.include "Constants.inc"
.include "variables.inc"
.include "macros.inc"
.feature force_range
.segment "BANK_14"

BANK_THIS = $14

.export lut_SmallMapObjCHR
.export LoadNPCSprites
.export LoadMapObjects

.import lut_2x2MapObj_Down

lut_SmallMapObjCHR:
.incbin "chr/npc_sprites/princess_sprite.chr"   ; 00
.incbin "chr/npc_sprites/woman_sprite.chr"      ; 01
.incbin "chr/npc_sprites/oldlady_sprite.chr"    ; 02
.incbin "chr/npc_sprites/dancer_sprite.chr"     ; 03
.incbin "chr/npc_sprites/orb_sprite.chr"        ; 04
.incbin "chr/npc_sprites/witch_sprite.chr"      ; 05
.incbin "chr/npc_sprites/prince_sprite.chr"     ; 06
.incbin "chr/npc_sprites/soldier_sprite.chr"    ; 07
.incbin "chr/npc_sprites/scholar_sprite.chr"    ; 08
.incbin "chr/npc_sprites/punk_sprite.chr"       ; 09
.incbin "chr/npc_sprites/man_sprite.chr"        ; 0A
.incbin "chr/npc_sprites/sage_sprite.chr"       ; 0B
.incbin "chr/npc_sprites/dwarf_sprite.chr"      ; 0C
.incbin "chr/npc_sprites/mermaid_sprite.chr"    ; 0D
.incbin "chr/npc_sprites/lefein_sprite.chr"     ; 0E
.incbin "chr/npc_sprites/king_sprite.chr"       ; 0F
.incbin "chr/npc_sprites/broom_sprite.chr"      ; 10
.incbin "chr/npc_sprites/bat_sprite.chr"        ; 11
.incbin "chr/npc_sprites/garland_sprite.chr"    ; 12
.incbin "chr/npc_sprites/pirate_sprite.chr"     ; 13
.incbin "chr/npc_sprites/fairy_sprite.chr"      ; 14
.incbin "chr/npc_sprites/robot_sprite.chr"      ; 15
.incbin "chr/npc_sprites/dragon_sprite.chr"     ; 16
.incbin "chr/npc_sprites/bahamut_sprite.chr"    ; 17
.incbin "chr/npc_sprites/elfwoman_sprite.chr"   ; 18
.incbin "chr/npc_sprites/elfman_sprite.chr"     ; 19
.incbin "chr/npc_sprites/elfprince_sprite.chr"  ; 1A
.incbin "chr/npc_sprites/slab_sprite.chr"       ; 1B
.incbin "chr/npc_sprites/titan_sprite.chr"      ; 1C
.incbin "chr/npc_sprites/vampire_sprite.chr"    ; 1D

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

;; JIGS - this table is how many NPC sprites appear on each map

lut_MapObjectCount:
.byte 7  ; Coneria
.byte 8  ; Pravoka
.byte 8  ; Elfland
.byte 14 ; Melmond
.byte 14 ; Crescent Lake
.byte 14 ; Gaia
.byte 15 ; Onrac
.byte 14 ; Leifen
.byte 10 ; Coneria Castle 1F
.byte 8  ; Elfland Castle
.byte 7  ; Northwest Castle
.byte 1  ; Castle of Ordeals 1F
.byte 8  ; Temple of Fiends
.byte 0  ; Earth Cave B1
.byte 0  ; Gurgu Volcano B1
.byte 0  ; Ice Cave B1
.byte 9  ; Cardia
.byte 0  ; Bahamut's Room B1
.byte 11 ; Waterfall
.byte 13 ; Dwarf Cave
.byte 5  ; Matoya's Cave
.byte 1  ; Sarda's Cave
.byte 5  ; Marsh Cave B1
.byte 1  ; Mirage Tower 1F
.byte 4  ; Coneria Castle 2F
.byte 0  ; Castle of Ordeals 2F
.byte 0  ; Castle of Ordeals 3F
.byte 14 ; Marsh Cave B2
.byte 16 ; Marsh Cave B3
.byte 14 ; Earth Cave B2
.byte 16 ; Earth Cave B3
.byte 16 ; Earth Cave B4
.byte 11 ; Earth Cave B5
.byte 0  ; Gurgu Volcano B2
.byte 0  ; Gurgu Volcano B3
.byte 0  ; Gurgu Volcano B4
.byte 1  ; Gurgu Volcano B5
.byte 0  ; Ice Cave B2
.byte 0  ; Ice Cave B3
.byte 3  ; Bahamut's Room B2
.byte 1  ; Mirage Tower 2F
.byte 1  ; Mirage Tower 3F
.byte 1  ; Sea Shrine B5
.byte 0  ; Sea Shrine B4
.byte 0  ; Sea Shrine B3
.byte 0  ; Sea Shrine B2
.byte 10 ; Sea Shrine B1
.byte 0  ; Sky Palace 1F
.byte 1  ; Sky Palace 2F
.byte 1  ; Sky Palace 3F
.byte 0  ; Sky Palace 4F
.byte 1  ; Sky Palace 5F
.byte 0  ; Temple of Fiends 1F
.byte 0  ; Temple of Fiends 2F
.byte 1  ; Temple of Fiends 3F
.byte 0  ; Temple of Fiends 4F - Earth
.byte 0  ; Temple of Fiends 5F - Fire
.byte 0  ; Temple of Fiends 6F - Water
.byte 0  ; Temple of Fiends 7F - Wind
.byte 3  ; Temple of Fiends 8F - Chaos
.byte 1  ; Titan's Tunnel





