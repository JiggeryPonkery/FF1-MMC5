.include "Constants.inc"
.include "variables.inc"

.export EnemyAttackPlayer_PhysicalZ, PlayerAttackEnemy_PhysicalZ
.export ClericCheck, CritCheck, HandPalette
.export SoundTestZ
.export OptionsMenu, DrawSaveScreenNames, DrawSaveScreenSprites
.export EnterTitleScreenNew
.export JigsIntro
.export SaveScreen
.export ReadjustEquipStats
.export UnadjustEquipStats
.export BattleConfirmation
.export LoadEnemyStats

.import GameLoaded, StartNewGame, SaveScreenHelper, LoadBattleSpritesForBank_Z
.import SwapPRG_L, LongCall, DrawCombatBox_L, CallMusicPlay_L, WaitForVBlank_L, MultiplyXA, AddGPToParty, LoadShopCHRForBank_Z
.import RandAX, HushTriangle, BattleWaitForVBlank_L, GameStart_L, GameStart2, LoadPtyGenBGCHRAndPalettes, IntroTitlePrepare, LoadBridgeSceneGFX_Menu
.import DrawComplexString, ClearOAM, DrawPalette, CallMusicPlay, UpdateJoy, DrawSimple2x3Sprite, Draw2x2Sprite, CHRLoad, CHRLoadToA
.import DrawCursor, WaitForVBlank_L, DrawBox, LoadMenuCHRPal, MenuCondStall, CoordToNTAddr, LoadBorderPalette_Blue
.import UndrawBattleBlock, ShiftSpriteHightoLow, PlaySFX_Error




BANK_THIS = $0F

.segment "BANK_0Z"

lut_WeaponData:
    ;.INCBIN "bin/0C_8000_weapondata.bin"
    
;  .INCBIN "bin/0C_8000_weapondata.bin"

;      v ----------------------------- Hit rate
;          v ------------------------- Damage
;              v --------------------- Critical hit rate
;                  v ----------------- Spell
;                      v ------------- Element
;                          v --------- Category effectiveness
;                              v ----- Graphic
;                                  v - Palette

.byte $00,$0C,$0A,$00,$00,$00,$A8,$27 ; Wooden nunchucks
.byte $0A,$05,$05,$00,$00,$00,$98,$20 ; Small knife 
.byte $00,$06,$01,$00,$00,$00,$A0,$27 ; Wooden staff
.byte $05,$09,$0A,$00,$00,$00,$90,$20 ; Rapier
.byte $00,$09,$01,$00,$00,$00,$94,$27 ; Iron hammer
.byte $0A,$0F,$05,$00,$00,$00,$80,$20 ; Short sword
.byte $05,$10,$03,$00,$00,$00,$9C,$20 ; Hand axe
.byte $0A,$0A,$05,$00,$00,$00,$84,$2B ; Scimitar
.byte $00,$10,$0A,$00,$00,$00,$A8,$20 ; Iron nunchucks
.byte $0A,$07,$05,$00,$00,$00,$98,$20 ; Large knife
.byte $00,$0E,$01,$00,$00,$00,$A4,$20 ; Iron Staff
.byte $05,$0D,$0A,$00,$00,$00,$90,$20 ; Sabre
.byte $0A,$14,$05,$00,$00,$00,$8C,$20 ; Long sword
.byte $05,$16,$03,$00,$00,$00,$9C,$25 ; Great axe
.byte $0A,$0F,$05,$00,$00,$00,$88,$20 ; Falchion
.byte $0F,$0A,$05,$00,$00,$00,$98,$2C ; Silver knife
.byte $0F,$17,$05,$00,$00,$00,$8C,$2C ; Silver Sword
.byte $05,$0C,$01,$00,$00,$00,$94,$2C ; Silver Hammer
.byte $0A,$19,$04,$00,$00,$00,$9C,$2C ; Silver Axe
.byte $14,$1A,$05,$00,$10,$88,$88,$26 ; Flame sword
.byte $19,$1D,$05,$00,$20,$00,$8C,$21 ; Ice sword
.byte $0F,$13,$0A,$00,$00,$02,$90,$2B ; Dragon sword
.byte $14,$15,$05,$00,$00,$04,$80,$22 ; Giant sword
.byte $1E,$20,$05,$00,$00,$08,$8C,$27 ; Sun sword
.byte $0F,$13,$0A,$00,$00,$20,$90,$25 ; Coral sword
.byte $0F,$12,$05,$00,$00,$10,$80,$24 ; Were sword
.byte $0F,$12,$05,$00,$00,$41,$88,$23 ; Rune sword
.byte $00,$0C,$01,$00,$00,$00,$A0,$2A ; Power staff
.byte $0F,$1C,$03,$12,$00,$08,$9C,$23 ; Light axe       - casts HARM 2
.byte $00,$06,$01,$14,$00,$00,$A4,$21 ; Heal staff      - casts HEAL
.byte $0A,$0C,$01,$15,$00,$00,$A4,$25 ; Mage staff      - casts FIRE 2
.byte $23,$1E,$05,$04,$00,$00,$80,$27 ; Defense swrd    - casts SHIELD
.byte $0F,$0F,$01,$1F,$00,$00,$A4,$2C ; Wizard staff    - casts CONFUSE
.byte $19,$18,$1E,$00,$00,$00,$88,$21 ; Vorpal sword
.byte $23,$16,$05,$00,$00,$00,$98,$2C ; CatClaw
.byte $0F,$12,$01,$17,$00,$00,$94,$24 ; Thor Hammer     - casts BOLT 2
.byte $14,$16,$0A,$26,$00,$00,$90,$22 ; Bane sword      - casts BANE
.byte $23,$21,$1E,$00,$00,$00,$98,$27 ; Katana
.byte $23,$2D,$05,$00,$FF,$FF,$8C,$28 ; Excalibur
.byte $32,$38,$0A,$00,$00,$00,$84,$20 ; Masamune    

; Here's the element and category bytes shown in binary.
; Good luck trying to know what setting each byte actually does.
; I read somewhere that ice/fire armour or weapons are backwards 
; and those are the only ones that do anything with elements here...
;    
;                 Element   Category    
; Flame Sword   ; 0001,0000 1000,1000
; Ice sword     ; 0020,0000 1000,1100 
; Dragon sword  ; 0000,0000 0000,0010
; Giant sword   ; 0000,0000 0000,0100
; Sun sword     ; 0000,0000 1000,1100
; Coral sword   ; 0000,0000 0010,0000
; Were sword    ; 0000,0000 0001,0000
; Rune Sword    ; 0000,0000 0011,0000
; Excalibur     ; 1111,1111 1111,1111
;                 ^^^^ ^^^^ ^^^^ ^^^^
;                 |||| |||| |||| |||╘???  
;                 |||| |||| |||| ||╘Dragon  
;                 |||| |||| |||| |╘Giant  
;                 |||| |||| |||| ╘Undead  
;                 |||| |||| |||╘Were 
;                 |||| |||| ||╘Water  
;                 |||| |||| |╘Magic  
;                 |||| |||| ╘Regenerative  
;                 |||| |||╘Instant death?  
;                 |||| ||╘Stun?  
;                 |||| |╘Poison?
;                 |||| ╘Rub?  
;                 |||╘Fire  
;                 ||╘Ice  
;                 |╘Lightning  
;                 ╘Earth?  
;
; Best guesses taken from FF Hackster!

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Armor data!  [$8140 :: 0x30150]
;;
;;  4 bytes per armor, 40 armors ($A0 bytes total)
;;
;;  byte 0:  Evade penality
;;  byte 1:  Absorb boost
;;  byte 2:  Elemental defense
;;  byte 3:  Spell cast

lut_ArmorData:
;    .INCBIN "bin/0C_8140_armordata.bin"

;      v ------------------- Evade penalty
;          v --------------- Absorb boost
;              v ----------- Elemental defense
;                        v - Spell

;.byte $02,$01,%00000000,$00 ; Cloth T ;; original
.byte $00,$02,%00000000,$00 ; Cloth T  ;; JIGS - c'mon, that's just mean... At least make it a little useful.
.byte $08,$04,%00000000,$00 ; Wooden armor
.byte $0F,$0F,%00000000,$00 ; Chain armor
.byte $17,$18,%00000000,$00 ; Iron armor
.byte $21,$22,%00000000,$00 ; Steel armor
.byte $08,$12,%00000000,$00 ; Silver armor
.byte $0A,$22,%00100000,$00 ; Flame armor
.byte $0A,$22,%00010000,$00 ; Ice armor
.byte $0A,$2A,%01000000,$00 ; Opal armor
.byte $0A,$2A,%01110000,$00 ; Dragon armor
.byte $01,$04,%00000000,$00 ; Copper Q
.byte $01,$0F,%00000000,$00 ; Silver Q
.byte $01,$18,%00000000,$00 ; Gold Q
.byte $01,$22,%00000000,$00 ; Opal Q
.byte $02,$18,%00011000,44  ;$2C ; white T        - casts INVIS 2
.byte $02,$18,%00100100,32  ;$20 ; Black T        - casts ICE 2
.byte $00,$02,%00000000,$00 ; Wooden shield
.byte $00,$04,%00000000,$00 ; Iron shield
.byte $00,$08,%00000000,$00 ; Silver shield
.byte $00,$0C,%00100000,$00 ; Flame shield
.byte $00,$0C,%00010000,$00 ; Ice shield
.byte $00,$10,%00000100,$00 ; Opal shield
.byte $00,$10,%00000010,$00 ; Aegis shield
.byte $00,$02,%00000000,$00 ; Buckler
.byte $02,$08,%00000000,$00 ; Protect cape
.byte $01,$01,%00000000,$00 ; Cap
.byte $03,$03,%00000000,$00 ; Wooden helm
.byte $05,$05,%00000000,$00 ; Iron helm
.byte $03,$06,%00000000,$00 ; Silver helm
.byte $03,$08,%00000000,$00 ; Opal helm
.byte $03,$06,%00000000,20  ;$14 ; Heal helm      - casts HEAL
.byte $01,$01,%11111111,$00 ; Ribbon
.byte $01,$01,%00000000,$00 ; Gloves
.byte $03,$02,%00000000,$00 ; Copper Gauntlet
.byte $05,$04,%00000000,$00 ; Iron Gauntlet
.byte $03,$06,%00000000,$00 ; Silver Gauntlet
.byte $03,$06,%00000000,23  ;$17 ; Zeus Gauntlet  - casts BOLT 2
.byte $03,$06,%00000000,55  ;$37 ; Power Gauntlet - casts SABER
.byte $03,$08,%00000000,$00 ; Opal Gauntlet
.byte $01,$08,%00001000,$00 ; Protect Ring

;; As you can see here, to set a spell, you can abandon the $ and just use the number of the spell. 
;; Reference Bank A for the spell list in normal people numbers, or Constants.inc for hex!
;; And for the elemental defense:
;  
;
;  ╒-Maybe instant death of some sort, or Earth? (Enemy attack CRACK makes sense, earth-based instant death spell...)
;  |╒-Lightning
;  ||╒-Ice
;  |||╒-Fire
;  |||| ╒-Rub (instant death)
;  |||| |╒-Time? Poison?
;  |||| ||╒-Stun
;  |||| |||╒-Probably another kind of instant death! This game loves it! Might possibly be sleep.
;  vvvv vvvv
;; 0000,0000

lut_MagicData:
    .INCBIN "bin/0C_81E0_magicdata.bin"

lut_MagicBattleMessages:
  .BYTE $01, $00, $02, $03,  $00, $00, $05, $00,    $00, $00, $08, $03,  $00, $00, $0A, $0B     ; spells
  .BYTE $01, $00, $0C, $01,  $00, $0D, $00, $05,    $00, $0F, $10, $00,  $00, $12, $00, $00
  .BYTE $01, $4A, $00, $01,  $00, $4D, $4A, $0B,    $4A, $4A, $02, $03,  $00, $15, $16, $00
  .BYTE $18, $00, $19, $01,  $00, $00, $1B, $00,    $4A, $00, $1C, $1D,  $00, $1E, $1F, $15
  .BYTE $00, $00, $00, $00,  $00, $00, $00, $00,    $16, $15, $00, $1F,  $00, $00, $00, $00 
  .BYTE $4D, $00, $00, $00,  $15, $00, $00, $00,    $00, $00, $00, $00,  $00, $00, $00, $00

;; -- the above data can be removed, so long as it takes up the exact same space
;; -- Enemy data needs to be in this exact spot, to match Bank C.
  
data_EnemyStats:
;  .INCBIN "bin/0C_8520_enemydata.bin"  

;; I just stole all this again from the FFbytes docs by Dienyddiwr Da - http://www.romhacking.net/documents/81/ ! 

;     Experience - ENROMSTAT_EXP       
;     |       Gold Pieces - ENROMSTAT_GP
;     |       |       Hit Points - ENROMSTAT_HPMAX
;     |       |       |      Rate of Fear - ENROMSTAT_MORALE
;     |       |       |       |   AI Attack - ENROMSTAT_AI
;     |       |       |       |   |   Agility - ENROMSTAT_EVADE
;     |       |       |       |   |   |   Defense - ENROMSTAT_ABSORB
;     |       |       |       |   |   |   |   Hit Rate - ENROMSTAT_NUMHITS
;     |       |       |       |   |   |   |   |   Aim Rate - ENROMSTAT_HITRATE
;     |___¸   |___¸   |___¸   |   |   |   |   |   |   Strength - ENROMSTAT_DAMAGE
;     |   |   |   |   |   |   |   |   |   |   |   |   |   Critical Hit Rate - ENROMSTAT_CRITRATE
;     |   |   |   |   |   |   |   |   |   |   |   |   |   |   Special Attack Chance - ENROMSTAT_SPECIAL
;     |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   Attack Effect - ENROMSTAT_ATTACKAIL
;     |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   Category - ENROMSTAT_CATEGORY
;     |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   ?????? - ENROMSTAT_MAGDEF 
;     |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   Weakness - ENROMSTAT_ELEMWEAK
;     |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   Resistence - ENROMSTAT_ELEMRESIST
;     2   1   2   1   2   1   |   |   |   |   |   |   |   |   |   |   |   |   |   |   Item to Steal - ENROMSTAT_ITEM   
;     |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   
;     |__ |__ |__ |__ |__ |__ |__ |__ |__ |__ |__ |__ |__ |__ |__ |__ |__ |__ |__ |__ |__ ; Name   

