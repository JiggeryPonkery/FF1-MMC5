.include "variables.inc"
.include "macros.inc"
.include "Constants.inc"
.feature force_range

.export BattleOver_ProcessResult_L
.export SpiritCalculations
.export StealFromEnemy
.export LoadPlayerDefenderStats_ForEnemyAttack
.export LoadEnemyStats
.export EnemyAttackPlayer_PhysicalZ
.export PlayerAttackEnemy_PhysicalZ
.export PlayerAttackPlayer_PhysicalZ
.export ClericCheck
.export CritCheck
.export ScanEnemyString

.import CallMusicPlay_L
.import WaitForVBlank_L
.import UndrawNBattleBlocks_L
.import DrawCombatBox_L
.import BattleRNG_L
.import BattleCrossPageJump_L
.import BankC_CrossBankJumpList
.import LongCall
.import RandAX
.import MultiplyXA
.import SetPPUAddr_XA
.import ShiftLeft6
.import ADD_ITEM
.import AddGPToParty
.import Set_Inv_Magic
.import Set_Inv_Weapon
.import LoadPrice_Long
.import GetWeaponDataPointer
.import ConvertBattleNumber

.segment "BANK_0B"

BANK_THIS = $0B



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  LUT for Enemy AI [$9020 :: 0x31030]
;;  byte      0 = chance to cast spell         ($00-80)
;;  byte      1 = chance to use special attack ($00-80)
;;  bytes   2-A = magic spells available.  Each entry 0-based.  Or 'FF' for nothing.
;;  bytes   B-F = Enemy attack ID

EnemyAIData:

;      0   1   2   3   4   5   6   7   8   9   A    B   C   D   E   F
.byte $00,$05,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF, $1A,$FF,$FF,$FF,$FF ;00 IMP	    ; [IMP PUNCH]
.byte $00,$15,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF, $1A,$1A,$1A,$1A,$1A ;01 GrIMP	; [IMP PUNCH x5]
.byte $00,$00,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF, $FF,$FF,$FF,$FF,$FF ;02 WOLF	    ;
.byte $00,$00,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF, $FF,$FF,$FF,$FF,$FF ;03 GrWolf   ;
.byte $00,$00,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF, $FF,$FF,$FF,$FF,$FF ;04 WrWolf   ;
.byte $00,$20,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF, $00,$00,$00,$00,$FF ;05 FrWOLF   ; [FROST x4]
.byte $00,$00,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF, $FF,$FF,$FF,$FF,$FF ;06 IGUANA   ;
.byte $00,$20,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF, $01,$01,$01,$01,$FF ;07 AGAMA    ; [HEAT x4]
.byte $00,$40,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF, $02,$02,$02,$02,$FF ;08 SAURIA   ;
.byte $00,$00,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF, $FF,$FF,$FF,$FF,$FF ;09 GIANT    ;
.byte $00,$00,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF, $FF,$FF,$FF,$FF,$FF ;0A FrGIANT  ;
.byte $00,$00,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF, $FF,$FF,$FF,$FF,$FF ;0B R`GIANT  ;
.byte $00,$00,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF, $FF,$FF,$FF,$FF,$FF ;0C SAHAG    ;
.byte $00,$00,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF, $FF,$FF,$FF,$FF,$FF ;0D R`SAHAG  ;
.byte $00,$00,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF, $FF,$FF,$FF,$FF,$FF ;0E WzSAHAG  ;
.byte $00,$00,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF, $FF,$FF,$FF,$FF,$FF ;0F PIRATE   ;
.byte $00,$00,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF, $FF,$FF,$FF,$FF,$FF ;10 KYZOKU   ;
.byte $00,$00,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF, $FF,$FF,$FF,$FF,$FF ;11 SHARK    ;
.byte $00,$00,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF, $FF,$FF,$FF,$FF,$FF ;12 GrSHARK  ;
.byte $00,$80,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF, $03,$03,$03,$03,$FF ;13 OddEYE   ; [GAZE x4]
.byte $00,$40,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF, $03,$04,$03,$04,$FF ;14 BigEYE   ; [GAZE, FLASH, GAZE, FLASH]
.byte $00,$00,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF, $FF,$FF,$FF,$FF,$FF ;15 BONE     ;
.byte $00,$00,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF, $FF,$FF,$FF,$FF,$FF ;16 R`BONE   ;
.byte $00,$00,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF, $FF,$FF,$FF,$FF,$FF ;17 CREEP    ;
.byte $00,$00,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF, $FF,$FF,$FF,$FF,$FF ;18 CRAWL    ;
.byte $00,$00,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF, $FF,$FF,$FF,$FF,$FF ;19 HYENA    ;
.byte $00,$40,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF, $05,$05,$05,$05,$FF ;1A CEREBUS  ; [SCORCH x4]
.byte $00,$00,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF, $FF,$FF,$FF,$FF,$FF ;1B OGRE     ;
.byte $00,$00,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF, $FF,$FF,$FF,$FF,$FF ;1C GrOGRE   ;
.byte $40,$00,$03,$0D,$05,$15,$1F,$FF,$FF,$FF,$FF, $FF,$FF,$FF,$FF,$FF ;1D WzOGRE   ; <RUSE, DARK, SLEP, HOLD, ICE2>
.byte $00,$00,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF, $FF,$FF,$FF,$FF,$FF ;1E ASP      ;
.byte $00,$00,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF, $FF,$FF,$FF,$FF,$FF ;1F COBRA    ;
.byte $00,$00,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF, $FF,$FF,$FF,$FF,$FF ;20 SeaSNAKE ;
.byte $00,$00,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF, $FF,$FF,$FF,$FF,$FF ;21 SCORPION ;
.byte $00,$00,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF, $FF,$FF,$FF,$FF,$FF ;22 LOBSTER  ;
.byte $00,$00,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF, $FF,$FF,$FF,$FF,$FF ;23 BULL     ;
.byte $00,$00,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF, $FF,$FF,$FF,$FF,$FF ;24 ZomBULL  ;
.byte $00,$00,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF, $FF,$FF,$FF,$FF,$FF ;25 TROLL    ;
.byte $00,$00,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF, $FF,$FF,$FF,$FF,$FF ;26 SeaTROLL ;
.byte $00,$00,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF, $FF,$FF,$FF,$FF,$FF ;27 SHADOW   ;
.byte $00,$00,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF, $FF,$FF,$FF,$FF,$FF ;28 IMAGE    ;
.byte $00,$00,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF, $FF,$FF,$FF,$FF,$FF ;29 WRAITH   ;
.byte $00,$00,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF, $FF,$FF,$FF,$FF,$FF ;2A GHOST    ;
.byte $00,$00,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF, $FF,$FF,$FF,$FF,$FF ;2B ZOMBIE   ;
.byte $00,$00,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF, $FF,$FF,$FF,$FF,$FF ;2C GHOUL    ;
.byte $00,$00,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF, $FF,$FF,$FF,$FF,$FF ;2D GEIST    ;
.byte $00,$00,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF, $FF,$FF,$FF,$FF,$FF ;2E SPECTER  ;
.byte $00,$00,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF, $FF,$FF,$FF,$FF,$FF ;2F WORM     ;
.byte $00,$40,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF, $06,$06,$06,$06,$FF ;30 Sand W   ; [CRACK x4]
.byte $00,$00,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF, $FF,$FF,$FF,$FF,$FF ;31 Grey W   ;
.byte $50,$50,$3F,$35,$2D,$16,$15,$09,$0F,$05,$FF, $02,$07,$03,$08,$FF ;32 EYE      ; <XXXX, BRAK, RUB, LIT2, HOLD, MUTE, SLOW, SLEP> [GLANCE, SQUINT, GAZE, STARE]
.byte $40,$40,$3D,$3E,$3B,$35,$2D,$15,$09,$0F,$FF, $09,$09,$09,$09,$FF ;33 PHANTOM  ; <STOP, ZAP!, XFER, BRAK, RUB, HOLD, MUTE, SLOW> [GLARE x4]
.byte $00,$00,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF, $FF,$FF,$FF,$FF,$FF ;34 MEDUSA   ;
.byte $00,$00,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF, $FF,$FF,$FF,$FF,$FF ;35 GrMEDUSA ;
.byte $00,$00,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF, $FF,$FF,$FF,$FF,$FF ;36 CATMAN   ;
.byte $60,$00,$14,$0F,$0D,$05,$04,$07,$00,$05,$FF, $FF,$FF,$FF,$FF,$FF ;37 MANCAT   ; <FIR2, SLOW, DARK, SLEP, FIRE, LIT, CURE, SLEP>
.byte $00,$00,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF, $FF,$FF,$FF,$FF,$FF ;38 PEDE     ;
.byte $00,$00,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF, $FF,$FF,$FF,$FF,$FF ;39 GrPEDE   ;
.byte $00,$00,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF, $FF,$FF,$FF,$FF,$FF ;3A TIGER    ;
.byte $00,$00,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF, $FF,$FF,$FF,$FF,$FF ;3B Saber T  ;
.byte $00,$20,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF, $17,$17,$17,$17,$FF ;3C VAMPIRE  ; [DAZZLE x4]
.byte $20,$20,$12,$09,$1F,$1F,$16,$16,$14,$14,$FF, $17,$17,$17,$17,$FF ;3D WzVAMP   ; <AFIR, MUTE, ICE2 x2, LIT2 x2, FIR2 x2> [DAZZLE x4]
.byte $00,$00,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF, $FF,$FF,$FF,$FF,$FF ;3E GARGOYLE ;
.byte $40,$00,$14,$15,$04,$04,$FF,$FF,$FF,$FF,$FF, $FF,$FF,$FF,$FF,$FF ;3F R`GOYLE  ; <FIR2, HOLD, FIRE x2>
.byte $00,$00,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF, $FF,$FF,$FF,$FF,$FF ;40 EARTH    ;
.byte $00,$00,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF, $FF,$FF,$FF,$FF,$FF ;41 FIRE     ;
.byte $00,$40,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF, $0A,$0A,$0A,$FF,$FF ;42 Frost D  ; [BLIZZARD x3]
.byte $00,$40,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF, $0B,$0B,$0B,$FF,$FF ;43 Red D    ; [BLAZE x3]
.byte $00,$00,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF, $FF,$FF,$FF,$FF,$FF ;44 ZombieD  ;
.byte $00,$00,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF, $FF,$FF,$FF,$FF,$FF ;45 SCUM     ;
.byte $00,$00,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF, $FF,$FF,$FF,$FF,$FF ;46 MUCK     ;
.byte $00,$00,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF, $FF,$FF,$FF,$FF,$FF ;47 OOZE     ;
.byte $00,$00,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF, $FF,$FF,$FF,$FF,$FF ;48 SLIME    ;
.byte $00,$00,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF, $FF,$FF,$FF,$FF,$FF ;49 SPIDER   ;
.byte $00,$00,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF, $FF,$FF,$FF,$FF,$FF ;4A ARACHNID ;
.byte $00,$40,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF, $16,$16,$16,$16,$FF ;4B MANTICOR ; [STINGER x4]
.byte $00,$00,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF, $FF,$FF,$FF,$FF,$FF ;4C SPHINX   ;
.byte $00,$00,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF, $FF,$FF,$FF,$FF,$FF ;4D R`ANKYLO ;
.byte $00,$00,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF, $FF,$FF,$FF,$FF,$FF ;4E ANKYLO   ;
.byte $00,$00,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF, $FF,$FF,$FF,$FF,$FF ;4F MUMMY    ;
.byte $00,$00,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF, $FF,$FF,$FF,$FF,$FF ;50 WzMUMMY  ;
.byte $00,$00,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF, $FF,$FF,$FF,$FF,$FF ;51 COCTRICE ;
.byte $00,$20,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF, $07,$07,$07,$07,$FF ;52 PERILISK ; [SQUINT x4]
.byte $00,$00,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF, $FF,$FF,$FF,$FF,$FF ;53 WYVERN   ;
.byte $00,$00,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF, $FF,$FF,$FF,$FF,$FF ;54 WYRM     ;
.byte $00,$00,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF, $FF,$FF,$FF,$FF,$FF ;55 TYRO     ;
.byte $00,$00,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF, $FF,$FF,$FF,$FF,$FF ;56 T REX    ;
.byte $00,$00,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF, $FF,$FF,$FF,$FF,$FF ;57 CARIBE   ;
.byte $00,$00,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF, $FF,$FF,$FF,$FF,$FF ;58 R`CARIBE ;
.byte $00,$00,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF, $FF,$FF,$FF,$FF,$FF ;59 GATOR    ;
.byte $00,$00,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF, $FF,$FF,$FF,$FF,$FF ;5A FrGATOR  ;
.byte $00,$00,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF, $FF,$FF,$FF,$FF,$FF ;5B OCHO     ;
.byte $00,$00,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF, $FF,$FF,$FF,$FF,$FF ;5C NAOCHO   ;
.byte $00,$00,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF, $FF,$FF,$FF,$FF,$FF ;5D HYDRA    ;
.byte $00,$40,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF, $0D,$0D,$FF,$FF,$FF ;5E R`HYDRA  ; [CREMATE x2]
.byte $00,$00,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF, $FF,$FF,$FF,$FF,$FF ;5F GAURD    ;
.byte $00,$00,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF, $FF,$FF,$FF,$FF,$FF ;60 SENTRY   ;
.byte $00,$00,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF, $FF,$FF,$FF,$FF,$FF ;61 WATER    ;
.byte $00,$00,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF, $FF,$FF,$FF,$FF,$FF ;62 AIR      ;
.byte $60,$00,$16,$15,$0F,$0D,$07,$06,$05,$07,$FF, $FF,$FF,$FF,$FF,$FF ;63 NAGA     ; <LIT2, LOCK, SLEP, LIT, LIT2, HOLD, SLOW, DARK>
.byte $60,$00,$03,$09,$0F,$0D,$05,$04,$07,$13,$FF, $FF,$FF,$FF,$FF,$FF ;64 GrNAGA   ; <RUSE, MUTE, SLOW, DARK, SLEP, FIRE, LIT, HEAL>
.byte $00,$40,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF, $0D,$0D,$0D,$FF,$FF ;65 CHIMERA  ; [CREMATE x3]
.byte $00,$40,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF, $0D,$0E,$0D,$0E,$FF ;66 JIMERA   ; [CREMATE, POISON, CREMATE, POISON]
.byte $00,$00,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF, $FF,$FF,$FF,$FF,$FF ;67 WIZARD   ;
.byte $00,$40,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF, $0F,$0F,$0F,$0F,$FF ;68 SORCERER ; [TRANCE x4]
.byte $00,$00,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF, $FF,$FF,$FF,$FF,$FF ;69 GARLAND  ;
.byte $00,$40,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF, $10,$10,$10,$FF,$FF ;6A Gas D    ; [POISON x3]
.byte $00,$40,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF, $11,$11,$11,$FF,$FF ;6B Blue D   ; [THUNDER x3]
.byte $20,$00,$1D,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF, $FF,$FF,$FF,$FF,$FF ;6C MudGOL   ; <FAST>
.byte $30,$00,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$FF, $FF,$FF,$FF,$FF,$FF ;6D RockGOL  ; <SLOW x8>
.byte $00,$10,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF, $12,$12,$12,$12,$FF ;6E IronGOL  ; [TOXIC x4]
.byte $20,$00,$3B,$3C,$3B,$3F,$37,$FF,$FF,$FF,$FF, $FF,$FF,$FF,$FF,$FF ;6F BADMAN   ; <XFER, NUKE, XFER, XXXX, BLND>
.byte $00,$00,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF, $FF,$FF,$FF,$FF,$FF ;70 EVILMAN  ;
.byte $60,$00,$2D,$27,$1D,$14,$16,$0F,$0D,$05,$FF, $FF,$FF,$FF,$FF,$FF ;71 ASTOS    ; <RUB, SLO2, FAST, FIR2, LIT2, SLOW, DARK, SLEP>
.byte $40,$00,$2D,$2C,$24,$25,$27,$24,$2F,$2C,$FF, $FF,$FF,$FF,$FF,$FF ;72 MAGE     ; <RUB, LIT3 ,FIR3 ,BANE, SLO2, FIR3, STUN, LIT3>
.byte $30,$00,$3A,$3B,$33,$2A,$2B,$30,$23,$20,$FF, $FF,$FF,$FF,$FF,$FF ;73 FIGHTER  ; <WALL, XFER, HEL3, FOG2, INV2, CUR4 ,HEL2, CUR3>
.byte $00,$00,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF, $FF,$FF,$FF,$FF,$FF ;74 MADPONY  ;
.byte $00,$20,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF, $13,$13,$13,$13,$FF ;75 NITEMARE ; [SNORTING x4]
.byte $00,$20,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF, $14,$14,$14,$14,$FF ;76 WarMECH  ; [NUCLEAR x4]
.byte $60,$00,$1F,$1C,$1D,$16,$15,$14,$0F,$05,$FF, $FF,$FF,$FF,$FF,$FF ;77 LICH     ; <ICE2, SLP2, FAST, LIT2, HOLD, FIR2, SLOW, SLEP>
.byte $60,$00,$3C,$3D,$3E,$3F,$3C,$3D,$3E,$3F,$FF, $FF,$FF,$FF,$FF,$FF ;78 LICH 2   ; <NUKE, STOP, ZAP!, XXXX>
.byte $30,$00,$14,$0D,$14,$0D,$14,$15,$14,$15,$FF, $FF,$FF,$FF,$FF,$FF ;79 KARY     ; <FIR2, DARK, FIR2, DARK, FIR2, HOLD, FIR2, HOLD>
.byte $30,$00,$24,$2D,$24,$2D,$24,$2F,$24,$2F,$FF, $FF,$FF,$FF,$FF,$FF ;7A KARY 2   ; <FIR3, RUB>
.byte $00,$20,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF, $15,$15,$15,$15,$FF ;7B KRAKEN   ; [INK x4]
.byte $30,$20,$16,$16,$16,$16,$16,$16,$16,$16,$FF, $15,$15,$15,$15,$FF ;7C KRAKEN 2 ; [INK x4]
.byte $00,$40,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF, $11,$10,$0A,$0B,$FF ;7D TIAMAT   ; [THUNDER, POISON, BLIZZARD, BLAZE]
.byte $40,$40,$25,$1F,$16,$14,$25,$1F,$16,$14,$FF, $11,$10,$0A,$0B,$FF ;7E TIAMAT 2 ; <BANE, ICE2, LIT2, FIR2, BANE, ICE2, LIT2, FIR2> [THUNDER, POISON, BLIZZARD, BLAZE]
.byte $40,$40,$34,$2C,$27,$30,$24,$1F,$1D,$3C,$FF, $06,$0C,$18,$19,$FF ;7F CHAOS    ; <ICE3, LIT3, SLO2, CUR4, FIR3, ICE2, FAST, NUKE> [CRACK, INFERNO, SWIRL, TORNADO]




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
;      1   2   3   4   5   6   7   8   9   10  11  12  13  14  15  16  17  18  19  20  21  22  23  24  25
.byte $06,$00,$06,$00,$08,$00,$6A,$00,$06,$04,$11,$02,$04,$01,$00,$00,$04,$10,$00,$00,$00,$05,$01,$01,$00 ;00 IMP
.byte $12,$00,$12,$00,$10,$00,$78,$00,$09,$06,$11,$04,$08,$01,$00,$00,$04,$17,$00,$00,$00,$08,$02,$01,$00 ;01 GrIMP
.byte $18,$00,$06,$00,$14,$00,$69,$00,$24,$00,$11,$05,$08,$01,$00,$00,$00,$1C,$00,$00,$00,$07,$01,$00,$00 ;02 WOLF
.byte $5D,$00,$16,$00,$48,$00,$6C,$00,$36,$00,$11,$12,$0E,$01,$00,$00,$00,$2E,$00,$00,$00,$09,$02,$00,$00 ;03 GrWolf
.byte $87,$00,$43,$00,$44,$00,$78,$04,$2A,$06,$11,$11,$0E,$01,$64,$04,$91,$2D,$00,$00,$01,$0C,$04,$00,$00 ;04 WrWolf
.byte $92,$01,$C8,$00,$5C,$00,$C8,$00,$36,$00,$11,$17,$19,$01,$00,$00,$00,$37,$10,$20,$20,$10,$0C,$00,$00 ;05 FrWOLF
.byte $99,$00,$32,$00,$5C,$00,$86,$00,$18,$0C,$11,$17,$12,$0A,$00,$00,$02,$37,$00,$00,$00,$05,$03,$00,$00 ;06 IGUANA
.byte $A8,$09,$B0,$04,$28,$01,$C8,$00,$24,$12,$12,$4A,$1F,$01,$00,$00,$02,$8F,$20,$10,$10,$0C,$02,$00,$00 ;07 AGAMA
.byte $B9,$07,$92,$02,$C4,$00,$C8,$00,$18,$14,$11,$36,$1E,$01,$00,$00,$02,$5B,$00,$00,$00,$10,$0B,$00,$00 ;08 SAURIA
.byte $6F,$03,$6F,$03,$F0,$00,$88,$00,$30,$0C,$11,$3C,$26,$01,$00,$00,$04,$78,$00,$00,$00,$0C,$10,$01,$00 ;09 GIANT
.byte $D8,$06,$D8,$06,$50,$01,$C8,$00,$30,$10,$11,$4E,$3C,$01,$00,$00,$04,$96,$10,$20,$20,$12,$1B,$01,$00 ;0A FrGIANT
.byte $E2,$05,$E2,$05,$2C,$01,$C8,$00,$30,$14,$11,$53,$49,$01,$00,$00,$04,$87,$20,$10,$10,$14,$16,$01,$00 ;0B R`GIANT
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
    LDA tmp+2        ; compare level (minimum of 1)
    CMP #1           ; to 1
    BEQ @SaveLevel   ; if its equal, don't decrease it
    DEC tmp+2

   @DecreaseLevel:
    LDA tmp+2        ; compare level (minimum of 1)
    CMP #1           ; to 1
    BEQ @SaveLevel   ; if its equal, don't decrease it
    DEC tmp+2

   @SaveLevel:
    LDA tmp+2
    LDY #en_level
    STA (EnemyRAMPointer), Y    ; save level -- this gives a little bit of randomness to level-based checks

   @NextEnemy:
    INC btl_loadenstats_index           ; inc up-counter to look at next enemy
    DEC btl_loadenstats_count           ; dec down-counter
    BEQ :+
      JMP @EnemyLoop    ; loop until all 9 enemies processed

   ;; JIGS - and now on to filling the enemy's AI RAM!!

  : LDA #0
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
;; First byte: item shop type, just like treasure chests
;; 0 - weapon
;; 1 - armor
;; 2-6 - magic
;; 7 - item
;; 8 - gold
;;
;; Second byte: item name; for gold, its the index for the money chests
;;

