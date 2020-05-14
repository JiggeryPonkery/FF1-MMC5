.include "Constants.inc"
.include "variables.inc"
.feature force_range

.export EnemyAttackPlayer_PhysicalZ, PlayerAttackEnemy_PhysicalZ
.export PlayerAttackPlayer_PhysicalZ
.export ClericCheck, CritCheck
.export SoundTestZ
.export OptionsMenu, DrawSaveScreenNames, DrawSaveScreenSprites
.export EnterTitleScreen
.export JigsIntro
.export SaveScreen
.export ReadjustEquipStats
.export UnadjustEquipStats
.export LoadEnemyStats
.export NewGamePartyGeneration
.export StealFromEnemyZ
.export AssignMapTileDamage_Z
.export LoadPlayerDefenderStats_ForEnemyAttack
.export WeaponArmorShopStats
.export WeaponArmorSpecialDesc
.export GetEquipmentSpell
.export SpiritCalculations
.export Battle_SetPartyWeaponSpritePal
.export MapPoisonDamage_Z

.import GameLoaded, StartNewGame, SaveScreenHelper, LoadBattleSpritesForBank_Z
.import SwapPRG_L, LongCall, DrawCombatBox_L, CallMusicPlay_L, WaitForVBlank_L, MultiplyXA, AddGPToParty, LoadShopCHRForBank_Z
.import RandAX, HushTriangle, WaitForVBlank_L, GameStart_L, GameStart2, LoadPtyGenBGCHRAndPalettes, IntroTitlePrepare, LoadBridgeSceneGFX_Menu
.import DrawComplexString, ClearOAM, DrawPalette, CallMusicPlay, UpdateJoy, DrawSimple2x3Sprite, Draw2x2Sprite, CHRLoad, CHRLoadToA
.import DrawCursor, WaitForVBlank_L, DrawBox, LoadMenuCHRPal, MenuCondStall, CoordToNTAddr, LoadBorderPalette_Blue
.import UndrawBattleBlock, ShiftSpriteHightoLow, PlaySFX_Error
.import BattleBackgroundColor_LUT
.import BattleBGColorDigits
.import DrawPalette_L
.import CancelNewGame
.import LoadMenuCHRPal_Z
.import AddGPToParty
.import LoadPriceZ
.import BattleRNG_L
.import lutClassBatSprPalette
.import PlayDoorSFX
.import Bridge_LoadPalette
.import LoadCursorOnly
.import LoadShopCHRForBank_Z
.import ShiftLeft6



BANK_THIS = $0F

.segment "BANK_0F"

lut_WeaponData:

