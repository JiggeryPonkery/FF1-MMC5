; JIGS - 
; All data that is saved to each game slot is in "work RAM" at $5C00
; Saving temporarily wipes RAM from $6000 to $7FFF so make sure nothing important is there that needs to be constant while on the save screen.

;; JIGS - this is the new area for all save-game related things...

unsram          = $5C00  ; $400 bytes
sram            = $6400  ; $400 bytes ; but these are all on the swapped ram side
sram2           = $6800  ; $400 bytes
sram3           = $6C00  ; $400 bytes
sram_checksum   = sram + $1D
sram_assert_55  = sram + $1E
sram_assert_AA  = sram + $1F
sram2_checksum  = sram2 + $1D
sram2_assert_55 = sram2 + $1E
sram2_assert_AA = sram2 + $1F
sram3_checksum  = sram3 + $1D
sram3_assert_55 = sram3 + $1E
sram3_assert_AA = sram3 + $1F

ow_flags        = unsram + $00 ; see Overworld Flags in Constants
ship_x          = unsram + $01
ship_y          = unsram + $02
airship_x       = unsram + $03
airship_y       = unsram + $04
bridge_x        = unsram + $05
bridge_y        = unsram + $06
canal_x         = unsram + $07
canal_y         = unsram + $08
ow2_vehicle_x   = unsram + $09
ow2_vehicle_y   = unsram + $0A
unsram_ow2_scroll_x = unsram + $0B
unsram_ow2_scroll_y = unsram + $0C
unsram_ow_scroll_x  = unsram + $0D
unsram_ow_scroll_y  = unsram + $0E
unsram_vehicle      = unsram + $0F

Options          = unsram + $10 ; see Option Flags in Constants
BattleTextSpeed  = unsram + $11
BattleBGColor    = unsram + $12
smokebomb_steps  = unsram + $13
battleswon       = unsram + $14
battlesrun       = unsram + $15
gold             = unsram + $16 ; 17 ; 18 - 3 bytes
playtimer        = unsram + $19 ; 1A ; 1B ; 1C - 4 bytes - game clock!
; checksum       = unsram + $1D
; assert 55      = unsram + $1E
; assert AA      = unsram + $1F

items           = unsram + $20
item_pageswap   = items
item_heal       = unsram + $21
item_x_heal     = unsram + $22
item_ether      = unsram + $23
item_elixir     = unsram + $24
item_pure       = unsram + $25
item_soft       = unsram + $26
item_down       = unsram + $27
item_tent       = unsram + $28
item_cabin      = unsram + $29
item_house      = unsram + $2A
item_eyedrops   = unsram + $2B
item_smokebomb  = unsram + $2C
item_alarm      = unsram + $2D
item_unknown1   = unsram + $2E
item_unknown2   = unsram + $2F
item_qty_stop   = keyitems

keyitems        = unsram + $30
keyitems_1      = unsram + $30
keyitems_2      = unsram + $31
keyitems_3      = unsram + $32
keyitems_4      = unsram + $33
; unused        = unsram + $34
; unused        = unsram + $35
; unused        = unsram + $36
; unused        = unsram + $37
; unused        = unsram + $38
; unused        = unsram + $39
; unused        = unsram + $3A
lead_index      = unsram + $3B ; for the map sprite stuff
orb_fire        = unsram + $3C
orb_water       = unsram + $3D
orb_air         = unsram + $3E
orb_earth       = unsram + $3F

inv_equip       = unsram + $40
inv_weapon      = unsram + $40 ; 32 bytes compressed, 2 weapons per byte
inv_armor       = unsram + $60 ; 32 bytes compressed, 2 armors per byte
inv_magic       = unsram + $80 ; 64 bytes compressed, 2 spells per byte 
inv_enskill     = unsram + $C0 ; 48 bytes compressed, 2 attacks per byte
inv_skills      = unsram + $D8 ; 16 bytes compressed, 2 skills per byte
inv_class       = unsram + $E8 ; 16 bytes compressed, 2 skills per byte

;ONLY NEEDS 4 BYTES FOR SKILLS AND CLASSES!! 

ch_stats          = unsram + $0100 ; MUST be on page bound.  Each character allowed $40 bytes, so use 00,40,80,C0 to index ch_stats
ch_class          = ch_stats + $00 
ch_sprite         = ch_stats + $01
ch_skills         = ch_stats + $02
  ch_skill1       = ch_skills + $00  ; $02
  ch_skill2       = ch_skills + $01  ; $03
  ch_skill3       = ch_skills + $02  ; $04
  ch_skill4       = ch_skills + $03  ; $05
ch_attackperks    = ch_stats + $06
ch_defendperks    = ch_stats + $07
ch_miscperks      = ch_stats + $08
ch_critperks      = ch_stats + $09 
ch_weaponmastery  = ch_stats + $0A ; 0B - 2 bytes
ch_armormastery   = ch_stats + $0C ; 0D - 2 bytes
;                 = ch_stats + $0E
;                 = ch_stats + $0F

ch_level          = ch_stats + $10 ; OB this is 0 based, IB this is 1 based
 ch_mainstats     = ch_stats + $11
ch_strength       = ch_stats + $11
ch_agility        = ch_stats + $12
ch_intelligence   = ch_stats + $13 
ch_vitality       = ch_stats + $14
ch_speed          = ch_stats + $15
 ch_substats      = ch_stats + $16
ch_damage         = ch_stats + $16 ; unarmed damage
ch_hitrate        = ch_stats + $17 ; unarmed hitrate
ch_evasion        = ch_stats + $18 ; unarmed evasion
ch_magicdefense   = ch_stats + $19 ; unarmed magic defense
ch_morale         = ch_stats + $1A
ch_joblevel       = ch_stats + $1B 
ch_jobexp         = ch_stats + $1C
ch_exp            = ch_stats + $1D ; 1E, 1F - 3 bytes

ch_righthand      = ch_stats + $20
ch_lefthand       = ch_stats + $21
ch_head           = ch_stats + $22
ch_body           = ch_stats + $23
ch_hands          = ch_stats + $24
ch_accessory      = ch_stats + $25
ch_bag1           = ch_stats + $26  
ch_bag2           = ch_stats + $27  
ch_mp             = ch_stats + $28 ; 29, 2A, 2B, 2C, 2D, 2E, 2F - 8 bytes

ch_ailments       = ch_stats + $30
ch_basehp         = ch_stats + $31 ; 32 - 2 bytes
ch_curhp          = ch_stats + $33 ; 34 - 2 bytes
ch_maxhp          = ch_stats + $35 ; 36 - 2 bytes
;                 = ch_stats + $33
;                 = ch_stats + $34
;                 = ch_stats + $35
;                 = ch_stats + $36
;                 = ch_stats + $37
;                 = ch_stats + $38
ch_name           = ch_stats + $39 ; 3A, 3B, 3C, 3D, 3E, 3F - 7 bytes 

