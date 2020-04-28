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
.import CallMinimapDecompress, CallMusicPlay_L
.import lut_MinimapSprCHR, lut_MinimapBGPal, CHRLoad
.import LongCall
.import DrawComplexString

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
    JMP TheEnd_EndVblank
    
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

    JSR ClearOAM_BankD       ; clear OAM
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

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  ClearOAM_BankD   [$AFAB, 0x36FBB]
;;
;;    This is simply a copy of the ClearOAM routine found in the fixed bank.
;;  It doesn't really need to be duplicated here since it could just call the main ClearOAM routine.
;;  My guess is there were assembler limitations that made it difficult to export routines so that they
;;  were visible in other banks (hence all the "_L" versions of routines).  Obviously today we don't
;;  have these limitations... so this seems kind of wasteful.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

ClearOAM_BankD:
    LDX #0
    STX sprindex
    LDA #$F8

  @Loop:
      STA oam, X
      INX
      BNE @Loop

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
    JSR ClearOAM_BankD     ; clear OAM

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
;.byte $1E,$1F,$00,$00,$00,$00,$1A,$1B 
.byte $1E,$1F,$00,$00,$00,$00,$1A,$1B
.byte $1E,$1F,$00,$00,$00,$00,$1A,$1B 
.byte $1E,$1F,$00,$00,$00,$00,$1A,$1B
.BYTE $3C,$3D,$1C,$1C,$1C,$1C,$3A,$3B 
.BYTE $4C,$4D,$1D,$1D,$1D,$1D,$4A,$4B



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Minimap NT LUT  [$B000 :: 0x27010]
;;
;;    This LUT contains the full name and attribute table for the minimap
;;  It is copied in full to the nametables when the minimap is drawn.

lut_MinimapNT:
.INCBIN "bin/minimap_nt.nam"


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Minimap BG CHR  [$B400 :: 0x27410]
;;
;;    This is the CHR for the non-map BG graphics for the minimap
;;  Due to the way it's loaded, each of these blocks must be aligned
;;  on a $100 byte page


  .ALIGN $100
chr_MinimapDecor:
  .INCBIN "chr/minimap_decor.chr"


  .ALIGN $100
chr_MinimapTitle:
  .INCBIN "chr/minimap_title.chr"


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Minimap Draw Title CHR  [$BB00 :: 0x27B10]
;;
;;    Progressively draws the title CHR for the minimap
;;  This drawing is done progressively while the PPU is on so that
;;  tiles appear to gradually fill the screen.
;;
;;    Because it's done when PPU is on, it must be done in VBlank.  Which
;;  means it needs to be reasonably fast... and you can't do too much at once.
;;  The game spreads the job out over 16 frames, drawing 1 byte of each tile's
;;  CHR each frame.  ($28 bytes drawn per frame).
;;
;;    CHR must have already been preloaded and prearranged so that this
;;  routine can simply load and draw it without having to do heavy computations.
;;  See Minimap_PrepTitleCHR for how that's accomplished.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

Minimap_DrawTitleCHR:
    LDA #<mm_titlechr
    STA minimap_ptr
    LDA #>mm_titlechr
    STA minimap_ptr+1        ; load up the pointer to our pre-loaded CHR

    LDX #0                   ; X will be our frame counter.  We will spread this drawing
                             ;  out over 16 frames

  @FrameLoop:
    JSR WaitForVBlank_L      ; wait for VBlank
    LDY #0                   ; Y will be loop counter/index

    @SmallLoop:
      LDA lut_MinimapTitleCHRDest_hi, Y  ; load up the destination PPU address for this
      STA $2006                          ;  tile of the title graphic
      LDA lut_MinimapTitleCHRDest_lo, Y  ; get low byte as well
      CLC
      ADC lut_MinimapBitplane, X         ; and add bitplane/row info to low byte
      STA $2006                          ;  before writing it

      LDA (minimap_ptr), Y   ; get the preloaded CHR data
      STA $2007              ; and draw it

      INY                    ; inc loop counter/index
      CPY #$28
      BCC @SmallLoop         ; and keep looping until a single bitplane row has been drawn for $28 tiles

    LDA minimap_ptr          ; add $28 to our source pointer
    CLC                      ;   so that we load the next chunk of graphic data
    ADC #$28
    STA minimap_ptr
    LDA minimap_ptr+1
    ADC #0
    STA minimap_ptr+1

    LDA soft2000             ; reset the scroll
    STA $2000
    LDA #$00
    STA $2005
    LDA #$E8
    STA $2005

    ;JSR Minimap_DrawSFX       ; play ugly drawing sound effect
    ;; JIGS - please no
    INX
    CPX #16                   ; increment the frame loop counter
    BCC @FrameLoop            ; and loop until we do 16 frames (8 rows, 2 bitplanes per row = full tile)

    RTS                       ; then exit





