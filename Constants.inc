
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


;;;;;;;;;;;;;;;;
;; Overworld Flags:

SHIP_VISIBLE        = %00000001
AIRSHIP_VISIBLE     = %00000010
OW2_VEHICLE_VISIBLE = %00001000
CANAL_VISIBLE       = %00010000
BRIDGE_VISIBLE      = %00100000 
BRIDGE_SCENE_NOTYET = %01000000
BRIDGE_SCENE_OVER   = %10000000

;;;;;;;;;;;;;;;;
;; Option Flags:

AUTO_TARGET     = %00000001
SFX_MUTED       = %00000010
EXP_GAIN_LOW    = %00000100
EXP_GAIN_HIGH   = %00001000
MONEY_GAIN_LOW  = %00010000
MONEY_GAIN_HIGH = %00100000
ENC_RATE_LOW    = %01000000
ENC_RATE_HIGH   = %10000000


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


ENEMYAI_MAGICSTART   = $02
ENEMYAI_SPECIALSTART = $0B


;;;;;;;;;;;;;;;;;;
;;  elements
ELEMENT_DARK      = $01
ELEMENT_HOLY      = $02
ELEMENT_WIND      = $04
ELEMENT_WATER     = $08
ELEMENT_FIRE      = $10
ELEMENT_ICE       = $20
ELEMENT_LIGHTNING = $40
ELEMENT_EARTH     = $80

;;;;;;;;;;;;;;;;;;
;;  ailments
AIL_DEAD            = $01
AIL_STOP            = $02
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

PRAY_FAILRATE      = $A0
;; A random roll between Spirit and $FF must beat this for Pray to work.
PRAY_COST          = $0A ; succeeding will use up 10 spirit
PRAY_FAILVALUE     = $0A ; failing will give 10 spirit


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
ENROMSTAT_STATRESIST = $07
ENROMSTAT_EVADE      = $08
ENROMSTAT_ABSORB     = $09
ENROMSTAT_NUMHITS    = $0A
ENROMSTAT_HITRATE    = $0B
ENROMSTAT_DAMAGE     = $0C
ENROMSTAT_CRITRATE   = $0D
ENROMSTAT_AILCHANCE  = $0E
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
MAGDATA_MESSAGE      = $07


;;;;;;;;;;;;;;;;;;
;;  banks to swap to for different things
;;

BANK_ENEMYCHR      = $00

BANK_BATTLEBG      = $03
BANK_ATTACKSPRITES = $03
BANK_MENUCHR       = $03
BANK_BACKDROPPAL   = $03

BANK_BATTLESPRITES = $04

BANK_OWMAPTILESET  = $05

BANK_MAPTILESETS   = $06

BANK_DOMAINS      = $08
BANK_BATTLETEXT   = $08
BANK_BTLDATA      = $08
BANK_BTLPALETTES  = $08

BANK_MINIGAME     = $09
BANK_BRIDGESCENE  = $09
BANK_ENDINGSCENE  = $09
BANK_BRIDGEGFX    = $09
BANK_EPILOGUEGFX  = $09

BANK_ITEMDESC     = $0A
BANK_BTLMESSAGES  = $0A
BANK_ITEMS        = $0A 
BANK_ITEMPRICES   = $0A 
BANK_ENEMYNAMES   = $0A
BANK_MENUSTRINGS  = $0A
BANK_TREASURE     = $0A

BANK_BATTLE       = $0B
BANK_BATTLESTATS  = $0B
BANK_ENEMYSTATS   = $0B

BANK_DOBATTLE     = $0C

BANK_MUSIC        = $0D
BANK_MAPMUSIC     = $0D

BANK_MENUS        = $0E

BANK_PARTYGEN     = $0F
BANK_TITLE        = $0F
BANK_INTRO        = $0F
BANK_Z            = $0F
BANK_EQUIPSTATS   = $0F
BANK_BATTLEMAGIC  = $0F 

BANK_DIALOGUE     = $10 
BANK_TALKTOOBJ    = $10
BANK_KEYITEMS     = $10

BANK_DIALOGUE_2   = $11 

BANK_MAPMANPAL    = $12
BANK_OWINFO       = $12
BANK_SMINFO       = $12
BANK_TELEPORTINFO = $12

BANK_MINIMAP      = $13
BANK_MAPSPRITES   = $13

BANK_NPCSPRITES   = $14
BANK_OBJINFO      = $14


BANK_MAPS         = $17 ; + 18, 19, 1A, 1B, 1C

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
;;  battle box IDs  (2-based?)
; 0 and 1 can't be used...
BOX_CONFIRM         = $02  
BOX_PLAYER          = $03
BOX_COMMAND         = $04
BOX_ENEMYROSTER     = $05
BOX_ETHER           = $06
BOX_SKILL           = $07
BOX_HPUPDATE        = $08 ; fairly important

BOX_ATTACKER        = $09
BOX_ATTACK          = $0A
BOX_DEFENDER        = $0B
BOX_DAMAGE          = $0C
BOX_MESSAGE         = $0D
BOX_MAGIC           = $0E
BOX_ITEM            = $0F
BOX_GEAR            = $10
BOX_SCAN            = $11

