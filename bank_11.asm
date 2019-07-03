.include "Constants.inc"
.include "variables.inc"

BANK_THIS = $11

.segment "BANK_11"

.export lut_OWTileset
.export lut_SMTilesetAttr
.export lut_SMTilesetProp
.export lut_MapmanPalettes
.export lut_SMTilesetTSA
.export lut_SMPalettes
.export lut_InitUnsramFirstPage



;; JIGS - Re-arranged much of the data. There was a lot of unused padding to make sure certain routines were aligned to page boundaries and stuff.
;;        As of the time of this comment, there is 736 bytes free in this bank.
;; JIGS - now a lot more...



; world map tile data
; 2 bytes per tile:
;  +0: bits 6-7: 01 = chime required
;                10 = caravan required
;                11 = use floater to raise airship
;      bit  5:   Can dock ship here
;      bit  4:   Forest walking effect
;      bit  3:   Can't land airship here
;      bit  2:   Can't move ship here
;      bit  1:   Can't move canoe here
;      bit  0:   Can't walk here
;  +1: If bit 7 is set, bits 0-6 specify the teleport index
;      Otherwise, bit 6: battle here
;                 bits 0-1: 00 = normal battle
;                           01 = river battle
;                           10 = ocean battle
;                           11 = river battle
;  7 6 5 4  3 2 1 0         
; %0 0 0 0, 0 0 0 0 <- bit order, if I have it understood right

lut_OWTileset:
.byte $06,$40, $0E,$89, $0E,$89, $0E,$40, $1E,$40, $0E,$40, $0E,$40, $0B,$42
.byte $0E,$40, $0F,$00, $0F,$00, $0F,$00, $0F,$00, $0F,$00, $0E,$8E, $2E,$00

.byte $0F,$00, $0F,$00, $0F,$00, $0E,$40, $1E,$40, $0E,$40, $0B,$42, $0B,$42
.byte $0B,$42, $0F,$00, $0F,$00, $0E,$8A, $0E,$8A, $4E,$98, $0E,$00, $2E,$00

.byte $0F,$00, $0F,$00, $0F,$00, $0E,$40, $0E,$40, $0E,$40, $0E,$40, $0B,$42
.byte $0E,$40, $0E,$8B, $0E,$8B, $0E,$90, $0F,$00, $0F,$00, $0F,$00, $0E,$94
;                                                          
.byte $0F,$00, $0F,$00, $0E,$95, $0F,$00, $0E,$99, $0E,$9A, $8E,$00, $CE,$00
.byte $0E,$8C, $0E,$8C, $0E,$96, $0E,$00, $0F,$00, $0E,$00, $0F,$00, $0E,$00

.byte $0D,$41, $0D,$41, $0E,$40, $0E,$40, $0D,$41, $0E,$40, $0D,$93, $0F,$00
.byte $0F,$00, $0E,$81, $0E,$82, $0F,$00, $0E,$83, $0E,$84, $0E,$85, $0F,$00

.byte $0D,$41, $0D,$41, $0E,$40, $0E,$40, $06,$40, $0E,$40, $06,$00, $0E,$8D
.byte $0E,$8D, $06,$00, $0E,$86, $0F,$00, $0F,$00, $0E,$87, $0F,$00, $0F,$00

.byte $06,$40, $06,$40, $0E,$40, $0E,$40, $0E,$8F, $0E,$8F, $0E,$91, $0E,$9B
.byte $0E,$9C, $0E,$9D, $0E,$80, $0F,$00, $0E,$92, $0E,$88, $0E,$97, $0F,$00

.byte $06,$40, $06,$40, $0E,$40, $0E,$40, $0E,$00, $0E,$00, $06,$00, $2E,$00
.byte $2E,$00, $2E,$00, $2E,$00, $0F,$00, $0F,$00, $0F,$00, $0F,$00, $0F,$00

; world map pattern table assignment
.byte $20,$89,$8B,$21,$26,$23,$53,$4F,$3F,$01,$7E,$8D,$01,$73,$1C,$F5
.byte $02,$07,$04,$37,$2D,$2C,$4D,$3B,$3B,$81,$83,$AC,$AE,$77,$59,$01
.byte $18,$0C,$0D,$33,$2D,$2E,$48,$3B,$42,$AC,$AE,$1C,$01,$01,$01,$1C
.byte $14,$0E,$1C,$0F,$1C,$1C,$59,$59,$AC,$AE,$1C,$01,$D2,$7C,$7C,$D7
.byte $55,$54,$62,$5C,$54,$59,$69,$B1,$B3,$96,$93,$01,$9E,$A2,$9A,$D4
.byte $54,$54,$60,$59,$63,$6B,$01,$BA,$BC,$BE,$A2,$D1,$01,$A2,$CD,$D6
.byte $67,$65,$6F,$6B,$62,$E4,$DF,$DF,$DF,$DF,$DF,$CF,$DF,$96,$DF,$7C
.byte $68,$63,$6B,$6B,$E9,$AF,$01,$01,$01,$01,$F5,$CB,$7C,$7C,$C9,$7C
.byte $20,$8A,$8C,$22,$27,$24,$45,$50,$53,$7D,$01,$8E,$01,$74,$1D,$01
.byte $03,$08,$05,$2C,$2A,$39,$3C,$3C,$4B,$82,$84,$AD,$D9,$78,$59,$F5
.byte $0D,$0A,$1A,$2B,$2E,$36,$49,$3C,$43,$AD,$D9,$1D,$01,$01,$01,$1D
.byte $0E,$0F,$1D,$17,$1D,$1D,$59,$59,$AD,$D9,$1D,$D1,$7C,$7C,$D6,$01
.byte $54,$56,$5B,$62,$54,$59,$6A,$B2,$B4,$97,$94,$CF,$9F,$A3,$9B,$01
.byte $54,$54,$59,$5E,$64,$6C,$B9,$BB,$BD,$01,$A3,$D2,$CB,$A3,$01,$D7
.byte $68,$66,$6C,$70,$E3,$62,$E0,$E0,$E0,$E0,$E0,$7C,$E0,$97,$E0,$D4
.byte $64,$65,$6C,$6C,$DE,$B0,$20,$01,$01,$01,$01,$7C,$7C,$C9,$7C,$CD
.byte $20,$7C,$91,$25,$2A,$2C,$46,$3D,$40,$01,$80,$8F,$AA,$75,$1E,$F5
.byte $06,$0C,$0D,$38,$2B,$2E,$4E,$3D,$3D,$85,$87,$DA,$DC,$79,$7B,$01
.byte $19,$0C,$0D,$2F,$34,$31,$53,$51,$44,$DA,$DC,$1E,$C5,$C6,$C6,$1E
.byte $10,$15,$1E,$12,$1E,$1E,$59,$59,$DA,$DC,$1E,$01,$7C,$7C,$7C,$D8
.byte $54,$54,$5A,$59,$54,$59,$69,$B5,$B7,$98,$95,$01,$A0,$A4,$9C,$D5
.byte $57,$54,$62,$5F,$64,$6D,$01,$C0,$C2,$C4,$A4,$D3,$01,$A4,$CE,$7C
.byte $68,$64,$6D,$6D,$E5,$E7,$E1,$E1,$E1,$E1,$E1,$D0,$E1,$98,$E1,$7C
.byte $67,$65,$71,$6D,$A6,$A8,$20,$01,$F5,$F5,$01,$CC,$C8,$C8,$CA,$C8
.byte $20,$91,$92,$2A,$2B,$28,$47,$3E,$41,$7F,$01,$90,$AB,$76,$1F,$01
.byte $0A,$0D,$09,$29,$2C,$3A,$3E,$3E,$4C,$86,$88,$DB,$DD,$7A,$59,$F5
.byte $0B,$0B,$1B,$30,$35,$32,$4A,$52,$53,$DB,$DD,$1F,$C6,$C6,$C7,$1F
.byte $11,$16,$1F,$13,$1F,$1F,$59,$59,$DB,$DD,$1F,$D3,$7C,$7C,$7C,$01
.byte $54,$54,$59,$5D,$54,$59,$6A,$B6,$B8,$99,$EA,$D0,$A1,$A5,$9D,$01
.byte $54,$58,$61,$62,$63,$6E,$BF,$C1,$C3,$01,$A5,$7C,$CC,$A5,$01,$D8
.byte $63,$65,$6E,$6E,$E6,$E8,$E2,$E2,$E2,$E2,$E2,$7C,$E2,$99,$E2,$D5
.byte $68,$66,$6E,$72,$A7,$A9,$20,$F5,$F5,$01,$01,$C8,$C8,$CA,$C8,$CE

; world map palette assignments
.byte $FF,$00,$00,$FF,$FF,$FF,$AA,$AA,$AA,$00,$00,$00,$00,$55,$00,$00
.byte $00,$00,$00,$FF,$FF,$FF,$AA,$AA,$AA,$00,$00,$00,$00,$55,$55,$00
.byte $00,$00,$00,$FF,$FF,$FF,$AA,$AA,$AA,$00,$00,$00,$00,$00,$00,$00
.byte $00,$00,$00,$00,$00,$00,$55,$55,$00,$00,$00,$00,$00,$00,$00,$00
.byte $AA,$AA,$55,$55,$AA,$55,$AA,$00,$00,$00,$00,$00,$00,$00,$00,$00
.byte $AA,$AA,$55,$55,$FF,$AA,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
.byte $FF,$FF,$AA,$AA,$55,$55,$FF,$FF,$FF,$FF,$FF,$00,$FF,$00,$FF,$00
.byte $FF,$FF,$AA,$AA,$55,$55,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00

; world map palettes
.byte $0F,$1A,$10,$30,$0F,$1A,$27,$37,$0F,$1A,$31,$21,$0F,$1A,$29,$19
.byte $0F,$0F,$12,$36,$0F,$0F,$27,$36,$0F,$0F,$27,$30,$0F,$0F,$30,$1A

; Colors for index 2 of the map character palettes. The first is for the top
; half, and the second for the bottom.

lut_MapmanPalettes:
.byte $16,$16 ; Fighter
.byte $12,$17 ; Thief
.byte $27,$12 ; BlackBelt
.byte $16,$16 ; RedMage
.byte $30,$30 ; WhiteMage
.byte $27,$12 ; BlackMage
.byte $16,$16 ; Knight
.byte $16,$16 ; Ninja
.byte $27,$12 ; Master
.byte $16,$16 ; RedWiz
.byte $16,$30 ; WhiteWiz
.byte $27,$13 ; BlackWiz

;; unused, but needed for padding

;.byte $00,$00,$00,$00,$00,$00,$00,$00
;.byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
;.byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
;.byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
;.byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00

;; JIGS - moved this to make use of this unused padding. 

lut_InitUnsramFirstPage:
.byte $00 ; 00 ship visible
.byte $D2 ; 01 ship X 
.byte $99 ; 02 ship Y
.byte $00 ; 03 airship visible
.byte $DD ; 04 airship X
.byte $ED ; 05 airship Y
.byte $00 ; 06 bridge visible
.byte $98 ; 07 bridge X
.byte $98 ; 08 bridge Y
.byte $01 ; 09 canal visible
.byte $66 ; 0A canal X
.byte $A4 ; 0B canal Y
.byte $00 ; 0C bridgescene ; 00 = hasnt happened yet. 01 = happens when move is complete, 80 =  already has happened
.byte $92 ; 0D overworld scroll x
.byte $9E ; 0E overworld scroll y
.byte $01 ; 0F overworld vehicle
.byte $01 ; 10 exp gain option (normal)
.byte $01 ; 11 money gain option (normal)
.byte $01 ; 12 encounter rate option (normal)
.byte $00 ; 13 mute SFX option (on)
.byte $00 ; 14 auto target option (on)
.byte $04 ; 15 battle text speed (5)
.byte $01 ; 16 battle text background color (1: blue)
.byte $00 ; 17 unused
.byte $00 ; 18 unused
.byte $00 ; 19 unused
.byte $00 ; 1A unused
.byte $00 ; 1B unused
.byte $00 ; 1C unused
.byte $90 ; 1D gold low
.byte $01 ; 1E gold middle
.byte $00 ; 1F gold high

; Items
.byte $00 ;00 unused
.byte $02 ;01 heal -- JIGS - added two heals
.byte $00 ;02 X-heal
.byte $00 ;03 ether
.byte $00 ;04 elixier
.byte $01 ;05 pure -- JIGS - added one pure 
.byte $00 ;06 soft
.byte $00 ;07 phoenix down
.byte $00 ;08 tent
.byte $00 ;09 cabin
.byte $00 ;0A house
.byte $00 ;0B eyedrops
.byte $00 ;0C smokebomb
.byte $00 ;0D party horn
.byte $00 ;0E nothing
.byte $00 ;1F nothing

; Key Items
.byte $00 ;10 lute 
.byte $00 ;11 crown
.byte $00 ;12 crystal
.byte $00 ;13 herb
.byte $00 ;14 mystic key
.byte $00 ;15 tnt
.byte $00 ;16 adamant
.byte $00 ;17 slab
.byte $00 ;18 ruby
.byte $00 ;19 rod
.byte $00 ;1A floater
.byte $00 ;1B chime
.byte $00 ;1C tail
.byte $00 ;1D cube
.byte $00 ;1E bottle
.byte $00 ;1F oxyale
.byte $00 ;20 canoe
.byte $00 ;21 
.byte $00 ;22 
.byte $00 ;23 
.byte $00 ;24 
.byte $00 ;25
.byte $00 ;26
.byte $00 ;27
; 28
; 29
; 2A
; 2B
; 2C fire orb
; 2D water orb
; 2E air orb 
; 2F earth orb
;; JIGS - due to space limitations, these last 8 key item slots can't be set here.



;; Map tileset palette assignments
; Each byte is the palette map for one map tile (16x16 pixels)
; (each value is 2 bits, repeated 4 times for speed)
; must be on $400 byte bound - see padding above

lut_SMTilesetAttr: 
.byte $00,$00,$00,$55,$55,$55,$55,$55,$55,$55,$55,$55,$55,$55,$00,$00 ; Town
.byte $55,$55,$55,$55,$55,$55,$55,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
.byte $AA,$AA,$AA,$AA,$AA,$FF,$FF,$AA,$AA,$AA,$FF,$FF,$FF,$FF,$AA,$55
.byte $55,$55,$00,$00,$00,$FF,$FF,$FF,$55,$00,$FF,$AA,$00,$00,$FF,$FF
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$00,$AA,$FF,$FF,$FF,$FF,$FF,$FF,$FF
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$55

.byte $55,$55,$55,$55,$55,$55,$55,$55,$55,$00,$00,$00,$55,$00,$00,$00 ; Castle
.byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
.byte $00,$AA,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$AA,$FF,$FF,$AA,$AA,$00,$00
.byte $AA,$00,$00,$00,$FF,$FF,$00,$00,$FF,$FF,$00,$00,$FF,$FF,$FF,$FF
.byte $FF,$FF,$FF,$FF,$FF,$FF,$00,$00,$FF,$55,$55,$55,$55,$55,$55,$55
.byte $FF,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
.byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00

.byte $55,$55,$55,$55,$55,$55,$55,$55,$55,$00,$00,$AA,$00,$00,$00,$00 ; Cave
.byte $00,$00,$00,$00,$00,$AA,$AA,$00,$AA,$AA,$00,$AA,$AA,$55,$55,$00
.byte $AA,$55,$55,$55,$AA,$AA,$AA,$AA,$AA,$AA,$AA,$AA,$AA,$AA,$55,$55
.byte $AA,$AA,$AA,$AA,$AA,$AA,$FF,$FF,$AA,$AA,$AA,$FF,$AA,$AA,$AA,$AA
.byte $55,$AA,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
.byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
.byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
.byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00

.byte $55,$55,$55,$55,$55,$55,$55,$55,$55,$00,$00,$00,$00,$00,$00,$00 ; Safe Cave
.byte $00,$00,$00,$00,$00,$00,$00,$00,$FF,$FF,$FF,$FF,$00,$00,$00,$00
.byte $00,$00,$00,$00,$00,$00,$00,$00,$FF,$FF,$FF,$FF,$FF,$00,$00,$00
.byte $AA,$AA,$AA,$AA,$AA,$AA,$FF,$FF,$FF,$AA,$AA,$FF,$AA,$AA,$00,$00
.byte $55,$55,$55,$55,$55,$55,$55,$55,$55,$AA,$00,$00,$00,$00,$00,$00
.byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
.byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
.byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00

.byte $55,$55,$55,$55,$55,$55,$55,$55,$55,$00,$00,$00,$00,$00,$00,$00 ; Tower
.byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$55,$55,$55,$55,$55,$00,$00
.byte $AA,$AA,$AA,$AA,$00,$00,$AA,$AA,$AA,$00,$00,$00,$00,$55,$55,$55
.byte $AA,$AA,$AA,$AA,$AA,$AA,$AA,$AA,$AA,$AA,$AA,$AA,$AA,$00,$00,$00
.byte $AA,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
.byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
.byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
.byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00

