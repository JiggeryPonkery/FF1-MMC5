.include "Constants.inc"
.include "variables.inc"

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

.import ConvertBattleNumber
.import MultiplyXA
.import LongCall

BANK_THIS = $0A

; Dialogue data! This is moved to its own bank now, because the 7 letter spell names pushed me 50 bytes over the limit and damnit
; I'm not going to switch everything back to 6 letter spells now!

;; First, monster attacks:
lut_EnemyAttack:

.word EnemyAttack1
.word EnemyAttack2
.word EnemyAttack3
.word EnemyAttack4
.word EnemyAttack5
.word EnemyAttack6
.word EnemyAttack7
.word EnemyAttack8
.word EnemyAttack9
.word EnemyAttack10
.word EnemyAttack11
.word EnemyAttack12
.word EnemyAttack13
.word EnemyAttack14
.word EnemyAttack15
.word EnemyAttack16
.word EnemyAttack17
.word EnemyAttack18
.word EnemyAttack19
.word EnemyAttack20
.word EnemyAttack21
.word EnemyAttack22
.word EnemyAttack23
.word EnemyAttack24
.word EnemyAttack25
.word EnemyAttack26

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

;.byte $8B,$AD,$95,$A2,$8F,$59,$9D,$00 ; BjLY ... yeah this is leftover garbage
;.byte $F1,$6F,$F6,$FF,$FF,$FF,$FF,$00 ; 
;.byte $8F,$B5,$9C,$59,$91,$B4,$FF,$00 ; 
;.byte $97,$8B,$56

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;  Enemy names [$94E0 :: 0x2D4F0]
data_EnemyNames:

.word ENEMYNAME1  
.word ENEMYNAME2  
.word ENEMYNAME3  
.word ENEMYNAME4  
.word ENEMYNAME5  
.word ENEMYNAME6  
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
.word NAME_WAKEUPBELL   ; 0D
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

.word MoneyChest1  ; 70
.word MoneyChest2  ; 71
.word MoneyChest3  ; 72
.word MoneyChest4  ; 73
.word MoneyChest5  ; 74
.word MoneyChest6  ; 75
.word MoneyChest7  ; 76
.word MoneyChest8  ; 77
.word MoneyChest9  ; 78
.word MoneyChest10 ; 79
.word MoneyChest11 ; 7A
.word MoneyChest12 ; 7B
.word MoneyChest13 ; 7C
.word MoneyChest14 ; 7D
.word MoneyChest15 ; 7E
.word MoneyChest16 ; 7F
.word MoneyChest17 ; 80
.word MoneyChest18 ; 81
.word MoneyChest19 ; 82
.word MoneyChest20 ; 83
.word MoneyChest21 ; 84
.word MoneyChest22 ; 85
.word MoneyChest23 ; 86
.word MoneyChest24 ; 87
.word MoneyChest25 ; 88
.word MoneyChest26 ; 89
.word MoneyChest27 ; 8A
.word MoneyChest28 ; 8B
.word MoneyChest29 ; 8C
.word MoneyChest30 ; 8D
.word MoneyChest31 ; 8E
.word MoneyChest32 ; 8F
.word MoneyChest33 ; 90
.word MoneyChest34 ; 91
.word MoneyChest35 ; 92
.word MoneyChest36 ; 93
.word MoneyChest37 ; 94
.word MoneyChest38 ; 95
.word MoneyChest39 ; 96
.word MoneyChest40 ; 97
.word MoneyChest41 ; 98
.word MoneyChest42 ; 99
.word MoneyChest43 ; 9A
.word MoneyChest44 ; 9B
.word MoneyChest45 ; 9C
.word MoneyChest46 ; 9D
.word MoneyChest47 ; 9E
.word MoneyChest48 ; 9F
.word MoneyChest49 ; A0
.word MoneyChest50 ; A1
.word MoneyChest51 ; A2
.word MoneyChest52 ; A3
.word MoneyChest53 ; A4
.word MoneyChest54 ; A5
.word MoneyChest55 ; A6
.word MoneyChest56 ; A7
.word MoneyChest57 ; A8
.word MoneyChest58 ; A9
.word MoneyChest59 ; AA
.word MoneyChest60 ; AB
.word MoneyChest61 ; AC
.word MoneyChest62 ; AD
.word MoneyChest63 ; AE
.word MoneyChest64 ; AF
.word MoneyChest65 ; B0
.word MoneyChest66 ; B1
.word MoneyChest67 ; B2
.word MoneyChest68 ; B3
.word MoneyChest69 ; B4
.word MoneyChest70 ; B5
.word MoneyChest71 ; B6
.word MoneyChest72 ; B7
.word MoneyChest73 ; B8
.word MoneyChest74 ; B9
.word MoneyChest75 ; BA
.word MoneyChest76 ; BB
.word MoneyChest77 ; BC
.word MoneyChest78 ; BD
.word MoneyChest79 ; BE
.word MoneyChest80 ; BF

