.include "Constants.inc"
.include "variables.inc"

.segment "BANK_0A"

.export data_BattleMessages
.export lut_ItemPrices
.import MultiplyXA

BANK_THIS = $0A

;.INCBIN "bin/bank_0A_data.bin"
; Dialogue data! This is moved to its own bank now, because the 7 letter spell names pushed me 50 bytes over the limit and damnit
; I'm not going to switch everything back to 6 letter spells now!

;; First, monster attacks:

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
.byte $9D,$98,$9B,$97,$8A,$8D,$98,$00    ; TORNADO

;.byte $8B,$AD,$95,$A2,$8F,$59,$9D,$00 ; BjLY ... yeah this is leftover garbage
;.byte $F1,$6F,$F6,$FF,$FF,$FF,$FF,$00 ; 
;.byte $8F,$B5,$9C,$59,$91,$B4,$FF,$00 ; 
;.byte $97,$8B,$56

; But here's all the items and some more!
; When the game looks up an item name, it first gets the pointer--the two byte .word names here--and then looks that up from a table of sorts?
; I sorted all this out so you can rename items and *re-organize* them easier, which FFHackster lacks the ability to do. 
; And there was just so much wasted space. So much. Now you can fill it with 8-letter item names. 

  .ALIGN  $100


.word START        ; 00 
.word HEAL         ; 01 
.word PURE         ; 02 
.word SOFT         ; 03 
.word TENT         ; 04 
.word CABIN        ; 05 
.word HOUSE        ; 06 
.word LUTE         ; 07 
.word CROWN        ; 08 
.word CRYSTAL      ; 09 
.word HERB         ; 0A 
.word KEY          ; 0B 
.word TNT          ; 0C 
.word ADAMANT      ; 0D 
.word SLAB         ; 0E 
.word RUBY         ; 0F 
.word ROD          ; 10
.word FLOATER      ; 11
.word CHIME        ; 12
.word TAIL         ; 13
.word CUBE         ; 14
.word BOTTLE       ; 15
.word OXYALE       ; 16
.word CANOE        ; 17
.word ORB1         ; 18
.word ORB2         ; 19
.word ORB3         ; 1A
.word ORB4         ; 1B
.word Weapon1      ; 1C
.word Weapon2      ; 1D small knife
.word Weapon3      ; 1E wooden staff
.word Weapon4      ; 1F
.word Weapon5      ; 20
.word Weapon6      ; 21
.word Weapon7      ; 22
.word Weapon8      ; 23
.word Weapon9      ; 24
.word Weapon10     ; 25
.word Weapon11     ; 26
.word Weapon12     ; 27
.word Weapon13     ; 28
.word Weapon14     ; 29
.word Weapon15     ; 2A
.word Weapon16     ; 2B
.word Weapon17     ; 2C
.word Weapon18     ; 2D
.word Weapon19     ; 2E
.word Weapon20     ; 2F
.word Weapon21     ; 30
.word Weapon22     ; 31
.word Weapon23     ; 32
.word Weapon24     ; 33
.word Weapon25     ; 34
.word Weapon26     ; 35
.word Weapon27     ; 36
.word Weapon28     ; 37
.word Weapon29     ; 38
.word Weapon30     ; 39
.word Weapon31     ; 3A
.word Weapon32     ; 3B
.word Weapon33     ; 3C
.word Weapon34     ; 3D
.word Weapon35     ; 3E
.word Weapon36     ; 3F
.word Weapon37     ; 40
.word Weapon38     ; 41
.word Weapon39     ; 42
.word Weapon40     ; 43
.word Armor1       ; 44
.word Armor2       ; 45
.word Armor3       ; 46
.word Armor4       ; 47
.word Armor5       ; 48
.word Armor6       ; 49
.word Armor7       ; 4A
.word Armor8       ; 4B
.word Armor9       ; 4C
.word Armor10      ; 4D
.word Armor11      ; 4E
.word Armor12      ; 4F
.word Armor13      ; 50
.word Armor14      ; 51
.word Armor15      ; 52
.word Armor16      ; 53
.word Armor17      ; 54
.word Armor18      ; 55
.word Armor19      ; 56
.word Armor20      ; 57
.word Armor21      ; 58
.word Armor22      ; 59
.word Armor23      ; 5A
.word Armor24      ; 5B
.word Armor25      ; 5C
.word Armor26      ; 5D
.word Armor27      ; 5E
.word Armor28      ; 5F
.word Armor29      ; 60
.word Armor30      ; 61
.word Armor31      ; 62
.word Armor32      ; 63
.word Armor33      ; 64
.word Armor34      ; 65
.word Armor35      ; 66
.word Armor36      ; 67
.word Armor37      ; 68
.word Armor38      ; 69
.word Armor39      ; 6A
.word Armor40      ; 6B
.word MoneyChest1  ; 6C
.word MoneyChest2  ; 6D
.word MoneyChest3  ; 6E
.word MoneyChest4  ; 6F
.word MoneyChest5  ; 70
.word MoneyChest6  ; 71
.word MoneyChest7  ; 72
.word MoneyChest8  ; 73
.word MoneyChest9  ; 74
.word MoneyChest10 ; 75
.word MoneyChest11 ; 76
.word MoneyChest12 ; 77
.word MoneyChest13 ; 78
.word MoneyChest14 ; 79
.word MoneyChest15 ; 7A
.word MoneyChest16 ; 7B
.word MoneyChest17 ; 7C
.word MoneyChest18 ; 7D
.word MoneyChest19 ; 7E
.word MoneyChest20 ; 7F
.word MoneyChest21 ; 80
.word MoneyChest22 ; 81
.word MoneyChest23 ; 82
.word MoneyChest24 ; 83
.word MoneyChest25 ; 84
.word MoneyChest26 ; 85
.word MoneyChest27 ; 86
.word MoneyChest28 ; 87
.word MoneyChest29 ; 88
.word MoneyChest30 ; 89
.word MoneyChest31 ; 8A
.word MoneyChest32 ; 8B
.word MoneyChest33 ; 8C
.word MoneyChest34 ; 8D
.word MoneyChest35 ; 8E
.word MoneyChest36 ; 8F
.word MoneyChest37 ; 90
.word MoneyChest38 ; 91
.word MoneyChest39 ; 92
.word MoneyChest40 ; 93
.word MoneyChest41 ; 94
.word MoneyChest42 ; 95
.word MoneyChest43 ; 96
.word MoneyChest44 ; 97
.word MoneyChest45 ; 98
.word MoneyChest46 ; 99
.word MoneyChest47 ; 9A
.word MoneyChest48 ; 9B
.word MoneyChest49 ; 9C
.word MoneyChest50 ; 9D
.word MoneyChest51 ; 9E
.word MoneyChest52 ; 9F
.word MoneyChest53 ; A0
.word MoneyChest54 ; A1
.word MoneyChest55 ; A2
.word MoneyChest56 ; A3
.word MoneyChest57 ; A4
.word MoneyChest58 ; A5
.word MoneyChest59 ; A6
.word MoneyChest60 ; A7
.word MoneyChest61 ; A8
.word MoneyChest62 ; A9
.word MoneyChest63 ; AA
.word MoneyChest64 ; AB
.word MoneyChest65 ; AC
.word MoneyChest66 ; AD
.word MoneyChest67 ; AE
.word MoneyChest68 ; AF
.word SPELL1       ; B0
.word SPELL2       ; B1
.word SPELL3       ; B2
.word SPELL4       ; B3
.word SPELL5       ; B4
.word SPELL6       ; B5
.word SPELL7       ; B6
.word SPELL8       ; B7
.word SPELL9       ; B8
.word SPELL10      ; B9
.word SPELL11      ; BA
.word SPELL12      ; BB
.word SPELL13      ; BC
.word SPELL14      ; BD
.word SPELL15      ; BE
.word SPELL16      ; BF
.word SPELL17      ; C0
.word SPELL18      ; C1
.word SPELL19      ; C2
.word SPELL20      ; C3
.word SPELL21      ; C4
.word SPELL22      ; C5
.word SPELL23      ; C6
.word SPELL24      ; C7
.word SPELL25      ; C8
.word SPELL26      ; C9
.word SPELL27      ; CA
.word SPELL28      ; CB
.word SPELL29      ; CC
.word SPELL30      ; CD
.word SPELL31      ; CE
.word SPELL32      ; CF
.word SPELL33      ; D0
.word SPELL34      ; D1
.word SPELL35      ; D2
.word SPELL36      ; D3
.word SPELL37      ; D4
.word SPELL38      ; D5
.word SPELL39      ; D6
.word SPELL40      ; D7
.word SPELL41      ; D8
.word SPELL42      ; D9
.word SPELL43      ; DA
.word SPELL44      ; DB
.word SPELL45      ; DC
.word SPELL46      ; DD
.word SPELL47      ; DE
.word SPELL48      ; DF
.word SPELL49      ; E0
.word SPELL50      ; E1
.word SPELL51      ; E2
.word SPELL52      ; E3
.word SPELL53      ; E4
.word SPELL54      ; E5
.word SPELL55      ; E6
.word SPELL56      ; E7
.word SPELL57      ; E8
.word SPELL58      ; E9
.word SPELL59      ; EA
.word SPELL60      ; EB
.word SPELL61      ; EC
.word SPELL62      ; ED
.word SPELL63      ; EE
.word SPELL64      ; EF
.word CLASS1       ; F0
.word CLASS2       ; F1
.word CLASS3       ; F2
.word CLASS4       ; F3
.word CLASS5       ; F4
.word CLASS6       ; F5
.word CLASS7       ; F6
.word CLASS8       ; F7
.word CLASS9       ; F8
.word CLASS10      ; F9
.word CLASS11      ; FA
.word CLASS12      ; FB