;;;;;;;;;;;;;;;;;
;; menu box IDs
MBOX_OPTION         = $00
MBOX_CHARACTERS     = $01
MBOX_STATUS_CHAR    = $02
MBOX_STATUS_OPTION  = $03 
MBOX_STATUS         = $04
MBOX_TITLE          = $05
MBOX_SUBMENU        = $06
MBOX_INV            = $07
MBOX_ITEMDESC       = $08
MBOX_HP             = $09
MBOX_MP             = $0A
MBOX_HPMP           = $0B
MBOX_EQUIPSTATS     = $0C
MBOX_MAGIC_L        = $0D
MBOX_MAGIC_R        = $0E

SHOPBOX_SHOPKEEP    = $0F
SHOPBOX_TITLE       = $10
SHOPBOX_INV         = $11
SHOPBOX_COMMAND     = $12
SHOPBOX_GOLD        = $13




;;;;;;;;;;;;;;;;;;
;;  battle message IDs  (1-based)

BTLMSG_HPUP             = $00 ; HP up!
BTLMSG_ARMORUP          = $01 ; Armor up
BTLMSG_EASYTODODGE      = $02 ; Easy to dodge
BTLMSG_ASLEEP           = $03 ; Asleep
BTLMSG_EASYTOHIT        = $04 ; Easy to hit
BTLMSG_SIGHTRECOVERED   = $05 ; Sight recovered
BTLMSG_SILENCED         = $06 ; Silenced
BTLMSG_DEFENDLIGHTNING  = $07 ; Defend lightning
BTLMSG_DARKNESS         = $08 ; Darkness
BTLMSG_WEAPONSSTRONGER  = $09 ; Weapons stronger
BTLMSG_LOSTINTELLIGENCE = $0A ; Lost intelligence
BTLMSG_DEFENDFIRE       = $0B ; Defend fire
BTLMSG_ATTACKHALTED     = $0C ; Attack halted
BTLMSG_NEUTRALIZED      = $0D ; Poison neutralized
BTLMSG_BECAMETERRIFIED  = $0E ; Became terrified
BTLMSG_DEFENDCOLD       = $0F ; Defend cold
BTLMSG_BREAKSILENCE     = $10 ; Break the silence
BTLMSG_QUICKSHOT        = $11 ; Quick shot
BTLMSG_CONFUSED         = $12 ; Confused
BTLMSG_POISONED         = $13 ; Poisoned
BTLMSG_ERASED           = $14 ; Erased
BTLMSG_FELLINTOCRACK	= $15 ; Fell into crack
BTLMSG_PARALYZED        = $16 ; Paralyzed
BTLMSG_HPMAX_1          = $17 ; HP max!
BTLMSG_DEFENDMAGIC      = $18 ; Defend magic
BTLMSG_BROKENTOPIECES   = $19 ; Broken into pieces
BTLMSG_WEAPONENCHANTED  = $1A ; Weapon became enchanted
BTLMSG_DEFENDALL        = $1B ; Defend all
BTLMSG_DEFENSELESS      = $1C ; Defenseless
BTLMSG_TIMESTOPPED      = $1D ; Time stopped
BTLMSG_EXILETO4TH       = $1E ; Exile to 4th dimension
BTLMSG_SLAIN            = $1F ; Slain..
BTLMSG_INEFFECTIVE      = $20 ; Ineffective
BTLMSG_STRIKEFIRST      = $21 ; Chance to strike first
BTLMSG_SURPRISED        = $22 ; Monsters strike first
BTLMSG_CANTRUN          = $23 ; Can't run
BTLMSG_RUNAWAY          = $24 ; Run away
BTLMSG_CLOSECALL        = $25 ; Close call....
BTLMSG_WOKEUP           = $26 ; Woke up
BTLMSG_SLEEPING         = $27 ; Sleeping
BTLMSG_CURED            = $28 ; Cured!
BTLMSG_PARALYZEDCURED   = $29 ; Paralysis wore off
BTLMSG_HITS             = $2A ; _Hits!
BTLMSG_CRITICALHIT      = $2B ; Critical hit!!
BTLMSG_MAGICBLOCKED     = $2C ; Magic blocked
BTLMSG_DMG              = $2D ; DMG
BTLMSG_STOPPED          = $2E ; Stopped
BTLMSG_LEVUP            = $2F ; Lev. up!
BTLMSG_HPMAX_2          = $30 ; HP max
BTLMSG_PTS              = $31 ; _pts.
BTLMSG_STR              = $32 ; Str.
BTLMSG_AGI              = $33 ; Agi.
BTLMSG_INT              = $34 ; Int.
BTLMSG_VIT              = $35 ; Vit.
BTLMSG_LUCK             = $36 ; Luck
BTLMSG_UP               = $37 ;  up
BTLMSG_ETHER            = $38 ; MP restored! - JIGS added
BTLMSG_ELIXIR           = $39 ; HP and MP restored! - JIGS added
BTLMSG_DOWN             = $3A ; down
BTLMSG_PERISHED         = $3B ; perished
BTLMSG_MONSTERS         = $3C ; Monsters_
BTLMSG_PARTY            = $3D ; _party_
BTLMSG_TERMINATED       = $3E ; Terminated
BTLMSG_MISSED           = $3F ; Missed! 
BTLMSG_FOURSPACES       = $40 ; ____
BTLMSG_STONE            = $41 ; Petrified
BTLMSG_STONECURED       = $42 ; The stone shell breaks!
BTLMSG_DARK             = $43 ; Dark
BTLMSG_STUN             = $44 ; Stun
BTLMSG_NOESCAPE         = $45 ; No escape!
BTLMSG_MUTE             = $46 ; Mute
BTLMSG_HP               = $47 ; HP__
BTLMSG_EXPUP            = $48 ; Exp earned..
BTLMSG_INEFFECTIVENOW   = $49 ; Ineffective now
BTLMSG_SILENCE          = $4A ; Silence
BTLMSG_GOMAD            = $4B ; Go mad
BTLMSG_POISONSMOKE      = $4C ; Poison smoke
BTLMSG_NOTHINGHAPPENS   = $4D ; Nothing happens
BTLMSG_LIFE             = $4E ; Revived from the brink!
BTLMSG_REGEN            = $4F ; Regenerated HP 
BTLMSG_CRITUP           = $50 ; 
BTLMSG_HIDING           = $51 ; Slipped into hiding... 
BTLMSG_CANTHIDE         = $52 ; Can't hide now!
BTLMSG_ALREADYHIDING    = $53 ; Already hidden!
BTLMSG_TURN             = $54 ; __Round__
BTLMSG_ALARMCLOCK       = $55 ; The bell rings loudly...
BTLMSG_STEALING         = $56 ; Stealing...
BTLMSG_STOLE            = $57 ; Stole_
BTLMSG_SCROLL           = $58 ; _scroll
BTLMSG_REGENERATING     = $59 ; Begins healing slowly
BTLMSG_OUTOFITEM        = $5A ; Haven't got any more!
BTLMSG_CANNOTDEFEND     = $5B ; Cannot cover yourself!
BTLMSG_CONFUSECURED     = $5C ; Came to their senses
BTLMSG_GOLDFOUND        = $5D ; Gold found..
BTLMSG_NOTHING          = $5E ; Nothing
BTLMSG_SCANNING         = $5F ; Scanning...
BTLMSG_ATTACKBLOCKED    = $60 ; _covered the attack!
BTLMSG_COUNTER          = $61 ; Counter attack!
BTLMSG_PRAYING          = $62 ; Praying...
BTLMSG_FOCUSING         = $63 ; Focusing...
BTLMSG_TIMEFLOW         = $64 ; -- UNUSED
BTLMSG_ABSORBEDSPELL    = $65 ; Absorbed the spell!
BTLMSG_RUNICFAILED      = $66 ; Overwhelmed by_
BTLMSG_RUNIC            = $67 ; Runic
BTLMSG_NOWEAPON         = $68 ; No weapon equipped! 
BTLMSG_READY            = $69 ; Ready?
BTLMSG_CHARGE           = $6A ; Charge?!
BTLMSG_RUNAWAY_QUERY    = $6B ; Run away?
BTLMSG_YESNO            = $6C ; Yes    No
BTLMSG_YESNO_EMPH       = $6D ; Yes!   No!
BTLMSG_YESNO_UNSURE     = $6E ; Yes... No...


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
CHARPOSE_CROUCH_2   = $1C ; these are unused now

