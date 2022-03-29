
.export MusicPlay_L
.export BackupMapMusic
.export RestoreMapMusic
.export lut_MapMusicTrack

.import lut_VehicleMusic
.import MultiplyXA
.import WaitForVBlank_L

.include "variables.inc"
.include "Constants.inc"
.feature force_range

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

;;  JIGS - New format for control codes: See Constants.inc for MUSIC SCORE COMMANDS
;;  LOOP FOREVER    - Main loop for a song.
;;  LOOP 1-7 times  - Loop this many times.
;;  OCTAVE 1-5      - Set octave
;;  OCTAVE UP/DOWN  - Set octave offset -- used for the new Marsh Cave song so that an MMC5 square matches the triangle bass. Use again to turn it off.
;;                    Can now also be used to reach the highest octave!
;;  LOOP SWITCH     - Ignores the loop address the first time around, then branches to the new address when read again
;;  INSTRUMENT 0-F  - Set instrument
;;  SCORE GOTO      - Jumps to address
;;  SCORE RETURN    - Returns to previous jump point
;;  VOLUME MINUS    - Next byte is amount to subtract from volume
;;  VOLUME QRTR     - Toggle for using 1/4th the volume
;;  VOLUME HALF     - Toggle for using 1/2 volume - WORKS ON TRIANGLE TOO!!*
;;  DUTY 12         - Sets duty to 12.5%
;;  DUTY 25         - Sets duty to 25%
;;  DUTY 50         - Sets duty to 50%
;;  ENVELOPE 0-F    - Sets Envelope speed
;;  TEMPO 1-6       - Sets note length
;;  END SONG        - Ends song and stops all playback
;; 
;; * Uses DPCM volume register. 
;; Entering the menu also hushes the triangle, along with forcing a half volume trigger on all square channels.

;; JIGS - square 2 is now usually played by the MMC5 square for 2 reasons:
;; 1: Allows the normal square 2 to handle SFX without interrupting most songs
;; 2: using Mesen, you can pan the original square channels to one side, but both MMC5 channels are panned together,
;;   so this allows for a more balanced stereo sound if that's what you dig
;;   and most melodies have a new subtle delay, with square 3 copying square 1 at a much lower volume and a few frames off beat

 .ALIGN $100
lut_ScoreData:

;; $41
.word PRELUDE_SQ1
.word PRELUDE_SQ4
;.word PRELUDE_TRI
.word BLANK_TRI ;; JIGS < Prelude doesn't use the triangle, but it does now have a melody!
.word PRELUDE_SQ3
.word PRELUDE_SQ2

;; $42
.word PROLOGUE_SQ1
.word BLANK
.word PROLOGUE_TRI
.word PROLOGUE_SQ3
.word PROLOGUE_SQ2

;; $43
.word EPILOGUE_SQ1
.word BLANK
.word EPILOGUE_TRI
.word EPILOGUE_SQ3
.word EPILOGUE_SQ2

;; $44
.word OVERWORLD_SQ1
.word BLANK
.word OVERWORLD_TRI
.word OVERWORLD_SQ3
.word OVERWORLD_SQ2

;; $45
.word SHIP_SQ1
.word BLANK
.word SHIP_TRI
.word SHIP_SQ3
.word SHIP_SQ2

;; $46
.word AIRSHIP_SQ1
.word BLANK
.word AIRSHIP_TRI
.word AIRSHIP_SQ3
.word AIRSHIP_SQ2

;; $47
.word TOWN_SQ1
.word BLANK
.word TOWN_TRI
.word TOWN_SQ2
.word TOWN_SQ3

;; $48
.word CASTLE_SQ1
.word BLANK
.word CASTLE_TRI
.word CASTLE_SQ3
.word CASTLE_SQ2

;; $49
.word EARTHCAVE_SQ1
.word BLANK
.word EARTHCAVE_TRI
.word EARTHCAVE_SQ3
.word EARTHCAVE_SQ2

;; $4A
.word MATOYA_SQ1
.word BLANK
.word MATOYA_TRI
.word MATOYA_SQ3
.word MATOYA_SQ2

;; $4B
.word MARSHCAVE_SQ1
.word MARSHCAVE_SQ4
.word MARSHCAVE_TRI
.word MARSHCAVE_SQ3
.word MARSHCAVE_SQ2

;; $4C
.word SEASHRINE_SQ1
.word BLANK
.word SEASHRINE_TRI
.word SEASHRINE_SQ3
.word SEASHRINE_SQ2

;; $4D
.word SKYCASTLE_SQ1
.word SKYCASTLE_SQ4
.word SKYCASTLE_TRI
.word SKYCASTLE_SQ3
.word SKYCASTLE_SQ2

;; $4E
.word FIENDTEMPLE_SQ1
.word BLANK
.word FIENDTEMPLE_TRI
.word FIENDTEMPLE_SQ3
.word FIENDTEMPLE_SQ2

;; $4F
.word SHOP_SQ1
.word BLANK
.word SHOP_TRI
.word SHOP_SQ3
.word SHOP_SQ2

;; $50
.word BATTLE_SQ1
.word BLANK
;.word BATTLE_SQ2 ;; JIGS - Now played by the MMC5 audio so that SFX don't interrupt it.
.word BATTLE_TRI
.word BATTLE_SQ2
.word BATTLE_SQ3

;; $51
.word MENU_SQ1
.word BLANK
.word MENU_TRI
.word MENU_SQ3
.word MENU_SQ2
;; JIGS - the code that plays this has been disabled in menus
;; JIGS - BUT it has been moved to the map screen! And is used in inns!

;; $52
.word SLAIN_SQ1
.word SLAIN_SQ4
.word SLAIN_TRI
.word SLAIN_SQ3
.word SLAIN_SQ2

;; $53
.word BATTLEWIN_SQ1
.word BLANK
.word BATTLEWIN_TRI
.word BATTLEWIN_SQ3
.word BATTLEWIN_SQ2

;; $54
.word SAVE_SQ1
.word BLANK
.word SAVE_TRI
.word BLANK
.word SAVE_SQ2

;; $55
.word MARSHCAVEOLD_SQ1
.word BLANK
.word MARSHCAVEOLD_TRI
.word MARSHCAVEOLD_SQ3
.word MARSHCAVEOLD_SQ2

;; JIGS - a copy of the prelude for some reason?
;; Rename these and you have a new song if you have the space for it.

;; $56
.word FANFARE_SQ1
.word BLANK
.word FANFARE_TRI
.word BLANK
.word FANFARE_SQ2

;; $57
.word HEAL_SQ1
.word BLANK
.word HEAL_TRI
.word BLANK
.word HEAL_SQ2
;; JIGS - the code that plays this has been disabled

;; $58
.word TREASURE_SQ1
.word BLANK
.word TREASURE_TRI
.word BLANK
.word TREASURE_SQ2
;; JIGS - the code that plays this has been disabled

;; $59
.word BOSS_SQ1
.word BOSS_SQ2
.word BOSS_TRI
.word BOSS_SQ3
.word BOSS_SQ4

;; $5A
.word MARSHBOSS_SQ1
.word BLANK
.word MARSHBOSS_TRI
.word MARSHBOSS_SQ3
.word MARSHBOSS_SQ2

;; $5B
.word RUINEDCASTLE_SQ1
.word RUINEDCASTLE_SQ4
.word RUINEDCASTLE_TRI
.word RUINEDCASTLE_SQ3
.word RUINEDCASTLE_SQ2

;; $5A

;; With thanks to Gil Galad for their music driver disassembly for this sequence data!

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;            PRELUDE                               ;;;;;;;;;;;;;;;;;;;;;;;;;;;;        
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

PRELUDE_SQ1:

    .byte DUTY_25
    .byte TEMPO,$04,SPEED_SET,$83,INSTRUMENT,$00
    .byte $C7 ;; JIGS adding a short rest because the audio doesn't kick in fast enough in Mesen. Eh.
    PLOOP0:
    .byte OCTAVE_2,OCTAVE_DOWN ; down to 1! 
    PLOOP0A:
    .byte $A7,OCTAVE_DOWN,$07,$27,$57
    .byte $A7,OCTAVE_3,$07,$27,$57
    .byte $A7,OCTAVE_4,$07,$27,$57
    .byte $A7,OCTAVE_5,$07,$27,$57
    .byte $A7,$57,$27,$07,OCTAVE_4
    .byte $A7,$57,$27,$07,OCTAVE_3
    .byte $A7,$57,$27,$07,OCTAVE_2
    .byte $A7,$57,$27,$07,OCTAVE_DOWN
    ;; first chord done
    .byte $77,$97,$A7,OCTAVE_DOWN,$27
    .byte $77,$97,$A7,OCTAVE_3,$27
    .byte $77,$97,$A7,OCTAVE_4,$27
    .byte $77,$97,$A7,OCTAVE_5,$27
    .byte $77,$27,OCTAVE_4,$A7,$97
    .byte $77,$27,OCTAVE_3,$A7,$97
    .byte $77,$27,OCTAVE_2,$A7,$97
    .byte $77,$27,OCTAVE_DOWN,$A7,$97
    .byte LOOP_X,$01
    .word PLOOP0A
    
    .byte $77,$A7,OCTAVE_DOWN,$37,$57
    .byte $77,$A7,OCTAVE_3,$37,$57
    .byte $77,$A7,OCTAVE_4,$37,$57
    .byte $77,$A7,OCTAVE_5,$37,$57
    .byte $77,$57,$37,OCTAVE_4,$A7
    .byte $77,$57,$37,OCTAVE_3,$A7
    .byte $77,$57,$37,OCTAVE_2,$A7
    .byte $77,$57,$37,OCTAVE_DOWN,$A7
    .byte $97,OCTAVE_DOWN,$07,$57,$77
    .byte $97,OCTAVE_3,$07,$57,$77
    .byte $97,OCTAVE_4,$07,$57,$77
    .byte $97,OCTAVE_5,$07,$57,$77
    .byte $97,$77,$57,$07
    .byte OCTAVE_4,$97,$77,$57,$07
    .byte OCTAVE_3,$97,$77,$57,$07
    .byte OCTAVE_2,$97,$77,$57,$07
    .byte OCTAVE_DOWN,$67,$A7,OCTAVE_DOWN,$17,$57
    .byte $67,$A7,OCTAVE_3,$17,$57
    .byte $67,$A7,OCTAVE_4,$17,$57
    .byte $67,$A7,OCTAVE_5,$17,$57
    .byte $67,$57,$17,OCTAVE_4,$A7
    .byte $67,$57,$17,OCTAVE_3,$A7
    .byte $67,$57,$17,OCTAVE_2,$A7
    .byte $67,$57,$17,OCTAVE_DOWN,$A7
    .byte $87,OCTAVE_DOWN,$07,$37,$77
    .byte $87,OCTAVE_3,$07,$37,$77
    .byte $87,OCTAVE_4,$07,$37,$77
    .byte $87,OCTAVE_5,$07,$37,$77
    .byte $87,$77,$37,$07
    .byte OCTAVE_4,$87,$77,$37,$07
    .byte OCTAVE_3,$87,$77,$37,$07
    .byte OCTAVE_2,$87,$77,$37,$07,OCTAVE_DOWN
    .byte LOOP_FOREVER
    .word PLOOP0A

PRELUDE_SQ2:

;; JIGS - this is more space efficient:

.byte DUTY_25; DUTY_12
.byte TEMPO,$04,SPEED_SET,$83,INSTRUMENT,$02,$C4 ; (note: this takes into account the extra rest I added in the first channel)
.byte LOOP_FOREVER
.word PLOOP0

;     .byte TEMPO,$04,SPEED_SET,$05,INSTRUMENT,$02,$C7,$C7
;    PLOOP1:
;    PLOOP1A:
;    .byte OCTAVE_2,$A7,OCTAVE_2,$07,$27,$57,$A7,OCTAVE_3,$07,$27,$57,$A7,OCTAVE_4,$07,$27,$57
;    .byte $A7,OCTAVE_5,$07,$27,$57,$A7,$57,$27,$07,OCTAVE_4,$A7,$57,$27,$07,OCTAVE_3,$A7
;    .byte $57,$27,$07,OCTAVE_2,$A7,$57,$27,$07,OCTAVE_2,$77,$97,$A7,OCTAVE_2,$27,$77,$97
;    .byte $A7,OCTAVE_3,$27,$77,$97,$A7,OCTAVE_4,$27,$77,$97,$A7,OCTAVE_5,$27,$77,$27,OCTAVE_4
;    .byte $A7,$97,$77,$27,OCTAVE_3,$A7,$97,$77,$27,OCTAVE_2,$A7,$97,$77,$27,OCTAVE_2,$A7
;    .byte $97
;    .byte LOOP_X,$01
;    .word PLOOP1A ; $C3,$81
;    .byte OCTAVE_2,$77,$A7,OCTAVE_2,$37,$57,$77,$A7,OCTAVE_3,$37,$57,$77
;    .byte $A7,OCTAVE_4,$37,$57,$77,$A7,OCTAVE_5,$37,$57,$77,$57,$37,OCTAVE_4,$A7,$77,$57
;    .byte $37,OCTAVE_3,$A7,$77,$57,$37,OCTAVE_2,$A7,$77,$57,$37,OCTAVE_2,$A7,OCTAVE_2,$97,OCTAVE_2
;    .byte $07,$57,$77,$97,OCTAVE_3,$07,$57,$77,$97,OCTAVE_4,$07,$57,$77,$97,OCTAVE_5,$07
;    .byte $57,$77,$97,$77,$57,$07,OCTAVE_4,$97,$77,$57,$07,OCTAVE_3,$97,$77,$57,$07
;    .byte OCTAVE_2,$97,$77,$57,$07,OCTAVE_2,$67,$A7,OCTAVE_2,$17,$57,$67,$A7,OCTAVE_3,$17,$57
;    .byte $67,$A7,OCTAVE_4,$17,$57,$67,$A7,OCTAVE_5,$17,$57,$67,$57,$17,OCTAVE_4,$A7,$67
;    .byte $57,$17,OCTAVE_3,$A7,$67,$57,$17,OCTAVE_2,$A7,$67,$57,$17,OCTAVE_2,$A7,OCTAVE_2,$87
;    .byte OCTAVE_2,$07,$37,$77,$87,OCTAVE_3,$07,$37,$77,$87,OCTAVE_4,$07,$37,$77,$87,OCTAVE_5
;    .byte $07,$37,$77,$87,$77,$37,$07,OCTAVE_4,$87,$77,$37,$07,OCTAVE_3,$87,$77,$37
;    .byte $07,OCTAVE_2,$87,$77,$37,$07
;    .byte LOOP_FOREVER
;    .word PLOOP1 ; ORINGAL $C3,$81

PRELUDE_TRI:
    .byte TEMPO,$04
    PLOOP2:
    .byte $C0 ; $C7 update less often
    .byte LOOP_FOREVER
    .word PLOOP2

PRELUDE_SQ3:
    .byte SCORE_GOTO
    .word PRELUDE_MELODY_SHARED
    
    .byte $A3 ; fade in a quarter note length before the melody really starts
    .byte INSTRUMENT,$07 
    .byte SPEED_SET,$02
    PRELUDEMELODY:
    .byte OCTAVE_3,$A0,$C3,$91,OCTAVE_4,$01,OCTAVE_3,$AB,$9B,$A0,$CB,$C5,OCTAVE_4,$03,OCTAVE_3,$A3,$93
    .byte OCTAVE_4,$03,OCTAVE_3,$AB,$9B,$A0,$CB,$C5,$91,OCTAVE_4,$01
    .byte $05,$25,OCTAVE_3,$A0,OCTAVE_4,$23,$03,OCTAVE_3,$A5,$CB,OCTAVE_4,$0B,OCTAVE_3,$AB,$95,$CB
    .byte $AB,$9B,$70,$C3,$51,$71,$90,$A3,OCTAVE_4,$01
    .byte LOOP_SWITCH ; like a train track switch... next time it loops past here, it goes to END2 instead. First time, it ignores it...
    .word PRELUDEMELODY_END2
    ;... and plays this instead:
    .byte OCTAVE_3,$91,$A0,$C3,OCTAVE_4,$13,$03,OCTAVE_3,$A3,OCTAVE_4,$13,$00,$13,$31,$01,LOOP_X,$01
    .word PRELUDEMELODY

    PRELUDEMELODY_END2:
    .byte $51,$33,$15,$05,OCTAVE_3,$A0,$C3,OCTAVE_4,$51,$53,$35,$15,$00,$C3,$03,$13,LOOP_FOREVER
    .word PRELUDEMELODY

    ;; JIGS - melody based off Ailsean's "Final Ecstacy" remix (OCRemix.org)! I like it.

PRELUDE_MELODY_SHARED:
    .byte TEMPO,$04
    .byte DUTY_50
    .byte SPEED_SET,$03
    PRELUDEWAIT:
    .byte $C0,$C0,$C1,LOOP_X,$06 ; 14 bars
    .word PRELUDEWAIT
    .byte $C0,$C0,$C3 ; + 1 and 3/4 bars
    .byte $C7 ; take into account the delay on all tracks
    ; wait until song loops once
    .byte INSTRUMENT,$0F,OCTAVE_3
    .byte SCORE_RETURN

PRELUDE_SQ4:
    .byte SCORE_GOTO
    .word PRELUDE_MELODY_SHARED
    
    ;.byte $C5,$CA ; little bit more than an 8th note pause
    .byte $C3
    .byte VOLUME_HALF,$A3,VOLUME_HALF ;; VOLUME_HALF makes this half volume, once to turn it on, once to turn it off
    .byte INSTRUMENT,$08,SPEED_SET,$02,VOLUME_MINUS,$05,LOOP_FOREVER
    .word PRELUDEMELODY

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;           PROLOGUE                               ;;;;;;;;;;;;;;;;;;;;;;;;;;;;        
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


PROLOGUE_SQ1:
    .byte DUTY_25
    .byte TEMPO,$02
    PRLOOP0:
    PRLOOP0A:
    .byte SPEED_SET,$81,INSTRUMENT,$0E,OCTAVE_4,$05,$55,$75,$05,$A3,$95,$75,$55,$47,$57,$75
    .byte $55,$53,$43,$25,$75,$95,$25,OCTAVE_5,$03,OCTAVE_4,$A5,$95,$75,$67,$97,$75
    .byte $25,$93,$73
    .byte LOOP_X,$01
    .word PRLOOP0A
    .byte OCTAVE_5,$22,$25,$02,OCTAVE_4,$95,$A5,$A7,$97,$75
    .byte $65,$75,$95,$A5,OCTAVE_5,$05,$32,$35,$22,OCTAVE_4,$A5,OCTAVE_5,$05,$07,$17,$05
    .byte $07,$17,$05,OCTAVE_4,$A5,$95,$75
    .byte LOOP_FOREVER
    .word PRLOOP0

PROLOGUE_SQ2:
    .byte DUTY_12
    .byte TEMPO,$02
    PRLOOP1:
    PRLOOP1A:
    .byte SPEED_SET,$81,INSTRUMENT,$0A,OCTAVE_3,$02,$27,$47,$55,$25,$45,$75,$25,$47,$57,$75
    .byte $77,$97,$A3,$73,$73,$65,$77,$97,$A5,$75,$65,OCTAVE_4,$05,OCTAVE_3,$A3,$B3
    .byte OCTAVE_4,$03,OCTAVE_3,$A3
    .byte LOOP_X,$01
    .word PRLOOP1A
    .byte $A7,$97,$77,$97,$A7,$C7,$45,$97,$77
    .byte $57,$77,$97,$C7,$55,$75,$35,$25,$05,$23,$75,$95,OCTAVE_4,$03,OCTAVE_3,$83
    .byte $A3,$73,$53,$57,$77,$87,$57,$73,$43
    .byte LOOP_FOREVER
    .word PRLOOP1

PROLOGUE_SQ3:
    .byte VOLUME_HALF,VOLUME_MINUS,$02,TEMPO,$02,$C4,LOOP_FOREVER
    .word PROLOGUE_SQ1

PROLOGUE_SQ4:
    .byte VOLUME_QRTR,TEMPO,$02,$C5,LOOP_FOREVER
    .word PROLOGUE_SQ2


PROLOGUE_TRI:
    .byte TEMPO,$02
    PRLOOP2:
    PRLOOP2A:
    .byte OCTAVE_3,$53,$43,$23,$03,OCTAVE_2,$A3,$B3,OCTAVE_3,$01,$A3,$93
    .byte $73,$63,$73,$53,$43,$03
    .byte LOOP_X,$01
    .word PRLOOP2A
    .byte $A2,$A5,$52,$55,$33,$23,$73
    .byte $53,$83,$33,$23,$73,$83,OCTAVE_4,$13,$03,OCTAVE_3,$A3
    .byte LOOP_FOREVER
    .word PRLOOP2

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;           EPILOGUE                               ;;;;;;;;;;;;;;;;;;;;;;;;;;;;        
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


EPILOGUE_SQ1:
    .byte DUTY_25
    .byte TEMPO,$03,SPEED_SET,$01,INSTRUMENT,$0E,OCTAVE_2,$05,$25,$75,$95,OCTAVE_3,$05,$25,$75,$95,$B5,OCTAVE_4
    .byte $25,$75,OCTAVE_3,$B5,OCTAVE_4,$05,$45,$75,$05,$25,$65,$95,$25,$05,$45,$75
    .byte $05,OCTAVE_3,$B5,OCTAVE_4,$25,$75,OCTAVE_3,$B5,OCTAVE_4,$05,$45,$75,$05,$25,$65,$95
    .byte $25,$05,TEMPO,$02,$45,TEMPO,$04,$74,TEMPO,$01,$05
    ELOOP0A:
    .byte TEMPO,$03,OCTAVE_3,$B3,OCTAVE_4,$23,OCTAVE_3,$93,$B5
    .byte OCTAVE_4,$05,OCTAVE_3,$B5,$95,$71,$73,OCTAVE_4,$02,$05,OCTAVE_3,$73,$93,$B1,$91,$B3
    .byte OCTAVE_4,$23,OCTAVE_3,$93,$B5,OCTAVE_4,$05,OCTAVE_3,$B5,$95,$71,$73,OCTAVE_4,$02,$05,OCTAVE_3
    .byte $73,$93,$71,$65,$B5,OCTAVE_4,$35,$65,$73,$65,$45,$21,$43,$25,$05,OCTAVE_3
    .byte $B1,OCTAVE_4,$03,OCTAVE_3,$B5,$95,$75,$95,$B5,$45,$73,$95,$75,$61,OCTAVE_4,$73
    .byte $65,$45,$21,$43,$25,$05,OCTAVE_3,$B3,OCTAVE_4,$05,$25,$41,$C5,$05,$25,$45
    .byte $41,$21,$C7
    .byte LOOP_X,$04
    .word ELOOP0A
    .byte TEMPO,$03,OCTAVE_3,$B3,OCTAVE_4,$23,OCTAVE_3,$93,$B5,OCTAVE_4,$05
    .byte OCTAVE_3,$B5,$95,$71,$73,OCTAVE_4,$02,$05,OCTAVE_3,$73,$93,$B1,$91,$B3,OCTAVE_4,$23
    .byte OCTAVE_3,$93,$B5,OCTAVE_4,$05,OCTAVE_3,$B5,$95,$71,$73,OCTAVE_4,$02,$05,OCTAVE_3,$73,$93
    .byte $71,OCTAVE_4,$21,TEMPO,$02,$02,$05,TEMPO,$03,OCTAVE_3,$72,$92,$70,$C1,END_SONG

EPILOGUE_SQ2:
    .byte DUTY_12
    .byte TEMPO,$03,SPEED_SET,$01,INSTRUMENT,$0E,$C1,$C1,OCTAVE_3,$25,$75,$B5,$25,$45,$75,OCTAVE_4,$05,OCTAVE_3
    .byte $45,$65,$95,OCTAVE_4,$25,OCTAVE_3,$65,$45,$75,OCTAVE_4,$05,OCTAVE_3,$45,$25,$75,$B5
    .byte $25,$45,$75,OCTAVE_4,$05,OCTAVE_3,$45,$65,$95,OCTAVE_4,$25,OCTAVE_3,$65,$45,TEMPO,$02,$75
    .byte OCTAVE_4,TEMPO,$04,$04,OCTAVE_3,TEMPO,$01,$75
    ELOOP1A:
    .byte TEMPO,$03,$21,$01,$20,$01,$33,$03,$63,$21,$01
    .byte $21,$01,$20,$01,$33,$03,$63,$21,$33,OCTAVE_2,$B3,OCTAVE_3,$41,$63,$45,$25
    .byte $01,$23,$05,OCTAVE_2,$B5,$93,OCTAVE_3,$43,$23,OCTAVE_2,$B3,OCTAVE_3,$13,OCTAVE_2,$B5,OCTAVE_3
    .byte $15,$33,OCTAVE_2,$B3,OCTAVE_3,$41,$63,$45,$25,$01,$23,$05,OCTAVE_2,$B5,$93,OCTAVE_3
    .byte $43,$03,$93,$71,$61,$C7
    .byte LOOP_X,$04
    .word ELOOP1A
    .byte TEMPO,$03,$21,$01,$20,$01,$33,$03
    .byte $63,$21,$01,$21,$01,$20,$01,$33,$03,$63,$21,$53,$23,TEMPO,$02,$35,$55
    .byte $75,$35,TEMPO,$03,$24,$04,OCTAVE_2,$B4,$94,$B2,$92,$70,END_SONG

EPILOGUE_SQ3:
    .byte VOLUME_HALF,VOLUME_MINUS,$02,TEMPO,$03,$C4,LOOP_FOREVER
    .word EPILOGUE_SQ1

EPILOGUE_SQ4:
    .byte VOLUME_QRTR,TEMPO,$03,$C5,LOOP_FOREVER
    .word EPILOGUE_SQ2

EPILOGUE_TRI:

    .byte TEMPO,$03,$C1,$C1,OCTAVE_3,$71,$71,$71,$71,$71,$71,$71,OCTAVE_4,$05
    .byte TEMPO,$02,OCTAVE_3,$B5,TEMPO,$04,$94,TEMPO,$01,$75

    ELOOP2A:
    .byte TEMPO,$03,$71,$61,$51,$41,$31,$23,$03,$71
    .byte $23,$03,$71,$61,$51,$41,$31,$23,$03,OCTAVE_2,$B1,OCTAVE_3,$61,$71,$61,$41
    .byte $71,$51,$41,$41,$61,$71,$61,$41,$71,$51,$51,$91,$21,$C7
    .byte LOOP_X,$04
    .word ELOOP2A
    .byte TEMPO,$03,$71,$61,$51,$41,$31,$23,$03,$71,$23,$03,$71,$61,$51,$41
    .byte $31,$23,$03,OCTAVE_2,$B1,OCTAVE_3,$73,$53,TEMPO,$02,$75,$95,$A5,OCTAVE_4,$05,TEMPO,$03,OCTAVE_3
    .byte $92,$62,$72,$22,OCTAVE_2,$70,END_SONG

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;                 OVERWORLD                        ;;;;;;;;;;;;;;;;;;;;;;;;;;;;        
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


OVERWORLD_SQ1:
    .byte DUTY_25
    .byte TEMPO,$02
    OLOOP0:
    .byte SPEED_SET,$01,INSTRUMENT,$0C,$C5,OCTAVE_3,$B5,$95,$B5,OCTAVE_4,$05,OCTAVE_3,$B5,$95,$B5,SPEED_SET,$04
    .byte OCTAVE_4,$23,OCTAVE_3,$90,SPEED_SET,$01,$C5,OCTAVE_4,$05,OCTAVE_3,$B5,OCTAVE_4,$05,$25,$05
    .byte OCTAVE_3,$B5,OCTAVE_4,$05,SPEED_SET,$04,$43,OCTAVE_3,$B0,SPEED_SET,$01,$C5,OCTAVE_4,$45,$65,$75
    .byte $65,$45,$25,$05,$25,OCTAVE_3,$95,$B5,OCTAVE_4,$05,OCTAVE_3,$B3,$C7,$87,$97,$B7
    .byte OCTAVE_4,$02,$25,$05,OCTAVE_3,$B5,$95,$75,SPEED_SET,$04,OCTAVE_4,$20,$C3
    .byte LOOP_FOREVER
    .word OLOOP0

