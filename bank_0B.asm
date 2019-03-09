.include "variables.inc"
.include "macros.inc"
.include "Constants.inc"

.export data_EnemyNames
.export PrepBattleVarsAndEnterBattle_L
.export lut_BattleRates
.export lut_BattleFormations
.export BattleOver_ProcessResult_L
.export data_EpilogueCHR
.export data_EpilogueNT
.export data_BridgeCHR
.export data_BridgeNT
.export PrintEXPToNext_B

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

.segment "BANK_0B"

BANK_THIS = $0B

.INCBIN "bin/0B_8000_battledomaindata.bin"

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  LUT for battle formations  [$8400 :: 0x2C410]
;;
;;    The table containing which enemies you fight, how many of them there are,
;;  what palettes to use, etc, etc.

.ALIGN $100            ; must be on page bound
lut_BattleFormations:
  .INCBIN "bin/0B_8400_battleformations.bin"


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  LUT for battle encounter rates per map  [$8C00 :: 0x2CC10]

lut_BattleRates:
  .INCBIN "bin/0B_8C00_mapencounterrates.bin"


 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Exp to advance to the next level  [$9000 :: 0x2D010]

lut_ExpToAdvance:
  .FARADDR     40,    196,    547,   1171,   2146,   3550,   5461,   7957,  11116,  15016
  .FARADDR  19735,  25351,  31942,  39586,  48361,  58345,  69617,  82253,  96332, 111932
  .FARADDR 129131, 148008, 168639, 191103, 215479, 241843, 270275, 300851, 333651, 366450
  .FARADDR 399250, 432049, 464849, 497648, 530448, 563247, 596047, 628846, 661646, 694445
  .FARADDR 727245, 760044, 792844, 825643, 858443, 891242, 924042, 956841, 989641 
  .byte $00 ; <--level 50!?

  ;.byte $00,$00,$40 ; level 2
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
;  .INCBIN "bin/0B_9094_levelupdata.bin"

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
.byte %00000111, %01010001 ; Level 34
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
.byte %00000111, %01010001 ; Level 34
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
  .INCBIN "bin/0B_92E0_fiendtsa.bin"
  
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;  Fiend TSA data  [$9420 :: 0x2D430]
;;
;;    $C0 bytes of TSA for chaos
;;      $A8 bytes of NT TSA (14x12 image)
;;      $10 bytes of attributes  (4x4)
;;      $08 bytes of padding
data_ChaosTSA:
  .INCBIN "bin/0B_9420_chaostsa.bin"

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;  Enemy names [$94E0 :: 0x2D4F0]
data_EnemyNames:
  ;.INCBIN "bin/0B_94E0_enemynames.bin"

.word ENEMYNAME1  
.word ENEMYNAME2  
.word ENEMYNAME3  
.word ENEMYNAME4  
.word ENEMYNAME5  
.word ENEMYNAME6  
.word ENEMYNAME7  
.word ENEMYNAME8  
.word ENEMYNAME9  
.word ENEMYNAME10 
.word ENEMYNAME11 
.word ENEMYNAME12 
.word ENEMYNAME13 
.word ENEMYNAME14 
.word ENEMYNAME15 
.word ENEMYNAME16 
.word ENEMYNAME17 
.word ENEMYNAME18 
.word ENEMYNAME19 
.word ENEMYNAME20 
.word ENEMYNAME21 
.word ENEMYNAME22 
.word ENEMYNAME23 
.word ENEMYNAME24 
.word ENEMYNAME25 
.word ENEMYNAME26 
.word ENEMYNAME27 
.word ENEMYNAME28 
.word ENEMYNAME29 
.word ENEMYNAME30 
.word ENEMYNAME31 
.word ENEMYNAME32 
.word ENEMYNAME33 
.word ENEMYNAME34 
.word ENEMYNAME35 
.word ENEMYNAME36 
.word ENEMYNAME37 
.word ENEMYNAME38 
.word ENEMYNAME39 
.word ENEMYNAME40 
.word ENEMYNAME41 
.word ENEMYNAME42 
.word ENEMYNAME43 
.word ENEMYNAME44 
.word ENEMYNAME45 
.word ENEMYNAME46 
.word ENEMYNAME47 
.word ENEMYNAME48 
.word ENEMYNAME49 
.word ENEMYNAME50 
.word ENEMYNAME51 
.word ENEMYNAME52 
.word ENEMYNAME53 
.word ENEMYNAME54 
.word ENEMYNAME55 
.word ENEMYNAME56 
.word ENEMYNAME57 
.word ENEMYNAME58 
.word ENEMYNAME59 
.word ENEMYNAME60 
.word ENEMYNAME61 
.word ENEMYNAME62 
.word ENEMYNAME63 
.word ENEMYNAME64 
.word ENEMYNAME65 
.word ENEMYNAME66 
.word ENEMYNAME67 
.word ENEMYNAME68 
.word ENEMYNAME69 
.word ENEMYNAME70 
.word ENEMYNAME71 
.word ENEMYNAME72 
.word ENEMYNAME73 
.word ENEMYNAME74 
.word ENEMYNAME75 
.word ENEMYNAME76 
.word ENEMYNAME77 
.word ENEMYNAME78 
.word ENEMYNAME79 
.word ENEMYNAME80 
.word ENEMYNAME81 
.word ENEMYNAME82 
.word ENEMYNAME83 
.word ENEMYNAME84 
.word ENEMYNAME85 
.word ENEMYNAME86 
.word ENEMYNAME87 
.word ENEMYNAME88 
.word ENEMYNAME89 
.word ENEMYNAME90 
.word ENEMYNAME91 
.word ENEMYNAME92 
.word ENEMYNAME93 
.word ENEMYNAME94 
.word ENEMYNAME95 
.word ENEMYNAME96 
.word ENEMYNAME97 
.word ENEMYNAME98 
.word ENEMYNAME99 
.word ENEMYNAME100
.word ENEMYNAME101
.word ENEMYNAME102
.word ENEMYNAME103
.word ENEMYNAME104
.word ENEMYNAME105
.word ENEMYNAME106
.word ENEMYNAME107
.word ENEMYNAME108
.word ENEMYNAME109
.word ENEMYNAME110
.word ENEMYNAME111
.word ENEMYNAME112
.word ENEMYNAME113
.word ENEMYNAME114
.word ENEMYNAME115
.word ENEMYNAME116
.word ENEMYNAME117
.word ENEMYNAME118
.word ENEMYNAME119
.word ENEMYNAME120
.word ENEMYNAME121
.word ENEMYNAME122
.word ENEMYNAME123
.word ENEMYNAME124
.word ENEMYNAME125
.word ENEMYNAME126
.word ENEMYNAME127
.word ENEMYNAME128