CHARPOSE_NORM       = $00
CHARPOSE_ALT        = $04

LOADCHARPOSE_STAND    = $00 
LOADCHARPOSE_ATTACK_1 = $03
LOADCHARPOSE_ATTACK_2 = $06
LOADCHARPOSE_CHEER    = $09
LOADCHARPOSE_CROUCH   = $0C
LOADCHARPOSE_DEAD     = $0F
LOADCHARPOSE_LEGS     = $12




;;;;;;;;;;;;;;;;;
;; Item offsets






;;;;;;;;;;;;;;;;;;
;;  weapons and armor

WEAPONSTART = $0
WEP1  = $00  ; Wooden Nunchuck
WEP2  = $01  ; Small Knife
WEP3  = $02  ; Wooden Staff
WEP4  = $03  ; Rapier
WEP5  = $04  ; Iron Hammer
WEP6  = $05  ; Short Sword
WEP7  = $06  ; Hand Axe
WEP8  = $07  ; Scimitar
WEP9  = $08  ; Iron Nunchucks
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

CHICKENKNIFE_DAMAGE = $FE
BRAVEBLADE_DAMAGE   = $FF ; basically control codes for battle stat prep
CKD = CHICKENKNIFE_DAMAGE
BBD = BRAVEBLADE_DAMAGE   ; shorthand, for data table alignment

WEAPON_HIT         = $00
WEAPON_DAMAGE      = $01
WEAPON_CRIT        = $02
WEAPON_AIL         = $03
WEAPON_AILPROC     = $04
WEAPON_ELEMENT     = $05
WEAPON_CATEGORY    = $06
WEAPON_GFX         = $07
WEAPON_PAL         = $08
WEAPON_TYPE_1      = $09
WEAPON_TYPE_2      = $0A
WEAPON_PERMISSIONS = $0B ; 0C, 0D, 0E - 4 bytes