.word CLASS1       ; C0
.word CLASS2       ; C1
.word CLASS3       ; C2
.word CLASS4       ; C3
.word CLASS5       ; C4
.word CLASS6       ; C5
.word CLASS7       ; C6
.word CLASS8       ; C7
.word CLASS9       ; C8
.word CLASS10      ; C9
.word CLASS11      ; CA
.word CLASS12      ; CB


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
.word Weapon41     ; 28
.word Weapon42     ; 29
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
NAME_WAKEUPBELL:
.byte $A0,$A4,$AE,$A8,$B8,$B3,$FF,$E4,$00 ; Wakeup_^


ORB1: ; orbs
ORB2: ; Orbs are not listed on the item screen... but they could be? Maybe?
ORB3:
ORB4:
.BYTE $FF
BLANK:
.byte $00


;; KEY ITEMS
NAME_LUTE: 
.byte $95,$B8,$B7,$A8,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$00 ; LUTE
NAME_CROWN:
.byte $8C,$B5,$B2,$BA,$B1,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$00 ; CROWN
NAME_CRYSTAL:
.byte $8C,$B5,$BC,$B6,$B7,$A4,$AF,$FF,$8E,$BC,$A8,$FF,$00 ; CRYSTAL
NAME_HERB:
.byte $91,$A8,$B5,$A5,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$00 ; HERB
NAME_KEY:
.byte $96,$BC,$B6,$B7,$AC,$A6,$FF,$94,$A8,$BC,$FF,$FF,$00 ; KEY
NAME_TNT:
.byte $9D,$97,$9D,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$00 ; TNT
NAME_ADAMANT:
.byte $8A,$A7,$A4,$B0,$A4,$B1,$B7,$AC,$B1,$A8,$FF,$FF,$00 ; ADAMANT
NAME_SLAB:
.byte $9B,$B2,$B6,$A8,$B7,$B7,$A4,$FF,$9C,$AF,$A4,$A5,$00 ; SLAB
NAME_RUBY:
.byte $9C,$B7,$A4,$B5,$FF,$9B,$B8,$A5,$BC,$FF,$FF,$FF,$00 ; RUBY
NAME_ROD:
.byte $8E,$A4,$B5,$B7,$AB,$FF,$9B,$B2,$A7,$FF,$FF,$FF,$00 ; ROD
NAME_FLOATER:
.byte $95,$A8,$B9,$AC,$B6,$B7,$B2,$B1,$A8,$FF,$FF,$FF,$00 ; FLOATER
NAME_CHIME:
.byte $8C,$AB,$AC,$B0,$A8,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$00 ; CHIME
NAME_TAIL:
.byte $9B,$A4,$B7,$BE,$B6,$FF,$9D,$A4,$AC,$AF,$FF,$FF,$00 ; TAIL
NAME_CUBE:
.byte $A0,$A4,$B5,$B3,$FF,$8C,$B8,$A5,$A8,$FF,$FF,$FF,$00 ; CUBE
NAME_BOTTLE:
.byte $8B,$B2,$B7,$B7,$AF,$A8,$FF,$FF,$FF,$FF,$FF,$FF,$00 ; BOTTLE
NAME_BOTTLE_ALT:
.byte $8B,$B2,$B7,$B7,$AF,$A8,$00                         ; BOTTLE
NAME_OXYALE:
.byte $98,$BB,$BC,$A4,$AF,$A8,$FF,$FF,$FF,$FF,$FF,$FF,$00 ; OXYALE
NAME_CANOE:
.byte $8C,$A4,$B1,$B2,$A8,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$00 ; CANOE
NAME_LEWDS:
.byte $95,$A8,$BA,$A7,$FF,$9D,$A8,$BB,$B7,$B6,$FF,$FF,$00 ; Lewd Texts
NAME_LEWDS_ALT:
.byte $C5,$C5,$C5,$FF,$8B,$B2,$B2,$AE,$00                 ; ??? Book












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
.byte $8B,$98,$95,$9D,$FF,$DB,$FF,$00  ;  BOLT_(Shield)_
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
.byte $8C,$9E,$9B,$8E,$FF,$82,$FF,$00  ;  CURE_2_
SPELL18:
;.byte $91,$9B,$96,$82,$00 ; HRM2
.byte $91,$8A,$9B,$96,$FF,$82,$FF,$00  ;  HARM_2_
SPELL19:
;.byte $8A,$8F,$92,$9B,$00 ; AFIR
.byte $8F,$92,$9B,$8E,$FF,$DB,$FF,$00  ;  FIRE_(shield)_
SPELL20:
;.byte $91,$8E,$8A,$95,$00 ; HEAL
.byte $91,$8E,$8A,$95,$FF,$FF,$FF,$00  ;  HEAL___
SPELL21:
;.byte $8F,$92,$9B,$82,$00 ; FIR2
.byte $8F,$92,$9B,$8E,$FF,$82,$FF,$00  ;  FIRE_2_
SPELL22:
;.byte $91,$98,$95,$8D,$00 ; HOLD
.byte $91,$98,$95,$8D,$FF,$FF,$FF,$00  ;  HOLD___
SPELL23:
;.byte $95,$92,$9D,$82,$00 ; LIT2
.byte $8B,$98,$95,$9D,$FF,$82,$FF,$00  ;  BOLT_2_
SPELL24:
;.byte $95,$98,$94,$82,$00 ; L0K2
.byte $95,$98,$8C,$94,$FF,$82,$FF,$00  ;  LOCK_2_
SPELL25:
;.byte $99,$9E,$9B,$8E,$00 ; PURE
.byte $99,$9E,$9B,$8E,$FF,$FF,$FF,$00  ;  PURE___
SPELL26:
;.byte $8F,$8E,$8A,$9B,$00 ; FEAR 
.byte $8F,$8E,$8A,$9B,$FF,$FF,$FF,$00  ;  FEAR___
SPELL27:
;.byte $8A,$92,$8C,$8E,$00 ; AICE
.byte $92,$8C,$8E,$FF,$DB,$FF,$FF,$00  ;  ICE_(shield)__
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
.byte $92,$8C,$8E,$FF,$82,$FF,$FF,$00  ;  ICE_2__
SPELL33:
;.byte $8C,$9E,$9B,$83,$00 ; CUR3
.byte $8C,$9E,$9B,$8E,$FF,$83,$FF,$00  ;  CURE_3_
SPELL34:
;.byte $95,$92,$8F,$8E,$00 ; LIFE
.byte $95,$92,$8F,$8E,$FF,$FF,$FF,$00  ;  LIFE___
SPELL35:
;.byte $91,$9B,$96,$83,$00 ; HRM3
.byte $91,$8A,$9B,$96,$FF,$83,$FF,$00  ;  HARM_3_
SPELL36:
;.byte $91,$8E,$95,$82,$00 ; HEL2
.byte $91,$8E,$8A,$95,$FF,$82,$FF,$00  ;  HEAL_2_
SPELL37:
;.byte $8F,$92,$9B,$83,$00 ; FIR3
.byte $8F,$92,$9B,$8E,$FF,$83,$FF,$00  ;  FIRE_3_
SPELL38:
;.byte $8B,$8A,$97,$8E,$00 ; BANE
.byte $8B,$8A,$97,$8E,$FF,$FF,$FF,$00  ;  BANE___
SPELL39:
;.byte $A0,$8A,$9B,$99,$00 ; WARP
.byte $A0,$8A,$9B,$99,$FF,$FF,$FF,$00  ;  WARP___
SPELL40:
;.byte $9C,$95,$98,$82,$00 ; SL02
.byte $9C,$95,$98,$A0,$FF,$82,$FF,$00  ;  SLOW_2_
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
.byte $8B,$98,$95,$9D,$FF,$83,$FF,$00  ;  BOLT_3_
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
.byte $8C,$9E,$9B,$8E,$FF,$84,$FF,$00  ;  CURE_4_
SPELL50:
;.byte $91,$9B,$96,$84,$00 ; HRM4
.byte $91,$8A,$9B,$96,$FF,$84,$FF,$00  ;  HARM_4_
SPELL51:
;.byte $8A,$9B,$9E,$8B,$00 ; ARUB
.byte $9B,$9E,$8B,$FF,$DB,$FF,$FF,$00  ;  RUB_(shield)__
SPELL52:
;.byte $91,$8E,$95,$83,$00 ; HEL3
.byte $91,$8E,$8A,$95,$FF,$83,$FF,$00  ;  HEAL_3_
SPELL53:
;.byte $92,$8C,$8E,$83,$00 ; ICE3
.byte $92,$8C,$8E,$FF,$83,$FF,$FF,$00  ;  ICE_3__
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
.byte $95,$92,$8F,$8E,$FF,$82,$FF,$00  ;  LIFE_2_
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
.byte $8D,$98,$98,$96,$FF,$FF,$FF,$00  ;  DOOM___



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
.byte $94,$97,$92,$90,$91,$9D,$FF,$00 ; KNIGHT_
CLASS8:
.byte $97,$92,$97,$93,$8A,$FF,$FF,$00 ; NINJA__ 
CLASS9:
.byte $96,$8A,$9C,$9D,$8E,$9B,$FF,$00 ; MASTER_
CLASS10:
.byte $9B,$A8,$A7,$A0,$AC,$BD,$FF,$00 ; RedWiz_
CLASS11:
.byte $A0,$AB,$C0,$A0,$AC,$BD,$FF,$00 ; Wh.Wiz_
CLASS12:
.byte $8B,$AF,$C0,$A0,$AC,$BD,$FF,$00 ; Bl.Wiz_






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
.byte $E6,$E7,$E8,$E9,$00 ; {E6}{E7}{E8}{E9} (Stone) ; JIGS - the squished text doesn't exist anymore...
BTL_MESSAGE67:
.byte $E2,$E3,$E4,$E5,$00 ; {E2}{E3}{E4}{E5} (Poison) ; JIGS - the squished text doesn't exist anymore...
BTL_MESSAGE68:
.byte $8D,$A4,$B5,$AE,$00 ; Dark
BTL_MESSAGE69:
.byte $9C,$B7,$B8,$B1,$00 ; Stun
BTL_MESSAGE70:
.byte $8A,$EA,$C8,$C9,$00 ; A {EA}{C8}{C9} (sl eep) ; JIGS - the squished text doesn't exist anymore...
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
.byte $9C,$AC,$AA,$AB,$21,$23,$37,$35,$40,$C4,$00 ; Sight restored!
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
.word 0750    ; 0D WAKEUP BELL
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

