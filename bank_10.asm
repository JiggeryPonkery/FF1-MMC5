.include "Constants.inc"
.include "variables.inc"
.feature force_range

.export lut_DialoguePtrTbl
.export TalkToObject
.export HideMapObject
.export ShowMapObject
.export GetDialogueString
.export KeyItem_Add
.export KeyItem_LongCall_Add

.import MultiplyXA
.import FindEmptyWeaponSlot
.import Set_Inv_Weapon
.import ADD_ITEM


.segment "BANK_10"

BANK_THIS = $10

;; JIGS - Since NPCs/map objects can use the alternate table and standard map tiles cannot, I've moved all NPC dialogue to the second table

lut_DialoguePtrTbl:
.WORD EMPTY             ; 00 ; Nothing here.
.WORD HIDDENTREASURE    ; 01 ; While searching around, you found...
.WORD RECOVEREDHP       ; 02 ; A soft light spreads throughout the party... HP restored!
.WORD RECOVEREDMP       ; 03 ; A soft light spreads throughout the party... MP restored!
.WORD RECOVEREDHPMP     ; 04 ; A soft light spreads throughout the party... HP and MP restored!
.WORD REVIVED           ; 05 ; A soft light spreads throughout the party... Revived!
.WORD AILMENTSCURED     ; 06 ; A soft light spreads throughout the party... Cured!
.WORD EMPTY             ; 07 ; Nothing here.
.WORD EMPTY             ; 08 ; Nothing here.
.WORD EMPTY             ; 09 ; Nothing here.
.WORD EMPTY             ; 0A ; Nothing here.
.WORD EMPTY             ; 0B ; Nothing here.
.WORD EMPTY             ; 0C ; Nothing here.
.WORD EMPTY             ; 0D ; Nothing here.
.WORD EMPTY             ; 0E ; Nothing here.
.WORD EMPTY             ; 0F ; Nothing here.
.WORD EMPTY             ; 10 ; Nothing here.
.WORD EMPTY             ; 11 ; Nothing here.
.WORD EMPTY             ; 12 ; Nothing here.
.WORD EMPTY             ; 13 ; Nothing here.
.WORD EMPTY             ; 14 ; Nothing here.
.WORD EMPTY             ; 15 ; Nothing here.
.WORD EMPTY             ; 16 ; Nothing here.
.WORD EMPTY             ; 17 ; Nothing here.
.WORD EMPTY             ; 18 ; Nothing here.
.WORD EMPTY             ; 19 ; Nothing here.
.WORD EMPTY             ; 1A ; Nothing here.
.WORD EMPTY             ; 1B ; Nothing here.
.WORD EMPTY             ; 1C ; Nothing here.
.WORD EMPTY             ; 1D ; Nothing here.
.WORD EMPTY             ; 1E ; Nothing here.
.WORD EMPTY             ; 1F ; Nothing here.
.WORD EMPTY             ; 20 ; Nothing here.
.WORD EMPTY             ; 21 ; Nothing here.
.WORD EMPTY             ; 22 ; Nothing here.
.WORD EMPTY             ; 23 ; Nothing here.
.WORD EMPTY             ; 24 ; Nothing here.
.WORD EMPTY             ; 25 ; Nothing here.
.WORD EMPTY             ; 26 ; Nothing here.
.WORD EMPTY             ; 27 ; Nothing here.
.WORD EMPTY             ; 28 ; Nothing here.
.WORD EMPTY             ; 29 ; Nothing here.
.WORD EMPTY             ; 2A ; Nothing here.
.WORD EMPTY             ; 2B ; Nothing here.
.WORD EMPTY             ; 2C ; Nothing here.
.WORD EMPTY             ; 2D ; Nothing here.
.WORD EMPTY             ; 2E ; Nothing here.
.WORD EMPTY             ; 2F ; Nothing here.
.WORD EMPTY             ; 30 ; Nothing here.
.WORD EMPTY             ; 31 ; Nothing here.
.WORD EMPTY             ; 32 ; Nothing here.
.WORD EMPTY             ; 33 ; Nothing here.
.WORD EMPTY             ; 34 ; Nothing here.
.WORD EMPTY             ; 35 ; Nothing here.
.WORD EMPTY             ; 36 ; Nothing here.
.WORD EMPTY             ; 37 ; Nothing here.
.WORD EMPTY             ; 38 ; Nothing here.
.WORD EMPTY             ; 39 ; Nothing here.
.WORD EMPTY             ; 3A ; Nothing here.
.WORD EMPTY             ; 3B ; Nothing here.
.WORD EMPTY             ; 3C ; Nothing here.
.WORD EMPTY             ; 3D ; Nothing here.
.WORD EMPTY             ; 3E ; Nothing here.
.WORD EMPTY             ; 3F ; Nothing here.
.WORD EMPTY             ; 40 ; Nothing here.
.WORD EMPTY             ; 41 ; Nothing here.
.WORD EMPTY             ; 42 ; Nothing here.
.WORD EMPTY             ; 43 ; Nothing here.
.WORD EMPTY             ; 44 ; Nothing here.
.WORD EMPTY             ; 45 ; Nothing here.
.WORD EMPTY             ; 46 ; Nothing here.
.WORD EMPTY             ; 47 ; Nothing here.
.WORD EMPTY             ; 48 ; Nothing here.
.WORD EMPTY             ; 49 ; Nothing here.
.WORD EMPTY             ; 4A ; Nothing here.
.WORD EMPTY             ; 4B ; Nothing here.
.WORD EMPTY             ; 4C ; Nothing here.
.WORD EMPTY             ; 4D ; Nothing here.
.WORD EMPTY             ; 4E ; Nothing here.
.WORD EMPTY             ; 4F ; Nothing here.
.WORD EMPTY             ; 50 ; Nothing here.
.WORD EMPTY             ; 51 ; Nothing here.
.WORD EMPTY             ; 52 ; Nothing here.
.WORD EMPTY             ; 53 ; Nothing here.
.WORD EMPTY             ; 54 ; Nothing here.
.WORD EMPTY             ; 55 ; Nothing here.
.WORD EMPTY             ; 56 ; Nothing here.
.WORD EMPTY             ; 57 ; Nothing here.
.WORD EMPTY             ; 58 ; Nothing here.
.WORD EMPTY             ; 59 ; Nothing here.
.WORD EMPTY             ; 5A ; Nothing here.
.WORD EMPTY             ; 5B ; Nothing here.
.WORD EMPTY             ; 5C ; Nothing here.
.WORD EMPTY             ; 5D ; Nothing here.
.WORD EMPTY             ; 5E ; Nothing here.
.WORD EMPTY             ; 5F ; Nothing here.
.WORD EMPTY             ; 60 ; Nothing here.
.WORD EMPTY             ; 61 ; Nothing here.
.WORD EMPTY             ; 62 ; Nothing here.
.WORD EMPTY             ; 63 ; Nothing here.
.WORD EMPTY             ; 64 ; Nothing here.
.WORD EMPTY             ; 65 ; Nothing here.
.WORD EMPTY             ; 66 ; Nothing here.
.WORD EMPTY             ; 67 ; Nothing here.
.WORD EMPTY             ; 68 ; Nothing here.
.WORD EMPTY             ; 69 ; Nothing here.
.WORD EMPTY             ; 6A ; Nothing here.
.WORD EMPTY             ; 6B ; Nothing here.
.WORD EMPTY             ; 6C ; Nothing here.
.WORD EMPTY             ; 6D ; Nothing here.
.WORD EMPTY             ; 6E ; Nothing here.
.WORD EMPTY             ; 6F ; Nothing here.
.WORD EMPTY             ; 70 ; Nothing here.
.WORD EMPTY             ; 71 ; Nothing here.
.WORD EMPTY             ; 72 ; Nothing here.
.WORD EMPTY             ; 73 ; Nothing here.
.WORD EMPTY             ; 74 ; Nothing here.
.WORD EMPTY             ; 75 ; Nothing here.
.WORD EMPTY             ; 76 ; Nothing here.
.WORD EMPTY             ; 77 ; Nothing here.
.WORD EMPTY             ; 78 ; Nothing here.
.WORD EMPTY             ; 79 ; Nothing here.
.WORD EMPTY             ; 7A ; Nothing here.
.WORD EMPTY             ; 7B ; Nothing here.
.WORD EMPTY             ; 7C ; Nothing here.
.WORD EMPTY             ; 7D ; Nothing here.
.WORD EMPTY             ; 7E ; Nothing here.
.WORD EMPTY             ; 7F ; Nothing here.
.WORD EMPTY             ; 80 ; Nothing here.
.WORD EMPTY             ; 81 ; Nothing here.
.WORD EMPTY             ; 82 ; Nothing here.
.WORD EMPTY             ; 83 ; Nothing here.
.WORD EMPTY             ; 84 ; Nothing here.
.WORD EMPTY             ; 85 ; Nothing here.
.WORD EMPTY             ; 86 ; Nothing here.
.WORD EMPTY             ; 87 ; Nothing here.
.WORD EMPTY             ; 88 ; Nothing here.
.WORD EMPTY             ; 89 ; Nothing here.
.WORD EMPTY             ; 8A ; Nothing here.
.WORD EMPTY             ; 8B ; Nothing here.
.WORD EMPTY             ; 8C ; Nothing here.
.WORD EMPTY             ; 8D ; Nothing here.
.WORD EMPTY             ; 8E ; Nothing here.
.WORD EMPTY             ; 8F ; Nothing here.
.WORD EMPTY             ; 90 ; Nothing here.
.WORD EMPTY             ; 91 ; Nothing here.
.WORD EMPTY             ; 92 ; Nothing here.
.WORD EMPTY             ; 93 ; Nothing here.
.WORD EMPTY             ; 94 ; Nothing here.
.WORD EMPTY             ; 95 ; Nothing here.
.WORD EMPTY             ; 96 ; Nothing here.
.WORD EMPTY             ; 97 ; Nothing here.
.WORD EMPTY             ; 98 ; Nothing here.
.WORD EMPTY             ; 99 ; Nothing here.
.WORD EMPTY             ; 9A ; Nothing here.
.WORD EMPTY             ; 9B ; Nothing here.
.WORD EMPTY             ; 9C ; Nothing here.
.WORD EMPTY             ; 9D ; Nothing here.
.WORD EMPTY             ; 9E ; Nothing here.
.WORD EMPTY             ; 9F ; Nothing here.
.WORD EMPTY             ; A0 ; Nothing here.
.WORD EMPTY             ; A1 ; Nothing here.
.WORD EMPTY             ; A2 ; Nothing here.
.WORD EMPTY             ; A3 ; Nothing here.
.WORD EMPTY             ; A4 ; Nothing here.
.WORD EMPTY             ; A5 ; Nothing here.
.WORD EMPTY             ; A6 ; Nothing here.
.WORD EMPTY             ; A7 ; Nothing here.
.WORD EMPTY             ; A8 ; Nothing here.
.WORD EMPTY             ; A9 ; Nothing here.
.WORD EMPTY             ; AA ; Nothing here.
.WORD EMPTY             ; AB ; Nothing here.
.WORD EMPTY             ; AC ; Nothing here.
.WORD EMPTY             ; AD ; Nothing here.
.WORD EMPTY             ; AE ; Nothing here.
.WORD EMPTY             ; AF ; Nothing here.
.WORD EMPTY             ; B0 ; Nothing here.
.WORD EMPTY             ; B1 ; Nothing here.
.WORD EMPTY             ; B2 ; Nothing here.
.WORD FLOORSWORD        ; B3 ; No! That is just an unusable sample.
.WORD EMPTY             ; B4 ; Nothing here.
.WORD EMPTY             ; B5 ; Nothing here.
.WORD EMPTY             ; B6 ; Nothing here.
.WORD EMPTY             ; B7 ; Nothing here.
.WORD EMPTY             ; B8 ; Nothing here.
.WORD EMPTY             ; B9 ; Nothing here.
.WORD EMPTY             ; BA ; Nothing here.
.WORD EMPTY             ; BB ; Nothing here.
.WORD EMPTY             ; BC ; Nothing here.
.WORD EMPTY             ; BD ; Nothing here.
.WORD EMPTY             ; BE ; Nothing here.
.WORD LOCKEDDOOR        ; BF ; This door is locked by the mystic KEY.
.WORD EMPTY             ; C0 ; Nothing here.
.WORD EMPTY             ; C1 ; Nothing here.
.WORD EMPTY             ; C2 ; Nothing here.
.WORD EMPTY             ; C3 ; Nothing here.
.WORD EMPTY             ; C4 ; Nothing here.
.WORD EMPTY             ; C5 ; Nothing here.
.WORD EMPTY             ; C6 ; Nothing here.
.WORD EMPTY             ; C7 ; Nothing here.
.WORD EMPTY             ; C8 ; Nothing here.
.WORD EMPTY             ; C9 ; Nothing here.
.WORD EMPTY             ; CA ; Nothing here.
.WORD EMPTY             ; CB ; Nothing here.
.WORD EMPTY             ; CC ; Nothing here.
.WORD EMPTY             ; CD ; Nothing here.
.WORD EMPTY             ; CE ; Nothing here.
.WORD EMPTY             ; CF ; Nothing here.
.WORD EMPTY             ; D0 ; Nothing here.
.WORD EMPTY             ; D1 ; Nothing here.
.WORD EMPTY             ; D2 ; Nothing here.
.WORD EMPTY             ; D3 ; Nothing here.
.WORD EMPTY             ; D4 ; Nothing here.
.WORD EMPTY             ; D5 ; Nothing here.
.WORD EMPTY             ; D6 ; Nothing here.
.WORD EMPTY             ; D7 ; Nothing here.
.WORD EMPTY             ; D8 ; Nothing here.
.WORD EMPTY             ; D9 ; Nothing here.
.WORD EMPTY             ; DA ; Nothing here.
.WORD GRAVE2            ; DB ; Here lies Erdrick     837 - 866       R.I.P.
.WORD EMPTY             ; DC ; Nothing here.
.WORD EMPTY             ; DD ; Nothing here.
.WORD EMPTY             ; DE ; Nothing here.
.WORD EMPTY             ; DF ; Nothing here.
.WORD EMPTY             ; E0 ; Nothing here.
.WORD EMPTY             ; E1 ; Nothing here.
.WORD EMPTY             ; E2 ; Nothing here.
.WORD EMPTY             ; E3 ; Nothing here.
.WORD EMPTY             ; E4 ; Nothing here.
.WORD EMPTY             ; E5 ; Nothing here.
.WORD FOUNTAIN          ; E6 ; See your face upon the clean water. How dirty! Come! Wash your face!
.WORD EMPTY             ; E7 ; Nothing here.
.WORD EMPTY             ; E8 ; Nothing here.
.WORD EMPTY             ; E9 ; Nothing here.
.WORD EMPTY             ; EA ; Nothing here.
.WORD EMPTY             ; EB ; Nothing here.
.WORD EMPTY             ; EC ; Nothing here.
.WORD EMPTY             ; ED ; Nothing here.
.WORD GRAVE             ; EE ; This is a tomb.
.WORD WELL              ; EF ; This is a well. You might think that there is something to it.... But in fact it is just an ordinary well.
.WORD TREASURE          ; F0 ; In the treasure box, you found....
.WORD TREASUREFULL      ; F1 ; Can't hold anymore.
.WORD TREASUREEMPTY     ; F2 ; The treasure box is empty!
.WORD ALTAREARTH        ; F3 ; The Altar of the Earth.
.WORD ALTARFIRE         ; F4 ; The Altar of the Fire.
.WORD ALTARWATER        ; F5 ; The Altar of the Water.
.WORD ALTARDWIND        ; F6 ; The Altar of the Wind.
.WORD OXYALESPRING      ; F7 ; At the bottom of the spring, something is flowing.
.WORD TIAMATSOMETHING   ; F8 ; TIAMAT is the FIEND of the WIND....
.WORD SKYWINDOW         ; F9 ; From this window one can see the entire world. The Four Forces are flowing together, into the center of the Four Altars. Into the Temple of FIENDS.
.WORD EMPTY             ; FA ; Nothing here.
.WORD EMPTY             ; FB ; Nothing here.
.WORD EMPTY             ; FC ; Nothing here.
.WORD EMPTY             ; FD ; Nothing here.
.WORD EMPTY             ; FE ; Nothing here.
.WORD STONEPLATE        ; FF ; There is a stone plate on the floor.... You sense something.... Evil?....

