.include "Constants.inc"
.include "variables.inc"
.include "macros.inc"
.feature force_range

.export lut_EntrTele_X
.export lut_EntrTele_Y
.export lut_EntrTele_Map
.export lut_ExitTele_X
.export lut_ExitTele_Y
.export lut_Tilesets
.export lut_NormTele_X
.export lut_NormTele_Y
.export lut_NormTele_Map
.export lut_MapObjGfx
.export lut_ClassStartingStats
.export lut_Treasure
.export lut_Treasure_2
;;.export lut_BackdropPal
;;.export lut_BtlBackdrops
.export lut_MapObjects

.segment "BANK_13"

BANK_THIS = $13

; Map sprite picture assignment

lut_MapObjGfx:
.byte $00 ; 00 ; Princess
.byte $0F ; 01 ; King
.byte $12 ; 02 ; Garland
.byte $00 ; 03 ; Princess
.byte $13 ; 04 ; Pirate
.byte $18 ; 05 ; Elf Woman (Doctor)
.byte $1A ; 06 ; Elf Prince
.byte $0F ; 07 ; King (Astos)
.byte $0C ; 08 ; Dwarf
.byte $0C ; 09 ; Dwarf
.byte $05 ; 0A ; Witch
.byte $08 ; 0B ; Scholar
.byte $1D ; 0C ; Vampire
.byte $0B ; 0D ; Sage
.byte $17 ; 0E ; Bahamut
.byte $14 ; 0F ; Fairy
.byte $01 ; 10 ; Woman
.byte $15 ; 11 ; Robot
.byte $00 ; 12 ; Princess
.byte $14 ; 13 ; Fairy
.byte $1C ; 14 ; Titan
.byte $0B ; 15 ; Sage 
.byte $1B ; 16 ; Slab
.byte $1B ; 17 ; Slab
.byte $12 ; 18 ; Garland
.byte $12 ; 19 ; Garland
.byte $12 ; 1A ; Garland
.byte $04 ; 1B ; Orb
.byte $04 ; 1C ; Orb
.byte $04 ; 1D ; Orb
.byte $04 ; 1E ; Orb
.byte $00 ; 1F ; Princess
.byte $07 ; 20 ; Soldier
.byte $07 ; 21 ; Soldier
.byte $01 ; 22 ; Woman
.byte $08 ; 23 ; Scholar
.byte $0B ; 24 ; Sage
.byte $07 ; 25 ; Soldier
.byte $01 ; 26 ; Woman  (invisible)
.byte $07 ; 27 ; Soldier
.byte $08 ; 28 ; Scholar
.byte $00 ; 29 ; Princess
.byte $00 ; 2A ; Princess
.byte $07 ; 2B ; Soldier
.byte $0B ; 2C ; Sage
.byte $07 ; 2D ; Soldier
.byte $0B ; 2E ; Sage
.byte $07 ; 2F ; Soldier
.byte $07 ; 30 ; Soldier
.byte $07 ; 31 ; Soldier
.byte $07 ; 32 ; Soldier
.byte $09 ; 33 ; Punk
.byte $0B ; 34 ; Sage
.byte $03 ; 35 ; Dancer
.byte $01 ; 36 ; Woman
.byte $02 ; 37 ; Old Lady
.byte $01 ; 38 ; Woman
.byte $0A ; 39 ; Man
.byte $11 ; 3A ; Bat (Sky Warrior)
.byte $11 ; 3B ; Bat (Sky Warrior)
.byte $11 ; 3C ; Bat (Sky Warrior)
.byte $11 ; 3D ; Bat (Sky Warrior)
.byte $11 ; 3E ; Bat (Sky Warrior)
.byte $0A ; 3F ; Man
.byte $0B ; 40 ; Sage
.byte $01 ; 41 ; Woman
.byte $09 ; 42 ; Punk
.byte $0A ; 43 ; Man
.byte $19 ; 44 ; Elf Man
.byte $19 ; 45 ; Elf Man
.byte $19 ; 46 ; Elf Man
.byte $19 ; 47 ; Elf Man
.byte $18 ; 48 ; Elf Woman
.byte $19 ; 49 ; Elf Man
.byte $19 ; 4A ; Elf Man
.byte $19 ; 4B ; Elf Man
.byte $19 ; 4C ; Elf Man
.byte $19 ; 4D ; Elf Man
.byte $19 ; 4E ; Elf Man
.byte $19 ; 4F ; Elf Man
.byte $19 ; 50 ; Elf Man
.byte $19 ; 51 ; Elf Man
.byte $19 ; 52 ; Elf Man
.byte $18 ; 53 ; Elf Woman
.byte $18 ; 54 ; Elf Woman
.byte $19 ; 55 ; Elf Man
.byte $19 ; 56 ; Elf Man
.byte $11 ; 57 ; Bat (all the normal bats)
.byte $0C ; 58 ; Dwarf
.byte $0C ; 59 ; Dwarf
.byte $0C ; 5A ; Dwarf
.byte $0C ; 5B ; Dwarf
.byte $0C ; 5C ; Dwarf
.byte $0C ; 5D ; Dwarf
.byte $0C ; 5E ; Dwarf
.byte $0C ; 5F ; Dwarf
.byte $0C ; 60 ; Dwarf
.byte $0C ; 61 ; Dwarf
.byte $0C ; 62 ; Dwarf
.byte $0C ; 63 ; Dwarf
.byte $10 ; 64 ; Broom
.byte $10 ; 65 ; Broom
.byte $10 ; 66 ; Broom
.byte $10 ; 67 ; Broom
.byte $0A ; 68 ; Man
.byte $0A ; 69 ; Man
.byte $0A ; 6A ; Man
.byte $0B ; 6B ; Sage
.byte $0A ; 6C ; Man
.byte $0A ; 6D ; Man
.byte $0B ; 6E ; Sage
.byte $0A ; 6F ; Man
.byte $0A ; 70 ; Man
.byte $0A ; 71 ; Man
.byte $01 ; 72 ; Woman
.byte $01 ; 73 ; Woman
.byte $0C ; 74 ; Dwarf
.byte $07 ; 75 ; Soldier
.byte $13 ; 76 ; Pirate
.byte $0B ; 77 ; Sage
.byte $0B ; 78 ; Sage
.byte $0B ; 79 ; Sage
.byte $0B ; 7A ; Sage
.byte $0B ; 7B ; Sage
.byte $0B ; 7C ; Sage
.byte $0B ; 7D ; Sage
.byte $0B ; 7E ; Sage
.byte $0B ; 7F ; Sage
.byte $0B ; 80 ; Sage
.byte $0A ; 81 ; Man
.byte $0B ; 82 ; Sage
.byte $01 ; 83 ; Woman
.byte $0B ; 84 ; Sage
.byte $16 ; 85 ; Dragon
.byte $16 ; 86 ; Dragon
.byte $16 ; 87 ; Dragon
.byte $16 ; 88 ; Dragon
.byte $16 ; 89 ; Dragon
.byte $16 ; 8A ; Dragon
.byte $16 ; 8B ; Dragon
.byte $16 ; 8C ; Dragon
.byte $16 ; 8D ; Dragon
.byte $16 ; 8E ; Dragon
.byte $16 ; 8F ; Dragon
.byte $16 ; 90 ; Dragon
.byte $16 ; 91 ; Dragon
.byte $16 ; 92 ; Dragon
.byte $01 ; 93 ; Woman
.byte $08 ; 94 ; Scholar
.byte $07 ; 95 ; Soldier
.byte $05 ; 96 ; Witch
.byte $03 ; 97 ; Dancer
.byte $09 ; 98 ; Punk
.byte $0B ; 99 ; Sage
.byte $0B ; 9A ; Sage
.byte $16 ; 9B ; Dragon
.byte $13 ; 9C ; Pirate
.byte $09 ; 9D ; Punk
.byte $01 ; 9E ; Woman
.byte $0A ; 9F ; Man
.byte $0A ; A0 ; Man
.byte $0A ; A1 ; Man
.byte $15 ; A2 ; Robot
.byte $0D ; A3 ; Mermaid
.byte $0D ; A4 ; Mermaid
.byte $0D ; A5 ; Mermaid
.byte $0D ; A6 ; Mermaid
.byte $0D ; A7 ; Mermaid
.byte $0D ; A8 ; Mermaid
.byte $0D ; A9 ; Mermaid
.byte $0D ; AA ; Mermaid
.byte $0D ; AB ; Mermaid
.byte $0D ; AC ; Mermaid
.byte $0D ; AD ; Mermaid
.byte $0A ; AE ; Man
.byte $08 ; AF ; Scholar
.byte $08 ; B0 ; Scholar
.byte $01 ; B1 ; Woman
.byte $03 ; B2 ; Dancer
.byte $08 ; B3 ; Scholar
.byte $0A ; B4 ; Man
.byte $0A ; B5 ; Man
.byte $13 ; B6 ; Pirate
.byte $0A ; B7 ; Man
.byte $10 ; B8 ; Broom
.byte $05 ; B9 ; Witch
.byte $02 ; BA ; Old Lady
.byte $0E ; BB ; Leifen
.byte $0E ; BC ; Leifen
.byte $0E ; BD ; Leifen
.byte $0E ; BE ; Leifen
.byte $0E ; BF ; Leifen
.byte $0E ; C0 ; Leifen
.byte $0E ; C1 ; Leifen
.byte $0E ; C2 ; Leifen
.byte $0E ; C3 ; Leifen
.byte $0E ; C4 ; Leifen
.byte $0E ; C5 ; Leifen
.byte $0E ; C6 ; Leifen
.byte $0E ; C7 ; Leifen
.byte $0E ; C8 ; Leifen
.byte $0E ; C9 ; Leifen
.byte $04 ; CA ; Orb
.byte $15 ; CB ; Robot
.byte $15 ; CC ; Robot
.byte $15 ; CD ; Robot
.byte $15 ; CE ; Robot
.byte $15 ; CF ; Robot
.byte $00 ; D0 ; no NPC exists
.byte $00 ; D1 ;
.byte $00 ; D2 ;
.byte $00 ; D3 ;
.byte $00 ; D4 ;
.byte $00 ; D5 ;
.byte $00 ; D6 ;
.byte $00 ; D7 ;
.byte $00 ; D8 ;
.byte $00 ; D9 ;
.byte $00 ; DA ;
.byte $00 ; DB ;
.byte $00 ; DC ;
.byte $00 ; DD ;
.byte $00 ; DE ;
.byte $00 ; DF ;
.byte $00 ; E0 ;
.byte $00 ; E1 ;
.byte $00 ; E2 ;
.byte $00 ; E3 ;
.byte $00 ; E4 ;
.byte $00 ; E5 ;
.byte $00 ; E6 ;
.byte $00 ; E7 ;
.byte $00 ; E8 ;
.byte $00 ; E9 ;
.byte $00 ; EA ;
.byte $00 ; EB ;
.byte $00 ; EC ;
.byte $00 ; ED ;
.byte $00 ; EE ;
.byte $00 ; EF ;
.byte $00 ; F0 ;
.byte $00 ; F1 ;
.byte $00 ; F2 ;
.byte $00 ; F3 ;
.byte $00 ; F4 ;
.byte $00 ; F5 ;
.byte $00 ; F6 ;
.byte $00 ; F7 ;
.byte $00 ; F8 ;
.byte $00 ; F9 ;
.byte $00 ; FA ;
.byte $00 ; FB ;
.byte $00 ; FC ;
.byte $00 ; FD ;
.byte $00 ; FE ;
.byte $00 ; FF ;





