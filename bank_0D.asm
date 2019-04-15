
.export EnterEndingScene, MusicPlay_L, EnterMiniGame, EnterBridgeScene_L ;__Nasir_CRC_High_Byte (JIGS - nag)
;.export lut_IntroStoryText (JIGS - moved to Bank 10)
.export lut_OrbCHR
;; JIGS ^ adding this, part of the original game. Was defined in Constants.inc, but now defined here.

.import DrawComplexString_L, DrawBox_L, UpdateJoy_L, DrawPalette_L
.import WaitForVBlank_L, lut_RNG

.include "variables.inc"
.include "Constants.inc"
.include "macros.inc"

BANK_THIS = $0D

.segment "BANK_0D"

;;
;; This bank seems to have a lot of unused space
;;



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  LUT for score data  [$8000 :: 0x34010]
;;
;;    Score (music) data.  Starts with a pointer table.  Each song/track has 8 bytes.
;;  That 8 bytes is 3 2-byte pointer (one for each of the squares and the tri), followed
;;  by 2 bytes of padding.  After the pointer table is the music data
;;
;;  Music data format is as follows:
;;
;;  00-BF = play a note.  High 4 bits specify note to play:
;;            0x = C, 1x = C#, 2x = D, etc
;;            low 4 bits specify the length of the note (see below)
;;  C0-CF = rest.  Low 4 bits specify length of rest.  Only the triangle
;;            truely rests -- squares simply sustain their current note.
;;  D0    = infinite loop.  A 2 byte pointer follows the 'D0' byte, indicating
;;            where to loop back to
;;  D1-D7 = loop count.  Low bits specify number of times to loop.  2 byte
;;            pointer follows just like D0.  You cannot nest loops in loops, however
;;            you can nest a loop in an infinite loop.
;;  D8-DB = octave select.  Low bits select octave (4 octaves to choose from) (JIGS - now 5; DC for bass)
;;  DC-DF = unused (bugged octave select)
;;  E0-EF = envelope pattern select (low bits select which envelope pattern to use)
;;  F0-F7 = unused (does absolutly nothing)

;;  ^^ JIGS not true!
;;  F0    = Jigs' alternative loop
;;  F1    = Music GOTO .word
;;  F2    = Music RETURN 
;;  F3    = Octave Switch - F3 01 to lower, F3 02 to raise.
;;  F4    = Silencer. F4 will turn it off and on for the channel. Halves volume byte.
;;  F5    = Duty Select - F5 01, 02, 03 - 12.5%, 25%, 50% duty.
;;  F6    = Silencer. Same as F4, but quarter of the volume.
;;  F7    = unused!

;;  F8    = One byte follows this -- the low 4 bits of which select the envelope speed
;;  F9-FE = Tempo select.  Low bits select which tempo to use
;;  FF    = End of song marker -- stops all music playback.

 .ALIGN $100
lut_ScoreData:

.WORD PRELUDE_SQ1
.WORD PRELUDE_SQ2
;.WORD PRELUDE_TRI 
.WORD BLANK ;; JIGS < Prelude doesn't use the triangle, but it does now have a melody!
.WORD PRELUDE_SQ3
.WORD PRELUDE_SQ4

.WORD PROLOGUE_SQ1
.WORD PROLOGUE_SQ4
.WORD PROLOGUE_TRI
.WORD PROLOGUE_SQ2
.WORD PROLOGUE_SQ3

.WORD EPILOGUE_SQ1
.WORD EPILOGUE_SQ4
.WORD EPILOGUE_TRI
.WORD EPILOGUE_SQ2
.WORD EPILOGUE_SQ3

.WORD OVERWORLD_SQ1
.WORD OVERWORLD_SQ4
.WORD OVERWORLD_TRI
.WORD OVERWORLD_SQ2
.WORD OVERWORLD_SQ3

.WORD SHIP_SQ1
.WORD SHIP_SQ4
.WORD SHIP_TRI
.WORD SHIP_SQ2
.WORD SHIP_SQ3

.WORD AIRSHIP_SQ1
.WORD AIRSHIP_SQ4
.WORD AIRSHIP_TRI
.WORD AIRSHIP_SQ3
.WORD AIRSHIP_SQ2

.WORD TOWN_SQ1
.WORD TOWN_SQ4
.WORD TOWN_TRI
.WORD TOWN_SQ2
.WORD TOWN_SQ3

.WORD CASTLE_SQ1
.WORD CASTLE_SQ4
.WORD CASTLE_TRI
.WORD CASTLE_SQ2
.WORD CASTLE_SQ3

.WORD EARTHCAVE_SQ1
.WORD EARTHCAVE_SQ4
.WORD EARTHCAVE_TRI
.WORD EARTHCAVE_SQ2
.WORD EARTHCAVE_SQ3

.WORD MATOYA_SQ1
.WORD MATOYA_SQ4
.WORD MATOYA_TRI
.WORD MATOYA_SQ2
.WORD MATOYA_SQ3

.WORD MARSHCAVE_SQ1
.WORD MARSHCAVE_SQ4
.WORD MARSHCAVE_TRI
.WORD MARSHCAVE_SQ3
.WORD MARSHCAVE_SQ2

.WORD SEASHRINE_SQ1
.WORD SEASHRINE_SQ4
.WORD SEASHRINE_TRI
.WORD SEASHRINE_SQ2
.WORD SEASHRINE_SQ3

.WORD SKYCASTLE_SQ1
.WORD SKYCASTLE_SQ4
.WORD SKYCASTLE_TRI
.WORD SKYCASTLE_SQ2
.WORD SKYCASTLE_SQ3

.WORD FIENDTEMPLE_SQ1
.WORD FIENDTEMPLE_SQ4
.WORD FIENDTEMPLE_TRI
.WORD FIENDTEMPLE_SQ2
.WORD FIENDTEMPLE_SQ3

.WORD SHOP_SQ1
.WORD SHOP_SQ4
.WORD SHOP_TRI
.WORD SHOP_SQ2
.WORD SHOP_SQ3

.WORD BATTLE_SQ1
.WORD BATTLE_SQ4
;.WORD BATTLE_SQ2 ;; JIGS - Now played by the MMC5 audio so that SFX don't interrupt it.
.WORD BATTLE_TRI
.WORD BATTLE_SQ2
.WORD BATTLE_SQ3

.WORD MENU_SQ1
.WORD MENU_SQ4
.WORD MENU_TRI
.WORD MENU_SQ2
.WORD MENU_SQ3
;; JIGS - the code that plays this has been disabled in menus
;; JIGS - BUT it has been moved to the map screen! And is used in inns!

.WORD SLAIN_SQ1
.WORD SLAIN_SQ4
.WORD SLAIN_TRI
.WORD SLAIN_SQ2
.WORD SLAIN_SQ3

.WORD BATTLEWIN_SQ1
.WORD BATTLEWIN_SQ4
.WORD BATTLEWIN_TRI
.WORD BATTLEWIN_SQ2
.WORD BATTLEWIN_SQ3

.WORD SAVE_SQ1
.WORD BLANK
.WORD SAVE_TRI
.WORD BLANK
.WORD SAVE_SQ2

;.WORD PRELUDE_SQ1
;.WORD PRELUDE_SQ2
;.WORD PRELUDE_TRI
;.WORD PRELUDE_SQ3
;.WORD PRELUDE_SQ4

.WORD MARSHCAVEOLD_SQ1
.WORD MARSHCAVEOLD_SQ4
.WORD MARSHCAVEOLD_TRI
.WORD MARSHCAVEOLD_SQ2
.WORD MARSHCAVEOLD_SQ3

;; JIGS - a copy of the prelude for some reason? 
;; Rename these and you have a new song if you have the space for it.

.WORD FANFARE_SQ1
.WORD BLANK
.WORD FANFARE_TRI
.WORD BLANK
.WORD FANFARE_SQ2

.WORD HEAL_SQ1
.WORD BLANK
.WORD HEAL_TRI
.WORD BLANK
.WORD HEAL_SQ2
;; JIGS - the code that plays this has been disabled

.WORD TREASURE_SQ1
.WORD BLANK
.WORD TREASURE_TRI
.WORD BLANK
.WORD TREASURE_SQ2
;; JIGS - the code that plays this has been disabled

;; With thanks to Gil Galad for their music driver disassembly for this sequence data!

PRELUDE_SQ1:

 .BYTE $F5,$02 ; JIGS - set duty to 25%, as Marsh Cave will set it different but never swap back to the original game's setting
 .byte $FD,$F8,$05,$E0
 .byte $C7 ;; JIGS adding a short rest because the audio doesn't kick in fast enough in Mesen. Eh.
    PLOOP0:
    PLOOP0A:
    .byte $D8,$A7,$D8,$07,$27,$57,$A7,$D9,$07,$27,$57,$A7,$DA,$07,$27,$57
    .byte $A7,$DB,$07,$27,$57,$A7,$57,$27,$07,$DA,$A7,$57,$27,$07,$D9,$A7
    .byte $57,$27,$07,$D8,$A7,$57,$27,$07,$D8,$77,$97,$A7,$D8,$27,$77,$97
    .byte $A7,$D9,$27,$77,$97,$A7,$DA,$27,$77,$97,$A7,$DB,$27,$77,$27,$DA
    .byte $A7,$97,$77,$27,$D9,$A7,$97,$77,$27,$D8,$A7,$97,$77,$27,$D8,$A7
    .byte $97
    .byte $D1     ; LOOP 1 TIME
    .WORD PLOOP0A ; $C4,$80
    .byte $D8,$77,$A7,$D8,$37,$57,$77,$A7,$D9,$37,$57,$77
    .byte $A7,$DA,$37,$57,$77,$A7,$DB,$37,$57,$77,$57,$37,$DA,$A7,$77,$57
    .byte $37,$D9,$A7,$77,$57,$37,$D8,$A7,$77,$57,$37,$D8,$A7,$D8,$97,$D8
    .byte $07,$57,$77,$97,$D9,$07,$57,$77,$97,$DA,$07,$57,$77,$97,$DB,$07
    .byte $57,$77,$97,$77,$57,$07,$DA,$97,$77,$57,$07,$D9,$97,$77,$57,$07
    .byte $D8,$97,$77,$57,$07,$D8,$67,$A7,$D8,$17,$57,$67,$A7,$D9,$17,$57
    .byte $67,$A7,$DA,$17,$57,$67,$A7,$DB,$17,$57,$67,$57,$17,$DA,$A7,$67
    .byte $57,$17,$D9,$A7,$67,$57,$17,$D8,$A7,$67,$57,$17,$D8,$A7,$D8,$87
    .byte $D8,$07,$37,$77,$87,$D9,$07,$37,$77,$87,$DA,$07,$37,$77,$87,$DB
    .byte $07,$37,$77,$87,$77,$37,$07,$DA,$87,$77,$37,$07,$D9,$87,$77,$37
    .byte $07,$D8,$87,$77,$37,$07
    .byte $D0     ; INFINITE LOOP
    .WORD PLOOP0  ; ORIGINAL $C4,$80

PRELUDE_SQ2:

;; JIGS - this is more space efficient:

.BYTE $F5,$01 ; JIGS - set duty to 12.5%, as Marsh Cave will set it different but never swap back to the original game's setting
.byte $FD,$F8,$05,$E2,$C4 ; (note: this takes into account the extra rest I added in the first channel)
.byte $D0
.word PLOOP0

;     .byte $FD,$F8,$05,$E2,$C7,$C7
;    PLOOP1:
;    PLOOP1A:
;    .byte $D8,$A7,$D8,$07,$27,$57,$A7,$D9,$07,$27,$57,$A7,$DA,$07,$27,$57
;    .byte $A7,$DB,$07,$27,$57,$A7,$57,$27,$07,$DA,$A7,$57,$27,$07,$D9,$A7
;    .byte $57,$27,$07,$D8,$A7,$57,$27,$07,$D8,$77,$97,$A7,$D8,$27,$77,$97
;    .byte $A7,$D9,$27,$77,$97,$A7,$DA,$27,$77,$97,$A7,$DB,$27,$77,$27,$DA
;    .byte $A7,$97,$77,$27,$D9,$A7,$97,$77,$27,$D8,$A7,$97,$77,$27,$D8,$A7
;    .byte $97
;    .byte $D1
;    .WORD PLOOP1A ; $C3,$81
;    .byte $D8,$77,$A7,$D8,$37,$57,$77,$A7,$D9,$37,$57,$77
;    .byte $A7,$DA,$37,$57,$77,$A7,$DB,$37,$57,$77,$57,$37,$DA,$A7,$77,$57
;    .byte $37,$D9,$A7,$77,$57,$37,$D8,$A7,$77,$57,$37,$D8,$A7,$D8,$97,$D8
;    .byte $07,$57,$77,$97,$D9,$07,$57,$77,$97,$DA,$07,$57,$77,$97,$DB,$07
;    .byte $57,$77,$97,$77,$57,$07,$DA,$97,$77,$57,$07,$D9,$97,$77,$57,$07
;    .byte $D8,$97,$77,$57,$07,$D8,$67,$A7,$D8,$17,$57,$67,$A7,$D9,$17,$57
;    .byte $67,$A7,$DA,$17,$57,$67,$A7,$DB,$17,$57,$67,$57,$17,$DA,$A7,$67
;    .byte $57,$17,$D9,$A7,$67,$57,$17,$D8,$A7,$67,$57,$17,$D8,$A7,$D8,$87
;    .byte $D8,$07,$37,$77,$87,$D9,$07,$37,$77,$87,$DA,$07,$37,$77,$87,$DB
;    .byte $07,$37,$77,$87,$77,$37,$07,$DA,$87,$77,$37,$07,$D9,$87,$77,$37
;    .byte $07,$D8,$87,$77,$37,$07
;    .byte $D0
;    .WORD PLOOP1 ; ORINGAL $C3,$81

PRELUDE_TRI:
    .byte $FD
    PLOOP2:
    .byte $C7
    .byte $D0
    .WORD PLOOP2 ; ORIGINAL $BD,$82

PRELUDE_SQ3:
    .byte $FD
    .byte $F5,$03 ; Duty %50
    .byte $F8,$0C
    PRELUDEWAIT:
    .byte $C0,$C0,$C1,$D7
    .WORD PRELUDEWAIT
    ; wait until song loops once
    .byte $EF,$D9,$A3,$C7,$E7 ; nice fade in
    PRELUDEMELODY:
    .byte $D9,$A0,$C3,$91,$DA,$01,$D9,$AB,$9B,$A0,$CB,$C5,$DA,$03,$D9,$A3,$93
    .byte $DA,$03,$D9,$AB,$9B,$A0,$CB,$C5,$91,$DA,$01
    .byte $05,$25,$D9,$A0,$DA,$23,$03,$D9,$A5,$CB,$DA,$0B,$D9,$AB,$95,$CB
    .byte $AB,$9B,$70,$C3,$51,$71,$90,$A3,$DA,$01
    .byte $F0 ; like a train track switch... next time it loops past here, it goes to END2 instead. First time, it ignores it...
    .WORD PRELUDEMELODY_END2    
    ;... and plays this instead:
    .byte $D9,$91,$A0,$C3,$DA,$13,$03,$D9,$A3,$DA,$13,$00,$13,$31,$01,$D1
    .WORD PRELUDEMELODY
    
    PRELUDEMELODY_END2:
    .byte $51,$33,$15,$05,$D9,$A0,$C3,$DA,$51,$53,$35,$15,$00,$C3,$03,$13,$D0
    .WORD PRELUDEMELODY

    ;; JIGS - melody based off Ailsean's "Final Ecstacy" remix (OCRemix.org)! I like it.
    
PRELUDE_SQ4:
    .byte $FD
    .byte $F5,$03 ; Duty %50
    PRELUDEWAIT2:
    .byte $C0,$C0,$C1,$D7
    .WORD PRELUDEWAIT2
    
    .byte $C5,$CA ; little bit more than an 8th note pause
    .byte $F8,$0C 
    .byte $EF,$F4,$D9,$A3,$C7,$F4 ;; $F4 makes this half volume, once to turn it on, once to turn it off
    .byte $E9,$D0
    .WORD PRELUDEMELODY

PROLOGUE_SQ1:
.BYTE $F5,$02 ; JIGS - set duty to 25%, as Marsh Cave will set it different but never swap back to the original game's setting
    .byte $FB
    PRLOOP0:
    PRLOOP0A:
    .byte $F8,$07,$EE,$DA,$05,$55,$75,$05,$A3,$95,$75,$55,$47,$57,$75
    .byte $55,$53,$43,$25,$75,$95,$25,$DB,$03,$DA,$A5,$95,$75,$67,$97,$75
    .byte $25,$93,$73
    .byte $D1
    .WORD PRLOOP0A ;  $C2,$82
    .byte $DB,$22,$25,$02,$DA,$95,$A5,$A7,$97,$75
    .byte $65,$75,$95,$A5,$DB,$05,$32,$35,$22,$DA,$A5,$DB,$05,$07,$17,$05
    .byte $07,$17,$05,$DA,$A5,$95,$75
    .byte $D0
    .WORD PRLOOP0 ; ORIGINAL $C2,$82

PROLOGUE_SQ2:
.BYTE $F5,$01 ; JIGS - set duty to 12.5%, as Marsh Cave will set it different but never swap back to the original game's setting

    .byte $FB
    PRLOOP1:
    PRLOOP1A:
    .byte $F8,$07,$EA,$D9,$02,$27,$47,$55,$25,$45,$75,$25,$47,$57,$75
    .byte $77,$97,$A3,$73,$73,$65,$77,$97,$A5,$75,$65,$DA,$05,$D9,$A3,$B3
    .byte $DA,$03,$D9,$A3
    .byte $D1
    .WORD PRLOOP1A ; $0C,$83
    .byte $A7,$97,$77,$97,$A7,$C7,$45,$97,$77
    .byte $57,$77,$97,$C7,$55,$75,$35,$25,$05,$23,$75,$95,$DA,$03,$D9,$83
    .byte $A3,$73,$53,$57,$77,$87,$57,$73,$43
    .byte $D0
    .WORD PRLOOP1 ; ORIGINAL $0C,$83
    
PROLOGUE_SQ3:   
   .byte $F4, $FB, $C5, $D0
   .word PROLOGUE_SQ1
   
PROLOGUE_SQ4:   
   .byte $F4, $FB, $C5, $D0
   .word PROLOGUE_SQ2
    

PROLOGUE_TRI:
    .byte $FB
    PRLOOP2:
    PRLOOP2A:
    .byte $F8,$08,$EC,$D9,$53,$43,$23,$03,$D8,$A3,$B3,$D9,$01,$A3,$93
    .byte $73,$63,$73,$53,$43,$03
    .byte $D1
    .WORD PRLOOP2A ; $58,$83
    .byte $A2,$A5,$52,$55,$33,$23,$73
    .byte $53,$83,$33,$23,$73,$83,$DA,$13,$03,$D9,$A3
    .byte $D0
    .WORD PRLOOP2 ; ORIGINAL $58,$83


EPILOGUE_SQ1:
.BYTE $F5,$02 ; JIGS - set duty to 25%, as Marsh Cave will set it different but never swap back to the original game's setting
    .byte $FC,$F8,$08,$EE,$D8,$05,$25,$75,$95,$D9,$05,$25,$75,$95,$B5,$DA
   .byte $25,$75,$D9,$B5,$DA,$05,$45,$75,$05,$25,$65,$95,$25,$05,$45,$75
   .byte $05,$D9,$B5,$DA,$25,$75,$D9,$B5,$DA,$05,$45,$75,$05,$25,$65,$95
   .byte $25,$05,$FB,$45,$FD,$74,$FA,$05
   ELOOP0A:
   .byte $FC,$D9,$B3,$DA,$23,$D9,$93,$B5
   .byte $DA,$05,$D9,$B5,$95,$71,$73,$DA,$02,$05,$D9,$73,$93,$B1,$91,$B3
   .byte $DA,$23,$D9,$93,$B5,$DA,$05,$D9,$B5,$95,$71,$73,$DA,$02,$05,$D9
   .byte $73,$93,$71,$65,$B5,$DA,$35,$65,$73,$65,$45,$21,$43,$25,$05,$D9
   .byte $B1,$DA,$03,$D9,$B5,$95,$75,$95,$B5,$45,$73,$95,$75,$61,$DA,$73
   .byte $65,$45,$21,$43,$25,$05,$D9,$B3,$DA,$05,$25,$41,$C5,$05,$25,$45
   .byte $41,$21,$C7
   .byte $D4
   .WORD ELOOP0A ; $86,$9B
   .byte $FC,$D9,$B3,$DA,$23,$D9,$93,$B5,$DA,$05
   .byte $D9,$B5,$95,$71,$73,$DA,$02,$05,$D9,$73,$93,$B1,$91,$B3,$DA,$23
   .byte $D9,$93,$B5,$DA,$05,$D9,$B5,$95,$71,$73,$DA,$02,$05,$D9,$73,$93
   .byte $71,$DA,$21,$FB,$02,$05,$FC,$D9,$72,$92,$70,$C1,$FF

EPILOGUE_SQ2:
.BYTE $F5,$01 ; JIGS - set duty to 12.5%, as Marsh Cave will set it different but never swap back to the original game's setting

   .byte $FC,$F8,$08,$EE,$C1,$C1,$D9,$25,$75,$B5,$25,$45,$75,$DA,$05,$D9
   .byte $45,$65,$95,$DA,$25,$D9,$65,$45,$75,$DA,$05,$D9,$45,$25,$75,$B5
   .byte $25,$45,$75,$DA,$05,$D9,$45,$65,$95,$DA,$25,$D9,$65,$45,$FB,$75
   .byte $DA,$FD,$04,$D9,$FA,$75
   ELOOP1A:
   .byte $FC,$21,$01,$20,$01,$33,$03,$63,$21,$01
   .byte $21,$01,$20,$01,$33,$03,$63,$21,$33,$D8,$B3,$D9,$41,$63,$45,$25
   .byte $01,$23,$05,$D8,$B5,$93,$D9,$43,$23,$D8,$B3,$D9,$13,$D8,$B5,$D9
   .byte $15,$33,$D8,$B3,$D9,$41,$63,$45,$25,$01,$23,$05,$D8,$B5,$93,$D9
   .byte $43,$03,$93,$71,$61,$C7
   .byte $D4
   .WORD ELOOP1A ; $51,$9C
   .byte $FC,$21,$01,$20,$01,$33,$03
   .byte $63,$21,$01,$21,$01,$20,$01,$33,$03,$63,$21,$53,$23,$FB,$35,$55
   .byte $75,$35,$FC,$24,$04,$D8,$B4,$94,$B2,$92,$70,$FF

EPILOGUE_SQ3:   
   .byte $F4, $FC, $C5, $D0
   .word EPILOGUE_SQ1
   
EPILOGUE_SQ4:   
   .byte $F4, $FC, $C5, $D0
   .word EPILOGUE_SQ2   
   
EPILOGUE_TRI:

    .byte $FC,$F8,$08,$EE,$C1,$C1,$D9,$71,$71,$71,$71,$71,$71,$71,$DA,$05
   .byte $FB,$D9,$B5,$FD,$94,$FA,$75
   ELOOP2A:
   .byte $FC,$71,$61,$51,$41,$31,$23,$03,$71
   .byte $23,$03,$71,$61,$51,$41,$31,$23,$03,$D8,$B1,$D9,$61,$71,$61,$41
   .byte $71,$51,$41,$41,$61,$71,$61,$41,$71,$51,$51,$91,$21,$C7
   .byte $D4
   .WORD ELOOP2A ; $CE,$9C
   .byte $FC,$71,$61,$51,$41,$31,$23,$03,$71,$23,$03,$71,$61,$51,$41
   .byte $31,$23,$03,$D8,$B1,$D9,$73,$53,$FB,$75,$95,$A5,$DA,$05,$FC,$D9
   .byte $92,$62,$72,$22,$D8,$70,$FF


OVERWORLD_SQ1:
.BYTE $F5,$02 ; JIGS - set duty to 25%, as Marsh Cave will set it different but never swap back to the original game's setting
   .byte $FB
   OLOOP0:
   .byte $F8,$08,$EC,$C5,$D9,$B5,$95,$B5,$DA,$05,$D9,$B5,$95,$B5,$F8
   .byte $0A,$DA,$23,$D9,$90,$F8,$08,$C5,$DA,$05,$D9,$B5,$DA,$05,$25,$05
   .byte $D9,$B5,$DA,$05,$F8,$0A,$43,$D9,$B0,$F8,$08,$C5,$DA,$45,$65,$75
   .byte $65,$45,$25,$05,$25,$D9,$95,$B5,$DA,$05,$D9,$B3,$C7,$87,$97,$B7
   .byte $DA,$02,$25,$05,$D9,$B5,$95,$75,$F8,$0A,$DA,$20,$C3
   .byte $D0
   .WORD OLOOP0 ; ORIGINAL $3D,$88

OVERWORLD_SQ2:
.BYTE $F5,$01 ; JIGS - set duty to 12.5%, as Marsh Cave will set it different but never swap back to the original game's setting
   .byte $FB
   OLOOP1:
   .byte $F8,$08,$EE,$C5,$D9,$25,$05,$25,$45,$25,$05,$D8,$B5,$91,$D9
   .byte $65,$45,$25,$05,$D8,$95,$D9,$45,$25,$45,$65,$45,$25,$05,$D8,$B1
   .byte $D9,$85,$65,$45,$25,$F8,$06,$E1,$C7,$47,$77,$47,$C7,$47,$77,$47
   .byte $C7,$67,$97,$67,$C7,$67,$97,$67,$C7,$27,$57,$27,$C7,$27,$57,$27
   .byte $C7,$D8,$B7,$D9,$47,$D8,$B7,$C7,$B7,$D9,$47,$D8,$B7,$C7,$D9,$07
   .byte $47,$07,$C7,$07,$47,$07,$C7,$D8,$97,$D9,$07,$D8,$97,$C7,$97,$D9
   .byte $07,$D8,$97,$D9,$27,$57,$27,$57,$27,$57,$27,$57,$27,$67,$27,$67
   .byte $27,$67,$27,$67
   .byte $D0
   .WORD OLOOP1 ; $8D,$88
   
OVERWORLD_SQ3:   
   .byte $F4, $FB, $C5, $D0
   .word OVERWORLD_SQ1
   
OVERWORLD_SQ4:   
   .byte $F4, $FB, $C5, $D0
   .word OVERWORLD_SQ2

OVERWORLD_TRI:
   .byte $FB
   OLOOP2:
   .byte $F8,$08,$EC,$D9,$79,$C9,$79,$C6,$29,$C9,$79,$C9,$79,$C6,$29
   .byte $C9,$79,$C9,$79,$C6,$29,$C9,$79,$C9,$79,$C6,$29,$C9,$69,$C9,$69
   .byte $C6,$29,$C9,$69,$C9,$69,$C6,$29,$C9,$69,$C9,$69,$C6,$29,$C9,$69
   .byte $C9,$69,$C6,$29,$C9,$99,$C9,$99,$C6,$49,$C9,$99,$C9,$99,$C6,$49
   .byte $C9,$99,$C9,$99,$C6,$49,$C9,$99,$C9,$99,$C6,$49,$C9,$89,$C9,$89
   .byte $C6,$49,$C9,$89,$C9,$89,$C6,$49,$C9,$89,$C9,$89,$C6,$49,$C9,$89
   .byte $C9,$89,$C6,$49,$C9,$DA,$09,$C9,$D9,$79,$C9,$DA,$09,$C9,$D9,$79
   .byte $C9,$DA,$09,$C9,$D9,$79,$C9,$DA,$09,$C9,$D9,$79,$C9,$DA,$29,$C9
   .byte $D9,$99,$C9,$DA,$29,$C9,$D9,$99,$C9,$DA,$29,$C9,$D9,$99,$C9,$DA
   .byte $29,$C9,$D9,$99,$C9,$B9,$C9,$59,$C9,$B9,$C9,$59,$C9,$B9,$C9,$59
   .byte $C9,$B9,$C9,$59,$C9,$DA,$49,$C9,$D9,$B9,$C9,$DA,$49,$C9,$D9,$B9
   .byte $C9,$DA,$49,$C9,$D9,$B9,$C9,$DA,$49,$C9,$D9,$B9,$C9,$99,$C9,$99
   .byte $C6,$DA,$49,$C9,$D9,$99,$C9,$99,$C6,$DA,$49,$C9,$D9,$59,$C9,$59
   .byte $C6,$DA,$59,$C9,$D9,$59,$C9,$59,$C6,$DA,$59,$C9,$D9,$A9,$C9,$DA
   .byte $A9,$C9,$D9,$A9,$C9,$DA,$A9,$C9,$D9,$A9,$C9,$DA,$A9,$C9,$D9,$A9
   .byte $C9,$DA,$A9,$C9,$25,$05,$D9,$B5,$95
   .byte $D0
   .WORD OLOOP2 ; ORIGINAL $04,$89

SHIP_SQ1:
.BYTE $F5,$02 ; JIGS - set duty to 25%, as Marsh Cave will set it different but never swap back to the original game's setting
   .byte $FB,$F8,$08,$EE,$D9,$95,$A5
   SLOOP0:
   .byte $DA,$01,$C3,$77,$57,$47,$57,$22,$D9
   .byte $A5,$73,$DA,$57,$47,$27,$47,$02,$D9,$95,$63,$DA,$27,$07,$D9,$A7
   .byte $97,$A3,$C7,$77,$97,$A7,$DA,$03,$D9,$95,$A5,$DA,$01,$03,$77,$57
   .byte $47,$57,$22,$D9,$A5,$73,$DA,$57,$47,$27,$47,$02,$D9,$95,$63,$DA
   .byte $27,$07,$D9,$A7,$97,$A3,$A7,$77,$97,$A7,$DA,$01,$C5,$05,$25,$45
   .byte $75,$55,$45,$55,$43,$05,$D9,$95,$DA,$21,$C5,$25,$45,$55,$75,$55
   .byte $45,$55,$73,$25,$95,$73,$D9,$95,$A5
   .byte $D0
   .WORD SLOOP0 ; ORIGINAL $06,$8A

SHIP_SQ2:
.BYTE $F5,$01 ; JIGS - set duty to 12.5%, as Marsh Cave will set it different but never swap back to the original game's setting
   .byte $FB,$F8,$08,$E2,$C3
   SLOOP1:
   SLOOP1A:
   .byte $F8,$03,$E2,$C7,$D9,$59,$C9,$47,$59,$C6,$59
   .byte $C9,$47,$59,$C9,$C7,$59,$C9,$47,$59,$C6,$59,$C9,$47,$59,$C9,$C7
   .byte $29,$C9,$07,$29,$C6,$29,$C9,$07,$29,$C9,$C7,$09,$C9,$D8,$A7,$D9
   .byte $09,$C6,$09,$C9,$D8,$A7,$D9,$09,$C9,$C7,$09,$C9,$D8,$97,$D9,$09
   .byte $C6,$09,$C9,$D8,$97,$D9,$09,$C9,$C7,$29,$C9,$07,$29,$C6,$29,$C9
   .byte $07,$29,$C9,$C7,$39,$C9,$27,$39,$C6,$39,$C9,$27,$39,$C9,$C7,$49
   .byte $C9,$27,$49,$C6,$49,$C9,$27,$49,$C9
   .byte $D1
   .WORD SLOOP1A ; $70,$8A
   .byte $F8,$04,$E2,$09
   .byte $C9,$49,$C9,$29,$C9,$49,$C9,$09,$09,$49,$C9,$29,$C9,$49,$C9
   .byte $29
   .byte $C9,$59,$C9,$49,$C9,$59,$C9,$29,$29,$59,$C9,$49,$C9,$59,$C9,$09
   .byte $C9,$49,$C9,$29,$C9,$49,$C9,$09,$09,$49,$C9,$29,$C9,$49,$C9,$29
   .byte $C9,$59,$C9,$49,$C9,$59,$C9,$29,$29,$59,$C9,$49,$C9,$59,$C9
   SLOOP1B:
   .byte $29
   .byte $C9,$59,$C9,$49,$C9,$59,$C9,$29,$29,$59,$C9,$49,$C9,$59,$C9
   .byte $D2
   .WORD SLOOP1B ; $1A,$8B
   .byte $79,$C9,$79,$C9,$C7,$79,$C9,$C7,$79,$C9,$C7,$79,$C9
   .byte $D0
   .WORD SLOOP1 ; ORIGINAL $70,$8A

