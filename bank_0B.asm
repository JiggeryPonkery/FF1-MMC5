.include "variables.inc"
.include "macros.inc"
.include "Constants.inc"


.export PrepBattleVarsAndEnterBattle_L
.export lut_BattleRates
.export lut_BattleFormations
.export BattleOver_ProcessResult_L
.export data_EpilogueCHR
.export data_EpilogueNT
.export data_BridgeCHR
.export data_BridgeNT
.export PrintEXPToNext_B
.export lut_Domains
.export WriteAttributesToPPU

.import Battle_ReadPPUData_L
.import Battle_WritePPUData_L
.import CallMusicPlay_L
.import WaitForVBlank_L
.import UndrawNBattleBlocks_L
.import DrawCombatBox_L
.import BattleRNG_L
.import BattleCrossPageJump_L
.import BankC_CrossBankJumpList
.import LongCall
.import RandAX
.import MultiplyXA
.import BackupMapMusic
.import SetBattlePPUAddr

.segment "BANK_0B"

BANK_THIS = $0B

; overworld
lut_Domains:
.byte $E3,$31,$70,$2E,$70,$60,$36,$9F,$E3,$31,$70,$2E,$70,$60,$36,$9F
.byte $89,$70,$3C,$60,$3C,$39,$39,$3A,$EF,$60,$67,$39,$67,$3A,$B7,$B1
.byte $EF,$60,$67,$39,$67,$3A,$B7,$B1,$89,$70,$3C,$60,$3C,$39,$39,$3A
.byte $E3,$31,$70,$2E,$70,$60,$36,$9F,$E3,$31,$70,$2E,$70,$60,$36,$9F
.byte $71,$99,$71,$99,$A2,$A2,$B7,$B1,$E3,$31,$70,$2E,$70,$60,$36,$9F
.byte $37,$37,$25,$25,$36,$36,$38,$B7,$EF,$60,$67,$39,$67,$3A,$B7,$B1
.byte $EF,$60,$67,$39,$67,$3A,$B7,$B1,$F1,$BD,$F1,$BD,$B8,$B8,$BC,$3E
.byte $F1,$BD,$F1,$BD,$B8,$B8,$BC,$3E,$B2,$9E,$B2,$9E,$AD,$AD,$3D,$F0
.byte $71,$99,$71,$99,$A2,$A2,$B7,$B1,$71,$99,$71,$99,$A2,$A2,$B7,$B1
.byte $00,$00,$00,$00,$00,$00,$00,$00,$37,$37,$25,$25,$36,$36,$38,$B7
.byte $00,$00,$00,$00,$00,$00,$00,$00,$F1,$BD,$F1,$BD,$B8,$B8,$BC,$3E
.byte $F1,$BD,$F1,$BD,$B8,$B8,$BC,$3E,$B2,$9E,$B2,$9E,$AD,$AD,$3D,$F0
.byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
.byte $00,$00,$00,$00,$00,$00,$00,$00,$01,$05,$82,$00,$06,$07,$80,$86
.byte $01,$05,$82,$00,$06,$07,$80,$86,$83,$0D,$87,$0C,$87,$0B,$0B,$13
.byte $00,$00,$00,$00,$00,$00,$00,$00,$B2,$9E,$B2,$9E,$AD,$AD,$3D,$F0
.byte $00,$00,$00,$00,$00,$00,$00,$00,$88,$8A,$13,$8A,$8C,$8B,$19,$E6
.byte $83,$0D,$87,$0C,$87,$0B,$12,$13,$83,$0D,$87,$0C,$87,$0B,$12,$13
.byte $00,$00,$00,$00,$82,$03,$06,$80,$09,$07,$02,$86,$83,$83,$0C,$87
.byte $09,$07,$02,$86,$83,$83,$0C,$87,$8E,$0C,$8E,$0F,$0B,$12,$13,$1A
.byte $88,$8A,$13,$8A,$8C,$8B,$19,$E6,$88,$8A,$13,$8A,$8C,$8B,$19,$E6
.byte $88,$8A,$13,$8A,$8C,$8B,$19,$E6,$83,$0D,$87,$0C,$87,$0B,$12,$13
.byte $00,$00,$00,$00,$00,$00,$00,$00,$0D,$14,$83,$8E,$0C,$0C,$0B,$11
.byte $8E,$0C,$8E,$0F,$0B,$12,$13,$1A,$8E,$0C,$8E,$0F,$0B,$12,$13,$1A
.byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
.byte $8E,$0C,$8E,$0F,$0B,$12,$13,$1A,$83,$0D,$87,$0C,$87,$0B,$12,$13
.byte $83,$0D,$87,$0C,$87,$0B,$12,$13,$8E,$0C,$8E,$0F,$0B,$12,$13,$1A
.byte $17,$63,$95,$1E,$95,$9B,$9B,$9A,$17,$63,$95,$1E,$95,$9B,$9B,$9A
.byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
.byte $8E,$0C,$8E,$0F,$0B,$12,$13,$1A,$8E,$0C,$8E,$0F,$0B,$12,$13,$1A
.byte $83,$0D,$87,$0C,$87,$0B,$12,$13,$8E,$0C,$8E,$0F,$0B,$12,$13,$1A
.byte $17,$63,$95,$1E,$95,$9B,$9B,$9A ; northern rivers (and 1st map)
.byte $17,$63,$95,$1E,$95,$9B,$9B,$9A ; southern rivers (and 2nd map)
.byte $A0,$A0,$65,$41,$65,$62,$62,$E2 ; ocean (and 3rd map)
.byte $20,$5F,$20,$5F,$A5,$E0,$DF,$E5 ; rest of the maps
.byte $5B,$DC,$5C,$DD,$5E,$DB,$5D,$DE
.byte $00,$00,$00,$00,$00,$00,$00,$00
.byte $00,$00,$00,$00,$00,$00,$00,$00
.byte $00,$00,$00,$00,$00,$00,$00,$00
.byte $00,$00,$00,$00,$00,$00,$00,$00
.byte $00,$00,$00,$00,$00,$00,$00,$00
.byte $00,$00,$00,$00,$00,$00,$00,$00
.byte $00,$00,$00,$00,$00,$00,$00,$00
.byte $00,$00,$00,$00,$00,$00,$00,$00
.byte $00,$00,$00,$00,$00,$00,$00,$00
.byte $01,$05,$04,$08,$07,$83,$02,$8E
.byte $15,$15,$64,$8D,$93,$90,$E6,$1D
.byte $6F,$6F,$6A,$6E,$97,$9A,$9A,$EB
.byte $9C,$9C,$96,$96,$AB,$AC,$2C,$30
.byte $00,$00,$00,$00,$00,$00,$00,$00
.byte $00,$00,$00,$00,$00,$00,$00,$00
.byte $4F,$3F,$4F,$3F,$CA,$CA,$A3,$59
.byte $00,$00,$00,$00,$00,$00,$00,$00
.byte $00,$00,$00,$00,$00,$00,$00,$00
.byte $00,$00,$00,$00,$00,$00,$00,$00
.byte $0A,$0A,$85,$84,$81,$66,$6B,$11
.byte $CF,$CF,$68,$3B,$4C,$B4,$E7,$B9
.byte $00,$00,$00,$00,$00,$00,$00,$00
.byte $32,$32,$EA,$34,$33,$9D,$35,$4B
.byte $EA,$34,$33,$9D,$9D,$35,$35,$4B
.byte $84,$85,$10,$81,$2B,$66,$1A,$91
.byte $85,$10,$2B,$6B,$66,$11,$1A,$91
.byte $8D,$64,$90,$93,$91,$94,$1B,$1E
.byte $91,$93,$1C,$8F,$18,$16,$1D,$92
.byte $1C,$8F,$18,$63,$16,$0E,$0E,$92
.byte $63,$18,$94,$1B,$1E,$1D,$92,$21
.byte $6A,$6E,$1F,$97,$23,$24,$EB,$27
.byte $1F,$6E,$6D,$24,$23,$22,$EE,$27
.byte $6D,$24,$28,$E4,$26,$EE,$29,$2A
.byte $28,$E4,$EE,$26,$22,$27,$29,$2A
.byte $98,$98,$6C,$AC,$2F,$2C,$2E,$30
.byte $AB,$2F,$AC,$6C,$2E,$31,$30,$2D
.byte $00,$00,$00,$00,$00,$00,$00,$00
.byte $3B,$ED,$4C,$68,$4A,$E7,$B9,$4E
.byte $ED,$68,$E7,$4A,$B4,$BE,$BE,$4E
.byte $C4,$E1,$48,$C2,$49,$C3,$C3,$F2
.byte $E1,$C4,$FE,$C6,$C2,$48,$C3,$F2
.byte $42,$72,$47,$5A,$DA,$FE,$45,$61
.byte $5A,$72,$FE,$C6,$DA,$48,$49,$61
.byte $43,$43,$72,$42,$47,$58,$58,$45
.byte $4D,$52,$69,$4D,$54,$B6,$40,$50
.byte $52,$69,$B6,$D5,$54,$40,$D8,$50
.byte $CC,$B3,$D5,$B6,$A4,$D8,$53,$D6
.byte $B3,$CC,$C1,$51,$B5,$53,$D2,$D6
.byte $C1,$51,$B5,$A4,$D2,$50,$56,$D6
.byte $57,$57,$B0,$B0,$B0,$BB,$BB,$D0
.byte $CB,$CB,$AE,$AE,$55,$55,$D0,$D3
.byte $CD,$CD,$D9,$D9,$D9,$AF,$AF,$D3
.byte $BF,$C0,$BF,$C0,$A1,$A1,$A1,$BA
.byte $A8,$A8,$A6,$A6,$A9,$A9,$A7,$AA
.byte $C9,$44,$C9,$44,$C5,$C5,$C8,$C7
.byte $D1,$D7,$E8,$D8,$D4,$D3,$EC,$FF
.byte $D7,$EC,$D8,$D4,$D3,$46,$59,$AF
.byte $13,$13,$8B,$8B,$8B,$19,$19,$94
.byte $00,$00,$00,$00,$00,$00,$00,$00
.byte $00,$00,$00,$00,$00,$00,$00,$00
.byte $00,$00,$00,$00,$00,$00,$00,$00

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  LUT for battle formations  [$8400 :: 0x2C410]
;;
;;    The table containing which enemies you fight, how many of them there are,
;;  what palettes to use, etc, etc.
;;
;; BATTLE DATA
;; +0   = bits 4-7: battle formation
;;                   0 = 9 small
;;                   1 = 4 large
;;                   2 = 2 large & 6 small
;;                   3 = Fiend
;;                   4 = Chaos
;;                   5 = Mini boss mix
;;                   6 = Mini boss 9 small
;;                   7 = Mini boss 4 large
;;        bits 0-3: graphics set
;; +1   = 2 bits per enemy to select picture from the graphics set
;; +2-5 = enemy index numbers
;; +6-9 = high/low nybble is min/max # of the enemy in formation 1
;; +A   = palette 0
;; +B   = palette 1
;; +C   = "surprise" factor
;; +D   = bit  0:   can't run flag
;;        bits 4-7: palettes for enemies
;; +E-F = high/low nybble is min/max # of the enemy in formation 2

.ALIGN $100            ; must be on page bound

lut_BattleFormations:

