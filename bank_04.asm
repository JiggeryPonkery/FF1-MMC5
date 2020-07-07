.include "Constants.inc"
.include "variables.inc"
.feature force_range


.export LoadBattleSpritesForBank_Z
.export LoadSprite_Bank04
.export LoadStoneSprites
.export LoadCursorOnly
.export lut_BatSprCHR
.export lut_BatObjCHR

.import WaitForVBlank_L
.import LongCall
.import CHRLoad
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
UnusedSprites:
.INCBIN "chr/class/Unused.chr"
UnusedSprites2:
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
UnusedSprites3:
.INCBIN "chr/class/Unused.chr"
UnusedSprites4:
.INCBIN "chr/class/Unused.chr"
 

;; Weapon and Magic Casting Sprites
lut_BatObjCHR:
MagicWeaponSprites:  
.INCBIN "chr/weapon_magic_sprites.chr"

;; JIGS - Disch's original disassembly had a long string of data here.
;; Turns out it was character, weapon, and magic sprites, so I sorted them out! 
;; Now they're easy to edit with YY-CHR or by copying edited data from a FFHackster-compatible rom.

    
LoadBattleSpritesForBank_Z: 
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
    CMP #$10
    BNE @Loop
    JMP LoadBlackTile_BG
   
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
   .word UnusedSprites
   .byte $12,$A0
   .word UnusedSprites
   .byte $13,$00
   .word KnightSprites
   .byte $13,$60
   .word NinjaSprites
   .byte $13,$C0
   .word MasterSprites
   .byte $14,$20
   .word RedWizSprites
   .byte $14,$80
   .word WhiteWizSprites
   .byte $14,$E0
   .word BlackWizSprites    
   .byte $15,$40
   .word UnusedSprites
   .byte $15,$A0
   .word UnusedSprites


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

CHRLoadToAX_Shift:
    LDY $2002         ; reset PPU Addr toggle
    STA $2006         ; write high byte of dest address
    STX $2006         ; write low byte
    
    LDA #<TileShiftBuffer
    STA tmp+4
    LDA #>TileShiftBuffer
    STA tmp+5
    
    LDY #$FF
    LDA #0
  : STA (tmp+4), Y ; clear this out for safety
    DEY
    BNE :-
   
    LDA #3
    STA tmp+2

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
    LDA tmp+2
    BEQ :+ 
      JMP @Restart
    
  : LDA #>TileShiftBuffer
    STA tmp+1
    LDA #<TileShiftBuffer
    STA tmp

    LDX #$90
    LDY #0
    JMP CHRLoad_Loop
  

LoadStoneSprites:
    LDA #$00
    STA char_index
   @CharLoop:
    TAX
    LDA ch_class, X
    AND #$F0
    LSR A
    LSR A
    TAY
    LDA LoadBattleSpritesLUT_1+3,Y ; high byte only
    STA tmp+1
    LDA #$E0                       ; first byte of cheer pose from the CharPose_LUT
    STA tmp
    LDA #$60                       ; amount of tiles to draw (6)
    STA tmp+2
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
    LDA char_index ; every second character, do this instead:
    AND #$40
    BEQ :+
      PLA
      JSR CHRLoadToAX_Shift
      JMP :++
    
  : PLA
    JSR CHRLoadToAX                ; draw the cheer pose to background tiles
  : LDA char_index
    CLC
    ADC #$40
    STA char_index
    BNE @CharLoop                  ; when char_index loops back to $00, all 4 are done 
    RTS

LoadBattleSprite:   
   LDA char_index
   CLC      
   ROR A    
   ROR A    
   ROR A    
   TAX
   LDA ch_class, X 
   AND #$F0                        ; get sprite from class
   LSR A 
   LSR A                           ; shift down twice -- since what we want is the low bits shifted up twice!
   TAY                             ; so $F0 = $0F, then * 4   
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
    BNE Jump_StackLoader

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

Jump_StackLoader:
    JMP StackLoader
    
LoadSprite_Bank04:
    LDA MMC5_tmp
    LSR A    				; 01 
    BCS LoadBattleSprite
    LSR A                   ; 02 
    BCS LoadWeaponSprite
    LSR A                   ; 04 
    BCS LoadMagicSprite     
    BCC LoadAttackCloud     ; 08

BattleCharStonePositions_LUT:
   .byte $0D,$00    ; character 0 
   .byte $0D,$70    ; character 1 
   .byte $0E,$00    ; character 2 
   .byte $0E,$70    ; character 3 
   
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

