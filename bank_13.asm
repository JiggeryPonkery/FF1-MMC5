.include "Constants.inc"
.include "variables.inc"
.include "macros.inc"
.feature force_range

.segment "BANK_13"

.export EnterMinimap

.import MinimapDecompress
.import ClearOAM
.import CHRLoadToA
.import BackupMapMusic
.import RestoreMapMusic
.import DrawComplexString_L, DrawBox_L, UpdateJoy_L, DrawPalette_L
.import WaitForVBlank_L, lut_RNG
.import CallMusicPlay_L
.import CHRLoad
.import LongCall
.import DrawComplexString


BANK_THIS = $13

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Minimap Sprite CHR  [$BF00 :: 0x27F10]
;;    CHR for sprites on the minimap

;lut_MinimapSprCHR:
;  .INCBIN "chr/minimap_sprite.chr"

lut_NewMinimapCHR:
  .INCBIN "chr/new_minimap.chr"
  
lut_MinimapTitleCHR:  
  .INCBIN "chr/minimap_title.chr"
  
lut_ZoomMinimapTextCHR:
  .INCBIN "chr/minimap_zoomout.chr"
  
  
lut_MinimapTitle:
.byte $84,$84,$84,$84,$84,$84,$84,$84,$84,$84,$84,$84,$88,$89,$8A,$8B
.byte $8C,$8D,$8E,$8F,$84,$84,$84,$84,$84,$84,$84,$84,$84,$84,$84,$84
.byte $84,$84,$84,$84,$84,$84,$84,$84,$84,$84,$84,$84,$90,$91,$92,$93
.byte $94,$95,$96,$97,$84,$84,$84,$84,$84,$84,$84,$84,$84,$84,$84,$84
.byte $84,$84,$84,$84,$84,$84,$84,$84,$84,$84,$98,$99,$9A,$9B,$9C,$9D
.byte $9E,$9F,$A0,$A1,$A2,$A3,$84,$84,$84,$84,$84,$84,$84,$84,$84,$84
.byte $84,$84,$84,$84,$84,$84,$84,$84,$84,$84,$A4,$A5,$A6,$A7,$A8,$A9
.byte $AA,$AB,$AC,$AD,$AE,$AF,$84,$84,$84,$84,$84,$84,$84,$84,$84,$84

lut_ZoomMapTilesetID:
.byte $01 ; 00 - CONERIA
.byte $01 ; 01 - PRAVOKA
.byte $01 ; 02 - ELFLAND
.byte $01 ; 03 - MELMOND
.byte $01 ; 04 - CRESCENT_LAKE
.byte $01 ; 05 - GAIA
.byte $01 ; 06 - ONRAC
.byte $01 ; 07 - LEIFEN
.byte $02 ; 08 - Coneria_CASTLE_1F
.byte $02 ; 09 - ELFLAND_CASTLE
.byte $02 ; 0A - NORTHWEST_CASTLE
.byte $02 ; 0B - CASTLE_OF_ORDEALS_1F
.byte $06 ; 0C - TEMPLE_OF_FIENDS_PRESENT
.byte $04 ; 0D - EARTH_CAVE_B1
.byte $04 ; 0E - GURGU_VOLCANO_B1
.byte $05 ; 0F - ICE_CAVE_B1
.byte $05 ; 10 - CARDIA
.byte $05 ; 11 - BAHAMUTS_ROOM_B1
.byte $05 ; 12 - WATERFALL
.byte $05 ; 13 - DWARF_CAVE
.byte $05 ; 14 - MATOYAS_CAVE
.byte $05 ; 15 - SARDAS_CAVE
.byte $06 ; 16 - MARSH_CAVE_B1
.byte $06 ; 17 - MIRAGE_TOWER_1F
.byte $02 ; 18 - Coneria_CASTLE_2F
.byte $02 ; 19 - Castle_of_Ordeals_2F
.byte $02 ; 1A - Castle_of_Ordeals_3F
.byte $06 ; 1B - Marsh_Cave_B2       
.byte $06 ; 1C - Marsh_Cave_B3       
.byte $04 ; 1D - Earth_Cave_B2       
.byte $04 ; 1E - Earth_Cave_B3       
.byte $04 ; 1F - Earth_Cave_B4       
.byte $04 ; 20 - Earth_Cave_B5       
.byte $04 ; 21 - Gurgu_Volcano_B2    
.byte $04 ; 22 - Gurgu_Volcano_B3    
.byte $04 ; 23 - Gurgu_Volcano_B4    
.byte $04 ; 24 - Gurgu_Volcano_B5    
.byte $05 ; 25 - Ice_Cave_B2         
.byte $05 ; 26 - Ice_Cave_B3         
.byte $05 ; 27 - Bahamuts_Room_B2    
.byte $06 ; 28 - Mirage_Tower_2F     
.byte $06 ; 29 - Mirage_Tower_3F     
.byte $03 ; 2A - Sea_Shrine_B5             
.byte $03 ; 2B - Sea_Shrine_B4             
.byte $03 ; 2C - Sea_Shrine_B3             
.byte $03 ; 2D - Sea_Shrine_B2             
.byte $03 ; 2E - Sea_Shrine_B1             
.byte $07 ; 2F - Sky_Palace_1F             
.byte $07 ; 30 - Sky_Palace_2F             
.byte $07 ; 31 - Sky_Palace_3F             
.byte $07 ; 32 - Sky_Palace_4F             
.byte $07 ; 33 - Sky_Palace_5F             
.byte $08 ; 34 - Temple_of_Fiends_1F       
.byte $08 ; 35 - Temple_of_Fiends_2F       
.byte $08 ; 36 - Temple_of_Fiends_3F       
.byte $08 ; 37 - Temple_of_Fiends_4F_Earth 
.byte $08 ; 38 - Temple_of_Fiends_5F_Fire  
.byte $08 ; 39 - Temple_of_Fiends_6F_Water 
.byte $08 ; 3A - Temple_of_Fiends_7F_Wind      
.byte $08 ; 3B - Temple_of_Fiends_8F_Chaos     
.byte $04 ; 3C - Titans_Tunnel 

lut_MapTilesetFillTile:
.byte $FF ; 00 - CONERIA
.byte $FF ; 01 - PRAVOKA
.byte $FF ; 02 - ELFLAND
.byte $FF ; 03 - MELMOND
.byte $FF ; 04 - CRESCENT_LAKE
.byte $00 ; 05 - GAIA
.byte $DF ; 06 - ONRAC
.byte $FF ; 07 - LEIFEN
.byte $FF ; 08 - Coneria_CASTLE_1F
.byte $FF ; 09 - ELFLAND_CASTLE
.byte $FF ; 0A - NORTHWEST_CASTLE
.byte $FF ; 0B - CASTLE_OF_ORDEALS_1F
.byte $FF ; 0C - TEMPLE_OF_FIENDS_PRESENT
.byte $FF ; 0D - EARTH_CAVE_B1
.byte $FF ; 0E - GURGU_VOLCANO_B1
.byte $FF ; 0F - ICE_CAVE_B1
.byte $FF ; 10 - CARDIA
.byte $FF ; 11 - BAHAMUTS_ROOM_B1
.byte $FF ; 12 - WATERFALL
.byte $FF ; 13 - DWARF_CAVE
.byte $FF ; 14 - MATOYAS_CAVE
.byte $FF ; 15 - SARDAS_CAVE
.byte $FF ; 16 - MARSH_CAVE_B1
.byte $FF ; 17 - MIRAGE_TOWER_1F
.byte $FF ; 18 - Coneria_CASTLE_2F
.byte $FF ; 19 - Castle_of_Ordeals_2F
.byte $FF ; 1A - Castle_of_Ordeals_3F
.byte $FD ; 1B - Marsh_Cave_B2       
.byte $FF ; 1C - Marsh_Cave_B3       
.byte $FF ; 1D - Earth_Cave_B2       
.byte $FF ; 1E - Earth_Cave_B3       
.byte $FF ; 1F - Earth_Cave_B4       
.byte $FF ; 20 - Earth_Cave_B5       
.byte $FF ; 21 - Gurgu_Volcano_B2    
.byte $FF ; 22 - Gurgu_Volcano_B3    
.byte $FF ; 23 - Gurgu_Volcano_B4    
.byte $FF ; 24 - Gurgu_Volcano_B5    
.byte $FF ; 25 - Ice_Cave_B2         
.byte $FF ; 26 - Ice_Cave_B3         
.byte $FF ; 27 - Bahamuts_Room_B2    
.byte $FF ; 28 - Mirage_Tower_2F     
.byte $FF ; 29 - Mirage_Tower_3F     
.byte $FF ; 2A - Sea_Shrine_B5             
.byte $FF ; 2B - Sea_Shrine_B4             
.byte $FF ; 2C - Sea_Shrine_B3             
.byte $FF ; 2D - Sea_Shrine_B2             
.byte $FF ; 2E - Sea_Shrine_B1             
.byte $FF ; 2F - Sky_Palace_1F             
.byte $FF ; 30 - Sky_Palace_2F             
.byte $FF ; 31 - Sky_Palace_3F             
.byte $FF ; 32 - Sky_Palace_4F             
.byte $FF ; 33 - Sky_Palace_5F             
.byte $FF ; 34 - Temple_of_Fiends_1F       
.byte $FF ; 35 - Temple_of_Fiends_2F       
.byte $FF ; 36 - Temple_of_Fiends_3F       
.byte $FF ; 37 - Temple_of_Fiends_4F_Earth 
.byte $FF ; 38 - Temple_of_Fiends_5F_Fire  
.byte $FF ; 39 - Temple_of_Fiends_6F_Water 
.byte $FF ; 3A - Temple_of_Fiends_7F_Wind      
.byte $FF ; 3B - Temple_of_Fiends_8F_Chaos     
.byte $FF ; 3C - Titans_Tunnel 