; Map sprites
; 3 bytes
;  +0: graphic (00 = no sprite)
;  +1: bits 0-5: X coordinate
;      bit  6:   don't move
;      bit  7:   "in room" flag
;  +2: Y coordinate

;.align $100 - Enable in case sprites in maps wig out

lut_MapObjects:

; 00 ; Coneria 
.byte $31,$10,$01 ; Townsfolk
.byte $32,$07,$0D
.byte $34,$44,$01
.byte $35,$0F,$0C
.byte $36,$12,$14
.byte $37,$05,$06
.byte $38,$1B,$05
.byte $39,$1E,$0B
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00

; 01 ; Pravoka 
.byte $04,$45,$07 ; Bikke
.byte $3F,$0D,$10 ; Townsfolk
.byte $3F,$0C,$03
.byte $3F,$18,$15
.byte $40,$1D,$08
.byte $41,$08,$0E
.byte $42,$13,$0B
.byte $43,$14,$19
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00

; 02 ; Elfland
.byte $4D,$25,$17 ; Elves
.byte $4E,$26,$01
.byte $4F,$1C,$0B
.byte $50,$58,$0F
.byte $51,$09,$0F
.byte $52,$0A,$06
.byte $53,$44,$05
.byte $54,$4F,$1B
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00

; 03 ; Melmond
.byte $0B,$1A,$01 ; Unne
.byte $68,$08,$03 ; Farmers'n such
.byte $69,$16,$03
.byte $6A,$15,$11
.byte $6B,$4C,$01
.byte $6C,$0E,$0D
.byte $6D,$0F,$16
.byte $6E,$5D,$12
.byte $6F,$18,$07
.byte $70,$18,$17
.byte $71,$1D,$09
.byte $72,$14,$1A
.byte $73,$16,$0C
.byte $74,$19,$0D
.byte $00,$00,$00
.byte $00,$00,$00

