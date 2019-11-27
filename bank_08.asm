.include "Constants.inc"
.include "variables.inc"
.include "macros.inc"
.feature force_range

.export LoadBattleTextChr
.import CHRLoad

.segment "BANK_08"



BANK_THIS = $08

LoadBattleTextChr:
;; also loads all magic data and enemy AI!

    LDX #0
    LDA MagicData, X
    STA lut_MagicData, X
    LDA MagicData+$100, X
    STA lut_MagicData+$100, X
    LDA MagicData+$200, X
    STA lut_MagicData+$200, x
    LDA MagicData+$300, X
    STA lut_MagicData+$300, x
    LDA EnemyAIData, X
    STA lut_EnemyAi, X
    LDA EnemyAIData+$100, X
    STA lut_EnemyAi+$100, X
    LDA EnemyAIData+$200, X
    STA lut_EnemyAi+$200, X
    LDA EnemyAIData+$300, X
    STA lut_EnemyAi+$300, X
    LDA EnemyAIData+$400, X
    STA lut_EnemyAi+$400, X
    LDA EnemyAIData+$500, X
    LDA lut_EnemyAi+$500, X
    LDA EnemyAIData+$600, X
    STA lut_EnemyAi+$600, X
    LDA EnemyAIData+$700, X
    STA lut_EnemyAi+$700, X
    INX
    BEQ LoadBattleTextChr

    LDA $2002          ; Set address to $1000 
    LDA #>$0800
    STA $2006
    LDA #<$0800
    STA $2006
;
    LDA #>BattleTextChr
    STA tmp+1        
    LDA #<BattleTextChr
    STA tmp
    LDX #8   
    JMP CHRLoad


    
    