ENEMYNAME1:
.byte $92,$96,$99,$00                       ; IMP	
ENEMYNAME2:
.byte $90,$B5,$92,$96,$99,$00               ; GrIMP	
ENEMYNAME3:
.byte $A0,$98,$95,$8F,$00                   ; WOLF	
ENEMYNAME4:
.byte $90,$B5,$A0,$98,$95,$8F,$00           ; GrWolf	
ENEMYNAME5:
.byte $A0,$B5,$A0,$98,$95,$8F,$00           ; WrWolf     
ENEMYNAME6:
.byte $8F,$B5,$A0,$98,$95,$8F,$00           ; FrWOLF     
ENEMYNAME7:
.byte $92,$90,$9E,$8A,$97,$8A,$00           ; IGUANA     
ENEMYNAME8:
.byte $8A,$90,$8A,$96,$8A,$00               ; AGAMA
ENEMYNAME9:
.byte $9C,$8A,$9E,$9B,$92,$8A,$00           ; SAURIA
ENEMYNAME10:
.byte $90,$92,$8A,$97,$9D,$00               ; GIANT
ENEMYNAME11:
.byte $8F,$B5,$90,$92,$8A,$97,$9D,$00       ; FrGIANT
ENEMYNAME12:
.byte $9B,$C0,$90,$92,$8A,$97,$9D,$00       ; R.GIANT
ENEMYNAME13:
.byte $9C,$8A,$91,$8A,$90,$00               ; SAHAG
ENEMYNAME14:
.byte $9B,$C0,$9C,$8A,$91,$8A,$90,$00       ; R.SAHAG
ENEMYNAME15:
.byte $A0,$BD,$9C,$8A,$91,$8A,$90,$00       ; WzSAHAG
ENEMYNAME16:
.byte $99,$92,$9B,$8A,$9D,$8E,$00           ; PIRATE
ENEMYNAME17:
.byte $94,$A2,$A3,$98,$94,$9E,$00           ; KYZOKU
ENEMYNAME18:
.byte $9C,$91,$8A,$9B,$94,$00               ; SHARK
ENEMYNAME19:
.byte $90,$B5,$9C,$91,$8A,$9B,$94,$00       ; GrSHARK
ENEMYNAME20:
.byte $98,$A7,$A7,$8E,$A2,$8E,$00           ; OddEYE
ENEMYNAME21:
.byte $8B,$AC,$AA,$8E,$A2,$8E,$00           ; BigEYE
ENEMYNAME22:
.byte $8B,$98,$97,$8E,$00                   ; BONE
ENEMYNAME23:
.byte $9B,$C0,$8B,$98,$97,$8E,$00           ; R.BONE
ENEMYNAME24:
.byte $8C,$9B,$8E,$8E,$99,$00               ; CREEP
ENEMYNAME25:
.byte $8C,$9B,$8A,$A0,$95,$00               ; CRAWL
ENEMYNAME26:
.byte $91,$A2,$8E,$97,$8A,$00               ; HYENA
ENEMYNAME27:
.byte $8C,$8E,$9B,$8E,$8B,$9E,$9C,$00       ; CEREBUS
ENEMYNAME28:
.byte $98,$90,$9B,$8E,$00                   ; OGRE
ENEMYNAME29:
.byte $90,$B5,$98,$90,$9B,$8E,$00           ; GrOGRE
ENEMYNAME30:
.byte $A0,$BD,$98,$90,$9B,$8E,$00           ; WzOGRE
ENEMYNAME31:
.byte $8A,$9C,$99,$00                       ; ASP
ENEMYNAME32:
.byte $8C,$98,$8B,$9B,$8A,$00               ; COBRA
ENEMYNAME33:
.byte $9C,$A8,$A4,$9C,$97,$8A,$94,$8E,$00   ; SeaSNAKE
ENEMYNAME34:
.byte $9C,$8C,$98,$9B,$99,$92,$98,$97,$00   ; SCORPION
ENEMYNAME35:
.byte $95,$98,$8B,$9C,$9D,$8E,$9B,$00       ; LOBSTER
ENEMYNAME36:
.byte $8B,$9E,$95,$95,$00                   ; BULL
ENEMYNAME37:
.byte $A3,$B2,$B0,$8B,$9E,$95,$95,$00       ; ZomBULL
ENEMYNAME38:
.byte $9D,$9B,$98,$95,$95,$00               ; TROLL
ENEMYNAME39:
.byte $9C,$A8,$A4,$9D,$9B,$98,$95,$95,$00   ; SeaTROLL
ENEMYNAME40:
.byte $9C,$91,$8A,$8D,$98,$A0,$00           ; SHADOW
ENEMYNAME41:
.byte $92,$96,$8A,$90,$8E,$00               ; IMAGE
ENEMYNAME42:
.byte $A0,$9B,$8A,$92,$9D,$91,$00           ; WRAITH
ENEMYNAME43:
.byte $90,$91,$98,$9C,$9D,$00               ; GHOST
ENEMYNAME44:
.byte $A3,$98,$96,$8B,$92,$8E,$00           ; ZOMBIE
ENEMYNAME45:
.byte $90,$91,$98,$9E,$95,$00               ; GHOUL 
ENEMYNAME46:
.byte $90,$8E,$92,$9C,$9D,$00               ; GEIST
ENEMYNAME47:
.byte $9C,$99,$8E,$8C,$9D,$8E,$9B,$00       ; SPECTER
ENEMYNAME48:
.byte $A0,$98,$9B,$96,$00                   ; WORM
ENEMYNAME49:
.byte $9C,$A4,$B1,$A7,$FF,$A0,$00           ; Sand W
ENEMYNAME50:
.byte $90,$B5,$A8,$BC,$FF,$A0,$00           ; Grey W
ENEMYNAME51:
.byte $8E,$A2,$8E,$00                       ; EYE
ENEMYNAME52:
.byte $99,$91,$8A,$97,$9D,$98,$96,$00       ; PHANTOM
ENEMYNAME53:
.byte $96,$8E,$8D,$9E,$9C,$8A,$00           ; MEDUSA
ENEMYNAME54:
.byte $90,$B5,$96,$8E,$8D,$9E,$9C,$8A,$00   ; GrMEDUSA
ENEMYNAME55:
.byte $8C,$8A,$9D,$96,$8A,$97,$00           ; CATMAN
ENEMYNAME56:
.byte $96,$8A,$97,$8C,$8A,$9D,$00           ; MANCAT
ENEMYNAME57:
.byte $99,$8E,$8D,$8E,$00                   ; PEDE
ENEMYNAME58:
.byte $90,$B5,$99,$8E,$8D,$8E,$00           ; GrPEDE
ENEMYNAME59:
.byte $9D,$92,$90,$8E,$9B,$00               ; TIGER
ENEMYNAME60:
.byte $9C,$A4,$A5,$A8,$B5,$FF,$9D,$00       ; Saber T
ENEMYNAME61:
.byte $9F,$8A,$96,$99,$92,$9B,$8E,$00       ; VAMPIRE
ENEMYNAME62:
.byte $A0,$BD,$9F,$8A,$96,$99,$00           ; WzVAMP
ENEMYNAME63:
.byte $90,$8A,$9B,$90,$98,$A2,$95,$8E,$00   ; GARGOYLE
ENEMYNAME64:
.byte $9B,$C0,$90,$98,$A2,$95,$8E,$00       ; R.GOYLE
ENEMYNAME65:
.byte $8E,$8A,$9B,$9D,$91,$00               ; EARTH
ENEMYNAME66:
.byte $8F,$92,$9B,$8E,$00                   ; FIRE
ENEMYNAME67:
.byte $8F,$B5,$B2,$B6,$B7,$FF,$8D,$00       ; Frost D
ENEMYNAME68:
.byte $9B,$A8,$A7,$FF,$8D,$00               ; Red D
ENEMYNAME69:
.byte $A3,$B2,$B0,$A5,$AC,$A8,$8D,$00       ; ZombieD
ENEMYNAME70:
.byte $9C,$8C,$9E,$96,$00                   ; SCUM
ENEMYNAME71:
.byte $96,$9E,$8C,$94,$00                   ; MUCK
ENEMYNAME72:
.byte $98,$98,$A3,$8E,$00                   ; OOZE
ENEMYNAME73:
.byte $9C,$95,$92,$96,$8E,$00               ; SLIME
ENEMYNAME74:
.byte $9C,$99,$92,$8D,$8E,$9B,$00           ; SPIDER
ENEMYNAME75:
.byte $8A,$9B,$8A,$8C,$91,$97,$92,$8D,$00   ; ARACHNID
ENEMYNAME76:
.byte $96,$8A,$97,$9D,$92,$8C,$98,$9B,$00   ; MATICOR
ENEMYNAME77:
.byte $9C,$99,$91,$92,$97,$A1,$00           ; SPHINX
ENEMYNAME78:
.byte $9B,$C0,$8A,$97,$94,$A2,$95,$98,$00   ; R.ANKYLO
ENEMYNAME79:
.byte $8A,$97,$94,$A2,$95,$98,$00           ; ANKYLO
ENEMYNAME80:
.byte $96,$9E,$96,$96,$A2,$00               ; MUMMY
ENEMYNAME81:
.byte $A0,$BD,$96,$9E,$96,$96,$A2,$00       ; WzMUMMY
ENEMYNAME82:
.byte $8C,$98,$8C,$9D,$9B,$92,$8C,$8E,$00   ; COCTRICE
ENEMYNAME83:
.byte $99,$8E,$9B,$92,$95,$92,$9C,$94,$00   ; PERILISK
ENEMYNAME84:
.byte $A0,$A2,$9F,$8E,$9B,$97,$00           ; WYVERN
ENEMYNAME85:
.byte $A0,$A2,$9B,$96,$00                   ; WYRM
ENEMYNAME86:
.byte $9D,$A2,$9B,$98,$00                   ; TYRO
ENEMYNAME87:
.byte $9D,$FF,$9B,$8E,$A1,$00               ; T REX
ENEMYNAME88:
.byte $8C,$8A,$9B,$92,$8B,$8E,$00           ; CARIBE
ENEMYNAME89:
.byte $9B,$C0,$8C,$8A,$9B,$92,$8B,$8E,$00   ; R.CARIBE
ENEMYNAME90:
.byte $90,$8A,$9D,$98,$9B,$00               ; GATOR
ENEMYNAME91:
.byte $8F,$B5,$90,$8A,$9D,$98,$9B,$00       ; FrGATOR
ENEMYNAME92:
.byte $98,$8C,$91,$98,$00                   ; OCHO
ENEMYNAME93:
.byte $97,$8A,$98,$8C,$91,$98,$00           ; NAOCHO
ENEMYNAME94:
.byte $91,$A2,$8D,$9B,$8A,$00               ; HYDRA
ENEMYNAME95:
.byte $9B,$C0,$91,$A2,$8D,$9B,$8A,$00       ; R.HYDRA
ENEMYNAME96:
.byte $90,$9E,$8A,$9B,$8D,$00               ; GAURD
ENEMYNAME97:
.byte $9C,$8E,$97,$9D,$9B,$A2,$00           ; SENTRY
ENEMYNAME98:
.byte $A0,$8A,$9D,$8E,$9B,$00               ; WATER
ENEMYNAME99:
.byte $8A,$92,$9B,$00                       ; AIR
ENEMYNAME100:
.byte $97,$8A,$90,$8A,$00                   ; NAGA
ENEMYNAME101:
.byte $90,$B5,$97,$8A,$90,$8A,$00           ; GrNAGA
ENEMYNAME102:
.byte $8C,$91,$92,$96,$8E,$9B,$8A,$00       ; CHIMERA
ENEMYNAME103:
.byte $93,$92,$96,$8E,$9B,$8A,$00           ; JIMERA
ENEMYNAME104:
.byte $A0,$92,$A3,$8A,$9B,$8D,$00           ; WIZARD
ENEMYNAME105:
.byte $9C,$98,$9B,$8C,$8E,$9B,$8E,$9B,$00   ; SORCERER
ENEMYNAME106:
.byte $90,$8A,$9B,$95,$8A,$97,$8D,$00       ; GARLAND
ENEMYNAME107:
.byte $90,$A4,$B6,$FF,$8D,$00               ; Gas D
ENEMYNAME108:
.byte $8B,$AF,$B8,$A8,$FF,$8D,$00           ; Blue D
ENEMYNAME109:
.byte $96,$B8,$A7,$90,$98,$95,$00           ; MudGOL
ENEMYNAME110:
.byte $9B,$B2,$A6,$AE,$90,$98,$95,$00       ; RockGOL
ENEMYNAME111:
.byte $92,$B5,$B2,$B1,$90,$98,$95,$00       ; IronGOL
ENEMYNAME112:
.byte $8B,$8A,$8D,$96,$8A,$97,$00           ; BADMAN
ENEMYNAME113:
.byte $8E,$9F,$92,$95,$96,$8A,$97,$00       ; EVILMAN
ENEMYNAME114:
.byte $8A,$9C,$9D,$98,$9C,$00               ; ASTOS
ENEMYNAME115:
.byte $96,$8A,$90,$8E,$00                   ; MAGE
ENEMYNAME116:
.byte $8F,$92,$90,$91,$9D,$8E,$9B,$00       ; FIGHTER
ENEMYNAME117:
.byte $96,$8A,$8D,$99,$98,$97,$A2,$00        ; MADPONY
ENEMYNAME118:
.byte $97,$92,$9D,$8E,$96,$8A,$9B,$8E,$00    ; NITEMARE
ENEMYNAME119:
.byte $A0,$A4,$B5,$96,$8E,$8C,$91,$00        ; WarMECH
ENEMYNAME120:
.byte $95,$92,$8C,$91,$00                    ; LICH
ENEMYNAME121:
.byte $95,$92,$8C,$91,$00                    ; LICH (reprise)
ENEMYNAME122:
.byte $94,$8A,$9B,$A2,$00                    ; KARY
ENEMYNAME123:
.byte $94,$8A,$9B,$A2,$00                    ; KARY (reprise)
ENEMYNAME124:
.byte $94,$9B,$8A,$94,$8E,$97,$00            ; KRAKEN
ENEMYNAME125:
.byte $94,$9B,$8A,$94,$8E,$97,$00            ; KRAKEN (reprise)
ENEMYNAME126:
.byte $9D,$92,$8A,$96,$8A,$9D,$00            ; TIAMAT
ENEMYNAME127:
.byte $9D,$92,$8A,$96,$8A,$9D,$00            ; TIAMAT (reprise)
ENEMYNAME128:
.byte $8C,$91,$8A,$98,$9C,$00                ; CHAOS  

  

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;  Misc End-Of-Battle text [$9950 :: 0x2D960]
;;
;;    I don't know why these strings are stored here and not with the rest of the
;;  end of battle strings at $A00E.  Whatever.

       ; eobtext_print_level = $687A
       ; eobtext_print_hp    = $687C

