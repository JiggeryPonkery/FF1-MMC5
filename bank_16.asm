.include "Constants.inc"
.include "variables.inc"
.include "macros.inc"

.segment "BANK_16"

BANK_THIS = $16

;; Info from Anomie's disassembly!

; Map offsets from this address. Of the 16-bit value, bits 0-13 are the pointer
; within the bank and bits 14-15 select the bank.

;.byte $80,$00    ; 00 ; Coneria
;.byte $87,$82    ; 01 ; Pravoka
;.byte $38,$06    ; 02 ; Elfland
;.byte $1A,$09    ; 03 ; Melmond
;.byte $E0,$0B    ; 04 ; Crescent Lake
;.byte $13,$0F    ; 05 ; Gaia
;.byte $AA,$13    ; 06 ; Onrac
;.byte $75,$17    ; 07 ; Leifen
;.byte $FD,$19    ; 08 ; Coneria Castle 1F
;.byte $76,$1C    ; 09 ; Elfland Castle
;.byte $E9,$1E    ; 0A ; Northwest Castle
;.byte $6D,$21    ; 0B ; Castle of Ordeals 1F
;.byte $9F,$22    ; 0C ; Temple of Fiends
;.byte $69,$25    ; 0D ; Earth Cave B1
;.byte $70,$28    ; 0E ; Gurgu Volcano B1
;.byte $37,$2A    ; 0F ; Ice Cave B1
;.byte $17,$2C    ; 10 ; Cardia
;.byte $AE,$2F    ; 11 ; Bahamut's Room B1
;.byte $D6,$30    ; 12 ; Waterfall
;.byte $94,$36    ; 13 ; Dwarf Cave
;.byte $7B,$38    ; 14 ; Matoya's Cave
;.byte $72,$39    ; 15 ; Sarda's Cave
;.byte $80,$3A    ; 16 ; Marsh Cave B1
;.byte $81,$3C    ; 17 ; Mirage Tower 1F
;.byte $F6,$3E    ; 18 ; Coneria Castle 2F

;; next bank   ; v-- added $40 so the high byte would point to actual bank data without needing extra code to adjust it
;.byte $06,$80 ; $40   ; 19 ; Castle of Ordeals 2F
;.byte $9B,$81 ; $41   ; 1A ; Castle of Ordeals 3F
;.byte $DF,$82 ; $42   ; 1B ; Marsh Cave B2
;.byte $88,$87 ; $47   ; 1C ; Marsh Cave B3
;.byte $E8,$8D ; $4D   ; 1D ; Earth Cave B2
;.byte $44,$91 ; $51   ; 1E ; Earth Cave B3
;.byte $44,$95 ; $55   ; 1F ; Earth Cave B4
;.byte $96,$99 ; $59   ; 20 ; Earth Cave B5
;.byte $C8,$9B ; $5B   ; 21 ; Gurgu Volcano B2
;.byte $38,$9F ; $5F   ; 22 ; Gurgu Volcano B3
;.byte $64,$A4 ; $64   ; 23 ; Gurgu Volcano B4
;.byte $69,$A8 ; $68   ; 24 ; Gurgu Volcano B5
;.byte $31,$AE ; $6E   ; 25 ; Ice Cave B2
;.byte $BF,$B0 ; $70   ; 26 ; Ice Cave B3
;.byte $58,$B4 ; $74   ; 27 ; Bahamut's Room B2
;.byte $3C,$B6 ; $76   ; 28 ; Mirage Tower 2F
;.byte $FA,$B8 ; $78   ; 29 ; Mirage Tower 3F
;.byte $D8,$B9 ; $79   ; 2A ; Sea Shrine B5
;.byte $1F,$BD ; $7D   ; 2B ; Sea Shrine B4
;.byte $D0,$BF ; $7F   ; 2C ; Sea Shrine B3

