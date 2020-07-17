.include "Constants.inc"
.include "variables.inc"
.include "macros.inc"
.feature force_range

.export lut_OWTileset
.export lut_SMTilesetAttr
.export lut_SMTilesetProp
.export lut_MapmanPalettes
.export lut_SMTilesetTSA
.export lut_SMPalettes
.export lut_EntrTele_X
.export lut_EntrTele_Y
.export lut_EntrTele_Map
.export lut_ExitTele_X
.export lut_ExitTele_Y
.export lut_Tilesets
.export lut_NormTele_X
.export lut_NormTele_Y
.export lut_NormTele_Map
.export lut_MapObjGfx
.export lut_MapObjects

.segment "BANK_12"

BANK_THIS = $12

;; JIGS - Re-arranged much of the data. There was a lot of unused padding to make sure certain routines were aligned to page boundaries and stuff.
;;        As of the time of this comment, there is 736 bytes free in this bank.
;; JIGS - now a lot more...



; world map tile data
; 2 bytes per tile:
;  +0: bits 6-7: 01 = chime required
;                10 = caravan required               ; JIGS - changing this to "slow down"
;                11 = use floater to raise airship   ; caravan is now "EE" and is found with CMP
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
.byte $06,$40  ; 00 Plain grass
.byte $0E,$89  ; 01 Enter coneria Castle Left
.byte $0E,$89  ; 02 Enter coneria Castle Right
.byte $0E,$40  ; 03 Forest UL
.byte $1E,$40  ; 04 Forest top
.byte $0E,$40  ; 05 Forest UR
.byte $0E,$40  ; 06 Ocean UL
.byte $0B,$42  ; 07 Ocean top
.byte $0E,$40  ; 08 Ocean UR
.byte $0F,$00  ; 09 Big Castle top left
.byte $0F,$00  ; 0A Big Castle top right
.byte $0F,$00  ; 0B Small castle top left
.byte $0F,$00  ; 0C Small castle rop right
.byte $0F,$00  ; 0D Desert tower top
.byte $0E,$8E  ; 0E Earth Cave entrance
.byte $2E,$00  ; 0F Dock, left side
.byte $0F,$00  ; 10 Cave UL
.byte $0F,$00  ; 11 Cave top
.byte $0F,$00  ; 12 Cave UR
.byte $1E,$40  ; 13 Forest Left
.byte $1E,$40  ; 14 Forst Middle
.byte $1E,$40  ; 15 Forest Right
.byte $0B,$42  ; 16 Ocean left
.byte $0B,$42  ; 17 Ocean middle
.byte $0B,$42  ; 18 Ocean right
.byte $0F,$00  ; 19 Big castle middle left
.byte $0F,$00  ; 1A Big castle middle right
.byte $0E,$8A  ; 1B Enter Flfland Castle
.byte $0E,$8A  ; 1C Enter Elfland Castle
.byte $4E,$98  ; 1D Enter Desert tower
.byte $8E,$00  ; 1E Desert Tower shadow
.byte $2E,$00  ; 1F Docks, right side
.byte $0F,$00  ; 20 Cave left
.byte $0F,$00  ; 21 Cave middle
.byte $0F,$00  ; 22 Cave right
.byte $0E,$40  ; 23 Forest BL
.byte $1E,$40  ; 24 Forest bottom
.byte $0E,$40  ; 25 Forest BR
.byte $0E,$40  ; 26 Ocean BL
.byte $0B,$42  ; 27 Ocean bottom
.byte $0E,$40  ; 28 Ocean BR
.byte $0E,$8B  ; 29 Enter Astos Castle Left
.byte $0E,$8B  ; 2A Enter Astos Castle right
.byte $0E,$90  ; 2B Enter Ice Cave
.byte $0F,$00  ; 2C Town wall UL
.byte $0F,$00  ; 2D Town wall top
.byte $0F,$00  ; 2E Town wall UR
.byte $0E,$94  ; 2F Enter Dwarf Cave
.byte $0F,$00  ; 30 Cave BL
.byte $0F,$00  ; 31 Cave Bottom
.byte $0E,$95  ; 32 Enter Matoya's Cave
.byte $0F,$00  ; 33 Cave BR
.byte $0E,$99  ; 34 Enter Titan's Tunnel East
.byte $0E,$9A  ; 35 Enter Titan's Tunnel West
.byte $EE,$00  ; 36 Desert Caravan shop
.byte $CE,$00  ; 37 Desert Raise airship 
.byte $0E,$8C  ; 38 Enter Castle of Ordeals Left
.byte $0E,$8C  ; 39 Enter Castle of Ordeals Right
.byte $0E,$96  ; 3A Enter Sarda's Cave
.byte $0E,$00  ; 3B Town Wall top grass-/
.byte $0F,$00  ; 3C Town wall top /-pavement
.byte $0E,$00  ; 3D Town pavement
.byte $0F,$00  ; 3E Town wall top pavement-\ 
.byte $0E,$00  ; 3F Town wall top \-grass
.byte $0D,$41  ; 40 River UL
.byte $0D,$41  ; 41 River UR
.byte $8E,$40  ; 42 Desert UL
.byte $8E,$40  ; 43 Desert UR
.byte $0D,$41  ; 44 River
.byte $8E,$40  ; 45 Desert
.byte $0D,$93  ; 46 Waterfall
.byte $0F,$00  ; 47 Temple of Fiends roof left
.byte $0F,$00  ; 48 Temple of Fiends roof right
.byte $0E,$81  ; 49 Enter Coneria
.byte $0E,$82  ; 4A Enter Pravoka
.byte $0F,$00  ; 4B Town Wall middle grass-/
.byte $0E,$83  ; 4C Enter Elfland
.byte $0E,$84  ; 4D Enter Melmond
.byte $0E,$85  ; 4E Enter Crescent Lake
.byte $0F,$00  ; 4F Town wall middle \-grass
.byte $0D,$41  ; 50 River BL
.byte $0D,$41  ; 51 River BR
.byte $8E,$40  ; 52 Desert BL
.byte $8E,$40  ; 53 Desert BR
.byte $06,$40  ; 54 Plains
.byte $9E,$40  ; 55 Marsh
.byte $06,$00  ; 56 Temple of Fiends grass/pavement left
.byte $0E,$8D  ; 57 Enter Temple of Fiends Left
.byte $0E,$8D  ; 58 Enter Temple of Fiends right
.byte $06,$00  ; 59 Temple of Fiends pavement/grass right
.byte $0E,$86  ; 5A Enter Gaia
.byte $0F,$00  ; 5B Town Wall less grass-/
.byte $0F,$00  ; 5C Town wall grass-curve left
.byte $0E,$87  ; 5D Enter Onrac
.byte $0F,$00  ; 5E Town wall curve-grass right
.byte $0F,$00  ; 5F Town wall \-less grass
.byte $06,$40  ; 60 Plains UL
.byte $06,$40  ; 61 Plains UR
.byte $9E,$40  ; 62 Marsh UL
.byte $9E,$40  ; 63 Marsh UR
.byte $8E,$8F  ; 64 Volcano top left  (enter)
.byte $8E,$8F  ; 65 Volcano top right (enter)
.byte $8E,$91  ; 66 Cardia Cave 2
.byte $8E,$9B  ; 67 Cardia Cave 3
.byte $8E,$9C  ; 68 Cardia Cave 4
.byte $8E,$9D  ; 69 Cardia Cave 5
.byte $8E,$80  ; 6A Cardia Cave 1
.byte $0F,$00  ; 6B Town Wall /-pavement left
.byte $0E,$92  ; 6C Enter Bahamut's room
.byte $0E,$88  ; 6D Enter Leifen
.byte $8E,$97  ; 6E Enter Marsh Cave
.byte $0F,$00  ; 6F Town Wall pavement-\ right
.byte $06,$40  ; 70 Plains BL
.byte $06,$40  ; 71 Plains BR
.byte $9E,$40  ; 72 Marsh BL
.byte $9E,$40  ; 73 Marsh BR
.byte $8E,$00  ; 74 Volcano bottom left
.byte $8E,$00  ; 75 Volcano bottom right
.byte $06,$00  ; 76 Grass, no fight
.byte $2E,$00  ; 77 Docks, BR
.byte $2E,$00  ; 78 Docks, bottom
.byte $2E,$00  ; 79 Docks, BL
.byte $2E,$00  ; 7A Docks, UR
.byte $0F,$00  ; 7B Town Wall curve left
.byte $0F,$00  ; 7C Town wall bottom
.byte $0F,$00  ; 7D Town Wall gate left
.byte $0F,$00  ; 7E Town wall gate right
.byte $0F,$00  ; 7F Town wall curve right

; world map pattern table assignment
; 1 - UPPER LEFT
.byte $01 ; 00 Plain grass                           ; UL 
.byte $AC ; 01 Enter coneria Castle Left             ; UL 
.byte $AE ; 02 Enter coneria Castle Right            ; UL 
.byte $66 ; 03 Forest UL                             ; UL 
.byte $68 ; 04 Forest top                            ; UL 
.byte $6A ; 05 Forest UR                             ; UL 
.byte $01 ; 06 Ocean UL                              ; UL 
.byte $0D ; 07 Ocean top                             ; UL 
.byte $0F ; 08 Ocean UR                              ; UL 
.byte $01 ; 09 Big Castle top left                   ; UL 
.byte $6F ; 0A Big Castle top right                  ; UL 
.byte $BC ; 0B Small castle top left                 ; UL 
.byte $01 ; 0C Small castle rop right                ; UL 
.byte $A4 ; 0D Desert tower top                      ; UL 
.byte $4A ; 0E Earth Cave entrance                   ; UL 
.byte $06 ; 0F Dock, left side                       ; UL 
.byte $01 ; 10 Cave UL                               ; UL 
.byte $03 ; 11 Cave top                              ; UL 
.byte $05 ; 12 Cave UR                               ; UL 
.byte $86 ; 13 Forest Left                           ; UL 
.byte $77 ; 14 Forst Middle                          ; UL 
.byte $77 ; 15 Forest Right                          ; UL 
.byte $2C ; 16 Ocean left                            ; UL 
.byte $2D ; 17 Ocean middle                          ; UL 
.byte $2D ; 18 Ocean right                           ; UL 
.byte $8C ; 19 Big castle middle left                ; UL 
.byte $8E ; 1A Big castle middle right               ; UL 
.byte $DC ; 1B Enter Flfland Castle                  ; UL 
.byte $DE ; 1C Enter Elfland Castle                  ; UL 
.byte $C4 ; 1D Enter Desert tower                    ; UL 
.byte $0A ; 1E Desert Tower shadow                   ; UL 
.byte $01 ; 1F Docks, right side                     ; UL 
.byte $20 ; 20 Cave left                             ; UL 
.byte $11 ; 21 Cave middle                           ; UL 
.byte $11 ; 22 Cave right                            ; UL 
.byte $A6 ; 23 Forest BL                             ; UL 
.byte $77 ; 24 Forest bottom                         ; UL 
.byte $77 ; 25 Forest BR                             ; UL 
.byte $4C ; 26 Ocean BL                              ; UL 
.byte $2D ; 27 Ocean bottom                          ; UL 
.byte $4E ; 28 Ocean BR                              ; UL 
.byte $DC ; 29 Enter Astos Castle Left               ; UL 
.byte $DE ; 2A Enter Astos Castle right              ; UL 
.byte $4A ; 2B Enter Ice Cave                        ; UL 
.byte $01 ; 2C Town wall UL                          ; UL 
.byte $01 ; 2D Town wall top                         ; UL 
.byte $01 ; 2E Town wall UR                          ; UL 
.byte $4A ; 2F Enter Dwarf Cave                      ; UL 
.byte $32 ; 30 Cave BL                               ; UL 
.byte $11 ; 31 Cave Bottom                           ; UL 
.byte $4A ; 32 Enter Matoya's Cave                   ; UL 
.byte $31 ; 33 Cave BR                               ; UL 
.byte $4A ; 34 Enter Titan's Tunnel East             ; UL 
.byte $4A ; 35 Enter Titan's Tunnel West             ; UL 
.byte $0A ; 36 Desert Caravan shop                   ; UL 
.byte $0A ; 37 Desert Raise airship                  ; UL 
.byte $DC ; 38 Enter Castle of Ordeals Left          ; UL 
.byte $DE ; 39 Enter Castle of Ordeals Right         ; UL 
.byte $4A ; 3A Enter Sarda's Cave                    ; UL 
.byte $01 ; 3B Town Wall top grass-/                 ; UL 
.byte $70 ; 3C Town wall top /-pavement              ; UL 
.byte $C6 ; 3D Town pavement                         ; UL 
.byte $C6 ; 3E Town wall top pavement-\              ; UL 
.byte $83 ; 3F Town wall top \-grass                 ; UL 
.byte $2A ; 40 River UL                              ; UL 
.byte $09 ; 41 River UR                              ; UL 
.byte $01 ; 42 Desert UL                             ; UL 
.byte $43 ; 43 Desert UR                             ; UL 
.byte $09 ; 44 River                                 ; UL 
.byte $0A ; 45 Desert                                ; UL 
.byte $94 ; 46 Waterfall                             ; UL 
.byte $C7 ; 47 Temple of Fiends roof left            ; UL 
.byte $C9 ; 48 Temple of Fiends roof right           ; UL 
.byte $E0 ; 49 Enter Coneria                         ; UL 
.byte $81 ; 4A Enter Pravoka                         ; UL 
.byte $01 ; 4B Town Wall middle grass-/              ; UL 
.byte $E4 ; 4C Enter Elfland                         ; UL 
.byte $62 ; 62 Enter Melmond                         ; UL 
.byte $A1 ; 4E Enter Crescent Lake                   ; UL 
.byte $A3 ; 4F Town wall middle \-grass              ; UL 
.byte $09 ; 50 River BL                              ; UL 
.byte $09 ; 51 River BR                              ; UL 
.byte $52 ; 52 Desert BL                             ; UL 
.byte $0A ; 53 Desert BR                             ; UL 
.byte $84 ; 54 Plains                                ; UL 
.byte $44 ; 55 Marsh                                 ; UL 
.byte $01 ; 56 Temple of Fiends grass/pavement left  ; UL 
.byte $E7 ; 57 Enter Temple of Fiends Left           ; UL 
.byte $E9 ; 58 Enter Temple of Fiends right          ; UL 
.byte $EB ; 59 Temple of Fiends pavement/grass right ; UL 
.byte $E2 ; 5A Enter Gaia                            ; UL 
.byte $80 ; 5B Town Wall less grass-/                ; UL 
.byte $01 ; 5C Town wall grass-curve left            ; UL 
.byte $E2 ; 5D Enter Onrac                           ; UL 
.byte $C3 ; 5E Town wall curve-grass right           ; UL 
.byte $71 ; 5F Town wall \-less grass                ; UL 
.byte $64 ; 60 Plains UL                             ; UL 
.byte $75 ; 61 Plains UR                             ; UL 
.byte $46 ; 62 Marsh UL                              ; UL 
.byte $44 ; 63 Marsh UR                              ; UL 
.byte $01 ; 64 Volcano top left  (enter)             ; UL 
.byte $08 ; 65 Volcano top right (enter)             ; UL 
.byte $48 ; 66 Cardia Cave 2                         ; UL 
.byte $48 ; 67 Cardia Cave 3                         ; UL 
.byte $48 ; 68 Cardia Cave 4                         ; UL 
.byte $48 ; 69 Cardia Cave 5                         ; UL 
.byte $48 ; 6A Cardia Cave 1                         ; UL 
.byte $A0 ; 6B Town Wall /-pavement left             ; UL 
.byte $48 ; 6C Enter Bahamut's room                  ; UL 
.byte $E0 ; 6D Enter Leifen                          ; UL 
.byte $48 ; 6E Enter Marsh Cave                      ; UL 
.byte $C6 ; 6F Town Wall pavement-\ right            ; UL 
.byte $74 ; 70 Plains BL                             ; UL 
.byte $84 ; 71 Plains BR                             ; UL 
.byte $44 ; 72 Marsh BL                              ; UL 
.byte $45 ; 73 Marsh BR                              ; UL 
.byte $26 ; 74 Volcano bottom left                   ; UL 
.byte $28 ; 75 Volcano bottom right                  ; UL 
.byte $01 ; 76 Grass, no fight                       ; UL 
.byte $01 ; 77 Docks, BR                             ; UL 
.byte $01 ; 78 Docks, bottom                         ; UL 
.byte $01 ; 79 Docks, BL                             ; UL 
.byte $06 ; 7A Docks, UL                             ; UL 
.byte $C0 ; 7B Town Wall curve left                  ; UL 
.byte $C6 ; 7C Town wall bottom                      ; UL 
.byte $C6 ; 7D Town Wall gate left                   ; UL 
.byte $C2 ; 7E Town wall gate right                  ; UL 
.byte $C6 ; 7F Town wall curve right                 ; UL 