SHIP_SQ3:   
   .byte $F4, $FB, $C5, $D0
   .word SHIP_SQ1
   
SHIP_SQ4:   
   .byte $F4, $FB, $C5, $D0
   .word SHIP_SQ2
   
   
SHIP_TRI:
   .byte $FB,$F8,$08,$EC,$C3
   SLOOP2:
   SLOOP2A:
   .byte $D9,$57,$DA,$09,$C9,$D9,$57,$DA,$09,$C9,$D9
   .byte $57,$DA,$09,$C9,$D9,$57,$DA,$09,$C9,$D9,$27,$99,$C9,$27,$99,$C9
   .byte $27,$99,$C9,$27,$99,$C9,$D8,$A7,$D9,$59,$C9,$D8,$A7,$D9,$59,$C9
   .byte $D8,$A7,$D9,$59,$C9,$D8,$A7,$D9,$59,$C9,$07,$79,$C9,$07,$79,$C9
   .byte $07,$79,$C9,$07,$79,$C9,$D8,$97,$D9,$49,$C9,$D8,$97,$D9,$49,$C9
   .byte $D8,$97,$D9,$49,$C9,$D8,$97,$D9,$49,$C9,$27,$99,$C9,$27,$99,$C9
   .byte $27,$99,$C9,$27,$99,$C9,$37,$A9,$C9,$37,$A9,$C9,$37,$A9,$C9,$37
   .byte $A9,$C9,$07,$79,$C9,$07,$79,$C9,$07,$79,$C9,$07,$79,$C9
   .byte $D1
   .WORD SLOOP2A ; $42,$8B
   SLOOP2B:
   .byte $D8,$99,$C9,$99,$C9,$C4,$D9,$49,$C9,$99,$C9,$49,$C9,$29,$C9
   .byte $29,$C9,$C4,$59,$C9,$99,$C9,$59,$C9
   .byte $D1
   .WORD SLOOP2B ; $BE,$8B
   .byte $D8,$A9,$C9,$A9
   .byte $C9,$C4,$D9,$59,$C9,$A9,$C9,$59,$C9,$D8,$79,$C9,$79,$C9,$C4,$D9
   .byte $29,$C9,$79,$C9,$29,$C9,$D8,$B9,$C9,$B9,$C9,$C4,$D9,$29,$C9,$79
   .byte $C9,$29,$C9,$07,$79,$C9,$27,$79,$C9,$37,$A9,$C9,$47,$A9,$C9
   .byte $D0
   .WORD SLOOP2 ; ORIGINAL $42,$8B

AIRSHIP_SQ1:
.BYTE $F5,$02 ; JIGS - set duty to 25%, as Marsh Cave will set it different but never swap back to the original game's setting
   .byte $FC
   ALOOP0:
   .byte $F8,$04,$EB,$DA,$05,$55,$75,$A5,$97,$77,$57,$97,$75,$07,$27
   .byte $34,$F8,$09,$EB,$01,$C7,$C3,$F8,$04,$EB,$05,$55,$75,$A5,$97,$77
   .byte $57,$97,$75,$37,$57,$74,$F8,$09,$EB,$DB,$01,$F8,$03,$E1,$C7,$D9
   .byte $A9,$DA,$09,$29,$39,$59,$79,$89,$99,$F8,$04,$E1,$A7,$87,$57,$A7
   .byte $87,$C7,$37,$57,$A7,$87,$57,$A7,$87,$C4,$A7,$87,$57,$A7,$87,$C7
   .byte $37,$57,$A7,$87,$57,$A7,$87,$C4,$77,$57,$27,$77,$57,$C7,$07,$37
   .byte $57,$27,$D9,$A7,$DA,$57,$37,$C7,$D9,$A7,$DA,$17,$F8,$09,$EB,$03
   .byte $F8,$03,$E1,$47,$09,$49,$77,$49,$79,$F8,$08,$EE,$DB,$01
   .byte $D0
   .WORD ALOOP0 ; $10,$8C

AIRSHIP_SQ2:
.BYTE $F5,$01 ; JIGS - set duty to 12.5%, as Marsh Cave will set it different but never swap back to the original game's setting
   .byte $FC
   ALOOP1:
   .byte $F8,$07,$EB
   ALOOP1A:
   .byte $D9,$93,$73
   .byte $D7
   .WORD ALOOP1A ; $94,$8C
   .byte $DA,$23,$03,$23,$F8,$04
   .byte $E2,$D9,$09,$29,$39,$89,$DA,$09,$29,$39,$89,$F8,$07,$EB,$23,$03
   .byte $23,$F8,$04,$E2,$D9,$09,$79,$DA,$29,$99,$D9,$29,$99,$DA,$49,$B9
   .byte $F8,$07,$EB,$D9,$B3,$83,$53,$83,$F8,$04,$E2,$A7,$A7,$97,$A7,$C7
   .byte $A7,$97,$A7,$77,$77,$47,$77,$C7,$77,$47,$77
   .byte $D0
   .WORD ALOOP1 ; $91,$8C
   
AIRSHIP_SQ3:   
   .byte $F4, $FC, $C5, $D0
   .word AIRSHIP_SQ1
   
AIRSHIP_SQ4:   
   .byte $F4, $FC, $C5, $D0
   .word AIRSHIP_SQ2   

AIRSHIP_TRI:
   .byte $FC
   ALOOP2:
   .byte $F8,$08,$EC
   ALOOP2A:
   .byte $D9,$57,$DA,$07,$D9,$57,$DA,$07,$D9,$37,$A7,$37
   .byte $A7,$57,$DA,$07,$D9,$57,$DA,$07,$D9,$37,$A7,$37,$A7,$57,$DA,$07
   .byte $D9,$57,$DA,$07,$D9,$37,$A7,$37,$A7,$57,$DA,$07,$D9,$57,$DA,$07
   .byte $D9,$37,$A7,$37,$A7
   .byte $D1
   .WORD ALOOP2A ; $E2,$8C
   ALOOP2B:
   .byte $A7,$DA,$57,$D9,$A7,$DA,$57,$D9
   .byte $87,$DA,$37,$D9,$87,$DA,$37,$D9,$A7,$DA,$57,$D9,$A7,$DA,$57,$D9
   .byte $87,$C4
   .byte $D1
   .WORD ALOOP2B ; $16,$8D
   .byte $77,$DA,$27,$C7,$27,$D9,$87,$DA,$37,$C7,$37
   .byte $D9,$A7,$DA,$27,$C7,$27,$17,$57,$C7,$57,$75,$55,$45,$25,$05,$D9
   .byte $A5,$95,$75
   .byte $D0
   .WORD ALOOP2 ; $DF,$8C


TOWN_SQ1:
.BYTE $F5,$02 ; JIGS - set duty to 25%, as Marsh Cave will set it different but never swap back to the original game's setting
   .byte $FC
   TLOOP0:
   .byte $F8,$08,$EE,$DA,$43,$73,$23,$45,$55,$45,$25,$01,$03,$92,$95
   .byte $75,$25,$45,$55,$40,$43,$DB,$02,$05,$03,$DA,$B5,$95,$75,$25,$45
   .byte $55,$43,$03,$21,$25,$D9,$A5,$DA,$05,$25,$01,$D9,$B3,$DA,$05,$25
   .byte $D0
   .WORD TLOOP0  ; ORIGINAL $3B,$8F

TOWN_SQ2:
.BYTE $F5,$01 ; JIGS - set duty to 12.5%, as Marsh Cave will set it different but never swap back to the original game's setting
   .byte $FC
   TLOOP1:
   .byte $F8,$04,$E2,$D9,$45,$DA,$05,$D9,$75,$45,$25,$75,$B5,$25,$05
   .byte $95,$45,$05,$45,$75,$DA,$05,$D9,$45,$05,$95,$55,$05,$D8,$B5,$D9
   .byte $25,$75,$B5,$45,$DA,$05,$D9,$75,$45,$25,$45,$85,$B5,$F8,$08,$EE
   .byte $DA,$41,$63,$23,$D9,$B1,$DA,$05,$D9,$B5,$95,$75,$51,$C1,$70,$53
   .byte $D0
   .WORD TLOOP1 ; ORIGINAL $6E,$8F
   
TOWN_SQ3:   
   .byte $F4, $FC, $C5, $D0
   .word TOWN_SQ1
   
TOWN_SQ4:   
   .byte $F4, $FC, $C5, $D0
   .word TOWN_SQ2   

TOWN_TRI:
   .byte $FC
   TLOOP2:
   .byte $F8,$08,$EC,$DA,$01,$D9,$B1,$91,$71,$51,$51,$DA,$01,$D9,$41
   .byte $95,$DA,$45,$95,$45,$23,$63,$D9,$75,$DA,$25,$75,$25,$03,$D9,$03
   .byte $D8,$A5,$D9,$55,$A5,$DA,$05,$21,$D8,$75,$D9,$25,$75,$95,$B5,$95
   .byte $73
   .byte $D0
   .WORD TLOOP2 ; ORIGINAL $B1,$8F

CASTLE_SQ1:
.BYTE $F5,$02 ; JIGS - set duty to 25%, as Marsh Cave will set it different but never swap back to the original game's setting
   .byte $FD
   CLOOP0:
   .byte $F8,$08,$EE,$DA,$62,$65,$75,$65,$45,$25,$43
   .byte $D9,$90,$DA,$22,$25,$45,$25,$15,$D9,$B5,$DA,$13,$D9,$60,$B2,$DA
   .byte $15,$23,$43,$63,$73,$93,$75,$65,$43,$D9,$B2,$B5,$DA,$15,$25,$61
   .byte $41
   .byte $D0
   .WORD CLOOP0 ; $55,$8D

CASTLE_SQ2:
.BYTE $F5,$01 ; JIGS - set duty to 12.5%, as Marsh Cave will set it different but never swap back to the original game's setting
   .byte $FD
   CLOOP1:
   .byte $F8,$08,$EB,$D8,$95,$D9,$65,$25,$65,$D8,$95
   .byte $D9,$65,$25,$65,$15,$45,$D8,$95,$D9,$45,$D8,$B5,$D9,$45,$15,$45
   .byte $D8,$B5,$D9,$65,$25,$65,$D8,$B5,$D9,$65,$25,$65,$D8,$A5,$D9,$15
   .byte $D8,$65,$D9,$15,$D8,$85,$D9,$15,$D8,$A5,$D9,$15,$D8,$B5,$D9,$75
   .byte $25,$75,$D8,$A5,$D9,$75,$25,$75,$25,$95,$45,$95,$35,$B5,$D8,$B5
   .byte $D9,$35,$B5,$95,$75,$65,$41,$25,$DA,$25,$15,$D9,$B5,$95,$75,$65
   .byte $45
   .byte $D0
   .WORD CLOOP1 ; $85,$8D
   
CASTLE_SQ3:   
   .byte $F4, $FD, $C5, $D0
   .word CASTLE_SQ1
   
CASTLE_SQ4:   
   .byte $F4, $FD, $C5, $D0
   .word CASTLE_SQ2

CASTLE_TRI:
   .byte $FD
   CLOOP2:
   .byte $F8,$08,$EC,$DA,$21,$21,$11,$11,$D9,$B1,$B1
   .byte $A1,$A1,$71,$71,$DA,$21,$D9,$B1,$DA,$41,$41,$D9,$91,$91
   .byte $D0
   .WORD CLOOP2 ; $E5,$8D


EARTHCAVE_SQ1:
.BYTE $F5,$02 ; JIGS - set duty to 25%, as Marsh Cave will set it different but never swap back to the original game's setting
   .byte $FB
   D1LOOP0:
   .byte $F8,$03,$E0
   D1LOOP0A:
   .byte $D9,$29,$C9,$29,$C9,$59,$C9,$29,$C9
   .byte $09,$C9,$F8,$07,$45,$25,$F8,$03,$29,$C9,$59,$C9,$29,$C9,$49,$C9
   .byte $F8,$07,$75,$F8,$03,$79,$C9
   .byte $D1
   .WORD D1LOOP0A ; $F7,$90
   .byte $F8,$05,$17,$29,$C9,$59
   .byte $C9,$99,$C9,$F8,$08,$EE,$DA,$21,$C7,$F8,$03,$E0,$D9,$BC,$DA,$0C
   .byte $D9,$BC,$99,$C9,$B9,$C9,$F8,$05,$DA,$07,$D9,$B9,$C9,$99,$C9,$79
   .byte $C9,$57,$79,$C9,$99,$C9,$59,$C9,$F8,$08,$EE,$21,$F8,$05,$E0,$17
   .byte $29,$C9,$59,$C9,$99,$C9,$F8,$08,$EE,$DA,$21,$F8,$03,$E0,$C7,$D9
   .byte $BC,$DA,$0C,$D9,$BC,$99,$C9,$B9,$C9,$F8,$05,$DA,$07,$D9,$99,$C9
   .byte $59,$C9,$99,$C9,$DA,$47,$59,$C9,$49,$C9,$09,$C9,$F8,$08,$EE,$21
   .byte $F8,$05,$E0,$07,$D9,$97,$57,$97,$B7,$DA,$07,$D9,$B7,$97,$F8,$08
   .byte $B4,$F8,$08,$B9,$B9,$F8,$08,$B4,$F8,$08,$B9,$B9,$F8,$05,$DA,$07
   .byte $D9,$97,$57,$97,$B7,$DA,$07,$D9,$B7,$97,$F8,$08,$DA,$24,$F8,$08
   .byte $29,$29,$F8,$08,$DA,$24,$F8,$08,$29,$29,$F8,$05,$37,$07,$D9,$87
   .byte $DA,$07,$27,$37,$27,$07,$F8,$08,$D9,$A4,$F8,$08,$A9,$A9,$F8,$08
   .byte $D9,$A4,$F8,$08,$A9,$A9,$F8,$05,$DA,$37,$07,$D9,$87,$DA,$07,$27
   .byte $37,$27,$07,$F8,$08,$54,$F8,$08,$59,$59,$F8,$08,$54,$F8,$08,$59
   .byte $59
   .byte $D0
   .WORD D1LOOP0 ; $F4,$90
   
   
EARTHCAVE_SQ2:
.BYTE $F5,$01 ; JIGS - set duty to 12.5%, as Marsh Cave will set it different but never swap back to the original game's setting
   .byte $FB
   D1LOOP1:
   .byte $F8,$05,$E1
   D1LOOP1A:
   .byte $D8,$99,$C9,$99,$C9,$C4,$F8,$05
   .byte $75,$F8,$05,$99,$C9,$C3,$79,$C9,$F8,$05,$75,$F8,$05,$79,$C9
   .byte $D1
   .WORD D1LOOP1A ; $F8,$91
   D1LOOP1B:
   .byte $F8,$08,$EE,$93,$F8,$03,$E1,$C7,$57,$79,$C9,$99,$C9,$F8
   .byte $08,$EE,$B3,$F8,$03,$E1,$C7,$77,$99,$C9,$B9,$C9,$F8,$08,$EE,$D9
   .byte $03,$F8,$03,$E1,$C7,$D8,$97,$B9,$C9,$D9,$09,$C9,$F8,$08,$EE,$D8
   .byte $B3,$F8,$03,$E1,$C7,$77,$99,$C9,$B9,$C9
   .byte $D1
   .WORD D1LOOP1B ; $12,$92
   D1LOOP1C:
   .byte $F8,$05,$D9
   .byte $57,$C7,$07,$C7,$D8,$97,$C7,$D9,$07,$C7,$57,$27,$57,$27,$57,$27
   .byte $57,$27
   .byte $D1
   .WORD D1LOOP1C ; $4D,$92
   D1LOOP1D:
   .byte $87,$C7,$37,$C7,$07,$C7,$37,$C7,$87,$57,$87
   .byte $57,$87,$57,$87,$57
   .byte $D1
   .WORD D1LOOP1D ; $65,$92
   .byte $D0
   .WORD D1LOOP1 ; $F5,$91

EARTHCAVE_SQ3:   
   .byte $F4, $FB, $C5, $D0
   .word EARTHCAVE_SQ1
   
EARTHCAVE_SQ4:   
   .byte $F4, $FB, $C5, $D0
   .word EARTHCAVE_SQ2
   
   
EARTHCAVE_TRI:
   .byte $FB
   D1LOOP2:
   .byte $F8,$08,$EC
   D1LOOP2A:
   .byte $DA
   .byte $29,$C9,$29,$C9,$C4,$05,$29,$C9,$C3,$09,$C9,$D9,$B5,$B9,$C9
   .byte $D1
   .WORD D1LOOP2A ; $7F,$92
   D1LOOP2B:
   .byte $DA,$29,$C9,$29,$C9,$59,$C9,$59,$C9,$29,$C9,$C5,$09,$C9
   .byte $29,$C9,$29,$C9,$79,$C9,$79,$C9,$29,$C9,$C5,$09,$C9,$29,$C9,$29
   .byte $C9,$99,$C9,$99,$C9,$29,$C9,$C5,$09,$C9,$29,$C9,$29,$C9,$79,$C9
   .byte $79,$C9,$29,$C9,$C5,$09,$C9
   .byte $D1
   .WORD D1LOOP2B ; $92,$92
   D1LOOP2C:
   .byte $D9,$59,$C9,$59,$C9,$DA
   .byte $59,$C9,$59,$C6,$D9,$59,$C9,$DA,$59,$C9,$09,$C9,$D9,$74,$79,$C9
   .byte $74,$79,$C9
   .byte $D1
   .WORD D1LOOP2C ; $CA,$92
   D1LOOP2D:
   .byte $89,$C9,$89,$C9,$DA,$89,$C9,$89,$C6,$D9
   .byte $89,$C9,$DA,$89,$C9,$39,$C9,$D9,$A4,$A9,$C9,$A4,$A9,$C9
   .byte $D1
   .WORD D1LOOP2D ; $E6,$92
   .byte $D0
   .WORD D1LOOP2 ; $7C,$92


MATOYA_SQ1:
.BYTE $F5,$02 ; JIGS - set duty to 25%, as Marsh Cave will set it different but never swap back to the original game's setting
   .byte $FB
   D2LOOP0:
   .byte $F8,$08,$EC,$D9,$B7,$DA,$27,$67,$D9,$B7
   .byte $DA,$75,$67,$47,$25,$47,$27,$F8,$08,$EE,$13,$F8,$08,$EC,$27,$67
   .byte $97,$27,$B5,$97,$77,$65,$77,$67,$45,$67,$77,$F8,$08,$EE,$93,$15
   .byte $45,$2C,$CC,$1C,$CC,$2C,$CC,$D9,$B3,$DA,$77,$97,$B3,$25,$75,$6C
   .byte $CC,$7C,$CC,$6C,$CC,$43,$97,$B7,$DB,$13,$C7,$DA,$97,$B7,$DB,$17
   .byte $49,$29,$19,$29,$DA,$B4,$97,$77,$67,$43,$C7,$07,$27,$47,$23,$15
   .byte $D9,$95,$F8,$08,$EE,$DA,$20,$C5,$F8,$04,$E1,$29,$19,$D9,$B9,$DA
   .byte $19,$F8,$08,$EE,$20,$C5,$F8,$04,$E1,$69,$49,$29,$49,$F8,$08,$EE
   .byte $60,$C5,$F8,$04,$E1,$99,$79,$69,$79,$F8,$08,$EE,$90,$F8,$04,$E1
   .byte $69,$49,$29,$19,$49,$29,$19,$D9,$A9
   .byte $D0
   .WORD D2LOOP0 ; $86,$83

MATOYA_SQ2:
.BYTE $F5,$01 ; JIGS - set duty to 12.5%, as Marsh Cave will set it different but never swap back to the original game's setting
   .byte $FB
   D2LOOP1:
   .byte $F8,$07,$E2
   .byte $D8,$B9,$C9,$D9,$69,$C9,$D8,$B9,$C9,$D9,$69,$C9,$D8,$B9,$C9,$D9
   .byte $79,$C9,$D8,$B9,$C9,$D9,$79,$C9,$D8,$B9,$C9,$D9,$79,$C9,$D8,$B9
   .byte $C9,$D9,$79,$C9,$19,$C9,$99,$C9,$19,$C9,$99,$C9,$29,$C9,$99,$C9
   .byte $29,$C9,$99,$C9,$29,$C9,$B9,$C9,$29,$C9,$B9,$C9,$29,$C9,$B9,$C9
   .byte $29,$C9,$B9,$C9,$19,$C9,$99,$C9,$19,$C9,$99,$C9,$99,$C9,$99,$C9
   .byte $C5,$99,$C9,$99,$C9,$C5,$69,$C9,$69,$C9,$C5,$69,$C9,$69,$C9,$C5
   .byte $B9,$C9,$B9,$C9,$C5,$B9,$C9,$B9,$C9,$C5,$DA,$19,$C9,$19,$C9,$C5
   .byte $19,$C9,$19,$C9,$C5,$D9,$99,$C9,$99,$C9,$C5,$99,$C9,$99,$C9,$C5
   .byte $69,$C9,$69,$C9,$C5,$69,$C9,$69,$C9,$C5,$49,$C9,$79,$C9,$49,$C9
   .byte $79,$C9,$49,$C9,$79,$C9,$49,$C9,$79,$C9,$49,$C9,$79,$C9,$49,$C9
   .byte $79,$C9,$99,$79,$69,$49,$69,$49,$29,$19
   D2LOOP1A:
   .byte $F8,$08,$EE,$65,$25,$75
   .byte $25,$97,$97,$27,$97,$75,$45
   .byte $D2
   .WORD D2LOOP1A ; $CA,$84
   .byte $65,$25,$75,$25,$97,$97
   .byte $27,$97,$65,$45
   .byte $D0
   .WORD D2LOOP1 ; $1D,$84
   
MATOYA_SQ3:   
   .byte $F4, $FB, $C5, $D0
   .word MATOYA_SQ1
   
MATOYA_SQ4:   
   .byte $F4, $FB, $C5, $D0
   .word MATOYA_SQ2   

MATOYA_TRI:
   .byte $FB
   D2LOOP2:
   .byte $F8,$08,$EC,$D8,$B3,$D9,$43,$73
   .byte $95,$75,$23,$73,$B3,$97,$49,$C9,$19,$C9,$D8,$99,$C9,$C7,$67,$D9
   .byte $19,$C9,$69,$C9,$C7,$D8,$69,$C9,$D9,$67,$19,$C9,$C7,$D8,$B7,$D9
   .byte $69,$C9,$B9,$C9,$C7,$D8,$B9,$C9,$D9,$B7,$69,$C9,$C7,$D8,$77,$D9
   .byte $29,$C9,$79,$C9,$C7,$D8,$79,$C9,$D9,$77,$29,$C9,$C7,$D8,$97,$D9
   .byte $49,$C9,$99,$C9,$C7,$D8,$99,$C9,$D9,$97,$49,$C9,$C7,$D8,$67,$D9
   .byte $19,$C9,$69,$C9,$C7,$D8,$69,$C9,$D9,$67,$19,$C9,$C7,$D8,$B7,$D9
   .byte $69,$C9,$B9,$C9,$C7,$D8,$B9,$C9,$D9,$B7,$69,$C9,$07,$DA,$09,$C9
   .byte $D9,$07,$DA,$09,$C9,$D9,$07,$DA,$09,$C9,$D9,$07,$DA,$09,$C9,$D8
   .byte $97,$D9,$99,$C9,$D8,$97,$D9,$99,$C9,$D8,$97,$D9,$99,$C9,$D8,$97
   .byte $D9,$99,$C9
   D2LOOP2A:
   .byte $27,$99,$C9,$C7,$99,$C9,$27,$B9,$C9,$C7,$B9,$C9,$27
   .byte $DA,$19,$C9,$C7,$19,$C9,$D9,$27,$B9,$C9,$C7,$B9,$C9
   .byte $D2
   .WORD D2LOOP2A ; $83,$85
   .byte $27,$99,$C9,$C7,$99,$C9,$27,$B9,$C9,$C7,$B9,$C9,$27,$DA,$19,$C9
   .byte $C7,$19,$C9,$D9,$67,$DA,$19,$C9,$D9,$67,$DA,$19,$C9
   .byte $D0
   .WORD D2LOOP2 ; $E8,$84

   
   ;; JIGS - my own composition as a replacement for this ugly song...
   
   
MARSHCAVE_SQ1:
   .BYTE $FE
   .BYTE $F8,$08
   .BYTE $E1
   .BYTE $F5,$02  ; set duty to 25%
   DUNGEON3INTROLOOP:
   .BYTE $DA,$A8,$78,$38,$08,$D9,$38,$78,$A8,$DA,$28
   .BYTE $D1
   .WORD DUNGEON3INTROLOOP
   DUNGEON3LOOP:
   .BYTE $F8,$0A
   .BYTE $E0
   DUNGEON3LOOP1:
   .BYTE $DA,$04,$D9,$74,$DA,$06,$26,$56,$86 ; 1 
   .BYTE $74,$04,$76,$86,$A6,$DB,$16 ; 2 
   .BYTE $04,$DA,$74 ; 3.0
   .BYTE $F0
   .WORD DUNGEON3MELODYLOOP1
   .BYTE $A6,$86,$76,$A6 ; 3.5
   .BYTE $92,$98,$C8,$78,$C8,$58,$C8,$38,$C8 ;4 
   .BYTE $D1
   .WORD DUNGEON3LOOP1
    DUNGEON3MELODYLOOP1:
   .BYTE $36,$26,$06,$D9,$A6 ; 7.5 
   .BYTE $82,$62 ; 8 
  DUNGEON3LOOP1_2:
   .BYTE $DA,$78,$C8,$76,$04,$38,$78,$A6,$DB,$26,$08,$DA,$88 ; 9
   .BYTE $78,$C8,$76,$04,$38,$78,$86,$A6,$88,$68 ; 10
   .BYTE $78,$C8,$76,$04,$58,$38,$56,$28,$C8,$D9,$A8,$C8,$DA ; 11
   .BYTE $F0
   .WORD DUNGEON3MELODYLOOP2
   .BYTE $02,$36,$56,$86,$66 ; 12
   .BYTE $D1
   .WORD DUNGEON3LOOP1_2
   DUNGEON3MELODYLOOP2:
   .BYTE $01,$DB,$3A,$2A,$0A,$DA,$AA,$7A,$5A,$3A,$2A ;16  
   .BYTE $D0
   .WORD DUNGEON3LOOP
   
MARSHCAVE_SQ4:   
   .byte $F4, $FE, $C5, $D0
   .word MARSHCAVE_SQ4

MARSHCAVE_SQ2:
   .BYTE $FE
   .BYTE $C0
   .BYTE $F5,$01  ; set duty to 12.5%
   DUNGEON3HARMONYLOOP1:
   .BYTE $F8,$06
   .BYTE $EA
   .BYTE $D9
   .BYTE $74,$06,$74,$86,$56,$86
   .BYTE $74,$06,$74,$86,$56,$86
   .BYTE $74,$06,$74,$86
   .BYTE $F0
   .WORD DUNGEON3FLOOP1
   .BYTE $76,$56,$36,$26,$06,$36,$22
   .BYTE $D1
   .WORD DUNGEON3HARMONYLOOP1
   DUNGEON3FLOOP1:
   .BYTE $DA,$06,$D9,$86,$36,$26,$06,$36,$64,$24
   ;;Part 2
   DUNGEON3HARMONYLOOP2:
   .BYTE $E0
   .BYTE $08,$38,$78,$DA,$08,$D9 
   .BYTE $E2
   .BYTE $08,$38,$78,$DA,$08,$D9 
   .BYTE $E0
   .BYTE $38,$78,$A8,$DA,$38,$D9 
   .BYTE $E2
   .BYTE $38,$78,$A8,$DA,$38,$D9 
   
   .BYTE $E0
   .BYTE $08,$38,$78,$DA,$08,$D9 
   .BYTE $E2
   .BYTE $08,$38,$78,$DA,$08,$D9 
   .BYTE $E0
   .BYTE $38,$78,$DA,$08,$38,$D9 
   .BYTE $E2
   .BYTE $38,$78,$DA,$08,$38,$D9 
   
   .BYTE $E0
   .BYTE $08,$38,$78,$DA,$08,$D9 
   .BYTE $E2
   .BYTE $08,$38,$78,$DA,$08,$D9 
   .BYTE $E0
   .BYTE $38,$78,$A8,$DA,$38,$D9 
   .BYTE $E2
   .BYTE $38,$78,$A8,$DA,$38,$D9 
   .BYTE $F0
   .WORD DUNGEON3TRILLFLOOP
   .BYTE $E0
   .BYTE $08,$38,$78,$DA,$08,$D9 
   .BYTE $E2
   .BYTE $08,$38,$78,$DA,$08,$D9 
   .BYTE $E0
   .BYTE $38,$88,$DA,$08,$38,$D9 
   .BYTE $E2
   .BYTE $38,$88,$DA,$08,$38,$D9 
   .BYTE $D1
   .WORD DUNGEON3HARMONYLOOP2
   DUNGEON3TRILLFLOOP:
   .BYTE $E0
   .BYTE $08,$38,$78,$DA,$08,$D9 
   .BYTE $E1
   .BYTE $08,$38,$78,$DA,$08,$D9 
   .BYTE $E2
   .BYTE $08,$38,$78,$DA,$08,$D9 
   .BYTE $E3
   .BYTE $08,$38,$78,$DA,$08,$D9 
   .BYTE $D0
   .WORD DUNGEON3HARMONYLOOP1

MARSHCAVE_TRI:
   .BYTE $FE
   .BYTE $DB,$38,$28,$08,$DA,$98,$88,$78,$58,$38,$28,$08,$D9,$98,$88,$78,$58,$38,$28
   DUNGEON3TRILOOP:
   .BYTE $06,$C6,$06,$74,$86,$36,$D8,$76,$D9 ; 1
   .BYTE $06,$C6,$06,$74,$86,$36,$D8,$76,$D9 ; 2
   .BYTE $06,$C6,$06,$74,$86 ; 3/3
   .BYTE $F0
   .WORD DUNGEON3TRIFLOOP1
   .BYTE $36,$56 ; 3/4
   .BYTE $06,$C6,$D8,$A6,$D9,$55,$C8,$56,$76,$86 ; 4
   .BYTE $D1
   .WORD DUNGEON3TRILOOP
   DUNGEON3TRIFLOOP1:
   .BYTE $56,$36,$24,$84,$94,$84
   DUNGEON3TRILOOP2:
   .BYTE $D9,$08,$D8,$A8,$D9,$06,$D8,$78,$58,$76,$C6,$76,$86,$A6
   .BYTE $D9,$08,$D8,$A8,$D9,$06,$D8,$78,$58,$76,$C6,$D9,$06,$26,$D8,$A6
   .BYTE $D9,$08,$D8,$A8,$D9,$06,$D8,$78,$58,$76,$C6
   .BYTE $F0
   .WORD DUNGEON3TRIFLOOP2
   .BYTE $D9,$38,$C8,$38,$C8,$28,$C8
   .BYTE $08,$D8,$38,$D9,$08,$C8,$38,$C8,$58,$C8,$38,$D8,$38,$D9,$08,$D8,$A8,$88,$38,$68,$A8
   .BYTE $D1
   .WORD DUNGEON3TRILOOP2
   DUNGEON3TRIFLOOP2:
   .BYTE $76,$56,$26
   DUNGEON3TRILOOP3:
   .BYTE $06,$78,$D9,$38,$08,$78,$38,$D8,$78
   .BYTE $D1
   .WORD DUNGEON3TRILOOP3   
   .BYTE $D9,$D0
   .WORD DUNGEON3TRILOOP

