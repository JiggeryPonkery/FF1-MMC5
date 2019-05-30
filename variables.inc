; JIGS - 
; All data that is saved to each game slot is in "work RAM" at $5C00
; Saving temporarily wipes RAM from $6000 to $7FFF so make sure nothing important is there that needs to be constant while on the save screen.

; for sound channels (between Bx-Dx)
;  see Constants.inc
ch_scoreptr   = $0
ch_envptr     = $2  ; ptr to start of env data
ch_envpos     = $4  ; pos in env data (00-1F)
ch_lenctr     = $5  ; counter for score data (note length)
ch_frqtblptr  = $6  ; pointer to freq table (changes per octave)
ch_lentblptr  = $8  ; pointer to length table (changes per tempo)
ch_envrate    = $A  ; rate/speed of env table traversal
ch_envrem     = $B  ; remaining "fraction" of env data (3 bits of fraction)
ch_vol        = $C  ; output volume
ch_loopctr    = $D  ; remaining loop counter
ch_freq       = $E  ; output freq.  High bit set marks byte has been written (don't rewrite to reset duty)
;                   ; these are added in for the music system!
ch_loop_marker   = $02D9 ; somehow this will end up at $0379, $0389, $0399, $03A9, and $03B9
ch_return        = $02DA ; +B
ch_duty          = $02DC ; so $0300 has $121 bytes before it interferes
ch_octave        = $02DD ; and $0370, $0380, $0390, $03A0, $03B0 all have 9 bytes at the front free
ch_quiet         = $02DE ; (though they're almost all used up already!)
ch_extraquiet    = $02DF


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
item_soft       = items + $06
item_down       = items + $07
item_tent       = items + $08
item_cabin      = items + $09
item_house      = items + $0A
item_eyedrops   = items + $0B
item_smokebomb  = items + $0C
item_bell       = items + $0D
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


Character1BattleState = ch_stats + $10 ; these will match up to ch_battlestate in ch_stats
Character2BattleState = ch_stats + $10 + $40 ; 
Character3BattleState = ch_stats + $10 + $80 ; 
Character4BattleState = ch_stats + $10 + $C0 ;


ch_stats          = unsram + $0100  ; MUST be on page bound.  Each character allowed $40 bytes, so use 00,40,80,C0 to index ch_stats
ch_class          = ch_stats + $00
ch_ailments       = ch_stats + $01
ch_name           = ch_stats + $02 ; 03, 04, 05, 06, 07, 08 - 7 bytes 
ch_exp            = ch_stats + $09 ; 0A, 0B - 3 bytes
ch_curhp          = ch_stats + $0C ; 0D - 2 bytes
ch_maxhp          = ch_stats + $0E ; 0F - 2 bytes
ch_battlestate    = ch_stats + $10 ; JIGS - for hiding and regeneration and guarding and all that
ch_level          = ch_stats + $11 ; OB this is 0 based, IB this is 1 based
ch_strength       = ch_stats + $12
ch_agility        = ch_stats + $13
ch_intelligence   = ch_stats + $14 
ch_vitality       = ch_stats + $15
ch_speed          = ch_stats + $16
ch_substats       = ch_stats + $17
ch_damage         = ch_stats + $17
ch_hitrate        = ch_stats + $18
ch_defense        = ch_stats + $19
ch_evasion        = ch_stats + $1A
ch_magicdefense   = ch_stats + $1B
ch_elementresist  = ch_stats + $1C ; effected by equipment, needs to refresh after battle
ch_elementweak    = ch_stats + $1D ; effected by equipment, needs to refresh after battle
;nothing          = ch_stats + $1E
;nothing          = ch_stats + $1F

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
ch_numhitsmult    = ch_stats + $2D ; effected by equipment, needs to refresh after battle
ch_critrate       = ch_stats + $2E ; effected by equipment, needs to refresh after battle
;nothing          = ch_stats + $2F
ch_mp             = ch_stats + $30 ; 31, 32, 33, 34, 35, 36, 37 - 8 bytes
ch_spells         = ch_stats + $38 ; 39, 3A, 3B, 3C, 3D, 3E, 3F - 8 bytes

inv_equip         = unsram + $200
inv_weapon        = inv_equip ; 64 bytes
inv_armor         = inv_equip + $40 ; 64 bytes
inv_magic         = unsram + $280 ; 64 bytes, 1 per spell

game_flags        = unsram + $0300  ; must be on page bound


 

story_dropinput = $07
inroom          = $0D ; bit 7 is the actual inroom flag.  $x1=entering room, $x2=entering locked room (different sprite vis), $x5=exiting room, $x6=exiting locked room
doorppuaddr     = $0E ; 2 bytes, PPU address of door drawing work

tmp             = $10 ; 16 bytes

mu_scoreptr     = tmp+8  ;2 bytes, shared tmp

dlgbox_row      = tmp+$C  ; shared tmp
palcyc_mode     = tmp+$C  ; shared tmp

joy             = $20
joy_ignore      = $21
joy_select      = $22
joy_start       = $23
joy_a           = $24
joy_b           = $25

sprindex        = $26

ow_scroll_x     = $27  ; X scroll of OW in tiles
ow_scroll_y     = $28  ; Y scroll in tiles

sm_scroll_x     = $29  ; ditto, but for standard maps
sm_scroll_y     = $2A

mapdraw_x       = $2B
mapdraw_y       = $2C
mapflags        = $2D  ; bit 0 set when in standard map.  bit 1 set to indicate column drawing instead of row drawing

scroll_y        = $2F  ; Y scroll in tiles (16x16).  range=0-E

mapdraw_nty     = $30
mapdraw_ntx     = $31
mapdraw_job     = $32  ; 0=no job, 1=draw attribs, 2=draw tiles

mg_slidedir     = $33  ; shared
facing          = $33  ; 1=R  2=L  4=D  8=U
move_speed      = $34  ; pixels to move per frame (map)
move_ctr_x      = $35  ; pixels between tiles (map movement -- 00-0F)
move_ctr_y      = $36  ; ditto but for Y axis

menustall       = $37       ; see MenuCondStall in bank F for explanation

theend_x        = $38
theend_y        = $39
theend_src      = $62
theend_drawbuf  = $6800     ; $700 bytes!

box_x           = $38
box_y           = $39
box_wd          = $3C ; shared
box_ht          = $3D ; shared

dest_x          = $3A
dest_y          = $3B
dest_wd         = $3C
dest_ht         = $3D


image_ptr       = $3E ; shared
text_ptr        = $3E ; 2 bytes

spr_x           = $40
spr_y           = $41

mm_maprow       = $41 ; shared

vehicle         = $42 ;1=walking, 2=canoe, 4=ship, 8=airship

inforest        = $43 ; nonzero if in forest

tileprop        = $44 ; 2 bytes

vehicle_next    = $46 ; vehicle we're walking onto

vehchgpause     = $47 ; forced pause when changing vehicles
cur_map         = $48
cur_tileset     = $49

cur_mapobj      = $4A ; counter for updating which map object

music_track     = $4B
mu_chanprimer   = $4C
mu_chan         = $4D

entering_shop   = $50 ; nonzero = about to enter shop
shop_id         = $51

tileprop_now    = $52 ; special tile properties that we're on (tileprop isn't necessarily what we're standing on)

ow_tile         = $53

ppu_dest        = $54  ; 2 bytes

dlgflg_reentermap = $56  ; flag to indicate the map needs re-entering due to dialogue (Bahamut/class change)
cur_bank        = $57
ret_bank        = $58

descboxopen     = $59


format_buf      = $60  ; 7 bytes (5A-60) -- must not cross page bound

shutter_a       = $61  ; shared
shutter_b       = $62  ; shared

mm_bplo         = $61  ; shared
mm_bphi         = $62  ; shared

intro_ataddr    = $62  ; shared
intro_atbyte    = $63  ; shared
intro_color     = $64  ; shared

dlg_itemid      = $61  ; shared
joy_prevdir     = $61
cursor          = $62
cursor_max      = $63
cursor2         = $63  ; shared (secondary cursor)

mg_slidespr     = $64  ; shared, 3 bytes

namecurs_x      = $64
shopcurs_x      = $64  ; shared
hp_recovery     = $64
mp_required     = $65
namecurs_y      = $65
shopcurs_y      = $65  ; shared
story_credits   = $65  ; shared

minimap_ptr     = $64  ; shared, 2 bytes

submenu_targ    = $66  ; shared with shop_type
shop_type       = $66
story_page      = $66  ; shared

story_timer     = $67  ; shared
draweq_stradd   = $67  ; shared
char_index      = $67
mm_pixrow       = $67  ; shared
talkobj         = $67  ; shared -- object you're talking to on SM

sm_player_x     = $68  ; player X/Y position on standard map.  Only used for NPC collision detection
sm_player_y     = $69

btlformation    = $6A
enCHRpage       = $6B

altareffect     = $6C  ; flag to indicate altar effect is to occur (screen shaking, monochrome diagonal window thing)

sq2_sfx         = $6D

shop_cursor_ptr = $6E ; +$6F

enemy_load      = $70 ; all $10 bytes, 4 per enemy

cursor_change       = $71 ; magic menu 
treasure_offset     = $72 ; maps
item_box_offset     = $72 ; shops
item_box_offset_old = $73 ; shops
backup_cursor       = $73 ; shops, menus
backup_cursor_targ  = $74 ; item menus
inv_canequipinshop  = $74 ; shops
battleitemslot      = $74 ; equip menu
equipmenu_tmp       = $75 ; for unequip/reequipping



;;
;; Pointers
;;
btl_drawflags_tmp1   = $80 ; tmp storage for drawing sleep/dead character sprites
btl_drawflags_tmp2   = $81 ; immediately written over by CharStatsPointer

;; leveling up
lvlup_curexp        = $80  ; 2 byte pointer to character's current EXP
lvlup_exptoadv      = $82  ; 2 byte pointer to EXP needed to advance
lvlup_chstats       = $86  ; 2 byte pointer to character's OB stats
battlereward        = $88  ; 3 bytes.  Note that while this var is 3 bytes, this stop behaving properly
;                          ;  if rewards ever exceed the 2-byte boundary, since the game assumes you
;                          ;  will never receive more than 65535 XP/GP in any one battle.
;; physical and magical attacks
CharacterStatPointer   = $4E ; $4F ; far as I can tell these are unused by the game...?
CharStatsPointer       = $80 ; another one!
CharBackupStatsPointer = $82
AilmentPrintingPointer = $82
EnemyRAMPointer        = $84  ; 2 byte pointer to enemy's adjustable stats
EnemyROMPointer        = $86  ; 2 byte pointer to enemy's hard stats
BattleMenuPointer      = $88  
WeaponPointer          = $88  ; 2 byte pointer to weapon data
MagicPointer           = $8A  ; MagicPointer
EnemyAIPointer         = $8A
BattleBoxString        = $8A

;btl_entityptr_ibram     = $90
;btl_entityptr_obrom     = $92





btldraw_blockptrstart = $8C
btldraw_blockptrend   = $8E

btltmp          = $90  ; 16 bytes ?


btldraw_src     = $90   ; source data
btldraw_dst     = $92   ; destination pointer
btldraw_subsrc  = $94   ; source pointer of substring
btldraw_max     = $9F   ; maximum characters to draw


btlsfx_frontseat    = $90   ; where battle sfx data is stored in zero page
btlsfx_backseat     = $6D97 ; where it is stored when not in zero page (it swaps between the two)

btlsfx_framectr     = $94   ; The total frame counter for the entire sound effect
btlsfxsq2_len       = $98
btlsfxnse_len       = $99
btlsfxsq2_framectr  = $9A
btlsfxnse_framectr  = $9B
btlsfxsq2_ptr       = $9C
btlsfxnse_ptr       = $9E




framecounter    = $F0  ; 2 bytes!

equipoffset     = $F2 ; menus
Woosh           = $F3 ; battle

npcdir_seed     = $F4  ; RNG seed for determining direction for NPCs to walk

battlestep      = $F5
battlestep_sign = $F6
battlecounter   = $F7
battlerate      = $F8  ; X/256 chance of a random encounter occuring (SM only apparently)

startintrocheck = $F9
spaceruns       = $FA ; drawcomplexstring

dlgmusic_backup = $FB  ; backup music track for restoring music after the dialogue box changes it
dlgsfx          = $FC  ; flag to indicate to play a sound effect after opening dialogue box.  0=no sfx, 1=fanfare, else=treasure

NTsoft2000      = $FD  ; same as soft2000, but used to track coarse NT scroll
unk_FE          = $FE
soft2000        = $FF

unk_0100        = $0100 ; stack? 

tmp_hi          = $0110  ; 3? bytes

oam             = $0200  ; 256 bytes -- must be on page bound
oam_y           = oam
oam_t           = oam+1
oam_a           = oam+2
oam_x           = oam+3

MMC5_tmp        = $0360 ; 16 bytes, tmp ram not used by the original game
;; ^ battle turn order uses up $0D of this ^ 

;; some random Jiggers variables ; these can't go past $03x8

actual_bank     = $0370 ; necessary for Disch's longcall routine!
weasels         = $0371 ; Important for saving/loading
SFX_ErrorTime   = $0371 ; might have to do with using the noise channel for error SFX
TriangleHush    = $0372 ; Slowly raises and lowers a DMC thing to quiet the triangle channel
MenuHush        = $0373 ; Toggles in the main menu, keeps map music playing, and is used to help hush the triangle
soundtest       = $0374 ; Something to do with the sound test screen
BlankItem       = $0374 ; Necessary for shops to display correctly
autobattle      = $0374 ; for battling fast
Hidden          = $0375 ; for hiding in battle 
HiddenMagic     = $0376 ; for hiding in battle 
Asleep          = $0377 ; for sleeping! ...in battle. And save game music things.
BattleTurn      = $0378 ; Keeps track of battle turns and displays them above the character's names ; shared
battle_class    = $0380 ; for doing skills in battle
soundtesthelper = $0381 ; Something to do with the sound test screen
battle_stealsuccess        = $0382
RomRamMapping_lut_index    = $0383
btl_loadenemystats_counter = $0384
btl_loadenemystats_index   = $0385
LongCall_A      = $0386 ; The LongCall routine restores them after it swaps banks
LongCall_Y      = $0387
LongCall_X      = $0388
gettingcommand  = $0390



;; back to original variables

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

LevelUp_Pointer     = $82
LevelUp_LoopCounter = $6000
LevelUp_ClassID     = $6001
LevelUp_StatByte    = $6002
LevelUp_LevelIndex  = $6003
LevelUp_StatIndex   = $6004
LevelUp_StatBuffer  = $6005 ; 6, 7, 8, 9 - 5 bytes
 
TempSpellList        = $6000 ; to 6017 ; 24 bytes
TempSpellListIndex   = $6018
GetSpellLevelIndex   = $6019
CharacterIndexBackup = $601A
CharacterEquipBackup = $601B
    
bigstr_buf        = $6300 ; 128 bytes
SaveScreenCharBuf = $6300 ; for printing the names of characters in all 3 save slots ; seems safe to overwrite bigstr_buf while printing

puzzle           = $6400  ; used 
str_buf          = $6400  ; $39 bytes at least -- buffer must not cross page
item_box         = $6400  ; used in shops
btl_screenbackup = $6400  ; used in battle

shop_curprice     = $649C ; 9D, 9E, 9F - 4 bytes ; will mess up buying things if shared
shop_curitem      = $64A0
shop_amount       = $64A1
shop_amount_high  = $64A2
shop_amount_buy   = $64A3
shop_amount_max   = $64A4
shop_charindex    = $64A5
shop_spell        = $64A6
shop_selling      = $64A7
shop_cursorchange = $64A8
shop_listdrawn    = $64A9
shop_listactive   = $64AA
ItemToUnequip     = $64AC
ItemToEquip       = $64AD
slotcheck         = $64AE
equip_impossible  = $64AF
shop_x_price      = $64AF

;;;;;; ALL THE BATTLE STUFF!! ;;;;;;;


btl_turnorder       = $6000 ; $D entries (9 enemies + 4 characters)
GuardDefense        = $600F ; amount to add to a players btl_defender_defense stat
battle_item         = $600F ; handles item box scrolling and item use
btl_turnorderBackup = $6010 ; 13 bytes
btl_turnorderSpeed  = $6020 ; 13 bytes


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
btl_attacker_graphic         = btl_attacker + $0A ; the graphic used for an attack
btl_attacker_varplt          = btl_attacker + $0B ; The variable palette color used for an attack
btl_attacker_sprite          = btl_attacker + $0C 
btl_attacker_class           = btl_attacker + $0D
btl_attacker_hidden          = btl_attacker + $0E

btlmag_spellconnected       = btl_attacker + $01
btlmag_effect               = btl_attacker + $02
btlmag_effectivity          = btl_attacker + $03
btlmag_hitrate              = btl_attacker + $04
btlmag_element              = btl_attacker + $05
btlmag_fakeout_defindex     = btl_attacker + $06 ; See Battle_DoTurn in bank C for a description of
btlmag_fakeout_ailments     = btl_attacker + $07 ;   what these 'fakeout' vars are and how/why they're used
btlmag_fakeout_defplayer    = btl_attacker + $08

btl_defender                 = $6040 
btl_defender_index           = btl_defender + $01
btl_defender_damage          = btl_defender + $02
btl_defender_hitrate         = btl_defender + $03
btl_defender_defense         = btl_defender + $04
btl_defender_evasion         = btl_defender + $05
btl_defender_magicdefense    = btl_defender + $06
btl_defender_morale          = btl_defender + $07
btl_defender_category        = btl_defender + $08
btl_defender_elementweakness = btl_defender + $09
btl_defender_elementresist   = btl_defender + $0A
btl_defender_ailments        = btl_defender + $0B
btl_defender_hidden          = btl_defender + $0C
btl_defender_class           = btl_defender + $0D
btl_defender_hpmax           = btl_mathbuf + (MATHBUF_DEFENDERMAXHP*2)
btl_defender_hp              = btl_mathbuf + (MATHBUF_DEFENDERHP*2)  ; $687C -- treated as part of math buffer by some code

btlmag_defender_intelligence    = btl_defender + $01
btlmag_defender_speed           = btl_defender + $02
btlmag_defender_damage          = btl_defender + $03
btlmag_defender_hitrate         = btl_defender + $04
btlmag_defender_defense         = btl_defender + $05
btlmag_defender_evasion         = btl_defender + $06
btlmag_defender_magicdefense    = btl_defender + $07
btlmag_defender_morale          = btl_defender + $08 ; morale for enemies
btlmag_defender_battlestate     = btl_defender + $08 ; battlestate for players
btlmag_defender_numhitsmult     = btl_defender + $09
btlmag_defender_category        = btl_defender + $0A
btlmag_defender_weaponelement   = btl_defender + $0B
btlmag_defender_weaponcategory  = btl_defender + $0C
btlmag_defender_elementweakness = btl_defender + $0D
btlmag_defender_elementresist   = btl_defender + $0E
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
    MATHBUF_MAGDEFENDERHP       = $08 ;$12
    MATHBUF_DEFENDERHP          = $08 ;$13
    MATHBUF_MAGDEFENDERMAXHP    = $09 ;$15
    MATHBUF_DEFENDERMAXHP       = $09 ;$15
    MATHBUF_TOTALDAMAGE         = $0A ;$16
    
btl_mathbuf = $6050 ;   ; $16 bytes, 2 byte pairs, used as buffers for mathematical routines
    math_hitchance      = btl_mathbuf + (MATHBUF_HITCHANCE*2)       ; $6040 ; 
    math_basedamage     = btl_mathbuf + (MATHBUF_BASEDAMAGE*2)      ; $6042 ; 
    math_numhits        = btl_mathbuf + (MATHBUF_NUMHITS*2)         ; $6044 ; 
    math_magrandhit     = btl_mathbuf + (MATHBUF_MAGRANDHIT*2)      ; $6044 ; 
    math_category       = btl_mathbuf + (MATHBUF_CATEGORY*2)        ; $6046 ;  not really math... but whatever
    math_element        = btl_mathbuf + (MATHBUF_ELEMENT*2)         ; $6048 ;  not really math... but whatever
    math_randhit        = btl_mathbuf + (MATHBUF_RANDHIT*2)         ; $6048 ; 
    math_dmgcalc        = btl_mathbuf + (MATHBUF_DMGCALC*2)         ; $604A ; 
    math_critchance     = btl_mathbuf + (MATHBUF_CRITCHANCE*2)      ; $604C ; 
    math_ailmentchance  = btl_mathbuf + (MATHBUF_AILMENTCHANCE*2)   ; $604E ; 
;btlmag_defender_hp     = btl_mathbuf + (MATHBUF_MAGDEFENDERHP*2)   ; $6050 ; 
;btl_defender_hp        = btl_mathbuf + (MATHBUF_DEFENDERHP*2)      ; $6050 ;  -- treated as part of math buffer by some code
;btlmag_defender_hpmax  = btl_mathbuf + (MATHBUF_MAGDEFENDERMAXHP*2); $6052 ; 
;btl_defender_hpmax     = btl_mathbuf + (MATHBUF_DEFENDERMAXHP*2)   ; $6052 ; 
    battle_totaldamage  = btl_mathbuf + (MATHBUF_TOTALDAMAGE*2)     ; $6054 ;  -- treated as part of math buffer by some code

;; the following stats are saved at the start of battle, and re-applied at the end of battle. Everything that can change in battle needs to be un-done.
ch_backupstats           = $60C0 ;; $10 per character, so fills up to $60FF
ch_slotindex_backup      = ch_backupstats
ch_intelligence_backup   = ch_backupstats + $01
ch_speed_backup          = ch_backupstats + $02
ch_damage_backup         = ch_backupstats + $03
ch_hitrate_backup        = ch_backupstats + $04
ch_defense_backup        = ch_backupstats + $05
ch_evasion_backup        = ch_backupstats + $06
ch_magicdefense_backup   = ch_backupstats + $07
ch_elementresist_backup  = ch_backupstats + $08
ch_elementweak_backup    = ch_backupstats + $09
ch_weaponelement_backup  = ch_backupstats + $0A 
ch_weaponcategory_backup = ch_backupstats + $0B 
ch_numhits_backup        = ch_backupstats + $0C
ch_numhitsmult_backup    = ch_backupstats + $0D
ch_critrate_backup       = ch_backupstats + $0E    
    
btl_enemystats      = $6100  ; $1B bytes per enemy, 9 enemies = 243 bytes 
;    en_exp          = $00 ; 2 bytes                     1 2
;    en_gp           = $02 ; 2 bytes                     2 3 
    en_hpmax        = $00 ; 2 bytes                     1 2 
    en_morale       = $02 ; can be changed with magic   3
    en_ai           = $03 ;                             4
    en_evade        = $04 ; can be changed with magic   5
    en_defense      = $05 ; can be changed with magic   6
    en_numhits      = $06 ;                             7
    en_hitrate      = $07 ; can be changed with magic   8
    en_strength     = $08 ; can be changed with magic   9 
    en_critrate     = $09 ;                             10
    en_special      = $0A ;                             11
    en_attackail    = $0B ;                             12
    en_category     = $0C ;                             13 
    en_magdef       = $0D ;                             14 
    en_elemweakness = $0E ; can be changed with magic   15
    en_elemresist   = $0F ; can be changed with magic   16
    en_elemattack   = $10 ;                             17
    en_speed        = $11 ;                             18
    en_level        = $12 ;                             19  
    en_item         = $13 ; can be changed by stealing  20
    en_blank        = $14 ;                             21
    ;; this block matches enemy ROM layout
    
    en_aimagpos     = $15 ;                             22
    en_aiatkpos     = $16 ;                             23
    en_numhitsmult  = $17 ; can be changed with magic   24
    en_ailments     = $18 ; can be changed with magic   25
    en_hp           = $19 ; $1A ; 2 bytes               26 27
    en_enemyid      = $1B ;                             28
    
    ;; JIGS - I am NOT AT ALL convinced I haven't screwed up elemental weakness/resistance bug fixing.

btl_enemyrewards  = $6200
    en_exp          = $00 ; 2 bytes                     1 2
    en_gp           = $02 ; 2 bytes                     2 3 

;; $6300 is used by bigstr_buf, which prints the "Ready now?" box and maybe something else
;; $6400 is used by the Item option
btl_stringoutputbuf_anchor = $6400  ; JIGS - only needs to be $20 before btl_stringoutputbuf? 
btl_enemyIDs               = $6410  ; 9 entries of enemy IDs
btl_enemyroster            = $641A  ; $6BC9  ; 4 bytes of enemy IDs printed in the main battle menu, showing enemies in the fight
btl_enemyamount            = $641E  ; JIGS - tmp byte for number of enemies, for battle printing
btl_stringoutputbuf        = $641F  ; output buffer where decoded strings are printed
btl_unfmtcbtbox_buffer     = $6440  ; $6AFA  ; $80 bytes total, $10 bytes for each combat box.
                                    ; houses the unformatted text for each combat box.
                                    ; Additional bytes are used for other areas


btl_msgbuffer   = $6500  ; $691E   ; $180 bytes  ($0C rows * $20 bytes per row)
                         ; this buffer contains on-screen tiles to be drawn to ppu$2240
                         ; (note only $19 bytes are actually drawn, the remaining 7 bytes are padding)

btl_msgdraw_hdr         = $6640
btl_msgdraw_x           = $6641
btl_msgdraw_y           = $6642
btl_msgdraw_width       = $6643
btl_msgdraw_height      = $6644
btl_msgdraw_srcptr      = $6643  ; shared -- needs to match btl_msgdraw_width?
;                                ; $0544    above +1
btl_msgdraw_blockcount         = $6645 ; the number of blocks drawn
btl_msgdraw_blockcount_backup  = $6646
btl_combatboxcount             = $6647 ; the number of combat boxes that have been drawn
btl_combatboxcount_alt         = $6648 ; ANOTHER combatbox counter... this is totally redundant
DrawBattleMagicBox_loopctr     = $6649
UndrawNBattleBlocks_loopctr    = $664A
btl_drawbox_loopctr            = $664B
btl_msgbuffer_loopctr          = $664C
EOBCombatBox_tmp               = $664D
btl_tmp_drawcombatbox1         = $664E
btl_tmp_drawcombatbox2         = $664F
DrawBattleMagicBox_toporbottom = $6650
btltmp_boxleft                 = $6651
btltmp_boxcenter               = $6652
btltmp_boxright                = $6653
btltmp_altmsgbuffer            = $6660  ; $20 bytes read
btltmp_damageblockbuffer       = $6680  ; 6 bytes used, but $20 are read?
btl_stringbuf                  = $66A0  ; $21 byte buffer to contain string data for printing (reads $21st byte, but doesn't use?)
btl_attackbox_itemid           = $66C0  ; 
btlbox_blockdata               = $6700  ; at least #91 bytes (Gear option is the biggest so far)



eob_gp_reward               = $6876
eob_exp_reward              = $6878
eobtext_print_level = $687A
eobtext_print_hp    = $687C

battle_ailmentrandchance    = $6866

btl_weird_thing = $6868 ;  LDA  btl_defender_elemresist,  AND btl_attacker_element, STA to this...

battle_hitsconnected        = $686A     ; number of hits actually connected
battle_critsconnected       = $686B



;; Battle stuff for magical attacks


                            
                                    ; These two are kind of redundant
;battle_attacker_index       = $6884 ; ?? redundant??  why not just use btl_attacker?
;btl_defender_index       = $6885 ; same... but this is necessary for output!  See Battle_DoTurn in bank C!!

battle_defenderisplayer     = $6887 ; nonzero if player is defending, zero if enemy is defending 
                                    ;   important for output!  See Battle_DoTurn in bank C

;btl_attacker_ailments       = $6888
;btl_defender_ailments       = $6889 ; important for output!

btl_rngstate = $688A    ; State of RNG used for in-battle

btltmp_divLo = $688B
btltmp_divHi = $688C
btltmp_divV  = $688D

btl_curturn         = $688E         ; current turn (index for btl_turnorder)

;  Buffers to hold character commands for battle.  These must be contiguious in memory
;  due to the way memory is cleared.  These buffers also contain a bit of redundant data.
;
;  btl_charcmdbuf contains 3 bytes (padded to 4) per character:
;    byte 0 = command
;    byte 1 = spell effect ID  (used for Item/MAGIC/ITEM).  FF if no effect
;    byte 2 = target.  8x are player targets 0x are enemy targets.  FF=target all enemies, FE=target all players.
;
;  Commands can be the following:
;    00 = no command -- if surprised/asleep/stunned
;    01 = no command -- if dead
;    02 = no command -- if stone
;    04 = attack
;    08 = Item potion
;    10 = use item
;    20 = run   ('target' would be the actual character running)
;    40 = magic
;    80 = hide
;    FF = guard
; 
;  btl_charcmditem contains 1 byte per character:  the ID of the item they're using.
;    This is only used when the command is '10'
;
;  btl_charcmdconsumetype contains 1 byte per character.  It will be 01 for magic and 02 for Item.
;       unused for other commands.
;
;  btl_charcmdconsumeid contains 1 byte per character.  If will be the potion index
;       for Item, or the spell level for magic

btl_charcmdbuf          = $688F
btl_charcmditem         = btl_charcmdbuf+$10        ; $689F
btl_charcmdconsumetype  = btl_charcmditem+4         ; $68A3
btl_charcmdconsumeid    = btl_charcmdconsumetype+4  ; $68A7

btl_walkdirection = $68AB

char_order_buf = $689F ; 4 bytes

Rand_AX_lo    = $68AF
Rand_AX_high  = $68B0
Rand_AX_range = $68B6

DrawCharTmp = $68B6

btl_weird_tmp = $68B1
btl_various_tmp = $68B3 ; + B4



; These next 5 vars are all in temp memory, and are mostly just used for 
;  passing into BattleDraw8x8Sprite
btl8x8spr_x = $68AF ; X coord
                    ;  +1 used in drawing code as original position
btl8x8spr_y = $68B1 ; Y coord
                    ;  +1 used in drawing code as original position
btl8x8spr_a = $68B3 ; attribute
btl8x8spr_t = $68B4 ; tile ID
btl8x8spr_i = $68B5 ; slot to draw to (00-3F)


  
btl_tmpindex = $68B3    ; temporary holder for a current index
btl_tmpchar =  $68B4    ; temporary holder for a 0-based character index

btltmp_multA = $68B3    ; shared
btltmp_multB = $68B4    ; shared
btltmp_multC = $68B5

btl_another_loopctr = $68B4



btl_input        = $68B3

btl_soft2000 = $68B7    ; soft copy of $2000 used in battles
btl_soft2001 = $68B8    ; soft copy of $2001 used in battles



eobbox_slotid       = $6AA6
eobbox_textid       = $6AA7

btlinput_prevstate  = $6AA6     ; prev state for input
inputdelaycounter   = $6AA7     ; counter to delay multiple-input processing when holding a direction

btl_walkloopctr     = $6AA8

btl_animatingchar   = $6AA9     ; the character currently being animated (0-3)

btlcurs_x           = $6AAA     ; battle cursor X position (menu position, not pixel position)
btlcurs_y           = $6AAB     ; battle cursor Y position (menu position, not pixel position)
btlcurs             = $6AAA
btlcurs_max         = $6AAB     ; highest value for the cursor
btlcurs_positions   = $6AAC     ; ?? bytes, 2 bytes per entry, each entry is the pixel coord of where the
                                ;   cursor should be drawn when its item is selected.

btl_flashsprite1     = $6AAA 
btl_flashsprite2     = $6AAC 
                                
                                
btl_respondrate_tmp = $6AD0                                
                                
btl_drawflagsA = $6AD1  ; bits 0-3 = set to indicate character should be drawn as dead
                        ; bit    4 = set to draw battle cursor
                        ; bit    5 = set to draw weapon attack graphic
                        ; bit    6 = set to draw magic graphic & flash BG.

btl_drawflagsB = $6AD2  ; bits 0-4 = set to indicate character should be drawn as stone

btl_chardrawinfo = $6AD3        ;$10 bytes, 4 bytes for each character
    btl_chardraw_x      = btl_chardrawinfo+0
    btl_chardraw_y      = btl_chardrawinfo+1
    btl_chardraw_gfxset = btl_chardrawinfo+2
    btl_chardraw_pose   = btl_chardrawinfo+3
    
btlcursspr_x        = $6AE3
btlcursspr_y        = $6AE4
btlattackspr_x      = $6AE5
btlattackspr_y      = $6AE6

btlattackspr_t      = $6AE7     ; indicate which tile to draw for the weapon graphic
btlattackspr_pose   = $6AE8     ; for weapons, 0 or 8 to indicate whether or not to flip it
                                ; for magic, 0 or ?4? to indicate which frame to draw
btlattackspr_gfx    = $6AE9     ; copied to 't' prior to drawing.  Indicates which graphic to use
btlattackspr_wepmag = $6AEA     ; 0 for drawing the weapon, 1 for drawing the magic

btlattackspr_hidell = $6AED     ; nonzero to hide the lower-left tile of the attack graphic
                                ;   This is done for the "behind the back" frame of weapon swing animation.
btlattackspr_nodraw = $6AEE     ; nonzero to hide the weapon/magic sprite entirely.  This is
                                ;   Used when a non-BB player attacks without any weapon equipped
                                ;   Also used when using ITEMs to supress the magic flashing effect.

btltmp_targetlist   = $6AEF     ; temporary buffer (9 entries) containing possible targets



btl_targetbacketup  = $6AF9     ; the number of combat boxes that have been drawn


                                
btlcmd_curchar      = $6B7A     ; the current character inputting battle commands (0-3)
btlcmd_target       = $6B7B     ; the current enemy slot that is being targetted

btlcmd_spellindex   = $6B7D

btlcmd_magicgfx     = $6B7E     ; 2 bytes per character.  [0] = graphic to draw, [1] = palette to use

btl_result          = $6B86 ;   0 = keep battling
                            ;   1 = party defeated
                            ;   2 = all enemies defeated
                            ;   3 = party ran
                            ; $FF = wait for 2 seconds after fadeout before exiting (chaos defeated?)

btl_usepalette      = $6B87 ; $20 bytes - the palette that is actually displayed (after fade effects)

btl_followupmusic   = $6BA7 ; song to play in battle after current song finishes.  Moved to music_track
                            ;    once music_track has its high bit set  (does this ever happen?)

btl_charattrib      = $6BA8 ; attributes to use when drawing charcters in battle  (4 bytes, 1 for each)

btl_responddelay    = $6BAC


lvlup_levindex = $6BAD ; see LvlUp_LevelUp
btl_weird_loopctr = $6BAD


btl_strikingfirst   = $6BAE ; nonzero if players are striking first.  Zero otherwise


battle_bank     = $6BB1  ; The bank to jump back to for setting up battles
btl_smallslots  = $6BB2             ; Number of small enemy slots available
btl_largeslots  = btl_smallslots+1  ; Number of large slots available.  Must immediately follow smallslots

btl_enemyeffect = $6BB6     ; 0 to draw expolosion graphics as the effect
                            ;   nonzero to erase the enemy as the effect

btl_enemygfxplt = $6BC0  ; 9 entries of enemy graphic and palette assignment (graphic in high 2 bits, plt in low bit)


btl_targetall_tmp = $6BCE

btl_drawformationtmp = $6BCF
btl_randomplayer    = $6BCF ; set by GetRandomPlayerTarget  (0-3)
btl_mathbufadd16tmp1 = $6BCF

btl_drawformationtmp2 = $6BD0
btl_mathbufadd16tmp2 = $6BD0



btl_tmppltassign = $6C88    ; temporary value to assign palette to enemies in a formation


btl_attackid            = $6C8C ; >= $40 for enemy attacks



btlmag_magicsource      = $6C8F ; 0=magic, 1=Item, 2=item
btlmag_ailment_orig     = $6C90 ; A backup of 

btl_drawformationindex = $6C91

btl_battletype  = $6C92     ; 0=9 small, 1=4 large, 2=mix, 3=fiend, 4=chaos
btl_enemycount  = $6C93     ; count of the number of enemies being generated for a battle
btltmp_attr     = $6C94     ; $40 bytes of attribute data for the battle setup

explode_min_x   = $6D14
explode_min_y   = $6D15
explode_max_x   = $6D16
explode_max_y   = $6D17
explode_count   = $6D18



btltmp_attackerbuffer   = $6D2C

ScreenShakeCounter = $6D14
btl_backgroundflash = $6D16
; ????          = $6D14   ; action buffer?  $20 bytes?  contents for combat boxes are placed here?



btl_palettes    = $6D34   ; $20 bytes



btltmp_backseat = $6D74   ; $10 byte buffer -- backup of btltmp


btl_formdata    = $6D84   ; $10 bytes (formation data as appears in ROM)
    btlform_type    = btl_formdata+$0   ; battle type (high 4 bits) -- low 4 bits are pattern table
    btlform_engfx   = btl_formdata+$1   ; graphic assignment (2 bits per enemy)
    btlform_enids   = btl_formdata+$2   ; enemy IDs (4 bytes)
    btlform_enqty   = btl_formdata+$6   ; enemy quantities (4 bytes)
    btlform_plts    = btl_formdata+$A   ; palettes for this battle (2 bytes)
    btlform_surprise= btl_formdata+$C   ; surprise rate
    btlform_enplt   = btl_formdata+$D   ; enemy palette assign (in high 4 bits)
    btlform_norun   = btlform_enplt     ; no run flag (in low bit)
    btlform_enqtyB  = btl_formdata+$E   ; enemy quantities for B formation (2 bytes)


btlmag_playerhitsfx = $6DA7     ; sound effect to play when magic hits player
btltmp_smallslotpos = $6DB0
btltmp_buildroster = $6DB0

mapobj          = $6F00   ; $100 bytes -- page
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

enemy_ROM       = $7000  ; $B00 bytes, but on swapped page
 
mapdata         = $7000   ; must be on $1000 byte bound (ie:  pretty much unmovable)

mm_decorchr     = $7000   ; $300 bytes -- should be on page bound, shared
mm_titlechr     = $7300   ; $280 bytes -- should be on page bound, shared
