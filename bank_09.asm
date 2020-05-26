.include "Constants.inc"
.include "variables.inc"
.include "macros.inc"
.feature force_range

.segment "BANK_09"

.export EnterEndingScene, EnterMiniGame, EnterBridgeScene_L 
.export lut_OrbCHR
.export LoadStatusBoxScrollWork
.export EnterMinimap
.export Bridge_LoadPalette

.import DrawComplexString_L, DrawBox_L, UpdateJoy_L, DrawPalette_L
.import WaitForVBlank_L, lut_RNG
.import CallMusicPlay_L
.import CHRLoad
.import LongCall
.import DrawComplexString
.import MinimapDecompress
.import ClearOAM
.import CHRLoadToA

BANK_THIS = $09

;; JIGS - split from Bank 0D -- all the story and puzzle stuff is here now.

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  MiniGame -- Shuffle Puzzle  [$9DA0 :: 0x35DB0]
;;
;;    This takes the puzzle and randomly shuffles the pieces a bunch of
;;  times so that the puzzle is a bit different every time you do the minigame.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

MiniGame_ShufflePuzzle:
    LDX #$7F+1               ; X is our main loop counter, and will count
                             ;  the number of random moves we are to perform ($7F random moves)

  @MainLoop:
    DEX                 ; decrement main loop counter
    BNE :+              ; and once it's zero...
      RTS               ; ... exit

:   INC framecounter    ; otherwise, increment the frame counter
    LDY framecounter    ; and use it as a seed to get a random number from the RNG lut
    LDA lut_RNG, Y

    AND #$03               ; mask out the low bits so we have a random number between 0-3.
    TAY                    ;  this is the direction from which we're going to slide a piece into the empty slot
    LDA @lut_Direction, Y  ; use that direction to get the offset needed for the direction
    STA tmp                ; store that offset in tmp

      ; now we need to find the empty slot...
    LDY #$10
  @FindEmptyLoop:
      DEY
      LDA puzzle, Y        ; simply step through all 16 entries in the puzzle until we find the empty slot (0)
      BNE @FindEmptyLoop   ; and keep looping until we find it

    STY tmp+1            ; store empty slot index in tmp+1

    TYA                 ; put empty slot index in A, and add to it the
    CLC                 ;  directional offset (in tmp).  A is now the index
    ADC tmp             ;  of the tile we want to move into the empty slot

    BMI @MainLoop       ; ensure that index is valid (between 0-F).  If < 0
    CMP #$10            ;  or if >= $10, we're trying to move a tile that doesn't
    BCS @MainLoop       ;  exist (we crossed the top or bottom of the puzzle).  So don't do
                        ;  anything, and just exit

    LDY tmp             ; put the movement offset in Y to hold it for future checks
    STA tmp             ; put the index of the tile we want to move in tmp
                        ;  tmp and tmp+1 are now the indeces in the puzzle we want to swap to complete the movement

    CPY #1              ; check the movement offset to see if we were sliding left (from right)
    BNE @CheckRight     ; if not... skip ahead

      AND #$03          ; otherwise, we're trying to move left.  Check the low 2 bits of the index of the tile
      BEQ @MainLoop     ;  we're moving to see what column we're in.  If the column=0, we can't move it left!  So jump back to loop
      BNE @LegalMove    ;  otherwise (column nonzero), moving left is legal  (always branches)

  @CheckRight:
    CPY #-1             ; see if we're trying to slide right (from the left)
    BNE @LegalMove      ;  if not, move is legal, so jump ahead to do it

      AND #$03          ; otherwise check the column
      CMP #$03          ;  if the column=3 (right-side) we can't move any more right
      BEQ @MainLoop     ;  ... so continue loop

  @LegalMove:           ; if we get here, the move is legal!  Perform it!
    LDY tmp
    LDA puzzle, Y       ; copy the tile from the slot we're moving...
    LDY tmp+1
    STA puzzle, Y       ;  ... to the empty slot

    LDY tmp
    LDA #0
    STA puzzle, Y       ; then make the slot we moved empty

    JMP @MainLoop       ; and continue looping

  @lut_Direction:
    .BYTE 1, -1, 4, -4



 ; unused
;  .BYTE 3,3,3,3,3,3,3

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Minigame Puzzle piece CHR  [$9E00 : 0x35E10]
;;
;;    Must be on page boundary

  .ALIGN  $100
lut_MinigameCHR:
  .INCBIN "chr/puzzle_1bpp.chr"
  
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  DrawFancyTheEndGraphic  [$A000 :: 0x36010]
;;
;;  data for the "The End" graphic.  See 'DrawFancyTheEndGraphic' below for details.
data_TheEndDrawData:
  .INCBIN "bin/ending_drawdata.bin"


  
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  DrawFancyTheEndGraphic  [$A400 :: 0x36410]
;;
;;    Pattern tables at $0800-$0EFF are cleared.  Tiles $80-$E3 are then drawn in a 10x10 box
;;  inside the 'story box' on the NT.
;;
;;    The "The End" graphic is then progressively drawn (one pixel per frame) to the pattern tables.
;;  The graphic is actually a 1-bit image... as only the low bitplane is set... the high bitplane
;;  is always zero.
;;
;;    The graphic is drawn in 2 phases:
;;
;;  PHASE ONE:
;;
;;    It draws the outline.  It does this by keeping track of a pixel position, and every frame, moving that
;;  position in a given direction on the x and/or y axis, "setting" or drawing a pixel each time it moves.
;;  The direction it moves is determined by the above 'data_TheEndDrawData' table.
;;
;;    Each byte in that table is one pixel of movement.  This routine will follow that movement by reading bytes
;;  and moving appropriately until it reaches a '00' termination byte, at which point drawing will be complete.
;;
;;    Each of the low 4 bits of the source byte tell it to move in a direction:
;;          bit 0 ($01) = move right
;;          bit 1 ($02) = move down
;;          bit 2 ($04) = move left
;;          bit 3 ($08) = move up
;;
;;    Any combination of bits may be present, allowing it to move in 8 directions.  In the case of opposing bits
;;  (Left+Right, for example), Left/Up take priority over Right/Down.  Therefore values of $01 and $05 will
;;  both move left.
;;
;;  PHASE TWO:
;;
;;    Once the outline has been traced and drawn, it will trace it AGAIN -- this time performing a sort of
;;  'flood fill'.  Values of $02, $03, or $07 (most downward movement) will result in a straight line being
;;  drawn to the left until it "hits a wall".
;;
;;    Since flood fill occurs on downward movement, this means the "The End" graphic must be drawn more-or-less
;;  in a clockwise fashion, or else the fill will occur on the outside of the graphic, rather than the inside.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