ARMORSTART = $40
ARM1  = $40  ; Cloth T
ARM2  = $41  ; Wooden Armor
ARM3  = $42  ; Chain Armor
ARM4  = $43  ; Iron Armor
ARM5  = $44  ; Steel Armor
ARM6  = $45  ; Silver Armor
ARM7  = $46  ; Flame Armor
ARM8  = $47  ; Ice Armor
ARM9  = $48  ; Opal Armor
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

ARMOR_EVADE       = $00
ARMOR_DEF         = $01
ARMOR_MAGDEF      = $02
ARMOR_ELEMDEF     = $03
ARMOR_ELEMWEAK    = $04
ARMOR_STATDEF     = $05
ARMOR_HPBONUS     = $06
ARMOR_TYPE_1      = $07
ARMOR_TYPE_2      = $08
ARMOR_SLOT        = $09
ARMOR_PERMISSIONS = $0A ; 0B, 0C, 0D - 4 bytes



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
ALARMCLOCK     = $0D
SHOP_BOTTLE    = $0E
SHOP_LEWDS     = $0F

ITEM_KEYITEMSTART = $10
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
BOTTLE_ALT     = $2E ; for inventory description
LEWDS_ALT      = $2F ; for inventory description



;; for TalkToObject logic

FIREORB        = $0C
WATERORB       = $0D
AIRORB         = $0E
EARTHORB       = $0F

ITEM_SKILLSTART = $30

SKILL_RUSH     = $00
SKILL_STEAL    = $01
SKILL_3        = $02
SKILL_SCAN     = $03
SKILL_PRAY     = $04
SKILL_FOCUS    = $05
SKILL_7        = $06
SKILL_8        = $07
SKILL_9        = $08
SKILL_10       = $09
SKILL_11       = $0A
SKILL_12       = $0B
SKILL_13       = $0C
SKILL_14       = $0D
SKILL_15       = $0E
SKILL_16       = $0F
SKILL_COVER    = $10
SKILL_MUG      = $11
SKILL_PARRY    = $12
SKILL_RUNIC    = $13
SKILL_21       = $14
SKILL_22       = $15
SKILL_23       = $16
SKILL_24       = $17
SKILL_25       = $18
SKILL_26       = $19
SKILL_27       = $1A
SKILL_28       = $1B
SKILL_29       = $1C
SKILL_30       = $1D
SKILL_31       = $1E
SKILL_32       = $1F

ITEM_CLASSSTART = $50

CLASS_FT        = $00
CLASS_TH        = $01
CLASS_BB        = $02
CLASS_RM        = $03
CLASS_WM        = $04
CLASS_BM        = $05
CLASS_7         = $06
CLASS_8         = $07
CLASS_KN        = $08
CLASS_NJ        = $09
CLASS_MA        = $0A
CLASS_RW        = $0B
CLASS_WW        = $0C
CLASS_BW        = $0D
CLASS_15        = $0E
CLASS_16        = $0F
CLASS_17        = $10
CLASS_18        = $11
CLASS_19        = $12
CLASS_20        = $13
CLASS_21        = $14
CLASS_22        = $15
CLASS_23        = $16
CLASS_24        = $17
CLASS_25        = $18
CLASS_26        = $19
CLASS_27        = $1A
CLASS_28        = $1B
CLASS_29        = $1C
CLASS_30        = $1D
CLASS_31        = $1E
CLASS_32        = $1F


CLASS_START_MAX = $06 ; amount of starting classes to pick from
CLASS_PROMOTION = $10 ; classes lower than this are starting classes

;;;;;;;;;;;;;;;;;;
;; Perks + Crit Perks

;; Attacker Perks

UNARMED         = $01 ; Standard FF1 BlackBelt/Master stuff.
DUALWIELD       = $02 ; Allows using a second weapon in the left hand, with a hit% penalty
TWOHANDED       = $04 ; Boosts damage when not using a shield
STEALTHY        = $08 ; Hidden damage and crit rate, steal from shops
AIM             = $02 ; 100% Aim rate
RAGE            = $01 ; Doubles attack power, lowers hit %, cannot control character

;; Defender Perks

COUNTER         = $01 ; Random chance (based on speed + agility) to counter a physical attack
ENDURE          = $02 ; If over 1 HP, survive any physical hit that would kill them

;; Misc Perks

LIGHTSTEP       = $01 ; Ignore damage floor tiles
CHEMIST         = $02 ; Increases potion effects by x2, other items more potent
FIRSTSTRIKE     = $04 ; Increase first strike rate

