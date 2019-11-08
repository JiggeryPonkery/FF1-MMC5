.include "Constants.inc"
.include "variables.inc"
.include "macros.inc"

.export LoadBattleTextChr
.import CHRLoad

.segment "BANK_08"



BANK_THIS = $08

LoadBattleTextChr:
    JSR Load_Battle_Everything

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

Load_Battle_Everything:
    LDA #0
    TAX
   @Clear:
    STA $7000, X
    STA $7100, X
    STA $7200, X
    STA $7300, X
    STA $7400, X
    DEX
    BNE @Clear

   @Magic:
    LDA MagicData, X
    STA $7000, X
    LDA MagicData+$100, X
    STA $7100, X
    LDA MagicData+$200, X
    STA $7200, x
    INX
    BNE @Magic
    RTS
    
    
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
.byte $03,$20,$00,$08,$15,$C0,$28,$00 ; 13 HEAL    ;; JIGS - Heal spells now a
;.byte $00,$0C,$00,$08,$07,$C0,$28,$00 ; 13 HEAL     ;; backup of original spe
.byte $18,$1E,$10,$01,$01,$D0,$27,$00 ; 14 FIRE 2 
.byte $40,$10,$01,$02,$03,$E8,$27,$00 ; 15 HOLD    
.byte $18,$1E,$40,$01,$01,$C8,$27,$00 ; 16 BOLT 2 
.byte $40,$14,$00,$01,$0E,$B8,$27,$00 ; 17 LOCK 2  
.byte $00,$04,$00,$10,$08,$E0,$2A,$00 ; 18 PURE   
.byte $18,$28,$01,$01,$05,$E8,$25,$00 ; 19 FEAR        
.byte $00,$20,$00,$08,$0A,$B0,$21,$00 ; 1A ICE (shield)
.byte $00,$40,$00,$10,$08,$E0,$2C,$00 ; 1B VOICE  
.byte $40,$20,$00,$02,$03,$E8,$21,$00 ; 1C SLEEP 2
.byte $00,$00,$00,$10,$0C,$B8,$2A,$00 ; 1D FAST
.byte $40,$80,$01,$01,$03,$E8,$26,$00 ; 1E CONFUSE
.byte $18,$28,$20,$01,$01,$D0,$22,$00 ; 1F ICE 2  
.byte $00,$42,$00,$10,$07,$C0,$2C,$00 ; 20 CURE 3
.byte $00,$01,$00,$10,$06,$E0,$21,$00 ; 21 LIFE     ; JIGS - will now cure dea
.byte $18,$3C,$00,$01,$02,$C8,$25,$00 ; 22 HARM 3 
.byte $04,$40,$00,$08,$15,$C0,$27,$00 ; 23 HEAL 2
;.byte $00,$18,$00,$08,$07,$C0,$27,$00 ; 23 HEAL 2
.byte $18,$32,$10,$01,$01,$D0,$25,$00 ; 24 FIRE 3    
.byte $28,$01,$02,$01,$03,$E8,$22,$00 ; 25 BANE  
.byte $FF,$00,$00,$08,$00,$00,$00,$00 ; 26 WARP  
.byte $40,$00,$00,$02,$04,$E8,$29,$00 ; 27 SLOW 2
.byte $00,$02,$00,$10,$14,$E0,$20,$00 ; 28 SOFT    ; JIGS - will now cure ston
.byte $FF,$00,$00,$08,$00,$00,$00,$00 ; 29 EXIT   
.byte $00,$0C,$00,$08,$09,$B0,$2A,$00 ; 2A SHIELD2
.byte $00,$28,$00,$08,$10,$B0,$24,$00 ; 2B INVIS 2
.byte $18,$3C,$40,$01,$01,$C8,$22,$00 ; 2C BOLT 3 
.byte $18,$01,$08,$02,$03,$D8,$20,$00 ; 2D RUB    
.byte $28,$01,$80,$01,$03,$B8,$26,$00 ; 2E QUAKE  
.byte $00,$10,$01,$02,$12,$E8,$28,$00 ; 2F STUN   
.byte $00,$00,$00,$10,$0F,$C0,$21,$00 ; 30 CURE 4 
.byte $30,$50,$00,$01,$02,$C8,$2C,$00 ; 31 HARM 4    
.byte $00,$89,$00,$08,$0A,$B0,$25,$00 ; 32 RUB (shield)
.byte $05,$60,$00,$08,$15,$C0,$25,$00 ; 33 HEAL 3
;.byte $30,$30,$00,$08,$07,$C0,$25,$00 ; 33 HEAL 3
.byte $18,$46,$20,$01,$01,$D0,$2B,$00 ; 34 ICE 3  
.byte $40,$02,$02,$02,$03,$C8,$20,$00 ; 35 BREAK  
.byte $00,$10,$00,$04,$0D,$B0,$20,$00 ; 36 SABER 
.byte $00,$08,$01,$02,$12,$E8,$24,$00 ; 37 BLIND  
.byte $00,$01,$00,$10,$13,$D8,$21,$00 ; 38 LIFE 2  ; JIGS - will now cure deat
.byte $6B,$50,$00,$01,$01,$C8,$24,$00 ; 39 HOLY   
.byte $00,$FF,$00,$10,$0A,$B0,$20,$00 ; 3A WALL          
.byte $6B,$00,$00,$02,$11,$B8,$20,$00 ; 3B DISPEL        
.byte $6B,$64,$00,$01,$01,$D0,$28,$00 ; 3C FLARE  
.byte $30,$10,$04,$01,$03,$E8,$20,$00 ; 3D STOP           
.byte $20,$01,$04,$01,$03,$D8,$2B,$00 ; 3E BANISH         
.byte $00,$01,$08,$02,$12,$D8,$28,$00 ; 3F DOOM      
; $200 bytes ^ 