lut_MapTilesetPalette:
.byte $01 ; 00 - CONERIA
.byte $01 ; 01 - PRAVOKA
.byte $01 ; 02 - ELFLAND
.byte $01 ; 03 - MELMOND
.byte $01 ; 04 - CRESCENT_LAKE
.byte $01 ; 05 - GAIA
.byte $01 ; 06 - ONRAC
.byte $01 ; 07 - LEIFEN
.byte $01 ; 08 - Coneria_CASTLE_1F
.byte $01 ; 09 - ELFLAND_CASTLE
.byte $01 ; 0A - NORTHWEST_CASTLE
.byte $01 ; 0B - CASTLE_OF_ORDEALS_1F
.byte $02 ; 0C - TEMPLE_OF_FIENDS_PRESENT
.byte $03 ; 0D - EARTH_CAVE_B1
.byte $05 ; 0E - GURGU_VOLCANO_B1
.byte $04 ; 0F - ICE_CAVE_B1
.byte $02 ; 10 - CARDIA
.byte $02 ; 11 - BAHAMUTS_ROOM_B1
.byte $04 ; 12 - WATERFALL
.byte $02 ; 13 - DWARF_CAVE
.byte $02 ; 14 - MATOYAS_CAVE
.byte $02 ; 15 - SARDAS_CAVE
.byte $03 ; 16 - MARSH_CAVE_B1
.byte $02 ; 17 - MIRAGE_TOWER_1F
.byte $01 ; 18 - Coneria_CASTLE_2F
.byte $01 ; 19 - Castle_of_Ordeals_2F
.byte $01 ; 1A - Castle_of_Ordeals_3F
.byte $03 ; 1B - Marsh_Cave_B2       
.byte $03 ; 1C - Marsh_Cave_B3       
.byte $03 ; 1D - Earth_Cave_B2       
.byte $03 ; 1E - Earth_Cave_B3       
.byte $03 ; 1F - Earth_Cave_B4       
.byte $03 ; 20 - Earth_Cave_B5       
.byte $05 ; 21 - Gurgu_Volcano_B2    
.byte $05 ; 22 - Gurgu_Volcano_B3    
.byte $05 ; 23 - Gurgu_Volcano_B4    
.byte $05 ; 24 - Gurgu_Volcano_B5    
.byte $04 ; 25 - Ice_Cave_B2         
.byte $04 ; 26 - Ice_Cave_B3         
.byte $02 ; 27 - Bahamuts_Room_B2    
.byte $02 ; 28 - Mirage_Tower_2F     
.byte $02 ; 29 - Mirage_Tower_3F     
.byte $04 ; 2A - Sea_Shrine_B5             
.byte $04 ; 2B - Sea_Shrine_B4             
.byte $04 ; 2C - Sea_Shrine_B3             
.byte $04 ; 2D - Sea_Shrine_B2             
.byte $04 ; 2E - Sea_Shrine_B1             
.byte $06 ; 2F - Sky_Palace_1F             
.byte $06 ; 30 - Sky_Palace_2F             
.byte $06 ; 31 - Sky_Palace_3F             
.byte $06 ; 32 - Sky_Palace_4F             
.byte $06 ; 33 - Sky_Palace_5F             
.byte $02 ; 34 - Temple_of_Fiends_1F       
.byte $02 ; 35 - Temple_of_Fiends_2F       
.byte $02 ; 36 - Temple_of_Fiends_3F       
.byte $02 ; 37 - Temple_of_Fiends_4F_Earth 
.byte $02 ; 38 - Temple_of_Fiends_5F_Fire  
.byte $02 ; 39 - Temple_of_Fiends_6F_Water 
.byte $02 ; 3A - Temple_of_Fiends_7F_Wind      
.byte $02 ; 3B - Temple_of_Fiends_8F_Chaos     
.byte $03 ; 3C - Titans_Tunnel 

lut_ZoomMapTilesets:
.word lut_OverworldZoomTileset
.word lut_TownMiniMapTileset 
.word lut_CastleMiniMapTileset
.word lut_EarthCaveMiniMapTileset
.word lut_IceCaveMiniMapTileset
.word lut_TowerMiniMapTileset
.word lut_ShrineMiniMapTileset
.word lut_SkyCastleMiniMapTileset
.word lut_TempleMiniMapTileset

lut_ZoomMapPalettes:
.word lut_OverworldZoomPalette ; 0
.word lut_TownCastlePalette    ; 1
.word lut_TemplePalette        ; 2
.word lut_BrownCavePalette     ; 3
.word lut_BlueCavePalette      ; 4
.word lut_RedCavePalettee      ; 5 
.word lut_GreyPalette          ; 6

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  BG palette for minimap  [$BF20 :: 0x27F30]

;lut_MinimapBGPal:
;  .BYTE $02,$04,$37,$0F
;  .BYTE $02,$28,$18,$0F
;  .BYTE $02,$24,$1A,$30
;  .BYTE $02,$1B,$38,$2B
  
  
lut_OverworldZoomPalette:  
  .BYTE $1B,$0F,$37,$04 ; title
  .BYTE $1B,$02,$38,$17 ; map pixels
  .BYTE $1B,$0F,$02,$0F ; map paper borders

lut_TownCastlePalette: 
  .BYTE $38,$0F,$37,$04
  .BYTE $38,$00,$21,$1A
  .BYTE $38,$0F,$38,$0F

lut_TemplePalette:     
  .BYTE $38,$0F,$37,$04
  .BYTE $38,$00,$21,$1A
  .BYTE $38,$0F,$38,$0F  
  
lut_BrownCavePalette:  
  .BYTE $08,$0F,$37,$04
  .BYTE $08,$2D,$38,$27
  .BYTE $08,$0F,$08,$0F  
 ;       ^   ^   ^   ^
 ;for    |   |   |   chests/damage tiles
 ;center |   |   objects of interest
 ;row:   |   walls
 ;      map bg
  
lut_BlueCavePalette:   
  .BYTE $0C,$0F,$37,$04
  .BYTE $0C,$2D,$22,$1C
  .BYTE $0C,$0F,$0C,$0F  
 ;       ^   ^   ^   ^
 ;for    |   |   |   chests/damage tiles
 ;center |   |   objects of interest
 ;row:   |   walls
 ;      map bg

lut_RedCavePalettee:   
  .BYTE $06,$0F,$37,$04
  .BYTE $06,$2D,$26,$16
  .BYTE $06,$0F,$06,$0F  
 ;       ^   ^   ^   ^
 ;for    |   |   |   chests/damage tiles
 ;center |   |   objects of interest
 ;row:   |   walls
 ;      map bg


