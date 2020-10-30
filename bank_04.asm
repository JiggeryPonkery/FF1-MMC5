.include "Constants.inc"
.include "variables.inc"
.feature force_range


.export LoadBattleSpritesForBank_Z
.export LoadStoneSprites
.export LoadBattleSprite
.export lut_BatSprCHR
.export LoadBattleSpritePalettes
.export LoadAllBattleSprites
.export LoadAllBattleSprites_Menu

.import WaitForVBlank_L
.import LongCall
.import CHRLoad
.import CHRLoadToA
.import CallMusicPlay_L
.import WaitForVBlank_L


.segment "BANK_04"

BANK_THIS = $04

;; JIGS: Battle sprites split into class

lut_BatSprCHR:

FighterSprites: 
.INCBIN "chr/class/Fighter.chr"
ThiefSprites: 
.INCBIN "chr/class/Thief.chr"
BlackBeltSprites: 
.INCBIN "chr/class/BlackBelt.chr"  
RedMageSprites: 
.INCBIN "chr/class/RedMage.chr"
WhiteMageSprites: 
.INCBIN "chr/class/WhiteMage.Chr"
BlackMageSprites: 
.INCBIN "chr/class/BlackMage.chr"
Sprite_7:
.INCBIN "chr/class/Unused.chr"
Sprite_8:
.INCBIN "chr/class/Unused.chr"
Sprite_9:
.INCBIN "chr/class/Unused.chr"
Sprite_10:
.INCBIN "chr/class/Unused.chr"
Sprite_11:
.INCBIN "chr/class/Unused.chr"
Sprite_12:
.INCBIN "chr/class/Unused.chr"
Sprite_13:
.INCBIN "chr/class/Unused.chr"
Sprite_14:
.INCBIN "chr/class/Unused.chr"
Sprite_15:
.INCBIN "chr/class/Unused.chr"
Sprite_16:
.INCBIN "chr/class/Unused.chr"
KnightSprites: 
.INCBIN "chr/class/Knight.Chr"
NinjaSprites: 
.INCBIN "chr/class/Ninja.Chr"
MasterSprites: 
.INCBIN "chr/class/Master.Chr"  
RedWizSprites: 
.INCBIN "chr/class/RedWiz.Chr"
WhiteWizSprites: 
.INCBIN "chr/class/WhiteWiz.Chr"
BlackWizSprites: 
.INCBIN "chr/class/BlackWiz.Chr"
Sprite_23:
.INCBIN "chr/class/Unused.chr"
Sprite_24:
.INCBIN "chr/class/Unused.chr"
Sprite_25:
.INCBIN "chr/class/Unused.chr"
Sprite_26:
.INCBIN "chr/class/Unused.chr"
Sprite_27:
.INCBIN "chr/class/Unused.chr"
Sprite_28:
.INCBIN "chr/class/Unused.chr"
Sprite_29:
.INCBIN "chr/class/Unused.chr"
Sprite_30:
.INCBIN "chr/class/Unused.chr"
;Sprite_31:
;.INCBIN "chr/class/Unused.chr"
;Sprite_32:
;.INCBIN "chr/class/Unused.chr"
;; no room

CursorCHR:
.INCBIN "chr/cursor.chr"



;; JIGS - Disch's original disassembly had a long string of data here.
;; Turns out it was character, weapon, and magic sprites, so I sorted them out! 
;; Now they're easy to edit with YY-CHR or by copying edited data from a FFHackster-compatible rom.

    
LoadBattleSpritesForBank_Z: 
    JSR LoadBattleSpritePalettes

    LDA $2002  
    LDA #0    
    STA tmp+3					; counter for 12 classes 

   @Loop:
    LDA #$60                    ; CHRLoadToAX is different, in that it doesn't do rows, so tmp+2 is amount of writes
    STA tmp+2                   ; $60 writes is 6 tiles   
    JSR LoadBattleSpritesLocation 
    LDA LoadBattleSpritesLUT_1+1, Y
    TAX
    LDA LoadBattleSpritesLUT_1, Y   
    JSR CHRLoadToAX
    INC tmp+3
    LDA tmp+3
    CMP #$1E
    BNE @Loop
    