; on critical hits ...  matches ailment: effect:
CRIT_DEATH      = $01 ; death          ; kills enemy on critical hit
CRIT_CRIT       = $02 ; stop           ; ups critical hit chance for self
CRIT_POISON     = $04 ; poison         ; poisons enemy
CRIT_DARK       = $08 ; dark           ; blinds enemy
CRIT_STUN       = $10 ; stun           ; stuns enemy
CRIT_STRENGTH   = $20 ; sleep          ; raises own damage stat
CRIT_SLOW       = $40 ; mute           ; slows the enemy (-1 hit multiplier)
CRIT_CONF       = $80 ; confuse        ; confuses enemy

;; Armor perks
ARMOR_REGEN      = $80 ; Restore 5% HP per turn
ARMOR_COUNTER    = $40 ; Random chance (based on speed + agility) to counter a physical attack
ARMOR_REFLECT    = $20 ; Gives Reflect status
ARMOR_SPEED      = $10 ; Boosts Speed stat
ARMOR_ABSORB_HP  = $08 ; Absorbs % of physical damage dealt as HP (if I can code that)
ARMOR_DODGE      = $04 ; 33% chance to dodge a physical hit
ARMOR_AIM        = $02 ; 100% Aim rate
ARMOR_RAGE       = $01 ; Doubles attack power, lowers hit %, cannot control character




; Armour Perks:
;*------- > Regenerate
;-*------ > Counter
;--*----- > Reflect
;---*---- > Speed Boost
;----*--- > Absorb HP
;-----*-- > Random Dodge
;------*- > Focus Aim
;-------* > Rage



;;;;;;;;;;;;;;;;;;
;;  magic spells

ITEM_MAGICSTART = $00
MG_START = $00
  MG_CURE = $01
  MG_HARM = $02
  MG_FOG  = $03
  MG_RUSE = $04
  MG_FIRE = $05
  MG_SLEP = $06
  MG_LOCK = $07
  MG_LIT  = $08
  MG_GR01 = $09
  MG_GR02 = $0A
  MG_GR03 = $0B
  MG_GR04 = $0C
  MG_TM01 = $0D
  MG_TM02 = $0E
  MG_TM03 = $0F
  MG_TM04 = $10
  MG_LAMP = $11
  MG_MUTE = $12
  MG_ALIT = $13
  MG_INVS = $14
  MG_ICE  = $15
  MG_DARK = $16
  MG_TMPR = $17
  MG_SLOW = $18
  MG_GR05 = $19
  MG_GR06 = $1A
  MG_GR07 = $1B
  MG_GR08 = $1C
  MG_TM05 = $1D
  MG_TM06 = $1E
  MG_TM07 = $1F
  MG_TM08 = $20
  MG_CUR2 = $21
  MG_HRM2 = $22
  MG_AFIR = $23
  MG_REGN = $24
  MG_FIR2 = $25
  MG_HOLD = $26
  MG_LIT2 = $27
  MG_LOK2 = $28
  MG_GR09 = $29
  MG_GR10 = $2A
  MG_GR11 = $2B
  MG_GR12 = $2C
  MG_TM09 = $2D
  MG_TM10 = $2E
  MG_TM11 = $2F
  MG_TM12 = $30
  MG_PURE = $31
  MG_FEAR = $32
  MG_AICE = $33
  MG_AMUT = $34
  MG_SLP2 = $35
  MG_FAST = $36
  MG_CONF = $37
  MG_ICE2 = $38
  MG_GR13 = $39
  MG_GR14 = $3A
  MG_GR15 = $3B
  MG_GR16 = $3C
  MG_TM13 = $3D
  MG_TM14 = $3E
  MG_TM15 = $3F
  MG_TM16 = $40
  MG_CUR3 = $41
  MG_LIFE = $42
  MG_HRM3 = $43
  MG_RGN2 = $44
  MG_FIR3 = $45
  MG_BANE = $46
  MG_WARP = $47
  MG_SLO2 = $48
  MG_GR17 = $49
  MG_GR18 = $4A
  MG_GR19 = $4B
  MG_GR20 = $4C
  MG_TM17 = $4D
  MG_TM18 = $4E
  MG_TM19 = $4F
  MG_TM20 = $50
  MG_SOFT = $51
  MG_EXIT = $52
  MG_FOG2 = $53
  MG_INV2 = $54
  MG_LIT3 = $55
  MG_RUB  = $56
  MG_QAKE = $57
  MG_STUN = $58
  MG_GR21 = $59
  MG_GR22 = $5A
  MG_GR23 = $5B
  MG_GR24 = $5C
  MG_TM21 = $5D
  MG_TM22 = $5E
  MG_TM23 = $5F
  MG_TM24 = $60
  MG_CUR4 = $61
  MG_HRM4 = $62
  MG_ARUB = $63
  MG_RGN3 = $64
  MG_ICE3 = $65
  MG_BRAK = $66
  MG_SABR = $67
  MG_BLND = $68
  MG_GR25 = $69
  MG_GR26 = $6A
  MG_GR27 = $6B
  MG_GR28 = $6C
  MG_TM25 = $6D
  MG_TM26 = $6E
  MG_TM27 = $6F
  MG_TM28 = $70
  MG_LIF2 = $71
  MG_FADE = $72
  MG_WALL = $73
  MG_XFER = $74
  MG_NUKE = $75
  MG_STOP = $76
  MG_ZAP  = $77
  MG_XXXX = $78
  MG_GR29 = $79
  MG_GR30 = $7A
  MG_GR31 = $7B
  MG_GR32 = $7C
  MG_TM29 = $7D
  MG_TM30 = $7E
  MG_TM31 = $7F
  MG_TM32 = $80

 BATTLESPELLS = $81
  MG_HEAL     = BATTLESPELLS + $0
  MG_HEL2     = BATTLESPELLS + $1
  MG_HEL3     = BATTLESPELLS + $2
  MG_PRAYER   = BATTLESPELLS + $3
  MG_REFLECT  = BATTLESPELLS + $4
  MG_REFLECT2 = BATTLESPELLS + $5
  MG_UNUSED1  = BATTLESPELLS + $6
  MG_UNUSED2  = BATTLESPELLS + $7
  MG_UNUSED3  = BATTLESPELLS + $8
  MG_UNUSED4  = BATTLESPELLS + $9
  MG_UNUSED5  = BATTLESPELLS + $A
  MG_UNUSED6  = BATTLESPELLS + $B
  MG_UNUSED7  = BATTLESPELLS + $C
  MG_UNUSED8  = BATTLESPELLS + $D
  MG_UNUSED9  = BATTLESPELLS + $E
  MG_COUNTER  = BATTLESPELLS + $F
  
