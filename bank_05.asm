.include "Constants.inc"
.include "variables.inc"
.include "macros.inc"

.segment "BANK_05"

.import WaitForVBlank_L
.import CallMusicPlay_L

BANK_THIS = $05


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
.WORD Sea_Shrine_B5        ; 2A ; Sea Shrine B5
.WORD Sea_Shrine_B4        ; 2B ; Sea Shrine B4


Castle_of_Ordeals_2F:
.incbin "bin/maps/map_19.bin"

Castle_of_Ordeals_3F:
.incbin "bin/maps/map_1A.bin"

Marsh_Cave_B2:
.incbin "bin/maps/map_1B.bin"

Marsh_Cave_B3:
.incbin "bin/maps/map_1C.bin"

Earth_Cave_B2:
.incbin "bin/maps/map_1D.bin"

Earth_Cave_B3:
.incbin "bin/maps/map_1E.bin"

Earth_Cave_B4:
.incbin "bin/maps/map_1F.bin"

Earth_Cave_B5:
.incbin "bin/maps/map_20.bin"

Gurgu_Volcano_B2:
.incbin "bin/maps/map_21.bin"

Gurgu_Volcano_B3:
.incbin "bin/maps/map_22.bin"

Gurgu_Volcano_B4:
.incbin "bin/maps/map_23.bin"

Gurgu_Volcano_B5:
.incbin "bin/maps/map_24.bin"

Ice_Cave_B2:
.incbin "bin/maps/map_25.bin"

Ice_Cave_B3:
.incbin "bin/maps/map_26.bin"

Bahamuts_Room_B2:
.incbin "bin/maps/map_27.bin"

Mirage_Tower_2F:
.incbin "bin/maps/map_28.bin"

Mirage_Tower_3F:
.incbin "bin/maps/map_29.bin"

Sea_Shrine_B5:
.incbin "bin/maps/map_2A.bin"

Sea_Shrine_B4:
.incbin "bin/maps/map_2B.bin"




.byte "END OF BANK 05"
