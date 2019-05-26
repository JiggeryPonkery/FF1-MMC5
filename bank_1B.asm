.include "Constants.inc"
.include "variables.inc"
.include "macros.inc"

.segment "BANK_1B"

.import WaitForVBlank_L
.import CallMusicPlay_L

BANK_THIS = $1B

.incbin "bin/bank_blegh.bin"

.byte "END OF BANK 1B"
