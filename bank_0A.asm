.include "Constants.inc"
.include "variables.inc"
.feature force_range

.segment "BANK_0A"

.export data_BattleMessages
.export lut_ItemPrices
.export lut_ItemNamePtrTbl
.export lut_WeaponArmorNamePtrTbl
.export WeaponArmorPrices
.export lut_EnemyAttack
.export DumbBottleThing
.export data_EnemyNames
.export ScanEnemyString
.export lut_CommonStringPtrTbl
.export ItemDescriptions
.export DrawMenuString_A
.export DrawMenuString_CharCodes_A
.export lut_Treasure
.export lut_Treasure_2
.export lut_ClassSkills

.import DrawComplexString
.import ConvertBattleNumber
.import MultiplyXA
.import LongCall

BANK_THIS = $0A

; Dialogue data! This is moved to its own bank now, because the 7 letter spell names pushed me 50 bytes over the limit and damnit
; I'm not going to switch everything back to 6 letter spells now!

;; First, monster attacks:
lut_EnemyAttack:

.word EnemyAttack1   ; 0
.word EnemyAttack2   ; 1
.word EnemyAttack3   ; 2
.word EnemyAttack4   ; 3
.word EnemyAttack5   ; 4
.word EnemyAttack6   ; 5
.word EnemyAttack7   ; 6
.word EnemyAttack8   ; 7
.word EnemyAttack9   ; 8
.word EnemyAttack10  ; 9
.word EnemyAttack11  ; A
.word EnemyAttack12  ; B
.word EnemyAttack13  ; C
.word EnemyAttack14  ; D
.word EnemyAttack15  ; E
.word EnemyAttack16  ; F
.word EnemyAttack17  ; 10
.word EnemyAttack18  ; 11
.word EnemyAttack19  ; 12
.word EnemyAttack20  ; 13
.word EnemyAttack21  ; 14
.word EnemyAttack22  ; 15
.word EnemyAttack23  ; 16
.word EnemyAttack24  ; 17
.word EnemyAttack25  ; 18
.word EnemyAttack26  ; 19
.word EnemyAttack27  ; 1A
.word EnemyAttack28  ; 1B
.word EnemyAttack29  ; 1C
.word EnemyAttack30  ; 1D
.word EnemyAttack31  ; 1E
.word EnemyAttack32  ; 1F
.word EnemyAttack33  ; 20
.word EnemyAttack34  ; 21
.word EnemyAttack35  ; 22
.word EnemyAttack36  ; 23
.word EnemyAttack37  ; 24
.word EnemyAttack38  ; 25
.word EnemyAttack39  ; 26
.word EnemyAttack40  ; 27
.word EnemyAttack41  ; 28
.word EnemyAttack42  ; 29
.word EnemyAttack43  ; 2A
.word EnemyAttack44  ; 2B
.word EnemyAttack45  ; 2C
.word EnemyAttack46  ; 2D
.word EnemyAttack47  ; 2E
.word EnemyAttack48  ; 2F

EnemyAttack1:
.byte $8F,$9B,$98,$9C,$9D,$00             ; FROST
EnemyAttack2:
.byte $91,$8E,$8A,$9D,$00                 ; HEAT
EnemyAttack3:
.byte $90,$95,$8A,$97,$8C,$8E,$00         ; GLANCE
EnemyAttack4:
.byte $90,$8A,$A3,$8E,$00                 ; GAZE
EnemyAttack5:
.byte $8F,$95,$8A,$9C,$91,$00             ; FLASH
EnemyAttack6:
.byte $9C,$8C,$98,$9B,$8C,$91,$00         ; SCORCH
EnemyAttack7:
.byte $8C,$9B,$8A,$8C,$94,$00             ; CRACK
EnemyAttack8:
.byte $9C,$9A,$9E,$92,$97,$9D,$00         ; SQUINT
EnemyAttack9:
.byte $9C,$9D,$8A,$9B,$8E,$00             ; STARE
EnemyAttack10:
.byte $90,$95,$8A,$9B,$8E,$00             ; GLARE
EnemyAttack11:
.byte $8B,$95,$92,$A3,$A3,$8A,$9B,$8D,$00 ; BLIZZARD
EnemyAttack12:
.byte $8B,$95,$8A,$A3,$8E,$00             ; BLAZE
EnemyAttack13:
.byte $92,$97,$8F,$8E,$9B,$97,$98,$00     ; INFERNO
EnemyAttack14:
.byte $8C,$9B,$8E,$96,$8A,$9D,$8E,$00     ; CREMATE
EnemyAttack15:
.byte $99,$98,$92,$9C,$98,$97,$00         ; POISON
EnemyAttack16:
.byte $9D,$9B,$8A,$97,$8C,$8E,$00         ; TRANCE
EnemyAttack17:
.byte $99,$98,$92,$9C,$98,$97,$00         ; POISON
EnemyAttack18:
.byte $9D,$91,$9E,$97,$8D,$8E,$9B,$00     ; THUNDER
EnemyAttack19:
.byte $9D,$98,$A1,$92,$8C,$00             ; TOXIC
EnemyAttack20:
.byte $9C,$97,$98,$9B,$9D,$92,$97,$90,$00 ; SNORTING
EnemyAttack21:
.byte $97,$9E,$8C,$95,$8E,$8A,$9B,$00     ; NUCLEAR
EnemyAttack22:
.byte $92,$97,$94,$00                     ; INK
EnemyAttack23:
.byte $9C,$9D,$92,$97,$90,$8E,$9B,$00     ; STINGER
EnemyAttack24:
.byte $8D,$8A,$A3,$A3,$95,$8E,$00         ; DAZZLE
EnemyAttack25:
.byte $9C,$A0,$92,$9B,$95,$00             ; SWIRL
EnemyAttack26:
.byte $9D,$98,$9B,$97,$8A,$8D,$98,$00     ; TORNADO
EnemyAttack27:
EnemyAttack28:
EnemyAttack29:
EnemyAttack30:
EnemyAttack31:
EnemyAttack32:
EnemyAttack33:
EnemyAttack34:
EnemyAttack35:
EnemyAttack36:
EnemyAttack37:
EnemyAttack38:
EnemyAttack39:
EnemyAttack40:
EnemyAttack41:
EnemyAttack42:
EnemyAttack43:
EnemyAttack44:
EnemyAttack45:
EnemyAttack46:
EnemyAttack47:
EnemyAttack48:
.byte $92,$96,$99,$FF,$99,$9E,$97,$8C,$91,$00 ; IMP PUNCH


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;  Enemy names [$94E0 :: 0x2D4F0]
data_EnemyNames:

.word ENEMYNAME1
.word ENEMYNAME2
.word ENEMYNAME3
.word ENEMYNAME4
.word ENEMYNAME5
.word ENEMYNAME67
.word ENEMYNAME7
.word ENEMYNAME8
.word ENEMYNAME9
.word ENEMYNAME10
.word ENEMYNAME11
.word ENEMYNAME12
.word ENEMYNAME13
.word ENEMYNAME14
.word ENEMYNAME15
.word ENEMYNAME16
.word ENEMYNAME17
.word ENEMYNAME18
.word ENEMYNAME19
.word ENEMYNAME20
.word ENEMYNAME21
.word ENEMYNAME22
.word ENEMYNAME23
.word ENEMYNAME24
.word ENEMYNAME25
.word ENEMYNAME26
.word ENEMYNAME27
.word ENEMYNAME28
.word ENEMYNAME29
.word ENEMYNAME30
.word ENEMYNAME31
.word ENEMYNAME32
.word ENEMYNAME33
.word ENEMYNAME34
.word ENEMYNAME35
.word ENEMYNAME36
.word ENEMYNAME37
.word ENEMYNAME38
.word ENEMYNAME39
.word ENEMYNAME40
.word ENEMYNAME41
.word ENEMYNAME42
.word ENEMYNAME43
.word ENEMYNAME44
.word ENEMYNAME45
.word ENEMYNAME46
.word ENEMYNAME47
.word ENEMYNAME48
.word ENEMYNAME49
.word ENEMYNAME50
.word ENEMYNAME51
.word ENEMYNAME52
.word ENEMYNAME53
.word ENEMYNAME54
.word ENEMYNAME55
.word ENEMYNAME56
.word ENEMYNAME57
.word ENEMYNAME58
.word ENEMYNAME59
.word ENEMYNAME60
.word ENEMYNAME61
.word ENEMYNAME62
.word ENEMYNAME63
.word ENEMYNAME64
.word ENEMYNAME65
.word ENEMYNAME66
.word ENEMYNAME67
.word ENEMYNAME68
.word ENEMYNAME69
.word ENEMYNAME70
.word ENEMYNAME71
.word ENEMYNAME72
.word ENEMYNAME73
.word ENEMYNAME74
.word ENEMYNAME75
.word ENEMYNAME76
.word ENEMYNAME77
.word ENEMYNAME78
.word ENEMYNAME79
.word ENEMYNAME80
.word ENEMYNAME81
.word ENEMYNAME82
.word ENEMYNAME83
.word ENEMYNAME84
.word ENEMYNAME85
.word ENEMYNAME86
.word ENEMYNAME87
.word ENEMYNAME88
.word ENEMYNAME89
.word ENEMYNAME90
.word ENEMYNAME91
.word ENEMYNAME92
.word ENEMYNAME93
.word ENEMYNAME94
.word ENEMYNAME95
.word ENEMYNAME96
.word ENEMYNAME97
.word ENEMYNAME98
.word ENEMYNAME99
.word ENEMYNAME100
.word ENEMYNAME101
.word ENEMYNAME102
.word ENEMYNAME103
.word ENEMYNAME104
.word ENEMYNAME105
.word ENEMYNAME106
.word ENEMYNAME107
.word ENEMYNAME108
.word ENEMYNAME109
.word ENEMYNAME110
.word ENEMYNAME111
.word ENEMYNAME112
.word ENEMYNAME113
.word ENEMYNAME114
.word ENEMYNAME115
.word ENEMYNAME116
.word ENEMYNAME117
.word ENEMYNAME118
.word ENEMYNAME119
.word ENEMYNAME120
.word ENEMYNAME120
.word ENEMYNAME121
.word ENEMYNAME121
.word ENEMYNAME122
.word ENEMYNAME122
.word ENEMYNAME123
.word ENEMYNAME123
.word ENEMYNAME124


ENEMYNAME1:
.byte $92,$96,$99,$00                       ; IMP
ENEMYNAME2:
.byte $90,$B5,$92,$96,$99,$00               ; GrIMP
ENEMYNAME3:
.byte $A0,$98,$95,$8F,$00                   ; WOLF
ENEMYNAME4:
.byte $90,$B5,$A0,$98,$95,$8F,$00           ; GrWolf
ENEMYNAME5:
.byte $A0,$B5,$A0,$98,$95,$8F,$00           ; WrWolf
ENEMYNAME6:
.byte $8F,$B5,$A0,$98,$95,$8F,$00           ; FrWOLF
ENEMYNAME7:
.byte $92,$90,$9E,$8A,$97,$8A,$00           ; IGUANA
ENEMYNAME8:
.byte $8A,$90,$8A,$96,$8A,$00               ; AGAMA
ENEMYNAME9:
.byte $9C,$8A,$9E,$9B,$92,$8A,$00           ; SAURIA
ENEMYNAME10:
.byte $90,$92,$8A,$97,$9D,$00               ; GIANT
ENEMYNAME11:
.byte $8F,$B5,$90,$92,$8A,$97,$9D,$00       ; FrGIANT
ENEMYNAME12:
.byte $9B,$C0,$90,$92,$8A,$97,$9D,$00       ; R.GIANT
ENEMYNAME13:
.byte $9C,$8A,$91,$8A,$90,$00               ; SAHAG
ENEMYNAME14:
.byte $9B,$C0,$9C,$8A,$91,$8A,$90,$00       ; R.SAHAG
ENEMYNAME15:
.byte $A0,$BD,$9C,$8A,$91,$8A,$90,$00       ; WzSAHAG
ENEMYNAME16:
.byte $99,$92,$9B,$8A,$9D,$8E,$00           ; PIRATE
ENEMYNAME17:
.byte $94,$A2,$A3,$98,$94,$9E,$00           ; KYZOKU
ENEMYNAME18:
.byte $9C,$91,$8A,$9B,$94,$00               ; SHARK
ENEMYNAME19:
.byte $90,$B5,$9C,$91,$8A,$9B,$94,$00       ; GrSHARK
ENEMYNAME20:
.byte $98,$A7,$A7,$8E,$A2,$8E,$00           ; OddEYE
ENEMYNAME21:
.byte $8B,$AC,$AA,$8E,$A2,$8E,$00           ; BigEYE
ENEMYNAME22:
.byte $8B,$98,$97,$8E,$00                   ; BONE
ENEMYNAME23:
.byte $9B,$C0,$8B,$98,$97,$8E,$00           ; R.BONE
ENEMYNAME24:
.byte $8C,$9B,$8E,$8E,$99,$00               ; CREEP
ENEMYNAME25:
.byte $8C,$9B,$8A,$A0,$95,$00               ; CRAWL
ENEMYNAME26:
.byte $91,$A2,$8E,$97,$8A,$00               ; HYENA
ENEMYNAME27:
.byte $8C,$8E,$9B,$8E,$8B,$9E,$9C,$00       ; CEREBUS
ENEMYNAME28:
.byte $98,$90,$9B,$8E,$00                   ; OGRE
ENEMYNAME29:
.byte $90,$B5,$98,$90,$9B,$8E,$00           ; GrOGRE
ENEMYNAME30:
.byte $A0,$BD,$98,$90,$9B,$8E,$00           ; WzOGRE
ENEMYNAME31:
.byte $8A,$9C,$99,$00                       ; ASP
ENEMYNAME32:
.byte $8C,$98,$8B,$9B,$8A,$00               ; COBRA
ENEMYNAME33:
.byte $9C,$A8,$A4,$9C,$97,$8A,$94,$8E,$00   ; SeaSNAKE
ENEMYNAME34:
.byte $9C,$8C,$98,$9B,$99,$92,$98,$97,$00   ; SCORPION
ENEMYNAME35:
.byte $95,$98,$8B,$9C,$9D,$8E,$9B,$00       ; LOBSTER
ENEMYNAME36:
.byte $8B,$9E,$95,$95,$00                   ; BULL
ENEMYNAME37:
.byte $A3,$B2,$B0,$8B,$9E,$95,$95,$00       ; ZomBULL
ENEMYNAME38:
.byte $9D,$9B,$98,$95,$95,$00               ; TROLL
ENEMYNAME39:
.byte $9C,$A8,$A4,$9D,$9B,$98,$95,$95,$00   ; SeaTROLL
ENEMYNAME40:
.byte $9C,$91,$8A,$8D,$98,$A0,$00           ; SHADOW
ENEMYNAME41:
.byte $92,$96,$8A,$90,$8E,$00               ; IMAGE
ENEMYNAME42:
.byte $A0,$9B,$8A,$92,$9D,$91,$00           ; WRAITH
ENEMYNAME43:
.byte $90,$91,$98,$9C,$9D,$00               ; GHOST
ENEMYNAME44:
.byte $A3,$98,$96,$8B,$92,$8E,$00           ; ZOMBIE
ENEMYNAME45:
.byte $90,$91,$98,$9E,$95,$00               ; GHOUL
ENEMYNAME46:
.byte $90,$8E,$92,$9C,$9D,$00               ; GEIST
ENEMYNAME47:
.byte $9C,$99,$8E,$8C,$9D,$8E,$9B,$00       ; SPECTER
ENEMYNAME48:
.byte $A0,$98,$9B,$96,$00                   ; WORM
ENEMYNAME49:
.byte $9C,$A4,$B1,$A7,$FF,$A0,$00           ; Sand W
ENEMYNAME50:
.byte $90,$B5,$A8,$BC,$FF,$A0,$00           ; Grey W
ENEMYNAME51:
.byte $8E,$A2,$8E,$00                       ; EYE
ENEMYNAME52:
.byte $99,$91,$8A,$97,$9D,$98,$96,$00       ; PHANTOM
ENEMYNAME53:
.byte $96,$8E,$8D,$9E,$9C,$8A,$00           ; MEDUSA
ENEMYNAME54:
.byte $90,$B5,$96,$8E,$8D,$9E,$9C,$8A,$00   ; GrMEDUSA
ENEMYNAME55:
.byte $8C,$8A,$9D,$96,$8A,$97,$00           ; CATMAN
ENEMYNAME56:
.byte $96,$8A,$97,$8C,$8A,$9D,$00           ; MANCAT
ENEMYNAME57:
.byte $99,$8E,$8D,$8E,$00                   ; PEDE
ENEMYNAME58:
.byte $90,$B5,$99,$8E,$8D,$8E,$00           ; GrPEDE
ENEMYNAME59:
.byte $9D,$92,$90,$8E,$9B,$00               ; TIGER
ENEMYNAME60:
.byte $9C,$A4,$A5,$A8,$B5,$FF,$9D,$00       ; Saber T
ENEMYNAME61:
.byte $9F,$8A,$96,$99,$92,$9B,$8E,$00       ; VAMPIRE
ENEMYNAME62:
.byte $A0,$BD,$9F,$8A,$96,$99,$00           ; WzVAMP
ENEMYNAME63:
.byte $90,$8A,$9B,$90,$98,$A2,$95,$8E,$00   ; GARGOYLE
ENEMYNAME64:
.byte $9B,$C0,$90,$98,$A2,$95,$8E,$00       ; R.GOYLE
ENEMYNAME65:
.byte $8E,$8A,$9B,$9D,$91,$00               ; EARTH
ENEMYNAME66:
.byte $8F,$92,$9B,$8E,$00                   ; FIRE
ENEMYNAME67:
.byte $8F,$B5,$B2,$B6,$B7,$FF,$8D,$00       ; Frost D
ENEMYNAME68:
.byte $9B,$A8,$A7,$FF,$8D,$00               ; Red D
ENEMYNAME69:
.byte $A3,$B2,$B0,$A5,$AC,$A8,$8D,$00       ; ZombieD
ENEMYNAME70:
.byte $9C,$8C,$9E,$96,$00                   ; SCUM
ENEMYNAME71:
.byte $96,$9E,$8C,$94,$00                   ; MUCK
ENEMYNAME72:
.byte $98,$98,$A3,$8E,$00                   ; OOZE
ENEMYNAME73:
.byte $9C,$95,$92,$96,$8E,$00               ; SLIME
ENEMYNAME74:
.byte $9C,$99,$92,$8D,$8E,$9B,$00           ; SPIDER
ENEMYNAME75:
.byte $8A,$9B,$8A,$8C,$91,$97,$92,$8D,$00   ; ARACHNID
ENEMYNAME76:
.byte $96,$8A,$97,$9D,$92,$8C,$98,$9B,$00   ; MATICOR
ENEMYNAME77:
.byte $9C,$99,$91,$92,$97,$A1,$00           ; SPHINX
ENEMYNAME78:
.byte $9B,$C0,$8A,$97,$94,$A2,$95,$98,$00   ; R.ANKYLO
ENEMYNAME79:
.byte $8A,$97,$94,$A2,$95,$98,$00           ; ANKYLO
ENEMYNAME80:
.byte $96,$9E,$96,$96,$A2,$00               ; MUMMY
ENEMYNAME81:
.byte $A0,$BD,$96,$9E,$96,$96,$A2,$00       ; WzMUMMY
ENEMYNAME82:
.byte $8C,$98,$8C,$9D,$9B,$92,$8C,$8E,$00   ; COCTRICE
ENEMYNAME83:
.byte $99,$8E,$9B,$92,$95,$92,$9C,$94,$00   ; PERILISK
ENEMYNAME84:
.byte $A0,$A2,$9F,$8E,$9B,$97,$00           ; WYVERN
ENEMYNAME85:
.byte $A0,$A2,$9B,$96,$00                   ; WYRM
ENEMYNAME86:
.byte $9D,$A2,$9B,$98,$00                   ; TYRO
ENEMYNAME87:
.byte $9D,$FF,$9B,$8E,$A1,$00               ; T REX
ENEMYNAME88:
.byte $8C,$8A,$9B,$92,$8B,$8E,$00           ; CARIBE
ENEMYNAME89:
.byte $9B,$C0,$8C,$8A,$9B,$92,$8B,$8E,$00   ; R.CARIBE
ENEMYNAME90:
.byte $90,$8A,$9D,$98,$9B,$00               ; GATOR
ENEMYNAME91:
.byte $8F,$B5,$90,$8A,$9D,$98,$9B,$00       ; FrGATOR
ENEMYNAME92:
.byte $98,$8C,$91,$98,$00                   ; OCHO
ENEMYNAME93:
.byte $97,$8A,$98,$8C,$91,$98,$00           ; NAOCHO
ENEMYNAME94:
.byte $91,$A2,$8D,$9B,$8A,$00               ; HYDRA
ENEMYNAME95:
.byte $9B,$C0,$91,$A2,$8D,$9B,$8A,$00       ; R.HYDRA
ENEMYNAME96:
.byte $90,$9E,$8A,$9B,$8D,$00               ; GAURD
ENEMYNAME97:
.byte $9C,$8E,$97,$9D,$9B,$A2,$00           ; SENTRY
ENEMYNAME98:
.byte $A0,$8A,$9D,$8E,$9B,$00               ; WATER
ENEMYNAME99:
.byte $8A,$92,$9B,$00                       ; AIR
ENEMYNAME100:
.byte $97,$8A,$90,$8A,$00                   ; NAGA
ENEMYNAME101:
.byte $90,$B5,$97,$8A,$90,$8A,$00           ; GrNAGA
ENEMYNAME102:
.byte $8C,$91,$92,$96,$8E,$9B,$8A,$00       ; CHIMERA
ENEMYNAME103:
.byte $93,$92,$96,$8E,$9B,$8A,$00           ; JIMERA
ENEMYNAME104:
.byte $A0,$92,$A3,$8A,$9B,$8D,$00           ; WIZARD
ENEMYNAME105:
.byte $9C,$98,$9B,$8C,$8E,$9B,$8E,$9B,$00   ; SORCERER
ENEMYNAME106:
.byte $90,$8A,$9B,$95,$8A,$97,$8D,$00       ; GARLAND
ENEMYNAME107:
.byte $90,$A4,$B6,$FF,$8D,$00               ; Gas D
ENEMYNAME108:
.byte $8B,$AF,$B8,$A8,$FF,$8D,$00           ; Blue D
ENEMYNAME109:
.byte $96,$B8,$A7,$90,$98,$95,$00           ; MudGOL
ENEMYNAME110:
.byte $9B,$B2,$A6,$AE,$90,$98,$95,$00       ; RockGOL
ENEMYNAME111:
.byte $92,$B5,$B2,$B1,$90,$98,$95,$00       ; IronGOL
ENEMYNAME112:
.byte $8B,$8A,$8D,$96,$8A,$97,$00           ; BADMAN
ENEMYNAME113:
.byte $8E,$9F,$92,$95,$96,$8A,$97,$00       ; EVILMAN
ENEMYNAME114:
.byte $8A,$9C,$9D,$98,$9C,$00               ; ASTOS
ENEMYNAME115:
.byte $96,$8A,$90,$8E,$00                   ; MAGE
ENEMYNAME116:
.byte $8F,$92,$90,$91,$9D,$8E,$9B,$00       ; FIGHTER
ENEMYNAME117:
.byte $96,$8A,$8D,$99,$98,$97,$A2,$00        ; MADPONY
ENEMYNAME118:
.byte $97,$92,$9D,$8E,$96,$8A,$9B,$8E,$00    ; NITEMARE
ENEMYNAME119:
.byte $A0,$A4,$B5,$96,$8E,$8C,$91,$00        ; WarMECH
ENEMYNAME120:
.byte $95,$92,$8C,$91,$00                    ; LICH
ENEMYNAME121:
.byte $94,$8A,$9B,$A2,$00                    ; KARY
ENEMYNAME122:
.byte $94,$9B,$8A,$94,$8E,$97,$00            ; KRAKEN
ENEMYNAME123:
.byte $9D,$92,$8A,$96,$8A,$9D,$00            ; TIAMAT
ENEMYNAME124:
.byte $8C,$91,$8A,$98,$9C,$00                ; CHAOS


lut_ClassSkills:
.word ClassSkill1     ; 00
.word ClassSkill2     ; 01
.word ClassSkill3     ; 02
.word ClassSkill4     ; 03
.word ClassSkill5     ; 04
.word ClassSkill6     ; 05
.word ClassSkill7     ; 06
.word ClassSkill8     ; 07
.word ClassSkill9     ; 08
.word ClassSkill10    ; 09
.word ClassSkill11    ; 0A
.word ClassSkill12    ; 0B
.word ClassSkill13    ; 0C
.word ClassSkill14    ; 0D
.word ClassSkill15    ; 0E
.word ClassSkill16    ; 0F
.word ClassSkill17    ; 10
.word ClassSkill18    ; 11
.word ClassSkill19    ; 12
.word ClassSkill20    ; 13
.word ClassSkill21    ; 14
.word ClassSkill22    ; 15
.word ClassSkill23    ; 16
.word ClassSkill24    ; 17
.word ClassSkill25    ; 18
.word ClassSkill26    ; 19
.word ClassSkill27    ; 1A
.word ClassSkill28    ; 1B
.word ClassSkill29    ; 1C
.word ClassSkill30    ; 1D
.word ClassSkillBlank ; 1E


ClassSkill1:
.BYTE $8C,$B2,$B9,$A8,$B5,$00    ; Cover
ClassSkill2:
.BYTE $9C,$B7,$A8,$A4,$AF,$00    ; Steal
ClassSkill3:
.BYTE $99,$A4,$B5,$B5,$BC,$00    ; Parry
ClassSkill4:
.BYTE $9B,$B8,$B1,$AC,$A6,$00    ; Runic
ClassSkill5:
.BYTE $99,$B5,$A4,$BC,$FF,$00    ; Pray
ClassSkill6:
.BYTE $8F,$B2,$A6,$B8,$B6,$00    ; Focus
ClassSkill7:
ClassSkill8:
ClassSkill9:
ClassSkill10:
ClassSkill11:
ClassSkill12:
ClassSkill13:
ClassSkill14:
ClassSkill15:
ClassSkill16:
ClassSkill17:
ClassSkill18:
ClassSkill19:
ClassSkill20:
ClassSkill21:
ClassSkill22:
ClassSkill23:
ClassSkill24:
ClassSkill25:
ClassSkill26:
ClassSkill27:
ClassSkill28:
ClassSkill29:
ClassSkill30:
ClassSkillBlank:
.BYTE $FF,$FF,$FF,$FF,$FF,$00    ; _____  












; But here's all the items and some more!
; When the game looks up an item name, it first gets the pointer--the two byte .word names here--and then looks that up from a table of sorts?
; I sorted all this out so you can rename items and *re-organize* them easier, which FFHackster lacks the ability to do.
; And there was just so much wasted space. So much. Now you can fill it with 8-letter item names.

;  .ALIGN  $100

lut_ItemNamePtrTbl:
.word BLANK             ; 00
.word NAME_HEAL         ; 01
.word NAME_X_HEAL       ; 02
.word NAME_ETHER        ; 03
.word NAME_ELIXIR       ; 04
.word NAME_PURE         ; 05
.word NAME_SOFT         ; 06
.word NAME_P_DOWN       ; 07
.word NAME_TENT         ; 08
.word NAME_CABIN        ; 09
.word NAME_HOUSE        ; 0A
.word NAME_EYEDROPS     ; 0B
.word NAME_SMOKEBOMB    ; 0C
.word NAME_ALARMCLOCK   ; 0D
.word BLANK             ; 0E
.word BLANK             ; 0F

;; Key Items
.word NAME_LUTE         ; 10
.word NAME_CROWN        ; 11
.word NAME_CRYSTAL      ; 12
.word NAME_HERB         ; 13
.word NAME_KEY          ; 14
.word NAME_TNT          ; 15
.word NAME_ADAMANT      ; 16
.word NAME_SLAB         ; 17
.word NAME_RUBY         ; 18
.word NAME_ROD          ; 19
.word NAME_FLOATER      ; 1A
.word NAME_CHIME        ; 1B
.word NAME_TAIL         ; 1C
.word NAME_CUBE         ; 1D
.word NAME_BOTTLE       ; 1E
.word NAME_OXYALE       ; 1F
.word NAME_CANOE        ; 20
.word NAME_LEWDS        ; 21
.word BLANK             ; 22
.word BLANK             ; 23
.word BLANK             ; 24
.word BLANK             ; 25
.word BLANK             ; 26
.word BLANK             ; 27
.word BLANK             ; 28
.word BLANK             ; 29
.word NAME_BOTTLE_ALT   ; 2A
.word NAME_LEWDS_ALT    ; 2B
.word ORB1              ; 2C
.word ORB2              ; 2D
.word ORB3              ; 2E
.word ORB4              ; 2F