;;; third bank        
;.byte $03,$83    ; 2D ; Sea Shrine B2
;.byte $2C,$86    ; 2E ; Sea Shrine B1
;.byte $41,$89    ; 2F ; Sky Palace 1F
;.byte $7C,$8B    ; 30 ; Sky Palace 2F
;.byte $49,$8E    ; 31 ; Sky Palace 3F
;.byte $08,$91    ; 32 ; Sky Palace 4F
;.byte $5F,$94    ; 33 ; Sky Palace 5F
;.byte $6F,$95    ; 34 ; Temple of Fiends 1F
;.byte $F5,$97    ; 35 ; Temple of Fiends 2F
;.byte $C9,$9A    ; 36 ; Temple of Fiends 3F
;.byte $6F,$9D    ; 37 ; Temple of Fiends 4F - Earth
;.byte $AD,$9F    ; 38 ; Temple of Fiends 5F - Fire
;.byte $93,$A3    ; 39 ; Temple of Fiends 6F - Water
;.byte $FA,$A5    ; 3A ; Temple of Fiends 7F - Wind
;.byte $98,$A8    ; 3B ; Temple of Fiends 8F - Chaos
;.byte $5D,$AB    ; 3C ; Titan's Tunnel
;.byte $00,$00    ; 3D ; 
;.byte $00,$00    ; 3E ; 
;.byte $00,$00    ; 3F ; 

; Map data, as pointed to above for offsets 0080 to 3fff.
; Compression is the same as for the world map (see b01.txt), except there are
; no row pointers and 0xff ends the entire map instead of just the row. All
; maps are 64x64 max.

;; JIGS - new way:
;; A nice named pointer table.
;; Each pointer points to a .bin file in the /maps folder
;; Banks are chosen by comparing against the constants #MAP_BANKCHANGE_3 and 2 (see LoadStandardMap)
;; Each bank has its own named pointer table.

.word Coneria
.word PRAVOKA
.word ELFLAND
.word MELMOND
.word CRESCENT_LAKE
.word GAIA
.word ONRAC
.word LEIFEN
.word Coneria_CASTLE_1F
.word ELFLAND_CASTLE
.word NORTHWEST_CASTLE
.word CASTLE_OF_ORDEALS_1F
.word TEMPLE_OF_FIENDS_PRESENT
.word EARTH_CAVE_B1
.word GURGU_VOLCANO_B1
.word ICE_CAVE_B1
.word CARDIA
.word BAHAMUTS_ROOM_B1
.word WATERFALL
.word DWARF_CAVE
.word MATOYAS_CAVE
.word SARDAS_CAVE
.word MARSH_CAVE_B1
.word MIRAGE_TOWER_1F


Coneria:
.incbin "bin/maps/map_00.bin"

PRAVOKA:
.incbin "bin/maps/map_01.bin"

ELFLAND:
.incbin "bin/maps/map_02.bin"

MELMOND:
.incbin "bin/maps/map_03.bin"

CRESCENT_LAKE:
.incbin "bin/maps/map_04.bin"

GAIA:
.incbin "bin/maps/map_05.bin"

ONRAC:
.incbin "bin/maps/map_06.bin"

LEIFEN:
.incbin "bin/maps/map_07.bin"

Coneria_CASTLE_1F:
.incbin "bin/maps/map_08.bin"

ELFLAND_CASTLE:
.incbin "bin/maps/map_09.bin"

NORTHWEST_CASTLE:
.incbin "bin/maps/map_0A.bin"

CASTLE_OF_ORDEALS_1F:
.incbin "bin/maps/map_0B.bin"

TEMPLE_OF_FIENDS_PRESENT:
.incbin "bin/maps/map_0C.bin"

EARTH_CAVE_B1:
.incbin "bin/maps/map_0D.bin"

GURGU_VOLCANO_B1:
.incbin "bin/maps/map_0E.bin"

ICE_CAVE_B1:
.incbin "bin/maps/map_0F.bin"

CARDIA:
.incbin "bin/maps/map_10.bin"

BAHAMUTS_ROOM_B1:
.incbin "bin/maps/map_11.bin"

WATERFALL:
.incbin "bin/maps/map_12.bin"

DWARF_CAVE:
.incbin "bin/maps/map_13.bin"

MATOYAS_CAVE:
.incbin "bin/maps/map_14.bin"

SARDAS_CAVE:
.incbin "bin/maps/map_15.bin"

MARSH_CAVE_B1:
.incbin "bin/maps/map_16.bin"

MIRAGE_TOWER_1F:
.incbin "bin/maps/map_17.bin"

.byte "END OF BANK 16"