DrawFancyTheEndGraphic:
            @ppuaddr        = $61
    LDA #$00
    STA soft2000
    
    
    ; Clear CHR at $0800 to $0EFF  (tiles $80-EF)
    ;   clearing $80 bytes per frame (1 loop iteration = 1 frame)
    STA @ppuaddr            ;
    LDA #>$0800
    STA @ppuaddr+1          ; set @ppu addr to $0800
    
  @ClearCHRLoop:
        JSR WaitForVBlank_L     ; wait for VBlank
        
        LDA @ppuaddr+1          ; set ppu addr
        STA $2006
        LDA @ppuaddr
        STA $2006
        
        LDX #$80                ; clear $80 bytes
        LDA #$00
        : STA $2007
          DEX
          BNE :-

        LDA #$00                ; reset PPU addr (unnecessary, as we reset the scroll in a bit)
        STA $2006
        STA $2006
        
        JSR TheEnd_EndVblank    ; reset scroll, play music
        
        LDA @ppuaddr            ; Add $80 to low byte
        CLC
        ADC #$80
        STA @ppuaddr
        BNE @ClearCHRLoop       ; if carry...
        
        INC @ppuaddr+1          ; ...inc high byte
        LDA @ppuaddr+1
        CMP #$0F
        BCC @ClearCHRLoop       ; keep looping until high byte reaches $10
    
    
    
    ; Fill the story box (at $20A8) with unique tiles starting at $80
    ;   (that we just cleared).  That way to animate the "The End" graphic,
    ;   we just have to draw to CHR.
    ;
    ; This time, we draw one row of tiles each frame.
    ;   10 rows of tiles, each row has 10 tiles
    
                @drawtile       = $63
                @loopctr        = $64
    
    LDA #<$20A8
    STA @ppuaddr
    LDA #>$20A8
    STA @ppuaddr+1
    
    LDA #$80
    STA @drawtile
    LDA #10
    STA @loopctr
    
  @FillNTLoop:
        JSR WaitForVBlank_L         ; vblank

        LDA @ppuaddr+1              ; ppu addr
        STA $2006
        LDA @ppuaddr
        STA $2006
        
        LDX #10
        : LDA @drawtile             ; draw 10 tiles
          STA $2007
          INC @drawtile             ; (incrementing the tile each time so they're all unique)
          DEX
          BNE :-
          
        LDA #$00                    ; unneccesary ppu addr reset
        STA $2006
        STA $2006
        
        JSR TheEnd_EndVblank        ; scroll reset + music
        
        LDA @ppuaddr                ; move ppu addr down 1 row
        CLC
        ADC #$20
        STA @ppuaddr
        LDA @ppuaddr+1
        ADC #0
        STA @ppuaddr+1
        
        DEC @loopctr                ; loop 
        BNE @FillNTLoop
    
    ; Loop to change the attributes used to make the graphic use
    ;  palette 0.
    ;
    ; Since there are only $13 bytes of attribute data, this can all
    ;  be done in 1 frame
    
    JSR WaitForVBlank_L
    
    LDA #>$23CA                 ; attributes written to $23CA
    STA $2006
    LDA #<$23CA
    STA $2006
    
    LDX #$00
    : LDA lut_TheEnd_AttrTable, X
      STA $2007
      INX
      CPX #$13                  ; $13 bytes of data
      BCC :-
      
    JSR TheEnd_EndVblank
    
    
    ; Update the palette
    ;   This can be done in 1 frame
    LDA #$30
    STA cur_pal+1               ; white
    LDA #$16
    STA cur_pal+2               ; red (not used?)
    
    JSR WaitForVBlank_L
    JSR DrawPalette_L
    JSR TheEnd_EndVblank
    
    ;
    ;  Clear all the RAM in the draw buffer
    ;
    LDX #$00
    LDA #$00
    : STA theend_drawbuf       , X
      STA theend_drawbuf + $100, X
      STA theend_drawbuf + $200, X
      STA theend_drawbuf + $300, X
      STA theend_drawbuf + $400, X
      STA theend_drawbuf + $500, X
      STA theend_drawbuf + $600, X
      INX
      BNE :-
      
    JSR WaitForVBlank_L         ; since that loop took a bit of time -- do a frame just to keep
    JSR TheEnd_EndVblank        ;   the music going without interruption.
    
    
    ;
    ;  This is the start of the actual drawing
    ;
    
    LDA #$0C                    ; start drawing from position $C,$0
    STA theend_x
    LDA #$00
    STA theend_y
    
    LDA #<data_TheEndDrawData   ; init source pointer
    STA theend_src
    LDA #>data_TheEndDrawData
    STA theend_src+1
    
    ; Loop to draw the actual "The End" graphic
    :   LDY #$00
        LDA (theend_src), Y         ; Grab a source byte
        BEQ @StartFill              ; if zero, it's the terminator.  Exit to the @StartFill code
        
        JSR TheEnd_MoveAndSet       ; otherwise, use it to move and set pixel
        
        LDA theend_src              ; inc the source pointer
        CLC
        ADC #$01
        STA theend_src
        LDA theend_src+1
        ADC #$00
        STA theend_src+1
        
        JMP :-                      ; and keep looping until we find the terminator
        
@StartFill:
    ; The "Fill" effect works by re-traversing the outline of the graphic, and on certain
    ;  movements, doing a "fill" by setting all pixels to the left of it, until it finds another
    ;  set pixel
    
    ; Reset starting position
    LDA #$0C
    STA theend_x
    LDA #$00
    STA theend_y
    
    ; And source pointer
    LDA #<data_TheEndDrawData
    STA theend_src
    LDA #>data_TheEndDrawData
    STA theend_src+1
    
    ; The outer fill loop to trace the outline
  @FillLoop_Trace:
    LDY #$00
    LDA (theend_src), Y     ; get a source byte
    BNE :+                  ; if we hit the null...
      RTS                   ; ... we're done!  Exit!  This will actually RTS out of the entire "The End" routine.
    
    ; Otherwise... check the value to see if we should fill or not (see 'DrawFancyTheEndGraphic' above for details)
  : CMP #$02
    BEQ @DoFill         ; fill on values 2, 3, 7
    CMP #$03
    BEQ @DoFill
    CMP #$07
    BEQ @DoFill
    
    ;  For other values, just must the trace position and do nothing
    JSR TheEnd_MovePos      ; move position
                            ; flow into next iteration
  @FillLoop_Next:
    LDA theend_src      ; inc source pointer
    CLC
    ADC #$01
    STA theend_src
    LDA theend_src+1
    ADC #$00
    STA theend_src+1
    
    JMP @FillLoop_Trace ; loop until we hit the null
 
 
    ; Here, we actually want to start filling
  @DoFill:
                @filly      = $65       ; Y coord for filling
                @fillx      = $64       ; X coord for filling
                @fillppu    = $3E       ; ppu addr for filling
                @fillram    = $66       ; ram addr for filling
                
    LDX theend_y        ; backup this position
    STX @filly
    LDX theend_x
    STX @fillx
    
    JSR TheEnd_MovePos  ; move actual position
    
    LDX @filly                  ; check Y coord against gradient lut to see if
    LDA @lut_FillGradient, X    ;  we should fill on this row
    BEQ @FillLoop_Next          ; If zero, don't fill.  Skip.
    
    ;
    ;  This inner Fill loop will move left 1 pixel from the 'fill' position
    ;  and set it until we reach either the left-edge of the overall image
    ;  or until we come across another pixel that is set  (sort of like
    ;  a 1-directional flood fill)
    ;
@FillInnerLoop:
    LDA @fillx                  ; Move Left 1 pixel
    SEC
    SBC #$01
    BMI @FillLoop_Next          ; Abort if we've moved off the left edge!
    STA @fillx

    ;  Set PPU/RAM buffer pointers to access the current fill position pixel
    LDX @fillx
    LDY @filly
    LDA lut_TheEndPixelPosition_X, X
    CLC
    ADC lut_TheEndPixelPosition_Ylo, Y
    STA @fillppu
    STA @fillram
    LDA lut_TheEndPixelPosition_Yhi, Y
    ADC #$00
    STA @fillppu+1
    CLC
    ADC #$60
    STA @fillram+1
    
    ; Get the mask for this pixel
    TXA
    AND #$07
    TAX
    LDA lut_TheEndPixelMasks, X
    
    LDY #$00
    AND (@fillram), Y           ; check to see if the pixel is already set
    BNE @FillLoop_Next          ; if it was, we're done filling, as we've hit the "left wall"
    
    ; Otherwise... we want to draw this pixel to fill!
    JSR WaitForVBlank_L             ; have to draw in VBlank
    
    LDA lut_TheEndPixelMasks, X     ; get pixel mask again
    ORA (@fillram), Y               ; update RAM
    STA (@fillram), Y
    
    LDX @fillppu+1                  ; set pixel in PPU
    STX $2006
    LDX @fillppu
    STX $2006
    STA $2007
    
    JSR TheEnd_EndVblank            ; end VBlank (set scroll, update music)
    JMP @FillInnerLoop              ; keep looping until fill for this row is complete
    
    RTS         ; <- never reached
    
    
    ;
    ;  Not all rows are filled.  The game uses this LUT to selectively disable filling
    ;  for certain rows, producing a gradient effect.  There are $50 bytes in this lut,
    ;  one for each row.  If that byte is 1, filling is allowed.  If 0, no filling allowed.
    ;
  @lut_FillGradient:
  .BYTE 0, 0, 1, 0,  1, 0, 1, 0,     1, 0, 0, 1,  0, 0, 1, 0
  .BYTE 0, 1, 0, 1,  0, 1, 1, 1,     1, 1, 1, 1,  1, 1, 1, 1
  .BYTE 1, 1, 1, 1,  1, 1, 1, 1,     1, 1, 1, 1,  1, 1, 1, 1
  .BYTE 1, 1, 1, 1,  1, 1, 1, 1,     1, 1, 1, 1,  1, 1, 1, 1
  .BYTE 1, 1, 0, 1,  0, 1, 0, 1,     0, 1, 0, 1,  0, 1, 0, 1


  
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  TheEnd_MoveAndSet  [$A5E4 :: 0x365F4]
;;
;;  input:   A = source byte, indicating how to move
;;
;;  Moves the position, then sets the pixel.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

TheEnd_MoveAndSet:
    JSR TheEnd_MovePos          ; self explanitory
    JSR WaitForVBlank_L
    
    LDX theend_x
    LDY theend_y
    JSR TheEnd_SetPixel
   ; JMP TheEnd_EndVblank
    
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  TheEnd_EndVblank  [$A5F4 :: 0x36604]
;;
;;    Resets the scroll, resumes music
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

TheEnd_EndVblank:
    LDA soft2000
    STA $2000
    LDA #$00
    STA $2005
    STA $2005
    JMP CallMusicPlay_L

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  TheEnd_MovePos  [$A604 :: 0x36614]
;;
;;  input:  A = source byte to indicate how to move.  See 'DrawFancyTheEndGraphic' for details
;;
;;  in/out:  theend_x and theend_y
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

TheEnd_MovePos:
    STA tmp             ; back up the value
    
    AND #$05            ; see if Left/Right bits are set
    BEQ @CheckVert      ; if neither set, jump ahead to check up/down
    
      AND #$04              ; Check to see if the 'Right' bit is set
      BNE @Left             ; if yes, go to @Right, otherwise go @Left
      
    @Right:
        LDA theend_x        ; increment X position  (why doesn't he use INC?)
        CLC
        ADC #$01
        STA theend_x
        JMP @CheckVert
    
    @Left:
        LDA theend_x        ; move left (why doesn't he DEC?)
        SEC
        SBC #$01
        STA theend_x
    
    ; All values meet up here:
  @CheckVert:
    LDA tmp             ; restore backed up value
    
    AND #$0A            ; see if either Up/Down bits are set
    BEQ @Done           ; if not, exit
    
      AND #$08              ; otherwise, check to see if 'Up' bit is set
      BNE @Up
    
    @Down:
        LDA theend_y
        CLC
        ADC #$01
        STA theend_y
        RTS
    @Up:
        LDA theend_y
        SEC
        SBC #$01
        STA theend_y
    
  @Done:
    RTS

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  lut_TheEnd_AttrTable  [$A639 :: 0x36649]
;;
;;    These bytes are copied to the attribute table at $23CA
;;  The "The End" graphic is only 10x10 tiles, so only the 3x3
;;  block of attributes in the middle is interesting.  The rest
;;  is just there to make writing easier (it's a duplicate of what is
;;  already on the attribute table

lut_TheEnd_AttrTable:
  .BYTE             $0F, $0F, $CF,   $77, $55, $55
  .BYTE $55, $FF,   $00, $00, $CC,   $77, $55, $55
  .BYTE $55, $FF,   $F0, $F0, $FC
  ;                 ^ Interesting ^
  
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  TheEnd_SetPixel  [$A64C :: 0x3665C]
;;
;;  input:  X, Y = the X and Y pixel coord to set
;;
;;  Must be called during VBlank!
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

TheEnd_SetPixel:
                @bufaddr  = $66     ; local - points to pos in RAM
                @ppuaddr  = $3E     ; local - points to pos in PPU

    ; prep local pointers based on given X,Y position
    LDA lut_TheEndPixelPosition_X, X
    CLC
    ADC lut_TheEndPixelPosition_Ylo, Y
    STA @ppuaddr
    STA @bufaddr
    LDA lut_TheEndPixelPosition_Yhi, Y
    ADC #$00
    STA @ppuaddr+1
    CLC
    ADC #$60
    STA @bufaddr+1
    
    ; Then get the mask to the appropriate pixel
    TXA
    AND #$07
    TAX
    LDA lut_TheEndPixelMasks, X
    
    ; Draw this pixel to our RAM buffer
    LDY #$00
    ORA (@bufaddr), Y
    STA (@bufaddr), Y
    
    ; Draw it to the actual PPU
    LDX $2002
    
    LDX @ppuaddr+1
    STX $2006
    LDX @ppuaddr
    STX $2006
    STA $2007
    
    RTS
    
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Luts for 'The End' pixel coords conversion [$A681 :: 0x36691]
;;
;;    These luts let you get a ppu address from a X,Y position in pixels.
;;  0,0 is at PPU addr $0800 (beginning of drawable area for 'The End' graphic
;;
;;    The final 'lut_TheEndPixelMasks' table is 8 bytes, and gets the bitmask
;;  to the appropriate pixel

lut_TheEndPixelPosition_Ylo:                                    ; $A681
lut_TheEndPixelPosition_Yhi = lut_TheEndPixelPosition_Ylo + $50 ; $A6D1
lut_TheEndPixelPosition_X   = lut_TheEndPixelPosition_Yhi + $50 ; $A721
lut_TheEndPixelMasks        = lut_TheEndPixelPosition_X   + $50 ; $A771

  .INCBIN "bin/ending_LUTs.bin"

  
; $A779 -- unused
;  .BYTE $1F, $3F, $7F, $7F, $7C, $78, $78
;; JIGS - ^ 


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  MiniGame - Slide Vertically  [$A780 :: 0x36790]
;;
;;     Slides the puzzle pieces vertically in the puzzle -- updating the puzzle and
;;  animating the onscreen sprites so they appear to gradually slide into their new position.
;;  Only works for vertical movement -- for horizontal movement, MiniGame_HorzSlide is called
;;  instead.
;;
;;  IN:  tmp   = position of cursor
;;       tmp+1 = position of empty slot
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

MiniGame_VertSlide:
    LDA tmp           ; compare cursor to empty slot's position
    CMP tmp+1         ;  if cursor < empty slot
    BCC @Down         ;  ... then we will be sliding downward
                      ;  otherwise we're slide upward

  @Up:
    SBC tmp+1         ; subtract the empty slot's position from cursor position
    LSR A             ;  and right shift by 2 (gets the row difference)
    LSR A
    STA tmp+2         ; tmp+2 is now the number of rows we need to move upward (1-3)

    ; slide the puzzle pieces into their new slots

    LDX tmp+1         ; put the empty slot in X
  @Up_SlideLoop:
      LDA puzzle+4, X   ; get the piece from 1 row below, and move it into the empty slot
      STA puzzle, X     ; puzzle+4+X is now the new empty slot
      INX               ; increment X by 4 (1 row)
      INX
      INX
      INX
      CPX tmp           ; and repeat until we get to the cursor's slot
      BCC @Up_SlideLoop
    LDA #0
    STA puzzle, X       ; then replace the cursor's slot with 0 (make it the empty slot)

    LDA #3
    STA mg_slidedir     ; set the slide direction to 3 (sliding upwards)

    LDA tmp                  ; A = cursor
    LDX tmp+2                ; X = number of tiles that require sliding
  @Up_SpriteLoop:
      STA mg_slidespr-1, X   ; fill the slide sprite buffer with the slots which we need
      SEC                    ;  to slide.  -1 here because X is actually +1 than it should be for indexing
      SBC #4                 ; subtract 4 to record the next row upward
      DEX                    ; and loop until all rows have been recorded
      BNE @Up_SpriteLoop

    JMP MiniGame_AnimateSlide   ; then do the animation, and exit


  @Down:                ; sliding down is the same as sliding up
    LDA tmp+1           ; get empty slot position
    SEC
    SBC tmp             ; subtract cursor position
    LSR A               ; and divide by 4
    LSR A               ;  this results in the number of rows we need to move downward (1-3)
    STA tmp+2           ; store this in tmp+2

    LDX tmp+1           ; put empty slot in X
  @Down_SlideLoop:
      LDA puzzle-4, X     ; get the puzzle piece from 1 row above this row
      STA puzzle, X       ;  and copy it to this row
      DEX                 ; then decrement X by 4 (move 1 row up)
      DEX                 ;   this moves all the tiles in this column down 1 row
      DEX
      DEX
      CPX tmp             ; repeat until we get to the cursor's slot
      BNE @Down_SlideLoop
    LDA #0
    STA puzzle, X         ; then replace the cursor's slot with 0 (make it the empty slot)

    LDA #2
    STA mg_slidedir       ; set slide direction to 2 (downwards)

    LDA tmp               ; A = cursor
    LDX tmp+2             ; X = number of tiles that require sliding
  @Down_SpriteLoop:
      STA mg_slidespr-1, X   ; fill slide sprite buffer with slots that need to be moved
      CLC                    ;   so that MiniGame_AnimateSlide will move them
      ADC #4                 ; add 4 to move to the next row down
      DEX
      BNE @Down_SpriteLoop   ; and loop until all rows have been recorded

    JMP MiniGame_AnimateSlide   ; then animate them and exit

; Unused space (almost looks like it might be attributes)

;  .BYTE $00, $00, $00, $1E
;  .BYTE $1E, $3E, $FE, $FE
;  .BYTE $FC, $F8, $00, $00
;  .BYTE $00, $00, $00, $00
;  .BYTE $00, $00, $00, $00
;  .BYTE $00, $00, $00, $00
;  .BYTE $00, $00, $00

;; JIGS ^   
  
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Story Text   [$A800 :: 0x36810]
;;
;;    Pointer table followed by text data for the story text.  Story
;;  text is used for Bridge and Ending scenes and is displayed one 'page'
;;  at a time.  Each string in this text cooresponds to one page.

lut_StoryText:
.WORD SLIDE1 
.WORD SLIDE2
.WORD SLIDE3
.WORD SLIDE4
.WORD ENDSLIDE1
.WORD ENDSLIDE2
.WORD ENDSLIDE3
.WORD ENDSLIDE4
.WORD ENDSLIDE5
.WORD ENDSLIDE6
.WORD ENDSLIDE7
.WORD ENDSLIDE8
.WORD ENDSLIDE9
.WORD ENDSLIDE10
.WORD ENDSLIDE11
.WORD ENDSLIDE12
.WORD ENDSLIDE13
.WORD ENDSLIDE14
.WORD ENDSLIDE15
.WORD ENDSLIDE16
.WORD ENDSLIDE17
.WORD ENDSLIDE18
.WORD ENDSLIDE19
.WORD ENDSLIDE20
.WORD ENDSLIDE21

SLIDE1:
.byte $01,$8A,$3B,$24,$B2,$BF,$1B,$1D,$AC,$B5,$05,$AD,$B2,$55
.byte $5A,$BC,$31,$A8,$AA,$1F,$B6,$69,$00
SLIDE2:
.BYTE $A0,$AB,$39,$20,$5D,$5B,$B6
.byte $1B,$1D,$05,$8F,$B2,$55,$BF,$1B,$1D,$4B,$A7,$B2,$05,$B1,$B2,$21
.byte $AE,$B1,$46,$C0,$00
SLIDE3:
.BYTE $8E,$A4,$A6,$AB,$59,$B2,$AF,$A7,$1F,$AA,$20
.byte $B1,$05,$98,$9B,$8B,$BF,$1B,$41,$21,$82,$80,$80,$80,$05,$BC,$A8
.byte $2F,$1E,$A4,$AA,$B2,$24,$AB,$1F,$40,$05,$BA,$AC,$1C,$31,$2B,$B8
.byte $B7,$BC,$43,$B5,$49,$05,$BA,$AC,$1C,$1F,$C0,$FF,$8B,$B8,$21,$B1
.byte $46,$BF,$05,$B2,$B1,$AF,$4B,$A7,$2F,$AE,$B1,$2C,$B6,$C0,$00
SLIDE4:
.BYTE $8C
.byte $B2,$34,$C4,$C4,$05,$9C,$B7,$2F,$21,$BC,$26,$B5,$05,$AD,$B2,$55
.byte $5A,$BC,$C4,$05,$9B,$A8,$B7,$55,$B1,$1B,$AB,$1A,$68,$AA,$AB,$B7
.byte $05,$B2,$A9,$4F,$2B,$A6,$1A,$28,$FF,$26,$B5,$05,$BA,$B2,$B5,$AF
.byte $A7,$C0,$00

ENDSLIDE1:
.BYTE $9D,$AB,$1A,$9D,$AC,$34,$C2,$95,$B2,$B2,$B3,$05,$AC
.byte $B6,$FF,$B1,$46,$31,$4D,$AE,$3A,$C4,$05,$9D,$AB,$1A,$82,$80,$80
.byte $80,$50,$2B,$B5,$05,$AF,$B2,$2A,$31,$39,$B7,$AF,$1A,$30,$05,$B2
.byte $B9,$25,$C0,$FF,$99,$2B,$48,$05,$B3,$B5,$A8,$B9,$A4,$61,$B6,$C0
.byte $00

ENDSLIDE2:
.BYTE $8C,$B2,$B1,$B7,$4D,$AF,$36,$A9,$1B,$1D,$05,$A9,$B2,$B8,$44
.byte $A8,$45,$34,$B1,$B7,$B6,$BF,$05,$B7,$AB,$1A,$8E,$2F,$B7,$AB,$BF
.byte $1B,$1D,$05,$A0,$AC,$3B,$BF,$1B,$AB,$1A,$8F,$AC,$23,$BF,$05,$A4
.byte $B1,$A7,$1B,$AB,$1A,$A0,$39,$25,$BF,$05,$A4,$AA,$A4,$1F,$31,$A8
.byte $AF,$B2,$2A,$B6,$05,$B7,$B2,$1B,$AB,$1A,$2B,$B5,$1C,$C0,$00

ENDSLIDE3:
.BYTE $90
.byte $A4,$B5,$AF,$22,$A7,$BE,$1E,$AB,$39,$23,$A7,$05,$A5,$B8,$B5,$5A
.byte $27,$A9,$35,$FF,$82,$80,$80,$80,$05,$BC,$A8,$2F,$B6,$C0,$FF,$9D
.byte $AB,$39,$05,$AB,$A4,$B7,$23,$27,$AF,$40,$1B,$1D,$05,$8F,$B2,$B8
.byte $44,$99,$46,$25,$B6,$1B,$B2,$05,$B7,$AB,$AC,$1E,$BA,$35,$AF,$A7
.byte $C0,$00

ENDSLIDE4:
.BYTE $8C,$91,$8A,$98,$9C,$33,$3F,$05,$A6,$B5,$2B,$53,$27,$A9
.byte $B5,$49,$05,$B7,$AB,$B2,$B6,$1A,$8F,$26,$B5,$C0,$00

ENDSLIDE5:
.BYTE $8E,$B9,$AC
.byte $58,$A7,$49,$1F,$39,$40,$05,$B7,$AB,$1A,$BA,$35,$AF,$A7,$20,$3B
.byte $05,$A6,$B2,$32,$23,$27,$AC,$21,$1F,$05,$A7,$A4,$B5,$AE,$B1,$2C
.byte $B6,$C0,$00

ENDSLIDE6:
.byte $8B,$B8,$B7,$BF,$2D,$21,$AC,$1E,$B2,$B9,$25,$05,$B1
.byte $B2,$BA,$BF,$33,$4D,$2A,$59,$3F,$05,$A5,$A8,$3A,$24,$A8,$21,$5C
.byte $AA,$AB,$B7,$C4,$C4,$00

ENDSLIDE7:
.byte $9D,$AB,$1A,$95,$92,$90,$91,$9D,$05,$A0
.byte $8A,$9B,$9B,$92,$98,$9B,$9C,$20,$23,$05,$B5,$A8,$B7,$55,$B1,$1F
.byte $AA,$69,$05,$8A,$B6,$1B,$1D,$BC,$1B,$B5,$A4,$32,$AF,$05,$AC,$B1
.byte $1B,$AC,$34,$BF,$1B,$1D,$05,$BA,$B2,$B5,$AF,$27,$23,$B7,$55,$B1
.byte $B6,$05,$B7,$B2,$FF,$B1,$35,$B0,$5F,$C0,$00

ENDSLIDE8:
.byte $9C,$A4,$B5,$A4,$20
.byte $B1,$27,$93,$22,$A8,$05,$BA,$A4,$AC,$21,$A9,$35,$1B,$1D,$B0,$69
.byte $05,$98,$A9,$38,$26,$B5,$3E,$BF,$05,$90,$A4,$B5,$AF,$22,$27,$A7
.byte $B2,$2C,$05,$B7,$B2,$B2,$C0,$00

ENDSLIDE9:
.byte $01,$05,$8B,$B8,$B7,$BF,$33,$1D
.byte $29,$A7,$AC,$27,$5B,$05,$A8,$B9,$25,$FF,$41,$B3,$B3,$3A,$C5,$69
.byte $00

ENDSLIDE10:
.byte $8E,$B9,$25,$BC,$1C,$1F,$AA,$33,$3A,$B7,$05,$B0,$A4,$27,$1F
.byte $20,$67,$A4,$BC,$C0,$05,$9D,$AB,$1A,$23,$3F,$B2,$29,$68,$2C,$05
.byte $AC,$B1,$1B,$AB,$1A,$82,$80,$80,$80,$50,$2B,$B5,$05,$9D,$AC,$34
.byte $C2,$95,$B2,$B2,$B3,$C0,$00

ENDSLIDE11:
.byte $9D,$AB,$1A,$8F,$26,$B5,$38,$AB,$B2
.byte $3E,$05,$B7,$B2,$31,$A8,$A6,$49,$1A,$3C,$A8,$05,$A9,$B2,$B5,$48
.byte $BF,$20,$B1,$27,$A9,$AC,$AA,$AB,$B7,$05,$A4,$AA,$A4,$1F,$37,$1B
.byte $AB,$1A,$A9,$26,$B5,$05,$A8,$B9,$61,$43,$35,$A6,$2C,$1B,$AB,$39
.byte $05,$B6,$A8,$21,$A7,$2F,$AE,$B1,$2C,$B6,$05,$B8,$B3,$3C,$1B,$AB
.byte $1A,$BA,$35,$AF,$A7,$C0,$00

ENDSLIDE12:
.byte $A0,$AB,$3A,$1B,$AB,$1A,$8F,$26,$B5
.byte $05,$B5,$A8,$B7,$55,$B1,$BF,$2D,$21,$BA,$AC,$4E,$05,$A5,$A8,$1B
.byte $2E,$1C,$A8,$AC,$B5,$05,$B3,$A4,$37,$C0,$FF,$8A,$4E,$05,$B6,$AC
.byte $AA,$B1,$1E,$4C,$1B,$1D,$05,$A5,$A4,$B7,$B7,$AF,$1A,$BA,$AC,$1C
.byte $1B,$1D,$05,$8F,$B2,$B5,$48,$1E,$BA,$AC,$4E,$31,$A8,$05,$A8,$B5
.byte $A4,$3E,$A7,$C0,$00

ENDSLIDE13:
.byte $8B,$B8,$B7,$1B,$AB,$1A,$45,$AA,$3A,$A7,$05
.byte $BA,$AC,$4E,$65,$AC,$B9,$1A,$3C,$C0,$05,$99,$A4,$B6,$3E,$27,$A7
.byte $46,$29,$A5,$BC,$05,$B7,$AB,$1A,$8D,$BA,$2F,$B9,$2C,$BF,$1B,$1D
.byte $05,$8E,$AF,$B9,$2C,$BF,$20,$3B,$1B,$1D,$05,$8D,$B5,$A4,$AA,$3C
.byte $B6,$69,$00

ENDSLIDE14:
.byte $99,$A4,$B6,$3E,$27,$B2,$29,$A5,$BC,$05,$B3,$A8,$B2
.byte $B3,$45,$1E,$B8,$B1,$B6,$B8,$23,$05,$BA,$AB,$25,$1A,$1C,$1A,$B6
.byte $28,$B5,$BC,$05,$A6,$A4,$B0,$1A,$A9,$B5,$49,$C0,$00

ENDSLIDE15:
.byte $01,$9D,$1D
.byte $05,$95,$92,$90,$91,$9D,$FF,$A0,$8A,$9B,$9B,$92,$98,$9B,$9C,$05
.byte $B5,$A8,$B7,$55,$29,$A9,$B5,$49,$05,$B7,$AB,$A8,$AC,$44,$AD,$26
.byte $B5,$5A,$BC,$05,$A5,$A4,$A6,$AE,$FF,$1F,$1B,$AC,$34,$05,$82,$80
.byte $80,$80,$50,$2B,$63,$C0,$00

ENDSLIDE16:
.byte $9D,$AB,$1A,$34,$B0,$35,$AC,$2C,$05
.byte $B6,$B7,$B2,$23,$27,$A7,$A8,$A8,$B3,$FF,$1F,$05,$B7,$AB,$A8,$AC
.byte $44,$AB,$2B,$B5,$B7,$B6,$05,$BA,$AC,$4E,$4F,$4D,$53,$A6,$B7,$1B
.byte $1D,$05,$BA,$B2,$B5,$AF,$A7,$C0,$00

ENDSLIDE17:
.byte $01,$97,$A8,$B9,$25,$43,$35
.byte $66,$B7,$05,$B7,$AB,$1A,$AA,$B2,$B2,$A7,$20,$3B,$05,$B7,$B5,$B8
.byte $A8,$69,$00

ENDSLIDE18:
.byte $01,$97,$A8,$B9,$25,$1B,$55,$B1,$1B,$1D,$05,$8F,$B2
.byte $B8,$44,$99,$46,$25,$B6,$1B,$B2,$05,$B7,$AB,$1A,$A7,$2F,$AE,$24
.byte $AC,$A7,$A8,$69,$00

ENDSLIDE19:
.byte $01,$8A,$3B,$1B,$B5,$B8,$1C,$33,$AC,$4E,$05
.byte $A4,$AF,$5D,$BC,$1E,$68,$B9,$1A,$1F,$05,$B7,$AB,$1A,$1D,$2F,$B7
.byte $1E,$4C,$05,$B7,$AB,$1A,$B3,$A8,$B2,$B3,$45,$C0,$00

ENDSLIDE20:
.byte $01,$9D,$AB
.byte $1A,$A0,$2F,$5C,$35,$33,$AB,$B2,$05,$A5,$B5,$B2,$AE,$1A,$1C,$1A
.byte $82,$80,$80,$80,$05,$BC,$A8,$2F,$FF,$9D,$AC,$34,$C2,$95,$B2,$B2
.byte $B3,$05,$AC,$B6,$1B,$B5,$B8,$AF,$BC,$20,$05,$95,$92,$90,$91,$9D
.byte $FF,$A0,$8A,$9B,$9B,$92,$98,$9B,$69,$05,$9D,$AB,$A4,$21,$BA,$2F
.byte $5C,$35,$33,$3F,$05,$A2,$98,$9E,$C4,$00

ENDSLIDE21:
.byte $01,$96,$A4,$BC,$1B,$AB
.byte $1A,$98,$9B,$8B,$9C,$05,$A4,$AF,$5D,$BC,$1E,$B6,$AB,$1F,$A8,$C4
.byte $C4,$69,$00

;; Junk left over.
;.byte $1B,$55,$B1,$1B,$1D,$05,$84,$FF,$B3,$46,$25,$B6,$1B
;.byte $2E,$1C,$A8,$05,$A7,$A4,$B5,$AE,$24,$AC,$A7,$A8,$C0,$00
;.byte $8A,$B1
;.byte $A7,$1B,$AB,$1A,$B7,$B5,$B8,$A8,$05,$A6,$B5,$BC,$37,$5F,$1E,$A4
;.byte $AF,$5D,$BC,$B6,$05,$AF,$AC,$B9,$1A,$BA,$AC,$1C,$1F,$05,$B3,$A8
;.byte $B2,$B3,$45,$BE,$1E,$1D,$2F,$B7,$B6,$C0,$00
;.byte $9D,$AB,$1A,$A0,$2F
;.byte $5C,$35,$1B,$AB,$39,$05,$A9,$B2,$B8,$AA,$AB,$21,$B3,$A4,$37,$05
;.byte $82,$80,$80,$80,$BC,$2B,$B5,$1E,$4C,$05,$B7,$AC,$B0,$1A,$5D,$1E
;.byte $BC,$26,$C4,$00
;.byte $01,$96,$A4,$BC,$20,$4E,$1B,$AB,$1F,$AA,$B6,$05
;.byte $FF,$A6,$26,$B1,$B7,$1F,$B8,$1A,$28,$05,$FF,$FF,$24,$AB,$1F,$A8
;.byte $69,$00
;.byte $69,$00,$C3,$00,$BC,$5A,$C0,$00,$01,$96,$A4,$BC,$FF,$A4
;.byte $AF,$51,$B7,$43,$B1,$3F,$05,$BF,$0A,$A6,$B2,$B8,$B1,$B7,$47,$B8
;.byte $37,$B7,$5C,$B6,$43,$57,$69,$00,$00,$00,$00,$00,$00,$00,$00,$00
;.byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
;.byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
;.byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Story "last page" numbers  [$AE00 :: 0x36E10]
;;
;;    These are the "last page" numbers for bridge and ending scene text.

lut_Bridge_LastPage:  .BYTE  $04  ; bridge scene uses story pages $00-$03
lut_Ending_LastPage:  .BYTE  $19  ; ending scene uses story pages $04-$18



 ;; ?unused -- fragmented code?
 ;;   looks like some detached music driver code.  Starts with
 ;;  LDA music_track
 ;;  BPL xxx
 ;;   but the branch goes to some garbage address.  Probably left over garbage
 ;;   from earlier assemblies.

;  .BYTE $A5, $4B, $10, $12
;  .BYTE $C9, $80, $D0, $0D
;  .BYTE $A9, $70, $8D, $00
;  .BYTE $40, $8D

;; JIGS ^ 

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Enter MiniGame  [$AE10 :: 0x36E20]
;;
;;  OUT:   C = set if minigame was completed successfully (puzzle solved)
;;             clear if not
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

EnterMiniGame:
    LDA #0
    STA menustall         ; disable stalling
    STA $2001             ; turn off PPU
    STA $4015             ; and APU

    LDA #$08              ; clear NT scroll
    STA soft2000

    LDA #BANK_THIS        ; set cur bank for music playback
    STA cur_bank

    LDA #$05              ; draw a smaller box ($08,$05   $0A,$0A)
    STA box_y             ;  inside the main box which is normally used for text
    LDA #$08              ;  this smaller box will hold the puzzle
    STA box_x
    LDA #$0A
    STA box_wd
    STA box_ht
    JSR DrawBox_L

    ;; here we start loading CHR for the minigame.  There are 16 sliding puzzle pieces in CHR
    ;;  one is blank (no number), and the others are numbered 1-15.  Each sliding puzzle piece
    ;;  is 2x2 tiles, and is stored 1bpp (not the normal 2bpp).  This means there are 16*2*2*8
    ;;  ($200) bytes of CHR for the puzzle pieces.  Because it's 1bpp, we can't use the normal
    ;;  CHR loader.  This routine has to load it manually.
    ;;
    ;; To expand these graphics to 2bpp, the first sliding puzzle graphic (the one that isn't
    ;;  numbered) is used as the HIGH bitplane for every graphic.  And the numbered graphics
    ;;  are used as the low bitplane for every graphic.
    ;;
    ;; (tmp) will be the pointer for the low bitplane.  It will progressively draw all the
    ;;    tiles
    ;; (tmp+2) will be the pointer for the high bitplane.  It will only draw the first four tiles
    ;;    (the 2x2 tiles that make up the unnumbered graphic).

    LDA #>lut_MinigameCHR
    STA tmp+1               ; load up high byte of source pointers
    STA tmp+3

    LDA $2002            ; reset PPU toggle

    LDA #$10             ; set PPU addr to $1000 (start of sprite pattern tables)
    STA $2006
    LDA #$00
    STA $2006

    STA tmp              ; set the low byte of the low bitplane pointer

  @CHRLoadLoop:
     LDY #0              ; Y will be our inner loop counter and index.  Zero it
     @LoBitplaneLoop:
       LDA (tmp), Y
       STA $2007              ; draw low bitplane data
       INY
       CPY #8                 ; loop until 8 bytes drawn (entire low bitplane)
       BCC @LoBitplaneLoop

     LDA tmp                ; get low byte of lo bitplane pointer
     AND #$1F               ; mask low bits
     STA tmp+2              ; and write as low byte of high bitplane pointer
                            ;  This keeps the high bitplane looking at the first 2x2 graphic, but
                            ;   moves it between the UL, UR, DL, and DR tiles

     LDY #0                   ; do allt he same stuff, but draw the high bitplane
     @HiBitplaneLoop:
       LDA (tmp+2), Y
       STA $2007
       INY
       CPY #8
       BCC @HiBitplaneLoop    ; loop until 8 bytes drawn

     LDA tmp                ; add 8 to low byte of lo bitplane pointer
     CLC
     ADC #8
     STA tmp
     BNE @CHRLoadLoop       ; if it didn't wrap... keep looping

     INC tmp+1              ; otherwise if it did wrap... inc the high byte of the pointer

     LDA tmp+1                        ; then check the pointer to see if we've drawn all the tiles yet
     CMP #>(lut_MinigameCHR + $200)   ;  we need to draw $400 bytes ($200 bytes of low-bitplane data)
     BCC @CHRLoadLoop                 ; Loop until we've drawn that much

   ;
   ;  now we load up the starting positions for all the puzzle pieces
   ;

    LDX #$0F
  @LoadPuzzleLoop:
      LDA lut_PuzzleStart, X   ; simply copy the positions from this LUT
      STA puzzle, X            ;  into our puzzle
      DEX
      BPL @LoadPuzzleLoop      ; and loop until all $10 bytes copied

    JSR MiniGame_ShufflePuzzle ; shuffle the puzzle pieces around to randomize it



    LDA #$42
    STA music_track            ; start music track number $42 (bridge scene music)
    STA dlgmusic_backup

   ;
   ; load the desired palette
   ;

 ;   LDX #$0F
 ; @LoadPalLoop:
 ;   LDA lut_BridgeBGPal, X ; copy $10 colors (full BG palette)
 ;   STA cur_pal, X         ;  from the Bridge scene palette LUT
 ;   DEX                    ; seems wasteful to do this here -- there's a routine
 ;   BPL @LoadPalLoop       ;   you can JSR to that does this (Bridge_LoadPalette)
 
    JSR Bridge_LoadPalette

    LDA #$30               ; and a few sprite palettes as well
    STA cur_pal+$13        ; the white for the backs of the puzzle pieces
    LDA #$15               ;  and the red for the numbers on the puzzle pieces
    STA cur_pal+$12

   ; 
   ; puzzle is now generated.  Here we do some final prepwork and turn the PPU
   ;   on... and begin the main loop
   ;

    JSR ClearOAM             ; clear OAM
    JSR WaitForVBlank_L      ; then once in VBlank...
    LDA #>oam
    STA $4014                ; do sprite DMA
    JSR DrawPalette_L        ; and load up the palette

    LDA soft2000             ; the load up soft2000 (resets NT scroll)
    STA $2000
    LDA #$1E
    STA $2001                ; turn on the PPU
    LDA #0                   ; and set the scroll to zero
    STA $2005
    STA $2005

    STA joy_a                ; lastly, zero out joypad data so we start with a clean slate
    STA joy_b
    STA joy_prevdir
    STA joy
    STA cursor               ; and start the cursor (selected slot) at zero.

    LDA puzzle               ; but check slot zero to make sure it's not the empty slot
    BNE MiniGameLoop
      INC cursor             ; if it is... start the cursor on slot 1 instead
                      ; no JMP or RTS -- code flows into MiniGameLoop

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Mini Game Loop  [$AECF :: 0x36EDF]
;;
;;     The main loop driving the mini game!  Probably doesn't need to be
;;  seperated from EnterMiniGame -- but oh well.
;;
;;  OUT:  C = set if puzzle solved
;;            clear if puzzle not solved
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

MiniGameLoop:
    INC framecounter              ; increment the frame counter to keep animations working
    JSR WaitForVBlank_L           ; wait for vblank
    LDA #>oam
    STA $4014                     ; do sprite DMA
    JSR CallMusicPlay_L               ; keep music playing
    JSR DrawAllPuzzlePieces       ; draw all the puzzle pieces
    JSR MiniGame_ProcessInput     ; and refresh and process input!

    LDA joy_b
    BNE @B_Pressed                ; check to see if A or B have been pressed
    LDA joy_a
    BNE @A_Pressed

    JSR MiniGame_CheckVictory     ; then check to see if the puzzle has been solved
    BCC MiniGameLoop              ; if not... keep looping until it is
    RTS                           ; if it's solved, exit (C set here to indicate success)

  @B_Pressed:
    CLC                ; if B pressed, CLC to indicate the puzzle went unsolved
    RTS                ; and exit

  @A_Pressed:
    LDA #0             ; Zero X (for upcoming loop)
    TAX

    STA joy_a          ; clear A button catcher
    STA framecounter   ; clear framecounter.  This will ensure that the puzzle piece selected by the cursor
                       ;   will be visible for the next sprite drawing.

    LDA #$80
    STA mg_slidespr    ; erase the slide sprite buffer by filling it with a negative value
    STA mg_slidespr+1
    STA mg_slidespr+2

    LDA cursor         ; copy the current cursor to tmp
    STA tmp            ;  seems pointless.... why not just use cursor directly?

  @FindEmptyLoop:       ; search the puzzle for the empty slot
    LDA puzzle, X
    BEQ @ExitEmptyLoop  ; once we find it, exit the loop with slot index in X
    INX
    BNE @FindEmptyLoop  ; otherwise keep looping until it's found (always branches)

  @ExitEmptyLoop:
    TXA
    STA tmp+1          ; write empty slot index to tmp+1 (why not STX?).  Now...
                       ;  tmp   = cursor
                       ;  tmp+1 = empty slot

    LDA tmp            ; get the cursor
    AND #$03           ; mask to get the column it's in
    STA tmp+2          ; store the column temporarily
    LDA tmp+1          ; then get the empty slot's column
    AND #$03
    CMP tmp+2          ; and compare to cursor's column
    BEQ @Vertical      ; if they match, we need to slide the puzzle vertically

    LDA tmp            ; otherwise do the same thing over again
    AND #$0C           ;  except get the row instead of the column, this time
    STA tmp+2
    LDA tmp+1          ; compare it to empty slot's row
    AND #$0C
    CMP tmp+2
    BEQ @Horizontal    ; if they match, slide horizontally

                       ; otherwise... movement where the cursor currently is
                       ; is illegal.  Play an ugly error sound effect
    LDA #%00111100     ; 12.5% duty (harsh), volume=C
    STA $4004
    LDA #%10001100     ; sweep upwards in pitch (period=0, shift=4)
    STA $4005
    LDA #$70
    STA $4006          ; F value = $070
    LDA #$00
    STA $4007

    LDA #$14
    STA sq2_sfx        ; mark sq2 as being sound effect for $14 frames

    JMP MiniGameLoop   ; then jump back to minigame loop

  @Vertical:                   ; if moving vertically...
    JSR DrawAllPuzzlePieces    ;   redraw all the puzzle pieces so that they're all visible
    JMP MiniGame_VertSlide     ;   (cursor's piece might be hidden, here -- this ensures it's visible).
                               ; Then perform a vertical slide

  @Horizontal:                 ; same thing if moving horizontally, but do the horizontal
    JSR DrawAllPuzzlePieces    ;  slide instead.
    JMP MiniGame_HorzSlide

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Mini Game -- Directional LUTs  [$AF53 :: 0x36F63]
;;
;;    Each of these luts is the X and Y offset to slide each sprite
;;  every frame given the desired direction.  Directions are range 0-3 where
;;  0=right, 1=left, 2=down, 3=up

lut_MGDirection_Y:   .BYTE  0, 0, 1,-1
lut_MGDirection_X:   .BYTE  1,-1, 0, 0


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Mini Game -- Check for Victory  [$AF5B :: 0x36F6B]
;;
;;    Checks to see if the minigame puzzle has been solved.
;;  If it has, it animates the palette of the puzzle pieces and waits
;;  for the user to press a button before exiting.
;;
;;  OUT:  C = set if puzzle has been solved
;;            clear if not solved yet
;;
;;    The puzzle actually has two solutions.. one where the empty slot is at the start of the
;;  puzzle (before the 1) and one where it's at the end of the puzzle (after the 15).  To check
;;  for either of these solutions, the game does not look for a specific value in each slot -- rather
;;  it looks at values relative to their previous slot.  It starts looking at slot index 1 (rather
;;  than slot index 0) and ensures that slot1 = 1+slot0.  Then it make sure slot2 = 1+slot1, and so on.
;;  It does NOT check the last slot, since if the last slot is the empty slot (0) it would fail -- but
;;  if every slot up to the last slot is correct... then the last slot must also be correct as well,
;;  so there's no reason to check it.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

MiniGame_CheckVictory:
    LDX #1              ; X is our loop counter / index
    LDA puzzle          ; A is the required value for success
  @CheckLoop:
      CLC
      ADC #1            ; increment success value by 1
      CMP puzzle, X     ;  see if this puzzle piece is +1 the piece before it
      BNE @Fail         ; if not, puzzle isn't solved
      INX               ; otherwise move onto next piece
      CPX #$0F          ; until all but last piece checked
      BCC @CheckLoop

  ; Code reaches here is puzzle has been solved.  Don't exit right away -- instead start cycling the
  ;  palette, and wait for the user to press a button

    LDA #$54
    STA music_track       ; play music track $54  (special item fanfare)

    LDA #$12
    STA cursor            ; set the cursor so some value off the puzzle so it doesn't mess with the drawing

    JSR DrawAllPuzzlePieces   ; then redraw all puzzle pieces

    LDA #0
    STA joy_a             ; clear A and B button catchers
    STA joy_b

  ; now loop -- cycling the palette and waiting for the user to press a button
  ; you may notice that while the cursor is moved in this loop (via MiniGame_ProcessInput), the sprites
  ; are never redrawn.  DMA occurs, but the oam buffer is never changed.

  @Loop:
    JSR WaitForVBlank_L     ; Wait for VBlank
    LDA #>oam
    STA $4014               ; do sprite DMA
    JSR DrawPalette_L       ; update the palette
    JSR CallMusicPlay_L         ; call the music play routine (Probably shouldn't be done until after scroll set -- but doesn't matter)

    LDA #0                  ; THEN set scroll.  Note that if the music routine takes too long, this could theoretically
    STA $2005               ; cause the screen to bork... however DrawPalette resets the scroll to zero anyway due to
    STA $2005               ;  it doing double writes of 0 to $2006.  If DrawPalette didn't do that, however, this could
                            ;  be a serious problem

    INC framecounter        ; increment the frame counter

    LDA framecounter        ; use the frame counter to cycle the palette
    ASL A                   ;  double it
    AND #$30                ;  and mask out these bits for the color.  This cycles between $00 (dark grey),
    STA cur_pal+$13         ;  $10 (md grey), $20, and $30 (both white).  Changing colors once every 8 frames.

    JSR MiniGame_ProcessInput  ; process input (to update joy_a and joy_b)

    LDA joy_a
    ORA joy_b
    BEQ @Loop               ; and keep looping until either A or B pressed

    SEC             ; once they have been pressed... SEC to indicate puzzle solved
    RTS             ; and exit

  @Fail:
    CLC             ; CLC to indicate puzzle not solved
    RTS



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Initial Puzzle Position  [$AFB8 :: 0x36FC8]
;;
;;    LUT contains the initial position for the puzzle pieces in the minigame.
;;  These pieces are further scrambled after loading

lut_PuzzleStart:
  .BYTE $F, $4, $C, $8, $1, $6, $D, $9, $0, $5, $B, $3, $7, $E, $2, $A


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Mini Game -- Process Input [$AFC8 :: 0x36FD8]
;;
;;     Updates joy data and moves around the cursor for the minigame
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

MiniGame_ProcessInput:
    JSR UpdateJoy_L      ; update joypad info

    LDA joy              ; get joy data
    AND #$0F             ; isolate directonal buttons
    CMP joy_prevdir      ; see if they match previously down buttons
    BEQ @Exit            ; if they do match... no change -- just exit

    STA joy_prevdir      ; otherwise, record the change
    CMP #0               ; and see if buttons are being pressed (as opposed to released)
    BEQ @Exit            ; if nothing being pressed -- just exit

    CMP #$04             ; see if they're pressing up or down.  If they are, jump ahead to 'vertical'
    BCS @Vertical

    LDX #1            ; X = our change.  Make a change of 1 if moving right
    CMP #$01          ; compare the buttons pressed to see if they are pressing Right
    BEQ @Move         ; if they are... move

    LDX #-1           ; otherwise, they're moving left... so make a change of -1 instead
    BNE @Move         ; (always branches)

  @Vertical:
    LDX #4            ; moving down = change of 4
    CMP #$04          ; see if they pressed Down
    BEQ @Move         ; if they did... move

    LDX #-4           ; otherwise, they're moving Up.  So change = -4

  @Move:
    TXA               ; put change in A
    CLC
    ADC cursor        ; and add to it our cursor
    AND #$0F          ; then mask to keep them inside the puzzle boundaries
    STA cursor        ; and record that as our new cursor

    TAY
    LDA puzzle, Y     ; check the slot to see if it's empty
    BEQ @Move         ; if it is empty, move again in the same direction until we hit a non-empty slot

  @Exit:
    RTS               ; then exit

; unused (that $60 might be an unused RTS -- but who cares)
;  .BYTE $60,$00





  
;;;;;;;;;;;;;;;;;;;;;;
;;  unknown - unused  [$B5C9 :: 0x375D9]

lut_OrbCHR: 
 ; .INCBIN "chr/menuorbs.chr"
 .INCBIN "chr/new_menuorbs.chr"

;; Note that the graphics are edited a bit to give the menu some neat connecting box tiles.

 
 
 
 



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  EnterBridgeScene_L  [$B800 :: 0x37810]
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

EnterBridgeScene_L:              JMP EnterBridgeScene


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  EnterEndingScene   [$B803 :: 0x37813]
;;
;;    Enters the ending scene (epilogue that appears after you
;;  kill chaos)
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

EnterEndingScene:
    LDA #$43
    STA music_track           ; start music track $43 (epilogue music)

    JSR Story_FillSecAttrib   ; fill secondary NT's attribute table (make it blue)
    JSR Ending_StartPPU       ; load BG palette and start up the PPU

    LDA #0
    STA story_credits         ; we won't be drawing credits, so clear that

    LDA lut_Bridge_LastPage   ; start drawing story pages from AFTER the bridge scene
    STA story_page            ;  (both bridge and ending scene text is stored together, bridge
                              ;  scene text is stored first).

  @StoryLoop:
      LDA story_page            ; see if we're to the last page
      CMP lut_Ending_LastPage
      BCS @StoryExit            ; if we are, exit this loop

      LDA #1
      STA story_dropinput     ; otherwise, ignore/drop user input

      JSR Story_DoPage        ; do a page of story
      JMP @StoryLoop          ; and keep looping

  @StoryExit:
    LDA #$04                  ; redraw the story box
    STA box_x                 ;  this erases its contents.
    STA box_y
    LDA #$12
    STA box_wd
    LDA #$0C
    STA box_ht
    JSR DrawBox_L

    JSR Story_OpenShutters      ; Do the shutter opening effect to reveal the empty story box

    JSR DrawFancyTheEndGraphic  ; Do the fancy "The End" drawing effect

  @FinalLoop:              ; then the game is over!
    JSR WaitForVBlank_L    ; simply wait endlessly... FOREVER  **THERE IS NO ESCAPE**
    JSR CallMusicPlay_L        ;   but keep the music playing by calling MusicPlay every frame
    JMP @FinalLoop


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Enter Bridge Scene  [$B847 :: 0x37857]
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


EnterBridgeScene:
    JSR Story_FillSecAttrib    ; fill secondary NT's attribute table (make it blue)
    JSR Bridge_StartPPU        ; load the BG palette, and start up the PPU

    LDA #$42
    STA music_track         ; start music track $42 (bridge scene music)
    STA dlgmusic_backup

    LDA #0
    STA story_credits       ; start with drawing story (not credits)
    STA story_page          ; and start on page zero

  ; this loop does the first few pages of the bridge scene (the story)

   @StoryLoop:
      LDA story_page           ; get current page
      CMP lut_Bridge_LastPage  ; see if we've reached the max story page for the bridge scene
      BCS @StoryExit           ; if we have, exit this loop

      LDA #0
      STA story_dropinput   ; set dropinput to zero (we don't want to ignore user input)
      JSR Story_DoPage      ; and do a page of story

      JMP @StoryLoop        ; and continue looping until all necessary pages have been done

  @StoryExit:
    LDA #0
    STA story_page          ; reset the page number to zero
    LDA #1
    STA story_credits       ; but this time, we're doing the credits

  ; this loop does the next few pages of the bridge scene (the credits)

  @CreditsLoop:
      LDA story_page        ; check page number
      CMP #4                ; there are 4 pages of credits
      BCS @CreditsExit      ; if we've done all 4, exit this loop

      LDA #0                ; otherwise, zero dropinput so we don't ignore user input
      STA story_dropinput
      JSR Story_DoPage      ; and do a page of credits

      JMP @CreditsLoop      ; and continue looping

  @CreditsExit:
    LDA #$80              ; mark the bridge scene as completed.. so it won't be activated again
    STA bridgescene       ;   if the user walks over the bridge again

  ; this last loop simply stalls a bit ($20 frames) before exiting so the exit
  ;  isn't so abrupt

    LDA #$20              ; downcounter for number of frames to stall.  ($20 frames)
   @StallLoop:
      PHA                 ; push down counter
      JSR Story_EndFrame  ; stall a frame
      PLA                 ; pull and decrement down counter
      SEC
      SBC #1
      BNE @StallLoop      ; and loop until it expires

    LDA #$01              ; then move the PPU over to the "closed" NT (even though it should be there
    STA soft2000          ;  already!)
    STA $2000

    RTS                   ; and exit

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Story - Fill Secondary Attribute Table  [$B899 :: 0x378A9]
;;
;;    This fills the top half of the secondary NT's ($2400) attribute table.
;;  Essentially, this makes the story box on the $2400 NT a blue color, but makes
;;  the story box on the $2000 NT a black color.  The game will then
;;  toggle between these NTs every few scanlines to do that shutter effect seen
;;  in the Story screens (Bridge and Ending scenes).
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

Story_FillSecAttrib:
    LDA #0
    STA $2001             ; turn off PPU

    LDA #0
    STA story_page        ; reset story page to zero (totally unnecessary here)

    LDX #0                ; zero X for upcoming loop

    LDA $2002             ; reset PPU toggle
    LDA #$27
    STA $2006             ; set PPU Address to $27C0  (attribute table for nt@$2400)
    LDA #$C0
    STA $2006

  @Loop:
      LDA lut_StorySecondaryAttrib, X   ; copy byte from our attribute LUT
      STA $2007                         ; to the actual attribute table
      INX
      CPX #$20
      BCC @Loop           ; loop until $20 bytes copied (top half of attribute table)

    LDA #0             ; reset NT scroll to zero (seems weird to do here)
    STA soft2000
    STA $2000

    RTS                ; then exit


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Story - Start PPU  [$B8C4 :: 0x378D4]
;;
;;    Loads and draws the desired palette for the Bridge or Ending scene,
;;  then turns the PPU on and resets the scroll.
;;
;;    Two entry points.  One for the bridge scene, and one for the ending scene.
;;  The only difference between the two is a different palette is loaded.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

 ;; entry point for the Ending Scene

Ending_StartPPU:
    JSR Ending_LoadPalette   ; load ending palette
    JMP _Story_StartPPU      ;  then jump ahead to turn on PPU


 ;; entry point for the Bridge Scene

Bridge_StartPPU:
    JSR Bridge_LoadPalette   ; load bridge palette
                             ;  then flow into next section to turn on PPU


  _Story_StartPPU:
    JSR WaitForVBlank_L    ; wait for VBlank
    LDX #0                 ; zero X (completely pointless)
    JSR DrawPalette_L      ; draw the palette

    LDA #$0A
    STA $2001              ; turn on BG rendering (but leave sprites disabled)
    LDA #0
    STA $2005
    STA $2005              ; reset X and Y scroll
    RTS                    ; and exit



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Story - Do Page  [$B8E3 :: 0x378F3]
;;
;;    Does one page of story.  Incuding the open and close shutter effects.
;;
;;  IN:   story_page, story_credits
;;
;;  OUT:  story_page = incremented by 1
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


Story_DoPage:
    LDA #$01             ; switch to "closed" NT (shutters closed)
    STA soft2000
    STA $2000

    STA menustall        ; enable menu stalling (drawing is going to be done while PPU on)

    LDA #BANK_THIS       ; set current and return banks -- needed for
    STA cur_bank         ;  DrawComplexString, which is called from Story_DrawText
    STA ret_bank

    LDA #$04             ; redraw the story box at coords $04,$04
    STA box_x            ;  and with dims  $12,$0C
    STA box_y
    LDA #$12             ; this will erase the box's previous contents (the previous page)
    STA box_wd
    LDA #$0C
    STA box_ht

    JSR DrawBox_L            ; draw the box (erases contents)
    JSR Story_DrawText       ; draw this page of story text / credits
    JSR Story_OpenShutters   ; do the open shutter effect
    JSR Story_Wait           ; wait for user to read the text
    INC story_page           ;  then increment the story page
    JMP Story_CloseShutters  ; do the close shutter effect, then exit

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Story - Wait  [$B911 :: 0x37921]
;;
;;    Called when story/credit text is to be displayed.  Waits for user to
;;  read onscreen text before proceeding.
;;
;;    This waits for 512 frames (~8.5 seconds) maximum.  Or, if user input
;;  is not ignored, it exits when the user presses A or B (or after 512 frames
;;  if they never do).  User input is dropped/ignored for the ending scene, so the
;;  user has no choice but to wait.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

Story_Wait:
    LDA #2
    STA story_timer     ; set story timer to 2 (2*256 frames to wait = 512 frames)
    LDA #0
    STA framecounter    ; reset frame counter to zero (so it can count up to 256)

    STA joy_a           ; clear A and B button catchers
    STA joy_b

  @Loop:
    JSR WaitForVBlank_L    ; wait for VBlank
    JSR CallMusicPlay_L        ; keep music playing
    JSR UpdateJoy_L        ; update joypad data

    LDA story_dropinput    ; see if we're to drop (ignore) user input
    BNE @CountFrame        ; if we are, skip ahead to @CountFrame

    LDA joy_a           ; check to see if the user pressed A or B
    ORA joy_b
    BNE @Exit           ;  if they did, exit.  Otherwise, count the frame

  @CountFrame:
    INC framecounter    ; increment the frame counter
    BNE @Loop           ; if it didn't wrap, continue looping
    DEC story_timer     ;  if it did wrap, decrement story_timer (story_timer decrements once
    BNE @Loop           ;  every 256 frames).  Loop until story_timer expires.  At which point, exit.

  @Exit:
    LDA #0              ; on exit, clear A and B button catchers
    STA joy_a
    STA joy_b
    RTS


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Story - Close Shutters  [$B93F :: 0x3794F]
;;
;;    This routine animates the shutter closing effect done by the story screens.
;;  For the most part, this routine is identical to Story_OpenShutters below, only
;;  with minor changes to do the process in reverse.  See that routine below for
;;  details of what this routine is doing -- comments here will be sparse and will
;;  just highlight the differences.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

Story_CloseShutters:
    LDA #16
    STA shutter_a    ; shutter_a is the number of open scanlines
    LDA #1
    STA shutter_b    ; shutter_b is the number of closed scanline

  @Frame:
    LDA #$00         ; set soft2000 so remainder of previous frame has shutters opened
    STA soft2000

    JSR WaitForVBlank_L
    JSR WaitForShutterStart

    LDA #$07


  @ShutterLoop:
    PHA

    LDX shutter_b       ; wait for number of closed scanlines
   @ClosedLoop:
      JSR Wait100Cycs
      DEX
      BNE @ClosedLoop

    LDA #$00            ; then switch to open NT
    STA $2000

    LDX shutter_a
   @OpenLoop:           ; wait for number of open scanlines
      JSR Wait100Cycs
      DEX
      BNE @OpenLoop

    LDA #$01            ; then switch to closed NT
    STA $2000

    PLA
    SEC
    SBC #1
    BNE @ShutterLoop

  PAGECHECK @ShutterLoop

  ;; here, timing sensitive code is complete

    JSR CallMusicPlay_L

    INC framecounter
    LDA framecounter
    AND #$01
    BNE @Frame

    INC shutter_b   ; increment number of closed scanlines
    DEC shutter_a   ; decrement number of open scanlines
    BNE @Frame

    LDA #$01        ; once complete, switch to closed NT
    STA $2000       ;  so shutters remain closed.
    STA soft2000

    RTS

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Story - Open Shutters  [$B98D :: 0x3799D]
;;
;;    This routine animates the shutter opening effect done by the story screens.
;;  This is done with screen splitting and timing tricks.  See the big paragraphs
;;  in the routine for further details
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

Story_OpenShutters:
    LDA #16           ; set the counter for the closed shutter portion of the effect.
    STA shutter_a     ;  16 to approximate 16 scanlines of closed shutters

    LDA #1            ; set the counter for the open shutter portion of the effect
    STA shutter_b     ;  1 to approximate 1 scanline of opened shutters
                  ; this may look like it would actually be 17 scanlines (16+1, right?)
                  ;  but because the loops are a little shorter than 1 scanline.. this
                  ;  works out to closer to 16 scanlines (a little less, actually, see notes below)

            ; once counters are prepped -- start doing frames of animation

  @Frame:
    LDA #$01             ; set soft2000 to use the closed NT ($2400 -- the one with closed shutter
    STA soft2000         ;  graphics).  This leaves the shutter closed for the remainder of the previous
                         ;  frame.

    JSR WaitForVBlank_L          ; wait for VBlank
    JSR WaitForShutterStart      ; then wait for the PPU to reach approx. shutter start time

    LDA #$07             ; A is our down counter, that counts how many different shutters
                         ;  we are going to animate.  There are 7 animations performed, but because
                         ; the first two are off the top of the text box, only 5 are visible

  ;;
  ;;  This is the loop which animates the shutters.  This animation is performed by having two
  ;;   NTs which are identical except for the text box:  The $2000 NT has the text and a black BG,
  ;;   so it's the "open" NT.  The $2400 NT has no text and a blue BG, so it's the "closed" BG.
  ;;  The game will split the screen multiple times during the frame to have the PPU switch between
  ;;   these nametables at different scanlines -- thus appearing to make the shutters gradually
  ;;   open, even though no NT or CHR changes are taking place (as complicated as this sounds, it
  ;;   really is the simplest way to do this effect -- the effect itself is quite advanced, even though
  ;;   it may not seem it).
  ;;
  ;;  1 scanline is 113.6667 (341/3) CPU cycles.  This loop will use shutter_a and shutter_b as
  ;;   down counters to approximate the number of scanlines to have the shutters opened (b) and closed
  ;;   (a).  However the loop that uses these down counters is 105 CPU cycles per iteration (less than
  ;;   1 scanline) -- so these are "not quite scanlines".  This results in the entire loop being a
  ;;   little shorter than you'd expect.. and means the timing isn't quite as tight as it could be.
  ;;
  ;;  I have counted the cycles for this loop, and given that shutter_a and shutter_b will always
  ;;   collectively sum 17, @ShutterLoop takes exactly 1814 cycles every iteration
  ;;   (1814*3/341 = 15.95 -- a little less than 16 scanlines).  This means that *eventually*
  ;;   this routine would desync and the shutters would become oblong -- but since there's only 7
  ;;   iterations, and since the scroll isn't REALLY changed until the PPU reloads the temp address
  ;;   (which doesn't occur until the end of the scanline), this timing is "good enough".  It
  ;;   will draw correctly without distortion.
  ;;
  ;;  Having called WaitForShutterStart above, the PPU is now ~8 scanlines into frame rendering.
  ;;   The story box appears at scanline 40, which means there are 32 scanlines until the shutters
  ;;   start becoming visible.  This is why the first two shutters are invisible and why there's
  ;;   7 shutters drawn instead of 5 (since only 5 are visible in the story box).
  ;;
  ;;  Also note that the length of these loops could be changed if the branch crosses a page boundary
  ;;   but that would only make the loops longer (and they're already short) -- so even if that
  ;;   happens, there wouldn't be any visible glitches.  If anything it would help tighten up the
  ;;   timing.
  ;;

  @ShutterLoop:
    PHA              ; push shutter counter to stack to back it up

    LDX shutter_a       ; load number of not-quite-scanlines shutters are to be closed
   @ClosedLoop:         ; and wait that long
      JSR Wait100Cycs
      DEX
      BNE @ClosedLoop   ; (each loop iteration = 105 cycles)

    LDA #$00         ; then switch the PPU over to the "open" NT
    STA $2000

    LDX shutter_b       ; load number of not-quite-scanlines shutters are to be opened
   @OpenLoop:           ; and wait that long
      JSR Wait100Cycs
      DEX
      BNE @OpenLoop

    LDA #$01         ; then close the shutters again by switching
    STA $2000        ;  the PPU over to the "closed" NT

    PLA              ; pull the loop counter from the stack
    SEC
    SBC #1           ; and count it down
    BNE @ShutterLoop ; keep repeating this loop (draw another shutter) until it expires
                     ;  7 iterations -- so 7 shutters are drawn (but only 5 visible)

  PAGECHECK @ShutterLoop   ; assert that loop doesn't cross a page boundary (would mess with timing)

  ;;
  ;; Once code reaches here... timing critical stuff has ended, and PPU changes for the frame
  ;;   are complete
  ;;

    JSR CallMusicPlay_L    ; keep the music playing

    INC framecounter   ; increment the fame counter
    LDA framecounter   ; and check the low bit
    AND #$01
    BNE @Frame         ; if the low bit is set, repeat the same frame we just did
                       ;  this means the shutters move 1 scanline every other frame

    INC shutter_b      ; increment the number of open scanlines to do
    DEC shutter_a      ; and decrement the number of closed scanline
    BNE @Frame         ; and keep looping until there are no more closed scanlines

  ;; once the number of closed scanlines reaches zero... shutter animation is complete,
  ;;  and shutters are fully opened.

    LDA #0             ; set the PPU to use the "open" NT
    STA $2000
    STA soft2000

    RTS                ; and exit!

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Wait 100 Cycles [$B9DB :: 0x379EB]
;;
;;    JSRing to this routine will burn exactly 100 CPU cycles.  This total
;;  includes the JSR.  This is used as a timing mechanism for the shutter effects
;;  in the Story screens.
;;
;;    It is important that this routine does not modify X!  It also does not modify
;;  A, but that isn't relied upon.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

Wait100Cycs:
    LDY #17        ; +2 cycles
  @Loop:
      DEY            ; +2 cycles
      BNE @Loop      ; +3 cycles (5 cycle loop * 17 iterations = 85 - 1 = 84 cycles for loop)

  CRITPAGECHECK @Loop

    NOP            ; +2 cycles
    RTS            ; +6 cycles
                   ; = 2+84+2+6 = 94 cycles for this routine + 6 for the JSR = 100 cycles even

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Wait For Shutter Start [$B9E2 :: 0x379F2]
;;
;;    JSRing to this routine burns 3173 cycles.  If called after waiting for VBlank,
;;  this puts the CPU roughly 3209 cycles into the frame (*3/341 = ~28 scanlines from VBl start
;;  which is about ~8 scanlines into frame rendering).  Note that this is really probably closer
;;  to 7 scanlines into rendering... but since the PPU changes made by surrounding routines don't
;;  take effect until "HBlank" (end of scanline), write effectively get "pushed back" to the
;;  end of the scanline... so you basically "round up" when calculating the scanline.
;;
;;    The actual story box (where shutter effect is to apply) starts on scanline 40 -- which
;;  means from the time this routine ends, it will be approximately 32 scanlines until the
;;  story box is rendered.  Since the shutter effect is applied in groups of 16 scanlines,
;;  32 is a fine number to start with because it's a multiple of 16.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

WaitForShutterStart:
    LDA #0         ; +2
    STA $2005      ; +4    reset scroll
    STA $2005      ; +4

    LDX #30        ; +2
  @Loop:
      JSR Wait100Cycs   ; +100
      DEX               ; +2
      BNE @Loop         ; +3  (105 cycle loop * 30 iterations = 3150 - 1 = 3149 cycles for loop)

  PAGECHECK @Loop

    RTS            ; +6
                   ; = 2+4+4+2+3149+6 = 3167 cycles for this routine + 6 for the JSR = 3173 cycles

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Bridge Scene - Load Palette  [$B9F3 :: 0x37A03]
;;
;;    Loads the BG palette for the bridge scene
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

Bridge_LoadPalette:
    LDX #$0F                  ; X is loop counter and index
  @Loop:
      LDA lut_BridgeBGPal, X  ; copy palette entry from lut
      STA cur_pal, X          ; to palette
      DEX
      BPL @Loop               ; and loop until X wraps ($10 iterations -- full BG palette)

    RTS          ; then exit



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Ending Scene - Load Palette  [$B9FF :: 0x37A0F]
;;
;;    Loads the BG palette for the ending scene
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

Ending_LoadPalette:
    LDX #$0F                  ; X is loop counter and index
  @Loop:
      LDA lut_EndingBGPal, X  ; copy palette entry from lut
      STA cur_pal, X          ; to palette
      DEX
      BPL @Loop               ;and loop until X wraps ($10 iterations -- full BG palette)

    RTS           ; then exit

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Story - Draw Text  [$BA0B :: 0x37A1B]
;;
;;    Loads and draws the text for the story screens (Bridge/Ending scenes).
;;
;;  IN:  story_credits, story_page
;;
;;    Credits and Story text are stored seperately, and are in totally different
;;  formats.  As such this routine has to split itself in two depending on which
;;  type of text is being drawn.
;;
;;    Story text is a normal Complex String (see DrawComplexString for nitty-gritty
;;  details) drawn inside the story box.
;;
;;    Credits text is different.  Rather than being a complex string, it's a series of 
;;  simple strings -- each of which has no support for DTE, or even simple control codes
;;  like line breaks!
;;
;;    Each such simple string is prefixed with a 2-byte address which specifies the
;;  PPU address that this string is to be drawn.  The string then continues until a
;;  $00 or $01 termination byte is found.
;;
;;    The $00 null terminator marks the end of the page (ie:  the end of this series of
;;  strings).  The $01 terminator marks the end of the individual string, but another
;;  string immediately follows it (the new string is prefixed by a new PPU address)
;;
;;    For an Example:
;;
;;  80 21 ...(string data to be drawn at $2180)... 01 A0 21 ... (data to be drawn
;;     at $21A0) ... 00    (end of page)
;;
;;
;;    The NASIR CRC:
;;  ?As an anitpiracy measure?, a checksum is in place which limits changes you can make
;;  to the credits part of the bridge scene.  It performs the checksum on the first few bytes
;;  of lut_CreditsText, however it does not use the lut_CreditsText address directly (presumably
;;  as an additional obfuscation measure to make the routine harder to crack?)  What it does
;;  instead is, it reads the high byte of the address from the middle of this routine, and
;;  uses that as the high byte for a pointer from which it reads the credits data.
;;    The @NasirCRCHighByte and __Nasir_CRC_High_Byte symbols in this routine are simply used
;;  as markers so that other routine can get the appropriate byte.
;;    See AssertNasirCRC in the fixed bank for further details.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

Story_DrawText:
    LDA story_credits    ; are we drawing credits?  or story text?
    BNE @DoCredits       ;  if credits... do them
      JMP @DoStory       ;  otherwise, do story

  @DoCredits:
    LDA story_page       ; get current page number
    ASL A                ; double it (2 bytes per pointer)
    TAX                  ; and throw in X for indexing

        @NasirCRCHighByte:       ; label unimportant to this routine -- has to do with CRC check -- see above
    LDA lut_CreditsText, X     ; load up the pointer to credits text
    STA text_ptr
    LDA lut_CreditsText+1, X
    STA text_ptr+1

  @StartSimpleString:
    JSR Story_EndFrame   ; end the frame (keeps music playing, and ensures we're in VBlank)
    LDA $2002            ; reset PPU toggle

    LDY #1               ; Y=1 because we're to load the high byte of the address first
    LDA (text_ptr), Y
    STA $2006            ; set high byte of PPU address
    DEY                  ; then load and set low byte
    LDA (text_ptr), Y    ;  This is funky because the address is stored low-byte first, but
    STA $2006            ;  $2006 must be written to high-byte first.

    LDA text_ptr         ; add 2 to our text pointer
    CLC
    ADC #2
    STA text_ptr
    LDA text_ptr+1       ;  catch carry
    ADC #0
    STA text_ptr+1

  @SimpleStringLoop:
    LDY #0               ; zero Y, our index (pointless here, Y is already zero)
    LDA (text_ptr), Y    ; fetch next byte in string
    BEQ @EndCreditsPage  ; if zero (null terminator), this page is complete

    INC text_ptr         ;  otherwise, increment our pointer to look at next byte in string
    BNE :+
      INC text_ptr+1     ;  inc high byte of pointer if low byte wrapped

:   CMP #$01
    BEQ @StartSimpleString   ; if this byte was $01, start a new simple string

    STA $2007              ; otherwise (normal byte), draw it
    JMP @SimpleStringLoop  ; and continue looping

  @EndCreditsPage:
    LDA #0
    STA $2005            ; reset scroll (but not NT scroll -- screen still scrolled to $2400)
    STA $2005
    RTS                  ; and exit

 ;;
 ;; called for story text (ie:  not credits)
 ;;

@DoStory:
    LDA story_page          ; get the current page of story we're to display
    ASL A                   ; double it (2 bytes per pointer)
    TAX                     ; and throw it in X

    LDA lut_StoryText, X    ; load up the pointer to this page of story text
    STA text_ptr
    LDA lut_StoryText+1, X
    STA text_ptr+1

    JMP DrawComplexString_L ; and draw it at a complex string.  Then exit


;__Nasir_CRC_High_Byte = @NasirCRCHighByte+2   ; unimportant to this routine -- has to do with CRC check
                                              ;  see above description
                                              
;; JIGS - nah

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Story - End Frame  [$BA70 :: 0x37A80]
;;
;;    This routine is used to end a frame by some of the story code (Bridge/Ending scenes)
;;  It simply resets the scroll, calls MusicPlay, then waits for another VBlank to happen.
;;  This assures the frame will be rendered properly, music will play correctly, and
;;  code will resume from this routine when VBlank has started (so further drawing can be done)
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

Story_EndFrame:
    LDA #0
    STA $2005             ; reset scroll
    STA $2005

    JSR CallMusicPlay_L       ; play the music
    JSR WaitForVBlank_L   ; and wait for VBlank
    RTS                   ; then exit

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Story Secondary Attribute Table  [$BA7F :: 0x37A8F]
;;
;;    This is the top half of the attribute table for the secondary nametable ($2400)
;;  for the story screens (Bridge and Ending scenes).  All of it is the same as
;;  the normal attribute table ($2000) except for the box to contain the story, which uses
;;  palette set 0 instead of set 3.  This makes the empty box have a black body
;;  on the primary NT, and a blue body on the secondary NT.


lut_StorySecondaryAttrib:
  .BYTE $55,$55,$55,$55,$55,$55,$55,$55
  .BYTE $55,$00,$00,$00,$00,$44,$55,$55
  .BYTE $55,$00,$00,$00,$00,$44,$55,$55
  .BYTE $55,$00,$00,$00,$00,$44,$55,$55


 ; unused
 ; .BYTE 0

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  MiniGame - Slide Horizontally  [$BAA0 :: 0x37AB0]
;;
;;     Slides the puzzle pieces horizontally in the puzzle -- updating the puzzle and
;;  animating the onscreen sprites so they appear to gradually slide into their new position.
;;
;;     This routine is pretty much identical to MiniGame_VertSlide.  See that routine for details
;;  and more in-depth comments (repeating all the comments here would've been silly -- for the most
;;  part the routines are the same)
;;
;;  IN:  tmp   = position of cursor
;;       tmp+1 = position of empty slot
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


MiniGame_HorzSlide:
    LDA tmp          ; if cursor < empty slot
    CMP tmp+1
    BCC @Left        ; then sliding left.  Otherwise... sliding right.

  @Right:
    SBC tmp+1        ; cursor - empty slot
    STA tmp+2        ; = number of columns that need to be moved right

    LDX tmp+1            ; start at empty slot
  @Right_SlideLoop:
      LDA puzzle+1, X    ; move each puzzle piece right 1 slot
      STA puzzle, X
      INX
      CPX tmp            ; until we get to the cursor
      BCC @Right_SlideLoop
    LDA #0
    STA puzzle, X        ; make the cursor the empty slot

    LDA #1
    STA mg_slidedir      ; set slide direction to 1 (right)

    LDA tmp
    LDX tmp+2
  @Right_SpriteLoop:
      STA mg_slidespr-1, X    ; fill the slidespr list with the slots that need to be animated
      SEC
      SBC #1
      DEX
      BNE @Right_SpriteLoop

    JMP MiniGame_AnimateSlide   ; then animate them -- and exit


  @Left:
    LDA tmp+1      ; empty slot - cursor
    SEC
    SBC tmp
    STA tmp+2      ; = number of columns that need to be moved left

    LDX tmp+1
  @Left_SlideLoop:
      LDA puzzle-1, X     ; move all the necessary puzzle pieces left
      STA puzzle, X
      DEX
      CPX tmp
      BNE @Left_SlideLoop
    LDA #0
    STA puzzle, X         ; replace cursor's slot the empty slot

    STA mg_slidedir       ; set direction to zero (left)

    LDA tmp
    LDX tmp+2
  @Left_SpriteLoop:
      STA mg_slidespr-1, X    ; fill the slidespr list with the slots that need to be animated
      CLC
      ADC #1
      DEX
      BNE @Left_SpriteLoop

    JMP MiniGame_AnimateSlide  ; then animate them, and exit




 ;; unknown / unused

;  .BYTE $09,$03,$02,$05,$0F,$3C,$F3

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Credits Text   [$BB00 :: 0x37B10]
;;
;;    Pointer table followed by text data for the credits text.  Credits
;;  text is displayed in the second half of the Bridge Scene.  It does not
;;  follow the same format as other bridge scene text (Story Text).  See
;;  Story_DrawText for a description of the format

;  .ALIGN  $100
lut_CreditsText:
.word CREDITSLIDE1
.word CREDITSLIDE2
.word CREDITSLIDE3
.word CREDITSLIDE4

CREDITSLIDE1:
.byte $E8,$20,$2F,$31,$2E,$26,$31,$20,$2C,$2C,$24,$23,$01,$2C,$21,$21,$38,$01,$88,$21,$2D,$FF,$20,$FF,$32,$FF,$28,$FF,$31,$00

CREDITSLIDE2:
.byte $E8,$20,$22,$27,$20,$31,$20,$22,$33,$24,$31,$01,$29,$21,$23,$24,$32,$28,$26,$2D,$01,$86,$21,$38,$2E,$32,$28,$33,$20,$2A,$20,$FF,$20,$2C,$20,$2D,$2E,$00

CREDITSLIDE3:
.byte $E9,$20,$32,$22,$24,$2D,$20,$31,$28,$2E,$01,$2C,$21,$21,$38,$01,$87,$21,$2A,$24,$2D,$29,$28,$FF,$33,$24,$31,$20,$23,$20,$00

CREDITSLIDE4:
.byte $E8,$20,$2F,$31,$2E,$23,$34,$22,$33,$28,$2E,$2D,$01,$2C,$21,$2E,$25,$01,$86,$21,$32,$30,$34,$20,$31,$24,$FF,$FF,$20,$C2,$33,$24,$20,$2C,$00



 ; $BB8E -- unknown/unused?  very, very strange.  More space for credit text?
 ; .INCBIN "bin/0D_BB8E_unknown.bin"
 ;; JIGS - I've yet to run into a problem from disabling this...
 ;; HOWEVER, I have also yet to complete the game while working on it. So maybe it messes up the ending.

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Draw All Puzzle Pieces  [$BE00 :: 0x37E10]
;;
;;     Draws all puzzle pieces for the minigame to OAM.  Does
;;  not handle the animation that occurs when a puzzle piece is being moved.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

DrawAllPuzzlePieces:
    JSR ClearOAM     ; clear OAM

    LDA #$48         ; set sprite coords to $48, $2F
    STA spr_x        ;  this is where we start drawing the puzzle pieces
    LDA #$2F
    STA spr_y

    LDA #0           ; A will be the overall loop counter and puzzle piece to draw.  Start at zero.

  @Loop:
    PHA                 ; push loop counter to stack to back it up

    JSR DrawPuzzlePiece ; draw this puzzle piece

    LDA spr_x           ; add $10 to the X coord (next puzzle piece)
    CLC
    ADC #$10
    STA spr_x

    CMP #($40 + $48) ; once we do 4 puzzle pieces in this row...
    BCC @Continue
      LDA #$48       ;  ... reset the X coord to first column
      STA spr_x
      LDA spr_y      ;  ... and add $10 to Y coord to move to next row
      CLC
      ADC #$10
      STA spr_y

  @Continue:
    PLA              ; pull the loop counter from the stack
    CLC
    ADC #1           ; increment it by 1
    CMP #$10         ; and keep looping until we do all $10 tiles
    BCC @Loop

    RTS              ; then exit


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Draw Puzzle Piece  [$BE30 :: 0x37E40]
;;
;;    Draws the puzzle piece that is currently in the given slot
;;
;;  IN:  A = slot ID containing puzzle piece to draw
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


DrawPuzzlePiece:
    STA tmp+9        ; put slot index to draw in tmp+9 (will use later)
    TAX
    LDA puzzle, X    ; get the puzzle piece currently at this slot
    BNE @Draw        ;  if it's nonzero (slot isn't empty), draw it.  But don't draw an empty slot


  @Done:
    LDA sprindex     ; after done drawing (or if drawing was skipped due to slot being empty)
    CLC              ;  increment the sprindex by 4 sprites (4 bytes per sprite)
    ADC #4*4
    STA sprindex
    RTS              ; then exit


  @Draw:
    ASL A                 ; multiply puzzle piece by 4 to get the desired graphic for this piece
    ASL A
    STA tmp+8             ; store that tile ID in tmp+8 (will use later)

    LDX sprindex          ; put sprite index in X for indexing

    LDA spr_y             ; get the desired Y coord
    STA oam_y, X          ; set the top two sprites to use it
    STA oam_y+(1*4), X
    CLC
    ADC #8
    STA oam_y+(2*4), X    ; but add 8 to it for the bottom two sprites
    STA oam_y+(3*4), X

    LDA spr_x             ; then get X coord
    STA oam_x, X          ; left sprites get it unaltered
    STA oam_x+(2*4), X
    CLC
    ADC #8
    STA oam_x+(1*4), X    ; but 8 is added for the right side sprites
    STA oam_x+(3*4), X

    LDA tmp+8             ; get desired tile graphic (previously written to tmp+8)
    STA oam_t, X          ; set each of the 4 sprites' graphics
    CLC
    ADC #1
    STA oam_t+(1*4), X    ; but increment the tile ID by 1 each time
    CLC
    ADC #1
    STA oam_t+(2*4), X
    CLC
    ADC #1
    STA oam_t+(3*4), X

    LDA #0                ; sprite attributes = 0  (palettes 0, no flipping, foreground priority)

    LDY cursor            ; get the cursor
    CPY tmp+9             ;  and see if it matches our selected slot (previously written to tmp+9)

    BNE @DrawAttrib       ; if it does match...

      LDA framecounter    ; ... use bit 1 of the framecounter to hide the sprite.  Using bit 1 toggles
      AND #$02            ;   sprite visibility every other frame (2 frames visible, 2 frames invisible)
      ASL A               ; shift bit 1 into bit 5 (sprite priority bit).  This gives the sprite background
      ASL A               ; priority, hiding it behind the background when this bit is set (effectively
      ASL A               ; making the sprite invisible)
      ASL A

  @DrawAttrib:
    STA oam_a, X          ; copy the desired attribute byte to each sprite
    STA oam_a+(1*4), X
    STA oam_a+(2*4), X
    STA oam_a+(3*4), X

    JMP @Done             ; and JMP to the exit


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  MiniGame - Animate Slide [$BE9E :: 0x37EAE]
;;
;;    This routine performs the animation when sliding puzzle pieces around
;;  in the minigame.  Each tile being moved is slid 1 pixel in the direction they're being
;;  moved each frame.  It takes 16 frames for the tiles to slide into their new position.
;;
;;    This routine also updates the cursor so that it is set to the slot that was
;;  previously empty
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

MiniGame_AnimateSlide:
    LDA tmp+1              ; the old empty slot becomes the new cursor
    STA cursor             ;  since the old cursor will become the new empty slot -- and
                           ;  we never want the empty slot and cursor to be on the same tile

    LDA #0                 ; A will be a makeshift loop counter.  We will loop 16 times, moving
                           ;  the puzzle pieces 1 pixel each iteration.
  @AnimateLoop:
    PHA                    ; back up loop counter
    JSR WaitForVBlank_L    ; wait for VBlank
    LDA #>oam              ; do sprite DMA
    STA $4014
    JSR CallMusicPlay_L        ; and play the music

    LDA mg_slidespr        ; then slide the sprites of each tile being moved 1 pixel
    JSR @SlideTile         ;   in the desired direction
    LDA mg_slidespr+1
    JSR @SlideTile
    LDA mg_slidespr+2
    JSR @SlideTile

    PLA                    ; get loop counter (previously pushed)
    CLC
    ADC #1                 ; increment it by 1
    CMP #$10               ; and keep looping until we reach $10 ($10 iterations)
    BCC @AnimateLoop

    JMP MiniGameLoop       ; once finished -- return to the minigame loop

  ;;
  ;;  This local subroutine moves the tile in the given slot (in A) 1 pixel in the desired direction
  ;;    If the desired slot ID is negative ($80), it indicates that there is no slot to be moved.  Since
  ;;    it is possible to move 3 tiles at a time in the puzzle... 3 slots must be checked for every time,
  ;;    but less than 3 will need to be moved when the player only moves 1 or 2 tiles on the puzzle.
  ;;


  @SlideTile:
    BPL :+              ; if the selected sprite is a negative number, it indicates that
      RTS               ;  there is no sprite we need to move here.  So just exit

:   ASL A               ; otherwise, multiply the slot ID by 16 (4 bytes per sprite * 4 sprites
    ASL A               ;  per tile)
    ASL A
    ASL A
    TAX                 ;  and put in X for indexing OAM

    LDY mg_slidedir            ; get the direction we're going to move in Y
    LDA lut_MGDirection_Y, Y   ;  use that to get the Y and X offsets
    STA tmp                    ; 'tmp' will be added to sprite's Y coord
    LDA lut_MGDirection_X, Y
    STA tmp+1                  ; 'tmp+1' will be added to sprite's X coord

    LDY #4              ; Y is our loop counter (4 iterations -- one for each sprite making up this tile)
  @SlideLoop:
    LDA oam_y, X        ; add 'tmp' to sprite's Y coord
    CLC
    ADC tmp
    STA oam_y, X

    LDA oam_x, X        ; and tmp+1 to sprite's X coord
    CLC
    ADC tmp+1
    STA oam_x, X

    TXA                 ; add 4 to our sprite index (look at next sprite)
    CLC
    ADC #4
    TAX

    DEY                 ; decrement our loop counter
    BNE @SlideLoop      ; and repeat until it expires (4 iterations)

    RTS                 ; then exit


 ;; unused
 ;.BYTE 0,0,0,0,0


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Bridge Scene palette [$BF00 :: 0x37F10]

lut_BridgeBGPal:
  .BYTE $0F,$00,$02,$30,  $0F,$3B,$11,$24,  $0F,$3B,$0B,$2B,  $0F,$00,$0F,$30


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Ending Scene (epilogue) palette  [$BF10 :: 0x37F20]

lut_EndingBGPal:
  .BYTE $0F,$00,$01,$30,  $0F,$32,$21,$30,  $0F,$2C,$2A,$1A,  $0F,$00,$0F,$30





LoadStatusBoxScrollWork: 
  LDX #0
 @Loop:
  LDA @ImageTable, X
  STA statusbox_scrollwork, X
  INX
  CPX #8*10
  BNE @Loop
  RTS  
 
@ImageTable:
.byte $32,$33,$18,$18,$18,$18,$34,$35 
.byte $42,$43,$19,$19,$19,$19,$44,$45
.byte $1E,$1F,$00,$00,$00,$00,$1A,$1B 
.byte $1E,$1F,$00,$00,$00,$00,$1A,$1B
.byte $1E,$1F,$00,$00,$00,$00,$1A,$1B
.byte $1E,$1F,$00,$00,$00,$00,$1A,$1B 
.byte $1E,$1F,$00,$00,$00,$00,$1A,$1B
.BYTE $3C,$3D,$1C,$1C,$1C,$1C,$3A,$3B 
.BYTE $4C,$4D,$1D,$1D,$1D,$1D,$4A,$4B




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Minimap Sprite CHR  [$BF00 :: 0x27F10]
;;    CHR for sprites on the minimap

;lut_MinimapSprCHR:
;  .INCBIN "chr/minimap_sprite.chr"

lut_NewMinimapCHR:
  .INCBIN "chr/new_minimap.chr"
  
lut_MinimapTitleCHR:  
  .INCBIN "chr/minimap_title.chr"
  
lut_ZoomMinimapTextCHR:
  .INCBIN "chr/minimap_zoomout.chr"
  
  
lut_MinimapTitle:
.byte $84,$84,$84,$84,$84,$84,$84,$84,$84,$84,$84,$84,$88,$89,$8A,$8B
.byte $8C,$8D,$8E,$8F,$84,$84,$84,$84,$84,$84,$84,$84,$84,$84,$84,$84
.byte $84,$84,$84,$84,$84,$84,$84,$84,$84,$84,$84,$84,$90,$91,$92,$93
.byte $94,$95,$96,$97,$84,$84,$84,$84,$84,$84,$84,$84,$84,$84,$84,$84
.byte $84,$84,$84,$84,$84,$84,$84,$84,$84,$84,$98,$99,$9A,$9B,$9C,$9D
.byte $9E,$9F,$A0,$A1,$A2,$A3,$84,$84,$84,$84,$84,$84,$84,$84,$84,$84
.byte $84,$84,$84,$84,$84,$84,$84,$84,$84,$84,$A4,$A5,$A6,$A7,$A8,$A9
.byte $AA,$AB,$AC,$AD,$AE,$AF,$84,$84,$84,$84,$84,$84,$84,$84,$84,$84

lut_ZoomMapTilesetID:
.byte $01 ; 00 - CONERIA
.byte $01 ; 01 - PRAVOKA
.byte $01 ; 02 - ELFLAND
.byte $01 ; 03 - MELMOND
.byte $01 ; 04 - CRESCENT_LAKE
.byte $01 ; 05 - GAIA
.byte $01 ; 06 - ONRAC
.byte $01 ; 07 - LEIFEN
.byte $02 ; 08 - Coneria_CASTLE_1F
.byte $02 ; 09 - ELFLAND_CASTLE
.byte $02 ; 0A - NORTHWEST_CASTLE
.byte $02 ; 0B - CASTLE_OF_ORDEALS_1F
.byte $06 ; 0C - TEMPLE_OF_FIENDS_PRESENT
.byte $04 ; 0D - EARTH_CAVE_B1
.byte $04 ; 0E - GURGU_VOLCANO_B1
.byte $05 ; 0F - ICE_CAVE_B1
.byte $05 ; 10 - CARDIA
.byte $05 ; 11 - BAHAMUTS_ROOM_B1
.byte $05 ; 12 - WATERFALL
.byte $05 ; 13 - DWARF_CAVE
.byte $05 ; 14 - MATOYAS_CAVE
.byte $05 ; 15 - SARDAS_CAVE
.byte $06 ; 16 - MARSH_CAVE_B1
.byte $06 ; 17 - MIRAGE_TOWER_1F
.byte $02 ; 18 - Coneria_CASTLE_2F
.byte $02 ; 19 - Castle_of_Ordeals_2F
.byte $02 ; 1A - Castle_of_Ordeals_3F
.byte $06 ; 1B - Marsh_Cave_B2       
.byte $06 ; 1C - Marsh_Cave_B3       
.byte $04 ; 1D - Earth_Cave_B2       
.byte $04 ; 1E - Earth_Cave_B3       
.byte $04 ; 1F - Earth_Cave_B4       
.byte $04 ; 20 - Earth_Cave_B5       
.byte $04 ; 21 - Gurgu_Volcano_B2    
.byte $04 ; 22 - Gurgu_Volcano_B3    
.byte $04 ; 23 - Gurgu_Volcano_B4    
.byte $04 ; 24 - Gurgu_Volcano_B5    
.byte $05 ; 25 - Ice_Cave_B2         
.byte $05 ; 26 - Ice_Cave_B3         
.byte $05 ; 27 - Bahamuts_Room_B2    
.byte $06 ; 28 - Mirage_Tower_2F     
.byte $06 ; 29 - Mirage_Tower_3F     
.byte $03 ; 2A - Sea_Shrine_B5             
.byte $03 ; 2B - Sea_Shrine_B4             
.byte $03 ; 2C - Sea_Shrine_B3             
.byte $03 ; 2D - Sea_Shrine_B2             
.byte $03 ; 2E - Sea_Shrine_B1             
.byte $07 ; 2F - Sky_Palace_1F             
.byte $07 ; 30 - Sky_Palace_2F             
.byte $07 ; 31 - Sky_Palace_3F             
.byte $07 ; 32 - Sky_Palace_4F             
.byte $07 ; 33 - Sky_Palace_5F             
.byte $08 ; 34 - Temple_of_Fiends_1F       
.byte $08 ; 35 - Temple_of_Fiends_2F       
.byte $08 ; 36 - Temple_of_Fiends_3F       
.byte $08 ; 37 - Temple_of_Fiends_4F_Earth 
.byte $08 ; 38 - Temple_of_Fiends_5F_Fire  
.byte $08 ; 39 - Temple_of_Fiends_6F_Water 
.byte $08 ; 3A - Temple_of_Fiends_7F_Wind      
.byte $08 ; 3B - Temple_of_Fiends_8F_Chaos     
.byte $04 ; 3C - Titans_Tunnel 

lut_MapTilesetFillTile:
.byte $FF ; 00 - CONERIA
.byte $FF ; 01 - PRAVOKA
.byte $FF ; 02 - ELFLAND
.byte $FF ; 03 - MELMOND
.byte $FF ; 04 - CRESCENT_LAKE
.byte $00 ; 05 - GAIA
.byte $DF ; 06 - ONRAC
.byte $FF ; 07 - LEIFEN
.byte $FF ; 08 - Coneria_CASTLE_1F
.byte $FF ; 09 - ELFLAND_CASTLE
.byte $FF ; 0A - NORTHWEST_CASTLE
.byte $FF ; 0B - CASTLE_OF_ORDEALS_1F
.byte $FF ; 0C - TEMPLE_OF_FIENDS_PRESENT
.byte $FF ; 0D - EARTH_CAVE_B1
.byte $FF ; 0E - GURGU_VOLCANO_B1
.byte $FF ; 0F - ICE_CAVE_B1
.byte $FF ; 10 - CARDIA
.byte $FF ; 11 - BAHAMUTS_ROOM_B1
.byte $FF ; 12 - WATERFALL
.byte $FF ; 13 - DWARF_CAVE
.byte $FF ; 14 - MATOYAS_CAVE
.byte $FF ; 15 - SARDAS_CAVE
.byte $FF ; 16 - MARSH_CAVE_B1
.byte $FF ; 17 - MIRAGE_TOWER_1F
.byte $FF ; 18 - Coneria_CASTLE_2F
.byte $FF ; 19 - Castle_of_Ordeals_2F
.byte $FF ; 1A - Castle_of_Ordeals_3F
.byte $FD ; 1B - Marsh_Cave_B2       
.byte $FF ; 1C - Marsh_Cave_B3       
.byte $FF ; 1D - Earth_Cave_B2       
.byte $FF ; 1E - Earth_Cave_B3       
.byte $FF ; 1F - Earth_Cave_B4       
.byte $FF ; 20 - Earth_Cave_B5       
.byte $FF ; 21 - Gurgu_Volcano_B2    
.byte $FF ; 22 - Gurgu_Volcano_B3    
.byte $FF ; 23 - Gurgu_Volcano_B4    
.byte $FF ; 24 - Gurgu_Volcano_B5    
.byte $FF ; 25 - Ice_Cave_B2         
.byte $FF ; 26 - Ice_Cave_B3         
.byte $FF ; 27 - Bahamuts_Room_B2    
.byte $FF ; 28 - Mirage_Tower_2F     
.byte $FF ; 29 - Mirage_Tower_3F     
.byte $FF ; 2A - Sea_Shrine_B5             
.byte $FF ; 2B - Sea_Shrine_B4             
.byte $FF ; 2C - Sea_Shrine_B3             
.byte $FF ; 2D - Sea_Shrine_B2             
.byte $FF ; 2E - Sea_Shrine_B1             
.byte $FF ; 2F - Sky_Palace_1F             
.byte $FF ; 30 - Sky_Palace_2F             
.byte $FF ; 31 - Sky_Palace_3F             
.byte $FF ; 32 - Sky_Palace_4F             
.byte $FF ; 33 - Sky_Palace_5F             
.byte $FF ; 34 - Temple_of_Fiends_1F       
.byte $FF ; 35 - Temple_of_Fiends_2F       
.byte $FF ; 36 - Temple_of_Fiends_3F       
.byte $FF ; 37 - Temple_of_Fiends_4F_Earth 
.byte $FF ; 38 - Temple_of_Fiends_5F_Fire  
.byte $FF ; 39 - Temple_of_Fiends_6F_Water 
.byte $FF ; 3A - Temple_of_Fiends_7F_Wind      
.byte $FF ; 3B - Temple_of_Fiends_8F_Chaos     
.byte $FF ; 3C - Titans_Tunnel 


lut_MapTilesetPalette:
.byte $01 ; 00 - CONERIA
.byte $01 ; 01 - PRAVOKA
.byte $01 ; 02 - ELFLAND
.byte $01 ; 03 - MELMOND
.byte $01 ; 04 - CRESCENT_LAKE
.byte $01 ; 05 - GAIA
.byte $01 ; 06 - ONRAC
.byte $01 ; 07 - LEIFEN
.byte $01 ; 08 - Coneria_CASTLE_1F
.byte $01 ; 09 - ELFLAND_CASTLE
.byte $01 ; 0A - NORTHWEST_CASTLE
.byte $01 ; 0B - CASTLE_OF_ORDEALS_1F
.byte $02 ; 0C - TEMPLE_OF_FIENDS_PRESENT
.byte $03 ; 0D - EARTH_CAVE_B1
.byte $05 ; 0E - GURGU_VOLCANO_B1
.byte $04 ; 0F - ICE_CAVE_B1
.byte $02 ; 10 - CARDIA
.byte $02 ; 11 - BAHAMUTS_ROOM_B1
.byte $04 ; 12 - WATERFALL
.byte $02 ; 13 - DWARF_CAVE
.byte $02 ; 14 - MATOYAS_CAVE
.byte $02 ; 15 - SARDAS_CAVE
.byte $03 ; 16 - MARSH_CAVE_B1
.byte $02 ; 17 - MIRAGE_TOWER_1F
.byte $01 ; 18 - Coneria_CASTLE_2F
.byte $01 ; 19 - Castle_of_Ordeals_2F
.byte $01 ; 1A - Castle_of_Ordeals_3F
.byte $03 ; 1B - Marsh_Cave_B2       
.byte $03 ; 1C - Marsh_Cave_B3       
.byte $03 ; 1D - Earth_Cave_B2       
.byte $03 ; 1E - Earth_Cave_B3       
.byte $03 ; 1F - Earth_Cave_B4       
.byte $03 ; 20 - Earth_Cave_B5       
.byte $05 ; 21 - Gurgu_Volcano_B2    
.byte $05 ; 22 - Gurgu_Volcano_B3    
.byte $05 ; 23 - Gurgu_Volcano_B4    
.byte $05 ; 24 - Gurgu_Volcano_B5    
.byte $04 ; 25 - Ice_Cave_B2         
.byte $04 ; 26 - Ice_Cave_B3         
.byte $02 ; 27 - Bahamuts_Room_B2    
.byte $02 ; 28 - Mirage_Tower_2F     
.byte $02 ; 29 - Mirage_Tower_3F     
.byte $04 ; 2A - Sea_Shrine_B5             
.byte $04 ; 2B - Sea_Shrine_B4             
.byte $04 ; 2C - Sea_Shrine_B3             
.byte $04 ; 2D - Sea_Shrine_B2             
.byte $04 ; 2E - Sea_Shrine_B1             
.byte $06 ; 2F - Sky_Palace_1F             
.byte $06 ; 30 - Sky_Palace_2F             
.byte $06 ; 31 - Sky_Palace_3F             
.byte $06 ; 32 - Sky_Palace_4F             
.byte $06 ; 33 - Sky_Palace_5F             
.byte $02 ; 34 - Temple_of_Fiends_1F       
.byte $02 ; 35 - Temple_of_Fiends_2F       
.byte $02 ; 36 - Temple_of_Fiends_3F       
.byte $02 ; 37 - Temple_of_Fiends_4F_Earth 
.byte $02 ; 38 - Temple_of_Fiends_5F_Fire  
.byte $02 ; 39 - Temple_of_Fiends_6F_Water 
.byte $02 ; 3A - Temple_of_Fiends_7F_Wind      
.byte $02 ; 3B - Temple_of_Fiends_8F_Chaos     
.byte $03 ; 3C - Titans_Tunnel 

lut_ZoomMapTilesets:
.word lut_OverworldZoomTileset
.word lut_TownMiniMapTileset 
.word lut_CastleMiniMapTileset
.word lut_EarthCaveMiniMapTileset
.word lut_IceCaveMiniMapTileset
.word lut_TowerMiniMapTileset
.word lut_ShrineMiniMapTileset
.word lut_SkyCastleMiniMapTileset
.word lut_TempleMiniMapTileset

lut_ZoomMapPalettes:
.word lut_OverworldZoomPalette ; 0
.word lut_TownCastlePalette    ; 1
.word lut_TemplePalette        ; 2
.word lut_BrownCavePalette     ; 3
.word lut_BlueCavePalette      ; 4
.word lut_RedCavePalettee      ; 5 
.word lut_GreyPalette          ; 6

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  BG palette for minimap  [$BF20 :: 0x27F30]

;lut_MinimapBGPal:
;  .BYTE $02,$04,$37,$0F
;  .BYTE $02,$28,$18,$0F
;  .BYTE $02,$24,$1A,$30
;  .BYTE $02,$1B,$38,$2B
  
  
lut_OverworldZoomPalette:  
  .BYTE $1B,$0F,$37,$04 ; title
  .BYTE $1B,$02,$38,$17 ; map pixels
  .BYTE $1B,$0F,$02,$0F ; map paper borders

lut_TownCastlePalette: 
  .BYTE $38,$0F,$37,$04
  .BYTE $38,$00,$21,$1A
  .BYTE $38,$0F,$38,$0F

lut_TemplePalette:     
  .BYTE $38,$0F,$37,$04
  .BYTE $38,$00,$21,$1A
  .BYTE $38,$0F,$38,$0F  
  
lut_BrownCavePalette:  
  .BYTE $08,$0F,$37,$04
  .BYTE $08,$2D,$38,$27
  .BYTE $08,$0F,$08,$0F  
 ;       ^   ^   ^   ^
 ;for    |   |   |   chests/damage tiles
 ;center |   |   objects of interest
 ;row:   |   walls
 ;      map bg
  
lut_BlueCavePalette:   
  .BYTE $0C,$0F,$37,$04
  .BYTE $0C,$2D,$22,$1C
  .BYTE $0C,$0F,$0C,$0F  
 ;       ^   ^   ^   ^
 ;for    |   |   |   chests/damage tiles
 ;center |   |   objects of interest
 ;row:   |   walls
 ;      map bg

lut_RedCavePalettee:   
  .BYTE $06,$0F,$37,$04
  .BYTE $06,$2D,$26,$16
  .BYTE $06,$0F,$06,$0F  
 ;       ^   ^   ^   ^
 ;for    |   |   |   chests/damage tiles
 ;center |   |   objects of interest
 ;row:   |   walls
 ;      map bg


lut_GreyPalette:       
  .BYTE $0F,$0F,$37,$04
  .BYTE $0F,$2D,$10,$31
  .BYTE $0F,$0F,$0F,$0F  
 ;       ^   ^   ^   ^
 ;for    |   |   |   chests/damage tiles
 ;center |   |   objects of interest
 ;row:   |   walls
 ;      map bg


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Minimap Tileset color assignment LUT  [$BF80 :: 0x27F90]
;;
;;    Each entry in this table coresponds to an overworld tile.
;;  This table specifies what color (of the 4 colors available
;;  colors) this tile will be represented by in the minimap.
;;
;;    The low 2 bits specify the color... bit 2 ($4), is set if
;;  the tile represents a town/dungeon and indicates that a sprite
;;  should be drawn on that tile.
;;

lut_MinimapTileset: 
 ; .BYTE 1,5,5,1,1,1,1,1, 1,1,1,1,1,1,6,0
 ; .BYTE 1,1,1,1,1,1,0,0, 0,1,1,5,5,6,2,3
 ; .BYTE 1,3,1,1,1,1,1,0, 1,5,5,5,1,1,1,5
 ; .BYTE 1,1,5,1,5,5,2,2, 5,5,5,1,3,3,3,1
 ; .BYTE 0,0,2,2,0,2,4,1, 1,5,5,1,5,5,5,1
 ; .BYTE 0,0,2,2,1,1,1,5, 5,1,5,1,1,5,1,1
 ; .BYTE 1,1,1,1,5,5,5,5, 5,5,5,3,5,5,5,3
 ; .BYTE 1,1,1,1,1,1,1,1, 1,2,0,3,3,3,3,3 ; original

.BYTE 0,7,7,0,0,0,0,0, 0,0,0,2,2,2,7,2 
.BYTE 0,0,0,0,0,0,0,1, 0,0,0,4,4,2,2,2
.BYTE 0,3,0,0,0,0,0,0, 0,7,7,7,0,0,0,7
.BYTE 0,0,7,0,7,7,2,2, 7,7,7,0,2,2,2,0
.BYTE 1,1,2,2,1,2,4,2, 2,5,5,2,7,7,7,2 
.BYTE 1,1,2,2,0,0,0,7, 6,0,5,2,0,5,0,2  
.BYTE 0,0,0,0,7,7,5,5, 5,5,5,2,7,5,7,2
.BYTE 0,0,0,0,3,3,0,2, 2,2,2,2,2,2,2,2

;; for overworld:
; 0, 4 = dark green - land
; 1, 5 = blue - water, cave entrances
; 2, 6 = pale yellow - desert, docks, building rooftops
; 3, 7 = brown - mountains, entrances

lut_OverworldZoomTileset: ; 0 
  .BYTE 0,7,7,0,0,0,0,1, 0,2,2,2,2,2,4,2
  .BYTE 3,3,3,0,0,0,1,1, 1,2,2,7,7,2,2,2
  .BYTE 3,3,3,0,0,0,0,1, 0,7,7,4,2,2,2,4
  .BYTE 3,3,4,3,4,4,2,2, 7,7,4,0,2,2,2,0
  .BYTE 1,1,2,2,1,2,4,2, 2,7,7,2,7,7,7,2
  .BYTE 1,1,2,2,0,0,0,7, 7,0,7,2,2,7,2,2
  .BYTE 0,0,0,0,7,7,4,4, 4,4,4,2,4,7,4,2
  .BYTE 0,0,0,0,3,3,0,2, 2,2,2,2,2,2,2,2

; 0, 4 = yellow - floor, fluff items, exit
; 1, 5 = grey - wall, bridge
; 2, 6 = light blue - treasure, pillars, things to talk to, water
; 3, 7 = green - trees, items of interest
  
lut_TownMiniMapTileset: ; 1
  .BYTE 0,0,0,1,1,1,1,1, 1,1,1,1,1,1,3,3
  .BYTE 0,0,0,0,0,0,0,1, 1,1,2,1,1,1,5,5
  .BYTE 2,2,2,2,2,2,5,2, 2,2,1,1,1,5,2,2
  .BYTE 1,2,0,0,3,1,5,5, 0,0,1,2,0,0,5,5
  .BYTE 5,5,5,5,5,5,5,0, 6,5,5,5,5,5,5,5
  .BYTE 5,5,5,5,5,5,5,5, 5,5,5,5,5,5,5,5
  .BYTE 5,5,5,5,5,5,5,5, 5,5,5,5,5,5,5,5
  .BYTE 5,5,5,5,5,5,5,5, 5,5,5,5,5,3,5,2

; 0, 4 = yellow - floor, fluff items, exit
; 1, 5 = grey - wall, bridge
; 2, 6 = light blue - treasure, pillars, things to talk to, water
; 3, 7 = green - trees, items of interest
  
lut_CastleMiniMapTileset: ; 2
  .BYTE 1,1,1,1,0,1,1,0, 1,0,0,0,1,0,0,0
  .BYTE 0,0,0,0,0,0,0,0, 0,0,0,0,7,0,0,0
  .BYTE 0,3,0,0,0,0,0,0, 0,0,0,0,0,0,0,0
  .BYTE 1,0,1,1,1,1,5,5, 2,7,0,5,0,7,0,0
  .BYTE 7,0,0,0,5,5,0,0, 5,5,0,0,2,2,2,2
  .BYTE 2,2,2,2,2,2,0,0, 2,0,0,0,0,0,0,0
  .BYTE 0,7,7,2,2,2,2,2, 2,2,2,2,2,2,2,2
  .BYTE 2,2,2,2,2,2,2,2, 2,0,0,0,0,0,0,0  

; 0, 4 = black
; 1, 5 = grey - walls
; 2, 6 = white - neat things
; 3, 7 = color - chests

lut_EarthCaveMiniMapTileset:
  .BYTE 1,1,1,1,0,1,1,0, 1,0,0,0,1,2,6,6
  .BYTE 1,1,0,1,1,6,6,6, 6,6,0,0,0,0,0,6
  .BYTE 0,0,0,0,6,6,6,6, 6,6,6,6,6,6,0,0
  .BYTE 1,0,1,1,1,1,5,5, 0,0,0,5,0,3,1,1
  .BYTE 0,0,3,3,3,3,3,3, 3,3,3,3,3,3,3,3
  .BYTE 3,3,3,3,3,3,3,3, 3,3,3,3,3,3,3,3
  .BYTE 3,3,3,3,3,3,3,3, 3,3,3,3,3,3,3,3
  .BYTE 3,3,3,3,3,3,3,3, 3,3,3,3,3,3,3,0
  
; 0, 4 = black
; 1, 5 = grey
; 2, 6 = white
; 3, 7 = color   

lut_IceCaveMiniMapTileset:
  .BYTE 1,1,1,1,0,1,1,0, 1,0,0,0,1,2,0,0
  .BYTE 2,2,2,0,0,0,2,2, 6,6,6,6,0,0,0,0
  .BYTE 0,0,0,0,0,0,0,0, 6,6,6,6,6,6,6,0
  .BYTE 1,0,1,1,1,1,5,5, 2,2,0,5,0,1,0,0
  .BYTE 0,0,0,0,0,0,0,0, 0,0,0,3,3,3,3,3
  .BYTE 3,3,3,3,3,3,3,3, 3,3,3,3,3,3,3,3
  .BYTE 3,3,3,3,3,3,3,3, 3,3,3,3,3,3,3,3
  .BYTE 3,3,3,3,3,3,3,3, 3,3,3,3,3,3,3,0  

; 0, 4 = black
; 1, 5 = grey
; 2, 6 = white
; 3, 7 = color 

lut_TowerMiniMapTileset:
  .BYTE 1,1,1,1,0,1,1,0, 1,6,6,0,1,2,2,2
  .BYTE 2,2,2,2,2,0,0,2, 2,0,0,0,0,0,0,0
  .BYTE 6,6,6,6,0,0,6,6, 6,0,0,0,6,0,0,0
  .BYTE 1,0,1,1,1,1,5,5, 0,1,0,5,0,0,0,0
  .BYTE 7,0,0,0,5,5,0,0, 5,5,0,0,2,2,2,2
  .BYTE 0,3,3,3,3,3,3,3, 3,3,3,3,3,3,3,3
  .BYTE 3,3,3,3,3,3,3,3, 0,0,0,0,0,0,0,0
  .BYTE 0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0

; 0, 4 = black
; 1, 5 = grey - walls
; 2, 6 = white - pillar, stairs, neat things
; 3, 7 = color - treasure, water
  
lut_ShrineMiniMapTileset:
  .BYTE 1,1,1,1,0,1,1,0, 1,0,0,0,1,0,0,4
  .BYTE 2,2,1,4,1,2,0,2, 0,0,0,0,0,0,0,0
  .BYTE 0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0
  .BYTE 1,0,1,1,1,1,5,5, 2,0,0,5,3,0,0,0
  .BYTE 6,6,6,6,6,6,6,0, 2,0,0,6,6,6,6,6
  .BYTE 0,0,0,0,0,0,3,3, 3,3,3,3,3,3,3,3
  .BYTE 3,3,3,3,3,3,3,3, 3,3,3,3,3,3,3,3
  .BYTE 3,3,3,3,3,3,3,3, 3,3,3,3,0,0,0,0   

; 0, 4 = black
; 1, 5 = grey
; 2, 6 = white
; 3, 7 = color 

lut_SkyCastleMiniMapTileset:
  .BYTE 1,1,1,1,0,1,1,0, 1,0,6,0,1,0,0,0
  .BYTE 0,0,0,0,0,0,0,0, 0,0,0,0,7,0,0,0
  .BYTE 0,3,0,0,0,0,0,0, 0,0,0,0,0,0,0,0
  .BYTE 1,0,1,1,1,1,5,5, 2,7,0,5,0,7,0,0
  .BYTE 7,0,0,0,5,5,0,0, 5,5,0,0,2,2,2,2
  .BYTE 2,2,2,2,2,2,0,0, 2,0,0,0,0,0,0,0
  .BYTE 0,7,7,2,2,2,2,2, 2,2,2,2,2,2,2,2
  .BYTE 2,2,2,2,2,2,2,2, 2,0,0,0,0,0,0,0   

; 0, 4 = black
; 1, 5 = grey
; 2, 6 = white
; 3, 7 = color 

lut_TempleMiniMapTileset:
  .BYTE 1,1,1,1,0,1,1,0, 1,0,6,0,1,6,1,2
  .BYTE 2,2,2,2,2,2,0,2, 2,6,0,0,0,0,0,0
  .BYTE 0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0
  .BYTE 1,0,1,1,1,1,5,5, 1,1,0,5,0,0,0,0
  .BYTE 6,6,6,6,6,0,0,0, 0,0,0,3,3,3,3,3
  .BYTE 3,3,3,3,3,3,3,3, 3,3,3,3,3,3,3,3
  .BYTE 3,3,3,3,3,3,3,3, 3,3,3,3,3,3,0,0
  .BYTE 0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0 



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Enter Minimap  [$BC00 :: 0x27C10]
;;
;;    Ahhh... the minimap!  On one hand I think it's very clever... on the other hand
;;  the way it draws is CRIMINALLY inefficient.
;;
;;    Usually when you think of NES drawing, you think of a (more or less) fixed pattern
;;  table that contains your tiles, and you arrange those tiles on the screen with
;;  the name table.  However... the minimap is done somewhat differently.
;;
;;    The world map is 256x256 tiles, but it draws it as a 128x128 pixel image (so each
;;  pixel represents 4 tiles in a 2x2 arrangement).  Somewhat coincidentally... the BG pattern
;;  tables (16x16 tiles) also measure 128x128 pixels!  So the game simply uses the BG
;;  pattern tables as a canvas on which to draw the minimap... and has a fixed nametable
;;  placing the tiles on the screen.
;;
;;    Tiles on the pattern table that are nothing but water get drawn over with other
;;  supporting graphics (title and decoration graphics) after map drawing is complete.
;;
;;
;;    So yeah... that much is pretty slick.  But what is incredibly dumb about the
;;  minimap is that it wastes a LOT of ROM space and CPU time.
;;
;;    Since the drawing is done with the PPU on (so you can see the map progressively being
;;  drawn onscreen as sort of a neat visual effect), all PPU writes must be performed during
;;  VBlank.  This means that the number of writes you can do is very limited... and you have
;;  to end up wasting most of your CPU time waiting for VBlank to happen.  Now most people
;;  would use that down time to decompress map tiles and get them ready to be drawn next frame
;;  but for whatever reason the game doesn't!  Instead of the simple and expected 
;;  "load, draw, load, draw" pattern which uses the rendering time to pre-load graphics
;;  for next VBlank -- this routine will actually load EIGHT rows all at once, then draw
;;  one row a frame for 8 frames ("load, load, load, load...  draw, draw, draw, draw....").
;;
;;    Now...you have to wait for a frame between draws anyway (it's required since writes have
;;  to fall in VBlank) -- but the loading can be done any time.  So it makes more sense to spread
;;  it out between draws when you're doing nothing but waiting.  But NO!  The game crams a bunch
;;  of its loading in a SINGLE frame rather than spreading it out across 8 frames.
;;
;;    This results in an EXTRA and unnecessary pause every 8 rows while the CPU is busy wasting time
;;  loading tiles.
;;
;;
;;    As for wasting space... the game doesn't use the existing map decompression routine!
;;  I still don't know why.  Instead the game has ****TWO**** of its own routines for decompressing
;;  map tiles.  TWO.  I kid you not.  This makes a total of 3 versions of the exact same routine.
;;  But I rant about that in that routine (see MinimapDecompress).
;;
;;
;;
;;    Anyway... the drawing methods here will be confusing unless you're familiar with how NES
;;  2bpp graphics are layed out.  I won't get into it here... but basically each 8x8 tile is 16 bytes...
;;  the first 8 bytes ($x0-$x7) are the low bitplane, and the next 8 ($x8-$xF) are the high bitplane.
;;  each byte in the bitplane is a row of 8 pixels (each bit of the byte is a pixel)
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



EnterMinimap:
    LDA #BANK_THIS
    STA cur_bank           ; set cur bank (required for music routine)

    LDA #$00
    STA $2001
    STA $4015              ; turn off PPU and APU
    STA $5015              ; and silence the MMC5 APU. (JIGS)

    LDA #$41               ; switch to music track $41 (crystal theme)
    STA music_track        ; 
    STA dlgmusic_backup
    
    LDA mapflags
    LSR A
    BCS @DoSmallMap
    
    LDA mapflags
    ORA #$80
    STA mapflags           ; set the "overworld zoomed in" flag
    
   @DoSmallMap: 
    JSR EnterDungeonMap    ; Set up and draw the zoomed in map!
    
    LDA mapflags           ; if its on the overworld, prepare the next screen!
    BPL @SemiExitLoop

    LDA #0
    STA mm_maprow          ; start decompression tiles from row 0 (top row)
    STA minimap_ptr+1
    STA sprindex

    JSR SetMiniMapPointers ; re-set the pointers
    JSR DoMiniMapVBlank    ; wait for VBlank    
    JSR OverworldMap_Prep  ; Loads up fully zoomed out Overworld graphics into RAM while doing normal frame work!
    
    JSR DrawPressAToZoom

   @SemiExitLoop: 
    JSR MiniMapFrame      ; do a frame... animating sprite palettes and whatnot
    LDA joy_b             
    BNE @ExitMiniMap      ; if B was pressed, exit!

    LDA joy_a             ; check if A was pressed
    BEQ @SemiExitLoop     ; if not, keep looping
    
    LDA mapflags          ; else...
    LSR A
    BCS @ExitMiniMap      ; if in a small map, exit
    
   ;; A was pressed in the zoomed in overworld map: 
   ;; First, since OverworldMap_Prep stored its sprites at $0500 instead of $0200...
    LDX #0
   @FillOAM: 
    LDA mm_spritebuf, X         ; copy it all over
    STA oam, X
    INX
    BNE @FillOAM
    
    JSR Overworld_YouAreHere    ; Load the "You are here" graphic

    LDA mapflags
    AND #$7F
    STA mapflags                ; clear the high bit from mapflags  

    LDA #$0A
    STA $2001              ; turn on BG rendering (but leave sprites disabled)
    JSR MiniMap_Draw       ; draw everything with the screen on!

   @ExitLoop:
    JSR MiniMapFrame      ; do a frame... animating sprite palettes and whatnot

    LDA joy_a
    ORA joy_b
    BEQ @ExitLoop         ; and simply loop until the user presses A or B

   @ExitMiniMap:
    ;; no idea how much of this NEEDS to be here, but it seems to keep exiting clean so far.
    LDA #$0F
    STA cur_pal
    STA cur_pal+$10          ; set the background palette to black again
    JSR ClearOAM             ; wipe OAM
    JSR DoMiniMapVBlank      ; wait for VBlank
    LDA #>oam
    STA $4014                ; do sprite DMA (clear sprites from screen)  
    JSR DrawPalette_L        ; update the palette so the background turns black
    LDA #0                   ; reset scroll to 0 (might be pointless)
    STA $2005
    STA $2005
    STA $2001
    STA $4015                ; turn off PPU and APU
    STA $5015                ; and silence the MMC5 APU. (JIGS)    
    STA joy_b                
    STA joy_select
    LDA soft2000             ; clear the sprites-as-background-tiles flag
    AND #$10
    STA soft2000
    LDA mapflags
    AND #$7F
    STA mapflags             ; clear the high bit from mapfalgs
    RTS
    
    
    
EnterDungeonMap:
    JSR ZoomMap_YouAreHere  ; Load the "You are here" graphic -- also clears OAM
    JSR MiniMap_FillNTPal   ; Clears the screen and BG CHR, loads sprite-BG CHR
    
    LDA #0
    STA mm_maprow           ; start decompression tiles from row 0 (top row)
    STA tmp+6               ; and tmp+6 will be used similarly to mm_maprow
    STA minimap_ptr+1       ; set high byte of this pointer (low byte resets to 0 elsewhere)

    JSR SetMiniMapPointers
    
    LDA mapflags         ; high bit set if its the overworld map, but zoomed in
    BPL @SmallMap
    
    LDA ow_scroll_y      ; if it IS the overworld, get the Y scroll
    SEC
    SBC #32-7            ; -7 because ow_scroll_y is already 7 off from player's actual position
    STA mm_maprow        ; and start with this map row instead
    
    LDX #0               ; 0 is the fake overworld ID
    BEQ :+
   
   @SmallMap:   
    LDX cur_map
    LDA lut_ZoomMapTilesetID, X   ; use the current map ID to index this LUT
    ASL A
    TAX
  : LDA lut_ZoomMapTilesets, X    ; the tilesets are used to convert tile IDs into pixels
    STA ZoomMapTilesetPtr         ; so that water tiles are blue, trees are green, etc.
    LDA lut_ZoomMapTilesets+1, X  ; since different map tilesets have slightly different arrangements
    STA ZoomMapTilesetPtr+1

    JSR ZoomMap_Prep              ; Fill $6000 with the BG CHR to draw
    JSR SetupMinimapScreen        ; turn on the screen and do some prep to clear sprite DMA
    JMP MiniMap_Draw              ; transfer $6000 to BG CHR one row of pixels at a time; animated!


SetupMinimapScreen:
    JSR DoMiniMapVBlank    ; wait for the normal VBlank routine
    JSR DrawPalette_L      ; update the palette
    LDA #>oam              ; and the sprites
    STA $4014
    LDA #$0A
    STA $2001              ; turn on BG rendering (but leave sprites disabled)
    
SetMinimapScroll:
    LDA soft2000           ; reset scroll to $00,$E8
    STA $2000
    LDA #$00
    STA $2005
    LDA #$E8
    STA $2005
    RTS    
    
SetMiniMapPointers:    
  ;;reading from $7000-$7FFF
    LDA #<mapdata
    STA ZoomMapPointer
    LDA #>mapdata
    STA ZoomMapPointer+1
    
  ;;writing to $6000-$6FFF
    LDA #<mm_drawbuf
    STA MiniMap_DrawBuf
    LDA #>mm_drawbuf
    STA MiniMap_DrawBuf+1
    RTS
    


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Minimap Frame  [$BD49 :: 0x27D59]
;;
;;     Does a frame for the minimap!
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; JIGS - this assumes that soft2000 has bit $10 set already
;; so it starts with using the sprite CHR as background tiles

DoMiniMapVBlank: 
    LDA $2002     
    BPL @Wait     
    LDA #0        
  @Loop:
      SEC         
      SBC #$01    
      BNE @Loop   

  @Wait:
    LDA soft2000   ; turn on the wait for NMI bit
    ORA #$80
    STA $2000     
    
    LDA #71        ; and set scanline #71 as the one to break on
    STA $5203

   @WaitForScanline71:
    LDA $5204      ; high bit set when scanline #71 is being drawn
    BPL @WaitForScanline71
    
   @Scanline71:   
    LDX #$10       ; waits for H-blank so as not to draw weird dots on the screen
  : DEX        
    BNE :-    
    LDA soft2000
    EOR #$90       ; turn off sprites-as-background-tiles, but turn on the NMI bit thing if its off
    STA $2000
    LDA #199       ; set next break at scanline #199 
    STA $5203      
    
    JSR CallMusicPlay_L 
    
  ;  LDA playtimer
  ;  AND #$02 ; change this to a 4 to make its sound like being silly on a guitar string
  ;  BEQ :+
  ;    LDA $4000
  ;    AND #$F3
  ;    STA $4000
  ;    LDA $5000
  ;    AND #$F3
  ;    STA $5000
  ;    LDA CHAN_SQ3 + ch_freq+1
  ;    STA $5003                  ; output frequency      
  ;    JMP @WaitForScanline199
  ; :  LDA $4004
  ;    AND #$F3
  ;    STA $4004
  ;    LDA $5004
  ;    AND #$F3
  ;    STA $5004
  ;    LDA CHAN_SQ4 + ch_freq+1
  ;    STA $5007                  ; output frequency   
;; this dumb thing makes the Prelude have like a phaser effect... leaving it in for fun.
;; since I had fun playing around with it.
    
    ;; now there's nothing to do but wait, so while the screen draws
    ;; spend 16 or so scanlines updating the music 
    ;; this might be stupid risky
    ;; but vblank has more important things to be doing!
   
  @WaitForScanline199:
    LDA $5204      ; high bit set when scanline #199 is being drawn
    BPL @WaitForScanline199
    
   @Scanline199:   
    LDX #$10   
  : DEX        
    BNE :-    
    LDA soft2000         ; still has bit $10 set, so will set sprite CHR as background tiles again
    ORA #$80             ; turn on the NMI bit again just in case...
    STA $2000
    LDA #$00             ; and clear the scanline break register
    STA $5203      
   @LoopForever: 
    JMP @LoopForever     ; then loop forever! (or really until the NMI is triggered)
    


MiniMapFrame:
    JSR DoMiniMapVBlank
    LDA #>oam              ; Sprite DMA
    STA $4014

    JSR DrawPalette_L      ; draw the palette
    LDA #$1E               ; turn PPU on
    STA $2001
    
    JSR SetMinimapScroll
    ;JSR CallMusicPlay_L    ; keep the music playing
    ;; at this point, the next frame may have started, so its important
    ;; that soft2000 has the sprites-as-background-tiles bit set before the screen is turned on
    ;; (not that if CallMusicPlay is not done here, its probably NOT started on the next frame!)

    LDA #0
    STA joy_a              ; clear A and B button catchers
    STA joy_b
    JSR UpdateJoy_L        ; then update joypad data

    INC framecounter       ; inc the frame counter

    LDA framecounter
    AND #$08               ; use bit 3 of frame counter to toggle between
    BNE :+
      LDA #$30             ; $37 (tan color)
:   EOR #$07               ; and $0F (black)  every 8 frames
    STA cur_pal+$11        ; this is the color for the "you are here" sprite

    LDA framecounter       ; use bits 4,5 of frame counter
    AND #$30               ; to cycle between $00,$10,$20,$0F
    CMP #$30               ;  changing color every 16 frames
    BNE :+
      LDA #$0F
:   STA cur_pal+$12        ; this is the color for the town/dungeon marker sprites

    RTS                    ; and exit!


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Minimap Draw Rows  [$BD91 :: 0x27DA1]
;;
;;    Draws 8 preloaded rows of pixels to the PPU pattern tables.
;;  Each row is drawn in its own VBlank, so the drawing happens progressively.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


MiniMap_Draw:
    LDA #<mm_drawbuf
    STA MiniMap_DrawBuf
    LDA #>mm_drawbuf
    STA MiniMap_DrawBuf+1    ; reset this pointer to the start of its data
    
    LDA #0
    STA minimap_ptr+1        ; reset the high byte of this pointer too
    
PressAToZoom_Entry:
   @0100_Loop:               ; this loop happens every $0100 bytes
    LDA #0
    STA mm_pixrow            ; start drawing pixel row 0, increment by 1 row each loop

    @MainLoop:
        JSR DoMiniMapVBlank ; wait for Vblank before drawing anything
       
        LDX mm_pixrow        ; put row in X -- X will be the loop up counter and source index
      @RowLoop:
        LDA minimap_ptr+1    ; set PPU address, with mm_pixrow being the low byte
        STA $2006
        STX $2006
        
        TXA                  ; use mm_pixrow as the Y offset  
        TAY                  ; MiniMap_DrawBuf is not incremented by the low byte
        LDA (MiniMap_DrawBuf), Y
        STA $2007            ; and draw it
        
        TXA
        CLC
        ADC #$08             ; add 8 to the index (moves to high bitplane if we're on the low bitplane
        TAX                  ;  (or to low plane of next tile if on high plane.  Does not change rows)
        BCC @RowLoop         ; keep looping until X wraps ($20 interations -- $10 tiles)

    LDA soft2000          ; drawing for this row is done -- reset the scroll
    STA $2000
    LDA #$00
    STA $2005
    LDA #$E8
    STA $2005

    ; JSR Minimap_DrawSFX   ; play the ugly drawing sound effect
    ;; JIGS : STOP IT.

    LDA mm_pixrow         ; add 1 to our row counter
    CLC                   ; and mask low bits (0-7)
    ADC #1
    AND #$07
    STA mm_pixrow
    BNE @MainLoop         ; once it wraps 7->0, we've drawn 8 rows, so now...
    
    INC MiniMap_DrawBuf+1 ; increment the high byte of mm_drawbuf
    INC minimap_ptr+1     ; as well as the the destination to draw to
    LDA minimap_ptr+1     
    CMP #$0F              ; now see if its $0F
    BCC @0100_Loop        ; if not, do another $100 writes
    CMP #$10              ; see if its $10
    BNE :+                ; if not, jump ahead
       RTS                ; if it is, everything's drawn! so exit
    
  : LDA mapflags          ; get the map flag and see if its on the overworld and zoomed in 
    BPL @0100_Loop        ; if not, keep looping
    
    RTS 
    
    ;; But aha! Its row $0F on the zoomed in overworld: This needs to draw the text "_Press A to Zoom in_"
    ;; so overwrite the mm_drawbuf pointer with new data:
  ;  LDA #<lut_ZoomMinimapTextCHR
  ;  STA MiniMap_DrawBuf
  ;  LDA #>lut_ZoomMinimapTextCHR
  ;  STA MiniMap_DrawBuf+1    
  ;  JMP @0100_Loop


DrawPressAToZoom:
    LDA #<lut_ZoomMinimapTextCHR
    STA MiniMap_DrawBuf    
    LDA #>lut_ZoomMinimapTextCHR
    STA MiniMap_DrawBuf+1    
    
    LDA #$0F                     ; set the high byte of the pointer to the last row
    STA minimap_ptr+1
    LDA #$1E
    STA $2001                    ; and enable sprites
    JSR DoMiniMapVBlank
    LDA #>oam                    ; Do the sprite thing
    STA $4014    
    JMP PressAToZoom_Entry


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Minimap Prep Row  [$BDE7 :: 0x27DF7]
;;
;;    Decompresses two rows of map data, and 'merges' them into 1 row of
;;  pixels.  The pixels are dumped into the intermediate buffer 'mm_drawbuf'.
;;  Also, dungeon marker sprites are generated for tiles which require them
;;  in this routine.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;




;; MinimapDecompress takes about 56 scanlines to decompress 2 rows.
;; It takes 5 scanlines to do 1 @MainLoop
;; 16 @MainLoops will be 80 scanlines
;; Music takes at least 16 scanlines
;; The screen must break on scanlines 71 and 199
;; So the order of logic is:
;; Decompress the map rows during the title drawing
;; Wait for the first scanline break at 71
;; Do the 16 @MainLoops, then wait for scanline 199
;; Wait for VBlank to start, do music


OverworldMap_Prep:
    LDA #0                     ; reset low byte of PPU addr to 0
    STA minimap_ptr

OverworldMapPrep_VBlank: 
    LDA #71                   ; and set scanline #71 as the one to break on
    STA $5203

MiniMap_2Rows:
    JSR LongCall
    .word MinimapDecompress    ; decompress 2 rows of map data
    .byte BANK_OWMAP
    
    LDY #0                     ; Y will be the x coord (column) counter
    STY tmp                    ;; JIGS - tmp is used as a backup for Y     

   @Wait:
    LDA $5204      ; high bit set when scanline #71 is being drawn
    BPL @Wait
    
   @Scanline71:   
    LDX #$10       ; waits for H-blank so as not to draw weird dots on the screen
  : DEX        
    BNE :-    
    LDA soft2000
    AND #~$10      ; turn off sprites-as-background-tiles
    STA $2000
    LDA #199       ; set next break at scanline #199 
    STA $5203      

  @MainLoop:        ; tmp+7 is a counter to keep track of the number of bits
    LDY tmp         ;  that have yet to be shifted into the output CHR bytes
    LDA #8          ; since each byte is actually 8 pixels on a bitplane... multiple pixels          
    STA tmp+7       ; must be rotated into the same byte to be output as graphics.7    

  @RotateLoop:
    LDX mm_mapbuf, Y            ; here we get the minimap tileset data for 4 seperate
    LDA lut_MinimapTileset, X   ; map tiles (in a 2x2 square) and OR them together to combine
    LDX mm_mapbuf+1, Y          ; them to a single pixel.
    ORA lut_MinimapTileset, X   ;  This scales the map down from 256x256 tiles
    LDX mm_mapbuf2, Y           ;  to 128x128 pixels
    ORA lut_MinimapTileset, X
    LDX mm_mapbuf2+1, Y         ; after all this, A contains the output pixel (low 2 bits)
    ORA lut_MinimapTileset, X   ;  and bit 2 indicates whether or not a marker sprite needs to be placed here

    LSR A                       ; shift out low bit
    ROL mm_bplo                 ; rotate it into the low bitplane

    LSR A                       ; shift out the high bit
    ROL mm_bphi                 ; rotate into high bitplane

    LSR A                       ; shift out marker sprite flag
    BCC :+                      ; if set....
      JSR DrawOverworldSprite   ; ... generate a dungeon marker sprite

  : INY                         ; increment our X coord by 2
    INY                         
    DEC tmp+7                   ; decrement our bit counter
    BNE @RotateLoop             ; if more bits needed to fill our bitplanes... keep going

    ; @RotateLoop exits when 8 pixels have been shifted into both high and low
    ; bitplanes.
    STY tmp                    ; JIGS - backup Y - original code used X, but not these kinds of pointers!
    LDY minimap_ptr            ; use low byte of dest pointer as index for draw buffer

    LDA mm_bplo                ; copy both bitplanes to the appropriate areas of the buffer
    STA (MiniMap_DrawBuf), Y
    TYA
    CLC
    ADC #$08                   ; increment destination by 8
    TAY
    LDA mm_bphi
    STA (MiniMap_DrawBuf), Y
    TYA
    CLC
    ADC #$08                   ; and then another 8
    STA minimap_ptr            ; backing up the pointer
    BCC @MainLoop              ; if there was no carry, keep looping
    ; otherwise, if there was carry, we have completed a single row from 16 tiles (128 pixels)  
    
    INC mm_maprow              ; increment map row counter by 2
    INC mm_maprow

  @WaitForNext:
    LDA $5204      ; high bit set when scanline #199 is being drawn
    BPL @WaitForNext
    
  @Scanline199:   
    LDX #$10   
  : DEX        
    BNE :-    
    LDA soft2000         ; still has bit $10 set, so will set sprite CHR as background tiles again
    STA $2000
    LDA #$00             ; and clear the scanline break register
    STA $5203      

    LDA minimap_ptr            ; increment dest PPU address by 1 (next row of pixels)
    CLC
    ADC #1
    AND #$07                   ; and mask with 7 (0-7)
    STA minimap_ptr
    BEQ :+
       JSR WaitForVBlank_L
       JSR CallMusicPlay_L 
       JMP OverworldMapPrep_VBlank
    ;BNE MiniMap_2Rows          ; once it wraps from 7->0, we've filled 256 bytes of graphic data (8 rows of pixels)                         

  : INC MiniMap_DrawBuf+1      ; increment high byte of source
    INC minimap_ptr+1          ; increment high byte of PPU dest
    LDA minimap_ptr+1
    CMP #>$1000                ; see if the high byte is #$10
    BEQ :+
       JSR WaitForVBlank_L
       JSR CallMusicPlay_L     
       JMP OverworldMap_Prep      ; if not, do another $100 bytes
  : RTS



;; so while the overworld minimap compresses 4 tiles into 1 pixel...
;; this has to expand 1 tile into 4 pixels.
;; these are ALMOST the same routine, but completely different!

ZoomMap_Prep:
    LDA #0                     ; reset low byte of PPU addr to 0
    STA minimap_ptr

   @ZoomMap_PrepRow:
    LDA mapflags
    BPL :+

    JSR LongCall
    .word MinimapDecompress    ; decompress 2 rows of map data
    .byte BANK_OWMAP      

    LDA ow_scroll_x
    SEC
    SBC #32-7                  ; player's position is -7, but tiles start 32 to the left of the player
    STA ZoomMapPointer         ; save as low byte
    LDA #>mm_mapbuf            ; and use the map buffer instead of map data!
    STA ZoomMapPointer+1
 
  : LDA #0                     ; set here, in case MinimapDecompress used it
    STA tmp+1                  ; tmp+1 is used for sprite drawing

   @MainLoop:
    LDA #4                     ; this counter is only 4 instead of 8
    STA tmp+7
    
   @RotateLoop:
    INC tmp+1                   ; increment the tile-in-row counter
    LDY #0
    LDA (ZoomMapPointer), Y     ; get the tile from mapdata ($7000)
    TAY
    LDA (ZoomMapTilesetPtr), Y  ; get the bit plane info from this LUT
    PHA                         ; backup to stack
    AND #$03                    ; get only the low 2 bits (cut off the "this is a sprite) bit
    STA tmp                     ; and save them 
    PLA                         ; pull the original
    ASL A                       ; shift the bits left twice, then ORA with the 2 low bits
    ASL A                       ; this doubles the amount of pixel bits without needing
    ORA tmp                     ; to complicate the tileset data!
    
    ;; taking out the PHA, AND #$03, STA tmp, PLA instructions...
    ;; will result in tiles marked with 4 and 6 drawing stripes!
    
    LSR A                       ; now right shift it out
    ROL mm_bplo                 ; and into the low bit plane
    LSR A
    ROL mm_bphi                 ; then into the high bit plane
    LSR A
    ROL mm_bplo                 ; do the same with the next 2 bits
    LSR A
    ROL mm_bphi                  
    LSR A
    BCC :+
        JSR DrawZoomSprite
  : INC ZoomMapPointer          ; increment the source address
    BNE :+
       INC ZoomMapPointer+1     ; and high byte when the low byte wraps
  : DEC tmp+7
    BNE @RotateLoop  

    LDY minimap_ptr
    LDA mm_bplo
    STA (MiniMap_DrawBuf), Y     ; double the bit planes in the draw buffer
    INY                          ; INC Y and 
    STA (MiniMap_DrawBuf), Y     ; do the next one
    TYA
    CLC 
    ADC #07                      ; add 7, then back into Y
    TAY
    LDA mm_bphi
    STA (MiniMap_DrawBuf), Y     ; two more writes...
    INY
    STA (MiniMap_DrawBuf), Y      
    TYA
    CLC
    ADC #07                      ; add another 7 (+INY) then back it up
    STA minimap_ptr
    BCC @MainLoop                ; if there was no carry, keep looping
    ; otherwise, if there was carry, we have completed a single row from 16 tiles (128 pixels)
    
    INC mm_maprow                ; increment map row counter by 1
    INC tmp+6                    ; along with the non-offset row counter for sprite locations

    LDA minimap_ptr              ; increment dest PPU address by 2 (next NEXT row of pixels)
    CLC
    ADC #2
    AND #$07                     ; and mask with 7 (0-7)
    STA minimap_ptr
    BNE @ZoomMap_PrepRow         ; once it wraps from 7->0, we've filled 256 bytes of graphic data (8 rows of pixels)

    INC MiniMap_DrawBuf+1        ; increment high byte of source
    INC minimap_ptr+1            ; increment high byte of PPU dest
    LDA minimap_ptr+1
    CMP #>$1000
    BEQ @Done
        JMP ZoomMap_Prep             ; loop until PPU dest=$1000 (filling entire left pattern table)
   @Done:  
    RTS












  

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Minimap - Draw "You Are Here" sprite [$BF34 :: 0x27F44]
;;
;;     Clears OAM and draws the "you are here" marker sprite
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


Overworld_YouAreHere:
;    LDX #0
;    STX sprindex      ; clear the sprite index
;
;    LDA #$F8          ; flood OAM with $F8 (to clear it -- moves all sprites offscreen, making them invisible)
;   @Loop:
;      STA oam, X
;      INX
;      BNE @Loop       ; $100 iterations (all of OAM)

    LDA #$82
    STA oam+1         ; "you are here" sprite for the full overworld uses tile $82
    
    LDA #0
    STA oam+2         ; set sprite attributes (palette 0, no flipping, foreground priority)  

    LDA ow_scroll_x   ; get scroll X
    CLC
    ADC #$07          ; add 7 to get player position
    LSR A             ; divide that by 2 to scale to minimap (world map is 256x256 -- minimap is 128x128)
    CLC
    ADC #$3D          ; add $3D to offset it so it starts at the start of the map
    STA oam+3, X      ; record as X coord

    LDA ow_scroll_y   ; do the same to get Y coord
    CLC
    ADC #$07
    LSR A
    CLC
    ADC #$44          ; and add more since the map is lower than the in the original game
    STA oam+0         ; record as Y coord
    RTS               ; and exit!

ZoomMap_YouAreHere:
    LDX #0
    STX sprindex      ; clear the sprite index

    LDA #$F8          ; flood OAM with $F8 (to clear it -- moves all sprites offscreen, making them invisible)
   @Loop:
      STA oam, X
      INX
      BNE @Loop       ; $100 iterations (all of OAM)
      
    ;; X = 0
    STX oam+2         ; set sprite attributes (palette 0, no flipping, foreground priority)        

    LDA #$80
    STA oam+1         ; "you are here" sprite for zoomed in minimap uses tile $80

    LDA mapflags
    BMI @OverworldZoom

    LDA sm_scroll_x   ; get scroll X
    CLC
    ADC #$07          ; add 7 to get player position
    ASL A             ; divide that by 2 to scale to minimap (world map is 256x256 -- minimap is 128x128)
    CLC
    ADC #$3D          ; add $3D to offset it so it starts at the start of the map
    STA oam+3         ; record as X coord

    LDA sm_scroll_y   ; do the same to get Y coord
    CLC
    ADC #$07
    ASL A
    CLC
    ADC #$44          ; but add a little less ($34 instead of $3D)
    STA oam+0         ; record as Y coord
    RTS               ; and exit!
    
   @OverworldZoom:    ; simply put it over the center where the player will be
    LDA #127-2
    STA oam+3, X      ; record as X coord

    LDA #127+5
    STA oam+0         ; record as Y coord
    RTS


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Draw Dungeon Sprite  [$BE30 :: 0x27E40]
;;
;;    Draws a town/dungeon marker sprite at given coords
;;
;;  IN:  mm_maprow = y coord on world map
;;               Y = x coord on world map
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; JIGS - this saves to another sprite buffer first, then copies to OAM later

DrawOverworldSprite:
    LDA sprindex          ; Add 4 to the sprite index (drawing a single sprite -- 4 bytes)
    CLC                   ;  do this before drawing the sprite to leave sprite 0 alone
    ADC #$04              ;  since that is the party position sprite
    STA sprindex
    TAX                   ; put sprite index in X for indexing

    LDA mm_maprow         ; get Y coord
    LSR A                 ; divide by 2 (minimap display is 128x128 -- world map is 256x256)
    CLC
    ADC #$44              ; add $34 to offset the sprite to the start of the map on the screen
    STA mm_spritebuf, X   ; write this as Y coord of sprite

    LDA #$83
    STA mm_spritebuf+1, X ; use tile $81

    LDA #$00
    STA mm_spritebuf+2, X ; attributes (palette 0, no flipping, foreground priority)

    TYA                   ; get the X coord
    LSR A                 ; divide by 2 for same reason
    CLC
    ADC #$3D              ; add $3D to offset it to start of the map
    STA mm_spritebuf+3, X ; write as X coord

    RTS                   ; done!


DrawZoomSprite:
    LDA tmp+6        ; does this sprite show up where the "Press A to zoom out" text cuts off the map?
    CMP #60          ; if so, don't draw it!
    BCS @RTS

    LDA sprindex     ; Add 4 to the sprite index (drawing a single sprite -- 4 bytes)
    CLC              ;  do this before drawing the sprite to leave sprite 0 alone
    ADC #$04         ;  since that is the party position sprite
    STA sprindex
    TAX              ; put sprite index in X for indexing

   @NormalZoom:
    LDA tmp+6        ; get Y coord - 0-64
    ASL A            ; double it
    CLC
    ADC #$44         ; add $34 to offset the sprite to the start of the map on the screen
    STA oam, X       ; write this as Y coord of sprite

    LDA #$81
    STA oam+1, X     ; use tile $81

    LDA #$00
    STA oam+2, X     ; attributes (palette 0, no flipping, foreground priority)

    LDA tmp+1        ; get tile in the row, 0-64
    ASL A            ; multiply by 2
    CLC
    ADC #$3B         ; add $3D to offset it to start of the map
    STA oam+3, X     ; write as X coord

   @RTS:
    RTS              ; done!




;; This mess of a routine sets up the whole minimap screen.
;; First it fills the nametable with the necessary data:
;; * the Final Fantasy title    
;; * the top of the map's paper borders (which use sprite CHR as background tiles)
;; * all the blank rows in between
;; * the box in the center that wholes the whole BG CHR
;; * the bottom of the map's paper borders (again, sprite CHR)
;; * then fills up the attributes
;; * wipes BG CHR so it can be drawn to while the screen is on
;; * loads the palettes, based on map ID
;; * loads the sprite CHR 
;; * clear the zoomed out overworld's OAM buffer
;; * maybe something else I forgot
;; and it seems like every other step it has to check if its doing
;; the original overworld, the zoomed-in overworld, or a small 64*64 tile map!

EightWrites:
    LDY #8

DoWrites:
    STA $2007
    DEY
    BNE DoWrites
    RTS

MiniMap_FillNTPal:
    LDA #$08           ; write to soft2000 to clear NT scroll
    STA soft2000
    ASL A
    STA tmp            ; $10 is loop counter for the map tiles
    
    LDA mapflags
    LSR A
    BCS :+
      LDA #$FF
      BNE @SetFillTile ; if doing the overworld, use $FF as fill value
   
    ; otherwise, get the fill value from this LUT.
    ; this is because, while most maps have the bottom right 4 tiles blank
    ; some of them don't, and will fill the whole screen with whatever pixels it draws there
  : LDX cur_map   
    LDA lut_MapTilesetFillTile, X
    
   @SetFillTile:
    STA tmp+1

   ; 
   ; draw the NT data at lut_MinimapNT
   ;

    LDA $2002          ; reset PPU toggle
    LDA #>$2000        ; set PPU address to $2000  (start of nametables)
    STA $2006
    LDX #<$2000
    STX $2006

    LDY #$20
    LDA #$84           ; the 84th tile in the sprite CHR should be filled with black 
    JSR DoWrites
    
    ;; do the title from this lut
    
    LDX #0
   @Title:
    LDA lut_MinimapTitle, X
    STA $2007
    INX
    CPX #$80
    BNE @Title
    
    LDY #$20
    LDA #$84           ; the 84th tile in the sprite CHR should be filled with black 
    JSR DoWrites    

    ;; now the edge of the map page, which is just 0-40 in sequence

    LDX #0
   @MapTopLoop:
    STX $2007
    INX
    CPX #$40
    BNE @MapTopLoop
   
    LDX #0
   @ZoomMapLoop:             ; fill middle of nametable with $0-$FF in sequence
    LDA tmp+1
    JSR EightWrites          ; with both the sides being 8 filltiles in a row
    
   @ZoomMap_InnerLoop:
    STX $2007
    INX
    TXA
    AND #$0F
    BNE @ZoomMap_InnerLoop
    
    LDA tmp+1
    JSR EightWrites
    DEC tmp                  ; decrement the row counter for this part
    BNE @ZoomMapLoop
    
    LDX #$40                 ; then 40-80 in sequence are the bottom of the map page
   @MapBottomLoop:
    STX $2007
    INX
    CPX #$80
    BNE @MapBottomLoop    

    LDY #$80
    LDA #$84
    JSR DoWrites
    
    ;; should be on the attribute table now

    LDY #$08
    LDA #0
    JSR DoWrites
    LDY #$08
    LDA #$A0
    JSR DoWrites    
    LDY #$20
    LDA #$55 
    JSR DoWrites
    LDY #$08
    LDA #$0A
    JSR DoWrites
    LDY #$08
    LDA #0
    JSR DoWrites    
    
   ;
   ; clear the BG pattern table
   ;

    LDA $2002           ; reset PPU toggle
    LDA #>$0000         ; set PPU address to $0000 (start of BG pattern table)
    STA $2006
    LDA #<$0000
    STA $2006

    ;; since the overworld doesn't use the background color, but the dungeon maps do,
    ;; the BG pattern table needs to be filled with 8 $FFs, then 8 $0s
    ;; so tmp is set to either $FF or $0

    LDA mapflags
    ASL A
    BCC @FillDungeon
        LDA #$FF
        BMI :+

   @FillDungeon:
    LDA #0
  : STA tmp
  
    LDX #$00                 ; X is row counter
   @ClearCHRLoop_Start: 
    LDA tmp
    JSR EightWrites
    LDA #0
    JSR EightWrites
    DEX
    BNE @ClearCHRLoop_Start  ; $1000 iterations (full BG pattern table)

   ;
   ; load CHR for sprites ("you are here" mark, and town/dungeon points)
   ;

    LDA #<lut_NewMinimapCHR
    STA tmp
    LDA #>lut_NewMinimapCHR
    STA tmp+1
    LDA #$10
    LDX #11
    JSR CHRLoadToA
    ;; that loads up the map edges and sprite thingies

   ;
   ; load BG palettes for this screen
   ;

    LDA mapflags
    BPL @GetMapPal
    
   @ZoomOverworldPalette:    
    LDX #0
    BEQ @LoadMapPal

   @GetMapPal:    
    LDX cur_map
    LDA lut_MapTilesetPalette, X
    ASL A
    TAX
    
   @LoadMapPal: 
    LDA lut_ZoomMapPalettes, X
    STA tmp
    LDA lut_ZoomMapPalettes+1, X
    STA tmp+1
    
    LDY #$0C
   @PalLoop:
    LDA (tmp), Y          ; copy color from LUT
    STA cur_pal, Y        ;  to palette
    DEY
    BPL @PalLoop          ; loop until X wraps ($10 iterations)

    LDA cur_pal           ; copy the background color to the mirrored copy in the sprite palette
    STA cur_pal+$10       ;  this ensures the BG color will be what's desired when the palette is drawn

    LDA #$0F
    STA cur_pal+$11       ; start the "you are here" sprite
    STA cur_pal+$12       ;  and the town/dungeon marker sprite at $0F black

    LDX #0
    LDA #$F8
   @ClearOAMBuffer: 
    STA mm_spritebuf, X
    INX
    BNE @ClearOAMBuffer

   ;
   ;  Do last minute PPU stuff before exiting
   ;

    LDA soft2000
    ORA #$10              ; start each VBlank with sprites as the background
    STA soft2000

    LDA #$00              ; set scroll 
    STA $2005             
    LDA #$E8
    STA $2005             
    RTS                   ; then exit!



.byte "END OF BANK STORY/PUZZLE (09)"