.word SPELL1       ; 30 ;  MG_CURE
.word SPELL2       ; 31 ;  MG_HARM
.word SPELL3       ; 32 ;  MG_FOG
.word SPELL4       ; 33 ;  MG_RUSE
.word SPELL5       ; 34 ;  MG_FIRE
.word SPELL6       ; 35 ;  MG_SLEP
.word SPELL7       ; 36 ;  MG_LOCK
.word SPELL8       ; 37 ;  MG_LIT
.word SPELL9       ; 38 ;  MG_LAMP
.word SPELL10      ; 39 ;  MG_MUTE
.word SPELL11      ; 3A ;  MG_ALIT
.word SPELL12      ; 3B ;  MG_INVS
.word SPELL13      ; 3C ;  MG_ICE
.word SPELL14      ; 3D ;  MG_DARK
.word SPELL15      ; 3E ;  MG_TMPR
.word SPELL16      ; 3F ;  MG_SLOW
.word SPELL17      ; 40 ;  MG_CUR2
.word SPELL18      ; 41 ;  MG_HRM2
.word SPELL19      ; 42 ;  MG_AFIR
.word SPELL20      ; 43 ;  MG_HEAL
.word SPELL21      ; 44 ;  MG_FIR2
.word SPELL22      ; 45 ;  MG_HOLD
.word SPELL23      ; 46 ;  MG_LIT2
.word SPELL24      ; 47 ;  MG_LOK2
.word SPELL25      ; 48 ;  MG_PURE
.word SPELL26      ; 49 ;  MG_FEAR
.word SPELL27      ; 4A ;  MG_AICE
.word SPELL28      ; 4B ;  MG_AMUT
.word SPELL29      ; 4C ;  MG_SLP2
.word SPELL30      ; 4D ;  MG_FAST
.word SPELL31      ; 4E ;  MG_CONF
.word SPELL32      ; 4F ;  MG_ICE2
.word SPELL33      ; 50 ;  MG_CUR3
.word SPELL34      ; 51 ;  MG_LIFE
.word SPELL35      ; 52 ;  MG_HRM3
.word SPELL36      ; 53 ;  MG_HEL2
.word SPELL37      ; 54 ;  MG_FIR3
.word SPELL38      ; 55 ;  MG_BANE
.word SPELL39      ; 56 ;  MG_WARP
.word SPELL40      ; 57 ;  MG_SLO2
.word SPELL41      ; 58 ;  MG_SOFT
.word SPELL42      ; 59 ;  MG_EXIT
.word SPELL43      ; 5A ;  MG_FOG2
.word SPELL44      ; 5B ;  MG_INV2
.word SPELL45      ; 5C ;  MG_LIT3
.word SPELL46      ; 5D ;  MG_RUB
.word SPELL47      ; 5E ;  MG_QAKE
.word SPELL48      ; 5F ;  MG_STUN
.word SPELL49      ; 60 ;  MG_CUR4
.word SPELL50      ; 61 ;  MG_HRM4
.word SPELL51      ; 62 ;  MG_ARUB
.word SPELL52      ; 63 ;  MG_HEL3
.word SPELL53      ; 64 ;  MG_ICE3
.word SPELL54      ; 65 ;  MG_BRAK
.word SPELL55      ; 66 ;  MG_SABR
.word SPELL56      ; 67 ;  MG_BLND
.word SPELL57      ; 68 ;  MG_LIF2
.word SPELL58      ; 69 ;  MG_FADE
.word SPELL59      ; 6A ;  MG_WALL
.word SPELL60      ; 6B ;  MG_XFER
.word SPELL61      ; 6C ;  MG_NUKE
.word SPELL62      ; 6D ;  MG_STOP
.word SPELL63      ; 6E ;  MG_ZAP
.word SPELL64      ; 6F ;  MG_XXXX

.word BATTLESPELL1  ;  70
.word BATTLESPELL2  ;  71
.word BATTLESPELL3  ;  72
.word BATTLESPELL4  ;  73
.word BATTLESPELL5  ;  74
.word BATTLESPELL6  ;  75
.word BATTLESPELL7  ;  76
.word BATTLESPELL8  ;  77
.word BATTLESPELL9  ;  78
.word BATTLESPELL10 ;  79
.word BATTLESPELL11 ;  7A
.word BATTLESPELL12 ;  7B
.word BATTLESPELL13 ;  7C
.word BATTLESPELL14 ;  7D
.word BATTLESPELL15 ;  7E
.word BATTLESPELL16 ;  7F

.word MoneyChest1  ; 80
.word MoneyChest2  ; 81
.word MoneyChest3  ; 82
.word MoneyChest4  ; 83
.word MoneyChest5  ; 84
.word MoneyChest6  ; 85
.word MoneyChest7  ; 86
.word MoneyChest8  ; 87
.word MoneyChest9  ; 88
.word MoneyChest10 ; 89
.word MoneyChest11 ; 8A
.word MoneyChest12 ; 8B
.word MoneyChest13 ; 8C
.word MoneyChest14 ; 8D
.word MoneyChest15 ; 8E
.word MoneyChest16 ; 8F
.word MoneyChest17 ; 90
.word MoneyChest18 ; 91
.word MoneyChest19 ; 92
.word MoneyChest20 ; 93
.word MoneyChest21 ; 94
.word MoneyChest22 ; 95
.word MoneyChest23 ; 96
.word MoneyChest24 ; 97
.word MoneyChest25 ; 98
.word MoneyChest26 ; 99
.word MoneyChest27 ; 9A
.word MoneyChest28 ; 9B
.word MoneyChest29 ; 9C
.word MoneyChest30 ; 9D
.word MoneyChest31 ; 9E
.word MoneyChest32 ; 9F
.word MoneyChest33 ; A0
.word MoneyChest34 ; A1
.word MoneyChest35 ; A2
.word MoneyChest36 ; A3
.word MoneyChest37 ; A4
.word MoneyChest38 ; A5
.word MoneyChest39 ; A6
.word MoneyChest40 ; A7
.word MoneyChest41 ; A8
.word MoneyChest42 ; A9
.word MoneyChest43 ; AA
.word MoneyChest44 ; AB
.word MoneyChest45 ; AC
.word MoneyChest46 ; AD
.word MoneyChest47 ; AE
.word MoneyChest48 ; AF
.word MoneyChest49 ; B0
.word MoneyChest50 ; B1
.word MoneyChest51 ; B2
.word MoneyChest52 ; B3
.word MoneyChest53 ; B4
.word MoneyChest54 ; B5
.word MoneyChest55 ; B6
.word MoneyChest56 ; B7
.word MoneyChest57 ; B8
.word MoneyChest58 ; B9
.word MoneyChest59 ; BA
.word MoneyChest60 ; BB
.word MoneyChest61 ; BC
.word MoneyChest62 ; BD
.word MoneyChest63 ; BE
.word MoneyChest64 ; BF
.word MoneyChest65 ; C0
.word MoneyChest66 ; C1
.word MoneyChest67 ; C2
.word MoneyChest68 ; C3
.word MoneyChest69 ; C4
.word MoneyChest70 ; C5
.word MoneyChest71 ; C6
.word MoneyChest72 ; C7
.word MoneyChest73 ; C8
.word MoneyChest74 ; C9
.word MoneyChest75 ; CA
.word MoneyChest76 ; CB
.word MoneyChest77 ; CC
.word MoneyChest78 ; CD
.word MoneyChest79 ; CE
.word MoneyChest80 ; CF

.word CLASS1       ; D0
.word CLASS2       ; D1
.word CLASS3       ; D2
.word CLASS4       ; D3
.word CLASS5       ; D4
.word CLASS6       ; D5
.word CLASS7       ; D6
.word CLASS8       ; D7
.word CLASS9       ; D8
.word CLASS10      ; D9
.word CLASS11      ; DA
.word CLASS12      ; DB
.word CLASS13      ; DC
.word CLASS14      ; DD
.word CLASS15      ; DE
.word CLASS16      ; DF




; E0
; E1
; E2
; E3
; E4
; E5
; E6
; E7
; E8
; E9
; EA
; EB
; EC
; ED
; EE
; EF
; F0
; F1
; F2
; F3
; F4
; F5
; F6
; F7
; F8
; F9
; FA
; FB
; FC
; FD
; FE
; FF





lut_WeaponArmorNamePtrTbl:
.word Weapon1      ; 0  ; Wooden Nunchuck
.word Weapon2      ; 1  ; Small Knife
.word Weapon3      ; 2  ; Wooden Staff
.word Weapon4      ; 3  ; Rapier
.word Weapon5      ; 4  ; Iron Hammer
.word Weapon6      ; 5  ; Short Sword
.word Weapon7      ; 6  ; Hand Axe
.word Weapon8      ; 7  ; Scimitar
.word Weapon9      ; 8  ; Iron Nunchucks
.word Weapon10     ; 9  ; Large Knife
.word Weapon11     ; A  ; Iron Staff
.word Weapon12     ; B  ; Sabre
.word Weapon13     ; C  ; Long Sword
.word Weapon14     ; D  ; Great Axe
.word Weapon15     ; E  ; Falchion
.word Weapon16     ; F  ; Silver Knife
.word Weapon17     ; 10 ; Silver Sword
.word Weapon18     ; 11 ; Silver Hammer
.word Weapon19     ; 12 ; Silver Axe
.word Weapon20     ; 13 ; Flame Sword
.word Weapon21     ; 14 ; Ice Sword
.word Weapon22     ; 15 ; Dragon Sword
.word Weapon23     ; 16 ; Giant Sword
.word Weapon24     ; 17 ; Sun Sword
.word Weapon25     ; 18 ; Coral Sword
.word Weapon26     ; 19 ; Were Sword
.word Weapon27     ; 1A ; Rune Sword
.word Weapon28     ; 1B ; Power Staff
.word Weapon29     ; 1C ; Light Axe
.word Weapon30     ; 1D ; Heal Staff
.word Weapon31     ; 1E ; Mage Staff
.word Weapon32     ; 1F ; Defense Sword
.word Weapon33     ; 20 ; Wizard Staff
.word Weapon34     ; 21 ; Vorpal Sword
.word Weapon35     ; 22 ; CatClaw
.word Weapon36     ; 23 ; Thor Hammer
.word Weapon37     ; 24 ; Bane Sword
.word Weapon38     ; 25 ; Katana
.word Weapon39     ; 26 ; Excalibur
.word Weapon40     ; 27 ; Masamune
.word Weapon41     ; 28 ; Chicken Knife
.word Weapon42     ; 29 ; Brave Blade
.word Weapon43     ; 2A
.word Weapon44     ; 2B
.word Weapon45     ; 2C
.word Weapon46     ; 2D
.word Weapon47     ; 2E
.word Weapon48     ; 2F
.word Weapon49     ; 30
.word Weapon50     ; 31
.word Weapon51     ; 32
.word Weapon52     ; 33
.word Weapon53     ; 34
.word Weapon54     ; 35
.word Weapon55     ; 36
.word Weapon56     ; 37
.word Weapon57     ; 38
.word Weapon58     ; 39
.word Weapon59     ; 3A
.word Weapon60     ; 3B
.word Weapon61     ; 3C
.word Weapon62     ; 3D
.word Weapon63     ; 3E
.word Weapon64     ; 3F
.word Armor1       ; 40  ; Cloth T
.word Armor2       ; 41  ; Wooden Armor
.word Armor3       ; 42  ; Chain Armor
.word Armor4       ; 43  ; Iron Armor
.word Armor5       ; 44  ; Steel Armor
.word Armor6       ; 45  ; Silver Armor
.word Armor7       ; 46  ; Flame Armor
.word Armor8       ; 47  ; Ice Armor
.word Armor9       ; 48  ; Opal Armor
.word Armor10      ; 49  ; Dragon Armor
.word Armor11      ; 4A  ; Copper Q
.word Armor12      ; 4B  ; Silver Q
.word Armor13      ; 4C  ; Gold Q
.word Armor14      ; 4D  ; Opal Q
.word Armor15      ; 4E  ; White T
.word Armor16      ; 4F  ; Black T
.word Armor17      ; 50  ; Wooden Shield
.word Armor18      ; 51  ; Iron Shield
.word Armor19      ; 52  ; Silver Shield
.word Armor20      ; 53  ; Flame Shield
.word Armor21      ; 54  ; Ice Shield
.word Armor22      ; 55  ; Opal Shield
.word Armor23      ; 56  ; Aegis Shield
.word Armor24      ; 57  ; Buckler
.word Armor25      ; 58  ; Protect Cape
.word Armor26      ; 59  ; Cap
.word Armor27      ; 5A  ; Wooden Helm
.word Armor28      ; 5B  ; Iron Helm
.word Armor29      ; 5C  ; Silver Helm
.word Armor30      ; 5D  ; Opal Helm
.word Armor31      ; 5E  ; Heal Helm
.word Armor32      ; 5F  ; Ribbon
.word Armor33      ; 60  ; Gloves
.word Armor34      ; 61  ; Copper Gauntlet
.word Armor35      ; 62  ; Iron Gauntlet
.word Armor36      ; 63  ; Silver Gauntlet
.word Armor37      ; 64  ; Zeus Gauntlet
.word Armor38      ; 65  ; Power Gauntlet
.word Armor39      ; 66  ; Opal Gauntlet
.word Armor40      ; 67  ; Protect Ring
.word Armor41      ; 68
.word Armor42      ; 69
.word Armor43      ; 6A
.word Armor44      ; 6B
.word Armor45      ; 6C
.word Armor46      ; 6D
.word Armor47      ; 6E
.word Armor48      ; 6F
.word Armor49      ; 70
.word Armor50      ; 71
.word Armor51      ; 72
.word Armor52      ; 73
.word Armor53      ; 74
.word Armor54      ; 75
.word Armor55      ; 76
.word Armor56      ; 77
.word Armor57      ; 78
.word Armor58      ; 79
.word Armor59      ; 7A
.word Armor60      ; 7B
.word Armor61      ; 7C
.word Armor62      ; 7D
.word Armor63      ; 7E
.word Armor64      ; 7F


;; ITEM NAMES
;; For items with a quantity, make spaces so they're 6 letters long.

NAME_HEAL:
.byte $91,$A8,$A4,$AF,$FF,$FF,$FF,$E1,$00 ; Heal___& (E1 is the potion icon)
NAME_X_HEAL:
.byte $A1,$C2,$91,$A8,$A4,$AF,$FF,$E1,$00 ; X-Heal_&
NAME_ETHER:
.byte $8E,$B7,$AB,$A8,$B5,$FF,$FF,$E1,$00 ; Ether__&
NAME_ELIXIR:
.byte $8E,$AF,$AC,$BB,$AC,$B5,$FF,$E1,$00 ; Elixir_&
NAME_PURE:
.byte $99,$B8,$B5,$A8,$FF,$FF,$FF,$E1,$00 ; Pure___&
NAME_SOFT:
.byte $9C,$B2,$A9,$B7,$FF,$FF,$FF,$E1,$00 ; Soft___&
NAME_P_DOWN:
.byte $99,$AB,$B2,$A8,$B1,$AC,$BB,$E2,$00 ; PhoenixF
NAME_TENT:
.byte $9D,$A8,$B1,$B7,$FF,$FF,$FF,$FF,$00 ; Tent____
NAME_CABIN:
.byte $8C,$A4,$A5,$AC,$B1,$FF,$FF,$FF,$00 ; Cabin___
NAME_HOUSE:
.byte $91,$B2,$B8,$B6,$A8,$FF,$FF,$FF,$00 ; House___
NAME_EYEDROPS:
.byte $8E,$BC,$A8,$A7,$B5,$B2,$B3,$B6,$00 ; Eyedrops
NAME_SMOKEBOMB:
.byte $9C,$B0,$B2,$AE,$A8,$FF,$FF,$E3,$00 ; Smoke__Q
NAME_ALARMCLOCK:
.byte $8A,$AF,$A4,$B5,$B0,$FF,$FF,$EA,$00 ; Alarm__(clock)


ORB1: ; orbs
ORB2: ; Orbs are not listed on the item screen... but they could be? Maybe?
ORB3:
ORB4:
.BYTE $FF
BLANK:
.byte $00


;; KEY ITEMS

;; since these are NOT drawn by doing ComplexString stuff, they cannot use special control codes

NAME_LUTE:
.byte $95,$B8,$B7,$A8,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF     ; LUTE
NAME_CROWN:
.byte $8C,$B5,$B2,$BA,$B1,$FF,$FF,$FF,$FF,$FF,$FF,$FF     ; CROWN
NAME_CRYSTAL:
.byte $8C,$B5,$BC,$B6,$B7,$A4,$AF,$FF,$8E,$BC,$A8,$FF     ; CRYSTAL
NAME_HERB:
.byte $91,$A8,$B5,$A5,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF     ; HERB
NAME_KEY:
.byte $96,$BC,$B6,$B7,$AC,$A6,$FF,$94,$A8,$BC,$FF,$FF     ; KEY
NAME_TNT:
.byte $9D,$97,$9D,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF     ; TNT
NAME_ADAMANT:
.byte $8A,$A7,$A4,$B0,$A4,$B1,$B7,$AC,$B1,$A8,$FF,$FF     ; ADAMANT
NAME_SLAB:                                                
.byte $9B,$B2,$B6,$A8,$B7,$B7,$A4,$FF,$9C,$AF,$A4,$A5     ; SLAB
NAME_RUBY:                                                
.byte $9C,$B7,$A4,$B5,$FF,$9B,$B8,$A5,$BC,$FF,$FF,$FF     ; RUBY
NAME_ROD:                                                 
.byte $8E,$A4,$B5,$B7,$AB,$FF,$9B,$B2,$A7,$FF,$FF,$FF     ; ROD
NAME_FLOATER:                                             
.byte $95,$A8,$B9,$AC,$B6,$B7,$B2,$B1,$A8,$FF,$FF,$FF     ; FLOATER
NAME_CHIME:                                               
.byte $8C,$AB,$AC,$B0,$A8,$FF,$FF,$FF,$FF,$FF,$FF,$FF     ; CHIME
NAME_TAIL:                                                
.byte $9B,$A4,$B7,$BE,$B6,$FF,$9D,$A4,$AC,$AF,$FF,$FF     ; TAIL
NAME_CUBE:                                                
.byte $A0,$A4,$B5,$B3,$FF,$8C,$B8,$A5,$A8,$FF,$FF,$FF     ; CUBE
NAME_BOTTLE:                                              
.byte $8B,$B2,$B7,$B7,$AF,$A8,$FF,$FF,$FF,$FF,$FF,$FF     ; BOTTLE
NAME_BOTTLE_ALT:                                          
.byte $8B,$B2,$B7,$B7,$AF,$A8,$00                         ; BOTTLE      ; drawn in shops, so does use control codes
NAME_OXYALE:                                              
.byte $98,$BB,$BC,$A4,$AF,$A8,$FF,$FF,$FF,$FF,$FF,$FF     ; OXYALE
NAME_CANOE:                                               
.byte $8C,$A4,$B1,$B2,$A8,$FF,$FF,$FF,$FF,$FF,$FF,$FF     ; CANOE
NAME_LEWDS:                                               
.byte $95,$A8,$BA,$A7,$FF,$9D,$A8,$BB,$B7,$B6,$FF,$FF     ; Lewd Texts
NAME_LEWDS_ALT:
.byte $C5,$C5,$C5,$FF,$8B,$B2,$B2,$AE,$00                 ; ??? Book    ; drawn in shops, so does use control codes












;;Magic spell names
;;
;; Updated for 7 letter spells!
;; Since the code that draws spell names assumes 4 letters, it was easier for them to have the occasional $FF (Ice_)
;; than it was to bother padding it out... so these need to be 8 bytes each even if your spell is 3 letters long.
;; So if you have, say, CONFUSE, ICE, and FIRE 2 in the same line, the space between ICE and FIRE 2 will be too short...
;;
;; The issue with 7 letter names is that if you only have one spell, the cursor will block the number of max mana. Oh well!
;; You'd have to make a side-less box or something to widen it any further. Would look weird!

SPELL1:
;.byte $8C,$9E,$9B,$8E,$00 ; CURE
.byte $8C,$9E,$9B,$8E,$FF,$FF,$FF,$00  ;  CURE___
SPELL2:
;.byte $91,$8A,$9B,$96,$00 ; HARM
.byte $91,$8A,$9B,$96,$FF,$FF,$FF,$00  ;  HARM___
SPELL3:
;.byte $8F,$98,$90,$FF,$00 ; FOG_
.byte $9C,$91,$92,$8E,$95,$8D,$FF,$00  ;  SHIELD_
SPELL4:
;.byte $9B,$9E,$9C,$8E,$00 ; RUSE
.byte $8B,$95,$92,$97,$94,$FF,$FF,$00  ;  BLINK__
SPELL5:
;.byte $8F,$92,$9B,$8E,$00 ; FIRE
.byte $8F,$92,$9B,$8E,$FF,$FF,$FF,$00  ;  FIRE___
SPELL6:
;.byte $9C,$95,$8E,$99,$00 ; SLEP
.byte $9C,$95,$8E,$8E,$99,$FF,$FF,$00  ;  SLEEP__
SPELL7:
;.byte $95,$98,$8C,$94,$00 ; LOCK
.byte $95,$98,$8C,$94,$FF,$FF,$FF,$00  ;  LOCK___
SPELL8:
;.byte $95,$92,$9D,$FF,$00 ; LIT_
.byte $8B,$98,$95,$9D,$FF,$FF,$FF,$00  ;  BOLT___
SPELL9:
;.byte $95,$8A,$96,$99,$00 ; LAMP
.byte $95,$8A,$96,$99,$FF,$FF,$FF,$00  ;  LAMP___
SPELL10:
;.byte $96,$9E,$9D,$8E,$00 ; MUTE
.byte $96,$9E,$9D,$8E,$FF,$FF,$FF,$00  ;  MUTE___
SPELL11:
;.byte $8A,$95,$92,$9D,$00 ; ALIT
.byte $8B,$98,$95,$9D,$FF,$FF,$DB,$00  ;  BOLT__(Shield)
SPELL12:
;.byte $92,$97,$9F,$9C,$00 ; INVS
.byte $92,$97,$9F,$92,$9C,$FF,$FF,$00  ;  INVIS__
SPELL13:
;.byte $92,$8C,$8E,$FF,$00 ; ICE_
.byte $92,$8C,$8E,$FF,$FF,$FF,$FF,$00  ;  ICE____
SPELL14:
;.byte $8D,$8A,$9B,$94,$00 ; DARK
.byte $8D,$8A,$9B,$94,$FF,$FF,$FF,$00  ;  DARK___
SPELL15:
;.byte $9D,$96,$99,$9B,$00 ; TMPR
.byte $9D,$8E,$96,$99,$8E,$9B,$FF,$00  ;  TEMPER_
SPELL16:
;.byte $9C,$95,$98,$A0,$00 ; SLOW
.byte $9C,$95,$98,$A0,$FF,$FF,$FF,$00  ;  SLOW___
SPELL17:
;.byte $8C,$9E,$9B,$82,$00 ; CUR2
.byte $8C,$9E,$9B,$8E,$FF,$FF,$82,$00  ;  CURE__2
SPELL18:
;.byte $91,$9B,$96,$82,$00 ; HRM2
.byte $91,$8A,$9B,$96,$FF,$FF,$82,$00  ;  HARM__2
SPELL19:
;.byte $8A,$8F,$92,$9B,$00 ; AFIR
.byte $8F,$92,$9B,$8E,$FF,$FF,$DB,$00  ;  FIRE__(shield)
SPELL20:
;.byte $91,$8E,$8A,$95,$00 ; HEAL
;.byte $91,$8E,$8A,$95,$FF,$FF,$FF,$00  ;  HEAL___
.byte $9B,$8E,$90,$8E,$97,$FF,$FF,$00  ; REGEN__
SPELL21:
;.byte $8F,$92,$9B,$82,$00 ; FIR2
.byte $8F,$92,$9B,$8E,$FF,$FF,$82,$00  ;  FIRE__2
SPELL22:
;.byte $91,$98,$95,$8D,$00 ; HOLD
.byte $91,$98,$95,$8D,$FF,$FF,$FF,$00  ;  HOLD___
SPELL23:
;.byte $95,$92,$9D,$82,$00 ; LIT2
.byte $8B,$98,$95,$9D,$FF,$FF,$82,$00  ;  BOLT__2
SPELL24:
;.byte $95,$98,$94,$82,$00 ; L0K2
.byte $95,$98,$8C,$94,$FF,$FF,$82,$00  ;  LOCK__2
SPELL25:
;.byte $99,$9E,$9B,$8E,$00 ; PURE
.byte $99,$9E,$9B,$8E,$FF,$FF,$FF,$00  ;  PURE___
SPELL26:
;.byte $8F,$8E,$8A,$9B,$00 ; FEAR
.byte $8F,$8E,$8A,$9B,$FF,$FF,$FF,$00  ;  FEAR___
SPELL27:
;.byte $8A,$92,$8C,$8E,$00 ; AICE
.byte $92,$8C,$8E,$FF,$FF,$FF,$DB,$00  ;  ICE___(shield)
SPELL28:
;.byte $8A,$96,$9E,$9D,$00 ; AMUT
.byte $9F,$98,$92,$8C,$8E,$FF,$FF,$00  ;  VOICE__
SPELL29:
;.byte $9C,$95,$99,$82,$00 ; SLP2
.byte $9C,$95,$8E,$8E,$99,$FF,$82,$00  ;  SLEEP_2
SPELL30:
;.byte $8F,$8A,$9C,$9D,$00 ; FAST
.byte $8F,$8A,$9C,$9D,$FF,$FF,$FF,$00  ;  FAST
SPELL31:
;.byte $8C,$98,$97,$8F,$00 ; CONF
.byte $8C,$98,$97,$8F,$9E,$9C,$8E,$00  ;  CONFUSE
SPELL32:
;.byte $92,$8C,$8E,$82,$00 ; ICE2
.byte $92,$8C,$8E,$FF,$FF,$FF,$82,$00  ;  ICE___2
SPELL33:
;.byte $8C,$9E,$9B,$83,$00 ; CUR3
.byte $8C,$9E,$9B,$8E,$FF,$FF,$83,$00  ;  CURE__3
SPELL34:
;.byte $95,$92,$8F,$8E,$00 ; LIFE
.byte $95,$92,$8F,$8E,$FF,$FF,$FF,$00  ;  LIFE___
SPELL35:
;.byte $91,$9B,$96,$83,$00 ; HRM3
.byte $91,$8A,$9B,$96,$FF,$FF,$83,$00  ;  HARM__3
SPELL36:
;.byte $91,$8E,$95,$82,$00 ; HEL2
;.byte $91,$8E,$8A,$95,$FF,$FF,$82,$00  ;  HEAL__2
.byte $9B,$8E,$90,$8E,$97,$FF,$82,$00  ; REGEN_2
SPELL37:
;.byte $8F,$92,$9B,$83,$00 ; FIR3
.byte $8F,$92,$9B,$8E,$FF,$FF,$83,$00  ;  FIRE__3
SPELL38:
;.byte $8B,$8A,$97,$8E,$00 ; BANE
.byte $8B,$8A,$97,$8E,$FF,$FF,$FF,$00  ;  BANE___
SPELL39:
;.byte $A0,$8A,$9B,$99,$00 ; WARP
.byte $A0,$8A,$9B,$99,$FF,$FF,$FF,$00  ;  WARP___
SPELL40:
;.byte $9C,$95,$98,$82,$00 ; SL02
.byte $9C,$95,$98,$A0,$FF,$FF,$82,$00  ;  SLOW__2
SPELL41:
;.byte $9C,$98,$8F,$9D,$00 ; SOFT
.byte $9C,$98,$8F,$9D,$FF,$FF,$FF,$00  ;  SOFT___
SPELL42:
;.byte $8E,$A1,$92,$9D,$00 ; EXIT
.byte $8E,$A1,$92,$9D,$FF,$FF,$FF,$00  ;  EXIT___
SPELL43:
;.byte $8F,$98,$90,$82,$00 ; FOG2
.byte $9C,$91,$92,$8E,$95,$8D,$82,$00  ;  SHIELD2
SPELL44:
;.byte $92,$97,$9F,$82,$00 ; INV2
.byte $92,$97,$9F,$92,$9C,$FF,$82,$00  ;  INVIS_2
SPELL45:
;.byte $95,$92,$9D,$83,$00 ; LIT3
.byte $8B,$98,$95,$9D,$FF,$FF,$83,$00  ;  BOLT__3
SPELL46:
;.byte $9B,$9E,$8B,$FF,$00 ; RUB_
.byte $9B,$9E,$8B,$FF,$FF,$FF,$FF,$00  ;  RUB____
SPELL47:
;.byte $9A,$8A,$94,$8E,$00 ; QAKE
.byte $9A,$9E,$8A,$94,$8E,$FF,$FF,$00  ;  QUAKE__
SPELL48:
;.byte $9C,$9D,$9E,$97,$00 ; STUN
.byte $9C,$9D,$9E,$97,$FF,$FF,$FF,$00  ;  STUN___
SPELL49:
;.byte $8C,$9E,$9B,$84,$00 ; CUR4
.byte $8C,$9E,$9B,$8E,$FF,$FF,$84,$00  ;  CURE__4
SPELL50:
;.byte $91,$9B,$96,$84,$00 ; HRM4
.byte $91,$8A,$9B,$96,$FF,$FF,$84,$00  ;  HARM__4
SPELL51:
;.byte $8A,$9B,$9E,$8B,$00 ; ARUB
.byte $9B,$9E,$8B,$FF,$FF,$FF,$DB,$00  ;  RUB___(shield)
SPELL52:
;.byte $91,$8E,$95,$83,$00 ; HEL3
;.byte $91,$8E,$8A,$95,$FF,$FF,$83,$00  ;  HEAL__3
.byte $9B,$8E,$90,$8E,$97,$FF,$83,$00  ; REGEN_3
SPELL53:
;.byte $92,$8C,$8E,$83,$00 ; ICE3
.byte $92,$8C,$8E,$FF,$FF,$FF,$83,$00  ;  ICE___3
SPELL54:
;.byte $8B,$9B,$8A,$94,$00 ; BRAK
.byte $8B,$9B,$8E,$8A,$94,$FF,$FF,$00  ;  BREAK__
SPELL55:
;.byte $9C,$8A,$8B,$9B,$00 ; SABR
.byte $9C,$8A,$8B,$8E,$9B,$FF,$FF,$00  ;  SABER__
SPELL56:
;.byte $8B,$95,$97,$8D,$00 ; BLND
.byte $8B,$95,$92,$97,$8D,$FF,$FF,$00  ;  BLIND__
SPELL57:
;.byte $95,$92,$8F,$82,$00 ; LIF2
.byte $95,$92,$8F,$8E,$FF,$FF,$82,$00  ;  LIFE__2
SPELL58:
;.byte $8F,$8A,$8D,$8E,$00 ; FADE
.byte $91,$98,$95,$A2,$FF,$FF,$FF,$00  ;  HOLY___
SPELL59:
;.byte $A0,$8A,$95,$95,$00 ; WALL
.byte $A0,$8A,$95,$95,$FF,$FF,$FF,$00  ;  WALL___
SPELL60:
;.byte $A1,$8F,$8E,$9B,$00 ; XFER
.byte $8D,$92,$9C,$99,$8E,$95,$FF,$00  ;  DISPEL_
SPELL61:
;.byte $97,$9E,$94,$8E,$00 ; NUKE
.byte $8F,$95,$8A,$9B,$8E,$FF,$FF,$00  ;  FLARE__
SPELL62:
;.byte $9C,$9D,$98,$99,$00 ; STOP
.byte $9C,$9D,$98,$99,$FF,$FF,$FF,$00  ;  STOP___
SPELL63:
;.byte $A3,$8A,$99,$C4,$00 ; ZAP!
.byte $8B,$8A,$97,$92,$9C,$91,$FF,$00  ;  BANISH_
SPELL64:
;.byte $A1,$A1,$A1,$A1,$00 ; XXXX
.byte $8D,$8E,$8A,$9D,$91,$FF,$FF,$00  ;  DEATH__