LoadCursor:
    LDA #<CursorCHR
    STA tmp
    LDA #>CursorCHR
    STA tmp+1
    LDA #$40
    STA tmp+2   
    LDA #$1F
    LDX #$00
    JMP CHRLoadToAX       
    
LoadBlackTile_BG: ;; this one is necessary for the save screen and new game screens!
    LDA #0
    STA $2006
    STA $2006

FillBlackTile:    
    LDX #$10
   @Loop:
    STA $2007             ; write $20 zeros to clear 2 tiles
    DEX
    BNE @Loop
    RTS
   
LoadBattleSpritesLocation:
    LDA tmp+3
    ASL A
    ASL A
    TAY
    LDA LoadBattleSpritesLUT_1+2, Y 
    STA tmp
    LDA LoadBattleSpritesLUT_1+3, Y
    STA tmp+1
    RTS    

LoadBattleSpritesLUT_1:
   .byte $10,$00               ; location to draw to ($1000)
   .word FighterSprites
   .byte $10,$60
   .word ThiefSprites
   .byte $10,$C0
   .word BlackBeltSprites
   .byte $11,$20
   .word RedMageSprites
   .byte $11,$80
   .word WhiteMageSprites
   .byte $11,$E0
   .word BlackMageSprites
   .byte $12,$40
   .word Sprite_7
   .byte $12,$A0
   .word Sprite_8
   .byte $13,$00
   .word Sprite_9
   .byte $13,$60
   .word Sprite_10
   .byte $13,$C0
   .word Sprite_11
   .byte $14,$20
   .word Sprite_12
   .byte $14,$80
   .word Sprite_13
   .byte $14,$E0
   .word Sprite_14
   .byte $15,$40
   .word Sprite_15
   .byte $15,$A0
   .word Sprite_16
   
   .byte $16,$00
   .word KnightSprites
   .byte $16,$60
   .word NinjaSprites
   .byte $16,$C0
   .word MasterSprites
   .byte $17,$20
   .word RedWizSprites
   .byte $17,$80
   .word WhiteWizSprites
   .byte $17,$E0
   .word BlackWizSprites
   .byte $18,$40
   .word Sprite_23
   .byte $18,$A0
   .word Sprite_24
   .byte $19,$00
   .word Sprite_25
   .byte $19,$60
   .word Sprite_26
   .byte $19,$C0
   .word Sprite_27
   .byte $1A,$20
   .word Sprite_28
   .byte $1A,$80
   .word Sprite_29
   .byte $1A,$E0
   .word Sprite_30


ShiftTile:
    LDA (tmp), Y
    LSR A
    ROR tmp+3    
    LSR A    
    ROR tmp+3    
    LSR A    
    ROR tmp+3           
    LSR A    
    ROR tmp+3        
    RTS


CHRLoadToAX_ShiftSide:; this version takes up 9 tiles
    LDY $2002         ; reset PPU Addr toggle
    STA $2006         ; write high byte of dest address
    STX $2006         ; write low byte
    
    LDA #<TileShiftBuffer
    STA tmp+4
    LDA #>TileShiftBuffer
    STA tmp+5
    
    LDA #0
    TAY
  : STA (tmp+4), Y ; clear this out for safety
    DEY
    BNE :-
   
    LDA #3
    STA tmp+2 ; loop counter

    LDA #$10 
    STA tmp+6 ; for the other Y
    
   @Restart:
    LDA #0
    STA tmp+3
    
    LDX #$10 ; do 16 bytes
    
   @FirstTile:
    JSR ShiftTile
    STA (tmp+4), Y ; = [    ****] right 4 bits
    
    STY tmp+7
    LDY tmp+6 ; +$10 to Y
    
    ; tmp+3 = [****    ] new left 4 bits
    LDA tmp+3
    STA (tmp+4), Y
    
    LDA #0
    STA tmp+3 ; reset tmp+3
    LDY tmp+7 ; -$10 to Y
    
    INY
    INC tmp+6
    DEX
    BNE @FirstTile
    
    ; one tile is done! 

    LDX #$10
    
   @SecondTile:
    JSR ShiftTile 

    ; get previous tile's left 4 bits
    ORA (tmp+4), Y ; = [++++****] left 4 bits
    STA (tmp+4), Y     
    
    STY tmp+7
    LDY tmp+6 ; +$10 to Y
    
    ; tmp+3 = [****    ] new right 4 bits
    LDA tmp+3
    STA (tmp+4), Y
    
    LDA #0
    STA tmp+3 ; reset tmp+3
    LDY tmp+7 ; return Y to original position
    
    INY
    INC tmp+6
    DEX
    BNE @SecondTile
   
   LDX #$10
  @ThirdTile:
    INC tmp+6
    INY
    DEC tmp
    DEX    
    BNE @ThirdTile
    
    DEC tmp+2
    BEQ :+ 
      JMP @Restart
    
  : LDA #>TileShiftBuffer
    STA tmp+1
    LDA #<TileShiftBuffer
    STA tmp

    LDX #$90
    LDY #0
    JMP CHRLoad_Loop