;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Minimap - Prep Title CHR  [$BB4E :: 0x27B5E]
;;
;;    Exact same idea as Minimap_PrepDecorCHR (see that routine for details)
;;
;;    The loop in this routine is constructed a bit differently because it needs
;;  to copy only $280 bytes instead of $300.  Other than that (and using a different
;;  src/dest buffers), the routines are identical
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


Minimap_PrepTitleCHR:
    LDA #<mm_titlechr
    STA tmp+2
    LDA #>mm_titlechr
    STA tmp+3            ; set (tmp+2) to point to our dest buffer

    LDX #0               ; X will be outer loop counter
    LDY #0               ; Y must stay at zero for indexing
  @OuterLoop:
    LDA lut_MinimapBitplane, X
    STA tmp                  ; set (tmp) to point to our source buffer
    LDA #>chr_MinimapTitle   ; and offset it by current row/bitplane
    STA tmp+1

    @InnerLoop:
      LDA (tmp), Y       ; copy a byte from source to dest
      STA (tmp+2), Y

      INC tmp+2          ; inc dest pointer
      BNE :+
        INC tmp+3

  :   LDA tmp            ; add $10 to low byte of source pointer
      CLC                ;  to have it look at the next tile
      ADC #$10
      STA tmp
      BCS @IncHigh       ; if it had carry, inc high byte of pointer

      BPL @InnerLoop     ; if result of low byte is positive ($00-$70) keep looping

      LDA tmp+1
      CMP #>(chr_MinimapTitle + $280)  ; otherwise (low byte is >= $80), check to see if high byte
                                       ; is at the end of our source buffer
      BCC @InnerLoop        ;  if not.. keep looping
      BCS @ExitInnerLoop    ;  if yes... break out of inner loop (always branches)

    @IncHigh:
      INC tmp+1          ; inc high byte of source pointer
      BNE @InnerLoop     ; and keep looping (always branches)

  @ExitInnerLoop:
    INX                  ; increment row/bitplane counter
    CPX #$10             ; and keep looping until we do all $10 of them
    BCC @OuterLoop

    RTS                  ; then exit!

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Minimap Title CHR Dest LUT  [$BB8A :: 0x27B9A]
;;
;;    There are $28 tiles that make up the "Final Fantasy" title that is displayed
;;  in the minimap.  These tiles (along with those for the dragon graphic thing)
;;  are scattered around in the pattern table so as to not interefere with the map's CHR.
;;
;;    These LUTs tell where the game is supposed to put each of those $28 tiles in
;;  the pattern tables.  Each entry is the desired tile ID of each graphic left
;;  shift 4 (to make it a CHR address).  One table has the low byte and the other
;;  has the high byte.

lut_MinimapTitleCHRDest_lo:
  .BYTE <$0160,<$0260,<$02F0,<$0400, <$0450,<$0480,<$0490,<$0500
  .BYTE <$0540,<$0550,<$0560,<$0570, <$0580,<$0590,<$0600,<$0610
  .BYTE <$0640,<$0650,<$0660,<$0670, <$0680,<$0690,<$06A0,<$07B0
  .BYTE <$07C0,<$07F0,<$08F0,<$0900, <$0910,<$0A00,<$0A70,<$0AA0
  .BYTE <$0B00,<$0B80,<$0B90,<$0BA0, <$0C00,<$0C20,<$0C90,<$0EF0