lut_GreyPalette:       
  .BYTE $0F,$0F,$37,$04
  .BYTE $0F,$2D,$10,$31
  .BYTE $0F,$0F,$0F,$0F  
 ;       ^   ^   ^   ^
 ;for    |   |   |   chests/damage tiles
 ;center |   |   objects of interest
 ;row:   |   walls
 ;      map bg


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Minimap Tileset color assignment LUT  [$BF80 :: 0x27F90]
;;
;;    Each entry in this table coresponds to an overworld tile.
;;  This table specifies what color (of the 4 colors available
;;  colors) this tile will be represented by in the minimap.
;;
;;    The low 2 bits specify the color... bit 2 ($4), is set if
;;  the tile represents a town/dungeon and indicates that a sprite
;;  should be drawn on that tile.
;;

lut_MinimapTileset: 
 ; .BYTE 1,5,5,1,1,1,1,1, 1,1,1,1,1,1,6,0
 ; .BYTE 1,1,1,1,1,1,0,0, 0,1,1,5,5,6,2,3
 ; .BYTE 1,3,1,1,1,1,1,0, 1,5,5,5,1,1,1,5
 ; .BYTE 1,1,5,1,5,5,2,2, 5,5,5,1,3,3,3,1
 ; .BYTE 0,0,2,2,0,2,4,1, 1,5,5,1,5,5,5,1
 ; .BYTE 0,0,2,2,1,1,1,5, 5,1,5,1,1,5,1,1
 ; .BYTE 1,1,1,1,5,5,5,5, 5,5,5,3,5,5,5,3
 ; .BYTE 1,1,1,1,1,1,1,1, 1,2,0,3,3,3,3,3 ; original

.BYTE 0,7,7,0,0,0,0,0, 0,0,0,2,2,2,7,2 
.BYTE 0,0,0,0,0,0,0,1, 0,0,0,4,4,2,2,2
.BYTE 0,3,0,0,0,0,0,0, 0,7,7,7,0,0,0,7
.BYTE 0,0,7,0,7,7,2,2, 7,7,7,0,2,2,2,0
.BYTE 1,1,2,2,1,2,4,2, 2,5,5,2,7,7,7,2 
.BYTE 1,1,2,2,0,0,0,7, 6,0,5,2,0,5,0,2  
.BYTE 0,0,0,0,7,7,5,5, 5,5,5,2,7,5,7,2
.BYTE 0,0,0,0,3,3,0,2, 2,2,2,2,2,2,2,2

;; for overworld:
; 0, 4 = dark green - land
; 1, 5 = blue - water, cave entrances
; 2, 6 = pale yellow - desert, docks, building rooftops
; 3, 7 = brown - mountains, entrances

lut_OverworldZoomTileset: ; 0 
  .BYTE 0,7,7,0,0,0,0,1, 0,2,2,2,2,2,4,2
  .BYTE 3,3,3,0,0,0,1,1, 1,2,2,7,7,2,2,2
  .BYTE 3,3,3,0,0,0,0,1, 0,7,7,4,2,2,2,4
  .BYTE 3,3,4,3,4,4,2,2, 7,7,4,0,2,2,2,0
  .BYTE 1,1,2,2,1,2,4,2, 2,7,7,2,7,7,7,2
  .BYTE 1,1,2,2,0,0,0,7, 7,0,7,2,2,7,2,2
  .BYTE 0,0,0,0,7,7,4,4, 4,4,4,2,4,7,4,2
  .BYTE 0,0,0,0,3,3,0,2, 2,2,2,2,2,2,2,2

; 0, 4 = yellow - floor, fluff items, exit
; 1, 5 = grey - wall, bridge
; 2, 6 = light blue - treasure, pillars, things to talk to, water
; 3, 7 = green - trees, items of interest
  
lut_TownMiniMapTileset: ; 1
  .BYTE 0,0,0,1,1,1,1,1, 1,1,1,1,1,1,3,3
  .BYTE 0,0,0,0,0,0,0,1, 1,1,2,1,1,1,5,5
  .BYTE 2,2,2,2,2,2,5,2, 2,2,1,1,1,5,2,2
  .BYTE 1,2,0,0,3,1,5,5, 0,0,1,2,0,0,5,5
  .BYTE 5,5,5,5,5,5,5,0, 6,5,5,5,5,5,5,5
  .BYTE 5,5,5,5,5,5,5,5, 5,5,5,5,5,5,5,5
  .BYTE 5,5,5,5,5,5,5,5, 5,5,5,5,5,5,5,5
  .BYTE 5,5,5,5,5,5,5,5, 5,5,5,5,5,3,5,2

; 0, 4 = yellow - floor, fluff items, exit
; 1, 5 = grey - wall, bridge
; 2, 6 = light blue - treasure, pillars, things to talk to, water
; 3, 7 = green - trees, items of interest
  
lut_CastleMiniMapTileset: ; 2
  .BYTE 1,1,1,1,0,1,1,0, 1,0,0,0,1,0,0,0
  .BYTE 0,0,0,0,0,0,0,0, 0,0,0,0,7,0,0,0
  .BYTE 0,3,0,0,0,0,0,0, 0,0,0,0,0,0,0,0
  .BYTE 1,0,1,1,1,1,5,5, 2,7,0,5,0,7,0,0
  .BYTE 7,0,0,0,5,5,0,0, 5,5,0,0,2,2,2,2
  .BYTE 2,2,2,2,2,2,0,0, 2,0,0,0,0,0,0,0
  .BYTE 0,7,7,2,2,2,2,2, 2,2,2,2,2,2,2,2
  .BYTE 2,2,2,2,2,2,2,2, 2,0,0,0,0,0,0,0  

; 0, 4 = black
; 1, 5 = grey - walls
; 2, 6 = white - neat things
; 3, 7 = color - chests

lut_EarthCaveMiniMapTileset:
  .BYTE 1,1,1,1,0,1,1,0, 1,0,0,0,1,2,6,6
  .BYTE 1,1,0,1,1,6,6,6, 6,6,0,0,0,0,0,6
  .BYTE 0,0,0,0,6,6,6,6, 6,6,6,6,6,6,0,0
  .BYTE 1,0,1,1,1,1,5,5, 0,0,0,5,0,3,1,1
  .BYTE 0,0,3,3,3,3,3,3, 3,3,3,3,3,3,3,3
  .BYTE 3,3,3,3,3,3,3,3, 3,3,3,3,3,3,3,3
  .BYTE 3,3,3,3,3,3,3,3, 3,3,3,3,3,3,3,3
  .BYTE 3,3,3,3,3,3,3,3, 3,3,3,3,3,3,3,0
  
; 0, 4 = black
; 1, 5 = grey
; 2, 6 = white
; 3, 7 = color   

lut_IceCaveMiniMapTileset:
  .BYTE 1,1,1,1,0,1,1,0, 1,0,0,0,1,2,0,0
  .BYTE 2,2,2,0,0,0,2,2, 6,6,6,6,0,0,0,0
  .BYTE 0,0,0,0,0,0,0,0, 6,6,6,6,6,6,6,0
  .BYTE 1,0,1,1,1,1,5,5, 2,2,0,5,0,1,0,0
  .BYTE 0,0,0,0,0,0,0,0, 0,0,0,3,3,3,3,3
  .BYTE 3,3,3,3,3,3,3,3, 3,3,3,3,3,3,3,3
  .BYTE 3,3,3,3,3,3,3,3, 3,3,3,3,3,3,3,3
  .BYTE 3,3,3,3,3,3,3,3, 3,3,3,3,3,3,3,0  

; 0, 4 = black
; 1, 5 = grey
; 2, 6 = white
; 3, 7 = color 

lut_TowerMiniMapTileset:
  .BYTE 1,1,1,1,0,1,1,0, 1,6,6,0,1,2,2,2
  .BYTE 2,2,2,2,2,0,0,2, 2,0,0,0,0,0,0,0
  .BYTE 6,6,6,6,0,0,6,6, 6,0,0,0,6,0,0,0
  .BYTE 1,0,1,1,1,1,5,5, 0,1,0,5,0,0,0,0
  .BYTE 7,0,0,0,5,5,0,0, 5,5,0,0,2,2,2,2
  .BYTE 0,3,3,3,3,3,3,3, 3,3,3,3,3,3,3,3
  .BYTE 3,3,3,3,3,3,3,3, 0,0,0,0,0,0,0,0
  .BYTE 0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0