;; JIGS - Original item data started like this...
;; Some of the items have spaces, some don't. Turns out you don't need all those spaces anyway!
;; Can't remember if that's an edit I did or if the original code worked and they were dumb about it.

;.byte $00
;.byte $9D,$8E,$97,$9D,$FF,$FF,$FF,$00 ; TENT___ 
;.byte $8C,$8A,$8B,$92,$97,$FF,$FF,$00 ; CABIN__
;.byte $91,$98,$9E,$9C,$8E,$FF,$FF,$00 ; HOUSE__
;.byte $91,$8E,$8A,$95,$E1,$00 ; HEAL&
;.byte $99,$9E,$9B,$8E,$E1,$00 ; PURE&
;.byte $9C,$98,$8F,$9D,$E1,$FF,$FF,$00 ; SOFT&
;.byte $A0,$B2,$B2 ; X22 ? 

;; ITEM NAMES
;; For items with a quantity, make spaces so they're 6 letters long.

START:
.byte $00
HEAL:
.BYTE $91,$8E,$8A,$95,$E1,$FF,$00 ; HEAL&_ (E1 is the potion icon)
PURE:
.BYTE $99,$9E,$9B,$8E,$E1,$FF,$00 ; PURE&_
SOFT:
.BYTE $9C,$98,$8F,$9D,$E1,$FF,$00 ; SOFT&_
TENT:
.byte $9D,$8E,$97,$9D,$FF,$FF,$00 ; TENT__
CABIN: 
.BYTE $8C,$8A,$8B,$92,$97,$FF,$00 ; CABIN_
HOUSE:
.byte $91,$98,$9E,$9C,$8E,$FF,$00 ; HOUSE_


;; These do not need to be null-terminated if they're 7 letters long?
LUTE: 
.BYTE $95,$9E,$9D,$8E,$00; $FF,$FF,$FF,$00 ; LUTE
CROWN:
.BYTE $8C,$9B,$98,$A0,$97,$00; $FF,$FF,$00 ; CROWN
CRYSTAL:
.byte $8C,$9B,$A2,$9C,$9D,$8A,$95          ; CRYSTAL
HERB:
.BYTE $91,$8E,$9B,$8B,$00; $FF,$FF,$FF,$00 ; HERB
KEY:
.byte $94,$8E,$A2,$00; $FF,$FF,$FF,$FF,$00 ; KEY
TNT:
.BYTE $9D,$97,$9D,$00; $FF,$FF,$FF,$FF,$00 ; TNT
ADAMANT:
.byte $8A,$8D,$8A,$96,$8A,$97,$9D          ; ADAMANT
SLAB:
.BYTE $9C,$95,$8A,$8B,$00; $FF,$FF,$FF,$00 ; SLAB
RUBY:
.byte $9B,$9E,$8B,$A2,$00; $FF,$FF,$FF,$00 ; RUBY
ROD:
.BYTE $9B,$98,$8D,$00; $FF,$FF,$FF,$FF,$00 ; ROD
FLOATER:
.byte $8F,$95,$98,$8A,$9D,$8E,$9B          ; FLOATER
CHIME:
.BYTE $8C,$91,$92,$96,$8E,$00; $FF,$FF,$00 ; CHIME
TAIL:
.byte $9D,$8A,$92,$95,$00; $FF,$FF,$FF,$00 ; TAIL
CUBE:
.BYTE $8C,$9E,$8B,$8E,$00; $FF,$FF,$FF,$00 ; CUBE
BOTTLE:
.byte $8B,$98,$9D,$9D,$95,$8E,$00; $FF,$00 ; BOTTLE
OXYALE:
.BYTE $98,$A1,$A2,$8A,$95,$8E,$00; $FF,$00 ; OXYALE
CANOE:
.byte $8C,$8A,$97,$98,$8E,$00; $FF,$FF,$00 ; CANOE
ORB1: ; orbs
ORB2: ; Orbs are not listed on the item screen... but they could be? Maybe?
ORB3:
ORB4:
.BYTE $FF,$00