OVERWORLD_SQ2:
    .byte DUTY_12
    .byte TEMPO,$02
    OLOOP1:
    .byte SPEED_SET,$01,INSTRUMENT,$0E,$C5,OCTAVE_3,$25,$05,$25,$45,$25,$05,OCTAVE_2,$B5,$91,OCTAVE_3
    .byte $65,$45,$25,$05,OCTAVE_2,$95,OCTAVE_3,$45,$25,$45,$65,$45,$25,$05,OCTAVE_2,$B1
    .byte OCTAVE_3,$85,$65,$45,$25,SPEED_SET,$82,INSTRUMENT,$01,$C7,$47,$77,$47,$C7,$47,$77,$47
    .byte $C7,$67,$97,$67,$C7,$67,$97,$67,$C7,$27,$57,$27,$C7,$27,$57,$27
    .byte $C7,OCTAVE_2,$B7,OCTAVE_3,$47,OCTAVE_2,$B7,$C7,$B7,OCTAVE_3,$47,OCTAVE_2,$B7,$C7,OCTAVE_3,$07
    .byte $47,$07,$C7,$07,$47,$07,$C7,OCTAVE_2,$97,OCTAVE_3,$07,OCTAVE_2,$97,$C7,$97,OCTAVE_3
    .byte $07,OCTAVE_2,$97,OCTAVE_3,$27,$57,$27,$57,$27,$57,$27,$57,$27,$67,$27,$67
    .byte $27,$67,$27,$67
    .byte LOOP_FOREVER
    .word OLOOP1

OVERWORLD_SQ3:
    .byte VOLUME_QRTR,TEMPO,$02,$C5,LOOP_FOREVER
    .word OVERWORLD_SQ1

OVERWORLD_SQ4:
    .byte VOLUME_QRTR,TEMPO,$02,$C5,LOOP_FOREVER
    .word OVERWORLD_SQ2

OVERWORLD_TRI:
    .byte TEMPO,$02
    OLOOP2:
    .byte OCTAVE_3,$79,$C9,$79,$C6,$29,$C9,$79,$C9,$79,$C6,$29
    .byte $C9,$79,$C9,$79,$C6,$29,$C9,$79,$C9,$79,$C6,$29,$C9,$69,$C9,$69
    .byte $C6,$29,$C9,$69,$C9,$69,$C6,$29,$C9,$69,$C9,$69,$C6,$29,$C9,$69
    .byte $C9,$69,$C6,$29,$C9,$99,$C9,$99,$C6,$49,$C9,$99,$C9,$99,$C6,$49
    .byte $C9,$99,$C9,$99,$C6,$49,$C9,$99,$C9,$99,$C6,$49,$C9,$89,$C9,$89
    .byte $C6,$49,$C9,$89,$C9,$89,$C6,$49,$C9,$89,$C9,$89,$C6,$49,$C9,$89
    .byte $C9,$89,$C6,$49,$C9,OCTAVE_4,$09,$C9,OCTAVE_3,$79,$C9,OCTAVE_4,$09,$C9,OCTAVE_3,$79
    .byte $C9,OCTAVE_4,$09,$C9,OCTAVE_3,$79,$C9,OCTAVE_4,$09,$C9,OCTAVE_3,$79,$C9,OCTAVE_4,$29,$C9
    .byte OCTAVE_3,$99,$C9,OCTAVE_4,$29,$C9,OCTAVE_3,$99,$C9,OCTAVE_4,$29,$C9,OCTAVE_3,$99,$C9,OCTAVE_4
    .byte $29,$C9,OCTAVE_3,$99,$C9,$B9,$C9,$59,$C9,$B9,$C9,$59,$C9,$B9,$C9,$59
    .byte $C9,$B9,$C9,$59,$C9,OCTAVE_4,$49,$C9,OCTAVE_3,$B9,$C9,OCTAVE_4,$49,$C9,OCTAVE_3,$B9
    .byte $C9,OCTAVE_4,$49,$C9,OCTAVE_3,$B9,$C9,OCTAVE_4,$49,$C9,OCTAVE_3,$B9,$C9,$99,$C9,$99
    .byte $C6,OCTAVE_4,$49,$C9,OCTAVE_3,$99,$C9,$99,$C6,OCTAVE_4,$49,$C9,OCTAVE_3,$59,$C9,$59
    .byte $C6,OCTAVE_4,$59,$C9,OCTAVE_3,$59,$C9,$59,$C6,OCTAVE_4,$59,$C9,OCTAVE_3,$A9,$C9,OCTAVE_4
    .byte $A9,$C9,OCTAVE_3,$A9,$C9,OCTAVE_4,$A9,$C9,OCTAVE_3,$A9,$C9,OCTAVE_4,$A9,$C9,OCTAVE_3,$A9
    .byte $C9,OCTAVE_4,$A9,$C9,$25,$05,OCTAVE_3,$B5,$95
    .byte LOOP_FOREVER
    .word OLOOP2
    
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;                 SHIP                             ;;;;;;;;;;;;;;;;;;;;;;;;;;;;        
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    

SHIP_SQ1:
    .byte DUTY_25
    .byte TEMPO,$02,SPEED_SET,$01,INSTRUMENT,$0E,OCTAVE_3,$95,$A5
    SLOOP0:
    .byte OCTAVE_4,$01,$C3,$77,$57,$47,$57,$22,OCTAVE_3
    .byte $A5,$73,OCTAVE_4,$57,$47,$27,$47,$02,OCTAVE_3,$95,$63,OCTAVE_4,$27,$07,OCTAVE_3,$A7
    .byte $97,$A3,$C7,$77,$97,$A7,OCTAVE_4,$03,OCTAVE_3,$95,$A5,OCTAVE_4,$01,$03,$77,$57
    .byte $47,$57,$22,OCTAVE_3,$A5,$73,OCTAVE_4,$57,$47,$27,$47,$02,OCTAVE_3,$95,$63,OCTAVE_4
    .byte $27,$07,OCTAVE_3,$A7,$97,$A3,$A7,$77,$97,$A7,OCTAVE_4,$01,$C5,$05,$25,$45
    .byte $75,$55,$45,$55,$43,$05,OCTAVE_3,$95,OCTAVE_4,$21,$C5,$25,$45,$55,$75,$55
    .byte $45,$55,$73,$25,$95,$73,OCTAVE_3,$95,$A5
    .byte LOOP_FOREVER
    .word SLOOP0

SHIP_SQ2:
    .byte DUTY_12
    .byte TEMPO,$02,SPEED_SET,$01,INSTRUMENT,$02,$C3
    SLOOP1:
    SLOOP1A:
    .byte SPEED_SET,$86,INSTRUMENT,$02,$C7,OCTAVE_3,$59,$C9,$47,$59,$C6,$59
    .byte $C9,$47,$59,$C9,$C7,$59,$C9,$47,$59,$C6,$59,$C9,$47,$59,$C9,$C7
    .byte $29,$C9,$07,$29,$C6,$29,$C9,$07,$29,$C9,$C7,$09,$C9,OCTAVE_2,$A7,OCTAVE_3
    .byte $09,$C6,$09,$C9,OCTAVE_2,$A7,OCTAVE_3,$09,$C9,$C7,$09,$C9,OCTAVE_2,$97,OCTAVE_3,$09
    .byte $C6,$09,$C9,OCTAVE_2,$97,OCTAVE_3,$09,$C9,$C7,$29,$C9,$07,$29,$C6,$29,$C9
    .byte $07,$29,$C9,$C7,$39,$C9,$27,$39,$C6,$39,$C9,$27,$39,$C9,$C7,$49
    .byte $C9,$27,$49,$C6,$49,$C9,$27,$49,$C9
    .byte LOOP_X,$01
    .word SLOOP1A
    .byte SPEED_SET,$84,INSTRUMENT,$02,$09
    .byte $C9,$49,$C9,$29,$C9,$49,$C9,$09,$09,$49,$C9,$29,$C9,$49,$C9
    .byte $29
    .byte $C9,$59,$C9,$49,$C9,$59,$C9,$29,$29,$59,$C9,$49,$C9,$59,$C9,$09
    .byte $C9,$49,$C9,$29,$C9,$49,$C9,$09,$09,$49,$C9,$29,$C9,$49,$C9,$29
    .byte $C9,$59,$C9,$49,$C9,$59,$C9,$29,$29,$59,$C9,$49,$C9,$59,$C9
    SLOOP1B:
    .byte $29
    .byte $C9,$59,$C9,$49,$C9,$59,$C9,$29,$29,$59,$C9,$49,$C9,$59,$C9
    .byte LOOP_X,$02
    .word SLOOP1B
    .byte $79,$C9,$79,$C9,$C7,$79,$C9,$C7,$79,$C9,$C7,$79,$C9
    .byte LOOP_FOREVER
    .word SLOOP1

SHIP_SQ3:
    .byte VOLUME_HALF,VOLUME_MINUS,$02,TEMPO,$02,$C4,LOOP_FOREVER
    .word SHIP_SQ1

SHIP_SQ4:
    .byte VOLUME_QRTR,TEMPO,$02,$C5,LOOP_FOREVER
    .word SHIP_SQ2


SHIP_TRI:
    .byte TEMPO,$02,$C3
    SLOOP2:
    SLOOP2A:
    .byte OCTAVE_3,$57,OCTAVE_4,$09,$C9,OCTAVE_3,$57,OCTAVE_4,$09,$C9,OCTAVE_3
    .byte $57,OCTAVE_4,$09,$C9,OCTAVE_3,$57,OCTAVE_4,$09,$C9,OCTAVE_3,$27,$99,$C9,$27,$99,$C9
    .byte $27,$99,$C9,$27,$99,$C9,OCTAVE_2,$A7,OCTAVE_3,$59,$C9,OCTAVE_2,$A7,OCTAVE_3,$59,$C9
    .byte OCTAVE_2,$A7,OCTAVE_3,$59,$C9,OCTAVE_2,$A7,OCTAVE_3,$59,$C9,$07,$79,$C9,$07,$79,$C9
    .byte $07,$79,$C9,$07,$79,$C9,OCTAVE_2,$97,OCTAVE_3,$49,$C9,OCTAVE_2,$97,OCTAVE_3,$49,$C9
    .byte OCTAVE_2,$97,OCTAVE_3,$49,$C9,OCTAVE_2,$97,OCTAVE_3,$49,$C9,$27,$99,$C9,$27,$99,$C9
    .byte $27,$99,$C9,$27,$99,$C9,$37,$A9,$C9,$37,$A9,$C9,$37,$A9,$C9,$37
    .byte $A9,$C9,$07,$79,$C9,$07,$79,$C9,$07,$79,$C9,$07,$79,$C9
    .byte LOOP_X,$01
    .word SLOOP2A
    SLOOP2B:
    .byte OCTAVE_2,$99,$C9,$99,$C9,$C4,OCTAVE_3,$49,$C9,$99,$C9,$49,$C9,$29,$C9
    .byte $29,$C9,$C4,$59,$C9,$99,$C9,$59,$C9
    .byte LOOP_X,$01
    .word SLOOP2B
    .byte OCTAVE_2,$A9,$C9,$A9
    .byte $C9,$C4,OCTAVE_3,$59,$C9,$A9,$C9,$59,$C9,OCTAVE_2,$79,$C9,$79,$C9,$C4,OCTAVE_3
    .byte $29,$C9,$79,$C9,$29,$C9,OCTAVE_2,$B9,$C9,$B9,$C9,$C4,OCTAVE_3,$29,$C9,$79
    .byte $C9,$29,$C9,$07,$79,$C9,$27,$79,$C9,$37,$A9,$C9,$47,$A9,$C9
    .byte LOOP_FOREVER
    .word SLOOP2
    
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;                 AIRSHIP                          ;;;;;;;;;;;;;;;;;;;;;;;;;;;;        
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    

AIRSHIP_SQ1:
    .byte DUTY_25
    .byte TEMPO,$03
    ALOOP0:
    .byte SPEED_SET,$84,INSTRUMENT,$0B,OCTAVE_4,$05,$55,$75,$A5,$97,$77,$57,$97,$75,$07,$27
    .byte $34,SPEED_SET,$02,$01,$C7,$C3,SPEED_SET,$84,$05,$55,$75,$A5,$97,$77
    .byte $57,$97,$75,$37,$57,$74,SPEED_SET,$02,OCTAVE_5,$01,SPEED_SET,$86,INSTRUMENT,$01,$C7,OCTAVE_3
    .byte $A9,OCTAVE_4,$09,$29,$39,$59,$79,$89,$99,SPEED_SET,$84,$A7,$87,$57,$A7
    .byte $87,$C7,$37,$57,$A7,$87,$57,$A7,$87,$C4,$A7,$87,$57,$A7,$87,$C7
    .byte $37,$57,$A7,$87,$57,$A7,$87,$C4,$77,$57,$27,$77,$57,$C7,$07,$37
    .byte $57,$27,OCTAVE_3,$A7,OCTAVE_4,$57,$37,$C7,OCTAVE_3,$A7,OCTAVE_4,$17,SPEED_SET,$02,INSTRUMENT,$0B,$03
    .byte SPEED_SET,$86,INSTRUMENT,$01,$47,$09,$49,$77,$49,$79,SPEED_SET,$01,INSTRUMENT,$0E,OCTAVE_5,$01
    .byte LOOP_FOREVER
    .word ALOOP0

AIRSHIP_SQ2:
    .byte DUTY_12
    .byte TEMPO,$03
    ALOOP1:
    .byte SPEED_SET,$81,INSTRUMENT,$0B
    ALOOP1A:
    .byte OCTAVE_3,$93,$73
    .byte LOOP_X,$07
    .word ALOOP1A
    .byte OCTAVE_4,$23,$03,$23,SPEED_SET,$84
    .byte INSTRUMENT,$02,OCTAVE_3,$09,$29,$39,$89,OCTAVE_4,$09,$29,$39,$89,SPEED_SET,$81,INSTRUMENT,$0B,$23,$03
    .byte $23,SPEED_SET,$84,INSTRUMENT,$02,OCTAVE_3,$09,$79,OCTAVE_4,$29,$99,OCTAVE_3,$29,$99,OCTAVE_4,$49,$B9
    .byte SPEED_SET,$81,INSTRUMENT,$0B,OCTAVE_3,$B3,$83,$53,$83,SPEED_SET,$84,INSTRUMENT,$02,$A7,$A7,$97,$A7,$C7
    .byte $A7,$97,$A7,$77,$77,$47,$77,$C7,$77,$47,$77
    .byte LOOP_FOREVER
    .word ALOOP1

AIRSHIP_SQ3:
    .byte VOLUME_QRTR,TEMPO,$03,$C5,LOOP_FOREVER
    .word AIRSHIP_SQ1

AIRSHIP_SQ4:
    .byte VOLUME_QRTR,TEMPO,$03,$C5,LOOP_FOREVER
    .word AIRSHIP_SQ2

AIRSHIP_TRI:
    .byte TEMPO,$03
    ALOOP2:
    .byte OCTAVE_3,$57,OCTAVE_4,$07,OCTAVE_3,$57,OCTAVE_4,$07,OCTAVE_3,$37,$A7,$37
    .byte $A7,$57,OCTAVE_4,$07,OCTAVE_3,$57,OCTAVE_4,$07,OCTAVE_3,$37,$A7,$37,$A7,$57,OCTAVE_4,$07
    .byte OCTAVE_3,$57,OCTAVE_4,$07,OCTAVE_3,$37,$A7,$37,$A7,$57,OCTAVE_4,$07,OCTAVE_3,$57,OCTAVE_4,$07
    .byte OCTAVE_3,$37,$A7,$37,$A7
    .byte LOOP_X,$01
    .word ALOOP2
    ALOOP2A:
    .byte $A7,OCTAVE_4,$57,OCTAVE_3,$A7,OCTAVE_4,$57,OCTAVE_3
    .byte $87,OCTAVE_4,$37,OCTAVE_3,$87,OCTAVE_4,$37,OCTAVE_3,$A7,OCTAVE_4,$57,OCTAVE_3,$A7,OCTAVE_4,$57,OCTAVE_3
    .byte $87,$C4
    .byte LOOP_X,$01
    .word ALOOP2A
    .byte $77,OCTAVE_4,$27,$C7,$27,OCTAVE_3,$87,OCTAVE_4,$37,$C7,$37
    .byte OCTAVE_3,$A7,OCTAVE_4,$27,$C7,$27,$17,$57,$C7,$57,$75,$55,$45,$25,$05,OCTAVE_3
    .byte $A5,$95,$75
    .byte LOOP_FOREVER
    .word ALOOP2

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;                 TOWN                             ;;;;;;;;;;;;;;;;;;;;;;;;;;;;        
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


TOWN_SQ1:
    .byte DUTY_25
    .byte TEMPO,$03
    TLOOP0:
    .byte SPEED_SET,$01,INSTRUMENT,$0E,OCTAVE_4,$43,$73,$23,$45,$55,$45,$25,$01,$03,$92,$95
    .byte $75,$25,$45,$55,$40,$43,OCTAVE_5,$02,$05,$03,OCTAVE_4,$B5,$95,$75,$25,$45
    .byte $55,$43,$03,$21,$25,OCTAVE_3,$A5,OCTAVE_4,$05,$25,$01,OCTAVE_3,$B3,OCTAVE_4,$05,$25
    .byte LOOP_FOREVER
    .word TLOOP0

TOWN_SQ2:
    .byte DUTY_12
    .byte TEMPO,$03
    TLOOP1:
    .byte SPEED_SET,$84,INSTRUMENT,$02,OCTAVE_3,$45,OCTAVE_4,$05,OCTAVE_3,$75,$45,$25,$75,$B5,$25,$05
    .byte $95,$45,$05,$45,$75,OCTAVE_4,$05,OCTAVE_3,$45,$05,$95,$55,$05,OCTAVE_2,$B5,OCTAVE_3
    .byte $25,$75,$B5,$45,OCTAVE_4,$05,OCTAVE_3,$75,$45,$25,$45,$85,$B5,SPEED_SET,$01,INSTRUMENT,$0E
    .byte OCTAVE_4,$41,$63,$23,OCTAVE_3,$B1,OCTAVE_4,$05,OCTAVE_3,$B5,$95,$75,$51,$C1,$70,$53
    .byte LOOP_FOREVER
    .word TLOOP1

TOWN_SQ3:
    .byte VOLUME_QRTR,TEMPO,$03,$C4,LOOP_FOREVER
    .word TOWN_SQ1

TOWN_SQ4:
    .byte VOLUME_QRTR,TEMPO,$03,$C5,LOOP_FOREVER
    .word TOWN_SQ2

TOWN_TRI:
    .byte TEMPO,$03
    TLOOP2:
    .byte OCTAVE_4,$01,OCTAVE_3,$B1,$91,$71,$51,$51,OCTAVE_4,$01,OCTAVE_3,$41
    .byte $95,OCTAVE_4,$45,$95,$45,$23,$63,OCTAVE_3,$75,OCTAVE_4,$25,$75,$25,$03,OCTAVE_3,$03
    .byte OCTAVE_2,$A5,OCTAVE_3,$55,$A5,OCTAVE_4,$05,$21,OCTAVE_2,$75,OCTAVE_3,$25,$75,$95,$B5,$95
    .byte $73
    .byte LOOP_FOREVER
    .word TLOOP2
    
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;                 CASTLE                           ;;;;;;;;;;;;;;;;;;;;;;;;;;;;        
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    

CASTLE_SQ1:
    .byte DUTY_25
    .byte TEMPO,$04
    CLOOP0:
    .byte SPEED_SET,$01,INSTRUMENT,$0E,OCTAVE_4,$62,$65,$75,$65,$45,$25,$43
    .byte OCTAVE_3,$90,OCTAVE_4,$22,$25,$45,$25,$15,OCTAVE_3,$B5,OCTAVE_4,$13,OCTAVE_3,$60,$B2,OCTAVE_4
    .byte $15,$23,$43,$63,$73,$93,$75,$65,$43,OCTAVE_3,$B2,$B5,OCTAVE_4,$15,$25,$61
    .byte $41
    .byte LOOP_FOREVER
    .word CLOOP0

CASTLE_SQ2:
    .byte DUTY_12
    .byte TEMPO,$04
    CLOOP1:
    .byte SPEED_SET,$01,INSTRUMENT,$0B,OCTAVE_2,$95,OCTAVE_3,$65,$25,$65,OCTAVE_2,$95
    .byte OCTAVE_3,$65,$25,$65,$15,$45,OCTAVE_2,$95,OCTAVE_3,$45,OCTAVE_2,$B5,OCTAVE_3,$45,$15,$45
    .byte OCTAVE_2,$B5,OCTAVE_3,$65,$25,$65,OCTAVE_2,$B5,OCTAVE_3,$65,$25,$65,OCTAVE_2,$A5,OCTAVE_3,$15
    .byte OCTAVE_2,$65,OCTAVE_3,$15,OCTAVE_2,$85,OCTAVE_3,$15,OCTAVE_2,$A5,OCTAVE_3,$15,OCTAVE_2,$B5,OCTAVE_3,$75
    .byte $25,$75,OCTAVE_2,$A5,OCTAVE_3,$75,$25,$75,$25,$95,$45,$95,$35,$B5,OCTAVE_2,$B5
    .byte OCTAVE_3,$35,$B5,$95,$75,$65,$41,$25,OCTAVE_4,$25,$15,OCTAVE_3,$B5,$95,$75,$65
    .byte $45
    .byte LOOP_FOREVER
    .word CLOOP1

CASTLE_SQ3:
    .byte VOLUME_QRTR,TEMPO,$04,$C4,LOOP_FOREVER
    .word CASTLE_SQ1

CASTLE_SQ4:
    .byte VOLUME_QRTR,TEMPO,$04,$C5,LOOP_FOREVER
    .word CASTLE_SQ2

CASTLE_TRI:
    .byte TEMPO,$04
    CLOOP2:
    .byte OCTAVE_4,$21,$21,$11,$11,OCTAVE_3,$B1,$B1
    .byte $A1,$A1,$71,$71,OCTAVE_4,$21,OCTAVE_3,$B1,OCTAVE_4,$41,$41,OCTAVE_3,$91,$91
    .byte LOOP_FOREVER
    .word CLOOP2
    
    
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;           RUINED CASTLE (GBA)                    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;        
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



RUINEDCASTLE_SQ1:
    .byte TEMPO,$05        ; tempo
    .byte INSTRUMENT,$0D   ; envelope
    .byte $C8              ; all tracks have this delay
    .byte SPEED_SET,$03    ; envelope speed
    .byte DUTY_25          ; duty 25%

    RC_SQ1_PAUSE:
    .byte $C0
    RC_SQ1_PAUSE_LONG:
    .byte $C0,$C0,$C0,$C0,$C0,$C0,$C0,$C0,$C0,$C0,$C0
    ;; do nothing for 12 4/4 bars, or 16 3/4 bars

;   ;; JIGS SONG v  -- only delete this block to remove my custom content
;   RC_SQ1_ALTMELODY: ; (2 bars each line... mostly)
;   .byte SPEED_SET,$0D
;   .byte OCTAVE_3,$50,$C6,$97,$27,$57,$97
;   .byte OCTAVE_4,$40,$C6,$26,$16,OCTAVE_3,$96
;   .byte $60,$C6,$77,$27,$47,$67
;   .byte $21,$13,OCTAVE_2,$76,$A6,$76
;   .byte OCTAVE_3,$20,$C6,OCTAVE_2,$96,OCTAVE_3,$06,OCTAVE_2,$96
;   .byte OCTAVE_3,$30,$36,$46,$64
;   .byte $71,$74,$94,$B4
;   .byte $A4,$94,$74,OCTAVE_4,$13,OCTAVE_3,$93
;   .byte OCTAVE_4,$22,INSTRUMENT,$03,$2A,$4A,$5A,$7A,$9A,$BA,OCTAVE_5,$0A,$2A,SPEED_SET,$0C,INSTRUMENT,$0D,$21
;   .byte SPEED_SET,$0D
;   .byte INSTRUMENT,$03,SCORE_GOTO
;   .word RC_SQ1_MELODY_TRILL_2 ; 1, 2
;   .byte INSTRUMENT,$02,SCORE_GOTO
;   .word RC_SQ1_MELODY_TRILL_2 ; 3, 4
;   .byte INSTRUMENT,$01,SCORE_GOTO
;   .word RC_SQ1_MELODY_TRILL   ; 5
;   .byte INSTRUMENT,$0D,SCORE_GOTO
;   .word RC_SQ1_MELODY_TRILL   ; 6
;   .byte OCTAVE_3,$B2,INSTRUMENT,$03,$BA,OCTAVE_4,$0A,$2A,$4A,$5A,$7A,$9A,$BA,INSTRUMENT,$0D,$B0,$C4
;   .byte OCTAVE_3,INSTRUMENT,$03,$AA,OCTAVE_4,$0A,$2A,$4A,$5A,$7A,$9A,$AA,INSTRUMENT,$0D
;   .byte VOLUME_MINUS,$03,$A4,VOLUME_MINUS,$02,$94,VOLUME_MINUS,$01,$84,VOLUME_MINUS,$00,$73,$23
;   .byte $64,$24,$14,$23,OCTAVE_3,$93
;   .byte OCTAVE_4,$04,OCTAVE_3,$B4,$94,$73,$23
;   .byte $A4,$94,$74,$93,$43
;   .byte $74,$94,$54,$60,LOOP_FOREVER
;   .word RC_SQ1_PAUSE_LONG
;
;   RC_SQ1_MELODY_TRILL_2:
;   .byte OCTAVE_4,$28,$18,OCTAVE_3,$98,OCTAVE_4,$18
;   RC_SQ1_MELODY_TRILL:
;   .byte OCTAVE_4,$28,$18,OCTAVE_3,$98,OCTAVE_4,$18,SCORE_RETURN
;   ;; JIGS SONG ^

 ; original Castle theme from the GBA version
   RC_SQ1_MELODY:
   .byte OCTAVE_4,$61,$75,$65,$45,$25,$43,OCTAVE_3,$90,$C6
   .byte OCTAVE_4,$21,$45,$25,$15,OCTAVE_3,$B5,OCTAVE_4,$13,OCTAVE_3,$60,$C6
   .byte $B2,$C8,OCTAVE_4,$15,$23,$43,$63,$73,$93,$75,$65,$43
   .byte OCTAVE_3,$B1,OCTAVE_4,$15,$25,$61,$41,LOOP_X,$01
   .word RC_SQ1_MELODY
   .byte LOOP_FOREVER
   .word RC_SQ1_PAUSE

RUINEDCASTLE_SQ2:
    .byte TEMPO,$05
    .byte SPEED_SET,$03    ; envelope speed
    .byte DUTY_50          ; duty 50%
    .byte $C8              ; all tracks have this delay
    .byte OCTAVE_3         ; octave

    RC_SQ2_LOOP:
    .byte INSTRUMENT,$10   ; echoey boops 
    .byte $9F              ; A
    .byte $9F
    .byte $9F
    .byte INSTRUMENT,$11   ; louder
    .byte $AF              ; B flat
    .byte $7F              ; G
    .byte INSTRUMENT,$10   ; softer
    .byte $9F              ; A
    .byte $7F              ; G
    .byte INSTRUMENT,$11   ; louder
    .byte $9F              ; A
    .byte LOOP_FOREVER
    .word RC_SQ2_LOOP
  

RUINEDCASTLE_TRI:
    .byte TEMPO,$05
    .byte $C8             ; all tracks have this delay

    RC_TRI_BAR1_2:
    .byte OCTAVE_3,$26,$C8,$96,$C8,OCTAVE_4,$26,$C4,LOOP_X,$01
    .word RC_TRI_BAR1_2

    RC_TRI_BAR3_4:
    .byte OCTAVE_3,$16,$C8,$86,$C8,OCTAVE_4,$16,$C4,LOOP_X,$01
    .word RC_TRI_BAR3_4

    RC_TRI_BAR5_6:
    .byte OCTAVE_2,$B6,$C8,OCTAVE_3,$66,$C8,$B6,$C4,LOOP_X,$01
    .word RC_TRI_BAR5_6

    RC_TRI_BAR7_8:
    .byte OCTAVE_2,$A6,$C8,OCTAVE_3,$56,$C8,$A6,$C4,LOOP_X,$01
    .word RC_TRI_BAR7_8

    .byte SCORE_GOTO      ; goto
    .word RC_TRI_BAR9_10

    .byte OCTAVE_2,$B6,$C8,OCTAVE_3,$66,$C8,$B6,$C4 ; bar 11
    .byte OCTAVE_2,$66,$C8,OCTAVE_3,$16,$C8,$66,$C4 ; bar 12

    .byte SCORE_GOTO      ; goto
    .word RC_TRI_BAR9_10  ; bar 13, 14

    RC_TRI_BAR15_16:
    .byte OCTAVE_2,$96,$C8,OCTAVE_3,$46,$C8,$96,$C4,LOOP_X,$01
    .word RC_TRI_BAR15_16

    .byte LOOP_FOREVER    ; loop forever
    .word RC_TRI_BAR1_2

    RC_TRI_BAR9_10:
    .byte OCTAVE_2,$76,$C8,OCTAVE_3,$26,$C8,$76,$C4,LOOP_X,$01
    .word RC_TRI_BAR9_10
    .byte SCORE_RETURN    ; return