; 04 ; Crescent Lake  
.byte $15,$6A,$0A ; Dr. Canoe
.byte $77,$66,$0B ; Sages
.byte $78,$64,$0A
.byte $79,$63,$08
.byte $7A,$63,$06
.byte $7B,$64,$04
.byte $7C,$66,$03
.byte $7D,$68,$03
.byte $7E,$6A,$04
.byte $7F,$6B,$06
.byte $80,$6B,$08
.byte $81,$45,$01 ; Sleeping guy
.byte $82,$68,$0B
.byte $83,$10,$07 ; one of these is a lady and not a sage, maybe this one?
.byte $00,$00,$00
.byte $00,$00,$00

; 05 ; Gaia
.byte $13,$71,$13 ; Fairy
.byte $AE,$38,$3C ; Gaia townsfolk
.byte $AF,$29,$3B
.byte $B0,$3A,$29
.byte $B1,$0A,$34
.byte $B2,$26,$36
.byte $B3,$0C,$1F
.byte $B4,$1B,$2B
.byte $B5,$3A,$31
.byte $B6,$10,$10
.byte $B7,$17,$3B
.byte $B8,$29,$33
.byte $B9,$69,$31
.byte $BA,$17,$36
.byte $00,$00,$00
.byte $00,$00,$00

; 06 ; Onrac
.byte $10,$6D,$1E ; Submarine Engineer
.byte $93,$12,$18 
.byte $94,$09,$17
.byte $95,$15,$07
.byte $96,$5E,$15
.byte $97,$11,$0C
.byte $98,$14,$0C
.byte $99,$53,$03
.byte $9A,$6E,$17
.byte $9B,$11,$27
.byte $9C,$1A,$0E
.byte $9D,$1F,$0B
.byte $9E,$04,$17
.byte $9F,$29,$1B
.byte $A0,$1C,$04
.byte $00,$00,$00

; 07 ; Leifen
.byte $BB,$58,$15 ; Chime-giver
.byte $BC,$04,$08 ; Leifen peoples
.byte $BD,$53,$13
.byte $BE,$21,$08
.byte $BF,$50,$0A
.byte $C0,$1A,$0E
.byte $C1,$21,$0D
.byte $C2,$23,$16
.byte $C3,$09,$0F
.byte $C4,$56,$0A
.byte $C5,$06,$0A
.byte $C6,$1C,$12
.byte $C8,$0E,$14
.byte $C9,$07,$0D
.byte $00,$00,$00
.byte $00,$00,$00

;  +1: bits 0-5: X coordinate ; across: + 2 
;  +2: Y coordinate ; up/down: - 5

; 08 ; Conera Castle 1F
.byte $20,$50,$17 ; Guard near lower pillar 
.byte $20,$4C,$0D ; Guard near stairs
.byte $22,$04,$05
.byte $23,$0A,$06
.byte $25,$49,$17
.byte $26,$49,$0A ; Invisible lady
.byte $29,$C8,$13
.byte $2A,$93,$12
.byte $2C,$58,$04
.byte $2E,$50,$0A
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00

; 09 ; Elfland Castle 
.byte $05,$C9,$05 ; Elf Doctor
.byte $06,$C8,$06 ; Elf Prince
.byte $45,$41,$01 ; Elves
.byte $46,$17,$0E
.byte $47,$02,$18
.byte $48,$13,$04
.byte $49,$4F,$14
.byte $4A,$51,$14
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00

; 0A ; Northwest Castle 
.byte $07,$D0,$06 ; Astos
.byte $57,$16,$08 ; bats
.byte $57,$1C,$03
.byte $57,$04,$03
.byte $57,$13,$10
.byte $57,$0B,$0A
.byte $57,$04,$14
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00

; 0B ; Castle of Ordeals 1F
.byte $84,$4C,$0D ; Creepy vanishing sage
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00

; 0C ; Temple of Fiends (Present)
.byte $02,$D4,$15 ; Garland
.byte $03,$D4,$12 ; Princess
.byte $3A,$91,$13 ; Sky Warrior bats
.byte $3B,$92,$12
.byte $3C,$92,$13
.byte $3D,$97,$13
.byte $3E,$96,$13
.byte $CA,$D4,$11 ; Black orb
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00

; 0D ; Earth Cave B1
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00

; 0E ; Gurgu Volcano B1
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00

; 0F ; Ice Cave B1
;.byte $13,$6F,$1E ; surprise fairy!
.byte $00,$00,$00 ; fixed ^ 
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00

; 10 ; Cardia
.byte $85,$1C,$09 ; Dragons
.byte $86,$29,$06
.byte $87,$29,$16
.byte $88,$A6,$34
.byte $8A,$18,$1F
.byte $8B,$91,$25
.byte $8C,$25,$1E
.byte $8D,$0D,$06
.byte $8E,$95,$25
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00

; 11 ; Bahamut's Room B1
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00

; 12 ; Waterfall
.byte $11,$94,$35 ; must be robot
.byte $57,$08,$04 ; these are bats -- this one has been moved down 1 tile so as not to be in the wall
.byte $57,$0F,$17
.byte $57,$0A,$29
.byte $57,$17,$19
.byte $57,$19,$09
.byte $57,$28,$09
.byte $57,$21,$18
.byte $57,$32,$23
.byte $57,$2B,$29
.byte $57,$3A,$2C
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00

; 13 ; Dwarf Cave
.byte $08,$50,$2D ; TNT dwarf
.byte $09,$C7,$02 ; Blacksmith
.byte $58,$4E,$15 ; dwarves
.byte $59,$03,$0A
.byte $5A,$16,$11
.byte $5B,$0E,$07
.byte $5C,$D5,$04
.byte $5D,$02,$04
.byte $5E,$0A,$0F
.byte $5F,$0A,$13
.byte $60,$D3,$0E
.byte $61,$0D,$02
.byte $63,$12,$0A
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00

; 14 ; Matoya's Cave
.byte $0A,$C8,$01 ; Matoya
.byte $64,$03,$0D ; Brooms
.byte $65,$8B,$0A
.byte $66,$83,$07
.byte $67,$CD,$03
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00

; 15 ; Sarda's Cave
.byte $0D,$C2,$02 ;; Its Sarda!
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00

; 16 ; Marsh Cave B1
.byte $57,$04,$03 ; bats
.byte $57,$1E,$24 
.byte $57,$10,$15
.byte $57,$34,$16
.byte $57,$18,$1C
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00

; 17 ; Mirage Tower 1F
.byte $CE,$D4,$05 ; Robot
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00

; 18 ; Coneria Castle 2F
.byte $01,$CC,$04 ; King
.byte $12,$CB,$05 ; Princess
.byte $2B,$42,$1D ; Guards
.byte $30,$4D,$09
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00