eobtext_NameLN:
  .BYTE $02, $FF, $95, $0C
  .WORD eobtext_print_level
  .BYTE $00                                 ; "<Name> L##", where <Name> is btl_attacker's name and ## is value at $687A
eobtext_HPMax:
  .BYTE $0F, $31, $00                       ; "HP max"
eobtext_Npts:
  .BYTE $0C
  .WORD eobtext_print_hp
  .BYTE $0F, $32, $00                       ; "##pts." where ## is value at $687C
eobtext_PartyPerished:
  .BYTE $04, $0F, $3E, $0F, $3C, $00        ; "<Name> party perished", where <Name> is the party leader's name
  
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
    AND #$0F             ;; JIGS - cut off high bits (sprite)
    CMP #CLS_BB
    BEQ :+
    CMP #CLS_MA
    BEQ :+                          ; if yes, jump ahead, otherwise just exit
  @Exit:
    RTS

  : LDY #ch_righthand - ch_stats    ; see if they have any weapon equipped.
    LDA (lvlup_chstats), Y          ; check all 4 weapon slots, if any of them have an
    BEQ @Exit                       ; equipped weapon, exit
  ;  INY
  ;  LDA (lvlup_chstats), Y
  ;  BMI @Exit
  ;  INY
  ;  LDA (lvlup_chstats), Y
  ;  BMI @Exit
  ;  INY
  ;  LDA (lvlup_chstats), Y
  ;  BMI @Exit
    
    LDY #ch_level - ch_stats        ; reaches here if no weapon equipped.  Get the level
    LDA (lvlup_chstats), Y          ;  Add 1 to make it 1-based
    CLC
    ADC #$01
    ;LDY #ch_defense - ch_stats       ; Absorb = Level -- BUGGED:  This is the infamous BB Armor Bug
    ;STA (lvlup_chstats), Y          ;   This should only happen if the character has no ARMOR equipped.
                                    ;   Weapons shouldn't matter.  This cannot be easily fixed here,
                                    ;   as you'd pretty much have to write a new routine.
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
    
    LDY #ch_level - ch_stats        ; reaches here if no weapon equipped.  Get the level
    LDA (lvlup_chstats), Y          ;  Add 1 to make it 1-based
    CLC
    ADC #$01
    ASL A
    LDY #ch_defense - ch_stats       ; Absorb = Level -- BUGGED:  This is the infamous BB Armor Bug
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
    LDA #$00
    STA btl_soft2000            ; clear soft PPU regs
    STA btl_soft2001
    
    LDA #$50
    STA a:music_track           ; set music track and followup
    STA btl_followupmusic
    
    LDY a:respondrate
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
    
    LDA #$06
    JMP DoCrossPageJump         ; jump to FinishBattlePrepAndFadeIn in bank C

  
    
    

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
    .BYTE   $78, $50, $3C, $2D, $1E, $0F, $05, $01
    
    

    
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
    STA a:cur_bank
    
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
    
    LDA a:btlformation      ; check the formation ID
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
    JSR Battle_FlipAllChars         ; Flip all chars so they look like they're running away.
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
    STA a:music_track           ; Play the sad "game over" music
    STA btl_followupmusic
    
    LDA #$00
    STA btl_combatboxcount      ; reset combat box count
    
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
    STA btl_combatboxcount          ; clear combat box count
    
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
      STA a:cur_bank
      
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
      LDA btl_enemystats, Y     ; sum low byte
      ADC battlereward
      STA battlereward
      
      LDA btl_enemystats+1, Y   ; high byte
      ADC battlereward+1
      STA battlereward+1
      
      LDA battlereward+2        ; carry into 3rd byte - This is used for GP but not for Exp
      ADC #$00
      STA battlereward+2
      
      CLC
      TYA                       ; it assumes C is clear here, since sum cannot be over $FFFFFF
      ADC #28                  ;  add $14 to source index to move to next enemy ($14 bytes per enemy)
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
      LDA btl_enemystats, Y     ; sum low byte
      ADC battlereward
      STA battlereward
      
      LDA btl_enemystats+1, Y   ; high byte
      ADC battlereward+1
      STA battlereward+1
      
      LDA battlereward+2        ; carry into 3rd byte - This is used for GP but not for Exp
      ADC #$00
      STA battlereward+2
      
      CLC
      TYA                       ; it assumes C is clear here, since sum cannot be over $FFFFFF
      ADC #28                  ;  add $14 to source index to move to next enemy ($14 bytes per enemy)
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
    STA a:cur_bank          ; seems weird to do this here...
    
    TXA                     ; Get the EOB string ID to print
    ASL A                   ; x2 to use as index
    
    TAY
    LDX lut_EOBText, Y      ; load pointer from lut
    LDA lut_EOBText+1, Y    ; and put in YX
    TAY
    
    LDA EOBCombatBox_tmp               ; restore combo box ID in A
    JSR DrawCombatBox_L     ; A = box ID, YX = pointer to string
    
    INC btl_combatboxcount  ; count this combat box
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
    LDA btl_combatboxcount
    JSR UndrawNBattleBlocks_L
    LDA #$00
    STA btl_combatboxcount
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
    STA a:cur_bank
    
    LDA a:music_track       ; check this track
    BPL :+                  ; if it's finished...
      LDA btl_followupmusic ;   ... load followup music
      STA a:music_track     ;   and play it   (not sure why this is necessary)
      
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
  .WORD eobtext_NameLN          ; 6
  .WORD eobtext_HPMax           ; 7
  .WORD eobtext_Npts            ; 8
  .WORD eobtext_PartyPerished   ; 9
  
  @MnstPrsh: .BYTE $0F, $3D, $0F, $3C, $00      ; "Monsters perished"
  @ExpUp:    .BYTE $0F, $49, $00                ; "EXP up"
  @ExpVal:   .BYTE $0C
             .WORD eob_exp_reward
             .BYTE $99, $00                     ; "##P"  where ## is the experience reward
  @Gold:     .BYTE $90, $98, $95, $8D, $00      ; "GOLD"
  @GoldVal:  .BYTE $0C
             .WORD eob_gp_reward
             .BYTE $90, $00, $00                ; "##G"   where ## is the GP reward
  @LevUp:    .BYTE $0F, $30, $00                ; "Lev. up!"


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
    STA a:music_track
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
      
    LDA a:btlformation          ; See if this is a B-formation
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
    
    CMP #$02
    BNE :+
      JMP PrepareEnemyFormation_Mix         ; type=2    : prepare the 'Mix' enemy formation
