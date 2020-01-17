; JIGS - 
; All data that is saved to each game slot is in "work RAM" at $5C00
; Saving temporarily wipes RAM from $6000 to $7FFF so make sure nothing important is there that needs to be constant while on the save screen.

;; JIGS - this is the new area for all save-game related things...

unsram          = $5C00  ; $400 bytes
sram            = $6400  ; $400 bytes ; but these are all on the swapped ram side
sram2           = $6800  ; $400 bytes
sram3           = $6C00  ; $400 bytes
sram_checksum   = sram + $FD
sram_assert_55  = sram + $FE
sram_assert_AA  = sram + $FF
sram2_checksum   = sram2 + $FD
sram2_assert_55  = sram2 + $FE
sram2_assert_AA  = sram2 + $FF
sram3_checksum   = sram3 + $FD
sram3_assert_55  = sram3 + $FE
sram3_assert_AA  = sram3 + $FF

ship_vis        = unsram + $00
ship_x          = unsram + $01
ship_y          = unsram + $02
airship_vis     = unsram + $03
airship_x       = unsram + $04
airship_y       = unsram + $05
bridge_vis      = unsram + $06
bridge_x        = unsram + $07
bridge_y        = unsram + $08
canal_vis       = unsram + $09
canal_x         = unsram + $0A
canal_y         = unsram + $0B
bridgescene     = unsram + $0C ; 00 = hasnt happened yet. 01 = happens when move is complete, 80=  already has happened
unsram_ow_scroll_x = unsram + $0D
unsram_ow_scroll_y = unsram + $0E
unsram_vehicle     = unsram + $0F

ExpGainOption    = unsram + $10
MoneyGainOption  = unsram + $11
EncRateOption    = unsram + $12
MuteSFXOption    = unsram + $13
AutoTargetOption = unsram + $14
BattleTextSpeed  = unsram + $15
BattleBGColor    = unsram + $16
smokebomb_steps  = unsram + $17
; unused         = unsram + $18
; unused         = unsram + $19
; unused         = unsram + $1A
battleswon       = unsram + $1B
battlesrun       = unsram + $1C
gold             = unsram + $1D ; 1E ; 1F - 3 bytes

items           = unsram + $20
item_pageswap   = items + $00
item_heal       = items + $01
item_x_heal     = items + $02
item_ether      = items + $03
item_elixir     = items + $04
item_pure       = items + $05
item_clock      = items + $06
item_down       = items + $07
item_tent       = items + $08
item_cabin      = items + $09
item_house      = items + $0A
item_eyedrops   = items + $0B
item_smokebomb  = items + $0C
item_alarm      = items + $0D
item_unknown1   = items + $0E
item_unknown2   = items + $0F
item_qty_stop   = items + $10

keyitems        = items + $10
item_lute       = keyitems + $00
item_crown      = keyitems + $01
item_crystal    = keyitems + $02
item_herb       = keyitems + $03
item_mystickey  = keyitems + $04
item_tnt        = keyitems + $05
item_adamant    = keyitems + $06
item_slab       = keyitems + $07
item_ruby       = keyitems + $08
item_rod        = keyitems + $09
item_floater    = keyitems + $0A
item_chime      = keyitems + $0B
item_tail       = keyitems + $0C
item_cube       = keyitems + $0D
item_bottle     = keyitems + $0E
item_oxyale     = keyitems + $0F
item_canoe      = keyitems + $10
item_lewds      = keyitems + $11
item_nothing2   = keyitems + $12
item_nothing3   = keyitems + $13
item_nothing4   = keyitems + $14
item_nothing5   = keyitems + $15
item_nothing6   = keyitems + $16
item_nothing7   = keyitems + $17
item_nothing8   = keyitems + $18
item_nothing9   = keyitems + $19
item_bottle_alt = keyitems + $1A
item_lewds_alt  = keyitems + $1B
item_orb_start  = keyitems + $1C
  orb_fire      = item_orb_start + 0 ; $1C
  orb_water     = item_orb_start + 1 ; $1D
  orb_air       = item_orb_start + 2 ; $1E
  orb_earth     = item_orb_start + 3 ; $1F