BATTLESPELLS_START = BATTLESPELLS
BATTLESPELLS_END   = BATTLESPELLS_START + $10
ENEMY_ATTACK_START = BATTLESPELLS_END

;;;;;;;;;;;;;;;;;;
;; gold in chests

GOLD1  = $00 ; 10 
GOLD2  = $01 ; 20 
GOLD3  = $02 ; 25 
GOLD4  = $03 ; 30 
GOLD5  = $04 ; 55 
GOLD6  = $05 ; 70 
GOLD7  = $06 ; 85 
GOLD8  = $07 ; 110 
GOLD9  = $08 ; 135 
GOLD10 = $09 ; 155 
GOLD11 = $0A ; 160 
GOLD12 = $0B ; 180 
GOLD13 = $0C ; 240 
GOLD14 = $0D ; 255 
GOLD15 = $0E ; 260 
GOLD16 = $0F ; 295 
GOLD17 = $10 ; 300 
GOLD18 = $11 ; 315 
GOLD19 = $12 ; 330 
GOLD20 = $13 ; 350 
GOLD21 = $14 ; 385 
GOLD22 = $15 ; 400 
GOLD23 = $16 ; 450 
GOLD24 = $17 ; 500 
GOLD25 = $18 ; 530 
GOLD26 = $19 ; 575 
GOLD27 = $1A ; 620 
GOLD28 = $1B ; 680 
GOLD29 = $1C ; 750 
GOLD30 = $1D ; 795 
GOLD31 = $1E ; 880 
GOLD32 = $1F ; 1020 
GOLD33 = $20 ; 1250 
GOLD34 = $21 ; 1455 
GOLD35 = $22 ; 1520 
GOLD36 = $23 ; 1760 
GOLD37 = $24 ; 1975 
GOLD38 = $25 ; 2000 
GOLD39 = $26 ; 2750 
GOLD40 = $27 ; 3400 
GOLD41 = $28 ; 4150 
GOLD42 = $29 ; 5000 
GOLD43 = $2A ; 5450 
GOLD44 = $2B ; 6400 
GOLD45 = $2C ; 6720 
GOLD46 = $2D ; 7340 
GOLD47 = $2E ; 7690 
GOLD48 = $2F ; 7900 
GOLD49 = $30 ; 8135 
GOLD50 = $31 ; 9000 
GOLD51 = $32 ; 9300 
GOLD52 = $33 ; 9500 
GOLD53 = $34 ; 9900 
GOLD54 = $35 ; 10000
GOLD55 = $36 ; 12350
GOLD56 = $37 ; 13000
GOLD57 = $38 ; 13450
GOLD58 = $39 ; 14050
GOLD59 = $3A ; 14720
GOLD60 = $3B ; 15000
GOLD61 = $3C ; 17490
GOLD62 = $3D ; 18010
GOLD63 = $3E ; 19990
GOLD64 = $3F ; 20000
GOLD65 = $40 ; 20010
GOLD66 = $41 ; 26000
GOLD67 = $42 ; 45000
GOLD68 = $43 ; 65000
GOLD69 = $44 ; 
GOLD70 = $45 ; 
GOLD71 = $46 ; 
GOLD72 = $47 ; 
GOLD73 = $48 ; 
GOLD74 = $49 ; 
GOLD75 = $4A ; 
GOLD76 = $4B ; 
GOLD77 = $4C ; 
GOLD78 = $4D ; 
GOLD79 = $4E ; 
GOLD80 = $4F ; 

;;;;;;;;;;;;;;;;;;
;; Shop types