;; WEAPONS AND ARMORS
;; Note that the names I wrote by the bytes are not exactly what the bytes say
;; as I've tried to do in the other lists. Since I didn't edit anything that I can remember... it should all be vanilla.
;; so the names are fancy! 

Weapon1:
.BYTE $A0,$B2,$B2,$A7,$A8,$B1,$D9,$00 ; Wooden Nunchucks
Weapon2:
.byte $9C,$B0,$A4,$AF,$AF,$FF,$D6,$00 ; Small Knife
Weapon3:
.byte $A0,$B2,$B2,$A7,$A8,$B1,$D8,$00 ; Wooden Staff
Weapon4:
.byte $9B,$A4,$B3,$AC,$A8,$B5,$FF,$00 ; Rapier
Weapon5:
.byte $92,$B5,$B2,$B1,$FF,$FF,$D5,$00 ; Iron Hammer
Weapon6:
.byte $9C,$AB,$B2,$B5,$B7,$FF,$D4,$00 ; Short Sword
Weapon7:
.byte $91,$A4,$B1,$A7,$FF,$FF,$D7,$00 ; Hand Axe
Weapon8:
.byte $9C,$A6,$AC,$B0,$B7,$A4,$B5,$00 ; Scimitar
Weapon9: 
.byte $92,$B5,$B2,$B1,$FF,$FF,$D9,$00 ; Iron Nunchucks
Weapon10:
.byte $95,$A4,$B5,$AA,$A8,$FF,$D6,$00 ; Large Knife
Weapon11:
.byte $92,$B5,$B2,$B1,$FF,$FF,$D8,$00 ; Iron Staff
Weapon12:
.byte $9C,$A4,$A5,$B5,$A8,$FF,$FF,$00 ; Sabre
Weapon13:
.byte $95,$B2,$B1,$AA,$FF,$FF,$D4,$00 ; Long Sword
Weapon14:
.byte $90,$B5,$A8,$A4,$B7,$FF,$D7,$00 ; Great Axe
Weapon15:
.byte $8F,$A4,$AF,$A6,$AB,$B2,$B1,$00 ; Falchion
Weapon16:
.byte $9C,$AC,$AF,$B9,$A8,$B5,$D6,$00 ; Silver Knife
Weapon17:
.byte $9C,$AC,$AF,$B9,$A8,$B5,$D4,$00 ; Silver Sword
Weapon18:
.byte $9C,$AC,$AF,$B9,$A8,$B5,$D5,$00 ; Silver Hammer
Weapon19:
.byte $9C,$AC,$AF,$B9,$A8,$B5,$D7,$00 ; Silver Axe
Weapon20:
.byte $8F,$AF,$A4,$B0,$A8,$FF,$D4,$00 ; Flame Sword
Weapon21:
.byte $92,$A6,$A8,$FF,$FF,$FF,$D4,$00 ; Ice Sword
Weapon22:
.byte $8D,$B5,$A4,$AA,$B2,$B1,$D4,$00 ; Dragon Sword
Weapon23:
.byte $90,$AC,$A4,$B1,$B7,$FF,$D4,$00 ; Giant Sword
Weapon24:
.byte $9C,$B8,$B1,$FF,$FF,$FF,$D4,$00 ; Sun Sword
Weapon25: 
.byte $8C,$B2,$B5,$A4,$AF,$FF,$D4,$00 ; Coral Sword
Weapon26:
.byte $A0,$A8,$B5,$A8,$FF,$FF,$D4,$00 ; Were Sword
Weapon27:
.byte $9B,$B8,$B1,$A8,$FF,$FF,$D4,$00 ; Rune Sword
Weapon28:
.byte $99,$B2,$BA,$A8,$B5,$FF,$D8,$00 ; Power Staff
Weapon29:
.byte $95,$AC,$AA,$AB,$B7,$FF,$D7,$00 ; Light Axe
Weapon30:
.byte $91,$A8,$A4,$AF,$FF,$FF,$D8,$00 ; Heal Staff
Weapon31:
.byte $96,$A4,$AA,$A8,$FF,$FF,$D8,$00 ; Mage Staff
Weapon32:
.byte $8D,$A8,$A9,$A8,$B1,$B6,$A8,$00 ; Defense Sword
Weapon33:
.byte $A0,$AC,$BD,$A4,$B5,$A7,$D8,$00 ; Wizard Staff
Weapon34:
.byte $9F,$B2,$B5,$B3,$A4,$AF,$FF,$00 ; Vorpal Sword
Weapon35:
.byte $8C,$A4,$B7,$8C,$AF,$A4,$BA,$00 ; CatClaw
Weapon36:
.byte $9D,$AB,$B2,$B5,$FF,$FF,$D5,$00 ; Thor Hammer
Weapon37:
.byte $8B,$A4,$B1,$A8,$FF,$FF,$D4,$00 ; Bane Sword
Weapon38:
.byte $94,$A4,$B7,$A4,$B1,$A4,$FF,$00 ; Katana
Weapon39:
.byte $A1,$A6,$A4,$AF,$A5,$A8,$B5,$00 ; Excalibur
Weapon40:
.byte $96,$A4,$B6,$B0,$B8,$B1,$A8,$00 ; Masamune