BATTLESPELL1: ; CC
.byte $91,$8E,$8A,$95,$FF,$FF,$FF,$00  ;  HEAL
BATTLESPELL2: ; CD
.byte $91,$8E,$8A,$95,$FF,$FF,$82,$00  ;  HEAL__2
BATTLESPELL3: ; CE
.byte $91,$8E,$8A,$95,$FF,$FF,$83,$00  ;  HEAL__3
BATTLESPELL4: ; CF
.byte $99,$9B,$8A,$A2,$8E,$9B,$FF,$00  ;  PRAYER
BATTLESPELL5: ; D0
.BYTE $9B,$8E,$8F,$95,$8E,$8C,$9D,$00  ;  REFLECT
BATTLESPELL6: ; D1
.BYTE $9B,$8E,$8F,$95,$8C,$9D,$82,$00  ;  REFLCT2
BATTLESPELL7: ; D2
BATTLESPELL8: ; D3
BATTLESPELL9: ; D4
BATTLESPELL10: ; D5
BATTLESPELL11: ; D6
BATTLESPELL12: ; D7
BATTLESPELL13: ; D8
BATTLESPELL14: ; D9
BATTLESPELL15: ; DA
BATTLESPELL16: ; DB
.BYTE $8C,$98,$9E,$97,$9D,$8E,$9B,$00  ;  COUNTER





;gold in chests
;; Note this is only the text data. Actual amount given is in the price list at the start of Bank 9
MoneyChest1:
.byte $81,$80,$FF,$90,$00 ; 10
MoneyChest2:
.byte $82,$80,$FF,$90,$00 ; 20
MoneyChest3:
.byte $82,$85,$FF,$90,$00 ; 25
MoneyChest4:
.byte $83,$80,$FF,$90,$00 ; 30
MoneyChest5:
.byte $85,$85,$FF,$90,$00 ; 55
MoneyChest6:
.byte $87,$80,$FF,$90,$00 ; 70
MoneyChest7:
.byte $88,$85,$FF,$90,$00 ; 85
MoneyChest8:
.byte $81,$81,$80,$FF,$90,$00 ; 110
MoneyChest9:
.byte $81,$83,$85,$FF,$90,$00 ; 135
MoneyChest10:
.byte $81,$85,$85,$FF,$90,$00 ; 155
MoneyChest11:
.byte $81,$86,$80,$FF,$90,$00 ; 160
MoneyChest12:
.byte $81,$88,$80,$FF,$90,$00 ; 180
MoneyChest13:
.byte $82,$84,$80,$FF,$90,$00 ; 240
MoneyChest14:
.byte $82,$85,$85,$FF,$90,$00 ; 255
MoneyChest15:
.byte $82,$86,$80,$FF,$90,$00 ; 260
MoneyChest16:
.byte $82,$89,$85,$FF,$90,$00 ; 295
MoneyChest17:
.byte $83,$80,$80,$FF,$90,$00 ; 300
MoneyChest18:
.byte $83,$81,$85,$FF,$90,$00 ; 315
MoneyChest19:
.byte $83,$83,$80,$FF,$90,$00 ; 330
MoneyChest20:
.byte $83,$85,$80,$FF,$90,$00 ; 350
MoneyChest21:
.byte $83,$88,$85,$FF,$90,$00 ; 385
MoneyChest22:
.byte $84,$80,$80,$FF,$90,$00 ; 400
MoneyChest23:
.byte $84,$85,$80,$FF,$90,$00 ; 450
MoneyChest24:
.byte $85,$80,$80,$FF,$90,$00 ; 500
MoneyChest25:
.byte $85,$83,$80,$FF,$90,$00 ; 530
MoneyChest26:
.byte $85,$87,$85,$FF,$90,$00 ; 575
MoneyChest27:
.byte $86,$82,$80,$FF,$90,$00 ; 620
MoneyChest28:
.byte $86,$88,$80,$FF,$90,$00 ; 680
MoneyChest29:
.byte $87,$85,$80,$FF,$90,$00 ; 750
MoneyChest30:
.byte $87,$89,$85,$FF,$90,$00 ; 795
MoneyChest31:
.byte $88,$88,$80,$FF,$90,$00 ; 880
MoneyChest32:
.byte $81,$80,$82,$80,$FF,$90,$00 ; 1020
MoneyChest33:
.byte $81,$82,$85,$80,$FF,$90,$00 ; 1250
MoneyChest34:
.byte $81,$84,$85,$85,$FF,$90,$00 ; 1455
MoneyChest35:
.byte $81,$85,$82,$80,$FF,$90,$00 ; 1520
MoneyChest36:
.byte $81,$87,$86,$80,$FF,$90,$00 ; 1760
MoneyChest37:
.byte $81,$89,$87,$85,$FF,$90,$00 ; 1975
MoneyChest38:
.byte $82,$80,$80,$80,$FF,$90,$00 ; 2000
MoneyChest39:
.byte $82,$87,$85,$80,$FF,$90,$00 ; 2750
MoneyChest40:
.byte $83,$84,$80,$80,$FF,$90,$00 ; 3400
MoneyChest41:
.byte $84,$81,$85,$80,$FF,$90,$00 ; 4150
MoneyChest42:
.byte $85,$80,$80,$80,$FF,$90,$00 ; 5000
MoneyChest43:
.byte $85,$84,$85,$80,$FF,$90,$00 ; 5450
MoneyChest44:
.byte $86,$84,$80,$80,$FF,$90,$00 ; 6400
MoneyChest45:
.byte $86,$87,$82,$80,$FF,$90,$00 ; 6720
MoneyChest46:
.byte $87,$83,$84,$80,$FF,$90,$00 ; 7340
MoneyChest47:
.byte $87,$86,$89,$80,$FF,$90,$00 ; 7690
MoneyChest48:
.byte $87,$89,$80,$80,$FF,$90,$00 ; 7900
MoneyChest49:
.byte $88,$81,$83,$85,$FF,$90,$00 ; 8135
MoneyChest50:
.byte $89,$80,$80,$80,$FF,$90,$00 ; 9000
MoneyChest51:
.byte $89,$83,$80,$80,$FF,$90,$00 ; 9300
MoneyChest52:
.byte $89,$85,$80,$80,$FF,$90,$00 ; 9500
MoneyChest53:
.byte $89,$89,$80,$80,$FF,$90,$00 ; 9900
MoneyChest54:
.byte $81,$80,$80,$80,$80,$FF,$90,$00 ; 10000
MoneyChest55:
.byte $81,$82,$83,$85,$80,$FF,$90,$00 ; 12350
MoneyChest56:
.byte $81,$83,$80,$80,$80,$FF,$90,$00 ; 13000
MoneyChest57:
.byte $81,$83,$84,$85,$80,$FF,$90,$00 ; 13450
MoneyChest58:
.byte $81,$84,$80,$85,$80,$FF,$90,$00 ; 14050
MoneyChest59:
.byte $81,$84,$87,$82,$80,$FF,$90,$00 ; 14720
MoneyChest60:
.byte $81,$85,$80,$80,$80,$FF,$90,$00 ; 15000
MoneyChest61:
.byte $81,$87,$84,$89,$80,$FF,$90,$00 ; 17490
MoneyChest62:
.byte $81,$88,$80,$81,$80,$FF,$90,$00 ; 18010
MoneyChest63:
.byte $81,$89,$89,$89,$80,$FF,$90,$00 ; 19990
MoneyChest64:
.byte $82,$80,$80,$80,$80,$FF,$90,$00 ; 20000
MoneyChest65:
.byte $82,$80,$80,$81,$80,$FF,$90,$00 ; 20010
MoneyChest66:
.byte $82,$86,$80,$80,$80,$FF,$90,$00 ; 26000
MoneyChest67:
.byte $84,$85,$80,$80,$80,$FF,$90,$00 ; 45000
MoneyChest68:
.byte $86,$85,$80,$80,$80,$FF,$90,$00 ; 65000
MoneyChest69:
.byte $86,$85,$80,$80,$80,$FF,$90,$00 ; 65000
MoneyChest70:
.byte $86,$85,$80,$80,$80,$FF,$90,$00 ; 65000
MoneyChest71:
.byte $86,$85,$80,$80,$80,$FF,$90,$00 ; 65000
MoneyChest72:
.byte $86,$85,$80,$80,$80,$FF,$90,$00 ; 65000
MoneyChest73:
.byte $86,$85,$80,$80,$80,$FF,$90,$00 ; 65000
MoneyChest74:
.byte $86,$85,$80,$80,$80,$FF,$90,$00 ; 65000
MoneyChest75:
.byte $86,$85,$80,$80,$80,$FF,$90,$00 ; 65000
MoneyChest76:
.byte $86,$85,$80,$80,$80,$FF,$90,$00 ; 65000
MoneyChest77:
.byte $86,$85,$80,$80,$80,$FF,$90,$00 ; 65000
MoneyChest78:
.byte $86,$85,$80,$80,$80,$FF,$90,$00 ; 65000
MoneyChest79:
.byte $86,$85,$80,$80,$80,$FF,$90,$00 ; 65000
MoneyChest80:
.byte $86,$85,$80,$80,$80,$FF,$90,$00 ; 65000





;;CLASS NAMES


CLASS1:
.byte $8F,$92,$90,$91,$9D,$8E,$9B,$00 ; FIGHTER
CLASS2:
.byte $9D,$91,$92,$8E,$8F,$FF,$FF,$00 ; THIEF__
CLASS3:
.byte $8B,$AF,$C0,$8B,$8E,$95,$9D,$00 ; Bl.BELT
CLASS4:
.byte $9B,$A8,$A7,$96,$8A,$90,$8E,$00 ; RedMAGE
CLASS5:
.byte $A0,$AB,$C0,$96,$8A,$90,$8E,$00 ; Wh.MAGE
CLASS6:
.byte $8B,$AF,$C0,$96,$8A,$90,$8E,$00 ; Bl.MAGE
CLASS7:
.byte $8B,$AF,$C0,$A0,$AC,$BD,$FF,$00 ; 
CLASS8:
.byte $8B,$AF,$C0,$A0,$AC,$BD,$FF,$00 ; 

CLASS9:
.byte $94,$97,$92,$90,$91,$9D,$FF,$00 ; KNIGHT_
CLASS10:
.byte $97,$92,$97,$93,$8A,$FF,$FF,$00 ; NINJA__
CLASS11:
.byte $96,$8A,$9C,$9D,$8E,$9B,$FF,$00 ; MASTER_
CLASS12:
.byte $9B,$A8,$A7,$A0,$AC,$BD,$FF,$00 ; RedWiz_
CLASS13:
.byte $A0,$AB,$C0,$A0,$AC,$BD,$FF,$00 ; Wh.Wiz_
CLASS14:
.byte $8B,$AF,$C0,$A0,$AC,$BD,$FF,$00 ; Bl.Wiz_
CLASS15:
.byte $8B,$AF,$C0,$A0,$AC,$BD,$FF,$00 ; 
CLASS16:
.byte $8B,$AF,$C0,$A0,$AC,$BD,$FF,$00 ; 




;; WEAPONS AND ARMORS
;; Note that the names I wrote by the bytes are not exactly what the bytes say
;; as I've tried to do in the other lists. Since I didn't edit anything that I can remember... it should all be vanilla.
;; so the names are fancy!

Weapon1: ; 00
.BYTE $A0,$B2,$B2,$A7,$A8,$B1,$D9,$FF,$00 ; Wooden Nunchucks
Weapon2: ; 01
.byte $9C,$B0,$A4,$AF,$AF,$FF,$D6,$FF,$00 ; Small Knife
Weapon3: ; 02
.byte $A0,$B2,$B2,$A7,$A8,$B1,$D8,$FF,$00 ; Wooden Staff
Weapon4: ; 03
.byte $9B,$A4,$B3,$AC,$A8,$B5,$FF,$FF,$00 ; Rapier
Weapon5: ; 04
.byte $92,$B5,$B2,$B1,$FF,$FF,$D5,$FF,$00 ; Iron Hammer
Weapon6: ; 05
.byte $9C,$AB,$B2,$B5,$B7,$FF,$D4,$FF,$00 ; Short Sword
Weapon7: ; 06
.byte $91,$A4,$B1,$A7,$FF,$FF,$D7,$FF,$00 ; Hand Axe
Weapon8: ; 07
.byte $9C,$A6,$AC,$B0,$B7,$A4,$B5,$FF,$00 ; Scimitar
Weapon9: ; 08
.byte $92,$B5,$B2,$B1,$FF,$FF,$D9,$FF,$00 ; Iron Nunchucks
Weapon10: ; 09
.byte $95,$A4,$B5,$AA,$A8,$FF,$D6,$FF,$00 ; Large Knife
Weapon11: ; 0A
.byte $92,$B5,$B2,$B1,$FF,$FF,$D8,$FF,$00 ; Iron Staff
Weapon12: ; 0B
.byte $9C,$A4,$A5,$B5,$A8,$FF,$FF,$FF,$00 ; Sabre
Weapon13: ; 0C
.byte $95,$B2,$B1,$AA,$FF,$FF,$D4,$FF,$00 ; Long Sword
Weapon14: ; 0D
.byte $90,$B5,$A8,$A4,$B7,$FF,$D7,$FF,$00 ; Great Axe
Weapon15: ; 0E
.byte $8F,$A4,$AF,$A6,$AB,$B2,$B1,$FF,$00 ; Falchion
Weapon16: ; 0F
.byte $9C,$AC,$AF,$B9,$A8,$B5,$D6,$FF,$00 ; Silver Knife
Weapon17: ; 10
.byte $9C,$AC,$AF,$B9,$A8,$B5,$D4,$FF,$00 ; Silver Sword
Weapon18: ; 11
.byte $9C,$AC,$AF,$B9,$A8,$B5,$D5,$FF,$00 ; Silver Hammer
Weapon19: ; 12
.byte $9C,$AC,$AF,$B9,$A8,$B5,$D7,$FF,$00 ; Silver Axe
Weapon20: ; 13
.byte $8F,$AF,$A4,$B0,$A8,$FF,$D4,$FF,$00 ; Flame Sword
Weapon21: ; 14
.byte $92,$A6,$A8,$FF,$FF,$FF,$D4,$FF,$00 ; Ice Sword
Weapon22: ; 15
.byte $8D,$B5,$A4,$AA,$B2,$B1,$D4,$FF,$00 ; Dragon Sword
Weapon23: ; 16
.byte $90,$AC,$A4,$B1,$B7,$FF,$D4,$FF,$00 ; Giant Sword
Weapon24: ; 17
.byte $9C,$B8,$B1,$FF,$FF,$FF,$D4,$FF,$00 ; Sun Sword
Weapon25: ; 18
.byte $8C,$B2,$B5,$A4,$AF,$FF,$D4,$FF,$00 ; Coral Sword
Weapon26: ; 19
.byte $A0,$A8,$B5,$A8,$FF,$FF,$D4,$FF,$00 ; Were Sword
Weapon27: ; 1A
.byte $9B,$B8,$B1,$A8,$FF,$FF,$D4,$FF,$00 ; Rune Sword
Weapon28: ; 1B
.byte $99,$B2,$BA,$A8,$B5,$FF,$D8,$FF,$00 ; Power Staff
Weapon29: ; 1C
.byte $95,$AC,$AA,$AB,$B7,$FF,$D7,$FF,$00 ; Light Axe
Weapon30: ; 1D
.byte $91,$A8,$A4,$AF,$FF,$FF,$D8,$FF,$00 ; Heal Staff
Weapon31: ; 1E
.byte $96,$A4,$AA,$A8,$FF,$FF,$D8,$FF,$00 ; Mage Staff
Weapon32: ; 1F
.byte $8D,$A8,$A9,$A8,$B1,$B6,$A8,$FF,$00 ; Defense Sword
Weapon33: ; 20
.byte $A0,$AC,$BD,$A4,$B5,$A7,$D8,$FF,$00 ; Wizard Staff
Weapon34: ; 21
.byte $9F,$B2,$B5,$B3,$A4,$AF,$FF,$FF,$00 ; Vorpal Sword
Weapon35: ; 22
.byte $8C,$A4,$B7,$8C,$AF,$A4,$BA,$FF,$00 ; CatClaw
Weapon36: ; 23
.byte $9D,$AB,$B2,$B5,$FF,$FF,$D5,$FF,$00 ; Thor Hammer
Weapon37: ; 24
.byte $8B,$A4,$B1,$A8,$FF,$FF,$D4,$FF,$00 ; Bane Sword
Weapon38: ; 25
.byte $94,$A4,$B7,$A4,$B1,$A4,$FF,$FF,$00 ; Katana
Weapon39: ; 26
.byte $A1,$A6,$A4,$AF,$A5,$A8,$B5,$FF,$00 ; Excalibur
Weapon40: ; 27
.byte $96,$A4,$B6,$B0,$B8,$B1,$A8,$FF,$00 ; Masamune
Weapon41: ; 28
.byte $8C,$AB,$AC,$A6,$AE,$A8,$B1,$D6,$00 ; Chicken Knife
Weapon42: ; 29
.byte $8B,$B5,$A4,$B9,$A8,$FF,$D4,$FF,$00 ; Brave Blade
Weapon43: ; 2A
Weapon44: ; 2B
Weapon45: ; 2C
Weapon46: ; 2D
Weapon47: ; 2E
Weapon48: ; 2F
Weapon49: ; 30
Weapon50: ; 31
Weapon51: ; 32
Weapon52: ; 33
Weapon53: ; 34
Weapon54: ; 35
Weapon55: ; 36
Weapon56: ; 37
Weapon57: ; 38
Weapon58: ; 39
Weapon59: ; 3A
Weapon60: ; 3B
Weapon61: ; 3C
Weapon62: ; 3D
Weapon63: ; 3E
Weapon64: ; 3F

Armor1: ; 40
.byte $8C,$AF,$B2,$B7,$AB,$FF,$FF,$FF,$00 ; Cloth T
Armor2: ; 41
.byte $A0,$B2,$B2,$A7,$A8,$B1,$DA,$FF,$00 ; Wooden Armor
Armor3: ; 42
.byte $8C,$AB,$A4,$AC,$B1,$FF,$DA,$FF,$00 ; Chain Armor
Armor4: ; 43
.byte $92,$B5,$B2,$B1,$FF,$FF,$DA,$FF,$00 ; Iron Armor
Armor5: ; 44
.byte $9C,$B7,$A8,$A8,$AF,$FF,$DA,$FF,$00 ; Steel Armor
Armor6: ; 45
.byte $9C,$AC,$AF,$B9,$A8,$B5,$DA,$FF,$00 ; Silver Armor
Armor7: ; 46
.byte $8F,$AF,$A4,$B0,$A8,$FF,$DA,$FF,$00 ; Flame Armor
Armor8: ; 47
.byte $92,$A6,$A8,$FF,$FF,$FF,$DA,$FF,$00 ; Ice Armor
Armor9: ; 48
.byte $98,$B3,$A4,$AF,$FF,$FF,$DA,$FF,$00 ; Opal Armor
Armor10: ; 49
.byte $8D,$B5,$A4,$AA,$B2,$B1,$DA,$FF,$00 ; Dragon Armor
Armor11: ; 4A
.byte $8C,$B2,$B3,$B3,$A8,$B5,$DE,$FF,$00 ; Copper Q
Armor12: ; 4B
.byte $9C,$AC,$AF,$B9,$A8,$B5,$DE,$FF,$00 ; Silver Q
Armor13: ; 4C
.byte $90,$B2,$AF,$A7,$FF,$FF,$DE,$FF,$00 ; Gold Q
Armor14: ; 4D
.byte $98,$B3,$A4,$AF,$FF,$FF,$DE,$FF,$00 ; Opal Q
Armor15: ; 4E
.byte $A0,$AB,$AC,$B7,$A8,$FF,$DF,$FF,$00 ; White T
Armor16: ; 4F
.byte $8B,$AF,$A4,$A6,$AE,$FF,$DF,$FF,$00 ; Black T
Armor17: ; 50
.byte $A0,$B2,$B2,$A7,$A8,$B1,$DB,$FF,$00 ; Wooden Shield
Armor18: ; 51
.byte $92,$B5,$B2,$B1,$FF,$FF,$DB,$FF,$00 ; Iron Shield
Armor19: ; 52
.byte $9C,$AC,$AF,$B9,$A8,$B5,$DB,$FF,$00 ; Silver Shield
Armor20: ; 53
.byte $8F,$AF,$A4,$B0,$A8,$FF,$DB,$FF,$00 ; Flame Shield
Armor21: ; 54
.byte $92,$A6,$A8,$FF,$FF,$FF,$DB,$FF,$00 ; Ice Shield
Armor22: ; 55
.byte $98,$B3,$A4,$AF,$FF,$FF,$DB,$FF,$00 ; Opal Shield
Armor23: ; 56
.byte $8A,$A8,$AA,$AC,$B6,$FF,$DB,$FF,$00 ; Aegis Shield
Armor24: ; 57
.byte $8B,$B8,$A6,$AE,$AF,$A8,$B5,$FF,$00 ; Buckler
Armor25: ; 58
.byte $99,$B5,$B2,$8C,$A4,$B3,$A8,$FF,$00 ; Protect Cape
Armor26: ; 59
.byte $8C,$A4,$B3,$FF,$FF,$FF,$FF,$FF,$00 ; Cap
Armor27: ; 5A
.byte $A0,$B2,$B2,$A7,$A8,$B1,$DC,$FF,$00 ; Wooden Helm
Armor28: ; 5B
.byte $92,$B5,$B2,$B1,$FF,$FF,$DC,$FF,$00 ; Iron Helm
Armor29: ; 5C
.byte $9C,$AC,$AF,$B9,$A8,$B5,$DC,$FF,$00 ; Silver Helm
Armor30: ; 5D
.byte $98,$B3,$A4,$AF,$FF,$FF,$DC,$FF,$00 ; Opal Helm
Armor31: ; 5E
.byte $91,$A8,$A4,$AF,$FF,$FF,$DC,$FF,$00 ; Heal Helm
Armor32: ; 5F
.byte $9B,$AC,$A5,$A5,$B2,$B1,$FF,$FF,$00 ; Ribbon
Armor33: ; 60
.byte $90,$AF,$B2,$B9,$A8,$B6,$FF,$FF,$00 ; Gloves
Armor34: ; 61
.byte $8C,$B2,$B3,$B3,$A8,$B5,$DD,$FF,$00 ; Copper Gauntlet
Armor35: ; 62
.byte $92,$B5,$B2,$B1,$FF,$FF,$DD,$FF,$00 ; Iron Gauntlet
Armor36: ; 63
.byte $9C,$AC,$AF,$B9,$A8,$B5,$DD,$FF,$00 ; Silver Gauntlet
Armor37: ; 64
.byte $A3,$A8,$B8,$B6,$FF,$FF,$DD,$FF,$00 ; Zeus Gauntlet
Armor38: ; 65
.byte $99,$B2,$BA,$A8,$B5,$FF,$DD,$FF,$00 ; Power Gauntlet
Armor39: ; 66
.byte $98,$B3,$A4,$AF,$FF,$FF,$DD,$FF,$00 ; Opal Gauntlet
Armor40: ; 67
.byte $99,$B5,$B2,$9B,$AC,$B1,$AA,$FF,$00 ; Protect Ring
Armor41: ; 68
Armor42: ; 69
Armor43: ; 6A
Armor44: ; 6B
Armor45: ; 6C
Armor46: ; 6D
Armor47: ; 6E
Armor48: ; 6F
Armor49: ; 70
Armor50: ; 71
Armor51: ; 72
Armor52: ; 73
Armor53: ; 74
Armor54: ; 75
Armor55: ; 76
Armor56: ; 77
Armor57: ; 78
Armor58: ; 79
Armor59: ; 7A
Armor60: ; 7B
Armor61: ; 7C
Armor62: ; 7D
Armor63: ; 7E
Armor64: ; 7F








;; JIGS - moved from Bank B.
data_BattleMessages:
.word BTL_MESSAGE1
.word BTL_MESSAGE2
.word BTL_MESSAGE3
.word BTL_MESSAGE4
.word BTL_MESSAGE5
.word BTL_MESSAGE6
.word BTL_MESSAGE7
.word BTL_MESSAGE8
.word BTL_MESSAGE9
.word BTL_MESSAGE10
.word BTL_MESSAGE11
.word BTL_MESSAGE12
.word BTL_MESSAGE13
.word BTL_MESSAGE14
.word BTL_MESSAGE15
.word BTL_MESSAGE16
.word BTL_MESSAGE17
.word BTL_MESSAGE18
.word BTL_MESSAGE19
.word BTL_MESSAGE20
.word BTL_MESSAGE21
.word BTL_MESSAGE22
.word BTL_MESSAGE23
.word BTL_MESSAGE24
.word BTL_MESSAGE25
.word BTL_MESSAGE26
.word BTL_MESSAGE27
.word BTL_MESSAGE28
.word BTL_MESSAGE29
.word BTL_MESSAGE30
.word BTL_MESSAGE31
.word BTL_MESSAGE32
.word BTL_MESSAGE33
.word BTL_MESSAGE34
.word BTL_MESSAGE35
.word BTL_MESSAGE36
.word BTL_MESSAGE37
.word BTL_MESSAGE38
.word BTL_MESSAGE39
.word BTL_MESSAGE40
.word BTL_MESSAGE41
.word BTL_MESSAGE42
.word BTL_MESSAGE43
.word BTL_MESSAGE44
.word BTL_MESSAGE45
.word BTL_MESSAGE46
.word BTL_MESSAGE47
.word BTL_MESSAGE48
.word BTL_MESSAGE49
.word BTL_MESSAGE50
.word BTL_MESSAGE51
.word BTL_MESSAGE52
.word BTL_MESSAGE53
.word BTL_MESSAGE54
.word BTL_MESSAGE55
.word BTL_MESSAGE56
.word BTL_MESSAGE57
.word BTL_MESSAGE58
.word BTL_MESSAGE59
.word BTL_MESSAGE60
.word BTL_MESSAGE61
.word BTL_MESSAGE62
.word BTL_MESSAGE63
.word BTL_MESSAGE64
.word BTL_MESSAGE65
.word BTL_MESSAGE66
.word BTL_MESSAGE67
.word BTL_MESSAGE68
.word BTL_MESSAGE69
.word BTL_MESSAGE70
.word BTL_MESSAGE71
.word BTL_MESSAGE72
.word BTL_MESSAGE73
.word BTL_MESSAGE74
.word BTL_MESSAGE75
.word BTL_MESSAGE76
.word BTL_MESSAGE77
.word BTL_MESSAGE78
.word BTL_MESSAGE79
.word BTL_MESSAGE80
.word BTL_MESSAGE81
.word BTL_MESSAGE82
.word BTL_MESSAGE83
.word BTL_MESSAGE84
.word BTL_MESSAGE85
.word BTL_MESSAGE86
.word BTL_MESSAGE87
.word BTL_MESSAGE88
.word BTL_MESSAGE89
.word BTL_MESSAGE90
.word BTL_MESSAGE91
.word BTL_MESSAGE92
.word BTL_MESSAGE93
.word BTL_MESSAGE94
.word BTL_MESSAGE95
.word BTL_MESSAGE96
.word BTL_MESSAGE97
.word BTL_MESSAGE98
.word BTL_MESSAGE99
.word BTL_MESSAGE100
.word BTL_MESSAGE101
.word BTL_MESSAGE102
.word BTL_MESSAGE103
.word BTL_MESSAGE104
.word BTL_MESSAGE105
.word BTL_MESSAGE106
.word BTL_MESSAGE107
.word BTL_MESSAGE108
.word BTL_MESSAGE109
.word BTL_MESSAGE110
.word BTL_MESSAGE111