MARSHCAVE_SQ3:
   .BYTE $FE
   .BYTE $F8,$08
   .BYTE $ED
   .BYTE $F5,$01  ; set duty to 12.5%
   .BYTE $F3,$01  ; set octave to -1 
   .BYTE $C0,$D9
   .BYTE $D0
   .WORD DUNGEON3TRILOOP

   
   ;; JIGS - below is Marsh Cave's original song data
   
 MARSHCAVEOLD_SQ1:

   .byte $FB
   D3LOOP0:
   .byte $F8,$08,$E1
   D3LOOP0A:
   .byte $D9,$69,$79,$89,$79,$69,$79,$89,$A9,$89,$79,$39
   .byte $09,$69,$79,$89,$79,$69,$79,$89,$A9,$89,$79,$39,$09,$39,$49,$79
   .byte $A9,$B9,$DA,$09,$19,$09,$D9,$B9,$DA,$09,$19,$39,$19,$09,$D9,$89
   .byte $59,$B9,$DA,$09,$19,$09,$D9,$B9,$DA,$09,$19,$39,$19,$09,$D9,$89
   .byte $59,$DA,$09,$D9,$A9,$89,$59
   .byte $D1
   .WORD D3LOOP0A ; $C4,$85
   D3LOOP0B:
   .byte $F8,$07,$EE,$DA,$79,$89
   .byte $72,$C7,$C5,$A5,$95,$85
   .byte $D1
   .WORD D3LOOP0B ; $0A,$86
   D3LOOP0C:
   .byte $DB,$09,$19,$02,$C7,$C5,$35
   .byte $25,$15
   .byte $D1
   .WORD D3LOOP0C ; $19,$86
   .byte $D0
   .WORD D3LOOP0 ; $C1,$85

MARSHCAVEOLD_SQ2:

   .byte $FB
   D3LOOP1:
   .byte $F8,$06,$E1
   D3LOOP1A:
   .byte $D8,$77,$C5,$77
   .byte $C5,$C5,$77,$C7,$77,$C7,$77,$C7,$D9,$07,$C5,$07,$C5,$07,$C5,$07
   .byte $C5,$07,$C7
   .byte $D1
   .WORD D3LOOP1A ; $2C,$86
   D3LOOP1B:
   .byte $F8,$08,$EB,$25,$07,$55,$27,$73,$57,$57
   .byte $47,$47,$37,$37
   .byte $D1
   .WORD D3LOOP1B ; $46,$86
   D3LOOP1C:
   .byte $75,$57,$A5,$77,$DA,$03,$D9,$A7,$A7
   .byte $97,$97,$87,$87
   .byte $D1
   .WORD D3LOOP1C ; $57,$86
   .byte $D0
   .WORD D3LOOP1 ; $29,$86
   
MARSHCAVEOLD_SQ3:   
   .byte $F4, $FB, $C5, $D0
   .word MARSHCAVEOLD_SQ1
   
MARSHCAVEOLD_SQ4:   
   .byte $F4, $FB, $C5, $D0
   .word MARSHCAVEOLD_SQ2   

MARSHCAVEOLD_TRI:

   .byte $FB
   D3LOOP2:
   .byte $F8,$08,$EC
   D3LOOP2A:
   .byte $D9,$07
   .byte $C5,$07,$C5,$C5,$07,$C7,$07,$C7,$07,$C7,$57,$C5,$57,$C5,$57,$C5
   .byte $57,$C5,$57,$C7
   .byte $D1
   .WORD D3LOOP2A ; $6E,$86
   D3LOOP2B:
   .byte $77,$6C,$5C,$4C,$57,$67,$77,$6C,$5C
   .byte $4C,$57,$67,$77,$6C,$5C,$4C,$A7,$DA,$07,$D9,$97,$B7,$87,$A7
   .byte $D1
   .WORD D3LOOP2B ; $87,$86
   D3LOOP2C:
   .byte $DA,$07,$D9,$BC,$AC,$9C,$A7,$B7,$DA,$07,$D9,$BC,$AC,$9C
   .byte $A7,$B7,$DA,$07,$D9,$BC,$AC,$9C,$DA,$37,$57,$27,$47,$17,$37
   .byte $D1
   .WORD D3LOOP2C ; $A2,$86
   .byte $D0
   .WORD D3LOOP2 ; $6B,$86  
   
   
   
   
SEASHRINE_SQ1:
.BYTE $F5,$02 ; JIGS - set duty to 25%, as Marsh Cave will set it different but never swap back to the original game's setting
   .byte $FB
   D4LOOP0:
   .byte $F8,$08,$EE,$DA,$43,$D9,$B5,$DA,$B5,$95,$75
   .byte $65,$45,$73,$41,$C3,$C5,$45,$D9,$B5,$DA,$B5,$DB,$25,$05,$DA,$B5
   .byte $95,$B1,$C3,$75,$95,$B3,$25,$75,$65,$45,$65,$75,$43,$D9,$B3,$DA
   .byte $22,$D9,$B5,$DA,$05,$45,$B5,$95,$53,$75,$95,$71,$61
   .byte $D0
   .WORD D4LOOP0 ; $05,$93
   
   
SEASHRINE_SQ2:
.BYTE $F5,$01 ; JIGS - set duty to 12.5%, as Marsh Cave will set it different but never swap back to the original game's setting
   .byte $FB
   D4LOOP1:
   .byte $F8,$03,$EB,$D8,$B7,$D9,$77,$67,$77,$47,$77,$27,$77,$D8,$97
   .byte $D9,$67,$47,$67,$27,$67,$07,$67,$D8,$77,$D9,$47,$27,$47,$07,$47
   .byte $D8,$B7,$D9,$47,$D8,$97,$D9,$47,$D8,$77,$D9,$47,$D8,$97,$D9,$67
   .byte $27,$67,$D8,$B7,$D9,$77,$67,$77,$47,$77,$27,$77,$D8,$97,$D9,$67
   .byte $47,$67,$27,$67,$07,$67,$D8,$97,$D9,$47,$27,$47,$17,$47,$D8,$B7
   .byte $D9,$47,$D8,$77,$D9,$47,$07,$47,$D8,$77,$D9,$47,$07,$47,$F8,$03
   .byte $E2,$77,$B7,$97,$B7,$C7,$B7,$97,$B7,$67,$97,$77,$97,$C7,$97,$77
   .byte $97,$47,$77,$67,$77,$C7,$77,$67,$77,$27,$67,$47,$67,$C7,$67,$47
   .byte $67,$47,$77,$67,$77,$C7,$77,$67,$77,$97,$DA,$07,$D9,$B7,$DA,$07
   .byte $C7,$07,$D9,$B7,$DA,$07,$F8,$03,$E6,$D8,$97,$F8,$03,$E2,$D9,$99
   .byte $C9,$79,$C9,$D8,$99,$C9,$D9,$99,$C9,$F8,$05,$E6,$75,$F8,$03,$E2
   .byte $99,$C9,$F8,$03,$E6,$27,$F8,$03,$E2,$DA,$29,$C9,$09,$C9,$D9,$29
   .byte $C9,$DA,$29,$F8,$05,$E6,$C9,$05,$F8,$03,$E2,$29,$C9
   .byte $D0
   .WORD D4LOOP1 ; $41,$93

SEASHRINE_SQ3:   
   .byte $F4, $FB, $C5, $D0
   .word SEASHRINE_SQ1
   
SEASHRINE_SQ4:   
   .byte $F4, $FB, $C5, $D0
   .word SEASHRINE_SQ2   
   
SEASHRINE_TRI:
   .byte $FB
   D4LOOP2:
   .byte $F8,$08,$EC,$D9,$41,$21,$01,$03,$23,$41,$21,$11,$01,$D8,$77
   .byte $D9,$79,$C6,$79,$C9,$D8,$77,$D9,$79,$C6,$79,$C9,$27,$99,$C6,$99
   .byte $C9,$27,$99,$C6,$99,$C9,$47,$B9,$C6,$B9,$C9,$47,$B9,$C6,$B9,$C9
   .byte $D8,$B7,$D9,$B9,$C6,$B9,$C9,$D8,$B7,$D9,$B9,$C6,$B9,$C9,$07,$DA
   .byte $09,$C6,$09,$C9,$D9,$07,$DA,$09,$C6,$09,$C9,$D9,$57,$DA,$09,$C6
   .byte $09,$C9,$D9,$57,$DA,$09,$C6,$09,$C9,$D9,$27,$DA,$29,$C9,$09,$C9
   .byte $D9,$29,$C9,$DA,$29,$C9,$05,$29,$C9,$D9,$97,$DA,$69,$C9,$49,$C9
   .byte $D9,$99,$C9,$DA,$69,$C9,$45,$69,$C9
   .byte $D0
   .WORD D4LOOP2 ; $11,$94


SKYCASTLE_SQ1:
.BYTE $F5,$02 ; JIGS - set duty to 25%, as Marsh Cave will set it different but never swap back to the original game's setting
   D5LOOP0:
   .byte $FD,$F8,$06,$EC
   D5LOOP0A:
   .byte $F8,$05,$EC,$DA,$A7,$C7,$C2,$F8
   .byte $08,$EE,$43,$EC,$65,$A5,$EE,$81,$21,$C3,$EC,$A5,$45,$EE,$63,$EC
   .byte $85,$A5,$EE,$DB,$32,$DA,$C7,$B7,$A2,$C7,$97
   .byte $D1
   .WORD D5LOOP0A ; $E8,$8F
   D5LOOP0B:
   .byte $F8,$06
   .byte $EC,$A7,$C4,$F8,$08,$A7,$B7,$A7,$87,$EE,$A1,$F8,$06,$EC,$37,$C4
   .byte $F8,$08,$37,$47,$37,$17,$EE,$31
   .byte $D1
   .WORD D5LOOP0B ; $0E,$90
   .byte $DA,$F8,$05,$E1,$37
   .byte $37,$37,$37,$27,$27,$27,$27,$17,$17,$17,$17,$07,$FC,$07,$FB,$07
   .byte $FA,$07
   .byte $D0
   .WORD D5LOOP0 ; $E4,$8F

SKYCASTLE_SQ2:
.BYTE $F5,$01 ; JIGS - set duty to 12.5%, as Marsh Cave will set it different but never swap back to the original game's setting
   D5LOOP1:
   .byte $FD,$F8,$06,$EC
   D5LOOP1A:
   .byte $F8,$05,$EC,$D9,$A7,$C7,$C2
   .byte $F8,$08,$EE,$43,$EC,$65,$A5,$EE,$81,$21,$C3,$EC,$A5,$45,$EE,$63
   .byte $EC,$85,$A5,$EE,$DA,$32,$D9,$B5,$A2,$C7,$97
   .byte $D1
   .WORD D5LOOP1A ; $49,$90
   D5LOOP1B:
   .byte $F8,$06
   .byte $EC,$DA,$37,$C7,$27,$C7,$F8,$08,$EE,$13,$F8,$06,$EC,$07,$C7,$D9
   .byte $B7,$C7,$F8,$08,$EE,$A3,$F8,$06,$EC,$97,$C7,$87,$C7,$F8,$08,$EE
   .byte $73,$F8,$06,$EC,$67,$C7,$57,$C7,$F8,$08,$EE,$43
   .byte $D1
   .WORD D5LOOP1B ; $6E,$90
   .byte $F8
   .byte $05,$E1,$37,$37,$37,$37,$27,$27,$27,$27,$17,$17,$17,$17,$07,$FC
   .byte $07,$FB,$07,$FA,$07
   .byte $D0
   .WORD D5LOOP1 ; $45,$90
   
SKYCASTLE_SQ3:   
   .byte $F4, $FD, $C4, $D0
   .word SKYCASTLE_SQ1
   
SKYCASTLE_SQ4:   
   .byte $F4, $FD, $C4, $D0
   .word SKYCASTLE_SQ2
   
   
   

SKYCASTLE_TRI:
   D5LOOP2:
   .byte $FD,$F8,$08,$EC
   D5LOOP2A:
   .byte $D8,$A7,$C7,$D9
   .byte $47,$C7,$A7,$C7,$DA,$37,$C7,$D8,$87,$C7,$D9,$27,$C7,$87,$C7,$DA
   .byte $17,$C7
   .byte $D7
   .WORD D5LOOP2A ; $BC,$90
   D5LOOP2B:
   .byte $D9,$37,$C7,$A7,$C7,$DA,$13,$D9,$17,$C7,$15
   .byte $87,$C7,$B7,$C7
   .byte $D3
   .WORD D5LOOP2B ; $D5,$90
   .byte $C1,$C3,$C7,$FC,$C7,$FB,$C7,$FA,$C7
   .byte $D0
   .WORD D5LOOP2 ; $B8,$90

FIENDTEMPLE_SQ1:
.BYTE $F5,$02 ; JIGS - set duty to 25%, as Marsh Cave will set it different but never swap back to the original game's setting
   .byte $FB
   D6LOOP0:
   .byte $F8,$08,$EE,$D9,$B3,$85,$B5,$A5,$85,$65
   .byte $A5,$80,$C3,$B3,$DA,$15,$D9,$B5,$A5,$85,$65,$DA,$45,$30,$F8,$08
   .byte $E2,$C5,$D9,$3C,$5C,$6C,$7C,$8C,$9C,$F8,$08,$EC,$A3,$B5,$DA,$15
   .byte $D9,$B5,$A5,$85,$DA,$35,$13,$35,$45,$33,$D9,$B3,$C3,$DA,$35,$15
   .byte $D9,$B5,$A5,$85,$B5,$F8,$08,$EE,$A0,$C3
   .byte $D0
   .WORD D6LOOP0 ; $C6,$86

FIENDTEMPLE_SQ2:
.BYTE $F5,$01 ; JIGS - set duty to 12.5%, as Marsh Cave will set it different but never swap back to the original game's setting
   .byte $FB
   D6LOOP1:
   .byte $F8,$03
   .byte $EB,$D8,$B7,$D9,$37,$17,$37,$D8,$B7,$D9,$37,$17,$37,$D8,$A7,$D9
   .byte $37,$17,$37,$D8,$A7,$D9,$37,$17,$37,$D8,$87,$D9,$37,$17,$37,$D8
   .byte $87,$D9,$37,$17,$37,$D8,$A7,$D9,$37,$17,$37,$D8,$A7,$D9,$37,$17
   .byte $37,$D8,$B7,$D9,$37,$17,$37,$D8,$B7,$D9,$37,$17,$37,$D8,$A7,$D9
   .byte $37,$17,$37,$D8,$A7,$D9,$37,$17,$37,$D8,$87,$D9,$37,$17,$37,$D8
   .byte $87,$D9,$37,$17,$37,$D8,$87,$D9,$17,$D8,$B7,$D9,$17,$D8,$87,$D9
   .byte $17,$D8,$B7,$D9,$17,$F8,$03,$E2,$37,$37,$C7,$D8,$A7,$D9,$37,$37
   .byte $C7,$D8,$A7,$D9,$37,$37,$C7,$D8,$B7,$D9,$37,$37,$C7,$D8,$B7,$D9
   .byte $47,$47,$C7,$17,$47,$47,$C7,$17,$67,$67,$C7,$37,$67,$67,$C7,$37
   .byte $F8,$08,$EE,$83,$C7,$F8,$03,$EB,$D8,$B7,$D9,$47,$87,$F8,$08,$EE
   .byte $43,$C7,$F8,$03,$EB,$D8,$87,$D9,$17,$47,$F8,$08,$EE,$73,$C7,$F8
   .byte $03,$EB,$D8,$A7,$D9,$37,$77,$D8,$77,$A7,$D9,$17,$47,$77,$47,$17
   .byte $D8,$A7
   .byte $D0
   .WORD D6LOOP1 ; $0E,$87
   
FIENDTEMPLE_SQ3:   
   .byte $F4, $FB, $C5, $D0
   .word FIENDTEMPLE_SQ1
   
FIENDTEMPLE_SQ4:   
   .byte $F4, $FB, $C5, $D0
   .word FIENDTEMPLE_SQ2   

FIENDTEMPLE_TRI:
   .byte $FB
   D6LOOP2:
   .byte $F8,$08,$EC,$D9,$89,$C9,$89,$C9,$C5,$C3
   .byte $69,$C9,$69,$C9,$C5,$C3,$49,$C9,$49,$C9,$C5,$C3,$69,$C9,$69,$C9
   .byte $C5,$C3,$89,$C9,$89,$C9,$C5,$C3,$69,$C9,$69,$C9,$C5,$C3,$49,$C9
   .byte $49,$C9,$C5,$C3,$59,$C9,$59,$C9,$C5,$C3,$79,$C9,$79,$C9,$C7,$C5
   .byte $DA,$37,$77,$37,$D9,$89,$C9,$89,$C9,$C7,$C5,$DA,$37,$87,$37,$D9
   .byte $A9,$C9,$A9,$C9,$C7,$C5,$DA,$67,$A7,$67,$D9,$B9,$C9,$B9,$C9,$C7
   .byte $C5,$DA,$67,$B7,$67,$41,$11,$31,$41
   .byte $D0
   .WORD D6LOOP2 ; $D6,$87

SHOP_SQ1:
.BYTE $F5,$02 ; JIGS - set duty to 25%, as Marsh Cave will set it different but never swap back to the original game's setting
   .byte $FD
   S1LOOP0:
   .byte $F8,$09,$EC,$DA,$73,$65,$73,$95,$72,$43,$55,$75,$DB,$05
   .byte $DA,$B5,$DB,$25,$05,$DA,$95,$73,$85,$93,$45,$51,$C3,$C3,$65,$73
   .byte $25,$41,$C3,$C3,$85,$93,$45,$55,$25,$45,$65,$B5,$95,$75,$65,$75
   .byte $85,$DB,$05,$DA,$B5,$95,$B5,$DB,$05,$25,$05,$DA,$85,$F8,$04,$E1
   .byte $77,$C7,$DB,$07,$C7,$47,$C7,$27,$C7,$C3,$F8,$09,$EC,$DA,$B5,$75
   .byte $B5,$95,$55,$95,$75,$25,$75,$55,$25,$55
   .byte $D0
   .WORD S1LOOP0 ; $02,$8E

SHOP_SQ2:
.BYTE $F5,$01 ; JIGS - set duty to 12.5%, as Marsh Cave will set it different but never swap back to the original game's setting
   .byte $FD
   S1LOOP1:
   .byte $F8,$08
   .byte $EA,$D9,$43,$35,$43,$55,$42,$03,$25,$43,$45,$53,$55,$43,$45,$13
   .byte $15,$21,$C3,$C2,$03,$D8,$B5,$D9,$02,$D8,$B5,$D9,$05,$D8,$B5,$A2
   .byte $D9,$13,$15,$02,$32,$42,$22,$53,$55,$85,$75,$55,$F8,$04,$E2,$47
   .byte $C7,$57,$C7,$77,$C7,$B7,$C7,$C3,$F8,$08,$EA,$22,$02,$D8,$B2,$72
   .byte $D0
   .WORD S1LOOP1 ; $5E,$8E
   
SHOP_SQ3:   
   .byte $F4, $FD, $C5, $D0
   .word SHOP_SQ1
   
SHOP_SQ4:   
   .byte $F4, $FD, $C5, $D0
   .word SHOP_SQ2

SHOP_TRI:
   .byte $FD
   S1LOOP2:
   .byte $F8,$08,$EC,$D9,$05,$77,$C7,$77,$C7,$05,$77,$C7
   .byte $77,$C7,$05,$77,$C7,$77,$C7,$05,$77,$C7,$77,$C7,$05,$77,$C7,$77
   .byte $C7,$05,$97,$C7,$97,$C7,$05,$77,$C7,$77,$C7,$D8,$95,$D9,$47,$C7
   .byte $47,$C7,$25,$97,$C7,$97,$C7,$25,$A7,$C7,$A7,$C7,$25,$B7,$C7,$B7
   .byte $C7,$D8,$75,$D9,$77,$C7,$77,$C7,$05,$77,$C7,$77,$C7,$D8,$B5,$D9
   .byte $77,$C7,$77,$C7,$D8,$A5,$D9,$47,$C7,$47,$C7,$D8,$95,$D9,$47,$C7
   .byte $47,$C7,$25,$97,$C7,$97,$C7,$35,$97,$C7,$97,$C7,$45,$B7,$C7,$B7
   .byte $C7,$45,$87,$C7,$87,$C7,$55,$DA,$07,$C7,$07,$C7,$D9,$55,$DA,$07
   .byte $C7,$07,$C7,$D9,$07,$C7,$27,$C7,$47,$C7,$77,$C7,$C3,$C2,$C2,$C2
   .byte $D8,$77,$C7,$97,$C7,$B7,$C7
   .byte $D0
   .WORD S1LOOP2 ; $A4,$8E

BATTLE_SQ1:
.BYTE $F5,$02 ; JIGS - set duty to 25%, as Marsh Cave will set it different but never swap back to the original game's setting
   .byte $FB,$F8,$08,$E1
   .byte $D8,$3C,$6C,$9C,$D9,$0C,$3C,$6C,$9C,$DA,$0C,$3C,$6C,$9C,$DB,$0C
   .byte $C1,$C3,$C5,$C7,$F8,$08,$E0,$D9,$57
   BLOOP0:
   .byte $F8,$05,$E0,$79,$C9,$DA,$29
   .byte $C9,$F8,$08,$EE,$13,$F8,$08,$E0,$D9,$A7,$97,$75,$77,$97,$A5,$97
   .byte $F8,$08,$57,$F8,$05,$79,$C9,$DA,$29,$C9,$F8,$08,$EE,$14,$F8,$08
   .byte $E0,$D9,$97,$F8,$05,$A9,$C9,$DA,$59,$C9,$F8,$08,$EE,$42,$F8,$08
   .byte $E0,$C7,$D9,$57,$F8,$05,$79,$C9,$DA,$29,$C9,$F8,$08,$EE,$13,$F8
   .byte $08,$E0,$D9,$A7,$97,$75,$77,$97,$A5,$97,$F8,$08,$E0,$57,$F8,$05
   .byte $79,$C9,$DA,$29,$C9,$F8,$08,$EE,$14,$D9,$F8,$08,$E0,$97,$F8,$05
   .byte $A9,$C9,$DA,$59,$C9,$F8,$09,$EC,$41
   BLOOP0A:
   .byte $F8,$08,$E0,$C5,$74,$74,$F8
   .byte $08,$E0,$67,$C7,$C5,$C5,$C5
   .byte $D1
   .WORD BLOOP0A ; $19,$95
   .byte $F8,$08,$E0,$C5,$24,$34
   .byte $54,$34,$25,$C5,$D9,$94,$A4,$DA,$04,$D9,$A4,$95,$C5,$DA,$24,$34
   .byte $54,$34,$25,$C5,$D9,$94,$A4,$DA,$04,$D9,$A4,$95,$75,$65,$75,$95
   .byte $A5,$95,$A5,$DA,$05,$F8,$05,$E0,$29,$C9,$29,$C9,$29,$C9,$29,$C9
   .byte $C7,$F8,$04,$EE,$35,$F8,$05,$E0,$59,$C9,$29,$C9,$C7,$F8,$04,$EE
   .byte $D9,$95,$DA,$25,$65,$F8,$05,$E0,$39,$C9,$39,$C9,$39,$C9,$39,$C9
   .byte $C7,$F8,$04,$EE,$55,$F8,$05,$E0,$79,$C9,$29,$C9,$C7,$29,$09,$D9
   .byte $A9,$99,$DA,$09,$D9,$A9,$99,$79,$A9,$99,$79,$69
   .byte $D0
   .WORD BLOOP0 ; $A9,$94

BATTLE_SQ2:
.BYTE $F5,$01 ; JIGS - set duty to 12.5%, as Marsh Cave will set it different but never swap back to the original game's setting
   .byte $FB
   .byte $F8,$08,$E2,$CC,$CC,$D8,$3C,$6C,$9C,$D8,$0C,$3C,$6C,$9C,$D9,$0C
   .byte $3C,$6C,$9C,$DA,$0C,$CC,$C7,$C5,$C5,$C5,$C1
   BLOOP1:
   BLOOP1A:
   .byte $F8,$06,$EC,$D8,$29
   .byte $C9,$29,$C9,$45,$59,$C9,$59,$C9,$45,$29,$C9,$29,$C9,$45,$59,$C9
   .byte $59,$C9,$05,$29,$C9,$29,$C9,$45,$59,$C9,$59,$C9,$45,$29,$C9,$29
   .byte $C9,$45,$59,$29,$49,$79,$59,$49,$29,$09
   .byte $D1
   .WORD BLOOP1A ; $BB,$95
   .byte $D8,$A9,$C9
   .byte $A9,$C9,$D9,$F8,$08,$E1,$34,$34,$F8,$08,$E1,$27,$C7,$D8,$27,$27
   .byte $67,$67,$97,$97,$D8,$A9,$C9,$A9,$C9,$D9,$F8,$08,$E1,$34,$34,$F8
   .byte $08,$E1,$27,$C7,$C7,$69,$79,$69,$39,$29,$09,$D8,$A9,$99,$79,$69
   BLOOP1B:
   .byte $F8,$03,$EB,$D8,$29,$C9,$29,$C9,$D8,$A7,$77,$27,$D9,$07,$D8,$77
   .byte $37,$D9,$27,$D8,$A7,$77,$D9,$07,$D8,$77,$37,$A7,$27,$D8,$99,$C9
   .byte $99,$C9,$D8,$67,$27,$D8,$97,$D8,$77,$27,$D8,$A7,$D8,$97,$67,$27
   .byte $77,$27,$D8,$A7,$D8,$67,$D8,$97
   .byte $D1
   .WORD BLOOP1B ; $20,$96
   .byte $F8,$05,$E1,$A9,$C9
   .byte $D8,$29,$C9,$D8,$99,$C9,$D8,$29,$C9,$D8,$A9,$C9,$D8,$29,$C9,$09
   .byte $C9,$39,$C9,$29,$C9,$59,$C9,$09,$C9,$59,$C9,$29,$C9,$59,$C9,$39
   .byte $C9,$79,$C9,$69,$C9,$69,$C9,$69,$C9,$69,$C9,$C7,$F8,$04,$EE,$75
   .byte $F8,$05,$E1,$99,$C9,$69,$C9,$C7,$F8,$04,$EE,$25,$95,$D9,$25,$F8
   .byte $05,$E1,$D8,$79,$C9,$79,$C9,$79,$C9,$79,$C9,$C7,$F8,$04,$EE,$95
   .byte $F8,$05,$E1,$A9,$C9,$69,$C9,$C7,$C5,$C5,$C5
   .byte $D0
   .WORD BLOOP1 ; $BB,$95
   
BATTLE_SQ3:   
   .byte $F4, $FB, $C5, $D0
   .word BATTLE_SQ1
   
BATTLE_SQ4:   
   .byte $F4, $FB, $C5, $D0
   .word BATTLE_SQ2   
   
BATTLE_TRI:
   .byte $FB,$F8
   .byte $08,$E0,$C3
   BLOOP2A:
   .byte $D8,$79,$C9,$79,$C9,$79,$C9,$79,$C9,$79,$C9,$79,$C9
   .byte $59,$C9,$59,$C9
   .byte $D1
   .WORD BLOOP2A ; $C3,$96
   BLOOP2:
   BLOOP2B:
   .byte $77,$D9,$79,$C9,$D8,$97,$D9,$99,$C9
   .byte $D8,$A7,$D9,$A9,$C9,$07,$DA,$09,$C9,$D8,$77,$D9,$79,$C9,$D8,$97
   .byte $D9,$99,$C9,$D8,$A7,$D9,$A9,$C9,$D8,$97,$D9,$99,$C9
   .byte $D3
   .WORD BLOOP2B ; $D7,$96
   .byte $39,$C9,$39,$C9,$DA,$A9,$99,$79,$69,$39,$29,$09,$D9,$A9,$99,$79
   .byte $69,$39,$27,$C7,$69,$C9,$69,$C9,$99,$C9,$99,$C9,$DA,$29,$C9,$29
   .byte $C9,$D9,$39,$C9,$39,$C9,$DA,$A9,$99,$79,$69,$39,$29,$09,$D9,$A9
   .byte $99,$79,$69,$39,$27,$C7,$C7,$DB,$29,$39,$29,$09,$DA,$A9,$99,$79
   .byte $69,$39,$29
   BLOOP2C:
   .byte $D8,$79,$C9,$79,$C9,$D9,$77,$D8,$79,$C9,$79,$C9,$D9
   .byte $77,$D8,$79,$C9,$79,$C9,$D9,$77,$D8,$79,$C9,$79,$C9,$D9,$77,$D8
   .byte $79,$C9,$79,$C9,$D9,$77,$D8,$79,$C9,$29,$C9,$29,$C9,$D9,$27,$D8
   .byte $29,$C9,$29,$C9,$D9,$27,$D8,$29,$C9,$29,$C9,$D9,$27,$D8,$29,$C9
   .byte $29,$C9,$D9,$27,$D8,$29,$C9,$29,$C9,$D9,$27,$D8,$29,$C9
   .byte $D1
   .WORD BLOOP2C ; $43,$97
   .byte $75,$D9,$25,$D8,$A5,$D9,$55,$D8,$A5,$D9,$55,$D8,$A5,$D9,$05
   .byte $29,$C9,$29,$C9,$29,$C9,$29,$C9,$C7,$07,$C7,$09,$C9,$29,$C9,$C7
   .byte $DA,$05,$75,$DB,$05,$D9,$39,$C9,$39,$C9,$39,$C9,$39,$C9,$C7,$37
   .byte $C7,$39,$C9,$29,$C9,$C7,$25,$45,$65
   .byte $D0
   .WORD BLOOP2 ; $D7,$96


MENU_SQ1:
.BYTE $F5,$02 ; JIGS - set duty to 25%, as Marsh Cave will set it different but never swap back to the original game's setting
   .byte $FC
   MLOOP0:
   .byte $F8,$08,$EE
   .byte $D9,$A3,$DA,$A5,$93,$35,$23,$75,$53,$D9,$A5,$B1,$C5,$DA,$25,$03
   .byte $D9,$71,$71,$95,$B5,$DA,$07,$D9,$77,$97,$B7,$DA,$07,$27,$37,$57
   .byte $77,$87,$A7,$DB,$07,$DA,$A1,$C5,$97,$77,$91,$D9,$75,$95
   .byte $D0
   .WORD MLOOP0 ; $CD,$97

MENU_SQ2:
.BYTE $F5,$01 ; JIGS - set duty to 12.5%, as Marsh Cave will set it different but never swap back to the original game's setting
   .byte $FC
   MLOOP1:
   .byte $F8,$08,$E3,$D9,$A3,$DA,$A5,$93,$35,$23,$75,$53,$D9,$A5
   .byte $B1,$C5,$DA,$25,$03,$D9,$71,$71,$95,$B5,$DA,$07,$D9,$77,$97,$B7
   .byte $DA,$07,$27,$37,$57,$77,$87,$A7,$DB,$07,$DA,$A1,$C5,$97,$77,$91
   .byte $D9,$75,$95
   .byte $D0
   .WORD MLOOP1 ; $02,$98
   
MENU_SQ3:   
   .byte $F4, $FC, $C5, $D0
   .word MENU_SQ1
   
MENU_SQ4:   
   .byte $F4, $FC, $C5, $D0
   .word MENU_SQ2   

MENU_TRI:
   .byte $FC
   MLOOP2:
   .byte $F8,$08,$EC,$D9,$A5,$DA,$25,$55,$D9
   .byte $A5,$DA,$35,$95,$D9,$A5,$DA,$25,$55,$D9,$95,$DA,$25,$55,$D9,$85
   .byte $B5,$DA,$25,$D9,$75,$B5,$DA,$25,$D9,$75,$DA,$05,$35,$D9,$B5,$DA
   .byte $25,$55,$D9,$75,$DA,$05,$35,$D9,$75,$DA,$25,$55,$D9,$75,$DA,$35
   .byte $75,$D9,$85,$DA,$05,$35,$D9,$55,$DA,$05,$55,$D9,$55,$DA,$05,$75
   .byte $D9,$55,$DA,$05,$55,$D9,$35,$DA,$05,$35
   .byte $D0
   .WORD MLOOP2 ; $37,$98

SLAIN_SQ1:
.BYTE $F5,$02 ; JIGS - set duty to 25%, as Marsh Cave will set it different but never swap back to the original game's setting
   .byte $FC,$F8,$07
   .byte $E5,$D9,$95,$DA,$15,$25,$45
   SLAIN_LOOP0:
   .byte $52,$D9,$95,$A3,$DA,$75,$55,$45,$55
   .byte $45,$D9,$75,$91,$DA,$22,$D9,$55,$43,$B5,$DA,$25,$25,$15,$42,$15
   .byte $25,$45,$52,$D9,$95,$A3,$DA,$75,$55,$45,$55,$45,$D9,$75,$93,$A5
   .byte $DA,$05,$22,$45,$23,$13,$21,$C1
   .byte $D0
   .WORD SLAIN_LOOP0 ; $97,$98

