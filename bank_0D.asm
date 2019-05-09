
.export MusicPlay_L
.export BackupMapMusic
.export RestoreMapMusic

.import lut_TilesetMusicTrack
.import lut_VehicleMusic
.import MultiplyXA
.import WaitForVBlank_L

.include "variables.inc"
.include "Constants.inc"


BANK_THIS = $0D

.segment "BANK_0D"



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

;; $41
.WORD PRELUDE_SQ1
.WORD PRELUDE_SQ2
;.WORD PRELUDE_TRI 
.WORD BLANK ;; JIGS < Prelude doesn't use the triangle, but it does now have a melody!
.WORD PRELUDE_SQ3
.WORD PRELUDE_SQ4

;; $42
.WORD PROLOGUE_SQ1
.WORD BLANK
.WORD PROLOGUE_TRI
.WORD PROLOGUE_SQ3
.WORD PROLOGUE_SQ2

;; $43
.WORD EPILOGUE_SQ1
.WORD BLANK
.WORD EPILOGUE_TRI
.WORD EPILOGUE_SQ3
.WORD EPILOGUE_SQ2

;; $44
.WORD OVERWORLD_SQ1
.WORD BLANK
.WORD OVERWORLD_TRI
.WORD OVERWORLD_SQ3
.WORD OVERWORLD_SQ2

;; $45
.WORD SHIP_SQ1
.WORD BLANK
.WORD SHIP_TRI
.WORD SHIP_SQ3
.WORD SHIP_SQ2

;; $46
.WORD AIRSHIP_SQ1
.WORD BLANK
.WORD AIRSHIP_TRI
.WORD AIRSHIP_SQ3
.WORD AIRSHIP_SQ2

;; $47
.WORD TOWN_SQ1
.WORD BLANK
.WORD TOWN_TRI
.WORD TOWN_SQ2
.WORD TOWN_SQ3

;; $48
.WORD CASTLE_SQ1
.WORD BLANK
.WORD CASTLE_TRI
.WORD CASTLE_SQ3
.WORD CASTLE_SQ2

;; $49
.WORD EARTHCAVE_SQ1
.WORD BLANK
.WORD EARTHCAVE_TRI
.WORD EARTHCAVE_SQ3
.WORD EARTHCAVE_SQ2

;; $4A
.WORD MATOYA_SQ1
.WORD BLANK
.WORD MATOYA_TRI
.WORD MATOYA_SQ3
.WORD MATOYA_SQ2

;; $4B
.WORD MARSHCAVE_SQ1
.WORD MARSHCAVE_SQ4
.WORD MARSHCAVE_TRI
.WORD MARSHCAVE_SQ2
.WORD MARSHCAVE_SQ3

;; $4C
.WORD SEASHRINE_SQ1
.WORD BLANK
.WORD SEASHRINE_TRI
.WORD SEASHRINE_SQ3
.WORD SEASHRINE_SQ2

;; $4D
.WORD SKYCASTLE_SQ1
.WORD SKYCASTLE_SQ4
.WORD SKYCASTLE_TRI
.WORD SKYCASTLE_SQ3
.WORD SKYCASTLE_SQ2

;; $4E
.WORD FIENDTEMPLE_SQ1
.WORD BLANK
.WORD FIENDTEMPLE_TRI
.WORD FIENDTEMPLE_SQ3
.WORD FIENDTEMPLE_SQ2

;; $4F
.WORD SHOP_SQ1
.WORD BLANK
.WORD SHOP_TRI
.WORD SHOP_SQ3
.WORD SHOP_SQ2

;; $50
.WORD BATTLE_SQ1
.WORD BLANK
;.WORD BATTLE_SQ2 ;; JIGS - Now played by the MMC5 audio so that SFX don't interrupt it.
.WORD BATTLE_TRI
.WORD BATTLE_SQ2
.WORD BATTLE_SQ3

;; $51
.WORD MENU_SQ1
.WORD BLANK
.WORD MENU_TRI
.WORD MENU_SQ3
.WORD MENU_SQ2
;; JIGS - the code that plays this has been disabled in menus
;; JIGS - BUT it has been moved to the map screen! And is used in inns!

;; $52
.WORD SLAIN_SQ1
.WORD SLAIN_SQ4
.WORD SLAIN_TRI
.WORD SLAIN_SQ3
.WORD SLAIN_SQ2

;; $53
.WORD BATTLEWIN_SQ1
.WORD BLANK
.WORD BATTLEWIN_TRI
.WORD BATTLEWIN_SQ3
.WORD BATTLEWIN_SQ2

;; $54
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

;; $55
.WORD MARSHCAVEOLD_SQ1
.WORD BLANK
.WORD MARSHCAVEOLD_TRI
.WORD MARSHCAVEOLD_SQ3
.WORD MARSHCAVEOLD_SQ2

;; JIGS - a copy of the prelude for some reason? 
;; Rename these and you have a new song if you have the space for it.

;; $56
.WORD FANFARE_SQ1
.WORD BLANK
.WORD FANFARE_TRI
.WORD BLANK
.WORD FANFARE_SQ2

;; $57
.WORD HEAL_SQ1
.WORD BLANK
.WORD HEAL_TRI
.WORD BLANK
.WORD HEAL_SQ2
;; JIGS - the code that plays this has been disabled