BTL_MESSAGE1:
.byte $91,$99,$FF,$B8,$B3,$C4,$00  ; HP up!
BTL_MESSAGE2:
.byte $8A,$B5,$B0,$B2,$B5,$FF,$B8,$B3,$00   ; Armor up
BTL_MESSAGE3:
.byte $8E,$A4,$B6,$BC,$FF,$B7,$B2,$FF,$A7,$B2,$A7,$AA,$A8,$00 ; Easy to dodge
BTL_MESSAGE4:
.byte $8A,$B6,$AF,$A8,$A8,$B3,$00 ; Asleep
BTL_MESSAGE5:
.byte $8E,$A4,$B6,$BC,$FF,$B7,$B2,$FF,$AB,$AC,$B7,$00 ; Easy to hit
BTL_MESSAGE6:
.byte $9C,$AC,$AA,$AB,$B7,$FF,$B5,$A8,$A6,$B2,$B9,$A8,$B5,$A8,$A7,$00 ; Sight recovered
BTL_MESSAGE7:
.byte $9C,$AC,$AF,$A8,$B1,$A6,$A8,$A7,$00 ; Silenced
BTL_MESSAGE8:
.byte $8D,$A8,$A9,$A8,$B1,$A7,$FF,$AF,$AC,$AA,$AB,$B7,$B1,$AC,$B1,$AA,$00 ; Defend lightning
BTL_MESSAGE9:
.byte $8D,$A4,$B5,$AE,$B1,$A8,$B6,$B6,$00 ; Darkness
BTL_MESSAGE10:
.byte $A0,$A8,$A4,$B3,$B2,$B1,$B6,$FF,$B6,$B7,$B5,$B2,$B1,$AA,$A8,$B5,$00 ; Weapons stronger
BTL_MESSAGE11:
.byte $95,$B2,$B6,$B7,$FF,$AC,$B1,$B7,$A8,$AF,$AF,$AC,$AA,$A8,$B1,$A6,$A8,$00 ; Lost intelligence
BTL_MESSAGE12:
.byte $8D,$A8,$A9,$A8,$B1,$A7,$FF,$A9,$AC,$B5,$A8,$00 ; Defend fire
BTL_MESSAGE13:
.byte $8A,$B7,$B7,$A4,$A6,$AE,$FF,$AB,$A4,$AF,$B7,$A8,$A7,$00 ; Attack halted
BTL_MESSAGE14:
.byte $99,$B2,$AC,$B6,$B2,$B1,$FF,$B1,$A8,$B8,$B7,$B5,$A4,$AF,$AC,$BD,$A8,$A7,$00 ; Poison neutralized
BTL_MESSAGE15:
.byte $8B,$A8,$A6,$A4,$B0,$A8,$FF,$B7,$A8,$B5,$B5,$AC,$A9,$AC,$A8,$A7,$00 ; Became terrified
BTL_MESSAGE16:
.byte $8D,$A8,$A9,$A8,$B1,$A7,$FF,$A6,$B2,$AF,$A7,$00 ; Defend cold
BTL_MESSAGE17:
.byte $8B,$B5,$A8,$A4,$AE,$FF,$B7,$AB,$A8,$FF,$B6,$AC,$AF,$A8,$B1,$A6,$A8,$00 ; Break the silence
BTL_MESSAGE18:
.byte $9A,$B8,$AC,$A6,$AE,$FF,$B6,$AB,$B2,$B7,$00 ; Quick shot
BTL_MESSAGE19:
.byte $8C,$B2,$B1,$A9,$B8,$B6,$A8,$A7,$00 ; Confused
BTL_MESSAGE20:
.byte $99,$B2,$AC,$B6,$B2,$B1,$A8,$A7,$00 ; Poisoned
BTL_MESSAGE21:
.byte $8E,$B5,$A4,$B6,$A8,$A7,$00 ; Erased
BTL_MESSAGE22:
.byte $8F,$A8,$AF,$AF,$FF,$AC,$B1,$B7,$B2,$FF,$A6,$B5,$A4,$A6,$AE,$00 ; Fell into crack
BTL_MESSAGE23:
.byte $99,$A4,$B5,$A4,$AF,$BC,$BD,$A8,$A7,$00 ; Paralyzed
BTL_MESSAGE24:
.byte $91,$99,$FF,$B0,$A4,$BB,$C4,$00 ; HP max!
BTL_MESSAGE25:
.byte $8D,$A8,$A9,$A8,$B1,$A7,$FF,$B0,$A4,$AA,$AC,$A6,$00 ; Defend magic
BTL_MESSAGE26:
.byte $8B,$B5,$B2,$AE,$A8,$B1,$FF,$AC,$B1,$B7,$B2,$FF,$B3,$AC,$A8,$A6,$A8,$B6,$00 ; Broken into pieces
BTL_MESSAGE27:
.byte $A0,$A8,$A4,$B3,$B2,$B1,$FF,$A5,$A8,$A6,$A4,$B0,$A8,$FF,$A8,$B1,$A6,$AB,$A4,$B1,$B7,$A8,$A7,$00 ; Weapon became enchanted
BTL_MESSAGE28:
.byte $8D,$A8,$A9,$A8,$B1,$A7,$FF,$A4,$AF,$AF,$00 ; Defend all
BTL_MESSAGE29:
.byte $8D,$A8,$A9,$A8,$B1,$B6,$A8,$AF,$A8,$B6,$B6,$00 ; Defenseless
BTL_MESSAGE30:
.byte $9D,$AC,$B0,$A8,$FF,$B6,$B7,$B2,$B3,$B3,$A8,$A7,$00 ; Time stopped
BTL_MESSAGE31:
.byte $8E,$BB,$AC,$AF,$A8,$FF,$B7,$B2,$FF,$84,$B7,$AB,$FF,$A7,$AC,$B0,$A8,$B1,$B6,$AC,$B2,$B1,$00 ; Exile to 4th dimension
BTL_MESSAGE32:
.byte $9C,$AF,$A4,$AC,$B1,$C3,$00 ; Slain..
BTL_MESSAGE33:
.byte $92,$B1,$A8,$A9,$A9,$A8,$A6,$B7,$AC,$B9,$A8,$00 ; Ineffective
BTL_MESSAGE34:
.byte $8C,$AB,$A4,$B1,$A6,$A8,$FF,$B7,$B2,$FF,$B6,$B7,$B5,$AC,$AE,$A8,$FF,$A9,$AC,$B5,$B6,$B7,$00 ; Chance to strike first
BTL_MESSAGE35:
.byte $8E,$B1,$A8,$B0,$AC,$A8,$B6,$FF,$B6,$B7,$B5,$AC,$AE,$A8,$FF,$A9,$AC,$B5,$B6,$B7,$00 ; Enemies strike first
;.byte $96,$B2,$B1,$B6,$B7,$A8,$B5,$B6,$FF,$B6,$B7,$B5,$AC,$AE,$A8,$FF,$A9,$AC,$B5,$B6,$B7,$00 ; Monsters strike first
BTL_MESSAGE36:
.byte $8C,$A4,$B1,$BE,$B7,$FF,$B5,$B8,$B1,$00 ; Can't run
BTL_MESSAGE37:
.byte $9B,$B8,$B1,$FF,$A4,$BA,$A4,$BC,$00 ; Run away
BTL_MESSAGE38:
.byte $8C,$AF,$B2,$B6,$A8,$FF,$A6,$A4,$AF,$AF,$C3,$C3,$00 ; Close call....
BTL_MESSAGE39:
.byte $A0,$B2,$AE,$A8,$FF,$B8,$B3,$00 ; Woke up
BTL_MESSAGE40:
.byte $9C,$AF,$A8,$A8,$B3,$AC,$B1,$AA,$00 ; Sleeping
BTL_MESSAGE41:
.byte $8C,$B8,$B5,$A8,$A7,$C4,$00 ; Cured!
BTL_MESSAGE42:
.byte $99,$A4,$B5,$A4,$AF,$BC,$B6,$AC,$B6,$FF,$BA,$B2,$B5,$A8,$FF,$B2,$A9,$A9,$00 ; Paralysis wore off
BTL_MESSAGE43:
.byte $FF,$91,$AC,$B7,$B6,$C4,$00 ; _Hits!
BTL_MESSAGE44:
.byte $8C,$B5,$AC,$B7,$AC,$A6,$A4,$AF,$FF,$AB,$AC,$B7,$C4,$C4,$00 ; Critical hit!!
BTL_MESSAGE45:
.byte $96,$A4,$AA,$AC,$A6,$FF,$A5,$AF,$B2,$A6,$AE,$A8,$A7,$00 ; Magic blocked
BTL_MESSAGE46:
.byte $FF,$8D,$96,$90,$00 ; _DMG
BTL_MESSAGE47:
.byte $9C,$B7,$B2,$B3,$B3,$A8,$A7,$00 ; Stopped
BTL_MESSAGE48:
.byte $95,$A8,$B9,$C0,$FF,$B8,$B3,$C4,$00 ; Lev. up!
BTL_MESSAGE49:
.byte $91,$99,$FF,$B0,$A4,$BB,$00 ; HP max
BTL_MESSAGE50:
.byte $FF,$B3,$B7,$B6,$C0,$00 ; _pts.
BTL_MESSAGE51:
.byte $9C,$B7,$B5,$C0,$00 ; Str.
BTL_MESSAGE52:
.byte $8A,$AA,$AC,$C0,$00 ; Agi.
BTL_MESSAGE53:
.byte $92,$B1,$B7,$C0,$00 ; Int.
BTL_MESSAGE54:
.byte $9F,$AC,$B7,$C0,$00 ; Vit.
BTL_MESSAGE55:
;.byte $95,$B8,$A6,$AE,$00 ; Luck
.byte $9C,$B3,$A8,$A8,$A7,$00 ; Speed
BTL_MESSAGE56:
.byte $FF,$B8,$B3,$00 ;  up
BTL_MESSAGE57:
.byte $96,$99,$FF,$23,$37,$35,$40,$C4,$00  ; MP restored!
BTL_MESSAGE58:
.byte $91,$99,$20,$3B,$FF,$96,$99,$FF,$23,$37,$35,$40,$C4,$00 ; HP and MP restored!
BTL_MESSAGE59:
.byte $FF,$A7,$B2,$BA,$B1,$00 ; down
BTL_MESSAGE60:
.byte $B3,$A8,$B5,$AC,$B6,$AB,$A8,$A7,$00 ; perished
BTL_MESSAGE61:
.byte $8E,$B1,$A8,$B0,$AC,$A8,$B6,$FF,$00 ; Enemies_ ; $96,$B2,$B1,$B6,$B7,$A8,$B5,$B6,$FF,$00 ; Monsters_
BTL_MESSAGE62:
.byte $FF,$B3,$A4,$B5,$B7,$BC,$FF,$00 ; _party_
BTL_MESSAGE63:
.byte $9D,$A8,$B5,$B0,$AC,$B1,$A4,$B7,$A8,$A7,$00 ; Terminated
BTL_MESSAGE64:
.byte $96,$AC,$B6,$B6,$A8,$A7,$C4,$00 ; Missed!
BTL_MESSAGE65:
.byte $FF,$FF,$FF,$FF,$00 ; ____
BTL_MESSAGE66:
.byte $99,$A8,$B7,$5C,$A9,$AC,$40,$00 ; Petrified
BTL_MESSAGE67:
.byte $9D,$1D,$24,$28,$5A,$24,$1D,$4E,$31,$23,$A4,$AE,$B6,$C4,$00 ; The stone shell breaks!
BTL_MESSAGE68:
.byte $8D,$A4,$B5,$AE,$00 ; Dark
BTL_MESSAGE69:
.byte $9C,$B7,$B8,$B1,$00 ; Stun
BTL_MESSAGE70:
.byte $97,$2E,$2C,$51,$B3,$A8,$C4,$00 ; No escape!
BTL_MESSAGE71:
.byte $96,$B8,$B7,$A8,$00 ; Mute
BTL_MESSAGE72:
.byte $91,$99,$FF,$FF,$00 ; HP__
BTL_MESSAGE73:
.byte $8E,$BB,$B3,$FF,$A8,$A4,$B5,$B1,$A8,$A7,$C3,$00 ; Exp earned..
BTL_MESSAGE74:
.byte $92,$B1,$A8,$A9,$A9,$A8,$A6,$B7,$AC,$B9,$A8,$FF,$B1,$B2,$BA,$00 ; Ineffective now
BTL_MESSAGE75:
.byte $9C,$AC,$AF,$A8,$B1,$A6,$A8,$00 ; Silence
BTL_MESSAGE76:
.byte $90,$B2,$FF,$B0,$A4,$A7,$00 ; Go mad
BTL_MESSAGE77:
.byte $99,$B2,$AC,$B6,$B2,$B1,$FF,$B6,$B0,$B2,$AE,$A8,$00 ; Poison smoke
BTL_MESSAGE78:
.BYTE $97,$B2,$B7,$AB,$AC,$B1,$AA,$FF,$AB,$A4,$B3,$B3,$A8,$B1,$B6,$00  ; Nothing happens
BTL_MESSAGE79:
.byte $9B,$A8,$B9,$AC,$32,$27,$A9,$4D,$B0,$1B,$1D,$31,$5C,$B1,$AE,$C4,$00 ; Revived from the brink!
BTL_MESSAGE80:
.byte $9B,$A8,$AA,$A8,$B1,$A8,$B5,$A4,$B7,$A8,$A7,$FF,$91,$99,$00 ; Regenerated HP ; JIGS - added this
BTL_MESSAGE81:
.byte $8F,$A8,$A8,$AF,$AC,$B1,$AA,$FF,$AF,$B8,$A6,$AE,$BC,$C4,$00  ; Feeling lucky!
BTL_MESSAGE82:
.BYTE $9C,$AF,$AC,$B3,$B3,$A8,$A7,$FF,$AC,$B1,$B7,$B2,$FF,$AB,$AC,$A7,$AC,$B1,$AA,$C3,$C0,$00 ; Slipped into hiding...
BTL_MESSAGE83:
.byte $8C,$A4,$B1,$BE,$B7,$FF,$AB,$AC,$A7,$A8,$FF,$B1,$B2,$BA,$C4,$00 ; Can't hide now!
BTL_MESSAGE84:
.byte $8A,$AF,$B5,$A8,$A4,$A7,$BC,$FF,$AB,$AC,$A7,$A7,$A8,$B1,$C4,$00 ; Already hidden!
BTL_MESSAGE85:
.byte $FF,$FF,$9B,$B2,$B8,$B1,$A7,$FF,$FF,$00 ; __Round__
BTL_MESSAGE86:
.byte $9D,$1D,$31,$A8,$4E,$FF,$5C,$2A,$1E,$AF,$26,$A7,$AF,$BC,$69,$00 ; The bell rings loudly..
BTL_MESSAGE87:
.byte $9C,$B7,$A8,$A4,$AF,$AC,$B1,$AA,$C3,$C0,$00 ; Stealing...
BTL_MESSAGE88:
.byte $9C,$B7,$B2,$AF,$A8,$FF,$00  ; Stole_
BTL_MESSAGE89:
.byte $B6,$A6,$B5,$B2,$AF,$AF,$00  ; _scroll
BTL_MESSAGE90:
.byte $8B,$A8,$AA,$1F,$1E,$1D,$5F,$1F,$47,$B6,$AF,$46,$AF,$BC,$00 ; Begins healing slowly
BTL_MESSAGE91:
.byte $91,$A4,$32,$B1,$BE,$21,$AA,$B2,$21,$22,$4B,$B0,$35,$A8,$C4,$00 ; Haven't got any more!
BTL_MESSAGE92:
.byte $8C,$22,$B1,$B2,$21,$A6,$B2,$32,$44,$56,$55,$3E,$AF,$A9,$C4,$00 ; Cannot cover yourself!
BTL_MESSAGE93:
.byte $8C,$A4,$34,$1B,$2E,$1C,$A8,$AC,$44,$3E,$B1,$3E,$B6,$00 ; Came to their senses
BTL_MESSAGE94:
.byte $90,$B2,$AF,$A7,$FF,$A9,$B2,$B8,$B1,$A7,$C3,$00 ; Gold found..
BTL_MESSAGE95:
.byte $97,$B2,$B7,$AB,$AC,$B1,$AA,$00 ; Nothing
BTL_MESSAGE96:
.byte $9C,$51,$B1,$B1,$1F,$AA,$69,$00,$3A,$27,$56,$55,$3E,$AF,$A9,$C4,$00 ; Scanning...
BTL_MESSAGE97:
.byte $FF,$38,$B2,$32,$23,$27,$1C,$1A,$39,$B7,$5E,$AE,$C4,$00 ; _covered the attack!
BTL_MESSAGE98:
.byte $8C,$26,$B1,$53,$44,$39,$B7,$5E,$AE,$C4,$00 ; Counter attack!
BTL_MESSAGE99:
.byte $99,$B5,$A4,$BC,$1F,$AA,$69,$00 ; Praying...
BTL_MESSAGE100:
.byte $8F,$B2,$A6,$B8,$B6,$1F,$AA,$69,$00 ; Focusing...
BTL_MESSAGE101:
.byte $9D,$AC,$34,$31,$A8,$AA,$1F,$1E,$28,$43,$AF,$46,$00 ; Time begins to flow
BTL_MESSAGE102:
.byte $8A,$A5,$B6,$35,$62,$27,$1C,$1A,$B6,$B3,$A8,$4E,$C4,$00 ; Absorbed the spell!
BTL_MESSAGE103:
.byte $98,$32,$B5,$BA,$1D,$AF,$34,$27,$A5,$BC,$FF,$00 ; Overwhelmed by_
BTL_MESSAGE104:
.byte $9B,$B6,$B1,$AC,$B8,$00 ; Runic
BTL_MESSAGE105:
.byte $97,$2E,$60,$A4,$B3,$3C,$FF,$A8,$B4,$B8,$AC,$B3,$B3,$40,$C4,$00 ; No weapon equipped!
BTL_MESSAGE106:
.byte $FF,$FF,$FF,$FF,$9B,$A8,$A4,$A7,$BC,$C5,$FF,$FF,$FF,$00 ;   Ready?
BTL_MESSAGE107:
.byte $FF,$FF,$FF,$8C,$AB,$A4,$B5,$AA,$A8,$C5,$C4,$FF,$FF,$00 ;  Charge?!
BTL_MESSAGE108:
.byte $FF,$FF,$9B,$B8,$B1,$FF,$A4,$BA,$A4,$BC,$C5,$FF,$FF,$00 ;  Run away?
BTL_MESSAGE109:
.byte $FF,$FF,$A2,$A8,$B6,$FF,$FF,$FF,$FF,$97,$B2,$00 ; Yes    No
BTL_MESSAGE110:
.byte $FF,$FF,$A2,$A8,$B6,$C4,$FF,$FF,$FF,$97,$B2,$C4,$00 ; Yes!   No!
BTL_MESSAGE111:
.byte $FF,$FF,$A2,$A8,$B6,$C3,$C0,$FF,$FF,$97,$B2,$C3,$C0,$00 ; Yes... No...








 ;; You can use normal numbers to set the price if you use .word, as exampled by Heal and Pure below
 ;; Just don't go over 65535!
;                      297000 - the cost of 99 houses... for reference...
.ALIGN  $100

lut_ItemPrices:
.word 0000    ; 00 START
.word 0060    ; 01 HEAL
.word 2500    ; 02 X-HEAL
.word 5000    ; 03 ETHER
.word 50000   ; 04 ELIXIR
.word 0075    ; 05 PURE
.word 0800    ; 06 SOFT
.word 20000   ; 07 PHOENIX DOWN
.word 0075    ; 08 TENT
.word 0250    ; 09 CABIN
.word 3000    ; 0A HOUSE
.word 0200    ; 0B EYEDROP
.word 2000    ; 0C SMOKEBOMB
.word 0750    ; 0D ALARMCLOCK
.word 0000    ; 0F nothing
.word 0000    ; 0F nothing

;; key items
.word 0000    ; 10 LUTE
.word 0000    ; 11 CROWN
.word 0000    ; 12 CRYSTAL
.word 0000    ; 13 HERB
.word 0000    ; 14 KEY
.word 0000    ; 15 TNT
.word 0000    ; 16 ADAMANT
.word 0000    ; 17 SLAB
.word 0000    ; 18 RUBY
.word 0000    ; 19 ROD
.word 0000    ; 1A FLOATER
.word 0000    ; 1B CHIME
.word 0000    ; 1C TAIL
.word 0000    ; 1D CUBE
.word 50000   ; 1E BOTTLE
.word 0000    ; 1F OXYALE
.word 0000    ; 20 CANOE
.word 5000    ; 21 LEWDS
.word 5000    ; 22 ??? Book
.word 0000    ; 23 nothing
.word 0000    ; 24 nothing
.word 0000    ; 25 nothing
.word 0000    ; 26 nothing
.word 0000    ; 27 nothing
.word 0000    ; 28 nothing
.word 0000    ; 29 nothing
.word 0000    ; 2A nothing
.word 0000    ; 2B nothing
.word 0000    ; 2C ORB 1
.word 0000    ; 2D ORB 2
.word 0000    ; 2E ORB 3
.word 0000    ; 2F ORB 4

;; magic
.byte $64,$00 ; Level 1 Magic
.byte $64,$00
.byte $64,$00
.byte $64,$00
.byte $64,$00
.byte $64,$00
.byte $64,$00
.byte $64,$00
.byte $90,$01 ; Level 2 Magic
.byte $90,$01
.byte $90,$01
.byte $90,$01
.byte $90,$01
.byte $90,$01
.byte $90,$01
.byte $90,$01
.byte $DC,$05 ; Level 3 Magic
.byte $DC,$05
.byte $DC,$05
.byte $DC,$05
.byte $DC,$05
.byte $DC,$05
.byte $DC,$05
.byte $DC,$05
.byte $A0,$0F ; Level 4 Magic
.byte $A0,$0F
.byte $A0,$0F
.byte $A0,$0F
.byte $A0,$0F
.byte $A0,$0F
.byte $A0,$0F
.byte $A0,$0F
.byte $40,$1F ; Level 5 Magic
.byte $40,$1F
.byte $40,$1F
.byte $40,$1F
.byte $40,$1F
.byte $40,$1F
.byte $40,$1F
.byte $40,$1F
.byte $20,$4E ; Level 6 Magic
.byte $20,$4E
.byte $20,$4E
.byte $20,$4E
.byte $20,$4E
.byte $20,$4E
.byte $20,$4E
.byte $20,$4E
.byte $C8,$AF ; Level 7 Magic
.byte $C8,$AF
.byte $C8,$AF
.byte $C8,$AF
.byte $C8,$AF
.byte $C8,$AF
.byte $C8,$AF
.byte $C8,$AF
.byte $60,$EA ; Level 8 Magic
.byte $60,$EA
.byte $60,$EA
.byte $60,$EA
.byte $60,$EA
.byte $60,$EA
.byte $60,$EA
.byte $60,$EA

;; Battle spells... so nothing. Waste of space!
.word 0000    ; $70
.word 0000    ; $71
.word 0000    ; $72
.word 0000    ; $73
.word 0000    ; $74
.word 0000    ; $75
.word 0000    ; $76
.word 0000    ; $77
.word 0000    ; $78
.word 0000    ; $79
.word 0000    ; $7A
.word 0000    ; $7B
.word 0000    ; $7C
.word 0000    ; $7D
.word 0000    ; $7E
.word 0000    ; $7F

;; gold in chests
;              chest number
;              |    item ID (not price ID)
.word  0010  ; 1  ; $80
.word  0020  ; 2  ; $81
.word  0025  ; 3  ; $82
.word  0030  ; 4  ; $83
.word  0055  ; 5  ; $84
.word  0070  ; 6  ; $85
.word  0085  ; 7  ; $86
.word  0110  ; 8  ; $87
.word  0135  ; 9  ; $88
.word  0155  ; 10 ; $89
.word  0160  ; 11 ; $8A
.word  0180  ; 12 ; $8B
.word  0240  ; 13 ; $8C
.word  0255  ; 14 ; $8D
.word  0260  ; 15 ; $8E
.word  0295  ; 16 ; $8F
.word  0300  ; 17 ; $90
.word  0315  ; 18 ; $91
.word  0330  ; 19 ; $92
.word  0350  ; 20 ; $93
.word  0385  ; 21 ; $94
.word  0400  ; 22 ; $95
.word  0450  ; 23 ; $96
.word  0500  ; 24 ; $97
.word  0530  ; 25 ; $98
.word  0575  ; 26 ; $99
.word  0620  ; 27 ; $9A
.word  0680  ; 28 ; $9B
.word  0750  ; 29 ; $9C
.word  0795  ; 30 ; $9D
.word  0880  ; 31 ; $9E
.word  1020  ; 32 ; $9F
.word  1250  ; 33 ; $A0
.word  1455  ; 34 ; $A1
.word  1520  ; 35 ; $A2
.word  1760  ; 36 ; $A3
.word  1975  ; 37 ; $A4
.word  2000  ; 38 ; $A5
.word  2750  ; 39 ; $A6
.word  3400  ; 40 ; $A7
.word  4150  ; 41 ; $A8
.word  5000  ; 42 ; $A9
.word  5450  ; 43 ; $AA
.word  6400  ; 44 ; $AB
.word  6720  ; 45 ; $AC
.word  7340  ; 46 ; $AD
.word  7690  ; 47 ; $AE
.word  7900  ; 48 ; $AF
.word  8135  ; 49 ; $B0
.word  9000  ; 50 ; $B1
.word  9300  ; 51 ; $B2
.word  9500  ; 52 ; $B3
.word  9900  ; 53 ; $B4
.word  10000 ; 54 ; $B5
.word  12350 ; 55 ; $B6
.word  13000 ; 56 ; $B7
.word  13450 ; 57 ; $B8
.word  14050 ; 58 ; $B9
.word  14720 ; 59 ; $BA
.word  15000 ; 60 ; $BB
.word  17490 ; 61 ; $BC
.word  18010 ; 62 ; $BD
.word  19990 ; 63 ; $BE
.word  20000 ; 64 ; $BF
.word  20010 ; 65 ; $C0
.word  26000 ; 66 ; $C1
.word  45000 ; 67 ; $C2
.word  65000 ; 68 ; $C3
.word  65000 ; 69 ; $C4
.word  65000 ; 70 ; $C5
.word  65000 ; 71 ; $C6
.word  65000 ; 72 ; $C7
.word  65000 ; 73 ; $C8
.word  65000 ; 74 ; $C9
.word  65000 ; 75 ; $CA
.word  65000 ; 76 ; $CB
.word  65000 ; 77 ; $CC
.word  65000 ; 78 ; $CD
.word  65000 ; 79 ; $CE
.word  65000 ; 80 ; $CF

.ALIGN  $100

WeaponArmorPrices:
.byte $0A,$00 ; Weapon 1
.byte $05,$00 ; Weapon 2
.byte $05,$00 ; Weapon 3
.byte $0A,$00 ; Weapon 4
.byte $0A,$00 ; Weapon 5
.byte $26,$02 ; Weapon 6
.byte $26,$02 ; Weapon 7
.byte $C8,$00 ; Weapon 8
.byte $C8,$00 ; Weapon 9
.byte $AF,$00 ; Weapon 10
.byte $C8,$00 ; Weapon 11
.byte $C2,$01 ; Weapon 12
.byte $DC,$05 ; Weapon 13
.byte $D0,$07 ; Weapon 14
.byte $C2,$01 ; Weapon 15
.byte $20,$03 ; Weapon 16
.byte $A0,$0F ; Weapon 17
.byte $C4,$09 ; Weapon 18
.byte $94,$11 ; Weapon 19
.byte $10,$27 ; Weapon 20
.byte $98,$3A ; Weapon 21
.byte $40,$1F ; Weapon 22
.byte $40,$1F ; Weapon 23
.byte $20,$4E ; Weapon 24
.byte $40,$1F ; Weapon 25
.byte $70,$17 ; Weapon 26
.byte $88,$13 ; Weapon 27
.byte $39,$30 ; Weapon 28
.byte $10,$27 ; Weapon 29
.byte $A8,$61 ; Weapon 30
.byte $A8,$61 ; Weapon 31
.byte $40,$9C ; Weapon 32
.byte $50,$C3 ; Weapon 33
.byte $30,$75 ; Weapon 34
.byte $E8,$FD ; Weapon 35
.byte $40,$9C ; Weapon 36
.byte $60,$EA ; Weapon 37
.byte $60,$EA ; Weapon 38
.byte $60,$EA ; Weapon 39
.byte $60,$EA ; Weapon 40
.byte $00,$00 ; Weapon 41
.byte $00,$00 ; Weapon 42
.byte $00,$00 ; Weapon 43
.byte $00,$00 ; Weapon 44
.byte $00,$00 ; Weapon 45
.byte $00,$00 ; Weapon 46
.byte $00,$00 ; Weapon 47
.byte $00,$00 ; Weapon 48
.byte $00,$00 ; Weapon 49
.byte $00,$00 ; Weapon 50
.byte $00,$00 ; Weapon 51
.byte $00,$00 ; Weapon 52
.byte $00,$00 ; Weapon 53
.byte $00,$00 ; Weapon 54
.byte $00,$00 ; Weapon 55
.byte $00,$00 ; Weapon 56
.byte $00,$00 ; Weapon 57
.byte $00,$00 ; Weapon 58
.byte $00,$00 ; Weapon 59
.byte $00,$00 ; Weapon 60
.byte $00,$00 ; Weapon 61
.byte $00,$00 ; Weapon 62
.byte $00,$00 ; Weapon 63
.byte $00,$00 ; Weapon 64