Armor1: 
.byte $8C,$AF,$B2,$B7,$AB,$FF,$FF,$00 ; Cloth T
Armor2:
.byte $A0,$B2,$B2,$A7,$A8,$B1,$DA,$00 ; Wooden Armor
Armor3:
.byte $8C,$AB,$A4,$AC,$B1,$FF,$DA,$00 ; Chain Armor
Armor4:
.byte $92,$B5,$B2,$B1,$FF,$FF,$DA,$00 ; Iron Armor
Armor5:
.byte $9C,$B7,$A8,$A8,$AF,$FF,$DA,$00 ; Steel Armor
Armor6:
.byte $9C,$AC,$AF,$B9,$A8,$B5,$DA,$00 ; Silver Armor
Armor7:
.byte $8F,$AF,$A4,$B0,$A8,$FF,$DA,$00 ; Flame Armor
Armor8:
.byte $92,$A6,$A8,$FF,$FF,$FF,$DA,$00 ; Ice Armor
Armor9: 
.byte $98,$B3,$A4,$AF,$FF,$FF,$DA,$00 ; Opal Armor
Armor10:
.byte $8D,$B5,$A4,$AA,$B2,$B1,$DA,$00 ; Dragon Armor
Armor11:
.byte $8C,$B2,$B3,$B3,$A8,$B5,$DE,$00 ; Copper Q
Armor12:
.byte $9C,$AC,$AF,$B9,$A8,$B5,$DE,$00 ; Silver Q
Armor13:
.byte $90,$B2,$AF,$A7,$FF,$FF,$DE,$00 ; Gold Q
Armor14:
.byte $98,$B3,$A4,$AF,$FF,$FF,$DE,$00 ; Opal Q
Armor15:
.byte $A0,$AB,$AC,$B7,$A8,$FF,$DF,$00 ; White T
Armor16:
.byte $8B,$AF,$A4,$A6,$AE,$FF,$DF,$00 ; Black T
Armor17:
.byte $A0,$B2,$B2,$A7,$A8,$B1,$DB,$00 ; Wooden Shield
Armor18:
.byte $92,$B5,$B2,$B1,$FF,$FF,$DB,$00 ; Iron Shield
Armor19:
.byte $9C,$AC,$AF,$B9,$A8,$B5,$DB,$00 ; Silver Shield
Armor20:
.byte $8F,$AF,$A4,$B0,$A8,$FF,$DB,$00 ; Flame Shield
Armor21:
.byte $92,$A6,$A8,$FF,$FF,$FF,$DB,$00 ; Ice Shield
Armor22:
.byte $98,$B3,$A4,$AF,$FF,$FF,$DB,$00 ; Opal Shield
Armor23:
.byte $8A,$A8,$AA,$AC,$B6,$FF,$DB,$00 ; Aegis Shield
Armor24:
.byte $8B,$B8,$A6,$AE,$AF,$A8,$B5,$00 ; Buckler
Armor25:
.byte $99,$B5,$B2,$8C,$A4,$B3,$A8,$00 ; Protect Cape
Armor26:
.byte $8C,$A4,$B3,$FF,$FF,$FF,$FF,$00 ; Cap
Armor27:
.byte $A0,$B2,$B2,$A7,$A8,$B1,$DC,$00 ; Wooden Helm
Armor28:
.byte $92,$B5,$B2,$B1,$FF,$FF,$DC,$00 ; Iron Helm
Armor29:
.byte $9C,$AC,$AF,$B9,$A8,$B5,$DC,$00 ; Silver Helm
Armor30:
.byte $98,$B3,$A4,$AF,$FF,$FF,$DC,$00 ; Opal Helm
Armor31:
.byte $91,$A8,$A4,$AF,$FF,$FF,$DC,$00 ; Heal Helm
Armor32:
.byte $9B,$AC,$A5,$A5,$B2,$B1,$FF,$00 ; Ribbon
Armor33:
.byte $90,$AF,$B2,$B9,$A8,$B6,$FF,$00 ; Gloves
Armor34:
.byte $8C,$B2,$B3,$B3,$A8,$B5,$DD,$00 ; Copper Gauntlet
Armor35:
.byte $92,$B5,$B2,$B1,$FF,$FF,$DD,$00 ; Iron Gauntlet
Armor36:
.byte $9C,$AC,$AF,$B9,$A8,$B5,$DD,$00 ; Silver Gauntlet
Armor37:
.byte $A3,$A8,$B8,$B6,$FF,$FF,$DD,$00 ; Zeus Gauntlet
Armor38:
.byte $99,$B2,$BA,$A8,$B5,$FF,$DD,$00 ; Power Gauntlet
Armor39:
.byte $98,$B3,$A4,$AF,$FF,$FF,$DD,$00 ; Opal Gauntlet
Armor40:  
.byte $99,$B5,$B2,$9B,$AC,$B1,$AA,$00 ; Protect Ring

