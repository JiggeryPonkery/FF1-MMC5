.include "Constants.inc"
.include "variables.inc"
.include "macros.inc"
.feature force_range
.segment "BANK_17"

BANK_THIS = $17

.export lut_SMPtrTbl
.export lut_MapBanks

;; Info from Anomie's disassembly!

; Map offsets from this address. Of the 16-bit value, bits 0-13 are the pointer
; within the bank and bits 14-15 select the bank.

lut_MapBanks:
.byte BANK_MAPS   ; Coneria                    ; 00 ;
.byte BANK_MAPS   ; Pravoka                    ; 01 ;
.byte BANK_MAPS   ; Elfland                    ; 02 ;
.byte BANK_MAPS   ; Melmond                    ; 03 ;
.byte BANK_MAPS   ; Crescent_Lake              ; 04 ;
.byte BANK_MAPS   ; Gaia                       ; 05 ;
.byte BANK_MAPS   ; Onrac                      ; 06 ;
.byte BANK_MAPS   ; Leifen                     ; 07 ;
.byte BANK_MAPS   ; Coneria_Castle_1F          ; 08 ;
.byte BANK_MAPS   ; Elfland_Castle             ; 09 ;
.byte BANK_MAPS   ; Northwest_Castle           ; 0A ;
.byte BANK_MAPS   ; Castle_of_Ordeals_1F       ; 0B ;
.byte BANK_MAPS   ; Temple_of_Friends_Present  ; 0C ;
.byte BANK_MAPS   ; Earth_Cave_B1              ; 0D ;
.byte BANK_MAPS   ; Gurgu_Volcano_B1           ; 0E ;
.byte BANK_MAPS   ; Ice_Cave_B1                ; 0F ;
.byte BANK_MAPS   ; Cardia                     ; 10 ;
.byte BANK_MAPS   ; Bahamut_Room_B1            ; 11 ;
.byte BANK_MAPS   ; Waterfall                  ; 12 ;
.byte BANK_MAPS   ; Dwarf_Cave                 ; 13 ;
.byte BANK_MAPS   ; Matoya_Cave                ; 14 ;
.byte BANK_MAPS   ; Sardas_Cave                ; 15 ;
.byte BANK_MAPS   ; Marsh_Cave_B1              ; 16 ;
.byte BANK_MAPS+1 ; Mirage_Tower_1F            ; 17 ;
.byte BANK_MAPS+1 ; Coneria_Castle_2F          ; 18 ;
.byte BANK_MAPS+1 ; Castle_of_Ordeals_2F       ; 19 ;
.byte BANK_MAPS+1 ; Castle_of_Ordeals_3F       ; 1A ;
.byte BANK_MAPS+1 ; Marsh_Cave_B2              ; 1B ;
.byte BANK_MAPS+1 ; Marsh_Cave_B3              ; 1C ;
.byte BANK_MAPS+1 ; Earth_Cave_B2              ; 1D ;
.byte BANK_MAPS+1 ; Earth_Cave_B3              ; 1E ;
.byte BANK_MAPS+1 ; Earth_Cave_B4              ; 1F ;
.byte BANK_MAPS+1 ; Earth_Cave_B5              ; 20 ;
.byte BANK_MAPS+1 ; Gurgu_Volcano_B2           ; 21 ;
.byte BANK_MAPS+1 ; Gurgu_Volcano_B3           ; 22 ;
.byte BANK_MAPS+1 ; Gurgu_Volcano_B4           ; 23 ;
.byte BANK_MAPS+1 ; Gurgu_Volcano_B5           ; 24 ;
.byte BANK_MAPS+1 ; Ice_Cave_B2                ; 25 ;
.byte BANK_MAPS+1 ; Ice_Cave_B3                ; 26 ;
.byte BANK_MAPS+1 ; Bahamuts_Room_B2           ; 27 ;
.byte BANK_MAPS+1 ; Mirage_Tower_2F            ; 28 ;
.byte BANK_MAPS+1 ; Mirage_Tower_3F            ; 29 ;
.byte BANK_MAPS+1 ; Sea_Shrine_B5              ; 2A ;
.byte BANK_MAPS+2 ; Sea_Shrine_B4              ; 2B ;
.byte BANK_MAPS+2 ; Sea_Shrine_B3              ; 2C ;
.byte BANK_MAPS+2 ; Sea_Shrine_B2              ; 2D ;
.byte BANK_MAPS+2 ; Sea_Shrine_B1              ; 2E ;
.byte BANK_MAPS+2 ; Sky_Palace_1F              ; 2F ;
.byte BANK_MAPS+2 ; Sky_Palace_2F              ; 30 ;
.byte BANK_MAPS+2 ; Sky_Palace_3F              ; 31 ;
.byte BANK_MAPS+2 ; Sky_Palace_4F              ; 32 ;
.byte BANK_MAPS+2 ; Sky_Palace_5F              ; 33 ;
.byte BANK_MAPS+2 ; Temple_of_Fiends_1F        ; 34 ;
.byte BANK_MAPS+2 ; Temple_of_Fiends_2F        ; 35 ;
.byte BANK_MAPS+2 ; Temple_of_Fiends_3F        ; 36 ;
.byte BANK_MAPS+2 ; Temple_of_Fiends_4F_Earth  ; 37 ;
.byte BANK_MAPS+2 ; Temple_of_Fiends_5F_Fire   ; 38 ;
.byte BANK_MAPS+2 ; Temple_of_Fiends_6F_Water  ; 39 ;
.byte BANK_MAPS+2 ; Temple_of_Fiends_7F_Wind   ; 3A ;
.byte BANK_MAPS+2 ; Temple_of_Fiends_8F_Chaos  ; 3B ;
.byte BANK_MAPS+2 ; Titans_Tunnel              ; 3C ;