;; $58
.WORD TREASURE_SQ1
.WORD BLANK
.WORD TREASURE_TRI
.WORD BLANK
.WORD TREASURE_SQ2
;; JIGS - the code that plays this has been disabled

;; $59
.WORD BOSS_SQ1
.WORD BOSS_SQ2
.WORD BOSS_TRI
.WORD BOSS_SQ3
.WORD BOSS_SQ4

;; $5A
.WORD MARSHBOSS_SQ1
.WORD BLANK
.WORD MARSHBOSS_TRI
.WORD MARSHBOSS_SQ3
.WORD MARSHBOSS_SQ2




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
   .byte $F6, $FB, $C4, $D0
   .word PROLOGUE_SQ1
   
PROLOGUE_SQ4:   
   .byte $F6, $FB, $C5, $D0
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
   .byte $F6, $FC, $C4, $D0
   .word EPILOGUE_SQ1
   
EPILOGUE_SQ4:   
   .byte $F6, $FC, $C5, $D0
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
   .byte $F6, $FB, $C5, $D0
   .word OVERWORLD_SQ1
   
OVERWORLD_SQ4:   
   .byte $F6, $FB, $C5, $D0
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
   .byte $F6, $FB, $C4, $D0
   .word SHIP_SQ1
   
SHIP_SQ4:   
   .byte $F6, $FB, $C5, $D0
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
   .byte $F6, $FC, $C5, $D0
   .word AIRSHIP_SQ1
   
AIRSHIP_SQ4:   
   .byte $F6, $FC, $C5, $D0
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
   .byte $F6, $FC, $C4, $D0
   .word TOWN_SQ1
   
TOWN_SQ4:   
   .byte $F6, $FC, $C5, $D0
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
   .byte $F6, $FD, $C4, $D0
   .word CASTLE_SQ1
   
CASTLE_SQ4:   
   .byte $F6, $FD, $C5, $D0
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
   .byte $F6, $FB, $C4, $D0
   .word EARTHCAVE_SQ1
   
EARTHCAVE_SQ4:   
   .byte $F6, $FB, $C5, $D0
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
   .byte $F6, $FB, $C4, $D0
   .word MATOYA_SQ1
   
MATOYA_SQ4:   
   .byte $F6, $FB, $C5, $D0
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
   .byte $F4, $F6, $FE, $C5, $D0
   .word MARSHCAVE_SQ1

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
   .byte $F6, $FB, $C5, $D0
   .word MARSHCAVEOLD_SQ1
   
MARSHCAVEOLD_SQ4:   
   .byte $F6, $FB, $C5, $D0
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
   .byte $F6, $FB, $C4, $D0
   .word SEASHRINE_SQ1
   
SEASHRINE_SQ4:   
   .byte $F6, $FB, $C5, $D0
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
   
SKYCASTLE_SQ3:   
   .byte $F6, $FD, $C4, $D0
   .word SKYCASTLE_SQ1
   
SKYCASTLE_SQ4:   
   .byte $F6, $FD, $C4, $D0
   .word SKYCASTLE_SQ2
   
   
   



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
   
FIENDTEMPLE_SQ3:   
   .byte $F6, $FB, $C4, $D0
   .word FIENDTEMPLE_SQ1
   
FIENDTEMPLE_SQ4:   
   .byte $F6, $FB, $C5, $D0
   .word FIENDTEMPLE_SQ2   


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
   
SHOP_SQ3:   
   .byte $F6, $FD, $C5, $D0
   .word SHOP_SQ1
   
SHOP_SQ4:   
   .byte $F6, $FD, $C5, $D0
   .word SHOP_SQ2



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
   .byte $F6, $FB, $C5, $D0
   .word BATTLE_SQ1
   
BATTLE_SQ4:   
   .byte $F6, $FB, $C5, $D0
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
   .byte $F6, $FC, $C4, $D0
   .word MENU_SQ1
   
MENU_SQ4:   
   .byte $F6, $FC, $C5, $D0
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
   .byte $F6, $FC, $C4, $D0
   .word SLAIN_SQ1
   
SLAIN_SQ4:   
   .byte $F6, $FC, $C5, $D0
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
   .byte $F6, $FB, $C5, $D0
   .word BATTLEWIN_SQ1
   
BATTLEWIN_SQ4:   
   .byte $F6, $FB, $C5, $D0
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

;BLANK2: ; For songs that need to end. (note that using this will cause a song to end prematurely once it hits the FF. So... useless. Oops.)
;.BYTE $F9,$CA,$FF

MARSHBOSS_SQ1:
    .BYTE $F5,$02     ;duty set 25%
    .byte $FB         ;tempo FB
    .byte $F8,$08,$E1 ;envelope speed $08, pattern 1, gradual decay from C
    .byte $D8,$3C,$6C,$9C,$D9,$0C,$3C,$6C,$9C,$DA,$0C,$3C,$6C,$9C,$DB,$0C
    .byte $C0,$C3     ; long rest; two bars
    .byte $D0
    .WORD MARSHCAVEOLD_SQ1