; 19 ; Castle of Ordeals 2F
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00

; 1A ; Castle of Ordeals 3F
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00

; 1B ; Marsh Cave B2
.byte $57,$0E,$11 ; bats
.byte $57,$1B,$0B
.byte $57,$06,$10
.byte $57,$0F,$2D
.byte $57,$11,$33
.byte $57,$16,$30
.byte $57,$1D,$35
.byte $57,$22,$32
.byte $57,$26,$2B
.byte $57,$31,$1E
.byte $57,$36,$28
.byte $57,$2F,$28
.byte $57,$2E,$33
.byte $57,$3A,$38
.byte $00,$00,$00
.byte $00,$00,$00

; 1C ; Marsh Cave B3
.byte $57,$06,$0A ; all the bats
.byte $57,$1E,$08
.byte $57,$11,$10
.byte $57,$2C,$10
.byte $57,$2A,$1D
.byte $57,$33,$04
.byte $57,$2F,$22
.byte $57,$1F,$18
.byte $57,$1D,$20
.byte $57,$10,$1F
.byte $57,$02,$1E
.byte $57,$06,$2A
.byte $57,$05,$31
.byte $57,$14,$2D
.byte $57,$1E,$36
.byte $57,$1F,$2F

; 1D ; Earth Cave B2
.byte $57,$0A,$0B ; bats
.byte $57,$12,$0F
.byte $57,$0A,$15
.byte $57,$15,$16
.byte $57,$0F,$1F
.byte $57,$19,$24
.byte $57,$1B,$31
.byte $57,$21,$28
.byte $57,$1D,$19
.byte $57,$27,$16
.byte $57,$1F,$12
.byte $57,$A8,$10
.byte $57,$26,$29
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00

; 1E ; Earth Cave B3
.byte $0C,$DA,$26 ; Vampire
.byte $16,$5A,$1B ; Earth Plate
.byte $57,$8B,$09 ; bats
.byte $57,$8A,$0A
.byte $57,$89,$09
.byte $57,$0F,$10
.byte $57,$18,$0F
.byte $57,$11,$22
.byte $57,$11,$20
.byte $57,$12,$22
.byte $57,$1C,$12
.byte $57,$1A,$13
.byte $57,$23,$14
.byte $57,$27,$10
.byte $57,$2C,$0C
.byte $57,$2F,$0E

; 1F ; Earth Cave B4
.byte $57,$93,$28 ; baaats
.byte $57,$90,$26
.byte $57,$93,$24
.byte $57,$0A,$23
.byte $57,$0C,$2A
.byte $57,$18,$15
.byte $57,$16,$17
.byte $57,$13,$1B
.byte $57,$15,$0C
.byte $57,$12,$12
.byte $57,$A7,$0C
.byte $57,$20,$12
.byte $57,$24,$17
.byte $57,$21,$18
.byte $57,$24,$17
.byte $57,$21,$18

; 20 ; Earth Cave B5
.byte $1B,$CC,$2A ; Earth Orb
.byte $57,$11,$31 ; dang bats
.byte $57,$0F,$23
.byte $57,$1A,$25
.byte $57,$1E,$2E
.byte $57,$1F,$32
.byte $57,$20,$37
.byte $57,$24,$2A
.byte $57,$1C,$1F
.byte $57,$12,$18
.byte $57,$14,$1A
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00

; 21 ; Gurgu Volcano B2
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00

; 22 ; Gurgu Volcano B3
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00

; 23 ; Gurgu Volcano B4
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00

; 24 ; Gurgu Volcano B5
.byte $1C,$C7,$37 ; Fire Orb
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00

; 25 ; Ice Cave B2
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00

; 26 ; Ice Cave B3
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00

; 27 ; Bahamut's Room B2
.byte $0E,$D5,$03 ; Bahamut
.byte $8F,$D3,$07 ; Dragons
.byte $90,$D7,$07
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00

; 28 ; Mirage Tower 2F
.byte $CC,$13,$04 ; Robot
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00

; 29 ; Mirage Tower 3F
.byte $CD,$C9,$0A ; Transporter 
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00

; 2A ; Sea Shrine B5
.byte $1D,$CC,$08 ; Water Orb
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00

; 2B ; Sea Shrine B4
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00

; 2C ; Sea Shrine B3
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00

; 2D ; Sea Shrine B2
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00

; 2E ; Sea Shrine B1
.byte $A3,$86,$12 ; mermaids!
.byte $A4,$93,$05
.byte $A5,$9A,$12
.byte $A6,$84,$19
.byte $A7,$93,$12
.byte $A8,$94,$0C
.byte $A9,$8B,$0B
.byte $AA,$84,$0B
.byte $AB,$85,$04
.byte $AC,$94,$1A
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00

; 2F ; Sky Palace 1F
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00

; 30 ; Sky Palace 2F
.byte $16,$DA,$1B ; Earth plate? ??? 
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00

; 31 ; Sky Palace 3F
.byte $CF,$5E,$19 ; Window 
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00

; 32 ; Sky Palace 4F
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00

; 33 ; Sky Palace 5F
.byte $1E,$C7,$05 ; Wind Orb
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00

; 34 ; Temple of Fiends 1F
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00

; 35 ; Temple of Fiends 2F
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00

; 36 ; Temple of Fiends 3F
.byte $17,$D4,$10 ; Evil plate?
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00

; 37 ; Temple of Fiends 4F - Earth
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00

; 38 ; Temple of Fiends 5F - Fire
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00

; 39 ; Temple of Fiends 6F - Water
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00

; 3A ; Temple of Fiends 7F - Wind
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00

; 3B ; Temple of Fiends 8F - Chaos
.byte $18,$CF,$13 ; Garland's speech
.byte $19,$CF,$12 ; Garland's speech
.byte $1A,$CF,$11 ; Chaos fight!
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00

; 3C ; Titan's Tunnel
.byte $14,$48,$07 ; Titan
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00

; 3D ; empty map
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00

; 3E ; empty map
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00

; 3F ; empty map
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00


