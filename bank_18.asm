.include "Constants.inc"
.include "variables.inc"
.include "macros.inc"

.segment "BANK_18"

BANK_THIS = $18

.word Sea_Shrine_B3              ; 2C ;
.word Sea_Shrine_B2              ; 2D ;
.word Sea_Shrine_B1              ; 2E ;
.word Sky_Palace_1F              ; 2F ;
.word Sky_Palace_2F              ; 30 ;
.word Sky_Palace_3F              ; 31 ;
.word Sky_Palace_4F              ; 32 ;
.word Sky_Palace_5F              ; 33 ;
.word Temple_of_Fiends_1F        ; 34 ;
.word Temple_of_Fiends_2F        ; 35 ;
.word Temple_of_Fiends_3F        ; 36 ;
.word Temple_of_Fiends_4F_Earth  ; 37 ;
.word Temple_of_Fiends_5F_Fire   ; 38 ;
.word Temple_of_Fiends_6F_Water  ; 39 ;
.word Temple_of_Fiends_7F_Wind   ; 3A ;
.word Temple_of_Fiends_8F_Chaos  ; 3B ;
.word Titans_Tunnel              ; 3C ;

Sea_Shrine_B3:
.incbin "bin/maps/map_2C.bin"

Sea_Shrine_B2:
.incbin "bin/maps/map_2D.bin"

Sea_Shrine_B1:
.incbin "bin/maps/map_2E.bin"

Sky_Palace_1F:
.incbin "bin/maps/map_2F.bin"

Sky_Palace_2F:
.incbin "bin/maps/map_30.bin"

Sky_Palace_3F:
.incbin "bin/maps/map_31.bin"

Sky_Palace_4F:
.incbin "bin/maps/map_32.bin"

Sky_Palace_5F:
.incbin "bin/maps/map_33.bin"

Temple_of_Fiends_1F:
.incbin "bin/maps/map_34.bin"

Temple_of_Fiends_2F:
.incbin "bin/maps/map_35.bin"

Temple_of_Fiends_3F:
.incbin "bin/maps/map_36.bin"

Temple_of_Fiends_4F_Earth:
.incbin "bin/maps/map_37.bin"

Temple_of_Fiends_5F_Fire:
.incbin "bin/maps/map_38.bin"

Temple_of_Fiends_6F_Water:
.incbin "bin/maps/map_39.bin"

Temple_of_Fiends_7F_Wind:
.incbin "bin/maps/map_3A.bin"

Temple_of_Fiends_8F_Chaos:
.incbin "bin/maps/map_3B.bin"

Titans_Tunnel:
.incbin "bin/maps/map_3C.bin"

.byte "END OF BANK 18"