MARSHBOSS_SQ2:
   .BYTE $F5,$01     ; duty set 12.5%
   .byte $FB         ; tempo FB
   .byte $F8,$08,$E2 ; envelope speed $08, pattern 2, gradual decay from 8
   .byte $CE         ; evil confusing rest that messes it all up for a tiny echo effect
   .byte $D8,$3C,$6C,$9C,$0C,$3C,$6C,$9C,$D9,$0C,$3C,$6C,$9C,$DA,$0C
   ;; $_E ^ of a pause, so this one is 14 thingies off instead of 12
   .byte $C0,$C4,$CC ; long rest, $B8 in length...
   .byte $D0
   .WORD MARSHCAVEOLD_SQ2

MARSHBOSS_TRI:
   .byte $FB,$C3
   @MARSHBOSS_TRILOOP:
   ;.byte $D9,$07,$C5,$07,$C5,$C5,$07,$C7,$07,$C7,$07,$C7,$57,$C5,$57,$C5,$57,$C5
   ;.byte $57,$C5,$57,$C7
   .byte $D9,$09,$C9,$09,$C9,$09,$C9,$09,$C9,$09,$C9,$09,$C9,$D8,$A9,$C9,$A9,$C9
   .byte $D1
   .WORD @MARSHBOSS_TRILOOP
   .byte $D0
   .WORD MARSHCAVEOLD_TRI

MARSHBOSS_SQ3:
   .byte $F6, $FB, $C5, $D0
   .word MARSHBOSS_SQ1

MARSHBOSS_SQ4:


BOSS_SQ1:
    .BYTE $F5,$02     ;duty set 25%
    .byte $FB         ;tempo FB
    .byte $F8,$08,$E1 ;envelope speed $08, pattern 1, gradual decay from C
    .byte $D8,$3C,$6C,$9C,$D9,$0C,$3C,$6C,$9C,$DA,$0C,$3C,$6C,$9C,$DB,$0C
    .byte $C0,$C5     ; long rest; one and a half bars + a quarter note
    .BYTE $F5,$03     ;duty set 50%
    ;.byte $D9,$2A,$5A,$8A,$AA
 
  BOSS_SQ1START:
    .byte $D9,$0A,$2A,$3A,$5A,$7A,$8A,$AA,$BA
    .byte $F8,$0C ; envelope speed $0C
    .byte $EC     ;  decay from F with tremolo
    ;; Temple of Fiends bit
    .byte $DA,$03,$D9,$75,$DA,$75
    .byte $55,$35,$26,$3A,$2A,$05
    .byte $34,$2C,$3C,$2C,$00
    ;;EMPTY BAR
    .byte $03,$D9,$75,$DA,$76,$8A,$9A
    .byte $A5,$87,$8C,$AC,$8C,$75,$55
    .byte $70
    .byte $35,$55
    .byte $63,$D9,$A5,$DA,$35
    .byte $25,$05,$25,$35
    .byte $03,$D9,$73
    .byte $A2,$75
    .byte $85,$DA,$05,$55,$35
    .byte $D9,$B3,$DA,$15,$35
    .byte $31
    .byte $F8,$0B ; envelope speed $0B
    .byte $21
    ;;Sky Temple bit
    .byte $F4     ; half volume
    .byte $25,$29,$39,$29,$09,$20
    ;;EMPTY BAR
    .byte $D9,$75,$79,$89,$79,$59,$70
    ;;EMPTY BAR
    .byte $25,$29,$39,$29,$09,$20
    ;;EMPTY,$BAR
    .byte $05,$09,$29,$09,$D8,$A9,$D9,$03
    ;;Transition to Sea Shrine bit:
    .byte $F8,$09 ; envelope speed $09
    .byte $05     ; volume is at 8
    .byte $F4     ; un-half volume
    .byte $ED     ; decay from C with tremolo
    .byte $05
    .byte $EC     ; decay from F with tremolo
    .byte $05
    .byte $25
    ;;Sea Shrine bit
    .byte $F8,$0C ; envelope speed $0C
    .byte $33,$05,$35
    .byte $25,$05,$D8,$A5,$D9,$25
    .byte $00
    .byte $C3
    .byte $33,$55,$35
    .byte $25,$05,$D8,$A5,$D9,$85
    .byte $72,$89,$79,$57
    .byte $71
    .byte $23,$35,$55
    .byte $35,$25,$05,$75
    .byte $53,$75,$85
    .byte $73,$33
    .byte $03,$75,$55
    .byte $35,$25,$05,$35
  ;  .byte $F8,$0B ; envelope speed $0B
    .byte $21
    .byte $EF ; fade in then out with tremolo
    .byte $21
    ;; wrap up / Sky Castle thing reprise
    .byte $C5
    .byte $EC     ;  decay from F with tremolo
    .byte $29,$39,$29,$09,$21
    .byte $C5
    .byte $D0
    .WORD BOSS_SQ1START
    

   