;; THIS MUST BE HERE, DO NOT MOVE IT.

GetDialogueString:
    TXA                   ; get the string ID back
    ASL A                 ; double it (2 bytes per pointer)
    TAX                   ; and put in X for indexing
    BCS @HiTbl            ; if string ID was >= $80 use 2nd half of table, otherwise use first half

    @LoTbl:
      LDA lut_DialoguePtrTbl, X        ; load up the pointer into text_ptr
      STA text_ptr
      LDA lut_DialoguePtrTbl+1, X
      STA text_ptr+1
      RTS

    @HiTbl:
      LDA lut_DialoguePtrTbl+$100, X   ; same, but read from 2nd half of pointer table
      STA text_ptr
      LDA lut_DialoguePtrTbl+$101, X
      STA text_ptr+1
      RTS
      







EMPTY: 
.byte $97,$B2,$1C,$1F,$47,$1D,$23,$C0,$00

HIDDENTREASURE:
.byte $A0,$3D,$45,$24,$2B,$B5,$A6,$3D,$2A,$20,$4D,$B8,$3B,$05,$56,$64,$A9,$26,$3B,$69,$01,$02,$00

RECOVEREDHP:
.BYTE $FF,$FF,$8A,$24,$4C,$21,$68,$AA,$AB,$21,$B6,$B3,$23,$A4,$A7,$1E,$05,$FF,$1C,$4D,$B8,$AA,$AB,$26,$21,$1C,$1A,$B3,$2F,$B7,$BC,$C3,$C3,$05,$05,$05
.BYTE $FF,$FF,$FF,$FF,$FF,$FF,$91,$99,$FF,$9B,$2C,$28,$23,$A7,$C4,$00

RECOVEREDMP:
.BYTE $FF,$FF,$8A,$24,$4C,$21,$68,$AA,$AB,$21,$B6,$B3,$23,$A4,$A7,$1E,$05,$FF,$1C,$4D,$B8,$AA,$AB,$26,$21,$1C,$1A,$B3,$2F,$B7,$BC,$C3,$C3,$05,$05,$05
.BYTE $FF,$FF,$FF,$FF,$FF,$FF,$96,$99,$FF,$9B,$2C,$28,$23,$A7,$C4,$00

RECOVEREDHPMP:
.BYTE $FF,$FF,$8A,$24,$4C,$21,$68,$AA,$AB,$21,$B6,$B3,$23,$A4,$A7,$1E,$05,$FF,$1C,$4D,$B8,$AA,$AB,$26,$21,$1C,$1A,$B3,$2F,$B7,$BC,$C3,$C3,$05,$05,$05
.BYTE $FF,$FF,$91,$99,$20,$3B,$FF,$96,$99,$FF,$9B,$2C,$28,$23,$A7,$C4,$00

REVIVED:
.BYTE $FF,$FF,$8A,$24,$4C,$21,$68,$AA,$AB,$21,$B6,$B3,$23,$A4,$A7,$1E,$05,$FF,$1C,$4D,$B8,$AA,$AB,$26,$21,$1C,$1A,$B3,$2F,$B7,$BC,$C3,$C3,$05,$05,$05
.BYTE $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$9B,$A8,$B9,$AC,$32,$A7,$C4,$00

AILMENTSCURED:
.BYTE $FF,$FF,$8A,$24,$4C,$21,$68,$AA,$AB,$21,$B6,$B3,$23,$A4,$A7,$1E,$05,$FF,$1C,$4D,$B8,$AA,$AB,$26,$21,$1C,$1A,$B3,$2F,$B7,$BC,$C3,$C3,$05,$05,$05
.BYTE $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$8C,$55,$40,$C4,$00

FLOORSWORD: 
.byte $97,$B2,$C4,$05,$9D,$AB,$A4,$21,$AC,$1E,$AD,$B8,$37,$20,$B1,$05,$B8,$B1,$B8,$B6,$A4,$A5,$AF,$1A,$B6,$A4,$B0,$B3,$45,$C0,$00

LOCKEDDOOR: 
.byte $9D,$AB,$AC,$1E,$A7,$B2,$35,$2D,$1E,$AF,$B2,$A6,$AE,$A8,$27,$A5,$BC,$05,$B7,$AB,$1A,$B0,$BC,$37,$AC,$A6,$FF,$94,$8E,$A2,$C0,$00

GRAVE2: 
.byte $91,$A8,$B5,$1A,$68,$A8,$1E,$8E,$B5,$A7,$5C,$A6,$AE,$05,$FF,$FF,$FF,$FF,$88,$83,$87,$FF,$C2,$FF,$88,$86,$86,$05,$FF,$FF,$FF,$FF,$FF,$FF,$9B,$C0,$92,$C0,$99,$C0,$00

GRAVE: 
.byte $9D,$AB,$AC,$1E,$30,$20,$1B,$49,$A5,$C0,$00

FOUNTAIN: 
.byte $9C,$A8,$1A,$BC,$26,$B5,$43,$5E,$1A,$B8,$B3,$3C,$1B,$1D,$05,$A6,$AF,$A8,$22,$33,$39,$25,$C0,$FF,$91,$46,$67,$AC,$B5,$B7,$BC,$C4,$05,$8C,$B2,$34,$C4,$FF,$A0,$3F,$AB,$50,$26,$B5,$43,$A4,$48,$C4,$00

WELL: 
.byte $9D,$AB,$AC,$1E,$30,$20,$33,$A8,$4E,$C0,$FF,$A2,$26,$05,$B0,$AC,$AA,$AB,$B7,$1B,$AB,$1F,$AE,$1B,$AB,$39,$1B,$1D,$23,$05,$AC,$B6,$24,$B2,$34,$1C,$1F,$AA,$1B,$B2,$2D,$B7,$69,$05,$8B,$B8,$21,$1F,$43,$5E,$21,$5B,$2D,$1E,$AD,$B8,$37,$05,$A4,$B1,$FF,$35,$A7,$1F,$2F,$BC,$33,$A8,$4E,$C0,$00

TREASURE: 
.byte $92,$B1,$1B,$AB,$1A,$B7,$23,$3F,$55,$1A,$A5,$B2,$BB,$BF,$05,$BC,$B2,$B8,$43,$B2,$B8,$3B,$69,$01,$02,$00