.byte $55,$55,$55,$55,$55,$55,$55,$55,$55,$00,$00,$00,$55,$00,$00,$00 ; Shrine
.byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
.byte $55,$55,$55,$55,$55,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
.byte $AA,$AA,$AA,$AA,$AA,$AA,$AA,$AA,$AA,$00,$AA,$AA,$AA,$FF,$00,$00
.byte $00,$AA,$AA,$AA,$AA,$AA,$AA,$00,$00,$00,$00,$AA,$AA,$AA,$AA,$AA
.byte $00,$00,$00,$55,$55,$AA,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
.byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
.byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00

.byte $55,$55,$55,$55,$55,$55,$55,$55,$55,$00,$00,$00,$00,$00,$00,$00 ; Sky Palace
.byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$AA,$00,$00,$00,$00,$00,$00
.byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$AA,$AA,$FF,$FF,$00,$00,$00,$00
.byte $00,$FF,$FF,$FF,$FF,$FF,$00,$00,$00,$55,$55,$FF,$00,$00,$00,$00
.byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
.byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
.byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00

.byte $55,$55,$55,$55,$55,$55,$55,$55,$55,$00,$00,$00,$55,$00,$00,$00 ; Temple
.byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
.byte $55,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$AA,$AA,$FF,$00
.byte $00,$FF,$FF,$FF,$00,$00,$00,$00,$00,$00,$00,$FF,$FF,$FF,$FF,$FF
.byte $FF,$FF,$FF,$FF,$00,$55,$55,$FF,$FF,$FF,$FF,$FF,$FF,$00,$00,$00
.byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
.byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00



;; $8800 ;; 
;; Map tile data, 0x100 bytes per tileset
; 2 bytes per tile:
;  +0: bits 5-7: 000..... ; 0-1x     = normal
;                001..... ; 2-3x     = battle! Battle in $6a, BG in $53
;                010..... ; 4-5x     = WARP!
;                011..... ; 6-7x     = Warp without transition
;                100..... ; 8-9x     = Map-to-map teleport (+1 is target)
;                101..... ; A-Bx     = Warp without transition
;                110..... ; C-Dx     = Map-to-world teleport (+1 is target)
;                111..... ; E-Fx     = Warp without transition
;      bits 0-4: ...00000 ; 00       = No battle here
;                ...00001 ; 01       = Can't step here
;                ...0001x ; 03 - 02  = Door; +1 is shop number or 0 for regular door
;                ...0010x ; 05 - 04  = Need KEY
;                ...0011x ; 07 - 06  = Closes door
;                ...0100x ; 09 - 08  = Treasure chest (contents specified by +1)
;                ...0101x ; 0B - 0A  = Spiked square if +1 bit 7 clear, otherwise normal battle
;                ...0110x ; 0D - 0C  = Damage square
;                ...0111x ; 0F - 0E  = Need CROWN to step here
;                ...1000x ; 11 - 10  = Need CUBE to step here
;                ...1001x ; 13 - 12  = Need all ORBS to step here
;                ...1010x ; 15 - 14  = Use ROD
;                ...1011x ; 17 - 16  = Use LUTE
;                ...1100x ; 19 - 18  = Give Earth orb
;                ...1101x ; 1B - 1A  = Give Fire orb
;                ...1110x ; 1D - 1C  = Give Water orb
;                ...1111x ; 1F - 1E  = Give Wind orb
;          Also: bit 0: set if sprites cannot step here
;          Also: bit 1: If set, no message when pressing A at this square
;  +1: index for whatever is specified in byte 0


; JIGS - new version:
; 1xx..... - 80 - Can't step here
; x1x..... - 40 - Has unique dialogue
; 11x..... - C0 - Can't step + unique dialogue
; xx1..... - 20 - Sprite goes behind tile
; 
; 00 - Nothing special
; 01 - Warp to Previous Floor
; 02 - Warp to Map ; Map in +1
; 03 - Warp to Overworld ; Map in +1 ? 
; 04 - Door ; Shop in +1, 0 for normal room
; 05 - Locked Door
; 06 - Closes Door above tile
; 07 - Damage square
; 08 - Battle ; +1 = 80 for random encounter, else its Battle ID
; 09 - Treasure Chest, First Table ; Chest ID in +1
; 0A - Treasure Chest, Second Table ; Chest ID in +1
; 0B - Can use Quest item here ; Item in +1 
; 0C - Can save/Rest here
; 0D - Restore HP
; 0E - Restore MP
; 0F - Restore HP/MP
; 10 - Revive from Death
; 11 - Revive from Ailments -Death
; 12 - Grant Orb based on Map ID
; 13 - Requires 4 Orbs to Activate Teleport
; 14 - Requires CUBE to Activate Teleport
; 15 - Requires CROWN to Activate Teleport
; 16 - Activates Save Screen (like a bed or campfire)?
; 17 - 
; 18 - 
; 19 - 
; 1A - 
; 1B - 
; 1C - 
; 1D - 
; 1E - 
; 1F - 
; 
; 
; 










lut_SMTilesetProp:

; Town
.byte $00,$00 ; Grass
.byte $00,$00 ; Grass - left side in dark shade
.byte $00,$00 ; Grass - left side in dark shade, shade end
.byte $80,$00 ; Wall
.byte $80,$00 ; Wall
.byte $80,$00 ; Wall
.byte $80,$00 ; Wall - left side end
.byte $80,$00 ; Wall - middle
.byte $80,$00 ; Wall - right side end
.byte $80,$00 ; Wall - right side in shade
.byte $80,$00 ; Vertical wall - left side grass
.byte $80,$00 ; Vertical wall - right side grass, shade top end
.byte $80,$00 ; Vertical wall - right side shade
.byte $80,$00 ; Vertical wall - bottom corner, right side shade, bottom is grass
.byte $80,$00 ; Tree
.byte $80,$00 ; Two trees/bush
.byte $00,$00 ; Cobbles
.byte $00,$00 ; Cobbles, curved upper left corner
.byte $00,$00 ; Cobbles, curved upper right corner
.byte $00,$00 ; Cobbles, curved lower left corner
.byte $00,$00 ; Cobbles, curved lower right corner
.byte $00,$00 ; Cobbles, lower left corner in shade
.byte $00,$00 ; Cobbles, upper left corner in shade, lower left in shade end piece
.byte $80,$00 ; Roof tile, back side
.byte $80,$00 ; Roof tile continuous
.byte $80,$00 ; Roof tile, back side
.byte $80,$00 ; Clinic sign
.byte $80,$00 ; Roof gable
.byte $80,$00 ; Hat-shaped window
.byte $80,$00 ; Two small windows
.byte $04,$01 ; Door - Coneria Weapons
.byte $04,$02 ; Door - Pravoka Weapons
.byte $80,$00 ; Item sign
.byte $80,$00 ; Weapon sign
.byte $80,$00 ; Shield sign
.byte $80,$00 ; W. magic sig
.byte $80,$00 ; B. magic sign
.byte $80,$00 ; Inn sign
.byte $04,$03 ; Door - Elfland Weapons
.byte $80,$00 ; Water
.byte $80,$00 ; Water, left side shade
.byte $80,$00 ; Water, left side shade with end piece
.byte $00,$00 ; Bridge =
.byte $00,$00 ; Bridge ||
.byte $00,$00 ; Steps
.byte $04,$04 ; Door - Melmond Weapons
.byte $C0,$E6 ; Fountain (come wash your face)
.byte $C0,$EE ; Grave (This is a tomb.)
.byte $80,$00 ; Fence
.byte $C0,$EF ; Well (Ordinary well dialogue.)
.byte $00,$00 ; Sand
.byte $00,$00 ; Sandy Grass
.byte $80,$00 ; Palm trees
.byte $06,$00 ; Stairs - Door Closer
.byte $04,$05 ; Door - Crescent Lake Weapons
.byte $00,$00 ; Opened door
.byte $06,$00 ; Cobbles - Door Closer
.byte $06,$00 ; Grass - Door Closer
.byte $06,$00 ; Bridge || - Door Closer
.byte $C0,$F7 ; Water (At the bottom of the spring, something is flowing.)
.byte $06,$00 ; Sand - Door Closer
.byte $06,$00 ; Sandy Grass - Door Closer
.byte $04,$06 ; Door - Gaia Weapon
.byte $04,$07 ; Door - unused shop
.byte $04,$08 ; Door - unused shop
.byte $04,$09 ; Door - unused shop
.byte $04,$0A ; Door - unused shop
.byte $04,$0B ; Door - Coneria Armor
.byte $04,$0C ; Door - Pravoka Armor
.byte $04,$0D ; Door - Elfland Armor
.byte $04,$0E ; Door - Melmond Armor
.byte $01,$00 ; Grass (teleport?)
.byte $02,$20 ; Submarine (teleport to underwater shrine)
.byte $04,$0F ; Door - LakeArmor     
.byte $04,$10 ; Door - GaiaArmor     
.byte $04,$11 ; Door - UnusedShop    
.byte $04,$12 ; Door - UnusedShop    
.byte $04,$13 ; Door - UnusedShop    
.byte $04,$14 ; Door - UnusedShop    
.byte $04,$15 ; Door - ConeriaWMagic
.byte $04,$16 ; Door - ProvokaWMagic 
.byte $04,$17 ; Door - ElflandWMagic 
.byte $04,$18 ; Door - MelmondWMagic 
.byte $04,$19 ; Door - LakeWMagic    
.byte $04,$1A ; Door - ElflandWMagic2
.byte $04,$1B ; Door - GaiaWMagic    
.byte $04,$1C ; Door - GaiaWMagic2   
.byte $04,$1D ; Door - OnracWMagic   
.byte $04,$1E ; Door - LeifenWMagic  
.byte $04,$1F ; Door - ConeriaBMagic
.byte $04,$20 ; Door - ProvokaBMagic 
.byte $04,$21 ; Door - ElflandBMagic 
.byte $04,$22 ; Door - MelmondBMagic 
.byte $04,$23 ; Door - LakeBMagic    
.byte $04,$24 ; Door - ElflandBMagic2
.byte $04,$25 ; Door - GaiaBMagic    
.byte $04,$26 ; Door - GaiaBMagic2   
.byte $04,$27 ; Door - OnracBMagic   
.byte $04,$28 ; Door - LeifenBMagic  
.byte $04,$29 ; Door - ConeriaTemple
.byte $04,$2A ; Door - ElflandTemple 
.byte $04,$2B ; Door - LakeTemple    
.byte $04,$2C ; Door - GaiaTemple    
.byte $04,$2D ; Door - OnracTemple   
.byte $04,$2E ; Door - ProvokaTemple 
.byte $04,$2F ; Door - UnusedShop    
.byte $04,$30 ; Door - UnusedShop    
.byte $04,$31 ; Door - UnusedShop    
.byte $04,$32 ; Door - UnusedShop    
.byte $04,$33 ; Door - ConeriaInn   
.byte $04,$34 ; Door - ProvokaInn    
.byte $04,$35 ; Door - ElflandInn    
.byte $04,$36 ; Door - MelmondInn    
.byte $04,$37 ; Door - LakeInn       
.byte $04,$38 ; Door - GaiaInn       
.byte $04,$39 ; Door - OnracInn      
.byte $04,$3A ; Door - UnusedShop    
.byte $04,$3B ; Door - UnusedShop    
.byte $04,$3C ; Door - UnusedShop    
.byte $04,$3D ; Door - ConeriaItem  
.byte $04,$3E ; Door - ProvokaItem   
.byte $04,$3F ; Door - ElflandItem   
.byte $04,$40 ; Door - LakeItem      
.byte $04,$41 ; Door - GaiaItem      
.byte $04,$42 ; Door - OnracItem     
.byte $04,$43 ; Door - UnusedShop    
.byte $04,$44 ; Door - UnusedShop    
.byte $C0,$DB ; Grave (special) 

; Castle
.byte $80,$00 ; In room, upper left corner 
.byte $80,$00 ; In room, back wall
.byte $80,$00 ; In room, upper right corner
.byte $80,$00 ; In room, left wall
.byte $00,$00 ; In room, middle floor
.byte $80,$00 ; In room, right wall 
.byte $80,$00 ; In room, lower left corner
.byte $00,$00 ; In room, bottom wall
.byte $80,$00 ; In room, lower right corner
.byte $00,$00 ; Floor
.byte $00,$00 ; In room, Ladder
.byte $00,$00 ; Floor
.byte $00,$00 ; In room, Altar corner? 
.byte $80,$00 ; In room, Table
.byte $80,$00 ; In room, Table alt
.byte $00,$00 ; In room, Bed, top
.byte $00,$00 ; In room, Bed
.byte $00,$00 ; In room, Side table, right
.byte $00,$00 ; In room, Side table, left
.byte $80,$00 ; In room, Two urns
.byte $80,$00 ; In room, Fancy wardrobe top?
.byte $80,$00 ; In room, Long table, top end
.byte $80,$00 ; In room, Long table, middle
.byte $80,$00 ; In room, Long table, bottom end
.byte $80,$00 ; In room, Fancy wardrobe top?
.byte $80,$00 ; In room, Gryphon statue, facing right
.byte $80,$00 ; In room, Gryphon statue, facing left
.byte $80,$00 ; In room, Throne left side
.byte $00,$00 ; In room, Throne seat
.byte $80,$00 ; In room, Throne right side
.byte $80,$00 ; In room, Throne upper left
.byte $80,$00 ; In room, Throne top
.byte $80,$00 ; In room, Throne upper right
.byte $00,$00 ; Grass
.byte $00,$00 ; Floor
.byte $00,$00 ; Floor
.byte $00,$00 ; Floor
.byte $00,$00 ; Floor
.byte $00,$00 ; Floor
.byte $00,$00 ; Floor
.byte $00,$00 ; Floor
.byte $00,$00 ; Floor
.byte $00,$00 ; Floor
.byte $00,$00 ; Floor
.byte $00,$00 ; Floor
.byte $00,$00 ; Floor
.byte $00,$00 ; Floor
.byte $00,$00 ; Floor
.byte $80,$00 ; Back Wall
.byte $00,$00 ; Cobble floor
.byte $80,$00 ; Wall left side
.byte $80,$00 ; Wall right side
.byte $80,$00 ; Back wall left side
.byte $80,$00 ; Back wall right side
.byte $04,$00 ; Closed door, opens rooms
.byte $00,$00 ; Open door
.byte $80,$00 ; Pillar
.byte $01,$00 ; Grass - Warp to previous map
.byte $06,$00 ; Cobble floor, closes doors
.byte $45,$BF ; Closed door (locked)
.byte $80,$00 ; Open air/sky
.byte $03,$04 ; Grass - Exit Coneria Castle
.byte $00,$00 ; Floor
.byte $00,$00 ; Floor
.byte $03,$03 ; Grass - Exit Castle of Ordeals
.byte $00,$00 ; Floor
.byte $00,$00 ; Floor
.byte $00,$00 ; Floor
.byte $02,$00 ; Stairs up - To Coneria Castle upper floor
.byte $02,$17 ; Stairs up - To Castle of Ordeals 2
.byte $00,$00 ; Floor
.byte $00,$00 ; Floor
.byte $01,$00 ; Stairs down - Warp to previous map
.byte $02,$3E ; Stairs down - To Coneria Castle lower floor
.byte $00,$00 ; Floor
.byte $00,$00 ; Floor
.byte $02,$1A ; Teleport pillar, Castle of Ordeals 4
.byte $02,$1B ; Teleport pillar, Castle of Ordeals 5 
.byte $02,$1C ; Teleport pillar, Castle of Ordeals 6
.byte $02,$1D ; Teleport pillar, Castle of Ordeals 7
.byte $02,$1E ; Teleport pillar, Castle of Ordeals 8
.byte $02,$1F ; Teleport pillar, Castle of Ordeals 9
.byte $02,$3A ; Teleport pillar, Castle of Ordeals A
.byte $02,$3B ; Teleport pillar, Castle of Ordeals B
.byte $02,$3C ; Teleport pillar, Castle of Ordeals C
.byte $02,$3D ; Teleport pillar, Castle of Ordeals D
.byte $00,$00 ; Floor
.byte $00,$00 ; Floor
.byte $00,$00 ; Walk-through pillar?
.byte $08,$1D ; In room, Floor - Battle 1D
.byte $08,$18 ; In room, Floor - Battle 18
.byte $08,$3F ; In room, Floor - Battle 3F
.byte $08,$4F ; In room, Lower wall - Battle 4F
.byte $08,$4B ; In room, Floor - Battle 4B
.byte $08,$80 ; In room, Floor - Random encounter
.byte $08,$00 ; In room, Floor - Battle 0
.byte $08,$80 ; Cobbles - Random encounter
.byte $15,$16 ; In room, Crown-required throne seat
.byte $15,$18 ; In room, Crown-required throne seat
.byte $09,$01 ; In room, Treasure
.byte $09,$02 ; In room, Treasure
.byte $09,$03 ; In room, Treasure
.byte $09,$04 ; In room, Treasure
.byte $09,$05 ; In room, Treasure
.byte $09,$06 ; In room, Treasure
.byte $09,$0D ; In room, Treasure
.byte $09,$0E ; In room, Treasure
.byte $09,$0F ; In room, Treasure
.byte $09,$10 ; In room, Treasure
.byte $09,$11 ; In room, Treasure
.byte $09,$12 ; In room, Treasure
.byte $09,$13 ; In room, Treasure
.byte $09,$7B ; In room, Treasure
.byte $09,$7C ; In room, Treasure
.byte $09,$7D ; In room, Treasure
.byte $09,$7E ; In room, Treasure
.byte $09,$7F ; In room, Treasure
.byte $09,$80 ; In room, Treasure
.byte $09,$81 ; In room, Treasure
.byte $09,$82 ; In room, Treasure
.byte $09,$83 ; In room, Treasure
.byte $00,$00 ; Floor 
.byte $00,$00 ; Floor 
.byte $00,$00 ; Floor 
.byte $00,$00 ; Floor 
.byte $00,$00 ; Floor 
.byte $00,$00 ; Floor 
.byte $00,$00 ; Floor 