ch_spells         = ch_stats + $100 ; $18 bytes
ch_classlevels    = ch_spells + $18 ; $28 bytes

game_flags        = unsram + $0300  ; must be on page bound



;; Temporary RAM 
tmp                     = $00 ; 16 bytes

ExpGainOption           = $0B
MoneyGainOption         = $0C
EncRateOption           = $0D
MuteSFXOption           = $0E
AutoTargetOption        = $0F 

;; Controls & Movement  
joy                     = $10
joy_ignore              = $11
joy_select              = $12
joy_start               = $13
joy_a                   = $14
joy_b                   = $15
joy_prevdir             = $16
facing                  = $17 ; 1=R  2=L  4=D  8=U
move_speed              = $18 ; pixels to move per frame (map)
ow_slow                 = $19 ; halves movement speed when walking (1 pixel every 2 frames)
move_ctr_x              = $1A ; pixels between tiles (map movement -- 00-0F)
move_ctr_y              = $1B ; ditto but for Y axis (JIGS - can these be combined?)
battlestep              = $1C
vehicle_next            = $1D ; vehicle player is walking onto ; must be 1 when entering overworld from a map, if set to 8, will load characters onto airship and position airship where player is!
vehicle                 = $1E ; 1 = walking, 2 = canoe, 4 = ship, 8 = airship ; set automaticly on OW, unused in SM
vehchgpause             = $1F ; forced pause when changing vehicles ; all Vehicle things can be shared

;; Map Things           
mapflags                = $20 ; bit 0 set when in standard map.  bit 1 set to indicate column drawing instead of row drawing
ow_scroll_x             = $21 ; X scroll of OW in tiles
ow_scroll_y             = $22 ; Y scroll in tiles
sm_scroll_x             = $23 ; ditto, but for standard maps
sm_scroll_y             = $24
mapdraw_x               = $25
mapdraw_y               = $26
mapdraw_nty             = $27
mapdraw_ntx             = $28
scroll_y                = $29 ; Y scroll in tiles (16x16).  range=0-E
mapspritehide           = $2A ; nonzero if in forest
mapdraw_job             = $2B ; 0 = no job, 1 = draw attribs, 2 = draw tiles
cur_map                 = $2C
cur_tileset             = $2D
cur_mapobj              = $2E ; counter for updating which map object
battlestep_sign         = $2F ; controls whether or not battlestep goes up or down ; uses high 3 bits
airship_vis             = $2F ; uses low 5 bits

;; Standard Map Things  
tileprop                = $30 ; 2 bytes
tileprop_now            = $32 ; 2 bytes special tile properties that we're on (tileprop isn't necessarily what we're standing on)
tileprop_last           = $34 ; 1 byte

;; v shared v           
wateraccess             = $35 ; for moving into water
sm_player_x             = $36 ; player X/Y position on standard map.  Only used for NPC collision detection
sm_player_y             = $37
domappoison             = $38
;                       = $39
;                       = $3A
;                       = $3B
battlerate              = $3C ; X/256 chance of a random encounter occuring (SM only apparently)
inroom                  = $3D ; bit 7 is the actual inroom flag.  $x2=entering room, $x1=entering locked room (different sprite vis), $x5=exiting room, $x6=exiting locked room
doorppuaddr             = $3E ; 2 bytes, PPU address of door drawing work

;; Story Things - Shared ; Story stuff happens on overworld or end of the game
story_page              = $35 
story_timer             = $36 
shutter_a               = $37 
shutter_b               = $38 
story_dropinput         = $39 
story_credits           = $3A 
theend_x                = $3B
theend_y                = $3C
theend_src              = $3D

;; Minimap - Shared     
mm_bplo                 = $35 
mm_bphi                 = $36 
mm_pixrow               = $37 
mm_maprow               = $38 
minimap_ptr             = $39 ; + A 

;; Minigame - Shared    
mg_slidespr             = $35 ; + 6, 7 
mg_slidedir             = $38 

;; 1-bit item decompression
item_bit_ram            = $40

;; Box Drawing Things   
btldraw_box_id          = $40
btldraw_width           = $41
btldraw_width_counter   = $46

box_x                   = $40
box_y                   = $41
box_wd                  = $42 ; shared
box_ht                  = $43 ; shared
dest_wd                 = $42 ; for drawing image rectangles
dest_ht                 = $43 
btldraw_max             = $44 ; maximum characters to draw
dest_x                  = $44 ; NOT used in battle box drawing?
dest_y                  = $45
;                       = $46 ; this variable can be used outside of battle, but not in battle
image_ptr               = $47 ; + 8 - for images
text_ptr                = $47 ; + 8 - for text
;                       = $49 ; 
format_buf              = $50 ; 7 bytes, goes in reverse (4A-50) -- must not cross page bound
;; $50 must stay 0 to null-terminator the format_buf

;; Cursor               
cursor                  = $51
cursor_max              = $52
cursor_x                = $53 
cursor_y                = $54 
cursoradd               = $55 ; naming characters
cursor_change           = $55 ; magic menu 
backup_cursor           = $56 ; shops, menus
submenu_cursor          = $57 ; for item menus, to not reset the cursor when exiting a sub-menu
shop_cursor_ptr         = $56 ; + 7 ; used in shops only
submenu_targ            = $58 ; also used in battle for the ether menu

;; Dialogue Things - shared
talkobj                 = $51 ; shared -- object you're talking to on SM
dlg_itemid              = $52 ; shared
DialogueBank            = $53 ; important for dialogue
treasure_offset         = $54 ; stores the chest's item name printing code (weapons and armor use a different code)

;; Menu Things - Shared 
equipoffset             = $59 ; menus
hp_recovery             = $59 ; +5A tmp bytes for amount of HP to heal with potions and spells
using_item              = $5B ; item ID for item menu use
mp_required             = $5B ; offset for spell level to decrease when casting (menus only)
descboxopen             = $5C ; marks the description box is open
WeaponOrArmorPage       = $5D ; equip menu, swaps between weapons/armour
equipmenu_tmp           = $5E ; for unequip/reequipping
weasels                 = $5F ; Important for saving/loading, and sound test menu
char_id                 = $60 ; equip menu

;; Shop Things - Shared 
shop_id                 = $5A
shop_type               = $5B
item_box_offset         = $5C 
item_box_offset_old     = $5D 
inv_canequipinshop      = $5E 
blank_item              = $5F

