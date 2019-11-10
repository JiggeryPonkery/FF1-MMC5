.include "Constants.inc"
.include "variables.inc"
.include "macros.inc"
.feature force_range
.segment "BANK_00"

BANK_THIS = $00

.incbin "bin/nesheader.bin"

.incbin "chr/battle_blankspace.chr"
.incbin "chr/backdrops/00_grasslands.chr"
.incbin "chr/battle_blankspace.chr"
.incbin "chr/enemies/imp.chr"
.incbin "chr/enemies/wolf.chr"
.incbin "chr/enemies/iguana.chr"
.incbin "chr/enemies/giant.chr"
.incbin "chr/battleicons.chr"

.incbin "chr/battle_blankspace.chr"
.incbin "chr/backdrops/01_cave.chr"
.incbin "chr/battle_blankspace.chr"
.incbin "chr/enemies/sahagin.chr"
.incbin "chr/enemies/pirate.chr"
.incbin "chr/enemies/shark.chr"
.incbin "chr/enemies/bigeye.chr"
.incbin "chr/battleicons.chr"

.incbin "chr/battle_blankspace.chr"
.incbin "chr/backdrops/02_cave_2.chr"
.incbin "chr/battle_blankspace.chr"
.incbin "chr/enemies/skeleton.chr"
.incbin "chr/enemies/creep.chr"
.incbin "chr/enemies/hyena.chr"
.incbin "chr/enemies/ogre.chr"
.incbin "chr/battleicons.chr"

.incbin "chr/battle_blankspace.chr"
.incbin "chr/backdrops/03_ocean.chr"
.incbin "chr/battle_blankspace.chr"
.incbin "chr/enemies/snake.chr"
.incbin "chr/enemies/scorpion.chr"
.incbin "chr/enemies/bull.chr"
.incbin "chr/enemies/troll.chr"
.incbin "chr/battleicons.chr"

.incbin "chr/battle_blankspace.chr"
.incbin "chr/backdrops/04_forest.chr"
.incbin "chr/battle_blankspace.chr"
.incbin "chr/enemies/ghost.chr"
.incbin "chr/enemies/zombie.chr"
.incbin "chr/enemies/worm.chr"
.incbin "chr/enemies/eye.chr"
.incbin "chr/battleicons.chr"

.incbin "chr/battle_blankspace.chr"
.incbin "chr/backdrops/05_temple.chr"
.incbin "chr/battle_blankspace.chr"
.incbin "chr/enemies/medusa.chr"
.incbin "chr/enemies/catman.chr"
.incbin "chr/enemies/pede.chr"
.incbin "chr/enemies/tiger.chr"
.incbin "chr/battleicons.chr"

.incbin "chr/battle_blankspace.chr"
.incbin "chr/backdrops/06_desert.chr"
.incbin "chr/battle_blankspace.chr"
.incbin "chr/enemies/vampire.chr"
.incbin "chr/enemies/gargoyle.chr"
.incbin "chr/enemies/earth_elemental.chr"
.incbin "chr/enemies/dragon_1.chr"
.incbin "chr/battleicons.chr"

.incbin "chr/battle_blankspace.chr"
.incbin "chr/backdrops/07_brambles.chr"
.incbin "chr/battle_blankspace.chr"
.incbin "chr/enemies/slime.chr"
.incbin "chr/enemies/spider.chr"
.incbin "chr/enemies/manticor.chr"
.incbin "chr/enemies/ankylo.chr"
.incbin "chr/battleicons.chr"


;.incbin "chr/enemies/imp.chr"               ; 00
;.incbin "chr/enemies/wolf.chr"              ; 01
;.incbin "chr/enemies/sahagin.chr"           ; 02
;.incbin "chr/enemies/pirate.chr"            ; 03
;.incbin "chr/enemies/skeleton.chr"          ; 04
;.incbin "chr/enemies/creep.chr"             ; 05
;.incbin "chr/enemies/snake.chr"             ; 06
;.incbin "chr/enemies/scorpion.chr"          ; 07
;.incbin "chr/enemies/ghost.chr"             ; 08
;.incbin "chr/enemies/zombie.chr"            ; 09
;.incbin "chr/enemies/medusa.chr"            ; 0A
;.incbin "chr/enemies/catman.chr"            ; 0B
;.incbin "chr/enemies/vampire.chr"           ; 0C
;.incbin "chr/enemies/gargoyle.chr"          ; 0D
;.incbin "chr/enemies/slime.chr"             ; 0E
;.incbin "chr/enemies/spider.chr"            ; 0F
;
;.incbin "chr/enemies/iguana.chr"            ; 00
;.incbin "chr/enemies/giant.chr"             ; 01
;.incbin "chr/enemies/shark.chr"             ; 02
;.incbin "chr/enemies/bigeye.chr"            ; 03
;.incbin "chr/enemies/hyena.chr"             ; 04
;.incbin "chr/enemies/ogre.chr"              ; 05
;.incbin "chr/enemies/bull.chr"              ; 06
;.incbin "chr/enemies/troll.chr"             ; 07
;.incbin "chr/enemies/worm.chr"              ; 08
;.incbin "chr/enemies/eye.chr"               ; 09
;.incbin "chr/enemies/pede.chr"              ; 0A
;.incbin "chr/enemies/tiger.chr"             ; 0B
;.incbin "chr/enemies/earth_elemental.chr"   ; 0C
;.incbin "chr/enemies/dragon_1.chr"          ; 0D
;.incbin "chr/enemies/manticor.chr"          ; 0E
;.incbin "chr/enemies/ankylo.chr"            ; 0F
;
; .byte "END OF BANK 00"
