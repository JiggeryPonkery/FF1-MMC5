
;;;;;;;;;;;;;;;;;;
;;  directions for facing and keys

RIGHT             = $01
LEFT              = $02
DOWN              = $04
UP                = $08
BTN_START         = $10

;;;;;;;;;;;;;;;;;;
;;  music channels
;; JIGS - moving this up $10 bytes to fit 2 more channels of data in.
;; Further channel variables are stores in MMC5 exram... somehow

CHAN_START        = $B0
CHAN_BYTES        = $10 

CHAN_SQ1          = CHAN_START
CHAN_SQ2          = CHAN_START + CHAN_BYTES
CHAN_TRI          = CHAN_START + (2 * CHAN_BYTES)
;; JIGS - for the MMC5 square channels
CHAN_SQ3          = CHAN_START + (3 * CHAN_BYTES)
CHAN_SQ4          = CHAN_START + (4 * CHAN_BYTES)
CHAN_STOP         = $0 ; CHAN_START + (5 * CHAN_BYTES)
EXTRA_CHAN_START  = $0300



;;;;;;;;;;;;;;;;;;
;; ch_stat locations in save games

SaveScreenChar1  = sram+$100
SaveScreenChar2  = sram+$140
SaveScreenChar3  = sram+$180
SaveScreenChar4  = sram+$1C0
SaveScreenChar5  = sram2+$100
SaveScreenChar6  = sram2+$140
SaveScreenChar7  = sram2+$180
SaveScreenChar8  = sram2+$1C0
SaveScreenChar9  = sram3+$100
SaveScreenChar10 = sram3+$140
SaveScreenChar11 = sram3+$180
SaveScreenChar12 = sram3+$1C0

;;;;;;;;;;;;;;;;;;
;; battle actions
ACTION_FIGHT      = $01
ACTION_MAGIC      = $02
ACTION_SKILL      = $04
ACTION_GEAR       = $08
ACTION_GUARD      = $10
ACTION_ITEM       = $20
ACTION_HIDE       = $40
ACTION_FLEE       = $80

;;;;;;;;;;;;;;;;;;
;;  Enemy AI extras
ENEMYAI_COUNTER   = $01
ENEMYAI_REFLECT   = $80

ENEMY_ATTACK_START = $45 ; this is the offset for enemy magic data

;;;;;;;;;;;;;;;;;;
;;  elements
ELEMENT_TIME      = $01
ELEMENT_STUN      = $02
ELEMENT_POISON    = $04
ELEMENT_DEATH     = $08
ELEMENT_FIRE      = $10
ELEMENT_ICE       = $20
ELEMENT_LIGHTNING = $40
ELEMENT_EARTH     = $80


;;;;;;;;;;;;;;;;;;
;;  enemy categories
CATEGORY_UNKNOWN     = $01
CATEGORY_DRAGON      = $02
CATEGORY_GIANT       = $04
CATEGORY_UNDEAD      = $08
CATEGORY_WERE        = $10
CATEGORY_WATER       = $20
CATEGORY_MAGE        = $40
CATEGORY_REGEN       = $80

;; and for single category listing:
TYPE_UNKNOWN     = $01
TYPE_DRAGON      = $02
TYPE_GIANT       = $03
TYPE_UNDEAD      = $04
TYPE_WERE        = $05
TYPE_WATER       = $06
TYPE_MAGE        = $07
TYPE_REGEN       = $08

;;;;;;;;;;;;;;;;;;
;;  enemy stats in ROM
ENROMSTAT_EXP        = $00       ; 2 bytes
ENROMSTAT_GP         = $02       ; 2 bytes
ENROMSTAT_HPMAX      = $04       ; 2 bytes
ENROMSTAT_MORALE     = $06
ENROMSTAT_AI         = $07
ENROMSTAT_EVADE      = $08
ENROMSTAT_ABSORB     = $09
ENROMSTAT_NUMHITS    = $0A
ENROMSTAT_HITRATE    = $0B
ENROMSTAT_DAMAGE     = $0C
ENROMSTAT_CRITRATE   = $0D
ENROMSTAT_SPECIAL    = $0E
ENROMSTAT_ATTACKAIL  = $0F
ENROMSTAT_CATEGORY   = $10
ENROMSTAT_MAGDEF     = $11
ENROMSTAT_ELEMWEAK   = $12
ENROMSTAT_ELEMRESIST = $13
ENROMSTAT_ELEMATTACK = $14
ENROMSTAT_SPEED      = $15
ENROMSTAT_LEVEL      = $16 
ENROMSTAT_ITEM       = $17
ENROMSTAT_BLANK      = $18

;;;;;;;;;;;;;;;;;;;
;;  magic data in ROM
MAGDATA_HITRATE      = $00
MAGDATA_EFFECTIVITY  = $01
MAGDATA_ELEMENT      = $02
MAGDATA_TARGET       = $03   ; (01 = All enemies, 02 = One Enemy, 04 = Spell Caster, 08 = Whole Party, 10 = One party member)
MAGDATA_EFFECT       = $04
MAGDATA_GRAPHIC      = $05
MAGDATA_PALETTE      = $06
MAGDATA_UNUSED       = $07


;;;;;;;;;;;;;;;;;;
;;  banks to swap to for different things
;;

