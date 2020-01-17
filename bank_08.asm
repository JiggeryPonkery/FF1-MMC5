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
  : LDA MagicData, X
    STA lut_MagicData, X
    LDA MagicData+$100, X
    STA lut_MagicData+$100, X
    LDA MagicData+$200, X
    STA lut_MagicData+$200, x
    LDA MagicData+$300, X
    STA lut_MagicData+$300, x
    INX
    BNE :-
    
    LDX #$20
  : LDA PlayerHPString_ROM, X
    STA PlayerHPString_RAM, X
    DEX
    BPL :-

    LDA $2002         
    LDA #>$0800
    STA $2006
    LDA #<$0800
    STA $2006
    LDA #>BattleTextChr
    STA tmp+1        
    LDA #<BattleTextChr
    STA tmp
    LDX #8  
    JSR CHRLoad
    
    LDA #>$1300
    STA $2006
    LDA #<$1300
    STA $2006
    LDA #>BattleTextChr_Sprites
    STA tmp+1        
    LDA #<BattleTextChr_Sprites
    STA tmp
    LDX #13 
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
.byte $00,$0C,$00,$08,$07,$C0,$28,$01 ; 00 HEAL                       ; 40
.byte $00,$18,$00,$08,$07,$C0,$27,$01 ; 01 HEAL 2                     ; 41
.byte $30,$30,$00,$08,$07,$C0,$25,$01 ; 02 HEAL 3                     ; 42
.byte $00,$08,$00,$10,$FC,$C0,$20,$00 ; 03 Pray - Cure Ailment        ; 43
.byte $00,$05,$00,$04,$18,$B0,$2C,BTLMSG_DEFENDALL ; 04 Reflect       ; 44
.byte $00,$00,$00,$00,$00,$00,$00,BTLMSG_DEFENDALL ; 05 Reflect 2     ; 45
.byte $00,$00,$00,$00,$00,$00,$00,$00 ; 06 ????                       ; 46
.byte $00,$00,$00,$00,$00,$00,$00,$00 ; 07 ????                       ; 47
.byte $00,$00,$00,$00,$00,$00,$00,$00 ; 08 ????                       ; 48
.byte $00,$00,$00,$00,$00,$00,$00,$00 ; 09 ????                       ; 49
.byte $00,$00,$00,$00,$00,$00,$00,$00 ; 0A ????                       ; 4A
.byte $00,$00,$00,$00,$00,$00,$00,$00 ; 0B ????                       ; 4B
.byte $00,$00,$00,$00,$00,$00,$00,$00 ; 0C ????                       ; 4C
.byte $00,$00,$00,$00,$00,$00,$00,$00 ; 0D ????                       ; 4D
.byte $00,$00,$00,$00,$00,$00,$00,$00 ; 0E ????                       ; 4E
.byte $00,$00,$00,$04,$17,$00,$00,BTLMSG_QUICKSHOT ; 0F Counter       ; 4F
;; $80 bytes
;; removed heal and pure data