; 2 - UPPER RIGHT
.byte $01 ; 00 Plain grass                           ; UR
.byte $AD ; 01 Enter coneria Castle Left             ; UR
.byte $AF ; 02 Enter coneria Castle Right            ; UR
.byte $67 ; 03 Forest UL                             ; UR
.byte $69 ; 04 Forest top                            ; UR
.byte $6B ; 05 Forest UR                             ; UR
.byte $0C ; 06 Ocean UL                              ; UR
.byte $0E ; 07 Ocean top                             ; UR
.byte $01 ; 08 Ocean UR                              ; UR
.byte $6E ; 09 Big Castle top left                   ; UR
.byte $01 ; 0A Big Castle top right                  ; UR
.byte $BD ; 0B Small castle top left                 ; UR
.byte $01 ; 0C Small castle rop right                ; UR
.byte $A5 ; 0D Desert tower top                      ; UR
.byte $4B ; 0E Earth Cave entrance                   ; UR
.byte $01 ; 0F Dock, left side                       ; UR
.byte $02 ; 10 Cave UL                               ; UR
.byte $04 ; 11 Cave top                              ; UR
.byte $01 ; 12 Cave UR                               ; UR
.byte $78 ; 13 Forest Left                           ; UR
.byte $78 ; 14 Forst Middle                          ; UR
.byte $8B ; 15 Forest Right                          ; UR
.byte $2E ; 16 Ocean left                            ; UR
.byte $2E ; 17 Ocean middle                          ; UR
.byte $2F ; 18 Ocean right                           ; UR
.byte $8D ; 19 Big castle middle left                ; UR
.byte $8F ; 1A Big castle middle right               ; UR
.byte $DD ; 1B Enter Flfland Castle                  ; UR
.byte $DF ; 1C Enter Elfland Castle                  ; UR
.byte $C5 ; 1D Enter Desert tower                    ; UR
.byte $0B ; 1E Desert Tower shadow                   ; UR
.byte $06 ; 1F Docks, right side                     ; UR
.byte $12 ; 20 Cave left                             ; UR
.byte $12 ; 21 Cave middle                           ; UR
.byte $15 ; 22 Cave right                            ; UR
.byte $78 ; 23 Forest BL                             ; UR
.byte $78 ; 24 Forest bottom                         ; UR
.byte $AB ; 25 Forest BR                             ; UR
.byte $4D ; 26 Ocean BL                              ; UR
.byte $2E ; 27 Ocean bottom                          ; UR
.byte $4F ; 28 Ocean BR                              ; UR
.byte $DD ; 29 Enter Astos Castle Left               ; UR
.byte $DF ; 2A Enter Astos Castle right              ; UR
.byte $4B ; 2B Enter Ice Cave                        ; UR
.byte $01 ; 2C Town wall UL                          ; UR
.byte $01 ; 2D Town wall top                         ; UR
.byte $01 ; 2E Town wall UR                          ; UR
.byte $4B ; 2F Enter Dwarf Cave                      ; UR
.byte $22 ; 30 Cave BL                               ; UR
.byte $12 ; 31 Cave Bottom                           ; UR
.byte $4B ; 32 Enter Matoya's Cave                   ; UR
.byte $24 ; 33 Cave BR                               ; UR
.byte $4B ; 34 Enter Titan's Tunnel East             ; UR
.byte $4B ; 35 Enter Titan's Tunnel West             ; UR
.byte $0B ; 36 Desert Caravan shop                   ; UR
.byte $0B ; 37 Desert Raise airship                  ; UR
.byte $DD ; 38 Enter Castle of Ordeals Left          ; UR
.byte $DF ; 39 Enter Castle of Ordeals Right         ; UR
.byte $4B ; 3A Enter Sarda's Cave                    ; UR
.byte $80 ; 3B Town Wall top grass-/                 ; UR
.byte $C6 ; 3C Town wall top /-pavement              ; UR
.byte $C6 ; 3D Town pavement                         ; UR
.byte $71 ; 3E Town wall top pavement-\              ; UR
.byte $01 ; 3F Town wall top \-grass                 ; UR
.byte $09 ; 40 River UL                              ; UR
.byte $2B ; 41 River UR                              ; UR
.byte $42 ; 42 Desert UL                             ; UR
.byte $01 ; 43 Desert UR                             ; UR
.byte $09 ; 44 River                                 ; UR
.byte $0B ; 45 Desert                                ; UR
.byte $95 ; 46 Waterfall                             ; UR
.byte $C8 ; 47 Temple of Fiends roof left            ; UR
.byte $CA ; 48 Temple of Fiends roof right           ; UR
.byte $E1 ; 49 Enter Coneria                         ; UR
.byte $82 ; 4A Enter Pravoka                         ; UR
.byte $A0 ; 4B Town Wall middle grass-/              ; UR
.byte $E5 ; 4C Enter Elfland                         ; UR
.byte $63 ; 63 Enter Melmond                         ; UR
.byte $A2 ; 4E Enter Crescent Lake                   ; UR
.byte $01 ; 4F Town wall middle \-grass              ; UR
.byte $09 ; 50 River BL                              ; UR
.byte $09 ; 51 River BR                              ; UR
.byte $0B ; 52 Desert BL                             ; UR
.byte $53 ; 53 Desert BR                             ; UR
.byte $85 ; 54 Plains                                ; UR
.byte $45 ; 55 Marsh                                 ; UR
.byte $E6 ; 56 Temple of Fiends grass/pavement left  ; UR
.byte $E8 ; 57 Enter Temple of Fiends Left           ; UR
.byte $EA ; 58 Enter Temple of Fiends right          ; UR
.byte $01 ; 59 Temple of Fiends pavement/grass right ; UR
.byte $E3 ; 5A Enter Gaia                            ; UR
.byte $70 ; 5B Town Wall less grass-/                ; UR
.byte $C0 ; 5C Town wall grass-curve left            ; UR
.byte $E3 ; 5D Enter Onrac                           ; UR
.byte $01 ; 5E Town wall curve-grass right           ; UR
.byte $83 ; 5F Town wall \-less grass                ; UR
.byte $74 ; 60 Plains UL                             ; UR
.byte $65 ; 61 Plains UR                             ; UR
.byte $45 ; 62 Marsh UL                              ; UR
.byte $47 ; 63 Marsh UR                              ; UR
.byte $07 ; 64 Volcano top left  (enter)             ; UR
.byte $01 ; 65 Volcano top right (enter)             ; UR
.byte $49 ; 66 Cardia Cave 2                         ; UR
.byte $49 ; 67 Cardia Cave 3                         ; UR
.byte $49 ; 68 Cardia Cave 4                         ; UR
.byte $49 ; 69 Cardia Cave 5                         ; UR
.byte $49 ; 6A Cardia Cave 1                         ; UR
.byte $C6 ; 6B Town Wall /-pavement left             ; UR
.byte $49 ; 6C Enter Bahamut's room                  ; UR
.byte $E1 ; 6D Enter Leifen                          ; UR
.byte $49 ; 6E Enter Marsh Cave                      ; UR
.byte $A3 ; 6F Town Wall pavement-\ right            ; UR
.byte $85 ; 70 Plains BL                             ; UR
.byte $75 ; 71 Plains BR                             ; UR
.byte $45 ; 72 Marsh BL                              ; UR
.byte $45 ; 73 Marsh BR                              ; UR
.byte $27 ; 74 Volcano bottom left                   ; UR
.byte $29 ; 75 Volcano bottom right                  ; UR
.byte $01 ; 76 Grass, no fight                       ; UR
.byte $01 ; 77 Docks, BR                             ; UR
.byte $01 ; 78 Docks, bottom                         ; UR
.byte $01 ; 79 Docks, BL                             ; UR
.byte $01 ; 7A Docks, UL                             ; UR
.byte $C6 ; 7B Town Wall curve left                  ; UR
.byte $C6 ; 7C Town wall bottom                      ; UR
.byte $C2 ; 7D Town Wall gate left                   ; UR
.byte $C6 ; 7E Town wall gate right                  ; UR
.byte $C3 ; 7F Town wall curve right                 ; UR

; 3 - LOWER LEFT 
.byte $01 ; 00 Plain grass                           ; LL
.byte $C6 ; 01 Enter coneria Castle Left             ; LL
.byte $BE ; 02 Enter coneria Castle Right            ; LL
.byte $76 ; 03 Forest UL                             ; LL
.byte $87 ; 04 Forest top                            ; LL
.byte $87 ; 05 Forest UR                             ; LL
.byte $1C ; 06 Ocean UL                              ; LL
.byte $3D ; 07 Ocean top                             ; LL
.byte $1E ; 08 Ocean UR                              ; LL
.byte $01 ; 09 Big Castle top left                   ; LL
.byte $7F ; 0A Big Castle top right                  ; LL
.byte $CC ; 0B Small castle top left                 ; LL
.byte $CE ; 0C Small castle rop right                ; LL
.byte $B4 ; 0D Desert tower top                      ; LL
.byte $5A ; 0E Earth Cave entrance                   ; LL
.byte $06 ; 0F Dock, left side                       ; LL
.byte $10 ; 10 Cave UL                               ; LL
.byte $12 ; 11 Cave top                              ; LL
.byte $12 ; 12 Cave UR                               ; LL
.byte $96 ; 13 Forest Left                           ; LL
.byte $87 ; 14 Forst Middle                          ; LL
.byte $87 ; 15 Forest Right                          ; LL
.byte $3C ; 16 Ocean left                            ; LL
.byte $3D ; 17 Ocean middle                          ; LL
.byte $3D ; 18 Ocean right                           ; LL
.byte $9C ; 19 Big castle middle left                ; LL
.byte $9E ; 1A Big castle middle right               ; LL
.byte $EC ; 1B Enter Flfland Castle                  ; LL
.byte $EE ; 1C Enter Elfland Castle                  ; LL
.byte $D4 ; 1D Enter Desert tower                    ; LL
.byte $D6 ; 1E Desert Tower shadow                   ; LL
.byte $01 ; 1F Docks, right side                     ; LL
.byte $30 ; 20 Cave left                             ; LL
.byte $23 ; 21 Cave middle                           ; LL
.byte $12 ; 22 Cave right                            ; LL
.byte $B6 ; 23 Forest BL                             ; LL
.byte $B8 ; 24 Forest bottom                         ; LL
.byte $BA ; 25 Forest BR                             ; LL
.byte $01 ; 26 Ocean BL                              ; LL
.byte $5D ; 27 Ocean bottom                          ; LL
.byte $5F ; 28 Ocean BR                              ; LL
.byte $EC ; 29 Enter Astos Castle Left               ; LL
.byte $EE ; 2A Enter Astos Castle right              ; LL
.byte $5A ; 2B Enter Ice Cave                        ; LL
.byte $60 ; 2C Town wall UL                          ; LL
.byte $C1 ; 2D Town wall top                         ; LL
.byte $C1 ; 2E Town wall UR                          ; LL
.byte $5A ; 2F Enter Dwarf Cave                      ; LL
.byte $01 ; 30 Cave BL                               ; LL
.byte $33 ; 31 Cave Bottom                           ; LL
.byte $5A ; 32 Enter Matoya's Cave                   ; LL
.byte $35 ; 33 Cave BR                               ; LL
.byte $5A ; 34 Enter Titan's Tunnel East             ; LL
.byte $5A ; 35 Enter Titan's Tunnel West             ; LL
.byte $1A ; 36 Desert Caravan shop                   ; LL
.byte $1A ; 37 Desert Raise airship                  ; LL
.byte $EC ; 38 Enter Castle of Ordeals Left          ; LL
.byte $EE ; 39 Enter Castle of Ordeals Right         ; LL
.byte $5A ; 3A Enter Sarda's Cave                    ; LL
.byte $01 ; 3B Town Wall top grass-/                 ; LL
.byte $C6 ; 3C Town wall top /-pavement              ; LL
.byte $C6 ; 3D Town pavement                         ; LL
.byte $C6 ; 3E Town wall top pavement-\              ; LL
.byte $93 ; 3F Town wall top \-grass                 ; LL
.byte $09 ; 40 River UL                              ; LL
.byte $09 ; 41 River UR                              ; LL
.byte $40 ; 40 Desert UL                             ; LL
.byte $1A ; 43 Desert UR                             ; LL
.byte $09 ; 44 River                                 ; LL
.byte $1A ; 45 Desert                                ; LL
.byte $94 ; 46 Waterfall                             ; LL
.byte $D7 ; 47 Temple of Fiends roof left            ; LL
.byte $D9 ; 48 Temple of Fiends roof right           ; LL
.byte $F0 ; 49 Enter Coneria                         ; LL
.byte $91 ; 4A Enter Pravoka                         ; LL
.byte $01 ; 4B Town Wall middle grass-/              ; LL
.byte $F4 ; 4C Enter Elfland                         ; LL
.byte $72 ; 72 Enter Melmond                         ; LL
.byte $B1 ; 4E Enter Crescent Lake                   ; LL
.byte $B3 ; 4F Town wall middle \-grass              ; LL
.byte $3A ; 50 River BL                              ; LL
.byte $09 ; 51 River BR                              ; LL
.byte $01 ; 52 Desert BL                             ; LL
.byte $51 ; 51 Desert BR                             ; LL
.byte $85 ; 54 Plains                                ; LL
.byte $54 ; 55 Marsh                                 ; LL
.byte $01 ; 56 Temple of Fiends grass/pavement left  ; LL
.byte $F7 ; 57 Enter Temple of Fiends Left           ; LL
.byte $F9 ; 58 Enter Temple of Fiends right          ; LL
.byte $FB ; 59 Temple of Fiends pavement/grass right ; LL
.byte $F2 ; 5A Enter Gaia                            ; LL
.byte $90 ; 5B Town Wall less grass-/                ; LL
.byte $01 ; 5C Town wall grass-curve left            ; LL
.byte $F2 ; 5D Enter Onrac                           ; LL
.byte $D3 ; 5E Town wall curve-grass right           ; LL
.byte $C6 ; 5F Town wall \-less grass                ; LL
.byte $74 ; 60 Plains UL                             ; LL
.byte $85 ; 61 Plains UR                             ; LL
.byte $54 ; 62 Marsh UL                              ; LL
.byte $54 ; 63 Marsh UR                              ; LL
.byte $16 ; 64 Volcano top left  (enter)             ; LL
.byte $18 ; 65 Volcano top right (enter)             ; LL
.byte $58 ; 66 Cardia Cave 2                         ; LL
.byte $58 ; 67 Cardia Cave 3                         ; LL
.byte $58 ; 68 Cardia Cave 4                         ; LL
.byte $58 ; 69 Cardia Cave 5                         ; LL
.byte $58 ; 6A Cardia Cave 1                         ; LL
.byte $B0 ; 6B Town Wall /-pavement left             ; LL
.byte $58 ; 6C Enter Bahamut's room                  ; LL
.byte $F0 ; 6D Enter Leifen                          ; LL
.byte $58 ; 6E Enter Marsh Cave                      ; LL
.byte $C6 ; 6F Town Wall pavement-\ right            ; LL
.byte $64 ; 70 Plains BL                             ; LL
.byte $75 ; 71 Plains BR                             ; LL
.byte $56 ; 72 Marsh BL                              ; LL
.byte $54 ; 73 Marsh BR                              ; LL
.byte $36 ; 74 Volcano bottom left                   ; LL
.byte $38 ; 75 Volcano bottom right                  ; LL
.byte $01 ; 76 Grass, no fight                       ; LL
.byte $01 ; 77 Docks, BR                             ; LL
.byte $06 ; 78 Docks, bottom                         ; LL
.byte $06 ; 79 Docks, BL                             ; LL
.byte $01 ; 7A Docks, UR                             ; LL
.byte $D0 ; 7B Town Wall curve left                  ; LL
.byte $D1 ; 7C Town wall bottom                      ; LL
.byte $D1 ; 7D Town Wall gate left                   ; LL
.byte $D2 ; 7E Town wall gate right                  ; LL
.byte $D1 ; 7F Town wall curve right                 ; LL