:   BCC PrepareEnemyFormation_SmallLarge    ; type=0,1  : prepare the '9Small' or '4Large' enemy formation
      JMP PrepareEnemyFormation_FiendChaos  ; type=3,4  : prepare the 'Fiend'/'Chaos' enemy formation
      
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
    CLC
    ROR A
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
    
    LDA btl_formdata, Y     ; pointless:  Get the ID of this enemy, but never use it
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
    STA btl_drawformationtmp                   ; 8 rows of tiles.  Used as loop down-counter
    
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
      JSR Battle_WritePPUData_L ; Do the PPU writing with the given params
      
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
      
      JSR Battle_WritePPUData_L ; do the actual drawing for this row
      
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
    LDA btlform_enids       ; Just use the first enemy ID as the only enemy in this formation
    STA btl_enemyIDs
    STA btl_enemyroster               ; ???  Duplicated to 6BC9?  Why?  I doubt this is ever used
    JMP WriteAttributes_ClearUnusedEnStats
    
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
    JSR ReadAttributesFromPPU       ; Read the attribute table into btltmp_attr
    LDA btl_enemycount
    STA btltmp+6                    ; put the number of enemies in btltmp+6, used as a loop counter
    
    LDX #$00
    LDY #$00
    STY btl_drawformationtmp           ; temporary counter:  how many enemies we have drawn
                        ;   which is confusing, because this is also stored in X for this routine
                        ;   This value and X are always in sync.
                        ; Best I can figure is X is the src counter, and $6BCF is the dest counter
                        ;  Though it is completely unnecessary to have both.
    
    
    ; Begin Loop to draw attributes for each enemy
    ; Since small enemies are 32x32 pixels, and each byte of the attribute table is 32x32 pixels, you'd think this
    ;   would be simple 1 byte = 1 enemy.  HOWEVER, this is complicated because the way the battlefield is set up,
    ;   enemies to not land on the 32x32 pixel boundary.  Rather, they land exactly between them both in the X and Y
    ;   direction
    ;
    ;   For example, ideally it'd work like this:
    ;
    ; AA|BB|CC     (each alphabetic character represents a 16x16 pixel block)
    ; AA|BB|CC     (A-F represent enemies)
    ; --+--+--     (lines are attribute byte boundaries)
    ; DD|EE|FF
    ; DD|EE|FF
    ;
    ;   But in actuality, it works like this:
    ;
    ; A|AB|BC|C
    ; -+--+--+-
    ; A|AB|BC|C
    ; D|DE|EF|F
    ; -+--+--+-
    ; D|DE|EF|F
    ;
    ;  This has the interesting effect of effectively reversing which 'sector' of the attribute byte the enemy
    ;   occupies.  Example:  the upper-left portion of the enemy occupies the lower-right portion of the attribute
    ;   byte (and vice versa)
    ;  It also means the enemies span 4 bytes of attributes rather than just 1 byte
    