;      v ----------------------------- Hit rate
;          v ------------------------- Damage
;              v --------------------- Critical hit rate
;                  v ----------------- Ailment (used to be spell, but that's stored in the battle bank now)
;                      v-------------- Ailment chance (1-200)
;                          v ------------- Element
;                              v --------- Category effectiveness
;                                  v ----- Graphic
;                                      v - Palette

.byte $00,$0C,$0A,$00,$00,$00,$00,$A8,$27 ; 00  Wooden nunchucks
.byte $0A,$05,$05,$00,$00,$00,$00,$98,$20 ; 01  Small knife
.byte $00,$06,$01,$00,$00,$00,$00,$A0,$27 ; 02  Wooden staff
.byte $05,$09,$0A,$00,$00,$00,$00,$90,$20 ; 03  Rapier
.byte $00,$09,$01,$00,$00,$00,$00,$94,$27 ; 04  Iron hammer
.byte $0A,$0F,$05,$00,$00,$00,$00,$80,$20 ; 05  Short sword
.byte $05,$10,$03,$00,$00,$00,$00,$9C,$20 ; 06  Hand axe
.byte $0A,$0A,$05,$00,$00,$00,$00,$84,$2B ; 07  Scimitar
.byte $00,$10,$0A,$00,$00,$00,$00,$A8,$20 ; 08  Iron nunchucks
.byte $0A,$07,$05,$00,$00,$00,$00,$98,$20 ; 09  Large knife
.byte $00,$0E,$01,$10,$1E,$00,$00,$A4,$20 ; 0A  Iron Staff      - might cause STUN
.byte $05,$0D,$0A,$00,$00,$00,$00,$90,$20 ; 0B  Sabre
.byte $0A,$14,$05,$00,$00,$00,$00,$8C,$20 ; 0C  Long sword
.byte $05,$16,$03,$00,$00,$00,$00,$9C,$25 ; 0D  Great axe
.byte $0A,$0F,$05,$00,$00,$00,$00,$88,$20 ; 0E  Falchion
.byte $0F,$0A,$05,$00,$00,$00,$00,$98,$2C ; 0F  Silver knife
.byte $0F,$17,$05,$00,$00,$00,$00,$8C,$2C ; 10  Silver Sword
.byte $05,$0C,$01,$00,$00,$00,$00,$94,$2C ; 11  Silver Hammer
.byte $0A,$19,$04,$00,$00,$00,$00,$9C,$2C ; 12  Silver Axe
.byte $14,$1A,$05,$00,$00,$10,$88,$88,$26 ; 13  Flame sword
.byte $19,$1D,$05,$00,$00,$20,$00,$8C,$21 ; 14  Ice sword
.byte $0F,$13,$0A,$00,$00,$00,$02,$90,$2B ; 15  Dragon sword
.byte $14,$15,$05,$00,$00,$00,$04,$80,$22 ; 16  Giant sword
.byte $1E,$20,$05,$08,$1E,$00,$08,$8C,$27 ; 17  Sun sword       - might cause DARK
.byte $0F,$13,$0A,$00,$00,$00,$20,$90,$25 ; 18  Coral sword
.byte $0F,$12,$05,$00,$00,$00,$10,$80,$24 ; 19  Were sword
.byte $0F,$12,$05,$40,$1E,$00,$41,$88,$23 ; 1A  Rune sword      - might cause MUTE
.byte $00,$0C,$01,$00,$00,$00,$00,$A0,$2A ; 1B  Power staff
.byte $0F,$1C,$03,$08,$2F,$00,$08,$9C,$23 ; 1C  Light axe       - casts HARM 2, might cause DARK
.byte $00,$06,$01,$00,$00,$00,$00,$A4,$21 ; 1D  Heal staff      - casts HEAL
.byte $0A,$0C,$01,$00,$00,$00,$00,$A4,$25 ; 1E  Mage staff      - casts FIRE 2
.byte $23,$1E,$05,$00,$00,$00,$00,$80,$27 ; 1F  Defense swrd    - casts SHIELD
.byte $0F,$0F,$01,$00,$00,$00,$00,$A4,$2C ; 20  Wizard staff    - casts CONFUSE
.byte $19,$18,$1E,$00,$00,$00,$00,$88,$21 ; 21  Vorpal sword
.byte $23,$16,$05,$00,$00,$00,$00,$98,$2C ; 22  CatClaw
.byte $0F,$12,$01,$00,$00,$00,$00,$94,$24 ; 23  Thor Hammer     - casts BOLT 2
.byte $14,$16,$0A,$04,$14,$00,$00,$90,$22 ; 24  Bane sword      - casts BANE, might cause POISON
.byte $23,$21,$1E,$00,$00,$00,$00,$98,$27 ; 25  Katana
.byte $23,$2D,$05,$00,$00,$FF,$FF,$8C,$28 ; 26  Excalibur
.byte $32,$38,$0A,$00,$00,$00,$00,$84,$20 ; 27  Masamune
.byte $28,$00,$0A,$00,$FF,$00,$14,$98,$28 ; 28  Chicken Knife
.byte $20,$00,$05,$00,$00,$00,$0A,$8C,$2A ; 29  Brave Blade
.byte $00,$00,$00,$00,$00,$00,$00,$00,$00 ; 2A
.byte $00,$00,$00,$00,$00,$00,$00,$00,$00 ; 2B
.byte $00,$00,$00,$00,$00,$00,$00,$00,$00 ; 2C
.byte $00,$00,$00,$00,$00,$00,$00,$00,$00 ; 2D
.byte $00,$00,$00,$00,$00,$00,$00,$00,$00 ; 2E
.byte $00,$00,$00,$00,$00,$00,$00,$00,$00 ; 2F
.byte $00,$00,$00,$00,$00,$00,$00,$00,$00 ; 30
.byte $00,$00,$00,$00,$00,$00,$00,$00,$00 ; 31
.byte $00,$00,$00,$00,$00,$00,$00,$00,$00 ; 32
.byte $00,$00,$00,$00,$00,$00,$00,$00,$00 ; 33
.byte $00,$00,$00,$00,$00,$00,$00,$00,$00 ; 34
.byte $00,$00,$00,$00,$00,$00,$00,$00,$00 ; 35
.byte $00,$00,$00,$00,$00,$00,$00,$00,$00 ; 36
.byte $00,$00,$00,$00,$00,$00,$00,$00,$00 ; 37
.byte $00,$00,$00,$00,$00,$00,$00,$00,$00 ; 38
.byte $00,$00,$00,$00,$00,$00,$00,$00,$00 ; 39
.byte $00,$00,$00,$00,$00,$00,$00,$00,$00 ; 3A
.byte $00,$00,$00,$00,$00,$00,$00,$00,$00 ; 3B
.byte $00,$00,$00,$00,$00,$00,$00,$00,$00 ; 3C
.byte $00,$00,$00,$00,$00,$00,$00,$00,$00 ; 3D
.byte $00,$00,$00,$00,$00,$00,$00,$00,$00 ; 3E
.byte $00,$00,$00,$00,$00,$00,$00,$00,$00 ; 3F
.byte $00,$00,$00,$00,$00,$00,$00,$00,$00 ; 40





; Status defense bits:
;*------- > Confusion
;-*------ > Mute
;--*----- > Stun
;---*---- > Sleep
;----*--- > Blindness
;-----*-- > Poison
;------*- > Stone
;-------* > Death

; Elemental defense/weakness bits:
;*------- > Earth
;-*------ > Lightning
;--*----- > Ice
;---*---- > Fire
;----*--- > Deathy stuff  / WATER
;-----*-- > Poisony stuff / WIND
;------*- > Stunny stuff  / HOLY
;-------* > ??            / DARK
;; JIGS - these last 4 are kind of weird? Vanilla FF uses like... status as elements or something.
;; FF Hackster lists them as things like Time, Status, Death...
;; I forget why Constants.inc has them listed as the caps versions shown here.

; Category bits:
;*------- > Regenerative
;-*------ > Magic
;--*----- > Water
;---*---- > Were
;----*--- > Undead
;-----*-- > Giant
;------*- > Dragon
;-------* > Unknown

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Armor data!  [$8140 :: 0x30150]
;;
;;  4 bytes per armor, 40 armors ($A0 bytes total)
;;
;;  byte 0:  Evade penality
;;  byte 1:  Absorb boost
;;  byte 2:  Magic evade boost
;;  byte 3:  Elemental defense
;;  byte 4:  Elemental weakness
;;  byte 5:  Status defense
;;  Spell LUT is seperated

lut_ArmorData:
;      v - Evade penalty
;          v - Absorb boost
;              v - Magic Defense Boost
;                 v - Elemental defense
;                           v - Elemental weakness
;                                      v - Status defense

;.byte $02,$01,$00,%00000000,%00000000,%00000000 ; Cloth T ;; original
.byte $00,$02,$00,%00000000,%00000000,%00000000 ; 00 Cloth T  ;; JIGS - c'mon, that's just mean... At least make it a little useful.
.byte $08,$04,$00,%00000000,%00000000,%00000000 ; 01 Wooden armor
.byte $0F,$0F,$00,%00000000,%00000000,%00000000 ; 02 Chain armor
.byte $17,$18,$00,%00000000,%00000000,%00000000 ; 03 Iron armor
.byte $21,$22,$00,%00000000,%00000000,%00010000 ; 04 Steel armor
.byte $08,$12,$00,%00000000,%00000000,%00000000 ; 05 Silver armor
.byte $0A,$22,$00,%00100000,%00010000,%00000000 ; 06 Flame armor
.byte $0A,$22,$00,%00010000,%00100000,%00000000 ; 07 Ice armor
.byte $0A,$2A,$00,%01000000,%00000000,%00000000 ; 08 Opal armor
.byte $0A,$2A,$00,%01110000,%00000000,%00000000 ; 09 Dragon armor
.byte $01,$04,$00,%00000000,%00000000,%00000000 ; 0A Copper Q
.byte $01,$0F,$00,%00000000,%00000000,%00000000 ; 0B Silver Q
.byte $01,$18,$00,%00000000,%00000000,%00000000 ; 0C Gold Q
.byte $01,$22,$00,%00000000,%00000000,%00000000 ; 0D Opal Q
.byte $02,$18,$00,%00011000,%00000000,%00011000 ; 0E white T        - casts INVIS 2
.byte $02,$18,$00,%00100100,%00000000,%00100100 ; 0F Black T        - casts ICE 2
.byte $00,$02,$00,%00000000,%00000000,%00000000 ; 10 Wooden shield
.byte $00,$04,$00,%00000000,%00000000,%00000000 ; 11 Iron shield
.byte $00,$08,$00,%00000000,%00000000,%00000000 ; 12 Silver shield
.byte $00,$0C,$00,%00100000,%00010000,%00000000 ; 13 Flame shield
.byte $00,$0C,$00,%00010000,%00100000,%00000000 ; 14 Ice shield
.byte $00,$10,$00,%01000000,%00000000,%00000000 ; 15 Opal shield
.byte $00,$10,$00,%00000100,%00000000,%11000000 ; 16 Aegis shield
.byte $00,$02,$00,%00000000,%00000000,%00000000 ; 17 Buckler
.byte $02,$08,$00,%00000000,%00000000,%00000001 ; 18 Protect cape
.byte $01,$01,$00,%00000000,%00000000,%00000000 ; 19 Cap
.byte $03,$03,$00,%00000000,%00000000,%00000000 ; 1A Wooden helm
.byte $05,$05,$00,%00000000,%00000000,%00000000 ; 1B Iron helm
.byte $03,$06,$00,%00000000,%00000000,%00000000 ; 1C Silver helm
.byte $03,$08,$00,%00000000,%00000000,%00000000 ; 1D Opal helm
.byte $03,$06,$00,%00000000,%00000000,%00000000 ; 1E Heal helm      - casts HEAL
.byte $01,$01,$00,%00000000,%00000000,%11111111 ; 1F Ribbon
.byte $01,$01,$00,%00000000,%00000000,%00000000 ; 20 Gloves
.byte $03,$02,$00,%00000000,%00000000,%00000000 ; 21 Copper Gauntlet
.byte $05,$04,$00,%00000000,%00000000,%00000000 ; 22 Iron Gauntlet
.byte $03,$06,$00,%00000000,%00000000,%00000000 ; 23 Silver Gauntlet
.byte $03,$06,$00,%00000000,%00000000,%00010000 ; 24 Zeus Gauntlet  - casts BOLT 2
.byte $03,$06,$00,%00000000,%00000000,%00000000 ; 25 Power Gauntlet - casts SABER
.byte $03,$08,$00,%00000000,%00000000,%00000000 ; 26 Opal Gauntlet
.byte $01,$08,$00,%00001000,%00000000,%00000001 ; 27 Protect Ring
.byte $00,$00,$00,$00,$00,$00
.byte $00,$00,$00,$00,$00,$00
.byte $00,$00,$00,$00,$00,$00
.byte $00,$00,$00,$00,$00,$00
.byte $00,$00,$00,$00,$00,$00
.byte $00,$00,$00,$00,$00,$00
.byte $00,$00,$00,$00,$00,$00
.byte $00,$00,$00,$00,$00,$00
.byte $00,$00,$00,$00,$00,$00
.byte $00,$00,$00,$00,$00,$00
.byte $00,$00,$00,$00,$00,$00
.byte $00,$00,$00,$00,$00,$00
.byte $00,$00,$00,$00,$00,$00
.byte $00,$00,$00,$00,$00,$00
.byte $00,$00,$00,$00,$00,$00
.byte $00,$00,$00,$00,$00,$00
.byte $00,$00,$00,$00,$00,$00
.byte $00,$00,$00,$00,$00,$00
.byte $00,$00,$00,$00,$00,$00
.byte $00,$00,$00,$00,$00,$00
.byte $00,$00,$00,$00,$00,$00
.byte $00,$00,$00,$00,$00,$00
.byte $00,$00,$00,$00,$00,$00
.byte $00,$00,$00,$00,$00,$00
.byte $00,$00,$00,$00,$00,$00

lut_EquipmentSpells:
.byte $00     ;00; Wooden nunchucks
.byte $00     ;01; Small knife
.byte $00     ;02; Wooden staff
.byte $00     ;03; Rapier
.byte $00     ;04; Iron hammer
.byte $00     ;05; Short sword
.byte $00     ;06; Hand axe
.byte $00     ;07; Scimitar
.byte $00     ;08; Iron nunchucks
.byte $00     ;09; Large knife
.byte $00     ;0A; Iron Staff
.byte $00     ;0B; Sabre
.byte $00     ;0C; Long sword
.byte $00     ;0D; Great axe
.byte $00     ;0E; Falchion
.byte $00     ;0F; Silver knife
.byte $00     ;10; Silver Sword
.byte $00     ;11; Silver Hammer
.byte $00     ;12; Silver Axe
.byte $00     ;13; Flame sword
.byte $00     ;14; Ice sword
.byte $00     ;15; Dragon sword
.byte $00     ;16; Giant sword
.byte $00     ;17; Sun sword
.byte $00     ;18; Coral sword
.byte $00     ;19; Were sword
.byte $00     ;1A; Rune sword
.byte $00     ;1B; Power staff
.byte MG_HRM2 ;1C; $12 ; Light axe       - casts HARM 2
.byte MG_HEAL ;1D; $14 ; Heal staff      - casts HEAL
.byte MG_FIR2 ;1E; $15 ; Mage staff      - casts FIRE 2
.byte MG_FOG  ;1F; $04 ; Defense swrd    - casts SHIELD
.byte MG_CONF ;20; $1F ; Wizard staff    - casts CONFUSE
.byte $00     ;21; Vorpal sword
.byte $00     ;22; CatClaw
.byte MG_LIT2 ;23; $17 ; Thor Hammer     - casts BOLT 2
.byte MG_BANE ;24; $26 ; Bane sword      - casts BANE
.byte $00     ;25; Katana
.byte $00     ;26; Excalibur
.byte $00     ;27; Masamune
.byte $00     ;28; Chicken Knife
.byte $00     ;29; Brave Blade
.byte $00     ;2A;
.byte $00     ;2B;
.byte $00     ;2C;
.byte $00     ;2D;
.byte $00     ;2E;
.byte $00     ;2F;
.byte $00     ;30;
.byte $00     ;31;
.byte $00     ;32;
.byte $00     ;33;
.byte $00     ;34;
.byte $00     ;35;
.byte $00     ;36;
.byte $00     ;37;
.byte $00     ;38;
.byte $00     ;39;
.byte $00     ;3A;
.byte $00     ;3B;
.byte $00     ;3C;
.byte $00     ;3D;
.byte $00     ;3E;
.byte $00     ;3F;

.byte $00 ; Cloth T
.byte $00 ; Wooden armor
.byte $00 ; Chain armor
.byte $00 ; Iron armor
.byte $00 ; Steel armor
.byte $00 ; Silver armor
.byte $00 ; Flame armor
.byte $00 ; Ice armor
.byte $00 ; Opal armor
.byte $00 ; Dragon armor
.byte $00 ; Copper Q
.byte $00 ; Silver Q
.byte $00 ; Gold Q
.byte $00 ; Opal Q
.byte MG_INV2 ; 44  ;$2C ; white T        - casts INVIS 2
.byte MG_ICE2 ; 32  ;$20 ; Black T        - casts ICE 2
.byte $00 ; Wooden shield
.byte $00 ; Iron shield
.byte $00 ; Silver shield
.byte $00 ; Flame shield
.byte $00 ; Ice shield
.byte $00 ; Opal shield
.byte $00 ; Aegis shield
.byte $00 ; Buckler
.byte $00 ; Protect cape
.byte $00 ; Cap
.byte $00 ; Wooden helm
.byte $00 ; Iron helm
.byte $00 ; Silver helm
.byte $00 ; Opal helm
.byte MG_HEAL ; 20  ;$14 ; Heal helm      - casts HEAL
.byte $00 ; Ribbon
.byte $00 ; Gloves
.byte $00 ; Copper Gauntlet
.byte $00 ; Iron Gauntlet
.byte $00 ; Silver Gauntlet
.byte MG_LIT2 ; 23  ;$17 ; Zeus Gauntlet  - casts BOLT 2
.byte MG_SABR ; 55  ;$37 ; Power Gauntlet - casts SABER
.byte $00 ; Opal Gauntlet
.byte $00 ; Protect Ring
.byte $00 ;
.byte $00 ;
.byte $00 ;
.byte $00 ;
.byte $00 ;
.byte $00 ;
.byte $00 ;
.byte $00 ;
.byte $00 ;
.byte $00 ;
.byte $00 ;
.byte $00 ;
.byte $00 ;
.byte $00 ;
.byte $00 ;
.byte $00 ;
.byte $00 ;
.byte $00 ;
.byte $00 ;
.byte $00 ;
.byte $00 ;
.byte $00 ;
.byte $00 ;
.byte $00 ;

;; As you can see here, to set a spell, you can abandon the $ and just use the number of the spell.
;; Reference Bank A for the spell list in normal people numbers, or Constants.inc for hex!

GetEquipmentSpell:
    LDX tmp+10
    LDA lut_EquipmentSpells, X
    STA tmp+10
    RTS


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  LUT for Enemy AI [$9020 :: 0x31030]
;;
;;    $10 bytes per AI
;;
;;  byte      0 = chance to cast spell         ($00-80)
;;  byte      1 = chance to use special attack ($00-80)
;;  bytes   2-9 = magic spells available.  Each entry 0-based.  Or 'FF' for nothing.
;;  bytes $B-$F = special attacks (0 based), or 'FF' for nothing.

EnemyAIData:

;      0   1   2   3   4   5   6   7   8   9   A   B   C   D   E   F
.byte $00,$05,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$1A,$FF,$FF,$FF,$FF ;00 IMP	   ; [IMP PUNCH]
.byte $00,$15,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$1A,$1A,$1A,$1A,$1A ;01 GrIMP	   ; [IMP PUNCH x5]
.byte $00,$00,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF ;02 WOLF	   ;
.byte $00,$00,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF ;03 GrWolf   ;
.byte $00,$00,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF ;04 WrWolf   ;
.byte $00,$20,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$00,$00,$00,$00,$FF ;05 FrWOLF   ; [FROST x4]
.byte $00,$00,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF ;06 IGUANA   ;
.byte $00,$20,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$01,$01,$01,$01,$FF ;07 AGAMA    ; [HEAT x4]
.byte $00,$40,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$02,$02,$02,$02,$FF ;08 SAURIA   ;
.byte $00,$00,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF ;09 GIANT    ;
.byte $00,$00,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF ;0A FrGIANT  ;
.byte $00,$00,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF ;0B R`GIANT  ;
.byte $00,$00,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF ;0C SAHAG    ;
.byte $00,$00,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF ;0D R`SAHAG  ;
.byte $00,$00,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF ;0E WzSAHAG  ;
.byte $00,$00,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF ;0F PIRATE   ;
.byte $00,$00,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF ;10 KYZOKU   ;
.byte $00,$00,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF ;11 SHARK    ;
.byte $00,$00,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF ;12 GrSHARK  ;
.byte $00,$80,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$03,$03,$03,$03,$FF ;13 OddEYE   ; [GAZE x4]
.byte $00,$40,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$03,$04,$03,$04,$FF ;14 BigEYE   ; [GAZE, FLASH, GAZE, FLASH]
.byte $00,$00,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF ;15 BONE     ;
.byte $00,$00,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF ;16 R`BONE   ;
.byte $00,$00,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF ;17 CREEP    ;
.byte $00,$00,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF ;18 CRAWL    ;
.byte $00,$00,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF ;19 HYENA    ;
.byte $00,$40,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$05,$05,$05,$05,$FF ;1A CEREBUS  ; [SCORCH x4]
.byte $00,$00,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF ;1B OGRE     ;
.byte $00,$00,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF ;1C GrOGRE   ;
.byte $40,$00,$03,$0D,$05,$15,$1F,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF ;1D WzOGRE   ; <RUSE, DARK, SLEP, HOLD, ICE2>
.byte $00,$00,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF ;1E ASP      ;
.byte $00,$00,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF ;1F COBRA    ;
.byte $00,$00,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF ;20 SeaSNAKE ;
.byte $00,$00,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF ;21 SCORPION ;
.byte $00,$00,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF ;22 LOBSTER  ;
.byte $00,$00,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF ;23 BULL     ;
.byte $00,$00,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF ;24 ZomBULL  ;
.byte $00,$00,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF ;25 TROLL    ;
.byte $00,$00,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF ;26 SeaTROLL ;
.byte $00,$00,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF ;27 SHADOW   ;
.byte $00,$00,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF ;28 IMAGE    ;
.byte $00,$00,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF ;29 WRAITH   ;
.byte $00,$00,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF ;2A GHOST    ;
.byte $00,$00,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF ;2B ZOMBIE   ;
.byte $00,$00,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF ;2C GHOUL    ;
.byte $00,$00,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF ;2D GEIST    ;
.byte $00,$00,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF ;2E SPECTER  ;
.byte $00,$00,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF ;2F WORM     ;
.byte $00,$40,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$06,$06,$06,$06,$FF ;30 Sand W   ; [CRACK x4]
.byte $00,$00,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF ;31 Grey W   ;
.byte $50,$50,$3F,$35,$2D,$16,$15,$09,$0F,$05,$FF,$02,$07,$03,$08,$FF ;32 EYE      ; <XXXX, BRAK, RUB, LIT2, HOLD, MUTE, SLOW, SLEP> [GLANCE, SQUINT, GAZE, STARE]
.byte $40,$40,$3D,$3E,$3B,$35,$2D,$15,$09,$0F,$FF,$09,$09,$09,$09,$FF ;33 PHANTOM  ; <STOP, ZAP!, XFER, BRAK, RUB, HOLD, MUTE, SLOW> [GLARE x4]
.byte $00,$00,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF ;34 MEDUSA   ;
.byte $00,$00,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF ;35 GrMEDUSA ;
.byte $00,$00,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF ;36 CATMAN   ;
.byte $60,$00,$14,$0F,$0D,$05,$04,$07,$00,$05,$FF,$FF,$FF,$FF,$FF,$FF ;37 MANCAT   ; <FIR2, SLOW, DARK, SLEP, FIRE, LIT, CURE, SLEP>
.byte $00,$00,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF ;38 PEDE     ;
.byte $00,$00,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF ;39 GrPEDE   ;
.byte $00,$00,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF ;3A TIGER    ;
.byte $00,$00,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF ;3B Saber T  ;
.byte $00,$20,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$17,$17,$17,$17,$FF ;3C VAMPIRE  ; [DAZZLE x4]
.byte $20,$20,$12,$09,$1F,$1F,$16,$16,$14,$14,$FF,$17,$17,$17,$17,$FF ;3D WzVAMP   ; <AFIR, MUTE, ICE2 x2, LIT2 x2, FIR2 x2> [DAZZLE x4]
.byte $00,$00,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF ;3E GARGOYLE ;
.byte $40,$00,$14,$15,$04,$04,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF ;3F R`GOYLE  ; <FIR2, HOLD, FIRE x2>
.byte $00,$00,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF ;40 EARTH    ;
.byte $00,$00,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF ;41 FIRE     ;
.byte $00,$40,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$0A,$0A,$0A,$FF,$FF ;42 Frost D  ; [BLIZZARD x3]
.byte $00,$40,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$0B,$0B,$0B,$FF,$FF ;43 Red D    ; [BLAZE x3]
.byte $00,$00,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF ;44 ZombieD  ;
.byte $00,$00,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF ;45 SCUM     ;
.byte $00,$00,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF ;46 MUCK     ;
.byte $00,$00,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF ;47 OOZE     ;
.byte $00,$00,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF ;48 SLIME    ;
.byte $00,$00,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF ;49 SPIDER   ;
.byte $00,$00,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF ;4A ARACHNID ;
.byte $00,$40,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$16,$16,$16,$16,$FF ;4B MANTICOR ; [STINGER x4]
.byte $00,$00,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF ;4C SPHINX   ;
.byte $00,$00,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF ;4D R`ANKYLO ;
.byte $00,$00,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF ;4E ANKYLO   ;
.byte $00,$00,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF ;4F MUMMY    ;
.byte $00,$00,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF ;50 WzMUMMY  ;
.byte $00,$00,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF ;51 COCTRICE ;
.byte $00,$20,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$07,$07,$07,$07,$FF ;52 PERILISK ; [SQUINT x4]
.byte $00,$00,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF ;53 WYVERN   ;
.byte $00,$00,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF ;54 WYRM     ;
.byte $00,$00,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF ;55 TYRO     ;
.byte $00,$00,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF ;56 T REX    ;
.byte $00,$00,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF ;57 CARIBE   ;
.byte $00,$00,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF ;58 R`CARIBE ;
.byte $00,$00,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF ;59 GATOR    ;
.byte $00,$00,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF ;5A FrGATOR  ;
.byte $00,$00,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF ;5B OCHO     ;
.byte $00,$00,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF ;5C NAOCHO   ;
.byte $00,$00,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF ;5D HYDRA    ;
.byte $00,$40,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$0D,$0D,$FF,$FF,$FF ;5E R`HYDRA  ; [CREMATE x2]
.byte $00,$00,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF ;5F GAURD    ;
.byte $00,$00,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF ;60 SENTRY   ;
.byte $00,$00,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF ;61 WATER    ;
.byte $00,$00,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF ;62 AIR      ;
.byte $60,$00,$16,$15,$0F,$0D,$07,$06,$05,$07,$FF,$FF,$FF,$FF,$FF,$FF ;63 NAGA     ; <LIT2, LOCK, SLEP, LIT, LIT2, HOLD, SLOW, DARK>
.byte $60,$00,$03,$09,$0F,$0D,$05,$04,$07,$13,$FF,$FF,$FF,$FF,$FF,$FF ;64 GrNAGA   ; <RUSE, MUTE, SLOW, DARK, SLEP, FIRE, LIT, HEAL>
.byte $00,$40,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$0D,$0D,$0D,$FF,$FF ;65 CHIMERA  ; [CREMATE x3]
.byte $00,$40,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$0D,$0E,$0D,$0E,$FF ;66 JIMERA   ; [CREMATE, POISON, CREMATE, POISON]
.byte $00,$00,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF ;67 WIZARD   ;
.byte $00,$40,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$0F,$0F,$0F,$0F,$FF ;68 SORCERER ; [TRANCE x4]
.byte $00,$00,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF ;69 GARLAND  ;
.byte $00,$40,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$10,$10,$10,$FF,$FF ;6A Gas D    ; [POISON x3]
.byte $00,$40,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$11,$11,$11,$FF,$FF ;6B Blue D   ; [THUNDER x3]
.byte $20,$00,$1D,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF ;6C MudGOL   ; <FAST>
.byte $30,$00,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$FF,$FF,$FF,$FF,$FF,$FF ;6D RockGOL  ; <SLOW x8>
.byte $00,$10,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$12,$12,$12,$12,$FF ;6E IronGOL  ; [TOXIC x4]
.byte $20,$00,$3B,$3C,$3B,$3F,$37,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF ;6F BADMAN   ; <XFER, NUKE, XFER, XXXX, BLND>
.byte $00,$00,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF ;70 EVILMAN  ;
.byte $60,$00,$2D,$27,$1D,$14,$16,$0F,$0D,$05,$FF,$FF,$FF,$FF,$FF,$FF ;71 ASTOS    ; <RUB, SLO2, FAST, FIR2, LIT2, SLOW, DARK, SLEP>
.byte $40,$00,$2D,$2C,$24,$25,$27,$24,$2F,$2C,$FF,$FF,$FF,$FF,$FF,$FF ;72 MAGE     ; <RUB, LIT3 ,FIR3 ,BANE, SLO2, FIR3, STUN, LIT3>
.byte $30,$00,$3A,$3B,$33,$2A,$2B,$30,$23,$20,$FF,$FF,$FF,$FF,$FF,$FF ;73 FIGHTER  ; <WALL, XFER, HEL3, FOG2, INV2, CUR4 ,HEL2, CUR3>
.byte $00,$00,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF ;74 MADPONY  ;
.byte $00,$20,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$13,$13,$13,$13,$FF ;75 NITEMARE ; [SNORTING x4]
.byte $00,$20,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$14,$14,$14,$14,$FF ;76 WarMECH  ; [NUCLEAR x4]
.byte $60,$00,$1F,$1C,$1D,$16,$15,$14,$0F,$05,$FF,$FF,$FF,$FF,$FF,$FF ;77 LICH     ; <ICE2, SLP2, FAST, LIT2, HOLD, FIR2, SLOW, SLEP>
.byte $60,$00,$3C,$3D,$3E,$3F,$3C,$3D,$3E,$3F,$FF,$FF,$FF,$FF,$FF,$FF ;78 LICH 2   ; <NUKE, STOP, ZAP!, XXXX>
.byte $30,$00,$14,$0D,$14,$0D,$14,$15,$14,$15,$FF,$FF,$FF,$FF,$FF,$FF ;79 KARY     ; <FIR2, DARK, FIR2, DARK, FIR2, HOLD, FIR2, HOLD>
.byte $30,$00,$24,$2D,$24,$2D,$24,$2F,$24,$2F,$FF,$FF,$FF,$FF,$FF,$FF ;7A KARY 2   ; <FIR3, RUB>
.byte $00,$20,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$15,$15,$15,$15,$FF ;7B KRAKEN   ; [INK x4]
.byte $30,$20,$16,$16,$16,$16,$16,$16,$16,$16,$FF,$15,$15,$15,$15,$FF ;7C KRAKEN 2 ; [INK x4]
.byte $00,$40,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$11,$10,$0A,$0B,$FF ;7D TIAMAT   ; [THUNDER, POISON, BLIZZARD, BLAZE]
.byte $40,$40,$25,$1F,$16,$14,$25,$1F,$16,$14,$FF,$11,$10,$0A,$0B,$FF ;7E TIAMAT 2 ; <BANE, ICE2, LIT2, FIR2, BANE, ICE2, LIT2, FIR2> [THUNDER, POISON, BLIZZARD, BLAZE]
.byte $40,$40,$34,$2C,$27,$30,$24,$1F,$1D,$3C,$FF,$06,$0C,$18,$19,$FF ;7F CHAOS    ; <ICE3, LIT3, SLO2, CUR4, FIR3, ICE2, FAST, NUKE> [CRACK, INFERNO, SWIRL, TORNADO]




data_EnemyStats:

;; I just stole all this again from the FFbytes docs by Dienyddiwr Da - http://www.romhacking.net/documents/81/ !

;     ENROMSTAT_EXP
;     |       ENROMSTAT_GP
;     |       |       ENROMSTAT_HPMAX
;     |       |       |      ENROMSTAT_MORALE
;     |       |       |       |   ENROMSTAT_STATRESIST
;     |       |       |       |   |   ENROMSTAT_EVADE
;     |       |       |       |   |   |   ENROMSTAT_ABSORB
;     |       |       |       |   |   |   |   ENROMSTAT_NUMHITS - low bit = number of hits per attack ; high bits = number of unique attacks
;     |       |       |       |   |   |   |   |   ENROMSTAT_HITRATE
;     |___¸   |___¸   |___¸   |   |   |   |   |   |   ENROMSTAT_DAMAGE
;     |   |   |   |   |   |   |   |   |   |   |   |   |   ENROMSTAT_CRITRATE
;     |   |   |   |   |   |   |   |   |   |   |   |   |   |   ENROMSTAT_AILCHANCE
;     |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   ENROMSTAT_ATTACKAIL
;     |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   ENROMSTAT_CATEGORY
;     |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   ENROMSTAT_MAGDEF
;     |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   ENROMSTAT_ELEMWEAK
;     |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   ENROMSTAT_ELEMRESIST
;     |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   ENROMSTAT_ELEMATTACK
;     2   1   2   1   2   1   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   ENROMSTAT_SPEED
;     |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   ENROMSTAT_LEVEL
;     |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   ENROMSTAT_ITEM
;     |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   ENROMSTAT_BLANK
;     |__ |__ |__ |__ |__ |__ |__ |__ |__ |__ |__ |__ |__ |__ |__ |__ |__ |__ |__ |__ |__ |__ |__ |__ |__  ID Name
.byte $06,$00,$06,$00,$08,$00,$6A,$00,$06,$04,$11,$02,$04,$01,$00,$00,$04,$10,$00,$00,$00,$05,$01,$01,$00 ;00 IMP
.byte $12,$00,$12,$00,$10,$00,$78,$00,$09,$06,$11,$04,$08,$01,$00,$00,$04,$17,$00,$00,$00,$08,$02,$01,$00 ;01 GrIMP
.byte $18,$00,$06,$00,$14,$00,$69,$00,$24,$00,$11,$05,$08,$01,$00,$00,$00,$1C,$00,$00,$00,$07,$01,$00,$00 ;02 WOLF
.byte $5D,$00,$16,$00,$48,$00,$6C,$00,$36,$00,$11,$12,$0E,$01,$00,$00,$00,$2E,$00,$00,$00,$09,$02,$00,$00 ;03 GrWolf
.byte $87,$00,$43,$00,$44,$00,$78,$04,$2A,$06,$11,$11,$0E,$01,$64,$04,$91,$2D,$00,$00,$01,$0C,$04,$00,$00 ;04 WrWolf
.byte $92,$01,$C8,$00,$5C,$00,$C8,$00,$36,$00,$11,$17,$19,$01,$00,$00,$00,$37,$10,$20,$20,$10,$0C,$00,$00 ;05 FrWOLF
.byte $99,$00,$32,$00,$5C,$00,$86,$00,$18,$0C,$11,$17,$12,$0A,$00,$00,$02,$37,$00,$00,$00,$05,$03,$00,$00 ;06 IGUANA
.byte $A8,$09,$B0,$04,$28,$01,$C8,$00,$24,$12,$12,$4A,$1F,$01,$00,$00,$02,$8F,$20,$10,$10,$0C,$00,$00,$00 ;07 AGAMA
.byte $B9,$07,$92,$02,$C4,$00,$C8,$00,$18,$14,$11,$36,$1E,$01,$00,$00,$02,$5B,$00,$00,$00,$10,$00,$00,$00 ;08 SAURIA
.byte $6F,$03,$6F,$03,$F0,$00,$88,$00,$30,$0C,$11,$3C,$26,$01,$00,$00,$04,$78,$00,$00,$00,$0C,$00,$01,$00 ;09 GIANT
.byte $D8,$06,$D8,$06,$50,$01,$C8,$00,$30,$10,$11,$4E,$3C,$01,$00,$00,$04,$96,$10,$20,$20,$12,$00,$01,$00 ;0A FrGIANT
.byte $E2,$05,$E2,$05,$2C,$01,$C8,$00,$30,$14,$11,$53,$49,$01,$00,$00,$04,$87,$20,$10,$10,$14,$00,$01,$00 ;0B R`GIANT
.byte $1E,$00,$1E,$00,$1C,$00,$6E,$00,$48,$04,$11,$07,$0A,$01,$00,$00,$20,$1C,$40,$90,$00,$09,$03,$01,$00 ;0C SAHAG
.byte $69,$00,$69,$00,$40,$00,$8E,$00,$4E,$08,$11,$10,$0F,$01,$00,$00,$20,$2E,$40,$90,$00,$10,$05,$01,$00 ;0D R`SAHAG
.byte $72,$03,$72,$03,$CC,$00,$C8,$80,$60,$14,$11,$33,$2F,$01,$00,$00,$20,$65,$40,$90,$20,$15,$14,$01,$00 ;0E WzSAHAG
.byte $28,$00,$28,$00,$06,$00,$FF,$00,$0C,$00,$11,$02,$08,$01,$00,$00,$00,$0F,$00,$00,$00,$16,$04,$01,$00 ;0F PIRATE
.byte $3C,$00,$78,$00,$32,$00,$6A,$00,$18,$06,$11,$0D,$0E,$01,$00,$00,$00,$25,$00,$80,$00,$10,$05,$01,$00 ;10 KYZOKU
.byte $0B,$01,$42,$00,$78,$00,$79,$00,$48,$00,$11,$1E,$16,$01,$00,$00,$20,$46,$40,$90,$00,$0C,$07,$00,$00 ;11 SHARK
.byte $39,$09,$58,$02,$58,$01,$C8,$00,$48,$08,$11,$56,$32,$01,$00,$00,$20,$AA,$40,$90,$00,$20,$15,$00,$00 ;12 GrSHARK
.byte $2A,$00,$0A,$00,$0A,$00,$6E,$00,$54,$00,$11,$02,$04,$01,$00,$00,$00,$0E,$40,$90,$08,$0F,$03,$00,$00 ;13 OddEYE
.byte $07,$0E,$07,$0E,$30,$01,$C8,$00,$18,$10,$12,$4C,$1E,$01,$00,$00,$20,$9C,$40,$90,$08,$1F,$14,$00,$00 ;14 BigEYE
.byte $09,$00,$03,$00,$0A,$00,$7C,$01,$0C,$00,$11,$02,$0A,$01,$00,$00,$08,$11,$10,$2B,$01,$09,$04,$01,$00 ;15 BONE
.byte $7A,$01,$7A,$01,$90,$00,$9C,$01,$2A,$0C,$11,$24,$1A,$01,$00,$00,$08,$4C,$10,$2B,$01,$16,$08,$01,$00 ;16 R`BONE
.byte $3F,$00,$0F,$00,$38,$00,$68,$00,$18,$08,$11,$0E,$11,$01,$00,$00,$00,$28,$10,$00,$00,$03,$04,$00,$00 ;17 CREEP
.byte $BA,$00,$C8,$00,$54,$00,$6A,$00,$2A,$08,$18,$15,$01,$01,$64,$10,$00,$33,$00,$00,$00,$06,$07,$00,$00 ;18 CRAWL
.byte $20,$01,$48,$00,$78,$00,$7A,$00,$30,$04,$11,$1E,$16,$01,$00,$00,$00,$4C,$00,$00,$00,$16,$0A,$00,$00 ;19 HYENA
.byte $9E,$04,$58,$02,$C0,$00,$92,$00,$30,$08,$11,$30,$1E,$01,$00,$00,$00,$67,$20,$10,$10,$23,$10,$00,$00 ;1A CEREBUS
.byte $C3,$00,$C3,$00,$64,$00,$74,$00,$12,$0A,$11,$19,$12,$01,$00,$00,$04,$41,$00,$00,$00,$12,$07,$01,$00 ;1B OGRE
.byte $1A,$01,$2C,$01,$84,$00,$7E,$00,$1E,$0E,$11,$21,$17,$01,$00,$00,$04,$47,$00,$00,$00,$16,$0A,$01,$00 ;1C GrOGRE
.byte $D3,$02,$D3,$02,$90,$00,$86,$80,$36,$0A,$11,$24,$17,$01,$00,$00,$C4,$50,$00,$80,$80,$20,$0F,$01,$00 ;1D WzOGRE
.byte $7B,$00,$32,$00,$38,$00,$6B,$04,$1E,$06,$11,$0E,$06,$01,$53,$04,$02,$2E,$00,$00,$00,$1C,$05,$00,$00 ;1E ASP
.byte $A5,$00,$32,$00,$50,$00,$6E,$04,$24,$0A,$11,$14,$16,$1F,$00,$00,$02,$38,$00,$00,$00,$22,$0E,$00,$00 ;1F COBRA
.byte $BD,$03,$58,$02,$E0,$00,$C8,$04,$30,$0C,$11,$38,$23,$00,$00,$00,$22,$74,$40,$90,$08,$29,$16,$00,$00 ;20 SeaSNAKE
.byte $E1,$00,$46,$00,$54,$00,$70,$04,$36,$0A,$12,$15,$16,$01,$75,$04,$00,$37,$00,$00,$00,$12,$0E,$00,$00 ;21 SCORPION
.byte $7F,$02,$2C,$01,$94,$00,$C8,$04,$3C,$12,$13,$25,$23,$01,$86,$04,$20,$55,$40,$90,$00,$18,$16,$00,$00 ;22 LOBSTER
.byte $E9,$01,$E9,$01,$A4,$00,$7C,$00,$30,$04,$12,$29,$16,$01,$00,$00,$00,$5F,$00,$00,$00,$16,$0A,$01,$00 ;23 BULL
.byte $1A,$04,$1A,$04,$E0,$00,$88,$00,$24,$0E,$11,$38,$28,$01,$00,$00,$08,$74,$10,$2B,$01,$10,$14,$01,$00 ;24 ZomBULL
.byte $6D,$02,$6D,$02,$B8,$00,$88,$00,$30,$0C,$13,$2E,$18,$01,$00,$00,$80,$64,$10,$00,$80,$1C,$09,$01,$00 ;25 TROLL
.byte $54,$03,$54,$03,$D8,$00,$C8,$00,$30,$14,$11,$36,$28,$01,$00,$00,$A0,$6E,$40,$80,$08,$26,$13,$01,$00 ;26 SeaTROLL
.byte $5A,$00,$2D,$00,$32,$00,$7C,$8F,$24,$00,$11,$0D,$0A,$01,$53,$08,$09,$25,$10,$AB,$01,$06,$06,$00,$00 ;27 SHADOW
.byte $E7,$00,$E7,$00,$56,$00,$A0,$8F,$5A,$04,$11,$16,$16,$01,$64,$10,$09,$34,$10,$AB,$01,$0C,$0A,$00,$00 ;28 IMAGE
.byte $B0,$01,$B0,$01,$72,$00,$A0,$8F,$6C,$0C,$11,$1D,$28,$01,$75,$10,$09,$43,$10,$AB,$01,$16,$10,$00,$00 ;29 WRAITH
.byte $DE,$03,$DE,$03,$B4,$00,$B8,$8F,$24,$1E,$11,$2D,$5D,$01,$86,$10,$09,$55,$10,$AB,$01,$24,$20,$00,$00 ;2A GHOST
.byte $18,$00,$0C,$00,$14,$00,$78,$31,$06,$00,$11,$05,$0A,$01,$00,$00,$08,$19,$10,$AB,$01,$02,$05,$01,$00 ;2B ZOMBIE
.byte $5D,$00,$32,$00,$30,$00,$7C,$31,$0C,$06,$13,$0C,$08,$01,$42,$10,$08,$24,$10,$2B,$01,$04,$08,$01,$00 ;2C GHOUL
.byte $75,$00,$75,$00,$38,$00,$A0,$31,$2E,$0A,$13,$0E,$08,$01,$53,$10,$08,$28,$10,$2B,$01,$0D,$12,$01,$00 ;2D GEIST
.byte $96,$00,$96,$00,$34,$00,$A0,$31,$2A,$0C,$11,$0D,$14,$01,$64,$10,$08,$2D,$10,$2B,$01,$18,$15,$01,$00 ;2E SPECTER
.byte $F8,$10,$E8,$03,$00,$01,$C8,$00,$24,$0A,$11,$70,$41,$0A,$00,$00,$00,$C8,$00,$80,$80,$10,$15,$00,$00 ;2F WORM
.byte $7B,$0A,$84,$03,$C8,$00,$7C,$00,$3E,$0E,$11,$32,$2E,$01,$00,$00,$00,$67,$00,$80,$80,$20,$20,$00,$00 ;30 Sand W
.byte $87,$06,$90,$01,$18,$01,$C8,$00,$04,$1F,$11,$46,$32,$01,$00,$00,$00,$8F,$20,$90,$80,$30,$25,$00,$00 ;31 Grey W
.byte $99,$0C,$99,$0C,$A2,$00,$C8,$F1,$0C,$1E,$21,$2A,$1E,$01,$97,$80,$40,$5C,$00,$80,$01,$30,$20,$00,$00 ;32 EYE
.byte $01,$00,$01,$00,$68,$01,$C8,$F1,$18,$3C,$21,$96,$78,$28,$97,$10,$89,$A0,$10,$AB,$03,$30,$30,$00,$00 ;33 PHANTOM
.byte $BB,$02,$BB,$02,$44,$00,$96,$02,$24,$0A,$11,$11,$14,$01,$53,$04,$00,$37,$00,$00,$00,$15,$10,$01,$00 ;34 MEDUSA
.byte $C2,$04,$C2,$04,$60,$00,$C8,$02,$48,$0C,$1A,$18,$0B,$01,$75,$10,$01,$46,$10,$A0,$00,$1C,$18,$01,$00 ;35 GrMEDUSA
.byte $0C,$03,$0C,$03,$A0,$00,$94,$00,$30,$10,$12,$28,$1E,$01,$64,$04,$91,$5D,$00,$00,$00,$20,$11,$01,$00 ;36 CATMAN
.byte $5B,$02,$20,$03,$6E,$00,$96,$00,$3C,$1E,$13,$1C,$14,$01,$00,$00,$40,$3E,$00,$FB,$00,$2C,$19,$01,$00 ;37 MANCAT
.byte $AA,$04,$2C,$01,$DE,$00,$6F,$04,$30,$14,$11,$38,$27,$01,$64,$04,$00,$74,$00,$00,$00,$10,$12,$00,$00 ;38 PEDE
.byte $C4,$08,$E8,$03,$40,$01,$B0,$04,$30,$18,$11,$50,$49,$01,$00,$00,$00,$B9,$00,$30,$00,$20,$20,$00,$00 ;39 GrPEDE
.byte $B6,$01,$6C,$00,$84,$00,$74,$00,$30,$08,$12,$21,$16,$19,$00,$00,$00,$55,$00,$00,$00,$20,$0B,$00,$00 ;3A TIGER
.byte $4B,$03,$F4,$01,$C8,$00,$B4,$00,$2A,$08,$12,$32,$18,$46,$00,$00,$00,$6A,$00,$00,$00,$30,$13,$00,$00 ;3B Saber T
.byte $B0,$04,$D0,$07,$9C,$00,$C8,$01,$48,$18,$11,$27,$4C,$01,$75,$10,$89,$4B,$10,$AB,$01,$1D,$10,$01,$00 ;3C VAMPIRE
.byte $51,$09,$B8,$0B,$2C,$01,$C8,$01,$48,$1C,$11,$2A,$5A,$01,$97,$10,$C9,$54,$10,$AB,$01,$26,$20,$01,$00 ;3D WzVAMP
.byte $84,$00,$50,$00,$50,$00,$84,$02,$2D,$08,$14,$14,$0C,$01,$00,$00,$01,$35,$00,$80,$80,$08,$0B,$00,$00 ;3E GARGOYLE
.byte $83,$01,$83,$01,$5E,$00,$86,$02,$48,$20,$14,$18,$0A,$01,$00,$00,$01,$7F,$00,$B0,$90,$15,$1B,$00,$00 ;3F R`GOYLE
.byte $00,$06,$00,$03,$20,$01,$C8,$80,$12,$14,$11,$48,$42,$01,$00,$00,$01,$82,$10,$EB,$80,$10,$0F,$01,$00 ;40 EARTH
.byte $54,$06,$20,$03,$14,$01,$C8,$88,$2A,$14,$11,$45,$32,$01,$00,$00,$01,$82,$20,$9B,$10,$20,$17,$01,$00 ;41 FIRE
.byte $A5,$06,$D0,$07,$C8,$00,$C8,$00,$78,$08,$11,$32,$35,$01,$00,$00,$02,$C4,$50,$A2,$24,$20,$20,$01,$00 ;42 Frost D
.byte $58,$0B,$A0,$0F,$F8,$00,$C8,$00,$60,$1E,$11,$3E,$4B,$01,$00,$00,$02,$C8,$22,$90,$14,$26,$20,$01,$00 ;43 Red D
.byte $1B,$09,$E7,$03,$0C,$01,$C8,$01,$18,$1E,$11,$43,$38,$01,$97,$10,$0A,$87,$10,$AB,$05,$10,$20,$01,$00 ;44 ZombieD
.byte $54,$00,$14,$00,$18,$00,$7C,$04,$00,$FF,$11,$01,$01,$01,$64,$04,$00,$24,$30,$CB,$00,$01,$05,$00,$00 ;45 SCUM
.byte $FF,$00,$46,$00,$4C,$00,$98,$04,$04,$07,$11,$13,$1E,$01,$00,$00,$00,$37,$40,$BB,$00,$01,$0A,$00,$00 ;46 MUCK
.byte $FC,$00,$46,$00,$4C,$00,$90,$04,$06,$06,$11,$13,$20,$01,$00,$00,$00,$37,$30,$CB,$00,$01,$0F,$00,$00 ;47 OOZE
.byte $4D,$04,$84,$03,$9C,$00,$C8,$04,$18,$FF,$11,$27,$31,$01,$64,$04,$00,$55,$10,$EB,$00,$01,$14,$00,$00 ;48 SLIME
.byte $1E,$00,$08,$00,$1C,$00,$6D,$04,$1E,$00,$11,$07,$0A,$01,$00,$00,$00,$1C,$00,$00,$00,$20,$03,$00,$00 ;49 SPIDER
.byte $8D,$00,$32,$00,$40,$00,$6F,$04,$18,$0C,$11,$10,$05,$01,$53,$04,$00,$2E,$00,$00,$00,$30,$08,$00,$00 ;4A ARACHNID
.byte $25,$05,$8A,$02,$A4,$00,$96,$04,$48,$08,$12,$29,$16,$01,$00,$00,$00,$5F,$00,$80,$02,$1C,$0F,$01,$00 ;4B MATICOR
.byte $88,$04,$88,$04,$E4,$00,$84,$04,$78,$0C,$13,$39,$17,$01,$00,$00,$00,$73,$00,$80,$02,$2D,$16,$01,$00 ;4C SPHINX
.byte $94,$05,$2C,$01,$00,$01,$92,$00,$38,$26,$13,$40,$3C,$01,$00,$00,$00,$82,$00,$00,$00,$20,$20,$00,$00 ;4D R`ANKYLO
.byte $32,$0A,$01,$00,$60,$01,$90,$00,$30,$30,$11,$58,$62,$01,$00,$00,$00,$9C,$00,$00,$00,$10,$18,$00,$00 ;4E ANKYLO
.byte $2C,$01,$2C,$01,$50,$00,$AC,$01,$18,$14,$11,$14,$1E,$01,$53,$20,$08,$3C,$10,$2B,$01,$08,$0E,$01,$00 ;4F MUMMY
.byte $D8,$03,$E8,$03,$BC,$00,$94,$01,$18,$18,$11,$2F,$2B,$01,$75,$20,$08,$5F,$10,$2B,$01,$20,$17,$01,$00 ;50 WzMUMMY
.byte $BA,$00,$C8,$00,$32,$00,$7C,$00,$48,$04,$11,$0A,$01,$01,$53,$02,$00,$2F,$00,$80,$04,$20,$0A,$00,$00 ;51 COCTRICE
.byte $A7,$01,$F4,$01,$2C,$00,$7C,$00,$48,$04,$11,$0B,$14,$01,$00,$00,$00,$2D,$20,$90,$04,$30,$16,$00,$00 ;52 PERILISK
.byte $95,$04,$32,$00,$D4,$00,$96,$00,$60,$0C,$11,$35,$1E,$01,$64,$04,$02,$73,$00,$80,$04,$1F,$15,$01,$00 ;53 WYVERN
.byte $C2,$04,$F6,$01,$04,$01,$96,$00,$3C,$16,$11,$41,$28,$01,$00,$00,$02,$83,$00,$80,$04,$28,$1F,$01,$00 ;54 WYRM
.byte $3B,$0D,$F6,$01,$E0,$01,$90,$00,$3C,$0A,$11,$85,$41,$01,$00,$00,$02,$C8,$00,$00,$00,$20,$26,$00,$00 ;55 TYRO
.byte $20,$1C,$58,$02,$58,$02,$96,$00,$3C,$0A,$11,$90,$73,$1E,$00,$00,$02,$C8,$00,$00,$00,$30,$30,$00,$00 ;56 T REX
.byte $F0,$00,$14,$00,$5C,$00,$8A,$00,$48,$00,$11,$17,$16,$01,$00,$00,$00,$44,$40,$90,$08,$26,$0A,$00,$00 ;57 CARIBE
.byte $22,$02,$2E,$00,$AC,$00,$8E,$00,$48,$14,$11,$2B,$25,$01,$00,$00,$00,$53,$00,$90,$08,$36,$11,$00,$00 ;58 R`CARIBE
.byte $30,$03,$84,$03,$B8,$00,$8A,$00,$30,$10,$12,$2E,$2A,$01,$00,$00,$00,$67,$40,$90,$08,$18,$0D,$00,$00 ;59 GATOR
.byte $62,$07,$D0,$07,$20,$01,$8E,$00,$30,$14,$12,$48,$38,$01,$00,$00,$02,$8F,$40,$90,$28,$24,$16,$00,$00 ;5A FrGATOR
.byte $C8,$04,$66,$00,$D0,$00,$B0,$00,$18,$18,$13,$34,$14,$01,$64,$04,$00,$74,$40,$90,$00,$14,$10,$00,$00 ;5B OCHO
.byte $75,$0C,$F4,$01,$58,$01,$C8,$00,$18,$20,$13,$56,$23,$01,$97,$04,$00,$AA,$00,$00,$00,$20,$20,$00,$00 ;5C NAOCHO
.byte $93,$03,$96,$00,$D4,$00,$8A,$00,$24,$0E,$23,$35,$1E,$01,$00,$00,$02,$74,$00,$00,$70,$20,$10,$00,$00 ;5D HYDRA
.byte $BF,$04,$90,$01,$B6,$00,$98,$00,$24,$0E,$23,$2E,$14,$01,$00,$00,$02,$67,$20,$10,$D0,$30,$20,$00,$00 ;5E R`HYDRA
.byte $C8,$04,$90,$01,$C8,$00,$C8,$00,$48,$28,$12,$32,$19,$01,$64,$10,$00,$6E,$40,$0B,$00,$26,$20,$01,$00 ;5F GAURD
.byte $A0,$0F,$D0,$07,$90,$01,$96,$00,$60,$30,$11,$5A,$66,$01,$00,$00,$00,$A0,$40,$BB,$00,$40,$28,$01,$00 ;60 SENTRY
.byte $AA,$07,$20,$03,$2C,$01,$C8,$00,$48,$14,$11,$44,$45,$01,$00,$00,$01,$82,$20,$9B,$28,$1F,$28,$00,$00 ;61 WATER
.byte $4E,$06,$27,$03,$66,$01,$C8,$00,$90,$04,$11,$3E,$35,$01,$00,$00,$01,$82,$00,$8B,$44,$30,$28,$00,$00 ;62 AIR
.byte $33,$09,$33,$09,$64,$01,$C8,$00,$48,$08,$11,$47,$09,$01,$64,$04,$60,$74,$40,$90,$00,$18,$12,$00,$00 ;63 NAGA
.byte $A1,$0D,$A0,$0F,$A4,$01,$9A,$00,$30,$10,$11,$58,$07,$01,$97,$04,$40,$8F,$00,$00,$40,$26,$1A,$00,$00 ;64 GrNAGA
.byte $10,$08,$C4,$09,$2C,$01,$C8,$00,$48,$14,$14,$3C,$1E,$01,$00,$00,$02,$82,$20,$90,$02,$20,$12,$00,$00 ;65 CHIMERA
.byte $E8,$11,$88,$13,$5E,$01,$C8,$00,$3C,$12,$14,$46,$28,$01,$00,$00,$02,$8F,$20,$90,$02,$34,$1A,$00,$00 ;66 JIMERA
.byte $14,$01,$2C,$01,$54,$00,$7E,$00,$42,$10,$12,$15,$1E,$01,$53,$80,$21,$62,$00,$33,$00,$10,$0A,$01,$00 ;67 WIZARD
.byte $36,$03,$E7,$03,$70,$00,$82,$00,$30,$0C,$13,$1C,$01,$01,$64,$01,$00,$BB,$00,$00,$00,$1C,$14,$01,$00 ;68 SORCERER
.byte $82,$00,$FA,$00,$6A,$00,$FF,$90,$0C,$0A,$21,$1B,$0F,$01,$00,$00,$00,$40,$00,$00,$00,$08,$06,$01,$00 ;69 GARLAND
.byte $E4,$0F,$88,$13,$60,$01,$C8,$04,$60,$10,$11,$44,$48,$01,$00,$00,$02,$C8,$20,$80,$04,$26,$26,$01,$00 ;6A Gas D
.byte $CA,$0C,$D0,$07,$C6,$01,$C8,$08,$60,$14,$11,$56,$5C,$01,$00,$00,$02,$C8,$10,$00,$44,$28,$26,$01,$00 ;6B Blue D
.byte $E9,$04,$20,$03,$B0,$00,$C8,$00,$1C,$07,$11,$2C,$40,$01,$75,$04,$41,$5D,$00,$7B,$80,$08,$10,$01,$00 ;6C MudGOL
.byte $51,$09,$E8,$03,$C8,$00,$C8,$00,$18,$10,$11,$32,$46,$01,$00,$00,$41,$6E,$00,$FB,$80,$10,$16,$01,$00 ;6D RockGOL
.byte $3D,$1A,$B8,$0B,$30,$01,$C8,$00,$18,$64,$11,$4C,$5D,$01,$00,$00,$01,$8F,$00,$BB,$80,$16,$1F,$01,$00 ;6E IronGOL
.byte $EF,$04,$08,$07,$04,$01,$C8,$00,$24,$26,$12,$41,$2C,$01,$00,$00,$00,$87,$00,$00,$01,$30,$11,$01,$00 ;6F BADMAN
.byte $8C,$0A,$B8,$0B,$BE,$00,$C8,$00,$2A,$20,$11,$30,$37,$01,$00,$00,$41,$AD,$00,$0B,$01,$38,$18,$01,$00 ;70 EVILMAN
.byte $CA,$08,$D0,$07,$A8,$00,$FF,$80,$4E,$28,$21,$2A,$1A,$01,$64,$80,$00,$AA,$00,$00,$00,$24,$12,$01,$00 ;71 ASTOS
.byte $47,$04,$47,$04,$69,$00,$C8,$00,$4E,$28,$11,$1B,$1A,$01,$00,$00,$40,$AA,$00,$00,$00,$26,$10,$01,$00 ;72 MAGE
.byte $5C,$0D,$5C,$0D,$C8,$00,$9E,$00,$5A,$26,$11,$2D,$28,$01,$00,$00,$40,$BA,$00,$00,$00,$28,$14,$01,$00 ;73 FIGHTER
.byte $3F,$00,$0F,$00,$40,$00,$6A,$00,$16,$02,$12,$10,$0A,$01,$00,$00,$00,$28,$00,$00,$00,$20,$03,$00,$00 ;74 MADPONY
.byte $F8,$04,$BC,$02,$C8,$00,$C8,$00,$84,$18,$13,$32,$1E,$01,$00,$00,$01,$64,$20,$9B,$01,$30,$10,$00,$00 ;75 NITEMARE
.byte $00,$7D,$00,$7D,$E8,$03,$C8,$FF,$60,$50,$12,$C8,$80,$01,$00,$00,$80,$C8,$00,$FB,$54,$40,$40,$01,$00 ;76 WarMECH
.byte $98,$08,$B8,$0B,$90,$01,$FF,$B7,$18,$28,$11,$31,$28,$01,$75,$10,$49,$78,$10,$2B,$81,$18,$1C,$81,$00 ;77 LICH
.byte $D0,$07,$01,$00,$F4,$01,$FF,$B7,$30,$32,$11,$40,$32,$01,$97,$10,$49,$8C,$00,$2B,$81,$28,$24,$81,$00 ;78 LICH (reprise)
.byte $AB,$09,$B8,$0B,$58,$02,$FF,$BF,$30,$32,$36,$3F,$28,$01,$00,$00,$41,$B7,$01,$72,$10,$20,$20,$81,$00 ;79 KARY
.byte $D0,$07,$01,$00,$BC,$02,$FF,$BF,$3C,$3C,$36,$3F,$3C,$01,$00,$00,$41,$B7,$00,$72,$10,$28,$28,$81,$00 ;7A KARY (reprise)
.byte $95,$10,$88,$13,$20,$03,$FF,$BF,$54,$3C,$48,$5A,$32,$01,$64,$08,$20,$A0,$40,$90,$28,$30,$24,$81,$00 ;7B KRAKEN
.byte $D0,$07,$01,$00,$84,$03,$FF,$BF,$62,$46,$48,$72,$46,$01,$97,$08,$20,$C8,$00,$90,$28,$38,$2C,$81,$00 ;7C KRAKEN (reprise)
.byte $78,$15,$70,$17,$E8,$03,$FF,$FB,$48,$50,$24,$50,$31,$01,$64,$80,$02,$C8,$02,$F0,$44,$40,$28,$81,$00 ;7D TIAMAT
.byte $D0,$07,$01,$00,$4C,$04,$FF,$FF,$5A,$5A,$24,$55,$4B,$01,$97,$80,$42,$C8,$00,$F0,$44,$48,$30,$81,$00 ;7E TIAMAT (reprise)
.byte $00,$00,$00,$00,$D0,$07,$FF,$FF,$64,$64,$12,$C8,$64,$01,$A8,$10,$00,$C8,$00,$FF,$03,$3F,$35,$81,$00 ;7F CHAOS

DoesEnemyXExist:
    LDA btl_enemyIDs, X
    CMP #$FF
    RTS

GetEnemyRAMPtr:
    LDX #28                ; multiply enemy index by $1C  (number of bytes per enemy)
    JSR MultiplyXA
    CLC                     ; then add btl_enemystats to the result
    ADC #<btl_enemystats                ;; FB
    STA EnemyRAMPointer
    TXA
    ADC #>btl_enemystats                ;; 6B
    STA EnemyRAMPointer+1
    RTS

LoadEnemyStats:
    LDA #0
    LDY #0
   @ClearLoop:
    STA btl_enemystats, Y
    STA btl_enemystats+$24, Y
    DEY
    BNE @ClearLoop

    LDA #$09
    STA btl_loadenstats_count              ; loop down-counter
    LDA #$00
    STA btl_loadenstats_index               ; loop up-counter / enemy index

    ;LDA #0
    STA tmp
    STA tmp+1
   @EnemyLoop:
    LDA btl_loadenstats_index               ; Put a pointer to the current enemy's stat RAM
    JSR GetEnemyRAMPtr                         ;    in btltmp+A

    LDX btl_loadenstats_index              ; Check to see if this enemy even exists
    JSR DoesEnemyXExist
    BNE :+

      LDA tmp
      CLC
      ADC #4
      STA tmp
      LDA tmp+1
      CLC
      ADC #28
      STA tmp+1
      JMP @NextEnemy        ; if it doesn't, skip ahead...

  : LDX #25                ; multiply current enemy ID by #25  (25 bytes of data per enemy)
    JSR MultiplyXA          ;   add the result to data_EnemyStats to generate a pointer to the enemy
    CLC                     ;   data in ROM.
    ADC #<data_EnemyStats
    STA EnemyROMPointer
    TXA
    ADC #>data_EnemyStats
    STA EnemyROMPointer+1

    LDX tmp
    LDY #0
   @RewardLoop:
    LDA (EnemyROMPointer), Y
    STA btl_enemyrewards, X
    INX
    INY
    CPY #4
    BNE @RewardLoop

    STX tmp
    LDX tmp+1

    ; Y = 4 here, is pointing at HP max
   @Loop:
    LDA (EnemyROMPointer), Y
    STA btl_enemystats, X
    INX
    INY
    CPY #25                  ; copy the next 21 bytes of ROM data into RAM.
    BNE @Loop

    LDA #1
    STA btl_enemystats, X    ; <- en_numhitsmult, default to hit multiplier of 1

    ;; skip 3 stats that were set to 0 by the clearing of the RAM 
    ;; en_unused, en_extraAI, and en_ailments

    TXA
    CLC
    ADC #7                   ; add 7 to the "btl_enemystats, X" position
    STA tmp+1                ;

    LDY #ENROMSTAT_HPMAX
    LDA (EnemyROMPointer), Y ; load max HP low byte
    PHA                      ; push low byte
    INY
    LDA (EnemyROMPointer), Y ; load max HP high byte

    LDY #en_hp+1             ; Y = $19, or 26
    STA (EnemyRAMPointer), Y ; save as current HP high byte
    PLA                      ; pull low byte
    DEY
    STA (EnemyRAMPointer), Y ; save as current HP low byte

    LDX btl_loadenstats_index   ; get the enemy ID
    LDA btl_enemyIDs, X
    LDY #en_enemyid
    STA (EnemyRAMPointer), Y

    ;; level is already set, but this will randomize things a bit!
    
    LDY #ENROMSTAT_LEVEL        ; get enemy level
    LDA (EnemyROMPointer), Y
    STA tmp+2                   ; save in tmp+2

    JSR BattleRNG_L
    AND #$0F                    ; get a random number between 0-15
    TAX                         ; and fetch an alteration number from this little LUT
    LDA EnemyLevelRandomizer_LUT, X 
    BEQ @SaveLevel             ; then increase or decrease the level 
    BMI @DecreaseLevel
    
    ;; 0   = do nothing
    ;; 1-3 = increase level by this amount
    ;; 4   = decrease level twice
    ;; 255 = decrease level
    
    CMP #4
    BEQ @DecreaseLevel_2
    
    CLC
    ADC tmp+2
    BNE @SaveLevel
    
   @DecreaseLevel_2: 
    DEC tmp+2
    
   @DecreaseLevel: 
    DEC tmp+2   

   @SaveLevel:
    LDA tmp+2
    STA (EnemyRAMPointer), Y    ; save level -- this gives a little bit of randomness to level-based checks

   @NextEnemy:
    INC btl_loadenstats_index           ; inc up-counter to look at next enemy
    DEC btl_loadenstats_count           ; dec down-counter
    BEQ :+
      JMP @EnemyLoop    ; loop until all 9 enemies processed

  : LDX #0
   @FillPlayerHitMultiplyer:
    TXA
    JSR PrepCharStatPointers
    LDY #ch_class - ch_stats
    LDA (CharStatsPointer), Y
    AND #CLS_BB | CLS_MA              ; see if the player character is BB or Master
    BEQ :+
       LDY #ch_righthand - ch_stats
       LDA (CharStatsPointer), Y     ; then see if they have a weapon equipped
       BNE :+
        LDA #02                      ; if no weapon, they have 2 fists, so a hit multiplyer of 2
        BNE :++
  : LDA #01                           ; everyone else gets 1
  : STA btl_charhitmult, X
    INX
    CPX #4
    BNE @FillPlayerHitMultiplyer

   ;; JIGS - and now on to filling the enemy's AI RAM!!

    LDA #0
    STA tmp+2                ; enemy ID counter
    STA tmp+3                ; AI index for writing to RAM
   @EnemyAI_Loop:
    JSR GetEnemyRAMPtr
    LDY #en_enemyid
    LDA (EnemyRAMPointer), Y
    AND #$7F                 ; cap at $7F, in case not enough enemies were loaded and old data wasn't overwritten with the right values here
    LDX #$10
    JSR MultiplyXA
    CLC
    ADC #<EnemyAIData
    STA EnemyROMPointer
    TXA
    ADC #>EnemyAIData
    STA EnemyROMPointer+1    ; ROM pointer now points to their AI data
 
    LDY #0
    LDX tmp+3
   @FillAI:
    LDA (EnemyROMPointer), Y
    STA lut_EnemyAi, X
    INX
    INY
    CPY #$10
    BNE @FillAI

    STX tmp+3                ; save RAM write position
    INC tmp+2                ; inc tmp+2 for next enemy
    LDA tmp+2
    CMP #$09
    BNE @EnemyAI_Loop
    RTS


EnemyLevelRandomizer_LUT:
;     0, 1, 2, 3, 4,   5, 6, 7, 8, 9, A, B, C, D, E,   F
.byte 0, 1, 2, 0, 255, 0, 1, 4, 2, 0, 1, 4, 0, 0, 255, 3

;;
;; For the enemy's ITEM byte above:
;; $01 = has item, $10 = has secondary item, $80 = has special item
;; So $91 means has all 3 items to steal
;;
;; First byte: item type  -- $00: gold, $01: consumable, $02: weapon/armor, $03: spell
;; almost just like treasure chests!
;;
;; Second byte: item name; for gold, its the index for the money chests
;;

lut_StealList:
.byte $00, GOLD1      , $00, $00, $00, $00         ; 10 gold        ,      ,                 ; 00 IMP
.byte $02, ARM26      , $00, $00, $00, $00         ; cap            ,      ,                 ; 01 GrIMP
.byte $00, $00        , $00, $00, $00, $00         ; *              *      *                 ; 02 WOLF
.byte $00, $00        , $00, $00, $00, $00         ; *              *      *                 ; 03 GrWolf
.byte $00, $00        , $00, $00, $00, $00         ; *              *      *                 ; 04 WrWolf
.byte $00, $00        , $00, $00, $00, $00         ; *              *      *                 ; 05 FrWOLF
.byte $00, $00        , $00, $00, $00, $00         ; *              *      *                 ; 06 IGUANA
.byte $00, $00        , $00, $00, $00, $00         ; *              *      *                 ; 07 AGAMA
.byte $00, $00        , $00, $00, $00, $00         ; *              *      *                 ; 08 SAURIA
.byte $02, ARM11      , $00, $00, $00, $00         ; Copper bracelet,      ,                 ; 09 GIANT
.byte $02, ARM12      , $00, $00, $00, $00         ; Silver bracelet,      ,                 ; 0A FrGIANT
.byte $01, X_HEAL     , $00, $00, $00, $00         ; X_Heal         ,      ,                 ; 0B R`GIANT
.byte $01, HEAL       , $00, $00, $00, $00         ; Heal           ,      ,                 ; 0C SAHAG
.byte $01, PURE       , $00, $00, $00, $00         ; Pure           ,      ,                 ; 0D R`SAHAG
.byte $01, X_HEAL     , $00, $00, $00, $00         ; X_Heal         ,      ,                 ; 0E WzSAHAG
.byte $02, WEP8       , $00, $00, $00, $00         ; Scimitar       ,      ,                 ; 0F PIRATE
.byte $02, WEP15      , $00, $00, $00, $00         ; Falchion       ,      ,                 ; 10 KYZOKU
.byte $00, $00        , $00, $00, $00, $00         ; *              *      *                 ; 11 SHARK
.byte $00, $00        , $00, $00, $00, $00         ; *              *      *                 ; 12 GrSHARK
.byte $00, $00        , $00, $00, $00, $00         ; *              *      *                 ; 13 OddEYE
.byte $00, $00        , $00, $00, $00, $00         ; *              *      *                 ; 14 BigEYE
.byte $02, WEP3       , $00, $00, $00, $00         ; Wooden staff   ,      ,                 ; 15 BONE
.byte $02, WEP11      , $00, $00, $00, $00         ; Iron staff     ,      ,                 ; 16 R`BONE
.byte $00, $00        , $00, $00, $00, $00         ; *              *      *                 ; 17 CREEP
.byte $00, $00        , $00, $00, $00, $00         ; *              *      *                 ; 18 CRAWL
.byte $00, $00        , $00, $00, $00, $00         ; *              *      *                 ; 19 HYENA
.byte $00, $00        , $00, $00, $00, $00         ; *              *      *                 ; 1A CEREBUS
.byte $02, WEP5       , $00, $00, $00, $00         ; Iron hammer    ,      ,                 ; 1B OGRE
.byte $02, WEP18      , $00, $00, $00, $00         ; Silver hammer  ,      ,                 ; 1C GrOGRE
.byte $03, MG_ICE2    , $00, $00, $00, $00         ; Ice 2 scroll   ,      ,                 ; 1D WzOGRE
.byte $00, $00        , $00, $00, $00, $00         ; *              *      *                 ; 1E ASP
.byte $00, $00        , $00, $00, $00, $00         ; *              *      *                 ; 1F COBRA
.byte $00, $00        , $00, $00, $00, $00         ; *              *      *                 ; 20 SeaSNAKE
.byte $00, $00        , $00, $00, $00, $00         ; *              *      *                 ; 21 SCORPION
.byte $00, $00        , $00, $00, $00, $00         ; *              *      *                 ; 22 LOBSTER
.byte $00, GOLD13     , $00, $00, $00, $00         ; 240 gold -     ,      ,                 ; 23 BULL
.byte $03, MG_AICE    , $00, $00, $00, $00         ; AICE scroll    ,      ,                 ; 24 ZomBULL
.byte $00, GOLD14     , $00, $00, $00, $00         ; 255 gold       ,      ,                 ; 25 TROLL
.byte $00, GOLD31     , $00, $00, $00, $00         ; 880 gold       ,      ,                 ; 26 SeaTROLL
.byte $00, $00        , $00, $00, $00, $00         ; *              *      *                 ; 27 SHADOW
.byte $00, $00        , $00, $00, $00, $00         ; *              *      *                 ; 28 IMAGE
.byte $00, $00        , $00, $00, $00, $00         ; *              *      *                 ; 29 WRAITH
.byte $00, $00        , $00, $00, $00, $00         ; *              *      *                 ; 2A GHOST
.byte $02, ARM1       , $00, $00, $00, $00         ; Cloth T        ,      ,                 ; 2B ZOMBIE
.byte $00, GOLD5      , $00, $00, $00, $00         ; 55 gold        ,      ,                 ; 2C GHOUL
.byte $00, GOLD7      , $00, $00, $00, $00         ; 85 gold        ,      ,                 ; 2D GEIST
.byte $00, GOLD12     , $00, $00, $00, $00         ; 180 gold       ,      ,                 ; 2E SPECTER
.byte $00, $00        , $00, $00, $00, $00         ; *              *      *                 ; 2F WORM
.byte $00, $00        , $00, $00, $00, $00         ; *              *      *                 ; 30 Sand W
.byte $00, $00        , $00, $00, $00, $00         ; *              *      *                 ; 31 Grey W
.byte $00, $00        , $00, $00, $00, $00         ; *              *      *                 ; 32 EYE
.byte $00, $00        , $00, $00, $00, $00         ; *              *      *                 ; 33 PHANTOM
.byte $01, SOFT       , $00, $00, $00, $00         ; Soft           ,      ,                 ; 34 MEDUSA
.byte $01, SOFT       , $00, $00, $00, $00         ; Soft           ,      ,                 ; 35 GrMEDUSA
.byte $01, PURE       , $00, $00, $00, $00         ; Pure           ,      ,                 ; 36 CATMAN
.byte $03, MG_FIR2    , $00, $00, $00, $00         ; Fire 2 scroll  ,      ,                 ; 37 MANCAT
.byte $00, $00        , $00, $00, $00, $00         ; *              *      *                 ; 38 PEDE
.byte $00, $00        , $00, $00, $00, $00         ; *              *      *                 ; 39 GrPEDE
.byte $00, $00        , $00, $00, $00, $00         ; *              *      *                 ; 3A TIGER
.byte $00, $00        , $00, $00, $00, $00         ; *              *      *                 ; 3B Saber T
.byte $01, X_HEAL     , $00, $00, $00, $00         ; X_Heal         ,      ,                 ; 3C VAMPIRE
.byte $01, ETHER      , $00, $00, $00, $00         ; Ether          ,      ,                 ; 3D WzVAMP
.byte $00, $00        , $00, $00, $00, $00         ; *              *      *                 ; 3E GARGOYLE
.byte $00, $00        , $00, $00, $00, $00         ; *              *      *                 ; 3F R`GOYLE
.byte $01, SOFT       , $00, $00, $00, $00         ; Soft           ,      ,                 ; 40 EARTH
.byte $01, SMOKEBOMB  , $00, $00, $00, $00         ; Smokebomb      ,      ,                 ; 41 FIRE
.byte $00, GOLD39     , $00, $00, $00, $00         ; 2750 gold      ,      ,                 ; 42 Frost D
.byte $00, GOLD39     , $00, $00, $00, $00         ; 2750 gold      ,      ,                 ; 43 Red D
.byte $00, GOLD41     , $00, $00, $00, $00         ; 5000 gold      ,      ,                 ; 44 ZombieD
.byte $00, $00        , $00, $00, $00, $00         ; *              *      *                 ; 45 SCUM
.byte $00, $00        , $00, $00, $00, $00         ; *              *      *                 ; 46 MUCK
.byte $00, $00        , $00, $00, $00, $00         ; *              *      *                 ; 47 OOZE
.byte $00, $00        , $00, $00, $00, $00         ; *              *      *                 ; 48 SLIME
.byte $00, $00        , $00, $00, $00, $00         ; *              *      *                 ; 49 SPIDER
.byte $00, $00        , $00, $00, $00, $00         ; *              *      *                 ; 4A ARACHNID
.byte $00, GOLD33     , $00, $00, $00, $00         ; 1250 gold      ,      ,                 ; 4B MANTICOR
.byte $00, GOLD36     , $00, $00, $00, $00         ; 1760 gold      ,      ,                 ; 4C SPHINX
.byte $00, $00        , $00, $00, $00, $00         ; *              *      *                 ; 4D R`ANKYLO
.byte $00, $00        , $00, $00, $00, $00         ; *              *      *                 ; 4E ANKYLO
.byte $01, ALARMCLOCK , $00, $00, $00, $00         ; Alarm Clock    ,      ,                 ; 4F MUMMY
.byte $01, ALARMCLOCK , $00, $00, $00, $00         ; Alarm Clock    ,      ,                 ; 50 WzMUMMY
.byte $00, $00        , $00, $00, $00, $00         ; *              *      *                 ; 51 COCTRICE
.byte $00, $00        , $00, $00, $00, $00         ; *              *      *                 ; 52 PERILISK
.byte $00, GOLD32     , $00, $00, $00, $00         ; 1020 gold      ,      ,                 ; 53 WYVERN
.byte $00, GOLD33     , $00, $00, $00, $00         ; 1250 gold      ,      ,                 ; 54 WYRM
.byte $00, $00        , $00, $00, $00, $00         ; *              *      *                 ; 55 TYRO
.byte $00, $00        , $00, $00, $00, $00         ; *              *      *                 ; 56 T REX
.byte $00, $00        , $00, $00, $00, $00         ; *              *      *                 ; 57 CARIBE
.byte $00, $00        , $00, $00, $00, $00         ; *              *      *                 ; 58 R`CARIBE
.byte $00, $00        , $00, $00, $00, $00         ; *              *      *                 ; 59 GATOR
.byte $00, $00        , $00, $00, $00, $00         ; *              *      *                 ; 5A FrGATOR
.byte $00, $00        , $00, $00, $00, $00         ; *              *      *                 ; 5B OCHO
.byte $00, $00        , $00, $00, $00, $00         ; *              *      *                 ; 5C NAOCHO
.byte $00, $00        , $00, $00, $00, $00         ; *              *      *                 ; 5D HYDRA
.byte $00, $00        , $00, $00, $00, $00         ; *              *      *                 ; 5E R`HYDRA
.byte $01, SMOKEBOMB  , $00, $00, $00, $00         ; Smokebomb      ,      ,                 ; 5F GAURD
.byte $01, SMOKEBOMB  , $00, $00, $00, $00         ; Smokebomb      ,      ,                 ; 60 SENTRY
.byte $00, $00        , $00, $00, $00, $00         ; *              *      *                 ; 61 WATER
.byte $00, $00        , $00, $00, $00, $00         ; *              *      *                 ; 62 AIR
.byte $00, $00        , $00, $00, $00, $00         ; *              *      *                 ; 63 NAGA
.byte $00, $00        , $00, $00, $00, $00         ; *              *      *                 ; 64 GrNAGA
.byte $00, $00        , $00, $00, $00, $00         ; *              *      *                 ; 65 CHIMERA
.byte $00, $00        , $00, $00, $00, $00         ; *              *      *                 ; 66 JIMERA
.byte $03, MG_LIT     , $00, $00, $00, $00         ; Bolt 2 scroll  ,      ,                 ; 67 WIZARD
.byte $01, ETHER      , $00, $00, $00, $00         ; Ether          ,      ,                 ; 68 SORCERER
.byte $02, WEP6       , $00, $00, $00, $00         ; Short sword    ,      ,                 ; 69 GARLAND
.byte $00, GOLD45     , $00, $00, $00, $00         ; 6720 gold      ,      ,                 ; 6A Gas D
.byte $00, GOLD47     , $00, $00, $00, $00         ; 7690 gold      ,      ,                 ; 6B Blue D
.byte $03, MG_FAST    , $00, $00, $00, $00         ; Fast scroll    ,      ,                 ; 6C MudGOL
.byte $03, MG_SLOW    , $00, $00, $00, $00         ; Slow scroll    ,      ,                 ; 6D RockGOL
.byte $02, ARM4       , $00, $00, $00, $00         ; Iron armor     ,      ,                 ; 6E IronGOL
.byte $02, ARM6       , $00, $00, $00, $00         ; Silver armor   ,      ,                 ; 6F BADMAN
.byte $02, WEP17      , $00, $00, $00, $00         ; Silver sword   ,      ,                 ; 70 EVILMAN
.byte $03, MG_RUB     , $00, $00, $00, $00         ; Rub scroll     ,      ,                 ; 71 ASTOS
.byte $01, ETHER      , $00, $00, $00, $00         ; Ether          ,      ,                 ; 72 MAGE
.byte $03, MG_FOG2    , $00, $00, $00, $00         ; Fog 2 scroll   ,      ,                 ; 73 FIGHTER
.byte $00, $00        , $00, $00, $00, $00         ; *              *      *                 ; 74 MADPONY
.byte $00, $00        , $00, $00, $00, $00         ; *              *      *                 ; 75 NITEMARE
.byte $01, ELIXIR     , $00, $00, $00, $00         ; Elixir         ,      ,                 ; 76 WarMECH
.byte $01, PHOENIXDOWN, $00, $00, $03, MG_QAKE     ; Phoenix Down   ,      , Quake scroll    ; 77 LICH
.byte $01, PHOENIXDOWN, $00, $00, $02, ARM23       ; Phoenix Down   ,      , Aegis Shield    ; 78 LICH (reprise)
.byte $03, MG_FIR3    , $00, $00, $02, ARM20       ; Fire 3 scroll  ,      , Flame Shield    ; 79 KARY
.byte $01, SMOKEBOMB  , $00, $00, $02, ARM32       ; Smokebomb      ,      , Ribbon          ; 7A KARY (reprise)
.byte $02, ARM14      , $00, $00, $02, ARM25       ; Opal bracelet  ,      , Protect Cape    ; 7B KRAKEN
.byte $01, ETHER      , $00, $00, $02, ARM38       ; Ether          ,      , Power Gauntlet  ; 7C KRAKEN (reprise)
.byte $01, ELIXIR     , $00, $00, $02, ARM10       ; Elixir         ,      , Dragon armor    ; 7D TIAMAT
.byte $01, ELIXIR     , $00, $00, $02, WEP40       ; Elixir         ,      , Masamune        ; 7E TIAMAT (reprise)
.byte $01, ELIXIR     , $00, $00, $01, PHOENIXDOWN ; Elixir         ,      , Elixer          ; 7F CHAOS

;
; JIGS - tried to copy the stealing algorithm from FF6, as seen in MasterZed's faq:
; https://gamefaqs.gamespot.com/ps/562865-final-fantasy-vi/faqs/11114
;

;1. If the monster has no items, then you automatically fail to steal.
;
;2. If your level is >= 205 (hacks only), you automatically steal.
;   (Skip steps 3 through 7)
;
;3. StealValue = Your Level + 50 - Monster's level
;
;4. If StealValue < 0 then you fail to steal.
;
;5. If StealValue >=128 then you automatically steal.  (Skip steps 6 and 7)
;
;6. If you have a Sneak Ring equipped:
;      StealValue = StealValue * 2
;
;7. If StealValue <= [0..99] then you fail to steal.
;
;8. You have 1 in 8 chance of getting a rare item; otherwise, you get a common
;   item.
;
;9. If the monster doesn't have an item to steal in that slot, then you fail to
;   steal; otherwise, you successfully steal that item.
;


StealFromEnemyZ:
    LDA #$0F
    STA btl_unformattedstringbuf ; message code
    LDA #BTLMSG_STOLE
    STA btl_unformattedstringbuf+1 ; message "Stole"
    LDA #$0E
    STA btl_unformattedstringbuf+2 ; put the item name code into the message buffer

    LDA #0
    STA btl_unformattedstringbuf+4 ; 44 must be 0'd if its a normal item
    STA btl_unformattedstringbuf+6 ; if its a scroll, 44 and 45 are written over, so end at 46
    STA MMC5_tmp+2
    STA MMC5_tmp+1
    STA battle_stealsuccess

    LDA btl_defender
    JSR GetEnemyRAMPtr

    LDY #en_item
    LDA (EnemyRAMPointer), Y        ; get their "has item" byte
    BEQ @Nothing                    ; battle_stealsuccess remains 0

    PHA                             ; backup their "has item" byte
    LDA btl_attacker
    AND #03
    TAX
   ; JSR PrepCharStatPointers
    LDY #ch_ailments - ch_stats
    LDA (CharStatsPointer), Y
    AND #AIL_DARK
    BEQ :+
        LDA #30
        STA MMC5_tmp+1
  : LDA btl_charhidden, X
    BEQ :+
        LDA #15
        STA MMC5_tmp+2
  : LDY #en_level
    LDA (EnemyRAMPointer), Y        ; get enemy level
    STA tmp+1
    LDA MMC5_tmp                    ; load thief's level (was saved in Bank C)
    CLC
    ADC #50                         ; add 50
    ADC MMC5_tmp+2                  ; add 15 if hidden
    SEC
    SBC tmp+1                       ; subtract enemy level
    SBC MMC5_tmp+1                  ; subtract 30 if blind
    STA MMC5_tmp                    ; if neither hidden or blind, then StealValue = Level + 50 - Enemy's level
    BCC @Fail                       ; Carry clear = StealValue is less than 0
    CMP #100
    BCS @Success                    ; StealValue is maxed

    LDA #0
    LDX #99                         ; get 1-99
    JSR RandAX
    CMP MMC5_tmp                    ; Carry set on fail: StealValue is higher than the roll
    BCC @Success

  @Fail:
    PLA                             ; undo the push
  @Fail_NoPush:
    DEC battle_stealsuccess

  @Nothing:
    RTS

  @Success:
    LDY #en_enemyid
    LDA (EnemyRAMPointer), Y        ; get the enemy's index
    LDX #6
    JSR MultiplyXA                  ; multiply by 6 (6 bytes in the steal list)
    CLC
    ADC #<lut_StealList
    STA tmp
    TXA
    ADC #>lut_StealList
    STA tmp+1                       ; (tmp) now points to the first byte in their inventory

    PLA                             ; get the enemy's backed up "Has Item" byte
    BPL @StealNormal                ; if the high bit was NOT set, they have no special items

    JSR BattleRNG_L
    AND #$07                        ; 1 in 8 chance that it pulls a 0 now
    BEQ @StealSpecial

   @StealNormal:
    LDY #en_item
    LDA (EnemyRAMPointer), Y
    AND #$11
    BEQ @Fail_NoPush

    LDA (EnemyRAMPointer), Y
    PHA                             ; push it again...
    AND #~$11
    STA (EnemyRAMPointer), Y        ; then clear it out so it can't be stolen

    PLA                             ; and pull to see if they ever had a secondary item
    AND #$10
    BEQ @StealNormal_1              ; they have no secondary item to steal

    JSR BattleRNG_L
    AND #01
    BNE @StealNormal_2

   @StealNormal_1:
    LDY #0
    BEQ @FindItem

   @StealNormal_2:
    LDY #2
    BNE @FindItem

   @StealSpecial:
    LDY #en_item
    LDA (EnemyRAMPointer), Y
    AND #~$80
    STA (EnemyRAMPointer), Y        ; then clear it out so it can't be stolen
    LDY #4

   @FindItem:
    INC battle_stealsuccess
    LDA (tmp), Y
    BEQ @StealGold

    CMP #1
    BEQ @StealItem

    CMP #2
    BEQ @StealEquipment

   @StealMagic:                     ; do all the different ways of putting items in your inventory
    INY
    LDA (tmp), Y
    STA btl_unformattedstringbuf+3  ; put the item name next in the message buffer
    SEC
    SBC #ITEM_MAGICSTART
    TAX
    INC inv_magic, X
    LDA #$0F
    STA btl_unformattedstringbuf+4
    LDA #BTLMSG_SCROLL
    STA btl_unformattedstringbuf+5  ; and put _scroll at the end of the message
    RTS

   @StealEquipment:
    LDA #$0D
    STA btl_unformattedstringbuf+2   ; here, re-write the item name byte with equipment name byte
    INY
    LDA (tmp), Y
    TAX
    STX btl_unformattedstringbuf+3
    INC inv_weapon, X
    RTS

   @StealItem:
    INY
    LDA (tmp), Y
    STA btl_unformattedstringbuf+3
    TAX
    INC items, X
    RTS

   @StealGold:
    LDA #3
    STA shop_type                    ; needed to make sure LoadPrice works right

    INY
    LDA (tmp), Y
    STA btl_unformattedstringbuf+3
    JSR LoadPriceZ                   ; get the price of the item (the amount of gold stolen)
    JSR AddGPToParty                 ; add that to the party's GP
    RTS








;; This checks if the player attacker is a cleric, and doubles their crit chance against undead enemies.
;; JIGS - leaving this here as proof of concept... My hack idea originally turned fighters/knights into undead-slayers. You can do the same!

 ClericCheck:
;    LDA battle_defenderisplayer     ; is it player attacking?
;    BNE @return
;    LDA btl_defender_class
;    BEQ :+                          ; if fighter
;    CMP #$06                        ; or knight
;    BNE @return
;  : LDA btl_defender_category
;    AND #CATEGORY_UNDEAD+CATEGORY_WERE
;    BEQ @return
;    ASL math_critchance             ; *2 Crit chance against undead/cursed
;    @return:
;    RTS

;; This checks if the player attacker is a given class, and gives a status effect to their critical hits.

CritCheck:
    LDA #0
    STA MMC5_tmp
    LDA battle_attackerisplayer
    BEQ @CritReturn                 ; don't do any of these if confusedly attacking another character

    LDA btl_attacker
    JSR PrepCharStatPointers
    LDY #ch_speed - ch_stats        ;
    LDA (CharStatsPointer), Y       ; get speed (luck)
    ASL A
    LDX #100                        ;
    JSR RandAX                      ; Random number between speed/luck and 100
    CMP #75                         ; Gotta roll over 75 to do the thing
    BCC @CritReturn

    LDA btl_attacker_class
    AND #$0F             ;; JIGS - cut off high bits (hidden state)
    CMP #$01                        ; IF thief, goto CritCrit
    BEQ @CritCrit
    CMP #$07                        ; IF ninja, goto CritCrit
    BEQ @CritCrit
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

   @CritCrit:
    LDA btl_attacker_critrate
    CLC
    ADC #4
    BCC :+
      LDA #$FF
 : 	LDY #ch_critrate - ch_stats
    STA (CharStatsPointer), Y
    LDA #BTLMSG_CRITUP
    STA MMC5_tmp
    RTS

   @CritStun:
    LDA btl_defender_elementresist
    AND #$01
    BEQ :+                          ; if defender resists the special attack's element (stun 01)
    RTS                             ; cancel specialty
  : LDA #BTLMSG_PARALYZED
    STA MMC5_tmp
    LDA #AIL_STUN                   ; Stun ailment as used by STUN's effectivity in original game
    JMP @CritAddAilment

   @CritSlow:
    LDA btl_defender
    LDY #en_numhitsmult
    LDA (EnemyRAMPointer), Y        ; hit multiplier from RAM stats
    STA MMC5_tmp
    DEC MMC5_tmp                    ; Decrease their hit multiplier
    LDA MMC5_tmp
    BNE :+
        RTS                         ; if it went to 0, don't save it

 :  STA (EnemyRAMPointer), Y
    LDA #BTLMSG_LOSTINTELLIGENCE
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

   @CritConfuse:
    LDA btl_defender_elementresist
    AND #$08
    BEQ :+                          ; if defender resists the special attack's element (dark/confuses 08)
    RTS                             ; cancel specialty
  : LDA #BTLMSG_CONFUSED
    STA MMC5_tmp
    LDA #AIL_CONF                   ; Confuse ailment as used by CONF's effectivity in original game
    JMP @CritAddAilment

   @CritAddAilment:
    BIT btl_defender_ailments
    BNE @noailment
    ORA btl_defender_ailments    ; add to existing ailments
    STA btl_defender_ailments
    LDA (CharStatsPointer), Y    ; Check the class (Y is still character class)

   @noailment:
    RTS



HiddenCheck:
    LDA btl_attacker_hitrate ; regardless of class, double their hit rate
    ASL A
    BCC :+
        LDA #$FF              ; cap at FF
  :	STA btl_attacker_hitrate

    LDA btl_attacker_critrate ; regardless of class, 1.5x their crit rate
    LSR A                     ; halve it, then add in original value
    CLC
    ADC btl_attacker_critrate
    BCC :+
        LDA #$FF              ; cap at FF
  :	STA btl_attacker_critrate

    LDA btl_attacker_class
    CMP #$01                     ; if thief
    BEQ @HiddenBoost
    CMP #$07                     ; if ninja
    BEQ @HiddenBoost
    RTS

   @HiddenBoost:
 ;  LDA btl_attacker_damage
 ;  LSR A                        ; divide by 2
 ;  CLC
 ;  ADC btl_attacker_damage
 ;  BCC :+
 ;      LDA #$FF                 ; cap at FF
 ;:	STA btl_attacker_damage      ; I think this should basically make the strength 50% higher, or x1.5
    LDA btl_attacker_damage
    ASL A
    BCC :+
        LDA #$FF
  : STA btl_attacker_damage

    LDA btl_attacker_attackailment
    CLC
    ADC btl_attacker_critrate
    BCC :+
        LDA #$FF                 ; cap at FF
  :	STA btl_attacker_critrate    ; Thieves get x2 CritRate
    RTS




CoverStuff:
    LDA btl_charcover, X
    BEQ @NoCover

    LDA btl_attacker
    CMP btl_charcover+4, X         ; get the knight doing the covering
    BEQ @NoCover                   ; skip if the knight is confused and doing the attacking!

    JSR PrepCharStatPointers       ; get pointer to char stats in CharBackupStatsPointer and CharStatsPointer
    LDY #ch_ailments - ch_stats
    LDA (CharStatsPointer), Y
    AND #AIL_DEAD | AIL_STOP | AIL_SLEEP
    BNE @NoCover                   ; the knight is immobile and can't help!
    LDA (CharStatsPointer), Y
    AND #AIL_STUN
    BEQ @Cover
        JSR BattleRNG_L
        AND #01
        BEQ @NoCover               ; the knight is stunned, 50/50 chance to perform action

   @Cover:
    INC attackblocked              ; set to 1
    LDA btl_defender_index         ; get the original target
    ORA #$80                       ; convert to ID
    STA btl_defender
    ;; important to note: this is used by the DefenderBox drawing thing, but not really used for players otherwise!
    ;; everything else uses btl_defender_index... so btl_defender is now the ORIGINAL target
    LDA btl_charcover+4, X         ; get the knight doing the covering
    AND #$03
    STA btl_defender_index         ; and set as the new defender

   @NoCover:
    LDA btl_defender_index
    RTS



SpiritCalculations:
    LDA battle_hitsconnected
    BEQ @Exit                   ; attack was a miss

    LDA battle_attackerisplayer
    BEQ @Decrement              ; enemy is attacker

   ; player is attacker:
    LDA battle_defenderisplayer 
    BEQ @IncreaseSpirit_Undead  ; defender is enemy
    
    JSR @SubtractSpirit         ; player vs player: subtract 1 from the defender
    LDA btl_attacker
    JSR PrepCharStatPointers
    JMP @SubtractSpirit         ; then subtract 1 from the attacker    
    
    ; enemy is attacker
   @Decrement:
    LDA battle_defenderisplayer
    BEQ @Exit                    ; enemy vs enemy; do nothing

   ; enemy vs player, so check if the player is covering someone else
    LDX btl_defender_index
    LDY #4
  : LDA btl_charcover+4, X
    CMP btl_defender
    BEQ @IncrementCover     ; found the slot where the player is set to be covering someone!
    INX                     ; so give a boost to spirit
    DEY
    BNE :-                  ; loop until all 4 slots checked

   ; player defender isn't covering anyone, but are they doing anything else?
    LDX btl_defender_index
    LDA btl_charguard, X
    ORA btl_charparry, X
    ORA btl_charpray, X
    ORA btl_charrunic, X
    ORA btl_charfocus, X
    ORA btl_charrush, X
    ORA btl_charhidden, X
    BNE @IncrementNormal
    ; if doing ANY of these, increase spirit instead!

   @SubtractSpirit:
    LDY #ch_morale - ch_stats
    LDA (CharStatsPointer), Y
    BEQ @Exit
        SEC
        SBC #1
        STA (CharStatsPointer), Y
 
   @Exit:
    RTS
   
   @IncreaseSpirit_Undead:
    LDA btl_defender_category
    AND #CATEGORY_UNDEAD
    BEQ @IncrementNormal
        LDA #3               ; 3 spirit for hitting an undead enemy
        STA tmp
        BNE @Increment
        
   @IncrementCover:
    LDA #7                   ; 7 spirit for covering an ally and being hit while doing so
    STA tmp
    BNE @Increment

   @IncrementNormal:
    LDA #1
    STA tmp
    
   @Increment:
    LDY #ch_morale - ch_stats
    LDA (CharStatsPointer), Y
    CMP #$FF
    BEQ @Exit
        CLC
        ADC tmp
        STA (CharStatsPointer), Y
    RTS    



















;; whether or not this saves space, this makes loading stats SO much easier
;; if you plan on re-arranging any variables in RAM
PlayerAttackerStats_LUT:
.byte btl_attacker_damage - btl_attacker,         ch_damage - ch_stats
.byte btl_attacker_hitrate - btl_attacker,        ch_hitrate - ch_stats
.byte btl_attacker_numhits - btl_attacker,        ch_numhits - ch_stats
.byte btl_attacker_critrate - btl_attacker,       ch_critrate - ch_stats
.byte btl_attacker_category - btl_attacker,       ch_weaponcategory - ch_stats
.byte btl_attacker_element - btl_attacker,        ch_weaponelement - ch_stats
.byte btl_attacker_attackailment - btl_attacker,  ch_attackailment - ch_stats
.byte btl_attacker_ailments - btl_attacker,       ch_ailments - ch_stats
.byte btl_attacker_class - btl_attacker,          ch_class - ch_stats
.byte btl_attacker_ailmentchance - btl_attacker,  ch_attackailproc - ch_stats

PlayerDefenderStats_LUT: 
.byte btl_defender_ailments - btl_attacker,         ch_ailments - ch_stats
.byte btl_defender_statusresist - btl_attacker,     ch_statusresist - ch_stats
.byte btl_defender_elementweakness - btl_attacker,  ch_elementweak - ch_stats
.byte btl_defender_evasion - btl_attacker,          ch_evasion - ch_stats
.byte btl_defender_defense - btl_attacker,          ch_defense - ch_stats
.byte btl_defender_class - btl_attacker,            ch_class - ch_stats 
.byte btl_defender_magicdefense - btl_attacker,     ch_magicdefense - ch_stats
.byte btl_defender_elementresist - btl_attacker,    ch_elementresist - ch_stats
.byte btl_defender_hp - btl_attacker,               ch_curhp - ch_stats
.byte btl_defender_hp+1 - btl_attacker,             ch_curhp+1 - ch_stats 

EnemyAttackerStats_LUT:
.byte btl_attacker_damage - btl_attacker,          en_strength
.byte btl_attacker_category - btl_attacker,        en_category
.byte btl_attacker_element - btl_attacker,         en_elemattack
.byte btl_attacker_hitrate - btl_attacker,         en_hitrate
.byte btl_attacker_numhitsmult - btl_attacker,     en_numhitsmult
.byte btl_attacker_numhits - btl_attacker,         en_numhits
.byte btl_attacker_critrate - btl_attacker,        en_critrate
.byte btl_attacker_ailmentchance - btl_attacker,   en_ailproc
.byte btl_attacker_attackailment - btl_attacker,   en_attackail
.byte btl_attacker_ailments - btl_attacker,        en_ailments

EnemyDefenderStats_LUT:
.byte btl_defender_ailments - btl_attacker,        en_ailments
.byte btl_defender_category - btl_attacker,        en_category
.byte btl_defender_statusresist - btl_attacker,    en_statusresist
.byte btl_defender_elementweakness - btl_attacker, en_elemweakness
.byte btl_defender_evasion - btl_attacker,         en_evade
.byte btl_defender_defense - btl_attacker,         en_defense
.byte btl_defender_hp - btl_attacker,              en_hp
.byte btl_defender_hp+1 - btl_attacker,            en_hp+1




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
    LDA BattleCharID
    ORA #$80
    STA btl_attacker

    JSR PrepCharStatPointers        ; get pointer to attacker's OB and IB stats

    LDY #ch_ailments - ch_stats
    LDA (CharStatsPointer), Y
    AND #AIL_CONF
    BEQ :+
       JSR EnemyExistLoop

  : LDA AutoTargetOption
    BNE @SkipAutoTarget

    JSR CheckTargetLoop             ; JIGS - doublecheck the enemy you're attacking exists!

   @SkipAutoTarget:
    STX btl_defender_index       ; set defender index
    STX btl_defender

    TXA
    JSR GetEnemyRAMPtr

    ;;;;;;;;;;;;;;;;;;;;;;;;
    ;; Attacker/PLAYER stats
    
    LDX #20
   @Loop: 
    LDY PlayerAttackerStats_LUT-1, X
    LDA (CharStatsPointer), Y
    DEX
    LDY PlayerAttackerStats_LUT-1, X
    STA btl_attacker, Y
    DEX
    BNE @Loop
    
    STX battle_defenderisplayer     ; clear this value to zero to indicate the defender is an enemy
    INX ;#1
    STX battle_attackerisplayer     

    LDA btl_attacker_class
    AND #$0F                        ;; cut off high bits to get class
    STA btl_attacker_class

    LDX BattleCharID
    LDA btl_charhitmult, X
    STA btl_attacker_numhitsmult

    LDA btl_charweaponsprite, X
    STA btl_attacker_graphic
    
    LDA btl_charweaponpal, X
    STA btl_attacker_varplt

    LDA btl_charrush, X
    BEQ :+
        LDA btl_attacker_hitrate
        LSR A
        LSR A
        STA btl_attacker_hitrate ; one quarter hit rate

        LDY #ch_level - ch_stats
        LDA (CharStatsPointer), Y
        ASL A
        CLC
        ADC btl_attacker_damage ; level * 2 on top of damage. That's 100 extra damage at level 50!
        STA btl_attacker_damage

        DEC btl_charrush, X

  : LDA btl_charhidden, X          ;; get hidden state
    BEQ @Defender
 
    JSR HiddenCheck ;; JIGS - this upgrades stats a bit if they're hidden.
    ;; 2x hit rate
    ;; 1.5x crit rate (2x for thief/ninja)
    ;; 2x damage for thief/ninja


    ;;;;;;;;;;;;;;;;;;;;;;;;
    ;; Defender/ENEMY stats
   @Defender:
    LDX #16
   @EnemyLoop: 
    LDY EnemyDefenderStats_LUT-1, X
    LDA (EnemyRAMPointer), Y
    DEX
    LDY EnemyDefenderStats_LUT-1, X
    STA btl_attacker, Y
    DEX
    BNE @EnemyLoop   

    STX btl_defender_class
    RTS



PlayerAttackPlayer_PhysicalZ:
    LDA BattleCharID
    ORA #$80
    STA btl_attacker
    ;; ^ this might not be necessary, as the attacker drawing box sets it when confused

   ; AND #$03
   ; JSR PrepCharStatPointers        ; this was done during confusion checks

    ;;;;;;;;;;;;;;;;;;;;;;;;
    ;; Attacker/PLAYER stats

    LDX #20
   @Loop: 
    LDY PlayerAttackerStats_LUT-1, X
    LDA (CharStatsPointer), Y
    DEX
    LDY PlayerAttackerStats_LUT-1, X
    STA btl_attacker, Y
    DEX
    BNE @Loop

    INX
    STX battle_attackerisplayer
    STX battle_defenderisplayer

    LDA btl_attacker_class
    AND #$0F                        ;; cut off high bits to get class
    STA btl_attacker_class

    LDX BattleCharID    
    LDA btl_charhitmult, X
    STA btl_attacker_numhitsmult

    LDA btl_charweaponsprite, X
    STA btl_attacker_graphic
    
    LDA btl_charweaponpal, X
    STA btl_attacker_varplt

    LDA btl_attacker_damage
    LSR A                           ;; damage for player > player is half
    STA btl_attacker_damage

    LDA btl_attacker_critrate
    LSR A                           ;; crit rate for player > player is half
    STA btl_attacker_critrate

    ;; ignore Hidden bonuses

   @FindTarget:
    JSR BattleRNG_L
    AND #$03
    STA btl_defender_index
    TAX
    ORA #$80
    STA btl_defender
    JSR PrepCharStatPointers        ; get pointer to attacker's OB and IB stats

    LDY #ch_ailments - ch_stats
    LDA (CharStatsPointer), Y
    AND #AIL_DEAD | AIL_STOP
    BNE @FindTarget
    
    JSR CoverStuff
    JMP PlayerDefenderStats


;;  input:
;;    A = defending player index
;;    X = attacking enemy slot index

 EnemyAttackPlayer_PhysicalZ:
    LDA btl_attacker
    JSR GetEnemyRAMPtr

    ;;;;;;;;;;;;;;;;;;;;;
    ; Attacker ENEMY stats
    
    LDX #20
   @Loop: 
    LDY EnemyAttackerStats_LUT-1, X
    LDA (EnemyRAMPointer), Y
    DEX
    LDY EnemyAttackerStats_LUT-1, X
    STA btl_attacker, Y
    DEX
    BNE @Loop    
    
    STX btl_attacker_class          ; enemy has no class, and also thus can't be hidden
    STX battle_attackerisplayer
    INX ;#1
    STX battle_defenderisplayer

    LDA btl_attacker_numhits
    PHA
    AND #$0F
    STA btl_attacker_numhits
    PLA 
    AND #$F0
    LSR A
    LSR A
    LSR A
    LSR A
    STA btl_attacker_limbs
    
    LDA btl_retaliate
    BEQ LoadPlayerDefenderStats_ForEnemyAttack
        LDA #1
        STA btl_attacker_limbs
    ;; if this attack is a counter attack, only do the one attack

LoadPlayerDefenderStats_ForEnemyAttack:
    LDA btl_randomplayer

    AND #$03
    STA btl_defender_index       ; record the defender index
    TAX
    ORA #$80
    STA btl_defender

    JSR CoverStuff
    
PlayerDefenderStats:
    JSR PrepCharStatPointers        ; get pointer to char stats in CharBackupStatsPointer and CharStatsPointer

    LDX #20
   @Loop: 
    LDY PlayerDefenderStats_LUT-1, X
    LDA (CharStatsPointer), Y
    DEX
    LDY PlayerDefenderStats_LUT-1, X
    STA btl_attacker, Y
    DEX
    BNE @Loop   
    
    STX btl_defender_category
    
    LDA btl_defender_class
    AND #$0F                         ;; cut off high bits to get class
    STA btl_defender_class

    LDX btl_defender_index
    LDA btl_charhidden, X
    BEQ :+
    LDA btl_defender_class
    ORA #$10
    STA btl_defender_class        ; high bit is used for player defenders in Bank C

  : LDA btl_charguard, X          ; check battlestate for Guarding
    BEQ @Done                     ; if not guarding, finish up

    LDA btl_defender_ailments
    AND #AIL_STUN
    BEQ @Guard

    JSR BattleRNG_L               ; 50/50 chance for guarding to fail
    AND #01                       ; if stunned
    BEQ @Done

    LDX btl_defender_index
    DEC btl_charguard, X

   @Guard: 
    LDY #(ch_level - ch_stats)
    LDA (CharStatsPointer), Y     ; guard defense is level * 2
    ASL A
    CLC
    ADC btl_defender_defense
    BCC :+
       LDA #$FF
  : STA btl_defender_defense

   @Done:
    RTS









Battle_SetPartyWeaponSpritePal:
    LDX #8
   @Clear: 
    STA btl_charweaponpal-1, X
    DEX
    BNE @Clear

    LDA #3
    STA char_index
   @Loop: 
    LDA char_index
    JSR ShiftLeft6
    TAX
    LDA ch_righthand, X
    BEQ @CheckForFist
    
    JSR GetWeaponDataPointer
    
    LDX char_index
    LDY #7
    LDA (tmp), Y
    STA btl_charweaponsprite, X
    INY
    LDA (tmp), Y
    STA btl_charweaponpal, X
    
   @Next:
    DEX
    BNE @Loop
    RTS
   
   @Empty:   
    LDX char_index
    LDA #$20                   ; set the palette to white/grey
    STA btl_charweaponpal, X
    BNE @Next
    
   @CheckForFist:
    LDA ch_class, X
    AND #CLS_BB | CLS_MA
    BEQ @Empty
    
    TXA
    TAY
    LDX char_index
    LDA #$AC
    STA btl_charweaponsprite, X
    LDA ch_class, Y
    AND #$F0
    LSR A
    LSR A
    LSR A
    LSR A
    TAY
    LDA lut_InBattleCharPaletteAssign, Y
    STA btl_charweaponsprite, X
    JMP @Next

lut_InBattleCharPaletteAssign:
  .BYTE $21 ; Fighter
  .BYTE $22 ; Thief
  .BYTE $20 ; BBelt
  .BYTE $21 ; RMage
  .BYTE $21 ; WMage
  .BYTE $20 ; BMage
  .BYTE $21 ; 
  .BYTE $22 ; 
  .BYTE $20 ; 
  .BYTE $21 ; 
  .BYTE $21 ; 
  .BYTE $20 ; 



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
    JSR GetWeaponDataPointer

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

  @SpecialWeapons:
    LDA ch_righthand, X
    CMP #CHICKEN_KNIFE+1
    BEQ @Restore
    CMP #BRAVE_BLADE+1
    BNE @Done

  @Restore:
    LDA ch_damagebackup, X
    STA ch_damage, X

   @Done:
    LDA ch_damage, X       ; get char's dmg
    SEC
    SBC (tmp), Y           ; subtract weapon's damage bonus
    STA ch_damage, X       ; and write back

    LDA #00               ;; JIGS - clear these out
    STA ch_critrate, X
    STA ch_weaponelement, X
    STA ch_weaponcategory, X
    STA ch_attackailment, X
    STA ch_attackailproc, X

   ; LDA #$01
   ; STA ch_numhitsmult, X ;; JIGS - this is always 1, weapon equipped or not.

    ;LDX equipmenu_tmp   ; restore X to the equipment source index
    RTS

  @AdjustArmor:
    JSR GetPointerToArmorData

    ;LDX tmp+7           ; get char index in X
    ;LDY #0              ; zero our source index Y

    LDA ch_evasion, X   ; get character's evade
    CLC
    ADC (tmp), Y        ; add the armor's evade penalty rate (removing the penalty)
    STA ch_evasion, X   ; and write back

    INY                 ; skip over absorb--it just gets set to 0 since we're removing all armour
    INY                 ; Y now points to magic defense
    LDA ch_magicdefense, X
    CLC
    ADC (tmp), Y
    STA ch_magicdefense, X

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
    STA ch_statusresist, X
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
    JSR GetWeaponDataPointer ; this sets Y to 0

    LDA ch_hitrate, X      ; get char's hit rate
    CLC
    ADC (tmp), Y           ; add to it the weapon's hit bonus
    BCC :+
        LDA #$FF           ; cap at 255
  : STA ch_hitrate, X      ; and write it back

    INY                    ; inc source index

    LDA ch_damage, X       ; get char's damage
    CLC
    ADC (tmp), Y           ; add weapon's damage bonus
    BCC :+
        LDA #$FF           ; cap at 255

  : STA ch_damage, X       ; and write back

    ;; JIGS - and do other battle stat prepping here

    INY
    LDA (tmp), Y
    STA ch_critrate, X
    INY
    LDA (tmp), Y
    STA ch_attackailment, X
    INY
    LDA (tmp), Y
    STA ch_attackailproc, X
    INY
    LDA (tmp), Y
    STA ch_weaponelement, X
    INY
    LDA (tmp), Y
    STA ch_weaponcategory, X

  @SpecialWeapons:
    LDA ch_righthand, X
    CMP #CHICKEN_KNIFE+1
    BEQ @ChickenKnife
    CMP #BRAVE_BLADE+1
    BNE @Done

  @BraveBlade:
    LDA ch_damage, X
    STA ch_damagebackup, X
    LDA battleswon
    JMP :+

  @ChickenKnife:
    LDA ch_damage, X
    STA ch_damagebackup, X
    LDA battlesrun
  : STA ch_damage, X

  @Done:
    RTS

  @AdjustArmor:            ; A = armor_id * 4
    JSR GetPointerToArmorData

    LDA ch_evasion, X      ; get char's evade
    SEC
    SBC (tmp), Y           ; subtract armor evade penalty
    BCS :+
      LDA #0               ; cap at 0 evasion
  : STA ch_evasion, X      ; and write it back

    INY                    ; inc source index
    LDA ch_defense, X      ; get absorb
    CLC
    ADC (tmp), Y           ; add absorb bonus
    BCC :+
      LDA #$FF             ; cap at 255
  : STA ch_defense, X      ; and write back

    INY
    LDA ch_magicdefense, X
    CLC
    ADC (tmp), Y
    BCC :+
      LDA #$FF             ; cap at 255
  : STA ch_magicdefense, X

    INY                     ; inc source index
    LDA ch_elementresist, X ; get elemental resistence
    ORA (tmp), Y            ; combine this armor's elemental resistence
    STA ch_elementresist, X ; and write back

    INY
    LDA ch_elementweak, X   ; get elemental weakness
    ORA (tmp), Y            ; combine this armor's elemental weakness
    STA ch_elementweak, X   ; and write back

    INY
    LDA ch_statusresist, X
    ORA (tmp), Y
    STA ch_statusresist, X
    RTS


GetWeaponDataPointer:
   ; SEC
   ; SBC #$01               ; subtract 1 from the equip ID (equipment is 1 based -- 0 is an empty slot)
    TAY                    ; save A
    DEY                    ; NOW subtract 1 from the Equip ID!
    TXA                    ; then push X to stack
    PHA
    TYA                    ; restore A
    LDX #9
    JSR MultiplyXA
    ; I think nomally we'd add the low byte of the pointer, but since the weapon data is
    ; at the very start of the bank, we'd just be adding 0.
    CLC
    ;ADC #<lut_WeaponData

    STA tmp                ; put in tmp as low byte of our pointer
    TXA
    ADC #>lut_WeaponData   ; add high byte of our pointer
    STA tmp+1              ; fill tmp+1 to complete our pointer
    PLA
    TAX                    ; then restore X
    LDY #0                 ; and set Y to 0 for later
    RTS

GetPointerToArmorData:
    SEC
    SBC #ARMORSTART+1
    TAY                    ; save A
    TXA                    ; then push X to stack
    PHA
    TYA                    ; restore A
    LDX #6
    JSR MultiplyXA
    CLC
    ADC #<lut_ArmorData    ; add low byte of our pointer
    STA tmp                ; put in tmp as low byte of our pointer
    TXA
    ADC #>lut_ArmorData    ; add high byte of our pointer
    STA tmp+1              ; fill tmp+1 to complete our pointer
    PLA
    TAX                    ; then restore X
    LDY #0                 ; and set Y to 0 for later
    RTS


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

  ;  LDA #$01                  ; always 1 until a spell changes it
  ;  STA ch_numhitsmult, X

    LDA ch_class, X    ; get this char's class
    AND #$0F             ;; JIGS - cut off high bits (sprite)

    CMP #CLS_BB        ; see if he's a black belt or master... if yes, jump ahead
    BEQ @BlackBelt     ; otherwise, exit
    CMP #CLS_MA
    BNE @Exit

  @BlackBelt:
    LDA ch_righthand, X
    BEQ @NoWeaponEquipped     ; if zero, we know this BB has no weapon equipped

  @WeaponEquipped:
    LDA ch_strength, X        ; if a weapon is equipped... get strength stat
    LSR A                     ;  /2
    ;CLC ;; JIGS  - fixes rounding error, if its a bug?
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





WeaponArmorShopStats:
    LDA #$FF
    LDX #12
  : STA bigstr_buf-1, X
    DEX
    BNE :-

    STX bigstr_buf+11 ; null-terminate main string

    LDA #$01
    STA bigstr_buf+3 ; put line break in
    STA bigstr_buf+7

    LDA #14
    STA dest_x
    LDA #20
    STA dest_y

    LDA shop_curitem
    CMP #ARMORSTART+1
    BCS @Armor

   @Weapon:
    TAX
    JSR GetWeaponDataPointer   ; Y = 0, also preserves X

    LDA (tmp), Y ; Hit Rate
    STA bigstr_buf+16
    INY
    LDA (tmp), Y ; Damage
    CPX #CHICKEN_KNIFE+1
    BNE :+
        LDA battlesrun
        BNE @SaveWeaponDamage

  : CPX #BRAVE_BLADE+1
    BNE @SaveWeaponDamage

    LDA battleswon

   @SaveWeaponDamage:
    STA bigstr_buf+12            ; space stats 3 bytes apart
    INY
    LDA (tmp), Y ; Critical
    STA bigstr_buf+20
    RTS

   @Armor:
   ; CLC
   ; ADC #1 ; the following JSR subtracts +1 too many, but needs to stay doing that for other routines
    JSR GetPointerToArmorData

    LDA (tmp), Y ; Evade penalty
    STA bigstr_buf+16
    INY
    LDA (tmp), Y ; Absorb
    STA bigstr_buf+12
    INY
    LDA (tmp), Y ; Magic Defense
    STA bigstr_buf+20
    RTS



M_EquipDescBox_Weapon:
.byte $8A,$61,$34,$B1,$B7,$E4,$FE,$01     ; Ailment:
.byte $8E,$45,$34,$B1,$B7,$E4,$FE,$01     ; Element:
.byte $9C,$B3,$A8,$4E,$E4,$FF,$FF,$FE     ; Spell:__

M_EquipDescBox_Armor:
.byte $99,$4D,$53,$A6,$B7,$E4,$FE,$01     ; Protect:
.byte $8E,$45,$34,$B1,$B7,$E4,$FE,$01     ; Element:
.byte $9C,$B3,$A8,$4E,$E4,$FF,$FF,$FE     ; Spell:__

SillyWeaponArmorSpecialDesc_LUT:
    .word M_EquipDescBox_Weapon
    .word M_EquipDescBox_Armor

WeaponArmorSpecialDesc:
    LDA #23
    STA dest_y
    LDA #03
    STA dest_x

    LDX ItemToEquip
    BNE :+
      RTS            ; save time and just return

  : DEX
    STX tmp+10
    CPX #ARMORSTART
    BCS @Armor

   @Weapon:
    LDX #0
    BEQ :+

   @Armor:
    LDX #2
  : LDA SillyWeaponArmorSpecialDesc_LUT, X
    STA text_ptr
    LDA SillyWeaponArmorSpecialDesc_LUT+1, X   ; load pointer from table, store to text_ptr  (source pointer for DrawComplexString)
    STA text_ptr+1

    LDY #0
    LDX #0
   @Loop:
    LDA (text_ptr), Y
    CMP #$FE
    BEQ @FillSpaces
    STA str_buf+$80, X
    INX
   @Resume:
    INY
    CPY #$18
    BNE @Loop
    BEQ @SortOutBytes

   @FillSpaces:
    STY tmp
    LDY #18
    LDA #$FF
  : STA str_buf+$80, X
    INX
    DEY
    BNE :-
    LDY tmp
    JMP @Resume

   @SortOutBytes:
    LDA ItemToEquip
    CMP #ARMORSTART+1
    BCS @ArmorBytes

   @WeaponBytes:
    JSR GetWeaponDataPointer
    JMP :+

   @ArmorBytes:
    JSR GetPointerToArmorData
  : LDY #3
    LDA (tmp), Y ; Ailment to inflict (weapon) / Element resisted (armor)
    STA tmp+11
    INY
    INY
    LDA (tmp), Y ; Element to attack with (weapon) / Status defended against (armor)
    STA tmp+12

    LDA ItemToEquip
    CMP #ARMORSTART+1
    BCC :+

   @FixArmorBytes:
    LDX tmp+12
    LDY tmp+11
    STX tmp+11
    STY tmp+12

  : JSR GetEquipmentSpell
    BEQ @NoSpell

    STA str_buf+$BB   ; spell ID
    LDA #$02
    STA str_buf+$BA   ; control code for item name, before spell ID
    LDA #$0A
    STA str_buf+$BD   ; amount of spaces after spell
    BNE @FinishUp

   @NoSpell:
    LDA #$02
    STA str_buf+$BD   ; amount of spaces after "no spell"
    LDA #$06
    STA str_buf+$BA   ; control code for common string
    LDA #$1D
    STA str_buf+$BB   ; followed by the string for "no spell"

   @FinishUp:
    LDA #$09
    STA str_buf+$BC   ; next byte is # of spaces
    LDA #0
    STA str_buf+$BE   ; terminate the string properly
    STA joy_start     ; and zero this for the next loop of the screen!
    STA tmp+13
    LDA #1
    STA menustall     ; and set this to draw with the screen on

    ;; str_buf+$80 is 26 tiles wide each row, with +1 for the line breaks
    ;; three rows for 81 total. Spell names are 7 tiles.
    ;; all spaces must be preserved to overwrite common equipment stats!
    ;; But with the spell name decompressed, that's 7 spaces too many...

    ;; visually, it should look like this, if there is a spell:
    ;; Ailment:_*_*_*_*_*_*_*_*__ 01
    ;; Element:_*_*_*_*_*_*_*_*__ 01
    ;; Spell:___XXXXXXX__________ 00
    ;; it may look messier in RAM.
    ;; Spell: FF FF FF 02 XX 09 09 00

    ;; now to convert the bits in the other two stats into tiles!

    LDA tmp+11 ; start with ailment
    LDX #$07   ; how far into the string to print the icons
    LDY #$F1   ; tile for fancy tiny X to indicate nothing in that slot

   @UnrollStatByte:
    LSR A
    BCC :+
      LDY #$E9 ; death
  : JSR @PrintIcon
    LSR A
    BCC :+
      LDY #$ED ; stone
  : JSR @PrintIcon
    LSR A
    BCC :+
      LDY #$EB ; poison
  : JSR @PrintIcon
    LSR A
    BCC :+
      LDY #$EC ; darkness
  : JSR @PrintIcon
    LSR A
    BCC :+
      LDY #$75 ; sleep
  : JSR @PrintIcon
    LSR A
    BCC :+
      LDY #$71 ; stun
  : JSR @PrintIcon
    LSR A
    BCC :+
      LDY #$76 ; mute
  : JSR @PrintIcon
    LSR A
    BCC :+
      LDY #$70 ; confusion
  : JSR @PrintIcon

  ;; and then the element icon
    LDA tmp+12
    LDX #$20

  @UnrollElementByte:
    LSR A
    BCC :+
      LDY #$70 ; status element
  : JSR @PrintIcon
    LSR A
    BCC :+
      LDY #$71 ; stun element
  : JSR @PrintIcon
    LSR A
    BCC :+
      LDY #$EB ; poison element
  : JSR @PrintIcon
    LSR A
    BCC :+
      LDY #$E9 ; death element
  : JSR @PrintIcon
    LSR A
    BCC :+
      LDY #$72 ; fire element
  : JSR @PrintIcon
    LSR A
    BCC :+
      LDY #$73 ; ice element
  : JSR @PrintIcon
    LSR A
    BCC :+
      LDY #$74 ; lightning element
  : JSR @PrintIcon
    LSR A
    BCC :+
      LDY #$ED ; earth element
  : JSR @PrintIcon

    LDA #<(str_buf+$80)
    STA text_ptr
    LDA #>(str_buf+$80)
    STA text_ptr+1
    RTS

   ;; string should be ready to go; jump back and print it!

   @PrintIcon:
    PHA
    TYA
    STA str_buf+$80, X
    INX
    INX ; add spaces between icons
    LDY #$F1
    PLA
    RTS







;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Assign Map Tile Damage [$C861 :: 0x3C871]
;;
;;    Deals 1 damage to all party members (for standard map damaging tiles
;;  -- Frost/Lava).
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


AssignMapTileDamage_Z:
    LDX #$00              ; zero loop counter and char index

  @Loop:
    LDA ch_curhp+1, X     ; check high byte of HP
    BNE @DmgSubtract      ; if nonzero (> 255 HP), deal this guy damage

    LDA ch_curhp, X       ; otherwise, check low byte
    CMP #2                ; if < 2, skip damage (don't take away their last HP)
    BCC @DmgSkip

  @DmgSubtract:
    LDA ch_curhp, X       ; subtract 1 HP
    SEC
    SBC #1
    STA ch_curhp, X
    LDA ch_curhp+1, X
    SBC #0
    STA ch_curhp+1, X

  @DmgSkip:
    TXA                   ; add $40 to char index (next character in party)
    CLC
    ADC #$40
    TAX

    BNE @Loop             ; loop until it wraps (4 iterations)
    LDA cur_bank
    RTS                   ; then exit




MapPoisonDamage_Z:
    LDA #1
    LDX #5
    JSR RandAX     ; get between 1-5 damage to deal out
    STA tmp+1

    LDY #0         ; X will be our loop counter and char index
  @DmgLoop:
    LDA ch_ailments, Y    ; get this character's ailments
    AND #AIL_POISON       ; see if they're poisoned
    BEQ @DmgSkip          ; if not... skip this character
    
    LDA tmp+1
    STA tmp

    LDA ch_curhp+1, Y     ; check high byte of HP
    BNE @DmgSubtract      ; if nonzero (> 255 HP), deal this character damage

    LDA ch_curhp, Y
    CMP #1                ; skip if their HP is only 1  
    BEQ @DmgSkip

  @FindNewDamage:
    LDA tmp               ; otherwise, check low byte of HP
    CMP ch_curhp, Y       ; see if they have as much HP as there is damage 
    BCC @DmgSubtract      ; C set if they will die from it, so skip 
    
    DEC tmp
    JMP @FindNewDamage

  @DmgSubtract:
    LDA ch_curhp, Y       ; subtract 1 from HP
    SEC
    SBC tmp
    STA ch_curhp, Y
    LDA ch_curhp+1, Y
    SBC #0
    STA ch_curhp+1, Y

  @DmgSkip:
    TYA                   ; add $40 char index
    CLC
    ADC #$40
    TAY
    BNE @DmgLoop          ; and loop until it wraps (4 iterations)
    
   @Random:               ; then figure out how many steps until the next poison
    LDA #4
    LDX #8
    JSR RandAX
    STA domappoison
    LDA #$1E
    STA btl_soft2001      ; and remove red emphasis (reset soft2001 to normal use)
    LDA cur_bank
    RTS  












  lut_IntroStoryText:

;; JIGS - the original used DTE, which my routine can not... so I did my best to re-make it with some fancy tweaks.
;; Since every letter is a sprite as well, we can't use control codes. So the routine uses $78 (sprite the same colour as the background)
;; and reads them as double line breaks.
;; The screen is 32 tiles wide, so...
     ; 1,  2,  3,  4,  5,  6,  7,  8,  9,  10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32

.byte $FF,$FF,$FF,$FF,$9D,$AB,$A8,$FF,$BA,$B2,$B5,$AF,$A7,$FF,$AC,$B6,$FF,$B9,$A8,$AC,$AF,$A8,$A7,$FF,$AC,$B1,$78
.byte $FF,$FF,$A7,$A4,$B5,$AE,$B1,$A8,$B6,$B6,$C0,$FF,$FF,$9D,$AB,$A8,$FF,$BA,$AC,$B1,$A7,$FF,$B6,$B7,$B2,$B3,$B6,$BF,$78
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$B7,$AB,$A8,$FF,$B6,$A8,$A4,$FF,$AC,$B6,$FF,$BA,$AC,$AF,$A7,$BF,$78
.byte $FF,$A4,$B1,$A7,$FF,$B7,$AB,$A8,$FF,$A8,$A4,$B5,$B7,$AB,$FF,$A5,$A8,$AA,$AC,$B1,$B6,$FF,$B7,$B2,$FF,$B5,$B2,$B7,$C0,$78
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$9D,$AB,$A8,$FF,$B3,$A8,$B2,$B3,$AF,$A8,$FF,$BA,$A4,$AC,$B7,$BF,$FF,$78
.byte $B7,$AB,$A8,$AC,$B5,$FF,$B2,$B1,$AF,$BC,$FF,$AB,$B2,$B3,$A8,$BF,$FF,$A4,$FF,$B3,$B5,$B2,$B3,$AB,$A8,$A6,$BC,$C3,$C0,$78,$78
.byte $C6,$A0,$AB,$A8,$B1,$FF,$B7,$AB,$A8,$FF,$BA,$B2,$B5,$AF,$A7,$FF,$AC,$B6,$FF,$AC,$B1,$FF,$A7,$A4,$B5,$AE,$B1,$A8,$B6,$B6,$78
.byte $FF,$FF,$FF,$8F,$B2,$B8,$B5,$FF,$A0,$A4,$B5,$B5,$AC,$B2,$B5,$B6,$FF,$BA,$AC,$AF,$AF,$FF,$A6,$B2,$B0,$A8,$C3,$79,$78,$78
.byte $FF,$FF,$FF,$FF,$FF,$8A,$A9,$B7,$A8,$B5,$FF,$A4,$FF,$AF,$B2,$B1,$AA,$FF,$AD,$B2,$B8,$B5,$B1,$A8,$BC,$BF,$78
.byte $FF,$FF,$A9,$B2,$B8,$B5,$FF,$BC,$B2,$B8,$B1,$AA,$FF,$BA,$A4,$B5,$B5,$AC,$B2,$B5,$B6,$FF,$A4,$B5,$B5,$AC,$B9,$A8,$BF,$78
.byte $FF,$FF,$FF,$FF,$FF,$A8,$A4,$A6,$AB,$FF,$AB,$B2,$AF,$A7,$AC,$B1,$AA,$FF,$A4,$B1,$FF,$98,$9B,$8B,$C0,$00
;; It's the intro text... I'm not gonna spell it out here. :I I just made some edits to spiff it up a bit. Some spaces here, a better ... there, added in a proper ` for the quotation part...


JigsIntro:
    ;; some prep work done in LoadShopCHRForBank_Z in Bank $04 -- turns off screen, sets soft2000, and loads Shop graphics (intro sprites as well)
    ;; The shop graphics have the extra .' tile this screen uses, as well as loading the menu text.
    JSR LongCall
    .word LoadShopCHRForBank_Z
    .byte BANK_MENUCHR

    LDA #$FF
    STA MMC5_tmp
    JSR ClearNT_Color
    JSR ClearButtons
    STA cursor
    STA joy_prevdir        ; as well as resetting the cursor and previous joy direction

    LDA $2002           ; reset PPU toggle and set PPU address to $2000
    LDA #>$23C0         ;   (start of nametable)
    STA $2006
    LDA #<$23C0
    STA $2006

    LDX #$40            ; Next, fill the attribute table so that all tiles use
    LDA #$00            ;  palette 0.
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

    LDA #$0D ; 09                ; starting sprite coordinates
    STA spr_x
    LDA #$14 ; 10
    STA spr_y

    LDX #2                  ; Text coordinates
    STX dest_y
    DEX ; #1
    STX dest_x

    JSR TurnMenuScreenOn_ClearOAM

IntroLoop:
    LDA #4
    STA tmp+6

   @loop:
    JSR NextLetter           ; gets the next tile to print, set it up in OAM, updates the sprite palette
    JSR TurnOnScreen         ; does all the frame work! Loads the new palette, updates sprites, sets scroll, does music...

    DEC tmp+6
    BNE @loop
    ;; Do 4 frames, then...

    JSR UpdateJoy         ; Update joypad data
    LDA joy
    AND #BTN_START        ; see if start was pressed
    BEQ :+                ; if not, skip ahead.
        LDA #0
        STA $2001              ; turn off the PPU
        STA joy_a              ; clear A, B, Start button catchers
        STA joy_b
        STA joy_start
        STA cursor
        STA joy_prevdir        ; as well as resetting the cursor and previous joy direction
        JMP GameStart2

  : JSR IntroStoryText
    JMP IntroLoop


NextLetter:
    LDX sprindex     ; get the sprite index in X
    LDY #0
    LDA (text_ptr), Y
    STA oam+$1, X    ; write it to oam

    DEC spr_y        ; DEC the coordinates every frame to give it that "popping out" effect
    LDA spr_y
    STA oam+$0, X    ;  set Y coords
    DEC spr_x
    LDA spr_x
    STA oam+$3, X    ;  set X coords

    LDA #$04
    STA oam+$2, X    ; write to oam
    ;; flow into

IntroSpritePalette:
    LDA tmp+6
    CMP #03         ; on frame 1 and 2 (loop counter = 4 or 3), do dark
    BCS @Darkest

   @Darker:          ; on frame 3 and 4 (loop counter = 2 or 1), do light
    LDA #$21
    STA cur_pal+19
    RTS

   @Darkest:
    LDA #$11
    STA cur_pal+19
    RTS


IntroStoryText:
    LDA #1
    STA menustall         ; enable to write while PPU is on?
    JSR CoordToNTAddr
    JSR MenuCondStall

   @Draw:
    LDY #0            ; zero Y -- we don't want to use it as an index.  Rather, the pointer is updated
    LDA (text_ptr), Y ;   after each fetch
    BEQ @Finish       ; if the character is 0  (null terminator), exit the routine

    INC text_ptr      ; otherwise, inc source pointer
    BNE :+
      INC text_ptr+1  ;   inc high byte if low byte wrapped

:   CMP #$78
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
    LDA spr_y
    CLC
    ADC #$14 ; 10
    STA spr_y         ; update sprite Y coordinates to next line
    LDA #$0D ; 9
    STA spr_x         ; and reset sprite X
    JMP @Finish

   @DrawText_Exit:
    INC dest_x
    INC MMC5_tmp+7

    LDA spr_y
    CLC
    ADC #$4
    STA spr_y

    LDA spr_x
    CLC
    ADC #$0C ; 08
    STA spr_x

   @Finish:
    LDA #$00          ; reset scroll to 0
    STA $2005
    STA $2005
    RTS


ClearButtons:
    LDA #0
    STA joy_a              ; clear A, B, Start button catchers
    STA joy_b
    STA joy_start
    STA joy_select
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



EnterTitleScreen:
    LDA #$08               ; set soft2000 so that sprites use right pattern
    STA soft2000           ;   table while BG uses left

    JSR ClearButtons       ; resets all buttons and A = 0
    STA $2001              ; turn off the PPU
    STA cursor
    STA joy_prevdir        ; as well as resetting the cursor and previous joy direction

    JSR LongCall
    .word IntroTitlePrepare
    .byte BANK_MENUS
    ;; Draw the bridge scene, and load sprite palettes

    JSR LongCall
    .word Bridge_LoadPalette
    .byte BANK_BRIDGESCENE
    ;; and load the palette

    JSR LongCall
    .word LoadCursorOnly
    .byte BANK_MENUCHR

    JSR DrawTitleWords
    JSR TurnMenuScreenOn_ClearOAM

    LDA #3
    STA cursor_max

   @Loop:
    JSR ClearOAM
    JSR DrawTitleCursor
    JSR WaitForVBlank_L
    LDA #>oam
    STA $4014
    LDA #0
    STA $2005
    STA $2005

    LDA #BANK_THIS
    STA cur_bank
    JSR CallMusicPlay

    JSR UpdateJoy
    LDA joy_a
    ORA joy_start
    BNE @OptionChosen

    LDA joy
    AND #$0C          ; isolate Up/down directions
    CMP joy_prevdir   ; if its the same as last frame, do nothing
    BEQ @Loop

    STA joy_prevdir   ; save the new direction press
    CMP #0            ; see if the change was buttons being pressed or lifted
    BEQ @Loop         ; if buttons were being lifted, do nothing (keep looping)

    CMP #$04          ; see if it was down
    BNE @Up

   @Down:
    INC cursor
    LDA cursor
    CMP cursor_max
    BCC @MoveOK
    LDA #0
    BEQ @MoveOK

   @Up:
    DEC cursor
    LDA cursor
    BPL @MoveOK
    LDX cursor_max
    DEX
    TXA             ; A = 1 less than cursor_max

   @MoveOK:
    STA cursor
    JSR PlaySFX_MenuMove
    JMP @Loop

   @OptionChosen:
    LDA cursor
    CMP #2
    BEQ @OptionsMenu
    CMP #1           ; this will set C, indicating new game or continue
    RTS              ; then return to the GameStart stuff to decide what to load next

   @OptionsMenu:
    LDA #0
    STA $2001                         ; turn off the screen and menustall
    STA menustall
    LDX BattleBGColor                 ; Options screen uses the battle BG color (so you can see what you're choosing!)
    LDA BattleBackgroundColor_LUT, X
    STA cur_pal+14
    JSR ClearNT_FillBackground        ; Clear and fill the background with a tile other than $00
    JSR OptionsMenu                   ; Do the options menu!
    JMP EnterTitleScreen              ; and re-draw the Title screen


DrawTitleCursor:
    LDY cursor                   ; put the cursor in Y
    LDA lut_TitleCursor_Y, Y     ; get the Y position
    STA spr_y
    LDA #$38                     ; X position is always the same
    STA spr_x
    JMP DrawCursor               ; draw it!  and exit

lut_TitleCursor_Y:
   .BYTE $38,$48,$58







;; This is for the Options menu on the title mostly.
;; Because it doesn't need to reset the Bridge Scene graphics, and tile $00 is a piece of hillside for some reason.
ClearNT_FillBackground:
    LDA #$7E
    STA MMC5_tmp
    BNE ClearNT_Color

ClearNT:
    LDA #$00
    STA MMC5_tmp

ClearNT_Color:
    LDA $2002     ; reset PPU toggle
    LDA #$20
    STA $2006
    LDA #$00
    STA $2006     ; set PPU addr to $2000 (start of NT)
    LDA MMC5_tmp
    LDX #$F0      ; $03C0 / 4 = $F0.
    LDY #$40

@Loop:            ; first loop clears the first $0300 bytes of the NT
      STA $2007
      STA $2007
      STA $2007
      STA $2007
      DEX          ;  decrement X
      BNE @Loop    ;  and stop looping once X expires

    LDA #$FF      ; A=FF (this is what we will fill attribute table with
@Loop2:           ;  2nd loop fills the last $40 bytes (attribute table) with FF
      STA $2007
      DEY
      BNE @Loop2
    RTS






DrawTitleWords:
    LDX #0
    JSR @DrawString
    ; JSR to the @DrawString to draw the first one, then just let code flow into it to draw a second one
    JSR @DrawString
    ;; JIGS -- draw 1 more, 3 in total. Added some stuff below.

  @DrawString:
    LDA @lut_TitleText+1, X ; get the Target PPU address from the LUT
    STA $2006
    LDA @lut_TitleText, X
    STA $2006
    INX                     ; move X past the address we just read
    INX

  @Loop:
    LDA @lut_TitleText, X   ; get the next character in the string
    BEQ @Exit               ;  if it's zero, exit (null terminator
    STA $2007               ; otherwise, draw the character
    INX                     ; INX to move to next character
    BNE @Loop               ; and keep looping (always branches)

  @Exit:
    INX                     ; INX to move X past the null terminator we just read
    RTS

 ;; LUT for the copyright text.  Simply a 2-byte target PPU address, followed by a
 ;;  null terminated string.  Two strings total.

@lut_TitleText:
   .WORD $20E9
   .BYTE $8C,$98,$97,$9D,$92,$97,$9E,$8E,$00 ; CONTINUE
   .WORD $2129
   .BYTE $97,$8E,$A0,$FF,$90,$8A,$96,$8E,$00 ; NEW GAME
   .WORD $2169
   .BYTE $98,$99,$9D,$92,$98,$97,$9C,$00     ; OPTIONS
   ;.WORD $2328
   ;.BYTE $8C,$FF,$81,$89,$88,$87,$FF,$9C,$9A,$9E,$8A,$9B,$8E,$00  ; "C 1987 SQUARE  "
   ;.WORD $2348
   ;.BYTE $8C,$FF,$81,$89,$89,$80,$FF,$97,$92,$97,$9D,$8E,$97,$8D,$98,$00  ; "C 1990 NINTENDO"

   ;; JIGS - using the bridge scene, it already has this info.






;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  NewGamePartyGeneration  [$9C54 :: 0x39C64]
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

ReturnToTitle:
    PLA
    PLA ; remove the "JSR NewGamePartyGeneration" bit from the stack?
    JMP CancelNewGame
    ;; JIGS - hope this works!

NewGamePartyGeneration:
    LDA #$00                ; turn off the PPU
    STA $2001

    JSR LoadMenuCHRPal_Z
    ;; This loads up the menu text, as well as each class's sprites -- even the job changes!
    
    LDA #$17
    STA $2006
    LDA #$EE
    STA $2006
    LDA #$7F
    STA $2007
    ;; this will draw a _ on a blank tile, for the blinker

    LDX #$4B        ; Initialize the ptygen buffer!
    ;;  JIGS - bigger buffer! Buff buffer.
    : LDA lut_PtyGenBuf, X  ;  all $40 bytes!  ($10 bytes per character)
      STA ptygen, X
      DEX
      BPL :-

  @Char_0:                      ; To Character generation for each of the 4 characters
    LDA #$00                    ;   branching back to the previous char if the user
    STA char_index              ;   cancelled by pressing B
    JSR DoPartyGen_OnCharacter
    BCS ReturnToTitle
    ;; JIGS ^ if you accidentally clicked new game...
  @Char_1:
    LDA #$13  ;; JIGS - every character has 3 more bytes in ptygen now
    STA char_index
    JSR DoPartyGen_OnCharacter
    BCS @Char_0
  @Char_2:
    LDA #$26
    STA char_index
    JSR DoPartyGen_OnCharacter
    BCS @Char_1
  @Char_3:
    LDA #$39
    STA char_index
    JSR DoPartyGen_OnCharacter
    BCS @Char_2


    ; Once all 4 characters have been generated and named...
    JSR PtyGen_DrawScreen       ; Draw the screen one more time
    JSR ClearOAM                ; Clear OAM
    JSR PtyGen_DrawChars        ; Redraw char sprites
    JSR WaitForVBlank_L         ; Do a frame
    LDA #>oam                   ;   with a proper OAM update
    STA $4014

    JSR MenuWaitForBtn_SFX      ; Wait for the user to press A (or B) again, to
    LDA joy                     ;  confirm their party decisions.
    AND #$40
    BNE @Char_3                 ; If they pressed B, jump back to Char 3 generation

    ;;  Otherwise, they've pressed A!  Party confirmed!
    LDA #$00
    STA $2001                   ; shut the PPU off

    LDX #$00                    ; Move class and name selection
    JSR @RecordClassAndName     ;  out of the ptygen buffer and into the actual character stats
    LDX #$13
    JSR @RecordClassAndName
    LDX #$26
    JSR @RecordClassAndName
    LDX #$39

  @RecordClassAndName:
    TXA                     ; X is the ptygen source index  ($10 bytes per character)

  ;; JIGS - X needs to be 0, 13, 26, and 39
  ;;        Y needs to be 0, 10, 20, and 30, ASL A'd twice
    AND #$F0                ; - so cut off low byte!

    ASL A
    ASL A
    TAY                     ; Y is the ch_stats dest index  ($40 bytes per character)

    LDA ptygen_sprite, X ; get sprite
    ASL A                ; shift the low bits into the high bits
    ASL A
    ASL A
    ASL A
    ORA ptygen_class, X  ; combine with class bits
    STA ch_class, Y      ; and save!

    LDA #7
    STA tmp

   @NameLoop:
    LDA ptygen_name, X ; then save name!
    STA ch_name, Y
    INY
    INX
    DEC tmp
    BNE @NameLoop

    LDA #0
    STA playtimer
    STA playtimer+1
    STA playtimer+2
    STA playtimer+3   ; and reset the timer to 0
    RTS



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  PtyGen_DrawScreen  [$9CF8 :: 0x39D08]
;;
;;    Prepares and draws the Party Generation screen
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

PtyGen_DrawScreen:
    LDA #$08
    STA soft2000          ; set BG/Spr pattern table assignments
    JSR ClearButtons      ; A = 0
    STA cursor
    STA joy_prevdir       ; as well as resetting the cursor and previous joy direction
    STA $2001             ; turn off PPU

    JSR ClearNT ;_FillBackground      ; Fill the background with colour instead of boxes
    JSR PtyGen_DrawBoxes
    JSR PtyGen_DrawText
    JMP TurnMenuScreenOn_ClearOAM


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  DoPartyGen_OnCharacter  [$9D15 :: 0x39D25]
;;
;;    Does character selection and name input for one character.
;;
;;  input:      ptygen = should be filled appropriately
;;          char_index = $00, 10, 20, 30 to indicate which character's name we're setting
;;
;;  output:    C is cleared if the user confirmed/named their character
;;             C is set if the user pressed B to cancel/go back
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

DoPartyGen_OnCharacter:
    JSR PtyGen_DrawScreen           ; Draw the Party generation screen

    ; Then enter the main logic loop
  @MainLoop:
    JSR PtyGen_Frame              ; Do a frame and update joypad input
    LDA joy_a
    BNE DoNameInput               ; if A was pressed, do name input
    LDA joy_b
    BEQ :+
      ; if B pressed -- just SEC and exit
      SEC
      RTS

    ; Code reaches here if A/B were not pressed
  : LDA joy
    AND #$0F
    CMP joy_prevdir
    BEQ @MainLoop             ; if there was no change in directional input, loop to another frame

    STA joy_prevdir           ; otherwise, record new directional input as prevdir
    CMP #$00                  ; if directional input released (rather than pressed)
    BEQ @MainLoop             ;   loop to another frame.

    ;; JIGS-- Left/Right now change the class, Up/Down change the sprite.
    CMP #$02  ; if left is pressed
      BEQ @ReverseCharThing
    CMP #$04  ; or if down is pressed
      BEQ @CharSpriteThing
    CMP #$08  ; or if up is pressed
      BEQ @ReverseCharSpriteThing


   ; Otherwise, if any direction was pressed:
    LDX char_index
    CLC
    LDA ptygen_class, X       ; Add 1 to the class ID of the current character.
    ADC #1
    CMP #6                    ; JIGS - change this to 12 for all classes
    BCC :+
      LDA #0                  ; wrap 5->0
  : STA ptygen_class, X

    LDA #$01                  ; set menustall (drawing while PPU is on)
    STA menustall
    LDX char_index            ; then update the on-screen class name
    JSR PtyGen_DrawOneText
    JMP @MainLoop

   @ReverseCharThing:
    LDX char_index
    LDA ptygen_class, X       ; Subtract 1 from the class ID of the current character.
    SEC
    SBC #1
    CMP #6                    ; JIGS - change this to 12 for all classes
    BCC :-
    LDA #5                    ; JIGS - and then change this to 11
    BNE :-

   @CharSpriteThing:
    LDX char_index
    LDA ptygen_sprite, X
    CLC
    ADC #1
    CMP #6                    ; JIGS - change this to 12 for all classes
    BCC :+
       LDA #0
  : STA ptygen_sprite, X
    JMP @MainLoop

   @ReverseCharSpriteThing:
    LDX char_index
    LDA ptygen_sprite, X      ; Subtract 1 from the sprite ID of the current character.
    SEC
    SBC #1
    CMP #6                    ; JIGS - change this to 12 for all classes
    BCC :-
    LDA #5                    ; JIGS - and then change this to 11
    BNE :-

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  DoNameInput  [$9D50 :: 0x39D60]
;;
;;    Does the name input screen.  Draw the screen, gets the name, etc, etc.
;;
;;  input:      ptygen = should be filled appropriately
;;          char_index = $00, 10, 20, 30 to indicate which character's name we're setting
;;
;;  output:    C is cleared to indicate name successfully input
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

DoNameInput:
    LDA #$00                ; Turn off the PPU (for drawing)
    STA $2001

    STA menustall           ; zero a bunch of misc vars being used here
    STA joy_a
    STA joy_b
    STA joy_start
    STA joy
    STA joy_prevdir

   ; STA cursor              ; letter of the name we're inputting (0-3)
    STA namecurs_x          ; X position of letter selection cursor (0-9)
    STA namecurs_y          ; Y position (0-6)

    ; Some local temp vars
    @selectedtile   = tmp

    JSR ClearNT ;_FillBackground
    JSR DrawNameInputScreen
    JSR NameInput_DrawName

    ;Write $00 to $1C97
    LDY $2002
    LDX #$1C
    STX $2006
    LDY #$97
    STY $2006
    LDA #0
    STA $2007
    ;; JIGS - this turns part of the beam spell graphic into a white _

    JSR TurnMenuScreenOn_ClearOAM   ; now that everything is drawn, turn the screen on

    LDX char_index
    LDY #0
   @FindCursorLoop:
    LDA ptygen_name, X
    CMP #$FF
    BEQ :+
    INX
    INY
    CPX #7
    BNE @FindCursorLoop
  : STY cursor

    INC menustall
    ;LDA #$01                ; Set menustall, as future drawing will
    ;STA menustall           ;  be with the PPU on
    JMP @MainLoop

    ;;;;;;;;;;;;;;;;;;


  @Start_Pressed:
    JSR PlaySFX_MenuSel
    LDY #0
    STY joy_start
    CLC                 ; CLC to indicate name was successfully input
    RTS

  @MainLoop:
    JSR CharName_Frame      ; Do a frame & get input

    LDA joy_start
    BNE @Start_Pressed
    LDA joy_a
    BNE @A_Pressed          ; Check if A or B pressed
    LDA joy_b
    BNE @B_Pressed

    LDA joy                 ; Otherwise see if D-pad state has changed
    AND #$0F
    CMP joy_prevdir
    BEQ @MainLoop           ; no change?  Jump back
    STA joy_prevdir

    ; D-pad state has changed, see what it changed to
    CMP #$00
    BEQ @MainLoop           ; if released, do nothing and loop

    CMP #$04
    BCC @Left_Or_Right      ; if < 4, L or R pressed

    CMP #$08                ; otherwise, if == 8, Up pressed
    BNE @Down               ; otherwise, if != 8, Down pressed

   @Up:
    DEC namecurs_y          ; DEC cursor Y position
    BPL @MainLoop
    LDA #$06                ; wrap 0->6
    STA namecurs_y
    JMP @MainLoop

   @Down:
    INC namecurs_y          ; INC cursor Y position
    LDA namecurs_y
    CMP #$07                ; wrap 6->0
    BCC @MainLoop
    LDA #$00
    STA namecurs_y
    JMP @MainLoop

   @Left_Or_Right:
    CMP #$02                ; if D-pad state == 2, Left pressed
    BNE @Right              ; else, Right pressed

   @Left:
    DEC namecurs_x          ; DEC cursor X position
    BPL @MainLoop
    LDA #$09                ; wrap 0->9
    STA namecurs_x
    JMP @MainLoop

   @Right:
    INC namecurs_x          ; INC cursor X position
    LDA namecurs_x
    CMP #$0A                ; wrap 9->0
    BCC @MainLoop
    LDA #$00
    STA namecurs_x
    JMP @MainLoop

   @B_Pressed:
    LDA #$FF                ; if B was pressed, erase the previous tile
    STA @selectedtile       ;   by setting selectedtile to be a space

    LDA cursor              ; then by pre-emptively moving the cursor back
    SEC                     ;   so @SetTile will overwrite the prev char
    SBC #$01                ;   instead of the next one
      STA cursor
      CMP #$FF
      BEQ @B_RTS

    LDA #$00                ; set cursoradd to 0 so @SetTile doesn't change
    STA cursoradd           ; the cursor
    STA joy_b               ; clear joy_b as well
    BEQ @SetTile            ; (always branches)

   @B_RTS:
    JMP DoPartyGen_OnCharacter

    ;;;;;;;;;;;;;;;;;;
   @A_Pressed:
    LDX namecurs_y                  ; when A is pressed, clear joy_a
    LDA #$00
    STA joy_a                       ; Then get the tile they selected by first
    LDA lut_NameInputRowStart, X    ;  running the Y cursor through a row lut
    CLC
    ADC namecurs_x                  ; add X cursor
    ASL A                           ; and multiply by 2 -- since there are spaces between tiles
    TAX                             ; use that value as an index to the lut_NameInput
    LDA lut_NameInput, X
    STA @selectedtile               ; record selected tile
    LDA #$01
    STA cursoradd                   ; set cursoradd to 1 to indicate we want @SetTile to move the cursor forward

    LDA cursor                      ; check current cursor position
    CMP #$07                        ;  If we've already input 7 letters for this name....
    BCS @Done                       ;  .. then we're done.  Branch ahead
                                    ; Otherwise, fall through to SetTile

   @SetTile:
    LDA cursor                  ; use cursor and char_index to access the appropriate
    CLC                         ;   letter in this character's name
    ADC char_index
    TAX
    LDA @selectedtile
    STA ptygen_name, X          ; and write the selected tile

    JSR NameInput_DrawName      ; Redraw the name as it appears on-screen

    LDA cursor                  ; Then add to our cursor
    CLC
    ADC cursoradd
    STA cursor

    JMP @MainLoop               ; And keep going!

   @Done:
    CLC                 ; CLC to indicate name was successfully input
    RTS

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  PtyGen_Frame  [$9E33 :: 0x39E43]
;;
;;    Does the typical frame stuff for the Party Gen screen
;;  Note the scroll is not reset here, since there is a little bit of drawing
;;  done AFTER this (which is dangerous -- what if the music routine runs long!)
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

PtyGen_Frame:
    JSR ClearOAM           ; wipe OAM then draw all sprites
    JSR PtyGen_DrawChars
    JSR PtyGen_DrawCursor

    JSR WaitForVBlank_L    ; VBlank and DMA
    LDA #>oam
    STA $4014

    LDA #BANK_THIS         ; then keep playing music
    STA cur_bank
    JSR CallMusicPlay

    JMP PtyGen_Joy         ; and update joy data!


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  CharName_Frame  [$9E4E :: 0x39E5E]
;;
;;    Does typical frame stuff for the Character naming screen
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

Blinker_LUT:
.byte $60, $68, $70, $78, $80, $88, $90, $90

CharName_Frame:
    JSR ClearOAM           ; wipe OAM then draw the cursor
    JSR CharName_DrawCursor

    LDA playtimer          ; get the milliseconds (music increments and wraps this)
    CMP #30                ; depending on if its the first or second half of the second, skip displaying the blinker
    BCC :+

    LDX cursor
    LDA Blinker_LUT, X

    LDX sprindex
    STA oam+$3, X          ; upper left horizontal coordinate
    LDA #$22
    STA oam+$0, X          ; upper left vertical coordinate
    LDA #$7E
    STA oam+$1, X          ; graphic: _
    LDA #$01
    STA oam+$2, X          ; attribute

  : JSR WaitForVBlank_L    ; VBlank and DMA
    LDA #>oam
    STA $4014

    LDA soft2000           ; reset the scroll to zero.
    STA $2000
    LDA #0
    STA $2005
    STA $2005

    LDA #BANK_THIS         ; keep playing music
    STA cur_bank
    JSR CallMusicPlay

    ; then update joy by running seamlessly into PtyGen_Joy

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  PtyGen_Joy  [$9E70 :: 0x39E80]
;;
;;    Updates Joypad data and plays button related sound effects for the Party
;;  Generation AND Character Naming screens.  Seems like a huge waste, since sfx could
;;  be easily inserted where the game handles the button presses.  But whatever.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

PtyGen_Joy:
    LDA joy
    AND #$0F
    STA tmp+7            ; put old directional buttons in tmp+7 for now

    JSR UpdateJoy        ; then update joypad data

    LDA joy_a            ; if either A or B pressed...
    ORA joy_b
    BEQ :+
      JMP PlaySFX_MenuSel ; play the Selection SFX, and exit

:   LDA joy              ; otherwise, check new directional buttons
    AND #$0F
    BEQ @Exit            ; if none pressed, exit
    CMP tmp+7            ; if they match the old buttons (no new buttons pressed)
    BEQ @Exit            ;   exit
    JMP PlaySFX_MenuMove ; .. otherwise, play the Move sound effect
  @Exit:
    RTS

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  PtyGen_DrawBoxes  [$9E90 :: 0x39EA0]
;;
;;    Draws the 4 boxes for the Party Generation screen
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

PtyGen_DrawBoxes:
    LDA #0
    STA tmp+15       ; reset loop counter to zero

  @Loop:
      JSR @Box       ; then loop 4 times, each time, drawing the next
      LDA tmp+15     ; character's box
      CLC
      ADC #$13       ; incrementing by $13 each time (indexes ptygen buffer)
      STA tmp+15
      CMP #$40      ;; JIGS - this might should be $4C but I guess it doesn't matter
      BCC @Loop
    RTS

 @Box:
    LDX tmp+15           ; get ptygen index in X

    LDA ptygen_box_x, X  ; get X,Y coords from ptygen buffer
    STA box_x
    LDA ptygen_box_y, X
    STA box_y

    LDA #11              ; fixed width/height of 10
    STA box_wd
    STA box_ht

    LDA #0
    STA menustall        ; disable menustalling (PPU is off)
    JMP DrawBox          ;  draw the box, and exit


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  PtyGen_DrawText  [$9EBC :: 0x39ECC]
;;
;;    Draws the text for all 4 character boxes in the Party Generation screen.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

PtyGen_DrawText:
    LDA #0             ; start loop counter at zero
  @MainLoop:
     PHA                ; push loop counter to back it up
     JSR @DrawOne       ; draw one character's strings
     PLA                ;  pull loop counter
     CLC                ; and increase it to point to next character's data
     ADC #$13
     CMP #$4C

     BCC @MainLoop      ;  loop until all 4 chars drawn
    RTS

  @DrawOne:
    TAX                 ; put the ptygen index in X for upcoming routine

    ; no JMP or RTS -- code flows seamlessly into PtyGen_DrawOneText

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  PtyGen_DrawOneText  [$9ECC :: 0x39EDC]
;;
;;    This draws text for *one* of the character boxes in the Party Generation
;;  screen.  This is called by the above routine to draw all 4 of them at once,
;;  but is also called to redraw an individual class name when the player changes
;;  the class of the selected character.
;;
;;    The text drawn here is just two short strings.  First is the name of the
;;  selected class (Fighter/Thief/etc).  Second is the character's name.
;;
;;    Text is drawn by simply copying short strings to the format buffer, then
;;  calling DrawComplexString to draw them.  The character's name is simply
;;  the 4 letters copied over.. whereas the class name makes use of one
;;  of DrawComplexString's control codes.  See that routine for further details.
;;
;;  IN:  X = ptygen index of the char whose text we want to draw
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

PtyGen_DrawOneText:
    LDA ptygen_class_x, X   ; get X,Y coords where we're going to place
    STA dest_x              ;  the class name
    LDA ptygen_class_y, X
    STA dest_y

    LDA ptygen_class, X     ; get the selected class
    CMP #01                 ; this silly thing just centers the THIEF text...
    BEQ :+
    CMP #07                 ; and the NINJA if its ever set to print here
    BNE :++

  : INC dest_x

  : CLC
    ADC #ITEM_CLASSSTART    ; add $F0 to select the class' "item name"
    STA format_buf-1        ;  store that as 2nd byte in format string
    LDA #$FF
    STA format_buf-3
    LDA #$02                ; first byte in string is $02 -- the control code to
    STA format_buf-2        ;  print an item name

    LDA #<(format_buf-3)    ; set the text pointer to point to the start of the 2-byte
    STA text_ptr            ;  string we just constructed
    LDA #>(format_buf-3)
    STA text_ptr+1

    LDA #BANK_THIS          ; set cur and ret banks (see DrawComplexString for why)
    STA cur_bank
    STA ret_bank

    TXA                     ; back up our index (DrawComplexString will corrupt it)
    PHA
    JSR DrawComplexString   ; draw the string
    PLA
    TAX                     ; and restore our index

    LDA ptygen_name, X
    STA format_buf-7
    LDA ptygen_name+1, X
    STA format_buf-6
    LDA ptygen_name+2, X
    STA format_buf-5
    LDA ptygen_name+3, X
    STA format_buf-4
    LDA ptygen_name+4, X
    STA format_buf-3
    LDA ptygen_name+5, X
    STA format_buf-2
    LDA ptygen_name+6, X
    STA format_buf-1

    LDA ptygen_name_x, X    ; set destination coords appropriately
    STA dest_x
    LDA ptygen_name_y, X
    STA dest_y

    ;; JIGS - for longer names

    LDA #<(format_buf-7)    ; set pointer to start of 4-byte string
    STA text_ptr
    LDA #>(format_buf-7)
    STA text_ptr+1

    LDA #BANK_THIS          ; set banks again (not necessary as they haven't changed from above
    STA cur_bank            ;   but oh well)
    STA ret_bank

    JMP DrawComplexString   ; then draw another complex string -- and exit!


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  PtyGen_DrawCursor  [$9F26 :: 0x39F36]
;;
;;    Draws the cursor for the Party Generation screen
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

PtyGen_DrawCursor:
    LDX char_index          ; use the current index to get the cursor
    LDA ptygen_curs_x, X    ;  coords from the ptygen buffer.
    STA spr_x
    LDA ptygen_curs_y, X
    STA spr_y
    JMP DrawCursor          ; and draw the cursor there



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  CharName_DrawCursor  [$9F35 :: 0x39F45]
;;
;;    Draws the cursor for the Character Naming screen
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

CharName_DrawCursor:
    LDA namecurs_x      ; X position = (cursx * 16) + $20
    ASL A
    ASL A
    ASL A
    ASL A
    CLC
    ADC #$20
    STA spr_x

    LDA namecurs_y      ; Y position = (cursy * 16) + $50
    ASL A
    ASL A
    ASL A
    ASL A
    CLC
    ADC #$50
    STA spr_y

    JMP DrawCursor


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  PtyGen_DrawChars  [$9F4E :: 0x39F5E]
;;
;;    Draws the sprites for all 4 characters on the party gen screen.
;;  This routine uses DrawSimple2x3Sprite to draw the sprites.
;;  See that routine for details.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

PtyGen_DrawChars:
    LDX #$00         ; Simply call @DrawOne four times, each time
    JSR @DrawOne     ;  having the index of the char to draw in X
    LDX #$13
    ;; JIGS ^ again, increase by 3 for every character
    JSR @DrawOne
    LDX #$26
    JSR @DrawOne
    LDX #$39


  @DrawOne:
    LDA ptygen_spr_x, X   ; load desired X,Y coords for the sprite
    STA spr_x
    LDA ptygen_spr_y, X
    STA spr_y

    ;LDA ptygen_class, X   ; get the class
    LDA ptygen_sprite, X   ; JIGS - get the SPRITE
    TAX
    LDA lutClassBatSprPalette, X   ; get the palette that class uses
    STA tmp+1             ; write the palette to tmp+1  (used by DrawSimple2x3Sprite)

    TXA               ; multiply the class index by $06
    ASL A             ; double it
	STA tmp           ; save it
	ASL A             ; double it again
	CLC               ; add in the first double!
	ADC tmp
    STA tmp           ; store it in tmp for DrawSimple2x3Sprite
    JMP DrawSimple2x3Sprite



;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  NameInput_DrawName  [$9F7D :: 0x39F8D]
;;
;;    Used during party generation.. specifically the name input screen
;;  to draw the character's name at the top of the screen.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;

NameInput_DrawName:
            @buf  = $59 ; $5C     ; local - buffer to hold the name for printing
            ;; JIGS ^ move the buffer further in, but its okay! Not overwriting anything. I think.

    LDX char_index          ; copy the character's name to our temp @buf
    LDA ptygen_name, X
    STA @buf
    LDA ptygen_name+1, X
    STA @buf+1
    LDA ptygen_name+2, X
    STA @buf+2
    LDA ptygen_name+3, X
    STA @buf+3              ; The code assumes @buf+4 is 0
    ;; JIGS - adding more letters ^ this is still correct, but 7 instead of 4
    LDA ptygen_name+4, X
    STA @buf+4
    LDA ptygen_name+5, X
    STA @buf+5
    LDA ptygen_name+6, X
    STA @buf+6

    LDA #>@buf              ; Set the text pointer
    STA text_ptr+1
    LDA #<@buf
    STA text_ptr

    LDA #BANK_THIS          ; set cur/ret banks
    STA cur_bank
    STA ret_bank

    LDA #$0C                ; set X/Y positions for the name to be printed
    STA dest_x
    LDA #$04
    STA dest_y

    LDA #$01                ; drawing while PPU is on, so set menustall
    STA menustall

    JMP DrawComplexString   ; Then draw the name and exit!

;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  DrawNameInputScreen  [$9FB0 :: 0x39FC0]
;;
;;  Draws everything except for the player's name.
;;
;;  Assumes PPU is off upon entry
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;

DrawNameInputScreen:
    LDA $2002               ; clear PPU toggle

;    LDA #>$23C0             ; set PPU addr to the attribute table
;    STA $2006
;    LDA #<$23C0
;    STA $2006

;    LDA #$00                ; set $10 bytes of the attribute table to use palette 0
;    LDX #$10                ;  $10 bytes = 8 rows of tiles (32 pixels)
;    : STA $2007             ; This makes the top box the orangish color instead of the normal blue
;      DEX
;      BNE :-

;; JIGS - not doing that anymore!

    LDA #0
    STA menustall           ; no menustall (PPU is off at this point)

    LDA #$04                ; Draw the big box containing input
    STA box_x
    LDA #$08
    STA box_y
    LDA #$17
    STA box_wd
    LDA #$14
    STA box_ht
    JSR DrawBox

    LDA #$0A               ; Draw the small top box containing the player's name
    STA box_x
    LDA #$02
    STA box_y
    LDA #$0B ; 06
    STA box_wd
    LDA #$05 ; 04
    STA box_ht
    JSR DrawBox

    LDA #<lut_NameInput     ; Print the NameInput lut as a string.  This will fill
    STA text_ptr            ;  the bottom box with the characters the user can select.
    LDA #>lut_NameInput
    STA text_ptr+1
    LDA #$06
    STA dest_x
    LDA #$0A
    STA dest_y
    LDA #BANK_THIS
    STA cur_bank
    STA ret_bank
    JMP DrawComplexString


;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Name Input Row Start lut  [$A00A :: 0x3A01A]
;;
;;    offset (in usable characters) to start of each row in the below lut_NameInput

lut_NameInputRowStart:
  .BYTE  0, 10, 20, 30, 40, 50, 60  ; 10 characters of data per row
                                    ;  (which is actually 20 bytes, because they have spaces between them)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Name Input lut  [$A011 :: 0x3A021]
;;
;;    This lut is not only used to get the character the user selection on the name input screen,
;;  but it also is stored in null-terminated string form so that the entire thing can be drawn with
;;  with a single call to DrawComplexString.  It's intersperced with $FF (spaces) and $01 (double line breaks)

lut_NameInput:
  .BYTE $8A, $FF, $8B, $FF, $8C, $FF, $8D, $FF, $8E, $FF, $8F, $FF, $90, $FF, $91, $FF, $92, $FF, $93, $01  ; A - J
  .BYTE $94, $FF, $95, $FF, $96, $FF, $97, $FF, $98, $FF, $99, $FF, $9A, $FF, $9B, $FF, $9C, $FF, $9D, $01  ; K - T
  .BYTE $9E, $FF, $9F, $FF, $A0, $FF, $A1, $FF, $A2, $FF, $A3, $FF, $BE, $FF, $BF, $FF, $C0, $FF, $FF, $01  ; U - Z ; , . <space>
  .BYTE $80, $FF, $81, $FF, $82, $FF, $83, $FF, $84, $FF, $85, $FF, $86, $FF, $87, $FF, $88, $FF, $89, $01  ; 0 - 9
  .BYTE $A4, $FF, $A5, $FF, $A6, $FF, $A7, $FF, $A8, $FF, $A9, $FF, $AA, $FF, $AB, $FF, $AC, $FF, $AD, $01  ; a - j
  .BYTE $AE, $FF, $AF, $FF, $B0, $FF, $B1, $FF, $B2, $FF, $B3, $FF, $B4, $FF, $B5, $FF, $B6, $FF, $B7, $01  ; k - t
  .BYTE $B8, $FF, $B9, $FF, $BA, $FF, $BB, $FF, $BC, $FF, $BD, $FF, $C2, $FF, $C3, $FF, $C4, $FF, $C5, $01  ; u - z - .. ! ?
  ;.BYTE $01
  ;.BYTE $FF, $FF, $FF, $9C, $8E, $95, $8E, $8C, $9D, $FF, $FF, $97, $8A, $96, $8E, $00                      ;   SELECT  NAME

  ;; JIGS - I think this looks nicer:

  .BYTE $05
  .BYTE $97,$8A,$96,$8E,$FF,$A2,$98,$9E,$9B,$FF,$8C,$91,$8A,$9B,$8A,$8C,$9D,$8E,$9B,$00 ; NAME YOUR CHARACTER

;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  LUT for party generation  [$A0AE :: 0x3A0BE]
;;
;;    This LUT is copied to the RAM buffer 'ptygen' which is used to
;;  track which class is selected for each character, what their name is,
;;  where they're to be drawn, etc.  This can be changed to assign a default
;;  party or default names, and to rearrange some of the graphics for the
;;  Party Generation Screen
;;
;;    See details of 'ptygen' buffer in RAM for a full understanding of
;;  the format of this table.

lut_PtyGenBuf:
;  .BYTE $00,$00,$FF,$FF,$FF,$FF,$07,$0C,$05,$06,$40,$40,$04,$04,$30,$40
;  .BYTE $01,$00,$FF,$FF,$FF,$FF,$15,$0C,$13,$06,$B0,$40,$12,$04,$A0,$40
;  .BYTE $02,$00,$FF,$FF,$FF,$FF,$07,$18,$05,$12,$40,$A0,$04,$10,$30,$A0
;  .BYTE $03,$00,$FF,$FF,$FF,$FF,$15,$18,$13,$12,$B0,$A0,$12,$10,$A0,$A0
  ;      1   2   3   4   5   6   7   8   9   10  11  12  13  14  15  16  17  18  19
  .BYTE $00,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$06,$0C,$05,$06,$48,$40,$04,$04,$33,$44,$00
  .BYTE $01,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$13,$0C,$12,$06,$B0,$40,$11,$04,$9C,$44,$01
  .BYTE $02,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$06,$18,$05,$12,$48,$A0,$04,$10,$33,$A4,$02
  .BYTE $03,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$13,$18,$12,$12,$B0,$A0,$11,$10,$9C,$A4,$03

  ;; JIGS ^ adding more bytes for names, and one for sprite instead of class.... ^
; ptygen_class   = 1
; ptygen_name    = 2, 3, 4, 5, 6, 7, 8
; ptygen_name_x  = 9
; ptygen_name_y  = 10
; ptygen_class_x = 11
; ptygen_class_y = 12
; ptygen_spr_x   = 13
; ptygen_spr_y   = 14
; ptygen_box_x   = 15
; ptygen_box_y   = 16
; ptygen_curs_x  = 17
; ptygen_curs_y  = 18
; ptygen_sprite  = 19









DrawOptions:
  LDA #24
  STA dest_x
  LDA #8
  STA dest_y
  LDX ExpGainOption
  LDA lut_LowNormalHigh, X
  JSR DrawZ_MenuString

  LDA #10
  STA dest_y
  LDX MoneyGainOption
  LDA lut_LowNormalHigh, X
  JSR DrawZ_MenuString

  LDA #12
  STA dest_y
  LDX EncRateOption
  LDA lut_LowNormalHigh, X
  JSR DrawZ_MenuString

  JSR LongCall
  .word BattleBGColorDigits
  .byte BANK_MENUS

  LDA $2002          ; PPU toggle... needed or not?
  LDA #>$221A        ; Color is drawn here
  STA $2006
  LDA #<$221A
  STA $2006
  LDA format_buf-2
  STA $2007
  LDA format_buf-1
  STA $2007

  LDA #>$21DB        ; Respond rate is drawn here
  STA $2006
  LDA #<$21DB
  STA $2006
  LDA BattleTextSpeed ; get the current respond rate (which is zero based)
  CLC                 ;  add $80+1 to it.  $80 to convert it to the coresponding tile
  ADC #$80+1          ;  for the desired digit to print, and +1 to convert it from zero
  STA $2007           ;  based to 1 based (so it's printed as 1-8 instead of 0-7)
  LDA #$00            ; reset scroll to 0 (very important!)
  STA $2005
  STA $2005

  LDA #24
  STA dest_x
  LDA #18
  STA dest_y
  LDX AutoTargetOption
  LDA lut_OnOff, X
  JSR DrawZ_MenuString

  LDA #20
  STA dest_y
  LDX MuteSFXOption
  LDA lut_OnOff, X
  JMP DrawZ_MenuString


OptionsMenu:
    JSR ClearButtons          ; A = 0
    STA cursor
    STA joy_prevdir        ; as well as resetting the cursor and previous joy direction
    STA $2001
    STA menustall

    LDX BattleBGColor
    LDA BattleBackgroundColor_LUT, X
    STA cur_pal+14

    LDA #1
    STA box_x
    LDA #6
    STA box_y
    LDA #30
    STA box_wd
    LDA #17
    STA box_ht
    JSR DrawBox                ; draws the options box

    LDA #7
    STA cursor_max
    LDA #0
    JSR DrawZ_MenuString       ; draws the static list of changable things

    JSR TurnMenuScreenOn_ClearOAM

ReenterOptionsMenu:
    LDA #1
    STA menustall              ; turn menustall back on
    JSR DrawOptions            ; and draw the option variables (off, on, high, low, etc)

OptionsLoop:
  JSR ClearOAM
  JSR DrawOptionsCursor        ; draw the cursor
  JSR OptionsMenuFrame         ; Do a frame

  LDA joy_a                    ; check to see if A has been pressed
  BNE @A_Pressed
  LDA joy_b                    ; then see if B has been pressed
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
    BEQ @JMP_MoneyGain
    CMP #2
    BEQ @JMP_EncounterRate
    CMP #3
    BEQ @BattleTextSpeed
    CMP #4
    BEQ @JMP_BattleBackground
    CMP #5
    BEQ @JMP_AutoTarget
    PLA                   ; pull direction and toss it

   @MenuSFX:
    LDA MuteSFXOption     ; whether left or right is pressed, all you can do is switch it on/off
    BEQ :+
      DEC MuteSFXOption
      RTS

  : INC MuteSFXOption
    RTS

   @JMP_BattleBackground:
   JMP BattleBackgroundColor

   @JMP_MoneyGain:
   JMP @MoneyGain

   @JMP_EncounterRate:
   JMP @EncounterRate

   @BattleTextSpeed:
    PLA                     ; pull direction and branch
    BEQ @IncreaseBattleTextSpeed

       DEC BattleTextSpeed
       LDA BattleTextSpeed
       BPL @Return         ; if the result didn't wrap (still positive), return
       LDA #8
       STA BattleTextSpeed
       RTS

   @IncreaseBattleTextSpeed:
    LDA BattleTextSpeed
    CMP #8
    BNE :+                  ; if its not over the limit, increase it
       LDA #0
       STA BattleTextSpeed
       RTS

  : INC BattleTextSpeed
   @Return:
    RTS

   @JMP_AutoTarget:
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


BattleBackgroundColor:
    PLA
    BEQ @NextColor

   @PreviousColor:
    DEC BattleBGColor
    LDA BattleBGColor
    CMP #$FF
    BNE @Return
    LDA #14
    STA BattleBGColor
    JMP @Return

   @NextColor:
    LDA BattleBGColor
    CMP #14
    BNE :+
       LDA #0
       STA BattleBGColor
       JMP @Return

  : INC BattleBGColor

   @Return:
    LDA #0
    STA $2002
    LDX BattleBGColor
    LDA BattleBackgroundColor_LUT, X
    STA cur_pal+14
    JMP TurnOnScreen


DrawOptionsCursor:
    LDY cursor                   ; get current cursor selection
    LDA lut_OptionsCursor_Y, Y   ;  use cursor as an index to get the desired Y coord
    STA spr_y                    ;  write the Y coord
    LDA #$B0                     ; X coord for options menu cursor is always 22
    STA spr_x
    JMP DrawCursor               ; draw it!  and exit

lut_OptionsCursor_Y:
   .BYTE  $40,$50,$60,$70,$80,$90,$A0

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
    JSR ClearNT

    LDX #>$23C0
    LDA #<$23C0
    STX $2006   ; write X as high byte
    STA $2006   ; A as low byte

    LDA #0
    LDX #$10
   @Loop1:
    STA $2007
    DEX
    BNE @Loop1

    LDA #$F0
    LDX #$8
   @Loop2:
    STA $2007
    DEX
    BNE @Loop2

    LDA #$FF
    LDX #$28
   @Loop3:
    STA $2007
    DEX
    BNE @Loop3

;; that should set the attributes to look like this:
;  .BYTE $00,$00,$00,$00,$00,$00,$00,$00
;  .BYTE $00,$00,$00,$00,$00,$00,$00,$00
;  .BYTE $F0,$F0,$F0,$F0,$F0,$F0,$F0,$F0
;  .BYTE $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
;  .BYTE $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
;  .BYTE $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
;  .BYTE $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
;  .BYTE $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF

    LDA $2002              ; Set address to $1000
    LDA #>$1000
    STA $2006
    LDA #<$1000
    STA $2006

    LDA #>WeaselChr
    STA tmp+1
    LDA #<WeaselChr
    STA tmp

    LDY #0
    LDX #$40
  @LoadWeaselLoop:
    LDA (tmp), Y      ; read a byte from source pointer
    STA $2007         ; and write it to CHR-RAM
    INY               ; inc our source index
    DEX
    BNE @LoadWeaselLoop
    RTS





SoundTestZ:
    LDA #BANK_THIS           ; record current bank and CallMusicPlay
    STA cur_bank

    JSR SoundTestClearNT     ; clear the nametable, set the attributes, load weasel sprite
    STX menustall            ; X = 0

    LDA #$02
    STA box_x
    LDA #$0A
    STA box_y
    LDA #$1C
    STA box_wd
    LDA #$05
    STA box_ht
    JSR DrawBox              ; draw the song name box

    LDA #$02
    STA box_x
    LDA #$14
    STA box_y
    LDA #$1C
    STA box_wd
    LDA #$08
    STA box_ht
    JSR DrawBox              ; draw the instructions box

    INC dest_x
    LDA #$0C
    JSR DrawZ_MenuString            ; draw the instructions

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
    LDA #$20
    STA cur_pal+3

    JSR TurnMenuScreenOn_ClearOAM   ; then clear OAM and turn the screen on

SoundTest_NewSong:
    LDA #1
    STA menustall         ; enable to write while PPU is on
    LDA #$05
    STA dest_x
    LDA #$0C
    STA dest_y
    LDA soundtest         ; 0-24, or however many songs there are
    CLC
    ADC #$10              ; all song names are after $10 in the lut_ZMenuText table
    JSR DrawZ_MenuString

SoundTestMenuLoop:
    JSR ClearOAM                  ; clear OAM (erasing    all existing sprites)
    JSR DrawSoundTestCursor       ; draw the cursor
    JSR DrawSoundTestHole
    JSR WeaselSprite
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
    BCC SoundTest_NewSong         ; carry set if new song chosen (only prints text, doesn't update music)
    JMP SoundTestMenuLoop         ; rinse, repeat

   @B_Pressed:
    JSR ClearButtons
    STA joy_prevdir        ; as well as resetting the cursor and previous joy direction
    STA $2001
    STA $4015           ; and silence the APU.  Music sill start next time MusicPlay is called.
    STA $5015           ; and silence the MMC5 APU.
    STA soundtesthelper
    STA dlgmusic_backup
    STA soundtest
    RTS               ; and exit the main menu (by RTSing out of its loop)

   @A_Pressed:
    LDA soundtesthelper
    BEQ @MusicOn
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
    INC soundtesthelper
    LDA soundtest
    CLC
    ADC #$41
    STA music_track
    JMP SoundTestMenuLoop          ; then return to main menu loop

   @Start_Pressed:
    JSR DrawZheepText
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

    LDA playtimer          ; pause the play timer while in the sound test!
    CMP #59                ; but if its about to hit 60, don't touch it
    BEQ :+                 ; or else every frame here will count as a second for total playtime
        DEC playtimer

  : INC framecounter       ; increment the frame counter to count this frame

    JSR ClearButtons
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
      LDA #26
      STA soundtest
  : CLC
    RTS

  @Up:                ; up is the same deal...
    LDA #0
    STA soundtesthelper
    INC soundtest
    LDA soundtest
    CMP #27
    BNE :+
      LDA #0
      STA soundtest
  : CLC
    RTS

 @Exit:
  SEC
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

DrawZheepText:
    LDA #$01
    STA menustall
    LDX #$1B
    JSR RandAX
    STA dest_x
    LDA #$02
    LDX #$08
    JSR RandAX
    STA dest_y
    DEC weasels
    LDA #$0D
    JMP DrawZ_MenuString

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
  .INCBIN "chr/weasel.chr"












































;; JIGS - here is all the 3 Save File things.


SaveScreen:
    LDA #0
    STA cursor               ; flush cursor, joypad, and prev joy directions
    STA joy
    STA joy_prevdir
    STA $2001                ; turn off the PPU
    STA menustall            ; disable menu stalling
    STA SaveGameMusic        ; clear this variable, which will help reset music later
    JSR ClearNT              ; clear the NT
    LDA #1
    STA $5113                ; swap battery-backed PRG RAM
    JSR SaveScreenHelper

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
    JSR DrawZ_MenuString ; Draw Save slot text: SAVE 1, SAVE 2, SAVE 3
    JSR DrawSaveScreenNames
    LDA weasels
    BNE SaveGameStuff

LoadGameStuff:
    JSR SaveScreenTitleTextPosition
    LDA #$07
    JSR DrawZ_MenuString
    JSR TurnMenuScreenOn_ClearOAM
    JMP SaveScreenLoop

SaveGameStuff:
    JSR SaveScreenTitleTextPosition
    LDA #$08
    JSR DrawZ_MenuString
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
    LDA #02 ; 10
    STA dest_x
    LDA #01
    STA menustall
    LDA #10
    JSR DrawZ_MenuString
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
    STA SaveGameMusic
    LDY cursor
    LDA SavedTextYLUT, Y
    STA dest_y
    LDA #04
    STA dest_x
    LDA #01
    STA menustall
    LDA #09
    JSR DrawZ_MenuString
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
    JSR DrawZ_MenuString
    JSR DrawSaveScreenNames
    JSR PlayDoorSFX
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

    JSR ClearButtons
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
    LDA (CharStatsPointer), Y  ; get name byte
    CMP #0
    BNE :+
    LDA #$FF
  : STA SaveScreenCharBuf, X  ; put in string buffer
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

    LDA #$FF ; spaces to put between names on the same line, or just to fill blank space
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
    STA CharStatsPointer
    LDA SaveScreenChar_LUT+1, Y
    STA CharStatsPointer+1
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
    LDA (CharStatsPointer), Y  ; get first letter of first character's name in this save slot
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
    LDA (CharStatsPointer), Y  ; get sprite from different save slots
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








DrawZ_MenuString: ;_Len:
    ASL A                   ; double menu string ID
    TAX                     ; put in X
    LDA lut_ZMenuText, X     ; and load up the pointer into (tmp)
    STA text_ptr
    LDA lut_ZMenuText+1, X
    STA text_ptr+1
    LDA #BANK_THIS
    STA cur_bank          ; set data bank (string to draw is on this bank -- or is in RAM)
    STA ret_bank          ; set return bank (we want it to RTS to this bank when complete)
    JMP DrawComplexString ;  Draw Complex String, then exit!



MenuWaitForBtn_SFX:
    JSR MenuFrame           ; do a frame
    LDA joy_a               ;  check A and B buttons
    ORA joy_b
    BEQ MenuWaitForBtn_SFX  ;  if both are zero, keep looping.  Otherwise...
    LDA #0
    STA joy_a               ; clear both joy_a and joy_b
    STA joy_b
   ; JMP PlaySFX_MenuSel     ; play the MenuSel sound effect, and exit


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

MenuFrame:
    JSR HushTriangle
    ;; JIGS ^ every frame, gosh
    JSR WaitForVBlank_L    ; wait for VBlank
    LDA #>oam              ; Do sprite DMA (update the 'real' OAM)
    STA $4014

    LDA soft2000           ; reset scroll and PPU data
    STA $2000
    LDA #0
    STA $2005
    STA $2005

    LDA music_track        ; if no music track is playing...
    BPL :+
      ;LDA #$51             ;  start music track $51  (menu music)
      LDA dlgmusic_backup  ;; JIGS - change to map music
      STA music_track

:   LDA #BANK_THIS         ; record this bank as the return bank
    STA cur_bank           ; then call the music play routine (keep music playing)
    JSR CallMusicPlay

    INC framecounter       ; increment the frame counter to count this frame

    JSR ClearButtons
    JMP UpdateJoy          ; update joypad info, then exit





;; JIGS - luts go down here:


lut_LowNormalHigh:
.byte $01,$02,$03

lut_OnOff:
.byte $04,$05

lut_ZMenuText:
.word M_OptionsMenu          ; 0
.word OptLow                 ; 1
.word OptNormal              ; 2
.word OptHigh                ; 3
.word OptionOn               ; 4
.word OptionOff              ; 5
.word M_SaveSlots            ; 6
.word M_SaveTitle            ; 7
.word M_LoadTitle            ; 8
.word Saved                  ; 9
.word AreYouSure             ; A ; 10
.word Deleted                ; B ; 11
.word SoundTestInstructions  ; C ; 12
.word Zheep                  ; D ; 13
.word BLANK                  ; E ;
.word BLANK                  ; F ;
.word Song1                  ; 10
.word Song2                  ; 11
.word Song3                  ; 12
.word Song4                  ; 13
.word Song5                  ; 14
.word Song6                  ; 15
.word Song7                  ; 16
.word Song8                  ; 17
.word Song9                  ; 18
.word Song10                 ; 19
.word Song11                 ; 1A
.word Song12                 ; 1B
.word Song13                 ; 1C
.word Song14                 ; 1D
.word Song15                 ; 1E
.word Song16                 ; 1F
.word Song17                 ; 20
.word Song18                 ; 21
.word Song19                 ; 22
.word Song20                 ; 23
.word Song21                 ; 24
.word Song22                 ; 25
.word Song23                 ; 26
.word Song24                 ; 27
.word Song25                 ; 28
.word Song26                 ; 29
.word Song27                 ; 2A


BLANK:

OptionOn:
.byte $98,$97,$FF,$00

OptionOff:
.byte $98,$8F,$8F,$00

OptLow:
.byte $95,$98,$A0,$FF,$FF,$FF,$00

OptNormal:
.byte $97,$98,$9B,$52,$95,$00

OptHigh:
.byte $91,$92,$90,$91,$FF,$FF,$00

M_OptionsMenu:
.byte $8E,$A1,$99,$8E,$9B,$92,$8E,$97,$8C,$8E,$FF,$90,$8A,$92,$97,$01
.byte $96,$98,$97,$8E,$A2,$FF,$90,$8A,$92,$97,$01
.byte $8E,$97,$8C,$98,$9E,$97,$9D,$8E,$9B,$FF,$9B,$8A,$9D,$8E,$01
.byte $8B,$8A,$9D,$9D,$95,$8E,$FF,$96,$8E,$9C,$9C,$8A,$90,$8E,$FF,$9C,$99,$8E,$8E,$8D,$FF,$FF,$C1,$FF,$FF,$FF,$FF,$C7,$01
.byte $8B,$8A,$9D,$9D,$95,$8E,$FF,$96,$8E,$9C,$9C,$8A,$90,$8E,$FF,$8C,$98,$95,$98,$9B,$FF,$FF,$C1,$FF,$FF,$FF,$FF,$C7,$01
.byte $8A,$9E,$9D,$98,$C2,$9D,$8A,$9B,$90,$8E,$9D,$01
.byte $96,$8E,$97,$9E,$FF,$9C,$8F,$A1,$00


SoundTestInstructions:
.byte $8B,$FF,$C2,$FF,$8E,$BB,$AC,$B7,$05,$8A,$FF,$C2,$FF,$9C,$B7,$A4,$B5,$B7,$F2,$9C,$B7,$B2,$B3,$FF,$96,$B8
.byte $B6,$AC,$A6,$05,$9E,$B3,$F2,$8D,$B2,$BA,$B1,$FF,$C2,$FF,$9C,$A8,$AF,$A8,$A6,$B7,$FF,$9C,$B2
.byte $B1,$AA,$05,$9C,$B7,$A4,$B5,$B7,$FF,$C2,$FF,$91,$B8,$AA,$FF,$A4,$FF,$BA,$A8,$A4,$B6,$A8,$AF,$FF,$E8,$D3,$E8,$00

Zheep:
.byte $A3,$AB,$B3,$C4,$00

M_SaveSlots:
.byte $8F,$92,$95,$8E,$FF,$81,$01,$01,$01,$01,$8F,$92,$95,$8E,$FF,$82,$01,$01,$01,$01,$8F,$92,$95,$8E,$FF,$83,$00

M_SaveTitle:
.byte $95,$98,$8A,$8D,$FF,$FF,$90,$8A,$96,$8E,$00

M_LoadTitle:
.byte $9C,$8A,$9F,$8E,$FF,$FF,$90,$8A,$96,$8E,$00

Saved:
.byte $9C,$8A,$9F,$8E,$8D,$C4,$00

AreYouSure:
.byte $F3,$F4,$7F,$F4,$F3,$F4,$FA,$FF,$8A,$9B,$8E,$FF,$A2,$98,$9E,$FF,$9C,$9E,$9B,$8E,$C5,$FB,$F4,$F3,$F4,$7F,$F4,$F3,$00

Deleted:
.byte $FF,$FF,$8D,$8E,$95,$8E,$9D,$8E,$8D,$C4,$FF,$FF,$FF,$00


;                      13  12  11  10  0F  0E  0D  0C  0B  0A
;                      19  18  17  16  15  14  13  12  11  10  9   8   7   6   5   4   3   2   1   0 -- spaces needed
Song1:
.byte $99,$B5,$A8,$AF,$B8,$A7,$A8,$09,$10,$00                                             ; Prelude
Song2:
.byte $99,$B5,$B2,$AF,$B2,$AA,$B8,$A8,$09,$0F,$00                                         ; Prologue
Song3:
.byte $8E,$B3,$AC,$AF,$B2,$AA,$B8,$A8,$09,$0F,$00                                         ; Epilogue
Song4:
.byte $98,$B9,$A8,$B5,$BA,$B2,$B5,$AF,$A7,$09,$0D,$00                                     ; Overworld
Song5:
.byte $9C,$A4,$AC,$AF,$AC,$B1,$AA,$FF,$9C,$AB,$AC,$B3,$09,$0B,$00                         ; Sailing Ship
Song6:
.byte $8A,$AC,$B5,$B6,$AB,$AC,$B3,$09,$10,$00                                             ; Airship
Song7:
.byte $9D,$B2,$BA,$B1,$09,$13,$00                                                         ; Town
Song8:
.byte $8C,$A4,$B6,$B7,$AF,$A8,$09,$11,$00                                                 ; Castle
Song9:
.byte $8E,$A4,$B5,$B7,$AB,$FF,$8C,$A4,$B9,$A8,$FF,$7A,$FF,$90,$B8,$B5,$AA,$B8,$09,$05,$00 ; Earth Cave / Gurgu
Song10:
.byte $96,$A4,$B7,$B2,$BC,$A4,$09,$11,$00                                                 ; Matoya
Song11:
.byte $96,$A4,$B5,$B6,$AB,$FF,$8C,$A4,$B9,$A8,$FF,$C8,$97,$A8,$BA,$C9,$09,$07,$00         ; Marsh Cave (New)
Song12:
.byte $9D,$A8,$B0,$B3,$AF,$A8,$FF,$B2,$A9,$FF,$8F,$AC,$A8,$B1,$A7,$B6,$09,$07,$00         ; Temple of Fiends
Song13:
.byte $9C,$AE,$BC,$FF,$8C,$A4,$B6,$B7,$AF,$A8,$09,$0C,$00                                 ; Sky Castle
Song14:
.byte $9C,$A8,$A4,$FF,$9C,$AB,$B5,$AC,$B1,$A8,$09,$0C,$00                                 ; Sea Shrine
Song15:
.byte $9C,$AB,$B2,$B3,$09,$13,$00                                                         ; Shop
Song16:
.byte $8B,$A4,$B7,$B7,$AF,$A8,$09,$11,$00                                                 ; Battle
Song17:
.byte $96,$A8,$B1,$B8,$FF,$7A,$FF,$92,$B1,$B1,$FF,$7A,$FF,$96,$A4,$B3,$09,$07,$00         ; Menu / Inn / Map
Song18:
.byte $9C,$AF,$A4,$AC,$B1,$09,$12,$00                                                     ; Slain
Song19:
.byte $8F,$A4,$B1,$A9,$A4,$B5,$A8,$09,$10,$00                                             ; Fanfare
Song20:
.byte $94,$A8,$BC,$FF,$92,$B7,$A8,$B0,$09,$0E,$00                                         ; Key Item
Song21:
.byte $96,$A4,$B5,$B6,$AB,$FF,$8C,$A4,$B9,$A8,$FF,$C8,$98,$AF,$A7,$C9,$09,$07,$00         ; Marsh Cave (Old)
Song22:
.byte $9C,$A4,$B9,$AC,$B1,$AA,$09,$11,$00                                                 ; Saving
Song23:
.byte $91,$A8,$A4,$AF,$AC,$B1,$AA,$FF,$C8,$9E,$B1,$B8,$B6,$A8,$A7,$C9,$09,$07,$00         ; Healing (Unused)
Song24:
.byte $9D,$B5,$A8,$A4,$B6,$B8,$B5,$A8,$FF,$C8,$9E,$B1,$B8,$B6,$A8,$A7,$C9,$09,$06,$00     ; Treasure (Unused)
Song25:
.byte $8F,$AC,$A8,$B1,$A7,$FF,$8B,$A4,$B7,$B7,$AF,$A8,$09,$0B,$00                         ; Fiend Battle
Song26:
.byte $8F,$AC,$A8,$B1,$A7,$FF,$8B,$A4,$B7,$B7,$AF,$A8,$FF,$82,$09,$09,$00                 ; Fiend Battle 2
Song27:
.byte $9B,$B8,$AC,$B1,$A8,$A7,$FF,$8C,$A4,$B6,$B7,$AF,$A8,$09,$0A,$00                     ; Ruined Castle



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







.byte "END OF BANK F"