SHOP_WEAPON     = $00
SHOP_ARMOR      = $01
SHOP_WHITEMAGIC = $02
SHOP_BLACKMAGIC = $03
SHOP_GREENMAGIC = $04
SHOP_TIMEMAGIC  = $05
SHOP_SKILLS     = $06
SHOP_ITEM       = $07
SHOP_CLINIC     = $08
SHOP_INN        = $09
SHOP_CARAVAN    = $0A
SHOP_CARAVAN_ID = $7F ;AF

  
;;;;;;;;;;;;;;;;;;
;;  Map IDs and Banks

MAP_00  = $00 ; CONERIA
MAP_01  = $01 ; PRAVOKA
MAP_02  = $02 ; ELFLAND
MAP_03  = $03 ; MELMOND
MAP_04  = $04 ; CRESCENT_LAKE
MAP_05  = $05 ; GAIA
MAP_06  = $06 ; ONRAC
MAP_07  = $07 ; LEIFENf
MAP_08  = $08 ; Coneria_CASTLE_1F
MAP_09  = $09 ; ELFLAND_CASTLE
MAP_0A  = $0A ; NORTHWEST_CASTLE
MAP_0B  = $0B ; CASTLE_OF_ORDEALS_1F
MAP_0C  = $0C ; TEMPLE_OF_FIENDS_PRESENT
MAP_0D  = $0D ; EARTH_CAVE_B1
MAP_0E  = $0E ; GURGU_VOLCANO_B1
MAP_0F  = $0F ; ICE_CAVE_B1
MAP_10  = $10 ; CARDIA
MAP_11  = $11 ; BAHAMUTS_ROOM_B1
MAP_12  = $12 ; WATERFALL
MAP_13  = $13 ; DWARF_CAVE
MAP_14  = $14 ; MATOYAS_CAVE
MAP_15  = $15 ; SARDAS_CAVE
MAP_16  = $16 ; MARSH_CAVE_B1
MAP_17  = $17 ; MIRAGE_TOWER_1F
MAP_18  = $18 ; Coneria_CASTLE_2F
MAP_19  = $19 ; Castle_of_Ordeals_2F
MAP_1A  = $1A ; Castle_of_Ordeals_3F
MAP_1B  = $1B ; Marsh_Cave_B2       
MAP_1C  = $1C ; Marsh_Cave_B3       
MAP_1D  = $1D ; Earth_Cave_B2       
MAP_1E  = $1E ; Earth_Cave_B3       
MAP_1F  = $1F ; Earth_Cave_B4       
MAP_20  = $20 ; Earth_Cave_B5       
MAP_21  = $21 ; Gurgu_Volcano_B2    
MAP_22  = $22 ; Gurgu_Volcano_B3    
MAP_23  = $23 ; Gurgu_Volcano_B4    
MAP_24  = $24 ; Gurgu_Volcano_B5    
MAP_25  = $25 ; Ice_Cave_B2         
MAP_26  = $26 ; Ice_Cave_B3         
MAP_27  = $27 ; Bahamuts_Room_B2    
MAP_28  = $28 ; Mirage_Tower_2F     
MAP_29  = $29 ; Mirage_Tower_3F     
MAP_2A  = $2A ; Sea_Shrine_B5             
MAP_2B  = $2B ; Sea_Shrine_B4             
MAP_2C  = $2C ; Sea_Shrine_B3             
MAP_2D  = $2D ; Sea_Shrine_B2             
MAP_2E  = $2E ; Sea_Shrine_B1             
MAP_2F  = $2F ; Sky_Palace_1F             
MAP_30  = $30 ; Sky_Palace_2F             
MAP_31  = $31 ; Sky_Palace_3F             
MAP_32  = $32 ; Sky_Palace_4F             
MAP_33  = $33 ; Sky_Palace_5F             
MAP_34  = $34 ; Temple_of_Fiends_1F       
MAP_35  = $35 ; Temple_of_Fiends_2F       
MAP_36  = $36 ; Temple_of_Fiends_3F       
MAP_37  = $37 ; Temple_of_Fiends_4F_Earth 
MAP_38  = $38 ; Temple_of_Fiends_5F_Fire  
MAP_39  = $39 ; Temple_of_Fiends_6F_Water 
MAP_3A  = $3A ; Temple_of_Fiends_7F_Wind    
MAP_3B  = $3B ; Temple_of_Fiends_8F_Chaos   
MAP_3C  = $3C ; Titans_Tunnel               

  
  
  
;;;;;;;;;;;;;;;;;;;;;;
;;
;; MUSIC SCORE COMMANDS
;;
;;

;            ; for 112.5 bpm, 4/4:
; C    = $0x ; $x0 = 128, whole note   
; Cs   = $1x ; $x1 = 96, half + quarter
; D    = $2x ; $x2 = 64, half note
; Eb   = $3x ; $x3 = 48, quarter + eighth    
; E    = $4x ; $x4 = 32, quarter note
; F    = $5x ; $x5 = 24  eighth + sixteenth  
; Fs   = $6x ; $x6 = 16, eighth note   
; G    = $7x ; $x7 = 12   
; Ab   = $8x ; $x8 = 8,  sixteenth note
; A    = $9x ; $x9 = 6
; Bb   = $Ax ; $xA = 4
; B    = $Bx ; $xB = 2   
; REST = $Cx ; $xC = 3
;            ; $xD = 5 
;            ; $xE = 1 
;            ; $xF = 192, whole + half

