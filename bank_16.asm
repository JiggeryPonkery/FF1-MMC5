.include "Constants.inc"
.include "variables.inc"
.include "macros.inc"

.segment "BANK_16"

.import WaitForVBlank_L
.import CallMusicPlay_L

BANK_THIS = $16

.incbin "bin/bank_blegh.bin"

.byte "END OF BANK 16"