;;; Battle backdrop palettes
;;
;;lut_BackdropPal:
;;.byte $0F,$31,$29,$30 ; 00 ; grasslands
;;.byte $0F,$0C,$17,$07 ; 01 ; cave
;;.byte $0F,$1C,$2B,$1B ; 02 ; cave_2
;;.byte $0F,$30,$3C,$22 ; 03 ; ocean
;;.byte $0F,$18,$0A,$1C ; 04 ; forest
;;.byte $0F,$3C,$1C,$0C ; 05 ; temple
;;.byte $0F,$37,$31,$28 ; 06 ; desert
;;.byte $0F,$27,$17,$1C ; 07 ; brambles
;;.byte $0F,$1A,$17,$07 ; 08 ; cave_3
;;.byte $0F,$30,$10,$00 ; 09 ; castle
;;.byte $0F,$22,$1A,$10 ; 0A ; river
;;.byte $0F,$37,$10,$00 ; 0B ; sky_castle
;;.byte $0F,$21,$12,$03 ; 0C ; sea_shrine
;;.byte $0F,$31,$22,$13 ; 0D ; cave_4
;;.byte $0F,$26,$16,$06 ; 0E ; cave_5
;;.byte $0F,$2B,$1C,$0C ; 0F ; waterfall
;;
;;.byte $0F,$30,$00,$31 ; Weapon shop
;;.byte $0F,$10,$27,$17 ; Armor shop
;;.byte $0F,$3C,$1C,$0C ; White magic shop
;;.byte $0F,$3B,$1B,$0B ; Black magic shop
;;.byte $0F,$37,$16,$10 ; Clinic
;;.byte $0F,$36,$16,$07 ; Inn
;;.byte $0F,$37,$17,$07 ; Item
;;.byte $0F,$30,$28,$16 ; Caravan
;;
;;
;;; Battle backdrop assignment
;;
;;lut_BtlBackdrops:
;;.byte $00 ; grasslands
;;.byte $09 ; castle
;;.byte $09 ; castle
;;.byte $04 ; forest
;;.byte $04 ; forest
;;.byte $04 ; forest
;;.byte $00 ; grasslands
;;.byte $03 ; ocean
;;.byte $00 ; grasslands
;;.byte $FF ; unused?
;;.byte $FF ; unused?
;;.byte $FF ; unused?
;;.byte $FF ; unused?
;;.byte $FF ; unused?
;;.byte $08 ; cave_3
;;.byte $FF ; unused?
;;.byte $FF ; unused?
;;.byte $FF ; unused?
;;.byte $FF ; unused?
;;.byte $04 ; forest
;;.byte $04 ; forest
;;.byte $04 ; forest
;;.byte $03 ; ocean
;;.byte $03 ; ocean
;;.byte $03 ; ocean
;;.byte $FF ; unused?
;;.byte $FF ; unused?
;;.byte $09 ; castle
;;.byte $09 ; castle
;;.byte $0B ; sky_castle
;;.byte $06 ; desert
;;.byte $FF ; unused?
;;.byte $FF ; unused?
;;.byte $FF ; unused?
;;.byte $FF ; unused?
;;.byte $04 ; forest
;;.byte $04 ; forest
;;.byte $04 ; forest
;;.byte $00 ; grasslands
;;.byte $03 ; ocean
;;.byte $00 ; grasslands
;;.byte $09 ; castle
;;.byte $09 ; castle
;;.byte $0D ; cave_4
;;.byte $FF ; unused?
;;.byte $FF ; unused?
;;.byte $FF ; unused?
;;.byte $02 ; cave_2
;;.byte $FF ; unused?
;;.byte $FF ; unused?
;;.byte $02 ; cave_2
;;.byte $FF ; unused?
;;.byte $02 ; cave_2
;;.byte $02 ; cave_2
;;.byte $06 ; desert
;;.byte $06 ; desert
;;.byte $09 ; castle
;;.byte $09 ; castle
;;.byte $02 ; cave_2
;;.byte $00 ; grasslands
;;.byte $FF ; unused?
;;.byte $FF ; unused?
;;.byte $FF ; unused?
;;.byte $00 ; grasslands
;;.byte $0A ; river
;;.byte $0A ; river
;;.byte $06 ; desert
;;.byte $06 ; desert
;;.byte $0A ; river
;;.byte $06 ; desert
;;.byte $0F ; waterfall?
;;.byte $FF ; unused?
;;.byte $FF ; unused?
;;.byte $00 ; grasslands
;;.byte $03 ; ocean
;;.byte $FF ; unused?
;;.byte $00 ; grasslands
;;.byte $00 ; grasslands
;;.byte $00 ; grasslands
;;.byte $FF ; unused?
;;.byte $0A ; river
;;.byte $0A ; river
;;.byte $06 ; desert
;;.byte $06 ; desert
;;.byte $00 ; grasslands
;;.byte $07 ; brambles
;;.byte $00 ; grasslands
;;.byte $05 ; temple
;;.byte $05 ; temple
;;.byte $00 ; grasslands
;;.byte $00 ; grasslands
;;.byte $FF ; unused?
;;.byte $FF ; unused?
;;.byte $0C ; sea_shrine
;;.byte $FF ; unused?
;;.byte $FF ; unused?
;;.byte $00 ; grasslands
;;.byte $00 ; grasslands
;;.byte $07 ; brambles
;;.byte $07 ; brambles
;;.byte $0E ; cave_5
;;.byte $0E ; cave_5
;;.byte $02 ; cave_2
;;.byte $02 ; cave_2
;;.byte $02 ; cave_2
;;.byte $02 ; cave_2
;;.byte $02 ; cave_2
;;.byte $FF ; unused?
;;.byte $02 ; cave_2
;;.byte $00 ; grasslands
;;.byte $01 ; cave
;;.byte $FF ; unused?
;;.byte $00 ; grasslands
;;.byte $00 ; grasslands
;;.byte $07 ; brambles
;;.byte $07 ; brambles
;;.byte $00 ; grasslands
;;.byte $00 ; grasslands
;;.byte $00 ; grasslands
;;.byte $FF ; unused?
;;.byte $FF ; unused?
;;.byte $FF ; unused?
;;.byte $FF ; unused?
;;.byte $FF ; unused?
;;.byte $FF ; unused?
;;.byte $FF ; unused?
;;.byte $FF ; unused?
;;.byte $FF ; unused?