; Cave        ; 
.byte $80,$00 ; In room, upper left corner 
.byte $80,$00 ; In room, back wall
.byte $80,$00 ; In room, upper right corner
.byte $80,$00 ; In room, left wall
.byte $00,$00 ; In room, middle floor
.byte $80,$00 ; In room, right wall 
.byte $80,$00 ; In room, lower left corner
.byte $00,$00 ; In room, bottom wall
.byte $80,$00 ; In room, lower right corner
.byte $00,$00 ; In room, Ladder top
.byte $00,$00 ; In room, Ladder bottom
.byte $00,$00 ; Cave floor
.byte $00,$00 ; In room, useless corner piece thing
.byte $80,$00 ; In room, candlestick
.byte $12,$F3 ; In room, Earth orb
.byte $03,$05 ; In room, Exit Earth Cave teleport
.byte $80,$00 ; In room, altar statue left
.byte $80,$00 ; In room, altar statue right
.byte $00,$00 ; In room, up-arrow floor
.byte $80,$00 ; In room, spiky stalagwossits
.byte $80,$00 ; In room, spiky stalagwossits alternate
.byte $03,$00 ; Stairs up - exit Titan cave east
.byte $03,$01 ; Stairs up - exit Titan cave west
.byte $12,$F4 ; in room, Fire orb - $1A,$F4
.byte $01,$00 ; Stairs up - Return floor
.byte $02,$0C ; Stairs up - Volcano 4
.byte $00,$00 ; Blank floor
.byte $08,$1E ; Cave floor - Battle 1E
.byte $08,$1F ; Cave floor - Battle 1F
.byte $08,$21 ; In room, blank floor - Battle 21
.byte $08,$6E ; In room, blank floor - Battle 6E
.byte $03,$06 ; In room, Exit Volcano teleport
.byte $0B,ROD ; Cave floor - Can use Rod here
.byte $08,$6F ; In room, blank floor - Battle 6F
.byte $08,$27 ; In room, blank floor - Battle 27
.byte $08,$28 ; In room, blank floor - Battle 28
.byte $02,$05 ; Stairs Down - Earth Cave 1
.byte $02,$06 ; Stairs Down - Earth Cave 2
.byte $02,$07 ; Stairs Down - Earth Cave 3
.byte $02,$08 ; Stairs Down - Earth Cave 4
.byte $02,$09 ; Stairs Down - Volcano 1
.byte $02,$0A ; Stairs Down - Volcano 2
.byte $02,$0B ; Stairs Down - Volcano 3
.byte $02,$0D ; Stairs Down - Volcano 5
.byte $02,$0E ; Stairs Down - Volcano 6
.byte $01,$00 ; Stairs Down - return floor
.byte $08,$80 ; In room, blank floor - random encounters
.byte $08,$29 ; In room, blank floor - Battle 29
.byte $80,$00 ; Back Wall
.byte $00,$00 ; Cave floor
.byte $80,$00 ; Wall left side
.byte $80,$00 ; Wall right side
.byte $80,$00 ; Back wall left side
.byte $80,$00 ; Back wall right side
.byte $04,$00 ; Closed door, opens rooms
.byte $00,$00 ; Open door
.byte $00,$00 ; Blank floor
.byte $00,$00 ; ?? Weird looking cave floor ??
.byte $06,$00 ; Cave floor, closes doors
.byte $45,$BF ; Closed door (locked)
.byte $80,$00 ; Water/Lava
.byte $07,$00 ; Damage tile, lava
.byte $80,$00 ; Cave filler
.byte $80,$00 ; Cave filler
.byte $08,$2A ; In room, blank floor - Battle 2A
.byte $08,$80 ; Cave floor - random encounters 
.byte $09,$2E ; In room, treasure
.byte $09,$2F ; In room, treasure
.byte $09,$30 ; In room, treasure
.byte $09,$31 ; In room, treasure
.byte $09,$32 ; In room, treasure
.byte $09,$33 ; In room, treasure
.byte $09,$34 ; In room, treasure
.byte $09,$35 ; In room, treasure
.byte $09,$36 ; In room, treasure
.byte $09,$37 ; In room, treasure
.byte $09,$38 ; In room, treasure
.byte $09,$39 ; In room, treasure
.byte $09,$3A ; In room, treasure
.byte $09,$3B ; In room, treasure
.byte $09,$3C ; In room, treasure
.byte $09,$3D ; In room, treasure
.byte $09,$3E ; In room, treasure
.byte $09,$3F ; In room, treasure
.byte $09,$40 ; In room, treasure
.byte $09,$41 ; In room, treasure
.byte $09,$42 ; In room, treasure
.byte $09,$43 ; In room, treasure
.byte $09,$44 ; In room, treasure
.byte $09,$45 ; In room, treasure
.byte $09,$46 ; In room, treasure
.byte $09,$47 ; In room, treasure
.byte $09,$48 ; In room, treasure
.byte $09,$49 ; In room, treasure
.byte $09,$4A ; In room, treasure
.byte $09,$4B ; In room, treasure
.byte $09,$4C ; In room, treasure
.byte $09,$4D ; In room, treasure
.byte $09,$4E ; In room, treasure
.byte $09,$4F ; In room, treasure
.byte $09,$50 ; In room, treasure
.byte $09,$51 ; In room, treasure
.byte $09,$52 ; In room, treasure
.byte $09,$53 ; In room, treasure
.byte $09,$54 ; In room, treasure
.byte $09,$55 ; In room, treasure
.byte $09,$56 ; In room, treasure
.byte $09,$57 ; In room, treasure
.byte $09,$58 ; In room, treasure
.byte $09,$59 ; In room, treasure
.byte $09,$5A ; In room, treasure
.byte $09,$5B ; In room, treasure
.byte $09,$5C ; In room, treasure
.byte $09,$5D ; In room, treasure
.byte $09,$5E ; In room, treasure
.byte $09,$5F ; In room, treasure
.byte $09,$60 ; In room, treasure
.byte $09,$61 ; In room, treasure
.byte $09,$62 ; In room, treasure
.byte $09,$63 ; In room, treasure
.byte $09,$64 ; In room, treasure
.byte $09,$65 ; In room, treasure
.byte $09,$66 ; In room, treasure
.byte $09,$67 ; In room, treasure
.byte $09,$68 ; In room, treasure
.byte $09,$69 ; In room, treasure
.byte $09,$6A ; In room, treasure
.byte $00,$00 ; Blank floor

; Safe Cave   ; 
.byte $80,$00 ; In room, upper left corner 
.byte $90,$00 ; In room, back wall
.byte $80,$00 ; In room, upper right corner
.byte $80,$00 ; In room, left wall
.byte $00,$00 ; In room, middle floor
.byte $80,$00 ; In room, right wall 
.byte $80,$00 ; In room, lower left corner
.byte $00,$00 ; In room, bottom wall
.byte $80,$00 ; In room, lower right corner
.byte $00,$00 ; Blank floor
.byte $00,$00 ; In room, Ladder bottom
.byte $00,$00 ; Blank floor
.byte $00,$00 ; In room, useless corner piece thing
.byte $80,$00 ; In room, candlestick
.byte $40,$B3 ; In room, Sword
.byte $00,$00 ; In room, Chair
.byte $80,$00 ; In room, Table
.byte $80,$00 ; In room, Fireplace
.byte $80,$00 ; In room, small, large urns
.byte $00,$00 ; In room, Skull
.byte $00,$00 ; In room, bed top
.byte $00,$00 ; In room, bed body
.byte $80,$00 ; In room, anvil
.byte $80,$00 ; In room, hammer
.byte $01,$00 ; Stairs up - warp to last map
.byte $02,$11 ; Stairs up - Ice Cave 3
.byte $02,$13 ; Stairs up - Ice Cave 5
.byte $03,$02 ; Stairs up - Exit Ice Cave
.byte $00,$00 ; Blank floor
.byte $00,$00 ; Blank floor
.byte $00,$00 ; Blank floor
.byte $00,$00 ; Blank floor
.byte $00,$00 ; Blank floor
.byte $00,$00 ; Blank floor
.byte $00,$00 ; Blank floor
.byte $00,$00 ; Blank floor
.byte $00,$00 ; Blank floor
.byte $00,$00 ; Blank floor
.byte $00,$00 ; Blank floor
.byte $00,$00 ; Blank floor
.byte $01,$00 ; Stairs down - warp to last map
.byte $02,$0F ; Stairs down - Ice Cave 1
.byte $02,$10 ; Stairs down - Ice Cave 2
.byte $02,$14 ; Stairs down - Ice Cave 6
.byte $02,$19 ; Stairs down - Bahamut's Room
.byte $02,$12 ; In room, Hole - Ice Cave 4
.byte $02,$15 ; In room, Hole - Ice Cave 7
.byte $00,$00 ; Blank floor
.byte $80,$00 ; Back Wall
.byte $00,$00 ; Cave floor
.byte $80,$00 ; Wall left side
.byte $80,$00 ; Wall right side
.byte $80,$00 ; Back wall left side
.byte $80,$00 ; Back wall right side
.byte $04,$00 ; Closed door, opens rooms
.byte $00,$00 ; Open door
.byte $80,$00 ; Well
.byte $07,$00 ; Damage tile, Ice
.byte $06,$00 ; Cave floor, closes doors
.byte $45,$BF ; Closed door (locked)
.byte $00,$00 ; Blank floor
.byte $80,$00 ; Cave filler
.byte $00,$00 ; Blank floor
.byte $00,$00 ; Blank floor
.byte $08,$2C ; In room, bottom wall, Battle 
.byte $08,$2D ; In room, Battle 
.byte $08,$2E ; In room, Battle 
.byte $08,$2F ; In room, Battle 
.byte $08,$30 ; In room, bottom wall, Battle 
.byte $08,$69 ; In room, Battle 
.byte $08,$80 ; In room, Random encounters
.byte $08,$00 ; In room, Battle 
.byte $08,$4A ; In room, bottom wall, Battle 
.byte $08,$80 ; Cave floor, Random encounters
.byte $00,$00 ; Blank floor
.byte $09,$21 ; Treasure
.byte $09,$22 ; Treasure
.byte $09,$23 ; Treasure
.byte $09,$24 ; Treasure
.byte $09,$25 ; Treasure
.byte $09,$26 ; Treasure
.byte $09,$27 ; Treasure
.byte $09,$28 ; Treasure
.byte $09,$29 ; Treasure
.byte $09,$2A ; Treasure
.byte $09,$2B ; Treasure
.byte $09,$2C ; Treasure
.byte $09,$2D ; Treasure
.byte $09,$6B ; Treasure
.byte $09,$6C ; Treasure
.byte $09,$6D ; Treasure
.byte $09,$6E ; Treasure
.byte $09,$6F ; Treasure
.byte $09,$70 ; Treasure
.byte $09,$71 ; Treasure
.byte $09,$72 ; Treasure
.byte $09,$73 ; Treasure
.byte $09,$74 ; Treasure
.byte $09,$75 ; Treasure
.byte $09,$76 ; Treasure
.byte $09,$77 ; Treasure
.byte $09,$78 ; Treasure
.byte $09,$79 ; Treasure
.byte $09,$7A ; Treasure
.byte $09,$84 ; Treasure
.byte $09,$85 ; Treasure
.byte $09,$86 ; Treasure
.byte $09,$87 ; Treasure
.byte $09,$88 ; Treasure
.byte $09,$89 ; Treasure
.byte $09,$8A ; Treasure
.byte $09,$8B ; Treasure
.byte $09,$8C ; Treasure
.byte $09,$8D ; Treasure
.byte $09,$8E ; Treasure
.byte $09,$8F ; Treasure
.byte $09,$90 ; Treasure
.byte $09,$91 ; Treasure
.byte $09,$92 ; Treasure
.byte $09,$93 ; Treasure
.byte $09,$94 ; Treasure
.byte $09,$B5 ; Treasure
.byte $09,$B6 ; Treasure
.byte $09,$B7 ; Treasure
.byte $09,$B8 ; Treasure
.byte $09,$B9 ; Treasure
.byte $09,$BA ; Treasure
.byte $00,$00 ; Blank floor

; Tower       ; 
.byte $80,$00 ; In room, upper left corner 
.byte $80,$00 ; In room, back wall
.byte $80,$00 ; In room, upper right corner
.byte $80,$00 ; In room, left wall
.byte $00,$00 ; In room, middle floor
.byte $80,$00 ; In room, right wall 
.byte $80,$00 ; In room, lower left corner
.byte $00,$00 ; In room, bottom wall
.byte $80,$00 ; In room, lower right corner
.byte $01,$00 ; In room, Ladder top - teleport to previous map
.byte $02,$03 ; In room, Ladder bottom - Marsh cave 2
.byte $00,$00 ; Blank floor
.byte $00,$00 ; In room, useless corner piece thing
.byte $80,$00 ; In room, square pyramid
.byte $80,$00 ; In room, Kitchen appliances
.byte $80,$00 ; In room, Big ol' Tablet
.byte $80,$00 ; In room, Table
.byte $80,$00 ; In room, Stove
.byte $80,$00 ; In room, Stack of film reels
.byte $80,$00 ; In room, Stereo, left side
.byte $80,$00 ; In room, Stereo, right side
.byte $00,$00 ; blank floor
.byte $00,$00 ; In room, chair
.byte $80,$00 ; In room, Ruined bust
.byte $80,$00 ; In room, Smart home speaker?
.byte $08,$1C ; In room, battle
.byte $08,$1C ; In room, battle
.byte $08,$15 ; In room, battle
.byte $08,$4E ; In room, bottom wall, battle
.byte $08,$50 ; In room, battle
.byte $00,$00 ; blank floor
.byte $00,$00 ; blank floor
.byte $02,$02 ; Stairs down - Marsh Cave 1
.byte $00,$00 ; Stairs down - nothing
.byte $02,$04 ; Stairs down - Marsh Cave 3
.byte $01,$00 ; Stairs down - Warp to last map
.byte $00,$00 ; blank floor
.byte $00,$00 ; blank floor
.byte $01,$00 ; Stairs up - Warp to last map
.byte $02,$29 ; Stairs up - Mirage Tower 1
.byte $02,$2A ; Stairs up - Mirage Tower 2
.byte $00,$00 ; blank floor
.byte $00,$00 ; blank floor
.byte $00,$00 ; blank floor
.byte $14,$2B ; In room, Cube-required teleport
.byte $08,$80 ; In room, Random encounters
.byte $08,$00 ; In room, battle
.byte $08,$00 ; In room, battle
.byte $80,$00 ; Back Wall
.byte $00,$00 ; Tower floor
.byte $80,$00 ; Wall left side
.byte $80,$00 ; Wall right side
.byte $80,$00 ; Back wall left side
.byte $80,$00 ; Back wall right side
.byte $04,$00 ; Closed door, opens rooms
.byte $00,$00 ; Open door
.byte $00,$00 ; Floor glyph
.byte $80,$00 ; Pillar
.byte $06,$00 ; Tower floor, closes doors
.byte $45,$BF ; Closed door (locked)
.byte $00,$00 ; Shag carpeting?
.byte $00,$00 ; Blank floor
.byte $00,$00 ; Blank floor
.byte $00,$00 ; Blank floor
.byte $08,$80 ; Cave floor, random encounters
.byte $09,$14 ; Treasure
.byte $09,$15 ; Treasure
.byte $09,$16 ; Treasure
.byte $09,$17 ; Treasure
.byte $09,$18 ; Treasure
.byte $09,$19 ; Treasure
.byte $09,$1A ; Treasure
.byte $09,$1B ; Treasure
.byte $09,$1C ; Treasure
.byte $09,$1D ; Treasure
.byte $09,$1E ; Treasure
.byte $09,$1F ; Treasure
.byte $09,$20 ; Treasure
.byte $09,$C4 ; Treasure
.byte $09,$C5 ; Treasure
.byte $09,$C6 ; Treasure
.byte $09,$C7 ; Treasure
.byte $09,$C8 ; Treasure
.byte $09,$C9 ; Treasure
.byte $09,$CA ; Treasure
.byte $09,$CB ; Treasure
.byte $09,$CC ; Treasure
.byte $09,$CD ; Treasure
.byte $09,$CE ; Treasure
.byte $09,$CF ; Treasure
.byte $09,$D0 ; Treasure
.byte $09,$D1 ; Treasure
.byte $09,$D2 ; Treasure
.byte $09,$D3 ; Treasure
.byte $09,$D4 ; Treasure
.byte $09,$D5 ; Treasure
.byte $09,$BB ; Treasure
.byte $09,$BC ; Treasure
.byte $09,$BD ; Treasure
.byte $09,$BE ; Treasure
.byte $09,$BF ; Treasure
.byte $09,$C0 ; Treasure
.byte $09,$C1 ; Treasure
.byte $09,$C2 ; Treasure
.byte $00,$00 ; Blank Floor
.byte $00,$00 ; Blank Floor
.byte $00,$00 ; Blank Floor
.byte $00,$00 ; Blank Floor
.byte $00,$00 ; Blank Floor
.byte $00,$00 ; Blank Floor
.byte $00,$00 ; Blank Floor
.byte $00,$00 ; Blank Floor
.byte $00,$00 ; Blank Floor
.byte $00,$00 ; Blank Floor
.byte $00,$00 ; Blank Floor
.byte $00,$00 ; Blank Floor
.byte $00,$00 ; Blank Floor
.byte $00,$00 ; Blank Floor
.byte $00,$00 ; Blank Floor
.byte $00,$00 ; Blank Floor
.byte $00,$00 ; Blank Floor
.byte $00,$00 ; Blank Floor
.byte $00,$00 ; Blank Floor
.byte $00,$00 ; Blank Floor
.byte $00,$00 ; Blank Floor
.byte $00,$00 ; Blank Floor
.byte $00,$00 ; Blank Floor
.byte $00,$00 ; Blank Floor