;;    $0  $1         $2  $3  $4  $5   $6  $7  $8  $9  $A  $B  $C  $D   $E  $F        ; Formation 1                                           ;    ; Formation 2
.byte $00,%00000000, $00,$01,$FF,$FF, $35,$00,$00,$00,$00,$01,$04,$40, $36,$04  ; 00 ; 3-5 Imps                                              ; 80 ; 3-6 Imps       0-4 GrImps
.byte $02,%00001000, $15,$18,$FF,$FF, $24,$00,$00,$00,$0C,$0C,$04,$00, $35,$02  ; 01 ; 2-4 Bones                                             ; 81 ; 3-5 Bones      0-2 Crawls
.byte $00,%00101000, $01,$02,$03,$FF, $13,$02,$02,$02,$00,$01,$04,$A0, $13,$00  ; 02 ; 1-3 GrImps, 0-2 Wolves, 0-2 GrWolves, 0-2 Imps        ; 82 ; 1-3 GrImps
.byte $00,%00001010, $02,$03,$FF,$FF, $12,$00,$00,$00,$00,$01,$04,$40, $46,$01  ; 03 ; 1-2 Wolves                                            ; 83 ; 4-6 Wolves     0-1 GrWolves
.byte $04,%00001010, $2B,$2C,$FF,$FF, $24,$00,$00,$00,$16,$17,$04,$40, $23,$24  ; 04 ; 2-4 Zombies                                           ; 84 ; 2-3 Zombies    2-4 Ghouls
.byte $07,%00000010, $49,$45,$FF,$FF, $12,$00,$00,$00,$1A,$21,$37,$40, $00,$24  ; 05 ; 1-2 Spiders                                           ; 85 ; 2-4 Scum
.byte $1C,%00000001, $74,$FF,$FF,$FF, $11,$00,$00,$00,$32,$32,$04,$00, $24,$00  ; 06 ;   1 Madpony                                           ; 86 ; 2-4 Madpony            
.byte $22,%00001110, $17,$1B,$FF,$FF, $12,$00,$00,$00,$0D,$0E,$04,$40, $13,$11  ; 07 ; 1-2 Creep                                             ; 87 ; 1-3 Creep        1 Ogre
.byte $04,%00001010, $2C,$2D,$FF,$FF, $11,$00,$00,$00,$17,$18,$04,$40, $25,$04  ; 08 ; 1-2 Ghoul                                             ; 88 ; 2-5 Ghoul      0-4 GEIST 
.byte $10,%00000111, $09,$06,$FF,$FF, $00,$11,$00,$00,$02,$01,$04,$40, $13,$02  ; 09 ;   1 Iguana                                            ; 89 ; 1-3 GIANT      0-2 IGUANA 
.byte $04,%00000000, $27,$FF,$FF,$FF, $24,$00,$00,$00,$1A,$1A,$5A,$00, $37,$00  ; 0A ; 2-4 Shadow                                            ; 8A ; 3-7 SHADOW         
.byte $00,%00001010, $03,$02,$FF,$FF, $25,$03,$00,$00,$00,$01,$04,$80, $48,$00  ; 0B ; 2-5 GrWolves, 0-3 Wolves                              ; 8B ; 4-8 GrWolf   
.byte $12,%00000111, $1B,$19,$FF,$FF, $12,$00,$00,$00,$0E,$10,$04,$40, $13,$02  ; 0C ; 1-2 Ogre                                              ; 8C ; 1-3 OGRE       0-2 HYENA 
.byte $03,%00000000, $1E,$FF,$FF,$FF, $12,$00,$00,$00,$11,$11,$04,$00, $37,$00  ; 0D ; 1-2 Asp                                               ; 8D ; 3-7 ASP            
.byte $20,%00111000, $01,$04,$09,$FF, $05,$13,$02,$00,$01,$02,$21,$60, $25,$02  ; 0E ; 0-5 GrImp, 1-3 WrWolf, 0-2 Giant                      ; 8E ; 2-5 GrImp      0-2 WrWolf
.byte $04,%00001010, $2E,$2D,$FF,$FF, $00,$14,$00,$00,$18,$19,$04,$80, $25,$25  ; 0F ; 1-4 Specter                                           ; 8F ; 2-5 SPECTER    2-5 GEIST 
.byte $06,%00000010, $3E,$FF,$FF,$FF, $23,$00,$00,$00,$1F,$1F,$04,$00, $38,$00  ; 10 ; 2-3 Gargoyle                                          ; 90 ; 3-8 GARGOYLE       
.byte $00,%00001010, $04,$03,$FF,$FF, $36,$00,$00,$00,$01,$02,$21,$80, $25,$05  ; 11 ; 3-6 WrWolf                                            ; 91 ; 2-5 WrWolf     0-5 GrWolf 
.byte $07,%00001000, $47,$4A,$FF,$FF, $00,$14,$00,$00,$21,$22,$37,$80, $25,$05  ; 12 ; 1-4 Ooze                                              ; 92 ; 2-5 OOZE       0-5 ARACHNID 
.byte $12,%00001111, $1C,$1B,$FF,$FF, $11,$12,$00,$00,$0E,$0F,$04,$80, $14,$02  ; 13 ;   1 GrOgre, 1-2 Ogre                                  ; 93 ; 1-4 GrOGRE     0-2 OGRE 
.byte $07,%00000010, $4A,$FF,$FF,$FF, $12,$00,$00,$00,$21,$21,$04,$00, $48,$00  ; 14 ; 1-2 Arachnid                                          ; 94 ; 4-8 ARACHNID       
.byte $03,%00001000, $1F,$21,$FF,$FF, $26,$00,$00,$00,$12,$15,$04,$40, $26,$04  ; 15 ; 2-6 Cobra                                             ; 95 ; 2-6 COBRA      0-4 SCORPION 
.byte $08,%00000010, $51,$4F,$FF,$FF, $26,$00,$00,$00,$25,$26,$04,$80, $26,$15  ; 16 ; 2-6 Coctrice                                          ; 96 ; 2-6 COCTRICE   1-5 MUMMY 
.byte $15,%00000001, $38,$FF,$FF,$FF, $14,$00,$00,$00,$15,$15,$04,$00, $16,$00  ; 17 ; 1-4 Pede                                              ; 97 ; 1-6 PEDE           
.byte $04,%00000000, $28,$29,$FF,$FF, $26,$00,$00,$00,$18,$19,$04,$40, $26,$04  ; 18 ; 2-6 Image                                             ; 98 ; 2-6 IMAGE      0-4 WRAITH 
.byte $15,%00001111, $3B,$3A,$FF,$FF, $00,$13,$00,$00,$1A,$1D,$1B,$40, $13,$02  ; 19 ; 1-3 Tiger                                             ; 99 ; 1-3 Saber T    0-2 TIGER 
.byte $23,%00000110, $21,$23,$FF,$FF, $24,$00,$00,$00,$11,$15,$1B,$80, $26,$12  ; 1A ; 2-4 Scorpion                                          ; 9A ; 2-6 SCORPION   1-2 BULL 
.byte $13,%00000111, $25,$23,$FF,$FF, $12,$01,$00,$00,$11,$12,$1B,$80, $12,$02  ; 1B ; 1-2 Troll, 0-1 Bull                                   ; 9B ; 1-2 TROLL      0-2 BULL 
.byte $0B,%00000000, $67,$FF,$FF,$FF, $24,$00,$00,$00,$32,$32,$21,$01, $37,$00  ; 1C ; 2-4 Wizard                                            ; 9C ; 3-7 WIZARD         
.byte $08,%00000000, $4F,$50,$FF,$FF, $25,$00,$00,$00,$25,$26,$04,$40, $37,$11  ; 1D ; 2-5 Mummy                                             ; 9D ; 3-7 MUMMY        1 WzMUMMY 
.byte $10,%00000011, $09,$FF,$FF,$FF, $12,$00,$00,$00,$02,$02,$04,$00, $24,$00  ; 1E ; 1-2 Giant                                             ; 9E ; 2-4 GIANT          
.byte $10,%00000111, $09,$06,$FF,$FF, $12,$03,$00,$00,$01,$02,$04,$80, $14,$11  ; 1F ; 1-2 Giant, 0-3 Iguana                                 ; 9F ; 1-4 GIANT        1 IGUANA 
.byte $29,%00001011, $5D,$59,$FF,$FF, $12,$00,$00,$00,$2A,$2B,$1B,$40, $14,$03  ; 20 ; 1-2 Hydra                                             ; A0 ; 1-4 HYDRA      0-3 GATOR 
.byte $16,%00000001, $40,$FF,$FF,$FF, $11,$00,$00,$00,$1C,$1C,$04,$01, $24,$00  ; 21 ;   1 Earth                                             ; A1 ; 2-4 EARTH          
.byte $12,%00001101, $1A,$1D,$FF,$FF, $01,$12,$00,$00,$0D,$10,$37,$41, $13,$02  ; 22 ; 0-1 Cerebus, 1-2 WzOgre                               ; A2 ; 1-3 CEREBUS    0-2 WzOGRE 
.byte $08,%00000010, $52,$FF,$FF,$FF, $25,$00,$00,$00,$25,$25,$04,$00, $48,$00  ; 23 ; 2-5 Perelisk                                          ; A3 ; 4-8 PERILISK       
.byte $19,%00000011, $5E,$FF,$FF,$FF, $11,$00,$00,$00,$03,$03,$04,$00, $44,$00  ; 24 ;   1 R. Hydra                                          ; A4 ; 4-4 R`HYDRA        
.byte $29,%00000001, $5B,$57,$FF,$FF, $13,$00,$00,$00,$2A,$2B,$21,$80, $11,$02  ; 25 ; 1-3 Ocho                                              ; A5 ; 1-1 OCHO       0-2 CARIBE 
.byte $10,%00000111, $0B,$07,$FF,$FF, $12,$00,$00,$00,$03,$03,$04,$00, $11,$13  ; 26 ; 1-2 R. Giant                                          ; A6 ; 1-1 R`GIANT    1-3 AGAMA 
.byte $16,%00000001, $41,$FF,$FF,$FF, $12,$00,$00,$00,$03,$03,$04,$01, $34,$00  ; 27 ; 1-2 Fire                                              ; A7 ; 3-4 FIRE           
.byte $14,%00000001, $31,$FF,$FF,$FF, $11,$00,$00,$00,$19,$19,$04,$00, $24,$00  ; 28 ;   1 Grey W.                                           ; A8 ; 2-4 Grey W         
.byte $10,%00000001, $07,$FF,$FF,$FF, $11,$00,$00,$00,$03,$03,$04,$00, $24,$00  ; 29 ;   1 Agama                                             ; A9 ; 2-4 AGAMA          
.byte $16,%00000011, $43,$FF,$FF,$FF, $11,$00,$00,$00,$0D,$0D,$04,$00, $24,$00  ; 2A ;   1 Red D.                                            ; AA ; 2-4 Red D          
.byte $02,%00100000, $16,$15,$18,$FF, $11,$24,$11,$00,$0C,$0D,$04,$80, $36,$00  ; 2B ;   1 R. Bone, 2-4 Bone, 1 Crawl                        ; AB ; 3-6 R`BONE    
.byte $04,%10100000, $29,$28,$2E,$2D, $15,$03,$03,$03,$18,$19,$04,$A0, $26,$00  ; 2C ; 1-5 Wraith, 0-3 Image, 0-3 Specter, 0-3 Geist         ; AC ; 2-6 WRAITH     
.byte $00,%00000010, $05,$FF,$FF,$FF, $37,$00,$00,$00,$04,$04,$04,$00, $47,$00  ; 2D ; 3-7 FrWolf                                            ; AD ; 4-7 FrWOLF         
.byte $20,%00001011, $0A,$05,$FF,$FF, $11,$02,$00,$00,$04,$04,$04,$01, $22,$26  ; 2E ;   1 FrGiant, 0-2 FrWolf                               ; AE ; 2-2 FrGIANT    2-6 FrWOLF 
.byte $0C,%00001010, $72,$73,$FF,$FF, $14,$00,$00,$00,$24,$2E,$4B,$40, $23,$11  ; 2F ; 1-4 Mage                                              ; AF ; 2-3 MAGE         1 FIGHTER 
.byte $16,%00000011, $42,$FF,$FF,$FF, $12,$00,$00,$00,$07,$07,$04,$00, $34,$00  ; 30 ; 1-2 Frost D.                                          ; B0 ; 3-4 Frost D        
.byte $15,%00000001, $39,$FF,$FF,$FF, $11,$00,$00,$00,$0C,$0C,$04,$00, $12,$00  ; 31 ;   1 GrPede                                            ; B1 ; 1-2 GrPEDE         
.byte $13,%00001101, $24,$25,$FF,$FF, $13,$00,$00,$00,$12,$16,$04,$81, $14,$02  ; 32 ; 1-3 ZomBull                                           ; B2 ; 1-4 ZomBULL    0-2 TROLL 
.byte $05,%00000010, $37,$34,$FF,$FF, $35,$00,$00,$00,$0E,$1E,$04,$80, $37,$05  ; 33 ; 3-5 Mancat                                            ; B3 ; 3-7 MANCAT     0-5 MEDUSA 
.byte $25,%00001100, $34,$3B,$FF,$FF, $25,$00,$00,$00,$0E,$1A,$1B,$40, $36,$12  ; 34 ; 2-5 Medusa                                            ; B4 ; 3-6 MEDUSA     1-2 Saber T 
.byte $2B,%00001100, $68,$6C,$FF,$FF, $25,$00,$00,$00,$33,$34,$04,$40, $16,$12  ; 35 ; 2-5 Sorcerer                                          ; B5 ; 1-6 SORCERER   1-2 MudGOL 
.byte $17,%00000001, $4B,$FF,$FF,$FF, $13,$00,$00,$00,$1D,$1D,$04,$00, $34,$00  ; 36 ; 1-3 Manticor                                          ; B6 ; 3-4 MATICOR        
.byte $18,%00000001, $54,$FF,$FF,$FF, $13,$00,$00,$00,$27,$27,$04,$00, $13,$00  ; 37 ; 1-3 Wyrm                                              ; B7 ; 1-3 WYRM           
.byte $17,%00000011, $4D,$FF,$FF,$FF, $13,$00,$00,$00,$22,$22,$04,$00, $14,$00  ; 38 ; 1-3 R. Ankylo                                         ; B8 ; 1-4 R`ANKYLO       
.byte $25,%00001110, $36,$3B,$FF,$FF, $24,$00,$00,$00,$1A,$1D,$1B,$80, $36,$12  ; 39 ; 2-4 Catman                                            ; B9 ; 3-6 CATMAN     1-2 Saber T 
.byte $10,%00000001, $08,$FF,$FF,$FF, $12,$00,$00,$00,$05,$05,$1B,$00, $24,$00  ; 3A ; 1-2 Sauria                                            ; BA ; 2-4 SAURIA         
.byte $1A,%00000011, $65,$FF,$FF,$FF, $13,$00,$00,$00,$30,$30,$04,$00, $34,$00  ; 3B ; 1-3 Chimera                                           ; BB ; 3-4 CHIMERA        
.byte $14,%00000001, $30,$FF,$FF,$FF, $11,$00,$00,$00,$1C,$1C,$04,$00, $12,$00  ; 3C ;   1 Sand W.                                           ; BC ; 1-2 Sand W         
.byte $18,%00000111, $55,$53,$FF,$FF, $11,$00,$00,$00,$28,$29,$04,$80, $11,$01  ; 3D ;   1 Tyro                                              ; BD ; 1-1 TYRO       0-1 WYVERN 
.byte $18,%00110101, $53,$54,$56,$FF, $00,$00,$11,$00,$27,$28,$04,$A0, $13,$05  ; 3E ;   1 T-Rex                                             ; BE ; 1-3 WYVERN     0-5 WYRM
.byte $1B,%00001111, $6C,$6D,$FF,$FF, $13,$00,$00,$00,$34,$35,$04,$40, $14,$13  ; 3F ; 1-3 MudGol                                            ; BF ; 1-4 MudGOL     1-3 RockGOL 
.byte $05,%00000000, $35,$FF,$FF,$FF, $14,$00,$00,$00,$0F,$0F,$04,$00, $47,$00  ; 40 ; 1-4 GrMedusa                                          ; C0 ; 4-7 GrMEDUSA       
.byte $19,%00000001, $5C,$FF,$FF,$FF, $11,$00,$00,$00,$2C,$2C,$21,$00, $12,$00  ; 41 ;   1 Naocho                                            ; C1 ; 1-2 NAOCHO         
.byte $23,%00001011, $26,$22,$FF,$FF, $12,$13,$00,$00,$13,$14,$04,$80, $12,$14  ; 42 ; 1-2 SeaTroll, 1-3 Lobsters                            ; C2 ; 1-2 SeaTROLL   1-4 LOBSTER 
.byte $03,%00000010, $22,$FF,$FF,$FF, $26,$00,$00,$00,$13,$13,$04,$00, $37,$00  ; 43 ; 2-6 Lobsters                                          ; C3 ; 3-7 LOBSTER        
.byte $23,%00110010, $22,$20,$26,$FF, $16,$25,$22,$00,$13,$14,$04,$20, $15,$03  ; 44 ; 1-6 Lobsters, 2-5 SeaSnakes, 2 SeaTrolls              ; C4 ; 1-5 LOBSTER    0-3 SeaSNAKE
.byte $21,%00000100, $0E,$12,$FF,$FF, $01,$12,$00,$00,$07,$0B,$04,$80, $36,$22  ; 45 ; 0-1 WzSahag, 1-2 GrShark                              ; C5 ; 3-6 WzSAHAG    2-2 GrSHARK 
.byte $24,%00001100, $2A,$33,$FF,$FF, $00,$11,$00,$00,$07,$16,$04,$41, $25,$00  ; 46 ;   1 Phantom                                           ; C6 ; 2-5 GHOST      
.byte $2A,%00001001, $63,$61,$FF,$FF, $11,$01,$00,$00,$13,$13,$04,$00, $12,$36  ; 47 ;   1 Naga, 0-1 Water                                   ; C7 ; 1-2 NAGA       3-6 WATER 
.byte $11,%00001101, $12,$14,$FF,$FF, $11,$01,$00,$00,$07,$09,$04,$40, $12,$12  ; 48 ;   1 GrShark, 0-1 BigEye                               ; C8 ; 1-2 GrSHARK    1-2 BigEYE 
.byte $0A,%00000010, $61,$FF,$FF,$FF, $13,$00,$00,$00,$13,$13,$04,$01, $36,$00  ; 49 ; 1-3 Water                                             ; C9 ; 3-6 WATER          
.byte $08,%10100000, $50,$4F,$51,$52, $15,$08,$08,$08,$25,$26,$04,$A0, $12,$16  ; 4A ; 1-5 WzMummy, 0-8 Mummy, 0-8 Coctrice, 0-8 Perelisk    ; CA ; 1-2 WzMUMMY    1-6 MUMMY 
.byte $16,%00000011, $44,$FF,$FF,$FF, $12,$00,$00,$00,$16,$16,$04,$01, $24,$00  ; 4B ; 1-2 Zombie Dragons                                    ; CB ; 2-4 ZombieD        
.byte $0A,%00000000, $5F,$60,$FF,$FF, $25,$00,$00,$00,$2E,$2F,$04,$40, $01,$11  ; 4C ; 2-5 Guards                                            ; CC ; 0-1 GAURD      1-1 SENTRY 
.byte $0C,%00000000, $6F,$FF,$FF,$FF, $25,$00,$00,$00,$24,$24,$04,$00, $59,$00  ; 4D ; 2-5 Badman                                            ; CD ; 5-9 BADMAN         
.byte $1B,%00000001, $6B,$FF,$FF,$FF, $11,$00,$00,$00,$14,$14,$04,$01, $23,$00  ; 4E ;   1 Blue D.                                           ; CE ; 2-3 Blue D         
.byte $2C,%00000001, $75,$6F,$FF,$FF, $13,$00,$00,$00,$24,$33,$04,$80, $12,$12  ; 4F ; 1-3 NiteMare                                          ; CF ; 1-2 NITEMARE   1-2 BADMAN 
.byte $07,%00000000, $48,$FF,$FF,$FF, $36,$00,$00,$00,$24,$24,$04,$00, $48,$00  ; 50 ; 3-6 Slime                                             ; D0 ; 4-8 SLIME          
.byte $0A,%00000010, $62,$FF,$FF,$FF, $24,$00,$00,$00,$04,$04,$04,$00, $36,$00  ; 51 ; 2-4 Air                                               ; D1 ; 3-6 AIR            
.byte $2A,%00001001, $64,$62,$FF,$FF, $11,$01,$00,$00,$04,$2D,$04,$80, $01,$13  ; 52 ;   1 GrNaga, 0-1 Air                                   ; D2 ; 0-1 GrNAGA     1-3 AIR 
.byte $26,%00001100, $3D,$44,$FF,$FF, $13,$00,$00,$00,$16,$20,$04,$80, $13,$12  ; 53 ; 1-3 WzVamp                                            ; D3 ; 1-3 WzVAMP     1-2 ZombieD 
.byte $2C,%00000100, $70,$75,$FF,$FF, $11,$12,$00,$00,$17,$33,$04,$40, $12,$12  ; 54 ;   1 Evilman, 1-2 Nitemare                             ; D4 ; 1-2 EVILMAN    1-2 NITEMARE 
.byte $1A,%00001111, $65,$66,$FF,$FF, $12,$12,$00,$00,$30,$31,$04,$40, $11,$00  ; 55 ; 1-2 Chimera, 1-2 Jimera                               ; D5 ; 1-1 CHIMERA   
.byte $2C,%00001011, $76,$73,$FF,$FF, $11,$00,$00,$00,$2E,$2F,$4B,$80, $00,$12  ; 56 ;   1 WarMech                                           ; D6 ; 1-2 FIGHTER 
.byte $14,%00000001, $2F,$FF,$FF,$FF, $12,$00,$00,$00,$1B,$1B,$04,$01, $34,$00  ; 57 ; 1-2 Worm                                              ; D7 ; 3-4 WORM           
.byte $1B,%00000011, $6D,$FF,$FF,$FF, $12,$00,$00,$00,$35,$35,$04,$00, $24,$00  ; 58 ; 1-2 RockGol                                           ; D8 ; 2-4 RockGOL        
.byte $1B,%00000001, $6A,$FF,$FF,$FF, $11,$00,$00,$00,$21,$21,$04,$01, $24,$00  ; 59 ;   1 Gas D.                                            ; D9 ; 2-4 Gas D          
.byte $11,%00000101, $12,$11,$FF,$FF, $12,$01,$00,$00,$07,$09,$04,$40, $12,$01  ; 5A ; 1-2 GrShark, 0-1 Shark                                ; DA ; 1-2 GrSHARK    0-1 SHARK 
.byte $21,%00110000, $0C,$0D,$13,$FF, $06,$00,$12,$00,$08,$09,$04,$80, $37,$02  ; 5B ; 0-6 Sahag, 1-2 R.Sahag                                ; DB ; 3-7 SAHAG      0-2 R`SAHAG
.byte $21,%00000110, $10,$11,$00,$FF, $15,$00,$00,$00,$09,$0A,$04,$80, $00,$11  ; 5C ; 1-5 Kyzoku                                            ; DC ; 1-1 SHARK 
.byte $21,%00000001, $11,$0C,$00,$FF, $12,$02,$00,$00,$08,$09,$04,$C0, $00,$46  ; 5D ; 1-2 Shark, 0-2 Sahag                                  ; DD ; 4-6 SAHAG 
.byte $21,%00000001, $11,$0D,$00,$FF, $11,$01,$00,$00,$08,$09,$04,$80, $12,$03  ; 5E ;   1 Shark, 0-1 R.Sahag                                ; DE ; 1-2 SHARK      0-3 R`SAHAG 
.byte $09,%00000000, $57,$FF,$00,$FF, $26,$00,$00,$00,$2A,$2A,$04,$00, $38,$00  ; 5F ; 2-6 Caribe                                            ; DF ; 3-8 CARIBE         
.byte $19,%00000111, $5D,$5B,$00,$FF, $12,$02,$00,$00,$2A,$2B,$21,$40, $11,$01  ; 60 ; 1-2 Hydra, 0-2 Ocho                                   ; E0 ; 1-1 HYDRA      0-1 OCHO 
.byte $23,%00100011, $26,$20,$22,$FF, $12,$02,$02,$00,$13,$14,$04,$80, $11,$03  ; 61 ; 1-2 SeaTroll, 0-2 SeaSnake, 0-2 Lobsters              ; E1 ; 1-1 SeaTROLL   0-3 SeaSNAKE
.byte $09,%00000010, $5A,$58,$00,$FF, $12,$03,$00,$00,$2C,$2D,$04,$80, $11,$14  ; 62 ; 1-2 FrGator, 0-3 R.Caribe                             ; E2 ; 1-1 FrGATOR    1-4 R`CARIBE 
.byte $13,%00000011, $25,$FF,$00,$FF, $12,$00,$00,$00,$12,$12,$04,$00, $24,$00  ; 63 ; 1-2 Troll                                             ; E3 ; 2-4 TROLL          
.byte $13,%00000001, $23,$FF,$00,$FF, $12,$00,$00,$00,$11,$11,$1B,$00, $24,$00  ; 64 ; 1-2 Bull                                              ; E4 ; 2-4 BULL           
.byte $29,%00011000, $57,$59,$5B,$FF, $02,$02,$11,$00,$2A,$2B,$1E,$60, $24,$02  ; 65 ; 0-2 Caribe, 0-2 Gator, 1 Ocho                         ; E5 ; 2-4 CARIBE     0-2 GATOR
.byte $07,%00001010, $4A,$49,$45,$46, $12,$02,$01,$01,$1A,$21,$37,$A0, $36,$02  ; 66 ; 1-2 Arachnid, 0-1 Spider, 0-1 Scum, 0-1 Muck          ; E6 ; 3-6 ARACHNID   0-2 SPIDER 
.byte $25,%00001110, $36,$3B,$FF,$FF, $13,$02,$00,$00,$1A,$1D,$1B,$80, $47,$00  ; 67 ; 1-3 Catman, 0-2 Saber T                               ; E7 ; 4-7 CATMAN     
.byte $06,%00000000, $3D,$3C,$FF,$FF, $00,$25,$00,$00,$1F,$20,$04,$80, $11,$36  ; 68 ; 2-5 WzVamp                                            ; E8 ; 1-1 WzVAMP     3-6 VAMPIRE 
.byte $24,%00000011, $32,$FF,$FF,$FF, $11,$00,$00,$00,$17,$17,$04,$01, $23,$00  ; 69 ;   1 Eye                                               ; E9 ; 2-3 EYE            
.byte $06,%00000010, $3F,$FF,$FF,$FF, $25,$00,$00,$00,$20,$20,$04,$00, $37,$00  ; 6A ; 2-5 R.Goyle                                           ; EA ; 3-7 R`GOYLE        
.byte $07,%00000000, $46,$FF,$FF,$FF, $13,$00,$00,$00,$1A,$1A,$04,$00, $47,$00  ; 6B ; 1-3 Muck                                              ; EB ; 4-7 MUCK           
.byte $0B,%00000000, $68,$FF,$FF,$FF, $13,$00,$00,$00,$33,$33,$04,$00, $37,$00  ; 6C ; 1-3 Sorcerer                                          ; EC ; 3-7 SORCERER       
.byte $12,%00000001, $1A,$FF,$FF,$FF, $12,$00,$00,$00,$0D,$0D,$37,$00, $34,$00  ; 6D ; 1-2 Cerebus                                           ; ED ; 3-4 CEREBUS        
.byte $12,%00011111, $1D,$1C,$19,$FF, $11,$11,$02,$00,$0F,$10,$04,$A0, $13,$02  ; 6E ;   1 WzOgre, 1 GrOgre, 0-7 Hyena (bug? changed to 0-2) ; EE ; 1-3 WzOGRE     0-2 GrOGRE
.byte $17,%00000001, $4C,$FF,$FF,$FF, $12,$00,$00,$00,$23,$23,$04,$00, $14,$00  ; 6F ; 1-2 Sphinxes                                          ; EF ; 1-4 Sphinxes              
.byte $18,%00000001, $53,$FF,$FF,$FF, $13,$00,$00,$00,$28,$28,$04,$00, $14,$00  ; 70 ; 1-3 Wyverns                                           ; F0 ; 1-4 Wyverns               
.byte $17,%00000011, $4E,$FF,$FF,$FF, $11,$00,$00,$00,$1C,$1C,$04,$00, $12,$00  ; 71 ;   1 Ankylo                                            ; F1 ; 1-2 Ankylo                
.byte $03,%00000000, $20,$FF,$FF,$FF, $24,$00,$00,$00,$13,$13,$04,$00, $36,$00  ; 72 ; 2-4 Sea Snakes                                        ; F2 ; 3-6 Sea Snakes            
.byte $3D,%00000001, $78,$77,$FF,$FF, $11,$00,$00,$00,$36,$37,$04,$01, $00,$11  ; 73 ;     Lich 2                                            ; F3 ;     Lich 1
.byte $3D,%00000000, $7A,$79,$FF,$FF, $11,$00,$00,$00,$38,$39,$04,$01, $00,$11  ; 74 ;     Kary 2                                            ; F4 ;     Kary 1
.byte $3E,%00000010, $7C,$7B,$FF,$FF, $11,$00,$00,$00,$3A,$3B,$04,$01, $00,$11  ; 75 ;     Kraken 2                                          ; F5 ;     Kraken 1
.byte $3E,%00000011, $7E,$7D,$FF,$FF, $11,$00,$00,$00,$3C,$3D,$04,$01, $00,$11  ; 76 ;     Tiamat 2                                          ; F6 ;     Tiamat 1
.byte $00,%00000000, $00,$FF,$FF,$FF, $00,$00,$00,$00,$00,$00,$00,$00, $00,$00  ; 77 ;                                                       ; F7 ; 
.byte $00,%00000000, $00,$FF,$FF,$FF, $00,$00,$00,$00,$00,$00,$00,$00, $00,$00  ; 78 ;                                                       ; F8 ; 
.byte $5B,%00001110, $69,$FF,$FF,$FF, $11,$00,$00,$00,$13,$2E,$04,$41, $00,$00  ; 79 ;     Garland                                           ; F9 ;   
.byte $61,%00100000, $0F,$FF,$FF,$FF, $99,$00,$00,$00,$08,$0B,$04,$A1, $00,$00  ; 7A ;   9 Pirates                                           ; FA ; 
.byte $4F,%00000100, $7F,$FF,$FF,$FF, $11,$00,$00,$00,$3E,$3F,$04,$01, $00,$00  ; 7B ;     Chaos                                             ; FB ;                 
.byte $56,%00000000, $3C,$FF,$FF,$FF, $11,$00,$00,$00,$1F,$1F,$04,$01, $00,$00  ; 7C ;     Vampire                                           ; FC ;                 
.byte $5C,%00000010, $71,$FF,$FF,$FF, $11,$00,$00,$00,$06,$06,$04,$01, $00,$00  ; 7D ;     Astos                                             ; FD ;                 
.byte $01,%00100000, $0E,$0D,$FF,$FF, $00,$00,$00,$00,$08,$0B,$04,$A1, $12,$88  ; 7E ;                                                       ; FE ; 1-2 WzSahag     8-8 R.Sahag
.byte $2B,%00001110, $00,$6E,$FF,$FF, $11,$00,$00,$00,$13,$2E,$04,$41, $00,$12  ; 7F ;                                                       ; FF ;                 1-2 IronGol

;.byte $3D,$01,$78,$00,$00,$00,$11,$00,$00,$00,$36,$37,$04,$01,$00,$00  ; 73 ;     Lich reprise                                      ;                 
;.byte $3D,$00,$7A,$00,$00,$00,$11,$00,$00,$00,$38,$39,$04,$01,$00,$00  ; 74 ;     Kary reprise                                      ;                 
;.byte $3E,$02,$7C,$00,$00,$00,$11,$00,$00,$00,$3A,$3B,$04,$01,$00,$00  ; 75 ;     Kraken reprise                                    ;                 
;.byte $3E,$03,$7E,$00,$00,$00,$11,$00,$00,$00,$3C,$3D,$04,$01,$00,$00  ; 76 ;     Tiamat reprise                                    ;                 
;.byte $3E,$03,$7D,$00,$00,$00,$11,$00,$00,$00,$3C,$3D,$04,$01,$00,$00  ; 77 ;     Tiamat                                            ;                 
;.byte $3E,$02,$7B,$00,$00,$00,$11,$00,$00,$00,$3A,$3B,$04,$01,$00,$00  ; 78 ;     Kraken                                            ;                 
;.byte $3D,$00,$79,$00,$00,$00,$11,$00,$00,$00,$38,$39,$04,$01,$00,$00  ; 79 ;     Kary                                              ;                 
;.byte $3D,$01,$77,$00,$00,$00,$11,$00,$00,$00,$36,$37,$04,$01,$00,$00  ; 7A ;     Lich                                              ;                 
;.byte $4F,$04,$7F,$00,$00,$00,$11,$00,$00,$00,$3E,$3F,$04,$01,$00,$00  ; 7B ;     Chaos                                             ;                 
;.byte $56,$00,$3C,$00,$00,$00,$11,$00,$00,$00,$1F,$1F,$04,$01,$00,$00  ; 7C ;     Vampire                                           ;                 
;.byte $5C,$02,$71,$00,$00,$00,$11,$00,$00,$00,$06,$06,$04,$01,$00,$00  ; 7D ;     Astos                                             ;                 
;.byte $01,$20,$0E,$0D,$0F,$00,$00,$00,$99,$00,$08,$0B,$04,$A1,$12,$88  ; 7E ;   9 Pirates                                           ; 1-2 WzSahag     8-8 R.Sahag
;.byte $2B,$0E,$69,$6E,$00,$00,$11,$00,$00,$00,$13,$2E,$04,$41,$00,$12  ; 7F ;     Garland                                           ;                 1-2 IronGol

;; JIGS - left nybble: enemy size (0 = small, 1 = large, 2 = fiend, 3 = chaos)
;;       right nybble: enemy place in chr list
;;        second byte: order in bank (small and large are seperated graphically)

