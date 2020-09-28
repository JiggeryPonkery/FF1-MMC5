.include "Constants.inc"
.include "variables.inc"
.include "macros.inc"
.feature force_range

.export BattleIcons
.export lut_ShopCHR
.export lut_MenuTextCHR
.export LoadShopCHRForBank_Z
.export lut_BatObjCHR
.export LoadCursorOnly
.export LoadSprite_Bank03
.export lut_BackdropPal
.export lut_BtlBackdrops
.export LoadShopCHR_andPalettes
.export LoadMenuOrbs

.import WaitForVBlank_L
.import LongCall
.import CHRLoad
.import CallMusicPlay_L
.import WaitForVBlank_L
.import LoadCHR_MusicPlay
.import CHRLoadToA

.segment "BANK_03"

BANK_THIS = $03

lut_BattleBackdropCHR:
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

;; Weapon and Magic Casting Sprites
lut_BatObjCHR:
MagicWeaponSprites:  
.INCBIN "chr/weapon_magic_sprites.chr"

lut_ShopCHR:
.INCBIN "chr/shop.chr" 

lut_MenuTextCHR:
.INCBIN "chr/menu_text.chr" 

lut_OrbCHR: 
 .INCBIN "chr/new_menuorbs.chr"

BattleIcons:
.incbin "chr/battleicons.chr"


ScrollworkImageTable:
.byte $32,$33,$18,$18,$18,$18,$34,$35 
.byte $42,$43,$19,$19,$19,$19,$44,$45
.byte $1E,$1F,$00,$00,$00,$00,$1A,$1B 
.byte $1E,$1F,$00,$00,$00,$00,$1A,$1B
.byte $1E,$1F,$00,$00,$00,$00,$1A,$1B
.byte $1E,$1F,$00,$00,$00,$00,$1A,$1B 
.byte $1E,$1F,$00,$00,$00,$00,$1A,$1B
.BYTE $3C,$3D,$1C,$1C,$1C,$1C,$3A,$3B 
.BYTE $4C,$4D,$1D,$1D,$1D,$1D,$4A,$4B