;; for this, I need to skip 4 bytes at the start, then write 4, skip 4, write the SECOND HALF ???

;; JIGS - no its 5:30 AM and I am wrong, but I'm on the right track...

;sprite data:   00 01 02 03 04 05 06 07 08 09 0A 0B 0C 0D 0E 0F
;               10 11 12 31 14 15 16 17 18 19 1A 1B 1C 1D 1E 1F
;
;location data: x  x  x  x  00 01 02 03 x  x  x  x  08 09 0A 0B
;               04 05 06 07 10 11 12 13 0C 0D 0E 0F 18 19 1A 1B
;               14 15 16 17 20 21 22 23 1C 1D 1E 1F 28 29 2A 2B ...  

; write blank 4, write 4, write blank 4, forward Y 4, write 4
; real loop:
; backup Y 8 ($04), write 4 ($08), forward Y 8 ($10), write 4 ($14), backup Y 8 ($0C), write 4 ($10), forward Y 8 ($18), write 4



CHRLoadToAX_ShiftUpDown: ; this version takes up 8 tiles
    LDY $2002            ; reset PPU Addr toggle
    STA $2006            ; write high byte of dest address
    STX $2006            ; write low byte
    
    LDY #0 ; doing this is very important
    
    ;4 blank bytes to start with...
    JSR ShiftyYThing
    JSR ShiftyYThing    
    JSR ShiftyYThing
    
    JSR ShiftUpDown_Write4        
    
    ;; JIGS - I did this my tried and true way of... doing semi-random things until it worked.
    ;; I honestly can't explain it.
    ;; anyway this shifts the stone sprite down 4 pixels
    
    LDA #12
    STA tmp+2
ShiftUpDown_RealLoop:    
    TYA
    SEC
    SBC #$18
    TAY
    JSR ShiftUpDown_Write4
    TYA
    CLC
    ADC #$18
    TAY
    JSR ShiftUpDown_Write4
    DEC tmp+2
    BNE ShiftUpDown_RealLoop
    RTS

ShiftyYThing:
    JSR ShiftUpDown_Write4    
    
    LDX #$04
    LDA #$00
ShiftUpDown_WriteLoopBlank:
    STA $2007
    DEX
    BNE ShiftUpDown_WriteLoopBlank

ShiftY4:
    INY
    INY
    INY
    INY
    RTS
   
ShiftUpDown_Write4:
    LDX #4
ShiftUpDown_WriteLoop:
    LDA (tmp), Y      ; read a byte from source pointer
    STA $2007
    INY               ; inc our source index
    DEX
    BNE ShiftUpDown_WriteLoop
    RTS   
   
   
  

