.include "Constants.inc"
.include "variables.inc"
.include "macros.inc"
.feature force_range
.segment "BANK_02"

BANK_THIS = $02

.incbin "chr/enemies/kary.chr"              ; 00
.incbin "chr/enemies/lich.chr"              ; 01
.incbin "chr/enemies/kraken.chr"            ; 02
.incbin "chr/enemies/tiamat.chr"            ; 03
.incbin "chr/enemies/chaos.chr"             ; 04

.byte "END OF BANK 02"