LOOP_FOREVER = $D0
LOOP_1       = $D1 ; 1 = amount of times to loop
LOOP_2       = $D2
LOOP_3       = $D3
LOOP_4       = $D4
LOOP_5       = $D5
LOOP_6       = $D6
LOOP_7       = $D7
OCTAVE_1     = $D8 ; dark_blue
OCTAVE_2     = $D9 ; light blue
OCTAVE_3     = $DA ; white
OCTAVE_4     = $DB ; yellow
OCTAVE_5     = $DC ; orange
OCTAVE_UP    = $DD
OCTAVE_DOWN  = $DE
LOOP_SWITCH  = $DF
INSTRUMENT_0 = $E0 ; gradual decay from F
INSTRUMENT_1 = $E1 ; gradual decay from C
INSTRUMENT_2 = $E2 ; gradual decay from 8
INSTRUMENT_3 = $E3 ; gradual decay from 4
INSTRUMENT_4 = $E4 ; fade from F->8->F
INSTRUMENT_5 = $E5 ; fade from C->4->B
INSTRUMENT_6 = $E6 ; fade from 8->1->8
INSTRUMENT_7 = $E7 ; hold, then decay from F
INSTRUMENT_8 = $E8 ; hold, then decay from C
INSTRUMENT_9 = $E9 ; hold, then decay from 4
INSTRUMENT_A = $EA ; fade from 8->F->8
INSTRUMENT_B = $EB ; fade from 4->C->4
INSTRUMENT_C = $EC ; decay from F with tremolo
INSTRUMENT_D = $ED ; decay from C with tremolo
INSTRUMENT_E = $EE ; fade C->4->B with tremolo
INSTRUMENT_F = $EF ; fade from 1->C->4->9->1
SCORE_GOTO   = $F0
SCORE_RETURN = $F1
VOLUME_MINUS = $F2 ; next byte is amount to subtract ($00 to $0F)
VOLUME_QRTR  = $F3
VOLUME_HALF  = $F4
DUTY_12      = $F5
DUTY_25      = $F6
DUTY_50      = $F7
SPEED_SET    = $F8
TEMPO_1      = $F9
TEMPO_2      = $FA
TEMPO_3      = $FB ; 75 bpm
TEMPO_4      = $FC ; 90 bpm
TEMPO_5      = $FD ; 99 bom
TEMPO_6      = $FE ; 112.5 bpm
END_SONG     = $FF


  
;;;;;;;;;;;;;;;;;;;;
;;
;; Weapon Graphics
;; 
;;
  
WEASEL_PLUSH      = $50
BIG_HOLE          = $54
DRINK_ITEM        = $58
SPEAR             = $60
TRIDENT           = $64
BELL_ITEM         = $68
CURSOR_1          = $70 ; best not to change it even if its doubled up, for now
CLAW              = $74
EXPLODE_MAGIC     = $78
HEAVY_SWORD       = $80
KATANA            = $84
SABRE             = $88
LONG_SWORD        = $8C
SHORT_SWORD       = $90
HAMMER            = $94
KNIFE             = $98
AXE               = $9C
CANE              = $A0
ROD_WEAPON        = $A4
NUNCHUCKS         = $A8
FIST              = $AC
WALL_MAGIC        = $B0
SPARKLE_MAGIC     = $B8
STARS_MAGIC       = $C0
LIGHTNING_MAGIC   = $C8
LONGFIRE_MAGIC    = $D0
GLOWBALL_MAGIC    = $D8
DUSTBALL_MAGIC    = $E0
SHORTFIRE_MAGIC   = $E8
CURSOR_2          = $F0
ENEMY_EXPLOSIONS  = $F4
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
;;;;;;;;;;;;;;;;;;;;;;
;;
;; USER SET THINGS
;;
;;

MAX_SONG                 = $1B ; total number of music tracks the soundtest screen can play ; 0 based
FAST_HITCAP              = $03 ; How many times the Fast spell can boost the hit multiplyer
STARTING_STATS           = $0E ; number of starting stats for each class ; 1 based
HP_MAX_LOW               = $E7
HP_MAX_HIGH              = $03 ; these two = 999
COVER_HITS               = $F0 ; high bits only (second number always 0). Amount of hits a knight can last covering someone.
COUNTER_CHANCE           = 150 ; must exceed this value to counter
MIN_CONFUSED_MAGDAMAGE   = $05 ; minimum magic damage for confused characters 
SMOKEBOMB_EFFECT         = 50  ; steps without battles - double for chemists 
BTL_HEAL_POTENCY         = 16  ; HP restored in battle - double for chemists
BTL_XHEAL_POTENCY        = 96  ; HP restored in battle - double for chemists
HEAL_POTENCY             = 30  ; HP restored - double for chemists
XHEAL_POTENCY            = 180 ; HP restored - double for chemists
TENT_HP                  = 45  ; HP restored by sleeping
CABIN_HP                 = 90  ; HP restored by sleeping
HOUSE_HP                 = 180 ; HP restored by sleeping