;      ╒ Hit Rate
;      |   ╒ Effectivity
;      |   |   ╒ Element
;      |   |   |   ╒ Target
;      |   |   |   |   ╒ Effect
;      |   |   |   |   |   ╒ Graphic
;      |   |   |   |   |   |   ╒ Palette
;      |   |   |   |   |   |   |   ╒ Unused
;      v   v   v   v   v   v   v   v  
.byte $00,$0C,$00,$08,$07,$C0,$28,$00 ; 00 HEAL  
.byte $00,$18,$00,$08,$07,$C0,$27,$00 ; 01 HEAL 2
.byte $30,$30,$00,$08,$07,$C0,$25,$00 ; 02 HEAL 3
.byte $00,$00,$00,$04,$17,$00,$00,$00 ; 03 Counter
.byte $00,$05,$00,$04,$18,$B0,$2C,$00 ; 04 Reflect
.byte $00,$00,$00,$00,$00,$00,$00,$00 ; 05 Reflect 2

;; removed heal and pure data

;; Enemy attacks
.byte $20,$18,$20,$01,$01,$00,$00,$00 ; 06   FROST    
.byte $20,$0C,$10,$01,$01,$00,$00,$00 ; 07   HEAT     
.byte $05,$02,$02,$02,$03,$00,$00,$00 ; 08   GLANCE   
.byte $00,$10,$01,$02,$03,$00,$00,$00 ; 09   GAZE     
.byte $18,$08,$01,$01,$03,$00,$00,$00 ; 0A   FLASH    
.byte $20,$07,$10,$01,$01,$00,$00,$00 ; 0B   SCORCH   
.byte $10,$01,$80,$01,$03,$00,$00,$00 ; 0C   CRACK    
.byte $00,$01,$08,$02,$03,$00,$00,$00 ; 0D   SQUINT   
.byte $18,$11,$00,$02,$01,$00,$00,$00 ; 0E   STARE    
.byte $10,$01,$04,$02,$03,$00,$00,$00 ; 0F   GLARE    
.byte $20,$32,$20,$01,$01,$00,$00,$00 ; 10   BLIZZARD 
.byte $20,$40,$10,$01,$01,$00,$00,$00 ; 11   BLAZE    
.byte $20,$60,$10,$01,$01,$00,$00,$00 ; 12   INFERNO  
.byte $20,$18,$10,$01,$01,$00,$00,$00 ; 13   CREMATE  
.byte $05,$02,$02,$01,$03,$00,$00,$00 ; 14   POISON   
.byte $00,$10,$00,$01,$03,$00,$00,$00 ; 15   TRANCE   
.byte $20,$44,$02,$01,$01,$00,$00,$00 ; 16   POISON   
.byte $20,$4C,$40,$01,$01,$00,$00,$00 ; 17   THUNDER  
.byte $00,$01,$08,$01,$03,$00,$00,$00 ; 18   TOXIC    
.byte $18,$08,$01,$02,$03,$00,$00,$00 ; 19   SNORTING 
.byte $30,$50,$00,$01,$01,$00,$00,$00 ; 1A   NUCLEAR  
.byte $18,$08,$01,$01,$03,$00,$00,$00 ; 1B   INK      
.byte $00,$04,$02,$01,$03,$00,$00,$00 ; 1C   STINGER  
.byte $20,$10,$01,$02,$03,$00,$00,$00 ; 1D   DAZZLE   
.byte $20,$40,$00,$01,$01,$00,$00,$00 ; 1E   SWIRL      
.byte $20,$40,$00,$01,$01,$00,$00,$00 ; 1F   TORNADO    
; $D0 bytes








BattleTextChr:
.incbin "chr/battle_text.chr"


.byte "END OF BANK 08"