BANK_BATTLECHR    = $00

BANK_BATTLEBG     = $03

BANK_MINIMAP      = $04
BANK_MENUCHR      = $04
BANK_BTLCHR       = $04

BANK_TILESETCHR   = $06

BANK_ORBCHR       = $09
BANK_MINIGAME     = $09
BANK_BRIDGESCENE  = $09
BANK_ENDINGSCENE  = $09

BANK_BTLMESSAGES  = $0A
BANK_ITEMS        = $0A 
BANK_ITEMPRICES   = $0A 
BANK_ENEMYNAMES   = $0A

BANK_BATTLE       = $0B
BANK_BTLDATA      = $0B
BANK_DOMAINS      = $0B
BANK_BRIDGEGFX    = $0B
BANK_EPILOGUEGFX  = $0B

BANK_BTLPALETTES  = $0C

BANK_MUSIC        = $0D

BANK_MENUS        = $0E

BANK_PARTYGEN     = $0F
BANK_TITLE        = $0F
BANK_INTRO        = $0F
BANK_Z            = $0F
BANK_ENEMYSTATS   = $0F
BANK_EQUIPSTATS   = $0F

BANK_DIALOGUE     = $10 
BANK_TALKTOOBJ    = $10

BANK_DIALOGUE_2   = $11 

BANK_MAPMANPAL    = $12
BANK_OWINFO       = $12
BANK_SMINFO       = $12
BANK_STARTUPINFO  = $12

BANK_BACKDROPPAL  = $13
BANK_STARTINGSTATS= $13
BANK_OBJINFO      = $13
BANK_TREASURE     = $13
BANK_TELEPORTINFO = $13

BANK_MAPCHR       = $14

BANK_OWMAP        = $1E


;;;;;;;;;;;;;;;;;;
;;  Special Standard Map tile IDs
;;

MAPTILE_CLOSEDDOOR = $36    ; tiles used for door graphics (for runtime changes to the map -- when you 
MAPTILE_OPENDOOR   = $37    ;   enter/exit rooms)
MAPTILE_LOCKEDDOOR = $3B

;;;;;;;;;;;;;;;;;;
;;  game flag bits

GMFLG_OBJVISIBLE   = %00000001    ; must be low bit (often shifted out)
GMFLG_EVENT        = %00000010    ; must be bit 1 (shifted out)
GMFLG_TCOPEN       = %00000100
GMFLG_TCOPEN_2     = %00001000
GMFLG_OBJVISIBLE_2 = %10000000    ; must be high bit (shifted out the other way)

;;;;;;;;;;;;;;;;;;
;;  battle formation IDs

BTL_VAMPIRE        = $7C
BTL_ASTOS          = $7D
BTL_BIKKE          = $7A
BTL_GARLAND        = $79

;;;;;;;;;;;;;;;;;;
;;  battle message IDs  (1-based)