TREASUREFULL: 
.byte $92,$B1,$1B,$AB,$1A,$B7,$23,$3F,$55,$1A,$A5,$B2,$BB,$BF,$05,$BC,$B2,$B8,$43,$B2,$B8,$3B,$69,$01,$02,$01
.byte $C3,$C0,$8B,$B8,$B7,$FF,$BC,$B2,$B8
.byte $A6,$A4,$B1,$BE,$21,$AB,$B2,$AF,$A7,$20,$B1,$BC,$FF,$B0,$B2,$23,$C0,$00

;; In the treasure box, you found....
;; ITEM
;; ... But you can't hold any more.

TREASUREEMPTY: 
.byte $9D,$AB,$1A,$B7,$23,$3F,$55,$1A,$A5,$B2,$BB,$2D,$B6,$05,$A8,$B0,$B3,$B7,$BC,$C4,$00

ALTAREARTH: 
.byte $9D,$AB,$1A,$8A,$AF,$B7,$2F,$36,$A9,$1B,$AB,$1A,$8E,$2F,$1C,$C0,$00

ALTARFIRE: 
.byte $9D,$AB,$1A,$8A,$AF,$B7,$2F,$36,$A9,$1B,$AB,$1A,$8F,$AC,$23,$C0,$00

ALTARWATER: 
.byte $9D,$AB,$1A,$8A,$AF,$B7,$2F,$36,$A9,$1B,$AB,$1A,$A0,$39,$25,$C0,$00

ALTARDWIND: 
.byte $9D,$AB,$1A,$8A,$AF,$B7,$2F,$36,$A9,$1B,$AB,$1A,$A0,$1F,$A7,$C0,$00

OXYALESPRING: 
.byte $8A,$B7,$1B,$AB,$1A,$A5,$B2,$B7,$28,$B0,$36,$A9,$1B,$1D,$05,$B6,$B3,$B5,$1F,$AA,$BF,$24,$B2,$34,$1C,$1F,$AA,$2D,$B6,$05,$A9,$AF,$46,$1F,$AA,$C0,$00

TIAMATSOMETHING: 
.byte $9D,$92,$8A,$52,$9D,$2D,$B6,$1B,$AB,$1A,$8F,$92,$8E,$97,$8D,$36,$A9,$05,$B7,$AB,$1A,$A0,$92,$97,$8D,$69,$00

SKYWINDOW: 
.byte $8F,$B5,$49,$1B,$3D,$1E,$BA,$1F,$A7,$46,$36,$B1,$1A,$A6,$22,$05,$B6,$A8,$1A,$1C,$1A,$3A,$57,$B5,$1A,$BA,$35,$AF,$A7,$C0,$05,$9D,$AB,$1A,$8F,$26,$44,$8F,$35,$48,$1E,$A4,$23,$05,$A9,$AF,$46,$1F,$AA,$1B,$B2,$66,$1C,$25,$BF,$FF,$1F,$28,$05,$B7,$AB,$1A,$A6,$3A,$B7,$25,$36,$A9,$1B,$AB,$1A,$8F,$26,$B5,$05,$8A,$AF,$B7,$2F,$B6,$C0,$FF,$92,$B1,$28,$1B,$AB,$1A,$9D,$A8,$B0,$B3,$45,$05,$B2,$A9,$FF,$8F,$92,$8E,$97,$8D,$9C,$C0,$00

STONEPLATE: 
.byte $9D,$AB,$25,$1A,$AC,$1E,$A4,$24,$28,$B1,$1A,$B3,$AF,$39,$A8,$05,$B2,$B1,$1B,$AB,$1A,$A9,$AF,$B2,$35,$69,$05,$A2,$B2,$B8,$24,$3A,$B6,$1A,$B6,$B2,$34,$1C,$1F,$AA,$69,$05,$8E,$B9,$61,$C5,$69,$00











;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  TalkToObject  [$902B :: 0x3903B]
;;
;;    Called to talk to a object on the map (townsperson, etc).
;;
;;  IN:        X = index to map object (to index 'mapobj' buffer)
;;        dlgsfx, dlgflg_reentermap = assumed to be zero
;;
;;  OUT:       A = ID of dialogue text to print onscreen
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

TalkToObject:
    LDA mapobj_id, X    ; get the ID of the object they're talking to
    
    LDX #6
    JSR MultiplyXA
    STA tmp+4
    STX tmp+5
    CLC                 ; JIGS - added

    ADC #<lut_MapObjTalkData   ; and add the pointer to the start of the talk data table to that
    STA tmp+4
    LDA #>lut_MapObjTalkData
    ADC tmp+5
    STA tmp+5                  ; (tmp+6) now points to the talk data for this object

    LDY #0              ; copy the 4 bytes of talk data to the first 4 bytes of temp RAM
    LDA (tmp+4), Y
    STA tmp
    INY
    LDA (tmp+4), Y
    STA tmp+1
    INY
    LDA (tmp+4), Y
    STA tmp+2
    INY
    LDA (tmp+4), Y
    STA tmp+3
    
    INY 
    LDA (tmp+4), Y
    STA DialogueBank    ; JIGS - added

    INY
    LDA (tmp+4), Y
    ASL A               ; *2 (two bytes per pointer)
    TAY                 ; throw in Y for indexing
    
    LDA lut_MapObjTalkJumpTbl, Y       ; same, but with low half of table
    STA tmp+4
    LDA lut_MapObjTalkJumpTbl+1, Y
    STA tmp+5
    JMP (tmp+4)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Check Game Event Flag  [$9079 :: 0x39089]
;;
;;  IN:   Y = object ID whose event flag you want to check
;;  OUT:  C = state of event flag
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

CheckGameEventFlag:
    LDA game_flags, Y    ; Get the game flags using Y as index
    LSR A                ;   and shift the event flag into C
    LSR A
    RTS

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Set Game Event Flag  [$907F :: 0x3908F]
;;
;;  IN:  Y = object ID whose flag to set
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

SetGameEventFlag:
    LDA game_flags, Y   ; get the game flags
    ORA #GMFLG_EVENT    ; set the event bit
    STA game_flags, Y   ; and write back
    RTS

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Clear Game Event Flag  [$9088 :: 0x39098]
;;
;;  IN:  Y = object ID whose flag to clear
;;
;;  This routine is unused by the original game
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

ClearGameEventFlag:
    LDA game_flags, Y  ; get game flags
    AND #~GMFLG_EVENT  ; clear event bit
    STA game_flags, Y  ; write back
    RTS

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  IsObjectVisible  [$9091 :: 0x390A1]
;;
;;  IN:  Y = ID of object to test
;;  OUT: C = set if object is visible
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

IsObjectVisible:
    LDA game_flags, Y     ; get the game flags using object ID as index
    LSR A                 ; shift object visibility flag into C
    RTS                   ; and exit


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  HideThisMapObject [$9096 :: 0x390A6]
;;
;;    Hides a map object, just like HideMapObject, but assumes the object
;;  exists in the current list of map objects (once and only once) -- and also
;;  assumes where that object is located is known.
;;
;;    As opposed to HideMapObject, which scans the entire list of current map
;;  objects and removes all occurances of the object.
;;
;;  IN:  Y = ID of object (to index 'game_flags')
;;       X = map object list index (to index 'mapobj')
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

HideThisMapObject:
    LDA game_flags, Y        ; get the game flags using object ID as index
    AND #~GMFLG_OBJVISIBLE   ; flip off the obj visibility flag (hide object)
    STA game_flags, Y        ; write it back

    LDA #0                   ; kill the object on the map by removing it from the list of
    STA mapobj_id, X         ; map objects

    RTS                      ; then exit

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Show Map Object [$90A4 :: 0x390B4]
;;
;;    Makes the given object ID visible, and shows one object on the map which uses that
;;  ID (if there is one).
;;
;;  IN:   Y = ID of object to show
;;
;;    Note, this routine writes over 'tmp', so caution should be used when calling from
;;  one of the talk routines (which also use 'tmp' for something unrelated)
;;
;;    X remains unchanged by this routine
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

ShowMapObject:
    STY tmp               ; back up the object ID

    LDA game_flags, Y
    ORA #GMFLG_OBJVISIBLE ; set the object visibility flag
    STA game_flags, Y     ; and write it back

    LDY #0                ; zero Y for indexing (our loop counter -- mapobj index)
  @Loop:
      LDA tmp             ; get the backed up object ID
      CMP mapobj_rawid, Y ; compare to this map object's raw ID
      BEQ @Found          ; if they match, we found the object!

      TYA                 ; otherwise, increment our loop counter to look at
      CLC                 ; next map object
      ADC #$10
      TAY

      CMP #$F0            ; and loop until all 15 map objects checked
      BCC @Loop
    RTS

  @Found:                 ; if we found the object we need to show...
    STA mapobj_id, Y      ; .. write the raw ID to the used ID to make the object visible
    RTS                   ; and exit



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  TalkBattle  [$90C5 :: 0x390D5]
;;
;;    Triggers a battle via talking to someone (Garland, Astos, etc)
;;
;;  IN:  A = ID of battle formation to trigger
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

TalkBattle:
    STA btlformation     ; record the formation
    LDA #TP_BATTLEMARKER ; then overwrite the tile properties with the battle marker bit
    STA tileprop         ;    so a battle is triggered when the dialogue box closes
    RTS


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  TalkNormTeleport  [$90CC :: 0x390DE]
;;
;;    Triggers a normal teleport (standard map->standard map) via talking
;;  to someone (ie:  when you rescue the princess)
;;
;;  IN:  A = normal teleport ID
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

TalkNormTeleport:
    STA tileprop+1       ; overwrite tile properties so set up a normal teleport
    LDA #TP_TELE_NORM    ;  with given teleport ID
    STA tileprop         ; This will cause the teleport to happen as soon as the
    RTS                  ; dialogue box closes

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Jump table for actions when talking to townspeople  [$90D3 :: 0x390E3]
;;
;;    This is a ginourmous jump table.  It consists of $D0 entries -- one for each object ID.
;;  When you talk to an object on the map, its ID is used to index this table and the appropriate
;;  routine is jumped to.  See TalkRoutines below for further explanation.


lut_MapObjTalkJumpTbl:
.WORD Talk_Normal          ; 00
.WORD Talk_KingConeria     ; 01
.WORD Talk_Garland         ; 02
.WORD Talk_Princess1       ; 03
.WORD Talk_Princess2       ; 04
.WORD Talk_Bikke           ; 05
.WORD Talk_ElfDoc          ; 06
.WORD Talk_ElfPrince       ; 07
.WORD Talk_Astos           ; 08
.WORD Talk_Nerrick         ; 09
.WORD Talk_Smith           ; 0A
.WORD Talk_Matoya          ; 0B
.WORD Talk_Unne            ; 0C
.WORD Talk_Vampire         ; 0D
.WORD Talk_Sarda           ; 0E
.WORD Talk_Bahamut         ; 0F
.WORD Talk_SubEng          ; 10
.WORD Talk_CubeBot         ; 11
.WORD Talk_Fairy           ; 12
.WORD Talk_Titan           ; 13
.WORD Talk_CanoeSage       ; 14
.WORD Talk_OrdealsSage     ; 15
.WORD Talk_GiveChime       ; 16
.WORD Talk_GoBridge        ; 17
.WORD Talk_4Orb            ; 18
.WORD Talk_BlackOrb        ; 19
.WORD Talk_Replace         ; 1A
.WORD Talk_Fight           ; 1B
.WORD Talk_PrincessRescued ; 1C
.WORD Talk_ifVisible       ; 1D
.WORD Talk_ifHasItem       ; 1E
.WORD Talk_ifOrbLit        ; 1F
.WORD Talk_ifCanalGone     ; 20
.WORD Talk_ifKeyTNT        ; 21
.WORD Talk_ifHasAirship    ; 22
.WORD Talk_ifEarthVamp     ; 23
.WORD Talk_ifBridgeBuilt   ; 24
.WORD Talk_ifEarthFireOrbs ; 25
.WORD Talk_ifEventHappened ; 26
.WORD Talk_ifHasCanoe      ; 27