;gold in chests
;; Note this is only the text data. Actual amount given is in the price list at the start of Bank 9
MoneyChest1:
.byte $81,$80,$FF,$99,$00 ; 10 
MoneyChest2:
.byte $82,$80,$FF,$99,$00 ; 20 
MoneyChest3:
.byte $82,$85,$FF,$99,$00 ; 25
MoneyChest4:
.byte $83,$80,$FF,$90,$00 ; 30
MoneyChest5:
.byte $85,$85,$FF,$99,$00 ; 55
MoneyChest6:
.byte $87,$80,$FF,$99,$00 ; 70
MoneyChest7:
.byte $88,$85,$FF,$99,$00 ; 85
MoneyChest8:
.byte $81,$81,$80,$FF,$99,$00 ; 110
MoneyChest9:
.byte $81,$83,$85,$FF,$99,$00 ; 135
MoneyChest10:
.byte $81,$85,$85,$FF,$99,$00 ; 155
MoneyChest11:
.byte $81,$86,$80,$FF,$99,$00 ; 160
MoneyChest12:
.byte $81,$88,$80,$FF,$99,$00 ; 180
MoneyChest13:
.byte $82,$84,$80,$FF,$99,$00 ; 240
MoneyChest14:
.byte $82,$85,$85,$FF,$99,$00 ; 255
MoneyChest15:
.byte $82,$86,$80,$FF,$99,$00 ; 260
MoneyChest16:
.byte $82,$89,$85,$FF,$99,$00 ; 295
MoneyChest17:
.byte $83,$80,$80,$FF,$99,$00 ; 300
MoneyChest18:
.byte $83,$81,$85,$FF,$99,$00 ; 315
MoneyChest19:
.byte $83,$83,$80,$FF,$99,$00 ; 330
MoneyChest20:
.byte $83,$85,$80,$FF,$99,$00 ; 350
MoneyChest21:
.byte $83,$88,$85,$FF,$99,$00 ; 385
MoneyChest22:
.byte $84,$80,$80,$FF,$99,$00 ; 400
MoneyChest23:
.byte $84,$85,$80,$FF,$99,$00 ; 450
MoneyChest24:
.byte $85,$80,$80,$FF,$99,$00 ; 500
MoneyChest25:
.byte $85,$83,$80,$FF,$99,$00 ; 530
MoneyChest26:
.byte $85,$87,$85,$FF,$99,$00 ; 575
MoneyChest27:
.byte $86,$82,$80,$FF,$99,$00 ; 620
MoneyChest28:
.byte $86,$88,$80,$FF,$99,$00 ; 680
MoneyChest29:
.byte $87,$85,$80,$FF,$99,$00 ; 750
MoneyChest30:
.byte $87,$89,$85,$FF,$99,$00 ; 795
MoneyChest31:
.byte $88,$88,$80,$FF,$99,$00 ; 880
MoneyChest32:
.byte $81,$80,$82,$80,$FF,$99,$00 ; 1020
MoneyChest33:
.byte $81,$82,$85,$80,$FF,$99,$00 ; 1250
MoneyChest34:
.byte $81,$84,$85,$85,$FF,$99,$00 ; 1455
MoneyChest35:
.byte $81,$85,$82,$80,$FF,$99,$00 ; 1520
MoneyChest36:
.byte $81,$87,$86,$80,$FF,$99,$00 ; 1760
MoneyChest37:
.byte $81,$89,$87,$85,$FF,$99,$00 ; 1975
MoneyChest38:
.byte $82,$80,$80,$80,$FF,$90,$00 ; 2000
MoneyChest39:
.byte $82,$87,$85,$80,$FF,$99,$00 ; 2750
MoneyChest40:
.byte $83,$84,$80,$80,$FF,$99,$00 ; 3400
MoneyChest41:
.byte $84,$81,$85,$80,$FF,$99,$00 ; 4150
MoneyChest42:
.byte $85,$80,$80,$80,$FF,$99,$00 ; 5000
MoneyChest43:
.byte $85,$84,$85,$80,$FF,$99,$00 ; 5450
MoneyChest44:
.byte $86,$84,$80,$80,$FF,$99,$00 ; 6400
MoneyChest45:
.byte $86,$87,$82,$80,$FF,$99,$00 ; 6720
MoneyChest46:
.byte $87,$83,$84,$80,$FF,$99,$00 ; 7340
MoneyChest47:
.byte $87,$86,$89,$80,$FF,$99,$00 ; 7690
MoneyChest48:
.byte $87,$89,$80,$80,$FF,$99,$00 ; 7900
MoneyChest49:
.byte $88,$81,$83,$85,$FF,$99,$00 ; 8135
MoneyChest50:
.byte $89,$80,$80,$80,$FF,$99,$00 ; 9000
MoneyChest51:
.byte $89,$83,$80,$80,$FF,$99,$00 ; 9300
MoneyChest52:
.byte $89,$85,$80,$80,$FF,$99,$00 ; 9500
MoneyChest53:
.byte $89,$89,$80,$80,$FF,$99,$00 ; 9900
MoneyChest54:
.byte $81,$80,$80,$80,$80,$FF,$99,$00 ; 10000
MoneyChest55:
.byte $81,$82,$83,$85,$80,$FF,$99,$00 ; 12350
MoneyChest56:
.byte $81,$83,$80,$80,$80,$FF,$99,$00 ; 13000
MoneyChest57:
.byte $81,$83,$84,$85,$80,$FF,$99,$00 ; 13450
MoneyChest58:
.byte $81,$84,$80,$85,$80,$FF,$99,$00 ; 14050
MoneyChest59:
.byte $81,$84,$87,$82,$80,$FF,$99,$00 ; 14720
MoneyChest60:
.byte $81,$85,$80,$80,$80,$FF,$99,$00 ; 15000
MoneyChest61:
.byte $81,$87,$84,$89,$80,$FF,$99,$00 ; 17490
MoneyChest62:
.byte $81,$88,$80,$81,$80,$FF,$99,$00 ; 18010
MoneyChest63:
.byte $81,$89,$89,$89,$80,$FF,$99,$00 ; 19990
MoneyChest64:
.byte $82,$80,$80,$80,$80,$FF,$99,$00 ; 20000
MoneyChest65:
.byte $82,$80,$80,$81,$80,$FF,$99,$00 ; 20010
MoneyChest66:
.byte $82,$86,$80,$80,$80,$FF,$99,$00 ; 26000
MoneyChest67:
.byte $84,$85,$80,$80,$80,$FF,$99,$00 ; 45000
MoneyChest68:
.byte $86,$85,$80,$80,$80,$FF,$99,$00 ; 65000



 
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



;CLASSNAMES:
CLASS1:
.byte $8F,$92,$90,$91,$9D,$8E,$9B,$00 ; FIGHTER
CLASS2:
.byte $9D,$91,$92,$8E,$8F,$FF,$FF,$00 ; _THIEF_ ; JIGS - moved a space to the start to center it
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
.byte $97,$92,$97,$93,$8A,$FF,$FF,$00 ; _NINJA_ ; JIGS - moved a space to the start to center it
CLASS9:
.byte $96,$8A,$9C,$9D,$8E,$9B,$FF,$00 ; MASTER_
CLASS10:
.byte $9B,$A8,$A7,$A0,$AC,$BD,$FF,$00 ; RedWiz_
CLASS11:
.byte $A0,$AB,$C0,$A0,$AC,$BD,$FF,$00 ; Wh.Wiz_
CLASS12:
.byte $8B,$AF,$C0,$A0,$AC,$BD,$FF,$00 ; Bl.Wiz_

;; This stuff is no longer needed.
;; Battle things, HP, Stone, Poison?
;; Basically, I sorted all the ailments into single tile icons and re-wrote the code that displays them all.
;; This made room for some more tiles in the font graphics, and there's some blanks in there too!

;.byte $91,$99,$FF,$00,$FF,$FF,$FF,$00 ; HP_ ; ___
;.byte $9C,$9D,$FF,$00,$99,$98,$FF,$00 ; ST_ ; PO_
;.byte $99,$98,$FF,$00,$97,$8E,$8D,$00 ; PO_ ; NED
;.byte $99,$98,$92,$9C,$98,$97,$00     ; POISON