BTLMSG_HPUP             = $01 ; HP up!
BTLMSG_ARMORUP          = $02 ; Armor up
BTLMSG_EASYTODODGE      = $03 ; Easy to dodge
BTLMSG_ASLEEP           = $04 ; Asleep
BTLMSG_EASYTOHIT        = $05 ; Easy to hit
BTLMSG_SIGHTRECOVERED   = $06 ; Sight recovered
BTLMSG_SILENCED         = $07 ; Silenced
BTLMSG_DEFENDLIGHTNING  = $08 ; Defend lightning
BTLMSG_DARKNESS         = $09 ; Darkness
BTLMSG_WEAPONSSTRONGER  = $0A ; Weapons stronger
BTLMSG_LOSTINTELLIGENCE = $0B ; Lost intelligence
BTLMSG_DEFENDFIRE       = $0C ; Defend fire
BTLMSG_ATTACKHALTED     = $0D ; Attack halted
BTLMSG_NEUTRALIZED      = $0E ; Poison neutralized
BTLMSG_BECAMETERRIFIED  = $0F ; Became terrified
BTLMSG_DEFENDCOLD       = $10 ; Defend cold
BTLMSG_BREAKSILENCE     = $11 ; Break the silence
BTLMSG_QUICKSHOT        = $12 ; Quick shot
BTLMSG_CONFUSED         = $13 ; Confused
BTLMSG_POISONED         = $14 ; Poisoned
BTLMSG_ERASED           = $15 ; Erased
BTLMSG_FELLINTOCRACK	= $16 ; Fell into crack
BTLMSG_PARALYZED        = $17 ; Paralyzed
BTLMSG_HPMAX_1          = $18 ; HP max!
BTLMSG_DEFENDMAGIC      = $19 ; Defend magic
BTLMSG_BROKENTOPIECES   = $1A ; Broken into pieces
BTLMSG_WEAPONENCHANTED  = $1B ; Weapon became enchanted
BTLMSG_DEFENDALL        = $1C ; Defend all
BTLMSG_DEFENSELESS      = $1D ; Defenseless
BTLMSG_TIMESTOPPED      = $1E ; Time stopped
BTLMSG_EXILETO4TH       = $1F ; Exile to 4th dimension
BTLMSG_SLAIN            = $20 ; Slain..
BTLMSG_INEFFECTIVE      = $21 ; Ineffective
BTLMSG_STRIKEFIRST      = $22 ; Chance to strike first
BTLMSG_SURPRISED        = $23 ; Monsters strike first
BTLMSG_CANTRUN          = $24 ; Can't run
BTLMSG_RUNAWAY          = $25 ; Run away
BTLMSG_CLOSECALL        = $26 ; Close call....
BTLMSG_WOKEUP           = $27 ; Woke up
BTLMSG_SLEEPING         = $28 ; Sleeping
BTLMSG_CURED            = $29 ; Cured!
BTLMSG_PARALYZEDCURED   = $2A ; Paralysis wore off
BTLMSG_HITS             = $2B ; _Hits!
BTLMSG_CRITICALHIT      = $2C ; Critical hit!!
BTLMSG_MAGICBLOCKED     = $2D ; Magic blocked
BTLMSG_DMG              = $2E ; DMG
BTLMSG_STOPPED          = $2F ; Stopped
BTLMSG_LEVUP            = $30 ; Lev. up!
BTLMSG_HPMAX_2          = $31 ; HP max
BTLMSG_PTS              = $32 ; _pts.
BTLMSG_STR              = $33 ; Str.
BTLMSG_AGI              = $34 ; Agi.
BTLMSG_INT              = $35 ; Int.
BTLMSG_VIT              = $36 ; Vit.
BTLMSG_LUCK             = $37 ; Luck
BTLMSG_UP               = $38 ;  up
BTLMSG_ETHER            = $39 ; MP restored! - JIGS added
BTLMSG_ELIXIR           = $3A ; HP and MP restored! - JIGS added
BTLMSG_DOWN             = $3B ; down
BTLMSG_PERISHED         = $3C ; perished
BTLMSG_MONSTERS         = $3D ; Monsters_
BTLMSG_PARTY            = $3E ; _party_
BTLMSG_TERMINATED       = $3F ; Terminated
BTLMSG_MISSED           = $40 ; Missed! 
BTLMSG_FOURSPACES       = $41 ; ____
BTLMSG_STONETEXT        = $42 ; {E6}{E7}{E8}{E9} (Stone) ;; JIGS - the squished text doesn't exist anymore...
BTLMSG_POISONTEXT       = $43 ; {E2}{E3}{E4}{E5} (Poison) ;; JIGS - the squished text doesn't exist anymore...
BTLMSG_DARK             = $44 ; Dark
BTLMSG_STUN             = $45 ; Stun
BTLMSG_SLEEPTEXT        = $46 ; A {EA}{C8}{C9} (sl eep) ;; JIGS - the squished text doesn't exist anymore...
BTLMSG_MUTE             = $47 ; Mute
BTLMSG_HP               = $48 ; HP__
BTLMSG_EXPUP            = $49 ; Exp earned..
BTLMSG_INEFFECTIVENOW   = $4A ; Ineffective now
BTLMSG_SILENCE          = $4B ; Silence
BTLMSG_GOMAD            = $4C ; Go mad
BTLMSG_POISONSMOKE      = $4D ; Poison smoke
BTLMSG_NOTHINGHAPPENS   = $4E ; Nothing happens
; JIGS - adding these:
BTLMSG_LIFE             = $4F ; Revived from the brink!
BTLMSG_REGEN            = $50 ; Regenerated HP 
BTLMSG_CRITUP           = $51 ; 
BTLMSG_HIDING           = $52 ; Slipped into hiding... 
BTLMSG_CANTHIDE         = $53 ; Can't hide now!
BTLMSG_ALREADYHIDING    = $54 ; Already hidden!
BTLMSG_EYEDROPS         = $55 ; Sight restored!
BTLMSG_WAKEUPBELL       = $56 ; The bell rings loudly...
BTLMSG_STEALING         = $57 ; Stealing...
BTLMSG_STOLE            = $58 ; Stole_
BTLMSG_SCROLL           = $59 ; _scroll
BTLMSG_REGENERATING     = $5A ; Begins healing slowly
BTLMSG_OUTOFITEM        = $5B ; Haven't got any more!
BTLMSG_CANNOTDEFEND     = $5C ; Cannot cover yourself!
BTLMSG_CONFUSECURED     = $5D ; Came to their senses
BTLMSG_GOLDFOUND        = $5E ; Gold found..
BTLMSG_NOTHING          = $5F ; Nothing
BTLMSG_SCANNING         = $60 ; Scanning...
BTLMSG_ATTACKBLOCKED    = $61 ; _covered the attack!
BTLMSG_COUNTER          = $62 ; Counter attack!