LoadMenuOrbs:
    LDX #08
    LDA #<lut_OrbCHR                 ; from source address lut_OrbCHR
    STA tmp
    LDA #>lut_OrbCHR
    STA tmp+1
    LDA #0
    JSR CHRLoadToA                   ; load up desired CHR (this is the ORB graphics that appear in the upper-left corner of main menu
    LDX #0
   @Loop:
    LDA ScrollworkImageTable, X
    STA statusbox_scrollwork, X
    INX
    CPX #8*10
    BNE @Loop
    RTS

; Battle backdrop palettes

lut_BackdropPal:
.byte $0F,$31,$29,$30 ; 00 ; grasslands
.byte $0F,$0C,$17,$07 ; 01 ; cave
.byte $0F,$1C,$2B,$1B ; 02 ; cave_2
.byte $0F,$30,$3C,$22 ; 03 ; ocean
.byte $0F,$18,$0A,$1C ; 04 ; forest
.byte $0F,$3C,$1C,$0C ; 05 ; temple
.byte $0F,$37,$31,$28 ; 06 ; desert
.byte $0F,$27,$17,$1C ; 07 ; brambles
.byte $0F,$1A,$17,$07 ; 08 ; cave_3
.byte $0F,$30,$10,$00 ; 09 ; castle
.byte $0F,$22,$1A,$10 ; 0A ; river
.byte $0F,$37,$10,$00 ; 0B ; sky_castle
.byte $0F,$21,$12,$03 ; 0C ; sea_shrine
.byte $0F,$31,$22,$13 ; 0D ; cave_4
.byte $0F,$26,$16,$06 ; 0E ; cave_5
.byte $0F,$2B,$1C,$0C ; 0F ; waterfall

.byte $0F,$30,$00,$31 ; 10 ; Weapon shop
.byte $0F,$10,$27,$17 ; 11 ; Armor shop
.byte $0F,$3C,$1C,$0C ; 12 ; White magic shop
.byte $0F,$3B,$1B,$0B ; 13 ; Black magic shop
.byte $0F,$3C,$1C,$0C ; 14 ; Green magic shop
.byte $0F,$3B,$1B,$0B ; 15 ; Time magic shop
.byte $0F,$3B,$1B,$0B ; 16 ; Skills
.byte $0F,$37,$17,$07 ; 17 ; Item
.byte $0F,$37,$16,$10 ; 18 ; Clinic
.byte $0F,$36,$16,$07 ; 19 ; Inn
.byte $0F,$30,$28,$16 ; 1A ; Caravan

; Battle backdrop assignment

lut_BtlBackdrops:
.byte $80 ; grasslands
.byte $89 ; castle
.byte $89 ; castle
.byte $84 ; forest
.byte $84 ; forest
.byte $84 ; forest
.byte $80 ; grasslands
.byte $83 ; ocean
.byte $80 ; grasslands
.byte $8F ; unused?
.byte $8F ; unused?
.byte $8F ; unused?
.byte $8F ; unused?
.byte $8F ; unused?
.byte $88 ; cave_3
.byte $8F ; unused?
.byte $8F ; unused?
.byte $8F ; unused?
.byte $8F ; unused?
.byte $84 ; forest
.byte $84 ; forest
.byte $84 ; forest
.byte $83 ; ocean
.byte $83 ; ocean
.byte $83 ; ocean
.byte $8F ; unused?
.byte $8F ; unused?
.byte $89 ; castle
.byte $89 ; castle
.byte $8B ; sky_castle
.byte $86 ; desert
.byte $8F ; unused?
.byte $8F ; unused?
.byte $8F ; unused?
.byte $8F ; unused?
.byte $84 ; forest
.byte $84 ; forest
.byte $84 ; forest
.byte $80 ; grasslands
.byte $83 ; ocean
.byte $80 ; grasslands
.byte $89 ; castle
.byte $89 ; castle
.byte $8D ; cave_4
.byte $8F ; unused?
.byte $8F ; unused?
.byte $8F ; unused?
.byte $82 ; cave_2
.byte $8F ; unused?
.byte $8F ; unused?
.byte $82 ; cave_2
.byte $8F ; unused?
.byte $82 ; cave_2
.byte $82 ; cave_2
.byte $86 ; desert
.byte $86 ; desert
.byte $89 ; castle
.byte $89 ; castle
.byte $82 ; cave_2
.byte $80 ; grasslands
.byte $8F ; unused?
.byte $8F ; unused?
.byte $8F ; unused?
.byte $80 ; grasslands
.byte $8A ; river
.byte $8A ; river
.byte $86 ; desert
.byte $86 ; desert
.byte $8A ; river
.byte $86 ; desert
.byte $8F ; waterfall?
.byte $8F ; unused?
.byte $8F ; unused?
.byte $80 ; grasslands
.byte $83 ; ocean
.byte $8F ; unused?
.byte $80 ; grasslands
.byte $80 ; grasslands
.byte $80 ; grasslands
.byte $8F ; unused?
.byte $8A ; river
.byte $8A ; river
.byte $86 ; desert
.byte $86 ; desert
.byte $80 ; grasslands
.byte $87 ; brambles
.byte $80 ; grasslands
.byte $85 ; temple
.byte $85 ; temple
.byte $80 ; grasslands
.byte $80 ; grasslands
.byte $8F ; unused?
.byte $8F ; unused?
.byte $8C ; sea_shrine
.byte $8F ; unused?
.byte $8F ; unused?
.byte $80 ; grasslands
.byte $80 ; grasslands
.byte $87 ; brambles
.byte $87 ; brambles
.byte $8E ; cave_5
.byte $8E ; cave_5
.byte $82 ; cave_2
.byte $82 ; cave_2
.byte $82 ; cave_2
.byte $82 ; cave_2
.byte $82 ; cave_2
.byte $8F ; unused?
.byte $82 ; cave_2
.byte $80 ; grasslands
.byte $81 ; cave
.byte $8F ; unused?
.byte $80 ; grasslands
.byte $80 ; grasslands
.byte $87 ; brambles
.byte $87 ; brambles
.byte $80 ; grasslands
.byte $80 ; grasslands
.byte $80 ; grasslands
.byte $8F ; unused?
.byte $8F ; unused?
.byte $8F ; unused?
.byte $8F ; unused?
.byte $8F ; unused?
.byte $8F ; unused?
.byte $8F ; unused?
.byte $8F ; unused?
.byte $8F ; unused?


lut_ShopPalettes:
  .BYTE  $0F,$00,$04,$30,  $0F,$00,$11,$30

LoadShopCHR_andPalettes:
    JSR LoadCursorOnly

    LDA shop_id          ; Get Shop ID
    LSR A                ; shift high bits (shop type) into low bits
    LSR A
    LSR A
    LSR A
    STA shop_type        ; save shop type
    ASL A
    ASL A
    ORA #$40             ; *4 and add $40 to get offset to required backdrop palette
    JSR LoadBGPalette
    
    LDX #$07           ; start at X=7
  @Loop:
    LDA lut_ShopPalettes, X
    STA cur_pal+4, X   ; copy over the shop palettes
    DEX                ; and loop until X wraps (8 colors copied in total)
    BPL @Loop
    
;    LDA #BANK_THIS
;    STA cur_bank
;    JSR LoadCHR_MusicPlay ;; update music, swaps back

    JSR LoadShopPointers
    
    LDA #$07           ; dest PPU address = $0700
    LDX #$01           ; load just one row
    JMP CHRLoadToA     ; 

LoadShopPointers:
    LDA #<lut_ShopCHR
	STA tmp
    LDA shop_type      ; get shop type
    CLC
    ADC #>lut_ShopCHR  ; source pointer (tmp) = lut_ShopCHR
    STA tmp+1
    RTS

LoadShopCHRForBank_Z: ;; JIGS - Its either put this here or copy all of lut_ShopCHR to Bank Z as well.
    LDA #$08
    STA soft2000           ; 
    LDA $2002              ; reset toggle
    LDA #0
    STA $2001              ; turn off the PPU
    STA $2006              ; set address to $0000
    STA $2006           
    JSR FillBlackTile      ; fill the blank tile at the start of CHR RAM

    JSR LoadShopCHR_andPalettes ; then load up the shop graphics
    LDY #$08
    JSR LoadMenuText            ; then load up the menu text

    JSR LoadBlackTiles_Sprite   ; then do the blank tile as a sprite
    JSR LoadShopPointers        ; load the shop pointers for sprites
    
    LDA #$17               ; dest PPU address = $1700
    LDX #$01               ; load just one row
    JSR CHRLoadToA          
    
    LDY #$18               ; and end with doing menu text for sprites
LoadMenuText:
    LDA #<lut_MenuTextCHR
    STA tmp
    LDA #>lut_MenuTextCHR
    STA tmp+1
    LDX #$08
    TYA
    JMP CHRLoadToA

LoadBGPalette:
    TAX                       ; backdrop ID * 4 in X for indexing
    LDA lut_BackdropPal, X    ; copy the palette over
    STA cur_pal
    LDA lut_BackdropPal+1, X
    STA cur_pal+1
    LDA lut_BackdropPal+2, X
    STA cur_pal+2
    LDA lut_BackdropPal+3, X
    STA cur_pal+3    
    RTS

LoadBattleBackdrop_AndPalette:
    LDX ow_tile              ; Get last OW tile stepped on
    LDA lut_BtlBackdrops, X  ; use it to index and get battle backdrop ID
    STA tmp+1                ; save this value for just after the RTS below
    AND #$0F                 ; multiply ID by 4
    ASL A
    ASL A                    ; and load up the palette
    JSR LoadBGPalette

    LDA #0
    STA $2006                ; set address to $0000
    STA $2006           
    STA tmp

    JSR FillBlackTile
    INX
    JSR CHRLoad
    JMP FillBlackTile

CHRLoadToAX:
    LDY InBattle
    BNE Jump_StackLoader

    LDY $2002         ; reset PPU Addr toggle
    STA $2006         ; write high byte of dest address
    STX $2006         ; write low byte
    LDY #$00
    LDX tmp+2         ; amount of writes to make
CHRLoad_Loop:
    LDA (tmp), Y      ; read a byte from source pointer
    STA $2007         ; and write it to CHR-RAM
    INY               ; inc our source index
    DEX
    BNE CHRLoad_Loop  ; if we've loaded all requested tiles, exit.  Otherwise continue loading
    RTS

Jump_StackLoader:
    JMP StackLoader
    
LoadSprite_Bank03:
    LDA MMC5_tmp
    LSR A    				; 01 
    BCS LoadWeaponSprite
    LSR A                   ; 02 
    BCS LoadMagicSprite     
    ;BCC LoadAttackCloud     ; 04

LoadAttackCloud:
    LDA #<MagicWeaponSprites+$40
    STA tmp
    LDA #>MagicWeaponSprites+$0F
    STA tmp+1
    ; a800 < start of MagicWeaponSprites
    ; b740 < where we want to laod from

    LDA #$C0
    STA tmp+2
    LDA #$10
    LDX #$40
    JSR CHRLoadToAX
	JSR LoadBlackTiles_Sprite
    JMP LoadBattleBackdrop_AndPalette
   
LoadWeaponSprite:
    JSR LoadMagicWeaponSprite    
    LDA #$10
    LDX #$00
    JMP CHRLoadToAX
    
LoadCursorOnly:
    LDA #$F0
    STA btlattackspr_gfx
    JSR LoadMagicWeaponSprite    
    LDA #$1F
    LDX #$00
    JMP CHRLoadToAX   

LoadMagicWeaponSprite:    
    LDA #0
    STA tmp+1
    LDA btlattackspr_gfx
    CLC
    ROL A
    ROL tmp+1
    ROL A
    ROL tmp+1
    ROL A
    ROL tmp+1
    ROL A
    ROL tmp+1                 ; this should convert something like $A8 into $0A80
    CLC
    ADC #<MagicWeaponSprites
    STA tmp
    LDA #>MagicWeaponSprites
    ADC tmp+1
    STA tmp+1
    LDA #$40
    STA tmp+2    
    RTS
    
    
LoadMagicSprite:
    JSR LoadMagicWeaponSprite    
    LDA tmp+1
    PHA
    LDA tmp
    PHA
    
    LDA #$13                
    LDX #$00
    JSR CHRLoadToAX    
    ;; do the first 4 tiles
    
    ;; BattleUpdatePPU - Copy:
    LDA btl_soft2001
    STA $2001               ; copy over soft2001
    LDA #$00
    STA $2005               ; reset scroll
    STA $2005
    
    LDA $2002
    LDA #>oam
    STA $4014               ; Do OAM DMA
    LDA #BANK_THIS
    STA cur_bank            ; set the swap-back bank (necessary because music playback is in another bank)
    JSR CallMusicPlay_L     ; Call music playback to keep it playing
    ;; does not update battle sfx, so make sure this is called before SFX begin
    
    LDA #BANK_DOBATTLE      ; reset the swap-back bank
    STA cur_bank           
    
    LDA #$40
    STA tmp+2
    PLA 
    STA tmp
    CLC
    ADC #$40
    STA tmp
    PLA 
    ADC #$00
    STA tmp+1
    LDA #$13
    LDX #$40
    JMP CHRLoadToAX

;; JIGS - this is really just so I don't see garbage in the PPU viewer while testing battle graphics...
;; since now it displays sprites instead of background tiles
;; JIGS - but now also helpful for the intro screen!

LoadBlackTiles_Sprite:
    LDX #>$1000
    LDA #<$1000
    STX $2006             ; write X as high byte
    STA $2006             ; A as low byte

FillBlackTile:    
    LDX #$10
   @Loop:
    STA $2007             ; write $20 zeros to clear 2 tiles
    DEX
    BNE @Loop
    RTS

StackLoader:
    PHA       ; backup A
    TXA       ; backup X
    PHA

    LDY #0
   @StackLoad_Loop:
    LDA (tmp), Y      ; read a byte from source pointer
    STA $0100, Y      ; save to the top of the stack
    INY
    CPY tmp+2         ; and stop when all the bytes are loaded
    BNE @StackLoad_Loop
    
    JSR WaitForVBlank_L
    
    PLA       ; restore X    
    TAX
    PLA       ; restore A 
    LDY $2002
    STA $2006         ; write high byte of dest address
    STX $2006         ; write low byte
    
    TSX       ; move stack pointer to X
    STX tmp+3 ; backup stack pointer    
    LDX #$FF  ; start at the top of the stack
    TXS       ; transfer to the stack pointer

    LDX tmp+2 ; get amount of bytes to write    
   @PullStackLoop:
    PLA
    STA $2007
    DEX
    BNE @PullStackLoop
    
    LDX tmp+3
    TXS       ; restore stack pointer
    RTS
    




.byte "END OF BANK 03"