BOSS_SQ2:
   .BYTE $F5,$01     ; duty set 12.5%
   .byte $FB         ; tempo FB
   .byte $F8,$08,$E2 ; envelope speed $08, pattern 2, gradual decay from 8
   .byte $CE         ; evil confusing rest that messes it all up for a tiny echo effect
   .byte $D8,$3C,$6C,$9C,$0C,$3C,$6C,$9C,$D9,$0C,$3C,$6C,$9C,$DA,$0C
   ;; $_E ^ of a pause, so this one is 14 thingies off instead of 12
   .byte $C0,$C4,$CC ; long rest, $B8 in length...

   
   BOSS_SQ2START:
   .byte $D9,$79,$39,$09,$39,$29,$39,$79,$39,$09,$D8,$79,$39,$79,$A9,$79,$A9,$79
   .byte $D9,$59,$29,$D8,$A9,$D9,$29,$09,$29,$59,$29,$D8,$A9,$59,$29,$59,$89,$59,$29,$59
   .byte $39,$89,$D9,$09,$39,$D8,$A9,$D9,$39,$09,$39,$89,$39,$09,$39,$79,$39,$09,$F0
   .WORD BOSS_SQSTART_FIENDTEMPLEPART1_ALTEND
   .byte $39
   .byte $59,$39,$09,$89,$DA,$39,$29,$09,$89,$59,$29,$D9,$A9,$59,$29,$DA,$29,$D9,$A9,$59
   .byte $D1 
   .WORD BOSS_SQ2START
   
   BOSS_SQSTART_FIENDTEMPLEPART1_ALTEND:
   .byte $29 
   .byte $39,$29,$09,$39,$89,$79,$DA,$09,$D9,$A9,$39,$29,$09,$39,$89,$79,$29,$09
   
   BOSS_SQ2_FIENDTEMPLEPART2_START:
   .byte $D8,$A7,$D9,$67,$37,$67,$D8,$A7,$D9,$67,$37,$67
   .byte $D8,$A7,$D9,$57,$37,$57,$27,$57,$37,$57
   .byte $07,$37,$27,$37,$07,$37,$27,$37
   .byte $D8,$A7,$D9,$27,$07,$27,$D8,$A7,$D9,$27,$07,$27
   .byte $37,$87,$77,$87,$37,$87,$77,$87
   .byte $37,$B7,$87,$37,$B7,$87,$37,$B7
   .byte $A7,$DA,$67,$37,$27,$D9,$A7,$67,$37,$27
   .byte $DA,$27,$D9,$A7,$87,$77,$57,$87,$77,$27
   
   .byte $E1 ;  gradual decay from C
   .byte $F1 
   .WORD BOSS_SQ2_SEASHRINE_START
   .byte $E2 ;  gradual decay from 8
   .byte $F1 
   .WORD BOSS_SQ2_SEASHRINE_START
   .byte $F1 
   .WORD BOSS_SQ2_SEASHRINE_TRILLS_BAR1_3
   .byte $F1
   .WORD BOSS_SQ2_SEASHRINE_TRILLS_BAR2_5
   .byte $F1 
   .WORD BOSS_SQ2_SEASHRINE_TRILLS_BAR1_3   
   .byte $F1
   .WORD BOSS_SQ2_SEASHRINE_TRILLS_BAR4
   .byte $F1
   .WORD BOSS_SQ2_SEASHRINE_TRILLS_BAR2_5
   .byte $F1
   .WORD BOSS_SQ2_SEASHRINE_TRILLS_BAR6
   .byte $F1
   .word BOSS_SQ4_TRILLS_BAR1
   .byte $F1
   .word BOSS_SQ4_TRILLS_BAR2
   .byte $F1
   .WORD BOSS_SQ2_SEASHRINE_TRILLS_BAR9
   .BYTE $D0
   .WORD BOSS_SQ2START
   
   
   BOSS_SQ2_SEASHRINE_START:
   .byte $D8,$77,$D9,$37,$27,$37,$07,$37,$D8,$A7,$D9,$37
   .byte $D8,$57,$D9,$27,$07,$27,$D8,$A7,$D9,$27,$D8,$87,$D9,$27
   .byte $D8,$37,$D9,$07,$D8,$A7,$D9,$07,$D8,$87,$D9,$07,$D8,$77,$D9,$07
   .byte $F0 
   .WORD BOSS_SQ2_SEASHRINE_PART1_ALTEND
   .byte $D8,$57,$D9,$07,$D8,$37,$D9,$27,$D8,$57,$D9,$27,$D8,$A7,$D9,$27
   .byte $D1 
   .WORD BOSS_SQ2_SEASHRINE_START
   
   BOSS_SQ2_SEASHRINE_PART1_ALTEND:
   .byte $D8,$37,$D9,$07,$D8,$87,$D9,$07
   .byte $D1 
   .WORD BOSS_SQ2_SEASHRINE_PART1_ALTEND
   .byte $F2
   
   BOSS_SQ2_SEASHRINE_TRILLS_BAR1_3:
   .byte $5A,$2A,$5A,$2A
   .byte $D7 
   .WORD BOSS_SQ2_SEASHRINE_TRILLS_BAR1_3
   .byte $F2
   
   BOSS_SQ2_SEASHRINE_TRILLS_BAR2_5:
   .byte $3A,$0A,$3A,$0A
   .byte $D7 
   .WORD BOSS_SQ2_SEASHRINE_TRILLS_BAR2_5
   .byte $F2
   
   BOSS_SQ2_SEASHRINE_TRILLS_BAR4:
   .byte $7A,$3A,$7A,$3A
   .byte $D7 
   .WORD BOSS_SQ2_SEASHRINE_TRILLS_BAR4
   .byte $F2
   
   BOSS_SQ2_SEASHRINE_TRILLS_BAR6:
   .byte $5A,$0A,$5A,$0A
   .byte $D7 
   .WORD BOSS_SQ2_SEASHRINE_TRILLS_BAR6
   .byte $F2
   .byte $D8
   
   BOSS_SQ2_SEASHRINE_TRILLS_BAR9:
   .byte $BA,$5A,$BA,$5A,$BA,$5A,$BA,$5A
   .byte $D7 
   .WORD BOSS_SQ2_SEASHRINE_TRILLS_BAR9
   .byte $F2


   
   