.byte $06,$00,$06,$00,$08,$00,$6A,$FF,$06,$04,$01,$02,$04,$01,$00,$00,$04,$10,$00,$00,$02 ; IMP	
.byte $12,$00,$12,$00,$10,$00,$78,$FF,$09,$06,$01,$04,$08,$01,$00,$00,$04,$17,$00,$00,$00 ; GrIMP	
.byte $18,$00,$06,$00,$14,$00,$69,$FF,$24,$00,$01,$05,$08,$01,$00,$00,$00,$1C,$00,$00,$00 ; WOLF	
.byte $5D,$00,$16,$00,$48,$00,$6C,$FF,$36,$00,$01,$12,$0E,$01,$00,$00,$00,$2E,$00,$00,$00 ; GrWolf	
.byte $87,$00,$43,$00,$44,$00,$78,$FF,$2A,$06,$01,$11,$0E,$01,$02,$04,$91,$2D,$00,$00,$00 ; WrWolf 
.byte $92,$01,$C8,$00,$5C,$00,$C8,$00,$36,$00,$01,$17,$19,$01,$00,$00,$00,$37,$10,$20,$00 ; FrWOLF 
.byte $99,$00,$32,$00,$5C,$00,$86,$FF,$18,$0C,$01,$17,$12,$0A,$00,$00,$02,$37,$00,$00,$00 ; IGUANA 
.byte $A8,$09,$B0,$04,$28,$01,$C8,$01,$24,$12,$02,$4A,$1F,$01,$00,$00,$02,$8F,$20,$10,$00 ; AGAMA
.byte $B9,$07,$92,$02,$C4,$00,$C8,$02,$18,$14,$01,$36,$1E,$01,$00,$00,$02,$5B,$00,$00,$00 ; SAURIA
.byte $6F,$03,$6F,$03,$F0,$00,$88,$FF,$30,$0C,$01,$3C,$26,$01,$00,$00,$04,$78,$00,$00,$00 ; GIANT
.byte $D8,$06,$D8,$06,$50,$01,$C8,$FF,$30,$10,$01,$4E,$3C,$01,$00,$00,$04,$96,$10,$20,$00 ; FrGIANT
.byte $E2,$05,$E2,$05,$2C,$01,$C8,$FF,$30,$14,$01,$53,$49,$01,$00,$00,$04,$87,$20,$10,$00 ; R`GIANT
.byte $1E,$00,$1E,$00,$1C,$00,$6E,$FF,$48,$04,$01,$07,$0A,$01,$00,$00,$20,$1C,$40,$90,$00 ; SAHAG
.byte $69,$00,$69,$00,$40,$00,$8E,$FF,$4E,$08,$01,$10,$0F,$01,$00,$00,$20,$2E,$40,$90,$00 ; R`SAHAG
.byte $72,$03,$72,$03,$CC,$00,$C8,$FF,$60,$14,$01,$33,$2F,$01,$00,$00,$20,$65,$40,$90,$00 ; WzSAHAG
.byte $28,$00,$28,$00,$06,$00,$FF,$FF,$0C,$00,$01,$02,$08,$01,$00,$00,$00,$0F,$00,$00,$00 ; PIRATE
.byte $3C,$00,$78,$00,$32,$00,$6A,$FF,$18,$06,$01,$0D,$0E,$01,$00,$00,$00,$25,$00,$80,$00 ; KYZOKU
.byte $0B,$01,$42,$00,$78,$00,$79,$FF,$48,$00,$01,$1E,$16,$01,$00,$00,$20,$46,$40,$90,$00 ; SHARK
.byte $39,$09,$58,$02,$58,$01,$C8,$FF,$48,$08,$01,$56,$32,$01,$00,$00,$20,$AA,$40,$90,$00 ; GrSHARK
.byte $2A,$00,$0A,$00,$0A,$00,$6E,$03,$54,$00,$01,$02,$04,$01,$00,$00,$00,$0E,$40,$90,$00 ; OddEYE
.byte $07,$0E,$07,$0E,$30,$01,$C8,$04,$18,$10,$02,$4C,$1E,$01,$00,$00,$20,$9C,$40,$90,$00 ; BigEYE
.byte $09,$00,$03,$00,$0A,$00,$7C,$FF,$0C,$00,$01,$02,$0A,$01,$00,$00,$08,$11,$10,$2B,$00 ; BONE
.byte $7A,$01,$7A,$01,$90,$00,$9C,$FF,$2A,$0C,$01,$24,$1A,$01,$00,$00,$08,$4C,$10,$2B,$00 ; R`BONE
.byte $3F,$00,$0F,$00,$38,$00,$68,$FF,$18,$08,$01,$0E,$11,$01,$00,$00,$00,$28,$10,$00,$00 ; CREEP
.byte $BA,$00,$C8,$00,$54,$00,$6A,$FF,$2A,$08,$08,$15,$01,$01,$01,$10,$00,$33,$00,$00,$00 ; CRAWL
.byte $20,$01,$48,$00,$78,$00,$7A,$FF,$30,$04,$01,$1E,$16,$01,$00,$00,$00,$4C,$00,$00,$00 ; HYENA
.byte $9E,$04,$58,$02,$C0,$00,$92,$05,$30,$08,$01,$30,$1E,$01,$00,$00,$00,$67,$20,$10,$00 ; CEREBUS
.byte $C3,$00,$C3,$00,$64,$00,$74,$FF,$12,$0A,$01,$19,$12,$01,$00,$00,$04,$41,$00,$00,$00 ; OGRE
.byte $1A,$01,$2C,$01,$84,$00,$7E,$FF,$1E,$0E,$01,$21,$17,$01,$00,$00,$04,$47,$00,$00,$00 ; GrOGRE
.byte $D3,$02,$D3,$02,$90,$00,$86,$06,$36,$0A,$01,$24,$17,$01,$00,$00,$C4,$50,$00,$80,$00 ; WzOGRE
.byte $7B,$00,$32,$00,$38,$00,$6B,$FF,$1E,$06,$01,$0E,$06,$01,$02,$04,$02,$2E,$00,$00,$00 ; ASP
.byte $A5,$00,$32,$00,$50,$00,$6E,$FF,$24,$0A,$01,$14,$16,$1F,$00,$00,$02,$38,$00,$00,$00 ; COBRA
.byte $BD,$03,$58,$02,$E0,$00,$C8,$FF,$30,$0C,$01,$38,$23,$00,$00,$00,$22,$74,$40,$90,$00 ; SeaSNAKE
.byte $E1,$00,$46,$00,$54,$00,$70,$FF,$36,$0A,$02,$15,$16,$01,$02,$04,$00,$37,$00,$00,$00 ; SCORPION
.byte $7F,$02,$2C,$01,$94,$00,$C8,$FF,$3C,$12,$03,$25,$23,$01,$02,$04,$20,$55,$40,$90,$00 ; LOBSTER
.byte $E9,$01,$E9,$01,$A4,$00,$7C,$FF,$30,$04,$02,$29,$16,$01,$00,$00,$00,$5F,$00,$00,$00 ; BULL
.byte $1A,$04,$1A,$04,$E0,$00,$88,$FF,$24,$0E,$01,$38,$28,$01,$00,$00,$08,$74,$10,$2B,$00 ; ZomBULL
.byte $6D,$02,$6D,$02,$B8,$00,$88,$FF,$30,$0C,$03,$2E,$18,$01,$00,$00,$80,$64,$10,$00,$00 ; TROLL
.byte $54,$03,$54,$03,$D8,$00,$C8,$FF,$30,$14,$01,$36,$28,$01,$00,$00,$A0,$6E,$40,$80,$00 ; SeaTROLL
.byte $5A,$00,$2D,$00,$32,$00,$7C,$FF,$24,$00,$01,$0D,$0A,$01,$01,$08,$09,$25,$10,$AB,$00 ; SHADOW
.byte $E7,$00,$E7,$00,$56,$00,$A0,$FF,$5A,$04,$01,$16,$16,$01,$01,$10,$09,$34,$10,$AB,$00 ; IMAGE
.byte $B0,$01,$B0,$01,$72,$00,$A0,$FF,$6C,$0C,$01,$1D,$28,$01,$01,$10,$09,$43,$10,$AB,$00 ; WRAITH
.byte $DE,$03,$DE,$03,$B4,$00,$B8,$FF,$24,$1E,$01,$2D,$5D,$01,$01,$10,$09,$55,$10,$AB,$00 ; GHOST
.byte $18,$00,$0C,$00,$14,$00,$78,$FF,$06,$00,$01,$05,$0A,$01,$00,$00,$08,$19,$10,$AB,$00 ; ZOMBIE
.byte $5D,$00,$32,$00,$30,$00,$7C,$FF,$0C,$06,$03,$0C,$08,$01,$01,$10,$08,$24,$10,$2B,$00 ; GHOUL 
.byte $75,$00,$75,$00,$38,$00,$A0,$FF,$2E,$0A,$03,$0E,$08,$01,$01,$10,$08,$28,$10,$2B,$00 ; GEIST
.byte $96,$00,$96,$00,$34,$00,$A0,$FF,$2A,$0C,$01,$0D,$14,$01,$01,$10,$08,$2D,$10,$2B,$00 ; SPECTER
.byte $F8,$10,$E8,$03,$00,$01,$C8,$FF,$24,$0A,$01,$70,$41,$0A,$00,$00,$00,$C8,$00,$80,$00 ; WORM
.byte $7B,$0A,$84,$03,$C8,$00,$7C,$07,$3E,$0E,$01,$32,$2E,$01,$00,$00,$00,$67,$00,$80,$00 ; Sand W
.byte $87,$06,$90,$01,$18,$01,$C8,$FF,$04,$1F,$01,$46,$32,$01,$00,$00,$00,$8F,$20,$90,$00 ; Grey W
.byte $99,$0C,$99,$0C,$A2,$00,$C8,$08,$0C,$1E,$01,$2A,$1E,$01,$00,$00,$40,$5C,$00,$80,$00 ; EYE
.byte $01,$00,$01,$00,$68,$01,$C8,$09,$18,$3C,$01,$96,$78,$28,$01,$10,$89,$A0,$10,$AB,$00 ; PHANTOM
.byte $BB,$02,$BB,$02,$44,$00,$96,$02,$24,$0A,$01,$11,$14,$01,$02,$04,$00,$37,$00,$00,$00 ; MEDUSA
.byte $C2,$04,$C2,$04,$60,$00,$C8,$02,$48,$0C,$0A,$18,$0B,$01,$01,$10,$01,$46,$10,$A0,$00 ; GrMEDUSA
.byte $0C,$03,$0C,$03,$A0,$00,$94,$FF,$30,$10,$02,$28,$1E,$01,$02,$04,$91,$5D,$00,$00,$00 ; CATMAN
.byte $5B,$02,$20,$03,$6E,$00,$96,$0A,$3C,$1E,$03,$1C,$14,$01,$00,$00,$40,$3E,$00,$FB,$00 ; MANCAT
.byte $AA,$04,$2C,$01,$DE,$00,$6F,$FF,$30,$14,$01,$38,$27,$01,$02,$04,$00,$74,$00,$00,$00 ; PEDE
.byte $C4,$08,$E8,$03,$40,$01,$B0,$FF,$30,$18,$01,$50,$49,$01,$00,$00,$00,$B9,$00,$30,$00 ; GrPEDE
.byte $B6,$01,$6C,$00,$84,$00,$74,$FF,$30,$08,$02,$21,$16,$19,$00,$00,$00,$55,$00,$00,$00 ; TIGER
.byte $4B,$03,$F4,$01,$C8,$00,$B4,$FF,$2A,$08,$02,$32,$18,$46,$00,$00,$00,$6A,$00,$00,$00 ; Saber T
.byte $B0,$04,$D0,$07,$9C,$00,$C8,$0B,$48,$18,$01,$27,$4C,$01,$01,$10,$89,$4B,$10,$AB,$00 ; VAMPIRE
.byte $51,$09,$B8,$0B,$2C,$01,$C8,$0C,$48,$1C,$01,$2A,$5A,$01,$01,$10,$C9,$54,$10,$AB,$00 ; WzVAMP
.byte $84,$00,$50,$00,$50,$00,$84,$FF,$2D,$08,$04,$14,$0C,$01,$00,$00,$01,$35,$00,$80,$00 ; GARGOYLE
.byte $83,$01,$83,$01,$5E,$00,$86,$0D,$48,$20,$04,$18,$0A,$01,$02,$00,$01,$7F,$00,$B0,$00 ; R`GOYLE
.byte $00,$06,$00,$03,$20,$01,$C8,$FF,$12,$14,$01,$48,$42,$01,$00,$00,$01,$82,$10,$EB,$00 ; EARTH
.byte $54,$06,$20,$03,$14,$01,$C8,$FF,$2A,$14,$01,$45,$32,$01,$00,$00,$01,$82,$20,$9B,$00 ; FIRE
.byte $A5,$06,$D0,$07,$C8,$00,$C8,$0E,$78,$08,$01,$32,$35,$01,$00,$00,$02,$C4,$50,$A2,$00 ; Frost D
.byte $58,$0B,$A0,$0F,$F8,$00,$C8,$0F,$60,$1E,$01,$3E,$4B,$01,$00,$00,$02,$C8,$22,$90,$00 ; Red D
.byte $1B,$09,$E7,$03,$0C,$01,$C8,$FF,$18,$1E,$01,$43,$38,$01,$01,$10,$0A,$87,$10,$AB,$00 ; ZombieD
.byte $54,$00,$14,$00,$18,$00,$7C,$FF,$00,$FF,$01,$01,$01,$01,$02,$04,$00,$24,$30,$CB,$00 ; SCUM
.byte $FF,$00,$46,$00,$4C,$00,$98,$FF,$04,$07,$01,$13,$1E,$01,$00,$00,$00,$37,$40,$BB,$00 ; MUCK
.byte $FC,$00,$46,$00,$4C,$00,$90,$FF,$06,$06,$01,$13,$20,$01,$00,$00,$00,$37,$30,$CB,$00 ; OOZE
.byte $4D,$04,$84,$03,$9C,$00,$C8,$FF,$18,$FF,$01,$27,$31,$01,$02,$04,$00,$55,$10,$EB,$00 ; SLIME
.byte $1E,$00,$08,$00,$1C,$00,$6D,$FF,$1E,$00,$01,$07,$0A,$01,$00,$00,$00,$1C,$00,$00,$00 ; SPIDER
.byte $8D,$00,$32,$00,$40,$00,$6F,$FF,$18,$0C,$01,$10,$05,$01,$02,$04,$00,$2E,$00,$00,$00 ; ARACHNID
.byte $25,$05,$8A,$02,$A4,$00,$96,$21,$48,$08,$02,$29,$16,$01,$00,$00,$00,$5F,$00,$80,$00 ; MATICOR
.byte $88,$04,$88,$04,$E4,$00,$84,$FF,$78,$0C,$03,$39,$17,$01,$00,$00,$00,$73,$00,$80,$00 ; SPHINX
.byte $94,$05,$2C,$01,$00,$01,$92,$FF,$38,$26,$03,$40,$3C,$01,$00,$00,$00,$82,$00,$00,$00 ; R`ANKYLO
.byte $32,$0A,$01,$00,$60,$01,$90,$FF,$30,$30,$01,$58,$62,$01,$00,$00,$00,$9C,$00,$00,$00 ; ANKYLO
.byte $2C,$01,$2C,$01,$50,$00,$AC,$FF,$18,$14,$01,$14,$1E,$01,$01,$20,$08,$3C,$10,$2B,$00 ; MUMMY
.byte $D8,$03,$E8,$03,$BC,$00,$94,$FF,$18,$18,$01,$2F,$2B,$01,$02,$20,$08,$5F,$10,$2B,$00 ; WzMUMMY
.byte $BA,$00,$C8,$00,$32,$00,$7C,$FF,$48,$04,$01,$0A,$01,$01,$02,$02,$00,$2F,$00,$80,$00 ; COCTRICE
.byte $A7,$01,$F4,$01,$2C,$00,$7C,$10,$48,$04,$01,$0B,$14,$01,$00,$00,$00,$2D,$20,$90,$00 ; PERILISK
.byte $95,$04,$32,$00,$D4,$00,$96,$FF,$60,$0C,$01,$35,$1E,$01,$02,$04,$02,$73,$00,$80,$00 ; WYVERN
.byte $C2,$04,$F6,$01,$04,$01,$96,$FF,$3C,$16,$01,$41,$28,$01,$00,$00,$02,$83,$00,$80,$00 ; WYRM
.byte $3B,$0D,$F6,$01,$E0,$01,$90,$FF,$3C,$0A,$01,$85,$41,$01,$00,$00,$02,$C8,$00,$00,$00 ; TYRO
.byte $20,$1C,$58,$02,$58,$02,$96,$FF,$3C,$0A,$01,$90,$73,$1E,$00,$00,$02,$C8,$00,$00,$00 ; T REX
.byte $F0,$00,$14,$00,$5C,$00,$8A,$FF,$48,$00,$01,$17,$16,$01,$00,$00,$00,$44,$40,$90,$00 ; CARIBE
.byte $22,$02,$2E,$00,$AC,$00,$8E,$FF,$48,$14,$01,$2B,$25,$01,$00,$00,$00,$53,$00,$00,$00 ; R`CARIBE
.byte $30,$03,$84,$03,$B8,$00,$8A,$FF,$30,$10,$02,$2E,$2A,$01,$00,$00,$00,$67,$40,$90,$00 ; GATOR
.byte $62,$07,$D0,$07,$20,$01,$8E,$FF,$30,$14,$02,$48,$38,$01,$00,$00,$02,$8F,$40,$90,$00 ; FrGATOR
.byte $C8,$04,$66,$00,$D0,$00,$B0,$FF,$18,$18,$03,$34,$14,$01,$02,$04,$00,$74,$40,$90,$00 ; OCHO
.byte $75,$0C,$F4,$01,$58,$01,$C8,$FF,$18,$20,$03,$56,$23,$01,$02,$04,$00,$AA,$00,$00,$00 ; NAOCHO
.byte $93,$03,$96,$00,$D4,$00,$8A,$FF,$24,$0E,$03,$35,$1E,$01,$00,$00,$02,$74,$00,$00,$00 ; HYDRA
.byte $BF,$04,$90,$01,$B6,$00,$98,$11,$24,$0E,$03,$2E,$14,$01,$00,$00,$02,$67,$20,$10,$00 ; R`HYDRA
.byte $C8,$04,$90,$01,$C8,$00,$C8,$FF,$48,$28,$02,$32,$19,$01,$01,$10,$00,$6E,$40,$0B,$00 ; GAURD
.byte $A0,$0F,$D0,$07,$90,$01,$96,$FF,$60,$30,$01,$5A,$66,$01,$00,$00,$00,$A0,$40,$BB,$00 ; SENTRY
.byte $AA,$07,$20,$03,$2C,$01,$C8,$FF,$48,$14,$01,$44,$45,$01,$00,$00,$01,$82,$20,$9B,$00 ; WATER
.byte $4E,$06,$27,$03,$66,$01,$C8,$FF,$90,$04,$01,$3E,$35,$01,$00,$00,$01,$82,$00,$8B,$00 ; AIR
.byte $33,$09,$33,$09,$64,$01,$C8,$12,$48,$08,$01,$47,$09,$01,$02,$04,$60,$74,$40,$90,$00 ; NAGA
.byte $A1,$0D,$A0,$0F,$A4,$01,$9A,$13,$30,$10,$01,$58,$07,$01,$02,$04,$40,$8F,$00,$00,$00 ; GrNAGA
.byte $10,$08,$C4,$09,$2C,$01,$C8,$14,$48,$14,$04,$3C,$1E,$01,$00,$00,$02,$82,$20,$90,$00 ; CHIMERA
.byte $E8,$11,$88,$13,$5E,$01,$C8,$15,$3C,$12,$04,$46,$28,$01,$00,$00,$02,$8F,$20,$90,$00 ; JIMERA
.byte $14,$01,$2C,$01,$54,$00,$7E,$FF,$42,$10,$02,$15,$1E,$01,$00,$00,$21,$62,$00,$33,$00 ; WIZARD
.byte $36,$03,$E7,$03,$70,$00,$82,$16,$30,$0C,$03,$1C,$01,$01,$00,$01,$00,$BB,$00,$00,$00 ; SORCERER
.byte $82,$00,$FA,$00,$6A,$00,$FF,$FF,$0C,$0A,$01,$1B,$0F,$01,$00,$00,$00,$40,$00,$00,$00 ; GARLAND
.byte $E4,$0F,$88,$13,$60,$01,$C8,$17,$60,$10,$01,$44,$48,$01,$00,$00,$02,$C8,$20,$80,$00 ; Gas D
.byte $CA,$0C,$D0,$07,$C6,$01,$C8,$18,$60,$14,$01,$56,$5C,$01,$00,$00,$02,$C8,$10,$00,$00 ; Blue D
.byte $E9,$04,$20,$03,$B0,$00,$C8,$19,$1C,$07,$01,$2C,$40,$01,$02,$04,$41,$5D,$00,$7B,$00 ; MudGOL
.byte $51,$09,$E8,$03,$C8,$00,$C8,$1A,$18,$10,$01,$32,$46,$01,$00,$00,$41,$6E,$00,$FB,$00 ; RockGOL
.byte $3D,$1A,$B8,$0B,$30,$01,$C8,$1B,$18,$64,$01,$4C,$5D,$01,$00,$00,$01,$8F,$00,$BB,$00 ; IronGOL
.byte $EF,$04,$08,$07,$04,$01,$C8,$FF,$24,$26,$02,$41,$2C,$01,$00,$00,$00,$87,$00,$00,$00 ; BADMAN
.byte $8C,$0A,$B8,$0B,$BE,$00,$C8,$1C,$2A,$20,$01,$30,$37,$01,$00,$00,$41,$AD,$00,$0B,$00 ; EVILMAN
.byte $CA,$08,$D0,$07,$A8,$00,$FF,$2B,$4E,$28,$01,$2A,$1A,$01,$00,$00,$00,$AA,$00,$00,$00 ; ASTOS
.byte $47,$04,$47,$04,$69,$00,$C8,$1D,$4E,$28,$01,$1B,$1A,$01,$00,$00,$40,$AA,$00,$00,$00 ; MAGE
.byte $5C,$0D,$5C,$0D,$C8,$00,$9E,$1E,$5A,$26,$01,$2D,$28,$01,$00,$00,$40,$BA,$00,$00,$00 ; FIGHTER
.byte $3F,$00,$0F,$00,$40,$00,$6A,$FF,$16,$02,$02,$10,$0A,$01,$00,$00,$00,$28,$00,$00,$00 ; MADPONY
.byte $F8,$04,$BC,$02,$C8,$00,$C8,$1F,$84,$18,$03,$32,$1E,$01,$00,$00,$01,$64,$20,$9B,$00 ; NITEMARE
.byte $00,$7D,$00,$7D,$E8,$03,$C8,$20,$60,$50,$02,$C8,$80,$01,$00,$00,$80,$C8,$00,$FB,$00 ; WarMECH
.byte $98,$08,$B8,$0B,$90,$01,$FF,$22,$18,$28,$01,$31,$28,$01,$01,$10,$49,$78,$10,$2B,$00 ; LICH
.byte $D0,$07,$01,$00,$F4,$01,$FF,$23,$30,$32,$01,$40,$32,$01,$01,$10,$49,$8C,$00,$2B,$00 ; LICH (reprise)
.byte $AB,$09,$B8,$0B,$58,$02,$FF,$24,$30,$32,$06,$3F,$28,$01,$00,$00,$41,$B7,$01,$72,$00 ; KARY
.byte $D0,$07,$01,$00,$BC,$02,$FF,$25,$3C,$3C,$06,$3F,$3C,$01,$00,$00,$41,$B7,$00,$72,$00 ; KARY (reprise)
.byte $95,$10,$88,$13,$20,$03,$FF,$26,$54,$3C,$08,$5A,$32,$01,$00,$00,$20,$A0,$40,$90,$00 ; KRAKEN
.byte $D0,$07,$01,$00,$84,$03,$FF,$27,$62,$46,$08,$72,$46,$01,$00,$00,$20,$C8,$00,$90,$00 ; KRAKEN (reprise)
.byte $78,$15,$70,$17,$E8,$03,$FF,$28,$48,$50,$04,$50,$31,$01,$00,$00,$02,$C8,$02,$F0,$00 ; TIAMAT
.byte $D0,$07,$01,$00,$4C,$04,$FF,$29,$5A,$5A,$04,$55,$4B,$01,$00,$00,$42,$C8,$00,$F0,$00 ; TIAMAT (reprise)
.byte $00,$00,$00,$00,$D0,$07,$FF,$2A,$64,$64,$02,$C8,$64,$01,$01,$10,$00,$C8,$00,$FF,$00 ; CHAOS
   

  

  
  lut_IntroStoryText:
;  .INCBIN "bin/0D_BF20_introtext.bin"
;; JIGS ^ this uses DTE, which my routine can not... so I did my best to re-make it with some fancy tweaks.
;; Since every letter is a sprite as well, we can't use control codes. So the routine uses $FF (sprite the same colour as the background)
;; and reads them as double line breaks. So we have to use $C1 as spaces.
;; The screen is 32 tiles wide, so...
     ; 1,  2,  3,  4,  5,  6,  7,  8,  9,  10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32  
     
.byte $C1,$C1,$C1,$C1,$9D,$AB,$A8,$C1,$BA,$B2,$B5,$AF,$A7,$C1,$AC,$B6,$C1,$B9,$A8,$AC,$AF,$A8,$A7,$C1,$AC,$B1,$FF
.byte $C1,$C1,$A7,$A4,$B5,$AE,$B1,$A8,$B6,$B6,$C0,$C1,$C1,$9D,$AB,$A8,$C1,$BA,$AC,$B1,$A7,$C1,$B6,$B7,$B2,$B3,$B6,$BF,$FF
.byte $C1,$C1,$C1,$C1,$C1,$C1,$C1,$B7,$AB,$A8,$C1,$B6,$A8,$A4,$C1,$AC,$B6,$C1,$BA,$AC,$AF,$A7,$BF,$FF
.byte $C1,$A4,$B1,$A7,$C1,$B7,$AB,$A8,$C1,$A8,$A4,$B5,$B7,$AB,$C1,$A5,$A8,$AA,$AC,$B1,$B6,$C1,$B7,$B2,$C1,$B5,$B2,$B7,$C0,$FF
.byte $C1,$C1,$C1,$C1,$C1,$C1,$C1,$9D,$AB,$A8,$C1,$B3,$A8,$B2,$B3,$AF,$A8,$C1,$BA,$A4,$AC,$B7,$BF,$C1,$FF
.byte $B7,$AB,$A8,$AC,$B5,$C1,$B2,$B1,$AF,$BC,$C1,$AB,$B2,$B3,$A8,$BF,$C1,$A4,$C1,$B3,$B5,$B2,$B3,$AB,$A8,$A6,$BC,$C3,$C0,$FF,$FF
.byte $C6,$A0,$AB,$A8,$B1,$C1,$B7,$AB,$A8,$C1,$BA,$B2,$B5,$AF,$A7,$C1,$AC,$B6,$C1,$AC,$B1,$C1,$A7,$A4,$B5,$AE,$B1,$A8,$B6,$B6,$FF
.byte $C1,$C1,$C1,$8F,$B2,$B8,$B5,$C1,$A0,$A4,$B5,$B5,$AC,$B2,$B5,$B6,$C1,$BA,$AC,$AF,$AF,$C1,$A6,$B2,$B0,$A8,$C3,$79,$FF,$FF
.byte $C1,$C1,$C1,$C1,$C1,$8A,$A9,$B7,$A8,$B5,$C1,$A4,$C1,$AF,$B2,$B1,$AA,$C1,$AD,$B2,$B8,$B5,$B1,$A8,$BC,$BF,$FF
.byte $C1,$C1,$A9,$B2,$B8,$B5,$C1,$BC,$B2,$B8,$B1,$AA,$C1,$BA,$A4,$B5,$B5,$AC,$B2,$B5,$B6,$C1,$A4,$B5,$B5,$AC,$B9,$A8,$BF,$FF
.byte $C1,$C1,$C1,$C1,$C1,$A8,$A4,$A6,$AB,$C1,$AB,$B2,$AF,$A7,$AC,$B1,$AA,$C1,$A4,$B1,$C1,$98,$9B,$8B,$C0,$00 
;; It's the intro text... I'm not gonna spell it out here. :I I just made some edits to spiff it up a bit. Some spaces here, a better ... there, added in a proper ` for the quotation part... 
 
 
JigsIntro:
    LDA #$08               ; set soft2000 so that sprites use right pattern
    STA soft2000           ; table while BG uses left
    LDA #0
    STA $2001              ; turn off the PPU
        
    LDA $2002              ; Set address to $0000 
    LDA #>$0000
    STA $2006
    LDA #<$0000
    STA $2006
    
    JSR LongCall
    .word LoadShopCHRForBank_Z
    .byte $09
    