; Shrine      ; 
.byte $80,$00 ; In room, upper left corner 
.byte $80,$00 ; In room, back wall
.byte $80,$00 ; In room, upper right corner
.byte $80,$00 ; In room, left wall
.byte $00,$00 ; In room, middle floor
.byte $80,$00 ; In room, right wall 
.byte $80,$00 ; In room, lower left corner
.byte $00,$00 ; In room, bottom wall
.byte $80,$00 ; In room, lower right corner
.byte $00,$00 ; Blank floor
.byte $00,$00 ; In room, Ladder bottom
.byte $00,$00 ; Blank floor
.byte $00,$00 ; In room, useless corner piece th
.byte $80,$00 ; In room, Wooden table
.byte $00,$00 ; Blank floor
.byte $03,$07 ; In room, Water Orb teleport to overworld
.byte $80,$00 ; In room, Shrine statue left
.byte $80,$00 ; In room, Shrine statue right
.byte $80,$00 ; In room, Water Altar statue left
.byte $12,$F5 ; In room, Water orb altar
.byte $80,$00 ; In room, Water Altar statue right
.byte $80,$00 ; In room, casket
.byte $00,$00 ; In room, chair
.byte $80,$00 ; In room, eroded tablet
.byte $00,$00 ; blank floor
.byte $00,$00 ; blank floor
.byte $00,$00 ; blank floor
.byte $00,$00 ; blank floor
.byte $00,$00 ; blank floor
.byte $00,$00 ; blank floor
.byte $00,$00 ; blank floor
.byte $00,$00 ; blank floor
.byte $08,$10 ; In room, battle
.byte $08,$44 ; In room, battle
.byte $08,$45 ; In room, battle
.byte $08,$49 ; In room, battle
.byte $08,$4A ; In room, battle
.byte $00,$00 ; blank floor
.byte $00,$00 ; blank floor
.byte $00,$00 ; blank floor
.byte $00,$00 ; blank floor
.byte $00,$00 ; blank floor
.byte $00,$00 ; blank floor
.byte $00,$00 ; blank floor
.byte $00,$00 ; blank floor
.byte $00,$00 ; blank floor
.byte $00,$00 ; blank floor
.byte $00,$00 ; blank floor
.byte $80,$00 ; Back Wall
.byte $00,$00 ; Shrine floor
.byte $80,$00 ; Wall left side
.byte $80,$00 ; Wall right side
.byte $80,$00 ; Back wall left side
.byte $80,$00 ; Back wall right side
.byte $04,$00 ; Closed door, opens rooms
.byte $00,$00 ; Open door
.byte $80,$00 ; Pillar
.byte $00,$00 ; blank floor
.byte $06,$00 ; Shrine floor, closes doors
.byte $45,$BF ; Closed door (locked)
.byte $80,$00 ; Water
.byte $00,$00 ; Shag carpeting?
.byte $00,$00 ; Blank floor
.byte $00,$00 ; Blank floor
.byte $13,$01 ; In room, Time warp - teleport to Temple of Fiends past
.byte $01,$00 ; Submarine - Warp to previous map (Onrac)
.byte $01,$00 ; Stairs up - Warp to previous map
.byte $02,$21 ; Stairs up - Sea Shrine 2
.byte $02,$22 ; Stairs up - Sea Shrine 3
.byte $02,$24 ; Stairs up - Sea Shrine 5
.byte $02,$25 ; Stairs up - Sea Shrine 6
.byte $00,$00 ; blank floor
.byte $00,$00 ; blank floor
.byte $00,$00 ; blank floor
.byte $00,$00 ; blank floor
.byte $02,$28 ; Stairs down - Sea Shrine 9
.byte $02,$23 ; Stairs down - Sea Shrine 4
.byte $01,$00 ; Stairs down - Warp to previous map
.byte $02,$26 ; Stairs down - Sea Shrine 7
.byte $02,$27 ; Stairs down - Sea Shrine 8
.byte $00,$00 ; blank floor
.byte $00,$00 ; blank floor
.byte $08,$04 ; blank floor, battle
.byte $08,$80 ; In room, random encounters
.byte $08,$10 ; In room, battle
.byte $08,$80 ; Shrine floor, random encounters
.byte $09,$07 ; Treasure
.byte $09,$08 ; Treasure
.byte $09,$09 ; Treasure
.byte $09,$0A ; Treasure
.byte $09,$0B ; Treasure
.byte $09,$0C ; Treasure
.byte $09,$95 ; Treasure
.byte $09,$96 ; Treasure
.byte $09,$97 ; Treasure
.byte $09,$98 ; Treasure
.byte $09,$99 ; Treasure
.byte $09,$9A ; Treasure
.byte $09,$9B ; Treasure
.byte $09,$9C ; Treasure
.byte $09,$9D ; Treasure
.byte $09,$9E ; Treasure
.byte $09,$9F ; Treasure
.byte $09,$A0 ; Treasure
.byte $09,$A1 ; Treasure
.byte $09,$A2 ; Treasure
.byte $09,$A3 ; Treasure
.byte $09,$A4 ; Treasure
.byte $09,$A5 ; Treasure
.byte $09,$A6 ; Treasure
.byte $09,$A7 ; Treasure
.byte $09,$A8 ; Treasure
.byte $09,$A9 ; Treasure
.byte $09,$AA ; Treasure
.byte $09,$AB ; Treasure
.byte $09,$AC ; Treasure
.byte $09,$AD ; Treasure
.byte $09,$AE ; Treasure
.byte $09,$AF ; Treasure
.byte $09,$B0 ; Treasure
.byte $09,$B1 ; Treasure
.byte $09,$B2 ; Treasure
.byte $09,$B3 ; Treasure
.byte $09,$B4 ; Treasure
.byte $00,$00 ; blank floor
.byte $00,$00 ; blank floor
.byte $00,$00 ; blank floor
.byte $00,$00 ; blank floor

; Sky Palace  ; 
.byte $80,$00 ; In room, upper left corner 
.byte $80,$00 ; In room, back wall
.byte $80,$00 ; In room, upper right corner
.byte $80,$00 ; In room, left wall
.byte $00,$00 ; In room, middle floor
.byte $80,$00 ; In room, right wall 
.byte $80,$00 ; In room, lower left corner
.byte $00,$00 ; In room, bottom wall
.byte $80,$00 ; In room, lower right corner
.byte $00,$00 ; Blank floor
.byte $03,$08 ; In room, Teleport - Exit Sky Castle to Overworld
.byte $00,$00 ; In room, Floor arrow
.byte $80,$00 ; In room, Air Orb altar statue left
.byte $12,$F6 ; In room, Air Orb altar
.byte $80,$00 ; In room, Air Orb altar statue right
.byte $80,$00 ; In room, broken robot
.byte $80,$F8 ; In room, machinery
.byte $80,$F8 ; In room, machinery
.byte $80,$F8 ; In room, machinery
.byte $80,$F8 ; In room, machinery
.byte $80,$F8 ; In room, machinery
.byte $80,$00 ; In room, table
.byte $00,$00 ; In room, chair
.byte $80,$00 ; In room, tablet thing
.byte $80,$00 ; In room, bigger tablet thing
.byte $C0,$F9 ; Space; Sky window
.byte $00,$00 ; Blank floor
.byte $00,$00 ; Blank floor
.byte $00,$00 ; Blank floor
.byte $00,$00 ; Blank floor
.byte $00,$00 ; Blank floor
.byte $00,$00 ; Blank floor
.byte $00,$00 ; Blank floor
.byte $00,$00 ; Blank floor
.byte $00,$00 ; Blank floor
.byte $00,$00 ; Blank floor
.byte $00,$00 ; Blank floor
.byte $00,$00 ; Blank floor
.byte $00,$00 ; Blank floor
.byte $00,$00 ; Blank floor
.byte $00,$00 ; Blank floor
.byte $00,$00 ; Blank floor
.byte $00,$00 ; Blank floor
.byte $00,$00 ; Blank floor
.byte $00,$00 ; Blank floor
.byte $00,$00 ; Blank floor
.byte $00,$00 ; Blank floor
.byte $00,$00 ; Blank floor
.byte $80,$00 ; Back Wall
.byte $00,$00 ; Shrine floor
.byte $80,$00 ; Wall left side
.byte $80,$00 ; Wall right side
.byte $80,$00 ; Back wall left side
.byte $80,$00 ; Back wall right side
.byte $04,$00 ; Closed door, opens rooms
.byte $00,$00 ; Open door
.byte $80,$00 ; Water
.byte $80,$00 ; Space
.byte $06,$00 ; Shrine floor, closes doors
.byte $45,$BF ; Closed door (locked)
.byte $00,$00 ; Blank floor
.byte $00,$00 ; Blank floor
.byte $00,$00 ; Blank floor
.byte $00,$00 ; Blank floor
.byte $01,$00 ; In-room, floor glyph - Warp to previous map
.byte $02,$2C ; Warp Pad Up - Sky Palace 2
.byte $02,$2D ; Warp Pad Up - Sky Palace 3
.byte $02,$2E ; Warp Pad Up - Sky Palace 4
.byte $02,$2F ; Warp Pad Up - Sky Palace 5
.byte $01,$00 ; Warp Pad Down - Warp to previous map
.byte $00,$00 ; blank floor
.byte $00,$00 ; blank floor
.byte $00,$00 ; blank floor
.byte $08,$80 ; In room, random encounters
.byte $08,$80 ; In room, random encounters
.byte $08,$80 ; Palace floor, random encounters
.byte $09,$D6 ; In room, Treasure
.byte $09,$D7 ; In room, Treasure
.byte $09,$D8 ; In room, Treasure
.byte $09,$D9 ; In room, Treasure
.byte $09,$DA ; In room, Treasure
.byte $09,$DB ; In room, Treasure
.byte $09,$DC ; In room, Treasure
.byte $09,$DD ; In room, Treasure
.byte $09,$DE ; In room, Treasure
.byte $09,$DF ; In room, Treasure
.byte $09,$E0 ; In room, Treasure
.byte $09,$E1 ; In room, Treasure
.byte $09,$E2 ; In room, Treasure
.byte $09,$E3 ; In room, Treasure
.byte $09,$E4 ; In room, Treasure
.byte $09,$E5 ; In room, Treasure
.byte $09,$E6 ; In room, Treasure
.byte $09,$E7 ; In room, Treasure
.byte $09,$E8 ; In room, Treasure
.byte $09,$E9 ; In room, Treasure
.byte $09,$EA ; In room, Treasure
.byte $09,$EB ; In room, Treasure
.byte $09,$EC ; In room, Treasure
.byte $09,$ED ; In room, Treasure
.byte $09,$EE ; In room, Treasure
.byte $09,$EF ; In room, Treasure
.byte $09,$F0 ; In room, Treasure
.byte $09,$F1 ; In room, Treasure
.byte $09,$F2 ; In room, Treasure
.byte $09,$F3 ; In room, Treasure
.byte $09,$F4 ; In room, Treasure
.byte $09,$F5 ; In room, Treasure
.byte $09,$F6 ; In room, Treasure
.byte $09,$F7 ; In room, Treasure
.byte $00,$00 ; blank floor
.byte $00,$00 ; blank floor
.byte $00,$00 ; blank floor
.byte $00,$00 ; blank floor
.byte $00,$00 ; blank floor
.byte $00,$00 ; blank floor
.byte $00,$00 ; blank floor
.byte $00,$00 ; blank floor
.byte $00,$00 ; blank floor
.byte $00,$00 ; blank floor
.byte $00,$00 ; blank floor
.byte $00,$00 ; blank floor
.byte $00,$00 ; blank floor
.byte $00,$00 ; blank floor
.byte $00,$00 ; blank floor
.byte $00,$00 ; blank floor
.byte $00,$00 ; blank floor
.byte $00,$00 ; blank floor