; 0, 4 = black
; 1, 5 = grey - walls
; 2, 6 = white - pillar, stairs, neat things
; 3, 7 = color - treasure, water
  
lut_ShrineMiniMapTileset:
  .BYTE 1,1,1,1,0,1,1,0, 1,0,0,0,1,0,0,4
  .BYTE 2,2,1,4,1,2,0,2, 0,0,0,0,0,0,0,0
  .BYTE 0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0
  .BYTE 1,0,1,1,1,1,5,5, 2,0,0,5,3,0,0,0
  .BYTE 6,6,6,6,6,6,6,0, 2,0,0,6,6,6,6,6
  .BYTE 0,0,0,0,0,0,3,3, 3,3,3,3,3,3,3,3
  .BYTE 3,3,3,3,3,3,3,3, 3,3,3,3,3,3,3,3
  .BYTE 3,3,3,3,3,3,3,3, 3,3,3,3,0,0,0,0   

; 0, 4 = black
; 1, 5 = grey
; 2, 6 = white
; 3, 7 = color 

lut_SkyCastleMiniMapTileset:
  .BYTE 1,1,1,1,0,1,1,0, 1,0,6,0,1,0,0,0
  .BYTE 0,0,0,0,0,0,0,0, 0,0,0,0,7,0,0,0
  .BYTE 0,3,0,0,0,0,0,0, 0,0,0,0,0,0,0,0
  .BYTE 1,0,1,1,1,1,5,5, 2,7,0,5,0,7,0,0
  .BYTE 7,0,0,0,5,5,0,0, 5,5,0,0,2,2,2,2
  .BYTE 2,2,2,2,2,2,0,0, 2,0,0,0,0,0,0,0
  .BYTE 0,7,7,2,2,2,2,2, 2,2,2,2,2,2,2,2
  .BYTE 2,2,2,2,2,2,2,2, 2,0,0,0,0,0,0,0   

; 0, 4 = black
; 1, 5 = grey
; 2, 6 = white
; 3, 7 = color 

lut_TempleMiniMapTileset:
  .BYTE 1,1,1,1,0,1,1,0, 1,0,6,0,1,6,1,2
  .BYTE 2,2,2,2,2,2,0,2, 2,6,0,0,0,0,0,0
  .BYTE 0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0
  .BYTE 1,0,1,1,1,1,5,5, 1,1,0,5,0,0,0,0
  .BYTE 6,6,6,6,6,0,0,0, 0,0,0,3,3,3,3,3
  .BYTE 3,3,3,3,3,3,3,3, 3,3,3,3,3,3,3,3
  .BYTE 3,3,3,3,3,3,3,3, 3,3,3,3,3,3,0,0
  .BYTE 0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0 



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Enter Minimap  [$BC00 :: 0x27C10]
;;
;;    Ahhh... the minimap!  On one hand I think it's very clever... on the other hand
;;  the way it draws is CRIMINALLY inefficient.
;;
;;    Usually when you think of NES drawing, you think of a (more or less) fixed pattern
;;  table that contains your tiles, and you arrange those tiles on the screen with
;;  the name table.  However... the minimap is done somewhat differently.
;;
;;    The world map is 256x256 tiles, but it draws it as a 128x128 pixel image (so each
;;  pixel represents 4 tiles in a 2x2 arrangement).  Somewhat coincidentally... the BG pattern
;;  tables (16x16 tiles) also measure 128x128 pixels!  So the game simply uses the BG
;;  pattern tables as a canvas on which to draw the minimap... and has a fixed nametable
;;  placing the tiles on the screen.
;;
;;    Tiles on the pattern table that are nothing but water get drawn over with other
;;  supporting graphics (title and decoration graphics) after map drawing is complete.
;;
;;
;;    So yeah... that much is pretty slick.  But what is incredibly dumb about the
;;  minimap is that it wastes a LOT of ROM space and CPU time.
;;
;;    Since the drawing is done with the PPU on (so you can see the map progressively being
;;  drawn onscreen as sort of a neat visual effect), all PPU writes must be performed during
;;  VBlank.  This means that the number of writes you can do is very limited... and you have
;;  to end up wasting most of your CPU time waiting for VBlank to happen.  Now most people
;;  would use that down time to decompress map tiles and get them ready to be drawn next frame
;;  but for whatever reason the game doesn't!  Instead of the simple and expected 
;;  "load, draw, load, draw" pattern which uses the rendering time to pre-load graphics
;;  for next VBlank -- this routine will actually load EIGHT rows all at once, then draw
;;  one row a frame for 8 frames ("load, load, load, load...  draw, draw, draw, draw....").
;;
;;    Now...you have to wait for a frame between draws anyway (it's required since writes have
;;  to fall in VBlank) -- but the loading can be done any time.  So it makes more sense to spread
;;  it out between draws when you're doing nothing but waiting.  But NO!  The game crams a bunch
;;  of its loading in a SINGLE frame rather than spreading it out across 8 frames.
;;
;;    This results in an EXTRA and unnecessary pause every 8 rows while the CPU is busy wasting time
;;  loading tiles.
;;
;;
;;    As for wasting space... the game doesn't use the existing map decompression routine!
;;  I still don't know why.  Instead the game has ****TWO**** of its own routines for decompressing
;;  map tiles.  TWO.  I kid you not.  This makes a total of 3 versions of the exact same routine.
;;  But I rant about that in that routine (see MinimapDecompress).
;;
;;
;;
;;    Anyway... the drawing methods here will be confusing unless you're familiar with how NES
;;  2bpp graphics are layed out.  I won't get into it here... but basically each 8x8 tile is 16 bytes...
;;  the first 8 bytes ($x0-$x7) are the low bitplane, and the next 8 ($x8-$xF) are the high bitplane.
;;  each byte in the bitplane is a row of 8 pixels (each bit of the byte is a pixel)
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



EnterMinimap:
    LDA #BANK_THIS
    STA cur_bank           ; set cur bank (required for music routine)

    LDA #$00
    STA $2001
    STA $4015              ; turn off PPU and APU
    STA $5015              ; and silence the MMC5 APU. (JIGS)

    JSR LongCall
    .WORD BackupMapMusic
    .BYTE BANK_MUSIC

    LDA #$41               ; switch to music track $41 (crystal theme)
    STA music_track        ; 
    ;STA dlgmusic_backup
    
    LDA mapflags
    LSR A
    BCS @DoSmallMap
    
    LDA mapflags
    ORA #$80
    STA mapflags           ; set the "overworld zoomed in" flag
    
   @DoSmallMap: 
    LDX #0
   @BackupMapObj: 
    LDA mapobj, X
    STA mapobj_backup, X
    DEX
    BNE @BackupMapObj
   
    JSR EnterDungeonMap    ; Set up and draw the zoomed in map!

   @SemiExitLoop: 
    JSR MiniMapFrame      ; do a frame... animating sprite palettes and whatnot
    LDA joy_b             
    BNE @ExitMiniMap      ; if B was pressed, exit!

    LDA joy_a             ; check if A was pressed
    BEQ @SemiExitLoop     ; if not, keep looping
    
    LDA mapflags          ; else...
    LSR A
    BCS @ExitMiniMap      ; if in a small map, exit
    
   ;; A was pressed in the zoomed in overworld map: 
   ;; First, since OverworldMap_Prep stored its sprites at $0500 instead of $0200...
    LDX #0
   @FillOAM: 
    LDA mm_spritebuf, X         ; copy it all over
    STA oam, X
    INX
    BNE @FillOAM
    
    JSR Overworld_YouAreHere    ; Load the "You are here" graphic

    LDA mapflags
    AND #$7F
    STA mapflags                ; clear the high bit from mapflags  

    LDA #$0A
    STA $2001              ; turn on BG rendering (but leave sprites disabled)
    JSR MiniMap_DrawOW     ; draw everything with the screen on!

   @ExitLoop:
    JSR MiniMapFrame      ; do a frame... animating sprite palettes and whatnot

    LDA joy_a
    ORA joy_b
    BEQ @ExitLoop         ; and simply loop until the user presses A or B

   @ExitMiniMap:
    ;; no idea how much of this NEEDS to be here, but it seems to keep exiting clean so far.
    LDA #$0F
    STA cur_pal
    STA cur_pal+$10          ; set the background palette to black again
    JSR ClearOAM             ; wipe OAM
    JSR DoMiniMapVBlank      ; wait for VBlank
    LDA #>oam
    STA $4014                ; do sprite DMA (clear sprites from screen)  
    JSR DrawPalette_L        ; update the palette so the background turns black
    LDA #0                   ; reset scroll to 0 (might be pointless)
    STA $2005
    STA $2005
    STA $2001
   ; STA $4015                ; turn off PPU and APU
   ; STA $5015                ; and silence the MMC5 APU. (JIGS)    
    STA joy_b                
    STA joy_select
    LDA soft2000             ; clear the sprites-as-background-tiles flag
    AND #$10
    STA soft2000
    LDA mapflags
    AND #$7F
    STA mapflags             ; clear the high bit from mapfalgs
    LSR A
    BCC :+
    
    LDX #0
   @FixMapObj: 
    LDA mapobj_backup, X
    STA mapobj, X
    DEX
    BNE @FixMapObj
    
  : JSR LongCall
    .WORD RestoreMapMusic
    .byte BANK_MUSIC
    ;; why isn't this working? music_track is 0 ... 
    
    RTS
    
    
    