;;;;;;;;;;;;;;;;;;
;;  Alternative battle message IDs
;;    For whatever reason, the game has a routine where it runs an ID through a LUT
;;  to get a different ID.  Don't ask me why.
;;
;;  These are zero-based and are used exclusively with ShowAltBattleMessage in bank C.
;;  See that routine for more info.
ALTBTLMSG_RUNAWAY           = $00
ALTBTLMSG_PARALYZED_B       = $01
ALTBTLMSG_SLEEPING          = $02
ALTBTLMSG_SILENCED_1        = $03
ALTBTLMSG_INEFFECTIVE       = $04
ALTBTLMSG_CONFUSED          = $05       ; ALTBTLMSG_CONFUSED through ALTBTLMSG_BROKENTOPIECES
ALTBTLMSG_SILENCED_2        = $06       ;   must be in sequential order, as they are used programmatically.
ALTBTLMSG_ASLEEP            = $07       ;   They are the messages printed when an ailment is inflicted.
ALTBTLMSG_PARALYZED_A       = $08
ALTBTLMSG_DARKNESS          = $09
ALTBTLMSG_POISONED          = $0A
ALTBTLMSG_BROKENTOPIECES    = $0B
ALTBTLMSG_TERMINATED        = $0C
ALTBTLMSG_CURED_1           = $0D       ; Same deal as ALTBTLMSG_CONFUSED -- these are printed when
ALTBTLMSG_BREAKSILENCE      = $0E       ;   their matching ailment is cured
ALTBTLMSG_WOKEUP            = $0F
ALTBTLMSG_CURED_2           = $10
ALTBTLMSG_SIGHTRECOVERED    = $11
ALTBTLMSG_NEUTRALIZED       = $12
ALTBTLMSG_INEFFECTIVENOW    = $13       ; <- message for curing Stone - you cannot cure stone in battle
ALTBTLMSG_SLAIN             = $14
ALTBTLMSG_NOTHINGHAPPENS    = $15

;;;;;;;;;;;;;;;;;;
;;  normal teleport IDs

NORMTELE_SAVEDPRINCESS = $3F

;;;;;;;;;;;;;;;;;;
;;  misc crap

WPNID_XCALBUR      = $26 ; originally 27, but this comes pre-DEC

;;;;;;;;;;;;;;;;;;
;;  ailments
AIL_DEAD            = $01
AIL_STONE           = $02
AIL_POISON          = $04
AIL_DARK            = $08
AIL_STUN            = $10
AIL_SLEEP           = $20
AIL_MUTE            = $40
AIL_CONF            = $80


;;;;;;;;;;;;;;;;;;
;;  battle states ; good ailments!
STATE_REGENLOW     = $10
STATE_REGENMIDDLE  = $20
STATE_REGENHIGH    = $40
STATE_REGENALL     = $70 ; all the above
STATE_REFLECT      = $80 
STATE_REGENERATING = $07
;; low 3 bits are used for how many turns left to regenerate

;;;;;;;;;;;;;;;;;;
;;  map object IDs
;;