lut_ClassStartingStats:
;     Class HP   Str  Agil Int  Vit  Luck DMG  Hit% Evade MDef  MP   Weapon Armor Spells Unused
.byte $00,  $23, $14, $05, $01, $0A, $05, $0A, $0A, $35,  $0F,  $00, $02,   $41,  $00,   $00 ; Fighter
.byte $01,  $1E, $05, $0A, $05, $05, $0F, $02, $05, $3A,  $0F,  $00, $02,   $41,  $00,   $00 ; Thief
.byte $02,  $21, $05, $05, $05, $14, $05, $02, $05, $35,  $0A,  $00, $00,   $41,  $00,   $00 ; BB
.byte $03,  $1E, $0A, $0A, $0A, $05, $05, $05, $07, $3A,  $14,  $22, $03,   $41,  $00,   $00 ; RedMage
.byte $04,  $1C, $05, $05, $0F, $0A, $05, $02, $05, $35,  $14,  $22, $03,   $41,  $00,   $00 ; WMage
.byte $05,  $19, $01, $0A, $14, $01, $0A, $01, $05, $3A,  $14,  $22, $03,   $41,  $00,   $00 ; BMage
.byte $06,  $23, $14, $05, $01, $0A, $05, $0A, $0A, $35,  $0F,  $00, $02,   $41,  $00,   $00 ; Knight
.byte $07,  $1E, $05, $0A, $05, $05, $0F, $02, $05, $3A,  $0F,  $00, $02,   $41,  $00,   $00 ; Ninja
.byte $08,  $21, $05, $05, $05, $14, $05, $02, $05, $35,  $0A,  $00, $00,   $41,  $00,   $00 ; Master
.byte $09,  $1E, $0A, $0A, $0A, $05, $05, $05, $07, $3A,  $14,  $22, $03,   $41,  $00,   $00 ; RedWiz
.byte $0A,  $1C, $05, $05, $0F, $0A, $05, $02, $05, $35,  $14,  $22, $03,   $41,  $00,   $00 ; WWiz 
.byte $0B,  $19, $01, $0A, $14, $01, $0A, $01, $05, $3A,  $14,  $22, $03,   $41,  $00,   $00 ; Bwiz
;                                                                     \ 02 small knife or 03 wooden staff
;                                                                            \ 01 cloth armour

; Overworld->map teleport X coords
lut_EntrTele_X: 
.byte $1E ; Cardia 1 
.byte $10 ; Coneria
.byte $13 ; Pravoka
.byte $29 ; Elfland
.byte $01 ; Melmond
.byte $0B ; Crescent Lake
.byte $3D ; Gaia
.byte $01 ; Onrac
.byte $13 ; Leifen
.byte $0E ; C ; Coneria Castle 1F
.byte $10 ; Elfland Castle
.byte $16 ; Northwest Castle
.byte $0C ; Castle of Ordeals 1F
.byte $14 ; Temple of Fiends
.byte $17 ; Earth Cave B1
.byte $1B ; Gurgu Volcano B1
.byte $07 ; Ice Cave B1
.byte $0C ; Cardia 2
.byte $02 ; Bahamut's Room B1
.byte $39 ; Waterfall
.byte $16 ; Dwarf Cave
.byte $0F ; Matoya's Cave
.byte $12 ; Sarda's Cave
.byte $15 ; Marsh Cave B1
.byte $11 ; Mirage Tower 1F
.byte $0B ; Titan's Tunnel East 
.byte $05 ; Titan's Tunnel West
.byte $13 ; Cardia 3
.byte $2B ; Cardia 4
.byte $3A ; Cardia 5
.byte $00 ; 
.byte $00 ; 

; Overworld->map teleport Y coords
lut_EntrTele_Y: 
.byte $12 ; Cardia 1 
.byte $17 ; Coneria
.byte $20 ; Pravoka
.byte $16 ; Elfland
.byte $10 ; Melmond
.byte $17 ; Crescent Lake
.byte $3D ; Gaia
.byte $0C ; Onrac
.byte $17 ; Leifen
.byte $1E ; 23 ; Coneria Castle 1F
.byte $1F ; Elfland Castle
.byte $18 ; Northwest Castle
.byte $15 ; Castle of Ordeals 1F
.byte $1E ; Temple of Fiends
.byte $18 ; Earth Cave B1
.byte $0F ; Gurgu Volcano B1
.byte $01 ; Ice Cave B1
.byte $0F ; Cardia 2
.byte $02 ; Bahamut's Room B1
.byte $38 ; Waterfall
.byte $0B ; Dwarf Cave
.byte $0B ; Matoya's Cave
.byte $0D ; Sarda's Cave
.byte $1B ; Marsh Cave B1
.byte $1F ; Mirage Tower 1F
.byte $0E ; Titan's Tunnel East 
.byte $03 ; Titan's Tunnel West
.byte $24 ; Cardia 3
.byte $1D ; Cardia 4
.byte $37 ; Cardia 5
.byte $00 ; 
.byte $00 ; 

; Overworld->map teleport map #
lut_EntrTele_Map: 
.byte $10 ; Cardia 1 
.byte $00 ; Coneria
.byte $01 ; Pravoka
.byte $02 ; Elfland
.byte $03 ; Melmond
.byte $04 ; Crescent Lake
.byte $05 ; Gaia
.byte $06 ; Onrac
.byte $07 ; Leifen
.byte $08 ; Coneria Castle 1F
.byte $09 ; Elfland Castle
.byte $0A ; Northwest Castle
.byte $0B ; Castle of Ordeals 1F
.byte $0C ; Temple of Fiends
.byte $0D ; Earth Cave B1
.byte $0E ; Gurgu Volcano B1
.byte $0F ; Ice Cave B1
.byte $10 ; Cardia 2
.byte $11 ; Bahamut's Room B1
.byte $12 ; Waterfall
.byte $13 ; Dwarf Cave
.byte $14 ; Matoya's Cave
.byte $15 ; Sarda's Cave
.byte $16 ; Marsh Cave B1
.byte $17 ; Mirage Tower 1F
.byte $3C ; Titan's Tunnel East 
.byte $3C ; Titan's Tunnel West
.byte $10 ; Cardia 3
.byte $10 ; Cardia 4
.byte $10 ; Cardia 5
.byte $00 ; 
.byte $00 ; 

; Map->world map teleport X coords
lut_ExitTele_X: 
.byte $2A ; Titan's Tunnel East
.byte $1E ; Titan's Tunnel West
.byte $C5 ; Ice Cave
.byte $82 ; Castle of Ordeals
.byte $99 ; Castle of Coneria
.byte $41 ; Earth Cave
.byte $BC ; Gurgu Volcano
.byte $3E ; Sea Shrine
.byte $C2 ; Sky Castle
.byte $00 ; 
.byte $00 ; 
.byte $00 ; 
.byte $00 ; 
.byte $00 ; 
.byte $00 ; 
.byte $00 ; 

; Map->world map teleport Y coords
lut_ExitTele_Y: 
.byte $AE ; Titan's Tunnel East
.byte $AF ; Titan's Tunnel West
.byte $B7 ; Ice Cave
.byte $2D ; Castle of Ordeals
.byte $9F ; Castle of Coneria
.byte $BB ; Earth Cave
.byte $CD ; Gurgu Volcano
.byte $38 ; Sea Shrine
.byte $3B ; Sky Castle
.byte $00 ;
.byte $00 ;
.byte $00 ;
.byte $00 ;
.byte $00 ;
.byte $00 ;
.byte $00 ;