RUINEDCASTLE_SQ3:
    .byte TEMPO,$05
    .byte SPEED_SET,$03   ; envelope speed
    .byte DUTY_50         ; duty 50%
    .byte $C8             ; all tracks have this delay
    .byte $CE             ; delay by the teensiest amount
    .byte $CE             ; delay by the teensiest amount

    RC_SQ3_LOOP:
    .byte OCTAVE_4         ; octave
    .byte INSTRUMENT,$10   
    .byte $2F              ; D
    .byte $2F     
    .byte $2F     
    .byte INSTRUMENT,$11
    .byte $1F              ; C sharp
    .byte OCTAVE_3 
    .byte $BF              ; B
    .byte OCTAVE_4
    .byte INSTRUMENT,$10   
    .byte $2F              ; D
    .byte INSTRUMENT,$11
    .byte OCTAVE_3 
    .byte $BF              ; B
    .byte OCTAVE_4
    .byte INSTRUMENT,$10   
    .byte $9F              ; A
    .byte LOOP_FOREVER
    .word RC_SQ3_LOOP


RUINEDCASTLE_SQ4:
    .byte TEMPO,$05
    .byte DUTY_25          ; duty 25%
    .byte $C8              ; all tracks have this delay
    .byte $CE              ; delay by the teensiest amount

    RC_SQ4_LOOP:
    .byte SCORE_GOTO
    .word RC_SQ4_WRIGGLEBOOP_SETUP

    .byte OCTAVE_2
    .byte SPEED_SET,$0A    ; envelope speed
    .byte INSTRUMENT,$0F   ; fade in with tremelo
    .byte $AF              ; 2 bar long drone

    .byte SCORE_GOTO
    .word RC_SQ4_WRIGGLEBOOP_SETUP

    .byte OCTAVE_2
    .byte SPEED_SET,$0A    ; envelope speed
    .byte INSTRUMENT,$0F   ; fade in with tremelo
    .byte $9F              ; 2 bar long drone
    .byte LOOP_FOREVER
    .word RC_SQ4_LOOP

    RC_SQ4_WRIGGLEBOOP_SETUP:
    .byte INSTRUMENT,$08   ; hold, decay from C
    .byte SPEED_SET,$81    ; envelope speed - beepy

    ;; I feel there is a way to do this in a less VOLUME_MINUS intensive way, but...
    ;; it works. And compared to how shaved down the other square channels are now--
    ;; (every single $xF note was originally a goto/return to a WRIGGLEBOOP-like mess of shorter notes and volume manipulation)
    ;; --I'm happy with it.

    RC_SQ4_WRIGGLEBOOP:
    .byte OCTAVE_4
    .byte $25              ; this x5 note is $18 long
    .byte OCTAVE_3
    .byte $97              ; this x7 note is $0C long
    .byte VOLUME_MINUS,$03 ; -3 volume
    .byte OCTAVE_4
    .byte $27 
    .byte VOLUME_MINUS,$04 ; -4 volume
    .byte $25    
    .byte VOLUME_MINUS,$05 ; -5 volume
    .byte OCTAVE_3
    .byte $95              ; one 3/4 bar = $60
    .byte VOLUME_MINUS,$06 ; -6 volume
    .byte OCTAVE_4
    .byte $27
    .byte VOLUME_MINUS,$07 ; -7 volume
    .byte OCTAVE_3
    .byte $97
    .byte VOLUME_MINUS,$08 ; -8 volume
    .byte $97
    .byte VOLUME_MINUS,$09 ; -9 volume
    .byte OCTAVE_4
    .byte $27
    .byte VOLUME_MINUS,$0A ; -A volume
    .byte $25
    .byte VOLUME_MINUS,$0B ; -B volume
    .byte OCTAVE_3
    .byte $95              ; one 3/4 bar = $60
    .byte VOLUME_MINUS,$00 ; reset volume
    .byte LOOP_X,$02
    .word RC_SQ4_WRIGGLEBOOP
    .byte SCORE_RETURN

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;           EARTH CAVE / GURGU VOLCANO             ;;;;;;;;;;;;;;;;;;;;;;;;;;;;        
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


EARTHCAVE_SQ1:
    .byte DUTY_25
    .byte TEMPO,$02
    D1LOOP0:
    .byte SPEED_SET,$86,INSTRUMENT,$00
    D1LOOP0A:
    .byte OCTAVE_3,$29,$C9,$29,$C9,$59,$C9,$29,$C9
    .byte $09,$C9,SPEED_SET,$81,$45,$25,SPEED_SET,$86,$29,$C9,$59,$C9,$29,$C9,$49,$C9
    .byte SPEED_SET,$81,$75,SPEED_SET,$86,$79,$C9
    .byte LOOP_X,$01
    .word D1LOOP0A
    .byte SPEED_SET,$83,$17,$29,$C9,$59
    .byte $C9,$99,$C9,SPEED_SET,$01,INSTRUMENT,$0E,OCTAVE_4,$21,$C7,SPEED_SET,$86,INSTRUMENT,$00,OCTAVE_3,$BC,OCTAVE_4,$0C
    .byte OCTAVE_3,$BC,$99,$C9,$B9,$C9,SPEED_SET,$83,OCTAVE_4,$07,OCTAVE_3,$B9,$C9,$99,$C9,$79
    .byte $C9,$57,$79,$C9,$99,$C9,$59,$C9,SPEED_SET,$01,INSTRUMENT,$0E,$21,SPEED_SET,$83,INSTRUMENT,$00,$17
    .byte $29,$C9,$59,$C9,$99,$C9,SPEED_SET,$01,INSTRUMENT,$0E,OCTAVE_4,$21,SPEED_SET,$86,INSTRUMENT,$00,$C7,OCTAVE_3
    .byte $BC,OCTAVE_4,$0C,OCTAVE_3,$BC,$99,$C9,$B9,$C9,SPEED_SET,$83,OCTAVE_4,$07,OCTAVE_3,$99,$C9
    .byte $59,$C9,$99,$C9,OCTAVE_4,$47,$59,$C9,$49,$C9,$09,$C9,SPEED_SET,$01,INSTRUMENT,$0E,$21
    .byte SPEED_SET,$83,INSTRUMENT,$00,$07,OCTAVE_3,$97,$57,$97,$B7,OCTAVE_4,$07,OCTAVE_3,$B7,$97,SPEED_SET,$01
    .byte $B4,$B9,$B9,$B4,$B9,$B9,SPEED_SET,$83,OCTAVE_4,$07
    .byte OCTAVE_3,$97,$57,$97,$B7,OCTAVE_4,$07,OCTAVE_3,$B7,$97,SPEED_SET,$01,OCTAVE_4,$24
    .byte $29,$29,OCTAVE_4,$24,$29,$29,SPEED_SET,$83,$37,$07,OCTAVE_3,$87
    .byte OCTAVE_4,$07,$27,$37,$27,$07,SPEED_SET,$01,OCTAVE_3,$A4,$A9,$A9
    .byte OCTAVE_3,$A4,$A9,$A9,SPEED_SET,$83,OCTAVE_4,$37,$07,OCTAVE_3,$87,OCTAVE_4,$07,$27
    .byte $37,$27,$07,SPEED_SET,$01,$54,$59,$59,$54,$59
    .byte $59
    .byte LOOP_FOREVER
    .word D1LOOP0


EARTHCAVE_SQ2:
    .byte DUTY_12
    .byte TEMPO,$02
    D1LOOP1:
    .byte SPEED_SET,$83,INSTRUMENT,$01
    D1LOOP1A:
    .byte OCTAVE_2,$99,$C9,$99,$C9,$C4
    .byte $75,$99,$C9,$C3,$79,$C9,$75,$79,$C9
    .byte LOOP_X,$01
    .word D1LOOP1A
    D1LOOP1B:
    .byte SPEED_SET,$01,INSTRUMENT,$0E,$93,SPEED_SET,$86,INSTRUMENT,$01,$C7,$57,$79,$C9,$99,$C9,SPEED_SET,$01
    .byte INSTRUMENT,$0E,$B3,SPEED_SET,$83,INSTRUMENT,$01,$C7,$77,$99,$C9,$B9,$C9,SPEED_SET,$01,INSTRUMENT,$0E,OCTAVE_3
    .byte $03,SPEED_SET,$86,INSTRUMENT,$01,$C7,OCTAVE_2,$97,$B9,$C9,OCTAVE_3,$09,$C9,SPEED_SET,$01,INSTRUMENT,$0E,OCTAVE_2
    .byte $B3,SPEED_SET,$86,INSTRUMENT,$01,$C7,$77,$99,$C9,$B9,$C9
    .byte LOOP_X,$01
    .word D1LOOP1B
    D1LOOP1C:
    .byte SPEED_SET,$83,OCTAVE_3
    .byte $57,$C7,$07,$C7,OCTAVE_2,$97,$C7,OCTAVE_3,$07,$C7,$57,$27,$57,$27,$57,$27
    .byte $57,$27
    .byte LOOP_X,$01
    .word D1LOOP1C
    D1LOOP1D:
    .byte $87,$C7,$37,$C7,$07,$C7,$37,$C7,$87,$57,$87
    .byte $57,$87,$57,$87,$57
    .byte LOOP_X,$01
    .word D1LOOP1D
    .byte LOOP_FOREVER
    .word D1LOOP1

EARTHCAVE_SQ3:
    .byte VOLUME_QRTR,TEMPO,$02,$C4,LOOP_FOREVER
    .word EARTHCAVE_SQ1

EARTHCAVE_SQ4:
    .byte VOLUME_QRTR,TEMPO,$02,$C5,LOOP_FOREVER
    .word EARTHCAVE_SQ2


EARTHCAVE_TRI:
    .byte TEMPO,$02
    D1LOOP2:
    D1LOOP2A:
    .byte OCTAVE_4
    .byte $29,$C9,$29,$C9,$C4,$05,$29,$C9,$C3,$09,$C9,OCTAVE_3,$B5,$B9,$C9
    .byte LOOP_X,$01
    .word D1LOOP2A
    D1LOOP2B:
    .byte OCTAVE_4,$29,$C9,$29,$C9,$59,$C9,$59,$C9,$29,$C9,$C5,$09,$C9
    .byte $29,$C9,$29,$C9,$79,$C9,$79,$C9,$29,$C9,$C5,$09,$C9,$29,$C9,$29
    .byte $C9,$99,$C9,$99,$C9,$29,$C9,$C5,$09,$C9,$29,$C9,$29,$C9,$79,$C9
    .byte $79,$C9,$29,$C9,$C5,$09,$C9
    .byte LOOP_X,$01
    .word D1LOOP2B
    D1LOOP2C:
    .byte OCTAVE_3,$59,$C9,$59,$C9,OCTAVE_4
    .byte $59,$C9,$59,$C6,OCTAVE_3,$59,$C9,OCTAVE_4,$59,$C9,$09,$C9,OCTAVE_3,$74,$79,$C9
    .byte $74,$79,$C9
    .byte LOOP_X,$01
    .word D1LOOP2C
    D1LOOP2D:
    .byte $89,$C9,$89,$C9,OCTAVE_4,$89,$C9,$89,$C6,OCTAVE_3
    .byte $89,$C9,OCTAVE_4,$89,$C9,$39,$C9,OCTAVE_3,$A4,$A9,$C9,$A4,$A9,$C9
    .byte LOOP_X,$01
    .word D1LOOP2D
    .byte LOOP_FOREVER
    .word D1LOOP2
    
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;               MATOYA                             ;;;;;;;;;;;;;;;;;;;;;;;;;;;;        
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    


MATOYA_SQ1:
    .byte DUTY_25
    .byte TEMPO,$02
    D2LOOP0:
    .byte SPEED_SET,$01,INSTRUMENT,$0C,OCTAVE_3,$B7,OCTAVE_4,$27,$67,OCTAVE_3,$B7
    .byte OCTAVE_4,$75,$67,$47,$25,$47,$27,INSTRUMENT,$0E,$13,INSTRUMENT,$0C,$27,$67
    .byte $97,$27,$B5,$97,$77,$65,$77,$67,$45,$67,$77,INSTRUMENT,$0E,$93,$15
    .byte $45,$2C,$CC,$1C,$CC,$2C,$CC,OCTAVE_3,$B3,OCTAVE_4,$77,$97,$B3,$25,$75,$6C
    .byte $CC,$7C,$CC,$6C,$CC,$43,$97,$B7,OCTAVE_5,$13,$C7,OCTAVE_4,$97,$B7,OCTAVE_5,$17
    .byte $49,$29,$19,$29,OCTAVE_4,$B4,$97,$77,$67,$43,$C7,$07,$27,$47,$23,$15
    .byte OCTAVE_3,$95,INSTRUMENT,$0E,OCTAVE_4,$20,$C5,SPEED_SET,$84,INSTRUMENT,$01,$29,$19,OCTAVE_3,$B9,OCTAVE_4
    .byte $19,SPEED_SET,$01,INSTRUMENT,$0E,$20,$C5,SPEED_SET,$84,INSTRUMENT,$01,$69,$49,$29,$49,SPEED_SET,$01,INSTRUMENT,$0E
    .byte $60,$C5,SPEED_SET,$84,INSTRUMENT,$01,$99,$79,$69,$79,SPEED_SET,$01,INSTRUMENT,$0E,$90,SPEED_SET,$84,INSTRUMENT,$01
    .byte $69,$49,$29,$19,$49,$29,$19,OCTAVE_3,$A9
    .byte LOOP_FOREVER
    .word D2LOOP0

MATOYA_SQ2:
    .byte DUTY_12
    .byte TEMPO,$02
    D2LOOP1:
    .byte SPEED_SET,$81,INSTRUMENT,$02
    .byte OCTAVE_2,$B9,$C9,OCTAVE_3,$69,$C9,OCTAVE_2,$B9,$C9,OCTAVE_3,$69,$C9,OCTAVE_2,$B9,$C9,OCTAVE_3
    .byte $79,$C9,OCTAVE_2,$B9,$C9,OCTAVE_3,$79,$C9,OCTAVE_2,$B9,$C9,OCTAVE_3,$79,$C9,OCTAVE_2,$B9
    .byte $C9,OCTAVE_3,$79,$C9,$19,$C9,$99,$C9,$19,$C9,$99,$C9,$29,$C9,$99,$C9
    .byte $29,$C9,$99,$C9,$29,$C9,$B9,$C9,$29,$C9,$B9,$C9,$29,$C9,$B9,$C9
    .byte $29,$C9,$B9,$C9,$19,$C9,$99,$C9,$19,$C9,$99,$C9,$99,$C9,$99,$C9
    .byte $C5,$99,$C9,$99,$C9,$C5,$69,$C9,$69,$C9,$C5,$69,$C9,$69,$C9,$C5
    .byte $B9,$C9,$B9,$C9,$C5,$B9,$C9,$B9,$C9,$C5,OCTAVE_4,$19,$C9,$19,$C9,$C5
    .byte $19,$C9,$19,$C9,$C5,OCTAVE_3,$99,$C9,$99,$C9,$C5,$99,$C9,$99,$C9,$C5
    .byte $69,$C9,$69,$C9,$C5,$69,$C9,$69,$C9,$C5,$49,$C9,$79,$C9,$49,$C9
    .byte $79,$C9,$49,$C9,$79,$C9,$49,$C9,$79,$C9,$49,$C9,$79,$C9,$49,$C9
    .byte $79,$C9,$99,$79,$69,$49,$69,$49,$29,$19
    D2LOOP1A:
    .byte SPEED_SET,$01,INSTRUMENT,$0E,$65,$25,$75
    .byte $25,$97,$97,$27,$97,$75,$45
    .byte LOOP_X,$02
    .word D2LOOP1A
    .byte $65,$25,$75,$25,$97,$97
    .byte $27,$97,$65,$45
    .byte LOOP_FOREVER
    .word D2LOOP1

MATOYA_SQ3:
    .byte VOLUME_HALF,VOLUME_MINUS,$01,TEMPO,$02,$C4,LOOP_FOREVER
    .word MATOYA_SQ1

MATOYA_SQ4:
    .byte VOLUME_QRTR,TEMPO,$02,$C5,LOOP_FOREVER
    .word MATOYA_SQ2

MATOYA_TRI:
    .byte TEMPO,$02
    D2LOOP2:
    .byte OCTAVE_2,$B3,OCTAVE_3,$43,$73
    .byte $95,$75,$23,$73,$B3,$97,$49,$C9,$19,$C9,OCTAVE_2,$99,$C9,$C7,$67,OCTAVE_3
    .byte $19,$C9,$69,$C9,$C7,OCTAVE_2,$69,$C9,OCTAVE_3,$67,$19,$C9,$C7,OCTAVE_2,$B7,OCTAVE_3
    .byte $69,$C9,$B9,$C9,$C7,OCTAVE_2,$B9,$C9,OCTAVE_3,$B7,$69,$C9,$C7,OCTAVE_2,$77,OCTAVE_3
    .byte $29,$C9,$79,$C9,$C7,OCTAVE_2,$79,$C9,OCTAVE_3,$77,$29,$C9,$C7,OCTAVE_2,$97,OCTAVE_3
    .byte $49,$C9,$99,$C9,$C7,OCTAVE_2,$99,$C9,OCTAVE_3,$97,$49,$C9,$C7,OCTAVE_2,$67,OCTAVE_3
    .byte $19,$C9,$69,$C9,$C7,OCTAVE_2,$69,$C9,OCTAVE_3,$67,$19,$C9,$C7,OCTAVE_2,$B7,OCTAVE_3
    .byte $69,$C9,$B9,$C9,$C7,OCTAVE_2,$B9,$C9,OCTAVE_3,$B7,$69,$C9,$07,OCTAVE_4,$09,$C9
    .byte OCTAVE_3,$07,OCTAVE_4,$09,$C9,OCTAVE_3,$07,OCTAVE_4,$09,$C9,OCTAVE_3,$07,OCTAVE_4,$09,$C9,OCTAVE_2
    .byte $97,OCTAVE_3,$99,$C9,OCTAVE_2,$97,OCTAVE_3,$99,$C9,OCTAVE_2,$97,OCTAVE_3,$99,$C9,OCTAVE_2,$97
    .byte OCTAVE_3,$99,$C9
    D2LOOP2A:
    .byte $27,$99,$C9,$C7,$99,$C9,$27,$B9,$C9,$C7,$B9,$C9,$27
    .byte OCTAVE_4,$19,$C9,$C7,$19,$C9,OCTAVE_3,$27,$B9,$C9,$C7,$B9,$C9
    .byte LOOP_X,$02
    .word D2LOOP2A
    .byte $27,$99,$C9,$C7,$99,$C9,$27,$B9,$C9,$C7,$B9,$C9,$27,OCTAVE_4,$19,$C9
    .byte $C7,$19,$C9,OCTAVE_3,$67,OCTAVE_4,$19,$C9,OCTAVE_3,$67,OCTAVE_4,$19,$C9
    .byte LOOP_FOREVER
    .word D2LOOP2


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;; NEW MARSH CAVE - "DUNGEONEERS" ((C) Jiggers)     ;;;;;;;;;;;;;;;;;;;;;;;;;;;;        
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

   ;; JIGS - my own composition as a replacement for this ugly song...

MARSHCAVE_SQ1:
    .byte TEMPO,$05
    .byte SPEED_SET,$01
    .byte INSTRUMENT,$01
    .byte DUTY_25
    DUNGEON3INTROLOOP:
    .byte OCTAVE_4,$A8,$78,$38,$08,OCTAVE_3,$38,$78,$A8,OCTAVE_4,$28
    .byte LOOP_X,$01
    .word DUNGEON3INTROLOOP
    DUNGEON3LOOP:
    .byte SPEED_SET,$02
    .byte INSTRUMENT,$00
    DUNGEON3LOOP1:
    .byte OCTAVE_4,$04,OCTAVE_3,$74,OCTAVE_4,$06,$26,$56,$86 ; 1
    .byte $74,$04,$76,$86,$A6,OCTAVE_5,$16 ; 2
    .byte $04,OCTAVE_4,$74 ; 3.0
    .byte LOOP_SWITCH
    .word DUNGEON3MELODYLOOP1
    .byte $A6,$86,$76,$A6 ; 3.5
    .byte $92,$98,$C8,$78,$C8,$58,$C8,$38,$C8 ;4
    .byte LOOP_X,$01
    .word DUNGEON3LOOP1
     DUNGEON3MELODYLOOP1:
    .byte $36,$26,$06,OCTAVE_3,$A6 ; 7.5
    .byte $82,$62 ; 8
   DUNGEON3LOOP1_2:
    .byte OCTAVE_4,$78,$C8,$76,$04,$38,$78,$A6,OCTAVE_5,$26,$08,OCTAVE_4,$88 ; 9
    .byte $78,$C8,$76,$04,$38,$78,$86,$A6,$88,$68 ; 10
    .byte $78,$C8,$76,$04,$58,$38,$56,$28,$C8,OCTAVE_3,$A8,$C8,OCTAVE_4 ; 11
    .byte LOOP_SWITCH
    .word DUNGEON3MELODYLOOP2
    .byte $02,$36,$56,$86,$66 ; 12
    .byte LOOP_X,$01
    .word DUNGEON3LOOP1_2
    DUNGEON3MELODYLOOP2:
    .byte $01,OCTAVE_5,$3A,$2A,$0A,OCTAVE_4,$AA,$7A,$5A,$3A,$2A ;16
    .byte LOOP_FOREVER
    .word DUNGEON3LOOP

MARSHCAVE_SQ4:
    .byte VOLUME_HALF,VOLUME_QRTR,TEMPO,$05,$C5,LOOP_FOREVER
    .word MARSHCAVE_SQ1

MARSHCAVE_SQ2:
    .byte TEMPO,$05
    .byte $C0
    .byte DUTY_12
    DUNGEON3HARMONYLOOP1:
    .byte SPEED_SET,$82
    .byte INSTRUMENT,$0A
    .byte OCTAVE_3
    .byte $74,$06,$74,$86,$56,$86
    .byte $74,$06,$74,$86,$56,$86
    .byte $74,$06,$74,$86
    .byte LOOP_SWITCH
    .word DUNGEON3FLOOP1
    .byte $76,$56,$36,$26,$06,$36,$22
    .byte LOOP_X,$01
    .word DUNGEON3HARMONYLOOP1
    DUNGEON3FLOOP1:
    .byte OCTAVE_4,$06,OCTAVE_3,$86,$36,$26,$06,$36,$64,$24
    ;;Part 2
    DUNGEON3HARMONYLOOP2:
    .byte INSTRUMENT,$00
    .byte $08,$38,$78,OCTAVE_4,$08,OCTAVE_3
    .byte INSTRUMENT,$02
    .byte $08,$38,$78,OCTAVE_4,$08,OCTAVE_3
    .byte INSTRUMENT,$00
    .byte $38,$78,$A8,OCTAVE_4,$38,OCTAVE_3
    .byte INSTRUMENT,$02
    .byte $38,$78,$A8,OCTAVE_4,$38,OCTAVE_3

    .byte INSTRUMENT,$00
    .byte $08,$38,$78,OCTAVE_4,$08,OCTAVE_3
    .byte INSTRUMENT,$02
    .byte $08,$38,$78,OCTAVE_4,$08,OCTAVE_3
    .byte INSTRUMENT,$00
    .byte $38,$78,OCTAVE_4,$08,$38,OCTAVE_3
    .byte INSTRUMENT,$02
    .byte $38,$78,OCTAVE_4,$08,$38,OCTAVE_3

    .byte INSTRUMENT,$00
    .byte $08,$38,$78,OCTAVE_4,$08,OCTAVE_3
    .byte INSTRUMENT,$02
    .byte $08,$38,$78,OCTAVE_4,$08,OCTAVE_3
    .byte INSTRUMENT,$00
    .byte $38,$78,$A8,OCTAVE_4,$38,OCTAVE_3
    .byte INSTRUMENT,$02
    .byte $38,$78,$A8,OCTAVE_4,$38,OCTAVE_3
    .byte LOOP_SWITCH
    .word DUNGEON3TRILLFLOOP
    .byte INSTRUMENT,$00
    .byte $08,$38,$78,OCTAVE_4,$08,OCTAVE_3
    .byte INSTRUMENT,$02
    .byte $08,$38,$78,OCTAVE_4,$08,OCTAVE_3
    .byte INSTRUMENT,$00
    .byte $38,$88,OCTAVE_4,$08,$38,OCTAVE_3
    .byte INSTRUMENT,$02
    .byte $38,$88,OCTAVE_4,$08,$38,OCTAVE_3
    .byte LOOP_X,$01
    .word DUNGEON3HARMONYLOOP2
    DUNGEON3TRILLFLOOP:
    .byte INSTRUMENT,$00
    .byte $08,$38,$78,OCTAVE_4,$08,OCTAVE_3
    .byte INSTRUMENT,$01
    .byte $08,$38,$78,OCTAVE_4,$08,OCTAVE_3
    .byte INSTRUMENT,$02
    .byte $08,$38,$78,OCTAVE_4,$08,OCTAVE_3
    .byte INSTRUMENT,$03
    .byte $08,$38,$78,OCTAVE_4,$08,OCTAVE_3
    .byte LOOP_FOREVER
    .word DUNGEON3HARMONYLOOP1

MARSHCAVE_TRI:
    .byte TEMPO,$05
    .byte OCTAVE_5,$38,$28,$08,OCTAVE_4,$98,$88,$78,$58,$38,$28,$08,OCTAVE_3,$98,$88,$78,$58,$38,$28
    DUNGEON3TRILOOP:
    .byte $06,$C6,$06,$74,$86,$36,OCTAVE_2,$76,OCTAVE_3 ; 1
    .byte $06,$C6,$06,$74,$86,$36,OCTAVE_2,$76,OCTAVE_3 ; 2
    .byte $06,$C6,$06,$74,$86 ; 3/3
    .byte LOOP_SWITCH
    .word DUNGEON3TRIFLOOP1
    .byte $36,$56 ; 3/4
    .byte $06,$C6,OCTAVE_2,$A6,OCTAVE_3,$55,$C8,$56,$76,$86 ; 4
    .byte LOOP_X,$01
    .word DUNGEON3TRILOOP
    DUNGEON3TRIFLOOP1:
    .byte $56,$36,$24,$84,$94,$84
    DUNGEON3TRILOOP2:
    .byte OCTAVE_3,$08,OCTAVE_2,$A8,OCTAVE_3,$06,OCTAVE_2,$78,$58,$76,$C6,$76,$86,$A6
    .byte OCTAVE_3,$08,OCTAVE_2,$A8,OCTAVE_3,$06,OCTAVE_2,$78,$58,$76,$C6,OCTAVE_3,$06,$26,OCTAVE_2,$A6
    .byte OCTAVE_3,$08,OCTAVE_2,$A8,OCTAVE_3,$06,OCTAVE_2,$78,$58,$76,$C6
    .byte LOOP_SWITCH
    .word DUNGEON3TRIFLOOP2
    .byte OCTAVE_3,$38,$C8,$38,$C8,$28,$C8
    .byte $08,OCTAVE_2,$38,OCTAVE_3,$08,$C8,$38,$C8,$58,$C8,$38,OCTAVE_2,$38,OCTAVE_3,$08,OCTAVE_2,$A8,$88,$38,$68,$A8
    .byte LOOP_X,$01
    .word DUNGEON3TRILOOP2
    DUNGEON3TRIFLOOP2:
    .byte $76,$56,$26
    DUNGEON3TRILOOP3:
    .byte $06,$78,OCTAVE_3,$38,$08,$78,$38,OCTAVE_2,$78
    .byte LOOP_X,$01
    .word DUNGEON3TRILOOP3
    .byte OCTAVE_3,LOOP_FOREVER
    .word DUNGEON3TRILOOP

MARSHCAVE_SQ3:
    .byte TEMPO,$05
    .byte SPEED_SET,$01
    .byte INSTRUMENT,$0D
    .byte DUTY_12
    .byte OCTAVE_DOWN  ; set octave to -1
    .byte $C0,OCTAVE_3
    .byte LOOP_FOREVER
    .word DUNGEON3TRILOOP

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;          MARSH CAVE (vanilla)                    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;        
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


   ;; JIGS - below is Marsh Cave's original song data