shop_curprice           = $60 ; + 1, 2, 3 - 4 bytes ; will mess up buying things if shared
shop_curitem            = $64
shop_amount             = $65
shop_amount_high        = $66
shop_amount_buy         = $67
shop_amount_max         = $68
shop_charindex          = $69
shop_spell              = $6A
shop_descriptionset     = $6A
shop_selling            = $6B
shop_cursorchange       = $6C
shop_listdrawn          = $6D
shop_listactive         = $6E
char_index              = $6F ; for printing character stats in menus and sprites in battle

ItemToUnequip           = $70 ; used in equip menu
ItemToEquip             = $71 ; used in equip menu
ItemOverflow            = $72 ; used in equip menu
slotcheck               = $73
equip_impossible        = $74 ; also used in equip menu
shop_x_price            = $75
shop_drawmarks          = $76
DualWieldStats          = $77
ArmorSlot               = $78
EquipPermissions        = $7A ; 7B, 7C, 7D, 7E, 7F ; 6 bytes
MenuStats               = $7A ; 7B, 7C, 7D, 7E, 7F ; 6 bytes 

;; Battle Things - Shared

btlcurs_rowshift        = $55
;                       = $56 
btlmag_movement         = $57
; submenu_targ - shared  ; $58
btlformation            = $59 ; don't write over, is used to check for Chaos fight
ow_tile                 = $5A ; only used for getting battle backdrop from overworld tile
btl_drawflags_tmp1      = $5A ; tmp storage for drawing sleep/stone/dead character sprites
btl_drawflags_tmp2      = $5B  
btl_drawflags_tmp3      = $5C  
btldraw_src             = $5A ; + B, source data
btldraw_dst             = $5C ; + D, destination pointer
btldraw_subsrc          = $5E ; + F, source pointer of substring

BattleCharID            = $60 ; Character ID (0, 1, 2, 3) for currently acting character
EntityRegenID           = $60 ; Temp ID of character or enemy being poisoned/regenerated
btl_loadenstats_index   = $60 ; Temp index of enemy whose stats are being loaded before battle
btl_loadenstats_count   = $61 ; Temp counter for loading enemy stats before battle
battle_class            = $61 ; Temp storage of clas for doing skills in battle
ailment_backup          = $61 ; Temp storage of ailment while doing a character's turn
EntityRegenCounter      = $61 ; Temp counter for poisoning/regenerating enemies between turns
PlayMagicSound          = $62 ; ID of magic sound effect to play in battle
Woosh                   = $63 ; counter for animating magic
BattleTurn              = $64 ; Keeps track of battle turns and displays them above the character's names ; shared
AutoTargetOptionBackup  = $65 ; for battling fast

btlsfx_framectr         = $66 ; The total frame counter for the entire sound effect
btlsfxsq2_len           = $67 ; 
btlsfxnse_len           = $68 ; 
btlsfxsq2_framectr      = $69 ; 
btlsfxnse_framectr      = $6A ; 
btlsfxsq2_ptr           = $6B ; + C 
btlsfxnse_ptr           = $6D ; + E 
; char_index not shared = $6F

;; Battle Temp          
btltmp                  = $70 ; 16 bytes

;; Level up things

LevelUp_PrintHP         = $69 ; + A
LevelUp_PrintLevel      = $6B ; + C
LevelUp_StatData        = $6D
LevelUp_MPData          = $6E
LevelUp_MPCap           = $6F


;;
;; Pointers - these are all 2 bytes each unless otherwise specified
;;

;; leveling up
eob_gp_reward           = $6B ; + C
eob_exp_reward          = $6D ; + E ;; these two can't be in the $70s because btltmp gets swapped when printing

LevelUp_Pointer         = $70 ; these also hold EXP and EXP to Next for the status menu
LevelUp_Reward          = $72 ; <--/ 
battlereward            = $78 ; 3 bytes.  Note that while this var is 3 bytes, this stop behaving properly
;                             ;  if rewards ever exceed the 2-byte boundary, since the game assumes you
;                             ;  will never receive more than 65535 XP/GP in any one battle.
lvlup_chstats           = $80 ; 2 byte pointer to character's OB stats


ZoomMapPointer          = $80 ; for mini map stuff
ZoomMapTilesetPtr       = $82
MiniMap_DrawBuf         = $84 
MiniMap_OWDrawBuf       = $86 

CharStatsPointer        = $80 
CharBackupStatsPointer  = $82 ; for changing party formation after battle
EnemyRAMPointer         = $82 ; pointer to enemy's adjustable stats
EnemyROMPointer         = $84 ; pointer to enemy's hard stats
OneBitPointer           = $84 ; for adjusting compressed inventory
BattleTmpPointer        = $86 
MagicPointer            = $86 ; pointer to magic data in RAM, v shared
WeaponPointer           = $86 ; pointer to weapon data in RAM ^ shared
BattleTmpPointer2       = $88 ; this pointer is often used by things 
EnemyAIPointer          = $8A
BattleBoxString         = $8A 
btldraw_blockptrstart   = $8C ; 8D? 
btldraw_blockptrend     = $8E ; 8F? 

;;General NES things    

ppu_dest                = $90 ; 2 bytes
cur_bank                = $92
ret_bank                = $93
actual_bank             = $94
sprindex                = $95
spr_x                   = $96
spr_y                   = $97
NTsoft2000              = $98 ; same as soft2000, but used to track coarse NT scroll
soft2000                = $9A
menustall               = $9B ; see MenuCondStall in bank $1F for explanation
ScreenShakeCounter      = $9B ; used in battle and silent errors
dlgbox_row              = $9C ; counts down from 7 when drawing dialogue box; nothing else 
npcdir_seed             = $9D ; RNG seed for determining direction for NPCs to walk
framecounter            = $9E ; Used for frame effects (palettes, flashing, ship noise)
InBattle                = $9F
RAMSwap                 = $A0 ; 0 for normal RAM, 1 for extra
PaletteFade             = $A0 ; for fading palettes during screen transitions ; ends up 0
PaletteCounter          = $A1 

;; Music stuff          
SaveGameMusic           = $A3 
soundtest_track         = $A4 ; Something to do with the sound test screen
TriangleHush            = $A6 ; Slowly raises and lowers a DMC thing to quiet the triangle channel
MenuHush                = $A7 ; Toggles in the main menu, keeps map music playing, and is used to help hush the triangle
noise_sfx               = $A8 ; loop counter, for opening chests (play noise this long)
sq2_sfx                 = $A9 ; triggers square 2 being used for SFX
dlgmusic_backup         = $AA ; backup music track for restoring music after the dialogue/saving box changes it
music_track             = $AB
mu_chanprimer           = $AC
mu_chan                 = $AD
mu_scoreptr             = $AE ; + F
ChaosNoise              = $AF ; only used at the end of the game, while no music is playing