; Temple      ; 
.byte $80,$00 ; In room, upper left corner 
.byte $80,$00 ; In room, back wall
.byte $80,$00 ; In room, upper right corner
.byte $80,$00 ; In room, left wall
.byte $00,$00 ; In room, middle floor
.byte $80,$00 ; In room, right wall 
.byte $80,$00 ; In room, lower left corner
.byte $00,$00 ; In room, bottom wall
.byte $80,$00 ; In room, lower right corner
.byte $01,$00 ; In room, Ladder top - warp to previous map
.byte $02,$33 ; In room, Ladder bottom - Temple of Fiends 4
.byte $00,$00 ; Blank floor
.byte $00,$00 ; In room, Broken thing?
.byte $80,$00 ; In room, wooden table
.byte $00,$00 ; Blank floor
.byte $80,$00 ; In room, Teleport thing, unused?
.byte $80,$00 ; In room, Temple statue left
.byte $80,$00 ; In room, Temple statue right
.byte $80,$00 ; In room, Orb altar statue left
.byte $00,$00 ; In room, Orb altar (none)
.byte $80,$00 ; In room, Orb altar statue right
.byte $80,$00 ; In room, Tablet
.byte $00,$00 ; blank floor
.byte $00,$00 ; blank floor
.byte $00,$00 ; blank floor
.byte $00,$00 ; blank floor
.byte $00,$00 ; blank floor
.byte $00,$00 ; blank floor
.byte $00,$00 ; blank floor
.byte $00,$00 ; blank floor
.byte $00,$00 ; blank floor
.byte $00,$00 ; blank floor
.byte $0B,LUTE ; In room, Use Lute here
.byte $00,$00 ; blank floor
.byte $00,$00 ; blank floor
.byte $00,$00 ; blank floor
.byte $00,$00 ; blank floor
.byte $00,$00 ; blank floor
.byte $00,$00 ; blank floor
.byte $00,$00 ; blank floor
.byte $00,$00 ; blank floor
.byte $00,$00 ; blank floor
.byte $00,$00 ; blank floor
.byte $00,$00 ; blank floor
.byte $80,$00 ; Earth Icon
.byte $80,$00 ; Water Icon
.byte $80,$00 ; Fire Icon
.byte $80,$00 ; Air Icon
.byte $80,$00 ; Back Wall
.byte $00,$00 ; Temple floor 
.byte $80,$00 ; Wall left side 
.byte $80,$00 ; Wall right side 
.byte $80,$00 ; Back wall left side 
.byte $80,$00 ; Back wall right side 
.byte $04,$00 ; Closed door, opens rooms 
.byte $00,$00 ; Open door 
.byte $80,$00 ; Pillar
.byte $80,$00 ; Block
.byte $06,$00 ; Temple floor, closes doors 
.byte $45,$BF ; Closed door (locked) 
.byte $00,$00 ; Grass
.byte $80,$00 ; Sky
.byte $00,$00 ; Temple floor
.byte $00,$00 ; Blank floor
.byte $01,$00 ; In room, Time warp - Warp to previous map
.byte $01,$00 ; Stairs up - Warp to previous map
.byte $02,$31 ; Stairs up - Temple of Fiends 2
.byte $02,$32 ; Stairs up - Temple of Fiends 3
.byte $00,$00 ; blank floor
.byte $00,$00 ; blank floor
.byte $00,$00 ; blank floor
.byte $00,$00 ; blank floor
.byte $00,$00 ; blank floor
.byte $00,$00 ; blank floor
.byte $00,$00 ; blank floor
.byte $02,$39 ; Stairs down - Temple of Fiends 10
.byte $02,$38 ; Stairs down - Temple of Fiends 9
.byte $02,$37 ; Stairs down - Temple of Fiends 8
.byte $02,$30 ; Stairs down - Temple of Fiends 1
.byte $01,$00 ; Stairs down - Warp to previous map
.byte $02,$33 ; Stairs down - Temple of Fiends 4
.byte $02,$34 ; Stairs down - Temple of Fiends 5
.byte $02,$35 ; Stairs down - Temple of Fiends 6
.byte $02,$36 ; Stairs down - Temple of Fiends 7
.byte $00,$00 ; Blank floor
.byte $08,$80 ; In room, Random encounters
.byte $08,$46 ; In room, bottom wall, battle
.byte $08,$73 ; Temple floor, battle
.byte $08,$74 ; Temple floor, battle
.byte $08,$75 ; Temple floor, battle
.byte $08,$76 ; Temple floor, battle
.byte $08,$00 ; Temple floor, battle
.byte $08,$80 ; Temple floor, random encounters
.byte $09,$F8 ; In room, Treasure
.byte $09,$F9 ; In room, Treasure
.byte $09,$FA ; In room, Treasure
.byte $09,$FB ; In room, Treasure
.byte $09,$FC ; In room, Treasure
.byte $09,$FD ; In room, Treasure
.byte $09,$FE ; In room, Treasure
.byte $09,$FF ; In room, Treasure
.byte $00,$00 ; blank floor
.byte $00,$00 ; blank floor
.byte $00,$00 ; blank floor
.byte $00,$00 ; blank floor
.byte $00,$00 ; blank floor
.byte $00,$00 ; blank floor
.byte $00,$00 ; blank floor
.byte $00,$00 ; blank floor
.byte $00,$00 ; blank floor
.byte $00,$00 ; blank floor
.byte $00,$00 ; blank floor
.byte $00,$00 ; blank floor
.byte $00,$00 ; blank floor
.byte $00,$00 ; blank floor
.byte $00,$00 ; blank floor
.byte $00,$00 ; blank floor
.byte $00,$00 ; blank floor
.byte $00,$00 ; blank floor
.byte $00,$00 ; blank floor
.byte $00,$00 ; blank floor
.byte $00,$00 ; blank floor
.byte $00,$00 ; blank floor
.byte $00,$00 ; blank floor
.byte $00,$00 ; blank floor
.byte $00,$00 ; blank floor
.byte $00,$00 ; blank floor
.byte $00,$00 ; blank floor


;; $9000 ;;

;; Map tileset pattern table
; 0x200 bytes per map.
;  First 0x80 are UL tile of each map tile
;  Second 0x80 are UR tile of each map tile
;  Third 0x80 are BL tile of each map tile
;  Fourth 0x80 are BR tile of each map tile
;
; Note, if you plan to use doors tile 0x37 should be an open door, 0x36
; should be a closed normal door, and 0x3b should be a closed key door.

lut_SMTilesetTSA:   
.byte $11,$10,$10,$0C,$0C,$0C,$6F,$0D,$0D,$0D,$6F,$6C,$6C,$0E,$26,$26 ; Town
.byte $0A,$4B,$0A,$0A,$0A,$0A,$09,$03,$13,$47,$55,$2E,$06,$08,$24,$24
.byte $28,$4E,$49,$62,$64,$66,$24,$0F,$4D,$4D,$2C,$68,$3B,$24,$40,$58
.byte $44,$42,$3A,$57,$22,$3B,$24,$20,$0A,$11,$68,$0F,$3A,$57,$24,$24
.byte $24,$24,$24,$24,$24,$24,$24,$11,$60,$24,$24,$24,$24,$24,$24,$24
.byte $24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24
.byte $24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24
.byte $24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$58

.byte $01,$01,$01,$0D,$0D,$0D,$0C,$0C,$6F,$6D,$6C,$6F,$6D,$6D,$27,$27
.byte $0B,$0B,$4C,$0B,$0B,$0B,$0B,$03,$13,$48,$56,$2F,$07,$08,$25,$25
.byte $29,$4F,$4A,$63,$65,$67,$25,$0F,$0F,$0F,$2D,$69,$3B,$25,$41,$78
.byte $44,$43,$3A,$57,$23,$3B,$25,$21,$0B,$01,$69,$0F,$3A,$57,$25,$25
.byte $25,$25,$25,$25,$25,$25,$25,$01,$61,$25,$25,$25,$25,$25,$25,$25
.byte $25,$25,$25,$25,$25,$25,$25,$25,$25,$25,$25,$25,$25,$25,$25,$25
.byte $25,$25,$25,$25,$25,$25,$25,$25,$25,$25,$25,$25,$25,$25,$25,$25
.byte $25,$25,$25,$25,$25,$25,$25,$25,$25,$25,$25,$25,$25,$25,$25,$78

.byte $11,$10,$02,$1C,$0E,$0E,$6F,$0E,$1D,$0E,$6F,$6E,$6E,$6F,$36,$26
.byte $1A,$1A,$1A,$5B,$1A,$09,$12,$13,$13,$45,$1E,$3E,$16,$18,$34,$34
.byte $38,$5E,$59,$72,$74,$2A,$34,$0F,$4D,$5D,$3C,$6A,$3B,$34,$50,$79
.byte $54,$52,$3A,$57,$32,$3B,$34,$30,$1A,$11,$6A,$0F,$3A,$57,$34,$34
.byte $34,$34,$34,$34,$34,$34,$34,$11,$70,$34,$34,$34,$34,$34,$34,$34
.byte $34,$34,$34,$34,$34,$34,$34,$34,$34,$34,$34,$34,$34,$34,$34,$34
.byte $34,$34,$34,$34,$34,$34,$34,$34,$34,$34,$34,$34,$34,$34,$34,$34
.byte $34,$34,$34,$34,$34,$34,$34,$34,$34,$34,$34,$34,$34,$34,$34,$79

.byte $01,$01,$01,$0E,$0E,$1D,$1C,$0E,$6F,$6D,$6E,$6D,$6D,$6F,$37,$27
.byte $1B,$1B,$1B,$1B,$5C,$1B,$1B,$13,$13,$46,$1F,$3F,$17,$18,$35,$35
.byte $39,$5F,$5A,$73,$75,$2B,$35,$0F,$0F,$0F,$3D,$6B,$3B,$35,$51,$19
.byte $54,$53,$3A,$57,$33,$3B,$35,$31,$1B,$01,$6B,$0F,$3A,$57,$35,$35
.byte $35,$35,$35,$35,$35,$35,$35,$01,$71,$35,$35,$35,$35,$35,$35,$35
.byte $35,$35,$35,$35,$35,$35,$35,$35,$35,$35,$35,$35,$35,$35,$35,$35
.byte $35,$35,$35,$35,$35,$35,$35,$35,$35,$35,$35,$35,$35,$35,$35,$35
.byte $35,$35,$35,$35,$35,$35,$35,$35,$35,$35,$35,$35,$35,$35,$35,$19

.byte $03,$05,$05,$07,$09,$09,$07,$09,$09,$00,$2E,$00,$60,$40,$44,$46 ; Castle
.byte $48,$0F,$4A,$4B,$40,$6A,$6C,$6C,$40,$2C,$4E,$0F,$65,$67,$0F,$0F
.byte $0F,$1F,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
.byte $01,$0B,$20,$0D,$42,$4C,$22,$24,$62,$1F,$0B,$22,$61,$1F,$00,$00
.byte $1F,$00,$00,$00,$26,$26,$00,$00,$28,$28,$00,$00,$62,$62,$62,$62
.byte $62,$62,$62,$62,$62,$62,$00,$00,$62,$09,$09,$09,$09,$09,$09,$09
.byte $0B,$65,$65,$2A,$2A,$2A,$2A,$2A,$2A,$2A,$2A,$2A,$2A,$2A,$2A,$2A
.byte $2A,$2A,$2A,$2A,$2A,$2A,$2A,$2A,$2A,$00,$00,$00,$00,$00,$00,$00
.byte $06,$06,$04,$09,$09,$08,$09,$09,$08,$00,$2F,$00,$09,$41,$45,$47
.byte $49,$4A,$0F,$4B,$41,$6B,$6D,$6D,$41,$2D,$4F,$64,$66,$0F,$0F,$0F
.byte $0F,$1F,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
.byte $02,$0C,$21,$0E,$43,$4D,$23,$25,$63,$1F,$0C,$23,$61,$1F,$00,$00
.byte $1F,$00,$00,$00,$27,$27,$00,$00,$29,$29,$00,$00,$63,$63,$63,$63
.byte $63,$63,$63,$63,$63,$63,$00,$00,$63,$09,$09,$09,$09,$09,$09,$09
.byte $0C,$66,$66,$2B,$2B,$2B,$2B,$2B,$2B,$2B,$2B,$2B,$2B,$2B,$2B,$2B
.byte $2B,$2B,$2B,$2B,$2B,$2B,$2B,$2B,$2B,$00,$00,$00,$00,$00,$00,$00
.byte $13,$15,$15,$17,$09,$09,$19,$0A,$0A,$00,$3E,$00,$70,$50,$54,$56
.byte $58,$0F,$5A,$5B,$50,$6C,$6C,$6E,$50,$3C,$5E,$0F,$75,$77,$0F,$69
.byte $79,$1F,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
.byte $11,$1B,$30,$1D,$52,$5C,$32,$34,$72,$1F,$1B,$32,$61,$1F,$00,$00
.byte $1F,$00,$00,$00,$36,$36,$00,$00,$38,$38,$00,$00,$72,$72,$72,$72
.byte $72,$72,$72,$72,$72,$72,$00,$00,$72,$09,$09,$09,$0A,$09,$09,$09
.byte $1B,$75,$75,$3A,$3A,$3A,$3A,$3A,$3A,$3A,$3A,$3A,$3A,$3A,$3A,$3A
.byte $3A,$3A,$3A,$3A,$3A,$3A,$3A,$3A,$3A,$00,$00,$00,$00,$00,$00,$00
.byte $16,$16,$14,$09,$09,$18,$0A,$0A,$1A,$00,$3F,$00,$71,$51,$55,$57
.byte $59,$5A,$0F,$5B,$51,$6D,$6D,$6F,$51,$3D,$5F,$74,$76,$0F,$68,$78
.byte $0F,$1F,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
.byte $12,$1C,$31,$1E,$53,$5D,$33,$35,$73,$1F,$1C,$33,$61,$1F,$00,$00
.byte $1F,$00,$00,$00,$37,$37,$00,$00,$39,$39,$00,$00,$73,$73,$73,$73
.byte $73,$73,$73,$73,$73,$73,$00,$00,$73,$09,$09,$09,$0A,$09,$09,$09
.byte $1C,$76,$76,$3B,$3B,$3B,$3B,$3B,$3B,$3B,$3B,$3B,$3B,$3B,$3B,$3B
.byte $3B,$3B,$3B,$3B,$3B,$3B,$3B,$3B,$3B,$00,$00,$00,$00,$00,$00,$00

.byte $03,$05,$05,$07,$09,$09,$07,$09,$09,$10,$2E,$0B,$60,$4C,$40,$4A ; Cave
.byte $0F,$4F,$62,$42,$44,$26,$26,$40,$26,$26,$00,$0B,$0B,$09,$09,$4A
.byte $0B,$09,$09,$09,$28,$28,$28,$28,$28,$28,$28,$28,$28,$28,$09,$09
.byte $01,$0B,$0D,$0B,$20,$01,$22,$24,$61,$2C,$0B,$22,$66,$68,$46,$48
.byte $09,$0B,$2A,$2A,$2A,$2A,$2A,$2A,$2A,$2A,$2A,$2A,$2A,$2A,$2A,$2A
.byte $2A,$2A,$2A,$2A,$2A,$2A,$2A,$2A,$2A,$2A,$2A,$2A,$2A,$2A,$2A,$2A
.byte $2A,$2A,$2A,$2A,$2A,$2A,$2A,$2A,$2A,$2A,$2A,$2A,$2A,$2A,$2A,$2A
.byte $2A,$2A,$2A,$2A,$2A,$2A,$2A,$2A,$2A,$2A,$2A,$2A,$2A,$2A,$2A,$00
.byte $06,$06,$04,$09,$09,$08,$09,$09,$08,$6A,$2F,$0C,$0F,$4D,$41,$4B
.byte $4E,$0F,$63,$43,$45,$27,$27,$41,$27,$27,$00,$0C,$0C,$09,$09,$4B
.byte $0C,$09,$09,$09,$29,$29,$29,$29,$29,$29,$29,$29,$29,$29,$09,$09
.byte $02,$0C,$0C,$0E,$02,$21,$23,$25,$61,$2D,$0C,$23,$67,$69,$47,$49
.byte $09,$0C,$2B,$2B,$2B,$2B,$2B,$2B,$2B,$2B,$2B,$2B,$2B,$2B,$2B,$2B
.byte $2B,$2B,$2B,$2B,$2B,$2B,$2B,$2B,$2B,$2B,$2B,$2B,$2B,$2B,$2B,$2B
.byte $2B,$2B,$2B,$2B,$2B,$2B,$2B,$2B,$2B,$2B,$2B,$2B,$2B,$2B,$2B,$2B
.byte $2B,$2B,$2B,$2B,$2B,$2B,$2B,$2B,$2B,$2B,$2B,$2B,$2B,$2B,$2B,$00
.byte $13,$15,$15,$17,$09,$09,$19,$0A,$0A,$10,$3E,$1B,$70,$5C,$50,$5A
.byte $0F,$5F,$64,$52,$54,$36,$36,$50,$36,$36,$00,$1B,$1B,$09,$09,$5A
.byte $1B,$09,$09,$09,$38,$38,$38,$38,$38,$38,$38,$38,$38,$38,$09,$09
.byte $11,$1B,$1D,$1B,$30,$11,$32,$34,$61,$3C,$1B,$32,$76,$78,$56,$58
.byte $09,$1B,$3A,$3A,$3A,$3A,$3A,$3A,$3A,$3A,$3A,$3A,$3A,$3A,$3A,$3A
.byte $3A,$3A,$3A,$3A,$3A,$3A,$3A,$3A,$3A,$3A,$3A,$3A,$3A,$3A,$3A,$3A
.byte $3A,$3A,$3A,$3A,$3A,$3A,$3A,$3A,$3A,$3A,$3A,$3A,$3A,$3A,$3A,$3A
.byte $3A,$3A,$3A,$3A,$3A,$3A,$3A,$3A,$3A,$3A,$3A,$3A,$3A,$3A,$3A,$00
.byte $16,$16,$14,$09,$09,$18,$0A,$0A,$1A,$6A,$3F,$1C,$71,$5D,$51,$5B
.byte $5E,$0F,$65,$53,$55,$37,$37,$51,$37,$37,$00,$1C,$1C,$09,$09,$5B
.byte $1C,$09,$09,$09,$39,$39,$39,$39,$39,$39,$39,$39,$39,$39,$09,$09
.byte $12,$1C,$1C,$1E,$12,$31,$33,$35,$61,$3D,$1C,$33,$77,$79,$57,$59
.byte $09,$1C,$3B,$3B,$3B,$3B,$3B,$3B,$3B,$3B,$3B,$3B,$3B,$3B,$3B,$3B
.byte $3B,$3B,$3B,$3B,$3B,$3B,$3B,$3B,$3B,$3B,$3B,$3B,$3B,$3B,$3B,$3B
.byte $3B,$3B,$3B,$3B,$3B,$3B,$3B,$3B,$3B,$3B,$3B,$3B,$3B,$3B,$3B,$3B
.byte $3B,$3B,$3B,$3B,$3B,$3B,$3B,$3B,$3B,$3B,$3B,$3B,$3B,$3B,$3B,$00