MagicData:    
;    
; JIGS - I highly recommend using FFHackster to design your magic, then copy-p    
;        and comment out the stuff below. For weapons and armours, too.    
;    
;; JIGS note - When loading up magic data, about #90 bytes can be saved by cha    
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
;      |   |   |   |   |   |   |   ╒ Message
;      v   v   v   v   v   v   v   v  
.byte $00,$10,$00,$10,$07,$C0,$29,$01 ; 00 CURE           ; HP up!
.byte $18,$14,$00,$01,$02,$C8,$21,$00 ; 01 HARM           
.byte $00,$08,$00,$10,$09,$B0,$29,$02 ; 02 SHIELD         ; Armor up
.byte $00,$50,$00,$04,$10,$B0,$22,$03 ; 03 BLINK          ; Easy to dodge
.byte $18,$0A,$10,$02,$01,$D0,$26,$00 ; 04 FIRE           
.byte $18,$20,$01,$01,$03,$E8,$2B,$00 ; 05 SLEEP          
.byte $40,$14,$00,$02,$0E,$B8,$28,$05 ; 06 LOCK           ; Easy to hit
.byte $18,$0A,$40,$02,$01,$C8,$28,$00 ; 07 BOLT           
.byte $00,$08,$00,$10,$08,$E0,$27,$00 ; 08 LAMP           
.byte $40,$40,$01,$01,$03,$E8,$2C,$00 ; 09 MUTE           
.byte $00,$40,$00,$08,$0A,$B0,$28,$08 ; 0A BOLT (Shield)  ; Defend lightning
.byte $00,$28,$00,$10,$10,$B0,$23,$03 ; 0B INVISBL        ; Easy to dodge
.byte $18,$14,$20,$02,$01,$D0,$21,$00 ; 0C ICE            
.byte $18,$08,$01,$01,$03,$E8,$23,$00 ; 0D DARK           
.byte $00,$0E,$00,$10,$0B,$B8,$2B,$0A ; 0E TEMPER         ; Weapons stronger
.byte $40,$00,$01,$01,$04,$E8,$2A,$0B ; 0F SLOW           ; Lost intelligence
.byte $00,$21,$00,$10,$07,$C0,$2B,$01 ; 10 CURE 2         ; HP up!
.byte $18,$28,$00,$01,$02,$C8,$23,$00 ; 11 HARM 2         
.byte $00,$10,$00,$08,$0A,$B0,$26,$0C ; 12 FIRE (shield)  ; Defend fire
.byte $03,$20,$00,$08,$15,$C0,$28,BTLMSG_REGENERATING ; 13 REGEN    ;; JIGS - Heal spells temporarily replaced
;.byte $00,$0C,$00,$08,$07,$C0,$28,$00 ; 13 HEAL     ;; backup of original spe
.byte $18,$1E,$10,$01,$01,$D0,$27,$00 ; 14 FIRE 2 
.byte $40,$10,$01,$02,$03,$E8,$27,$0D ; 15 HOLD            ; Attack halted
.byte $18,$1E,$40,$01,$01,$C8,$27,$00 ; 16 BOLT 2          
.byte $40,$14,$00,$01,$0E,$B8,$27,$05 ; 17 LOCK 2          ; Easy to hit
.byte $00,$04,$00,$10,$08,$E0,$2A,$00 ; 18 PURE            
.byte $18,$28,$01,$01,$05,$E8,$25,$0F ; 19 FEAR            ; Became terrified
.byte $00,$20,$00,$08,$0A,$B0,$21,$10 ; 1A ICE (shield)    ; Defend cold
.byte $00,$40,$00,$10,$08,$E0,$2C,$00 ; 1B VOICE           
.byte $40,$20,$00,$02,$03,$E8,$21,$00 ; 1C SLEEP 2         
.byte $00,$00,$00,$10,$0C,$B8,$2A,$12 ; 1D FAST            ; Quick shot
.byte $40,$80,$01,$01,$03,$E8,$26,$00 ; 1E CONFUSE         
.byte $18,$28,$20,$01,$01,$D0,$22,$00 ; 1F ICE 2           
.byte $00,$42,$00,$10,$07,$C0,$2C,$01 ; 20 CURE 3          ; HP up!
.byte $00,$01,$00,$10,$06,$E0,$21,$4F ; 21 LIFE     ; JIGS- will now cure death ; Revived from the brink!
.byte $18,$3C,$00,$01,$02,$C8,$25,$00 ; 22 HARM 3 
.byte $04,$40,$00,$08,$15,$C0,$27,BTLMSG_REGENERATING ; 23 REGEN 2
;.byte $00,$18,$00,$08,$07,$C0,$27,$00 ; 23 HEAL 2
.byte $18,$32,$10,$01,$01,$D0,$25,$00 ; 24 FIRE 3    
.byte $28,$01,$02,$01,$03,$E8,$22,$4D ; 25 BANE             ; Poison smoke
.byte $FF,$00,$00,$08,$00,$00,$00,$4A ; 26 WARP             ; Ineffective now
.byte $40,$00,$00,$02,$04,$E8,$29,$0B ; 27 SLOW 2           ; Lost intelligence
.byte $00,$02,$00,$10,$14,$E0,$20,$00 ; 28 SOFT / FLOW      ; JIGS - will now cure stone
.byte $FF,$00,$00,$08,$00,$00,$00,$4A ; 29 EXIT             ; Ineffective now
.byte $00,$0C,$00,$08,$09,$B0,$2A,$02 ; 2A SHIELD2          ; Armor up
.byte $00,$28,$00,$08,$10,$B0,$24,$03 ; 2B INVIS 2          ; Easy to dodge
.byte $18,$3C,$40,$01,$01,$C8,$22,$00 ; 2C BOLT 3           
.byte $18,$01,$08,$02,$03,$D8,$20,$15 ; 2D RUB              ; Erased
.byte $28,$01,$80,$01,$03,$B8,$26,$16 ; 2E QUAKE            ; Fell into crack
.byte $00,$10,$01,$02,$12,$E8,$28,$00 ; 2F STUN   
.byte $00,$00,$00,$10,$0F,$C0,$21,$18 ; 30 CURE 4           ; HP max! 
.byte $30,$50,$00,$01,$02,$C8,$2C,$00 ; 31 HARM 4           
.byte $00,$89,$00,$08,$0A,$B0,$25,$19 ; 32 RUB (shield)     ; Defend magic ;; JIGS should be "defend death?"
.byte $05,$60,$00,$08,$15,$C0,$25,$00 ; 33 REGEN 3
;.byte $30,$30,$00,$08,$07,$C0,$25,$00 ; 33 HEAL 3
.byte $18,$46,$20,$01,$01,$D0,$2B,$00 ; 34 ICE 3  
.byte $40,$02,$02,$02,$03,$C8,$20,$00 ; 35 BREAK  
.byte $0F,$10,$00,$04,$0D,$B0,$20,$00 ; 36 SABER             ; Weapon became enchanted (JIGS - added $0F to Hit Rate)
.byte $00,$08,$01,$02,$12,$E8,$24,$00 ; 37 BLIND             
.byte $00,$01,$00,$10,$13,$D8,$21,$00 ; 38 LIFE 2 (Cures death now!) ; Revived from the brink!
.byte $6B,$50,$00,$01,$01,$C8,$24,$00 ; 39 HOLY              
.byte $00,$FF,$00,$10,$0A,$B0,$20,$00 ; 3A WALL              ; Defend all
.byte $6B,$00,$00,$02,$11,$B8,$20,$00 ; 3B DISPEL            ; Defenseless
.byte $6B,$64,$00,$01,$01,$D0,$28,$00 ; 3C FLARE             
.byte $30,$10,$04,$01,$03,$E8,$20,$00 ; 3D STOP              ; Time stopped
.byte $20,$01,$04,$01,$03,$D8,$2B,$00 ; 3E BANISH            ; Exile to 4th dimension
.byte $00,$01,$08,$02,$12,$D8,$28,$00 ; 3F DOOM              ; Erased
; $200 bytes ^ 

