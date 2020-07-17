.include "Constants.inc"
.include "variables.inc"
.feature force_range
.segment "BANK_05"

BANK_THIS = $05
 
.export Overworld_Tileset
.export Second_Overworld_Tileset
    
Overworld_Tileset:
.incbin "chr/tilesets/overworld_tileset.chr"

Second_Overworld_Tileset:
.incbin "chr/tilesets/overworld_tileset.chr"
