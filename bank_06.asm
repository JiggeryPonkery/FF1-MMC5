.include "Constants.inc"
.include "variables.inc"
.include "macros.inc"
.feature force_range
.segment "BANK_06"

BANK_THIS = $06

.incbin "chr/tilesets/town_tileset.chr"

.incbin "chr/tilesets/castle_tileset.chr"

.incbin "chr/tilesets/cave_tileset.chr"

.incbin "chr/tilesets/safecave_tileset.chr"

.incbin "chr/tilesets/tower_tileset.chr"

.incbin "chr/tilesets/seashrine_tileset.chr"

.incbin "chr/tilesets/skycastle_tileset.chr"

.incbin "chr/tilesets/templeoffiends_tileset.chr"

; .byte "END OF BANK 06"