;;   JIGS - this saves having to have the lut_ShopCHR copy-pasted in this bank.
    
    

    
    LDA #0
    STA joy_a              ; clear A, B, Start button catchers
    STA joy_b
    STA joy_start
    STA cursor
    STA joy_prevdir        ; as well as resetting the cursor and previous joy direction

    LDA $2002           ; reset PPU toggle and set PPU address to $2000
    LDA #>$2000         ;   (start of nametable)
    STA $2006
    LDA #<$2000
    STA $2006

    LDX #($03C0 / 4)    ; Fill the nametable with tile $FF (blank space)
    LDA #$FF            ;  this loop does a full $03C0 writes
  @NTLoop:
      STA $2007
      STA $2007
      STA $2007
      STA $2007
      DEX
      BNE @NTLoop

    LDX #$40            ; Next, fill the attribute table so that all tiles use
    LDA #$00; 1010101      ;  palette 0.  
  @AttrLoop:            ;  
      STA $2007         ;  
      DEX
      BNE @AttrLoop
      
    LDA #$0F
    STA cur_pal
    STA cur_pal+$10
    LDA #$01
    STA cur_pal+2
    STA cur_pal+$12
    LDA #$30
    STA cur_pal+3
     
    LDA #<lut_IntroStoryText  ; load up the pointer to the intro story text
    STA text_ptr
    LDA #>lut_IntroStoryText
    STA text_ptr+1
    
    LDA #2                  ; Text coordinates
    STA dest_y
    LDA #1
    STA dest_x
    
    LDA #$09; 08
    STA MMC5_tmp+3
    LDA #$10; 0F
    STA MMC5_tmp+4
     
    JSR TurnOnScreen
        
IntroLoop:
    LDA #4
    STA MMC5_tmp+6
    JSR IntroLoopFrames
    JSR IntroStory_Joy    
    JSR DrawText
    JMP IntroLoop
    
    
ClearOldLetters:
    LDA MMC5_tmp+7
    CMP #3
    BNE @nope
    LDA #0
    STA MMC5_tmp+7
    JSR ClearOAM       
    @nope:
    RTS
    
NextLetter:
    LDY #0         
    LDA (text_ptr), Y 
    CMP #$01
    BNE @DoIt
      LDA #$FF      ; if control code double line break, print empty sprite
       
    @DoIt:    
   ; SEC
   ; SBC #4         ;; JIGS - why did I have to add this after it was working forever???
   ;; then it started working again and this was breaking it?!?!
    STA MMC5_tmp+2
    LDA MMC5_tmp+3
    STA spr_x
    LDA MMC5_tmp+4
    STA spr_y
    
    LDX sprindex     ; get the sprite index in X

    LDA spr_y        ; load up desired Y coord
    STA oam+$0, X    ;  set UL and UR sprite Y coords
    STA oam+$8, X
    CLC
    ADC #$08         ; add 8 to Y coord
    STA oam+$4, X    ;  set DL and DR Y coords
    STA oam+$C, X

    LDA spr_x        ; load up X coord
    STA oam+$3, X    ;  set UL and DL X coords
    STA oam+$7, X
    CLC
    ADC #$08         ; add 8
    STA oam+$B, X    ;  and set UR and DR X coords
    STA oam+$F, X

    LDA MMC5_tmp     ; get UL tile from the buffer
    CLC
    ADC MMC5_tmp+2   ; add the tile offset to the tile ID
    STA oam+$1, X    ; write it to oam
    LDA #$04
    STA oam+$2, X    ; write to oam
  
    RTS              ; and exit!

    
   
DrawText:
    LDA #1
    STA menustall         ; enable to write while PPU is on?
    JSR CoordToNTAddr
    JSR MenuCondStall
   
   @Draw:
    LDY #0            ; zero Y -- we don't want to use it as an index.  Rather, the pointer is updated
    LDA (text_ptr), Y ;   after each fetch
    BEQ @Finish   ; if the character is 0  (null terminator), exit the routine

    INC text_ptr      ; otherwise, inc source pointer
    BNE :+
      INC text_ptr+1  ;   inc high byte if low byte wrapped

:   CMP #$FF
    BEQ @ControlCode  ;   if it is, jump ahead
    
    LDX $2002         ; reset PPU toggle
    LDX ppu_dest+1    ;  load and set desired PPU address
    STX $2006         ;  do this with X, as to not disturb A, which is still our character
    LDX ppu_dest
    STX $2006

    STA $2007          ; draw the character as-is
    INC ppu_dest       ; increment dest PPU address
    JMP @DrawText_Exit ; and finish after printing one letter
    
    @ControlCode:
    LDA #1
    STA dest_x
    INC dest_y
    INC dest_y
    LDA MMC5_tmp+4
    CLC
    ADC #$10
    STA MMC5_tmp+4    ; update sprite Y coordinates to next line
    LDA #$09; 8
    STA MMC5_tmp+3    ; and reset sprite X 
    JMP @Finish
  
   @DrawText_Exit:
    INC dest_x
    INC MMC5_tmp+7
    
    LDA MMC5_tmp+3
    CLC
    ADC #$08
    STA MMC5_tmp+3
    
   @Finish:    
    LDA #$00          ; reset scroll to 0
    STA $2005
    STA $2005
    STA menustall     ; and disable menu stalling again
    RTS    
    
    
    
    