.byte $0A,$00 ; Armor 1
.byte $32,$00 ; Armor 2
.byte $50,$00 ; Armor 3
.byte $20,$03 ; Armor 4
.byte $C8,$AF ; Armor 5
.byte $4C,$1D ; Armor 6
.byte $30,$75 ; Armor 7
.byte $30,$75 ; Armor 8
.byte $60,$EA ; Armor 9
.byte $60,$EA ; Armor 10
.byte $E8,$03 ; Armor 11
.byte $88,$13 ; Armor 12
.byte $50,$C3 ; Armor 13
.byte $E8,$FD ; Armor 14
.byte $02,$00 ; Armor 15
.byte $02,$00 ; Armor 16
.byte $0F,$00 ; Armor 17
.byte $64,$00 ; Armor 18
.byte $C4,$09 ; Armor 19
.byte $10,$27 ; Armor 20
.byte $10,$27 ; Armor 21
.byte $98,$3A ; Armor 22
.byte $40,$9C ; Armor 23
.byte $C4,$09 ; Armor 24
.byte $20,$4E ; Armor 25
.byte $50,$00 ; Armor 26
.byte $64,$00 ; Armor 27
.byte $C2,$01 ; Armor 28
.byte $C4,$09 ; Armor 29
.byte $10,$27 ; Armor 30
.byte $20,$4E ; Armor 31
.byte $02,$00 ; Armor 32
.byte $3C,$00 ; Armor 33
.byte $C8,$00 ; Armor 34
.byte $EE,$02 ; Armor 35
.byte $C4,$09 ; Armor 36
.byte $98,$3A ; Armor 37
.byte $10,$27 ; Armor 38
.byte $20,$4E ; Armor 39
.byte $20,$4E ; Armor 40
.byte $00,$00 ; Armor 41
.byte $00,$00 ; Armor 42
.byte $00,$00 ; Armor 43
.byte $00,$00 ; Armor 44
.byte $00,$00 ; Armor 45
.byte $00,$00 ; Armor 46
.byte $00,$00 ; Armor 47
.byte $00,$00 ; Armor 48
.byte $00,$00 ; Armor 49
.byte $00,$00 ; Armor 50
.byte $00,$00 ; Armor 51
.byte $00,$00 ; Armor 52
.byte $00,$00 ; Armor 53
.byte $00,$00 ; Armor 54
.byte $00,$00 ; Armor 55
.byte $00,$00 ; Armor 56
.byte $00,$00 ; Armor 57
.byte $00,$00 ; Armor 58
.byte $00,$00 ; Armor 59
.byte $00,$00 ; Armor 60
.byte $00,$00 ; Armor 61
.byte $00,$00 ; Armor 62
.byte $00,$00 ; Armor 63
.byte $00,$00 ; Armor 64



lut_CommonStringPtrTbl:
.word CommonString_00
.word CommonString_01
.word CommonString_02
.word CommonString_03
.word CommonString_04
.word CommonString_05
.word CommonString_06
.word CommonString_07
.word CommonString_08
.word CommonString_09
.word CommonString_0A
.word CommonString_0B
.word CommonString_0C
.word CommonString_0D
.word CommonString_0E
.word CommonString_0F
.word CommonString_10
.word CommonString_11
.word CommonString_12
.word CommonString_13
.word CommonString_14
.word CommonString_15
.word CommonString_16
.word CommonString_17
.word CommonString_18
.word CommonString_19
.word CommonString_1A
.word CommonString_1B
.word CommonString_1C
.word CommonString_1D
.word CommonString_1E
.word CommonString_1F
.word CommonString_20
.word CommonString_21
.word CommonString_22
.word CommonString_23
.word CommonString_24
.word CommonString_25
.word CommonString_26
.word CommonString_27
.word CommonString_28
.word CommonString_29
.word CommonString_2A
.word CommonString_2B
.word CommonString_2C
.word CommonString_2D
.word CommonString_2E
.word CommonString_2F
.word CommonString_30
.word CommonString_31
.word CommonString_32
.word CommonString_33
.word CommonString_34
.word CommonString_35
.word CommonString_36
.word CommonString_37
.word CommonString_38
.word CommonString_39
.word CommonString_3A
.word CommonString_3B
.word CommonString_3C
.word CommonString_3D
.word CommonString_3E
.word CommonString_3F
.word CommonString_40
.word CommonString_41
.word CommonString_42
.word CommonString_43
.word CommonString_44
.word CommonString_45
.word CommonString_46
.word CommonString_47
.word CommonString_48
.word CommonString_49
.word CommonString_4A
.word CommonString_4B
.word CommonString_4C
.word CommonString_4D
.word CommonString_4E
.word CommonString_4F
.word CommonString_50
.word CommonString_51
.word CommonString_52
.word CommonString_53
.word CommonString_54
.word CommonString_55
.word CommonString_56
.word CommonString_57
.word CommonString_58
.word CommonString_59
.word CommonString_5A
.word CommonString_5B
.word CommonString_5C
.word CommonString_5D
.word CommonString_5E
.word CommonString_5F
.word CommonString_60
.word CommonString_61
.word CommonString_62
.word CommonString_63
.word CommonString_64
.word CommonString_65
.word CommonString_66
.word CommonString_67
.word CommonString_68
.word CommonString_69
.word CommonString_6A
.word CommonString_6B
.word CommonString_6C
.word CommonString_6D
.word CommonString_6E
.word CommonString_6F
.word CommonString_70
.word CommonString_71
.word CommonString_72
.word CommonString_73
.word CommonString_74
.word CommonString_75
.word CommonString_76
.word CommonString_77
.word CommonString_78
.word CommonString_79
.word CommonString_7A
.word CommonString_7B
.word CommonString_7C
.word CommonString_7D
.word CommonString_7E
.word CommonString_7F

CommonString_00:
.byte $FF,$95,$AC,$AA,$AB,$B7,$AF,$4B,$23,$A6,$B2,$32,$44,$00         ; _Lightly recover |
CommonString_01:
.byte $9C,$B7,$4D,$2A,$AF,$4B,$23,$A6,$B2,$32,$44,$00                 ; Strongly recover_|
CommonString_02:
.byte $FF,$90,$23,$39,$AF,$4B,$23,$A6,$B2,$32,$44,$00                 ; _Greatly recover_|
CommonString_03:
.byte $FF,$9B,$A8,$A6,$B2,$32,$44,$B3,$2F,$B7,$BC,$BE,$1E,$00         ; _Recover party's_|
CommonString_04:
.byte $FF,$FF,$9B,$A8,$A6,$B2,$32,$44,$A9,$4D,$B0,$09,$03,$00         ; __Recover from___|
CommonString_05:
.byte $FF,$95,$AC,$AA,$AB,$B7,$AF,$4B,$A7,$A4,$B0,$A4,$66,$FF,$FF,$00 ; _Lightly damage__|
CommonString_06:
.byte $FF,$9C,$B7,$4D,$2A,$AF,$4B,$A7,$A4,$B0,$A4,$66,$FF,$00         ; _Strongly damage_|
CommonString_07:
.byte $FF,$91,$2B,$B9,$61,$4B,$A7,$A4,$B0,$A4,$66,$FF,$FF,$00         ; _Heavily damage__|
CommonString_08:
.byte $96,$3F,$B6,$AC,$32,$AF,$4B,$A7,$A4,$B0,$A4,$66,$FF,$00         ; Massively damage_|
CommonString_09:
.byte $09,$03,$36,$5A,$FF,$3A,$A8,$B0,$BC,$09,$04,$00                 ; ____one enemy____|
CommonString_0A:
.byte $99,$4D,$53,$A6,$21,$1C,$1A,$B3,$2F,$B7,$BC,$00                 ; Protect the party|
CommonString_0B:
.byte $9B,$A8,$B7,$55,$29,$1C,$1A,$B3,$2F,$B7,$BC,$FF,$00             ; Return the party_|
CommonString_0C:
.byte $FF,$4F,$2F,$B7,$4B,$34,$B0,$62,$B5,$C0,$FF,$FF,$00             ; __party member.__|
CommonString_0D:
.byte $FF,$FF,$9C,$68,$AA,$AB,$21,$A6,$41,$B1,$48,$FF,$FF,$00         ; __Slight chance__|
CommonString_0E:
.byte $FF,$90,$23,$39,$25,$38,$41,$B1,$48,$FF,$FF,$00                 ; _Greater chance__|
CommonString_0F:
.byte $09,$03,$36,$5A,$FF,$3A,$A8,$B0,$BC,$00                         ; ____one enemy    |
CommonString_10:
.byte $FF,$FF,$20,$4E,$FF,$3A,$A8,$B0,$AC,$2C,$00                     ; ___all enemies   |
CommonString_11:
.byte $FF,$B8,$3B,$2B,$27,$3A,$A8,$B0,$AC,$2C,$FF,$FF,$00             ; _undead enemies__|
CommonString_12:
.byte $33,$1D,$29,$91,$99,$2D,$1E,$AF,$46,$C0,$FF,$00                 ; _when HP is low._|
CommonString_13:
.byte $FF,$FF,$91,$99,$36,$32,$44,$57,$34,$C0,$FF,$FF,$00             ; __HP over time.__|
CommonString_14:
.byte $09,$03,$91,$99,$43,$35,$36,$5A,$09,$04,$00                     ; ___HP for one____|
CommonString_15:
.byte $09,$03,$33,$5B,$AB,$43,$AC,$23,$C0,$09,$03,$00                 ; ____with fire.___|
CommonString_16:
.byte $33,$5B,$AB,$65,$AC,$AA,$AB,$B7,$B1,$1F,$AA,$C0,$FF,$00         ; _with lightning._|
CommonString_17:
.byte $09,$03,$33,$5B,$AB,$2D,$48,$C0,$09,$04,$00                     ; ____with ice.____|
CommonString_18:
.byte $33,$5B,$AB,$59,$B2,$AF,$4B,$B0,$A4,$AA,$AC,$A6,$C0,$00         ; _with holy magic.|
CommonString_19:
.byte $FF,$B5,$A4,$30,$1F,$47,$A7,$A8,$A9,$3A,$3E,$C0,$00             ; _raising defense.|
CommonString_1A:
.byte $FF,$B5,$A4,$30,$1F,$47,$A8,$B9,$3F,$AC,$3C,$C0,$00             ; _raising evasion.|
CommonString_1B:
.byte $AF,$46,$25,$1F,$47,$A8,$B9,$3F,$AC,$3C,$C0,$00                 ; lowering evasion.|
CommonString_1C:
.byte $09,$11,$00                                                     ; _________________|
CommonString_1D:
.byte $96,$A4,$AA,$AC,$51,$4E,$4B,$1F,$25,$B7,$C0,$00                 ; Magically inert.
CommonString_1E:
CommonString_1F:
CommonString_20:
CommonString_21:
CommonString_22:
CommonString_23:
CommonString_24:
CommonString_25:
CommonString_26:
CommonString_27:
CommonString_28:
CommonString_29:
CommonString_2A:
CommonString_2B:
CommonString_2C:
CommonString_2D:
CommonString_2E:
CommonString_2F:
CommonString_30:
CommonString_31:
CommonString_32:
CommonString_33:
CommonString_34:
CommonString_35:
CommonString_36:
CommonString_37:
CommonString_38:
CommonString_39:
CommonString_3A:
CommonString_3B:
CommonString_3C:
CommonString_3D:
CommonString_3E:
CommonString_3F:
CommonString_40:
CommonString_41:
CommonString_42:
CommonString_43:
CommonString_44:
CommonString_45:
CommonString_46:
CommonString_47:
CommonString_48:
CommonString_49:
CommonString_4A:
CommonString_4B:
CommonString_4C:
CommonString_4D:
CommonString_4E:
CommonString_4F:
CommonString_50:
CommonString_51:
CommonString_52:
CommonString_53:
CommonString_54:
CommonString_55:
CommonString_56:
CommonString_57:
CommonString_58:
CommonString_59:
CommonString_5A:
CommonString_5B:
CommonString_5C:
CommonString_5D:
CommonString_5E:
CommonString_5F:
CommonString_60:
CommonString_61:
CommonString_62:
CommonString_63:
CommonString_64:
CommonString_65:
CommonString_66:
CommonString_67:
CommonString_68:
CommonString_69:
CommonString_6A:
CommonString_6B:
CommonString_6C:
CommonString_6D:
CommonString_6E:
CommonString_6F:
CommonString_70:
CommonString_71:
CommonString_72:
CommonString_73:
CommonString_74:
CommonString_75:
CommonString_76:
CommonString_77:
CommonString_78:
CommonString_79:
CommonString_7A:
CommonString_7B:
CommonString_7C:
CommonString_7D:
CommonString_7E:
CommonString_7F:







ItemDescriptions:
   LDA shop_curitem
   CMP #BOTTLE    ; if its bottle, set to $0E
   BNE :+
    LDA #$0E
    BNE @Items
 : CMP #LEWDS     ; if its lewds, set to $0F
   BNE :+
    LDA #$0F
    BNE @Items
 : CMP #$30       ; if its magic, subtract #$30 and use a different table
   BCC @Items

   ;Carry is set already...
   SBC #MG_START
   ASL A
   TAX
   LDA lut_MagicDescStrings, X
   STA text_ptr
   LDA lut_MagicDescStrings+1, X
   JMP @DoText

  @Items:
   SEC
   SBC #01 ; set item ID to -1
   ASL A
   TAX
   LDA lut_ItemDescStrings, X
   STA text_ptr
   LDA lut_ItemDescStrings+1, X
   JMP @DoText

  @DoText:
   STA text_ptr+1
   LDA #BANK_MENUS
   STA ret_bank
   LDA #BANK_ITEMDESC
   STA cur_bank
   JMP DrawComplexString ;  Draw Complex String, then exit, return to menu



lut_ItemDescStrings:
 .word DESC_HEAL
 .word DESC_X_HEAL
 .word DESC_ETHER
 .word DESC_ELIXIR
 .word DESC_PURE
 .word DESC_SOFT
 .word DESC_PHOENIXDOWN
 .word DESC_TENT
 .word DESC_CABIN
 .word DESC_HOUSE
 .word DESC_EYEDROPS
 .word DESC_SMOKEBOMB
 .word DESC_ALARMCLOCK
 .word DESC_BOTTLE
 .word DESC_LEWDS

lut_MagicDescStrings:
 .word DESC_MG_CURE
 .word DESC_MG_HARM
 .word DESC_MG_FOG
 .word DESC_MG_RUSE
 .word DESC_MG_FIRE
 .word DESC_MG_SLEP
 .word DESC_MG_LOCK
 .word DESC_MG_LIT
 .word DESC_MG_LAMP
 .word DESC_MG_MUTE
 .word DESC_MG_ALIT
 .word DESC_MG_INVS
 .word DESC_MG_ICE
 .word DESC_MG_DARK
 .word DESC_MG_TMPR
 .word DESC_MG_SLOW
 .word DESC_MG_CUR2
 .word DESC_MG_HRM2
 .word DESC_MG_AFIR
 .word DESC_MG_REGN
 .word DESC_MG_FIR2
 .word DESC_MG_HOLD
 .word DESC_MG_LIT2
 .word DESC_MG_LOK2
 .word DESC_MG_PURE
 .word DESC_MG_FEAR
 .word DESC_MG_AICE
 .word DESC_MG_AMUT
 .word DESC_MG_SLP2
 .word DESC_MG_FAST
 .word DESC_MG_CONF
 .word DESC_MG_ICE2
 .word DESC_MG_CUR3
 .word DESC_MG_LIFE
 .word DESC_MG_HRM3
 .word DESC_MG_RGN2
 .word DESC_MG_FIR3
 .word DESC_MG_BANE
 .word DESC_MG_WARP
 .word DESC_MG_SLO2
 .word DESC_MG_SOFT
 .word DESC_MG_EXIT
 .word DESC_MG_FOG2
 .word DESC_MG_INV2
 .word DESC_MG_LIT3
 .word DESC_MG_RUB
 .word DESC_MG_QAKE
 .word DESC_MG_STUN
 .word DESC_MG_CUR4
 .word DESC_MG_HRM4
 .word DESC_MG_ARUB
 .word DESC_MG_RGN3
 .word DESC_MG_ICE3
 .word DESC_MG_BRAK
 .word DESC_MG_SABR
 .word DESC_MG_BLND
 .word DESC_MG_LIF2
 .word DESC_MG_FADE
 .word DESC_MG_WALL
 .word DESC_MG_XFER
 .word DESC_MG_NUKE
 .word DESC_MG_STOP
 .word DESC_MG_ZAP
 .word DESC_MG_XXXX


DESC_HEAL:
.byte $FF,$9B,$2C,$28,$23,$1E,$83,$80,$FF,$91,$99,$C0,$FF,$01  ; _Restores 30 HP._|
.byte $FF,$95,$2C,$1E,$A8,$A9,$A9,$A8,$A6,$57,$32,$FF,$FF,$01  ; _Less effective__|
.byte $09,$03,$2D,$29,$A5,$39,$B7,$45,$C0,$09,$03,$00          ; ____in battle.___|

DESC_X_HEAL:
.byte $FF,$9B,$2C,$28,$23,$1E,$81,$88,$80,$FF,$91,$99,$C0,$01  ; _Restores 180 HP.|
.byte $FF,$95,$2C,$1E,$A8,$A9,$A9,$A8,$A6,$57,$32,$FF,$FF,$01  ; _Less effective__|
.byte $09,$03,$2D,$29,$A5,$39,$B7,$45,$C0,$09,$03,$00          ; ____in battle.___|

DESC_ETHER:
.byte $FF,$8F,$B8,$4E,$4B,$23,$37,$35,$2C,$FF,$FF,$01          ; _Fully restores__|
.byte $09,$03,$96,$99,$43,$35,$36,$5A,$FF,$FF,$01              ; ___MP for one____|
.byte $FF,$FF,$B6,$B3,$A8,$4E,$BE,$1E,$45,$32,$AF,$C0,$FF,$00  ; __spell's level._|

DESC_ELIXIR:
.byte $FF,$8F,$B8,$4E,$4B,$23,$37,$35,$2C,$FF,$FF,$01          ; _Fully restores__|
.byte $FF,$5F,$58,$91,$99,$20,$3B,$FF,$96,$99,$C0,$FF,$FF,$01  ; _all HP and MP.__|
.byte $06,$1C,$00

DESC_PURE:
.byte $FF,$FF,$8C,$55,$2C,$4F,$B2,$30,$3C,$C0,$FF,$FF,$01      ; __Cures poison.__|
.byte $06,$1C,$01
.byte $06,$1C,$00

DESC_SOFT:
.byte $09,$03,$8C,$55,$2C,$24,$28,$5A,$C0,$FF,$FF,$01          ; ___Cures stone.__|
.byte $06,$1C,$01
.byte $06,$1C,$00

DESC_PHOENIXDOWN:
.byte $09,$03,$8C,$55,$2C,$67,$2B,$1C,$C0,$FF,$FF,$01          ; ___Cures death.__|
.byte $06,$1C,$01
.byte $06,$1C,$00

DESC_TENT:
DESC_CABIN:
.byte $FF,$9E,$3E,$36,$B8,$B7,$B6,$AC,$A7,$1A,$28,$FF,$FF,$01  ; _Use outside to__|
.byte $09,$03,$23,$A6,$B2,$32,$44,$91,$99,$09,$04,$01          ; ___recover HP____|
.byte $09,$03,$43,$35,$20,$4E,$C0,$09,$05,$00                  ; ____for all._____|

DESC_HOUSE:
.byte $FF,$9E,$3E,$36,$B8,$B7,$B6,$AC,$A7,$1A,$28,$FF,$FF,$01  ; _Use outside to__|
.byte $FF,$23,$A6,$B2,$32,$44,$91,$99,$20,$3B,$FF,$FF,$01      ; _recover HP and__|
.byte $09,$03,$96,$99,$43,$35,$20,$4E,$C0,$09,$03,$00          ; ___MP for all.___|

DESC_EYEDROPS:
.byte $FF,$8C,$55,$2C,$31,$68,$3B,$5A,$B6,$B6,$C0,$00          ; _Cures blindness.|
.byte $06,$1C,$01
.byte $06,$1C,$00

DESC_SMOKEBOMB:                                              
.byte $FF,$9E,$3E,$1B,$2E,$3D,$A7,$1A,$1F,$FF,$FF,$01             ; _Use to hide in__|
.byte $FF,$FF,$A5,$39,$B7,$45,$BF,$36,$44,$28,$FF,$FF,$01         ; __battle, or to__|
.byte $FF,$A4,$B9,$B2,$AC,$27,$3A,$A8,$B0,$AC,$2C,$C0,$FF,$FF,$00 ; _avoid enemies.__|

DESC_ALARMCLOCK:
.byte $FF,$FF,$9E,$3E,$1B,$2E,$A4,$5D,$AE,$3A,$FF,$FF,$01      ; __Use to awaken__|
.byte $FF,$1B,$1D,$4F,$2F,$B7,$4B,$A9,$4D,$B0,$FF,$FF,$01      ; _the party from__|
.byte $FF,$B6,$45,$A8,$B3,$2D,$29,$A5,$39,$B7,$45,$C0,$00      ; _sleep in battle.|

DESC_BOTTLE:
.byte $FF,$FF,$95,$B2,$B2,$AE,$C4,$FF,$9D,$1D,$23,$BE,$B6,$FF,$FF,$01  ; __Look! There's__|
.byte $B6,$49,$A8,$1C,$1F,$47,$51,$B8,$AA,$AB,$B7,$FF,$01              ; something caught_|
.byte $FF,$FF,$2D,$B1,$B6,$AC,$A7,$1A,$5B,$69,$C5,$FF,$FF,$00          ; __inside it...?__|

DESC_LEWDS:
.byte $FF,$A2,$26,$38,$22,$BE,$21,$23,$A4,$A7,$FF,$FF,$01      ; _You can't read__|
.byte $FF,$1C,$39,$FF,$B8,$B1,$45,$B6,$1E,$56,$B8,$FF,$01      ; _that unless you_|
.byte $FF,$31,$B8,$4B,$5B,$43,$AC,$63,$B7,$C4,$FF,$FF,$00      ; __buy it first!__|








DESC_MG_CURE:
.byte $06,$00,$01                                              ; _Lightly recover |
.byte $06,$14,$01                                              ; ___HP for one    |
.byte $06,$0C,$00                                              ; __party member.  |

DESC_MG_HARM:
.byte $06,$05,$01                                              ; _Lightly damage  |
.byte $06,$11,$01                                              ; _undead enemies  |
.byte $06,$18,$00                                              ; _with holy magic.|

DESC_MG_FOG:
.byte $09,$03,$8E,$B1,$A6,$41,$B1,$21,$3C,$1A,$FF,$FF,$01      ; ___Enchant one___|
.byte $1B,$2F,$66,$B7,$BE,$1E,$2F,$B0,$35,$BF,$FF,$01          ; _target's armor,_|
.byte $06,$19,$00                                              ; _raising defense.|

DESC_MG_RUSE:
.byte $FF,$8C,$23,$39,$A8,$20,$FF,$AA,$AB,$B2,$37,$FF,$FF,$01  ; _Create a ghost__|
.byte $FF,$36,$54,$1C,$1A,$51,$37,$25,$BF,$FF,$01              ; __of the caster,_|
.byte $06,$1A,$00                                              ; _raising evasion.|

DESC_MG_FIRE:
.byte $06,$05,$01                                              ; _Lightly damage  |
.byte $06,$09,$01                                              ; ____one enemy    |
.byte $06,$15,$00                                              ; ____with fire.   |

DESC_MG_SLEP:
.byte $06,$0D,$01                                              ; __Slight chance  |
.byte $09,$03,$1B,$2E,$B6,$45,$A8,$B3,$09,$05,$01              ; ____to sleep_____|
.byte $06,$10,$C0,$FF,$FF,$00                                  ; ___all enemies.__|

DESC_MG_LOCK:
.byte $FF,$8C,$41,$B1,$48,$1B,$2E,$B7,$B5,$A4,$B3,$FF,$FF,$01  ; _Chance to trap  |
.byte $06,$0F,$BF,$09,$03,$01                                  ; ____one enemy,   |
.byte $06,$1B,$00                                              ; lowering evasion.|

DESC_MG_LIT:
.byte $06,$05,$01                                              ; _Lightly damage  |
.byte $06,$09,$01                                              ; ____one enemy    |
.byte $06,$16,$00                                              ; _with lightning. |

DESC_MG_LAMP:
.byte $06,$04,$01                                              ; __Recover from   |
.byte $09,$03,$31,$68,$3B,$5A,$B6,$B6,$C0,$09,$03,$01          ; ____blindness.___|
.byte $06,$1C,$00

DESC_MG_MUTE:
.byte $06,$0D,$01                                              ; __Slight chance  |
.byte $FF,$FF,$1B,$2E,$B6,$61,$3A,$48,$09,$04,$01              ; ___to silence____|
.byte $06,$10,$C0,$FF,$FF,$00                                  ; ___all enemies.__|

DESC_MG_ALIT:
.byte $06,$0A,$01                                              ; Protect the party|
.byte $43,$4D,$B0,$65,$AC,$AA,$AB,$B7,$B1,$1F,$AA,$C0,$FF,$01  ; _from lightning._|
.byte $06,$1C,$00

DESC_MG_INVS:
.byte $FF,$9D,$55,$29,$1C,$1A,$B7,$2F,$66,$21,$01              ; _Turn the target_|
.byte $09,$03,$2D,$B1,$B9,$30,$AC,$A5,$45,$BF,$09,$03,$01      ; ____invisible,___|
.byte $06,$1A,$00                                              ; _raising evasion.|

DESC_MG_ICE:
.byte $06,$05,$01                                              ; _Lightly damage  |
.byte $06,$09,$01                                              ; ____one enemy    |
.byte $06,$17,$00                                              ; ____with ice.    |

DESC_MG_DARK:
.byte $06,$0D,$01                                              ; __Slight chance  |
.byte $09,$03,$1B,$2E,$A5,$68,$3B,$09,$05,$01                  ; ____to blind     |
.byte $06,$10,$C0,$FF,$FF,$00                                  ; ___all enemies.__|

DESC_MG_TMPR:
.byte $09,$03,$91,$2F,$A7,$3A,$1B,$1D,$09,$04,$01              ; ___Harden the    |
.byte $1B,$2F,$66,$B7,$BE,$1E,$60,$A4,$B3,$3C,$C0,$01          ; _target's weapon.|
.byte $06,$1C,$00

DESC_MG_SLOW:
.byte $FF,$8C,$41,$B1,$48,$1B,$2E,$68,$B0,$5B,$FF,$01          ; _Chance to limit_|
.byte $06,$10,$BE,$FF,$FF,$01                                  ; ___all enemies'__|
.byte $09,$04,$20,$B7,$B7,$5E,$AE,$B6,$C0,$09,$04,$00          ; _____attacks.____|

DESC_MG_CUR2:
.byte $06,$01,$01                                              ; Strongly recover |
.byte $06,$14,$01                                              ; ___HP for one    |
.byte $06,$0C,$00                                              ; __party member.  |

DESC_MG_HRM2:
.byte $06,$06,$01                                              ; Strongly damage  |
.byte $06,$11,$01                                              ; _undead enemies  |
.byte $06,$18,$00                                              ; _with holy magic.|

DESC_MG_AFIR:
.byte $06,$0A,$01                                              ; Protect the party|
.byte $09,$03,$43,$4D,$B0,$43,$AC,$23,$C0,$09,$03,$01          ; ____from fire.___|
.byte $06,$1C,$00

DESC_MG_REGN:
.byte $06,$03,$01                                              ; _Recover party's |
.byte $06,$13,$01                                              ; __HP over time.  |
.byte $FF,$C8,$95,$3F,$B7,$1E,$83,$1B,$55,$B1,$B6,$C9,$FF,$00  ; _[Lasts 3 turns]_|

DESC_MG_FIR2:
.byte $06,$06,$01                                              ; _Strongly damage |
.byte $06,$10,$09,$03,$01                                      ; ___all enemies___|
.byte $06,$15,$00                                              ; ____with fire.   |

DESC_MG_HOLD:
.byte $06,$0D,$01                                              ; __Slight chance  |
.byte $09,$04,$1B,$2E,$37,$B8,$29,$09,$04,$01                  ; _____to stun_____|
.byte $06,$0F,$C0,$09,$03,$00                                  ; ____one enemy.___|

DESC_MG_LIT2:
.byte $06,$06,$01                                              ; _Strongly damage |
.byte $06,$10,$09,$03,$01                                      ; ___all enemies___|
.byte $06,$16,$00                                              ; _with lightning. |

DESC_MG_LOK2:
.byte $FF,$8C,$41,$B1,$48,$1B,$2E,$B7,$B5,$A4,$B3,$FF,$FF,$01  ; _Chance to trap__|
.byte $06,$10,$BF,$FF,$FF,$01                                  ; ___all enemies,__|
.byte $06,$1B,$00                                              ; lowering evasion.|

DESC_MG_PURE:
.byte $06,$04,$01                                              ; __Recover from  |
.byte $09,$04,$4F,$B2,$30,$3C,$C0,$09,$05,$01                  ; _____poison.____|
.byte $06,$1C,$00

DESC_MG_FEAR:
.byte $FF,$8C,$41,$B1,$48,$1B,$2E,$B6,$51,$23,$FF,$01          ; _Chance to scare_|
.byte $06,$10,$09,$03,$01                                      ; ___all enemies___|
.byte $FF,$2D,$B1,$28,$43,$45,$A8,$1F,$AA,$C0,$FF,$FF,$00      ; __into fleeing.__|

DESC_MG_AICE:
.byte $06,$0A,$01                                              ; Protect the party|
.byte $09,$03,$43,$4D,$B0,$2D,$48,$C0,$09,$04,$01              ; ____from ice.____|
.byte $06,$1C,$00

DESC_MG_AMUT:
.byte $06,$04,$01                                              ; __Recover from   |
.byte $B0,$A4,$AA,$AC,$51,$58,$B0,$B8,$53,$5A,$B6,$B6,$C0,$01  ; magical muteness.|
.byte $06,$1C,$00

DESC_MG_SLP2:
.byte $06,$0E,$01                                              ; _Greater chance  |
.byte $09,$04,$1B,$2E,$B6,$45,$A8,$B3,$09,$04,$01              ;_____to sleep_____|
.byte $06,$0F,$C0,$09,$03,$00                                  ; ____one enemy.___|

DESC_MG_FAST:
.byte $FF,$90,$AC,$B9,$A8,$FF,$1C,$1A,$B7,$2F,$66,$21,$01      ; _Give the target_|
.byte $42,$35,$1A,$A6,$41,$B1,$48,$1E,$28,$FF,$01              ; _more chances to_|
.byte $20,$B7,$B7,$5E,$AE,$4F,$25,$1B,$55,$B1,$C0,$00          ; _attack per turn.|