EnterDungeonMap:
    JSR ZoomMap_YouAreHere  ; Load the "You are here" graphic -- also clears OAM
    JSR MiniMap_FillNTPal   ; Clears the screen and BG CHR, loads sprite-BG CHR
    
    LDA #0
    STA mm_maprow           ; start decompression tiles from row 0 (top row)
    STA tmp+6               ; and tmp+6 will be used similarly to mm_maprow
    STA minimap_ptr+1       ; set high byte of this pointer (low byte resets to 0 elsewhere)

    JSR SetMiniMapPointers
    
    LDA mapflags         ; high bit set if its the overworld map, but zoomed in
    BPL @SmallMap
    
    LDA ow_scroll_y      ; if it IS the overworld, get the Y scroll
    SEC
    SBC #32-7            ; -7 because ow_scroll_y is already 7 off from player's actual position
    STA mm_maprow        ; and start with this map row instead
    
    LDX #0               ; 0 is the fake overworld ID
    BEQ :+
   
   @SmallMap:   
    LDX cur_map
    LDA lut_ZoomMapTilesetID, X   ; use the current map ID to index this LUT
    ASL A
    TAX
  : LDA lut_ZoomMapTilesets, X    ; the tilesets are used to convert tile IDs into pixels
    STA ZoomMapTilesetPtr         ; so that water tiles are blue, trees are green, etc.
    LDA lut_ZoomMapTilesets+1, X  ; since different map tilesets have slightly different arrangements
    STA ZoomMapTilesetPtr+1

    JSR ZoomMap_Prep              ; Fill $6000 with the BG CHR to draw
    JSR SetupMinimapScreen        ; turn on the screen and do some prep to clear sprite DMA

    ;; prepare these for decompressing the overworld map to mapdata
    LDA #0
    STA mm_maprow                 ; start decompression tiles from row 0 (top row)
    STA sprindex    
    STA minimap_ptr
    
    JMP MiniMap_Draw              ; transfer $6000 to BG CHR one row of pixels at a time; animated!
    ;; if on the overworld, also decompresses the zoomed out map while drawing!

SetupMinimapScreen:
    JSR DoMiniMapVBlank    ; wait for the normal VBlank routine
    JSR DrawPalette_L      ; update the palette
    LDA #>oam              ; and the sprites
    STA $4014
    LDA #$0A
    STA $2001              ; turn on BG rendering (but leave sprites disabled)
    
SetMinimapScroll:
    LDA soft2000           ; reset scroll to $00,$E8
    STA $2000
    LDA #$00
    STA $2005
    LDA #$E0 ;8
    STA $2005
    RTS    
    
SetMiniMapPointers:    
  ;;reading from $7000-$7FFF
    LDA #<mapdata
    STA ZoomMapPointer
    LDA #>mapdata
    STA ZoomMapPointer+1
    
  ;;writing to $6000-$6FFF
    LDA #<mm_drawbuf
    STA MiniMap_DrawBuf
    LDA #>mm_drawbuf
    STA MiniMap_DrawBuf+1
    RTS
    


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Minimap Frame  [$BD49 :: 0x27D59]
;;
;;     Does a frame for the minimap!
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; JIGS - this assumes that soft2000 has bit $10 set already
;; so it starts with using the sprite CHR as background tiles

DoMiniMapVBlank: 
    LDA $2002     
    BPL @Wait     
    LDA #0        
  @Loop:
      SEC         
      SBC #$01    
      BNE @Loop   

  @Wait:
    LDA soft2000   ; turn on the wait for NMI bit
    ORA #$80
    STA $2000     
    
    LDA #79        ; and set scanline #71 as the one to break on
    STA $5203

   @WaitForScanline71:
    LDA $5204      ; high bit set when scanline #71 is being drawn
    BPL @WaitForScanline71
    
   @Scanline71:   
    LDX #$10       ; waits for H-blank so as not to draw weird dots on the screen
  : DEX        
    BNE :-    
    LDA soft2000
    EOR #$90       ; turn off sprites-as-background-tiles, but turn on the NMI bit thing if its off
    STA $2000
    LDA #207       ; set next break at scanline #199 
    STA $5203      
    
    JSR CallMusicPlay_L 
    
  ;  LDA playtimer
  ;  AND #$02 ; change this to a 4 to make its sound like being silly on a guitar string
  ;  BEQ :+
  ;    LDA $4000
  ;    AND #$F3
  ;    STA $4000
  ;    LDA $5000
  ;    AND #$F3
  ;    STA $5000
  ;    LDA CHAN_SQ3 + ch_freq+1
  ;    STA $5003                  ; output frequency      
  ;    JMP @WaitForScanline199
  ; :  LDA $4004
  ;    AND #$F3
  ;    STA $4004
  ;    LDA $5004
  ;    AND #$F3
  ;    STA $5004
  ;    LDA CHAN_SQ4 + ch_freq+1
  ;    STA $5007                  ; output frequency   
;; this dumb thing makes the Prelude have like a phaser effect... leaving it in for fun.
;; since I had fun playing around with it.
    
    ;; now there's nothing to do but wait, so while the screen draws
    ;; spend 16 or so scanlines updating the music 
    ;; this might be stupid risky
    ;; but vblank has more important things to be doing!
   
  @WaitForScanline199:
    LDA $5204      ; high bit set when scanline #199 is being drawn
    BPL @WaitForScanline199
    
   @Scanline199:   
    LDX #$10   
  : DEX        
    BNE :-    
    LDA soft2000         ; still has bit $10 set, so will set sprite CHR as background tiles again
    ORA #$80             ; turn on the NMI bit again just in case...
    STA $2000
    LDA #$00             ; and clear the scanline break register
    STA $5203      
   @LoopForever: 
    JMP @LoopForever     ; then loop forever! (or really until the NMI is triggered)
    


MiniMapFrame:
    JSR DoMiniMapVBlank
    LDA #>oam              ; Sprite DMA
    STA $4014

    JSR DrawPalette_L      ; draw the palette
    LDA #$1E               ; turn PPU on
    STA $2001
    
    JSR SetMinimapScroll
    ;JSR CallMusicPlay_L    ; keep the music playing
    ;; at this point, the next frame may have started, so its important
    ;; that soft2000 has the sprites-as-background-tiles bit set before the screen is turned on
    ;; (not that if CallMusicPlay is not done here, its probably NOT started on the next frame!)

    LDA #0
    STA joy_a              ; clear A and B button catchers
    STA joy_b
    JSR UpdateJoy_L        ; then update joypad data

    ;INC framecounter       ; inc the frame counter

    LDA framecounter
    AND #$08               ; use bit 3 of frame counter to toggle between
    BNE :+
      LDA #$30             ; $37 (tan color)
:   EOR #$07               ; and $0F (black)  every 8 frames
    STA cur_pal+$11        ; this is the color for the "you are here" sprite

    LDA framecounter       ; use bits 4,5 of frame counter
    AND #$30               ; to cycle between $00,$10,$20,$0F
    CMP #$30               ;  changing color every 16 frames
    BNE :+
      LDA #$0F
:   STA cur_pal+$12        ; this is the color for the town/dungeon marker sprites

    RTS                    ; and exit!


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Minimap Draw Rows  [$BD91 :: 0x27DA1]
;;
;;    Draws 8 preloaded rows of pixels to the PPU pattern tables.
;;  Each row is drawn in its own VBlank, so the drawing happens progressively.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