lut_StealList:
.byte $08, GOLD1      , $00, $00, $00, $00         ; 10 gold        ,      ,                 ; 00 IMP
.byte $01, ARM26      , $00, $00, $00, $00         ; cap            ,      ,                 ; 01 GrIMP
.byte $00, $00        , $00, $00, $00, $00         ; *              *      *                 ; 02 WOLF
.byte $00, $00        , $00, $00, $00, $00         ; *              *      *                 ; 03 GrWolf
.byte $00, $00        , $00, $00, $00, $00         ; *              *      *                 ; 04 WrWolf
.byte $00, $00        , $00, $00, $00, $00         ; *              *      *                 ; 05 FrWOLF
.byte $00, $00        , $00, $00, $00, $00         ; *              *      *                 ; 06 IGUANA
.byte $00, $00        , $00, $00, $00, $00         ; *              *      *                 ; 07 AGAMA
.byte $00, $00        , $00, $00, $00, $00         ; *              *      *                 ; 08 SAURIA
.byte $01, ARM11      , $00, $00, $00, $00         ; Copper bracelet,      ,                 ; 09 GIANT
.byte $01, ARM12      , $00, $00, $00, $00         ; Silver bracelet,      ,                 ; 0A FrGIANT
.byte $07, X_HEAL     , $00, $00, $00, $00         ; X_Heal         ,      ,                 ; 0B R`GIANT
.byte $07, HEAL       , $00, $00, $00, $00         ; Heal           ,      ,                 ; 0C SAHAG
.byte $07, PURE       , $00, $00, $00, $00         ; Pure           ,      ,                 ; 0D R`SAHAG
.byte $07, X_HEAL     , $00, $00, $00, $00         ; X_Heal         ,      ,                 ; 0E WzSAHAG
.byte $00, WEP8       , $00, $00, $00, $00         ; Scimitar       ,      ,                 ; 0F PIRATE
.byte $00, WEP15      , $00, $00, $00, $00         ; Falchion       ,      ,                 ; 10 KYZOKU
.byte $00, $00        , $00, $00, $00, $00         ; *              *      *                 ; 11 SHARK
.byte $00, $00        , $00, $00, $00, $00         ; *              *      *                 ; 12 GrSHARK
.byte $00, $00        , $00, $00, $00, $00         ; *              *      *                 ; 13 OddEYE
.byte $00, $00        , $00, $00, $00, $00         ; *              *      *                 ; 14 BigEYE
.byte $00, WEP3       , $00, $00, $00, $00         ; Wooden staff   ,      ,                 ; 15 BONE
.byte $00, WEP11      , $00, $00, $00, $00         ; Iron staff     ,      ,                 ; 16 R`BONE
.byte $00, $00        , $00, $00, $00, $00         ; *              *      *                 ; 17 CREEP
.byte $00, $00        , $00, $00, $00, $00         ; *              *      *                 ; 18 CRAWL
.byte $00, $00        , $00, $00, $00, $00         ; *              *      *                 ; 19 HYENA
.byte $00, $00        , $00, $00, $00, $00         ; *              *      *                 ; 1A CEREBUS
.byte $00, WEP5       , $00, $00, $00, $00         ; Iron hammer    ,      ,                 ; 1B OGRE
.byte $00, WEP18      , $00, $00, $00, $00         ; Silver hammer  ,      ,                 ; 1C GrOGRE
.byte $04, MG_ICE2    , $00, $00, $00, $00         ; Ice 2 scroll   ,      ,                 ; 1D WzOGRE
.byte $00, $00        , $00, $00, $00, $00         ; *              *      *                 ; 1E ASP
.byte $00, $00        , $00, $00, $00, $00         ; *              *      *                 ; 1F COBRA
.byte $00, $00        , $00, $00, $00, $00         ; *              *      *                 ; 20 SeaSNAKE
.byte $00, $00        , $00, $00, $00, $00         ; *              *      *                 ; 21 SCORPION
.byte $00, $00        , $00, $00, $00, $00         ; *              *      *                 ; 22 LOBSTER
.byte $08, GOLD13     , $00, $00, $00, $00         ; 240 gold -     ,      ,                 ; 23 BULL
.byte $03, MG_AICE    , $00, $00, $00, $00         ; AICE scroll    ,      ,                 ; 24 ZomBULL
.byte $08, GOLD14     , $00, $00, $00, $00         ; 255 gold       ,      ,                 ; 25 TROLL
.byte $08, GOLD31     , $00, $00, $00, $00         ; 880 gold       ,      ,                 ; 26 SeaTROLL
.byte $00, $00        , $00, $00, $00, $00         ; *              *      *                 ; 27 SHADOW
.byte $00, $00        , $00, $00, $00, $00         ; *              *      *                 ; 28 IMAGE
.byte $00, $00        , $00, $00, $00, $00         ; *              *      *                 ; 29 WRAITH
.byte $00, $00        , $00, $00, $00, $00         ; *              *      *                 ; 2A GHOST
.byte $01, ARM1       , $00, $00, $00, $00         ; Cloth T        ,      ,                 ; 2B ZOMBIE
.byte $08, GOLD5      , $00, $00, $00, $00         ; 55 gold        ,      ,                 ; 2C GHOUL
.byte $08, GOLD7      , $00, $00, $00, $00         ; 85 gold        ,      ,                 ; 2D GEIST
.byte $08, GOLD12     , $00, $00, $00, $00         ; 180 gold       ,      ,                 ; 2E SPECTER
.byte $00, $00        , $00, $00, $00, $00         ; *              *      *                 ; 2F WORM
.byte $00, $00        , $00, $00, $00, $00         ; *              *      *                 ; 30 Sand W
.byte $00, $00        , $00, $00, $00, $00         ; *              *      *                 ; 31 Grey W
.byte $00, $00        , $00, $00, $00, $00         ; *              *      *                 ; 32 EYE
.byte $00, $00        , $00, $00, $00, $00         ; *              *      *                 ; 33 PHANTOM
.byte $07, SOFT       , $00, $00, $00, $00         ; Soft           ,      ,                 ; 34 MEDUSA
.byte $07, SOFT       , $00, $00, $00, $00         ; Soft           ,      ,                 ; 35 GrMEDUSA
.byte $07, PURE       , $00, $00, $00, $00         ; Pure           ,      ,                 ; 36 CATMAN
.byte $04, MG_FIR2    , $00, $00, $00, $00         ; Fire 2 scroll  ,      ,                 ; 37 MANCAT
.byte $00, $00        , $00, $00, $00, $00         ; *              *      *                 ; 38 PEDE
.byte $00, $00        , $00, $00, $00, $00         ; *              *      *                 ; 39 GrPEDE
.byte $00, $00        , $00, $00, $00, $00         ; *              *      *                 ; 3A TIGER
.byte $00, $00        , $00, $00, $00, $00         ; *              *      *                 ; 3B Saber T
.byte $07, X_HEAL     , $00, $00, $00, $00         ; X_Heal         ,      ,                 ; 3C VAMPIRE
.byte $07, ETHER      , $00, $00, $00, $00         ; Ether          ,      ,                 ; 3D WzVAMP
.byte $00, $00        , $00, $00, $00, $00         ; *              *      *                 ; 3E GARGOYLE
.byte $00, $00        , $00, $00, $00, $00         ; *              *      *                 ; 3F R`GOYLE
.byte $07, SOFT       , $00, $00, $00, $00         ; Soft           ,      ,                 ; 40 EARTH
.byte $07, SMOKEBOMB  , $00, $00, $00, $00         ; Smokebomb      ,      ,                 ; 41 FIRE
.byte $08, GOLD39     , $00, $00, $00, $00         ; 2750 gold      ,      ,                 ; 42 Frost D
.byte $08, GOLD39     , $00, $00, $00, $00         ; 2750 gold      ,      ,                 ; 43 Red D
.byte $08, GOLD41     , $00, $00, $00, $00         ; 5000 gold      ,      ,                 ; 44 ZombieD
.byte $00, $00        , $00, $00, $00, $00         ; *              *      *                 ; 45 SCUM
.byte $00, $00        , $00, $00, $00, $00         ; *              *      *                 ; 46 MUCK
.byte $00, $00        , $00, $00, $00, $00         ; *              *      *                 ; 47 OOZE
.byte $00, $00        , $00, $00, $00, $00         ; *              *      *                 ; 48 SLIME
.byte $00, $00        , $00, $00, $00, $00         ; *              *      *                 ; 49 SPIDER
.byte $00, $00        , $00, $00, $00, $00         ; *              *      *                 ; 4A ARACHNID
.byte $08, GOLD33     , $00, $00, $00, $00         ; 1250 gold      ,      ,                 ; 4B MANTICOR
.byte $08, GOLD36     , $00, $00, $00, $00         ; 1760 gold      ,      ,                 ; 4C SPHINX
.byte $00, $00        , $00, $00, $00, $00         ; *              *      *                 ; 4D R`ANKYLO
.byte $00, $00        , $00, $00, $00, $00         ; *              *      *                 ; 4E ANKYLO
.byte $07, ALARMCLOCK , $00, $00, $00, $00         ; Alarm Clock    ,      ,                 ; 4F MUMMY
.byte $07, ALARMCLOCK , $00, $00, $00, $00         ; Alarm Clock    ,      ,                 ; 50 WzMUMMY
.byte $00, $00        , $00, $00, $00, $00         ; *              *      *                 ; 51 COCTRICE
.byte $00, $00        , $00, $00, $00, $00         ; *              *      *                 ; 52 PERILISK
.byte $08, GOLD32     , $00, $00, $00, $00         ; 1020 gold      ,      ,                 ; 53 WYVERN
.byte $08, GOLD33     , $00, $00, $00, $00         ; 1250 gold      ,      ,                 ; 54 WYRM
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
.byte $07, SMOKEBOMB  , $00, $00, $00, $00         ; Smokebomb      ,      ,                 ; 5F GAURD
.byte $07, SMOKEBOMB  , $00, $00, $00, $00         ; Smokebomb      ,      ,                 ; 60 SENTRY
.byte $00, $00        , $00, $00, $00, $00         ; *              *      *                 ; 61 WATER
.byte $00, $00        , $00, $00, $00, $00         ; *              *      *                 ; 62 AIR
.byte $00, $00        , $00, $00, $00, $00         ; *              *      *                 ; 63 NAGA
.byte $00, $00        , $00, $00, $00, $00         ; *              *      *                 ; 64 GrNAGA
.byte $00, $00        , $00, $00, $00, $00         ; *              *      *                 ; 65 CHIMERA
.byte $00, $00        , $00, $00, $00, $00         ; *              *      *                 ; 66 JIMERA
.byte $04, MG_LIT     , $00, $00, $00, $00         ; Bolt 2 scroll  ,      ,                 ; 67 WIZARD
.byte $07, ETHER      , $00, $00, $00, $00         ; Ether          ,      ,                 ; 68 SORCERER
.byte $00, WEP6       , $00, $00, $00, $00         ; Short sword    ,      ,                 ; 69 GARLAND
.byte $08, GOLD45     , $00, $00, $00, $00         ; 6720 gold      ,      ,                 ; 6A Gas D
.byte $08, GOLD47     , $00, $00, $00, $00         ; 7690 gold      ,      ,                 ; 6B Blue D
.byte $04, MG_FAST    , $00, $00, $00, $00         ; Fast scroll    ,      ,                 ; 6C MudGOL
.byte $04, MG_SLOW    , $00, $00, $00, $00         ; Slow scroll    ,      ,                 ; 6D RockGOL
.byte $01, ARM4       , $00, $00, $00, $00         ; Iron armor     ,      ,                 ; 6E IronGOL
.byte $01, ARM6       , $00, $00, $00, $00         ; Silver armor   ,      ,                 ; 6F BADMAN
.byte $00, WEP17      , $00, $00, $00, $00         ; Silver sword   ,      ,                 ; 70 EVILMAN
.byte $04, MG_RUB     , $00, $00, $00, $00         ; Rub scroll     ,      ,                 ; 71 ASTOS
.byte $06, ETHER      , $00, $00, $00, $00         ; Ether          ,      ,                 ; 72 MAGE
.byte $03, MG_FOG2    , $00, $00, $00, $00         ; Fog 2 scroll   ,      ,                 ; 73 FIGHTER
.byte $00, $00        , $00, $00, $00, $00         ; *              *      *                 ; 74 MADPONY
.byte $00, $00        , $00, $00, $00, $00         ; *              *      *                 ; 75 NITEMARE
.byte $07, ELIXIR     , $00, $00, $00, $00         ; Elixir         ,      ,                 ; 76 WarMECH
.byte $07, PHOENIXDOWN, $00, $00, $04, MG_QAKE     ; Phoenix Down   ,      , Quake scroll    ; 77 LICH
.byte $07, PHOENIXDOWN, $00, $00, $01, ARM23       ; Phoenix Down   ,      , Aegis Shield    ; 78 LICH (reprise)
.byte $04, MG_FIR3    , $00, $00, $01, ARM20       ; Fire 3 scroll  ,      , Flame Shield    ; 79 KARY
.byte $07, SMOKEBOMB  , $00, $00, $01, ARM32       ; Smokebomb      ,      , Ribbon          ; 7A KARY (reprise)
.byte $01, ARM14      , $00, $00, $01, ARM25       ; Opal bracelet  ,      , Protect Cape    ; 7B KRAKEN
.byte $07, ETHER      , $00, $00, $01, ARM38       ; Ether          ,      , Power Gauntlet  ; 7C KRAKEN (reprise)
.byte $07, ELIXIR     , $00, $00, $01, ARM10       ; Elixir         ,      , Dragon armor    ; 7D TIAMAT
.byte $07, ELIXIR     , $00, $00, $00, WEP40       ; Elixir         ,      , Masamune        ; 7E TIAMAT (reprise)
.byte $07, ELIXIR     , $00, $00, $07, PHOENIXDOWN ; Elixir         ,      , Elixer          ; 7F CHAOS

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


StealFromEnemy:
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
    STA shop_type            ; for gold to work
    TAX                      ; put it in X for the comparing
    INY
    LDA (tmp), Y
    STA btl_unformattedstringbuf+3
    ;; pulling this before the compare saves having to do it 4 different times!

    CPX #SHOP_WHITEMAGIC     ; 0-1 = equipment
    BCC @Equipment
    CPX #SHOP_ITEM           ; 2-5 = magic
    BCC @Magic
    BEQ @Items               ; 6 = item

   ;; if it didn't branch to magic or items, its gotta be gold!
    JSR LoadPrice_Long               ; get the price of the item (the amount of gold stolen)
    JMP AddGPToParty                 ; add that to the party's GP

   @Equipment:
    TAX                              ; backup the item ID in X
    JSR Set_Inv_Weapon
    LDA #$0D
    STA btl_unformattedstringbuf+2   ; here, re-write the item name byte with equipment name byte
    BNE :+

   @Magic:
    TAX
    LDA #$0F
    STA btl_unformattedstringbuf+4  ; set another message control code
    LDA #BTLMSG_SCROLL
    STA btl_unformattedstringbuf+5  ; and put _scroll at the end of the message
    JSR Set_Inv_Magic

  : TXA                             ; put the item ID back into A
    JSR ADD_ITEM
    BCC :+
        JMP @Fail_NoPush            ; can't carry any more of that spell/equipment
  : RTS

    ;; JIGS - how could I cap magic at 9 here...?

   @Items:
    TAX
    LDA items, X
    CMP #99
    BNE :+
        JMP @Fail_NoPush            ; can't carry any more of that item
  : INC items, X
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
    LDA battle_attackerisplayer
    BEQ @NoMessage                  ; don't do any of these if confusedly attacking another character

    LDA btl_attacker
    JSR PrepCharStatPointers
    LDY #ch_speed - ch_stats        ;
    LDA (CharStatsPointer), Y       ; get speed (luck) \ 2
    LSR A
    LDX #200                        ;
    JSR RandAX                      ; Random number between luck/2 and 200
    CMP #180                        ; Gotta roll over 180 to do the thing
    BCC @NoMessage

    LDX #0
    LDA btl_attacker_critperks
    LSR A
    BCS @CritAilment
    INX
    LSR A
    BCS @CriticalUp
    INX
    LSR A
    BCS @CritAilment
    INX
    LSR A
    BCS @CritAilment
    INX
    LSR A
    BCS @CritAilment
    INX
    LSR A
    BCS @CritStrengthUp
    INX
    LSR A
    BCS @CritSlow
    INX
    LSR A
    BCS @CritAilment

   @NoMessage:
    LDX #0
   @CritReturn:
    LDA @CritMessages_LUT, X
    STA MMC5_tmp
    RTS

   @CriticalUp:
    LDA #<btl_charweaponcritrate
    STA tmp
    LDA #>btl_charweaponcritrate
    BNE :+

   @CritStrengthUp:
    LDA #<btl_chardamage
    STA tmp
    LDA #>btl_chardamage
  : STA tmp+1
    BNE @StatUp

   @CritSlow:
    LDY #en_numhitsmult
    LDA (EnemyRAMPointer), Y        ; hit multiplier from RAM stats
    STA tmp+7
    DEC tmp+7                       ; Decrease their hit multiplier
    LDA tmp+7
    BEQ @NoMessage                  ; if it went to 0, don't save it

    STA (EnemyRAMPointer), Y
    BNE @CritReturn

   @CritAilment:
    LDA btl_defender_statusresist
    AND btl_attacker_critperks
    BNE @NoMessage

    BIT btl_defender_ailments    ; do a bit check to see if the enemy has this ailment already
    BNE @NoMessage

    ORA btl_defender_ailments
    STA btl_defender_ailments
    BNE @CritReturn

   @StatUp:
    TXA
    PHA
    LDY BattleCharID
    LDX #2
   @StatUp_Loop:
    LDA (tmp), Y
    CLC
    ADC #4
    BCC :+
        LDA #$FF
  : STA (tmp), Y
    INY
    INY
    INY
    INY
    DEX
    BNE @StatUp_Loop

    PLA
    TAX
    BNE @CritReturn

   @CritMessages_LUT:
    .byte $00
    .byte BTLMSG_CRITUP
    .byte BTLMSG_POISONED
    .byte BTLMSG_DARKNESS
    .byte BTLMSG_PARALYZED
    .byte BTLMSG_WEAPONSSTRONGER
    .byte BTLMSG_LOSTINTELLIGENCE
    .byte BTLMSG_CONFUSED





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

    LDA btl_attacker_perks
    AND #STEALTHY
    BNE @HiddenBoost
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

    AND #$03
    STA tmp                        ; backup for possible btl_defender_index
    ORA #$80
    CMP btl_attacker               ; get the knight doing the covering
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
    LDA btl_charcover, X
    SEC
    SBC #$10
    BPL :+
      LDA #0                       ; if it wrapped to $Fx, set it to 0--no more cover for this character!
  : STA btl_charcover, X           ; subtract $10 from however many defending attempts are left

    INC attackblocked              ; set to 1
    LDA btl_defender_index         ; get the original target
    ORA #$80                       ; convert to ID
    STA btl_defender
    ;; important to note: this is used by the DefenderBox drawing thing, but not really used for players otherwise!
    ;; everything else uses btl_defender_index... so btl_defender is now the ORIGINAL target

    LDA tmp                        ; get the knight doing the covering
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
    LDA btl_charhidden, X  ; get the first action

    LDY #7
   @BattleActionsLoop:
    INX                    ; add 4 to check the next buffer
    INX
    INX
    INX
    ORA btl_charhidden, X
    DEY
    BNE @BattleActionsLoop

    CMP #0
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
.byte btl_attacker_ailments - btl_attacker,       ch_ailments - ch_stats
.byte btl_attacker_perks - btl_attacker,          ch_attackperks - ch_stats
.byte btl_attacker_critperks - btl_attacker,      ch_critperks - ch_stats

PlayerAttackerBattleStats_LUT:
.byte btl_attacker_hitrate - btl_attacker
.byte btl_attacker_damage - btl_attacker
.byte btl_attacker_critrate - btl_attacker
.byte btl_attacker_attackailment - btl_attacker
.byte btl_attacker_ailmentchance - btl_attacker
.byte btl_attacker_element - btl_attacker
.byte btl_attacker_category - btl_attacker
.byte btl_attacker_graphic - btl_attacker
.byte btl_attacker_varplt - btl_attacker
.byte btl_attacker_numhits - btl_attacker

PlayerDefenderStats_LUT:
.byte btl_defender_ailments - btl_attacker,         ch_ailments - ch_stats
.byte btl_defender_hp - btl_attacker,               ch_curhp - ch_stats
.byte btl_defender_hp+1 - btl_attacker,             ch_curhp+1 - ch_stats
.byte btl_defender_perks - btl_attacker,            ch_defendperks - ch_stats

PlayerDefenderBattleStats_LUT:
.byte btl_defender_statusresist - btl_attacker
.byte btl_defender_elementweakness - btl_attacker
.byte btl_defender_evasion - btl_attacker
.byte btl_defender_defense - btl_attacker
.byte btl_defender_magicdefense - btl_attacker
.byte btl_defender_elementresist - btl_attacker

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

  : LDA AutoTarget
    BEQ @SkipAutoTarget

    JSR CheckTargetLoop             ; JIGS - doublecheck the enemy you're attacking exists!

   @SkipAutoTarget:
    STX btl_defender_index       ; set defender index
    STX btl_defender

    TXA
    JSR GetEnemyRAMPtr

    ;;;;;;;;;;;;;;;;;;;;;;;;
    ;; Attacker/PLAYER stats

    LDX #6
   @Loop:
    LDY PlayerAttackerStats_LUT-1, X
    LDA (CharStatsPointer), Y
    DEX
    LDY PlayerAttackerStats_LUT-1, X
    STA btl_attacker, Y
    DEX
    BNE @Loop

    STX tmp+9        ; = 0
    STX battle_defenderisplayer
    INX
    STX battle_attackerisplayer

    JSR PlayerAttackerAttackStats

    LDA btl_charrush, X
    BEQ :+
        LDA btl_attacker_hitrate
        LSR A
        LSR A
        LSR A
        STA tmp
        ASL A                    ; hit rate / 4
        CLC                      ; + hit rate / 8
        ADC tmp
        STA btl_attacker_hitrate ; somewhere between 25% and 50% ?

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

    LDX #6
   @Loop:
    LDY PlayerAttackerStats_LUT-1, X
    LDA (CharStatsPointer), Y
    DEX
    LDY PlayerAttackerStats_LUT-1, X
    STA btl_attacker, Y
    DEX
    BNE @Loop

    STX tmp+9        ; = 0
    INX
    STX battle_attackerisplayer
    STX battle_defenderisplayer

    JSR PlayerAttackerAttackStats

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



PlayerAttackerAttackStats:
    LDA #<btlstats_weaponstats
    STA WeaponPointer
    LDA #>btlstats_weaponstats
    STA WeaponPointer+1

    LDA DualAttack
    BEQ :+
     LDA #4
     STA tmp+9       ; offset for second weapon

  : LDX #9
   @BattleStatsLoop: ; for this its stat * 4 + character ID
    TXA
    ASL A
    ASL A
    ASL A
    CLC
    ADC BattleCharID
    ADC tmp+9
    TAY
    LDA (WeaponPointer), Y
    LDY PlayerAttackerBattleStats_LUT, X
    STA btl_attacker, Y
    DEX
    BPL @BattleStatsLoop

    LDX BattleCharID
    LDA btl_charhitmult, X
    STA btl_attacker_numhitsmult
    RTS


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

    STX btl_attacker_perks          ; enemy has no perks, and also thus can't be hidden
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

    JSR CoverStuff               ; if this character is defended by Cover, swap btl_defender ID to the knight

PlayerDefenderStats:
    LDA #<btlstats_defensestats
    STA CharStatsPointer
    LDA #>btlstats_defensestats
    STA CharStatsPointer+1

    LDX #5
   @BattleStatsLoop: ; for this its stat * 4 + character ID
    TXA
    ASL A
    ASL A
    CLC
    ADC btl_defender_index
    TAY
    LDA (CharStatsPointer), Y
    LDY PlayerDefenderBattleStats_LUT, X
    STA btl_defender, Y
    DEX
    BPL @BattleStatsLoop

    LDA btl_defender_index
    JSR PrepCharStatPointers        ; get pointer to char stats

    LDX #8
   @Loop:
    LDY PlayerDefenderStats_LUT-1, X
    LDA (CharStatsPointer), Y
    DEX
    LDY PlayerDefenderStats_LUT-1, X
    STA btl_attacker, Y
    DEX
    BNE @Loop

    STX btl_defender_category

    LDX btl_defender_index
    LDA btl_charguard, X          ; check battlestate for Guarding
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






























































;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  LvlUp_AdjustBBSubStats  [$9966 :: 0x2D976]
;;
;;  Adjusts post level up substats for Black Belts / Masters
;;
;;  input:  lvlup_chstats should be prepped
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;LvlUp_AdjustBBSubStats:
;    LDY #ch_class - ch_stats        ; check to make sure this is a BB/Master
;    LDA (lvlup_chstats), Y
;    CMP #CLASS_BB
;    BEQ :+
;    CMP #CLASS_MA
;    BEQ :+                          ; if yes, jump ahead, otherwise just exit
;  @Exit:
;    RTS
;
;  : LDY #ch_righthand - ch_stats    ; see if they have any weapon equipped.
;    LDA (lvlup_chstats), Y          ; check all 4 weapon slots, if any of them have an
;    BEQ @Exit                       ; equipped weapon, exit
;
;    LDY #ch_level - ch_stats        ; reaches here if no weapon equipped.  Get the level
;    LDA (lvlup_chstats), Y          ;  Add 1 to make it 1-based
;    CLC
;    ADC #$01
;    ASL A
;    LDY #ch_damage - ch_stats          ; Damage = 2*Level
;    STA (lvlup_chstats), Y
;
;    ;JIGS - doing the armour thing properly?
;
;    LDY #ch_head - ch_stats
;    LDA (lvlup_chstats), Y
;    BEQ @Exit
;    LDY #ch_body - ch_stats
;    LDA (lvlup_chstats), Y
;    BEQ @Exit
;    LDY #ch_hands - ch_stats
;    LDA (lvlup_chstats), Y
;    BEQ @Exit
;    LDY #ch_accessory - ch_stats
;    LDA (lvlup_chstats), Y
;    BEQ @Exit
;
;    LDY #ch_level - ch_stats        ; reaches here if no armor equipped.  Get the level
;    LDA (lvlup_chstats), Y          ;  Add 1 to make it 1-based
;    CLC
;    ADC #$01
;    ASL A
;    LDY #ch_defense - ch_stats
;    STA (lvlup_chstats), Y
;    RTS

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  SubtractOneFromVal  [$9999 :: 0x2D9A9]
;;
;;  input:  $80 points to desired value
;;
;;    Subtracts 1 from the 1-byte value stored at the given pointer.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

SubtractOneFromVal:
    LDY #$00            ; self explanitory

    LDA (LevelUp_Pointer), Y
    SEC
    SBC #$01
    STA (LevelUp_Pointer), Y

    RTS



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  DoCrossPageJump  [$99A8 :: 0x2D9B8]
;;
;;  input:
;;     A = ID of the routine to jump to on bank C
;;
;;    The given ID must be a multiple of 3 (0, 3, 6, 9, etc), as this jumps to a '_L' jump
;;  list on the bank.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

DoCrossPageJump:
    CLC
    ADC #<BankC_CrossBankJumpList
    STA btltmp+6
    LDA #$00
    ADC #>BankC_CrossBankJumpList
    STA btltmp+7
    LDA #$0C
    JMP BattleCrossPageJump_L


BattleOver_ProcessResult_L:         JMP BattleOver_ProcessResult

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  GetJoyInput  [$9A06 :: 0x2DA16]
;;
;;  Joypad input is loaded into btl_input as well as A
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

GetJoyInput:
    LDY #$01            ; strobe controller
    STY $4016
    DEY
    STY $4016

    LDY #$08            ; Loop 8 times (for each button)
  @Loop:
      LDA $4016         ; get button input
      LSR A             ; shift bit 0 into C
      BCS :+            ; if clear.. shift bit 1 into C
        LSR A           ;   (this is to support detachable Famicom controllers which have button state in bit 1)

    : ROR btl_input     ; Roll C into btl_input
      DEY
      BNE @Loop         ; loop for all 8 buttons

    LDA btl_input       ; put input in A
    RTS                 ; and exit!







;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Shift6TAX   [$9A69 :: 2DA79]
;;
;;    Shifts A left by 6 (multiply by 64), then TAX
;;  This is commonly used to Convert a 0-based character ID to a usable index for looking
;;  up character stats.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

Shift6TAX:
    ASL A
    ASL A
    ASL A
    ASL A
    ASL A
    ASL A
    TAX
    RTS



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  BattleOver_ProcessResult  [$9AC0 :: 0x2DAD0]
;;
;;    Does all the end-of-battle stuff (except for cheering animation
;;  which is done in bank C)
;;
;;    At this point it is assumed btl_result is nonzero.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

BattleOver_ProcessResult:
    LDA #BANK_THIS              ; set callback bank for music
    STA cur_bank

     DEC ch_level
     DEC ch_level+$40
     DEC ch_level+$80
     DEC ch_level+$C0

    LDA btl_result              ; check the result
    CMP #$03
    BEQ BattleOver_Run          ; did they run?
    CMP #$01
    BEQ GameOver                ; were they defeated?

    ; otherwise, they're victorious!
    ;  Note that the party has already done their cheering animation, and the fanfare
    ;  music is already playing.

    LDA btlformation      ; check the formation ID
    CMP #$7B                ; $7B is Chaos's formation
    BNE :+                  ; if we just killed Chaos....
      LDA #$FF                  ; set btl_result to $FF to create a dramatic pause after fadeout
      STA btl_result
      JSR ChaosDeath            ; do the fancy dissolve effect
      JMP ExitBattle            ; then exit battle
                                ;  (note that no GP/EXP is awarded for battle $7B)

  : JSR EndOfBattleWrapUp   ; otherwise (not Chaos), award Gp/Exp and stuff
    JMP ExitBattle          ; then exit battle

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  BattleOver_Run  [$9AEB :: 0x2DAFB]
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

BattleOver_Run:
    LDA battlesrun
    CMP #$FF
    BEQ :+
       INC battlesrun

  : JSR Battle_FlipAllChars         ; Flip all chars so they look like they're running away.
  ; JMP ExitBattle                  ; <- Flow into ExitBattle to return to the main game.

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  ExitBattle  [$9AEE :: 0x2DAFE]
;;
;;    Called when battle is over.  Fades out and does other end-of-battle stuff.
;;  Actually this routine just passes the buck to 'ExitBattle' in bank C.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

ExitBattle:
    PLA                         ; current return address is to BattleLogicLoop in bank C
    PLA                         ; drop that -- new return address is to whatever called EnterBattle.
    LDA #$00                    ;   That is... when this routine exits, it will return to whoever called EnterBattle
    JMP DoCrossPageJump         ; jump to ExitBattle_L in bank C

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  GameOver  [$9AF5 :: 0x2DB0E]
;;
;;    Called when the party has been defeated.  YOU LOSE MOFO!!!
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

GameOver:
    LDA #$52
    STA music_track           ; Play the sad "game over" music
    STA btl_followupmusic

  ;  LDA #$00
  ;  STA btl_boxcount          ; reset combat box count

    LDA #BOX_MESSAGE            ; draw the "Party Perished" text
    LDX #$09                    ;  in combat box 4 (bottom/wide one)
    JSR DrawEOBCombatBox

    JSR WaitForAnyInput                     ; wait for user to press any button
    JSR RespondDelay_UndrawAllCombatBoxes   ; then undraw "Party Perished" box
    LDA #$03                    ; Fade out, and restart the game
    JMP DoCrossPageJump         ; jump to BattleFadeOutAndRestartGame_L

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  EndOfBattleWrapUp  [$9B14 :: 0x2DB24]
;;
;;    Gives GP/Exp rewards for a victorious battle, levels up
;;  characters when appropriate, and displays all the necessary crap
;;  on screen
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

EndOfBattleWrapUp:
   ; LDA #$00
   ; STA btl_boxcount          ; clear combat box count

   ; TAX
    LDX #0
    LDA #BOX_MESSAGE
    JSR DrawEOBCombatBox            ; draw "mosters perished" in combat box 4

    JSR WaitForAnyInput                     ; wait for the user to press any button
    JSR RespondDelay_UndrawAllCombatBoxes   ; then delay and undraw all boxes

    LDY #en_exp                 ; get the EXP reward for this battle
    JSR SumBattleRewardEXP
    JSR DivideRewardBySurvivors ; divide that reward by the number of surviving players

    LDA battlereward
    STA eob_exp_reward
    LDA battlereward+1          ; store reward in eob_exp_reward
    STA eob_exp_reward+1

    ORA battlereward            ; OR high/low bytes to see if reward was zero
    BNE :+                      ; if it was...
      INC eob_exp_reward        ;   ... inc it.  Minimum of 1 EXP for reward.

  : LDY #en_gp                  ; get the GP reward and store it in eob_gp_reward for it to be printed
    JSR SumBattleRewardGP         ; this is *kind of* bugged, as the game will properly award a 3-byte
    LDA battlereward            ;   GP value, but only 2 bytes will be printed.  So if you somehow
    STA eob_gp_reward           ;   receive over $FFFF GP in a single battle, it will be awarded properly,
    LDA battlereward+1          ;   but the reward will not be printed correctly.  But... this isn't really
    STA eob_gp_reward+1         ;   a bug as much as it's just a limitation.

    LDA #<gold
    STA LevelUp_Pointer
    LDA #>gold
    STA LevelUp_Pointer+1

    JSR GiveRewardToParty

   ; LDA #$00                    ; Draw 4 EoB boxes.
   ; STA eobbox_slotid           ;  Exp Up  |  ####P
    LDA #$01                    ;  Gold    |  ####G
    STA eobbox_textid
    JSR Draw4EobBoxes

    JSR WaitForAnyInput                         ; wait for input
    JSR RespondDelay_UndrawAllCombatBoxes       ; then delay, and undraw

    LDA #$00                    ; award XP to all 4 party members
    JSR LvlUp_AwardExp
    LDA #$01
    JSR LvlUp_AwardExp
    LDA #$02
    JSR LvlUp_AwardExp
    LDA #$03
    JMP LvlUp_AwardExp



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  data_MaxRewardPlusOne  [$99A3 :: 0x2D9B3]
;;    note that this is actually 1 higher than the max for some reason...
;;  Also note this name is slightly misleading.  It's not the maximum reward, it's the
;;  maximum value you can have AFTER being rewarded.  Effectively it is the GP/XP cap.

data_MaxRewardPlusOne:
  .FARADDR 1000000          ; 'FARADDR' stores a 3-byte value  (even though this isn't an addr)

data_MaxHPPlusOne:          ; 99A6
  .WORD 1000                ; max HP + 1







;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  LvlUp_AwardExp  [$9BB0 :: 0x2DBC0]
;;
;;  input:  A = ID of character to reward
;;
;;  Gives Exp to a single party member, and levels them up (once) if necessary
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

LvlUp_AwardExp:
    ORA #$80                        ; set this char as the 'attacker'
    STA btl_attacker                ;  (this is used to print their name when they level up)

    ASL A
    TAY

    LDA lut_CharStatsPtrTable, Y    ; get their stat pointer
    STA lvlup_chstats
    LDA lut_CharStatsPtrTable+1, Y
    STA lvlup_chstats+1

    LDY #ch_ailments - ch_stats     ; check their ailments
    LDA (lvlup_chstats), Y
    AND #$03                        ; isolate bit 1 and 2 = dead and stone
    BEQ :+                          ; no ailments = reward
      RTS                           ; anything else (stone or dead) = exit without getting a reward

  : LDA eob_exp_reward              ; move the exp reward back into battlereward
    STA battlereward
    LDA eob_exp_reward+1
    STA battlereward+1

    JSR LvlUp_GetCharExp            ; get this char's exp pointer
    JSR GiveRewardToParty           ; add the exp reward to it

        ; <-- "jump here" point  (see end of LvlUp_LevelUp for explanation of this note)

  ;  JSR LvlUp_GetExpToAdvance       ; Get exp to advance
    LDY #3 - 1                      ; compare 3 bytes (LevelUp_Pointer to lvlup_exptoadv)
    JSR MultiByteCmp

    BCS LvlUp_LevelUp               ; if curexp >= exptoadvance, LEVEL UP

  LvlUp_AwardExp_RTS:
    RTS                             ; otherwise, exit

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  LvlUp_GetCharExp  [$9BF3 :: 0x2DC03]
;;
;;  input:   lvlup_chstats
;;  output:  LevelUp_Pointer
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

LvlUp_GetCharExp:
    LDA lvlup_chstats                 ; self explanitory
    CLC
    ADC #ch_exp - ch_stats
    STA LevelUp_Pointer ; $80

    LDA #$00
    ADC lvlup_chstats+1
    STA LevelUp_Pointer+1 ; $81
    RTS

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  LvlUp_GetExpToAdvance  [$9C01 :: 0x2DC11]
;;
;;  input:   lvlup_chstats
;;  output:  LevelUp_Reward = points to 3-byte value containing total Exp required to advance
;;
;;    Gives nonsense if character is at level 50
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;LvlUp_GetExpToAdvance:
;    LDY #ch_level - ch_stats    ; get their level
;    LDA (lvlup_chstats), Y
;    ASL A
;    CLC
;    ADC (lvlup_chstats), Y      ; A = level*3
;
;    ADC #<lut_ExpToAdvance      ; Add to address of exp LUT
;    STA LevelUp_Reward          ; $82
;
;    LDA #$00
;    ADC #>lut_ExpToAdvance
;    STA LevelUp_Reward+1        ; $83
;
;    RTS

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  LvlUp_LevelUp  [$9C14 :: 0x2DC24]
;;
;;  input:   LevelUp_Pointer, lvlup_chmagic, and lvlup_chstats
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

LvlUp_LevelUp:
;    LDY #ch_level - ch_stats        ; check to see if they're are the max level
;    LDA (lvlup_chstats), Y          ; level 50 is max (-1 because OB level is stored 0-based
;    CMP #50 - 1                     ;   so it'd actually be stored as 49)
;    BEQ LvlUp_AwardExp_RTS          ; if at max level, branch to a nearby RTS
;
;
;   ; LevelUp_LevelIndex         @levindex = $6BAD       ; local, stores the index to level up stats
;   ; LevelUp_Pointer            @lvlupptr = $82         ; local, pointer to level up data
;   ; LevelUp_ClassID            @classid  = $688E       ; local, stores class ID
;
;    STA LevelUp_LevelIndex          ; record old level
;
;    CLC                             ; add 1
;    ADC #1
;    STA (lvlup_chstats), Y          ; change actual player stat
;    STA eobtext_print_level         ; and write to the print space in RAM so it can be drawn later
;                                    ;  (note that this will need to be INC'd later since it is 0-based now
;                                    ;   and we'd want to print it as 1-based)
;
;    LDY #ch_class - ch_stats
;    LDA (lvlup_chstats), Y
;    ASL A
;    TAY                             ; put 2* class ID in Y (to use as index)
;
;    ASL LevelUp_LevelIndex              ; double level index (2 bytes of data per level per class)
;
;    LDA lut_LevelUpDataPtrs, Y      ; calc the pointer to the level up data for this level for
;    CLC                             ;   this class.
;    ADC LevelUp_LevelIndex
;    STA LevelUp_Pointer
;    LDA lut_LevelUpDataPtrs+1, Y
;    ADC #$00
;    STA LevelUp_Pointer+1                 ; @lvlupptr now points to the 2-byte level up data to use
;
;    LDA #$00
;    STA eobtext_print_level+1       ; clear high-byte of print level
;    INC eobtext_print_level         ; convert print level to 1-based (it is now OK to print)
;
;    LDX #$00
;    LDA (lvlup_chstats, X)          ; get the first byte of chstats (happens to be class ID)
;    AND #$0F                        ;; JIGS - cut off high bits again
;    STA LevelUp_ClassID                    ; store class ID
;    TAX                             ; and throw it in X to use as index
;
;    ;;---- start assigning bonuses
;    LDY #ch_hitrate - ch_stats      ; assign Hit Rate bonus
;    LDA (lvlup_chstats), Y
;    CLC
;    ADC lut_LvlUpHitRateBonus, X
;    JSR CapAAt200                   ; cap hit rate at 200
;    STA (lvlup_chstats), Y
;
;    LDY #ch_magicdefense - ch_stats       ; assign Magic Defense bonus
;    LDA (lvlup_chstats), Y
;    CLC
;    ADC lut_LvlUpMagDefBonus, X
;    JSR CapAAt200                   ; cap at 200
;    STA (lvlup_chstats), Y
;
;    ;;---- increase spell charges!
;
;    ;; JIGS - edited to use ch_stats and for current and max MP being in the same byte
;
;   ; LDA LevelUp_ClassID
;   ; BEQ @SkipMPGain                 ; skip MP increase for Fighters (class 0)
;   ; CMP #CLS_TH                     ; and thieves.  This is necessary because
;   ; BEQ @SkipMPGain                 ; Knights/Ninjas get magic, and they share the same data.
;   ;; JIGS - they do not share the same data now
;
;    LDY #$01
;    LDA (LevelUp_Pointer), Y              ; get leveldata[1] byte (MP gains)
;    LDY #ch_mp - ch_stats           ; set Y to index max MP
;   @MagicUpLoop:
;      LSR A                         ; shift out low bit
;      BCC :+                        ; if set...
;        PHA
;        LDA (lvlup_chstats), Y        ; increase max MP for this level by 1
;        CLC
;        ADC #$01
;        STA (lvlup_chstats), Y
;        PLA
;    : INY                               ; INY to look at next spell level
;      CPY #ch_mp - ch_stats + 8  ; loop for all 8 bits (and all 8 spell levels)
;      BNE @MagicUpLoop
;
;    ;;---- Cap spell charges at a maximum
;    LDA LevelUp_ClassID            ; check the class
;    CMP #CLASS_KN
;    BEQ :+
;    CMP #CLASS_NJ
;    BEQ :+                  ; Knights/Ninjas cap at 4 MP
;        LDA #9+1            ;  all other classes cap at 9 MP
;        BNE :++
;  : LDA #4+1                ;(KN/NJ jumps here)
;
;    ;  At this point, A = max_charges+1
;  : LDY #ch_mp - ch_stats           ; similar loop as above
;    STA MMC5_tmp
;  @MagicCapLoop:
;      LDA (lvlup_chstats), Y   ; MP byte
;      AND #$0F                 ; destroy high bit (current mp)
;      CMP MMC5_tmp             ; see if MP max is == one beyond max
;      BCC :+                                ; if it is...
;        LDA (lvlup_chstats), Y              ; ... decrease it by one to cap it
;        SEC
;        SBC #$01
;        STA (lvlup_chstats), Y
;    : INY                                   ; repeat for all 8 spell levels
;      CPY #ch_mp - ch_stats + 8
;      BNE @MagicCapLoop
;
;    ;; JIGS - hopefully that sorts it out.
;
;
;  @SkipMPGain:      ; jumps here for fighters/thieves (prevent them from getting MP)
;
;    ;;---- Record stat byte
;                ;@statbyte = $688E   ; local, the stat gains byte from the level up data
;    LDY #$00
;    LDA (LevelUp_Pointer), Y              ; get leveldata[0] byte (other stat gains)
;    STA LevelUp_StatByte                   ; record it!
;
;    ;;---- HP gain
;    LDY #ch_vitality - ch_stats  ; Base HP gain depends on vitality
;    LDA (lvlup_chstats), Y
;    LSR A
;    LSR A
;    CLC
;    ADC #$01                ; Vit/4 + 1
;    PHA                     ;  (push it for later)
;
;    LDA LevelUp_StatByte           ; check the stat byte
;    AND #$20                ; see if the "strong" bit is set
;    BEQ :+                  ; if this is a strong level....
;      LDA #20               ;   get an additional HP bonus of rand[20,25]
;      LDX #25
;      JSR RandAX
;      JMP :++
;  : LDA #$00                ; for non-strong levels, no extra bonus
;
;  : STA tmp+6               ; store strong bonus in scratch ram
;    PLA                     ; pull base HP gain
;    CLC
;    ADC tmp+6               ; add with strong bonus
;    STA battlereward        ; record HP bonus as battle reward
;    LDA #$00
;    STA battlereward+1      ; (zero high byte of battle reward)
;    STA battlereward+2
;
;    LDA lvlup_chstats       ; set $80 to point to character's Max HP
;    CLC
;    ADC #ch_maxhp - ch_stats
;    STA LevelUp_Pointer
;    LDA lvlup_chstats+1
;    ADC #$00
;    STA LevelUp_Pointer+1
;
;    JSR GiveHpBonusToChar   ; Finally, apply the HP bonus!
;
;    ;;---- other stat gains (str/vit/etc)
;    ; LevelUp_LoopCounter              @loopctr = $6856
;    ; LevelUp_StatIndex                @statidx = $6858
;    ; LevelUp_StatBuffer               @statupbuffer = $6AAC ; 5 bytes indicating which stats have been incrased
;
;    ASL LevelUp_StatByte               ; drop the high 3 bits of the stat byte, other bits
;    ASL LevelUp_StatByte              ;   will be shifted out the high end
;    ASL LevelUp_StatByte
;
;    LDA #$00                    ; zero our loop counter
;    STA LevelUp_LoopCounter
;    LDA #ch_strength - ch_stats      ; and initialize our stat index
;    STA LevelUp_StatIndex
;
;    ; Loop 5 times, possibly increasing each of the base stats
;  @StatUpLoop:
;      ASL LevelUp_StatByte             ; shift out the high bit of the stat byte
;      BCC @StatUpRandomChance   ; if clear, stat has a random chance of increase
;
;    @IncreaseStat:              ; if set, stat has a guaranteed increase
;      LDA #$01                  ;   increase by 1
;      BNE @ApplyStatBonus       ;   (always branch)
;
;    @StatUpRandomChance:        ; stat byte was clear
;      JSR BattleRNG_L           ; get a random number
;      AND #$03
;      BEQ @IncreaseStat         ; 25% chance of increase
;      LDA #$00                  ; otherwise, no increase (or rather, increase by 0)
;
;    @ApplyStatBonus:
;      STA tmp
;      LDY LevelUp_LoopCounter              ; record stat increase in this statup buffer
;      STA LevelUp_StatBuffer, Y      ;   so that this can be reported back to the user later
;
;      LDY LevelUp_StatIndex
;      CLC
;      ADC (lvlup_chstats), Y    ; add bonus to stat
;      CMP #100
;      BEQ :+                    ; but only apply it if < 100
;        STA (lvlup_chstats), Y
;
;      ;; JIGS - fixing the bug mentioned below?
;    : LDA tmp
;      LDY LevelUp_LoopCounter              ; record stat increase in this statup buffer
;      STA LevelUp_StatBuffer, Y      ;   so that this can be reported back to the user later
;
;  ;  :
;      INC LevelUp_StatIndex              ; move to next stat
;
;      INC LevelUp_LoopCounter              ; and loop until all 5 stats processed
;      LDA LevelUp_LoopCounter
;      CMP #$05
;      BNE @StatUpLoop
;
;    ; The above is slightly BUGGED -- if the stat was maxed out, it will not be increased, but
;    ;  @statupbuffer will be set indicating it was, so misinformation will be reported to the player
;    ;  when statupbuffer is printed below.
;
;    ;;---- substat changes  (damage/absorb/etc)
;    ;  So much of this below code is fishy.  There are ALL SORTS of edge cases where a stat might
;    ; not be properly increased, or it might increase when it shouldn't.  It would be so much smarter
;    ; to just recalculate substats from scratch -- rather than try to adjust them on-the-fly like this.
;    ; This is undoubtedly BUGGED for edge cases, but I'm not going to point them all out.
;
;    LDY #ch_strength - ch_stats      ; damage goes up 1 pt for each 2pts of strength
;    LDA LevelUp_StatBuffer+0         ; so check to see if strength has gone up
;    BEQ :+                      ; if yes...
;      LDA (lvlup_chstats), Y
;      LSR A
;      BCS :+                    ; ...see if it went up to an even number
;      LDY #ch_damage - ch_stats    ;    if yes, add 1 to damage stat
;      LDA (lvlup_chstats), Y    ;    capping at 200
;      CLC
;      ADC #$01
;      CMP #201
;      BEQ :+
;        STA (lvlup_chstats), Y
;
;  : LDY #ch_evasion - ch_stats    ; evade goes up 1 if agility went up
;    LDA LevelUp_StatBuffer+1
;    BEQ :+                      ; did agility go up?
;      LDA (lvlup_chstats), Y
;      CLC
;      ADC #$01
;      CMP #201                  ; cap at 200
;      BEQ :+
;        STA (lvlup_chstats), Y
;
;  : JSR LvlUp_AdjustBBSubStats  ; adjust dmg and absorb for BB/Masters


    ;;---- Display the actual ... display to indicate to the user that they levelled up

    LDA #$00                    ; draw 4 EOB Boxes:
    STA eobbox_slotid           ;   Level Up | <Name> L##
    LDA #$05                    ;   HP Max   | ### pts.
    STA eobbox_textid
    JSR Draw4EobBoxes

    ; Now we need to loop through all of the base stats (str/int/etc) and print
    ;  a "Str Up!" msg if that stat increased.

            @displayloopctr    = btl_unformattedstringbuf+8  ;  eobbox_slotid  ; btlinput_prevstate
            @displaymsgcode    = btl_unformattedstringbuf+10  ;  eobbox_textid  ; inputdelaycounter
    LDA #$00
    STA @displayloopctr             ; zero the loop counter
    LDA #BTLMSG_STR
    STA @displaymsgcode             ; start with msg code for 'Str'

  @DisplayLoop:
    LDY @displayloopctr
    LDA LevelUp_StatBuffer, Y            ; check to see if the stat increased

    BEQ @DisplayLoop_Next           ; if it didn't, skip ahead.  Otherwise...

      LDA #BTLMSG_UP                ; fill the display buffer with the following string:
      STA btl_unformattedstringbuf+3          ; 0F <StatMsgCode> 0F <UpMsgCode> 00
      LDA #$0F                      ;  which of course will print "Str Up!" or "Int Up!"
      STA btl_unformattedstringbuf+0
      STA btl_unformattedstringbuf+2
      LDA @displaymsgcode
      STA btl_unformattedstringbuf+1
      LDA #$00
      STA btl_unformattedstringbuf+4

      LDA #BANK_THIS                ; set swap-back bank to this bank.
      STA cur_bank

      LDA #BOX_MESSAGE
      LDX #<btl_unformattedstringbuf
      LDY #>btl_unformattedstringbuf
      JSR DrawCombatBox_L           ; draw this string in combat box 4

      JSR RespondDelay              ; wait a bit for them to read it
      JSR WaitForAnyInput           ; wait a bit more for the user to press something

      LDA #$01
      JSR UndrawNBattleBlocks_L     ; then undraw the box we just drew

  @DisplayLoop_Next:
    INC @displaymsgcode             ; inc msg code to refer to next stat name
    INC @displayloopctr
    LDA @displayloopctr
    CMP #$05                        ; loop 5 times (for each stat)
    BNE @DisplayLoop

    ; The delay, undraw all boxes, and exit!
    JMP RespondDelay_UndrawAllCombatBoxes

    ;; BUGGED - If the character gains so much EXP that they should level up more than once,
    ;;   This code will only level them up the first time, and they'll have to complete another battle
    ;;   to level up again.
    ;;
    ;;   This is actually very easy to fix... instead of exiting this routine here... you could just
    ;; JMP back to the "jump here" point I marked in LvlUp_AwardExp.  That will keep checking for
    ;; and performing level ups until they're all done.

    ;; JIGS - I tried this and it kinda just got buggier. But that was also on a previous build
    ;; where lots of different battle things I changed got buggier... So it might be safe now.

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Draw4EobBoxes  [$9DC5 :: 0x2DDD5]
;;
;;  input:  eobbox_slotid = expected to be zero  (why doesn't this routine just zero it?)
;;          eobbox_textid = EOB text ID to print in first box
;;
;;    This routine draws 4 EOB combat boxes with text eobbox_textid, eobbox_textid+1, eobbox_textid+2,
;;  and eobbox_textid+3.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

Draw4EobBoxes:
  LDA #8; 0
  STA eobbox_slotid ;; JIGS - just in case

  @Loop:
      LDA eobbox_slotid         ; draw one EOB box
      LDX eobbox_textid
      JSR DrawEOBCombatBox

      INC eobbox_slotid         ; inc slot and text
      INC eobbox_textid
      LDA eobbox_slotid
      CMP #$0C ; 4                  ; keep looping until all 4 slots drawn
      BNE @Loop

    RTS



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  [$9E0C :: 0x2DE1C]
;;    Lut - pointer table to the beginning of each character's OB stats in RAM

lut_CharStatsPtrTable:
  .WORD ch_stats
  .WORD ch_stats + $40
  .WORD ch_stats + $80
  .WORD ch_stats + $C0


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  CapAAt200  [$9E1C :: 0x2DE2C]
;;
;;    Sets A to 200 if it is over 200
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

CapAAt200:
    CMP #201
    BCC :+
      LDA #200
  : RTS

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  GiveRewardToParty  [$9E23 :: 0x2DE33]
;;
;;  input:        $80,81 = destination pointer.  Points to stat to be increased
;;          battlereward = 3-byte reward
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

GiveRewardToParty:
    JSR AddBattleRewardToVal        ; add reward to target buffer

    LDA #<data_MaxRewardPlusOne     ; set $82 to point to reward max+1 (1000000)
    STA LevelUp_Reward
    LDA #>data_MaxRewardPlusOne
    STA LevelUp_Reward+1

    LDY #3 - 1                      ; compare 3 bytes
    JSR MultiByteCmp                ;  current value compared to max

    BCC @Exit                       ; less than the max, just exit

    ; Otherwise, current >= max

    LDY #$00                ; loop to copy 3 bytes of data
    : LDA (LevelUp_Reward), Y          ; copy max to dest
      STA (LevelUp_Pointer), Y
      INY
      CPY #$03
      BNE :-

    ; Then, because we're working with Max+1 for some stupid reason, subtract 1:
    JMP SubtractOneFromVal

  @Exit:
    RTS


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  GiveHpBonusToChar  [$9E44 :: 0x2DE54]
;;
;;  input:        $80,81 = destination pointer.  Points to stat to be increased (max HP)
;;          battlereward = 3-byte reward (must not be > $7FFF or this will overwrite character strength!)
;;
;;    This routine is basically a copy of GiveRewardToParty.  The only differences are:
;;  - It uses a different cap (1000 instead of 1000000)
;;  - It records the result to eobtext_print_hp so it can be displayed to the user
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;GiveHpBonusToChar:
;    JSR AddBattleRewardToVal    ; add reward (which is the HP bonus)
;
;    LDA #<data_MaxHPPlusOne     ; copy HP cap to $82,83
;    STA LevelUp_Reward
;    LDA #>data_MaxHPPlusOne
;    STA LevelUp_Reward+1
;
;    LDY #2 - 1                  ; compare 2 byte value (char max HP to HP cap)
;    JSR MultiByteCmp
;    BCC @Done                   ; if max HP < cap, jump ahead to @Done
;
;    LDY #$00                    ; copy the cap over to the max HP
;    : LDA (LevelUp_Reward), Y
;      STA (LevelUp_Pointer), Y ; < HP max
;      INY
;      CPY #$02
;      BNE :-
;
;    JSR SubtractOneFromVal      ; then subtract 1, because the cap is retardedly 1 over the maximum
;
;  @Done:
;    LDY #$00                    ; finally, copy the new max HP to eobtext_print_hp so
;    LDA (LevelUp_Pointer), Y  ;   it can be printed to the user!
;    STA eobtext_print_hp
;    INY
;    LDA (LevelUp_Pointer), Y
;    STA eobtext_print_hp+1
;    RTS

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  AddBattleRewardToVal [$9E72 :: 0x2DE82]
;;
;;  input:  $80  points to a 3-byte value to add battlereward to.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

AddBattleRewardToVal:
    LDA #$03
    STA char_index               ; loop 3 times (adding 3 bytes)
    LDA #$00
    TAY                          ; A, X, Y all zero'd
    TAX                          ; Y = dest index, X = source index

    CLC                          ; CLC at the start of the addition
  @Loop:
      LDA (LevelUp_Pointer), Y  ; read dest byte
      ADC battlereward, X        ; sum with source/reward byte
      STA (LevelUp_Pointer), Y  ; write back to dest

      INX                        ; inc indexes to do next byte
      INY

      DEC char_index             ; loop 3 times, for each byte
      BNE @Loop

    RTS

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  MultiByteCmp  [$9EB1 :: 0x2DEC1]
;;
;;  input:  $80,81 = ptr to first value
;;          $82,83 = ptr to second value
;;               Y = number of bytes (-1) to compare.  Ex:  Y=1 compares 2 bytes
;;
;;  output:    Z,C = set to result of CMP
;;
;;    C set if ($80) >= ($82)
;;    Z set if they're equal
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

MultiByteCmp:
  @Loop:
    LDA (LevelUp_Pointer), Y ; load value
    CMP (LevelUp_Reward), Y  ; compare to target value
    BEQ @NextByte             ; if equal, do next byte

      PHP                     ; if not equal...
      PLA
      AND #$81                ; clear all flags except N,C.  Presumably this is to clear Z
      PHA                     ;  strangely, this also clears I!  nuts!  Why it preserves N is
      PLP                     ;  is a mystery, as its result here is not reliable.
      RTS                     ; and exit

  @NextByte:
    DEY                       ; decrease byte counter to move to next byte
    BNE @Loop                 ; loop if more bytes to compare

    LDA (LevelUp_Pointer), Y ; otherwise, if this is the last byte
    CMP (LevelUp_Reward), Y  ; simply do the CMP
    RTS                       ; the 'Z' result will be preserved on this CMP


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  DivideRewardBySurvivors  [$9EC6 :: 0x2DED6]
;;
;;    Divides the reward (in battlereward) by the number
;;  of surviving party members.
;;
;;  input/output:   battlereward   (2 bytes)
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

DivideRewardBySurvivors:
    ; Count the number of players that survived
    LDX #$04                    ; loop down counter
    LDY #$00                    ; count of survivors

    LDA btl_drawflagsA          ; OR the drawflags together -- low 4 bits will be set
    ORA btl_drawflagsB          ;  if that character did not survive
  @CountLoop:
      LSR A                     ; shift out bits
      BCS :+                    ; if clear...
        INY                     ;  ... count it
    : DEX
      BNE @CountLoop


    ;;  Loop to divide exp reward by the number of remaining characters.
    ;;    strangely, this only divides a 16-bit value, when the experience itself
    ;;    is tallied into a 24-bit value.  I wouldn't say this is bugged, but it's
    ;;    a curiosity.
          @divisor =    BattleTmpPointer
          @remainder =  BattleTmpPointer+1

    STY @divisor                ; Y (the number of surviving party members) is the divisor
    LDA #$00
    STA @remainder              ; zero remainder

    LDX #16                     ; loop 16 times, one for each bit of the dividend

    ROL battlereward            ; roll out the high bit of the sum into C
    ROL battlereward+1
  @DivLoop:
    ROL @remainder              ; roll bit into remainder

    LDA @remainder
    CMP @divisor
    BCC :+                      ; once the remainder >= divisor
      SBC @divisor              ;  ... subtract divisor
      STA @remainder
  : ROL battlereward            ; roll 1 into result (if subtracted)
    ROL battlereward+1          ; or 0 into result (if didn't subtract)
    DEX
    BNE @DivLoop
    RTS




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Sum Battle Rewards
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

SumBattleRewardEXP:

;; Y = EXP

    LDA #$00
    STA battlereward            ; reset reward to zero
    STA battlereward+1
    STA battlereward+2

    LDX #$09                    ; loop 9 times, once for each enemy slot

  @Loop:
      CLC
      LDA btl_enemyrewards, Y     ; sum low byte
      ADC battlereward
      STA battlereward

      LDA btl_enemyrewards+1, Y   ; high byte
      ADC battlereward+1
      STA battlereward+1

      LDA battlereward+2        ; carry into 3rd byte - This is used for GP but not for Exp
      ADC #$00
      STA battlereward+2

      CLC
      TYA                       ; it assumes C is clear here, since sum cannot be over $FFFFFF
      ADC #04                   ;  add $04 to source index to move to next enemy ($04 bytes per enemy)
      TAY

      DEX
      BNE @Loop

      LDA Options
      AND #EXP_GAIN_HIGH | EXP_GAIN_LOW
      BEQ @RTS         ; if both are 0, exit
      AND #EXP_GAIN_HIGH ; if not, one of them is active; check if its high
      BEQ HalveReward  ; its not high, so it must be low; halve the reward
      BNE DoubleReward ; it IS high; 1.5x the reward

   @RTS:
    RTS


SumBattleRewardGP:

;; Y = GP

    LDA #$00
    STA battlereward            ; reset reward to zero
    STA battlereward+1
    STA battlereward+2

    LDX #$09                    ; loop 9 times, once for each enemy slot

  @Loop:
      CLC
      LDA btl_enemyrewards, Y     ; sum low byte
      ADC battlereward
      STA battlereward

      LDA btl_enemyrewards+1, Y   ; high byte
      ADC battlereward+1
      STA battlereward+1

      LDA battlereward+2        ; carry into 3rd byte - This is used for GP but not for Exp
      ADC #$00
      STA battlereward+2

      CLC
      TYA                       ; it assumes C is clear here, since sum cannot be over $FFFFFF
      ADC #04                  ;  add $04 to source index to move to next enemy ($04 bytes per enemy)
      TAY

      DEX
      BNE @Loop

      LDA Options
      AND #MONEY_GAIN_HIGH | MONEY_GAIN_LOW
      BEQ @RTS         ; if both are 0, exit
      AND #MONEY_GAIN_HIGH ; if not, one of them is active; check if its high
      BEQ HalveReward  ; its not high, so it must be low; halve the reward
      BNE DoubleReward ; it IS high; 1.5x the reward

   @RTS:
    RTS



HalveReward:
    LSR battlereward+2
    ROR battlereward+1
    ROR battlereward
    RTS

DoubleReward:
    ASL battlereward
    ROL battlereward+1
    ROL battlereward+2
    RTS


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  DrawEOBCombatBox  [$9F3B :: 0x2DF4B]
;;
;;    Draws an "End of Battle" (EOB) combat box.  These are boxes containing
;;  text that is shown at the end of battle... like "Level up!" kind of stuff.
;;
;;  input:  A = combat box ID to draw
;;          X = EOB string ID   (see lut_EOBText for valid values)
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

DrawEOBCombatBox:
    STA EOBCombatBox_tmp               ; backup the combo box ID

    LDA #BANK_THIS          ; set the current bank for the music driver
    STA cur_bank            ; seems weird to do this here...

    TXA                     ; Get the EOB string ID to print
    ASL A                   ; x2 to use as index

    TAY
    LDX lut_EOBText, Y      ; load pointer from lut
    LDA lut_EOBText+1, Y    ; and put in YX
    TAY

    LDA EOBCombatBox_tmp    ; restore combo box ID in A
    JSR DrawCombatBox_L     ; A = box ID, YX = pointer to string

  ;  INC btl_boxcount        ; count this combat box
    RTS                     ; and exit!

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  RespondDelay_UndrawAllCombatBoxes [$9F57 :: 0x2DF67]
;;
;;    Calls RespondDelay, then undraws all combat boxes
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

RespondDelay_UndrawAllCombatBoxes:
    JSR RespondDelay                ; this is all self explanitory...
    LDA BattleBoxBufferCount
    JSR UndrawNBattleBlocks_L
;    LDA #$00
;    STA btl_boxcount
    RTS

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  RespondDelay [$9F66 :: 0x2DF76]
;;
;;    Waits the appropriate number of frames, as indicated by 'btl_responddelay'.
;;  Normally that value is dictated by the player's desired respond rate -- however
;;  its value is overwritten by some code for some areas of the game.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

RespondDelay:
    LDA btl_responddelay
    STA btl_respondrate_tmp               ; loop counter
  @Loop:
      JSR WaitForVBlank_L   ; Do a frame
      JSR MusicPlay         ; update music
      DEC btl_respondrate_tmp             ; repeat for desired number of frames
      BNE @Loop
    RTS

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  WaitForAnyInput [$9F78 :: 0x2DF88]
;;
;;  Spins and waits full frames until the user presses any button.
;;
;;  Input stored in A and btl_input upon exit.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

WaitForAnyInput:
    JSR GetJoyInput         ; get input
    PHA                     ; back it up
    JSR WaitForVBlank_L     ; wait a frame
    JSR MusicPlay           ; do music for that frame
    PLA                     ; get input
    BEQ WaitForAnyInput     ; keep looping if no buttons pressed

    RTS                     ; otherwise, exit with input stored in A

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  MusicPlay  [$9F86 :: 0x2DF96]
;;
;;    Call music play -- version for this bank
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

MusicPlay:
    LDA #BANK_THIS          ; tell CallMusicPlay which bank to swap back to
    STA cur_bank

    LDA music_track       ; check this track
    BPL :+                  ; if it's finished...
      LDA btl_followupmusic ;   ... load followup music
      STA music_track     ;   and play it   (not sure why this is necessary)

  : JMP CallMusicPlay_L

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Battle_FlipAllChars  [$9F99 :: 0x2DFA9]
;;
;;    Does the animation to flip each of the characters to face right.
;;  Done when the party runs away from a battle.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

Battle_FlipAllChars:
    LDA #$A0 ; 10           ; put a pointer to first character's OAM data in $8A
    STA BattleBoxString     ;  start at $10 because the first 4 sprites are for the battle
    LDA #>oam               ;  cursor/weapon/magic sprite.
    STA BattleBoxString+1

    LDA #$00                ; loop up-counter and character index
    STA BattleTmpPointer2
  @Loop:
      JSR Battle_FlipCharSprite ; flip this character sprite

      JSR WaitForVBlank_L       ; wait for a frame
      LDA #>oam                 ;  so we can update OAM
      STA $4014
      JSR MusicPlay             ; update music (since we waited a frame)

      LDA #15
      STA btl_responddelay      ; change respond delay to 15 (battle is over, so respond rate doesn't matter anymore)
      JSR RespondDelay          ; wait 15 frames

      INC BattleTmpPointer2     ; Inc counter and loop until all 4 characters flipped.
      LDA BattleTmpPointer2
      CMP #$04

      BNE @Loop

    RTS


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Battle_FlipCharSprite  [$9FC4 :: 0x2DFD4]
;;
;;    Flips a character sprite (unless they're dead/stone) to face right.  This
;;  is done after the party runs away.
;;
;;  input:    A = ID of character to flip
;;          $8A = pointer in OAM to character's sprite data
;;
;;  output: $8A = updated to point to next character's sprite data
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

Battle_FlipCharSprite:
    JSR Shift6TAX           ; convert char ID to index
    LDA ch_ailments, X      ; get ailment
    AND #AIL_DEAD | AIL_STOP | AIL_SLEEP
    BNE @Skip

   ; CMP #$01
   ; BEQ @Skip               ; if they're dead, skip them
   ; CMP #$02
   ; BEQ @Skip               ; if they're stone, skip them
   ; CMP #$20
   ; BEQ @Skip               ; if they're asleep, skip them

    ; Otherwise, we're going to loop and flip each character sprite
    LDX #$03                ; X is loop down counter.  3 rows of tiles per character
                            ;   2 tiles per row
  @Loop:
    LDY #<oam_x              ; swap X coordinates for the tiles
    LDA (BattleBoxString), Y
    PHA
    LDY #<oam_x+4
    LDA (BattleBoxString), Y
    LDY #<oam_x
    STA (BattleBoxString), Y
    PLA
    LDY #<oam_x+4
    STA (BattleBoxString), Y

    LDY #<oam_a              ; Then set the "flip-X" attribute bit for each tile
    JSR @FlipTile
    LDY #<oam_a+4
    JSR @FlipTile

    LDA #$08                ; pointer += 8 to move to next row of tiles
    JSR @AddToPtr           ;   (4 bytes per tile, 2 tiles per row)

    DEX                     ; Loop until all 3 rows flipped
    BNE @Loop

    RTS                     ; Then exit!

  @Skip:                    ; jumps here to skip the tile
    LDA #4*6                ; add $18 to the pointer to skip then entire character (4 bytes per tile
                            ;   6 tiles per character)
  @AddToPtr:
    CLC                     ; Add A to the pointer at $8A
    ADC BattleBoxString
    STA BattleBoxString
    LDA #$00                ; (adding carry to high byte is unnecessary, as OAM will never cross a page)
    ADC BattleBoxString+1
    STA BattleBoxString+1
    RTS

  @FlipTile:
    LDA (BattleBoxString), Y ; get attribute byte
    ORA #$40                 ; set the 'flip-X' bit
    STA (BattleBoxString), Y ; write it back
    RTS


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  lut for End of Battle text  [$A00E :: 0x3201E]
;;
;;    Strings used for DrawEOBCombatBox.  I have no idea why some of the
;; string data is stored here, and some of it is stored way back at $9950.

lut_EOBText:
  .WORD @MnstPrsh               ; 0
  .WORD @ExpUp                  ; 1
  .WORD @ExpVal                 ; 2
  .WORD @Gold                   ; 3
  .WORD @GoldVal                ; 4
  .WORD @LevUp                  ; 5
  .WORD @eobtext_NameLN         ; 6
  .WORD @eobtext_HPMax          ; 7
  .WORD @eobtext_Npts           ; 8
  .WORD @eobtext_PartyPerished  ; 9

  @MnstPrsh: .BYTE $0F,BTLMSG_MONSTERS
             .BYTE $0F,BTLMSG_TERMINATED,$00 ; "Monsters Terminated"
  @ExpUp:    .BYTE $0F,BTLMSG_EXPUP,$00      ; "Exp earned.."
  @ExpVal:   .BYTE $18
             .WORD eob_exp_reward            ; "## Exp"  where ## is the experience reward
             .BYTE $FF,$8E,$BB,$B3,$00
  @GoldVal:  .BYTE $18
             .WORD eob_gp_reward             ; "## Gold"   where ## is the GP reward
             .BYTE $FF,$90,$B2,$AF,$A7,$00
  @Gold:     .BYTE $0F,BTLMSG_GOLDFOUND,$00  ; "Gold found.."
  @LevUp:    .BYTE $0F,BTLMSG_LEVUP,$00      ; "Lev. up!"

  @eobtext_NameLN:
  .BYTE $02, $FF, $95, $18
  .WORD eobtext_print_level
  .BYTE $00                                 ; "<Name> L##", where <Name> is btl_attacker's name and ## is value at $687A
  @eobtext_HPMax:
  .BYTE $0F, BTLMSG_HPMAX_2, $00            ; "HP max"
  @eobtext_Npts:
  .BYTE $18
  .WORD eobtext_print_hp
  .BYTE $0F, $32, $00                       ; "##pts." where ## is value at $687C
  @eobtext_PartyPerished:
  .BYTE $04, $0F, BTLMSG_PARTY
  .BYTE $0F, BTLMSG_PERISHED, $00           ; "<Name> party perished", where <Name> is the party leader's name

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  ChaosDeath_FadeNoise  [$A03D :: 0x3204D]
;;
;;  input/output:   $9C = value to write to Noise volume reg
;;
;;    This routine is called by ChaosDeath.  The first time it is called, 9C=0, which means
;;  the DEC here will cause it to wrap to $FF.  This will make the noise start playing a rumble
;;  at full volume.
;;
;;    It is then called every $80 frames as the ChaosDeath animation progresses.  Each time, it
;;  will decrease the volume by 1, causing the noise to VERY SLOWLY fade out.
;;
;;    Until the end of the animation, where it is called a 17th time, resulting in the DEC
;;  producing a value of $EF.  This sets noise to play full volume with an automated fadeout
;;  that loops.  Resulting in two more "BOOM" noises that follow.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

ChaosDeath_FadeNoise:
    DEC ChaosNoise      ; DEC noise setting

    LDA ChaosNoise
    STA $400C           ; write it to noise volume control
    LDA #$FF
    STA $400D           ; (no effect)
    STA $400F           ; set length counter (make noise audible)
    LDA #$0F
    STA $400E           ; set tone -- lowest possible frequency resulting in a very low rumble.

    RTS


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  ChaosDeath  [$A052 :: 0x32062]
;;
;;    This does the slow "dissolving"/"disintegrating" effect that you see
;;  when Chaos is defeated.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

ChaosDeath:
    JSR WaitForVBlank_L
    LDA $2002

    LDA #$DE                ; now draw a column of blank spaces from $20DD down, 12 rows
    STA tmp
    LDX #$20
    LDY #11                 ; Y is rows
   @ClearIconLoop:
    JSR SetPPUAddr_XA
    LDA #0
    STA $2007
    STA $2007
    DEY
    BEQ :+
        LDA tmp
        CLC
        ADC #$20
        STA tmp
    BCC @ClearIconLoop
      INX
      BNE @ClearIconLoop

  : LDX #$23
    LDA #$C7                ; and set the attribute to the rest of the backdrop
    JSR SetPPUAddr_XA
    LDA #$00
    STA $2007
    STA $2005               ; reset scroll to 0
    STA $2005

    JSR MusicPlay

    LDA #115
    STA EOBCombatBox_tmp    ;   loop down counter
  @WaitLoop:                ; wait for 110 frames (wait for the fanfare music to get
      JSR WaitForVBlank_L   ;   through the main jingle part)
      JSR MusicPlay
      DEC EOBCombatBox_tmp
      BNE @WaitLoop

    LDA #$80                ; stop music playback
    STA music_track
    STA btl_followupmusic
    JSR MusicPlay

    LDA #$08                ; silence all channels except Noise
    STA $4015
    STA $5015               ; JIGS - MMC5 audio

    ; a bunch of local vars
            @rvalprev       = EnemyRAMPointer   ; "previous" random value
            @rval           = EnemyRAMPointer+1 ; a random value
            @ppuaddr        = EnemyROMPointer   ; 2 bytes
            @outerctr       = WeaponPointer
            @innerctr       = WeaponPointer+1
            @tilerowtbl     = btl_msgbuffer ; a table of 256 entries which says which row to erase for each tile
                                            ;   note that the table is 256 entries but it only NEEDS to be 128.
                                            ;   The last 128 entries are not used.

    LDA #$00                    ; Start the Low-pitch noise rumble
    STA ChaosNoise              ; See ChaosDeath_FadeNoise for details
    JSR ChaosDeath_FadeNoise

    LDY #$00                    ; Fill @tilerowtbl with randomness
  @TableFillLoop:
      JSR BattleRNG_L
      STA @tilerowtbl, Y
      INY
      BNE @TableFillLoop


    ;   The Choas Death effect is done with a nested Loop.  There is an inner loop that runs $100
    ; times.  Each time it runs, it erases one row of pixels (row determined by @tilerowtbl)
    ; for a tile between $00-7F.  This will erase Chaos as well as the battle backdrop tiles.
    ;
    ;   The outer loop will change which row gets erased by incrementing each value in the table.
    ;
    ;   Note that in order to ensure no tiles get skipped, the RNG is assumed to produce every value
    ; between 0-255 exactly once when called 256 times.  This also means we can only generate
    ; ONE random number inside the inner loop.  Therefore, that random number is used for several things.
    ;
    ;   A frame is drawn after every row of pixels is erased.

    LDA #$08
    STA @outerctr         ; outer loop counter.   Loop 8 times (once for each pixel row)
  @OuterLoop:
      LDA #$00
      STA @innerctr         ; inner loop counter  Loop $100 times (for $80 tiles -- they'll get erased twice each)
    @InnerLoop:

        LDA @innerctr               ; update the noise playback halfway through the inner loop
        CMP #$80
        BNE :+
          JSR ChaosDeath_FadeNoise

      : LDA #$00                    ; The one **AND ONLY** RNG call to choose a tile to erase
        LDX #$79
        JSR RandAX

        STA @rval                   ; store the tile number for later use

        LDX #$10                    ; multiply the tile ID by $10 to get the PPU addr to that
        JSR MultiplyXA              ;  tile's CHR
        STA @ppuaddr
        STX @ppuaddr+1

        LDY @rval                   ; get tile number, use it to figure out which row to erase
        LDA @tilerowtbl, Y
        AND #$07                    ; mask off to get 0-7 (only 8 rows of tiles)

        CLC                         ; Add the row number to the PPU addr
        ADC @ppuaddr
        STA @ppuaddr
        LDA @ppuaddr+1
        ADC #$00
        STA @ppuaddr+1

        JSR WaitForVBlank_L         ; Wait for VBlank

        LDA #$00
        JSR @SetPpuAddr         ; set ppu addr to low bitplane
        LDA #$00
        STA $2007               ; erase it

        LDA #$01
        JSR @SetPpuAddr         ; set ppu addr to high bitplane
        LDA #$00
        STA $2007               ; erase it

        LDA @rvalprev           ; load *another* random value
        AND #$03
        STA $2005               ; use it as X scroll to shake the screen

        LDA @rval               ; use tile ID as random number for Y scroll
        STA @rvalprev           ;  (and use it as X scroll next iteration)
        AND #$03
        STA $2005

        DEC @innerctr           ; loop 256 times!
        BNE @InnerLoop
        ;- end inner loop

      LDX #$00                  ; Once the inner loop ends, INC each entry in the @tilerowtbl
      : INC @tilerowtbl, X      ;  so change which rows get erased next outer iteration
        INX
        BNE :-

      JSR ChaosDeath_FadeNoise  ; update noise effect
      DEC @outerctr
      BNE @OuterLoop            ; outer loop 8 times
    ;- end outer loop

    ; At this point, Chaos and the battle backdrop have disintegrated, and the noise has started playing
    ; a "BOOM BOOM" effect (see ChaosDeath_FadeNoise for details).
    ;
    ; Wait 2 seconds for dramatic effect

    LDA #240
    STA $9E                 ; 120 frames = 2 seconds
  @Wait2SecondLoop:
      JSR WaitForVBlank_L
      LDA #$00
      : SEC                 ; small inner loop to burn cycles so that we don't call WaitForVBlank
        SBC #$01            ; immediately at the start of VBlank (even though that shouldn't be
        BNE :-              ; a problem)
      DEC $9E
      BNE @Wait2SecondLoop

    LDA #$00                ; then finally make the noise shut the hell up
    STA $4015
    RTS                     ; and exit!


    ; This is JSR'd to by the above code to set the PPU addr.
    ; input:  A=0 to set PPU addr to low bitplane
    ;         A=1 to set PPU addr to high bitplane

  @SetPpuAddr:
    ASL A           ; A*8 to move bitplane bit into proper position
    ASL A
    ASL A
    CLC
    ADC @ppuaddr    ; Add to ppu addr
    PHA             ; (push low byte, since $2006 needs high byte written first)
    LDA #$00
    ADC @ppuaddr+1  ; Resume addition to high byte
    STA $2006       ; write high byte
    PLA             ; then pull and write low byte
    STA $2006
    RTS




















;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Increment Y routines  [$A7B0 :: 0x2E7C0]
;;
;;    These routines just add a fixed value to Y and then return

;IncYBy8:        ; this is never actually used
;    INY

IncYBy7:
    INY
    INY
    INY

IncYBy4:
    INY
    INY
    INY
    INY
    RTS


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  WriteAttributes_ClearUnusedEnStats  [$A7B9 :: 0x2E7C9]
;;
;;  This is a weird compound routine that does two things that really have no reason
;;    to be done together.  It's just miscellaneous battle prep.
;;
;;  This routine will write btltmp_attr back to the PPU attribute tables,
;;  then it will iterate over btl_enemystats and zero stats for enemies that are unused.
;;
;;  Why clearing of unused enemies isn't done with the same code that initialized used
;;   enemy stats is a mystery to me.  That would have made a lot more sense.
;;   But even if it did... enemy stats were already cleared by PrepareEnemyFormation's
;;   blanket RAM clearing, so clearing it again here is entirely pointless.
;;   But whatever.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; JIGS - seems pointless then...?

;WriteAttributes_ClearUnusedEnStats:
;    JSR WriteAttributesToPPU
;
;    LDA #$00
;    STA btltmp+2            ; loop up-counter - the current enemy we're looking at
;
;  @EnemyLoop:
;    LDY btltmp+2
;    LDA btl_enemyIDs, Y     ; get current enemy ID
;    CMP #$FF
;    BNE @NextEnemy          ; if it's actually being used, then skip it.  Otherwise...
;
;    LDA btltmp+2
;    JSR GetEnemyStatPtr     ; Get the stat pointer for this enemy, put it in btltmp+0
;    STA btltmp+0
;    STX btltmp+1
;
;    LDY #$00                ; copy $14 bytes of 0 to this enemy's stats
;    LDX #$14
;    LDA #$00
;  @Loop:
;      STA (btltmp+0), Y
;      INY
;      DEX
;      BNE @Loop
;
;  @NextEnemy:
;    INC btltmp+2            ; increment our enemy counter
;    LDA btltmp+2
;    CMP #$09
;    BNE @EnemyLoop          ; loop until all 9 enemies processed
;
;    RTS


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  GetEnemyStatPtr  [$A7E7 :: 0x2E7F7]
;;
;;  input:
;;      A = desired enemy index  (0-8)
;;
;;  output:
;;      XA = pointer to that enemy's stats in RAM
;;
;;  This seems like a useful routine, but it only is used in 1 place?
;;   Looks like this routine is duplicated in bank C, where it is used much more.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

GetEnemyStatPtr:
    LDX #$14                ; multiply enemy index by $14  (number of bytes per enemy)
    JSR MultiplyXA
    CLC                     ; then add btl_enemystats to the result
    ADC #<btl_enemystats
    PHA
    TXA
    ADC #>btl_enemystats
    TAX
    PLA
    RTS

PrepCharStatPointers:
    ASL A                               ; 2* for pointer lut
    TAY
    LDA lut_CharStatsPtrTable, Y
    STA CharStatsPointer
    LDA lut_CharStatsPtrTable+1, Y
    STA CharStatsPointer+1
    RTS


;Example message:
;[Enemy  Name    HP-####/####   ]
;[Lvl-## Defense-### Attack-### ]
;[Type-Mending   Affliction-@@  ]
;[Weak-@@@@@@@@  Defy-@@@@@@@@  ]






















ScanEnemyString:
    LDX #0

    LDA #0
    STA tmp+8
    ;; tmp+9 is index for the ShortStringList

    LDY #120
   @FillString:
    LDA #$FF
    STA bigstr_buf, Y
    DEY
    BNE @FillString
    ;; fill the string with blank spaces to start with

    LDY #en_enemyid
    LDA (EnemyRAMPointer), Y
    ASL A
    TAY
    ;LDA data_EnemyNames, Y
    STA tmp
    ;LDA data_EnemyNames+1, Y
    STA tmp+1
    LDA #11
    JSR @AddToString
    ;; draw enemy name into the string

    INX
    INX

    JSR @GetNextShortString ; Lvl-
    LDA #1
    STA MMC5_tmp+2          ; MMC5_tmp+2 is kind of a brancher for later.
    LDY #en_level             ; bit 1 set = 2 numbers, bit 2 = 3 numbers, bit 4 = 4 numbers
    LDA (EnemyRAMPointer), Y
    LDY #0
    JSR @ConvertNumber
    ;; print Lvl- ##

    DEX

    JSR @GetNextShortString ; Attack-
    LDA #2
    STA MMC5_tmp+2
    LDA btlmag_defender_damage
    LDY #0
    JSR @ConvertNumber
    ;; print Attack- ###

    JSR @GetNextShortString ; HP-
    LDA #4
    STA MMC5_tmp+2
    LDA btlmag_defender_hp
    LDY btlmag_defender_hp+1
    JSR @ConvertNumber
    LDA #$7A                 ; /
    STA bigstr_buf, X
    INX
    LDA btlmag_defender_hpmax
    LDY btlmag_defender_hpmax+1
    JSR @ConvertNumber
    ; print HP- ####/####

    INX

    JSR @GetNextShortString ; Hit-
    LDA #1
    STA MMC5_tmp+2
    LDA btlmag_defender_numhitsmult
    LDY #0
    JSR @ConvertNumber

    LDX #51

    JSR @GetNextShortString ; Defend-
    LDA #2
    STA MMC5_tmp+2
    LDA btlmag_defender_defense
    LDY #0
    JSR @ConvertNumber
    ;; print Defense- ###

    LDX #62

    JSR @GetNextShortString ; Type-
    ;; Now because each enemy can have more than one category
    ;; but Categories can't be represented by icons
    ;; then we need to choose ONE category that most accurately represents an enemy
    ;; So there's a list further below of just ONE category per enemy ID
    ;; which is then doubled into an index for the word to print

    LDY #en_enemyid
    LDA (EnemyRAMPointer), Y
    TAY
    LDA @SingleCategory, Y
    ASL A                   ; multiply by 2
    TAY
    LDA @CategoryName_LUT, Y
    STA tmp
    LDA @CategoryName_LUT+1, Y
    STA tmp+1
    LDA #8
    JSR @AddToString

    LDX #77

    JSR @GetNextShortString ; Caution-
    LDY #en_attackail
    LDA (EnemyRAMPointer), Y
    LDY #$FF
    DEX
    JSR @UnrollStatByte
    ;; this only supports 4 ailments, which is already too damn much. 2 is too damn much!

    LDX #91

    JSR @GetNextShortString ; Weak-
    LDA btlmag_defender_elementweakness
    LDY #$CA
    JSR @UnrollElementByte

    LDX #106

    JSR @GetNextShortString ; Defy-
    LDA btlmag_defender_elementresist
    LDY #$CA
    JSR @UnrollElementByte

   @EndString:
    LDA #$05
    STA bigstr_buf+30
    STA bigstr_buf+61
    STA bigstr_buf+90
    LDA #$00
    STA bigstr_buf+120
    LDA #>(bigstr_buf)
    STA text_ptr+1
    LDA #<(bigstr_buf)
    STA text_ptr
    LDA #1
    STA menustall
    STA dest_x
    LDA #24
    STA dest_y
    RTS

   @UnrollStatByte:
    LSR A
    BCC :+
      LDY #$CD ; death
      JSR @PrintStatBitIcon
  : LSR A
    BCC :+
      LDY #$D1 ; stone
      JSR @PrintStatBitIcon
  : LSR A
    BCC :+
      LDY #$CC ; poison
      JSR @PrintStatBitIcon
  : LSR A
    BCC :+
      LDY #$EB ; darkness
      JSR @PrintStatBitIcon
  : LSR A
    BCC :+
      LDY #$D2 ; sleep
      JSR @PrintStatBitIcon
  : LSR A
    BCC :+
      LDY #$CB ; stun
      JSR @PrintStatBitIcon
  : LSR A
    BCC :+
      LDY #$D3 ; mute
      JSR @PrintStatBitIcon
  : LSR A
    BCC :+
      LDY #$CA ; confusion
      JSR @PrintStatBitIcon
  : RTS

  @UnrollElementByte:
    LSR A
    BCC :+
      JSR @PrintElementBitIcon
  : INX
    INY
    LSR A
    BCC :+
      JSR @PrintElementBitIcon
  : INX
    INY
    LSR A
    BCC :+
      JSR @PrintElementBitIcon
  : INX
    INY
    LSR A
    BCC :+
      JSR @PrintElementBitIcon
  : INX
    INY
    LSR A
    BCC :+
      JSR @PrintElementBitIcon
  : INX
    INY
    LSR A
    BCC :+
      JSR @PrintElementBitIcon
  : INX
    INY
    LSR A
    BCC :+
      JSR @PrintElementBitIcon
  : INX
    INY
    LSR A
    BCC :+
      JSR @PrintElementBitIcon
  : RTS

   @PrintStatBitIcon:
    INX
    JSR @PrintElementBitIcon
    LDY #$C4
    INX

   @PrintElementBitIcon:
    PHA
    TYA
    STA bigstr_buf, X
    PLA
    RTS

   @GetNextShortString:
    LDA tmp+8
    ASL A
    TAY
    LDA @ShortStringList, Y
    STA tmp
    LDA @ShortStringList+1, Y
    STA tmp+1
    INC tmp+8
    LDA #9                  ; set tmp+8 to 9, the longest ShortString
    BNE @AddToString
    ;; this gets the next ShortString and prints it to the Big string

   @ConvertNumber:
    STA MMC5_tmp
    STY MMC5_tmp+1
    TXA
    PHA

    JSR LongCall
    .word ConvertBattleNumber
    .byte $0E

    PLA
    TAX
    LDA text_ptr
    STA tmp
    LDA text_ptr+1
    STA tmp+1
    LDA #4
    ;; this converts hex numbers (enemy stats) into decimal, and prints it

   @AddToString:
    STA tmp+2
    LDY #0
   @AddToString_Loop:
    LDA (tmp), Y
    BEQ @FinishOffName      ; when it gets to the end of an enemy name, move the X pointer to the end of #11
    CMP #$FE                ; when it gets to the end of a ShortString
    BEQ :+
    STA bigstr_buf, X
    INX
    INY
    DEC tmp+2
    BNE @AddToString_Loop
  : RTS

   @FinishOffName:
    INX
    DEC tmp+2
    BNE @FinishOffName
    RTS

   @MoveXOver:
    INX
    DEY
    BNE @MoveXOver
    RTS

@ShortStringList:
.word @Level
.word @Attack
.word @HP
.word @Hit
.word @Defend
.word @Type
.word @Caution
.word @Weak
.word @Defy

@Level:
.byte $95,$B9,$AF,$C2,$FE

@HP:
.byte $91,$99,$C2,$FE

@Hit:
.byte $91,$AC,$B7,$C2,$FE

@Defend:
.byte $8D,$A8,$A9,$A8,$B1,$A7,$C2,$FE

@Attack:
.byte $8A,$B7,$B7,$A4,$A6,$AE,$C2,$FE

@Type:
.byte $9D,$BC,$B3,$A8,$C2,$FE

@Caution:
.byte $8C,$A4,$B8,$B7,$AC,$B2,$B1,$C2,$FE

@Weak:
.byte $A0,$A8,$A4,$AE,$C2,$FE

@Defy:
.byte $8D,$A8,$A9,$BC,$C2,$FE


@CategoryName_LUT:
.word @TYPE_NOTHING
.word @TYPE_UNKNOWN
.word @TYPE_DRAGON
.word @TYPE_GIANT
.word @TYPE_UNDEAD
.word @TYPE_BEASTLY
.word @TYPE_AQUATIC
.word @TYPE_MAGICAL
.word @TYPE_MENDING

@TYPE_NOTHING:
.byte $97,$B2,$B7,$AB,$AC,$B1,$AA,$FE ; Nothing
@TYPE_UNKNOWN:
.byte $9E,$B1,$AE,$B1,$B2,$BA,$B1,$FE ; Unknown
@TYPE_DRAGON:
.byte $8D,$B5,$A4,$AA,$B2,$B1,$FE,$00 ; Dragon
@TYPE_GIANT:
.byte $90,$AC,$A4,$B1,$B7,$FE,$00,$00 ; Giant
@TYPE_UNDEAD:
.byte $9E,$B1,$A7,$A8,$A4,$A7,$FE,$00 ; Undead
@TYPE_BEASTLY:
.byte $8B,$A8,$A4,$B6,$B7,$AF,$BC,$FE ; Beastly
@TYPE_AQUATIC:
.byte $8A,$B4,$B8,$A4,$B7,$AC,$A6,$FE ; Aquatic
@TYPE_MAGICAL:
.byte $96,$A4,$AA,$AC,$A6,$A4,$AF,$FE ; Magical
@TYPE_MENDING:
.byte $96,$A8,$B1,$A7,$AC,$B1,$AA,$FE ; Mending

@SingleCategory:
.byte TYPE_GIANT   ;00 IMP
.byte TYPE_GIANT   ;01 GrIMP
.byte $00          ;02 WOLF
.byte $00          ;03 GrWolf
.byte TYPE_WERE    ;04 WrWolf
.byte $00          ;05 FrWOLF
.byte TYPE_DRAGON  ;06 IGUANA
.byte TYPE_DRAGON  ;07 AGAMA
.byte TYPE_DRAGON  ;08 SAURIA
.byte TYPE_GIANT   ;09 GIANT
.byte TYPE_GIANT   ;0A FrGIANT
.byte TYPE_GIANT   ;0B R`GIANT
.byte TYPE_WATER   ;0C SAHAG
.byte TYPE_WATER   ;0D R`SAHAG
.byte TYPE_WATER   ;0E WzSAHAG
.byte $00          ;0F PIRATE
.byte $00          ;10 KYZOKU
.byte TYPE_WATER   ;11 SHARK
.byte TYPE_WATER   ;12 GrSHARK
.byte $00          ;13 OddEYE
.byte TYPE_WATER   ;14 BigEYE
.byte TYPE_UNDEAD  ;15 BONE
.byte TYPE_UNDEAD  ;16 R`BONE
.byte $00          ;17 CREEP
.byte $00          ;18 CRAWL
.byte $00          ;19 HYENA
.byte $00          ;1A CEREBUS
.byte TYPE_GIANT   ;1B OGRE
.byte TYPE_GIANT   ;1C GrOGRE
.byte TYPE_GIANT   ;1D WzOGRE
.byte TYPE_DRAGON  ;1E ASP
.byte TYPE_DRAGON  ;1F COBRA
.byte TYPE_WATER   ;20 SeaSNAKE
.byte $00          ;21 SCORPION
.byte TYPE_WATER   ;22 LOBSTER
.byte $00          ;23 BULL
.byte TYPE_UNDEAD  ;24 ZomBULL
.byte TYPE_REGEN   ;25 TROLL
.byte TYPE_REGEN   ;26 SeaTROLL
.byte TYPE_UNDEAD  ;27 SHADOW
.byte TYPE_UNDEAD  ;28 IMAGE
.byte TYPE_UNDEAD  ;29 WRAITH
.byte TYPE_UNDEAD  ;2A GHOST
.byte TYPE_UNDEAD  ;2B ZOMBIE
.byte TYPE_UNDEAD  ;2C GHOUL
.byte TYPE_UNDEAD  ;2D GEIST
.byte TYPE_UNDEAD  ;2E SPECTER
.byte $00          ;2F WORM
.byte $00          ;30 Sand W
.byte $00          ;31 Grey W
.byte TYPE_MAGE    ;32 EYE
.byte TYPE_UNDEAD  ;33 PHANTOM
.byte $00          ;34 MEDUSA
.byte TYPE_UNKNOWN ;35 GrMEDUSA
.byte TYPE_WERE    ;36 CATMAN
.byte TYPE_MAGE    ;37 MANCAT
.byte $00          ;38 PEDE
.byte $00          ;39 GrPEDE
.byte $00          ;3A TIGER
.byte $00          ;3B Saber T
.byte TYPE_UNDEAD  ;3C VAMPIRE
.byte TYPE_UNDEAD  ;3D WzVAMP
.byte TYPE_UNKNOWN ;3E GARGOYLE
.byte TYPE_UNKNOWN ;3F R`GOYLE
.byte TYPE_UNKNOWN ;40 EARTH
.byte TYPE_UNKNOWN ;41 FIRE
.byte TYPE_DRAGON  ;42 Frost D
.byte TYPE_DRAGON  ;43 Red D
.byte TYPE_UNDEAD  ;44 ZombieD
.byte $00          ;45 SCUM
.byte $00          ;46 MUCK
.byte $00          ;47 OOZE
.byte $00          ;48 SLIME
.byte $00          ;49 SPIDER
.byte $00          ;4A ARACHNID
.byte $00          ;4B MATICOR
.byte $00          ;4C SPHINX
.byte $00          ;4D R`ANKYLO
.byte $00          ;4E ANKYLO
.byte TYPE_UNDEAD  ;4F MUMMY
.byte TYPE_UNDEAD  ;50 WzMUMMY
.byte $00          ;51 COCTRICE
.byte $00          ;52 PERILISK
.byte TYPE_DRAGON  ;53 WYVERN
.byte TYPE_DRAGON  ;54 WYRM
.byte TYPE_DRAGON  ;55 TYRO
.byte TYPE_DRAGON  ;56 T REX
.byte $00          ;57 CARIBE
.byte $00          ;58 R`CARIBE
.byte $00          ;59 GATOR
.byte TYPE_DRAGON  ;5A FrGATOR
.byte $00          ;5B OCHO
.byte $00          ;5C NAOCHO
.byte TYPE_DRAGON  ;5D HYDRA
.byte TYPE_DRAGON  ;5E R`HYDRA
.byte $00          ;5F GAURD
.byte $00          ;60 SENTRY
.byte TYPE_UNKNOWN ;61 WATER
.byte TYPE_UNKNOWN ;62 AIR
.byte TYPE_MAGE    ;63 NAGA
.byte TYPE_MAGE    ;64 GrNAGA
.byte TYPE_DRAGON  ;65 CHIMERA
.byte TYPE_DRAGON  ;66 JIMERA
.byte TYPE_WATER   ;67 WIZARD  ;; very weird
.byte $00          ;68 SORCERER
.byte $00          ;69 GARLAND
.byte TYPE_DRAGON  ;6A Gas D
.byte TYPE_DRAGON  ;6B Blue D
.byte TYPE_MAGE    ;6C MudGOL
.byte TYPE_MAGE    ;6D RockGOL
.byte TYPE_UNKNOWN ;6E IronGOL
.byte $00          ;6F BADMAN
.byte TYPE_MAGE    ;70 EVILMAN
.byte $00          ;71 ASTOS
.byte TYPE_MAGE    ;72 MAGE
.byte TYPE_MAGE    ;73 FIGHTER
.byte $00          ;74 MADPONY
.byte TYPE_UNKNOWN ;75 NITEMARE
.byte TYPE_REGEN   ;76 WarMECH
.byte TYPE_UNDEAD  ;77 LICH
.byte TYPE_UNDEAD  ;78 LICH (reprise)
.byte TYPE_MAGE    ;79 KARY
.byte TYPE_MAGE    ;7A KARY (reprise)
.byte TYPE_WATER   ;7B KRAKEN
.byte TYPE_WATER   ;7C KRAKEN (reprise)
.byte TYPE_DRAGON  ;7D TIAMAT
.byte TYPE_DRAGON  ;7E TIAMAT (reprise)
.byte TYPE_UNKNOWN ;7F CHAOS






.byte "END OF BANK B"