DESC_MG_CONF:
.byte $FF,$FF,$8C,$41,$B1,$48,$1B,$2E,$32,$BB,$FF,$FF,$01      ; __Chance to vex__|
.byte $06,$10,$09,$03,$01                                      ; ___all enemies___|
.byte $FF,$2D,$B1,$28,$2D,$B1,$B6,$22,$5B,$BC,$C0,$FF,$00      ; __into insanity._|

DESC_MG_ICE2:
.byte $06,$06,$01                                              ; _Strongly damage |
.byte $06,$10,$09,$03,$01                                      ; ___all enemies___|
.byte $06,$17,$00                                              ; ____with ice.    |

DESC_MG_CUR3:
.byte $06,$02,$01                                              ; _Greatly recover |
.byte $06,$14,$01                                              ; ___HP for one    |
.byte $06,$0C,$00                                              ; __party member.  |

DESC_MG_LIFE:
.byte $06,$04,$01                                              ; __Recover from   |
.byte $09,$04,$FF,$67,$2B,$1C,$C0,$09,$04,$FF,$01              ; ______death._____|
.byte $06,$1C,$00

DESC_MG_HRM3:
.byte $06,$07,$01                                              ; _Heavily damage  |
.byte $06,$11,$01                                              ; _undead enemies  |
.byte $06,$18,$00                                              ; _with holy magic.|

DESC_MG_RGN2:
.byte $06,$03,$01                                              ; _Recover party's |
.byte $06,$13,$01                                              ; __HP over time.  |
.byte $FF,$C8,$95,$3F,$B7,$1E,$84,$1B,$55,$B1,$B6,$C9,$FF,$00  ; _[Lasts 4 turns]_|

DESC_MG_FIR3:
.byte $06,$07,$01                                              ; _Heavily damage  |
.byte $06,$10,$09,$03,$01                                      ; ___all enemies___|
.byte $06,$15,$00                                              ; ____with fire.   |

DESC_MG_BANE:
.byte $FF,$8C,$41,$B1,$48,$1B,$2E,$AE,$61,$58,$FF,$01          ; _Chance to kill__|
.byte $06,$10,$09,$03,$01                                      ; ___all enemies___|
.byte $FF,$FF,$33,$5B,$AB,$4F,$B2,$30,$3C,$C0,$FF,$FF,$00      ; ___with poison.__|

DESC_MG_WARP:
.byte $06,$0B,$01                                              ; Return the party |
.byte $1B,$2E,$1C,$1A,$B3,$23,$B9,$AC,$26,$1E,$01              ; _to the previous_|
.byte $65,$A8,$32,$AF,$BF,$36,$44,$A8,$BB,$5B,$C0,$FF,$00      ; _level, or exit._|

DESC_MG_SLO2:
.byte $06,$0E,$01                                              ; _Greater chance  |
.byte $FF,$1B,$2E,$68,$B0,$5B,$36,$5A,$09,$03,$01              ; __to limit one___|
.byte $FF,$3A,$A8,$B0,$BC,$BE,$1E,$39,$B7,$5E,$AE,$B6,$C0,$00  ; _enemy's attacks.|

DESC_MG_SOFT:
.byte $06,$04,$01                                              ; __Recover from   |
.byte $09,$05,$24,$28,$5A,$C0,$09,$05,$01                      ; ______stone._____|
.byte $06,$1C,$00

DESC_MG_EXIT:
.byte $06,$0B,$01                                              ; Return the party |
.byte $FF,$FF,$1B,$2E,$1C,$1A,$A8,$BB,$5B,$C0,$FF,$FF,$01      ; ___to the exit.__|
.byte $06,$1C,$00

DESC_MG_FOG2:
.byte $09,$03,$8E,$B1,$A6,$41,$B1,$21,$1C,$1A,$FF,$FF,$01      ; ___Enchant the___|
.byte $FF,$4F,$2F,$B7,$BC,$BE,$1E,$A4,$B5,$B0,$35,$BF,$FF,$01  ; __party's armor,_|
.byte $06,$19,$00                                              ; _raising defense.|

DESC_MG_INV2:
.byte $FF,$9D,$55,$29,$1C,$1A,$B3,$2F,$B7,$4B,$FF,$01          ; _Turn the party__|
.byte $09,$03,$2D,$B1,$B9,$30,$AC,$A5,$45,$BF,$09,$03,$01      ; ____invisible,___|
.byte $06,$1A,$00                                              ; _raising evasion.|

DESC_MG_LIT3:
.byte $06,$07,$01                                              ; _Heavily damage  |
.byte $06,$10,$09,$03,$01                                      ; ___all enemies___|
.byte $06,$16,$00                                              ; _with lightning. |

DESC_MG_RUB:
.byte $FF,$8C,$41,$B1,$48,$1B,$2E,$25,$3F,$1A,$01              ; _Chance to erase_|
.byte $06,$0F,$C0,$09,$03,$01                                  ; ____one enemy.___|
.byte $06,$1C,$00

DESC_MG_QAKE:
.byte $FF,$8C,$41,$B1,$48,$1B,$2E,$3E,$3B,$FF,$FF,$01          ; _Chance to send__|
.byte $06,$10,$09,$03,$01                                      ; ___all enemies___|
.byte $2D,$B1,$28,$1B,$1D,$FF,$2B,$B5,$1C,$C0,$FF,$00          ; _into the earth._|

DESC_MG_STUN:
.byte $FF,$92,$B1,$A9,$68,$A6,$21,$37,$B8,$29,$3C,$FF,$01      ; _Inflict stun on_|
.byte $06,$09,$01                                              ; ____one enemy    |
.byte $06,$12,$00                                              ; _when HP is low. |

DESC_MG_CUR4:
.byte $FF,$9B,$A8,$A6,$B2,$32,$44,$5F,$58,$91,$99,$FF,$FF,$01  ; _Recover all HP  |
.byte $22,$27,$61,$AF,$1E,$A9,$35,$36,$5A,$FF,$01              ; and ills for one |
.byte $06,$0C,$00                                              ; __party member.  |

DESC_MG_HRM4:
.byte $06,$08,$01                                              ; Massively damage |
.byte $06,$11,$01                                              ; _undead enemies  |
.byte $06,$18,$00                                              ; with holy magic. |

DESC_MG_ARUB:
.byte $06,$0A,$01                                              ; Protect the party|
.byte $FF,$FF,$43,$4D,$B0,$67,$2B,$1C,$C0,$09,$03,$01          ; ___from death.___|
.byte $06,$1C,$00

DESC_MG_RGN3:
.byte $06,$03,$01                                              ; _Recover party's |
.byte $06,$13,$01                                              ; __HP over time.  |
.byte $FF,$C8,$95,$3F,$B7,$1E,$85,$1B,$55,$B1,$B6,$C9,$FF,$00  ; _[Lasts 5 turns] |

DESC_MG_ICE3:
.byte $06,$07,$01                                              ; _Heavily damage  |
.byte $06,$10,$09,$03,$01                                      ; ___all enemies   |
.byte $06,$17,$00                                              ; ____with ice.    |

DESC_MG_BRAK:
.byte $FF,$8C,$41,$B1,$48,$1B,$2E,$B7,$55,$29,$FF,$01          ; _Chance to turn__|
.byte $06,$09,$01                                              ; ____one enemy    |
.byte $FF,$FF,$2D,$B1,$28,$24,$28,$5A,$C0,$09,$03,$00          ; ___into stone.___|

DESC_MG_SABR:
.byte $09,$03,$91,$2F,$A7,$3A,$1B,$1D,$09,$04,$01              ; ___Harden the____|
.byte $38,$3F,$53,$B5,$BE,$1E,$60,$A4,$B3,$3C,$C0,$01          ; _caster's weapon.|
.byte $06,$1C,$00

DESC_MG_BLND:
.byte $92,$B1,$A9,$68,$A6,$21,$A5,$68,$3B,$36,$29,$01          ; Inflict blind on_|
.byte $06,$09,$01                                              ; ____one enemy    |
.byte $06,$12,$00                                              ; _when HP is low. |

DESC_MG_LIF2:
.byte $06,$04,$01                                              ; __Recover from   |
.byte $FF,$FF,$67,$2B,$1C,$33,$5B,$AB,$09,$04,$01              ; ___death with____|
.byte $09,$03,$43,$B8,$4E,$FF,$91,$99,$C0,$09,$05,$00          ; ____full HP._____|

DESC_MG_FADE:
.byte $06,$07,$01                                              ; _Heavily damage  |
.byte $06,$10,$C0,$FF,$FF,$01                                  ; ___all enemies   |
.byte $06,$18,$00                                              ; _with holy magic.|

DESC_MG_WALL:
.byte $06,$0A,$01                                              ; Protect the party|
.byte $09,$03,$43,$4D,$B0,$20,$4E,$09,$05,$01                  ; ____from all_____|
.byte $09,$04,$A8,$45,$34,$B1,$B7,$B6,$C0,$09,$04,$00          ; ____elements.____|

DESC_MG_XFER:
.byte $9B,$A8,$B0,$B2,$32,$FF,$23,$B6,$30,$B7,$22,$48,$01      ; Remove resistance|
.byte $28,$FF,$A8,$45,$34,$B1,$B7,$1E,$A9,$4D,$B0,$FF,$01      ; to elements from_|
.byte $06,$0F,$C0,$09,$03,$00                                  ; ____one enemy.___|

DESC_MG_NUKE:
.byte $06,$08,$01                                              ; Massively damage |
.byte $06,$10,$C0,$FF,$FF,$01                                  ; ___all enemies.__|
.byte $06,$1C,$00

DESC_MG_STOP:
.byte $06,$0D,$01                                              ; __Slight chance  |
.byte $09,$04,$1B,$2E,$37,$B8,$29,$09,$04,$01                  ; _____to stun_____|
.byte $06,$10,$C0,$FF,$FF,$00                                  ; ___all enemies.__|

DESC_MG_ZAP:
.byte $06,$0D,$01                                              ; __Slight chance  |
.byte $09,$04,$1B,$2E,$AE,$61,$58,$09,$04,$01                  ; _____to kill_____|
.byte $06,$10,$C0,$FF,$FF,$00                                  ; ___all enemies.__|

DESC_MG_XXXX:
.byte $FF,$92,$B1,$37,$22,$B7,$AF,$4B,$AE,$61,$AF,$1E,$01      ; _Instantly kills_|
.byte $06,$09,$01                                              ; ____one enemy    |
.byte $06,$12,$00                                              ; _when HP is low. |



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Items in treasure chests
;;
;; An explanation of chest item IDs:
;; If the first byte is $00, the second byte is $70 or higher (80 possible amounts of gold)
;; If the first byte is $01, its an item, key item, or magic:
;; second byte: $1 through $0F are consumables   (15 possible items)
;; second byte: $10 through $2F are key items    (32 possible key items)
;; second byte: $30 through $6F are magic spells (64 possible spells)
;; If the first byte is $02, its weapons or armor:
;; $1 through $3F are weapons     (64 possible weapons)
;; $40 through $7F are armors     (64 possible armors)


lut_Treasure:
.byte $00, $00      ; 00 ; Unused             - 
.byte $02, ARM4     ; 01 ; Coneria 1          - Iron   Armor
.byte $02, ARM18    ; 02 ; Coneria 2          - Iron   Shield
.byte $01, TNT      ; 03 ; Coneria 3          - TNT    
.byte $02, WEP11    ; 04 ; Coneria 4          - Iron   Staff
.byte $02, WEP12    ; 05 ; Coneria 5          - Sabre  
.byte $02, WEP16    ; 06 ; Coneria 6          - Silver Knife
.byte $01, CABIN    ; 07 ; Temple of Fiends 1 - CABIN  
.byte $01, HEAL     ; 08 ; Temple of Fiends 2 - HEAL Potion
.byte $02, ARM26    ; 09 ; Temple of Fiends 3 - Cap    
.byte $02, WEP27    ; 0A ; Temple of Fiends 4 - Rune   Sword
.byte $02, WEP26    ; 0B ; Temple of Fiends 5 - Were   Sword
.byte $01, SOFT     ; 0C ; Temple of Fiends 6 - Soft  
.byte $02, WEP18    ; 0D ; Elfland 1          - Silver Hammer
.byte $00, GOLD22   ; 0E ; Elfland 2          - 400 G
.byte $00, GOLD19   ; 0F ; Elfland 3          - 330 G
.byte $02, ARM34    ; 10 ; Elfland 4          - Copper Gauntlets
.byte $02, WEP28    ; 11 ; NorthWest Castle 1 - Power  Staff
.byte $02, ARM35    ; 12 ; NorthWest Castle 2 - Iron   Gauntlets
.byte $02, WEP15    ; 13 ; NorthWest Castle 3 - Falchon
.byte $01, PHOENIXDOWN ; JIGS - to combat Astos's RUB
;.byte $00, GOLD16   ; 14 ; Marsh Cave 1       - 295 G 
.byte $02, ARM11    ; 15 ; Marsh Cave 2       - Copper Bracelet
.byte $01, HOUSE    ; 16 ; Marsh Cave 3       - HOUSE  
.byte $00, GOLD21   ; 17 ; Marsh Cave 4       - 385 G
.byte $00, GOLD27   ; 18 ; Marsh Cave 5       - 620 G
.byte $02, WEP6     ; 19 ; Marsh Cave 6       - Short  Sword
.byte $00, GOLD28   ; 1A ; Marsh Cave 7       - 680 G
.byte $02, WEP10    ; 1B ; Marsh Cave 8       - Large  Knife
.byte $01, CROWN    ; 1C ; Marsh Cave 9       - CROWN  
.byte $02, ARM4     ; 1D ; Marsh Cave 10      - Iron   Armor
.byte $02, ARM12    ; 1E ; Marsh Cave 11      - Silver Bracelet
.byte $02, WEP16    ; 1F ; Marsh Cave 12      - Silver Knife
.byte $00, GOLD32   ; 20 ; Marsh Cave 13      - 1020 G
.byte $01, GOLD23   ; 21 ; Dwarf Cave 1       - 450 G
.byte $00, GOLD26   ; 22 ; Dwarf Cave 2       - 575 G
.byte $01, CABIN    ; 23 ; Dwarf Cave 3       - CABIN  
.byte $02, ARM27    ; 24 ; Dwarf Cave 4       - Iron   Helmet
.byte $02, ARM27    ; 25 ; Dwarf Cave 5       - Wooden Helmet
.byte $02, WEP22    ; 26 ; Dwarf Cave 6       - Dragon Sword
.byte $02, WEP16    ; 27 ; Dwarf Cave 7       - Silver Knife
.byte $02, ARM6     ; 28 ; Dwarf Cave 8       - Silver Armor
.byte $00, GOLD26   ; 29 ; Dwarf Cave 9       - 575 G
.byte $01, HOUSE    ; 2A ; Dwarf Cave 10      - HOUSE  
.byte $01, HEAL     ; 2B ; Matoya's Cave 1    - HEAL Potion
.byte $01, PURE     ; 2C ; Matoya's Cave 2    - PURE Potion
.byte $01, HEAL     ; 2D ; Matoya's Cave 3    - HEAL Potion
.byte $00, GOLD31   ; 2E ; Earth Cave 1       - 880 G
.byte $01, HEAL     ; 2F ; Earth Cave 2       - HEAL Potion
.byte $01, PURE     ; 30 ; Earth Cave 3       - PURE Potion
.byte $00, GOLD30   ; 31 ; Earth Cave 4       - 795 G
.byte $00, GOLD37   ; 32 ; Earth Cave 5       - 1975 G
.byte $02, WEP25    ; 33 ; Earth Cave 6       - Coral  Sword
.byte $01, CABIN    ; 34 ; Earth Cave 7       - CABIN  
.byte $00, GOLD19   ; 35 ; Earth Cave 8       - 330 G
.byte $00, GOLD42   ; 36 ; Earth Cave 9       - 5000 G
.byte $02, ARM17    ; 37 ; Earth Cave 10      - Wooden Shield
.byte $00, GOLD26   ; 38 ; Earth Cave 11      - 575 G
.byte $00, GOLD32   ; 39 ; Earth Cave 12      - 1020 G
.byte $00, GOLD40   ; 3A ; Earth Cave 13      - 3400 G
.byte $01, TENT     ; 3B ; Earth Cave 14      - TENT   
.byte $01, HEAL     ; 3C ; Earth Cave 15      - HEAL Potion
.byte $01, RUBY     ; 3D ; Earth Cave 16      - RUBY   
.byte $00, GOLD33   ; 3E ; Earth Cave 17      - 1250 G
.byte $02, ARM19    ; 3F ; Earth Cave 18      - Silver Shield
.byte $01, CABIN    ; 40 ; Earth Cave 19      - CABIN  
.byte $00, GOLD43   ; 41 ; Earth Cave 20      - 5450 G
.byte $00, GOLD35   ; 42 ; Earth Cave 21      - 1520 G
.byte $02, WEP2     ; 43 ; Earth Cave 22      - Wooden Staff
.byte $00, GOLD40   ; 44 ; Earth Cave 23      - 3400 G
.byte $00, GOLD34   ; 45 ; Earth Cave 24      - 1455 G
.byte $02, ARM29    ; 46 ; Titan's Tunnel 1   - Silver Helmet
.byte $00, GOLD23   ; 47 ; Titan's Tunnel 2   - 450 G
.byte $00, GOLD27   ; 48 ; Titan's Tunnel 3   - 620 G
.byte $02, WEP14    ; 49 ; Titan's Tunnel 4   - Great  Axe
.byte $01, HEAL     ; 4A ; Gurgu Volcano 1    - HEAL Potion
.byte $01, CABIN    ; 4B ; Gurgu Volcano 2    - CABIN  
.byte $00, GOLD37   ; 4C ; Gurgu Volcano 3    - 1975 G
.byte $01, PURE     ; 4D ; Gurgu Volcano 4    - PURE Potion
.byte $01, HEAL     ; 4E ; Gurgu Volcano 5    - HEAL Potion
.byte $00, GOLD34   ; 4F ; Gurgu Volcano 6    - 1455 G
.byte $02, ARM19    ; 50 ; Gurgu Volcano 7    - Silver Shield
.byte $00, GOLD35   ; 51 ; Gurgu Volcano 8    - 1520 G
.byte $02, ARM29    ; 52 ; Gurgu Volcano 9    - Silver Helmet
.byte $02, ARM36    ; 53 ; Gurgu Volcano 10   - Silver Gauntlets
.byte $00, GOLD36   ; 54 ; Gurgu Volcano 11   - 1760 G
.byte $02, WEP19    ; 55 ; Gurgu Volcano 12   - Silver Axe
.byte $00, GOLD30   ; 56 ; Gurgu Volcano 13   - 795 G
.byte $00, GOLD29   ; 57 ; Gurgu Volcano 14   - 750 G
.byte $02, WEP23    ; 58 ; Gurgu Volcano 15   - Giant  Sword
.byte $00, GOLD41   ; 59 ; Gurgu Volcano 16   - 4150 G
.byte $00, GOLD35   ; 5A ; Gurgu Volcano 17   - 1520 G
.byte $02, ARM29    ; 5B ; Gurgu Volcano 18   - Silver Helmet
.byte $01, SOFT     ; 5C ; Gurgu Volcano 19   - Soft  
.byte $00, GOLD39   ; 5D ; Gurgu Volcano 20   - 2750 G
.byte $00, GOLD36   ; 5E ; Gurgu Volcano 21   - 1760 G
.byte $02, WEP2     ; 5F ; Gurgu Volcano 22   - Wooden Staff
.byte $00, GOLD33   ; 60 ; Gurgu Volcano 23   - 1250 G
.byte $00, GOLD1    ; 61 ; Gurgu Volcano 24   - 10 G
.byte $00, GOLD10   ; 62 ; Gurgu Volcano 25   - 155 G
.byte $01, HOUSE    ; 63 ; Gurgu Volcano 26   - HOUSE  
.byte $00, GOLD38   ; 64 ; Gurgu Volcano 27   - 2000 G
.byte $02, WEP21    ; 65 ; Gurgu Volcano 28   - Ice    Sword
.byte $00, GOLD31   ; 66 ; Gurgu Volcano 29   - 880 G
.byte $01, PURE     ; 67 ; Gurgu Volcano 30   - PURE Potion
.byte $02, ARM20    ; 68 ; Gurgu Volcano 31   - Flame  Shield
.byte $00, GOLD46   ; 69 ; Gurgu Volcano 32   - 7340 G
.byte $02, ARM7     ; 6A ; Gurgu Volcano 33   - Flame  Armor
.byte $01, HEAL     ; 6B ; Ice Cave 1         - HEAL Potion
.byte $00, GOLD54   ; 6C ; Ice Cave 2         - 10000 G
.byte $00, GOLD52   ; 6D ; Ice Cave 3         - 9500 G
.byte $01, TENT     ; 6E ; Ice Cave 4         - TENT   
.byte $02, ARM21    ; 6F ; Ice Cave 5         - Ice    Shield
.byte $02, ARM1     ; 70 ; Ice Cave 6         - Cloth  
.byte $02, WEP20    ; 71 ; Ice Cave 7         - Flame  Sword
.byte $01, FLOATER  ; 72 ; Ice Cave 8         - FLOATER
.byte $00, GOLD48   ; 73 ; Ice Cave 9         - 7900 G
.byte $00, GOLD43   ; 74 ; Ice Cave 10        - 5450 G
.byte $00, GOLD53   ; 75 ; Ice Cave 11        - 9900 G
.byte $00, GOLD42   ; 76 ; Ice Cave 12        - 5000 G
.byte $00, GOLD12   ; 77 ; Ice Cave 13        - 180 G
.byte $00, GOLD55   ; 78 ; Ice Cave 14        - 12350 G
.byte $02, ARM36    ; 79 ; Ice Cave 15        - Silver Gauntlets
.byte $02, ARM8     ; 7A ; Ice Cave 16        - Ice    Armor
.byte $02, ARM37    ; 7B ; Castle of Ordeal 1 - Zeus   Gauntlets
.byte $01, HOUSE    ; 7C ; Castle of Ordeal 2 - HOUSE  
.byte $00, GOLD34   ; 7D ; Castle of Ordeal 3 - 1455 G
.byte $00, GOLD46   ; 7E ; Castle of Ordeal 4 - 7340 G
.byte $02, ARM13    ; 7F ; Castle of Ordeal 5 - Gold   Bracelet
.byte $02, WEP21    ; 80 ; Castle of Ordeal 6 - Ice    Sword
.byte $02, ARM35    ; 81 ; Castle of Ordeal 7 - Iron   Gauntlets
.byte $02, WEP30    ; 82 ; Castle of Ordeal 8 - Heal   Staff
.byte $01, TAIL     ; 83 ; Castle of Ordeal 9 - TAIL   
.byte $00, GOLD34   ; 84 ; Cardia 1           - 1455 G
.byte $00, GOLD38   ; 85 ; Cardia 2           - 2000 G
.byte $00, GOLD39   ; 86 ; Cardia 3           - 2750 G
.byte $00, GOLD39   ; 87 ; Cardia 4           - 2750 G
.byte $00, GOLD35   ; 88 ; Cardia 5           - 1520 G
.byte $00, GOLD1    ; 89 ; Cardia 6           - 10 G
.byte $00, GOLD24   ; 8A ; Cardia 7           - 500 G
.byte $01, HOUSE    ; 8B ; Cardia 8           - HOUSE  
.byte $00, GOLD26   ; 8C ; Cardia 9           - 575 G
.byte $01, SOFT     ; 8D ; Cardia 10          - Soft  
.byte $01, CABIN    ; 8E ; Cardia 11          - CABIN  
.byte $00, GOLD52   ; 8F ; Cardia 12          - 9500 G
.byte $00, GOLD11   ; 90 ; Cardia 13          - 160 G
.byte $00, $00      ; 91 ; Not Used 1         - 530 G
.byte $00, $00      ; 92 ; Not Used 2         - Small  Knife
.byte $00, $00      ; 93 ; Not Used 3         - Cap    
.byte $00, $00      ; 94 ; Not Used 4         - Zeus   Gauntlets
.byte $02, ARM32    ; 95 ; Sea Shrine 1       - Ribbon  
.byte $00, GOLD53   ; 96 ; Sea Shrine 2       - 9900 G
.byte $00, GOLD46   ; 97 ; Sea Shrine 3       - 7340 G
.byte $00, GOLD39   ; 98 ; Sea Shrine 4       - 2750 G
.byte $00, GOLD47   ; 99 ; Sea Shrine 5       - 7690 G
.byte $00, GOLD49   ; 9A ; Sea Shrine 6       - 8135 G
.byte $00, GOLD43   ; 9B ; Sea Shrine 7       - 5450 G
.byte $00, GOLD21   ; 9C ; Sea Shrine 8       - 385 G
.byte $02, ARM38    ; 9D ; Sea Shrine 9       - Power  Gauntlets
.byte $02, WEP29    ; 9E ; Sea Shrine 10      - Light  Axe
.byte $00, GOLD53   ; 9F ; Sea Shrine 11      - 9900 G
.byte $00, GOLD38   ; A0 ; Sea Shrine 12      - 2000 G
.byte $00, GOLD23   ; A1 ; Sea Shrine 13      - 450 G
.byte $00, GOLD8    ; A2 ; Sea Shrine 14      - 110 G
.byte $02, WEP29    ; A3 ; Sea Shrine 15      - Light  Axe
.byte $02, ARM9     ; A4 ; Sea Shrine 16      - Opal   Armor
.byte $00, GOLD2    ; A5 ; Sea Shrine 17      - 20 G
.byte $02, WEP31    ; A6 ; Sea Shrine 18      - Mage   Staff
.byte $00, GOLD55   ; A7 ; Sea Shrine 19      - 12350 G
.byte $00, GOLD50   ; A8 ; Sea Shrine 20      - 9000 G
.byte $00, GOLD36   ; A9 ; Sea Shrine 21      - 1760 G
.byte $02, ARM14    ; AA ; Sea Shrine 22      - Opal   Bracelet
.byte $00, GOLD39   ; AB ; Sea Shrine 23      - 2750 G
.byte $00, GOLD54   ; AC ; Sea Shrine 24      - 10000 G
.byte $00, GOLD1    ; AD ; Sea Shrine 25      - 10 G
.byte $00, GOLD41   ; AE ; Sea Shrine 26      - 4150 G
.byte $00, GOLD42   ; AF ; Sea Shrine 27      - 5000 G
.byte $01, PURE     ; B0 ; Sea Shrine 28      - PURE Potion
.byte $02, ARM22    ; B1 ; Sea Shrine 29      - Opal   Shield
.byte $02, ARM30    ; B2 ; Sea Shrine 30      - Opal   Helmet
.byte $02, ARM39    ; B3 ; Sea Shrine 31      - Opal   Gauntlets
.byte $01, SLAB     ; B4 ; Sea Shrine 32      - SLAB   
.byte $02, WEP33    ; B5 ; Waterfall 1        - Wizard Staff
.byte $02, ARM32    ; B6 ; Waterfall 2        - Ribbon  
.byte $00, GOLD57   ; B7 ; Waterfall 3        - 13450 G
.byte $00, GOLD44   ; B8 ; Waterfall 4        - 6400 G
.byte $00, GOLD42   ; B9 ; Waterfall 5        - 5000 G
.byte $02, WEP32    ; BA ; Waterfall 6        - Defense
.byte $00, $00      ; BB ; Not Used 5         - HEAL Potion
.byte $00, $00      ; BC ; Not Used 6         - HEAL Potion
.byte $00, $00      ; BD ; Not Used 7         - HEAL Potion
.byte $00, $00      ; BE ; Not Used 8         - HEAL Potion
.byte $00, $00      ; BF ; Not Used 9         - HEAL Potion
.byte $00, $00      ; C0 ; Not Used 10        - HEAL Potion
.byte $00, $00      ; C1 ; Not Used 11        - HEAL Potion
.byte $00, $00      ; C2 ; Not Used 12        - HEAL Potion
.byte $00, $00      ; C3 ; Not Used 13        - HEAL Potion
.byte $02, ARM23    ; C4 ; Mirage Tower 1     - Aegis  Shield
.byte $00, GOLD39   ; C5 ; Mirage Tower 2     - 2750 G
.byte $00, GOLD40   ; C6 ; Mirage Tower 3     - 3400 G
.byte $00, GOLD62   ; C7 ; Mirage Tower 4     - 18010 G
.byte $01, CABIN    ; C8 ; Mirage Tower 5     - CABIN  
.byte $02, ARM31    ; C9 ; Mirage Tower 6     - Heal   Helmet
.byte $00, GOLD31   ; CA ; Mirage Tower 7     - 880 G
.byte $02, WEP34    ; CB ; Mirage Tower 8     - Vorpal 
.byte $01, HOUSE    ; CC ; Mirage Tower 9     - HOUSE  
.byte $00, GOLD47   ; CD ; Mirage Tower 10    - 7690 G
.byte $02, WEP24    ; CE ; Mirage Tower 11    - Sun    Sword
.byte $00, GOLD54   ; CF ; Mirage Tower 12    - 10000 G
.byte $02, ARM10    ; D0 ; Mirage Tower 13    - Dragon Armor
.byte $00, GOLD49   ; D1 ; Mirage Tower 14    - 8135 G
.byte $00, GOLD48   ; D2 ; Mirage Tower 15    - 7900 G
.byte $02, WEP36    ; D3 ; Mirage Tower 16    - Thor   Hammer
.byte $00, GOLD55   ; D4 ; Mirage Tower 17    - 12350 G
.byte $00, GOLD56   ; D5 ; Mirage Tower 18    - 13000 G
.byte $00, GOLD53   ; D6 ; Sky Palace 1       - 9900 G
.byte $01, HEAL     ; D7 ; Sky Palace 2       - HEAL Potion
.byte $00, GOLD42   ; D8 ; Sky Palace 3       - 4150 G
.byte $00, GOLD48   ; D9 ; Sky Palace 4       - 7900 G
.byte $00, GOLD42   ; DA ; Sky Palace 5       - 5000 G
.byte $02, ARM40    ; DB ; Sky Palace 6       - ProRing
.byte $00, GOLD45   ; DC ; Sky Palace 7       - 6720 G
.byte $02, ARM31    ; DD ; Sky Palace 8       - Heal   Helmet
.byte $00, GOLD12   ; DE ; Sky Palace 9       - 180 G
.byte $02, WEP37    ; DF ; Sky Palace 10      - Bane   Sword
.byte $02, ARM15    ; E0 ; Sky Palace 11      - White  Shirt
.byte $02, ARM16    ; E1 ; Sky Palace 12      - Black  Shirt
.byte $02, ARM32    ; E2 ; Sky Palace 13      - Ribbon  
.byte $02, ARM39    ; E3 ; Sky Palace 14      - Opal   Gauntlets
.byte $02, ARM22    ; E4 ; Sky Palace 15      - Opal   Shield
.byte $02, ARM29    ; E5 ; Sky Palace 16      - Silver Helmet
.byte $01, HOUSE    ; E6 ; Sky Palace 17      - HOUSE  
.byte $00, GOLD31   ; E7 ; Sky Palace 18      - 880 G
.byte $00, GOLD56   ; E8 ; Sky Palace 19      - 13000 G
.byte $01, ADAMANT  ; E9 ; Sky Palace 20      - ADAMANT
.byte $00, GOLD41   ; EA ; Sky Palace 21      - 4150 G
.byte $01, SOFT     ; EB ; Sky Palace 22      - Soft  
.byte $00, GOLD40   ; EC ; Sky Palace 23      - 3400 G
.byte $02, WEP38    ; ED ; Sky Palace 24      - Katana 
.byte $01, ARM25    ; EE ; Sky Palace 25      - ProCape
.byte $02, ARM1     ; EF ; Sky Palace 26      - Cloth  
.byte $00, GOLD52   ; F0 ; Sky Palace 27      - 9500 G
.byte $01, SOFT     ; F1 ; Sky Palace 28      - Soft  
.byte $00, GOLD44   ; F2 ; Sky Palace 29      - 6400 G
.byte $00, GOLD49   ; F3 ; Sky Palace 30      - 8135 G
.byte $00, GOLD50   ; F4 ; Sky Palace 31      - 9000 G
.byte $01, HEAL     ; F5 ; Sky Palace 32      - HEAL Potion
.byte $02, ARM40    ; F6 ; Sky Palace 33      - ProRing
.byte $00, GOLD45   ; F7 ; Sky Palace 34      - 5450 G
.byte $02, WEP40    ; F8 ; ToF Revisited 1    - Masmune
.byte $00, GOLD66   ; F9 ; ToF Revisited 2    - 26000 G
.byte $02, WEP38    ; FA ; ToF Revisited 3    - Katana 
.byte $02, ARM40    ; FB ; ToF Revisited 4    - ProRing
.byte $02, ARM25    ; FC ; ToF Revisited 5    - ProCape
.byte $00, GOLD67   ; FD ; ToF Revisited 6    - 45000 G
.byte $00, GOLD68   ; FE ; ToF Revisited 7    - 65000 G
.byte $00, $00      ; FF ;Unused             - 