lut_MinimapTitleCHRDest_hi:
  .BYTE >$0160,>$0260,>$02F0,>$0400, >$0450,>$0480,>$0490,>$0500
  .BYTE >$0540,>$0550,>$0560,>$0570, >$0580,>$0590,>$0600,>$0610
  .BYTE >$0640,>$0650,>$0660,>$0670, >$0680,>$0690,>$06A0,>$07B0
  .BYTE >$07C0,>$07F0,>$08F0,>$0900, >$0910,>$0A00,>$0A70,>$0AA0
  .BYTE >$0B00,>$0B80,>$0B90,>$0BA0, >$0C00,>$0C20,>$0C90,>$0EF0



;; unused

;  .BYTE $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
;  .BYTE $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
;  .BYTE $FF,$FF,$FF,$FF,$6D,$76

;; JIGS  ^ 


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
    STA $5015           ; and silence the MMC5 APU. (JIGS)

    ;;LDA #$41               ; switch to music track $41 (crystal theme)
    LDA #$51
    ;; JIGS - since the menu theme isn't used, why not use it here! 
    STA music_track        ;   but it's not heard until after all drawing is complete (music routine isn't called)
    STA dlgmusic_backup

    JSR Minimap_PrepDecorCHR   ; Load decoration CHR to RAM (those dragon graphic things)
    JSR Minimap_PrepTitleCHR   ; And the "Final Fantasy" title text
    JSR Minimap_YouAreHere     ; Load the "You are here" graphic -- clear OAM, and draw the "you are here" sprite
    JSR Minimap_FillNTPal      ; Fill the nametable and palettes

    LDA #0
    STA mm_maprow          ; start decompression tiles from row 0 (top row)

    LDA #>$0000            ; set high byte of dest PPU addr.
    STA minimap_ptr+1

  @MainLoop:
    LDA #0                 ; reset low byte of PPU addr to 0
    STA minimap_ptr

    @InnerLoop:            ;   Inner loop is run 8 times -- each time loads a single row of pixels
      JSR Minimap_PrepRow  ; Load a single row of 128 pixels from 2 rows of map data

      INC mm_maprow        ; increment map row counter by 2
      INC mm_maprow

      LDA minimap_ptr      ; increment dest PPU address by 1 (next row of pixels)
      CLC
      ADC #1
      AND #$07             ; and mask with 7 (0-7)
      STA minimap_ptr
      BNE @InnerLoop       ; once it wraps from 7->0, we've filled 256 bytes of graphic data (8 rows of pixels)

    JSR Minimap_DrawRows       ; draw those 8 rows of pixels
    INC minimap_ptr+1          ; increment high byte of PPU dest

    LDA minimap_ptr+1
    CMP #>$1000
    BNE @MainLoop              ; loop until PPU dest=$1000 (filling entire left pattern table)

      ;  now map drawing is done

    JSR Minimap_DrawDecorCHR   ; draw the dragon decorations (previously loaded)
    JSR Minimap_DrawTitleCHR   ; and the "Final Fantasy" title graphics (also previously loaded)


  @ExitLoop:
    JSR MinimapFrame      ; do a frame... animating sprite palettes and whatnot

    LDA joy_a
    ORA joy_b
    BEQ @ExitLoop         ; and simply loop until the user presses A or B

    RTS                   ; at which point... exit!

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Minimap Draw Decorative CHR  [$BC55 :: 0x27C65]
;;
;;    EXACTLY the same as Minimap_DrawTitleCHR (see that routine for
;;  details).  Only difference here is we're drawing the CHR for the 
;;  dragon decoration graphic, and so we use different LUTs.  Also, this
;;  graphic consists of $30 tiles instead of $28, so a bit more is drawn
;;  each frame.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