;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Hide Map Object [$9273 :: 0x39283]
;;
;;    Makes the given object ID invisible, and hides one object on the map which uses that
;;  ID (if there is one).
;;
;;  IN:   Y = ID of object to hide
;;
;;    Note, this routine writes over 'tmp', so caution should be used when calling from
;;  one of the talk routines (which also use 'tmp' for something unrelated)
;;
;;    X remains unchanged by this routine
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


HideMapObject:
    STY tmp                   ; back up the object ID
    LDA game_flags, Y
    AND #~GMFLG_OBJVISIBLE    ; clear the visibility flag for this object
    STA game_flags, Y

    LDY #0                ; zero Y for loop counter / mapobject indexing
  @Loop:
      LDA tmp             ; get the object ID
      CMP mapobj_id, Y    ; see if it matches this object's ID
      BEQ @Found          ; if it does, we found the object we need to hide!

      TYA                 ; otherwise, increment the loop counter to look at the next object
      CLC
      ADC #$10
      TAY

      CMP #$F0            ; and keep looping until all 15 map objects checked
      BCC @Loop
    RTS

  @Found:                 ; if we've found the map object we're hiding...
    LDA #0
    STA mapobj_id, Y      ; set it's ID to zero to hide it
    RTS                   ;  and exit



;; JIGS - this little routine will scan item_box for the item ID in A
;; Then it sets a 1 or 0 if you have it.
;; this is why the Key Item decompress was called before TalkToObj

ScanForKeyItem:
    STA tmp
    LDX #$FF
  : INX
    LDA item_box, X
    BEQ @Nothing
    
    CMP tmp
    BNE :-
    
   @FoundIt:
    LDA #1
   @Nothing:
    RTS

   
    
;; Gives a key item by setting a bit in a compressed key item byte!    
    
    
KeyItem_LongCall_Add:  ; called from menu bank when purchasing the bottle or the ??? book
    LDA LongCall_X
    
KeyItem_Add:    
    TAY                ; back up item ID ($10 to $2F)
    AND #$07           ; get the low 3 bits
    TAX                ; put in X to index table of bits  
    LDA KeyItem_LUT, X
    STA tmp            ; save as the bit to "increment" later
    TYA                ; restore item ID
    LSR A              ; shift right 4 times to remove low nybble
    LSR A
    LSR A              
    LSR A              ; result is now 1 or 2
    PHP                ; push carry flag to stack (carry flag = high bit of low nybble)
    LSR A              ; now shift right one more time
    BNE @KeyItem_3_4   ; if there's still a toggled bit left, the original byte was $2x
    
   @KeyItem_1_2:
    PLP                ; pull the earlier flag push
    BCC @KeyItem_1     ; if carry was clear, then there was no high bit in the low nybble
    
   @KeyItem_2:
    LDA keyitems_2     ; but if there was, then it was between $18 and $1F
    ORA tmp            ; "increment" the "has item" bit
    STA keyitems_2     ; save it back
    BNE @RTS           ; and jump to exit (BNE because it is known to not be 0 now)

   @KeyItem_1:
    LDA keyitems_1
    ORA tmp
    STA keyitems_1
    BNE @RTS
   
   @KeyItem_3_4:
    TYA
    PLP 
    BCC @KeyItem_3
    
   @KeyItem_4: 
    LDA keyitems_4
    ORA tmp
    STA keyitems_4
    BNE @RTS
    
   @KeyItem_3: 
    LDA keyitems_3
    ORA tmp
    STA keyitems_3
   
   @RTS:
    RTS


   

KeyItem_LUT:            ; 1        ; 2        ; 3      ; 4
  .BYTE %10000000 ; $80 ; lute     ; ruby     ; canoe  ; 
  .BYTE %01000000 ; $40 ; crown    ; rod      ; lewds  ; 
  .BYTE %00100000 ; $20 ; crystal  ; floater  ;        ; 
  .BYTE %00010000 ; $10 ; herb     ; chime    ;        ; 
  .BYTE %00001000 ; $08 ; key      ; tail     ;        ; 
  .BYTE %00000100 ; $04 ; tnt      ; cube     ;        ; 
  .BYTE %00000010 ; $02 ; adamant  ; bottle   ;        ; bottle_alt
  .BYTE %00000001 ; $01 ; slab     ; oxyale   ;        ; lewds_alt




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  TalkRoutines  [$9296 :: 0x392A6]
;;
;;    One of these routines is called each time you talk to a map object.
;;  It determines the action performed by the object (if any) and the text that is
;;  to appear in dialogue on-screen.
;;
;;    Routines are not JSR'd to directly.  They are all accessed via a jump table
;;  See lut_MapObjTalkJumpTbl above.
;;
;;    Before jumping to these routines, the game fills the first 4 bytes of temp
;;  RAM (tmp through tmp+3) with the data for the object being talked to.  See
;;  lut_MapObjTalkData for this data.
;;
;;    Not all of these bytes go used -- sometimes only one is used, but at least one is used
;;  always (except for dummy routines that are never called).  To save space/time, these values
;;  will be referred to by index in brakets in the routines below.  IE:  [0] for the first
;;  byte of data, [1] for the next, then [2], [3].
;;
;;    Most of the time (but not always), [1], [2], and [3] are only used for a dialogue
;;  string ID.  Sometimes, though, they might be used for an object ID as part of a condition
;;  check.  [0] is used for the more dynamic routines that are used for several different
;;  but similar objects... and is always used for a condition check.  Several other of these
;;  routines are (needlessly) hardcoded to be for a specific object.
;;
;;    Some objects hide themselves after you talk to them (like Garland, the fiend orbs, etc,
;;  anything you fight).  This is usually accomplished by loading the object ID into Y and
;;  calling HideThisMapObject, instead of calling the more general HideMapObject routine.
;;  See HideThisMapObject for details on the differences between the two.
;;
;;  IN:   tmp - tmp+3 = map object's data
;;                  X = runtime map object list index (to index 'mapobj') -- only used
;;                        for HideThisMapObject.
;;             dlgsfx = assumed to be zero
;;
;;  OUT:            A = dialogue ID of text to print
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

 ;; King of Coneria  [$9297 :: 0x392A7]
 ;;  [1] if princess kidnapped
 ;;  [2] if princess rescued but bridge not built yet
 ;;  [3] if bridge has been built

Talk_KingConeria:
    LDY #OBJID_PRINCESS_2   ; see if the saved princess is visible (princess has been rescued)
    JSR IsObjectVisible
    BCS :+                  ; if not...
      LDA tmp+1             ;  ... print [1]
      RTS

  : LDA ow_flags            ; otherwise (princess rescued), see if bridge is visible
    AND #BRIDGE_VISIBLE
    BEQ :+                  ; if it is...
      LDA tmp+3             ;  ... print [3]
      RTS
                            ; otherwise (princess rescued, bridge not visible)
  : LDA ow_flags
    ORA #BRIDGE_VISIBLE
    STA ow_flags
    INC dlgsfx              ; play fanfare
    LDA tmp+2               ; print [2]
    RTS

 ;; Garland (regular, not the ToFR version)  [$92B1 :: 0x392C1]
 ;;  [1] always

Talk_Garland:
    LDY #OBJID_GARLAND
    JSR HideThisMapObject   ; hide (kill) the Garland object (this object)
    
    LDA #BTL_GARLAND
    JSR TalkBattle          ; trigger the battle with Garland

    LDA tmp+1               ; and print [1]
    RTS

 ;; Kidnapped Princess (in the ToF)  [$92BE :: 0x392CE]
 ;;  [1] always

Talk_Princess1:
    LDY #OBJID_PRINCESS_1
    JSR HideThisMapObject   ; hide the kidnapped princess (this object)

    LDY #OBJID_PRINCESS_2
    JSR ShowMapObject       ; show (replace with) the rescued princess

    LDA #NORMTELE_SAVEDPRINCESS  ; trigger the teleport back to Coneria Castle
    JSR TalkNormTeleport

    LDA tmp+1               ; and print [1]
    RTS

 ;; Bikke the Pirate  [$92D0 :: 0x392E0]
 ;;  [1] if haven't fought him yet
 ;;  [2] if fought him but haven't taken his ship yet
 ;;  [3] after you have the ship

Talk_Bikke:
    LDY #OBJID_BIKKE
    JSR CheckGameEventFlag  ; check Bikke's event flag to see if we fought him yet
    BCS @AlreadyFought      ; if we already have, skip ahead

      JSR SetGameEventFlag  ; otherwise, set event flag to mark him as fought
      LDA #BTL_BIKKE        ; then start a battle with Bikke (his pirates)
      JSR TalkBattle
      LDA tmp+1             ; and print [1]
      RTS

  @AlreadyFought:        ; if we've already fought bikke...
    LDA ow_flags         ; see if the party has the ship
    AND #SHIP_VISIBLE
    BNE @HaveShip        ; if they do, skip ahead

      LDA ow_flags
      ORA #SHIP_VISIBLE
      STA ow_flags            ; otherwise, give the player the ship
      LDY #OBJID_PIRATETERR_1
      JSR ShowMapObject       ; and show a bunch of scaredy-cat townspeople that the pirates
      LDY #OBJID_PIRATETERR_2 ;  were terrorizing
      JSR ShowMapObject
      LDY #OBJID_PIRATETERR_3
      JSR ShowMapObject

      LDA tmp+2          ; print [2]
      INC dlgsfx         ; and play fanfare
      RTS

  @HaveShip:           ; otherwise, if we have the ship already
    LDA tmp+3          ; just print [3]
    RTS

 ;; Elf Doctor (taking care of the sleeping prince)  [$9301 :: 0x09311]
 ;;  [1] if prince is sleeping and you don't have the herb
 ;;  [2] if prince is sleeping and you DO have the herb
 ;;  [3] once prince is awake

Talk_ElfDoc:
    LDY #OBJID_ELFPRINCE    ; check the elf prince's event flag
    JSR CheckGameEventFlag  ;  it will be clear if the prince is still asleep
    BCC @PrinceAsleep       ; if prince is awake...
      LDA tmp+3             ;  .. then simply print [3]
      RTS

  @PrinceAsleep:          ; if the prince is still asleep
    LDA #HERB             ; check to see if the player has any herb
    JSR ScanForKeyItem
    BNE @HaveHerb         ; if not...
      LDA tmp+1           ; .. then simply print [1]
      RTS

  @HaveHerb:              ; prince is asleep and you have herb!
    LDA keyitems_1
    AND #~$10
    STA keyitems_1        ; take away the herb from the party
    
    JSR SetGameEventFlag  ; set the prince's event flag (wake him up)
    INC dlgsfx            ; play fanfare
    LDA tmp+2             ; and print [2]
    RTS

  ;; Elf Prince  [$931E :: 0x3932E]
  ;;  [3] if sleeping
  ;;  [1] if awake and you don't have the key yet
  ;;  [2] once you have the key