MiniMap_DrawOW:
    LDA #<mapdata
    STA MiniMap_DrawBuf
    LDA #>mapdata
    STA MiniMap_DrawBuf+1    ; Draw the overworld from "mapdata"
    JMP :+

MiniMap_Draw:
    LDA #<mapdata
    STA MiniMap_OWDrawBuf
    LDA #>mapdata
    STA MiniMap_OWDrawBuf+1  ; sat "mapdata" to the OWDrawBuf

    LDA #<mm_drawbuf
    STA MiniMap_DrawBuf
    LDA #>mm_drawbuf
    STA MiniMap_DrawBuf+1    ; reset this pointer to the start of its data
    
  : LDA #0
    STA minimap_ptr+1        ; reset the high byte of this pointer too
    
   @0100_Loop:               ; this loop happens every $0100 bytes
    LDA #0
    STA mm_pixrow            ; start drawing pixel row 0, increment by 1 row each loop

    @MainLoop:
        JSR DoMiniMapDrawVBlank ; wait for Vblank before drawing anything
       
        LDX mm_pixrow        ; put row in X -- X will be the loop up counter and source index
      @RowLoop:
        LDA minimap_ptr+1    ; set PPU address, with mm_pixrow being the low byte
        STA $2006
        STX $2006
        
        TXA                  ; use mm_pixrow as the Y offset  
        TAY                  ; MiniMap_DrawBuf is not incremented by the low byte
        LDA (MiniMap_DrawBuf), Y
        STA $2007            ; and draw it
        
        TXA
        CLC
        ADC #$08             ; add 8 to the index (moves to high bitplane if we're on the low bitplane
        TAX                  ;  (or to low plane of next tile if on high plane.  Does not change rows)
        BCC @RowLoop         ; keep looping until X wraps ($20 interations -- $10 tiles)

    LDA soft2000          ; drawing for this row is done -- reset the scroll
    STA $2000
    LDA #$00
    STA $2005
    LDA #$E0; 8
    STA $2005

    ; JSR Minimap_DrawSFX   ; play the ugly drawing sound effect
    ;; JIGS : STOP IT.

    LDA mm_pixrow         ; add 1 to our row counter
    CLC                   ; and mask low bits (0-7)
    ADC #1
    AND #$07
    STA mm_pixrow
    BNE @MainLoop         ; once it wraps 7->0, we've drawn 8 rows, so now...
    
    INC MiniMap_DrawBuf+1 ; increment the high byte of mm_drawbuf
    INC minimap_ptr+1     ; as well as the the destination to draw to
    LDA minimap_ptr+1     
    CMP #$0F              ; now see if its $0F
    BCC @0100_Loop        ; if not, do another $100 writes
    CMP #$10              ; see if its $10
    BNE :+                ; if not, jump ahead
       RTS                ; if it is, everything's drawn! so exit
   
  : LDA mapflags          ; get the map flag and see if its on the overworld and zoomed in 
    BPL @0100_Loop        ; if not, keep looping

    ;; But aha! Its row $0F on the zoomed in overworld: This needs to draw the text "_Press A to Zoom in_"
    ;; so overwrite the mm_drawbuf pointer with new data:
    LDA #<lut_ZoomMinimapTextCHR
    STA MiniMap_DrawBuf
    LDA #>lut_ZoomMinimapTextCHR
    STA MiniMap_DrawBuf+1    
    JMP @0100_Loop



DoMiniMapDrawVBlank: 
    LDA mapflags
    BPL @SetWait
    LDA minimap_ptr+1
    CMP #>$1000
    BEQ @SetWait
    
    JSR LongCall
    .word MinimapDecompress    ; decompress 2 rows of map data
    .byte BANK_OWMAP
    
   @SetWait: 
    LDA #79        ; and set scanline #71 as the one to break on
    STA $5203

   @WaitForScanline71:
    LDA $5204      ; high bit set when scanline #71 is being drawn
    BPL @WaitForScanline71
    
   @Scanline71:   
    LDX #$10       ; waits for H-blank so as not to draw weird dots on the screen
  : DEX        
    BNE :-    
    LDA soft2000
    EOR #$90       ; turn off sprites-as-background-tiles, but turn on the NMI bit thing if its off
    STA $2000
    LDA #207       ; set next break at scanline #199 
    STA $5203      
    
    JSR CallMusicPlay_L 
    LDA mapflags
    BPL @WaitForScanline199
    JSR OverworldMap_Prep
   
  @WaitForScanline199:
    LDA $5204      ; high bit set when scanline #199 is being drawn
    BPL @WaitForScanline199
    
   @Scanline199:   
    LDX #$10   
  : DEX        
    BNE :-    
    LDA soft2000         ; still has bit $10 set, so will set sprite CHR as background tiles again
    ORA #$80             ; turn on the NMI bit again just in case...
    STA $2000
    LDA #$00             ; and clear the scanline break register
    STA $5203      
   @LoopForever: 
    JMP @LoopForever     ; then loop forever! (or really until the NMI is triggered)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Minimap Prep Row  [$BDE7 :: 0x27DF7]
;;
;;    Decompresses two rows of map data, and 'merges' them into 1 row of
;;  pixels.  The pixels are dumped into the intermediate buffer 'mm_drawbuf'.
;;  Also, dungeon marker sprites are generated for tiles which require them
;;  in this routine.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; MinimapDecompress takes about 56 scanlines to decompress 2 rows.
;; It takes 5 scanlines to do 1 @MainLoop
;; 16 @MainLoops will be 80 scanlines
;; Music takes at least 16 scanlines
;; The screen must break on scanlines 71 and 199
;; So the order of logic is:
;; Decompress the map rows during the title drawing
;; Wait for the first scanline break at 71
;; Do the 16 @MainLoops, then wait for scanline 199
;; Wait for VBlank to start, do music


OverworldMap_Prep:
    LDA minimap_ptr+1
    CMP #>$1000                ; see if the high byte is #$10
    BNE :+
    RTS
  : LDA #0                     ; reset low byte of PPU addr to 0
    STA tmp
   ; LDY #0                     ; Y will be the x coord (column) counter
   ; STY tmp                    ;; JIGS - tmp is used as a backup for Y     

  @MainLoop:        ; tmp+7 is a counter to keep track of the number of bits
    LDY tmp         ;  that have yet to be shifted into the output CHR bytes
    LDA #8          ; since each byte is actually 8 pixels on a bitplane... multiple pixels          
    STA tmp+7       ; must be rotated into the same byte to be output as graphics.7    

  @RotateLoop:
    LDX mm_mapbuf, Y            ; here we get the minimap tileset data for 4 seperate
    LDA lut_MinimapTileset, X   ; map tiles (in a 2x2 square) and OR them together to combine
    LDX mm_mapbuf+1, Y          ; them to a single pixel.
    ORA lut_MinimapTileset, X   ;  This scales the map down from 256x256 tiles
    LDX mm_mapbuf2, Y           ;  to 128x128 pixels
    ORA lut_MinimapTileset, X
    LDX mm_mapbuf2+1, Y         ; after all this, A contains the output pixel (low 2 bits)
    ORA lut_MinimapTileset, X   ;  and bit 2 indicates whether or not a marker sprite needs to be placed here

    LSR A                       ; shift out low bit
    ROL mm_bplo                 ; rotate it into the low bitplane

    LSR A                       ; shift out the high bit
    ROL mm_bphi                 ; rotate into high bitplane

    LSR A                       ; shift out marker sprite flag
    BCC :+                      ; if set....
      JSR DrawOverworldSprite   ; ... generate a dungeon marker sprite

  : INY                         ; increment our X coord by 2
    INY                         
    DEC tmp+7                   ; decrement our bit counter
    BNE @RotateLoop             ; if more bits needed to fill our bitplanes... keep going

    ; @RotateLoop exits when 8 pixels have been shifted into both high and low
    ; bitplanes.
    STY tmp                    ; JIGS - backup Y - original code used X, but not these kinds of pointers!
    LDY minimap_ptr            ; use low byte of dest pointer as index for draw buffer

    LDA mm_bplo                ; copy both bitplanes to the appropriate areas of the buffer
    STA (MiniMap_OWDrawBuf), Y
    TYA
    CLC
    ADC #$08                   ; increment destination by 8
    TAY
    LDA mm_bphi
    STA (MiniMap_OWDrawBuf), Y
    TYA
    CLC
    ADC #$08                   ; and then another 8
    STA minimap_ptr            ; backing up the pointer
    BCC @MainLoop              ; if there was no carry, keep looping
    ; otherwise, if there was carry, we have completed a single row from 16 tiles (128 pixels)  
    
    INC mm_maprow              ; increment map row counter by 2
    INC mm_maprow

    LDA minimap_ptr            ; increment dest PPU address by 1 (next row of pixels)
    CLC
    ADC #1
    AND #$07                   ; and mask with 7 (0-7)
    STA minimap_ptr
    BNE :+
    INC MiniMap_OWDrawBuf+1
    LDA #0
    STA minimap_ptr
  : RTS







