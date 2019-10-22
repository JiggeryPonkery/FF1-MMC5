.include "variables.inc"
.include "macros.inc"
.include "Constants.inc"

.export BankC_CrossBankJumpList
.export PrepCharStatPointers
.export RespondDelay
.export lut_BattlePalettes

.import BattleConfirmation
.import BattleCrossPageJump_L
.import BattleOver_ProcessResult_L
.import BattleRNG_L
.import BattleScreenShake_L
.import BattleWaitForVBlank_L
.import CallMusicPlay_L
.import ClearBattleMessageBuffer_L
.import ClericCheck
.import CritCheck
.import DrawBattleEquipmentBox_L
.import DrawBattleMagicBox_L
.import DrawCombatBox_L
.import DrawCommandBox_L
.import DrawComplexString
.import DrawItemBox_L
.import DrawRosterBox_L
.import EnemyAttackPlayer_PhysicalZ
.import FormatBattleString_L
.import GameStart_L
.import HandPalette
.import LoadEnemyStats
.import LongCall
.import Magic_ConvertBitsToBytes
.import MultiplyXA
.import PlayerAttackEnemy_PhysicalZ
.import PlayerAttackPlayer_PhysicalZ
.import PrintBattleTurn
.import RandAX
.import ShiftSpriteHightoLow
.import SwapBtlTmpBytes_L
.import UndrawNBattleBlocks_L
.import WaitForVBlank_L
.import PlayDoorSFX
.import DrawManaString_ForBattle
.import DrawPlayerBox
.import ShiftLeft6
.import StealFromEnemyZ
.import SkillText_BBelt
.import RestoreMapMusic
.import JIGS_RefreshAttributes

BANK_THIS = $0C

.segment "BANK_0C"

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Weapon data!  [$8000 :: 0x30010]
;;
;;  8 bytes per weapon, 40 weapons ($140 bytes total)
;;
;;  byte 0:  Hit rate
;;  byte 1:  Damage
;;  byte 2:  Critial rate (BUGGED - not used .. see LoadOneCharacterIBStats for offending code) ;; JIGS ( this should be fixed now )
;;  byte 3:  Spell cast
;;  byte 4:  Element
;;  byte 5:  Category effectiveness (Giant/Undead/etc)
;;  byte 6:  graphic
;;  byte 7:  palette

;; JIGS - see bank Z for actual data!!!

;lut_WeaponData:

lut_EquipmentSpells:
.byte $00 ; Wooden nunchucks
.byte $00 ; Small knife 
.byte $00 ; Wooden staff
.byte $00 ; Rapier
.byte $00 ; Iron hammer
.byte $00 ; Short sword
.byte $00 ; Hand axe
.byte $00 ; Scimitar
.byte $00 ; Iron nunchucks
.byte $00 ; Large knife
.byte $00 ; Iron Staff
.byte $00 ; Sabre
.byte $00 ; Long sword
.byte $00 ; Great axe
.byte $00 ; Falchion
.byte $00 ; Silver knife
.byte $00 ; Silver Sword
.byte $00 ; Silver Hammer
.byte $00 ; Silver Axe
.byte $00 ; Flame sword
.byte $00 ; Ice sword
.byte $00 ; Dragon sword
.byte $00 ; Giant sword
.byte $00 ; Sun sword
.byte $00 ; Coral sword
.byte $00 ; Were sword
.byte $00 ; Rune sword
.byte $00 ; Power staff
.byte $12 ; Light axe       - casts HARM 2
.byte $14 ; Heal staff      - casts HEAL
.byte $15 ; Mage staff      - casts FIRE 2
.byte $04 ; Defense swrd    - casts SHIELD
.byte $1F ; Wizard staff    - casts CONFUSE
.byte $00 ; Vorpal sword
.byte $00 ; CatClaw
.byte $17 ; Thor Hammer     - casts BOLT 2
.byte $26 ; Bane sword      - casts BANE
.byte $00 ; Katana
.byte $00 ; Excalibur
.byte $00 ; Masamune
.byte $00 ; Chicken Knife    
.byte $00 ; Brave Blade
.byte $00 ;  
.byte $00 ;  
.byte $00 ;  
.byte $00 ;  
.byte $00 ;  
.byte $00 ;  
.byte $00 ;  
.byte $00 ;  
.byte $00 ;  
.byte $00 ;  
.byte $00 ;  
.byte $00 ;  
.byte $00 ;  
.byte $00 ;  
.byte $00 ;  
.byte $00 ;  
.byte $00 ;  
.byte $00 ;  
.byte $00 ;  
.byte $00 ; 
.byte $00 ; 
.byte $00 ; 

.byte $00 ; Cloth T 
.byte $00 ; Wooden armor
.byte $00 ; Chain armor
.byte $00 ; Iron armor
.byte $00 ; Steel armor
.byte $00 ; Silver armor
.byte $00 ; Flame armor
.byte $00 ; Ice armor
.byte $00 ; Opal armor
.byte $00 ; Dragon armor
.byte $00 ; Copper Q
.byte $00 ; Silver Q
.byte $00 ; Gold Q
.byte $00 ; Opal Q
.byte 44  ;$2C ; white T        - casts INVIS 2
.byte 32  ;$20 ; Black T        - casts ICE 2
.byte $00 ; Wooden shield
.byte $00 ; Iron shield
.byte $00 ; Silver shield
.byte $00 ; Flame shield
.byte $00 ; Ice shield
.byte $00 ; Opal shield
.byte $00 ; Aegis shield
.byte $00 ; Buckler
.byte $00 ; Protect cape
.byte $00 ; Cap
.byte $00 ; Wooden helm
.byte $00 ; Iron helm
.byte $00 ; Silver helm
.byte $00 ; Opal helm
.byte 20  ;$14 ; Heal helm      - casts HEAL
.byte $00 ; Ribbon
.byte $00 ; Gloves
.byte $00 ; Copper Gauntlet
.byte $00 ; Iron Gauntlet
.byte $00 ; Silver Gauntlet
.byte 23  ;$17 ; Zeus Gauntlet  - casts BOLT 2
.byte 55  ;$37 ; Power Gauntlet - casts SABER
.byte $00 ; Opal Gauntlet
.byte $00 ; Protect Ring
.byte $00 ;     
.byte $00 ; 
.byte $00 ; 
.byte $00 ; 
.byte $00 ; 
.byte $00 ; 
.byte $00 ; 
.byte $00 ; 
.byte $00 ; 
.byte $00 ; 
.byte $00 ; 
.byte $00 ; 
.byte $00 ; 
.byte $00 ; 
.byte $00 ; 
.byte $00 ; 
.byte $00 ; 
.byte $00 ; 
.byte $00 ; 
.byte $00 ; 
.byte $00 ; 
.byte $00 ; 
.byte $00 ; 
.byte $00 ; 

;; As you can see here, to set a spell, you can abandon the $ and just use the number of the spell. 
;; Reference Bank A for the spell list in normal people numbers, or Constants.inc for hex!

; Here's the element and category bytes shown in binary.
; Good luck trying to know what setting each byte actually does.
; I read somewhere that ice/fire armour or weapons are backwards 
; and those are the only ones that do anything with elements here...
;    
;                 Element   Category    
; Flame Sword   ; 0001,0000 1000,1000
; Ice sword     ; 0020,0000 1000,1100 
; Dragon sword  ; 0000,0000 0000,0010
; Giant sword   ; 0000,0000 0000,0100
; Sun sword     ; 0000,0000 1000,1100
; Coral sword   ; 0000,0000 0010,0000
; Were sword    ; 0000,0000 0001,0000
; Rune Sword    ; 0000,0000 0011,0000
; Excalibur     ; 1111,1111 1111,1111
;                 ^^^^ ^^^^ ^^^^ ^^^^
;                 |||| |||| |||| |||╘???  
;                 |||| |||| |||| ||╘Dragon  
;                 |||| |||| |||| |╘Giant  
;                 |||| |||| |||| ╘Undead  
;                 |||| |||| |||╘Were 
;                 |||| |||| ||╘Water  
;                 |||| |||| |╘Magic  
;                 |||| |||| ╘Regenerative  
;                 |||| |||╘Instant death?  
;                 |||| ||╘Stun?  
;                 |||| |╘Poison?
;                 |||| ╘Rub?  
;                 |||╘Fire  
;                 ||╘Ice  
;                 |╘Lightning  
;                 ╘Earth?  
;
; Best guesses taken from FF Hackster!

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Magic data!  [$81E0 :: 0x301F0]
;;
;;  8 bytes per magic spell:
;;      $40 spells          ($200 bytes)
;;      $02 potions         ($10 bytes)
;;      $1A enemy attacks   ($D0 bytes)
;;  = $2E0 bytes total
;;
;;    see MAGDATA constants in Constants.inc for layout description

lut_MagicData:
;
; JIGS - I highly recommend using FFHackster to design your magic, then copy-paste the data into the .bin above
;        and comment out the stuff below. For weapons and armours, too.
;
;; JIGS note - When loading up magic data, about #90 bytes can be saved by changing the bit-shifting to:
;; A = magic ID
;; LDX #7
;; JSR MultiplyXA
;; ...then deleting the unused byte from all of these.
   
;      ╒ Hit Rate
;      |   ╒ Effectivity
;      |   |   ╒ Element
;      |   |   |   ╒ Target
;      |   |   |   |   ╒ Effect
;      |   |   |   |   |   ╒ Graphic
;      |   |   |   |   |   |   ╒ Palette
;      |   |   |   |   |   |   |   ╒ Unused
;      v   v   v   v   v   v   v   v  
.byte $00,$10,$00,$10,$07,$C0,$29,$00 ; 00 CURE 
.byte $18,$14,$00,$01,$02,$C8,$21,$00 ; 01 HARM   
.byte $00,$08,$00,$10,$09,$B0,$29,$00 ; 02 SHIELD
.byte $00,$50,$00,$04,$10,$B0,$22,$00 ; 03 BLINK 
.byte $18,$0A,$10,$02,$01,$D0,$26,$00 ; 04 FIRE   
.byte $18,$20,$01,$01,$03,$E8,$2B,$00 ; 05 SLEEP  
.byte $40,$14,$00,$02,$0E,$B8,$28,$00 ; 06 LOCK  
.byte $18,$0A,$40,$02,$01,$C8,$28,$00 ; 07 BOLT   
.byte $00,$08,$00,$10,$08,$E0,$27,$00 ; 08 LAMP   
.byte $40,$40,$01,$01,$03,$E8,$2C,$00 ; 09 MUTE   
.byte $00,$40,$00,$08,$0A,$B0,$28,$00 ; 0A BOLT (Shield)
.byte $00,$28,$00,$10,$10,$B0,$23,$00 ; 0B INVISBL 
.byte $18,$14,$20,$02,$01,$D0,$21,$00 ; 0C ICE    
.byte $18,$08,$01,$01,$03,$E8,$23,$00 ; 0D DARK   
.byte $00,$0E,$00,$10,$0B,$B8,$2B,$00 ; 0E TEMPER  
.byte $40,$00,$01,$01,$04,$E8,$2A,$00 ; 0F SLOW    
.byte $00,$21,$00,$10,$07,$C0,$2B,$00 ; 10 CURE 2  
.byte $18,$28,$00,$01,$02,$C8,$23,$00 ; 11 HARM 2 
.byte $00,$10,$00,$08,$0A,$B0,$26,$00 ; 12 FIRE (shield)
.byte $03,$20,$00,$08,$15,$C0,$28,$00 ; 13 HEAL    ;; JIGS - Heal spells now apply regen
;.byte $00,$0C,$00,$08,$07,$C0,$28,$00 ; 14 HEAL     ;; backup of original spell
.byte $18,$1E,$10,$01,$01,$D0,$27,$00 ; 15 FIRE 2 
.byte $40,$10,$01,$02,$03,$E8,$27,$00 ; 16 HOLD    
.byte $18,$1E,$40,$01,$01,$C8,$27,$00 ; 17 BOLT 2 
.byte $40,$14,$00,$01,$0E,$B8,$27,$00 ; 18 LOCK 2  
.byte $00,$04,$00,$10,$08,$E0,$2A,$00 ; 19 PURE   
.byte $18,$28,$01,$01,$05,$E8,$25,$00 ; 1A FEAR        
.byte $00,$20,$00,$08,$0A,$B0,$21,$00 ; 1B ICE (shield)
.byte $00,$40,$00,$10,$08,$E0,$2C,$00 ; 1C VOICE  
.byte $40,$20,$00,$02,$03,$E8,$21,$00 ; 1D SLEEP 2
.byte $00,$00,$00,$10,$0C,$B8,$2A,$00 ; 1E FAST
.byte $40,$80,$01,$01,$03,$E8,$26,$00 ; 1F CONFUSE
.byte $18,$28,$20,$01,$01,$D0,$22,$00 ; 20 ICE 2  
.byte $00,$42,$00,$10,$07,$C0,$2C,$00 ; 21 CURE 3
.byte $00,$01,$00,$10,$06,$E0,$21,$00 ; 22 LIFE     ; JIGS - will now cure death, then heal some HP
.byte $18,$3C,$00,$01,$02,$C8,$25,$00 ; 23 HARM 3 
.byte $04,$40,$00,$08,$15,$C0,$27,$00 ; 24 HEAL 2
;.byte $00,$18,$00,$08,$07,$C0,$27,$00 ; 25 HEAL 2
.byte $18,$32,$10,$01,$01,$D0,$25,$00 ; 26 FIRE 3    
.byte $28,$01,$02,$01,$03,$E8,$22,$00 ; 27 BANE  
.byte $FF,$00,$00,$08,$00,$00,$00,$00 ; 28 WARP  
.byte $40,$00,$00,$02,$04,$E8,$29,$00 ; 29 SLOW 2
.byte $00,$02,$00,$10,$14,$E0,$20,$00 ; 2A SOFT    ; JIGS - will now cure stone
.byte $FF,$00,$00,$08,$00,$00,$00,$00 ; 2B EXIT   
.byte $00,$0C,$00,$08,$09,$B0,$2A,$00 ; 2C SHIELD2
.byte $00,$28,$00,$08,$10,$B0,$24,$00 ; 2D INVIS 2
.byte $18,$3C,$40,$01,$01,$C8,$22,$00 ; 2E BOLT 3 
.byte $18,$01,$08,$02,$03,$D8,$20,$00 ; 2F RUB    
.byte $28,$01,$80,$01,$03,$B8,$26,$00 ; 30 QUAKE  
.byte $00,$10,$01,$02,$12,$E8,$28,$00 ; 31 STUN   
.byte $00,$00,$00,$10,$0F,$C0,$21,$00 ; 32 CURE 4 
.byte $30,$50,$00,$01,$02,$C8,$2C,$00 ; 33 HARM 4    
.byte $00,$89,$00,$08,$0A,$B0,$25,$00 ; 34 RUB (shield)
.byte $05,$60,$00,$08,$15,$C0,$25,$00 ; 35 HEAL 3
;.byte $30,$30,$00,$08,$07,$C0,$25,$00 ; 36 HEAL 3
.byte $18,$46,$20,$01,$01,$D0,$2B,$00 ; 37 ICE 3  
.byte $40,$02,$02,$02,$03,$C8,$20,$00 ; 38 BREAK  
.byte $00,$10,$00,$04,$0D,$B0,$20,$00 ; 39 SABER 
.byte $00,$08,$01,$02,$12,$E8,$24,$00 ; 3A BLIND  
.byte $00,$01,$00,$10,$13,$D8,$21,$00 ; 3B LIFE 2  ; JIGS - will now cure death, then max HP
.byte $6B,$50,$00,$01,$01,$C8,$24,$00 ; 3C HOLY   
.byte $00,$FF,$00,$10,$0A,$B0,$20,$00 ; 3D WALL          
.byte $6B,$00,$00,$02,$11,$B8,$20,$00 ; 3E DISPEL        
.byte $6B,$64,$00,$01,$01,$D0,$28,$00 ; 3F FLARE  
.byte $30,$10,$04,$01,$03,$E8,$20,$00 ; 40 STOP           
.byte $20,$01,$04,$01,$03,$D8,$2B,$00 ; 41 BANISH         
.byte $00,$01,$08,$02,$12,$D8,$28,$00 ; 42 DOOM      

;      ╒ Hit Rate
;      |   ╒ Effectivity
;      |   |   ╒ Element
;      |   |   |   ╒ Target
;      |   |   |   |   ╒ Effect
;      |   |   |   |   |   ╒ Graphic
;      |   |   |   |   |   |   ╒ Palette
;      |   |   |   |   |   |   |   ╒ Unused
;      v   v   v   v   v   v   v   v  
.byte $18,$00,$00,$01,$01,$E8,$20,$00 ; Kick

;; removed heal and pure data

;; Enemy attacks
.byte $20,$18,$20,$01,$01,$00,$00,$00 ; FROST      
.byte $20,$0C,$10,$01,$01,$00,$00,$00 ; HEAT       
.byte $05,$02,$02,$02,$03,$00,$00,$00 ; GLANCE     
.byte $00,$10,$01,$02,$03,$00,$00,$00 ; GAZE       
.byte $18,$08,$01,$01,$03,$00,$00,$00 ; FLASH      
.byte $20,$07,$10,$01,$01,$00,$00,$00 ; SCORCH     
.byte $10,$01,$80,$01,$03,$00,$00,$00 ; CRACK      
.byte $00,$01,$08,$02,$03,$00,$00,$00 ; SQUINT     
.byte $18,$11,$00,$02,$01,$00,$00,$00 ; STARE      
.byte $10,$01,$04,$02,$03,$00,$00,$00 ; GLARE      
.byte $20,$32,$20,$01,$01,$00,$00,$00 ; BLIZZARD   
.byte $20,$40,$10,$01,$01,$00,$00,$00 ; BLAZE      
.byte $20,$60,$10,$01,$01,$00,$00,$00 ; INFERNO    
.byte $20,$18,$10,$01,$01,$00,$00,$00 ; CREMATE    
.byte $05,$02,$02,$01,$03,$00,$00,$00 ; POISON     
.byte $00,$10,$00,$01,$03,$00,$00,$00 ; TRANCE     
.byte $20,$44,$02,$01,$01,$00,$00,$00 ; POISON     
.byte $20,$4C,$40,$01,$01,$00,$00,$00 ; THUNDER    
.byte $00,$01,$08,$01,$03,$00,$00,$00 ; TOXIC      
.byte $18,$08,$01,$02,$03,$00,$00,$00 ; SNORTING   
.byte $30,$50,$00,$01,$01,$00,$00,$00 ; NUCLEAR    
.byte $18,$08,$01,$01,$03,$00,$00,$00 ; INK        
.byte $00,$04,$02,$01,$03,$00,$00,$00 ; STINGER    
.byte $20,$10,$01,$02,$03,$00,$00,$00 ; DAZZLE     
.byte $20,$40,$00,$01,$01,$00,$00,$00 ; SWIRL      
.byte $20,$40,$00,$01,$01,$00,$00,$00 ; TORNADO    
    

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Magic battle messages  [$84C0 :: 0x304D0]
;;
;;    1 bytes per magic spell, $40+$02+$1A spells+potions+attacks ($5C bytes total)
;;  Each entry indicates which battle message to print when the spell connects with its target.
;;  A value of 0 indicates no message should be printed.
;;
;;    The values themselves match BTLMSG_XXXX names in Constants.inc

lut_MagicBattleMessages:
  .BYTE $01 ; CURE          ; HP up!
  .BYTE $00 ; HARM   
  .BYTE $02 ; SHIELD        ; Armor up
  .BYTE $03 ; BLINK         ; Easy to dodge
  .BYTE $00 ; FIRE   
  .BYTE $00 ; SLEEP  
  .BYTE $05 ; LOCK          ; Easy to hit
  .BYTE $00 ; BOLT   
  .BYTE $00 ; LAMP          ; Cures ailment, so will print Cured! even if this is $00
  .BYTE $00 ; MUTE   
  .BYTE $08 ; BOLT (Shield) ; Defend lightning
  .BYTE $03 ; INVISBL       ; Easy to dodge
  .BYTE $00 ; ICE    
  .BYTE $00 ; DARK   
  .BYTE $0A ; TEMPER        ; Weapons stronger
  .BYTE $0B ; SLOW          ; Lost intelligence
  .BYTE $01 ; CURE 2        ; HP up!
  .BYTE $00 ; HARM 2 
  .BYTE $0C ; FIRE (shield) ; Defend fire
;  .BYTE $01 ; HEAL          ; HP up!
  .BYTE BTLMSG_REGENERATING  ; Begins healing slowly
  .BYTE $00 ; FIRE 2 
  .BYTE $0D ; HOLD          ; Attack halted
  .BYTE $00 ; BOLT 2 
  .BYTE $05 ; LOCK 2        ; Easy to hit
  .BYTE $00 ; PURE          ; Cures ailment, so will print Cured! even if this is $00 
  .BYTE $0F ; FEAR          ; Became terrified
  .BYTE $10 ; ICE (shield)  ; Defend cold
  .BYTE $00 ; VOICE         ; Cures ailment, so will print Cured! even if this is $00 
  .BYTE $00 ; SLEEP 2
  .BYTE $12 ; FAST          ; Quick shot
  .BYTE $00 ; CONFUSE
  .BYTE $00 ; ICE 2  
  .BYTE $01 ; CURE 3        ; HP up!
  .BYTE $4F ; LIFE          ; Revived from the brink!
  .BYTE $00 ; HARM 3 
;  .BYTE $01 ; HEAL 2        ; HP up!
  .BYTE BTLMSG_REGENERATING  ; Begins healing slowly
  .BYTE $00 ; FIRE 3    
  .BYTE $4D ; BANE          ; Poison smoke
  .BYTE $4A ; WARP          ; Ineffective now
  .BYTE $0B ; SLOW 2        ; Lost intelligence
  .BYTE $29 ; SOFT          ; Cured!
  .BYTE $4A ; EXIT          ; Ineffective now
  .BYTE $02 ; SHIELD2       ; Armor up
  .BYTE $03 ; INVIS 2       ; Easy to dodge
  .BYTE $00 ; BOLT 3 
  .BYTE $15 ; RUB           ; Erased
  .BYTE $16 ; QUAKE         ; Fell into crack
  .BYTE $00 ; STUN            ;; JIGS - Stun has no message? Really?
  .BYTE $18 ; CURE 4        ; HP max!
  .BYTE $00 ; HARM 4    
  .BYTE $19 ; RUB (shield)  ; Defend magic ;; JIGS should be "defend death?"
;  .BYTE $01 ; HEAL 3        ; HP up!
  .BYTE BTLMSG_REGENERATING  ; Begins healing slowly
  .BYTE $00 ; ICE 3  
  .BYTE $00 ; BREAK  
  .BYTE $1B ; SABER         ; Weapon became enchanted
  .BYTE $00 ; BLIND  
  .BYTE $4F ; LIFE 2        ; Revived from the brink!
  .BYTE $00 ; HOLY   
  .BYTE $1C ; WALL          ; Defend all
  .BYTE $1D ; DISPEL        ; Defenseless
  .BYTE $00 ; FLARE  
  .BYTE $1E ; STOP          ; Time stopped
  .BYTE $1F ; BANISH        ; Exile to 4th dimension
  .BYTE $15 ; DOOM          ; Erased
  
  .BYTE $00 ; kick 
  
  ; enemy attacks
  .BYTE $00 ; FROST     ; 
  .BYTE $00 ; HEAT      ; 
  .BYTE $00 ; GLANCE    ; 
  .BYTE $00 ; GAZE      ; 
  .BYTE $00 ; FLASH     ; 
  .BYTE $00 ; SCORCH    ; 
  .BYTE $16 ; CRACK     ; Fell into crack
  .BYTE $15 ; SQUINT    ; Erased
  .BYTE $00 ; STARE     ; 
  .BYTE $1F ; GLARE     ; Exile to 4th dimension
  .BYTE $00 ; BLIZZARD  ; 
  .BYTE $00 ; BLAZE     ; 
  .BYTE $00 ; INFERNO   ; 
  .BYTE $00 ; CREMATE   ; 
  .BYTE $4D ; POISON    ; Poison smoke
  .BYTE $00 ; TRANCE    ; 
  .BYTE $00 ; POISON    ; 
  .BYTE $00 ; THUNDER   ; 
  .BYTE $15 ; TOXIC     ; Erased
  .BYTE $00 ; SNORTING  ; 
  .BYTE $00 ; NUCLEAR   ; 
  .BYTE $00 ; INK       ; 
  .BYTE $00 ; STINGER   ; 
  .BYTE $00 ; DAZZLE    ; 
  .BYTE $00 ; SWIRL     ; 
  .BYTE $00 ; TORNADO   ; 
  .BYTE $00 ; unused
  .BYTE $00 ; unused
  .BYTE $00 ; unused
  .BYTE $00 ; unused
  
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Data for enemy stats [$8520 :: 0x30530]
;;
;;  $80 Enemies * $14 bytes per enemy
;;    = $A00 bytes of data
;;
;;  See ENROMSTAT_xxx constants in Constants.inc for layout

;data_EnemyStats:
  
  ;; JIGS - see bank Z!!
  
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  LUT for Battle Palettes [$8F20 :: 0x30F30]
;;
;;    LUT of 64 4-byte palettes for use with battle formations

lut_BattlePalettes:
  ;.INCBIN "bin/battlepalettes.bin"
;                          ; Enemies that use it: (may not be 100% accurate)  
.byte $0F,$36,$27,$16 ; 00 ; Imp, Wolf
.byte $0F,$36,$22,$13 ; 01 ; GrImp, GrWolf, Iguana
.byte $0F,$25,$29,$1B ; 02 ; Giant, WrWolf
.byte $0F,$23,$26,$16 ; 03 ; R.Hydra, R.Giant, Fire, Agama
.byte $0F,$24,$30,$22 ; 04 ; FrWolf, FrGiant, Air
.byte $0F,$26,$2B,$19 ; 05 ; Sauria
.byte $0F,$3A,$16,$1B ; 06 ; Astos
.byte $0F,$30,$31,$22 ; 07 ; Frost D., GrShark, Ghost
.byte $0F,$37,$26,$16 ; 08 ; R. Sahag
.byte $0F,$30,$2B,$1C ; 09 ; BigEye, Shark, Sahag
.byte $0F,$36,$21,$12 ; 0A ; Kyzoku
.byte $0F,$30,$28,$19 ; 0B ; WzSahag, Pirate
.byte $0F,$30,$23,$1B ; 0C ; Bone, Crawl, GrPede
.byte $0F,$37,$25,$16 ; 0D ; Creep, Cerebus, Red D., R. Bone
.byte $0F,$38,$26,$14 ; 0E ; Ogre, Medusa
.byte $0F,$23,$29,$19 ; 0F ; GrMedusa, GrOgre
.byte $0F,$17,$31,$1C ; 10 ; Hyena, WzOgre
.byte $0F,$36,$26,$14 ; 11 ; Cobra, Bull
.byte $0F,$25,$2B,$19 ; 12 ; Asp, Troll
.byte $0F,$30,$2C,$13 ; 13 ; Lobster, Naga, Water, SeaSnake, Garland
.byte $0F,$30,$22,$12 ; 14 ; SeaTroll, Blue D.
.byte $0F,$2B,$26,$16 ; 15 ; Scorpion, Pede
.byte $0F,$16,$2C,$18 ; 16 ; Zombie, ZomBull, Phantom, ZombieD
.byte $0F,$23,$30,$00 ; 17 ; Ghoul, Evilman, Eye
.byte $0F,$30,$28,$1C ; 18 ; Specter, Image
.byte $0F,$30,$2A,$18 ; 19 ; Geist, Wraith, Grey W.
.byte $0F,$32,$1C,$0C ; 1A ; Spider, Shadow, Saber T, Muck
.byte $0F,$37,$27,$13 ; 1B ; Worm
.byte $0F,$16,$37,$18 ; 1C ; Earth, Sand W., Ankylo
.byte $0F,$30,$28,$17 ; 1D ; Tiger, Manticor, Catman
.byte $0F,$25,$2B,$19 ; 1E ; Mancat
.byte $0F,$30,$12,$16 ; 1F ; Gargoyle
.byte $0F,$37,$16,$13 ; 20 ; WzVamp, R. Goyle
.byte $0F,$30,$28,$1A ; 21 ; Scum, Ooze, Gas D.
.byte $0F,$36,$26,$16 ; 22 ; Arachnid, R.Ankylo
.byte $0F,$30,$37,$1A ; 23 ; Sphinx
.byte $0F,$30,$32,$0C ; 24 ; Mage, Badman
.byte $0F,$30,$26,$16 ; 25 ; Mummy, Perelisk
.byte $0F,$30,$27,$12 ; 26 ; Coctrice, WzMummy
.byte $0F,$30,$27,$16 ; 27 ; Wyrm, T-Rex
.byte $0F,$30,$2C,$1C ; 28 ; Wyvern
.byte $0F,$36,$26,$16 ; 29 ; Tyro
.byte $0F,$26,$3C,$1B ; 2A ; Hydra, Caribe
.byte $0F,$25,$2A,$1A ; 2B ; Gator, Ocho
.byte $0F,$1B,$27,$16 ; 2C ; Naocho, R.Caribe
.byte $0F,$37,$32,$00 ; 2D ; FrFator, GrNaga
.byte $0F,$37,$10,$1C ; 2E ; Fighter, Guard, IronGol
.byte $0F,$30,$26,$00 ; 2F ; WarMech
.byte $0F,$17,$38,$18 ; 30 ; Chimera
.byte $0F,$13,$37,$1B ; 31 ; Jimera
.byte $0F,$30,$27,$18 ; 32 ; Madpony, Wizard
.byte $0F,$14,$30,$22 ; 33 ; Sorcerer, Nitemare
.byte $0F,$36,$26,$16 ; 34 ; MudGol
.byte $0F,$36,$10,$00 ; 35 ; RockGol
.byte $0F,$30,$28,$04 ; 36 ; Lich
.byte $0F,$30,$16,$23 ; 37 ; Lich
.byte $0F,$16,$14,$30 ; 38 ; Kary
.byte $0F,$16,$14,$28 ; 39 ; Kary
.byte $0F,$27,$30,$23 ; 3A ; Kraken
.byte $0F,$3B,$13,$23 ; 3B ; Kraken
.byte $0F,$16,$2B,$12 ; 3C ; Tiamat
.byte $0F,$27,$2B,$13 ; 3D ; Tiamat
.byte $0F,$23,$28,$18 ; 3E ; Chaos
.byte $0F,$30,$28,$18 ; 3F ; Chaos

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  LUT for Enemy AI [$9020 :: 0x31030]
;;
;;    $10 bytes per AI
;;
;;  byte      0 = chance to cast spell         ($00-80)
;;  byte      1 = chance to use special attack ($00-80)
;;  bytes   2-9 = magic spells available.  Each entry 0-based.  Or 'FF' to mark end of spells
;;  bytes $B-$E = special attacks (0 based), or 'FF' to mark end of attacks

lut_EnemyAi:
  
  ;      0   1   2   3   4   5   6   7   8   9   A   B   C   D   E   F  
.byte $00,$20,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$00,$00,$00,$00,$FF ; 00 ; Frost Wolf
.byte $00,$20,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$01,$01,$01,$01,$FF ; 01 ; Agama
.byte $00,$40,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$02,$02,$02,$02,$FF ; 02 ; Sauria
.byte $00,$80,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$03,$03,$03,$03,$FF ; 03 ; OddEYE
.byte $00,$40,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$03,$04,$03,$04,$FF ; 04 ; BigEYE
.byte $00,$40,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$05,$05,$05,$05,$FF ; 05 ; Cerberus
.byte $40,$00,$03,$0D,$05,$15,$1F,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF ; 06 ; WzOgre
.byte $00,$40,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$06,$06,$06,$06,$FF ; 07 ; Sand Worm
.byte $50,$50,$3F,$35,$2D,$16,$15,$09,$0F,$05,$FF,$02,$07,$03,$08,$FF ; 08 ; EYE
.byte $40,$40,$3D,$3E,$3B,$35,$2D,$15,$09,$0F,$FF,$09,$09,$09,$09,$FF ; 09 ; PHANTOM
.byte $60,$00,$14,$0F,$0D,$05,$04,$07,$00,$05,$FF,$FF,$FF,$FF,$FF,$FF ; 0A ; Mancat
.byte $00,$20,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$17,$17,$17,$17,$FF ; 0B ; Vampire
.byte $20,$20,$12,$09,$1F,$1F,$16,$16,$14,$14,$FF,$17,$17,$17,$17,$FF ; 0C ; WzVamp
.byte $40,$00,$14,$15,$04,$04,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF ; 0D ; Red Gargoyle
.byte $00,$40,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$0A,$0A,$0A,$FF,$FF ; 0E ; Frost Dragon
.byte $00,$40,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$0B,$0B,$0B,$FF,$FF ; 0F ; Red Dragon
.byte $00,$20,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$07,$07,$07,$07,$FF ; 10 ; Perelist
.byte $00,$40,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$0D,$0D,$FF,$FF,$FF ; 11 ; Red Hydra
.byte $60,$00,$16,$15,$0F,$0D,$07,$06,$05,$07,$FF,$FF,$FF,$FF,$FF,$FF ; 12 ; Naga
.byte $60,$00,$03,$09,$0F,$0D,$05,$04,$07,$13,$FF,$FF,$FF,$FF,$FF,$FF ; 13 ; Grey Naga
.byte $00,$40,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$0D,$0D,$0D,$FF,$FF ; 14 ; Chimera
.byte $00,$40,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$0D,$0E,$0D,$0E,$FF ; 15 ; Jimera
.byte $00,$40,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$0F,$0F,$0F,$0F,$FF ; 16 ; Sorcerer
.byte $00,$40,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$10,$10,$10,$FF,$FF ; 17 ; Gas Dragon
.byte $00,$40,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$11,$11,$11,$FF,$FF ; 18 ; Blue Dragon
.byte $20,$00,$1D,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF ; 19 ; Mug Golem
.byte $30,$00,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$FF,$FF,$FF,$FF,$FF,$FF ; 1A ; Rock Golem
.byte $00,$10,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$12,$12,$12,$12,$FF ; 1B ; Iron Golem
.byte $20,$00,$3B,$3C,$3B,$3F,$37,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF ; 1C ; Badman
.byte $40,$00,$2D,$2C,$24,$25,$27,$24,$2F,$2C,$FF,$FF,$FF,$FF,$FF,$FF ; 1D ; Mage
.byte $30,$00,$3A,$3B,$33,$2A,$2B,$30,$23,$20,$FF,$FF,$FF,$FF,$FF,$FF ; 1E ; Fighter
.byte $00,$20,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$13,$13,$13,$13,$FF ; 1F ; Nitemare
.byte $00,$20,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$14,$14,$14,$14,$FF ; 20 ; WarMech
.byte $00,$40,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$16,$16,$16,$16,$FF ; 21 ; Manticor
.byte $60,$00,$1F,$1C,$1D,$16,$15,$14,$0F,$05,$FF,$FF,$FF,$FF,$FF,$FF ; 22 ; Lich
.byte $60,$00,$3C,$3D,$3E,$3F,$3C,$3D,$3E,$3F,$FF,$FF,$FF,$FF,$FF,$FF ; 23 ; Lich Reprise
.byte $30,$00,$14,$0D,$14,$0D,$14,$15,$14,$15,$FF,$FF,$FF,$FF,$FF,$FF ; 24 ; Kary
.byte $30,$00,$24,$2D,$24,$2D,$24,$2F,$24,$2F,$FF,$FF,$FF,$FF,$FF,$FF ; 25 ; Kary Reprise
.byte $00,$20,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$15,$15,$15,$15,$FF ; 26 ; Kraken
.byte $30,$20,$16,$16,$16,$16,$16,$16,$16,$16,$FF,$15,$15,$15,$15,$FF ; 27 ; Kraken Reprise
.byte $00,$40,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$11,$10,$0A,$0B,$FF ; 28 ; Tiamat
.byte $40,$40,$25,$1F,$16,$14,$25,$1F,$16,$14,$FF,$11,$10,$0A,$0B,$FF ; 29 ; Tiamat Reprise
.byte $40,$40,$34,$2C,$27,$30,$24,$1F,$1D,$3C,$FF,$06,$0C,$18,$19,$FF ; 2A ; Chaos
.byte $60,$00,$2D,$27,$1D,$14,$16,$0F,$0D,$05,$FF,$FF,$FF,$FF,$FF,$FF ; 2B ; Astos

;; From the FF Bytes documents 
;  ##   Strat.      (Magics and Magic Cycle : Attack and Attack Cycle)
;  00 = FrWOLF 	    (: FROST)
;  01 = AGAMA 	    (: HEAT)
;  02 = SAURIA 	    (: GLANCE)
;  03 = OddEYE 	    (: GAZE)
;  04 = BigEYE 	    (: GAZE, FLASH)
;  05 = CERBERUS    (: SCORCH)
;  06 = WzOGRE	    (RUSE, DARK, SLEP, HOLD, ICE2)
;  07 = Sand W	    (: CRACK)
;  08 = EYE  	    (XXXX, BRAK, RUB, LIT2, HOLD, MUTE, SLOW, SLEP : GLANCE, SQUINT, GAZE, STARE)
;  09 = PHANTOM	    (STOP, ZAP!, XFER, BRAK, RUB, HOLD, MUTE, SLOW : GLARE)
;  0A = MANCAT	    (FIR2, SLOW, DARK, SLEP, FIRE, LIT, CURE, SLEP)
;  0B = VAMPIRE	    (: DAZZLE)
;  0C = WzVAMP	    (AFIR, MUTE, ICE2[*2], LIT2[*2], FIR2[*2] : DAZZLE)
;  0D = R`GOYLE	    (FIR2, HOLD, FIRE[*2])
;  0E = Frost D	    (: BLIZZARD)
;  0F = Red D	    (: BLAZE)
;  10 = PERELISK    (: SQUINT)
;  11 = R`HYDRA	    (: CREMATE)
;  12 = NAGA	    (LIT2, LOCK, SLEP, LIT, LIT2, HOLD, SLOW, DARK)
;  13 = GrNAGA	    (RUSE, MUTE, SLOW, DARK, SLEP, FIRE, LIT, HEAL)
;  14 = CHIMERA	    (: CREMATE)
;  15 = JIMERA	    (: CREMATE, POISON(pos))
;  16 = SORCERER    (: TRANCE)
;  17 = Gas D	    (: POISON(dmg))
;  18 = Blue D	    (: THUNDER)
;  19 = MudGOL	    (FAST)
;  1A = RockGOL	    (SLOW)
;  1B = IronGOL	    (: TOXIC)
;  1C = BADMAN	    (XFER, NUKE, XFER, XXXX, BLND)
;  1D = MAGE	    (RUB, LIT3 ,FIR3 ,BANE, SLO2, FIR3, STUN, LIT3)
;  1E = FIGHTER	    (WALL, XFER, HEL3, FOG2, INV2, CUR4 ,HEL2, CUR3)
;  1F = NITEMARE    (: SNORTING)
;  20 = WarMECH	    (: NUCLEAR)
;  21 = MANTICOR    (: STINGER) 
;  22 = LICH	    (ICE2, SLP2, FAST, LIT2, HOLD, FIR2, SLOW, SLEP)
;  23 = LICH 2	    (NUKE, STOP, ZAP!, XXXX)
;  24 = KARY	    (FIR2, DARK, FIR2, DARK, FIR2, HOLD, FIR2, HOLD)
;  25 = KARY 2	    (FIR3, RUB)
;  26 = KRAKEN	    (: INK)
;  27 = KRAKEN 2    (LIT2 : INK)
;  28 = TIAMAT	    (: THUNDER, POISON(dmg), BLIZZARD, BLAZE)
;  29 = TIAMAT 2    (BANE, ICE2, LIT2, FIR2 : THUNDER, POISON(dmg), BLIZZARD, BLAZE)
;  2A = CHAOS	    (ICE3, LIT3, SLO2, CUR4, FIR3, ICE2, FAST, NUKE : CRACK, INFERNO, SWIRL, TORNADO)
;  2B = ASTOS	    (RUB, SLO2, FAST, FIR2, LIT2, SLOW, DARK, SLEP)
;  FF = None  

.align $100  
  
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  ExitBattle  [$92E0 :: 0x312F0]
;;
;;    Called when battle is over.  Fades out and does other end-of-battle stuff.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

ExitBattle:
    LDA btl_result                  ; if its 2, they won the battle, so walk forward
    CMP #$02
    BNE :+
    JSR ResetUsePalette
    JSR PartyWalkAnimation          ; JIGS - makes them all walk to the left
    JMP :++                         ; does its own fadeout, so skip this one
    
  : JSR BattleFadeOut               ; else, just fade out
    
  : JSR ReSortPartyByAilment        ; rearrange party to put sick/dead members in the back
    LDA btl_result                  ; check battle result
    CMP #$FF                        ; if not $FF...
    BEQ @ChaosWait
    
    JSR LongCall
    .word RestoreMapMusic
    .byte BANK_MUSIC
    RTS
   
   @ChaosWait:
    LDA #120                        ; otherwise, wait 120 frames (2 seconds)
    STA btl_result                  ;  before exiting
    BNE WaitFrames_BattleResult
    

;; JIGS - don't think this should be messed with. Weird routine in Bank B I don't wanna figure out.
BankC_CrossBankJumpList:

ExitBattle_L:                   JMP ExitBattle                  ; $9000
BattleFadeOutAndRestartGame_L:  JMP BattleFadeOutAndRestartGame ; $9003
FinishBattlePrepAndFadeIn_L:                                    ; $9006

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  FinishBattlePrepAndFadeIn  [$9306 :: 0x31316]
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

FinishBattlePrepAndFadeIn:
    JSR LongCall
    .word LoadEnemyStats              ; this is all pretty self explanitory
    .byte BANK_ENEMYSTATS
    
    JSR BattleUpdatePPU
    
    LDA #$08                        ; enable BG drawing, but not sprites
    STA btl_soft2000
    LDA #$0E
    STA btl_soft2001
    
    JSR ClearBattleMessageBuffer_L
    JSR BattleFadeIn
    
    LDA #$1E
    STA btl_soft2001                ; enable BG and sprites
    
    JSR EnterBattlePrepareSprites
    JSR BackupCharacterBattleStats
    ;; JIGS - adding battle turn reset:
    LDA #1
    STA BattleTurn    
    JSR PrintBattleTurnNumber
    JSR DrawCharacterStatus
    JSR DrawPlayerBox
    
    JMP Battle_AfterFadeIn
    
    
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  WaitFrames_BattleResult  [$932A :: 0x3133A]
;;
;;  input:  btl_result = number of frames to wait (zero'd on exit)
;;
;;    Will actually wait N+1 frames.  It's weird that btl_result is hijacked for
;;  this purpose, but whatever.
;;
;;  NOTE:  This routine will not update music!  Therefore it should only be called
;;    when music is stopped.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

WaitFrames_BattleResult:
    JSR WaitForVBlank_L     ; wait a frame
    
    LDA #$00                ; burn a bunch of CPU time -- presumably so that 
    : SEC                   ;  WaitForVBlank isn't called again so close to start of
      SBC #$01              ;  vblank.  I don't think this is actually necessary,
      BNE :-                ;  but it doesn't hurt.
      
    DEC btl_result          ; loop until counter has expired
    BNE WaitFrames_BattleResult
    
    SEC                     ; SEC before exit? This triggers the End Game bridge scene
  WaitFrames_BattleResult_RTS:
    RTS

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  CheckForEndOfBattle  [$933B :: 0x3134B]
;;
;;    Checks btl_result, and if nonzero, ends the battle.
;;  When ending the battle, this routine will NOT RTS, but will double-RTS,
;;  returning control to whoever called EnterBattle originally.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

CheckForEndOfBattle:
    LDA btl_result
    BNE :+
      RTS                       ; if battle result is zero, do nothing -- keep battling!
      
  : LDX AutoTargetOptionBackup      ;; JIGS - restore option for future battles
    STX AutoTargetOption            ;; in case it was overwritten in the last round 
  
    CMP #$02                    ; if battle result == 2, the party is victorious
    BNE :+
      JSR PlayFanfareAndCheer   ; play fanfare music and do cheering animation
      
  : LDA #<BattleOver_ProcessResult_L    ; For all non-zero battle results, the battle is over
    STA btltmp+6                        ; Hand off control to another routine in bank B
    LDA #>BattleOver_ProcessResult_L
    STA btltmp+7
    
    LDA #$0B
    JMP BattleCrossPageJump_L
    
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  BattleFadeOutAndRestartGame  [$9355 :: 0x31365]
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

BattleFadeOutAndRestartGame:
    JSR BattleFadeOut
    JMP GameStart_L     ; then jump to GameStart, which returns the user to the title screen.
    
   
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Battle_AfterFadeIn  [$93AE :: 0x313BE]
;;
;;    Called after battle has faded in for the first time (shortly after entry).
;;  It actually starts doing actual battle stuff!
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

ClearCommandBuffer:
    LDY #$1C
    LDA #$00
    STA btl_attackid                ; clear attack id?  This seems very strange to do here...
    : STA btl_charcmdbuf-1, Y       ; clear the character battle command buffer
      DEY
      BNE :-
    RTS

Battle_AfterFadeIn:
  ;  LDY #$1C
  ;  LDA #$00
  ;  : STA btl_charcmdbuf-1, Y   ; zero the player command buffer
  ;    DEY
  ;    BNE :-
  ;; This gets done before the turn starts though...?
      
    LDA #$00                    ; zero a bunch of misc vars to prep them
    STA btl_boxcount
    STA btl_strikingfirst
    STA btl_attackid
    STA battle_autoswitch
    
    LDA btlform_norun
    AND #$01                ; see if "no run" bit is set.  If it is, there is no strike first/surprised check
    BNE BattleLogicLoop
    
    ; This block of code does some math to see if the party will be surprised or
    ;   get a first strike in the battle.  The end result of this math is:
    ; 
    ; S = (leaders_agility + leaders_luck) / 8
    ; V = random[S+S, S+100] - surpised_rate
    ;
    ; if V <  11, party is surprised  (possibly BUGGED, since 0 is a valid value, should this be 10 instead of 11?)
    ; if V >= 90, party strikes first
    ; otherwise, normal fight
    
    LDA #$00
    STA btl_mathbuf+1   ; clear high byte of mathbuf0
    
    LDA ch_agility
    CLC
    ADC ch_speed
    LSR A
    LSR A
    LSR A
    STA btl_mathbuf     ; mathbuf0 = (agil+luck)/8   -- party leader's stats only
    
    LDX #100
    JSR RandAX          ; random value between that and 100
    TAX
    
    LDA #$00
    JSR MathBuf_Add     ; add random value, effectively creating range of [2*stat, stat+100], where 'stat' is above agil+luck value
    LDX btlform_surprise; get surprise rate
    LDA #$00
    JSR MathBuf_Sub     ; subtracts surprise rate from that value
    
    LDY btl_mathbuf         ; put value in XY
    LDX btl_mathbuf+1
    JSR ZeroXYIfNegative    ; clip at 0 (pointless, because MathBuf_Sub already does this)
    
    TYA                     ; drop high byte and check low byte
    CMP #11
   
    BCC @Surprised          ; if < 11, SURPRISED!
    CMP #90
    BCC BattleLogicLoop     ; if < 90, normal fight
    
      ; otherwise (>= 90), STRIKE FIRST
      LDA #BTLMSG_STRIKEFIRST
      JSR DrawMessageBoxDelay_ThenClearAll   ; draw strike first message
      INC btl_strikingfirst             ; set flag
      JMP BattleLogicLoop               ; and jump ahead to logic loop
    
    ; surprised code
  @Surprised:
    LDA #02
    STA btl_strikingfirst               ; JIGS - if party surprised, this is 2
    LDA #BTLMSG_SURPRISED
    JSR DrawMessageBoxDelay_ThenClearAll
    ;JMP BattleLogicLoop_DoCombat        ; skip over first round of player input, and just do combat
    ;; JIGS - flows into it
    
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  BattleLogicLoop  [$9420 :: 0x31430]
;;
;;    The main loop for battle.  Get player commands, then perform combat.
;;  Rinse and Repeat until battle is over.
;;
;;    When the party is surprised, the game will jump to an alternate entry point,
;;  skipping player commands for the first round of combat.  Note that while this means party members
;;  can't attack or do other commands, they *DO* still get a turn during combat.  This turn is actually
;;  used if the character becomes stunned or falls asleep.
;;
;;    So if you are surpised by Geists or something, and one of your chars gets stunned, he might
;;  still un-stun in the first round, even though you were surprised.  One might consider this
;;  to be BUGGED.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

BattleLogicLoop_DoCombat_Surprised:     ; alternative entry point for when the party is surprised
    JSR ClearCommandBuffer
    JSR DoBattleRound
    JSR CheckForEndOfBattle

BattleLogicLoop:
    JSR RebuildEnemyRoster          ; Rebuild the roster in case some enemies died/ran away
    JSR DrawRosterBox_L             ; Draw the roster box
    INC btl_boxcount
   @FrameLoop: 
    JSR DoFrame_WithInput        
    BEQ @FrameLoop
    JSR UndrawOneBox
    
BattleLogicLoop_ReEntry:    
    LDA AutoTargetOptionBackup      ;; JIGS - restore AutoTargetOption if auto battle (start button)
    STA AutoTargetOption            ;;  was used last round
    JSR ClearCommandBuffer

    ;;   Get input commands for each of the 4 characters.  This is done kind of confusingly,
    ;; since the player can undo/backtrack by pressing B.  This code does not necessarily
    ;; flow linearly.
    ;;
    ;;   If the user backtracks, instead of RTS'ing, GetCharacterBattleCommand will drop
    ;; its return address and jump back to one of these 'Backtrack' labels.  See
    ;; GetCharacterBattleCommand for more details
    
 __GetCharacterBattleCommand_Backtrack_0:
    LDA #$00
    JSR GetCharacterBattleCommand
 __GetCharacterBattleCommand_Backtrack_1:
    LDA #$01
    JSR GetCharacterBattleCommand
 __GetCharacterBattleCommand_Backtrack_2:
    LDA #$02
    JSR GetCharacterBattleCommand
 __GetCharacterBattleCommand_Backtrack_3:
    LDA #$03
    JSR GetCharacterBattleCommand
    
    INC btlcmd_curchar       ; set this to 4 so the BacktrackBattleCommand jump table works right!
    
ReadyToFight:
    LDA #5
    JSR DrawCombatBox_NoRestore
    JSR LongCall             ; swap to Bank Z to draw this
    .word BattleConfirmation
    .byte BANK_Z
    
    LDA #0
    STA gettingcommand    
    STA battle_autoswitch
    LDY #$10
    : LDA lut_ReadyCursorPos-1, Y
      STA btlcurs_positions-1, Y   
      DEY
      BNE :-
    JSR MenuSelection_2x4           
    CMP #02
    BEQ BacktrackBattleCommand  ;; bit 2 set if B pressed, so undraw the ready? box
    LDA btlcurs_x               ;; otherwise, A was pressed on either Yes or No
    BNE BacktrackBattleCommand  ;; < no was chosen
    
    ;; ----
    ;;  Once all commands are input
    
    JSR UndrawOneBox
    JSR DrawCharacterStatus
    
    ; And then do the actual combat!
BattleLogicLoop_DoCombat:       ; alternative entry point for when the party is surprised
    JSR DoBattleRound
    JSR CheckForEndOfBattle
    JSR RebuildEnemyRoster
    JMP BattleLogicLoop_ReEntry ; JIGS - do this to skip pressing a button again before selecting a command

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  BacktrackBattleCommand  [$945B :: 0x3146B]
;;
;;    Called when the user pressed B to move to a previous character's commands.  This does
;;  the weird non-linear jumping around bullshit described in GetCharacterBattleCommand.
;;  See that routine for details.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

BacktrackBattleCommand:
    LDA btlcmd_curchar          ; use cur char as index to our jump table, so we know where to backtrack to.
    BNE :+    
    JMP InputCharacterBattleCommand2 ; if Character 0, stay right there
   
  : JSR UndrawOneBox
    ASL A
    TAY
    LDA @JumpTable, Y
    STA $88
    LDA @JumpTable+1, Y
    STA $89                     ; $88,89 is where to jump back to
    JMP ($0088)
    
  @JumpTable:
  NOP
  NOP
  .WORD __GetCharacterBattleCommand_Backtrack_0     ; char 1 backtracks to char 0
  .WORD __GetCharacterBattleCommand_Backtrack_1     ; char 2 backtracks to char 1
  .WORD __GetCharacterBattleCommand_Backtrack_2     ; char 3 backtracks to char 2
  .WORD __GetCharacterBattleCommand_Backtrack_3     ; ready check backtracks to char 3
  
  
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  GetCharacterBattleCommand  [$9477 :: 0x31487]
;;
;;  input:   A = the character whose commands to get
;;  input:   A = the character whose commands to get
;;  output:  btl_charcmdbuf is filled appropriately
;;
;;    This routine will acquire and record the battle commands for a single character.
;;
;;  NOTE!:
;;    This routine is strange and may not actually RTS out.  Instead, if the player presses
;;  'B' in the battle menu to move back to a previous character, the return address is dropped
;;  and instead, this routine will jump back to the middle of the BattleLogicLoop.
;;
;;    This is terrible design, IMO, as there are dozens of better ways to do this, but whatever.
;;  Ultimately this means that this routine cannot be safely called from anywhere other than
;;  BattleLogicLoop.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


GetCharacterBattleCommand:
    STA btlcmd_curchar              ; record the character
    CLC
    ROR A
    ROR A
    ROR A
    STA CharacterIndexBackup        ; convert current command character 
    TAX
    LDA ch_class, X
    AND #$0F                        ; get class, throw away sprite bits
    CMP #CLS_KN                     ; if its over black mage, subtract 6
    BCC :+
      SBC #6
  : STA battle_class
    
    LDA btlcmd_curchar    
    JSR PrepCharStatPointers        ; Prep the stat pointers (this persists through all the sub menus)
    
    JSR ClearGuardState             ; in case they guarded then chose to re-select their command, undo the guard state
    
    LDY #ch_ailments - ch_stats     ; See if this character has any ailment that would prevent them from inputting
    LDA (CharStatsPointer), Y       ;   any commands
    AND #AIL_DEAD | AIL_STONE | AIL_SLEEP | AIL_CONF
    BEQ InputCharacterBattleCommand ; If they can, jump to routine to get input from menus
    RTS
    
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  SetCharacterBattleCommand  [$935D :: 0x3136D]
;;
;;  Sets the battle command for character 'btlcmd_curchar' to the following:
;;
;;  btl_charcmdbuf+0 = A
;;  btl_charcmdbuf+1 = X
;;  btl_charcmdbuf+2 = Y
;;
;;  Afterward, it will walk the character back to the right.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

SetCharacterBattleCommand:
    PHA
    TYA
    PHA
    TXA
    PHA
    LDA btlcmd_curchar
    ASL A
    ASL A
    TAY
    PLA
    STA btl_charcmdbuf+1, Y     ; [1] = X
    PLA
    STA btl_charcmdbuf+2, Y     ; [2] = Y
    PLA
    STA btl_charcmdbuf, Y       ; [0] = A
    LDA battle_class
    STA btl_charcmdbuf+3, Y     ; for ethers and skill use
    
    LDA ConfusedMagic
    BEQ :+                      ; resume as normal
        LDA btl_charcmdbuf+1, Y     ; A = effect
        LDX btl_charcmdbuf+2, Y     ; X = target
        LDY BattleCharID            ; Y = attacker
        JMP Player_DoMagic
    
  : LDA btlcmd_curchar
    JSR CharWalkAnimationRight
    JSR HideCharacter
    JMP BattleFrame 
    
    ;; JIGS - that should do it for hiding sprites...!    
    
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  UndoCharacterBattleCommand  [$937A :: 0x3138A]
;;
;;    Undoes a character's input battle command.  This is called when the player
;;  pressed B in the battle menu to move back to a previous character.
;;  This routine is really only significant for 2 things:
;;
;;  1) The Item command will dec a potion counter.  If the player moves back to undo
;;     that Item, the potion counter needs to be incremented back.
;;
;;  2) We might not necessarily want to go back to the previous character, since the
;;     previous character might be sleeping/stunned/dead/stone.  Therefore this
;;     routine will backtrack to the next "able-bodied" character.
;;
;;    After this routine, btlcmd_curchar will be 1+ the desired character to backtrack to,
;;  so future code can merely subtract 1 from this to get the desired character.  Or...
;;  btlcmd_curchar will be 0 if you can't backtrack any more.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    
UndoCharacterBattleCommand:
    LDA btlcmd_curchar                  ; if we're on character 0, we can't back up any more
    BEQ @Done
    
    ; Otherwise, try to back up more...
    SEC                                 ; get the prev char's stats
    SBC #$01
    JSR PrepCharStatPointers

    LDY #ch_ailments - ch_stats
    LDA (CharStatsPointer), Y        ; see if they have ailments that would stop them from doing anything
    AND #AIL_DEAD | AIL_STONE | AIL_SLEEP | AIL_CONF
    BEQ @Done
    
    DEC btlcmd_curchar                  ; if they can't, dec curchar to go to the prev character
    JMP UndoCharacterBattleCommand      ;  and try again

  @Done:
    RTS
    
    

  

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  InputCharacterBattleCommand  [$9496 :: 0x314A6]
;;
;;     Gets the character battle command from user input.  This is called
;;  by GetCharacterBattleCommand if the character in question is able to
;;  input commands.  See that routine for details
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    
InputCharacterBattleCommand:
    LDA btlcmd_curchar        
    JSR CharWalkAnimationLeft           ; walk this character left

CancelBattleAction_RedrawCommand:    
    JSR DrawCommandBox
    JSR UpdateSprites_BattleFrame       ; then do a frame with updated battle sprites

InputCharacterBattleCommand2:           ;; JIGS - instead of making them walk around all the time...
CancelBattleAction:                     ;; and why bother having a routine that jumps back here??
    LDA btlcmd_curchar
    JSR PrepAndGetBattleMainCommand     ; get the main menu command
    CMP #$02                            
    BNE Battle_MainMenu_APressed        ; If they pressed A, jump ahead to get their sub-menu selection

    ; if B pressed in main menu         
    LDA btlcmd_curchar
    BEQ :+
    JSR CharWalkAnimationRight          ; walk this character back to the right
    JSR HideCharacter                   ;; JIGS - rehide them if previously hidden
  : JSR UndoCharacterBattleCommand      ; undo the previously input command
    JMP BacktrackBattleCommand          ; and backtrack to previous character.
    
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Battle_MainMenu_APressed  [$94B8 :: 0x314C8]
;;
;;     This subroutine is jumped to when A is pressed to select something on
;;  the main menu.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

Battle_MainMenu_APressed:
    LDA #0
    STA gettingcommand    
    LDA btlcurs_y               ; use the selected row to index the sub menu jump table
    AND #$03
    ASL A
    TAY
    LDA btlcurs_x               ; check which column they're in
    AND #$01
    BEQ :+                      ; if in the right column (RUN)
       LDA lut_BattleSubMenu2, Y 
       STA BattleMenuPointer
       LDA lut_BattleSubMenu2+1, Y
       STA BattleMenuPointer+1
       JMP (BattleMenuPointer) ; ($0088)
        
  : LDA lut_BattleSubMenu, Y
    STA BattleMenuPointer
    LDA lut_BattleSubMenu+1, Y
    STA BattleMenuPointer+1
    JMP (BattleMenuPointer) ; ($0088)                 ; then jump to the appropriate sub menu logic

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  lut_BattleSubMenu  [$94DE :: 0x314EE]
;;
;;    Jump table for battle submenus.  Called when the player selects one of the FIGHT/MAGIC/Item/ITEM
;;  options on the main battle screen.

lut_BattleSubMenu:
  .WORD BattleSubMenu_Fight
  .WORD BattleSubMenu_Magic
  .WORD BattleSubMenu_Skill
  .WORD BattleSubMenu_Equipment
    
  ;;JIGS - adding things

;; Skill ideas to try and implement  
; Fighter       Defend      ; guard the back row from attacks
; Thief         Steal       ; steal from enemy
; BBelt         Counter     ; defend and attack 1.5x strength if hit
; RedMage       Runic       ; absorb magic that turn
; WhiteMage     Chant       ; lose defense to charge next spell
; BlackMage     Chant

lut_BattleSubMenu2:
  .WORD BattleSubMenu_Guard
  .WORD BattleSubMenu_Item
  .WORD BattleSubMenu_Hide
  .WORD BattleSubMenu_Run
  

BattleSubMenu_Skill:
    LDA battle_class
  : BEQ @DoNothing                  ; if fighter, do nothing
    CMP #2                          ; only thieves have a skill so far, so
    BCS @DoNothing                  ; if bbelt or higher, do nothing

   @Steal: 
    JSR UndrawOneBox
    JSR SelectEnemyTarget           ; Pick a target
    CMP #$02
    BNE :+                          ; If they pressed B....
      JSR DrawCommandBox
      JMP CancelBattleAction        ; ... cancel
  
  : LDA #ACTION_SKILL
    JMP SetCharacterBattleCommand   ; command 'FE ?? TT'; FE is "steal", TT is enemy target, ?? is not used
  
   @DoNothing:
    LDA #BTLMSG_NOSKILL
    JSR DrawMessageBoxDelay_ThenClearIt
    JMP CancelBattleAction
  

BattleSubMenu_Run:  
    JSR UndrawOneBox
    LDA btlcmd_curchar
    ORA #$80                  ; get character index, put in Y
    TAY
    LDA #ACTION_FLEE
    JMP SetCharacterBattleCommand     ; command '20 ?? TT' for running, where 'TT' is character running and ?? is unused.  
 

BattleSubMenu_Guard:
    JSR UndrawOneBox
    LDA btlcmd_curchar
    PHA
    JSR PrepCharStatPointers
    LDY #ch_battlestate - ch_stats
    LDA (CharStatsPointer), Y
    ORA #STATE_GUARDING       ; add the Guard status
    STA (CharStatsPointer), Y
    PLA
    ORA #$80                  ; get character index, put in Y
    TAY
    LDA #ACTION_GUARD
    JMP SetCharacterBattleCommand


  ;; JIGS - this is new!  
BattleSubMenu_Hide:
    LDA btlcmd_curchar
    PHA                           ; Backup character ID
    JSR PrepCharStatPointers      ; load player's ailments
    LDY #ch_ailments - ch_stats
    LDA (CharStatsPointer), Y
    AND #AIL_DARK | AIL_STUN      ; see if character is blind or stunned
    BEQ @DoHide
    
   @PrintStuff:
    LDA #BTLMSG_CANTHIDE
    JSR DrawMessageBox
   @FrameLoop: 
    JSR DoFrame_WithInput        
    BEQ @FrameLoop               ; Wait for the player to provide any input
    JSR UndrawOneBox
    PLA                          ; Restore Character ID
    JMP CancelBattleAction

   @DoHide:
    JSR UndrawOneBox
    PLA                          
    ORA #$80                     
    TAY                          
    LDA #ACTION_HIDE              ; bit 8 set ; JIGS - new hiding bit for battle commands!
    JMP SetCharacterBattleCommand

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  BattleSubMenu_Fight  [$94E6 :: 0x314F6]
;;
;;  Called when the player selects 'FIGHT'
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

SetAutoBattle:
    LDA #0
    STA AutoTargetOption         ; turn on AutoTarget
    DEC battle_autoswitch
    JSR SetAutoFirstChar   
    
   @Loop:
    JSR @AutoBattleSet
    INC btlcmd_curchar
    LDA btlcmd_curchar
    CMP #4
    BNE @Loop
    JMP AutoSet_Ready
    
   @AutoBattleSet:
    LDA btlcmd_curchar          
    JSR ConfirmCharacterCanAct
    BCS :+
    LDA #ACTION_FIGHT
    STA btl_charcmdbuf, X       ; [0] = A
  : RTS

SetAutoFirstChar:    
    LDA btlcmd_curchar           ; see what character to start from
    STA MMC5_tmp+1
    JSR CharWalkAnimationRight   ; walk this character back to the right
    JMP HideCharacter            ;; JIGS - rehide them if previously hidden

SetAutoRun:
    INC battle_autoswitch
    JSR SetAutoFirstChar   
   
   @Loop:
    JSR @AutoRunSet   
    INC btlcmd_curchar
    LDA btlcmd_curchar
    CMP #4
    BNE @Loop
    JMP AutoSet_Ready

 @AutoRunSet:
    LDA btlcmd_curchar         
    JSR ConfirmCharacterCanAct
    BCS :+
    LDA #ACTION_FLEE
    STA btl_charcmdbuf, X       ; [0] = A
    LDA btlcmd_curchar          
    ORA #$80
    STA btl_charcmdbuf+2, X     ; [2] = Y
  : RTS

ConfirmCharacterCanAct:
    AND #03
    PHA
    JSR RemoveCharacterAction   ; clear out the buffer
    TYA
    TAX
    PLA
    JSR PrepCharStatPointers
    LDY #ch_ailments - ch_stats
    CLC
    LDA (CharStatsPointer), Y
    AND #AIL_DEAD | AIL_STONE | AIL_SLEEP | AIL_CONF
    BEQ :+
    SEC
  : RTS
    
AutoSet_Ready: 
    JSR BattleClearVariableSprite
    JSR BattleFrame
    JSR UndrawOneBox
    INC MMC5_tmp+1
    LDA MMC5_tmp+1
    STA btlcmd_curchar
    PLA 
    PLA
    PLA
    PLA                             ; two JSRs to undo 
    JMP ReadyToFight
    

BattleSubMenu_Fight:
    JSR UndrawOneBox
    JSR SelectEnemyTarget                   ; Pick a target
    CMP #$02                              
    BNE :+                                  ; If they pressed B....
      JMP CancelBattleAction_RedrawCommand  ; ... cancel
  : LDA #ACTION_FIGHT                       ; If they pressed A, record the command
    JMP SetCharacterBattleCommand           ; Command:   04 xx TT    attack enemy slot TT (xx appears to be unused)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  BattleSubMenu_Magic  [$94F5 :: 0x31505]
;;
;;  Called when the player selects 'MAGIC'
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

BattleSubMenu_Magic:
    JSR UndrawOneBox                ; undraw the command box

BattleSubMenu_Magic_NoUndraw:
    LDA btlcmd_curchar              ; <- This is never used
    JSR Magic_ConvertBitsToBytes    ; JIGS is using it!

    JSR MenuSelection_Magic
    JSR UndrawOneBox                ; undraw the selection box
    
    CMP #$02
    BNE :+                          ; if they pressed B to exit the menu box
      JSR DrawCommandBox            ;   re-draw the command box
      JMP CancelBattleAction        ;   then cancel this action
      
  : LDA btlcurs_y   ; up/down  (0 to 3)
    LDX #3          ; 3 spells per level! Since there's no gap between spell levels anymore.
    JSR MultiplyXA
    STA tmp
    
    LDA DrawBattleMagicBox_toporbottom ; first 12 spells or second 12 spells, (0 or 1)
    BEQ :+
    
    LDA #4         ; if its 1, put 4 in tmp+1
 :  STA tmp+1      ; if its 0, put 0 in tmp+1
    ASL A
    ASL A          ; multiply 4*4 = 16
    SEC            
    SBC tmp+1      ; and subtract 4 to get 12, the amount of spells in a box - or still 0.
    
    CLC
    ADC btlcurs_x  ; left/right (0 to 2)
    CLC
    ADC tmp        ; btlcurs_y * 3
    
    ;; Spell Index = cursor_y * 3 + cursor_X + Page * 4 * 3
    
    TAY                             ; put that index in Y, and use it to get the chosen spell
    LDA TempSpellList, Y            ;; JIGS - proper spell list
    BNE :+                          ; if they selected an empty slot, do the @NothingBox -- otherwise skip over it
    
  @NothingBox:
      JSR DoNothingMessageBox       ; Show the nothing box
      JMP BattleSubMenu_Magic_NoUndraw  ; and redo the magic selection submenu from the beginning
      
  : STA btlcmd_spellindex                       ; store spell in 6B7D

    ;; JIGS - new part here too: MP index = Page * 4 + cursor_Y

    LDA tmp+1                 ; Top or Bottom box * 4 (0 or 4)    
    CLC
    ADC CharacterIndexBackup  ; +$0, $40, $80, or $C0
    ADC #ch_mp - ch_stats     ; +$30
    ADC btlcurs_y             ; "spell level" - but only 0-3 
    TAX
    LDA ch_stats, X           ; stats plus all ^ those numbers 
    AND #$F0                  ; chop off low bits (max mp) to get current mp
    
    BEQ @NothingBox                 ; if no more MP for this level, cut to "nothing" box and repeat.

ConfusedMagicLoadPoint:    
    LDY btlcmd_curchar
    LDA #$01
    STA btl_charcmdconsumetype, Y   ; put 01 as consumable type (to indicate magic)
    TXA
    STA btl_charcmdconsumeid, Y     ; put the spell level as the consumable ID
    ;; JIGS ^ note, X is not spell level anymore, but the whole ch_stats list up until the proper MP slot
    
    DEC btlcmd_spellindex           ; dec index of selected spell (make it 0 based instead of 1 based)
    LDA btlcmd_spellindex
    JSR GetPointerToMagicData
    
    LDY #$05
    LDA (MagicPointer), Y
    STA btl_various_tmp             ; put magic graphic at 68B3 (temp)
    
    LDY #$06
    LDA (MagicPointer), Y
    STA btl_various_tmp+1           ; put magic palette at 68B4 (temp)
    
    LDA btlcmd_curchar
    ASL A
    TAY                             ; use 2*char as index for btlcmd_magicgfx
    
    LDA btl_various_tmp
    STA btlcmd_magicgfx, Y          ; record magic graphic
    LDA btl_various_tmp+1
    STA btlcmd_magicgfx+1, Y        ; and magic palette
    
    LDY #$03
    LDA (MagicPointer), Y           ; get the target for this spell (stored as semi-flags:  01,02,04,08,10,20 are valid values)
    
  @CheckTarget_01:
    LSR A                           ; shift out low bit
    BCC @CheckTarget_02             ; if set (target=01 -- target all enemies)...
      LDY #$FF
      LDA #ACTION_MAGIC             ;  command = 02 xx FF  (where xx = spell index)
      LDX btlcmd_spellindex
      JMP SetCharacterBattleCommand ; set command and exit
  
  @CheckTarget_02:                  ; target 02 = target one enemy
    LSR A
    BCC @CheckTarget_04
      LDA btl_battletype
      CMP #3                        ; if its a fiend/chaos battle, don't bother selecting target
      BCC :+
        LDY #$00                    ; output: Y = the target slot
        JMP :+++
    : LDA ConfusedMagic
      BEQ :+
        JSR GetRandomEnemy_ForMagic
        TXA
        TAY
        JMP :++        
    : JSR SelectEnemyTarget_Magic   ; puts target in Y
      CMP #$02
      BNE :+                        ; if they pressed B to exit
        JMP BattleSubMenu_Magic_NoUndraw     ; redo magic submenu from the beginnning
    : LDA #ACTION_MAGIC
      LDX btlcmd_spellindex
      JMP SetCharacterBattleCommand ; command = 02 xx TT  (xx = spell, TT = enemy target)
    
  @CheckTarget_04:                  ; target 04 = target self
    LSR A
    BCC @CheckTarget_08     
      LDA btlcmd_curchar            ; use cur char
      ORA #$80                      ; OR with 80 to indicate targetting a player character
      TAY
      LDA #ACTION_MAGIC
      LDX btlcmd_spellindex
      JMP SetCharacterBattleCommand
    
  @CheckTarget_08:                  ; target 08 = target whole party
    LSR A
    BCC @Target_10
      LDA #ACTION_MAGIC
      LDY #$FE                      ; 'FE' targets party
      LDX btlcmd_spellindex
      JMP SetCharacterBattleCommand ; 02 xx FE

  @Target_10:                       ; target 10 = target one player
    LDA ConfusedMagic
    BEQ :+
      JSR BattleRNG_L
      JMP :++
  
  : LDA btlcmd_curchar
    JSR SelectPlayerTarget          ; get a player target?
    CMP #$02                        ; did they press B to exit
    BNE :+
      ;JMP BattleSubMenu_Magic       ; if yes, jump back to magic submenu
      JMP BattleSubMenu_Magic_NoUndraw
  : LDA btlcurs_y
  : AND #$03
    ORA #$80                        ; otherwise, put the player target in Y
    TAY
    LDA #ACTION_MAGIC
    LDX btlcmd_spellindex
    JMP SetCharacterBattleCommand   ; 02 xx TT

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  BattleSubMenu_Item  [$95F5 :: 0x31605]
;;
;;  Called when the player selects 'Item'
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

BattleSubMenu_Item:
    LDA item_heal         ; see if there are any consumables
    ORA item_x_heal
    ORA item_ether
    ORA item_elixir
    ORA item_down
    ORA item_pure
    ORA item_eyedrops
    ORA item_bell
    ORA item_soft
    ORA item_smokebomb
    BNE :+                      ; if there are no potions...
      JSR DoNothingMessageBox   ; show the 'Nothing' box
      JMP CancelBattleAction    ; then cancel

  : JSR UndrawOneBox
    
BattleSubMenu_Item_NoUndraw:
    INC btl_boxcount
    JSR DrawItemBox_L          ; otherwise (have at least 1 potion), draw the Item box
  
    JSR MenuSelection_Item     ; get menu selection from the player  
    JSR UndrawOneBox
    CMP #$02
    BNE :+                      ; was B pressed to get out of the Item menu?
      JSR DrawCommandBox 
      JMP CancelBattleAction    ;   if yes, cancel the action
      
  : LDX battle_item             ; get the item they chose
    LDA item_box, X             ; item_box was filled with $FF before being filled with 
    CMP #$FF                    ; item IDs. If battle_item points to an $FF, do nothing
    BNE @ItemOK
       JSR DoNothingMessageBox
       JMP CancelBattleAction
    
   @ItemOK:
    STA btlcmd_spellindex       ; now holds item ID
    CMP #SMOKEBOMB
    BEQ @NoTarget
    CMP #WAKEUPBELL             ; it doesn't matter what gets saved as the target 
    BNE @GetTarget              ; since it will never be used by these items
    
       @NoTarget:
        PHA                     ; since there's a pull up ahead for the player target 
        JMP @SkipTarget         ; just push this, since it won't be used anyway
   
  @GetTarget:
    LDA btlcmd_curchar          ; get input for SelectPlayerTarget
    JSR SelectPlayerTarget      ; and call it!
    CMP #$02
    BNE :+                      ; if they pressed B...
      JMP BattleSubMenu_Item_NoUndraw  ; ... return to the Item sub menu
  
  : LDA btlcurs_y           ; get target
    AND #$03
    STA submenu_targ        ; save for Ether stuff, not used otherwise
    ORA #$80                ; OR with 80 to indicate it's a player target
    PHA                     ; backup for a bit later
  
    LDA btlcmd_spellindex
    CMP #ETHER                  ; if its an ether, gotta do another menu selection...
    BNE @SkipTarget
    
   @EtherManaMenu:
    LDA #6
    JSR DrawCombatBox
    JSR LongCall
    .word DrawManaString_ForBattle
    .byte BANK_MENUS
    
    JSR EtherManaSelection      ; pressing A will set tmp 
    JSR UndrawOneBox
    CMP #$02
    BNE :+                      ; if they pressed B...
      PLA                       ; pull previous target from stack
      JMP BattleSubMenu_Item_NoUndraw ; ... return to the target selection
    
  : LDA btlcurs_x
    ASL A
    ASL A                       ; x = 0 or 1, times 4
    ADC btlcurs_y               ;   + 0, 1, 2, or 3
    STA battle_class            ; = spell level chosen (is also used for skills)
    JSR Ether_IsThereMP         ; check that character for mana
    BNE @SkipTarget             ; if they have a high byte, do it
        JSR DoNothingMessageBox ; otherwise, print "Nothing" and jump back
        JMP @EtherManaMenu
    
   @SkipTarget:
    LDY btlcmd_curchar
    LDA #$02
    STA btl_charcmdconsumetype, Y   ; store 02 as the consumable type (to indicate Item)
    LDA btlcmd_spellindex
    STA btl_charcmdconsumeid, Y     ; store menu selection as consumed ID -- to indicate which potion  (00/01 for Heal/Pure potion)
    
    PLA                     ; get last character selection
    TAY                     ; put in Y (for SetCharacterBattleCommand)
    LDX btlcmd_spellindex   ; get the item ID 
    LDA #ACTION_ITEM
    JMP SetCharacterBattleCommand
    
    ;; SetCharacterBattleCommand saves the following:
    ;STA btl_charcmdbuf+1, Y     ; [1] = X <- Item ID, add $40 for item message
    ;STA btl_charcmdbuf+2, Y     ; [2] = Y <- target
    ;STA btl_charcmdbuf, Y       ; [0] = A <- %00001000 ($08) this bit is set to indicate item use
    ;STA btl_charcmdbuf+4, Y     ; [4] = tmp <- spell level for ether
    
EtherManaSelection:
    LDY #$10
    : LDA lut_EtherCursorPos-1, Y   ; copy over the cursor positions for
      STA btlcurs_positions-1, Y    ;  the Item menu
      DEY
      BNE :-
    JMP MenuSelection_2x4           ; and do the logic
    
Ether_IsThereMP:
    LDA submenu_targ
    JSR ShiftLeft6
    CLC
    ADC #ch_mp - ch_stats
    ADC tmp
    TAX
    LDA ch_stats, X
    AND #$0F
    RTS   




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  BattleSubMenu_Equipment  [$9679 :: 0x31689]
;;
;;  Called when the player selects 'ITEM'
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

BattleSubMenu_Equipment:
;;
;; WeaponPointer variable is used as tmp space until the end of this, where it finally is used as a pointer.
;;

    LDA btlcmd_curchar
    JSR PrepCharStatPointers

    LDA #$00            ; Check the 8 equipment slots and make sure there's at least 1 item
    LDX #$08
    LDY #ch_righthand - ch_stats
    : ORA (CharStatsPointer), Y  ; OR all equipment together to see if any are nonzero
      INY
      DEX
      BNE :-
      
    AND #$FF                        ; update Z flag to see if all slots were zero
    BNE :+                          ; if all slots were 0 (no items), flow into @NothingBox, otherwise skip ahead
    
  @NothingBox:
      JSR DoNothingMessageBox       ; Show the "nothing" box
      JMP CancelBattleAction        ; And cancel this battle action
      
  : JSR UndrawOneBox
  
    JSR DrawBattleEquipmentBox_L    ; Draw the item box
    INC btl_boxcount
    JSR MenuSelection_Equipment     ; and run the logic for selecting an item
    
    JSR UndrawOneBox
    
    CMP #$02
    BNE :+                          ; if B pressed
      JSR DrawCommandBox
      JMP CancelBattleAction        ; cancel action
      
  : LDA btlcurs_x               ; Selected column
    AND #$01
    STA btl_various_tmp
    LDA btlcurs_y               ;  + Selected row
    AND #$03
    ASL A
    CLC
    ADC btl_various_tmp         ;  = equip slot of selected item
    
    ;; A is now Column (0 - 1) + Row*2 (0, 2, 4, 6)
    ;; Since the equipment is listed in this order:
    ;; 0       1
    ;; 2       3
    ;; 4       5 
    ;; 6       7 

    ADC #ch_righthand - ch_stats  ; + offset for character equipment = index for ob stats
    PHA
    
    LDA btlcmd_curchar
    JSR PrepCharStatPointers

    PLA
    TAY
    
    LDA (CharStatsPointer), Y   ; Get the selected equipment
    BEQ @NothingBox             ; if zero, print nothing box and exit
    
    STA WeaponPointer           ; if nonzero, stick it in $89
    DEC WeaponPointer           ; convert from 1-based to 0-based
    
    LDA btlcmd_curchar
    PHA
    TAY
    LDA WeaponPointer           ; otherwise weapon selected, get the index    
    STA btl_charcmditem, Y      ; record it in command buffer as item being used

    TAX
    LDA lut_EquipmentSpells, X
    STA tmp
    
    JSR GetPointerToMagicData
    
    LDY #$06
    LDA (MagicPointer), Y
    TAX
    PLA                          ; = btlcmd_curchar
    ASL A
    TAY
    TXA
    STA btlcmd_magicgfx+1, Y     ; save X as magic palette
    
    
  @GetSpellCast:
    DEC tmp
    LDX tmp                         ; put it in X
    ;DEX                             ; DEX to make it 0-based (FF becomes "no spell")
    LDY btlcmd_curchar              ; Y=cur char -- default to targetting yourself
    LDA #ACTION_GEAR
    JMP SetCharacterBattleCommand
   
    
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  GetPointerToMagicData  [$9711 :: 0x31721]
;;
;;  in:    A = magic index
;;  out:  XA = pointer to that magic spell's data
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

GetPointerToMagicData:
    LDX #$08                ; *8 (8 bytes per spell)
    JSR MultiplyXA
    CLC
    ADC #<lut_MagicData     ; low byte
    STA MagicPointer
    TXA
    ADC #>lut_MagicData     ; high byte in X
    STA MagicPointer+1
    RTS
    
    
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  EnterBattlePrepareSprites  [$9724 :: 0x31734]
;;
;;  Prepare the battle sprites!
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

UnhideAllCharacters:        ;; JIGS - used by the end of battle cheering and to initalize to 0 at battle start.
    LDA #0
    STA ch_battlestate ;; - this also clears out regenerative spells and the guarding state
    STA ch_battlestate + $40
    STA ch_battlestate + $80
    STA ch_battlestate + $C0
    STA Hidden
    RTS

EnterBattlePrepareSprites:
    LDA #$00
    STA btl_drawflagsA      ; clear drawflags
    STA btl_drawflagsB
    
    STA btl_drawflagsC              ;; JIGS - adding this
    JSR UnhideAllCharacters ;; And this!
        
    JSR BattleClearOAM      ; clear shadow OAM
    JSR BattleFrame         ; do a frame with oam updated to clear actual oam)
    JSR BattleUpdatePPU     ; reset scroll and stuffs
    
    LDA #$00
    STA btl_msgdraw_blockcount  ; clear the block count (important for undrawing in fixed bank code)
    STA btl_boxcount               
    STA btlattackspr_nodraw              
    
    ;;  Prep all the character drawing stuff
    ;LDA #$B0
    
    ;; JIGS - since battle screen shifted, shifting positions! 
    
    LDA #$C4+8
    STA btl_chardraw_x + $0     ; put all characters in the $B0 column
    LDA #$C8+8
    STA btl_chardraw_x + $4
    LDA #$CC+8
    STA btl_chardraw_x + $8
    LDA #$D0+8
    STA btl_chardraw_x + $C
    
    LDA #$30                    ; set Y coords, starting at $30, and increasing by $18
    STA btl_chardraw_y + $0     ; JIGS - and add an extra pixel, so $19
    LDA #$49
    STA btl_chardraw_y + $4
    LDA #$62
    STA btl_chardraw_y + $8
    LDA #$7B
    STA btl_chardraw_y + $C
    
    LDA #$00                    ; graphics sets are pretty much fixed -- it's effectively just ID<<5
    STA btl_chardraw_gfxset + $0
    LDA #$20
    STA btl_chardraw_gfxset + $4
    LDA #$40
    STA btl_chardraw_gfxset + $8
    LDA #$60
    STA btl_chardraw_gfxset + $C
    
  ; JMP SetAllNaturalPose       ; <- flow into
    
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  SetAllNaturalPose  [$9776 :: 0x31786]
;;
;;  Call SetNaturalPose for all characters
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

SetAllNaturalPose:
    LDA #$00
    JSR SetNaturalPose
    LDA #$01
    JSR SetNaturalPose
    LDA #$02
    JSR SetNaturalPose
    LDA #$03
    JMP SetNaturalPose
    
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  BattleUpdatePPU  [$978A :: 0x3179A]
;;
;;  Applies btl_soft2001 and resets the scroll
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

BattleUpdatePPU:
    LDA btl_soft2001
    STA $2001               ; copy over soft2001
    LDA #$00
    STA $2005               ; reset scroll
    STA $2005
    RTS
    
    
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  BattleFrame  [$9799 :: 0x317A9]
;;
;;  This does all the work you'd expect to be done in a typical frame.
;;  Except for maybe resetting the scroll
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

BattleFrame:
    JSR BattleWaitForVBlank_L   ; Wait for VBlank 
    LDA $2002
    LDA #>oam
    STA $4014                   ; Do OAM DMA
    JMP BattleUpdateAudio       ; Update audio
    
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  BattleClearOAM  [$97A7 :: 0x317B7]
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

BattleClearOAM:
    LDX #$00            ; flood fill OAM with $F0
    LDA #$F0
    : STA oam, X
      INX
      BNE :-
    RTS

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  BattleClearVariableSprite  [$97B2 :: 0x317C2]
;;
;;    Erases the Variable sprite (cursor/weapon/magic) from shadow OAM
;;  And clears the drawflags which would redraw them
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

BattleClearVariableSprite:
    LDX #$00
    LDA #$F0
    : STA oam, X            ; clear first $10 bytes of shadow OAM  (the first 4 sprites)
      INX                   ;   (or 1 16x16 sprite)
      CPX #$10
      BNE :-
      
    LDA btl_drawflagsA      ; clear draw flags which draw those sprites
    AND #$0F
    STA btl_drawflagsA
    
    RTS

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  DoFrame_WithInput  [$97C7 :: 0x317D7]
;;
;;  Calls DoMiniFrame
;;  Also fetches controller input and returns it in A, and in btl_input
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

DoFrame_WithInput:
    JSR BattleRNG_L     ; generate a number and throw it away (makes RNG less predictable -- sorta)
    
    LDY #$01            ; strobe the controllers
    STY $4016
    DEY
    STY $4016
    
    LDY #$08            ; loop 8 times (once for each button)
  @Loop:
    LDA $4016           ; get button
    LSR A               ; shift out low bit
    BCS :+              ; if clear, shift out another one
      LSR A             ;  (this captures detachable Famicom controllers which report in bit 1)
  : ROR btl_input       ; Roll button state into temp rarm
    DEY
    BNE @Loop           ; repeat for all buttons
    
    JSR DoMiniFrame     ; do a frame
    LDA btl_input       ; reload the controller state, now in A
    RTS
    
    
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  BattleDraw8x8Sprite  [$97E9 :: 0x317F9]
;;
;;  Draws a single 8x8 sprite.  Or rather, just copies it to shadow oam to be drawn next frame
;;
;;  input:  all 'btl8x8spr' variables
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

BattleDraw8x8Sprite:
    TYA
    PHA             ; backup Y (don't want to change it)
    
    LDA btl8x8spr_i ; get slot
    ASL A
    ASL A           ; *4 to use as index
    TAY
    
    LDA btl8x8spr_a ; copy values over
    STA oam_a, Y
    LDA btl8x8spr_t
    STA oam_t, Y
    LDA btl8x8spr_y
    STA oam_y, Y
    LDA btl8x8spr_x
    STA oam_x, Y
    
    PLA             ; restore Y
    TAY
    
    RTS

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  UpdateSprites_BattleFrame  [$980C :: 0x3181C]
;;
;;  Draws all battle sprites
;;  Then does a frame.
;;
;;  Note that if magic is being drawn, this routine will actually do 5 frames instead of 1, because
;;     it does 4 additional frames for the background flash animation
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

UpdateSprites_BattleFrame:
    LDA btlattackspr_nodraw
    BEQ :+                  ; If we are not to draw the attacksprite
      LDA btl_drawflagsA    ; clear all 'A' drawflags except for the 'dead' bits
      AND #$0F
      STA btl_drawflagsA
      
    ; This will update the dead bits in drawflagsA
    ;   and the stone bits in drawflagsB
  : LDA #$00
    STA btl_drawflags_tmp1     ; to hold dead bits
    STA btl_drawflags_tmp2     ; to hold stone bits
    TAX
    
  @ExtractDeadStoneBits:    ; loop 4 times, starting with character 3 down to character 0
      TXA                   ; subtract $40 to go to the prev character index
      SEC
      SBC #$40
      TAX
      
      LDA ch_ailments, X    ; get the ailments
      LSR A                 ; shift out dead bit
      ROL btl_drawflags_tmp1               ;   and into $88
      LSR A                 ; shift out stone bit
      ROL btl_drawflags_tmp2               ;   and into $89
      LSR A                 ; shift out poison
      LSR A                 ; ... dark
      LSR A                 ; ... stun
      LSR A                 ; and finally sleep
      ROL btl_drawflags_tmp3

      TXA                   ; Loop until we do character 0
      BNE @ExtractDeadStoneBits
    
    LDA btl_drawflagsA  ; move new dead bits into drawflagsA
    AND #$F0
    ORA btl_drawflags_tmp1
    STA btl_drawflagsA
    
    LDA btl_drawflagsB  ; move new stone bits into drawflagsB
    AND #$F0
    ORA btl_drawflags_tmp2
    STA btl_drawflagsB
    
    LDA btl_drawflagsC
    AND #$F0
    ORA btl_drawflags_tmp3
    STA btl_drawflagsC
    
    ;; JIGS - that is a much simpler way to handle sleep!
    
    LDA btl_drawflagsA  ; see if we 'draw battle cursor' flag is set
    AND #$10
    BEQ @DrawChars      ; if not, skip drawing the cursor, and jump ahead to drawing characters
    
      ; Draw the battle cursor
      LDX btlcursspr_x  ; apply X coord
      STX btl8x8spr_x
      STX btl8x8spr_x+1
      LDY btlcursspr_y  ; apply Y coord
      STY btl8x8spr_y
      STY btl8x8spr_y+1
      LDA #$00          ; put cursor in highest-priority slot
      STA btl8x8spr_i
      LDA #$03          ; use palette 3 for cursor
      STA btl8x8spr_a
      LDA #$F0          ; use tile $F0
      STA btl8x8spr_t
      JSR Draw16x8SpriteRow ; draw 16x16 sprite
      JSR Draw16x8SpriteRow
    
  @DrawChars:
    LDA #$04            ; draw char 0 at oam 4
    STA btl8x8spr_i
    LDA #$00
    JSR DrawCharacter
    
    LDA #$0A            ; draw char 1 at oam 10
    STA btl8x8spr_i
    LDA #$01
    JSR DrawCharacter
    
    LDA #$10            ; draw char 2 at oam 16
    STA btl8x8spr_i
    LDA #$02
    JSR DrawCharacter
    
    LDA #$16            ; draw char 3 at oam 22
    STA btl8x8spr_i
    LDA #$03
    JSR DrawCharacter
    
  ; Draw Weapon Swing graphic
    LDA btl_drawflagsA
    AND #$20                ; only draw the weapon graphic if the appropriate draw flag is set
    BEQ @DrawMagic
    
      LDA #$00                  ; draw in oam slot 0
      STA btl8x8spr_i
      LDA btlattackspr_x        ; set X,Y position
      STA btl8x8spr_x
      STA btl8x8spr_x+1
      LDA btlattackspr_y
      STA btl8x8spr_y
      STA btl8x8spr_y+1
      LDX btlattackspr_pose     ; get pose (0 or 8 depending on whether or not to flip the graphic)
      JSR DrawWeaponGraphicRow  ; draw 2 rows of tiles.  No need to set tile here, as DrawWeaponGraphicRow
      JSR DrawWeaponGraphicRow  ;    takes care of that
    
    LDA btlattackspr_hidell     ; See if we need to hide the lower-left tile
    BEQ @DrawMagic
      LDA #$FF                  ; if set hide the lower-left tile of the weapon sprite
      STA oam_y+8               ;   by moving of to the bottom of the screen.
      LDA #$00
      STA btlattackspr_hidell   ; then clear that flag
    
  @DrawMagic:
    LDA btl_drawflagsA
    AND #$40
    BEQ @Done
      JSR DoMagicFlash          ; flash the background color
      
      LDA #$00                  ; put magic sprite at oam slot 0
      STA btl8x8spr_i
      
      LDA btlattackspr_x        ; set X,Y coords
      STA btl8x8spr_x+1
      LDA btlattackspr_y
      STA btl8x8spr_y
      STA btl8x8spr_y+1
      
      LDA #$02                  ; use palette 2
      STA btl8x8spr_a
      
      LDA btlattackspr_t        ; set tile
      CLC
      ADC btlattackspr_pose     ; add pose to adjust for magic animation
      STA btl8x8spr_t
      
      JSR Draw16x8SpriteRow     ; then just draw the 16x16 sprite
      JSR Draw16x8SpriteRow
     
  @Done:
    JSR BattleFrame             ; Lastly, do a frame
    LDA btl_drawflagsA          ; and clear drawflags (other than 'dead' bits)
    AND #$0F
    STA btl_drawflagsA
    RTS

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  DrawCharacter  [$9910 :: 0x31920]
;;
;;  Draws the given character sprite (to shadow OAM)
;;
;;  input:   A = character ID to draw (0,1,2 or 3)
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

DrawCharacter_LUT:
    .byte $01, $02, $04, $08

DrawCharacter:
    TAX
    
    JSR PrepCharStatPointers   
    LDY #ch_battlestate - ch_stats
    LDA (CharStatsPointer), Y   
    AND #STATE_HIDDEN
    BEQ @DrawThem          ; then just draw as normal
      
      TXA ; restore Character ID
      TAY ; put in Y
      LDA lut_CharacterOAMOffset, Y   ; get character's OAM offset
      
      TAX                    ;  X = OAM offset as source index
      LDY #$00               ;  Y = loop counter
      LDA #$F0
     : STA oam, X            ; clear $18 bytes of shadow OAM  (6 sprites)
        INX                  ;
        INY                  ;
        CPY #$18    
        BNE :-
      RTS
      
    @DrawThem:
        
    TXA   ; restore character ID
    
    ;; back to original code ?? Might have moved things around a bit so the ID loads right

    TAY
    LDA btl_charattrib, Y
    STA btl8x8spr_a         ; assign attribute
    
    TXA                     ; JIGS - restore character ID again
    ASL A
    ASL A
    TAY                     ; *4 in Y.  Now it can be used as index for btl_chardraw stuff
    
    LDA btl_chardraw_x, Y   ; get X position
    STA btl8x8spr_x
    STA btl8x8spr_x+1       ; also store in temp as a backup
    
    LDA btl_chardraw_y, Y   ; Y position
    STA btl8x8spr_y
    STA btl8x8spr_y+1       ; also store in temp as a backup
    
    LDA DrawCharacter_LUT, X
    STA DrawCharTmp

   ; INX                     ; X is the char ID.  INX for purposes of below loop.    
   ; LDA #$01                ; This will effectively set temp ram to be 1<<X
   ; STA DrawCharTmp         ; This seems incredibly stupid though, as this could more easily be accomplished
   ; : ASL DrawCharTmp       ; with a LUT of:  01,02,04,08
   ;   DEX
   ;   BNE :-
   ; LSR DrawCharTmp               ; <- at this point, $68B6 = 1<<characterID
    
    LDA btl_drawflagsA      ; See if the character is dead
    ORA btl_drawflagsC              ; Or asleep!
    AND #$0F                ; 
    AND DrawCharTmp         ; 
    BEQ @DrawNotDead

    @DrawDead:     
    ;; JIGS - adding label
    
    ;;;;;;;;;;;;;;;
    ; If the character is to be drawn dead
    LDA #$1A
    CLC
    ADC btl_chardraw_gfxset, Y
    STA btl8x8spr_t             ; Tile is $1A + gfxset
    
    LDA btl_chardraw_x, Y       ;; JIGS - a better way to change positions
    SEC
    SBC #$08
    
    STA btl8x8spr_x             ; this is because the graphic changes from 16x24 to 24x16
    STA btl8x8spr_x+1           ;   so we have to move left a bit to accomidate
    
    LDA btl8x8spr_y             ; add 8 to Y
    CLC                         ;  again because 16x24 to 24x16
    ADC #$08
    STA btl8x8spr_y
    
    JSR DrawCharacter_DeadRow   ; Then draw 2 rows of tiles, and exit
    JMP DrawCharacter_DeadRow
    
  @DrawNotDead:
    ; Not dead, but see if they're stone
    LDA btl_drawflagsB  ; Again, not sure exactly what this holds, but low 4 bits seem to indicate
    AND #$0F            ;  which characters are stoned
    AND DrawCharTmp
    BEQ @DrawChar       ; if not stoned, just draw them
    
    ; otherwise, if they're stone
    LDA #$03
    STA btl8x8spr_a             ; overwrite their attribute value to use the stone palette
    LDA #CHARPOSE_CHEER        
    
    STA btl_chardraw_pose, Y    ; force them to be crouched
    LDA btl_chardraw_x, Y
    STA btl8x8spr_x             ; force them at X position $B0  (normal position)
    STA btl8x8spr_x+1
    
  @DrawChar:
    LDX btl_chardraw_pose, Y    ; X becomes our index for the pose TSA lut
    JSR @DrawPoseRow            ; draw 3 rows, properly incrementing after each one
    JSR @DrawPoseRow            ;   2 JSRs, and the 3rd just flows into @DrawPoseRow
    
  @DrawPoseRow:
    LDA btl_chardraw_gfxset, Y      ; get the graphic set
    CLC
    ADC lut_CharacterPoseTSA, X     ; add our pose TSA to it
    STA btl8x8spr_t                 ; that is the tile to draw
    INX                             ; inc TSA index so next pose row we'll use different tiles
    ; Flow continues into Draw16x8SpriteRow, which will draw the tiles
    
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Draw16x8SpriteRow  [$9998 :: 0x319A8]
;;
;;  Draws 2 8x8 tiles with given 'btl8x8spr' information
;;  NOTE that it actually resets the X coord to the backup X coord, and
;;    afterwards it increments the Y coord to point to the next row.
;;  It also will increment the tile ID
;;
;;  All of these things mean you can simply call it twice in a row to draw a normal
;;  16x16 sprite.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

Draw16x8SpriteRow:
    LDA btl8x8spr_x+1           ; restore backup X position
    STA btl8x8spr_x
    JSR BattleDraw8x8Sprite     ; draw 1 tile
    JSR DrawCharacter_NextTile  ; then increment, then draw another tile
    INC btl8x8spr_i             ; then increment again
    INC btl8x8spr_t
    LDA btl8x8spr_y             ; add 8 to Y to move to next row
    CLC
    ADC #$08
    STA btl8x8spr_y
    RTS                         ; and exit!
    
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  DrawCharacter_DeadRow  [$99B4 :: 0x319C4]
;;
;;  Support routine for DrawCharacter.
;;  Draws a row of tiles for the dead character graphic
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

DrawCharacter_DeadRow:
    LDA btl8x8spr_x+1           ; restore original X position for this row
    STA btl8x8spr_x
    
    JSR BattleDraw8x8Sprite     ; draw first tile
    JSR DrawCharacter_NextTile  ; then inc+draw 2 more
    JSR DrawCharacter_NextTile
    INC btl8x8spr_i             ; then inc oam pos and tile index
    INC btl8x8spr_t
    LDA btl8x8spr_y             ; lastly, add 8 to Y position so next time this is called
    CLC                         ;  it'll draw the next row
    ADC #$08
    STA btl8x8spr_y
    RTS
    
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  DrawCharacter_NextTile  [$99D3 :: 0x319E3]
;;
;;  Support routine for DrawCharacter.
;;  Increments tile positions and IDs, then draws another tile
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

DrawCharacter_NextTile:
    INC btl8x8spr_i     ; Increment the oam index
    INC btl8x8spr_t     ; increment the tile index to draw
    LDA btl8x8spr_x     ; add 8 to our drawing X position
    CLC
    ADC #$08
    STA btl8x8spr_x
    JMP BattleDraw8x8Sprite ; draw & exit

    
    
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  DrawWeaponGraphicRow  [$99E5 :: 0x319F5]
;;
;;  This is effectively the same idea as Draw16x8SpriteRow, but for weapon graphics.
;;  Like that other routine, it is designed to be called twice in a row to draw the
;;  full graphic.
;;
;;  On first entry, X should be 0 to draw the graphic normally
;;  or X should be 8 to draw the graphic flipped on the X axis
;;
;;  The weapon swing animation alternates between these two
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

DrawWeaponGraphicRow:
    LDA btl8x8spr_x+1               ; reset X coord to backup
    STA btl8x8spr_x
    
    LDA btlattackspr_t              ; get weapon graphic tile
    CLC
    ADC lut_WeaponSwingTSA, X       ; add TSA value
    STA btl8x8spr_t                 ; record it
    LDA lut_WeaponSwingTSA+4, X     ; get attribute & record it
    STA btl8x8spr_a
    JSR BattleDraw8x8Sprite         ; draw this tile
    
    INC btl8x8spr_i                 ; inc the oam position
    INX                             ; inc the TSA index
    LDA btl8x8spr_x                 ; add 8 to X position for next tile
    CLC
    ADC #$08
    STA btl8x8spr_x
    
    LDA btlattackspr_t              ; do all the same shit to draw another tile
    CLC
    ADC lut_WeaponSwingTSA, X
    STA btl8x8spr_t
    LDA lut_WeaponSwingTSA+4, X
    STA btl8x8spr_a
    JSR BattleDraw8x8Sprite
    
    LDA btl8x8spr_y                 ; add 8 to Y position
    CLC
    ADC #$08
    STA btl8x8spr_y
    INX                             ; inc TSA index
    INC btl8x8spr_i                 ; and oam position
    RTS

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  PrepAndGetBattleMainCommand  [$9A2C :: 0x31A3C]
;;
;;  Preps cursor position table, then calls MenuSelection_2x4
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

PrepAndGetBattleMainCommand:
    LDA #1
    STA gettingcommand
    LDY #$10
    : LDA lut_MainCombatBoxCursorPos-1, Y   ; -1 because Y is 1-based
      STA btlcurs_positions-1, Y
      DEY
      BNE :-
    JMP MenuSelection_2x4

    
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  SelectPlayerTarget  [$9A3A :: 0x31A4A]
;;
;;    Preps cursor positions for the party, then calls MenuSelection_2x4 to
;;  get the selection
;;
;;  input:  A = the current character.  (WHY?!?  Why can't the routine just use btlcmd_curchar directly?)
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

SelectPlayerTarget:
    STA btl_targetbacketup                 ; backup the current character
    
    LDY #$10                    ; Set the cursor positions
    : LDA lut_PlayerTargetCursorPos-1, Y
      STA btlcurs_positions-1, Y
      DEY
      BNE :-
      
    ; We have to push some of the cursor positions to the left
    ; Dead characters need to be pushed left 8 pixels
    ; And the current character needs to be move left 16 pixels (because they've stepped forward)
    LDA #$08                    ; first, move dead characters left 8
    STA btl_various_tmp+1                  ; $68B4 is temp to hold how much to push left
    
    
    LDA btl_drawflagsA
    AND #$01                    ; if char 0 is dead
    BEQ :+
      LDA #$00
      JSR @PushLeft             ; push char 0 left
      
  : LDA btl_drawflagsA          ; do same for char 1
    AND #$02
    BEQ :+
      LDA #$01
      JSR @PushLeft
      
  : LDA btl_drawflagsA          ; and char 2
    AND #$04
    BEQ :+
      LDA #$02
      JSR @PushLeft

  : LDA btl_drawflagsA          ; and char 3
    AND #$08
    BEQ :+
      LDA #$03
      JSR @PushLeft
    
  : JSR @PushCurChar            ; push the current character
    JMP MenuSelection_2x4       ; then do the menu logic!
    
  @PushCurChar:
    LDA #16                 ; current char gets pushed left 16 pixels
    STA btl_various_tmp+1
    LDA btl_targetbacketup               ; Get the current char from backup (why doesn't it just use btlcmd_curchar?)
    
  @PushLeft:
    STA btl_various_tmp            ; increment the character index.  WHY?!?! This doesn't make any sense and
    INC btl_various_tmp              ;   is a waste of code and time, and just complicates the below labels!
    LDA btl_various_tmp              ;   This is so stupid!!!
    
    ASL A                           ; *2 to use as index for the cursor positions.  Put in Y
    TAY
    LDA btlcurs_positions-2, Y      ; Get original X position (-2 because of the stupid INC above)
    SEC
    SBC btl_various_tmp+1                 ; Subtract the 'push' amount
    STA btlcurs_positions-2, Y      ; Store to this X position
    STA btlcurs_positions-2+8, Y    ;   and the mirrored X position
    
    RTS

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  SelectEnemyTarget  [$9AA4 :: 0x31AB4]
;;
;;  Allow the user to select an enemy target.
;;
;;  output: Y and btlcmd_target = enemy slot being targetted
;;                            A = 01 if A pressed to exit, or 02 if B pressed
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

SelectEnemyTarget_Magic:  
SelectEnemyTarget:  
    LDA btl_battletype
    CMP #3
    BCC :+
        JSR BattleClearVariableSprite   ; clear the cursor sprite
        JSR BattleFrame                 ; update PPU to refresh OAM
        LDY #$00                        ; output: Y = the target slot
        LDA #$01                        ; output: A = 1 ('A' button pressed)
        RTS
    
 :  JSR DrawRosterBox_L         ; and show enemy names instead
    INC btl_boxcount
    
    LDA #$00                    ; initialize/clear the cursor position
    STA btlcurs
    
    LDA btl_battletype          ; get the formation type and use it as an index to the jump table
    ASL A
    TAY
    LDA lut_EnemyTargetMenuJumpTbl, Y
    STA $88
    LDA lut_EnemyTargetMenuJumpTbl+1, Y
    STA $89
    JSR @DoJump
    JSR UndrawOneBox
    LDY btlcmd_target
    RTS
    
   @DoJump: 
    JMP ($0088)                 ; jump to appropriate target menu code
    



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  lut_EnemyTargetMenuJumpTbl  [$9AC5 :: 0x31AD5]

lut_EnemyTargetMenuJumpTbl:
  .WORD EnemyTargetMenu_9Small
  .WORD EnemyTargetMenu_4Large
  .WORD EnemyTargetMenu_Mix
;  .WORD EnemyTargetMenu_FiendChaos
;  .WORD EnemyTargetMenu_FiendChaos
  
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  EnemyTargetMenu_FiendChaos  [$9ACF :: 0x31ADF]
;;
;;    Same idea as the below EnemyTargetMenu_XXX routines, only this doesn't need to actually
;;  have a menu because there is only 1 target to select.  So instead... just provide
;;  the the only possible output
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;EnemyTargetMenu_FiendChaos:
;    JSR BattleClearVariableSprite   ; clear the cursor sprite
;    JSR BattleFrame                 ; update PPU to refresh OAM
;    LDY #$00                        ; output: Y = the target slot
;    LDA #$01                        ; output: A = 1 ('A' button pressed)
;    RTS

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  EnemyTargetMenu_9Small  [$9ADA :: 0x31AEA]
;;
;;  Calls EnemyTargetMenu, with some prep to configure it for the '9 small' formation
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

EnemyTargetMenu_9Small:
    ; Take the list of enemy slots and convert them to
    ;  legal cursor indexes.
    LDX #$00                        ; X is the cursor index and loop counter
  @TranslateLoop:
      LDY lut_EnemyIndex9Small, X   ; Y is the enemy slot index
      LDA btl_enemyIDs, Y           ; see if an enemy is in this slot
      CMP #$FF
      BEQ :+                        ; if there is, move enemy slot index to A
        TYA                         ;    otherwise, keep $FF in A (to indicate slot is empty)
    : STA btltmp_targetlist, X      ; store to targetlist
    
      INX
      CPX #$09
      BNE @TranslateLoop            ; loop for all 9 enemies.
    
    ; Then prep the btlcurs_positions buffer
    LDY #$00
  @CursPosLoop:
      LDA lut_Target9SmallCursorPos, Y  ; copy cursor positions from lut
      STA btlcurs_positions, Y          ; to RAM lut
      INY
      CPY #9*2                  ; 9 enemies, 2 bytes per slot
      BNE @CursPosLoop

    ; 8 is the max target slot (0-8)
    LDA #$08
    STA btlcurs_max
    JMP EnemyTargetMenu
    
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  EnemyTargetMenu_4Large  [$9B04 :: 0x31B14]
;;
;;    Calls EnemyTargetMenu, with some prep to configure it for the '4 large' formation.
;;  Identical to the 9Small version, but just using different tables and constants.
;;  See that routine for details, comments here are sparse.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

EnemyTargetMenu_4Large:
    LDX #$00
  @TranslateLoop:
      LDY lut_EnemyIndex4Large, X
      LDA btl_enemyIDs, Y
      CMP #$FF
      BEQ :+
        TYA
    : STA btltmp_targetlist, X
      INX                       ; sort of bugged.  There are only 4 entries in the 4large lut.  This reads
      CPX #$04                  ; 9 entries, which steps out of bounds, but the entries are never used so 
      BNE @TranslateLoop        ; it doesn't matter.
      
    LDY #$00
  @CursPosLoop:
      LDA lut_Target4LargeCursorPos, Y
      STA btlcurs_positions, Y
      INY
      CPY #9*2                  ; same deal -- should only be reading 4 entries, not 9
      BNE @CursPosLoop          ;   clearly this routine was copy/pasted
      
    LDA #$03
    STA btlcurs_max
    JMP EnemyTargetMenu

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  EnemyTargetMenu_Mix  [$9B2E :: 0x31B3E]
;;
;;    Same idea as 9Small/4Large routines above.  See them for details.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

EnemyTargetMenu_Mix:
    LDX #$00
  @TranslateLoop:
      LDY lut_EnemyIndexMix, X
      LDA btl_enemyIDs, Y
      CMP #$FF
      BEQ :+
        TYA
    : STA btltmp_targetlist, X
      INX
      CPX #$09                  ; <- should be 8
      BNE @TranslateLoop
    
    LDY #$00
  @CursPosLoop:
      LDA lut_TargetMixCursorPos, Y
      STA btlcurs_positions, Y
      INY
      CPY #9*2                  ; <- should be 8*2
      BNE @CursPosLoop
    
    LDA #$07
    STA btlcurs_max
  ; JMP EnemyTargetMenu         ; <- Flow into

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  EnemyTargetMenu  [$9B55 :: 0x31B65]
;;
;;  Do the menu logic for selecting an enemy target.
;;
;;  input:  btlcurs_max
;;          btlcurs             (assumed to be initalized to zero)
;;          btlcurs_positions   (assumed to be filled with cursor positions)
;;
;;  output: Y and btlcmd_target (enemy slot being targetted)
;;          A                   (01 if A pressed to exit, or 02 if B pressed)
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

EnemyTargetMenu:
    JSR BattleTarget_DownSub        ; move down to the first legal slot

  @MainLoop:
    LDA btl_drawflagsA              ; set the flag to show the cursor
    ORA #$10
    STA btl_drawflagsA
    
    LDA btlcurs                     ; set the X,Y coord for the cursor
    ASL A
    TAY
    LDA btlcurs_positions, Y
    STA btlcursspr_x
    LDA btlcurs_positions+1, Y
    STA btlcursspr_y
    
    JSR UpdateSprites_BattleFrame   ; do frame to draw the cursor
    JSR DoFrame_WithInput           ; do ANOTHER frame to get input
    
    CMP btlinput_prevstate
    BNE :+                          ; if no change in input...
      JSR UpdateInputDelayCounter
      BEQ @MainLoop                 ; ... update input delay, and loop if input delay still in effect
      JMP @CheckInput               ; and process input
      
  : LDA #$05                        ; there was a change in input, so reset the input delay counter
    STA inputdelaycounter           ;    to a slightly longer time than usual

  @CheckInput:
    LDA btl_input                   ; record state as prev state
    STA btlinput_prevstate
    
    LDA btl_input
    AND #$03
    BEQ :+                          ; see if A or B were pressed.  If yes...
      PHA
      JSR BattleClearVariableSprite ; clear the cursor sprite in shadow OAM
      JSR BattleFrame               ; do a frame to clear it in the PPU
      PLA                           ; and the A/B button state in A, and exit!
      RTS
    
  : JSR @ProcessDPad                ; Otherwise, A/B not pressed, check the DPad
    JMP @MainLoop                   ; Rinse, repeat
    
  @ProcessDPad:
    LDA btl_input           ; check the DPad
    AND #$F0
    CMP #$20
    BEQ BattleTarget_Down   ; see if Down pressed
    CMP #$10
    BEQ BattleTarget_Up     ; see if Up pressed
    RTS
    
   
    
    
    
    
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  BattleTarget_Down    [$9BBB :: 0x31BCB]
;;  BattleTarget_DownSub [$9BCB :: 0x31BDB]
;;
;;  Chooses the next legal battle target.
;;
;;    The 'Sub' entry point is for the first target selection.  It cuts in at the target
;;  verification code.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

BattleTarget_Down:
    LDA btlcurs             ; see if the cursor is at our max
    CMP btlcurs_max
    BNE :+                  ; if it's at the max, replace with -1 (so we INC it to zero)
      LDA #-1
      STA btlcurs
  : INC btlcurs             ; inc to next slot

BattleTarget_DownSub:
    LDY btlcurs                 ; put the cursor in Y
    LDA btltmp_targetlist, Y    ; get the target slot
    CMP #$FF
    BEQ BattleTarget_Down       ; if it's empty, keep moving down until we find a non-empty slot
    
    STA btlcmd_target           ; once we have a valid slot, store it in ?'btltmp_target'?
    RTS
    
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  BattleTarget_Up    [$9BD9 :: 0x31BE9]
;;
;;  Chooses the next legal battle target.
;;
;;    The 'Sub' entry point is for the first target selection.  It cuts in at the target
;;  verification code.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    
BattleTarget_Up:
    LDA btlcurs             ; see if the cursor is at zero
    BNE :+
      LDA btlcurs_max       ; if it is, set it to max+1
      STA btlcurs           ;  (+1 because we'll be DEC'ing it in a second)
      INC btlcurs
      
  : DEC btlcurs             ; DEC to move to previous slot
    LDY btlcurs
    LDA btltmp_targetlist, Y; Check the enemy slot, see if it's empty
    CMP #$FF
    BEQ BattleTarget_Up     ; if it is, keep moving up
    STA btlcmd_target       ; otherwise, if it's not empty, record the target
    RTS                     ;   and exit
    
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  MenuSelection_Equipment  [$9BF8 :: 0x31C08]
;;
;;    Just calls MenuSelection_2x4 with the Equipment menu cursor positions.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

MenuSelection_Equipment:
    LDY #$10
    : LDA lut_EquipmentCursorPos-1, Y
      STA btlcurs_positions-1, Y
      DEY
      BNE :-
    JMP MenuSelection_2x4

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  MenuSelection_Item  [$9C06 :: 0x31C16]
;;
;;    Just calls MenuSelection_2x4 with the Item menu cursor positions.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

MenuSelection_Item:
    LDY #$10
    : LDA lut_ItemCursorPos-1, Y   ; copy over the cursor positions for
      STA btlcurs_positions-1, Y    ;  the Item menu
      DEY
      BNE :-
    ;JMP MenuSelection_2x4           ; and do the logic
    
    LDA #0
    STA item_pageswap
    STA tmp
    STA btlcurs_x
    STA btlcurs_y
    STA battle_item
    
   @RedrawList:  
    LDA item_pageswap
    LDX #12
    JSR MultiplyXA       
    STA tmp
    TAX                  

    LDA #01
    STA menustall
    STA bigstr_buf+11, X
    STA bigstr_buf+23, X
    STA bigstr_buf+35, X ; Items are spaced 13 bytes apart, so put the line break on the first three 
    LDA #0 
    STA bigstr_buf+47, X ; and the null terminator on the fourth, every time the list is moved

    LDA #<(bigstr_buf)
    CLC
    ADC tmp             ; add the list offset
    STA text_ptr
    LDA #>(bigstr_buf)
    ADC #0
    STA text_ptr+1
    
    LDA #03
    STA dest_x
    LDA #21
    STA dest_y
    
    JSR DrawComplexString 
    
  @MainLoop:
    JSR SharedMenuCode_A
    
    LDA btlcurs_positions, Y
    STA btlcursspr_x
    LDA btlcurs_positions+1, Y
    STA btlcursspr_y
    
    JSR UpdateSprites_BattleFrame   ; Update sprites & do a frame
    JSR DoFrame_WithInput           ; Do *ANOTHER* frame and get input in A
    CMP btlinput_prevstate
    BNE :+                          ; If there was no change in input...
      JSR UpdateInputDelayCounter   ; update delay counter
      BEQ @MainLoop                 ; not accepting input, repeat from main loop
      JMP @CheckButtons             ; then check buttons
      
  : LDA #$05                        ; if there was a change of input, reset the delay counter (make it a little
    STA inputdelaycounter           ;   longer than normal), and then check buttons
    
  @CheckButtons:
    LDA btl_input                   ; record current input as previous input
    STA btlinput_prevstate
    
    LDA btl_input
    AND #$03
    BEQ :+                          ; see if A or B are pressed.  If they are...
      PHA                           ; push A/B state
      JSR BattleClearVariableSprite ; erase the cursor sprite (in shadow oam)
      JSR BattleFrame               ; redraw the screen (to erase it in the PPU)
      PLA
      RTS                           ; exit!
    
  : JSR @MoveCursor                 ; if A/B are not pressed, then check arrow buttons to move the cursor
    JMP @MainLoop                   ; and repeat
    
  @MoveCursor:
    LDA btl_input
    AND #$F0                        ; isolate arrow buttons
    CMP #$20
    BEQ @Cursor_Down
    CMP #$10
    BEQ @Cursor_Up
    RTS
  
  @Cursor_Down:    
    LDA battle_item          ; check the item position
    CMP #9                   ; if its over 9, do not increase it any further
    BCS :+
      INC battle_item

  : LDA btlcurs_y            ; if cursor_y is over 3, stop increasing it, so it stays at the bottom of the list
    CMP #3
    BCC :+
        LDA item_pageswap    ; check item_pageswap, and if its over 6, stop increasing it
        CMP #6               ; each increase shifts the bigstr_buf draw position
        BCS @Return
        INC item_pageswap
        PLA
        PLA
        JMP @RedrawList      ; re-draw the whole thing
        
  : INC btlcurs_y    
    RTS
  @Cursor_Up:
    LDA battle_item
    BEQ :+
    
      DEC battle_item
  
  : LDA btlcurs_y
    BNE :+
        LDA item_pageswap
        BEQ @Return
        DEC item_pageswap
        PLA
        PLA
        JMP @RedrawList
    
  : DEC btlcurs_y
  @Return:  
    RTS  
  



SharedMenuCode_A:
    LDA btl_drawflagsA
    ORA #$10
    STA btl_drawflagsA
    
    LDA btlcurs_y
    AND #$03
    ASL A
    STA btl_various_tmp+1
    LDA btlcurs_x
    AND #01
    ASL A
    ASL A
    ASL A
    CLC
    ADC btl_various_tmp+1           ; Y*2 + X*8 -- putting the cursor positions in COL-major order instead of row major
    TAY
    RTS    
    
    

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  MenuSelection_Magic  [$9C14 :: 0x31C24]
;;
;;    Same idea as MenuSelection_2x4, but rewritten as it is more complex than
;;  a basic 2x4 menu.  See MenuSelection_2x4 for input/output and other details.
;;
;;  additional output:   $6AF8 = magic page
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

MenuSelection_Magic:
    LDA #$00
    STA DrawBattleMagicBox_toporbottom     ; set page number to 0 (draw top page of magic box)
    
    JSR DrawBattleMagicBox_L    ; draw it!
    INC btl_boxcount
    
@MenuSelection:
    LDA #$00
    STA btlcurs_x
    STA btlcurs_y
    
  @MainLoop:
    LDA btl_drawflagsA
    ORA #$10
    STA btl_drawflagsA
    
    LDA btlcurs_y
    AND #$03
    ASL A
    STA btl_various_tmp+1
    LDA btlcurs_x
    ASL A
    ASL A
    ASL A
    CLC
    ADC btl_various_tmp+1           ; Y*2 + X*8 -- putting the cursor positions in COL-major order instead of row major
    TAY
    
    LDA lut_MagicCursorPos, Y
    STA btlcursspr_x
    LDA lut_MagicCursorPos+1, Y
    STA btlcursspr_y
    
    JSR UpdateSprites_BattleFrame   ; Do a frame to update the cursor
   @FrameLoop: 
    JSR DoFrame_WithInput        
    BEQ @FrameLoop
    
    CMP btlinput_prevstate          ; See if there was any change in input
    BNE @InputChanged               ; if yes, jump ahead to process it
      JSR UpdateInputDelayCounter   ; if no, update input delay to see if we should ignore input or not
      BEQ @MainLoop                 ; if we're to ignore it, just loop
      LDA #$03
      STA inputdelaycounter         ; otherwise, reset the counter and proceed to process it
      JMP :+
  @InputChanged:    ;; JIGS - 5 was just too slow for me...
      LDA #$04 ;05                  ; if input changed, reset the counter to a higher value
      STA inputdelaycounter         ;   then process the input
      
  : LDA btl_input                   ; set prev state
    STA btlinput_prevstate
    
    LDA btl_input
    AND #$03                        ; see if A/B were pressed
    BEQ :+                          ; if yes....
      PHA                           ; push A/B state
      
      LDA btlcurs_y                 ; clip X,Y cursor positions
      AND #$03
      STA btlcurs_y
      LDA btlcurs_x
      AND #$03
      STA btlcurs_x
      
      JSR BattleClearVariableSprite ; hide the cursor sprite
      JSR BattleFrame               ; do a frame to hide it from view
      
      LDY btlcurs_y                 ; put Y cursor pos in Y (why?  haha)
      PLA                           ; restore A/B state
      RTS
    
    ; jumps here if A/B were not pressed
  : JSR @CheckDPad
    JMP @MainLoop
    
  @CheckDPad:
    LDA btl_input
    AND #$F0
    CMP #$80
    BEQ @Cursor_Right
    CMP #$40
    BEQ @Cursor_Left
    CMP #$20
    BEQ @Cursor_Down
    CMP #$10
    BEQ @Cursor_Up
    RTS
    
  @Cursor_Down:
    LDA btlcurs_y
    AND #$03
    CMP #$03                    ; see if it's at the bottom of the page
    BNE @NormalMove_Down        ; if not, do a normal move
    LDA DrawBattleMagicBox_toporbottom                   ; otherwise, check the page
    BEQ :+
      RTS                       ; page 1 = do nothing
  : INC DrawBattleMagicBox_toporbottom                   ; page 0 = inc to page 1
    JSR UndrawOneBox
    JSR DrawBattleMagicBox_L    ; draw the page 1 magic box
    INC btl_boxcount
  @NormalMove_Down:
    INC btlcurs_y
    RTS

  @Cursor_Up:
    LDA btlcurs_y
    AND #$03                    ; top row of page?
    BNE @NormalMove_Up          ; no?  then normal move
    LDA DrawBattleMagicBox_toporbottom                   ; yes?  check page
    CMP #$01
    BEQ :+
      RTS                       ; page 0?  exit
  : DEC DrawBattleMagicBox_toporbottom                   ; page 1?  move to page 0, and redraw it
    JSR UndrawOneBox
    JSR DrawBattleMagicBox_L
    INC btl_boxcount
  @NormalMove_Up:
    DEC btlcurs_y
    RTS
    
  @Cursor_Left:
    LDA btlcurs_x
    BNE :+                  ; are we in the left column?  If yes..
      LDA #$03              ; change to 3, so we'll DEC it to 2 (right column)
      STA btlcurs_x
  : DEC btlcurs_x
    RTS

  @Cursor_Right:
    LDA btlcurs_x
    CMP #$02
    BNE :+              ; if in right column
      LDA #-1           ; change to -1 (so we INC to zero)
      STA btlcurs_x
  : INC btlcurs_x
    RTS
    
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  MenuSelection_2x4  [$9D0E :: 0x31D1E]
;;
;;    The the menu logic for selecting items on a 2x4 menu.  This is used by the
;;  main combat menu (FIGHT/RUN/MAGIC/etc), but also for other menus (like the
;;  Item menu).
;;
;;    Menus can use fewer than 2x4 items as long as the cursor entries exist
;;  (for smaller menus some entries will be mirrored).
;;
;;  input:   btlcurs_positions should be filled with 8 entries (in col major order)
;;
;;  output:
;;                    A = A/B button state (bit 0=A pressed... bit 1=B pressed)
;;      Y and btlcurs_y = row of item selected (0-3)
;;            btlcurs_x = column of item selected (0=left column, 1="Run" column)
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

MenuSelection_2x4:
    LDA #$00
    STA btlcurs_x
    STA btlcurs_y
    
  @MainLoop:
    JSR SharedMenuCode_A
    
    LDA btlcurs_positions, Y
    STA btlcursspr_x
    LDA btlcurs_positions+1, Y
    STA btlcursspr_y
    
    JSR UpdateSprites_BattleFrame   ; Update sprites & do a frame
    JSR DoFrame_WithInput        
    CMP btlinput_prevstate
    BNE :+                          ; If there was no change in input...
      JSR UpdateInputDelayCounter   ; update delay counter
      BEQ @MainLoop                 ; not accepting input, repeat from main loop
      JMP @CheckButtons             ; then check buttons
      
  : LDA #$05                        ; if there was a change of input, reset the delay counter (make it a little
    STA inputdelaycounter           ;   longer than normal), and then check buttons
    
  @CheckButtons:
    LDA btl_input                   ; record current input as previous input
    STA btlinput_prevstate
    
    LDA btl_input
    AND #$03
    BEQ :+                          ; see if A or B are pressed.  If they are...
      PHA                           ; push A/B state
      
      LDA btlcurs_y                 ; clip/wrap the cursor so it's within valid range.
      AND #$03
      STA btlcurs_y
      LDA btlcurs_x
      AND #$01
      STA btlcurs_x
      
      JSR BattleClearVariableSprite ; erase the cursor sprite (in shadow oam)
      JSR BattleFrame               ; redraw the screen (to erase it in the PPU)
      
      LDY btlcurs_y                 ; put cursor selection in Y (though Fight/Run column selection is still in btlcurs_x
      PLA                           ; put A/B button state in A
      RTS                           ; exit!
    
  : LDA btl_input
    AND #$08
    BEQ :+
    
    ;; Start was pressed!
    LDA gettingcommand
    BEQ :+                          ; if not on command box, do nothing
    JMP SetAutoBattle
    
  : LDA btl_input
    AND #$04
    BEQ :+  
    ;; Select was pressed!
    LDA gettingcommand
    BEQ :+
    JMP SetAutoRun
  
  : JSR @MoveCursor                 ; if A/B are not pressed, then check arrow buttons to move the cursor
    JMP @MainLoop                   ; and repeat
    
  @MoveCursor:
    LDA btl_input
    AND #$F0                        ; isolate arrow buttons
    CMP #$80
    BEQ @Cursor_Right               ; branch around depending on which button is pressed
    CMP #$40
    BEQ @Cursor_Left
    CMP #$20
    BEQ @Cursor_Down
    CMP #$10
    BEQ @Cursor_Up
    RTS
  
  @Cursor_Down:                     ; these are all pretty self explanitory
    INC btlcurs_y
    RTS
  @Cursor_Up:
    DEC btlcurs_y
    RTS
  @Cursor_Left:
    DEC btlcurs_x
    RTS
  @Cursor_Right:
    INC btlcurs_x
    RTS
    
    
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Set Natural Pose  [$9DB2 :: 0x31DC2]
;;
;;  input:   A = ID of character to do (0-3)
;;
;;  output:  Desired character's 'btl_chardraw_pose' value
;;           A will also contain the pose value
;;
;;  This routine will check to see if the character should be standing (pose $00)
;;    or crouching (pose $18) in their natural pose.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

SetNaturalPose:
    ASL A
    ASL A
    TAX                         ; X=%0000xx00  where 'xx' is character ID
    ASL A                       
    ASL A                       
    ASL A                       
    ASL A                       ; Y=%xx000000  where 'xx' is character ID
    TAY                         ;   Y can now be used as an index for character stats
    
    LDA ch_ailments, Y          ; check this character's ailment
    AND #AIL_DEAD
    BEQ :+                      ; if they're dead
      STA ch_ailments, Y        ;; JIGS - if they're dead, it should be their ONLY ailment!
      LDA #$00                  ; zero their hit points (seems strange to do this here, but whatever)
      STA ch_curhp, Y
      STA ch_curhp+1, Y
      
  : LDA ch_ailments, Y          ;; JIGS - same goes for stone! But leave their HP alone
    AND #AIL_STONE        
    BEQ :+ 
       STA ch_ailments, Y        
      
  : LDA ch_ailments, Y          ; get ailments again
    AND #(AIL_POISON | AIL_STUN )
    BEQ @CheckHP                ; if they are... then they are crouching
    
  @DoCrouching:
    LDA #CHARPOSE_CROUCH                
    STA btl_chardraw_pose, X
    RTS

    
@CheckHP:                       ; if they don't have poison/stun/sleep, we need to check their HP
    LDA ch_maxhp, Y             ; move max HP to $68B3,4
    STA btl_various_tmp
    LDA ch_maxhp+1, Y
    STA btl_various_tmp+1
    
    LSR btl_various_tmp+1       ; divide it by 4 (25% of max HP)
    ROR btl_various_tmp
    LSR btl_various_tmp+1
    ROR btl_various_tmp
    
    LDA ch_curhp+1, Y           ; if the high byte of their HP is nonzero, they have over 256, which is
    BNE @DoStanding             ;   definitely more than 25% max, so DoStanding

    LDA ch_curhp, Y             ; otherwise, compare low byte of HP to low byte of 25%
    CMP btl_various_tmp        
    BCC @DoCrouching            ; if cur HP is less, they are crouching

@DoStanding:                    ; otherwise, they're standing
    LDA #CHARPOSE_STAND
    STA btl_chardraw_pose, X
    RTS

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  CharWalkAnimationLeft  [$9E01 :: 0x31E11]
;;
;;  A = the character to animate (0-3)
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

CharWalkAnimationLeft:
    PHA         ; push char index
    JSR UnhideCharacter                 
    LDA #-2     ; negative directional value = move left
    BNE :+      ;  <-- FLOW:  This label is in CharWalkAnimationRight

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  CharWalkAnimationRight  [$9E06 :: 0x31E16]
;;
;;  A = the character to animate (0-3)
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

CharWalkAnimationRight:
    PHA         ; push char index
    LDA #2      ; positive directional value = move right
    
:   STA btl_walkdirection       ; 68AB = walk direction
    PLA
    STA btl_animatingchar
    JSR CharacterWalkAnimation
    LDA btl_animatingchar
    JSR SetNaturalPose          ; after animation is complete, revert this character to their natural pose
    JMP UpdateSprites_TwoFrames ; update, then return

UnhideCharacter:    
    JSR PrepCharStatPointers
    LDY #ch_battlestate - ch_stats
    LDA (CharStatsPointer), Y
    AND #STATE_HIDDEN               ; check only for Hidden state
    BNE UnhideCharacter_Save         
    RTS    

UnhideCharacter_Save:    
    LDY #ch_battlestate - ch_stats
    LDA (CharStatsPointer), Y
    AND #~STATE_HIDDEN          ; keep Guard state if it exists, as well as regen potency and turns
    STA (CharStatsPointer), Y
    LDA #01
    STA Hidden
    RTS
    
HideCharacter_Save:
    LDY #ch_battlestate - ch_stats
    LDA (CharStatsPointer), Y
    ORA #STATE_HIDDEN
    STA (CharStatsPointer), Y
    LDA #0
    STA Hidden
    RTS
    
HideCharacter:
    PHA        
    LDA Hidden              ; if general Hidden variable is 1, someone needs to rehide...
    BEQ :+

        LDA btl_animatingchar 
        JSR PrepCharStatPointers
        JSR HideCharacter_Save
        JSR UpdateSprites_BattleFrame ; necessary, because the 4th character won't re-hide before the turn starts until sprites are updated...

  : PLA
    RTS    

AttackerToAnimatedChar:    
    LDA btl_attacker
    AND #$03
    STA btl_animatingchar  
    RTS
    
    
    
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  CharacterWalkAnimation  [$9E1C :: 0x31E2C]
;;
;;  input:
;;   btl_animatingchar = character index to animate (0-3)
;;               $68AB = direction/speed (pixels per 2 frames)
;;                       negative = move left, positive = move right
;;
;;    This routine does the walk forward and walk back animation for the
;;  characters.
;;
;;    This routine takes 16 frames to complete.
;;
;;    For whatever weird reason, this routine moves the character every
;;  OTHER frame rather than every frame.  Which is especially weird since
;;  the supplied speed is 2 pixels (either -2 to walk left or 2 to walk right).
;;  The game could have very easily made animation smoother by halving the
;;  walk speed and updating every frame.  Weird weird.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

CharacterWalkAnimation:
    LDA #$08
    STA btl_walkloopctr                  ; loop down counter -- looping 8 times for 16 total frames
    
  @Loop:
      LDA btl_animatingchar     ; get the character index
      ASL A
      ASL A
      TAX                       ; index for btl_chardraw buffer
      
      LDA btl_walkloopctr
      AND #$02                  ; toggle animation pose every 4 frames
      ASL A                     ; switch between pose '0' (stand) and pose '4' (walk)
      STA btl_chardraw_pose, X
      
      LDA btl_chardraw_x, X     ; add the directional value to the X position
      CLC
      ADC btl_walkdirection
      STA btl_chardraw_x, X
      
      JSR UpdateSprites_TwoFrames   ; update sprites, do 2 frames of animation
      
      DEC btl_walkloopctr
      BNE @Loop                 ; keep looping
    RTS
    
    
PartyWalkAnimation:
    LDA #$2A
    STA btl_walkloopctr                  ; loop down counter -- looping 8 times for 16 total frames
    LDA #-4
    STA btl_walkdirection

  @Loop:
    LDA #0
    STA btl_animatingchar
  @CharacterLoop:
      LDA btl_animatingchar
      JSR PrepCharStatPointers
      
      LDY # ch_ailments - ch_stats  ; See if this character has any ailment that would prevent them from moving
      LDA (CharStatsPointer), Y   
      AND # AIL_DEAD | AIL_STONE | AIL_SLEEP
      BNE :+
 
      LDA btl_animatingchar
      ASL A
      ASL A
      TAX                       ; index for btl_chardraw buffer
      
      LDA btl_walkloopctr
      AND #$02                  ; toggle animation pose every 4 frames
      ASL A                     ; switch between pose '0' (stand) and pose '4' (walk)
      STA btl_chardraw_pose, X
      
      LDA btl_chardraw_x, X     ; add the directional value to the X position
      CLC
      ADC btl_walkdirection
      STA btl_chardraw_x, X
      
    : INC btl_animatingchar
      LDA btl_animatingchar
      CMP #4
      BCC @CharacterLoop
    
      JSR UpdateSprites_TwoFrames   ; update sprites, do 2 frames of animation
      
      DEC btl_walkloopctr
      LDA btl_walkloopctr
      CMP #$4                       ; when there's 4 boopers left, start fading out
      BCS @Loop
      
      JSR FadeOutOneShade           ; fade out one shade
      JSR DoFrame_UpdatePalette
      
      LDA btl_walkloopctr
      BNE @Loop
    RTS    
    
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  PlayFanfareAndCheer    [$9E43 :: 0x31E53]
;;
;;    Plays the "you won the battle" fanfare music and do the animation for the
;;  party cheering over their accomplishment.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

PlayFanfareAndCheer:
    ;; JIGS - added this:
    LDA #0
    STA $4015             ; silence APU
    STA $5015           ; and silence the MMC5 APU. (JIGS)
    JSR WaitForVBlank_L
    ;; I have no idea how to stop the fanfare from starting with a noise crunchy sound...
    ;; but this seems to do the trick?

    JSR UnhideAllCharacters
    INC btl_boxcount
    JSR UndrawOneBox            ; undraw the player name and HP box

    LDA #$53                    ; play fanfare music
    STA music_track
    STA btl_followupmusic
    
    LDA battleswon
    CMP #$FF
    BEQ :+
       INC battleswon
    
  : LDA #$40                    ; loop counter
    STA btl_walkloopctr
  @Loop:
      LDA btl_walkloopctr
      AND #(CHARPOSE_CHEER >> 1)    ; alternate between CHEER/STAND poses every 8 loop iterations
      ASL A
      STA btl_chardraw_pose+$0
      STA btl_chardraw_pose+$4
      STA btl_chardraw_pose+$8
      STA btl_chardraw_pose+$C
      
      JSR UpdateSprites_TwoFrames   ; draw!
      
      DEC btl_walkloopctr
      BNE @Loop
      
    JSR SetAllNaturalPose           ; afterwards, give everyone their natural pose
    JMP UpdateSprites_TwoFrames     ; draw, and exit

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  WalkForwardAndStrike    [$9E70 :: 0x31E80]
;;
;;    Does the animation to walk a character forward, swing their weapon (or cast their spell),
;;  then walk back to their original position.
;;
;;  input:
;;      A = the character to animate (0-3)
;;      X = the attack sprite graphic
;;      Y = 0 is swinging with a weapon, 1 if casting a magic spell
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

WalkForwardAndStrike:
    STA btl_animatingchar       ; A = character to animate
    STX btlattackspr_gfx        ; X = attack sprite graphic
    STY btlattackspr_wepmag     ; Y = 0,1 to choose between weapon/magic

    ;; JIGS - adding: - note that after this, the character does not go back into hiding!
    JSR UnhideCharacter
    LDA #0
    STA Hidden
    STA Woosh ;; JIGS - ... it does a magic thing!
    
    LDA #-2
    STA btl_walkdirection                  ; walk the character to the left
    
    JSR CharacterWalkAnimation
    
    LDA PlayMagicSound
    BEQ :+
    LDA btlmag_magicsource
    BNE :+                          ; if zero, it's magic... so...
      LDA #$00                      ; ...play magic sfx.  
      STA PlayMagicSound
      JSR PlayBattleSFX             ;  
    
  : LDA #$08                    ; 6AA8 is the loop counter (loop 8 times), alternates between 
    STA btl_walkloopctr                   ;   animation frames every 2 iterations.
    
  @DoAttackAnimationLoop:
    LDA btl_drawflagsA                  ; set the "draw weapon" draw flag
    ORA #$20                            ;  note:  for magic, this is changed in PrepAttackSprite call below
    STA btl_drawflagsA
    
    LDA btl_walkloopctr
    AND #$02                            ; every other frame...
    BEQ @BFrame
        JSR PrepAttackSprite_AFrame     ; alternate between AFrame of animation
        ; otherwise, flow into magic processing
        JMP :+
    @BFrame:
        JSR PrepAttackSprite_BFrame     ; ... and BFrame of animation
    : JSR UpdateSprites_TwoFrames       ; redraw sprites on screen, do 2 frames.
    
      DEC btl_walkloopctr
      BNE @DoAttackAnimationLoop        ; loop until counter expires
    
    
    JSR BattleClearVariableSprite       ; Finally, once attack animation complete, clear the weapon/magic sprite
    JSR BattleFrame                     ; Do another frame to make sure it's erased  (seems silly to do that here... since
                                        ;   we do another frame shortly...)

    LDA btl_animatingchar
    ASL A
    ASL A
    TAX
    LDA #CHARPOSE_STAND
    STA btl_chardraw_pose, X            ; reset the character's pose to 'standing'
    JSR UpdateSprites_TwoFrames         ; then update sprites and do 2 frames.
    
    LDA #2
    STA btl_walkdirection
    JSR CharacterWalkAnimation          ; Do the animation to walk the character back to the right
    
    LDA btl_animatingchar
    JSR SetNaturalPose                  ; reset character back to their natural pose
  ; JSR BattleClearVariableSprite       ; clear the wep/mag sprite (again?  Pointless to do here)
  ;; JIGS - ^
  ; JMP UpdateSprites_TwoFrames         ; <- flow into.  Update sprites and do 2 frames
    
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  UpdateSprites_TwoFrames [$9ECB :: 0x31EDB]
;;
;;    Same as UpdateSprites_BattleFrame, but waits an additional frame
;;  (to slow down animations a bit?)
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

UpdateSprites_TwoFrames:
    JSR UpdateSprites_BattleFrame
    JMP BattleFrame

    
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  PrepAttackSprite_AFrame [$9ED1 :: 0x31EE1]
;;
;;    Weapon and Magic attacks consist of 2 frames of animation.  This routine will
;;  prep the 'AFrame' of animation.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

PrepAttackSprite_AFrame:
    LDA btlattackspr_wepmag                 ; see if this is a weapon or a magic graphic
    BEQ __PrepAttackSprite_Weapon_AFrame    ; if weapon, jump ahead to weapon processing
                                            ; otherwise, flow into magic processing
    
    ;; [$9ED6 :: 0x31EE6]
    ;;  Support routine:  Sets the btlattackspr to the 'A' frame for magic    
__PrepAttackSprite_Magic_AFrame:
    JSR __PrepAttackSprite_Weapon_AFrame    ; magic AFrame is the same as weapon AFrame, but with some changes:
    LDA #CHARPOSE_CHEER
    STA btl_chardraw_pose, X                ; player is cheering rather than swinging
    
   ; LDA btlattackspr_gfx                    ; (moving graphic over to _t is unnecessary here, as this was
   ; STA btlattackspr_t                      ;  already done in the WeaponAFrame)
    
    LDA btlattackspr_gfx ; check what kind of graphic it is
    CMP #$E8             ; if its the little flare from the hands, don't move the sprite
    BEQ :+
    CMP #$E0             ; if its the "dust" sprite, float it up
    BEQ @MagicSpriteUp
    
    @MagicSpriteLeft:    
    LDA btlattackspr_x  ; load the X spot
    SEC                 ; set carry
    SBC Woosh           ; subtract Woosh variable
    STA btlattackspr_x  ; save X spot
    JMP @Woosh
    
    @MagicSpriteUp:
    LDA btl_animatingchar
    BEQ :+             ; skip moving the sprite up if the caster is in the top slot (no room)
    
    LDA btlattackspr_y ; load Y spot, to make the magic float upwards
    SEC
    SBC Woosh
    STA btlattackspr_y
    
    @Woosh:
    LDA Woosh           ; Load Woosh variable
    CLC                 ; 
    ADC #02             ; Add 2
    STA Woosh           ; and save... so every 2 frames, the magic moves 2 pixels up or left
    
  : LDA btl_drawflagsA                      ; turn on the magic drawflag bit, and turn off the weapon
    ORA #$40                                ; drawflag bit.
    AND #~$20                               ; this will cause the BG color to flash.
    STA btl_drawflagsA
    RTS
    
    ;; [$9EEF :: 0x31EFF]
    ;;  Support routine:  Sets the btlattackspr to the 'A' frame for weapons    
__PrepAttackSprite_Weapon_AFrame:
    LDA btl_animatingchar           ; use character*4 as index
    ASL A
    ASL A
    TAX
    
    LDA #CHARPOSE_ATTACK_F
    STA btl_chardraw_pose, X        ; set the pose to forward attack
    
    LDA btl_chardraw_x, X           ; weapon graphic is $10 pixels left of the char graphic
    SEC
    SBC #$10
    STA btlattackspr_x
    
    LDA btl_chardraw_y, X           ; weapon graphic is at same Y position as char
    STA btlattackspr_y
    
    LDA btlattackspr_gfx            ; Set the tile to the appropriate graphic
    STA btlattackspr_t              ; And set the pose to scene 0
    LDA #$00
    STA btlattackspr_pose
    RTS
    
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  PrepAttackSprite_BFrame [$9F15 :: 0x31F25]
;;
;;    Weapon and Magic attacks consist of 2 frames of animation.  This routine will
;;  prep the 'BFrame' of animation.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

PrepAttackSprite_BFrame:
    LDA btlattackspr_wepmag                 ; weapon or magic?
    BEQ :+                                  ; if magic...
      JSR __PrepAttackSprite_Magic_AFrame   ; Same setup as AFrame
      LDA #$04
      STA btlattackspr_pose                 ; just the pose is different.
      RTS

  : LDA btl_animatingchar       ; BFrame for weapons is different.  The weapon has to move
    ASL A                       ;   back behind the player's head.
    ASL A
    TAX                         ; X=4*char index
    
    LDA btl_chardraw_x, X       ; weapon graphic is 8 pixels to the right of the character
    CLC
    ADC #$08
    STA btlattackspr_x
    
    LDA btl_chardraw_y, X       ; and 8 pixels ABOVE the character
    SEC
    SBC #$08
    STA btlattackspr_y
    
    LDA btlattackspr_gfx        ; copy graphic over
    STA btlattackspr_t
    
    LDA #CHARPOSE_ATTACK_B      ; change the player's pose to backward attack
    STA btlattackspr_pose       ;  also.. it just works out the pose is the same for the BFrame of the attack sprite
    STA btl_chardraw_pose, X
    
    INC btlattackspr_hidell     ; set the hideLL flag to stop the graphic from drawing over the character's face
    RTS
    
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  UpdateInputDelayCounter  [$9F4D :: 0x31F5D]
;;  
;;    Counts down the input delay counter, and indicates whether or not input should
;;  be accepted.  Input should not be accepted every frame since that would make the cursor
;;  hyper-sensitive when you hold a direction on the Dpad.
;;
;;  output:  A,Z will be zero if input is to be ignored.
;;               or nonzero if input should be accepted
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

UpdateInputDelayCounter:
    DEC inputdelaycounter       ; dec the counter
    BEQ :+                      ; if nonzero, indicate that we should ignore input
      LDA #$00                  ;  (A=0)
      RTS
  : LDA #$03                    ; otherwise, if zero, reset delay counter
    STA inputdelaycounter
    LDA #$01                    ; and indicate we can use input (A=nonzero)
    RTS
    
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  [$9F5D :: 0x31F6D]
;;  Lut - pointer table to the beginning of each character's stats OB in RAM

lut_CharStatsPtrTable_alt:  ;; JIGS - moved this label
lut_CharStatsPtrTable:
  .WORD ch_stats
  .WORD ch_stats+$40
  .WORD ch_stats+$80
  .WORD ch_stats+$C0
  
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  [$9F65 :: 0x31F75]
;;  Lut - pointer table to the beginning of each character's IB stats in RAM

lut_IBCharStatsPtrTable_alt:    ;; JIGS - moved this label
lut_IBCharStatsPtrTable:
  .WORD ch_backupstats
  .WORD ch_backupstats + (1*$10)
  .WORD ch_backupstats + (2*$10)
  .WORD ch_backupstats + (3*$10)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  lut_MainCombatBoxCursorPos  [$9F75 :: 0x31F85]
;;
;;    Pixel positions to draw the cursor sprite for the main combat menu.

lut_MainCombatBoxCursorPos:
;         X    Y
  .BYTE $08, $A6 ;9E    ; FIGHT
  .BYTE $08, $B6 ;AE    ; MAGIC
  .BYTE $08, $C6 ;BE    ; SKILL
  .BYTE $08, $D6 ;CE    ; GEAR
  .BYTE $40, $A6 ;9E    ; ITEMS
  .BYTE $40, $B6 ;AE    ; GUARD
  .BYTE $40, $C6 ;9E    ; HIDE
  .BYTE $40, $D6 ;AE    ; FLEE
  
  
lut_ReadyCursorPos:
  .BYTE $08, $C6 
  .BYTE $08, $C6 
  .BYTE $08, $C6 
  .BYTE $08, $C6 
  .BYTE $40, $C6
  .BYTE $40, $C6
  .BYTE $40, $C6 
  .BYTE $40, $C6 
  
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  lut_PlayerTargetCursorPos  [$9F85 :: 0x31F95]
;;
;;    Pixel positions to draw the cursor sprite for selecting the player/character
;;  targets.  Uses 2x4 menu, but only has 1 column, so the 2nd column mirrors the first.

lut_PlayerTargetCursorPos:
  .BYTE $B8, $34    ; char 0
  .BYTE $BC, $4D    ; char 1
  .BYTE $C0, $66    ; char 2
  .BYTE $C4, $7F    ; char 3
  .BYTE $B8, $34    ; mirrors
  .BYTE $BC, $4D
  .BYTE $C0, $66
  .BYTE $C4, $7F
  
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  lut_Target9SmallCursorPos  [$9F95 :: 0x31FA5]
;;  lut_Target4LargeCursorPos  [$9FA7 :: 0x31FB7]
;;  lut_TargetMixCursorPos     [$9FAF :: 0x31FBF]
;;
;;    Pixel positions to draw the cursor sprite for target selection (for various
;;  formation types)

lut_Target9SmallCursorPos:
  .BYTE $10, $30
  .BYTE $08, $58
  .BYTE $00, $80
  .BYTE $38, $30
  .BYTE $30, $58
  .BYTE $28, $80
  .BYTE $60, $30
  .BYTE $58, $58
  .BYTE $50, $80  
  
lut_Target4LargeCursorPos:
  .BYTE $08, $30
  .BYTE $00, $68
  .BYTE $40, $30
  .BYTE $38, $68

lut_TargetMixCursorPos:
  .BYTE $08, $30
  .BYTE $00, $68
  .BYTE $48, $30
  .BYTE $40, $58
  .BYTE $38, $80
  .BYTE $70, $30
  .BYTE $68, $58
  .BYTE $60, $80
  
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  lut_MagicCursorPos  [$9FBF :: 0x31FCF]
;;
;;    Pixel positions for the MAGIC submenu.  It doesn't use 2x4 menu because
;;  it has more entries and also because it has to be able to switch pages.
;;  Also, these cursor positions are in COL-major order instead of row-major.
;;  This makes more sense here since there's 4 rows but only 3 cols, and it's
;;  easier to multiply by 4 than it is to multiply by 3

 lut_MagicCursorPos:
  .BYTE $10, $A6
  .BYTE $10, $B6
  .BYTE $10, $C6
  .BYTE $10, $D6
  .BYTE $50, $A6
  .BYTE $50, $B6
  .BYTE $50, $C6
  .BYTE $50, $D6
  .BYTE $90, $A6
  .BYTE $90, $B6
  .BYTE $90, $C6
  .BYTE $90, $D6
  
  ;; JIGS - longer magic names
; lut_CombatItemMagicBox in Bank F tells the size of the box.
; BattleMenu_DrawMagicNames in Bank F decides how long the blank spell names are
; Bank 0A has a list of spell names to edit directly! 
;
; Out of battle, DrawMagicMenuMainBox (Bank E) has... stuff

 
  
  

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  lut_EquipmentCursorPos 
;;
;;    Pixel positions for the EQUIP submenu.  It uses the 2x4 menu and
;;  actually uses all 8 slots!

lut_EquipmentCursorPos:
  .BYTE $08, $A6
  .BYTE $08, $B6
  .BYTE $08, $C6
  .BYTE $08, $D6
  .BYTE $60, $A6
  .BYTE $60, $B6
  .BYTE $60, $C6
  .BYTE $60, $D6

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  lut_ItemCursorPos  [$9FE7 :: 0x31FF7]
;;
;;    Pixel positions for the Item submenu.  It uses the 2x4 menu but only
;;  has 2 entries (Heal and Pure potions), so those 2 entries are mirrored
;;  several times

lut_ItemCursorPos:
  .BYTE $08, $A6        ;
  .BYTE $08, $B6        ;
  .BYTE $08, $C6        ;
  .BYTE $08, $D6        ;
  .BYTE $08, $A6        ;
  .BYTE $08, $B6        ;
  .BYTE $08, $C6        ;
  .BYTE $08, $D6        ;
  
lut_EtherCursorPos:
  .BYTE $18, $A6        ;
  .BYTE $18, $B6        ;
  .BYTE $18, $C6        ;
  .BYTE $18, $D6        ;
  .BYTE $58, $A6        ;
  .BYTE $58, $B6        ;
  .BYTE $58, $C6        ;
  .BYTE $58, $D6        ;  
  
lut_SkillCursorPos:  
  .BYTE $08, $CE        ;
  .BYTE $08, $CE        ;
  .BYTE $08, $CE        ;
  .BYTE $08, $CE        ;
  .BYTE $08, $CE        ;
  .BYTE $08, $CE        ;
  .BYTE $08, $CE        ;
  .BYTE $08, $CE        ;
  
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  lut_EnemyIndex9Small  [$9FF7 :: 0x32007]
;;  lut_EnemyIndex4Large  [$A000 :: 0x32010]
;;  lut_EnemyIndexMix     [$A004 :: 0x32014]
;;
;;    LUT to convert a cursor index to an actual enemy index (for various formation types)
;;  This is needed because the order in which enemies are generated do not match the order they're
;;  drawn.
;;  Example:  in the 9 small formation type, Enemy 0 is in the center row, but cursor=0 points to the top row.

lut_EnemyIndex9Small:
  .BYTE $01, $00, $02
  .BYTE $04, $03, $05
  .BYTE $07, $06, $08
  
lut_EnemyIndex4Large:
  .BYTE $00, $01
  .BYTE $02, $03
  
lut_EnemyIndexMix:
  .BYTE $00, $01            ; 2 large
  .BYTE $03, $02, $04       ; 6 small
  .BYTE $06, $05, $07
  
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  lut for character poses  [$A00C :: 0x3201C]
;;
;;  Each entry is basically a TSA for constructing an in-battle character sprite.  Each entry
;;   is a different pose, and constructs a 16x24 image out of 2x3 tiles.  Entries are 3 bytes each (with 1 byte
;;   of padding).  Each byte is the tile to use for the 16x8 sprite for a single tile row in the pose.

lut_CharacterPoseTSA:
  .BYTE $00, $02, $04, $00      ; 00 = standing pose
  .BYTE $00, $02, $06, $00      ; 04 = walking pose
  .BYTE $08, $0A, $0C, $00      ; 08 = attacking (arm back) pose
  .BYTE $00, $02, $06, $00      ; 0C = attacking (arm forward) pose
  .BYTE $0E, $10, $12, $00      ; 10 = cheering pose
  .BYTE $0E, $10, $12, $00      ; 14 = cheering pose again (possibly for casting magic or something?)
  .BYTE $14, $16, $18, $00      ; 18 = crouching pose  (for when you're hurt)
  .BYTE $14, $16, $18, $00      ; 1C = crouching pose again
  
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  lut for weapon swing TSA  [$A02C :: 0x3203C]
;;
;;  There are 2 frames here, each consisting of 8 bytes.
;;  For each frame, the first 4 bytes are the tiles to draw, and the next 4 are the attributes
;;
;;  Frame 0 is normal drawing, Frame 1 is flipped horizontally

lut_WeaponSwingTSA:
  .BYTE $00, $01, $02, $03,     $02, $02, $02, $02  ; <- normal graphic
  .BYTE $01, $00, $03, $02,     $42, $42, $42, $42  ; <- flipped horizontally
  
  
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  lut for assigning palettes to in-battle char sprites  [$A03C :: 0x3204C]
;;
lut_InBattleCharPaletteAssign:
  .BYTE 1, 0, 0, 1, 1, 0
  .BYTE 1, 1, 0, 1, 1, 0
  
  
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  DoMagicFlash  [$A051 :: 0x32061]
;;
;;    Flashes the color of the magic spell onto the background of the screen.  This routine actually
;;  takes 4 frames, 2 are drawn normal, and 2 are drawn with the flashed bg color
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

DoMagicFlash:
    LDA btl_usepalette + $18 + 1    ; get the color of the magic spell from the usepalette
    CMP #$20                        ; if it's white, replace it with gray so it isn't
    BNE :+                          ;   so overwhelming
      LDA #$10
  : STA $89                         ; store in tmp  ($89 is the flash color)
  
    LDA btl_palettes + $10          ; get the original BG color
    STA btl_backgroundflash                       ; back it up (probably unnecessary, since btl_palettes is never changed)
    
    JSR @FrameNoPaletteChange       ; Draw a normal frame
    
    LDA $89                         ; change the BG color to the flash color
    JSR @FramePaletteChange         ;  and draw 2 more frames
    JSR @FrameNoPaletteChange
    
    LDA btl_backgroundflash                       ; restore original BG color and draw another frame
  ; JMP @FramePaletteChange         ;   <- code flows into this routine
    
  @FramePaletteChange:
    STA btl_usepalette + $10
    JMP DoFrame_UpdatePalette
    
  @FrameNoPaletteChange:
    JSR WaitForVBlank_L
    JSR BattleUpdatePPU
  ; JMP BattleUpdateAudio  ; <- code flows into this routine
    
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Battle Update Audio  [$A07C :: 0x3208C]
;;
;;  Updates battle sound effects and music playback.  Called every frame to keep audio playback moving
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

BattleUpdateAudio:
    LDA #BANK_THIS
    STA cur_bank          ; set the swap-back bank (necessary because music playback is in another bank)
    LDA music_track
    BPL :+                  ; if the high bit of the music track is set (indicating the current song is finished)...
      LDA btl_followupmusic ;   then play the followup music
      STA music_track
:   JSR CallMusicPlay_L     ; Call music playback to keep it playing
    JMP UpdateBattleSFX     ; and update sound effects to keep them playing
    
    
    
    
    
Delay_UndrawOneBox:
    JSR RespondDelay
    
UndrawOneBox:
    JSR SaveAXY
UndrawOneBox_NoSave:    
    LDA #01
;   BNE UndrawBoxes

;Delay_UndrawTwoBoxes:
;    JSR RespondDelay    
;    
;UndrawTwoBoxes:
;    JSR SaveAXY
;    LDA #02
;    BNE UndrawBoxes
;    
;UndrawThreeBoxes:
;    JSR SaveAXY
;    LDA #03
;    BNE UndrawBoxes
;    
;UndrawFourBoxes:    
;    JSR SaveAXY
;    LDA #04
;    BNE UndrawBoxes
;    
;UndrawFiveBoxes:    
;    JSR SaveAXY
;    LDA #05
    
UndrawBoxes: 
   STA tmp   
   LDA btl_boxcount
   SEC
   SBC tmp
   STA btl_boxcount
   BPL :+
     LDA #BTLMSG_TERMINATED
     JSR DrawMessageBox
    @Loop: 
     JSR WaitForVBlank_L
     JMP @Loop
   
 : LDA tmp
   JSR UndrawNBattleBlocks_L
   ;JSR RespondDelay
   JMP RestoreAXY
   
UndrawAllButTwoBoxes:
   JSR SaveAXY
   ;JSR RespondDelay
  @Loop:
    JSR UndrawOneBox_NoSave
    LDA btl_boxcount
    CMP #$02
    BNE @Loop
    BEQ RestoreAXY
   
UndrawAllKnownBoxes:
   JSR SaveAXY
UndrawAllKnownBoxes_NoSave:
   LDA btl_boxcount
   JSR UndrawNBattleBlocks_L
   LDA #0
   STA btl_boxcount
   ;JSR RespondDelay
    
RestoreAXY:
    LDA MMC5_tmp+5
    LDY MMC5_tmp+6
    LDX MMC5_tmp+7
    RTS  
    
SaveAXY:
    STA MMC5_tmp+5
    STY MMC5_tmp+6
    STX MMC5_tmp+7
    RTS

DrawCharacterNameAttackerBox:
    ORA #$80
    STA btl_attacker
    
DrawAttackerBox:
    JSR SaveAXY
    LDA btl_boxcount            ; only draw the attacker name 
    BNE RestoreAXY              ; if there are no boxes already drawn
    LDA #$02                    ; $02 is the code for the attacker
    STA btltmp_attackerbuffer   ; put that in buffer to hold attacker name
    LDX #<btltmp_attackerbuffer ; set XY to point to that buffer
    LDY #>btltmp_attackerbuffer
    LDA #0
    JMP DrawCombatBox

DrawDefenderBox:
    JSR SaveAXY
    LDA #$03                            ; 03 = defender format code
    STA btltmp_altmsgbuffer + 9
    LDX #<(btltmp_altmsgbuffer + 9)
    LDY #>(btltmp_altmsgbuffer + 9)
    LDA #$02                            ; then print defender combat box
    JMP DrawCombatBox

DrawAttackBox:
    JSR SaveAXY

    ; To draw the attack name, we need to get the Item ID
    ;  How to get the Item ID depends on the source
    
    LDA btlmag_magicsource  ; check the source
    BNE @NotMagic           ; source=0 is magic.  So if zero...
    
    ; source = magic
    LDA btl_attackid        ; see if the attack type is magic or a special attack
    CMP #$40
    BCS :+                  ; if its an enemy attack, skip changing the ID
      CLC
      ADC #MG_START         ; add MG_START to the index to convert from a magic index to an item index.
      BNE :+
      
  @NotMagic:
    CMP #$01                ; if source=1, it's a Item
    BNE @Equipment                  ; for Items....
      LDA btl_attackid              ; ... get the item ID for heal/pure potions
    : TAX
      LDA #$0E                      ; preface it with 0E, the command to draw an attack (item) name
      BNE @Print                    ; (always branch)
      
  ; Reach here if the source=equipment
  @Equipment:
    CMP #02
    BNE @Skill
      LDA btl_attacker
      AND #$03
      TAY
      LDX btl_charcmditem, Y          ; get the item ID from the cmd buffer
      LDA #$0D                        ; use control code for weapon/armor names
      BNE @Print

  @Skill:
    LDY battle_class
    LDX @skillname_lut, Y
    LDA #$0F

  @Print:
    STA btl_attackbox_itemid
    STX btl_attackbox_itemid+1                       
    LDX #<btl_attackbox_itemid
    LDY #>btl_attackbox_itemid      ; get pointer to that string in YX

    LDA #$01                        ; draw the attack name in box 1
    JMP DrawCombatBox
    
   @skillname_lut:
   .byte BTLMSG_NOSKILL
   .byte BTLMSG_STEALING
   .byte BTLMSG_NOSKILL
   .byte BTLMSG_NOSKILL
   .byte BTLMSG_NOSKILL
   .byte BTLMSG_NOSKILL

DrawDamageBox:
    JSR SaveAXY

    LDX #$06            ; loop 6 times
    LDY #$00
  @Loop:
      LDA @Data, Y      ; copy unformatted text to output buffer
      STA btltmp_damageblockbuffer, Y
      INY
      DEX
      BNE @Loop
      
    LDX #<btltmp_damageblockbuffer  ; YX is a a pointer to our text buffer in RAM
    LDY #>btltmp_damageblockbuffer
    LDA #$03                        ; combat box ID 3
    JSR DrawCombatBox
    JMP RespondDelay
    
   @Data:                         ; data for "###DMG"
    .BYTE $0C                     ; format number
    .WORD math_basedamage         ; pointer to number to print
    .BYTE $0F, BTLMSG_DMG         ; "DMG" battle message
    .BYTE $00                     ; null terminator

DrawMessageBoxDelay_ThenClearAll:      
    JSR DrawMessageBox
    JSR RespondDelay
    JMP UndrawAllKnownBoxes_NoSave

DoNothingMessageBox:
    LDA #BTLMSG_NOTHING           ; Draw the "Nothing" combat box
    JSR DrawMessageBox
   @FrameLoop: 
    JSR DoFrame_WithInput        
    BEQ @FrameLoop
    JMP UndrawOneBox
    
DrawMessageBox:    
    TAX
    LDA #$04
    JSR SetMessageBuffer
    LDY #$00
    LDA #$0F                    ; get the control code
    STA ($88), Y                ; write it to pos 0
    INY
    TXA
    STA ($88), Y                ; write secondary byte to pos 1
    INY
    LDA #$00
    STA ($88), Y                ; write terminator to pos 2
    LDA #$04
    JMP DrawMessageBox_Prebuilt
    
DrawMagicMessage:
    JSR SaveAXY
    LDA btlmag_spellconnected       ; see if the spell connected
    BNE :+
      JSR DrawIneffective           ; if not, just show the 'Ineffective' message and exit
      JMP RestoreAXY
      
  : LDX btl_attackid                ; otherwise, get the attack type
    CPX #$41                        ; if >= $42, it indicates an enemy attack
    BCS RespondDelay
    
  : LDA lut_MagicBattleMessages, X  ; Get the desired message to print
    BEQ MessageRTS                  ; if 0, don't print anything.  Instead, just delay and exit
    BNE DrawMessageBoxDelay_ThenClearIt

DrawIneffective:
    LDA #BTLMSG_INEFFECTIVE    
    
DrawMessageBoxDelay_ThenClearIt:    
    JSR DrawMessageBox
    JMP Delay_UndrawOneBox

SetMessageBuffer:    
    PHA
    ASL A                       ; get pointer to this combat box's unformatted buffer
    TAY
    LDA lut_UnformattedCombatBoxBuffer, Y
    STA $88
    LDA lut_UnformattedCombatBoxBuffer+1, Y
    STA $89                     ; put in $88,89
    PLA
MessageRTS:
    RTS

DrawCombatBox:
    INC btl_boxcount
    JSR DrawCombatBox_L    
    JMP RestoreAXY

;; input: A = box ID to draw    
DrawMessageBox_Prebuilt:        ; for more complicated messages... assumes that the 
    JSR SetMessageBuffer        ; right part of btl_unfmtcbtbox_buffer has been filled in properly
    LDX $88                     ; put source pointer for drawing in YX
    LDY $89
    
DrawCombatBox_NoRestore:   
    INC btl_boxcount
    JMP DrawCombatBox_L        

DrawCommandBox:
    INC btl_boxcount
    JMP DrawCommandBox_L

    
    
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  lut_UnformattedCombatBoxBuffer [$A0CD :: 0x320DD]
;;
;;   The addresses for the unformated buffer for each combat box

lut_UnformattedCombatBoxBuffer:
  .WORD btl_unfmtcbtbox_buffer       ; 0 attacker
  .WORD btl_unfmtcbtbox_buffer + $10 ; 1 attack
  .WORD btl_unfmtcbtbox_buffer + $20 ; 2 defender
  .WORD btl_unfmtcbtbox_buffer + $30 ; 3 damage
  .WORD btl_unfmtcbtbox_buffer + $40 ; 4 bottom message
  
  
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  RespondDelay_ClearCombatBoxes [$A0D7 :: 0x320E7]
;;
;;  Waits for the Respond Rate, then clears all drawn combat boxes
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

RespondDelay_ClearCombatBoxes:
    JSR RespondDelay            ; respond rate wait
    JMP UndrawAllKnownBoxes
    
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  RespondDelay [$A0E6 :: 0x320F6]
;;
;;    Waits the appropriate number of frames, as indicated by the player's
;;  Respond Rate setting.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

RespondDelay:
    LDA btl_responddelay        ; get the delay
    STA btl_respondrate_tmp     ; stuff it in temp ram as loop counter
    : JSR WaitForVBlank_L       ; wait that many frames
      JSR BattleUpdateAudio     ; updating audio each frame
      DEC btl_respondrate_tmp
      BNE :-
    RTS

    
ClearAltMessageBuffer:
    PHA         ; preserves A,X
    TXA
    PHA
    LDX #0 ; #$04            ; index starts at 4
    LDA #$00
    ; STA btl_boxcount
    : ;STA btltmp_altmsgbuffer-5, X  ; but -5?  (also clears explode_count)
      STA btltmp_altmsgbuffer, X
      INX
      CPX #$20
      BNE :-
    PLA
    TAX
    PLA
    RTS        
    
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  lut_CharacterOAMOffset [$A0F8 :: 0x32108]
;;
;;    Offset for each character's sprite data in OAM
lut_CharacterOAMOffset:
  .BYTE $10, $28, $40, $58
  
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  FlashCharacterSprite [$A0FC :: 0x3210C]
;;
;;    Flashes the on-screen sprite for a character in battle.  This is
;;  done when an enemy attacks the player, or if a spell is cast on the player
;;
;;  input:  A = index of character to flash (0-3)
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

FlashCharacterSprite:
    TAY
    LDA lut_CharacterOAMOffset, Y   ; get character's OAM offset
    STA btl_flashsprite1                    ; back it up
    
    TAX                 ; X = OAM offset as source index
    LDY #$00            ; Y = loop counter and dest index 
    : LDA oam, X
      STA btl_flashsprite2, Y      ; copy all this character's sprite data to temp mem buffer
      INX
      INY
      CPY #6*4          ; 6 sprites * 4 bytes per sprite
      BNE :-
      
    LDA #$10
    STA btl_weird_loopctr          ; Main Loop counter
    
  @MainLoop:
    LDX btl_flashsprite1           ; X = OAM offset
    LDY #$00            ; Y = inner loop counter
    
    LDA btl_weird_loopctr
    AND #$02            ; every 2 iterations of main loop, toggle character's visibility
    BEQ @ShowSpriteLoop
    
  @HideSpriteLoop:
      LDA #$F0          ; hide sprite by moving if offscreen
      STA oam, X
      INX
      INY
      CPY #6*4
      BNE @HideSpriteLoop
    BEQ @NextIteration  ; (always branches)
  
  @ShowSpriteLoop:
      LDA btl_flashsprite2, Y      ; show sprite by restoring original sprite data
      STA oam, X
      INX
      INY
      CPY #$18
      BNE @ShowSpriteLoop
  
  @NextIteration:
    JSR BattleFrame     ; Do a frame and update sprites
    DEC btl_weird_loopctr
    BNE @MainLoop       ; Keep looping until main counter expires
    
    RTS

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  PrepCharStatPointers  [$A145 :: 0x32155]
;;
;;  Fills CharBackupStatsPointer and CharStatsPointer
;;
;;  input:  A = the desired char index 
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

PrepCharStatPointers:
    ASL A                               ; 2* for pointer lut
    TAY
    
    LDA lut_IBCharStatsPtrTable, Y      ; copy pointers from pointer luts
    STA CharBackupStatsPointer
    LDA lut_IBCharStatsPtrTable+1, Y
    STA CharBackupStatsPointer+1
    
    LDA lut_CharStatsPtrTable, Y
    STA CharStatsPointer
    LDA lut_CharStatsPtrTable+1, Y
    STA CharStatsPointer+1
    
    RTS
    
    
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  lut_InitialTurnOrder  [$A15C :: 0x3216C]
;;
;;  lut used to initialize battle turn order.  Simply contains IDs for all enemies/characters.

lut_InitialTurnOrder:
  .BYTE $00, $01, $02, $03, $04, $05, $06, $07, $08     ; enemy IDs
  .BYTE $80, $81, $82, $83, $7F                         ; character IDs

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  DoBattleRound  [$A169 :: 0x32179]
;;
;;  Do a single round of battle!!!!
;;
;;    This is the automated portion of battle -- after the user has input
;;  commands for all the characters.  This routine will return after all animation
;;  and automation for the round is over.
;;
;;  output:  btl_result
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

DoBattleRound:
    LDY #$0E                        ; initialize turn order buffer
    : LDA lut_InitialTurnOrder-1, Y ;  by just copying values from a lut
      STA btl_turnorderBackup-1, Y ;; JIGS - using a backup first
      DEY
      BNE :-
    ; at this point, Y=0
    
    STY btl_boxcount                ; clear the battle box counter
    STY btl_result                  ; Zero the battle result to indicate we should keep looping)

    ; Shuffle the turn order.  This is done by looping 16 times, each time
    ;  it will pick 2 random entries in the turn order table and swap them.
    ;
    ; Note that this is suboptimal, since it's more likely for an entry to
    ; remain unmoved than a typical iterative swap method.  So the heroes get
    ; a little screwed here, since they have a higher chance of remaining at
    ; the end of the turn order list
    ;
    ; You could argue that this is BUGGED.  The fix would be to rewrite this
    ; loop to do a traditional iterative shuffle algorithm.
    
    ;;JIGS - what if turn order was based on speed stats?
    
   @MainLoop:
    STY tmp
    LDA btl_turnorderBackup, Y 
    BMI @PlayerSpeed           ; N was set by loading an 8 if it was a player
    
   @EnemySpeed:
    JSR GetEnemyRAMPtr
    
    LDY #en_speed              ; get speed
    LDA (EnemyRAMPointer), Y     
    JMP @FinishLoop
    
   @PlayerSpeed:
    AND #$03
    JSR PrepCharStatPointers 
    
    LDY #ch_speed - ch_stats   ; get player speed
    LDA (CharStatsPointer), Y
    
   @FinishLoop:
    LDY tmp
    STA btl_turnorderSpeed, Y            ; Store in temporary memory
    
    TAX
    LDA #0
    JSR RandAX                 ; random number between 0 and Entity's Speed
    
    CLC
    ADC btl_turnorderSpeed, Y            ; add the random number to the speed/player luck
    STA btl_turnorderSpeed, Y            ; and save it...
    INY                        ; increase Y
    CPY #$0D                 
    BNE @MainLoop
    
    ;; So now we have a second turn order, full of spooooky math. 
    
    LDX #0
    STX tmp                    ; zero TMP
    STX btl_curturn            ; and make sure this is 0 - will be a mini loop counter
   @ThirdLoop:
    LDY #0
   @SecondLoop:
    LDA btl_turnorderSpeed, Y
    ;BEQ @Skip
    CMP tmp
    BCC @Lower
    
   @Higher:                    ; if higher, save as the new number to compare against
    BEQ @Same
    STA tmp

   @Lower:                     ; if lower, do nothing
    INY
    CPY #$0D
    BNE @SecondLoop
    INC btl_curturn            ; increase once, to note that one loop is done
    LDA btl_curturn            ; then check and see if two loops were done
    CMP #2                     ; if two loops, break out and get to where X can be inc'd
    BNE @ThirdLoop             ; repeat again to match the highest with itself
    
    ;; now Y is pointing at $7F in btl_turnorderBackup, so the rest of the turn order gets filled with this
    
   @Same: ; if its the same, we found the highest number possible. Grab their ID backup and slot them in to go.
    CMP #0 ; eventually, 0s will start getting compared to 0s... when that happens...
    BEQ @Lower ; go back and do nothing
  
    LDA btl_turnorderBackup, Y 
    STA btl_turnorder, X
    LDA #0
    STA btl_turnorderSpeed, Y    
    STA tmp                    ; and reset TMP 
    STA btl_curturn            ; and this again
   ;@Skip: 
    INX 
    CPX #$0D                   ; when X hits this, all combatants have been indexed properly!
    BNE @ThirdLoop
    

  @PerformBattleTurnLoop:
    LDY btl_curturn
    LDA #$00
    STA btl_defender_ailments   ; zero defender ailments (important for turn output)
    
    LDA btl_turnorder, Y        ; get whoever's turn it is
    BMI @TakeTurn               ; if it's a player, take their turn
      CMP #$7F                  ; if its a blank enemy, skip it
      BEQ @NextTurn
      TAY                       ; otherwise it's an enemy... so:
      LDA btl_enemyIDs, Y       ; get this slot's enemy ID
      CMP #$FF
      BEQ @NextTurn             ; if the slot is empty, skip their turn
      LDA btl_strikingfirst     ; if the party is striking first
      CMP #01
      BEQ @NextTurn             ;   skip their turn
      TYA                       ; otherwise, put the SLOT ID in A, and take their turn
      JMP :+
      
  @TakeTurn:
    STA tmp
    LDA btl_strikingfirst     ; if enemies are striking first
    CMP #02
    BEQ @NextTurn
    LDA tmp
  
  : JSR Battle_DoTurn                       ; do their turn
    JSR DrawPlayerBox                       ; draw the player box overtop the current player box
    JSR DrawCharacterStatus                 ; update character on-screen stats
    INC btl_boxcount
    JSR UndrawOneBox                        ; then undraw it; effectively updates HP
    JSR BattleTurnEnd_CheckForBattleEnd     ; wrap up / see if battle is over (will double-RTS if battle is over)
  @NextTurn:
    INC btl_curturn
    LDA btl_curturn
    CMP #9+4                        ; 9 enemy slots + 4 player slots
    BNE @PerformBattleTurnLoop      ; keep looping until all entities have had a turn
        
    ;; once all entities have had their turn, the round is over.
    LDA #$00
    STA btl_strikingfirst       ; clear striking first flag so enemies can now act.
    
    JSR ApplyEndOfRoundEffects  ; these should update character HP automatically, if a character is poisoned

  DoBattleRound_RTS:
    RTS


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  BattleTurnEnd_CheckForBattleEnd  [$A1DB :: 0x321EB]
;;
;;    Removed defeated defenders from combat and checks to see if the battle should
;;  end.  Note that it only checks if the defender was defeated
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

BattleTurnEnd_CheckForBattleEnd:
    LDA btl_defender_ailments       ; Check to see if the defender has died
    AND #(AIL_DEAD | AIL_STONE)
    
    BEQ CheckForBattleEnd           ; JIGS - fixin' bugs?
    
    ;BEQ DoBattleRound_RTS           ; if not, nothing to do here, so just exit
        ; NOTE!!!  The game is BUGGED because if the last remaining enemy is
        ;  confused, and if they kill themselves, then btl_defender_ailments will
        ;  not be set properly and the battle will not exit.  An alternative fix for this
        ;  is simple... instead of branching to an RTS here, just branch to CheckForBattleEnd.
        ;  That way the game will check for end of battle after EVERY turn, instead of just
        ;  turns where an entity died.
    
    ; Code reaches here if the defender is dead/stone
    LDA battle_defenderisplayer
    BNE @PlayerKilled           ; see if they're a player or an enemy
    
      ; If they were an enemy...
      LDY btl_defender_index    ; get their ID
      LDA btl_enemyIDs, Y
      CMP #$FF                  ; See if they were already removed from the roster.
      BEQ CheckForBattleEnd     ;  If they were, then just jump ahead to checking for battle end
      
      LDA #$FF
      STA btl_enemyIDs, Y       ; otherwise, remove this enemy from the lineup
      TYA
      STA btl_defender
      JSR EraseEnemyGraphic     ; and erase the enemy graphic
      
      JMP CheckForBattleEnd     ; Then check for battle end
  
  @PlayerKilled:                ; if killed defender was a player  
    JSR RemoveDefenderAction
  ; JMP CheckForBattleEnd       ; <- flow into -- check to see if the battle is over.

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  CheckForBattleEnd  [$A20D :: 0x3221D]
;;
;;    Checks to see if all enemies or players have been defeated.
;;
;;  output:
;;    none/normal RTS if battle is to resume
;;    btl_result set appropriate and Double-RTS if battle is to end.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

CheckForBattleEnd:
    LDA btl_drawflagsA      ; check drawflags to get party 'dead' status
    ORA btl_drawflagsB      ; combine with 'stone' status
    AND #$0F                ; isolate low bits.
    CMP #$0F                ; if all 4 bits are set, then all players are either dead or stone (game over)
    BNE :+
      INC btl_result            ; party is dead... set btl_result to 1 (party defeated)
      BNE @DoubleRTS            ; always branch -- double RTS to break out of the battle round
    
  : LDY #$09                ; If the party isn't dead, loop through all enemy slots to see if enemies are dead
  @EnemyLoop:
      LDA btl_enemyIDs-1, Y     ; check this slot (-1 because Y is 1-based)
      CMP #$FF
      BNE @Exit                 ; If enemy slot is not empty, enemy party is not defeated, so just exit
      DEY
      BNE @EnemyLoop            ; loop to check all 9 enemy slots
    
    LDA #$02                ; we reach here if all enemy slots are empty
    STA btl_result          ; set btl_result to 2 (enemies defeated)
                            ;   and flow into DoubleRTS to break out of battle round.
  @DoubleRTS:
    PLA
    PLA
  @Exit:
    RTS
    
  

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  ApplyEndOfRoundEffects  [$A2A6 :: 0x322B6]
;;
;;    Applies end of round effects (poison damage, regenerative recovery)
;;  Note that poison damage is NOT applied to enemies, meaning that enemies are
;;  immune to poison.  You could argue that this is BUGGED, but I don't think there
;;  are any in-game means to poison an enemy.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

ApplyEndOfRoundEffects:
    JSR ApplyPoisonToAllEnemies ; will also check for battle end
    JSR ApplyRegenToAllEnemies  ; apply regen to all enemies
    
    LDA #0
    STA EntityRegenID             ; record character ID
   @Loop: 
    STA CharacterIndexBackup
    LDA EntityRegenID
    JSR PrepCharStatPointers
    JSR ClearGuardState
    JSR ApplyRegenPoisonToPlayer
    INC EntityRegenID
    LDA CharacterIndexBackup
    CLC
    ADC #$40
    BNE @Loop
    
    ;; JIGS - Updates the Battle Turn text and character sprites at the same time
    INC BattleTurn
    
    JSR DrawCharacterStatus     
    JSR PrintBattleTurnNumber
    JMP CheckForBattleEnd       ; poison may have killed the party -- check for battle end.
    
ClearGuardState:
    LDY #ch_battlestate - ch_stats 
    LDA (CharStatsPointer), Y      
    AND #~STATE_GUARDING           
    STA (CharStatsPointer), Y
    RTS
    
PrintBattleTurnNumber:
    JSR LongCall
    .word PrintBattleTurn
    .byte BANK_MENUS
    
    JSR WaitForVBlank_L
    
    LDA #>$205D                  ; set PPU addr
    STA $2006
    LDA #<$205D
    STA $2006
    
    LDA format_buf-2 ; tens
    STA $2007
    LDA format_buf-1 ; ones 
    STA $2007
    
    JSR BattleUpdatePPU                 ; reset scroll 
    JMP BattleUpdateAudio               ; update audio for the frame we just waited for
    
    

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  ApplyPoisonToPlayer  [$A2C3 :: 0x322D3]
;;
;;  input:  A = ID of player (0-3)
;;
;;    Note that poison is applied even if the player is stoned.  Meaning if a player
;;  is both poisoned and stoned, their life will drain.  One could argue that this is
;;  BUGGED -- since a stoned character cannot receive or recover damage by any other
;;  means.... so you wouldn't expect them to receive it from poison.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; JIGS - my version:
; box logic:
; if regen, draw character name, draw "regenerating", delay, undraw "regenerating"
; if poison, see if character name is drawn; if no, draw it, skip ahead: if yes, don't draw it
; skip ahead: draw "poisoned", and "damage XXX" boxes
; if dead from poison, draw "slain", then undraw it
; undraw "damage", "poisoned", and name




ApplyRegenPoisonToPlayer:
    LDA EntityRegenID
    ORA #$80
    STA btl_attacker

    LDX CharacterIndexBackup    
    LDA ch_battlestate, X
    AND #$0F            ; get regen state
    BEQ :+
    
    JSR ApplyRegenToPlayer

  : LDA ch_ailments, X  ; get this character's ailments
    AND #AIL_POISON
    BEQ @Exit           ; if poison = no, then z = 1
    
    LDA ch_ailments, X
    AND # AIL_DEAD | AIL_STONE
    BEQ @Exit           ; do not poison someone who is stone... or dead
    
	LDA ch_maxhp, X     ; move max HP to math_basedamage 
    STA math_basedamage
    LDA ch_maxhp+1, X
    STA math_basedamage+1
    
    LSR math_basedamage+1   ; divide it by 8 (12.5% of max HP)
    ROR math_basedamage
    LSR math_basedamage+1
    ROR math_basedamage
    LSR math_basedamage+1
    ROR math_basedamage
    
    LDA ch_curhp, X
    SEC
    SBC math_basedamage
    STA ch_curhp, X
    LDA ch_curhp+1, X
    SBC math_basedamage+1
    STA ch_curhp+1, X      
    TXA
    PHA

    BCC @Dead       ; if C is clear (HP is negative), they're dead
    ORA ch_curhp, X ; if high and low are 0 
    BNE :+
    
   @Dead:
    LDA #0              ; clip their HP at zero... 
    STA ch_curhp, X          
    STA ch_curhp+1, X                  
    LDA #AIL_DEAD
    STA ch_ailments, X        ; give them the DEAD ailment
    
  : JSR DrawPoisonAsAttack
    LDA #1
    JSR PlayBattleSFX   
    JSR BattleScreenShake_L
    LDA btl_attacker
    AND #$03
    JSR FlashCharacterSprite        ; flash this character's graphic
    JSR RespondDelay  
    PLA
    TAX
    LDA ch_ailments, X
    AND #AIL_DEAD
    BEQ @Exit
   
    LDA #BTLMSG_SLAIN
    JMP DrawMessageBoxDelay_ThenClearAll  ; if dead, print "slain"
    
   @Exit:
    JMP UndrawAllKnownBoxes
   

ApplyRegenToPlayer:
    LDA ch_maxhp, X
    STA math_basedamage
    STA btlmag_defender_hpmax
    LDA ch_maxhp+1, X
    STA math_basedamage+1
    STA btlmag_defender_hpmax+1
    TXA
    PHA

    LDA ch_battlestate, X
    AND #STATE_REGENHIGH ; $60  ; clear out everything but potency ($20, $40, or $60)    
    CMP #STATE_REGENLOW
    BNE :+ 
        @LowPotency:            ; 8%
        LDA #12         
        BNE @Divide
        
  : CMP #STATE_REGENMIDDLE
    BNE :+    
       @MiddlePotency:          ; 12.5%
        LDA #8
        BNE @Divide
    
 : @HighPotency:                ; 5 = almost 20%
    LDA #6                      ; 6 = 16.6 ?
  
  @Divide:
    JSR RegenDivision

    PLA
    TAX                         ; move HP back to RAM stats
    LDA math_basedamage
    STA ch_curhp, X
    LDA math_basedamage+1
    STA ch_curhp+1, X
    
    LDA ch_battlestate, X       ; see if they're hidden
    AND #STATE_HIDDEN
    BEQ @NotHidden              ; if not, skip
    
    JSR UnhideCharacter_Save    ; if hidden, unhide
    
   @NotHidden: 
    LDA #0
    JSR PlayBattleSFX            ; play heal SFX
    JSR UpdateSprites_BattleFrame
    LDA EntityRegenID
    JSR FlashCharacterSprite
    
    LDX CharacterIndexBackup    
    LDA Hidden                    ; if Hidden is 1, skip re-hiding
    BEQ @DecrementRegeneration
    
    LDA ch_battlestate, X
    ORA #STATE_HIDDEN
    STA ch_battlestate, X         ; rehide character
    DEC Hidden
   
   @DecrementRegeneration:
    LDA ch_battlestate, X
    SEC
    SBC #1
    STA ch_battlestate, X         ; subtract 1 from the regen state to mark this turn has been used up
    AND #$0F
    BNE @drawregenbox
    
    LDA ch_battlestate, X
    AND #STATE_HIDDEN | STATE_GUARDING
    STA ch_battlestate, X
    
   @drawregenbox:
	JSR DrawAttackerBox        ; draw the attacker box
	LDA #BTLMSG_REGEN             
    JMP DrawMessageBoxDelay_ThenClearIt
  
;; this poison code is very much inspired by anomie's work 
;; https://gamefaqs.gamespot.com/boards/522595-final-fantasy/45575058/499635691
;; The regeneration for both players and enemies is also based off it! 
  
ApplyPoisonToAllEnemies:
    LDA #08
    STA btl_defender
  : JSR ApplyPoisonToEnemy
    DEC btl_defender
    BMI :-
  : RTS  

ApplyPoisonToEnemy:
    LDA btl_defender
    STA btl_attacker
    JSR GetEnemyRAMPtr
    
    LDY #en_ailments
    LDA (EnemyRAMPointer), Y
    AND #AIL_POISON
    BEQ :- 
    
  ;  LDY #en_category
  ;  LDA (EnemyRAMPointer), Y
  ;  AND #CATEGORY_REGEN
  ;  BNE :- 
  ;; This would stop the enemy from being poisoned if they are regenerative
  ;; the idea being that poison would also cancel out regeneration
    
    LDY #en_hpmax
    LDA (EnemyRAMPointer), Y
    STA math_basedamage
    STA btlmag_defender_hpmax
    INY
    LDA (EnemyRAMPointer), Y
    STA math_basedamage+1
    STA btlmag_defender_hpmax+1
    
    LSR math_basedamage+1   ; divide it by 8 (12.5% of max HP)
    ROR math_basedamage
    LSR math_basedamage+1
    ROR math_basedamage
    LSR math_basedamage+1
    ROR math_basedamage
    
    LDA #$2A    
    LDX #01                      ; pretend its magic
    JSR UpdateVariablePalette    ; make the explosion effect yellowy-green      
    JSR DoExplosionEffect        ; and do enemy explosion effect      
    JSR DrawPoisonAsAttack       ; do poison messaging      
    JSR RespondDelay      

    LDY #en_hp
    LDA (EnemyRAMPointer), Y
    SEC
    SBC math_basedamage
    STA (EnemyRAMPointer), Y
    STA tmp
    INY
    LDA (EnemyRAMPointer), Y
    SBC math_basedamage+1
    STA (EnemyRAMPointer), Y
    
    BCC @Dead                 ; if C is clear (HP is negative), they're dead
    ORA tmp                   ; if high and low are 0 
    BNE :+
 
   @Dead:
    LDA #BTLMSG_TERMINATED               
    JSR DrawMessageBoxDelay_ThenClearAll
    JSR EnemyDiedFromPoison
    JMP CheckForBattleEnd
    
  : JMP UndrawAllKnownBoxes
    
DrawPoisonAsAttack:                 ; Who is getting poisoned
    JSR DrawAttackerBox
    LDA #BTLMSG_POISONED            ; the message for poison
    JSR DrawMessageBox
	JMP DrawDamageBox               ; print damage    

   
;; JIGS - updated regeneration for enemies
    
ApplyRegenToAllEnemies:
    LDA #8
    STA EntityRegenID
    
  @MainLoop:
    LDX EntityRegenID
    STX btl_attacker
	JSR DoesEnemyXExist
	BEQ @Next
    
    TXA
    JSR GetEnemyRAMPtr
    
    LDY #en_category              ; Get the enemy category, and see if they are
    LDA (EnemyRAMPointer), Y      ;  regenerative
    AND #CATEGORY_REGEN
    BEQ @Next                     ; If not, skip them -- go to next iteration
    
  ; LDY #en_ailment               
  ; LDA (EnemyRAMPointer), Y      
  ; AND #AIL_POISON
  ; BEQ @Next                     ; enabling this would cause it to skip regeneration if the enemy was poisoned
 
    LDY #en_hpmax
    LDA (EnemyRAMPointer), Y
    STA math_basedamage
    STA btlmag_defender_hpmax
    INY
    LDA (EnemyRAMPointer), Y
    STA math_basedamage+1
    STA btlmag_defender_hpmax+1
    
    LDA #12                     ; 8% of max HP
    JSR RegenDivision
    
  : LDY #en_hp                  ; move HP back to RAM stats
    LDA math_basedamage
    STA (EnemyRAMPointer), Y
    INY
    LDA math_basedamage+1
    STA (EnemyRAMPointer), Y
    
   @drawregenbox:
	JSR DrawAttackerBox          ; draw the attacker box
    JSR DisplayAttackIndicator

	LDA #BTLMSG_REGEN             
    JSR DrawMessageBoxDelay_ThenClearAll

  @Next:
    DEC EntityRegenID             ; loop until all enemies counted
    BPL @MainLoop
    RTS

   
    
    
RegenDivision:    
    LDX btlmag_defender_hpmax   ; now holds enemy's max HP low byte
    LDY btlmag_defender_hpmax+1 ; and max HP high byte
    JSR YXDivideA               ; divides by effectivity and puts it in A 
    ORA btltmp_divLo            ; 
    BNE :+                      ; I assume this puts high byte and low byte together to see if 
    INC btltmp_divV             ; there is any HP left at all ; 
  : LDA #MATHBUF_BASEDAMAGE
    TAX
    LDY #MATHBUF_REGENHP
    JSR MathBuf_Add16
    
    LDX #MATHBUF_DEFENDERMAXHP  ; compare max HP and base damage
    LDY #MATHBUF_BASEDAMAGE     ; base damage contains how much HP to regen
    JSR MathBuf_Compare         ; C will be set if Y >= X (HP >= HPMax)
    BCC :+                      ; cap at Max HP
      LDA btlmag_defender_hpmax
      STA math_basedamage
      LDA btlmag_defender_hpmax+1
      STA math_basedamage+1
  : RTS
    




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  WalkForwardAndCastMagic  [$A32D :: 0x3233D]
;;
;;    Update the variable palette, then walk the character forward, draw the
;;  magic animation, and walk back.
;;
;;  input:
;;     A = Character index to walk forward  (0-3)
;;     X = zero -> draw magic sprite and flashy effect  (for actual magic spells)
;;         nonzero -> don't draw sprite/flashy effects  (for item usage)
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

WalkForwardAndCastMagic:
    STX btlattackspr_nodraw     ; write nodraw flag
    PHA                         ; (backup character index)
    ASL A
    TAY                         ; *2 char index in Y, to get their magic graphic
    LDX btlcmd_magicgfx, Y
    TXA                         ; graphic in X & pushed to stack
    PHA
    TYA 
    PHA                         ; push 2*char index  (pointless)
    
    LDA btlcmd_magicgfx+1, Y    ; A = palette
    LDX #$01                    ; X = nonzero to indicate magic palette
    JSR UpdateVariablePalette   ; update the palette
    
    PLA
    TAY                         ; retore 2*char index in Y  (pointless because we never use it)
    PLA
    TAX                         ; restore graphic ID in X
    PLA                         ; restore character index in A
    LDY #$01                    ; Y = nonzero to indicate doing the magic effect
    JSR WalkForwardAndStrike    ; walk forward and strike with magic!!!
    
    LDA #$00
    STA btlattackspr_nodraw     ; clear the nodraw flag
    RTS
    
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Battle_DoTurn  [$A352 :: 0x32362]
;;
;;    Do the battle animation and action for an entity's turn.
;;  
;;  input:  A = entity whose turn to take:
;;              00-08 -> enemy slot ID
;;              80-83 -> player ID
;;
;;          N = set to reflect high bit of A
;;
;;
;;  output:
;;      battle_defenderisplayer
;;      btl_defender_index
;;      btl_defender_ailments
;;
;;    The output for this routine is designed with basic physical attacks
;;  in mind.  Very simply, the defender ID, type, and ailments are retained, so
;;  that after this entity's turn is over, another routine can check to see if
;;  the defender died -- and if they did, it can remove/erase the entity from battle
;;  and check to see if battle is over.
;;
;;    Where this gets weird is that not all actions result in this simple single-defender
;;  logic.  Specifically, spells that have multiple targets don't work so well if the
;;  output only tracks one defender.  Therefore magic effects will have to remove
;;  entities from battle on their own.
;;
;;    What's WORSE is that the game doesn't check to see if the battle is over UNLESS
;;  this output indicates that at least one entity died.
;;
;;    Therefore magic logic, and running logic, and whatever other logic has to "fake"
;;  this output so that the end-of-battle checking doesn't choke.  Magic logic in
;;  particular will use btlmag_fakeout_xxx to "compile" appropriate output.  These
;;  fakeout vars will be copied to the above output before Battle_DoTurn exits.
;;
;;    This is incredibly goofy and overly complicated.  Like most of this combat code!
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

Battle_DoTurn:
    BMI Battle_DoPlayerTurn     ; if high bit set, this is a player, do a player turn
    JMP Battle_DoEnemyTurn      ; otherwise, do an enemy turn

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Battle_DoPlayerTurn  [$A357 :: 0x32367]
;;
;;  input:  A = player ID  ($80-83)
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;Command_LUT:
;    Fight  ; 01
;    Magic  ; 02
;    Skill  ; 04
;    Gear   ; 08
;    Guard  ; 10
;    Items  ; 20
;    Hide   ; 40
;    Flee   ; 80


Battle_DoPlayerTurn:
    JSR ClearAltMessageBuffer   ; Clear alt message buffer
    ;; JIGS - do this here instead of when it gets to items/magic 
    ;; maybe it'll be used for skill stuff too! It clears btl_boxcount to 0
    
    AND #$03                    ; mask off the high bit to get the player ID
    STA BattleCharID            ;  and record it for future use
    
    JSR IsCommandPlayerValid  
    BCC @Return                 ; exit if carry clear
    
    LDA BattleCharID
    ASL A
    ASL A
    TAY                         ; id*4 in Y (command index)
    
    LDA btl_charcmdbuf, Y       ; get command byte
    LSR A
    BCS @Attack
    LSR A
    BCS @Magic
    LSR A
    BCS @Skill
    LSR A
    BCS @Gear
    LSR A
    BCS @Return ; Guard--do nothing
    LSR A
    BCS @Items
    LSR A
    BCS @Hide
    LSR A
    BCS @Flee
    
   @Return:
    JMP UndrawAllKnownBoxes
    
    ;;  Code reaches here if the player had no command, which would only happen if they are
    ;;  immobilized or dead.

   @Attack: 
    LDX btl_charcmdbuf+2, Y           ; X = enemy target
    LDA BattleCharID                  ; A = attacker
    JMP PlayerAttackEnemy_Physical    ; Do the attack!

   @Items:
    LDA btl_charcmdbuf+1, Y       ; get the effect ID in A ($40 for heal, $41 for pure)
    LDX btl_charcmdbuf+2, Y       ; get the target in X
    LDY BattleCharID              ; get the actor in Y
    JMP Player_DoItem
   
   @Gear:   
    LDA btl_charcmdbuf+1, Y       ; A = effect ID
    LDX btl_charcmdbuf+2, Y       ; X = target
    LDY BattleCharID              ; Y = attacker
    JMP Player_DoEquipment

   @Flee:
    JMP Battle_PlayerTryRun       ; try to run!

   @Magic:
    TYA                         ; back up command index
    PHA
    
    LDY BattleCharID
    LDX btl_charcmdconsumeid, Y
    LDA ch_stats, X
    SEC
    SBC #$10
    STA ch_stats, X ; JIGS - lower high bits by 1, leaving low bits (max mp) alone
    
    PLA                         ; restore command index
    TAY
    
    LDA btl_charcmdbuf+1, Y     ; A = effect
    LDX btl_charcmdbuf+2, Y     ; X = target
    LDY BattleCharID            ; Y = attacker
    JMP Player_DoMagic

   @Hide: 
    JMP Player_Hide        
  
   @Skill:
    LDX btl_charcmdbuf+2, Y           ; X = enemy target
    LDA BattleCharID                  ; A = attacker
    JMP StealFromEnemy

IsCommandPlayerValid:     
    LDA BattleCharID
    JSR PrepCharStatPointers        ; load player's ailments

    LDY #ch_ailments - ch_stats
    LDA (CharStatsPointer), Y
    STA ailment_backup
    
    AND #AIL_DEAD | AIL_STONE
    BEQ :+
   @Nope:
      CLC                           ; cancel action and return
      RTS
    
  : LDA ailment_backup
    AND #AIL_SLEEP                  ; are they asleep?
    BEQ :+
      JSR Battle_PlayerTryWakeup
      BCC @Nope
      
  : LDA ailment_backup
    AND #AIL_STUN                   ; are they stunned?
    BEQ :+
      JSR Battle_PlayerTryUnstun    ; if yes, try to unstun
      BCC @Nope

  : LDA ailment_backup
    AND #AIL_CONF                   ; are they confused?
    BEQ :+
      JSR Player_Confused           ; if yes, do physical attack (will try to un-confuse too)
    
  : SEC
    RTS 
   
StealFromEnemy:
    STX btl_defender_index       ; set defender index
    STX btl_defender
    ORA #$80
    STA btl_attacker
    
    LDX btl_charcmdbuf+3, Y
    STX battle_class
   
    JSR DrawAttackerBox
    JSR DrawDefenderBox
    
    LDA #03
    STA btlmag_magicsource      ; set magicsource to 3 to print skill names
    JSR DrawAttackBox           ; it uses battle_class to get the correct skill from a lut
    JSR AttackerToAnimatedChar   
    JSR UnhideCharacter
    
    LDY #ch_level - ch_stats
    LDA (CharStatsPointer), Y
    STA MMC5_tmp                        ; save thief's level
    
    LDA #-8
    STA btl_walkdirection               ; walk the character to the left
    
    LDA #$20
    STA btl_walkloopctr                 ; loop down counter
  
  ;; 8 pixels per movement... that should be 1 screen width
   
   @Loop:
    LDA btl_animatingchar     ; get the character index
    ASL A
    ASL A
    TAX                       ; index for btl_chardraw buffer
    
    LDA btl_walkloopctr
    AND #$02                  ; toggle animation pose every 4 frames
    ASL A                     ; switch between pose '0' (stand) and pose '4' (walk)
    STA btl_chardraw_pose, X
    
    LDA btl_chardraw_x, X     ; add the directional value to the X position
    CLC
    ADC btl_walkdirection
    STA btl_chardraw_x, X
    
    JSR UpdateSprites_TwoFrames   ; update sprites, do 2 frames of animation
    
    DEC btl_walkloopctr
    BNE @Loop                 ; keep looping

    JSR SetNaturalPose    
    JSR AttackerToAnimatedChar    
    JSR HideCharacter
    
    JSR LongCall
    .word StealFromEnemyZ
    .byte BANK_ENEMYSTATS
    
    LDA battle_stealsuccess
    BMI @StealMissed              ; $FF = steal missed
    BNE @StealHit                 ; #01 = steal hit
        JSR DoNothingMessageBox   ; #00 = has nothing to steal
        JMP UndrawAllKnownBoxes

   @StealMissed:
    LDA #BTLMSG_MISSED
    JSR DrawMessageBox
    BNE :+
    
   @StealHit: 
    LDA #$04                          ; draw it in combat box 4
    JSR DrawMessageBox_Prebuilt
    
  : JSR DoFrame_WithInput     
    BEQ :-
    JMP UndrawAllKnownBoxes
  


    
  
 ;; JIGS - adding a whole chunk here

Player_Hide:
    LDA BattleCharID
    JSR DrawCharacterNameAttackerBox
  
    LDY #ch_ailments - ch_stats
    LDA (CharStatsPointer), Y
    AND #AIL_DARK | AIL_STUN
    BEQ @CheckHide
      LDA #BTLMSG_CANTHIDE ; Can't hide now!
      JMP @PrintStuff   
     
   @CheckHide: 
    LDY #ch_battlestate - ch_stats
    LDA (CharStatsPointer), Y
    AND #STATE_HIDDEN
    BEQ @Hide
      LDA #BTLMSG_ALREADYHIDING ; Already hidden!
      JMP @PrintStuff     

   @Hide:
    LDA (CharStatsPointer), Y
    ORA #STATE_HIDDEN
    STA (CharStatsPointer), Y
  
    LDA #BTLMSG_HIDING
    
    @PrintStuff:
    JSR DrawMessageBoxDelay_ThenClearAll
    JMP DrawCharacterStatus          ; draw hidden status icon
  

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Battle_PlayerTryRun  [$A3D8 :: 0x323E8]
;;
;;  Player taking their turn trying to run.
;;
;;  input:  A = player ID
;;
;;    NOTE!  This routine will double-RTS on run success!
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

Battle_PlayerTryRun:
    LDA BattleCharID
    JSR DrawCharacterNameAttackerBox
    
    LDA btl_strikingfirst           ; are we striking first?
    CMP #01                         ; JIGS - 1 is players striking first, 2 is enemies striking first
    BEQ @Success                    ; If yes, run success is guaranteed
    
    LDA btlform_norun
    AND #$01                        ; if the 'no run' bit is set in the formation,
    BNE @Fail                       ;   then failure is guaranteed.
    
    ; Formula for running is pretty simple.
    ;
    ;   Run if:  Luck > random[0, level+15]
    ;
    ; The problem is... the game is BUGGED and reads the wrong value for the level.. it ends up reading
    ;  the ailment byte for 2 players after this one (for top 2 slots) or other garbage memory for the
    ;  bottom 2 players.
    ;
    ; This code is also WAAAY more complicated and bigger than it needs to be.  This could be done with a
    ;   simple CMP instruction -- why they decided to bring the math buffer into this is beyond me.
    
;    LDY #ch_level - ch_stats        ; Get Level
;    LDA (CharStatsPointer), Y       ; JIGS - fixed
;    CLC
;    ADC #15                         ; level + 15
;    TAX                             ; put it in X
;    
;    LDY #ch_battlestate - ch_stats  ; Get Battlestate (hiding)
;    LDA (CharStatsPointer), Y       ; JIGS - if hidden, level doesn't factor into it
;    AND #$10                        ; so the running should be easier to achieve?
;    BEQ :+                          ; Seems like running gets harder the more you level up
;    
;    LDX #15                         ; by increasing the random value higher than 15
;    
;  : LDA #$00                        ; So getting a higher number is bad if you want your luck/speed
;    JSR RandAX                      ; to be higher?
;    STA tmp
;    
;    LDY #ch_speed - ch_stats         ; get player luck
;    LDA (CharStatsPointer), Y
;    CMP tmp
;	BCS @Success

    LDA #0
    STA MMC5_tmp        ; total speed
    STA MMC5_tmp+1      ; enemy ID
    LDA btl_enemycount
    STA MMC5_tmp+2      ; amount of enemies
    
   @EnemyLoop:
    LDX MMC5_tmp+1
    JSR DoesEnemyXExist
    BEQ @NextEnemy
    
    LDA MMC5_tmp+1
    JSR GetEnemyRAMPtr
    
    LDY #en_speed
    LDA (EnemyRAMPointer), Y
    CLC
    ADC MMC5_tmp
    STA MMC5_tmp
    
   @NextEnemy:
    INC MMC5_tmp+1
    DEC MMC5_tmp+2    
    BNE @EnemyLoop
    
    LSR MMC5_tmp
    LSR MMC5_tmp

    LDY #ch_level - ch_stats  
    LDA (CharStatsPointer), Y      
    STA MMC5_tmp+1
    
    LSR MMC5_tmp+1
    
    LDY #ch_battlestate - ch_stats  
    LDA (CharStatsPointer), Y       
    AND #$10                        
    BEQ :+                          

    LDA MMC5_tmp+1
    CLC
    ADC #15
    STA MMC5_tmp+1
    
  : LDY #ch_speed - ch_stats  
    LDA (CharStatsPointer), Y     
    CLC
    ADC MMC5_tmp+1    
    CMP MMC5_tmp
    BCS @Success
    
    ;; JIGS - new running formula:
    ;; All enemy's speed combined / 4
    ;; Against character's level / 2 + speed (+15 if hiding)

  @Fail:
    LDA #BTLMSG_CANTRUN             ; on failure, print 'Can't Run' 
    JMP DrawMessageBoxDelay_ThenClearAll ; then clear all combat boxes and exit
  
  @Success:
    LDA #BTLMSG_CLOSECALL           ; on success, print 'Close Call....' 
    JSR DrawMessageBoxDelay_ThenClearAll ; then clear all combat boxes
    
    LDA #$03
    STA btl_result                  ; Set the battle result to 3 (party ran)
    
    PLA                             ; double-RTS to exit the battle round
    PLA
    RTS
    
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Battle_PlayerTryWakeup  [$A42F :: 0x3243F]
;;
;;  Player taking their turn trying to wake themselves up.
;;
;;  input:  A = player ID
;;
;;      This routine is horrendously inefficient.  The formula for waking up
;;  is very simple.  If MaxHP <= rand[0,$50], you stay asleep, otherwise you
;;  wake up.  This is a very easy check to do... but for whatever reason this
;;  routine complictes it by running everything through the math buffer and shit.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

Battle_PlayerTryWakeup:
    LDA BattleCharID
    JSR DrawCharacterNameAttackerBox
    
    JSR BattleRNG_L
    AND #$07                            ; random [0,1]
    BEQ :+                              ; wake up if 0 (12.5% chance)

    LDA #BTLMSG_SLEEPING            ; print "Sleeping" message, and exit
    JMP PlayerTurn_PrintAndClearC
    
  : LDY #ch_ailments - ch_stats     ; and OB stats
    LDA (CharStatsPointer), Y
    AND #~AIL_SLEEP
    STA (CharStatsPointer), Y
    
    LDA #BTLMSG_WOKEUP              ; print "Woke up" message and exit
    JMP PlayerTurn_PrintAndSetC
    

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Battle_PlayerTryUnstun  [$A481 :: 0x32491]
;;
;;  Player taking their turn trying to unstun themselves.
;;
;;  input:  A = player ID
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

Battle_PlayerTryUnstun:
    LDA BattleCharID
    JSR DrawCharacterNameAttackerBox
    
    JSR BattleRNG_L
    AND #$03                            ; random [0,3]
    BEQ :++                             ; unstun if 0 (25% chance)
      JSR BattleRNG_L                   ; 50/50 chance to act anyway
      AND #$01
      BEQ :+
        LDA #BTLMSG_PARALYZED                ; otherwise, if nonzero, stay stunned
        
PlayerTurn_PrintAndClearC:
        JSR DrawMessageBoxDelay_ThenClearAll ; print "Paralyzed" message, then clear boxes and end turn.
        CLC
        RTS
        
  : LDY #ch_ailments - ch_stats         ; ... and also from OB ailments
    LDA (CharStatsPointer), Y
    AND #~AIL_STUN
    STA (CharStatsPointer), Y
    
    LDA #BTLMSG_CURED                   ; print "Cured!" message, and exit!
    
PlayerTurn_PrintAndSetC:    
    JSR DrawMessageBoxDelay_ThenClearIt
    SEC
    RTS


    
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  PlayerAttackEnemy_Physical  [$A4BA :: 0x324CA]
;;
;;    Perform a physical attack of Player->Enemy.
;;  Simply prep stats and calls DoPhysicalAttack, then updates enemy HP/ailments.
;;  Does not erase the enemy if he is defeated.
;;
;;  input:
;;    A = attacking player index
;;    X = defending enemy slot index
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


Player_Confused:
    LDA BattleCharID
    JSR DrawCharacterNameAttackerBox
    
    JSR BattleRNG_L
    AND #$03                            ; random [0,1]
    BEQ :+                              ; smarten up if 0 (25% chance)
        
        LDA #BTLMSG_CONFUSED            ; print "Confused" message, and exit
        JSR DrawMessageBoxDelay_ThenClearIt
        JMP PlayerConfusedAttack
    
  : LDY #ch_ailments - ch_stats           ; and OB stats
    LDA (CharStatsPointer), Y
    AND #~AIL_CONF
    STA (CharStatsPointer), Y
    LDA #BTLMSG_CONFUSECURED              ; print "Came to their senses" message and exit
    JSR DrawMessageBoxDelay_ThenClearIt   ; should jump back to DoPlayerTurn? 
    RTS
    
   
PlayerRandomSpell:
    LDA BattleCharID
    JSR Magic_ConvertBitsToBytes

    LDA #7
    STA tmp
   @FindMana:     ; this will try to find a spell level between 1 and 8 that has MP 
    LDX tmp       ; each failure will decrease the max spell level by 1
    LDA #0        ; making it more likely that it will find a lower level spell to cast
    JSR RandAX
    CLC
    ADC #ch_mp - ch_stats
    TAY
    LDA (CharStatsPointer), Y
    AND #$F0
    BNE @FindSpell ; found a spell level with mana left!
    DEC tmp 
    BPL @FindMana ; keep looking until tmp decrements to $FF--8 tries
    JMP PlayerAttackPlayer_Physical ; couldn't find any mana, just attack
    
   @FindSpell: 
    TYA             ; Y = spell level
    SEC
    SBC #ch_mp - ch_stats ; remove the offset from Y, to get spell level
    LDX #3                ; multiply by 3 to read the temp spell list
    JSR MultiplyXA
    TAY
    
    LDA TempSpellList, Y
    ORA TempSpellList+1, Y
    ORA TempSpellList+2, Y
    BNE @ChooseSpell
    JMP PlayerAttackPlayer_Physical ; no spells for this level, so attack
    
   @ChooseSpell: 
    JSR BattleRNG_L
    AND #03
    BEQ @Spell1
    LSR A
    BCS @Spell2
    
   @Spell3:
    LDA TempSpellList+2, Y
    BEQ @ChooseSpell
    BNE @CastItAlready
    
   @Spell2:
    LDA TempSpellList+1, Y
    BEQ @ChooseSpell  
    BNE @CastItAlready    
    
   @Spell1:
    LDA TempSpellList, Y
    BEQ @ChooseSpell
    
   @CastItAlready:
    STA btlcmd_spellindex
    LDA BattleCharID
    STA btlcmd_curchar 
    INC ConfusedMagic
    JMP ConfusedMagicLoadPoint
    
GetRandomEnemy_ForMagic:         ;; JIGS - dumb thing to get enemy target
    LDA #0
    LDX #8
    JSR RandAX
    TAX
    JSR DoesEnemyXExist
    BEQ GetRandomEnemy_ForMagic
    RTS
    
ConfusedMagicTarget:
    JSR BattleRNG_L
    AND #01              ;; 50% chance to cast the spell normally.
    BEQ @RTS
    
    DEC ConfusedMagic
    DEC ConfusedMagic  ;; set to $FF 
    
    LDY #MAGDATA_TARGET
    LDA (MagicPointer), Y
    
    LSR A 
    BCC :+ 
      LDA #$02
      STA btlmag_playerhitsfx ; enemy->player magic plays the "cha" sound effect (ID 2)
      LDA #$08                ; change all enemies to whole party
     @RTS: 
      RTS
  : LSR A
    BCC :+
      JSR BattleRNG_L
      AND #03
      ORA #$80
      STA btl_defender
      LDA #$02
      STA btlmag_playerhitsfx ; enemy->player magic plays the "cha" sound effect (ID 2)
      LDA #$10                ; change one enemy to one party member
      RTS
  : LSR A                     ; skip over "spell caster" bit
    LSR A    
    BCC :+ 
      LDA #$01                ; change whole party to all enemies
      RTS
  : LSR A
    BCC @0_RTS                ; not a spell that can be changed or something? 
      JSR GetRandomEnemy_ForMagic
      STX btl_defender
      LDA #$02                ; change one party member to one enemy
      RTS
      
   @0_RTS:                    ; this part might not be needed, but safest to use it
    LDA #0
    RTS
    
    ;; JIGS - figure out if the chosen spell can be cast on an enemy or player instead, 
    ;; and if so, do a 50/50 roll to cast it on them
    
    ;;MAGDATA_TARGET       = $03   ; 
    ;;(01 = All enemies, 02 = One Enemy, 04 = Spell Caster, 08 = Whole Party, 10 = One party member)

PlayerConfusedAttack:
    PLA
    PLA
    PLA
    PLA    ;; don't want to return to the DoPlayerTurn / IsCommandPlayerValid point
    JSR BattleRNG_L
    AND #$03
    BEQ ConfusedPlayerAttackEnemy_Physical     ; 25% chance to attack enemy
    AND #$01
    BEQ PlayerAttackPlayer_Physical    ; after that, 50% chance to attack a random player?
    JMP PlayerRandomSpell  
   
PlayerAttackPlayer_Physical:   ;; this LongCall part makes sure the player being attacked is alive
    JSR LongCall
    .word PlayerAttackPlayer_PhysicalZ
    .byte BANK_ENEMYSTATS
    
    JSR DoPhysicalAttack_NoAttackerBox
    JMP SavePlayerDefender    
    
;; JIGS - hopefully DoPhysicalAttack is updated enough to handle this!

ConfusedPlayerAttackEnemy_Physical:
    LDA AutoTargetOption
    PHA                   ; push the current state of the option
    LDA #0
    STA AutoTargetOption  ; set auto target for this attack
    LDA BattleCharID
    JSR PlayerAttackEnemy_Physical
    PLA
    STA AutoTargetOption  ; and restore it
    RTS

PlayerAttackEnemy_Physical:
    JSR LongCall
    .word PlayerAttackEnemy_PhysicalZ
    .byte BANK_ENEMYSTATS
   
    ;; JIGS - whew, alright so...
    ;;        This whole bit was moved to Bank Z, which also contains a check to see if
    ;;        the auto-target option is on or off. If auto-target is on, it will still attack
    ;;        a random monster.
    ;;        Also there should be some bug fixes or something...?
    ;;        The whole elmental weakness thing confuses me too much, but I think I did it okay.
    ;;        Doing this saves a lot of space to change other parts of the battle code.

    ;;;;;;;;;;;;;;;;;;;;
    JSR DoPhysicalAttack            ; Do the attack!!
    ;;;;;;;;;;;;;;;;;;;;
    
    LDY #en_ailments                ; IB ailements
    LDA btl_defender_ailments
    STA (EnemyRAMPointer), Y
    
    LDY #en_hp                      ; IB HP
    LDA btl_defender_hp
    STA (EnemyRAMPointer), Y
    INY
    LDA btl_defender_hp+1
    STA (EnemyRAMPointer), Y

    RTS
    
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  EnemyAttackPlayer_Physical  [$A581 :: 0x32591]
;;
;;    Perform a physical attack of Enemy->Player.
;;  Simply prep stats and calls DoPhysicalAttack, then updates player HP/ailments.
;;
;;  input:
;;    A = defending player index
;;    X = attacking enemy slot index
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    
EnemyAttackPlayer_Physical:
    
    JSR LongCall
    .word EnemyAttackPlayer_PhysicalZ
    .byte BANK_ENEMYSTATS

    ;; JIGS - again, moved to Bank Z to make space here for other changes, and to try and fix some bugs
    
    JSR DoPhysicalAttack_NoAttackerBox ; DoPhysicalAttack       

SavePlayerDefender:
    LDA btl_defender
    JSR PrepCharStatPointers
    
    LDY #ch_curhp - ch_stats
    LDA btl_defender_hp
    STA (CharStatsPointer), Y
    INY
    LDA btl_defender_hp+1
    STA (CharStatsPointer), Y
    
    LDY #ch_ailments - ch_stats             ; update both IB and OB ailments
    LDA btl_defender_ailments
    STA (CharStatsPointer), Y
    RTS                             ; done!

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  ClearMathBufHighBytes  [$A65A :: 0x3266A]
;;
;;    Clear the high bytes of the entries in the math buffer.
;;  A is expected to be 0 upon exit
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

ClearMathBufHighBytes:
    LDA #$00
    STA btl_mathbuf +  1        ; math_hitchance        = $6040
    STA btl_mathbuf +  3        ; math_basedamage       = $6042 
    STA btl_mathbuf +  5        ; math_numhits          = $6044 
    STA btl_mathbuf +  7        ; math_category         = $6046 
    STA btl_mathbuf +  9        ; math_element          = $6048 
    STA btl_mathbuf + 11        ; math_dmgcalc          = $604A 
    STA btl_mathbuf + 13        ; math_critchance       = $604C 
    STA btl_mathbuf + 15        ; math_ailmentchance    = $604E 
    ;STA btl_mathbuf + 17       ; btl_defender_hp       = $6050 ; NO DON'T ZERO THIS.
    ;STA btl_mathbuf + 19       ; btlmag_defender_hpmax = $6052 ; NO DON'T ZERO THIS.
    STA btl_mathbuf + 21        ; battle_totaldamage    = $6054 
    RTS



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  DoPhysicalAttack  [$A67B :: 0x3268B]
;;
;;    Called to do all the mathematical calculations AND ANIMATIONS of a physical attack.
;;  This routine does everything, from the animation before the attack, to calculating the damage.
;;  to printing the on-screen messages.
;;
;;    The only things it DOESN'T do are:
;;  a) fetch attacker/defender stats
;;  b) apply new HP/ailment values to entity
;;  c) erase defeated enemies from the screen
;;
;;    Everything else (everything between steps 'a' and 'b') is done here.
;;
;;    This routine is HUGE -- and TREMENDOUSLY inefficient.  A lot of the math is done in
;;  an extremely convoluted way and is way more complicated and takes up way more code
;;  than it needs to.  Ranges are checked and values clipped multiple times.  There is
;;  some unnecessary storing of variables, only to load them again immediately.  And
;;  the way values are clipped don't even really make sense some of the time.
;;
;;   The only thing I can think of is that this code was generated with heavy use of
;;  macros or something -- I can't imagine anyone actually writing code like this by
;;  hand.  Especially since the style does not match the rest of the game at all.
;;
;;   There's too much input for this routine to list here, but basically it assumes that
;;  all btl_attacker_xxx and btl_defender_xxx vars have been prepped, as well as a few
;;  other battle variables in the $688x range.
;;
;;    'btl_defender_ailments' and 'btl_defender_hp' are the output for this routine, and
;;  should be applied to their respective entities afterward.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

HitChance_Subtract40:
    LDA math_hitchance
    SEC
    SBC #40
    STA math_hitchance
    RTS
    
HitChance_Add40:
    LDA math_hitchance
    CLC
    ADC #40
    STA math_hitchance
    BCC :+

CapHitChance:    
    LDA #$FF
    STA math_hitchance
    
  : RTS    

DoPhysicalAttack:
    JSR DrawAttackerBox 
    
DoPhysicalAttack_NoAttackerBox:      
    JSR DrawDefenderBox
    
    JSR ClearMathBufHighBytes       ; zero high bytes of math buffers
    
    LDA #168                        ; base hit chance of 168
    STA math_hitchance
    
    LDA btl_attacker_damage         ; base damage of attacker's strength value
    STA math_basedamage
    
    LDA btl_attacker_critrate       ; base crit chance of attacker's crit rate
    STA math_critchance
    
    ;JSR LongCall                
    ;    .WORD ClericCheck
    ;    .byte $0F
    ;; See Bank Z file for more info. Despite the name, if a player is hidden, subtracts 40 from the enemy's hit chance.
    
    LDA btl_attacker_ailments       ; if attacker has DARK status, penalty of 40 to their hit chance
    AND #AIL_DARK
    BEQ :+
        JSR HitChance_Subtract40
        
  : LDA btl_defender_ailments
    AND #AIL_STUN  
    BEQ :+
        JSR BattleRNG_L             ; 50% chance the defender is too stunned to evade more
        AND #01
        BEQ :+
        JSR HitChance_Add40
      
  : LDA btl_defender_hidden         ; if defender is hidden, subtract another 40 from the attacker's hit chance
    BEQ :+
      JSR HitChance_Subtract40
      
      LDA btl_defender_class        ; thieves and ninjas get an extra 40 for hiding
      AND #CLS_TH | CLS_NJ
      BEQ :+
        JSR HitChance_Subtract40    ; if the enemy is blind, hitchance is #48 now

  : LDA btl_attacker_category       ; see if attacker category matches defender category
    AND btl_defender_category
    STA math_category
    
    LDA btl_attacker_element        ; see if attacker element matches defender elemental weakness
    AND btl_defender_elementweakness
    STA math_element
    
    LDA math_category
    ORA math_element                    ; merge categoy/element matches
    BEQ :+                              ; if any weaknesses found...
     ; LDA #MATHBUF_HITCHANCE           ; +40 bonus to hit chance
     ; LDX #40
     ; JSR MathBuf_Add
     ; LDY math_hitchance               ;; JIGS - this seems pointless in vanilla: the max hitchance is #$F8
     ; LDX math_hitchance+1             ;; 168 to start, blind enemy is +40, category/elemental weakness is +40
     ; JSR CapXYAtFF                    
     ; STY math_hitchance
     ; STX math_hitchance+1             ; maximum hit chance of 255
      
      JSR HitChance_Add40
      ;; JIGS ^ much simpler
      ;; HitChance is capped at #$FF by this routine too.
      
      LDA math_basedamage               ; and +4 bonus to base damage
      CLC
      ADC #4
      STA math_basedamage
      BCC :+
        LDA #$FF
        STA math_basedamage             ; maximum base damage of 255
        
  : LDA btl_defender_ailments
    AND #AIL_SLEEP
    BEQ :+      
        LDA #0
        STA btl_defender_evasion        ;; JIGS - sleep is scary!
        BEQ :++                         ;; skip the DARK check if defender is asleep
        
  : LDA btl_defender_ailments           ; if defender has DARK, bonus of 40 to attacker's hit chance
    AND #AIL_DARK
    BEQ :+
        JSR HitChance_Add40
        
  : LDA btl_defender_ailments
    AND #AIL_STUN | AIL_SLEEP
    BEQ :+                              ; if defender alseep or stunned....
      LDA math_basedamage               ; apply 25% bonus to base damage
      LSR A
      LSR A
      CLC
      ADC math_basedamage
      STA math_basedamage
      BCC :+
        LDA #$FF
        STA math_basedamage             ; cap at 255 base damage
       ;JMP :+                          ; (jump past the @DefenderMobile block)
     
       ;; JIGS - this should let hit chance and hit rate be added together always
  
       ; if the defender is mobile (not asleep of stunned)
    : LDA #MATHBUF_HITCHANCE            ; add their hit rate to their hit chance
      LDX btl_attacker_hitrate          ;
      JSR MathBuf_Add                   ;
    
      LDA #MATHBUF_HITCHANCE            ; and subtract the defender's evade rate from
      LDX btl_defender_evasion            ;  the hit chance.
      JSR MathBuf_Sub
      
      LDY math_hitchance
      LDX math_hitchance+1
      JSR CapXYAtFF                     ; cap at 255
      STY math_hitchance
      STX math_hitchance+1
      ;; JIGS - fixed the bug noted by Anomie as well, so this is capped AFTER all the equations
    
    ;;;;;
  : LDA math_hitchance
    BNE :+
      INC math_hitchance                ; minimum hit chance of 1
      
  : LDA math_critchance
    CMP math_hitchance
    BCC :+
      LDA math_hitchance                ; crit chance cannot exceed hit chance
      STA math_critchance
      
  : LDA btl_attacker_numhits            ; get proper number of hits (numhits * mult)
    LDX btl_attacker_numhitsmult        ;  the mult is essentially the multiplier for the FAST spell
    JSR MultiplyXA
    STA math_numhits
    
    LDA math_numhits
    BNE :+
      INC math_numhits                  ; minimum of 1 hit
      
  : LDA battle_attackerisplayer
    BEQ @EnemyAttackingPlayer           ; jump ahead if enemy is attacking a player
    
  @PlayerAttackingEnemy:
    LDA btl_attacker_varplt             ; palette to use (unimportant/unused for enemy attacks)
    LDX #$00                            ; 0 for physical/weapon attacks, nonzero for magic attacks
    JSR UpdateVariablePalette
    
    ;LDY #ch_weaponsprite - ch_stats
    ;LDA (CharStatsPointer), Y 
    LDA btl_attacker_graphic
    BEQ :+  ; JIGS - only do this longcall if no weapon equipped
    CMP #$AC
    BNE :++ ; or if using fists    
        
  : JSR LongCall
    .word HandPalette
    .byte BANK_ENEMYSTATS
    
    JSR DoFrame_UpdatePalette
      ;; JIGS - Check character class and sprite to decide what colour fists to use...
      ;; Since any sprite can be a blackbelt...
       
  : LDX btl_attacker_graphic    ; If the graphic is zero... then we shouldn't draw it
    BNE :+
      INC btlattackspr_nodraw   ; set set the 'nodraw' flag for attack sprites
      
  : ;LDX btl_attacker_graphic    ; weapon graphic
    LDY #$00                    ; 0 to indicate swinging a weapon
    ;LDA battle_attacker_index   ; the attacker (0-3)
    STY PlayMagicSound
    LDA btl_attacker
    AND #$03
    JSR WalkForwardAndStrike    ; Do the animation to walk the character forward, swing their weapon, and walk back
    
    LDA battle_defenderisplayer
    BNE :+
    
    LDA btl_defender_ailments
    AND #AIL_DEAD | AIL_STONE
    BNE :+                      ; if the enemy target is not already dead or stone...
      JSR DoExplosionEffect     ; play the "cha" sound effect and draw explosion animation on the enemy
      
  : LDA #$00
    STA btlattackspr_nodraw     ; clear the 'nodraw' flag for the attack sprites
    
    LDA battle_defenderisplayer ; 1 if player, 0 if enemy
    BEQ :+                      ; branch to just after @EnemyAttackingPlayer block
    
  @EnemyAttackingPlayer:
    LDA #$01
    JSR PlayBattleSFX           ; play the "boom bash" sound effect
    JSR BattleScreenShake_L     ; do the 'screen shake' animation
    
    LDA btl_defender_index
    AND #$03                  ; 
    JSR FlashCharacterSprite  ; flash their character sprite (JIGS; even if dead)
    
  : LDA btl_defender_ailments
    AND #AIL_DEAD | AIL_STONE
    BEQ :+ 
        LDA #BTLMSG_INEFFECTIVE           ; draw the "Ineffective" battle message, 
        JMP DrawMessageBoxDelay_ThenClearAll   ; clear all combat boxes, and exit
  
  : LDA #$00
    STA battle_critsconnected
    STA battle_hitsconnected
    STA battle_totaldamage
    STA battle_totaldamage+1
    STA battle_thishitconnected
    
    LDA math_basedamage
    STA math_basedamage_backup     ; 6BAD is temp space for base damage.  Moved here because we will be writing over math_basedamage
    
  @HitLoop:             ;  [A7DD :: 327ED]
    JSR ClearMathBufHighBytes   ; A=0
    STA math_dmgcalc            ; zero damage calculation
    LDX #200
    JSR RandAX                  ; [0,200]
    STA math_randhit
    LDA math_randhit
    CMP #200
    BNE :+
       JMP @NextHitIteration    ; skip if got 200 exactly (guaranteed miss)
       
  : LDX btl_weird_loopctr
    LDA #$00
    JSR RandAX
    CLC
    ADC btl_weird_loopctr
    STA math_basedamage     ; random between [basedmg, basedmg*2]
    BCC :+                
      LDA #$FF
      STA math_basedamage   ; max 255
      
  : LDA math_hitchance
    CMP math_randhit        ; if hit chance is < randhit value, then this was a miss.  Jump ahead
    BCC @Miss
   
    LDA math_basedamage                     ; if it was a hit
    STA math_dmgcalc                        ;   take random calculated damage
    LDA #(math_dmgcalc - btl_mathbuf) / 2
    LDX btl_defender_defense
    JSR MathBuf_Sub                         ;   subtract defender's absorb
    
   ; LDY math_dmgcalc            ; really inefficient way to set minimum of 1 damage
   ; LDX math_dmgcalc+1
   ; JSR ZeroXYIfNegative
   ; STY math_dmgcalc
   ; STX math_dmgcalc+1
   ; LDA math_dmgcalc
   ; ORA math_dmgcalc+1
   ; BNE :+
   ;   INC math_dmgcalc
    
    LDA math_dmgcalc
    ORA math_dmgcalc+1          ;; JIGS - combine high and low bites
    BNE :+                      ;; if still 0, give 1 damage
        INC math_dmgcalc 
      
  : INC battle_hitsconnected    ; count number of hits connected
    INC battle_thishitconnected
  
  @Miss:                    ; jumps here if we missed, but this code runs regardless of whether or not we hit/missed
    LDA math_critchance     ; see if hit value is <= crit chance  (this will be impossible if the attack was a miss)
    CMP math_randhit
    BCC :+                                  ; if it was... we scored a critical
      LDA #MATHBUF_DMGCALC
      LDX math_basedamage                   ; add random damage to our total
      JSR MathBuf_Add
      INC battle_critsconnected
      
  : LDA #MATHBUF_TOTALDAMAGE
    LDX #MATHBUF_TOTALDAMAGE
    LDY #MATHBUF_DMGCALC
    JSR MathBuf_Add16               ; total damage += dmgcalc
    
    LDA btl_attacker_attackailment
    BEQ @NextHitIteration           ; we're done if no ailment to apply
    LDA battle_thishitconnected
    BEQ @NextHitIteration
    
  : LDA battle_attackerisplayer    ; 1 if player, 0 if enemy
    BEQ @DoEnemyAilmentChance
      LDA battle_defenderisplayer  ; 1 if player, 0 if enemy
      BNE :+
      LDA btl_battletype            ; if battle type is 3 or 4 (fiend or chaos)
      CMP #$03                      ; then skip trying to apply ailment
      BCS @NextHitIteration
      : LDA btl_defender_category
        AND $75      ; if enemy has a resistance to the attack, set chance to 1
        BEQ :+       ; if no resistances found, jump ahead to set ailment chance to weapon's
           LDA #1   
           BNE :++   ; jump ahead to save it
      
      : LDA btl_attacker_ailmentchance  ; use ailment chance from weapon
      : STA math_ailmentchance          
        BNE @GetAilmentRandChance  ; skip all the enemy>player stuff with elements and magic defense checks
 
   @DoEnemyAilmentChance:
    LDA #100
    STA math_ailmentchance          ; base chance of connecting ailment = 100
    LDA btl_defender_elementresist
    AND btl_attacker_element
    BEQ :+                          ; if defender resists attacker's element
      LDA #$00                      ; chance to connect with ailment is zero  (later will be changed to 1)
      STA math_ailmentchance
      
  : LDA #MATHBUF_AILMENTCHANCE
    LDX btl_defender_magicdefense   ; subtract defender's magdef from ailment chance
    JSR MathBuf_Sub
    
    LDA #MATHBUF_AILMENTCHANCE
    JSR MathBuf_NZ
    BNE @GetAilmentRandChance
      INC math_ailmentchance        ; minimum ailment chance of 1

  @GetAilmentRandChance:      
    LDA #$00
    LDX #200
    JSR RandAX
    STA battle_ailmentrandchance    ; random value between [0,200]
    
    CMP #200
    BEQ @NextHitIteration           ; if == 200, skip ahead (no ailment)
    
    LDA math_ailmentchance
    CMP battle_ailmentrandchance
    BCC @NextHitIteration           ; if ailment chance >= rand value, apply the ailment!
      LDA btl_defender_ailments     ; Do some bit trickery to get only the ailments that
      EOR #$FF                      ;  the defender does not already have.
      AND btl_attacker_attackailment
      BEQ @NextHitIteration              ; if its 0, the player already has the ailments the enemy can give them
      ;; Note that in the case an enemy has more than 1 ailment to give,
      ;; They will apply both ailments again if the defender only has one of them?
      
      JSR PrintPlayerAilmentMessageFromAttack   ; print the message for those ailments
      
      LDA btl_defender_ailments     ; apply the ailment
      ORA btl_attacker_attackailment
      STA btl_defender_ailments
    
  @NextHitIteration:
    LDA #0
    STA battle_thishitconnected
  
    DEC math_numhits
    BEQ :+
      JMP @HitLoop
      
  : LDA battle_hitsconnected
    CMP #$02                    ; if they connected with 2 or more hits, draw the # of Hits box
    BCC :+
      STA btl_unfmtcbtbox_buffer+$11    ; write:  11 xx 00 0F 2B 00   to unformatted buffer +$10   (where 'xx 00' is number of hits)
      LDA #$11                          ;   ('0F 2B' prints "hits!")
      STA btl_unfmtcbtbox_buffer+$10
      LDA #$00
      STA btl_unfmtcbtbox_buffer+$12
      STA btl_unfmtcbtbox_buffer+$15
      LDA #$0F
      STA btl_unfmtcbtbox_buffer+$13
      LDA #BTLMSG_HITS
      STA btl_unfmtcbtbox_buffer+$14
      
      LDA #$01                          ; draw it in combat box 1
      ;LDX #<(btl_unfmtcbtbox_buffer + $10)
      ;LDY #>(btl_unfmtcbtbox_buffer + $10)
      JSR DrawMessageBox_Prebuilt
      
  : LDA battle_totaldamage
    ORA battle_totaldamage+1
    BNE :+                              ; if there is zero damage....
      LDA #$0F                          ; print format code for "Missed!" into unformatted buffer
      STA btl_unfmtcbtbox_buffer + $30
      LDA #BTLMSG_MISSED
      STA btl_unfmtcbtbox_buffer + $31
      LDA #$00
      STA btl_unfmtcbtbox_buffer + $32
      LDA #$03                          ; output either damage or "Missed!"
      JSR DrawMessageBox_Prebuilt
      JMP DoPhysicalAttack_Exit
      ;BEQ @OutputDamageBox              ; (always branch) 
      
  : ;LDA #$11                            ; if there is nonzero damage...
    ;STA btl_unfmtcbtbox_buffer + $30    ; print:  '11 xx xx 0F 2E 00'
    LDA battle_totaldamage              ;  where '11 xx xx' prints the damage
    STA MMC5_tmp+6                      ;; JIGS - for special critical hits
    STA math_basedamage
    
    ;STA btl_unfmtcbtbox_buffer + $31    ;  and '0F 2E' prints "DMG"
    LDA battle_totaldamage+1
    STA MMC5_tmp+7                      ;; JIGS - for special critical hits (thief gold stealing)
    STA math_basedamage+1
    
   ; STA btl_unfmtcbtbox_buffer + $32
   ; LDA #$0F
   ; STA btl_unfmtcbtbox_buffer + $33
   ; LDA #BTLMSG_DMG
   ; STA btl_unfmtcbtbox_buffer + $34
   ; LDA #$00
   ; STA btl_unfmtcbtbox_buffer + $35
    
    ;; JIGS - adding one more thing...
    
    LDA battle_defenderisplayer
    BEQ @OutputDamageBox         ; jump ahead if player is attacking enemy
    
    LDA btl_defender_index       ; get character index
    JSR UnhideCharacter          ; unhide them
    LDA #0                       ; and set the backup variable to 0 since they're not re-hiding after this
    STA Hidden                   ; though depending on the logic, this may not be necessary... better safe than buggy though
  
  @OutputDamageBox:
  ;  LDA #$03                            ; output either damage or "Missed!"
    ;LDX #<(btl_unfmtcbtbox_buffer + $30);  to the #3 combat box
    ;LDY #>(btl_unfmtcbtbox_buffer + $30)
  ;  JSR DrawMessageBox_Prebuilt
   JSR DrawDamageBox 
  
    LDA battle_critsconnected
    BEQ :+                              ; if any criticals connected...
      LDA #BTLMSG_CRITICALHIT           ; print the Critical Hit!! combat message box
      JSR DrawMessageBoxDelay_ThenClearIt
        
        LDA battle_attackerisplayer
        BEQ :+
         JSR LongCall                     ; JIGS - critical hit checker! 
        .WORD CritCheck
        .byte BANK_ENEMYSTATS                                                 

        LDA MMC5_tmp        ; load special attack message
        BEQ :+              ; ignore if 0
        
        JSR DrawMessageBoxDelay_ThenClearIt
        ;; back to original battle code...

 :  LDA #MATHBUF_DEFENDERHP
    LDX #MATHBUF_DEFENDERHP
    LDY #MATHBUF_TOTALDAMAGE
    JSR MathBuf_Sub16           ; defender_hp -= totaldamage
    
    LDA #MATHBUF_DEFENDERHP
    JSR MathBuf_NZ
    BNE @TryWake                ; done if HP is > 0
    
    LDA #AIL_DEAD                       ; otherwise (HP == 0)
    STA btl_defender_ailments           ; add the 'Dead' ailment
    LDA battle_defenderisplayer
    BEQ :+                              ; if this is a player
      LDA #BTLMSG_SLAIN                 ;  print "Slain" battle message
      BNE @DrawThisMessage
  : LDA #BTLMSG_TERMINATED              ; otherwise, print the "Terminated" battle message
    JMP @DrawThisMessage
    
  @TryWake:  
    LDA battle_hitsconnected
    BEQ DoPhysicalAttack_Exit       ; don't wake if no hits connected
    
    LDA btl_defender_ailments    
    AND #AIL_SLEEP
    BEQ @CheckConfusion             ; skip waking up if they're not asleep

    LDA btl_attacker_attackailment    
    AND #AIL_SLEEP                  ; is the ailment sleep?
    BNE @CheckConfusion             ; if yes, check for confusion
        LDA btl_defender_ailments   ; otherwise, wake 'em up
        AND #~AIL_SLEEP
        STA btl_defender_ailments      ; remove sleep ailment
        LDA #BTLMSG_WOKEUP
        JSR DrawMessageBoxDelay_ThenClearIt ; print "Woke up"
   
   @CheckConfusion: 
    LDA btl_defender_ailments    
    AND #AIL_CONF
    BEQ DoPhysicalAttack_Exit       ; skip getting sorted out if they're not confused
   
    LDA btl_attacker_attackailment    
    AND #AIL_CONF                   ; is the ailment confuse?
    BNE DoPhysicalAttack_Exit       ; if it is, don't wake them      

   @WakeUp:
    LDA btl_defender_ailments
    AND #~AIL_CONF
    STA btl_defender_ailments      ; remove sleep ailment
    LDA #BTLMSG_CONFUSECURED
      
   @DrawThisMessage:
    JSR DrawMessageBoxDelay_ThenClearIt ; print "Woke up"
    
DoPhysicalAttack_Exit:
    JSR RespondDelay
    JMP UndrawAllKnownBoxes
    
   
    
    
    
    
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  PrintPlayerAilmentMessageFromAttack  [$A988 :: 0x32998]
;;
;;    Prints the battle message(s) associated with the given ailments (in A)
;;
;;  What's weird is that this only applies to ailments applied to player characters,
;;  and only those caused by physical attacks.  It's such a specific use case -- you'd think
;;  this would be more generalized...
;;
;;    Note this double-returns if the ailment being added is 'death' in order to prevent a damage
;;  amount from displaying.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

PrintPlayerAilmentMessageFromAttack:
    ASL A
    BCC :+                      ; bit 7 set = confusion
      PHA
      LDA #BTLMSG_CONFUSED
      JSR DrawMessageBoxDelay_ThenClearIt
      PLA
  : ASL A                       ; bit 6 set = mute
    BCC :+
      PHA
      LDA #BTLMSG_SILENCED
      JSR DrawMessageBoxDelay_ThenClearIt
      PLA
  : ASL A                       ; bit 5 set = sleep (removes action)
    BCC :+
      PHA
      LDA #BTLMSG_ASLEEP
      JSR DrawMessageBoxDelay_ThenClearIt
      JSR RemoveDefenderAction
      PLA
  : ASL A                       ; bit 4 set = stun (removes action)
    BCC :+
      PHA
      LDA #BTLMSG_PARALYZED
      JSR DrawMessageBoxDelay_ThenClearIt
      ;JSR @RemoveDefenderAction
      PLA
  : ASL A                       ; bit 3 set = dark
    BCC :+
      PHA
      LDA #BTLMSG_DARKNESS
      JSR DrawMessageBoxDelay_ThenClearIt
      PLA
  : ASL A                       ; bit 2 set = poison
    BCC :+
      PHA
      LDA #BTLMSG_POISONED
      JSR DrawMessageBoxDelay_ThenClearIt
      PLA
  : ASL A                       ; bit 1 set = stone (removes action)
    BCC :+
      PHA
      LDA battle_defenderisplayer
      BNE @PlayerStone
     
      LDA #BTLMSG_BROKENTOPIECES
      BNE @ResumeStone
      
     @PlayerStone:
      JSR RemoveDefenderAction
      LDA #BTLMSG_STOPPED
      
     @ResumeStone: 
      JSR DrawMessageBoxDelay_ThenClearIt
      PLA
      
  : ASL A                       ; bit 1 set = dead (removes action)
    BCC :+
      LDA #$00
      STA btl_defender_hp
      STA btl_defender_hp+1
      
      LDA battle_defenderisplayer
      BNE @PlayerDead
      
      LDA #BTLMSG_TERMINATED
      BNE @ResumeDead
      
     @PlayerDead:
      JSR RemoveDefenderAction
      LDA #BTLMSG_SLAIN
      
     @ResumeDead: 
      JSR DrawMessageBoxDelay_ThenClearIt
      
      PLA                       ; Drop the return address.  Do not return to DoPhysicalAttack, but instead return 
      PLA                       ;  to whoever called it.  This will prevent attack damage from being drawn on
                                ;  screen (which would be pointless because the player just died)
      
      LDA btl_defender_ailments         ; apply dead ailment
      ORA btl_attacker_attackailment
      STA btl_defender_ailments
      JSR RespondDelay
      JMP UndrawAllKnownBoxes
      
  : RTS
    
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  RemoveDefenderAction  [$A9F9 :: 0x32A09]
;;
;;    Erases the chosen action that a player is to perform this round, and has them do
;;  nothing instead.  This is called when a player gets stunned/slept by an enemy.
;;
;;    Note that this is only called from PrintPlayerAilmentMessageFromAttack.
;;  and therefore applies only to defending players, and not to defending enemies.
;;  Again.. you'd think this code would have been used elsewhere...
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

RemoveDefenderAction:
    LDA btl_defender_index   ; defender 
    
RemoveCharacterAction:
    AND #$03
    ASL A
    ASL A
    TAY
    LDA #0
    STA btl_charcmdbuf, Y
    STA btl_charcmdbuf+1, Y
    STA btl_charcmdbuf+2, Y
    STA btl_charcmdbuf+3, Y
    RTS
    
    

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  YXDivideA  [$AA1B :: 0x32A2B]
;;
;;  A = YX / A
;;  X = YX % A
;;
;;  divHi has the high byte of the division result (but it's never used)
;;
;;    As with 'DoDivision', you'd think this routine would be used more, but it's only used
;;  for formatting HP for printing.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

YXDivideA:
    STA btltmp_divV
    STX btltmp_divLo
    STY btltmp_divHi
    JSR DoDivision
    LDA btltmp_divLo
    LDX btltmp_divV
    RTS
    
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  CapXYAtFF  [$A4AA :: 0x324BA]
;;
;;  XY contains a 16-bit value.  If that value is > 00FF, cap it at 00FF
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

CapXYAtFF:
    TXA
    BEQ :+          ; if X (high byte) is not zero
      LDX #$00      ; set XY to 00FF
      LDY #$FF
  : RTS

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  ZeroXYIfNegative [$A4B2 :: 0x324C2]
;;
;;  XY contains a 16-bit signed value.  If that value is negative, replace it with zero.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

ZeroXYIfNegative:
    TXA             ; check high byte
    BPL :+          ; if positive, just exit.  Otherwise
      LDX #$00      ; XY = 0
      LDY #$00
  : RTS
        
    
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  DrawCharacterStatus  [$AA50 :: 0x32A60]
;;
;;     Draws the contents of each character's status box (the 4 small boxes on the
;;  right side of the battle screen).  This includes name, "HP" or ailment text,
;;  and their current HP.
;;
;;     Drawing is spread over 5 frames, one frame for each character's text, and one frame
;;  to update the sprites.
;;
;;     Note that strangely, this routine prints the OB stats instead of the IB stats.
;;  I would expect in-battle code to print in-battle stats.  Is IB HP even used?
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; JIGS - i hate this code. so I re-wrote it all! 
;; Then I deleted my stuff and put it back because this version is more efficient on the PPU...
;; But with my own stuff in it too! Then I re-wrote it again.

DrawCharacterStatus:
    JSR SetAllNaturalPose
    JSR UpdateSprites_BattleFrame
    
    LDA #$00
    TAX
    STA CharacterIndexBackup   ; temp var for character index/loop counter
    
@CharacterLoop:
    LDA #$00                        
    STA btl_unfmtcbtbox_buffer+$50, X   ; start of first string, invisible tile
    STA btl_unfmtcbtbox_buffer+$53, X ; start of second string, invisible tile
    STA btl_unfmtcbtbox_buffer+$56, X ; start of third string, invisible tile
    
    STA btl_unfmtcbtbox_buffer+$51, X   ; clear out heavy ailment
    STA btl_unfmtcbtbox_buffer+$54, X ; clear out light ailment
    
    LDA CharacterIndexBackup
    JSR PrepCharStatPointers
    LDY #ch_ailments - ch_stats
    LDA (CharStatsPointer), Y    
    
    ; 0 1 2
    ; 3 4 5
    ; 6 7 x - the tiles will be laid out like this, where 2, 5, and 7 are null terminators
    
    ; 0 = regenerating
    ; 3 = guarding
    ; 6 = hidden
    ; 1 = heavy ailment
    ; 4 = light ailment
    
    STA tmp+1
    LDY #$FF 

    JSR @DoAilments
    
  : LDY #ch_battlestate - ch_stats
    LDA (CharStatsPointer), Y    
    BEQ @NoState                    ; if 0, skip changing it
    AND #STATE_HIDDEN               ; hidden?
    BEQ :+
        LDA #$7E
        STA btl_unfmtcbtbox_buffer+$56, X ; start of third string
        
  : LDY #ch_battlestate - ch_stats
    LDA (CharStatsPointer), Y            
    AND #STATE_GUARDING              ; guarding?
    BEQ :+
        LDA #$EF
        STA btl_unfmtcbtbox_buffer+$53, X ; start of second string
    
  : LDY #ch_battlestate - ch_stats
    LDA (CharStatsPointer), Y
    AND #STATE_REGENLOW | STATE_REGENMIDDLE ; regenerating? 
    BEQ @NoState
        LDA #$F2
        STA btl_unfmtcbtbox_buffer+$50, X ; start of first string
    
   @NoState: 
    LDA #$FF
    STA btl_unfmtcbtbox_buffer+$52, X
    STA btl_unfmtcbtbox_buffer+$55, X ; null terminate each bit
    STA btl_unfmtcbtbox_buffer+$57, X ; and create a blank third line
    
    TXA
    CLC
    ADC #8                          ; add 8 to X to move forward in the buffer
    TAX
    
    INC CharacterIndexBackup        ; add 1 to character index to process next character
    LDA CharacterIndexBackup
    CMP #4                          ; when all 4 are done, finish
    BNE @CharacterLoop
    
    ;; btl_unfmtcbtbox_buffer should now be $1C bytes long, with two $00s at the end.

    LDA #<$20DD                     ; position to begin printing
    STA AilmentPrintingPointer
    LDA #>$20DD
    STA AilmentPrintingPointer+1
    
    JSR WaitForVBlank_L         ; since we're about to do some drawing, wait for VBlank
    LDA $2002                   ; clear toggle
    
    LDX #0
    LDY #0

  @ResetLocation:
    LDA AilmentPrintingPointer+1     ; set PPU addr
    STA $2006
    LDA AilmentPrintingPointer
    STA $2006
    
  @DrawLoop:  
    LDA btl_unfmtcbtbox_buffer+$50, Y ; (using Y to index)
    CMP #$FF                      ; use $FF as null terminator for this routine 
    BEQ @NextRow
    STA $2007
    INY
    JMP @DrawLoop
  
  @NextRow:  
    LDA AilmentPrintingPointer     ; then add $20 to dest pointer to move to next row
    CLC
    ADC #$20
    STA AilmentPrintingPointer
    LDA AilmentPrintingPointer+1
    ADC #$00
    STA AilmentPrintingPointer+1
    INY
    INX 
    CPX #12                        ; three lines per character, so count 4*3 $00s
    BNE @ResetLocation             ; minus 1, because the last one doesn't need to be three lines
    
    JSR BattleUpdatePPU                 ; reset scroll 
    JSR BattleUpdateAudio               ; update audio for the frame we just waited for
    
  : RTS    
    
   @DoAilments:
    
   @HeavyAilment:
	INY
	CPY #3
    BEQ @LightAilment
	LDA @AilmentLUT, Y 
    STA tmp
	LDA tmp+1
    AND tmp
    BEQ @HeavyAilment
	LDA @AilmentIconLUT, Y
	STA btl_unfmtcbtbox_buffer+$54, X
    BNE @HeavyAilment

   @LightAilment: 
	INY
	CPY #8
    BEQ :-
	LDA @AilmentLUT, Y
    STA tmp
    LDA tmp+1
    AND tmp
    BEQ @LightAilment
	LDA @AilmentIconLUT, Y
	STA btl_unfmtcbtbox_buffer+$51, X
    BNE @LightAilment    

    
@AilmentLUT: 
.byte AIL_POISON
.byte AIL_STONE
.byte AIL_DEAD   ; heavy ailments, with dead overwriting the other two

.byte AIL_SLEEP  ; everything overwrites Sleep, since Sleep has the sprite change to fallen down pose
.byte AIL_MUTE   ; mute stops you from using battle commands, so it gets messaging to remind you who is muted
.byte AIL_DARK   ; whereas blind only stops you from hiding, so if mute and blind, show blind!
.byte AIL_CONF   ; confuse is the most dangerous of them ; it means they can act, and act against you
.byte AIL_STUN   ; but if they're stunned they can't act, so show that instead

@AilmentIconLUT:
.byte $7D, $7C, $7B, $7F, $EE, $EC, $F3, $ED ; poison, stone, dead, sleep, mute, dark, confuse, stun!

  
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  DoMiniFrame  [$AB29 :: 0x32B39]
;;
;;    This is a strange little routine that does some typical frame work.  I'm sort of at a loss
;;  to even describe it in a meaningful way.
;;
;;    What's especially strange is that it DOES use the Battle audio routine, but NOT the BattleVBlank routine
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

DoMiniFrame:
    JSR WaitForVBlank_L
    JMP BattleUpdateAudio
    
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  UpdateVariablePalette  [$AB2F :: 0x32B3F]
;;
;;    Updates the variable palette (used by weapon/magic graphics).
;;
;;  A = palette color (assumed to be $2x)
;;  X = 0 for weapon, nonzero for magic
;;
;;    Palette written is:
;;  weapon:  FF 2x 1x 0x
;;  magic:   FF 2x 1x 30   (last color is white for magic)
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

UpdateVariablePalette:
    PHA
    JSR ResetUsePalette
    PLA
    STA btl_usepalette + $19        ; set first shade
    SEC
    SBC #$10
    STA btl_usepalette + $1A        ; second shade
    SEC
    SBC #$10
    STA btl_usepalette + $1B        ; third shade
    TXA
    BEQ DoFrame_UpdatePalette       ; if weapon, jump ahead to update the PPU
      LDA #$30                      ; if magic, replace third shade with white
      STA btl_usepalette + $1B
    ; JMP DoFrame_UpdatePalette     ; then update PPU  (flow into)
  
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  DoFrame_UpdatePalette  [$AB50 :: 0x32B60]
;;
;;  Actually draws the usepalette, and does some typical frame work:
;;    - Wait for VBlank
;;    - draw usepalette
;;    - reset scroll
;;    - apply btl_soft2001
;;    - update audio
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

DoFrame_UpdatePalette:
    JSR BattleWaitForVBlank_L       ; wait for VBlank
    
    LDA #$3F            ; set PPU addr to point to palettes
    STA $2006
    LDA #$00
    STA $2006
    
    LDY #$00                ; draw the usepalette to the PPU
  @Loop:
      LDA btl_usepalette, Y
      STA $2007
      INY
      CPY #$20
      BNE @Loop
      
    LDA #$3F                ; reset PPU address
    STA $2006
    LDA #$00
    STA $2006
    STA $2006
    STA $2006
    
    JSR BattleUpdatePPU     ; reset scroll & apply soft2001
    JMP BattleUpdateAudio   ; update audio and exit
    
    
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  ResetUsePalette  [$AB80 :: 0x32B90]
;;
;;  Resets btl_usepalettes by copying btl_palettes on top of it
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

ResetUsePalette:
    LDY #$20                    ; copy $20 bytes over
  @Loop:
      LDA btl_palettes-1, Y     ; -1 because Y is 1-based and stops at 0
      STA btl_usepalette-1, Y
      DEY
      BNE @Loop
    RTS
    
    
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  BattleFadeIn  [$AB8C :: 0x32B9C]
;;
;;  Self explanitory
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

BattleFadeIn:
    JSR BattleClearOAM          ; Clear OAM
    LDA #$00
    STA soft2000              ; clear other PPU settings
    STA $2001                   ; including disabling rendering, though since btl_soft2001 has
                                ;   rendering enabled, rendering will be re-enabled when palettes are updated
    
    JSR WaitForVBlank_L         ; wait for VBlank
    LDA $2002
    LDA #>oam
    STA $4014                   ; Do DMA (clearing actual PPU OAM)
    LDA #$04
    STA btl_another_loopctr                   ; loop downcounter.  Looping 4 times -- once for each shade
    JSR BattleUpdateAudio       ; since we just did a frame, keep audio updated
    
    ; This fades in by using the fadeout routine.  Basically it will reset the palette each iteration
    ;   fading it out less and less each time, giving the appearance that it is fading it.
    ; So first frame it will fade out 4 shades, then draw
    ; next frame will reset, then fade out 3 shades, then draw
    ; next will reset, fade 2 shades, etc
  @Loop:
      JSR ResetUsePalette       ; reset palette
      
      LDX btl_another_loopctr
      : JSR FadeOutOneShade     ; fade out X shades, where X is our loop down-counter
        DEX
        BNE :-
        
      JSR Do3Frames_UpdatePalette   ; draw palette (and turn on PPU)
      DEC btl_another_loopctr
      BNE @Loop                 ; loop until down-counter exhausted
      
    JSR ResetUsePalette         ; Reset to fully-faded in palette
    JMP DoFrame_UpdatePalette   ; Then draw it and exit
    
    
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  BattleFadeOut  [$ABC4 :: 0x32BD4]
;;
;;  Self explanitory
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    
BattleFadeOut:
    JSR ResetUsePalette ; reset usepalette
    LDA #$04
    STA btl_another_loopctr           ; Loop down counter (loop 4 shades, enough to make solid black)
  @Loop:
      JSR FadeOutOneShade           ; fade out one shade
      JSR Do3Frames_UpdatePalette   ; draw it
      DEC btl_another_loopctr
      BNE @Loop                     ; repeat 4 times
    RTS

    
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  FadeOutOneShade  [$ABD8 :: 0x32BE8]
;;
;;  Iterates btl_usepalette and fades every color out by 1 shade
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

FadeOutOneShade:
    LDY #$00                ; index and loop up-counter
  @Loop:
      LDA btl_usepalette, Y ; get the color
      AND #$30              ; mask out brighness bits
      BNE :+                ; if brightness is 0
        LDA #$0F            ;  use 0F black
        BNE @SetColor
    : SEC                   ; otherwise, subtract $10 to take it down a shade
      SBC #$10
      STA btl_various_tmp          ; save new brightness to temp ram
      LDA btl_palettes, Y   ; get the original color
      AND #$CF              ; remove brightness
      ORA btl_various_tmp             ; apply new brightness
      
    @SetColor:
      STA btl_usepalette, Y ; write new color to usepalette
      INY
      CPY #$20              ; loop until all $20 colors faded
      BNE @Loop
      
    RTS
    
    
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Do3Frames_UpdatePalette  [$ABFC :: 0x32C0C]
;;
;;    Same as DoFrame_UpdatePalette, only this waits a few additional
;;  extra frames to slow down the fade effect
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

Do3Frames_UpdatePalette:
    JSR DoMiniFrame
    JSR DoFrame_UpdatePalette
    JMP DoMiniFrame
    
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  GetCharOBPointers  [$AC23 :: 0x32C33]
;;
;;    Gets OB stat pointers for 2 characters.
;;
;;  input:  A, X = IDs of characters whose stat pointers to get
;;
;;  output:  CharBackupStatsPointer = pointer to A's OB ch_stats
;;           CharStatsPointer = pointer to X's OB ch_stats
;;
;;    Yeah, I know the use of 'ib charstat ptr' is a little misleading since
;;  it's not IB stats... but whatever.  This is only used by one part of the game.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

GetCharOBPointers:
    ASL A                           ; ID * 2 to use as index for lut
    
    TAY
    LDA lut_CharStatsPtrTable, Y    ; copy pointer from lut to output
    STA CharBackupStatsPointer
    LDA lut_CharStatsPtrTable+1, Y
    STA CharBackupStatsPointer+1
    
    TXA
    ASL A                           ; X ID * 2
    
    TAY
    LDA lut_CharStatsPtrTable, Y    ; copy pointer from lut again
    STA CharStatsPointer
    LDA lut_CharStatsPtrTable+1, Y
    STA CharStatsPointer+1
    
    RTS
    
   
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  SwapCharsForSorting  [$AC57 :: 0x32C67]
;;
;;  input:  $88 and $89 = char IDs (0-3) to swap
;;
;;    This routine swaps not only character stats,
;;  but also the character entries in char_order_buf
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

SwapCharsForSorting:
    LDA $88                 ; Swap ch_stats
    LDX $89
    JSR GetCharOBPointers
    JSR SwapCharOBStats
    
    LDA $88                 ; put char IDs in X,Y
    TAY
    LDA $89
    TAX
    
    LDA char_order_buf, Y   ; so that we can swap their entries in char_order_buf
    PHA
    LDA char_order_buf, X
    STA char_order_buf, Y
    PLA
    STA char_order_buf, X
    
    RTS                     ; done!
    
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  SwapCharOBStats  [$AC80 :: 0x32C90]
;;
;;  input:
;;    CharBackupStatsPointer
;;    CharStatsPointer
;;
;;    Both pointers point to *OB* stats for characters.  This routine
;;  will do a buffer swap.
;;
;;    It'll swap $40 bytes total.  This is the size of ch_stats, and the
;;  size of ch_magicdata.  To fully have characters swap places, both of
;;  those buffers will have to be swapped, so this needs to be called twice.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

SwapCharOBStats:
    LDY #$00                ; index and loop up counter
  @Loop:
      LDA (CharStatsPointer), Y  ; Swap a byte
      PHA
      LDA (CharBackupStatsPointer), Y
      STA (CharStatsPointer), Y
      PLA
      STA (CharBackupStatsPointer), Y
      
      INY                           ; loop $40 times
      CPY #$40
      BNE @Loop
      
    RTS
    
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  lut_AilmentWeight  [$AC92 :: 0x32CA2]
;;
;;    Table to add weight to characters with ailments so they will
;;  be moved to the back of the party when the party is sorted.  This
;;  is used to move dead/stone/poisoned chars to the back of the party
;;  after battle.
;;
;;    Weight is placed in high 4 bits, since the char index is in the low
;;  2 bits.  Higher weight = move to back of party.

lut_AilmentWeight:
  .BYTE $00     ; 0 no ailment (no weight)
  .BYTE $40     ; 1 dead (highest weight)
  .BYTE $20     ; 2 stone
  .BYTE $40     ; 3 somehow dead AND stoned 
  .BYTE $00     ; 4 poison
  .BYTE $40     ; 5 somehow dead and poisoned
  .BYTE $20     ; 6 somehow stoned and poisoned
  .BYTE $40     ; 7 somehow just everything
  .byte $00     ; 8 dark
  
  ;; JIGS - hopefully this makes it so poisoned characters don't get moved around.

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  ReSortPartyByAilment  [$AC96 :: 0x32CA6]
;;
;;    This moves characters around in the party order to move dead/
;;  stone/poison enemies to the back of the party.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

ReSortPartyByAilment:
    LDX #$00                    ; X is character index and loop up counter
  @WeightLoop:
      TXA                       ; shift left 6 to get character stat index
      JSR ShiftLeft6
      TAY                       ; char index in Y
      
      LDA ch_ailments, Y        ; get their ailments
      AND #$0F                  ; cut out everything but death, stone, poison, and dark
      STA ch_ailments, Y        ; then save it, to clear out non-battle ailments from persisting
      TAY                       ; ailments in Y
      
      TXA                       ; char index in A
      CLC
      ADC lut_AilmentWeight, Y  ; add ailment weight to character index
      STA char_order_buf, X     ; store in char order buffer
      
      INX
      CPX #$04
      BNE @WeightLoop           ; loop 4 times (for each character)
      
    ; Now that ailment weights are added, we can just sort char_order_buf to
    ;  go in ascending order, and characters will debilitating ailments will be
    ;  moved to the back of the party.

                @outerloopctr = $8A
                @loopctr = $8B
    
    STX @outerloopctr               ; X=4 at this point, do the outer loop 4 times
@OuterSortLoop:
    LDA #$00                        ; inner loop counter -- loop 3 times
    STA @loopctr
    
  @InnerLoop:
    LDY @loopctr
    LDA char_order_buf, Y         ; check weight of this slot
    CMP char_order_buf+1, Y       ; compare to weight of next slot
    BCC :+                        ; if the weight of this slot is greater (this slot should be after next slot)
      TYA
    
      AND #$03                    
      STA $88                     
      INY
      TYA
      
      AND #$03                    
      STA $89                     
      JSR SwapCharsForSorting
      DEY
    
    : INC @loopctr                  ; do inner loop 3 times (not 4, because we check slot+1)
      LDA @loopctr
      CMP #$03
      BNE @InnerLoop
      
    DEC @outerloopctr               ; do outer loop 4 times, so that the last slot has time to be moved all the way
    BNE @OuterSortLoop              ;  to the front.
    
    RTS
    
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  TransferByte  [$ACE1 :: 0x32CF1]
;;
;;  Transfer a byte between two buffers (specifically for transferring OB char stats to IB stats)
;;
;;  input:
;;    CharBackupStatsPointer = pointer to dest buffer
;;    CharStatsPointer = pointer to source buffer
;;                      A = dest index
;;                      Y = source index
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

TransferByte:
    PHA                             ; backup A
    LDA (CharStatsPointer), Y       ; Load the source stat
    TAX                             ; stick it in X
    PLA                             ; restore A, put in Y
    TAY
    TXA                             ; get the source stat
    STA (CharBackupStatsPointer), Y ; write it to the dest
    RTS
    


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  LoadAllCharacterIBStats  [$ACEB :: 0x32CFB]
;;
;;    Loads the in-battle stats for all charaters
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;LoadAllCharacterIBStats:
BackupCharacterBattleStats:
    LDA #$00                    ; just load each of them one at a time
    JSR BackupOneCharacterBattleStats
    LDA #$01
    JSR BackupOneCharacterBattleStats
    LDA #$02
    JSR BackupOneCharacterBattleStats
    LDA #$03
    ;; flow

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  LoadOneCharacterIBStats  [$ACFF :: 0x32D0F]
;;
;;    Loads the in-battle stats for one character (in A)
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

BackupOneCharacterBattleStats:
    STA btl_tmpindex                ; store char index (temporarily)
    JSR PrepCharStatPointers        ; prep stat pointers
    
    LDY #ch_class - ch_stats
    LDA (CharStatsPointer), Y       ; get char class
    AND #$F0                        ;; JIGS - cut off low bits to get sprite
    JSR ShiftSpriteHightoLow    
    TAY                             ;  use as index to get assigned palette
    LDA lut_InBattleCharPaletteAssign, Y
    LDY btl_tmpindex
    STA btl_charattrib, Y

    LDA btl_tmpindex
    LDY #ch_slotindex_backup - ch_backupstats
    STA (CharBackupStatsPointer), Y
    
    LDY #ch_intelligence - ch_stats
    LDA #ch_intelligence_backup - ch_backupstats
    JSR TransferByte
    
    LDY #ch_speed - ch_stats
    LDA #ch_speed_backup - ch_backupstats
    JSR TransferByte
    
    LDY #ch_damage - ch_stats
    LDA #ch_damage_backup - ch_backupstats
    JSR TransferByte
    
    LDY #ch_hitrate - ch_stats
    LDA #ch_hitrate_backup - ch_backupstats
    JSR TransferByte
    
    LDY #ch_defense - ch_stats
    LDA #ch_defense_backup - ch_backupstats
    JSR TransferByte
    
    LDY #ch_evasion - ch_stats
    LDA #ch_evasion_backup - ch_backupstats
    JSR TransferByte
    
    LDY #ch_magicdefense - ch_stats
    LDA #ch_magicdefense_backup - ch_backupstats
    JSR TransferByte
    
    LDY #ch_elementresist - ch_stats
    LDA #ch_elementresist_backup - ch_backupstats
    JSR TransferByte
    
    LDY #ch_elementweak - ch_stats
    LDA #ch_elementweak_backup - ch_backupstats
    JSR TransferByte
    
    LDY #ch_weaponelement - ch_stats
    LDA #ch_weaponelement_backup - ch_backupstats
    JSR TransferByte
    
    LDY #ch_weaponcategory - ch_stats
    LDA #ch_weaponcategory_backup - ch_backupstats
    JSR TransferByte
    
    LDY #ch_numhits - ch_stats
    LDA #ch_numhits_backup - ch_backupstats
    JSR TransferByte

    LDY #ch_numhitsmult - ch_stats
    LDA #ch_numhitsmult_backup - ch_backupstats
    JSR TransferByte

    LDY #ch_critrate - ch_stats
    LDA #ch_critrate_backup - ch_backupstats
    JMP TransferByte    
    
    
    
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  MathBuf_Compare [$ADEA :: 0x32DFA]
;;
;;  Compares two entries in the math buffer.
;;
;;  input:  X,Y = indexes of math buffer to compare
;;
;;  output:   C = set if Y >= X, clear if Y < X
;;            N = set if high byte of Y < high byte of X
;;
;;            All other flags are cleared.... **INCLUDING THE I FLAG**.  This is very strange.
;;         Since IRQs are not used by the game, this doesn't matter.  But still, very strange.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

MathBuf_Compare:
    JSR DoubleXAndY         ; Double X,Y so we can use them as proper indexes
    LDA btl_mathbuf+1, Y    ; Get high byte of Y entry
    CMP btl_mathbuf+1, X    ; Compare to high byte of X entry
    BEQ :+                  ;  if not equal...
      PHP
      PLA
      AND #$81              ; preserve NC flags, but clear all other flags
      PHA
      PLP
      RTS                   ; and exit
    
  : LDA btl_mathbuf, Y      ; if high bytes were equal, compare low bytes
    CMP btl_mathbuf, X
    PHP
    PLA
    AND #$01                ; this time, only preserve the C flag
    PHA
    PLP
    RTS
    
    
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Multiply X,A [$AE09 :: 0x32E19]
;;
;;    Does unsigned multiplication:  X*A
;;  High 8 bits of result stored in X
;;  Low  8 bits of result stored in A
;;
;;  There is a 100% identical routine in bank B at $9EFB.  It's duplicated here so its accessible in
;; this bank as well.  Probably should have been put in the fixed bank.
;;
;;  And I mean 100% identical.  I actually copy/pasted that code here.  There is literally no difference
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;MultiplyXA:
;    STA btltmp_multA    ; store the values we'll be multiplying
;    STX btltmp_multB
;    LDX #$08            ; Use x as a loop counter.  X=8 for 8 bits
    
;    LDA #$00            ; A will be the high byte of the product
;    STA btltmp_multC    ; multC will be the low byte
    
    ; For each bit in multA
;  @Loop:
;      LSR btltmp_multA      ; shift out the low bit
;      BCC :+
;        CLC                 ; if it was set, add multB to our product
;        ADC btltmp_multB
;    : ROR A                 ; then rotate down our product
;      ROR btltmp_multC
;      DEX
;      BNE @Loop
    
;    TAX                     ; put high bits of product in X
;    LDA btltmp_multC        ; put low bits in A
;    RTS   

;; JIGS - This is in Bank F now, but also... it just uses the MMC5 registers!!    
 ;; Wish I knew how to simplify division though... 
    
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  DoDivision  [$AE2B :: 0x32E3B]
;;
;;  vars:
;;    btltmp_divLo
;;    btltmp_divHi
;;    btltmp_divV
;;
;;  result:
;;    HiLo = HiLo / V
;;       V = HiLo % V
;;
;;  You'd think this routine would be used more than it is....
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

DoDivision:
    TXA                     ; backup X
    PHA
    LDA #$00                ; clear temp ram (to hold remainder)
    STA btl_various_tmp
    
    LDX #16                 ; loop 16 times (each bit in HiLo)
    ROL btltmp_divLo
    ROL btltmp_divHi        ; left shift 1 bit out
  @Loop:
      ROL btl_various_tmp             ; roll the bit into remainder
      LDA btl_various_tmp
      CMP btltmp_divV       ; see if it's >= divisor
      BCC :+
        SBC btltmp_divV     ; if yes, subtract divisor
        STA btl_various_tmp
    : ROL btltmp_divLo      ; if subtracted, roll 1 into low bit, otherwise, roll 0
      ROL btltmp_divHi      ;   this ultimately will perform the division
      DEX
      BNE @Loop             ; loop for all 16 bits
    LDA btl_various_tmp
    STA btltmp_divV         ; store remainder
    
    PLA                     ; restory X
    TAX
    
    RTS


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  RandAX [$AE5D :: 0x32E6D]
;;
;;  Generates a random number between [A,X] inclusive.
;;  Generated number is stored in A on return
;;
;;  This is quite literally an exact copy (seriously, copy/paste) from a routine
;;  in bank 0B.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;RandAX:
;    STA $68AF       ; 68AF is the 'lo' value
;    INX
;    STX $68B0       ; 68B0 is hi+1.  But this STX is totally unnecessary because this value is never used
    
;    TXA
;    SEC
;    SBC $68AF       ; subtract to get the range.
;    STA $68B6       ; 68B6 = range
    
;    JSR BattleRNG_L
;    LDX $68B6
;    JSR MultiplyXA  ; random()*range
    
;    TXA             ; drop the low 8 bits, put high 8 bits in A  (effectively:  divide by 256)
;    CLC
;    ADC $68AF       ; + lo
    
;    RTS

;; JIGS - this is moved to Bank F - that is, the Fixed bank.
    
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  MathBuf_Add16 [$AE7B :: 0x32E8B]
;;
;;  Adds two 16-bit value in the math buffer.  Stores result in math buffer.
;;
;;  input:  A = index of math buffer to receive sum
;;        X,Y = indexes of math buffer to add
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

MathBuf_Add16:
    PHA                     ; backup target index
    JSR DoubleXAndY         ; double X,Y so they are usable indexes
    
    LDA btl_mathbuf, Y
    CLC
    ADC btl_mathbuf, X
    STA btl_mathbufadd16tmp1               ; add low bytes together
    
    LDA btl_mathbuf+1, Y
    ADC btl_mathbuf+1, X
    STA btl_mathbufadd16tmp2               ; and high bytes
    
    BCC :+                  ; if there was high-byte carry
      LDA #$FF              ; cap at $FFFF
      STA btl_mathbufadd16tmp1
      STA btl_mathbufadd16tmp2
      
  : PLA                     ; restore target index
    ASL A                   ; *2 to use as index
    TAX
    
    LDA btl_mathbufadd16tmp1               ; move sum to target slot in math buffer
    STA btl_mathbuf, X
    LDA btl_mathbufadd16tmp2
    STA btl_mathbuf+1, X
    
    RTS
    
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  MathBuf_Sub16 [$AEAC :: 0x32EBC]
;;
;;  Subtracts two 16-bit value in the math buffer.  Stores result in math buffer.
;;
;;  input:  A = index of math buffer to receive result
;;        X,Y = indexes of math buffer to subtract   (A = X-Y)
;;
;;     Code is same as MathBuf_Add16.  See that routine for details, comments here are sparse.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

MathBuf_Sub16:
    PHA
    JSR DoubleXAndY
    
    LDA btl_mathbuf, X
    SEC
    SBC btl_mathbuf, Y
    STA btl_mathbufadd16tmp1
    
    LDA btl_mathbuf+1, X
    SBC btl_mathbuf+1, Y
    STA btl_mathbufadd16tmp2
    
    BCS :+
      LDA #$00
      STA btl_mathbufadd16tmp1
      STA btl_mathbufadd16tmp2
      
  : PLA
    ASL A
    TAX
    LDA btl_mathbufadd16tmp1
    STA btl_mathbuf, X
    LDA btl_mathbufadd16tmp2
    STA btl_mathbuf+1, X
    RTS
    
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  MathBuf_Add [$AEDD :: 0x32EED]
;;
;;  Adds an 8-bit value to an entry in the math buffer, capping the sum at FFFF
;;
;;  input:  A = index of math buffer to add to
;;          X = value to add
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

MathBuf_Add:
    STA btl_mathbufadd16tmp1       ; backup index
    PHA             ; backup A,X,Y
    TXA
    PHA
    TYA
    PHA
    
    LDA btl_mathbufadd16tmp1      ; index value * 2 to use as index
    ASL A
    TAY
    
    TXA             ; value to add from X
    CLC
    ADC btl_mathbuf, Y      ; add it
    STA btl_mathbuf, Y
    LDA #$00
    ADC btl_mathbuf+1, Y
    STA btl_mathbuf+1, Y
    BCC :+                  ; if exceeded FFFF
      LDA #$FF
      STA btl_mathbuf, Y    ; cap at FFFF
      STA btl_mathbuf+1, Y
      
  : PLA                     ; restore backups of all regs
    TAY                     ; before exiting
    PLA
    TAX
    PLA
    RTS
    
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  MathBuf_Sub [$AF0A :: 0x32F1A]
;;
;;  Subtracts an 8-bit value from an entry in the math buffer, capping the result at 0000
;;
;;  input:  A = index of math buffer to subtract from
;;          X = value to subtract
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

MathBuf_Sub:
    STA btl_mathbufadd16tmp1           ; routine is identical to MathBuf_Add, only it subtracts
    PHA                 ;   instead.  Spare comments.
    TXA
    PHA
    TYA
    PHA
    LDA btl_mathbufadd16tmp1
    ASL A
    TAY
    STX btl_mathbufadd16tmp1
    SEC
    LDA btl_mathbuf, Y
    SBC btl_mathbufadd16tmp1
    STA btl_mathbuf, Y
    LDA btl_mathbuf+1, Y
    SBC #$00
    STA btl_mathbuf+1, Y
    BCS :+
      LDA #$00
      STA btl_mathbuf, Y
      STA btl_mathbuf+1, Y
  : PLA
    TAY
    PLA
    TAX
    PLA
    RTS
    
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  MathBuf_NZ [$AF3C :: 0x32F1A]
;;
;;  Sets NZ flags to reflect a 16-bit value in the math buffer
;;
;;  input:  A = index of math buffer to use
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

MathBuf_NZ:
    ASL A                   ; double and stick in Y to use as index
    TAY
    LDA btl_mathbuf+1, Y    ; get high byte of value
    BNE @Exit               ; if nonzero, just use it as our NZ settings and exit
    
      LDA btl_mathbuf, Y          ; if zero, get the low byte, to use its Z flag setting
      PHP
      PLA                   ; move status flags to A
      AND #$7F              ; clear the N flag (value is not negative if high byte was zero)
      PHA
      PLP                   ; move back to status flags
  @Exit:
    RTS
    
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  MathBuf_CopyXToY [$AF4D :: 0x32F5D]
;;
;;  X = source index
;;  Y = dest index
;;
;;  Copies the source entry in the math buf to the dest entry
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

MathBuf_CopyXToY:
    JSR DoubleXAndY         ; double X,Y so they are usable indexes
    LDA btl_mathbuf, X      ; copy low byte
    STA btl_mathbuf, Y
    LDA btl_mathbuf+1, X    ; high byte
    STA btl_mathbuf+1, Y
    RTS
    
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  DoubleXAndY [$AF5D :: 0x32F6D]
;;
;;  X *= 2
;;  Y *= 2
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

DoubleXAndY:
    TXA     ; Double X!
    ASL A
    TAX
    
    TYA     ; Double Y!
    ASL A
    TAY
    
    RTS
    
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  ApplyEnemyAilmentMask  [$B190 :: 0x331A0]
;;
;;  input:   A = ailments to keep
;;
;;  effectively does:   ailments &= A
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

ApplyEnemyAilmentMask:
    LDY #en_ailments
    AND ($9A), Y
    STA ($9A), Y
    RTS
    
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Battle_DoEnemyTurn  [$B197 :: 0x331A7]
;;
;;  Takes an enemy's turn in battle.
;;
;;  input:  A = slot id of enemy
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

Battle_DoEnemyTurn:
    STA btl_attacker
    JSR GetEnemyRAMPtr
    LDA #$02
    STA btlmag_playerhitsfx     ; enemy->player magic plays the "cha" sound effect (ID 2)
    JSR ClearAltMessageBuffer
    LDA #$00
    STA btlmag_magicsource      ; Enemies can't use potions or items -- so their magic source is always 'magic'
    JSR DrawAttackerBox         ; draw the attacker box
    JSR DisplayAttackIndicator  ; flash the enemy
    
    LDY #en_ailments
    LDA (EnemyRAMPointer), Y             ; see if they're stunned or asleep
    AND #AIL_SLEEP | AIL_STUN
    BEQ @EnemyActive
    
    ;;;;  This block runs if enemy is stunned or asleep
    
    AND #AIL_SLEEP                  ; see if they are asleep
    BNE @Asleep                     ;  if yes, jump ahead to asleep code                    
        
        ;; Otherwise, they are paralyzed
    JSR BattleRNG_L         ; random number between [0,255]
    AND #$03                ; 25% chance to get 0 
    BNE :+                  ; then the paralysis is cured:
      LDA #~AIL_STUN
      JSR ApplyEnemyAilmentMask     ; remove STUN ailment mask
      LDA #BTLMSG_CURED             ; display "Cured!" message and end their turn
      BNE @PrintAndEnd
  : LDA #BTLMSG_PARALYZED
    BNE @PrintAndEnd
    
  @Asleep:                  ; If the enemy is asleep
    JSR BattleRNG_L         ; random number between [0,255]
    AND #$07                ; 12.5% chance to get 0
    BNE :+                  ; then the sleepiness is cured:
      LDA #~AIL_SLEEP
      JSR ApplyEnemyAilmentMask    
      LDA #BTLMSG_WOKEUP     
      BNE @PrintAndEnd
  : LDA #BTLMSG_SLEEPING
    
  @PrintAndEnd:
    JMP DrawMessageBoxDelay_ThenClearAll

  @EnemyActive:                         ; jumps here if enemy is active (not stunned or asleep)
    LDY #en_ailments
    LDA (EnemyRAMPointer), Y                     ; check the high bit to see if they're confused
    BPL @EnemyActive_AndNotConfused     ; if clear, jump ahead to EnemyActive_AndNotConfused.  Otherwise...
    
    ; If enemy is confused
    JSR BattleRNG_L                     ; random [0,$FF]
    AND #03
    BNE :+                              ; cured if 0 (25% chance)
      LDA #~AIL_CONF
      JSR ApplyEnemyAilmentMask
      LDA #BTLMSG_CONFUSECURED
      BNE @PrintAndEnd
      
  : LDA #BTLMSG_CONFUSED
    JSR DrawMessageBoxDelay_ThenClearIt
    
    JSR BattleRNG_L
    AND #03
    BEQ @EnemyActive_AndNotConfused     ; 25% chance enemy will do normal AI routine anyway
    
    LDA #MG_FIRE - MG_START             ; cast FIRE on a random enemy  -- which is totally lame.  I would expect stronger
    STA btl_attackid                    ; enemies to have a stronger attack.
    JSR Battle_PrepareMagic             ; Note that even though we are casting FIRE, the attack combat box is never drawn, so
   
    ;;JIGS - altering the spell's properties to more resemble a physical attack
   
    LDX #0
    STX btlmag_element                  ; clear fire element
    LDA #$20
    JSR UpdateVariablePalette           ; and make sure its white dust cloud
    LDY #en_strength
    LDA (EnemyRAMPointer), Y
    LSR A
    BNE :+
        LDA #01                         ; minimum damage of 1
  : STA btlmag_effectivity              ; set attack strength as half enemy's strength 
    JSR Battle_CastMagicOnRandEnemy     ;   it *looks* like a physical attack.
    JMP Battle_EndMagicTurn
    
    ;;  Code reaches here if enemy has normal status -- not stunned, asleep, or confused.  It can just do
    ;;  its normal action:
  @EnemyActive_AndNotConfused:
    LDA ch_level
    ASL A
    STA $9E             ; $9E = 2*level of party leader
    
    ; Check the enemy's morale and see if they are going to run away.
    ; The formula for this is:
    ;
    ;   V = X + Morale - L
    ;
    ; where:
    ;   X = random number between [$00,$32]
    ;   Morale = enemy's morale stat
    ;   L = 2* level of the party leader.
    ;
    ;   if V is less than $50, the enemy will run!
    
    LDY #en_morale
    LDA (EnemyRAMPointer), Y     ; morale
    SEC
    SBC $9E
    BCC @RunAway        ; run if morale < 2*level_of_leader
    STA $9E             ; store Morale-L in 9E
    LDA #$00
    LDX #$32
    JSR RandAX          ; random between [$00-$32]
    CLC
    ADC $9E             ; A is now 'V' above... X+Morale-L
    BCS Enemy_DoAi      ; if > 255, do not run
    CMP #$50
    BCS Enemy_DoAi      ; if >= $50, do not run
    ; Otherwise, fall through to @RunAway
    
  @RunAway:
    LDA #BTLMSG_RUNAWAY
    JSR DrawMessageBox
    
    JSR TargetSelf                  ; Target self
    STA btl_defender_index          ; record as defender index (See Battle_DoTurn for why this is important)
    
    JSR EraseEnemyGraphic
    LDA #AIL_DEAD
    STA btl_defender_ailments       ; Mark ourselves as dead (See Battle_DoTurn for why this is important)
    LDY #en_ailments
    STA (EnemyRAMPointer), Y        ; Give ourselves the 'DEAD' ailment
    
    ;; JIGS - new way to clear GP and Exp rewards!
    LDA btl_defender                ; enemy ID
    ASL A                           ; times 4
    ASL A 
    TAY                             ; put into Y...
    
    LDA #$00
    STA battle_defenderisplayer     ; Fill output:  defender is an enemy
    
    STA btl_enemyrewards, Y         ; then clear 4 bytes of this enemy's reward RAM
    STA btl_enemyrewards+1, Y
    STA btl_enemyrewards+2, Y
    STA btl_enemyrewards+3, Y
    
    LDX btl_attacker
    JSR ClearEnemyID
    JMP UndrawAllKnownBoxes


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  ClearEnemyID  [$B288 :: 0x33298]
;;
;;  X = slot index whose enemy ID to clear
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

ClearEnemyID:
    LDA #$FF
    STA btl_enemyIDs, X
    RTS

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  EnemyAi_ShouldPerformAction  [$B294 :: 0x332A4]
;;
;;  input:   A = 'rate' between $00-80
;;  output:  C = CLEAR if the action should be performed.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

EnemyAi_ShouldPerformAction:
    STA btl_randomplayer       ; store rate
    LDA #$00
    LDX #$80
    JSR RandAX      ; rand[ 0, 128 ]
    CMP btl_randomplayer       ; C clear if rand is less than rate (action should be performed)
    RTS

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Enemy_DoAi  [$B2A2 :: 0x332A2]
;;
;;    Have the enemy check its AI and pick an action to perform, then actually perform
;;  the action.
;;
;;  input:  $9A,9B = points to enemy stats in RAM
;;          $9C,9D = points to enemy stats in ROM
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

Enemy_DoAi:
    LDY #en_ai
    LDA (EnemyRAMPointer), Y
    CMP #$FF                    ; get AI id from RAM 
    BNE :+
      JMP ChooseAndAttackPlayer ; no AI -- just attack a random player
      
    ; use enemy AI
  : LDX #$10                ; get a pointer to this enemy's AI data
    JSR MultiplyXA          ; $10 bytes per AI entry
    CLC                     ;   end result, of this math:  @aiptr points to this enemy's AI data
    ADC #<lut_EnemyAi
    STA EnemyAIPointer
    TXA
    ADC #>lut_EnemyAi
    STA EnemyAIPointer+1   ; pointer to AI data
    
    LDY #$00
    LDA (EnemyAIPointer), Y         ; Get byte 0 (magic rate)
    JSR EnemyAi_ShouldPerformAction ; See if we should do a magic attack
    BCS @CheckSpecialAttack         ; if not, jump ahead to check for special attacks
    
  @DoMagicAttack:
    LDY #en_aimagpos
    LDA (EnemyRAMPointer), Y
    AND #$07                        ; get current magic pos
    JSR @IncrementAiPos             ; increment magic position
    ADC #$02                        ; position+2 is the index to the spell to cast
    TAY
    LDA (EnemyAIPointer), Y         ; get the spell to cast
    CMP #$FF                        ; if $FF (empty slot)...
    BNE :+
      LDA #$00                      ; ...reset position, and start over
      LDY #en_aimagpos
      STA (EnemyRAMPointer), Y
      JMP @DoMagicAttack            ; keep going until we find a non-empty spell slot
    
  : JMP Enemy_DoMagicEffect         ; with the magic spell in A, do the magic attack
    
    ;;  This is like a mini-subroutine used by the surrounding code
    ;;    it is always JSR'd to, never branched to.  So RTS is OK.
  @IncrementAiPos:
    PHA                             ; backup position
    CLC
    ADC #$01                        ; +1
    STA (EnemyRAMPointer), Y        ; and write it back
    PLA                             ; restore backup
    RTS
  
  @CheckSpecialAttack:
    LDY #$01
    LDA (EnemyAIPointer), Y         ; get special attack rate
    JSR EnemyAi_ShouldPerformAction ; see if we should do it
    BCS ChooseAndAttackPlayer       ; if not, just do a normal attack
    
    ; otherwise, do a special attack
  @DoSpecialAttack:
    LDY #en_aiatkpos            ; This block is the same as @DoMagicAttack -- the only difference
    LDA (EnemyRAMPointer), Y    ;   is it cycles through the 4 enemy attack slots instead of the
    AND #$03                    ;   8 magic slots.
    JSR @IncrementAiPos
    ADC #$0B
    TAY
    LDA (EnemyAIPointer), Y
    CMP #$FF
    BNE :+
      LDA #$00
      LDY #en_aiatkpos
      STA (EnemyRAMPointer), Y
      JMP @DoSpecialAttack
  : CLC
    ADC #$41                    ; add $40 to the special attack ID to indicate it's a special attack (0-3F are magic)
    JMP Enemy_DoMagicEffect     ; and perform the special attack

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  ChooseAndAttackPlayer  [$B319 :: 0x33329]
;;
;;    Choose a random player target, and then do a physical attack against them.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

ChooseAndAttackPlayer:
    JSR GetRandomPlayerTarget       ; get random target
    JMP EnemyAttackPlayer_Physical  ; do the attack and exit
    
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  GetRandomPlayerTarget [$B325 :: 0x33335]
;;
;;  output:  btl_randomplayer = 0-based player ID of who to target
;;
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; A doesn't need to be backed up here?! Its not really carrying anything important.

GetRandomPlayerTarget:
    TXA
    PHA
    
  @GetTargetLoop:
      LDA #$00
      STA btl_randomplayer        ; zero output
      
      JSR BattleRNG_L             ; get a random number
      CMP #$20
      BCS :+
        INC btl_randomplayer      ; inc target if < $20
    : CMP #$40
      BCS :+
        INC btl_randomplayer      ; inc target if < $40
    : CMP #$80
      BCS :+
        INC btl_randomplayer      ; inc target if < $80
        
      ; The end result here, is:
      ;  4/8 chance of target=0   (rand is [80,FF])
      ;  2/8 chance of target=1   (rand is [40,7F])
      ;  1/8 chance of target=2   (rand is [20,3F])
      ;  1/8 chance of target=3   (rand is [00,1F])
      
    : LDA btl_randomplayer        ; get target
      JSR PrepCharStatPointers
    
    LDY #ch_ailments - ch_stats
    LDA (CharStatsPointer), Y  
    AND #AIL_DEAD | AIL_STONE
    BNE @GetTargetLoop            ; target is dead/stone, choose another one
    
    LDY #ch_battlestate - ch_stats
    LDA (CharStatsPointer), Y    ; check if hidden
    AND #STATE_HIDDEN
    BEQ :+
       ; if nonzero, do another compare to give hidden characters another chance to stay hidden?
       LDA #01
       LDX #03
       JSR RandAX
       CMP #03
       BNE @GetTargetLoop  ; if it rolls a 1 or a 2, loop. If it rolls a 3, tough luck, hidden character
 :  PLA                    ; restore A,X
    TAX
    RTS
    
    
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Battle_PrepareMagic  [$B35C :: 0x3336C]
;;
;;    Loads the stats for the desired magic spell.
;;
;;  input:   btl_attackid = ID of spell
;;           btl_attacker = ID of attacker
;;
;;  output:  MagicPointer,  btlmag_xxx.
;;
;;  NOTE!!
;;      If the spell has no effect, this routine will double-RTS out to abort the player's turn.
;;  Since this routine is called before the player walks forward to cast their spell, this routine
;;  must walk them forward before double-RTSing.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

Battle_PrepareMagic:
    INC HiddenMagic     ; JIGS - if its 1, that tells the UnhideCharacter routine to keep the Hidden variable as 1 until magic is over. Or something like that.

    LDA btl_attackid                ; get the attack ID
    CMP #$FF                        ; if $FF, it's a non-attack.  This can only happen when
    BEQ @Ineffective                ;    a player uses an item that has no effect
    
    ; At this point, A has the attack ID which is in the range [$00,$3F] and contains a magic index
    JSR GetPointerToMagicData
    
    LDY #MAGDATA_EFFECT             ; get the effect byte
    LDA (MagicPointer), Y           ; if it's nonzero (valid effect), jump ahead to @SpellOk
    BNE @SpellOk                    
    
    ; otherwise (spell with no IB effect, like EXIT), fall through to @Ineffective
    
    ; The Ineffective block will actually do a double-RTS to abort the player's entire action.
    ;   In the original game, this code will only be reached for players (because enemies will never use
    ;   bad items/spells)
      @Ineffective:
        LDA btl_attacker                ; as per Disch's suggestion, skip walking forward if the attacker is enemy
        BPL :+                          ; (high bit not set)
        AND #$03                        ; mask out character index from the attacker ID
        LDX #$01                        ; X=1 to indicate to NOT draw magic sprite.
        JSR WalkForwardAndCastMagic     ; do the walk/magic animation
        DEC HiddenMagic                 ; JIGS - set to 0 again, since its not going to happen anywhere else...
        
      : LDA btlmag_magicsource
        CMP #$02
          BNE :+
          LDA #BTLMSG_NOTHINGHAPPENS    ; source=02 (item)
          BNE :++
        : LDA #BTLMSG_INEFFECTIVENOW    ; source=00 or 01 (magic or Item)
      : JSR DrawMessageBoxDelay_ThenClearAll  ; Show the battle message, then clear all boxes
        PLA                             ; Double-RTS to abort player's turn
        PLA
        RTS
    
    ; Code reaches here if the spell has a valid effect  (effect in A)
    ;   Load the stats of this magic spell
  @SpellOk:
    STA btlmag_effect           ; record effect
    
    LDY #MAGDATA_ELEMENT        ; magic's element
    LDA (MagicPointer), Y
    STA btlmag_element
    
    LDY #MAGDATA_HITRATE        ; hit rate
    LDA (MagicPointer), Y
    STA btlmag_hitrate
    
    LDY #MAGDATA_EFFECTIVITY    ; and effectivity
    LDA (MagicPointer), Y
    ;STA btlmag_effectivity
    
  ;  LDY ConfusedMagic    ;; JIGS - enable this to halve effectiveness while confused
  ;  BEQ :+
    
  ;  LSR A
  : STA btlmag_effectivity
    
    RTS
    
    
    
   
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Player_DoItem [$B3BD :: 0x333CD]
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

Player_DoItem:
    STA btl_attackid            ; record the attack ID
    LDA #$01                    ; source = Item
    STA btlmag_magicsource      ; record the source
    
    TYA                         ; Y = attacker, put attacker in A
    AND #$03
    ORA #$80
    STA btl_attacker            ; make sure high bit is set, and record them as an attacker
    STX btl_defender            ; X contains the defender, record them as well
    
    LDA #$00
    STA btlmag_playerhitsfx     ; player->player magic plays the 'heal' sound effect (ID 0)
    
    JSR DrawAttackerBox         ; Draw the attacker name box
    JSR DrawAttackBox           ; Draw the spell name box
    
    INC HiddenMagic
    
    LDA btl_attacker
    AND #$7F
    LDX btlmag_magicsource
    JSR WalkForwardAndCastMagic
    
    LDX btl_attackid
    LDA items, X
    BNE :+ 
    
    DEC HiddenMagic  
    LDA #BTLMSG_OUTOFITEM
    JMP DrawMessageBoxDelay_ThenClearAll
    
  : TXA
    ASL A
    LDA UseItem_JumpTable-2, X  ; -2 because there is no item with a 0
    STA tmp
    LDA UseItem_JumpTable-1, X  ; so 1*2 is looking at Heal instead of XHeal now
    STA tmp+1
    JMP (tmp)

UseItem_JumpTable:        
    .word UseItem_Heal          ; 1
    .word UseItem_XHeal         ; 2
    .word UseItem_Ether         ; 3
    .word UseItem_Elixir        ; 4
    .word UseItem_Pure          ; 5
    .word UseItem_Soft          ; 6
    .word UseItem_PhoenixDown   ; 7
    NOP                         
    NOP                         ; 8 
    NOP                         
    NOP                         ; 9 
    NOP                         
    NOP                         ; 10
    .word UseItem_Eyedrops      ; 11 ; B
    .word UseItem_Smokebomb     ; 12 ; C
    .word UseItem_WakeupBell    ; 13 ; D 

UseItem_WakeupBell: 
    LDX #0
   @Loop: 
    LDA ch_ailments, X
    AND #~AIL_SLEEP ; $DF  ; clear out all ailments that aren't sleep
    STA ch_ailments, X
    TXA
    CLC
    ADC #$40
    BNE @Loop

    LDX #WAKEUPBELL
    DEC items, X           ; remove wakeup bell from inventory        
    LDA #3
    JSR PlayBattleSFX      ; play bell SFX
    LDA #BTLMSG_WAKEUPBELL ; print "The bell rings loudly.."
    JMP UseItem_End

UseItem_Heal:  
    JSR BtlMag_LoadPlayerDefenderStats_NoSFX
    JSR Battle_PlMag_IsPlayerValid
    BNE UseItem_Ineffective
    
    LDA #BTL_HEAL_POTENCY
    STA btlmag_effectivity
    JSR BtlMag_Effect_RecoverHP
    JSR UseItem_CommonCode

    LDX #HEAL
    LDA #BTLMSG_HPUP
    JMP UseItem_End_RemoveItem
    
UseItem_XHeal:  
    JSR BtlMag_LoadPlayerDefenderStats_NoSFX
    JSR Battle_PlMag_IsPlayerValid
    BNE UseItem_Ineffective
    
    LDA #BTL_XHEAL_POTENCY
    STA btlmag_effectivity
    JSR BtlMag_Effect_RecoverHP
    JSR UseItem_CommonCode
    LDA #BTLMSG_HPUP                   ; print "HP up!"
    LDX #X_HEAL
    JMP UseItem_End_RemoveItem
    
UseItem_Elixir:
   JSR BtlMag_LoadPlayerDefenderStats_NoSFX
   JSR Battle_PlMag_IsPlayerValid
   BNE UseItem_Ineffective
   
   JSR BtlMag_SetHPToMax
   
    LDA btl_defender
    AND #$03
    JSR ShiftLeft6
    CLC
    ADC #ch_mp - ch_stats    ; $0, $40, $80, or $C0 + $30
    TAX        

    LDY #0 
   @InnerLoop:
    LDA ch_stats, X ; X is pointer to level 1 MP 
    AND #$0F        ; clear current mp entirely, leaving only max mp
    STA tmp+1       ; back it up
    ASL A           ; shift by 4
    ASL A
    ASL A
    ASL A           ; to put max mp into high bits--current mp
    ORA tmp+1       ; add max mp back in
    STA ch_stats, X ; and save it
    INY
    TXA          
    CLC
    ADC #1          ; +1 for each spell level
    TAX
    CPY #08
    BNE @InnerLoop

    JSR UseItem_CommonCode
    LDA #BTLMSG_ELIXIR
    LDX #ELIXIR
    JMP UseItem_End_RemoveItem

UseItem_Ineffective:            ; put here so it can be BCC'd to easily
    DEC HiddenMagic
    LDA #BTLMSG_INEFFECTIVENOW 
    JMP DrawMessageBoxDelay_ThenClearAll
    
UseItem_Pure:
    JSR BtlMag_LoadPlayerDefenderStats_NoSFX
    LDA #AIL_POISON
    STA btlmag_effectivity
    
    JSR BtlMag_Effect_CureAilment
    BCC UseItem_Ineffective
    
    LDX #PURE
    JMP UseItem_AilmentCured
    
UseItem_Soft:
    JSR BtlMag_LoadPlayerDefenderStats_NoSFX
    LDA #AIL_STONE
    STA btlmag_effectivity
    
    JSR BtlMag_Effect_CureAilment
    BCC UseItem_Ineffective
    
    LDA btlmag_defender_hp+1    ; check high byte of HP
    BNE :+                      ; if its over 0, they have enough HP
        LDA btlmag_defender_hp  ; if its 0, check low byte
        BNE :+                  ; if low byte is above 0, do nothing
        LDA #25                 ; otherwise, give them 25 HP
        STA btlmag_defender_hp
    
  : LDX #SOFT
UseItem_AilmentCured:
    DEC items, X                       ; remove item from inventory
    JSR UseItem_CommonCode
    LDA #BTLMSG_CURED                  ; print "Cured!"
    JMP UseItem_End
  
UseItem_PhoenixDown:
    JSR BtlMag_LoadPlayerDefenderStats_NoSFX
    LDA #AIL_DEAD
    STA btlmag_effectivity
    
    JSR BtlMag_Effect_CureAilment
    BCC UseItem_Ineffective
    
    LDA #25                            ; give them 25 HP
    STA btlmag_defender_hp
    JSR UseItem_CommonCode
    LDA #BTLMSG_LIFE
    LDX #PHOENIXDOWN    
    JMP UseItem_End_RemoveItem
  
UseItem_Smokebomb:            ; adds $10 to all battlestate ch_stats to make the party hidden
    LDA #0 
   @Loop: 
    TAX
    LDA ch_ailments, X
    AND #(AIL_DEAD | AIL_STONE)
    BNE @Next                  ; if character is dead or stoned, skip
    
    LDA ch_battlestate, X      
    ORA #STATE_HIDDEN
    STA ch_battlestate, X
    
    @Next:
    TXA
    CLC
    ADC #$40
    BNE @Loop
    
    JSR PlayDoorSFX      ; do the smokebomb explosion/door SFX
    LDX #SMOKEBOMB
    LDA #BTLMSG_HIDING    
    JMP UseItem_End_RemoveItem
    
UseItem_Ether:
    LDA btl_attacker
    AND #$03
    ASL A
    ASL A
    TAY
    LDA btl_charcmdbuf+3, Y ; all this to get the magic level to use the ether on!
    STA tmp
    
    LDA btl_defender
    AND #$03
    JSR ShiftLeft6
    TAX 

    LDA ch_ailments, X
    AND #(AIL_DEAD | AIL_STONE)
    BNE Eyedrops_Ineffective ; if character is dead or stoned, ineffective
    
    TXA
    CLC
    ADC #ch_mp - ch_stats
    ADC tmp
    TAX
    
    LDA ch_stats, X ; X is pointer to level MP 
    AND #$0F        ; clear current mp entirely, leaving only max mp
    STA tmp+1       ; back it up
    ASL A           ; shift by 4
    ASL A
    ASL A
    ASL A           ; to put max mp into high bits--current mp
    ORA tmp+1       ; add max mp back in
    STA ch_stats, X ; and save it
    
    LDA btlmag_playerhitsfx
    JSR PlayBattleSFX     
    LDA btl_defender
    AND #$03
    JSR FlashCharacterSprite
    LDA #BTLMSG_ETHER
    LDX #ETHER
    JMP UseItem_End_RemoveItem
    
UseItem_Eyedrops:
    JSR BtlMag_LoadPlayerDefenderStats_NoSFX
    LDA #AIL_DARK
    STA btlmag_effectivity
        
    JSR BtlMag_Effect_CureAilment
    BCS :+

Eyedrops_Ineffective: ; (the other one is too far away...)
    DEC HiddenMagic
    LDA #BTLMSG_INEFFECTIVENOW 
    JMP DrawMessageBoxDelay_ThenClearAll    
    
  : JSR UseItem_CommonCode
    LDX #EYEDROPS
    LDA #BTLMSG_EYEDROPS
    
UseItem_End_RemoveItem:
    DEC items, X

UseItem_End:
    DEC HiddenMagic
    JMP DrawMessageBoxDelay_ThenClearAll 

UseItem_CommonCode:
    LDA btlmag_playerhitsfx
    JSR PlayBattleSFX  
    LDA btl_defender
    AND #$03
    JSR FlashCharacterSprite
    JMP BtlMag_SavePlayerDefenderStats ; save the cured ailment



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Player_DoEquipment [$B3B5 :: 0x333C5]
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

Player_DoEquipment:
    STA btl_attackid        ; record the attack ID
    LDA #$02                ; source = item
    BNE Player_DoMagicEffect
    
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Player_DoMagic [$B3C5 :: 0x333D5]
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

Player_DoMagic:             ; Player Magic
    STA btl_attackid        ; record the attack ID
    LDA #$00                ; source = magic
  ; JMP Player_DoMagicEffect; <- flow into
    
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Player_DoMagicEffect [$B3CA :: 0x333DA]
;;
;;    Does EVERYTHING for when a player is taking their turn and is doing
;;  a MAGIC/Item/ITEM action.
;;
;;  input:
;;    btl_attackid = the ID of the magic effect to perform
;;               A = the source (written to btlmag_magicsource)
;;               X = the target/defender
;;               Y = the attacker
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

Player_DoMagicEffect:
    STA btlmag_magicsource      ; record the source
    TYA                         ; Y = attacker, put attacker in A
    AND #$03
    ORA #$80
    STA btl_attacker            ; make sure high bit is set, and record them as an attacker
    STA btl_loadenemystats_counter                   ; ???  This value seems to never be used.
    STX btl_defender            ; X contains the defender, record them as well
    
    LDA #$00
    STA btlmag_playerhitsfx     ; player->player magic plays the 'heal' sound effect (ID 0)
    
   ; JSR ClearAltMessageBuffer   ; Clear alt message buffer
    LDA ConfusedMagic
    BNE :+
    JSR DrawAttackerBox         ; Draw the attacker name box
  : JSR DrawAttackBox           ; Draw the spell name box

    ;; JIGS - adding this:
    ; This may be a point of contention, if the Silent status is meant to act more like berserk, in that it only allows to attack...?
    ; But rather than re-write it so you randomly attack enemies and have no control...
    ; this is easier.    

    LDA btl_attacker            ; Load attacker's stat pointer
    JSR PrepCharStatPointers
    
    LDA btlmag_magicsource      ; if its magic, it will be 0
    BNE :+                      ; if its not 0, skip over checking for silence.    
    
    ;; back to original code
        
    LDY #ch_ailments - ch_stats  ; check their ailments to see if they're muted.  This is weird, as it's done for
    LDA (CharStatsPointer), Y    ; Magic (makes sense), items (weird), and Item (no sense at all)
    AND #AIL_MUTE                ; You could argue this is BUGGED
    BEQ :+
      JSR ClearSpecialMagicVariables
      LDA #BTLMSG_SILENCED                   ; if muted, just print "Silenced" message
      JMP DrawMessageBoxDelay_ThenClearAll   ; clear all boxes, and exit (don't actually do the spell effect)
      
  : LDA #$00
    STA btlmag_fakeout_ailments             ; clear the fakeout ailments
    
    JSR Battle_PrepareMagic                 ; Otherwise, load up magic effect info
    JSR Battle_PlayerMagic_CastOnTarget     ; And actually cast the spell
    JMP Battle_EndMagicTurn                 ; End the turn

ClearSpecialMagicVariables:
    LDA #0
    STA HiddenMagic
    STA ConfusedMagic
    RTS
    
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Battle_PlayerMagic_CastOnTarget [$B40A :: 0x3341A]
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

Battle_PlayerMagic_CastOnTarget:
 
    INC PlayMagicSound
    LDX btlmag_magicsource          ; X=0 for magic (indicating we should do magic casting animation)
    LDA btl_attacker
    AND #$7F
    JSR WalkForwardAndCastMagic
    
    LDA ConfusedMagic
    BEQ :+
    JSR ConfusedMagicTarget             ; is 0 if its to cast normally
    BNE :++                             ; so this branches if MAGDATA_TARGET is loaded reversed
    
  : LDY #MAGDATA_TARGET                 ; Check the target for the spell they're casting
    LDA (MagicPointer), Y
    
  : LSR A
    BCC :+
      JMP Battle_PlMag_TargetAllEnemies ; bit 0 set = target all opponents
  : LSR A
    BCC :+
      JMP Battle_PlMag_TargetOneEnemy   ; bit 1 set = target one opponent
  : LSR A
    BCC :+
      BCS Battle_PlMag_TargetSelf       ; bit 2 set = target self
  : LSR A
    BCC Battle_PlMag_TargetOnePlayer    ; (other) = target one ally
    BCS Battle_PlMag_TargetAllPlayers   ; bit 3 set = target all allies
    
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Battle_PlMag_TargetSelf [$B427 :: 0x33437]
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

Battle_PlMag_TargetSelf:
    JSR TargetSelf                      ; set target to yourself
    JSR DrawDefenderBox                 ; draw defender box
    JMP Battle_CastMagicOnPlayer        ; and cast the spell
    
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Battle_PlMag_IsPlayerValid  [$B430 :: 0x33440]
;;
;;    Used by Battle_PlMag_XXX routines to see if a player target is valid.
;;  Player targets are invalid if they are dead/stone.
;;
;;  input:  btl_entityptr_obrom - should point to target's OB stats
;;
;;  output: Z = set if target is valid, clear if invalid
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

Battle_PlMag_IsPlayerValid:
    LDY #ch_ailments - ch_stats
    LDA (CharStatsPointer), Y
    AND #AIL_DEAD | AIL_STONE
    RTS
    
    
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Battle_PlMag_TargetOnePlayer [$B437 :: 0x33447]
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

Battle_PlMag_TargetOnePlayer:
    JSR DrawDefenderBox                     ; Draw defender box
    JSR BtlMag_LoadPlayerDefenderStats      ; Load defender stats (and do "hit with magic" animation/sound)
    LDA btlmag_effect
    CMP #$06 ; is the spell Life?
    BEQ :+   ; if it is, skip checking if the player is valid
    CMP #$13 ; is the spell Life 2 or Soft?
    BCS :+   ; if it is, skip also
    
    JSR Battle_PlMag_IsPlayerValid          ; Is this a valid target?
    BEQ :+
      JMP DrawIneffective                   ; if not, show "Ineffective" and exit
  : JMP Battle_CastMagicOnPlayer_NoLoad     ; otherwise, do the actual spell (noload because we already loaded above)
    
    
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Battle_PlMag_TargetAllPlayers [$B448 :: 0x33458]
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

Battle_PlMag_TargetAllPlayers:
    LDA #$00
    STA btl_targetall_tmp               ; loop counter (loop through all 4 players)
    
@Loop:
    LDA btl_targetall_tmp               ; use loop counter as player index
    ORA #$80                            ; set high bit to indicate it is a player target
    STA btl_defender                    ; set as defender
    
    JSR DrawDefenderBox                 ; ... do magic casting stuff
    JSR BtlMag_LoadPlayerDefenderStats
    JSR Battle_PlMag_IsPlayerValid
    BEQ :+
      JSR DrawIneffective               ; show Ineffective if target is dead/stone
      JMP @Next
  : JSR Battle_CastMagicOnPlayer_NoLoad ; (NoLoad because we loaded above)
  
  @Next:
    JSR UndrawAllButTwoBoxes            ; undraw all but the Attacker/Attack boxes
    
    INC btl_targetall_tmp               ; loop through all 4 players.
    LDA btl_targetall_tmp
    CMP #$04
    BNE @Loop
    
    RTS
    
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Battle_PlMag_TargetOneEnemy [$B480 :: 0x33490]
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

Battle_PlMag_TargetOneEnemy:
   
    ;; JIGS - auto-target for magic:
    LDX btl_defender
    LDA AutoTargetOption
    BNE @SkipAutoTarget
    
    JSR DoesEnemyXExist
    BNE :+ ;@SkipAutoTarget ; they do exist, so cast on the intended target
    JMP Battle_CastMagicOnRandEnemy ; they don't exist, so pick a random one.
    
    @SkipAutoTarget:
    JSR DoesEnemyXExist
    BNE :+                          ; if the enemy does not exist
      JMP DrawIneffective           ;  just show "Ineffective" message, and exit
  : TXA
    JSR DrawDefenderBox
    JMP Battle_CastMagicOnEnemy

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Battle_PlMag_TargetAllEnemies [$B495 :: 0x334A5]
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

Battle_PlMag_TargetAllEnemies:
    LDA #$00
    STA btl_targetall_tmp           ; loop counter (loop through 9 enemy slots)
    
  @Loop:
    LDY btl_targetall_tmp
    LDA btl_enemyIDs, Y             ; get the ID of this enemy slot
    CMP #$FF                        ;  if FF, the enemy does not exist, so skip it
    BEQ @Next
      LDA btl_targetall_tmp         ; otherwise, if not FF, it's a valid target.
      STA btl_defender              ; make it the defender
      JSR DrawDefenderBox           ; draw the Defender box
      JSR Battle_CastMagicOnEnemy   ; do the actual spell
      JSR UndrawAllButTwoBoxes      ; undraw all but attacker and attack boxes
      
  @Next:
    INC btl_targetall_tmp
    LDA btl_targetall_tmp           ; Keep looping until all 9 slots targetted
    CMP #$09
    BNE @Loop
    
    RTS
    
    

    
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Enemy_DoMagicEffect  [$B4D5 :: 0x334E5]
;;
;;  input:  $9A = point to enemy's stats in RAM
;;            A = ID of effect they're casting (>= $42 for enemy attacks)
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    
Enemy_DoMagicEffect:
            @enram =    $9A     ; input - points to this enemy's stats in RAM
            
    STA btl_attackid                        ; store spell/attack we're using
    ;JSR ClearAltMessageBuffer
    LDA btl_attacker
    JSR GetEnemyRAMPtr
    
    LDA #$00
    STA btlmag_magicsource                  ; set magic source as 'magic'
    JSR DrawAttackBox
    
    LDA #$00
    STA btlmag_fakeout_ailments             ; clear the fakeout ailments
    
    JSR Battle_PrepareMagic                 ; load magic's stats
    
    LDY #en_ailments
    LDA (@enram), Y                         ; get this enemy's ailments
    AND #AIL_MUTE                           ; are they muted?
    BEQ :+
      ;JSR DrawCombatBox_Attack             ; if yes, draw their attack name
      LDA #BTLMSG_SILENCED                  ; but then just say "ineffective"
      JMP DrawMessageBoxDelay_ThenClearAll  ; then clear boxes and exit
    
  : LDY #MAGDATA_TARGET                 ; get the spell's Target byte
    LDA (MagicPointer), Y
    JSR Battle_EnemyMagic_CastOnTarget  ; and use it to cast this spell!
  ; JMP Battle_EndMagicTurn             ; <- flow into -- end the turn

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Battle_EndMagicTurn  [$B50E :: 0x3351E]
;;
;;  Called at the end of a player/enemy's turn to finalize some stuff.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

Battle_EndMagicTurn:
    JSR UndrawAllKnownBoxes
    
    LDA btlmag_fakeout_ailments     ; copy the 'fakeout' values to output
    STA btl_defender_ailments       ; See Battle_DoTurn for explanation
    LDA btlmag_fakeout_defindex
    STA btl_defender_index
    LDA btlmag_fakeout_defplayer
    STA battle_defenderisplayer
    
    JMP ClearSpecialMagicVariables ;; Clear Hidden and Confused variables
    
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Battle_EnemyMagic_CastOnTarget  [$B524 :: 0x33534]
;;
;;    Casts a magic spell!  (note:  not an enemy attack, this is for magic only).
;;
;;  input:
;;               A = spell's target value (as stored in MAGDATA_TARGET)
;;      btlmag_xxx = filled with magic info
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

Battle_EnemyMagic_CastOnTarget:
    LSR A
    BCC :+
      JMP Battle_CastMagicOnAllPlayers      ; 01 = target all opponents
      
  : LSR A
    BCC :+
      JMP Battle_CastMagicOnRandomPlayer    ; 02 = target one opponent
      
  : LSR A
    BCC :+
      BCS Battle_CastMagicOnSelf_Enemy      ; 04 = target self
      
  : LSR A
    BCC :+
      BCS Battle_CastMagicOnAllEnemies      ; 08 = target all allies
      
  : JMP Battle_CastMagicOnRandEnemy         ; 10 (others) = target one ally

  
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  TargetSelf  [$B53D :: 0x3354D]
;;
;;  defender = attacker
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

TargetSelf:
    LDA btl_attacker
    STA btl_defender
    RTS

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Battle_CastMagicOnSelf_Enemy  [$B544 :: 0x33554]
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

Battle_CastMagicOnSelf_Enemy:           ; pretty straight forward....
    JSR TargetSelf
    JSR DrawDefenderBox
    JMP Battle_CastMagicOnEnemy
    
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Battle_CastMagicOnRandEnemy  [$B54D :: 0x3355D]
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

Battle_CastMagicOnRandEnemy:
  @Loop:
    LDA #$00
    LDX #$08
    JSR RandAX
    TAX                     ; random enemy slot [0,8]
    
    JSR DoesEnemyXExist     ; does an enemy exist in that slot?
    BEQ @Loop               ; loop until we find an enemy that exists
    
    ; once we have an enemy that exists
    STX btl_defender            ; set it as the defender
    JSR DrawDefenderBox         ; print defender box
    JMP Battle_CastMagicOnEnemy ; and cast the spell!

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Battle_CastMagicOnAllEnemies  [$B563 :: 0x33573]
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

Battle_CastMagicOnAllEnemies:
    LDA #$00
    STA btl_targetall_tmp                  ; loop counter.  Loop through all 9 enemy slots
    
  @Loop:
    TAX                         ; Skip the enemy if the slot is empty
    JSR DoesEnemyXExist
    BEQ @Next
    
    ; Otherwise, the enemy exists!  Do it!
    LDA btl_targetall_tmp
    STA btl_defender                    ; set defender
    JSR GetEnemyRAMPtr                  ; prep pointers
    JSR DrawDefenderBox                 ; Draw defender box
    JSR Battle_CastMagicOnEnemy         ; cast it!
    JSR UndrawAllButTwoBoxes            ; undraw all boxes except for attacker/attack
    
  @Next:
    INC btl_targetall_tmp
    LDA btl_targetall_tmp
    CMP #$09                    ; loop until all 9 enemy slots targetted
    BNE @Loop
    
    RTS
    
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Battle_CastMagicOnEnemy  [$B593 :: 0x335A3]
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

Battle_CastMagicOnEnemy:
    JSR BtlMag_LoadEnemyDefenderStats   ; load enemy stats into defender mem
    JSR BtlMag_PerformSpellEffect       ; do the spell (modifying defender's stats)
    JMP BtlMag_SaveEnemyDefenderStats   ; update changed enemy stats.
 
 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Battle_CastMagicOnRandomPlayer  [$B59C :: 0x335AC]
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

Battle_CastMagicOnRandomPlayer:
    JSR GetRandomPlayerTarget       ; set the defender to a random player target
    LDA btl_randomplayer
    ORA #$80
    STA btl_defender
    
    JSR DrawDefenderBox             ; draw defender box
    JMP Battle_CastMagicOnPlayer    ; then cast the magic and exit!
    
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Battle_CastMagicOnPlayer  [$B5AD :: 0x335BD]
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

Battle_CastMagicOnPlayer:
    JSR BtlMag_LoadPlayerDefenderStats
Battle_CastMagicOnPlayer_NoLoad:
    JSR BtlMag_PerformSpellEffect
    JMP BtlMag_SavePlayerDefenderStats
    
    
    
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Battle_CastMagicOnAllPlayers  [$B5B6 :: 0x335C6]
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

Battle_CastMagicOnAllPlayers:
    LDA #$00
    STA btl_targetall_tmp                   ; loop counter (loop through all players)
    
  @Loop:
    LDA btl_targetall_tmp
    JSR PrepCharStatPointers                ; prep pointers to this player
    JSR Battle_PlMag_IsPlayerValid
    BNE :+
    
      LDA btl_targetall_tmp
      ORA #$80
      STA btl_defender                      ; set defender (high bit set to indicate it's a player)
      JSR DrawDefenderBox                   ; 
      JSR BtlMag_LoadPlayerDefenderStats    ; load their stats, play sound effect, and flash player graphic
      JSR Battle_CastMagicOnPlayer_NoLoad   ; then cast the magic on the player (NoLoad because we already loaded them above)
      JSR UndrawAllButTwoBoxes              ; undraw all but the attacker and attack boxes
      
  : INC btl_targetall_tmp                   ; inc loop counter
    LDA btl_targetall_tmp
    CMP #$04
    BNE @Loop                               ; loop until all 4 players have been targetted
   
    RTS

    

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  BtlMag_LoadPlayerDefenderStats  [$B602 :: 0x33612]
;;
;;    Loads battle magic stats for the defender, when the defender is a player character.
;;  Also plays the appropriate sound effect for when the player gets hit with magic, and flashes
;;  the character graphic.
;;
;;  input:  below values are expected to be set properly:
;;          - btlmag_playerhitsfx
;;          - btl_defender
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

BtlMag_LoadPlayerDefenderStats:
    LDA btlmag_playerhitsfx
    JSR PlayBattleSFX               ; play the appropriate sound effect for this spell
   
BtlMag_LoadPlayerDefenderStats_NoSFX:
    LDA btl_defender
    JSR PrepCharStatPointers        ; prep entityptr's
 
    LDY #ch_battlestate - ch_stats
    LDA (CharStatsPointer), Y
    AND #STATE_HIDDEN
    BEQ @NotHidden                  ; if they're not hidden, skip all this 
    
    LDA (CharStatsPointer), Y       ; reload to preserve low bits
    AND #~STATE_HIDDEN              ; remove hiding bit
    STA (CharStatsPointer), Y   
    
    LDA btl_attacker                ; check the attacker.  If the high bit is set (it's a player).
    BPL @EnemyAttacker     
    
    ;if player is "attacker", that is, the spell-caster...
    LDA #1
    STA Hidden    ; save backup Hidden variable as 1, so that when we get to re-hiding the character, it will do so.
    
    ;; Otherwise, Hidden is 0, so the character won't re-hide after getting hit by the enemy's magic.
    
    @EnemyAttacker:
    JSR UpdateSprites_BattleFrame ; and do a frame to unhide the character sprite before flashing it...?
    LDA btl_defender              ; and do this again... because updating sprites/drawing characters
    JSR PrepCharStatPointers      ; clobbered the pointer...
    
    @NotHidden:    
    LDA btl_defender
    AND #$03
    JSR FlashCharacterSprite        ; flash this character's graphic
  
    LDA #$0
    STA btlmag_defender_category    ;    This only matters for HARM spells, which check the Undead bit. 
    
    LDY #ch_ailments - ch_stats     ;
    LDA (CharStatsPointer), Y    
    STA btlmag_defender_ailments
    
    LDY #ch_curhp - ch_stats        ;
    LDA (CharStatsPointer), Y
    STA btlmag_defender_hp
    INY
    LDA (CharStatsPointer), Y
    STA btlmag_defender_hp+1
    
    INY ; #ch_maxhp - ch_stats        ; max HP from OB
    LDA (CharStatsPointer), Y
    STA btlmag_defender_hpmax
    INY
    LDA (CharStatsPointer), Y
    STA btlmag_defender_hpmax+1
    
    INY
    LDA (CharStatsPointer), Y
    STA btlmag_defender_battlestate
    
    LDY #ch_intelligence - ch_stats
    LDA (CharStatsPointer), Y
    STA btlmag_defender_intelligence
    
    LDY #ch_speed - ch_stats
    LDA (CharStatsPointer), Y
    STA btlmag_defender_speed
    
    INY ; #ch_damage - ch_stats
    LDA (CharStatsPointer), Y
    STA btlmag_defender_damage
    
    INY ; #ch_hitrate - ch_stats
	LDA (CharStatsPointer), Y
	STA btlmag_defender_hitrate    
    
    INY ; #ch_defense - ch_stats
    LDA (CharStatsPointer), Y
    STA btlmag_defender_defense
    
    INY ; #ch_evasion - ch_stats
    LDA (CharStatsPointer), Y
    STA btlmag_defender_evasion
    
    INY ; #ch_magicdefense - ch_stats
    LDA (CharStatsPointer), Y
    STA btlmag_defender_magicdefense

    INY ; #ch_elementresist - ch_stats
    LDA (CharStatsPointer), Y
    STA btlmag_defender_elementresist

    INY ; #ch_elementweak - ch_stats
    LDA (CharStatsPointer), Y
    STA btlmag_defender_elementweakness
    
    LDY #ch_numhitsmult - ch_stats
    LDA (CharStatsPointer), Y
    STA btlmag_defender_numhitsmult
    
    LDY #ch_weaponelement - ch_stats
    LDA (CharStatsPointer), Y
    STA btlmag_defender_weaponelement
    
    INY ; #ch_weaponcategory - ch_stats
    LDA (CharStatsPointer), Y
    STA btlmag_defender_weaponcategory
    
    ;; And now re-hide after flashing.   
    
    LDA Hidden                  ; if Hidden is 1, re-hide character... if 0, nothing changes.
    BEQ :+
    JSR HideCharacter_Save
    ; will clear Hidden ; when Caster steps back, they won't go into hiding again anyway.
 :  RTS
    
 
  ;; JIGS - loading and saving stats could be shortened by making a .word table of the ch_xxx - ch_stats stuff
  ;; and another of the btlmag_defender_xxx stuff, and going through a loop...
  ;; make a note to test this, see if I can use it for ALL attacker/defender stuff (physical too why not)
  ;; see the way the game loads enemy ROM stats for ideas.
  


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  BtlMag_LoadEnemyDefenderStats  [$B6C8 :: 0x336D8]
;;
;;    Loads battle magic stats for the defender, when the defender is an enemy.
;;  Also does the explosion effect, since any magic targetting an enemy will have that effect.
;;
;;  input:   btl_defender = enemy index.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

BtlMag_LoadEnemyDefenderStats:
    LDA btl_defender
    JSR GetEnemyRAMPtr     
    
    LDY #en_hpmax               
    LDA (EnemyRAMPointer), Y    ; Max HP 
    STA btlmag_defender_hpmax
    INY
    LDA (EnemyRAMPointer), Y
    STA btlmag_defender_hpmax+1
    
    INY 
    LDA (EnemyRAMPointer), Y    ; Morale
    STA btlmag_defender_morale
    
    INY ; ai
    INY                         
    LDA (EnemyRAMPointer), Y    ; Evade 
    STA btlmag_defender_evasion
    
    INY
    LDA (EnemyRAMPointer), Y    ; Defense
    STA btlmag_defender_defense ; 
    
    INY ; numhits
    INY
    LDA (EnemyRAMPointer), Y    ; hit rate
    STA btlmag_defender_hitrate ; 
    
    INY                         ; Damage
    LDA (EnemyRAMPointer), Y    ; 
    STA btlmag_defender_damage
    
    LDY #en_category            
    LDA (EnemyRAMPointer), Y    ; Category
    STA btlmag_defender_category
    
    INY                          
    LDA (EnemyRAMPointer), Y    ; Magic Defense
    STA btlmag_defender_magicdefense
    
    INY                        
    LDA (EnemyRAMPointer), Y    ; Elemental weakness
    STA btlmag_defender_elementweakness
    
    INY                        
    LDA (EnemyRAMPointer), Y    ; Elemental Resistance
    STA btlmag_defender_elementresist
    
    INY                        
    INY
    LDA (EnemyRAMPointer), Y    ; Speed
    STA btlmag_defender_speed
    
    LDY #en_numhitsmult         
    LDA (EnemyRAMPointer), Y    ; Hit multiplier
    STA btlmag_defender_numhitsmult
    
    INY                         
    LDA (EnemyRAMPointer), Y    ; Ailments
    STA btlmag_defender_ailments
    
    INY 
    LDA (EnemyRAMPointer), Y    ; Current HP
    STA btlmag_defender_hp
    INY
    LDA (EnemyRAMPointer), Y
    STA btlmag_defender_hp+1
    
    JMP DoExplosionEffect


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  BtlMag_SaveEnemyDefenderStats  [$B757 :: 0x33767]
;;
;;    Saved stats that the spell effect may have changed back to enemy stat RAM.
;;
;;  BUGGED:
;;    This routine does not save 'btlmag_defender_elemresist' anywhere, and therefore
;;  spells which change enemy resistence (like XFER, AFIR, etc) have no effect when cast
;;  on enemies.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

BtlMag_SaveEnemyDefenderStats:
    LDA btl_defender                ; get defender slot index
    JSR GetEnemyRAMPtr              ; use it to get a pointer to their stats in RAM
    
    LDY #en_morale
    LDA btlmag_defender_morale
    STA (EnemyRAMPointer), Y    ; Morale
        
    INY ; ai
    INY                         
    LDA btlmag_defender_evasion
    STA (EnemyRAMPointer), Y    ; Evade 
    
    INY
    LDA btlmag_defender_defense ; 
    STA (EnemyRAMPointer), Y    ; Defense
    
    INY ; numhits
    INY
    LDA btlmag_defender_hitrate ; 
    STA (EnemyRAMPointer), Y    ; hit rate
    
    INY                         ; Damage
    LDA btlmag_defender_damage
    STA (EnemyRAMPointer), Y    ; 
    
    LDY #en_category            
    LDA btlmag_defender_category
    STA (EnemyRAMPointer), Y    ; Category
    
    INY                          
    LDA btlmag_defender_magicdefense
    STA (EnemyRAMPointer), Y    ; Magic Defense
    
    INY                        
    LDA btlmag_defender_elementweakness
    STA (EnemyRAMPointer), Y    ; Elemental weakness
    
    INY                        
    LDA btlmag_defender_elementresist
    STA (EnemyRAMPointer), Y    ; Elemental Resistance
    
    INY                        
    INY
    LDA btlmag_defender_speed
    STA (EnemyRAMPointer), Y    ; Speed
    
    LDY #en_numhitsmult         
    LDA btlmag_defender_numhitsmult
    STA (EnemyRAMPointer), Y    ; Hit multiplier
    
    INY                         
    LDA btlmag_defender_ailments
    STA (EnemyRAMPointer), Y    ; Ailments
    
    INY 
    LDA btlmag_defender_hp
    STA (EnemyRAMPointer), Y    ; Current HP
    INY
    LDA btlmag_defender_hp+1
    STA (EnemyRAMPointer), Y
    
    RTS
    
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  BtlMag_SavePlayerDefenderStats  [$B790 :: 0x337A0]
;;
;;    Saved stats that the spell effect may have changed back to IB player stats
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

BtlMag_SavePlayerDefenderStats:
    LDA btl_defender
    JSR PrepCharStatPointers
        
    LDA btlmag_defender_ailments
    LDY #ch_ailments - ch_stats
    STA (CharStatsPointer), Y       ; ailments
    
    LDA btlmag_defender_hp          ; HP
    LDY #ch_curhp - ch_stats
    STA (CharStatsPointer), Y
    LDA btlmag_defender_hp+1
    INY
    STA (CharStatsPointer), Y
    
    LDY #ch_battlestate - ch_stats
    LDA btlmag_defender_battlestate
    STA (CharStatsPointer), Y
    
    LDA btlmag_defender_intelligence
    LDY #ch_intelligence - ch_stats
    STA (CharStatsPointer), Y
    
    LDA btlmag_defender_speed
    LDY #ch_speed - ch_stats
    STA (CharStatsPointer), Y
        
    INY ; #ch_damage - ch_stats
    LDA btlmag_defender_damage
    STA (CharStatsPointer), Y
    
    INY ; #ch_hitrate - ch_stats
	LDA btlmag_defender_hitrate    
    STA (CharStatsPointer), Y
    
    INY ; #ch_defense - ch_stats
    LDA btlmag_defender_defense
    STA (CharStatsPointer), Y
    
    INY ; #ch_evasion - ch_stats
    LDA btlmag_defender_evasion
    STA (CharStatsPointer), Y
    
    INY ; #ch_magicdefense - ch_stats
    LDA btlmag_defender_magicdefense
    STA (CharStatsPointer), Y

    INY ; #ch_elementresist - ch_stats
    LDA btlmag_defender_elementresist
    STA (CharStatsPointer), Y

    INY ; #ch_elementweak - ch_stats
    LDA btlmag_defender_elementweakness
    STA (CharStatsPointer), Y
    
    LDY #ch_numhitsmult - ch_stats
    LDA btlmag_defender_numhitsmult
    STA (CharStatsPointer), Y
    
    LDY #ch_weaponelement - ch_stats
    LDA btlmag_defender_weaponelement
    STA (CharStatsPointer), Y
       
    INY ; #ch_weaponcategory - ch_stats
    LDA btlmag_defender_weaponcategory
    STA (CharStatsPointer), Y
    
    JMP DrawCharacterStatus                 ; update icons to reflect any status changes
    ; while this is done at the end of every turn, spells that cast over the party can show their effect immediately
    
    
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  BtlMag_PerformSpellEffect  [$B7CD :: 0x337DD]
;;
;;    Actually do the effect of the spell!
;;
;;  output:  'btlmag_fakeout_xxx' vars (see Battle_DoTurn for an explanation)
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

BtlMag_PerformSpellEffect:
    LDA btlmag_effect               ; Get this spell's effect ID
    ASL A                           ; x2 to use as index
    TAX
    LDA @jumptable_MagicEffect, X
    STA btltmp+6
    LDA @jumptable_MagicEffect+1, X
    STA btltmp+7                    ; pointer to spell logic in btltmp+6
    
    LDA btlmag_defender_ailments    ; backup defender's original ailments
    STA btlmag_ailment_orig
    
    LDA #0
    STA btlmag_spellconnected       ; initialize spell connected (have it miss by default)
    
    JSR @DoMagicEffect              ; Do the actual effect!
    JSR DrawMagicMessage            ; print appropriate battle message for this spell effect
    
    LDA #MATHBUF_MAGDEFENDERHP      ; if the spell reduced their HP to or below 0, add the 'DEAD' ailment
    JSR MathBuf_NZ
    BEQ @AddDeadAilment
    BMI @AddDeadAilment
    BPL :+                          ; HP > 0, so jump ahead to HandleAilmentChanges
    
  @AddDeadAilment:
      LDA btlmag_defender_ailments
      ORA #AIL_DEAD
      STA btlmag_defender_ailments
      
  : JMP BtlMag_HandleAilmentChanges ; Handle changes to defender's ailments... and exit!
    
  @DoMagicEffect:
    CLC
    JMP (btltmp+6)      ; call the routine from our jump table

    @jumptable_MagicEffect:
        .WORD DrawIneffective        ; 00   ; Spell has no in-battle effect
        .WORD BtlMag_Effect_Damage          ; 01   
        .WORD BtlMag_Effect_DamageUndead    ; 02   
        .WORD BtlMag_Effect_InflictAilment  ; 03   
        .WORD BtlMag_Effect_Slow            ; 04   
        .WORD BtlMag_Effect_LowerMorale     ; 05   
        .WORD BtlMag_Effect_Life            ; 06   
        .WORD BtlMag_Effect_RecoverHP       ; 07   
        .WORD BtlMag_Effect_CureAilment     ; 08   
        .WORD BtlMag_Effect_AbsorbUp        ; 09   
        .WORD BtlMag_Effect_ElemResist      ; 0A   
        .WORD BtlMag_Effect_AttackUp        ; 0B   
        .WORD BtlMag_Effect_Fast            ; 0C   
        .WORD BtlMag_Effect_AttackUp2       ; 0D   
        .WORD BtlMag_Effect_EvadeDown       ; 0E   
        .WORD BtlMag_Effect_CureAll         ; 0F   
        .WORD BtlMag_Effect_EvadeUp         ; 10   
        .WORD BtlMag_Effect_RemoveResist    ; 11   
        .WORD BtlMag_Effect_InflictAilment2 ; 12   
        .WORD BtlMag_Effect_Life2           ; 13   
        .WORD BtlMag_Effect_CureAilment     ; 14   ; for Soft
        .WORD BtlMag_Effect_Regen           ; 15
        

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  BtlMag_PrepHitAndDamage  [$B82D :: 0x3383D]
;;
;;    Prepares hit rate and damage for a spell.  Specifically it does the following:
;;
;;  hitrate   += spell hit rate
;;  hitrate   -= defender's magdef
;;  damage     = rand[ damage, damage*2 ]
;;  magrandhit = rand[ 0, 200 ]
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

BtlMag_PrepHitAndDamage:
    LDA #MATHBUF_HITCHANCE
    LDX btlmag_hitrate
    JSR MathBuf_Add             ; math_hitchance += spell's base hit rate
    
    LDA #MATHBUF_HITCHANCE
    LDX btlmag_defender_magicdefense
    JSR MathBuf_Sub             ; math_hitchance -= defender's magdef
    
    LDA #0
    LDX math_basedamage
    JSR RandAX
    TAX                         ; X = rand[ 0, spelldamage ]
    
    LDA #MATHBUF_BASEDAMAGE
    JSR MathBuf_Add             ; math_basedamage = rand[ spelldamage, spelldamage*2 ]
    
    JSR Random_0_200
    JMP WriteAToMagRandHit      ; math_magrandhit = rand[ 0, 200 ]


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  BtlMag_CalcElemHitChance  [$B851 :: 0x33861]
;;
;;    Loads base hit chance and adds elemental bonus/penalty.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

BtlMag_CalcElemHitChance:
    JSR BtlMag_LoadBaseHitChance        ; load base hit chance
    
    LDA btlmag_element
    AND btlmag_defender_elementresist
    BEQ :+                              ; if defender resists
      LDA #0                            ; ... reset hit chance to zero
      STA math_hitchance
      STA math_hitchance+1
      
  : LDA btlmag_element                  
    AND btlmag_defender_elementweakness
    BEQ BtlMag_LoadBaseHitChance_RTS    ; (RTS)
    LDA #0                              ; if defender is weak to element
    LDX #40                             ;   add +40 to hit chance
    JMP MathBuf_Add
    
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  BtlMag_LoadBaseHitChance  [$B873 :: 0x33883]
;;
;;    Loads the base hit chance for a spell in the math buffer.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

BtlMag_LoadBaseHitChance:
    LDA #<148               ; base hit chance of 148
    STA math_hitchance
    LDA #>148
    STA math_hitchance+1
    
BtlMag_LoadBaseHitChance_RTS:
    RTS

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  BtlMag_DidSpellConnect  [$B87E :: 0x3388E]
;;
;;    Sets C if a spell connects with its target, or clears C if it misses
;;
;;  input:  math_hitchance  = chance for the spell to connect
;;          math_magrandhit = random number between 0,200
;;
;;  output: C = set if spell connected
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

BtlMag_DidSpellConnect:
    LDY #MATHBUF_HITCHANCE      ; compare hit chance
    LDX #MATHBUF_MAGRANDHIT     ; to mag rand hit
    JMP MathBuf_Compare

    
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  BtlMag_MarkSpellConnected  [$B885 :: 0x33895]
;;
;;    Indicates that the spell has connected with its target
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

BtlMag_MarkSpellConnected:
    LDA #1
    STA btlmag_spellconnected       ; set spellconnected var to nonzero to indicate it connected
    RTS
    
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  BtlMag_ZeroHitChance  [$B88B :: 0x3389B]
;;
;;    Zero the spell's hit chance.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

BtlMag_ZeroHitChance:
    LDA #0
    STA math_hitchance
    STA math_hitchance+1
    RTS
    

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  BtlMag_Effect_Damage  [$B899 :: 0x338A9]
;;
;;    Routine for in-battle spell logic:   Do damage.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

BtlMag_Effect_Damage:
    JSR BtlMag_MarkSpellConnected           ; damage spells always connect
    JSR BtlMag_LoadBaseHitChance            ; load base hit chance (since damage always hits, this becomes more of a "critical" chance)
    JSR PutEffectivityInDamageMathBuf       ; Load spell effectivity into 'damage' math buffer
    
    LDA btlmag_element
    AND btlmag_defender_elementresist          ; see if the defender resists this element
    BEQ :+                                  ; if they do...
      JSR BtlMag_ZeroHitChance              ; ... zero the hit/crit chance
      LSR math_basedamage+1                 ; and halve the damage
      ROR math_basedamage
      
  : LDA btlmag_element
    AND btlmag_defender_elementweakness        ; see if they are weak to the element
    BEQ :+                                  ; if yes...
      LDA #MATHBUF_HITCHANCE
      LDX #40
      JSR MathBuf_Add                       ; crit bonus of +40
      
                                            ; damage *= 1.5
      LDX #MATHBUF_BASEDAMAGE               ;   copy 1x damage into temp buffer
      LDY #$02                              ;  (use math buf 2 as a temp buffer)
      JSR MathBuf_CopyXToY
      
      LSR math_basedamage+1                 ;   damage *= 0.5
      ROR math_basedamage
      
      LDA #MATHBUF_BASEDAMAGE               ;   then add the backup back into the damage
      LDX #$02                              ;   resulting in 1.5 damage
      LDY #MATHBUF_BASEDAMAGE
      JSR MathBuf_Add16
      
    ; Once damage is set up...
  : JSR BtlMag_PrepHitAndDamage             ; Get hit/damage stuff into math buffers
  ; JMP BtlMag_ApplyDamage                  ; <- Flow into

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  BtlMag_ApplyDamage  [$B8DB :: 0x338EB]
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

BtlMag_ApplyDamage:
    LDA math_magrandhit
    CMP #200
    BEQ :+                          ; if the hit/crit roll was 200, this is NOT a crit
      JSR BtlMag_DidSpellConnect    ; See if the spell connected as a critical
      BCC :+                        ; if yes...
        ASL math_basedamage         ; ... do 2x damage
        ROL math_basedamage+1
        
  : LDA #MATHBUF_MAGDEFENDERHP
    LDX #MATHBUF_MAGDEFENDERHP
    LDY #MATHBUF_BASEDAMAGE
    JSR MathBuf_Sub16               ; HP -= damage
    JMP DrawDamageBox               ; Then draw the damage combat box and exit.
    
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  PutEffectivityInDamageMathBuf  [$B8F9 :: 0x33909]
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

PutEffectivityInDamageMathBuf:
;    LDY #ch_intelligence - ch_stats
;    LDA (CharStatsPointer), Y

;    LSR A ; divide by 2
;    LSR A ; divide by 4
;    LSR A ; divide by 8
;    STA MMC5_tmp
;    LSR A ; divide by 16
;    CLC
;    ADC MMC5_tmp
    
    ;Int/16 + Int/8 ... so an Intelligence stat of 80 would give +15 damage
    
;    ADC btlmag_effectivity

;; JIGS - someone else will have to figure that one out...

    LDA btlmag_effectivity          ; move effectivity into the math buffer!
    STA math_basedamage
    LDA #0
    STA math_basedamage+1
    RTS
    
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  BtlMag_Effect_DamageUndead  [$B905 :: 0x33915]
;;
;;    Routine for in-battle spell logic:   Damage undead.
;;
;;    Note that this routine does NOT check elemental resistence/weakness.  Therefore, all
;;  damage undead spells are treated as non-elemental even if they are assigned an element.
;;  One could argue this is BUGGED -- although HARM spells are non-elemental in the game
;;  anyway so it doesn't really matter.
;;
;;    An easy fix for this would be to check the category first, and simply jump to the normal
;;  BtlMag_Effect_Damage if they are undead... instead of jumping to BtlMag_ApplyDamage
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

BtlMag_Effect_DamageUndead:
    JSR BtlMag_LoadBaseHitChance        ; Load base hit/crit chance
    JSR PutEffectivityInDamageMathBuf   ; load up base damage
    JSR BtlMag_PrepHitAndDamage         ; crit rate, randomize damage
    
    LDA btlmag_defender_category        ; Check defender category to see if they are undead...
    AND #CATEGORY_UNDEAD
    BNE :+                              ; if not...
      LDA #0
      RTS                               ; and exit.
      
    ; Otherwise, if defender is undead..
  : JSR BtlMag_MarkSpellConnected       ; Mark the spell as connected
    JMP BtlMag_ApplyDamage              ; And do the actual damage!
    
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  BtlMag_DoStatPrep  [$B929 :: 0x33939]
;;
;;    Prep hit rate and damage for a spell.  Factors elemental resistence into hit rate.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

BtlMag_DoStatPrep:
    JSR BtlMag_CalcElemHitChance        ; apply elemental bonus/penalty to spell hit chance
    JMP BtlMag_PrepHitAndDamage

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  BtlMag_Effect_InflictAilment  [$B92F :: 0x3393F]
;;
;;    Routine for in-battle spell logic:   Inflict ailment.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

BtlMag_Effect_InflictAilment:
    JSR BtlMag_DoStatPrep
    LDA math_magrandhit             ; get random hit roll
    CMP #200                        ; if rolled an even 200, skip ahead to a 'miss'
    BEQ @Miss
      JSR BtlMag_DidSpellConnect
      BCC @Miss
        JSR BtlMag_ApplyAilments
        JMP BtlMag_MarkSpellConnected
  
  @Miss:
    RTS
    
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  BtlMag_ApplyAilments  [$B94A :: 0x3395A]
;;
;;    Applies the magic's ailments to the defender.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

BtlMag_ApplyAilments:
    LDA btlmag_effectivity          ; effectivity byte is the ailment(s) to add
    PHA                             ; back it up
    AND btlmag_defender_ailments    ; See if defender has this ailment (or really, any of these ailment) already
    BEQ :+                          ;   If yes...
      JSR DrawIneffective    ;   ... show "Ineffective" message
      
  : PLA                             ; restore ailment byte
    ORA btlmag_defender_ailments    ; add to existing ailments
    STA btlmag_defender_ailments
    RTS                             ; and exit
    
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  BtlMag_Effect_Slow  [$B95E :: 0x3396E]
;;
;;    'Slow' effect reduces the defender's hit mulitplier, which negates 'FAST'
;;  if they are fasted, or reduces their maximum hit count to 1 otherwise.
;;
;;    Note you could argue that this spell is BUGGED, since if the target is already slowed, this spell
;;  will have no effect, but will still visually indicate that it worked.  It would be more appropriate
;;  to print "ineffective" to show that it doesn't stack.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

BtlMag_Effect_Slow:
    JSR BtlMag_DoStatPrep           ; Load up hit chance w/ element applied
    LDA math_magrandhit
    CMP #200                        ; hit roll of 200 = guaranteed miss
    BEQ @Done
    JSR BtlMag_DidSpellConnect      ; See if they connected.  If not...
    BCC @Done                       ;  ... miss
    
    JSR BtlMag_MarkSpellConnected   ; Otherwise, mark that this connected
    DEC btlmag_defender_numhitsmult ; Decrease their hit multiplier
    BPL @Done                       ;   if it wrapped...
    INC btlmag_defender_numhitsmult ;   ... INC it to undo it.  (This is where the 'bug' is, btlmag_spellconnected should be zero'd here)
        
    ;; JIGS - fixing bug:
    LDA #0
    STA btlmag_spellconnected  
  
  @Done:
  ; RTS                             ; <- Flow into

;; Common RTS that is branched to by various surrounding code
BtlMag_Effect_Slow_RTS:
    RTS
    
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  BtlMag_Effect_LowerMorale  [$B979 :: 0x33989]
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

BtlMag_Effect_LowerMorale:
    JSR BtlMag_DoStatPrep           ; Load up hit chance w/ element applied
    LDA math_magrandhit
    CMP #200                        ; hit roll of 200 = automatic miss
    BEQ BtlMag_Effect_Slow_RTS
    
    JSR BtlMag_DidSpellConnect      ; see if the spell connected
    BCC BtlMag_Effect_Slow_RTS      ; if not, jump ahead to an RTS
    
    LDA btlmag_defender_morale      ; subtract spell effectivity from defender morale
    SEC
    SBC btlmag_effectivity
    BCS :+
        LDA #0                      ; cap at 0 (don't let it wrap)
  : STA btlmag_defender_morale
    JMP BtlMag_MarkSpellConnected   ; then mark the spell as connected and exit.

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  BtlMag_Effect_RecoverHP  [$B999 :: 0x339A9]
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

BtlMag_Effect_Regen:
    LDA btlmag_defender_ailments    ; Check defender ailment
    AND #AIL_DEAD
    BNE BtlMag_Effect_Slow_RTS       ; If they're dead, do nothing
    
    JSR BtlMag_MarkSpellConnected
    
    LDA btl_defender                 ; check if player or enemy
    BMI :+                           ; if player, jump ahead
       LDA btlmag_defender_category
       ORA #CATEGORY_REGEN
       STA btlmag_defender_category
       RTS                           ; note that if Regen is cast on an enemy... its permanent.
    
  : LDA btlmag_defender_battlestate
    AND #STATE_HIDDEN | STATE_GUARDING ; $90
    ; clear out everything but hiding and guarding
    ORA btlmag_effectivity          ; add in heal potency (2, 4, or 6)
    ORA btlmag_hitrate              ; add in amount of turns to heal for
    STA btlmag_defender_battlestate
    RTS

BtlMag_Effect_Life2:    
    JSR BtlMag_Effect_CureAilment   ; cure death
    BCS BtlMag_SetHPToMax           ; and max out HP
    RTS ; target was not dead and it failed
    
BtlMag_Effect_Life:    
    JSR BtlMag_Effect_CureAilment   ; cure death
    BCS :+
       RTS ; target was not dead and it failed
  : LDA #$10                        ; and set cure effectivity to same as Cure 1
    STA btlmag_effectivity

BtlMag_Effect_RecoverHP:
    JSR BtlMag_MarkSpellConnected   ; HP recovery always connects (doesn't it miss if dead?)
    
    LDA btlmag_defender_ailments    ; Check defender ailment
    AND #AIL_DEAD
    BNE BtlMag_Effect_Slow_RTS      ; If they're dead, do nothing
    
    LDA btlmag_effectivity          ; This block just does:  X = rand[ effectivity, effectivity*2 ], capping at 255
    TAX
    LDA #0
    JSR RandAX                      ;   random between [0,effectivity]
    CLC
    ADC btlmag_effectivity          ;   random between [effectivity, effectivity*2]
    BCC :+
      LDA #$FF                      ;   (cap at 255)
  : TAX
  
    LDA #MATHBUF_MAGDEFENDERHP      ; Add X to defender's HP
    JSR MathBuf_Add
    
    LDX #MATHBUF_MAGDEFENDERMAXHP
    LDY #MATHBUF_MAGDEFENDERHP
    JSR MathBuf_Compare             ; Compare current HP with max HP
    BCC BtlMag_Effect_CureAil_RTS   ; if hp < maxhp, just exit
    ;JMP BtlMag_SetHPToMax           ; otherwise, set HP to the maximum   (strangely, this could just flow into it, but it actually JMPs)
    
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  BtlMag_SetHPToMax  [$B9C6 :: 0x339D6]
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

BtlMag_SetHPToMax:
    LDX #MATHBUF_MAGDEFENDERMAXHP   ; just copy the defender's max HP over to their actual HP
    LDY #MATHBUF_MAGDEFENDERHP
    JMP MathBuf_CopyXToY
    
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  BtlMag_Effect_CureAilment  [$B9CD :: 0x339DD]
;;
;;    Note that strangely this WILL cure the 'death' ailment, but it does not set the HP
;;  to a nonzero value, so they'll just die again.  It also will cure the STONE ailment...
;;  yet strangely SOFT is not usable in battle (why not?)
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

BtlMag_Effect_CureAilment:
    LDA btlmag_defender_ailments    ; Get the defender's ailments
    AND btlmag_effectivity          ; See if they have any of the ailments we're trying to cure
    BEQ BtlMag_Effect_CureAil_RTS   ;  If not, no effect, just exit
    
    LDA btlmag_effectivity          ; Otherwise, cure ailment bits
    EOR #$FF
    AND btlmag_defender_ailments
    STA btlmag_defender_ailments
    JSR BtlMag_MarkSpellConnected   ; and mark the spell as connected
  ; RTS                             ; <- flow into
    SEC
    RTS   ; C set if it worked
  
    
;; Common RTS that is branched to by various surrounding code
BtlMag_Effect_CureAil_RTS:
    CLC                      ; C cleared if it didn't work
    RTS
    
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  BtlMag_Effect_AbsorbUp  [$B9E4 :: 0x339F4]
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

BtlMag_Effect_AbsorbUp:
    LDA btlmag_defender_defense      ; get defender absorb
    ADC btlmag_effectivity          ; add effectivity to it
    BCC :+
      LDA #$FF                      ; (cap at 255)
  : STA btlmag_defender_defense      ; that's our new absorb!
    JMP BtlMag_MarkSpellConnected   ; This spell always connects.
    
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  BtlMag_Effect_ElemResist  [$B9F4 :: 0x33A04]
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

BtlMag_Effect_ElemResist:
    LDA btlmag_effectivity          ; pretty straight forward...
    ORA btlmag_defender_elementresist
    STA btlmag_defender_elementresist
    JMP BtlMag_MarkSpellConnected
    
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  BtlMag_Effect_AttackUp  [$BA00 :: 0x33A10]
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

BtlMag_Effect_AttackUp:
    LDA btlmag_defender_damage    ; identical to BtlMag_Effect_AbsorbUp, but modify attack power instead
    ADC btlmag_effectivity
    BCC :+
      LDA #$FF
  : STA btlmag_defender_damage
    JMP BtlMag_MarkSpellConnected
    
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  BtlMag_Effect_Fast  [$BA10 :: 0x33A20]
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

BtlMag_Effect_Fast:
    JSR BtlMag_MarkSpellConnected   ; Always connects (except when maxed -- this will be undone then)
    INC btlmag_defender_numhitsmult ; Increase hit multiplier
    
    LDA btlmag_defender_numhitsmult
    CMP #3
    BCC :+                          ; if hit multiplier is >= 3
      LDA #0
      STA btlmag_spellconnected     ; undo the connect (this spell has no effect)
      LDA #$02                      ; and max the multiplier at 2
      
  : STA btlmag_defender_numhitsmult
    RTS
    
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  BtlMag_Effect_AttackUp2  [$BA28 :: 0x33A38]
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

BtlMag_Effect_AttackUp2:
    ;LDA $6884                       ; BUGGED - this is *probably* supposed to be using the spell hit-rate value
    
    LDA btlmag_defender_hitrate     ; JIGS - FIXED?
    
    ADC btlmag_hitrate              ;   as a HIT bonus and then the effectivity as a DAMAGE bonus, but defender's
    BCC :+                          ;   hit rate is not loaded into memory, so this end up adding it to
      LDA #$FF                      ;   some other part of mem.  Note that this doesn't matter in the original
 : ;STA $6884                       ;   game, as TMPR and SABR both have 0 for the spell's hit rate.

    STA btlmag_defender_hitrate    ; JIGS - changing this too?
  
            ; Code here is a duplicate of BtlMag_Effect_AttackUp.  You could just JMP there and save
            ;   all this space.
            
        ;; JIGS - sound good
    	JMP BtlMag_Effect_AttackUp        
            
;    LDA btlmag_effectivity          ; Add the spell effectivity to the defender's attack power.
;    CLC
;    ADC btlmag_defender_strength
;    BCC :+
;      LDA #$FF                      ; cap at 255
;  : STA btlmag_defender_strength
;    JMP BtlMag_MarkSpellConnected   ; Indicate spell connected.

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  BtlMag_Effect_EvadeDown  [$BA46 :: 0x33A56]
;;
;;      This spell effect is BUGGED and will always miss its target.  It's actually a very easy
;;  fix -- all you have to do is change the offending JMP to a BEQ
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

BtlMag_Effect_EvadeDown:
    JSR BtlMag_DoStatPrep           ; prep hit rate & apply elemental resistance and stuff
    LDA math_magrandhit
    CMP #200                        ; hit roll of 200 = automatic miss
    ;JMP @Done                       ; BUGGED -- this should be BEQ, not JMP.  Since it always jumps,
                                    ;   this means the spell never has any effect and always misses!
        ; due to bug, this code is never reached, but it works as you'd expect:
        
    ;; JIGS - fixing bug
    BEQ @Done
        
    JSR BtlMag_DidSpellConnect      ; see if the spell connected
    BCC @Done                       ; if not, exit
    LDA btlmag_defender_evasion       ; if yes, subtract effectivity from defender's evade
    SEC
    SBC btlmag_effectivity
    BCS :+
      LDA #0                        ; clip at 0
  : STA btlmag_defender_evasion
    JSR BtlMag_MarkSpellConnected   ; then mark that the spell connected
  @Done:
    RTS
    
    
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  BtlMag_Effect_CureAll  [$BA68 :: 0x33A78]
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

BtlMag_Effect_CureAll:
    JSR BtlMag_SetHPToMax           ; Fill HP to max
    LDA #0                          ; and zero ailments, curing all of them
    STA btlmag_defender_ailments
    JMP BtlMag_MarkSpellConnected   ; mark as connected

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  BtlMag_Effect_EvadeUp  [$BA73 :: 0x33A83]
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

BtlMag_Effect_EvadeUp:
    LDA btlmag_defender_evasion           ; Same as BtlMag_Effect_AttackUp, but increases evade instead
    ADC btlmag_effectivity
    BCC :+
      LDA #$FF
  : STA btlmag_defender_evasion
    JMP BtlMag_MarkSpellConnected
    
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Random_0_200  [$BA83 :: 0x33A93]
;;
;;  Gets a random number between [0,200]
;;
;;    This is used for "hit rolls".  The attack/magic is considered a hit if this
;;  number is less than a calculated hit rate.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

Random_0_200:
    LDA #0
    LDX #200
    JSR RandAX
    RTS
    
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  WriteAToMagRandHit  [$BA8B :: 0x33A9B]
;;
;;  Writes A to mag rand hit entry in math buffer.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

WriteAToMagRandHit:
    STA math_magrandhit
    LDA #0
    STA math_magrandhit+1
    RTS
    
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  BtlMag_Effect_RemoveResist  [$BA94 :: 0x33AA4]
;;
;;    This routine does its own version of elemental resistance checking to see about the elemental
;;  hit bonus -- and really, there's [little] reason for it.  It could be SERIOUSLY trimmed by calling
;;  BtlMag_DoStatPrep.
;;
;;    The only difference I can see is that this is doing is when the target is both weak AND resistent
;;  to the element.  In that case, this code will result in a hit rate of 188, whereas DoStatPrep will
;;  result in a hit rate of 40.
;;
;;    It's weird that this does elemental checks at all -- I mean... the whole point of this is to remove
;;  elemental resistance, so what good is it if it is thwarted by elemental resistence?  Fortunately,
;;  the only spell to use it (XFER) is nonelemental so it doesn't matter.
;;
;;  XFER bug explained:
;;      XFER removes elemental resistence.  It works properly when cast on players, but not when cast on
;;  enemies.  On enemies it has no effect.
;; 
;;      The bug is not in this code -- the below routine works fine.  It modifies the target's elemental
;;  resistence correctly.  The problem is, for enemies, this value is taken from their ROM stats
;;  and not their RAM stats.  So after the spell is resolved, this new elemental resistence stat is not
;;  used and the enemy stat remains unchanged.
;;
;;      The problem is in BtlMag_LoadEnemyDefenderStats, BtlMag_SaveEnemyDefenderStats, and
;;  PlayerAttackEnemy_Physical.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

BtlMag_Effect_RemoveResist:
    JSR BtlMag_LoadBaseHitChance        ; load base hit chance (148)
    
    ;; JIGS - not really sure what to do here. Is the above JSR needed? In any case, I don't think this part is.
    
 ;   LDA btlmag_element
 ;   AND btlmag_defender_elemresist
 ;   BEQ :+
 ;     JSR BtlMag_ZeroHitChance          ; if defender resists, hit chance = 0
 ; : LDA btlmag_element
 ;   AND btlmag_defender_elemweakness
 ;   BEQ :+                              ; if defender is weak,
      LDA #188                          ; hit chance = 188
      STA math_hitchance                ;   (148 base + 40 bonus)
      
  : LDA #MATHBUF_HITCHANCE
    LDX btlmag_hitrate
    JSR MathBuf_Add                     ; add spell's hit rate to chance
    LDA #MATHBUF_HITCHANCE
    LDX btlmag_defender_magicdefense
    JSR MathBuf_Sub                     ; subtract defender's magdef from hit chance
    
    JSR Random_0_200                    ; get hit roll
    CMP #200                            ; 200 = always miss
    BEQ BtlMag_Effect_RemRst_RTS
    
    JSR WriteAToMagRandHit              ; record hit roll
    JSR BtlMag_DidSpellConnect          ; check to see if spell connected
    BCC BtlMag_Effect_RemRst_RTS        ; if it did...
    LDA #0
    STA btlmag_defender_elementresist      ; clear all defender's elemental resistance
    JSR BtlMag_MarkSpellConnected       ; and mark that the spell connected.
    
  ; RTS                                 ; <- flow into

  
;; Common RTS that is branched to by various surrounding code
BtlMag_Effect_RemRst_RTS:
    RTS
    
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  BtlMag_Effect_InflictAilment2  [$BAD7 :: 0x33AE7]
;;
;;  Inflicts the desired ailment.  There is NO randomness involved.  Whether or not it
;;  hits depends solely on remaining HP and elemental resistence.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

BtlMag_Effect_InflictAilment2:
    LDA btlmag_element                  ; If the defender resists the elemenu
    AND btlmag_defender_elementresist
    BNE BtlMag_Effect_RemRst_RTS        ; then they are 100% immune.  Branch to RTS
    
    LDA #<300
    STA math_magrandhit
    LDA #>300
    STA math_magrandhit+1
    LDY #MATHBUF_MAGRANDHIT
    LDX #MATHBUF_MAGDEFENDERHP
    JSR MathBuf_Compare                 ; see if defender's HP is under 300
    
    BCC BtlMag_Effect_RemRst_RTS        ; if not, FAIL/exit
    
    JSR BtlMag_ApplyAilments            ; otherwise, apply the ailments
    JMP BtlMag_MarkSpellConnected       ; and mark as connected, and exit


    
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  BtlMag_HandleAilmentChanges  [$BAF8 :: 0x33B08]
;;
;;    After a spell takes effect, this checks the target's ailments before and after
;;  the spell and handles changes.  This includes:
;;
;;  - Printing battle messages to show ailments that have been added/removed
;;  - Removing enemies from the battle if they've been slain
;;  - Clear enemy graphics if they've been slain
;;  - Remove player's action from the command buffer if they've been immobilized.
;;
;;    About the only thing it DOESN'T do that you might expect it to is set a player's HP
;;  to zero if they've been killed.
;;
;;    Note that this routine also handles the 'fakeout' necessary for faking the output
;;  of mulitple targets.  See Battle_DoTurn for an explanation.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

BtlMag_HandleAilmentChanges:
    LDA btlmag_effect
    CMP #06
    BEQ CheckPlayerState
    CMP #13
    BCS CheckPlayerState ; if the magic spell that was cast was Life, Life 2, or Soft, skip all this

    LDX #$08                     ; loop 8 times -- once for each ailment
    LDA btlmag_defender_ailments 
    STA btltmp+7                 ; store their new ailments in btltmp+7

  @AilmentLoop:                  
    LDA #0                       ; shift out low orig ailment bit
    STA btltmp+6                 ; shift it into btltmp+6
    LSR btlmag_ailment_orig      
    ROL btltmp+6                 ; results in 0 or 1 if the defender originally had this ailment

    LSR btltmp+7                 ; shift low bit of NEW ailment into A
    ROL A                        

    CMP btltmp+6                 ; compare to see if the state of this ailment changed.

    BNE @AilmentChanged          

  @NextAilment:                  
    DEX                          ; dec loop counter, and loop until we're done
    BNE @AilmentLoop             
    BEQ @DoneWithAilMessages

  @AilmentChanged:
    CMP #0                       ; see if the ailment is added or if it was cured
    BEQ @AilmentCured            ; jump ahead if cured
    
    ; Otherwise, ailment has been inflicted
    CPX #$08                     ; is this the first ailment?  (first ailment is DEATH)
    BNE @AilmentAdded            ; if not death, jump ahead
    
    ; Reaches here if the target has died
    LDA #BTLMSG_TERMINATED       ; use "Terminated" message
    LDX btl_defender             ; is the defender a player?
    BPL :+                       ; if yes...
      LDA #BTLMSG_SLAIN          ; ... switch to "Slain" message instead      
  : JSR DrawMessageBoxDelay_ThenClearIt ; Show Terminated/Slain
    JMP @DoneWithAilMessages     ; And exit this loop (no point in checking other ailments)
    
  @AilmentAdded:
    CPX #07                      ; was it stone?
    BNE :+                       ; if not, just get the message
       LDA btl_defender          ; if stone, check defender
       BPL :+                    ; if its an enemy, print normal message
        LDA #BTLMSG_STOPPED      ; if its a player, swap that message for "Stopped"
        BNE @PrintMessageAndNext
 
  : LDA AilmentAdded_MessageLut-1, X ; -1 because X is +1
    
  @PrintMessageAndNext:
    JSR DrawMessageBoxDelay_ThenClearIt ; Show the message
    JMP @NextAilment             ; And continue looping through ailments.
    
  @AilmentCured:
    LDA AilmentCured_MessageLut-1, X
    BNE @PrintMessageAndNext     ; print it and keep looping

    
    ;; Once all messages for inflicted/cured ailments have been printed...
  @DoneWithAilMessages:
    LDX btl_defender             ; get defender
    BMI CheckPlayerState         ; if it's a player, jump ahead to player logic
    
    ; Otherwise, defender is an enemy
    LDA btlmag_defender_ailments ; See if the enemy has been killed/stoned
    AND #(AIL_DEAD | AIL_STONE)
    BEQ :+                       ; if yes....

EnemyDiedFromPoison:    
      JSR EraseEnemyGraphic      ;  Erase their graphic
      LDX btl_defender
      JSR ClearEnemyID           ;  Remove them from the battle
      
      LDA btlmag_defender_ailments
      STA btlmag_fakeout_ailments   ; record their ailments to fakeout output to show that
      LDA btl_defender              ;   at least one enemy has been killed
      STA btlmag_fakeout_defindex
      
  : LDA #$00
    STA btlmag_fakeout_defplayer
    RTS
    
CheckPlayerState:
    LDA btlmag_defender_ailments    ; see if the player has been rendered immobile
    AND #(AIL_DEAD | AIL_STONE | AIL_SLEEP)
    BEQ :+                          ; if yes...
      STA btlmag_fakeout_ailments   ; record fakout ailments to show that at least one player has
      LDA btl_defender              ;   been removed from combat
      ORA #$80                      ;; JIGS - this doesn't check for Stun, because if the player was
      STA btlmag_fakeout_defindex   ;; previously stunned before being, say, muted...
      LDA btl_defender              ;; then this little part would remove their actions
      JSR RemoveCharacterAction     ;; even though Stun is now a 50/50 chance to act
      
  : LDA #$01
    STA btlmag_fakeout_defplayer
    RTS


  ;; JIGS - well, figured out why this stupid thing exists... 
  ;; Its the dumb BtlMag_HandleAilmentChanges routine.
  ;; But I think I have a better way to deal with it that lets
  ;; the rest of this routine be used for actual messages  
  ;; An even better way would be to delete all this 
  ;; and just have the messages themselves be in the proper order!
  
AilmentAdded_MessageLut:            
.BYTE BTLMSG_CONFUSED       ; X = 1 
.BYTE BTLMSG_SILENCED       ; X = 2
.BYTE BTLMSG_ASLEEP         ; X = 3 
.BYTE BTLMSG_PARALYZED      ; X = 4 
.BYTE BTLMSG_DARKNESS       ; X = 5 
.BYTE BTLMSG_POISONED       ; X = 6 
.BYTE BTLMSG_BROKENTOPIECES ; X = 7 
.BYTE BTLMSG_TERMINATED     ; X = 8 
  
AilmentCured_MessageLut:    
.BYTE BTLMSG_CONFUSECURED   ; confuse    
.BYTE BTLMSG_BREAKSILENCE   ; mute
.BYTE BTLMSG_WOKEUP         ; sleep
.BYTE BTLMSG_NEUTRALIZED    ; poison
.BYTE BTLMSG_PARALYZEDCURED ; stun
.BYTE BTLMSG_SIGHTRECOVERED ; blind
.BYTE BTLMSG_NEUTRALIZED    ; poison
.BYTE BTLMSG_CURED          ; stone
.BYTE BTLMSG_LIFE           ; cure message for death
    
;; JIGS - bugged, need to confirm messages are picked right    
    
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  GetEnemyStatPtr  [$BB86 :: 0x33B96]
;;
;;  input:
;;      A = desired enemy index  (0-8)
;;
;;  output:
;;      XA = pointer to that enemy's stats in RAM
;;
;;  Again this is a 100% identical copy of a routine in bank B
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    
GetEnemyRAMPtr:
    LDX #28                ; multiply enemy index by $14  (number of bytes per enemy)
    JSR MultiplyXA
    CLC                     ; then add btl_enemystats to the result
    ADC #<btl_enemystats                ;; FB
    STA EnemyRAMPointer
    TXA
    ADC #>btl_enemystats                ;; 6B
    STA EnemyRAMPointer+1
    RTS
    

    
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Inc Y routines  [$BB9B :: 0x33BAB]
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    
IncYBy4:                ; BB9F
    INY
    INY
    INY
    INY
    
    RTS
    
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  RebuildEnemyRoster  [$BBA4 :: 0x33BB4]
;;
;;  Rebuilds the roster to show which enemies are actually in the fight.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

RebuildEnemyRoster:
    LDA #$FF
    LDX #$03
  @ClearLoop:
      STA btl_enemyroster, X
      DEX
      BPL @ClearLoop
      
    INX             ;X=0.  X will be the enemy slot index
    LDY #$00        ;Y=0.  Y will be the roster index
    
  @FillLoop:
      JSR ShouldAddEnemyToRoster    ; should we add this enemy to the roster?
      LDA btltmp_buildroster
      BEQ :+                        ; if yes...
        LDA btl_enemyIDs, X         ; put the enemy in the roster
        STA btl_enemyroster, Y
        INY                         ; inc roster index
    : INX
      CPX #$09
      BNE @FillLoop                 ; loop for all 9 enemy slots.
    
    RTS
    
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  DoesEnemyXExist  [$BBC6 :: 0x33BD6]
;;
;;  input:   X = enemy index
;;  output:  Z = clear if enemy exists, set if enemy slot is empty
;;           A = ID of enemy
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    
DoesEnemyXExist:
    LDA btl_enemyIDs, X
    CMP #$FF
    RTS
    
    
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  ShouldAddEnemyToRoster  [$BBCC :: 0x33BDC]
;;
;;  input:       X = enemy slot index
;;  output:  $6DB1 = 0 if enemy should not be added to the roster
;;                   1 if enemy should be added
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

ShouldAddEnemyToRoster:
    LDA #$00                ; clear output by default
    STA btltmp_buildroster
    
    TXA                     ; backup X,Y
    PHA
    TYA
    PHA
    
    JSR DoesEnemyXExist     ; if this enemy slot is empty
    BEQ @Exit               ;  just exit
    
    LDY #$00                ; otherwise, loop over the existing roster to see if the enemy
  @Loop:                    ; is already in it
      CMP btl_enemyroster, Y
      BEQ @Exit             ; if it already exists, exit
      INY
      CPY #$04              ; loop over all 4 roster entries
      BNE @Loop
    
    ; If the enemy did not exist in the roster, then we should add it! 
    ;  set our output to 1, then exit
    INC btltmp_buildroster
    
  @Exit:
    PLA
    TAY
    PLA
    TAX         ; restore Y,X
    RTS
    
    
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  EraseEnemyGraphic  [$BBEE :: 0x33BFE]
;;
;;  input:   btl_defender = the target enemy slot to erase
;;
;;    Note, for the Chaos fight, this routine will do nothing.  The disintegration
;;  effect when Chaos is killed is done elsewhere.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

EraseEnemyGraphic:
    INC btl_enemyeffect         ; make enemyeffect nonzero
    JSR DrawEnemyEffect         ; draw the erase effect
    LDA #$00
    STA btl_enemyeffect         ; then zero enemy effect again
    RTS

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  DoExplosionEffect  [$BBFA :: 0x33C0A]
;;
;;    Plays the "cha" sound effect when you attack an enemy, and draws the explosion sound effect
;;  on top of the target enemy.
;;
;;  input:  btl_enemyeffect = assumed to be 0
;;             btl_defender = the target enemy slot on which to draw the effect
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

DoExplosionEffect:
    LDA ConfusedMagic
    BPL :+
       LDA #0
       JSR PlayBattleSFX
       JSR DisplayAttackIndicator
       JMP DisplayAttackIndicator
    
  : LDA #$02
    JSR PlayBattleSFX           ; the the "cha" sound effect.
  ; JMP DrawEnemyEffect         ; <- then flow into drawing the enemy effect.

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  DrawEnemyEffect  [$BBFF :: 0x33C0F]
;;
;;  Either draws the explosion effect over an enemy... or erases the enemy.
;;  Depending on the status of btl_enemyeffect.
;;
;;  if btl_enemyeffect = 0, it draws explosion effects
;;  otherwise, it erases the enemy.
;;
;;    I have NO idea why these two different things are combined into the same routine -- there isn't really
;;  any reason for them to be.  Whatever.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

DrawEnemyEffect:
    LDA btl_defender
    PHA
    JSR SwapBtlTmpBytes_L
    LDX btl_battletype
    BNE :+
      JMP DrawEnemyEffect_9Small          ; 9small formation
  : DEX
    BNE :+
      JMP DrawEnemyEffect_4Large          ; 4large formation
  :   DEX
    BNE :+
      JMP DrawEnemyEffect_Mix          ; mix formation
    
    ;; The rest of this is for Fiends/Chaos -- but is the same
    ;;  idea as DrawEnemyEffect_9Small.  See that routine for
    ;;  details -- comments here are sparese.
  : PLA                     ; throw the enemy slot away -- we don't need it since there's only 1 enemy
  
    LDA #$20
    STA explode_min_x
    LDA #$40
    STA explode_min_y
    LDA #$60
    STA explode_max_x
    LDA #$78
    STA explode_max_y
    LDA #$14
    STA explode_count
    JSR DrawExplosions
    
    LDA btl_enemyeffect
    BEQ @Exit               ; exit if we don't want to erase the enemy
    LDA btl_battletype
    CMP #$04
    BEQ @Exit               ; exit if this is a Chaos fight -- we don't erase Chaos normally -- he has a fancy
                            ;  dissolve effect
    
    LDA #$0C
    STA explode_min_x             ; row counter / loop counter
    
    LDA #<$20C2             ; $6D15,6 = target PPU address
    STA explode_min_y
    LDA #>$20C2
    STA explode_max_x
    
  @EraseLoop:
      JSR WaitForVBlank_L           ; Vblank
      LDA explode_max_x                    ; Set PPU Addr
      STA $2006
      LDA explode_min_y
      STA $2006
      
      LDA #$00
      JSR WriteAToPPU6Times         ; clear 12 tiles in this row
      JSR WriteAToPPU6Times
      
      JSR BattleUpdatePPU           ; reset scroll, etc

      LDA explode_min_y      
      CLC                           ; move PPU addr to next row
      ADC #$20
      STA explode_min_y
      BCC :+
        INC explode_max_x
    : JSR BattleUpdateAudio         ; update audio for the frame
      DEC explode_min_x
      BNE @EraseLoop
      
  @Exit:
    JMP SwapBtlTmpBytes_L


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  VBlank_SetPPUAddr  [$BC85 :: 0x33C95]
;;
;;  Waits for VBlank, and sets PPU addr to btltmp+A,B
;;  Also makes a point to preseve A
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

VBlank_SetPPUAddr:
    PHA                         ; backup A
    JSR WaitForVBlank_L         ; VBlank
    LDA btltmp+$B               ; set ppu addr
    STA $2006
    LDA btltmp+$A
    STA $2006
    PLA                         ; restore A
    RTS

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  DrawExplosions_PreserveX  [$BCA5 :: 0x33CB5]
;;
;;  Also loads btl_enemyeffect into A upon exit
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

DrawExplosions_PreserveX:
    TXA                 ; backup X
    PHA
    JSR DrawExplosions  ; draw explosions
    PLA
    TAX                 ; restore X
    LDA btl_enemyeffect ; load btl_enemyeffect
    RTS


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  DrawEnemyEffect_9Small  [$BCB0 :: 0x33CC0]
;;
;;  Either erase the enemy or draw the explosion graphics on it, depending on btl_enemyeffect.
;;
;;  input:             btl_enemyeffect = choose to erase or draw explosions
;;         value pushed to stack and A = enemy slot
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

DrawEnemyEffect_9Small:
    PLA                     ; get enemy slot and back it up again
    ASL A                   ; *2 to use it for an index for the coord LUT
    TAX                         
    
    LDA lut_ExplosionCoords_9Small, X
    STA explode_min_x
    CLC
    ADC #$18
    STA explode_max_x       ; get min/max X coord
    
    LDA lut_ExplosionCoords_9Small+1, X
    STA explode_min_y
    CLC
    ADC #$18
    STA explode_max_y       ; get min/max Y coord
   
    LDA #$06                ; set the number of explosions for this enemy
    STA explode_count
    
    JSR DrawExplosions_PreserveX        ; Draw the actual explosion
    BEQ __DrawEnemyEffect_9Small_Exit   ; branches if btl_enemyeffect is zero
        
    ; This code only runs if btl_enemyeffect is nonzero (erase the enemy)
    LDA lut_EraseEnemyPPUAddress_9Small, X  ; X is only set correctly because DrawExplosions_PreserveX preserves X
    STA btltmp+$A
    LDA lut_EraseEnemyPPUAddress_9Small+1, X
    STA btltmp+$B
  ; JMP EraseSmallEnemy                     ; <- flow into

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  EraseSmallEnemy  [$BCE2 :: 0x33CF2]
;;
;;   input:  btltmp+$A,B PPU address pointing to enemy graphic
;;
;;  Erases an enemy graphic, then swaps out btltmp bytes
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

EraseSmallEnemy:
    LDA #$04                        ; loop counter (clearing 4 rows)
    STA btltmp
    : JSR VBlank_SetPPUAddr         ; set the PPU addr
      LDA #$00
      JSR WriteAToPPU4Times         ; clear 4 tiles
      JSR MoveDown1Row_UpdateAudio  ; finish the frame and prep for next row
      DEC btltmp
      BNE :-                        ; dec loop counter and loop

__DrawEnemyEffect_9Small_Exit:      
    JMP SwapBtlTmpBytes_L

    
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  WriteAToPPUXTimes  [$BCFC :: 0x33D0C]
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

WriteAToPPU6Times:
    JSR WriteAToPPU2Times
    
WriteAToPPU4Times:
    JSR WriteAToPPU2Times
    
WriteAToPPU2Times:
    STA $2007
    STA $2007
    RTS
    

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  MoveDown1Row_UpdateAudio  [$BD09 :: 0x33D19]
;;
;;    Updates the PPU address stored at btltmp+$A to move down
;;  one row of tiles, and then update audio.
;;
;;  This routine and VBlank_SetPPUAddr are used to bookend in-battle PPU updates.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

MoveDown1Row_UpdateAudio:
    JSR BattleUpdatePPU         ; reset scroll and stuffs
    LDA btltmp+$A               ; update soft ppu addr to point to next row
    CLC
    ADC #$20
    STA btltmp+$A
    LDA btltmp+$B
    ADC #$00
    STA btltmp+$B
    JMP BattleUpdateAudio       ; update audio and exit

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  lut_ExplosionCoords_9Small  [$BD1C :: 0x33D2C]
;;
;;  The sprite coords to draw explosions for enemies in the 9 small formation

lut_ExplosionCoords_9Small:  
  .BYTE $18, $58
  .BYTE $20, $30
  .BYTE $10, $80
  .BYTE $40, $58
  .BYTE $48, $30
  .BYTE $38, $80
  .BYTE $68, $58
  .BYTE $70, $30
  .BYTE $60, $80


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  DrawEnemyEffect_4Large  [$BD2E :: 0x33D3E]
;;
;;  Identical to DrawEnemyEffect_9Small but with different constants.
;;  See that routine for details, comments here will be sparse
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

DrawEnemyEffect_4Large:
    PLA
    ASL A
    TAX
    
    LDA lut_ExplosionCoords_4Large, X
    STA explode_min_x
    CLC
    ADC #$28
    STA explode_max_x
    
    LDA lut_ExplosionCoords_4Large+1, X
    STA explode_min_y
    CLC
    ADC #$28
    STA explode_max_y
    
    LDA #$08
    STA explode_count
    
    JSR DrawExplosions_PreserveX
    BEQ SwapBtlTmpBytes_Local ; @Exit
    
    LDA lut_EraseEnemyPPUAddress_4Large, X
    STA btltmp+$A
    LDA lut_EraseEnemyPPUAddress_4Large+1, X
    STA btltmp+$B
    
    LDA #$06                        ; 6 rows for large enemies
    STA btltmp
    : JSR VBlank_SetPPUAddr
      LDA #$00
      JSR WriteAToPPU6Times
      JSR MoveDown1Row_UpdateAudio
      DEC btltmp
      BNE :-

   SwapBtlTmpBytes_Local:   
    JMP SwapBtlTmpBytes_L

  ; [$BD7A :: 0x33D8A]
  lut_ExplosionCoords_4Large:
    .BYTE $18, $30
    .BYTE $10, $68
    .BYTE $50, $30
    .BYTE $48, $68
    
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  DrawEnemyEffect_Mix  [$BD82 :: 0x33D92]
;;
;;  Identical to DrawEnemyEffect_9Small but with different constants for the 2Large+6Small mix formation
;;  See that routine for details, comments here will be sparse
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

DrawEnemyEffect_Mix:
    CMP #$02                        ; if slot is < 2
    BCS :+
      JMP DrawEnemyEffect_4Large    ; and jump to the 4Large version -- since the first 2 enemies in this formation
                                    ;   are large and are placed in the same spot as the 4large formation
    
    ; Jumps here if slot >= 2 (one of the small enemies)
  : PLA                         ; undo our pointless push ; JIGS - this one is not pointless somehow.
    SEC
    SBC #$02                    ; subtract 2 to make the index [0-5], which indexes the small enemy slots
    ASL A
    TAX
    
    LDA lut_ExplosionCoords_6Small, X
    STA explode_min_x
    CLC
    ADC #$18
    STA explode_max_x
    
    LDA lut_ExplosionCoords_6Small+1, X
    STA explode_min_y
    CLC
    ADC #$18
    STA explode_max_y
    
    LDA #$06                    ; way more explosions for small enemies in the mix formation than in the 9small formation
    STA explode_count           ;  is this BUGGED?
    
    JSR DrawExplosions_PreserveX  ; doesn't call the Preserve X version -- the one time it would actually make sense to...
    BEQ SwapBtlTmpBytes_Local
   
    LDA lut_EraseEnemyPPUAddress_Mix_Small, X
    STA btltmp+$A
    LDA lut_EraseEnemyPPUAddress_Mix_Small+1, X
    STA btltmp+$B
    JMP EraseSmallEnemy         ; reuse the EraseSmallEnemy routine used in the 9Small formation
    
    ;; [$BDCC :: 0x33DDC]
lut_ExplosionCoords_6Small:
    .BYTE $50, $58
    .BYTE $58, $30
    .BYTE $48, $80
    .BYTE $78, $58
    .BYTE $80, $30
    .BYTE $70, $80

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  DrawExplosions  [$BDDB :: 0x33DEB]
;;
;;    Draws the explosions that appear on an enemy when you attack them.
;;  This routine takes several frames to complete.
;;
;;  input:
;;    btl_enemyeffect = if nonzero, this routine exits immediately without drawing anything
;;      explode_count = number of explosion graphics to draw (/ 3)
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

DrawExplosions:
    LDA btl_enemyeffect         ; Only draw the explosion if enemy effect is set to draw explosions
    BEQ @DrawExplosionSprites
      RTS                       ;  if not, exit immediately
      
  @DrawExplosionSprites:
    LDA #$00
    STA btltmp+2            ; btltmp+2 is a loop counter
    : LDA #$00              ;  loop 3 times, drawing an explosion sprite in each explosion slot
      LDX #$02              ; get a random value, one of:  F4, F8, or FC
      JSR RandAX            ; this will be used as the explosion graphic tile
      ASL A
      ASL A
      CLC
      ADC #$F4
      
      LDX btltmp+2              ; use the loop counter as the slot
      JSR DrawExplosion_Frame   ; draw the graphic and do a frame
      
      INC btltmp+2              ; inc loop counter (and slot index)
      LDA btltmp+2
      CMP #$03
      BNE :-                    ; loop 3 times to fill all slots
      
    DEC explode_count           ; dec the explosion counter
    BNE @DrawExplosionSprites   ;  loop until no more explosions to draw
    
    ; Wipe all the explosion sprites
    LDY #$30                ; 3 slots * 4 sprites per slot * 4 bytes per slot -- loop down counter
    LDA #$FF                ; $FF value to clear
    LDX #$00                ; loop up counter
    
    : STA oam+$D0, X        ; clear oam
      INX
      DEY
      BNE :-
      
    JSR WaitForVBlank_L     ; Do one more frame
    LDA #>oam               ; so we can update sprite data in the PPU
    STA $4014
    JMP BattleUpdateAudio   ; update audio since we did a frame
    
    
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  DrawExplosion_Frame  [$BE1B :: 0x33E2B]
;;
;;  Draws an explosion/damage sprite, then does a frame updating OAM.
;;
;;  input:
;;     explode min/max vars
;;     A = F4, F8, or FC, indicating which of the 3 graphics to draw
;;     X = 0, 1, or 2, indicating which explosion sprite slot to use
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

DrawExplosion_Frame:
    PHA                         ; backup tile ID
    TXA
    ASL A
    ASL A
    ASL A
    ASL A                       ; get slot * $10 (4 sprites per graphic * 4 bytes per sprite)
    CLC
    ADC #$D0                    ; $D0 is the first oam slot for explosion graphics
    STA btltmp
    LDA #>oam
    STA btltmp+1                ; btltmp now points to dest area in oam to draw the sprite
    
    LDA explode_min_x
    LDX explode_max_x
    JSR RandAX                  ; get a random X coordinate
    LDY #oam_x - oam
    JSR Explosion_Write_0808    ; write X coords to all 4 sprites
    
    LDA explode_min_y
    LDX explode_max_y
    JSR RandAX                  ; get a random Y coordinate
    LDY #oam_y - oam
    JSR Explosion_Write_0088    ; write Y coords
    
    LDA #$02                    ; attribute = no flipping, use palette 2 (the weapon/magic palette)
    LDY #oam_a - oam
    JSR Explosion_Write_0808
    
    PLA                         ; get the tile
    LDY #oam_t - oam
    LDX #$04
    : STA (btltmp), Y           ; set the tile for all 4 sprites
      JSR IncYBy4
      CLC
      ADC #$01
      DEX
      BNE :-
      
    JSR WaitForVBlank_L         ; do a frame
    LDA #>oam                   ; where OAM is updated
    STA $4014
    JMP BattleUpdateAudio       ; update music/sfx during this frame as well
    
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Explosion_Write_0808  [$BE68 :: 0x33E78]
;;
;;  Writes a value to OAM for 4 sprites (each sprite of a 16x16 sprite)
;;  The values written are A+0, A+8, A+0, A+8
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

Explosion_Write_0808:
    STA (btltmp), Y             ; write +0 value
    PHA
    CLC
    ADC #$08                    ; write +8 value
    JSR IncYBy4_WriteToOam
    
    PLA
    JSR IncYBy4_WriteToOam      ; write +0 value
    JSR IncYBy4
    CLC
    ADC #$08
    STA (btltmp), Y             ; write +8 value
    RTS


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Explosion_Write_0088  [$BE7E :: 0x33E8E]
;;
;;  Same as Expolosion_Write_0808, but the values are written in a different order:
;;  The values written are A+0, A+0, A+8, A+8
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

Explosion_Write_0088:
    STA (btltmp), Y             ; write +0 value
    JSR IncYBy4_WriteToOam      ; write +0 value
    CLC
    ADC #$08
    JSR IncYBy4_WriteToOam      ; write +8 value
    JMP IncYBy4_WriteToOam      ; write +8 value
    
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  IncYBy4_WriteToOam  [$BE8C :: 0x33E9C]
;;
;;    Inc Y by 4 to move to the next sprite data in OAM, then write A to
;;  oam (via btltmp ptr).
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

IncYBy4_WriteToOam:
    JSR IncYBy4
    STA (btltmp), Y
    RTS

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  lut_EraseEnemyPPUAddress_9Small  [$BE92 :: 0x33EA2]
;;
;;     PPU addresses used to erase enemies in the 9 small formation type

lut_EraseEnemyPPUAddress_9Small:
  .WORD $2163, $20C4, $2202     ; Left column of enemies
  .WORD $2168, $20C9, $2207     ; Center column
  .WORD $216D, $20CE, $220C     ; right column

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  lut_EraseEnemyPPUAddress_4Large  [$BEA4 :: 0x33EB4]
;;
;;     PPU addresses used to erase enemies in the 4 large formation type

lut_EraseEnemyPPUAddress_4Large:
  .WORD $20C3, $21A2
  .WORD $20CA, $21A9
  
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  lut_EraseEnemyPPUAddress_Mix_Small  [$BEAC :: 0x33EBC]
;;
;;     PPU addresses used to erase *SMALL* enemies in the Mix formation type
;;  Large enemies are omitted -- and the 4Large table is used for them instead.

lut_EraseEnemyPPUAddress_Mix_Small:
  .WORD $216A, $20CB, $2209     ; Center column
  .WORD $216F, $20D0, $220E     ; right column

  







;Small:
; 1  4  7 
; 0  3  5
; 2  6  8
;
;Large:
; 0  2
; 1  3
;
;Mix:
;    3  7
; 0
;    2  5
; 1
;    4  6

;; sorta interleaved: 
;; First byte is Attribute table location
;; Second byte is Attribute to write (ORA) to flash the graphic

SmallEnemyAttributes:
.byte $D0, $C0, $D1, $F0, $D8, $CC, $D9, $FF, $00 ; ID 0 (middle left)   
.byte $C9, $F0, $D1, $0F, $00, $00, $00, $00, $00 ; ID 1 (upper left)   
.byte $E0, $CC, $E1, $33, $00, $00, $00, $00, $00 ; ID 2 (bottom left)   
.byte $D2, $F0, $DA, $FF, $00, $00, $00, $00, $00 ; ID 3 (middle middle) 
.byte $CA, $F0, $CB, $C0, $D2, $0F, $D3, $0C, $00 ; ID 4 (upper middle)  
.byte $D3, $F0, $D4, $30, $DB, $FF, $DC, $33, $00 ; ID 5 (middle right)  
.byte $E1, $CC, $E2, $FF, $00, $00, $00, $00, $00 ; ID 6 (bottom middle) 

MixedEnemyAttributes: ;; these next two belong to SmallEnemyAttributes
;; but because of... things... if we don't pad out MixedEnemyAttributes
;; with 9*2 bytes then it won't get the right IDs for Enemy 2 and 3
.byte $CB, $C0, $CC, $30, $D3, $0C, $D4, $03, $00 ; ID 7 (upper right)   
.byte $E3, $FF, $00, $00, $00, $00, $00, $00, $00 ; ID 8 (bottom right)  

;; MixedEnemyAttributes_Real:
.byte $D2, $C0, $D3, $30, $DA, $CC, $DB, $33, $00 ; ID 2 (middle left) 
.byte $CA, $C0, $CB, $F0, $D2, $0C, $D3, $0F, $00 ; ID 3 (upper left)  
.byte $E2, $FF, $E3, $33, $00, $00, $00, $00, $00 ; ID 4 (bottom left) 
.byte $D3, $C0, $D4, $F0, $DB, $CC, $DC, $FF, $00 ; ID 5 (middle right)  
.byte $CC, $F0, $D4, $0F, $00, $00, $00, $00, $00 ; ID 6 (upper right)   
.byte $E3, $CC, $E4, $33, $00, $00, $00, $00, $00 ; ID 7 (bottom right)  



LargeEnemyAttributes:
.byte $C8, $F0, $C9, $F0, $CA, $30, $D0, $CC, $D1, $FF, $D2, $33, $00 ; ID 0 (top left)     
.byte $D8, $CC, $D9, $FF, $E0, $CC, $E1, $FF, $00, $00, $00, $00, $00 ; ID 1 (bottom left)  
.byte $CA, $C0, $CB, $F0, $D2, $CC, $D3, $FF, $00, $00, $00, $00, $00 ; ID 2 (top right)    
.byte $DA, $FF, $DB, $FF, $E2, $FF, $E3, $FF, $00, $00, $00, $00, $00 ; ID 3 (bottom right) 

FiendChaosAttributes:
.byte $C8, $F0, $C9, $F0, $CA, $F0, $CB, $F0 
.byte $D0, $FF, $D1, $FF, $D2, $FF, $D3, $FF 
.byte $D8, $FF, $D9, $FF, $DA, $FF, $DB, $FF 
.byte $E0, $FF, $E1, $FF, $E2, $FF, $E3, $FF, $00 

DisplayAttackIndicator:
  LDA btl_attacker
  STA indicator_index
  
  LDA ConfusedMagic
  BEQ :+ 
    LDA btl_defender
    STA indicator_index
  
: LDX btl_battletype
  BEQ @Indicator_9Small          ; 9small formation
  DEX
  BEQ @Indicator_4Large          ; 4large formation
  DEX
  BEQ @Indicator_Mix             ; mix formation
  
 @Indicator_Fiend:
  LDA #<FiendChaosAttributes
  STA tmp+4
  LDA #>FiendChaosAttributes
  LDX #0
  BEQ @PrepLoop
  
 @Indicator_9Small:
  LDA #<SmallEnemyAttributes
  STA tmp+4
  LDA #>SmallEnemyAttributes
  LDX #9
  BNE @PrepLoop
  
 @Indicator_4Large:
  LDA #<LargeEnemyAttributes
  STA tmp+4
  LDA #>LargeEnemyAttributes
  LDX #13
  BNE @PrepLoop

 @Indicator_Mix:
  LDA indicator_index
  CMP #2
  BCC @Indicator_4Large    
  
  LDA #<MixedEnemyAttributes
  STA tmp+4
  LDA #>MixedEnemyAttributes
  LDX #9
  
 @PrepLoop:
  STA tmp+5
  LDA indicator_index   
  JSR MultiplyXA
  STA tmp+7
  LDA #02                ; frame loop = do this many frames
  STA tmp+6
   
 @Begin:
  JSR WaitForVBlank_L
  LDY tmp+7  
 @Loop:
  JSR @SetAddress
  LDA $2007          ; throw away buffered byte ? 
  LDA $2007          ; get actual attribute byte
  STA tmp+8          ; save
  JSR @SetAddress    ; re-do the address 
  INY 
  LDA (tmp+4), Y     ; get next byte in lut
  ORA tmp+8          ; add in any other bits          
  STA $2007          ; then save it
  INY 
  BNE @Loop
 
 @ExitLoop:
  PLA                         
  PLA                         ; undo JSR... but still saved some space!
  JSR @MiniFrame
  JSR JIGS_RefreshAttributes   
  JSR @MiniFrame
  DEC tmp+6  
  BNE @Begin 
  RTS

 @SetAddress: 
  LDX #$23
  LDA (tmp+4), Y
  BEQ @ExitLoop
  STX $2006  
  STA $2006 
  RTS
  
 @MiniFrame:
  JSR BattleUpdatePPU         ; set scroll
  JSR BattleUpdateAudio       ; update audio
  JSR DoMiniFrame
  JMP DoMiniFrame             ; wait for vblank/then do audio (2 frames)
  

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  PlayBattleSFX  [$BEB8 :: 0x33EC8]
;;
;;  Begin playing a battle sound effect.  See data_BattleSoundEffects for sound effect descriptions
;;
;;  Desired sound effect stored in A
;;     0 = rising bleeps heard for magic casting and healing
;;     1 = The "boom bash" sound effect heard when an enemy attacks physically
;;     2 = The "chuh" noise heard when a player attacks or when a player is hit with magic.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

PlayBattleSFX:
   ; PHA                             ; backup the desired sfx
   ; JSR SwapBattleSFXBytes          ; swap in sound effect data
   ; PLA
    ASL A                           ; double sfx ID and use as index to pointer table lut
    TAX
    
    LDA data_BattleSoundEffects, X      ; copy pointer to btltmp+10, btlsfxsq2_ptr, and btlsfxnse_ptr
    STA btltmp+10
    STA btlsfxsq2_ptr
    STA btlsfxnse_ptr
    LDA data_BattleSoundEffects+1, X
    STA btltmp+11
    STA btlsfxsq2_ptr+1
    STA btlsfxnse_ptr+1
    
    LDA btlsfxsq2_ptr           ; add 3 to the btlsfxsq2_ptr to skip over the header
    CLC
    ADC #$03
    STA btlsfxsq2_ptr
    LDA btlsfxsq2_ptr+1
    ADC #$00
    STA btlsfxsq2_ptr+1
    
    LDA btlsfxnse_ptr           ; add 8 to the noise pointer to skip over the header and square data
    CLC
    ADC #$08
    STA btlsfxnse_ptr
    LDA btlsfxnse_ptr+1
    ADC #$00
    STA btlsfxnse_ptr+1
    
    LDY #$00                    ; Start reading the header
    LDA (btltmp+10), Y          ; byte 0 of header:  the sound effect length in frames
    STA sq2_sfx               ; record this to sq2_sfx so that music playback doesn't interfere with the sound effect
    STA btlsfx_framectr
    INY
    LDA (btltmp+10), Y          ; byte 1 of header:  sequence length of the square
    STA btlsfxsq2_len
    INY
    LDA (btltmp+10), Y          ; byte 2 of header:  sequence length of noise
    STA btlsfxnse_len
    
    LDA #$01
    STA btlsfxsq2_framectr      ; init frame counters for sqare/noise to 1, so that when we call the below Update
    STA btlsfxnse_framectr      ;  routines, it will force the channel to be updated
    JSR UpdateBattleSFX_Square
    JSR UpdateBattleSFX_Noise
    
    LDA #$0F
    STA $4015                   ; make sure channels are enabled
    RTS 
    ;JMP SwapBattleSFXBytes      ; swap out sfx bytes
    
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  UpdateBattleSFX  [$BF13 :: 0x33F23]
;;
;;  Continues play of battle sound effects.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

UpdateBattleSFX:
    ;JSR SwapBattleSFXBytes
    LDA btlsfx_framectr
    BEQ :+
      JSR UpdateBattleSFX_Square
      JSR UpdateBattleSFX_Noise
      DEC btlsfx_framectr
  : RTS ;JMP SwapBattleSFXBytes
    
    
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  UpdateBattleSFX_Square  [$BF26 :: 0x33F36]
;;
;;  Steps through Square2 sound effect data and updates APU regs
;;
;;  See data_BattleSoundEffects for details of sound effect format
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

UpdateBattleSFX_Square:
    LDA btlsfxsq2_len
    BEQ @Exit
    DEC btlsfxsq2_framectr
    BNE @Exit
      LDY #$04
      LDA (btlsfxsq2_ptr), Y
      STA btlsfxsq2_framectr    ; byte [4] if the frame length of this portion
      LDY #$00
      LDA (btlsfxsq2_ptr), Y
      STA $4004                 ; byte [0] is the volume/duty setting
      INY
      LDA (btlsfxsq2_ptr), Y
      STA $4005                 ; byte [1] is the sweep setting
      INY
      LDA (btlsfxsq2_ptr), Y
      STA $4006                 ; byte [2] is low 8 bits of F-value
      INY
      LDA (btlsfxsq2_ptr), Y
      STA $4007                 ; byte [3] is high 3 bits of F-value + length counter
    
      CLC                       ; add 8 to the pointer (even though we only used 5 bytes of data)
      LDA btlsfxsq2_ptr         ;   (the other 3 bytes are the noise sfx data?)
      ADC #$08
      STA btlsfxsq2_ptr
      LDA btlsfxsq2_ptr+1
      ADC #$00
      STA btlsfxsq2_ptr+1
    
      DEC btlsfxsq2_len
  @Exit:
    RTS
    
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  UpdateBattleSFX_Noise  [$BF5E :: 0x33F6E]
;;
;;  Steps through Noise sound effect data and updates Noise APU regs
;;
;;  See data_BattleSoundEffects for details of sound effect format
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    
UpdateBattleSFX_Noise:
    LDA btlsfxnse_len           ; check the length of this sfx (if any)
    BEQ @Exit                   ; if we've completed it, then just exit
    DEC btlsfxnse_framectr      ; Count down our frame counter
    BNE @Exit                   ; Once it expires, we update the sfx
    
      LDY #$02
      LDA (btlsfxnse_ptr), Y
      STA btlsfxnse_framectr    ; byte [2] if the frame length of this portion
      LDY #$00
      LDA (btlsfxnse_ptr), Y
      STA $400C                 ; byte [0] is the volume setting
      INY
      LDA (btlsfxnse_ptr), Y
      STA $400E                 ; byte [1] is the Freq/tone of the noise
      LDA #$FF
      STA $400F                 ; fixed value of FF used for length counter (keep noise playing for a long time)
      
      CLC                       ; add 8 to the noise pointer (even though we only used 3 bytes of data)
      LDA btlsfxnse_ptr         ;   (the other 5 bytes are the square sfx data?)
      ADC #$08
      STA btlsfxnse_ptr
      LDA btlsfxnse_ptr+1
      ADC #$00
      STA btlsfxnse_ptr+1
      
      DEC btlsfxnse_len         ; decrease the remaining data length of the sfx
  @Exit:
    RTS

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  SwapBattleSFXBytes  [$BF8F :: 0x33F9F]
;;
;;  Swaps 'btlsfx' variables from their "back seat" in RAM to their usable block in zero page.
;;     Either bringing the btlsfx into zero page, or putting them back
;;
;;  Ultimately this routine just swaps the 16 bytes at address $90 and $6D97
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;SwapBattleSFXBytes:
;    LDX #$00                    ; loop up-counter
;    LDY #$10                    ; loop down-counter (copy $10 bytes)
;  @Loop:
;      LDA btlsfx_frontseat, X   ; swap front and back bytes
;      PHA
;      LDA btlsfx_backseat, X
;      STA btlsfx_frontseat, X
;      PLA
;      STA btlsfx_backseat, X
;      
;      INX                       ; update loop counter and keep looping until all bytes swapped
;      DEY
;      BNE @Loop
;    RTS
;    
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  data_BattleSoundEffects  [$BFA4 :: 0x33FB4]
;;
;;  This is the data for the 3 sound effects heard in battle.
;;    sfx 0 = rising bleeps heard for magic casting and healing
;;    sfx 1 = The "boom bash" sound effect heard when an enemy attacks
;;    sfx 2 = The "chuh" noise heard when a player attacks.
;;
;;  This data starts with a short pointer table with entries for each sound effect.
;;
;;  The actual data consists of a 3 byte header, followed by N blocks of 8 bytes each.
;;
;;  Header:
;;     byte 0 = overall length of the sound effect in frames
;;     byte 1 = number of data blocks for the Square channel  (must be at least 1)
;;     byte 2 = number of data blocks for the Noise channel   (must be at least 1)
;;
;;    Following the header is N blocks, where N is the higher of bytes 1 and 2.  Each block has
;;  8 bytes:
;;
;;     byte 0 = Volume/duty for the Square (copied directly to $4004)
;;     byte 1 = Sweep for the Square (copied direclty to $4005)
;;     byte 2 = Low 8 bytes of F-value for Square ($4006)
;;     byte 3 = High 3 bytes of F-value and len counter for Square ($4007)
;;     byte 4 = Length in Frames for the above Square data to be applied
;;
;;     byte 5 = Volume setting for Noise  (copied to $400C)
;;     byte 6 = Freq/tone of Noise  ($400E)
;;     byte 7 = Length in frames for the above Noise data to be applied
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

data_BattleSoundEffects:
  .WORD @sfx_Magic
  .WORD @sfx_EnemyAttack
  .WORD @sfx_PlayerAttack
  .WORD @sfx_WakeupBell
  
@sfx_Magic:
  .BYTE $3C, $01, $01

  .BYTE $FF, $FB, $00, $FB, $32,     $00, $00, $1E
  
@sfx_EnemyAttack:
  .BYTE $0F, $01, $04
  
  .BYTE $00, $00, $00, $00, $01,     $2F, $0E, $03  ; This sound effect starts with a low pitched 'boom'.  That effect actually only plays for
  .BYTE $00, $00, $00, $00, $01,     $2F, $0A, $06  ;   3 frames here... but due to the fact that the game does not properly update sound effect
  .BYTE $00, $00, $00, $00, $01,     $2F, $04, $06  ;   playback while it does the "screen shake" effect, it plays longer than indicated.
  .BYTE $00, $00, $00, $00, $01,     $00, $00, $01

@sfx_PlayerAttack:
  .BYTE $0C, $01, $04
  
  .BYTE $00, $00, $00, $00, $01,     $2F, $07, $03
  .BYTE $00, $00, $00, $00, $01,     $2F, $0C, $05
  .BYTE $00, $00, $00, $00, $01,     $2F, $07, $04
  .BYTE $00, $00, $00, $00, $01,     $00, $00, $01

@sfx_WakeupBell:
  .BYTE $90, $02, $01
  
  .BYTE $A0, $00, $50, $08, $10,     $00, $00, $01 
  .BYTE $8F, $00, $50, $08, $80,     $00, $00, $01 


.byte "END OF BANK C"