;.byte $1A,$1B,$1C,$1D,$1E,$1F,$20,$21,$22,$23,$24,$25,$26,$27
;.byte $28,$29,$2A,$2B,$2C,$2D,$2E,$2F,$30,$31,$32,$33,$34,$35,$36,$37
;.byte $38,$39,$3A,$3B,$3C,$3D,$3E,$3F,$40,$41,$42,$43,$44,$45,$46,$47
;.byte $48,$49,$4A,$4B,$4C,$4D,$4E,$4F,$50,$51,$52,$53,$14,$55,$56,$57

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
.word BTL_MESSAGE78 ; there are only this many Battle Messages in Constants.inc
.word BTL_MESSAGE79 ; So these last 3 are all blank. As is 57 and 58 ($39 and $3A), and yet another is just 4 blank spaces...?
.word BTL_MESSAGE80 ; You have a few to work with before needing to make more! 
.word BTL_MESSAGE81 ; however, I'm hijacking < this one for a Thief gold stealing message, because I can't print custom ones from Bank Z without crashing the game...
  
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
.byte $97,$A8,$B8,$B7,$B5,$A4,$AF,$AC,$BD,$A8,$A7,$00 ; Neutralized
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
.byte $96,$B2,$B1,$B6,$B7,$A8,$B5,$B6,$FF,$B6,$B7,$B5,$AC,$AE,$A8,$FF,$A9,$AC,$B5,$B6,$B7,$00 ; Monsters strike first
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
.byte $99,$A4,$B5,$A4,$AF,$BC,$BD,$A8,$A7,$00 ; Paralyzed
BTL_MESSAGE43:
.byte $91,$AC,$B7,$B6,$C4,$FF,$FF,$FF,$00 ; Hits!___ 
BTL_MESSAGE44:
.byte $8C,$B5,$AC,$B7,$AC,$A6,$A4,$AF,$FF,$AB,$AC,$B7,$C4,$C4,$00 ; Critical hit!!
BTL_MESSAGE45:
.byte $96,$A4,$AA,$AC,$A6,$FF,$A5,$AF,$B2,$A6,$AE,$A8,$A7,$00 ; Magic blocked
BTL_MESSAGE46:
.byte $8D,$96,$90,$00 ; DMG
BTL_MESSAGE47:
.byte $9C,$B7,$B2,$B3,$B3,$A8,$A7,$00 ; Stopped
BTL_MESSAGE48:
.byte $95,$A8,$B9,$C0,$FF,$B8,$B3,$C4,$00 ; Lev. up!
BTL_MESSAGE49:
.byte $91,$99,$FF,$B0,$A4,$BB,$00 ; HP max
BTL_MESSAGE50:
.byte $B3,$B7,$B6,$C0,$00 ; pts.
BTL_MESSAGE51:
.byte $9C,$B7,$B5,$C0,$00 ; Str.
BTL_MESSAGE52:
.byte $8A,$AA,$AC,$C0,$00 ; Agi.
BTL_MESSAGE53:
.byte $92,$B1,$B7,$C0,$00 ; Int.
BTL_MESSAGE54:
.byte $9F,$AC,$B7,$C0,$00 ; Vit.
BTL_MESSAGE55:
.byte $95,$B8,$A6,$AE,$00 ; Luck
BTL_MESSAGE56:
.byte $FF,$B8,$B3,$00 ;  up
BTL_MESSAGE57:
.byte $00 ; 
BTL_MESSAGE58:
.byte $00 ; 
BTL_MESSAGE59:
.byte $FF,$A7,$B2,$BA,$B1,$00 ; down
BTL_MESSAGE60:
.byte $B3,$A8,$B5,$AC,$B6,$AB,$A8,$A7,$00 ; perished
BTL_MESSAGE61:
.byte $96,$B2,$B1,$B6,$B7,$A8,$B5,$B6,$FF,$00 ; Monsters_
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
.byte $8E,$A1,$99,$FF,$B8,$B3,$00 ; EXP up
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
.byte $00 ; 
BTL_MESSAGE80:
.byte $9B,$A8,$AA,$A8,$B1,$A8,$B5,$A4,$B7,$A8,$A7,$FF,$91,$99,$00 ; Regenerated HP ; JIGS - added this
BTL_MESSAGE81:
.byte $9C,$B7,$B2,$AF,$A8,$C1,$AA,$B2,$AF,$A7,$C4,$00  ; Stole gold! ; JIGS - added this

;; original pointers here. What a mess.
;.byte $40,$8C,$47,$8C,$50,$8C,$5E,$8C,$65,$8C,$71,$8C,$81,$8C,$8A,$8C
;.byte $9B,$8C,$A4,$8C,$B5,$8C,$C7,$8C,$D3,$8C,$E1,$8C,$ED,$8C,$FE,$8C
;.byte $0A,$8D,$1C,$8D,$27,$8D,$30,$8D,$39,$8D,$40,$8D,$50,$8D,$5A,$8D
;.byte $62,$8D,$6F,$8D,$82,$8D,$9A,$8D,$A5,$8D,$B1,$8D,$BE,$8D,$D5,$8D
;.byte $DC,$8D,$E8,$8D,$FF,$8D,$15,$8E,$1F,$8E,$28,$8E,$35,$8E,$3D,$8E
;.byte $46,$8E,$4D,$8E,$57,$8E,$60,$8E,$6F,$8E,$7D,$8E,$81,$8E,$89,$8E
;.byte $92,$8E,$99,$8E,$9E,$8E,$A3,$8E,$A8,$8E,$AD,$8E,$B2,$8E,$B7,$8E
;.byte $BB,$8E,$BC,$8E,$BD,$8E,$C3,$8E,$CC,$8E,$D6,$8E,$DE,$8E,$E9,$8E
;.byte $F1,$8E,$F6,$8E,$FB,$8E,$00,$8F,$05,$8F,$0A,$8F,$0F,$8F,$14,$8F
;.byte $19,$8F,$20,$8F,$30,$8F,$38,$8F,$3F,$8F,$EC,$8F
    
        ; pointer table
   ;    data_BattleMessages = data_BattleMessages_Raw + $310
   ;; JIGS - putting the pointers at the top...

;; $8FEC - unused space ;; JIGS - not true... this is "Nothing happens" for some reason.

  ;.BYTE $97, $B2, $B7, $AB,   $AC, $B1, $AA, $FF,   $AB, $A4, $B3, $B3,   $A8, $B1, $B6, $00,   $00, $00, $00, $00






 ;; JIGS - Item prices moved here. 
 ;; You can use normal numbers to set the price if you use .word, as exampled by Heal and Pure below
 ;; Just don't go over 65535! 
;                      297000 - the cost of 99 houses... for reference...
.ALIGN  $100

