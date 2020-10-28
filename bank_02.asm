.include "Constants.inc"
.include "variables.inc"
.include "macros.inc"
.feature force_range
.segment "BANK_02"

BANK_THIS = $02

;.incbin "chr/enemies/kary.chr"              ; 00
;.incbin "chr/enemies/lich.chr"              ; 01
;.incbin "chr/enemies/kraken.chr"            ; 02
;.incbin "chr/enemies/tiamat.chr"            ; 03
;.incbin "chr/enemies/chaos.chr"             ; 04

.incbin "chr/enemies/Lich_Fix.chr"              ; 00
.incbin "chr/enemies/Kary_Fix.chr"              ; 01
.incbin "chr/enemies/Kraken_Fix.chr"            ; 02
.incbin "chr/enemies/Tiamat_Fix.chr"            ; 03
;.incbin "chr/enemies/Chaos_Fix.chr"            ; 04 - adds in missing tile without edits, educated guess where the tile might go
.incbin "chr/enemies/Chaos_Fix_JIGS.chr"        ; 04 - changes missing tile to flesh out left foot (right from player perspective)

.byte "END OF BANK 02"