;      ╒ Hit Rate
;      |   ╒ Effectivity
;      |   |   ╒ Element
;      |   |   |   ╒ Target
;      |   |   |   |   ╒ Effect
;      |   |   |   |   |   ╒ Graphic
;      |   |   |   |   |   |   ╒ Palette
;      |   |   |   |   |   |   |   ╒ Message
;      v   v   v   v   v   v   v   v  
.byte $00,$0C,$00,$08,$07,$C0,$28,$01 ; 00 HEAL  
.byte $00,$18,$00,$08,$07,$C0,$27,$01 ; 01 HEAL 2
.byte $30,$30,$00,$08,$07,$C0,$25,$01 ; 02 HEAL 3
.byte $00,$08,$00,$10,$FC,$C0,$20,$00 ; 03 Pray - Cure Ailment
.byte $00,$05,$00,$04,$18,$B0,$2C,BTLMSG_DEFENDALL ; 04 Reflect
.byte $00,$00,$00,$00,$00,$00,$00,BTLMSG_DEFENDALL ; 05 Reflect 2
.byte $00,$00,$00,$00,$00,$00,$00,$00 ; 06 ????
.byte $00,$00,$00,$00,$00,$00,$00,$00 ; 07 ????
.byte $00,$00,$00,$00,$00,$00,$00,$00 ; 08 ????
.byte $00,$00,$00,$00,$00,$00,$00,$00 ; 09 ????
.byte $00,$00,$00,$00,$00,$00,$00,$00 ; 0A ????
.byte $00,$00,$00,$00,$00,$00,$00,$00 ; 0B ????
.byte $00,$00,$00,$00,$00,$00,$00,$00 ; 0C ????
.byte $00,$00,$00,$00,$00,$00,$00,$00 ; 0D ????
.byte $00,$00,$00,$00,$00,$00,$00,$00 ; 0E ????
.byte $00,$00,$00,$04,$17,$00,$00,BTLMSG_QUICKSHOT ; 0F Counter
;; $80 bytes
;; removed heal and pure data