lut_ItemPrices:
.byte $00,$00 ; START
.WORD 0060    ; HEAL
.WORD 0075    ; PURE
.byte $20,$03 ; SOFT
.byte $4B,$00 ; TENT
.byte $FA,$00 ; CABIN
.byte $B8,$0B ; HOUSE
.byte $00,$00 ; LUTE
.byte $00,$00 ; CROWN
.byte $00,$00 ; CRYSTAL
.byte $00,$00 ; HERB
.byte $00,$00 ; KEY
.byte $00,$00 ; TNT
.byte $00,$00 ; ADAMANT
.byte $00,$00 ; SLAB
.byte $00,$00 ; RUBY 
.byte $00,$00 ; ROD
.byte $00,$00 ; FLOATER
.byte $00,$00 ; CHIME
.byte $00,$00 ; TAIL
.byte $00,$00 ; CUBE
.byte $50,$C3 ; BOTTLE
.byte $00,$00 ; OXYALE
.byte $00,$00 ; CANOE
.byte $00,$00 ; ORB 1
.byte $00,$00 ; ORB 2
.byte $00,$00 ; ORB 3
.byte $00,$00 ; ORB 4
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
;.byte $0A,$00 ; gold in chests
;.byte $14,$00
;.byte $19,$00
;.byte $1E,$00
;.byte $37,$00
;.byte $46,$00
;.byte $55,$00
;.byte $6E,$00
;.byte $87,$00
;.byte $9B,$00
;.byte $A0,$00
;.byte $B4,$00
;.byte $F0,$00
;.byte $FF,$00
;.byte $04,$01
;.byte $27,$01
;.byte $2C,$01
;.byte $3B,$01
;.byte $4A,$01
;.byte $5E,$01
;.byte $81,$01
;.byte $90,$01
;.byte $C2,$01
;.byte $F4,$01
;.byte $12,$02
;.byte $3F,$02
;.byte $6C,$02
;.byte $A8,$02
;.byte $EE,$02
;.byte $1B,$03
;.byte $70,$03
;.byte $FC,$03
;.byte $E2,$04
;.byte $AF,$05
;.byte $F0,$05
;.byte $E0,$06
;.byte $B7,$07
;.byte $D0,$07
;.byte $BE,$0A
;.byte $48,$0D
;.byte $36,$10
;.byte $88,$13
;.byte $4A,$15
;.byte $00,$19
;.byte $40,$1A
;.byte $AC,$1C
;.byte $0A,$1E
;.byte $DC,$1E
;.byte $C7,$1F
;.byte $28,$23
;.byte $54,$24
;.byte $1C,$25
;.byte $AC,$26
;.byte $10,$27
;.byte $3E,$30
;.byte $C8,$32
;.byte $8A,$34
;.byte $E2,$36
;.byte $80,$39
;.byte $98,$3A
;.byte $52,$44
;.byte $5A,$46
;.byte $16,$4E
;.byte $20,$4E
;.byte $2A,$4E
;.byte $90,$65
;.byte $C8,$AF
;.byte $E8,$FD
;; Commenting out, but leaving the original hex bytes in for reference/backup.
.word  0010 ; 1 Gold in chests
.word  0020 ; 2
.word  0025 ; 3
.word  0030 ; 4
.word  0055 ; 5
.word  0070 ; 6
.word  0085 ; 7
.word  0110 ; 8
.word  0135 ; 9
.word  0155 ; 10
.word  0160 ; 11
.word  0180 ; 12
.word  0240 ; 13
.word  0255 ; 14
.word  0260 ; 15
.word  0295 ; 16
.word  0300 ; 17
.word  0315 ; 18
.word  0330 ; 19
.word  0350 ; 20
.word  0385 ; 21
.word  0400 ; 22
.word  0450 ; 23
.word  0500 ; 
.word  0530 ; 
.word  0575 ; 
.word  0620 ; 
.word  0680 ; 
.word  0750 ; 
.word  0795 ; 
.word  0880 ; 
.word  1020 ;
.word  1250 ;
.word  1455 ;
.word  1520 ;
.word  1760 ;
.word  1975 ;
.word  2000 ;
.word  2750 ;
.word  3400 ;
.word  4150 ;
.word  5000 ;
.word  5450 ;
.word  6400 ;
.word  6720 ;
.word  7340 ;
.word  7690 ;
.word  7900 ;
.word  8135 ;
.word  9000 ;
.word  9300 ;
.word  9500 ;
.word  9900 ;
.word  10000 ;
.word  12350 ;
.word  13000 ;
.word  13450 ;
.word  14050 ;
.word  14720 ;
.word  15000 ;
.word  17490 ;
.word  18010 ;
.word  19990 ;
.word  20000 ;
.word  20010 ;
.word  26000 ;
.word  45000 ;
.word  65000 ;
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
 







  
  
  
 ;; JIGS - here's Enemy AI data. Since Bank A is so spacey without dialogue and Bank C is pretty tight...
 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  LUT for Enemy AI [$9020 :: 0x31030]
;;
;;    $10 bytes per AI
;;
;;  byte      0 = chance to cast spell         ($00-80)
;;  byte      1 = chance to use special attack ($00-80)
;;  bytes   2-9 = magic spells available.  Each entry 0-based.  Or 'FF' to mark end of spells
;;  bytes $B-$E = special attacks (0 based), or 'FF' to mark end of attacks
 
 lut_EnemyAi:
  ;.INCBIN "bin/0C_9020_aidata.bin"
  