; Map tileset selection
lut_Tilesets: 
.byte $00 ; town        ; Coneria
.byte $00 ; town        ; Pravoka
.byte $00 ; town        ; Elfland
.byte $00 ; town        ; Melmond
.byte $00 ; town        ; Crescent Lake
.byte $00 ; town        ; Gaia
.byte $00 ; town        ; Onrac
.byte $00 ; town        ; Leifen
.byte $01 ; castle      ; Coneria Castle 1F
.byte $01 ; castle      ; Elfland Castle
.byte $01 ; castle      ; Northwest Castle
.byte $01 ; castle      ; Castle of Ordeals 1F
.byte $05 ; shrine      ; Temple of Fiends
.byte $02 ; cave        ; Earth Cave B1
.byte $02 ; cave        ; Gurgu Volcano B1
.byte $03 ; safe cave   ; Ice Cave B1
.byte $03 ; safe cave   ; Cardia
.byte $03 ; safe cave   ; Bahamut's Room B1
.byte $03 ; safe cave   ; Waterfall
.byte $03 ; safe cave   ; Dwarf Cave
.byte $03 ; safe cave   ; Matoya's Cave
.byte $03 ; safe cave   ; Sarda's Cave
.byte $04 ; tower       ; Marsh Cave B1
.byte $04 ; tower       ; Mirage Tower 1F
.byte $01 ; castle      ; Coneria Castle 2F
.byte $01 ; castle      ; Castle of Ordeals 2F
.byte $01 ; castle      ; Castle of Ordeals 3F
.byte $04 ; tower       ; Marsh Cave B2
.byte $04 ; tower       ; Marsh Cave B3
.byte $02 ; cave        ; Earth Cave B2
.byte $02 ; cave        ; Earth Cave B3
.byte $02 ; cave        ; Earth Cave B4
.byte $02 ; cave        ; Earth Cave B5
.byte $02 ; cave        ; Gurgu Volcano B2
.byte $02 ; cave        ; Gurgu Volcano B3
.byte $02 ; cave        ; Gurgu Volcano B4
.byte $02 ; cave        ; Gurgu Volcano B5
.byte $03 ; safe cave   ; Ice Cave B2
.byte $03 ; safe cave   ; Ice Cave B3
.byte $03 ; safe cave   ; Bahamut's Room B2
.byte $04 ; tower       ; Mirage Tower 2F
.byte $04 ; tower       ; Mirage Tower 3F
.byte $05 ; shrine      ; Sea Shrine B5
.byte $05 ; shrine      ; Sea Shrine B4
.byte $05 ; shrine      ; Sea Shrine B3
.byte $05 ; shrine      ; Sea Shrine B2
.byte $05 ; shrine      ; Sea Shrine B1
.byte $06 ; sky palace  ; Sky Palace 1F
.byte $06 ; sky palace  ; Sky Palace 2F
.byte $06 ; sky palace  ; Sky Palace 3F
.byte $06 ; sky palace  ; Sky Palace 4F
.byte $06 ; sky palace  ; Sky Palace 5F
.byte $07 ; temple      ; Temple of Fiends 1F
.byte $07 ; temple      ; Temple of Fiends 2F
.byte $07 ; temple      ; Temple of Fiends 3F
.byte $07 ; temple      ; Temple of Fiends 4F - Earth
.byte $07 ; temple      ; Temple of Fiends 5F - Fire
.byte $07 ; temple      ; Temple of Fiends 6F - Water
.byte $07 ; temple      ; Temple of Fiends 7F - Wind
.byte $07 ; temple      ; Temple of Fiends 8F - Chaos
.byte $02 ; cave        ; Titan's Tunnel
.byte $00 ;             ; 
.byte $00 ;             ; 
.byte $00 ;             ; 



; map->map teleport X coords
lut_NormTele_X: 
.byte $0C ; Coneria Castle 1
.byte $14 ; Time Warp
.byte $12 ; Marsh Cave 1
.byte $22 ; Marsh Cave 2
.byte $05 ; Marsh Cave 3
.byte $0A ; Earth Cave 1
.byte $1B ; Earth Cave 2
.byte $3D ; Earth Cave 3
.byte $19 ; Earth Cave 4
.byte $1E ; Gurgu Volcano 1
.byte $12 ; Gurgu Volcano 2
.byte $03 ; Gurgu Volcano 3
.byte $2E ; Gurgu Volcano 4
.byte $23 ; Gurgu Volcano 5
.byte $20 ; Gurgu Volcano 6
.byte $1E ; Ice Cave 1
.byte $03 ; Ice Cave 2
.byte $37 ; Ice Cave 3
.byte $27 ; Ice Cave 4
.byte $06 ; Ice Cave 5
.byte $3B ; Ice Cave 6
.byte $33 ; Ice Cave 7
.byte $0C ; Castle of Ordeals 1
.byte $16 ; Castle of Ordeals 2
.byte $02 ; Castle of Ordeals 3
.byte $17 ; Bahamut's Room
.byte $0E ; Castle of Ordeals 4
.byte $0C ; Castle of Ordeals 5
.byte $0C ; Castle of Ordeals 6
.byte $0A ; Castle of Ordeals 7
.byte $01 ; Castle of Ordeals 8
.byte $06 ; Castle of Ordeals 9
.byte $15 ; Sea Shrine 1
.byte $2D ; Sea Shrine 2
.byte $0C ; Sea Shrine 3
.byte $3D ; Sea Shrine 4
.byte $2F ; Sea Shrine 5
.byte $36 ; Sea Shrine 6
.byte $30 ; Sea Shrine 7
.byte $2D ; Sea Shrine 8
.byte $32 ; Sea Shrine 9
.byte $10 ; Mirage Tower 1
.byte $08 ; Mirage Tower 2
.byte $13 ; Sky Palace 1
.byte $13 ; Sky Palace 2
.byte $18 ; Sky Palace 3
.byte $03 ; Sky Palace 4
.byte $07 ; Sky Palace 5
.byte $08 ; Temple of Fiends 1
.byte $10 ; Temple of Fiends 2
.byte $01 ; Temple of Fiends 3
.byte $14 ; Temple of Fiends 4
.byte $28 ; Temple of Fiends 5
.byte $03 ; Temple of Fiends 6
.byte $0D ; Temple of Fiends 7
.byte $01 ; Temple of Fiends 8
.byte $01 ; Temple of Fiends 9
.byte $0F ; Temple of Fiends 10
.byte $04 ; Castle of Ordeals 10
.byte $08 ; Castle of Ordeals 11
.byte $0E ; Castle of Ordeals 12
.byte $17 ; Castle of Ordeals 13
.byte $0E ; Coneria Castle bottom floor
.byte $0C ; Rescue Princess