Talk_ElfPrince:
    LDY #OBJID_ELFPRINCE    ; check the prince's event flag to see if he's sleeping
    JSR CheckGameEventFlag
    BCS @Awake              ; if he's still sleeping...
      LDA tmp+3             ;  .. then just print [3]
      RTS

  @Awake:               ; if prince is awake...
    LDA #KEY            ; check to see if the player has the key
    JSR ScanForKeyItem
    BEQ @GiveTheKey     ; if they already do...
      LDA tmp+2         ; .. then just print [2]
      RTS

  @GiveTheKey:          ; otherwise, we need to give them the key
    LDA #KEY            ; give it to them
    JSR KeyItem_Add
    INC dlgsfx          ; play fanfare
    LDA tmp+1           ; and print [1]
    RTS

  ;; Astos  [$9338 :: 0x39348]
  ;;  [1] if you don't have the Crown
  ;;  [2] if you do

Talk_Astos:
    LDA #CROWN             ; see if the player has the crown
    JSR ScanForKeyItem
    BNE @HaveCrown         ; if they don't...
      LDA tmp+1            ; ... simply print [1]
      RTS

  @HaveCrown:              ; otherwise (they have the crown)
    LDA #CRYSTAL           ; give them the Crystal
    JSR KeyItem_Add
    LDY #OBJID_ASTOS
    JSR HideThisMapObject  ; hide (kill) Astos' map object (this object)
    LDA #BTL_ASTOS         ; trigger battle with Astos
    JSR TalkBattle

    INC dlgsfx             ; play fanfare
    LDA tmp+2              ; and print [2]
    RTS


  ;; Nerrick (dwarf who opens the Canal)  [$9352 :: 0x39362]
  ;;  [1] if you don't have the TNT
  ;;  [2] if you do

Talk_Nerrick:
    LDA #TNT               ; check to see if the player has TNT
    JSR ScanForKeyItem
    BNE @HaveTNT           ; if not...
      LDA tmp+1            ; ... simply print [1]
      RTS

  @HaveTNT:
    LDA keyitems_1
    AND #~$04
    STA keyitems_1         ; otherwise, remove the TNT from the party
    
    LDA ow_flags
    AND #~CANAL_VISIBLE    ; remove the canal_visible bit
    STA ow_flags
    LDY #OBJID_NERRICK     ; hide Nerrick (this object)
    JSR HideThisMapObject

    INC dlgsfx             ; play fanfare
    LDA tmp+2              ; and print [2]
    RTS

  ;; Smith (dwarf blacksmith)  [$936C :: 0x3937C]
  ;;  [1] if you don't have the adamant
  ;;  DLGID_DONTBEGREEDY  if you have adamant, but no free weapon slot (HARDCODED!)
  ;;  [2] if you have adamant and a free weapon slot
  ;;  [3] after you've handed over the adamant

Talk_Smith:
    LDY #OBJID_SMITH       ; check Smith's event flag to see if we already made
    JSR CheckGameEventFlag ;  the Xcalbur for the party
    BCC @WantSword         ; if he already made it....
      LDA tmp+3            ; ... then simply print [3]
      RTS

  @WantSword:
    LDA #ADAMANT           ; otherwise check to see if party has the Adamant
    JSR ScanForKeyItem
    BNE @HaveAdamant       ; if not...
      LDA tmp+1            ; ... simply print [1]
      RTS

  @HaveAdamant:            ; otherwise, make the sword!
    JSR Set_Inv_Weapon
    LDA #WPNID_XCALBUR     ; put the XCalbur in the previously found slot
    JSR ADD_ITEM
   
    LDY #OBJID_SMITH       ; set Smith's event flag to mark that we made the sword
    JSR SetGameEventFlag
  
    LDA keyitems_1
    AND #~$02
    STA keyitems_1          ; take the Adamant away from the party
    
    INC dlgsfx             ; play fanfare
    LDA tmp+2              ; and print [2]
    RTS

  ;; Matoya (witch with the herb) [$9398 :: 0x393A8]
  ;;  [1] if prince is asleep and you don't have the crystal
  ;;  [2] if you have the crystal
  ;;  [3] if you have the herb, or if prince is awake

Talk_Matoya:
    LDA #HERB               ; see if they already have the herb
    JSR ScanForKeyItem
    BEQ @NoHerb             ; if not... jump ahead.  If so, do the default

  @Default:
    LDA tmp+3               ; default just prints [3]
    RTS

  @NoHerb:
    LDA #CRYSTAL              ; see if the player has the crystal
    JSR ScanForKeyItem
    BNE @DoExchange           ; if they do, exchange!

     LDY #OBJID_ELFPRINCE     ; otherwise, see if the elf prince is still asleep
     JSR CheckGameEventFlag   ;  by checking his game flag
     BCS @Default             ; if he's awake, revert to default action

      LDA tmp+1               ; otherwise, elf is still asleep.  print [1]
      RTS

  @DoExchange:          ; exchanging Crystal for Herb
    LDA #HERB            ; give player herb
    JSR KeyItem_Add
    
    LDA keyitems_1
    AND #~$10
    STA keyitems_1      ; take away crystal
    
    INC dlgsfx          ; play fanfare
    LDA tmp+2           ; print [2]
    RTS

  ;; Dr. Unne  [$93BA :: 0x393CA]
  ;;  [1] if you don't know Lefeinish, don't have slab
  ;;  [2] if you have Slab, but don't know Lefeinish
  ;;  [3] if you know Lefeinish

Talk_Unne:
    LDY #OBJID_UNNE         ; Check Unne's event flag to see if he taught you
    JSR CheckGameEventFlag  ;   Lefeinish yet
    BCC @NeedToLearn        ; if he already taught you...
      LDA tmp+3             ; .. print [3]
      RTS

  @NeedToLearn:
    LDA #SLAB               ; otherwise, check to see if the party has the Slab
    JSR ScanForKeyItem
    BNE @Teach              ; if they don't...
      LDA tmp+1             ; .. print [1]
      RTS

  @Teach:                   ; if they have the slab... teach them!
    LDA keyitems_1
    AND #~$01
    STA keyitems_1          ; take away the slab

    JSR SetGameEventFlag    ; set Unne's event flag (teach you lefeinish)
    INC dlgsfx              ; fanfare
    LDA tmp+2               ; print [2]
    RTS

  ;; Vampire  [$93D7 :: 0x393E7]
  ;;  [1] always

Talk_Vampire:
    LDY #OBJID_VAMPIRE      ; Kill/Hide the Vampire object (this object)
    JSR HideThisMapObject
    LDA #BTL_VAMPIRE        ; Trigger a battle with the Vampire
    JSR TalkBattle
    LDA tmp+1               ; and print [1]
    RTS

  ;; Sarda (gives you the Rod)  [$93E4 :: 0x393F4]
  ;;  [1] if vampire has been killed but you don't have the Rod yet
  ;;  [2] if you have the Rod or Vampire is still alive

Talk_Sarda:
    LDA #ROD                ; see if the party already has the Rod
    JSR ScanForKeyItem
    BNE @Default            ; if they do, skip to default

    LDY #OBJID_VAMPIRE      ; see if they killed the vampire yet (seems pointless -- can't reach Sarda
    JSR IsObjectVisible     ;   until you kill the vampire)
    BCS @Default            ; if Vampire is still alive, skip to default

    LDA #ROD                ; otherwise, reward them with the Rod
    JSR KeyItem_Add
    INC dlgsfx              ; play fanfare
    LDA tmp+1               ; and print [1]
    RTS

  @Default:
    LDA tmp+2               ; default just prints [2]
    RTS

  ;; Bahamut  [$93FB :: 0x3940B]
  ;;  [1] if haven't been promoted, and don't have the Tail
  ;;  [2] if haven't been promoted, and DO have the Tail
  ;;  [3] once promoted

Talk_Bahamut:
    LDY #OBJID_BAHAMUT      ; Check Bahamut's Event flag (see if he promoted you yet)
    JSR CheckGameEventFlag
    BCC @CheckTail          ; if he has...
      LDA tmp+3             ; ... print [3]
      RTS

  @CheckTail:
    LDA #TAIL               ; he hasn't promoted you yet... so check to see if you have the tail
    JSR ScanForKeyItem
    BNE @ClassChange        ; if you don't...
      LDA tmp+1             ; ... print [1]
      RTS

  @ClassChange:             ; otherwise (have tail), do the class change!
    LDA keyitems_2
    AND #~$08
    STA keyitems_2          ; remove the tail from inventory
    
    JSR SetGameEventFlag    ; set Bahamut's event flag
    JSR DoClassChange       ; do class change
    INC dlgsfx              ; play fanfare
    LDA tmp+2               ; and print [2]
    RTS

  ;; Generic condition check based on object visibility  [$941B :: 0x3942B]
  ;;  [1] if object ID [0] is hidden
  ;;  [2] if it's visible

Talk_ifVisible:
    LDY tmp                 ; check to see if object [0] is visible
    JSR IsObjectVisible
    BCS :+                  ; if it is, print [2]
      LDA tmp+1             ; otherwise, print [1]
      RTS
  : LDA tmp+2
    RTS

  ;; Submarine Engineer (in Onrac, blocking enterance to Sea Shrine)  [$9428 :: 0x39438]
  ;;  [1] if you don't have the Oxyale
  ;;  [2] if you do

Talk_SubEng:
    LDA #OXYALE             ; see if the player has the Oxyale
    JSR ScanForKeyItem
    BNE :+                  ; if they don't...
      LDA tmp+1             ; ...print [1]
      RTS
  : LDY #OBJID_SUBENGINEER  ; otherwise (they do)
    JSR HideThisMapObject   ; hide the sub engineer object (this object)
    LDA tmp+2               ; and print [2]
    RTS

  ;; Waterfall Robot (gives you the cube)  [$9438 :: 0x39448]
  ;;  [1] if you don't have the Cube
  ;;  [2] if you do

Talk_CubeBot:
    LDA #CUBE            ; see if the player has the cube
    JSR ScanForKeyItem
    BEQ :+               ; if they do...
      LDA tmp+2          ; ... print [2]
      RTS
  : LDA #CUBE            ; if they don't, give them the cube
    JSR KeyItem_Add
    LDA tmp+1            ; print [1]
    INC dlgsfx           ; and play fanfare
    RTS

  ;; Rescued Princess (in Coneria Castle)  [$9448 :: 0x39458]
  ;;  [1] if you don't have the Lute
  ;;  [2] if you do

Talk_Princess2:
    LDA #LUTE              ; see if the player has the Lute
    JSR ScanForKeyItem
    BEQ :+
      LDA tmp+2            ; if they do, print [2]
      RTS
  : LDA #LUTE              ; otherwise, give them the lute
    JSR KeyItem_Add
    INC dlgsfx             ; play fanfare
    LDA tmp+1              ; and print [1]
    RTS

  ;; Fairy (trapped in the Bottle)  [$9458 :: 0x39468]
  ;;  [1] if you don't have the Oxyale
  ;;  [2] if you do

Talk_Fairy:
    LDA #OXYALE            ; see if the player has the oxyale
    JSR ScanForKeyItem
    BEQ :+
      LDA tmp+2            ; if they do, print [2]
      RTS
  : LDA #OXYALE            ; otherwise, give them the oxyale
    JSR KeyItem_Add
    INC dlgsfx             ; play fanfare
    LDA tmp+1              ; print [1]
    RTS

  ;; Titan  [$9468 :: 0x39478]
  ;;  [1] if you don't have the Ruby
  ;;  [2] if you do