lut_SMPtrTbl:
.WORD Coneria                    ; 00 ; 
.WORD Pravoka                    ; 01 ; 
.WORD Elfland                    ; 02 ; 
.WORD Melmond                    ; 03 ; 
.WORD Crescent_Lake              ; 04 ; 
.WORD Gaia                       ; 05 ; 
.WORD Onrac                      ; 06 ; 
.WORD Leifen                     ; 07 ; 
.WORD Coneria_Castle_1F          ; 08 ; 
.WORD Elfland_Castle             ; 09 ; 
.WORD Northwest_Castle           ; 0A ; 
.WORD Castle_of_Ordeals_1F       ; 0B ; 
.WORD Temple_of_Friends_Present  ; 0C ; 
.WORD Earth_Cave_B1              ; 0D ; 
.WORD Gurgu_Volcano_B1           ; 0E ; 
.WORD Ice_Cave_B1                ; 0F ; 
.WORD Cardia                     ; 10 ; 
.WORD Bahamut_Room_B1            ; 11 ; 
.WORD Waterfall                  ; 12 ; 
.WORD Dwarf_Cave                 ; 13 ; 
.WORD Matoya_Cave                ; 14 ; 
.WORD Sardas_Cave                ; 15 ; 
.WORD Marsh_Cave_B1              ; 16 ; 
.WORD Mirage_Tower_1F            ; 17 ; 
.WORD Coneria_Castle_2F          ; 18 ; 
.WORD Castle_of_Ordeals_2F       ; 19 ; 
.WORD Castle_of_Ordeals_3F       ; 1A ; 
.WORD Marsh_Cave_B2              ; 1B ; 
.WORD Marsh_Cave_B3              ; 1C ; 
.WORD Earth_Cave_B2              ; 1D ; 
.WORD Earth_Cave_B3              ; 1E ; 
.WORD Earth_Cave_B4              ; 1F ; 
.WORD Earth_Cave_B5              ; 20 ; 
.WORD Gurgu_Volcano_B2           ; 21 ; 
.WORD Gurgu_Volcano_B3           ; 22 ; 
.WORD Gurgu_Volcano_B4           ; 23 ; 
.WORD Gurgu_Volcano_B5           ; 24 ; 
.WORD Ice_Cave_B2                ; 25 ; 
.WORD Ice_Cave_B3                ; 26 ; 
.WORD Bahamuts_Room_B2           ; 27 ; 
.WORD Mirage_Tower_2F            ; 28 ; 
.WORD Mirage_Tower_3F            ; 29 ; 
.WORD Sea_Shrine_B5              ; 2A ; 
.WORD Sea_Shrine_B4              ; 2B ; 
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