@AttributeLoop:
    ;LDA $6BCF           ; pointless, not used
    
    TXA                 ; back up src enemy counter
    PHA
    
    LDX btl_drawformationtmp           ; get dst en counter
    LDA @lut_AttributeOffset, X
    TAY                 ; put offset to attribute data in Y
    
    PLA
    TAX                 ; retore src enemy counter
    LDA btl_enemygfxplt, X  ; get palette assignment for this enemy
    AND #$01
    BEQ :+
      LDA #$80              ; if low bit set, A=80
      JMP @PlotAttributes
    
    : LDA #$40              ; if low bit clear, A=40
    
    ; Now, A=80 or 40, which is the desired BG palette to use for this enemy
    ;  shifted into the high 2 bits -- which is the 'lower-right' attribute portion.
    ;  Which, as explained above, coresponds to the 'upper-left' enemy graphic position
  @PlotAttributes:
    JSR @ApplyAtAndShift        ; Write upper-left enemy graphic attributes
    INY                         ; Inc attritube index by 1 (next attribute byte)
    JSR @ApplyAtAndShift        ; Write upper-right
    JSR IncYBy7                 ; Iny by 7 (next row)
    JSR @ApplyAtAndShift        ; Write lower-left
    INY
    JSR @ApplyAtAndShift        ; Write lower-right
    
    INX                         ; increment src counter
    INC btl_drawformationtmp                   ; increment dest counter
    DEC btltmp+6                ; count down the number of enemies we have left to draw
    BNE @AttributeLoop          ; Loop until there are no more remaining
    
    JMP @DrawNT                 ; Jump ahead to draw nametable bytes
    
    ;;  Support subroutine used by @PlotAttributes to actually update the attribute table
    @ApplyAtAndShift:
        PHA                 ; backup attribute bits
        ORA btltmp_attr, Y  ; merge with existing attribute table
        STA btltmp_attr, Y
        PLA                 ; restore backup
        LSR A               ; and shift down two places
        LSR A               ; shifting down results in changing which sector of the attribute
        RTS                 ;   table we'll write to next
    