;lut_EnemyBankCHR:
;.byte $00,$00 ;00 IMP	
;.byte $00,$00 ;01 GrIMP	
;.byte $00,$01 ;02 WOLF	
;.byte $00,$01 ;03 GrWolf	
;.byte $00,$01 ;04 WrWolf 
;.byte $00,$01 ;05 FrWOLF 
;.byte $10,$00 ;06 IGUANA 
;.byte $10,$00 ;07 AGAMA
;.byte $10,$00 ;08 SAURIA
;.byte $10,$01 ;09 GIANT
;.byte $10,$01 ;0A FrGIANT
;.byte $10,$01 ;0B R`GIANT
;.byte $00,$02 ;0C SAHAG
;.byte $00,$02 ;0D R`SAHAG
;.byte $00,$02 ;0E WzSAHAG
;.byte $00,$03 ;0F PIRATE
;.byte $00,$03 ;10 KYZOKU
;.byte $10,$02 ;11 SHARK
;.byte $10,$02 ;12 GrSHARK
;.byte $10,$03 ;13 OddEYE
;.byte $10,$03 ;14 BigEYE
;.byte $00,$04 ;15 BONE
;.byte $00,$04 ;16 R`BONE
;.byte $00,$05 ;17 CREEP
;.byte $00,$05 ;18 CRAWL
;.byte $10,$04 ;19 HYENA
;.byte $10,$04 ;1A CEREBUS
;.byte $10,$05 ;1B OGRE
;.byte $10,$05 ;1C GrOGRE
;.byte $10,$05 ;1D WzOGRE
;.byte $00,$06 ;1E ASP
;.byte $00,$06 ;1F COBRA
;.byte $00,$06 ;20 SeaSNAKE
;.byte $00,$07 ;21 SCORPION
;.byte $00,$07 ;22 LOBSTER
;.byte $10,$06 ;23 BULL
;.byte $10,$06 ;24 ZomBULL
;.byte $10,$07 ;25 TROLL
;.byte $10,$07 ;26 SeaTROLL
;.byte $00,$08 ;27 SHADOW
;.byte $00,$08 ;28 IMAGE
;.byte $00,$08 ;29 WRAITH
;.byte $00,$08 ;2A GHOST
;.byte $00,$09 ;2B ZOMBIE
;.byte $00,$09 ;2C GHOUL 
;.byte $00,$09 ;2D GEIST
;.byte $00,$09 ;2E SPECTER
;.byte $10,$08 ;2F WORM
;.byte $10,$08 ;30 Sand W
;.byte $10,$08 ;31 Grey W
;.byte $10,$09 ;32 EYE
;.byte $10,$09 ;33 PHANTOM
;.byte $00,$0A ;34 MEDUSA
;.byte $00,$0A ;35 GrMEDUSA
;.byte $00,$0B ;36 CATMAN
;.byte $00,$0B ;37 MANCAT
;.byte $10,$0A ;38 PEDE
;.byte $10,$0A ;39 GrPEDE
;.byte $10,$0B ;3A TIGER
;.byte $10,$0B ;3B Saber T
;.byte $00,$0C ;3C VAMPIRE
;.byte $00,$0C ;3D WzVAMP
;.byte $00,$0D ;3E GARGOYLE
;.byte $00,$0D ;3F R`GOYLE
;.byte $10,$0C ;40 EARTH
;.byte $10,$0C ;41 FIRE
;.byte $10,$0D ;42 Frost D
;.byte $10,$0D ;43 Red D
;.byte $10,$0D ;44 ZombieD
;.byte $00,$0E ;45 SCUM
;.byte $00,$0E ;46 MUCK
;.byte $00,$0E ;47 OOZE
;.byte $00,$0E ;48 SLIME
;.byte $00,$0F ;49 SPIDER
;.byte $00,$0F ;4A ARACHNID
;.byte $10,$0E ;4B MATICOR
;.byte $10,$0E ;4C SPHINX
;.byte $10,$0F ;4D R`ANKYLO
;.byte $10,$0F ;4E ANKYLO
;.byte $01,$00 ;4F MUMMY
;.byte $01,$00 ;50 WzMUMMY
;.byte $01,$01 ;51 COCTRICE
;.byte $01,$01 ;52 PERILISK
;.byte $11,$00 ;53 WYVERN
;.byte $11,$00 ;54 WYRM
;.byte $11,$01 ;55 TYRO
;.byte $11,$01 ;56 T REX
;.byte $01,$02 ;57 CARIBE
;.byte $01,$02 ;58 R`CARIBE
;.byte $01,$03 ;59 GATOR
;.byte $01,$03 ;5A FrGATOR
;.byte $11,$02 ;5B OCHO
;.byte $11,$02 ;5C NAOCHO
;.byte $11,$03 ;5D HYDRA
;.byte $11,$03 ;5E R`HYDRA
;.byte $01,$04 ;5F GAURD
;.byte $01,$04 ;60 SENTRY
;.byte $01,$05 ;61 WATER
;.byte $01,$05 ;62 AIR
;.byte $11,$04 ;63 NAGA
;.byte $11,$04 ;64 GrNAGA
;.byte $11,$05 ;65 CHIMERA
;.byte $11,$05 ;66 JIMERA
;.byte $01,$06 ;67 WIZARD
;.byte $01,$06 ;68 SORCERER
;.byte $01,$07 ;69 GARLAND
;.byte $11,$06 ;6A Gas D
;.byte $11,$06 ;6B Blue D
;.byte $11,$07 ;6C MudGOL
;.byte $11,$07 ;6D RockGOL
;.byte $11,$07 ;6E IronGOL
;.byte $01,$08 ;6F BADMAN
;.byte $01,$08 ;70 EVILMAN
;.byte $01,$09 ;71 ASTOS
;.byte $01,$09 ;72 MAGE
;.byte $01,$09 ;73 FIGHTER
;.byte $11,$08 ;74 MADPONY
;.byte $11,$08 ;75 NITEMARE
;.byte $11,$09 ;76 WarMECH
;.byte $21,$FF ;77 LICH
;.byte $21,$FF ;78 LICH (reprise)
;.byte $21,$FF ;79 KARY
;.byte $21,$FF ;7A KARY (reprise)
;.byte $21,$FF ;7B KRAKEN
;.byte $21,$FF ;7C KRAKEN (reprise)
;.byte $21,$FF ;7D TIAMAT
;.byte $21,$FF ;7E TIAMAT (reprise)
;.byte $31,$FF ;7F CHAOS
;
;
;
;
;LoadEnemyGraphics:
;;    LDY #2
;   @LoadNext: 
;    LDA (tmp+4), Y              ; get enemy ID
;    CMP #$FF                    ; if $FF, do... something to skip it
;    BEQ :+
;  
;    ASL A                       ; double ID, put in X
;    TAX
;    STY enemyload_counter       ; save Y as counter
;    LDA lut_EnemyBankCHR, X     ; get first byte of this table
;    AND #$0F                    ; cut off high bits
;    LDY enemyload_pointer       ; load the pointer thing into Y
;    STA enemyload, Y            ; save the bank # as this byte in the new loading list
;    INY
;    LDA lut_enemyBankCHR, X     ; get first byte again
;    AND #$F0                    ; cut off low bits
;    BEQ @SmallEnemy             ; if its 0, its a small enemy, else...
;    
;    CMP #02
;    BEQ @Fiend
;    CMP #03
;    BEQ @Chaos
;    
;   @LargeEnemy:
;    INX                         ; get second byte of above table
;    LDA lut_enemyBankCHR, X     ; large enemies are $240 bytes each - #576 bytes 
;    LDX #$24                    ; so multiply by...
;    JSR MultiplyXA              ; 
;    STA enemyload, Y            ; low byte of address
;    INY                         ; 
;    TXA                         ; get high byte of multiplication
;    ORA #$80                    ; set highest bit so it loads from the bank's address properly
;    STA enemyload, Y            ; and save as high byte of address
;    INY 
;    STY enemyload_pointer
;    LDY enemyload_counter
;    INY
;    CPY #6
;    BEQ @Finish
;    JMP @LoadNext
;    
;    
;   @SmallEnemy:
;    INX                         ; get second byte of above table
;    LDA lut_enemyBankCHR, X     ; small enemies are $100 bytes each
;    STA enemyload, Y            ; low byte of address
;    INY                         ; 
;    TXA                         ; get high byte of multiplication
;    ORA #$80                    ; set highest bit so it loads from the bank's address properly
;    STA enemyload, Y            ; and save as high byte of address
;    INY 
;    STY enemyload_pointer
;    LDY enemyload_counter
;    INY
;    CPY #6
;    BEQ @Finish
;    JMP @LoadNext
    
    
    
    
    
    
    
    
    
    
    
    

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  LUT for battle encounter rates per map  [$8C00 :: 0x2CC10]

lut_BattleRates:
  
.byte $0A,$08,$08,$08,$08,$08,$08,$08,$08,$08,$08,$08,$08,$08,$08,$08
.byte $08,$08,$08,$08,$08,$08,$08,$08,$08,$08,$08,$08,$08,$08,$08,$08
.byte $08,$08,$08,$08,$08,$08,$08,$08,$08,$08,$08,$08,$08,$08,$08,$08
.byte $08,$08,$08,$08,$18,$08,$08,$08,$09,$0A,$0B,$0C,$01,$08,$08,$08


 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Exp to advance to the next level  [$9000 :: 0x2D010]

lut_ExpToAdvance:
  .FARADDR     40 ; level 2 
  .FARADDR    196 ; level 3 
  .FARADDR    547 ; level 4 
  .FARADDR   1171 ; level 5 
  .FARADDR   2146 ; level 6 
  .FARADDR   3550 ; level 7 
  .FARADDR   5461 ; level 8 
  .FARADDR   7957 ; level 9 
  .FARADDR  11116 ; level 10
  .FARADDR  15016 ; level 11
  .FARADDR  19735 ; level 12
  .FARADDR  25351 ; level 13
  .FARADDR  31942 ; level 14
  .FARADDR  39586 ; level 15
  .FARADDR  48361 ; level 16
  .FARADDR  58345 ; level 17
  .FARADDR  69617 ; level 18
  .FARADDR  82253 ; level 19
  .FARADDR  96332 ; level 20
  .FARADDR 111932 ; level 21
  .FARADDR 129131 ; level 22
  .FARADDR 148008 ; level 23
  .FARADDR 168639 ; level 24
  .FARADDR 191103 ; level 25
  .FARADDR 215479 ; level 26
  .FARADDR 241843 ; level 27
  .FARADDR 270275 ; level 28
  .FARADDR 300851 ; level 29
  .FARADDR 333651 ; level 30
  .FARADDR 366450 ; level 31
  .FARADDR 399250 ; level 32
  .FARADDR 432049 ; level 33
  .FARADDR 464849 ; level 34
  .FARADDR 497648 ; level 35
  .FARADDR 530448 ; level 36
  .FARADDR 563247 ; level 37
  .FARADDR 596047 ; level 38
  .FARADDR 628846 ; level 39
  .FARADDR 661646 ; level 40
  .FARADDR 694445 ; level 41
  .FARADDR 727245 ; level 42
  .FARADDR 760044 ; level 43
  .FARADDR 792844 ; level 44
  .FARADDR 825643 ; level 45
  .FARADDR 858443 ; level 46
  .FARADDR 891242 ; level 47
  .FARADDR 924042 ; level 48
  .FARADDR 956841 ; level 49
  .FARADDR 989641 ; level 50

  ;; in hex, it would look like this:
  ;.byte $00,$00,$28 ; level 2
  ;.byte #00,$00,$C4 ; level 3
  ;.byte #00,$02,$23 ; level 4
  ;.byte #00,$04,$93 ; level 5
  ;.byte #00,$08,$62 ; level 6
  
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Level up data!  [$9094 :: 0x2D0A4]
;;
;;  Data consists of 2 bytes per level.
;;  49 levels per class
;;   6 classes (promoted classes share their unpromoted data)
;;
;;  Byte 0:  bit 5:  set if level up is "strong" (extra 20-24 HP bonus)
;;           bit 4:  set for guaranteed Str increase
;;           bit 3:  set for guaranteed Agil increase
;;           bit 2:  set for guaranteed Int increase
;;           bit 1:  set for guaranteed Vit increase
;;           bit 0:  set for guaranteed Luck increase
;;
;;  Byte 1:  MP up.  Each bit corresponds to a level of spell.
;;            Ex:  bit 0 means you'll get a level 1 charge
;;                 bit 7 means you'll get a level 8 charge

data_LevelUpData_Raw:

;; ...still, I'd rather use FFHackster and just cut/paste the data into the .bin...

;; JIGS - alternate explanation of the bits: 1 means do the boost, 0 means nothing!
;; 7, 6, 5,  4,   3,    2,   1,   0    ::             7, 6, 5, 4, 3, 2, 1, 0
;; x, x, HP, Str, Agil, Int, Vit, Luck ;; Magic Level 8, 7, 6, 5, 4, 3, 2, 1 

data_LevelUpData_Class1: ;; Class 1 - Fighter
.byte %00111010, %00000000 ; Level 1 
.byte %00111011, %00000000 ; Level 2 
.byte %00111101, %00000000 ; Level 3 
.byte %00111010, %00000000 ; Level 4 
.byte %00111011, %00000000 ; Level 5 
.byte %00111101, %00000000 ; Level 6 
.byte %00111010, %00000000 ; Level 7 
.byte %00111011, %00000000 ; Level 8 
.byte %00111101, %00000000 ; Level 9 
.byte %00111010, %00000000 ; Level 10
.byte %00011011, %00000000 ; Level 11
.byte %00111101, %00000000 ; Level 12
.byte %00111010, %00000000 ; Level 13
.byte %00011011, %00000000 ; Level 14
.byte %00111101, %00000000 ; Level 15
.byte %00111010, %00000000 ; Level 16
.byte %00011011, %00000000 ; Level 17
.byte %00111101, %00000000 ; Level 18
.byte %00111010, %00000000 ; Level 19
.byte %00010011, %00000000 ; Level 20
.byte %00111101, %00000000 ; Level 21
.byte %00111010, %00000000 ; Level 22
.byte %00010011, %00000000 ; Level 23
.byte %00011101, %00000000 ; Level 24
.byte %00111010, %00000000 ; Level 25
.byte %00010011, %00000000 ; Level 26
.byte %00011101, %00000000 ; Level 27
.byte %00111010, %00000000 ; Level 28
.byte %00010011, %00000000 ; Level 29
.byte %00011101, %00000000 ; Level 30
.byte %00110010, %00000000 ; Level 31
.byte %00011001, %00000000 ; Level 32
.byte %00010110, %00000000 ; Level 33
.byte %00111001, %00000000 ; Level 34
.byte %00010010, %00000000 ; Level 35
.byte %00011101, %00000000 ; Level 36
.byte %00110010, %00000000 ; Level 37
.byte %00011001, %00000000 ; Level 38
.byte %00010110, %00000000 ; Level 39
.byte %00111000, %00000000 ; Level 40
.byte %00010000, %00000000 ; Level 41
.byte %00011100, %00000000 ; Level 42
.byte %00110000, %00000000 ; Level 43
.byte %00011000, %00000000 ; Level 44
.byte %00010000, %00000000 ; Level 45
.byte %00111000, %00000000 ; Level 46
.byte %00010000, %00000000 ; Level 47
.byte %00011000, %00000000 ; Level 48
.byte %00110000, %00000000 ; Level 49

;; 27 HP
;; 49 Strength
;; 35 Agililty
;; 14 Intelligence
;; 25 Vitality
;; 24 Speed

;; Class 2 - Thief
data_LevelUpData_Class2:
.byte %00111001, %00000000 ; Level 1 
.byte %00110111, %00000000 ; Level 2 
.byte %00111001, %00000000 ; Level 3 
.byte %00110101, %00000000 ; Level 4 
.byte %00011011, %00000000 ; Level 5 
.byte %00110101, %00000000 ; Level 6 
.byte %00011001, %00000000 ; Level 7 
.byte %00110011, %00000000 ; Level 8 
.byte %00011101, %00000000 ; Level 9 
.byte %00100001, %00000000 ; Level 10
.byte %00011011, %00000000 ; Level 11
.byte %00110101, %00000000 ; Level 12
.byte %00001001, %00000000 ; Level 13
.byte %00110011, %00000000 ; Level 14
.byte %00011101, %00000000 ; Level 15
.byte %00001001, %00000000 ; Level 16
.byte %00110011, %00000000 ; Level 17
.byte %00011101, %00000000 ; Level 18
.byte %00001001, %00000000 ; Level 19
.byte %00110011, %00000000 ; Level 20
.byte %00011101, %00000000 ; Level 21
.byte %00001001, %00000000 ; Level 22
.byte %00110011, %00000000 ; Level 23
.byte %00011101, %00000000 ; Level 24
.byte %00001001, %00000000 ; Level 25
.byte %00110011, %00000000 ; Level 26
.byte %00011101, %00000000 ; Level 27
.byte %00001001, %00000000 ; Level 28
.byte %00100011, %00000000 ; Level 29
.byte %00011101, %00000000 ; Level 30
.byte %00001001, %00000000 ; Level 31
.byte %00111011, %00000000 ; Level 32
.byte %00011101, %00000000 ; Level 33
.byte %00001001, %00000000 ; Level 34
.byte %00011011, %00000000 ; Level 35
.byte %00111101, %00000000 ; Level 36
.byte %00001001, %00000000 ; Level 37
.byte %00011011, %00000000 ; Level 38
.byte %00011101, %00000000 ; Level 39
.byte %00101001, %00000000 ; Level 40
.byte %00010011, %00000000 ; Level 41
.byte %00001101, %00000000 ; Level 42
.byte %00010001, %00000000 ; Level 43
.byte %00001011, %00000000 ; Level 44
.byte %00110101, %00000000 ; Level 45
.byte %00001001, %00000000 ; Level 46
.byte %00010011, %00000000 ; Level 47
.byte %00001101, %00000000 ; Level 48
.byte %00010001, %00000000 ; Level 49

;; 18 HP
;; 33 Strength
;; 32 Agililty
;; 17 Intelligence
;; 16 Vitality
;; 49 Speed

;; Class 3 - Black Belt
data_LevelUpData_Class3:
.byte %00101011, %00000000 ; Level 1 
.byte %00010111, %00000000 ; Level 2 
.byte %00101010, %00000000 ; Level 3 
.byte %00010111, %00000000 ; Level 4 
.byte %00001011, %00000000 ; Level 5 
.byte %00110110, %00000000 ; Level 6 
.byte %00001011, %00000000 ; Level 7 
.byte %00010111, %00000000 ; Level 8 
.byte %00101010, %00000000 ; Level 9 
.byte %00010111, %00000000 ; Level 10
.byte %00001011, %00000000 ; Level 11
.byte %00110110, %00000000 ; Level 12
.byte %00001011, %00000000 ; Level 13
.byte %00010111, %00000000 ; Level 14
.byte %00101010, %00000000 ; Level 15
.byte %00110111, %00000000 ; Level 16
.byte %00001011, %00000000 ; Level 17
.byte %00110110, %00000000 ; Level 18
.byte %00001011, %00000000 ; Level 19
.byte %00010111, %00000000 ; Level 20
.byte %00101010, %00000000 ; Level 21
.byte %00010111, %00000000 ; Level 22
.byte %00001011, %00000000 ; Level 23
.byte %00110110, %00000000 ; Level 24
.byte %00001011, %00000000 ; Level 25
.byte %00010111, %00000000 ; Level 26
.byte %00101010, %00000000 ; Level 27
.byte %00010111, %00000000 ; Level 28
.byte %00001011, %00000000 ; Level 29
.byte %00110110, %00000000 ; Level 30
.byte %00101011, %00000000 ; Level 31
.byte %00010111, %00000000 ; Level 32
.byte %00101010, %00000000 ; Level 33
.byte %00010111, %00000000 ; Level 34
.byte %00001011, %00000000 ; Level 35
.byte %00110110, %00000000 ; Level 36
.byte %00001011, %00000000 ; Level 37
.byte %00010111, %00000000 ; Level 38
.byte %00101010, %00000000 ; Level 39
.byte %00010111, %00000000 ; Level 40
.byte %00001011, %00000000 ; Level 41
.byte %00110110, %00000000 ; Level 42
.byte %00001010, %00000000 ; Level 43
.byte %00010111, %00000000 ; Level 44
.byte %00101010, %00000000 ; Level 45
.byte %00110110, %00000000 ; Level 46
.byte %00001011, %00000000 ; Level 47
.byte %00110110, %00000000 ; Level 48
.byte %00001010, %00000000 ; Level 49

;; 20 HP
;; 24 Strength
;; 25 Agililty
;; 24 Intelligence
;; 49 Vitality
;; 30 Speed

;;Class 4 - Red Mage
data_LevelUpData_Class4:
.byte %00110011, %00000011 ; Level 1 
.byte %00001110, %00000010 ; Level 2 
.byte %00110011, %00000001 ; Level 3 
.byte %00001110, %00000010 ; Level 4 
.byte %00110011, %00000100 ; Level 5 
.byte %00001100, %00000101 ; Level 6 
.byte %00110011, %00000010 ; Level 7 
.byte %00101100, %00000100 ; Level 8 
.byte %00110001, %00001001 ; Level 9 
.byte %00000110, %00001000 ; Level 10
.byte %00111001, %00000100 ; Level 11
.byte %00000111, %00001010 ; Level 12
.byte %00110000, %00000001 ; Level 13
.byte %00001111, %00010000 ; Level 14
.byte %00110001, %00011100 ; Level 15
.byte %00100110, %00000010 ; Level 16
.byte %00011000, %00010000 ; Level 17
.byte %00000111, %00001000 ; Level 18
.byte %00010001, %00100100 ; Level 19
.byte %00001110, %00110001 ; Level 20
.byte %00010000, %00000001 ; Level 21
.byte %00000111, %00100000 ; Level 22
.byte %00011001, %00001010 ; Level 23
.byte %00000100, %00010000 ; Level 24
.byte %00010010, %01100000 ; Level 25
.byte %00101101, %01000100 ; Level 26
.byte %00010001, %00000010 ; Level 27
.byte %00000110, %01100000 ; Level 28
.byte %00011000, %00011000 ; Level 29
.byte %00000101, %10000000 ; Level 30
.byte %00010011, %11000100 ; Level 31
.byte %00001100, %00100000 ; Level 32
.byte %00010000, %10000000 ; Level 33
.byte %00000111, %01010000 ; Level 34
.byte %00011001, %10000000 ; Level 35
.byte %00100100, %00001000 ; Level 36
.byte %00010010, %01000000 ; Level 37
.byte %00001101, %10000000 ; Level 38
.byte %00010001, %00100000 ; Level 39
.byte %00000110, %00000010 ; Level 40
.byte %00011000, %00010000 ; Level 41
.byte %00000101, %10000000 ; Level 42
.byte %00010011, %01000000 ; Level 43
.byte %00001100, %00000100 ; Level 44
.byte %00010000, %00100000 ; Level 45
.byte %00100111, %10000000 ; Level 46
.byte %00011001, %00001000 ; Level 47
.byte %00000100, %01000000 ; Level 48
.byte %00010010, %00010000 ; Level 49

;; 13 HP
;; 25 Strength
;; 17 Agililty
;; 24 Intelligence
;; 22 Vitality
;; 25 Speed
 
;;Class 5 - White Mage
data_LevelUpData_Class5:
.byte %00111101, %00000011 ; Level 1 
.byte %00011110, %00000010 ; Level 2 
.byte %00110101, %00000001 ; Level 3 
.byte %00001110, %00000110 ; Level 4 
.byte %00100101, %00000100 ; Level 5 
.byte %00010110, %00000001 ; Level 6 
.byte %00101101, %00001100 ; Level 7 
.byte %00000110, %00001010 ; Level 8 
.byte %00110101, %00000001 ; Level 9 
.byte %00001110, %00001100 ; Level 10
.byte %00100101, %00010000 ; Level 11
.byte %00010110, %00010010 ; Level 12
.byte %00101101, %00001001 ; Level 13
.byte %00000110, %00010100 ; Level 14
.byte %00010101, %00100000 ; Level 15
.byte %00101110, %00100010 ; Level 16
.byte %00000101, %00011000 ; Level 17
.byte %00010110, %00100001 ; Level 18
.byte %00101101, %01000100 ; Level 19
.byte %00000110, %01000000 ; Level 20
.byte %00010100, %00110000 ; Level 21
.byte %00001101, %01001000 ; Level 22
.byte %00100110, %00000011 ; Level 23
.byte %00010100, %10100000 ; Level 24
.byte %00001101, %11000000 ; Level 25
.byte %00000110, %00010100 ; Level 26
.byte %00110100, %10000010 ; Level 27
.byte %00001101, %01001000 ; Level 28
.byte %00000110, %10100000 ; Level 29
.byte %00010000, %00000100 ; Level 30
.byte %00101001, %00010000 ; Level 31
.byte %00000010, %10000000 ; Level 32
.byte %00010000, %01000000 ; Level 33
.byte %00001001, %00001000 ; Level 34
.byte %00000010, %00100000 ; Level 35
.byte %00110000, %10000000 ; Level 36
.byte %00001001, %00000010 ; Level 37
.byte %00000010, %01000000 ; Level 38
.byte %00010000, %00010000 ; Level 39
.byte %00001001, %10000000 ; Level 40
.byte %00100010, %00100000 ; Level 41
.byte %00010000, %00000100 ; Level 42
.byte %00001001, %01000000 ; Level 43
.byte %00000010, %10000000 ; Level 44
.byte %00010000, %00001000 ; Level 45
.byte %00101001, %00010000 ; Level 46
.byte %00000010, %00100000 ; Level 47
.byte %00010000, %01000000 ; Level 48
.byte %00001001, %10000000 ; Level 49

;; 15 HP
;; 18 Strength
;; 18 Agililty
;; 29 Intelligence
;; 19 Vitality
;; 20 Speed

;;Class 6 - Black Mage
data_LevelUpData_Class6:
.byte %00100100, %00000011 ; Level 1 
.byte %00001110, %00000010 ; Level 2 
.byte %00110101, %00000001 ; Level 3 
.byte %00000110, %00000110 ; Level 4 
.byte %00101101, %00000100 ; Level 5 
.byte %00010110, %00000001 ; Level 6 
.byte %00100101, %00001100 ; Level 7 
.byte %00001110, %00001010 ; Level 8 
.byte %00010101, %00000001 ; Level 9 
.byte %00100100, %00001100 ; Level 10
.byte %00001110, %00010000 ; Level 11
.byte %00010100, %00010010 ; Level 12
.byte %00100101, %00001001 ; Level 13
.byte %00001100, %00010100 ; Level 14
.byte %00010110, %00100000 ; Level 15
.byte %00000100, %00100010 ; Level 16
.byte %00101101, %00011000 ; Level 17
.byte %00010100, %00100001 ; Level 18
.byte %00000110, %01000100 ; Level 19
.byte %00001100, %01000000 ; Level 20
.byte %00110101, %00110000 ; Level 21
.byte %00000100, %01001000 ; Level 22
.byte %00001110, %00000011 ; Level 23
.byte %00010100, %10100000 ; Level 24
.byte %00100101, %11000000 ; Level 25
.byte %00001100, %00010100 ; Level 26
.byte %00010110, %10000010 ; Level 27
.byte %00000100, %01001000 ; Level 28
.byte %00101101, %10100000 ; Level 29
.byte %00010100, %00000100 ; Level 30
.byte %00000110, %00010000 ; Level 31
.byte %00001100, %10000000 ; Level 32
.byte %00010101, %01000000 ; Level 33
.byte %00100100, %00001000 ; Level 34
.byte %00001110, %00100000 ; Level 35
.byte %00010100, %10000000 ; Level 36
.byte %00000101, %00000010 ; Level 37
.byte %00001100, %01000000 ; Level 38
.byte %00010110, %00010000 ; Level 39
.byte %00100100, %10000000 ; Level 40
.byte %00000101, %00100000 ; Level 41
.byte %00000100, %00000100 ; Level 42
.byte %00000110, %01000000 ; Level 43
.byte %00000100, %10000000 ; Level 44
.byte %00000101, %00001000 ; Level 45
.byte %00000100, %00010000 ; Level 46
.byte %00000110, %00100000 ; Level 47
.byte %00000100, %01000000 ; Level 48
.byte %00000101, %10000000 ; Level 49

;; 12 HP
;; 13 Strength
;; 13 Agililty
;; 49 Intelligence
;; 14 Vitality
;; 14 Speed

;; Class 7 - Knight  
data_LevelUpData_Class7:
.byte %00111010, %00000000 ; Level 1 
.byte %00111011, %00000000 ; Level 2 
.byte %00111101, %00000000 ; Level 3 
.byte %00111010, %00000000 ; Level 4 
.byte %00111011, %00000000 ; Level 5 
.byte %00111101, %00000000 ; Level 6 
.byte %00111010, %00000000 ; Level 7 
.byte %00111011, %00000000 ; Level 8 
.byte %00111101, %00000000 ; Level 9 
.byte %00111010, %00000000 ; Level 10
.byte %00011011, %00000000 ; Level 11
.byte %00111101, %00000000 ; Level 12
.byte %00111010, %00000000 ; Level 13
.byte %00011011, %00000111 ; Level 14
.byte %00111101, %00000000 ; Level 15
.byte %00111010, %00000111 ; Level 16
.byte %00011011, %00000000 ; Level 17
.byte %00111101, %00000111 ; Level 18
.byte %00111010, %00000000 ; Level 19
.byte %00010011, %00000111 ; Level 20
.byte %00111101, %00000000 ; Level 21
.byte %00111010, %00000111 ; Level 22
.byte %00010011, %00000000 ; Level 23
.byte %00011101, %00000111 ; Level 24
.byte %00111010, %00000000 ; Level 25
.byte %00010011, %00000111 ; Level 26
.byte %00011101, %00000000 ; Level 27
.byte %00111010, %00000111 ; Level 28
.byte %00010011, %00000000 ; Level 29
.byte %00011101, %00000111 ; Level 30
.byte %00110010, %00000000 ; Level 31
.byte %00011001, %00000111 ; Level 32
.byte %00010110, %00000000 ; Level 33
.byte %00111001, %00000111 ; Level 34
.byte %00010010, %00000000 ; Level 35
.byte %00011101, %00000111 ; Level 36
.byte %00110010, %00000000 ; Level 37
.byte %00011001, %00000111 ; Level 38
.byte %00010110, %00000000 ; Level 39
.byte %00111000, %00000111 ; Level 40
.byte %00010000, %00000000 ; Level 41
.byte %00011100, %00000111 ; Level 42
.byte %00110000, %00000000 ; Level 43
.byte %00011000, %00000111 ; Level 44
.byte %00010000, %00000000 ; Level 45
.byte %00111000, %00000111 ; Level 46
.byte %00010000, %00000000 ; Level 47
.byte %00011000, %00000111 ; Level 48
.byte %00110000, %00000000 ; Level 49

;; Class 8 - Ninja
data_LevelUpData_Class8:
.byte %00111001, %00000000 ; Level 1 
.byte %00110111, %00000000 ; Level 2 
.byte %00111001, %00000000 ; Level 3 
.byte %00110101, %00000000 ; Level 4 
.byte %00011011, %00000000 ; Level 5 
.byte %00110101, %00000000 ; Level 6 
.byte %00011001, %00000000 ; Level 7 
.byte %00110011, %00000000 ; Level 8 
.byte %00011101, %00000000 ; Level 9 
.byte %00100001, %00000000 ; Level 10
.byte %00011011, %00000000 ; Level 11
.byte %00110101, %00000000 ; Level 12
.byte %00001001, %00000000 ; Level 13
.byte %00110011, %00001111 ; Level 14
.byte %00011101, %00000000 ; Level 15
.byte %00001001, %00001111 ; Level 16
.byte %00110011, %00000000 ; Level 17
.byte %00011101, %00001111 ; Level 18
.byte %00001001, %00000000 ; Level 19
.byte %00110011, %00001111 ; Level 20
.byte %00011101, %00000000 ; Level 21
.byte %00001001, %00001111 ; Level 22
.byte %00110011, %00000000 ; Level 23
.byte %00011101, %00001111 ; Level 24
.byte %00001001, %00000000 ; Level 25
.byte %00110011, %00001111 ; Level 26
.byte %00011101, %00000000 ; Level 27
.byte %00001001, %00001111 ; Level 28
.byte %00100011, %00000000 ; Level 29
.byte %00011101, %00001111 ; Level 30
.byte %00001001, %00000000 ; Level 31
.byte %00111011, %00001111 ; Level 32
.byte %00011101, %00000000 ; Level 33
.byte %00001001, %00001111 ; Level 34
.byte %00011011, %00000000 ; Level 35
.byte %00111101, %00001111 ; Level 36
.byte %00001001, %00000000 ; Level 37
.byte %00011011, %00001111 ; Level 38
.byte %00011101, %00000000 ; Level 39
.byte %00101001, %00001111 ; Level 40
.byte %00010011, %00000000 ; Level 41
.byte %00001101, %00001111 ; Level 42
.byte %00010001, %00000000 ; Level 43
.byte %00001011, %00001111 ; Level 44
.byte %00110101, %00000000 ; Level 45
.byte %00001001, %00001111 ; Level 46
.byte %00010011, %00000000 ; Level 47
.byte %00001101, %00001111 ; Level 48
.byte %00010001, %00000000 ; Level 49

;; Class 9 - Master
data_LevelUpData_Class9:
.byte %00101011, %00000000 ; Level 1 
.byte %00010111, %00000000 ; Level 2 
.byte %00101010, %00000000 ; Level 3 
.byte %00010111, %00000000 ; Level 4 
.byte %00001011, %00000000 ; Level 5 
.byte %00110110, %00000000 ; Level 6 
.byte %00001011, %00000000 ; Level 7 
.byte %00010111, %00000000 ; Level 8 
.byte %00101010, %00000000 ; Level 9 
.byte %00010111, %00000000 ; Level 10
.byte %00001011, %00000000 ; Level 11
.byte %00110110, %00000000 ; Level 12
.byte %00001011, %00000000 ; Level 13
.byte %00010111, %00000000 ; Level 14
.byte %00101010, %00000000 ; Level 15
.byte %00110111, %00000000 ; Level 16
.byte %00001011, %00000000 ; Level 17
.byte %00110110, %00000000 ; Level 18
.byte %00001011, %00000000 ; Level 19
.byte %00010111, %00000000 ; Level 20
.byte %00101010, %00000000 ; Level 21
.byte %00010111, %00000000 ; Level 22
.byte %00001011, %00000000 ; Level 23
.byte %00110110, %00000000 ; Level 24
.byte %00001011, %00000000 ; Level 25
.byte %00010111, %00000000 ; Level 26
.byte %00101010, %00000000 ; Level 27
.byte %00010111, %00000000 ; Level 28
.byte %00001011, %00000000 ; Level 29
.byte %00110110, %00000000 ; Level 30
.byte %00101011, %00000000 ; Level 31
.byte %00010111, %00000000 ; Level 32
.byte %00101010, %00000000 ; Level 33
.byte %00010111, %00000000 ; Level 34
.byte %00001011, %00000000 ; Level 35
.byte %00110110, %00000000 ; Level 36
.byte %00001011, %00000000 ; Level 37
.byte %00010111, %00000000 ; Level 38
.byte %00101010, %00000000 ; Level 39
.byte %00010111, %00000000 ; Level 40
.byte %00001011, %00000000 ; Level 41
.byte %00110110, %00000000 ; Level 42
.byte %00001010, %00000000 ; Level 43
.byte %00010111, %00000000 ; Level 44
.byte %00101010, %00000000 ; Level 45
.byte %00110110, %00000000 ; Level 46
.byte %00001011, %00000000 ; Level 47
.byte %00110110, %00000000 ; Level 48
.byte %00001010, %00000000 ; Level 49

;;Class 10 - Red Wizard 
data_LevelUpData_Class10:
.byte %00110011, %00000011 ; Level 1 
.byte %00001110, %00000010 ; Level 2 
.byte %00110011, %00000001 ; Level 3 
.byte %00001110, %00000010 ; Level 4 
.byte %00110011, %00000100 ; Level 5 
.byte %00001100, %00000101 ; Level 6 
.byte %00110011, %00000010 ; Level 7 
.byte %00101100, %00000100 ; Level 8 
.byte %00110001, %00001001 ; Level 9 
.byte %00000110, %00001000 ; Level 10
.byte %00111001, %00000100 ; Level 11
.byte %00000111, %00001010 ; Level 12
.byte %00110000, %00000001 ; Level 13
.byte %00001111, %00010000 ; Level 14
.byte %00110001, %00011100 ; Level 15
.byte %00100110, %00000010 ; Level 16
.byte %00011000, %00010000 ; Level 17
.byte %00000111, %00001000 ; Level 18
.byte %00010001, %00100100 ; Level 19
.byte %00001110, %00110001 ; Level 20
.byte %00010000, %00000001 ; Level 21
.byte %00000111, %00100000 ; Level 22
.byte %00011001, %00001010 ; Level 23
.byte %00000100, %00010000 ; Level 24
.byte %00010010, %01100000 ; Level 25
.byte %00101101, %01000100 ; Level 26
.byte %00010001, %00000010 ; Level 27
.byte %00000110, %01100000 ; Level 28
.byte %00011000, %00011000 ; Level 29
.byte %00000101, %10000000 ; Level 30
.byte %00010011, %11000100 ; Level 31
.byte %00001100, %00100000 ; Level 32
.byte %00010000, %10000000 ; Level 33
.byte %00000111, %01010000 ; Level 34
.byte %00011001, %10000000 ; Level 35
.byte %00100100, %00001000 ; Level 36
.byte %00010010, %01000000 ; Level 37
.byte %00001101, %10000000 ; Level 38
.byte %00010001, %00100000 ; Level 39
.byte %00000110, %00000010 ; Level 40
.byte %00011000, %00010000 ; Level 41
.byte %00000101, %10000000 ; Level 42
.byte %00010011, %01000000 ; Level 43
.byte %00001100, %00000100 ; Level 44
.byte %00010000, %00100000 ; Level 45
.byte %00100111, %10000000 ; Level 46
.byte %00011001, %00001000 ; Level 47
.byte %00000100, %01000000 ; Level 48
.byte %00010010, %00010000 ; Level 49
 
;;Class 11 - White Wizard
data_LevelUpData_Class11:
.byte %00111101, %00000011 ; Level 1 
.byte %00011110, %00000010 ; Level 2 
.byte %00110101, %00000001 ; Level 3 
.byte %00001110, %00000110 ; Level 4 
.byte %00100101, %00000100 ; Level 5 
.byte %00010110, %00000001 ; Level 6 
.byte %00101101, %00001100 ; Level 7 
.byte %00000110, %00001010 ; Level 8 
.byte %00110101, %00000001 ; Level 9 
.byte %00001110, %00001100 ; Level 10
.byte %00100101, %00010000 ; Level 11
.byte %00010110, %00010010 ; Level 12
.byte %00101101, %00001001 ; Level 13
.byte %00000110, %00010100 ; Level 14
.byte %00010101, %00100000 ; Level 15
.byte %00101110, %00100010 ; Level 16
.byte %00000101, %00011000 ; Level 17
.byte %00010110, %00100001 ; Level 18
.byte %00101101, %01000100 ; Level 19
.byte %00000110, %01000000 ; Level 20
.byte %00010100, %00110000 ; Level 21
.byte %00001101, %01001000 ; Level 22
.byte %00100110, %00000011 ; Level 23
.byte %00010100, %10100000 ; Level 24
.byte %00001101, %11000000 ; Level 25
.byte %00000110, %00010100 ; Level 26
.byte %00110100, %10000010 ; Level 27
.byte %00001101, %01001000 ; Level 28
.byte %00000110, %10100000 ; Level 29
.byte %00010000, %00000100 ; Level 30
.byte %00101001, %00010000 ; Level 31
.byte %00000010, %10000000 ; Level 32
.byte %00010000, %01000000 ; Level 33
.byte %00001001, %00001000 ; Level 34
.byte %00000010, %00100000 ; Level 35
.byte %00110000, %10000000 ; Level 36
.byte %00001001, %00000010 ; Level 37
.byte %00000010, %01000000 ; Level 38
.byte %00010000, %00010000 ; Level 39
.byte %00001001, %10000000 ; Level 40
.byte %00100010, %00100000 ; Level 41
.byte %00010000, %00000100 ; Level 42
.byte %00001001, %01000000 ; Level 43
.byte %00000010, %10000000 ; Level 44
.byte %00010000, %00001000 ; Level 45
.byte %00101001, %00010000 ; Level 46
.byte %00000010, %00100000 ; Level 47
.byte %00010000, %01000000 ; Level 48
.byte %00001001, %10000000 ; Level 49

;;Class 12 - Black Wizard
data_LevelUpData_Class12:
.byte %00100100, %00000011 ; Level 1 
.byte %00001110, %00000010 ; Level 2 
.byte %00110101, %00000001 ; Level 3 
.byte %00000110, %00000110 ; Level 4 
.byte %00101101, %00000100 ; Level 5 
.byte %00010110, %00000001 ; Level 6 
.byte %00100101, %00001100 ; Level 7 
.byte %00001110, %00001010 ; Level 8 
.byte %00010101, %00000001 ; Level 9 
.byte %00100100, %00001100 ; Level 10
.byte %00001110, %00010000 ; Level 11
.byte %00010100, %00010010 ; Level 12
.byte %00100101, %00001001 ; Level 13
.byte %00001100, %00010100 ; Level 14
.byte %00010110, %00100000 ; Level 15
.byte %00000100, %00100010 ; Level 16
.byte %00101101, %00011000 ; Level 17
.byte %00010100, %00100001 ; Level 18
.byte %00000110, %01000100 ; Level 19
.byte %00001100, %01000000 ; Level 20
.byte %00110101, %00110000 ; Level 21
.byte %00000100, %01001000 ; Level 22
.byte %00001110, %00000011 ; Level 23
.byte %00010100, %10100000 ; Level 24
.byte %00100101, %11000000 ; Level 25
.byte %00001100, %00010100 ; Level 26
.byte %00010110, %10000010 ; Level 27
.byte %00000100, %01001000 ; Level 28
.byte %00101101, %10100000 ; Level 29
.byte %00010100, %00000100 ; Level 30
.byte %00000110, %00010000 ; Level 31
.byte %00001100, %10000000 ; Level 32
.byte %00010101, %01000000 ; Level 33
.byte %00100100, %00001000 ; Level 34
.byte %00001110, %00100000 ; Level 35
.byte %00010100, %10000000 ; Level 36
.byte %00000101, %00000010 ; Level 37
.byte %00001100, %01000000 ; Level 38
.byte %00010110, %00010000 ; Level 39
.byte %00100100, %10000000 ; Level 40
.byte %00000101, %00100000 ; Level 41
.byte %00000100, %00000100 ; Level 42
.byte %00000110, %01000000 ; Level 43
.byte %00000100, %10000000 ; Level 44
.byte %00000101, %00001000 ; Level 45
.byte %00000100, %00010000 ; Level 46
.byte %00000110, %00100000 ; Level 47
.byte %00000100, %01000000 ; Level 48
.byte %00000101, %10000000 ; Level 49
   

   
 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;  Fiend TSA data  [$92E0 :: 0x2D2F0]
;;
;;    $50 bytes of TSA for all 4 fiend graphics (resulting in $140 bytes of data total)
;;      $40 bytes of NT TSA (8x8 image)
;;      $10 bytes of attributes  (4x4)
data_FiendTSA:
  
.byte $00,$12,$13,$14,$15,$16,$17,$18,$19,$1A,$1B,$1C,$1D,$1E,$1F,$00
.byte $20,$21,$22,$23,$24,$25,$26,$27,$28,$29,$2A,$2B,$2C,$2D,$2E,$2F
.byte $30,$31,$32,$33,$34,$35,$36,$00,$37,$38,$39,$3A,$3B,$3C,$3D,$00
.byte $00,$00,$3E,$3F,$40,$41,$42,$00,$00,$00,$00,$43,$44,$45,$46,$00

.byte $30,$00,$00,$00
.byte $33,$99,$65,$00 ; Lich attributes
.byte $33,$55,$55,$00
.byte $F3,$F0,$F0,$F0

.byte $00,$00,$47,$48,$49,$4A,$4B,$00,$00,$00,$4C,$4D,$4E,$4F,$50,$51
.byte $00,$00,$52,$53,$54,$55,$56,$57,$00,$00,$59,$5A,$5B,$5C,$5D,$5E
.byte $00,$00,$60,$61,$62,$63,$64,$65,$00,$00,$66,$67,$68,$69,$6A,$6B
.byte $00,$00,$6D,$6E,$6F,$70,$71,$72,$00,$00,$73,$74,$75,$76,$77,$78

.byte $30,$00,$00,$00
.byte $33,$44,$56,$00 ; Kary attributes?
.byte $33,$44,$55,$00
.byte $F3,$F0,$F0,$F0

.byte $00,$00,$12,$13,$14,$15,$00,$00,$00,$16,$17,$18,$19,$1A,$1B,$00
.byte $00,$1C,$1D,$1E,$1F,$20,$21,$22,$00,$23,$24,$25,$26,$27,$28,$29
.byte $00,$2A,$2B,$2C,$2D,$2E,$2F,$30,$31,$32,$33,$34,$35,$36,$37,$38
.byte $00,$39,$3A,$3B,$3C,$3D,$3E,$3F,$00,$40,$41,$42,$43,$44,$45,$00

.byte $30,$00,$00,$00
.byte $33,$AA,$AA,$00 ; Kraken attributes?
.byte $33,$55,$59,$00
.byte $F3,$F0,$F0,$F0

.byte $00,$00,$00,$46,$47,$48,$00,$00,$49,$4A,$4B,$4C,$4D,$4E,$4F,$00
.byte $50,$51,$52,$53,$54,$55,$56,$00,$57,$58,$59,$5A,$5B,$5C,$5D,$00
.byte $5E,$5F,$60,$61,$62,$63,$64,$00,$65,$66,$67,$68,$69,$6A,$6B,$6C
.byte $00,$6D,$6E,$6F,$70,$71,$72,$73,$00,$74,$75,$76,$77,$78,$79,$00

.byte $30,$00,$00,$00
.byte $33,$59,$AA,$00 ; Tiamat attributes?
.byte $33,$55,$99,$00
.byte $F3,$F0,$F0,$F0  
  
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;  Fiend TSA data  [$9420 :: 0x2D430]
;;
;;    $C0 bytes of TSA for chaos
;;      $A8 bytes of NT TSA (14x12 image)
;;      $10 bytes of attributes  (4x4)
;;      $08 bytes of padding
data_ChaosTSA:
  
.byte $00,$00,$00,$12,$13,$00,$14,$15,$16,$17,$00,$00,$00,$00,$00,$00
.byte $18,$19,$1A,$1B,$1C,$1D,$1E,$1F,$20,$00,$00,$00,$00,$21,$22,$23
.byte $24,$25,$26,$27,$28,$29,$2A,$2B,$00,$00,$00,$2C,$2D,$2E,$2F,$30
.byte $31,$32,$33,$34,$35,$36,$37,$00,$38,$39,$3A,$3B,$3C,$3D,$3E,$3F
.byte $40,$41,$42,$43,$44,$00,$45,$46,$00,$47,$48,$49,$4A,$4B,$4C,$4D
.byte $4E,$4F,$50,$51,$52,$00,$00,$00,$53,$54,$55,$56,$57,$58,$00,$00
.byte $00,$59,$00,$00,$00,$00,$5A,$5B,$5C,$5D,$5E,$5F,$60,$00,$00,$00
.byte $00,$00,$00,$00,$61,$62,$63,$00,$64,$65,$66,$00,$00,$00,$00,$00
.byte $00,$67,$68,$69,$6A,$6B,$6C,$6D,$6E,$00,$00,$00,$00,$00,$00,$6F
.byte $70,$71,$00,$00,$00,$72,$73,$00,$00,$00,$00,$00,$00,$00,$00,$00
.byte $00,$00,$00,$00,$75,$00,$00,$00

.byte $B3,$A0,$90,$A0
.byte $BB,$AA,$AA,$AA ; attributes
.byte $77,$55,$56,$55
.byte $F7,$F5,$F5,$F5

;; padding
.byte $00,$00,$00,$00
.byte $00,$00,$00,$00  



  


  
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  LvlUp_AdjustBBSubStats  [$9966 :: 0x2D976]
;;
;;  Adjusts post level up substats for Black Belts / Masters
;;
;;  input:  lvlup_chstats should be prepped
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

LvlUp_AdjustBBSubStats:
    LDY #ch_class - ch_stats        ; check to make sure this is a BB/Master
    LDA (lvlup_chstats), Y
    AND #$0F                        ;; JIGS - cut off high bits (sprite)
    CMP #CLS_BB
    BEQ :+
    CMP #CLS_MA
    BEQ :+                          ; if yes, jump ahead, otherwise just exit
  @Exit:
    RTS

  : LDY #ch_righthand - ch_stats    ; see if they have any weapon equipped.
    LDA (lvlup_chstats), Y          ; check all 4 weapon slots, if any of them have an
    BEQ @Exit                       ; equipped weapon, exit
    
    LDY #ch_level - ch_stats        ; reaches here if no weapon equipped.  Get the level
    LDA (lvlup_chstats), Y          ;  Add 1 to make it 1-based
    CLC
    ADC #$01
    ASL A
    LDY #ch_damage - ch_stats          ; Damage = 2*Level
    STA (lvlup_chstats), Y
    
    ;JIGS - doing the armour thing properly?
    
    LDY #ch_head - ch_stats
    LDA (lvlup_chstats), Y 
    BEQ @Exit
    LDY #ch_body - ch_stats
    LDA (lvlup_chstats), Y 
    BEQ @Exit
    LDY #ch_hands - ch_stats
    LDA (lvlup_chstats), Y 
    BEQ @Exit
    LDY #ch_accessory - ch_stats
    LDA (lvlup_chstats), Y 
    BEQ @Exit
    
    LDY #ch_level - ch_stats        ; reaches here if no armor equipped.  Get the level
    LDA (lvlup_chstats), Y          ;  Add 1 to make it 1-based
    CLC
    ADC #$01
    ASL A
    LDY #ch_defense - ch_stats       
    STA (lvlup_chstats), Y 
    RTS
    
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  SubtractOneFromVal  [$9999 :: 0x2D9A9]
;;
;;  input:  $80 points to desired value
;;
;;    Subtracts 1 from the 1-byte value stored at the given pointer.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

SubtractOneFromVal:
    LDY #$00            ; self explanitory
    
    LDA ($80), Y
    SEC
    SBC #$01
    STA ($80), Y
    
    RTS
    
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  data_MaxRewardPlusOne  [$99A3 :: 0x2D9B3]
;;    note that this is actually 1 higher than the max for some reason...
;;  Also note this name is slightly misleading.  It's not the maximum reward, it's the
;;  maximum value you can have AFTER being rewarded.  Effectively it is the GP/XP cap.
    
data_MaxRewardPlusOne:
  .FARADDR 1000000          ; 'FARADDR' stores a 3-byte value  (even though this isn't an addr)
  
data_MaxHPPlusOne:          ; 99A6
  .WORD 1000                ; max HP + 1
  
  
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  DoCrossPageJump  [$99A8 :: 0x2D9B8]
;;
;;  input:
;;     A = ID of the routine to jump to on bank C
;;
;;    The given ID must be a multiple of 3 (0, 3, 6, 9, etc), as this jumps to a '_L' jump
;;  list on the bank.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

DoCrossPageJump:
    CLC
    ADC #<BankC_CrossBankJumpList
    STA btltmp+6
    LDA #$00
    ADC #>BankC_CrossBankJumpList
    STA btltmp+7
    LDA #$0C
    JMP BattleCrossPageJump_L


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  PrepBattleVarsAndEnterBattle  [$99B8 :: 0x2D9C8]
;;
;;  Does some battle setup stuff and eventually enters battle
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

PrepBattleVarsAndEnterBattle:
    JSR LongCall
    .word BackupMapMusic 
    .byte BANK_MUSIC
    
    LDA #$00
    STA btl_soft2000            ; clear soft PPU regs
    STA btl_soft2001
    
    STA CHAN_SQ2+ch_envptr
    STA CHAN_SQ2+ch_envptr+1
    
    STA ConfusedMagic          
    STA DrawPlayerHPCounter    ; make sure this is 0
   ; LDA #$50
   ; STA music_track           ; set music track and followup
   ; STA btl_followupmusic
    
    LDY BattleTextSpeed
    LDA lut_RespondDelay, Y     ; prep respond rate
    STA btl_responddelay
    
    LDA #<btlbox_blockdata      ; Prepare the block data pointer
    STA btldraw_blockptrstart
    STA btldraw_blockptrend
    LDA #>btlbox_blockdata
    STA btldraw_blockptrstart+1
    STA btldraw_blockptrend+1
    
    INC ch_level
    INC ch_level+$40
    INC ch_level+$80
    INC ch_level+$C0
    ;; JIGS - there was a lot of stupid stuff here, its gone now, nothing is broken.
  
    
    JSR PrepareEnemyFormation   ; build the enemy formation
    
    LDX dlgmusic_backup
    LDA BattleMusic_LUT, X
    STA music_track           ; set music track and followup
    STA btl_followupmusic
    
    LDA AutoTargetOption
    STA AutoTargetOptionBackup
    
    LDA #$06
    JMP DoCrossPageJump         ; jump to FinishBattlePrepAndFadeIn in bank C

  
BattleMusic_LUT:
 .byte $50, $50, $50, $59, $59, $5A, $5A, $5A ; 9 small, 4 large, mix, fiend, chaos, mixed miniboss, pirates, 4 big large minibosses 
    

;;;;  [$9A00 :: 0x2DA10]
PrepBattleVarsAndEnterBattle_L:     JMP PrepBattleVarsAndEnterBattle
BattleOver_ProcessResult_L:         JMP BattleOver_ProcessResult

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  GetJoyInput  [$9A06 :: 0x2DA16]
;;
;;  Joypad input is loaded into btl_input as well as A
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

GetJoyInput:
    LDY #$01            ; strobe controller
    STY $4016
    DEY
    STY $4016
    
    LDY #$08            ; Loop 8 times (for each button)
  @Loop:
      LDA $4016         ; get button input
      LSR A             ; shift bit 0 into C
      BCS :+            ; if clear.. shift bit 1 into C
        LSR A           ;   (this is to support detachable Famicom controllers which have button state in bit 1)
        
    : ROR btl_input     ; Roll C into btl_input
      DEY
      BNE @Loop         ; loop for all 8 buttons
      
    LDA btl_input       ; put input in A
    RTS                 ; and exit!
   
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  LUT for respond rate delay  [$9A22 :: 0x2DA32]
;;
;;  Translates the 0-based respond rate value as stored in the 'respondrate' variable,
;;      and translates it into a frame delay value
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    
lut_RespondDelay:
;    .BYTE   $78, $50, $3C, $2D, $1E, $0F, $05, $01
;; JIGS - making them a little less painfully slow...    
    .BYTE   $40, $30, $20, $18, $10, $0A, $05, $01

; 1 - 64 frames
; 2 - 48 frames 
; 3 - 32 frames
; 4 - 24 frames
; 5 - 16 frames
; 6 - 10 frames
; 7 - 5 frames
; 8 - 1 frame
   

    
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Shift6TAX   [$9A69 :: 2DA79]
;;
;;    Shifts A left by 6 (multiply by 64), then TAX
;;  This is commonly used to Convert a 0-based character ID to a usable index for looking
;;  up character stats.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

Shift6TAX:
    ASL A
    ASL A
    ASL A
    ASL A
    ASL A
    ASL A
    TAX
    RTS


  
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  BattleOver_ProcessResult  [$9AC0 :: 0x2DAD0]
;;
;;    Does all the end-of-battle stuff (except for cheering animation
;;  which is done in bank C)
;;
;;    At this point it is assumed btl_result is nonzero.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

BattleOver_ProcessResult:
    LDA #BANK_THIS              ; set callback bank for music
    STA cur_bank
    
     DEC ch_level
     DEC ch_level+$40
     DEC ch_level+$80
     DEC ch_level+$C0
     
     JSR RestoreCharacterBattleStats ;; put back the pre-battle stats that spells would have changed
     ;; JIGS - the game used to convert a lot of stuff here, but it was stupid, and now it only changes level from 1 based to 0 based
    
    LDA btl_result              ; check the result
    CMP #$03
    BEQ BattleOver_Run          ; did they run?
    CMP #$01
    BEQ GameOver                ; were they defeated?
    
    ; otherwise, they're victorious!
    ;  Note that the party has already done their cheering animation, and the fanfare
    ;  music is already playing.
    
    LDA btlformation      ; check the formation ID
    CMP #$7B                ; $7B is Chaos's formation
    BNE :+                  ; if we just killed Chaos....
      LDA #$FF                  ; set btl_result to $FF to create a dramatic pause after fadeout
      STA btl_result
      JSR ChaosDeath            ; do the fancy dissolve effect
      JMP ExitBattle            ; then exit battle
                                ;  (note that no GP/EXP is awarded for battle $7B)
    
  : JSR EndOfBattleWrapUp   ; otherwise (not Chaos), award Gp/Exp and stuff
    JMP ExitBattle          ; then exit battle
    
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  BattleOver_Run  [$9AEB :: 0x2DAFB]
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

BattleOver_Run:
    LDA battlesrun
    CMP #$FF
    BEQ :+
       INC battlesrun
    
  : JSR Battle_FlipAllChars         ; Flip all chars so they look like they're running away.
  ; JMP ExitBattle                  ; <- Flow into ExitBattle to return to the main game.
  
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  ExitBattle  [$9AEE :: 0x2DAFE]
;;
;;    Called when battle is over.  Fades out and does other end-of-battle stuff.
;;  Actually this routine just passes the buck to 'ExitBattle' in bank C.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

ExitBattle:
    PLA                         ; current return address is to BattleLogicLoop in bank C
    PLA                         ; drop that -- new return address is to whatever called EnterBattle.
    LDA #$00                    ;   That is... when this routine exits, it will return to whoever called EnterBattle
    JMP DoCrossPageJump         ; jump to ExitBattle_L in bank C

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  GameOver  [$9AF5 :: 0x2DB0E]
;;
;;    Called when the party has been defeated.  YOU LOSE MOFO!!!
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

GameOver:
    LDA #$52
    STA music_track           ; Play the sad "game over" music
    STA btl_followupmusic
    
    LDA #$00
    STA btl_boxcount          ; reset combat box count
    
    LDA #$04                    ; draw the "Party Perished" text
    LDX #$09                    ;  in combat box 4 (bottom/wide one)
    JSR DrawEOBCombatBox
    
    JSR WaitForAnyInput                     ; wait for user to press any button
    JSR RespondDelay_UndrawAllCombatBoxes   ; then undraw "Party Perished" box
    LDA #$03                    ; Fade out, and restart the game
    JMP DoCrossPageJump         ; jump to BattleFadeOutAndRestartGame_L

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  EndOfBattleWrapUp  [$9B14 :: 0x2DB24]
;;
;;    Gives GP/Exp rewards for a victorious battle, levels up
;;  characters when appropriate, and displays all the necessary crap
;;  on screen
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

EndOfBattleWrapUp:
    LDA #$00
    STA btl_boxcount          ; clear combat box count
    
    TAX
    LDA #$04
    JSR DrawEOBCombatBox            ; draw "mosters perished" in combat box 4
    
    JSR WaitForAnyInput                     ; wait for the user to press any button
    JSR RespondDelay_UndrawAllCombatBoxes   ; then delay and undraw all boxes
        
    LDY #en_exp                 ; get the EXP reward for this battle
    JSR SumBattleRewardEXP
    JSR DivideRewardBySurvivors ; divide that reward by the number of surviving players
    
    LDA battlereward
    STA eob_exp_reward
    LDA battlereward+1          ; store reward in eob_exp_reward
    STA eob_exp_reward+1
    
    ORA battlereward            ; OR high/low bytes to see if reward was zero
    BNE :+                      ; if it was...
      INC eob_exp_reward        ;   ... inc it.  Minimum of 1 EXP for reward.
      
  : LDY #en_gp                  ; get the GP reward and store it in eob_gp_reward for it to be printed
    JSR SumBattleRewardGP         ; this is *kind of* bugged, as the game will properly award a 3-byte
    LDA battlereward            ;   GP value, but only 2 bytes will be printed.  So if you somehow
    STA eob_gp_reward           ;   receive over $FFFF GP in a single battle, it will be awarded properly,
    LDA battlereward+1          ;   but the reward will not be printed correctly.  But... this isn't really
    STA eob_gp_reward+1         ;   a bug as much as it's just a limitation.
    
    LDA #<gold
    STA $80
    LDA #>gold
    STA $81
    
    JSR GiveRewardToParty
    
    LDA #$00                    ; Draw 4 EoB boxes.
    STA eobbox_slotid           ;  Exp Up  |  ####P
    LDA #$01                    ;  Gold    |  ####G
    STA eobbox_textid
    JSR Draw4EobBoxes
    
    JSR WaitForAnyInput                         ; wait for input
    JSR RespondDelay_UndrawAllCombatBoxes       ; then delay, and undraw
    
    LDA #$00                    ; award XP to all 4 party members
    ;JSR LvlUp_AwardAndUpdateExp
    JSR LvlUp_AwardExp
    LDA #$01
    ;JSR LvlUp_AwardAndUpdateExp
    JSR LvlUp_AwardExp
    LDA #$02
    ;JSR LvlUp_AwardAndUpdateExp
    JSR LvlUp_AwardExp
    LDA #$03
    ;JMP LvlUp_AwardAndUpdateExp
    JMP LvlUp_AwardExp
    
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  LvlUp_AwardAndUpdateExp  [$9B7F :: 0x2DB8F]
;;
;;  input:  A = character index whose XP to update
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;LvlUp_AwardAndUpdateExp:

PrintEXPToNext_B:

;    JSR LvlUp_AwardExp          ; award exp to this player
    LDA char_index
    LSR A
    LSR A
    LSR A
    LSR A
    LSR A
    
    ;ASL A
    TAY
    
    LDA lut_CharStatsPtrTable, Y    ; get their stat pointer
    STA lvlup_chstats
    LDA lut_CharStatsPtrTable+1, Y
    STA lvlup_chstats+1
        
    ; Now that XP is updated, update the 'ch_exptonext' stat
    JSR LvlUp_GetCharExp        ; get the Xp pointer
    JSR LvlUp_GetExpToAdvance   ; and Xp to advance pointer
    
    LDY #ch_level - ch_stats    ; see if they're at level 50
    LDA (lvlup_chstats), Y
    CMP #50 - 1                 ; (-1 because it's 0 based)
    BNE :+
      LDA #$00                  ; if at level 50, just set "0" for exptonext
      PHA               ; push low
      PHA               ; push high
      JMP @UpdateToAdvance
    
  : LDX #$03                    ; if not level 50, subtract curexp from exptoadvance
    LDY #$00                    ;  and push the result (low byte first)
    SEC                         ; loop 3 times (3 bytes of data)
  @FindDifLoop:
      LDA (lvlup_exptoadv), Y
      SBC (lvlup_curexp), Y
      PHA
      INY
      DEX
      BNE @FindDifLoop
    PLA                         ; drop the highest byte (only 2 bytes stored in exptonext)
    
   @UpdateToAdvance:
    PLA                         ; pull high byte
    STA tmp+1 ; LongCall_tmp+1                   ; write it
    PLA                         ; pull low byte
    STA tmp ; LongCall_tmp                     ; write it
    LDA #00
    STA tmp+2
    RTS
    
    
;  @UpdateToAdvance:
;    LDY #ch_exptonext - ch_stats + 1
;    PLA                         ; pull high byte
;    STA ($86), Y                ; write it
;    DEY
;    PLA                         ; pull low byte
;    STA ($86), Y                ; write it
;    
;   RTS             ; Done!
;; JIGS - called from status menu now, exptonext is not saved in ch_stats
    
    
    
    
    
    
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  LvlUp_AwardExp  [$9BB0 :: 0x2DBC0]
;;
;;  input:  A = ID of character to reward
;;
;;  Gives Exp to a single party member, and levels them up (once) if necessary
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

LvlUp_AwardExp:
    ORA #$80                        ; set this char as the 'attacker'
    STA btl_attacker                ;  (this is used to print their name when they level up)
    
    ASL A
    TAY
    
    LDA lut_CharStatsPtrTable, Y    ; get their stat pointer
    STA lvlup_chstats
    LDA lut_CharStatsPtrTable+1, Y
    STA lvlup_chstats+1
     
    LDY #ch_ailments - ch_stats     ; check their ailments
    LDA ($86), Y
    AND #$03                        ; isolate bit 1 and 2 = dead and stone
    BEQ :+                          ; no ailments = reward
      RTS                           ; anything else (stone or dead) = exit without getting a reward
      
  : LDA eob_exp_reward              ; move the exp reward back into battlereward
    STA battlereward
    LDA eob_exp_reward+1
    STA battlereward+1
    
    JSR LvlUp_GetCharExp            ; get this char's exp pointer
    JSR GiveRewardToParty           ; add the exp reward to it
    
        ; <-- "jump here" point  (see end of LvlUp_LevelUp for explanation of this note)
    
    JSR LvlUp_GetExpToAdvance       ; Get exp to advance
    LDY #3 - 1                      ; compare 3 bytes (lvlup_curexp to lvlup_exptoadv)
    JSR MultiByteCmp
    
    BCS LvlUp_LevelUp               ; if curexp >= exptoadvance, LEVEL UP
    
  LvlUp_AwardExp_RTS:
    RTS                             ; otherwise, exit

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  LvlUp_GetCharExp  [$9BF3 :: 0x2DC03]
;;
;;  input:   lvlup_chstats
;;  output:  lvlup_curexp
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

LvlUp_GetCharExp:
    LDA lvlup_chstats                 ; self explanitory
    CLC
    ADC #ch_exp - ch_stats
    STA lvlup_curexp ; $80
    
    LDA #$00
    ADC lvlup_chstats+1
    STA lvlup_curexp+1 ; $81
    RTS
    
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  LvlUp_GetExpToAdvance  [$9C01 :: 0x2DC11]
;;
;;  input:   lvlup_chstats
;;  output:  lvlup_exptoadv = points to 3-byte value containing total Exp required to advance
;;
;;    Gives nonsense if character is at level 50
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

LvlUp_GetExpToAdvance:
    LDY #ch_level - ch_stats    ; get their level
    LDA (lvlup_chstats), Y
    ASL A
    CLC
    ADC (lvlup_chstats), Y                ; A = level*3
    
    ADC #<lut_ExpToAdvance      ; Add to address of exp LUT
    STA lvlup_exptoadv          ; $82
    
    LDA #$00
    ADC #>lut_ExpToAdvance
    STA lvlup_exptoadv+1        ; $83
    
    RTS
    
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  LvlUp_LevelUp  [$9C14 :: 0x2DC24]
;;
;;  input:   lvlup_curexp, lvlup_chmagic, and lvlup_chstats
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

LvlUp_LevelUp:
    LDY #ch_level - ch_stats        ; check to see if they're are the max level
    LDA (lvlup_chstats), Y          ; level 50 is max (-1 because OB level is stored 0-based
    CMP #50 - 1                     ;   so it'd actually be stored as 49)
    BEQ LvlUp_AwardExp_RTS          ; if at max level, branch to a nearby RTS

    
   ; LevelUp_LevelIndex         @levindex = $6BAD       ; local, stores the index to level up stats
   ; LevelUp_Pointer            @lvlupptr = $82         ; local, pointer to level up data
   ; LevelUp_ClassID            @classid  = $688E       ; local, stores class ID
            
    STA LevelUp_LevelIndex          ; record old level
    
    CLC                             ; add 1
    ADC #1
    STA (lvlup_chstats), Y          ; change actual player stat
    STA eobtext_print_level         ; and write to the print space in RAM so it can be drawn later
                                    ;  (note that this will need to be INC'd later since it is 0-based now
                                    ;   and we'd want to print it as 1-based)
    
    LDY #ch_class - ch_stats
    LDA (lvlup_chstats), Y
    AND #$0F                        ;; JIGS - cut off high bits (sprite)
    ASL A
    TAY                             ; put 2* class ID in Y (to use as index)
    
    ASL LevelUp_LevelIndex              ; double level index (2 bytes of data per level per class)
    
    LDA lut_LevelUpDataPtrs, Y      ; calc the pointer to the level up data for this level for
    CLC                             ;   this class.
    ADC LevelUp_LevelIndex
    STA LevelUp_Pointer
    LDA lut_LevelUpDataPtrs+1, Y
    ADC #$00
    STA LevelUp_Pointer+1                 ; @lvlupptr now points to the 2-byte level up data to use
    
    LDA #$00
    STA eobtext_print_level+1       ; clear high-byte of print level
    INC eobtext_print_level         ; convert print level to 1-based (it is now OK to print)
    
    LDX #$00
    LDA (lvlup_chstats, X)          ; get the first byte of chstats (happens to be class ID)
    AND #$0F                        ;; JIGS - cut off high bits again 
    STA LevelUp_ClassID                    ; store class ID 
    TAX                             ; and throw it in X to use as index
    
    ;;---- start assigning bonuses
    LDY #ch_hitrate - ch_stats      ; assign Hit Rate bonus
    LDA (lvlup_chstats), Y
    CLC
    ADC lut_LvlUpHitRateBonus, X
    JSR CapAAt200                   ; cap hit rate at 200
    STA (lvlup_chstats), Y
    
    LDY #ch_magicdefense - ch_stats       ; assign Magic Defense bonus
    LDA (lvlup_chstats), Y
    CLC
    ADC lut_LvlUpMagDefBonus, X
    JSR CapAAt200                   ; cap at 200
    STA (lvlup_chstats), Y
    
    ;;---- increase spell charges!
    
    ;; JIGS - edited to use ch_stats and for current and max MP being in the same byte
    
   ; LDA LevelUp_ClassID
   ; BEQ @SkipMPGain                 ; skip MP increase for Fighters (class 0)
   ; CMP #CLS_TH                     ; and thieves.  This is necessary because
   ; BEQ @SkipMPGain                 ; Knights/Ninjas get magic, and they share the same data.
   ;; JIGS - they do not share the same data now
    
    LDY #$01
    LDA (LevelUp_Pointer), Y              ; get leveldata[1] byte (MP gains)
    LDY #ch_mp - ch_stats           ; set Y to index max MP
   @MagicUpLoop:
      LSR A                         ; shift out low bit
      BCC :+                        ; if set...
        PHA
        LDA (lvlup_chstats), Y        ; increase max MP for this level by 1
        CLC
        ADC #$01
        STA (lvlup_chstats), Y
        PLA
    : INY                               ; INY to look at next spell level
      CPY #ch_mp - ch_stats + 8  ; loop for all 8 bits (and all 8 spell levels)
      BNE @MagicUpLoop
    
    ;;---- Cap spell charges at a maximum
    LDA LevelUp_ClassID            ; check the class
    CMP #CLS_KN
    BEQ :+
    CMP #CLS_NJ
    BEQ :+                  ; Knights/Ninjas cap at 4 MP
        LDA #9+1            ;  all other classes cap at 9 MP
        BNE :++
  : LDA #4+1                ;(KN/NJ jumps here)
  
    ;  At this point, A = max_charges+1
  : LDY #ch_mp - ch_stats           ; similar loop as above
    STA MMC5_tmp
  @MagicCapLoop:
      LDA (lvlup_chstats), Y   ; MP byte
      AND #$0F                 ; destroy high bit (current mp)
      CMP MMC5_tmp             ; see if MP max is == one beyond max
      BCC :+                                ; if it is...
        LDA (lvlup_chstats), Y              ; ... decrease it by one to cap it
        SEC
        SBC #$01
        STA (lvlup_chstats), Y
    : INY                                   ; repeat for all 8 spell levels
      CPY #ch_mp - ch_stats + 8
      BNE @MagicCapLoop
     
    ;; JIGS - hopefully that sorts it out. 

  
  @SkipMPGain:      ; jumps here for fighters/thieves (prevent them from getting MP)
    
    ;;---- Record stat byte
                ;@statbyte = $688E   ; local, the stat gains byte from the level up data
    LDY #$00
    LDA (LevelUp_Pointer), Y              ; get leveldata[0] byte (other stat gains)
    STA LevelUp_StatByte                   ; record it!
    
    ;;---- HP gain
    LDY #ch_vitality - ch_stats  ; Base HP gain depends on vitality
    LDA (lvlup_chstats), Y
    LSR A
    LSR A
    CLC
    ADC #$01                ; Vit/4 + 1
    PHA                     ;  (push it for later)
    
    LDA LevelUp_StatByte           ; check the stat byte
    AND #$20                ; see if the "strong" bit is set
    BEQ :+                  ; if this is a strong level....
      LDA #20               ;   get an additional HP bonus of rand[20,25]
      LDX #25
      JSR RandAX
      JMP :++
  : LDA #$00                ; for non-strong levels, no extra bonus
  
  : STA btltmp_multA               ; store strong bonus in scratch ram
    PLA                     ; pull base HP gain
    CLC
    ADC btltmp_multA               ; add with strong bonus
    STA battlereward        ; record HP bonus as battle reward
    LDA #$00
    STA battlereward+1      ; (zero high byte of battle reward)
    STA battlereward+2
    
    LDA lvlup_chstats       ; set $80 to point to character's Max HP
    CLC
    ADC #ch_maxhp - ch_stats
    STA $80
    LDA lvlup_chstats+1
    ADC #$00
    STA $81
    
    JSR GiveHpBonusToChar   ; Finally, apply the HP bonus!
    
    ;;---- other stat gains (str/vit/etc)
    ; LevelUp_LoopCounter              @loopctr = $6856 
    ; LevelUp_StatIndex                @statidx = $6858 
    ; LevelUp_StatBuffer               @statupbuffer = $6AAC ; 5 bytes indicating which stats have been incrased 
                
    ASL LevelUp_StatByte               ; drop the high 3 bits of the stat byte, other bits
    ASL LevelUp_StatByte              ;   will be shifted out the high end
    ASL LevelUp_StatByte
    
    LDA #$00                    ; zero our loop counter
    STA LevelUp_LoopCounter
    LDA #ch_strength - ch_stats      ; and initialize our stat index 
    STA LevelUp_StatIndex
    
    ; Loop 5 times, possibly increasing each of the base stats
  @StatUpLoop:
      ASL LevelUp_StatByte             ; shift out the high bit of the stat byte
      BCC @StatUpRandomChance   ; if clear, stat has a random chance of increase

    @IncreaseStat:              ; if set, stat has a guaranteed increase
      LDA #$01                  ;   increase by 1
      BNE @ApplyStatBonus       ;   (always branch)
    
    @StatUpRandomChance:        ; stat byte was clear
      JSR BattleRNG_L           ; get a random number
      AND #$03
      BEQ @IncreaseStat         ; 25% chance of increase
      LDA #$00                  ; otherwise, no increase (or rather, increase by 0)
    
    @ApplyStatBonus:
      STA tmp
      ;LDY LevelUp_LoopCounter              ; record stat increase in this statup buffer
      ;STA LevelUp_StatBuffer, Y      ;   so that this can be reported back to the user later
      
      LDY LevelUp_StatIndex
      CLC
      ADC (lvlup_chstats), Y    ; add bonus to stat
      CMP #100
      BEQ :+                    ; but only apply it if < 100
        STA (lvlup_chstats), Y
      
      ;; JIGS - fixing the bug mentioned below?
    : LDA tmp
      LDY LevelUp_LoopCounter              ; record stat increase in this statup buffer
      STA LevelUp_StatBuffer, Y      ;   so that this can be reported back to the user later
     
  ;  :     
      INC LevelUp_StatIndex              ; move to next stat
    
      INC LevelUp_LoopCounter              ; and loop until all 5 stats processed
      LDA LevelUp_LoopCounter
      CMP #$05
      BNE @StatUpLoop
    
    ; The above is slightly BUGGED -- if the stat was maxed out, it will not be increased, but
    ;  @statupbuffer will be set indicating it was, so misinformation will be reported to the player
    ;  when statupbuffer is printed below.
    
    ;;---- substat changes  (damage/absorb/etc)
    ;  So much of this below code is fishy.  There are ALL SORTS of edge cases where a stat might
    ; not be properly increased, or it might increase when it shouldn't.  It would be so much smarter
    ; to just recalculate substats from scratch -- rather than try to adjust them on-the-fly like this.
    ; This is undoubtedly BUGGED for edge cases, but I'm not going to point them all out.
    
    LDY #ch_strength - ch_stats      ; damage goes up 1 pt for each 2pts of strength
    LDA LevelUp_StatBuffer+0         ; so check to see if strength has gone up
    BEQ :+                      ; if yes...
      LDA (lvlup_chstats), Y
      LSR A
      BCS :+                    ; ...see if it went up to an even number
      LDY #ch_damage - ch_stats    ;    if yes, add 1 to damage stat
      LDA (lvlup_chstats), Y    ;    capping at 200
      CLC
      ADC #$01
      CMP #201
      BEQ :+
        STA (lvlup_chstats), Y
      
  : LDY #ch_evasion - ch_stats    ; evade goes up 1 if agility went up
    LDA LevelUp_StatBuffer+1
    BEQ :+                      ; did agility go up?
      LDA (lvlup_chstats), Y
      CLC
      ADC #$01
      CMP #201                  ; cap at 200
      BEQ :+
        STA (lvlup_chstats), Y
    
  : JSR LvlUp_AdjustBBSubStats  ; adjust dmg and absorb for BB/Masters
  
  
    ;;---- Display the actual ... display to indicate to the user that they levelled up
    
    LDA #$00                    ; draw 4 EOB Boxes:
    STA eobbox_slotid           ;   Level Up | <Name> L##
    LDA #$05                    ;   HP Max   | ### pts.
    STA eobbox_textid
    JSR Draw4EobBoxes
    
    ; Now we need to loop through all of the base stats (str/int/etc) and print
    ;  a "Str Up!" msg if that stat increased.
    
            @displayloopctr    = $6AA6  ;  eobbox_slotid  ; btlinput_prevstate  
            @displaymsgcode    = $6AA7  ;  eobbox_textid  ; inputdelaycounter 
            @displaybuffer     = $6AFA  ;  btl_unfmtcbtbox_buffer
    LDA #$00
    STA @displayloopctr             ; zero the loop counter
    LDA #BTLMSG_STR
    STA @displaymsgcode             ; start with msg code for 'Str'
    
  @DisplayLoop:
    LDY @displayloopctr
    LDA LevelUp_StatBuffer, Y            ; check to see if the stat increased
    
    BEQ @DisplayLoop_Next           ; if it didn't, skip ahead.  Otherwise...
    
      LDA #BTLMSG_UP                ; fill the display buffer with the following string:
      STA @displaybuffer+3          ; 0F <StatMsgCode> 0F <UpMsgCode> 00
      LDA #$0F                      ;  which of course will print "Str Up!" or "Int Up!"
      STA @displaybuffer+0
      STA @displaybuffer+2
      LDA @displaymsgcode
      STA @displaybuffer+1
      LDA #$00
      STA @displaybuffer+4
      
      LDA #BANK_THIS                ; set swap-back bank to this bank.
      STA cur_bank
      
      LDA #$04
      LDX #<@displaybuffer
      LDY #>@displaybuffer
      JSR DrawCombatBox_L           ; draw this string in combat box 4
      
      JSR RespondDelay              ; wait a bit for them to read it
      JSR WaitForAnyInput           ; wait a bit more for the user to press something
      
      LDA #$01
      JSR UndrawNBattleBlocks_L     ; then undraw the box we just drew
      
  @DisplayLoop_Next:
    INC @displaymsgcode             ; inc msg code to refer to next stat name
    INC @displayloopctr
    LDA @displayloopctr
    CMP #$05                        ; loop 5 times (for each stat)
    BNE @DisplayLoop
    
    ; The delay, undraw all boxes, and exit!
    JMP RespondDelay_UndrawAllCombatBoxes
    
    ;; BUGGED - If the character gains so much EXP that they should level up more than once,
    ;;   This code will only level them up the first time, and they'll have to complete another battle
    ;;   to level up again.
    ;;
    ;;   This is actually very easy to fix... instead of exiting this routine here... you could just
    ;; JMP back to the "jump here" point I marked in LvlUp_AwardExp.  That will keep checking for
    ;; and performing level ups until they're all done.

    ;; JIGS - I tried this and it kinda just got buggier. But that was also on a previous build 
    ;; where lots of different battle things I changed got buggier... So it might be safe now.
    
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Draw4EobBoxes  [$9DC5 :: 0x2DDD5]
;;
;;  input:  eobbox_slotid = expected to be zero  (why doesn't this routine just zero it?)
;;          eobbox_textid = EOB text ID to print in first box
;;
;;    This routine draws 4 EOB combat boxes with text eobbox_textid, eobbox_textid+1, eobbox_textid+2,
;;  and eobbox_textid+3.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

Draw4EobBoxes:
  LDA #0
  STA eobbox_slotid ;; JIGS - just in case

  @Loop:
      LDA eobbox_slotid         ; draw one EOB box
      LDX eobbox_textid
      JSR DrawEOBCombatBox
      
      INC eobbox_slotid         ; inc slot and text
      INC eobbox_textid
      LDA eobbox_slotid
      CMP #$04                  ; keep looping until all 4 slots drawn
      BNE @Loop
 
    RTS


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  lut - Hit rate bonus for each class (assigned at level up)  [$9DDC :: 0x2DDEC]

lut_LvlUpHitRateBonus:
  .BYTE  3,  2,  3,  2,  1,  1,   3,  2,  3,  2,  1,  1
  ;     FT  TH  BB  RM  WM  BM   KN  NJ  MA  RW  WW  BW
  
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  lut - Mag Def bonus for each class (assigned at level up)  [$9DE8 :: 0x2DDF8]
;;
;;    This is arguably BUGGED -- since MA gets penalized, and fighters get more magdef than
;;  fighters, which doesn't make any sense.  It's almost as if these should be inverted
;;  to be 5-their_value.
  
lut_LvlUpMagDefBonus:
  .BYTE  3,  2,  4,  2,  2,  2,   3,  2,  4,  2,  2,  2
  ;     FT  TH  BB  RM  WM  BM   KN  NJ  MA  RW  WW  BW
  ;; JIGS - keeping it 4 for Master. Mr. Fists can dodge magic better.
  
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  [$9DF4 :: 0x2DE04]
;;    Lut - pointer table to level up data for each class
;;  see data_LevelUpData_Raw for explanation of data format
  
lut_LevelUpDataPtrs:
.word data_LevelUpData_Class1
.word data_LevelUpData_Class2
.word data_LevelUpData_Class3
.word data_LevelUpData_Class4
.word data_LevelUpData_Class5
.word data_LevelUpData_Class6
.word data_LevelUpData_Class7
.word data_LevelUpData_Class8
.word data_LevelUpData_Class9
.word data_LevelUpData_Class10
.word data_LevelUpData_Class11
.word data_LevelUpData_Class12

;  .WORD data_LevelUpData_Raw + (49*2 * 0)      ; Fighter
;  .WORD data_LevelUpData_Raw + (49*2 * 1)      ; Thief
;  .WORD data_LevelUpData_Raw + (49*2 * 2)      ; BlBelt
;  .WORD data_LevelUpData_Raw + (49*2 * 3)      ; RedMage
;  .WORD data_LevelUpData_Raw + (49*2 * 4)      ; WhiteMage
;  .WORD data_LevelUpData_Raw + (49*2 * 5)      ; BlackMage
;;; JIGS - woo, now all 12 classes can be different!
;  .WORD data_LevelUpData_Raw + (49*2 * 6)      ; Knight
;  .WORD data_LevelUpData_Raw + (49*2 * 7)      ; Ninja
;  .WORD data_LevelUpData_Raw + (49*2 * 8)      ; Master
;  .WORD data_LevelUpData_Raw + (49*2 * 9)      ; RedWiz
;  .WORD data_LevelUpData_Raw + (49*2 * 10)     ; WhiteWiz
;  .WORD data_LevelUpData_Raw + (49*2 * 11)     ; BlackWiz
  
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  [$9E0C :: 0x2DE1C]
;;    Lut - pointer table to the beginning of each character's OB stats in RAM

lut_CharStatsPtrTable:
  .WORD ch_stats
  .WORD ch_stats + $40
  .WORD ch_stats + $80
  .WORD ch_stats + $C0
  
  
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  CapAAt200  [$9E1C :: 0x2DE2C]
;;
;;    Sets A to 200 if it is over 200
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

CapAAt200:
    CMP #201
    BCC :+
      LDA #200
  : RTS

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  GiveRewardToParty  [$9E23 :: 0x2DE33]
;;
;;  input:        $80,81 = destination pointer.  Points to stat to be increased
;;          battlereward = 3-byte reward
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

GiveRewardToParty:
    JSR AddBattleRewardToVal        ; add reward to target buffer
    
    LDA #<data_MaxRewardPlusOne     ; set $82 to point to reward max+1 (1000000)
    STA $82
    LDA #>data_MaxRewardPlusOne
    STA $83
    
    LDY #3 - 1                      ; compare 3 bytes
    JSR MultiByteCmp                ;  current value compared to max
    
    BCC @Exit                       ; less than the max, just exit
    
    ; Otherwise, current >= max
    
    LDY #$00                ; loop to copy 3 bytes of data
    : LDA ($82), Y          ; copy max to dest
      STA ($80), Y
      INY
      CPY #$03
      BNE :-
      
    ; Then, because we're working with Max+1 for some stupid reason, subtract 1:
    JMP SubtractOneFromVal
    
  @Exit:
    RTS
    
    
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  GiveHpBonusToChar  [$9E44 :: 0x2DE54]
;;
;;  input:        $80,81 = destination pointer.  Points to stat to be increased (max HP)
;;          battlereward = 3-byte reward (must not be > $7FFF or this will overwrite character strength!)
;;
;;    This routine is basically a copy of GiveRewardToParty.  The only differences are:
;;  - It uses a different cap (1000 instead of 1000000)
;;  - It records the result to eobtext_print_hp so it can be displayed to the user
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

GiveHpBonusToChar:
    JSR AddBattleRewardToVal    ; add reward (which is the HP bonus)
    
    LDA #<data_MaxHPPlusOne     ; copy HP cap to $82,83
    STA $82
    LDA #>data_MaxHPPlusOne
    STA $83
    
    LDY #2 - 1                  ; compare 2 byte value (char max HP to HP cap)
    JSR MultiByteCmp
    BCC @Done                   ; if max HP < cap, jump ahead to @Done
    
    LDY #$00                    ; copy the cap over to the max HP
    : LDA ($82), Y
      STA ($80), Y
      INY
      CPY #$02
      BNE :-
      
    JSR SubtractOneFromVal      ; then subtract 1, because the cap is retardedly 1 over the maximum
 
  @Done:
    LDY #$00                    ; finally, copy the new max HP to eobtext_print_hp so
    LDA ($80), Y                ;   it can be printed to the user!
    STA eobtext_print_hp
    INY
    LDA ($80), Y
    STA eobtext_print_hp+1
    RTS

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  AddBattleRewardToVal [$9E72 :: 0x2DE82]
;;
;;  input:  $80  points to a 3-byte value to add battlereward to.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

AddBattleRewardToVal:
            @loopctr = $8B          ; local
    LDA #$03
    STA @loopctr                ; loop 3 times (adding 3 bytes)
    LDA #$00
    TAY                     ; A, X, Y all zero'd
    TAX                     ; Y = dest index, X = source index
    STA $8A                 ;  ??? $8A also zero'd?
    
    CLC                     ; CLC at the start of the addition
  @Loop:
      LDA ($80), Y          ; read dest byte
      ADC battlereward, X   ; sum with source/reward byte
      STA ($80), Y          ; write back to dest
      
      INX                   ; inc indexes to do next byte
      INY
      
      DEC @loopctr          ; loop 3 times, for each byte
      BNE @Loop
      
    RTS
    
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  MultiByteCmp  [$9EB1 :: 0x2DEC1]
;;
;;  input:  $80,81 = ptr to first value
;;          $82,83 = ptr to second value
;;               Y = number of bytes (-1) to compare.  Ex:  Y=1 compares 2 bytes
;;
;;  output:    Z,C = set to result of CMP
;;
;;    C set if ($80) >= ($82)
;;    Z set if they're equal
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

MultiByteCmp:
  @Loop:
    LDA ($80), Y            ; load value
    CMP ($82), Y            ; compare to target value
    BEQ @NextByte           ; if equal, do next byte
    
      PHP                     ; if not equal...
      PLA
      AND #$81                ; clear all flags except N,C.  Presumably this is to clear Z
      PHA                     ;  strangely, this also clears I!  nuts!  Why it preserves N is
      PLP                     ;  is a mystery, as its result here is not reliable.
      RTS                     ; and exit
    
  @NextByte:
    DEY                     ; decrease byte counter to move to next byte
    BNE @Loop               ; loop if more bytes to compare
    
    LDA ($80), Y            ; otherwise, if this is the last byte
    CMP ($82), Y            ; simply do the CMP
    RTS                     ; the 'Z' result will be preserved on this CMP
    
    
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  DivideRewardBySurvivors  [$9EC6 :: 0x2DED6]
;;
;;    Divides the reward (in battlereward) by the number
;;  of surviving party members.
;;
;;  input/output:   battlereward   (2 bytes)
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

DivideRewardBySurvivors:
    ; Count the number of players that survived
    LDX #$04                    ; loop down counter
    LDY #$00                    ; count of survivors
    
    LDA btl_drawflagsA          ; OR the drawflags together -- low 4 bits will be set
    ORA btl_drawflagsB          ;  if that character did not survive
  @CountLoop:
      LSR A                     ; shift out bits
      BCS :+                    ; if clear...
        INY                     ;  ... count it
    : DEX
      BNE @CountLoop
      
      
    ;;  Loop to divide exp reward by the number of remaining characters.
    ;;    strangely, this only divides a 16-bit value, when the experience itself
    ;;    is tallied into a 24-bit value.  I wouldn't say this is bugged, but it's
    ;;    a curiosity.
          @divisor =    $84
          @remainder =  $85
      
    STY @divisor                ; Y (the number of surviving party members) is the divisor
    LDA #$00
    STA @remainder              ; zero remainder
    
    LDX #16                     ; loop 16 times, one for each bit of the dividend
    
    ROL battlereward            ; roll out the high bit of the sum into C
    ROL battlereward+1
  @DivLoop:
    ROL @remainder              ; roll bit into remainder
    
    LDA @remainder
    CMP @divisor
    BCC :+                      ; once the remainder >= divisor
      SBC @divisor              ;  ... subtract divisor
      STA @remainder
  : ROL battlereward            ; roll 1 into result (if subtracted)
    ROL battlereward+1          ; or 0 into result (if didn't subtract)
    DEX
    BNE @DivLoop
    RTS
    

    
    
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Sum Battle Rewards
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

SumBattleRewardEXP:

;; Y = EXP

    LDA #$00
    STA battlereward            ; reset reward to zero
    STA battlereward+1
    STA battlereward+2
    
    LDX #$09                    ; loop 9 times, once for each enemy slot
    
  @Loop:
      CLC
      LDA btl_enemyrewards, Y     ; sum low byte
      ADC battlereward
      STA battlereward
      
      LDA btl_enemyrewards+1, Y   ; high byte
      ADC battlereward+1
      STA battlereward+1
      
      LDA battlereward+2        ; carry into 3rd byte - This is used for GP but not for Exp
      ADC #$00
      STA battlereward+2
      
      CLC
      TYA                       ; it assumes C is clear here, since sum cannot be over $FFFFFF
      ADC #04                   ;  add $04 to source index to move to next enemy ($04 bytes per enemy)
      TAY
      
      DEX
      BNE @Loop
      
      LDA ExpGainOption
      BEQ HalveReward ; If ExpGain is 0 (Low), halve the reward
          CMP #2
          BEQ DoubleReward ; If ExpGain is 2 (High), 1.5x the reward
          ;; Otherwise, ExpGain is 1, normal, so do nothing.
    RTS


SumBattleRewardGP:

;; Y = GP

    LDA #$00
    STA battlereward            ; reset reward to zero
    STA battlereward+1
    STA battlereward+2
    
    LDX #$09                    ; loop 9 times, once for each enemy slot
    
  @Loop:
      CLC
      LDA btl_enemyrewards, Y     ; sum low byte
      ADC battlereward
      STA battlereward
      
      LDA btl_enemyrewards+1, Y   ; high byte
      ADC battlereward+1
      STA battlereward+1
      
      LDA battlereward+2        ; carry into 3rd byte - This is used for GP but not for Exp
      ADC #$00
      STA battlereward+2
      
      CLC
      TYA                       ; it assumes C is clear here, since sum cannot be over $FFFFFF
      ADC #04                  ;  add $04 to source index to move to next enemy ($04 bytes per enemy)
      TAY
      
      DEX
      BNE @Loop
      
      LDA MoneyGainOption
      BEQ HalveReward ; If ExpGain is 0 (Low), halve the reward
          CMP #2
          BEQ DoubleReward ; If ExpGain is 2 (High), 1.5x the reward
          ;; Otherwise, ExpGain is 1, normal, so do nothing.
      
    RTS
    
    
HalveReward:
    LSR battlereward+2
    ROR battlereward+1
    ROR battlereward
    RTS

DoubleReward:    
    ASL battlereward
    ROL battlereward+1
    ROL battlereward+2 
    RTS

    
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  DrawEOBCombatBox  [$9F3B :: 0x2DF4B]
;;
;;    Draws an "End of Battle" (EOB) combat box.  These are boxes containing
;;  text that is shown at the end of battle... like "Level up!" kind of stuff.
;;
;;  input:  A = combat box ID to draw
;;          X = EOB string ID   (see lut_EOBText for valid values)
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

DrawEOBCombatBox:
    STA EOBCombatBox_tmp               ; backup the combo box ID
    
    LDA #BANK_THIS          ; set the current bank for the music driver
    STA cur_bank          ; seems weird to do this here...
    
    TXA                     ; Get the EOB string ID to print
    ASL A                   ; x2 to use as index
    
    TAY
    LDX lut_EOBText, Y      ; load pointer from lut
    LDA lut_EOBText+1, Y    ; and put in YX
    TAY
    
    LDA EOBCombatBox_tmp    ; restore combo box ID in A
    JSR DrawCombatBox_L     ; A = box ID, YX = pointer to string
    
    INC btl_boxcount  ; count this combat box
    RTS                     ; and exit!

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  RespondDelay_UndrawAllCombatBoxes [$9F57 :: 0x2DF67]
;;
;;    Calls RespondDelay, then undraws all combat boxes
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

RespondDelay_UndrawAllCombatBoxes:
    JSR RespondDelay                ; this is all self explanitory...
    LDA btl_boxcount
    JSR UndrawNBattleBlocks_L
    LDA #$00
    STA btl_boxcount
    RTS
    
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  RespondDelay [$9F66 :: 0x2DF76]
;;
;;    Waits the appropriate number of frames, as indicated by 'btl_responddelay'.
;;  Normally that value is dictated by the player's desired respond rate -- however
;;  its value is overwritten by some code for some areas of the game.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

RespondDelay:
    LDA btl_responddelay
    STA btl_respondrate_tmp               ; loop counter
  @Loop:
      JSR WaitForVBlank_L   ; Do a frame
      JSR MusicPlay         ; update music
      DEC btl_respondrate_tmp             ; repeat for desired number of frames
      BNE @Loop
    RTS
    
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  WaitForAnyInput [$9F78 :: 0x2DF88]
;;
;;  Spins and waits full frames until the user presses any button.
;;
;;  Input stored in A and btl_input upon exit.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

WaitForAnyInput:
    JSR GetJoyInput         ; get input
    PHA                     ; back it up
    JSR WaitForVBlank_L     ; wait a frame
    JSR MusicPlay           ; do music for that frame
    PLA                     ; get input
    BEQ WaitForAnyInput     ; keep looping if no buttons pressed
    
    RTS                     ; otherwise, exit with input stored in A
    
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  MusicPlay  [$9F86 :: 0x2DF96]
;;
;;    Call music play -- version for this bank
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

MusicPlay:
    LDA #BANK_THIS          ; tell CallMusicPlay which bank to swap back to
    STA cur_bank
    
    LDA music_track       ; check this track
    BPL :+                  ; if it's finished...
      LDA btl_followupmusic ;   ... load followup music
      STA music_track     ;   and play it   (not sure why this is necessary)
      
  : JMP CallMusicPlay_L 
  
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Battle_FlipAllChars  [$9F99 :: 0x2DFA9]
;;
;;    Does the animation to flip each of the characters to face right.
;;  Done when the party runs away from a battle.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

Battle_FlipAllChars:
    LDA #$10                ; put a pointer to first character's OAM data in $8A
    STA $8A                 ;  start at $10 because the first 4 sprites are for the battle
    LDA #>oam               ;  cursor/weapon/magic sprite.
    STA $8B
    
    LDA #$00                ; loop up-counter and character index
    STA $88
  @Loop:
      JSR Battle_FlipCharSprite ; flip this character sprite
      
      JSR WaitForVBlank_L       ; wait for a frame
      LDA #>oam                 ;  so we can update OAM
      STA $4014
      JSR MusicPlay             ; update music (since we waited a frame)
      
      LDA #15
      STA btl_responddelay      ; change respond delay to 15 (battle is over, so respond rate doesn't matter anymore)
      JSR RespondDelay          ; wait 15 frames
      
      INC $88                   ; Inc counter and loop until all 4 characters flipped.
      LDA $88
      CMP #$04
      
      BNE @Loop
      
    RTS
   
    
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Battle_FlipCharSprite  [$9FC4 :: 0x2DFD4]
;;
;;    Flips a character sprite (unless they're dead/stone) to face right.  This
;;  is done after the party runs away.
;;
;;  input:    A = ID of character to flip
;;          $8A = pointer in OAM to character's sprite data
;;
;;  output: $8A = updated to point to next character's sprite data
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

Battle_FlipCharSprite:
    JSR Shift6TAX           ; convert char ID to index
    LDA ch_ailments, X      ; get ailment
    CMP #$01
    BEQ @Skip               ; if they're dead, skip them
    CMP #$02
    BEQ @Skip               ; if they're stone, skip them
    CMP #$20             
    BEQ @Skip               ; if they're asleep, skip them
    
    ; Otherwise, we're going to loop and flip each character sprite
    LDX #$03                ; X is loop down counter.  3 rows of tiles per character
                            ;   2 tiles per row
  @Loop:
    LDY #<oam_x              ; swap X coordinates for the tiles
    LDA ($8A), Y
    PHA
    LDY #<oam_x+4
    LDA ($8A), Y
    LDY #<oam_x
    STA ($8A), Y
    PLA
    LDY #<oam_x+4
    STA ($8A), Y
    
    LDY #<oam_a              ; Then set the "flip-X" attribute bit for each tile
    JSR @FlipTile
    LDY #<oam_a+4
    JSR @FlipTile
    
    LDA #$08                ; pointer += 8 to move to next row of tiles
    JSR @AddToPtr           ;   (4 bytes per tile, 2 tiles per row)
    
    DEX                     ; Loop until all 3 rows flipped
    BNE @Loop
    
    RTS                     ; Then exit!
    
  @Skip:                    ; jumps here to skip the tile
    LDA #4*6                ; add $18 to the pointer to skip then entire character (4 bytes per tile
                            ;   6 tiles per character)
  @AddToPtr:
    CLC                     ; Add A to the pointer at $8A
    ADC $8A
    STA $8A
    LDA #$00                ; (adding carry to high byte is unnecessary, as OAM will never cross a page)
    ADC $8B
    STA $8B
    RTS
    
  @FlipTile:
    LDA ($8A), Y            ; get attribute byte
    ORA #$40                ; set the 'flip-X' bit
    STA ($8A), Y            ; write it back
    RTS
    

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  lut for End of Battle text  [$A00E :: 0x3201E]
;;
;;    Strings used for DrawEOBCombatBox.  I have no idea why some of the
;; string data is stored here, and some of it is stored way back at $9950.

lut_EOBText:
  .WORD @MnstPrsh               ; 0
  .WORD @ExpUp                  ; 1
  .WORD @ExpVal                 ; 2
  .WORD @Gold                   ; 3
  .WORD @GoldVal                ; 4
  .WORD @LevUp                  ; 5
  .WORD @eobtext_NameLN         ; 6
  .WORD @eobtext_HPMax          ; 7
  .WORD @eobtext_Npts           ; 8
  .WORD @eobtext_PartyPerished  ; 9
  
  @MnstPrsh: .BYTE $0F,$3D,$0F,$3C,$00      ; "Enemies perished" 
  @ExpUp:    .BYTE $0F,$49,$00              ; "Exp earned.."
  @ExpVal:   .BYTE $0C
             .WORD eob_exp_reward           ; "## Exp"  where ## is the experience reward
             .BYTE $FF,$8E,$BB,$B3,$00      
  @GoldVal:  .BYTE $0C
             .WORD eob_gp_reward            ; "## Gold"   where ## is the GP reward
             .BYTE $FF,$90,$B2,$AF,$A7,$00  
  @Gold:     .BYTE $0F,$5E,$00              ; "Gold found.."
  @LevUp:    .BYTE $0F,$30,$00              ; "Lev. up!"

  @eobtext_NameLN:
  .BYTE $02, $FF, $95, $0C
  .WORD eobtext_print_level
  .BYTE $00                                 ; "<Name> L##", where <Name> is btl_attacker's name and ## is value at $687A
  @eobtext_HPMax:
  .BYTE $0F, $31, $00                       ; "HP max"
  @eobtext_Npts:
  .BYTE $0C
  .WORD eobtext_print_hp
  .BYTE $0F, $32, $00                       ; "##pts." where ## is value at $687C
  @eobtext_PartyPerished:
  .BYTE $04, $0F, $3E, $0F, $3C, $00        ; "<Name> party perished", where <Name> is the party leader's name
  
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  ChaosDeath_FadeNoise  [$A03D :: 0x3204D]
;;
;;  input/output:   $9C = value to write to Noise volume reg
;;
;;    This routine is called by ChaosDeath.  The first time it is called, 9C=0, which means
;;  the DEC here will cause it to wrap to $FF.  This will make the noise start playing a rumble
;;  at full volume.
;;
;;    It is then called every $80 frames as the ChaosDeath animation progresses.  Each time, it
;;  will decrease the volume by 1, causing the noise to VERY SLOWLY fade out.
;;
;;    Until the end of the animation, where it is called a 17th time, resulting in the DEC
;;  producing a value of $EF.  This sets noise to play full volume with an automated fadeout
;;  that loops.  Resulting in two more "BOOM" noises that follow.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

ChaosDeath_FadeNoise:
    DEC $9C             ; DEC noise setting
    
    LDA $9C
    STA $400C           ; write it to noise volume control
    LDA #$FF
    STA $400D           ; (no effect)
    STA $400F           ; set length counter (make noise audible)
    LDA #$0F
    STA $400E           ; set tone -- lowest possible frequency resulting in a very low rumble.
    
    RTS


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  ChaosDeath  [$A052 :: 0x32062]
;;
;;    This does the slow "dissolving"/"disintegrating" effect that you see
;;  when Chaos is defeated.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    
ChaosDeath:
    LDA #110
    STA EOBCombatBox_tmp           ;   loop down counter
  @WaitLoop:                ; wait for 110 frames (wait for the fanfare music to get 
      JSR WaitForVBlank_L   ;   through the main jingle part)
      JSR MusicPlay
      DEC EOBCombatBox_tmp
      BNE @WaitLoop
      
    LDA #$80                ; stop music playback
    STA music_track
    STA btl_followupmusic
    JSR MusicPlay
    
    LDA #$08                ; silence all channels except Noise
    STA $4015
    STA $5015               ; JIGS - MMC5 audio
    
    ; a bunch of local vars
            @rvalprev       = $82   ; "previous" random value
            @rval           = $83   ; a random value
            @ppuaddr        = $88   ; 2 bytes
            @outerctr       = $9A
            @innerctr       = $9B
            @tilerowtbl     = btl_msgbuffer ; a table of 256 entries which says which row to erase for each tile
                                            ;   note that the table is 256 entries but it only NEEDS to be 128.
                                            ;   The last 128 entries are not used.
    
    LDA #$00                    ; Start the Low-pitch noise rumble
    STA $9C                     ; See ChaosDeath_FadeNoise for details
    JSR ChaosDeath_FadeNoise

    LDY #$00                    ; Fill @tilerowtbl with randomness
  @TableFillLoop:
      JSR BattleRNG_L
      STA @tilerowtbl, Y
      INY
      BNE @TableFillLoop
      
      
    ;   The Choas Death effect is done with a nested Loop.  There is an inner loop that runs $100
    ; times.  Each time it runs, it erases one row of pixels (row determined by @tilerowtbl)
    ; for a tile between $00-7F.  This will erase Chaos as well as the battle backdrop tiles.
    ;
    ;   The outer loop will change which row gets erased by incrementing each value in the table.
    ;
    ;   Note that in order to ensure no tiles get skipped, the RNG is assumed to produce every value
    ; between 0-255 exactly once when called 256 times.  This also means we can only generate
    ; ONE random number inside the inner loop.  Therefore, that random number is used for several things.
    ;
    ;   A frame is drawn after every row of pixels is erased.
    
    LDA #$08
    STA @outerctr         ; outer loop counter.   Loop 8 times (once for each pixel row)
  @OuterLoop:
      LDA #$00
      STA @innerctr         ; inner loop counter  Loop $100 times (for $80 tiles -- they'll get erased twice each)
    @InnerLoop:
    
        LDA @innerctr               ; update the noise playback halfway through the inner loop
        CMP #$80
        BNE :+
          JSR ChaosDeath_FadeNoise
          
      : LDA #$00                    ; The one **AND ONLY** RNG call to choose a tile to erase
        LDX #$79
        JSR RandAX
        
        STA @rval                   ; store the tile number for later use
        
        LDX #$10                    ; multiply the tile ID by $10 to get the PPU addr to that
        JSR MultiplyXA              ;  tile's CHR
        STA @ppuaddr
        STX @ppuaddr+1
        
        LDY @rval                   ; get tile number, use it to figure out which row to erase
        LDA @tilerowtbl, Y
        AND #$07                    ; mask off to get 0-7 (only 8 rows of tiles)
        
        CLC                         ; Add the row number to the PPU addr
        ADC @ppuaddr
        STA @ppuaddr
        LDA @ppuaddr+1
        ADC #$00
        STA @ppuaddr+1
        
        JSR WaitForVBlank_L         ; Wait for VBlank
        
        LDA #$00
        JSR @SetPpuAddr         ; set ppu addr to low bitplane
        LDA #$00
        STA $2007               ; erase it
        
        LDA #$01
        JSR @SetPpuAddr         ; set ppu addr to high bitplane
        LDA #$00
        STA $2007               ; erase it
        
        LDA @rvalprev           ; load *another* random value
        AND #$03
        STA $2005               ; use it as X scroll to shake the screen
        
        LDA @rval               ; use tile ID as random number for Y scroll
        STA @rvalprev           ;  (and use it as X scroll next iteration)
        AND #$03
        STA $2005
        
        DEC @innerctr           ; loop 256 times!
        BNE @InnerLoop
        ;- end inner loop
    
      LDX #$00                  ; Once the inner loop ends, INC each entry in the @tilerowtbl
      : INC @tilerowtbl, X      ;  so change which rows get erased next outer iteration
        INX
        BNE :-
      
      JSR ChaosDeath_FadeNoise  ; update noise effect
      DEC @outerctr
      BNE @OuterLoop            ; outer loop 8 times
    ;- end outer loop
    
    ; At this point, Chaos and the battle backdrop have disintegrated, and the noise has started playing
    ; a "BOOM BOOM" effect (see ChaosDeath_FadeNoise for details).
    ;
    ; Wait 2 seconds for dramatic effect
    
    LDA #120
    STA $9E                 ; 120 frames = 2 seconds
  @Wait2SecondLoop:
      JSR WaitForVBlank_L
      LDA #$00
      : SEC                 ; small inner loop to burn cycles so that we don't call WaitForVBlank
        SBC #$01            ; immediately at the start of VBlank (even though that shouldn't be
        BNE :-              ; a problem)
      DEC $9E
      BNE @Wait2SecondLoop
    
    LDA #$00                ; then finally make the noise shut the hell up
    STA $4015
    
    RTS                     ; and exit!
 

    ; This is JSR'd to by the above code to set the PPU addr.
    ; input:  A=0 to set PPU addr to low bitplane
    ;         A=1 to set PPU addr to high bitplane
    
  @SetPpuAddr:
    ASL A           ; A*8 to move bitplane bit into proper position
    ASL A
    ASL A
    CLC
    ADC @ppuaddr    ; Add to ppu addr
    PHA             ; (push low byte, since $2006 needs high byte written first)
    LDA #$00
    ADC @ppuaddr+1  ; Resume addition to high byte
    STA $2006       ; write high byte
    PLA             ; then pull and write low byte
    STA $2006
    RTS
  
  
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  PrepareEnemyFormation [$A12A :: 0x2E13A]
;;
;;    This routine will take loaded formation data and will generate the appropriate number
;;  of enemies for this battle.  It will also do all the drawing of all the enemies (NT and Attributes).
;;  However, it will not load any enemy stats.  It merely records the IDs of each enemy
;;
;;  input:
;;      btlformation
;;      btl_formdata
;;
;;  output:
;;      btl_battletype
;;      btl_enemyIDs
;;      (PPU drawing of all enemies)
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

PrepareEnemyFormation:
    ; Start by doing some blanket RAM clearing
    
    ; zero RAM at $6BB2 to $6C8F
    ; This is basic RAM clearing to prep generation of the battle formation.
    ;   This clears things like number of available slots for each enemy, as well
    ;   as enemy stats.
    LDA #$00
    LDX #$DE
    LDY #$00
    : STA $6BB2, Y ; btl_smallslots
      INY
      DEX
      BNE :-
      
    ; fill RAM at $6BB7 to $6BCC with $FF
    ; This fills the enemyIDs with FF which indicates "no enemy".  Though it probably should only have
    ;   to do this for 9 bytes, not $15.  This fill spills into btl_enemygfxplt, which isn't used
    ;   unless the enemy ID is valid anyway....
    LDA #$FF
    LDX #$09    ;; JIGS - fixed
    : STA btl_enemyIDs, X       
      DEX
      BPL :-
      
    LDA btlformation          ; See if this is a B-formation
    BPL :+                      ; if it is, replace A-formation values with the B-formation values
      LDA btlform_enqtyB        ; use formation B min/max values
      STA btlform_enqty
      LDA btlform_enqtyB +1
      STA btlform_enqty  +1
      LDX #$00
      STX btlform_enids +2      ; zero the enemy ID and min/max for enemies 2,3
      STX btlform_enids +3      ; (only enemies 0,1 are used for B formations)
      STX btlform_enqty +2
      STX btlform_enqty +3
      
  : LDA #<btl_formdata          ; prep (btltmp+10) to point to the formation data
    STA btltmp+10
    LDA #>btl_formdata
    STA btltmp+11
    
    
    LDA btlform_type            ; Get the battle type (stored in high 4 bits of first formation byte)
    LSR A
    LSR A
    LSR A
    LSR A
    STA btl_battletype
    STA dlgmusic_backup
    
    CMP #07
    BEQ @4Large_Boss
    CMP #06
    BEQ @9Small_Boss
    CMP #05                    
    BEQ @Mix_Boss
    CMP #04
    BEQ @BigBoss
    CMP #03
    BEQ @BigBoss
    CMP #02
    BEQ @Mix
   
   @9Small_4Large:   
    JMP PrepareEnemyFormation_SmallLarge  ; type=0,1  : prepare the '9Small' or '4Large' enemy formation   
   @Mix_Boss: 
    LDA #2
    STA btl_battletype
   @Mix: 
    JMP PrepareEnemyFormation_Mix         ; type=2    : prepare the 'Mix' enemy formation
   @BigBoss:
    JMP PrepareEnemyFormation_FiendChaos  ; type=3,4  : prepare the 'Fiend'/'Chaos' enemy formation
   @9Small_Boss:
    LDA #0   
    STA btl_battletype
    JMP PrepareEnemyFormation_SmallLarge
   @4Large_Boss:
    LDA #1   
    STA btl_battletype
    JMP PrepareEnemyFormation_SmallLarge


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  PrepareEnemyFormation_SmallLarge [$A17E :: 0x2E18E]
;;
;;    PrepareEnemyFormation, but specifically geared for the '9Small' and '4Large'
;;  formation types
;;
;;  input:
;;     A = 0 if using the 9Small formation type
;;     A = 1 if using the 4Large formation type
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

    ;; JIGS - this is done a few times, so I consolidated them into a JSR/RTS to save a few bytes
    UnrollThing:
    ROL A
    ROL A
    AND #$01
    STA btl_tmppltassign        
    LDA btlform_engfx           
    RTS


PrepareEnemyFormation_SmallLarge:
    ASL A               ; multiply the formation type by 4 so we can use it to index a LUT
    ASL A
    TAX
    LDY #$00
    
    ; Prep btl_smallslots and btl_largeslots apporpriately for this formation type
    : LDA lut_EnemyCountByBattleType, X
      STA btl_smallslots, Y
      INX
      INY
      CPY #$02
      BNE :-
      
    LDA #$00            ; clear the enemy counter
    STA btl_enemycount
    
    ;; This is the start of an unrolled loop that preps the graphics and palettes for each enemy group
    ; enemy group 0
    LDA btlform_enplt           ; palette assignment
    JSR UnrollThing
    
    AND #$03
    LSR A
    ROR A
    ROR A                       ; isolate $03 graphic bits, move to $C0
    LDY #$02
    STY btltmp+2                ; load group 0 (+2)
    JSR @GenerateEnemyGroup     ; GENERATE
    
    ; enemy group 1
    LDA btlform_enplt           ; palette assignment
    ROL A
    JSR UnrollThing
    
    AND #$0C
    CLC
    ASL A
    ASL A
    ASL A
    ASL A                       ; isolate $0C graphic bits, move to $C0
    LDY #$03
    STY btltmp+2                ; load group 1 (+2)
    JSR @GenerateEnemyGroup     ; GENERATE
    
    ; enemy group 2
    LDA btlform_enplt           ; palette assignment
    ROL A
    ROL A
    JSR UnrollThing
    
    AND #$30
    ASL A
    ASL A                       ; isolate $30 graphic bits, move to $C0
    LDY #$04
    STY btltmp+2                ; load group 2 (+2)
    JSR @GenerateEnemyGroup     ; GENERATE
    
    ; enemy group 3
    LDA btlform_enplt           ; palette assignment
    ROL A
    ROL A
    ROL A
    JSR UnrollThing
    
    AND #$C0                    ; isolate $C0 graphic bits
    LDY #$05
    STY btltmp+2                ; load group 3 (+2)
    JSR @GenerateEnemyGroup     ; GENERATE
    
    ; Once the enemies have been generated - draw them!
    JMP DrawFormation_NonFiend
    

    
;;  Support routine to generate an enemy group  [A202 :: 0x2E212]
;;
;;  input:
;;      A               = graphic assignment for this group (in high 2 bits:  00,40,80,C0)
;;      btltmp+10       = a pointer to btl_formdata  (why it doesn't just use btl_formdata directly is beyond me
;;      btltmp+2        = 2,3,4, or 5 to indicate which enemy group to generate
;;      btl_tmppltasign = 0 or 1 to indicate palette assignment for this group
;;      btl_enemycount  = number of enemies generated so far
;;      btl_smallslots  = number of available small enemy slots
;;      btl_largeslots  =   "   "             large
;;
;;  output:
;;      btl_enemycount  = updated to reflect changes
;;      btl_smallslots  = updated
;;      btl_largeslots  = updated
;;      btl_enemygfxplt = the graphic and palette assignment for this enemy (graphic in high 2 bits, palette in low bit)
;;      btl_enemyIDs    = the actual ID for this enemy
  @GenerateEnemyGroup:
    STA btl_drawformationtmp               ; 6BCF is a temp store for the graphic assignment
    
   ; LDA btl_formdata, Y     ; pointless:  Get the ID of this enemy, but never use it
    LDY btltmp+2            ; Get the group index
    
    JSR IncYBy4             ; add 4 to get the index to the enemy quantities
    LDA (btltmp+10), Y      ; Get the quantity for this enemy
    AND #$0F
    TAX                     ; but low 4 bits (max) in X
    LDA (btltmp+10), Y      ; get again to put high 4 bits (min) in A
    LSR A
    LSR A
    LSR A
    LSR A
    
    JSR RandAX              ; with A=min and X=max, get a random number of enemies
    ORA #$00                ; ORA with 0 just to update the Z flag
    BEQ @Exit2              ; If there are no enemies, jump ahead to an RTS
    
    STA btl_drawformationtmp2               ; put the number of enemies in 6BD0
    
    ; Here the game checks to see if there is a slot available, and exits if there isn't.
    ;  but this is TOTALLY unnecessary because it does the exact same check inside the loop
    ;  that immediately follows this code
    LDY #$00
    LDA btl_drawformationtmp               ; get graphic assignment
    ASL A                   ; check bit 6 to see if it is large/small
    BPL :+
      INY                   ; Y=1 for large enemies, Y=0 for small enemies
  : LDA btl_smallslots, Y   ; see if there are enough slots available for this enemy
    BEQ @Exit2              ; if no slots remaining, jump ahead to RTS
    
@Loop:
    LDY #$00
    LDA btl_drawformationtmp              ; get bit 6 of graphic again to see if it's small/large
    ASL A
    BPL :+
      INY                   ; Y=1 for large, 0 for small
:   LDA btl_smallslots, Y   ; check to see if there are slots available
    BEQ @Exit1              ; if there are no more slots available, jump ahead to an RTS
    
    SEC
    SBC #$01
    STA btl_smallslots, Y   ; remove one of the available slots
    
    LDX btl_enemycount      ; Get the current enemy counter as an index
    LDA btl_drawformationtmp               ; Get graphic
    ORA btl_tmppltassign    ; combine with palette
    STA btl_enemygfxplt, X  ; record it for this generated enemy
    
    TYA
    PHA                     ; pointless: backup small/large indicator
    
    LDY btltmp+2            ; get index to enemy ID
    LDA btl_formdata, Y     ; get enemy ID
    STA btl_enemyIDs, X     ; record it for this generated enemy
    
    PLA                     ; pointless: restore backup of small/large indicator (but it's never used again)
    TAY
    
    INC btl_enemycount      ; increment the generated enemy counter
    DEC btl_drawformationtmp2               ; decrement the counter indicating how many of this type of enemy we have to make
    BNE @Loop               ; loop until we've generated all of them
    
@Exit1:
   RTS
@Exit2:
   RTS
   
   
   
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  LUT for Fiend TSA Pointers [$A266 :: 0x2E276]
;;
;;    There are 4 fiend TSAs, each consisting of $50 bytes ($40 TSA and $10 attribute).
;;  This LUT contains the pointers to the start of each fiend's TSA data.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
   
lut_FiendTSAPtrs:
  .WORD data_FiendTSA
  .WORD data_FiendTSA + $50
  .WORD data_FiendTSA + $A0
  .WORD data_FiendTSA + $F0

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  PrepareEnemyFormation_FiendChaos  [$A26E :: 0x2E27E]
;;
;;    PrepareEnemyFormation, but specifically geared for the 'Fiend' and 'Chaos'
;;  formation types
;;
;;  input:
;;     A = 3 if using the Fiend formation type
;;     A = 4 if using the Chaos formation type
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

PrepareEnemyFormation_FiendChaos:
    CMP #$04
    BNE PrepareEnemyFormation_Fiend
    JMP PrepareEnemyFormation_Chaos
    
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  PrepareEnemyFormation_Fiend  [$A275 :: 0x2E285]
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

PrepareEnemyFormation_Fiend:
    JSR ReadAttributesFromPPU   ; Read the Attributes into btltmp_attr
    
    ; First, draw the Fiend's NT data
    LDA btlform_engfx           ; get the assigned graphic for this formation
    ASL A                       ; x2 to use as index for lut_FiendTSAPtrs
    TAX
    
    LDA #$08
    STA btl_drawformationtmp    ; 8 rows of tiles.  Used as loop down-counter
    
    LDA lut_FiendTSAPtrs, X     ; source TSA data in btltmp+4
    STA btltmp+4
    LDA lut_FiendTSAPtrs+1, X
    STA btltmp+5
    
    LDA #<$2104                 ; dst PPU address ($2104) in btltmp+6
    STA btltmp+6
    LDA #>$2104
    STA btltmp+7
    
    LDA #BANK_THIS              ; source bank (this bank)
    STA btltmp+9
    
  @RowLoop:
      LDA #$08
      STA btltmp+8              ; copy 8 bytes
      ;JSR Battle_WritePPUData_L ; Do the PPU writing with the given params
      JSR Battle_WritePPUData_BankB
      JSR TurnOffScreen_SetScroll
      
      CLC
      LDA btltmp+4              ; add 8 to the source pointer to point to next row of tiles
      ADC #$08
      STA btltmp+4
      BCC :+
        INC btltmp+5
        
    : JSR BtlTmp6_NextRow       ; update the dest PPU address to point to next row
    
      DEC btl_drawformationtmp                 ; dec row counter
      BNE @RowLoop              ; loop until all 8 rows are drawn
    
    JSR ApplyPalette_FiendChaos             ; apply this fiend's palette
    JMP FinalizeEnemyFormation_FiendChaos   ; then finalize (write palettes to PPU, other crap)
    
    
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  BtlTmp6_NextRow  [$A2B8 :: 0x2E2C8]
;;
;;  Assuming btltmp+6 contains a PPU address, this routine increments that
;;  updates that address to point to the next row of tiles
;;
;;  Note that this routine is pretty much identical to BtlTmp_NextRow, only it modifies
;;  btltmp+6 instead of btltmp+0
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

BtlTmp6_NextRow:
    CLC             ; simply add $20 to btltmp+6
    LDA btltmp+6
    ADC #$20
    STA btltmp+6
    BCC :+
      INC btltmp+7  ; carry increments btltmp+7
  : RTS
    
    
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  ApplyPalette_FiendChaos  [$A2C4 :: 0x2E2D4]
;;
;;    Draws the palette for the fiends/chaos.  Does not draw directly to the PPU,
;;  instead, it draws to btltmp_attr.
;;
;;  input:
;;    btltmp+4,5    = points to $10 bytes of source attribute data
;;
;;  output:
;;    btltmp_attr   = updated
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

ApplyPalette_FiendChaos:
    LDY #$00        ; loop up-counter
  @Loop:
      LDA @lut_AtOffset, Y  ; put the attribute offset for this byte in X
      TAX
      
      LDA (btltmp+4), Y
      STA btltmp_attr, X    ; copy the attribute byte over
      
      INY
      CPY #$10
      BNE @Loop             ; loop until all $10 bytes copied
    RTS
    
  @lut_AtOffset:
    .BYTE $08, $09, $0A, $0B
    .BYTE $10, $11, $12, $13
    .BYTE $18, $19, $1A, $1B
    .BYTE $20, $21, $22, $23
  
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  PrepareEnemyFormation_Chaos  [$A2E5 :: 0x2E2F5]
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  
PrepareEnemyFormation_Chaos:
    JSR ReadAttributesFromPPU
    
    LDA #$0C
    STA btl_drawformationtmp               ; row counter (used as loop down-counter).  Draw $C rows
    
    LDA #<data_ChaosTSA     ; load source pointer to btltmp+4
    STA btltmp+4            ;  source is the Chaos TSA
    LDA #>data_ChaosTSA
    STA btltmp+5
    
    LDA #<$20C2             ; load dest PPU addr to btltmp+6
    STA btltmp+6            ;  drawing to $20C2
    LDA #>$20C2
    STA btltmp+7
    
    LDA #BANK_THIS          ; source bank is this bank
    STA btltmp+9
    
  @RowLoop:
      LDA #$0E
      STA btltmp+8              ; draw $0E tiles
      
      ;JSR Battle_WritePPUData_L ; do the actual drawing for this row
      
      JSR Battle_WritePPUData_BankB
      JSR TurnOffScreen_SetScroll
      
      CLC                   ; add $0E to source pointer to point to next row
      LDA btltmp+4
      ADC #$0E
      STA btltmp+4
      BCC :+
        INC btltmp+5
        
    : JSR BtlTmp6_NextRow   ; adjust dest pointer to point to next row
    
      DEC btl_drawformationtmp             ; dec row counter and loop until we've drawn all rows
      BNE @RowLoop
    
    ; Once all rows are drawn, apply Chaos's palette
    JSR ApplyPalette_FiendChaos
    
    ; code continues into FinalizeEnemyFormation_FiendChaos
    
    
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  FinalizeEnemyFormation_FiendChaos  [$A31E :: 0x2E32E]
;;
;;    This sets the 1 enemy for this formation (the fiend or chaos), then calls
;;  WriteAttributes_ClearUnusedEnStats to finish up the PrepareEnemyFormation work.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

FinalizeEnemyFormation_FiendChaos:
    LDA #$01
    STA btl_enemycount      ; There is exactly 1 enemy for Fiend/Chaos formations
    LDA btlformation      ; See if this is a B-formation
    BPL :+                  ; if it is, load second enemy ID
      LDA btlform_enids+1
      JMP :++
    
  : LDA btlform_enids       ; Just use the first enemy ID as the only enemy in this formation
  : STA btl_enemyIDs
    STA btl_enemyroster               ; ???  Duplicated to 6BC9?  Why?  I doubt this is ever used
    ;JMP WriteAttributes_ClearUnusedEnStats
    JMP WriteAttributesToPPU
    
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  PrepareEnemyFormation_Mix  [$A32F :: 0x2E33F]
;;
;;    PrepareEnemyFormation, but specifically geared for the 'Mix' formation
;;  type (2Large + 6Small)
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

PrepareEnemyFormation_Mix:
    LDA #$00
    STA btl_enemycount          ; reset enemy count to zero
    
    LDY #$02
    STY btltmp_smallslotpos     ; small enemy slots start at slot 2
    
    LDA #$02
    STA btl_largeslots          ; 2 large slots available
    LDA #$06
    STA btl_smallslots          ; 6 small slots
    
    ;;;;
    ;; Begin an unrolled loop to load each enemy group
    ;;;;
    
    ;; Group 0
    LDA btlform_enplt           ; Get palette assignment bits
    CLC
    JSR UnrollThing
     ;; JIGS ^ used again here, and below
     
    AND #$03
    ASL A
    ASL A
    ASL A
    ASL A
    ASL A
    ASL A                       ; Extract $03 bits, move into $C0 bits
    LDY #$00
    STY btltmp+2                ; indicate we want to load group 0
    JSR @GenerateEnemyGroup     ; GENERATE
    
    ;; Group 1
    LDA btlform_enplt           ; pallete assignment
    CLC
    ROL A
    JSR UnrollThing
   
    AND #$0C
    ASL A
    ASL A
    ASL A
    ASL A                       ; extract $0C bits, move to $C0 bits
    LDY #$01
    STY btltmp+2                ; load group 1
    JSR @GenerateEnemyGroup     ; GENERATE
    
    ;; Group 2
    LDA btlform_enplt           ; pallete assignment
    LSR A
    LSR A
    LSR A
    LSR A
    LSR A
    ;LSR A                       ; extract bit 6 of palette assignment
    ;; JIGS - fixing a bug?
    AND #$01                    ;   BUGGED - this should be bit 5!  There is 1 too many LSRs
    STA btl_tmppltassign
    LDA btlform_engfx           ; get graphic
    AND #$30
    ASL A
    ASL A                       ; extract $30 bits, move to $C0 bits
    LDY #$02
    STY btltmp+2                ; load group 2
    JSR @GenerateEnemyGroup     ; GENERATE
    
    ;; Group 3
    LDA btlform_enplt           ; pallete assignment
    LSR A
    LSR A
    LSR A
    LSR A
    AND #$01                    ; extract bit 4 of palette assignment
    STA btl_tmppltassign
    LDA btlform_engfx           ; get graphic
    AND #$C0                    ; extract $C0 bits
    LDY #$03
    STY btltmp+2                ; load group 3
    JSR @GenerateEnemyGroup     ; GENERATE
    
    
    ;; Once all enemy groups have been generated, do the PPU drawing!
    JMP DrawFormation_NonFiend
    
    
;;  Support routine to generate an enemy group  [A3B3 :: 0x2D3C3]
;;
;;  This is strikingly similar to the routine used by 9Small and 4Large formations (at $A202)
;;    but this one has very subtle changes to make it work with the mix formation.
;;
;;  input:
;;      A               = graphic assignment for this group (in high 2 bits:  00,40,80,C0)
;;      btltmp+2        = 0,1,2, or 3 to indicate which enemy group to generate
;;      btl_tmppltasign = 0 or 1 to indicate palette assignment for this group
;;      btl_enemycount  = number of enemies generated so far
;;      btl_smallslots  = number of available small enemy slots
;;      btl_largeslots  =   "   "             large
;;      btltmp_smallslotpos   = the next open enemy slot to place a small enemy
;;
;;  output:
;;      btl_enemycount  = updated to reflect changes
;;      btl_smallslots  = updated
;;      btl_largeslots  = updated
;;      btl_enemygfxplt = the graphic and palette assignment for this enemy (graphic in high 2 bits, palette in low bit)
;;      btl_enemyIDs    = the actual ID for this enemy
;;      btltmp_smallslotpos = updated

  @GenerateEnemyGroup:
    LDY btltmp+2
    ORA btl_tmppltassign
    STA btltmp+0
    AND #$40                    ; check the graphic assignment for this group
      BEQ @PlaceSmallGroup      ; if this uses a small graphic, jump to @PlaceSmallGroup
      
  @PlaceLargeGroup:
    LDA btl_largeslots
    BEQ @LargeExit          ; if there are no more large slots, skip this enemy group
    
    LDA btlform_enqty, Y    ; get min/max for this enemy group
    PHA
    AND #$0F                
    TAX                     ; put max in X
    PLA
    LSR A
    LSR A
    LSR A
    LSR A                   ; put min in X
    JSR RandAX              ; get a random enemy count for this group
    ORA #$00                ; ORA just to update the Z flag
    BEQ @LargeExit          ; If there are no enemies to generate, just exit
    
    STA btltmp+3            ; put the number of enemies in btltmp+3, used as a loop counter
    LDY btltmp+2
    LDA btlform_enids, Y    ; get the enemy ID
  @LargeLoop:
      LDY #$00              ; if there is only 1 large slot available, use enemy slot 1
      LDX btl_largeslots    ; otherwise, use enemy slot 0
      CPX #$01
      BNE :+
        INY                 ; Y= enemy slot to use (0 or 1)
        
    : STA btl_enemyIDs, Y   ; record the enemy ID
    
      PHA                   ; backup enemy ID
      LDA btltmp+0          ; record the graphic/palette assignment for this enemy
      STA btl_enemygfxplt, Y
      PLA                   ; restore enemy ID
      
      INC btl_enemycount    ; increment enemy counter
      DEC btl_largeslots    ; reduce number of available large slots
      BEQ @LargeExit        ; if no more available, we can't place any more of this enemy
      
      DEC btltmp+3          ; loop until no more enemies in this group to place
      BNE @LargeLoop
  @LargeExit:
    RTS
    
  @PlaceSmallGroup:
    LDA btl_smallslots
    BEQ @SmallExit          ; if there are no more small slots available, can't place this group
    
    LDA btlform_enqty, Y    ; get min/max for this enemy group
    PHA
    AND #$0F
    TAX                     ; max goes in X
    PLA
    LSR A
    LSR A
    LSR A
    LSR A                   ; min goes in A
    
    JSR RandAX              ; get a random quantity
    ORA #$00                ; ORA to update Z flag
    BEQ @SmallExit          ; if no enemies in this group, then exit
    
    STA btltmp+3            ; store qty
    LDY btltmp+2
    LDA btlform_enids, Y    ; get the enemy ID
    
  @SmallLoop:
      LDY btltmp_smallslotpos   ; record the enemy ID in the next small enemy slot
      INC btltmp_smallslotpos   ;  and increment the next small enemy slot
      STA btl_enemyIDs, Y
      
      PHA                       ; backup enemy ID
      LDA btltmp+0
      STA btl_enemygfxplt, Y    ; record graphic and palette assignment
      PLA                       ; restore enemy ID
      
      INC btl_enemycount        ; increase enemy count
      DEC btl_smallslots        ; decrease available small slots
      BEQ @SmallExit            ; if no more small slots available, exit
      
      DEC btltmp+3              ; reduce quantity and loop until no more enemies to place
      BNE @SmallLoop
      
  @SmallExit:
    RTS

;;;;;;;;;;;;;;;
;;  Formation attributes need to fill 32 bytes, each byte has 4 regions where the attribute is determined
;;   by a particular enemy.  Each digit/nybble here indicates which enemy determines the palette for each
;;   16x16 attribute block.  IE, a value of 1 means the first enemy (enemy 0's) palette is used.  A value
;;   of 0 means the block is used by background instead and not by any enemy
lut_FormationAttributes_9Small:                 ; "tops" are the odd rows of attributes, "bottoms" are even
    .BYTE $00,$00,$00,$00,$00,$00,$00,$00       ;  it's easier to work this way, sadly
    .BYTE $00,$22,$55,$58,$80,$00,$00,$00
    .BYTE $01,$11,$44,$77,$70,$00,$00,$00
    .BYTE $03,$36,$66,$99,$00,$00,$00,$00
;lut_FormationAttributes_9Small_bottoms:        ; These are the "bottoms"
    .BYTE $00,$22,$55,$58,$80,$00,$00,$00       ;  If you were to interleave these so that they were ordered top1, bottom1, top2, bottom2, top3, bottom3, etc
    .BYTE $01,$11,$44,$77,$70,$00,$00,$00       ;  it would make a lot more sense.  They're structured this way only for ease of indexing.
    .BYTE $01,$11,$44,$77,$70,$00,$00,$00
    .BYTE $03,$36,$66,$99,$00,$00,$00,$00
    
;    .BYTE $00,$00,$00,$00,$00,$00,$00,$00     ; it would look like this!
;    .BYTE $00,$22,$55,$58,$80,$00,$00,$00 
;    .BYTE $00,$22,$55,$58,$80,$00,$00,$00
;    .BYTE $01,$11,$44,$77,$70,$00,$00,$00 
;    .BYTE $01,$11,$44,$77,$70,$00,$00,$00
;    .BYTE $01,$11,$44,$77,$70,$00,$00,$00
;    .BYTE $03,$36,$66,$99,$00,$00,$00,$00
;    .BYTE $03,$36,$66,$99,$00,$00,$00,$00    
    
    
lut_FormationAttributes_4Large:
    .BYTE $00,$00,$00,$00,$00,$00,$00,$00
    .BYTE $01,$11,$13,$33,$00,$00,$00,$00
    .BYTE $02,$22,$44,$44,$00,$00,$00,$00
    .BYTE $02,$22,$44,$44,$00,$00,$00,$00
; bottoms:    
    .BYTE $01,$11,$13,$33,$00,$00,$00,$00
    .BYTE $01,$11,$13,$33,$00,$00,$00,$00
    .BYTE $02,$22,$44,$44,$00,$00,$00,$00
    .BYTE $02,$22,$44,$44,$00,$00,$00,$00
    
;    .BYTE $00,$00,$00,$00,$00,$00,$00,$00
;    .BYTE $01,$11,$13,$33,$00,$00,$00,$00
;    .BYTE $01,$11,$13,$33,$00,$00,$00,$00
;    .BYTE $01,$11,$13,$33,$00,$00,$00,$00
;    .BYTE $02,$22,$44,$44,$00,$00,$00,$00
;    .BYTE $02,$22,$44,$44,$00,$00,$00,$00
;    .BYTE $02,$22,$44,$44,$00,$00,$00,$00
;    .BYTE $02,$22,$44,$44,$00,$00,$00,$00
    
    
lut_FormationAttributes_Mix:
    .BYTE $00,$00,$00,$00,$00,$00,$00,$00
    .BYTE $01,$11,$14,$44,$77,$00,$00,$00
    .BYTE $02,$22,$03,$36,$66,$00,$00,$00
    .BYTE $02,$22,$55,$58,$80,$00,$00,$00    
; bottoms:
    .BYTE $01,$11,$14,$44,$77,$00,$00,$00
    .BYTE $01,$11,$13,$36,$66,$00,$00,$00
    .BYTE $02,$22,$03,$36,$66,$00,$00,$00
    .BYTE $02,$22,$55,$58,$80,$00,$00,$00
    
    .BYTE $00,$00,$00,$00,$00,$00,$00,$00
    .BYTE $01,$11,$14,$44,$77,$00,$00,$00    
    .BYTE $01,$11,$14,$44,$77,$00,$00,$00
    .BYTE $01,$11,$13,$36,$66,$00,$00,$00    
    .BYTE $02,$22,$03,$36,$66,$00,$00,$00
    .BYTE $02,$22,$03,$36,$66,$00,$00,$00    
    .BYTE $02,$22,$55,$58,$80,$00,$00,$00    
    .BYTE $02,$22,$55,$58,$80,$00,$00,$00    
    
    
lut_FormationPlacement_9Small:
  .WORD $2163, $20C4, $2202     ; Left column of enemies
  .WORD $2168, $20C9, $2207     ; Center column
  .WORD $216D, $20CE, $220C     ; right column
  .WORD 0                       ; terminator
  
lut_FormationPlacement_4Large:
  .WORD $A0C3, $A1A2
  .WORD $A0CA, $A1A9
  .WORD 0                       ; terminator
  
lut_FormationPlacement_Mix:
  .WORD $A0C3, $A1A2
  .WORD $216A, $20CB, $2209     ; Center column
  .WORD $216F, $20D0, $220E     ; right column
  .WORD 0                       ; terminator
  
BattleFormation_PrepAttributeLutsToXA:
    ; in:   XA = pointer to FormationAttributesTable (ie:  FormationAttributes_9Small)
    ; out:  btltmp+2 through btltmp+5 set appropriately for BattleFormation_GetAttributeByte
    STA btltmp+2
    STX btltmp+3
    CLC
    ADC #8*4
    STA btltmp+4
    TXA
    ADC #0
    STA btltmp+5
    RTS
    
BattleFormation_GetAttributeByte:
    ; in:   Y = index of attribute byte to get
    ;       btltmp+2, btltmp+3 = should point to "tops" FormationAttributes table
    ;       btltmp+4, btltmp+5 = should point to "bottoms" FormationaAttributes table
    ; out:  A = attribute byte
    @dst = btltmp+1
    LDA (btltmp+4),Y        ; load the "bottoms"
    JSR BattleFormation_GetAttributeNybble
    ASL A
    ASL A
    ASL A
    ASL A
    STA @dst
    LDA (btltmp+2),Y        ; load the "tops"
    JSR BattleFormation_GetAttributeNybble
    ORA @dst
    RTS
    
BattleFormation_GetAttributeNybble:
    ; in:   A = formation lut byte
    ; out:  A = nybble
    ;   (trashes btltmp+0 and X)
    @dst = btltmp+0
   
    PHA         ; back up src byte
    
    AND #$0F    ; get the low nybble (right / high nybble of output)
    BEQ @next   ; if it's zero, it's not an enemy.  Leave it with attribute 0
        ; otherwise, it's an enemy index (plus one), so get the palette assignment
        TAX
        LDA btl_enemygfxplt-1, X
        AND #1      ; 0 actually uses palette 1, 1 actually uses palette 2
        CLC
        ADC #1
        ASL A
        ASL A
        
  @next:
    STA @dst    ; store high half-nybble of dst byte
    PLA         ; get high nybble of src byte
    LSR A       
    LSR A
    LSR A
    LSR A
    BEQ @done   ; if it's zero, there's no enemy
        TAX
        LDA btl_enemygfxplt-1, X
        AND #1      ; 0 actually uses palette 1, 1 actually uses palette 2
        CLC
        ADC #1
        ORA @dst
        STA @dst
    
  @done:
    LDA @dst
    RTS
    
BattleFormation_DrawAttributes:
    ; in:  XA should point to the formation attributes lut (see BattleFormation_PrepAttributeLutsToXA)
    PHA
    TXA
    PHA
    JSR ReadAttributesFromPPU
    PLA
    TAX
    PLA
    JSR BattleFormation_PrepAttributeLutsToXA
    LDY #(8*4)-1
    @loop:
        TYA
        AND #7              ; skip the 2 right-most attribute columns.
        CMP #5              ;   this is kind of hacky, but whatever
        BCS @continue
            JSR BattleFormation_GetAttributeByte
            STA btltmp_attr+8, Y
      @continue:
        DEY
        BPL @loop
    RTS
    
    
BattleFormation_DrawEnemies:
    ; in:  XA should point to the FormationPlacement lut
    @nt_lut  = btltmp+4
    @index   = btltmp+6
    @drawdst = btltmp+0     ; must be this -- this is what DrawSmallEnemy and DrawLargeEnemy require
    @drawpic = btltmp+2     ; ditto
    
    STA @nt_lut+0
    STX @nt_lut+1
    LDX #0
    STX @index
    
    @Loop:
        LDA @index
        TAX                 ; 1x index in X
        ASL A
        TAY                 ; 2x index in Y
        
        LDA (@nt_lut),Y     ; get the PPU address where this enemy should be drawn
        STA @drawdst+0
        INY
        LDA (@nt_lut),Y     ; if high byte is zero, that's the terminator, nothing left to draw
        BEQ @Exit           ;  This is where we escape the loop
        PHP                 ; back up N flag here (used to determine small/large enemy)
        AND #$7F            ; kill N flag bit
        STA @drawdst+1
        
        ; Does this enemy even exist?
        LDA btl_enemyIDs, X
        CMP #$FF
        BNE :+              ; If not, don't draw him.  Continue looping
            PLA             ; drop backed up status
            BNE @Next       ; will always branch (PHP never pushes zero)
        :
        
        ; which graphic to draw?  0 or 1?
        LDY #0
        LDA btl_enemygfxplt, X
        BPL :+
            INY
        :
        STY @drawpic
        
        ; small or large enemy?
        PLP                 ; restore backed up N flag
        BPL :+
            JSR DrawLargeEnemy
            JMP @Next
        :
            JSR DrawSmallEnemy
            
      @Next:
        INC @index
        JMP @Loop
  @Exit:
    RTS
    

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  DrawFormation_NonFiend  [$A43A :: 0x2E44A]
;;
;;  Draws NT and Attributes for the enemies for any battle formation type
;;  except for the Fiend/Chaos types
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

DrawFormation_NonFiend:
    LDA btl_battletype          ; get the battle type
    ASL A                       ; double it to use as an index in a LUT
    TAX
    
    LDA lut_DrawFormation_NonFiend, X   ; use LUT to get jump table address
    STA btltmp+$C
    LDA lut_DrawFormation_NonFiend+1, X
    STA btltmp+$D
    
    JMP (btltmp+$C)             ; jump to it
    
    
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  DrawFormation_9Small  [$A44C :: 0x2E45C]
;;
;;  Draws NT and Attributes for the enemies for the "9 small" formation type
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    
DrawFormation_9Small:
    LDX #>lut_FormationAttributes_9Small
    LDA #<lut_FormationAttributes_9Small
    JSR BattleFormation_DrawAttributes
    
    LDX #>lut_FormationPlacement_9Small
    LDA #<lut_FormationPlacement_9Small
    JSR BattleFormation_DrawEnemies
    
    ;JMP WriteAttributes_ClearUnusedEnStats
    JMP WriteAttributesToPPU
    
    
DrawFormation_4Large:
    LDX #>lut_FormationAttributes_4Large
    LDA #<lut_FormationAttributes_4Large
    JSR BattleFormation_DrawAttributes
    
    LDX #>lut_FormationPlacement_4Large
    LDA #<lut_FormationPlacement_4Large
    JSR BattleFormation_DrawEnemies
    
    ;JMP WriteAttributes_ClearUnusedEnStats
    JMP WriteAttributesToPPU

DrawFormation_Mix:
    LDX #>lut_FormationAttributes_Mix
    LDA #<lut_FormationAttributes_Mix
    JSR BattleFormation_DrawAttributes
    
    LDX #>lut_FormationPlacement_Mix
    LDA #<lut_FormationPlacement_Mix
    JSR BattleFormation_DrawEnemies
    
    ;JMP WriteAttributes_ClearUnusedEnStats
    JMP WriteAttributesToPPU
    
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  ReadAttributesFromPPU [$A6EB :: 0x2E6FB]
;;
;;  Reads the attribute table from PPU memory
;;  Stores it in btltmp_attr
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  
ReadAttributesFromPPU:
    LDA #<btltmp_attr       ; set dest pointer to btltmp_attr
    STA btltmp+4
    LDA #>btltmp_attr
    STA btltmp+5
    
    LDA #<$23C0             ; set src pointer to attribute table
    STA btltmp+6
    LDA #>$23C0
    STA btltmp+7
    
    LDA #$40                ; read $40 bytes
    STA btltmp+8
    
    JMP Battle_ReadPPUData_L    ; do the reading, and exit
    

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  WriteAttributesToPPU [$A702 :: 0x2E712]
;;
;;  Reads the data from btltmp_attr
;;  Write to the attribute table in PPU memory
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

WriteAttributesToPPU:
    LDA #<btltmp_attr       ; set source pointer
    STA btltmp+4
    LDA #>btltmp_attr
    STA btltmp+5
    
    LDA #<$23C0             ; set dest address
    STA btltmp+6
    LDA #>$23C0
    STA btltmp+7
    
    LDA #$40                ; copy 4 tiles
    STA btltmp+8
    
    ;LDA #BANK_THIS          ; from this bank (although it's actually from RAM, so this
    ;STA btltmp+9            ;   isn't strictly necessary)
    
    ;JMP Battle_WritePPUData_L   ; actually do the write, then exit
    ;RTS
    
    JSR Battle_WritePPUData_BankB
    LDA cur_bank
    CMP #$0C
    BNE TurnOffScreen_SetScroll
    RTS
    
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Battle_WritePPUData  [$F23E :: 0x3F24E]
;;
;;    Copies a block of data to PPU memory.  Note that no more than 256 bytes can be copied at a time
;;  with this routine
;;
;;  input:
;;     btltmp+4,5 = pointer to get data from
;;     btltmp+6,7 = the PPU address to write to
;;     btltmp+8   = the number of bytes to write
;;     btltmp+9   = the bank to swap in
;;
;;  This routine will swap back to the battle_bank prior to exiting
;;  It will also reset the scroll.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

Battle_WritePPUData_BankB:
  ;  LDA btltmp+9                ; swap in the desired bank
  ;  JSR SwapPRG_L
    
    JSR WaitForVBlank_L
    JSR SetBattlePPUAddr        ; use btltmp+6,7 to set PPU addr
    
    LDY #$00                    ; Y is loop up-counter
    LDX btltmp+8                ; X is loop down-counter
    
  @Loop:
      LDA (btltmp+4), Y         ; copy source data to PPU
      STA $2007
      INY
      DEX
      BNE @Loop
    
    RTS    
  ;  LDA battle_bank             ; swap battle_bank back in
  ;  JSR SwapPRG_L
    
TurnOffScreen_SetScroll:    
    LDA #$00                    ; reset scroll before exiting
    STA $2001
    STA $2005
    STA $2005
    RTS    
    
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  DrawSmallEnemy  [$A71E :: 0x2E72E]
;;
;;  Draws a small enemy graphic to the given nametable position.
;;  NT updates only, no attributes
;;
;;  input:
;;     btltmp+0,1   = PPU address to draw to
;;     btltmp+2     = zero or nonzero to indicate which small enemy to draw
;;
;;  This routine takes care not to modify A,X, but it DOES modify btltmp+0,1
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

DrawSmallEnemy:
    PHA
    TXA
    PHA                 ; backup A and X
    JSR WaitForVBlank_L ; wait for VBlank
    
    ; See which enemy graphic this tile is using.
    ;   Small enemy graphics start at tiles $12 and $22
    LDX #$12            ; start at tile $12
    LDA btltmp+2        ; see which graphic this enemy is using
    BEQ :+              ; if that graphic is not graphic 0...
      LDX #$22          ; then start at tile $22
      
  : LDA #$04
    STA btltmp+3        ; loop counter to draw each row
    
  @Loop:
      JSR SetPpuAddr_BtlTmp     ; set desired PPU addr
      JSR Draw4TilesFromX       ; draw one row of tiles for this enemy
      TXA
      PHA                       ; backup tile ID
      JSR BtlTmp_NextRow        ; update btltmp to point to next row
      PLA                       ; restore tile ID - note this backup and restore isn't strictly necessary because
      TAX                       ;  BtlTmp_NextRow does not modify X.  Maybe he did this "just in case"
      
      DEC btltmp+3              ; dec loop counter, and keep going until there are no more rows to draw
      BNE @Loop
      
    ; Restore backed up A,X before exiting
    PLA
    TAX
    PLA
    RTS
    
    
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  SetPpuAddr_BtlTmp  [$A745 :: 0x2E755]
;;
;;  Sets the PPU addr to whatever is in btltmp+0
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

SetPpuAddr_BtlTmp:
    LDA btltmp+1
    STA $2006
    LDA btltmp+0
    STA $2006
    RTS
    
    
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  BtlTmp_NextRow  [$A750 :: 0x2E760]
;;
;;  Assuming btltmp+0 contains a PPU address, this routine increments that
;;  updates that address to point to the next row of tiles
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

BtlTmp_NextRow:
    LDA #$20            ; simply add $20 to the value stored in btltmp
    CLC
    ADC btltmp+0
    STA btltmp+0
    LDA #$00
    ADC btltmp+1
    STA btltmp+1
    RTS
    
    
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  DrawLargeEnemy  [$A75E :: 0x2E76E]
;;
;;  Draws a large enemy graphic to the given nametable position.
;;  NT updates only, no attributes
;;
;;  input:
;;     btltmp+0,1   = PPU address to draw to
;;     btltmp+2     = zero or nonzero to indicate which small enemy to draw
;;
;;  This routine is identical to DrawSmallEnemy, only it draws a 6x6 image
;;     instead of a 4x4 image.  See DrawSmallEnemy for details -- comments here
;;     will be sparse.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    
DrawLargeEnemy:
    PHA
    TXA
    PHA
    JSR WaitForVBlank_L
    LDX #$32                ; image 0 starts at tile $32
    LDA btltmp+2
    BEQ :+
      LDX #$56              ; image 1 starts at tile $56
      
  : LDA #$06                ; 6 rows
    STA btltmp+3
  @Loop:
      JSR SetPpuAddr_BtlTmp
      JSR Draw6TilesFromX   ; 6 tiles in each row
      TXA
      PHA
      JSR BtlTmp_NextRow
      PLA
      TAX
      DEC btltmp+3
      BNE @Loop
      
    PLA
    TAX
    PLA
    RTS
    
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Draw Tiles From 'X' [$A785 :: 0x2E795]
;;
;;    These routines draw 6 or 4 tiles to the PPU, starting with tile 'X'
;;  and incrementing X between each draw.
;;
;;    This is used to draw an individual row of tiles for enemies.  6 bytes being for large
;;  enemies, and 4 bytes being for small enemies.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    
Draw6TilesFromX:
    STX $2007
    INX
    STX $2007
    INX
    
Draw4TilesFromX:
    STX $2007
    INX
    STX $2007
    INX
    STX $2007
    INX
    STX $2007
    INX
    RTS
    
    
    
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  LUT for enemy counts for battle formation types  [$A79E :: 0x2E7AE]
;;
;;    This table indicates how many large/small enemies you use in a given formation type.
;;  Though it only seems to be used for formation types 0,1
;;
;;    There is unnecessary padding here and there seems to be an entry for formation type 2
;;  But it is messed up and not actually used by the game.
    
lut_EnemyCountByBattleType:
  .BYTE 9, 0, 0, 0   ; <- formation type 0
  .BYTE 0, 4, 0, 0   ; <- formation type 1
  .BYTE 2, 6, 0, 0   ; <- *almost* formation type 2, but it is not used and it has large/small values backwards
;       ^  ^  ^  ^
;       |  |  |  |
;       |  |  ??????  not used?
;       |  large enemies
;       small enemies  
  
  
  
  
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Jumptable lut for drawing non-fiend formations  [$A7AA :: 0x2E7BA]
;;
;;  Pretty self-explanitory.  See DrawFormation_NonFiend for usage

lut_DrawFormation_NonFiend:
  .WORD DrawFormation_9Small
  .WORD DrawFormation_4Large
  .WORD DrawFormation_Mix
  
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Increment Y routines  [$A7B0 :: 0x2E7C0]
;;
;;    These routines just add a fixed value to Y and then return
  
;IncYBy8:        ; this is never actually used
;    INY
  
IncYBy7:
    INY
    INY
    INY
    
IncYBy4:
    INY
    INY
    INY
    INY
    RTS
    
    
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  WriteAttributes_ClearUnusedEnStats  [$A7B9 :: 0x2E7C9]
;;
;;  This is a weird compound routine that does two things that really have no reason
;;    to be done together.  It's just miscellaneous battle prep.
;;
;;  This routine will write btltmp_attr back to the PPU attribute tables,
;;  then it will iterate over btl_enemystats and zero stats for enemies that are unused.
;;
;;  Why clearing of unused enemies isn't done with the same code that initialized used
;;   enemy stats is a mystery to me.  That would have made a lot more sense.
;;   But even if it did... enemy stats were already cleared by PrepareEnemyFormation's
;;   blanket RAM clearing, so clearing it again here is entirely pointless.
;;   But whatever.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; JIGS - seems pointless then...?
    
;WriteAttributes_ClearUnusedEnStats:
;    JSR WriteAttributesToPPU
;    
;    LDA #$00
;    STA btltmp+2            ; loop up-counter - the current enemy we're looking at
;    
;  @EnemyLoop:
;    LDY btltmp+2
;    LDA btl_enemyIDs, Y     ; get current enemy ID
;    CMP #$FF
;    BNE @NextEnemy          ; if it's actually being used, then skip it.  Otherwise...
;    
;    LDA btltmp+2
;    JSR GetEnemyStatPtr     ; Get the stat pointer for this enemy, put it in btltmp+0
;    STA btltmp+0
;    STX btltmp+1
;    
;    LDY #$00                ; copy $14 bytes of 0 to this enemy's stats
;    LDX #$14
;    LDA #$00
;  @Loop:
;      STA (btltmp+0), Y
;      INY
;      DEX
;      BNE @Loop
;      
;  @NextEnemy:
;    INC btltmp+2            ; increment our enemy counter
;    LDA btltmp+2
;    CMP #$09
;    BNE @EnemyLoop          ; loop until all 9 enemies processed
;    
;    RTS
    
    
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  GetEnemyStatPtr  [$A7E7 :: 0x2E7F7]
;;
;;  input:
;;      A = desired enemy index  (0-8)
;;
;;  output:
;;      XA = pointer to that enemy's stats in RAM
;;
;;  This seems like a useful routine, but it only is used in 1 place?
;;   Looks like this routine is duplicated in bank C, where it is used much more.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    
GetEnemyStatPtr:
    LDX #$14                ; multiply enemy index by $14  (number of bytes per enemy)
    JSR MultiplyXA
    CLC                     ; then add btl_enemystats to the result
    ADC #<btl_enemystats
    PHA
    TXA
    ADC #>btl_enemystats
    TAX
    PLA
    RTS
    
    
    
    
    
    
    
    
    
RestoreCharacterBattleStats:
    LDA #$00                
    JSR RestoreOneCharacterBattleStats
    LDA #$01
    JSR RestoreOneCharacterBattleStats
    LDA #$02
    JSR RestoreOneCharacterBattleStats
    LDA #$03

RestoreOneCharacterBattleStats:
    JSR PrepCharStatPointers        ; prep stat pointers
    
    LDY #ch_intelligence_backup - ch_backupstats
    LDA #ch_intelligence - ch_stats
    JSR TransferByteBack
    
    LDY #ch_speed_backup - ch_backupstats
    LDA #ch_speed - ch_stats
    JSR TransferByteBack
    
    LDY #ch_damage_backup - ch_backupstats
    LDA #ch_damage - ch_stats
    JSR TransferByteBack
    
    LDY #ch_hitrate_backup - ch_backupstats
    LDA #ch_hitrate - ch_stats
    JSR TransferByteBack
    
    LDY #ch_defense_backup - ch_backupstats
    LDA #ch_defense - ch_stats
    JSR TransferByteBack
    
    LDY #ch_evasion_backup - ch_backupstats
    LDA #ch_evasion - ch_stats
    JSR TransferByteBack
    
    LDY #ch_magicdefense_backup - ch_backupstats
    LDA #ch_magicdefense - ch_stats
    JSR TransferByteBack
    
    LDY #ch_elementresist_backup - ch_backupstats
    LDA #ch_elementresist - ch_stats
    JSR TransferByteBack
    
    LDA #ch_elementweak - ch_stats
    LDY #ch_elementweak_backup - ch_backupstats
    JSR TransferByteBack
    
    LDA #ch_weaponelement - ch_stats
    LDY #ch_weaponelement_backup - ch_backupstats
    JSR TransferByteBack
    
    LDA #ch_weaponcategory - ch_stats
    LDY #ch_weaponcategory_backup - ch_backupstats
    JSR TransferByteBack
    
    LDA #ch_numhits - ch_stats
    LDY #ch_numhits_backup - ch_backupstats
    JSR TransferByteBack

    LDA #ch_numhitsmult - ch_stats
    LDY #ch_numhitsmult_backup - ch_backupstats
    JSR TransferByteBack

    LDA #ch_critrate - ch_stats
    LDY #ch_critrate_backup - ch_backupstats
    
  TransferByteBack:
    PHA                             ; backup A
    LDA (CharBackupStatsPointer), Y ; Load the source stat
    TAX                             ; stick it in X
    PLA                             ; restore A, put in Y
    TAY
    TXA                             ; get the source stat
    STA (CharStatsPointer), Y       ; write it to the dest
    RTS  
    
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
  
lut_IBCharStatsPtrTable:
  .WORD ch_backupstats
  .WORD ch_backupstats + (1*$10)
  .WORD ch_backupstats + (2*$10)
  .WORD ch_backupstats + (3*$10)    
    
    
    
    
    
  
  

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Epilogue/Bridge scene CHR and NT  [$A800 :: 0x2E810]
;;
;;

data_EpilogueCHR:
  .INCBIN "chr/endingbridge_chrnt.bin"
  
data_EpilogueNT =       data_EpilogueCHR + $800         ; $B000
data_BridgeCHR  =       data_EpilogueNT  + $400         ; $B400
data_BridgeNT   =       data_BridgeCHR   + $800         ; $BC00

.byte "END OF BANK B"