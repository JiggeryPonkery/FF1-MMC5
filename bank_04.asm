.include "Constants.inc"
.include "variables.inc"
.feature force_range


.export lut_ShopCHR
.export LoadShopCHRForBank_Z
.export LoadBattleSpritesForBank_Z
.export LoadSprite_Bank04
; ^ JIGS added some

.import WaitForVBlank_L

;; JIGS imported... v 
.import LongCall, CHRLoad, CallMusicPlay_L, BattleWaitForVBlank_L


.segment "BANK_04"

BANK_THIS = $04

lut_ShopCHR:
.INCBIN "chr/shop_text.chr" 


;; JIGS: Battle sprites split into class

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

 

;; Weapon and Magic Casting Sprites
MagicWeaponSprites:  
.INCBIN "chr/weapon_magic_sprites.chr"

;; JIGS - Disch's original disassembly had a long string of data here.
;; Turns out it was character, weapon, and magic sprites, so I sorted them out! 
;; Now they're easy to edit with YY-CHR or by copying edited data from a FFHackster-compatible rom.



LoadShopCHRForBank_Z: ;; JIGS - Its either put this here or copy all of lut_ShopCHR to Bank Z as well.
    LDA #>lut_ShopCHR
    STA tmp+1        
    LDA #<lut_ShopCHR
    STA tmp
    LDX #16    
    JSR CHRLoad
;    
    LDA $2002          ; Set address to $1000 
    LDA #>$1000
    STA $2006
    LDA #<$1000
    STA $2006
;
    LDA #>lut_ShopCHR
    STA tmp+1        
    LDA #<lut_ShopCHR
    STA tmp
    LDX #16    
    JMP CHRLoad
    
    
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
    CMP #12
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
   .byte $10,$00               ; location to draw to for ($1000)
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
   .word KnightSprites
   .byte $12,$A0
   .word NinjaSprites
   .byte $13,$00
   .word MasterSprites
   .byte $13,$60
   .word RedWizSprites
   .byte $13,$C0
   .word WhiteWizSprites
   .byte $14,$20
   .word BlackWizSprites    

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
    LDY $2002         ; reset PPU Addr toggle
    STA $2006         ; write high byte of dest address
    STX $2006         ; write low byte
    LDY #$00
    LDX tmp+2
CHRLoad_Loop:
    LDA (tmp), Y      ; read a byte from source pointer
    STA $2007         ; and write it to CHR-RAM
    INY               ; inc our source index
    DEX
    BNE CHRLoad_Loop  ; if we've loaded all requested tiles, exit.  Otherwise continue loading
    RTS
    
LoadSprite_Bank04:
    LDA MMC5_tmp
    LSR A    				; 01 
    BCS LoadBattleSprite
    LSR A                   ; 02 
    BCS LoadWeaponSprite
    LSR A                   ; 04 
    BCS LoadMagicSprite     
    BCC LoadAttackCloud     ; 08

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
    JMP CHRLoadToAX
   
LoadWeaponSprite:
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
    LDA #$10
    LDX #$00
    JMP CHRLoadToAX
    
LoadMagicSprite:
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
    ROL tmp+1               ; this should convert something like $A8 into $0A80
    CLC
    ADC #<MagicWeaponSprites
    STA tmp
    LDA #>MagicWeaponSprites
    ADC tmp+1
    STA tmp+1
    PHA
    LDA tmp
    PHA
    LDA #$40
    STA tmp+2
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
    STA $4014                   ; Do OAM DMA
    LDA #BANK_THIS
    STA cur_bank            ; set the swap-back bank (necessary because music playback is in another bank)
    JSR CallMusicPlay_L     ; Call music playback to keep it playing
    ;; does not update battle sfx, so make sure this is called before SFX begin
    
    JSR BattleWaitForVBlank_L
    
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

    
    
.byte "END OF BANK 04"    
    
    
    