@DrawNT:
    LDA btl_enemycount
    STA btltmp+6            ; put enemy counter in btltmp+6 - used as a loop counter
    LDX #$00                ; X= 2* current enemy index
    LDY #$00                ; Y= 1* current enemy index
    
@NTLoop:
    LDA @lut_NTAddress, X   ; Get desired NT address for where to draw this enemy
    STA btltmp+0            ;  put it in btltmp+0
    INX
    LDA @lut_NTAddress, X
    STA btltmp+1
    INX
    
    LDA #$00
    STA btltmp+2            ; default to use graphic 0
    LDA btl_enemygfxplt, Y            ; but check the high byte of the assigned graphic for this enemy
    BPL :+                  ; if set...
      INC btltmp+2          ;    use graphic 1 instead
      
  : JSR DrawSmallEnemy      ; draw the enemy at the given coords
    INY
    
    DEC btltmp+6
    BNE @NTLoop             ; Loop until there are no enemies left to draw
    
    ; Finally, clear unused enemy stats, update attributes, then exit
    JMP WriteAttributes_ClearUnusedEnStats
    
@lut_NTAddress:
  .WORD $2142, $20C2, $21C2     ; Left column of enemies
  .WORD $2146, $20C6, $21C6     ; Center column
  .WORD $214A, $20CA, $21CA     ; right column
  
@lut_AttributeOffset:
  .BYTE $10, $08, $18           ; Left column
  .BYTE $11, $09, $19           ; Center column
  .BYTE $12, $0A, $1A           ; Right column
  
  
  
  
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  DrawFormation_4Large  [$A4E4 :: 0x2E4F4]
;;
;;  Draws NT and Attributes for the enemies for the "4 large" formation type
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

DrawFormation_4Large:
    JSR ReadAttributesFromPPU
    
    ; Begin an unrolled loop to apply the attributes for each of the 4 enemies.
    ; Large enemies are layed out like so in the attribute tables:
    ;
    ; A|AA|.B|BB    (. is unused space)
    ; -+--+--+--
    ; A|AA|.B|BB
    ; A|AA|.B|BB
    ; -+--+--+--
    ; C|CC|.D|DD
    ; C|CC|.D|DD
    ; -+--+--+--
    ; C|CC|.D|DD
    ;
    ; So each enemy occupies 1 full attrubute bytes, and part of 3 other bytes
    
    LDA btl_enemygfxplt+0   ; get enemy 0's assigned palette
    AND #$01
    STA btl_tmppltassign    ; put it in tmppltassign
    LDY #$08                ; its attribute position starts at $08
    JSR @ApplyAtTop         ; apply it as top-row enemy
    
    LDA btl_enemygfxplt+1   ; do same for enemy 1
    AND #$01
    STA btl_tmppltassign
    LDY #$18                ; start at $18
    JSR @ApplyAtBottom      ; bottom row
    
    LDA btl_enemygfxplt+2   ; repeat for enemies 2,3
    AND #$01
    STA btl_tmppltassign
    LDY #$0A
    JSR @ApplyAtTop
    
    LDA btl_enemygfxplt+3
    AND #$01
    STA btl_tmppltassign
    LDY #$1A
    JSR @ApplyAtBottom 
    
    JMP @DrawNT
    
    
    ; applies all attributes for one large enemy in the Top Row
    ;                Y = position of attribute byte
    ; btl_tmppltassign = zero if enemy is to use palette 1, nonzero if to use palette 2
    ;
    ; top row:
    ;   ..|..
    ;   .A|AA
    ;   --+--
    ;   .A|AA
    ;   .A|AA
    
  @ApplyAtTop:
    LDA #%01000000      ; lower-right sector only ; 40
    JSR @ApplyAtByte
    INY
    LDA #%01010000      ; lower sectors ; 50 
    JSR @ApplyAtByte
    JSR IncYBy7         ; (inc by 7 to go to next row)
    LDA #%01000100      ; right sectors only ; 44
    JSR @ApplyAtByte
    INY
    LDA #%01010101      ; all sectors ; 55
    JMP @ApplyAtByte
    
    ; applies all attributes for one large enemy in the Bottom Row
    ;                Y = position of attribute byte
    ; btl_tmppltassign = zero if enemy is to use palette 1, nonzero if to use palette 2
    ;
    ; bottom row:
    ;   .A|AA
    ;   .A|AA
    ;   --+--
    ;   .A|AA
    ;   ..|..
    
  @ApplyAtBottom:
    LDA #%01000100      ; right sectors ; 44
    JSR @ApplyAtByte
    INY
    LDA #%01010101      ; all sectors   ; 55
    JSR @ApplyAtByte
    JSR IncYBy7         ; (inc by 7 to go to next row)
    LDA #%00000100      ; upper-right sector ; 04
    JSR @ApplyAtByte
    INY
    LDA #%00000101      ; upper sectors ; 05
    JMP @ApplyAtByte
    
    ; applies attributes to the desired sector of the desired byte.
    ;                A = low bit set in each attribute sector to update
    ;                Y = position of attribute byte
    ; btl_tmppltassign = zero if enemy is to use palette 1, nonzero if to use palette 2
  @ApplyAtByte:
    LDX btl_tmppltassign    ; if set to use palette 2...
    BEQ :+
      ASL A                 ; then shift A so it is the high-bit in each sector instead of low bit
  : ORA btltmp_attr, Y      ; then OR with attribute byte at given position
    STA btltmp_attr, Y
    RTS
    
    
