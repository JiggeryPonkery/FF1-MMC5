.include "Constants.inc"
.include "variables.inc"
.include "macros.inc"
.feature force_range

.export BattleIcons
.export lut_ShopCHR
.export lut_MenuTextCHR
.export LoadShopCHRForBank_Z

.import CHRLoad

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


lut_ShopCHR:
.INCBIN "chr/shop.chr" 

lut_MenuTextCHR:
.INCBIN "chr/menu_text.chr" 


LoadShopCHRForBank_Z: ;; JIGS - Its either put this here or copy all of lut_ShopCHR to Bank Z as well.
    LDA #$08
    STA soft2000           ; 
    LDA $2002              ; reset toggle
    LDA #0
    STA $2001              ; turn off the PPU
    STA $2006              ; set write address to $0000
    STA $2006

    JSR LoadShopCHR

    LDA $2002          ; Set address to $1000 
    LDA #>$1000
    STA $2006
    LDA #<$1000
    STA $2006
    
LoadShopCHR:
    LDA #>lut_ShopCHR
    STA tmp+1        
    LDA #<lut_ShopCHR
    STA tmp
    LDX #16    
    JMP CHRLoad


.byte "END OF BANK 03"