MARSHCAVEOLD_SQ1:
    .byte TEMPO,$02
    D3LOOP0:
    .byte SPEED_SET,$01,INSTRUMENT,$01
    D3LOOP0A:
    .byte OCTAVE_3,$69,$79,$89,$79,$69,$79,$89,$A9,$89,$79,$39
    .byte $09,$69,$79,$89,$79,$69,$79,$89,$A9,$89,$79,$39,$09,$39,$49,$79
    .byte $A9,$B9,OCTAVE_4,$09,$19,$09,OCTAVE_3,$B9,OCTAVE_4,$09,$19,$39,$19,$09,OCTAVE_3,$89
    .byte $59,$B9,OCTAVE_4,$09,$19,$09,OCTAVE_3,$B9,OCTAVE_4,$09,$19,$39,$19,$09,OCTAVE_3,$89
    .byte $59,OCTAVE_4,$09,OCTAVE_3,$A9,$89,$59
    .byte LOOP_X,$01
    .word D3LOOP0A
    D3LOOP0B:
    .byte SPEED_SET,$81,INSTRUMENT,$0E,OCTAVE_4,$79,$89
    .byte $72,$C7,$C5,$A5,$95,$85
    .byte LOOP_X,$01
    .word D3LOOP0B
    D3LOOP0C:
    .byte OCTAVE_5,$09,$19,$02,$C7,$C5,$35
    .byte $25,$15
    .byte LOOP_X,$01
    .word D3LOOP0C
    .byte LOOP_FOREVER
    .word D3LOOP0

MARSHCAVEOLD_SQ2:
    .byte TEMPO,$02
    D3LOOP1:
    .byte SPEED_SET,$82,INSTRUMENT,$01
    D3LOOP1A:
    .byte OCTAVE_2,$77,$C5,$77
    .byte $C5,$C5,$77,$C7,$77,$C7,$77,$C7,OCTAVE_3,$07,$C5,$07,$C5,$07,$C5,$07
    .byte $C5,$07,$C7
    .byte LOOP_X,$01
    .word D3LOOP1A
    D3LOOP1B:
    .byte SPEED_SET,$01,INSTRUMENT,$0B,$25,$07,$55,$27,$73,$57,$57
    .byte $47,$47,$37,$37
    .byte LOOP_X,$01
    .word D3LOOP1B
    D3LOOP1C:
    .byte $75,$57,$A5,$77,OCTAVE_4,$03,OCTAVE_3,$A7,$A7
    .byte $97,$97,$87,$87
    .byte LOOP_X,$01
    .word D3LOOP1C
    .byte LOOP_FOREVER
    .word D3LOOP1

MARSHCAVEOLD_SQ3:
    .byte VOLUME_QRTR,TEMPO,$02,$C5,LOOP_FOREVER
    .word MARSHCAVEOLD_SQ1

MARSHCAVEOLD_SQ4:
    .byte VOLUME_QRTR,TEMPO,$02,$C5,LOOP_FOREVER
    .word MARSHCAVEOLD_SQ2

MARSHCAVEOLD_TRI:
    .byte TEMPO,$02
    D3LOOP2:
    D3LOOP2A:
    .byte OCTAVE_3,$07
    .byte $C5,$07,$C5,$C5,$07,$C7,$07,$C7,$07,$C7,$57,$C5,$57,$C5,$57,$C5
    .byte $57,$C5,$57,$C7
    .byte LOOP_X,$01
    .word D3LOOP2A
    D3LOOP2B:
    .byte $77,$6C,$5C,$4C,$57,$67,$77,$6C,$5C
    .byte $4C,$57,$67,$77,$6C,$5C,$4C,$A7,OCTAVE_4,$07,OCTAVE_3,$97,$B7,$87,$A7
    .byte LOOP_X,$01
    .word D3LOOP2B
    D3LOOP2C:
    .byte OCTAVE_4,$07,OCTAVE_3,$BC,$AC,$9C,$A7,$B7,OCTAVE_4,$07,OCTAVE_3,$BC,$AC,$9C
    .byte $A7,$B7,OCTAVE_4,$07,OCTAVE_3,$BC,$AC,$9C,OCTAVE_4,$37,$57,$27,$47,$17,$37
    .byte LOOP_X,$01
    .word D3LOOP2C
    .byte LOOP_FOREVER
    .word D3LOOP2

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;           SEA SHRINE                             ;;;;;;;;;;;;;;;;;;;;;;;;;;;;        
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


SEASHRINE_SQ1:
    .byte DUTY_25
    .byte TEMPO,$02
    D4LOOP0:
    .byte SPEED_SET,$01,INSTRUMENT,$0E,OCTAVE_4,$43,OCTAVE_3,$B5,OCTAVE_4,$B5,$95,$75
    .byte $65,$45,$73,$41,$C3,$C5,$45,OCTAVE_3,$B5,OCTAVE_4,$B5,OCTAVE_5,$25,$05,OCTAVE_4,$B5
    .byte $95,$B1,$C3,$75,$95,$B3,$25,$75,$65,$45,$65,$75,$43,OCTAVE_3,$B3,OCTAVE_4
    .byte $22,OCTAVE_3,$B5,OCTAVE_4,$05,$45,$B5,$95,$53,$75,$95,$71,$61
    .byte LOOP_FOREVER
    .word D4LOOP0


SEASHRINE_SQ2:
    .byte DUTY_12
    .byte TEMPO,$02
    D4LOOP1:
    .byte SPEED_SET,$86,INSTRUMENT,$0B,OCTAVE_2,$B7,OCTAVE_3,$77,$67,$77,$47,$77,$27,$77,OCTAVE_2,$97
    .byte OCTAVE_3,$67,$47,$67,$27,$67,$07,$67,OCTAVE_2,$77,OCTAVE_3,$47,$27,$47,$07,$47
    .byte OCTAVE_2,$B7,OCTAVE_3,$47,OCTAVE_2,$97,OCTAVE_3,$47,OCTAVE_2,$77,OCTAVE_3,$47,OCTAVE_2,$97,OCTAVE_3,$67
    .byte $27,$67,OCTAVE_2,$B7,OCTAVE_3,$77,$67,$77,$47,$77,$27,$77,OCTAVE_2,$97,OCTAVE_3,$67
    .byte $47,$67,$27,$67,$07,$67,OCTAVE_2,$97,OCTAVE_3,$47,$27,$47,$17,$47,OCTAVE_2,$B7
    .byte OCTAVE_3,$47,OCTAVE_2,$77,OCTAVE_3,$47,$07,$47,OCTAVE_2,$77,OCTAVE_3,$47,$07,$47
    .byte INSTRUMENT,$02,$77,$B7,$97,$B7,$C7,$B7,$97,$B7,$67,$97,$77,$97,$C7,$97,$77
    .byte $97,$47,$77,$67,$77,$C7,$77,$67,$77,$27,$67,$47,$67,$C7,$67,$47
    .byte $67,$47,$77,$67,$77,$C7,$77,$67,$77,$97,OCTAVE_4,$07,OCTAVE_3,$B7,OCTAVE_4,$07
    .byte $C7,$07,OCTAVE_3,$B7,OCTAVE_4,$07,INSTRUMENT,$06,OCTAVE_2,$97,INSTRUMENT,$02,OCTAVE_3,$99
    .byte $C9,$79,$C9,OCTAVE_2,$99,$C9,OCTAVE_3,$99,$C9,SPEED_SET,$83,INSTRUMENT,$06,$75,SPEED_SET,$86,INSTRUMENT,$02
    .byte $99,$C9,INSTRUMENT,$06,$27,INSTRUMENT,$02,OCTAVE_4,$29,$C9,$09,$C9,OCTAVE_3,$29
    .byte $C9,OCTAVE_4,$29,SPEED_SET,$83,INSTRUMENT,$06,$C9,$05,SPEED_SET,$86,INSTRUMENT,$02,$29,$C9
    .byte LOOP_FOREVER
    .word D4LOOP1

SEASHRINE_SQ3:
    .byte VOLUME_HALF,VOLUME_MINUS,$02,TEMPO,$02,$C4,LOOP_FOREVER
    .word SEASHRINE_SQ1

SEASHRINE_SQ4:
    .byte VOLUME_QRTR,TEMPO,$02,$C5,LOOP_FOREVER
    .word SEASHRINE_SQ2

SEASHRINE_TRI:
    .byte TEMPO,$02
    D4LOOP2:
    .byte OCTAVE_3,$41,$21,$01,$03,$23,$41,$21,$11,$01,OCTAVE_2,$77
    .byte OCTAVE_3,$79,$C6,$79,$C9,OCTAVE_2,$77,OCTAVE_3,$79,$C6,$79,$C9,$27,$99,$C6,$99
    .byte $C9,$27,$99,$C6,$99,$C9,$47,$B9,$C6,$B9,$C9,$47,$B9,$C6,$B9,$C9
    .byte OCTAVE_2,$B7,OCTAVE_3,$B9,$C6,$B9,$C9,OCTAVE_2,$B7,OCTAVE_3,$B9,$C6,$B9,$C9,$07,OCTAVE_4
    .byte $09,$C6,$09,$C9,OCTAVE_3,$07,OCTAVE_4,$09,$C6,$09,$C9,OCTAVE_3,$57,OCTAVE_4,$09,$C6
    .byte $09,$C9,OCTAVE_3,$57,OCTAVE_4,$09,$C6,$09,$C9,OCTAVE_3,$27,OCTAVE_4,$29,$C9,$09,$C9
    .byte OCTAVE_3,$29,$C9,OCTAVE_4,$29,$C9,$05,$29,$C9,OCTAVE_3,$97,OCTAVE_4,$69,$C9,$49,$C9
    .byte OCTAVE_3,$99,$C9,OCTAVE_4,$69,$C9,$45,$69,$C9
    .byte LOOP_FOREVER
    .word D4LOOP2

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;           SKY CASTLE                             ;;;;;;;;;;;;;;;;;;;;;;;;;;;;        
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


SKYCASTLE_SQ1:
    .byte DUTY_25
    D5LOOP0:
    .byte TEMPO,$04,SPEED_SET,$82,INSTRUMENT,$0C
    D5LOOP0A:
    .byte SPEED_SET,$83,INSTRUMENT,$0C,OCTAVE_4,$A7,$C7,$C2,SPEED_SET,$01
    .byte INSTRUMENT,$0E,$43,INSTRUMENT,$0C,$65,$A5,INSTRUMENT,$0E,$81,$21,$C3,INSTRUMENT,$0C,$A5,$45,INSTRUMENT,$0E,$63,INSTRUMENT,$0C
    .byte $85,$A5,INSTRUMENT,$0E,OCTAVE_5,$32,OCTAVE_4,$C7,$B7,$A2,$C7,$97
    .byte LOOP_X,$01
    .word D5LOOP0A
    D5LOOP0B:
    .byte SPEED_SET,$82
    .byte INSTRUMENT,$0C,$A7,$C4,SPEED_SET,$01,$A7,$B7,$A7,$87,INSTRUMENT,$0E,$A1,SPEED_SET,$82,INSTRUMENT,$0C,$37,$C4
    .byte SPEED_SET,$01,$37,$47,$37,$17,INSTRUMENT,$0E,$31
    .byte LOOP_X,$01
    .word D5LOOP0B
    .byte OCTAVE_4,SPEED_SET,$83,INSTRUMENT,$01,$37
    .byte $37,$37,$37,$27,$27,$27,$27,$17,$17,$17,$17,$07,TEMPO,$03,$07,TEMPO,$02,$07
    .byte TEMPO,$01,$07
    .byte LOOP_FOREVER
    .word D5LOOP0

SKYCASTLE_SQ2:
    .byte DUTY_12
    D5LOOP1:
    .byte TEMPO,$04,SPEED_SET,$82,INSTRUMENT,$0C
    D5LOOP1A:
    .byte SPEED_SET,$83,INSTRUMENT,$0C,OCTAVE_3,$A7,$C7,$C2
    .byte SPEED_SET,$01,INSTRUMENT,$0E,$43,INSTRUMENT,$0C,$65,$A5,INSTRUMENT,$0E,$81,$21,$C3,INSTRUMENT,$0C,$A5,$45,INSTRUMENT,$0E,$63
    .byte INSTRUMENT,$0C,$85,$A5,INSTRUMENT,$0E,OCTAVE_4,$32,OCTAVE_3,$B5,$A2,$C7,$97
    .byte LOOP_X,$01
    .word D5LOOP1A
    D5LOOP1B:
    .byte SPEED_SET,$82
    .byte INSTRUMENT,$0C,OCTAVE_4,$37,$C7,$27,$C7,SPEED_SET,$01,INSTRUMENT,$0E,$13,SPEED_SET,$82,INSTRUMENT,$0C,$07,$C7,OCTAVE_3
    .byte $B7,$C7,SPEED_SET,$01,INSTRUMENT,$0E,$A3,SPEED_SET,$82,INSTRUMENT,$0C,$97,$C7,$87,$C7,SPEED_SET,$01,INSTRUMENT,$0E
    .byte $73,SPEED_SET,$82,INSTRUMENT,$0C,$67,$C7,$57,$C7,SPEED_SET,$01,INSTRUMENT,$0E,$43
    .byte LOOP_X,$01
    .word D5LOOP1B
    .byte SPEED_SET,$83
    .byte INSTRUMENT,$01,$37,$37,$37,$37,$27,$27,$27,$27,$17,$17,$17,$17,$07,TEMPO,$03
    .byte $07,TEMPO,$02,$07,TEMPO,$01,$07
    .byte LOOP_FOREVER
    .word D5LOOP1

SKYCASTLE_TRI:
    D5LOOP2:
    .byte TEMPO,$04
    D5LOOP2A:
    .byte OCTAVE_2,$A7,$C7,OCTAVE_3
    .byte $47,$C7,$A7,$C7,OCTAVE_4,$37,$C7,OCTAVE_2,$87,$C7,OCTAVE_3,$27,$C7,$87,$C7,OCTAVE_4
    .byte $17,$C7
    .byte LOOP_X,$07
    .word D5LOOP2A
    D5LOOP2B:
    .byte OCTAVE_3,$37,$C7,$A7,$C7,OCTAVE_4,$13,OCTAVE_3,$17,$C7,$15
    .byte $87,$C7,$B7,$C7
    .byte LOOP_X,$03
    .word D5LOOP2B
    .byte $C1,$C3,$C7,TEMPO,$03,$C7,TEMPO,$02,$C7,TEMPO,$01,$C7
    .byte LOOP_FOREVER
    .word D5LOOP2

SKYCASTLE_SQ3:
    .byte VOLUME_QRTR,TEMPO,$04,$C4,LOOP_FOREVER
    .word SKYCASTLE_SQ1

SKYCASTLE_SQ4:
    .byte VOLUME_QRTR,TEMPO,$04,$C4,LOOP_FOREVER
    .word SKYCASTLE_SQ2



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;            TEMPLE OF FIENDS                      ;;;;;;;;;;;;;;;;;;;;;;;;;;;;        
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

FIENDTEMPLE_SQ1:
    .byte DUTY_25
    .byte TEMPO,$02
    D6LOOP0:
    .byte SPEED_SET,$01,INSTRUMENT,$0E,OCTAVE_3,$B3,$85,$B5,$A5,$85,$65
    .byte $A5,$80,$C3,$B3,OCTAVE_4,$15,OCTAVE_3,$B5,$A5,$85,$65,OCTAVE_4,$45,$30
    .byte INSTRUMENT,$02,$C5,OCTAVE_3,$3C,$5C,$6C,$7C,$8C,$9C,INSTRUMENT,$0C,$A3,$B5,OCTAVE_4,$15
    .byte OCTAVE_3,$B5,$A5,$85,OCTAVE_4,$35,$13,$35,$45,$33,OCTAVE_3,$B3,$C3,OCTAVE_4,$35,$15
    .byte OCTAVE_3,$B5,$A5,$85,$B5,INSTRUMENT,$0E,$A0,$C3
    .byte LOOP_FOREVER
    .word D6LOOP0

FIENDTEMPLE_SQ2:
    .byte DUTY_12
    .byte TEMPO,$02
    D6LOOP1:
    .byte SPEED_SET,$86
    .byte INSTRUMENT,$0B,OCTAVE_2,$B7,OCTAVE_3,$37,$17,$37,OCTAVE_2,$B7,OCTAVE_3,$37,$17,$37,OCTAVE_2,$A7,OCTAVE_3
    .byte $37,$17,$37,OCTAVE_2,$A7,OCTAVE_3,$37,$17,$37,OCTAVE_2,$87,OCTAVE_3,$37,$17,$37,OCTAVE_2
    .byte $87,OCTAVE_3,$37,$17,$37,OCTAVE_2,$A7,OCTAVE_3,$37,$17,$37,OCTAVE_2,$A7,OCTAVE_3,$37,$17
    .byte $37,OCTAVE_2,$B7,OCTAVE_3,$37,$17,$37,OCTAVE_2,$B7,OCTAVE_3,$37,$17,$37,OCTAVE_2,$A7,OCTAVE_3
    .byte $37,$17,$37,OCTAVE_2,$A7,OCTAVE_3,$37,$17,$37,OCTAVE_2,$87,OCTAVE_3,$37,$17,$37,OCTAVE_2
    .byte $87,OCTAVE_3,$37,$17,$37,OCTAVE_2,$87,OCTAVE_3,$17,OCTAVE_2,$B7,OCTAVE_3,$17,OCTAVE_2,$87,OCTAVE_3
    .byte $17,OCTAVE_2,$B7,OCTAVE_3,$17,INSTRUMENT,$02,$37,$37,$C7,OCTAVE_2,$A7,OCTAVE_3,$37,$37
    .byte $C7,OCTAVE_2,$A7,OCTAVE_3,$37,$37,$C7,OCTAVE_2,$B7,OCTAVE_3,$37,$37,$C7,OCTAVE_2,$B7,OCTAVE_3
    .byte $47,$47,$C7,$17,$47,$47,$C7,$17,$67,$67,$C7,$37,$67,$67,$C7,$37
    .byte SPEED_SET,$01,INSTRUMENT,$0E,$83,$C7,SPEED_SET,$86,INSTRUMENT,$0B,OCTAVE_2,$B7,OCTAVE_3,$47,$87,SPEED_SET,$01,INSTRUMENT,$0E
    .byte $43,$C7,SPEED_SET,$86,INSTRUMENT,$0B,OCTAVE_2,$87,OCTAVE_3,$17,$47,SPEED_SET,$01,INSTRUMENT,$0E,$73,$C7,SPEED_SET,$86
    .byte INSTRUMENT,$0B,OCTAVE_2,$A7,OCTAVE_3,$37,$77,OCTAVE_2,$77,$A7,OCTAVE_3,$17,$47,$77,$47,$17
    .byte OCTAVE_2,$A7
    .byte LOOP_FOREVER
    .word D6LOOP1

FIENDTEMPLE_TRI:
    .byte TEMPO,$02
    D6LOOP2:
    .byte OCTAVE_3,$89,$C9,$89,$C9,$C5,$C3
    .byte $69,$C9,$69,$C9,$C5,$C3,$49,$C9,$49,$C9,$C5,$C3,$69,$C9,$69,$C9
    .byte $C5,$C3,$89,$C9,$89,$C9,$C5,$C3,$69,$C9,$69,$C9,$C5,$C3,$49,$C9
    .byte $49,$C9,$C5,$C3,$59,$C9,$59,$C9,$C5,$C3,$79,$C9,$79,$C9,$C7,$C5
    .byte OCTAVE_4,$37,$77,$37,OCTAVE_3,$89,$C9,$89,$C9,$C7,$C5,OCTAVE_4,$37,$87,$37,OCTAVE_3
    .byte $A9,$C9,$A9,$C9,$C7,$C5,OCTAVE_4,$67,$A7,$67,OCTAVE_3,$B9,$C9,$B9,$C9,$C7
    .byte $C5,OCTAVE_4,$67,$B7,$67,$41,$11,$31,$41
    .byte LOOP_FOREVER
    .word D6LOOP2

FIENDTEMPLE_SQ3:
    .byte VOLUME_QRTR,TEMPO,$02,$C4,LOOP_FOREVER
    .word FIENDTEMPLE_SQ1

FIENDTEMPLE_SQ4:
    .byte VOLUME_QRTR,TEMPO,$02,$C5,LOOP_FOREVER
    .word FIENDTEMPLE_SQ2

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;              SHOP                                ;;;;;;;;;;;;;;;;;;;;;;;;;;;;        
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


SHOP_SQ1:
    .byte DUTY_25
    .byte TEMPO,$04
    S1LOOP0:
    .byte SPEED_SET,$02,INSTRUMENT,$0C,OCTAVE_4,$73,$65,$73,$95,$72,$43,$55,$75,OCTAVE_5,$05
    .byte OCTAVE_4,$B5,OCTAVE_5,$25,$05,OCTAVE_4,$95,$73,$85,$93,$45,$51,$C3,$C3,$65,$73
    .byte $25,$41,$C3,$C3,$85,$93,$45,$55,$25,$45,$65,$B5,$95,$75,$65,$75
    .byte $85,OCTAVE_5,$05,OCTAVE_4,$B5,$95,$B5,OCTAVE_5,$05,$25,$05,OCTAVE_4,$85,SPEED_SET,$84,INSTRUMENT,$01
    .byte $77,$C7,OCTAVE_5,$07,$C7,$47,$C7,$27,$C7,$C3,SPEED_SET,$02,INSTRUMENT,$0C,OCTAVE_4,$B5,$75
    .byte $B5,$95,$55,$95,$75,$25,$75,$55,$25,$55
    .byte LOOP_FOREVER
    .word S1LOOP0

SHOP_SQ2:
    .byte DUTY_12
    .byte TEMPO,$04
    S1LOOP1:
    .byte SPEED_SET,$01
    .byte INSTRUMENT,$0A,OCTAVE_3,$43,$35,$43,$55,$42,$03,$25,$43,$45,$53,$55,$43,$45,$13
    .byte $15,$21,$C3,$C2,$03,OCTAVE_2,$B5,OCTAVE_3,$02,OCTAVE_2,$B5,OCTAVE_3,$05,OCTAVE_2,$B5,$A2
    .byte OCTAVE_3,$13,$15,$02,$32,$42,$22,$53,$55,$85,$75,$55,SPEED_SET,$84,INSTRUMENT,$02,$47
    .byte $C7,$57,$C7,$77,$C7,$B7,$C7,$C3,SPEED_SET,$01,INSTRUMENT,$0A,$22,$02,OCTAVE_2,$B2,$72
    .byte LOOP_FOREVER
    .word S1LOOP1

SHOP_TRI:
    .byte TEMPO,$04
    S1LOOP2:
    .byte OCTAVE_3,$05,$77,$C7,$77,$C7,$05,$77,$C7
    .byte $77,$C7,$05,$77,$C7,$77,$C7,$05,$77,$C7,$77,$C7,$05,$77,$C7,$77
    .byte $C7,$05,$97,$C7,$97,$C7,$05,$77,$C7,$77,$C7,OCTAVE_2,$95,OCTAVE_3,$47,$C7
    .byte $47,$C7,$25,$97,$C7,$97,$C7,$25,$A7,$C7,$A7,$C7,$25,$B7,$C7,$B7
    .byte $C7,OCTAVE_2,$75,OCTAVE_3,$77,$C7,$77,$C7,$05,$77,$C7,$77,$C7,OCTAVE_2,$B5,OCTAVE_3
    .byte $77,$C7,$77,$C7,OCTAVE_2,$A5,OCTAVE_3,$47,$C7,$47,$C7,OCTAVE_2,$95,OCTAVE_3,$47,$C7
    .byte $47,$C7,$25,$97,$C7,$97,$C7,$35,$97,$C7,$97,$C7,$45,$B7,$C7,$B7
    .byte $C7,$45,$87,$C7,$87,$C7,$55,OCTAVE_4,$07,$C7,$07,$C7,OCTAVE_3,$55,OCTAVE_4,$07
    .byte $C7,$07,$C7,OCTAVE_3,$07,$C7,$27,$C7,$47,$C7,$77,$C7,$C3,$C2,$C2,$C2
    .byte OCTAVE_2,$77,$C7,$97,$C7,$B7,$C7
    .byte LOOP_FOREVER
    .word S1LOOP2

SHOP_SQ3:
    .byte VOLUME_QRTR,TEMPO,$04,$C5,LOOP_FOREVER
    .word SHOP_SQ1

SHOP_SQ4:
    .byte VOLUME_QRTR,TEMPO,$04,$C5,LOOP_FOREVER
    .word SHOP_SQ2

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;              BATTLE                              ;;;;;;;;;;;;;;;;;;;;;;;;;;;;        
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



BATTLE_SQ1:
    .byte DUTY_25
    .byte TEMPO,$02,SPEED_SET,$01,INSTRUMENT,$01
    .byte OCTAVE_2,$3C,$6C,$9C,OCTAVE_3,$0C,$3C,$6C,$9C,OCTAVE_4,$0C,$3C,$6C,$9C,OCTAVE_5,$0C
    .byte $C1,$C3,$C5,$C7,INSTRUMENT,$00,OCTAVE_3,$57
    BLOOP0:
    .byte SPEED_SET,$83,INSTRUMENT,$00,$79,$C9,OCTAVE_4,$29
    .byte $C9,SPEED_SET,$01,INSTRUMENT,$0E,$13,INSTRUMENT,$00,OCTAVE_3,$A7,$97,$75,$77,$97,$A5,$97
    .byte $57,SPEED_SET,$83,$79,$C9,OCTAVE_4,$29,$C9,SPEED_SET,$01,INSTRUMENT,$0E,$14
    .byte INSTRUMENT,$00,OCTAVE_3,$97,SPEED_SET,$83,$A9,$C9,OCTAVE_4,$59,$C9,SPEED_SET,$01,INSTRUMENT,$0E,$42
    .byte INSTRUMENT,$00,$C7,OCTAVE_3,$57,SPEED_SET,$83,$79,$C9,OCTAVE_4,$29,$C9,SPEED_SET,$01,INSTRUMENT,$0E,$13
    .byte INSTRUMENT,$00,OCTAVE_3,$A7,$97,$75,$77,$97,$A5,$97,INSTRUMENT,$00,$57,SPEED_SET,$83
    .byte $79,$C9,OCTAVE_4,$29,$C9,SPEED_SET,$01,INSTRUMENT,$0E,$14,OCTAVE_3,INSTRUMENT,$00,$97,SPEED_SET,$83
    .byte $A9,$C9,OCTAVE_4,$59,$C9,SPEED_SET,$02,INSTRUMENT,$0C,$41
    BLOOP0A:
    .byte SPEED_SET,$01,INSTRUMENT,$00,$C5,$74,$74
    .byte INSTRUMENT,$00,$67,$C7,$C5,$C5,$C5
    .byte LOOP_X,$01
    .word BLOOP0A
    .byte INSTRUMENT,$00,$C5,$24,$34
    .byte $54,$34,$25,$C5,OCTAVE_3,$94,$A4,OCTAVE_4,$04,OCTAVE_3,$A4,$95,$C5,OCTAVE_4,$24,$34
    .byte $54,$34,$25,$C5,OCTAVE_3,$94,$A4,OCTAVE_4,$04,OCTAVE_3,$A4,$95,$75,$65,$75,$95
    .byte $A5,$95,$A5,OCTAVE_4,$05,SPEED_SET,$83,INSTRUMENT,$00,$29,$C9,$29,$C9,$29,$C9,$29,$C9
    .byte $C7,SPEED_SET,$84,INSTRUMENT,$0E,$35,SPEED_SET,$83,INSTRUMENT,$00,$59,$C9,$29,$C9,$C7,SPEED_SET,$84,INSTRUMENT,$0E
    .byte OCTAVE_3,$95,OCTAVE_4,$25,$65,SPEED_SET,$83,INSTRUMENT,$00,$39,$C9,$39,$C9,$39,$C9,$39,$C9
    .byte $C7,SPEED_SET,$84,INSTRUMENT,$0E,$55,SPEED_SET,$83,INSTRUMENT,$00,$79,$C9,$29,$C9,$C7,$29,$09,OCTAVE_3
    .byte $A9,$99,OCTAVE_4,$09,OCTAVE_3,$A9,$99,$79,$A9,$99,$79,$69
    .byte LOOP_FOREVER
    .word BLOOP0

;; JIGS - fixed another bass octave thing with the intro sweep!
;;        and another ... and ... another and... there's a few!