; Map sprites
; 3 bytes
;  +0: ID (00 = no sprite)
;  +1: bits 0-5: X coordinate
;      bit  6:   don't move
;      bit  7:   "in room" flag
;  +2: Y coordinate

;.align $100 - Enable in case sprites in maps wig out

lut_MapObjects:
.word MAPOBJ_LIST_0   ; Coneria
.word MAPOBJ_LIST_1   ; Pravoka
.word MAPOBJ_LIST_2   ; Elfland
.word MAPOBJ_LIST_3   ; Melmond
.word MAPOBJ_LIST_4   ; Crescent Lake
.word MAPOBJ_LIST_5   ; Gaia
.word MAPOBJ_LIST_6   ; Onrac
.word MAPOBJ_LIST_7   ; Leifen
.word MAPOBJ_LIST_8   ; Coneria Castle 1F
.word MAPOBJ_LIST_9   ; Elfland Castle
.word MAPOBJ_LIST_10  ; Northwest Castle
.word MAPOBJ_LIST_11  ; Castle of Ordeals 1F
.word MAPOBJ_LIST_12  ; Temple of Fiends
.word MAPOBJ_LIST_13  ; Earth Cave B1
.word MAPOBJ_LIST_14  ; Gurgu Volcano B1
.word MAPOBJ_LIST_15  ; Ice Cave B1
.word MAPOBJ_LIST_16  ; Cardia
.word MAPOBJ_LIST_17  ; Bahamut's Room B1
.word MAPOBJ_LIST_18  ; Waterfall
.word MAPOBJ_LIST_19  ; Dwarf Cave
.word MAPOBJ_LIST_20  ; Matoya's Cave
.word MAPOBJ_LIST_21  ; Sarda's Cave
.word MAPOBJ_LIST_22  ; Marsh Cave B1
.word MAPOBJ_LIST_23  ; Mirage Tower 1F
.word MAPOBJ_LIST_24  ; Coneria Castle 2F
.word MAPOBJ_LIST_25  ; Castle of Ordeals 2F
.word MAPOBJ_LIST_26  ; Castle of Ordeals 3F
.word MAPOBJ_LIST_27  ; Marsh Cave B2
.word MAPOBJ_LIST_28  ; Marsh Cave B3
.word MAPOBJ_LIST_29  ; Earth Cave B2
.word MAPOBJ_LIST_30  ; Earth Cave B3
.word MAPOBJ_LIST_31  ; Earth Cave B4
.word MAPOBJ_LIST_32  ; Earth Cave B5
.word MAPOBJ_LIST_33  ; Gurgu Volcano B2
.word MAPOBJ_LIST_34  ; Gurgu Volcano B3
.word MAPOBJ_LIST_35  ; Gurgu Volcano B4
.word MAPOBJ_LIST_36  ; Gurgu Volcano B5
.word MAPOBJ_LIST_37  ; Ice Cave B2
.word MAPOBJ_LIST_38  ; Ice Cave B3
.word MAPOBJ_LIST_39  ; Bahamut's Room B2
.word MAPOBJ_LIST_40  ; Mirage Tower 2F
.word MAPOBJ_LIST_41  ; Mirage Tower 3F
.word MAPOBJ_LIST_42  ; Sea Shrine B5
.word MAPOBJ_LIST_43  ; Sea Shrine B4
.word MAPOBJ_LIST_44  ; Sea Shrine B3
.word MAPOBJ_LIST_45  ; Sea Shrine B2
.word MAPOBJ_LIST_46  ; Sea Shrine B1
.word MAPOBJ_LIST_47  ; Sky Palace 1F
.word MAPOBJ_LIST_48  ; Sky Palace 2F
.word MAPOBJ_LIST_49  ; Sky Palace 3F
.word MAPOBJ_LIST_50  ; Sky Palace 4F
.word MAPOBJ_LIST_51  ; Sky Palace 5F
.word MAPOBJ_LIST_52  ; Temple of Fiends 1F
.word MAPOBJ_LIST_53  ; Temple of Fiends 2F
.word MAPOBJ_LIST_54  ; Temple of Fiends 3F
.word MAPOBJ_LIST_55  ; Temple of Fiends 4F - Earth
.word MAPOBJ_LIST_56  ; Temple of Fiends 5F - Fire
.word MAPOBJ_LIST_57  ; Temple of Fiends 6F - Water
.word MAPOBJ_LIST_58  ; Temple of Fiends 7F - Wind
.word MAPOBJ_LIST_59  ; Temple of Fiends 8F - Chaos
.word MAPOBJ_LIST_60  ; Titan's Tunnel


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;; FOR REFERENCE ;;;;;;;;;;;;;;;;;;;;

