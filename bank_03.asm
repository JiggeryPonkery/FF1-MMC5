.include "Constants.inc"
.include "variables.inc"
.include "macros.inc"

.export BattleIcons

.segment "BANK_03"

BANK_THIS = $03

.incbin "chr/backdrops/00_grasslands.chr"
.incbin "chr/backdrops/01_cave.chr"
.incbin "chr/backdrops/02_cave_2.chr"
.incbin "chr/backdrops/03_ocean.chr"
.incbin "chr/backdrops/04_forest.chr"
.incbin "chr/backdrops/05_temple.chr"
.incbin "chr/backdrops/06_desert.chr"
.incbin "chr/backdrops/07_brambles.chr"
.incbin "chr/backdrops/08_cave_3.chr"
.incbin "chr/backdrops/09_castle.chr"
.incbin "chr/backdrops/0A_river.chr"
.incbin "chr/backdrops/0B_sky_castle.chr"
.incbin "chr/backdrops/0C_sea_shrine.chr"
.incbin "chr/backdrops/0D_cave_4.chr"
.incbin "chr/backdrops/0E_cave_5.chr"
.incbin "chr/backdrops/0F_waterfall.chr"

BattleIcons:
.incbin "chr/battleicons.chr"

.byte "END OF BANK 03"