@DrawNT:
    LDA btl_enemycount
    STA btltmp+6            ; use this as a loop down-counter
    LDX #$00                ; X= 2* enemy index
    LDY #$00                ; Y= 1* enemy index
    
  @NTLoop:
      LDA @lut_NTAddress, X ; put target PPU address in btltmp+0
      STA btltmp+0
      INX
      LDA @lut_NTAddress, X
      STA btltmp+1
      INX
      
      LDA #$00              ; put desired image (0 or 1) in btltmp+2
      STA btltmp+2
      LDA btl_enemygfxplt, Y
      BPL :+
        INC btltmp+2        ; bit 7 of the enemygraphic set indicates we should use image 1
        
    : JSR DrawLargeEnemy    ; draw the enemy
      INY
      DEC btltmp+6
      BNE @NTLoop           ; loop until no more enemies to draw
      
    JMP WriteAttributes_ClearUnusedEnStats
    
@lut_NTAddress:
  .WORD $20C2, $2182
  .WORD $20CA, $218A
  
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  DrawFormation_Mix  [$A590 :: 0x2E5A0]
;;
;;  Draws NT and Attributes for the enemies for the "mix" formation type (2 Large + 6 small)
;;
;;  This routine is very similar to DrawFormation_4Large and DrawFormation_9Small
;;    so I'm not going to comment it as thoroughly.  You should get the idea of what it does
;;    from those routines.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

    
DrawFormation_Mix:
    JSR ReadAttributesFromPPU
    LDA btl_enemyIDs+0
    CMP #$FF
    BEQ @SmallEnemyAttr     ; if there are no large enemies, skip ahead to small enemies
    
    LDY #$00                ; Y=0 or 4 depending on which palette to use
    LDA btl_enemygfxplt+0
    AND #$01
    BEQ :+
      JSR IncYBy4
      
  : LDA @lut_LargeEn0_Attributes, Y
    STA btltmp_attr + $08   ; do a straight copy of the large enemy attributes from
    INY                     ; a lookup table.
    LDA @lut_LargeEn0_Attributes, Y
    STA btltmp_attr + $09
    INY
    LDA @lut_LargeEn0_Attributes, Y
    STA btltmp_attr + $10
    INY
    LDA @lut_LargeEn0_Attributes, Y
    STA btltmp_attr + $11
    INY
    
    ; Do the same for enemy 1
    LDA btl_enemyIDs+1
    CMP #$FF
    BEQ @SmallEnemyAttr     ; if there are no more large enemies, skip ahead to small
    
    LDY #$00                ; Y=0 or 4 depending on which palette to use
    LDA btl_enemygfxplt+1
    AND #$01
    BEQ :+
      JSR IncYBy4
      
  : LDA @lut_LargeEn1_Attributes, Y
    STA btltmp_attr + $18   ; straight copy from lut
    INY
    LDA @lut_LargeEn1_Attributes, Y
    STA btltmp_attr + $19
    INY
    LDA @lut_LargeEn1_Attributes, Y
    STA btltmp_attr + $20
    INY
    LDA @lut_LargeEn1_Attributes, Y
    STA btltmp_attr + $21
    
  @SmallEnemyAttr:
    LDA #$00
    STA btl_drawformationtmp           ; The small enemy index (0-5)
    LDA #$02
    STA btl_drawformationindex           ; The actual enemy index (2-7 for small enemies)
  @SmallEnemyAttrLoop:
      LDX btl_drawformationindex
      LDA btl_enemyIDs, X
      CMP #$FF
      BEQ @NextSmallEnemy   ; if this enemy doesn't exist, skip it
    
    ; Small enemies only take up 2 attribute bytes now, because the large enemies pushed them over 16
    ;   pixels, so they now land cleanly on an attribute byte for the X axis, but still not the Y axis:
    ;
    ; AA|BB
    ; --+--
    ; AA|BB
    ; CC|DD
    ; --+--
    ; CC|DD  
      
    ;; A=50 if using palette 1, A=A0 if using palette 2
      LDA btl_enemygfxplt, X
      AND #$01
      BEQ :+
        LDA #$A0
        BNE :++ ;(always jump)
    :   LDA #$50
    
    ;; apply attributes for top half of enemy
    : LDX btl_drawformationtmp
      PHA
      LDA @lut_SmallEn_AtOffset, X
      TAX                   ; attribute offset in X
      PLA                   ; attribute bits in A
      ORA btltmp_attr, X
      STA btltmp_attr, X
      
    ;; Do all the same for bottom half of enemy
    ;;  A=05 if using palette 1, A=0A if using palette 2
      LDX btl_drawformationindex
      LDA btl_enemygfxplt, X
      AND #$01
      BEQ :+
        LDA #$0A
        BNE :++
      : LDA #$05
      
    ;; apply attributes for bottom half of enemy
    : LDX btl_drawformationtmp
      PHA
      LDA @lut_SmallEn_AtOffset, X
      TAX
      PLA
      ORA btltmp_attr+8, X
      STA btltmp_attr+8, X
    
  @NextSmallEnemy:
      INC btl_drawformationindex       ; increment actual index
      INC btl_drawformationtmp       ; and small enemy index
      LDA btl_drawformationindex
      CMP #$09        ; keep looping until we do all ?9? enemies (it should only be 8, since the 9th enemy will always be blank)
      BNE @SmallEnemyAttrLoop
    
    
    ;; Draw large enemy #0
    LDA btl_enemyIDs
    CMP #$FF
    BEQ @DrawSmallEnemies       ; if large enemy 0 doesn't exist, skip to small enemies
    
    LDA #<$20C2             ; set target ppu addr to $20C2
    STA btltmp+0
    LDA #>$20C2
    STA btltmp+1
    LDA btl_enemygfxplt+0   ; move bit 7 of the gfx assignment to bit 0 of btltmp+2 to indicate which image to draw
    AND #$80
    CLC
    ROL A
    ROL A
    STA btltmp+2
    JSR DrawLargeEnemy      ; then actually draw it
    
    ;; All the same, but for large enemy #1
    LDA btl_enemyIDs+1
    CMP #$FF
    BEQ @DrawSmallEnemies
    
    LDA #<$2182             ; target ppu address = $2182
    STA btltmp+0
    LDA #>$2182
    STA btltmp+1
    LDA btl_enemygfxplt+1
    AND #$80
    CLC
    ROL A
    ROL A
    STA btltmp+2
    JSR DrawLargeEnemy
    
    
  @DrawSmallEnemies:
    ; Same idea as the attributes here
    LDA #$02
    STA btl_drawformationindex       ; 6C91 is the 'actual' index  (0-7)
    LDA #$00
    STA btl_drawformationtmp       ; 6BCF is 2* the 'small' index (0,2,4,6,8,A) - used to index  @lut_SmallEn_DrawPos
  @DrawSmallLoop:
      LDX btl_drawformationindex
      LDA btl_enemyIDs, X           ; see if this enemy exists
      CMP #$FF
      BNE :+
        JMP @DrawNextSmallEnemy     ; if not, skip it  (note that is actually could/should jump to WriteAttribute_ClearUnusedEnState to exit the routine
                                    ; since there will never be any more enemies to draw after this.  But whatever.
        
    : LDA #$00                  ; move bit 7 of this enemy's graphic to bit 0 of btltmp+2
      STA btltmp+2
      LDA btl_enemygfxplt, X
      BPL :+
        INC btltmp+2
        
    : LDX btl_drawformationtmp                     ; get 'small' index
      LDA @lut_SmallEn_DrawPos, X   ; put the target PPU address in btltmp+0
      STA btltmp+0
      LDA @lut_SmallEn_DrawPos+1, X
      STA btltmp+1
      INC btl_drawformationtmp
      INC btl_drawformationtmp                     ; increment small index
      
      JSR DrawSmallEnemy
  @DrawNextSmallEnemy:
      INC btl_drawformationindex             ; inc actual index and loop until all small enemies drawn
      LDA btl_drawformationindex
      CMP #$09
      BNE @DrawSmallLoop
      
    JMP WriteAttributes_ClearUnusedEnStats
    
    
    ; These two attribute LUTs are used for the large enemies in this formation.
    ;    and will be copied directly into attribute memory.  There are no ORs or anything,
    ;    just a straight copy.  This means it will overwrite some other attributes for
    ;    the battle scene... specifically the left-most column, and part of the bottom row
    ;    of the battle backdrop.
    ;
    ; As such, these tables need to include the attribute settings for those areas as well.
  @lut_LargeEn0_Attributes:       ; placed at positions $08, $09, $10, $11   in the attribute table
    ; if using palette 0
    .BYTE $73, $50
    .BYTE $77, $55
  
    ; if using palette 1
    .BYTE $B3, $A0
    .BYTE $BB, $AA
  
  @lut_LargeEn1_Attributes:       ; placed at positions $18, $19, $20, $21   in the attribute table
    ; if using palette 0
    .BYTE $77, $55
    .BYTE $F7, $F5
  
    ; if using palette 1
    .BYTE $BB, $AA
    .BYTE $FB, $FA
  
  ; LUT to indicate the PPU address at which to draw each small enemy
  @lut_SmallEn_DrawPos:
  .WORD $2148, $20C8, $21C8
  .WORD $214C, $20CC, $21CC
  
  
  ; LUT to indicate the offset of the first attribute byte impacted by each small enemy
  @lut_SmallEn_AtOffset:
    .BYTE $12, $0A, $1A     ; first column of small enemies
    .BYTE $13, $0B, $1B     ; second column of small enemies
    
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
    
    LDA #BANK_THIS          ; from this bank (although it's actually from RAM, so this
    STA btltmp+9            ;   isn't strictly necessary)
    
    JSR Battle_WritePPUData_L   ; actually do the write, then exit
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
    
WriteAttributes_ClearUnusedEnStats:
    JSR WriteAttributesToPPU
    
    LDA #$00
    STA btltmp+2            ; loop up-counter - the current enemy we're looking at
    
  @EnemyLoop:
    LDY btltmp+2
    LDA btl_enemyIDs, Y     ; get current enemy ID
    CMP #$FF
    BNE @NextEnemy          ; if it's actually being used, then skip it.  Otherwise...
    
    LDA btltmp+2
    JSR GetEnemyStatPtr     ; Get the stat pointer for this enemy, put it in btltmp+0
    STA btltmp+0
    STX btltmp+1
    
    LDY #$00                ; copy $14 bytes of 0 to this enemy's stats
    LDX #$14
    LDA #$00
  @Loop:
      STA (btltmp+0), Y
      INY
      DEX
      BNE @Loop
      
  @NextEnemy:
    INC btltmp+2            ; increment our enemy counter
    LDA btltmp+2
    CMP #$09
    BNE @EnemyLoop          ; loop until all 9 enemies processed
    
    RTS
    
    
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
  .INCBIN "bin/0B_A800_endingbridge_chrnt.bin"
  
data_EpilogueNT =       data_EpilogueCHR + $800         ; $B000
data_BridgeCHR  =       data_EpilogueNT  + $400         ; $B400
data_BridgeNT   =       data_BridgeCHR   + $800         ; $BC00

.byte "END OF BANK B"