.include "Constants.inc"
.include "variables.inc"
.include "macros.inc"
.feature force_range
.segment "BANK_14"

BANK_THIS = $14

.export lut_MapObjCHR
.export lut_SmallMapObjCHR
.export lut_OWMapObjCHR

lut_MapObjCHR:
.incbin "chr/class/fighter_mapsprite.chr"
.incbin "chr/class/thief_mapsprite.chr"
.incbin "chr/class/blackbelt_mapsprite.chr"
.incbin "chr/class/redmage_mapsprite.chr"
.incbin "chr/class/whitemage_mapsprite.chr"
.incbin "chr/class/blackmage_mapsprite.chr"
.incbin "chr/class/unused_mapsprite.chr"
.incbin "chr/class/unused_mapsprite.chr"
.incbin "chr/class/knight_mapsprite.chr"
.incbin "chr/class/ninja_mapsprite.chr"
.incbin "chr/class/master_mapsprite.chr"
.incbin "chr/class/redwizard_mapsprite.chr"
.incbin "chr/class/whitewizard_mapsprite.chr"
.incbin "chr/class/blackwizard_mapsprite.chr"
.incbin "chr/class/unused_mapsprite.chr"
.incbin "chr/class/unused_mapsprite.chr"

lut_OWMapObjCHR:
.incbin "chr/npc_sprites/shadow_bridge_canal_tiles.chr"
.incbin "chr/npc_sprites/ship_sprite.chr"
.incbin "chr/npc_sprites/airship_sprite.chr"
.incbin "chr/npc_sprites/canoe_sprite.chr"

;; ?? -- unused garbage filler...?

;.byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
;.byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
;.byte $02,$25,$38,$3A,$02,$16,$14,$19,$02,$2C,$30,$27,$02,$26,$31,$17
;.byte $02,$25,$38,$3A,$02,$16,$14,$19,$02,$2C,$30,$27,$02,$26,$31,$17
;.byte $02,$25,$38,$3A,$02,$16,$14,$19,$02,$2C,$30,$27,$02,$26,$31,$17
;.byte $02,$25,$38,$3A,$02,$16,$14,$19,$02,$2C,$30,$27,$02,$26,$31,$17
;.byte $02,$25,$38,$3A,$02,$16,$14,$19,$02,$2C,$30,$27,$02,$26,$31,$17
;.byte $02,$25,$38,$3A,$02,$16,$14,$19,$02,$2C,$30,$27,$02,$26,$31,$17

lut_SmallMapObjCHR:
.incbin "chr/npc_sprites/princess_sprite.chr"   ; 00
.incbin "chr/npc_sprites/woman_sprite.chr"      ; 01
.incbin "chr/npc_sprites/oldlady_sprite.chr"    ; 02
.incbin "chr/npc_sprites/dancer_sprite.chr"     ; 03
.incbin "chr/npc_sprites/orb_sprite.chr"        ; 04
.incbin "chr/npc_sprites/witch_sprite.chr"      ; 05
.incbin "chr/npc_sprites/prince_sprite.chr"     ; 06
.incbin "chr/npc_sprites/soldier_sprite.chr"    ; 07
.incbin "chr/npc_sprites/scholar_sprite.chr"    ; 08
.incbin "chr/npc_sprites/punk_sprite.chr"       ; 09
.incbin "chr/npc_sprites/man_sprite.chr"        ; 0A
.incbin "chr/npc_sprites/sage_sprite.chr"       ; 0B
.incbin "chr/npc_sprites/dwarf_sprite.chr"      ; 0C
.incbin "chr/npc_sprites/mermaid_sprite.chr"    ; 0D
.incbin "chr/npc_sprites/lefein_sprite.chr"     ; 0E
.incbin "chr/npc_sprites/king_sprite.chr"       ; 0F
.incbin "chr/npc_sprites/broom_sprite.chr"      ; 10
.incbin "chr/npc_sprites/bat_sprite.chr"        ; 11
.incbin "chr/npc_sprites/garland_sprite.chr"    ; 12
.incbin "chr/npc_sprites/pirate_sprite.chr"     ; 13
.incbin "chr/npc_sprites/fairy_sprite.chr"      ; 14
.incbin "chr/npc_sprites/robot_sprite.chr"      ; 15
.incbin "chr/npc_sprites/dragon_sprite.chr"     ; 16
.incbin "chr/npc_sprites/bahamut_sprite.chr"    ; 17
.incbin "chr/npc_sprites/elfwoman_sprite.chr"   ; 18
.incbin "chr/npc_sprites/elfman_sprite.chr"     ; 19
.incbin "chr/npc_sprites/elfprince_sprite.chr"  ; 1A
.incbin "chr/npc_sprites/slab_sprite.chr"       ; 1B
.incbin "chr/npc_sprites/titan_sprite.chr"      ; 1C
.incbin "chr/npc_sprites/vampire_sprite.chr"    ; 1D


 .byte "END OF BANK 14"
