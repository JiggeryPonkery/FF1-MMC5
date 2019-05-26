.include "Constants.inc"
.include "variables.inc"
.include "macros.inc"

.segment "BANK_17"

.import WaitForVBlank_L
.import CallMusicPlay_L

BANK_THIS = $17

.incbin "bin/bank_blegh.bin"

.byte "END OF BANK 17"