LoadAttackCloud:
    LDA #<MagicWeaponSprites+$40
    STA tmp
    LDA #>MagicWeaponSprites+$0F
    STA tmp+1
    ; a800 < start of MagicWeaponSprites
    ; b740 < where we want to laod from

    LDA #$C0
    STA tmp+2
    LDA #$10
    LDX #$40
    JSR CHRLoadToAX
	JMP LoadBlackTiles_Sprite
   
LoadWeaponSprite:
    JSR LoadMagicWeaponSprite    
    LDA #$10
    LDX #$00
    JMP CHRLoadToAX
    
LoadCursorOnly:
    LDA #$F0
    STA btlattackspr_gfx
    JSR LoadMagicWeaponSprite    
    LDA #$1F
    LDX #$00
    JMP CHRLoadToAX   

LoadMagicWeaponSprite:    
    LDA #0
    STA tmp+1
    LDA btlattackspr_gfx
    CLC
    ROL A
    ROL tmp+1
    ROL A
    ROL tmp+1
    ROL A
    ROL tmp+1
    ROL A
    ROL tmp+1                 ; this should convert something like $A8 into $0A80
    CLC
    ADC #<MagicWeaponSprites
    STA tmp
    LDA #>MagicWeaponSprites
    ADC tmp+1
    STA tmp+1
    LDA #$40
    STA tmp+2    
    RTS
    
    
LoadMagicSprite:
    JSR LoadMagicWeaponSprite    
    LDA tmp+1
    PHA
    LDA tmp
    PHA
    
    LDA #$13                
    LDX #$00
    JSR CHRLoadToAX    
    ;; do the first 4 tiles
    
    ;; BattleUpdatePPU - Copy:
    LDA btl_soft2001
    STA $2001               ; copy over soft2001
    LDA #$00
    STA $2005               ; reset scroll
    STA $2005
    
    LDA $2002
    LDA #>oam
    STA $4014               ; Do OAM DMA
    LDA #BANK_THIS
    STA cur_bank            ; set the swap-back bank (necessary because music playback is in another bank)
    JSR CallMusicPlay_L     ; Call music playback to keep it playing
    ;; does not update battle sfx, so make sure this is called before SFX begin
    
    LDA #BANK_DOBATTLE      ; reset the swap-back bank
    STA cur_bank           
    
    LDA #$40
    STA tmp+2
    PLA 
    STA tmp
    CLC
    ADC #$40
    STA tmp
    PLA 
    ADC #$00
    STA tmp+1
    LDA #$13
    LDX #$40
    JMP CHRLoadToAX

;; JIGS - this is really just so I don't see garbage in the PPU viewer while testing battle graphics...
;; since now it displays sprites instead of background tiles

LoadBlackTiles_Sprite:
    LDX #>$1000
    LDA #<$1000
    STX $2006             ; write X as high byte
    STA $2006             ; A as low byte
	JMP FillBlackTile

LoadBlackTile_BG: ;; this one is necessary for the save screen and new game screens!
    LDA #0
    STA $2006
    STA $2006

FillBlackTile:    
;   LDA #0
    LDX #$10
   @Loop:
    STA $2007             ; write $20 zeros to clear 2 tiles
    DEX
    BNE @Loop
    RTS

StackLoader:
    PHA       ; backup A
    TXA       ; backup X
    PHA

    LDY #0
   @StackLoad_Loop:
    LDA (tmp), Y      ; read a byte from source pointer
    STA $0100, Y      ; save to the top of the stack
    INY
    CPY tmp+2         ; and stop when all the bytes are loaded
    BNE @StackLoad_Loop
    
    JSR WaitForVBlank_L
    
    PLA       ; restore X    
    TAX
    PLA       ; restore A 
    LDY $2002
    STA $2006         ; write high byte of dest address
    STX $2006         ; write low byte
    
    TSX       ; move stack pointer to X
    STX tmp+3 ; backup stack pointer    
    LDX #$FF  ; start at the top of the stack
    TXS       ; transfer to the stack pointer

    LDX tmp+2 ; get amount of bytes to write    
   @PullStackLoop:
    PLA
    STA $2007
    DEX
    BNE @PullStackLoop
    
    LDX tmp+3
    TXS       ; restore stack pointer
    RTS
    
.byte "END OF BANK 04"    
    
    
    