BOSS_TRI:
   .byte $FB         ; tempo FB
   ;.byte $F8,$08,$E0 ; envelope speed and pattern...?
   .byte $C3         ; half note pause
   BASSINTRO:
   .byte $D8,$79,$C9,$79,$C9,$79,$C9,$79,$C9,$79,$C9,$79,$C9,$59,$C9,$59,$C9
   .byte $79,$C9,$79,$C9,$79,$C9,$79,$C9,$79,$C9,$59,$C9,$39,$C9,$29,$C9
   
   BOSS_TRISTART:
   .byte $09,$C9,$09,$C9,$09,$C9,$09,$C9,$09,$C9,$29,$C9,$79,$C9,$09,$C9  
   .byte $A9,$C9,$A9,$C9,$A9,$C9,$A9,$C9,$A9,$C9,$D9,$29,$C9,$59,$C9,$D8,$A9,$C9  
   .byte $F0
   .WORD BOSS_TRISTART_ALTEND

   .byte $89,$C9,$89,$C9,$89,$C9,$89,$C9,$89,$C9,$89,$C9,$79,$C9,$79,$C9
   .byte $89,$C9,$89,$C9,$89,$C9,$89,$C9,$A9,$C9,$A9,$C9,$59,$C9,$29,$C9
   .byte $D1
   .WORD BOSS_TRISTART
   
   BOSS_TRISTART_ALTEND:
   .byte $99,$C9,$99,$C9,$99,$C9,$89,$C9,$89,$C9,$79,$C9,$59,$C9,$29,$C9
   .byte $37,$57,$87,$A7,$D9,$07,$D8,$57,$87,$57
   
   ;;Part 2 of Temple of Fiends bit
   
   BOSS_TRI_BOOPS1:
   .byte $39,$C9,$39,$C9,$39,$C9,$A9,$C9
   .byte $D1
   .word BOSS_TRI_BOOPS1
   
   BOSS_TRI_BOOPS2:
   .byte $A9,$C9,$A9,$C9,$A9,$C9,$D9,$59,$C9,$D8
   .byte $D1
   .word BOSS_TRI_BOOPS2
   
   BOSS_TRI_BOOPS3:
   .byte $79,$C9,$79,$C9,$79,$C9,$D9,$09,$C9,$D8
   .byte $D1
   .word BOSS_TRI_BOOPS3
   
   BOSS_TRI_BOOPS4:
   .byte $A9,$C9,$A9,$C9,$A9,$C9,$D9,$29,$C9,$D8
   .byte $D1
   .word BOSS_TRI_BOOPS4
   
   BOSS_TRI_BOOPS5:
   .byte $39,$C9,$39,$C9,$39,$C9,$A9,$C9
   .byte $D1
   .word BOSS_TRI_BOOPS5
   
   BOSS_TRI_BOOPS6:
   .byte $89,$C9,$89,$C9,$89,$C9,$69,$C9,$89,$C9,$89,$C9,$39,$C9,$39,$C9

   BOSS_TRI_BOOPS7:
   .byte $67,$D9,$67,$37,$D8
   .byte $D1
   .word BOSS_TRI_BOOPS7
   .byte $67,$D9,$67,$D8
   
   BOSS_TRI_BOOPS8:
   .byte $A7,$D9,$A7,$87,$D8
   .byte $D1
   .word BOSS_TRI_BOOPS8
   .byte $A7,$D9,$A7
   
   BOSS_TRI_SEASHRINE_START:
   .byte $01
   .byte $D8,$A1
   .byte $80
   .byte $A3
   .byte $D9,$01
   .byte $D8,$A1
   .byte $81
   .byte $F0
   .WORD BOSS_TRI_SEASHRINE_BRIDGE
   .byte $82,$87,$C7
   .byte $D1
   .WORD BOSS_TRI_SEASHRINE_START
   
   BOSS_TRI_SEASHRINE_BRIDGE:
   .byte $87,$C7,$87,$C7,$89,$C9,$89,$C9,$89,$C9,$A9,$C9
   
   BOSS_TRI_SEASHRINE_PART2:
   .byte $DC,$B9,$C9,$B7,$D8,$B9,$C9,$B7,$C7,$77,$B7,$77
   .byte $09,$C9,$07,$D9,$09,$C9,$07,$C7,$D8,$77,$D9,$07,$D8,$77  
   .byte $29,$C9,$27,$D9,$29,$C9,$27,$C7,$D8,$A7,$D9,$27,$D8,$27
   .byte $39,$C9,$37,$D9,$39,$C9,$37,$C7,$D8,$A7,$D9,$37,$D8,$27
   .byte $71 
   .byte $51 
   ;;earth cave/volcano bit
   
   .byte $29,$C9,$29,$C9,$59,$C9,$29,$C9,$09,$C9,$35,$27
   .byte $C7,$29,$C9,$59,$C9,$29,$C9,$09,$C9,$35,$22
   .byte $0A,$2A,$3A,$5A,$7A,$8A,$AA,$D9,$0A,$29,$C9
   .byte $29,$C9,$09,$C9,$D8,$A9,$C9,$89,$C9,$79,$C9,$59,$C9,$39,$C9,$29,$C9
   
   .BYTE $D0
   .WORD BOSS_TRISTART