;      0   1   2   3   4   5   6   7   8   9   A   B   C   D   E   F  
.byte $00,$20,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$00,$00,$00,$00,$FF ; 00 ; Frost Wolf
.byte $00,$20,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$01,$01,$01,$01,$FF ; 01 ; Agama
.byte $00,$40,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$02,$02,$02,$02,$FF ; 02 ; Sauria
.byte $00,$80,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$03,$03,$03,$03,$FF ; 03 ; OddEYE
.byte $00,$40,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$03,$04,$03,$04,$FF ; 04 ; BigEYE
.byte $00,$40,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$05,$05,$05,$05,$FF ; 05 ; Cerberus
.byte $40,$00,$03,$0D,$05,$15,$1F,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF ; 06 ; WzOgre
.byte $00,$40,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$06,$06,$06,$06,$FF ; 07 ; Sand Worm
.byte $50,$50,$3F,$35,$2D,$16,$15,$09,$0F,$05,$FF,$02,$07,$03,$08,$FF ; 08 ; EYE
.byte $40,$40,$3D,$3E,$3B,$35,$2D,$15,$09,$0F,$FF,$09,$09,$09,$09,$FF ; 09 ; PHANTOM
.byte $60,$00,$14,$0F,$0D,$05,$04,$07,$00,$05,$FF,$FF,$FF,$FF,$FF,$FF ; 0A ; Mancat
.byte $00,$20,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$17,$17,$17,$17,$FF ; 0B ; Vampire
.byte $20,$20,$12,$09,$1F,$1F,$16,$16,$14,$14,$FF,$17,$17,$17,$17,$FF ; 0C ; WzVamp
.byte $40,$00,$14,$15,$04,$04,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF ; 0D ; Red Gargoyle
.byte $00,$40,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$0A,$0A,$0A,$FF,$FF ; 0E ; Frost Dragon
.byte $00,$40,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$0B,$0B,$0B,$FF,$FF ; 0F ; Red Dragon
.byte $00,$20,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$07,$07,$07,$07,$FF ; 10 ; Perelist
.byte $00,$40,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$0D,$0D,$FF,$FF,$FF ; 11 ; Red Hydra
.byte $60,$00,$16,$15,$0F,$0D,$07,$06,$05,$07,$FF,$FF,$FF,$FF,$FF,$FF ; 12 ; Naga
.byte $60,$00,$03,$09,$0F,$0D,$05,$04,$07,$13,$FF,$FF,$FF,$FF,$FF,$FF ; 13 ; Grey Naga
.byte $00,$40,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$0D,$0D,$0D,$FF,$FF ; 14 ; Chimera
.byte $00,$40,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$0D,$0E,$0D,$0E,$FF ; 15 ; Jimera
.byte $00,$40,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$0F,$0F,$0F,$0F,$FF ; 16 ; Sorcerer
.byte $00,$40,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$10,$10,$10,$FF,$FF ; 17 ; Gas Dragon
.byte $00,$40,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$11,$11,$11,$FF,$FF ; 18 ; Blue Dragon
.byte $20,$00,$1D,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF ; 19 ; Mug Golem
.byte $30,$00,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$FF,$FF,$FF,$FF,$FF,$FF ; 1A ; Rock Golem
.byte $00,$10,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$12,$12,$12,$12,$FF ; 1B ; Iron Golem
.byte $20,$00,$3B,$3C,$3B,$3F,$37,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF ; 1C ; Badman
.byte $40,$00,$2D,$2C,$24,$25,$27,$24,$2F,$2C,$FF,$FF,$FF,$FF,$FF,$FF ; 1D ; Mage
.byte $30,$00,$3A,$3B,$33,$2A,$2B,$30,$23,$20,$FF,$FF,$FF,$FF,$FF,$FF ; 1E ; Fighter
.byte $00,$20,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$13,$13,$13,$13,$FF ; 1F ; Nitemare
.byte $00,$20,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$14,$14,$14,$14,$FF ; 20 ; WarMech
.byte $00,$40,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$16,$16,$16,$16,$FF ; 21 ; Manticor
.byte $60,$00,$1F,$1C,$1D,$16,$15,$14,$0F,$05,$FF,$FF,$FF,$FF,$FF,$FF ; 22 ; Lich
.byte $60,$00,$3C,$3D,$3E,$3F,$3C,$3D,$3E,$3F,$FF,$FF,$FF,$FF,$FF,$FF ; 23 ; Lich Reprise
.byte $30,$00,$14,$0D,$14,$0D,$14,$15,$14,$15,$FF,$FF,$FF,$FF,$FF,$FF ; 24 ; Kary
.byte $30,$00,$24,$2D,$24,$2D,$24,$2F,$24,$2F,$FF,$FF,$FF,$FF,$FF,$FF ; 25 ; Kary Reprise
.byte $00,$20,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$15,$15,$15,$15,$FF ; 26 ; Kraken
.byte $30,$20,$16,$16,$16,$16,$16,$16,$16,$16,$FF,$15,$15,$15,$15,$FF ; 27 ; Kraken Reprise
.byte $00,$40,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$11,$10,$0A,$0B,$FF ; 28 ; Tiamat
.byte $40,$40,$25,$1F,$16,$14,$25,$1F,$16,$14,$FF,$11,$10,$0A,$0B,$FF ; 29 ; Tiamat Reprise
.byte $40,$40,$34,$2C,$27,$30,$24,$1F,$1D,$3C,$FF,$06,$0C,$18,$19,$FF ; 2A ; Chaos
.byte $60,$00,$2D,$27,$1D,$14,$16,$0F,$0D,$05,$FF,$FF,$FF,$FF,$FF,$FF ; 2B ; Astos

;; From the FF Bytes documents 
;  ##   Strat.   (Magics and Magic Cycle : Attack and Attack Cycle)
;  00 = FrWOLF 	(: FROST)
;  01 = AGAMA 	(: HEAT)
;  02 = SAURIA 	(: GLANCE)
;  03 = OddEYE 	(: GAZE)
;  04 = BigEYE 	(: GAZE, FLASH)
;  05 = CERBERUS	(: SCORCH)
;  06 = WzOGRE	(RUSE, DARK, SLEP, HOLD, ICE2)
;  07 = Sand W	(: CRACK)
;  08 = EYE	(XXXX, BRAK, RUB, LIT2, HOLD, MUTE, SLOW, SLEP : GLANCE, SQUINT, GAZE, STARE)
;  09 = PHANTOM	(STOP, ZAP!, XFER, BRAK, RUB, HOLD, MUTE, SLOW : GLARE)
;  0A = MANCAT	(FIR2, SLOW, DARK, SLEP, FIRE, LIT, CURE, SLEP)
;  0B = VAMPIRE	(: DAZZLE)
;  0C = WzVAMP	(AFIR, MUTE, ICE2[*2], LIT2[*2], FIR2[*2] : DAZZLE)
;  0D = R`GOYLE	(FIR2, HOLD, FIRE[*2])
;  0E = Frost D	(: BLIZZARD)
;  0F = Red D	(: BLAZE)
;  10 = PERELISK	(: SQUINT)
;  11 = R`HYDRA	(: CREMATE)
;  12 = NAGA	(LIT2, LOCK, SLEP, LIT, LIT2, HOLD, SLOW, DARK)
;  13 = GrNAGA	(RUSE, MUTE, SLOW, DARK, SLEP, FIRE, LIT, HEAL)
;  14 = CHIMERA	(: CREMATE)
;  15 = JIMERA	(: CREMATE, POISON(pos))
;  16 = SORCERER	(: TRANCE)
;  17 = Gas D	(: POISON(dmg))
;  18 = Blue D	(: THUNDER)
;  19 = MudGOL	(FAST)
;  1A = RockGOL	(SLOW)
;  1B = IronGOL	(: TOXIC)
;  1C = BADMAN	(XFER, NUKE, XFER, XXXX, BLND)
;  1D = MAGE	(RUB, LIT3 ,FIR3 ,BANE, SLO2, FIR3, STUN, LIT3)
;  1E = FIGHTER	(WALL, XFER, HEL3, FOG2, INV2, CUR4 ,HEL2, CUR3)
;  1F = NITEMARE (: SNORTING)
;  20 = WarMECH	(: NUCLEAR)
;  21 = MANTICOR	(: STINGER) 
;  22 = LICH	(ICE2, SLP2, FAST, LIT2, HOLD, FIR2, SLOW, SLEP)
;  23 = LICH 2	(NUKE, STOP, ZAP!, XXXX)
;  24 = KARY	(FIR2, DARK, FIR2, DARK, FIR2, HOLD, FIR2, HOLD)
;  25 = KARY 2	(FIR3, RUB)
;  26 = KRAKEN	(: INK)
;  27 = KRAKEN 2 (LIT2 : INK)
;  28 = TIAMAT	(: THUNDER, POISON(dmg), BLIZZARD, BLAZE)
;  29 = TIAMAT 2 (BANE, ICE2, LIT2, FIR2 : THUNDER, POISON(dmg), BLIZZARD, BLAZE)
;  2A = CHAOS	(ICE3, LIT3, SLO2, CUR4, FIR3, ICE2, FAST, NUKE : CRACK, INFERNO, SWIRL, TORNADO)
;  2B = ASTOS	(RUB, SLO2, FAST, FIR2, LIT2, SLOW, DARK, SLEP)
;  FF = None  
  
 
  

.byte "END OF BANK A"