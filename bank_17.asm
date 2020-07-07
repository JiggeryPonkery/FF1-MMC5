.include "Constants.inc"
.include "variables.inc"
.include "macros.inc"
.feature force_range
.segment "BANK_17"

BANK_THIS = $17

.export lut_SMPtrTbl

;; Info from Anomie's disassembly!

; Map offsets from this address. Of the 16-bit value, bits 0-13 are the pointer
; within the bank and bits 14-15 select the bank.

lut_SMPtrTbl:
.WORD Coneria
.WORD Pravoka
.WORD Elfland
.WORD Melmond
.WORD Crescent_Lake
.WORD Gaia
.WORD Onrac
.WORD Leifen
.WORD Coneria_Castle_1F
.WORD Elfland_Castle
.WORD Northwest_Castle
.WORD Castle_of_Ordeals_1F
.WORD Temple_of_Friends_Present
.WORD Earth_Cave_B1
.WORD Gurgu_Volcano_B1
.WORD Ice_Cave_B1
.WORD Cardia
.WORD Bahamut_Room_B1
.WORD Waterfall
.WORD Dwarf_Cave
.WORD Matoya_Cave
.WORD Sardas_Cave
.WORD Marsh_Cave_B1
.WORD Mirage_Tower_1F
.WORD Coneria_Castle_2F
.WORD Castle_of_Ordeals_2F ; 19 ; Castle of Ordeals 2F
.WORD Castle_of_Ordeals_3F ; 1A ; Castle of Ordeals 3F
.WORD Marsh_Cave_B2        ; 1B ; Marsh Cave B2
.WORD Marsh_Cave_B3        ; 1C ; Marsh Cave B3
.WORD Earth_Cave_B2        ; 1D ; Earth Cave B2
.WORD Earth_Cave_B3        ; 1E ; Earth Cave B3
.WORD Earth_Cave_B4        ; 1F ; Earth Cave B4
.WORD Earth_Cave_B5        ; 20 ; Earth Cave B5
.WORD Gurgu_Volcano_B2     ; 21 ; Gurgu Volcano B2
.WORD Gurgu_Volcano_B3     ; 22 ; Gurgu Volcano B3
.WORD Gurgu_Volcano_B4     ; 23 ; Gurgu Volcano B4
.WORD Gurgu_Volcano_B5     ; 24 ; Gurgu Volcano B5
.WORD Ice_Cave_B2          ; 25 ; Ice Cave B2
.WORD Ice_Cave_B3          ; 26 ; Ice Cave B3
.WORD Bahamuts_Room_B2     ; 27 ; Bahamut's Room B2
.WORD Mirage_Tower_2F      ; 28 ; Mirage Tower 2F
.WORD Mirage_Tower_3F      ; 29 ; Mirage Tower 3F
.WORD Sea_Shrine_B5              ; 2A ; Sea Shrine B5
.WORD Sea_Shrine_B4              ; 2B ; Sea Shrine B4
.WORD Sea_Shrine_B3              ; 2C ;
.WORD Sea_Shrine_B2              ; 2D ;
.WORD Sea_Shrine_B1              ; 2E ;
.WORD Sky_Palace_1F              ; 2F ;
.WORD Sky_Palace_2F              ; 30 ;
.WORD Sky_Palace_3F              ; 31 ;
.WORD Sky_Palace_4F              ; 32 ;
.WORD Sky_Palace_5F              ; 33 ;
.WORD Temple_of_Fiends_1F        ; 34 ;
.WORD Temple_of_Fiends_2F        ; 35 ;
.WORD Temple_of_Fiends_3F        ; 36 ;
.WORD Temple_of_Fiends_4F_Earth  ; 37 ;
.WORD Temple_of_Fiends_5F_Fire   ; 38 ;
.WORD Temple_of_Fiends_6F_Water  ; 39 ;
.WORD Temple_of_Fiends_7F_Wind   ; 3A ;
.WORD Temple_of_Fiends_8F_Chaos  ; 3B ;
.WORD Titans_Tunnel              ; 3C ;


















Coneria:
.incbin "maps/00.cmap"

Pravoka:
.incbin "maps/01.cmap"