BOSS_SQ3:
    .byte $FB         ; tempo FB
    .byte $C0,$C1     ; two and a half bar pause
    .BYTE $F5,$02     ; duty set 25%
   BOSS_SQ3START:
   .byte $F8,$0C      ; envelope speed $0C
   .byte $E8          ; hold, then decay from C
   .byte $D8,$01
   .byte $DC,$A1
   .byte $81
   .byte $83,$A3
   .byte $D8,$01
   .byte $DC,$A1
   .byte $91
   .byte $81
   .byte $F8,$08      ; envelope speed $08
   .byte $E1          ; gradual decay from C
   .byte $D8
   .byte $37,$A5,$A7,$37,$A5,$A7
   .byte $57,$A5,$A7,$57,$A5,$A7
   .byte $37,$D9,$05,$07,$D8,$37,$D9,$05,$07
   .byte $D8,$77,$D9,$25,$27,$D8,$77,$D9,$25,$27
   .byte $D8,$87,$D9,$35,$37,$D8,$87,$D9,$35,$37
   .byte $D8,$37,$B5,$B7,$37,$B5,$B7
   .byte $67,$D9,$67,$37,$D8,$67,$D9,$67,$35,$67
   .byte $D8,$A7,$D9,$A7,$87,$37,$D8,$A7,$85,$77
   
   BOSS_SQ3_SEASHRINE_INTRO:
   .byte $07,$07,$C2
   .byte $DC,$A7,$A7,$C2
   .byte $87,$87,$C2
   .byte $87,$87,$C5,$A7,$A7,$C5
   .byte $D8,$07,$07,$C2
   .byte $DC,$A7,$A7,$C2
   .byte $87,$87,$C2
   .byte $87,$87,$C7 
   .byte $87,$87,$87,$D8 
   .byte $F8,$09      ; envelope speed $09
   .byte $05
   
   BOSS_SQ3_SEASHRINE_PART1:
   .byte $07,$07,$27,$37,$07,$07,$27,$37
   .byte $DC,$A7,$A7,$D8,$07,$27,$DC,$A7,$A7,$D8,$07,$27
   .byte $DC,$87,$87,$A7,$D8,$07,$DC,$87,$87,$A7,$D8,$07 
   .byte $DC,$87,$87,$A7,$D8,$07
   .byte $F0
   .WORD BOSS_SQ3_SEASHRINE_PART1_ALTEND
   
   .byte $DC,$A7,$A7,$D8,$07,$27
   .byte $D1
   .WORD BOSS_SQ3_SEASHRINE_PART1
   
   BOSS_SQ3_SEASHRINE_PART1_ALTEND:
   .byte $37,$37,$57,$77
   .byte $27,$27,$57,$27,$07,$35,$25
   .byte $27,$57,$27,$37,$75,$77
   .byte $57,$57,$87,$57,$37,$75,$55
   .byte $57,$87,$57,$77,$A5,$A7
   .byte $07,$07,$27,$07,$DC,$A7,$D8,$35,$27
   .byte $55,$37,$75,$57,$85
   .byte $F8,$08      ; envelope speed $08
   .byte $E1          ; gradual decay from C
   .byte $DC          ; VERY BASS
   .byte $27,$27,$57,$27,$07,$35,$25
   .byte $27,$57,$27,$07,$35
   .byte $F8,$0C      ; envelope speed $0C
   .byte $21
   .byte $F8,$08      ; envelope speed $08
   .byte $D8
   .byte $77
   .byte $77,$57,$37,$27,$77,$57,$37,$27
   .byte $D0
   .WORD BOSS_SQ3START
   