BATTLE_SQ2:
    .byte DUTY_12
    .byte TEMPO,$02
    .byte SPEED_SET,$01,INSTRUMENT,$02,$CC,$CC,OCTAVE_2,OCTAVE_DOWN,$3C,$6C,$9C,OCTAVE_DOWN,$0C,$3C,$6C,$9C,OCTAVE_3,$0C
    .byte $3C,$6C,$9C,OCTAVE_4,$0C,$CC,$C7,$C5,$C5,$C5,$C1
    BLOOP1:
    BLOOP1A:
    .byte SPEED_SET,$82,INSTRUMENT,$0C,OCTAVE_2,$29
    .byte $C9,$29,$C9,$45,$59,$C9,$59,$C9,$45,$29,$C9,$29,$C9,$45,$59,$C9
    .byte $59,$C9,$05,$29,$C9,$29,$C9,$45,$59,$C9,$59,$C9,$45,$29,$C9,$29
    .byte $C9,$45,$59,$29,$49,$79,$59,$49,$29,$09
    .byte LOOP_X,$01
    .word BLOOP1A
    .byte OCTAVE_2,$A9,$C9
    .byte $A9,$C9,OCTAVE_3,SPEED_SET,$01,INSTRUMENT,$01,$34,$34,INSTRUMENT,$01,$27,$C7,OCTAVE_2,OCTAVE_DOWN,$27,$27
    .byte $67,$67,$97,$97,OCTAVE_DOWN,$A9,$C9,$A9,$C9,OCTAVE_3,INSTRUMENT,$01,$34,$34
    .byte INSTRUMENT,$01,$27,$C7,$C7,$69,$79,$69,$39,$29,$09,OCTAVE_2,$A9,$99,$79,$69
    BLOOP1B:
    .byte SPEED_SET,$86,INSTRUMENT,$0B
    .byte OCTAVE_DOWN ; down to 1
    .byte $29,$C9,$29,$C9,OCTAVE_DOWN ; up... 
    .byte $A7,$77,$27
    .byte OCTAVE_3,$07,OCTAVE_2,$77,$37
    .byte OCTAVE_3,$27,OCTAVE_2,$A7,$77
    .byte OCTAVE_3,$07,OCTAVE_2,$77,$37
    .byte $A7,$27
    .byte OCTAVE_DOWN,$99,$C9,$99,$C9,OCTAVE_DOWN
    .byte $67,$27,OCTAVE_DOWN,$97
    .byte OCTAVE_DOWN,$77,$27,OCTAVE_DOWN,$A7
    .byte OCTAVE_DOWN,$97,$67,$27
    .byte $77,$27,OCTAVE_DOWN,$A7
    .byte OCTAVE_DOWN,$67,OCTAVE_DOWN,$97 ; ends on lowest octave
    .byte OCTAVE_DOWN ; adding this to reset the octave down switch so the loop can re-start it... 
    .byte LOOP_X,$01
    .word BLOOP1B
    
    .byte OCTAVE_DOWN ; adding this to undo the one added! ugh
    .byte SPEED_SET,$83,INSTRUMENT,$01
    .byte $A9,$C9
    .byte OCTAVE_DOWN ; previous loop ended on lowest, so this would be going up. vv - ends on up again
    .byte $29,$C9,OCTAVE_DOWN,$99,$C9,OCTAVE_DOWN,$29,$C9,OCTAVE_DOWN,$A9,$C9,OCTAVE_DOWN,$29,$C9,$09
    .byte $C9,$39,$C9,$29,$C9,$59,$C9,$09,$C9,$59,$C9,$29,$C9,$59,$C9,$39
    .byte $C9,$79,$C9,$69,$C9,$69,$C9,$69,$C9,$69,$C9,$C7,SPEED_SET,$84,INSTRUMENT,$0E,$75
    .byte SPEED_SET,$83,INSTRUMENT,$01,$99,$C9,$69,$C9,$C7,SPEED_SET,$84,INSTRUMENT,$0E,$25,$95,OCTAVE_3,$25,SPEED_SET,$83
    .byte INSTRUMENT,$01,OCTAVE_2,$79,$C9,$79,$C9,$79,$C9,$79,$C9,$C7,SPEED_SET,$84,INSTRUMENT,$0E,$95
    .byte SPEED_SET,$83,INSTRUMENT,$01,$A9,$C9,$69,$C9,$C7,$C5,$C5,$C5
    .byte LOOP_FOREVER
    .word BLOOP1

BATTLE_SQ3:
    .byte VOLUME_QRTR,TEMPO,$02,$C5,LOOP_FOREVER
    .word BATTLE_SQ1

BATTLE_SQ4:
    .byte VOLUME_QRTR,TEMPO,$02,$C5,LOOP_FOREVER
    .word BATTLE_SQ2

BATTLE_TRI:
    .byte TEMPO,$02
    .byte $C3
    BLOOP2A:
    .byte OCTAVE_2,$79,$C9,$79,$C9,$79,$C9,$79,$C9,$79,$C9,$79,$C9
    .byte $59,$C9,$59,$C9
    .byte LOOP_X,$01
    .word BLOOP2A
    BLOOP2:
    BLOOP2B:
    .byte $77,OCTAVE_3,$79,$C9,OCTAVE_2,$97,OCTAVE_3,$99,$C9
    .byte OCTAVE_2,$A7,OCTAVE_3,$A9,$C9,$07,OCTAVE_4,$09,$C9,OCTAVE_2,$77,OCTAVE_3,$79,$C9,OCTAVE_2,$97
    .byte OCTAVE_3,$99,$C9,OCTAVE_2,$A7,OCTAVE_3,$A9,$C9,OCTAVE_2,$97,OCTAVE_3,$99,$C9
    .byte LOOP_X,$03
    .word BLOOP2B
    .byte $39,$C9,$39,$C9,OCTAVE_4,$A9,$99,$79,$69,$39,$29,$09,OCTAVE_3,$A9,$99,$79
    .byte $69,$39,$27,$C7,$69,$C9,$69,$C9,$99,$C9,$99,$C9,OCTAVE_4,$29,$C9,$29
    .byte $C9,OCTAVE_3,$39,$C9,$39,$C9,OCTAVE_4,$A9,$99,$79,$69,$39,$29,$09,OCTAVE_3,$A9
    .byte $99,$79,$69,$39,$27,$C7,$C7,OCTAVE_5,$29,$39,$29,$09,OCTAVE_4,$A9,$99,$79
    .byte $69,$39,$29
    BLOOP2C:
    .byte OCTAVE_2,$79,$C9,$79,$C9,OCTAVE_3,$77,OCTAVE_2,$79,$C9,$79,$C9,OCTAVE_3
    .byte $77,OCTAVE_2,$79,$C9,$79,$C9,OCTAVE_3,$77,OCTAVE_2,$79,$C9,$79,$C9,OCTAVE_3,$77,OCTAVE_2
    .byte $79,$C9,$79,$C9,OCTAVE_3,$77,OCTAVE_2,$79,$C9,$29,$C9,$29,$C9,OCTAVE_3,$27,OCTAVE_2
    .byte $29,$C9,$29,$C9,OCTAVE_3,$27,OCTAVE_2,$29,$C9,$29,$C9,OCTAVE_3,$27,OCTAVE_2,$29,$C9
    .byte $29,$C9,OCTAVE_3,$27,OCTAVE_2,$29,$C9,$29,$C9,OCTAVE_3,$27,OCTAVE_2,$29,$C9
    .byte LOOP_X,$01
    .word BLOOP2C
    .byte $75,OCTAVE_3,$25,OCTAVE_2,$A5,OCTAVE_3,$55,OCTAVE_2,$A5,OCTAVE_3,$55,OCTAVE_2,$A5,OCTAVE_3,$05
    .byte $29,$C9,$29,$C9,$29,$C9,$29,$C9,$C7,$07,$C7,$09,$C9,$29,$C9,$C7
    .byte OCTAVE_4,$05,$75,OCTAVE_5,$05,OCTAVE_3,$39,$C9,$39,$C9,$39,$C9,$39,$C9,$C7,$37
    .byte $C7,$39,$C9,$29,$C9,$C7,$25,$45,$65
    .byte LOOP_FOREVER
    .word BLOOP2

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;                 MENU                             ;;;;;;;;;;;;;;;;;;;;;;;;;;;;        
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


MENU_SQ1:
    .byte DUTY_25
    .byte TEMPO,$03
    MLOOP0:
    .byte SPEED_SET,$01,INSTRUMENT,$0E
    .byte OCTAVE_3,$A3,OCTAVE_4,$A5,$93,$35,$23,$75,$53,OCTAVE_3,$A5,$B1,$C5,OCTAVE_4,$25,$03
    .byte OCTAVE_3,$71,$71,$95,$B5,OCTAVE_4,$07,OCTAVE_3,$77,$97,$B7,OCTAVE_4,$07,$27,$37,$57
    .byte $77,$87,$A7,OCTAVE_5,$07,OCTAVE_4,$A1,$C5,$97,$77,$91,OCTAVE_3,$75,$95
    .byte LOOP_FOREVER
    .word MLOOP0

MENU_SQ2:
    .byte DUTY_12
    .byte TEMPO,$03
    MLOOP1:
    .byte SPEED_SET,$01,INSTRUMENT,$03,OCTAVE_3,$A3,OCTAVE_4,$A5,$93,$35,$23,$75,$53,OCTAVE_3,$A5
    .byte $B1,$C5,OCTAVE_4,$25,$03,OCTAVE_3,$71,$71,$95,$B5,OCTAVE_4,$07,OCTAVE_3,$77,$97,$B7
    .byte OCTAVE_4,$07,$27,$37,$57,$77,$87,$A7,OCTAVE_5,$07,OCTAVE_4,$A1,$C5,$97,$77,$91
    .byte OCTAVE_3,$75,$95
    .byte LOOP_FOREVER
    .word MLOOP1

MENU_SQ3:
    .byte VOLUME_QRTR,TEMPO,$03,$C4,LOOP_FOREVER
    .word MENU_SQ1

MENU_SQ4:
    .byte VOLUME_QRTR,TEMPO,$03,$C5,LOOP_FOREVER
    .word MENU_SQ2

MENU_TRI:
    .byte TEMPO,$03
    MLOOP2:
    .byte OCTAVE_3,$A5,OCTAVE_4,$25,$55,OCTAVE_3
    .byte $A5,OCTAVE_4,$35,$95,OCTAVE_3,$A5,OCTAVE_4,$25,$55,OCTAVE_3,$95,OCTAVE_4,$25,$55,OCTAVE_3,$85
    .byte $B5,OCTAVE_4,$25,OCTAVE_3,$75,$B5,OCTAVE_4,$25,OCTAVE_3,$75,OCTAVE_4,$05,$35,OCTAVE_3,$B5,OCTAVE_4
    .byte $25,$55,OCTAVE_3,$75,OCTAVE_4,$05,$35,OCTAVE_3,$75,OCTAVE_4,$25,$55,OCTAVE_3,$75,OCTAVE_4,$35
    .byte $75,OCTAVE_3,$85,OCTAVE_4,$05,$35,OCTAVE_3,$55,OCTAVE_4,$05,$55,OCTAVE_3,$55,OCTAVE_4,$05,$75
    .byte OCTAVE_3,$55,OCTAVE_4,$05,$55,OCTAVE_3,$35,OCTAVE_4,$05,$35
    .byte LOOP_FOREVER
    .word MLOOP2
    
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;                GAME OVER                         ;;;;;;;;;;;;;;;;;;;;;;;;;;;;        
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    

SLAIN_SQ1:
    .byte DUTY_25
    .byte TEMPO,$03,SPEED_SET,$81
    .byte INSTRUMENT,$05,OCTAVE_3,$95,OCTAVE_4,$15,$25,$45
    SLAIN_LOOP0:
    .byte $52,OCTAVE_3,$95,$A3,OCTAVE_4,$75,$55,$45,$55
    .byte $45,OCTAVE_3,$75,$91,OCTAVE_4,$22,OCTAVE_3,$55,$43,$B5,OCTAVE_4,$25,$25,$15,$42,$15
    .byte $25,$45,$52,OCTAVE_3,$95,$A3,OCTAVE_4,$75,$55,$45,$55,$45,OCTAVE_3,$75,$93,$A5
    .byte OCTAVE_4,$05,$22,$45,$23,$13,$21,$C1
    .byte LOOP_FOREVER
    .word SLAIN_LOOP0

SLAIN_SQ2:
    .byte DUTY_12
    .byte TEMPO,$03,SPEED_SET,$81,INSTRUMENT,$06,$C1
    SLAIN_LOOP1:
    .byte OCTAVE_3,$93,$53,$73,$A3,$73,$43,$53,$03,$53,$23,OCTAVE_2,$B3,OCTAVE_3,$83,$91
    .byte $71,OCTAVE_3,$93,$53,$73,$A3,$73,$43,$53,$03,$53,$93,$73,$43,$51,$C1
    .byte LOOP_FOREVER
    .word SLAIN_LOOP1

SLAIN_SQ3:
    .byte VOLUME_QRTR,TEMPO,$03,$C4,LOOP_FOREVER
    .word SLAIN_SQ1

SLAIN_SQ4:
    .byte VOLUME_QRTR,TEMPO,$03,$C5,LOOP_FOREVER
    .word SLAIN_SQ2

SLAIN_TRI:
    .byte TEMPO,$03,$C1
    SLAIN_LOOP2:
    .byte OCTAVE_4,$21,$71,$01,$51,OCTAVE_3,$A1,OCTAVE_4
    .byte $41,OCTAVE_3,$91,OCTAVE_4,$93,$43,OCTAVE_4,$21,$71,$01,$51,OCTAVE_3,$B1,$91,OCTAVE_5,$25
    .byte OCTAVE_4,$95,$75,$95,$22,$C5
    .byte LOOP_FOREVER
    .word SLAIN_LOOP2

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;              BATTLE FANFARE                      ;;;;;;;;;;;;;;;;;;;;;;;;;;;;        
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


BATTLEWIN_SQ1:
    .byte DUTY_25
    .byte TEMPO,$02,SPEED_SET,$01,INSTRUMENT,$01,OCTAVE_2,$3C,$7C
    .byte $AC,OCTAVE_2,$3C,$7C,$AC,OCTAVE_3,$3C,$7C,$AC,OCTAVE_4,$3C,$7C,$AC,INSTRUMENT,$0C
    .byte OCTAVE_5,$3C,$CC,$3C,$CC,$3C,$CC,$35,OCTAVE_4,$B5,OCTAVE_5,$15,SPEED_SET,$83,$3C,$CC
    .byte $CC,$CC,$1C,$CC,SPEED_SET,$01,INSTRUMENT,$0E,$32
    FLOOP0:
    .byte INSTRUMENT,$0C,OCTAVE_3,$A5,$85,$A5,$87
    .byte OCTAVE_4,$15,OCTAVE_4,$17,$05,$17,$05,$07,OCTAVE_3,$A5,$85,$75,$87,INSTRUMENT,$0E
    .byte $51,$C7,INSTRUMENT,$0C,$A5,$85,$A5,$87,OCTAVE_4,$15,$17,$05,$17,$05,$07
    .byte OCTAVE_3,$A5,$85,$A5,OCTAVE_4,$17,INSTRUMENT,$0E,$31,$C7
    .byte LOOP_FOREVER
    .word FLOOP0

BATTLEWIN_SQ2:
    .byte DUTY_12
    .byte TEMPO,$02,SPEED_SET,$01
    .byte INSTRUMENT,$02,$CC,$CC,OCTAVE_2,$3C,$7C,$AC,OCTAVE_2,$3C,$7C,$AC,OCTAVE_3,$3C,$7C,$AC
    .byte OCTAVE_4,$3C,INSTRUMENT,$0C,$7C,$CC,$7C,$CC,$7C,$CC,$75,$35,$55,SPEED_SET,$83
    .byte $7C,$CC,$CC,$CC,$5C,$CC,SPEED_SET,$01,INSTRUMENT,$0E,$72
    BATTLEWIN_LOOP1:
    .byte INSTRUMENT,$0C,OCTAVE_3,$75,$55
    .byte $75,$57,$55,$57,$35,$57,$35,$37,$75,$55,$35,$57,INSTRUMENT,$0E,$11
    .byte $C7,INSTRUMENT,$0C,OCTAVE_3,$75,$55,$75,$57,$55,$57,$35,$57,$35,$37,$75
    .byte $55,$75,$A7,INSTRUMENT,$0E,$B1,$C7
    .byte LOOP_FOREVER
    .word BATTLEWIN_LOOP1

BATTLEWIN_SQ3:
    .byte VOLUME_QRTR,TEMPO,$02,$C5,LOOP_FOREVER
    .word BATTLEWIN_SQ1

BATTLEWIN_SQ4:
    .byte VOLUME_QRTR,TEMPO,$02,$C5,LOOP_FOREVER
    .word BATTLEWIN_SQ2

BATTLEWIN_TRI:
    .byte TEMPO,$02,$C3
    .byte OCTAVE_4,$3C,$CC,OCTAVE_3,$AC,$CC,$7C,$CC,$35,$65,$85,$3C,$CC,$CC,$CC,$3C
    .byte $CC,$37,$C7,$37,$C7,$37,$C7
    BATTLEWIN_LOOP2:
    .byte OCTAVE_3,$37,$A9,$C9,$37,$A9,$C9,$37,$A9
    .byte $C9,$37,$A9,$C9,$17,$89,$C9,$17,$89,$C9,$17,$89,$C9,$17,$89,$C9
    .byte $37,$A9,$C9,$37,$A9,$C9,$37,$A9,$C9,$37,$A9,$C9,$17,$89,$C9,$17
    .byte $89,$C9,$17,$89,$C9,$17,$89,$C9,$37,$A9,$C9,$37,$A9,$C9,$37,$A9
    .byte $C9,$37,$A9,$C9,$17,$89,$C9,$17,$89,$C9,$17,$89,$C9,$17,$89,$C9
    .byte $37,$A9,$C9,$37,$A9,$C9,$37,$A9,$C9,$37,$A9,$C9,OCTAVE_2,$B7,OCTAVE_3,$69
    .byte $C9,OCTAVE_2,$B7,OCTAVE_3,$69,$C9,OCTAVE_2,$B7,OCTAVE_3,$69,$C9,OCTAVE_2,$B7,OCTAVE_3,$69,$C9
    .byte LOOP_FOREVER
    .word BATTLEWIN_LOOP2

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;             KEY ITEM COLLECT                     ;;;;;;;;;;;;;;;;;;;;;;;;;;;;        
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

FANFARE_SQ1:
    .byte DUTY_25
    .byte TEMPO,$04,SPEED_SET,$01,INSTRUMENT,$0C,OCTAVE_4,$45,$25,$15,$45,$25,$15,OCTAVE_3,$B5,OCTAVE_4,$25
    .byte INSTRUMENT,$0E,TEMPO,$03,OCTAVE_3,$93,TEMPO,$02,$B3,OCTAVE_4,$12,END_SONG

FANFARE_SQ2:
    .byte DUTY_12
    .byte TEMPO,$04,SPEED_SET,$01,INSTRUMENT,$0E,OCTAVE_3,$91,$71,TEMPO,$03,$03,TEMPO,$02,$23,$42,END_SONG

FANFARE_TRI:
    .byte TEMPO,$04,OCTAVE_4,$13,$43,OCTAVE_3,$B3,OCTAVE_4,$23,TEMPO,$03,OCTAVE_3,$53,TEMPO,$02,$73
    .byte $92,END_SONG

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;            GAME SAVED                            ;;;;;;;;;;;;;;;;;;;;;;;;;;;;        
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


SAVE_SQ1:
    .byte DUTY_25
    .byte TEMPO,$02,SPEED_SET,$82,INSTRUMENT,$0C,OCTAVE_3,$BC,OCTAVE_4,$0C,$1C,SPEED_SET,$01,INSTRUMENT,$0C,TEMPO,$04,$24,$27,$27
    .byte $27,INSTRUMENT,$0E,TEMPO,$03,$34,TEMPO,$02,$54,$72,END_SONG

SAVE_SQ2:
    .byte DUTY_12
    .byte TEMPO,$02,SPEED_SET,$01,INSTRUMENT,$0C,$CC,$CC,$CC,TEMPO,$04,OCTAVE_3,$74,$B7,$97,$77,INSTRUMENT,$0E
    .byte TEMPO,$03,$74,TEMPO,$02,OCTAVE_4,$04,OCTAVE_3,$B2,END_SONG

SAVE_TRI:
    .byte TEMPO,$02,$CC,$CC,$CC,TEMPO,$04,OCTAVE_3,$B4,OCTAVE_4,$27,$07,OCTAVE_3,$B7,TEMPO,$03
    .byte $A4,TEMPO,$02,$94,$73,END_SONG
    
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;               HEALING SFX                        ;;;;;;;;;;;;;;;;;;;;;;;;;;;;        
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    
;; JIGS - fixed the bass notes
HEAL_SQ1:
    .byte DUTY_25
    .byte TEMPO,$02,SPEED_SET,$01,INSTRUMENT,$01,OCTAVE_2,OCTAVE_DOWN,$AC,OCTAVE_DOWN,$2C,$5C,$AC,OCTAVE_3,$2C,$5C,$AC,OCTAVE_4,$2C
    .byte $5C,$AC,OCTAVE_5,$2C,$5C,$AC,END_SONG

HEAL_SQ2:
    .byte DUTY_12
    .byte TEMPO,$02,SPEED_SET,$01,INSTRUMENT,$02,$C7,OCTAVE_2,OCTAVE_DOWN,$AC,OCTAVE_DOWN,$2C,$5C,$AC,OCTAVE_3,$2C,$5C,$AC,OCTAVE_4
    .byte $2C,$5C,$AC,OCTAVE_5,$2C,$5C,$AC,END_SONG

HEAL_TRI:
    .byte TEMPO,$02,$C7,$C7,OCTAVE_2,$CC,$CC,OCTAVE_3,$CC,$CC,$CC,OCTAVE_4,$CC,$CC
    .byte $CC,OCTAVE_5,$CC,$CC,$CC,OCTAVE_2,OCTAVE_DOWN,$CC,$CC,END_SONG

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;             COMMON TREASURE COLLECT              ;;;;;;;;;;;;;;;;;;;;;;;;;;;;        
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


TREASURE_SQ1:
    .byte DUTY_25
    .byte TEMPO,$03,SPEED_SET,$81,INSTRUMENT,$00,OCTAVE_4,$79,$B9,OCTAVE_5,$39,$79,$B9,END_SONG

TREASURE_SQ2:
    .byte DUTY_12
    .byte TEMPO,$03,SPEED_SET,$81,INSTRUMENT,$01,OCTAVE_3,$B9,OCTAVE_4,$39,$79,$B9,OCTAVE_5,$39,END_SONG

TREASURE_TRI:
    .byte TEMPO,$03,$C9,$C9,$C9,$C9,$C9,END_SONG

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;               BLANK TRACK                        ;;;;;;;;;;;;;;;;;;;;;;;;;;;;        
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


BLANK:   ; For songs that need to loop
    ;.byte VOLUME_MINUS,$0F ; custom silencer on; subtract $0F from volume
    .byte TEMPO,$00      ; note length LUT with longest note
    .byte INSTRUMENT,$0F ; envelope pattern that starts with the quietest note
    .byte SPEED_SET,$7F  ; slowest envelope update speed (127 frames before the next value!)
BLANK_LOOP:
    .byte $C0            ; play a 192-frames long silence
    .byte LOOP_FOREVER   ; loop forever
    .word BLANK_LOOP
    
BLANK_TRI:
    .byte TEMPO,$00
    BLANK_TRI_LOOP:
    .byte $C0
    .byte LOOP_FOREVER
    .word BLANK_TRI_LOOP

;BLANK2: ; For songs that need to end. (note that using this will cause a song to end prematurely once it hits the FF. So... useless. Oops.)
;.byte TEMPO,$01,$CA,END_SONG

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;        OLD MARSH CAVE MINI BOSS BATTLE           ;;;;;;;;;;;;;;;;;;;;;;;;;;;;        
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


MARSHBOSS_SQ1:
    .byte DUTY_25     ;duty set 25%
    .byte TEMPO,$02         ;tempo FB
    .byte SPEED_SET,$01,INSTRUMENT,$01 ;envelope speed $08, pattern 1, gradual decay from C
    .byte OCTAVE_2,$3C,$6C,$9C,OCTAVE_3,$0C,$3C,$6C,$9C,OCTAVE_4,$0C,$3C,$6C,$9C,OCTAVE_5,$0C
    .byte $C0,$C3     ; long rest; two bars
    .byte LOOP_FOREVER
    .word MARSHCAVEOLD_SQ1

MARSHBOSS_SQ2:
    .byte DUTY_12     ; duty set 12.5%
    .byte TEMPO,$02         ; tempo FB
    .byte SPEED_SET,$01,INSTRUMENT,$02 ; envelope speed $08, pattern 2, gradual decay from 8
    .byte $CE         ; evil confusing rest that messes it all up for a tiny echo effect
    .byte OCTAVE_2,$3C,$6C,$9C,$0C,$3C,$6C,$9C,OCTAVE_3,$0C,$3C,$6C,$9C,OCTAVE_4,$0C
    ;; $_E ^ of a pause, so this one is 14 thingies off instead of 12
    .byte $C0,$C4,$CC ; long rest, $B8 in length...
    .byte LOOP_FOREVER
    .word MARSHCAVEOLD_SQ2

MARSHBOSS_TRI:
    .byte TEMPO,$02,$C3
    @MARSHBOSS_TRILOOP:
    ;.byte OCTAVE_3,$07,$C5,$07,$C5,$C5,$07,$C7,$07,$C7,$07,$C7,$57,$C5,$57,$C5,$57,$C5
    ;.byte $57,$C5,$57,$C7
    .byte OCTAVE_3,$09,$C9,$09,$C9,$09,$C9,$09,$C9,$09,$C9,$09,$C9,OCTAVE_2,$A9,$C9,$A9,$C9
    .byte LOOP_X,$01
    .word @MARSHBOSS_TRILOOP
    .byte LOOP_FOREVER
    .word MARSHCAVEOLD_TRI

MARSHBOSS_SQ3:
    .byte VOLUME_QRTR,TEMPO,$02,$C5,LOOP_FOREVER
    .word MARSHBOSS_SQ1

MARSHBOSS_SQ4:


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;          FIEND BATTLE (arranged by Jiggers)      ;;;;;;;;;;;;;;;;;;;;;;;;;;;;        
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


BOSS_SQ1:
    .byte DUTY_25     ;duty set 25%
    .byte TEMPO,$02     ;tempo FB
    .byte SPEED_SET,$01,INSTRUMENT,$01 ;envelope speed $08, pattern 1, gradual decay from C
    .byte OCTAVE_2,$3C,$6C,$9C,OCTAVE_3,$0C,$3C,$6C,$9C,OCTAVE_4,$0C,$3C,$6C,$9C,OCTAVE_5,$0C
    .byte $C0,$C5     ; long rest; one and a half bars + a quarter note
    .byte DUTY_50     ;duty set 50%
    ;.byte OCTAVE_3,$2A,$5A,$8A,$AA

BOSS_SQ1START:
    .byte OCTAVE_3,$0A,$2A,$3A,$5A,$7A,$8A,$AA,$BA
    .byte SPEED_SET,$04    ; envelope speed $0C
    .byte INSTRUMENT,$0C     ;  decay from F with tremolo
    ;; Temple of Fiends bit
    .byte OCTAVE_4,$03,OCTAVE_3,$75,OCTAVE_4,$75
    .byte $55,$35,$26,$3A,$2A,$05
    .byte $34,$2C,$3C,$2C,$00
    ;;EMPTY BAR
    .byte $03,OCTAVE_3,$75,OCTAVE_4,$76,$8A,$9A
    .byte $A5,$87,$8C,$AC,$8C,$75,$55
    .byte $70
    .byte $35,$55
    .byte $63,OCTAVE_3,$A5,OCTAVE_4,$35
    .byte $25,$05,$25,$35
    .byte $03,OCTAVE_3,$73
    .byte $A2,$75
    .byte $85,OCTAVE_4,$05,$55,$35
    .byte OCTAVE_3,$B3,OCTAVE_4,$15,$35
    .byte $31
    .byte SPEED_SET,$03    ; envelope speed $0B
    .byte $21
    ;;Sky Temple bit
    .byte VOLUME_HALF      ; half volume
    .byte $25,$29,$39,$29,$09,$20
    ;;EMPTY BAR
    .byte OCTAVE_3,$75,$79,$89,$79,$59,$70
    ;;EMPTY BAR
    .byte $25,$29,$39,$29,$09,$20
    ;;EMPTY,$BAR
    .byte $05,$09,$29,$09,OCTAVE_2,$A9,OCTAVE_3,$03
    ;;Transition to Sea Shrine bit:
    .byte SPEED_SET,$02    ; envelope speed $09
    .byte $05              ; volume is at 8
    .byte VOLUME_HALF      ; un-half volume
    .byte INSTRUMENT,$0D     ; decay from C with tremolo
    .byte $05
    .byte INSTRUMENT,$0C     ; decay from F with tremolo
    .byte $05
    .byte $25
    ;;Sea Shrine bit
    .byte SPEED_SET,$04    ; envelope speed $0C
    .byte $33,$05,$35
    .byte $25,$05,OCTAVE_2,$A5,OCTAVE_3,$25
    .byte $00
    .byte $C3
    .byte $33,$55,$35
    .byte $25,$05,OCTAVE_2,$A5,OCTAVE_3,$85
    .byte $72,$89,$79,$57
    .byte $71
    .byte $23,$35,$55
    .byte $35,$25,$05,$75
    .byte $53,$75,$85
    .byte $73,$33
    .byte $03,$75,$55
    .byte $35,$25,$05,$35
  ;  .byte SPEED_SET,$03   ; envelope speed $0B
    .byte $21
    .byte INSTRUMENT,$0F     ; fade in then out with tremolo
    .byte $21
    ;; wrap up / Sky Castle thing reprise
    .byte $C5
    .byte INSTRUMENT,$0C     ;  decay from F with tremolo
    .byte $29,$39,$29,$09,$21
    .byte $C5
    .byte LOOP_FOREVER
    .word BOSS_SQ1START



