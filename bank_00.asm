.include "Constants.inc"
.include "variables.inc"
.include "macros.inc"
.feature force_range
.segment "BANK_00"

BANK_THIS = $00

.incbin "bin/nesheader.bin"

.incbin "chr/enemies/imp.chr"               ; 00
.incbin "chr/enemies/wolf.chr"              ; 01
.incbin "chr/enemies/sahagin.chr"           ; 02
.incbin "chr/enemies/pirate.chr"            ; 03
.incbin "chr/enemies/skeleton.chr"          ; 04
.incbin "chr/enemies/creep.chr"             ; 05
.incbin "chr/enemies/snake.chr"             ; 06
.incbin "chr/enemies/scorpion.chr"          ; 07
.incbin "chr/enemies/ghost.chr"             ; 08
.incbin "chr/enemies/zombie.chr"            ; 09
.incbin "chr/enemies/medusa.chr"            ; 0A
.incbin "chr/enemies/catman.chr"            ; 0B
.incbin "chr/enemies/vampire.chr"           ; 0C
.incbin "chr/enemies/gargoyle.chr"          ; 0D
.incbin "chr/enemies/slime.chr"             ; 0E
.incbin "chr/enemies/spider.chr"            ; 0F
.incbin "chr/enemies/mummy.chr"             ; 10
.incbin "chr/enemies/coctrice.chr"          ; 11
.incbin "chr/enemies/caribe.chr"            ; 12
.incbin "chr/enemies/gator.chr"             ; 13
.incbin "chr/enemies/sentry.chr"            ; 14
.incbin "chr/enemies/water_elemental.chr"   ; 15
.incbin "chr/enemies/wizard.chr"            ; 16
.incbin "chr/enemies/garland.chr"           ; 17
.incbin "chr/enemies/badman.chr"            ; 18
.incbin "chr/enemies/astos.chr"             ; 19




;.incbin "chr/battleicons.chr"
;
.byte "END OF BANK 00"