; 4 - LOWER RIGHT
.byte $01 ; 00 Plain grass                           ; LR
.byte $BE ; 01 Enter coneria Castle Left             ; LR
.byte $BF ; 02 Enter coneria Castle Right            ; LR
.byte $88 ; 03 Forest UL                             ; LR
.byte $88 ; 04 Forest top                            ; LR
.byte $7B ; 05 Forest UR                             ; LR
.byte $1D ; 06 Ocean UL                              ; LR
.byte $3E ; 07 Ocean top                             ; LR
.byte $1F ; 08 Ocean UR                              ; LR
.byte $7E ; 09 Big Castle top left                   ; LR
.byte $01 ; 0A Big Castle top right                  ; LR
.byte $CD ; 0B Small castle top left                 ; LR
.byte $CF ; 0C Small castle rop right                ; LR
.byte $B5 ; 0D Desert tower top                      ; LR
.byte $5B ; 0E Earth Cave entrance                   ; LR
.byte $01 ; 0F Dock, left side                       ; LR
.byte $13 ; 10 Cave UL                               ; LR
.byte $13 ; 11 Cave top                              ; LR
.byte $14 ; 12 Cave UR                               ; LR
.byte $88 ; 13 Forest Left                           ; LR
.byte $88 ; 14 Forst Middle                          ; LR
.byte $9B ; 15 Forest Right                          ; LR
.byte $3E ; 16 Ocean left                            ; LR
.byte $3E ; 17 Ocean middle                          ; LR
.byte $3F ; 18 Ocean right                           ; LR
.byte $9D ; 19 Big castle middle left                ; LR
.byte $9F ; 1A Big castle middle right               ; LR
.byte $ED ; 1B Enter Flfland Castle                  ; LR
.byte $EF ; 1C Enter Elfland Castle                  ; LR
.byte $D5 ; 1D Enter Desert tower                    ; LR
.byte $1B ; 1E Desert Tower shadow                   ; LR
.byte $06 ; 1F Docks, right side                     ; LR
.byte $13 ; 20 Cave left                             ; LR
.byte $13 ; 21 Cave middle                           ; LR
.byte $25 ; 22 Cave right                            ; LR
.byte $B7 ; 23 Forest BL                             ; LR
.byte $B9 ; 24 Forest bottom                         ; LR
.byte $BB ; 25 Forest BR                             ; LR
.byte $5C ; 26 Ocean BL                              ; LR
.byte $5E ; 27 Ocean bottom                          ; LR
.byte $01 ; 28 Ocean BR                              ; LR
.byte $ED ; 29 Enter Astos Castle Left               ; LR
.byte $EF ; 2A Enter Astos Castle right              ; LR
.byte $5B ; 2B Enter Ice Cave                        ; LR
.byte $C1 ; 2C Town wall UL                          ; LR
.byte $C1 ; 2D Town wall top                         ; LR
.byte $61 ; 2E Town wall UR                          ; LR
.byte $5B ; 2F Enter Dwarf Cave                      ; LR
.byte $32 ; 30 Cave BL                               ; LR
.byte $34 ; 31 Cave Bottom                           ; LR
.byte $5B ; 32 Enter Matoya's Cave                   ; LR
.byte $01 ; 33 Cave BR                               ; LR
.byte $5B ; 34 Enter Titan's Tunnel East             ; LR
.byte $5B ; 35 Enter Titan's Tunnel West             ; LR
.byte $1B ; 36 Desert Caravan shop                   ; LR
.byte $1B ; 37 Desert Raise airship                  ; LR
.byte $ED ; 38 Enter Castle of Ordeals Left          ; LR
.byte $EF ; 39 Enter Castle of Ordeals Right         ; LR
.byte $5B ; 3A Enter Sarda's Cave                    ; LR
.byte $90 ; 3B Town Wall top grass-/                 ; LR
.byte $C6 ; 3C Town wall top /-pavement              ; LR
.byte $C6 ; 3D Town pavement                         ; LR
.byte $C6 ; 3E Town wall top pavement-\              ; LR
.byte $01 ; 3F Town wall top \-grass                 ; LR
.byte $09 ; 40 River UL                              ; LR
.byte $09 ; 41 River UR                              ; LR
.byte $1B ; 42 Desert UL                             ; LR
.byte $41 ; 43 Desert UR                             ; LR
.byte $09 ; 44 River                                 ; LR
.byte $1B ; 45 Desert                                ; LR
.byte $95 ; 46 Waterfall                             ; LR
.byte $D8 ; 47 Temple of Fiends roof left            ; LR
.byte $DA ; 48 Temple of Fiends roof right           ; LR
.byte $F1 ; 49 Enter Coneria                         ; LR
.byte $92 ; 4A Enter Pravoka                         ; LR
.byte $B0 ; 4B Town Wall middle grass-/              ; LR
.byte $F5 ; 4C Enter Elfland                         ; LR
.byte $73 ; 73 Enter Melmond                         ; LR
.byte $B2 ; 4E Enter Crescent Lake                   ; LR
.byte $01 ; 4F Town wall middle \-grass              ; LR
.byte $09 ; 50 River BL                              ; LR
.byte $3B ; 51 River BR                              ; LR
.byte $50 ; 52 Desert BL                             ; LR
.byte $01 ; 53 Desert BR                             ; LR
.byte $84 ; 54 Plains                                ; LR
.byte $55 ; 55 Marsh                                 ; LR
.byte $F6 ; 56 Temple of Fiends grass/pavement left  ; LR
.byte $F8 ; 57 Enter Temple of Fiends Left           ; LR
.byte $FA ; 58 Enter Temple of Fiends right          ; LR
.byte $01 ; 59 Temple of Fiends pavement/grass right ; LR
.byte $F3 ; 5A Enter Gaia                            ; LR
.byte $C6 ; 5B Town Wall less grass-/                ; LR
.byte $D0 ; 5C Town wall grass-curve left            ; LR
.byte $F3 ; 5D Enter Onrac                           ; LR
.byte $01 ; 5E Town wall curve-grass right           ; LR
.byte $93 ; 5F Town wall \-less grass                ; LR
.byte $84 ; 60 Plains UL                             ; LR
.byte $75 ; 61 Plains UR                             ; LR
.byte $55 ; 62 Marsh UL                              ; LR
.byte $55 ; 63 Marsh UR                              ; LR
.byte $17 ; 64 Volcano top left  (enter)             ; LR
.byte $19 ; 65 Volcano top right (enter)             ; LR
.byte $59 ; 66 Cardia Cave 2                         ; LR
.byte $59 ; 67 Cardia Cave 3                         ; LR
.byte $59 ; 68 Cardia Cave 4                         ; LR
.byte $59 ; 69 Cardia Cave 5                         ; LR
.byte $59 ; 6A Cardia Cave 1                         ; LR
.byte $C6 ; 6B Town Wall /-pavement left             ; LR
.byte $59 ; 6C Enter Bahamut's room                  ; LR
.byte $F1 ; 6D Enter Leifen                          ; LR
.byte $59 ; 6E Enter Marsh Cave                      ; LR
.byte $B3 ; 6F Town Wall pavement-\ right            ; LR
.byte $74 ; 70 Plains BL                             ; LR
.byte $65 ; 71 Plains BR                             ; LR
.byte $55 ; 72 Marsh BL                              ; LR
.byte $57 ; 73 Marsh BR                              ; LR
.byte $37 ; 74 Volcano bottom left                   ; LR
.byte $39 ; 75 Volcano bottom right                  ; LR
.byte $01 ; 76 Grass, no fight                       ; LR
.byte $06 ; 77 Docks, BR                             ; LR
.byte $06 ; 78 Docks, bottom                         ; LR
.byte $01 ; 79 Docks, BL                             ; LR
.byte $01 ; 7A Docks, UR                             ; LR
.byte $D1 ; 7B Town Wall curve left                  ; LR
.byte $D1 ; 7C Town wall bottom                      ; LR
.byte $D2 ; 7D Town Wall gate left                   ; LR
.byte $D1 ; 7E Town wall gate right                  ; LR
.byte $D3 ; 7F Town wall curve right                 ; LR

; 00 = palette 1, greys
; 55 = palette 2, browns
; AA = palette 3, blues
; FF = palette 4, greens


; world map palette assignments
.byte $FF ; 00 Plain grass                         
.byte $00 ; 01 Enter coneria Castle Left           
.byte $00 ; 02 Enter coneria Castle Right          
.byte $FF ; 03 Forest UL                           
.byte $FF ; 04 Forest top                          
.byte $FF ; 05 Forest UR                           
.byte $AA ; 06 Ocean UL                            
.byte $AA ; 07 Ocean top                           
.byte $AA ; 08 Ocean UR                            
.byte $00 ; 09 Big Castle top left                 
.byte $00 ; 0A Big Castle top right                
.byte $00 ; 0B Small castle top left               
.byte $00 ; 0C Small castle rop right              
.byte $55 ; 0D Desert tower top                    
.byte $55 ; 0E Earth Cave entrance                 
.byte $00 ; 0F Dock, left side                     
.byte $55 ; 10 Cave UL                             
.byte $55 ; 11 Cave top                            
.byte $55 ; 12 Cave UR                             
.byte $FF ; 13 Forest Left                         
.byte $FF ; 14 Forst Middle                        
.byte $FF ; 15 Forest Right                        
.byte $AA ; 16 Ocean left                          
.byte $AA ; 17 Ocean middle                        
.byte $AA ; 18 Ocean right                         
.byte $00 ; 19 Big castle middle left              
.byte $00 ; 1A Big castle middle right             
.byte $00 ; 1B Enter Flfland Castle                
.byte $00 ; 1C Enter Elfland Castle                
.byte $55 ; 1D Enter Desert tower                  
.byte $55 ; 1E Desert Tower shadow                 
.byte $00 ; 1F Docks, right side                   
.byte $55 ; 20 Cave left                           
.byte $55 ; 21 Cave middle                         
.byte $55 ; 22 Cave right                          
.byte $FF ; 23 Forest BL                           
.byte $FF ; 24 Forest bottom                       
.byte $FF ; 25 Forest BR                           
.byte $AA ; 26 Ocean BL                            
.byte $AA ; 27 Ocean bottom                        
.byte $AA ; 28 Ocean BR                            
.byte $00 ; 29 Enter Astos Castle Left             
.byte $00 ; 2A Enter Astos Castle right            
.byte $55 ; 2B Enter Ice Cave                      
.byte $00 ; 2C Town wall UL                        
.byte $00 ; 2D Town wall top                       
.byte $00 ; 2E Town wall UR                        
.byte $55 ; 2F Enter Dwarf Cave                    
.byte $55 ; 30 Cave BL                             
.byte $55 ; 31 Cave Bottom                         
.byte $55 ; 32 Enter Matoya's Cave                 
.byte $55 ; 33 Cave BR                             
.byte $55 ; 34 Enter Titan's Tunnel East           
.byte $55 ; 35 Enter Titan's Tunnel West           
.byte $55 ; 36 Desert Caravan shop                 
.byte $55 ; 37 Desert Raise airship                
.byte $00 ; 38 Enter Castle of Ordeals Left        
.byte $00 ; 39 Enter Castle of Ordeals Right       
.byte $55 ; 3A Enter Sarda's Cave                  
.byte $00 ; 3B Town Wall top grass-/               
.byte $00 ; 3C Town wall top /-pavement            
.byte $00 ; 3D Town pavement                       
.byte $00 ; 3E Town wall top pavement-\            
.byte $00 ; 3F Town wall top \-grass               
.byte $AA ; 40 River UL                            
.byte $AA ; 41 River UR                            
.byte $55 ; 42 Desert UL                           
.byte $55 ; 43 Desert UR                           
.byte $AA ; 44 River                               
.byte $55 ; 45 Desert                              
.byte $AA ; 46 Waterfall                           
.byte $00 ; 47 Temple of Fiends roof left          
.byte $00 ; 48 Temple of Fiends roof right         
.byte $00 ; 49 Enter Coneria                       
.byte $00 ; 4A Enter Pravoka                       
.byte $00 ; 4B Town Wall middle grass-/            
.byte $55 ; 4C Enter Elfland                       
.byte $55 ; 4D Enter Melmond                       
.byte $00 ; 4E Enter Crescent Lake                 
.byte $00 ; 4F Town wall middle \-grass            
.byte $AA ; 50 River BL                            
.byte $AA ; 51 River BR                            
.byte $55 ; 52 Desert BL                           
.byte $55 ; 53 Desert BR                           
.byte $FF ; 54 Plains                              
.byte $AA ; 55 Marsh                               
.byte $00 ; 56 Temple of Fiends grass/pavement left
.byte $00 ; 57 Enter Temple of Fiends Left         
.byte $00 ; 58 Enter Temple of Fiends right        
.byte $00 ; 59 Temple of Fiends pavement/grass right
.byte $00 ; 5A Enter Gaia                          
.byte $00 ; 5B Town Wall less grass-/              
.byte $00 ; 5C Town wall grass-curve left          
.byte $00 ; 5D Enter Onrac                         
.byte $00 ; 5E Town wall curve-grass right         
.byte $00 ; 5F Town wall \-less grass              
.byte $FF ; 60 Plains UL                           
.byte $FF ; 61 Plains UR                           
.byte $AA ; 62 Marsh UL                            
.byte $AA ; 63 Marsh UR                            
.byte $55 ; 64 Volcano top left  (enter)           
.byte $55 ; 65 Volcano top right (enter)           
.byte $FF ; 66 Cardia Cave 2                       
.byte $FF ; 67 Cardia Cave 3                       
.byte $FF ; 68 Cardia Cave 4                       
.byte $FF ; 69 Cardia Cave 5                       
.byte $FF ; 6A Cardia Cave 1                       
.byte $00 ; 6B Town Wall /-pavement left           
.byte $FF ; 6C Enter Bahamut's room                
.byte $00 ; 6D Enter Leifen                        
.byte $FF ; 6E Enter Marsh Cave                    
.byte $00 ; 6F Town Wall pavement-\ right          
.byte $FF ; 70 Plains BL                           
.byte $FF ; 71 Plains BR                           
.byte $AA ; 72 Marsh BL                            
.byte $AA ; 73 Marsh BR                            
.byte $55 ; 74 Volcano bottom left                 
.byte $55 ; 75 Volcano bottom right                
.byte $00 ; 76 Grass, no fight                     
.byte $00 ; 77 Docks, BR                           
.byte $00 ; 78 Docks, bottom                       
.byte $00 ; 79 Docks, BL                           
.byte $00 ; 7A Docks, UR                           
.byte $00 ; 7B Town Wall curve left                
.byte $00 ; 7C Town wall bottom                    
.byte $00 ; 7D Town Wall gate left                 
.byte $00 ; 7E Town wall gate right                
.byte $00 ; 7F Town wall curve right               

; world map palettes
.byte $0F,$1A,$10,$30 ; greys
.byte $0F,$1A,$18,$38 ; $27,$37 ; browns
.byte $0F,$1A,$31,$21 ; blues
.byte $0F,$1A,$29,$19 ; greens
.byte $0F,$0F,$12,$36
.byte $0F,$0F,$27,$36
.byte $0F,$0F,$27,$30
.byte $0F,$0F,$30,$1A

; Colors for index 2 of the map character palettes. The first is for the top
; half, and the second for the bottom.

lut_MapmanPalettes:
;      Clothes Top (usually hair)
;      |   Clothes Bottom
;      |   |   Skin Top
;      |   |   |   Skin Bottom
;      |   |   |   |
;      v   v   v   v 
.byte $16,$16,$36,$36 ; Fighter
.byte $17,$08,$38,$38 ; Thief
.byte $18,$21,$28,$28 ; BlackBelt
.byte $16,$16,$36,$36 ; RedMage
.byte $30,$30,$36,$36 ; WhiteMage
.byte $27,$12,$36,$36 ; BlackMage
.byte $16,$16,$36,$36 ; Unused Class 1
.byte $16,$16,$36,$36 ; Unused Class 2
.byte $16,$16,$36,$36 ; Knight
.byte $08,$08,$38,$38 ; Ninja
.byte $18,$21,$28,$28 ; Master
.byte $16,$16,$36,$36 ; RedWiz
.byte $16,$30,$36,$36 ; WhiteWiz
.byte $27,$13,$36,$36 ; BlackWiz
.byte $16,$16,$36,$36 ; Unused Class 3
.byte $16,$16,$36,$36 ; Unused Class 4

;; unused, but needed for padding

;.byte $00,$00,$00,$00,$00,$00,$00,$00
;.byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
.byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
.byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
;.byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00


;; Map tileset palette assignments
; Each byte is the palette map for one map tile (16x16 pixels)
; (each value is 2 bits, repeated 4 times for speed)
; must be on $400 byte bound - see padding above

;.align $400

lut_SMTilesetAttr: 
.byte $00,$00,$00,$55,$55,$55,$55,$55,$55,$55,$55,$55,$55,$55,$00,$00 ; Town
.byte $55,$55,$55,$55,$55,$55,$55,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
.byte $AA,$AA,$AA,$AA,$AA,$FF,$FF,$AA,$AA,$AA,$FF,$FF,$FF,$FF,$AA,$55
.byte $55,$55,$00,$00,$00,$FF,$FF,$FF,$55,$00,$FF,$AA,$00,$00,$FF,$FF
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$00,$AA,$FF,$FF,$FF,$FF,$FF,$FF,$FF
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$00,$FF,$55

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