;; so while the overworld minimap compresses 4 tiles into 1 pixel...
;; this has to expand 1 tile into 4 pixels.
;; these are ALMOST the same routine, but completely different!

ZoomMap_Prep:
    LDA #0                     ; reset low byte of PPU addr to 0
    STA minimap_ptr

   @ZoomMap_PrepRow:
    LDA mapflags
    BPL :+

    JSR LongCall
    .word MinimapDecompress    ; decompress 2 rows of map data
    .byte BANK_OWMAP      

    LDA ow_scroll_x
    SEC
    SBC #32-7                  ; player's position is -7, but tiles start 32 to the left of the player
    STA ZoomMapPointer         ; save as low byte
    LDA #>mm_mapbuf            ; and use the map buffer instead of map data!
    STA ZoomMapPointer+1
 
  : LDA #0                     ; set here, in case MinimapDecompress used it
    STA tmp+1                  ; tmp+1 is used for sprite drawing

   @MainLoop:
    LDA #4                     ; this counter is only 4 instead of 8
    STA tmp+7
    
   @RotateLoop:
    INC tmp+1                   ; increment the tile-in-row counter
    LDY #0
    LDA (ZoomMapPointer), Y     ; get the tile from mapdata ($7000)
    TAY
    LDA (ZoomMapTilesetPtr), Y  ; get the bit plane info from this LUT
    PHA                         ; backup to stack
    AND #$03                    ; get only the low 2 bits (cut off the "this is a sprite) bit
    STA tmp                     ; and save them 
    PLA                         ; pull the original
    ASL A                       ; shift the bits left twice, then ORA with the 2 low bits
    ASL A                       ; this doubles the amount of pixel bits without needing
    ORA tmp                     ; to complicate the tileset data!
    
    ;; taking out the PHA, AND #$03, STA tmp, PLA instructions...
    ;; will result in tiles marked with 4 and 6 drawing stripes!
    
    LSR A                       ; now right shift it out
    ROL mm_bplo                 ; and into the low bit plane
    LSR A
    ROL mm_bphi                 ; then into the high bit plane
    LSR A
    ROL mm_bplo                 ; do the same with the next 2 bits
    LSR A
    ROL mm_bphi                  
    LSR A
    BCC :+
        JSR DrawZoomSprite
  : INC ZoomMapPointer          ; increment the source address
    BNE :+
       INC ZoomMapPointer+1     ; and high byte when the low byte wraps
  : DEC tmp+7
    BNE @RotateLoop  

    LDY minimap_ptr
    LDA mm_bplo
    STA (MiniMap_DrawBuf), Y     ; double the bit planes in the draw buffer
    INY                          ; INC Y and 
    STA (MiniMap_DrawBuf), Y     ; do the next one
    TYA
    CLC 
    ADC #07                      ; add 7, then back into Y
    TAY
    LDA mm_bphi
    STA (MiniMap_DrawBuf), Y     ; two more writes...
    INY
    STA (MiniMap_DrawBuf), Y      
    TYA
    CLC
    ADC #07                      ; add another 7 (+INY) then back it up
    STA minimap_ptr
    BCC @MainLoop                ; if there was no carry, keep looping
    ; otherwise, if there was carry, we have completed a single row from 16 tiles (128 pixels)
    
    INC mm_maprow                ; increment map row counter by 1
    INC tmp+6                    ; along with the non-offset row counter for sprite locations

    LDA minimap_ptr              ; increment dest PPU address by 2 (next NEXT row of pixels)
    CLC
    ADC #2
    AND #$07                     ; and mask with 7 (0-7)
    STA minimap_ptr
    BNE @ZoomMap_PrepRow         ; once it wraps from 7->0, we've filled 256 bytes of graphic data (8 rows of pixels)

    INC MiniMap_DrawBuf+1        ; increment high byte of source
    INC minimap_ptr+1            ; increment high byte of PPU dest
    LDA minimap_ptr+1
    CMP #>$1000
    BEQ @Done
        JMP ZoomMap_Prep             ; loop until PPU dest=$1000 (filling entire left pattern table)
   @Done:  
    RTS












  

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Minimap - Draw "You Are Here" sprite [$BF34 :: 0x27F44]
;;
;;     Clears OAM and draws the "you are here" marker sprite
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


Overworld_YouAreHere:
;    LDX #0
;    STX sprindex      ; clear the sprite index
;
;    LDA #$F8          ; flood OAM with $F8 (to clear it -- moves all sprites offscreen, making them invisible)
;   @Loop:
;      STA oam, X
;      INX
;      BNE @Loop       ; $100 iterations (all of OAM)

    LDA #$82
    STA oam+1         ; "you are here" sprite for the full overworld uses tile $82
    
    LDA #0
    STA oam+2         ; set sprite attributes (palette 0, no flipping, foreground priority)  

    LDA ow_scroll_x   ; get scroll X
    CLC
    ADC #$07          ; add 7 to get player position
    LSR A             ; divide that by 2 to scale to minimap (world map is 256x256 -- minimap is 128x128)
    CLC
    ADC #$3D          ; add $3D to offset it so it starts at the start of the map
    STA oam+3, X      ; record as X coord

    LDA ow_scroll_y   ; do the same to get Y coord
    CLC
    ADC #$07
    LSR A
    CLC
    ADC #$4C          ; and add more since the map is lower than the in the original game
    STA oam+0         ; record as Y coord
    RTS               ; and exit!

ZoomMap_YouAreHere:
    LDX #0
    STX sprindex      ; clear the sprite index

    LDA #$F8          ; flood OAM with $F8 (to clear it -- moves all sprites offscreen, making them invisible)
   @Loop:
      STA oam, X
      INX
      BNE @Loop       ; $100 iterations (all of OAM)
      
    ;; X = 0
    STX oam+2         ; set sprite attributes (palette 0, no flipping, foreground priority)        

    LDA #$80
    STA oam+1         ; "you are here" sprite for zoomed in minimap uses tile $80

    LDA mapflags
    BMI @OverworldZoom

    LDA sm_scroll_x   ; get scroll X
    CLC
    ADC #$07          ; add 7 to get player position
    ASL A             ; divide that by 2 to scale to minimap (world map is 256x256 -- minimap is 128x128)
    CLC
    ADC #$3D          ; add $3D to offset it so it starts at the start of the map
    STA oam+3         ; record as X coord

    LDA sm_scroll_y   ; do the same to get Y coord
    CLC
    ADC #$07
    ASL A
    CLC
    ADC #$4C          ; but add a little less ($34 instead of $3D)
    STA oam+0         ; record as Y coord
    RTS               ; and exit!
    
   @OverworldZoom:    ; simply put it over the center where the player will be
    LDA #127-2
    STA oam+3, X      ; record as X coord

    LDA #127+13
    STA oam+0         ; record as Y coord
    RTS


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Draw Dungeon Sprite  [$BE30 :: 0x27E40]
;;
;;    Draws a town/dungeon marker sprite at given coords
;;
;;  IN:  mm_maprow = y coord on world map
;;               Y = x coord on world map
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; JIGS - this saves to another sprite buffer first, then copies to OAM later