BOSS_SQ4:
    .byte $FB         ; tempo FB
    .byte $F4         ; half volume, for later loop
    .byte $C0,$C1     ; two and a half bar pause
    
   BOSS_SQ4START: 
    .byte $C0,$C1,$C5  ; two and a half bar + quarter note pause
    .byte $F4          ; un-halve volume    
    .byte $F5,$03      ; 50% duty
    .byte $F8,$0C      ; envelope speed $0C
    .byte $ED          ; decay from C with tremelo
    .byte $DA,$34,$2C,$3C,$2C,$05,$27,$07,$D9,$A5
    .byte $DA,$00 
    .byte $C2,$C6 
    .byte $79,$87,$77,$55 
    .byte $71 
    .byte $D9,$A3,$DA,$63 
    .byte $A1
    .byte $DB,$02,$09,$DA,$A9,$79,$39
    .byte $DB,$20 
    .byte $F4         ; half volume
    .byte $EC         ; decay from F with tremelo
    .byte $55,$35 
    .byte $DA,$B4,$B7,$DB,$17,$DA,$B7,$A7,$B7
    .byte $A3,$39,$69,$A9,$DB,$39,$69,$A9,$69,$39
    .byte $F4          ; un-halve volume   
    .byte $ED          ; decay from C with tremelo
    .byte $DA,$A7,$57,$37,$27,$A7,$87,$DB,$25
    .byte $F8,$0D      ; envelope speed $0D
    .byte $30  
    .byte $C0 
    .byte $C1 
    .byte $F8,$08      ; envelope speed $08
    .byte $EE          ; fade C->4->B with tremolo
 
    
    BOSS_SQ4_SEASHRINE_LOOP:
    .byte $D9,$77,$DA,$37,$27,$37,$07,$37,$57,$37
    .byte $D9,$57,$DA,$27,$07,$27,$D9,$A7,$DA,$27,$07,$D9,$A7
    .byte $37,$DA,$07,$D9,$A7,$DA,$07,$D9,$87,$DA,$07,$D9,$77,$57 
    .byte $37,$DA,$07,$D9,$A7,$DA,$07,$D9,$87,$DA,$07,$D9,$77,$57 
    .byte $D2
    .WORD BOSS_SQ4_SEASHRINE_LOOP

    .byte $F4         ; half volume
    .byte $EC         ; decay from F with tremelo
    .byte $F8,$0C     ; envelope speed $0C
    ;; mini solo
    .byte $DA,$23,$35,$55
    .byte $72,$79,$89,$79,$39
    .byte $53,$35,$55
    .byte $73,$A3
    .byte $85,$35,$DB,$05,$DA,$A5
    .byte $75,$35,$DB,$35,$05
    .byte $DA
    
    .byte $F5,$02      ; 25% duty
    .byte $F8,$0C      ; envelope speed $08
    
    .byte $F1
    .word BOSS_SQ4_TRILLS_BAR1
    .byte $F1
    .word BOSS_SQ4_TRILLS_BAR2
    
    BOSS_SQ4_TRILLS_BAR3_4:
    .byte $DB,$2A,$DA,$BA
    .byte $DB,$2A,$DA,$BA
    .byte $DB,$2A,$DA,$BA
    .byte $DB,$2A,$DA,$BA
    .byte $D7
    .WORD BOSS_SQ4_TRILLS_BAR3_4

    .BYTE $D0
    .WORD BOSS_SQ4START
    
    
    BOSS_SQ4_TRILLS_BAR1:
    .byte $BA,$7A,$BA,$7A
    .byte $D7
    .WORD BOSS_SQ4_TRILLS_BAR1
    .byte $F2
    
    BOSS_SQ4_TRILLS_BAR2:
    .byte $BA,$8A,$BA,$8A
    .byte $D7
    .WORD BOSS_SQ4_TRILLS_BAR2
    .byte $F2



;; DB = orange octave 
;; DA = yellow octave
;; D9 = white octave
;; D8 = blue octave
;; DC = dark blue octave
;;   
;;        0   1   2   3   4   5   6   7   8   9   A   B   C   D   E   F
;; .BYTE $90,$60,$48,$30,$24,$18,$12,$0C,$09,$06,$03,$03,$04,$10,$08,$08 ; FB (75 bpm)
;;
;; $_C = half a sixteenth note + 1 ;; 12 used in the opening woosh =  an extra $_7 of length
;; -- that's why there's an eighth-note gap before the melody starts in the original battle song. 
;;
;; LENGTH                              ; PITCH
;; $_B = $_A                           ; B = B
;; $_A = half a sixteenth note         ; A = Bb
;; $_9 = sixteenth note                ; 9 = A
;; $_8 = sixteenth+half a sixteenth    ; 8 = Ab
;; $_7 = eighth note                   ; 7 = G
;; $_6 = eighth+sixteenth              ; 6 = F#
;; $_5 = fourth note                   ; 5 = F
;; $_4 = fourth+eigth                  ; 4 = E
;; $_3 = half note                     ; 3 = Eb
;; $_2 = third note                    ; 2 = D
;; $_1 = whole note                    ; 1 = C#
;; $_0 = one and a half                ; 0 = C
;;
;; JIGS - my midi is 150 bpm, so the note lengths here are doubled IN NAME to match it.
;; Each $01 of length is 16 ticks in the midi. (384 ticks per quarter note)   


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

    ;; JIGS -- use the MMC5 multiplier registers to use 10 bytes per song, 5 tracks each
    LDX #10
    JSR MultiplyXA
    CLC
    ADC mu_chanprimer     ; And do this instead of ORA
    STA tmp               ; this is the low byte of the pointer to the pointer table
    
    TXA
    ADC #>lut_ScoreData   ; get the high byte
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

    CMP #2*5
    BCC @Exit            ; check to see if all 3 of these have been primed.  If not, just exit
                         ;  otherwise... all channels are primed -- music is all set for playback
      LDA #0
      STA music_track    ; zero music_track to indicate that a track is playing

      STA ch_loopctr+CHAN_SQ1
      STA ch_loopctr+CHAN_SQ2
      STA ch_loopctr+CHAN_TRI
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

  @Exit:
    RTS

 ;; LUT used to convert from primer index to chan index
  @lut_PrimerToChan:
  .BYTE CHAN_SQ1,  CHAN_SQ1
  .BYTE CHAN_SQ2,  CHAN_SQ2
  .BYTE CHAN_TRI,  CHAN_TRI
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
      
      JSR QuarterVolume
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