Talk_Titan:
    LDA #RUBY              ; does the player have the ruby?
    JSR ScanForKeyItem
    BNE :+                 ; if not...
      LDA tmp+1            ; ... simply print [1]
      RTS
  : LDA keyitems_2
    AND #~$80
    STA keyitems_2         ; if they do have it, take it away

    LDY #OBJID_TITAN       ; hide/remove Titan (this object)
    JSR HideThisMapObject
    LDA tmp+2              ; print [2]
    INC dlgsfx             ; and play fanfare
    RTS

  ;; Nameless sage who gives you the canoe  [$947D :: 0x3948D]
  ;;  [1] if you don't have the canoe and Earth Orb has been lit
  ;;  [2] if you have the canoe or if Earth Orb hasn't been lit yet

Talk_CanoeSage:
    LDA #CANOE            ; see if party has canoe
    JSR ScanForKeyItem
    BNE @Default          ; if they do, show default text
      LDA orb_earth       ; if they have the canoe, check to see if they've recovered the Earth Orb
      BEQ @Default        ; if not, show default
        LDA #CANOE        ; otherwise, give them the canoe
        JSR KeyItem_Add
        INC dlgsfx        ; play fanfare
        LDA tmp+1         ; and print [1]
        RTS
  @Default:
    LDA tmp+2             ; for default, just print [2]
    RTS

  ;; Generic eventless object  [$9492 :: 0x394A2]
  ;;  [1] always

Talk_Normal:
    LDA tmp+1             ; uneventful object -- just print [1]
    RTS

  ;; Replacable Object (first 2 of the 3 ToFR Garlands)  [$9495 :: 0x394A5]
  ;;  [1] always --- hide THIS object whose ID is [0], and show object ID [3]

Talk_Replace:
    LDY tmp               ; get object ID from [0]
    JSR HideThisMapObject ; hide that object (this object)
    LDY tmp+3
    JSR ShowMapObject     ; show object ID [3]
    LDA tmp+1             ; and print [1]
    RTS

  ;; Mysterious Sage (in the CoO -- disappears after you talk to him) [$94A2 :: 0x394B2]
  ;;  [1] always --- hide THIS object whose ID is [0]

Talk_OrdealsSage:
    LDY tmp
    JSR HideThisMapObject ; hide object ID [0] (this object)
    LDA tmp+1             ; and print [1]
    RTS

  ;; Generic fight (Final ToFR Garland, Fiends)  [$94AA :: 0x394BA] 
  ;;  [1] always --- hide THIS object whose ID is [0], and initiate battle ID [3]

Talk_Fight:
    LDY tmp
    JSR HideThisMapObject ; hide object [0] (this object)
    LDA tmp+3
    JSR TalkBattle        ; trigger battle ID [3]
    LDA tmp+1             ; and print [1]
    RTS

  ;; Generic condition based on item index  [$94B8 :: 0x394C8]
  ;;  [1] if party contains at least one of item index [0]
  ;;  [2] otherwise (none of that item)

Talk_ifHasItem:
    LDA tmp              ; use [0] as an item index
    JSR ScanForKeyItem   ; see if the player has said item
    BEQ @DontHave        ; if they do have it
      LDA tmp+1          ; print [1]
      RTS
  @DontHave:
    LDA tmp+2            ; otherwise, print [2]
    RTS
    
Talk_ifOrbLit:
    LDY tmp              ; use [0] as an item index
    LDA keyitems, Y      ; see if the player has the orb
    BEQ @DontHave        ; if they do have it
      LDA tmp+1          ; print [1]
      RTS
  @DontHave:
    LDA tmp+2            ; otherwise, print [2]
    RTS    

  ;; Invisible Lady  (infamous invisible lady in Coneria Castle)  [$94C5 :: 0x394D5]
  ;;  [1] if princess not rescued and you don't have the Lute
  ;;  [2] if princess rescued or you do have the Lute

Talk_PrincessRescued:
    LDY #OBJID_PRINCESS_2
    JSR IsObjectVisible  ; see if the princess has been rescued (rescued princess object visible)
    BCS :+               ; if she's not rescued...
        LDA tmp+1        ; print [1]
        RTS
  : LDA tmp+2            ; otherwise print [2]
    RTS


  ;; Condition based on whether or not the bridge has been built [$94D7 :: 0x394E7]
  ;;   this condition is not used by any objects in the game, however it's still in the jump table
  ;;  [1] if bridge is built
  ;;  [2] otherwise

Talk_ifBridgeBuilt:
    LDA ow_flags
    AND #BRIDGE_VISIBLE  ; see if bridge is visible (has been built)
    BEQ :+               ; if it has...
      LDA tmp+1          ; print [1]
      RTS
  : LDA tmp+2            ; otherwise, print [2]
    RTS


  ;; Generic condition based on game event flag [$94E2 :: 0x394F2]
  ;;  [1] if game event flag ID [0] is clear
  ;;  [2] if it's set

Talk_ifEventHappened:
    LDY tmp                 ; use [0] as an event flag index
    JSR CheckGameEventFlag  ;  see if that event flag has been set
    BCS :+                  ; if not...
      LDA tmp+1             ; ... print [1]
      RTS
  : LDA tmp+2               ; otherwise print [2]
    RTS

  ;; Some guard in Coneria town  [$94F0 :: 0x39500]
  ;;  [1] if princess has been saved, but bridge isn't built yet
  ;;  [2] if princess still kidnapped or bridge is built

Talk_GoBridge:
    LDY #OBJID_PRINCESS_2   ; check to see if princess has been rescued
    JSR IsObjectVisible
    BCC :+                  ; if she has...
      LDA ow_flags
      AND #BRIDGE_VISIBLE   ; see if bridge has been built
      BNE :+                ; if not... (princess saved, but bridge not built yet...)
        LDA tmp+1           ;  ... print [1]
        RTS
  : LDA tmp+2               ; otherwise print [2]
    RTS

  ;; The Black Orb  [$9502 :: 0x39512]
  ;;  [1] if all 4 orbs are lit
  ;;  [2] otherwise

Talk_BlackOrb:
    LDA orb_fire            ; see if all orbs have been lit
    AND orb_water
    AND orb_air
    AND orb_earth
    BEQ @NotAllLit          ; if all of them are lit...
      LDY #OBJID_BLACKORB   ; hide the black orb object (this object)
      JSR HideThisMapObject
      INC dlgsfx            ; play TC sound effect  (not fanfare)
      INC dlgsfx
      LDA tmp+1             ; and print [1]
      RTS
  @NotAllLit:
    LDA tmp+2               ; otherwise, (not all orbs lit), print [2]
    RTS

  ;; Conditional Check for 4 Orbs  [$951F :: 0x3952F]
  ;;  [1] if all 4 orbs lit
  ;;  [2] otherwise

Talk_4Orb:
    LDA orb_fire        ; see if all orbs have been lit
    AND orb_water
    AND orb_air
    AND orb_earth
    BEQ :+              ; if they have...
      LDA tmp+1         ; print [1]
      RTS
  : LDA tmp+2           ; otherwise (not all of them lit)
    RTS                 ;  print [2]

 ;; Conditional check for canoe (some lady in Elfland)  [$9533 :: 0x39543]
 ;;  [1] if you have the canoe
 ;;  [2] if you don't

Talk_ifHasCanoe:
    LDA #CANOE          ; see if the player has the canoe
    JSR ScanForKeyItem
    BEQ @NoCanoe        ; if they do...
      LDA tmp+1         ; print [1]
      RTS
  @NoCanoe:             ; otherwise (no canoe), print [2]
    LDA tmp+2
    RTS

 ;; Conditional check for Canal (some dwarves)  [$953E :: 0x3954E]
 ;;  [1] if Canal has been opened up
 ;;  [2] if Canal is still blocked

Talk_ifCanalGone:
    LDA ow_flags
    AND #CANAL_VISIBLE  ; see if the canal has been blown yet
    BNE @CanalBlocked   ; if it has been opened up already
      LDA tmp+1         ;   print [1]
      RTS
  @CanalBlocked:        ; otherwise (still blocked)
    LDA tmp+2           ;   print [2]
    RTS

 ;; Conditional check for key+TNT  (some dwarf?)  [$9549 :: 0x39559]
 ;;  [1] if have key, but not TNT
 ;;  [2] if no key, or have TNT

Talk_ifKeyTNT:
    LDA #KEY            ; check to see if the party has the key
    JSR ScanForKeyItem
    BEQ :+              ; if they do...
      LDA #TNT          ; check to see if they have the TNT
      JSR ScanForKeyItem
      BNE :+            ; if they don't  (key but no TNT)
        LDA tmp+1       ;   print [1]
        RTS
  : LDA tmp+2           ; otherwise, print [2]
    RTS

 ;; Conditional check for Earth Orb and Vampire (people in Melmond) [$9559 :: 0x39569]
 ;;  [1] if Vampire is dead and Earth Orb not lit
 ;;  [2] if Vampire lives, or Earth Orb has been lit

Talk_ifEarthVamp:
    LDY #OBJID_VAMPIRE    ; see if the vampire has been killed yet
    JSR IsObjectVisible
    BCS :+                ; if not...
      LDA orb_earth       ; check to see if player revived earth orb
      BNE :+              ; if not... (Vampire killed, Earth Orb not lit yet)
        LDA tmp+1         ; print [1]
        RTS
  : LDA tmp+2             ; otherwise print [2]
    RTS

 ;; Conditional check for airship  [$956B :: 0x3957B]
 ;;  [1] if you don't have the airship
 ;;  [2] if you do

Talk_ifHasAirship:
    LDA ow_flags
    AND #AIRSHIP_VISIBLE ; see if the party has the airship
    BNE @HaveAirship     ; if they don't....
      LDA tmp+1          ; print [1]
      RTS
  @HaveAirship:
    LDA tmp+2            ; if they do, print [2]
    RTS

 ;; Conditional check for earth/fire orbs [$9576 :: 0x39586]
 ;;  [1] if Earth Orb not lit, or Fire Orb Lit
 ;;  [2] if Earth Orb lit, and Fire Obj not lit

Talk_ifEarthFireOrbs:
    LDA orb_earth        ; see if the Earth Orb has been recovered
    BEQ :+               ; if it has...
      LDA orb_fire       ; check Fire Orb
      BNE :+             ; if it's still dark (Earth lit, but not Fire)
        LDA tmp+1        ; print [1]
        RTS
  : LDA tmp+2            ; otherwise, print [2]
    RTS

 ;; Guy with the Chime (in Lefein)  [$9594 :: 0x395A4]
 ;;  [1] if you speak Lefeinish, and don't have the Chime
 ;;  [2] if you speak Lefeinish, and do have the Chime
 ;;  [3] if you don't speak Lefeinish