IntroLoopFrames:
   @loop:
    JSR WaitForVBlank_L      ; wait for VBlank (don't want to turn the screen on midway through the frame)
    JSR IntroSpritePalette
    JSR DrawPalette          ; draw/apply the current palette
    JSR NextLetter
    LDA #>oam                ; do Sprite DMA
    STA $4014
        
    LDA #$08
    STA soft2000             ; set $2000 and soft2000 appropriately
    STA $2000                ;  (no NT scroll, BG uses left pattern table, sprites use right, etc)

    LDA #$1E
    STA $2001                ; enable BG and sprite rendering
    LDA #0
    STA $2005
    STA $2005                ; reset scroll

    LDA #BANK_THIS           ; record current bank and CallMusicPlay
    STA cur_bank
    JSR CallMusicPlay
    
    DEC MMC5_tmp+6
    BNE @loop
    RTS
    
    
IntroStory_Joy:
    JSR UpdateJoy         ; Update joypad data
    LDA joy
    AND #BTN_START        ; see if start was pressed
    BNE :+                ;  if not, just exit
      RTS
:   
    LDA #0
    STA $2001              ; turn off the PPU

    STA joy_a              ; clear A, B, Start button catchers
    STA joy_b
    STA joy_start
    STA cursor
    STA joy_prevdir        ; as well as resetting the cursor and previous joy direction
    JMP GameStart2
    
    
IntroSpritePalette:
    LDA #0
    STA $2001

    LDA MMC5_tmp+6
    CMP #04
    BCS @Darkest
    CMP #02
    BCS @Darker
      LDA #$21
      STA cur_pal+19
      RTS
        
    @Darker:  
    LDA #$11
    STA cur_pal+19
    RTS
    
    @Darkest:  
    LDA #$01
    STA cur_pal+19
    RTS
 
 
 
TurnMenuScreenOn_ClearOAM:
    JSR ClearOAM  
TurnOnScreen: 
    JSR WaitForVBlank_L      ; wait for VBlank (don't want to turn the screen on midway through the frame)
    LDA #>oam                ; do Sprite DMA
    STA $4014
    JSR DrawPalette          ; draw/apply the current palette
    
    LDA #$08
    STA soft2000             ; set $2000 and soft2000 appropriately
    STA $2000                ;  (no NT scroll, BG uses left pattern table, sprites use right, etc)

    LDA #$1E
    STA $2001                ; enable BG and sprite rendering
    LDA #0
    STA $2005
    STA $2005                ; reset scroll

    LDA #BANK_THIS           ; record current bank and CallMusicPlay
    STA cur_bank
    JMP CallMusicPlay
 
 
 
EnterTitleScreenNew:
    JSR IntroTitlePrepare_BankZ    ; clear NT, start music, etc, ; JISG - also ends up drawing the Bridge Scene
    JSR TitleScreenPalette
    JSR DrawTitleWords
    
    BIT $2002                       ;  reset PPU toggle
    
    JSR TurnMenuScreenOn_ClearOAM  
    
    LDA #3
    STA cursor_max
    
   @Loop:
    JSR ClearOAM       

    JSR CheckTitleCursor
    JSR WaitForVBlank_L
       
    LDA #>oam          
    STA $4014          
  ;  JSR DrawPalette
    
    LDA #0             
    STA $2005
    STA $2005

    JSR UpdateJoy          
    LDA #BANK_THIS       
    STA cur_bank

    JSR CallMusicPlay
    LDA joy_a
    ORA joy_start         
    BNE @OptionChosen      

    LDA joy                
    AND #$0C 
    CMP joy_prevdir         
    BEQ @Loop              

    STA joy_prevdir       
    CMP #0            
    BEQ @Loop         

    CMP #$04         
    BNE @Up

  @Down:           
    LDA cursor      
    CLC
    ADC #$01
    CMP cursor_max   
    BCC @Move        
    LDA #0          
    BEQ @Move       

  @Up:               
    LDA cursor       
    SEC
    SBC #$01
    BPL @Move        
    LDA cursor_max   
    SEC
    SBC #$01

  @Move:
    STA cursor          
    JSR PlaySFX_MenuMove 
    JMP @Loop

@OptionChosen:           
    LDA cursor              
    CMP #2
    BEQ @OptionsMenu
        CMP #1                 
        RTS                   
    @OptionsMenu:
    LDA #0
    STA $2001              
    STA menustall           
    LDA #$01
    STA cur_pal+1
    STA cur_pal+13
    JSR ClearNT_FillBackground    
    JSR OptionsMenu
    JMP EnterTitleScreenNew
    
    
CheckTitleCursor:
    LDY cursor          ; put the cursor in Y

    LDA lut_TitleCursor_Y, Y
    STA spr_y
    LDA #$38
    STA spr_x
    
    JMP DrawCursor               ; draw it!  and exit
    
   lut_TitleCursor_Y:   
   .BYTE $38,$48,$58
   

    

    
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  IntroTitlePrepare  [$A219 :: 0x3A229]
;;
;;    Does various preparation things for the intro story and title screen.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; JIGS - This is now just for the title screen, not the intro story. LoadMenuCHRPal ends with swapping to bank 9, so the commented-out parts are done there.
;;        Then returns to this bank to finish doing stuff!

IntroTitlePrepare_BankZ:
  
    JSR LongCall
    .word IntroTitlePrepare
    .byte $0E    
  
  ;  LDA #$08               ; set soft2000 so that sprites use right pattern
  ;  STA soft2000           ;   table while BG uses left
  ;  LDA #0
  ;  STA $2001              ; turn off the PPU

  ;  JSR LoadMenuCHRPal     ; Load necessary CHR and palettes

  ;;  LDA #$41
  ;;  STA music_track        ; Start up the crystal theme music
  ;;; JIGS - stop resetting the damn song!

    LDA #0
    STA joy_a              ; clear A, B, Start button catchers
    STA joy_b
    STA joy_start
    STA cursor
    STA joy_prevdir        ; as well as resetting the cursor and previous joy direction
    RTS
        
 ;   JMP ClearNT            ; then wipe the nametable clean and exit

 ;; JIGS - IntroTitlePrepare now calls to draw the bridge scene GFX... so no wiping the NT here.

ClearNT_FillBackground:
    LDA #$6D ; EF
    STA MMC5_tmp
    JMP ClearNT_Color
    
ClearNT:
    LDA #$00
    STA MMC5_tmp
ClearNT_Color:
    LDA $2002     ; reset PPU toggle
    LDA #$20
    STA $2006
    LDA #$00
    STA $2006     ; set PPU addr to $2000 (start of NT)
    TAY
    LDA MMC5_tmp
    LDX #$03      

@Loop:            ; first loop clears the first $0300 bytes of the NT
      STA $2007
      INY
      BNE @Loop      ; once Y wraps
        DEX          ;  decrement X
        BNE @Loop    ;  and stop looping once X expires (total $0300 iterations)

@Loop2:           ; next loop clears the next $00C0 (up to the attribute table)
      STA $2007
      INY
      CPY #$C0       ; loop until Y reaches #$C0
      BCC @Loop2


    LDA #$FF      ; A=FF (this is what we will fill attribute table with
@Loop3:           ;  3rd and final loop fills the last $40 bytes (attribute table) with FF
      STA $2007
      INY
      BNE @Loop3

    RTS

    

TitleScreenPalette:
    LDX #$0F
  @LoadPalLoop:
    LDA lut_BridgeBGPal, X ; copy $10 colors (full BG palette)
    STA cur_pal, X         ;  from the Bridge scene palette LUT
    DEX                    ; seems wasteful to do this here -- there's a routine
    BPL @LoadPalLoop       ;   you can JSR to that does this (Bridge_LoadPalette)
RTS 
 
lut_BridgeBGPal:
  .BYTE $0F,$00,$02,$30,  $0F,$3B,$11,$24,  $0F,$3B,$0B,$2B,  $0F,$00,$0F,$30 
 
 
 
DrawTitleWords:
 DrawCopyright:
    LDX #0
    JSR @DrawString         ; JSR to the @DrawString to draw the first one
                            ;  then just let code flow into it to draw a second one (2 strings total)
    JSR @DrawString
    ;; JIGS -- draw 1 more, 3 in total. Added some stuff below.

  @DrawString:
    LDA @lut_Copyright+1, X ; get the Target PPU address from the LUT
    STA $2006
    LDA @lut_Copyright, X
    STA $2006
    INX                     ; move X past the address we just read
    INX

  @Loop:
    LDA @lut_Copyright, X   ; get the next character in the string
    BEQ @Exit               ;  if it's zero, exit (null terminator
    STA $2007               ; otherwise, draw the character
    INX                     ; INX to move to next character
    BNE @Loop               ; and keep looping (always branches)

  @Exit:
    INX                     ; INX to move X past the null terminator we just read
    RTS

 ;; LUT for the copyright text.  Simply a 2-byte target PPU address, followed by a
 ;;  null terminated string.  Two strings total.

@lut_Copyright:
   .WORD $20E9
   .BYTE $8C,$98,$97,$9D,$92,$97,$9E,$8E,$00 ; CONTINUE
   .WORD $2129
   .BYTE $97,$8E,$A0,$C1,$90,$8A,$96,$8E,$00 ; NEW GAME
   .WORD $2169
   .BYTE $98,$99,$9D,$92,$98,$97,$9C,$00     ; OPTIONS
   ;.WORD $2328
   ;.BYTE $8C,$FF,$81,$89,$88,$87,$FF,$9C,$9A,$9E,$8A,$9B,$8E,$00  ; "C 1987 SQUARE  "
   ;.WORD $2348
   ;.BYTE $8C,$FF,$81,$89,$89,$80,$FF,$97,$92,$97,$9D,$8E,$97,$8D,$98,$00  ; "C 1990 NINTENDO"
   
   ;; JIGS - using the bridge scene, it already has this info.
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
DrawOptions:
  LDA #24
  STA dest_x
  LDA #9
  STA dest_y
  
  LDX ExpGainOption
  LDA lut_LowNormalHigh, X
  JSR DrawCharMenuString
  
  LDA #11
  STA dest_y
  
  LDX MoneyGainOption
  LDA lut_LowNormalHigh, X
  JSR DrawCharMenuString
  
  LDA #13
  STA dest_y
  
  LDX EncRateOption
  LDA lut_LowNormalHigh, X
  JSR DrawCharMenuString
 
  LDA #17
  STA dest_y
  
  LDX AutoTargetOption
  LDA lut_OnOff, X
  JSR DrawCharMenuString
  
  LDA #19
  STA dest_y
  
  LDX MuteSFXOption
  LDA lut_OnOff, X
  JSR DrawCharMenuString
  
  LDA $2002          ; PPU toggle... needed or not?
  LDA #>$21F8        ; Respond rate is drawn at address $22D6
  STA $2006
  LDA #<$21F8
  STA $2006
  LDA BattleTextSpeed ; get the current respond rate (which is zero based)
  CLC                 ;  add $80+1 to it.  $80 to convert it to the coresponding tile
  ADC #$80+1          ;  for the desired digit to print, and +1 to convert it from zero
  STA $2007           ;  based to 1 based (so it's printed as 1-8 instead of 0-7)  
  LDA #$00            ; reset scroll to 0 (very important!)
  STA $2005
  STA $2005
  RTS
  
  
OptionsMenu:
    LDA #0
    STA $2001
    STA joy
    STA joy_prevdir
    STA cursor                  ; turn off screen and clear some button stuff
    STA menustall
  
    LDA #1
    STA box_x
    LDA #7
    STA box_y
    LDA #30
    STA box_wd
    LDA #15
    STA box_ht
    JSR DrawBox                 ; draws the options box
    
    LDA #6            
    STA cursor_max    
    LDA #0
    JSR DrawCharMenuString      ; draws the static list of changable things
    
    JSR TurnMenuScreenOn_ClearOAM    
    
ReenterOptionsMenu:      
    LDA #1
    STA menustall              ; turn menustall back on
    JSR DrawOptions            ; and draw the option variables (off, on, high, low, etc)

OptionsLoop:
  JSR ClearOAM
  JSR DrawOptionsCursor        ; draw the cursor
  JSR OptionsMenuFrame         ; Do a frame
  
  LDA joy_a                     ; check to see if A has been pressed
  BNE @A_Pressed
  LDA joy_b                     ; then see if B has been pressed
  BNE @B_Pressed
  JSR @OptionDirections
  JMP OptionsLoop               
    
  @B_Pressed:
   RTS  
   
  @A_Pressed: 
    LDA #0                  ; enter ChangeOption with A = 0, as if right was pressed
    JSR ChangeOption
    ;PLA
    ;PLA
    JMP ReenterOptionsMenu
  
  @OptionDirections: 
    LDA joy                 ; mask out the directional buttons from the joy data
    AND #$0F 
    CMP joy_prevdir         ; see if the state of any directional buttons changed
    BEQ @Return             ; if not, keep looping

    STA joy_prevdir         ; otherwise, record changes to direction
    CMP #0                  ; see if the change was buttons being pressed or lifted
    BEQ @Return             ; if buttons were being lifted, do nothing (keep looping)

    CMP #$03                ; see if they pressed up/down or left/right
    BCC @LeftRight

  @UpDown:
    CMP #DOWN
    BNE @Up
      
   @Down:              ; moving down...
    LDA cursor         ;  get cursor, and increment by 1
    CLC
    ADC #$01
    CMP cursor_max    ;  if it's < cursor_max, it's still in range, so
    BCC @Move         ;   jump ahead to move
    LDA #0            ;  otherwise, it needs to be wrapped to zero
    BEQ @Move         ;   (always branches)

   @Up:               ; up is the same deal...
    LDA cursor        ;  get cursor, decrement by 1
    SEC
    SBC #$01
    BPL @Move         ; if the result didn't wrap (still positive), jump ahead to move
    LDA cursor_max    ;  otherwise wrap so that it equals cursor_max-1
    SEC
    SBC #$01

   @Move:
    STA cursor            ; set cursor to changed value
    JMP PlaySFX_MenuMove  ; then play that hideous sound effect and exit
  
   @Return:
    RTS
  
   @LeftRight:
    CMP #RIGHT
    BEQ :+
      LDA #1              ; enter ChangeOption with A = 1 if left was pressed
      JMP :++
    
  : LDA #0                ; enter ChangeOption with A = 0 if right was pressed
  : JSR ChangeOption
    PLA
    PLA
    JMP ReenterOptionsMenu
   
ChangeOption: 
    PHA                   ; backup direction
    JSR PlaySFX_MenuSel  
    LDA cursor
    BEQ @ExpGain
    CMP #1
    BEQ @MoneyGain
    CMP #2
    BEQ @EncounterRate
    CMP #3
    BEQ @BattleTextSpeed
    CMP #4
    BEQ @AutoTargetJump
    PLA                   ; pull direction and toss it
  
   @MenuSFX:
    LDA MuteSFXOption     ; whether left or right is pressed, all you can do is switch it on/off
    BEQ :+
      DEC MuteSFXOption
      RTS
    
  : INC MuteSFXOption
    RTS
    
   @BattleTextSpeed:
    PLA                     ; pull direction and branch 
    BEQ @IncreaseBattleTextSpeed 
        
       DEC BattleTextSpeed
       LDA BattleTextSpeed
       BPL @Return         ; if the result didn't wrap (still positive), return
       LDA #7
       STA BattleTextSpeed
       RTS
    
   @IncreaseBattleTextSpeed:
    LDA BattleTextSpeed
    CMP #7
    BNE :+                  ; if its not over the limit, increase it
       LDA #0 
       STA BattleTextSpeed
       RTS
    
  : INC BattleTextSpeed
   @Return:  
    RTS
    
   @AutoTargetJump:
    JMP @AutoTarget       
    
   @ExpGain:
   PLA 
   BEQ @IncreaseExpGain 
        
       DEC ExpGainOption
       LDA ExpGainOption
       BPL @Return         ; if the result didn't wrap (still positive), return
       LDA #2
       STA ExpGainOption
       RTS
    
   @IncreaseExpGain:
    LDA ExpGainOption
    CMP #2
    BNE :+                  ; if its not over the limit, increase it
       LDA #0 
       STA ExpGainOption
       RTS
    
  : INC ExpGainOption
    RTS 
    
    @MoneyGain:
    PLA 
    BEQ @IncreaseMoneyGain
        
       DEC MoneyGainOption
       LDA MoneyGainOption
       BPL @Return         ; if the result didn't wrap (still positive), return
       LDA #2
       STA MoneyGainOption
       RTS
    
   @IncreaseMoneyGain:
    LDA MoneyGainOption
    CMP #2
    BNE :+                  ; if its not over the limit, increase it
       LDA #0 
       STA MoneyGainOption
       RTS
      
  : INC MoneyGainOption
    RTS 
   
   @EncounterRate:
    PLA 
    BEQ @IncreaseEncounterRate
        
       DEC EncRateOption
       LDA EncRateOption
       BPL @Return         ; if the result didn't wrap (still positive), return
       LDA #2
       STA EncRateOption
       RTS
    
   @IncreaseEncounterRate:
    LDA EncRateOption
    CMP #2
    BNE :+                  ; if its not over the limit, increase it
       LDA #0 
       STA EncRateOption
       RTS
      
  : INC EncRateOption
    RTS 
    
   @AutoTarget:
    PLA                      ; pull direction and toss it
    LDA AutoTargetOption     ; whether left or right is pressed, all you can do is switch it on/off
    BEQ :+
      DEC AutoTargetOption
      RTS
    
  : INC AutoTargetOption
    RTS 
    
    
    
   
DrawOptionsCursor:
    LDY cursor                   ; get current cursor selection
    LDA lut_OptionsCursor_Y, Y   ;  use cursor as an index to get the desired Y coord
    STA spr_y                    ;  write the Y coord
    LDA #$B0                     ; X coord for options menu cursor is always 22
    STA spr_x
    JMP DrawCursor               ; draw it!  and exit
    
  lut_OptionsCursor_Y:          
   .BYTE  $48,$58,$68,$78,$88,$98        

OptionsMenuFrame:
    LDA MenuHush ; InMainMenu ; if in main menu, lower triangle volume
    BEQ :+                    
    JSR HushTriangle
   
 :  JSR WaitForVBlank_L    ; wait for VBlank
    LDA #>oam              ; Do sprite DMA (update the 'real' OAM)
    STA $4014
    
    LDA soft2000           ; reset scroll and PPU data
    STA $2000
    LDA #0
    STA $2005
    STA $2005

    LDA music_track        ; if no music track is playing...
    BPL :+
     LDA dlgmusic_backup   ; restore from backup
     STA music_track

:   LDA #BANK_THIS         ; record this bank as the return bank
    STA cur_bank           ; then call the music play routine (keep music playing)
    JSR CallMusicPlay

    INC framecounter       ; increment the frame counter to count this frame

    LDA #0                 ; zero joy_a and joy_b so that an increment will bring to a
    STA joy_a              ;   nonzero state
    STA joy_b
    JMP UpdateJoy          ; update joypad info, then exit    
    
    
  
    
  
  
SoundTestClearNT:
    LDA $2002     ; reset PPU toggle
    LDA #$20
    STA $2006
    LDA #$00
    STA $2006     ; set PPU addr to $2000 (start of NT)
    LDY #$00      ; zero out A and Y
    TYA           ;   Y will be the low byte of our counter
    LDX #$03      ; X=3 -- this is the high byte of our counter (loop $0300 times)

@Loop:            ; first loop clears the first $0300 bytes of the NT
      STA $2007
      INY
      BNE @Loop      ; once Y wraps
        DEX          ;  decrement X
        BNE @Loop    ;  and stop looping once X expires (total $0300 iterations)

@Loop2:           ; next loop clears the next $00C0 (up to the attribute table)
      STA $2007
      INY
      CPY #$C0       ; loop until Y reaches #$C0
      BCC @Loop2

    LDX #>$23C0
    LDA #<$23C0
    STX $2006   ; write X as high byte
    STA $2006   ; A as low byte
    
    LDX #0
  @AttrLoop:
      LDA lut_SoundtestAttTable, X   ; copy over attribute bytes
      STA $2007
      INX
      CPX #$40
      BNE @AttrLoop           ; loop until all $40 bytes copied
      
      @Loop3:
      LDA $FF
      STA $2007
      INX 
      CPX #$40
      BNE @Loop3
    
    LDA $2002              ; Set address to $1000 
    LDA #>$1000
    STA $2006
    LDA #<$1000
    STA $2006    
      
    LDA #>WeaselChr
    STA tmp+1        
    LDA #<WeaselChr
    STA tmp
    LDX #$40
    LDY #0

CHRLoad_Cont_2:
    LDA (tmp), Y      ; read a byte from source pointer
    STA $2007         ; and write it to CHR-RAM
    INY               ; inc our source index
    DEX
    BNE CHRLoad_Cont_2
    RTS 
  
  lut_SoundtestAttTable:
  .BYTE $00,$00,$00,$00,$00,$00,$00,$00
  .BYTE $00,$00,$00,$00,$00,$00,$00,$00
  .BYTE $F0,$F0,$F0,$F0,$F0,$F0,$F0,$F0
  .BYTE $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  .BYTE $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  .BYTE $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  .BYTE $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  .BYTE $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  
  

    SoundTestZ:
    LDA #BANK_THIS           ; record current bank and CallMusicPlay
    STA cur_bank
        
    JSR SoundTestClearNT               ; clear the nametable
   
    LDA #$02                        
    STA box_x                       
    LDA #$0A
    STA box_y
    LDA #$1C
    STA box_wd
    LDA #$05
    STA box_ht
    JSR DrawBox        
    LDA #$02                        
    STA box_x                       
    LDA #$14
    STA box_y
    LDA #$1C
    STA box_wd
    LDA #$08
    STA box_ht
    JSR DrawBox        
  
   ; Weasel colours! 
    LDA #$38
    STA cur_pal+17
    LDA #$36
    STA cur_pal+18
    LDA #$17
    STA cur_pal+19
    STA cur_pal+22
    
    LDA #$07
    STA cur_pal+21
    LDA #$0F
    STA cur_pal+23
    STA cur_pal+2
      
    JSR TurnMenuScreenOn_ClearOAM   ; then clear OAM and turn the screen on
    
  SoundTestMenuLoop:    
    JSR ClearOAM                  ; clear OAM (erasing    all existing sprites)
    JSR DrawSoundTestCursor       ; draw the cursor
    JSR DrawSoundTestHole
    JSR WeaselSprite
    JSR SoundTest_DrawSongName
    JSR SoundTest_DrawInstructions
    JSR SoundTestFrame            ; Do a frame
        
    LDA joy_a                     ; check to see if A has been pressed
    BNE @A_Pressed
    LDA joy_b                     ; then see if B has been pressed
    BNE @B_Pressed
    LDA joy_start     
    BNE @Start_Pressed
    LDA joy_select
    BNE @Zoom
    JSR SoundTestSelect
    JMP SoundTestMenuLoop         ;  rinse, repeat

  @B_Pressed:
    LDA #0            ; turn PPU off
    STA $2001
    STA $4015           ; and silence the APU.  Music sill start next time MusicPlay is called.
    STA $5015           ; and silence the MMC5 APU.
    STA joy_a         ; flush A, B, and Start joypad recordings
    STA joy_b
    STA joy_start
    STA joy_select
    STA soundtesthelper
    RTS               ; and exit the main menu (by RTSing out of its loop)

  @A_Pressed:
    LDA soundtesthelper
    CMP #1
    BCC @MusicOn
      LDA #0
      STA soundtesthelper
      STA $4015             ; silence APU
      STA $5015             ; and silence the MMC5 APU. (JIGS)
      
      ;LDA #$80           ; If yes, write $80 to the music track to mark that the song is over
      ;STA music_track    ;  All channels will be silenced next frame
      JMP SoundTestMenuLoop          ; then return to main menu loop
      
    @MusicOn:  
    LDA #0
    STA $4015             ; silence APU
    STA $5015             ; and silence the MMC5 APU. (JIGS)
    JSR WaitForVBlank_L
    LDA #1
    STA soundtesthelper
    LDA soundtest
    CLC
    ADC #$41
    STA music_track  
    JMP SoundTestMenuLoop          ; then return to main menu loop
    
    @Start_Pressed:
    JSR DrawWeasel
    JMP SoundTestMenuLoop
    
    @Zoom:
    JSR WeaselZoomStart
    JMP SoundTestMenuLoop
   
SoundTestFrame:
    JSR WaitForVBlank_L    ; wait for VBlank
    LDA #>oam              ; Do sprite DMA (update the 'real' OAM)
    STA $4014

    LDA soft2000           ; reset scroll and PPU data
    STA $2000
    LDA #0
    STA $2005
    STA $2005

    LDA #BANK_THIS           ; record current bank and CallMusicPlay
    STA cur_bank
    JSR CallMusicPlay
    
    INC framecounter       ; increment the frame counter to count this frame

    LDA #0                 ; zero joy_a and joy_b so that an increment will bring to a
    STA joy_a              ;   nonzero state
    STA joy_b
    STA joy_start
    STA joy_select
    JMP UpdateJoy          ; update joypad info, then exit
 
SoundTestSelect:
    LDA joy           ; get joypad data
    AND #$0C          ;  isolate up/down buttons
    CMP joy_prevdir   ;  compare it to previously checked button states
    BEQ @Exit         ; if they equal, do nothing (button has already been pressed and is currently just held)

    STA joy_prevdir   ; otherwise, button state has changed, so record new button state in prevdir
    CMP #$00          ;  and check to see if a button is being pressed or released (nonzero=pressed)
    BEQ @Exit         ;  if zero, button is being released, so do nothing and just exit

    CMP #$04          ; see if the user pressed down or up
    BNE @Up

  @Down:              ; moving down...
    LDA #0
    STA soundtesthelper    
    DEC soundtest
    LDA soundtest     
    CMP #$FF
    BNE :+
      LDA #23
      STA soundtest
      CLC
 :  JMP @Exit

  @Up:                ; up is the same deal...
    LDA #0
    STA soundtesthelper    
    INC soundtest
    LDA soundtest
    CMP #24
    BNE @Exit
      LDA #00
      STA soundtest      
      
 @Exit:
    RTS

DrawSoundTestCursor:
    LDA #$16
    STA spr_x              ; set cursor X coord to $58
    LDA #$60
    STA spr_y              ; and that's the cursor Y coord
    JMP DrawCursor         ; draw the cursor and exit    

DrawSoundTestHole:
    LDA #$08
    STA spr_x              ; set cursor X coord to $58
    LDA #$83
    STA spr_y              ; and that's the cursor Y coord
    LDA #<lutHole          ; load up the pointer to the hole sprite
    STA tmp                ; arrangement
    LDA #>lutHole          ; and store that pointer in (tmp)
    STA tmp+1
    LDA #$DC               ; hole tiles start at $DC
    STA tmp+2
    JMP Draw2x2Sprite

    
SoundTest_DrawSongName:
    LDA #$05
    STA dest_x
    LDA #$0C
    STA dest_y   
    LDA soundtest      ; 0-23 
    LDX #24            ; each song name is 24 bytes across
    JSR MultiplyXA     ; output of A is low byte of multiplication
    CLC
    ADC #<lut_SongNamesLong
    STA text_ptr
    TXA
    ADC #>lut_SongNamesLong   ; note:  no CLC here, we want the carry from the low byte
    STA text_ptr+1
    
DrawSongName:
    LDA #1
    STA menustall         ; enable to write while PPU is on?
    JSR CoordToNTAddr
    JSR MenuCondStall
   
   @Draw:
    LDY #0            ; zero Y -- we don't want to use it as an index.  Rather, the pointer is updated
    LDA (text_ptr), Y ;   after each fetch
    BEQ @DrawSongName_Exit   ; if the character is 0  (null terminator), exit the routine

    INC text_ptr      ; otherwise, inc source pointer
    BNE :+
      INC text_ptr+1  ;   inc high byte if low byte wrapped

:   CMP #$1A          ; values below $1A are control codes.  See if this is a control code
    BCC @ControlCode  ;   if it is, jump ahead
    
    LDX $2002         ; reset PPU toggle
    LDX ppu_dest+1    ;  load and set desired PPU address
    STX $2006         ;  do this with X, as to not disturb A, which is still our character
    LDX ppu_dest
    STX $2006

    STA $2007         ; draw the character as-is
    INC ppu_dest      ; increment dest PPU address
    JMP @Draw         ; and repeat the process until terminated
    
    @ControlCode:
    LDA #$04
    STA dest_x
    INC dest_y
    JMP DrawSongName
  
   @DrawSongName_Exit:
    LDA #$00          ; reset scroll to 0
    STA $2005
    STA $2005
    STA menustall     ; and disable menu stalling again
    RTS

  SoundTest_DrawInstructions:
    LDA #$04
    STA dest_x
    LDA #$16
    STA dest_y   
    LDA #<SoundTestInstructions
    STA text_ptr
    LDA #>SoundTestInstructions 
    STA text_ptr+1
    JMP DrawSongName

Zheep:
.byte $A3,$AB,$B3,$C4,$00  ; Zhp! (It's the sound weasels make.)
  
   DrawWeasel:  
    LDA #$01
    LDX #$1B
    JSR RandAX
    STA dest_x
    LDA #$02
    LDX #$08
    JSR RandAX
    STA dest_y
    DEC weasels
    LDA #<Zheep
    STA text_ptr
    LDA #>Zheep
    STA text_ptr+1
    JSR DrawSongName
    
    WeaselSprite:
    LDA weasels
    CMP #$F0          ; if less than 9, stop drawing weasels (oawoo)
    BCS @Yes
      LDA #0
      STA weasels
      RTS
     
    @Yes:
    LDX #$0F
    JSR MultiplyXA
    WeaselSpriteZoom:
    STA spr_x
    LDA #$83
    STA spr_y
    LDA #<lutWeasel   ; load up the pointer to the weasel sprite
    STA tmp           ; arrangement
    LDA #>lutWeasel   ; and store that pointer in (tmp)
    STA tmp+1
    LDA #$00          ; weasel tiles start at $00
    STA tmp+2
    JMP Draw2x2Sprite
    
   lutWeasel:
   .BYTE $00, $04      ; UL sprite = tile 0, palette 3
   .BYTE $02, $04      ; DL sprite = tile 2, palette 3
   .BYTE $01, $04      ; UR sprite = tile 1, palette 3
   .BYTE $03, $04      ; DR sprite = tile 3, palette 3
   
   lutHole:
   .BYTE $00, $05      ; UL sprite = tile 0, palette 3
   .BYTE $02, $05      ; DL sprite = tile 2, palette 3
   .BYTE $01, $05      ; UR sprite = tile 1, palette 3
   .BYTE $03, $05      ; DR sprite = tile 3, palette 3
  
  
   WeaselZoomStart:
   LDA weasels              ; load variable "weasels"; if the weasel is on screen, this will be anything but 0
   CMP #0                   ; 
   BNE WeaselZoomBegin      ; if "weasels" is NOT 0, weasel is printed, so skip ahead to set it in motion
     LDA #245               ; if "weasels" is 0, weasel has not been printed yet; so load 245
     STA weasels            ; and save as "weasels", to start printing on the right side of the screen
     JMP WeaselZoomFrame   
     
   WeaselZoom:
   DEC weasels
   DEC weasels
   DEC weasels
   LDA weasels
   CMP #9                   ; if less than 9, stop drawing weasels (oawoo)
   BCS WeaselZoomFrame
       LDA #0
       STA weasels
       RTS
       
   WeaselZoomBegin:
   LDA spr_x
   STA weasels   
   
   WeaselZoomFrame:
   JSR WeaselSpriteZoom
   JSR DrawSoundTestCursor       ; draw the cursor
   JSR DrawSoundTestHole
   JSR WaitForVBlank_L    ; wait for VBlank
   LDA #>oam              ; Do sprite DMA (update the 'real' OAM)
   STA $4014

   LDA soft2000           ; reset scroll and PPU data
   STA $2000
   LDA #0
   STA $2005
   STA $2005
   JSR CallMusicPlay
   JSR ClearOAM                  ; clear OAM (erasing all existing sprites)
   JMP WeaselZoom
  
WeaselChr:
  .INCBIN "bin/weasel.chr"   




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Unadjust Equipment stats  [$ED92 :: 0x3EDA2]
;;
;;    This is called when you enter the weapon or armor menu.  It edits all the characters
;;  stats to reflect what they would be if they removed all their equipment.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


UnadjustEquipStats:
 LDA #0
 STA equipmenu_tmp
 
 @Loop:
 AND #$C0
 TAX
 
    LDA ch_righthand, X
    BEQ :+
    JSR @AdjustWeapon
    
  : LDA ch_lefthand, X
    BEQ :+
    JSR @AdjustArmor  ; left hand
    
  : LDA ch_head, X
    BEQ :+
    JSR @AdjustArmor  ; head
    
  : LDA ch_body, X
    BEQ :+
    JSR @AdjustArmor  ; body
    
  : LDA ch_hands, X
    BEQ :+
    JSR @AdjustArmor  ; hands
    
  : LDA ch_accessory, X
    BEQ :+
    JSR @AdjustArmor  ; accessory
 
  : JSR UnadjustBBEquipStats  ; do a few adjustments for BB/MAs... and zero absorb for all
 
 LDA equipmenu_tmp         ; add $40 to the source index (look at next character)
 CLC
 ADC #$40
 STA equipmenu_tmp
 BCC @Loop                 ; keep looping until source index wraps (wraps after 4 characters)
 RTS 
 
    @AdjustWeapon:
      SEC
      SBC #$01              ; subtract 1 from the equipment ID (they're 1-based, not 0-based... 0 is empty slot)

      ASL A
      ASL A                 ; then multiply by 4 (A = equip_id*4) -- high bit (equipped) is lost here, no need to mask it out
      ASL A               ; multiply by another 2  (A= weapon_id*8) -- there are 8 bytes of stats per weapon
      STA tmp             ; this is the low byte of our source pointer
      LDA #0
      TAY
      ADC #>lut_WeaponData ; include carry into high byte of source pointer
      STA tmp+1           ; (tmp) is now a pointer to stats for this weapon

     ; LDX tmp+7           ; load char index into X
     ; LDY #0              ; zero source index Y

      LDA ch_hitrate, X   ; get character's hit rate
      SEC
      SBC (tmp), Y        ; subtract the weapon's hit rate bonus
      STA ch_hitrate, X   ; and write back to character's hit rate
      ;; JIGS - some battle stat prep added in:
      LSR A
      LSR A
      LSR A
      LSR A
      LSR A
      CLC
      ADC #$01
      STA ch_numhits, X
      ;;   

      INY                 ; inc source index

      LDA ch_damage, X       ; get char's dmg
      SEC
      SBC (tmp), Y        ; subtract weapon's damage bonus
      STA ch_damage, X       ; and write back
      
      LDA #00               ;; JIGS - clear these out
      STA ch_critrate, X
      STA ch_weaponelement, X
      STA ch_weaponcategory, X
      STA ch_weaponsprite, X
      STA ch_weaponpal, X      
      
      LDA #$01
      STA ch_numhitsmult, X ;; JIGS - this is always 1, weapon equipped or not.
      
      ;LDX equipmenu_tmp   ; restore X to the equipment source index
      RTS
      
    @AdjustArmor:  
      SEC
      SBC #$01            ; subtract 1 from the equipment ID (they're 1-based, not 0-based... 0 is empty slot)
      ASL A
      ASL A               ; then multiply by 4 (A = equip_id*4) -- high bit (equipped) is lost here, no need to mask it out
      CLC                 ; (A= armor_id*8)
      ADC #<lut_ArmorData ; add A to desired pointer
      STA tmp             ;  and store pointer to (tmp)
      LDA #0
      TAY
      ADC #>lut_ArmorData
      STA tmp+1           ; (tmp) is now a pointer to stats for this armor

      ;LDX tmp+7           ; get char index in X
      ;LDY #0              ; zero our source index Y

      LDA ch_evasion, X   ; get character's evade
      CLC
      ADC (tmp), Y        ; add the armor's evade penalty rate (removing the penalty)
      STA ch_evasion, X   ; and write back
      
      ;LDX equipmenu_tmp   ; then restore X to equipment source index
      RTS                 ; and exit

      
;;;;;;;;;;;;;;;;;;;
;;
;;  UnadjustBBEquipStats  [$EEB7 :: 0x3EEC7]
;;
;;    This is sort of a continuation of above 'UnadjustEquipStats' routine
;;
;;    Here, the dmg stat for BB/MAs is zerod.. or the absorb and elemental resistence
;;  for all classes is zerod.
;;
;;;;;;;;;;;;;;;;;;;

UnadjustBBEquipStats:
    ;LDX tmp+7           ; get char index into X
    LDA ch_class, X     ; get the char's class
    AND #$0F            ;; JIGS - cut off high bits (sprite)

    CMP #CLS_BB         ; check if he's a black belt or master
    BEQ @BlackBelt      ;  if he isn't, just exit
    CMP #CLS_MA         ; if he is...
    BNE @Armor

  @BlackBelt:
    LDA #0              ; zero his damage stat
    STA ch_damage, X

  @Armor:               ; for armor...
    LDA #0
    ;LDX tmp+7               ; get char index
    STA ch_defense, X       ; zero absorb
    STA ch_elementresist, X ; and elemental resistence
    STA ch_elementweak, X   ; JIGS - and elemental weakness why not
    RTS                     ; then exit      


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Readjust Equipment stats  [$ED92 :: 0x3EDA2]
;;
;;    This is called when you EXIT the weapon or armor menu.  It edits all the characters
;;  stats to reflect the changes made by their equipment.
;;
;;    This is very similar in format to above UnadjustEquipmentStats routine
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


ReadjustEquipStats:
 LDA #0
 STA equipmenu_tmp
 
 @Loop:
 AND #$C0
 TAX
 
    LDA ch_righthand, X
    BEQ :+
    JSR @AdjustWeapon
    
  : LDA ch_lefthand, X
    BEQ :+
    JSR @AdjustArmor  ; left hand
    
  : LDA ch_head, X
    BEQ :+
    JSR @AdjustArmor  ; head
    
  : LDA ch_body, X
    BEQ :+
    JSR @AdjustArmor  ; body
    
  : LDA ch_hands, X
    BEQ :+
    JSR @AdjustArmor  ; hands
    
  : LDA ch_accessory, X
    BEQ :+
    JSR @AdjustArmor  ; accessory
 
  : JSR ReadjustBBEquipStats  ; do a few adjustments for BB/MAs... 
 
 LDA equipmenu_tmp         ; add $40 to the source index (look at next character)
 CLC
 ADC #$40
 STA equipmenu_tmp
 BCC @Loop                 ; keep looping until source index wraps (wraps after 4 characters)
 RTS 

  @AdjustWeapon:
    SEC
    SBC #$01               ; subtract 1 from the equip ID (equipment is 1 based -- 0 is an empty slot)
    ASL A
    ASL A                  ; multiply by 4 
    ASL A                  ; multiply by another 2 (A now = weapon_id * 8)
    STA tmp                ; put in tmp as low byte of our pointer
    LDA #0
    TAY
    ADC #>lut_WeaponData   ; add high byte of our pointer (including any appropriate carry)
    STA tmp+1              ; fill tmp+1 to complete our pointer

    LDA ch_hitrate, X      ; get char's hit rate
    CLC
    ADC (tmp), Y           ; add to it the weapon's hit bonus
    STA ch_hitrate, X      ; and write it back

    INY                    ; inc source index

    LDA ch_damage, X       ; get char's damage
    CLC
    ADC (tmp), Y           ; add weapon's damage bonus
    STA ch_damage, X       ; and write back
    
    ;; JIGS - and do other battle stat prepping here
    
    INY
    LDA (tmp), Y
    STA ch_critrate, X
    INY
    INY 
    LDA (tmp), Y
    STA ch_weaponelement, X
    INY
    LDA (tmp), Y
    STA ch_weaponcategory, X
    INY
    LDA (tmp), Y
    STA ch_weaponsprite, X
    INY
    LDA (tmp), Y
    STA ch_weaponpal, X
    RTS

  @AdjustArmor:            ; A = armor_id * 4
    SEC
    SBC #$01               ; subtract 1 from the equip ID (equipment is 1 based -- 0 is an empty slot)
    ASL A
    ASL A                  ; multiply by 4 (this drops the high bit -- no need to mask it out)
    CLC
    ADC #<lut_ArmorData    ; add low byte of pointer to our A
    STA tmp                ; and store it in tmp
    LDA #0
    TAY
    ADC #>lut_ArmorData    ; then get high byte of pointer (ADC to catch appropriate carry)
    STA tmp+1              ; (tmp) is now a pointer to this armor's stats

    LDA ch_evasion, X      ; get char's evade
    SEC
    SBC (tmp), Y           ; subtract armor evade penalty
    STA ch_evasion, X      ; and write it back
    INY                    ; inc source index

    LDA ch_defense, X      ; get absorb
    CLC
    ADC (tmp), Y           ; add absorb bonus
    STA ch_defense, X      ; and write back

    LDA ch_elementresist, X ; get elemental resistence
    INY                     ;   inc source index
    ORA ($10), Y            ; combine this armor's elemental resistence
    STA ch_elementresist, X ; and write back
    RTS                    ; and exit





;;;;;;;;;;;;;;;;;;;
;;
;;  ReadjustBBEquipStats  [$EEDB :: 0x3EEEB]
;;
;;    This is sort of a continuation of above 'ReadjustEquipStats' routine
;;  This checks BlackBelts to see if they have equipment equipped, and adjusts their
;;  stats appropriately (since they have special bonuses for being unequipped).
;;
;;;;;;;;;;;;;;;;;;;

ReadjustBBEquipStats:
    LDA ch_hitrate, X
    LSR A
    LSR A
    LSR A
    LSR A
    LSR A
    CLC
    ADC #$01
    STA ch_numhits, X  ; figure out numhits! for everyone!
    
    LDA #$01                  ; always 1 until a spell changes it
    STA ch_numhitsmult, X
    
    LDA ch_class, X    ; get this char's class
    AND #$0F             ;; JIGS - cut off high bits (sprite)

    CMP #CLS_BB        ; see if he's a black belt or master... if yes, jump ahead
    BEQ @BlackBelt     ; otherwise, exit
    CMP #CLS_MA
    BNE @Exit

  @BlackBelt:
    LDA ch_damage, X          ; check this BB's damage stat
    BEQ @NoWeaponEquipped     ; if zero, we know this BB has no weapon equipped
                              ; we know this because UnadjustBBEquipStats zeros damage for blackbelts.
                              ; thus the only way it could be nonzero is if it had a weapon bonus added.

  @WeaponEquipped:
    LDA ch_strength, X        ; if a weapon is equipped... get strength stat
    LSR A                     ;  /2
    ADC ch_damage, X          ; and add to damage
    STA ch_damage, X
    JMP @Armor ;RTS                       ; equipped BB's dmg = (str/2 + weapon)

  @NoWeaponEquipped:
    LDA ch_level, X           ; if unequipped, get current experience level
    CLC
    ADC #$01                  ; add 1 (levels are stored 0 based in RAM -- ie '0' is really level 1)
    ASL A                     ; multiply by 2
    STA ch_damage, X          ; and set dmg.  Unequipped BB's dmg = (level*2)
    STA ch_critrate, X        ; JIGS - so is crit rate
    
    ;; - adding numhits, since battle prep doesn't do it anymore!
    LDA #$AC
    STA ch_weaponsprite, X ; and give fisties sprite
    
    LDA ch_numhits, X ; and double numhits
    ASL A
    STA ch_numhits, X

  @Armor:                     ; for armor....
    LDA ch_defense, X         ; get absorb
    BNE @Exit                 ; if nonzero he has something equipped (absorb would be 0 otherwise), so just exit

    LDA ch_level, X           ; otherwise, get level + 1
    CLC
    ADC #$01
    STA ch_defense, X         ; Unequipped BB's absorb=level
     
  @Exit:
    RTS                       ; and exit

    
    



  
   

   



;; This checks if the player attacker is a cleric, and doubles their crit chance against undead enemies. 
;; JIGS - leaving this here as proof of concept... My hack idea originally turned fighters/knights into undead-slayers. You can do the same!
    
 ClericCheck:                       ;; this also changes the enemy's hit chance if the player is hidden
    LDA battle_defenderisplayer                       ; is it player attacking?
    BNE @CheckHiddenPlayer          ; if not, check if defending player is hidden
    RTS     ; remove this and enable the rest!
     
;    LDY #ch_class - ch_stats        ; 
;    LDA (CharStatsPointer), Y   ; Check the class
;    AND #$0F                        ; cut off high bits (sprite)
;    BEQ :+                          ; if fighter
;    CMP #$06                        ; or knight
;    BNE @return
;  : LDA btl_defender_category        
;    AND #CATEGORY_UNDEAD+CATEGORY_WERE 
;    BEQ @return
;    ASL math_critchance             ; *2 Crit chance against undead/cursed
;    @return:
;    RTS
 
   @CheckHiddenPlayer:
    LDA #ch_battlestate - ch_stats   ; if defender is hidden, subtract another 40 from the attacker's hit chance
    AND #$10 ; knock off non-hiding bits
    BNE :+
      LDA math_hitchance
      SEC
      SBC #40
      STA math_hitchance
 :  RTS
 
 
    ;; This checks if the player attacker is a given class, and gives a status effect to their critical hits.
  
 CritCheck:
    LDA #0
    STA MMC5_tmp
    ;LDA battle_defenderisplayer
    ;BNE @CritReturn
 ;   LDA #1
 ;   LDX #100                        ; 
 ;   JSR RandAX                      ; 
 ;   CMP #50                         ; Player needs to roll 50 or over to do their special thing.
 ;   BCC @CritReturn
    LDA btl_attacker
    JSR PrepCharStatPointers
    
    LDY #ch_class - ch_stats        ; 
    LDA (CharStatsPointer), Y    ; Check the class
    AND #$0F             ;; JIGS - cut off high bits (sprite)
    CMP #$01                        ; IF thief, goto CritSteal
    BEQ @CritSteal                   
    CMP #$07                        ; IF ninja, goto CritSteal
    BEQ @CritSteal                   
    CMP #$02                        ; IF bbelt, goto CritStun
    BEQ @CritStun
    CMP #$08                        ; IF master, goto CritStun
    BEQ @CritStun
    CMP #$03                        ; IF redmage, goto CritSlow
    BEQ @CritSlow
    CMP #$09                        ; IF redwiz, goto CritSlow
    BEQ @CritSlow
    CMP #$05                        ; IF blackmage, goto CritConfuse
    BEQ @CritConfuse
    CMP #$0B                        ; IF blackwiz, goto CritConfuse
    BEQ @CritConfuse
    CMP #$04                        ; IF whitemage, goto CritStrength
    BEQ @CritStrength
    CMP #$0A                        ; IF whitewiz, goto CritStrength
    BEQ @CritStrength
        @CritReturn:
        RTS
    
    @CritStun:
    LDA btl_defender_elementresist
    AND #$01
    BEQ :+                          ; if defender resists the special attack's element (stun 01)
    RTS                             ; cancel specialty
  : LDA #$10                        ; Stun ailment as used by STUN's effectivity in original game
    JMP @CritAddAilment
                
    @CritConfuse:
    LDA btl_defender_elementresist
    AND #$08
    BEQ :+                          ; if defender resists the special attack's element (dark/confuses 08)
    RTS                             ; cancel specialty
  : LDA #$80                        ; Confuse ailment as used by CONF's effectivity in original game
    JMP @CritAddAilment
         
    @CritSlow:
    LDA btl_defender
    LDY #en_numhitsmult  
    LDA (EnemyRAMPointer), Y                    ; hit multiplier from RAM stats
    STA MMC5_tmp
    DEC MMC5_tmp    ; Decrease their hit multiplier
    LDA MMC5_tmp
    BNE :+                          
       ; if it went to 0, don't save it
        RTS    
    
    STA (EnemyRAMPointer), Y
 :  LDA #BTLMSG_LOSTINTELLIGENCE
    STA MMC5_tmp
    RTS
     
    @CritStrength:                  
    LDA btl_attacker_damage
    CLC
    ADC #4
    BCC :+
      LDA #$FF
 : 	LDY #ch_damage - ch_stats
    STA (CharStatsPointer), Y
    LDA #BTLMSG_WEAPONSSTRONGER    
    STA MMC5_tmp    
    RTS 
    
    @CritSteal:
    LDA MMC5_tmp+6
    STA tmp
    LDA MMC5_tmp+7
    STA tmp+1
    LDA #0                           
    STA tmp+2                        
    JSR AddGPToParty     
     LDA #BTLMSG_STOLEGOLD
     STA MMC5_tmp
     RTS

   
    @CritAddAilment:
    ;PHA
    ;AND btl_defender_ailments    ; See if defender has this ailment already
    ;BEQ :+                       ; If yes...
    ;   PLA                       ; fix the stack
    ;   RTS                       ; cancel the specialty
    BIT btl_defender_ailments
    BNE @noailment
 :  ;PLA
    ORA btl_defender_ailments    ; add to existing ailments
    STA btl_defender_ailments    
    LDA (CharStatsPointer), Y    ; Check the class (Y is still character class)
    CMP #$05                     ; is it still the black mage's turn?
    BEQ :+                       ; if yes, go print Confused
    CMP #$0B                     ; is it still the black wizard's turn?
    BNE :++                      ; if not, go print Paralyzed, since it must be the bbelts's turn
  :    LDA #BTLMSG_CONFUSED      
       STA MMC5_tmp 
       RTS
       
  : LDA #BTLMSG_PARALYZED_A
    STA MMC5_tmp
        
    @noailment:
    RTS

    
    
    ThiefHiddenCheck:
    LDY #ch_battlestate - ch_stats
    LDA (CharStatsPointer), Y
    AND #$10 ; clear all but hiding bits
    BEQ @Return    
    
    LDA btl_attacker_hitrate ; regardless of class, double their hit rate
    ASL A ; btl_attacker_hitrate ; I realise I could just do this, but I'm worried it might overflow, so I'm gonna...
    BCC :+
    LDA #$FF                  ; cap at FF
 : 	STA btl_attacker_hitrate 
    
    LDA btl_attacker_critrate ; regardless of class, double their crit rate
    ASL A ; btl_attacker_critrate ; I realise I could just do this, but I'm worried it might overflow, so I'm gonna...
    BCC :+
    LDA #$FF                  ; cap at FF
 : 	STA btl_attacker_critrate 
    
    LDY #ch_class - ch_stats         
    LDA (CharStatsPointer), Y
    AND #$0F             ;; JIGS - cut off high bits (sprite)
    CMP #$01                     ; if thief   
    BEQ @HiddenBoost
    CMP #$07                     ; if ninja
    BEQ @HiddenBoost
       @Return: 
       RTS
    
    @HiddenBoost:
    LDA btl_attacker_hiddenstrength 
    LSR A ; btl_attacker_hiddenstrength ; divide by 2 
    CLC
    ADC btl_attacker_damage
    BCC :+
    LDA #$FF                  ; cap at FF
 : 	STA btl_attacker_damage       ; I think this should basically make the strength 50% higher, or x1.5

    LDA btl_attacker_hiddencritrate
    CLC
    ADC btl_attacker_critrate
    BCC :+
    LDA #$FF                  ; cap at FF
 : 	STA btl_attacker_critrate       ; Thieves get x3 CritRate
    RTS
      













    ;; JIGS : Loads the class to see if the character is a black belt or master, then loads sprite to decide what palette to use for the li'l fisties
      
    HandPalette:
    LDA battle_defenderisplayer       ; gotta make sure its a player attacking, first. If not, skip all this.
    BNE @Done
    
    ;LDY #ch_class - ch_stats        
    ;LDA (CharStatsPointer), Y    ; Check the class
    ;CMP #$02
    ;BEQ @Fists                      ; is it a black belt?
    ;CMP #$08
    ;BNE @Done                       ; or master?
    
    ;; No reason to check, really... This allows everyone to have a little green/tan or reddish dust cloud when they attack. :D
    ;; But only BB/Masters get fist icons. That's set when everything else about weapons is set.
    
    @Fists:
    LDY #ch_class - ch_stats
    LDA (CharStatsPointer), Y    ; Check the sprite
    AND #$F0             ;; JIGS - cut off low bits to get sprite
       
    CMP #$10 ; Thief
    BEQ @Tan
    CMP #$20 ; Black belt
    BEQ @Tan
    CMP #$80 ; Master
    BEQ @Tan
    CMP #$50 ; Black Mage
    BEQ @Tan
    CMP #$B0 ; Black Wizard
    BEQ @Tan
    
    @RedWhite: ; everything else
    LDA #$36
    STA btl_usepalette + $19
    LDA #$16
    STA btl_usepalette + $1A 
    LDA #$07
    STA btl_usepalette + $1B
    RTS
    
    @Tan:   
    LDA #$28
    STA btl_usepalette + $19
    LDA #$18
    STA btl_usepalette + $1A 
    LDA #$08
    STA btl_usepalette + $1B
    
    @Done:
    RTS   

      
      
      
      
;; JIGS - here is all the 3 Save File things.




SaveScreen:
  LDA #0
  STA cursor                      ; flush cursor, joypad, and prev joy directions
  STA joy
  STA joy_prevdir
  STA $2001               ; turn off the PPU
  STA menustall           ; disable menu stalling
  STA Asleep           ; clear this variable, which will help reset music later
  JSR ClearNT             ; clear the NT
  LDA #1
  STA $5113                ; swap battery-backed PRG RAM into $8000 page   
  JSR SaveScreenHelper  
 ; JSR LongCall
 ; .word LoadBattleSpritesForBank_Z
 ; .byte $09
 
 LDA #1
 STA box_x
 LDA #4
 STA box_y
 LDA #30
 STA box_wd
 LDA #8
 STA box_ht
 JSR DrawBox             ; Draw Save Slot Box 1
 LDA #12
 STA box_y
 JSR DrawBox             ; Draw Save Slot Box 2
 LDA #20
 STA box_y
 JSR DrawBox             ; Draw Save Slot Box 3
 LDA #8
 STA box_x
 LDA #1
 STA box_y
 LDA #16
 STA box_wd
 LDA #3
 STA box_ht
 JSR DrawBox             ; Draw Save/Load title box
   
 LDA #07
 STA dest_y
 LDA #04
 STA dest_x
 LDA #02
 STA cursor_max          ; and Cursor max!
 LDA #$06
 JSR DrawCharMenuString ; Draw Save slot text: SAVE 1, SAVE 2, SAVE 3
 JSR DrawSaveScreenNames 
 LDA weasels
 BNE SaveGameStuff
  
 LoadGameStuff:
 JSR SaveScreenTitleTextPosition
 LDA #$07
 JSR DrawCharMenuString
 JSR TurnMenuScreenOn_ClearOAM 
 JMP SaveScreenLoop

 SaveGameStuff: 
 JSR SaveScreenTitleTextPosition
 LDA #$08
 JSR DrawCharMenuString
 JSR TurnMenuScreenOn_ClearOAM 
 JSR SaveScreenLoop
 LDA #0
 STA weasels
 RTS
  
 SaveScreenLoop:
 JSR ClearOAM
 JSR DrawSaveScreenCursor
 JSR DrawSaveScreenSprites
 JSR SaveScreenFrame
    LDA joy_b
    BNE @B_Pressed       ; check to see if A or B have been pressed
    LDA joy_a
    BNE @A_Pressed       ; if neither pressed.. see if the cursor has been moved
    LDA joy              ; get joy
    CMP #$30            
    BEQ @Select_Pressed    
    AND #$0C             ; isolate up/downbuttons
    CMP joy_prevdir      ; compare to previous buttons to see if button state has changed
    BEQ SaveScreenLoop   ; if no change.. do nothing, and continue loop
 
    STA joy_prevdir      ; otherwise, record changes

    CMP #0               ; then check to see if buttons have been pressed or not
    BEQ SaveScreenLoop   ; if not.. do thing, and continue loop
    
    CMP #$08             ; if up was pressed
    BEQ @Previous

   @Next:
    INC cursor
    LDA cursor           ; if Up pressed, increase amount 
    CMP #3
    BNE @MoveDone        ; if not, jump ahead to @MoveDone
    LDA #0               ; if yes, wrap limit to 1
    JMP @MoveDone        ; 
    
    @Previous:           ; otherwise, it was down
    DEC cursor
    LDA cursor
    CMP #$FF
    BNE @MoveDone        ; if it hasn't gone below 0, that's all -- continue loop
    LDA cursor_max       ; otherwise (below 0), wrap to max
    
  @MoveDone:             ; code reaches here when A is to be the new amount to buy
    STA cursor
    JMP SaveScreenLoop   ; and continue loop

  @B_Pressed:            ; if B pressed....
    LDA #0
    STA $5113            ; swap battery-backed PRG RAM into $6000 page   
    SEC                  ; set C to tell the title screen we didn't load a game
    RTS                  ; 
 
  @A_Pressed:            ; if A pressed...
    LDA cursor
    CMP #02
    BEQ @ThirdSaveSlot
    CMP #01
    BEQ @SecondSaveSlot
    LDA weasels
    BEQ :+    
      JSR SaveFirstSlot
      JMP GameSaved
    : JMP LoadFirstSlot    
    
    @ThirdSaveSlot:
    LDA weasels
    BEQ :+    
      JSR SaveThirdSlot
      JMP GameSaved
    : JMP LoadThirdSlot    
    
    @SecondSaveSlot:
    LDA weasels
    BEQ :+    
      JSR SaveSecondSlot
      JMP GameSaved
    : JMP LoadSecondSlot        
    
    @Select_Pressed:
     LDA #02
     STA dest_y
     LDA #04 ; 10
     STA dest_x
     LDA #01
     STA menustall
     LDA #10
     JSR DrawCharMenuString
     JSR ConfirmDelete
     BCS JumpSaveScreen ; if B pressed, redraw screen
    
    LDA cursor
    CMP #02
    BEQ @DeleteThirdSaveSlot
    CMP #01
    BEQ @DeleteSecondSaveSlot
      JMP DeleteFirstSave
    
    @DeleteThirdSaveSlot:
      JMP DeleteThirdSave
    
    @DeleteSecondSaveSlot:
      JMP DeleteSecondSave
    
    JumpSaveScreen:
    JMP SaveScreen
    
    ConfirmDelete:
    JSR SaveScreenFrame
    LDA joy_a
    BNE @DoDelete
    LDA joy_b
    BEQ ConfirmDelete  ;  if both are zero, keep looping.  Otherwise...
    SEC
    RTS
    
    @DoDelete:
    CLC
    RTS
    
    
  GameSaved:
  LDA #$56
  STA music_track      
  STA Asleep
  LDY cursor
  LDA SavedTextYLUT, Y
  STA dest_y
  LDA #04
  STA dest_x
  LDA #01
  STA menustall
  LDA #09
  JSR DrawCharMenuString
  JSR DrawSaveScreenNames
  JMP SaveScreenLoop
  
  SavedTextYLUT:
  .byte $09,$11,$19
    
    
  SaveOverworldInfo:
    LDX #0            ; zero X for upcoming loop
    LDA ow_scroll_x           ; copy over OW information
    STA unsram_ow_scroll_x
    LDA ow_scroll_y
    STA unsram_ow_scroll_y
    LDA vehicle
    STA unsram_vehicle  
    RTS    
    
  SaveFirstSlot:
    JSR SaveOverworldInfo

  @CopyLoop:
      LDA unsram       , X    ; copy $400 bytes from "unsram" to sram
      STA   sram       , X
      LDA unsram + $100, X
      STA   sram + $100, X
      LDA unsram + $200, X
      STA   sram + $200, X
      LDA unsram + $300, X
      STA   sram + $300, X
      INX
      BNE @CopyLoop           ; loop until X expires ($100 iterations)

    LDA #$55                  ; set assertion bytes
    STA sram_assert_55        ;  if assertion bytes are ever different values
    LDA #$AA                  ;  the game knows SRAM has been corrupted
    STA sram_assert_AA        ;   like due to battery failure or something
    LDA #$00
    STA sram_checksum         ; clear the checksum byte so that it will not interfere with checksum calculations
    LDX #$00                  ; clear X (loop counter)
    CLC                       ; and clear carry so it isn't included in checksum

  @ChecksumLoop:
      ADC sram       , X    ; sum every byte in SRAM
      ADC sram + $100, X    ;  note that carry is not cleared between additions
      ADC sram + $200, X
      ADC sram + $300, X
      INX
      BNE @ChecksumLoop     ; loop until X expires ($100 iterations)
                      ; after loop, A is now what the checksum computes to
    EOR #$FF          ;  to force it to compute to FF, invert the value
    STA sram_checksum ;  and write it to the checksum byte.  Checksum calculations will now result in FF
    RTS

    
  SaveSecondSlot:
    JSR SaveOverworldInfo

  @CopyLoop:
      LDA unsram       , X    ; copy $400 bytes from "unsram" to sram
      STA   sram2       , X
      LDA unsram + $100, X
      STA   sram2 + $100, X
      LDA unsram + $200, X
      STA   sram2 + $200, X
      LDA unsram + $300, X
      STA   sram2 + $300, X
      INX
      BNE @CopyLoop           ; loop until X expires ($100 iterations)

    LDA #$55                  ; set assertion bytes
    STA sram2_assert_55       ;  if assertion bytes are ever different values
    LDA #$AA                  ;  the game knows SRAM has been corrupted
    STA sram2_assert_AA       ;   like due to battery failure or something
    LDA #$00
    STA sram2_checksum        ; clear the checksum byte so that it will not interfere with checksum calculations
    LDX #$00                  ; clear X (loop counter)
    CLC                       ; and clear carry so it isn't included in checksum

  @ChecksumLoop:
      ADC sram2       , X    ; sum every byte in SRAM
      ADC sram2 + $100, X    ;  note that carry is not cleared between additions
      ADC sram2 + $200, X
      ADC sram2 + $300, X
      INX
      BNE @ChecksumLoop     ; loop until X expires ($100 iterations)

                       ; after loop, A is now what the checksum computes to
    EOR #$FF           ;  to force it to compute to FF, invert the value
    STA sram2_checksum ;  and write it to the checksum byte.  Checksum calculations will now result in FF
    RTS

    SaveThirdSlot:
    JSR SaveOverworldInfo

  @CopyLoop:
      LDA unsram       , X    ; copy $400 bytes from "unsram" to sram
      STA   sram3       , X
      LDA unsram + $100, X
      STA   sram3 + $100, X
      LDA unsram + $200, X
      STA   sram3 + $200, X
      LDA unsram + $300, X
      STA   sram3 + $300, X
      INX
      BNE @CopyLoop           ; loop until X expires ($100 iterations)

    LDA #$55                  ; set assertion bytes
    STA sram3_assert_55       ;  if assertion bytes are ever different values
    LDA #$AA                  ;  the game knows SRAM has been corrupted
    STA sram3_assert_AA       ;   like due to battery failure or something
    LDA #$00
    STA sram3_checksum        ; clear the checksum byte so that it will not interfere with checksum calculations
    LDX #$00                  ; clear X (loop counter)
    CLC                       ; and clear carry so it isn't included in checksum

  @ChecksumLoop:
      ADC sram3       , X    ; sum every byte in SRAM
      ADC sram3 + $100, X    ;  note that carry is not cleared between additions
      ADC sram3 + $200, X
      ADC sram3 + $300, X
      INX
      BNE @ChecksumLoop     ; loop until X expires ($100 iterations)

                       ; after loop, A is now what the checksum computes to
    EOR #$FF           ;  to force it to compute to FF, invert the value
    STA sram3_checksum ;  and write it to the checksum byte.  Checksum calculations will now result in FF
    RTS    
    
    LoadFirstSlot:
    LDA sram_assert_55              ; check sram assertion values to make sure
    CMP #$55                        ;  sram is not corrupt.  If they are not what are expected...
    BNE UhOhNewGame                    ;  then do a new game.
    LDA sram_assert_AA
    CMP #$AA
    BNE UhOhNewGame
    
    JSR VerifyChecksum1              ; Then verify checksum to ensure save game integrity
    BCS UhOhNewGame                    ;  if it failed, do a new game
    
    LDX #$00
    : LDA   sram, X                 ; Copy all of SRAM to unsram
      STA unsram, X
      LDA   sram+$100, X
      STA unsram+$100, X
      LDA   sram+$200, X
      STA unsram+$200, X
      LDA   sram+$300, X
      STA unsram+$300, X
      INX
      BNE :-
    LDA #0
    STA $5113         ; swap battery-backed PRG RAM into $6000 page  
    STA MenuHush
    JMP GameLoaded
    
    LoadSecondSlot:
    LDA sram2_assert_55              ; check sram assertion values to make sure
    CMP #$55                        ;  sram is not corrupt.  If they are not what are expected...
    BNE UhOhNewGame                    ;  then do a new game.
    LDA sram2_assert_AA
    CMP #$AA
    BNE UhOhNewGame
    
    JSR VerifyChecksum2              ; Then verify checksum to ensure save game integrity
    BCS UhOhNewGame                    ;  if it failed, do a new game
    
    LDX #$00
    : LDA   sram2, X                 ; Copy all of SRAM to unsram
      STA unsram, X
      LDA   sram2+$100, X
      STA unsram+$100, X
      LDA   sram2+$200, X
      STA unsram+$200, X
      LDA   sram2+$300, X
      STA unsram+$300, X
      INX
      BNE :-
    LDA #0
    STA $5113         ; swap battery-backed PRG RAM into $6000 page  
    STA MenuHush
    JMP GameLoaded
    
    UhOhNewGame:
    JMP StartNewGame
    
    LoadThirdSlot:
    LDA sram3_assert_55              ; check sram assertion values to make sure
    CMP #$55                        ;  sram is not corrupt.  If they are not what are expected...
    BNE UhOhNewGame                    ;  then do a new game.
    LDA sram3_assert_AA
    CMP #$AA
    BNE UhOhNewGame
    
    JSR VerifyChecksum3              ; Then verify checksum to ensure save game integrity
    BCS UhOhNewGame                    ;  if it failed, do a new game
    
    LDX #$00
    : LDA   sram3, X                 ; Copy all of SRAM to unsram
      STA unsram, X
      LDA   sram3+$100, X
      STA unsram+$100, X
      LDA   sram3+$200, X
      STA unsram+$200, X
      LDA   sram3+$300, X
      STA unsram+$300, X
      INX
      BNE :-
    LDA #0
    STA $5113         ; swap battery-backed PRG RAM into $6000 page  
    STA MenuHush
    JMP GameLoaded
    
    
    
    DeleteFirstSave:
    LDA #0
    TAX
    : STA sram, X
      STA sram+$100, X
      STA sram+$200, X
      STA sram+$300, X
      INX
      BNE :-
      JMP GameDeleted
      
    DeleteSecondSave:
    LDA #0
    TAX
    : STA sram2, X
      STA sram2+$100, X
      STA sram2+$200, X
      STA sram2+$300, X
      INX
      BNE :-
      JMP GameDeleted  
      
    DeleteThirdSave:
    LDA #0
    TAX
    : STA sram3, X
      STA sram3+$100, X
      STA sram3+$200, X
      STA sram3+$300, X
      INX
      BNE :-
        
  GameDeleted:
  ;LDA #02
  ;STA dest_y
  LDA #10
  STA dest_x
  LDA #01
  STA menustall
  LDA #11
  JSR DrawCharMenuString
  JSR DrawSaveScreenNames
  JSR PlaySFX_Error
  JSR WaitForButton
  JMP SaveScreen
    
  WaitForButton:
  JSR SaveScreenFrame
  LDA joy_a
  ORA joy_b
  BEQ WaitForButton
  RTS
    
    
    SaveScreenFrame:
    LDA MenuHush ; InMainMenu ; if in main menu, lower triangle volume
    BEQ :+                    ; otherwise, in Inn or Loading screen
    JSR HushTriangle
    
  : JSR WaitForVBlank_L    ; wait for VBlank
    LDA #>oam              ; Do sprite DMA (update the 'real' OAM)
    STA $4014

    LDA soft2000           ; reset scroll and PPU data
    STA $2000
    LDA #0
    STA $2005
    STA $2005

    LDA #BANK_THIS         ; record this bank as the return bank
    STA cur_bank           ; then call the music play routine (keep music playing)
    JSR CallMusicPlay

    INC framecounter       ; increment the frame counter to count this frame

    LDA #0                 ; zero joy_a and joy_b so that an increment will bring to a
    STA joy_a              ;   nonzero state
    STA joy_b
    STA joy_select
    STA joy_start
    JMP UpdateJoy          ; update joypad info, then exit
    
    
    
 DrawSaveScreenCursor:
  LDX cursor            
  LDA @lut, X           
  STA spr_y             
  LDA #$10
  STA spr_x             
  JMP DrawCursor        

  @lut:
    .BYTE $38,$78,$B8

  
 SaveScreenTitleTextPosition:
 LDA #02
 STA dest_y
 LDA #11
 STA dest_x
 RTS
      
      
      
      
      
      
 
DrawSaveScreenNames:
LDX #0
STX MMC5_tmp
LDA MMC5_tmp

@LoopStart:
JSR SaveScreenCharPointer
LDY #2 ; 0 is class, 1 is ailments, 2 is start of name 

@Loop:
LDA (CharacterStatPointer), Y  ; get name byte
CMP #0
BNE :+
LDA #$C1
:  
STA SaveScreenCharBuf, X  ; put in string buffer
INY
INX
CPY #9 ; name is 7 letters
BNE @Loop

INX ; make a space for control codes and ... spaces!
INX 
INX ; inc X until its 10, 10 bytes per character = 120 bytes
INC MMC5_tmp
LDA MMC5_tmp  ; 12 characters yet?
CMP #12
BNE @LoopStart

;; JIGS - I DON'T CARE, IT WORKS. >:(

LDA #$C1 ; spaces to put between names on the same line, or just to fill blank space
         ; because every character has 10 letters in this
STA SaveScreenCharBuf+7   ; character 1 
STA SaveScreenCharBuf+8
STA SaveScreenCharBuf+9
STA SaveScreenCharBuf+27  ; character 3
STA SaveScreenCharBuf+28
STA SaveScreenCharBuf+29
STA SaveScreenCharBuf+47 ; character 5
STA SaveScreenCharBuf+48
STA SaveScreenCharBuf+49
STA SaveScreenCharBuf+67 ; character 7
STA SaveScreenCharBuf+68
STA SaveScreenCharBuf+69
STA SaveScreenCharBuf+87 ; character 9
STA SaveScreenCharBuf+88
STA SaveScreenCharBuf+89
STA SaveScreenCharBuf+107 ; character 11
STA SaveScreenCharBuf+108
STA SaveScreenCharBuf+109

LDA #01 ; two lines breaks
STA SaveScreenCharBuf+37 ; character 4
STA SaveScreenCharBuf+38 
STA SaveScreenCharBuf+77 ; character 8
STA SaveScreenCharBuf+78 

LDA #05 ; one line break
STA SaveScreenCharBuf+17 ; character 2 
STA SaveScreenCharBuf+18 ; character 2 
STA SaveScreenCharBuf+19 ; character 2 
STA SaveScreenCharBuf+39 ; character 4
STA SaveScreenCharBuf+57 ; character 6 
STA SaveScreenCharBuf+58 ; character 6 
STA SaveScreenCharBuf+59 ; character 6
STA SaveScreenCharBuf+79 ; character 8
STA SaveScreenCharBuf+97 ; character 10 
STA SaveScreenCharBuf+98 ; character 10 
STA SaveScreenCharBuf+99 ; character 10 

LDA #0 ; end 
STA SaveScreenCharBuf+117 ; character 12

LDA #13
STA dest_x
LDA #06
STA dest_y
LDA #<SaveScreenCharBuf
STA text_ptr
LDA #>SaveScreenCharBuf
STA text_ptr+1
JMP DrawComplexString 


SaveScreenChar_LUT:
.word SaveScreenChar1  ; 0, 1
.word SaveScreenChar2  ; 2, 3
.word SaveScreenChar3  ; 4, 5 
.word SaveScreenChar4  ; 6, 7
.word SaveScreenChar5  ; 8, 9
.word SaveScreenChar6  ; A, B
.word SaveScreenChar7  ; C, D
.word SaveScreenChar8  ; E, F
.word SaveScreenChar9  ; 10, 11
.word SaveScreenChar10 ; 12, 13
.word SaveScreenChar11 ; 14, 15
.word SaveScreenChar12 ; 16, 17

SaveScreenCharPointer:
    ASL A
    TAY
    LDA SaveScreenChar_LUT, Y         
    STA CharacterStatPointer
    LDA SaveScreenChar_LUT+1, Y
    STA CharacterStatPointer+1
    RTS     
    
DrawSaveScreenSprites:
LDA #0
STA MMC5_tmp               ; loop counter

LDA cursor
LDX #8
JSR MultiplyXA
STA MMC5_tmp+1 ; slot 1 = 0, slot 2 = 8, slot 3 = 16
LSR A
STA MMC5_tmp+2 ; slot 1 = 0, slot 2 = 4, slot 3 = 8

@LoopStart:
LDA MMC5_tmp+2
JSR SaveScreenCharPointer
LDY #2
LDA (CharacterStatPointer), Y  ; get first letter of first character's name in this save slot
BEQ @RTS                  ; if its 0, this save slot must be empty, so skip drawing sprites
LDX MMC5_tmp+1
LDA SaveScreenCharSprite_LUT, X ; MMC5_tmp+1 just gets the position to draw the sprite on the screen.
STA spr_x
INX
LDA SaveScreenCharSprite_LUT, X
STA spr_y
INX
STX MMC5_tmp+1

LDY #0
LDA (CharacterStatPointer), Y  ; get sprite from different save slots
AND #$F0                  ; knock off class bits
JSR ShiftSpriteHightoLow
TAY                       
LDA lutClassBatSprPalette, Y ; get sprite palette
STA tmp+1
LDA lutClassBatSpriteID, Y ; get tile ID in CHR
STA tmp
JSR DrawSimple2x3Sprite
INC MMC5_tmp               ; loop counter
INC MMC5_tmp+2             ; thing that gets the right character
LDA MMC5_tmp
CMP #4                     ; only draw 4 sprites
BNE @LoopStart
@RTS:
RTS


lutClassBatSpriteID:
  .BYTE $00,$06,$0C,$12,$18,$1E    ; unpromoted classes
  .BYTE $24,$2A,$30,$36,$3C,$42    ; promoted classes

lutClassBatSprPalette:
  .BYTE $01,$00,$00,$01,$01,$00    ; unpromoted classes
  .BYTE $01,$01,$00,$01,$01,$00    ; promoted classes

 SaveScreenCharSprite_LUT:
  .byte $56,$27
  .byte $A6,$27
  .byte $56,$40
  .byte $A6,$40
  .byte $56,$67
  .byte $A6,$67
  .byte $56,$80
  .byte $A6,$80
  .byte $56,$A7
  .byte $A6,$A7
  .byte $56,$C0
  .byte $A6,$C0





VerifyChecksum1:
    LDA #$00      ; clear A
    LDX #$00      ; and X
    CLC           ; and C!
@Loop:
      ADC sram, X   
      ADC sram+$100, X   
      ADC sram+$200, X
      ADC sram+$300, X
      INX
      BNE @Loop
      JMP ChecksumSuccessCheck

VerifyChecksum2:
    LDA #$00      ; clear A
    LDX #$00      ; and X
    CLC           ; and C!
@Loop:
      ADC sram2, X   
      ADC sram2+$100, X   
      ADC sram2+$200, X
      ADC sram2+$300, X
      INX
      BNE @Loop
      JMP ChecksumSuccessCheck

VerifyChecksum3:
    LDA #$00      ; clear A
    LDX #$00      ; and X
    CLC           ; and C!
@Loop:
      ADC sram3, X   
      ADC sram3+$100, X   
      ADC sram3+$200, X
      ADC sram3+$300, X
      INX
      BNE @Loop

ChecksumSuccessCheck:
    CMP #$FF         ; if result does not equal $FF, the checksum has failed
    BNE ChecksumFail
    CLC
    RTS

ChecksumFail:
    SEC
    RTS






BattleConfirmation:
  LDA #21
  STA dest_y
  LDA #03
  STA dest_x
  LDA #01
  STA menustall
  LDA #12
  JMP DrawCharMenuString


  
  
  
LoadEnemyStats:
    LDA #0
    LDY #0
    @ClearLoop:
    STA btl_enemystats, Y
    DEY
    BNE @ClearLoop
    
    LDA #$09
    STA btl_loadenemystats_counter              ; loop down-counter
    LDA #$00
    STA btl_loadenemystats_index               ; loop up-counter / enemy index
    
  @EnemyLoop:
    LDA btl_loadenemystats_index              ; Put a pointer to the current enemy's stat RAM
    JSR GetEnemyRAMPtr                          ;    in btltmp+A
    
    LDX btl_loadenemystats_index              ; Check to see if this enemy even exists
    JSR DoesEnemyXExist
    BNE :+
      JMP @NextEnemy        ; if it doesn't, skip ahead...
      
  : LDX #21                ; multiply current enemy ID by #$15  ($15 bytes of data per enemy)
    JSR MultiplyXA          ;   add the result to data_EnemyStats to generate a pointer to the enemy
    CLC                     ;   data in ROM.
    ADC #<data_EnemyStats  
    STA EnemyROMPointer
    TXA
    ADC #>data_EnemyStats
    STA EnemyROMPointer+1
    
    LDY #0
   @Loop:
    LDA (EnemyROMPointer), Y
    STA (EnemyRAMPointer), Y
    INY
    CPY #21               ; copy 21 bytes of ROM data into RAM.
    BNE @Loop
   
    LDA #0
    STA (EnemyRAMPointer), Y ; <- en_aimagpos
    INY                 
    STA (EnemyRAMPointer), Y ; <- en_aiatkpos
    INY 
    LDA #$01
    STA (EnemyRAMPointer), Y ; en_numhitsmult, default to hit multiplier of 1
    
    INY
    LDA #0
    STA (EnemyRAMPointer), Y ; <- en_ailments

    LDY #04
    LDA (EnemyROMPointer), Y ; load max HP low byte
    PHA                      ; push low byte
    INY
    LDA (EnemyROMPointer), Y ; load max HP high byte
    
    LDY #en_hp+1
    STA (EnemyRAMPointer), Y ; save as current HP high byte
    PLA                      ; pull low byte
    DEY
    STA (EnemyRAMPointer), Y ; save as current HP low byte
    
    LDX btl_loadenemystats_index   ; get the enemy ID
    LDA btl_enemyIDs, X
    LDY #en_enemyid
    STA (EnemyRAMPointer), Y    
    
  @NextEnemy:
    INC btl_loadenemystats_index           ; inc up-counter to look at next enemy
    DEC btl_loadenemystats_counter           ; dec down-counter
    BEQ :+
      JMP @EnemyLoop    ; loop until all 9 enemies processed
      
  :  RTS
    

    
  
  
  
  
    
    
    ;; this is stuff copied over from Bank C so there's more room to play around with more interesting things.
    
   EnemyExistLoop:
    LDA #$00
    LDX #$08
    JSR RandAX
    TAX                     ; random enemy slot [0,8] 
    
   CheckTargetLoop:
    LDA btl_enemyIDs, X
    CMP #$FF   
    BEQ EnemyExistLoop               ; if no, then loop to find one
    RTS                            

PlayerAttackEnemy_PhysicalZ:
  ;  LDA $88         ; JIGS - reload this from Battle_DoPlayerTurn in Bank C
                    ; Which is weird, because that already did an AND #$03 to the $88 thing, then saved it? Oh well.
    
    ORA #$80
    STA btl_attacker
    
    AND #$03
    JSR PrepCharStatPointers        ; get pointer to attacker's OB and IB stats
    
    LDA AutoTargetOption
    BNE @SkipAutoTarget
    
    JSR CheckTargetLoop             ; JIGS - doublecheck the enemy you're attacking exists!
    
    @SkipAutoTarget:
    STX btl_defender_index       ; set defender index
    STX btl_defender

    TXA
    JSR GetEnemyRAMPtr     
    
    ;;;;;;;;;;;;;;;;;;;;;;;;
    ;; Attacker/PLAYER stats
    LDA #$00                        ; clear this value to zero to indicate the defender
    STA battle_defenderisplayer     ;   is an enemy
    
    LDY #ch_class - ch_stats
    LDA (CharStatsPointer), Y
    AND #$F0                        ;; JIGS cut off low bits to get sprite
    JSR ShiftSpriteHightoLow
    STA btl_attacker_sprite
    
    LDY #ch_damage - ch_stats
    LDA (CharStatsPointer), Y
    STA btl_attacker_damage
    STA btl_attacker_hiddenstrength
    
    INY ; ch_hitrate
    LDA (CharStatsPointer), Y
    STA btl_attacker_hitrate
    
    LDY #ch_weaponsprite - ch_stats
    LDA (CharStatsPointer), Y
    STA btl_attacker_graphic
    
    INY ; ch_weaponpal
    LDA (CharStatsPointer), Y
    STA btl_attacker_varplt
    
    INY ; ch_weaponelement
    LDA (CharStatsPointer), Y
    STA btl_attacker_element
    
    INY ; ch_weaponcategory
    LDA (CharStatsPointer), Y
    STA btl_attacker_category
    
    INY ; ch_numhits
    LDA (CharStatsPointer), Y
    STA btl_attacker_numhits
    
    INY ; ch_numhitsmult          
    LDA (CharStatsPointer), Y
    STA btl_attacker_numhitsmult
    
    INY ; ch_critrate             
    LDA (CharStatsPointer), Y
    STA btl_attacker_critrate
    STA btl_attacker_hiddencritrate
    
   ; LDY #ch_ailments - ch_stats     ;; - JIGS ?? no? 
   ; LDA (CharStatsPointer), Y
   ; STA btl_attacker_ailments
    
    JSR ThiefHiddenCheck ;; JIGS - note that this is added, so it upgrades the Thief's stats a bit if they're hidden.
    
    ;;;;;;;;;;;;;;;;;;;;;;;;
    ;; Defender/ENEMY stats
    LDY #en_ailments                ; ailment from RAM
    LDA (EnemyRAMPointer), Y
    STA btl_defender_ailments
    
    LDY #en_category
    LDA (EnemyRAMPointer), Y
    STA btl_defender_category
    
    LDY #en_elemweakness             ; 
    LDA (EnemyRAMPointer), Y
    STA btl_defender_elementweakness ; 
    
    LDY #en_evade                   ; evade from RAM
    LDA (EnemyRAMPointer), Y
    STA btl_defender_evasion
    
    LDY #en_defense                 ; absorb/defense from RAM
    LDA (EnemyRAMPointer), Y
    STA btl_defender_defense
    
    LDY #en_hp                      ; HP from RAM
    LDA (EnemyRAMPointer), Y
    STA btl_defender_hp
    INY
    LDA (EnemyRAMPointer), Y
    STA btl_defender_hp+1
   
    RTS
    
    
    
    
    
;;  input:
;;    A = defending player index
;;    X = attacking enemy slot index    
  
 EnemyAttackPlayer_PhysicalZ:
   ; STX btl_attacker
    LDA btl_randomplayer
    
    ;LDX btl_attacker
    
    AND #$03
    STA btl_defender_index       ; record the defender index
                                    ; btl_defender is set later
    JSR PrepCharStatPointers        ; get pointer to char stats in CharBackupStatsPointer and CharStatsPointer
    
    ;STX battle_attacker_index       ; record attacker index
        
    LDA btl_attacker
    JSR GetEnemyRAMPtr     
    
    ;;;;;;;;;;;;;;;;;;;;;
    ; Attacker ENEMY stats
    
    LDA #$01                    ; mark that the defender is a player and not an enemy
    STA battle_defenderisplayer
    
    LDY #en_strength          
    LDA (EnemyRAMPointer), Y
    STA btl_attacker_damage
    
    LDY #en_category     
    LDA (EnemyRAMPointer), Y  
    STA btl_attacker_category
    
    LDY #en_elemresist     
    LDA (EnemyRAMPointer), Y  
    STA btl_attacker_element  
    
    LDY #en_hitrate 
    LDA (EnemyRAMPointer), Y
    STA btl_attacker_hitrate
    
    LDY #en_numhitsmult       
    LDA (EnemyRAMPointer), Y  
    STA btl_attacker_numhitsmult
    
    LDY #en_numhits
    LDA (EnemyRAMPointer), Y
    STA btl_attacker_numhits
    
    LDY #en_critrate
    LDA (EnemyRAMPointer), Y
    STA btl_attacker_critrate
    
    LDY #en_attackail
    LDA (EnemyRAMPointer), Y
    STA btl_attacker_attackailment
    
    LDY #en_ailments           
    LDA (EnemyRAMPointer), Y
    STA btl_attacker_ailments
    
    ;;;;;;;;;;;;;;;;;;;;;
    ; Defender PLAYER CHARACTER stats
    
    ;; JIGS - first two are always 0, so saving space...
    LDA #$00
    STA btl_defender_category
    STA btl_defender_elementweakness
    STA GuardDefense
    
    LDY #(ch_evasion - ch_stats)
    LDA (CharStatsPointer), Y
    STA btl_defender_evasion
    
    LDY #(ch_battlestate - ch_stats)
    LDA (CharStatsPointer), Y     ; check battlestate for Guarding
    AND #$80                      ; if not guarding, resume as normal
    BEQ :+                        ; otherwise, do a bit of math...
    
    LDY #(ch_level - ch_stats)
    LDA (CharStatsPointer), Y     ; guard defense is level * 2
    ASL A
    STA GuardDefense
    
  : LDY #(ch_defense - ch_stats)
    LDA (CharStatsPointer), Y
    CLC
    ADC GuardDefense
    STA btl_defender_defense
    
    LDY #(ch_magicdefense - ch_stats)
    LDA (CharStatsPointer), Y
    STA btl_defender_magicdefense
    
    LDY #(ch_elementresist - ch_stats)
    LDA (CharStatsPointer), Y
    STA btl_defender_elementresist
    
    LDY #(ch_curhp - ch_stats)       
    LDA (CharStatsPointer), Y
    STA btl_defender_hp
    INY
    LDA (CharStatsPointer), Y
    STA btl_defender_hp+1
    
    LDY #(ch_ailments - ch_stats)    
    LDA (CharStatsPointer), Y        
    STA btl_defender_ailments
    
    LDA btl_defender_index        
    ORA #$80
    STA btl_defender

    RTS
  
  
    
    
    
;; JIGS -- Below this point are copies of routines in other banks... It's easier to copy-paste them here than to meddle with LongCalls back and forth to JSR certain things.


    
PrepCharStatPointers:
    ASL A                               ; 2* for pointer lut
    TAY
    LDA lut_IBCharStatsPtrTable, Y      ; copy pointers from pointer luts
    STA CharBackupStatsPointer
    LDA lut_IBCharStatsPtrTable+1, Y
    STA CharBackupStatsPointer+1
    LDA lut_CharStatsPtrTable, Y
    STA CharStatsPointer
    LDA lut_CharStatsPtrTable+1, Y
    STA CharStatsPointer+1
    RTS    
  
    
GetEnemyRAMPtr:
    LDX #28                ; multiply enemy index by $14  (number of bytes per enemy)
    JSR MultiplyXA
    CLC                     ; then add btl_enemystats to the result
    ADC #<btl_enemystats                ;; FB
    STA EnemyRAMPointer
    TXA
    ADC #>btl_enemystats                ;; 6B
    STA EnemyRAMPointer+1
    RTS

DoesEnemyXExist:
    LDA btl_enemyIDs, X
    CMP #$FF
    RTS    
    
RespondDelay:
    LDA btl_responddelay        ; get the delay
    STA MMC5_tmp+2 ; $6AD0      ; stuff it in temp ram as loop counter
    : JSR WaitForVBlank_L       ; wait that many frames
      JSR BattleUpdateAudio     ; updating audio each frame
      DEC MMC5_tmp+2        ;; JIGS - Respond Delay doesn't seem to work in this bank... trying a different counter.
      BNE :-
    RTS    
    
BattleUpdateAudio:
    LDA #BANK_THIS
    STA a:cur_bank          ; set the swap-back bank (necessary because music playback is in another bank)
    LDA a:music_track
    BPL :+                  ; if the high bit of the music track is set (indicating the current song is finished)...
      LDA btl_followupmusic ;   then play the followup music
      STA a:music_track
:   JSR CallMusicPlay_L     ; Call music playback to keep it playing
    ;JMP UpdateBattleSFX     ; and update sound effects to keep them playing    
    
UpdateBattleSFX:
    JSR SwapBattleSFXBytes
    LDA btlsfx_framectr
    BEQ :+
      JSR UpdateBattleSFX_Square
      JSR UpdateBattleSFX_Noise
      DEC btlsfx_framectr
  : JSR SwapBattleSFXBytes
    RTS

UpdateBattleSFX_Square:
    LDA btlsfxsq2_len
    BEQ @Exit
    DEC btlsfxsq2_framectr
    BNE @Exit
      LDY #$04
      LDA (btlsfxsq2_ptr), Y
      STA btlsfxsq2_framectr    ; byte [4] if the frame length of this portion
      LDY #$00
      LDA (btlsfxsq2_ptr), Y
      STA $4004                 ; byte [0] is the volume/duty setting
      INY
      LDA (btlsfxsq2_ptr), Y
      STA $4005                 ; byte [1] is the sweep setting
      INY
      LDA (btlsfxsq2_ptr), Y
      STA $4006                 ; byte [2] is low 8 bits of F-value
      INY
      LDA (btlsfxsq2_ptr), Y
      STA $4007                 ; byte [3] is high 3 bits of F-value + length counter
    
      CLC                       ; add 8 to the pointer (even though we only used 5 bytes of data)
      LDA btlsfxsq2_ptr         ;   (the other 3 bytes are the noise sfx data?)
      ADC #$08
      STA btlsfxsq2_ptr
      LDA btlsfxsq2_ptr+1
      ADC #$00
      STA btlsfxsq2_ptr+1
    
      DEC btlsfxsq2_len
      RTS
  @Exit:
    RTS
    
UpdateBattleSFX_Noise:
    LDA btlsfxnse_len           ; check the length of this sfx (if any)
    BEQ @Exit                   ; if we've completed it, then just exit
    DEC btlsfxnse_framectr      ; Count down our frame counter
    BNE @Exit                   ; Once it expires, we update the sfx
    
      LDY #$02
      LDA (btlsfxnse_ptr), Y
      STA btlsfxnse_framectr    ; byte [2] if the frame length of this portion
      LDY #$00
      LDA (btlsfxnse_ptr), Y
      STA $400C                 ; byte [0] is the volume setting
      INY
      LDA (btlsfxnse_ptr), Y
      STA $400E                 ; byte [1] is the Freq/tone of the noise
      LDA #$FF
      STA $400F                 ; fixed value of FF used for length counter (keep noise playing for a long time)
      
      CLC                       ; add 8 to the noise pointer (even though we only used 3 bytes of data)
      LDA btlsfxnse_ptr         ;   (the other 5 bytes are the square sfx data?)
      ADC #$08
      STA btlsfxnse_ptr
      LDA btlsfxnse_ptr+1
      ADC #$00
      STA btlsfxnse_ptr+1
      
      DEC btlsfxnse_len         ; decrease the remaining data length of the sfx
      RTS
  @Exit:
    RTS

SwapBattleSFXBytes:
    LDX #$00                    ; loop up-counter
    LDY #$10                    ; loop down-counter (copy $10 bytes)
  @Loop:
      LDA btlsfx_frontseat, X   ; swap front and back bytes
      PHA
      LDA btlsfx_backseat, X
      STA btlsfx_frontseat, X
      PLA
      STA btlsfx_backseat, X
      
      INX                       ; update loop counter and keep looping until all bytes swapped
      DEY
      BNE @Loop
    RTS    


    
DrawCharMenuString:
    LDY #$7F                ; set length to default 7F

DrawCharMenuString_Len:
    ASL A                   ; double menu string ID
    TAX                     ; put in X
    LDA lut_ZMenuText, X     ; and load up the pointer into (tmp)
    STA tmp
    LDA lut_ZMenuText+1, X
    STA tmp+1

    LDA #<bigstr_buf        ; set the text pointer to our bigstring buffer
    STA text_ptr
    LDA #>bigstr_buf
    STA text_ptr+1

  @Loop:                    ; now step through each byte of the string....
    LDA (tmp), Y            ; get the byte
    CMP #$10                ; compare it to $10 (charater stat control code)
    BNE :+                  ;   if it equals...
      ORA submenu_targ      ;   OR with desired character ID to draw desired character's stats
:   STA bigstr_buf, Y       ; copy the byte to the big string buffer
    DEY                     ; then decrement Y
    CPY #$FF                ; check to see if it wrapped
    BNE @Loop               ; and keep looping until it has

                                ; once the loop is complete and our big string buffer has been filled
    LDA #BANK_THIS
    STA cur_bank          ; set data bank (string to draw is on this bank -- or is in RAM)
    STA ret_bank          ; set return bank (we want it to RTS to this bank when complete)
    JMP DrawComplexString ;  Draw Complex String, then exit!
    
    



    
    
    
    
PlaySFX_MenuSel:
    LDA MuteSFXOption
    BNE @Done
    LDA #%00010100
    STA $400C
    LDA #%10001000
    STA $400F
    LDA #%00001010
    STA $400E
    @Done:
    LDA MMC5_tmp ;; JIGS - this routine is used by the options menu only...
    RTS             


PlaySFX_MenuMove:
    LDA MuteSFXOption
    BNE @Done
    LDA #%00000010
    STA $400C
    LDA #%01000000
    STA $400F
    LDA #$0
    STA $400E
    @Done:
    RTS            
    
    
    
    
    
    
    
;; JIGS - luts go down here:   


lut_LowNormalHigh:
.byte $01,$02,$03

lut_OnOff:
.byte $04,$05

lut_ZMenuText:
.word M_OptionsMenu ; 0
.word OptLow
.word OptNormal
.word OptHigh
.word OptionOn
.word OptionOff
.word M_SaveSlots
.word M_SaveTitle
.word M_LoadTitle
.word Saved
.word AreYouSure
.word Deleted
.word BattleYesNo ; 12

OptionOn:
.byte $98,$97,$C1,$00

OptionOff:
.byte $98,$8F,$8F,$00

OptLow:
.byte $95,$98,$A0,$C1,$C1,$C1,$00

OptNormal:
.byte $97,$98,$9B,$52,$95,$00

OptHigh:
.byte $91,$92,$90,$91,$C1,$C1,$00

M_OptionsMenu:   ;3A
.byte $8E,$A1,$99,$8E,$9B,$92,$8E,$97,$8C,$8E,$C1,$90,$8A,$92,$97,$01
.byte $96,$98,$97,$8E,$A2,$C1,$90,$8A,$92,$97,$01
.byte $8E,$97,$8C,$98,$9E,$97,$9D,$8E,$9B,$C1,$9B,$8A,$9D,$8E,$01
.byte $8B,$8A,$9D,$9D,$95,$8E,$C1,$96,$8E,$9C,$9C,$8A,$90,$8E,$C1,$9C,$99,$8E,$8E,$8D,$01
.byte $8A,$9E,$9D,$98,$C2,$9D,$8A,$9B,$90,$8E,$9D,$01
.byte $96,$8E,$97,$9E,$C1,$9C,$8F,$A1,$00
    
SoundTestInstructions:
.byte $8B,$C1,$C2,$C1,$8E,$BB,$AC,$B7,$05,$8A,$C1,$C2,$C1,$9C,$B7,$A4,$B5,$B7,$7A,$9C,$B7,$B2,$B3,$C1,$96,$B8
.byte $B6,$AC,$A6,$05,$9E,$B3,$7A,$8D,$B2,$BA,$B1,$C1,$C2,$C1,$9C,$A8,$AF,$A8,$A6,$B7,$C1,$9C,$B2
.byte $B1,$AA,$05,$9C,$B7,$A4,$B5,$B7,$C1,$C2,$C1,$91,$B8,$AA,$C1,$A4,$C1,$BA,$A8,$A4,$B6,$A8,$AF,$C1,$E2,$00


M_SaveSlots:
.byte $8F,$92,$95,$8E,$C1,$81,$01,$01,$01,$01,$8F,$92,$95,$8E,$C1,$82,$01,$01,$01,$01,$8F,$92,$95,$8E,$C1,$83,$00 

M_SaveTitle:
.byte $95,$98,$8A,$8D,$C1,$C1,$90,$8A,$96,$8E,$00

M_LoadTitle:
.byte $9C,$8A,$9F,$8E,$C1,$C1,$90,$8A,$96,$8E,$00

Saved:
.byte $9C,$8A,$9F,$8E,$8D,$C4,$00

AreYouSure:
.byte $7F,$F2,$7F,$F2,$FA,$C1,$8A,$9B,$8E,$C1,$A2,$98,$9E,$C1,$9C,$9E,$9B,$8E,$C5,$FB,$F2,$7F,$F2,$7F,$00

Deleted:
.byte $C1,$C1,$8D,$8E,$95,$8E,$9D,$8E,$8D,$C4,$C1,$C1,$C1,$00

BattleYesNo:
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$05
.byte $FF,$FF,$9B,$A8,$A4,$A7,$BC,$C5,$FF,$FF,$FF,$FF,$05
.BYTE $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$01
.byte $A2,$A8,$B6,$FF,$FF,$FF,$FF,$97,$B2,$FF,$FF,$FF,$01
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$00



lut_SongNamesLong:
;.INCBIN "bin/SongNamesLong.bin"

.byte $99,$B5,$A8,$AF,$B8,$A7,$A8,$C1,$C1,$C1,$C1,$C1,$C1,$C1,$C1,$C1,$C1,$C1,$C1,$C1,$C1,$C1,$C1,$00 ; Prelude
.byte $99,$B5,$B2,$AF,$B2,$AA,$B8,$A8,$C1,$C1,$C1,$C1,$C1,$C1,$C1,$C1,$C1,$C1,$C1,$C1,$C1,$C1,$C1,$00 ; Prologue
.byte $8E,$B3,$AC,$AF,$B2,$AA,$B8,$A8,$C1,$C1,$C1,$C1,$C1,$C1,$C1,$C1,$C1,$C1,$C1,$C1,$C1,$C1,$C1,$00 ; Epilogue
.byte $98,$B9,$A8,$B5,$BA,$B2,$B5,$AF,$A7,$C1,$C1,$C1,$C1,$C1,$C1,$C1,$C1,$C1,$C1,$C1,$C1,$C1,$C1,$00 ; Overworld
.byte $9C,$A4,$AC,$AF,$AC,$B1,$AA,$C1,$9C,$AB,$AC,$B3,$C1,$C1,$C1,$C1,$C1,$C1,$C1,$C1,$C1,$C1,$C1,$00 ; Sailing Ship
.byte $8A,$AC,$B5,$B6,$AB,$AC,$B3,$C1,$C1,$C1,$C1,$C1,$C1,$C1,$C1,$C1,$C1,$C1,$C1,$C1,$C1,$C1,$C1,$00 ; Airship
.byte $9D,$B2,$BA,$B1,$C1,$C1,$C1,$C1,$C1,$C1,$C1,$C1,$C1,$C1,$C1,$C1,$C1,$C1,$C1,$C1,$C1,$C1,$C1,$00 ; Town
.byte $8C,$A4,$B6,$B7,$AF,$A8,$C1,$C1,$C1,$C1,$C1,$C1,$C1,$C1,$C1,$C1,$C1,$C1,$C1,$C1,$C1,$C1,$C1,$00 ; Castle
.byte $8E,$A4,$B5,$B7,$AB,$C1,$8C,$A4,$B9,$A8,$C1,$7A,$C1,$90,$B8,$B5,$AA,$B8,$C1,$C1,$C1,$C1,$C1,$00 ; Earth Cave / Gurgu 
.byte $96,$A4,$B7,$B2,$BC,$A4,$C1,$C1,$C1,$C1,$C1,$C1,$C1,$C1,$C1,$C1,$C1,$C1,$C1,$C1,$C1,$C1,$C1,$00 ; Matoya
.byte $96,$A4,$B5,$B6,$AB,$C1,$8C,$A4,$B9,$A8,$C1,$F5,$97,$A8,$BA,$F6,$C1,$C1,$C1,$C1,$C1,$C1,$C1,$00 ; Marsh Cave (New)
.byte $9D,$A8,$B0,$B3,$AF,$A8,$C1,$B2,$A9,$C1,$8F,$AC,$A8,$B1,$A7,$B6,$C1,$C1,$C1,$C1,$C1,$C1,$C1,$00 ; Temple of Fiends
.byte $9C,$AE,$BC,$C1,$8C,$A4,$B6,$B7,$AF,$A8,$C1,$C1,$C1,$C1,$C1,$C1,$C1,$C1,$C1,$C1,$C1,$C1,$C1,$00 ; Sky Castle
.byte $9C,$A8,$A4,$C1,$9C,$AB,$B5,$AC,$B1,$A8,$C1,$C1,$C1,$C1,$C1,$C1,$C1,$C1,$C1,$C1,$C1,$C1,$C1,$00 ; Sea Shrine
.byte $9C,$AB,$B2,$B3,$C1,$C1,$C1,$C1,$C1,$C1,$C1,$C1,$C1,$C1,$C1,$C1,$C1,$C1,$C1,$C1,$C1,$C1,$C1,$00 ; Shop
.byte $8B,$A4,$B7,$B7,$AF,$A8,$C1,$C1,$C1,$C1,$C1,$C1,$C1,$C1,$C1,$C1,$C1,$C1,$C1,$C1,$C1,$C1,$C1,$00 ; Battle
.byte $96,$A8,$B1,$B8,$C1,$7A,$C1,$92,$B1,$B1,$C1,$7A,$C1,$96,$A4,$B3,$C1,$C1,$C1,$C1,$C1,$C1,$C1,$00 ; Menu / Inn / Map
.byte $9C,$AF,$A4,$AC,$B1,$C1,$C1,$C1,$C1,$C1,$C1,$C1,$C1,$C1,$C1,$C1,$C1,$C1,$C1,$C1,$C1,$C1,$C1,$00 ; Slain
.byte $8F,$A4,$B1,$A9,$A4,$B5,$A8,$C1,$C1,$C1,$C1,$C1,$C1,$C1,$C1,$C1,$C1,$C1,$C1,$C1,$C1,$C1,$C1,$00 ; Fanfare
.byte $94,$A8,$BC,$C1,$92,$B7,$A8,$B0,$C1,$C1,$C1,$C1,$C1,$C1,$C1,$C1,$C1,$C1,$C1,$C1,$C1,$C1,$C1,$00 ; Key Item
.byte $96,$A4,$B5,$B6,$AB,$C1,$8C,$A4,$B9,$A8,$C1,$F5,$98,$AF,$A7,$F6,$C1,$C1,$C1,$C1,$C1,$C1,$C1,$00 ; Marsh Cave (Old)
.byte $9C,$A4,$B9,$AC,$B1,$AA,$C1,$C1,$C1,$C1,$C1,$C1,$C1,$C1,$C1,$C1,$C1,$C1,$C1,$C1,$C1,$C1,$C1,$00 ; Saving
.byte $91,$A8,$A4,$AF,$AC,$B1,$AA,$C1,$F5,$9E,$B1,$B8,$B6,$A8,$A7,$F6,$C1,$C1,$C1,$C1,$C1,$C1,$C1,$00 ; Healing (Unused)
.byte $9D,$B5,$A8,$A4,$B6,$B8,$B5,$A8,$C1,$F5,$9E,$B1,$B8,$B6,$A8,$A7,$F6,$C1,$C1,$C1,$C1,$C1,$C1,$00 ; Treasure (Unused)




lut_CharStatsPtrTable:
  .WORD ch_stats
  .WORD ch_stats+$40
  .WORD ch_stats+$80
  .WORD ch_stats+$C0    
    
lut_IBCharStatsPtrTable:
  .WORD ch_backupstats
  .WORD ch_backupstats + (1*$10)
  .WORD ch_backupstats + (2*$10)
  .WORD ch_backupstats + (3*$10)
  
  
lut_UnformattedCombatBoxBuffer:
  .WORD btl_unfmtcbtbox_buffer
  .WORD btl_unfmtcbtbox_buffer + $10
  .WORD btl_unfmtcbtbox_buffer + $20
  .WORD btl_unfmtcbtbox_buffer + $30
  .WORD btl_unfmtcbtbox_buffer + $40  
  
.byte "END OF BANK Z"