;; gold in chests
;              chest number
;              |    item ID (not price ID)
.word  0010  ; 1  ; 70
.word  0020  ; 2  ; 71
.word  0025  ; 3  ; 72
.word  0030  ; 4  ; 73
.word  0055  ; 5  ; 74
.word  0070  ; 6  ; 75
.word  0085  ; 7  ; 76
.word  0110  ; 8  ; 77
.word  0135  ; 9  ; 78
.word  0155  ; 10 ; 79
.word  0160  ; 11 ; 7A
.word  0180  ; 12 ; 7B
.word  0240  ; 13 ; 7C
.word  0255  ; 14 ; 7D
.word  0260  ; 15 ; 7E
.word  0295  ; 16 ; 7F
.word  0300  ; 17 ; 80
.word  0315  ; 18 ; 81
.word  0330  ; 19 ; 82
.word  0350  ; 20 ; 83
.word  0385  ; 21 ; 84
.word  0400  ; 22 ; 85
.word  0450  ; 23 ; 86
.word  0500  ; 24 ; 87
.word  0530  ; 25 ; 88
.word  0575  ; 26 ; 89
.word  0620  ; 27 ; 8A
.word  0680  ; 28 ; 8B
.word  0750  ; 29 ; 8C
.word  0795  ; 30 ; 8D
.word  0880  ; 31 ; 8E
.word  1020  ; 32 ; 8F
.word  1250  ; 33 ; 90
.word  1455  ; 34 ; 91
.word  1520  ; 35 ; 92
.word  1760  ; 36 ; 93
.word  1975  ; 37 ; 94
.word  2000  ; 38 ; 95
.word  2750  ; 39 ; 96
.word  3400  ; 40 ; 97
.word  4150  ; 41 ; 98
.word  5000  ; 42 ; 99
.word  5450  ; 43 ; 9A
.word  6400  ; 44 ; 9B
.word  6720  ; 45 ; 9C
.word  7340  ; 46 ; 9D
.word  7690  ; 47 ; 9E
.word  7900  ; 48 ; 9F
.word  8135  ; 49 ; A0
.word  9000  ; 50 ; A1
.word  9300  ; 51 ; A2
.word  9500  ; 52 ; A3
.word  9900  ; 53 ; A4
.word  10000 ; 54 ; A5
.word  12350 ; 55 ; A6
.word  13000 ; 56 ; A7
.word  13450 ; 57 ; A8
.word  14050 ; 58 ; A9
.word  14720 ; 59 ; AA
.word  15000 ; 60 ; AB
.word  17490 ; 61 ; AC
.word  18010 ; 62 ; AD
.word  19990 ; 63 ; AE
.word  20000 ; 64 ; AF
.word  20010 ; 65 ; B0
.word  26000 ; 66 ; B1
.word  45000 ; 67 ; B2
.word  65000 ; 68 ; B3
.word  65000 ; 69 ; B4
.word  65000 ; 70 ; B5
.word  65000 ; 71 ; B6
.word  65000 ; 72 ; B7
.word  65000 ; 73 ; B8
.word  65000 ; 74 ; B9
.word  65000 ; 75 ; BA
.word  65000 ; 76 ; BB
.word  65000 ; 77 ; BC
.word  65000 ; 78 ; BD
.word  65000 ; 79 ; BE
.word  65000 ; 80 ; BF

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

  
DumbBottleThing:
    LDY #0
    DEC text_ptr
    DEC text_ptr
    LDA (text_ptr), Y
    CMP #$07
    BEQ @Exit

    CPX #BOTTLE
    BEQ @ChangeBottleName
    CPX #LEWDS
    BEQ @ChangeLewdsName
   @Exit: 
    RTS

   @ChangeBottleName:
    LDX #BOTTLE_ALT
    RTS

   @ChangeLewdsName:
    LDX #LEWDS_ALT
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
      INX
  : LSR A
    BCC :+
      LDY #$D1 ; stone
      JSR @PrintStatBitIcon
      INX
  : LSR A
    BCC :+
      LDY #$CC ; poison
      JSR @PrintStatBitIcon
      INX
  : LSR A
    BCC :+
      LDY #$EB ; darkness
      JSR @PrintStatBitIcon
      INX
  : LSR A
    BCC :+
      LDY #$D2 ; sleep
      JSR @PrintStatBitIcon
      INX
  : LSR A
    BCC :+
      LDY #$CB ; stun
      JSR @PrintStatBitIcon
      INX
  : LSR A
    BCC :+
      LDY #$D3 ; mute
      JSR @PrintStatBitIcon
      INX
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