;; I didn't put a + or - on every map, but the easiest way to calculate NPC positions
;; would be to use FFHackster, then add the offsets from this list and adjust as needed

;ID   ##    X   Y
;00 ; 00 ;  16  20 ; Coneria
;01 ; 01 ;  12  15 ; Pravoka
;02 ; 02 ;  11  17 ; Elfland
;03 ; 03 ;  15  18 ; Melmond  (not 16 x?)
;04 ; 04 ;  6   19 ; Crescent Lake
;05 ; 05 ; -3  -3  ; Gaia
;06 ; 06 ;  6   12 ; Onrac
;07 ; 07 ;  4   20 ; Leifen
;08 ; 08 ;  19  12 ; Coneria Castle 1F
;09 ; 09 ;  18  16 ; Elfland Castle
;0A ; 10 ;  15  19 ; Northwest Castle
;0B ; 11 ;  19  19 ; Castle of Ordeals 1F
;0C ; 12 ;  11  13 ; Temple of Fiends
;0D ; 13 ;  6  -3  ; Earth Cave B1
;0E ; 14 ;  15  16 ; Gurgu Volcano B1
;0F ; 15 ;  6   16 ; Ice Cave B1
;10 ; 16 ;  0   0  ; Cardia
;11 ; 17 ;  29  4  ; Bahamut's Room B1
;12 ; 18 ;  0   1  ; Waterfall
;13 ; 19 ;  19  4  ; Dwarf Cave
;14 ; 20 ;  23  24 ; Matoya's Cave
;15 ; 21 ;  18  23 ; Sarda's Cave
;16 ; 22 ;  8   3  ; Marsh Cave B1
;17 ; 23 ;  16  15 ; Mirage Tower 1F
;18 ; 24 ;  19  14 ; Coneria Castle 2F
;19 ; 25 ;  19  19 ; Castle of Ordeals 2F
;1A ; 26 ;  19  19 ; Castle of Ordeals 3F
;1B ; 27 ;  1   1  ; Marsh Cave B2
;1C ; 28 ;  1   2  ; Marsh Cave B3
;1D ; 29 ;  6   2  ; Earth Cave B2
;1E ; 30 ;  1   4  ; Earth Cave B3
;1F ; 31 ; -3   3  ; Earth Cave B4
;20 ; 32 ;  8  -8  ; Earth Cave B5
;21 ; 33 ;  16  15 ; Gurgu Volcano B2
;22 ; 34 ;  6   6  ; Gurgu Volcano B3
;23 ; 35 ;  7   7  ; Gurgu Volcano B4
;24 ; 36 ;  0   0  ; Gurgu Volcano B5
;25 ; 37 ;  1   16 ; Ice Cave B2
;26 ; 38 ;  1   7  ; Ice Cave B3
;27 ; 39 ;  10  3  ; Bahamut's Room B2
;28 ; 40 ;  16  15 ; Mirage Tower 2F
;29 ; 41 ;  23  23 ; Mirage Tower 3F
;2A ; 42 ;  3   2  ; Sea Shrine B5
;2B ; 43 ; -2   5  ; Sea Shrine B4
;2C ; 44 ;  4   9  ; Sea Shrine B3
;2D ; 45 ; -1   7  ; Sea Shrine B2
;2E ; 46 ;  16  16 ; Sea Shrine B1
;2F ; 47 ;  12  9  ; Sky Palace 1F
;30 ; 48 ;  12  10 ; Sky Palace 2F
;31 ; 49 ;  8   4  ; Sky Palace 3F
;32 ; 50 ; -4  -4  ; Sky Palace 4F
;33 ; 51 ;  24  4  ; Sky Palace 5F
;34 ; 52 ;  11  13 ; Temple of Fiends 1F
;35 ; 53 ;  11  13 ; Temple of Fiends 2F
;36 ; 54 ;  11  13 ; Temple of Fiends 3F
;37 ; 55 ;  12  15 ; Temple of Fiends 4F - Earth
;38 ; 56 ;  4   2  ; Temple of Fiends 5F - Fire
;39 ; 57 ;  16  16 ; Temple of Fiends 6F - Water
;3A ; 58 ;  5   12 ; Temple of Fiends 7F - Wind
;3B ; 59 ;  16  15 ; Temple of Fiends 8F - Chaos
;3C ; 60 ;  23  20 ; Titan's Tunnel