;; JIGS - thoughts on compressing some flags...
;InBattle      = 1 bit
;SaveGameMusic = 1 bit
;MenuHush      = 1 bit
;altareffect, dlflfg_reentermap, dlgsfx, entering shop = all 1 bit
;ow_slow uses high bit, can be merged with mapflags




;; $B0, $C0, $D0, $E0, and $F0 are the 5 tracks

; for sound channels (between Bx-Fx)
;  see Constants.inc
ch_scoreptr             = $0
ch_instrument           = $2  ; low 4 bits are volume envelope ; shared
ch_tempo                = $2  ; high 4 bits are tempo ; shared
ch_envpos               = $3  ; pos in env data (00-1F)
ch_lenctr               = $4  ; counter for score data (note length)
ch_envrate              = $5  ; rate/speed of env table traversal
ch_envrem               = $6  ; remaining "fraction" of env data (3 bits of fraction)
ch_vibrato_depth        = $7  ; low bits
ch_vibrato_speed        = $7  ; high bits
ch_vibrato              = $8  ; 
ch_octave               = $9  ; bits 0-2 are octave, bits 4-5 are octave switches ; shared
ch_quiet                = $9  ; bits 6-7 are half and quarter volume switches ; shared
ch_loopctr              = $A  ; bits 4-6 are remaining loop counter, bit 7 is loop switch ; shared
ch_vol_minus            = $A  ; bits 0-3 are subtracted from ch_vol ; shared
ch_vol                  = $B  ; output volume + duty
ch_freq                 = $C  ; +D ; output freq.  High bit set marks byte has been written (don't rewrite to reset duty)
ch_return               = $E  ; +F ; holds return address for SCORE_GOTO

text_ptr_backup         = $010D ; + E, F
stack                   = $0100 
oam                     = $0200  ; 256 bytes -- must be on page bound
oam_y                   = oam    ;; y position
oam_t                   = oam+1  ;; tile
oam_a                   = oam+2  ;; attribute
oam_x                   = oam+3  ;; x position

;; Flags                
startintrocheck         = $0300 ;
altareffect             = $0301 ; flag to indicate altar effect is to occur (screen shaking, monochrome diagonal window thing)
dlgflg_reentermap       = $0302 ; flag to indicate the map needs re-entering due to dialogue (Bahamut/class change)
entering_shop           = $0303 ; nonzero = about to enter shop
dlgsfx                  = $0304 ; flag to indicate to play a sound effect after opening dialogue box.  0=no sfx, 1=fanfare, else=treasure
Hidden                  = $0305 ; for hiding in battle 
HiddenMagic             = $0306 ; for hiding in battle 
ConfusedMagic           = $0307 ; confused magic stuff for battle
battle_autoswitch       = $0308 ; $FF if auto-battle, $01 if auto-run, $00 normal

gettingcommand          = $0309 ; flag for allowing start to trigger auto-fight or auto-run
btl_drawflagsA          = $030A ; bits 0-3 = set to indicate character should be drawn as dead
;                               ; bit    4 = set to draw battle cursor
;                               ; bit    5 = set to draw weapon attack graphic
;                               ; bit    6 = set to draw magic graphic & flash BG.
;                               ; bit    7 = set to load 4-6 character tiles during UpdateSprites_BattleFrame 
btl_drawflagsB          = $030B ; bits 0-3 = set to indicate character should be drawn as stone
btl_drawflagsC          = $030C ; bits 0-3 = set to indicate character should be drawn as dead (asleep); other 4 bits - set pray star sprite
battle_attackerisplayer = $030D ; 1 if player is attacking, 0 if enemy is attacking
battle_defenderisplayer = $030E ; 1 if player is defending, 0 if enemy is defending 

LongCall_A              = $0310 ; The LongCall routine restores them after it swaps banks
LongCall_Y              = $0311
LongCall_X              = $0312
AutoTarget              = $0313

btltmp_targetlist       = $0327 ; temporary buffer (9 entries) containing possible targets

; These next 5 vars (7 bytes) are all in temp memory, and are mostly just used for passing into BattleDraw8x8Sprite
btl8x8spr_x             = $0337 ; + 8, X coord ; +1 used in drawing code as original position
btl8x8spr_y             = $0339 ; + A, Y coord ;  +1 used in drawing code as original position
btl8x8spr_a             = $033B ; attribute
btl8x8spr_t             = $033C ; tile ID
btl8x8spr_i             = $033D ; slot to draw to (00-3F)
battle_ailmentrandchance= $033E
battle_hitsconnected    = $033F     ; number of hits actually connected

battle_critsconnected   = $0347
battle_thishitconnected = $0348
btl_curturn             = $0349      ; current turn (index for btl_turnorder)
eobtext_print_level     = $0449 ; + A 
btl_walkdirection       = $034A
DrawCharTmp             = $034B
btl_weird_tmp           = $034B
eobtext_print_hp        = $034B ; + C
Rand_AX_lo              = $034D
Rand_AX_high            = $034E
Rand_AX_range           = $034F

;; MISC BATTLE STUFF
btl_rngstate            = $0350 ; State of RNG used for in-battle
btl_various_tmp         = $0351 ; + 2
btl_tmpindex            = $0353 ; temporary holder for a current index
btl_tmpchar             = $0354 ; temporary holder for a 0-based character index
btl_another_loopctr     = $0354 
btl_input               = $0353 
;btl_soft2000            = $0357 ; soft copy of $2000 used in battles
btl_soft2001            = $0358 ; soft copy of $2001 used in battles
eobbox_slotid           = $0359 
eobbox_textid           = $035A 
btlinput_prevstate      = $0359 ; prev state for input
inputdelaycounter       = $035A ; counter to delay multiple-input processing when holding a direction
btl_walkloopctr         = $035B 
btl_animatingchar       = $035C ; the character currently being animated (0-3)
btl_flashsprite1        = $035D 
MagicMessage            = $035E 
btl_respondrate_tmp     = $035F                                
cursorspr_x             = $0360 
cursorspr_y             = $0361 
btlattackspr_x          = $0362 
btlattackspr_y          = $0363 
btlattackspr_t          = $0364 ; indicate which tile to draw for the weapon graphic
btlattackspr_pose       = $0365 ; for weapons, 0 or 8 to indicate whether or not to flip it ; for magic, 0 or ?4? to indicate which frame to draw
btlattackspr_gfx        = $0366 ; copied to 't' prior to drawing.  Indicates which graphic to use
btlattackspr_wepmag     = $0367 ; 0 for drawing the weapon, 1 for drawing the magic
btlattackspr_hidell     = $0368 ; nonzero to hide the lower-left tile of the attack graphic for the "behind the back" frame of weapon swing animation.
btlattackspr_nodraw     = $0369 ; nonzero to hide the weapon/magic sprite entirely. When a non-BB player attacks without any weapon equipped
;                               ; Also used when using ITEMs to supress the magic flashing effect.
btlcmd_curchar          = $036A ; the current character inputting battle commands (0-3)
btlcmd_target           = $036B ; the current enemy slot that is being targetted
btlcmd_spellindex       = $036D
btl_result              = $036E ; 0 = keep battling, 1 = party defeated, 2 = all enemies defeated, 3 = party ran
;                               ; $FF = wait for 2 seconds after fadeout before exiting (chaos defeated?)
btl_followupmusic       = $036F ; song to play in battle after current song finishes.  Moved to music_track
;                               ; once music_track has its high bit set  (does this ever happen?)
btl_responddelay        = $0370 
lvlup_levindex          = $0371 ; see LvlUp_LevelUp
btl_weird_loopctr       = $0371 
math_basedamage_backup  = $0371 
btl_strikingfirst       = $0372 ; nonzero if players are striking first.  Zero otherwise
btl_enemyeffect         = $0373 ; 0 to draw expolosion graphics as the effect, nonzero to erase the enemy as the effect
btl_targetall_tmp       = $0374 
btl_drawformationtmp    = $0375 
btl_randomplayer        = $0375 ; set by GetRandomPlayerTarget  (0-3)
btl_mathbufadd16tmp1    = $0375 
btl_drawformationtmp2   = $0376 
btl_mathbufadd16tmp2    = $0376 
btl_tmppltassign        = $0377 ; temporary value to assign palette to enemies in a formation
btl_attackid            = $0378 ; >= $40 for enemy attacks
btlmag_magicsource      = $0379 ; 0=magic, 1=Item, 2=item
btlmag_ailment_orig     = $037A ; A backup of 
btl_drawformationindex  = $037B 
btlmag_playerhitsfx     = $037C ; sound effect to play when magic hits player
ActiveRunic             = $037D 
btl_backgroundflash     = $037E
battle_stealsuccess     = $037F ; $FF if miss, $00 if no item, $01 if success
explode_min_x           = $0380 
explode_min_y           = $0381 
explode_max_x           = $0382 
explode_max_y           = $0383 
explode_count           = $0384 
btl_spriteflash         = $0384
attackblocked           = $0385 
btl_retaliate           = $0386 
DualAttack              = $0387 

btltmp_smallslotpos     = $038A 
btltmp_buildroster      = $038A 
btl_battletype          = $038B ; 0=9 small, 1=4 large, 2=mix, 3=fiend, 4=chaos
btl_smallslots          = $038C ; Number of small enemy slots available
btl_largeslots          = $038D ; btl_smallslots+1  ; Number of large slots available.  Must immediately follow smallslots
battle_bank             = $038E ; The bank to jump back to for setting up battles
btl_enemycount          = $038F ; count of the number of enemies being generated for a battle


MMC5_tmp                = $0390 ; 16 bytes, tmp ram not used by the original game
;; ^ battle turn order uses up $0D of this ^ 

cur_pal         = $03B0       ; 32 bytes
inroom_pal      = cur_pal+$20 ; 16 bytes
tmp_pal         = cur_pal+$20 ; 32 bytes

;; JIGS - if I'm not mistaken, $400-7FF can be used in battle and will re-fill with tileset_data afterwards

mapobj_backup   = $0400  ; $100 bytes -- used for minimap
tileset_data    = $0400  ; $400 bytes -- must be on page bound

mm_spritebuf    = $0500  ; $100 bytes, keep on page bound
mm_mapbuf       = $0600  ; same
mm_mapbuf2      = $0700  ; same

tileset_prop    = tileset_data  ; 256 bytes, 2 bytes per tile
tsa_ul          = tileset_data+$100  ; 128 bytes
tsa_ur          = tileset_data+$180  ; 128
tsa_dl          = tileset_data+$200  ; 128
tsa_dr          = tileset_data+$280  ; 128
tsa_attr        = tileset_data+$300  ; 128
load_map_pal    = tileset_data+$380  ; $30  (shared with draw_buf -- hence only for loading)

draw_buf        = $0780  ; 128
draw_buf_ul     = draw_buf
draw_buf_ur     = draw_buf + $10
draw_buf_dl     = draw_buf + $20
draw_buf_dr     = draw_buf + $30
draw_buf_attr   = draw_buf + $40
draw_buf_at_hi  = draw_buf + $50
draw_buf_at_lo  = draw_buf + $60
draw_buf_at_msk = draw_buf + $70

mm_drawbuf      = $6000  ; $1000 bytes

MapMusicBackup  = $6000    
MapMusicBackup1 = $6050    
MapMusicBackup2 = $6060    
MapMusicBackup3 = $6070    
MapMusicBackup4 = $6080    
MapMusicBackup5 = $6090   ; for backing up music RAM before a battle

ptygen          = $6000   ; $4C bytes
 ptygen_class   = ptygen
 ptygen_name    = ptygen+1 ; 7 bytes
 ptygen_name_x  = ptygen+8
 ptygen_name_y  = ptygen+9
 ptygen_class_x = ptygen+10
 ptygen_class_y = ptygen+11
 ptygen_spr_x   = ptygen+12
 ptygen_spr_y   = ptygen+13
 ptygen_box_x   = ptygen+14
 ptygen_box_y   = ptygen+15
 ptygen_curs_x  = ptygen+16
 ptygen_curs_y  = ptygen+17
 ptygen_sprite  = ptygen+18

CharStats_TmpSwap1 = $6000 ; temporarily holds 64 bytes of character data while switching order
CharStats_TmpSwap2 = $6040 ; temporarily holds 64 bytes of character data while switching order

lutmp_ch_stats  = $6000 ; temporarily holds 64 bytes of each character data while switching in the lineup menu, 256 total

LevelUp_LoopCounter = $6000
LevelUp_ClassID     = $6001
LevelUp_StatByte    = $6002
LevelUp_LevelIndex  = $6003
LevelUp_StatIndex   = $6004
LevelUp_StatBuffer  = $6005 ; 6, 7, 8, 9 - 5 bytes

TileShiftBuffer     = $6000

EquipStats_RAM      = $6000
SpellData_RAM       = $6000

orbbox_scrollwork    = $6100 ; for menu, $40 bytes   
statusbox_scrollwork = $6140 ; for menu, $40 bytes   
bigstr_buf           = $6300 ; 128 bytes
SaveScreenCharBuf    = $6300 ; for printing the names of characters in all 3 save slots ; seems safe to overwrite bigstr_buf while printing

puzzle               = $6400  ; used in minigame
str_buf              = $6400  ; buffer must not cross page
item_box             = $6400  ; used in shops
lut_BackdropLayout   = $6400  ; holds randomized values for the battle backdrop before its drawn

;;;;;; ALL THE BATTLE STUFF!! ;;;;;;;


btl_attacker                 = $6030
btl_attacker_damage          = btl_attacker + $01 ; this block is for physical attacks
btl_attacker_hitrate         = btl_attacker + $02
btl_attacker_numhits         = btl_attacker + $03
btl_attacker_numhitsmult     = btl_attacker + $04
btl_attacker_critrate        = btl_attacker + $05
btl_attacker_category        = btl_attacker + $06
btl_attacker_element         = btl_attacker + $07
btl_attacker_attackailment   = btl_attacker + $08
btl_attacker_ailments        = btl_attacker + $09
btl_attacker_limbs           = btl_attacker + $0A ; the amount of limbs an enemy has (# of unique physical hits!) not used for players
btl_attacker_graphic         = btl_attacker + $0A ; the graphic used for an attack
btl_attacker_varplt          = btl_attacker + $0B ; The variable palette color used for an attack
btl_attacker_perks           = btl_attacker + $0C 
btl_attacker_critperks       = btl_attacker + $0D 
btl_attacker_ailmentchance   = btl_attacker + $0E
;                            = btl_attacker + $0F ; not used yet

btl_defender                 = $6040 
btl_defender_index           = btl_defender + $01
btl_defender_damage          = btl_defender + $02
btl_defender_hitrate         = btl_defender + $03
btl_defender_defense         = btl_defender + $04
btl_defender_evasion         = btl_defender + $05
btl_defender_magicdefense    = btl_defender + $06
btl_defender_morale          = btl_defender + $07
btl_defender_category        = btl_defender + $08
btl_defender_statusresist    = btl_defender + $09
btl_defender_elementresist   = btl_defender + $0A
btl_defender_elementweakness = btl_defender + $0B
btl_defender_ailments        = btl_defender + $0C
btl_defender_perks           = btl_defender + $0D
;                            = btl_defender + $0E ; not used yet
;                            = btl_defender + $0F ; not used yet
btl_defender_hpmax           = btl_mathbuf + (MATHBUF_DEFENDERMAXHP*2)
btl_defender_hp              = btl_mathbuf + (MATHBUF_DEFENDERHP*2)  ; $687C -- treated as part of math buffer by some code

btlmag_spellconnected           = btl_attacker + $01 ; this block is for magical attacks
btlmag_effect                   = btl_attacker + $02
btlmag_effectivity              = btl_attacker + $03
btlmag_hitrate                  = btl_attacker + $04
btlmag_element                  = btl_attacker + $05
btlmag_color                    = btl_attacker + $06
btlmag_gfx                      = btl_attacker + $07
btlmag_target                   = btl_attacker + $08
btlmag_message                  = btl_attacker + $09

;; these are all things that can be changed by magic! (Except max HP)

btlmag_defender_sprite          = btl_attacker + $0A
btlmag_defender_intelligence    = btl_attacker + $0B
btlmag_defender_speed           = btl_attacker + $0C
btlmag_defender_damage          = btl_attacker + $0D
btlmag_defender_hitrate         = btl_attacker + $0E
btlmag_defender_defense         = btl_attacker + $0F
btlmag_defender                 = btl_defender
btlmag_defender_evasion         = btl_defender + $01
btlmag_defender_magicdefense    = btl_defender + $02
btlmag_defender_morale          = btl_defender + $03 ; morale for enemies
btlmag_defender_battlestate     = btl_defender + $04 ; battlestate for players
btlmag_defender_numhitsmult     = btl_defender + $05
btlmag_defender_critrate        = btl_defender + $06
btlmag_defender_category        = btl_defender + $07
btlmag_defender_weaponelement   = btl_defender + $08
btlmag_defender_weaponcategory  = btl_defender + $09
btlmag_defender_attackailment   = btl_defender + $0A
btlmag_defender_attackailproc   = btl_defender + $0B
btlmag_defender_elementweakness = btl_defender + $0C
btlmag_defender_elementresist   = btl_defender + $0D
btlmag_defender_statusresist    = btl_defender + $0E
btlmag_defender_ailments        = btl_defender + $0F
btlmag_defender_hpmax           = btl_mathbuf + (MATHBUF_MAGDEFENDERMAXHP*2)  ; $6880
btlmag_defender_hp              = btl_mathbuf + (MATHBUF_MAGDEFENDERHP*2)  ; $687A

;; Mathbuf stuff
    MATHBUF_HITCHANCE           = $00
    MATHBUF_BASEDAMAGE          = $01
    MATHBUF_NUMHITS             = $02
    MATHBUF_MAGRANDHIT          = $02
    MATHBUF_CATEGORY            = $03
    MATHBUF_ELEMENT             = $04
    MATHBUF_RANDHIT             = $04
    MATHBUF_DMGCALC             = $05
    MATHBUF_CRITCHANCE          = $06
    MATHBUF_AILMENTCHANCE       = $07
    MATHBUF_MAGDEFENDERHP       = $08 
    MATHBUF_DEFENDERHP          = $08 
    MATHBUF_MAGDEFENDERMAXHP    = $09 
    MATHBUF_DEFENDERMAXHP       = $09 
    MATHBUF_TOTALDAMAGE         = $0A 
    MATHBUF_REGENHP             = $0B 
    PARRY_DAMAGE                = $1F
    
btl_mathbuf = $6050 ;   ; $16 bytes, 2 byte pairs, used as buffers for mathematical routines
    math_hitchance      = btl_mathbuf + (MATHBUF_HITCHANCE*2)       ; $6050 ; 
    math_basedamage     = btl_mathbuf + (MATHBUF_BASEDAMAGE*2)      ; $6052 ; 
    math_numhits        = btl_mathbuf + (MATHBUF_NUMHITS*2)         ; $6054 ; 
    math_magrandhit     = btl_mathbuf + (MATHBUF_MAGRANDHIT*2)      ; $6054 ; 
    math_category       = btl_mathbuf + (MATHBUF_CATEGORY*2)        ; $6056 ;  not really math... but whatever
    math_element        = btl_mathbuf + (MATHBUF_ELEMENT*2)         ; $6058 ;  not really math... but whatever
    math_randhit        = btl_mathbuf + (MATHBUF_RANDHIT*2)         ; $6058 ; 
    math_dmgcalc        = btl_mathbuf + (MATHBUF_DMGCALC*2)         ; $605A ; 
    math_critchance     = btl_mathbuf + (MATHBUF_CRITCHANCE*2)      ; $605C ; 
    math_ailmentchance  = btl_mathbuf + (MATHBUF_AILMENTCHANCE*2)   ; $605E ; 
;btlmag_defender_hp     = btl_mathbuf + (MATHBUF_MAGDEFENDERHP*2)   ; $6060 ; 
;btl_defender_hp        = btl_mathbuf + (MATHBUF_DEFENDERHP*2)      ; $6060 ;  -- treated as part of math buffer by some code
;btlmag_defender_hpmax  = btl_mathbuf + (MATHBUF_MAGDEFENDERMAXHP*2); $6062 ; 
;btl_defender_hpmax     = btl_mathbuf + (MATHBUF_DEFENDERMAXHP*2)   ; $6062 ; 
    battle_totaldamage  = btl_mathbuf + (MATHBUF_TOTALDAMAGE*2)     ; $6064 ;  -- treated as part of math buffer by some code
    
    btl_poisondamage    = btltmp_divLo
    
    btltmp_divLo        = btl_mathbuf + (MATHBUF_REGENHP*2)         ; $6066 
    btltmp_divHi        = btl_mathbuf + (MATHBUF_REGENHP*2) + 1     ; $6067 
    btltmp_divV         = $6068 
    btltmp_divtmp       = $6069 
    
    btl_parrydamage     = btl_mathbuf + (PARRY_DAMAGE*2)            ; $608E ; 2 bytes

; anomie poison code reference    
;btltmp_divLo = $688B ;  divV
;btltmp_divHi = $688C ;  divLo
;btltmp_divV  = $688D ;  divHi

btl_turnorder       = $6070 ; $D entries (9 enemies + 4 characters)
indicator_index     = $607D ; tmp byte for flashing enemies if they're defender or attacker
battle_item         = $607F ; handles item box scrolling and item use
btl_turnorderBackup = $6080 ; 13 bytes
btl_turnorderSpeed  = $6090 ; 13 bytes

;; some free RAM here in  battle    

    
btl_enemystats      = $6100  ; $1B bytes per enemy, 9 enemies = 243 bytes ($F3)
    en_hpmax        = $00 ; 2 bytes                             1 2 
    en_morale       = $02 ; can be changed with magic           3
    en_statusresist = $03 ;                                     4
    en_evade        = $04 ; can be changed with magic           5
    en_defense      = $05 ; can be changed with magic           6
    en_numhits      = $06 ;                                     7
    en_hitrate      = $07 ; can be changed with magic           8
    en_strength     = $08 ; can be changed with magic           9 
    en_critrate     = $09 ; can be changed with magic           10
    en_ailproc      = $0A ;                                     11
    en_attackail    = $0B ; can be changed with magic           12
    en_category     = $0C ;                                     13 
    en_magdef       = $0D ; can be changed with magic           14 
    en_elemweakness = $0E ; can be changed with magic           15
    en_elemresist   = $0F ; can be changed with magic           16
    en_elemattack   = $10 ;                                     17
    en_speed        = $11 ;                                     18
    en_level        = $12 ;                                     19  
    en_item         = $13 ; can be changed by stealing          20
    en_BLANK        = $14 ;                                     21
    
    ;; ^ this block matches enemy ROM layout ^ 
    
    en_numhitsmult  = $15 ; can be changed with magic (default=1) 24
    en_unused       = $16 ;                                       22
    en_extraAI      = $17 ; holds info like counter, guard, etc   23
    en_ailments     = $18 ; can be changed with magic             25
    en_hp           = $19 ; $1A ; 2 bytes                         26 27
    en_enemyid      = $1B ;                                       28
    
btl_enemyrewards    = $6200 ; up to $6224 (9*4=36)
    en_exp          = $00 ; 2 bytes                     1 2
    en_gp           = $02 ; 2 bytes                     2 3 

btl_formdata        = $6230 ; $10 bytes (formation data as appears in ROM)
    btlform_type    = btl_formdata+$0   ; battle type (high 4 bits) -- low 4 bits are pattern table
    btlform_engfx   = btl_formdata+$1   ; graphic assignment (2 bits per enemy)
    btlform_enids   = btl_formdata+$2   ; enemy IDs (4 bytes)
    btlform_enqty   = btl_formdata+$6   ; enemy quantities (4 bytes)
    btlform_plts    = btl_formdata+$A   ; palettes for this battle (2 bytes)
    btlform_surprise= btl_formdata+$C   ; surprise rate
    btlform_enplt   = btl_formdata+$D   ; enemy palette assign (in high 4 bits)
    btlform_norun   = btlform_enplt     ; no run flag (in low bit)
    btlform_enqtyB  = btl_formdata+$E   ; enemy quantities for B formation (2 bytes)  
;; JIGS - new stuff:

btlformation_strengths   = btl_formdata+$0 
btlformation_battletype  = btl_formdata+$0 
btlformation_en_id       = btl_formdata+$1 ; 2, 3, 4
btlformation_en_amount   = btl_formdata+$5 ; 6. 7. 8 
btlformation_palettes    = btl_formdata+$9 ; A, B
btlformation_plt_assign  = btl_formdata+$C 
btlformation_surprise    = btl_formdata+$D 





  
   
btl_enemyIDs               = $6240  ; 9 entries of enemy IDs
btl_enemyroster            = $6249  ; 4 bytes of enemy IDs printed in the main battle menu, showing enemies in the fight
btl_enemyamount            = $624F  ; temp byte for number of enemies, for battle printing
btl_enemygfxplt            = $6250  ; 9 entries of enemy graphic and palette assignment (graphic in high 2 bits, plt in low bit)
btl_enemyrosterID_temp     = $6260  ; 9 bytes, enemy roster POSITION


btl_unformattedstringbuf   = $6300
btl_msgbuffer              = $6500  ; $120 bytes ($09 rows * $20 bytes per row) - holds all on-screen battle message tiles
btl_stringbuf              = $6620  ; holds the string to draw to a battle box.



;  Buffers to hold character commands for battle.  These must be contiguious in memory
;  due to the way memory is cleared.  These buffers also contain a bit of redundant data.
;
;  btl_charcmdbuf contains 3 bytes (padded to 4) per character:
;    byte 0 = command
;    byte 1 = spell effect ID  (used for Item/Magic/Gear).  FF if no effect
;    byte 2 = target.  8x are player targets 0x are enemy targets.  FF=target all enemies, FE=target all players.
;    byte 3 = character class, for skills, or the level of magic to use an Ether on
;
;  Commands can be the following:
;    00 = no command -- if surprised/asleep/dead/stone
;    01 = fight
;    02 = magic
;    04 = skill
;    08 = gear
;    10 = guard
;    20 = item 
;    40 = hide
;    80 = flee    ('target' would be the actual character running)
; 
;  btl_charcmditem contains 1 byte per character:  the ID of the item they're using.
;    This is only used when the command is '10'
;
;  btl_charcmdconsumetype contains 1 byte per character.  It will be 01 for magic and 02 for Item.
;       unused for other commands.
;
;  btl_charcmdconsumeid contains 1 byte per character.  If will be the potion index
;       for Item, or the spell level for magic

char_order_buf          = $6800 ; for sorting after battle
btl_charcmdbuf          = $6800 ; 4 bytes per character
btl_charcmditem         = $6810 ; 1 byte per character for the rest
btl_charcmdconsumetype  = $6814 ; 
btl_charcmdconsumeid    = $6818 ; 

;; battle statuses 

btl_charstatuses        = $681C ; see "ClearCharBuffers" in Bank C before changing this

btl_charstone           = $681C ; Stone status - should always be first
btl_charregen           = $6820 ; Regeneration status
btl_charreflect         = $6824 ; Reflect magic status

;; long-actions -- these last more than 1 turn

btl_charparry           = $6828 ; BB/Master Parry skill
btl_charfocus           = $682C ; Black Focus skill
btl_charcover           = $6830 ; Knight Cover
btl_charhidden          = $6834 ; Hidden status

;; actions 

btl_charguard           = $6838 ; Guard status
btl_charpray            = $683C ; White Pray skill
btl_charrunic           = $6840 ; Red Runic skill
btl_charrush            = $6844 ; Fighter Rush skill

btl_charstatuses_end    = $6844 

;; stats
;; if more stats are added, check PlayerMagDefenderStats_LUT in Bank C and PlayerAttackerStats_LUT in Bank B to adjust the routines

btlstats_mainstats      = $6878

btl_chararmorperks      = btlstats_mainstats + 0*4

;;  these 3 stats are used in battle calculations and can be changed by magic
btl_charintelligence    = btlstats_mainstats + 1*4 ; $687C
btl_charspeed           = btlstats_mainstats + 2*4 ; $6880
btl_charhitmult         = btlstats_mainstats + 3*4 ; $6884

btlstats_defensestats   = btlstats_mainstats + 4*4

btl_charevasion         = btlstats_defensestats + 0*4 ; $6888
btl_chardefense         = btlstats_defensestats + 1*4 ; $688C
btl_charmagdefense      = btlstats_defensestats + 2*4 ; $6890
btl_charelementresist   = btlstats_defensestats + 3*4 ; $6894
btl_charelementweak     = btlstats_defensestats + 4*4 ; $6898
btl_charstatusresist    = btlstats_defensestats + 5*4 ; $689C

; all of these are 8 bytes: 2 weapons each!

btlstats_weaponstats    = btlstats_defensestats + 6*4

btl_charhitrate         = btlstats_weaponstats + 0*8 ; $68A0
btl_chardamage          = btlstats_weaponstats + 1*8 ; $68A8
btl_charweaponcritrate  = btlstats_weaponstats + 2*8 ; $68B0
btl_charweaponailment   = btlstats_weaponstats + 3*8 ; $68B8
btl_charweaponailproc   = btlstats_weaponstats + 4*8 ; $68C0
btl_charweaponelement   = btlstats_weaponstats + 5*8 ; $68C8
btl_charweaponcategory  = btlstats_weaponstats + 6*8 ; $68D0
btl_charweaponsprite    = btlstats_weaponstats + 7*8 ; $68D8
btl_charweaponpal       = btlstats_weaponstats + 8*8 ; $68E0
btl_charnumhits         = btlstats_weaponstats + 9*8 ; $68E8 

btl_chardrawinfo        = $68F0 ; $10 bytes, 4 bytes for each character
    btl_chardraw_x      = btl_chardrawinfo+0
    btl_chardraw_y      = btl_chardrawinfo+1
    btl_chardraw_gfxset = btl_chardrawinfo+2
    btl_chardraw_pose   = btl_chardrawinfo+3

btl_flashsprite2        = $6900 ; $18 bytes, tmp storage of sprite data
btl_flashsprite3        = $6918 ; $18 bytes, tmp storage of sprite data
btl_charattrib          = $6930 ; attributes to use when drawing charcters in battle 
btl_charnaturalpose     = $6934 ; 
btl_charactivepose      = $6938 ; 
btl_coverspritebackup   = $693C ; 
btl_palettes            = $6940 ; $20 bytes
btltmp_attr             = $6960 ; $40 bytes of attribute data for the battle setup ; NOT temporary! Needed for flashing enemies. 
cursor_positions        = $69A0 ; $18 bytes, 2 bytes per entry, each entry is the pixel coord of where the
;                               ; cursor should be drawn when its item is selected. lut_MagicCursorPos has the most

btltmp_backseat         = $69F0 ; $10 byte buffer -- backup of btltmp


lut_MagicData   = $7000  ; $400 bytes
lut_EnemyAi     = $7100  ; $90 bytes
;; JIGS - these two no longer needed once magic loading works better

TempSpriteLoading    = $7400 ; $E0 bytes - used in battle

PlayerHPString_RAM   = $74E0 ; $20 bytes

;Sizes of the battle message boxes in RAM
BattleBoxBuffers     = $7500
HPUpdateBox          = $7FA0 ; 81 bytes
BattleBoxBufferList  = $7FF1 ; to 7FF9 - 8 bytes
UndrawNBattleBlocks_loopctr = $7FFB
EOBCombatBox_tmp      = $7FFD
btl_msgbuffer_loopctr = $7FFE ; how many rows to transfer from the buffer to the screen
BattleBoxBufferCount  = $7FFF ; total list of drawn boxes

 







mapobj          = $6F00         ; $100 bytes -- page
 mapobj_id      = mapobj + $00  ; rearranging these is ill advised
 mapobj_flgs    = mapobj + $01  ;  because the loader is pretty rigid
 mapobj_physX   = mapobj + $02  ;  flags:  $80=inroom $40=don't move
 mapobj_physY   = mapobj + $03
 mapobj_gfxX    = mapobj + $04
 mapobj_gfxY    = mapobj + $05
 mapobj_ctrX    = mapobj + $06
 mapobj_ctrY    = mapobj + $07
 mapobj_spdX    = mapobj + $08
 mapobj_spdY    = mapobj + $09
 mapobj_rawid   = mapobj + $0A
 mapobj_movectr = mapobj + $0B
 mapobj_face    = mapobj + $0C
 mapobj_pl      = mapobj + $0D   ; bit 7 = talking to player (changes facing), other bits = being shoved by player
 mapobj_tsaptr  = mapobj + $0E 

mapdata         = $7000  ; must be on $1000 byte bound (ie:  pretty much unmovable)

mm_decorchr     = $7000  ; $300 bytes -- should be on page bound, shared
mm_titlechr     = $7300  ; $280 bytes -- should be on page bound, shared

theend_drawbuf  = $7900  ; $700 bytes! 