; map->map teleport Y coords
lut_NormTele_Y: 
.byte $12 ; Coneria Castle 1
.byte $11 ; Time Warp
.byte $10 ; Marsh Cave 1
.byte $25 ; Marsh Cave 2
.byte $06 ; Marsh Cave 3
.byte $09 ; Earth Cave 1
.byte $2D ; Earth Cave 2
.byte $21 ; Earth Cave 3
.byte $35 ; Earth Cave 4
.byte $20 ; Gurgu Volcano 1
.byte $02 ; Gurgu Volcano 2
.byte $17 ; Gurgu Volcano 3
.byte $17 ; Gurgu Volcano 4
.byte $06 ; Gurgu Volcano 5
.byte $1F ; Gurgu Volcano 6
.byte $02 ; Ice Cave 1
.byte $02 ; Ice Cave 2
.byte $05 ; Ice Cave 3
.byte $06 ; Ice Cave 4
.byte $14 ; Ice Cave 5
.byte $21 ; Ice Cave 6
.byte $0B ; Ice Cave 7
.byte $0C ; Castle of Ordeals 1
.byte $16 ; Castle of Ordeals 2
.byte $02 ; Castle of Ordeals 3
.byte $37 ; Bahamut's Room
.byte $0C ; Castle of Ordeals 4
.byte $09 ; Castle of Ordeals 5
.byte $10 ; Castle of Ordeals 6
.byte $0C ; Castle of Ordeals 7
.byte $14 ; Castle of Ordeals 8
.byte $05 ; Castle of Ordeals 9
.byte $2A ; Sea Shrine 1
.byte $08 ; Sea Shrine 2
.byte $1A ; Sea Shrine 3
.byte $31 ; Sea Shrine 4
.byte $27 ; Sea Shrine 5
.byte $29 ; Sea Shrine 6
.byte $0A ; Sea Shrine 7
.byte $14 ; Sea Shrine 8
.byte $30 ; Sea Shrine 9
.byte $1F ; Mirage Tower 1
.byte $01 ; Mirage Tower 2
.byte $15 ; Sky Palace 1
.byte $04 ; Sky Palace 2
.byte $17 ; Sky Palace 3
.byte $03 ; Sky Palace 4
.byte $36 ; Sky Palace 5
.byte $1B ; Temple of Fiends 1
.byte $0F ; Temple of Fiends 2
.byte $01 ; Temple of Fiends 3
.byte $12 ; Temple of Fiends 4
.byte $01 ; Temple of Fiends 5
.byte $20 ; Temple of Fiends 6
.byte $15 ; Temple of Fiends 7
.byte $01 ; Temple of Fiends 8
.byte $04 ; Temple of Fiends 9
.byte $07 ; Temple of Fiends 10
.byte $04 ; Castle of Ordeals 10
.byte $04 ; Castle of Ordeals 11
.byte $14 ; Castle of Ordeals 12
.byte $16 ; Castle of Ordeals 13
.byte $0D ; Coneria Castle bottom floor
.byte $07 ; Rescue Princess

; map->map teleport map #
lut_NormTele_Map: 
.byte $18 ; Coneria Castle 1     > 2F (loop - WARP magic doesn't work)
.byte $34 ; Time Warp            > Temple of Fiends 1F
.byte $1B ; Marsh Cave 1         > B2
.byte $1B ; Marsh Cave 2         > B2
.byte $1C ; Marsh Cave 3         > B3
.byte $1D ; Earth Cave 1         > B2
.byte $1E ; Earth Cave 2         > B3
.byte $1F ; Earth Cave 3         > B4
.byte $20 ; Earth Cave 4         > B5
.byte $21 ; Gurgu Volcano 1      > B2
.byte $22 ; Gurgu Volcano 2      > B3
.byte $23 ; Gurgu Volcano 3      > B4
.byte $22 ; Gurgu Volcano 4      > B3
.byte $23 ; Gurgu Volcano 5      > B4
.byte $24 ; Gurgu Volcano 6      > B5
.byte $25 ; Ice Cave 1           > B2 
.byte $26 ; Ice Cave 2           > B3
.byte $25 ; Ice Cave 3           > B2
.byte $26 ; Ice Cave 4           > B3
.byte $0F ; Ice Cave 5           > B1
.byte $26 ; Ice Cave 6           > B3
.byte $25 ; Ice Cave 7           > B2
.byte $19 ; Castle of Ordeals 1  > 2F
.byte $1A ; Castle of Ordeals 2  > 3F
.byte $0B ; Castle of Ordeals 3  > 1F
.byte $27 ; Bahamut's Room       > B2
.byte $19 ; Castle of Ordeals 4  > 2F (maze)
.byte $19 ; Castle of Ordeals 5  > 2F (maze)
.byte $19 ; Castle of Ordeals 6  > 2F (maze)
.byte $19 ; Castle of Ordeals 7  > 2F (maze)
.byte $19 ; Castle of Ordeals 8  > 2F (maze)
.byte $19 ; Castle of Ordeals 9  > 2F (maze)
.byte $2C ; Sea Shrine 1         > B3
.byte $2D ; Sea Shrine 2         > B2 (way to mermaids?)
.byte $2E ; Sea Shrine 3         > B1 (mermaids?)
.byte $2B ; Sea Shrine 4         > B4
.byte $2C ; Sea Shrine 5         > B3
.byte $2D ; Sea Shrine 6         > B2
.byte $2C ; Sea Shrine 7         > B3
.byte $2B ; Sea Shrine 8         > B4
.byte $2A ; Sea Shrine 9         > B5
.byte $28 ; Mirage Tower 1       > 2F
.byte $29 ; Mirage Tower 2       > 3F
.byte $2F ; Sky Palace 1         > 1F
.byte $30 ; Sky Palace 2         > 2F
.byte $31 ; Sky Palace 3         > 3F
.byte $32 ; Sky Palace 4         > 4F
.byte $33 ; Sky Palace 5         > 5F
.byte $37 ; Temple of Fiends 1   > 4F - Earth
.byte $35 ; Temple of Fiends 2   > 2F
.byte $36 ; Temple of Fiends 3   > 3F
.byte $35 ; Temple of Fiends 4   > 2F
.byte $34 ; Temple of Fiends 5   > 1F
.byte $37 ; Temple of Fiends 6   > 4F - Earth
.byte $38 ; Temple of Fiends 7   > 5F - Fire
.byte $39 ; Temple of Fiends 8   > 6F - Water
.byte $3A ; Temple of Fiends 9   > 7F - Wind
.byte $3B ; Temple of Fiends 10  > 8F - Chaos
.byte $19 ; Castle of Ordeals 10 > 2F (maze)
.byte $19 ; Castle of Ordeals 11 > 2F (maze)
.byte $19 ; Castle of Ordeals 12 > 2F (maze)
.byte $19 ; Castle of Ordeals 13 > 2F (maze)
.byte $08 ; Coneria Castle       > 1F (loop - WARP magic doesn't work)
.byte $18 ; Rescue Princess (ToF)> Coneria Castle 2F





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

.byte "END OF BANK 13"