LoadStoneSprites:
    LDA $2002                 ; reset PPU toggle
    
    LDA #>$0D00    
    STA $2006
    LDA #<$0D00    
    STA $2006
    
    LDA #0
    LDY #3
   @ClearLoop_Outer: 
    LDX #0
   @ClearLoop_Inner:
    STA $2007
    DEX
    BNE @ClearLoop_Inner
    DEY
    BNE @ClearLoop_Outer
    
    ;; clear 3 rows of sprites -- this is part of battle setup as well,  
    ;; as at least $0F70, 80, and 90 must be blank. They mirror the top of the message box
    ;; and will show up in the background above the message box when the screen shakes    

    LDA #$00
    STA char_index
   @CharLoop:
    TAX
    LDA ch_sprite, X
    ASL A
    ASL A
    TAY
    LDA LoadBattleSpritesLUT_1+3,Y ; high byte only
    STA tmp+1
    LDA #$E0                       ; first byte of cheer pose from the CharPose_LUT
    STA tmp
    LDA char_index                 ; then get the destination address to draw the tiles to
    LSR A
    LSR A
    LSR A
    LSR A
    LSR A                          ; shift it into 0, 1, 2, or 3 * 2
    TAY 
    LDA BattleCharStonePositions_LUT+1, Y
    TAX
    LDA BattleCharStonePositions_LUT, Y    
    PHA
    LDA char_index ; for first and third character, do this instead:
    AND #$40
    BEQ :+
      PLA
      JSR CHRLoadToAX_ShiftUpDown  ; makes 2x4 square
      JMP :++
    
  : PLA
    JSR CHRLoadToAX_ShiftSide      ; makes 3x3 square
    
  : LDA char_index
    CLC
    ADC #$40
    STA char_index
    BNE @CharLoop                  ; when char_index loops back to $00, all 4 are done 
    JMP LoadBattleSpritePalettes
    

LoadAllBattleSprites_Menu:
    JSR LoadCursor
    LDA #3
    STA char_index
  : LDA char_index
    TAY
    LSR A
    ROR A
    ROR A
    TAX
    LDA ch_sprite, X 
    ASL A
    ASL A 
    TAX                             ; so $F0 = $0F, then * 4   
    LDA LoadBattleSpritesLUT_1+3,X  ; only bother with the high byte, the low byte is always $0
    STA tmp+1                       
    LDA #0
    STA tmp
    LDA MenuCharPositions_LUT, Y
    LDX #2
    JSR CHRLoadToA
    DEC char_index
    BPL :-
    
LoadBattleSpritePalettes:
    LDX #$0F  ; start at $0F
  @Loop:
      LDA @BattleSpritePalettes, X
      STA cur_pal+$10, X   ; copy color to sprite palette
      DEX
      BPL @Loop            ; loop until X wraps ($10 colors copied)
      RTS

@BattleSpritePalettes:
  .byte $0F,$18,$21,$28  ; BlackMage, BlackBelt
  .byte $0F,$16,$30,$36  ; Fighter, RedMage, WhiteMage
  .byte $0F,$08,$17,$28  ; Thief
  .byte $0F,$00,$10,$30  ; Cursor

    
LoadAllBattleSprites:    
    LDA #3
    STA char_index
  : JSR LoadBattleSprite
    DEC char_index
    BPL :-
    RTS

LoadBattleSprite:   
    LDA char_index
    LSR A    
    ROR A    
    ROR A    
    TAX
    LDA ch_sprite, X 
    ASL A
    ASL A
    TAY                             ; sprite * 4
    LDA LoadBattleSpritesLUT_1+3,Y  ; only bother with the high byte, the low byte is always $0
    STA tmp+1                       
    LDY char_index
    LDX btl_charactivepose, Y       ; btl_charpose buffer holds the pose to use: stand, attack, crouch, cheer, dead
    LDA BattleCharPose_LUT, X       ; which is used to get these bytes!
    STA tmp                         ; so now get the low byte
    LDA BattleCharPose_LUT+1, X     ; and if there's an high byte to add... add it
    CLC      
    ADC tmp+1
    STA tmp+1
    LDA BattleCharPose_LUT+2, X     ; third byte is how many tiles to draw 
    STA tmp+2
    LDA char_index                  ; finally, get the destination address to draw the tiles to
    ASL A
    TAY 
    LDA BattleCharPositions_LUT+1, Y
    TAX
    LDA BattleCharPositions_LUT, Y
   
CHRLoadToAX:
    LDY InBattle
    BNE StackLoader

    LDY $2002         ; reset PPU Addr toggle
    STA $2006         ; write high byte of dest address
    STX $2006         ; write low byte
    LDY #$00
    LDX tmp+2         ; amount of writes to make