item_stop       = item_orb_start + 4 ; $20

playtimer        = unsram + $F0 ; 4 bytes - game clock!
;                = unsram + $F1
;                = unsram + $F2
;                = unsram + $F3

ch_stats          = unsram + $0100  ; MUST be on page bound.  Each character allowed $40 bytes, so use 00,40,80,C0 to index ch_stats
ch_class          = ch_stats + $00 ; high bits = sprite, low bits = class
ch_ailments       = ch_stats + $01
ch_name           = ch_stats + $02 ; 03, 04, 05, 06, 07, 08 - 7 bytes 
ch_exp            = ch_stats + $09 ; 0A, 0B - 3 bytes
ch_curhp          = ch_stats + $0C ; 0D - 2 bytes
ch_maxhp          = ch_stats + $0E ; 0F - 2 bytes
ch_level          = ch_stats + $10 ; OB this is 0 based, IB this is 1 based
ch_strength       = ch_stats + $11
ch_agility        = ch_stats + $12
ch_intelligence   = ch_stats + $13 
ch_vitality       = ch_stats + $14
ch_speed          = ch_stats + $15
ch_substats       = ch_stats + $16
ch_damage         = ch_stats + $16
ch_hitrate        = ch_stats + $17
ch_defense        = ch_stats + $18
ch_evasion        = ch_stats + $19
ch_magicdefense   = ch_stats + $1A
ch_statusresist   = ch_stats + $1B ;
ch_elementresist  = ch_stats + $1C ; effected by equipment, needs to refresh after battle
ch_elementweak    = ch_stats + $1D ; effected by equipment, needs to refresh after battle
ch_attackailment  = ch_stats + $1E ; effected by equipment
ch_attackailproc  = ch_stats + $1F ; effected by equipment

ch_righthand      = ch_stats + $20
ch_lefthand       = ch_stats + $21
ch_head           = ch_stats + $22
ch_body           = ch_stats + $23
ch_hands          = ch_stats + $24
ch_accessory      = ch_stats + $25
ch_bag1           = ch_stats + $26  
ch_bag2           = ch_stats + $27  
ch_weaponsprite   = ch_stats + $28 ; effected by equipment
ch_weaponpal      = ch_stats + $29 ; effected by equipment
ch_weaponelement  = ch_stats + $2A ; effected by equipment, needs to refresh after battle
ch_weaponcategory = ch_stats + $2B ; effected by equipment, needs to refresh after battle
ch_numhits        = ch_stats + $2C ; effected by equipment, needs to refresh after battle
ch_critrate       = ch_stats + $2D ; effected by equipment, needs to refresh after battle
ch_damagebackup   = ch_stats + $2E ; effected by equipment
;unused           = ch_stats + $2F 
ch_mp             = ch_stats + $30 ; 31, 32, 33, 34, 35, 36, 37 - 8 bytes
ch_spells         = ch_stats + $38 ; 39, 3A, 3B, 3C, 3D, 3E, 3F - 8 bytes

inv_equip         = unsram + $200
inv_weapon        = inv_equip ; 64 bytes
inv_armor         = inv_equip + $40 ; 64 bytes
inv_magic         = unsram + $280 ; 64 bytes, 1 per spell

game_flags        = unsram + $0300  ; must be on page bound



;; Temporary RAM 
tmp                     = $00 ; 16 bytes

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
battlestep_sign         = $2F ; controls whether or not battlestep goes up or down

;; Standard Map Things  
tileprop                = $30 ; 2 bytes
tileprop_now            = $32 ; 2 bytes special tile properties that we're on (tileprop isn't necessarily what we're standing on)
tileprop_last           = $34 ; 1 byte

;; v shared v           
wateraccess             = $35 ; for moving into water
sm_player_x             = $36 ; player X/Y position on standard map.  Only used for NPC collision detection
sm_player_y             = $37
talkobj                 = $38 ; shared -- object you're talking to on SM
dlg_itemid              = $39 ; shared
DialogueTable_1or2      = $3A ; important for dialogue
treasure_offset         = $3B ; stores the chest's item name printing code (weapons and armor use a different code)
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