SLAIN_SQ2:
.BYTE $F5,$01 ; JIGS - set duty to 12.5%, as Marsh Cave will set it different but never swap back to the original game's setting
   .byte $FC,$F8,$07,$E6,$C1
   SLAIN_LOOP1:
   .byte $D9,$93,$53,$73,$A3,$73,$43,$53,$03,$53,$23,$D8,$B3,$D9,$83,$91
   .byte $71,$D9,$93,$53,$73,$A3,$73,$43,$53,$03,$53,$93,$73,$43,$51,$C1
   .byte $D0
   .WORD SLAIN_LOOP1 ; $D0,$98
   
SLAIN_SQ3:   
   .byte $F4, $FC, $C5, $D0
   .word SLAIN_SQ1
   
SLAIN_SQ4:   
   .byte $F4, $FC, $C5, $D0
   .word SLAIN_SQ2   
   
SLAIN_TRI:
   .byte $FC,$F8,$08,$EC,$C1
   SLAIN_LOOP2:
   .byte $DA,$21,$71,$01,$51,$D9,$A1,$DA
   .byte $41,$D9,$91,$DA,$93,$43,$DA,$21,$71,$01,$51,$D9,$B1,$91,$DB,$25
   .byte $DA,$95,$75,$95,$22,$C5
   .byte $D0
   .WORD SLAIN_LOOP2 ; $F8,$98

BATTLEWIN_SQ1:
.BYTE $F5,$02 ; JIGS - set duty to 25%, as Marsh Cave will set it different but never swap back to the original game's setting
   .byte $FB,$F8,$08,$E1,$D8,$3C,$7C
   .byte $AC,$D8,$3C,$7C,$AC,$D9,$3C,$7C,$AC,$DA,$3C,$7C,$AC,$F8,$08,$EC
   .byte $DB,$3C,$CC,$3C,$CC,$3C,$CC,$35,$DA,$B5,$DB,$15,$F8,$05,$3C,$CC
   .byte $CC,$CC,$1C,$CC,$F8,$08,$EE,$32
   FLOOP0:
   .byte $F8,$08,$EC,$D9,$A5,$85,$A5,$87
   .byte $DA,$15,$DA,$17,$05,$17,$05,$07,$D9,$A5,$85,$75,$87,$F8,$08,$EE
   .byte $51,$C7,$F8,$08,$EC,$A5,$85,$A5,$87,$DA,$15,$17,$05,$17,$05,$07
   .byte $D9,$A5,$85,$A5,$DA,$17,$F8,$08,$EE,$31,$C7
   .byte $D0
   .WORD FLOOP0 ; $48,$99

BATTLEWIN_SQ2:
.BYTE $F5,$01 ; JIGS - set duty to 12.5%, as Marsh Cave will set it different but never swap back to the original game's setting
   .byte $FB,$F8
   .byte $08,$E2,$CC,$CC,$D8,$3C,$7C,$AC,$D8,$3C,$7C,$AC,$D9,$3C,$7C,$AC
   .byte $DA,$3C,$F8,$08,$EC,$7C,$CC,$7C,$CC,$7C,$CC,$75,$35,$55,$F8,$05
   .byte $7C,$CC,$CC,$CC,$5C,$CC,$F8,$08,$EE,$72
   BATTLEWIN_LOOP1:
   .byte $F8,$08,$EC,$D9,$75,$55
   .byte $75,$57,$55,$57,$35,$57,$35,$37,$75,$55,$35,$57,$F8,$08,$EE,$11
   .byte $C7,$F8,$08,$EC,$D9,$75,$55,$75,$57,$55,$57,$35,$57,$35,$37,$75
   .byte $55,$75,$A7,$F8,$08,$EE,$B1,$C7
   .byte $D0
   .WORD BATTLEWIN_LOOP1 ; $AA,$99

BATTLEWIN_SQ3:   
   .byte $F4, $FB, $C5, $D0
   .word BATTLEWIN_SQ1
   
BATTLEWIN_SQ4:   
   .byte $F4, $FB, $C5, $D0
   .word BATTLEWIN_SQ2   
   
BATTLEWIN_TRI:
   .byte $FB,$F8,$08,$EC,$C3
   .byte $DA,$3C,$CC,$D9,$AC,$CC,$7C,$CC,$35,$65,$85,$3C,$CC,$CC,$CC,$3C
   .byte $CC,$37,$C7,$37,$C7,$37,$C7
   BATTLEWIN_LOOP2:
   .byte $D9,$37,$A9,$C9,$37,$A9,$C9,$37,$A9
   .byte $C9,$37,$A9,$C9,$17,$89,$C9,$17,$89,$C9,$17,$89,$C9,$17,$89,$C9
   .byte $37,$A9,$C9,$37,$A9,$C9,$37,$A9,$C9,$37,$A9,$C9,$17,$89,$C9,$17
   .byte $89,$C9,$17,$89,$C9,$17,$89,$C9,$37,$A9,$C9,$37,$A9,$C9,$37,$A9
   .byte $C9,$37,$A9,$C9,$17,$89,$C9,$17,$89,$C9,$17,$89,$C9,$17,$89,$C9
   .byte $37,$A9,$C9,$37,$A9,$C9,$37,$A9,$C9,$37,$A9,$C9,$D8,$B7,$D9,$69
   .byte $C9,$D8,$B7,$D9,$69,$C9,$D8,$B7,$D9,$69,$C9,$D8,$B7,$D9,$69,$C9
   .byte $D0
   .WORD BATTLEWIN_LOOP2 ; $F7,$99

FANFARE_SQ1:
.BYTE $F5,$02 ; JIGS - set duty to 25%, as Marsh Cave will set it different but never swap back to the original game's setting
   .byte $FD,$F8,$08,$EC,$DA,$45,$25,$15,$45,$25,$15,$D9,$B5,$DA,$25,$F8
   .byte $08,$EE,$FC,$D9,$93,$FB,$B3,$DA,$12,$FF

FANFARE_SQ2:
.BYTE $F5,$01 ; JIGS - set duty to 12.5%, as Marsh Cave will set it different but never swap back to the original game's setting
   .byte $FD,$F8,$08,$EE,$D9,$91,$71,$FC,$03,$FB,$23,$42,$FF

FANFARE_TRI:
   .byte $FD,$F8,$08,$EC,$DA,$13,$43,$D9,$B3,$DA,$23,$FC,$D9,$53,$FB,$73
   .byte $92,$FF

;PRELUDE_SQ1:
;PRELUDE_SQ2:
;PRELUDE_TRI:

SAVE_SQ1:
.BYTE $F5,$02 ; JIGS - set duty to 25%, as Marsh Cave will set it different but never swap back to the original game's setting
   .byte $FB,$F8,$06,$EC,$D9,$BC,$DA,$0C,$1C,$F8,$08,$EC,$FD,$24,$27,$27
   .byte $27,$F8,$08,$EE,$FC,$34,$FB,$54,$72,$FF

SAVE_SQ2:
.BYTE $F5,$01 ; JIGS - set duty to 12.5%, as Marsh Cave will set it different but never swap back to the original game's setting
   .byte $FB,$F8,$08,$EC,$CC,$CC,$CC,$FD,$D9,$74,$B7,$97,$77,$F8,$08,$EE
   .byte $FC,$74,$FB,$DA,$04,$D9,$B2,$FF

SAVE_TRI:
   .byte $FB,$F8,$08,$EC,$CC,$CC,$CC,$FD,$D9,$B4,$DA,$27,$07,$D9,$B7,$FC
   .byte $A4,$FB,$94,$73,$FF

HEAL_SQ1:
.BYTE $F5,$02 ; JIGS - set duty to 25%, as Marsh Cave will set it different but never swap back to the original game's setting
   .byte $FB,$F8,$08,$E1,$D8,$AC,$D8,$2C,$5C,$AC,$D9,$2C,$5C,$AC,$DA,$2C
   .byte $5C,$AC,$DB,$2C,$5C,$AC,$FF
   
HEAL_SQ2:
.BYTE $F5,$01 ; JIGS - set duty to 12.5%, as Marsh Cave will set it different but never swap back to the original game's setting
   .byte $FB,$F8,$08,$E2,$C7,$D8,$AC,$D8,$2C,$5C,$AC,$D9,$2C,$5C,$AC,$DA
   .byte $2C,$5C,$AC,$DB,$2C,$5C,$AC,$FF

HEAL_TRI:
   .byte $FB,$F8,$08,$EC,$C7,$C7,$D8,$CC,$CC,$D9,$CC,$CC,$CC,$DA,$CC,$CC
   .byte $CC,$DB,$CC,$CC,$CC,$DC,$CC,$CC,$FF

TREASURE_SQ1:
.BYTE $F5,$02 ; JIGS - set duty to 25%, as Marsh Cave will set it different but never swap back to the original game's setting
   .byte $FC,$F8,$07,$E0,$DA,$79,$B9,$DB,$39,$79,$B9,$FF

TREASURE_SQ2:
.BYTE $F5,$01 ; JIGS - set duty to 12.5%, as Marsh Cave will set it different but never swap back to the original game's setting
   .byte $FC,$F8,$07,$E1,$D9,$B9,$DA,$39,$79,$B9,$DB,$39,$FF

TREASURE_TRI:
   .byte $FC,$F8,$08,$E0,$C9,$C9,$C9,$C9,$C9,$FF

BLANK:   ; For songs that need to loop
;.BYTE $E8 ; silent envelopt pattern
;.BYTE $FC ; note length LUT with shortest note
;.byte $CB ; shortest note, so SQ2 FX stuff ends and plays the next note faster
.BYTE $F9,$C0
.BYTE $D0
.WORD BLANK

BLANK2: ; For songs that need to end. (note that using this will cause a song to end prematurely once it hits the FF. So... useless. Oops.)
.BYTE $F9,$CA,$FF

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  MiniGame -- Shuffle Puzzle  [$9DA0 :: 0x35DB0]
;;
;;    This takes the puzzle and randomly shuffles the pieces a bunch of
;;  times so that the puzzle is a bit different every time you do the minigame.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

MiniGame_ShufflePuzzle:
    LDX #$7F+1               ; X is our main loop counter, and will count
                             ;  the number of random moves we are to perform ($7F random moves)

  @MainLoop:
    DEX                 ; decrement main loop counter
    BNE :+              ; and once it's zero...
      RTS               ; ... exit

:   INC framecounter    ; otherwise, increment the frame counter
    LDY framecounter    ; and use it as a seed to get a random number from the RNG lut
    LDA lut_RNG, Y

    AND #$03               ; mask out the low bits so we have a random number between 0-3.
    TAY                    ;  this is the direction from which we're going to slide a piece into the empty slot
    LDA @lut_Direction, Y  ; use that direction to get the offset needed for the direction
    STA tmp                ; store that offset in tmp

      ; now we need to find the empty slot...
    LDY #$10
  @FindEmptyLoop:
      DEY
      LDA puzzle, Y        ; simply step through all 16 entries in the puzzle until we find the empty slot (0)
      BNE @FindEmptyLoop   ; and keep looping until we find it

    STY tmp+1            ; store empty slot index in tmp+1

    TYA                 ; put empty slot index in A, and add to it the
    CLC                 ;  directional offset (in tmp).  A is now the index
    ADC tmp             ;  of the tile we want to move into the empty slot

    BMI @MainLoop       ; ensure that index is valid (between 0-F).  If < 0
    CMP #$10            ;  or if >= $10, we're trying to move a tile that doesn't
    BCS @MainLoop       ;  exist (we crossed the top or bottom of the puzzle).  So don't do
                        ;  anything, and just exit

    LDY tmp             ; put the movement offset in Y to hold it for future checks
    STA tmp             ; put the index of the tile we want to move in tmp
                        ;  tmp and tmp+1 are now the indeces in the puzzle we want to swap to complete the movement

    CPY #1              ; check the movement offset to see if we were sliding left (from right)
    BNE @CheckRight     ; if not... skip ahead

      AND #$03          ; otherwise, we're trying to move left.  Check the low 2 bits of the index of the tile
      BEQ @MainLoop     ;  we're moving to see what column we're in.  If the column=0, we can't move it left!  So jump back to loop
      BNE @LegalMove    ;  otherwise (column nonzero), moving left is legal  (always branches)

  @CheckRight:
    CPY #-1             ; see if we're trying to slide right (from the left)
    BNE @LegalMove      ;  if not, move is legal, so jump ahead to do it

      AND #$03          ; otherwise check the column
      CMP #$03          ;  if the column=3 (right-side) we can't move any more right
      BEQ @MainLoop     ;  ... so continue loop

  @LegalMove:           ; if we get here, the move is legal!  Perform it!
    LDY tmp
    LDA puzzle, Y       ; copy the tile from the slot we're moving...
    LDY tmp+1
    STA puzzle, Y       ;  ... to the empty slot

    LDY tmp
    LDA #0
    STA puzzle, Y       ; then make the slot we moved empty

    JMP @MainLoop       ; and continue looping

  @lut_Direction:
    .BYTE 1, -1, 4, -4



 ; unused
  .BYTE 3,3,3,3,3,3,3

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Minigame Puzzle piece CHR  [$9E00 : 0x35E10]
;;
;;    Must be on page boundary

  .ALIGN  $100
lut_MinigameCHR:
  .INCBIN "bin/0D_9E00_puzzle_1bpp.chr"
  
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  DrawFancyTheEndGraphic  [$A000 :: 0x36010]
;;
;;  data for the "The End" graphic.  See 'DrawFancyTheEndGraphic' below for details.
data_TheEndDrawData:
  .INCBIN "bin/0D_A000_theenddrawdata.bin"


  
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  DrawFancyTheEndGraphic  [$A400 :: 0x36410]
;;
;;    Pattern tables at $0800-$0EFF are cleared.  Tiles $80-$E3 are then drawn in a 10x10 box
;;  inside the 'story box' on the NT.
;;
;;    The "The End" graphic is then progressively drawn (one pixel per frame) to the pattern tables.
;;  The graphic is actually a 1-bit image... as only the low bitplane is set... the high bitplane
;;  is always zero.
;;
;;    The graphic is drawn in 2 phases:
;;
;;  PHASE ONE:
;;
;;    It draws the outline.  It does this by keeping track of a pixel position, and every frame, moving that
;;  position in a given direction on the x and/or y axis, "setting" or drawing a pixel each time it moves.
;;  The direction it moves is determined by the above 'data_TheEndDrawData' table.
;;
;;    Each byte in that table is one pixel of movement.  This routine will follow that movement by reading bytes
;;  and moving appropriately until it reaches a '00' termination byte, at which point drawing will be complete.
;;
;;    Each of the low 4 bits of the source byte tell it to move in a direction:
;;          bit 0 ($01) = move right
;;          bit 1 ($02) = move down
;;          bit 2 ($04) = move left
;;          bit 3 ($08) = move up
;;
;;    Any combination of bits may be present, allowing it to move in 8 directions.  In the case of opposing bits
;;  (Left+Right, for example), Left/Up take priority over Right/Down.  Therefore values of $01 and $05 will
;;  both move left.
;;
;;  PHASE TWO:
;;
;;    Once the outline has been traced and drawn, it will trace it AGAIN -- this time performing a sort of
;;  'flood fill'.  Values of $02, $03, or $07 (most downward movement) will result in a straight line being
;;  drawn to the left until it "hits a wall".
;;
;;    Since flood fill occurs on downward movement, this means the "The End" graphic must be drawn more-or-less
;;  in a clockwise fashion, or else the fill will occur on the outside of the graphic, rather than the inside.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