CHRLoad_Loop:
    LDA (tmp), Y      ; read a byte from source pointer
    STA $2007         ; and write it to CHR-RAM
    INY               ; inc our source index
    DEX
    BNE CHRLoad_Loop  ; if we've loaded all requested tiles, exit.  Otherwise continue loading
    RTS

StackLoader:
    PHA       ; backup A
    TXA       ; backup X
    PHA
 
    LDY tmp+2
    LDX #0
    DEY
   @StackLoad_Loop:
    LDA (tmp), Y                  ; read a byte from source pointer
    STA TempSpriteLoading, X      ; save to the top of the stack
    INX
    DEY                           ; and stop when all the bytes are loaded  
    BPL @StackLoad_Loop
    
    JSR WaitForVBlank_L
    
    PLA       ; restore X    
    TAX
    PLA       ; restore A 
    LDY $2002
    STA $2006         ; write high byte of dest address
    STX $2006         ; write low byte
 
    LDX tmp+2 ; get amount of bytes to write    
   @PullStackLoop:
    LDA TempSpriteLoading-1, X
    STA $2007
    DEX    
    BNE @PullStackLoop
    RTS
    
;; JIGS - PLA is the same amount of cycles as LDA, X
;; the below version uses the stack, while the above version uses TempSpriteLoading    
;; the above version is better, since the stack holds teleport information
;; and if too many teleports are taken (say in Castle of Ordeals), this will eventually clobber that data
    
;    PHA       ; backup A
;    TXA       ; backup X
;    PHA
;
;    LDY #0
;   @StackLoad_Loop:
;    LDA (tmp), Y      ; read a byte from source pointer
;    STA $0100, Y      ; save to the top of the stack
;    INY
;    CPY tmp+2         ; and stop when all the bytes are loaded
;    BNE @StackLoad_Loop
;    
;    JSR WaitForVBlank_L
;    
;    PLA       ; restore X    
;    TAX
;    PLA       ; restore A 
;    LDY $2002
;    STA $2006         ; write high byte of dest address
;    STX $2006         ; write low byte
;    
;    TSX       ; move stack pointer to X
;    STX tmp+3 ; backup stack pointer    
;    LDX #$FF  ; start at the top of the stack
;    TXS       ; transfer to the stack pointer
;
;    LDX tmp+2 ; get amount of bytes to write    
;   @PullStackLoop:
;    PLA
;    STA $2007
;    DEX
;    BNE @PullStackLoop
;    
;    LDX tmp+3
;    TXS       ; restore stack pointer
;    RTS    


BattleCharStonePositions_LUT:
   .byte $0E,$00    ; character 0 
   .byte $0D,$04    ; character 1 
   .byte $0E,$90    ; character 2 
   .byte $0D,$84    ; character 3 
   
MenuCharPositions_LUT:
   .byte $10        ; character 0 
   .byte $12        ; character 1 
   .byte $14        ; character 2 
   .byte $16        ; character 3    
   
BattleCharPositions_LUT:
   .byte $11,$00    ; character 0 
   .byte $11,$80    ; character 1 
   .byte $12,$00    ; character 2 
   .byte $12,$80    ; character 3    

BattleCharPose_LUT:
   ; first two bytes is offset for where to load sprites from
   ; third byte is how many tiles to draw (amount in high bits)
   .byte $00,$00,$60 ; $00 ; Stand/Walk ; 6 tiles 
   .byte $00,$00,$40 ; $03 ; Attack_1   ; 4 tiles, same as stand, but quicker
   .byte $80,$00,$60 ; $06 ; Attack_2   ; 6 tiles
   .byte $E0,$00,$60 ; $09 ; Cheer      ; 6 tiles
   .byte $40,$01,$60 ; $0C ; Crouch     ; 6 tiles
   .byte $A0,$01,$60 ; $0F ; Dead       ; 6 tiles
   .byte $00,$00,$80 ; $12 ; Stand/Walk ; 8 tiles, loads the walking legs before battle
   ;; Don't want to load 8 tiles per frame, so this last one is for before battle begins


    
.byte "END OF BANK 04"    
    
    
    