;; Box Drawing Things   
box_x                   = $40
box_y                   = $41
box_wd                  = $42 ; shared
box_ht                  = $43 ; shared
dest_wd                 = $42 ; for drawing image rectangles
dest_ht                 = $43 
dest_x                  = $44
dest_y                  = $45
spaceruns               = $46 ; see drawcomplexstring; amount of spaces to draw
btldraw_max             = $46 ; maximum characters to draw
image_ptr               = $47 ; + 8 - for images
text_ptr                = $47 ; + 8 - for text
format_buf              = $50 ; 7 bytes, goes in reverse (4A-50) -- must not cross page bound
;; $50 must stay 0 to null-terminator the format_buf

;; Cursor               
cursor                  = $51
cursor_max              = $52
cursor2                 = $52 ; shared (ether menu/ old equip menu secondary cursor)
shopcurs_x              = $53 ; shared
shopcurs_y              = $54 ; shared
namecurs_x              = $53 ; for naming characters at game start
namecurs_y              = $54 
btlcurs                 = $51
btlcurs_max             = $52 ; highest value for the cursor
btlcurs_x               = $53 ; battle cursor X position (menu position, not pixel position)
btlcurs_y               = $54 ; battle cursor Y position (menu position, not pixel position)
cursoradd               = $55 ; naming characters
cursor_change           = $55 ; magic menu 
backup_cursor           = $56 ; shops, menus
backup_cursor_targ      = $57 ; for item menus, to not reset the cursor when exiting a sub-menu
shop_cursor_ptr         = $56 ; + 7 ; used in shops only
submenu_targ            = $58 ; also used in battle for the ether menu

;; Menu Things - Shared 
equipoffset             = $59 ; menus
hp_recovery             = $5A ; tmp byte for amount of HP to heal with potions and spells
mp_required             = $5B ; offset for spell level to decrease when casting (menus only)
descboxopen             = $5C ; marks the description box is open
battleitemslot          = $5D ; equip menu, swaps between weapons/armour
equipmenu_tmp           = $5E ; for unequip/reequipping
weasels                 = $5F ; Important for saving/loading, and sound test menu

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
shop_selling            = $6B
shop_cursorchange       = $6C
shop_listdrawn          = $6D
shop_listactive         = $6E
char_index              = $6F ; for printing character stats in menus and sprites in battle

ItemToUnequip           = $70
ItemToEquip             = $71
slotcheck               = $72
equip_impossible        = $73
shop_x_price            = $74
shop_drawmarks          = $75

;; Battle Things - Shared
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

CharStatsPointer        = $80 
CharBackupStatsPointer  = $82 ; these get loaded up at the same time
EnemyRAMPointer         = $84 ; pointer to enemy's adjustable stats
EnemyROMPointer         = $86 ; pointer to enemy's hard stats
BattleTmpPointer        = $86 
WeaponPointer           = $86 ; pointer to weapon data
BattleTmpPointer2       = $88 ; this pointer is often used by things 
MagicPointer            = $8A ; MagicPointer
EnemyAIPointer          = $8A
BattleBoxString         = $8A 
btldraw_blockptrstart   = $8C
btldraw_blockptrend     = $8E

;;General NES things    
framecounter            = $90 ; 2 bytes!
ppu_dest                = $92 ; 2 bytes
cur_bank                = $94
ret_bank                = $95
actual_bank             = $96
sprindex                = $97
spr_x                   = $98
spr_y                   = $99
NTsoft2000              = $9A ; same as soft2000, but used to track coarse NT scroll
soft2000                = $9B
menustall               = $9C ; see MenuCondStall in bank $1F for explanation
ScreenShakeCounter      = $9D ; used in battle and silent errors
dlgbox_row              = $9D ; counts down from 7 when drawing dialogue box; nothing else 
npcdir_seed             = $9E ; RNG seed for determining direction for NPCs to walk
InBattle                = $9F
RAMSwap                 = $A0 ; 0 for normal RAM, 1 for extra
btldraw_width           = $A1 ; change later!
btldraw_width_counter   = $A3 ; change later!
btldraw_box_id          = $A2