BOSS_SQ2:
    .byte DUTY_12     ; duty set 12.5%
    .byte TEMPO,$02     ; tempo FB
    .byte SPEED_SET,$01,INSTRUMENT,$02 ; envelope speed $08, pattern 2, gradual decay from 8
    .byte $CE         ; evil confusing rest that messes it all up for a tiny echo effect
    .byte OCTAVE_2,$3C,$6C,$9C,$0C,$3C,$6C,$9C,OCTAVE_3,$0C,$3C,$6C,$9C,OCTAVE_4,$0C
    ;; $_E ^ of a pause, so this one is 14 thingies off instead of 12
    .byte $C0,$C4,$CC ; long rest, $B8 in length...


    BOSS_SQ2START:
    .byte OCTAVE_3,$79,$39,$09,$39,$29,$39,$79,$39,$09,OCTAVE_2,$79,$39,$79,$A9,$79,$A9,$79
    .byte OCTAVE_3,$59,$29,OCTAVE_2,$A9,OCTAVE_3,$29,$09,$29,$59,$29,OCTAVE_2,$A9,$59,$29,$59,$89,$59,$29,$59
    .byte $39,$89,OCTAVE_3,$09,$39,OCTAVE_2,$A9,OCTAVE_3,$39,$09,$39,$89,$39,$09,$39,$79,$39,$09,LOOP_SWITCH
    .word BOSS_SQSTART_FIENDTEMPLEPART1_ALTEND
    .byte $39
    .byte $59,$39,$09,$89,OCTAVE_4,$39,$29,$09,$89,$59,$29,OCTAVE_3,$A9,$59,$29,OCTAVE_4,$29,OCTAVE_3,$A9,$59
    .byte LOOP_X,$01
    .word BOSS_SQ2START

    BOSS_SQSTART_FIENDTEMPLEPART1_ALTEND:
    .byte $29
    .byte $39,$29,$09,$39,$89,$79,OCTAVE_4,$09,OCTAVE_3,$A9,$39,$29,$09,$39,$89,$79,$29,$09

    BOSS_SQ2_FIENDTEMPLEPART2_START:
    .byte OCTAVE_2,$A7,OCTAVE_3,$67,$37,$67,OCTAVE_2,$A7,OCTAVE_3,$67,$37,$67
    .byte OCTAVE_2,$A7,OCTAVE_3,$57,$37,$57,$27,$57,$37,$57
    .byte $07,$37,$27,$37,$07,$37,$27,$37
    .byte OCTAVE_2,$A7,OCTAVE_3,$27,$07,$27,OCTAVE_2,$A7,OCTAVE_3,$27,$07,$27
    .byte $37,$87,$77,$87,$37,$87,$77,$87
    .byte $37,$B7,$87,$37,$B7,$87,$37,$B7
    .byte $A7,OCTAVE_4,$67,$37,$27,OCTAVE_3,$A7,$67,$37,$27
    .byte OCTAVE_4,$27,OCTAVE_3,$A7,$87,$77,$57,$87,$77,$27

    .byte INSTRUMENT,$01 ;  gradual decay from C
    .byte SCORE_GOTO
    .word BOSS_SQ2_SEASHRINE_START
    .byte INSTRUMENT,$02 ;  gradual decay from 8
    .byte SCORE_GOTO
    .word BOSS_SQ2_SEASHRINE_START
    .byte SCORE_GOTO
    .word BOSS_SQ2_SEASHRINE_TRILLS_BAR1_3
    .byte SCORE_GOTO
    .word BOSS_SQ2_SEASHRINE_TRILLS_BAR2_5
    .byte SCORE_GOTO
    .word BOSS_SQ2_SEASHRINE_TRILLS_BAR1_3
    .byte SCORE_GOTO
    .word BOSS_SQ2_SEASHRINE_TRILLS_BAR4
    .byte SCORE_GOTO
    .word BOSS_SQ2_SEASHRINE_TRILLS_BAR2_5
    .byte SCORE_GOTO
    .word BOSS_SQ2_SEASHRINE_TRILLS_BAR6
    .byte SCORE_GOTO
    .word BOSS_SQ4_TRILLS_BAR1
    .byte SCORE_GOTO
    .word BOSS_SQ4_TRILLS_BAR2
    .byte SCORE_GOTO
    .word BOSS_SQ2_SEASHRINE_TRILLS_BAR9
    .byte LOOP_FOREVER
    .word BOSS_SQ2START


    BOSS_SQ2_SEASHRINE_START:
    .byte OCTAVE_2,$77,OCTAVE_3,$37,$27,$37,$07,$37,OCTAVE_2,$A7,OCTAVE_3,$37
    .byte OCTAVE_2,$57,OCTAVE_3,$27,$07,$27,OCTAVE_2,$A7,OCTAVE_3,$27,OCTAVE_2,$87,OCTAVE_3,$27
    .byte OCTAVE_2,$37,OCTAVE_3,$07,OCTAVE_2,$A7,OCTAVE_3,$07,OCTAVE_2,$87,OCTAVE_3,$07,OCTAVE_2,$77,OCTAVE_3,$07
    .byte LOOP_SWITCH
    .word BOSS_SQ2_SEASHRINE_PART1_ALTEND
    .byte OCTAVE_2,$57,OCTAVE_3,$07,OCTAVE_2,$37,OCTAVE_3,$27,OCTAVE_2,$57,OCTAVE_3,$27,OCTAVE_2,$A7,OCTAVE_3,$27
    .byte LOOP_X,$01
    .word BOSS_SQ2_SEASHRINE_START

    BOSS_SQ2_SEASHRINE_PART1_ALTEND:
    .byte OCTAVE_2,$37,OCTAVE_3,$07,OCTAVE_2,$87,OCTAVE_3,$07
    .byte LOOP_X,$01
    .word BOSS_SQ2_SEASHRINE_PART1_ALTEND
    .byte SCORE_RETURN

    BOSS_SQ2_SEASHRINE_TRILLS_BAR1_3:
    .byte $5A,$2A,$5A,$2A
    .byte LOOP_X,$07
    .word BOSS_SQ2_SEASHRINE_TRILLS_BAR1_3
    .byte SCORE_RETURN

    BOSS_SQ2_SEASHRINE_TRILLS_BAR2_5:
    .byte $3A,$0A,$3A,$0A
    .byte LOOP_X,$07
    .word BOSS_SQ2_SEASHRINE_TRILLS_BAR2_5
    .byte SCORE_RETURN

    BOSS_SQ2_SEASHRINE_TRILLS_BAR4:
    .byte $7A,$3A,$7A,$3A
    .byte LOOP_X,$07
    .word BOSS_SQ2_SEASHRINE_TRILLS_BAR4
    .byte SCORE_RETURN

    BOSS_SQ2_SEASHRINE_TRILLS_BAR6:
    .byte $5A,$0A,$5A,$0A
    .byte LOOP_X,$07
    .word BOSS_SQ2_SEASHRINE_TRILLS_BAR6
    .byte SCORE_RETURN
    .byte OCTAVE_2

    BOSS_SQ2_SEASHRINE_TRILLS_BAR9:
    .byte $BA,$5A,$BA,$5A,$BA,$5A,$BA,$5A
    .byte LOOP_X,$07
    .word BOSS_SQ2_SEASHRINE_TRILLS_BAR9
    .byte SCORE_RETURN


BOSS_SQ3:
    .byte TEMPO,$02               ; tempo FB
    .byte $C0,$C1               ; two and a half bar pause
    .byte DUTY_25               ; duty set 25%
    BOSS_SQ3START:
    .byte SPEED_SET,$04         ; envelope speed $0C
    .byte INSTRUMENT,$08          ; hold, then decay from C
    .byte OCTAVE_2,$01
    .byte OCTAVE_DOWN,$A1       ; octave down, now 1
    .byte $81
    .byte $83,$A3
    .byte OCTAVE_DOWN,$01       ; undo octave down; now octave 2
    .byte OCTAVE_DOWN,$A1       ; down again to 1
    .byte $91
    .byte $81
    .byte SPEED_SET,$01         ; envelope speed $08
    .byte INSTRUMENT,$01          ; gradual decay from C
    .byte OCTAVE_DOWN           ; undo down, now 2
    .byte $37,$A5,$A7,$37,$A5,$A7
    .byte $57,$A5,$A7,$57,$A5,$A7
    .byte $37,OCTAVE_3,$05,$07,OCTAVE_2,$37,OCTAVE_3,$05,$07
    .byte OCTAVE_2,$77,OCTAVE_3,$25,$27,OCTAVE_2,$77,OCTAVE_3,$25,$27
    .byte OCTAVE_2,$87,OCTAVE_3,$35,$37,OCTAVE_2,$87,OCTAVE_3,$35,$37
    .byte OCTAVE_2,$37,$B5,$B7,$37,$B5,$B7
    .byte $67,OCTAVE_3,$67,$37,OCTAVE_2,$67,OCTAVE_3,$67,$35,$67
    .byte OCTAVE_2,$A7,OCTAVE_3,$A7,$87,$37,OCTAVE_2,$A7,$85,$77

    BOSS_SQ3_SEASHRINE_INTRO:
    .byte $07,$07,$C2
    .byte OCTAVE_DOWN           ; 1
    .byte $A7,$A7,$C2
    .byte $87,$87,$C2
    .byte $87,$87,$C5,$A7,$A7,$C5
    .byte OCTAVE_DOWN           ; 2
    .byte $07,$07,$C2
    .byte OCTAVE_DOWN           ; 1
    .byte $A7,$A7,$C2
    .byte $87,$87,$C2
    .byte $87,$87,$C7
    .byte $87,$87,$87,OCTAVE_DOWN ; 2
    .byte SPEED_SET,$02      ; envelope speed $09
    .byte $05

    BOSS_SQ3_SEASHRINE_PART1:
    .byte $07,$07,$27,$37,$07,$07,$27,$37
    .byte OCTAVE_DOWN ; 1 
    .byte $A7,$A7
    .byte OCTAVE_DOWN ; 2
    .byte $07,$27,OCTAVE_DOWN ; 1
    .byte $A7,$A7,OCTAVE_DOWN ; 2
    .byte $07,$27
    .byte OCTAVE_DOWN ; 1
    .byte $87,$87,$A7,OCTAVE_DOWN ; 2
    .byte $07,OCTAVE_DOWN ; 1
    .byte $87,$87,$A7,OCTAVE_DOWN ; 2
    .byte $07,OCTAVE_DOWN ; 1
    .byte $87,$87,$A7,OCTAVE_DOWN ; 2
    .byte $07
    .byte LOOP_SWITCH
    .word BOSS_SQ3_SEASHRINE_PART1_ALTEND

    .byte OCTAVE_DOWN ; 1
    .byte $A7,$A7,OCTAVE_DOWN ; 2
    .byte $07,$27
    .byte LOOP_X,$01
    .word BOSS_SQ3_SEASHRINE_PART1

    BOSS_SQ3_SEASHRINE_PART1_ALTEND:
    .byte $37,$37,$57,$77
    .byte $27,$27,$57,$27,$07,$35,$25
    .byte $27,$57,$27,$37,$75,$77
    .byte $57,$57,$87,$57,$37,$75,$55
    .byte $57,$87,$57,$77,$A5,$A7
    .byte $07,$07,$27,$07,OCTAVE_DOWN ; 1
    .byte $A7,OCTAVE_DOWN ; 2
    .byte $35,$27
    .byte $55,$37,$75,$57,$85
    .byte SPEED_SET,$01         ; envelope speed $08
    .byte INSTRUMENT,$01          ; gradual decay from C
    .byte OCTAVE_DOWN ; 1       ; VERY BASS
    .byte $27,$27,$57,$27,$07,$35,$25
    .byte $27,$57,$27,$07,$35
    .byte SPEED_SET,$04         ; envelope speed $0C
    .byte $21
    .byte SPEED_SET,$01         ; envelope speed $08
    .byte OCTAVE_DOWN ; 2 
    .byte $77
    .byte $77,$57,$37,$27,$77,$57,$37,$27
    .byte LOOP_FOREVER
    .word BOSS_SQ3START

BOSS_SQ4:
    .byte TEMPO,$02               ; tempo FB
    .byte VOLUME_HALF           ; half volume, for later loop
    .byte $C0,$C1               ; two and a half bar pause

    BOSS_SQ4START:
    .byte $C0,$C1,$C5           ; two and a half bar + quarter note pause
    .byte VOLUME_HALF           ; un-halve volume
    .byte DUTY_50               ; 50% duty
    .byte SPEED_SET,$04         ; envelope speed $0C
    .byte INSTRUMENT,$0D          ; decay from C with tremelo
    .byte OCTAVE_4,$34,$2C,$3C,$2C,$05,$27,$07,OCTAVE_3,$A5
    .byte OCTAVE_4,$00
    .byte $C2,$C6
    .byte $79,$87,$77,$55
    .byte $71
    .byte OCTAVE_3,$A3,OCTAVE_4,$63
    .byte $A1
    .byte OCTAVE_5,$02,$09,OCTAVE_4,$A9,$79,$39
    .byte OCTAVE_5,$20
    .byte VOLUME_HALF           ; half volume
    .byte INSTRUMENT,$0C          ; decay from F with tremelo
    .byte $55,$35
    .byte OCTAVE_4,$B4,$B7,OCTAVE_5,$17,OCTAVE_4,$B7,$A7,$B7
    .byte $A3,$39,$69,$A9,OCTAVE_5,$39,$69,$A9,$69,$39
    .byte VOLUME_HALF           ; un-halve volume
    .byte INSTRUMENT,$0D          ; decay from C with tremelo
    .byte OCTAVE_4,$A7,$57,$37,$27,$A7,$87,OCTAVE_5,$25
    .byte SPEED_SET,$08         ; envelope speed $0D
    .byte $30
    .byte $C0
    .byte $C1
    .byte SPEED_SET,$01         ; envelope speed $08
    .byte INSTRUMENT,$0E          ; fade C->4->B with tremolo


    BOSS_SQ4_SEASHRINE_LOOP:
    .byte OCTAVE_3,$77,OCTAVE_4,$37,$27,$37,$07,$37,$57,$37
    .byte OCTAVE_3,$57,OCTAVE_4,$27,$07,$27,OCTAVE_3,$A7,OCTAVE_4,$27,$07,OCTAVE_3,$A7
    .byte $37,OCTAVE_4,$07,OCTAVE_3,$A7,OCTAVE_4,$07,OCTAVE_3,$87,OCTAVE_4,$07,OCTAVE_3,$77,$57
    .byte $37,OCTAVE_4,$07,OCTAVE_3,$A7,OCTAVE_4,$07,OCTAVE_3,$87,OCTAVE_4,$07,OCTAVE_3,$77,$57
    .byte LOOP_X,$02
    .word BOSS_SQ4_SEASHRINE_LOOP

    .byte VOLUME_HALF          ; half volume
    .byte INSTRUMENT,$0C         ; decay from F with tremelo
    .byte SPEED_SET,$04        ; envelope speed $0C
    ;; mini solo
    .byte OCTAVE_4,$23,$35,$55
    .byte $72,$79,$89,$79,$39
    .byte $53,$35,$55
    .byte $73,$A3
    .byte $85,$35,OCTAVE_5,$05,OCTAVE_4,$A5
    .byte $75,$35,OCTAVE_5,$35,$05
    .byte OCTAVE_4

    .byte DUTY_25            ; 25% duty
    .byte SPEED_SET,$04      ; envelope speed $08

    .byte SCORE_GOTO
    .word BOSS_SQ4_TRILLS_BAR1
    .byte SCORE_GOTO
    .word BOSS_SQ4_TRILLS_BAR2

    BOSS_SQ4_TRILLS_BAR3_4:
    .byte OCTAVE_5,$2A,OCTAVE_4,$BA
    .byte OCTAVE_5,$2A,OCTAVE_4,$BA
    .byte OCTAVE_5,$2A,OCTAVE_4,$BA
    .byte OCTAVE_5,$2A,OCTAVE_4,$BA
    .byte LOOP_X,$07
    .word BOSS_SQ4_TRILLS_BAR3_4

    .byte LOOP_FOREVER
    .word BOSS_SQ4START


    BOSS_SQ4_TRILLS_BAR1:
    .byte $BA,$7A,$BA,$7A
    .byte LOOP_X,$07
    .word BOSS_SQ4_TRILLS_BAR1
    .byte SCORE_RETURN

    BOSS_SQ4_TRILLS_BAR2:
    .byte $BA,$8A,$BA,$8A
    .byte LOOP_X,$07
    .word BOSS_SQ4_TRILLS_BAR2
    .byte SCORE_RETURN




BOSS_TRI:
    .byte TEMPO,$02         ; tempo FB
    .byte $C3             ; half note pause
    BASSINTRO:
    .byte OCTAVE_2,$79,$C9,$79,$C9,$79,$C9,$79,$C9,$79,$C9,$79,$C9,$59,$C9,$59,$C9
    .byte $79,$C9,$79,$C9,$79,$C9,$79,$C9,$79,$C9,$59,$C9,$39,$C9,$29,$C9

    BOSS_TRISTART:
    .byte $09,$C9,$09,$C9,$09,$C9,$09,$C9,$09,$C9,$29,$C9,$79,$C9,$09,$C9
    .byte $A9,$C9,$A9,$C9,$A9,$C9,$A9,$C9,$A9,$C9,OCTAVE_3,$29,$C9,$59,$C9,OCTAVE_2,$A9,$C9
    .byte LOOP_SWITCH
    .word BOSS_TRISTART_ALTEND

    .byte $89,$C9,$89,$C9,$89,$C9,$89,$C9,$89,$C9,$89,$C9,$79,$C9,$79,$C9
    .byte $89,$C9,$89,$C9,$89,$C9,$89,$C9,$A9,$C9,$A9,$C9,$59,$C9,$29,$C9
    .byte LOOP_X,$01
    .word BOSS_TRISTART

    BOSS_TRISTART_ALTEND:
    .byte $99,$C9,$99,$C9,$99,$C9,$89,$C9,$89,$C9,$79,$C9,$59,$C9,$29,$C9
    .byte $37,$57,$87,$A7,OCTAVE_3,$07,OCTAVE_2,$57,$87,$57

    ;;Part 2 of Temple of Fiends bit

    BOSS_TRI_BOOPS1:
    .byte $39,$C9,$39,$C9,$39,$C9,$A9,$C9
    .byte LOOP_X,$01
    .word BOSS_TRI_BOOPS1

    BOSS_TRI_BOOPS2:
    .byte $A9,$C9,$A9,$C9,$A9,$C9,OCTAVE_3,$59,$C9,OCTAVE_2
    .byte LOOP_X,$01
    .word BOSS_TRI_BOOPS2

    BOSS_TRI_BOOPS3:
    .byte $79,$C9,$79,$C9,$79,$C9,OCTAVE_3,$09,$C9,OCTAVE_2
    .byte LOOP_X,$01
    .word BOSS_TRI_BOOPS3

    BOSS_TRI_BOOPS4:
    .byte $A9,$C9,$A9,$C9,$A9,$C9,OCTAVE_3,$29,$C9,OCTAVE_2
    .byte LOOP_X,$01
    .word BOSS_TRI_BOOPS4

    BOSS_TRI_BOOPS5:
    .byte $39,$C9,$39,$C9,$39,$C9,$A9,$C9
    .byte LOOP_X,$01
    .word BOSS_TRI_BOOPS5

    BOSS_TRI_BOOPS6:
    .byte $89,$C9,$89,$C9,$89,$C9,$69,$C9,$89,$C9,$89,$C9,$39,$C9,$39,$C9

    BOSS_TRI_BOOPS7:
    .byte $67,OCTAVE_3,$67,$37,OCTAVE_2
    .byte LOOP_X,$01
    .word BOSS_TRI_BOOPS7
    .byte $67,OCTAVE_3,$67,OCTAVE_2

    BOSS_TRI_BOOPS8:
    .byte $A7,OCTAVE_3,$A7,$87,OCTAVE_2
    .byte LOOP_X,$01
    .word BOSS_TRI_BOOPS8
    .byte $A7,OCTAVE_3,$A7

    BOSS_TRI_SEASHRINE_START:
    .byte $01
    .byte OCTAVE_2,$A1
    .byte $80
    .byte $A3
    .byte OCTAVE_3,$01
    .byte OCTAVE_2,$A1
    .byte $81
    .byte LOOP_SWITCH
    .word BOSS_TRI_SEASHRINE_BRIDGE
    .byte $82,$87,$C7,OCTAVE_3
    .byte LOOP_X,$01
    .word BOSS_TRI_SEASHRINE_START

    BOSS_TRI_SEASHRINE_BRIDGE:
    .byte $87,$C7,$87,$C7,$89,$C9,$89,$C9,$89,$C9,$A9,$C9

    BOSS_TRI_SEASHRINE_PART2:
    .byte OCTAVE_2,OCTAVE_DOWN ; 1
    .byte $B9,$C9,$B7,OCTAVE_DOWN ; 2 
    .byte $B9,$C9,$B7,$C7,$77,$B7,$77
    .byte $09,$C9,$07,OCTAVE_3,$09,$C9,$07,$C7,OCTAVE_2,$77,OCTAVE_3,$07,OCTAVE_2,$77
    .byte $29,$C9,$27,OCTAVE_3,$29,$C9,$27,$C7,OCTAVE_2,$A7,OCTAVE_3,$27,OCTAVE_2,$27
    .byte $39,$C9,$37,OCTAVE_3,$39,$C9,$37,$C7,OCTAVE_2,$A7,OCTAVE_3,$37,OCTAVE_2,$27
    .byte $71
    .byte $51
    ;;earth cave/volcano bit

    .byte $29,$C9,$29,$C9,$59,$C9,$29,$C9,$09,$C9,$35,$27
    .byte $C7,$29,$C9,$59,$C9,$29,$C9,$09,$C9,$35,$22
    .byte $0A,$2A,$3A,$5A,$7A,$8A,$AA,OCTAVE_3,$0A,$29,$C9
    .byte $29,$C9,$09,$C9,OCTAVE_2,$A9,$C9,$89,$C9,$79,$C9,$59,$C9,$39,$C9,$29,$C9

    .byte LOOP_FOREVER
    .word BOSS_TRISTART




;; Notes for a song that's not here now.
;;
;;        0   1   2   3   4   5   6   7   8   9   A   B   C   D   E   F
;; .byte $90,$60,$48,$30,$24,$18,$12,$0C,$09,$06,$03,$03,$04,$10,$08,$08 ; FB (75 bpm)
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

      JSR ClearChannels   ; A = 0 when exiting

      STA mu_chanprimer   ; zero the channel primer
      STA sq2_sfx         ; zero sq2_sfx (seems strange to do here)

     
      LDX #$50  
     @ClearChannels:
      STA CHAN_START-1, X
      DEX
      BPL @ClearChannels    
      ;; JIGS - clear out all previous song data      
      
      LDA TriangleHush
      AND #$7F
      STA TriangleHush
      ;; JIGS - and turn off the force-hush bit

      JSR SilenceAPU
      
  @PrimeChannel:
    LDA music_track       ; get the music track to play
    SEC                   ; subtract 1 to make it zero based.  Had to be 1-based before
    SBC #1                ;  because a value of $00 means a song is in progress

    ;; JIGS -- use the MMC5 multiplier registers to use 10 bytes per song, 5 tracks each
    LDX #10
    JSR MultiplyXA
    ;CLC
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

      ;LDA #%00001111
      LDA #%00011111     ; JIGS - can't remember the reason for the 1 byte increase
                         ; MIGHT have to do with the DMA / DMCA / whatever thing that lowers triangle volume
      STA $4015          ; make sure playback for all channels is enabled
      STA $5015          ; make sure playback for all MMC5 channels is enabled (JIGS)

  @Exit:
    RTS

 ;; LUT used to convert from primer index to chan index
  @lut_PrimerToChan:
  .BYTE CHAN_SQ1, CHAN_SQ1
  .BYTE CHAN_SQ2, CHAN_SQ2
  .BYTE CHAN_TRI, CHAN_TRI
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

MusicPlay_L:   ; JMP MusicPlay
MusicPlay:
    INC framecounter
    INC playtimer      ; frames
    LDA playtimer
    CMP #60
    BCC :+
       LDA #0          ; seconds
       STA playtimer
       INC playtimer+1
       LDA playtimer+1
       CMP #60
       BCC :+
        LDA #0         ; minutes
        STA playtimer+1
        INC playtimer+2
        LDA playtimer+2
        CMP #60
        BCC :+
           LDA #0      ; hours
           STA playtimer+2
           INC playtimer+3
           LDA playtimer+3
           CMP #100
           BCC :+
            LDA #99
            STA playtimer+3 ; cap at 99 hours, you crazy

 :  LDA music_track    ; check the music track
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

    ORA #$80                   ; set high bit of freq to mark that it doesn't need to be updated
    STA CHAN_SQ1 + ch_freq+1   ;  anymore 
    AND #$07                   ; JIGS - remove everything but frequency bits!
    STA $4003                  ; output frequency
    LDA CHAN_SQ1 + ch_freq
    STA $4002
 
   @Sq1_NoFreqChange:          ; if the freq is not to be changed...
    LDA CHAN_SQ1 + ch_volume   ; still update volume (same process as above)
    ORA #%00110000    
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
   @Sq2_Update:                 ;  if not playing a sound effect...
    LDA CHAN_SQ2 + ch_freq+1    ; check high bit of F value
    BMI @Sq2_NoFreqChange       ; if set... no freq change

   @Sq2_FreqChange:
    ORA #$80                  ; then set high bit to mark that it doesn't need updating
    STA CHAN_SQ2 + ch_freq+1  ; and write it back
    AND #$07                  ; remove high bit flag from F-value (not necessary)
    STA $4007
    LDA CHAN_SQ2 + ch_freq    ; output freq
    STA $4006

   @Sq2_NoFreqChange:
    LDA CHAN_SQ2 + ch_volume  ; get volume
    ORA #%00110000            ; disable length/decay.  Don't set any duty bits (12.5% by default)
    STA $4004                 ; output
    LDA #%01111111
    STA $4005                 ; disable sweep

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
   
    ORA #%10000000
    STA CHAN_TRI + ch_freq+1  ; then set high bit to indicate freq doesn't need updating
    JMP @CheckHush

   @Tri_HighBitSet:           ; if high bit was set
    CMP #$FF                  ;  see if high byte = $FF
    BNE @CheckHush            ; if not, do nothing
    LDA #%10000000            ;  otherwise, silence the tri by setting the linear counter reload
    STA $4008                 ;  to zero.  This will silence the tri on the next linear counter clock.
    
   @CheckHush: 
    LDA MenuHush
    BNE @HushTri              ; hush triangle if in menu
    LDA TriangleHush
    BPL @CheckUnhush          ; skip hush triangle if high bit not set (song is not forcing half volume)
    
   @HushTri: 
    JSR HushTriangle       
   
   @CheckUnhush:   
    LDA MenuHush              
    BNE @Tri_Done              ; skip unhushing if in menu
    LDA TriangleHush
    BMI @Tri_Done              ; skip unhushing if high bit set
    
    JSR UnhushTriangle

   @Tri_Done:

  ;; JIGS - here we do MMC5 square stuff!

    LDA CHAN_SQ3 + ch_freq+1     ; get high bit of output F-value
    BMI @Sq3_NoFreqChange        ; if it's set, there's no change, so skip ahead

    ORA #$80                   ; set high bit of freq to mark that it doesn't need to be updated
    STA CHAN_SQ3 + ch_freq+1   ;  anymore 
    AND #$07
    STA $5003                    ; output frequency
    LDA CHAN_SQ3 + ch_freq
    STA $5002

   @Sq3_NoFreqChange:          ; if the freq is not to be changed...
    LDA CHAN_SQ3 + ch_volume   ; get the output volume
    ORA #%00110000             ;  set bits to disable length and decay, do not set duty
    STA $5000                  ;  output the volume/duty

   @Sq3_Done:
    LDA CHAN_SQ4 + ch_freq+1     ; get high bit of output F-value
    BMI @Sq4_NoFreqChange        ; if it's set, there's no change, so skip ahead

    ORA #$80                   ; set high bit of freq to mark that it doesn't need to be updated
    STA CHAN_SQ4 + ch_freq+1   ;  anymore 
    AND #$07
    STA $5007                  ; output frequency
    LDA CHAN_SQ4 + ch_freq
    STA $5006

   @Sq4_NoFreqChange:          ; if the freq is not to be changed...
    LDA CHAN_SQ4 + ch_volume   ; get the output volume
    ORA #%00110000             ;  set bits to disable length and decay, do not set duty
    STA $5004                  ;  output the volume/duty

   @Sq4_Done:

  ;; Now that all 3 channels are playing the tones they're supposed to -- process music data
  ;;  to find what the channels are to play next frame

    LDA #CHAN_START          ; reset mu_chan to start at the first channel (square 1)
    STA mu_chan