OBJID_GARLAND      = $02   ; Garland (the first one, not ToFR)
OBJID_PRINCESS_1   = $03   ; kidnapped princess (in ToF)
OBJID_BIKKE        = $04   ; Bikke the Pirate
OBJID_ELFPRINCE    = $06   ; Elf Prince (sleeping man-beauty)
OBJID_ASTOS        = $07   ; Astos -- the dark king!  omg scarey
OBJID_NERRICK      = $08   ; Nerrick -- the dwarf working on the canal
OBJID_SMITH        = $09   ; Smith, the dwarven blacksmith (no, he's not Watts)
OBJID_MATOYA       = $0A
OBJID_UNNE         = $0B   ; you've never heard of him?
OBJID_VAMPIRE      = $0C   ; Earth Cave's Vampire
OBJID_SARDA        = $0D
OBJID_BAHAMUT      = $0E   ; Bahamut
OBJID_SUBENGINEER  = $10   ; Submarine Engineer (blocking Sea Shrine in Onrac)
OBJID_PRINCESS_2   = $12   ; rescued princess (in Coneria Castle)
OBJID_FAIRY        = $13   ; fairy that appears from the bottle
OBJID_TITAN        = $14   ; Titan in Titan's Tunnel
OBJID_RODPLATE     = $16   ; plate that is removed with the Rod
OBJID_LUTEPLATE    = $17   ; plate that is removed with the Lute

OBJID_SKYWAR_FIRST = $3A                   ; start of the 5 sky warriors
OBJID_SKYWAR_LAST  = OBJID_SKYWAR_FIRST+4  ; last of the 5 sky warriors

OBJID_PIRATETERR_1 = $3F   ; townspeople that were terrorized by the
OBJID_PIRATETERR_2 = $40   ;   pirates... they don't become visible until after
OBJID_PIRATETERR_3 = $41   ;   you beat Bikke and claim the ship

OBJID_BAT          = $57   ; normal bat

OBJID_BLACKORB     = $CA

;;;;;;;;;;;;;;;;;;
;;  common dialogue IDs
;;

; table 2
DLGID_DONTBEGREEDY = $3A   ; from Smith if you have too many weapons

; table 1
DLGID_NOTHING        = $00   ; "Nothing Here"
DLGID_HIDDENTREASURE = $01   ; "Searching around, you find..."
DLGID_HPRESTORED     = $02
DLGID_MPRESTORED     = $03
DLGID_HPMPRESTORED   = $04
DLGID_REVIVED        = $05
DLGID_AILMENTSCURED  = $06
DLGID_TCGET          = $F0   ; "In this chest you find..."
DLGID_CANTCARRY      = $F1   ; "You can't carry anymore"
DLGID_EMPTYTC        = $F2   ; "this treasure chest is empty"


;;;;;;;;;;;;;;;;;;
;;  treasure item type ranges
TCITYPE_ITEMSTART  = $00
TCITYPE_WEPSTART   = TCITYPE_ITEMSTART+$1C
TCITYPE_ARMSTART   = TCITYPE_WEPSTART+$28
TCITYPE_GPSTART    = TCITYPE_ARMSTART+$28


;;;;;;;;;;;;;;;;;;
;;  standard map tile properties

;TP_SPEC_DOOR      = %00000010
;TP_SPEC_LOCKED    = %00000100
;TP_SPEC_CLOSEROOM = %00000110
;TP_SPEC_TREASURE  = %00001000
;TP_SPEC_BATTLE    = %00001010
;TP_SPEC_DAMAGE    = %00001100
;TP_SPEC_CROWN     = %00001110
;TP_SPEC_CUBE      = %00010000
;TP_SPEC_4ORBS     = %00010010
;TP_SPEC_USEROD    = %00010100
;TP_SPEC_USELUTE   = %00010110
;TP_SPEC_EARTHORB  = %00011000
;TP_SPEC_FIREORB   = %00011010
;TP_SPEC_WATERORB  = %00011100
;TP_SPEC_AIRORB    = %00011110
;TP_SPEC_MASK      = %00011110

;TP_TELE_EXIT      = %11000000   ; "exit" teleport (standard map to overworld map)
;TP_TELE_NORM      = %10000000   ; "normal" teleport (standard map to standard map)
;TP_TELE_WARP      = %01000000   ; "warp" teleport (go back to previous floor)
;TP_TELE_NONE      = 0

;TP_TELE_MASK      = %11000000

;TP_NOTEXT_MASK    = %11000010   ; if any of these bits set, "Nothing Here" is forced when you talk to tile

;TP_BATTLEMARKER   = %00100000
;TP_NOMOVE         = %00000001

TP_TELE_NONE       = $00
TP_TELE_WARP       = $01  ; "warp" teleport (go back to previous floor)
TP_TELE_NORM       = $02  ; "normal" teleport (standard map to standard map)
TP_TELE_EXIT       = $03  ; "exit" teleport (standard map to overworld map)
TP_SPEC_DOOR       = $04
TP_SPEC_LOCKED     = $05
TP_SPEC_CLOSEROOM  = $06
TP_SPEC_DAMAGE     = $07
TP_SPEC_BATTLE     = $08
TP_SPEC_USEKEYITEM = $09
TP_SPEC_USESAVE    = $0A
TP_SPEC_LIGHTORB   = $0B
TP_SPEC_4ORBS      = $0C
TP_SPEC_CUBE       = $0D
TP_SPEC_CROWN      = $0E
TP_SPEC_BRIDGEHORZ = $0F
TP_SPEC_BRIDGEVERT = $10
TP_SPEC_DEEPWATER  = $11
TP_SPEC_WATERACCESS = $12
;                     13
;                     14
;                     15
;                     16
;                     17
;                     18
TP_SPEC_TREASURE   = $19
TP_SPEC_TREASURE_2 = $1A
TP_SPEC_TREASURE_NOMOVE   = $99
TP_SPEC_TREASURE_2_NOMOVE = $9A
TP_SPEC_HP         = $1B
TP_SPEC_MP         = $1C
TP_SPEC_HPMP       = $1D
TP_SPEC_CUREDEATH  = $1E
TP_SPEC_CUREAIL    = $1F



TP_NOMOVE         = %10000000
TP_HASTEXT_MASK   = %01000000
TP_HIDESPRITE     = %00100000

TP_TELE_MASK      = %00000011
TP_SPEC_MASK      = %00011111
TP_BATTLEMARKER   = $FF

TP_TREASURE_OPEN  = $70

AIRORB_MAP        = $33         ; map ID that the orbs are found on
WATERORB_MAP      = $2A
FIREORB_MAP       = $24
EARTHORB_MAP      = $20

;;;;;;;;;;;;;;;;;;
;;  overworld map tile properties

OWTP_DOCKSHIP     = %00100000
OWTP_FOREST       = %00010000

OWTP_SPEC_CHIME   = %01000000
;OWTP_SPEC_CARAVAN = %10000000
OWTP_SPEC_SLOW    = %10000000
OWTP_SPEC_CARAVAN = %11101110
OWTP_SPEC_FLOATER = %11000000

OWTP_SPEC_MASK    = %11000000

;;;;;;;;;;;;;;;;;;
;;  "Poses" for the characters in battle
CHARPOSE_STAND      = $00
CHARPOSE_WALK       = $04
CHARPOSE_ATTACK_B   = $08
CHARPOSE_ATTACK_F   = $0C
CHARPOSE_CHEER      = $10
CHARPOSE_CHEER_2    = $14
CHARPOSE_CROUCH     = $18
CHARPOSE_CROUCH_2   = $1C


;;;;;;;;;;;;;;;;;;
;;  classes

CLS_FT  = $00
CLS_TH  = $01
CLS_BB  = $02
CLS_RM  = $03
CLS_WM  = $04
CLS_BM  = $05
CLS_KN  = $06
CLS_NJ  = $07
CLS_MA  = $08
CLS_RW  = $09
CLS_WW  = $0A
CLS_BW  = $0B


;;;;;;;;;;;;;;;;;
;; Item offsets

ITEM_KEYITEMSTART = $10
ITEM_MAGICSTART   = $30
CHESTGOLDSTART    = $70
ITEM_CLASSSTART   = $C0

WEAPONSTART       = $0
ARMORSTART        = $40


;;;;;;;;;;;;;;;;;;
;;  Items

HEAL           = $01
X_HEAL         = $02
ETHER          = $03
ELIXIR         = $04
PURE           = $05
SOFT           = $06
PHOENIXDOWN    = $07
TENT           = $08
CABIN          = $09
HOUSE          = $0A
EYEDROPS       = $0B
SMOKEBOMB      = $0C
WAKEUPBELL     = $0D

SMOKEBOMB_EFFECT  = $32 ; 50 steps
BTL_HEAL_POTENCY  = $10 ; 16
BTL_XHEAL_POTENCY = $60 ; 96
HEAL_POTENCY      = $1E ; 30
XHEAL_POTENCY     = $B4 ; 180

LUTE           = $10
CROWN          = $11
CRYSTAL        = $12 ; vanishes on use
HERB           = $13 ; vanishes on use
KEY            = $14
TNT            = $15 ; vanishes on use
ADAMANT        = $16 ; vanishes on use
SLAB           = $17
RUBY           = $18 ; vanishes on use
ROD            = $19
FLOATER        = $1A
CHIME          = $1B
TAIL           = $1C
CUBE           = $1D
BOTTLE         = $1E ; vanishes on use
OXYALE         = $1F
CANOE          = $20
LEWDS          = $21
BOTTLE_ALT     = $2A ; for shops
LEWDS_ALT      = $2B

KEYITEM_MAX    = $12 ; 18 key items

FIREORB        = $2C
WATERORB       = $2D
AIRORB         = $2E
EARTHORB       = $2F


;;;;;;;;;;;;;;;;;;
;;  weapons and armor

WEP1 = $00   ; Wooden Nunchuck
WEP2 = $01   ; Small Knife
WEP3 = $02   ; Wooden Staff
WEP4 = $03   ; Rapier
WEP5 = $04   ; Iron Hammer
WEP6 = $05   ; Short Sword
WEP7 = $06   ; Hand Axe
WEP8 = $07   ; Scimitar
WEP9 = $08   ; Iron Nunchucks
WEP10 = $09  ; Large Knife
WEP11 = $0A  ; Iron Staff
WEP12 = $0B  ; Sabre
WEP13 = $0C  ; Long Sword
WEP14 = $0D  ; Great Axe
WEP15 = $0E  ; Falchion
WEP16 = $0F  ; Silver Knife
WEP17 = $10  ; Silver Sword
WEP18 = $11  ; Silver Hammer
WEP19 = $12  ; Silver Axe
WEP20 = $13  ; Flame Sword
WEP21 = $14  ; Ice Sword
WEP22 = $15  ; Dragon Sword
WEP23 = $16  ; Giant Sword
WEP24 = $17  ; Sun Sword
WEP25 = $18  ; Coral Sword
WEP26 = $19  ; Were Sword
WEP27 = $1A  ; Rune Sword
WEP28 = $1B  ; Power Staff
WEP29 = $1C  ; Light Axe
WEP30 = $1D  ; Heal Staff
WEP31 = $1E  ; Mage Staff
WEP32 = $1F  ; Defense Sword
WEP33 = $20  ; Wizard Staff
WEP34 = $21  ; Vorpal Sword
WEP35 = $22  ; CatClaw
WEP36 = $23  ; Thor Hammer
WEP37 = $24  ; Bane Sword
WEP38 = $25  ; Katana
WEP39 = $26  ; Excalibur
WEP40 = $27  ; Masamune
WEP41 = $28  ; Chicken Knife
WEP42 = $29  ; Brave Blade 
WEP43 = $2A
WEP44 = $2B
WEP45 = $2C
WEP46 = $2D                       
WEP47 = $2E
WEP48 = $2F
WEP49 = $30
WEP50 = $31
WEP51 = $32
WEP52 = $33
WEP53 = $34
WEP54 = $35
WEP55 = $36
WEP56 = $37
WEP57 = $38
WEP58 = $39
WEP59 = $3A
WEP60 = $3B
WEP61 = $3C
WEP62 = $3D
WEP63 = $3E
WEP64 = $3F
CHICKEN_KNIFE = WEP41
BRAVE_BLADE = WEP42

ARM1 = $40   ; Cloth T
ARM2 = $41   ; Wooden Armor
ARM3 = $42   ; Chain Armor
ARM4 = $43   ; Iron Armor
ARM5 = $44   ; Steel Armor
ARM6 = $45   ; Silver Armor
ARM7 = $46   ; Flame Armor
ARM8 = $47   ; Ice Armor
ARM9 = $48   ; Opal Armor
ARM10 = $49  ; Dragon Armor
ARM11 = $4A  ; Copper Q
ARM12 = $4B  ; Silver Q
ARM13 = $4C  ; Gold Q
ARM14 = $4D  ; Opal Q
ARM15 = $4E  ; White T
ARM16 = $4F  ; Black T
ARM17 = $50  ; Wooden Shield
ARM18 = $51  ; Iron Shield
ARM19 = $52  ; Silver Shield
ARM20 = $53  ; Flame Shield
ARM21 = $54  ; Ice Shield
ARM22 = $55  ; Opal Shield
ARM23 = $56  ; Aegis Shield
ARM24 = $57  ; Buckler
ARM25 = $58  ; Protect Cape
ARM26 = $59  ; Cap
ARM27 = $5A  ; Wooden Helm
ARM28 = $5B  ; Iron Helm
ARM29 = $5C  ; Silver Helm
ARM30 = $5D  ; Opal Helm
ARM31 = $5E  ; Heal Helm
ARM32 = $5F  ; Ribbon
ARM33 = $60  ; Gloves
ARM34 = $61  ; Copper Gauntlet
ARM35 = $62  ; Iron Gauntlet
ARM36 = $63  ; Silver Gauntlet
ARM37 = $64  ; Zeus Gauntlet
ARM38 = $65  ; Power Gauntlet
ARM39 = $66  ; Opal Gauntlet
ARM40 = $67  ; Protect Ring
ARM41 = $68  
ARM42 = $69  
ARM43 = $6A  
ARM44 = $6B  
ARM45 = $6C  
ARM46 = $6D  
ARM47 = $6E  
ARM48 = $6F  
ARM49 = $70  
ARM50 = $71  
ARM51 = $72  
ARM52 = $73  
ARM53 = $74  
ARM54 = $75  
ARM55 = $76  
ARM56 = $77  
ARM57 = $78  
ARM58 = $79  
ARM59 = $7A  
ARM60 = $7B  
ARM61 = $7C  
ARM62 = $7D  
ARM63 = $7E  
ARM64 = $7F  


;;;;;;;;;;;;;;;;;;
;; gold in chests

GOLD1  = $70 ; 10 
GOLD2  = $71 ; 20 
GOLD3  = $72 ; 25 
GOLD4  = $73 ; 30 
GOLD5  = $74 ; 55 
GOLD6  = $75 ; 70 
GOLD7  = $76 ; 85 
GOLD8  = $77 ; 110 
GOLD9  = $78 ; 135 
GOLD10 = $79 ; 155 
GOLD11 = $7A ; 160 
GOLD12 = $7B ; 180 
GOLD13 = $7C ; 240 
GOLD14 = $7D ; 255 
GOLD15 = $7E ; 260 
GOLD16 = $7F ; 295 
GOLD17 = $80 ; 300 
GOLD18 = $81 ; 315 
GOLD19 = $82 ; 330 
GOLD20 = $83 ; 350 
GOLD21 = $84 ; 385 
GOLD22 = $85 ; 400 
GOLD23 = $86 ; 450 
GOLD24 = $87 ; 500 
GOLD25 = $88 ; 530 
GOLD26 = $89 ; 575 
GOLD27 = $8A ; 620 
GOLD28 = $8B ; 680 
GOLD29 = $8C ; 750 
GOLD30 = $8D ; 795 
GOLD31 = $8E ; 880 
GOLD32 = $8F ; 1020 
GOLD33 = $90 ; 1250 
GOLD34 = $91 ; 1455 
GOLD35 = $92 ; 1520 
GOLD36 = $93 ; 1760 
GOLD37 = $94 ; 1975 
GOLD38 = $95 ; 2000 
GOLD39 = $96 ; 2750 
GOLD40 = $97 ; 3400 
GOLD41 = $98 ; 4150 
GOLD42 = $99 ; 5000 
GOLD43 = $9A ; 5450 
GOLD44 = $9B ; 6400 
GOLD45 = $9C ; 6720 
GOLD46 = $9D ; 7340 
GOLD47 = $9E ; 7690 
GOLD48 = $9F ; 7900 
GOLD49 = $A0 ; 8135 
GOLD50 = $A1 ; 9000 
GOLD51 = $A2 ; 9300 
GOLD52 = $A3 ; 9500 
GOLD53 = $A4 ; 9900 
GOLD54 = $A5 ; 10000
GOLD55 = $A6 ; 12350
GOLD56 = $A7 ; 13000
GOLD57 = $A8 ; 13450
GOLD58 = $A9 ; 14050
GOLD59 = $AA ; 14720
GOLD60 = $AB ; 15000
GOLD61 = $AC ; 17490
GOLD62 = $AD ; 18010
GOLD63 = $AE ; 19990
GOLD64 = $AF ; 20000
GOLD65 = $B0 ; 20010
GOLD66 = $B1 ; 26000
GOLD67 = $B2 ; 45000
GOLD68 = $B3 ; 65000
GOLD69 = $B4 ; 
GOLD70 = $B5 ; 
GOLD71 = $B6 ; 
GOLD72 = $B7 ; 
GOLD73 = $B8 ; 
GOLD74 = $B9 ; 
GOLD75 = $BA ; 
GOLD76 = $BB ; 
GOLD77 = $BC ; 
GOLD78 = $BD ; 
GOLD79 = $BE ; 
GOLD80 = $BF ; 



;;;;;;;;;;;;;;;;;;
;;  magic spells

MG_START = $30
  MG_CURE = MG_START + $00
  MG_HARM = MG_START + $01
  MG_FOG  = MG_START + $02
  MG_RUSE = MG_START + $03
  MG_FIRE = MG_START + $04
  MG_SLEP = MG_START + $05
  MG_LOCK = MG_START + $06
  MG_LIT  = MG_START + $07
  MG_LAMP = MG_START + $08
  MG_MUTE = MG_START + $09
  MG_ALIT = MG_START + $0A
  MG_INVS = MG_START + $0B
  MG_ICE  = MG_START + $0C
  MG_DARK = MG_START + $0D
  MG_TMPR = MG_START + $0E
  MG_SLOW = MG_START + $0F
  MG_CUR2 = MG_START + $10
  MG_HRM2 = MG_START + $11
  MG_AFIR = MG_START + $12
  MG_HEAL = MG_START + $13
  MG_FIR2 = MG_START + $14
  MG_HOLD = MG_START + $15
  MG_LIT2 = MG_START + $16
  MG_LOK2 = MG_START + $17
  MG_PURE = MG_START + $18
  MG_FEAR = MG_START + $19
  MG_AICE = MG_START + $1A
  MG_AMUT = MG_START + $1B
  MG_SLP2 = MG_START + $1C
  MG_FAST = MG_START + $1D
  MG_CONF = MG_START + $1E
  MG_ICE2 = MG_START + $1F
  MG_CUR3 = MG_START + $20
  MG_LIFE = MG_START + $21
  MG_HRM3 = MG_START + $22
  MG_HEL2 = MG_START + $23
  MG_FIR3 = MG_START + $24
  MG_BANE = MG_START + $25
  MG_WARP = MG_START + $26
  MG_SLO2 = MG_START + $27
  MG_SOFT = MG_START + $28
  MG_EXIT = MG_START + $29
  MG_FOG2 = MG_START + $2A
  MG_INV2 = MG_START + $2B
  MG_LIT3 = MG_START + $2C
  MG_RUB  = MG_START + $2D
  MG_QAKE = MG_START + $2E
  MG_STUN = MG_START + $2F
  MG_CUR4 = MG_START + $30
  MG_HRM4 = MG_START + $31
  MG_ARUB = MG_START + $32
  MG_HEL3 = MG_START + $33
  MG_ICE3 = MG_START + $34
  MG_BRAK = MG_START + $35
  MG_SABR = MG_START + $36
  MG_BLND = MG_START + $37
  MG_LIF2 = MG_START + $38
  MG_FADE = MG_START + $39
  MG_WALL = MG_START + $3A
  MG_XFER = MG_START + $3B
  MG_NUKE = MG_START + $3C
  MG_STOP = MG_START + $3D
  MG_ZAP  = MG_START + $3E
  MG_XXXX = MG_START + $3F
BATTLESPELLS = MG_START + $40
BATTLESPELLS_START = BATTLESPELLS + $5C
  
  
;;;;;;;;;;;;;;;;;;
;;  Map IDs and Banks

MAP_00  = $00
MAP_01  = $01
MAP_02  = $02
MAP_03  = $03
MAP_04  = $04
MAP_05  = $05
MAP_06  = $06
MAP_07  = $07
MAP_08  = $08
MAP_09  = $09
MAP_0A  = $0A
MAP_0B  = $0B
MAP_0C  = $0C
MAP_0D  = $0D
MAP_0E  = $0E
MAP_0F  = $0F
MAP_10  = $10
MAP_11  = $11
MAP_12  = $12
MAP_13  = $13
MAP_14  = $14
MAP_15  = $15
MAP_16  = $16
MAP_17  = $17
MAP_18  = $18
MAP_19  = $19
MAP_1A  = $1A
MAP_1B  = $1B
MAP_1C  = $1C
MAP_1D  = $1D
MAP_1E  = $1E
MAP_1F  = $1F
MAP_20  = $20
MAP_21  = $21
MAP_22  = $22
MAP_23  = $23
MAP_24  = $24
MAP_25  = $25
MAP_26  = $26
MAP_27  = $27
MAP_28  = $28
MAP_29  = $29
MAP_2A  = $2A
MAP_2B  = $2B
MAP_2C  = $2C
MAP_2D  = $2D
MAP_2E  = $2E
MAP_2F  = $2F
MAP_30  = $30
MAP_31  = $31
MAP_32  = $32
MAP_33  = $33
MAP_34  = $34
MAP_35  = $35
MAP_36  = $36
MAP_37  = $37
MAP_38  = $38
MAP_39  = $39
MAP_3A  = $3A
MAP_3B  = $3B
MAP_3C  = $3C

MAP_BANKCHANGE_2 = MAP_18 ; first map in SM_Bank_2
MAP_BANKCHANGE_3 = MAP_2A ; first map in SM_Bank_3
  
SM_BANK_1 = $16
SM_BANK_2 = $17
SM_BANK_3 = $18
  
  
;; labels that couldn't be inserted in data


lut_MapObjCHR      = $A200   ; BANK_MAPCHR
;lut_OWPtrTbl       = $8000   ; BANK_OWMAP
lut_SMPtrTbl       = $8000   ; BANK_STANDARDMAPS
;lut_Domains        = $8000   ; BANK_DOMAINS -- MUST be on page boundary
lut_BatSprCHR      = $9000   ; BANK_BTLCHR -- page
lut_BatObjCHR      = $A800   ; BANK_BTLCHR -- page
;lut_DialoguePtrTbl = $8000   ; BANK_DIALOGUE