;.byte $55,$55,$55,$55,$55,$55,$55,$55,$55,$00,$00,$00,$00,$00,$00,$00 ; Inside Town
;.byte $00,$00,$00,$00,$00,$00,$00,$00,$FF,$FF,$FF,$FF,$00,$00,$00,$00
;.byte $00,$00,$00,$00,$00,$00,$00,$00,$FF,$FF,$FF,$FF,$FF,$00,$00,$00
;.byte $AA,$AA,$AA,$AA,$AA,$AA,$FF,$FF,$FF,$AA,$AA,$FF,$AA,$AA,$00,$00
;.byte $55,$55,$55,$55,$55,$55,$55,$55,$55,$AA,$00,$00,$00,$00,$00,$00
;.byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
;.byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
;.byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00

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
; 09 - Can use Quest item here ; Item in +1 
; 0A - Can save/Rest here
; 0B - Grant Orb based on Map ID
; 0C - Requires 4 Orbs to Activate Teleport
; 0D - Requires CUBE to Activate Teleport
; 0E - Requires CROWN to Activate Teleport
; 0F - Horizontal Bridge = 
; 10 - Vertical Bridge ||
; 11 - Deep Water
; 12 - Water Access
; 13
; 14
; 15
; 16
; 17
; 18 
; 19 - Treasure Chest, First Table ; Chest ID in +1
; 1A - Treasure Chest, Second Table ; Chest ID in +1
; 1B - Restore HP           ; +1 = ID of restore message (DLGID_HPRESTORED)
; 1C - Restore MP           ; +1 = ID of restore message (DLGID_MPRESTORED)
; 1D - Restore HP/MP        ; +1 = ID of restore message (DLGID_HPMPRESTORED
; 1E - Revive from Death    ; +1 = ID of restore message (DLGID_REVIVED)
; 1F - Revive from Ailments ; +1 = ID of restore message (DLGID_AILMENTSCURED)

;; to save space with a jump table, I moved the interaction ones to the end, keeping the ones the player
;; will most likely move on at the front. This means that its necessary to set the "cannot walk" bit for
;; the tiles without a jump table entry! Thus, all original treasure chests are $99, and healing tiles
;; would be $Dx - can't step, unique dialogue + 1 




lut_SMTilesetProp:

; Town
.byte $00,$00 ; 00 Grass
.byte $00,$00 ; 01 Grass - left side in dark shade
.byte $00,$00 ; 02 Grass - left side in dark shade, shade end
.byte $80,$00 ; 03 Wall
.byte $80,$00 ; 04 Wall
.byte $80,$00 ; 05 Wall
.byte $80,$00 ; 06 Wall - left side end
.byte $80,$00 ; 07 Wall - middle
.byte $80,$00 ; 08 Wall - right side end
.byte $80,$00 ; 09 Wall - right side in shade
.byte $80,$00 ; 0A Vertical wall - left side grass
.byte $80,$00 ; 0B Vertical wall - right side grass, shade top end
.byte $80,$00 ; 0C Vertical wall - right side shade
.byte $80,$00 ; 0D Vertical wall - bottom corner, right side shade, bottom is grass
.byte $80,$00 ; 0E Tree
.byte $80,$00 ; 0F Two trees/bush
.byte $00,$00 ; 10 Cobbles
.byte $00,$00 ; 11 Cobbles, curved upper left corner
.byte $00,$00 ; 12 Cobbles, curved upper right corner
.byte $00,$00 ; 13 Cobbles, curved lower left corner
.byte $00,$00 ; 14 Cobbles, curved lower right corner
.byte $00,$00 ; 15 Cobbles, lower left corner in shade
.byte $00,$00 ; 16 Cobbles, upper left corner in shade, lower left in shade end piece
.byte $80,$00 ; 17 Roof tile, back side
.byte $80,$00 ; 18 Roof tile continuous
.byte $80,$00 ; 19 Roof tile, back side
.byte $80,$00 ; 1A Clinic sign
.byte $80,$00 ; 1B Roof gable
.byte $80,$00 ; 1C Hat-shaped window
.byte $80,$00 ; 1D Two small windows
.byte $04,$01 ; 1E Door - Coneria Weapons
.byte $04,$02 ; 1F Door - Pravoka Weapons
.byte $80,$00 ; 20 Item sign
.byte $80,$00 ; 21 Weapon sign
.byte $80,$00 ; 22 Shield sign
.byte $80,$00 ; 23 W. magic sig
.byte $80,$00 ; 24 B. magic sign
.byte $80,$00 ; 25 Inn sign
.byte $04,$03 ; 26 Door - Elfland Weapons
.byte $11,$00 ; 27 Water
.byte $11,$00 ; 28 Water, left side shade
.byte $11,$00 ; 29 Water, left side shade with end piece
.byte $0F,$00 ; 2A Bridge =
.byte $10,$00 ; 2B Bridge ||
.byte $12,$00 ; 2C Steps
.byte $04,$04 ; 2D Door - Melmond Weapons
.byte $C0,$E6 ; 2E Fountain (come wash your face)
.byte $C0,$EE ; 2F Grave (This is a tomb.)
.byte $80,$00 ; 30 Fence
.byte $C0,$EF ; 31 Well (Ordinary well dialogue.)
.byte $00,$00 ; 32 Sand
.byte $00,$00 ; 33 Sandy Grass
.byte $80,$00 ; 34 Palm trees
.byte $06,$00 ; 35 Stairs - Door Closer
.byte $04,$05 ; 36 Door - Crescent Lake Weapons
.byte $00,$00 ; 37 Opened door
.byte $06,$00 ; 38 Cobbles - Door Closer
.byte $06,$00 ; 39 Grass - Door Closer
.byte $06,$00 ; 3A Bridge || - Door Closer
.byte $C0,$F7 ; 3B Water (At the bottom of the spring, something is flowing.)
.byte $06,$00 ; 3C Sand - Door Closer
.byte $06,$00 ; 3D Sandy Grass - Door Closer
.byte $04,$06 ; 3E Door - Gaia Weapon
.byte $04,$07 ; 3F Door - unused weapon shop
.byte $04,$08 ; 40 Door - unused weapon shop
.byte $04,$09 ; 41 Door - unused weapon shop
.byte $04,$0A ; 42 Door - unused weapon shop
.byte $04,$10 ; 43 Door - Coneria Armor
.byte $04,$11 ; 44 Door - Pravoka Armor
.byte $04,$12 ; 45 Door - Elfland Armor
.byte $04,$13 ; 46 Door - Melmond Armor
.byte $01,$00 ; 47 Grass (teleport?)
.byte $02,$20 ; 48 Submarine (teleport to underwater shrine)
.byte $04,$14 ; 49 Door - LakeArmor     
.byte $04,$15 ; 4A Door - GaiaArmor     
.byte $04,$16 ; 4B Door - Unused armor Shop    
.byte $04,$17 ; 4C Door - Unused armor Shop    
.byte $04,$18 ; 4D Door - Unused armor Shop     
.byte $04,$19 ; 4E Door - Unused armor Shop    
.byte $04,$20 ; 4F Door - ConeriaWMagic
.byte $04,$21 ; 50 Door - ProvokaWMagic 
.byte $04,$22 ; 51 Door - ElflandWMagic 
.byte $04,$23 ; 52 Door - MelmondWMagic 
.byte $04,$24 ; 53 Door - LakeWMagic    
.byte $04,$25 ; 54 Door - ElflandWMagic2
.byte $04,$26 ; 55 Door - GaiaWMagic    
.byte $04,$27 ; 56 Door - GaiaWMagic2   
.byte $04,$28 ; 57 Door - OnracWMagic   
.byte $04,$29 ; 58 Door - LeifenWMagic  
.byte $04,$30 ; 59 Door - ConeriaBMagic
.byte $04,$31 ; 5A Door - ProvokaBMagic 
.byte $04,$32 ; 5B Door - ElflandBMagic 
.byte $04,$33 ; 5C Door - MelmondBMagic 
.byte $04,$34 ; 5D Door - LakeBMagic    
.byte $04,$35 ; 5E Door - ElflandBMagic2
.byte $04,$36 ; 5F Door - GaiaBMagic    
.byte $04,$37 ; 60 Door - GaiaBMagic2   
.byte $04,$38 ; 61 Door - OnracBMagic   
.byte $04,$39 ; 62 Door - LeifenBMagic  
.byte $04,$50 ; 63 Door - ConeriaTemple
.byte $04,$50 ; 64 Door - ElflandTemple 
.byte $04,$50 ; 65 Door - LakeTemple    
.byte $04,$50 ; 66 Door - GaiaTemple    
.byte $04,$50 ; 67 Door - OnracTemple   
.byte $04,$50 ; 68 Door - ProvokaTemple 
.byte $04,$50 ; 69 Door - UnusedShop    
.byte $04,$50 ; 6A Door - UnusedShop    
.byte $04,$50 ; 6B Door - UnusedShop    
.byte $04,$50 ; 6C Door - UnusedShop    
.byte $04,$60 ; 6D Door - ConeriaInn   
.byte $04,$60 ; 6E Door - ProvokaInn    
.byte $04,$60 ; 6F Door - ElflandInn    
.byte $04,$60 ; 70 Door - MelmondInn    
.byte $04,$60 ; 71 Door - LakeInn       
.byte $04,$60 ; 72 Door - GaiaInn       
.byte $04,$60 ; 73 Door - OnracInn      
.byte $04,$60 ; 74 Door - UnusedShop    
.byte $04,$60 ; 75 Door - UnusedShop    
.byte $04,$60 ; 76 Door - UnusedShop    
.byte $04,$40 ; 77 Door - ConeriaItem  
.byte $04,$41 ; 78 Door - ProvokaItem   
.byte $04,$42 ; 79 Door - ElflandItem   
.byte $04,$43 ; 7A Door - LakeItem      
.byte $04,$44 ; 7B Door - GaiaItem      
.byte $04,$45 ; 7C Door - OnracItem     
.byte $9A,$01 ; 7D Tree - Treasure Table 2
.byte $80,$00 ; 7E Dark Water
.byte $C0,$DB ; 7F Grave (special) 

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
.byte $0E,$16 ; In room, Crown-required throne seat
.byte $0E,$18 ; In room, Crown-required throne seat
.byte $99,$01 ; In room, Treasure
.byte $99,$02 ; In room, Treasure
.byte $99,$03 ; In room, Treasure
.byte $99,$04 ; In room, Treasure
.byte $99,$05 ; In room, Treasure
.byte $99,$06 ; In room, Treasure
.byte $99,$0D ; In room, Treasure
.byte $99,$0E ; In room, Treasure
.byte $99,$0F ; In room, Treasure
.byte $99,$10 ; In room, Treasure
.byte $99,$11 ; In room, Treasure
.byte $99,$12 ; In room, Treasure
.byte $99,$13 ; In room, Treasure
.byte $99,$7B ; In room, Treasure
.byte $99,$7C ; In room, Treasure
.byte $99,$7D ; In room, Treasure
.byte $99,$7E ; In room, Treasure
.byte $99,$7F ; In room, Treasure
.byte $99,$80 ; In room, Treasure
.byte $99,$81 ; In room, Treasure
.byte $99,$82 ; In room, Treasure
.byte $99,$83 ; In room, Treasure
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
.byte $4B,$F3 ; In room, Earth orb
.byte $03,$05 ; In room, Exit Earth Cave teleport
.byte $80,$00 ; In room, altar statue left
.byte $80,$00 ; In room, altar statue right
.byte $00,$00 ; In room, up-arrow floor
.byte $80,$00 ; In room, spiky stalagwossits
.byte $80,$00 ; In room, spiky stalagwossits alternate
.byte $03,$00 ; Stairs up - exit Titan cave east
.byte $03,$01 ; Stairs up - exit Titan cave west
.byte $4B,$F4 ; in room, Fire orb - $1A,$F4
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
.byte $99,$2E ; In room, treasure
.byte $99,$2F ; In room, treasure
.byte $99,$30 ; In room, treasure
.byte $99,$31 ; In room, treasure
.byte $99,$32 ; In room, treasure
.byte $99,$33 ; In room, treasure
.byte $99,$34 ; In room, treasure
.byte $99,$35 ; In room, treasure
.byte $99,$36 ; In room, treasure
.byte $99,$37 ; In room, treasure
.byte $99,$38 ; In room, treasure
.byte $99,$39 ; In room, treasure
.byte $99,$3A ; In room, treasure
.byte $99,$3B ; In room, treasure
.byte $99,$3C ; In room, treasure
.byte $99,$3D ; In room, treasure
.byte $99,$3E ; In room, treasure
.byte $99,$3F ; In room, treasure
.byte $99,$40 ; In room, treasure
.byte $99,$41 ; In room, treasure
.byte $99,$42 ; In room, treasure
.byte $99,$43 ; In room, treasure
.byte $99,$44 ; In room, treasure
.byte $99,$45 ; In room, treasure
.byte $99,$46 ; In room, treasure
.byte $99,$47 ; In room, treasure
.byte $99,$48 ; In room, treasure
.byte $99,$49 ; In room, treasure
.byte $99,$4A ; In room, treasure
.byte $99,$4B ; In room, treasure
.byte $99,$4C ; In room, treasure
.byte $99,$4D ; In room, treasure
.byte $99,$4E ; In room, treasure
.byte $99,$4F ; In room, treasure
.byte $99,$50 ; In room, treasure
.byte $99,$51 ; In room, treasure
.byte $99,$52 ; In room, treasure
.byte $99,$53 ; In room, treasure
.byte $99,$54 ; In room, treasure
.byte $99,$55 ; In room, treasure
.byte $99,$56 ; In room, treasure
.byte $99,$57 ; In room, treasure
.byte $99,$58 ; In room, treasure
.byte $99,$59 ; In room, treasure
.byte $99,$5A ; In room, treasure
.byte $99,$5B ; In room, treasure
.byte $99,$5C ; In room, treasure
.byte $99,$5D ; In room, treasure
.byte $99,$5E ; In room, treasure
.byte $99,$5F ; In room, treasure
.byte $99,$60 ; In room, treasure
.byte $99,$61 ; In room, treasure
.byte $99,$62 ; In room, treasure
.byte $99,$63 ; In room, treasure
.byte $99,$64 ; In room, treasure
.byte $99,$65 ; In room, treasure
.byte $99,$66 ; In room, treasure
.byte $99,$67 ; In room, treasure
.byte $99,$68 ; In room, treasure
.byte $99,$69 ; In room, treasure
.byte $99,$6A ; In room, treasure
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
.byte $99,$21 ; In room, Treasure
.byte $99,$22 ; In room, Treasure
.byte $99,$23 ; In room, Treasure
.byte $99,$24 ; In room, Treasure
.byte $99,$25 ; In room, Treasure
.byte $99,$26 ; In room, Treasure
.byte $99,$27 ; In room, Treasure
.byte $99,$28 ; In room, Treasure
.byte $99,$29 ; In room, Treasure
.byte $99,$2A ; In room, Treasure
.byte $99,$2B ; In room, Treasure
.byte $99,$2C ; In room, Treasure
.byte $99,$2D ; In room, Treasure
.byte $99,$6B ; In room, Treasure
.byte $99,$6C ; In room, Treasure
.byte $99,$6D ; In room, Treasure
.byte $99,$6E ; In room, Treasure
.byte $99,$6F ; In room, Treasure
.byte $99,$70 ; In room, Treasure
.byte $99,$71 ; In room, Treasure
.byte $99,$72 ; In room, Treasure
.byte $99,$73 ; In room, Treasure
.byte $99,$74 ; In room, Treasure
.byte $99,$75 ; In room, Treasure
.byte $99,$76 ; In room, Treasure
.byte $99,$77 ; In room, Treasure
.byte $99,$78 ; In room, Treasure
.byte $99,$79 ; In room, Treasure
.byte $99,$7A ; In room, Treasure
.byte $99,$84 ; In room, Treasure
.byte $99,$85 ; In room, Treasure
.byte $99,$86 ; In room, Treasure
.byte $99,$87 ; In room, Treasure
.byte $99,$88 ; In room, Treasure
.byte $99,$89 ; In room, Treasure
.byte $99,$8A ; In room, Treasure
.byte $99,$8B ; In room, Treasure
.byte $99,$8C ; In room, Treasure
.byte $99,$8D ; In room, Treasure
.byte $99,$8E ; In room, Treasure
.byte $99,$8F ; In room, Treasure
.byte $99,$90 ; In room, Treasure
.byte $99,$91 ; In room, Treasure
.byte $99,$92 ; In room, Treasure
.byte $99,$93 ; In room, Treasure
.byte $99,$94 ; In room, Treasure
.byte $99,$B5 ; In room, Treasure
.byte $99,$B6 ; In room, Treasure
.byte $99,$B7 ; In room, Treasure
.byte $99,$B8 ; In room, Treasure
.byte $99,$B9 ; In room, Treasure
.byte $99,$BA ; In room, Treasure
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
.byte $0D,$2B ; In room, Cube-required teleport
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
.byte $99,$14 ; In room, Treasure
.byte $99,$15 ; In room, Treasure
.byte $99,$16 ; In room, Treasure
.byte $99,$17 ; In room, Treasure
.byte $99,$18 ; In room, Treasure
.byte $99,$19 ; In room, Treasure
.byte $99,$1A ; In room, Treasure
.byte $99,$1B ; In room, Treasure
.byte $99,$1C ; In room, Treasure
.byte $99,$1D ; In room, Treasure
.byte $99,$1E ; In room, Treasure
.byte $99,$1F ; In room, Treasure
.byte $99,$20 ; In room, Treasure
.byte $99,$C4 ; In room, Treasure
.byte $99,$C5 ; In room, Treasure
.byte $99,$C6 ; In room, Treasure
.byte $99,$C7 ; In room, Treasure
.byte $99,$C8 ; In room, Treasure
.byte $99,$C9 ; In room, Treasure
.byte $99,$CA ; In room, Treasure
.byte $99,$CB ; In room, Treasure
.byte $99,$CC ; In room, Treasure
.byte $99,$CD ; In room, Treasure
.byte $99,$CE ; In room, Treasure
.byte $99,$CF ; In room, Treasure
.byte $99,$D0 ; In room, Treasure
.byte $99,$D1 ; In room, Treasure
.byte $99,$D2 ; In room, Treasure
.byte $99,$D3 ; In room, Treasure
.byte $99,$D4 ; In room, Treasure
.byte $99,$D5 ; In room, Treasure
.byte $99,$BB ; In room, Treasure
.byte $99,$BC ; In room, Treasure
.byte $99,$BD ; In room, Treasure
.byte $99,$BE ; In room, Treasure
.byte $99,$BF ; In room, Treasure
.byte $99,$C0 ; In room, Treasure
.byte $99,$C1 ; In room, Treasure
.byte $99,$C2 ; In room, Treasure
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
.byte $4B,$F5 ; In room, Water orb altar
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
.byte $0C,$01 ; In room, Time warp - teleport to Temple of Fiends past
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
.byte $99,$07 ; In room, Treasure
.byte $99,$08 ; In room, Treasure
.byte $99,$09 ; In room, Treasure
.byte $99,$0A ; In room, Treasure
.byte $99,$0B ; In room, Treasure
.byte $99,$0C ; In room, Treasure
.byte $99,$95 ; In room, Treasure
.byte $99,$96 ; In room, Treasure
.byte $99,$97 ; In room, Treasure
.byte $99,$98 ; In room, Treasure
.byte $99,$99 ; In room, Treasure
.byte $99,$9A ; In room, Treasure
.byte $99,$9B ; In room, Treasure
.byte $99,$9C ; In room, Treasure
.byte $99,$9D ; In room, Treasure
.byte $99,$9E ; In room, Treasure
.byte $99,$9F ; In room, Treasure
.byte $99,$A0 ; In room, Treasure
.byte $99,$A1 ; In room, Treasure
.byte $99,$A2 ; In room, Treasure
.byte $99,$A3 ; In room, Treasure
.byte $99,$A4 ; In room, Treasure
.byte $99,$A5 ; In room, Treasure
.byte $99,$A6 ; In room, Treasure
.byte $99,$A7 ; In room, Treasure
.byte $99,$A8 ; In room, Treasure
.byte $99,$A9 ; In room, Treasure
.byte $99,$AA ; In room, Treasure
.byte $99,$AB ; In room, Treasure
.byte $99,$AC ; In room, Treasure
.byte $99,$AD ; In room, Treasure
.byte $99,$AE ; In room, Treasure
.byte $99,$AF ; In room, Treasure
.byte $99,$B0 ; In room, Treasure
.byte $99,$B1 ; In room, Treasure
.byte $99,$B2 ; In room, Treasure
.byte $99,$B3 ; In room, Treasure
.byte $99,$B4 ; In room, Treasure
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
.byte $4B,$F6 ; In room, Air Orb altar
.byte $80,$00 ; In room, Air Orb altar statue right
.byte $80,$00 ; In room, broken robot
.byte $C0,$F8 ; In room, machinery "Tiamat is the fiend of wind..."
.byte $C0,$F8 ; In room, machinery "Tiamat is the fiend of wind..."
.byte $C0,$F8 ; In room, machinery "Tiamat is the fiend of wind..."
.byte $C0,$F8 ; In room, machinery "Tiamat is the fiend of wind..."
.byte $C0,$F8 ; In room, machinery "Tiamat is the fiend of wind..."
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
.byte $99,$D6 ; In room, Treasure
.byte $99,$D7 ; In room, Treasure
.byte $99,$D8 ; In room, Treasure
.byte $99,$D9 ; In room, Treasure
.byte $99,$DA ; In room, Treasure
.byte $99,$DB ; In room, Treasure
.byte $99,$DC ; In room, Treasure
.byte $99,$DD ; In room, Treasure
.byte $99,$DE ; In room, Treasure
.byte $99,$DF ; In room, Treasure
.byte $99,$E0 ; In room, Treasure
.byte $99,$E1 ; In room, Treasure
.byte $99,$E2 ; In room, Treasure
.byte $99,$E3 ; In room, Treasure
.byte $99,$E4 ; In room, Treasure
.byte $99,$E5 ; In room, Treasure
.byte $99,$E6 ; In room, Treasure
.byte $99,$E7 ; In room, Treasure
.byte $99,$E8 ; In room, Treasure
.byte $99,$E9 ; In room, Treasure
.byte $99,$EA ; In room, Treasure
.byte $99,$EB ; In room, Treasure
.byte $99,$EC ; In room, Treasure
.byte $99,$ED ; In room, Treasure
.byte $99,$EE ; In room, Treasure
.byte $99,$EF ; In room, Treasure
.byte $99,$F0 ; In room, Treasure
.byte $99,$F1 ; In room, Treasure
.byte $99,$F2 ; In room, Treasure
.byte $99,$F3 ; In room, Treasure
.byte $99,$F4 ; In room, Treasure
.byte $99,$F5 ; In room, Treasure
.byte $99,$F6 ; In room, Treasure
.byte $99,$F7 ; In room, Treasure
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
.byte $09,LUTE ; In room, Use Lute here
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
.byte $99,$F8 ; In room, Treasure
.byte $99,$F9 ; In room, Treasure
.byte $99,$FA ; In room, Treasure
.byte $99,$FB ; In room, Treasure
.byte $99,$FC ; In room, Treasure
.byte $99,$FD ; In room, Treasure
.byte $99,$FE ; In room, Treasure
.byte $99,$FF ; In room, Treasure
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

; Inside Town  ; 
;.byte $80,$00 ; In room, upper left corner 
;.byte $90,$00 ; In room, back wall
;.byte $80,$00 ; In room, upper right corner
;.byte $80,$00 ; In room, left wall
;.byte $00,$00 ; In room, middle floor
;.byte $80,$00 ; In room, right wall 
;.byte $80,$00 ; In room, lower left corner
;.byte $00,$00 ; In room, bottom wall
;.byte $80,$00 ; In room, lower right corner
;.byte $00,$00 ; Blank floor
;.byte $00,$00 ; In room, Ladder bottom
;.byte $00,$00 ; Blank floor
;.byte $00,$00 ; In room, useless corner piece thing
;.byte $80,$00 ; In room, candlestick
;.byte $40,$B3 ; In room, Sword
;.byte $00,$00 ; In room, Chair
;.byte $80,$00 ; In room, Table
;.byte $80,$00 ; In room, Fireplace
;.byte $80,$00 ; In room, small, large urns
;.byte $00,$00 ; In room, Skull
;.byte $00,$00 ; In room, bed top
;.byte $00,$00 ; In room, bed body
;.byte $80,$00 ; In room, anvil
;.byte $80,$00 ; In room, hammer
;.byte $01,$00 ; Stairs up - warp to last map
;.byte $02,$11 ; Stairs up - Ice Cave 3
;.byte $02,$13 ; Stairs up - Ice Cave 5
;.byte $03,$02 ; Stairs up - Exit Ice Cave
;.byte $00,$00 ; Blank floor
;.byte $00,$00 ; Blank floor
;.byte $00,$00 ; Blank floor
;.byte $00,$00 ; Blank floor
;.byte $00,$00 ; Blank floor
;.byte $00,$00 ; Blank floor
;.byte $00,$00 ; Blank floor
;.byte $00,$00 ; Blank floor
;.byte $00,$00 ; Blank floor
;.byte $00,$00 ; Blank floor
;.byte $00,$00 ; Blank floor
;.byte $00,$00 ; Blank floor
;.byte $01,$00 ; Stairs down - warp to last map
;.byte $02,$0F ; Stairs down - Ice Cave 1
;.byte $02,$10 ; Stairs down - Ice Cave 2
;.byte $02,$14 ; Stairs down - Ice Cave 6
;.byte $02,$19 ; Stairs down - Bahamut's Room
;.byte $02,$12 ; In room, Hole - Ice Cave 4
;.byte $02,$15 ; In room, Hole - Ice Cave 7
;.byte $00,$00 ; Blank floor
;.byte $80,$00 ; Back Wall
;.byte $00,$00 ; Cave floor
;.byte $80,$00 ; Wall left side
;.byte $80,$00 ; Wall right side
;.byte $80,$00 ; Back wall left side
;.byte $80,$00 ; Back wall right side
;.byte $04,$00 ; Closed door, opens rooms
;.byte $00,$00 ; Open door
;.byte $80,$00 ; Well
;.byte $07,$00 ; Damage tile, Ice
;.byte $06,$00 ; Cave floor, closes doors
;.byte $45,$BF ; Closed door (locked)
;.byte $00,$00 ; Blank floor
;.byte $80,$00 ; Cave filler
;.byte $00,$00 ; Blank floor
;.byte $00,$00 ; Blank floor
;.byte $08,$2C ; In room, bottom wall, Battle 
;.byte $08,$2D ; In room, Battle 
;.byte $08,$2E ; In room, Battle 
;.byte $08,$2F ; In room, Battle 
;.byte $08,$30 ; In room, bottom wall, Battle 
;.byte $08,$69 ; In room, Battle 
;.byte $08,$80 ; In room, Random encounters
;.byte $08,$00 ; In room, Battle 
;.byte $08,$4A ; In room, bottom wall, Battle 
;.byte $08,$80 ; Cave floor, Random encounters
;.byte $00,$00 ; Blank floor
;.byte $99,$21 ; In room, Treasure
;.byte $99,$22 ; In room, Treasure
;.byte $99,$23 ; In room, Treasure
;.byte $99,$24 ; In room, Treasure
;.byte $99,$25 ; In room, Treasure
;.byte $99,$26 ; In room, Treasure
;.byte $99,$27 ; In room, Treasure
;.byte $99,$28 ; In room, Treasure
;.byte $99,$29 ; In room, Treasure
;.byte $99,$2A ; In room, Treasure
;.byte $99,$2B ; In room, Treasure
;.byte $99,$2C ; In room, Treasure
;.byte $99,$2D ; In room, Treasure
;.byte $99,$6B ; In room, Treasure
;.byte $99,$6C ; In room, Treasure
;.byte $99,$6D ; In room, Treasure
;.byte $99,$6E ; In room, Treasure
;.byte $99,$6F ; In room, Treasure
;.byte $99,$70 ; In room, Treasure
;.byte $99,$71 ; In room, Treasure
;.byte $99,$72 ; In room, Treasure
;.byte $99,$73 ; In room, Treasure
;.byte $99,$74 ; In room, Treasure
;.byte $99,$75 ; In room, Treasure
;.byte $99,$76 ; In room, Treasure
;.byte $99,$77 ; In room, Treasure
;.byte $99,$78 ; In room, Treasure
;.byte $99,$79 ; In room, Treasure
;.byte $99,$7A ; In room, Treasure
;.byte $99,$84 ; In room, Treasure
;.byte $99,$85 ; In room, Treasure
;.byte $99,$86 ; In room, Treasure
;.byte $99,$87 ; In room, Treasure
;.byte $99,$88 ; In room, Treasure
;.byte $99,$89 ; In room, Treasure
;.byte $99,$8A ; In room, Treasure
;.byte $99,$8B ; In room, Treasure
;.byte $99,$8C ; In room, Treasure
;.byte $99,$8D ; In room, Treasure
;.byte $99,$8E ; In room, Treasure
;.byte $99,$8F ; In room, Treasure
;.byte $99,$90 ; In room, Treasure
;.byte $99,$91 ; In room, Treasure
;.byte $99,$92 ; In room, Treasure
;.byte $99,$93 ; In room, Treasure
;.byte $99,$94 ; In room, Treasure
;.byte $99,$B5 ; In room, Treasure
;.byte $99,$B6 ; In room, Treasure
;.byte $99,$B7 ; In room, Treasure
;.byte $99,$B8 ; In room, Treasure
;.byte $99,$B9 ; In room, Treasure
;.byte $99,$BA ; In room, Treasure
;.byte $00,$00 ; Blank floor

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
.byte $24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$26,$0F,$58

.byte $01,$01,$01,$0D,$0D,$0D,$0C,$0C,$6F,$6D,$6C,$6F,$6D,$6D,$27,$27
.byte $0B,$0B,$4C,$0B,$0B,$0B,$0B,$03,$13,$48,$56,$2F,$07,$08,$25,$25
.byte $29,$4F,$4A,$63,$65,$67,$25,$0F,$0F,$0F,$2D,$69,$3B,$25,$41,$78
.byte $44,$43,$3A,$57,$23,$3B,$25,$21,$0B,$01,$69,$0F,$3A,$57,$25,$25
.byte $25,$25,$25,$25,$25,$25,$25,$01,$61,$25,$25,$25,$25,$25,$25,$25
.byte $25,$25,$25,$25,$25,$25,$25,$25,$25,$25,$25,$25,$25,$25,$25,$25
.byte $25,$25,$25,$25,$25,$25,$25,$25,$25,$25,$25,$25,$25,$25,$25,$25
.byte $25,$25,$25,$25,$25,$25,$25,$25,$25,$25,$25,$25,$25,$27,$0F,$78

.byte $11,$10,$02,$1C,$0E,$0E,$6F,$0E,$1D,$0E,$6F,$6E,$6E,$6F,$36,$26
.byte $1A,$1A,$1A,$5B,$1A,$09,$12,$13,$13,$45,$1E,$3E,$16,$18,$34,$34
.byte $38,$5E,$59,$72,$74,$2A,$34,$0F,$4D,$5D,$3C,$6A,$3B,$34,$50,$79
.byte $54,$52,$3A,$57,$32,$3B,$34,$30,$1A,$11,$6A,$0F,$3A,$57,$34,$34
.byte $34,$34,$34,$34,$34,$34,$34,$11,$70,$34,$34,$34,$34,$34,$34,$34
.byte $34,$34,$34,$34,$34,$34,$34,$34,$34,$34,$34,$34,$34,$34,$34,$34
.byte $34,$34,$34,$34,$34,$34,$34,$34,$34,$34,$34,$34,$34,$34,$34,$34
.byte $34,$34,$34,$34,$34,$34,$34,$34,$34,$34,$34,$34,$34,$36,$0F,$79

.byte $01,$01,$01,$0E,$0E,$1D,$1C,$0E,$6F,$6D,$6E,$6D,$6D,$6F,$37,$27
.byte $1B,$1B,$1B,$1B,$5C,$1B,$1B,$13,$13,$46,$1F,$3F,$17,$18,$35,$35
.byte $39,$5F,$5A,$73,$75,$2B,$35,$0F,$0F,$0F,$3D,$6B,$3B,$35,$51,$19
.byte $54,$53,$3A,$57,$33,$3B,$35,$31,$1B,$01,$6B,$0F,$3A,$57,$35,$35
.byte $35,$35,$35,$35,$35,$35,$35,$01,$71,$35,$35,$35,$35,$35,$35,$35
.byte $35,$35,$35,$35,$35,$35,$35,$35,$35,$35,$35,$35,$35,$35,$35,$35
.byte $35,$35,$35,$35,$35,$35,$35,$35,$35,$35,$35,$35,$35,$35,$35,$35
.byte $35,$35,$35,$35,$35,$35,$35,$35,$35,$35,$35,$35,$35,$37,$0F,$19

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

;.byte $03,$05,$05,$07,$09,$09,$07,$09,$09,$00,$2E,$00,$60,$40,$42,$44 ; Inside Town
;.byte $46,$48,$2C,$4A,$62,$64,$6A,$0F,$26,$26,$26,$26,$00,$00,$00,$00
;.byte $00,$00,$00,$00,$00,$00,$00,$00,$28,$28,$28,$28,$28,$4C,$4C,$00
;.byte $01,$0B,$0D,$0B,$20,$01,$22,$24,$66,$68,$0B,$22,$61,$4E,$00,$00
;.byte $09,$09,$09,$09,$09,$09,$09,$09,$09,$0B,$00,$2A,$2A,$2A,$2A,$2A
;.byte $2A,$2A,$2A,$2A,$2A,$2A,$2A,$2A,$2A,$2A,$2A,$2A,$2A,$2A,$2A,$2A
;.byte $2A,$2A,$2A,$2A,$2A,$2A,$2A,$2A,$2A,$2A,$2A,$2A,$2A,$2A,$2A,$2A
;.byte $2A,$2A,$2A,$2A,$2A,$2A,$2A,$2A,$2A,$2A,$2A,$2A,$2A,$2A,$2A,$00
;.byte $06,$06,$04,$09,$09,$08,$09,$09,$08,$00,$2F,$00,$0F,$41,$43,$45
;.byte $47,$49,$2D,$4B,$63,$65,$6B,$0F,$27,$27,$27,$27,$00,$00,$00,$00
;.byte $00,$00,$00,$00,$00,$00,$00,$00,$29,$29,$29,$29,$29,$4D,$4D,$00
;.byte $02,$0C,$0C,$0E,$02,$21,$23,$25,$67,$69,$0C,$23,$61,$4F,$00,$00
;.byte $09,$09,$09,$09,$09,$09,$09,$09,$09,$0C,$00,$2B,$2B,$2B,$2B,$2B
;.byte $2B,$2B,$2B,$2B,$2B,$2B,$2B,$2B,$2B,$2B,$2B,$2B,$2B,$2B,$2B,$2B
;.byte $2B,$2B,$2B,$2B,$2B,$2B,$2B,$2B,$2B,$2B,$2B,$2B,$2B,$2B,$2B,$2B
;.byte $2B,$2B,$2B,$2B,$2B,$2B,$2B,$2B,$2B,$2B,$2B,$2B,$2B,$2B,$2B,$00
;.byte $13,$15,$15,$17,$09,$09,$19,$0A,$0A,$00,$3E,$00,$70,$50,$52,$54
;.byte $56,$58,$3C,$5A,$72,$74,$6C,$6E,$36,$36,$36,$36,$00,$00,$00,$00
;.byte $00,$00,$00,$00,$00,$00,$00,$00,$38,$38,$38,$38,$38,$5C,$5C,$00
;.byte $11,$1B,$1D,$1B,$30,$11,$32,$34,$76,$78,$1B,$32,$61,$5E,$00,$00
;.byte $0A,$09,$09,$09,$0A,$09,$09,$09,$0A,$1B,$00,$3A,$3A,$3A,$3A,$3A
;.byte $3A,$3A,$3A,$3A,$3A,$3A,$3A,$3A,$3A,$3A,$3A,$3A,$3A,$3A,$3A,$3A
;.byte $3A,$3A,$3A,$3A,$3A,$3A,$3A,$3A,$3A,$3A,$3A,$3A,$3A,$3A,$3A,$3A
;.byte $3A,$3A,$3A,$3A,$3A,$3A,$3A,$3A,$3A,$3A,$3A,$3A,$3A,$3A,$3A,$00
;.byte $16,$16,$14,$09,$09,$18,$0A,$0A,$1A,$00,$3F,$00,$71,$51,$53,$55
;.byte $57,$59,$3D,$5B,$73,$75,$6D,$6F,$37,$37,$37,$37,$00,$00,$00,$00
;.byte $00,$00,$00,$00,$00,$00,$00,$00,$39,$39,$39,$39,$39,$5D,$5D,$00
;.byte $12,$1C,$1C,$1E,$12,$31,$33,$35,$77,$79,$1C,$33,$61,$5F,$00,$00
;.byte $0A,$09,$09,$09,$0A,$09,$09,$09,$0A,$1C,$00,$3B,$3B,$3B,$3B,$3B
;.byte $3B,$3B,$3B,$3B,$3B,$3B,$3B,$3B,$3B,$3B,$3B,$3B,$3B,$3B,$3B,$3B
;.byte $3B,$3B,$3B,$3B,$3B,$3B,$3B,$3B,$3B,$3B,$3B,$3B,$3B,$3B,$3B,$3B
;.byte $3B,$3B,$3B,$3B,$3B,$3B,$3B,$3B,$3B,$3B,$3B,$3B,$3B,$3B,$3B,$00



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

.byte $0F,$3B,$3B,$3B,$0F,$3B,$3B,$2B,$0F,$1B,$2B,$3B,$0F,$00,$01,$30 ; 3D ; Inside Town
.byte $0F,$0F,$12,$36,$0F,$0F,$27,$36,$60,$FF,$5E,$00,$BC,$00,$00,$00 
.byte $0F,$10,$00,$0F,$0F,$0F,$0B,$1B,$0F,$0B,$1B,$2B,$0F,$00,$01,$30 

.byte $0F,$3B,$3B,$3B,$0F,$3B,$3B,$2B,$0F,$1B,$2B,$3B,$0F,$00,$01,$30 ; 3E ; 
.byte $0F,$0F,$12,$36,$0F,$0F,$27,$36,$00,$00,$00,$00,$00,$00,$00,$00 
.byte $0F,$10,$00,$0F,$0F,$0F,$0B,$1B,$0F,$0B,$1B,$2B,$0F,$00,$01,$30 

.byte $FF,$FF,$FF,$FF,$FF,$FF,$03,$03,$03,$03,$03,$03,$03,$03,$FF,$FF ; 3F ; 
.byte $0F,$0F,$12,$36,$0F,$0F,$27,$36,$00,$00,$00,$00,$00,$00,$00,$00
.byte $7F,$7F,$7F,$7F,$7F,$7F,$60,$60,$60,$60,$60,$60,$60,$60,$FF,$FF


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Map sprite picture assignment

lut_MapObjGfx:
.byte $00 ; 00 ; Princess
.byte $0F ; 01 ; King
.byte $12 ; 02 ; Garland
.byte $00 ; 03 ; Princess
.byte $13 ; 04 ; Pirate
.byte $18 ; 05 ; Elf Woman (Doctor)
.byte $1A ; 06 ; Elf Prince
.byte $0F ; 07 ; King (Astos)
.byte $0C ; 08 ; Dwarf
.byte $0C ; 09 ; Dwarf
.byte $05 ; 0A ; Witch
.byte $08 ; 0B ; Scholar
.byte $1D ; 0C ; Vampire
.byte $0B ; 0D ; Sage
.byte $17 ; 0E ; Bahamut
.byte $14 ; 0F ; Fairy
.byte $01 ; 10 ; Woman
.byte $15 ; 11 ; Robot
.byte $00 ; 12 ; Princess
.byte $14 ; 13 ; Fairy
.byte $1C ; 14 ; Titan
.byte $0B ; 15 ; Sage 
.byte $1B ; 16 ; Slab
.byte $1B ; 17 ; Slab
.byte $12 ; 18 ; Garland
.byte $12 ; 19 ; Garland
.byte $12 ; 1A ; Garland
.byte $04 ; 1B ; Orb
.byte $04 ; 1C ; Orb
.byte $04 ; 1D ; Orb
.byte $04 ; 1E ; Orb
.byte $00 ; 1F ; Princess
.byte $07 ; 20 ; Soldier
.byte $07 ; 21 ; Soldier
.byte $01 ; 22 ; Woman
.byte $08 ; 23 ; Scholar
.byte $0B ; 24 ; Sage
.byte $07 ; 25 ; Soldier
.byte $01 ; 26 ; Woman  (invisible)
.byte $07 ; 27 ; Soldier
.byte $08 ; 28 ; Scholar
.byte $00 ; 29 ; Princess
.byte $00 ; 2A ; Princess
.byte $07 ; 2B ; Soldier
.byte $0B ; 2C ; Sage
.byte $07 ; 2D ; Soldier
.byte $0B ; 2E ; Sage
.byte $07 ; 2F ; Soldier
.byte $07 ; 30 ; Soldier
.byte $07 ; 31 ; Soldier
.byte $07 ; 32 ; Soldier
.byte $09 ; 33 ; Punk
.byte $0B ; 34 ; Sage
.byte $03 ; 35 ; Dancer
.byte $01 ; 36 ; Woman
.byte $02 ; 37 ; Old Lady
.byte $01 ; 38 ; Woman
.byte $0A ; 39 ; Man
.byte $11 ; 3A ; Bat (Sky Warrior)
.byte $11 ; 3B ; Bat (Sky Warrior)
.byte $11 ; 3C ; Bat (Sky Warrior)
.byte $11 ; 3D ; Bat (Sky Warrior)
.byte $11 ; 3E ; Bat (Sky Warrior)
.byte $0A ; 3F ; Man
.byte $0B ; 40 ; Sage
.byte $01 ; 41 ; Woman
.byte $09 ; 42 ; Punk
.byte $0A ; 43 ; Man
.byte $19 ; 44 ; Elf Man
.byte $19 ; 45 ; Elf Man
.byte $19 ; 46 ; Elf Man
.byte $19 ; 47 ; Elf Man
.byte $18 ; 48 ; Elf Woman
.byte $19 ; 49 ; Elf Man
.byte $19 ; 4A ; Elf Man
.byte $19 ; 4B ; Elf Man
.byte $19 ; 4C ; Elf Man
.byte $19 ; 4D ; Elf Man
.byte $19 ; 4E ; Elf Man
.byte $19 ; 4F ; Elf Man
.byte $19 ; 50 ; Elf Man
.byte $19 ; 51 ; Elf Man
.byte $19 ; 52 ; Elf Man
.byte $18 ; 53 ; Elf Woman
.byte $18 ; 54 ; Elf Woman
.byte $19 ; 55 ; Elf Man
.byte $19 ; 56 ; Elf Man
.byte $11 ; 57 ; Bat (all the normal bats)
.byte $0C ; 58 ; Dwarf
.byte $0C ; 59 ; Dwarf
.byte $0C ; 5A ; Dwarf
.byte $0C ; 5B ; Dwarf
.byte $0C ; 5C ; Dwarf
.byte $0C ; 5D ; Dwarf
.byte $0C ; 5E ; Dwarf
.byte $0C ; 5F ; Dwarf
.byte $0C ; 60 ; Dwarf
.byte $0C ; 61 ; Dwarf
.byte $0C ; 62 ; Dwarf
.byte $0C ; 63 ; Dwarf
.byte $10 ; 64 ; Broom
.byte $10 ; 65 ; Broom
.byte $10 ; 66 ; Broom
.byte $10 ; 67 ; Broom
.byte $0A ; 68 ; Man
.byte $0A ; 69 ; Man
.byte $0A ; 6A ; Man
.byte $0B ; 6B ; Sage
.byte $0A ; 6C ; Man
.byte $0A ; 6D ; Man
.byte $0B ; 6E ; Sage
.byte $0A ; 6F ; Man
.byte $0A ; 70 ; Man
.byte $0A ; 71 ; Man
.byte $01 ; 72 ; Woman
.byte $01 ; 73 ; Woman
.byte $0C ; 74 ; Dwarf
.byte $07 ; 75 ; Soldier
.byte $13 ; 76 ; Pirate
.byte $0B ; 77 ; Sage
.byte $0B ; 78 ; Sage
.byte $0B ; 79 ; Sage
.byte $0B ; 7A ; Sage
.byte $0B ; 7B ; Sage
.byte $0B ; 7C ; Sage
.byte $0B ; 7D ; Sage
.byte $0B ; 7E ; Sage
.byte $0B ; 7F ; Sage
.byte $0B ; 80 ; Sage
.byte $0A ; 81 ; Man
.byte $0B ; 82 ; Sage
.byte $01 ; 83 ; Woman
.byte $0B ; 84 ; Sage
.byte $16 ; 85 ; Dragon
.byte $16 ; 86 ; Dragon
.byte $16 ; 87 ; Dragon
.byte $16 ; 88 ; Dragon
.byte $16 ; 89 ; Dragon
.byte $16 ; 8A ; Dragon
.byte $16 ; 8B ; Dragon
.byte $16 ; 8C ; Dragon
.byte $16 ; 8D ; Dragon
.byte $16 ; 8E ; Dragon
.byte $16 ; 8F ; Dragon
.byte $16 ; 90 ; Dragon
.byte $16 ; 91 ; Dragon
.byte $16 ; 92 ; Dragon
.byte $01 ; 93 ; Woman
.byte $08 ; 94 ; Scholar
.byte $07 ; 95 ; Soldier
.byte $05 ; 96 ; Witch
.byte $03 ; 97 ; Dancer
.byte $09 ; 98 ; Punk
.byte $0B ; 99 ; Sage
.byte $0B ; 9A ; Sage
.byte $16 ; 9B ; Dragon
.byte $13 ; 9C ; Pirate
.byte $09 ; 9D ; Punk
.byte $01 ; 9E ; Woman
.byte $0A ; 9F ; Man
.byte $0A ; A0 ; Man
.byte $0A ; A1 ; Man
.byte $15 ; A2 ; Robot
.byte $0D ; A3 ; Mermaid
.byte $0D ; A4 ; Mermaid
.byte $0D ; A5 ; Mermaid
.byte $0D ; A6 ; Mermaid
.byte $0D ; A7 ; Mermaid
.byte $0D ; A8 ; Mermaid
.byte $0D ; A9 ; Mermaid
.byte $0D ; AA ; Mermaid
.byte $0D ; AB ; Mermaid
.byte $0D ; AC ; Mermaid
.byte $0D ; AD ; Mermaid
.byte $0A ; AE ; Man
.byte $08 ; AF ; Scholar
.byte $08 ; B0 ; Scholar
.byte $01 ; B1 ; Woman
.byte $03 ; B2 ; Dancer
.byte $08 ; B3 ; Scholar
.byte $0A ; B4 ; Man
.byte $0A ; B5 ; Man
.byte $13 ; B6 ; Pirate
.byte $0A ; B7 ; Man
.byte $10 ; B8 ; Broom
.byte $05 ; B9 ; Witch
.byte $02 ; BA ; Old Lady
.byte $0E ; BB ; Leifen
.byte $0E ; BC ; Leifen
.byte $0E ; BD ; Leifen
.byte $0E ; BE ; Leifen
.byte $0E ; BF ; Leifen
.byte $0E ; C0 ; Leifen
.byte $0E ; C1 ; Leifen
.byte $0E ; C2 ; Leifen
.byte $0E ; C3 ; Leifen
.byte $0E ; C4 ; Leifen
.byte $0E ; C5 ; Leifen
.byte $0E ; C6 ; Leifen
.byte $0E ; C7 ; Leifen
.byte $0E ; C8 ; Leifen
.byte $0E ; C9 ; Leifen
.byte $04 ; CA ; Orb
.byte $15 ; CB ; Robot
.byte $15 ; CC ; Robot
.byte $15 ; CD ; Robot
.byte $15 ; CE ; Robot
.byte $15 ; CF ; Robot
.byte $00 ; D0 ; no NPC exists
.byte $00 ; D1 ;
.byte $00 ; D2 ;
.byte $00 ; D3 ;
.byte $00 ; D4 ;
.byte $00 ; D5 ;
.byte $00 ; D6 ;
.byte $00 ; D7 ;
.byte $00 ; D8 ;
.byte $00 ; D9 ;
.byte $00 ; DA ;
.byte $00 ; DB ;
.byte $00 ; DC ;
.byte $00 ; DD ;
.byte $00 ; DE ;
.byte $00 ; DF ;
.byte $00 ; E0 ;
.byte $00 ; E1 ;
.byte $00 ; E2 ;
.byte $00 ; E3 ;
.byte $00 ; E4 ;
.byte $00 ; E5 ;
.byte $00 ; E6 ;
.byte $00 ; E7 ;
.byte $00 ; E8 ;
.byte $00 ; E9 ;
.byte $00 ; EA ;
.byte $00 ; EB ;
.byte $00 ; EC ;
.byte $00 ; ED ;
.byte $00 ; EE ;
.byte $00 ; EF ;
.byte $00 ; F0 ;
.byte $00 ; F1 ;
.byte $00 ; F2 ;
.byte $00 ; F3 ;
.byte $00 ; F4 ;
.byte $00 ; F5 ;
.byte $00 ; F6 ;
.byte $00 ; F7 ;
.byte $00 ; F8 ;
.byte $00 ; F9 ;
.byte $00 ; FA ;
.byte $00 ; FB ;
.byte $00 ; FC ;
.byte $00 ; FD ;
.byte $00 ; FE ;
.byte $00 ; FF ;





; Map sprites
; 3 bytes
;  +0: graphic (00 = no sprite)
;  +1: bits 0-5: X coordinate
;      bit  6:   don't move
;      bit  7:   "in room" flag
;  +2: Y coordinate

;.align $100 - Enable in case sprites in maps wig out

lut_MapObjects:

; 00 ; Coneria 
.byte $31,$10,$01 ; Townsfolk
.byte $32,$07,$0D
.byte $34,$44,$01
.byte $35,$0F,$0C
.byte $36,$12,$14
.byte $37,$05,$06
.byte $38,$1B,$05
.byte $39,$1E,$0B
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00

; 01 ; Pravoka 
.byte $04,$45,$07 ; Bikke
.byte $3F,$0D,$10 ; Townsfolk
.byte $3F,$0C,$03
.byte $3F,$18,$15
.byte $40,$1D,$08
.byte $41,$08,$0E
.byte $42,$13,$0B
.byte $43,$14,$19
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00

; 02 ; Elfland
.byte $4D,$25,$17 ; Elves
.byte $4E,$26,$01
.byte $4F,$1C,$0B
.byte $50,$58,$0F
.byte $51,$09,$0F
.byte $52,$0A,$06
.byte $53,$44,$05
.byte $54,$4F,$1B
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00

; 03 ; Melmond
.byte $0B,$1A,$01 ; Unne
.byte $68,$08,$03 ; Farmers'n such
.byte $69,$16,$03
.byte $6A,$15,$11
.byte $6B,$4C,$01
.byte $6C,$0E,$0D
.byte $6D,$0F,$16
.byte $6E,$5D,$12
.byte $6F,$18,$07
.byte $70,$18,$17
.byte $71,$1D,$09
.byte $72,$14,$1A
.byte $73,$16,$0C
.byte $74,$19,$0D
.byte $00,$00,$00
.byte $00,$00,$00

; 04 ; Crescent Lake  
.byte $15,$6A,$0A ; Dr. Canoe
.byte $77,$66,$0B ; Sages
.byte $78,$64,$0A
.byte $79,$63,$08
.byte $7A,$63,$06
.byte $7B,$64,$04
.byte $7C,$66,$03
.byte $7D,$68,$03
.byte $7E,$6A,$04
.byte $7F,$6B,$06
.byte $80,$6B,$08
.byte $81,$45,$01 ; Sleeping guy
.byte $82,$68,$0B
.byte $83,$10,$07 ; one of these is a lady and not a sage, maybe this one?
.byte $00,$00,$00
.byte $00,$00,$00

; 05 ; Gaia
.byte $13,$71,$13 ; Fairy
.byte $AE,$38,$3C ; Gaia townsfolk
.byte $AF,$29,$3B
.byte $B0,$3A,$29
.byte $B1,$0A,$34
.byte $B2,$26,$36
.byte $B3,$0C,$1F
.byte $B4,$1B,$2B
.byte $B5,$3A,$31
.byte $B6,$10,$10
.byte $B7,$17,$3B
.byte $B8,$29,$33
.byte $B9,$69,$31
.byte $BA,$17,$36
.byte $00,$00,$00
.byte $00,$00,$00

; 06 ; Onrac
.byte $10,$6D,$1E ; Submarine Engineer
.byte $93,$12,$18 
.byte $94,$09,$17
.byte $95,$15,$07
.byte $96,$5E,$15
.byte $97,$11,$0C
.byte $98,$14,$0C
.byte $99,$53,$03
.byte $9A,$6E,$17
.byte $9B,$11,$27
.byte $9C,$1A,$0E
.byte $9D,$1F,$0B
.byte $9E,$04,$17
.byte $9F,$29,$1B
.byte $A0,$1C,$04
.byte $00,$00,$00

; 07 ; Leifen
.byte $BB,$58,$15 ; Chime-giver
.byte $BC,$04,$08 ; Leifen peoples
.byte $BD,$53,$13
.byte $BE,$21,$08
.byte $BF,$50,$0A
.byte $C0,$1A,$0E
.byte $C1,$21,$0D
.byte $C2,$23,$16
.byte $C3,$09,$0F
.byte $C4,$56,$0A
.byte $C5,$06,$0A
.byte $C6,$1C,$12
.byte $C8,$0E,$14
.byte $C9,$07,$0D
.byte $00,$00,$00
.byte $00,$00,$00

;  +1: bits 0-5: X coordinate ; across: + 2 
;  +2: Y coordinate ; up/down: - 5

; 08 ; Conera Castle 1F
.byte $20,$50,$17 ; Guard near lower pillar 
.byte $20,$4C,$0D ; Guard near stairs
.byte $22,$04,$05
.byte $23,$0A,$06
.byte $25,$49,$17
.byte $26,$49,$0A ; Invisible lady
.byte $29,$C8,$13
.byte $2A,$93,$12
.byte $2C,$58,$04
.byte $2E,$50,$0A
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00

; 09 ; Elfland Castle 
.byte $05,$C9,$05 ; Elf Doctor
.byte $06,$C8,$06 ; Elf Prince
.byte $45,$41,$01 ; Elves
.byte $46,$17,$0E
.byte $47,$02,$18
.byte $48,$13,$04
.byte $49,$4F,$14
.byte $4A,$51,$14
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00

; 0A ; Northwest Castle 
.byte $07,$D0,$06 ; Astos
.byte $57,$16,$08 ; bats
.byte $57,$1C,$03
.byte $57,$04,$03
.byte $57,$13,$10
.byte $57,$0B,$0A
.byte $57,$04,$14
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00

; 0B ; Castle of Ordeals 1F
.byte $84,$4C,$0D ; Creepy vanishing sage
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00

; 0C ; Temple of Fiends (Present)
.byte $02,$D4,$15 ; Garland
.byte $03,$D4,$12 ; Princess
.byte $3A,$91,$13 ; Sky Warrior bats
.byte $3B,$92,$12
.byte $3C,$92,$13
.byte $3D,$97,$13
.byte $3E,$96,$13
.byte $CA,$D4,$11 ; Black orb
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00

; 0D ; Earth Cave B1
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00

; 0E ; Gurgu Volcano B1
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00

; 0F ; Ice Cave B1
;.byte $13,$6F,$1E ; surprise fairy!
.byte $00,$00,$00 ; fixed ^ 
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00

; 10 ; Cardia
.byte $85,$1C,$09 ; Dragons
.byte $86,$29,$06
.byte $87,$29,$16
.byte $88,$A6,$34
.byte $8A,$18,$1F
.byte $8B,$91,$25
.byte $8C,$25,$1E
.byte $8D,$0D,$06
.byte $8E,$95,$25
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00

; 11 ; Bahamut's Room B1
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00

; 12 ; Waterfall
.byte $11,$94,$35 ; must be robot
.byte $57,$08,$04 ; these are bats -- this one has been moved down 1 tile so as not to be in the wall
.byte $57,$0F,$17
.byte $57,$0A,$29
.byte $57,$17,$19
.byte $57,$19,$09
.byte $57,$28,$09
.byte $57,$21,$18
.byte $57,$32,$23
.byte $57,$2B,$29
.byte $57,$3A,$2C
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00

; 13 ; Dwarf Cave
.byte $08,$50,$2D ; TNT dwarf
.byte $09,$C7,$02 ; Blacksmith
.byte $58,$4E,$15 ; dwarves
.byte $59,$03,$0A
.byte $5A,$16,$11
.byte $5B,$0E,$07
.byte $5C,$D5,$04
.byte $5D,$02,$04
.byte $5E,$0A,$0F
.byte $5F,$0A,$13
.byte $60,$D3,$0E
.byte $61,$0D,$02
.byte $63,$12,$0A
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00

; 14 ; Matoya's Cave
.byte $0A,$C8,$01 ; Matoya
.byte $64,$03,$0D ; Brooms
.byte $65,$8B,$0A
.byte $66,$83,$07
.byte $67,$CD,$03
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00

; 15 ; Sarda's Cave
.byte $0D,$C2,$02 ;; Its Sarda!
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00

; 16 ; Marsh Cave B1
.byte $57,$04,$03 ; bats
.byte $57,$1E,$24 
.byte $57,$10,$15
.byte $57,$34,$16
.byte $57,$18,$1C
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00

; 17 ; Mirage Tower 1F
.byte $CE,$D4,$05 ; Robot
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00

; 18 ; Coneria Castle 2F
.byte $01,$CC,$04 ; King
.byte $12,$CB,$05 ; Princess
.byte $2B,$42,$1D ; Guards
.byte $30,$4D,$09
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00

; 19 ; Castle of Ordeals 2F
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00

; 1A ; Castle of Ordeals 3F
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00

; 1B ; Marsh Cave B2
.byte $57,$0E,$11 ; bats
.byte $57,$1B,$0B
.byte $57,$06,$10
.byte $57,$0F,$2D
.byte $57,$11,$33
.byte $57,$16,$30
.byte $57,$1D,$35
.byte $57,$22,$32
.byte $57,$26,$2B
.byte $57,$31,$1E
.byte $57,$36,$28
.byte $57,$2F,$28
.byte $57,$2E,$33
.byte $57,$3A,$38
.byte $00,$00,$00
.byte $00,$00,$00

; 1C ; Marsh Cave B3
.byte $57,$06,$0A ; all the bats
.byte $57,$1E,$08
.byte $57,$11,$10
.byte $57,$2C,$10
.byte $57,$2A,$1D
.byte $57,$33,$04
.byte $57,$2F,$22
.byte $57,$1F,$18
.byte $57,$1D,$20
.byte $57,$10,$1F
.byte $57,$02,$1E
.byte $57,$06,$2A
.byte $57,$05,$31
.byte $57,$14,$2D
.byte $57,$1E,$36
.byte $57,$1F,$2F

; 1D ; Earth Cave B2
.byte $57,$0A,$0B ; bats
.byte $57,$12,$0F
.byte $57,$0A,$15
.byte $57,$15,$16
.byte $57,$0F,$1F
.byte $57,$19,$24
.byte $57,$1B,$31
.byte $57,$21,$28
.byte $57,$1D,$19
.byte $57,$27,$16
.byte $57,$1F,$12
.byte $57,$A8,$10
.byte $57,$26,$29
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00

; 1E ; Earth Cave B3
.byte $0C,$DA,$26 ; Vampire
.byte $16,$5A,$1B ; Earth Plate
.byte $57,$8B,$09 ; bats
.byte $57,$8A,$0A
.byte $57,$89,$09
.byte $57,$0F,$10
.byte $57,$18,$0F
.byte $57,$11,$22
.byte $57,$11,$20
.byte $57,$12,$22
.byte $57,$1C,$12
.byte $57,$1A,$13
.byte $57,$23,$14
.byte $57,$27,$10
.byte $57,$2C,$0C
.byte $57,$2F,$0E

; 1F ; Earth Cave B4
.byte $57,$93,$28 ; baaats
.byte $57,$90,$26
.byte $57,$93,$24
.byte $57,$0A,$23
.byte $57,$0C,$2A
.byte $57,$18,$15
.byte $57,$16,$17
.byte $57,$13,$1B
.byte $57,$15,$0C
.byte $57,$12,$12
.byte $57,$A7,$0C
.byte $57,$20,$12
.byte $57,$24,$17
.byte $57,$21,$18
.byte $57,$24,$17
.byte $57,$21,$18

; 20 ; Earth Cave B5
.byte $1B,$CC,$2A ; Earth Orb
.byte $57,$11,$31 ; dang bats
.byte $57,$0F,$23
.byte $57,$1A,$25
.byte $57,$1E,$2E
.byte $57,$1F,$32
.byte $57,$20,$37
.byte $57,$24,$2A
.byte $57,$1C,$1F
.byte $57,$12,$18
.byte $57,$14,$1A
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00

; 21 ; Gurgu Volcano B2
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00

; 22 ; Gurgu Volcano B3
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00

; 23 ; Gurgu Volcano B4
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00

; 24 ; Gurgu Volcano B5
.byte $1C,$C7,$37 ; Fire Orb
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00

; 25 ; Ice Cave B2
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00

; 26 ; Ice Cave B3
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00

; 27 ; Bahamut's Room B2
.byte $0E,$D5,$03 ; Bahamut
.byte $8F,$D3,$07 ; Dragons
.byte $90,$D7,$07
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00

; 28 ; Mirage Tower 2F
.byte $CC,$13,$04 ; Robot
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00

; 29 ; Mirage Tower 3F
.byte $CD,$C9,$0A ; Transporter 
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00

; 2A ; Sea Shrine B5
.byte $1D,$CC,$08 ; Water Orb
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00

; 2B ; Sea Shrine B4
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00

; 2C ; Sea Shrine B3
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00

; 2D ; Sea Shrine B2
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00

; 2E ; Sea Shrine B1
.byte $A3,$86,$12 ; mermaids!
.byte $A4,$93,$05
.byte $A5,$9A,$12
.byte $A6,$84,$19
.byte $A7,$93,$12
.byte $A8,$94,$0C
.byte $A9,$8B,$0B
.byte $AA,$84,$0B
.byte $AB,$85,$04
.byte $AC,$94,$1A
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00

; 2F ; Sky Palace 1F
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00

; 30 ; Sky Palace 2F
.byte $16,$DA,$1B ; Earth plate? ??? 
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00

; 31 ; Sky Palace 3F
.byte $CF,$5E,$19 ; Window 
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00

; 32 ; Sky Palace 4F
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00

; 33 ; Sky Palace 5F
.byte $1E,$C7,$05 ; Wind Orb
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00

; 34 ; Temple of Fiends 1F
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00

; 35 ; Temple of Fiends 2F
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00

; 36 ; Temple of Fiends 3F
.byte $17,$D4,$10 ; Evil plate?
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00

; 37 ; Temple of Fiends 4F - Earth
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00

; 38 ; Temple of Fiends 5F - Fire
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00

; 39 ; Temple of Fiends 6F - Water
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00

; 3A ; Temple of Fiends 7F - Wind
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00

; 3B ; Temple of Fiends 8F - Chaos
.byte $18,$CF,$13 ; Garland's speech
.byte $19,$CF,$12 ; Garland's speech
.byte $1A,$CF,$11 ; Chaos fight!
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00

; 3C ; Titan's Tunnel
.byte $14,$48,$07 ; Titan
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00

; 3D ; empty map
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00

; 3E ; empty map
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00

; 3F ; empty map
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00
.byte $00,$00,$00



; Overworld->map teleport X coords
lut_EntrTele_X: 
.byte $1E ; Cardia 1 
.byte $10 ; Coneria
.byte $13 ; Pravoka
.byte $29 ; Elfland
.byte $01 ; Melmond
.byte $0B ; Crescent Lake
.byte $3D ; Gaia
.byte $01 ; Onrac
.byte $13 ; Leifen
.byte $0E ; C ; Coneria Castle 1F
.byte $10 ; Elfland Castle
.byte $16 ; Northwest Castle
.byte $0C ; Castle of Ordeals 1F
.byte $14 ; Temple of Fiends
.byte $17 ; Earth Cave B1
.byte $1B ; Gurgu Volcano B1
.byte $07 ; Ice Cave B1
.byte $0C ; Cardia 2
.byte $02 ; Bahamut's Room B1
.byte $39 ; Waterfall
.byte $16 ; Dwarf Cave
.byte $0F ; Matoya's Cave
.byte $12 ; Sarda's Cave
.byte $15 ; Marsh Cave B1
.byte $11 ; Mirage Tower 1F
.byte $0B ; Titan's Tunnel East 
.byte $05 ; Titan's Tunnel West
.byte $13 ; Cardia 3
.byte $2B ; Cardia 4
.byte $3A ; Cardia 5
.byte $00 ; 
.byte $00 ; 

; Overworld->map teleport Y coords
lut_EntrTele_Y: 
.byte $12 ; Cardia 1 
.byte $17 ; Coneria
.byte $20 ; Pravoka
.byte $16 ; Elfland
.byte $10 ; Melmond
.byte $17 ; Crescent Lake
.byte $3D ; Gaia
.byte $0C ; Onrac
.byte $17 ; Leifen
.byte $1E ; 23 ; Coneria Castle 1F
.byte $1F ; Elfland Castle
.byte $18 ; Northwest Castle
.byte $15 ; Castle of Ordeals 1F
.byte $1E ; Temple of Fiends
.byte $18 ; Earth Cave B1
.byte $0F ; Gurgu Volcano B1
.byte $01 ; Ice Cave B1
.byte $0F ; Cardia 2
.byte $02 ; Bahamut's Room B1
.byte $38 ; Waterfall
.byte $0B ; Dwarf Cave
.byte $0B ; Matoya's Cave
.byte $0D ; Sarda's Cave
.byte $1B ; Marsh Cave B1
.byte $1F ; Mirage Tower 1F
.byte $0E ; Titan's Tunnel East 
.byte $03 ; Titan's Tunnel West
.byte $24 ; Cardia 3
.byte $1D ; Cardia 4
.byte $37 ; Cardia 5
.byte $00 ; 
.byte $00 ; 

; Overworld->map teleport map #
lut_EntrTele_Map: 
.byte $10 ; Cardia 1 
.byte $00 ; Coneria
.byte $01 ; Pravoka
.byte $02 ; Elfland
.byte $03 ; Melmond
.byte $04 ; Crescent Lake
.byte $05 ; Gaia
.byte $06 ; Onrac
.byte $07 ; Leifen
.byte $08 ; Coneria Castle 1F
.byte $09 ; Elfland Castle
.byte $0A ; Northwest Castle
.byte $0B ; Castle of Ordeals 1F
.byte $0C ; Temple of Fiends
.byte $0D ; Earth Cave B1
.byte $0E ; Gurgu Volcano B1
.byte $0F ; Ice Cave B1
.byte $10 ; Cardia 2
.byte $11 ; Bahamut's Room B1
.byte $12 ; Waterfall
.byte $13 ; Dwarf Cave
.byte $14 ; Matoya's Cave
.byte $15 ; Sarda's Cave
.byte $16 ; Marsh Cave B1
.byte $17 ; Mirage Tower 1F
.byte $3C ; Titan's Tunnel East 
.byte $3C ; Titan's Tunnel West
.byte $10 ; Cardia 3
.byte $10 ; Cardia 4
.byte $10 ; Cardia 5
.byte $00 ; 
.byte $00 ; 

; Map->world map teleport X coords
lut_ExitTele_X: 
.byte $2A ; Titan's Tunnel East
.byte $1E ; Titan's Tunnel West
.byte $C5 ; Ice Cave
.byte $82 ; Castle of Ordeals
.byte $99 ; Castle of Coneria
.byte $41 ; Earth Cave
.byte $BC ; Gurgu Volcano
.byte $3E ; Sea Shrine
.byte $C2 ; Sky Castle
.byte $00 ; 
.byte $00 ; 
.byte $00 ; 
.byte $00 ; 
.byte $00 ; 
.byte $00 ; 
.byte $00 ; 

; Map->world map teleport Y coords
lut_ExitTele_Y: 
.byte $AE ; Titan's Tunnel East
.byte $AF ; Titan's Tunnel West
.byte $B7 ; Ice Cave
.byte $2D ; Castle of Ordeals
.byte $9F ; Castle of Coneria
.byte $BB ; Earth Cave
.byte $CD ; Gurgu Volcano
.byte $38 ; Sea Shrine
.byte $3B ; Sky Castle
.byte $00 ;
.byte $00 ;
.byte $00 ;
.byte $00 ;
.byte $00 ;
.byte $00 ;
.byte $00 ;

; Map tileset selection
lut_Tilesets: 
.byte $00 ; town        ; Coneria
.byte $00 ; town        ; Pravoka
.byte $00 ; town        ; Elfland
.byte $00 ; town        ; Melmond
.byte $00 ; town        ; Crescent Lake
.byte $00 ; town        ; Gaia
.byte $00 ; town        ; Onrac
.byte $00 ; town        ; Leifen
.byte $01 ; castle      ; Coneria Castle 1F
.byte $01 ; castle      ; Elfland Castle
.byte $01 ; castle      ; Northwest Castle
.byte $01 ; castle      ; Castle of Ordeals 1F
.byte $05 ; shrine      ; Temple of Fiends
.byte $02 ; cave        ; Earth Cave B1
.byte $02 ; cave        ; Gurgu Volcano B1
.byte $03 ; safe cave   ; Ice Cave B1
.byte $03 ; safe cave   ; Cardia
.byte $03 ; safe cave   ; Bahamut's Room B1
.byte $03 ; safe cave   ; Waterfall
.byte $03 ; safe cave   ; Dwarf Cave
.byte $03 ; safe cave   ; Matoya's Cave
.byte $03 ; safe cave   ; Sarda's Cave
.byte $04 ; tower       ; Marsh Cave B1
.byte $04 ; tower       ; Mirage Tower 1F
.byte $01 ; castle      ; Coneria Castle 2F
.byte $01 ; castle      ; Castle of Ordeals 2F
.byte $01 ; castle      ; Castle of Ordeals 3F
.byte $04 ; tower       ; Marsh Cave B2
.byte $04 ; tower       ; Marsh Cave B3
.byte $02 ; cave        ; Earth Cave B2
.byte $02 ; cave        ; Earth Cave B3
.byte $02 ; cave        ; Earth Cave B4
.byte $02 ; cave        ; Earth Cave B5
.byte $02 ; cave        ; Gurgu Volcano B2
.byte $02 ; cave        ; Gurgu Volcano B3
.byte $02 ; cave        ; Gurgu Volcano B4
.byte $02 ; cave        ; Gurgu Volcano B5
.byte $03 ; safe cave   ; Ice Cave B2
.byte $03 ; safe cave   ; Ice Cave B3
.byte $03 ; safe cave   ; Bahamut's Room B2
.byte $04 ; tower       ; Mirage Tower 2F
.byte $04 ; tower       ; Mirage Tower 3F
.byte $05 ; shrine      ; Sea Shrine B5
.byte $05 ; shrine      ; Sea Shrine B4
.byte $05 ; shrine      ; Sea Shrine B3
.byte $05 ; shrine      ; Sea Shrine B2
.byte $05 ; shrine      ; Sea Shrine B1
.byte $06 ; sky palace  ; Sky Palace 1F
.byte $06 ; sky palace  ; Sky Palace 2F
.byte $06 ; sky palace  ; Sky Palace 3F
.byte $06 ; sky palace  ; Sky Palace 4F
.byte $06 ; sky palace  ; Sky Palace 5F
.byte $07 ; temple      ; Temple of Fiends 1F
.byte $07 ; temple      ; Temple of Fiends 2F
.byte $07 ; temple      ; Temple of Fiends 3F
.byte $07 ; temple      ; Temple of Fiends 4F - Earth
.byte $07 ; temple      ; Temple of Fiends 5F - Fire
.byte $07 ; temple      ; Temple of Fiends 6F - Water
.byte $07 ; temple      ; Temple of Fiends 7F - Wind
.byte $07 ; temple      ; Temple of Fiends 8F - Chaos
.byte $02 ; cave        ; Titan's Tunnel
.byte $00 ;             ; 
.byte $00 ;             ; 
.byte $00 ;             ; 



; map->map teleport X coords
lut_NormTele_X: 
.byte $0C ; Coneria Castle 1
.byte $14 ; Time Warp
.byte $12 ; Marsh Cave 1
.byte $22 ; Marsh Cave 2
.byte $05 ; Marsh Cave 3
.byte $0A ; Earth Cave 1
.byte $1B ; Earth Cave 2
.byte $3D ; Earth Cave 3
.byte $19 ; Earth Cave 4
.byte $1E ; Gurgu Volcano 1
.byte $12 ; Gurgu Volcano 2
.byte $03 ; Gurgu Volcano 3
.byte $2E ; Gurgu Volcano 4
.byte $23 ; Gurgu Volcano 5
.byte $20 ; Gurgu Volcano 6
.byte $1E ; Ice Cave 1
.byte $03 ; Ice Cave 2
.byte $37 ; Ice Cave 3
.byte $27 ; Ice Cave 4
.byte $06 ; Ice Cave 5
.byte $3B ; Ice Cave 6
.byte $33 ; Ice Cave 7
.byte $0C ; Castle of Ordeals 1
.byte $16 ; Castle of Ordeals 2
.byte $02 ; Castle of Ordeals 3
.byte $17 ; Bahamut's Room
.byte $0E ; Castle of Ordeals 4
.byte $0C ; Castle of Ordeals 5
.byte $0C ; Castle of Ordeals 6
.byte $0A ; Castle of Ordeals 7
.byte $01 ; Castle of Ordeals 8
.byte $06 ; Castle of Ordeals 9
.byte $15 ; Sea Shrine 1
.byte $2D ; Sea Shrine 2
.byte $0C ; Sea Shrine 3
.byte $3D ; Sea Shrine 4
.byte $2F ; Sea Shrine 5
.byte $36 ; Sea Shrine 6
.byte $30 ; Sea Shrine 7
.byte $2D ; Sea Shrine 8
.byte $32 ; Sea Shrine 9
.byte $10 ; Mirage Tower 1
.byte $08 ; Mirage Tower 2
.byte $13 ; Sky Palace 1
.byte $13 ; Sky Palace 2
.byte $18 ; Sky Palace 3
.byte $03 ; Sky Palace 4
.byte $07 ; Sky Palace 5
.byte $08 ; Temple of Fiends 1
.byte $10 ; Temple of Fiends 2
.byte $01 ; Temple of Fiends 3
.byte $14 ; Temple of Fiends 4
.byte $28 ; Temple of Fiends 5
.byte $03 ; Temple of Fiends 6
.byte $0D ; Temple of Fiends 7
.byte $01 ; Temple of Fiends 8
.byte $01 ; Temple of Fiends 9
.byte $0F ; Temple of Fiends 10
.byte $04 ; Castle of Ordeals 10
.byte $08 ; Castle of Ordeals 11
.byte $0E ; Castle of Ordeals 12
.byte $17 ; Castle of Ordeals 13
.byte $0E ; Coneria Castle bottom floor
.byte $0C ; Rescue Princess

; map->map teleport Y coords
lut_NormTele_Y: 
.byte $12 ; Coneria Castle 1
.byte $11 ; Time Warp
.byte $10 ; Marsh Cave 1
.byte $25 ; Marsh Cave 2
.byte $06 ; Marsh Cave 3
.byte $09 ; Earth Cave 1
.byte $2D ; Earth Cave 2
.byte $21 ; Earth Cave 3
.byte $35 ; Earth Cave 4
.byte $20 ; Gurgu Volcano 1
.byte $02 ; Gurgu Volcano 2
.byte $17 ; Gurgu Volcano 3
.byte $17 ; Gurgu Volcano 4
.byte $06 ; Gurgu Volcano 5
.byte $1F ; Gurgu Volcano 6
.byte $02 ; Ice Cave 1
.byte $02 ; Ice Cave 2
.byte $05 ; Ice Cave 3
.byte $06 ; Ice Cave 4
.byte $14 ; Ice Cave 5
.byte $21 ; Ice Cave 6
.byte $0B ; Ice Cave 7
.byte $0C ; Castle of Ordeals 1
.byte $16 ; Castle of Ordeals 2
.byte $02 ; Castle of Ordeals 3
.byte $37 ; Bahamut's Room
.byte $0C ; Castle of Ordeals 4
.byte $09 ; Castle of Ordeals 5
.byte $10 ; Castle of Ordeals 6
.byte $0C ; Castle of Ordeals 7
.byte $14 ; Castle of Ordeals 8
.byte $05 ; Castle of Ordeals 9
.byte $2A ; Sea Shrine 1
.byte $08 ; Sea Shrine 2
.byte $1A ; Sea Shrine 3
.byte $31 ; Sea Shrine 4
.byte $27 ; Sea Shrine 5
.byte $29 ; Sea Shrine 6
.byte $0A ; Sea Shrine 7
.byte $14 ; Sea Shrine 8
.byte $30 ; Sea Shrine 9
.byte $1F ; Mirage Tower 1
.byte $01 ; Mirage Tower 2
.byte $15 ; Sky Palace 1
.byte $04 ; Sky Palace 2
.byte $17 ; Sky Palace 3
.byte $03 ; Sky Palace 4
.byte $36 ; Sky Palace 5
.byte $1B ; Temple of Fiends 1
.byte $0F ; Temple of Fiends 2
.byte $01 ; Temple of Fiends 3
.byte $12 ; Temple of Fiends 4
.byte $01 ; Temple of Fiends 5
.byte $20 ; Temple of Fiends 6
.byte $15 ; Temple of Fiends 7
.byte $01 ; Temple of Fiends 8
.byte $04 ; Temple of Fiends 9
.byte $07 ; Temple of Fiends 10
.byte $04 ; Castle of Ordeals 10
.byte $04 ; Castle of Ordeals 11
.byte $14 ; Castle of Ordeals 12
.byte $16 ; Castle of Ordeals 13
.byte $0D ; Coneria Castle bottom floor
.byte $07 ; Rescue Princess

; map->map teleport map #
lut_NormTele_Map: 
.byte $18 ; Coneria Castle 1     > 2F (loop - WARP magic doesn't work)
.byte $34 ; Time Warp            > Temple of Fiends 1F
.byte $1B ; Marsh Cave 1         > B2
.byte $1B ; Marsh Cave 2         > B2
.byte $1C ; Marsh Cave 3         > B3
.byte $1D ; Earth Cave 1         > B2
.byte $1E ; Earth Cave 2         > B3
.byte $1F ; Earth Cave 3         > B4
.byte $20 ; Earth Cave 4         > B5
.byte $21 ; Gurgu Volcano 1      > B2
.byte $22 ; Gurgu Volcano 2      > B3
.byte $23 ; Gurgu Volcano 3      > B4
.byte $22 ; Gurgu Volcano 4      > B3
.byte $23 ; Gurgu Volcano 5      > B4
.byte $24 ; Gurgu Volcano 6      > B5
.byte $25 ; Ice Cave 1           > B2 
.byte $26 ; Ice Cave 2           > B3
.byte $25 ; Ice Cave 3           > B2
.byte $26 ; Ice Cave 4           > B3
.byte $0F ; Ice Cave 5           > B1
.byte $26 ; Ice Cave 6           > B3
.byte $25 ; Ice Cave 7           > B2
.byte $19 ; Castle of Ordeals 1  > 2F
.byte $1A ; Castle of Ordeals 2  > 3F
.byte $0B ; Castle of Ordeals 3  > 1F
.byte $27 ; Bahamut's Room       > B2
.byte $19 ; Castle of Ordeals 4  > 2F (maze)
.byte $19 ; Castle of Ordeals 5  > 2F (maze)
.byte $19 ; Castle of Ordeals 6  > 2F (maze)
.byte $19 ; Castle of Ordeals 7  > 2F (maze)
.byte $19 ; Castle of Ordeals 8  > 2F (maze)
.byte $19 ; Castle of Ordeals 9  > 2F (maze)
.byte $2C ; Sea Shrine 1         > B3
.byte $2D ; Sea Shrine 2         > B2 (way to mermaids?)
.byte $2E ; Sea Shrine 3         > B1 (mermaids?)
.byte $2B ; Sea Shrine 4         > B4
.byte $2C ; Sea Shrine 5         > B3
.byte $2D ; Sea Shrine 6         > B2
.byte $2C ; Sea Shrine 7         > B3
.byte $2B ; Sea Shrine 8         > B4
.byte $2A ; Sea Shrine 9         > B5
.byte $28 ; Mirage Tower 1       > 2F
.byte $29 ; Mirage Tower 2       > 3F
.byte $2F ; Sky Palace 1         > 1F
.byte $30 ; Sky Palace 2         > 2F
.byte $31 ; Sky Palace 3         > 3F
.byte $32 ; Sky Palace 4         > 4F
.byte $33 ; Sky Palace 5         > 5F
.byte $37 ; Temple of Fiends 1   > 4F - Earth
.byte $35 ; Temple of Fiends 2   > 2F
.byte $36 ; Temple of Fiends 3   > 3F
.byte $35 ; Temple of Fiends 4   > 2F
.byte $34 ; Temple of Fiends 5   > 1F
.byte $37 ; Temple of Fiends 6   > 4F - Earth
.byte $38 ; Temple of Fiends 7   > 5F - Fire
.byte $39 ; Temple of Fiends 8   > 6F - Water
.byte $3A ; Temple of Fiends 9   > 7F - Wind
.byte $3B ; Temple of Fiends 10  > 8F - Chaos
.byte $19 ; Castle of Ordeals 10 > 2F (maze)
.byte $19 ; Castle of Ordeals 11 > 2F (maze)
.byte $19 ; Castle of Ordeals 12 > 2F (maze)
.byte $19 ; Castle of Ordeals 13 > 2F (maze)
.byte $08 ; Coneria Castle       > 1F (loop - WARP magic doesn't work)
.byte $18 ; Rescue Princess (ToF)> Coneria Castle 2F




.byte "END OF BANK 12"