; 00 ; Coneria
;     ID   X      Y
MAPOBJ_LIST_0:
.byte $31,$10+16,$01+21 ; Guard (guard is down 1 so he doesn't get stuck on no-move tiles)
.byte $32,$07+16,$0D+20
.byte $34,$44+16,$01+20
.byte $35,$0F+16,$0C+20
.byte $36,$12+16,$14+20
.byte $37,$05+16,$06+20
.byte $38,$1B+16,$05+20
.byte $39,$1E+16,$0B+20

; 01 ; Pravoka
MAPOBJ_LIST_1:
.byte $04,$45+12,$07+15 ; Bikke
.byte $3F,$0D+12,$10+15 ; Townsfolk
.byte $3F,$0C+12,$03+15
.byte $3F,$18+12,$15+15
.byte $40,$1D+12,$08+15
.byte $41,$08+12,$0E+15
.byte $42,$13+12,$0B+15
.byte $43,$14+12,$19+15

; 02 ; Elfland
MAPOBJ_LIST_2:
.byte $4D,$25+11,$17+17 ; Elves
.byte $4E,$26+11,$01+17
.byte $4F,$1C+11,$0B+17
.byte $50,$58+11,$0F+17
.byte $51,$09+11,$0F+17
.byte $52,$0A+11,$06+17
.byte $53,$44+11,$05+17
.byte $54,$4F+11,$1B+17

; 03 ; Melmond
MAPOBJ_LIST_3:
.byte $0B,$1A+15,$01+18 ; Unne
.byte $68,$08+15,$03+18 ; Farmers'n such
.byte $69,$16+15,$03+18
.byte $6A,$15+15,$11+18
.byte $6B,$4C+15,$01+18
.byte $6C,$0E+15,$0D+18
.byte $6D,$0F+15,$16+18
.byte $6E,$5D+15,$12+18
.byte $6F,$18+15,$07+18
.byte $70,$18+15,$17+18
.byte $71,$1D+15,$09+18
.byte $72,$14+15,$1A+18
.byte $73,$16+15,$0C+18
.byte $74,$19+15,$0D+18

; 04 ; Crescent Lake
MAPOBJ_LIST_4:
.byte $15,$6A+6,$0A+19 ; Dr. Canoe
.byte $77,$66+6,$0B+19 ; Sages
.byte $78,$64+6,$0A+19
.byte $79,$63+6,$08+19
.byte $7A,$63+6,$06+19
.byte $7B,$64+6,$04+19
.byte $7C,$66+6,$03+19
.byte $7D,$68+6,$03+19
.byte $7E,$6A+6,$04+19
.byte $7F,$6B+6,$06+19
.byte $80,$6B+6,$08+19
.byte $81,$45+6,$01+19 ; Sleeping guy
.byte $82,$68+6,$0B+19
.byte $83,$10+6,$07+19 ; one of these is a lady and not a sage, maybe this one?

; 05 ; Gaia
MAPOBJ_LIST_5:
.byte $13,$71-3,$13-3 ; Fairy
.byte $AE,$38-3,$3C-3 ; Gaia townsfolk
.byte $AF,$29-3,$3B-3
.byte $B0,$3A-3,$29-3
.byte $B1,$0A-3,$34-3
.byte $B2,$26-3,$36-3
.byte $B3,$0C-3,$1F-3
.byte $B4,$1B-3,$2B-3
.byte $B5,$3A-3,$31-3
.byte $B6,$10-3,$10-3
.byte $B7,$17-3,$3B-3
.byte $B8,$29-3,$33-3
.byte $B9,$69-3,$31-3
.byte $BA,$17-3,$36-3

; 06 ; Onrac
MAPOBJ_LIST_6:
.byte $10,$6D+6,$1E+12 ; Submarine Engineer
.byte $93,$12+6,$18+12
.byte $94,$09+6,$17+12
.byte $95,$15+6,$07+12
.byte $96,$5E+6,$15+12
.byte $97,$11+6,$0C+12
.byte $98,$14+6,$0C+12
.byte $99,$53+6,$03+12
.byte $9A,$6E+6,$17+12
.byte $9B,$11+6,$27+12
.byte $9C,$1A+6,$0E+12
.byte $9D,$1F+6,$0B+12
.byte $9E,$04+6,$17+12
.byte $9F,$29+6,$1B+12
.byte $A0,$1C+6,$04+12

; 07 ; Leifen
MAPOBJ_LIST_7:
.byte $BB,$58+4,$15+20 ; Chime-giver
.byte $BC,$04+4,$08+20 ; Leifen peoples
.byte $BD,$53+4,$13+20
.byte $BE,$21+4,$08+20
.byte $BF,$50+4,$0A+20
.byte $C0,$1A+4,$0E+20
.byte $C1,$21+4,$0D+20
.byte $C2,$23+4,$16+20
.byte $C3,$09+4,$0F+20
.byte $C4,$56+4,$0A+20
.byte $C5,$06+4,$0A+20
.byte $C6,$1C+4,$12+20
.byte $C8,$0E+4,$14+20
.byte $C9,$07+4,$0D+20

; 08 ; Coneria Castle 1F
MAPOBJ_LIST_8:
.byte $20,$4E+19,$1C+12 ; Guard near lower pillar
.byte $20,$4A+19,$12+12 ; Guard near stairs
.byte $22,$02+19,$0A+12
.byte $23,$08+19,$0B+12
.byte $25,$47+19,$1C+12
.byte $26,$47+19,$0F+12 ; Invisible lady
.byte $29,$C6+19,$18+12
.byte $2A,$91+19,$17+12
.byte $2C,$56+19,$09+12
.byte $2E,$4E+19,$0F+12

; 09 ; Elfland Castle
MAPOBJ_LIST_9:
.byte $05,$C9+18,$05+16 ; Elf Doctor
.byte $06,$C8+18,$06+16 ; Elf Prince
.byte $45,$41+18,$01+16 ; Elves
.byte $46,$17+18,$0E+16
.byte $47,$02+18,$18+16
.byte $48,$13+18,$04+16
.byte $49,$4F+18,$14+16
.byte $4A,$51+18,$14+16

; 0A ; Northwest Castle
MAPOBJ_LIST_10:
.byte $07,$D0+15,$06+19 ; Astos
.byte $57,$16+15,$08+19 ; bats
.byte $57,$1C+15,$03+19
.byte $57,$04+15,$03+19
.byte $57,$13+15,$10+19
.byte $57,$0B+15,$0A+19
.byte $57,$04+15,$14+19

; 0B ; Castle of Ordeals 1F
MAPOBJ_LIST_11:
.byte $84,$4C+19,$0D+19 ; Creepy vanishing sage

; 0C ; Temple of Fiends (Present)
MAPOBJ_LIST_12:
.byte $02,$D4+11,$15+13 ; Garland
.byte $03,$D4+11,$12+13 ; Princess
.byte $3A,$91+11,$13+13 ; Sky Warrior bats
.byte $3B,$92+11,$12+13
.byte $3C,$92+11,$13+13
.byte $3D,$97+11,$13+13
.byte $3E,$96+11,$13+13
.byte $CA,$D4+11,$11+13 ; Black orb

; 0D ; Earth Cave B1
MAPOBJ_LIST_13:
;.byte $00,$00,$00

; 0E ; Gurgu Volcano B1
MAPOBJ_LIST_14:
;.byte $00,$00,$00

; 0F ; Ice Cave B1
MAPOBJ_LIST_15:
;.byte $13,$6F,$1E ; surprise fairy!
;.byte $00,$00,$00 ; fixed ^

; 10 ; Cardia
MAPOBJ_LIST_16:
.byte $85,$1C,$09 ; Dragons
.byte $86,$29,$06
.byte $87,$29,$16
.byte $88,$A6,$34
.byte $8A,$18,$1F
.byte $8B,$91,$25
.byte $8C,$25,$1E
.byte $8D,$0D,$06
.byte $8E,$95,$25

; 11 ; Bahamut's Room B1
MAPOBJ_LIST_17:
;.byte $00,$00,$00

; 12 ; Waterfall
MAPOBJ_LIST_18:
.byte $11,$94+0,$35+1 ; must be robot
.byte $57,$08+0,$04+1 ; these are bats -- this one has been moved down 1 tile so as not to be in the wall
.byte $57,$0F+0,$17+1
.byte $57,$0A+0,$29+1
.byte $57,$17+0,$19+1
.byte $57,$19+0,$09+1
.byte $57,$28+0,$09+1
.byte $57,$21+0,$18+1
.byte $57,$32+0,$23+1
.byte $57,$2B+0,$29+1
.byte $57,$3A+0,$2C+1

; 13 ; Dwarf Cave
MAPOBJ_LIST_19:
.byte $08,$50+19,$2D+4 ; TNT dwarf
.byte $09,$C7+19,$02+4 ; Blacksmith
.byte $58,$4E+19,$15+4 ; dwarves
.byte $59,$03+19,$0A+4
.byte $5A,$16+19,$11+4
.byte $5B,$0E+19,$07+4
.byte $5C,$D5+19,$04+4
.byte $5D,$02+19,$04+4
.byte $5E,$0A+19,$0F+4
.byte $5F,$0A+19,$13+4
.byte $60,$D3+19,$0E+4
.byte $61,$0D+19,$02+4
.byte $63,$12+19,$0A+4

; 14 ; Matoya's Cave
MAPOBJ_LIST_20:
.byte $0A,$C8+23,$01+24 ; Matoya
.byte $64,$03+23,$0D+24 ; Brooms
.byte $65,$8B+23,$0A+24
.byte $66,$83+23,$07+24
.byte $67,$CD+23,$03+24

; 15 ; Sarda's Cave
MAPOBJ_LIST_21:
.byte $0D,$C2+18,$02+23 ;; Its Sarda!

; 16 ; Marsh Cave B1
MAPOBJ_LIST_22:
.byte $57,$04+8,$03+3 ; bats
.byte $57,$1E+8,$24+3
.byte $57,$10+8,$15+3
.byte $57,$34+8,$16+3
.byte $57,$18+8,$1C+3

; 17 ; Mirage Tower 1F
MAPOBJ_LIST_23:
.byte $CE,$D4+16,$05+15 ; Robot

; 18 ; Coneria Castle 2F
MAPOBJ_LIST_24:
.byte $01,$CC+19,$04+14 ; King
.byte $12,$CB+19,$05+14 ; Princess
.byte $2B,$42+19,$1D+14 ; Guards
.byte $30,$4D+19,$09+14

; 19 ; Castle of Ordeals 2F
MAPOBJ_LIST_25:
;.byte $00,$00,$00

; 1A ; Castle of Ordeals 3F
MAPOBJ_LIST_26:
;.byte $00,$00,$00

; 1B ; Marsh Cave B2
MAPOBJ_LIST_27:
.byte $57,$0E+1,$11+1 ; bats
.byte $57,$1B+1,$0B+1
.byte $57,$06+1,$10+1
.byte $57,$0F+1,$2D+1
.byte $57,$11+1,$33+1
.byte $57,$16+1,$30+1
.byte $57,$1D+1,$35+1
.byte $57,$22+1,$32+1
.byte $57,$26+1,$2B+1
.byte $57,$31+1,$1E+1
.byte $57,$36+1,$28+1
.byte $57,$2F+1,$28+1
.byte $57,$2E+1,$33+1
.byte $57,$3A+1,$38+1

; 1C ; Marsh Cave B3
MAPOBJ_LIST_28:
.byte $57,$06+1,$0A+2 ; all the bats
.byte $57,$1E+1,$08+2
.byte $57,$11+1,$10+2
.byte $57,$2C+1,$10+2
.byte $57,$2A+1,$1D+2
.byte $57,$33+1,$04+2
.byte $57,$2F+1,$22+2
.byte $57,$1F+1,$18+2
.byte $57,$1D+1,$20+2
.byte $57,$10+1,$1F+2
.byte $57,$02+1,$1E+2
.byte $57,$06+1,$2A+2
.byte $57,$05+1,$31+2
.byte $57,$14+1,$2D+2
.byte $57,$1E+1,$36+2
.byte $57,$1F+1,$2F+2

; 1D ; Earth Cave B2
MAPOBJ_LIST_29:
.byte $57,$0A+6,$0B+2 ; bats
.byte $57,$12+6,$0F+2
.byte $57,$0A+6,$15+2
.byte $57,$15+6,$16+2
.byte $57,$0F+6,$1F+2
.byte $57,$19+6,$24+2
.byte $57,$1B+6,$31+2
.byte $57,$21+6,$28+2
.byte $57,$1D+6,$19+2
.byte $57,$27+6,$16+2
.byte $57,$1F+6,$12+2
.byte $57,$A8+6,$10+2
.byte $57,$26+6,$29+2
.byte $00,$00+6,$00+2

; 1E ; Earth Cave B3
MAPOBJ_LIST_30:
.byte $0C,$DA+1,$26+4 ; Vampire
.byte $16,$5A+1,$1B+4 ; Earth Plate
.byte $57,$8B+1,$09+4 ; bats
.byte $57,$8A+1,$0A+4
.byte $57,$89+1,$09+4
.byte $57,$0F+1,$10+4
.byte $57,$18+1,$0F+4
.byte $57,$11+1,$22+4
.byte $57,$11+1,$20+4
.byte $57,$12+1,$22+4
.byte $57,$1C+1,$12+4
.byte $57,$1A+1,$13+4
.byte $57,$23+1,$14+4
.byte $57,$27+1,$10+4
.byte $57,$2C+1,$0C+4
.byte $57,$2F+1,$0E+4

; 1F ; Earth Cave B4
MAPOBJ_LIST_31:
.byte $57,$93-3,$28+3 ; baaats
.byte $57,$90-3,$26+3
.byte $57,$93-3,$24+3
.byte $57,$0A-3,$23+3
.byte $57,$0C-3,$2A+3
.byte $57,$18-3,$15+3
.byte $57,$16-3,$17+3
.byte $57,$13-3,$1B+3
.byte $57,$15-3,$0C+3
.byte $57,$12-3,$12+3
.byte $57,$A7-3,$0C+3
.byte $57,$20-3,$12+3
.byte $57,$24-3,$17+3
.byte $57,$21-3,$18+3
.byte $57,$24-3,$17+3
.byte $57,$21-3,$18+3

; 20 ; Earth Cave B5
MAPOBJ_LIST_32:
.byte $1B,$CC+8,$2A-8 ; Earth Orb
.byte $57,$11+8,$31-8 ; dang bats
.byte $57,$0F+8,$23-8
.byte $57,$1A+8,$25-8
.byte $57,$1E+8,$2E-8
.byte $57,$1F+8,$32-8
.byte $57,$20+8,$37-8
.byte $57,$24+8,$2A-8
.byte $57,$1C+8,$1F-8
.byte $57,$12+8,$18-8
.byte $57,$14+8,$1A-8

; 21 ; Gurgu Volcano B2
MAPOBJ_LIST_33:
;.byte $00,$00,$00

; 22 ; Gurgu Volcano B3
MAPOBJ_LIST_34:
;.byte $00,$00,$00

; 23 ; Gurgu Volcano B4
MAPOBJ_LIST_35:
;.byte $00,$00,$00

; 24 ; Gurgu Volcano B5
MAPOBJ_LIST_36:
;.byte $1C,$C7,$37 ; Fire Orb

; 25 ; Ice Cave B2
MAPOBJ_LIST_37:
;.byte $00,$00,$00

; 26 ; Ice Cave B3
MAPOBJ_LIST_38:
;.byte $00,$00,$00

; 27 ; Bahamut's Room B2
MAPOBJ_LIST_39:
.byte $0E,$D5+10,$03+3 ; Bahamut
.byte $8F,$D3+10,$07+3 ; Dragons
.byte $90,$D7+10,$07+3

; 28 ; Mirage Tower 2F
MAPOBJ_LIST_40:
.byte $CC,$13+16,$04+15 ; Robot

; 29 ; Mirage Tower 3F
MAPOBJ_LIST_41:
.byte $CD,$C9+23,$0A+23 ; Transporter

; 2A ; Sea Shrine B5
MAPOBJ_LIST_42:
.byte $1D,$CC+3,$08+2 ; Water Orb

; 2B ; Sea Shrine B4
MAPOBJ_LIST_43:
;.byte $00,$00,$00

; 2C ; Sea Shrine B3
MAPOBJ_LIST_44:
;.byte $00,$00,$00

; 2D ; Sea Shrine B2
MAPOBJ_LIST_45:
;.byte $00,$00,$00

; 2E ; Sea Shrine B1
MAPOBJ_LIST_46:
.byte $A3,$86+16,$12+16 ; mermaids!
.byte $A4,$93+16,$05+16
.byte $A5,$9A+16,$12+16
.byte $A6,$84+16,$19+16
.byte $A7,$93+16,$12+16
.byte $A8,$94+16,$0C+16
.byte $A9,$8B+16,$0B+16
.byte $AA,$84+16,$0B+16
.byte $AB,$85+16,$04+16
.byte $AC,$94+16,$1A+16

; 2F ; Sky Palace 1F
MAPOBJ_LIST_47:
;.byte $00,$00,$00

; 30 ; Sky Palace 2F
MAPOBJ_LIST_48:
.byte $16,$DA+12,$1B+10 ; Earth plate? ???

; 31 ; Sky Palace 3F
MAPOBJ_LIST_49:
.byte $CF,$5E+8,$19+4 ; Window

; 32 ; Sky Palace 4F
MAPOBJ_LIST_50:
;.byte $00,$00,$00

; 33 ; Sky Palace 5F
MAPOBJ_LIST_51:
.byte $1E,$C7+24,$05+4 ; Wind Orb

; 34 ; Temple of Fiends 1F
MAPOBJ_LIST_52:
;.byte $00,$00,$00

; 35 ; Temple of Fiends 2F
MAPOBJ_LIST_53:
;.byte $00,$00,$00

; 36 ; Temple of Fiends 3F
MAPOBJ_LIST_54:
.byte $17,$D4+11,$10+13 ; Evil plate?

; 37 ; Temple of Fiends 4F - Earth
MAPOBJ_LIST_55:
;.byte $00,$00,$00

; 38 ; Temple of Fiends 5F - Fire
MAPOBJ_LIST_56:
;.byte $00,$00,$00

; 39 ; Temple of Fiends 6F - Water
MAPOBJ_LIST_57:
;.byte $00,$00,$00

; 3A ; Temple of Fiends 7F - Wind
MAPOBJ_LIST_58:
;.byte $00,$00,$00

; 3B ; Temple of Fiends 8F - Chaos
MAPOBJ_LIST_59:
.byte $18,$CF+16,$13+15 ; Garland's speech
.byte $19,$CF+16,$12+15 ; Garland's speech
.byte $1A,$CF+16,$11+15 ; Chaos fight!

; 3C ; Titan's Tunnel
MAPOBJ_LIST_60:
.byte $14,$48+23,$07+20 ; Titan









;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Map Object CHR Loading  [$E99E :: 0x3E9AE]
;;
;;   Loads CHR for map objects (townspeople, etc)  For standard maps only
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

LoadNPCSprites:
    LDA $2002      ; reset PPU toggle
    LDA #$11
    STA $2006
    LDA #$00
    STA $2006      ; set PPU Addr to $1100 (start of map object CHR)

    LDA cur_map    ; get current map ID
    ASL A
    TAX
    LDA lut_MapObjects, X
    STA tmp+4
    LDA lut_MapObjects+1, X
    STA tmp+5
    
    LDX cur_map
    LDA lut_MapObjectCount, X
    STA tmp+6

    LDY #0         ; zero out Y (our source index)
  @ObjLoop:
    LDA (tmp+4), Y       ; get object ID
    TAX                  ; put it in X
    LDA lut_MapObjGfx, X ; index to get graphic ID based on object ID
    CLC
    ADC #>lut_SmallMapObjCHR  ; add to high byte of pointer
    STA tmp+1
    LDA #<lut_SmallMapObjCHR
    STA tmp              ; CHR source pointer (tmp) now = lut_MapObjCHR + (graphic_id * $100)

    TYA              ; back up obj source index by pushing it to the stack
    PHA
    LDY #0           ; clear Y for upcoming CHR loading loop
  @CHRLoop:
      LDA (tmp), Y   ; load 256 bytes of CHR (16 tiles -- 1 row)
      STA $2007
      INY
      BNE @CHRLoop
    PLA              ; pull obj source index from stack
    CLC
    ADC #$03         ; increment it by 3
    TAY              ; put it back in Y
    DEC tmp+6        ; loop until proper amount of objects have been loaded
    BNE @ObjLoop

    RTS              ; then exit


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Load Map Objects  [$E7EB :: 0x3E7FB]
;;
;;    This loads all objects for the current standard map.
;;
;;    Each map has $30 bytes of object information.  $0F objects per map, 3 bytes
;;  per object (last 3 bytes are padding and go unused):
;;   byte 0 = object ID
;;   byte 1 = object X coord and behavior flags
;;   byte 2 = object Y coord
;;
;;    Objects get loaded to the 'mapobj' buffer.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

LoadMapObjects:
    LDA #<mapobj
    STA tmp+14
    LDA #>mapobj
    STA tmp+15      ; set dest pointer to point to 'mapobj'

    LDA #0          ; JIGS - first, clear out any previous data
    TAY
  @ClearLoop:
    STA (tmp+14), Y
    DEY
    BNE @ClearLoop

    LDX cur_map
    LDA lut_MapObjectCount, X
    BEQ @NoObjects
    STA tmp+11      ; set loop counter to $0F ($0F objects to load per map)

    LDA cur_map
    ASL A
    TAX 
    LDA lut_MapObjects, X
    STA tmp+12
    LDA lut_MapObjects+1, X
    STA tmp+13

  @Loop:
     LDY #0
     LDA (tmp+12), Y          ; read the object ID from source buffer
     JSR LoadSingleMapObject  ; load the object

     LDA tmp+12           ; add 3 to the source pointer to look at the next map object
     CLC
     ADC #3
     STA tmp+12
     LDA tmp+13
     ADC #0
     STA tmp+13

     DEC tmp+11           ; decrement loop counter
     BNE @Loop            ; and loop until all $F objects have been loaded
   @NoObjects:
    RTS        ; then exit!

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Load Single Map Object [$E83B :: 0x3E84B]
;;
;;    Loads a single map object from given source buffer
;;
;;  IN:       A = ID of this map object
;;       tmp+12 = pointer to source map data
;;       tmp+14 = pointer to dest buffer (to load object data to).  Typically points somewhere in 'mapobj'
;;
;;    tmp+14 is incremented after this routine is called so that the next object will be
;;  loaded into the next spot in RAM.  Source pointer is not incremented, however.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

LoadSingleMapObject:
    LDY #<mapobj_rawid
    STA (tmp+14), Y         ; record this object's raw ID

    LDY #0                  ; reset Y to zero so we can start copying the rest of the object info
    TAX                     ; put object ID in X for indexing
    LDA game_flags, X       ; get the object's visibility flag
    AND #GMFLG_OBJVISIBLE   ; isolate it
    BEQ :+                  ;   if the object is invisible, replace the ID with zero (no object)
      TXA                   ;   otherwise, restore the raw ID into A (unchanged)
  : STA (tmp+14), Y         ; record raw ID (or 0 if sprite is invisible) as the 'to-use' object ID

    INY                     ; inc Y to look at next source byte
    LDA (tmp+12), Y         ; get next source byte (X coord and behavior flags)
    PHA                     ; back it up
    AND #$C0                ; isolate the behavior flags
    STA (tmp+14), Y         ; record them

    INY                     ; inc Y to look at next source byte
    LDA (tmp+12), Y         ; get next source byte (Y coord)
    TAX                     ; back it up
    PLA                     ; reload backed up X coord
    AND #$3F                ; mask out the low bits (remove behavior flags, wrap to 64 tiles)
    STA (tmp+14), Y         ; and record it as this object's physical X position
    LDY #<mapobj_gfxX
    STA (tmp+14), Y         ;  and as the object's graphical X position

    TXA                     ; restore backed up Y coord
    AND #$3F                ; isolate low bits (wrap to 64 tiles)
    LDY #<mapobj_physY
    STA (tmp+14), Y         ; record as physical Y coord
    LDY #<mapobj_gfxY
    STA (tmp+14), Y         ; and graphical Y coord

   ; LDY #<mapobj_ctrX       ; zero movement counters and speed vars
   ; LDA #0
   ; STA (tmp+14), Y
   ; INY
   ; STA (tmp+14), Y
   ; INY
   ; STA (tmp+14), Y
   ; INY
   ; STA (tmp+14), Y
   ;
   ; LDY #<mapobj_movectr    ; zero some other stuff
   ; STA (tmp+14), Y
   ; INY
   ; STA (tmp+14), Y
   ; INY
   ; STA (tmp+14), Y

    LDY #<mapobj_tsaptr      ; set the object's TSA pointer so that they're facing downward
    LDA #<lut_2x2MapObj_Down
    STA (tmp+14), Y
    INY
    LDA #>lut_2x2MapObj_Down
    STA (tmp+14), Y

    LDA tmp+14              ; increment the dest pointer to point to the next object's space in RAM
    CLC
    ADC #$10
    STA tmp+14

    RTS                     ; and exit!













.byte "END OF BANK 14"