DrawFancyTheEndGraphic:
            @ppuaddr        = $61
    LDA #$00
    STA soft2000
    
    
    ; Clear CHR at $0800 to $0EFF  (tiles $80-EF)
    ;   clearing $80 bytes per frame (1 loop iteration = 1 frame)
    STA @ppuaddr            ;
    LDA #>$0800
    STA @ppuaddr+1          ; set @ppu addr to $0800
    
  @ClearCHRLoop:
        JSR WaitForVBlank_L     ; wait for VBlank
        
        LDA @ppuaddr+1          ; set ppu addr
        STA $2006
        LDA @ppuaddr
        STA $2006
        
        LDX #$80                ; clear $80 bytes
        LDA #$00
        : STA $2007
          DEX
          BNE :-

        LDA #$00                ; reset PPU addr (unnecessary, as we reset the scroll in a bit)
        STA $2006
        STA $2006
        
        JSR TheEnd_EndVblank    ; reset scroll, play music
        
        LDA @ppuaddr            ; Add $80 to low byte
        CLC
        ADC #$80
        STA @ppuaddr
        BNE @ClearCHRLoop       ; if carry...
        
        INC @ppuaddr+1          ; ...inc high byte
        LDA @ppuaddr+1
        CMP #$0F
        BCC @ClearCHRLoop       ; keep looping until high byte reaches $10
    
    
    
    ; Fill the story box (at $20A8) with unique tiles starting at $80
    ;   (that we just cleared).  That way to animate the "The End" graphic,
    ;   we just have to draw to CHR.
    ;
    ; This time, we draw one row of tiles each frame.
    ;   10 rows of tiles, each row has 10 tiles
    
                @drawtile       = $63
                @loopctr        = $64
    
    LDA #<$20A8
    STA @ppuaddr
    LDA #>$20A8
    STA @ppuaddr+1
    
    LDA #$80
    STA @drawtile
    LDA #10
    STA @loopctr
    
  @FillNTLoop:
        JSR WaitForVBlank_L         ; vblank

        LDA @ppuaddr+1              ; ppu addr
        STA $2006
        LDA @ppuaddr
        STA $2006
        
        LDX #10
        : LDA @drawtile             ; draw 10 tiles
          STA $2007
          INC @drawtile             ; (incrementing the tile each time so they're all unique)
          DEX
          BNE :-
          
        LDA #$00                    ; unneccesary ppu addr reset
        STA $2006
        STA $2006
        
        JSR TheEnd_EndVblank        ; scroll reset + music
        
        LDA @ppuaddr                ; move ppu addr down 1 row
        CLC
        ADC #$20
        STA @ppuaddr
        LDA @ppuaddr+1
        ADC #0
        STA @ppuaddr+1
        
        DEC @loopctr                ; loop 
        BNE @FillNTLoop
    
    ; Loop to change the attributes used to make the graphic use
    ;  palette 0.
    ;
    ; Since there are only $13 bytes of attribute data, this can all
    ;  be done in 1 frame
    
    JSR WaitForVBlank_L
    
    LDA #>$23CA                 ; attributes written to $23CA
    STA $2006
    LDA #<$23CA
    STA $2006
    
    LDX #$00
    : LDA lut_TheEnd_AttrTable, X
      STA $2007
      INX
      CPX #$13                  ; $13 bytes of data
      BCC :-
      
    JSR TheEnd_EndVblank
    
    
    ; Update the palette
    ;   This can be done in 1 frame
    LDA #$30
    STA cur_pal+1               ; white
    LDA #$16
    STA cur_pal+2               ; red (not used?)
    
    JSR WaitForVBlank_L
    JSR DrawPalette_L
    JSR TheEnd_EndVblank
    
    ;
    ;  Clear all the RAM in the draw buffer
    ;
    LDX #$00
    LDA #$00
    : STA theend_drawbuf       , X
      STA theend_drawbuf + $100, X
      STA theend_drawbuf + $200, X
      STA theend_drawbuf + $300, X
      STA theend_drawbuf + $400, X
      STA theend_drawbuf + $500, X
      STA theend_drawbuf + $600, X
      INX
      BNE :-
      
    JSR WaitForVBlank_L         ; since that loop took a bit of time -- do a frame just to keep
    JSR TheEnd_EndVblank        ;   the music going without interruption.
    
    
    ;
    ;  This is the start of the actual drawing
    ;
    
    LDA #$0C                    ; start drawing from position $C,$0
    STA theend_x
    LDA #$00
    STA theend_y
    
    LDA #<data_TheEndDrawData   ; init source pointer
    STA theend_src
    LDA #>data_TheEndDrawData
    STA theend_src+1
    
    ; Loop to draw the actual "The End" graphic
    :   LDY #$00
        LDA (theend_src), Y         ; Grab a source byte
        BEQ @StartFill              ; if zero, it's the terminator.  Exit to the @StartFill code
        
        JSR TheEnd_MoveAndSet       ; otherwise, use it to move and set pixel
        
        LDA theend_src              ; inc the source pointer
        CLC
        ADC #$01
        STA theend_src
        LDA theend_src+1
        ADC #$00
        STA theend_src+1
        
        JMP :-                      ; and keep looping until we find the terminator
        
@StartFill:
    ; The "Fill" effect works by re-traversing the outline of the graphic, and on certain
    ;  movements, doing a "fill" by setting all pixels to the left of it, until it finds another
    ;  set pixel
    
    ; Reset starting position
    LDA #$0C
    STA theend_x
    LDA #$00
    STA theend_y
    
    ; And source pointer
    LDA #<data_TheEndDrawData
    STA theend_src
    LDA #>data_TheEndDrawData
    STA theend_src+1
    
    ; The outer fill loop to trace the outline
  @FillLoop_Trace:
    LDY #$00
    LDA (theend_src), Y     ; get a source byte
    BNE :+                  ; if we hit the null...
      RTS                   ; ... we're done!  Exit!  This will actually RTS out of the entire "The End" routine.
    
    ; Otherwise... check the value to see if we should fill or not (see 'DrawFancyTheEndGraphic' above for details)
  : CMP #$02
    BEQ @DoFill         ; fill on values 2, 3, 7
    CMP #$03
    BEQ @DoFill
    CMP #$07
    BEQ @DoFill
    
    ;  For other values, just must the trace position and do nothing
    JSR TheEnd_MovePos      ; move position
                            ; flow into next iteration
  @FillLoop_Next:
    LDA theend_src      ; inc source pointer
    CLC
    ADC #$01
    STA theend_src
    LDA theend_src+1
    ADC #$00
    STA theend_src+1
    
    JMP @FillLoop_Trace ; loop until we hit the null
 
 
    ; Here, we actually want to start filling
  @DoFill:
                @filly      = $65       ; Y coord for filling
                @fillx      = $64       ; X coord for filling
                @fillppu    = $3E       ; ppu addr for filling
                @fillram    = $66       ; ram addr for filling
                
    LDX theend_y        ; backup this position
    STX @filly
    LDX theend_x
    STX @fillx
    
    JSR TheEnd_MovePos  ; move actual position
    
    LDX @filly                  ; check Y coord against gradient lut to see if
    LDA @lut_FillGradient, X    ;  we should fill on this row
    BEQ @FillLoop_Next          ; If zero, don't fill.  Skip.
    
    ;
    ;  This inner Fill loop will move left 1 pixel from the 'fill' position
    ;  and set it until we reach either the left-edge of the overall image
    ;  or until we come across another pixel that is set  (sort of like
    ;  a 1-directional flood fill)
    ;
@FillInnerLoop:
    LDA @fillx                  ; Move Left 1 pixel
    SEC
    SBC #$01
    BMI @FillLoop_Next          ; Abort if we've moved off the left edge!
    STA @fillx

    ;  Set PPU/RAM buffer pointers to access the current fill position pixel
    LDX @fillx
    LDY @filly
    LDA lut_TheEndPixelPosition_X, X
    CLC
    ADC lut_TheEndPixelPosition_Ylo, Y
    STA @fillppu
    STA @fillram
    LDA lut_TheEndPixelPosition_Yhi, Y
    ADC #$00
    STA @fillppu+1
    CLC
    ADC #$60
    STA @fillram+1
    
    ; Get the mask for this pixel
    TXA
    AND #$07
    TAX
    LDA lut_TheEndPixelMasks, X
    
    LDY #$00
    AND (@fillram), Y           ; check to see if the pixel is already set
    BNE @FillLoop_Next          ; if it was, we're done filling, as we've hit the "left wall"
    
    ; Otherwise... we want to draw this pixel to fill!
    JSR WaitForVBlank_L             ; have to draw in VBlank
    
    LDA lut_TheEndPixelMasks, X     ; get pixel mask again
    ORA (@fillram), Y               ; update RAM
    STA (@fillram), Y
    
    LDX @fillppu+1                  ; set pixel in PPU
    STX $2006
    LDX @fillppu
    STX $2006
    STA $2007
    
    JSR TheEnd_EndVblank            ; end VBlank (set scroll, update music)
    JMP @FillInnerLoop              ; keep looping until fill for this row is complete
    
    RTS         ; <- never reached
    
    
    ;
    ;  Not all rows are filled.  The game uses this LUT to selectively disable filling
    ;  for certain rows, producing a gradient effect.  There are $50 bytes in this lut,
    ;  one for each row.  If that byte is 1, filling is allowed.  If 0, no filling allowed.
    ;
  @lut_FillGradient:
  .BYTE 0, 0, 1, 0,  1, 0, 1, 0,     1, 0, 0, 1,  0, 0, 1, 0
  .BYTE 0, 1, 0, 1,  0, 1, 1, 1,     1, 1, 1, 1,  1, 1, 1, 1
  .BYTE 1, 1, 1, 1,  1, 1, 1, 1,     1, 1, 1, 1,  1, 1, 1, 1
  .BYTE 1, 1, 1, 1,  1, 1, 1, 1,     1, 1, 1, 1,  1, 1, 1, 1
  .BYTE 1, 1, 0, 1,  0, 1, 0, 1,     0, 1, 0, 1,  0, 1, 0, 1


  
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  TheEnd_MoveAndSet  [$A5E4 :: 0x365F4]
;;
;;  input:   A = source byte, indicating how to move
;;
;;  Moves the position, then sets the pixel.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

TheEnd_MoveAndSet:
    JSR TheEnd_MovePos          ; self explanitory
    JSR WaitForVBlank_L
    
    LDX theend_x
    LDY theend_y
    JSR TheEnd_SetPixel
    JMP TheEnd_EndVblank
    
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  TheEnd_EndVblank  [$A5F4 :: 0x36604]
;;
;;    Resets the scroll, resumes music
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

TheEnd_EndVblank:
    LDA soft2000
    STA $2000
    LDA #$00
    STA $2005
    STA $2005
    JMP MusicPlay_L

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  TheEnd_MovePos  [$A604 :: 0x36614]
;;
;;  input:  A = source byte to indicate how to move.  See 'DrawFancyTheEndGraphic' for details
;;
;;  in/out:  theend_x and theend_y
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

TheEnd_MovePos:
    STA tmp             ; back up the value
    
    AND #$05            ; see if Left/Right bits are set
    BEQ @CheckVert      ; if neither set, jump ahead to check up/down
    
      AND #$04              ; Check to see if the 'Right' bit is set
      BNE @Left             ; if yes, go to @Right, otherwise go @Left
      
    @Right:
        LDA theend_x        ; increment X position  (why doesn't he use INC?)
        CLC
        ADC #$01
        STA theend_x
        JMP @CheckVert
    
    @Left:
        LDA theend_x        ; move left (why doesn't he DEC?)
        SEC
        SBC #$01
        STA theend_x
    
    ; All values meet up here:
  @CheckVert:
    LDA tmp             ; restore backed up value
    
    AND #$0A            ; see if either Up/Down bits are set
    BEQ @Done           ; if not, exit
    
      AND #$08              ; otherwise, check to see if 'Up' bit is set
      BNE @Up
    
    @Down:
        LDA theend_y
        CLC
        ADC #$01
        STA theend_y
        RTS
    @Up:
        LDA theend_y
        SEC
        SBC #$01
        STA theend_y
    
  @Done:
    RTS

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  lut_TheEnd_AttrTable  [$A639 :: 0x36649]
;;
;;    These bytes are copied to the attribute table at $23CA
;;  The "The End" graphic is only 10x10 tiles, so only the 3x3
;;  block of attributes in the middle is interesting.  The rest
;;  is just there to make writing easier (it's a duplicate of what is
;;  already on the attribute table

lut_TheEnd_AttrTable:
  .BYTE             $0F, $0F, $CF,   $77, $55, $55
  .BYTE $55, $FF,   $00, $00, $CC,   $77, $55, $55
  .BYTE $55, $FF,   $F0, $F0, $FC
  ;                 ^ Interesting ^
  
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  TheEnd_SetPixel  [$A64C :: 0x3665C]
;;
;;  input:  X, Y = the X and Y pixel coord to set
;;
;;  Must be called during VBlank!
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

TheEnd_SetPixel:
                @bufaddr  = $66     ; local - points to pos in RAM
                @ppuaddr  = $3E     ; local - points to pos in PPU

    ; prep local pointers based on given X,Y position
    LDA lut_TheEndPixelPosition_X, X
    CLC
    ADC lut_TheEndPixelPosition_Ylo, Y
    STA @ppuaddr
    STA @bufaddr
    LDA lut_TheEndPixelPosition_Yhi, Y
    ADC #$00
    STA @ppuaddr+1
    CLC
    ADC #$60
    STA @bufaddr+1
    
    ; Then get the mask to the appropriate pixel
    TXA
    AND #$07
    TAX
    LDA lut_TheEndPixelMasks, X
    
    ; Draw this pixel to our RAM buffer
    LDY #$00
    ORA (@bufaddr), Y
    STA (@bufaddr), Y
    
    ; Draw it to the actual PPU
    LDX $2002
    
    LDX @ppuaddr+1
    STX $2006
    LDX @ppuaddr
    STX $2006
    STA $2007
    
    RTS
    
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Luts for 'The End' pixel coords conversion [$A681 :: 0x36691]
;;
;;    These luts let you get a ppu address from a X,Y position in pixels.
;;  0,0 is at PPU addr $0800 (beginning of drawable area for 'The End' graphic
;;
;;    The final 'lut_TheEndPixelMasks' table is 8 bytes, and gets the bitmask
;;  to the appropriate pixel

lut_TheEndPixelPosition_Ylo:                                    ; $A681
lut_TheEndPixelPosition_Yhi = lut_TheEndPixelPosition_Ylo + $50 ; $A6D1
lut_TheEndPixelPosition_X   = lut_TheEndPixelPosition_Yhi + $50 ; $A721
lut_TheEndPixelMasks        = lut_TheEndPixelPosition_X   + $50 ; $A771

  .INCBIN "bin/0D_A681_theendluts.bin"

  
; $A779 -- unused
;  .BYTE $1F, $3F, $7F, $7F, $7C, $78, $78
;; JIGS - ^ 


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  MiniGame - Slide Vertically  [$A780 :: 0x36790]
;;
;;     Slides the puzzle pieces vertically in the puzzle -- updating the puzzle and
;;  animating the onscreen sprites so they appear to gradually slide into their new position.
;;  Only works for vertical movement -- for horizontal movement, MiniGame_HorzSlide is called
;;  instead.
;;
;;  IN:  tmp   = position of cursor
;;       tmp+1 = position of empty slot
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

MiniGame_VertSlide:
    LDA tmp           ; compare cursor to empty slot's position
    CMP tmp+1         ;  if cursor < empty slot
    BCC @Down         ;  ... then we will be sliding downward
                      ;  otherwise we're slide upward

  @Up:
    SBC tmp+1         ; subtract the empty slot's position from cursor position
    LSR A             ;  and right shift by 2 (gets the row difference)
    LSR A
    STA tmp+2         ; tmp+2 is now the number of rows we need to move upward (1-3)

    ; slide the puzzle pieces into their new slots

    LDX tmp+1         ; put the empty slot in X
  @Up_SlideLoop:
      LDA puzzle+4, X   ; get the piece from 1 row below, and move it into the empty slot
      STA puzzle, X     ; puzzle+4+X is now the new empty slot
      INX               ; increment X by 4 (1 row)
      INX
      INX
      INX
      CPX tmp           ; and repeat until we get to the cursor's slot
      BCC @Up_SlideLoop
    LDA #0
    STA puzzle, X       ; then replace the cursor's slot with 0 (make it the empty slot)

    LDA #3
    STA mg_slidedir     ; set the slide direction to 3 (sliding upwards)

    LDA tmp                  ; A = cursor
    LDX tmp+2                ; X = number of tiles that require sliding
  @Up_SpriteLoop:
      STA mg_slidespr-1, X   ; fill the slide sprite buffer with the slots which we need
      SEC                    ;  to slide.  -1 here because X is actually +1 than it should be for indexing
      SBC #4                 ; subtract 4 to record the next row upward
      DEX                    ; and loop until all rows have been recorded
      BNE @Up_SpriteLoop

    JMP MiniGame_AnimateSlide   ; then do the animation, and exit


  @Down:                ; sliding down is the same as sliding up
    LDA tmp+1           ; get empty slot position
    SEC
    SBC tmp             ; subtract cursor position
    LSR A               ; and divide by 4
    LSR A               ;  this results in the number of rows we need to move downward (1-3)
    STA tmp+2           ; store this in tmp+2

    LDX tmp+1           ; put empty slot in X
  @Down_SlideLoop:
      LDA puzzle-4, X     ; get the puzzle piece from 1 row above this row
      STA puzzle, X       ;  and copy it to this row
      DEX                 ; then decrement X by 4 (move 1 row up)
      DEX                 ;   this moves all the tiles in this column down 1 row
      DEX
      DEX
      CPX tmp             ; repeat until we get to the cursor's slot
      BNE @Down_SlideLoop
    LDA #0
    STA puzzle, X         ; then replace the cursor's slot with 0 (make it the empty slot)

    LDA #2
    STA mg_slidedir       ; set slide direction to 2 (downwards)

    LDA tmp               ; A = cursor
    LDX tmp+2             ; X = number of tiles that require sliding
  @Down_SpriteLoop:
      STA mg_slidespr-1, X   ; fill slide sprite buffer with slots that need to be moved
      CLC                    ;   so that MiniGame_AnimateSlide will move them
      ADC #4                 ; add 4 to move to the next row down
      DEX
      BNE @Down_SpriteLoop   ; and loop until all rows have been recorded

    JMP MiniGame_AnimateSlide   ; then animate them and exit

; Unused space (almost looks like it might be attributes)

;  .BYTE $00, $00, $00, $1E
;  .BYTE $1E, $3E, $FE, $FE
;  .BYTE $FC, $F8, $00, $00
;  .BYTE $00, $00, $00, $00
;  .BYTE $00, $00, $00, $00
;  .BYTE $00, $00, $00, $00
;  .BYTE $00, $00, $00

;; JIGS ^   
  
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Story Text   [$A800 :: 0x36810]
;;
;;    Pointer table followed by text data for the story text.  Story
;;  text is used for Bridge and Ending scenes and is displayed one 'page'
;;  at a time.  Each string in this text cooresponds to one page.

lut_StoryText:
;  .INCBIN "bin/0D_A800_storytext.bin"

.WORD SLIDE1 
.WORD SLIDE2
.WORD SLIDE3
.WORD SLIDE4
.WORD ENDSLIDE1
.WORD ENDSLIDE2
.WORD ENDSLIDE3
.WORD ENDSLIDE4
.WORD ENDSLIDE5
.WORD ENDSLIDE6
.WORD ENDSLIDE7
.WORD ENDSLIDE8
.WORD ENDSLIDE9
.WORD ENDSLIDE10
.WORD ENDSLIDE11
.WORD ENDSLIDE12
.WORD ENDSLIDE13
.WORD ENDSLIDE14
.WORD ENDSLIDE15
.WORD ENDSLIDE16
.WORD ENDSLIDE17
.WORD ENDSLIDE18
.WORD ENDSLIDE19
.WORD ENDSLIDE20
.WORD ENDSLIDE21

SLIDE1:
.byte $01,$8A,$3B,$24,$B2,$BF,$1B,$1D,$AC,$B5,$05,$AD,$B2,$55
.byte $5A,$BC,$31,$A8,$AA,$1F,$B6,$69,$00
SLIDE2:
.BYTE $A0,$AB,$39,$20,$5D,$5B,$B6
.byte $1B,$1D,$05,$8F,$B2,$55,$BF,$1B,$1D,$4B,$A7,$B2,$05,$B1,$B2,$21
.byte $AE,$B1,$46,$C0,$00
SLIDE3:
.BYTE $8E,$A4,$A6,$AB,$59,$B2,$AF,$A7,$1F,$AA,$20
.byte $B1,$05,$98,$9B,$8B,$BF,$1B,$41,$21,$82,$80,$80,$80,$05,$BC,$A8
.byte $2F,$1E,$A4,$AA,$B2,$24,$AB,$1F,$40,$05,$BA,$AC,$1C,$31,$2B,$B8
.byte $B7,$BC,$43,$B5,$49,$05,$BA,$AC,$1C,$1F,$C0,$FF,$8B,$B8,$21,$B1
.byte $46,$BF,$05,$B2,$B1,$AF,$4B,$A7,$2F,$AE,$B1,$2C,$B6,$C0,$00
SLIDE4:
.BYTE $8C
.byte $B2,$34,$C4,$C4,$05,$9C,$B7,$2F,$21,$BC,$26,$B5,$05,$AD,$B2,$55
.byte $5A,$BC,$C4,$05,$9B,$A8,$B7,$55,$B1,$1B,$AB,$1A,$68,$AA,$AB,$B7
.byte $05,$B2,$A9,$4F,$2B,$A6,$1A,$28,$FF,$26,$B5,$05,$BA,$B2,$B5,$AF
.byte $A7,$C0,$00

ENDSLIDE1:
.BYTE $9D,$AB,$1A,$9D,$AC,$34,$C2,$95,$B2,$B2,$B3,$05,$AC
.byte $B6,$FF,$B1,$46,$31,$4D,$AE,$3A,$C4,$05,$9D,$AB,$1A,$82,$80,$80
.byte $80,$50,$2B,$B5,$05,$AF,$B2,$2A,$31,$39,$B7,$AF,$1A,$30,$05,$B2
.byte $B9,$25,$C0,$FF,$99,$2B,$48,$05,$B3,$B5,$A8,$B9,$A4,$61,$B6,$C0
.byte $00

ENDSLIDE2:
.BYTE $8C,$B2,$B1,$B7,$4D,$AF,$36,$A9,$1B,$1D,$05,$A9,$B2,$B8,$44
.byte $A8,$45,$34,$B1,$B7,$B6,$BF,$05,$B7,$AB,$1A,$8E,$2F,$B7,$AB,$BF
.byte $1B,$1D,$05,$A0,$AC,$3B,$BF,$1B,$AB,$1A,$8F,$AC,$23,$BF,$05,$A4
.byte $B1,$A7,$1B,$AB,$1A,$A0,$39,$25,$BF,$05,$A4,$AA,$A4,$1F,$31,$A8
.byte $AF,$B2,$2A,$B6,$05,$B7,$B2,$1B,$AB,$1A,$2B,$B5,$1C,$C0,$00

ENDSLIDE3:
.BYTE $90
.byte $A4,$B5,$AF,$22,$A7,$BE,$1E,$AB,$39,$23,$A7,$05,$A5,$B8,$B5,$5A
.byte $27,$A9,$35,$FF,$82,$80,$80,$80,$05,$BC,$A8,$2F,$B6,$C0,$FF,$9D
.byte $AB,$39,$05,$AB,$A4,$B7,$23,$27,$AF,$40,$1B,$1D,$05,$8F,$B2,$B8
.byte $44,$99,$46,$25,$B6,$1B,$B2,$05,$B7,$AB,$AC,$1E,$BA,$35,$AF,$A7
.byte $C0,$00

ENDSLIDE4:
.BYTE $8C,$91,$8A,$98,$9C,$33,$3F,$05,$A6,$B5,$2B,$53,$27,$A9
.byte $B5,$49,$05,$B7,$AB,$B2,$B6,$1A,$8F,$26,$B5,$C0,$00

ENDSLIDE5:
.BYTE $8E,$B9,$AC
.byte $58,$A7,$49,$1F,$39,$40,$05,$B7,$AB,$1A,$BA,$35,$AF,$A7,$20,$3B
.byte $05,$A6,$B2,$32,$23,$27,$AC,$21,$1F,$05,$A7,$A4,$B5,$AE,$B1,$2C
.byte $B6,$C0,$00

ENDSLIDE6:
.byte $8B,$B8,$B7,$BF,$2D,$21,$AC,$1E,$B2,$B9,$25,$05,$B1
.byte $B2,$BA,$BF,$33,$4D,$2A,$59,$3F,$05,$A5,$A8,$3A,$24,$A8,$21,$5C
.byte $AA,$AB,$B7,$C4,$C4,$00

ENDSLIDE7:
.byte $9D,$AB,$1A,$95,$92,$90,$91,$9D,$05,$A0
.byte $8A,$9B,$9B,$92,$98,$9B,$9C,$20,$23,$05,$B5,$A8,$B7,$55,$B1,$1F
.byte $AA,$69,$05,$8A,$B6,$1B,$1D,$BC,$1B,$B5,$A4,$32,$AF,$05,$AC,$B1
.byte $1B,$AC,$34,$BF,$1B,$1D,$05,$BA,$B2,$B5,$AF,$27,$23,$B7,$55,$B1
.byte $B6,$05,$B7,$B2,$FF,$B1,$35,$B0,$5F,$C0,$00

ENDSLIDE8:
.byte $9C,$A4,$B5,$A4,$20
.byte $B1,$27,$93,$22,$A8,$05,$BA,$A4,$AC,$21,$A9,$35,$1B,$1D,$B0,$69
.byte $05,$98,$A9,$38,$26,$B5,$3E,$BF,$05,$90,$A4,$B5,$AF,$22,$27,$A7
.byte $B2,$2C,$05,$B7,$B2,$B2,$C0,$00

ENDSLIDE9:
.byte $01,$05,$8B,$B8,$B7,$BF,$33,$1D
.byte $29,$A7,$AC,$27,$5B,$05,$A8,$B9,$25,$FF,$41,$B3,$B3,$3A,$C5,$69
.byte $00

ENDSLIDE10:
.byte $8E,$B9,$25,$BC,$1C,$1F,$AA,$33,$3A,$B7,$05,$B0,$A4,$27,$1F
.byte $20,$67,$A4,$BC,$C0,$05,$9D,$AB,$1A,$23,$3F,$B2,$29,$68,$2C,$05
.byte $AC,$B1,$1B,$AB,$1A,$82,$80,$80,$80,$50,$2B,$B5,$05,$9D,$AC,$34
.byte $C2,$95,$B2,$B2,$B3,$C0,$00

ENDSLIDE11:
.byte $9D,$AB,$1A,$8F,$26,$B5,$38,$AB,$B2
.byte $3E,$05,$B7,$B2,$31,$A8,$A6,$49,$1A,$3C,$A8,$05,$A9,$B2,$B5,$48
.byte $BF,$20,$B1,$27,$A9,$AC,$AA,$AB,$B7,$05,$A4,$AA,$A4,$1F,$37,$1B
.byte $AB,$1A,$A9,$26,$B5,$05,$A8,$B9,$61,$43,$35,$A6,$2C,$1B,$AB,$39
.byte $05,$B6,$A8,$21,$A7,$2F,$AE,$B1,$2C,$B6,$05,$B8,$B3,$3C,$1B,$AB
.byte $1A,$BA,$35,$AF,$A7,$C0,$00

ENDSLIDE12:
.byte $A0,$AB,$3A,$1B,$AB,$1A,$8F,$26,$B5
.byte $05,$B5,$A8,$B7,$55,$B1,$BF,$2D,$21,$BA,$AC,$4E,$05,$A5,$A8,$1B
.byte $2E,$1C,$A8,$AC,$B5,$05,$B3,$A4,$37,$C0,$FF,$8A,$4E,$05,$B6,$AC
.byte $AA,$B1,$1E,$4C,$1B,$1D,$05,$A5,$A4,$B7,$B7,$AF,$1A,$BA,$AC,$1C
.byte $1B,$1D,$05,$8F,$B2,$B5,$48,$1E,$BA,$AC,$4E,$31,$A8,$05,$A8,$B5
.byte $A4,$3E,$A7,$C0,$00

ENDSLIDE13:
.byte $8B,$B8,$B7,$1B,$AB,$1A,$45,$AA,$3A,$A7,$05
.byte $BA,$AC,$4E,$65,$AC,$B9,$1A,$3C,$C0,$05,$99,$A4,$B6,$3E,$27,$A7
.byte $46,$29,$A5,$BC,$05,$B7,$AB,$1A,$8D,$BA,$2F,$B9,$2C,$BF,$1B,$1D
.byte $05,$8E,$AF,$B9,$2C,$BF,$20,$3B,$1B,$1D,$05,$8D,$B5,$A4,$AA,$3C
.byte $B6,$69,$00

ENDSLIDE14:
.byte $99,$A4,$B6,$3E,$27,$B2,$29,$A5,$BC,$05,$B3,$A8,$B2
.byte $B3,$45,$1E,$B8,$B1,$B6,$B8,$23,$05,$BA,$AB,$25,$1A,$1C,$1A,$B6
.byte $28,$B5,$BC,$05,$A6,$A4,$B0,$1A,$A9,$B5,$49,$C0,$00

ENDSLIDE15:
.byte $01,$9D,$1D
.byte $05,$95,$92,$90,$91,$9D,$FF,$A0,$8A,$9B,$9B,$92,$98,$9B,$9C,$05
.byte $B5,$A8,$B7,$55,$29,$A9,$B5,$49,$05,$B7,$AB,$A8,$AC,$44,$AD,$26
.byte $B5,$5A,$BC,$05,$A5,$A4,$A6,$AE,$FF,$1F,$1B,$AC,$34,$05,$82,$80
.byte $80,$80,$50,$2B,$63,$C0,$00

ENDSLIDE16:
.byte $9D,$AB,$1A,$34,$B0,$35,$AC,$2C,$05
.byte $B6,$B7,$B2,$23,$27,$A7,$A8,$A8,$B3,$FF,$1F,$05,$B7,$AB,$A8,$AC
.byte $44,$AB,$2B,$B5,$B7,$B6,$05,$BA,$AC,$4E,$4F,$4D,$53,$A6,$B7,$1B
.byte $1D,$05,$BA,$B2,$B5,$AF,$A7,$C0,$00

ENDSLIDE17:
.byte $01,$97,$A8,$B9,$25,$43,$35
.byte $66,$B7,$05,$B7,$AB,$1A,$AA,$B2,$B2,$A7,$20,$3B,$05,$B7,$B5,$B8
.byte $A8,$69,$00

ENDSLIDE18:
.byte $01,$97,$A8,$B9,$25,$1B,$55,$B1,$1B,$1D,$05,$8F,$B2
.byte $B8,$44,$99,$46,$25,$B6,$1B,$B2,$05,$B7,$AB,$1A,$A7,$2F,$AE,$24
.byte $AC,$A7,$A8,$69,$00

ENDSLIDE19:
.byte $01,$8A,$3B,$1B,$B5,$B8,$1C,$33,$AC,$4E,$05
.byte $A4,$AF,$5D,$BC,$1E,$68,$B9,$1A,$1F,$05,$B7,$AB,$1A,$1D,$2F,$B7
.byte $1E,$4C,$05,$B7,$AB,$1A,$B3,$A8,$B2,$B3,$45,$C0,$00

ENDSLIDE20:
.byte $01,$9D,$AB
.byte $1A,$A0,$2F,$5C,$35,$33,$AB,$B2,$05,$A5,$B5,$B2,$AE,$1A,$1C,$1A
.byte $82,$80,$80,$80,$05,$BC,$A8,$2F,$FF,$9D,$AC,$34,$C2,$95,$B2,$B2
.byte $B3,$05,$AC,$B6,$1B,$B5,$B8,$AF,$BC,$20,$05,$95,$92,$90,$91,$9D
.byte $FF,$A0,$8A,$9B,$9B,$92,$98,$9B,$69,$05,$9D,$AB,$A4,$21,$BA,$2F
.byte $5C,$35,$33,$3F,$05,$A2,$98,$9E,$C4,$00

ENDSLIDE21:
.byte $01,$96,$A4,$BC,$1B,$AB
.byte $1A,$98,$9B,$8B,$9C,$05,$A4,$AF,$5D,$BC,$1E,$B6,$AB,$1F,$A8,$C4
.byte $C4,$69,$00

;; Junk left over.
;.byte $1B,$55,$B1,$1B,$1D,$05,$84,$FF,$B3,$46,$25,$B6,$1B
;.byte $2E,$1C,$A8,$05,$A7,$A4,$B5,$AE,$24,$AC,$A7,$A8,$C0,$00
;.byte $8A,$B1
;.byte $A7,$1B,$AB,$1A,$B7,$B5,$B8,$A8,$05,$A6,$B5,$BC,$37,$5F,$1E,$A4
;.byte $AF,$5D,$BC,$B6,$05,$AF,$AC,$B9,$1A,$BA,$AC,$1C,$1F,$05,$B3,$A8
;.byte $B2,$B3,$45,$BE,$1E,$1D,$2F,$B7,$B6,$C0,$00
;.byte $9D,$AB,$1A,$A0,$2F
;.byte $5C,$35,$1B,$AB,$39,$05,$A9,$B2,$B8,$AA,$AB,$21,$B3,$A4,$37,$05
;.byte $82,$80,$80,$80,$BC,$2B,$B5,$1E,$4C,$05,$B7,$AC,$B0,$1A,$5D,$1E
;.byte $BC,$26,$C4,$00
;.byte $01,$96,$A4,$BC,$20,$4E,$1B,$AB,$1F,$AA,$B6,$05
;.byte $FF,$A6,$26,$B1,$B7,$1F,$B8,$1A,$28,$05,$FF,$FF,$24,$AB,$1F,$A8
;.byte $69,$00
;.byte $69,$00,$C3,$00,$BC,$5A,$C0,$00,$01,$96,$A4,$BC,$FF,$A4
;.byte $AF,$51,$B7,$43,$B1,$3F,$05,$BF,$0A,$A6,$B2,$B8,$B1,$B7,$47,$B8
;.byte $37,$B7,$5C,$B6,$43,$57,$69,$00,$00,$00,$00,$00,$00,$00,$00,$00
;.byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
;.byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
;.byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Story "last page" numbers  [$AE00 :: 0x36E10]
;;
;;    These are the "last page" numbers for bridge and ending scene text.

lut_Bridge_LastPage:  .BYTE  $04  ; bridge scene uses story pages $00-$03
lut_Ending_LastPage:  .BYTE  $19  ; ending scene uses story pages $04-$18



 ;; ?unused -- fragmented code?
 ;;   looks like some detached music driver code.  Starts with
 ;;  LDA music_track
 ;;  BPL xxx
 ;;   but the branch goes to some garbage address.  Probably left over garbage
 ;;   from earlier assemblies.

;  .BYTE $A5, $4B, $10, $12
;  .BYTE $C9, $80, $D0, $0D
;  .BYTE $A9, $70, $8D, $00
;  .BYTE $40, $8D

;; JIGS ^ 

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Enter MiniGame  [$AE10 :: 0x36E20]
;;
;;  OUT:   C = set if minigame was completed successfully (puzzle solved)
;;             clear if not
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

EnterMiniGame:
    LDA #0
    STA menustall         ; disable stalling
    STA $2001             ; turn off PPU
    STA $4015             ; and APU

    LDA #$08              ; clear NT scroll
    STA soft2000

    LDA #BANK_THIS        ; set cur bank for music playback
    STA cur_bank

    LDA #$05              ; draw a smaller box ($08,$05   $0A,$0A)
    STA box_y             ;  inside the main box which is normally used for text
    LDA #$08              ;  this smaller box will hold the puzzle
    STA box_x
    LDA #$0A
    STA box_wd
    STA box_ht
    JSR DrawBox_L

    ;; here we start loading CHR for the minigame.  There are 16 sliding puzzle pieces in CHR
    ;;  one is blank (no number), and the others are numbered 1-15.  Each sliding puzzle piece
    ;;  is 2x2 tiles, and is stored 1bpp (not the normal 2bpp).  This means there are 16*2*2*8
    ;;  ($200) bytes of CHR for the puzzle pieces.  Because it's 1bpp, we can't use the normal
    ;;  CHR loader.  This routine has to load it manually.
    ;;
    ;; To expand these graphics to 2bpp, the first sliding puzzle graphic (the one that isn't
    ;;  numbered) is used as the HIGH bitplane for every graphic.  And the numbered graphics
    ;;  are used as the low bitplane for every graphic.
    ;;
    ;; (tmp) will be the pointer for the low bitplane.  It will progressively draw all the
    ;;    tiles
    ;; (tmp+2) will be the pointer for the high bitplane.  It will only draw the first four tiles
    ;;    (the 2x2 tiles that make up the unnumbered graphic).

    LDA #>lut_MinigameCHR
    STA tmp+1               ; load up high byte of source pointers
    STA tmp+3

    LDA $2002            ; reset PPU toggle

    LDA #$10             ; set PPU addr to $1000 (start of sprite pattern tables)
    STA $2006
    LDA #$00
    STA $2006

    STA tmp              ; set the low byte of the low bitplane pointer

  @CHRLoadLoop:
     LDY #0              ; Y will be our inner loop counter and index.  Zero it
     @LoBitplaneLoop:
       LDA (tmp), Y
       STA $2007              ; draw low bitplane data
       INY
       CPY #8                 ; loop until 8 bytes drawn (entire low bitplane)
       BCC @LoBitplaneLoop

     LDA tmp                ; get low byte of lo bitplane pointer
     AND #$1F               ; mask low bits
     STA tmp+2              ; and write as low byte of high bitplane pointer
                            ;  This keeps the high bitplane looking at the first 2x2 graphic, but
                            ;   moves it between the UL, UR, DL, and DR tiles

     LDY #0                   ; do allt he same stuff, but draw the high bitplane
     @HiBitplaneLoop:
       LDA (tmp+2), Y
       STA $2007
       INY
       CPY #8
       BCC @HiBitplaneLoop    ; loop until 8 bytes drawn

     LDA tmp                ; add 8 to low byte of lo bitplane pointer
     CLC
     ADC #8
     STA tmp
     BNE @CHRLoadLoop       ; if it didn't wrap... keep looping

     INC tmp+1              ; otherwise if it did wrap... inc the high byte of the pointer

     LDA tmp+1                        ; then check the pointer to see if we've drawn all the tiles yet
     CMP #>(lut_MinigameCHR + $200)   ;  we need to draw $400 bytes ($200 bytes of low-bitplane data)
     BCC @CHRLoadLoop                 ; Loop until we've drawn that much

   ;
   ;  now we load up the starting positions for all the puzzle pieces
   ;

    LDX #$0F
  @LoadPuzzleLoop:
      LDA lut_PuzzleStart, X   ; simply copy the positions from this LUT
      STA puzzle, X            ;  into our puzzle
      DEX
      BPL @LoadPuzzleLoop      ; and loop until all $10 bytes copied

    JSR MiniGame_ShufflePuzzle ; shuffle the puzzle pieces around to randomize it



    LDA #$42
    STA music_track            ; start music track number $42 (bridge scene music)

   ;
   ; load the desired palette
   ;

    LDX #$0F
  @LoadPalLoop:
    LDA lut_BridgeBGPal, X ; copy $10 colors (full BG palette)
    STA cur_pal, X         ;  from the Bridge scene palette LUT
    DEX                    ; seems wasteful to do this here -- there's a routine
    BPL @LoadPalLoop       ;   you can JSR to that does this (Bridge_LoadPalette)

    LDA #$30               ; and a few sprite palettes as well
    STA cur_pal+$13        ; the white for the backs of the puzzle pieces
    LDA #$15               ;  and the red for the numbers on the puzzle pieces
    STA cur_pal+$12

   ; 
   ; puzzle is now generated.  Here we do some final prepwork and turn the PPU
   ;   on... and begin the main loop
   ;

    JSR ClearOAM_BankD       ; clear OAM
    JSR WaitForVBlank_L      ; then once in VBlank...
    LDA #>oam
    STA $4014                ; do sprite DMA
    JSR DrawPalette_L        ; and load up the palette

    LDA soft2000             ; the load up soft2000 (resets NT scroll)
    STA $2000
    LDA #$1E
    STA $2001                ; turn on the PPU
    LDA #0                   ; and set the scroll to zero
    STA $2005
    STA $2005

    STA joy_a                ; lastly, zero out joypad data so we start with a clean slate
    STA joy_b
    STA joy_prevdir
    STA joy
    STA cursor               ; and start the cursor (selected slot) at zero.

    LDA puzzle               ; but check slot zero to make sure it's not the empty slot
    BNE MiniGameLoop
      INC cursor             ; if it is... start the cursor on slot 1 instead
                      ; no JMP or RTS -- code flows into MiniGameLoop

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Mini Game Loop  [$AECF :: 0x36EDF]
;;
;;     The main loop driving the mini game!  Probably doesn't need to be
;;  seperated from EnterMiniGame -- but oh well.
;;
;;  OUT:  C = set if puzzle solved
;;            clear if puzzle not solved
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

MiniGameLoop:
    INC framecounter              ; increment the frame counter to keep animations working
    JSR WaitForVBlank_L           ; wait for vblank
    LDA #>oam
    STA $4014                     ; do sprite DMA
    JSR MusicPlay_L               ; keep music playing
    JSR DrawAllPuzzlePieces       ; draw all the puzzle pieces
    JSR MiniGame_ProcessInput     ; and refresh and process input!

    LDA joy_b
    BNE @B_Pressed                ; check to see if A or B have been pressed
    LDA joy_a
    BNE @A_Pressed

    JSR MiniGame_CheckVictory     ; then check to see if the puzzle has been solved
    BCC MiniGameLoop              ; if not... keep looping until it is
    RTS                           ; if it's solved, exit (C set here to indicate success)

  @B_Pressed:
    CLC                ; if B pressed, CLC to indicate the puzzle went unsolved
    RTS                ; and exit

  @A_Pressed:
    LDA #0             ; Zero X (for upcoming loop)
    TAX

    STA joy_a          ; clear A button catcher
    STA framecounter   ; clear framecounter.  This will ensure that the puzzle piece selected by the cursor
                       ;   will be visible for the next sprite drawing.

    LDA #$80
    STA mg_slidespr    ; erase the slide sprite buffer by filling it with a negative value
    STA mg_slidespr+1
    STA mg_slidespr+2

    LDA cursor         ; copy the current cursor to tmp
    STA tmp            ;  seems pointless.... why not just use cursor directly?

  @FindEmptyLoop:       ; search the puzzle for the empty slot
    LDA puzzle, X
    BEQ @ExitEmptyLoop  ; once we find it, exit the loop with slot index in X
    INX
    BNE @FindEmptyLoop  ; otherwise keep looping until it's found (always branches)

  @ExitEmptyLoop:
    TXA
    STA tmp+1          ; write empty slot index to tmp+1 (why not STX?).  Now...
                       ;  tmp   = cursor
                       ;  tmp+1 = empty slot

    LDA tmp            ; get the cursor
    AND #$03           ; mask to get the column it's in
    STA tmp+2          ; store the column temporarily
    LDA tmp+1          ; then get the empty slot's column
    AND #$03
    CMP tmp+2          ; and compare to cursor's column
    BEQ @Vertical      ; if they match, we need to slide the puzzle vertically

    LDA tmp            ; otherwise do the same thing over again
    AND #$0C           ;  except get the row instead of the column, this time
    STA tmp+2
    LDA tmp+1          ; compare it to empty slot's row
    AND #$0C
    CMP tmp+2
    BEQ @Horizontal    ; if they match, slide horizontally

                       ; otherwise... movement where the cursor currently is
                       ; is illegal.  Play an ugly error sound effect
    LDA #%00111100     ; 12.5% duty (harsh), volume=C
    STA $4004
    LDA #%10001100     ; sweep upwards in pitch (period=0, shift=4)
    STA $4005
    LDA #$70
    STA $4006          ; F value = $070
    LDA #$00
    STA $4007

    LDA #$14
    STA sq2_sfx        ; mark sq2 as being sound effect for $14 frames

    JMP MiniGameLoop   ; then jump back to minigame loop

  @Vertical:                   ; if moving vertically...
    JSR DrawAllPuzzlePieces    ;   redraw all the puzzle pieces so that they're all visible
    JMP MiniGame_VertSlide     ;   (cursor's piece might be hidden, here -- this ensures it's visible).
                               ; Then perform a vertical slide

  @Horizontal:                 ; same thing if moving horizontally, but do the horizontal
    JSR DrawAllPuzzlePieces    ;  slide instead.
    JMP MiniGame_HorzSlide

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Mini Game -- Directional LUTs  [$AF53 :: 0x36F63]
;;
;;    Each of these luts is the X and Y offset to slide each sprite
;;  every frame given the desired direction.  Directions are range 0-3 where
;;  0=right, 1=left, 2=down, 3=up

lut_MGDirection_Y:   .BYTE  0, 0, 1,-1
lut_MGDirection_X:   .BYTE  1,-1, 0, 0


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Mini Game -- Check for Victory  [$AF5B :: 0x36F6B]
;;
;;    Checks to see if the minigame puzzle has been solved.
;;  If it has, it animates the palette of the puzzle pieces and waits
;;  for the user to press a button before exiting.
;;
;;  OUT:  C = set if puzzle has been solved
;;            clear if not solved yet
;;
;;    The puzzle actually has two solutions.. one where the empty slot is at the start of the
;;  puzzle (before the 1) and one where it's at the end of the puzzle (after the 15).  To check
;;  for either of these solutions, the game does not look for a specific value in each slot -- rather
;;  it looks at values relative to their previous slot.  It starts looking at slot index 1 (rather
;;  than slot index 0) and ensures that slot1 = 1+slot0.  Then it make sure slot2 = 1+slot1, and so on.
;;  It does NOT check the last slot, since if the last slot is the empty slot (0) it would fail -- but
;;  if every slot up to the last slot is correct... then the last slot must also be correct as well,
;;  so there's no reason to check it.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

MiniGame_CheckVictory:
    LDX #1              ; X is our loop counter / index
    LDA puzzle          ; A is the required value for success
  @CheckLoop:
      CLC
      ADC #1            ; increment success value by 1
      CMP puzzle, X     ;  see if this puzzle piece is +1 the piece before it
      BNE @Fail         ; if not, puzzle isn't solved
      INX               ; otherwise move onto next piece
      CPX #$0F          ; until all but last piece checked
      BCC @CheckLoop

  ; Code reaches here is puzzle has been solved.  Don't exit right away -- instead start cycling the
  ;  palette, and wait for the user to press a button

    LDA #$54
    STA music_track       ; play music track $54  (special item fanfare)

    LDA #$12
    STA cursor            ; set the cursor so some value off the puzzle so it doesn't mess with the drawing

    JSR DrawAllPuzzlePieces   ; then redraw all puzzle pieces

    LDA #0
    STA joy_a             ; clear A and B button catchers
    STA joy_b

  ; now loop -- cycling the palette and waiting for the user to press a button
  ; you may notice that while the cursor is moved in this loop (via MiniGame_ProcessInput), the sprites
  ; are never redrawn.  DMA occurs, but the oam buffer is never changed.

  @Loop:
    JSR WaitForVBlank_L     ; Wait for VBlank
    LDA #>oam
    STA $4014               ; do sprite DMA
    JSR DrawPalette_L       ; update the palette
    JSR MusicPlay_L         ; call the music play routine (Probably shouldn't be done until after scroll set -- but doesn't matter)

    LDA #0                  ; THEN set scroll.  Note that if the music routine takes too long, this could theoretically
    STA $2005               ; cause the screen to bork... however DrawPalette resets the scroll to zero anyway due to
    STA $2005               ;  it doing double writes of 0 to $2006.  If DrawPalette didn't do that, however, this could
                            ;  be a serious problem

    INC framecounter        ; increment the frame counter

    LDA framecounter        ; use the frame counter to cycle the palette
    ASL A                   ;  double it
    AND #$30                ;  and mask out these bits for the color.  This cycles between $00 (dark grey),
    STA cur_pal+$13         ;  $10 (md grey), $20, and $30 (both white).  Changing colors once every 8 frames.

    JSR MiniGame_ProcessInput  ; process input (to update joy_a and joy_b)

    LDA joy_a
    ORA joy_b
    BEQ @Loop               ; and keep looping until either A or B pressed

    SEC             ; once they have been pressed... SEC to indicate puzzle solved
    RTS             ; and exit

  @Fail:
    CLC             ; CLC to indicate puzzle not solved
    RTS

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  ClearOAM_BankD   [$AFAB, 0x36FBB]
;;
;;    This is simply a copy of the ClearOAM routine found in the fixed bank.
;;  It doesn't really need to be duplicated here since it could just call the main ClearOAM routine.
;;  My guess is there were assembler limitations that made it difficult to export routines so that they
;;  were visible in other banks (hence all the "_L" versions of routines).  Obviously today we don't
;;  have these limitations... so this seems kind of wasteful.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

ClearOAM_BankD:
    LDX #0
    STX sprindex
    LDA #$F8

  @Loop:
      STA oam, X
      INX
      BNE @Loop

    RTS

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Initial Puzzle Position  [$AFB8 :: 0x36FC8]
;;
;;    LUT contains the initial position for the puzzle pieces in the minigame.
;;  These pieces are further scrambled after loading

lut_PuzzleStart:
  .BYTE $F, $4, $C, $8, $1, $6, $D, $9, $0, $5, $B, $3, $7, $E, $2, $A


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Mini Game -- Process Input [$AFC8 :: 0x36FD8]
;;
;;     Updates joy data and moves around the cursor for the minigame
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

MiniGame_ProcessInput:
    JSR UpdateJoy_L      ; update joypad info

    LDA joy              ; get joy data
    AND #$0F             ; isolate directonal buttons
    CMP joy_prevdir      ; see if they match previously down buttons
    BEQ @Exit            ; if they do match... no change -- just exit

    STA joy_prevdir      ; otherwise, record the change
    CMP #0               ; and see if buttons are being pressed (as opposed to released)
    BEQ @Exit            ; if nothing being pressed -- just exit

    CMP #$04             ; see if they're pressing up or down.  If they are, jump ahead to 'vertical'
    BCS @Vertical

    LDX #1            ; X = our change.  Make a change of 1 if moving right
    CMP #$01          ; compare the buttons pressed to see if they are pressing Right
    BEQ @Move         ; if they are... move

    LDX #-1           ; otherwise, they're moving left... so make a change of -1 instead
    BNE @Move         ; (always branches)

  @Vertical:
    LDX #4            ; moving down = change of 4
    CMP #$04          ; see if they pressed Down
    BEQ @Move         ; if they did... move

    LDX #-4           ; otherwise, they're moving Up.  So change = -4

  @Move:
    TXA               ; put change in A
    CLC
    ADC cursor        ; and add to it our cursor
    AND #$0F          ; then mask to keep them inside the puzzle boundaries
    STA cursor        ; and record that as our new cursor

    TAY
    LDA puzzle, Y     ; check the slot to see if it's empty
    BEQ @Move         ; if it is empty, move again in the same direction until we hit a non-empty slot

  @Exit:
    RTS               ; then exit

; unused (that $60 might be an unused RTS -- but who cares)
;  .BYTE $60,$00

;; JIGS ^ 


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Another little _L jump table  [$B000 :: 0x37010]
;;

MusicPlay_L:    JMP MusicPlay

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Music_NewSong  [$B003 :: 0x37013]
;;
;;    Called when music_track is nonzero, indicating a new track is to be played.
;;
;;  IN:  A = music_track
;;
;;    Bit 6 of the music track ($40) is set for the first call when a track is changed
;;  (all used track numbers have that bit set).  The idea behind this is that the game
;;  only prepares (or "primes") one channel at a time, rather than trying to do all
;;  3 channels in the same frame.  Why it doesn't do all 3 at the same time is beyond me...
;;  it does it in the normal music playback code, so there's no reason it couldn't do it here.
;;
;;    Anyway, if bit 6 is set, this routine clears it, then starts priming channels one
;;  at a time (using mu_chanprimer as a counter to keep track of which channel is next).
;;  Once all 3 channels have been prepped... then music_track is zero'd so that music playback
;;  can really begin.
;;
;;    The game never needs to call this routine directly (except from MusicPlay).  MusicPlay
;;  will call it as soon as it sees a nonzero value in music_track -- therefore all the game
;;  has to do to change tracks is to write the desired track number to music_track.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

Music_NewSong:
    CMP #$40             ; see if bit 6 is set.  If it's set, we need to halt all channels
    BCC @PrimeChannel    ;  and begin priming channels.  If set, we already halted channels
                         ;  and began priming.  So jump ahead to resume priming
      AND #$3F             ; here if bit 6 was set.  Isolate the low bits (track number)
      STA music_track      ; and write back to the music track

      LDA #0
      STA mu_chanprimer   ; zero the channel primer

      ;LDA #0
      ;; JIGS - already 0!
      STA sq2_sfx         ; zero sq2_sfx (seems strange to do here)

      STA $4002           ; then zero each of the channels output freq (including noise)
      STA $4003           ; This in effect silences the squares
      STA $4006           ;  and SLOPPILY silences the tri (tri will pop)
      STA $4007           ;  but does not silence noise -- instead it just makes it crazy high pitched
      STA $400A
      STA $400B
      STA $400E
      
      STA $5002           ; MMC5 Square 1 (Square 3) - JIGS
      STA $5003           ; MMC5 Square 1 (Square 3) - JIGS
      STA $5006           ; MMC5 Square 2 (Square 4) - JIGS
      STA $5007           ; MMC5 Square 2 (Square 4) - JIGS
       STA CHAN_SQ1+ch_octave ; JIGS - and clear out the octave up/down setting
       STA CHAN_SQ2+ch_octave
       STA CHAN_TRI+ch_octave
       STA CHAN_SQ3+ch_octave
       STA CHAN_SQ4+ch_octave
       STA CHAN_SQ1+ch_quiet ; JIGS - and clear out the shushers
       STA CHAN_SQ2+ch_quiet
       STA CHAN_SQ3+ch_quiet
       STA CHAN_SQ4+ch_quiet
       STA CHAN_SQ1+ch_extraquiet
       STA CHAN_SQ2+ch_extraquiet
       STA CHAN_SQ3+ch_extraquiet
       STA CHAN_SQ4+ch_extraquiet
      

      LDA #$30            ; *then* set channel volumes to zero -- this will properly
      STA $4000           ;  silence the squares and noise... and will eventually silence
      STA $4004           ;  triangle (next linear counter clock).  
      STA $4008
      STA $400C
      STA $5000           ; MMC5 Square 1 (Square 3) - JIGS
      STA $5004           ; MMC5 Square 2 (Square 4) - JIGS 

  @PrimeChannel:
    LDA music_track       ; get the music track to play
    SEC                   ; subtract 1 to make it zero based.  Had to be 1-based before
    SBC #1                ;  because a value of $00 means a song is in progress

;    ASL A                 ; multiply by 8 to get the song pointer table index (8 bytes
;    ASL A                 ;  of pointers per song)
;    ASL A
;    ORA mu_chanprimer     ; OR with the channel we're currently priming (only one is done per frame)

    ;; JIGS -- use the MMC5 multiplier registers to use 10 bytes per song, 5 tracks each
    STA $5205             ; Put music track into the MMC5 Multiplier 
    LDA #10                
    STA $5206             ; Multiply by 10
    LDA $5205
    CLC
    ADC mu_chanprimer     ; And do this instead of ORA

    STA tmp               ; this is the low byte of the pointer to the pointer table
    LDA #>lut_ScoreData   ; get the high byte
    STA tmp+1             ;  (tmp) now points to the pointer table for this track.

    LDX mu_chanprimer          ; get the channel we're priming
    LDA @lut_PrimerToChan, X   ; run that through a LUT to convert it to a usable channel index
    STA mu_chan                ; record that as our current channel
    TAX                        ; and put it in X for indexing

    LDY #0                ; read the pointer from the track's pointer table
    LDA (tmp), Y          ;   and set it as this channel's score pointer
    STA ch_scoreptr, X
    INY
    LDA (tmp), Y
    STA ch_scoreptr+1, X

    JSR Music_ChannelScore  ; Then do score processing to get the channel started

    LDA mu_chanprimer    ; inc the primer by 2 (2 bytes per pointer per channel)
    CLC
    ADC #2
    STA mu_chanprimer

    ;CMP #2*3             ; there are 3 channels to load/prime (2 squares + 1 tri).
    CMP #2*5
    ;; JIGS ^ 5 channels now!
    BCC @Exit            ; check to see if all 3 of these have been primed.  If not, just exit
                         ;  otherwise... all channels are primed -- music is all set for playback
      LDA #0
      STA music_track    ; zero music_track to indicate that a track is playing

      ;LDA #0                    ; zero loop counters for all channels
      STA ch_loopctr+CHAN_SQ1
      STA ch_loopctr+CHAN_SQ2
      STA ch_loopctr+CHAN_TRI
      ;STA ch_loopctr+CHAN_STOP  ; this must be intended to be noise -- but since noise isn't
                                ;  part of the music engine -- this is worthless
      
      STA ch_loopctr+CHAN_SQ3   ; JIGS : adding Square 3
      STA ch_loopctr+CHAN_SQ4   ; JIGS : adding Square 4
      STA CHAN_SQ1+ch_loop_marker ; JIGS - Wipe the special Jigs Loop Markers so songs don't flip out.
      STA CHAN_SQ2+ch_loop_marker
      STA CHAN_TRI+ch_loop_marker
      STA CHAN_SQ3+ch_loop_marker
      STA CHAN_SQ4+ch_loop_marker
                                
                                

      ;LDA #%00001111
      LDA #%00011111     ; JIGS - can't remember the reason for the 1 byte increase
                         ; MIGHT have to do with the DMA / DMCA / whatever thing that lowers triangle volume
      STA $4015          ; make sure playback for all channels is enabled
      STA $5015          ; make sure playback for all MMC5 channels is enabled (JIGS)
                         ; And comment out pointless stuff

      ;LDA #0             ; then zero sq2_sfx *again*
      ;STA sq2_sfx        ;  (again this seems silly to do here)

      ;STA $4002          ; and zero all channel freqs except noise
      ;STA $4003          ;  utterly pointless as they've already been zerod
      ;STA $4006
      ;STA $4007
      ;STA $400A
      ;STA $400B
  @Exit:
    RTS

 ;; LUT used to convert from primer index to chan index
  @lut_PrimerToChan:
  .BYTE CHAN_SQ1,  CHAN_SQ1
  .BYTE CHAN_SQ2,  CHAN_SQ2
  .BYTE CHAN_TRI,  CHAN_TRI
  ;.BYTE CHAN_STOP, CHAN_STOP  ; unused -- probably was supposed to be noise
  .BYTE CHAN_SQ3, CHAN_SQ3  ; 
  .BYTE CHAN_SQ4, CHAN_SQ4  ; JIGS 

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Music Play  [$B099 :: 0x370A9]
;;
;;    Should be called every frame from the game (or rather, every frame where
;;  music is audible).  It traverses and parses musical score data to calculate
;;  what frequency/volume each channel is to output.  As these score data updates
;;  the freq/volume.. new tones are heard, which produces music!
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

MusicPlay:
    LDA music_track    ; check the music track
    BPL @Play          ; if high bit is set, song is over
    CMP #$80           ;  if low bit is set, channels are already silenced
    BNE @Exit          ;  so just exit

      LDA #$70         ; otherwise (low bit clear), channels need to be silenced
      STA $4000        ; silence square by setting their volume to zero
      STA $4004
      STA $4008        ; triangle silences eventually (once length or linear counter expires)
      STA $5000        ; silence MMC5 square by setting their volume to zero (JIGS)
      STA $5004

      INC music_track  ; set low bit of music track to mark channels as silenced.  Then exit

  @Exit:
    RTS

  @Play:
    BEQ @Resume        ; if the track was zero, resume a playing track
    JMP Music_NewSong  ; otherwise start a new song


@Resume:
  ;; First, update Square 1's regs to match output music data
  ;;  The high bit of the output F-value is checked to see if the frequency has changed.
  ;;  If there was no change, the frequency should not be written again because writing
  ;;  to the last channel reg ($4003 for sq1) to change the freq resets the duty.  If
  ;;  this is done every frame, the sound would crackle something fierce.

    LDA CHAN_SQ1 + ch_freq+1     ; get high bit of output F-value
    BMI @Sq1_NoFreqChange        ; if it's set, there's no change, so skip ahead

      LDA CHAN_SQ1 + ch_vol      ; get the output volume
      ;ORA #%01110000             ;  set bits to disable length and decay, and set duty to 25%
      ORA #%00110000            ; JIGS - ^ if you disable duty-setting code, swap these two lines ^ 
      STA $4000                  ;  output the volume/duty
      LDA #%01111111
      STA $4001                  ; disable sweep unit
      LDA CHAN_SQ1 + ch_freq
      STA $4002
      LDA CHAN_SQ1 + ch_freq+1
      STA $4003                  ; output frequency

      LDA #$80                   ; set high bit of freq to mark that it doesn't need to be updated
      STA CHAN_SQ1 + ch_freq+1   ;  anymore (that LDA should probalby be ORA, but it doesn't matter)
      JMP @Sq1_Done

    @Sq1_NoFreqChange:           ; if the freq is not to be changed...
      LDA CHAN_SQ1 + ch_vol      ; still update volume (same process as above)
      ;ORA #%01110000
      ORA #%00110000            ; JIGS - ^ if you disable duty-setting code, swap these two lines ^ 
      STA $4000
      LDA #%01111111             ; and disable sweep
      STA $4001

  @Sq1_Done:

  ;; Now we update Sq2's regs.  Since Sq2 is also used for some sound effects, we need
  ;;  to skip this step if Sq2 is busy playing a sound effect.
  ;;
  ;; Square 1 is fixed to output 25% duty all the time (or 75% -- but that's audibly identical)
  ;; Square 2 on the other hand has no duty bits explicitly set, which means the envelope pattern
  ;;  can also specify any duty cycle.  If no duty bits are set in the envelope pattern, it
  ;;  would be 12.5%.  This is the case in the original game, as no duty bits in the envelope tables
  ;;  are set.

    LDA sq2_sfx         ; is sq2 currently playing sfx?
    BEQ @Sq2_Update     ;  if not, update it normally
    DEC sq2_sfx         ; otherwise dec the sfx counter
    BNE @Sq2_Done       ; if it's still not zero (still playing), skip sq2 updating completely
    ;LDA #$30
    ;STA $4004           ; JIGS - set volume to 0 
    ;LDA #$80
    ;STA CHAN_SQ2 + ch_freq+1    
    ;JMP @Sq2_FreqChange
    
    BEQ @Sq2_FreqChange ; otherwise, it's done, force an update to all sq2 regs (always branches)
                        ;   this ensures sq2 will resume playing music immediately, rather than
                        ;   waiting for the next note.
  @Sq2_Update:                  ;  if not playing a sound effect...
    LDA CHAN_SQ2 + ch_freq+1    ; check high bit of F value
    BMI @Sq2_NoFreqChange       ; if set... no freq change

   @Sq2_FreqChange:
      LDA CHAN_SQ2 + ch_vol     ; get volume
      ORA #%00110000            ; disable length/decay.  Don't set any duty bits (12.5% by default)
      STA $4004                 ; output
      LDA #%01111111
      STA $4005                 ; disable sweep

      LDA CHAN_SQ2 + ch_freq    ; output freq
      STA $4006
      LDA CHAN_SQ2 + ch_freq+1
      AND #$0F                  ; remove high bit flag from F-value (not necessary)
      STA $4007
      ORA #$80                  ; then set high bit to mark that it doesn't need updating
      STA CHAN_SQ2 + ch_freq+1  ; and write it back
      JMP @Sq2_Done             ; then sq2 is done!

   @Sq2_NoFreqChange:
      LDA CHAN_SQ2 + ch_vol     ; update vol/sweep just as above -- but don't update freq
      ORA #%00110000
      STA $4004
      LDA #%01111111
      STA $4005

  @Sq2_Done:

  ;; The same process one last time, but this time for the Triangle.
  ;;  Triangle also has the high byte of the freq as $FF if it is to be silenced.
  ;; This is probably because the triangle has no volume control and thus can't be silenced
  ;;  by just setting the volume to zero (even though that could work if coded that way -- but
  ;;  whatever).

    LDA CHAN_TRI + ch_freq+1    ; Get high byte of freq
    BMI @Tri_HighBitSet         ; if high bit of high byte set, skip ahead

      LDA #%10001111            ; otherwise, set linear counter to keep channel playing
      STA $4008                 ;  (keep it audible)
      LDA CHAN_TRI + ch_freq    ; set the freq
      STA $400A
      LDA CHAN_TRI + ch_freq+1
      STA $400B

      LDA #%10000000
      STA CHAN_TRI + ch_freq+1  ; then set high bit to indicate freq doesn't need updating
      JMP @Tri_Done

    @Tri_HighBitSet:            ; if high bit was set
      CMP #$FF                  ;  see if high byte = $FF
      BNE @Tri_Done             ; if not, do nothing
        LDA #%10000000          ;  otherwise, silence the tri by setting the linear counter reload
        STA $4008               ;  to zero.  This will silence the tri on the next linear counter clock.

  @Tri_Done:
  
  ;; JIGS - here we do MMC5 square stuff!
  
   LDA CHAN_SQ3 + ch_freq+1     ; get high bit of output F-value
    BMI @Sq3_NoFreqChange        ; if it's set, there's no change, so skip ahead

      LDA CHAN_SQ3 + ch_vol      ; get the output volume
      ORA #%00110000             ;  set bits to disable length and decay, do not set duty
      STA $5000                  ;  output the volume/duty
      LDA CHAN_SQ3 + ch_freq
      STA $5002
      LDA CHAN_SQ3 + ch_freq+1
      STA $5003                  ; output frequency

      LDA #$80                   ; set high bit of freq to mark that it doesn't need to be updated
      STA CHAN_SQ3 + ch_freq+1   ;  anymore (that LDA should probalby be ORA, but it doesn't matter)
      JMP @Sq3_Done

    @Sq3_NoFreqChange:           ; if the freq is not to be changed...
      LDA CHAN_SQ3 + ch_vol      ; still update volume (same process as above)
      ORA #%00110000
      STA $5000
    
  @Sq3_Done:
  
   LDA CHAN_SQ4 + ch_freq+1     ; get high bit of output F-value
    BMI @Sq4_NoFreqChange        ; if it's set, there's no change, so skip ahead

      LDA CHAN_SQ4 + ch_vol      ; get the output volume
      ORA #%00110000             ;  set bits to disable length and decay, do not set duty
      STA $5004                  ;  output the volume/duty
      LDA CHAN_SQ4 + ch_freq
      STA $5006
      LDA CHAN_SQ4 + ch_freq+1
      STA $5007                  ; output frequency

      LDA #$80                   ; set high bit of freq to mark that it doesn't need to be updated
      STA CHAN_SQ4 + ch_freq+1   ;  anymore (that LDA should probalby be ORA, but it doesn't matter)
      JMP @Sq4_Done

    @Sq4_NoFreqChange:           ; if the freq is not to be changed...
      LDA CHAN_SQ4 + ch_vol      ; still update volume (same process as above)
      ORA #%00110000
      STA $5004
    
  @Sq4_Done:
  
  ;; Now that all 3 channels are playing the tones they're supposed to -- process music data
  ;;  to find what the channels are to play next frame

    LDA #CHAN_START          ; reset mu_chan to start at the first channel (square 1)
    STA mu_chan

@UpdateLoop:
    LDX mu_chan              ; put current channel in X for indexing

    DEC ch_lenctr, X         ; decrement the channel's len counter
    BNE @EnvStep             ; if it's nonzero -- a note is still playing, so update the env pattern

      JSR Music_ChannelScore ; otherwise, the note is done (len expired), so do more score processing
      LDA ch_envpos, X       ; put the env position in A (expected to be there in @UpdateVol)
      JMP @UpdateVol         ;  and jump ahead

  @EnvStep:            ; if a note is still playing... update the env pattern
    LDA ch_envrate, X      ; get the envelope rate
    CLC
    ADC ch_envrem, X       ; add to it the remaining "fraction"
    STA ch_envrem, X       ; and write that back as updated fraction

    CMP #8                 ; check to see if fraction >= 8 (take another step)
    BCC @UpdateNext        ; if not, no further work to be done for envelope.  Skip ahead

      STA tmp              ; otherwise (fraction >= 8), store fraction in tmp for later
      AND #7               ; isolate just the low bits (fraciton bits)
      STA ch_envrem, X     ;  and write those back as the channel's remaining fraction

      LDA tmp              ; then get all the full value back from tmp
      LSR A                ; right shift by 3 (removing fraction)
      LSR A
      LSR A
      CLC
      ADC ch_envpos, X     ; and add that to the envelope position

    @UpdateVol:
      CMP #$20             ; check to see if the envelope position is >= $20
      BCC :+               ;  if it is...
        LDA #$1F           ;  ... cap it at $1F ($1F is maximum)

:     STA ch_envpos, X     ; write back as current env pos
      TAY                  ; then put in Y for indexing

      LDA ch_envptr, X     ; copy the channel's env pointer to tmp
      STA tmp
      LDA ch_envptr+1, X
      STA tmp+1

      LDA (tmp), Y         ; then read the env byte to output
      
      JSR HalfVolume
      JSR HalfVolumeMenu
      ;; JIGS ^ inserting these! This checks to see if we need to halve the volume output
      ;; or double-halve it for the menu
      AND #$3F
      ORA ch_duty, X
      ;; JIGS ^ inserting these! This checks the duty set for the channel
      
      STA ch_vol, X        ; and record that as channel's output volume

  @UpdateNext:        ; processing for this channel is done
    LDA mu_chan            ; so increment mu_chan to look at the next channel
    CLC
    ADC #CHAN_BYTES
    STA mu_chan

    CMP #CHAN_STOP         ; and keep looping until all channels processed
    BCC @UpdateLoop

    RTS                    ; then we're done!  exit!

    
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;JIGS - these two routines divide the volume by two if its meant to be

HalfVolume:
  STA tmp
  LDY ch_quiet, X
  CPY #01
  BEQ @Shush
     RTS
  
  @Shush:
  CLC
  LSR A     ; divide volume by 2
  ADC #$0   ; add the carry back in
  RTS  
  
HalfVolumeMenu:
  STA tmp
  LDY MenuHush
  CPY #01
  BEQ @Shush
     RTS
  
  @Shush:
  CLC
  LSR A     ; divide volume by 2
  ADC #$0   ; add the carry back in
  RTS      
    
    
    
    
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Music Channel Score  [$B189 :: 0x37199]
;;
;;    Processes score (music) data for a channel.  All this does is copy
;;  the channel's score pointer to the general 'mu_scoreptr' var so that it can
;;  be properly indexed, then calls Music_DoScore, which does all the actual work.
;;
;;  IN:  X = index of channel to update
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

Music_ChannelScore:
    LDA ch_scoreptr, X    ; copy the channel's score pointer
    STA mu_scoreptr       ;  to mu_scoreptr
    LDA ch_scoreptr+1, X
    STA mu_scoreptr+1

    JMP Music_DoScore     ; then call Music_DoScore

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Music Do Score  [$B194 :: 0x371A4]
;;
;;    Processes score (music) data for a channel.  Updates the channel's data in RAM,
;;  but does not update any actual APU regs (that's not done until next frame)
;;
;;  IN:            X = Channel to update (CHAN_SQ1, etc -- should be = to mu_chan)
;;       mu_scoreptr = pointer to score data for the channel (should be copied from ch_scoreptr,X)
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


Music_DoScore_IncByA:   ; entry point for resuming -- incs score pointer by A, then resumes
    CLC                   ; add A co ch_scoreptr
    ADC ch_scoreptr, X
    STA ch_scoreptr, X
    STA mu_scoreptr       ; and update mu_scoreptr as well to keep it synced

    LDA ch_scoreptr+1, X  ; include carry in high byte
    ADC #0
    STA ch_scoreptr+1, X
    STA mu_scoreptr+1

Music_DoScore:
    LDY #0
    LDA (mu_scoreptr), Y    ; get a byte from the score
    CMP #$C0                ;  see if it's >= $C0
    BCS @Code_C0_FF         ;  if it is, jump ahead to code processing

      JSR Music_Note        ; otherwise, it's a normal note -- so process it as a note
                            ;  and continue into @Done
  @Done:
    LDA ch_scoreptr, X      ; when done, increment the channel's score pointer by 1
    CLC                     ;  (to get it past the note/rest byte we just processed)
    ADC #1
    STA ch_scoreptr, X
    LDA ch_scoreptr+1, X
    ADC #0
    STA ch_scoreptr+1, X    ; and exit
    RTS                     ;  still don't understand why Nasir disliked INC so much

  @Code_C0_FF:
    CMP #$D0             ; check to see if score code is >= $D0
    BCS @Code_D0_FF      ; if is, jump ahead.

      JSR Music_Rest     ; otherwise it's $Cx, which is a rest.  Process as a rest
      JMP @Done          ;  and jump back to @Done

  @Code_D0_FF:
    CMP #$D8
    BCS @Code_D8_FF      ; next, see if code is >= $D8

      JSR Music_LoopCode  ; if here, it's $D0-D7 (loop/repeat code).  Process the loop
      JMP Music_DoScore   ;  then continue with normal processing (Music_LoopCode updates the
                          ;  score pointer)

  @Code_D8_FF:
    CMP #$E0
    BCS @Code_E0_FF      ; next check for >= $E0

      JSR Music_SetOctave        ; here if code $D8-DF (octave select).  Set octave
      LDA #1
      JMP Music_DoScore_IncByA   ; then resume score processing, adding 1 to score pointer

  @Code_E0_FF:
    CMP #$F0
    BCS @Code_F0_FF      ; >= $F0

      JSR Music_SetEnvPattern    ; here if $E0-EF (env pattern select).
      LDA #1                     ;  set env pattern, then add 1 to score pointer and resume
      JMP Music_DoScore_IncByA

  @Code_F0_FF:
    CMP #$FF             ; is code == $FF ?
    BNE @Code_F0_FE

      LDA #$80           ; If yes, write $80 to the music track to mark that the song is over
      STA music_track    ;  All channels will be silenced next frame
      LDA #0
      STA soundtesthelper ;; JIGS - reset this when there's no music
      RTS                ; RTS because no further score processing is needed if song is over

  @Code_F0_FE:
    CMP #$F8             ; is code == $F8 ?
    BNE @Code_Fx

      LDY #1                ; code is $F8 here (set envelope speed/rate)
      LDA (mu_scoreptr), Y  ;  get the byte following $F8 in the score
      AND #$0F              ;  mask out the low 4 bits
      TAY                   ;  throw in Y, and use it to index
      LDA lut_EnvSpeeds, Y  ;  the desired envelope speed
      STA ch_envrate, X     ;  record that for the channel

      LDA #2
      JMP Music_DoScore_IncByA  ; then resume processing -- incing by 2 (for $F8 and following byte)

  @Code_Fx:              ; here if $F0-F7, or $F9-FE
    CMP #$F9
    BCC @Code_F0; _F7      ; see if $F0-F7

      JSR Music_SetTempo       ; here if $F9-FE -- Tempo select
      LDA #1
      JMP Music_DoScore_IncByA ; resume processing after incing by 1

;;  @Code_F0_F7:
;;    LDA #1                     ; $F0-F7 do absolutely nothing
;;    JMP Music_DoScore_IncByA   ;  just skip over this byte and continue processing

   ;; JIGS added the following...  
      
  @Code_F0:
    CMP #$F0
	BNE @Code_F1_F2
	  JSR Music_LoopCode2
      JMP Music_DoScore
	    
  @Code_F1_F2:
	CMP #$F3                ; if less than F3 
	BCS @Code_F3
	  JSR Music_Goto        ; here if $F1-F2, Music Goto function
      JMP Music_DoScore
        
  @Code_F3:
    CMP #$F3
    BNE @Code_F4
       LDY #01
       LDA (mu_scoreptr), Y  ; get the following byte in the score
       STA ch_octave, X     ; JIGS - SHOULD be either 1 or 2
       LDA #2          
       JMP Music_DoScore_IncByA  
       
  
  @Code_F4:
    CMP #$F4
    BNE @Code_F5
       LDA ch_quiet, X
       CMP #01
       BEQ @UnShush
          LDA #01
          STA ch_quiet, X
          JMP SkipMusicBit
    
       @UnShush:
       LDA #00
       STA ch_quiet, X
       JMP SkipMusicBit
  
  @Code_F5:
    CMP #$F5
    BNE @Code_F6
        JSR Music_Duty
        LDA #2
        JMP Music_DoScore_IncByA  ; then resume processing -- incing by 2 (for $F5 and following byte)

 @Code_F6:
    SkipMusicBit:
    LDA #1                     ; $F6-F7 do absolutely nothing
    JMP Music_DoScore_IncByA   ;  just skip over this byte and continue processing


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Music_LoopCode  [$B217 :: 0x37227]
;;
;;    Called to process a loop/repeat command (code $D0-D7)
;;  Code $D0 is infinite loop, other codes $Dx repeat 'x' times.
;;
;;  IN:  A = code (as read from score)
;;       X = channel index
;;       mu_scoreptr
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

Music_LoopCode:
    AND #$0F                ; get low bits (repeat count)
    STA tmp                 ; back it up for later

    LDA ch_loopctr, X       ; check the loop counter
    ;BEQ @StartLoop          ;  if loop counter is zero, this is a new loop -- start it
    BEQ StartLoop   
    ;; JIGS ^ changing local to hijack the code. I do this again for ResumeLoop
    DEC ch_loopctr, X       ; otherwise, dec the loop counter
    ;BNE @ResumeLoop         ;  if it's still nonzero (still looping), resume the loop
                             ; otherwise, this loop is done -- skip past it
    BNE ResumeLoop             
      
      SKIPLOOP:               ; JIGS added this label    
      LDA ch_scoreptr, X
      CLC
      ADC #3
      STA ch_scoreptr, X    ; skip past the loop code by adding 3 to the score pointer
      STA mu_scoreptr       ; (3 = 2 byte loop address + 1 byte control code)
      LDA ch_scoreptr+1, X  ; update mu_scoreptr as well to keep it in sync
      ADC #0
      STA ch_scoreptr+1, X
      STA mu_scoreptr+1
      RTS

  ;@ResumeLoop:
  ;  LDY #1
  ;  LDA (mu_scoreptr), Y    ; to resume the loop, get low byte of loop address from the score
  ;  STA ch_scoreptr, X      ;  record that as the new score pointer for the channel
  ;  STA tmp                 ; store in tmp (don't change mu_scoreptr yet because we still need it
  ;  INY                     ;   to get the high byte)
  ;  LDA (mu_scoreptr), Y
  ;  STA ch_scoreptr+1, X    ; get high byte
  ;  STA mu_scoreptr+1
  ;  LDA tmp
  ;  STA mu_scoreptr         ; then set low byte of mu_scoreptr previously tmp'd
  ;  RTS                     ; channel is now pointing to loop address -- exit
  ;; JIGS - moving this down here:

  ;@StartLoop:             ; to start a new loop...
  StartLoop:
    LDA tmp               ; get the number to times to repeat this loop
    STA ch_loopctr, X     ; record that as the loop counter
    ;JMP @ResumeLoop       ;  then resume the loop as normal

  ResumeLoop:              ; JIGS changing things
    LDY #1
    LDA (mu_scoreptr), Y    ; to resume the loop, get low byte of loop address from the score
    STA ch_scoreptr, X      ;  record that as the new score pointer for the channel
    STA tmp                 ; store in tmp (don't change mu_scoreptr yet because we still need it
    INY                     ;   to get the high byte)
    LDA (mu_scoreptr), Y
    STA ch_scoreptr+1, X    ; get high byte
    STA mu_scoreptr+1
    LDA tmp
    STA mu_scoreptr         ; then set low byte of mu_scoreptr previously tmp'd
    RTS                     ; channel is now pointing to loop address -- exit


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; JIGS  Music_LoopCode2  
;;
;;    Called to process a loop/repeat command (code $F0)
;;    F0 is a "go back to X then skip the second time" kind of loop,
;;	  allowing a song to play something twice, then have a variation
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

Music_LoopCode2:
 	LDA ch_loop_marker, X	; if 0 (no loop yet started)
	BEQ @StartLoop			; go to start
	CMP #$01				; if 1 (loop started)
	BEQ @ResumeLoop			; ResumeLoop
	JMP SKIPLOOP       		; Otherwise, ignore it
	
	@ResumeLoop:
	LDA #00					; load nothing
	STA ch_loop_marker, X	; write over the loop code so its 0 again for next time
	DEC ch_loopctr, X       ; dec the main loop counter, since it won't get to it again
	JMP ResumeLoop			; then do the Loop
			
	@StartLoop:             ; to start a new loop...
	LDA #01					; Load 1
	STA ch_loop_marker, X   ; Save 
	JMP SKIPLOOP       		; Skip over F0 and pointer in the score and resume playing

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  JIGS  Music_Goto
;;
;;    Called to process a goto/return command (code $F1 or $F2)
;;    
;;	  
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
   
Music_Goto:
    CMP #$F2                ; if F2 then goto the Return part
    BEQ @Return             ; otherwise its an F1, so find the point in the song to start playing next--
    
    JSR @SaveReturnPoint    ; ...once we get the return point saved...
    JMP ResumeLoop          ; --which works the same way as resuming a loop! But is skipping to another spot entirely.
  
    @Return:                ; 
      LDA ch_return, X      ; load return pointers
      STA ch_scoreptr, X    ; save as channel and music pointers
      STA mu_scoreptr       ;
      LDA ch_return+1, X    ;
      STA ch_scoreptr+1, X  ;
      STA mu_scoreptr+1     ;
      RTS
    
    @SaveReturnPoint:		
    LDA ch_scoreptr, X
    CLC
    ADC #3
    STA ch_return, X        ; skip past the F1 and .WORD bytes 
    LDA ch_scoreptr+1, X    ; 
    ADC #0
    STA ch_return+1, X
    RTS    


    
    
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Music_Note  [$B250 :: 0x37260]
;;
;;    Called to process a note score code ($00-BF)
;;
;;  IN:  A = code (as read from score)
;;       X = index to channel
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

Music_Note:
    STA tmp+14               ; backup the code
    JSR Music_ApplyTone      ; apply the tone
    LDA tmp+14               ; restore the code
    JMP Music_ApplyLength    ; apply the length, and exit

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Music_Rest  [$B25A :: 0x3726A]
;;
;;    Called to process a rest score code ($C0-CF)
;;
;;  IN:           A = code (as read from score)
;;       mu_chan, X = index to channel
;;
;;    Note that rests silence the triangle, but do not change the output of the squares.
;;  As a result, rests are really only rests for the triangle, and are more like 'sustain
;;  note' for the squares, in that the squares will keep playing normally.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

Music_Rest:
    JSR Music_ApplyLength_Rest   ; apply the length

    LDA mu_chan        ; see if this is the triangle
    CMP #CHAN_TRI
    BNE @Exit          ;  if it is, make the tri rest by marking that it needs to be silenced
      LDA #$FF         ; this is done by setting the high byte of the freq to $FF (only works with the tri)
      STA CHAN_TRI + ch_freq+1
  @Exit:
    RTS


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Music_ApplyTone  [$B268 :: 0x37278]
;;
;;    Loads/applies the desired freq for the given note.
;;
;;  IN:  A = code (as read from score).  High 4 bits are the note
;;       X = index to channel data
;;
;;    This routine seems to have remnants of support for the noise channel in
;;  music.  The noise channel does not take part in any music tracks (it's only
;;  used for sound effect outside of the music routines.  Therefore the noise
;;  section of this routine goes completely unused.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

Music_ApplyTone:
;    CPX #CHAN_STOP    ; see if this channel is noise
;    BNE @NotNoise     ; if it's not noise, jump ahead

;      LSR A           ; for noise (unused)
;      LSR A
;      LSR A           ; right-shift value to get the high bits (note/tone)
;      LSR A
;      CLC
;      ADC #4          ; add 4 to that (change $0-B to $4-F)
;      STA ch_freq, X  ;  use that as new F value
;      LDA #0
;      STA ch_freq+1, X  ; clear high byte of freq to mark freq needs updating
;      RTS             ; exit

;;      JIGS - unused

  @NotNoise:    ; other channels (squares, tri)
    LSR A            ; right shift code by 3 and isolate what previously was the high bits
    LSR A            ;  this is the same as right-shifting by 4 to get the high bits (note to play),
    LSR A            ;  then doubling that to get the index (2 bytes of F-data per note)
    AND #($F0 >> 3)
    TAY              ; put note*2 in Y for indexing

    LDA ch_frqtblptr, X    ; copy freq table pointer to tmp
    STA tmp
    LDA ch_frqtblptr+1, X
    STA tmp+1

    LDA (tmp), Y        ; read the new freq from that table
    STA ch_freq, X      ; and record it as the new freq for this channel to output
    INY
    LDA (tmp), Y
    STA ch_freq+1, X

    RTS              ; and exit


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Music_ApplyLength  [$B292 :: 0x372A2]
;;
;;    Applies the desired length to a note/rest.
;;
;;  IN:   A = code (as read from score) of the note/rest
;;        X = index to channel
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

Music_ApplyLength:          ; for notes
    AND #$0F          ; isolate low bits (note length)
    TAY               ; put in Y for indexing

    LDA ch_lentblptr, X    ; copy channel's length table pointer to tmp
    STA tmp
    LDA ch_lentblptr+1, X
    STA tmp+1

    LDA (tmp), Y      ; get note length from lookup table
    STA ch_lenctr, X  ; record as channel's length counter

    LDA #0
    STA ch_envpos, X  ; reset the envelope counter (and env fraction) to restart
    STA ch_envrem, X  ;  the envelope pattern

    RTS               ; and exit


Music_ApplyLength_Rest:    ; for rests
    AND #$0F                 ; exact same process -- except don't restart envelope pattern
    TAY

    LDA ch_lentblptr, X
    STA tmp
    LDA ch_lentblptr+1, X
    STA tmp+1

    LDA (tmp), Y
    STA ch_lenctr, X

    RTS


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Music_SetTempo  [$B2B8 :: 0x372C8]
;;
;;    Called to process a tempo control code ($F9-FE).  It simply changes
;;  the LUT used for note length lookups.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


Music_SetTempo:
    SEC               ; subtract 9 to make the low digit zero based ($F9-FE -> F0-F5)
    SBC #$09
    AND #$0F          ; isolate low bits (tempo ID)
    ASL A             ; multiply by 16 (16 bytes per length table)
    ASL A
    ASL A
    ASL A

    CLC
    ADC #<lut_NoteLengths  ; add the above to the start of the note length luts
    STA ch_lentblptr, X    ;  to get the pointer to the desired length table
    LDA #>lut_NoteLengths
    ADC #0
    STA ch_lentblptr+1, X  ; and record that length table for the channel

    RTS

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Music_SetOctave  [$B2CD :: 0x372DD]
;;
;;    Called to process octave control codes ($D8-DF)
;;  Note codes $DC-DF should not be used because the freq table is only
;;  4 octaves large.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

Music_SetOctave:
    AND #$07                 ; isolate the low bits of the control code (the desired octave)
    TAY                      ;  put in Y for indexing
    JSR CheckOctave          ; JIGS - added this!

    LDA #<lut_NoteFreqs      ; take the pointer to the frequency table
    CLC                      ;  add to it the offset to the desired octave
    ADC lut_OctaveOffset, Y  ; and store the resulting pointer (which points to a 12-entry
    STA ch_frqtblptr, X      ;  table of notes at the desired octave) as the channel's
    LDA #>lut_NoteFreqs      ;  freq table pointer.
    ADC #0
    STA ch_frqtblptr+1, X

    RTS                      ; then exit
    
    
 CheckOctave:
    LDA ch_octave, X        ; JIGS
    CMP #01                 ; 0 do nothing, 1 decrease octave, 2 increase octave
    BEQ @OctaveDown
    CMP #02
    BEQ @OctaveUp
     @Return:
     RTS
    
  @OctaveUp:
     CPY #03                ; if Y = 3 (Octave DB) then don't increase it...
     BEQ @Return
     INY
     RTS
    
  @OctaveDown:
    CPY #04                 ; if Y = 4 (Octave DC) then don't decrease it...
    BNE @CheckZero
        RTS
  @CheckZero:             ; if Y = 0 (Octave D8) then increase to 4 (DC) which is the bass octave! confusing.
    CPY #00    
    BEQ @SetToDC    
        DEY
        RTS
    @SetToDC:
        LDY #04
        RTS    
    

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Music_SetEnvPattern  [$B2DF :: 0x372EF]
;;
;;    Called to process envelope pattern control codes ($E0-EF)
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

Music_SetEnvPattern:
    STY tmp+15            ; zero temp RAM (Y is assumed to be zero)
    ASL A                 ;  this is done so it can catch the carry
    ASL A
    ASL A                 ; multiply the desired env pattern (low 4 bits) by 32
    ASL A                 ;  (32 bytes per env pattern)
    ASL A
    ROL tmp+15            ; rotate high bit of carry into temp ram

    ADC #<lut_EnvPatterns  ; set the channel's envptr to the pointer to the
    STA ch_envptr, X       ; Env Pattern LUT + patternID*32
    LDA #>lut_EnvPatterns
    ADC tmp+15
    STA ch_envptr+1, X

    RTS                   ; and exit
    
    
;;;;;
;; JIGS - set the duty for the channel! 
;; This is done by using F5 in the score.
;; The following byte names the channel and the duty rate.
;; 
;; $01 - duty 12.5%
;; $02 - duty 25%
;; $0x - duty 50% ; any byte higher than 2 will set it to 50%
;;
    
Music_Duty:    
    LDY #1                 
    LDA (mu_scoreptr), Y  ; get the following byte in the score
    CMP #$01
    BEQ DutySet12       
    CMP #$02
    BEQ DutySet25
    ;CMP #$30
    ;BEQ DutySet50
    DutySet50:
       LDA #%10000000
       STA ch_duty, X
       RTS
    DutySet12:;.5
       LDA #%00000000        
       STA ch_duty, X
       RTS
    DutySet25:
       LDA #%01000000       
       STA ch_duty, X
       RTS        
    
        
    

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  LUT for octave changes   [$B2F3 :: 0x37303]
;;
;;    Values here are used as an additive to offset the below note freq table
;;  in order to select an octave.  Strangely, this table is 6 entries large, but the
;;  freq table is only 4 octaves large, which means the last 2 entries in this table
;;  are useless

lut_OctaveOffset:
  .BYTE 0*12*2     ; 12 notes per octave * 2 bytes of freq per note
  .BYTE 1*12*2
  .BYTE 2*12*2
  .BYTE 3*12*2
  .BYTE 4*12*2     ; last two entries are useless (note freq table isn't large enough)
  .BYTE 5*12*2     ; JIGS - note that only THIS line is useless 

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  LUT for note freqs [$B2F9 :: 0x37309]
;;
;;    Values here are used to convert note IDs (C, C#, etc) to a usable F-value for
;;  output to the channel's registers.  There are 4 octaves, twelve notes per
;;  octave

lut_NoteFreqs:
  ;       C     C#    D     D#    E     F     F#    G     G#    A     A#    B
  .WORD $0357,$0327,$02FA,$02CF,$02A7,$0281,$025D,$023B,$021B,$01FC,$01E0,$01C5 ; D8 - low
  .WORD $01AB,$0193,$017D,$0167,$0153,$0140,$012E,$011D,$010D,$00FE,$00F0,$00E2 ; D9 - mid
  .WORD $00D6,$00CA,$00BE,$00B4,$00AA,$00A0,$0097,$008F,$0087,$007F,$0078,$0071 ; DA - high
  .WORD $006B,$0065,$005F,$005A,$0055,$0050,$004C,$0047,$0043,$0040,$003C,$0039 ; DB - highest
  .WORD $06AD,$064D,$05F2,$059D,$054C,$0500,$04B8,$0474,$0434,$03F8,$03BF,$0389 ; DC - BASS
  ;; JIGS ^ ADDED BASS OCTAVE

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  LUT for note/rest lengths  [$B359 :: 0x37369]
;;
;;    Values used here are used to convert the 'length' portion of a note rest
;;  code (the low 4 bits) into a usable duration in frames.

lut_NoteLengths:

;        0   1   2   3   4   5   6   7   8   9   A   B   C   D   E   F
  .BYTE $C0,$60,$30,$18,$0C,$90,$48,$24,$C0,$60,$30,$18,$0C,$90,$48,$24 ; F9
  .BYTE $78,$3C,$1E,$0F,$07,$5A,$28,$14,$78,$3C,$1E,$0F,$07,$5A,$28,$14 ; FA
  .BYTE $90,$60,$48,$30,$24,$18,$12,$0C,$09,$06,$03,$03,$04,$10,$08,$08 ; FB
  .BYTE $78,$50,$3C,$28,$1E,$14,$0F,$0A,$07,$05,$03,$02,$0E,$0D,$07,$06 ; FC
  .BYTE $6C,$48,$36,$24,$1B,$12,$0E,$09,$07,$04,$03,$06,$0E,$60,$40,$30 ; FD (99 bpm)
  ;.BYTE $60,$40,$30,$20,$18,$10,$0C,$08,$06,$04,$02,$02,$0B,$0A,$06,$05 ; FE
  .BYTE $80,$60,$40,$30,$20,$18,$10,$0C,$08,$06,$04,$02,$03,$05,$01,$C0 ; (115 bpm)
  ; JIGS ^ note lengths used for my Marsh Cave replacement
  
;; JIGS -- NOTE : I changed an original byte of code in the FD string, under the B column, from a $03 to a $06
;; This is so I can use triplets that equal the same length as an eighth note ($12)
  
  
; a list of what note lengths each song uses:
;   
; F9 - none, and the note lengths are messed up/unfinished
; FA - same
;
; FB - Prologue, Matoya, Marsh Cave (original), Temple of Fiends, Overworld, Ship, Earth Cave,
;      Sea Shrine, Battle, Victory Fanfare, Save, Heal
;
; FC - Airship, Town, Menu, Slain, Common Treasure, Epilogue
;
; FD - Prelude, Castle, Shop, Sky Castle, Treasure Fanfare
;
; FE - Original: none, and the note lengths are messed up/unfinished ; now used for my Marsh Cave replacement


;; With FD, a $_7 is a sixteenth note.
;; $_6 = 
;; $_5 = 8th
;; $_4 = 
;; $_3 = 4th
;; $_2 = 
;; $_1 = half note
;; $_0 = three-quarters
;; there is no whole note, which I fixed in my own LUT. 
;; If it fit, $_F would be a note and a half.
;; 0 being a whole note also pushed things right to make a bit more sense
;; with even numbers being even note lengths
  
; JIGS - here's an alternate note length lut that I was using
;; Some of them aren't great with the dividing/multiplication of numbers
;; I tried my best to keep track of how each hex byte compares to ticks per quarter note
;; But my midi program of choice only goes down to "quarter note = 48"
;; So only the first line is really accurate
;; For a lot of shorter notes, you'll need to do some combination math; 
;; that's why there's a lot of 1s and 2s and 3s going on.
;; I would add those in as rests to keep uneven notes on schedule with the rest of the song

;      0   1   2   3   4   5   6   7   8   9   A   B   C   D   E   F
;.BYTE $C0,$90,$60,$48,$30,$24,$18,$12,$0C,$09,$06,$03,$04,$08,$01,$02 ; F9 - 75 bpm
;      192 144  96  72  48  36  24  18  12   9   6	3	4	8   1   2
;.BYTE $A0,$78,$50,$3C,$28,$1E,$14,$0F,$0A,$07,$05,$03,$03,$01,$02,$F0 ; FA - 90 bpm
;      160 120  80  60  40  30  20  15  10   7	5	3	3	1	2  240
;.BYTE $90,$6C,$48,$36,$24,$1B,$12,$0E,$09,$07,$04,$03,$03,$01,$01,$D8 ; FB - 99 bpm
;      144 108  72  54  36  27  18  14	9	7	4	3	3	1	0  216
;.BYTE $80,$60,$40,$30,$20,$18,$10,$0C,$08,$06,$04,$02,$03,$05,$01,$C0 ; FC - 115 bpm
;      128  96	64	48	32	24	16	12	8	6	4	2	3	5   1  192
;.BYTE $78,$5A,$3C,$2D,$1E,$16,$0F,$0B,$07,$05,$04,$02,$03,$01,$01,$B4 ; FD - 120 bpm
;      120  90  60  45  30  22	15	11	7	5	4	2	3	1	0  180
;.BYTE $60,$48,$30,$24,$18,$12,$0C,$09,$06,$04,$03,$01,$02,$01,$01,$90 ; FD - 150 bpm
;      96   72	48	36	24	18	12	9	6	4.5	3	1.5	2	1	0  144 
  
  
  
  
  
  
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  LUT for music envelope speeds  [$B3B9 :: 0x373C9]
;;
;;    Values here are used as speeds for traversal through below envelope tables.
;;  Values are fixed point with 3 bits of fraction.  IE:  a speed of $0C would be 
;;  one and a half steps through the table every frame (3 steps every two frames)
;;
;;    Note that overflow when doing math with these values is not handled by the
;;  game, so none of these values should go above %11111000.  That will ensure that
;;  the addition of the existing 'fraction' will never cause an overflow.

lut_EnvSpeeds:
  .BYTE $80,$60,$40,$30,$20,$18,$10,$0C,$08,$06,$04,$03,$02,$01,$00,$00


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  LUTs for envelope patterns  [$B3C9 :: 0x373D9]
;;
;;    These are 16 tables, each table consisting of 32 entries.  These tables
;;  represent the envelope pattern that the channel is to take every note it plays.
;;  $0F is full volume, and $00 is silence.  The speed at which the channel traverses
;;  these tables depends on their envelope rate, which is determined in part by
;;  the above lut (lut_EnvSpeeds).  Once the channel reaches the end of the table, the
;;  last entry is sustained (infinitely repeated).
;;    Note that volume/envelope is only applicable to squares, as triangle has no volume
;;  control.

lut_EnvPatterns:
  .BYTE  $0F,$0F,$0E,$0E,$0D,$0D,$0C,$0C,$0B,$0B,$0A,$0A,$09,$09,$08,$08 ; pattern $E0
  .BYTE  $07,$07,$06,$06,$05,$05,$04,$04,$03,$03,$02,$02,$01,$01,$00,$00 ;  gradual decay from F

  .BYTE  $0C,$0C,$0C,$0B,$0B,$0B,$0A,$0A,$0A,$09,$09,$09,$08,$08,$08,$07 ; pattern $E1
  .BYTE  $07,$06,$06,$06,$05,$05,$04,$04,$03,$03,$02,$02,$01,$01,$00,$00 ;  gradual decay from C

  .BYTE  $08,$08,$08,$08,$07,$07,$07,$07,$06,$06,$06,$06,$05,$05,$05,$05 ; pattern $E2
  .BYTE  $04,$04,$04,$04,$03,$03,$03,$03,$02,$02,$02,$02,$01,$01,$00,$00 ;  gradual decay from 8

  .BYTE  $04,$04,$04,$04,$04,$04,$04,$04,$03,$03,$03,$03,$03,$03,$03,$03 ; pattern $E3 ; only used in Shop and new Marsh Cave
  .BYTE  $03,$03,$03,$03,$03,$03,$03,$02,$02,$02,$02,$02,$02,$00,$00,$00 ;  gradual decay from 4

  .BYTE  $0F,$0F,$0E,$0E,$0D,$0D,$0C,$0C,$0B,$0B,$0A,$0A,$09,$09,$08,$08 ; pattern $E4 ; unused
  .BYTE  $08,$08,$09,$09,$0A,$0A,$0B,$0B,$0C,$0C,$0D,$0D,$0E,$0E,$0F,$0F ;  fade from F->8->F

  .BYTE  $0C,$0C,$0B,$0B,$0A,$0A,$09,$09,$08,$08,$07,$07,$06,$06,$05,$05 ; pattern $E5 ; only used in Slain 
  .BYTE  $04,$04,$05,$05,$06,$06,$07,$07,$08,$08,$09,$09,$0A,$0A,$0B,$0B ;  fade from C->4->B

  .BYTE  $08,$08,$07,$07,$06,$06,$05,$05,$04,$04,$03,$03,$02,$02,$01,$01 ; pattern $E6
  .BYTE  $01,$01,$02,$02,$03,$03,$04,$04,$05,$05,$06,$06,$07,$07,$08,$08 ;  fade from 8->1->8

  .BYTE  $0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0E,$0E,$0C,$0C,$0B,$0B,$0A,$0A ; pattern $E7 ; only used in my prelude melody
  .BYTE  $09,$09,$08,$08,$07,$07,$06,$06,$05,$05,$04,$04,$04,$03,$03,$03 ;  hold, then decay from F

  ;.BYTE  $0C,$0C,$0C,$0C,$0C,$0C,$0C,$0C,$0B,$0B,$0A,$0A,$09,$09,$08,$08 ; pattern $E8 -- unused
  ;.BYTE  $06,$06,$05,$05,$04,$04,$04,$03,$03,$03,$02,$02,$02,$02,$02,$02 ;  hold, then decay from C
  
  .BYTE  $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00  
  .BYTE  $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00

  ;; JIGS - since no original song uses this, I'm setting it to the "silent" instrument
  ;;        So that music that plays in places where square 2 does SFX can use it to silence SFX properly after playing.
  ;;        That's Battle, and Prologue (plays during tile mini game)
  ;;        So by the time you need to edit this, hopefully you've worked out a better solution.
  ;;        Or maybe just don't care about an instrument being used as SFX for a few frames!
  ;;        You'll probably just use another music engine though...
  
  .BYTE  $04,$04,$04,$04,$04,$04,$04,$04,$04,$03,$03,$03,$03,$03,$03,$03 ; pattern $E9 ; JIGS - only used in my prelude melody
  .BYTE  $03,$03,$02,$02,$02,$02,$02,$02,$02,$02,$01,$01,$01,$01,$01,$01 ;  hold, then decay from 4

  .BYTE  $08,$08,$09,$09,$0A,$0A,$0B,$0B,$0C,$0C,$0D,$0D,$0E,$0E,$0F,$0F ; pattern $EA
  .BYTE  $0F,$0F,$0E,$0E,$0D,$0D,$0C,$0C,$0B,$0B,$0A,$0A,$09,$09,$08,$08 ;  fade from 8->F->8

  .BYTE  $04,$04,$05,$05,$06,$06,$07,$07,$08,$08,$09,$09,$0A,$0A,$0B,$0B ; pattern $EB
  .BYTE  $0C,$0B,$0A,$0A,$09,$09,$08,$08,$07,$07,$06,$06,$05,$05,$04,$04 ;  fade from 4->C->4

  .BYTE  $0F,$0E,$0D,$0C,$0B,$0A,$09,$08,$09,$0A,$0B,$0C,$0B,$0A,$09,$08 ; pattern $EC
  .BYTE  $07,$06,$05,$04,$05,$06,$07,$08,$07,$06,$05,$04,$03,$02,$01,$00 ;  decay from F with tremolo

  .BYTE  $0C,$0C,$0B,$0B,$0A,$0A,$09,$08,$09,$0A,$0B,$0C,$0B,$0A,$09,$08 ; pattern $ED
  .BYTE  $07,$06,$05,$04,$05,$06,$07,$08,$07,$06,$05,$04,$03,$02,$01,$00 ;  decay from C with tremolo

  .BYTE  $0C,$0B,$0A,$09,$08,$07,$06,$05,$04,$05,$06,$07,$08,$07,$06,$05 ; pattern $EE
  .BYTE  $04,$05,$06,$07,$08,$07,$06,$05,$04,$05,$06,$07,$08,$09,$0A,$0B ;  fade C->4->B with tremolo

  .BYTE  $01,$02,$03,$04,$05,$06,$07,$08,$09,$0A,$0B,$0C,$0B,$0A,$09,$08 ; pattern $EF ; JIGS - only used in my prelude melody
  .BYTE  $07,$06,$05,$04,$05,$06,$07,$08,$09,$08,$07,$06,$05,$04,$03,$01 ;  fade in then out with tremolo

 ;; JIGS - some alternate patterns:
;   .BYTE  $0C,$0B,$0A,$0B,$0C,$0B,$0A,$09,$08,$07,$06,$05,$04,$05,$06,$07 
;   .BYTE  $08,$09,$0A,$0B,$0B,$0A,$09,$08,$07,$06,$05,$04,$03,$02,$01,$00 ;  C\A/C \>\ 4 />/ B \\\\  (Violin/Pipes)
;   
;  .BYTE $0F,$0E,$0C,$0A,$08,$05,$03,$01,$0C,$0A,$08,$06,$04,$02,$00,$00 ; Echo
;  .BYTE $08,$07,$06,$04,$02,$00,$00,$00,$04,$03,$02,$01,$00,$00,$00,$00
;
;  Note that with the half-volume control, you don't need pattern E2 or E3; 
;  You can use pattern E0 or E1 and just put the hush on it to have it almost the same! Almost.
;  Many other patterns can be taken out and replaced with this.
  
  
  
  
  
  
  
  
  
  
;;;;;;;;;;;;;;;;;;;;;;
;;  unknown - unused  [$B5C9 :: 0x375D9]

lut_OrbCHR: 
  .INCBIN "bin/0D_B5C9_menuorbs.bin"

;  .INCBIN "bin/0D_B5C9_unknown.bin"
;; JIGS - same thing, just not unknown anymore!
;; Note that the graphics are edited a bit to give the menu some neat connecting box tiles.

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  EnterBridgeScene_L  [$B800 :: 0x37810]
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

EnterBridgeScene_L:              JMP EnterBridgeScene


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  EnterEndingScene   [$B803 :: 0x37813]
;;
;;    Enters the ending scene (epilogue that appears after you
;;  kill chaos)
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

EnterEndingScene:
    LDA #$43
    STA music_track           ; start music track $43 (epilogue music)

    JSR Story_FillSecAttrib   ; fill secondary NT's attribute table (make it blue)
    JSR Ending_StartPPU       ; load BG palette and start up the PPU

    LDA #0
    STA story_credits         ; we won't be drawing credits, so clear that

    LDA lut_Bridge_LastPage   ; start drawing story pages from AFTER the bridge scene
    STA story_page            ;  (both bridge and ending scene text is stored together, bridge
                              ;  scene text is stored first).

  @StoryLoop:
      LDA story_page            ; see if we're to the last page
      CMP lut_Ending_LastPage
      BCS @StoryExit            ; if we are, exit this loop

      LDA #1
      STA story_dropinput     ; otherwise, ignore/drop user input

      JSR Story_DoPage        ; do a page of story
      JMP @StoryLoop          ; and keep looping

  @StoryExit:
    LDA #$04                  ; redraw the story box
    STA box_x                 ;  this erases its contents.
    STA box_y
    LDA #$12
    STA box_wd
    LDA #$0C
    STA box_ht
    JSR DrawBox_L

    JSR Story_OpenShutters      ; Do the shutter opening effect to reveal the empty story box

    JSR DrawFancyTheEndGraphic  ; Do the fancy "The End" drawing effect

  @FinalLoop:              ; then the game is over!
    JSR WaitForVBlank_L    ; simply wait endlessly... FOREVER  **THERE IS NO ESCAPE**
    JSR MusicPlay_L        ;   but keep the music playing by calling MusicPlay every frame
    JMP @FinalLoop


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Enter Bridge Scene  [$B847 :: 0x37857]
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


EnterBridgeScene:
    JSR Story_FillSecAttrib    ; fill secondary NT's attribute table (make it blue)
    JSR Bridge_StartPPU        ; load the BG palette, and start up the PPU

    LDA #$42
    STA music_track         ; start music track $42 (bridge scene music)

    LDA #0
    STA story_credits       ; start with drawing story (not credits)
    STA story_page          ; and start on page zero

  ; this loop does the first few pages of the bridge scene (the story)

   @StoryLoop:
      LDA story_page           ; get current page
      CMP lut_Bridge_LastPage  ; see if we've reached the max story page for the bridge scene
      BCS @StoryExit           ; if we have, exit this loop

      LDA #0
      STA story_dropinput   ; set dropinput to zero (we don't want to ignore user input)
      JSR Story_DoPage      ; and do a page of story

      JMP @StoryLoop        ; and continue looping until all necessary pages have been done

  @StoryExit:
    LDA #0
    STA story_page          ; reset the page number to zero
    LDA #1
    STA story_credits       ; but this time, we're doing the credits

  ; this loop does the next few pages of the bridge scene (the credits)

  @CreditsLoop:
      LDA story_page        ; check page number
      CMP #4                ; there are 4 pages of credits
      BCS @CreditsExit      ; if we've done all 4, exit this loop

      LDA #0                ; otherwise, zero dropinput so we don't ignore user input
      STA story_dropinput
      JSR Story_DoPage      ; and do a page of credits

      JMP @CreditsLoop      ; and continue looping

  @CreditsExit:
    LDA #$80              ; mark the bridge scene as completed.. so it won't be activated again
    STA bridgescene       ;   if the user walks over the bridge again

  ; this last loop simply stalls a bit ($20 frames) before exiting so the exit
  ;  isn't so abrupt

    LDA #$20              ; downcounter for number of frames to stall.  ($20 frames)
   @StallLoop:
      PHA                 ; push down counter
      JSR Story_EndFrame  ; stall a frame
      PLA                 ; pull and decrement down counter
      SEC
      SBC #1
      BNE @StallLoop      ; and loop until it expires

    LDA #$01              ; then move the PPU over to the "closed" NT (even though it should be there
    STA soft2000          ;  already!)
    STA $2000

    RTS                   ; and exit

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Story - Fill Secondary Attribute Table  [$B899 :: 0x378A9]
;;
;;    This fills the top half of the secondary NT's ($2400) attribute table.
;;  Essentially, this makes the story box on the $2400 NT a blue color, but makes
;;  the story box on the $2000 NT a black color.  The game will then
;;  toggle between these NTs every few scanlines to do that shutter effect seen
;;  in the Story screens (Bridge and Ending scenes).
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

Story_FillSecAttrib:
    LDA #0
    STA $2001             ; turn off PPU

    LDA #0
    STA story_page        ; reset story page to zero (totally unnecessary here)

    LDX #0                ; zero X for upcoming loop

    LDA $2002             ; reset PPU toggle
    LDA #$27
    STA $2006             ; set PPU Address to $27C0  (attribute table for nt@$2400)
    LDA #$C0
    STA $2006

  @Loop:
      LDA lut_StorySecondaryAttrib, X   ; copy byte from our attribute LUT
      STA $2007                         ; to the actual attribute table
      INX
      CPX #$20
      BCC @Loop           ; loop until $20 bytes copied (top half of attribute table)

    LDA #0             ; reset NT scroll to zero (seems weird to do here)
    STA soft2000
    STA $2000

    RTS                ; then exit


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Story - Start PPU  [$B8C4 :: 0x378D4]
;;
;;    Loads and draws the desired palette for the Bridge or Ending scene,
;;  then turns the PPU on and resets the scroll.
;;
;;    Two entry points.  One for the bridge scene, and one for the ending scene.
;;  The only difference between the two is a different palette is loaded.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

 ;; entry point for the Ending Scene

Ending_StartPPU:
    JSR Ending_LoadPalette   ; load ending palette
    JMP _Story_StartPPU      ;  then jump ahead to turn on PPU


 ;; entry point for the Bridge Scene

Bridge_StartPPU:
    JSR Bridge_LoadPalette   ; load bridge palette
                             ;  then flow into next section to turn on PPU


  _Story_StartPPU:
    JSR WaitForVBlank_L    ; wait for VBlank
    LDX #0                 ; zero X (completely pointless)
    JSR DrawPalette_L      ; draw the palette

    LDA #$0A
    STA $2001              ; turn on BG rendering (but leave sprites disabled)
    LDA #0
    STA $2005
    STA $2005              ; reset X and Y scroll
    RTS                    ; and exit



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Story - Do Page  [$B8E3 :: 0x378F3]
;;
;;    Does one page of story.  Incuding the open and close shutter effects.
;;
;;  IN:   story_page, story_credits
;;
;;  OUT:  story_page = incremented by 1
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


Story_DoPage:
    LDA #$01             ; switch to "closed" NT (shutters closed)
    STA soft2000
    STA $2000

    STA menustall        ; enable menu stalling (drawing is going to be done while PPU on)

    LDA #BANK_THIS       ; set current and return banks -- needed for
    STA cur_bank         ;  DrawComplexString, which is called from Story_DrawText
    STA ret_bank

    LDA #$04             ; redraw the story box at coords $04,$04
    STA box_x            ;  and with dims  $12,$0C
    STA box_y
    LDA #$12             ; this will erase the box's previous contents (the previous page)
    STA box_wd
    LDA #$0C
    STA box_ht

    JSR DrawBox_L            ; draw the box (erases contents)
    JSR Story_DrawText       ; draw this page of story text / credits
    JSR Story_OpenShutters   ; do the open shutter effect
    JSR Story_Wait           ; wait for user to read the text
    INC story_page           ;  then increment the story page
    JMP Story_CloseShutters  ; do the close shutter effect, then exit

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Story - Wait  [$B911 :: 0x37921]
;;
;;    Called when story/credit text is to be displayed.  Waits for user to
;;  read onscreen text before proceeding.
;;
;;    This waits for 512 frames (~8.5 seconds) maximum.  Or, if user input
;;  is not ignored, it exits when the user presses A or B (or after 512 frames
;;  if they never do).  User input is dropped/ignored for the ending scene, so the
;;  user has no choice but to wait.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

Story_Wait:
    LDA #2
    STA story_timer     ; set story timer to 2 (2*256 frames to wait = 512 frames)
    LDA #0
    STA framecounter    ; reset frame counter to zero (so it can count up to 256)

    STA joy_a           ; clear A and B button catchers
    STA joy_b

  @Loop:
    JSR WaitForVBlank_L    ; wait for VBlank
    JSR MusicPlay_L        ; keep music playing
    JSR UpdateJoy_L        ; update joypad data

    LDA story_dropinput    ; see if we're to drop (ignore) user input
    BNE @CountFrame        ; if we are, skip ahead to @CountFrame

    LDA joy_a           ; check to see if the user pressed A or B
    ORA joy_b
    BNE @Exit           ;  if they did, exit.  Otherwise, count the frame

  @CountFrame:
    INC framecounter    ; increment the frame counter
    BNE @Loop           ; if it didn't wrap, continue looping
    DEC story_timer     ;  if it did wrap, decrement story_timer (story_timer decrements once
    BNE @Loop           ;  every 256 frames).  Loop until story_timer expires.  At which point, exit.

  @Exit:
    LDA #0              ; on exit, clear A and B button catchers
    STA joy_a
    STA joy_b
    RTS


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Story - Close Shutters  [$B93F :: 0x3794F]
;;
;;    This routine animates the shutter closing effect done by the story screens.
;;  For the most part, this routine is identical to Story_OpenShutters below, only
;;  with minor changes to do the process in reverse.  See that routine below for
;;  details of what this routine is doing -- comments here will be sparse and will
;;  just highlight the differences.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

Story_CloseShutters:
    LDA #16
    STA shutter_a    ; shutter_a is the number of open scanlines
    LDA #1
    STA shutter_b    ; shutter_b is the number of closed scanline

  @Frame:
    LDA #$00         ; set soft2000 so remainder of previous frame has shutters opened
    STA soft2000

    JSR WaitForVBlank_L
    JSR WaitForShutterStart

    LDA #$07


  @ShutterLoop:
    PHA

    LDX shutter_b       ; wait for number of closed scanlines
   @ClosedLoop:
      JSR Wait100Cycs
      DEX
      BNE @ClosedLoop

    LDA #$00            ; then switch to open NT
    STA $2000

    LDX shutter_a
   @OpenLoop:           ; wait for number of open scanlines
      JSR Wait100Cycs
      DEX
      BNE @OpenLoop

    LDA #$01            ; then switch to closed NT
    STA $2000

    PLA
    SEC
    SBC #1
    BNE @ShutterLoop

  PAGECHECK @ShutterLoop

  ;; here, timing sensitive code is complete

    JSR MusicPlay_L

    INC framecounter
    LDA framecounter
    AND #$01
    BNE @Frame

    INC shutter_b   ; increment number of closed scanlines
    DEC shutter_a   ; decrement number of open scanlines
    BNE @Frame

    LDA #$01        ; once complete, switch to closed NT
    STA $2000       ;  so shutters remain closed.
    STA soft2000

    RTS

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Story - Open Shutters  [$B98D :: 0x3799D]
;;
;;    This routine animates the shutter opening effect done by the story screens.
;;  This is done with screen splitting and timing tricks.  See the big paragraphs
;;  in the routine for further details
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

Story_OpenShutters:
    LDA #16           ; set the counter for the closed shutter portion of the effect.
    STA shutter_a     ;  16 to approximate 16 scanlines of closed shutters

    LDA #1            ; set the counter for the open shutter portion of the effect
    STA shutter_b     ;  1 to approximate 1 scanline of opened shutters
                  ; this may look like it would actually be 17 scanlines (16+1, right?)
                  ;  but because the loops are a little shorter than 1 scanline.. this
                  ;  works out to closer to 16 scanlines (a little less, actually, see notes below)

            ; once counters are prepped -- start doing frames of animation

  @Frame:
    LDA #$01             ; set soft2000 to use the closed NT ($2400 -- the one with closed shutter
    STA soft2000         ;  graphics).  This leaves the shutter closed for the remainder of the previous
                         ;  frame.

    JSR WaitForVBlank_L          ; wait for VBlank
    JSR WaitForShutterStart      ; then wait for the PPU to reach approx. shutter start time

    LDA #$07             ; A is our down counter, that counts how many different shutters
                         ;  we are going to animate.  There are 7 animations performed, but because
                         ; the first two are off the top of the text box, only 5 are visible

  ;;
  ;;  This is the loop which animates the shutters.  This animation is performed by having two
  ;;   NTs which are identical except for the text box:  The $2000 NT has the text and a black BG,
  ;;   so it's the "open" NT.  The $2400 NT has no text and a blue BG, so it's the "closed" BG.
  ;;  The game will split the screen multiple times during the frame to have the PPU switch between
  ;;   these nametables at different scanlines -- thus appearing to make the shutters gradually
  ;;   open, even though no NT or CHR changes are taking place (as complicated as this sounds, it
  ;;   really is the simplest way to do this effect -- the effect itself is quite advanced, even though
  ;;   it may not seem it).
  ;;
  ;;  1 scanline is 113.6667 (341/3) CPU cycles.  This loop will use shutter_a and shutter_b as
  ;;   down counters to approximate the number of scanlines to have the shutters opened (b) and closed
  ;;   (a).  However the loop that uses these down counters is 105 CPU cycles per iteration (less than
  ;;   1 scanline) -- so these are "not quite scanlines".  This results in the entire loop being a
  ;;   little shorter than you'd expect.. and means the timing isn't quite as tight as it could be.
  ;;
  ;;  I have counted the cycles for this loop, and given that shutter_a and shutter_b will always
  ;;   collectively sum 17, @ShutterLoop takes exactly 1814 cycles every iteration
  ;;   (1814*3/341 = 15.95 -- a little less than 16 scanlines).  This means that *eventually*
  ;;   this routine would desync and the shutters would become oblong -- but since there's only 7
  ;;   iterations, and since the scroll isn't REALLY changed until the PPU reloads the temp address
  ;;   (which doesn't occur until the end of the scanline), this timing is "good enough".  It
  ;;   will draw correctly without distortion.
  ;;
  ;;  Having called WaitForShutterStart above, the PPU is now ~8 scanlines into frame rendering.
  ;;   The story box appears at scanline 40, which means there are 32 scanlines until the shutters
  ;;   start becoming visible.  This is why the first two shutters are invisible and why there's
  ;;   7 shutters drawn instead of 5 (since only 5 are visible in the story box).
  ;;
  ;;  Also note that the length of these loops could be changed if the branch crosses a page boundary
  ;;   but that would only make the loops longer (and they're already short) -- so even if that
  ;;   happens, there wouldn't be any visible glitches.  If anything it would help tighten up the
  ;;   timing.
  ;;

  @ShutterLoop:
    PHA              ; push shutter counter to stack to back it up

    LDX shutter_a       ; load number of not-quite-scanlines shutters are to be closed
   @ClosedLoop:         ; and wait that long
      JSR Wait100Cycs
      DEX
      BNE @ClosedLoop   ; (each loop iteration = 105 cycles)

    LDA #$00         ; then switch the PPU over to the "open" NT
    STA $2000

    LDX shutter_b       ; load number of not-quite-scanlines shutters are to be opened
   @OpenLoop:           ; and wait that long
      JSR Wait100Cycs
      DEX
      BNE @OpenLoop

    LDA #$01         ; then close the shutters again by switching
    STA $2000        ;  the PPU over to the "closed" NT

    PLA              ; pull the loop counter from the stack
    SEC
    SBC #1           ; and count it down
    BNE @ShutterLoop ; keep repeating this loop (draw another shutter) until it expires
                     ;  7 iterations -- so 7 shutters are drawn (but only 5 visible)

  PAGECHECK @ShutterLoop   ; assert that loop doesn't cross a page boundary (would mess with timing)

  ;;
  ;; Once code reaches here... timing critical stuff has ended, and PPU changes for the frame
  ;;   are complete
  ;;

    JSR MusicPlay_L    ; keep the music playing

    INC framecounter   ; increment the fame counter
    LDA framecounter   ; and check the low bit
    AND #$01
    BNE @Frame         ; if the low bit is set, repeat the same frame we just did
                       ;  this means the shutters move 1 scanline every other frame

    INC shutter_b      ; increment the number of open scanlines to do
    DEC shutter_a      ; and decrement the number of closed scanline
    BNE @Frame         ; and keep looping until there are no more closed scanlines

  ;; once the number of closed scanlines reaches zero... shutter animation is complete,
  ;;  and shutters are fully opened.

    LDA #0             ; set the PPU to use the "open" NT
    STA $2000
    STA soft2000

    RTS                ; and exit!

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Wait 100 Cycles [$B9DB :: 0x379EB]
;;
;;    JSRing to this routine will burn exactly 100 CPU cycles.  This total
;;  includes the JSR.  This is used as a timing mechanism for the shutter effects
;;  in the Story screens.
;;
;;    It is important that this routine does not modify X!  It also does not modify
;;  A, but that isn't relied upon.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

Wait100Cycs:
    LDY #17        ; +2 cycles
  @Loop:
      DEY            ; +2 cycles
      BNE @Loop      ; +3 cycles (5 cycle loop * 17 iterations = 85 - 1 = 84 cycles for loop)

  CRITPAGECHECK @Loop

    NOP            ; +2 cycles
    RTS            ; +6 cycles
                   ; = 2+84+2+6 = 94 cycles for this routine + 6 for the JSR = 100 cycles even

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Wait For Shutter Start [$B9E2 :: 0x379F2]
;;
;;    JSRing to this routine burns 3173 cycles.  If called after waiting for VBlank,
;;  this puts the CPU roughly 3209 cycles into the frame (*3/341 = ~28 scanlines from VBl start
;;  which is about ~8 scanlines into frame rendering).  Note that this is really probably closer
;;  to 7 scanlines into rendering... but since the PPU changes made by surrounding routines don't
;;  take effect until "HBlank" (end of scanline), write effectively get "pushed back" to the
;;  end of the scanline... so you basically "round up" when calculating the scanline.
;;
;;    The actual story box (where shutter effect is to apply) starts on scanline 40 -- which
;;  means from the time this routine ends, it will be approximately 32 scanlines until the
;;  story box is rendered.  Since the shutter effect is applied in groups of 16 scanlines,
;;  32 is a fine number to start with because it's a multiple of 16.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

WaitForShutterStart:
    LDA #0         ; +2
    STA $2005      ; +4    reset scroll
    STA $2005      ; +4

    LDX #30        ; +2
  @Loop:
      JSR Wait100Cycs   ; +100
      DEX               ; +2
      BNE @Loop         ; +3  (105 cycle loop * 30 iterations = 3150 - 1 = 3149 cycles for loop)

  PAGECHECK @Loop

    RTS            ; +6
                   ; = 2+4+4+2+3149+6 = 3167 cycles for this routine + 6 for the JSR = 3173 cycles

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Bridge Scene - Load Palette  [$B9F3 :: 0x37A03]
;;
;;    Loads the BG palette for the bridge scene
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

Bridge_LoadPalette:
    LDX #$0F                  ; X is loop counter and index
  @Loop:
      LDA lut_BridgeBGPal, X  ; copy palette entry from lut
      STA cur_pal, X          ; to palette
      DEX
      BPL @Loop               ; and loop until X wraps ($10 iterations -- full BG palette)

    RTS          ; then exit



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Ending Scene - Load Palette  [$B9FF :: 0x37A0F]
;;
;;    Loads the BG palette for the ending scene
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

Ending_LoadPalette:
    LDX #$0F                  ; X is loop counter and index
  @Loop:
      LDA lut_EndingBGPal, X  ; copy palette entry from lut
      STA cur_pal, X          ; to palette
      DEX
      BPL @Loop               ;and loop until X wraps ($10 iterations -- full BG palette)

    RTS           ; then exit

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Story - Draw Text  [$BA0B :: 0x37A1B]
;;
;;    Loads and draws the text for the story screens (Bridge/Ending scenes).
;;
;;  IN:  story_credits, story_page
;;
;;    Credits and Story text are stored seperately, and are in totally different
;;  formats.  As such this routine has to split itself in two depending on which
;;  type of text is being drawn.
;;
;;    Story text is a normal Complex String (see DrawComplexString for nitty-gritty
;;  details) drawn inside the story box.
;;
;;    Credits text is different.  Rather than being a complex string, it's a series of 
;;  simple strings -- each of which has no support for DTE, or even simple control codes
;;  like line breaks!
;;
;;    Each such simple string is prefixed with a 2-byte address which specifies the
;;  PPU address that this string is to be drawn.  The string then continues until a
;;  $00 or $01 termination byte is found.
;;
;;    The $00 null terminator marks the end of the page (ie:  the end of this series of
;;  strings).  The $01 terminator marks the end of the individual string, but another
;;  string immediately follows it (the new string is prefixed by a new PPU address)
;;
;;    For an Example:
;;
;;  80 21 ...(string data to be drawn at $2180)... 01 A0 21 ... (data to be drawn
;;     at $21A0) ... 00    (end of page)
;;
;;
;;    The NASIR CRC:
;;  ?As an anitpiracy measure?, a checksum is in place which limits changes you can make
;;  to the credits part of the bridge scene.  It performs the checksum on the first few bytes
;;  of lut_CreditsText, however it does not use the lut_CreditsText address directly (presumably
;;  as an additional obfuscation measure to make the routine harder to crack?)  What it does
;;  instead is, it reads the high byte of the address from the middle of this routine, and
;;  uses that as the high byte for a pointer from which it reads the credits data.
;;    The @NasirCRCHighByte and __Nasir_CRC_High_Byte symbols in this routine are simply used
;;  as markers so that other routine can get the appropriate byte.
;;    See AssertNasirCRC in the fixed bank for further details.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

Story_DrawText:
    LDA story_credits    ; are we drawing credits?  or story text?
    BNE @DoCredits       ;  if credits... do them
      JMP @DoStory       ;  otherwise, do story

  @DoCredits:
    LDA story_page       ; get current page number
    ASL A                ; double it (2 bytes per pointer)
    TAX                  ; and throw in X for indexing

        @NasirCRCHighByte:       ; label unimportant to this routine -- has to do with CRC check -- see above
    LDA lut_CreditsText, X     ; load up the pointer to credits text
    STA text_ptr
    LDA lut_CreditsText+1, X
    STA text_ptr+1

  @StartSimpleString:
    JSR Story_EndFrame   ; end the frame (keeps music playing, and ensures we're in VBlank)
    LDA $2002            ; reset PPU toggle

    LDY #1               ; Y=1 because we're to load the high byte of the address first
    LDA (text_ptr), Y
    STA $2006            ; set high byte of PPU address
    DEY                  ; then load and set low byte
    LDA (text_ptr), Y    ;  This is funky because the address is stored low-byte first, but
    STA $2006            ;  $2006 must be written to high-byte first.

    LDA text_ptr         ; add 2 to our text pointer
    CLC
    ADC #2
    STA text_ptr
    LDA text_ptr+1       ;  catch carry
    ADC #0
    STA text_ptr+1

  @SimpleStringLoop:
    LDY #0               ; zero Y, our index (pointless here, Y is already zero)
    LDA (text_ptr), Y    ; fetch next byte in string
    BEQ @EndCreditsPage  ; if zero (null terminator), this page is complete

    INC text_ptr         ;  otherwise, increment our pointer to look at next byte in string
    BNE :+
      INC text_ptr+1     ;  inc high byte of pointer if low byte wrapped

:   CMP #$01
    BEQ @StartSimpleString   ; if this byte was $01, start a new simple string

    STA $2007              ; otherwise (normal byte), draw it
    JMP @SimpleStringLoop  ; and continue looping

  @EndCreditsPage:
    LDA #0
    STA $2005            ; reset scroll (but not NT scroll -- screen still scrolled to $2400)
    STA $2005
    RTS                  ; and exit

 ;;
 ;; called for story text (ie:  not credits)
 ;;

@DoStory:
    LDA story_page          ; get the current page of story we're to display
    ASL A                   ; double it (2 bytes per pointer)
    TAX                     ; and throw it in X

    LDA lut_StoryText, X    ; load up the pointer to this page of story text
    STA text_ptr
    LDA lut_StoryText+1, X
    STA text_ptr+1

    JMP DrawComplexString_L ; and draw it at a complex string.  Then exit


;__Nasir_CRC_High_Byte = @NasirCRCHighByte+2   ; unimportant to this routine -- has to do with CRC check
                                              ;  see above description
                                              
;; JIGS - nah

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Story - End Frame  [$BA70 :: 0x37A80]
;;
;;    This routine is used to end a frame by some of the story code (Bridge/Ending scenes)
;;  It simply resets the scroll, calls MusicPlay, then waits for another VBlank to happen.
;;  This assures the frame will be rendered properly, music will play correctly, and
;;  code will resume from this routine when VBlank has started (so further drawing can be done)
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

Story_EndFrame:
    LDA #0
    STA $2005             ; reset scroll
    STA $2005

    JSR MusicPlay_L       ; play the music
    JSR WaitForVBlank_L   ; and wait for VBlank
    RTS                   ; then exit

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Story Secondary Attribute Table  [$BA7F :: 0x37A8F]
;;
;;    This is the top half of the attribute table for the secondary nametable ($2400)
;;  for the story screens (Bridge and Ending scenes).  All of it is the same as
;;  the normal attribute table ($2000) except for the box to contain the story, which uses
;;  palette set 0 instead of set 3.  This makes the empty box have a black body
;;  on the primary NT, and a blue body on the secondary NT.


lut_StorySecondaryAttrib:
  .BYTE $55,$55,$55,$55,$55,$55,$55,$55
  .BYTE $55,$00,$00,$00,$00,$44,$55,$55
  .BYTE $55,$00,$00,$00,$00,$44,$55,$55
  .BYTE $55,$00,$00,$00,$00,$44,$55,$55


 ; unused
  .BYTE 0

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  MiniGame - Slide Horizontally  [$BAA0 :: 0x37AB0]
;;
;;     Slides the puzzle pieces horizontally in the puzzle -- updating the puzzle and
;;  animating the onscreen sprites so they appear to gradually slide into their new position.
;;
;;     This routine is pretty much identical to MiniGame_VertSlide.  See that routine for details
;;  and more in-depth comments (repeating all the comments here would've been silly -- for the most
;;  part the routines are the same)
;;
;;  IN:  tmp   = position of cursor
;;       tmp+1 = position of empty slot
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


MiniGame_HorzSlide:
    LDA tmp          ; if cursor < empty slot
    CMP tmp+1
    BCC @Left        ; then sliding left.  Otherwise... sliding right.

  @Right:
    SBC tmp+1        ; cursor - empty slot
    STA tmp+2        ; = number of columns that need to be moved right

    LDX tmp+1            ; start at empty slot
  @Right_SlideLoop:
      LDA puzzle+1, X    ; move each puzzle piece right 1 slot
      STA puzzle, X
      INX
      CPX tmp            ; until we get to the cursor
      BCC @Right_SlideLoop
    LDA #0
    STA puzzle, X        ; make the cursor the empty slot

    LDA #1
    STA mg_slidedir      ; set slide direction to 1 (right)

    LDA tmp
    LDX tmp+2
  @Right_SpriteLoop:
      STA mg_slidespr-1, X    ; fill the slidespr list with the slots that need to be animated
      SEC
      SBC #1
      DEX
      BNE @Right_SpriteLoop

    JMP MiniGame_AnimateSlide   ; then animate them -- and exit


  @Left:
    LDA tmp+1      ; empty slot - cursor
    SEC
    SBC tmp
    STA tmp+2      ; = number of columns that need to be moved left

    LDX tmp+1
  @Left_SlideLoop:
      LDA puzzle-1, X     ; move all the necessary puzzle pieces left
      STA puzzle, X
      DEX
      CPX tmp
      BNE @Left_SlideLoop
    LDA #0
    STA puzzle, X         ; replace cursor's slot the empty slot

    STA mg_slidedir       ; set direction to zero (left)

    LDA tmp
    LDX tmp+2
  @Left_SpriteLoop:
      STA mg_slidespr-1, X    ; fill the slidespr list with the slots that need to be animated
      CLC
      ADC #1
      DEX
      BNE @Left_SpriteLoop

    JMP MiniGame_AnimateSlide  ; then animate them, and exit




 ;; unknown / unused

  .BYTE $09,$03,$02,$05,$0F,$3C,$F3

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Credits Text   [$BB00 :: 0x37B10]
;;
;;    Pointer table followed by text data for the credits text.  Credits
;;  text is displayed in the second half of the Bridge Scene.  It does not
;;  follow the same format as other bridge scene text (Story Text).  See
;;  Story_DrawText for a description of the format

;  .ALIGN  $100
lut_CreditsText:
;  .INCBIN "bin/0D_BB00_credittext.bin"
;; JIGS - unpacked and labeled for editing


.word CREDITSLIDE1
.word CREDITSLIDE2
.word CREDITSLIDE3
.word CREDITSLIDE4

CREDITSLIDE1:
.byte $E8,$20,$2F,$31,$2E,$26,$31,$20,$2C,$2C,$24,$23,$01,$2C,$21,$21,$38,$01,$88,$21,$2D,$FF,$20,$FF,$32,$FF,$28,$FF,$31,$00

CREDITSLIDE2:
.byte $E8,$20,$22,$27,$20,$31,$20,$22,$33,$24,$31,$01,$29,$21,$23,$24,$32,$28,$26,$2D,$01,$86,$21,$38,$2E,$32,$28,$33,$20,$2A,$20,$FF,$20,$2C,$20,$2D,$2E,$00

CREDITSLIDE3:
.byte $E9,$20,$32,$22,$24,$2D,$20,$31,$28,$2E,$01,$2C,$21,$21,$38,$01,$87,$21,$2A,$24,$2D,$29,$28,$FF,$33,$24,$31,$20,$23,$20,$00

CREDITSLIDE4:
.byte $E8,$20,$2F,$31,$2E,$23,$34,$22,$33,$28,$2E,$2D,$01,$2C,$21,$2E,$25,$01,$86,$21,$32,$30,$34,$20,$31,$24,$FF,$FF,$20,$C2,$33,$24,$20,$2C,$00



 ; $BB8E -- unknown/unused?  very, very strange.  More space for credit text?
 ; .INCBIN "bin/0D_BB8E_unknown.bin"
 ;; JIGS - I've yet to run into a problem from disabling this...
 ;; HOWEVER, I have also yet to complete the game while working on it. So maybe it messes up the ending.

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Draw All Puzzle Pieces  [$BE00 :: 0x37E10]
;;
;;     Draws all puzzle pieces for the minigame to OAM.  Does
;;  not handle the animation that occurs when a puzzle piece is being moved.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

DrawAllPuzzlePieces:
    JSR ClearOAM_BankD     ; clear OAM

    LDA #$48         ; set sprite coords to $48, $2F
    STA spr_x        ;  this is where we start drawing the puzzle pieces
    LDA #$2F
    STA spr_y

    LDA #0           ; A will be the overall loop counter and puzzle piece to draw.  Start at zero.

  @Loop:
    PHA                 ; push loop counter to stack to back it up

    JSR DrawPuzzlePiece ; draw this puzzle piece

    LDA spr_x           ; add $10 to the X coord (next puzzle piece)
    CLC
    ADC #$10
    STA spr_x

    CMP #($40 + $48) ; once we do 4 puzzle pieces in this row...
    BCC @Continue
      LDA #$48       ;  ... reset the X coord to first column
      STA spr_x
      LDA spr_y      ;  ... and add $10 to Y coord to move to next row
      CLC
      ADC #$10
      STA spr_y

  @Continue:
    PLA              ; pull the loop counter from the stack
    CLC
    ADC #1           ; increment it by 1
    CMP #$10         ; and keep looping until we do all $10 tiles
    BCC @Loop

    RTS              ; then exit


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Draw Puzzle Piece  [$BE30 :: 0x37E40]
;;
;;    Draws the puzzle piece that is currently in the given slot
;;
;;  IN:  A = slot ID containing puzzle piece to draw
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


DrawPuzzlePiece:
    STA tmp+9        ; put slot index to draw in tmp+9 (will use later)
    TAX
    LDA puzzle, X    ; get the puzzle piece currently at this slot
    BNE @Draw        ;  if it's nonzero (slot isn't empty), draw it.  But don't draw an empty slot


  @Done:
    LDA sprindex     ; after done drawing (or if drawing was skipped due to slot being empty)
    CLC              ;  increment the sprindex by 4 sprites (4 bytes per sprite)
    ADC #4*4
    STA sprindex
    RTS              ; then exit


  @Draw:
    ASL A                 ; multiply puzzle piece by 4 to get the desired graphic for this piece
    ASL A
    STA tmp+8             ; store that tile ID in tmp+8 (will use later)

    LDX sprindex          ; put sprite index in X for indexing

    LDA spr_y             ; get the desired Y coord
    STA oam_y, X          ; set the top two sprites to use it
    STA oam_y+(1*4), X
    CLC
    ADC #8
    STA oam_y+(2*4), X    ; but add 8 to it for the bottom two sprites
    STA oam_y+(3*4), X

    LDA spr_x             ; then get X coord
    STA oam_x, X          ; left sprites get it unaltered
    STA oam_x+(2*4), X
    CLC
    ADC #8
    STA oam_x+(1*4), X    ; but 8 is added for the right side sprites
    STA oam_x+(3*4), X

    LDA tmp+8             ; get desired tile graphic (previously written to tmp+8)
    STA oam_t, X          ; set each of the 4 sprites' graphics
    CLC
    ADC #1
    STA oam_t+(1*4), X    ; but increment the tile ID by 1 each time
    CLC
    ADC #1
    STA oam_t+(2*4), X
    CLC
    ADC #1
    STA oam_t+(3*4), X

    LDA #0                ; sprite attributes = 0  (palettes 0, no flipping, foreground priority)

    LDY cursor            ; get the cursor
    CPY tmp+9             ;  and see if it matches our selected slot (previously written to tmp+9)

    BNE @DrawAttrib       ; if it does match...

      LDA framecounter    ; ... use bit 1 of the framecounter to hide the sprite.  Using bit 1 toggles
      AND #$02            ;   sprite visibility every other frame (2 frames visible, 2 frames invisible)
      ASL A               ; shift bit 1 into bit 5 (sprite priority bit).  This gives the sprite background
      ASL A               ; priority, hiding it behind the background when this bit is set (effectively
      ASL A               ; making the sprite invisible)
      ASL A

  @DrawAttrib:
    STA oam_a, X          ; copy the desired attribute byte to each sprite
    STA oam_a+(1*4), X
    STA oam_a+(2*4), X
    STA oam_a+(3*4), X

    JMP @Done             ; and JMP to the exit


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  MiniGame - Animate Slide [$BE9E :: 0x37EAE]
;;
;;    This routine performs the animation when sliding puzzle pieces around
;;  in the minigame.  Each tile being moved is slid 1 pixel in the direction they're being
;;  moved each frame.  It takes 16 frames for the tiles to slide into their new position.
;;
;;    This routine also updates the cursor so that it is set to the slot that was
;;  previously empty
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

MiniGame_AnimateSlide:
    LDA tmp+1              ; the old empty slot becomes the new cursor
    STA cursor             ;  since the old cursor will become the new empty slot -- and
                           ;  we never want the empty slot and cursor to be on the same tile

    LDA #0                 ; A will be a makeshift loop counter.  We will loop 16 times, moving
                           ;  the puzzle pieces 1 pixel each iteration.
  @AnimateLoop:
    PHA                    ; back up loop counter
    JSR WaitForVBlank_L    ; wait for VBlank
    LDA #>oam              ; do sprite DMA
    STA $4014
    JSR MusicPlay_L        ; and play the music

    LDA mg_slidespr        ; then slide the sprites of each tile being moved 1 pixel
    JSR @SlideTile         ;   in the desired direction
    LDA mg_slidespr+1
    JSR @SlideTile
    LDA mg_slidespr+2
    JSR @SlideTile

    PLA                    ; get loop counter (previously pushed)
    CLC
    ADC #1                 ; increment it by 1
    CMP #$10               ; and keep looping until we reach $10 ($10 iterations)
    BCC @AnimateLoop

    JMP MiniGameLoop       ; once finished -- return to the minigame loop

  ;;
  ;;  This local subroutine moves the tile in the given slot (in A) 1 pixel in the desired direction
  ;;    If the desired slot ID is negative ($80), it indicates that there is no slot to be moved.  Since
  ;;    it is possible to move 3 tiles at a time in the puzzle... 3 slots must be checked for every time,
  ;;    but less than 3 will need to be moved when the player only moves 1 or 2 tiles on the puzzle.
  ;;


  @SlideTile:
    BPL :+              ; if the selected sprite is a negative number, it indicates that
      RTS               ;  there is no sprite we need to move here.  So just exit

:   ASL A               ; otherwise, multiply the slot ID by 16 (4 bytes per sprite * 4 sprites
    ASL A               ;  per tile)
    ASL A
    ASL A
    TAX                 ;  and put in X for indexing OAM

    LDY mg_slidedir            ; get the direction we're going to move in Y
    LDA lut_MGDirection_Y, Y   ;  use that to get the Y and X offsets
    STA tmp                    ; 'tmp' will be added to sprite's Y coord
    LDA lut_MGDirection_X, Y
    STA tmp+1                  ; 'tmp+1' will be added to sprite's X coord

    LDY #4              ; Y is our loop counter (4 iterations -- one for each sprite making up this tile)
  @SlideLoop:
    LDA oam_y, X        ; add 'tmp' to sprite's Y coord
    CLC
    ADC tmp
    STA oam_y, X

    LDA oam_x, X        ; and tmp+1 to sprite's X coord
    CLC
    ADC tmp+1
    STA oam_x, X

    TXA                 ; add 4 to our sprite index (look at next sprite)
    CLC
    ADC #4
    TAX

    DEY                 ; decrement our loop counter
    BNE @SlideLoop      ; and repeat until it expires (4 iterations)

    RTS                 ; then exit


 ;; unused
 .BYTE 0,0,0,0,0


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Bridge Scene palette [$BF00 :: 0x37F10]

lut_BridgeBGPal:
  .BYTE $0F,$00,$02,$30,  $0F,$3B,$11,$24,  $0F,$3B,$0B,$2B,  $0F,$00,$0F,$30


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Ending Scene (epilogue) palette  [$BF10 :: 0x37F20]

lut_EndingBGPal:
  .BYTE $0F,$00,$01,$30,  $0F,$32,$21,$30,  $0F,$2C,$2A,$1A,  $0F,$00,$0F,$30


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Intro Story Text  [$BF20 :: 0x37F30]
;;
;;    Processed as a Complex String.  Output during the intro story
;;  (first screen visible when starting the game)

;lut_IntroStoryText:
  ;.INCBIN "bin/0D_BF20_introtext.bin"
  
  ;; JIGS - moved to Bank 10