@UpdateLoop:
    TAX ; LDX mu_chan              ; put current channel in X for indexing
   
    DEC ch_notelength, X     ; decrement the channel's len counter
    BNE @EnvStep             ; if it's nonzero -- a note is still playing, so update the env pattern

      JSR Music_ChannelScore ; otherwise, the note is done (len expired), so do more score processing
      CPX #CHAN_TRI
      BNE @UpdateVol      ; set initial volume for this note if its not the triangle channel
      BEQ @UpdateNext

  @EnvStep:                 ; if a note is still playing... update the env pattern
    ;; JIGS - this should save some cycles!
    CPX #CHAN_TRI
    BNE :+
        JMP @UpdateNext         ; Triangle channel does not use envelopes or volume control...
    
  : LDA ch_envelope_type, X
    BMI @XValuesPerFrame
    
  @XFramesPerValue:
    DEC ch_envelope_time, X  ; decrease the frame-count timer before the next update
    BNE @UpdateNext          ; no need to update volume yet then... so next channel!   
 
    LDA ch_envelope_length, X
    AND #%00111111           ; remove legato/vibrato on bits
    STA ch_envelope_time, X  ; get the length set earlier and save as the new timer
    
    LDA ch_envelope_position, X
    AND #ENVELOPE_LENGTH-1
    CMP #ENVELOPE_LENGTH-1   ; see if the position is at max, and if so, leave it
    BEQ @UpdateNext
    
    INC ch_envelope_position, X ; else, increase it by one
    BNE @UpdateVol
    
  @XValuesPerFrame:          ; high bit is 0
    LDA ch_envelope_position, X
    AND #%11000000
    STA tmp                  ; backup these two bits
    
    LDA ch_envelope_position, X
    AND #ENVELOPE_LENGTH-1   ; keep only the actual position bits
    CMP #ENVELOPE_LENGTH-1   ; see if the position is at max, and if so, leave it
    BEQ @UpdateNext
   ; CLC                     ; The CMP should clear carry here!
   
    ADC ch_envelope_time, X  ; add the distance per frame
    CMP #ENVELOPE_LENGTH-1   ; capping at #63 (or 31 for original envelope lengths)
    BCC :+
    LDA #ENVELOPE_LENGTH-1 
  : ORA tmp                  ; add back in the other bits
    STA ch_envelope_position, X ; and save

   @UpdateVol:
  ;  LDA ch_envelope_position, X
  ;  AND #%00111111
  ;  TAY                      ; then put in Y for indexing
  ;
  ;  LDA ch_instrument, X     ; instrument * Envelope pattern length
  ;  AND #%00011111
  ;  LDX #ENVELOPE_LENGTH     ; length of Envelope patterns (32 bytes)
  ;  JSR MultiplyXA           ; also does CLC
  ;  ADC #<lut_EnvPatterns    ; add the ROM address of the pattern table!
  ;  STA tmp
  ;  TXA
  ;  ADC #>lut_EnvPatterns
  ;  STA tmp+1
  ;  LDX mu_chan              ; put this back in X    

    LDA ch_instrument, X      ; instrument 
    AND #%00011111            ; remove tempo bits
    TAY
    LDA InstrumentTable_Low, Y
    STA tmp+1
    LDA InstrumentTable_High, Y
    STA tmp+2
  
    LDA ch_envelope_position, X
    AND #%00111111
    TAY                      ; then put in Y for indexing    
  
    LDA (tmp+1), Y              
    AND #$0F
    STA tmp                  ; tmp = volume bits 
    BEQ @Done

    LDA MenuHush
    BEQ @AdjustVolume
    LSR tmp
    BEQ @Done                ; if halving silenced it, finish up

  @AdjustVolume:
    JSR AdjustVolume
    
  @Done:
    LDA (tmp+1), Y
    AND #%11000000         ; see if there were duty bits to assign
    BEQ :+
      ORA tmp              ; if there were, add them to the volume bits
      STA tmp              
      LDA ch_volume, X      
      AND #%00110000       ; clear the previous duty info
      JMP :++              ; jump ahead to write
    
  : LDA ch_volume, X       ; else, no new duty bits to set, so keep old ones   
    AND #$F0               ; clear out everything but the high bits (duty + volume toggles)
  : ORA tmp                ; add them into the note's volume byte
    STA ch_volume, X       ; and record that as channel's output volume

  @UpdateNext:             ; processing for this channel is done
    TXA                    ; so increment mu_chan to look at the next channel
    CLC
    ADC #CHAN_BYTES
    STA mu_chan

   ;; JIGS - this basically ends when mu_chan is #$F0 and #CHAN_BYTES is added to it (#$10) resulting in 0, with carry set
    ; CMP #CHAN_STOP         ; and keep looping until all channels processed
    BCS :+
    JMP  @UpdateLoop
  : RTS                    ; then we're done!  exit!



AdjustVolume:
   @HalfVolume:
    LDA ch_volume, X
    AND #%00010000      ; get the Halve volume bit
    BEQ @QuarterVolume  ; if not set, skip
    
    LSR tmp
    
   @QuarterVolume:
    LDA ch_volume, X
    AND #%00100000      ; get the Quarter volume bit
    BEQ @CustomVolume   ; if not set, skip
    
    LSR tmp
    LSR tmp
    
   @CustomVolume: 
    LDA ch_volume_subtract, X ; loads the custom amount to cut from the volume
    AND #%01111000            ; cut out the other bits
    BEQ @Return               ; no custom volume, so jump ahead
    
    LSR A               ; move high bits to low bits
    LSR A 
    LSR A
    STA tmp+3
    
    LDA tmp
    SEC
    SBC tmp+3           ; subtract custom quietness
    BCS :+
    LDA #0              ; set to 0 if it wrapped around
  : STA tmp
  @Return:  
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
    LDY #0 
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

Music_DoScore_IncBy1:
    LDY #1

Music_DoScore_IncByA:
    INC ch_scoreptr, X
    BNE :+
    
    INC ch_scoreptr+1, X
    INC mu_scoreptr+1

  : INC mu_scoreptr
    DEY
    BNE Music_DoScore_IncByA

;Music_DoScore_IncByA:   ; entry point for resuming -- incs score pointer by A, then resumes
;    CLC                   ; add A co ch_scoreptr
;    ADC ch_scoreptr, X
;    STA ch_scoreptr, X
;    STA mu_scoreptr       ; and update mu_scoreptr as well to keep it synced
;
;    LDA ch_scoreptr+1, X  ; include carry in high byte
;    ADC #0
;    STA ch_scoreptr+1, X
;    STA mu_scoreptr+1

Music_DoScore:
    ;LDY #0
    LDA (mu_scoreptr), Y    ; get a byte from the score
    CMP #$C0                ;  see if it's >= $C0
    BCS Music_Control_Codes ;  if it is, jump ahead to code processing

      JSR Music_Note        ; otherwise, it's a normal note -- so process it as a note
                            ;  and continue into @Done
Music_DoScore_Done:
    ;LDA ch_scoreptr, X      ; when done, increment the channel's score pointer by 1
    ;CLC                     ;  (to get it past the note/rest byte we just processed)
    ;ADC #1
    ;STA ch_scoreptr, X
    ;LDA ch_scoreptr+1, X
    ;ADC #0
    ;STA ch_scoreptr+1, X    ; and exit
    ;RTS                     ;  still don't understand why Nasir disliked INC so much
    
    INC ch_scoreptr, X
    BNE :+
      INC ch_scoreptr+1, X  
  : RTS
    

Music_Control_Codes:
    CMP #MUSIC_CODES_START
    BCS :+
        JMP Music_Rest
  : CMP #END_SONG
    BNE :+
        LDA #$80           ; If yes, write $80 to the music track to mark that the song is over
        STA music_track    ;  All channels will be silenced next frame
        RTS                ; RTS because no further score processing is needed if song is over
  : STA tmp+2
    SEC 
    SBC #MUSIC_CODES_START
    ASL A
    TAY 
    LDA Music_JumpTable+1, Y 
    STA tmp+1 
    LDA Music_JumpTable, Y
    STA tmp 
    LDA tmp+2
    JMP (tmp)
    
    ;; JIGS - this takes about half the CPU time to do... but at the cost of ALWAYS taking that much CPU time.
    ;; Perhaps a smarter thing to do is set the Octave stuff (most likely to be used) higher in the list.
    ;; Setup codes should be lower... but it all depends on what people end up using the most in the score.
    