QuarterVolume:
  STA tmp
  LDY ch_extraquiet, X
  BEQ :+
    CLC
    LSR A     ; divide volume by 2
    LSR A     ; then four
;    ADC #$0   ; add the carry back in
  : RTS  

HalfVolume:
  STA tmp
  LDY ch_quiet, X
  BEQ :+
    CLC
    LSR A     ; divide volume by 2
;    ADC #$0   ; add the carry back in
  : RTS  
  
HalfVolumeMenu:
  STA tmp
  LDY MenuHush
  BEQ :+
    CLC
    LSR A     ; divide volume by 2
;    ADC #$0   ; add the carry back in
  : RTS      
    
    
    
    
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
       BNE @UnShush
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
    CMP #$F6
    BNE SkipMusicBit
        LDA ch_extraquiet, X
        BNE @UnShush_2
          LDA #01
          STA ch_extraquiet, X
          JMP SkipMusicBit
    
       @UnShush_2:
       LDA #00
       STA ch_extraquiet, X
     
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
  .BYTE $90,$60,$48,$30,$24,$18,$12,$0C,$09,$06,$03,$03,$04,$10,$08,$08 ; FB (75 bpm)
  .BYTE $78,$50,$3C,$28,$1E,$14,$0F,$0A,$07,$05,$03,$02,$0E,$0D,$07,$06 ; FC (90 bpm)
  .BYTE $6C,$48,$36,$24,$1B,$12,$0E,$09,$07,$04,$03,$06,$0E,$60,$40,$30 ; FD (99 bpm)
  ;.BYTE $60,$40,$30,$20,$18,$10,$0C,$08,$06,$04,$02,$02,$0B,$0A,$06,$05 ; FE
  .BYTE $80,$60,$40,$30,$20,$18,$10,$0C,$08,$06,$04,$02,$03,$05,$01,$C0 ; (112.5 bpm)
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

  .BYTE  $0C,$0C,$0C,$0C,$0C,$0C,$0C,$0C,$0B,$0B,$0A,$0A,$09,$09,$08,$08 ; pattern $E8
  .BYTE  $06,$06,$05,$05,$04,$04,$04,$03,$03,$03,$02,$02,$02,$02,$02,$02 ;  hold, then decay from C
 
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
  
BackupMapMusic:
    LDA #1
    STA $5113         ; swap RAM
    
    LDY #0
    LDX #0
    STX MMC5_tmp
   @MainLoop:
    LDA CHAN_START, Y
    STA MapMusicBackup, Y
    INY
    CPY #80
    BNE @MainLoop
  
  @ExtraLoop_Start:  
   LDY #0
  @ExtraLoop:   
   LDA EXTRA_CHAN_START, X
   STA MapMusicBackup1, X
   INY
   INX
   CPY #7
   BNE @ExtraLoop
   
   LDA MMC5_tmp
   CMP #4
   BEQ :+
   
   TXA 
   CLC
   ADC #9
   TAX
    
   INC MMC5_tmp
   JMP @ExtraLoop_Start
   
 : LDA #0
   STA $5113         ; swap RAM
   RTS


RestoreMapMusic:
    LDA #$30
    STA $4000   ; set Squares and Noise volume to 0
    STA $4004   ;  clear triangle's linear counter (silencing it next clock)
    STA $4008
    STA $400C
    STA $5000   ; set MMC5 Squares volume to 0
    STA $5004   ;


    LDA #1
    STA $5113         ; swap RAM
    LDY #0
    LDX #0
    STX MMC5_tmp
   @MainLoop:
    LDA MapMusicBackup, Y
    STA CHAN_START, Y
    INY
    CPY #80
    BNE @MainLoop
  
  @ExtraLoop_Start:  
   LDY #0
  @ExtraLoop:   
   LDA MapMusicBackup1, X
   STA EXTRA_CHAN_START, X
   INY
   INX
   CPY #7
   BNE @ExtraLoop
   
   LDA MMC5_tmp
   CMP #4
   BEQ :+
   
   TXA 
   CLC
   ADC #9
   TAX
    
   INC MMC5_tmp
   JMP @ExtraLoop_Start
   
 : LDA mapflags            ; make sure we're on the overworld
   LSR A                   ; Get SM flag, and shift it into C
   BCC :+                  ; if set (on overworld), do overworld music
 
   LDX cur_tileset               ; get the tileset
   LDA lut_TilesetMusicTrack, X  ; use it to get the music track tied to this tileset
   JMP @End
   
 : LDX vehicle
   LDA lut_VehicleMusic, X  
 
  @End:
   STA dlgmusic_backup
   
   JSR WaitForVBlank_L     ; wait a frame
    
    LDA #$00                ; burn a bunch of CPU time -- presumably so that 
    : SEC                   ;  WaitForVBlank isn't called again so close to start of
      SBC #$01              ;  vblank.  I don't think this is actually necessary,
      BNE :-                ;  but it doesn't hurt.
      
   JSR WaitForVBlank_L     ; wait another frame
   
   LDA #0
   STA $5113         ; swap RAM
   RTS
 
 
 
 
 
 
  
  
  
.byte "END OF BANK MUSIC"  
  
  
   