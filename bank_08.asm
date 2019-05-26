.include "Constants.inc"
.include "variables.inc"
.include "macros.inc"

.segment "BANK_08"

.import WaitForVBlank_L
.import CallMusicPlay_L

BANK_THIS = $08

.incbin "chr/battle_blankspace.chr"
.incbin "chr/backdrops/08_cave_3.chr"
.incbin "chr/battle_blankspace.chr"
.incbin "chr/enemies/mummy.chr"
.incbin "chr/enemies/coctrice.chr"
.incbin "chr/enemies/wyvern.chr"
.incbin "chr/enemies/trex.chr"
.incbin "chr/battleicons.chr"

.incbin "chr/battle_blankspace.chr"
.incbin "chr/backdrops/09_castle.chr"
.incbin "chr/battle_blankspace.chr"
.incbin "chr/enemies/caribe.chr"
.incbin "chr/enemies/gator.chr"
.incbin "chr/enemies/ocho.chr"
.incbin "chr/enemies/hydra.chr"
.incbin "chr/battleicons.chr"

.incbin "chr/battle_blankspace.chr"
.incbin "chr/backdrops/0A_river.chr"
.incbin "chr/battle_blankspace.chr"
.incbin "chr/enemies/sentry.chr"
.incbin "chr/enemies/water_elemental.chr"
.incbin "chr/enemies/naga.chr"
.incbin "chr/enemies/chimera.chr"
.incbin "chr/battleicons.chr"

.incbin "chr/battle_blankspace.chr"
.incbin "chr/backdrops/0B_sky_castle.chr"
.incbin "chr/battle_blankspace.chr"
.incbin "chr/enemies/wizard.chr"
.incbin "chr/enemies/garland.chr"
.incbin "chr/enemies/dragon_2.chr"
.incbin "chr/enemies/golem.chr"
.incbin "chr/battleicons.chr"

.incbin "chr/battle_blankspace.chr"
.incbin "chr/backdrops/0C_sea_shrine.chr"
.incbin "chr/battle_blankspace.chr"
.incbin "chr/enemies/badman.chr"
.incbin "chr/enemies/astos.chr"
.incbin "chr/enemies/madpony.chr"
.incbin "chr/enemies/warmech.chr"
.incbin "chr/battleicons.chr"

.incbin "chr/battle_blankspace.chr"
.incbin "chr/backdrops/0D_cave_4.chr"
.incbin "chr/battle_blankspace.chr"
.incbin "chr/enemies/kary.chr"
.incbin "chr/enemies/lich.chr"
.incbin "chr/battleicons.chr"

.incbin "chr/battle_blankspace.chr"
.incbin "chr/backdrops/0E_cave_5.chr"
.incbin "chr/battle_blankspace.chr"
.incbin "chr/enemies/kraken.chr"
.incbin "chr/enemies/tiamat.chr"
.incbin "chr/battleicons.chr"

.incbin "chr/battle_blankspace.chr"
.incbin "chr/backdrops/0F_waterfall.chr"
.incbin "chr/battle_blankspace.chr"
.incbin "chr/enemies/chaos.chr"
.incbin "chr/battleicons.chr"

; .byte "END OF BANK 08"
