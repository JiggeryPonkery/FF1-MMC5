.include "Constants.inc"
.include "variables.inc"
.include "macros.inc"

.export LoadBattleTextChr
.import CHRLoad

.segment "BANK_08"



BANK_THIS = $08



.byte "END OF BANK 08"




LoadBattleTextChr:
    LDA $2002          ; Set address to $1000 
    LDA #>$0800
    STA $2006
    LDA #<$0800
    STA $2006
;
    LDA #>BattleTextChr
    STA tmp+1        
    LDA #<BattleTextChr
    STA tmp
    LDX #8   
    JMP CHRLoad






BattleTextChr:
.incbin "chr/battle_text.chr"