;; Enemy attacks
.byte $20,$18,$20,$01,$01,$00,$00,$00 ; 10 FROST    
.byte $20,$0C,$10,$01,$01,$00,$00,$00 ; 11 HEAT     
.byte $05,$02,$02,$02,$03,$00,$00,$00 ; 12 GLANCE   
.byte $00,$10,$01,$02,$03,$00,$00,$00 ; 13 GAZE     
.byte $18,$08,$01,$01,$03,$00,$00,$00 ; 14 FLASH    
.byte $20,$07,$10,$01,$01,$00,$00,$00 ; 15 SCORCH   
.byte $10,$01,$80,$01,$03,$00,$00,$16 ; 16 CRACK      ; Fell into crack
.byte $00,$01,$08,$02,$03,$00,$00,$15 ; 17 SQUINT     ; Erased
.byte $18,$11,$00,$02,$01,$00,$00,$00 ; 18 STARE      ; 
.byte $10,$01,$04,$02,$03,$00,$00,$1F ; 19 GLARE      ; Exile to 4th dimension
.byte $20,$32,$20,$01,$01,$00,$00,$00 ; 1A BLIZZARD   ; 
.byte $20,$40,$10,$01,$01,$00,$00,$00 ; 1B BLAZE      ; 
.byte $20,$60,$10,$01,$01,$00,$00,$00 ; 1C INFERNO    ; 
.byte $20,$18,$10,$01,$01,$00,$00,$00 ; 1D CREMATE    ; 
.byte $05,$02,$02,$01,$03,$00,$00,$4D ; 1E POISON     ; Poison smoke - JIGS - doesn't make sense, never did. Poison turns to stone? Sure it stops time now, why not.
.byte $00,$10,$00,$01,$03,$00,$00,$00 ; 1F TRANCE     ; 
.byte $20,$44,$02,$01,$01,$00,$00,$00 ; 20 POISON     ; 
.byte $20,$4C,$40,$01,$01,$00,$00,$00 ; 21 THUNDER    ; 
.byte $00,$01,$08,$01,$03,$00,$00,$15 ; 22 TOXIC      ; Erased
.byte $18,$08,$01,$02,$03,$00,$00,$00 ; 23 SNORTING 
.byte $30,$50,$00,$01,$01,$00,$00,$00 ; 24 NUCLEAR  
.byte $18,$08,$01,$01,$03,$00,$00,$00 ; 25 INK      
.byte $00,$04,$02,$01,$03,$00,$00,$00 ; 26 STINGER  
.byte $20,$10,$01,$02,$03,$00,$00,$00 ; 27 DAZZLE   
.byte $20,$40,$00,$01,$01,$00,$00,$00 ; 28 SWIRL      
.byte $20,$40,$00,$01,$01,$00,$00,$00 ; 29 TORNADO    
; $D0 bytes

.byte $00,$00,$00,$00,$00,$00,$00,$00 ; 2A
.byte $00,$00,$00,$00,$00,$00,$00,$00 ; 2B
.byte $00,$00,$00,$00,$00,$00,$00,$00 ; 2C
.byte $00,$00,$00,$00,$00,$00,$00,$00 ; 2D
.byte $00,$00,$00,$00,$00,$00,$00,$00 ; 2E
.byte $00,$00,$00,$00,$00,$00,$00,$00 ; 2F
.byte $00,$00,$00,$00,$00,$00,$00,$00 ; 30
.byte $00,$00,$00,$00,$00,$00,$00,$00 ; 31
.byte $00,$00,$00,$00,$00,$00,$00,$00 ; 32
.byte $00,$00,$00,$00,$00,$00,$00,$00 ; 33
.byte $00,$00,$00,$00,$00,$00,$00,$00 ; 34
.byte $00,$00,$00,$00,$00,$00,$00,$00 ; 35
.byte $00,$00,$00,$00,$00,$00,$00,$00 ; 36
.byte $00,$00,$00,$00,$00,$00,$00,$00 ; 37
.byte $00,$00,$00,$00,$00,$00,$00,$00 ; 38
.byte $00,$00,$00,$00,$00,$00,$00,$00 ; 39
.byte $00,$00,$00,$00,$00,$00,$00,$00 ; 3A
.byte $00,$00,$00,$00,$00,$00,$00,$00 ; 3B
.byte $00,$00,$00,$00,$00,$00,$00,$00 ; 3C
.byte $00,$00,$00,$00,$00,$00,$00,$00 ; 3D
.byte $00,$00,$00,$00,$00,$00,$00,$00 ; 3E
.byte $00,$00,$00,$00,$00,$00,$00,$00 ; 3F


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

EnemyAIData:
  