DrawOverworldSprite:
    LDA sprindex          ; Add 4 to the sprite index (drawing a single sprite -- 4 bytes)
    CLC                   ;  do this before drawing the sprite to leave sprite 0 alone
    ADC #$04              ;  since that is the party position sprite
    STA sprindex
    TAX                   ; put sprite index in X for indexing

    LDA mm_maprow         ; get Y coord
    LSR A                 ; divide by 2 (minimap display is 128x128 -- world map is 256x256)
    CLC
    ADC #$4C              ; add $34 to offset the sprite to the start of the map on the screen
    STA mm_spritebuf, X   ; write this as Y coord of sprite

    LDA #$83
    STA mm_spritebuf+1, X ; use tile $81

    LDA #$00
    STA mm_spritebuf+2, X ; attributes (palette 0, no flipping, foreground priority)

    TYA                   ; get the X coord
    LSR A                 ; divide by 2 for same reason
    CLC
    ADC #$3D              ; add $3D to offset it to start of the map
    STA mm_spritebuf+3, X ; write as X coord

    RTS                   ; done!


DrawZoomSprite:
    LDA tmp+6        ; does this sprite show up where the "Press A to zoom out" text cuts off the map?
    CMP #60          ; if so, don't draw it!
    BCS @RTS

    LDA sprindex     ; Add 4 to the sprite index (drawing a single sprite -- 4 bytes)
    CLC              ;  do this before drawing the sprite to leave sprite 0 alone
    ADC #$04         ;  since that is the party position sprite
    STA sprindex
    TAX              ; put sprite index in X for indexing

   @NormalZoom:
    LDA tmp+6        ; get Y coord - 0-64
    ASL A            ; double it
    CLC
    ADC #$4C         ; add $34 to offset the sprite to the start of the map on the screen
    STA oam, X       ; write this as Y coord of sprite

    LDA #$81
    STA oam+1, X     ; use tile $81

    LDA #$00
    STA oam+2, X     ; attributes (palette 0, no flipping, foreground priority)

    LDA tmp+1        ; get tile in the row, 0-64
    ASL A            ; multiply by 2
    CLC
    ADC #$3B         ; add $3D to offset it to start of the map
    STA oam+3, X     ; write as X coord

   @RTS:
    RTS              ; done!




;; This mess of a routine sets up the whole minimap screen.
;; First it fills the nametable with the necessary data:
;; * the Final Fantasy title    
;; * the top of the map's paper borders (which use sprite CHR as background tiles)
;; * all the blank rows in between
;; * the box in the center that wholes the whole BG CHR
;; * the bottom of the map's paper borders (again, sprite CHR)
;; * then fills up the attributes
;; * wipes BG CHR so it can be drawn to while the screen is on
;; * loads the palettes, based on map ID
;; * loads the sprite CHR 
;; * clear the zoomed out overworld's OAM buffer
;; * maybe something else I forgot
;; and it seems like every other step it has to check if its doing
;; the original overworld, the zoomed-in overworld, or a small 64*64 tile map!

EightWrites:
    LDY #8

DoWrites:
    STA $2007
    DEY
    BNE DoWrites
    RTS

MiniMap_FillNTPal:
    LDA #$08           ; write to soft2000 to clear NT scroll
    STA soft2000
    ASL A
    STA tmp            ; $10 is loop counter for the map tiles
    
    LDA mapflags
    LSR A
    BCS :+
      LDA #$FF
      BNE @SetFillTile ; if doing the overworld, use $FF as fill value
   
    ; otherwise, get the fill value from this LUT.
    ; this is because, while most maps have the bottom right 4 tiles blank
    ; some of them don't, and will fill the whole screen with whatever pixels it draws there
  : LDX cur_map   
    LDA lut_MapTilesetFillTile, X
    
   @SetFillTile:
    STA tmp+1

   ; 
   ; draw the NT data at lut_MinimapNT
   ;

    LDA $2002          ; reset PPU toggle
    LDA #>$2000        ; set PPU address to $2000  (start of nametables)
    STA $2006
    LDX #<$2000
    STX $2006

    LDY #$20
    LDA #$84           ; the 84th tile in the sprite CHR should be filled with black 
    JSR DoWrites
    
    ;; do the title from this lut
    
    LDX #0
   @Title:
    LDA lut_MinimapTitle, X
    STA $2007
    INX
    CPX #$80
    BNE @Title
    
    LDY #$20
    LDA #$84           ; the 84th tile in the sprite CHR should be filled with black 
    JSR DoWrites    

    ;; now the edge of the map page, which is just 0-40 in sequence

    LDX #0
   @MapTopLoop:
    STX $2007
    INX
    CPX #$40
    BNE @MapTopLoop
   
    LDX #0
   @ZoomMapLoop:             ; fill middle of nametable with $0-$FF in sequence
    LDA tmp+1
    JSR EightWrites          ; with both the sides being 8 filltiles in a row
    
   @ZoomMap_InnerLoop:
    STX $2007
    INX
    TXA
    AND #$0F
    BNE @ZoomMap_InnerLoop
    
    LDA tmp+1
    JSR EightWrites
    DEC tmp                  ; decrement the row counter for this part
    BNE @ZoomMapLoop
    
    LDX #$40                 ; then 40-80 in sequence are the bottom of the map page
   @MapBottomLoop:
    STX $2007
    INX
    CPX #$80
    BNE @MapBottomLoop    

    LDY #$80
    LDA #$84
    JSR DoWrites
    
    ;; should be on the attribute table now

    LDY #$08
    LDA #0
    JSR DoWrites
    LDY #$08
    LDA #$A0
    JSR DoWrites    
    LDY #$20
    LDA #$55 
    JSR DoWrites
    LDY #$08
    LDA #$0A
    JSR DoWrites
    LDY #$08
    LDA #0
    JSR DoWrites    
    
   ;
   ; clear the BG pattern table
   ;

    LDA $2002           ; reset PPU toggle
    LDA #>$0000         ; set PPU address to $0000 (start of BG pattern table)
    STA $2006
    LDA #<$0000
    STA $2006

    ;; since the overworld doesn't use the background color, but the dungeon maps do,
    ;; the BG pattern table needs to be filled with 8 $FFs, then 8 $0s
    ;; so tmp is set to either $FF or $0

    LDA mapflags
    ASL A
    BCC @FillDungeon
        LDA #$FF
        BMI :+

   @FillDungeon:
    LDA #0
  : STA tmp
  
    LDX #$00                 ; X is row counter
   @ClearCHRLoop_Start: 
    LDA tmp
    JSR EightWrites
    LDA #0
    JSR EightWrites
    DEX
    BNE @ClearCHRLoop_Start  ; $1000 iterations (full BG pattern table)

   ;
   ; load CHR for sprites ("you are here" mark, and town/dungeon points)
   ;

    LDA #<lut_NewMinimapCHR
    STA tmp
    LDA #>lut_NewMinimapCHR
    STA tmp+1
    LDA #$10
    LDX #11
    JSR CHRLoadToA
    ;; that loads up the map edges and sprite thingies

   ;
   ; load BG palettes for this screen
   ;

    LDA mapflags
    BPL @GetMapPal
    
   @ZoomOverworldPalette:    
    LDX #0
    BEQ @LoadMapPal

   @GetMapPal:    
    LDX cur_map
    LDA lut_MapTilesetPalette, X
    ASL A
    TAX
    
   @LoadMapPal: 
    LDA lut_ZoomMapPalettes, X
    STA tmp
    LDA lut_ZoomMapPalettes+1, X
    STA tmp+1
    
    LDY #$0C
   @PalLoop:
    LDA (tmp), Y          ; copy color from LUT
    STA cur_pal, Y        ;  to palette
    DEY
    BPL @PalLoop          ; loop until X wraps ($10 iterations)

    LDA cur_pal           ; copy the background color to the mirrored copy in the sprite palette
    STA cur_pal+$10       ;  this ensures the BG color will be what's desired when the palette is drawn

    LDA #$0F
    STA cur_pal+$11       ; start the "you are here" sprite
    STA cur_pal+$12       ;  and the town/dungeon marker sprite at $0F black

    LDX #0
    LDA #$F8
   @ClearOAMBuffer: 
    STA mm_spritebuf, X
    INX
    BNE @ClearOAMBuffer

   ;
   ;  Do last minute PPU stuff before exiting
   ;

    LDA soft2000
    ORA #$10              ; start each VBlank with sprites as the background
    STA soft2000

    LDA #$00              ; set scroll 
    STA $2005             
    LDA #$E0; 8
    STA $2005             
    RTS                   ; then exit!











.byte "END OF BANK 13"