.byte $03,$05,$05,$07,$09,$09,$07,$09,$09,$00,$2E,$00,$60,$40,$42,$44 ; Safe Cave 
.byte $46,$48,$2C,$4A,$62,$64,$6A,$0F,$26,$26,$26,$26,$00,$00,$00,$00
.byte $00,$00,$00,$00,$00,$00,$00,$00,$28,$28,$28,$28,$28,$4C,$4C,$00
.byte $01,$0B,$0D,$0B,$20,$01,$22,$24,$66,$68,$0B,$22,$61,$4E,$00,$00
.byte $09,$09,$09,$09,$09,$09,$09,$09,$09,$0B,$00,$2A,$2A,$2A,$2A,$2A
.byte $2A,$2A,$2A,$2A,$2A,$2A,$2A,$2A,$2A,$2A,$2A,$2A,$2A,$2A,$2A,$2A
.byte $2A,$2A,$2A,$2A,$2A,$2A,$2A,$2A,$2A,$2A,$2A,$2A,$2A,$2A,$2A,$2A
.byte $2A,$2A,$2A,$2A,$2A,$2A,$2A,$2A,$2A,$2A,$2A,$2A,$2A,$2A,$2A,$00
.byte $06,$06,$04,$09,$09,$08,$09,$09,$08,$00,$2F,$00,$0F,$41,$43,$45
.byte $47,$49,$2D,$4B,$63,$65,$6B,$0F,$27,$27,$27,$27,$00,$00,$00,$00
.byte $00,$00,$00,$00,$00,$00,$00,$00,$29,$29,$29,$29,$29,$4D,$4D,$00
.byte $02,$0C,$0C,$0E,$02,$21,$23,$25,$67,$69,$0C,$23,$61,$4F,$00,$00
.byte $09,$09,$09,$09,$09,$09,$09,$09,$09,$0C,$00,$2B,$2B,$2B,$2B,$2B
.byte $2B,$2B,$2B,$2B,$2B,$2B,$2B,$2B,$2B,$2B,$2B,$2B,$2B,$2B,$2B,$2B
.byte $2B,$2B,$2B,$2B,$2B,$2B,$2B,$2B,$2B,$2B,$2B,$2B,$2B,$2B,$2B,$2B
.byte $2B,$2B,$2B,$2B,$2B,$2B,$2B,$2B,$2B,$2B,$2B,$2B,$2B,$2B,$2B,$00
.byte $13,$15,$15,$17,$09,$09,$19,$0A,$0A,$00,$3E,$00,$70,$50,$52,$54
.byte $56,$58,$3C,$5A,$72,$74,$6C,$6E,$36,$36,$36,$36,$00,$00,$00,$00
.byte $00,$00,$00,$00,$00,$00,$00,$00,$38,$38,$38,$38,$38,$5C,$5C,$00
.byte $11,$1B,$1D,$1B,$30,$11,$32,$34,$76,$78,$1B,$32,$61,$5E,$00,$00
.byte $0A,$09,$09,$09,$0A,$09,$09,$09,$0A,$1B,$00,$3A,$3A,$3A,$3A,$3A
.byte $3A,$3A,$3A,$3A,$3A,$3A,$3A,$3A,$3A,$3A,$3A,$3A,$3A,$3A,$3A,$3A
.byte $3A,$3A,$3A,$3A,$3A,$3A,$3A,$3A,$3A,$3A,$3A,$3A,$3A,$3A,$3A,$3A
.byte $3A,$3A,$3A,$3A,$3A,$3A,$3A,$3A,$3A,$3A,$3A,$3A,$3A,$3A,$3A,$00
.byte $16,$16,$14,$09,$09,$18,$0A,$0A,$1A,$00,$3F,$00,$71,$51,$53,$55
.byte $57,$59,$3D,$5B,$73,$75,$6D,$6F,$37,$37,$37,$37,$00,$00,$00,$00
.byte $00,$00,$00,$00,$00,$00,$00,$00,$39,$39,$39,$39,$39,$5D,$5D,$00
.byte $12,$1C,$1C,$1E,$12,$31,$33,$35,$77,$79,$1C,$33,$61,$5F,$00,$00
.byte $0A,$09,$09,$09,$0A,$09,$09,$09,$0A,$1C,$00,$3B,$3B,$3B,$3B,$3B
.byte $3B,$3B,$3B,$3B,$3B,$3B,$3B,$3B,$3B,$3B,$3B,$3B,$3B,$3B,$3B,$3B
.byte $3B,$3B,$3B,$3B,$3B,$3B,$3B,$3B,$3B,$3B,$3B,$3B,$3B,$3B,$3B,$3B
.byte $3B,$3B,$3B,$3B,$3B,$3B,$3B,$3B,$3B,$3B,$3B,$3B,$3B,$3B,$3B,$00

.byte $03,$05,$05,$07,$09,$09,$07,$09,$09,$10,$2E,$00,$60,$4E,$4A,$48 ; Tower
.byte $62,$64,$4C,$6A,$6C,$00,$46,$44,$42,$09,$09,$09,$09,$09,$00,$00
.byte $28,$28,$28,$28,$00,$00,$26,$26,$26,$00,$00,$00,$2C,$09,$09,$09
.byte $01,$0B,$0D,$0B,$20,$01,$22,$24,$66,$68,$0B,$22,$40,$00,$00,$00
.byte $0B,$2A,$2A,$2A,$2A,$2A,$2A,$2A,$2A,$2A,$2A,$2A,$2A,$2A,$2A,$2A
.byte $2A,$2A,$2A,$2A,$2A,$2A,$2A,$2A,$2A,$2A,$2A,$2A,$2A,$2A,$2A,$2A
.byte $2A,$2A,$2A,$2A,$2A,$2A,$2A,$2A,$00,$00,$00,$00,$00,$00,$00,$00
.byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
.byte $06,$06,$04,$09,$09,$08,$09,$09,$08,$61,$2F,$00,$0F,$4F,$4B,$49
.byte $63,$65,$4D,$6B,$6A,$00,$47,$45,$43,$09,$09,$09,$09,$09,$00,$00
.byte $29,$29,$29,$29,$00,$00,$27,$27,$27,$00,$00,$00,$2D,$09,$09,$09
.byte $02,$0C,$0C,$0E,$02,$21,$23,$25,$67,$69,$0C,$23,$41,$00,$00,$00
.byte $0C,$2B,$2B,$2B,$2B,$2B,$2B,$2B,$2B,$2B,$2B,$2B,$2B,$2B,$2B,$2B
.byte $2B,$2B,$2B,$2B,$2B,$2B,$2B,$2B,$2B,$2B,$2B,$2B,$2B,$2B,$2B,$2B
.byte $2B,$2B,$2B,$2B,$2B,$2B,$2B,$2B,$00,$00,$00,$00,$00,$00,$00,$00
.byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
.byte $13,$15,$15,$17,$09,$09,$19,$0A,$0A,$10,$3E,$00,$70,$5E,$5A,$58
.byte $72,$74,$5C,$6D,$6F,$00,$56,$54,$52,$09,$09,$09,$0A,$09,$00,$00
.byte $38,$38,$38,$38,$00,$00,$36,$36,$36,$00,$00,$00,$3C,$09,$09,$09
.byte $11,$1B,$1D,$1B,$30,$11,$32,$34,$76,$78,$1B,$32,$50,$00,$00,$00
.byte $1B,$3A,$3A,$3A,$3A,$3A,$3A,$3A,$3A,$3A,$3A,$3A,$3A,$3A,$3A,$3A
.byte $3A,$3A,$3A,$3A,$3A,$3A,$3A,$3A,$3A,$3A,$3A,$3A,$3A,$3A,$3A,$3A
.byte $3A,$3A,$3A,$3A,$3A,$3A,$3A,$3A,$00,$00,$00,$00,$00,$00,$00,$00
.byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
.byte $16,$16,$14,$09,$09,$18,$0A,$0A,$1A,$61,$3F,$00,$71,$5F,$5B,$59
.byte $73,$75,$5D,$6E,$6D,$00,$57,$55,$53,$09,$09,$09,$0A,$09,$00,$00
.byte $39,$39,$39,$39,$00,$00,$37,$37,$37,$00,$00,$00,$3D,$09,$09,$09
.byte $12,$1C,$1C,$1E,$12,$31,$33,$35,$77,$79,$1C,$33,$51,$00,$00,$00
.byte $1C,$3B,$3B,$3B,$3B,$3B,$3B,$3B,$3B,$3B,$3B,$3B,$3B,$3B,$3B,$3B
.byte $3B,$3B,$3B,$3B,$3B,$3B,$3B,$3B,$3B,$3B,$3B,$3B,$3B,$3B,$3B,$3B
.byte $3B,$3B,$3B,$3B,$3B,$3B,$3B,$3B,$00,$00,$00,$00,$00,$00,$00,$00
.byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00

.byte $03,$05,$05,$07,$09,$09,$07,$09,$09,$00,$2E,$00,$60,$40,$00,$44 ; Shrine 
.byte $46,$2C,$0F,$4C,$4B,$4E,$62,$64,$00,$00,$00,$00,$00,$00,$00,$00
.byte $09,$09,$09,$09,$09,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
.byte $01,$0B,$0D,$0B,$20,$01,$22,$24,$6A,$00,$0B,$22,$68,$66,$00,$00
.byte $42,$48,$26,$26,$26,$26,$26,$00,$00,$00,$00,$28,$28,$28,$28,$28
.byte $00,$00,$00,$09,$09,$0B,$2A,$2A,$2A,$2A,$2A,$2A,$2A,$2A,$2A,$2A
.byte $2A,$2A,$2A,$2A,$2A,$2A,$2A,$2A,$2A,$2A,$2A,$2A,$2A,$2A,$2A,$2A
.byte $2A,$2A,$2A,$2A,$2A,$2A,$2A,$2A,$2A,$2A,$2A,$2A,$00,$00,$00,$00
.byte $06,$06,$04,$09,$09,$08,$09,$09,$08,$00,$2F,$00,$09,$41,$00,$45
.byte $47,$2D,$4A,$4D,$0F,$4F,$63,$65,$00,$00,$00,$00,$00,$00,$00,$00
.byte $09,$09,$09,$09,$09,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
.byte $02,$0C,$0C,$0E,$02,$21,$23,$25,$6B,$00,$0C,$23,$69,$67,$00,$00
.byte $43,$49,$27,$27,$27,$27,$27,$00,$00,$00,$00,$29,$29,$29,$29,$29
.byte $00,$00,$00,$09,$09,$0C,$2B,$2B,$2B,$2B,$2B,$2B,$2B,$2B,$2B,$2B
.byte $2B,$2B,$2B,$2B,$2B,$2B,$2B,$2B,$2B,$2B,$2B,$2B,$2B,$2B,$2B,$2B
.byte $2B,$2B,$2B,$2B,$2B,$2B,$2B,$2B,$2B,$2B,$2B,$2B,$00,$00,$00,$00
.byte $13,$15,$15,$17,$09,$09,$19,$0A,$0A,$00,$3E,$00,$70,$50,$00,$54
.byte $56,$3C,$0F,$5C,$5B,$5E,$72,$74,$00,$00,$00,$00,$00,$00,$00,$00
.byte $0A,$09,$09,$09,$09,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
.byte $11,$1B,$1D,$1B,$30,$11,$32,$34,$6C,$00,$1B,$32,$78,$76,$00,$00
.byte $52,$58,$36,$36,$36,$36,$36,$00,$00,$00,$00,$38,$38,$38,$38,$38
.byte $00,$00,$00,$09,$09,$1B,$3A,$3A,$3A,$3A,$3A,$3A,$3A,$3A,$3A,$3A
.byte $3A,$3A,$3A,$3A,$3A,$3A,$3A,$3A,$3A,$3A,$3A,$3A,$3A,$3A,$3A,$3A
.byte $3A,$3A,$3A,$3A,$3A,$3A,$3A,$3A,$3A,$3A,$3A,$3A,$00,$00,$00,$00
.byte $16,$16,$14,$09,$09,$18,$0A,$0A,$1A,$00,$3F,$00,$71,$51,$00,$55
.byte $57,$3D,$5A,$5D,$0F,$5F,$73,$75,$00,$00,$00,$00,$00,$00,$00,$00
.byte $0A,$09,$09,$09,$09,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
.byte $12,$1C,$1C,$1E,$12,$31,$33,$35,$6D,$00,$1C,$33,$79,$77,$00,$00
.byte $53,$59,$37,$37,$37,$37,$37,$00,$00,$00,$00,$39,$39,$39,$39,$39
.byte $00,$00,$00,$09,$09,$1C,$3B,$3B,$3B,$3B,$3B,$3B,$3B,$3B,$3B,$3B
.byte $3B,$3B,$3B,$3B,$3B,$3B,$3B,$3B,$3B,$3B,$3B,$3B,$3B,$3B,$3B,$3B
.byte $3B,$3B,$3B,$3B,$3B,$3B,$3B,$3B,$3B,$3B,$3B,$3B,$00,$00,$00,$00

.byte $03,$05,$05,$07,$09,$09,$07,$09,$09,$00,$28,$60,$10,$2E,$2D,$4E ; Sky Palace
.byte $40,$42,$44,$6A,$6B,$46,$48,$4A,$4C,$68,$00,$00,$00,$00,$00,$00
.byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
.byte $01,$0B,$0D,$0B,$20,$01,$22,$24,$66,$68,$0B,$22,$00,$00,$00,$00
.byte $64,$26,$26,$26,$26,$62,$00,$00,$00,$09,$09,$0B,$2A,$2A,$2A,$2A
.byte $2A,$2A,$2A,$2A,$2A,$2A,$2A,$2A,$2A,$2A,$2A,$2A,$2A,$2A,$2A,$2A
.byte $2A,$2A,$2A,$2A,$2A,$2A,$2A,$2A,$2A,$2A,$2A,$2A,$2A,$2A,$00,$00
.byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
.byte $06,$06,$04,$09,$09,$08,$09,$09,$08,$00,$29,$61,$2C,$2F,$10,$4F
.byte $41,$43,$45,$6A,$6C,$47,$49,$4B,$4D,$69,$00,$00,$00,$00,$00,$00
.byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
.byte $02,$0C,$0C,$0E,$02,$21,$23,$25,$67,$69,$0C,$23,$00,$00,$00,$00
.byte $65,$27,$27,$27,$27,$63,$00,$00,$00,$09,$09,$0C,$2B,$2B,$2B,$2B
.byte $2B,$2B,$2B,$2B,$2B,$2B,$2B,$2B,$2B,$2B,$2B,$2B,$2B,$2B,$2B,$2B
.byte $2B,$2B,$2B,$2B,$2B,$2B,$2B,$2B,$2B,$2B,$2B,$2B,$2B,$2B,$00,$00
.byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
.byte $13,$15,$15,$17,$09,$09,$19,$0A,$0A,$00,$38,$70,$10,$3E,$3D,$5E
.byte $50,$52,$54,$6D,$6E,$56,$58,$5A,$5C,$78,$00,$00,$00,$00,$00,$00
.byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
.byte $11,$1B,$1D,$1B,$30,$11,$32,$34,$76,$78,$1B,$32,$00,$00,$00,$00
.byte $74,$36,$36,$36,$36,$72,$00,$00,$00,$09,$09,$1B,$3A,$3A,$3A,$3A
.byte $3A,$3A,$3A,$3A,$3A,$3A,$3A,$3A,$3A,$3A,$3A,$3A,$3A,$3A,$3A,$3A
.byte $3A,$3A,$3A,$3A,$3A,$3A,$3A,$3A,$3A,$3A,$3A,$3A,$3A,$3A,$00,$00
.byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
.byte $16,$16,$14,$09,$09,$18,$0A,$0A,$1A,$00,$39,$71,$3C,$3F,$10,$5F
.byte $51,$53,$55,$6D,$6F,$57,$59,$5B,$5D,$79,$00,$00,$00,$00,$00,$00
.byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
.byte $12,$1C,$1C,$1E,$12,$31,$33,$35,$77,$79,$1C,$33,$00,$00,$00,$00
.byte $75,$37,$37,$37,$37,$73,$00,$00,$00,$09,$09,$1C,$3B,$3B,$3B,$3B
.byte $3B,$3B,$3B,$3B,$3B,$3B,$3B,$3B,$3B,$3B,$3B,$3B,$3B,$3B,$3B,$3B
.byte $3B,$3B,$3B,$3B,$3B,$3B,$3B,$3B,$3B,$3B,$3B,$3B,$3B,$3B,$00,$00
.byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00

