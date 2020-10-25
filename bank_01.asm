.include "Constants.inc"
.include "variables.inc"
.include "macros.inc"
.feature force_range
.segment "BANK_01"

BANK_THIS = $01

.incbin "chr/enemies/iguana.chr"            ; 00
.incbin "chr/enemies/giant.chr"             ; 01
.incbin "chr/enemies/shark.chr"             ; 02
.incbin "chr/enemies/bigeye.chr"            ; 03
.incbin "chr/enemies/hyena.chr"             ; 04
.incbin "chr/enemies/ogre.chr"              ; 05
.incbin "chr/enemies/bull.chr"              ; 06
.incbin "chr/enemies/troll.chr"             ; 07
.incbin "chr/enemies/worm.chr"              ; 08
.incbin "chr/enemies/eye.chr"               ; 09
.incbin "chr/enemies/pede.chr"              ; 0A
.incbin "chr/enemies/tiger.chr"             ; 0B
.incbin "chr/enemies/earth_elemental.chr"   ; 0C
.incbin "chr/enemies/dragon_1.chr"          ; 0D
.incbin "chr/enemies/manticor.chr"          ; 0E
.incbin "chr/enemies/ankylo.chr"            ; 0F
.incbin "chr/enemies/wyvern.chr"            ; 10
.incbin "chr/enemies/trex.chr"              ; 11
.incbin "chr/enemies/ocho.chr"              ; 12
.incbin "chr/enemies/hydra.chr"             ; 13
.incbin "chr/enemies/naga.chr"              ; 14
.incbin "chr/enemies/chimera.chr"           ; 15
.incbin "chr/enemies/dragon_2.chr"          ; 16
.incbin "chr/enemies/golem.chr"             ; 17
.incbin "chr/enemies/madpony.chr"           ; 18
.incbin "chr/enemies/warmech.chr"           ; 19


.byte "END OF BANK 01"