;      0   1   2   3   4   5   6   7   8   9   A   B   C   D   E   F  
.byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00 ;00 IMP	
.byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00 ;01 GrIMP	
.byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00 ;02 WOLF	
.byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00 ;03 GrWolf	
.byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00 ;04 WrWolf 
.byte $00,$20,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$00,$00,$00,$00,$FF ;05 FrWOLF 
.byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00 ;06 IGUANA 
.byte $00,$20,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$01,$01,$01,$01,$FF ;07 AGAMA
.byte $00,$40,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$02,$02,$02,$02,$FF ;08 SAURIA
.byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00 ;09 GIANT
.byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00 ;0A FrGIANT
.byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00 ;0B R`GIANT
.byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00 ;0C SAHAG
.byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00 ;0D R`SAHAG
.byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00 ;0E WzSAHAG
.byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00 ;0F PIRATE
.byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00 ;10 KYZOKU
.byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00 ;11 SHARK
.byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00 ;12 GrSHARK
.byte $00,$80,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$03,$03,$03,$03,$FF ;13 OddEYE
.byte $00,$40,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$03,$04,$03,$04,$FF ;14 BigEYE
.byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00 ;15 BONE
.byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00 ;16 R`BONE
.byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00 ;17 CREEP
.byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00 ;18 CRAWL
.byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00 ;19 HYENA
.byte $00,$40,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$05,$05,$05,$05,$FF ;1A CEREBUS
.byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00 ;1B OGRE
.byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00 ;1C GrOGRE
.byte $40,$00,$03,$0D,$05,$15,$1F,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF ;1D WzOGRE
.byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00 ;1E ASP
.byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00 ;1F COBRA
.byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00 ;20 SeaSNAKE
.byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00 ;21 SCORPION
.byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00 ;22 LOBSTER
.byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00 ;23 BULL
.byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00 ;24 ZomBULL
.byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00 ;25 TROLL
.byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00 ;26 SeaTROLL
.byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00 ;27 SHADOW
.byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00 ;28 IMAGE
.byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00 ;29 WRAITH
.byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00 ;2A GHOST
.byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00 ;2B ZOMBIE
.byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00 ;2C GHOUL 
.byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00 ;2D GEIST
.byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00 ;2E SPECTER
.byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00 ;2F WORM
.byte $00,$40,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$06,$06,$06,$06,$FF ;30 Sand W
.byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00 ;31 Grey W
.byte $50,$50,$3F,$35,$2D,$16,$15,$09,$0F,$05,$FF,$02,$07,$03,$08,$FF ;32 EYE
.byte $40,$40,$3D,$3E,$3B,$35,$2D,$15,$09,$0F,$FF,$09,$09,$09,$09,$FF ;33 PHANTOM
.byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00 ;34 MEDUSA
.byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00 ;35 GrMEDUSA
.byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00 ;36 CATMAN
.byte $60,$00,$14,$0F,$0D,$05,$04,$07,$00,$05,$FF,$FF,$FF,$FF,$FF,$FF ;37 MANCAT
.byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00 ;38 PEDE
.byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00 ;39 GrPEDE
.byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00 ;3A TIGER
.byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00 ;3B Saber T
.byte $00,$20,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$17,$17,$17,$17,$FF ;3C VAMPIRE
.byte $20,$20,$12,$09,$1F,$1F,$16,$16,$14,$14,$FF,$17,$17,$17,$17,$FF ;3D WzVAMP
.byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00 ;3E GARGOYLE
.byte $40,$00,$14,$15,$04,$04,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF ;3F R`GOYLE
.byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00 ;40 EARTH
.byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00 ;41 FIRE
.byte $00,$40,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$0A,$0A,$0A,$FF,$FF ;42 Frost D
.byte $00,$40,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$0B,$0B,$0B,$FF,$FF ;43 Red D
.byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00 ;44 ZombieD
.byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00 ;45 SCUM
.byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00 ;46 MUCK
.byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00 ;47 OOZE
.byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00 ;48 SLIME
.byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00 ;49 SPIDER
.byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00 ;4A ARACHNID
.byte $00,$40,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$16,$16,$16,$16,$FF ;4B MATICOR
.byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00 ;4C SPHINX
.byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00 ;4D R`ANKYLO
.byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00 ;4E ANKYLO
.byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00 ;4F MUMMY
.byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00 ;50 WzMUMMY
.byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00 ;51 COCTRICE
.byte $00,$20,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$07,$07,$07,$07,$FF ;52 PERILISK
.byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00 ;53 WYVERN
.byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00 ;54 WYRM
.byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00 ;55 TYRO
.byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00 ;56 T REX
.byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00 ;57 CARIBE
.byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00 ;58 R`CARIBE
.byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00 ;59 GATOR
.byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00 ;5A FrGATOR
.byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00 ;5B OCHO
.byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00 ;5C NAOCHO
.byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00 ;5D HYDRA
.byte $00,$40,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$0D,$0D,$FF,$FF,$FF ;5E R`HYDRA
.byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00 ;5F GAURD
.byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00 ;60 SENTRY
.byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00 ;61 WATER
.byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00 ;62 AIR
.byte $60,$00,$16,$15,$0F,$0D,$07,$06,$05,$07,$FF,$FF,$FF,$FF,$FF,$FF ;63 NAGA
.byte $60,$00,$03,$09,$0F,$0D,$05,$04,$07,$13,$FF,$FF,$FF,$FF,$FF,$FF ;64 GrNAGA
.byte $00,$40,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$0D,$0D,$0D,$FF,$FF ;65 CHIMERA
.byte $00,$40,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$0D,$0E,$0D,$0E,$FF ;66 JIMERA
.byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00 ;67 WIZARD
.byte $00,$40,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$0F,$0F,$0F,$0F,$FF ;68 SORCERER
.byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00 ;69 GARLAND
.byte $00,$40,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$10,$10,$10,$FF,$FF ;6A Gas D
.byte $00,$40,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$11,$11,$11,$FF,$FF ;6B Blue D
.byte $20,$00,$1D,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF ;6C MudGOL
.byte $30,$00,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$FF,$FF,$FF,$FF,$FF,$FF ;6D RockGOL
.byte $00,$10,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$12,$12,$12,$12,$FF ;6E IronGOL
.byte $20,$00,$3B,$3C,$3B,$3F,$37,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF ;6F BADMAN
.byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00 ;70 EVILMAN
.byte $60,$00,$2D,$27,$1D,$14,$16,$0F,$0D,$05,$FF,$FF,$FF,$FF,$FF,$FF ;71 ASTOS
.byte $40,$00,$2D,$2C,$24,$25,$27,$24,$2F,$2C,$FF,$FF,$FF,$FF,$FF,$FF ;72 MAGE
.byte $30,$00,$3A,$3B,$33,$2A,$2B,$30,$23,$20,$FF,$FF,$FF,$FF,$FF,$FF ;73 FIGHTER
.byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00 ;74 MADPONY
.byte $00,$20,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$13,$13,$13,$13,$FF ;75 NITEMARE
.byte $00,$20,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$14,$14,$14,$14,$FF ;76 WarMECH
.byte $60,$00,$1F,$1C,$1D,$16,$15,$14,$0F,$05,$FF,$FF,$FF,$FF,$FF,$FF ;77 LICH
.byte $60,$00,$3C,$3D,$3E,$3F,$3C,$3D,$3E,$3F,$FF,$FF,$FF,$FF,$FF,$FF ;78 LICH (reprise)
.byte $30,$00,$14,$0D,$14,$0D,$14,$15,$14,$15,$FF,$FF,$FF,$FF,$FF,$FF ;79 KARY
.byte $30,$00,$24,$2D,$24,$2D,$24,$2F,$24,$2F,$FF,$FF,$FF,$FF,$FF,$FF ;7A KARY (reprise)
.byte $00,$20,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$15,$15,$15,$15,$FF ;7B KRAKEN
.byte $30,$20,$16,$16,$16,$16,$16,$16,$16,$16,$FF,$15,$15,$15,$15,$FF ;7C KRAKEN (reprise)
.byte $00,$40,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$11,$10,$0A,$0B,$FF ;7D TIAMAT
.byte $40,$40,$25,$1F,$16,$14,$25,$1F,$16,$14,$FF,$11,$10,$0A,$0B,$FF ;7E TIAMAT (reprise)
.byte $40,$40,$34,$2C,$27,$30,$24,$1F,$1D,$3C,$FF,$06,$0C,$18,$19,$FF ;7F CHAOS


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



BattleTextChr:
.incbin "chr/battle_text.chr"


.byte "END OF BANK 08"