Minimap_DrawDecorCHR:
    LDA #<mm_decorchr
    STA minimap_ptr
    LDA #>mm_decorchr
    STA minimap_ptr+1        ; load up the pointer to our pre-loaded CHR

    LDX #0                   ; X will be our frame counter.  We will spread this drawing
                             ;  out over 16 frames

  @FrameLoop:
    JSR WaitForVBlank_L      ; wait for VBlank
    LDY #0                   ; Y will be loop counter/index

    @SmallLoop:
      LDA lut_MinimapDecorCHRDest_hi, Y  ; load up the destination PPU address for this
      STA $2006                          ;  tile of the title graphic
      LDA lut_MinimapDecorCHRDest_lo, Y  ; get low byte as well
      CLC
      ADC lut_MinimapBitplane, X         ; and add bitplane/row info to low byte
      STA $2006                          ;  before writing it

      LDA (minimap_ptr), Y   ; get the preloaded CHR data
      STA $2007              ; and draw it

      INY                    ; inc loop counter/index
      CPY #$30
      BCC @SmallLoop         ; and keep looping until a single bitplane row has been drawn for $30 tiles

    LDA minimap_ptr          ; add $30 to our source pointer
    CLC                      ;   so that we load the next chunk of graphic data
    ADC #$30
    STA minimap_ptr
    LDA minimap_ptr+1
    ADC #0
    STA minimap_ptr+1

    LDA soft2000             ; reset the scroll
    STA $2000
    LDA #$00
    STA $2005
    LDA #$E8
    STA $2005

    ;JSR Minimap_DrawSFX       ; play ugly drawing sound effect
    ;; JIGS - again, no
    INX
    CPX #16                   ; increment the frame loop counter
    BCC @FrameLoop            ; and loop until we do 16 frames (8 rows, 2 bitplanes per row = full tile)

    RTS                       ; then exit


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Minimap - Prep Decorative CHR  [$BCA3 :: 0x27CB3]
;;
;;    Preps the decorative CHR (the little dragon graphic thing that goes
;;  in the corners of the minimap) by re-arranging it to its necessary
;;  format, then dumping to a temporary RAM buffer, so it can be quickly copied to
;;  the pattern tables later.
;;
;;    Since each tile is drawn bitplane and row at a time, there is some necessary
;;  interleaving to perform here.  To speed up the routine that actually draws
;;  this data to the pattern tables, we want to do all the calculations here, and store the
;;  data in the temp buffer so that bytes can just be read and output in the order they're
;;  given.  We'll only be drawing one byte per tile at a time (rather than 16 bytes
;;  in a row for each tile -- which is how the pattern tables work).
;;
;;    Too hard to explain how this works in words... so here's an example:
;;
;;  CHR data as it needs to appear in the PPU pattern tables:
;;  00 01 02 03 04 05 06 07 08 09 0A 0B 0C 0D 0E 0F    (all 16 bytes of tile 0's graphic)
;;  10 11 12 13 14 15 16 17 18 19 1A 1B 1C 1D 1E 1F    (followed by all 16 bytes of tile 1's graphic)
;;  20 21 22 23 24 25 26 27 28 29 2A 2B 2C 2D 2E 2F    (followed by tile 2, etc)
;;
;;   But to draw this one bitplane row at a time, we need to have it stored
;;  in our RAM buffer as the following:
;;  00 10 20 08 18 28 01 11 21 09 19 29 03 13 23 ...   (all top row low bitplanes
;;                                                      followed by top row high bitplanes
;;                                                      followed by row 1 low bitplanes... etc)
;;
;;    That is the interleaving this routine is performing -- and why it isn't just a straight
;;  copy.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 

Minimap_PrepDecorCHR:
    LDA #<mm_decorchr
    STA tmp+2
    LDA #>mm_decorchr
    STA tmp+3              ; set (tmp+2) to our dest pointer (RAM to receive interleaved graphics)

    LDX #0          ; X is the outer loop counter, and indicates which row/bitplane to output next
    LDY #0          ; Y needs to always be zero for indexing

  @OuterLoop:
    LDA lut_MinimapBitplane, X
    STA tmp                  ; Load source pointer (tmp) to point to chr_MinimapDecor
    LDA #>chr_MinimapDecor   ;   offset by the row/bitplane we're to be decoded
    STA tmp+1                ;   from lut_MinimapBitplane)

    @InnerLoop:
      LDA (tmp), Y       ; copy a single byte from source
      STA (tmp+2), Y     ;  to dest

      INC tmp+2          ; increment dest pointer by 1
      BNE :+
        INC tmp+3

  :   LDA tmp            ; increment source pointer by $10 (to look at the same
      CLC                ;  row/bitplane on the next tile)
      ADC #$10
      STA tmp
      BCC @InnerLoop     ; if there was no wrap -- continue looping.  Otherwise...

      INC tmp+1            ; include the carry in the high byte of src pointer
      LDA tmp+1            ; check it to see if we copied data for $30 tiles
      CMP #>(chr_MinimapDecor + $300)
      BCC @InnerLoop       ; if not, keep looping  ($30 iterations)

    INX                 ; once the inner loop exits, we finished a single row/bitplane
    CPX #$10            ;  INX to start the next row/bitplane.
    BCC @OuterLoop      ; and continue outer loop until we do all $10 bytes of each tile
                        ; (outer loop = $10 iterations ... * $30 inner iterations =
                        ;     total $300 bytes copied)

    RTS

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Minimap CHR bitplane LUT  [$BCD9 :: 0x27CE9]
;;
;;    CHR for the minimap support graphics (title and decorations) is drawn progressively.
;;  CHR for each tile is drawn one row at a time -- or more specificlaly, one row of
;;  one bitplane at a time.
;;
;;    This progressive drawing is performed in a loop with an upcounter.  That counter
;;  is run through this LUT to know which bitplane of which row to draw during which
;;  loop iteration
;;
;;    You can scramble this table up in any order to change how the title and decorations
;;  get drawn without changing the final result.  As long as every value between 00-0F
;;  exists in this table.

lut_MinimapBitplane:

;      bitplane
;        lo  hi
  .BYTE $00,$08   ; top row
  .BYTE $01,$09
  .BYTE $02,$0A
  .BYTE $03,$0B
  .BYTE $04,$0C
  .BYTE $05,$0D
  .BYTE $06,$0E
  .BYTE $07,$0F   ; bottom row


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Minimap Decoration CHR Dest LUT  [$BCE9 :: 0x27CF9]
;;
;;    Exactly the same as lut_MinimapDecorCHRDest (see that LUT description for
;;  details).  Except this is for the 'dragon' decoration that appears on the map.
;;  It consists of $30 tiles



lut_MinimapDecorCHRDest_lo:
  .BYTE <$0010,<$0020,<$0030,<$0040, <$0050,<$0060,<$0070,<$0080
  .BYTE <$00B0,<$00C0,<$00D0,<$00E0, <$00F0,<$0700,<$0710,<$0720
  .BYTE <$0730,<$0740,<$0750,<$0760, <$0800,<$0810,<$0820,<$0830
  .BYTE <$0840,<$0D00,<$0D10,<$0D20, <$0D30,<$0D40,<$0E00,<$0E10
  .BYTE <$0E20,<$0E30,<$0E40,<$0F00, <$0F10,<$0F20,<$0F30,<$0F40
  .BYTE <$0F50,<$0F60,<$0F70,<$0F80, <$0F90,<$0FA0,<$0FB0,<$0FC0

lut_MinimapDecorCHRDest_hi:
  .BYTE >$0010,>$0020,>$0030,>$0040, >$0050,>$0060,>$0070,>$0080
  .BYTE >$00B0,>$00C0,>$00D0,>$00E0, >$00F0,>$0700,>$0710,>$0720
  .BYTE >$0730,>$0740,>$0750,>$0760, >$0800,>$0810,>$0820,>$0830
  .BYTE >$0840,>$0D00,>$0D10,>$0D20, >$0D30,>$0D40,>$0E00,>$0E10
  .BYTE >$0E20,>$0E30,>$0E40,>$0F00, >$0F10,>$0F20,>$0F30,>$0F40
  .BYTE >$0F50,>$0F60,>$0F70,>$0F80, >$0F90,>$0FA0,>$0FB0,>$0FC0



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Minimap Frame  [$BD49 :: 0x27D59]
;;
;;     Does a frame for the minimap!
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

MinimapFrame:
    JSR WaitForVBlank_L    ; wait for VBlank
    LDA #>oam              ; Sprite DMA
    STA $4014

    JSR DrawPalette_L      ; draw the palette
    LDA #$1E               ; turn PPU on
    STA $2001

    LDA soft2000           ; reset scroll to $00,$E8
    STA $2000
    LDA #$00
    STA $2005
    LDA #$E8
    STA $2005

    JSR CallMusicPlay_L    ; keep the music playing

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


Minimap_DrawRows:
    LDA #0
    STA mm_pixrow            ; start drawing pixel row 0, increment by 1 row each loop

    @MainLoop:
      LDX mm_pixrow          ; put row in X -- X will be the loop up counter and source index
      JSR WaitForVBlank_L    ; wait for VBlank

      @RowLoop:
        LDA minimap_ptr+1    ; set PPU address
        STA $2006
        STX $2006

        LDA mm_drawbuf, X    ; get graphic from drawing buffer
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

      BNE @MainLoop         ; once it wraps 7->0, we've drawn all 8 rows, so exit

    RTS


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Minimap - Drawing Sound effect [$BDCD :: 0x27DDD]
;;
;;    Plays that ugly sound effect you hear when the map is drawing.  Just
;;  plays a steady tone, but when called every frame, the phase resets each
;;  frame, which is why it sounds almost like it's buzzing.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;Minimap_DrawSFX:
;    LDA #$02
;    STA $4015            ; silence all channels except for square 2

;    LDA #%00110110
;    STA $4004            ; 12.5% duty (harshest), volume=6
;    LDA #$7F
;    STA $4005            ; disable sweep
;    LDA #$60
;    STA $4006            ; play tone at F=$060
;    LDA #$00
;    STA $4007

;    RTS

;; JIGS YAY


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


Minimap_PrepRow:
    JSR CallMinimapDecompress    ; decompress 2 rows of map data
    LDY #0                       ; Y will be the x coord (column) counter

  @MainLoop:
    LDA #8            ; tmp+7 is a counter to keep track of the number of bits
    STA tmp+7         ;  that have yet to be shifted into the output CHR bytes
                      ; since each byte is actually 8 pixels on a bitplane... multiple pixels
                      ; must be rotated into the same byte to be output as graphics.

    @RotateLoop:
      LDX mm_mapbuf, Y            ; here we get the minimap tileset data for 4 seperate
      LDA lut_MinimapTileset, X   ; map tiles (in a 2x2 square) and OR them together to combine
      LDX mm_mapbuf+1, Y          ; them to a single pixel.
      ORA lut_MinimapTileset, X   ;  This scales the map down from 256x256 tiles
      LDX mm_mapbuf2, Y           ;  to 128x128 pixels
      ORA lut_MinimapTileset, X
      LDX mm_mapbuf2+1, Y         ; after all this, A contains the output pixel (low 2 bits)
      ORA lut_MinimapTileset, X   ;  and bit 2 indicates whether or not a marker sprite needs to be placed here

      LSR A           ; shift out low bit
      ROL mm_bplo     ; rotate it into the low bitplane

      LSR A           ; shift out the high bit
      ROL mm_bphi     ; rotate into high bitplane

      LSR A                   ; shift out marker sprite flag
      BCC :+                  ; if set....
        JSR DrawDungeonSprite ; ... generate a dungeon marker sprite

  :   INY             ; increment our X coord by 2
      INY
      DEC tmp+7       ; decrement our bit counter
      BNE @RotateLoop ; if more bits needed to fill our bitplanes... keep going

      ; @RotateLoop exits when 8 pixels have been shifted into both high and low
      ; bitplanes.

    LDX minimap_ptr      ; use low byte of dest pointer as index for draw buffer

    LDA mm_bplo          ; copy both bitplanes to the appropriate areas of the buffer
    STA mm_drawbuf, X
    LDA mm_bphi
    STA mm_drawbuf+8, X

    LDA minimap_ptr      ; add $10 to low byte of pointer (look at next tile graphic)
    CLC
    ADC #$10
    STA minimap_ptr

    BCC @MainLoop        ; if there was no carry, keep looping
                         ;  otherwise, if there was carry, we have completed a single row
                         ;  from 16 tiles (128 pixels).  So this routine has completed its task
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

DrawDungeonSprite:
    LDA sprindex     ; Add 4 to the sprite index (drawing a single sprite -- 4 bytes)
    CLC              ;  do this before drawing the sprite to leave sprite 0 alone
    ADC #$04         ;  since that is the party position sprite
    STA sprindex
    TAX              ; put sprite index in X for indexing

    LDA mm_maprow    ; get Y coord
    LSR A            ; divide by 2 (minimap display is 128x128 -- world map is 256x256)
    CLC
    ADC #$34         ; add $34 to offset the sprite to the start of the map on the screen
    STA oam, X       ; write this as Y coord of sprite

    LDA #$81
    STA oam+1, X     ; use tile $81

    LDA #$00
    STA oam+2, X     ; attributes (palette 0, no flipping, foreground priority)

    TYA              ; get the X coord
    LSR A            ; divide by 2 for same reason
    CLC
    ADC #$3D         ; add $3D to offset it to start of the map
    STA oam+3, X     ; write as X coord

    RTS              ; done!




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Minimap - Fill NT and Palette [$BE54 :: 0x27E64]
;;
;;    Fills the nametable for the minimap.
;;  Also clears all of CHR-RAM for the BG, loads and draws the palette,
;;  and loads CHR for the sprites.

Minimap_FillNTPal:
    LDA #$08           ; write to soft2000 to clear NT scroll
    STA soft2000

   ; 
   ; draw the NT data at lut_MinimapNT
   ;

    LDA $2002          ; reset PPU toggle
    LDA #>$2000        ; set PPU address to $2000  (start of nametables)
    STA $2006
    LDA #<$2000
    STA $2006

    LDA #<lut_MinimapNT
    STA tmp
    LDA #>lut_MinimapNT ; load up the pointer to the LUT containing the minimap NT
    STA tmp+1           ;  data.  Store the pointer in (tmp)

    LDX #$04            ; X is high byte of loop counter
    LDY #$00            ; Y is low byte of counter and index
   @NTLoop:
       LDA (tmp), Y     ; get byte from LUT
       STA $2007        ; draw it
       INY              ; inc source index
       BNE @NTLoop      ; if it wrapped....
      INC tmp+1         ; inc high byte of source pointer
      DEX               ; dec high byte of loop counter
      BNE @NTLoop       ; and keep looping until expires ($400 iterations)

   ;
   ; clear the BG pattern table
   ;

    LDA $2002           ; reset PPU toggle
    LDA #>$0000         ; set PPU address to $0000 (start of BG pattern table)
    STA $2006
    LDA #<$0000
    STA $2006

                        ; A=0
    LDY #$10            ; Y is high byte of loop counter
    LDX #$00            ; X is low byte
   @ClearCHRLoop:
       STA $2007           ; zero out the pattern tables
       INX
       BNE @ClearCHRLoop
      DEY
      BNE @ClearCHRLoop    ; $1000 iterations (full BG pattern table)

   ;
   ; load CHR for sprites ("you are here" mark, and town/dungeon points)
   ;

    LDA $2002          ; reset PPU toggle
    LDA #>$1800        ; PPU address = $1800  (start of CHR for sprite tile $80)
    STA $2006
    LDA #<$1800
    STA $2006

    LDX #$00
   @SpriteCHRLoop:
      LDA lut_MinimapSprCHR, X
      STA $2007                      ; copy the CHR to the PPU
      INX                            ; inc loop counter
      CPX #$20
      BCC @SpriteCHRLoop             ; loop until $20 bytes copied (2 tiles)

   ;
   ; load BG palettes for this screen
   ;

    LDX #$0F
   @BGPalLoop:
      LDA lut_MinimapBGPal, X   ; copy color from LUT
      STA cur_pal, X            ;  to palette
      DEX
      BPL @BGPalLoop            ; loop until X wraps ($10 iterations)

    LDA cur_pal           ; copy the background color to the mirrored copy in the sprite palette
    STA cur_pal+$10       ;  this ensures the BG color will be what's desired when the palette is drawn

    LDA #$0F
    STA cur_pal+$11       ; start the "you are here" sprite
    STA cur_pal+$12       ;  and the town/dungeon marker sprite at $0F black

   ;
   ;  Do last minute PPU stuff before exiting
   ;

    JSR WaitForVBlank_L   ; wait for VBlank
    LDA #>oam             ; then do sprite DMA
    STA $4014

    JSR DrawPalette_L     ; draw the palette

    LDA soft2000
    STA $2000             ; set NT scroll and pattern page assignments
    LDA #$0A
    STA $2001             ; turn on BG rendering, but leave sprites invisible for now

    LDA #$00              ; set scroll to $00,$E8  (8 pixels up from bottom of the NT)
    STA $2005             ;   since there's vertical mirroring, this scrolls up 8 pixels,
    LDA #$E8              ;   which makes the screen appear to be 8 pixels lower than
    STA $2005             ;   what you might expect.  This centers the image on the screen a bit better
                          ; The NT could've just been drawn 1 tile down.. but that would mess with
                          ; attribute alignment

    RTS                   ; then exit!


;;  unused space
;  .BYTE 0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0
;  .BYTE 0,0,0,0, 0

;; JIGS The following moved to Bank F to make space for ... item prices!

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Minimap Sprite CHR  [$BF00 :: 0x27F10]
;;    CHR for sprites on the minimap

;lut_MinimapSprCHR:
;  .INCBIN "bin/minimap_sprite.chr"


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  BG palette for minimap  [$BF20 :: 0x27F30]

;lut_MinimapBGPal:
;  .BYTE $02,$1B,$38,$2B, $02,$04,$37,$0F, $02,$28,$18,$0F, $02,$24,$1A,$30



;; unused
;  .BYTE 0,0,0,0

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Minimap - Draw "You Are Here" sprite [$BF34 :: 0x27F44]
;;
;;     Clears OAM and draws the "you are here" marker sprite
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


Minimap_YouAreHere:
    LDX #0
    STX sprindex      ; clear the sprite index

    LDA #$F8          ; flood OAM with $F8 (to clear it -- moves all sprites offscreen, making them invisible)
   @Loop:
      STA oam, X
      INX
      BNE @Loop       ; $100 iterations (all of OAM)

    LDA #$08
    STA soft2000      ; clear NT scroll (seems inapporpriate to do it here, but I guess it doesn't hurt)

    LDA #$80
    STA oam+1         ; "you are here" sprite uses tile $80

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
    ADC #$34          ; but add a little less ($34 instead of $3D)
    STA oam+0         ; record as Y coord

    LDA #$00
    STA oam+2         ; set sprite attributes (palette 0, no flipping, foreground priority)

    RTS               ; and exit!



  ; unused
  ;.BYTE 0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0
  ;.BYTE 0,0,0,0, 0,0,0,0, 0
  
 ;; JIGS ^ 

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
  .BYTE 1,5,5,1,1,1,1,1,1,1,1,1,1,1,6,0
  .BYTE 1,1,1,1,1,1,0,0,0,1,1,5,5,6,2,3
  .BYTE 1,3,1,1,1,1,1,0,1,5,5,5,1,1,1,5
  .BYTE 1,1,5,1,5,5,2,2,5,5,5,1,3,3,3,1
  .BYTE 0,0,2,2,0,2,4,1,1,5,5,1,5,5,5,1
  .BYTE 0,0,2,2,1,1,1,5,5,1,5,1,1,5,1,1
  .BYTE 1,1,1,1,5,5,5,5,5,5,5,3,5,5,5,3
  .BYTE 1,1,1,1,1,1,1,1,1,2,0,3,3,3,3,3




.byte "END OF BANK STORY/PUZZLE (09)"