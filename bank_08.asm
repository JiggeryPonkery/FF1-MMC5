.include "Constants.inc"
.include "variables.inc"
.include "macros.inc"
.feature force_range

.export LoadBattleTextChr
.import CHRLoad
.import BattleRNG_L
.import MultiplyXA

.segment "BANK_08"



BANK_THIS = $08

LoadBattleTextChr:
;; load player HP strings into RAM     
    LDX #$20
  : LDA PlayerHPString_ROM, X
    STA PlayerHPString_RAM, X
    DEX
    BPL :-

;; load the battle text and sprites
    LDA $2002         
    LDA #>$0800
    STA $2006
    LDA #<$0800
    STA $2006
    LDA #>BattleTextChr
    STA tmp+1        
    LDA #<BattleTextChr
    STA tmp
    LDX #8  
    JSR CHRLoad
    
    LDA #>$1300
    STA $2006
    LDA #<$1300
    STA $2006
    LDA #>BattleTextChr_Sprites
    STA tmp+1        
    LDA #<BattleTextChr_Sprites
    STA tmp
    LDX #13 
    JSR CHRLoad
    
;; randomize the battle backdrop

    LDY #$0  
    STY tmp
    STY tmp+1
    
   @Random: 
    JSR BattleRNG_L
    AND #$03
    BEQ @Random        ; if its 0, reroll
    CMP #3
    BEQ @Print3        ; if its 3, do 3
    CMP #1
    BEQ @Print1        ; if its 1, do 1
    BNE @Random        ; else, its 2; reroll

   @Print1:            
    LDA #0             ; clear the "drawn 3" counter
    STA tmp+1           
    INC tmp            ; inc the "drawn 1" counter
    LDA tmp
    CMP #4             ; when it reaches 4, switch to drawing 3 instead
    BEQ @Print3        ; after clearing the "drawn 1" counter
    ;; this will ensure that no pillar or tree or whatever is drawn more than 3 times in a row.
    
    LDA #1
    STA lut_BackdropLayout, Y
    INY
    LDA #2
    STA lut_BackdropLayout, Y
    BNE @Next

   @Print3:
    LDA #0
    STA tmp    
    INC tmp+1
    LDA tmp+1
    CMP #4
    BEQ @Print1
    
    LDA #3
    STA lut_BackdropLayout, Y
    INY
    LDA #4
    STA lut_BackdropLayout, Y
  
   @Next:
    INY 
    CPY #$20
    BNE @Random
    RTS




;; Player HP String
PlayerHPString_ROM:
.byte $13,$00,$05,$7A,$13,$00,$06,$01
.byte $13,$40,$05,$7A,$13,$40,$06,$01
.byte $13,$80,$05,$7A,$13,$80,$06,$01
.byte $13,$C0,$05,$7A,$13,$C0,$06,$00


BattleTextChr:
.incbin "chr/battle_text.chr"

BattleTextChr_Sprites:
.incbin "chr/battle_text_sprites.chr"


.byte "END OF BANK 08"