Music_JumpTable:
.word Music_SetOctave           ; $E0 - octave 2
.word Music_SetOctave           ; $E1 - octave 3
.word Music_SetOctave           ; $E2 - octave 4
.word Music_SetOctave           ; $E3 - octave 5
.word Music_SetOctaveSwitch     ; $E4 - octave switch down from x
.word Music_SetOctaveSwitch     ; $E5 - octave switch up from x
.word Music_VibratoOn           ; $E6 - vibrato toggle
.word Music_LegatoOn            ; $E7 - legato toggle
.word Music_CustomVolume        ; $E8 - subtract next byte from volume
.word Music_HalfVolume          ; $E9 - halve volume toggle
.word Music_QuarterVolume       ; $EA - quarter volume toggle
.word Music_VibratoSpeed        ; $EB - next byte is speed value and depth value (#%SSSSDDDD)
.word Music_Duty                ; $EC - duty 12.5%
.word Music_Duty                ; $ED - duty 25%
.word Music_Duty                ; $EE - duty 50%
.word Music_SetEnvSpeed         ; $EF - envelope speed
.word Music_LoopCode            ; $F0 - loop forever, next 2 bytes are address to jump back to
.word Music_LoopCode            ; $F1 - loop x times, next byte is amount (0-15), next 2 bytes are address
.word Music_SetEnvPattern       ; $F2 - envelope pattern (instrument)
.word Music_SetTempo            ; $F3 - song tempo (set note length table) 
.word Music_LoopSwitch          ; $F4 - train track switch toggle, next 2 bytes are second loop address 
.word Music_Goto                ; $F5 - like loop forever, next 2 bytes are address to jump to
.word Music_Return              ; $F6 - jump to bytes after Music_Goto's jump address


;    CMP #LOOP_FOREVER               ; if below this, then
;    BCS :+                          ; then its
;        JMP Music_Rest              ; <-- this
;  : CMP #LOOP_SWITCH                ; if below this, then
;    BCS :+                          ; then its
;        JMP Music_LoopCode          ; <-- this
;  : CMP #LEGATO_ON                  ; if below this, then
;    BCS :+                          ; then its
;        JMP Music_LoopSwitch        ; <-- this
;  : CMP #DUTY_12                    ; if below this, then
;    BCS :+                          ; then its
;        JMP Music_LegatoOn          ; <-- this
;  : CMP #VIBRATO_ON                 ; if below this, then
;    BCS :+                          ; then its
;        JMP Music_Duty              ; <-- this
;  : CMP #VIBRATO_SPEED              ; if below this, then
;    BCS :+                          ; then its
;        JMP Music_VibratoOn         ; <-- this
;  : CMP #INSTRUMENT                 ; if below this, then
;    BCS :+                          ; then its
;        JMP Music_VibratoSpeed      ; <-- this
;  : CMP #OCTAVE_UP                  ; if below this, then
;    BCS :+                          ; then its
;        JMP Music_SetEnvPattern     ; <-- this
;  : CMP #OCTAVE_2                   ; if below this, then
;    BCS :+                          ; then its
;        JMP Music_SetOctaveSwitch   ; <-- this
;  : CMP #SCORE_GOTO                 ; if below this, then
;    BCS :+                          ; then its
;        JMP Music_SetOctave         ; <-- this
;  : CMP #SCORE_RETURN       ; if below SCORE RETURN, its Score Goto
;    BCS :+
;        JMP Music_Goto
;  : CMP #VOLUME_MINUS       ; if below VOLUME MINUS, its Score Return
;    BCS :+
;        JMP Music_Return
;  : CMP #VOLUME_QRTR        ; if below VOLUME QRTR, its Volume Minus
;    BCS :+
;        JMP Music_CustomVolume
;  : CMP #VOLUME_HALF        ; if below VOLUME HALF, its Volume Quarter
;    BCS :+
;        JMP Music_QuarterVolume
;   : CMP #SPEED_SET         ; if below SPEED_SET, its a Volume Half
;    BCS :+
;        JMP Music_HalfVolume
;  : CMP #TEMPO              ; if below TEMPO, its an envelope speed select
;    BCS :+
;       JMP Music_SetEnvSpeed
;  : CMP #END_SONG           ; if not END SONG marker, then its tempo select
;    BEQ :+
;       JMP Music_SetTempo
;
;    ;; eles, it's $FF : End the song
;     : LDA #$80           ; If yes, write $80 to the music track to mark that the song is over
;       STA music_track    ;  All channels will be silenced next frame
;       RTS                ; RTS because no further score processing is needed if song is over



















Music_LegatoOn:
Music_VibratoOn:
Music_VibratoSpeed: ; also Depth


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
    LDY #1
    AND #$01                ; get low bits (repeat count)
    BEQ ResumeLoop_Y        ; if its 0, its loop forever

    LDA (mu_scoreptr), Y    ; JIGS - get repeat count for real

    ASL A
    ASL A
    ASL A
    ASL A                   ; shift into high bits
    STA tmp                 ; back it up for later

    LDA ch_loopcounter, X   ; check the loop counter
    AND #$F0                ; remove frequency bits
    BEQ StartLoop           ; if 0, start the loop

    SEC
    LDA ch_loopcounter, X   ; otherwise, dec the loop counter
    SBC #$10
    STA ch_loopcounter, X
    AND #$F0
    BNE ResumeLoop_2        ;  if it's still nonzero (still looping), resume the loop
    LDY #4
    JMP Music_DoScore_IncByA ; Skip over LOOP_X, ##, and pointer in the score and resume playing

StartLoop:
    LDA ch_loopcounter, X
    ORA tmp                 ; get the number to times to repeat this loop
    STA ch_loopcounter, X   ; record that as the loop counter
    
ResumeLoop_2:
    LDY #2
    BNE ResumeLoop_Y

ResumeLoop:
    LDY #1
    
ResumeLoop_Y:               ; JIGS changing things
    LDA (mu_scoreptr), Y    ; to resume the loop, get low byte of loop address from the score
    STA ch_scoreptr, X      ;  record that as the new score pointer for the channel
    STA tmp                 ; store in tmp (don't change mu_scoreptr yet because we still need it
    INY                     ;   to get the high byte)
    LDA (mu_scoreptr), Y
    STA ch_scoreptr+1, X    ; get high byte
    STA mu_scoreptr+1
    LDA tmp
    STA mu_scoreptr         ; then set low byte of mu_scoreptr previously tmp'd
    LDY #0 
    JMP Music_DoScore       ; channel is now pointing to loop address -- exit


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; JIGS  Music_LoopCode2
;;
;;    Called to process a loop/repeat command (code $F0)
;;    F0 is a "go back to X then skip the second time" kind of loop,
;;	  allowing a song to play something twice, then have a variation
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

Music_LoopSwitch:
 	LDA ch_loopbranch, X	; if 0 (no loop yet started)
    AND #$40
	BEQ @StartLoop			; go to start

   @ResumeLoop:
    LDA ch_loopbranch, X
    AND #%10111111          ; set the loop branch bit to 0
    STA ch_loopbranch, X
    LDA ch_loopcounter, X
    SEC
    SBC #$10
    STA ch_loopcounter, X	; dec the main loop counter, since it won't get to it again
	JMP ResumeLoop          ; then do the Loop

   @StartLoop:              ; to start a new loop...
    LDA ch_loopbranch, X
    ORA #$40                ; set the loop branch bit to 1
    STA ch_loopbranch, X   ; Save
    LDY #3
    JMP Music_DoScore_IncByA ; Skip over F0 and pointer in the score and resume playing

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
    LDA ch_scoreptr, X
    CLC
    ADC #3
    STA ch_return, X        ; skip past the F1 and .WORD bytes
    LDA ch_scoreptr+1, X    ;
    ADC #0
    STA ch_return+1, X
    JMP ResumeLoop          ; --which works the same way as resuming a loop! But is skipping to another spot entirely.

Music_Return:
    LDA ch_return, X      ; load return pointers
    STA ch_scoreptr, X    ; save as channel and music pointers
    STA mu_scoreptr       ;
    LDA ch_return+1, X    ;
    STA ch_scoreptr+1, X  ;
    STA mu_scoreptr+1     ;
    LDY #0 
    JMP Music_DoScore


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
    PHA                      ; backup the code
    JSR Music_ApplyTone      ; apply the tone
    PLA                      ; restore the code
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
    PHA
    JSR Music_ApplyLength_Rest   ; apply the length

    ;LDA mu_chan        ; see if this is the triangle
    CPX #CHAN_TRI
    BNE @Exit          ;  if it is, make the tri rest by marking that it needs to be silenced
      LDA #$FF         ; this is done by setting the high byte of the freq to $FF (only works with the tri)
      STA CHAN_TRI + ch_freq+1
  @Exit:
    PLA
    JMP Music_DoScore_Done




Music_HalfVolume:
    CPX #CHAN_TRI                  ; is it the Triangle channel?
    BNE :+                         ; if not, jump ahead to do square stuff 
        LDA TriangleHush           ; if yes, check TriangleHush
        BMI @Off                   ; if the high bit is set, the Hushing is active; so branch to turn it off
        ORA #$80                   ; here, turn it on by setting the high bit
        BMI @TriDone               ; then jump ahead to save it
        
       @Off:
        AND #$7F                   ; to turn it off, flip off the high bit
       
       @TriDone: 
        STA TriangleHush           ; save and exit!
        JMP Music_DoScore_IncBy1        

  : LDA ch_volume, X
    AND #%00010000        ; bit set means its already quiet
    BNE @UnShush          ; if bit set, then turn it off
      LDA ch_volume, X    ; but if its off: reload to restore other bits
      ORA #%00010000      ; and add in the bit
      STA ch_volume, X    ; save
      BNE :+

   @UnShush:              ; its on here:
    LDA ch_volume, X      ; reload to restore other bits
    AND #~%00010000       ; and cut out the bit
    STA ch_volume, X      ; save it
  : JMP Music_DoScore_IncBy1

Music_QuarterVolume:
    LDA ch_volume, X
    AND #%00100000        ; bit set means its already quiet
    BNE @UnShush          ; if bit set, then turn it off
      LDA ch_volume, X    ; but if its off: reload to restore other bits
      ORA #%00100000      ; and add in the bit
      STA ch_volume, X    ; save
      BNE :+

   @UnShush:              ; its on here:
    LDA ch_volume, X      ; reload to restore other bits
    AND #~%00100000       ; and cut out the bit
    STA ch_volume, X      ; save it
  : JMP Music_DoScore_IncBy1

Music_CustomVolume:
    LDA ch_volume_subtract, X 
    AND #%10000111        ; backup the frequency bits + frequency update toggle (if ever set during this...)
    STA tmp
    LDY #1
    LDA (mu_scoreptr), Y   ; get the next byte in the score (volume to subtract)
    ASL A
    ASL A
    ASL A                  ; shift into the appropriate bits
    ORA tmp                ; add the frequency stuff back in
    STA ch_volume_subtract, X
    LDY #2
    JMP Music_DoScore_IncByA






;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Music_SetTempo  [$B2B8 :: 0x372C8]
;;
;;    Called to process a tempo control code ($F9-FE).  It simply changes
;;  the LUT used for note length lookups.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


Music_SetTempo:
    LDA ch_tempo, X
    AND #%00011111
    STA tmp              ; backup non-tempo values
    
    LDY #1
    LDA (mu_scoreptr), Y ; get the next byte in the score (tempo value)
    ASL A
    ASL A
    ASL A
    ASL A
    ASL A                ; move low 3 bits into high bits
    ORA tmp              ; add in the backed up non-tempo values
    STA ch_tempo, X
    
    LDY #2
    JMP Music_DoScore_IncByA

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Music_SetOctave  [$B2CD :: 0x372DD]
;;
;;    Called to process octave control codes ($D8-DF)
;;  Note codes $DC-DF should not be used because the freq table is only
;;  4 octaves large.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

Music_SetOctaveSwitch:
;    OCTAVE_UP    = 0
;    OCTAVE_DOWN  = 1
    AND #$01
    BNE @OctaveUp

   @OctaveDown:
    LDA ch_octave, X  
    AND #%00001000     ; see if the bit is already set
    BNE @Clear         ; if it is, clear both bits and save

    LDA ch_octave, X   ; load the byte again
    AND #%11110011     ; clear out possible "octave up" bit
    ORA #%00001000     ; set the "octave down" bit
    BNE @Done          ;

   @OctaveUp:
    LDA ch_octave, X
    AND #%00001000     ; if already set, clear both
    BNE @Clear

    LDA ch_octave, X   ; if not set,
    AND #%11110011     ; clear octave switch bits
    ORA #%00000100     ; add in the up bit
    BNE @Done

   @Clear:
    LDA ch_octave, X
    AND #$11110011

   @Done:
    STA ch_octave, X
    JMP Music_DoScore_IncBy1


Music_SetOctave:
    AND #$03                 ; isolate the low bits of the control code (the desired octave)
    STA tmp

    LDA ch_octave, X
    AND #%11111100           ; clear out old values
    ORA tmp                  ; add in new values
    STA ch_octave, X        
    JMP Music_DoScore_IncBy1
    
;    LDA ch_octave, X
;    AND #$00001000
;    BNE @OctaveUp           ; if Octave Up bit is set, see if Y can be increased
;
;    LDA ch_octave, X        ; if not set, check Down bit
;    AND #$00000100
;    BEQ @Resume             ; neither bit set, do nothing and return
;
;   @OctaveDown:
;    CPY #0                  ; if Y = 0 (Octave D8) then don't decrease it further.
;    BEQ @Resume
;    DEY
;    JMP @Resume
;
;  @OctaveUp:
;   ; CPY #04                 ; if Y = 4 (Octave DC) then don't increase it further.
;   ; BEQ @Resume
;   ;; there is now a highest octave only reachable if Y = 4!
;    INY
;    
;  @Resume:
;    TYA
;    ORA ch_octave, X
;    STA ch_octave, X

   ; LDA #<lut_NoteFreqs      ; take the pointer to the frequency table
   ; CLC                      ;  add to it the offset to the desired octave
   ; ADC lut_OctaveOffset, Y  ; and store the resulting pointer (which points to a 12-entry
   ; STA ch_frqtblptr, X      ;  table of notes at the desired octave) as the channel's
   ; LDA #>lut_NoteFreqs      ;  freq table pointer.
   ; ADC #0
   ; STA ch_frqtblptr+1, X
   
 ;   JMP Music_DoScore_IncBy1




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Music_SetEnvPattern  [$B2DF :: 0x372EF]
;;
;;    Called to process envelope pattern control codes ($E0-EF)
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

Music_SetEnvPattern:
    LDY #1               
    LDA (mu_scoreptr), Y 
    AND #$1F
    STA tmp
    LDA ch_instrument, X
    AND #%11100000
    ORA tmp
    STA ch_instrument, X
    LDY #2
    JMP Music_DoScore_IncByA

Music_SetEnvSpeed:
    LDY #1                   ; code is $F8 here (set envelope speed/rate)
    LDA (mu_scoreptr), Y     ;  get the byte following $F8 in the score
    STA tmp
    
    AND #$80                 ; get the envelope type bit 
    STA tmp+1
    LDA ch_envelope_type, X
    AND #%01111111           ; clear out the old one
    ORA tmp+1
    STA ch_envelope_type, X
    
    LDA tmp
    AND #%00111111            ; remove the type bit and save as envelope time
    STA tmp
    STA ch_envelope_time, X
    
    LDA ch_envelope_length, X ; length is copied back to time when time expires in type 0
    AND #%11000000
    ORA tmp
    STA ch_envelope_length, X 

    LDY #2
    JMP Music_DoScore_IncByA  ; then resume processing -- incing by 2 (for $F8 and following byte)



;;;;;
;; JIGS - set the duty for the channel!
;; This is done by using F5 in the score.
;; The following byte names the channel and the duty rate.
;;       low 2 bits:
;; $F5 : 01 - duty 12.5%
;; $F6 : 10 - duty 25%
;; $F7 : 11 - duty 50%
;;

Music_Duty:
    AND #$03
    CLC
    ROR A
    ROR A
    ROR A
    STA tmp
    LDA ch_volume, X
    AND #%00111111
    ORA tmp
    STA ch_volume, X
    JMP Music_DoScore_IncBy1



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
;  @NotNoise:          ; other channels (squares, tri)
;;      JIGS - unused

    LSR A            ; right shift code by 3 and isolate what previously was the high bits
    LSR A            ;  this is the same as right-shifting by 4 to get the high bits (note to play),
    LSR A            ;  then doubling that to get the index (2 bytes of F-data per note)
    AND #($F0 >> 3)  ; #$1E? 
   ; TAY              ; put note*2 in Y for indexing

   ; LDA ch_frqtblptr, X    ; copy freq table pointer to tmp
   ; STA tmp
   ; LDA ch_frqtblptr+1, X
   ; STA tmp+1
    ;; JIGS - silly billies put the whole pointer in zero page RAM when they only needed 3 bits...
   
    PHA
    LDA ch_octave, X
    AND #$03
    TAY 
    INY               ; increment Y, because lowest natural octave is now 2
    
    LDA ch_freq+1, X
    AND #%01111000    ; save the volume substract bits
    STA tmp+2 
    
    LDA ch_octave, X
    AND #%00001000    ; see if down bit is set
    BNE @OctaveDown   ; if it is, decrement Y 
    LDA ch_octave, X
    AND #%00000100    ; see if up bit is set
    BEQ @GetNote      ; if it isn't, jump ahead
   
   @OctaveUp:
    INY               ; increase octave by 2
    INY               
    
   @OctaveDown:
    DEY   
    
   @GetNote: 
    LDA #<lut_NoteFreqs
    CLC
    ADC lut_OctaveOffset, Y
    STA tmp
    LDA #>lut_NoteFreqs
    ADC #0
    STA tmp+1
    PLA
    TAY   

    LDA (tmp), Y        ; read the new freq from that table
    STA ch_freq, X      ; and record it as the new freq for this channel to output
    INY
    LDA (tmp), Y
    ORA tmp+2           ; restore the volume subtract bits
    STA ch_freq+1, X
    
    ;; for vibrato: 
    DEY                  ; undo the INY
    TYA                
    LSR A                ; and halve it for a table only half the size
    STA ch_vibrato_legato, X
    RTS



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

Music_ApplyLength:               ; for notes
    TAY
    LDA ch_envelope_position, X
    AND #%11000000
    STA ch_envelope_position, X  ; reset envelope position
    TYA   

Music_ApplyLength_Rest:
    AND #$0F               ; isolate low bits (note length)
    TAY

    LDA ch_tempo, X
    AND #%11100000         ; get only the high bits (its shared!)
    LSR A                  ; shift them over by 1, so (example) $A0 becomes $50
    CLC                    ; table is $10 wide,     
    ADC #<lut_NoteLengths  ; add the above to the start of the note length luts
    STA tmp                ;  to get the pointer to the desired length table
    LDA #>lut_NoteLengths
    ADC #0
    STA tmp+1              ; and record that length table for the channel    
    
    ;; JIGS - much like the length table pointer, it does not need to be in zero page...
    
   ; TAY               ; put in Y for indexing
   ;
   ; LDA ch_lentblptr, X    ; copy channel's length table pointer to tmp
   ; STA tmp
   ; LDA ch_lentblptr+1, X
   ; STA tmp+1

    LDA (tmp), Y          ; get note length from lookup table
    STA ch_notelength, X  ; record as channel's length counter
    RTS                   ; and exit




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
  .BYTE 4*12*2     
  .BYTE 5*12*2     

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  LUT for note freqs [$B2F9 :: 0x37309]
;;
;;    Values here are used to convert note IDs (C, C#, etc) to a usable F-value for
;;  output to the channel's registers.  There are 4 octaves, twelve notes per
;;  octave

lut_NoteFreqs:
  ;       0     1     2     3     4     5     6     7     8     9     A     B
  ;       C     C#    D     D#    E     F     F#    G     G#    A     A#    B
  .WORD $06AC,$064C,$05F2,$059E,$054C,$0501,$04B8,$0474,$0434,$03F8,$03BE,$0388 ; D8 - BASS
  .WORD $0356,$0326,$02F9,$02CF,$02A6,$0280,$025C,$023A,$021A,$01FC,$01DF,$01C4 ; D9 - low
  .WORD $01AB,$0193,$017C,$0167,$0153,$0140,$012E,$011D,$010D,$00FE,$00EF,$00E2 ; DA - mid
  .WORD $00D5,$00C9,$00BE,$00B3,$00A9,$00A0,$0097,$008E,$0086,$007E,$0077,$0071 ; DB - high
  .WORD $006A,$0064,$005F,$0059,$0054,$0050,$004B,$0047,$0043,$003F,$003B,$0038 ; DC - highest
  .WORD $0035,$0032,$002F,$002C,$002A,$0028,$0026,$0024,$0022,$0020,$001E,$001C ; only available with octave switch
  
  ;; JIGS ^ ADDED BASS OCTAVE
  ;; Also changed values to match:
  ;; http://wiki.nesdev.com/w/index.php/Pulse_Channel_frequency_chart
  ;; FF1's vanilla values were close, but 1 bit sharp in some spots.


 ;; JIGS - Added vibrato range tables.
 ;; JIGS - ch_vibrato's high bit indicates if its moving up or down
 ;; This is about as much as I can do. 

lut_Vibrato_Tri:
   ;     C   C#  D   D#  E   F   F#  G   G#  A   A#  B
  .byte $60,$5A,$54,$52,$4B,$49,$44,$40,$3C,$3A,$36,$32
  .byte $30,$2D,$2A,$29,$26,$24,$22,$20,$1E,$1D,$1B,$19
  .byte $18,$17,$15,$14,$13,$12,$11,$10,$0F,$0F,$0D,$0D
  .byte $0C,$0B,$0B,$0A,$09,$09,$09,$08,$08,$07,$06,$07
  .byte $06,$05,$06,$05,$04,$05,$04,$04,$04,$04,$03,$03
  .byte $03,$03,$03,$02,$02,$02,$02,$02,$02,$02,$02,$01

  ;; these values are the distance from the low note to the next high note.
  
lut_Vibrato:
   ;     C   C#  D   D#  E   F   F#  G   G#  A   A#  B    v - pitch octave for standard notation
  .byte $53,$4C,$0D,$52,$4B,$01,$44,$40,$34,$07,$36,$32 ; 2 ; 0 < - this driver's pitch ID 
  .byte $30,$26,$06,$29,$26,$24,$22,$20,$1A,$03,$1B,$19 ; 3 ; 1 
  .byte $18,$17,$15,$14,$13,$12,$11,$10,$0D,$01,$0D,$0D ; 4 ; 2
  .byte $0C,$0B,$0B,$0A,$09,$09,$09,$08,$08,$07,$06,$07 ; 5 ; 3 
  .byte $06,$05,$06,$05,$04,$05,$04,$04,$04,$04,$03,$03 ; 6 ; 4
  .byte $03,$03,$03,$02,$02,$02,$02,$02,$02,$02,$02,$01 ; 7 ; 4+ up switch
;
; Avoid using heavy vibrato on these notes:
; D-2
; F-2
; A-2
; A-3
; A-4
;
; Notes with more limited vibrato range than Triangle table:
; C-2 
; C#-2
; G#-2
; C#-3
; G#-3
; G#-4 

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  LUT for note/rest lengths  [$B359 :: 0x37369]
;;
;;    Values used here are used to convert the 'length' portion of a note rest
;;  code (the low 4 bits) into a usable duration in frames.

lut_NoteLengths:

;        0   1   2   3   4   5   6   7   8   9   A   B   C   D   E   F
  .BYTE $C0,$60,$30,$18,$0C,$90,$48,$24,$C0,$60,$30,$18,$0C,$90,$48,$24 ; F9          ; $00
  .BYTE $78,$3C,$1E,$0F,$07,$5A,$28,$14,$78,$3C,$1E,$0F,$07,$5A,$28,$14 ; FA          ; $01
  .BYTE $90,$60,$48,$30,$24,$18,$12,$0C,$09,$06,$03,$03,$04,$10,$08,$08 ; FB (75 bpm) ; $02
  .BYTE $78,$50,$3C,$28,$1E,$14,$0F,$0A,$07,$05,$03,$02,$0E,$0D,$07,$06 ; FC (90 bpm) ; $03
  .BYTE $6C,$48,$36,$24,$1B,$12,$0E,$09,$07,$04,$03,$06,$0E,$60,$40,$30 ; FD (99 bpm) ; $04
  ;.BYTE $60,$40,$30,$20,$18,$10,$0C,$08,$06,$04,$02,$02,$0B,$0A,$06,$05 ; FE         ; 
  .BYTE $80,$60,$40,$30,$20,$18,$10,$0C,$08,$06,$04,$02,$03,$05,$01,$C0 ; (112.5 bpm) ; $05
  ; JIGS ^ note lengths used for my Marsh Cave replacement, and Ruined Castle

;; JIGS -- NOTE : I changed an original byte of code in the FD string, under the B column, from a $03 to a $06
;; This is so I can use triplets that equal the same length as an eighth note ($12)


; a list of what note lengths each song uses:
;
; F9 - none, and the note lengths are messed up/unfinished
; FA - used briefly in Epilogue and Sky Castle - notes $x5 ($5A length) for Epilogue, $x7 ($14) for Sky Castle
;; but if Epilogue were to use Tempo 4 and do a x1 and an x7 ...
;; abd Sky Castle were to use Tempo 4's $x5... 
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
;; JIGS - by "speed of $0C" he meant the envelope speed ID of 7, which is $0C! 
;;
;;    Note that overflow when doing math with these values is not handled by the
;;  game, so none of these values should go above %11111000.  That will ensure that
;;  the addition of the existing 'fraction' will never cause an overflow.

;lut_EnvSpeeds:
  ;       0,  1,  2,  3,  4,  5,  6,  7,  8,  9,  A,  B,  C,  D,  E,  F
;  .BYTE $80,$60,$40,$30,$20,$18,$10,$0C,$08,$06,$04,$03,$02,$01,$00,$00

;; envelope speeds used:
; Prelude          ; 5, C
; Prologue         ; 7 
; Epilogue         ; 8
; Overworld        ; 8, A, 6
; Ship             ; 8, 3, 4 
; Airship          ; 4, 9, 3, 8, 7
; Town             ; 8, 4
; Castle           ; 8 
; Volcano          ; 3, 7, 5, 8
; Matoya           ; 8, 4, 7
; Marsh Cave (New) ; 8, A, 6 
; Sea Shrine       ; 8, 3, 5
; Sky Castle       ; 6, 5, 8 
; Fiend Temple     ; 8, 3
; Shop             ; 9, 4, 8
; Battle           ; 8, 5, 9, 4, 6, 3
; Menu             ; 8
; Slain            ; 7
; Battle Win       ; 8, 5
; Marsh Cave (old) ; 8, 7, 6, 
; Fanfare          ; 8
; Save             ; 6, 8
; Heal             ; 8
; Treasure         ; 7
; Boss             ; 8, C, B, 9, D
; Ruined Castle    ; C, F, 7, D






;; JIGS - so to fix the Envelope Speeds in the songs, the left column is replaced with the right!
;; 00 -- 90
;; 01 -- 8C
;; 02 -- 88
;; 03 -- 86
;; 04 -- 84
;; 05 -- 83
;; 06 -- 82
;; 07 -- 81
;; 08 -- 01
;; 09 -- 02
;; 0A -- 02
;; 0B -- 03
;; 0C -- 04
;; 0D -- 08
;; 0E -- 00
;; 0F -- 00





;; JIGS - To put it into usable terms...
;;
;;ENV SPEED (ch_envrate)
;; vv   ENVELOPE DONE IN...                VALUES PER FRAME
;; 80 - 2 frames                         | 16
;; 60 - 3 frames                         | 12
;; 40 - 4 frames                         | 8
;; 30 - 6 frames                         | 6
;; 20 - 8 frames                         | 4
;; 18 - 11 frames                        | 3
;; 10 - 16 frames                        | 2
;; 0C - 32 frames                        | 1, 2 (uses ch_envrem)
;;                 
;;                                         FRAMES PER VALUE (uses ch_envrem)
;; 08 - 32 frames                        | 1
;; 06 - 52 frames                        | 2, 2, 1
;; 04 - 64 frames (1 second+4 frames)    | 2
;; 03 - 83 frames                        | 3, 3, 2
;; 02 - 128 frames (2 seconds+8 frames)  | 4
;; 01 - 256 frames (4 seconds+16 frames) | 8
;; 00 - never moves                      | 

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

InstrumentTable_Low:
.byte <Instrument_0
.byte <Instrument_1
.byte <Instrument_2
.byte <Instrument_3
.byte <Instrument_4
.byte <Instrument_5
.byte <Instrument_6
.byte <Instrument_7
.byte <Instrument_8
.byte <Instrument_9
.byte <Instrument_A
.byte <Instrument_B
.byte <Instrument_C
.byte <Instrument_D
.byte <Instrument_E
.byte <Instrument_F
.byte <Instrument_10
.byte <Instrument_11
;.byte <Instrument_12
;.byte <Instrument_13
;.byte <Instrument_14
;.byte <Instrument_15
;.byte <Instrument_16
;.byte <Instrument_17
;.byte <Instrument_18
;.byte <Instrument_19
;.byte <Instrument_1A
;.byte <Instrument_1B
;.byte <Instrument_1C
;.byte <Instrument_1D
;.byte <Instrument_1E
;.byte <Instrument_1F

InstrumentTable_High:
.byte >Instrument_0
.byte >Instrument_1
.byte >Instrument_2
.byte >Instrument_3
.byte >Instrument_4
.byte >Instrument_5
.byte >Instrument_6
.byte >Instrument_7
.byte >Instrument_8
.byte >Instrument_9
.byte >Instrument_A
.byte >Instrument_B
.byte >Instrument_C
.byte >Instrument_D
.byte >Instrument_E
.byte >Instrument_F
.byte >Instrument_10
.byte >Instrument_11
;.byte >Instrument_12
;.byte >Instrument_13
;.byte >Instrument_14
;.byte >Instrument_15
;.byte >Instrument_16
;.byte >Instrument_17
;.byte >Instrument_18
;.byte >Instrument_19
;.byte >Instrument_1A
;.byte >Instrument_1B
;.byte >Instrument_1C
;.byte >Instrument_1D
;.byte >Instrument_1E
;.byte >Instrument_1F

;; Instruments are now 64 bytes long, but to keep the original music the same, the second half is just a repeat of the last byte of the original envelopes.
;; Note you can set the two highest bits as duty now too!
;; may impliment a vibrato/legato toggle for bits #$20 and $10 later...

lut_EnvPatterns:
Instrument_0:
  .BYTE  $0F,$0F,$0E,$0E,$0D,$0D,$0C,$0C,$0B,$0B,$0A,$0A,$09,$09,$08,$08 ; pattern $E0
  .BYTE  $07,$07,$06,$06,$05,$05,$04,$04,$03,$03,$02,$02,$01,$01,$00,$00 ;  gradual decay from F
  .BYTE  $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
  .BYTE  $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
Instrument_1:
  .BYTE  $0C,$0C,$0C,$0B,$0B,$0B,$0A,$0A,$0A,$09,$09,$09,$08,$08,$08,$07 ; pattern $E1
  .BYTE  $07,$06,$06,$06,$05,$05,$04,$04,$03,$03,$02,$02,$01,$01,$00,$00 ;  gradual decay from C
  .BYTE  $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
  .BYTE  $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00  
Instrument_2:
  .BYTE  $08,$08,$08,$08,$07,$07,$07,$07,$06,$06,$06,$06,$05,$05,$05,$05 ; pattern $E2
  .BYTE  $04,$04,$04,$04,$03,$03,$03,$03,$02,$02,$02,$02,$01,$01,$00,$00 ;  gradual decay from 8
  .BYTE  $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
  .BYTE  $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00  
Instrument_3:
  .BYTE  $04,$04,$04,$04,$04,$04,$04,$04,$03,$03,$03,$03,$03,$03,$03,$03 ; pattern $E3 ; only used in Shop and new Marsh Cave
  .BYTE  $03,$03,$03,$03,$03,$03,$03,$02,$02,$02,$02,$02,$02,$00,$00,$00 ;  gradual decay from 4
  .BYTE  $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
  .BYTE  $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00  
Instrument_4:
  .BYTE  $0F,$0F,$0E,$0E,$0D,$0D,$0C,$0C,$0B,$0B,$0A,$0A,$09,$09,$08,$08 ; pattern $E4 ; unused
  .BYTE  $08,$08,$09,$09,$0A,$0A,$0B,$0B,$0C,$0C,$0D,$0D,$0E,$0E,$0F,$0F ;  fade from F->8->F
  .BYTE  $0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F
  .BYTE  $0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F
Instrument_5:
  .BYTE  $0C,$0C,$0B,$0B,$0A,$0A,$09,$09,$08,$08,$07,$07,$06,$06,$05,$05 ; pattern $E5 ; only used in Slain
  .BYTE  $04,$04,$05,$05,$06,$06,$07,$07,$08,$08,$09,$09,$0A,$0A,$0B,$0B ;  fade from C->4->B
  .BYTE  $0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B
  .BYTE  $0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B 
Instrument_6:
  .BYTE  $08,$08,$07,$07,$06,$06,$05,$05,$04,$04,$03,$03,$02,$02,$01,$01 ; pattern $E6
  .BYTE  $01,$01,$02,$02,$03,$03,$04,$04,$05,$05,$06,$06,$07,$07,$08,$08 ;  fade from 8->1->8
  .BYTE  $08,$08,$08,$08,$08,$08,$08,$08,$08,$08,$08,$08,$08,$08,$08,$08
  .BYTE  $08,$08,$08,$08,$08,$08,$08,$08,$08,$08,$08,$08,$08,$08,$08,$08
Instrument_7:
  .BYTE  $0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0E,$0E,$0C,$0C,$0B,$0B,$0A,$0A ; pattern $E7 ; only used in my prelude melody
  .BYTE  $09,$09,$08,$08,$07,$07,$06,$06,$05,$05,$04,$04,$04,$03,$03,$03 ;  hold, then decay from F
  .BYTE  $03,$03,$03,$03,$03,$03,$03,$03,$03,$03,$03,$03,$03,$03,$03,$03
  .BYTE  $03,$03,$03,$03,$03,$03,$03,$03,$03,$03,$03,$03,$03,$03,$03,$03
Instrument_8:
  .BYTE  $0C,$0C,$0C,$0C,$0C,$0C,$0C,$0C,$0B,$0B,$0A,$0A,$09,$09,$08,$08 ; pattern $E8
  .BYTE  $06,$06,$05,$05,$04,$04,$04,$03,$03,$03,$02,$02,$02,$02,$02,$02 ;  hold, then decay from C
  .BYTE  $02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02
  .BYTE  $02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02
Instrument_9:
  .BYTE  $04,$04,$04,$04,$04,$04,$04,$04,$04,$03,$03,$03,$03,$03,$03,$03 ; pattern $E9 ; JIGS - only used in my prelude melody
  .BYTE  $03,$03,$02,$02,$02,$02,$02,$02,$02,$02,$01,$01,$01,$01,$01,$01 ;  hold, then decay from 4
  .BYTE  $01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01
  .BYTE  $01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01
Instrument_A:
  .BYTE  $08,$08,$09,$09,$0A,$0A,$0B,$0B,$0C,$0C,$0D,$0D,$0E,$0E,$0F,$0F ; pattern $EA
  .BYTE  $0F,$0F,$0E,$0E,$0D,$0D,$0C,$0C,$0B,$0B,$0A,$0A,$09,$09,$08,$08 ;  fade from 8->F->8
  .BYTE  $08,$08,$08,$08,$08,$08,$08,$08,$08,$08,$08,$08,$08,$08,$08,$08
  .BYTE  $08,$08,$08,$08,$08,$08,$08,$08,$08,$08,$08,$08,$08,$08,$08,$08
Instrument_B:
  .BYTE  $04,$04,$05,$05,$06,$06,$07,$07,$08,$08,$09,$09,$0A,$0A,$0B,$0B ; pattern $EB
  .BYTE  $0C,$0B,$0A,$0A,$09,$09,$08,$08,$07,$07,$06,$06,$05,$05,$04,$04 ;  fade from 4->C->4
  .BYTE  $04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04
  .BYTE  $04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04
Instrument_C:
  .BYTE  $0F,$0E,$0D,$0C,$0B,$0A,$09,$08,$09,$0A,$0B,$0C,$0B,$0A,$09,$08 ; pattern $EC
  .BYTE  $07,$06,$05,$04,$05,$06,$07,$08,$07,$06,$05,$04,$03,$02,$01,$00 ;  decay from F with tremolo
  .BYTE  $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
  .BYTE  $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
Instrument_D:
  .BYTE  $0C,$0C,$0B,$0B,$0A,$0A,$09,$08,$09,$0A,$0B,$0C,$0B,$0A,$09,$08 ; pattern $ED
  .BYTE  $07,$06,$05,$04,$05,$06,$07,$08,$07,$06,$05,$04,$03,$02,$01,$00 ;  decay from C with tremolo
  .BYTE  $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
  .BYTE  $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
Instrument_E:
  .BYTE  $0C,$0B,$0A,$09,$08,$07,$06,$05,$04,$05,$06,$07,$08,$07,$06,$05 ; pattern $EE
  .BYTE  $04,$05,$06,$07,$08,$07,$06,$05,$04,$05,$06,$07,$08,$09,$0A,$0B ;  fade C->4->B with tremolo
  .BYTE  $0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B
  .BYTE  $0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B
Instrument_F:
  .BYTE  $01,$02,$03,$04,$05,$06,$07,$08,$09,$0A,$0B,$0C,$0B,$0A,$09,$08 ; pattern $EF ; JIGS - only used in my prelude melody and ruined castle
  .BYTE  $07,$06,$05,$04,$05,$06,$07,$08,$09,$08,$07,$06,$05,$04,$03,$01 ;  fade from 1->C->4->9->1
  .BYTE  $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
  .BYTE  $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00

;;New instruments!
Instrument_10:
  .BYTE  $0C,$0C,$0C,$0C,$0A,$04,$04,$04,$04,$02,$0A,$0A,$0A,$0A,$08,$02 ; Ruined Castle echoey boops
  .BYTE  $02,$02,$02,$01,$08,$08,$08,$08,$06,$01,$01,$01,$01,$01,$06,$06
  .BYTE  $06,$06,$04,$00,$00,$00,$00,$00,$04,$04,$04,$04,$02,$00,$00,$00
  .BYTE  $00,$00,$02,$02,$02,$02,$01,$00,$00,$00,$00,$00,$00,$00,$00,$00
Instrument_11:
  .BYTE  $0E,$0E,$0E,$0E,$0C,$06,$06,$06,$06,$04,$0C,$0C,$0C,$0C,$0A,$04 ; Slightly louder echoey boops!
  .BYTE  $04,$04,$04,$02,$0A,$0A,$0A,$0A,$08,$02,$02,$02,$02,$01,$08,$08
  .BYTE  $08,$08,$06,$01,$01,$01,$01,$01,$06,$06,$06,$06,$04,$00,$00,$00
  .BYTE  $00,$00,$04,$04,$04,$04,$02,$00,$00,$00,$00,$00,$00,$00,$00,$00

;; JIGS - some alternate pattern ideas:
;   .BYTE  $0C,$0B,$0A,$0B,$0C,$0B,$0A,$09,$08,$07,$06,$05,$04,$05,$06,$07
;   .BYTE  $08,$09,$0A,$0B,$0B,$0A,$09,$08,$07,$06,$05,$04,$03,$02,$01,$00 ;  C\A/C \>\ 4 />/ B \\\\  (Violin/Pipes)
;
;  .BYTE $0F,$0E,$0C,$0A,$08,$05,$03,$01,$0C,$0A,$08,$06,$04,$02,$00,$00 ; Echo
;  .BYTE $08,$07,$06,$04,$02,$00,$00,$00,$04,$03,$02,$01,$00,$00,$00,$00
;
;  Note that with the half-volume control, you don't need pattern E2 or E3;
;  You can use pattern E0 or E1 and just put the hush on it to have it almost the same! Almost.
;  Many other patterns can be taken out and replaced with this.

ClearChannels:
    LDA #0
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
    RTS

SilenceAPU:
    LDA #$30            ; *then* set channel volumes to zero -- this will properly
    STA $4000           ;  silence the squares and noise... and will eventually silence
    STA $4004           ;  triangle (next linear counter clock).
    STA $4008
    STA $400C
    STA $5000           ; MMC5 Square 1 (Square 3) - JIGS
    STA $5004           ; MMC5 Square 2 (Square 4) - JIGS
    RTS

BackupMapMusic:
    LDA #1
    STA $5113         ; swap RAM
   
    LDX #0
   @MainLoop:
    LDA CHAN_START, X
    STA MapMusicBackup, X
    INX
    CPX #80
    BNE @MainLoop
 
    LDA #0
    STA $5113         ; swap RAM
    RTS


RestoreMapMusic:
    JSR ClearChannels
    JSR SilenceAPU

    LDA #1
    STA $5113         ; swap RAM

    LDX #0
   @MainLoop:
    LDA MapMusicBackup, X
    STA CHAN_START, X
    INX
    CPX #80
    BNE @MainLoop
    
    LDA CHAN_SQ1 + ch_freq+1  
    AND #~$80
    STA CHAN_SQ1 + ch_freq+1  ; turn off high bit to indicate freq should update
    
    LDA CHAN_SQ2 + ch_freq+1  
    AND #~$80
    STA CHAN_SQ2 + ch_freq+1  ; turn off high bit to indicate freq should update
    
    LDA CHAN_SQ3 + ch_freq+1  
    AND #~$80
    STA CHAN_SQ3 + ch_freq+1  ; turn off high bit to indicate freq should update
    
    LDA CHAN_SQ4 + ch_freq+1  
    AND #~$80
    STA CHAN_SQ4 + ch_freq+1  ; turn off high bit to indicate freq should update
    
    LDA CHAN_TRI + ch_freq+1  
    AND #~$80
    STA CHAN_TRI + ch_freq+1  ; turn off high bit to indicate freq should update

    LDA mapflags            ; make sure we're on the overworld
    LSR A                   ; Get SM flag, and shift it into C
    BCC :+                  ; if set (on overworld), do overworld music
  
    ;LDX cur_tileset               ; get the tileset
    ;LDA lut_TilesetMusicTrack, X  ; use it to get the music track tied to this tileset
    LDX cur_map
    LDA lut_MapMusicTrack, X
    BNE @End
  
  : LDX vehicle
    LDA lut_VehicleMusic, X
  
   @End:
    STA dlgmusic_backup     ; if this isn't the same as the map music, the map loading will re-start it anyway
  
    JSR WaitForVBlank_L     ; wait a frame
  
    LDA #$00                ; burn a bunch of CPU time -- presumably so that
    : SEC                   ;  WaitForVBlank isn't called again so close to start of
      SBC #$01              ;  vblank.  I don't think this is actually necessary,
      BNE :-                ;  but it doesn't hurt.

    JSR WaitForVBlank_L     ; wait another frame

    LDA #0
    STA $5113         ; swap RAM
    RTS

;; JIGS - these two things raise and lower the volume of the triangle

HushTriangle:
    LDA TriangleHush
    AND #$7F
    CMP #$7F
    BEQ @return        ; its already at max!
    INC TriangleHush
    LDA TriangleHush
    STA $4011
   @return:
    RTS
    
UnhushTriangle:
    AND #$7F
    BEQ @return
    DEC TriangleHush
    LDA TriangleHush
    STA $4011
   @return: 
    RTS  











lut_MapMusicTrack:
.byte $47 ; 00 - CONERIA
.byte $47 ; 01 - PRAVOKA
.byte $47 ; 02 - ELFLAND
.byte $47 ; 03 - MELMOND
.byte $47 ; 04 - CRESCENT_LAKE
.byte $47 ; 05 - GAIA
.byte $47 ; 06 - ONRAC
.byte $47 ; 07 - LEIFEN
.byte $48 ; 08 - Coneria_CASTLE_1F
.byte $48 ; 09 - ELFLAND_CASTLE
.byte $5B ; 0A - NORTHWEST_CASTLE
.byte $5B ; 0B - CASTLE_OF_ORDEALS_1F
.byte $4E ; 0C - TEMPLE_OF_FIENDS_PRESENT
.byte $49 ; 0D - EARTH_CAVE_B1
.byte $49 ; 0E - GURGU_VOLCANO_B1
.byte $4B ; 0F - ICE_CAVE_B1
.byte $4A ; 10 - CARDIA
.byte $5B ; 4A ; 11 - BAHAMUTS_ROOM_B1
.byte $4B ; 12 - WATERFALL
.byte $4A ; 13 - DWARF_CAVE
.byte $4A ; 14 - MATOYAS_CAVE
.byte $4A ; 15 - SARDAS_CAVE
.byte $4B ; 16 - MARSH_CAVE_B1
.byte $4B ; 17 - MIRAGE_TOWER_1F
.byte $48 ; 18 - Coneria_CASTLE_2F
.byte $5B ; 19 - Castle_of_Ordeals_2F
.byte $5B ; 1A - Castle_of_Ordeals_3F
.byte $4B ; 1B - Marsh_Cave_B2
.byte $4B ; 1C - Marsh_Cave_B3
.byte $49 ; 1D - Earth_Cave_B2
.byte $49 ; 1E - Earth_Cave_B3
.byte $49 ; 1F - Earth_Cave_B4
.byte $49 ; 20 - Earth_Cave_B5
.byte $49 ; 21 - Gurgu_Volcano_B2
.byte $49 ; 22 - Gurgu_Volcano_B3
.byte $49 ; 23 - Gurgu_Volcano_B4
.byte $49 ; 24 - Gurgu_Volcano_B5
.byte $4B ; 25 - Ice_Cave_B2
.byte $4B ; 26 - Ice_Cave_B3
.byte $5B ; 4A ; 27 - Bahamuts_Room_B2
.byte $4B ; 28 - Mirage_Tower_2F
.byte $4B ; 29 - Mirage_Tower_3F
.byte $4C ; 2A - Sea_Shrine_B5
.byte $4C ; 2B - Sea_Shrine_B4
.byte $4C ; 2C - Sea_Shrine_B3
.byte $4C ; 2D - Sea_Shrine_B2
.byte $4C ; 2E - Sea_Shrine_B1
.byte $4D ; 2F - Sky_Palace_1F
.byte $4D ; 30 - Sky_Palace_2F
.byte $4D ; 31 - Sky_Palace_3F
.byte $4D ; 32 - Sky_Palace_4F
.byte $4D ; 33 - Sky_Palace_5F
.byte $4E ; 34 - Temple_of_Fiends_1F
.byte $4E ; 35 - Temple_of_Fiends_2F
.byte $4E ; 36 - Temple_of_Fiends_3F
.byte $4E ; 37 - Temple_of_Fiends_4F_Earth
.byte $4E ; 38 - Temple_of_Fiends_5F_Fire
.byte $4E ; 39 - Temple_of_Fiends_6F_Water
.byte $4E ; 3A - Temple_of_Fiends_7F_Wind
.byte $4E ; 3B - Temple_of_Fiends_8F_Chaos
.byte $4B ; 3C - Titans_Tunnel






.byte "END OF BANK MUSIC"