.byte $03,$05,$05,$07,$09,$09,$07,$09,$09,$10,$2E,$00,$60,$40,$00,$44 ; Temple
.byte $46,$2C,$0F,$4C,$4B,$62,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
.byte $09,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$60,$64,$66,$68
.byte $01,$0B,$0D,$0B,$20,$01,$22,$24,$6A,$48,$0B,$22,$1F,$61,$0B,$00
.byte $42,$26,$26,$26,$00,$00,$00,$00,$00,$00,$00,$28,$28,$28,$28,$28
.byte $28,$28,$28,$28,$00,$09,$09,$0B,$0B,$0B,$0B,$0B,$0B,$2A,$2A,$2A
.byte $2A,$2A,$2A,$2A,$2A,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
.byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
.byte $06,$06,$04,$09,$09,$08,$09,$09,$08,$6E,$2F,$00,$09,$41,$00,$45
.byte $47,$2D,$4A,$4D,$0F,$63,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
.byte $09,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$6F,$65,$67,$69
.byte $02,$0C,$0C,$0E,$02,$21,$23,$25,$6B,$49,$0C,$23,$1F,$61,$0C,$00
.byte $43,$27,$27,$27,$00,$00,$00,$00,$00,$00,$00,$29,$29,$29,$29,$29
.byte $29,$29,$29,$29,$00,$09,$09,$0C,$0C,$0C,$0C,$0C,$0C,$2B,$2B,$2B
.byte $2B,$2B,$2B,$2B,$2B,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
.byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
.byte $13,$15,$15,$17,$09,$09,$19,$0A,$0A,$10,$3E,$00,$70,$50,$00,$54
.byte $56,$3C,$0F,$5C,$5B,$72,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
.byte $09,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$70,$74,$76,$78
.byte $11,$1B,$1D,$1B,$30,$11,$32,$34,$6C,$58,$1B,$32,$1F,$61,$1B,$00
.byte $52,$36,$36,$36,$00,$00,$00,$00,$00,$00,$00,$38,$38,$38,$38,$38
.byte $38,$38,$38,$38,$00,$09,$0A,$1B,$1B,$1B,$1B,$1B,$1B,$3A,$3A,$3A
.byte $3A,$3A,$3A,$3A,$3A,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
.byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
.byte $16,$16,$14,$09,$09,$18,$0A,$0A,$1A,$6E,$3F,$00,$71,$51,$00,$55
.byte $57,$3D,$5A,$5D,$0F,$73,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
.byte $09,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$71,$75,$77,$79
.byte $12,$1C,$1C,$1E,$12,$31,$33,$35,$6D,$59,$1C,$33,$1F,$61,$1C,$00
.byte $53,$37,$37,$37,$00,$00,$00,$00,$00,$00,$00,$39,$39,$39,$39,$39
.byte $39,$39,$39,$39,$00,$09,$0A,$1C,$1C,$1C,$1C,$1C,$1C,$3B,$3B,$3B
.byte $3B,$3B,$3B,$3B,$3B,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
.byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00



;; $A000 ;; - $1000 byte bound
;; MAP PALETTES
; First row has the 4 'normal' palettes (?)
; Second row has two Control palettes and two Sprite palettes
; Third row has the 4 'room' palettes (?)

lut_SMPalettes:
.byte $0F,$1A,$28,$18,$0F,$00,$1A,$10,$0F,$30,$2C,$1C,$0F,$00,$01,$30 ; 00 ; Coneria
.byte $0F,$0F,$12,$36,$0F,$0F,$27,$36,$0F,$0F,$27,$36,$0F,$0F,$16,$36 
.byte $0F,$1A,$28,$18,$0F,$00,$1A,$10,$0F,$30,$2C,$1C,$0F,$00,$01,$30 

.byte $0F,$1A,$28,$18,$0F,$00,$1A,$10,$0F,$30,$2C,$1C,$0F,$00,$01,$30 ; 01 ; Pravoka
.byte $0F,$0F,$12,$36,$0F,$0F,$27,$36,$0F,$0F,$12,$36,$0F,$0F,$21,$36 
.byte $0F,$1A,$28,$18,$0F,$00,$1A,$10,$0F,$30,$2C,$1C,$0F,$00,$01,$30 

.byte $0F,$1A,$28,$18,$0F,$00,$1A,$10,$0F,$30,$2C,$1C,$0F,$00,$01,$30 ; 02 ; Elfland
.byte $0F,$0F,$12,$36,$0F,$0F,$27,$36,$0F,$0F,$27,$36,$0F,$0F,$2A,$36 
.byte $0F,$1A,$28,$18,$0F,$00,$1A,$10,$0F,$30,$2C,$1C,$0F,$00,$01,$30 

.byte $0F,$1A,$28,$18,$0F,$00,$1A,$10,$0F,$30,$2C,$1C,$0F,$00,$01,$30 ; 03 ; Melmond
.byte $0F,$0F,$12,$36,$0F,$0F,$27,$36,$0F,$0F,$17,$36,$0F,$0F,$27,$36 
.byte $0F,$1A,$28,$18,$0F,$00,$1A,$10,$0F,$30,$2C,$1C,$0F,$00,$01,$30 

.byte $0F,$1A,$28,$18,$0F,$00,$1A,$10,$0F,$30,$2C,$1C,$0F,$00,$01,$30 ; 04 ; Crescent Lake
.byte $0F,$0F,$12,$36,$0F,$0F,$27,$36,$0F,$0F,$25,$36,$0F,$0F,$15,$36 
.byte $0F,$1A,$28,$18,$0F,$00,$1A,$10,$0F,$30,$2C,$1C,$0F,$00,$01,$30 

.byte $0F,$1A,$28,$18,$0F,$00,$1A,$10,$0F,$30,$2C,$1C,$0F,$00,$01,$30 ; 05 ; Gaia
.byte $0F,$0F,$12,$36,$0F,$0F,$27,$36,$0F,$0F,$27,$36,$0F,$0F,$25,$36 
.byte $0F,$1A,$28,$18,$0F,$00,$1A,$10,$0F,$30,$2C,$1C,$0F,$00,$01,$30 

.byte $0F,$1A,$28,$18,$0F,$00,$1A,$10,$0F,$30,$2C,$1C,$0F,$00,$01,$30 ; 06 ; Onrac
.byte $0F,$0F,$12,$36,$0F,$0F,$27,$36,$0F,$0F,$16,$36,$0F,$0F,$12,$36 
.byte $0F,$1A,$28,$18,$0F,$00,$1A,$10,$0F,$30,$2C,$1C,$0F,$00,$01,$30 

.byte $0F,$1A,$28,$18,$0F,$00,$1A,$10,$0F,$30,$2C,$1C,$0F,$00,$01,$30 ; 07 ; Leifen
.byte $0F,$0F,$12,$36,$0F,$0F,$27,$36,$0F,$0F,$14,$36,$0F,$0F,$30,$36 
.byte $0F,$1A,$28,$18,$0F,$00,$1A,$10,$0F,$30,$2C,$1C,$0F,$00,$01,$30 

.byte $0F,$30,$30,$30,$0F,$30,$30,$10,$0F,$12,$1A,$19,$0F,$00,$01,$30 ; 08 ; Coneria Castle 1F
.byte $0F,$0F,$12,$36,$0F,$0F,$27,$36,$0F,$0F,$27,$36,$0F,$0F,$16,$36 
.byte $0F,$27,$17,$0F,$0F,$0F,$00,$10,$0F,$12,$1A,$19,$0F,$00,$01,$30 

.byte $0F,$30,$30,$30,$0F,$30,$30,$10,$0F,$12,$1A,$19,$0F,$00,$01,$30 ; 09 ; Elfland Castle
.byte $0F,$0F,$12,$36,$0F,$0F,$27,$36,$0F,$0F,$27,$36,$0F,$0F,$2A,$36 
.byte $0F,$27,$17,$0F,$0F,$0F,$00,$10,$0F,$12,$1A,$19,$0F,$00,$01,$30 

.byte $0F,$30,$30,$30,$0F,$30,$30,$10,$0F,$12,$1A,$19,$0F,$00,$01,$30 ; 0A ; Northwest Castle
.byte $0F,$0F,$12,$36,$0F,$0F,$27,$36,$0F,$0F,$1B,$36,$0F,$0F,$14,$36 
.byte $0F,$27,$17,$0F,$0F,$0F,$00,$10,$0F,$12,$1A,$19,$0F,$00,$01,$30 

.byte $0F,$30,$30,$30,$0F,$30,$30,$10,$0F,$12,$1A,$19,$0F,$00,$01,$30 ; 0B ; Castle of Ordeals 1F
.byte $0F,$0F,$12,$36,$0F,$0F,$27,$36,$0F,$0F,$16,$36,$0F,$0F,$27,$36 
.byte $0F,$27,$17,$0F,$0F,$0F,$00,$10,$0F,$12,$1A,$19,$0F,$00,$01,$30 

.byte $0F,$30,$30,$30,$0F,$30,$30,$10,$0F,$00,$10,$30,$0F,$00,$01,$30 ; 0C ; Temple of Fiends
.byte $0F,$0F,$12,$36,$0F,$0F,$27,$36,$0F,$01,$27,$36,$0F,$01,$14,$36 
.byte $0F,$10,$17,$0F,$0F,$0F,$00,$00,$0F,$0F,$00,$30,$0F,$00,$01,$30 

.byte $0F,$37,$37,$37,$0F,$37,$37,$27,$0F,$17,$27,$37,$0F,$00,$01,$30 ; 0D ; Earth Cave B1
.byte $0F,$0F,$12,$36,$0F,$0F,$27,$36,$0F,$0F,$30,$16,$0F,$0F,$14,$16 
.byte $0F,$10,$17,$0F,$0F,$0F,$07,$17,$0F,$07,$17,$27,$0F,$00,$01,$30 

.byte $0F,$36,$36,$36,$0F,$36,$36,$26,$0F,$16,$26,$36,$0F,$00,$01,$30 ; 0E ; Gurgu Volcano B1
.byte $0F,$0F,$12,$36,$0F,$0F,$27,$36,$0F,$00,$00,$00,$0F,$00,$00,$00 
.byte $0F,$10,$17,$0F,$0F,$0F,$06,$16,$0F,$06,$16,$26,$0F,$00,$01,$30 

.byte $0F,$31,$31,$31,$0F,$31,$31,$10,$0F,$00,$10,$31,$0F,$00,$01,$30 ; 0F ; Ice Cave B1
.byte $0F,$0F,$12,$36,$0F,$0F,$27,$36,$0F,$00,$00,$00,$0F,$00,$00,$00 
.byte $0F,$10,$17,$0F,$0F,$0F,$00,$00,$0F,$0F,$00,$31,$0F,$00,$01,$30 

.byte $0F,$3C,$3C,$3C,$0F,$3C,$3C,$2C,$0F,$1C,$2C,$3C,$0F,$00,$01,$30 ; 10 ; Cardia
.byte $0F,$0F,$12,$36,$0F,$0F,$27,$36,$0F,$0F,$17,$28,$0F,$0F,$18,$28 
.byte $0F,$10,$17,$0F,$0F,$0F,$0C,$1C,$0F,$0C,$1C,$2C,$0F,$00,$01,$30 

.byte $0F,$3C,$3C,$3C,$0F,$3C,$3C,$2C,$0F,$1C,$2C,$3C,$0F,$00,$01,$30 ; 11 ; Bahamut's Room B1
.byte $0F,$0F,$12,$36,$0F,$0F,$27,$36,$0F,$0F,$17,$28,$0F,$0F,$18,$28 
.byte $0F,$10,$17,$0F,$0F,$0F,$0C,$1C,$0F,$0C,$1C,$2C,$0F,$00,$01,$30 

.byte $0F,$2C,$2C,$2C,$0F,$2C,$2C,$1C,$0F,$0C,$1C,$2C,$0F,$00,$01,$30 ; 12 ; Waterfall
.byte $0F,$0F,$12,$36,$0F,$0F,$27,$36,$0F,$0F,$18,$15,$0F,$0F,$17,$15 
.byte $0F,$10,$17,$0F,$0F,$0F,$0C,$0C,$0F,$0F,$0C,$1C,$0F,$00,$01,$30 

.byte $0F,$27,$27,$27,$0F,$27,$27,$17,$0F,$07,$17,$27,$0F,$00,$01,$30 ; 13 ; Dwarf Cave
.byte $0F,$0F,$12,$36,$0F,$0F,$27,$36,$0F,$0F,$27,$36,$0F,$0F,$1A,$36 
.byte $0F,$10,$17,$0F,$0F,$0F,$07,$07,$0F,$0F,$07,$17,$0F,$00,$01,$30 

.byte $0F,$23,$23,$23,$0F,$23,$23,$13,$0F,$03,$13,$23,$0F,$00,$01,$30 ; 14 ; Matoya's Cave
.byte $0F,$0F,$12,$36,$0F,$0F,$27,$36,$0F,$0F,$14,$36,$0F,$0F,$06,$36 
.byte $0F,$10,$17,$0F,$0F,$0F,$03,$03,$0F,$0F,$03,$13,$0F,$00,$01,$30 

.byte $0F,$28,$28,$28,$0F,$28,$28,$18,$0F,$08,$18,$28,$0F,$00,$01,$30 ; 15 ; Sarda's Cave
.byte $0F,$0F,$12,$36,$0F,$0F,$27,$36,$0F,$0F,$1C,$36,$0F,$0F,$2B,$36 
.byte $0F,$10,$17,$0F,$0F,$0F,$08,$08,$0F,$0F,$08,$18,$0F,$00,$01,$30 

.byte $0F,$3B,$3B,$3B,$0F,$3B,$3B,$2B,$0F,$1B,$2B,$3B,$0F,$00,$01,$30 ; 16 ; Marsh Cave B1
.byte $0F,$0F,$12,$36,$0F,$0F,$27,$36,$0F,$0F,$27,$15,$0F,$0F,$14,$15 
.byte $0F,$10,$00,$0F,$0F,$0F,$0B,$1B,$0F,$0B,$1B,$2B,$0F,$00,$01,$30 

.byte $0F,$27,$27,$27,$0F,$27,$27,$17,$0F,$07,$17,$27,$0F,$00,$01,$30 ; 17 ; Mirage Tower 1F
.byte $0F,$0F,$12,$36,$0F,$0F,$27,$36,$0F,$0F,$10,$15,$0F,$0F,$22,$15 
.byte $0F,$10,$00,$0F,$0F,$0F,$07,$07,$0F,$0F,$07,$17,$0F,$00,$01,$30 

.byte $0F,$30,$30,$30,$0F,$30,$30,$10,$0F,$12,$1A,$19,$0F,$00,$01,$30 ; 18 ; Coneria Castle 2F
.byte $0F,$0F,$12,$36,$0F,$0F,$27,$36,$0F,$0F,$27,$36,$0F,$0F,$16,$36 
.byte $0F,$27,$17,$0F,$0F,$0F,$00,$10,$0F,$12,$1A,$19,$0F,$00,$01,$30 

.byte $0F,$30,$30,$30,$0F,$30,$30,$10,$0F,$12,$1A,$19,$0F,$00,$01,$30 ; 19 ; Castle of Ordeals 2F
.byte $0F,$0F,$12,$36,$0F,$0F,$27,$36,$0F,$00,$00,$00,$0F,$00,$00,$00 
.byte $0F,$27,$17,$0F,$0F,$0F,$00,$10,$0F,$12,$1A,$19,$0F,$00,$01,$30 

.byte $0F,$30,$30,$30,$0F,$30,$30,$10,$0F,$12,$1A,$19,$0F,$00,$01,$30 ; 1A ; Castle of Ordeals 3F
.byte $0F,$0F,$12,$36,$0F,$0F,$27,$36,$0F,$00,$00,$00,$0F,$00,$00,$00 
.byte $0F,$27,$17,$0F,$0F,$0F,$00,$10,$0F,$12,$1A,$19,$0F,$00,$01,$30 

.byte $0F,$3B,$3B,$3B,$0F,$3B,$3B,$2B,$0F,$1B,$2B,$3B,$0F,$00,$01,$30 ; 1B ; Marsh Cave B2
.byte $0F,$0F,$12,$36,$0F,$0F,$27,$36,$0F,$0F,$27,$15,$0F,$0F,$14,$15 
.byte $0F,$10,$00,$0F,$0F,$0F,$0B,$1B,$0F,$0B,$1B,$2B,$0F,$00,$01,$30 

.byte $0F,$2B,$2B,$2B,$0F,$2B,$2B,$1B,$0F,$0B,$1B,$2B,$0F,$00,$01,$30 ; 1C ; Marsh Cave B3
.byte $0F,$0F,$12,$36,$0F,$0F,$27,$36,$0F,$0F,$37,$24,$0F,$0F,$14,$24 
.byte $0F,$10,$00,$0F,$0F,$0F,$0B,$0B,$0F,$0F,$0B,$1B,$0F,$00,$01,$30 

.byte $0F,$37,$37,$37,$0F,$37,$37,$27,$0F,$17,$27,$37,$0F,$00,$01,$30 ; 1D ; Earth Cave B2
.byte $0F,$0F,$12,$36,$0F,$0F,$27,$36,$0F,$0F,$30,$16,$0F,$0F,$14,$16 
.byte $0F,$10,$17,$0F,$0F,$0F,$07,$17,$0F,$07,$17,$27,$0F,$00,$01,$30 