;; JIGS - this is an entirely new treasure table. None of these are used by the original game.

lut_Treasure_2:
.byte $00, $00        ; 00 ; Unused
.byte $02, WEP41      ; 01 ; Chicken Knife
.byte $00, $00        ; 02 ;
.byte $00, $00        ; 03 ;
.byte $00, $00        ; 04 ;
.byte $00, $00        ; 05 ;
.byte $00, $00        ; 06 ;
.byte $00, $00        ; 07 ;
.byte $00, $00        ; 08 ;
.byte $00, $00        ; 09 ;
.byte $00, $00        ; 0A ;
.byte $00, $00        ; 0B ;
.byte $00, $00        ; 0C ;
.byte $00, $00        ; 0D ;
.byte $00, $00        ; 0E ;
.byte $00, $00        ; 0F ;
.byte $00, $00        ; 10 ;
.byte $00, $00        ; 11 ;
.byte $00, $00        ; 12 ;
.byte $00, $00        ; 13 ;
.byte $00, $00        ; 14 ;
.byte $00, $00        ; 15 ;
.byte $00, $00        ; 16 ;
.byte $00, $00        ; 17 ;
.byte $00, $00        ; 18 ;
.byte $00, $00        ; 19 ;
.byte $00, $00        ; 1A ;
.byte $00, $00        ; 1B ;
.byte $00, $00        ; 1C ;
.byte $00, $00        ; 1D ;
.byte $00, $00        ; 1E ;
.byte $00, $00        ; 1F ;
.byte $00, $00        ; 20 ;
.byte $00, $00        ; 21 ;
.byte $00, $00        ; 22 ;
.byte $00, $00        ; 23 ;
.byte $00, $00        ; 24 ;
.byte $00, $00        ; 25 ;
.byte $00, $00        ; 26 ;
.byte $00, $00        ; 27 ;
.byte $00, $00        ; 28 ;
.byte $00, $00        ; 29 ;
.byte $00, $00        ; 2A ;
.byte $00, $00        ; 2B ;
.byte $00, $00        ; 2C ;
.byte $00, $00        ; 2D ;
.byte $00, $00        ; 2E ;
.byte $00, $00        ; 2F ;
.byte $00, $00        ; 30 ;
.byte $00, $00        ; 31 ;
.byte $00, $00        ; 32 ;
.byte $00, $00        ; 33 ;
.byte $00, $00        ; 34 ;
.byte $00, $00        ; 35 ;
.byte $00, $00        ; 36 ;
.byte $00, $00        ; 37 ;
.byte $00, $00        ; 38 ;
.byte $00, $00        ; 39 ;
.byte $00, $00        ; 3A ;
.byte $00, $00        ; 3B ;
.byte $00, $00        ; 3C ;
.byte $00, $00        ; 3D ;
.byte $00, $00        ; 3E ;
.byte $00, $00        ; 3F ;
.byte $00, $00        ; 40 ;
.byte $00, $00        ; 41 ;
.byte $00, $00        ; 42 ;
.byte $00, $00        ; 43 ;
.byte $00, $00        ; 44 ;
.byte $00, $00        ; 45 ;
.byte $00, $00        ; 46 ;
.byte $00, $00        ; 47 ;
.byte $00, $00        ; 48 ;
.byte $00, $00        ; 49 ;
.byte $00, $00        ; 4A ;
.byte $00, $00        ; 4B ;
.byte $00, $00        ; 4C ;
.byte $00, $00        ; 4D ;
.byte $00, $00        ; 4E ;
.byte $00, $00        ; 4F ;
.byte $00, $00        ; 50 ;
.byte $00, $00        ; 51 ;
.byte $00, $00        ; 52 ;
.byte $00, $00        ; 53 ;
.byte $00, $00        ; 54 ;
.byte $00, $00        ; 55 ;
.byte $00, $00        ; 56 ;
.byte $00, $00        ; 57 ;
.byte $00, $00        ; 58 ;
.byte $00, $00        ; 59 ;
.byte $00, $00        ; 5A ;
.byte $00, $00        ; 5B ;
.byte $00, $00        ; 5C ;
.byte $00, $00        ; 5D ;
.byte $00, $00        ; 5E ;
.byte $00, $00        ; 5F ;
.byte $00, $00        ; 60 ;
.byte $00, $00        ; 61 ;
.byte $00, $00        ; 62 ;
.byte $00, $00        ; 63 ;
.byte $00, $00        ; 64 ;
.byte $00, $00        ; 65 ;
.byte $00, $00        ; 66 ;
.byte $00, $00        ; 67 ;
.byte $00, $00        ; 68 ;
.byte $00, $00        ; 69 ;
.byte $00, $00        ; 6A ;
.byte $00, $00        ; 6B ;
.byte $00, $00        ; 6C ;
.byte $00, $00        ; 6D ;
.byte $00, $00        ; 6E ;
.byte $00, $00        ; 6F ;
.byte $00, $00        ; 70 ;
.byte $00, $00        ; 71 ;
.byte $00, $00        ; 72 ;
.byte $00, $00        ; 73 ;
.byte $00, $00        ; 74 ;
.byte $00, $00        ; 75 ;
.byte $00, $00        ; 76 ;
.byte $00, $00        ; 77 ;
.byte $00, $00        ; 78 ;
.byte $00, $00        ; 79 ;
.byte $00, $00        ; 7A ;
.byte $00, $00        ; 7B ;
.byte $00, $00        ; 7C ;
.byte $00, $00        ; 7D ;
.byte $00, $00        ; 7E ;
.byte $00, $00        ; 7F ;
.byte $00, $00        ; 80 ;
.byte $00, $00        ; 81 ;
.byte $00, $00        ; 82 ;
.byte $00, $00        ; 83 ;
.byte $00, $00        ; 84 ;
.byte $00, $00        ; 85 ;
.byte $00, $00        ; 86 ;
.byte $00, $00        ; 87 ;
.byte $00, $00        ; 88 ;
.byte $00, $00        ; 89 ;
.byte $00, $00        ; 8A ;
.byte $00, $00        ; 8B ;
.byte $00, $00        ; 8C ;
.byte $00, $00        ; 8D ;
.byte $00, $00        ; 8E ;
.byte $00, $00        ; 8F ;
.byte $00, $00        ; 90 ;
.byte $00, $00        ; 91 ;
.byte $00, $00        ; 92 ;
.byte $00, $00        ; 93 ;
.byte $00, $00        ; 94 ;
.byte $00, $00        ; 95 ;
.byte $00, $00        ; 96 ;
.byte $00, $00        ; 97 ;
.byte $00, $00        ; 98 ;
.byte $00, $00        ; 99 ;
.byte $00, $00        ; 9A ;
.byte $00, $00        ; 9B ;
.byte $00, $00        ; 9C ;
.byte $00, $00        ; 9D ;
.byte $00, $00        ; 9E ;
.byte $00, $00        ; 9F ;
.byte $00, $00        ; A0 ;
.byte $00, $00        ; A1 ;
.byte $00, $00        ; A2 ;
.byte $00, $00        ; A3 ;
.byte $00, $00        ; A4 ;
.byte $00, $00        ; A5 ;
.byte $00, $00        ; A6 ;
.byte $00, $00        ; A7 ;
.byte $00, $00        ; A8 ;
.byte $00, $00        ; A9 ;
.byte $00, $00        ; AA ;
.byte $00, $00        ; AB ;
.byte $00, $00        ; AC ;
.byte $00, $00        ; AD ;
.byte $00, $00        ; AE ;
.byte $00, $00        ; AF ;
.byte $00, $00        ; B0 ;
.byte $00, $00        ; B1 ;
.byte $00, $00        ; B2 ;
.byte $00, $00        ; B3 ;
.byte $00, $00        ; B4 ;
.byte $00, $00        ; B5 ;
.byte $00, $00        ; B6 ;
.byte $00, $00        ; B7 ;
.byte $00, $00        ; B8 ;
.byte $00, $00        ; B9 ;
.byte $00, $00        ; BA ;
.byte $00, $00        ; BB ;
.byte $00, $00        ; BC ;
.byte $00, $00        ; BD ;
.byte $00, $00        ; BE ;
.byte $00, $00        ; BF ;
.byte $00, $00        ; C0 ;
.byte $00, $00        ; C1 ;
.byte $00, $00        ; C2 ;
.byte $00, $00        ; C3 ;
.byte $00, $00        ; C4 ;
.byte $00, $00        ; C5 ;
.byte $00, $00        ; C6 ;
.byte $00, $00        ; C7 ;
.byte $00, $00        ; C8 ;
.byte $00, $00        ; C9 ;
.byte $00, $00        ; CA ;
.byte $00, $00        ; CB ;
.byte $00, $00        ; CC ;
.byte $00, $00        ; CD ;
.byte $00, $00        ; CE ;
.byte $00, $00        ; CF ;
.byte $00, $00        ; D0 ;
.byte $00, $00        ; D1 ;
.byte $00, $00        ; D2 ;
.byte $00, $00        ; D3 ;
.byte $00, $00        ; D4 ;
.byte $00, $00        ; D5 ;
.byte $00, $00        ; D6 ;
.byte $00, $00        ; D7 ;
.byte $00, $00        ; D8 ;
.byte $00, $00        ; D9 ;
.byte $00, $00        ; DA ;
.byte $00, $00        ; DB ;
.byte $00, $00        ; DC ;
.byte $00, $00        ; DD ;
.byte $00, $00        ; DE ;
.byte $00, $00        ; DF ;
.byte $00, $00        ; E0 ;
.byte $00, $00        ; E1 ;
.byte $00, $00        ; E2 ;
.byte $00, $00        ; E3 ;
.byte $00, $00        ; E4 ;
.byte $00, $00        ; E5 ;
.byte $00, $00        ; E6 ;
.byte $00, $00        ; E7 ;
.byte $00, $00        ; E8 ;
.byte $00, $00        ; E9 ;
.byte $00, $00        ; EA ;
.byte $00, $00        ; EB ;
.byte $00, $00        ; EC ;
.byte $00, $00        ; ED ;
.byte $00, $00        ; EE ;
.byte $00, $00        ; EF ;
.byte $00, $00        ; F0 ;
.byte $00, $00        ; F1 ;
.byte $00, $00        ; F2 ;
.byte $00, $00        ; F3 ;
.byte $00, $00        ; F4 ;
.byte $00, $00        ; F5 ;
.byte $00, $00        ; F6 ;
.byte $00, $00        ; F7 ;
.byte $00, $00        ; F8 ;
.byte $00, $00        ; F9 ;
.byte $00, $00        ; FA ;
.byte $00, $00        ; FB ;
.byte $00, $00        ; FC ;
.byte $00, $00        ; FD ;
.byte $00, $00        ; FE ;
.byte $00, $00        ; FF ;



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;                                                   ;;;;;;;;;;;;;;;;;;;; 
;;;;;;;;;;;;;;;;;              MENU TEXT FROM BANK 0E               ;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;                                                   ;;;;;;;;;;;;;;;;;;;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  LUT for menu text  [$8500 :: 0x38510]
;;
;;    This is a table of complex strings used in menus.

;; A few things were edited to fit the new menu layouts.

lut_MenuText:                 
.word M_Gold                  ; 0  ; 0 
.word M_Options               ; 1  ; 1 
.word M_ItemTitle             ; 2  ; 2 
.word M_QuestItemsTitle       ; 3  ; 3 
.word M_EquipPage1            ; 4  ; 4 
.word M_EquipPage2            ; 5  ; 5 
.word M_EquipPage3            ; 6  ; 6 
.word M_Char1Name             ; 7  ; 7 
.word M_Char2Name             ; 8  ; 8 
.word M_Char3Name             ; 9  ; 9 
.word M_Char4Name             ; A  ; 10
.word M_EquipNameClass        ; B  ; 11
.word M_EquipmentSlots        ; C  ; 12
.word M_EquipStats            ; D  ; 13
.word M_MP_List_Level         ; E  ; 14
.word M_MP_List_MP            ; F  ; 15
.word M_Elixir_List_MP        ; 10 ; 16
.word M_HP_List               ; 11 ; 17
.word M_MagicList             ; 12 ; 18
.word M_CharLevelStats        ; 13 ; 19
.word M_CharMainStats         ; 14 ; 20
.word M_CharSubStats          ; 15 ; 21
.word M_ItemNothing           ; 16 ; 22
.word M_KeyItem1_Desc         ; 17 ; 23 ; Lute
.word M_KeyItem2_Desc         ; 18 ; 24 ; Crown
.word M_KeyItem3_Desc         ; 19 ; 25 ; Crystal
.word M_KeyItem4_Desc         ; 1A ; 26 ; Herb
.word M_KeyItem5_Desc         ; 1B ; 27 ; Mystic Key
.word M_KeyItem6_Desc         ; 1C ; 28 ; TNT
.word M_KeyItem7_Desc         ; 1D ; 29 ; Adamant
.word M_KeyItem8_Desc         ; 1E ; 30 ; Slab
.word M_KeyItem9_Desc         ; 1F ; 31 ; Ruby
.word M_KeyItem10_Desc        ; 20 ; 32 ; Rod
.word M_KeyItem11_Desc        ; 21 ; 33 ; Floater
.word M_KeyItem12_Desc        ; 22 ; 34 ; Chime
.word M_KeyItem13_Desc        ; 23 ; 35 ; Tail
.word M_KeyItem14_Desc        ; 24 ; 36 ; Cube
.word M_KeyItem15_Desc        ; 25 ; 37 ; Bottle
.word M_KeyItem16_Desc        ; 26 ; 38 ; Oxyale
.word M_KeyItem17_Desc        ; 27 ; 39 ; Canoe
.word M_KeyItem1_Use          ; 28 ; 40 ; Lute use
.word M_KeyItem10_Use         ; 29 ; 41 ; Rod use
.word M_KeyItem11_Use         ; 2A ; 42 ; Floater use
.word M_KeyItem15_Use         ; 2B ; 43 ; Bottle use
.word M_ItemHeal              ; 2C ; 44 ; CURE magic
.word M_ItemEther             ; 2D ; 45
.word M_ItemElixir            ; 2E ; 46 
.word M_ItemPure              ; 2F ; 47 ; PURE magic
.word M_ItemSoft              ; 30 ; 48 ; SOFT magic
.word M_ItemPhoenixDown       ; 31 ; 49 ; LIFE magic
.word M_ItemAlarmClock        ; 32 ; 50
.word M_ItemEyedrop           ; 33 ; 51
.word M_ItemSmokebomb         ; 34 ; 52
.word M_ItemUseTentCabin      ; 35 ; 53 ; HEAL magic
.word M_ItemUseTentCabin_Save ; 36 ; 54
.word M_ItemUseHouse_Save     ; 37 ; 55
.word M_ItemUseHouse          ; 38 ; 56
.word M_ItemCannotSleep       ; 39 ; 57
.word M_NowSaving             ; 3A ; 58
.word M_ItemCannotUse         ; 3B ; 59
.word M_HealMagic             ; 3C ; 60 ; unused
.word M_WarpMagic             ; 3D ; 61
.word M_ExitMagic             ; 3E ; 62
.word M_NoMana                ; 3F ; 63
.word M_CannotUseMagic        ; 40 ; 64
.word M_OrbGoldBoxLink        ; 41 ; 65
.word M_ItemSubmenu           ; 42 ; 66
.word M_MagicSubmenu          ; 43 ; 67
.word M_MagicCantLearn        ; 44 ; 68
.word M_MagicAlreadyKnow      ; 45 ; 69
.word M_MagicLevelFull        ; 46 ; 70
.word M_MagicForget           ; 47 ; 71
.word M_MagicMenuSpellLevel12 ; 48 ; 72
.word M_MagicMenuSpellLevel34 ; 49 ; 73
.word M_MagicMenuSpellLevel56 ; 4A ; 74
.word M_MagicMenuSpellLevel78 ; 4B ; 75
.word M_MagicMenuOrbs         ; 4C ; 76
.word M_MagicNameLearned      ; 4D ; 77
.word M_EquipPage4            ; 4E ; 78 ; don't feel like re-formatting all the codes again... New stuff is unorganized here.
.word M_FixInventoryWindow    ; 4F ; 79 ; 
.word M_MagicMenuMPTitle      ; 50 ; 80 ; MP in magic menu title
.word M_EquipStats_Blank      ; 51 ; 81 ; 
.word M_EquipInventoryWeapon  ; 52 ; 82 ; 
.word M_EquipInventoryArmor   ; 53 ; 83 ; 
.word M_EquipInventorySelect  ; 54 ; 84 ; 
.word M_KeyItem18_Desc        ; 55 ; 85 ; 
.word M_LampMagic             ; 56 ; 86 ; LAMP magic
.word M_EquipInventoryClear   ; 57 ; 87 ; 

M_Gold: 
.byte $04,$FF,$90,$00 ; _G - for gold on menu

M_Options:
.byte $92,$9D,$8E,$96,$9C,$01 ; ITEMS 
.byte $96,$8A,$90,$92,$8C,$01 ; MAGIC
.byte $8E,$9A,$9E,$92,$99,$01 ; EQUIP
.byte $CA,$CB,$CC,$CD,$CE,$01 ; STATUS
.byte $CF,$D0,$D1,$D2,$97,$01 ; OPTION
.byte $9C,$8A,$9F,$8E,$E8,$00 ; SAVE (Heart)

M_ItemTitle: 
.BYTE $FF,$92,$9D,$8E,$96,$9C,$00 ; ITEMS

M_QuestItemsTitle: 
.BYTE $FF,$9A,$9E,$8E,$9C,$9D,$00 ; QUEST

M_EquipPage1:  
.byte $FF,$FF,$8E,$B4,$B8,$AC,$B3,$34,$B1,$21,$8B,$A4,$47,$81,$FF,$C7,$00

M_EquipPage2:   
.byte $C1,$FF,$8E,$B4,$B8,$AC,$B3,$34,$B1,$21,$8B,$A4,$47,$82,$FF,$C7,$00

M_EquipPage3:
.byte $C1,$FF,$8E,$B4,$B8,$AC,$B3,$34,$B1,$21,$8B,$A4,$47,$83,$FF,$C7,$00

M_EquipPage4:
.byte $C1,$FF,$8E,$B4,$B8,$AC,$B3,$34,$B1,$21,$8B,$A4,$47,$84,$00

M_Char1Name:   
.byte $10,$00,$00 ; Character 1's name

M_Char2Name:   
.byte $11,$00,$00 ; Character 2's name

M_Char3Name:  
.byte $12,$00,$00 ; Character 3's name

M_Char4Name:   
.byte $13,$00,$00 ; Character 4's name

M_EquipNameClass:  
.byte $10,$00,$09,$08,$10,$01,$00 ; name, 8 spaces, then class

M_EquipmentSlots:
.byte $9B,$AC,$AA,$AB,$21,$91,$22,$A7,$FF,$FF,$C8,$09,$08,$C9,$FF,$D4,$01   ; RIGHT_HAND__[________]_*
.byte $95,$A8,$A9,$21,$FF,$91,$22,$A7,$FF,$FF,$C8,$09,$08,$C9,$FF,$DB,$01   ; LEFT__HAND__[________]_*
.byte $91,$2B,$A7,$09,$08,$C8,$09,$08,$C9,$FF,$DC,$01                       ; HEAD________[________]_*
.byte $8B,$B2,$A7,$BC,$09,$08,$C8,$09,$08,$C9,$FF,$DA,$01                   ; BODY________[________]_*
.byte $91,$22,$A7,$B6,$09,$07,$C8,$09,$08,$C9,$FF,$DD,$01                   ; HANDS_______[________]_*
.byte $8A,$A6,$48,$B6,$B6,$35,$BC,$09,$03,$C8,$09,$08,$C9,$FF,$DE,$01       ; ACCESSORY___[________]_*
.byte $8B,$39,$B7,$45,$FF,$92,$53,$B0,$FF,$C8,$09,$08,$C9,$FF,$D8,$01       ; BATTLE_ITEM_[________]_*
.byte $8B,$39,$B7,$45,$FF,$92,$53,$B0,$FF,$C8,$09,$08,$C9,$FF,$D8,$00       ; BATTLE_ITEM_[________]_*

M_EquipStats:
.byte $8D,$A4,$B0,$A4,$66,$09,$03,        $10,$16,$FF,$FF      ; Damage___##__
.byte $8D,$A8,$A9,$3A,$3E,$FF,$FF,        $10,$18,$01          ; Defense__##
.byte $8A,$A6,$A6,$55,$5E,$4B,            $10,$17,$FF,$FF      ; Accuracy_##__
.byte $8E,$B9,$3F,$AC,$3C,$FF,$FF,        $10,$19,$01          ; Evasion__##
.byte $8C,$5C,$57,$51,$AF,$FF,            $10,$1B,$FF,$FF      ; Critical_##__
.byte $96,$C0,$8E,$B9,$A4,$A7,$A8,$FF,$FF,$10,$1A,$00          ; M.Evade__## 

M_MP_List_Level:  
.byte $95,$81,$01
.byte $95,$82,$01
.byte $95,$83,$01
.byte $95,$84,$01
.byte $95,$85,$01
.byte $95,$86,$01
.byte $95,$87,$01
.byte $95,$88,$00

M_MP_List_MP:
.byte $10,$20,$7A,$10,$30,$01 ; lists current MP / max MP veritcally
.byte $10,$21,$7A,$10,$31,$01
.byte $10,$22,$7A,$10,$32,$01
.byte $10,$23,$7A,$10,$33,$01
.byte $10,$24,$7A,$10,$34,$01
.byte $10,$25,$7A,$10,$35,$01
.byte $10,$26,$7A,$10,$36,$01
.byte $10,$27,$7A,$10,$37,$00

M_Elixir_List_MP: ; lists current MP / current MP / etc, horizontally
.byte $96,$99,$FF,$FF,$10,$20,$7A,$10,$21,$7A,$10,$22,$7A,$10,$23,$7A,$10,$24,$7A,$10,$25,$7A,$10,$26,$7A,$10,$27,$00

M_HP_List: 
.byte $10,$00,$FF,$10,$02,$FF,$10,$05,$7A,$10,$06,$00 ; lists name, ailment, and current HP horizontally

M_MagicList: 
.byte $95,$81,$FF,$FF,$10,$40,$FF,$FF,$10,$41,$FF,$FF,$10,$42,$01
.byte $95,$82,$FF,$FF,$10,$43,$FF,$FF,$10,$44,$FF,$FF,$10,$45,$01
.byte $95,$83,$FF,$FF,$10,$46,$FF,$FF,$10,$47,$FF,$FF,$10,$48,$01
.byte $95,$84,$FF,$FF,$10,$49,$FF,$FF,$10,$4A,$FF,$FF,$10,$4B,$01
.byte $95,$85,$FF,$FF,$10,$4C,$FF,$FF,$10,$4D,$FF,$FF,$10,$4E,$01
.byte $95,$86,$FF,$FF,$10,$4F,$FF,$FF,$10,$50,$FF,$FF,$10,$51,$01
.byte $95,$87,$FF,$FF,$10,$52,$FF,$FF,$10,$53,$FF,$FF,$10,$54,$01
.byte $95,$88,$FF,$FF,$10,$55,$FF,$FF,$10,$56,$FF,$FF,$10,$57,$00

;     |L  #    __ cc  MP   /  max MP   __  __ spel1 1  __ spell 2  __ spell 3 
;.byte $7E,$81,$FF,$10,$2C,$7A,$10,$34,$FF,$FF,$10,$14,$FF,$10,$15,$FF,$10,$16,$01
;.byte $7E,$82,$FF,$10,$2D,$7A,$10,$35,$FF,$FF,$10,$17,$FF,$10,$18,$FF,$10,$19,$01
;.byte $7E,$83,$FF,$10,$2E,$7A,$10,$36,$FF,$FF,$10,$1A,$FF,$10,$1B,$FF,$10,$1C,$01
;.byte $7E,$84,$FF,$10,$2F,$7A,$10,$37,$FF,$FF,$10,$1D,$FF,$10,$1E,$FF,$10,$1F,$01
;.byte $7E,$85,$FF,$10,$30,$7A,$10,$38,$FF,$FF,$10,$20,$FF,$10,$21,$FF,$10,$22,$01
;.byte $7E,$86,$FF,$10,$31,$7A,$10,$39,$FF,$FF,$10,$23,$FF,$10,$24,$FF,$10,$25,$01
;.byte $7E,$87,$FF,$10,$32,$7A,$10,$3A,$FF,$FF,$10,$26,$FF,$10,$27,$FF,$10,$28,$01
;.byte $7E,$88,$FF,$10,$33,$7A,$10,$3B,$FF,$FF,$10,$29,$FF,$10,$2A,$FF,$10,$2B,$00

M_CharLevelStats: 
.byte $10,$00,$01                                     ; NAME
.byte $10,$01,$01                                     ; Class
.byte $95,$A8,$32,$AF,$09,$05,$10,$03,$01             ; Level ##
.byte $8E,$BB,$B3,$C0,$FF,$FF,$10,$04,$01             ; Exp.  ## 
.byte $97,$A8,$BB,$B7,$09,$03,$10,$1E,$00             ; Next  ##

M_CharMainStats: 
.byte $9C,$B7,$23,$2A,$1C,$FF,$FF,$10,$11,$09,$04,  $8D,$A4,$B0,$A4,$66,$09,$03,        $10,$16,$01 ; Strength__##____Damage___###
.byte $8A,$AA,$61,$5B,$4B,$FF,$FF,$10,$12,$09,$04,  $8A,$A6,$A6,$55,$5E,$4B,            $10,$17,$01 ; Agility___##____Accuracy_###
.byte $92,$B1,$53,$4E,$A8,$A6,$21,$10,$13,$09,$04,  $8C,$5C,$57,$51,$AF,$FF,            $10,$1B,$01 ; Intellect_##____Critical_###
.byte $9F,$5B,$5F,$5B,$4B,$FF,    $10,$14,$09,$04,  $8D,$A8,$A9,$3A,$3E,$FF,$FF,        $10,$18,$01 ; Vitality__##____Defense__###
.byte $9C,$B3,$A8,$40,$09,$05,    $10,$15,$09,$04,  $8E,$B9,$3F,$AC,$3C,$FF,$FF,        $10,$19,$01 ; Speed_____##____Evasion__###
.byte $96,$35,$A4,$45,$09,$03,    $10,$1C,$09,$04,  $96,$C0,$8E,$B9,$A4,$A7,$A8,$FF,$FF,$10,$1A,$00 ; Morale___###____M.Evade__###