;; Music stuff          
;                       = $A0
ChaosNoise              = $A1 ; only used at the end of the game
SaveGameMusic           = $A2 
soundtesthelper         = $A3 ; Something to do with the sound test screen
soundtest               = $A4 ; Something to do with the sound test screen
SFX_ErrorTime           = $A5 ; might have to do with using the noise channel for error SFX
TriangleHush            = $A6 ; Slowly raises and lowers a DMC thing to quiet the triangle channel
MenuHush                = $A7 ; Toggles in the main menu, keeps map music playing, and is used to help hush the triangle
noise_sfx               = $A8 ; loop counter, for opening chests (play noise this long)
sq2_sfx                 = $A9 ; triggers square 2 being used for SFX
dlgmusic_backup         = $AA ; backup music track for restoring music after the dialogue/saving box changes it
music_track             = $AB
mu_chanprimer           = $AC
mu_chan                 = $AD
mu_scoreptr             = $AE ; + F

;; $B0, $C0, $D0, $E0, and $F0 are the 5 tracks

; for sound channels (between Bx-Fx)
;  see Constants.inc
ch_scoreptr             = $0
ch_envptr               = $2  ; ptr to start of env data
ch_envpos               = $4  ; pos in env data (00-1F)
ch_lenctr               = $5  ; counter for score data (note length)
ch_frqtblptr            = $6  ; pointer to freq table (changes per octave)
ch_lentblptr            = $8  ; pointer to length table (changes per tempo)
ch_envrate              = $A  ; rate/speed of env table traversal
ch_envrem               = $B  ; remaining "fraction" of env data (3 bits of fraction)
ch_vol                  = $C  ; output volume
ch_loopctr              = $D  ; remaining loop counter
ch_freq                 = $E  ; output freq.  High bit set marks byte has been written (don't rewrite to reset duty)
;                             ; these are added in for the music system!
ch_loop_marker          = $0250 ; somehow this will end up at $0300, $0310, $0320 $0330, and $0340
ch_return               = $0251 ; + 2
ch_duty                 = $0253 ; 
ch_octave               = $0254 ; 
ch_quiet                = $0255 ; 
ch_customquiet          = $0256 ; 

text_ptr_backup         = $010D ; + E, F
stack                   = $0100 
oam                     = $0200  ; 256 bytes -- must be on page bound
oam_y                   = oam
oam_t                   = oam+1
oam_a                   = oam+2
oam_x                   = oam+3

;; Flags                
startintrocheck         = $0307 ;
altareffect             = $0308 ; flag to indicate altar effect is to occur (screen shaking, monochrome diagonal window thing)
dlgflg_reentermap       = $0309 ; flag to indicate the map needs re-entering due to dialogue (Bahamut/class change)
entering_shop           = $030A ; nonzero = about to enter shop
dlgsfx                  = $030B ; flag to indicate to play a sound effect after opening dialogue box.  0=no sfx, 1=fanfare, else=treasure
Hidden                  = $030C ; for hiding in battle 
HiddenMagic             = $030D ; for hiding in battle 
ConfusedMagic           = $030E ; confused magic stuff for battle
battle_autoswitch       = $030F ; $FF if auto-battle, $01 if auto-run, $00 normal

gettingcommand          = $0317 ; flag for allowing start to trigger auto-fight or auto-run
btl_drawflagsA          = $0318 ; bits 0-3 = set to indicate character should be drawn as dead
;                               ; bit    4 = set to draw battle cursor
;                               ; bit    5 = set to draw weapon attack graphic
;                               ; bit    6 = set to draw magic graphic & flash BG.
btl_drawflagsB          = $0319 ; bits 0-4 = set to indicate character should be drawn as stone
btl_drawflagsC          = $031A ; bits 0-4 = set to indicate character should be drawn as dead (asleep); other 4 bits - set pray star sprite
battle_attackerisplayer = $031B ; 1 if player is attacking, 0 if enemy is attacking
battle_defenderisplayer = $031C ; 1 if player is defending, 0 if enemy is defending 
LongCall_A              = $031D ; The LongCall routine restores them after it swaps banks
LongCall_Y              = $031E
LongCall_X              = $031F

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
btl_soft2000            = $0357 ; soft copy of $2000 used in battles
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
btlcursspr_x            = $0360 
btlcursspr_y            = $0361 
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

btltmp_smallslotpos     = $038A 
btltmp_buildroster      = $038A 
btl_battletype          = $038B ; 0=9 small, 1=4 large, 2=mix, 3=fiend, 4=chaos
btl_smallslots          = $038C ; Number of small enemy slots available
btl_largeslots          = $038D ; btl_smallslots+1  ; Number of large slots available.  Must immediately follow smallslots
battle_bank             = $038E ; The bank to jump back to for setting up battles
btl_enemycount          = $038F ; count of the number of enemies being generated for a battle


MMC5_tmp                = $0390 ; 16 bytes, tmp ram not used by the original game
;; ^ battle turn order uses up $0D of this ^ 

btl_usepalette  = $03A0 ; $20 bytes - the palette that is actually displayed (after fade effects)
cur_pal         = $03C0       ; 32 bytes
inroom_pal      = cur_pal+$20 ; 16 bytes
tmp_pal         = $03F0       ; 16 bytes

tileset_data    = $0400  ; $400 bytes -- must be on page bound

mm_drawbuf      = $0500  ;$100 bytes, shared, should be on page bound, but don't think it's absolutely required
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
 
TempSpellList        = $6000 ; to 6017 ; 24 bytes
TempSpellListIndex   = $6018
SpellLevelIndex      = $6019
SpellListLoopCounter = $601A
CharacterIndexBackup = $601B
CharacterEquipBackup = $601C


orbbox_scrollwork    = $6100 ; for menu, $40 bytes   
statusbox_scrollwork = $6140 ; for menu, $40 bytes   
bigstr_buf        = $6300 ; 128 bytes
SaveScreenCharBuf = $6300 ; for printing the names of characters in all 3 save slots ; seems safe to overwrite bigstr_buf while printing

puzzle           = $6400  ; used in minigame
str_buf          = $6400  ; buffer must not cross page
item_box         = $6400  ; used in shops


;;;;;; ALL THE BATTLE STUFF!! ;;;;;;;


btl_attacker                 = $6030
btl_attacker_damage          = btl_attacker + $01
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
btl_attacker_sprite          = btl_attacker + $0C ; this is not used and I don't know why I made it
btl_attacker_class           = btl_attacker + $0D ; high bit is "hidden" state
btl_attacker_hidden          = btl_attacker + $0E ; not sure what to use this for
btl_attacker_ailmentchance   = btl_attacker + $0F

btlmag_spellconnected       = btl_attacker + $01
btlmag_effect               = btl_attacker + $02
btlmag_effectivity          = btl_attacker + $03
btlmag_hitrate              = btl_attacker + $04
btlmag_element              = btl_attacker + $05
btlmag_color                = btl_attacker + $06
btlmag_gfx                  = btl_attacker + $07
btlmag_target               = btl_attacker + $08
btlmag_message              = btl_attacker + $09

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
btl_defender_class           = btl_defender + $0D ; high bit is "hidden" state
btl_defender_hpmax           = btl_mathbuf + (MATHBUF_DEFENDERMAXHP*2)
btl_defender_hp              = btl_mathbuf + (MATHBUF_DEFENDERHP*2)  ; $687C -- treated as part of math buffer by some code

;; these are all things that can be changed by magic! Except max HP
btlmag_defender_intelligence    = btl_attacker + $0B
btlmag_defender_speed           = btl_attacker + $0C
btlmag_defender_damage          = btl_attacker + $0D
btlmag_defender_hitrate         = btl_attacker + $0E
btlmag_defender_defense         = btl_attacker + $0F
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
GuardDefense        = $607F ; amount to add to a players btl_defender_defense stat
battle_item         = $607F ; handles item box scrolling and item use
btl_turnorderBackup = $6080 ; 13 bytes
btl_turnorderSpeed  = $6090 ; 13 bytes
    
    
;; the following stats are saved at the start of battle, and re-applied at the end of battle. Everything that can change in battle needs to be un-done.
ch_backupstats            = $60C0 ;; $10 per character, so fills up to $60FF
ch_slotindex_backup       = ch_backupstats
ch_intelligence_backup    = ch_backupstats + $01
ch_speed_backup           = ch_backupstats + $02
ch_damage_backup          = ch_backupstats + $03
ch_hitrate_backup         = ch_backupstats + $04
ch_defense_backup         = ch_backupstats + $05
ch_evasion_backup         = ch_backupstats + $06
ch_magicdefense_backup    = ch_backupstats + $07
ch_critrate_backup        = ch_backupstats + $08
ch_weaponelement_backup   = ch_backupstats + $09 
ch_weaponcategory_backup  = ch_backupstats + $0A 
ch_attackailment_backup   = ch_backupstats + $0B 
ch_attackailproc_backup   = ch_backupstats + $0C 
ch_elementweak_backup     = ch_backupstats + $0D
ch_elementresist_backup   = ch_backupstats + $0E
ch_statusresist_backup    = ch_backupstats + $0F
    
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
    en_special      = $0A ;                                     11
    en_attackail    = $0B ; can be changed with magic           12
    en_category     = $0C ;                                     13 
    en_magdef       = $0D ;                                     14 
    en_elemweakness = $0E ; can be changed with magic           15
    en_elemresist   = $0F ; can be changed with magic           16
    en_elemattack   = $10 ;                                     17
    en_speed        = $11 ;                                     18
    en_level        = $12 ;                                     19  
    en_item         = $13 ; can be changed by stealing          20
    en_BLANK        = $14 ;                                     21
    
    ;; this block matches enemy ROM layout
    
    en_aimagpos     = $15 ; NOT USED ANYMORE                    22
    en_extraAI      = $16 ; holds info like counter, guard, etc 23
    en_numhitsmult  = $17 ; can be changed with magic   24
    en_ailments     = $18 ; can be changed with magic   25
    en_hp           = $19 ; $1A ; 2 bytes               26 27
    en_enemyid      = $1B ;                             28
    
btl_enemyrewards    = $6200 ; up to $6224 (9*4)
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
   
btl_enemyIDs               = $6240  ; 9 entries of enemy IDs
btl_enemyroster            = $6249  ; 4 bytes of enemy IDs printed in the main battle menu, showing enemies in the fight
btl_enemyamount            = $624F  ; temp byte for number of enemies, for battle printing
btl_enemygfxplt            = $6250  ; 9 entries of enemy graphic and palette assignment (graphic in high 2 bits, plt in low bit)

btl_unfmtcbtbox_buffer     = $6300  ; 

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
btl_charhitmult         = $681C ; Hit multiplyer
btl_charparry           = $6820 ; BB/Master Parry skill
btl_charcover           = $6828 ; Knight Cover, 8 bytes ; first 4 =  who is being covered, second 4 = by whom
btl_charregen           = $682C ; Regeneration status
btl_charguard           = $6830 ; Guard status
btl_charpray            = $6834 ; White Pray skill
btl_charfocus           = $6838 ; Black Focus skill
btl_charhidden          = $683C ; Hidden status
btl_charreflect         = $6840 ; Reflection status
btl_charrunic           = $6844 ; Red Runic skill
btl_charrush            = $6848 ; Fighter Rush skill


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
btlcurs_positions       = $69A0 ; $18 bytes, 2 bytes per entry, each entry is the pixel coord of where the
;                               ; cursor should be drawn when its item is selected. lut_MagicCursorPos has the most

btltmp_backseat         = $69F0 ; $10 byte buffer -- backup of btltmp


lut_MagicData   = $7000  ; $400 bytes
lut_EnemyAi     = $7400  ; $90 bytes

PlayerHPString_RAM   = $74E0 ; $20 bytes

;Sizes of the battle message boxes in RAM
BattleBoxBuffers     = $7500
BattleBoxBufferList  = $7FF0
UndrawNBattleBlocks_loopctr = $7FFB
btl_boxcount          = $7FFC
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