Talk_GiveChime:
    LDY #OBJID_UNNE         ; see if Unne event has happened yet (they speak Lefeinish)
    JSR CheckGameEventFlag
    BCS :+                  ; if not (they don't speak it)
      LDA tmp+3             ; ... print [3]
      RTS
  : LDA #CHIME              ; otherwise, check to see if they have the Chime
    JSR ScanForKeyItem
    BEQ :+                  ; if they do...
      LDA tmp+2             ; ... print [2]
      RTS
  : LDA #CHIME              ; otherwise, give them the Chime
    JSR KeyItem_Add
    INC dlgsfx              ; play fanfare
    LDA tmp+1               ; and print [1]
    RTS


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  LUT for Map Object Talk Data  [$95D5 :: 0x395E5]
;;
;;    Each object has 4 bytes of data which is used with the various talk routines
;;  to determine which text to draw when you talk to this object (and possibly other
;;  things).  See TalkRoutines for more details.
;;
;;    There are $D0 objects, each having 4 bytes of data in this table.  Therefore
;;  this table is $340 bytes large.


;; JIGS - this table will need to be doubled, with the fifth byte being $10, to use the second dialogue table.

lut_MapObjTalkData:
.byte $00,$00,$00,$00,$11,$00       ; 00 ; Nothing
.byte $00,$01,$02,$03,$11,$01       ; 01 ; King Coneria
.byte $00,$04,$00,$00,$11,$02       ; 02 ; Garland (Temple of Fiends)
.byte $00,$05,$00,$00,$11,$03       ; 03 ; Kidnapped Princess
.byte $00,$08,$09,$0A,$11,$05       ; 04 ; Bikke
.byte $00,$0B,$0C,$0D,$11,$06       ; 05 ; Elf Doctor
.byte $00,$0E,$0F,$10,$11,$07       ; 06 ; Elf Prince
.byte $00,$11,$12,$00,$11,$08       ; 07 ; Astos
.byte $00,$13,$14,$00,$11,$09       ; 08 ; TNT Dwarf
.byte $00,$15,$16,$18,$11,$0A       ; 09 ; Blacksmith Dwarf
.byte $00,$17,$19,$1A,$11,$0B       ; 0A ; Matoya
.byte $00,$1B,$1C,$18,$11,$0C       ; 0B ; Unne
.byte $00,$1D,$00,$00,$11,$0D       ; 0C ; Vampire
.byte $00,$1E,$18,$00,$11,$0E       ; 0D ; Sarda
.byte $00,$1F,$20,$18,$11,$0F       ; 0E ; Bahamut
.byte $13,$21,$22,$00,$11,$1D       ; 0F ; Talk_ifvis -- same as Black Orb... if... Fairy is visible??
.byte $00,$25,$26,$00,$11,$10       ; 10 ; Submarine Engineer
.byte $00,$27,$28,$00,$11,$11       ; 11 ; Cube Robot
.byte $00,$06,$07,$00,$11,$04       ; 12 ; Rescued Princess
.byte $00,$23,$24,$00,$11,$12       ; 13 ; Fairy
.byte $00,$29,$2A,$00,$11,$13       ; 14 ; Titan
.byte $00,$2B,$2C,$00,$11,$14       ; 15 ; Canoe Sage
.byte $00,$FF,$00,$00,$11,$00       ; 16 ; Earth Plate
.byte $00,$FF,$00,$00,$11,$00       ; 17 ; Temple of Fiends Plate 
.byte $18,$2E,$00,$19,$11,$1A       ; 18 ; Garland (Past 1)
.byte $19,$2F,$00,$1A,$11,$1A       ; 19 ; Garland (Past 2)
.byte $1A,$30,$00,$7B,$11,$1B       ; 1A ; Chaos fight
.byte $1B,$FA,$00,$F3,$11,$1B       ; 1B ; Earth Orb (Lich Fight)
.byte $1C,$FB,$00,$F4,$11,$1B       ; 1C ; Fire Orb (Kary Fight) 
.byte $1D,$FC,$00,$F5,$11,$1B       ; 1D ; Water Orb (Kraken Fight)
.byte $1E,$FD,$00,$F6,$11,$1B       ; 1E ; Wind Orb (Tiamat Fight)
.byte $00,$00,$00,$00,$11,$00       ; 1F ; Unused
.byte $12,$31,$32,$00,$11,$1D       ; 20 ; Talk_ifvis    Coneria castle people
.byte $12,$31,$34,$00,$11,$1D       ; 21 ; Talk_ifvis             unused?
.byte $12,$33,$34,$00,$11,$1D       ; 22 ; Talk_ifvis             v
.byte LUTE,$35,$36,$00,$11,$1E      ; 23 ; Talk_ifitem   (Lute)  v
.byte $12,$33,$34,$00,$11,$1D       ; 24 ; Talk_ifvis             v
.byte $12,$37,$34,$00,$11,$1D       ; 25 ; Talk_ifvis             v
.byte $00,$38,$39,$00,$11,$1D       ; 26 ; Talk_Invis             v
.byte $00,$3A,$34,$00,$11,$24       ; 27 ; Talk_ifbridge          unused?
.byte $12,$33,$34,$00,$11,$1D       ; 28 ; Talk_ifvis             unused?
.byte $12,$3B,$3C,$00,$11,$1D       ; 29 ; Talk_ifvis             ^
.byte $12,$3D,$3E,$00,$11,$1D       ; 2A ; Talk_ifvis             ^ 
.byte $12,$3F,$34,$00,$11,$1D       ; 2B ; Talk_ifvis             ^
.byte KEY,$40,$41,$00,$11,$1E       ; 2C ; Talk_ifitem   (Key)    ^
.byte $12,$33,$32,$00,$11,$1D       ; 2D ; Talk_ifvis             ^
.byte KEY,$42,$41,$00,$11,$1E       ; 2E ; Talk_ifitem   (Key) -- End Coneria castle people
.byte $06,$33,$34,$00,$11,$26       ; 2F ; Talk_ifevent  
.byte $12,$31,$34,$00,$11,$1D       ; 30 ; Talk_ifvis    
.byte $12,$43,$18,$00,$11,$1D       ; 31 ; Talk_ifvis    ; Coneria Townpeople start
.byte $00,$46,$18,$00,$11,$17       ; 32 ; Talk_GoBridge    v
.byte $12,$33,$34,$00,$11,$1D       ; 33 ; Talk_ifvis       v 
.byte $00,$45,$44,$00,$11,$18       ; 34 ; Talk_4Orb        v
.byte $00,$47,$00,$00,$11,$00       ; 35 ; Talk_norm        v
.byte $00,$48,$00,$00,$11,$00       ; 36 ; Talk_norm        ^ 
.byte $12,$33,$49,$00,$11,$1D       ; 37 ; Talk_ifvis       ^
.byte $12,$33,$4A,$00,$11,$1D       ; 38 ; Talk_ifvis       ^
.byte $00,$4B,$00,$00,$11,$00       ; 39 ; Talk_norm     ; End Coneria townpeople
.byte $00,$4D,$4C,$00,$11,$18       ; 3A ; Sky Warrior 1
.byte $00,$4E,$4C,$00,$11,$18       ; 3B ; Sky Warrior 2
.byte $00,$4F,$4C,$00,$11,$18       ; 3C ; Sky Warrior 3
.byte $00,$50,$4C,$00,$11,$18       ; 3D ; Sky Warrior 4
.byte $00,$51,$4C,$00,$11,$18       ; 3E ; Sky Warrior 5
.byte $00,$52,$00,$00,$11,$00       ; 3F ; Scared Pravoka Townsfolk
.byte $00,$53,$00,$00,$11,$00       ; 40 ; Scared Pravoka Townsfolk
.byte $00,$54,$00,$00,$11,$00       ; 41 ; Scared Pravoka Townsfolk
.byte $04,$55,$56,$00,$11,$26       ; 42 ; Talk_ifevent      ^
.byte $04,$57,$58,$00,$11,$26       ; 43 ; Talk_ifevent      ^ 
.byte $06,$59,$5A,$00,$11,$26       ; 44 ; Talk_ifevent    ; Pravoka Townsfolk end
.byte $00,$5B,$00,$00,$11,$00       ; 45 ; Talk_norm       ; Castle Elves start
.byte $06,$5C,$5A,$00,$11,$26       ; 46 ; Talk_ifevent              v
.byte HERB,$5E,$5D,$00,$11,$1E      ; 47 ; Talk_ifitem     (Herb)   v
.byte $00,$42,$00,$00,$11,$00       ; 48 ; Talk_norm                 ^
.byte $06,$59,$5F,$00,$11,$26       ; 49 ; Talk_ifevent              ^
.byte $06,$59,$60,$00,$11,$26       ; 4A ; Talk_ifevent    ; Castle Elves end
.byte KEY,$59,$5A,$00,$11,$1E       ; 4B ; Talk_ifitem     (Key)
.byte $06,$59,$5A,$00,$11,$26       ; 4C ; Talk_ifevent    
.byte $06,$61,$5A,$00,$11,$26       ; 4D ; Talk_ifevent    ; Elfland townsfolk start
.byte $06,$62,$5A,$00,$11,$26       ; 4E ; Talk_ifevent                  v
.byte $06,$63,$64,$00,$11,$26       ; 4F ; Talk_ifevent                  v
.byte $06,$65,$5A,$00,$11,$26       ; 50 ; Talk_ifevent                  v
.byte $06,$66,$67,$00,$11,$26       ; 51 ; Talk_ifevent                  ^
.byte $00,$68,$00,$00,$11,$00       ; 52 ; Talk_norm                     ^
.byte $11,$69,$6B,$00,$11,$27       ; 53 ; Talk_ifcanoe                  ^ 
.byte FLOATER,$6A,$6B,$00,$11,$1E   ; 54 ; Talk_ifitem   (Floater) ; Elfland townsfolk end
.byte $06,$61,$5A,$00,$11,$26       ; 55 ; Talk_ifevent    
.byte $06,$61,$5A,$00,$11,$26       ; 56 ; Talk_ifevent    
.byte $00,$4C,$00,$00,$11,$00       ; 57 ; Talk_norm       (Kee Kee)
.byte $00,$6C,$00,$00,$11,$00       ; 58 ; Talk_norm     ; Dwarf Start   
.byte $00,$6D,$6E,$00,$11,$20       ; 59 ; Talk_ifcanal      v
.byte $00,$6F,$00,$00,$11,$00       ; 5A ; Talk_norm         v
.byte $00,$70,$00,$00,$11,$00       ; 5B ; Talk_norm         v
.byte CRYSTAL,$6F,$71,$00,$11,$1E   ; 5C ; Talk_ifitem   v  (Crystal)
.byte EARTHORB,$73,$72,$00,$11,$1F  ; 5D ; Talk_ifitem  v  (Earth Orb)
.byte $00,$74,$00,$00,$11,$00       ; 5E ; Talk_norm         ^
.byte $00,$75,$6E,$00,$11,$20       ; 5F ; Talk_ifcanal      ^
.byte $00,$76,$77,$00,$11,$21       ; 60 ; Talk_ifkeytnt     ^
.byte $00,$71,$00,$00,$11,$00       ; 61 ; Talk_norm         ^
.byte $00,$75,$6E,$00,$11,$20       ; 62 ; Talk_ifcanal      ^
.byte $00,$77,$00,$00,$11,$00       ; 63 ; Talk_norm     ; Dwarf End  
.byte $00,$78,$00,$00,$11,$00       ; 64 ; Talk_norm     ; broom  
.byte $00,$78,$00,$00,$11,$00       ; 65 ; Talk_norm     ; broom
.byte $00,$78,$00,$00,$11,$00       ; 66 ; Talk_norm     ; broom
.byte $00,$78,$00,$00,$11,$00       ; 67 ; Talk_norm     ; broom  
.byte $0C,$7A,$79,$00,$11,$1D       ; 68 ; Talk_ifvis          ; Melmond townsfolk start
.byte $00,$7B,$00,$00,$11,$00       ; 69 ; Talk_norm                               v
.byte $00,$7C,$7D,$00,$11,$23       ; 6A ; Talk_ifearthvamp                        v
.byte EARTHORB,$7F,$7E,$00,$11,$1F  ; 6B ; Talk_ifitem     (Earth Orb)        v   
.byte $0C,$81,$80,$00,$11,$1D       ; 6C ; Talk_ifvis                              v
.byte $00,$83,$18,$00,$11,$23       ; 6D ; Talk_ifearthvamp                        v
.byte $00,$82,$00,$00,$11,$00       ; 6E ; Talk_norm                               v
.byte $00,$84,$00,$00,$11,$00       ; 6F ; Talk_norm                               ^
.byte EARTHORB,$86,$85,$00,$11,$1F  ; 70 ; Talk_ifitem     (Earth Orb)        ^
.byte $00,$87,$88,$00,$11,$22       ; 71 ; Talk_ifairship                          ^
.byte $00,$89,$00,$00,$11,$00       ; 72 ; Talk_norm                               ^
.byte $0E,$18,$8A,$00,$11,$26       ; 73 ; Talk_ifevent                            ^
.byte EARTHORB,$86,$8B,$00,$11,$1F  ; 74 ; Talk_ifitem     (Earth Orb) Jim! ; Melmond townsfolk end
.byte $00,$18,$00,$00,$11,$00       ; 75 ; Talk_norm       
.byte $00,$18,$00,$00,$11,$00       ; 76 ; Talk_norm       
.byte $00,$8C,$00,$00,$11,$00       ; 77 ; Talk_norm       ; Crescent Lake people start
.byte $00,$96,$8D,$00,$11,$18       ; 78 ; Talk_4Orb                    v
.byte $00,$97,$8E,$00,$11,$18       ; 79 ; Talk_4Orb                    v
.byte $00,$98,$8F,$00,$11,$18       ; 7A ; Talk_4Orb                    v
.byte $00,$99,$90,$00,$11,$18       ; 7B ; Talk_4Orb                    v
.byte $00,$9A,$91,$00,$11,$18       ; 7C ; Talk_4Orb                    v
.byte $00,$9B,$92,$00,$11,$18       ; 7D ; Talk_4Orb                    ^
.byte $00,$9C,$93,$00,$11,$18       ; 7E ; Talk_4Orb                    ^
.byte $00,$9D,$94,$00,$11,$18       ; 7F ; Talk_4Orb 
.byte $00,$95,$9E,$00,$11,$25       ; 80 ; Talk_ifearthfire             ^
.byte CANOE,$9F,$10,$00,$11,$1E     ; 81 ; Talk_ifitem     (Fire Orb) ^ ; JIGS - talks about the Floater, changing to Canoe
.byte $00,$A0,$00,$00,$11,$00       ; 82 ; Talk_norm                    ^
.byte $00,$A1,$00,$00,$11,$00       ; 83 ; Talk_norm       Crescent Lake people end 
.byte $84,$2D,$00,$00,$11,$15       ; 84 ; Talk_CoOGuy     Castle of Ordeals sage
.byte $00,$E2,$00,$00,$11,$00       ; 85 ; Talk_norm    ; Cardia dragons start
.byte $00,$E3,$00,$00,$11,$00       ; 86 ; Talk_norm       v
.byte $00,$E4,$00,$00,$11,$00       ; 87 ; Talk_norm       v
.byte $00,$E5,$00,$00,$11,$00       ; 88 ; Talk_norm       v
.byte $00,$E6,$00,$00,$11,$00       ; 89 ; Talk_norm       v
.byte $00,$E7,$00,$00,$11,$00       ; 8A ; Talk_norm       v
.byte $00,$E8,$00,$00,$11,$00       ; 8B ; Talk_norm       ^
.byte $00,$E9,$00,$00,$11,$00       ; 8C ; Talk_norm       ^
.byte $00,$EA,$00,$00,$11,$00       ; 8D ; Talk_norm       ^ 
.byte $00,$EB,$00,$00,$11,$00       ; 8E ; Talk_norm       ^
.byte $00,$EC,$00,$00,$11,$00       ; 8F ; Talk_norm    ; bahamut's room dragons   
.byte $00,$ED,$00,$00,$11,$00       ; 90 ; Talk_norm    ; bahamut's room dragons   
.byte $00,$EE,$00,$00,$11,$00       ; 91 ; Talk_norm       
.byte $00,$EF,$00,$00,$11,$00       ; 92 ; Talk_norm       
.byte $00,$AE,$00,$00,$11,$00       ; 93 ; Talk_norm    ; Onrac townsfolk start  
.byte SLAB,$A3,$A2,$00,$11,$1E      ; 94 ; Talk_ifitem (Slab) v  Unne's Brother in Onrac
.byte $00,$A4,$00,$00,$11,$00       ; 95 ; Talk_norm           v
.byte $00,$A5,$00,$00,$11,$00       ; 96 ; Talk_norm           v
.byte $00,$A6,$00,$00,$11,$00       ; 97 ; Talk_norm           v
.byte $00,$A7,$00,$00,$11,$00       ; 98 ; Talk_norm           v
.byte $00,$A8,$00,$00,$11,$00       ; 99 ; Talk_norm           v
.byte WATERORB,$AA,$A9,$00,$11,$1F  ; 9A ; Talk_ifitem    ^ (Water Orb) ; JIGS - original was air orb for some reason? Old sage by submarine
.byte $0E,$AB,$AC,$00,$11,$26       ; 9B ; Talk_ifevent        ^ Onrac Dragon before and after class change
.byte $00,$AD,$00,$00,$11,$00       ; 9C ; Talk_norm           ^
.byte $00,$AF,$00,$00,$11,$00       ; 9D ; Talk_norm           ^
.byte $00,$B0,$00,$00,$11,$00       ; 9E ; Talk_norm           ^
.byte $00,$B1,$00,$00,$11,$00       ; 9F ; Talk_norm           ^
.byte $00,$B2,$00,$00,$11,$00       ; A0 ; Talk_norm      ; Onrac townsfolk end 
.byte $00,$B3,$00,$00,$11,$00       ; A1 ; Talk_norm       
.byte $00,$27,$28,$00,$11,$00       ; A2 ; Talk_norm CubeBotBad 
.byte $00,$B4,$00,$00,$11,$00       ; A3 ; Talk_norm     ; mermaids start
.byte $00,$B5,$00,$00,$11,$00       ; A4 ; Talk_norm        v
.byte $00,$B6,$00,$00,$11,$00       ; A5 ; Talk_norm        v
.byte $00,$B7,$00,$00,$11,$00       ; A6 ; Talk_norm        v
.byte $00,$B8,$00,$00,$11,$00       ; A7 ; Talk_norm        v
.byte $00,$B9,$00,$00,$11,$00       ; A8 ; Talk_norm        ^
.byte WATERORB,$BB,$BA,$00,$11,$1F  ; A9 ; Talk_ifitem ^ (Water Orb)
.byte $00,$BC,$00,$00,$11,$00       ; AA ; Talk_norm        ^
.byte $00,$BD,$00,$00,$11,$00       ; AB ; Talk_norm        ^
.byte $00,$BE,$00,$00,$11,$00       ; AC ; Talk_norm     ; end mermaids  
.byte $00,$BF,$00,$00,$11,$00       ; AD ; Talk_norm       
.byte $00,$C0,$00,$00,$11,$00       ; AE ; Talk_norm     ; Gaia townsfolk start  
.byte $0B,$C1,$FE,$00,$11,$26       ; AF ; Talk_ifevent    Gaia guy before v and after learning Leifenish
.byte $00,$C2,$00,$00,$11,$00       ; B0 ; Talk_norm                       v
.byte $00,$C3,$00,$00,$11,$00       ; B1 ; Talk_norm                       v
.byte $00,$C4,$00,$00,$11,$00       ; B2 ; Talk_norm                       v
.byte $00,$C5,$00,$00,$11,$00       ; B3 ; Talk_norm                       v
.byte $00,$C6,$00,$00,$11,$00       ; B4 ; Talk_norm                       v
.byte $00,$C7,$00,$00,$11,$00       ; B5 ; Talk_norm                       ^
.byte $00,$C8,$00,$00,$11,$00       ; B6 ; Talk_norm                       ^
.byte $00,$C9,$00,$00,$11,$00       ; B7 ; Talk_norm                       ^
.byte $00,$CA,$00,$00,$11,$00       ; B8 ; Talk_norm                       ^
.byte $00,$CB,$00,$00,$11,$00       ; B9 ; Talk_norm                       ^
.byte $00,$CC,$00,$00,$11,$00       ; BA ; Talk_norm      ; Gaia townsfolk end 
.byte $00,$CD,$CE,$D0,$11,$16       ; BB ; Talk_Chime     ; Leifen guy what gives the chime
.byte $0B,$D0,$CF,$00,$11,$26       ; BC ; Talk_ifevent   Leifen citizens
.byte $0B,$D0,$D1,$00,$11,$26       ; BD ; Talk_ifevent   Leifen citizens
.byte $0B,$D0,$D2,$00,$11,$26       ; BE ; Talk_ifevent   Leifen citizens
.byte $0B,$D0,$D3,$00,$11,$26       ; BF ; Talk_ifevent   Leifen citizens
.byte $0B,$D0,$D4,$00,$11,$26       ; C0 ; Talk_ifevent   Leifen citizens
.byte $0B,$D0,$D5,$00,$11,$26       ; C1 ; Talk_ifevent   Leifen citizens
.byte $0B,$D0,$D6,$00,$11,$26       ; C2 ; Talk_ifevent   Leifen citizens
.byte $0B,$D0,$D7,$00,$11,$26       ; C3 ; Talk_ifevent   Leifen citizens
.byte $0B,$D0,$D8,$00,$11,$26       ; C4 ; Talk_ifevent   Leifen citizens
.byte $0B,$D0,$D9,$00,$11,$26       ; C5 ; Talk_ifevent   Leifen citizens
.byte $0B,$D0,$DA,$00,$11,$26       ; C6 ; Talk_ifevent   Leifen citizens
.byte $0B,$D0,$DB,$00,$11,$26       ; C7 ; Talk_ifevent   Leifen citizens
.byte $0B,$D0,$DC,$00,$11,$26       ; C8 ; Talk_ifevent   Leifen citizens
.byte $0B,$D0,$DD,$00,$11,$26       ; C9 ; Talk_ifevent   Leifen citizens
.byte $00,$21,$22,$00,$11,$19       ; CA ; Talk_BlackOrb  Black Orb
.byte $00,$D0,$00,$00,$11,$00       ; CB ; Talk_norm      Leifen going Lu...pa? still
.byte $00,$DE,$00,$00,$11,$00       ; CC ; Talk_norm      Robot talking about the Cube being flown off  
.byte $00,$DF,$00,$00,$11,$00       ; CD ; Talk_norm      Transporter requires Cube
.byte $00,$E0,$00,$00,$11,$00       ; CE ; Talk_norm      Robot guy misses his master
.byte $00,$E1,$00,$00,$11,$00       ; CF ; Talk_norm      Window over the world 



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  DoClassChange [$95AE :: 0x395BE]
;;
;;    Performs class change (promotion) on all party members.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


DoClassChange:
    LDA #0
  : TAX    
    LDA ch_class, X       ; simply bump up every party member's class ID number
    ORA #$10               ; to up them to the promoted version of their class
    STA ch_class, X
    LDA ch_sprite, X
    ORA #$10
    STA ch_sprite, X
    TXA
    CLC
    ADC #$40
    BNE :-

    INC dlgflg_reentermap  ; set flag to indicate map needs reentering 
    RTS                    ;   in order to reload party's mapman graphic




























.byte "END OF BANK DIALOGUE"