;.byte $9C,$B7,$23,$2A,$1C,$FF,$FF,$10,$07,$01         ; Strength__ 
;.byte $8A,$AA,$61,$5B,$4B,$FF,$FF,$10,$08,$01         ; Agility___  
;.byte $92,$B1,$53,$4E,$A8,$A6,$21,$10,$09,$01         ; Intellect_
;.byte $9F,$5B,$5F,$5B,$4B,$FF,$10,$0A,$01             ; Vitality__
;.byte $9C,$B3,$A8,$40,$09,$05,$10,$0B,$01             ; Speed_____    
;.byte $9C,$B3,$AC,$5C,$21,$FF,$FF,$00                 ; Spirit___
;
M_CharSubStats: 
;.byte $8D,$A4,$B0,$A4,$66,$09,$03,$10,$3C,$01         ; Damage___###
;.byte $8A,$A6,$A6,$55,$5E,$4B,$10,$3D,$01             ; Accuracy_###
;.byte $8C,$5C,$57,$51,$AF,$FF,$10,$44,$01             ; Critical_###
;.byte $8D,$A8,$A9,$3A,$3E,$FF,$FF,$10,$3E,$01         ; Defense__###
;.byte $8E,$B9,$3F,$AC,$3C,$FF,$FF,$10,$3F,$01         ; Evasion__###
;.byte $96,$C0,$8E,$B9,$A4,$A7,$A8,$FF,$FF,$10,$41,$00 ; M.Evade__###

M_ItemNothing:
.byte $A2,$B2,$64,$41,$B9,$1A,$B1,$B2,$1C,$1F,$AA,$C0,$00 ; You have nothing.

M_KeyItem1_Desc: 
.byte $8B,$A8,$A4,$B8,$57,$A9,$B8,$AF,$42,$B8,$B6,$AC,$A6,$43,$AC,$4E,$B6,$05
.byte $B7,$AB,$1A,$A4,$AC,$B5,$C0,$00 ; Beautiful music fills[enter]the air.

M_KeyItem2_Desc: 
.byte $9D,$AB,$1A,$B6,$28,$45,$29,$8C,$9B,$98,$A0,$97,$C0,$00 ; The stolen CROWN.

M_KeyItem3_Desc:
.byte $8A,$FF,$A5,$A4,$4E,$42,$A4,$A7,$1A,$4C,$FF,$8C,$9B,$A2,$9C,$9D,$8A,$95,$C0,$00 ; A ball made of CRYSTAL.

M_KeyItem4_Desc: 
.byte $A2,$B8,$A6,$AE,$C4,$FF,$9D,$3D,$1E,$34,$A7,$AC,$A6,$1F,$A8,$05
.byte $AC,$B6,$1B,$B2,$2E,$A5,$5B,$B7,$25,$C4,$00 ; Yuck! This medicine[enter]is too bitter!

M_KeyItem5_Desc:
.byte $9D,$AB,$1A,$B0,$BC,$37,$AC,$A6,$FF,$94,$8E,$A2,$C0,$00 ; The mystic KEY.

M_KeyItem6_Desc: 
.byte $8B,$A8,$38,$A4,$23,$A9,$B8,$AF,$C4,$00 ; Be careful!

M_KeyItem7_Desc:  
.byte $9D,$AB,$1A,$45,$AA,$3A,$A7,$2F,$4B,$34,$B7,$5F,$C0,$00 ; The legendary metal.

M_KeyItem8_Desc:  
.byte $9E,$B1,$AE,$B1,$46,$B1,$24,$BC,$B0,$A5,$B2,$AF,$1E,$A6,$B2,$B9,$25,$05
.byte $B7,$AB,$1A,$9C,$95,$8A,$8B,$C0,$00 ; Unknown symbols cover[enter]the SLAB.

M_KeyItem9_Desc:  
.byte $8A,$FF,$AF,$2F,$AA,$1A,$23,$A7,$24,$28,$5A,$C0,$00 ; A large red stone.

M_KeyItem10_Desc:  
.byte $9D,$AB,$1A,$9B,$98,$8D,$1B,$2E,$23,$B0,$B2,$B9,$1A,$1C,$A8,$05
.byte $B3,$AF,$39,$1A,$A9,$B5,$49,$1B,$AB,$1A,$2B,$B5,$1C,$C0,$00 ; The ROD to remove the[enter]plate from the earth.

M_KeyItem11_Desc: 
.byte $8A,$FF,$B0,$BC,$37,$25,$AC,$26,$1E,$4D,$A6,$AE,$C0,$00 ; A mysterious rock.

M_KeyItem12_Desc: 
.byte $9C,$B7,$A4,$B0,$B3,$A8,$27,$3C,$1B,$AB,$1A,$A5,$B2,$B7,$28,$B0,$69,$05
.byte $96,$8A,$8D,$8E,$FF,$92,$97,$FF,$95,$8E,$8F,$8E,$92,$97,$00 ; Stamped on the bottom..[enter]MADE IN LEFEIN. 

M_KeyItem13_Desc: 
.byte $98,$98,$91,$91,$C4,$C4,$FF,$92,$21,$37,$1F,$AE,$B6,$C4,$05
.byte $9D,$AB,$B5,$46,$2D,$21,$B2,$B9,$25,$69,$05
.byte $97,$B2,$C4,$FF,$8D,$3C,$BE,$21,$A7,$B2,$1B,$AB,$39,$C4,$C4,$00 ; OOHH!! It stinks![enter]Throw it over..[enter]No! Don't do that!!

M_KeyItem14_Desc:
.byte $8C,$B2,$AF,$35,$1E,$AA,$A4,$1C,$25,$20,$3B,$05
.byte $B6,$BA,$AC,$B5,$58,$1F,$1B,$AB,$1A,$8C,$9E,$8B,$8E,$C0,$00 ; Colors gather and[enter]swirl in the CUBE.

M_KeyItem15_Desc: 
;.byte $92,$B7,$2D,$1E,$A8,$B0,$B3,$B7,$BC,$C0,$00 ; It is empty.

M_KeyItem16_Desc:
.byte $9D,$AB,$1A,$98,$A1,$A2,$8A,$95,$8E,$43,$55,$B1,$30,$1D,$B6,$05
.byte $A9,$B5,$2C,$AB,$20,$AC,$B5,$C0,$00 ; The OXYALE furnishes[enter]fresh air. 

M_KeyItem17_Desc: 
.byte $A2,$B2,$B8,$38,$22,$FF,$A6,$4D,$B6,$B6,$1B,$AB,$1A,$5C,$B9,$25,$C0,$00 ; You can cross the river.

M_KeyItem18_Desc:
.byte $C6,$9D,$1D,$23,$BE,$1E,$B1,$2E,$B3,$AC,$A6,$B7,$55,$2C,$C5,$C4,$BE,$05
.byte $C6,$9E,$3E,$50,$26,$44,$AC,$B0,$A4,$AA,$1F,$39,$AC,$3C,$C4,$BE,$05
.byte $C6,$8A,$BA,$BF,$1B,$41,$B7,$BE,$1E,$A5,$35,$1F,$AA,$C4,$BE,$00

M_KeyItem1_Use:
.byte $9D,$AB,$1A,$B7,$B8,$B1,$1A,$B3,$AF,$A4,$BC,$B6,$BF,$05
.byte $B5,$A8,$B9,$2B,$AF,$1F,$AA,$20,$24,$B7,$A4,$AC,$B5,$5D,$BC,$C0,$00 ; The tune plays,[enter]revealing a stairway.

M_KeyItem10_Use: 
.byte $9D,$AB,$1A,$B3,$AF,$39,$1A,$B6,$AB,$39,$B7,$25,$B6,$BF,$05
.byte $B5,$A8,$B9,$2B,$AF,$1F,$AA,$20,$24,$B7,$A4,$AC,$B5,$5D,$BC,$C4,$00 ; The plate shatters,[enter]revealing a stairway!

M_KeyItem11_Use: 
.byte $9D,$AB,$1A,$8A,$92,$9B,$9C,$91,$92,$99,$31,$A8,$AA,$1F,$B6,$1B,$B2,$05
.byte $B5,$AC,$B6,$1A,$A9,$B5,$49,$1B,$AB,$1A,$A7,$2C,$25,$B7,$C0,$00 ; The AIRSHIP begins to[enter]rise from the desert.

M_KeyItem15_Use: 
.byte $99,$B2,$B3,$C4,$FF,$8A,$43,$A4,$AC,$B5,$BC,$20,$B3,$B3,$2B,$63,$BF,$05
.byte $B7,$AB,$A8,$29,$AC,$1E,$AA,$3C,$A8,$C0,$00 ; Pop! A fairy appears,[enter]then is gone.

M_ItemHeal:  
M_CureMagic:
.byte $9E,$3E,$1B,$2E,$23,$A6,$B2,$32,$44,$91,$99,$C0,$00 ; Use to recover HP.[END]

M_ItemEther:
.byte $9E,$3E,$1B,$2E,$23,$A6,$B2,$32,$44,$96,$99,$05
.byte $A9,$35,$36,$5A,$24,$B3,$A8,$4E,$65,$A8,$32,$AF,$C0,$00 ; Use to recover MP[ENTER]for one spell level.[END]

M_ItemElixir:
.byte $9E,$3E,$1B,$2E,$23,$A6,$B2,$32,$44,$5F,$58,$91,$99,$20,$3B,$FF,$96,$99,$C0,$00 ; Use to recover all HP and MP.[END]

M_ItemPure:  
M_PureMagic:
.byte $9E,$3E,$1B,$2E,$A6,$55,$1A,$B3,$B2,$30,$3C,$C0,$00 ; Use to cure poison.[END]

M_ItemSoft:  
M_SoftMagic:
.byte $9E,$3E,$1B,$2E,$23,$37,$35,$1A,$1C,$A8,$05
.byte $A5,$B2,$A7,$4B,$A9,$4D,$B0,$4F,$A8,$B7,$5C,$A9,$AC,$51,$57,$3C,$C0,$00 ; Use to restore the[ENTER]body from petrification.[END]

M_ItemPhoenixDown:
M_LifeMagic:
.byte $9E,$3E,$1B,$2E,$23,$B9,$AC,$32,$1B,$1D,$24,$B3,$AC,$5C,$B7,$C0,$00 ; Use to revive the spirit.[END]

M_ItemAlarmClock:
.byte $9E,$3E,$1B,$2E,$4D,$B8,$3E,$1B,$1D,$4F,$2F,$B7,$BC,$05
.byte $A9,$4D,$B0,$24,$45,$A8,$B3,$2D,$29,$A5,$39,$B7,$45,$C0,$00 ; Use to rouse the party[ENTER]from sleep in battle.[END]

M_ItemEyedrop:
.byte $9E,$3E,$1B,$2E,$23,$AA,$A4,$1F,$FF,$B6,$AC,$AA,$AB,$B7,$C0,$00 ; Use to regain sight.[END]

M_ItemSmokebomb:
.byte $9E,$3E,$1B,$2E,$3D,$A7,$1A,$A8,$32,$B5,$56,$5A,$2D,$29,$A5,$39,$B7,$45,$05
.byte $B2,$44,$A8,$AF,$B8,$A7,$1A,$3A,$A8,$B0,$AC,$2C,$2D,$29,$A7,$B8,$2A,$A8,$3C,$B6,$C0,$05 ; Use to hide everyone in battle,[ENTER]Or elude enemies in dungeons.[END]
.byte $9E,$3E,$FF,$AC,$B7,$C5,$FF,$99,$B8,$B6,$AB,$FF,$8A,$69,$A2,$8E,$9C,$FF,$99,$B8,$B6,$AB,$FF,$8B,$69,$97,$98,$00 ; Use it? Push A..YES Push B..NO

M_ItemUseTentCabin:
.byte $9B,$A8,$A6,$B2,$32,$44,$91,$99,$43,$35,$20,$4E,$C5,$05
.byte $99,$B8,$B6,$AB,$FF,$8A,$69,$A2,$8E,$9C,$05
.byte $99,$B8,$B6,$AB,$FF,$8B,$69,$97,$98,$00; Recover HP for all?[ENTER]Push A..YES[ENTER]Push B..NO[END]

M_ItemUseTentCabin_Save:
.byte $91,$99,$FF,$23,$A6,$B2,$32,$23,$A7,$C0,$FF,$9C,$A4,$32,$C5,$05
.byte $99,$B8,$B6,$AB,$FF,$8A,$69,$A2,$8E,$9C,$05
.byte $99,$B8,$B6,$AB,$FF,$8B,$69,$97,$98,$00 ; HP recovered. SAVE?[enter]Push A..YES[enter]Push B..NO

M_ItemUseHouse_Save:
.byte $91,$99,$20,$3B,$FF,$96,$99,$FF,$23,$A6,$B2,$32,$23,$A7,$C0,$FF,$9C,$A4,$32,$C5,$05
.byte $99,$B8,$B6,$AB,$FF,$8A,$69,$A2,$8E,$9C,$05
.byte $99,$B8,$B6,$AB,$FF,$8B,$69,$97,$98,$00 ; HP and MP recovered. Save?[ENTER]Push A..YES[ENTER]Push B..NO[END]

M_ItemUseHouse:  
.byte $9B,$A8,$A6,$B2,$32,$44,$91,$99,$20,$3B,$FF,$96,$99,$43,$35,$20,$4E,$C5,$05
.byte $99,$B8,$B6,$AB,$FF,$8A,$69,$A2,$8E,$9C,$05
.byte $99,$B8,$B6,$AB,$FF,$8B,$69,$97,$98,$00 ; Recover HP and MP for all?[ENTER]Push A..YES[ENTER]Push B..NO[END]

M_ItemCannotSleep:  
.byte $A2,$B2,$B8,$38,$22,$B1,$B2,$21,$B6,$45,$A8,$B3,$FF,$1D,$23,$C4,$00 ; You cannot sleep here!

M_NowSaving:   
.byte $97,$B2,$BA,$24,$A4,$B9,$1F,$AA,$69,$C4,$00 ; Now saving...! 

M_ItemCannotUse: 
.byte $A2,$B2,$B8,$38,$22,$B1,$B2,$21,$B8,$B6,$1A,$AC,$21,$1D,$23,$C4,$00 ; You cannot use it here!

M_HealMagic:   ; unused

M_WarpMagic:  
.byte $8A,$FF,$B0,$A4,$AA,$AC,$A6,$1B,$2E,$23,$B7,$55,$29,$3C,$A8,$05
.byte $A9,$AF,$B2,$35,$C0,$FF,$97,$46,$33,$2F,$B3,$31,$5E,$AE,$C4,$00 ; A magic to return one[enter]floor. Now warp back!

M_ExitMagic:  
.byte $95,$B2,$37,$C5,$FF,$97,$2E,$5D,$4B,$26,$B7,$C5,$05
.byte $92,$B6,$2D,$21,$AB,$B2,$B3,$A8,$AF,$2C,$B6,$C5,$FF,$9E,$B6,$1A,$1C,$30,$05
.byte $B6,$B3,$A8,$4E,$1B,$2E,$A8,$BB,$5B,$C4,$00 ; Lost? No way out?[return]Is it hopeless? Use this[return]spell to exit!

M_NoMana:  
.byte $8A,$AF,$AF,$36,$A9,$1B,$41,$21,$45,$32,$AF,$BE,$B6,$05
.byte $B6,$B3,$A8,$4E,$1E,$2F,$1A,$A8,$BB,$41,$B8,$37,$40,$C0,$00 ; All of that level's[enter]spells are exhausted.

M_CannotUseMagic:  
.byte $9C,$B2,$B5,$B5,$BC,$BF,$50,$26,$38,$22,$B1,$B2,$21,$B8,$3E,$05
.byte $B7,$AB,$A4,$21,$B6,$B3,$A8,$4E,$FF,$1D,$23,$C0,$00 ; Sorry, you cannot use[enter]that spell here.

M_OrbGoldBoxLink: ; JIGS - to smooth out the weird orb box shape and timer box...
.byte $6C,$7D,$7D,$7D,$7D,$7D,$7D,$7D,$7D,$6D,$01
.byte $7B,$7E,$7E,$7E,$7E,$7E,$7E,$7E,$7E,$7C,$01,$01,$01,$01,$01,$01,$01
.byte $6C,$7D,$7D,$7D,$7D,$7D,$7D,$7D,$7D,$6D,$00

M_ItemSubmenu:
.byte $FF,$FF,$9E,$3E,$09,$03,$9A,$B8,$2C,$B7,$FF,$92,$B7,$A8,$B0,$B6,$00 ; __ Use ___ Quest Items

M_MagicSubmenu: 
.byte $FF,$FF,$8C,$3F,$21,$FF,$95,$2B,$B5,$29,$FF,$8F,$35,$66,$B7,$00 ; Cast __ Learn __ Forget

M_MagicCantLearn:      
.byte $A2,$26,$38,$22,$B1,$B2,$21,$45,$2F,$29,$1C,$39,$24,$B3,$A8,$4E,$C0,$00 ; You cannot learn that spell.[END]

M_MagicAlreadyKnow:     
.byte $A2,$26,$20,$AF,$23,$A4,$A7,$4B,$AE,$B1,$46,$1B,$41,$21,$B6,$B3,$A8,$4E,$C0,$00 ; You already know that spell.[END]

M_MagicLevelFull:       
.byte $A2,$26,$38,$22,$B1,$B2,$21,$45,$2F,$29,$22,$4B,$B0,$35,$A8,$05
.byte $B6,$B3,$A8,$4E,$1E,$A9,$35,$1B,$3D,$1E,$B6,$B3,$A8,$4E,$65,$A8,$32,$AF,$C4,$00 ; You cannot learn any more[ENTER]spells for this spell level![END]

M_MagicForget:
.byte $8F,$35,$66,$21,$1C,$30,$24,$B3,$A8,$4E,$C5,$00

M_MagicMenuSpellLevel12:
.byte $FF,$FF,$9C,$B3,$A8,$4E,$FF,$95,$A8,$32,$58,$81,$C2,$82,$FF,$C7,$00

M_MagicMenuSpellLevel34:
.byte $C1,$FF,$9C,$B3,$A8,$4E,$FF,$95,$A8,$32,$58,$83,$C2,$84,$FF,$C7,$00

M_MagicMenuSpellLevel56:
.byte $C1,$FF,$9C,$B3,$A8,$4E,$FF,$95,$A8,$32,$58,$85,$C2,$86,$FF,$C7,$00

M_MagicMenuSpellLevel78:
.byte $C1,$FF,$9C,$B3,$A8,$4E,$FF,$95,$A8,$32,$58,$87,$C2,$88,$00

M_MagicMenuOrbs:
.byte $E5,$01,$E5,$01,$E5,$01,$E5,$01,$E6,$01,$E6,$01,$E6,$01,$E6,$00

M_MagicNameLearned:
.byte $FF,$10,$60,$65,$2B,$B5,$5A,$27,$1C,$1A,$B6,$B3,$A8,$4E,$C4,$00 ; [name] learned the spell! (uses variable width name stat code!)

M_FixInventoryWindow:
;.byte $7B,$0B,$07,$7E,$6A,$6B,$0B,$15,$7E,$7C    ; connect name and submenu title boxes
;.byte $01,$01,$01,$01,$01,$01,$01,$01,$05        ; line break to the bottom...
;.byte $7B,$0B,$1E,$7E,$7C,$00                    ; and connect the stat window

M_MagicMenuMPTitle:
;      0    1   2   3   4   5   6   7   8   9   A   B   C   D   E   F  10  11  12  13
.byte $95,$A8,$B9,$A8,$AF,$FF,$FF,$FF,$96,$99,$FF,$C3,$C3,$FF,$FF,$7A,$FF,$FF,$FF,$00 ; Level___MP_...._*/*__

M_EquipStats_Blank: ; numbers between 2 and 9 are amount of spaces in this string
;; don't draw it with the normal ComplexString setup... it must be loaded into RAM and edited there first!
.byte $8D,$A4,$B0,$A4,$66,$08                 ; Damage___###__ ; later on, stats are added in the # slots
.byte $8D,$A8,$A9,$3A,$3E,$05,$01             ; Defense__###
.byte $8A,$A6,$A6,$55,$5E,$BC,$06             ; Accuracy_###__
.byte $8E,$B9,$3F,$AC,$3C,$05,$01             ; Evasion__###
.byte $8C,$5C,$57,$51,$AF,$06                 ; Critical_###__
.byte $96,$C0,$8E,$B9,$A4,$A7,$A8,$05,$00     ; M.Evade__###

M_EquipInventoryWeapon:
.byte $C1,$FF,$A0,$2B,$B3,$3C,$B6,$FF,$C7,$00 ; Weapons

M_EquipInventoryArmor: 
.byte $C1,$FF,$FF,$8A,$B5,$B0,$35,$FF,$FF,$C7,$00 ; Armor

M_EquipInventorySelect:
.byte $9E,$3E,$FF,$9C,$B7,$2F,$B7,$7A,$9C,$A8,$45,$A6,$21,$28,$24,$BA,$5B,$A6,$AB,$01
;.byte $09,$03,$9E,$3E,$FF,$9C,$A8,$45,$A6,$21,$28,$24,$BA,$5B,$A6,$AB,$09,$05,$01
.byte $A5,$A8,$B7,$60,$3A,$33,$2B,$B3,$3C,$1E,$22,$27,$2F,$B0,$35,$C0,$00 ; Use Start/Select to switch between weapons and armor.

M_LampMagic:
.byte $8A,$24,$B3,$A8,$4E,$1B,$2E,$23,$37,$35,$1A,$B6,$AC,$AA,$AB,$B7,$C4,$00

M_EquipInventoryClear:
.byte $09,$1A,$00



DrawMenuString_CharCodes_A:
    LDA lut_MenuText, X     ; and load up the pointer into (tmp)
    STA tmp
    LDA lut_MenuText+1, X
    STA tmp+1

    LDA #<bigstr_buf        ; set the text pointer to our bigstring buffer
    STA text_ptr
    LDA #>bigstr_buf
    STA text_ptr+1
    
    LDY LongCall_Y
  @Loop:                    ; now step through each byte of the string....
    LDA (tmp), Y            ; get the byte
    CMP #$10                ; compare it to $10 (charater stat control code)
    BNE :+                  ;   if it equals...
      ORA submenu_targ      ;   OR with desired character ID to draw desired character's stats
  : STA bigstr_buf, Y       ; copy the byte to the big string buffer
    DEY                     ; then decrement Y
    CPY #$FF                ; check to see if it wrapped
    BNE @Loop               ; and keep looping until it has

                                ; once the loop is complete and our big string buffer has been filled
    BEQ :+                 ; draw the complex string and exit.

DrawMenuString_A:
    LDA lut_MenuText, X
    STA text_ptr
    LDA lut_MenuText+1, X   ; load pointer from table, store to text_ptr  (source pointer for DrawComplexString)
    STA text_ptr+1
    
  : LDA #BANK_THIS
    STA cur_bank          ; set data bank (string to draw is on this bank -- or is in RAM)
    LDA #BANK_MENUS
    STA ret_bank          ; set return bank (we want it to RTS to this bank when complete)
    JMP DrawComplexString ;  Draw Complex String, then exit!    


DumbBottleThing:
    BCS @NoTouchyExit ; if carry is set, can't be the bottle
    TXA
    LSR A
    CMP #BOTTLE
    BEQ @ChangeBottleName
    CMP #LEWDS
    BEQ @ChangeLewdsName

   @Exit:
    ASL A
    TAX
   @NoTouchyExit:
    RTS

   @ChangeBottleName:
    LDA #BOTTLE_ALT
    BNE @Exit

   @ChangeLewdsName:
    LDA #LEWDS_ALT
    BNE @Exit




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
    LDA data_EnemyNames, Y
    STA tmp
    LDA data_EnemyNames+1, Y
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
.byte TYPE_GIANT ;00 IMP
.byte TYPE_GIANT ;01 GrIMP
.byte $00 ;02 WOLF
.byte $00 ;03 GrWolf
.byte TYPE_WERE ;04 WrWolf
.byte $00 ;05 FrWOLF
.byte TYPE_DRAGON ;06 IGUANA
.byte TYPE_DRAGON ;07 AGAMA
.byte TYPE_DRAGON ;08 SAURIA
.byte TYPE_GIANT ;09 GIANT
.byte TYPE_GIANT ;0A FrGIANT
.byte TYPE_GIANT ;0B R`GIANT
.byte TYPE_WATER ;0C SAHAG
.byte TYPE_WATER ;0D R`SAHAG
.byte TYPE_WATER ;0E WzSAHAG
.byte $00 ;0F PIRATE
.byte $00 ;10 KYZOKU
.byte TYPE_WATER ;11 SHARK
.byte TYPE_WATER ;12 GrSHARK
.byte $00 ;13 OddEYE
.byte TYPE_WATER ;14 BigEYE
.byte TYPE_UNDEAD ;15 BONE
.byte TYPE_UNDEAD ;16 R`BONE
.byte $00 ;17 CREEP
.byte $00 ;18 CRAWL
.byte $00 ;19 HYENA
.byte $00 ;1A CEREBUS
.byte TYPE_GIANT ;1B OGRE
.byte TYPE_GIANT ;1C GrOGRE
.byte TYPE_GIANT ;1D WzOGRE
.byte TYPE_DRAGON ;1E ASP
.byte TYPE_DRAGON ;1F COBRA
.byte TYPE_WATER ;20 SeaSNAKE
.byte $00 ;21 SCORPION
.byte TYPE_WATER ;22 LOBSTER
.byte $00 ;23 BULL
.byte TYPE_UNDEAD ;24 ZomBULL
.byte TYPE_REGEN ;25 TROLL
.byte TYPE_REGEN ;26 SeaTROLL
.byte TYPE_UNDEAD ;27 SHADOW
.byte TYPE_UNDEAD ;28 IMAGE
.byte TYPE_UNDEAD ;29 WRAITH
.byte TYPE_UNDEAD ;2A GHOST
.byte TYPE_UNDEAD ;2B ZOMBIE
.byte TYPE_UNDEAD ;2C GHOUL
.byte TYPE_UNDEAD ;2D GEIST
.byte TYPE_UNDEAD ;2E SPECTER
.byte $00 ;2F WORM
.byte $00 ;30 Sand W
.byte $00 ;31 Grey W
.byte TYPE_MAGE ;32 EYE
.byte TYPE_UNDEAD ;33 PHANTOM
.byte $00 ;34 MEDUSA
.byte TYPE_UNKNOWN ;35 GrMEDUSA
.byte TYPE_WERE ;36 CATMAN
.byte TYPE_MAGE ;37 MANCAT
.byte $00 ;38 PEDE
.byte $00 ;39 GrPEDE
.byte $00 ;3A TIGER
.byte $00 ;3B Saber T
.byte TYPE_UNDEAD ;3C VAMPIRE
.byte TYPE_UNDEAD ;3D WzVAMP
.byte TYPE_UNKNOWN ;3E GARGOYLE
.byte TYPE_UNKNOWN ;3F R`GOYLE
.byte TYPE_UNKNOWN ;40 EARTH
.byte TYPE_UNKNOWN ;41 FIRE
.byte TYPE_DRAGON ;42 Frost D
.byte TYPE_DRAGON ;43 Red D
.byte TYPE_UNDEAD ;44 ZombieD
.byte $00 ;45 SCUM
.byte $00 ;46 MUCK
.byte $00 ;47 OOZE
.byte $00 ;48 SLIME
.byte $00 ;49 SPIDER
.byte $00 ;4A ARACHNID
.byte $00 ;4B MATICOR
.byte $00 ;4C SPHINX
.byte $00 ;4D R`ANKYLO
.byte $00 ;4E ANKYLO
.byte TYPE_UNDEAD ;4F MUMMY
.byte TYPE_UNDEAD ;50 WzMUMMY
.byte $00 ;51 COCTRICE
.byte $00 ;52 PERILISK
.byte TYPE_DRAGON ;53 WYVERN
.byte TYPE_DRAGON ;54 WYRM
.byte TYPE_DRAGON ;55 TYRO
.byte TYPE_DRAGON ;56 T REX
.byte $00 ;57 CARIBE
.byte $00 ;58 R`CARIBE
.byte $00 ;59 GATOR
.byte TYPE_DRAGON ;5A FrGATOR
.byte $00 ;5B OCHO
.byte $00 ;5C NAOCHO
.byte TYPE_DRAGON ;5D HYDRA
.byte TYPE_DRAGON ;5E R`HYDRA
.byte $00 ;5F GAURD
.byte $00 ;60 SENTRY
.byte TYPE_UNKNOWN ;61 WATER
.byte TYPE_UNKNOWN ;62 AIR
.byte TYPE_MAGE ;63 NAGA
.byte TYPE_MAGE ;64 GrNAGA
.byte TYPE_DRAGON ;65 CHIMERA
.byte TYPE_DRAGON ;66 JIMERA
.byte TYPE_WATER ;67 WIZARD  ;; very weird
.byte $00 ;68 SORCERER
.byte $00 ;69 GARLAND
.byte TYPE_DRAGON ;6A Gas D
.byte TYPE_DRAGON ;6B Blue D
.byte TYPE_MAGE ;6C MudGOL
.byte TYPE_MAGE ;6D RockGOL
.byte TYPE_UNKNOWN ;6E IronGOL
.byte $00 ;6F BADMAN
.byte TYPE_MAGE ;70 EVILMAN
.byte $00 ;71 ASTOS
.byte TYPE_MAGE ;72 MAGE
.byte TYPE_MAGE ;73 FIGHTER
.byte $00 ;74 MADPONY
.byte TYPE_UNKNOWN ;75 NITEMARE
.byte TYPE_REGEN ;76 WarMECH
.byte TYPE_UNDEAD ;77 LICH
.byte TYPE_UNDEAD ;78 LICH (reprise)
.byte TYPE_MAGE ;79 KARY
.byte TYPE_MAGE ;7A KARY (reprise)
.byte TYPE_WATER ;7B KRAKEN
.byte TYPE_WATER ;7C KRAKEN (reprise)
.byte TYPE_DRAGON ;7D TIAMAT
.byte TYPE_DRAGON ;7E TIAMAT (reprise)
.byte TYPE_UNKNOWN ;7F CHAOS

.byte "END OF BANK A"