.byte $0F,$37,$37,$37,$0F,$37,$37,$27,$0F,$17,$27,$37,$0F,$00,$01,$30 ; 1E ; Earth Cave B3
.byte $0F,$0F,$12,$36,$0F,$0F,$27,$36,$0F,$16,$07,$36,$0F,$07,$23,$36 
.byte $0F,$10,$17,$0F,$0F,$0F,$07,$17,$0F,$07,$17,$27,$0F,$00,$01,$30 

.byte $0F,$27,$27,$27,$0F,$27,$27,$17,$0F,$07,$17,$27,$0F,$00,$01,$30 ; 1F ; Earth Cave B4
.byte $0F,$0F,$12,$36,$0F,$0F,$27,$36,$0F,$0F,$27,$23,$0F,$0F,$14,$23 
.byte $0F,$10,$17,$0F,$0F,$0F,$07,$07,$0F,$0F,$07,$17,$0F,$00,$01,$30 

.byte $0F,$27,$27,$27,$0F,$27,$27,$17,$0F,$07,$17,$27,$0F,$00,$01,$30 ; 20 ; Earth Cave B5
.byte $0F,$0F,$12,$36,$0F,$0F,$27,$36,$0F,$16,$27,$37,$0F,$16,$27,$37 
.byte $0F,$10,$17,$0F,$0F,$0F,$07,$07,$0F,$0F,$07,$17,$0F,$00,$01,$30 

.byte $0F,$36,$36,$36,$0F,$36,$36,$26,$0F,$16,$26,$36,$0F,$00,$01,$30 ; 21 ; Gurgu Volcano B2
.byte $0F,$0F,$12,$36,$0F,$0F,$27,$36,$0F,$00,$00,$00,$0F,$00,$00,$00 
.byte $0F,$10,$17,$0F,$0F,$0F,$06,$16,$0F,$06,$16,$26,$0F,$00,$01,$30 

.byte $0F,$26,$26,$26,$0F,$26,$26,$16,$0F,$06,$16,$26,$0F,$00,$01,$30 ; 22 ; Gurgu Volcano B3
.byte $0F,$0F,$12,$36,$0F,$0F,$27,$36,$0F,$00,$00,$00,$0F,$00,$00,$00 
.byte $0F,$10,$17,$0F,$0F,$0F,$06,$06,$0F,$0F,$06,$16,$0F,$00,$01,$30 

.byte $0F,$26,$26,$26,$0F,$26,$26,$16,$0F,$06,$16,$26,$0F,$00,$01,$30 ; 23 ; Gurgu Volcano B4
.byte $0F,$0F,$12,$36,$0F,$0F,$27,$36,$0F,$00,$00,$00,$0F,$00,$00,$00 
.byte $0F,$10,$17,$0F,$0F,$0F,$06,$06,$0F,$0F,$06,$16,$0F,$00,$01,$30 

.byte $0F,$26,$26,$26,$0F,$26,$26,$16,$0F,$06,$16,$26,$0F,$00,$01,$30 ; 24 ; Gurgu Volcano B5
.byte $0F,$0F,$12,$36,$0F,$0F,$27,$36,$0F,$1C,$2C,$30,$0F,$1C,$2C,$30 
.byte $0F,$10,$17,$0F,$0F,$0F,$06,$06,$0F,$0F,$06,$16,$0F,$00,$01,$30 

.byte $0F,$31,$31,$31,$0F,$31,$31,$10,$0F,$00,$10,$31,$0F,$00,$01,$30 ; 25 ; Ice Cave B2
.byte $0F,$0F,$12,$36,$0F,$0F,$27,$36,$0F,$00,$00,$00,$0F,$00,$00,$00 
.byte $0F,$10,$17,$0F,$0F,$0F,$00,$00,$0F,$0F,$00,$31,$0F,$00,$01,$30 

.byte $0F,$31,$31,$31,$0F,$31,$31,$10,$0F,$00,$10,$31,$0F,$00,$01,$30 ; 26 ; Ice Cave B3
.byte $0F,$0F,$12,$36,$0F,$0F,$27,$36,$0F,$00,$00,$00,$0F,$00,$00,$00 
.byte $0F,$10,$17,$0F,$0F,$0F,$00,$00,$0F,$0F,$00,$31,$0F,$00,$01,$30 

.byte $0F,$2C,$2C,$2C,$0F,$2C,$2C,$1C,$0F,$0C,$1C,$2C,$0F,$00,$01,$30 ; 27 ; Bahamut's Room B2
.byte $0F,$0F,$12,$36,$0F,$0F,$27,$36,$0F,$0F,$17,$28,$0F,$0F,$18,$28 
.byte $0F,$10,$17,$0F,$0F,$0F,$0C,$0C,$0F,$0F,$0C,$1C,$0F,$00,$01,$30 

.byte $0F,$27,$27,$27,$0F,$27,$27,$17,$0F,$07,$17,$27,$0F,$00,$01,$30 ; 28 ; Mirage Tower 2F
.byte $0F,$0F,$12,$36,$0F,$0F,$27,$36,$0F,$0F,$10,$15,$0F,$0F,$22,$15 
.byte $0F,$10,$00,$0F,$0F,$0F,$07,$07,$0F,$0F,$07,$17,$0F,$00,$01,$30 

.byte $0F,$37,$37,$37,$0F,$37,$37,$27,$0F,$17,$27,$37,$0F,$00,$01,$30 ; 29 ; Mirage Tower 3F
.byte $0F,$0F,$12,$36,$0F,$0F,$27,$36,$0F,$0F,$10,$15,$0F,$0F,$22,$15 
.byte $0F,$10,$00,$0F,$0F,$0F,$07,$17,$0F,$07,$17,$27,$0F,$00,$01,$30 

.byte $0F,$22,$22,$22,$0F,$22,$22,$12,$0F,$02,$12,$22,$0F,$00,$01,$30 ; 2A ; Sea Shrine B5
.byte $0F,$0F,$12,$36,$0F,$0F,$27,$36,$0F,$14,$25,$30,$0F,$14,$25,$30 
.byte $0F,$2C,$1C,$0F,$0F,$0F,$01,$01,$0F,$0F,$01,$12,$0F,$00,$01,$30 

.byte $0F,$22,$22,$22,$0F,$22,$22,$12,$0F,$02,$12,$22,$0F,$00,$01,$30 ; 2B ; Sea Shrine B4
.byte $0F,$0F,$12,$36,$0F,$0F,$27,$36,$0F,$00,$00,$00,$0F,$00,$00,$00 
.byte $0F,$2C,$1C,$0F,$0F,$0F,$01,$01,$0F,$0F,$01,$12,$0F,$00,$01,$30 

.byte $0F,$22,$22,$22,$0F,$22,$22,$12,$0F,$02,$12,$22,$0F,$00,$01,$30 ; 2C ; Sea Shrine B3
.byte $0F,$0F,$12,$36,$0F,$0F,$27,$36,$0F,$00,$00,$00,$0F,$00,$00,$00 
.byte $0F,$2C,$1C,$0F,$0F,$0F,$01,$01,$0F,$0F,$01,$12,$0F,$00,$01,$30 

.byte $0F,$32,$32,$32,$0F,$32,$32,$22,$0F,$12,$22,$32,$0F,$00,$01,$30 ; 2D ; Sea Shrine B2
.byte $0F,$0F,$12,$36,$0F,$0F,$27,$36,$0F,$00,$00,$00,$0F,$00,$00,$00 
.byte $0F,$2C,$1C,$0F,$0F,$0F,$02,$12,$0F,$02,$12,$22,$0F,$00,$01,$30 

.byte $0F,$32,$32,$32,$0F,$32,$32,$22,$0F,$12,$22,$32,$0F,$00,$01,$30 ; 2E ; Sea Shrine B1
.byte $0F,$0F,$12,$36,$0F,$0F,$27,$36,$0F,$15,$27,$36,$0F,$24,$15,$36 
.byte $0F,$2C,$1C,$0F,$0F,$0F,$02,$12,$0F,$02,$12,$22,$0F,$00,$01,$30 

.byte $0F,$30,$30,$30,$0F,$30,$30,$10,$0F,$01,$12,$13,$0F,$00,$01,$30 ; 2F ; Sky Palace 1F
.byte $0F,$0F,$12,$36,$0F,$0F,$27,$36,$0F,$00,$00,$00,$0F,$00,$00,$00 
.byte $0F,$10,$00,$0F,$0F,$0F,$00,$10,$0F,$01,$12,$13,$0F,$00,$01,$30 

.byte $0F,$30,$30,$30,$0F,$30,$30,$10,$0F,$01,$12,$13,$0F,$00,$01,$30 ; 30 ; Sky Palace 2F
.byte $0F,$0F,$12,$36,$0F,$0F,$27,$36,$0F,$00,$00,$00,$0F,$00,$00,$00 
.byte $0F,$10,$00,$0F,$0F,$0F,$00,$10,$0F,$01,$12,$13,$0F,$00,$01,$30 

.byte $0F,$30,$30,$30,$0F,$30,$30,$10,$0F,$01,$12,$13,$0F,$00,$01,$30 ; 31 ; Sky Palace 3F
.byte $0F,$0F,$12,$36,$0F,$0F,$27,$36,$0F,$0F,$2B,$15,$0F,$0F,$1B,$15 
.byte $0F,$10,$00,$0F,$0F,$0F,$00,$10,$0F,$01,$12,$13,$0F,$00,$01,$30 

.byte $0F,$30,$30,$30,$0F,$30,$30,$10,$0F,$01,$12,$13,$0F,$00,$01,$30 ; 32 ; Sky Palace 4F
.byte $0F,$0F,$12,$36,$0F,$0F,$27,$36,$0F,$00,$00,$00,$0F,$00,$00,$00 
.byte $0F,$10,$00,$0F,$0F,$0F,$00,$10,$0F,$01,$12,$13,$0F,$00,$01,$30 

.byte $0F,$30,$30,$30,$0F,$30,$30,$10,$0F,$01,$12,$13,$0F,$00,$01,$30 ; 33 ; Sky Palace 5F
.byte $0F,$0F,$12,$36,$0F,$0F,$27,$36,$0F,$1B,$2B,$30,$0F,$1B,$2B,$30 
.byte $0F,$10,$00,$0F,$0F,$0F,$00,$10,$0F,$01,$12,$13,$0F,$00,$01,$30 

.byte $0F,$30,$30,$30,$0F,$30,$30,$10,$0F,$12,$1A,$19,$0F,$00,$01,$30 ; 34 ; Temple of Fiends 1F
.byte $0F,$0F,$12,$36,$0F,$0F,$27,$36,$0F,$00,$00,$00,$0F,$00,$00,$00 
.byte $0F,$10,$17,$0F,$0F,$0F,$00,$10,$0F,$12,$1A,$19,$0F,$00,$01,$30 

.byte $0F,$30,$30,$30,$0F,$30,$30,$10,$0F,$12,$1A,$19,$0F,$00,$01,$30 ; 35 ; Temple of Fiends 2F
.byte $0F,$0F,$12,$36,$0F,$0F,$27,$36,$0F,$00,$00,$00,$0F,$00,$00,$00 
.byte $0F,$10,$17,$0F,$0F,$0F,$00,$10,$0F,$12,$1A,$19,$0F,$00,$01,$30 

.byte $0F,$30,$30,$30,$0F,$30,$30,$10,$0F,$12,$1A,$19,$0F,$00,$01,$30 ; 36 ; Temple of Fiends 3F
.byte $0F,$0F,$12,$36,$0F,$0F,$27,$36,$0F,$16,$00,$10,$0F,$00,$23,$10 
.byte $0F,$10,$17,$0F,$0F,$0F,$00,$10,$0F,$12,$1A,$19,$0F,$00,$01,$30 

.byte $0F,$30,$30,$30,$0F,$30,$30,$10,$0F,$12,$1A,$19,$0F,$00,$01,$30 ; 37 ; Temple of Fiends 4F - Earth
.byte $0F,$0F,$12,$36,$0F,$0F,$27,$36,$0F,$00,$00,$00,$0F,$00,$00,$00 
.byte $0F,$10,$17,$0F,$0F,$0F,$00,$10,$0F,$12,$1A,$19,$0F,$00,$01,$30 

.byte $0F,$30,$30,$30,$0F,$30,$30,$10,$0F,$12,$1A,$19,$0F,$00,$01,$30 ; 38 ; Temple of Fiends 5F - Fire
.byte $0F,$0F,$12,$36,$0F,$0F,$27,$36,$0F,$00,$00,$00,$0F,$00,$00,$00 
.byte $0F,$10,$17,$0F,$0F,$0F,$00,$10,$0F,$12,$1A,$19,$0F,$00,$01,$30 

.byte $0F,$30,$30,$30,$0F,$30,$30,$10,$0F,$12,$1A,$19,$0F,$00,$01,$30 ; 39 ; Temple of Fiends 6F - Water
.byte $0F,$0F,$12,$36,$0F,$0F,$27,$36,$0F,$00,$00,$00,$0F,$00,$00,$00 
.byte $0F,$10,$17,$0F,$0F,$0F,$00,$10,$0F,$12,$1A,$19,$0F,$00,$01,$30 

.byte $0F,$30,$30,$30,$0F,$30,$30,$10,$0F,$12,$1A,$19,$0F,$00,$01,$30 ; 3A ; Temple of Fiends 7F - Wind
.byte $0F,$0F,$12,$36,$0F,$0F,$27,$36,$0F,$00,$00,$00,$0F,$00,$00,$00 
.byte $0F,$10,$17,$0F,$0F,$0F,$00,$10,$0F,$12,$1A,$19,$0F,$00,$01,$30 

.byte $0F,$30,$30,$30,$0F,$30,$30,$10,$0F,$12,$1A,$19,$0F,$00,$01,$30 ; 3B ; Temple of Fiends 8F - Chaos
.byte $0F,$0F,$12,$36,$0F,$0F,$27,$36,$0F,$0F,$27,$36,$0F,$0F,$14,$36 
.byte $0F,$10,$17,$0F,$0F,$0F,$00,$10,$0F,$12,$1A,$19,$0F,$00,$01,$30 

.byte $0F,$22,$22,$22,$0F,$22,$22,$12,$0F,$02,$12,$22,$0F,$00,$01,$30 ; 3C ; Titan's Tunnel
.byte $0F,$0F,$12,$36,$0F,$0F,$27,$36,$0F,$3C,$2C,$17,$0F,$3C,$2C,$17 
.byte $0F,$10,$17,$0F,$0F,$0F,$02,$02,$0F,$0F,$02,$12,$0F,$00,$01,$30 

.byte $0F,$3B,$3B,$3B,$0F,$3B,$3B,$2B,$0F,$1B,$2B,$3B,$0F,$00,$01,$30 ; 3D ; 
.byte $0F,$0F,$12,$36,$0F,$0F,$27,$36,$60,$FF,$5E,$00,$BC,$00,$00,$00 
.byte $0F,$10,$00,$0F,$0F,$0F,$0B,$1B,$0F,$0B,$1B,$2B,$0F,$00,$01,$30 

.byte $0F,$3B,$3B,$3B,$0F,$3B,$3B,$2B,$0F,$1B,$2B,$3B,$0F,$00,$01,$30 ; 3E ; 
.byte $0F,$0F,$12,$36,$0F,$0F,$27,$36,$00,$00,$00,$00,$00,$00,$00,$00 
.byte $0F,$10,$00,$0F,$0F,$0F,$0B,$1B,$0F,$0B,$1B,$2B,$0F,$00,$01,$30 

.byte $FF,$FF,$FF,$FF,$FF,$FF,$03,$03,$03,$03,$03,$03,$03,$03,$FF,$FF ; 3F ; 
.byte $0F,$0F,$12,$36,$0F,$0F,$27,$36,$00,$00,$00,$00,$00,$00,$00,$00
.byte $7F,$7F,$7F,$7F,$7F,$7F,$60,$60,$60,$60,$60,$60,$60,$60,$FF,$FF



; Initial sprite visibilities, event flags, treasure chest opened flags

;; JIGS - this seems wasteful... as it is for the original game, it could be done with:
;LDA #1
;LDY #0
; @Loop:
; STA game_flags, Y
; DEY
; BNE @Loop
 
;TYA
;STA game_flags+$12
;STA game_flags+$13
;STA game_flags+$19
;STA game_flags+$1A
;STA game_flags+$3F 
;STA game_flags+$40
;STA game_flags+$41
;; So that's what it does now. If ever you need to switch back, here's the old data:

;lut_InitGameFlags:
;.byte $01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01
;.byte $01,$01,$00,$00,$01,$01,$01,$01,$01,$00,$00,$01,$01,$01,$01,$01
;.byte $01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01
;.byte $01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$00
;.byte $00,$00,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01
;.byte $01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01
;.byte $01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01
;.byte $01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01
;.byte $01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01
;.byte $01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01
;.byte $01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01
;.byte $01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01
;.byte $01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01
;.byte $01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01
;.byte $01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01
;.byte $01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01

.byte "END OF BANK 11"