Elfland:
.incbin "maps/02.cmap"

Melmond:
.incbin "maps/03.cmap"

Crescent_Lake:
.incbin "maps/04.cmap"

Gaia:
.incbin "maps/05.cmap"

Onrac:
.incbin "maps/06.cmap"

Leifen:
.incbin "maps/07.cmap"

Coneria_Castle_1F:
.incbin "maps/08.cmap"

Elfland_Castle:
.incbin "maps/09.cmap"

Northwest_Castle:
.incbin "maps/10.cmap"

Castle_of_Ordeals_1F:
.incbin "maps/11.cmap"

Temple_of_Friends_Present:
.incbin "maps/12.cmap"

Earth_Cave_B1:
.incbin "maps/13.cmap"

Gurgu_Volcano_B1:
.incbin "maps/14.cmap"

Ice_Cave_B1:
.incbin "maps/15.cmap"

Cardia:
.incbin "maps/16.cmap"

Bahamut_Room_B1:
.incbin "maps/17.cmap"

Waterfall:
.incbin "maps/18.cmap"

Dwarf_Cave:
.incbin "maps/19.cmap"

Matoya_Cave:
.incbin "maps/20.cmap"

Sardas_Cave:
.incbin "maps/21.cmap"

Marsh_Cave_B1:
.incbin "maps/22.cmap"

Mirage_Tower_1F:
.incbin "maps/23.cmap"

Coneria_Castle_2F:
.incbin "maps/24.cmap"

Castle_of_Ordeals_2F:
.incbin "maps/25.cmap"

Castle_of_Ordeals_3F:
.incbin "maps/26.cmap"

Marsh_Cave_B2:
.incbin "maps/27.cmap"

Marsh_Cave_B3:
.incbin "maps/28.cmap"

Earth_Cave_B2:
.incbin "maps/29.cmap"

Earth_Cave_B3:
.incbin "maps/30.cmap"

Earth_Cave_B4:
.incbin "maps/31.cmap"

Earth_Cave_B5:
.incbin "maps/32.cmap"

Gurgu_Volcano_B2:
.incbin "maps/33.cmap"

Gurgu_Volcano_B3:
.incbin "maps/34.cmap"

Gurgu_Volcano_B4:
.incbin "maps/35.cmap"

Gurgu_Volcano_B5:
.incbin "maps/36.cmap"

Ice_Cave_B2:
.incbin "maps/37.cmap"

Ice_Cave_B3:
.incbin "maps/38.cmap"

Bahamuts_Room_B2:
.incbin "maps/39.cmap"

Mirage_Tower_2F:
.incbin "maps/40.cmap"

Mirage_Tower_3F:
.incbin "maps/41.cmap"

Sea_Shrine_B5:
.incbin "maps/42.cmap"

Sea_Shrine_B4:
.incbin "maps/43.cmap"

Sea_Shrine_B3:
.incbin "maps/44.cmap"

Sea_Shrine_B2:
.incbin "maps/45.cmap"

Sea_Shrine_B1:
.incbin "maps/46.cmap"

Sky_Palace_1F:
.incbin "maps/47.cmap"

Sky_Palace_2F:
.incbin "maps/48.cmap"

Sky_Palace_3F:
.incbin "maps/49.cmap"

Sky_Palace_4F:
.incbin "maps/50.cmap"

Sky_Palace_5F:
.incbin "maps/51.cmap"

Temple_of_Fiends_1F:
.incbin "maps/52.cmap"

Temple_of_Fiends_2F:
.incbin "maps/53.cmap"

Temple_of_Fiends_3F:
.incbin "maps/54.cmap"

Temple_of_Fiends_4F_Earth:
.incbin "maps/55.cmap"

Temple_of_Fiends_5F_Fire:
.incbin "maps/56.cmap"

Temple_of_Fiends_6F_Water:
.incbin "maps/57.cmap"

Temple_of_Fiends_7F_Wind:
.incbin "maps/58.cmap"

Temple_of_Fiends_8F_Chaos:
.incbin "maps/59.cmap"

Titans_Tunnel:
.incbin "maps/60.cmap"


.byte "END OF SMALL MAPS"