;; Enemy attacks
.byte $20,$18,$20,$01,$01,$00,$20,$00 ; 00 FROST      ; 50   
.byte $20,$0C,$10,$01,$01,$00,$20,$00 ; 01 HEAT       ; 51   
.byte $05,$02,$02,$02,$03,$00,$20,$00 ; 02 GLANCE     ; 52   
.byte $00,$10,$01,$02,$03,$00,$20,$00 ; 03 GAZE       ; 53   
.byte $18,$08,$01,$01,$03,$00,$20,$00 ; 04 FLASH      ; 54   
.byte $20,$07,$10,$01,$01,$00,$20,$00 ; 05 SCORCH     ; 55   
.byte $10,$01,$80,$01,$03,$00,$20,$16 ; 06 CRACK      ; 56   ; Fell into crack
.byte $00,$01,$08,$02,$03,$00,$20,$15 ; 07 SQUINT     ; 57   ; Erased
.byte $18,$11,$00,$02,$01,$00,$20,$00 ; 08 STARE      ; 58   ; 
.byte $10,$01,$04,$02,$03,$00,$20,$1F ; 09 GLARE      ; 59   ; Exile to 4th dimension
.byte $20,$32,$20,$01,$01,$00,$20,$00 ; 0A BLIZZARD   ; 5A   ; 
.byte $20,$40,$10,$01,$01,$00,$20,$00 ; 0B BLAZE      ; 5B   ; 
.byte $20,$60,$10,$01,$01,$00,$20,$00 ; 0C INFERNO    ; 5C   ; 
.byte $20,$18,$10,$01,$01,$00,$20,$00 ; 0D CREMATE    ; 5D   ; 
.byte $05,$02,$02,$01,$03,$00,$20,$4D ; 0E POISON     ; 5E   ; Poison smoke - JIGS - doesn't make sense, never did. Poison turns to stone? Sure it stops time now, why not.
.byte $00,$10,$00,$01,$03,$00,$20,$00 ; 0F TRANCE     ; 5F   ; 
.byte $20,$44,$02,$01,$01,$00,$20,$00 ; 10 POISON     ; 60   ; 
.byte $20,$4C,$40,$01,$01,$00,$20,$00 ; 11 THUNDER    ; 61   ; 
.byte $00,$01,$08,$01,$03,$00,$20,$15 ; 12 TOXIC      ; 62   ; Erased
.byte $18,$08,$01,$02,$03,$00,$20,$00 ; 13 SNORTING   ; 63   
.byte $30,$50,$00,$01,$01,$00,$20,$00 ; 14 NUCLEAR    ; 64   
.byte $18,$08,$01,$01,$03,$00,$20,$00 ; 15 INK        ; 65   
.byte $00,$04,$02,$01,$03,$00,$20,$00 ; 16 STINGER    ; 66   
.byte $20,$10,$01,$02,$03,$00,$20,$00 ; 17 DAZZLE     ; 67   
.byte $20,$40,$00,$01,$01,$00,$20,$00 ; 18 SWIRL      ; 68   
.byte $20,$40,$00,$01,$01,$00,$20,$00 ; 19 TORNADO    ; 69   
; $D0 bytes
;      ╒ Hit Rate
;      |   ╒ Effectivity
;      |   |   ╒ Element
;      |   |   |   ╒ Target
;      |   |   |   |   ╒ Effect
;      |   |   |   |   |   ╒ Graphic
;      |   |   |   |   |   |   ╒ Palette
;      |   |   |   |   |   |   |   ╒ Message
;      v   v   v   v   v   v   v   v  
.byte $10,$05,$00,$02,$01,$00,$20,$00 ; 1A IMP PUNCH  ; 6A
.byte $00,$00,$00,$00,$00,$00,$20,$00 ; 1B            ; 6B
.byte $00,$00,$00,$00,$00,$00,$20,$00 ; 1C            ; 6C
.byte $00,$00,$00,$00,$00,$00,$20,$00 ; 1D            ; 6D
.byte $00,$00,$00,$00,$00,$00,$20,$00 ; 1E            ; 6E
.byte $00,$00,$00,$00,$00,$00,$20,$00 ; 1F            ; 6F
.byte $00,$00,$00,$00,$00,$00,$20,$00 ; 20            ; 70
.byte $00,$00,$00,$00,$00,$00,$20,$00 ; 21            ; 71
.byte $00,$00,$00,$00,$00,$00,$20,$00 ; 22            ; 72
.byte $00,$00,$00,$00,$00,$00,$20,$00 ; 23            ; 73
.byte $00,$00,$00,$00,$00,$00,$20,$00 ; 24            ; 74
.byte $00,$00,$00,$00,$00,$00,$20,$00 ; 25            ; 75
.byte $00,$00,$00,$00,$00,$00,$20,$00 ; 26            ; 76
.byte $00,$00,$00,$00,$00,$00,$20,$00 ; 27            ; 77
.byte $00,$00,$00,$00,$00,$00,$20,$00 ; 28            ; 78
.byte $00,$00,$00,$00,$00,$00,$20,$00 ; 29            ; 79
.byte $00,$00,$00,$00,$00,$00,$20,$00 ; 2A            ; 7A
.byte $00,$00,$00,$00,$00,$00,$20,$00 ; 2B            ; 7B
.byte $00,$00,$00,$00,$00,$00,$20,$00 ; 2C            ; 7C
.byte $00,$00,$00,$00,$00,$00,$20,$00 ; 2D            ; 7D
.byte $00,$00,$00,$00,$00,$00,$20,$00 ; 2E            ; 7E
.byte $00,$00,$00,$00,$00,$00,$20,$00 ; 2F            ; 7F


;; Player HP String
PlayerHPString_ROM:
.byte $13,$00,$05,$7A,$13,$00,$06,$01
.byte $13,$40,$05,$7A,$13,$40,$06,$01
.byte $13,$80,$05,$7A,$13,$80,$06,$01
.byte $13,$C0,$05,$7A,$13,$C0,$06,$00


BattleTextChr:
.incbin "chr/battle_text.chr"

BattleTextChr_Sprites:
.incbin "chr/battle_text_sprites.chr"


.byte "END OF BANK 08"