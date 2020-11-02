.include "Constants.inc"
.include "variables.inc"
.feature force_range

.segment "BANK_0A"

.export DrawMenuString_A
.export DrawMenuString_CharCodes_A
.export lut_ItemNames_Low
.export lut_ItemNames_High
.export lut_Treasure
.export lut_Treasure_2
.export lut_EquipmentNames_Low
.export lut_EquipmentNames_High
.export lut_MagicNames_Low
.export lut_MagicNames_High
.export lut_PriceTable_Low
.export lut_PriceTable_High
.export lut_TreasureTable_Low
.export lut_TreasureTable_High
.export lut_BattleMessages_Low
.export lut_BattleMessages_High
.export lut_EnemyNames_Low
.export lut_EnemyNames_High
.export lut_GoldNames_Low
.export lut_GoldNames_High
.export lut_ItemDescStrings_Low
.export lut_ItemDescStrings_High

.import SwapPRG_L
.import DrawComplexString
.import MultiplyXA
.import LongCall

BANK_THIS = $0A




;; JIGS - moved from Bank B.

lut_BattleMessages_Low:
.byte <BTL_MESSAGE1   
.byte <BTL_MESSAGE2
.byte <BTL_MESSAGE3
.byte <BTL_MESSAGE4
.byte <BTL_MESSAGE5
.byte <BTL_MESSAGE6
.byte <BTL_MESSAGE7
.byte <BTL_MESSAGE8
.byte <BTL_MESSAGE9
.byte <BTL_MESSAGE10
.byte <BTL_MESSAGE11
.byte <BTL_MESSAGE12
.byte <BTL_MESSAGE13
.byte <BTL_MESSAGE14
.byte <BTL_MESSAGE15
.byte <BTL_MESSAGE16
.byte <BTL_MESSAGE17
.byte <BTL_MESSAGE18
.byte <BTL_MESSAGE19
.byte <BTL_MESSAGE20
.byte <BTL_MESSAGE21
.byte <BTL_MESSAGE22
.byte <BTL_MESSAGE23
.byte <BTL_MESSAGE24
.byte <BTL_MESSAGE25
.byte <BTL_MESSAGE26
.byte <BTL_MESSAGE27
.byte <BTL_MESSAGE28
.byte <BTL_MESSAGE29
.byte <BTL_MESSAGE30
.byte <BTL_MESSAGE31
.byte <BTL_MESSAGE32
.byte <BTL_MESSAGE33
.byte <BTL_MESSAGE34
.byte <BTL_MESSAGE35
.byte <BTL_MESSAGE36
.byte <BTL_MESSAGE37
.byte <BTL_MESSAGE38
.byte <BTL_MESSAGE39
.byte <BTL_MESSAGE40
.byte <BTL_MESSAGE41
.byte <BTL_MESSAGE42
.byte <BTL_MESSAGE43
.byte <BTL_MESSAGE44
.byte <BTL_MESSAGE45
.byte <BTL_MESSAGE46
.byte <BTL_MESSAGE47
.byte <BTL_MESSAGE48
.byte <BTL_MESSAGE49
.byte <BTL_MESSAGE50
.byte <BTL_MESSAGE51
.byte <BTL_MESSAGE52
.byte <BTL_MESSAGE53
.byte <BTL_MESSAGE54
.byte <BTL_MESSAGE55
.byte <BTL_MESSAGE56
.byte <BTL_MESSAGE57
.byte <BTL_MESSAGE58
.byte <BTL_MESSAGE59
.byte <BTL_MESSAGE60
.byte <BTL_MESSAGE61
.byte <BTL_MESSAGE62
.byte <BTL_MESSAGE63
.byte <BTL_MESSAGE64
.byte <BTL_MESSAGE65
.byte <BTL_MESSAGE66
.byte <BTL_MESSAGE67
.byte <BTL_MESSAGE68
.byte <BTL_MESSAGE69
.byte <BTL_MESSAGE70
.byte <BTL_MESSAGE71
.byte <BTL_MESSAGE72
.byte <BTL_MESSAGE73
.byte <BTL_MESSAGE74
.byte <BTL_MESSAGE75
.byte <BTL_MESSAGE76
.byte <BTL_MESSAGE77
.byte <BTL_MESSAGE78
.byte <BTL_MESSAGE79
.byte <BTL_MESSAGE80
.byte <BTL_MESSAGE81
.byte <BTL_MESSAGE82
.byte <BTL_MESSAGE83
.byte <BTL_MESSAGE84
.byte <BTL_MESSAGE85
.byte <BTL_MESSAGE86
.byte <BTL_MESSAGE87
.byte <BTL_MESSAGE88
.byte <BTL_MESSAGE89
.byte <BTL_MESSAGE90
.byte <BTL_MESSAGE91
.byte <BTL_MESSAGE92
.byte <BTL_MESSAGE93
.byte <BTL_MESSAGE94
.byte <BTL_MESSAGE95
.byte <BTL_MESSAGE96
.byte <BTL_MESSAGE97
.byte <BTL_MESSAGE98
.byte <BTL_MESSAGE99
.byte <BTL_MESSAGE100
.byte <BTL_MESSAGE101
.byte <BTL_MESSAGE102
.byte <BTL_MESSAGE103
.byte <BTL_MESSAGE104
.byte <BTL_MESSAGE105
.byte <BTL_MESSAGE106
.byte <BTL_MESSAGE107
.byte <BTL_MESSAGE108
.byte <BTL_MESSAGE109
.byte <BTL_MESSAGE110
.byte <BTL_MESSAGE111

lut_BattleMessages_High:
.byte >BTL_MESSAGE1
.byte >BTL_MESSAGE2
.byte >BTL_MESSAGE3
.byte >BTL_MESSAGE4
.byte >BTL_MESSAGE5
.byte >BTL_MESSAGE6
.byte >BTL_MESSAGE7
.byte >BTL_MESSAGE8
.byte >BTL_MESSAGE9
.byte >BTL_MESSAGE10
.byte >BTL_MESSAGE11
.byte >BTL_MESSAGE12
.byte >BTL_MESSAGE13
.byte >BTL_MESSAGE14
.byte >BTL_MESSAGE15
.byte >BTL_MESSAGE16
.byte >BTL_MESSAGE17
.byte >BTL_MESSAGE18
.byte >BTL_MESSAGE19
.byte >BTL_MESSAGE20
.byte >BTL_MESSAGE21
.byte >BTL_MESSAGE22
.byte >BTL_MESSAGE23
.byte >BTL_MESSAGE24
.byte >BTL_MESSAGE25
.byte >BTL_MESSAGE26
.byte >BTL_MESSAGE27
.byte >BTL_MESSAGE28
.byte >BTL_MESSAGE29
.byte >BTL_MESSAGE30
.byte >BTL_MESSAGE31
.byte >BTL_MESSAGE32
.byte >BTL_MESSAGE33
.byte >BTL_MESSAGE34
.byte >BTL_MESSAGE35
.byte >BTL_MESSAGE36
.byte >BTL_MESSAGE37
.byte >BTL_MESSAGE38
.byte >BTL_MESSAGE39
.byte >BTL_MESSAGE40
.byte >BTL_MESSAGE41
.byte >BTL_MESSAGE42
.byte >BTL_MESSAGE43
.byte >BTL_MESSAGE44
.byte >BTL_MESSAGE45
.byte >BTL_MESSAGE46
.byte >BTL_MESSAGE47
.byte >BTL_MESSAGE48
.byte >BTL_MESSAGE49
.byte >BTL_MESSAGE50
.byte >BTL_MESSAGE51
.byte >BTL_MESSAGE52
.byte >BTL_MESSAGE53
.byte >BTL_MESSAGE54
.byte >BTL_MESSAGE55
.byte >BTL_MESSAGE56
.byte >BTL_MESSAGE57
.byte >BTL_MESSAGE58
.byte >BTL_MESSAGE59
.byte >BTL_MESSAGE60
.byte >BTL_MESSAGE61
.byte >BTL_MESSAGE62
.byte >BTL_MESSAGE63
.byte >BTL_MESSAGE64
.byte >BTL_MESSAGE65
.byte >BTL_MESSAGE66
.byte >BTL_MESSAGE67
.byte >BTL_MESSAGE68
.byte >BTL_MESSAGE69
.byte >BTL_MESSAGE70
.byte >BTL_MESSAGE71
.byte >BTL_MESSAGE72
.byte >BTL_MESSAGE73
.byte >BTL_MESSAGE74
.byte >BTL_MESSAGE75
.byte >BTL_MESSAGE76
.byte >BTL_MESSAGE77
.byte >BTL_MESSAGE78
.byte >BTL_MESSAGE79
.byte >BTL_MESSAGE80
.byte >BTL_MESSAGE81
.byte >BTL_MESSAGE82
.byte >BTL_MESSAGE83
.byte >BTL_MESSAGE84
.byte >BTL_MESSAGE85
.byte >BTL_MESSAGE86
.byte >BTL_MESSAGE87
.byte >BTL_MESSAGE88
.byte >BTL_MESSAGE89
.byte >BTL_MESSAGE90
.byte >BTL_MESSAGE91
.byte >BTL_MESSAGE92
.byte >BTL_MESSAGE93
.byte >BTL_MESSAGE94
.byte >BTL_MESSAGE95
.byte >BTL_MESSAGE96
.byte >BTL_MESSAGE97
.byte >BTL_MESSAGE98
.byte >BTL_MESSAGE99
.byte >BTL_MESSAGE100
.byte >BTL_MESSAGE101
.byte >BTL_MESSAGE102
.byte >BTL_MESSAGE103
.byte >BTL_MESSAGE104
.byte >BTL_MESSAGE105
.byte >BTL_MESSAGE106
.byte >BTL_MESSAGE107
.byte >BTL_MESSAGE108
.byte >BTL_MESSAGE109
.byte >BTL_MESSAGE110
.byte >BTL_MESSAGE111

BTL_MESSAGE1:
.byte $91,$99,$FF,$B8,$B3,$C4,$00  ; HP up!
BTL_MESSAGE2:
.byte $8A,$B5,$B0,$B2,$B5,$FF,$B8,$B3,$00   ; Armor up
BTL_MESSAGE3:
.byte $8E,$A4,$B6,$BC,$FF,$B7,$B2,$FF,$A7,$B2,$A7,$AA,$A8,$00 ; Easy to dodge
BTL_MESSAGE4:
.byte $8A,$B6,$AF,$A8,$A8,$B3,$00 ; Asleep
BTL_MESSAGE5:
.byte $8E,$A4,$B6,$BC,$FF,$B7,$B2,$FF,$AB,$AC,$B7,$00 ; Easy to hit
BTL_MESSAGE6:
.byte $9C,$AC,$AA,$AB,$B7,$FF,$B5,$A8,$A6,$B2,$B9,$A8,$B5,$A8,$A7,$00 ; Sight recovered
BTL_MESSAGE7:
.byte $9C,$AC,$AF,$A8,$B1,$A6,$A8,$A7,$00 ; Silenced
BTL_MESSAGE8:
.byte $8D,$A8,$A9,$A8,$B1,$A7,$FF,$AF,$AC,$AA,$AB,$B7,$B1,$AC,$B1,$AA,$00 ; Defend lightning
BTL_MESSAGE9:
.byte $8D,$A4,$B5,$AE,$B1,$A8,$B6,$B6,$00 ; Darkness
BTL_MESSAGE10:
.byte $A0,$A8,$A4,$B3,$B2,$B1,$B6,$FF,$B6,$B7,$B5,$B2,$B1,$AA,$A8,$B5,$00 ; Weapons stronger
BTL_MESSAGE11:
.byte $95,$B2,$B6,$B7,$FF,$AC,$B1,$B7,$A8,$AF,$AF,$AC,$AA,$A8,$B1,$A6,$A8,$00 ; Lost intelligence
BTL_MESSAGE12:
.byte $8D,$A8,$A9,$A8,$B1,$A7,$FF,$A9,$AC,$B5,$A8,$00 ; Defend fire
BTL_MESSAGE13:
.byte $8A,$B7,$B7,$A4,$A6,$AE,$FF,$AB,$A4,$AF,$B7,$A8,$A7,$00 ; Attack halted
BTL_MESSAGE14:
.byte $99,$B2,$AC,$B6,$B2,$B1,$FF,$B1,$A8,$B8,$B7,$B5,$A4,$AF,$AC,$BD,$A8,$A7,$00 ; Poison neutralized
BTL_MESSAGE15:
.byte $8B,$A8,$A6,$A4,$B0,$A8,$FF,$B7,$A8,$B5,$B5,$AC,$A9,$AC,$A8,$A7,$00 ; Became terrified
BTL_MESSAGE16:
.byte $8D,$A8,$A9,$A8,$B1,$A7,$FF,$A6,$B2,$AF,$A7,$00 ; Defend cold
BTL_MESSAGE17:
.byte $8B,$B5,$A8,$A4,$AE,$FF,$B7,$AB,$A8,$FF,$B6,$AC,$AF,$A8,$B1,$A6,$A8,$00 ; Break the silence
BTL_MESSAGE18:
.byte $9A,$B8,$AC,$A6,$AE,$FF,$B6,$AB,$B2,$B7,$00 ; Quick shot
BTL_MESSAGE19:
.byte $8C,$B2,$B1,$A9,$B8,$B6,$A8,$A7,$00 ; Confused
BTL_MESSAGE20:
.byte $99,$B2,$AC,$B6,$B2,$B1,$A8,$A7,$00 ; Poisoned
BTL_MESSAGE21:
.byte $8E,$B5,$A4,$B6,$A8,$A7,$00 ; Erased
BTL_MESSAGE22:
.byte $8F,$A8,$AF,$AF,$FF,$AC,$B1,$B7,$B2,$FF,$A6,$B5,$A4,$A6,$AE,$00 ; Fell into crack
BTL_MESSAGE23:
.byte $99,$A4,$B5,$A4,$AF,$BC,$BD,$A8,$A7,$00 ; Paralyzed
BTL_MESSAGE24:
.byte $91,$99,$FF,$B0,$A4,$BB,$C4,$00 ; HP max!
BTL_MESSAGE25:
.byte $8D,$A8,$A9,$A8,$B1,$A7,$FF,$B0,$A4,$AA,$AC,$A6,$00 ; Defend magic
BTL_MESSAGE26:
.byte $8B,$B5,$B2,$AE,$A8,$B1,$FF,$AC,$B1,$B7,$B2,$FF,$B3,$AC,$A8,$A6,$A8,$B6,$00 ; Broken into pieces
BTL_MESSAGE27:
.byte $A0,$A8,$A4,$B3,$B2,$B1,$FF,$A5,$A8,$A6,$A4,$B0,$A8,$FF,$A8,$B1,$A6,$AB,$A4,$B1,$B7,$A8,$A7,$00 ; Weapon became enchanted
BTL_MESSAGE28:
.byte $8D,$A8,$A9,$A8,$B1,$A7,$FF,$A4,$AF,$AF,$00 ; Defend all
BTL_MESSAGE29:
.byte $8D,$A8,$A9,$A8,$B1,$B6,$A8,$AF,$A8,$B6,$B6,$00 ; Defenseless
BTL_MESSAGE30:
.byte $9D,$AC,$B0,$A8,$FF,$B6,$B7,$B2,$B3,$B3,$A8,$A7,$00 ; Time stopped
BTL_MESSAGE31:
.byte $8E,$BB,$AC,$AF,$A8,$FF,$B7,$B2,$FF,$84,$B7,$AB,$FF,$A7,$AC,$B0,$A8,$B1,$B6,$AC,$B2,$B1,$00 ; Exile to 4th dimension
BTL_MESSAGE32:
.byte $9C,$AF,$A4,$AC,$B1,$C3,$00 ; Slain..
BTL_MESSAGE33:
.byte $92,$B1,$A8,$A9,$A9,$A8,$A6,$B7,$AC,$B9,$A8,$00 ; Ineffective
BTL_MESSAGE34:
.byte $8C,$AB,$A4,$B1,$A6,$A8,$FF,$B7,$B2,$FF,$B6,$B7,$B5,$AC,$AE,$A8,$FF,$A9,$AC,$B5,$B6,$B7,$00 ; Chance to strike first
BTL_MESSAGE35:
.byte $8E,$B1,$A8,$B0,$AC,$A8,$B6,$FF,$B6,$B7,$B5,$AC,$AE,$A8,$FF,$A9,$AC,$B5,$B6,$B7,$00 ; Enemies strike first
;.byte $96,$B2,$B1,$B6,$B7,$A8,$B5,$B6,$FF,$B6,$B7,$B5,$AC,$AE,$A8,$FF,$A9,$AC,$B5,$B6,$B7,$00 ; Monsters strike first
BTL_MESSAGE36:
.byte $8C,$A4,$B1,$BE,$B7,$FF,$B5,$B8,$B1,$00 ; Can't run
BTL_MESSAGE37:
.byte $9B,$B8,$B1,$FF,$A4,$BA,$A4,$BC,$00 ; Run away
BTL_MESSAGE38:
.byte $8C,$AF,$B2,$B6,$A8,$FF,$A6,$A4,$AF,$AF,$C3,$C3,$00 ; Close call....
BTL_MESSAGE39:
.byte $A0,$B2,$AE,$A8,$FF,$B8,$B3,$00 ; Woke up
BTL_MESSAGE40:
.byte $9C,$AF,$A8,$A8,$B3,$AC,$B1,$AA,$00 ; Sleeping
BTL_MESSAGE41:
.byte $8C,$B8,$B5,$A8,$A7,$C4,$00 ; Cured!
BTL_MESSAGE42:
.byte $99,$A4,$B5,$A4,$AF,$BC,$B6,$AC,$B6,$FF,$BA,$B2,$B5,$A8,$FF,$B2,$A9,$A9,$00 ; Paralysis wore off
BTL_MESSAGE43:
.byte $FF,$91,$AC,$B7,$B6,$C4,$00 ; _Hits!
BTL_MESSAGE44:
.byte $8C,$B5,$AC,$B7,$AC,$A6,$A4,$AF,$FF,$AB,$AC,$B7,$C4,$C4,$00 ; Critical hit!!
BTL_MESSAGE45:
.byte $96,$A4,$AA,$AC,$A6,$FF,$A5,$AF,$B2,$A6,$AE,$A8,$A7,$00 ; Magic blocked
BTL_MESSAGE46:
.byte $FF,$8D,$96,$90,$00 ; _DMG
BTL_MESSAGE47:
.byte $9C,$B7,$B2,$B3,$B3,$A8,$A7,$00 ; Stopped
BTL_MESSAGE48:
.byte $95,$A8,$B9,$C0,$FF,$B8,$B3,$C4,$00 ; Lev. up!
BTL_MESSAGE49:
.byte $91,$99,$FF,$B0,$A4,$BB,$00 ; HP max
BTL_MESSAGE50:
.byte $FF,$B3,$B7,$B6,$C0,$00 ; _pts.
BTL_MESSAGE51:
.byte $9C,$B7,$B5,$C0,$00 ; Str.
BTL_MESSAGE52:
.byte $8A,$AA,$AC,$C0,$00 ; Agi.
BTL_MESSAGE53:
.byte $92,$B1,$B7,$C0,$00 ; Int.
BTL_MESSAGE54:
.byte $9F,$AC,$B7,$C0,$00 ; Vit.
BTL_MESSAGE55:
;.byte $95,$B8,$A6,$AE,$00 ; Luck
.byte $9C,$B3,$A8,$A8,$A7,$00 ; Speed
BTL_MESSAGE56:
.byte $FF,$B8,$B3,$00 ;  up
BTL_MESSAGE57:
.byte $96,$99,$FF,$23,$37,$35,$40,$C4,$00  ; MP restored!
BTL_MESSAGE58:
.byte $91,$99,$20,$3B,$FF,$96,$99,$FF,$23,$37,$35,$40,$C4,$00 ; HP and MP restored!
BTL_MESSAGE59:
.byte $FF,$A7,$B2,$BA,$B1,$00 ; down
BTL_MESSAGE60:
.byte $B3,$A8,$B5,$AC,$B6,$AB,$A8,$A7,$00 ; perished
BTL_MESSAGE61:
.byte $8E,$B1,$A8,$B0,$AC,$A8,$B6,$FF,$00 ; Enemies_ ; $96,$B2,$B1,$B6,$B7,$A8,$B5,$B6,$FF,$00 ; Monsters_
BTL_MESSAGE62:
.byte $FF,$B3,$A4,$B5,$B7,$BC,$FF,$00 ; _party_
BTL_MESSAGE63:
.byte $9D,$A8,$B5,$B0,$AC,$B1,$A4,$B7,$A8,$A7,$00 ; Terminated
BTL_MESSAGE64:
.byte $96,$AC,$B6,$B6,$A8,$A7,$C4,$00 ; Missed!
BTL_MESSAGE65:
.byte $FF,$FF,$FF,$FF,$00 ; ____
BTL_MESSAGE66:
.byte $99,$A8,$B7,$5C,$A9,$AC,$40,$00 ; Petrified
BTL_MESSAGE67:
.byte $9D,$1D,$24,$28,$5A,$24,$1D,$4E,$31,$23,$A4,$AE,$B6,$C4,$00 ; The stone shell breaks!
BTL_MESSAGE68:
.byte $8D,$A4,$B5,$AE,$00 ; Dark
BTL_MESSAGE69:
.byte $9C,$B7,$B8,$B1,$00 ; Stun
BTL_MESSAGE70:
.byte $97,$2E,$2C,$51,$B3,$A8,$C4,$00 ; No escape!
BTL_MESSAGE71:
.byte $96,$B8,$B7,$A8,$00 ; Mute
BTL_MESSAGE72:
.byte $91,$99,$FF,$FF,$00 ; HP__
BTL_MESSAGE73:
.byte $8E,$BB,$B3,$FF,$A8,$A4,$B5,$B1,$A8,$A7,$C3,$00 ; Exp earned..
BTL_MESSAGE74:
.byte $92,$B1,$A8,$A9,$A9,$A8,$A6,$B7,$AC,$B9,$A8,$FF,$B1,$B2,$BA,$00 ; Ineffective now
BTL_MESSAGE75:
.byte $9C,$AC,$AF,$A8,$B1,$A6,$A8,$00 ; Silence
BTL_MESSAGE76:
.byte $90,$B2,$FF,$B0,$A4,$A7,$00 ; Go mad
BTL_MESSAGE77:
.byte $99,$B2,$AC,$B6,$B2,$B1,$FF,$B6,$B0,$B2,$AE,$A8,$00 ; Poison smoke
BTL_MESSAGE78:
.byte $97,$B2,$B7,$AB,$AC,$B1,$AA,$FF,$AB,$A4,$B3,$B3,$A8,$B1,$B6,$00  ; Nothing happens
BTL_MESSAGE79:
.byte $9B,$A8,$B9,$AC,$32,$27,$A9,$4D,$B0,$1B,$1D,$31,$5C,$B1,$AE,$C4,$00 ; Revived from the brink!
BTL_MESSAGE80:
.byte $9B,$A8,$AA,$A8,$B1,$A8,$B5,$A4,$B7,$A8,$A7,$FF,$91,$99,$00 ; Regenerated HP ; JIGS - added this
BTL_MESSAGE81:
.byte $8F,$A8,$A8,$AF,$AC,$B1,$AA,$FF,$AF,$B8,$A6,$AE,$BC,$C4,$00  ; Feeling lucky!
BTL_MESSAGE82:
.byte $9C,$AF,$AC,$B3,$B3,$A8,$A7,$FF,$AC,$B1,$B7,$B2,$FF,$AB,$AC,$A7,$AC,$B1,$AA,$C3,$C0,$00 ; Slipped into hiding...
BTL_MESSAGE83:
.byte $8C,$A4,$B1,$BE,$B7,$FF,$AB,$AC,$A7,$A8,$FF,$B1,$B2,$BA,$C4,$00 ; Can't hide now!
BTL_MESSAGE84:
.byte $8A,$AF,$B5,$A8,$A4,$A7,$BC,$FF,$AB,$AC,$A7,$A7,$A8,$B1,$C4,$00 ; Already hidden!
BTL_MESSAGE85:
.byte $FF,$FF,$9B,$B2,$B8,$B1,$A7,$FF,$FF,$00 ; __Round__
BTL_MESSAGE86:
.byte $9D,$1D,$31,$A8,$4E,$FF,$5C,$2A,$1E,$AF,$26,$A7,$AF,$BC,$69,$00 ; The bell rings loudly..
BTL_MESSAGE87:
.byte $9C,$B7,$A8,$A4,$AF,$AC,$B1,$AA,$C3,$C0,$00 ; Stealing...
BTL_MESSAGE88:
.byte $9C,$B7,$B2,$AF,$A8,$FF,$00  ; Stole_
BTL_MESSAGE89:
.byte $B6,$A6,$B5,$B2,$AF,$AF,$00  ; _scroll
BTL_MESSAGE90:
.byte $8B,$A8,$AA,$1F,$1E,$1D,$5F,$1F,$47,$B6,$AF,$46,$AF,$BC,$00 ; Begins healing slowly
BTL_MESSAGE91:
.byte $91,$A4,$32,$B1,$BE,$21,$AA,$B2,$21,$22,$4B,$B0,$35,$A8,$C4,$00 ; Haven't got any more!
BTL_MESSAGE92:
.byte $8C,$22,$B1,$B2,$21,$A6,$B2,$32,$44,$56,$55,$3E,$AF,$A9,$C4,$00 ; Cannot cover yourself!
BTL_MESSAGE93:
.byte $8C,$A4,$34,$1B,$2E,$1C,$A8,$AC,$44,$3E,$B1,$3E,$B6,$00 ; Came to their senses
BTL_MESSAGE94:
.byte $90,$B2,$AF,$A7,$FF,$A9,$B2,$B8,$B1,$A7,$C3,$00 ; Gold found..
BTL_MESSAGE95:
.byte $97,$B2,$B7,$AB,$AC,$B1,$AA,$00 ; Nothing
BTL_MESSAGE96:
.byte $9C,$51,$B1,$B1,$1F,$AA,$69,$00,$3A,$27,$56,$55,$3E,$AF,$A9,$C4,$00 ; Scanning...
BTL_MESSAGE97:
.byte $FF,$38,$B2,$32,$23,$27,$1C,$1A,$39,$B7,$5E,$AE,$C4,$00 ; _covered the attack!
BTL_MESSAGE98:
.byte $8C,$26,$B1,$53,$44,$39,$B7,$5E,$AE,$C4,$00 ; Counter attack!
BTL_MESSAGE99:
.byte $99,$B5,$A4,$BC,$1F,$AA,$69,$00 ; Praying...
BTL_MESSAGE100:
.byte $8F,$B2,$A6,$B8,$B6,$1F,$AA,$69,$00 ; Focusing...
BTL_MESSAGE101:
.byte $9D,$AC,$34,$31,$A8,$AA,$1F,$1E,$28,$43,$AF,$46,$00 ; Time begins to flow
BTL_MESSAGE102:
.byte $8A,$A5,$B6,$35,$62,$27,$1C,$1A,$B6,$B3,$A8,$4E,$C4,$00 ; Absorbed the spell!
BTL_MESSAGE103:
.byte $98,$32,$B5,$BA,$1D,$AF,$34,$27,$A5,$BC,$FF,$00 ; Overwhelmed by_
BTL_MESSAGE104:
.byte $9B,$B6,$B1,$AC,$B8,$00 ; Runic
BTL_MESSAGE105:
.byte $97,$2E,$60,$A4,$B3,$3C,$FF,$A8,$B4,$B8,$AC,$B3,$B3,$40,$C4,$00 ; No weapon equipped!
BTL_MESSAGE106:
.byte $FF,$FF,$FF,$FF,$9B,$A8,$A4,$A7,$BC,$C5,$FF,$FF,$FF,$00 ;   Ready?
BTL_MESSAGE107:
.byte $FF,$FF,$FF,$8C,$AB,$A4,$B5,$AA,$A8,$C5,$C4,$FF,$FF,$00 ;  Charge?!
BTL_MESSAGE108:
.byte $FF,$FF,$9B,$B8,$B1,$FF,$A4,$BA,$A4,$BC,$C5,$FF,$FF,$00 ;  Run away?
BTL_MESSAGE109:
.byte $FF,$FF,$A2,$A8,$B6,$FF,$FF,$FF,$FF,$97,$B2,$00 ; Yes    No
BTL_MESSAGE110:
.byte $FF,$FF,$A2,$A8,$B6,$C4,$FF,$FF,$FF,$97,$B2,$C4,$00 ; Yes!   No!
BTL_MESSAGE111:
.byte $FF,$FF,$A2,$A8,$B6,$C3,$C0,$FF,$FF,$97,$B2,$C3,$C0,$00 ; Yes... No...





;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;  Enemy names [$94E0 :: 0x2D4F0]

lut_EnemyNames_Low:
.byte <ENEMYNAME1
.byte <ENEMYNAME2
.byte <ENEMYNAME3
.byte <ENEMYNAME4
.byte <ENEMYNAME5
.byte <ENEMYNAME6
.byte <ENEMYNAME7
.byte <ENEMYNAME8
.byte <ENEMYNAME9
.byte <ENEMYNAME10
.byte <ENEMYNAME11
.byte <ENEMYNAME12
.byte <ENEMYNAME13
.byte <ENEMYNAME14
.byte <ENEMYNAME15
.byte <ENEMYNAME16
.byte <ENEMYNAME17
.byte <ENEMYNAME18
.byte <ENEMYNAME19
.byte <ENEMYNAME20
.byte <ENEMYNAME21
.byte <ENEMYNAME22
.byte <ENEMYNAME23
.byte <ENEMYNAME24
.byte <ENEMYNAME25
.byte <ENEMYNAME26
.byte <ENEMYNAME27
.byte <ENEMYNAME28
.byte <ENEMYNAME29
.byte <ENEMYNAME30
.byte <ENEMYNAME31
.byte <ENEMYNAME32
.byte <ENEMYNAME33
.byte <ENEMYNAME34
.byte <ENEMYNAME35
.byte <ENEMYNAME36
.byte <ENEMYNAME37
.byte <ENEMYNAME38
.byte <ENEMYNAME39
.byte <ENEMYNAME40
.byte <ENEMYNAME41
.byte <ENEMYNAME42
.byte <ENEMYNAME43
.byte <ENEMYNAME44
.byte <ENEMYNAME45
.byte <ENEMYNAME46
.byte <ENEMYNAME47
.byte <ENEMYNAME48
.byte <ENEMYNAME49
.byte <ENEMYNAME50
.byte <ENEMYNAME51
.byte <ENEMYNAME52
.byte <ENEMYNAME53
.byte <ENEMYNAME54
.byte <ENEMYNAME55
.byte <ENEMYNAME56
.byte <ENEMYNAME57
.byte <ENEMYNAME58
.byte <ENEMYNAME59
.byte <ENEMYNAME60
.byte <ENEMYNAME61
.byte <ENEMYNAME62
.byte <ENEMYNAME63
.byte <ENEMYNAME64
.byte <ENEMYNAME65
.byte <ENEMYNAME66
.byte <ENEMYNAME67
.byte <ENEMYNAME68
.byte <ENEMYNAME69
.byte <ENEMYNAME70
.byte <ENEMYNAME71
.byte <ENEMYNAME72
.byte <ENEMYNAME73
.byte <ENEMYNAME74
.byte <ENEMYNAME75
.byte <ENEMYNAME76
.byte <ENEMYNAME77
.byte <ENEMYNAME78
.byte <ENEMYNAME79
.byte <ENEMYNAME80
.byte <ENEMYNAME81
.byte <ENEMYNAME82
.byte <ENEMYNAME83
.byte <ENEMYNAME84
.byte <ENEMYNAME85
.byte <ENEMYNAME86
.byte <ENEMYNAME87
.byte <ENEMYNAME88
.byte <ENEMYNAME89
.byte <ENEMYNAME90
.byte <ENEMYNAME91
.byte <ENEMYNAME92
.byte <ENEMYNAME93
.byte <ENEMYNAME94
.byte <ENEMYNAME95
.byte <ENEMYNAME96
.byte <ENEMYNAME97
.byte <ENEMYNAME98
.byte <ENEMYNAME99
.byte <ENEMYNAME100
.byte <ENEMYNAME101
.byte <ENEMYNAME102
.byte <ENEMYNAME103
.byte <ENEMYNAME104
.byte <ENEMYNAME105
.byte <ENEMYNAME106
.byte <ENEMYNAME107
.byte <ENEMYNAME108
.byte <ENEMYNAME109
.byte <ENEMYNAME110
.byte <ENEMYNAME111
.byte <ENEMYNAME112
.byte <ENEMYNAME113
.byte <ENEMYNAME114
.byte <ENEMYNAME115
.byte <ENEMYNAME116
.byte <ENEMYNAME117
.byte <ENEMYNAME118
.byte <ENEMYNAME119
.byte <ENEMYNAME120
.byte <ENEMYNAME121
.byte <ENEMYNAME122
.byte <ENEMYNAME123
.byte <ENEMYNAME124
.byte <ENEMYNAME125
.byte <ENEMYNAME126
.byte <ENEMYNAME127
.byte <ENEMYNAME128

lut_EnemyNames_High:
.byte >ENEMYNAME1
.byte >ENEMYNAME2
.byte >ENEMYNAME3
.byte >ENEMYNAME4
.byte >ENEMYNAME5
.byte >ENEMYNAME6
.byte >ENEMYNAME7
.byte >ENEMYNAME8
.byte >ENEMYNAME9
.byte >ENEMYNAME10
.byte >ENEMYNAME11
.byte >ENEMYNAME12
.byte >ENEMYNAME13
.byte >ENEMYNAME14
.byte >ENEMYNAME15
.byte >ENEMYNAME16
.byte >ENEMYNAME17
.byte >ENEMYNAME18
.byte >ENEMYNAME19
.byte >ENEMYNAME20
.byte >ENEMYNAME21
.byte >ENEMYNAME22
.byte >ENEMYNAME23
.byte >ENEMYNAME24
.byte >ENEMYNAME25
.byte >ENEMYNAME26
.byte >ENEMYNAME27
.byte >ENEMYNAME28
.byte >ENEMYNAME29
.byte >ENEMYNAME30
.byte >ENEMYNAME31
.byte >ENEMYNAME32
.byte >ENEMYNAME33
.byte >ENEMYNAME34
.byte >ENEMYNAME35
.byte >ENEMYNAME36
.byte >ENEMYNAME37
.byte >ENEMYNAME38
.byte >ENEMYNAME39
.byte >ENEMYNAME40
.byte >ENEMYNAME41
.byte >ENEMYNAME42
.byte >ENEMYNAME43
.byte >ENEMYNAME44
.byte >ENEMYNAME45
.byte >ENEMYNAME46
.byte >ENEMYNAME47
.byte >ENEMYNAME48
.byte >ENEMYNAME49
.byte >ENEMYNAME50
.byte >ENEMYNAME51
.byte >ENEMYNAME52
.byte >ENEMYNAME53
.byte >ENEMYNAME54
.byte >ENEMYNAME55
.byte >ENEMYNAME56
.byte >ENEMYNAME57
.byte >ENEMYNAME58
.byte >ENEMYNAME59
.byte >ENEMYNAME60
.byte >ENEMYNAME61
.byte >ENEMYNAME62
.byte >ENEMYNAME63
.byte >ENEMYNAME64
.byte >ENEMYNAME65
.byte >ENEMYNAME66
.byte >ENEMYNAME67
.byte >ENEMYNAME68
.byte >ENEMYNAME69
.byte >ENEMYNAME70
.byte >ENEMYNAME71
.byte >ENEMYNAME72
.byte >ENEMYNAME73
.byte >ENEMYNAME74
.byte >ENEMYNAME75
.byte >ENEMYNAME76
.byte >ENEMYNAME77
.byte >ENEMYNAME78
.byte >ENEMYNAME79
.byte >ENEMYNAME80
.byte >ENEMYNAME81
.byte >ENEMYNAME82
.byte >ENEMYNAME83
.byte >ENEMYNAME84
.byte >ENEMYNAME85
.byte >ENEMYNAME86
.byte >ENEMYNAME87
.byte >ENEMYNAME88
.byte >ENEMYNAME89
.byte >ENEMYNAME90
.byte >ENEMYNAME91
.byte >ENEMYNAME92
.byte >ENEMYNAME93
.byte >ENEMYNAME94
.byte >ENEMYNAME95
.byte >ENEMYNAME96
.byte >ENEMYNAME97
.byte >ENEMYNAME98
.byte >ENEMYNAME99
.byte >ENEMYNAME100
.byte >ENEMYNAME101
.byte >ENEMYNAME102
.byte >ENEMYNAME103
.byte >ENEMYNAME104
.byte >ENEMYNAME105
.byte >ENEMYNAME106
.byte >ENEMYNAME107
.byte >ENEMYNAME108
.byte >ENEMYNAME109
.byte >ENEMYNAME110
.byte >ENEMYNAME111
.byte >ENEMYNAME112
.byte >ENEMYNAME113
.byte >ENEMYNAME114
.byte >ENEMYNAME115
.byte >ENEMYNAME116
.byte >ENEMYNAME117
.byte >ENEMYNAME118
.byte >ENEMYNAME119
.byte >ENEMYNAME120
.byte >ENEMYNAME121
.byte >ENEMYNAME122
.byte >ENEMYNAME123
.byte >ENEMYNAME124
.byte >ENEMYNAME125
.byte >ENEMYNAME126
.byte >ENEMYNAME127
.byte >ENEMYNAME128

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
ENEMYNAME121:
.byte $95,$92,$8C,$91,$00                    ; LICH
ENEMYNAME122:
ENEMYNAME123:
.byte $94,$8A,$9B,$A2,$00                    ; KARY
ENEMYNAME124:
ENEMYNAME125:
.byte $94,$9B,$8A,$94,$8E,$97,$00            ; KRAKEN
ENEMYNAME126:
ENEMYNAME127:
.byte $9D,$92,$8A,$96,$8A,$9D,$00            ; TIAMAT
ENEMYNAME128:
.byte $8C,$91,$8A,$98,$9C,$00                ; CHAOS



; But here's all the items and some more!
; When the game looks up an item name, it first gets the pointer--the two byte .word names here--and then looks that up from a table of sorts?
; I sorted all this out so you can rename items and *re-organize* them easier, which FFHackster lacks the ability to do.
; And there was just so much wasted space. So much. Now you can fill it with 8-letter item names.

;  .ALIGN  $100


lut_ItemNames_Low:
.byte <BLANK             ; 00
.byte <NAME_HEAL         ; 01
.byte <NAME_X_HEAL       ; 02
.byte <NAME_ETHER        ; 03
.byte <NAME_ELIXIR       ; 04
.byte <NAME_PURE         ; 05
.byte <NAME_SOFT         ; 06
.byte <NAME_P_DOWN       ; 07
.byte <NAME_TENT         ; 08
.byte <NAME_CABIN        ; 09
.byte <NAME_HOUSE        ; 0A
.byte <NAME_EYEDROPS     ; 0B
.byte <NAME_SMOKEBOMB    ; 0C
.byte <NAME_ALARMCLOCK   ; 0D
.byte <BLANK             ; 0E
.byte <BLANK             ; 0F

;; KeyItems
.byte <NAME_LUTE         ; 10
.byte <NAME_CROWN        ; 11
.byte <NAME_CRYSTAL      ; 12
.byte <NAME_HERB         ; 13
.byte <NAME_KEY          ; 14
.byte <NAME_TNT          ; 15
.byte <NAME_ADAMANT      ; 16
.byte <NAME_SLAB         ; 17
.byte <NAME_RUBY         ; 18
.byte <NAME_ROD          ; 19
.byte <NAME_FLOATER      ; 1A
.byte <NAME_CHIME        ; 1B
.byte <NAME_TAIL         ; 1C
.byte <NAME_CUBE         ; 1D
.byte <NAME_BOTTLE       ; 1E
.byte <NAME_OXYALE       ; 1F
.byte <NAME_CANOE        ; 20
.byte <NAME_LEWDS        ; 21
.byte <BLANK             ; 22
.byte <BLANK             ; 23
.byte <BLANK             ; 24
.byte <BLANK             ; 25
.byte <BLANK             ; 26
.byte <BLANK             ; 27
.byte <BLANK             ; 28
.byte <BLANK             ; 29
.byte <NAME_BOTTLE_ALT   ; 2A
.byte <NAME_LEWDS_ALT    ; 2B
.byte <ORB1              ; 2C
.byte <ORB2              ; 2D
.byte <ORB3              ; 2E
.byte <ORB4              ; 2F

.byte <SKILL1            ; 30
.byte <SKILL2            ; 31
.byte <SKILL3            ; 32
.byte <SKILL4            ; 33
.byte <SKILL5            ; 34
.byte <SKILL6            ; 35
.byte <SKILL7            ; 36
.byte <SKILL8            ; 37
.byte <SKILL9            ; 38
.byte <SKILL10           ; 39
.byte <SKILL11           ; 3A
.byte <SKILL12           ; 3B
.byte <SKILL13           ; 3C
.byte <SKILL14           ; 3D
.byte <SKILL15           ; 3E
.byte <SKILL16           ; 3F
.byte <SKILL17           ; 40
.byte <SKILL18           ; 41
.byte <SKILL19           ; 42
.byte <SKILL20           ; 43
.byte <SKILL21           ; 44
.byte <SKILL22           ; 45
.byte <SKILL23           ; 46
.byte <SKILL24           ; 47
.byte <SKILL25           ; 48
.byte <SKILL26           ; 49
.byte <SKILL27           ; 4A
.byte <SKILL28           ; 4B
.byte <SKILL29           ; 4C
.byte <SKILL30           ; 4D
.byte <SKILL31           ; 4D
.byte <SKILL32           ; 4E

.byte <CLASS1            ; 50
.byte <CLASS2            ; 51
.byte <CLASS3            ; 52
.byte <CLASS4            ; 53
.byte <CLASS5            ; 54
.byte <CLASS6            ; 55
.byte <CLASS7            ; 56
.byte <CLASS8            ; 57
.byte <CLASS9            ; 58
.byte <CLASS10           ; 59
.byte <CLASS11           ; 5A
.byte <CLASS12           ; 5B
.byte <CLASS13           ; 5C
.byte <CLASS14           ; 5D
.byte <CLASS15           ; 5E
.byte <CLASS16           ; 5F
.byte <CLASS17           ; 60 
.byte <CLASS18           ; 61
.byte <CLASS19           ; 62
.byte <CLASS20           ; 63
.byte <CLASS21           ; 64
.byte <CLASS22           ; 65
.byte <CLASS23           ; 66
.byte <CLASS24           ; 67
.byte <CLASS25           ; 68
.byte <CLASS26           ; 69
.byte <CLASS27           ; 6A
.byte <CLASS28           ; 6B
.byte <CLASS29           ; 6C
.byte <CLASS30           ; 6D
.byte <CLASS31           ; 6E
.byte <CLASS32           ; 6F

.byte <CommonString_00   ; 70
.byte <CommonString_01   ; 71
.byte <CommonString_02   ; 72
.byte <CommonString_03   ; 73
.byte <CommonString_04   ; 74
.byte <CommonString_05   ; 75
.byte <CommonString_06   ; 76
.byte <CommonString_07   ; 77
.byte <CommonString_08   ; 78
.byte <CommonString_09   ; 79
.byte <CommonString_0A   ; 7A
.byte <CommonString_0B   ; 7B
.byte <CommonString_0C   ; 7C
.byte <CommonString_0D   ; 7D
.byte <CommonString_0E   ; 7E
.byte <CommonString_0F   ; 7F
.byte <CommonString_10   ; 80
.byte <CommonString_11   ; 81
.byte <CommonString_12   ; 82
.byte <CommonString_13   ; 83
.byte <CommonString_14   ; 84
.byte <CommonString_15   ; 85
.byte <CommonString_16   ; 86
.byte <CommonString_17   ; 87
.byte <CommonString_18   ; 88
.byte <CommonString_19   ; 89
.byte <CommonString_1A   ; 8A
.byte <CommonString_1B   ; 8B
.byte <CommonString_1C   ; 8C
.byte <CommonString_1D   ; 8D
.byte <CommonString_1E   ; 8E
.byte <CommonString_1F   ; 8F
.byte <CommonString_20   ; 90
.byte <CommonString_21   ; 91
.byte <CommonString_22   ; 92
.byte <CommonString_23   ; 93
.byte <CommonString_24   ; 94
.byte <CommonString_25   ; 95
.byte <CommonString_26   ; 96
.byte <CommonString_27   ; 97
.byte <CommonString_28   ; 98
.byte <CommonString_29   ; 99
.byte <CommonString_2A   ; 9A
.byte <CommonString_2B   ; 9B
.byte <CommonString_2C   ; 9C
.byte <CommonString_2D   ; 9D
.byte <CommonString_2E   ; 9E
.byte <CommonString_2F   ; 9F
.byte <CommonString_30   ; A0
.byte <CommonString_31   ; A1
.byte <CommonString_32   ; A2
.byte <CommonString_33   ; A3
.byte <CommonString_34   ; A4
.byte <CommonString_35   ; A5
.byte <CommonString_36   ; A6
.byte <CommonString_37   ; A7
.byte <CommonString_38   ; A8
.byte <CommonString_39   ; A9
.byte <CommonString_3A   ; AA
.byte <CommonString_3B   ; AB
.byte <CommonString_3C   ; AC
.byte <CommonString_3D   ; AD
.byte <CommonString_3E   ; AE
.byte <CommonString_3F   ; AF

lut_ItemNames_High:
.byte >BLANK             ; 00
.byte >NAME_HEAL         ; 01
.byte >NAME_X_HEAL       ; 02
.byte >NAME_ETHER        ; 03
.byte >NAME_ELIXIR       ; 04
.byte >NAME_PURE         ; 05
.byte >NAME_SOFT         ; 06
.byte >NAME_P_DOWN       ; 07
.byte >NAME_TENT         ; 08
.byte >NAME_CABIN        ; 09
.byte >NAME_HOUSE        ; 0A
.byte >NAME_EYEDROPS     ; 0B
.byte >NAME_SMOKEBOMB    ; 0C
.byte >NAME_ALARMCLOCK   ; 0D
.byte >BLANK             ; 0E
.byte >BLANK             ; 0F

;; KeyItems
.byte >NAME_LUTE         ; 10
.byte >NAME_CROWN        ; 11
.byte >NAME_CRYSTAL      ; 12
.byte >NAME_HERB         ; 13
.byte >NAME_KEY          ; 14
.byte >NAME_TNT          ; 15
.byte >NAME_ADAMANT      ; 16
.byte >NAME_SLAB         ; 17
.byte >NAME_RUBY         ; 18
.byte >NAME_ROD          ; 19
.byte >NAME_FLOATER      ; 1A
.byte >NAME_CHIME        ; 1B
.byte >NAME_TAIL         ; 1C
.byte >NAME_CUBE         ; 1D
.byte >NAME_BOTTLE       ; 1E
.byte >NAME_OXYALE       ; 1F
.byte >NAME_CANOE        ; 20
.byte >NAME_LEWDS        ; 21
.byte >BLANK             ; 22
.byte >BLANK             ; 23
.byte >BLANK             ; 24
.byte >BLANK             ; 25
.byte >BLANK             ; 26
.byte >BLANK             ; 27
.byte >BLANK             ; 28
.byte >BLANK             ; 29
.byte >NAME_BOTTLE_ALT   ; 2A
.byte >NAME_LEWDS_ALT    ; 2B
.byte >ORB1              ; 2C
.byte >ORB2              ; 2D
.byte >ORB3              ; 2E
.byte >ORB4              ; 2F

.byte >SKILL1            ; 30
.byte >SKILL2            ; 31
.byte >SKILL3            ; 32
.byte >SKILL4            ; 33
.byte >SKILL5            ; 34
.byte >SKILL6            ; 35
.byte >SKILL7            ; 36
.byte >SKILL8            ; 37
.byte >SKILL9            ; 38
.byte >SKILL10           ; 39
.byte >SKILL11           ; 3A
.byte >SKILL12           ; 3B
.byte >SKILL13           ; 3C
.byte >SKILL14           ; 3D
.byte >SKILL15           ; 3E
.byte >SKILL16           ; 3F
.byte >SKILL17           ; 40
.byte >SKILL18           ; 41
.byte >SKILL19           ; 42
.byte >SKILL20           ; 43
.byte >SKILL21           ; 44
.byte >SKILL22           ; 45
.byte >SKILL23           ; 46
.byte >SKILL24           ; 47
.byte >SKILL25           ; 48
.byte >SKILL26           ; 49
.byte >SKILL27           ; 4A
.byte >SKILL28           ; 4B
.byte >SKILL29           ; 4C
.byte >SKILL30           ; 4D
.byte >SKILL31           ; 4D
.byte >SKILL32           ; 4E

.byte >CLASS1            ; 50
.byte >CLASS2            ; 51
.byte >CLASS3            ; 52
.byte >CLASS4            ; 53
.byte >CLASS5            ; 54
.byte >CLASS6            ; 55
.byte >CLASS7            ; 56
.byte >CLASS8            ; 57
.byte >CLASS9            ; 58
.byte >CLASS10           ; 59
.byte >CLASS11           ; 5A
.byte >CLASS12           ; 5B
.byte >CLASS13           ; 5C
.byte >CLASS14           ; 5D
.byte >CLASS15           ; 5E
.byte >CLASS16           ; 5F
.byte >CLASS17           ; 60 
.byte >CLASS18           ; 61
.byte >CLASS19           ; 62
.byte >CLASS20           ; 63
.byte >CLASS21           ; 64
.byte >CLASS22           ; 65
.byte >CLASS23           ; 66
.byte >CLASS24           ; 67
.byte >CLASS25           ; 68
.byte >CLASS26           ; 69
.byte >CLASS27           ; 6A
.byte >CLASS28           ; 6B
.byte >CLASS29           ; 6C
.byte >CLASS30           ; 6D
.byte >CLASS31           ; 6E
.byte >CLASS32           ; 6F

.byte >CommonString_00   ; 70
.byte >CommonString_01   ; 71
.byte >CommonString_02   ; 72
.byte >CommonString_03   ; 73
.byte >CommonString_04   ; 74
.byte >CommonString_05   ; 75
.byte >CommonString_06   ; 76
.byte >CommonString_07   ; 77
.byte >CommonString_08   ; 78
.byte >CommonString_09   ; 79
.byte >CommonString_0A   ; 7A
.byte >CommonString_0B   ; 7B
.byte >CommonString_0C   ; 7C
.byte >CommonString_0D   ; 7D
.byte >CommonString_0E   ; 7E
.byte >CommonString_0F   ; 7F
.byte >CommonString_10   ; 80
.byte >CommonString_11   ; 81
.byte >CommonString_12   ; 82
.byte >CommonString_13   ; 83
.byte >CommonString_14   ; 84
.byte >CommonString_15   ; 85
.byte >CommonString_16   ; 86
.byte >CommonString_17   ; 87
.byte >CommonString_18   ; 88
.byte >CommonString_19   ; 89
.byte >CommonString_1A   ; 8A
.byte >CommonString_1B   ; 8B
.byte >CommonString_1C   ; 8C
.byte >CommonString_1D   ; 8D
.byte >CommonString_1E   ; 8E
.byte >CommonString_1F   ; 8F
.byte >CommonString_20   ; 90
.byte >CommonString_21   ; 91
.byte >CommonString_22   ; 92
.byte >CommonString_23   ; 93
.byte >CommonString_24   ; 94
.byte >CommonString_25   ; 95
.byte >CommonString_26   ; 96
.byte >CommonString_27   ; 97
.byte >CommonString_28   ; 98
.byte >CommonString_29   ; 99
.byte >CommonString_2A   ; 9A
.byte >CommonString_2B   ; 9B
.byte >CommonString_2C   ; 9C
.byte >CommonString_2D   ; 9D
.byte >CommonString_2E   ; 9E
.byte >CommonString_2F   ; 9F
.byte >CommonString_30   ; A0
.byte >CommonString_31   ; A1
.byte >CommonString_32   ; A2
.byte >CommonString_33   ; A3
.byte >CommonString_34   ; A4
.byte >CommonString_35   ; A5
.byte >CommonString_36   ; A6
.byte >CommonString_37   ; A7
.byte >CommonString_38   ; A8
.byte >CommonString_39   ; A9
.byte >CommonString_3A   ; AA
.byte >CommonString_3B   ; AB
.byte >CommonString_3C   ; AC
.byte >CommonString_3D   ; AD
.byte >CommonString_3E   ; AE
.byte >CommonString_3F   ; AF



;; ITEM NAMES
;; For items with a quantity, make spaces so they're 6 letters long.

NAME_HEAL:
.byte $91,$A8,$A4,$AF,$FF,$FF,$FF,$E1,$00 ; Heal___& (E1 is the potion icon)
NAME_X_HEAL:
.byte $A1,$C2,$91,$A8,$A4,$AF,$FF,$E1,$00 ; X-Heal_&
NAME_ETHER:
.byte $8E,$B7,$AB,$A8,$B5,$FF,$FF,$E1,$00 ; Ether__&
NAME_ELIXIR:
.byte $8E,$AF,$AC,$BB,$AC,$B5,$FF,$E1,$00 ; Elixir_&
NAME_PURE:
.byte $99,$B8,$B5,$A8,$FF,$FF,$FF,$E1,$00 ; Pure___&
NAME_SOFT:
.byte $9C,$B2,$A9,$B7,$FF,$FF,$FF,$E1,$00 ; Soft___&
NAME_P_DOWN:
.byte $99,$AB,$B2,$A8,$B1,$AC,$BB,$E2,$00 ; PhoenixF
NAME_TENT:
.byte $9D,$A8,$B1,$B7,$FF,$FF,$FF,$FF,$00 ; Tent____
NAME_CABIN:
.byte $8C,$A4,$A5,$AC,$B1,$FF,$FF,$FF,$00 ; Cabin___
NAME_HOUSE:
.byte $91,$B2,$B8,$B6,$A8,$FF,$FF,$FF,$00 ; House___
NAME_EYEDROPS:
.byte $8E,$BC,$A8,$A7,$B5,$B2,$B3,$B6,$00 ; Eyedrops
NAME_SMOKEBOMB:
.byte $9C,$B0,$B2,$AE,$A8,$FF,$FF,$E3,$00 ; Smoke__Q
NAME_ALARMCLOCK:
.byte $8A,$AF,$A4,$B5,$B0,$FF,$FF,$EA,$00 ; Alarm__(clock)


ORB1: ; orbs
ORB2: ; Orbs are not listed on the item screen... but they could be? Maybe?
ORB3:
ORB4:
.byte $FF
BLANK:
.byte $00


;; KEY ITEMS

;; since these are NOT drawn by doing ComplexString stuff, they cannot use special control codes

NAME_LUTE:
.byte $95,$B8,$B7,$A8,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF     ; LUTE
NAME_CROWN:
.byte $8C,$B5,$B2,$BA,$B1,$FF,$FF,$FF,$FF,$FF,$FF,$FF     ; CROWN
NAME_CRYSTAL:
.byte $8C,$B5,$BC,$B6,$B7,$A4,$AF,$FF,$8E,$BC,$A8,$FF     ; CRYSTAL
NAME_HERB:
.byte $91,$A8,$B5,$A5,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF     ; HERB
NAME_KEY:
.byte $96,$BC,$B6,$B7,$AC,$A6,$FF,$94,$A8,$BC,$FF,$FF     ; KEY
NAME_TNT:
.byte $9D,$97,$9D,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF     ; TNT
NAME_ADAMANT:
.byte $8A,$A7,$A4,$B0,$A4,$B1,$B7,$AC,$B1,$A8,$FF,$FF     ; ADAMANT
NAME_SLAB:                                                
.byte $9B,$B2,$B6,$A8,$B7,$B7,$A4,$FF,$9C,$AF,$A4,$A5     ; SLAB
NAME_RUBY:                                                
.byte $9C,$B7,$A4,$B5,$FF,$9B,$B8,$A5,$BC,$FF,$FF,$FF     ; RUBY
NAME_ROD:                                                 
.byte $8E,$A4,$B5,$B7,$AB,$FF,$9B,$B2,$A7,$FF,$FF,$FF     ; ROD
NAME_FLOATER:                                             
.byte $95,$A8,$B9,$AC,$B6,$B7,$B2,$B1,$A8,$FF,$FF,$FF     ; FLOATER
NAME_CHIME:                                               
.byte $8C,$AB,$AC,$B0,$A8,$FF,$FF,$FF,$FF,$FF,$FF,$FF     ; CHIME
NAME_TAIL:                                                
.byte $9B,$A4,$B7,$BE,$B6,$FF,$9D,$A4,$AC,$AF,$FF,$FF     ; TAIL
NAME_CUBE:                                                
.byte $A0,$A4,$B5,$B3,$FF,$8C,$B8,$A5,$A8,$FF,$FF,$FF     ; CUBE
NAME_BOTTLE:                                              
.byte $8B,$B2,$B7,$B7,$AF,$A8,$FF,$FF,$FF,$FF,$FF,$FF     ; BOTTLE
NAME_BOTTLE_ALT:                                          
.byte $8B,$B2,$B7,$B7,$AF,$A8,$00                         ; BOTTLE      ; drawn in shops, so does use control codes
NAME_OXYALE:                                              
.byte $98,$BB,$BC,$A4,$AF,$A8,$FF,$FF,$FF,$FF,$FF,$FF     ; OXYALE
NAME_CANOE:                                               
.byte $8C,$A4,$B1,$B2,$A8,$FF,$FF,$FF,$FF,$FF,$FF,$FF     ; CANOE
NAME_LEWDS:                                               
.byte $95,$A8,$BA,$A7,$FF,$9D,$A8,$BB,$B7,$B6,$FF,$FF     ; Lewd Texts
NAME_LEWDS_ALT:
.byte $C5,$C5,$C5,$FF,$8B,$B2,$B2,$AE,$00                 ; ??? Book    ; drawn in shops, so does use control codes

SKILL1:
.byte $9B,$B8,$B6,$AB,$FF,$00    ; Rush
SKILL2:
.byte $9C,$B7,$A8,$A4,$AF,$00    ; Steal
SKILL3:
.byte $99,$A4,$B5,$B5,$BC,$00    ; Parry
SKILL4:
.byte $9B,$B8,$B1,$AC,$A6,$00    ; Runic
SKILL5:
.byte $99,$B5,$A4,$BC,$FF,$00    ; Pray
SKILL6:
.byte $8F,$B2,$A6,$B8,$B6,$00    ; Focus
SKILL7:
.byte $8C,$B2,$B9,$A8,$B5,$00    ; Cover
SKILL8: 
.byte $9C,$A6,$A4,$B1,$FF,$00    ; Scan
SKILL9: 
.byte $FF,$FF,$FF,$FF,$FF,$00    ; _____  
SKILL10:
.byte $FF,$FF,$FF,$FF,$FF,$00    ; _____  
SKILL11:
.byte $FF,$FF,$FF,$FF,$FF,$00    ; _____  
SKILL12:
.byte $FF,$FF,$FF,$FF,$FF,$00    ; _____  
SKILL13:
.byte $FF,$FF,$FF,$FF,$FF,$00    ; _____  
SKILL14:
.byte $FF,$FF,$FF,$FF,$FF,$00    ; _____  
SKILL15:
.byte $FF,$FF,$FF,$FF,$FF,$00    ; _____  
SKILL16:
.byte $FF,$FF,$FF,$FF,$FF,$00    ; _____  
SKILL17:
.byte $FF,$FF,$FF,$FF,$FF,$00    ; _____  
SKILL18:
.byte $FF,$FF,$FF,$FF,$FF,$00    ; _____  
SKILL19:
.byte $FF,$FF,$FF,$FF,$FF,$00    ; _____  
SKILL20:
.byte $FF,$FF,$FF,$FF,$FF,$00    ; _____  
SKILL21:
.byte $FF,$FF,$FF,$FF,$FF,$00    ; _____  
SKILL22:
.byte $FF,$FF,$FF,$FF,$FF,$00    ; _____  
SKILL23:
.byte $FF,$FF,$FF,$FF,$FF,$00    ; _____  
SKILL24:
.byte $FF,$FF,$FF,$FF,$FF,$00    ; _____  
SKILL25:
.byte $FF,$FF,$FF,$FF,$FF,$00    ; _____  
SKILL26:
.byte $FF,$FF,$FF,$FF,$FF,$00    ; _____  
SKILL27:
.byte $FF,$FF,$FF,$FF,$FF,$00    ; _____  
SKILL28:
.byte $FF,$FF,$FF,$FF,$FF,$00    ; _____  
SKILL29:
.byte $FF,$FF,$FF,$FF,$FF,$00    ; _____  
SKILL30:
.byte $FF,$FF,$FF,$FF,$FF,$00    ; _____  
SKILL31:
.byte $FF,$FF,$FF,$FF,$FF,$00    ; _____  
SKILL32:
.byte $FF,$FF,$FF,$FF,$FF,$00    ; _____  

;;CLASS NAMES
CLASS1:
.byte $8F,$92,$90,$91,$9D,$8E,$9B,$00 ; FIGHTER
CLASS2:
.byte $9D,$91,$92,$8E,$8F,$FF,$FF,$00 ; THIEF__
CLASS3:
.byte $8B,$AF,$C0,$8B,$8E,$95,$9D,$00 ; Bl.BELT
CLASS4:
.byte $9B,$A8,$A7,$96,$8A,$90,$8E,$00 ; RedMAGE
CLASS5:
.byte $A0,$AB,$C0,$96,$8A,$90,$8E,$00 ; Wh.MAGE
CLASS6:
.byte $8B,$AF,$C0,$96,$8A,$90,$8E,$00 ; Bl.MAGE
CLASS7:
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$00 ; _______  
CLASS8:
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$00 ; _______  
CLASS9:
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$00 ; _______  
CLASS10:
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$00 ; _______  
CLASS11:
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$00 ; _______  
CLASS12:
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$00 ; _______  
CLASS13:
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$00 ; _______  
CLASS14:
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$00 ; _______  
CLASS15:
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$00 ; _______  
CLASS16:
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$00 ; _______  
CLASS17:
.byte $94,$97,$92,$90,$91,$9D,$FF,$00 ; KNIGHT_
CLASS18:
.byte $97,$92,$97,$93,$8A,$FF,$FF,$00 ; NINJA__
CLASS19:
.byte $96,$8A,$9C,$9D,$8E,$9B,$FF,$00 ; MASTER_
CLASS20:
.byte $9B,$A8,$A7,$A0,$AC,$BD,$FF,$00 ; RedWiz_
CLASS21:
.byte $A0,$AB,$C0,$A0,$AC,$BD,$FF,$00 ; Wh.Wiz_
CLASS22:
.byte $8B,$AF,$C0,$A0,$AC,$BD,$FF,$00 ; Bl.Wiz_
CLASS23:
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$00 ; _______  
CLASS24:
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$00 ; _______  
CLASS25:
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$00 ; _______  
CLASS26:
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$00 ; _______  
CLASS27:
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$00 ; _______  
CLASS28:
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$00 ; _______  
CLASS29:
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$00 ; _______  
CLASS30:
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$00 ; _______  
CLASS31:
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$00 ; _______  
CLASS32:
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$00 ; _______  


CommonString_00:
.byte $FF,$95,$AC,$AA,$AB,$B7,$AF,$4B,$23,$A6,$B2,$32,$44,$00         ; _Lightly recover |
CommonString_01:
.byte $9C,$B7,$4D,$2A,$AF,$4B,$23,$A6,$B2,$32,$44,$00                 ; Strongly recover_|
CommonString_02:
.byte $FF,$90,$23,$39,$AF,$4B,$23,$A6,$B2,$32,$44,$00                 ; _Greatly recover_|
CommonString_03:
.byte $FF,$9B,$A8,$A6,$B2,$32,$44,$B3,$2F,$B7,$BC,$BE,$1E,$00         ; _Recover party's_|
CommonString_04:
.byte $FF,$FF,$9B,$A8,$A6,$B2,$32,$44,$A9,$4D,$B0,$09,$03,$00         ; __Recover from___|
CommonString_05:
.byte $FF,$95,$AC,$AA,$AB,$B7,$AF,$4B,$A7,$A4,$B0,$A4,$66,$FF,$FF,$00 ; _Lightly damage__|
CommonString_06:
.byte $FF,$9C,$B7,$4D,$2A,$AF,$4B,$A7,$A4,$B0,$A4,$66,$FF,$00         ; _Strongly damage_|
CommonString_07:
.byte $FF,$91,$2B,$B9,$61,$4B,$A7,$A4,$B0,$A4,$66,$FF,$FF,$00         ; _Heavily damage__|
CommonString_08:
.byte $96,$3F,$B6,$AC,$32,$AF,$4B,$A7,$A4,$B0,$A4,$66,$FF,$00         ; Massively damage_|
CommonString_09:
.byte $09,$03,$36,$5A,$FF,$3A,$A8,$B0,$BC,$09,$04,$00                 ; ____one enemy____|
CommonString_0A:
.byte $99,$4D,$53,$A6,$21,$1C,$1A,$B3,$2F,$B7,$BC,$00                 ; Protect the party|
CommonString_0B:
.byte $9B,$A8,$B7,$55,$29,$1C,$1A,$B3,$2F,$B7,$BC,$FF,$00             ; Return the party_|
CommonString_0C:
.byte $FF,$4F,$2F,$B7,$4B,$34,$B0,$62,$B5,$C0,$FF,$FF,$00             ; __party member.__|
CommonString_0D:
.byte $FF,$FF,$9C,$68,$AA,$AB,$21,$A6,$41,$B1,$48,$FF,$FF,$00         ; __Slight chance__|
CommonString_0E:
.byte $FF,$90,$23,$39,$25,$38,$41,$B1,$48,$FF,$FF,$00                 ; _Greater chance__|
CommonString_0F:
.byte $09,$03,$36,$5A,$FF,$3A,$A8,$B0,$BC,$00                         ; ____one enemy    |
CommonString_10:
.byte $FF,$FF,$20,$4E,$FF,$3A,$A8,$B0,$AC,$2C,$00                     ; ___all enemies   |
CommonString_11:
.byte $FF,$B8,$3B,$2B,$27,$3A,$A8,$B0,$AC,$2C,$FF,$FF,$00             ; _undead enemies__|
CommonString_12:
.byte $33,$1D,$29,$91,$99,$2D,$1E,$AF,$46,$C0,$FF,$00                 ; _when HP is low._|
CommonString_13:
.byte $FF,$FF,$91,$99,$36,$32,$44,$57,$34,$C0,$FF,$FF,$00             ; __HP over time.__|
CommonString_14:
.byte $09,$03,$91,$99,$43,$35,$36,$5A,$09,$04,$00                     ; ___HP for one____|
CommonString_15:
.byte $09,$03,$33,$5B,$AB,$43,$AC,$23,$C0,$09,$03,$00                 ; ____with fire.___|
CommonString_16:
.byte $33,$5B,$AB,$65,$AC,$AA,$AB,$B7,$B1,$1F,$AA,$C0,$FF,$00         ; _with lightning._|
CommonString_17:
.byte $09,$03,$33,$5B,$AB,$2D,$48,$C0,$09,$04,$00                     ; ____with ice.____|
CommonString_18:
.byte $33,$5B,$AB,$59,$B2,$AF,$4B,$B0,$A4,$AA,$AC,$A6,$C0,$00         ; _with holy magic.|
CommonString_19:
.byte $FF,$B5,$A4,$30,$1F,$47,$A7,$A8,$A9,$3A,$3E,$C0,$00             ; _raising defense.|
CommonString_1A:
.byte $FF,$B5,$A4,$30,$1F,$47,$A8,$B9,$3F,$AC,$3C,$C0,$00             ; _raising evasion.|
CommonString_1B:
.byte $AF,$46,$25,$1F,$47,$A8,$B9,$3F,$AC,$3C,$C0,$00                 ; lowering evasion.|
CommonString_1C:
.byte $09,$11,$00                                                     ; _________________|
CommonString_1D:
.byte $96,$A4,$AA,$AC,$51,$4E,$4B,$1F,$25,$B7,$C0,$00                 ; Magically inert.
CommonString_1E:
CommonString_1F:
CommonString_20:
CommonString_21:
CommonString_22:
CommonString_23:
CommonString_24:
CommonString_25:
CommonString_26:
CommonString_27:
CommonString_28:
CommonString_29:
CommonString_2A:
CommonString_2B:
CommonString_2C:
CommonString_2D:
CommonString_2E:
CommonString_2F:
CommonString_30:
CommonString_31:
CommonString_32:
CommonString_33:
CommonString_34:
CommonString_35:
CommonString_36:
CommonString_37:
CommonString_38:
CommonString_39:
CommonString_3A:
CommonString_3B:
CommonString_3C:
CommonString_3D:
CommonString_3E:
CommonString_3F:



























;; make another table like the price table for dialogue? 




lut_GoldNames_Low:
.byte <GOLDAMOUNT_1  ; 00
.byte <GOLDAMOUNT_2  ; 01
.byte <GOLDAMOUNT_3  ; 02
.byte <GOLDAMOUNT_4  ; 03
.byte <GOLDAMOUNT_5  ; 04
.byte <GOLDAMOUNT_6  ; 05
.byte <GOLDAMOUNT_7  ; 06
.byte <GOLDAMOUNT_8  ; 07
.byte <GOLDAMOUNT_9  ; 08
.byte <GOLDAMOUNT_10 ; 09
.byte <GOLDAMOUNT_11 ; 0A
.byte <GOLDAMOUNT_12 ; 0B
.byte <GOLDAMOUNT_13 ; 0C
.byte <GOLDAMOUNT_14 ; 0D
.byte <GOLDAMOUNT_15 ; 0E
.byte <GOLDAMOUNT_16 ; 0F
.byte <GOLDAMOUNT_17 ; 10
.byte <GOLDAMOUNT_18 ; 11
.byte <GOLDAMOUNT_19 ; 12
.byte <GOLDAMOUNT_20 ; 13
.byte <GOLDAMOUNT_21 ; 14
.byte <GOLDAMOUNT_22 ; 15
.byte <GOLDAMOUNT_23 ; 16
.byte <GOLDAMOUNT_24 ; 17
.byte <GOLDAMOUNT_25 ; 18
.byte <GOLDAMOUNT_26 ; 19
.byte <GOLDAMOUNT_27 ; 1A
.byte <GOLDAMOUNT_28 ; 1B
.byte <GOLDAMOUNT_29 ; 1C
.byte <GOLDAMOUNT_30 ; 1D
.byte <GOLDAMOUNT_31 ; 1E
.byte <GOLDAMOUNT_32 ; 1F
.byte <GOLDAMOUNT_33 ; 20
.byte <GOLDAMOUNT_34 ; 21
.byte <GOLDAMOUNT_35 ; 22
.byte <GOLDAMOUNT_36 ; 23
.byte <GOLDAMOUNT_37 ; 24
.byte <GOLDAMOUNT_38 ; 25
.byte <GOLDAMOUNT_39 ; 26
.byte <GOLDAMOUNT_40 ; 27
.byte <GOLDAMOUNT_41 ; 28
.byte <GOLDAMOUNT_42 ; 29
.byte <GOLDAMOUNT_43 ; 2A
.byte <GOLDAMOUNT_44 ; 2B
.byte <GOLDAMOUNT_45 ; 2C
.byte <GOLDAMOUNT_46 ; 2D
.byte <GOLDAMOUNT_47 ; 2E
.byte <GOLDAMOUNT_48 ; 2F
.byte <GOLDAMOUNT_49 ; 30
.byte <GOLDAMOUNT_50 ; 31
.byte <GOLDAMOUNT_51 ; 32
.byte <GOLDAMOUNT_52 ; 33
.byte <GOLDAMOUNT_53 ; 34
.byte <GOLDAMOUNT_54 ; 35
.byte <GOLDAMOUNT_55 ; 36
.byte <GOLDAMOUNT_56 ; 37
.byte <GOLDAMOUNT_57 ; 38
.byte <GOLDAMOUNT_58 ; 39
.byte <GOLDAMOUNT_59 ; 3A
.byte <GOLDAMOUNT_60 ; 3B
.byte <GOLDAMOUNT_61 ; 3C
.byte <GOLDAMOUNT_62 ; 3D
.byte <GOLDAMOUNT_63 ; 3E
.byte <GOLDAMOUNT_64 ; 3F
.byte <GOLDAMOUNT_65 ; 40
.byte <GOLDAMOUNT_66 ; 41
.byte <GOLDAMOUNT_67 ; 42
.byte <GOLDAMOUNT_68 ; 43
.byte <GOLDAMOUNT_69 ; 44
.byte <GOLDAMOUNT_70 ; 45
.byte <GOLDAMOUNT_71 ; 46
.byte <GOLDAMOUNT_72 ; 47
.byte <GOLDAMOUNT_73 ; 48
.byte <GOLDAMOUNT_74 ; 49
.byte <GOLDAMOUNT_75 ; 4A
.byte <GOLDAMOUNT_76 ; 4B
.byte <GOLDAMOUNT_77 ; 4C
.byte <GOLDAMOUNT_78 ; 4D
.byte <GOLDAMOUNT_79 ; 4E
.byte <GOLDAMOUNT_80 ; 4F

lut_GoldNames_High:
.byte >GOLDAMOUNT_1  ; 00
.byte >GOLDAMOUNT_2  ; 01
.byte >GOLDAMOUNT_3  ; 02
.byte >GOLDAMOUNT_4  ; 03
.byte >GOLDAMOUNT_5  ; 04
.byte >GOLDAMOUNT_6  ; 05
.byte >GOLDAMOUNT_7  ; 06
.byte >GOLDAMOUNT_8  ; 07
.byte >GOLDAMOUNT_9  ; 08
.byte >GOLDAMOUNT_10 ; 09
.byte >GOLDAMOUNT_11 ; 0A
.byte >GOLDAMOUNT_12 ; 0B
.byte >GOLDAMOUNT_13 ; 0C
.byte >GOLDAMOUNT_14 ; 0D
.byte >GOLDAMOUNT_15 ; 0E
.byte >GOLDAMOUNT_16 ; 0F
.byte >GOLDAMOUNT_17 ; 10
.byte >GOLDAMOUNT_18 ; 11
.byte >GOLDAMOUNT_19 ; 12
.byte >GOLDAMOUNT_20 ; 13
.byte >GOLDAMOUNT_21 ; 14
.byte >GOLDAMOUNT_22 ; 15
.byte >GOLDAMOUNT_23 ; 16
.byte >GOLDAMOUNT_24 ; 17
.byte >GOLDAMOUNT_25 ; 18
.byte >GOLDAMOUNT_26 ; 19
.byte >GOLDAMOUNT_27 ; 1A
.byte >GOLDAMOUNT_28 ; 1B
.byte >GOLDAMOUNT_29 ; 1C
.byte >GOLDAMOUNT_30 ; 1D
.byte >GOLDAMOUNT_31 ; 1E
.byte >GOLDAMOUNT_32 ; 1F
.byte >GOLDAMOUNT_33 ; 20
.byte >GOLDAMOUNT_34 ; 21
.byte >GOLDAMOUNT_35 ; 22
.byte >GOLDAMOUNT_36 ; 23
.byte >GOLDAMOUNT_37 ; 24
.byte >GOLDAMOUNT_38 ; 25
.byte >GOLDAMOUNT_39 ; 26
.byte >GOLDAMOUNT_40 ; 27
.byte >GOLDAMOUNT_41 ; 28
.byte >GOLDAMOUNT_42 ; 29
.byte >GOLDAMOUNT_43 ; 2A
.byte >GOLDAMOUNT_44 ; 2B
.byte >GOLDAMOUNT_45 ; 2C
.byte >GOLDAMOUNT_46 ; 2D
.byte >GOLDAMOUNT_47 ; 2E
.byte >GOLDAMOUNT_48 ; 2F
.byte >GOLDAMOUNT_49 ; 30
.byte >GOLDAMOUNT_50 ; 31
.byte >GOLDAMOUNT_51 ; 32
.byte >GOLDAMOUNT_52 ; 33
.byte >GOLDAMOUNT_53 ; 34
.byte >GOLDAMOUNT_54 ; 35
.byte >GOLDAMOUNT_55 ; 36
.byte >GOLDAMOUNT_56 ; 37
.byte >GOLDAMOUNT_57 ; 38
.byte >GOLDAMOUNT_58 ; 39
.byte >GOLDAMOUNT_59 ; 3A
.byte >GOLDAMOUNT_60 ; 3B
.byte >GOLDAMOUNT_61 ; 3C
.byte >GOLDAMOUNT_62 ; 3D
.byte >GOLDAMOUNT_63 ; 3E
.byte >GOLDAMOUNT_64 ; 3F
.byte >GOLDAMOUNT_65 ; 40
.byte >GOLDAMOUNT_66 ; 41
.byte >GOLDAMOUNT_67 ; 42
.byte >GOLDAMOUNT_68 ; 43
.byte >GOLDAMOUNT_69 ; 44
.byte >GOLDAMOUNT_70 ; 45
.byte >GOLDAMOUNT_71 ; 46
.byte >GOLDAMOUNT_72 ; 47
.byte >GOLDAMOUNT_73 ; 48
.byte >GOLDAMOUNT_74 ; 49
.byte >GOLDAMOUNT_75 ; 4A
.byte >GOLDAMOUNT_76 ; 4B
.byte >GOLDAMOUNT_77 ; 4C
.byte >GOLDAMOUNT_78 ; 4D
.byte >GOLDAMOUNT_79 ; 4E
.byte >GOLDAMOUNT_80 ; 4F

;gold in chests
;; Note this is only the text data. Actual amount given is in the price list.
GOLDAMOUNT_1:
.byte $81,$80,$FF,$90,$00 ; 10
GOLDAMOUNT_2:
.byte $82,$80,$FF,$90,$00 ; 20
GOLDAMOUNT_3:
.byte $82,$85,$FF,$90,$00 ; 25
GOLDAMOUNT_4:
.byte $83,$80,$FF,$90,$00 ; 30
GOLDAMOUNT_5:
.byte $85,$85,$FF,$90,$00 ; 55
GOLDAMOUNT_6:
.byte $87,$80,$FF,$90,$00 ; 70
GOLDAMOUNT_7:
.byte $88,$85,$FF,$90,$00 ; 85
GOLDAMOUNT_8:
.byte $81,$81,$80,$FF,$90,$00 ; 110
GOLDAMOUNT_9:
.byte $81,$83,$85,$FF,$90,$00 ; 135
GOLDAMOUNT_10:
.byte $81,$85,$85,$FF,$90,$00 ; 155
GOLDAMOUNT_11:
.byte $81,$86,$80,$FF,$90,$00 ; 160
GOLDAMOUNT_12:
.byte $81,$88,$80,$FF,$90,$00 ; 180
GOLDAMOUNT_13:
.byte $82,$84,$80,$FF,$90,$00 ; 240
GOLDAMOUNT_14:
.byte $82,$85,$85,$FF,$90,$00 ; 255
GOLDAMOUNT_15:
.byte $82,$86,$80,$FF,$90,$00 ; 260
GOLDAMOUNT_16:
.byte $82,$89,$85,$FF,$90,$00 ; 295
GOLDAMOUNT_17:
.byte $83,$80,$80,$FF,$90,$00 ; 300
GOLDAMOUNT_18:
.byte $83,$81,$85,$FF,$90,$00 ; 315
GOLDAMOUNT_19:
.byte $83,$83,$80,$FF,$90,$00 ; 330
GOLDAMOUNT_20:
.byte $83,$85,$80,$FF,$90,$00 ; 350
GOLDAMOUNT_21:
.byte $83,$88,$85,$FF,$90,$00 ; 385
GOLDAMOUNT_22:
.byte $84,$80,$80,$FF,$90,$00 ; 400
GOLDAMOUNT_23:
.byte $84,$85,$80,$FF,$90,$00 ; 450
GOLDAMOUNT_24:
.byte $85,$80,$80,$FF,$90,$00 ; 500
GOLDAMOUNT_25:
.byte $85,$83,$80,$FF,$90,$00 ; 530
GOLDAMOUNT_26:
.byte $85,$87,$85,$FF,$90,$00 ; 575
GOLDAMOUNT_27:
.byte $86,$82,$80,$FF,$90,$00 ; 620
GOLDAMOUNT_28:
.byte $86,$88,$80,$FF,$90,$00 ; 680
GOLDAMOUNT_29:
.byte $87,$85,$80,$FF,$90,$00 ; 750
GOLDAMOUNT_30:
.byte $87,$89,$85,$FF,$90,$00 ; 795
GOLDAMOUNT_31:
.byte $88,$88,$80,$FF,$90,$00 ; 880
GOLDAMOUNT_32:
.byte $81,$80,$82,$80,$FF,$90,$00 ; 1020
GOLDAMOUNT_33:
.byte $81,$82,$85,$80,$FF,$90,$00 ; 1250
GOLDAMOUNT_34:
.byte $81,$84,$85,$85,$FF,$90,$00 ; 1455
GOLDAMOUNT_35:
.byte $81,$85,$82,$80,$FF,$90,$00 ; 1520
GOLDAMOUNT_36:
.byte $81,$87,$86,$80,$FF,$90,$00 ; 1760
GOLDAMOUNT_37:
.byte $81,$89,$87,$85,$FF,$90,$00 ; 1975
GOLDAMOUNT_38:
.byte $82,$80,$80,$80,$FF,$90,$00 ; 2000
GOLDAMOUNT_39:
.byte $82,$87,$85,$80,$FF,$90,$00 ; 2750
GOLDAMOUNT_40:
.byte $83,$84,$80,$80,$FF,$90,$00 ; 3400
GOLDAMOUNT_41:
.byte $84,$81,$85,$80,$FF,$90,$00 ; 4150
GOLDAMOUNT_42:
.byte $85,$80,$80,$80,$FF,$90,$00 ; 5000
GOLDAMOUNT_43:
.byte $85,$84,$85,$80,$FF,$90,$00 ; 5450
GOLDAMOUNT_44:
.byte $86,$84,$80,$80,$FF,$90,$00 ; 6400
GOLDAMOUNT_45:
.byte $86,$87,$82,$80,$FF,$90,$00 ; 6720
GOLDAMOUNT_46:
.byte $87,$83,$84,$80,$FF,$90,$00 ; 7340
GOLDAMOUNT_47:
.byte $87,$86,$89,$80,$FF,$90,$00 ; 7690
GOLDAMOUNT_48:
.byte $87,$89,$80,$80,$FF,$90,$00 ; 7900
GOLDAMOUNT_49:
.byte $88,$81,$83,$85,$FF,$90,$00 ; 8135
GOLDAMOUNT_50:
.byte $89,$80,$80,$80,$FF,$90,$00 ; 9000
GOLDAMOUNT_51:
.byte $89,$83,$80,$80,$FF,$90,$00 ; 9300
GOLDAMOUNT_52:
.byte $89,$85,$80,$80,$FF,$90,$00 ; 9500
GOLDAMOUNT_53:
.byte $89,$89,$80,$80,$FF,$90,$00 ; 9900
GOLDAMOUNT_54:
.byte $81,$80,$80,$80,$80,$FF,$90,$00 ; 10000
GOLDAMOUNT_55:
.byte $81,$82,$83,$85,$80,$FF,$90,$00 ; 12350
GOLDAMOUNT_56:
.byte $81,$83,$80,$80,$80,$FF,$90,$00 ; 13000
GOLDAMOUNT_57:
.byte $81,$83,$84,$85,$80,$FF,$90,$00 ; 13450
GOLDAMOUNT_58:
.byte $81,$84,$80,$85,$80,$FF,$90,$00 ; 14050
GOLDAMOUNT_59:
.byte $81,$84,$87,$82,$80,$FF,$90,$00 ; 14720
GOLDAMOUNT_60:
.byte $81,$85,$80,$80,$80,$FF,$90,$00 ; 15000
GOLDAMOUNT_61:
.byte $81,$87,$84,$89,$80,$FF,$90,$00 ; 17490
GOLDAMOUNT_62:
.byte $81,$88,$80,$81,$80,$FF,$90,$00 ; 18010
GOLDAMOUNT_63:
.byte $81,$89,$89,$89,$80,$FF,$90,$00 ; 19990
GOLDAMOUNT_64:
.byte $82,$80,$80,$80,$80,$FF,$90,$00 ; 20000
GOLDAMOUNT_65:
.byte $82,$80,$80,$81,$80,$FF,$90,$00 ; 20010
GOLDAMOUNT_66:
.byte $82,$86,$80,$80,$80,$FF,$90,$00 ; 26000
GOLDAMOUNT_67:
.byte $84,$85,$80,$80,$80,$FF,$90,$00 ; 45000
GOLDAMOUNT_68:
.byte $86,$85,$80,$80,$80,$FF,$90,$00 ; 65000
GOLDAMOUNT_69:
.byte $86,$85,$80,$80,$80,$FF,$90,$00 ; 65000
GOLDAMOUNT_70:
.byte $86,$85,$80,$80,$80,$FF,$90,$00 ; 65000
GOLDAMOUNT_71:
.byte $86,$85,$80,$80,$80,$FF,$90,$00 ; 65000
GOLDAMOUNT_72:
.byte $86,$85,$80,$80,$80,$FF,$90,$00 ; 65000
GOLDAMOUNT_73:
.byte $86,$85,$80,$80,$80,$FF,$90,$00 ; 65000
GOLDAMOUNT_74:
.byte $86,$85,$80,$80,$80,$FF,$90,$00 ; 65000
GOLDAMOUNT_75:
.byte $86,$85,$80,$80,$80,$FF,$90,$00 ; 65000
GOLDAMOUNT_76:
.byte $86,$85,$80,$80,$80,$FF,$90,$00 ; 65000
GOLDAMOUNT_77:
.byte $86,$85,$80,$80,$80,$FF,$90,$00 ; 65000
GOLDAMOUNT_78:
.byte $86,$85,$80,$80,$80,$FF,$90,$00 ; 65000
GOLDAMOUNT_79:
.byte $86,$85,$80,$80,$80,$FF,$90,$00 ; 65000
GOLDAMOUNT_80:
.byte $86,$85,$80,$80,$80,$FF,$90,$00 ; 65000


























lut_MagicNames_Low:
.byte <SPELL1         ; 00 ; MG_CURE
.byte <SPELL2         ; 01 ; MG_HARM
.byte <SPELL3         ; 02 ; MG_FOG
.byte <SPELL4         ; 03 ; MG_RUSE
.byte <SPELL5         ; 04 ; MG_FIRE
.byte <SPELL6         ; 05 ; MG_SLEP
.byte <SPELL7         ; 06 ; MG_LOCK
.byte <SPELL8         ; 07 ; MG_LIT
.byte <SPELL9         ; 08 ;  
.byte <SPELL10        ; 09 ;  
.byte <SPELL11        ; 0A ;  
.byte <SPELL12        ; 0B ;  
.byte <SPELL13        ; 0C ;  
.byte <SPELL14        ; 0D ;  
.byte <SPELL15        ; 0E ;  
.byte <SPELL16        ; 0F ;  
.byte <SPELL17        ; 10 ; MG_LAMP 
.byte <SPELL18        ; 11 ; MG_MUTE 
.byte <SPELL19        ; 12 ; MG_ALIT 
.byte <SPELL20        ; 13 ; MG_INVS 
.byte <SPELL21        ; 14 ; MG_ICE 
.byte <SPELL22        ; 15 ; MG_DARK 
.byte <SPELL23        ; 16 ; MG_TMPR 
.byte <SPELL24        ; 17 ; MG_SLOW 
.byte <SPELL25        ; 18 ;  
.byte <SPELL26        ; 19 ;  
.byte <SPELL27        ; 1A ;  
.byte <SPELL28        ; 1B ;  
.byte <SPELL29        ; 1C ;  
.byte <SPELL30        ; 1D ;  
.byte <SPELL31        ; 1E ;  
.byte <SPELL32        ; 1F ;  
.byte <SPELL33        ; 20 ; MG_CUR2 
.byte <SPELL34        ; 21 ; MG_HRM2 
.byte <SPELL35        ; 22 ; MG_AFIR 
.byte <SPELL36        ; 23 ; MG_HEAL 
.byte <SPELL37        ; 24 ; MG_FIR2 
.byte <SPELL38        ; 25 ; MG_HOLD 
.byte <SPELL39        ; 26 ; MG_LIT2 
.byte <SPELL40        ; 27 ; MG_LOK2 
.byte <SPELL41        ; 28 ;  
.byte <SPELL42        ; 29 ;  
.byte <SPELL43        ; 2A ;  
.byte <SPELL44        ; 2B ;  
.byte <SPELL45        ; 2C ;  
.byte <SPELL46        ; 2D ;  
.byte <SPELL47        ; 2E ;  
.byte <SPELL48        ; 2F ;  
.byte <SPELL49        ; 30 ; MG_PURE 
.byte <SPELL50        ; 31 ; MG_FEAR 
.byte <SPELL51        ; 32 ; MG_AICE 
.byte <SPELL52        ; 33 ; MG_AMUT 
.byte <SPELL53        ; 34 ; MG_SLP2 
.byte <SPELL54        ; 35 ; MG_FAST
.byte <SPELL55        ; 36 ; MG_CONF 
.byte <SPELL56        ; 37 ; MG_ICE2 
.byte <SPELL57        ; 38 ;  
.byte <SPELL58        ; 39 ;  
.byte <SPELL59        ; 3A ;  
.byte <SPELL60        ; 3B ;  
.byte <SPELL61        ; 3C ;  
.byte <SPELL62        ; 3D ;  
.byte <SPELL63        ; 3E ;  
.byte <SPELL64        ; 3F ;  
.byte <SPELL65        ; 40 ; MG_CUR3
.byte <SPELL66        ; 41 ; MG_LIFE
.byte <SPELL67        ; 42 ; MG_HRM3
.byte <SPELL68        ; 43 ; MG_HEL2
.byte <SPELL69        ; 44 ; MG_FIR3
.byte <SPELL70        ; 45 ; MG_BANE
.byte <SPELL71        ; 46 ; MG_WARP
.byte <SPELL72        ; 47 ; MG_SLO2
.byte <SPELL73        ; 48 ; 
.byte <SPELL74        ; 49 ; 
.byte <SPELL75        ; 4A ; 
.byte <SPELL76        ; 4B ; 
.byte <SPELL77        ; 4C ; 
.byte <SPELL78        ; 4D ; 
.byte <SPELL79        ; 4E ; 
.byte <SPELL80        ; 4F ; 
.byte <SPELL81        ; 50 ; MG_SOFT
.byte <SPELL82        ; 51 ; MG_EXIT
.byte <SPELL83        ; 52 ; MG_FOG2
.byte <SPELL84        ; 53 ; MG_INV2
.byte <SPELL85        ; 54 ; MG_LIT3
.byte <SPELL86        ; 55 ; MG_RUB 
.byte <SPELL87        ; 56 ; MG_QAKE
.byte <SPELL88        ; 57 ; MG_STUN
.byte <SPELL89        ; 58 ; 
.byte <SPELL90        ; 59 ; 
.byte <SPELL91        ; 5A ; 
.byte <SPELL92        ; 5B ; 
.byte <SPELL93        ; 5C ; 
.byte <SPELL94        ; 5D ; 
.byte <SPELL95        ; 5E ; 
.byte <SPELL96        ; 5F ; 
.byte <SPELL97        ; 60 ; MG_CUR4
.byte <SPELL98        ; 61 ; MG_HRM4
.byte <SPELL99        ; 62 ; MG_ARUB
.byte <SPELL100       ; 63 ; MG_HEL3
.byte <SPELL101       ; 64 ; MG_ICE3
.byte <SPELL102       ; 65 ; MG_BRAK
.byte <SPELL103       ; 66 ; MG_SABR
.byte <SPELL104       ; 67 ; MG_BLND
.byte <SPELL105       ; 68 ; 
.byte <SPELL106       ; 69 ; 
.byte <SPELL107       ; 6A ; 
.byte <SPELL108       ; 6B ; 
.byte <SPELL109       ; 6C ; 
.byte <SPELL110       ; 6D ; 
.byte <SPELL111       ; 6E ; 
.byte <SPELL112       ; 6F ; 
.byte <SPELL113       ; 70 ; MG_LIF2
.byte <SPELL114       ; 71 ; MG_FADE
.byte <SPELL115       ; 72 ; MG_WALL
.byte <SPELL116       ; 73 ; MG_XFER
.byte <SPELL117       ; 74 ; MG_NUKE
.byte <SPELL118       ; 75 ; MG_STOP
.byte <SPELL119       ; 76 ; MG_ZAP
.byte <SPELL120       ; 77 ; MG_XXXX
.byte <SPELL121       ; 78 ;
.byte <SPELL122       ; 79 ;
.byte <SPELL123       ; 7A ;
.byte <SPELL124       ; 7B ;
.byte <SPELL125       ; 7C ;
.byte <SPELL126       ; 7D ;
.byte <SPELL127       ; 7E ;
.byte <SPELL128       ; 7F ;
.byte <BATTLESPELL1   ; 80 ; 
.byte <BATTLESPELL2   ; 81 ; 
.byte <BATTLESPELL3   ; 82 ; 
.byte <BATTLESPELL4   ; 83 ; 
.byte <BATTLESPELL5   ; 84 ; 
.byte <BATTLESPELL6   ; 85 ; 
.byte <BATTLESPELL7   ; 86 ; 
.byte <BATTLESPELL8   ; 87 ; 
.byte <BATTLESPELL9   ; 88 ; 
.byte <BATTLESPELL10  ; 89 ; 
.byte <BATTLESPELL11  ; 8A ; 
.byte <BATTLESPELL12  ; 8B ; 
.byte <BATTLESPELL13  ; 8C ; 
.byte <BATTLESPELL14  ; 8D ; 
.byte <BATTLESPELL15  ; 8E ; 
.byte <BATTLESPELL16  ; 8F ; 
.byte <EnemyAttack1   ; 90 ; 00 - enemy attack ID
.byte <EnemyAttack2   ; 91 ; 01
.byte <EnemyAttack3   ; 92 ; 02
.byte <EnemyAttack4   ; 93 ; 03
.byte <EnemyAttack5   ; 94 ; 04
.byte <EnemyAttack6   ; 95 ; 05
.byte <EnemyAttack7   ; 96 ; 06
.byte <EnemyAttack8   ; 97 ; 07
.byte <EnemyAttack9   ; 98 ; 08
.byte <EnemyAttack10  ; 99 ; 09
.byte <EnemyAttack11  ; 9A ; 0A
.byte <EnemyAttack12  ; 9B ; 0B
.byte <EnemyAttack13  ; 9C ; 0C
.byte <EnemyAttack14  ; 9D ; 0D
.byte <EnemyAttack15  ; 9E ; 0E
.byte <EnemyAttack16  ; 9F ; 0F
.byte <EnemyAttack17  ; A0 ; 10
.byte <EnemyAttack18  ; A1 ; 11
.byte <EnemyAttack19  ; A2 ; 12
.byte <EnemyAttack20  ; A3 ; 13
.byte <EnemyAttack21  ; A4 ; 14
.byte <EnemyAttack22  ; A5 ; 15
.byte <EnemyAttack23  ; A6 ; 16
.byte <EnemyAttack24  ; A7 ; 17
.byte <EnemyAttack25  ; A8 ; 18
.byte <EnemyAttack26  ; A9 ; 19
.byte <EnemyAttack27  ; AA ; 1A
.byte <EnemyAttack28  ; AB ; 1B
.byte <EnemyAttack29  ; AC ; 1C
.byte <EnemyAttack30  ; AD ; 1D
.byte <EnemyAttack31  ; AE ; 1E
.byte <EnemyAttack32  ; AF ; 1F
.byte <EnemyAttack33  ; B0 ; 20
.byte <EnemyAttack34  ; B1 ; 21
.byte <EnemyAttack35  ; B2 ; 22
.byte <EnemyAttack36  ; B3 ; 23
.byte <EnemyAttack37  ; B4 ; 24
.byte <EnemyAttack38  ; B5 ; 25
.byte <EnemyAttack39  ; B6 ; 26
.byte <EnemyAttack40  ; B7 ; 27
.byte <EnemyAttack41  ; B8 ; 28
.byte <EnemyAttack42  ; B9 ; 29
.byte <EnemyAttack43  ; BA ; 2A
.byte <EnemyAttack44  ; BB ; 2B
.byte <EnemyAttack45  ; BC ; 2C
.byte <EnemyAttack46  ; BD ; 2D
.byte <EnemyAttack47  ; BE ; 2E
.byte <EnemyAttack48  ; BF ; 2F

lut_MagicNames_High:
.byte >SPELL1         ; 00 ; MG_CURE
.byte >SPELL2         ; 01 ; MG_HARM
.byte >SPELL3         ; 02 ; MG_FOG
.byte >SPELL4         ; 03 ; MG_RUSE
.byte >SPELL5         ; 04 ; MG_FIRE
.byte >SPELL6         ; 05 ; MG_SLEP
.byte >SPELL7         ; 06 ; MG_LOCK
.byte >SPELL8         ; 07 ; MG_LIT
.byte >SPELL9         ; 08 ;  
.byte >SPELL10        ; 09 ;  
.byte >SPELL11        ; 0A ;  
.byte >SPELL12        ; 0B ;  
.byte >SPELL13        ; 0C ;  
.byte >SPELL14        ; 0D ;  
.byte >SPELL15        ; 0E ;  
.byte >SPELL16        ; 0F ;  
.byte >SPELL17        ; 10 ; MG_LAMP 
.byte >SPELL18        ; 11 ; MG_MUTE 
.byte >SPELL19        ; 12 ; MG_ALIT 
.byte >SPELL20        ; 13 ; MG_INVS 
.byte >SPELL21        ; 14 ; MG_ICE 
.byte >SPELL22        ; 15 ; MG_DARK 
.byte >SPELL23        ; 16 ; MG_TMPR 
.byte >SPELL24        ; 17 ; MG_SLOW 
.byte >SPELL25        ; 18 ;  
.byte >SPELL26        ; 19 ;  
.byte >SPELL27        ; 1A ;  
.byte >SPELL28        ; 1B ;  
.byte >SPELL29        ; 1C ;  
.byte >SPELL30        ; 1D ;  
.byte >SPELL31        ; 1E ;  
.byte >SPELL32        ; 1F ;  
.byte >SPELL33        ; 20 ; MG_CUR2 
.byte >SPELL34        ; 21 ; MG_HRM2 
.byte >SPELL35        ; 22 ; MG_AFIR 
.byte >SPELL36        ; 23 ; MG_HEAL 
.byte >SPELL37        ; 24 ; MG_FIR2 
.byte >SPELL38        ; 25 ; MG_HOLD 
.byte >SPELL39        ; 26 ; MG_LIT2 
.byte >SPELL40        ; 27 ; MG_LOK2 
.byte >SPELL41        ; 28 ;  
.byte >SPELL42        ; 29 ;  
.byte >SPELL43        ; 2A ;  
.byte >SPELL44        ; 2B ;  
.byte >SPELL45        ; 2C ;  
.byte >SPELL46        ; 2D ;  
.byte >SPELL47        ; 2E ;  
.byte >SPELL48        ; 2F ;  
.byte >SPELL49        ; 30 ; MG_PURE 
.byte >SPELL50        ; 31 ; MG_FEAR 
.byte >SPELL51        ; 32 ; MG_AICE 
.byte >SPELL52        ; 33 ; MG_AMUT 
.byte >SPELL53        ; 34 ; MG_SLP2 
.byte >SPELL54        ; 35 ; MG_FAST
.byte >SPELL55        ; 36 ; MG_CONF 
.byte >SPELL56        ; 37 ; MG_ICE2 
.byte >SPELL57        ; 38 ;  
.byte >SPELL58        ; 39 ;  
.byte >SPELL59        ; 3A ;  
.byte >SPELL60        ; 3B ;  
.byte >SPELL61        ; 3C ;  
.byte >SPELL62        ; 3D ;  
.byte >SPELL63        ; 3E ;  
.byte >SPELL64        ; 3F ;  
.byte >SPELL65        ; 40 ; MG_CUR3
.byte >SPELL66        ; 41 ; MG_LIFE
.byte >SPELL67        ; 42 ; MG_HRM3
.byte >SPELL68        ; 43 ; MG_HEL2
.byte >SPELL69        ; 44 ; MG_FIR3
.byte >SPELL70        ; 45 ; MG_BANE
.byte >SPELL71        ; 46 ; MG_WARP
.byte >SPELL72        ; 47 ; MG_SLO2
.byte >SPELL73        ; 48 ; 
.byte >SPELL74        ; 49 ; 
.byte >SPELL75        ; 4A ; 
.byte >SPELL76        ; 4B ; 
.byte >SPELL77        ; 4C ; 
.byte >SPELL78        ; 4D ; 
.byte >SPELL79        ; 4E ; 
.byte >SPELL80        ; 4F ; 
.byte >SPELL81        ; 50 ; MG_SOFT
.byte >SPELL82        ; 51 ; MG_EXIT
.byte >SPELL83        ; 52 ; MG_FOG2
.byte >SPELL84        ; 53 ; MG_INV2
.byte >SPELL85        ; 54 ; MG_LIT3
.byte >SPELL86        ; 55 ; MG_RUB 
.byte >SPELL87        ; 56 ; MG_QAKE
.byte >SPELL88        ; 57 ; MG_STUN
.byte >SPELL89        ; 58 ; 
.byte >SPELL90        ; 59 ; 
.byte >SPELL91        ; 5A ; 
.byte >SPELL92        ; 5B ; 
.byte >SPELL93        ; 5C ; 
.byte >SPELL94        ; 5D ; 
.byte >SPELL95        ; 5E ; 
.byte >SPELL96        ; 5F ; 
.byte >SPELL97        ; 60 ; MG_CUR4
.byte >SPELL98        ; 61 ; MG_HRM4
.byte >SPELL99        ; 62 ; MG_ARUB
.byte >SPELL100       ; 63 ; MG_HEL3
.byte >SPELL101       ; 64 ; MG_ICE3
.byte >SPELL102       ; 65 ; MG_BRAK
.byte >SPELL103       ; 66 ; MG_SABR
.byte >SPELL104       ; 67 ; MG_BLND
.byte >SPELL105       ; 68 ; 
.byte >SPELL106       ; 69 ; 
.byte >SPELL107       ; 6A ; 
.byte >SPELL108       ; 6B ; 
.byte >SPELL109       ; 6C ; 
.byte >SPELL110       ; 6D ; 
.byte >SPELL111       ; 6E ; 
.byte >SPELL112       ; 6F ; 
.byte >SPELL113       ; 70 ; MG_LIF2
.byte >SPELL114       ; 71 ; MG_FADE
.byte >SPELL115       ; 72 ; MG_WALL
.byte >SPELL116       ; 73 ; MG_XFER
.byte >SPELL117       ; 74 ; MG_NUKE
.byte >SPELL118       ; 75 ; MG_STOP
.byte >SPELL119       ; 76 ; MG_ZAP
.byte >SPELL120       ; 77 ; MG_XXXX
.byte >SPELL121       ; 78 ;
.byte >SPELL122       ; 79 ;
.byte >SPELL123       ; 7A ;
.byte >SPELL124       ; 7B ;
.byte >SPELL125       ; 7C ;
.byte >SPELL126       ; 7D ;
.byte >SPELL127       ; 7E ;
.byte >SPELL128       ; 7F ;
.byte >BATTLESPELL1   ; 80 ; 
.byte >BATTLESPELL2   ; 81 ; 
.byte >BATTLESPELL3   ; 82 ; 
.byte >BATTLESPELL4   ; 83 ; 
.byte >BATTLESPELL5   ; 84 ; 
.byte >BATTLESPELL6   ; 85 ; 
.byte >BATTLESPELL7   ; 86 ; 
.byte >BATTLESPELL8   ; 87 ; 
.byte >BATTLESPELL9   ; 88 ; 
.byte >BATTLESPELL10  ; 89 ; 
.byte >BATTLESPELL11  ; 8A ; 
.byte >BATTLESPELL12  ; 8B ; 
.byte >BATTLESPELL13  ; 8C ; 
.byte >BATTLESPELL14  ; 8D ; 
.byte >BATTLESPELL15  ; 8E ; 
.byte >BATTLESPELL16  ; 8F ; 
.byte >EnemyAttack1   ; 90 ; 00 - enemy attack ID
.byte >EnemyAttack2   ; 91 ; 01
.byte >EnemyAttack3   ; 92 ; 02
.byte >EnemyAttack4   ; 93 ; 03
.byte >EnemyAttack5   ; 94 ; 04
.byte >EnemyAttack6   ; 95 ; 05
.byte >EnemyAttack7   ; 96 ; 06
.byte >EnemyAttack8   ; 97 ; 07
.byte >EnemyAttack9   ; 98 ; 08
.byte >EnemyAttack10  ; 99 ; 09
.byte >EnemyAttack11  ; 9A ; 0A
.byte >EnemyAttack12  ; 9B ; 0B
.byte >EnemyAttack13  ; 9C ; 0C
.byte >EnemyAttack14  ; 9D ; 0D
.byte >EnemyAttack15  ; 9E ; 0E
.byte >EnemyAttack16  ; 9F ; 0F
.byte >EnemyAttack17  ; A0 ; 10
.byte >EnemyAttack18  ; A1 ; 11
.byte >EnemyAttack19  ; A2 ; 12
.byte >EnemyAttack20  ; A3 ; 13
.byte >EnemyAttack21  ; A4 ; 14
.byte >EnemyAttack22  ; A5 ; 15
.byte >EnemyAttack23  ; A6 ; 16
.byte >EnemyAttack24  ; A7 ; 17
.byte >EnemyAttack25  ; A8 ; 18
.byte >EnemyAttack26  ; A9 ; 19
.byte >EnemyAttack27  ; AA ; 1A
.byte >EnemyAttack28  ; AB ; 1B
.byte >EnemyAttack29  ; AC ; 1C
.byte >EnemyAttack30  ; AD ; 1D
.byte >EnemyAttack31  ; AE ; 1E
.byte >EnemyAttack32  ; AF ; 1F
.byte >EnemyAttack33  ; B0 ; 20
.byte >EnemyAttack34  ; B1 ; 21
.byte >EnemyAttack35  ; B2 ; 22
.byte >EnemyAttack36  ; B3 ; 23
.byte >EnemyAttack37  ; B4 ; 24
.byte >EnemyAttack38  ; B5 ; 25
.byte >EnemyAttack39  ; B6 ; 26
.byte >EnemyAttack40  ; B7 ; 27
.byte >EnemyAttack41  ; B8 ; 28
.byte >EnemyAttack42  ; B9 ; 29
.byte >EnemyAttack43  ; BA ; 2A
.byte >EnemyAttack44  ; BB ; 2B
.byte >EnemyAttack45  ; BC ; 2C
.byte >EnemyAttack46  ; BD ; 2D
.byte >EnemyAttack47  ; BE ; 2E
.byte >EnemyAttack48  ; BF ; 2F


;;Magic spell names
;;
;; Updated for 7 letter spells!
;; Since the code that draws spell names assumes 4 letters, it was easier for them to have the occasional $FF (Ice_)
;; than it was to bother padding it out... so these need to be 8 bytes each even if your spell is 3 letters long.
;; So if you have, say, CONFUSE, ICE, and FIRE 2 in the same line, the space between ICE and FIRE 2 will be too short...
;;
;; The issue with 7 letter names is that if you only have one spell, the cursor will block the number of max mana. Oh well!
;; You'd have to make a side-less box or something to widen it any further. Would look weird!

SPELL1:
.byte $8C,$9E,$9B,$8E,$FF,$FF,$FF,$00  ;  CURE___
SPELL2:
.byte $91,$8A,$9B,$96,$FF,$FF,$FF,$00  ;  HARM___
SPELL3:
.byte $9C,$91,$92,$8E,$95,$8D,$FF,$00  ;  SHIELD_
SPELL4:
.byte $8B,$95,$92,$97,$94,$FF,$FF,$00  ;  BLINK__
SPELL5:
.byte $8F,$92,$9B,$8E,$FF,$FF,$FF,$00  ;  FIRE___
SPELL6:
.byte $9C,$95,$8E,$8E,$99,$FF,$FF,$00  ;  SLEEP__
SPELL7:
.byte $95,$98,$8C,$94,$FF,$FF,$FF,$00  ;  LOCK___
SPELL8:
.byte $8B,$98,$95,$9D,$FF,$FF,$FF,$00  ;  BOLT___
SPELL9:
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$00
SPELL10:
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$00
SPELL11:
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$00
SPELL12:
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$00
SPELL13:
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$00
SPELL14:
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$00
SPELL15:
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$00
SPELL16:
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$00

SPELL17:
.byte $95,$8A,$96,$99,$FF,$FF,$FF,$00  ;  LAMP___
SPELL18:
.byte $96,$9E,$9D,$8E,$FF,$FF,$FF,$00  ;  MUTE___
SPELL19:
.byte $8B,$98,$95,$9D,$FF,$FF,$DB,$00  ;  BOLT__(Shield)
SPELL20:
.byte $92,$97,$9F,$92,$9C,$FF,$FF,$00  ;  INVIS__
SPELL21:
.byte $92,$8C,$8E,$FF,$FF,$FF,$FF,$00  ;  ICE____
SPELL22:
.byte $8D,$8A,$9B,$94,$FF,$FF,$FF,$00  ;  DARK___
SPELL23:
.byte $9D,$8E,$96,$99,$8E,$9B,$FF,$00  ;  TEMPER_
SPELL24:
.byte $9C,$95,$98,$A0,$FF,$FF,$FF,$00  ;  SLOW___
SPELL25:
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$00
SPELL26:
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$00
SPELL27:
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$00
SPELL28:
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$00
SPELL29:
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$00
SPELL30:
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$00
SPELL31:
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$00
SPELL32:
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$00

SPELL33:
.byte $8C,$9E,$9B,$8E,$FF,$FF,$82,$00  ;  CURE__2
SPELL34:
.byte $91,$8A,$9B,$96,$FF,$FF,$82,$00  ;  HARM__2
SPELL35:
.byte $8F,$92,$9B,$8E,$FF,$FF,$DB,$00  ;  FIRE__(shield)
SPELL36:
;.byte $91,$8E,$8A,$95,$FF,$FF,$FF,$00  ;  HEAL___
.byte $9B,$8E,$90,$8E,$97,$FF,$FF,$00  ; REGEN__
SPELL37:
.byte $8F,$92,$9B,$8E,$FF,$FF,$82,$00  ;  FIRE__2
SPELL38:
.byte $91,$98,$95,$8D,$FF,$FF,$FF,$00  ;  HOLD___
SPELL39:
.byte $8B,$98,$95,$9D,$FF,$FF,$82,$00  ;  BOLT__2
SPELL40:
.byte $95,$98,$8C,$94,$FF,$FF,$82,$00  ;  LOCK__2
SPELL41:
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$00
SPELL42:
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$00
SPELL43:
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$00
SPELL44:
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$00
SPELL45:
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$00
SPELL46:
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$00
SPELL47:
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$00
SPELL48:
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$00

SPELL49:
.byte $99,$9E,$9B,$8E,$FF,$FF,$FF,$00  ;  PURE___
SPELL50:
.byte $8F,$8E,$8A,$9B,$FF,$FF,$FF,$00  ;  FEAR___
SPELL51:
.byte $92,$8C,$8E,$FF,$FF,$FF,$DB,$00  ;  ICE___(shield)
SPELL52:
.byte $9F,$98,$92,$8C,$8E,$FF,$FF,$00  ;  VOICE__
SPELL53:
.byte $9C,$95,$8E,$8E,$99,$FF,$82,$00  ;  SLEEP_2
SPELL54:
.byte $8F,$8A,$9C,$9D,$FF,$FF,$FF,$00  ;  FAST
SPELL55:
.byte $8C,$98,$97,$8F,$9E,$9C,$8E,$00  ;  CONFUSE
SPELL56:
.byte $92,$8C,$8E,$FF,$FF,$FF,$82,$00  ;  ICE___2
SPELL57:
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$00
SPELL58:
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$00
SPELL59:
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$00
SPELL60:
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$00
SPELL61:
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$00
SPELL62:
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$00
SPELL63:
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$00
SPELL64:
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$00

SPELL65:
.byte $8C,$9E,$9B,$8E,$FF,$FF,$83,$00  ;  CURE__3
SPELL66:
.byte $95,$92,$8F,$8E,$FF,$FF,$FF,$00  ;  LIFE___
SPELL67:
.byte $91,$8A,$9B,$96,$FF,$FF,$83,$00  ;  HARM__3
SPELL68:
;.byte $91,$8E,$8A,$95,$FF,$FF,$82,$00  ;  HEAL__2
.byte $9B,$8E,$90,$8E,$97,$FF,$82,$00  ; REGEN_2
SPELL69:
.byte $8F,$92,$9B,$8E,$FF,$FF,$83,$00  ;  FIRE__3
SPELL70:
.byte $8B,$8A,$97,$8E,$FF,$FF,$FF,$00  ;  BANE___
SPELL71:
.byte $A0,$8A,$9B,$99,$FF,$FF,$FF,$00  ;  WARP___
SPELL72:
.byte $9C,$95,$98,$A0,$FF,$FF,$82,$00  ;  SLOW__2
SPELL73:
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$00
SPELL74:
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$00
SPELL75:
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$00
SPELL76:
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$00
SPELL77:
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$00
SPELL78:
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$00
SPELL79:
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$00
SPELL80:
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$00

SPELL81:
.byte $9C,$98,$8F,$9D,$FF,$FF,$FF,$00  ;  SOFT___
SPELL82:
.byte $8E,$A1,$92,$9D,$FF,$FF,$FF,$00  ;  EXIT___
SPELL83:
.byte $9C,$91,$92,$8E,$95,$8D,$82,$00  ;  SHIELD2
SPELL84:
.byte $92,$97,$9F,$92,$9C,$FF,$82,$00  ;  INVIS_2
SPELL85:
.byte $8B,$98,$95,$9D,$FF,$FF,$83,$00  ;  BOLT__3
SPELL86:
.byte $9B,$9E,$8B,$FF,$FF,$FF,$FF,$00  ;  RUB____
SPELL87:
.byte $9A,$9E,$8A,$94,$8E,$FF,$FF,$00  ;  QUAKE__
SPELL88:
.byte $9C,$9D,$9E,$97,$FF,$FF,$FF,$00  ;  STUN___

SPELL89:
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$00
SPELL90:
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$00
SPELL91:
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$00
SPELL92:
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$00
SPELL93:
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$00
SPELL94:
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$00
SPELL95:
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$00
SPELL96:
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$00

SPELL97:
.byte $8C,$9E,$9B,$8E,$FF,$FF,$84,$00  ;  CURE__4
SPELL98:
.byte $91,$8A,$9B,$96,$FF,$FF,$84,$00  ;  HARM__4
SPELL99:
.byte $9B,$9E,$8B,$FF,$FF,$FF,$DB,$00  ;  RUB___(shield)
SPELL100:
;.byte $91,$8E,$8A,$95,$FF,$FF,$83,$00  ;  HEAL__3
.byte $9B,$8E,$90,$8E,$97,$FF,$83,$00  ; REGEN_3
SPELL101:
.byte $92,$8C,$8E,$FF,$FF,$FF,$83,$00  ;  ICE___3
SPELL102:
.byte $8B,$9B,$8E,$8A,$94,$FF,$FF,$00  ;  BREAK__
SPELL103:
.byte $9C,$8A,$8B,$8E,$9B,$FF,$FF,$00  ;  SABER__
SPELL104:
.byte $8B,$95,$92,$97,$8D,$FF,$FF,$00  ;  BLIND__
SPELL105:
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$00
SPELL106:
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$00
SPELL107:
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$00
SPELL108:
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$00
SPELL109:
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$00
SPELL110:
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$00
SPELL111:
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$00
SPELL112:
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$00

SPELL113:
.byte $95,$92,$8F,$8E,$FF,$FF,$82,$00  ;  LIFE__2
SPELL114:
.byte $91,$98,$95,$A2,$FF,$FF,$FF,$00  ;  HOLY___
SPELL115:
.byte $A0,$8A,$95,$95,$FF,$FF,$FF,$00  ;  WALL___
SPELL116:
.byte $8D,$92,$9C,$99,$8E,$95,$FF,$00  ;  DISPEL_
SPELL117:
.byte $8F,$95,$8A,$9B,$8E,$FF,$FF,$00  ;  FLARE__
SPELL118:
.byte $9C,$9D,$98,$99,$FF,$FF,$FF,$00  ;  STOP___
SPELL119:
.byte $8B,$8A,$97,$92,$9C,$91,$FF,$00  ;  BANISH_
SPELL120:
.byte $8D,$8E,$8A,$9D,$91,$FF,$FF,$00  ;  DEATH__
SPELL121:
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$00
SPELL122:
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$00
SPELL123:
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$00
SPELL124:
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$00
SPELL125:
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$00
SPELL126:
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$00
SPELL127:
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$00
SPELL128:
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$00

BATTLESPELL1: ; CC
.byte $91,$8E,$8A,$95,$FF,$FF,$FF,$00  ;  HEAL
BATTLESPELL2: ; CD
.byte $91,$8E,$8A,$95,$FF,$FF,$82,$00  ;  HEAL__2
BATTLESPELL3: ; CE
.byte $91,$8E,$8A,$95,$FF,$FF,$83,$00  ;  HEAL__3
BATTLESPELL4: ; CF
.byte $99,$9B,$8A,$A2,$8E,$9B,$FF,$00  ;  PRAYER
BATTLESPELL5: ; D0
.byte $9B,$8E,$8F,$95,$8E,$8C,$9D,$00  ;  REFLECT
BATTLESPELL6: ; D1
.byte $9B,$8E,$8F,$95,$8C,$9D,$82,$00  ;  REFLCT2
BATTLESPELL7: ; D2
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$00
BATTLESPELL8: ; D3
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$00
BATTLESPELL9: ; D4
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$00
BATTLESPELL10: ; D5
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$00
BATTLESPELL11: ; D6
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$00
BATTLESPELL12: ; D7
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$00
BATTLESPELL13: ; D8
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$00
BATTLESPELL14: ; D9
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$00
BATTLESPELL15: ; DA
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$00
BATTLESPELL16: ; DB
.byte $8C,$98,$9E,$97,$9D,$8E,$9B,$00  ;  COUNTER




EnemyAttack1:
.byte $8F,$9B,$98,$9C,$9D,$00             ; FROST
EnemyAttack2:
.byte $91,$8E,$8A,$9D,$00                 ; HEAT
EnemyAttack3:
.byte $90,$95,$8A,$97,$8C,$8E,$00         ; GLANCE
EnemyAttack4:
.byte $90,$8A,$A3,$8E,$00                 ; GAZE
EnemyAttack5:
.byte $8F,$95,$8A,$9C,$91,$00             ; FLASH
EnemyAttack6:
.byte $9C,$8C,$98,$9B,$8C,$91,$00         ; SCORCH
EnemyAttack7:
.byte $8C,$9B,$8A,$8C,$94,$00             ; CRACK
EnemyAttack8:
.byte $9C,$9A,$9E,$92,$97,$9D,$00         ; SQUINT
EnemyAttack9:
.byte $9C,$9D,$8A,$9B,$8E,$00             ; STARE
EnemyAttack10:
.byte $90,$95,$8A,$9B,$8E,$00             ; GLARE
EnemyAttack11:
.byte $8B,$95,$92,$A3,$A3,$8A,$9B,$8D,$00 ; BLIZZARD
EnemyAttack12:
.byte $8B,$95,$8A,$A3,$8E,$00             ; BLAZE
EnemyAttack13:
.byte $92,$97,$8F,$8E,$9B,$97,$98,$00     ; INFERNO
EnemyAttack14:
.byte $8C,$9B,$8E,$96,$8A,$9D,$8E,$00     ; CREMATE
EnemyAttack15:
.byte $99,$98,$92,$9C,$98,$97,$00         ; POISON
EnemyAttack16:
.byte $9D,$9B,$8A,$97,$8C,$8E,$00         ; TRANCE
EnemyAttack17:
.byte $99,$98,$92,$9C,$98,$97,$00         ; POISON
EnemyAttack18:
.byte $9D,$91,$9E,$97,$8D,$8E,$9B,$00     ; THUNDER
EnemyAttack19:
.byte $9D,$98,$A1,$92,$8C,$00             ; TOXIC
EnemyAttack20:
.byte $9C,$97,$98,$9B,$9D,$92,$97,$90,$00 ; SNORTING
EnemyAttack21:
.byte $97,$9E,$8C,$95,$8E,$8A,$9B,$00     ; NUCLEAR
EnemyAttack22:
.byte $92,$97,$94,$00                     ; INK
EnemyAttack23:
.byte $9C,$9D,$92,$97,$90,$8E,$9B,$00     ; STINGER
EnemyAttack24:
.byte $8D,$8A,$A3,$A3,$95,$8E,$00         ; DAZZLE
EnemyAttack25:
.byte $9C,$A0,$92,$9B,$95,$00             ; SWIRL
EnemyAttack26:
.byte $9D,$98,$9B,$97,$8A,$8D,$98,$00     ; TORNADO
EnemyAttack27:
EnemyAttack28:
EnemyAttack29:
EnemyAttack30:
EnemyAttack31:
EnemyAttack32:
EnemyAttack33:
EnemyAttack34:
EnemyAttack35:
EnemyAttack36:
EnemyAttack37:
EnemyAttack38:
EnemyAttack39:
EnemyAttack40:
EnemyAttack41:
EnemyAttack42:
EnemyAttack43:
EnemyAttack44:
EnemyAttack45:
EnemyAttack46:
EnemyAttack47:
EnemyAttack48:
.byte $92,$96,$99,$FF,$99,$9E,$97,$8C,$91,$00 ; IMP PUNCH









lut_EquipmentNames_Low:
.byte <Weapon1      ; 0  ; Wooden Nunchuck
.byte <Weapon2      ; 1  ; Small Knife
.byte <Weapon3      ; 2  ; Wooden Staff
.byte <Weapon4      ; 3  ; Rapier
.byte <Weapon5      ; 4  ; Iron Hammer
.byte <Weapon6      ; 5  ; Short Sword
.byte <Weapon7      ; 6  ; Hand Axe
.byte <Weapon8      ; 7  ; Scimitar
.byte <Weapon9      ; 8  ; Iron Nunchucks
.byte <Weapon10     ; 9  ; Large Knife
.byte <Weapon11     ; A  ; Iron Staff
.byte <Weapon12     ; B  ; Sabre
.byte <Weapon13     ; C  ; Long Sword
.byte <Weapon14     ; D  ; Great Axe
.byte <Weapon15     ; E  ; Falchion
.byte <Weapon16     ; F  ; Silver Knife
.byte <Weapon17     ; 10 ; Silver Sword
.byte <Weapon18     ; 11 ; Silver Hammer
.byte <Weapon19     ; 12 ; Silver Axe
.byte <Weapon20     ; 13 ; Flame Sword
.byte <Weapon21     ; 14 ; Ice Sword
.byte <Weapon22     ; 15 ; Dragon Sword
.byte <Weapon23     ; 16 ; Giant Sword
.byte <Weapon24     ; 17 ; Sun Sword
.byte <Weapon25     ; 18 ; Coral Sword
.byte <Weapon26     ; 19 ; Were Sword
.byte <Weapon27     ; 1A ; Rune Sword
.byte <Weapon28     ; 1B ; Power Staff
.byte <Weapon29     ; 1C ; Light Axe
.byte <Weapon30     ; 1D ; Heal Staff
.byte <Weapon31     ; 1E ; Mage Staff
.byte <Weapon32     ; 1F ; Defense Sword
.byte <Weapon33     ; 20 ; Wizard Staff
.byte <Weapon34     ; 21 ; Vorpal Sword
.byte <Weapon35     ; 22 ; CatClaw
.byte <Weapon36     ; 23 ; Thor Hammer
.byte <Weapon37     ; 24 ; Bane Sword
.byte <Weapon38     ; 25 ; Katana
.byte <Weapon39     ; 26 ; Excalibur
.byte <Weapon40     ; 27 ; Masamune
.byte <Weapon41     ; 28 ; Chicken Knife
.byte <Weapon42     ; 29 ; Brave Blade
.byte <Weapon43     ; 2A
.byte <Weapon44     ; 2B
.byte <Weapon45     ; 2C
.byte <Weapon46     ; 2D
.byte <Weapon47     ; 2E
.byte <Weapon48     ; 2F
.byte <Weapon49     ; 30
.byte <Weapon50     ; 31
.byte <Weapon51     ; 32
.byte <Weapon52     ; 33
.byte <Weapon53     ; 34
.byte <Weapon54     ; 35
.byte <Weapon55     ; 36
.byte <Weapon56     ; 37
.byte <Weapon57     ; 38
.byte <Weapon58     ; 39
.byte <Weapon59     ; 3A
.byte <Weapon60     ; 3B
.byte <Weapon61     ; 3C
.byte <Weapon62     ; 3D
.byte <Weapon63     ; 3E
.byte <Weapon64     ; 3F
.byte <Armor1       ; 40  ; Cloth T
.byte <Armor2       ; 41  ; Wooden Armor
.byte <Armor3       ; 42  ; Chain Armor
.byte <Armor4       ; 43  ; Iron Armor
.byte <Armor5       ; 44  ; Steel Armor
.byte <Armor6       ; 45  ; Silver Armor
.byte <Armor7       ; 46  ; Flame Armor
.byte <Armor8       ; 47  ; Ice Armor
.byte <Armor9       ; 48  ; Opal Armor
.byte <Armor10      ; 49  ; Dragon Armor
.byte <Armor11      ; 4A  ; Copper Q
.byte <Armor12      ; 4B  ; Silver Q
.byte <Armor13      ; 4C  ; Gold Q
.byte <Armor14      ; 4D  ; Opal Q
.byte <Armor15      ; 4E  ; White T
.byte <Armor16      ; 4F  ; Black T
.byte <Armor17      ; 50  ; Wooden Shield
.byte <Armor18      ; 51  ; Iron Shield
.byte <Armor19      ; 52  ; Silver Shield
.byte <Armor20      ; 53  ; Flame Shield
.byte <Armor21      ; 54  ; Ice Shield
.byte <Armor22      ; 55  ; Opal Shield
.byte <Armor23      ; 56  ; Aegis Shield
.byte <Armor24      ; 57  ; Buckler
.byte <Armor25      ; 58  ; Protect Cape
.byte <Armor26      ; 59  ; Cap
.byte <Armor27      ; 5A  ; Wooden Helm
.byte <Armor28      ; 5B  ; Iron Helm
.byte <Armor29      ; 5C  ; Silver Helm
.byte <Armor30      ; 5D  ; Opal Helm
.byte <Armor31      ; 5E  ; Heal Helm
.byte <Armor32      ; 5F  ; Ribbon
.byte <Armor33      ; 60  ; Gloves
.byte <Armor34      ; 61  ; Copper Gauntlet
.byte <Armor35      ; 62  ; Iron Gauntlet
.byte <Armor36      ; 63  ; Silver Gauntlet
.byte <Armor37      ; 64  ; Zeus Gauntlet
.byte <Armor38      ; 65  ; Power Gauntlet
.byte <Armor39      ; 66  ; Opal Gauntlet
.byte <Armor40      ; 67  ; Protect Ring
.byte <Armor41      ; 68
.byte <Armor42      ; 69
.byte <Armor43      ; 6A
.byte <Armor44      ; 6B
.byte <Armor45      ; 6C
.byte <Armor46      ; 6D
.byte <Armor47      ; 6E
.byte <Armor48      ; 6F
.byte <Armor49      ; 70
.byte <Armor50      ; 71
.byte <Armor51      ; 72
.byte <Armor52      ; 73
.byte <Armor53      ; 74
.byte <Armor54      ; 75
.byte <Armor55      ; 76
.byte <Armor56      ; 77
.byte <Armor57      ; 78
.byte <Armor58      ; 79
.byte <Armor59      ; 7A
.byte <Armor60      ; 7B
.byte <Armor61      ; 7C
.byte <Armor62      ; 7D
.byte <Armor63      ; 7E
.byte <Armor64      ; 7F

lut_EquipmentNames_High:
.byte >Weapon1      ; 0  ; Wooden Nunchuck
.byte >Weapon2      ; 1  ; Small Knife
.byte >Weapon3      ; 2  ; Wooden Staff
.byte >Weapon4      ; 3  ; Rapier
.byte >Weapon5      ; 4  ; Iron Hammer
.byte >Weapon6      ; 5  ; Short Sword
.byte >Weapon7      ; 6  ; Hand Axe
.byte >Weapon8      ; 7  ; Scimitar
.byte >Weapon9      ; 8  ; Iron Nunchucks
.byte >Weapon10     ; 9  ; Large Knife
.byte >Weapon11     ; A  ; Iron Staff
.byte >Weapon12     ; B  ; Sabre
.byte >Weapon13     ; C  ; Long Sword
.byte >Weapon14     ; D  ; Great Axe
.byte >Weapon15     ; E  ; Falchion
.byte >Weapon16     ; F  ; Silver Knife
.byte >Weapon17     ; 10 ; Silver Sword
.byte >Weapon18     ; 11 ; Silver Hammer
.byte >Weapon19     ; 12 ; Silver Axe
.byte >Weapon20     ; 13 ; Flame Sword
.byte >Weapon21     ; 14 ; Ice Sword
.byte >Weapon22     ; 15 ; Dragon Sword
.byte >Weapon23     ; 16 ; Giant Sword
.byte >Weapon24     ; 17 ; Sun Sword
.byte >Weapon25     ; 18 ; Coral Sword
.byte >Weapon26     ; 19 ; Were Sword
.byte >Weapon27     ; 1A ; Rune Sword
.byte >Weapon28     ; 1B ; Power Staff
.byte >Weapon29     ; 1C ; Light Axe
.byte >Weapon30     ; 1D ; Heal Staff
.byte >Weapon31     ; 1E ; Mage Staff
.byte >Weapon32     ; 1F ; Defense Sword
.byte >Weapon33     ; 20 ; Wizard Staff
.byte >Weapon34     ; 21 ; Vorpal Sword
.byte >Weapon35     ; 22 ; CatClaw
.byte >Weapon36     ; 23 ; Thor Hammer
.byte >Weapon37     ; 24 ; Bane Sword
.byte >Weapon38     ; 25 ; Katana
.byte >Weapon39     ; 26 ; Excalibur
.byte >Weapon40     ; 27 ; Masamune
.byte >Weapon41     ; 28 ; Chicken Knife
.byte >Weapon42     ; 29 ; Brave Blade
.byte >Weapon43     ; 2A
.byte >Weapon44     ; 2B
.byte >Weapon45     ; 2C
.byte >Weapon46     ; 2D
.byte >Weapon47     ; 2E
.byte >Weapon48     ; 2F
.byte >Weapon49     ; 30
.byte >Weapon50     ; 31
.byte >Weapon51     ; 32
.byte >Weapon52     ; 33
.byte >Weapon53     ; 34
.byte >Weapon54     ; 35
.byte >Weapon55     ; 36
.byte >Weapon56     ; 37
.byte >Weapon57     ; 38
.byte >Weapon58     ; 39
.byte >Weapon59     ; 3A
.byte >Weapon60     ; 3B
.byte >Weapon61     ; 3C
.byte >Weapon62     ; 3D
.byte >Weapon63     ; 3E
.byte >Weapon64     ; 3F
.byte >Armor1       ; 40  ; Cloth T
.byte >Armor2       ; 41  ; Wooden Armor
.byte >Armor3       ; 42  ; Chain Armor
.byte >Armor4       ; 43  ; Iron Armor
.byte >Armor5       ; 44  ; Steel Armor
.byte >Armor6       ; 45  ; Silver Armor
.byte >Armor7       ; 46  ; Flame Armor
.byte >Armor8       ; 47  ; Ice Armor
.byte >Armor9       ; 48  ; Opal Armor
.byte >Armor10      ; 49  ; Dragon Armor
.byte >Armor11      ; 4A  ; Copper Q
.byte >Armor12      ; 4B  ; Silver Q
.byte >Armor13      ; 4C  ; Gold Q
.byte >Armor14      ; 4D  ; Opal Q
.byte >Armor15      ; 4E  ; White T
.byte >Armor16      ; 4F  ; Black T
.byte >Armor17      ; 50  ; Wooden Shield
.byte >Armor18      ; 51  ; Iron Shield
.byte >Armor19      ; 52  ; Silver Shield
.byte >Armor20      ; 53  ; Flame Shield
.byte >Armor21      ; 54  ; Ice Shield
.byte >Armor22      ; 55  ; Opal Shield
.byte >Armor23      ; 56  ; Aegis Shield
.byte >Armor24      ; 57  ; Buckler
.byte >Armor25      ; 58  ; Protect Cape
.byte >Armor26      ; 59  ; Cap
.byte >Armor27      ; 5A  ; Wooden Helm
.byte >Armor28      ; 5B  ; Iron Helm
.byte >Armor29      ; 5C  ; Silver Helm
.byte >Armor30      ; 5D  ; Opal Helm
.byte >Armor31      ; 5E  ; Heal Helm
.byte >Armor32      ; 5F  ; Ribbon
.byte >Armor33      ; 60  ; Gloves
.byte >Armor34      ; 61  ; Copper Gauntlet
.byte >Armor35      ; 62  ; Iron Gauntlet
.byte >Armor36      ; 63  ; Silver Gauntlet
.byte >Armor37      ; 64  ; Zeus Gauntlet
.byte >Armor38      ; 65  ; Power Gauntlet
.byte >Armor39      ; 66  ; Opal Gauntlet
.byte >Armor40      ; 67  ; Protect Ring
.byte >Armor41      ; 68
.byte >Armor42      ; 69
.byte >Armor43      ; 6A
.byte >Armor44      ; 6B
.byte >Armor45      ; 6C
.byte >Armor46      ; 6D
.byte >Armor47      ; 6E
.byte >Armor48      ; 6F
.byte >Armor49      ; 70
.byte >Armor50      ; 71
.byte >Armor51      ; 72
.byte >Armor52      ; 73
.byte >Armor53      ; 74
.byte >Armor54      ; 75
.byte >Armor55      ; 76
.byte >Armor56      ; 77
.byte >Armor57      ; 78
.byte >Armor58      ; 79
.byte >Armor59      ; 7A
.byte >Armor60      ; 7B
.byte >Armor61      ; 7C
.byte >Armor62      ; 7D
.byte >Armor63      ; 7E
.byte >Armor64      ; 7F

;; WEAPONS AND ARMORS
;; Note that the names I wrote by the bytes are not exactly what the bytes say
;; as I've tried to do in the other lists. Since I didn't edit anything that I can remember... it should all be vanilla.
;; so the names are fancy!

Weapon1: ; 00
.byte $A0,$B2,$B2,$A7,$A8,$B1,$D9,$FF,$00 ; Wooden Nunchucks
Weapon2: ; 01
.byte $9C,$B0,$A4,$AF,$AF,$FF,$D6,$FF,$00 ; Small Knife
Weapon3: ; 02
.byte $A0,$B2,$B2,$A7,$A8,$B1,$D8,$FF,$00 ; Wooden Staff
Weapon4: ; 03
.byte $9B,$A4,$B3,$AC,$A8,$B5,$FF,$FF,$00 ; Rapier
Weapon5: ; 04
.byte $92,$B5,$B2,$B1,$FF,$FF,$D5,$FF,$00 ; Iron Hammer
Weapon6: ; 05
.byte $9C,$AB,$B2,$B5,$B7,$FF,$D4,$FF,$00 ; Short Sword
Weapon7: ; 06
.byte $91,$A4,$B1,$A7,$FF,$FF,$D7,$FF,$00 ; Hand Axe
Weapon8: ; 07
.byte $9C,$A6,$AC,$B0,$B7,$A4,$B5,$FF,$00 ; Scimitar
Weapon9: ; 08
.byte $92,$B5,$B2,$B1,$FF,$FF,$D9,$FF,$00 ; Iron Nunchucks
Weapon10: ; 09
.byte $95,$A4,$B5,$AA,$A8,$FF,$D6,$FF,$00 ; Large Knife
Weapon11: ; 0A
.byte $92,$B5,$B2,$B1,$FF,$FF,$D8,$FF,$00 ; Iron Staff
Weapon12: ; 0B
.byte $9C,$A4,$A5,$B5,$A8,$FF,$FF,$FF,$00 ; Sabre
Weapon13: ; 0C
.byte $95,$B2,$B1,$AA,$FF,$FF,$D4,$FF,$00 ; Long Sword
Weapon14: ; 0D
.byte $90,$B5,$A8,$A4,$B7,$FF,$D7,$FF,$00 ; Great Axe
Weapon15: ; 0E
.byte $8F,$A4,$AF,$A6,$AB,$B2,$B1,$FF,$00 ; Falchion
Weapon16: ; 0F
.byte $9C,$AC,$AF,$B9,$A8,$B5,$D6,$FF,$00 ; Silver Knife
Weapon17: ; 10
.byte $9C,$AC,$AF,$B9,$A8,$B5,$D4,$FF,$00 ; Silver Sword
Weapon18: ; 11
.byte $9C,$AC,$AF,$B9,$A8,$B5,$D5,$FF,$00 ; Silver Hammer
Weapon19: ; 12
.byte $9C,$AC,$AF,$B9,$A8,$B5,$D7,$FF,$00 ; Silver Axe
Weapon20: ; 13
.byte $8F,$AF,$A4,$B0,$A8,$FF,$D4,$FF,$00 ; Flame Sword
Weapon21: ; 14
.byte $92,$A6,$A8,$FF,$FF,$FF,$D4,$FF,$00 ; Ice Sword
Weapon22: ; 15
.byte $8D,$B5,$A4,$AA,$B2,$B1,$D4,$FF,$00 ; Dragon Sword
Weapon23: ; 16
.byte $90,$AC,$A4,$B1,$B7,$FF,$D4,$FF,$00 ; Giant Sword
Weapon24: ; 17
.byte $9C,$B8,$B1,$FF,$FF,$FF,$D4,$FF,$00 ; Sun Sword
Weapon25: ; 18
.byte $8C,$B2,$B5,$A4,$AF,$FF,$D4,$FF,$00 ; Coral Sword
Weapon26: ; 19
.byte $A0,$A8,$B5,$A8,$FF,$FF,$D4,$FF,$00 ; Were Sword
Weapon27: ; 1A
.byte $9B,$B8,$B1,$A8,$FF,$FF,$D4,$FF,$00 ; Rune Sword
Weapon28: ; 1B
.byte $99,$B2,$BA,$A8,$B5,$FF,$D8,$FF,$00 ; Power Staff
Weapon29: ; 1C
.byte $95,$AC,$AA,$AB,$B7,$FF,$D7,$FF,$00 ; Light Axe
Weapon30: ; 1D
.byte $91,$A8,$A4,$AF,$FF,$FF,$D8,$FF,$00 ; Heal Staff
Weapon31: ; 1E
.byte $96,$A4,$AA,$A8,$FF,$FF,$D8,$FF,$00 ; Mage Staff
Weapon32: ; 1F
.byte $8D,$A8,$A9,$A8,$B1,$B6,$A8,$FF,$00 ; Defense Sword
Weapon33: ; 20
.byte $A0,$AC,$BD,$A4,$B5,$A7,$D8,$FF,$00 ; Wizard Staff
Weapon34: ; 21
.byte $9F,$B2,$B5,$B3,$A4,$AF,$FF,$FF,$00 ; Vorpal Sword
Weapon35: ; 22
.byte $8C,$A4,$B7,$8C,$AF,$A4,$BA,$FF,$00 ; CatClaw
Weapon36: ; 23
.byte $9D,$AB,$B2,$B5,$FF,$FF,$D5,$FF,$00 ; Thor Hammer
Weapon37: ; 24
.byte $8B,$A4,$B1,$A8,$FF,$FF,$D4,$FF,$00 ; Bane Sword
Weapon38: ; 25
.byte $94,$A4,$B7,$A4,$B1,$A4,$FF,$FF,$00 ; Katana
Weapon39: ; 26
.byte $A1,$A6,$A4,$AF,$A5,$A8,$B5,$FF,$00 ; Excalibur
Weapon40: ; 27
.byte $96,$A4,$B6,$B0,$B8,$B1,$A8,$FF,$00 ; Masamune
Weapon41: ; 28
.byte $8C,$AB,$AC,$A6,$AE,$A8,$B1,$D6,$00 ; Chicken Knife
Weapon42: ; 29
.byte $8B,$B5,$A4,$B9,$A8,$FF,$D4,$FF,$00 ; Brave Blade
Weapon43: ; 2A
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$00
Weapon44: ; 2B
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$00
Weapon45: ; 2C
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$00
Weapon46: ; 2D
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$00
Weapon47: ; 2E
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$00
Weapon48: ; 2F
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$00
Weapon49: ; 30
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$00
Weapon50: ; 31
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$00
Weapon51: ; 32
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$00
Weapon52: ; 33
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$00
Weapon53: ; 34
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$00
Weapon54: ; 35
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$00
Weapon55: ; 36
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$00
Weapon56: ; 37
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$00
Weapon57: ; 38
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$00
Weapon58: ; 39
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$00
Weapon59: ; 3A
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$00
Weapon60: ; 3B
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$00
Weapon61: ; 3C
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$00
Weapon62: ; 3D
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$00
Weapon63: ; 3E
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$00
Weapon64: ; 3F
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$00

Armor1: ; 40
.byte $8C,$AF,$B2,$B7,$AB,$FF,$FF,$FF,$00 ; Cloth T
Armor2: ; 41
.byte $A0,$B2,$B2,$A7,$A8,$B1,$DA,$FF,$00 ; Wooden Armor
Armor3: ; 42
.byte $8C,$AB,$A4,$AC,$B1,$FF,$DA,$FF,$00 ; Chain Armor
Armor4: ; 43
.byte $92,$B5,$B2,$B1,$FF,$FF,$DA,$FF,$00 ; Iron Armor
Armor5: ; 44
.byte $9C,$B7,$A8,$A8,$AF,$FF,$DA,$FF,$00 ; Steel Armor
Armor6: ; 45
.byte $9C,$AC,$AF,$B9,$A8,$B5,$DA,$FF,$00 ; Silver Armor
Armor7: ; 46
.byte $8F,$AF,$A4,$B0,$A8,$FF,$DA,$FF,$00 ; Flame Armor
Armor8: ; 47
.byte $92,$A6,$A8,$FF,$FF,$FF,$DA,$FF,$00 ; Ice Armor
Armor9: ; 48
.byte $98,$B3,$A4,$AF,$FF,$FF,$DA,$FF,$00 ; Opal Armor
Armor10: ; 49
.byte $8D,$B5,$A4,$AA,$B2,$B1,$DA,$FF,$00 ; Dragon Armor
Armor11: ; 4A
.byte $8C,$B2,$B3,$B3,$A8,$B5,$DE,$FF,$00 ; Copper Q
Armor12: ; 4B
.byte $9C,$AC,$AF,$B9,$A8,$B5,$DE,$FF,$00 ; Silver Q
Armor13: ; 4C
.byte $90,$B2,$AF,$A7,$FF,$FF,$DE,$FF,$00 ; Gold Q
Armor14: ; 4D
.byte $98,$B3,$A4,$AF,$FF,$FF,$DE,$FF,$00 ; Opal Q
Armor15: ; 4E
.byte $A0,$AB,$AC,$B7,$A8,$FF,$DF,$FF,$00 ; White T
Armor16: ; 4F
.byte $8B,$AF,$A4,$A6,$AE,$FF,$DF,$FF,$00 ; Black T
Armor17: ; 50
.byte $A0,$B2,$B2,$A7,$A8,$B1,$DB,$FF,$00 ; Wooden Shield
Armor18: ; 51
.byte $92,$B5,$B2,$B1,$FF,$FF,$DB,$FF,$00 ; Iron Shield
Armor19: ; 52
.byte $9C,$AC,$AF,$B9,$A8,$B5,$DB,$FF,$00 ; Silver Shield
Armor20: ; 53
.byte $8F,$AF,$A4,$B0,$A8,$FF,$DB,$FF,$00 ; Flame Shield
Armor21: ; 54
.byte $92,$A6,$A8,$FF,$FF,$FF,$DB,$FF,$00 ; Ice Shield
Armor22: ; 55
.byte $98,$B3,$A4,$AF,$FF,$FF,$DB,$FF,$00 ; Opal Shield
Armor23: ; 56
.byte $8A,$A8,$AA,$AC,$B6,$FF,$DB,$FF,$00 ; Aegis Shield
Armor24: ; 57
.byte $8B,$B8,$A6,$AE,$AF,$A8,$B5,$FF,$00 ; Buckler
Armor25: ; 58
.byte $99,$B5,$B2,$8C,$A4,$B3,$A8,$FF,$00 ; Protect Cape
Armor26: ; 59
.byte $8C,$A4,$B3,$FF,$FF,$FF,$FF,$FF,$00 ; Cap
Armor27: ; 5A
.byte $A0,$B2,$B2,$A7,$A8,$B1,$DC,$FF,$00 ; Wooden Helm
Armor28: ; 5B
.byte $92,$B5,$B2,$B1,$FF,$FF,$DC,$FF,$00 ; Iron Helm
Armor29: ; 5C
.byte $9C,$AC,$AF,$B9,$A8,$B5,$DC,$FF,$00 ; Silver Helm
Armor30: ; 5D
.byte $98,$B3,$A4,$AF,$FF,$FF,$DC,$FF,$00 ; Opal Helm
Armor31: ; 5E
.byte $91,$A8,$A4,$AF,$FF,$FF,$DC,$FF,$00 ; Heal Helm
Armor32: ; 5F
.byte $9B,$AC,$A5,$A5,$B2,$B1,$FF,$FF,$00 ; Ribbon
Armor33: ; 60
.byte $90,$AF,$B2,$B9,$A8,$B6,$FF,$FF,$00 ; Gloves
Armor34: ; 61
.byte $8C,$B2,$B3,$B3,$A8,$B5,$DD,$FF,$00 ; Copper Gauntlet
Armor35: ; 62
.byte $92,$B5,$B2,$B1,$FF,$FF,$DD,$FF,$00 ; Iron Gauntlet
Armor36: ; 63
.byte $9C,$AC,$AF,$B9,$A8,$B5,$DD,$FF,$00 ; Silver Gauntlet
Armor37: ; 64
.byte $A3,$A8,$B8,$B6,$FF,$FF,$DD,$FF,$00 ; Zeus Gauntlet
Armor38: ; 65
.byte $99,$B2,$BA,$A8,$B5,$FF,$DD,$FF,$00 ; Power Gauntlet
Armor39: ; 66
.byte $98,$B3,$A4,$AF,$FF,$FF,$DD,$FF,$00 ; Opal Gauntlet
Armor40: ; 67
.byte $99,$B5,$B2,$9B,$AC,$B1,$AA,$FF,$00 ; Protect Ring
Armor41: ; 68
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$00
Armor42: ; 69
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$00
Armor43: ; 6A
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$00
Armor44: ; 6B
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$00
Armor45: ; 6C
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$00
Armor46: ; 6D
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$00
Armor47: ; 6E
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$00
Armor48: ; 6F
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$00
Armor49: ; 70
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$00
Armor50: ; 71
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$00
Armor51: ; 72
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$00
Armor52: ; 73
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$00
Armor53: ; 74
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$00
Armor54: ; 75
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$00
Armor55: ; 76
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$00
Armor56: ; 77
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$00
Armor57: ; 78
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$00
Armor58: ; 79
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$00
Armor59: ; 7A
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$00
Armor60: ; 7B
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$00
Armor61: ; 7C
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$00
Armor62: ; 7D
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$00
Armor63: ; 7E
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$00
Armor64: ; 7F
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$00












lut_PriceTable_High:
.byte >WeaponArmorPrices
.byte >WeaponArmorPrices
.byte >MagicPrices
.byte >MagicPrices
.byte >MagicPrices
.byte >MagicPrices
.byte >ItemPrices
.byte >ItemPrices
.byte >GoldPrices

lut_PriceTable_Low:
.byte <WeaponArmorPrices
.byte <WeaponArmorPrices
.byte <MagicPrices
.byte <MagicPrices
.byte <MagicPrices
.byte <MagicPrices
.byte <ItemPrices
.byte <ItemPrices
.byte <GoldPrices


;; Don't go over 65535! (keep prices within 2 bytes.)
;; 297000 - the cost of 99 houses... for reference...
;; but shops can handle more than 2 bytes of price
;.ALIGN  $100

ItemPrices:
;.word 0       ; 00 START ;; - item price checks subtract 1 from the item ID
.word 60      ; 01 HEAL
.word 2500    ; 02 X-HEAL
.word 5000    ; 03 ETHER
.word 50000   ; 04 ELIXIR
.word 75      ; 05 PURE
.word 800     ; 06 SOFT
.word 20000   ; 07 PHOENIX DOWN
.word 75      ; 08 TENT
.word 250     ; 09 CABIN
.word 3000    ; 0A HOUSE
.word 200     ; 0B EYEDROP
.word 2000    ; 0C SMOKEBOMB
.word 750     ; 0D ALARMCLOCK
.word 0       ; 0F nothing
.word 0       ; 0F nothing

;; key items
.word 0       ; 10 LUTE
.word 0       ; 11 CROWN
.word 0       ; 12 CRYSTAL
.word 0       ; 13 HERB
.word 0       ; 14 KEY
.word 0       ; 15 TNT
.word 0       ; 16 ADAMANT
.word 0       ; 17 SLAB
.word 0       ; 18 RUBY
.word 0       ; 19 ROD
.word 0       ; 1A FLOATER
.word 0       ; 1B CHIME
.word 0       ; 1C TAIL
.word 0       ; 1D CUBE
.word 50000   ; 1E BOTTLE
.word 0       ; 1F OXYALE
.word 0       ; 20 CANOE
.word 5000    ; 21 LEWDS
.word 5000    ; 22 ??? Book
.word 0       ; 23 nothing
.word 0       ; 24 nothing
.word 0       ; 25 nothing
.word 0       ; 26 nothing
.word 0       ; 27 nothing
.word 0       ; 28 nothing
.word 0       ; 29 nothing
.word 0       ; 2A nothing
.word 0       ; 2B nothing
.word 0       ; 2C ORB 1
.word 0       ; 2D ORB 2
.word 0       ; 2E ORB 3
.word 0       ; 2F ORB 4

;; Skill prices
.word 0       ; 30
.word 0       ; 31
.word 0       ; 32
.word 0       ; 33
.word 0       ; 34
.word 0       ; 35
.word 0       ; 36
.word 0       ; 37
.word 0       ; 38
.word 0       ; 39
.word 0       ; 3A
.word 0       ; 3B
.word 0       ; 3C
.word 0       ; 3D
.word 0       ; 3E
.word 0       ; 3F
.word 0       ; 40
.word 0       ; 41
.word 0       ; 42
.word 0       ; 43
.word 0       ; 44
.word 0       ; 45
.word 0       ; 46
.word 0       ; 47
.word 0       ; 48
.word 0       ; 49
.word 0       ; 4A
.word 0       ; 4B
.word 0       ; 4C
.word 0       ; 4D
.word 0       ; 4E
.word 0       ; 4F


MagicPrices:
;; magic
.word 100
.word 400
.word 1500
.word 4000
.word 8000
.word 20000
.word 45000
.word 60000


;.byte $64,$00 ; Level 1 Magic
;.byte $64,$00
;.byte $64,$00
;.byte $64,$00
;.byte $64,$00
;.byte $64,$00
;.byte $64,$00
;.byte $64,$00
;.byte $90,$01 ; Level 2 Magic
;.byte $90,$01
;.byte $90,$01
;.byte $90,$01
;.byte $90,$01
;.byte $90,$01
;.byte $90,$01
;.byte $90,$01
;.byte $DC,$05 ; Level 3 Magic
;.byte $DC,$05
;.byte $DC,$05
;.byte $DC,$05
;.byte $DC,$05
;.byte $DC,$05
;.byte $DC,$05
;.byte $DC,$05
;.byte $A0,$0F ; Level 4 Magic
;.byte $A0,$0F
;.byte $A0,$0F
;.byte $A0,$0F
;.byte $A0,$0F
;.byte $A0,$0F
;.byte $A0,$0F
;.byte $A0,$0F
;.byte $40,$1F ; Level 5 Magic
;.byte $40,$1F
;.byte $40,$1F
;.byte $40,$1F
;.byte $40,$1F
;.byte $40,$1F
;.byte $40,$1F
;.byte $40,$1F
;.byte $20,$4E ; Level 6 Magic
;.byte $20,$4E
;.byte $20,$4E
;.byte $20,$4E
;.byte $20,$4E
;.byte $20,$4E
;.byte $20,$4E
;.byte $20,$4E
;.byte $C8,$AF ; Level 7 Magic
;.byte $C8,$AF
;.byte $C8,$AF
;.byte $C8,$AF
;.byte $C8,$AF
;.byte $C8,$AF
;.byte $C8,$AF
;.byte $C8,$AF
;.byte $60,$EA ; Level 8 Magic
;.byte $60,$EA
;.byte $60,$EA
;.byte $60,$EA
;.byte $60,$EA
;.byte $60,$EA
;.byte $60,$EA
;.byte $60,$EA


;; gold in chests
;            ; chest number
GoldPrices:    ; item ID (not price ID)
.word  10    ; 1  ; $00
.word  20    ; 2  ; $01
.word  25    ; 3  ; $02
.word  30    ; 4  ; $03
.word  55    ; 5  ; $04
.word  70    ; 6  ; $05
.word  85    ; 7  ; $06
.word  110   ; 8  ; $07
.word  135   ; 9  ; $08
.word  155   ; 10 ; $09
.word  160   ; 11 ; $0A
.word  180   ; 12 ; $0B
.word  240   ; 13 ; $0C
.word  255   ; 14 ; $0D
.word  260   ; 15 ; $0E
.word  295   ; 16 ; $0F
.word  300   ; 17 ; $10
.word  315   ; 18 ; $11
.word  330   ; 19 ; $12
.word  350   ; 20 ; $13
.word  385   ; 21 ; $14
.word  400   ; 22 ; $15
.word  450   ; 23 ; $16
.word  500   ; 24 ; $17
.word  530   ; 25 ; $18
.word  575   ; 26 ; $19
.word  620   ; 27 ; $1A
.word  680   ; 28 ; $1B
.word  750   ; 29 ; $1C
.word  795   ; 30 ; $1D
.word  880   ; 31 ; $1E
.word  1020  ; 32 ; $1F
.word  1250  ; 33 ; $20
.word  1455  ; 34 ; $21
.word  1520  ; 35 ; $22
.word  1760  ; 36 ; $23
.word  1975  ; 37 ; $24
.word  2000  ; 38 ; $25
.word  2750  ; 39 ; $26
.word  3400  ; 40 ; $27
.word  4150  ; 41 ; $28
.word  5000  ; 42 ; $29
.word  5450  ; 43 ; $2A
.word  6400  ; 44 ; $2B
.word  6720  ; 45 ; $2C
.word  7340  ; 46 ; $2D
.word  7690  ; 47 ; $2E
.word  7900  ; 48 ; $2F
.word  8135  ; 49 ; $30
.word  9000  ; 50 ; $31
.word  9300  ; 51 ; $32
.word  9500  ; 52 ; $33
.word  9900  ; 53 ; $34
.word  10000 ; 54 ; $35
.word  12350 ; 55 ; $36
.word  13000 ; 56 ; $37
.word  13450 ; 57 ; $38
.word  14050 ; 58 ; $39
.word  14720 ; 59 ; $3A
.word  15000 ; 60 ; $3B
.word  17490 ; 61 ; $3C
.word  18010 ; 62 ; $3D
.word  19990 ; 63 ; $3E
.word  20000 ; 64 ; $3F
.word  20010 ; 65 ; $40
.word  26000 ; 66 ; $41
.word  45000 ; 67 ; $42
.word  65000 ; 68 ; $43
.word  65000 ; 69 ; $44
.word  65000 ; 70 ; $45
.word  65000 ; 71 ; $46
.word  65000 ; 72 ; $47
.word  65000 ; 73 ; $48
.word  65000 ; 74 ; $49
.word  65000 ; 75 ; $4A
.word  65000 ; 76 ; $4B
.word  65000 ; 77 ; $4C
.word  65000 ; 78 ; $4D
.word  65000 ; 79 ; $4E
.word  65000 ; 80 ; $4F

;.ALIGN  $100

WeaponArmorPrices:
.word 10    ; $0A,$00 ; Weapon 1
.word 5     ; $05,$00 ; Weapon 2
.word 5     ; $05,$00 ; Weapon 3
.word 10    ; $0A,$00 ; Weapon 4
.word 10    ; $0A,$00 ; Weapon 5
.word 550   ; $26,$02 ; Weapon 6
.word 550   ; $26,$02 ; Weapon 7
.word 200   ; $C8,$00 ; Weapon 8
.word 200   ; $C8,$00 ; Weapon 9
.word 175   ; $AF,$00 ; Weapon 10
.word 200   ; $C8,$00 ; Weapon 11
.word 450   ; $C2,$01 ; Weapon 12
.word 1500  ; $DC,$05 ; Weapon 13
.word 2000  ; $D0,$07 ; Weapon 14
.word 450   ; $C2,$01 ; Weapon 15
.word 800   ; $20,$03 ; Weapon 16
.word 4000  ; $A0,$0F ; Weapon 17
.word 2500  ; $C4,$09 ; Weapon 18
.word 4500  ; $94,$11 ; Weapon 19
.word 10000 ; $10,$27 ; Weapon 20
.word 15000 ; $98,$3A ; Weapon 21
.word 8000  ; $40,$1F ; Weapon 22
.word 8000  ; $40,$1F ; Weapon 23
.word 20000 ; $20,$4E ; Weapon 24
.word 8000  ; $40,$1F ; Weapon 25
.word 6000  ; $70,$17 ; Weapon 26
.word 5000  ; $88,$13 ; Weapon 27
.word 12345 ; $39,$30 ; Weapon 28
.word 10000 ; $10,$27 ; Weapon 29
.word 25000 ; $A8,$61 ; Weapon 30
.word 25000 ; $A8,$61 ; Weapon 31
.word 40000 ; $40,$9C ; Weapon 32
.word 50000 ; $50,$C3 ; Weapon 33
.word 30000 ; $30,$75 ; Weapon 34
.word 65000 ; $E8,$FD ; Weapon 35
.word 40000 ; $40,$9C ; Weapon 36
.word 60000 ; $60,$EA ; Weapon 37
.word 60000 ; $60,$EA ; Weapon 38
.word 60000 ; $60,$EA ; Weapon 39
.word 60000 ; $60,$EA ; Weapon 40
.word 2     ; $00,$00 ; Weapon 41
.word 2     ; $00,$00 ; Weapon 42
.word 0     ; $00,$00 ; Weapon 43
.word 0     ; $00,$00 ; Weapon 44
.word 0     ; $00,$00 ; Weapon 45
.word 0     ; $00,$00 ; Weapon 46
.word 0     ; $00,$00 ; Weapon 47
.word 0     ; $00,$00 ; Weapon 48
.word 0     ; $00,$00 ; Weapon 49
.word 0     ; $00,$00 ; Weapon 50
.word 0     ; $00,$00 ; Weapon 51
.word 0     ; $00,$00 ; Weapon 52
.word 0     ; $00,$00 ; Weapon 53
.word 0     ; $00,$00 ; Weapon 54
.word 0     ; $00,$00 ; Weapon 55
.word 0     ; $00,$00 ; Weapon 56
.word 0     ; $00,$00 ; Weapon 57
.word 0     ; $00,$00 ; Weapon 58
.word 0     ; $00,$00 ; Weapon 59
.word 0     ; $00,$00 ; Weapon 60
.word 0     ; $00,$00 ; Weapon 61
.word 0     ; $00,$00 ; Weapon 62
.word 0     ; $00,$00 ; Weapon 63
.word 0     ; $00,$00 ; Weapon 64

.word 10    ; $0A,$00 ; Armor 1
.word 50    ; $32,$00 ; Armor 2
.word 80    ; $50,$00 ; Armor 3
.word 800   ; $20,$03 ; Armor 4
.word 45000 ; $C8,$AF ; Armor 5
.word 7500  ; $4C,$1D ; Armor 6
.word 30000 ; $30,$75 ; Armor 7
.word 30000 ; $30,$75 ; Armor 8
.word 60000 ; $60,$EA ; Armor 9
.word 60000 ; $60,$EA ; Armor 10
.word 1000  ; $E8,$03 ; Armor 11
.word 5000  ; $88,$13 ; Armor 12
.word 50000 ; $50,$C3 ; Armor 13
.word 65000 ; $E8,$FD ; Armor 14
.word 2     ; $02,$00 ; Armor 15
.word 2     ; $02,$00 ; Armor 16
.word 15    ; $0F,$00 ; Armor 17
.word 100   ; $64,$00 ; Armor 18
.word 2500  ; $C4,$09 ; Armor 19
.word 10000 ; $10,$27 ; Armor 20
.word 10000 ; $10,$27 ; Armor 21
.word 15000 ; $98,$3A ; Armor 22
.word 40000 ; $40,$9C ; Armor 23
.word 2500  ; $C4,$09 ; Armor 24
.word 20000 ; $20,$4E ; Armor 25
.word 80    ; $50,$00 ; Armor 26
.word 100   ; $64,$00 ; Armor 27
.word 450   ; $C2,$01 ; Armor 28
.word 2500  ; $C4,$09 ; Armor 29
.word 10000 ; $10,$27 ; Armor 30
.word 20000 ; $20,$4E ; Armor 31
.word 2     ; $02,$00 ; Armor 32
.word 60    ; $3C,$00 ; Armor 33
.word 200   ; $C8,$00 ; Armor 34
.word 750   ; $EE,$02 ; Armor 35
.word 2500  ; $C4,$09 ; Armor 36
.word 15000 ; $98,$3A ; Armor 37
.word 10000 ; $10,$27 ; Armor 38
.word 20000 ; $20,$4E ; Armor 39
.word 20000 ; $20,$4E ; Armor 40
.word 0     ; $00,$00 ; Armor 41
.word 0     ; $00,$00 ; Armor 42
.word 0     ; $00,$00 ; Armor 43
.word 0     ; $00,$00 ; Armor 44
.word 0     ; $00,$00 ; Armor 45
.word 0     ; $00,$00 ; Armor 46
.word 0     ; $00,$00 ; Armor 47
.word 0     ; $00,$00 ; Armor 48
.word 0     ; $00,$00 ; Armor 49
.word 0     ; $00,$00 ; Armor 50
.word 0     ; $00,$00 ; Armor 51
.word 0     ; $00,$00 ; Armor 52
.word 0     ; $00,$00 ; Armor 53
.word 0     ; $00,$00 ; Armor 54
.word 0     ; $00,$00 ; Armor 55
.word 0     ; $00,$00 ; Armor 56
.word 0     ; $00,$00 ; Armor 57
.word 0     ; $00,$00 ; Armor 58
.word 0     ; $00,$00 ; Armor 59
.word 0     ; $00,$00 ; Armor 60
.word 0     ; $00,$00 ; Armor 61
.word 0     ; $00,$00 ; Armor 62
.word 0     ; $00,$00 ; Armor 63
.word 0     ; $00,$00 ; Armor 64













lut_ItemDescStrings_Low:
.byte <DESC_HEAL          ; 00
.byte <DESC_X_HEAL        ; 01
.byte <DESC_ETHER         ; 02
.byte <DESC_ELIXIR        ; 03
.byte <DESC_PURE          ; 04
.byte <DESC_SOFT          ; 05
.byte <DESC_PHOENIXDOWN   ; 06
.byte <DESC_TENT          ; 07
.byte <DESC_CABIN         ; 08
.byte <DESC_HOUSE         ; 09
.byte <DESC_EYEDROPS      ; 0A
.byte <DESC_SMOKEBOMB     ; 0B
.byte <DESC_ALARMCLOCK    ; 0C
.byte <DESC_BOTTLE        ; 0D
.byte <DESC_LEWDS         ; 0E

.byte <DESC_MG_CURE
.byte <DESC_MG_HARM
.byte <DESC_MG_FOG
.byte <DESC_MG_RUSE
.byte <DESC_MG_FIRE
.byte <DESC_MG_SLEP
.byte <DESC_MG_LOCK
.byte <DESC_MG_LIT
.byte <DESC_MG_NONE ; green
.byte <DESC_MG_NONE ; green
.byte <DESC_MG_NONE ; green
.byte <DESC_MG_NONE ; green
.byte <DESC_MG_NONE ; time
.byte <DESC_MG_NONE ; time
.byte <DESC_MG_NONE ; time
.byte <DESC_MG_NONE ; time
 
.byte <DESC_MG_LAMP
.byte <DESC_MG_MUTE
.byte <DESC_MG_ALIT
.byte <DESC_MG_INVS
.byte <DESC_MG_ICE
.byte <DESC_MG_DARK
.byte <DESC_MG_TMPR
.byte <DESC_MG_SLOW
.byte <DESC_MG_NONE ; green
.byte <DESC_MG_NONE ; green
.byte <DESC_MG_NONE ; green
.byte <DESC_MG_NONE ; green
.byte <DESC_MG_NONE ; time
.byte <DESC_MG_NONE ; time
.byte <DESC_MG_NONE ; time
.byte <DESC_MG_NONE ; time
 
.byte <DESC_MG_CUR2
.byte <DESC_MG_HRM2
.byte <DESC_MG_AFIR
.byte <DESC_MG_REGN
.byte <DESC_MG_FIR2
.byte <DESC_MG_HOLD
.byte <DESC_MG_LIT2
.byte <DESC_MG_LOK2
.byte <DESC_MG_NONE ; green
.byte <DESC_MG_NONE ; green
.byte <DESC_MG_NONE ; green
.byte <DESC_MG_NONE ; green
.byte <DESC_MG_NONE ; time
.byte <DESC_MG_NONE ; time
.byte <DESC_MG_NONE ; time
.byte <DESC_MG_NONE ; time
 
.byte <DESC_MG_PURE
.byte <DESC_MG_FEAR
.byte <DESC_MG_AICE
.byte <DESC_MG_AMUT
.byte <DESC_MG_SLP2
.byte <DESC_MG_FAST
.byte <DESC_MG_CONF
.byte <DESC_MG_ICE2
.byte <DESC_MG_NONE ; green
.byte <DESC_MG_NONE ; green
.byte <DESC_MG_NONE ; green
.byte <DESC_MG_NONE ; green
.byte <DESC_MG_NONE ; time
.byte <DESC_MG_NONE ; time
.byte <DESC_MG_NONE ; time
.byte <DESC_MG_NONE ; time 
 
.byte <DESC_MG_CUR3
.byte <DESC_MG_LIFE
.byte <DESC_MG_HRM3
.byte <DESC_MG_RGN2
.byte <DESC_MG_FIR3
.byte <DESC_MG_BANE
.byte <DESC_MG_WARP
.byte <DESC_MG_SLO2
.byte <DESC_MG_NONE ; green
.byte <DESC_MG_NONE ; green
.byte <DESC_MG_NONE ; green
.byte <DESC_MG_NONE ; green
.byte <DESC_MG_NONE ; time
.byte <DESC_MG_NONE ; time
.byte <DESC_MG_NONE ; time
.byte <DESC_MG_NONE ; time
 
.byte <DESC_MG_SOFT
.byte <DESC_MG_EXIT
.byte <DESC_MG_FOG2
.byte <DESC_MG_INV2
.byte <DESC_MG_LIT3
.byte <DESC_MG_RUB
.byte <DESC_MG_QAKE
.byte <DESC_MG_STUN
.byte <DESC_MG_NONE ; green
.byte <DESC_MG_NONE ; green
.byte <DESC_MG_NONE ; green
.byte <DESC_MG_NONE ; green
.byte <DESC_MG_NONE ; time
.byte <DESC_MG_NONE ; time
.byte <DESC_MG_NONE ; time
.byte <DESC_MG_NONE ; time
 
.byte <DESC_MG_CUR4
.byte <DESC_MG_HRM4
.byte <DESC_MG_ARUB
.byte <DESC_MG_RGN3
.byte <DESC_MG_ICE3
.byte <DESC_MG_BRAK
.byte <DESC_MG_SABR
.byte <DESC_MG_BLND
.byte <DESC_MG_NONE ; green
.byte <DESC_MG_NONE ; green
.byte <DESC_MG_NONE ; green
.byte <DESC_MG_NONE ; green
.byte <DESC_MG_NONE ; time
.byte <DESC_MG_NONE ; time
.byte <DESC_MG_NONE ; time
.byte <DESC_MG_NONE ; time 
 
.byte <DESC_MG_LIF2
.byte <DESC_MG_FADE
.byte <DESC_MG_WALL
.byte <DESC_MG_XFER
.byte <DESC_MG_NUKE
.byte <DESC_MG_STOP
.byte <DESC_MG_ZAP
.byte <DESC_MG_XXXX
.byte <DESC_MG_NONE ; green
.byte <DESC_MG_NONE ; green
.byte <DESC_MG_NONE ; green
.byte <DESC_MG_NONE ; green
.byte <DESC_MG_NONE ; time
.byte <DESC_MG_NONE ; time
.byte <DESC_MG_NONE ; time
.byte <DESC_MG_NONE ; time

lut_ItemDescStrings_High:
.byte >DESC_HEAL          ; 00
.byte >DESC_X_HEAL        ; 01
.byte >DESC_ETHER         ; 02
.byte >DESC_ELIXIR        ; 03
.byte >DESC_PURE          ; 04
.byte >DESC_SOFT          ; 05
.byte >DESC_PHOENIXDOWN   ; 06
.byte >DESC_TENT          ; 07
.byte >DESC_CABIN         ; 08
.byte >DESC_HOUSE         ; 09
.byte >DESC_EYEDROPS      ; 0A
.byte >DESC_SMOKEBOMB     ; 0B
.byte >DESC_ALARMCLOCK    ; 0C
.byte >DESC_BOTTLE        ; 0D
.byte >DESC_LEWDS         ; 0E

.byte >DESC_MG_CURE
.byte >DESC_MG_HARM
.byte >DESC_MG_FOG
.byte >DESC_MG_RUSE
.byte >DESC_MG_FIRE
.byte >DESC_MG_SLEP
.byte >DESC_MG_LOCK
.byte >DESC_MG_LIT
.byte >DESC_MG_NONE ; green
.byte >DESC_MG_NONE ; green
.byte >DESC_MG_NONE ; green
.byte >DESC_MG_NONE ; green
.byte >DESC_MG_NONE ; time
.byte >DESC_MG_NONE ; time
.byte >DESC_MG_NONE ; time
.byte >DESC_MG_NONE ; time

.byte >DESC_MG_LAMP
.byte >DESC_MG_MUTE
.byte >DESC_MG_ALIT
.byte >DESC_MG_INVS
.byte >DESC_MG_ICE
.byte >DESC_MG_DARK
.byte >DESC_MG_TMPR
.byte >DESC_MG_SLOW
.byte >DESC_MG_NONE ; green
.byte >DESC_MG_NONE ; green
.byte >DESC_MG_NONE ; green
.byte >DESC_MG_NONE ; green
.byte >DESC_MG_NONE ; time
.byte >DESC_MG_NONE ; time
.byte >DESC_MG_NONE ; time
.byte >DESC_MG_NONE ; time

.byte >DESC_MG_CUR2
.byte >DESC_MG_HRM2
.byte >DESC_MG_AFIR
.byte >DESC_MG_REGN
.byte >DESC_MG_FIR2
.byte >DESC_MG_HOLD
.byte >DESC_MG_LIT2
.byte >DESC_MG_LOK2
.byte >DESC_MG_NONE ; green
.byte >DESC_MG_NONE ; green
.byte >DESC_MG_NONE ; green
.byte >DESC_MG_NONE ; green
.byte >DESC_MG_NONE ; time
.byte >DESC_MG_NONE ; time
.byte >DESC_MG_NONE ; time
.byte >DESC_MG_NONE ; time

.byte >DESC_MG_PURE
.byte >DESC_MG_FEAR
.byte >DESC_MG_AICE
.byte >DESC_MG_AMUT
.byte >DESC_MG_SLP2
.byte >DESC_MG_FAST
.byte >DESC_MG_CONF
.byte >DESC_MG_ICE2
.byte >DESC_MG_NONE ; green
.byte >DESC_MG_NONE ; green
.byte >DESC_MG_NONE ; green
.byte >DESC_MG_NONE ; green
.byte >DESC_MG_NONE ; time
.byte >DESC_MG_NONE ; time
.byte >DESC_MG_NONE ; time
.byte >DESC_MG_NONE ; time 

.byte >DESC_MG_CUR3
.byte >DESC_MG_LIFE
.byte >DESC_MG_HRM3
.byte >DESC_MG_RGN2
.byte >DESC_MG_FIR3
.byte >DESC_MG_BANE
.byte >DESC_MG_WARP
.byte >DESC_MG_SLO2
.byte >DESC_MG_NONE ; green
.byte >DESC_MG_NONE ; green
.byte >DESC_MG_NONE ; green
.byte >DESC_MG_NONE ; green
.byte >DESC_MG_NONE ; time
.byte >DESC_MG_NONE ; time
.byte >DESC_MG_NONE ; time
.byte >DESC_MG_NONE ; time

.byte >DESC_MG_SOFT
.byte >DESC_MG_EXIT
.byte >DESC_MG_FOG2
.byte >DESC_MG_INV2
.byte >DESC_MG_LIT3
.byte >DESC_MG_RUB
.byte >DESC_MG_QAKE
.byte >DESC_MG_STUN
.byte >DESC_MG_NONE ; green
.byte >DESC_MG_NONE ; green
.byte >DESC_MG_NONE ; green
.byte >DESC_MG_NONE ; green
.byte >DESC_MG_NONE ; time
.byte >DESC_MG_NONE ; time
.byte >DESC_MG_NONE ; time
.byte >DESC_MG_NONE ; time

.byte >DESC_MG_CUR4
.byte >DESC_MG_HRM4
.byte >DESC_MG_ARUB
.byte >DESC_MG_RGN3
.byte >DESC_MG_ICE3
.byte >DESC_MG_BRAK
.byte >DESC_MG_SABR
.byte >DESC_MG_BLND
.byte >DESC_MG_NONE ; green
.byte >DESC_MG_NONE ; green
.byte >DESC_MG_NONE ; green
.byte >DESC_MG_NONE ; green
.byte >DESC_MG_NONE ; time
.byte >DESC_MG_NONE ; time
.byte >DESC_MG_NONE ; time
.byte >DESC_MG_NONE ; time 

.byte >DESC_MG_LIF2
.byte >DESC_MG_FADE
.byte >DESC_MG_WALL
.byte >DESC_MG_XFER
.byte >DESC_MG_NUKE
.byte >DESC_MG_STOP
.byte >DESC_MG_ZAP
.byte >DESC_MG_XXXX
.byte >DESC_MG_NONE ; green
.byte >DESC_MG_NONE ; green
.byte >DESC_MG_NONE ; green
.byte >DESC_MG_NONE ; green
.byte >DESC_MG_NONE ; time
.byte >DESC_MG_NONE ; time
.byte >DESC_MG_NONE ; time
.byte >DESC_MG_NONE ; time
 

DESC_HEAL:
.byte $FF,$9B,$2C,$28,$23,$1E,$83,$80,$FF,$91,$99,$C0,$FF,$01  ; _Restores 30 HP._|
.byte $FF,$95,$2C,$1E,$A8,$A9,$A9,$A8,$A6,$57,$32,$FF,$FF,$01  ; _Less effective__|
.byte $09,$03,$2D,$29,$A5,$39,$B7,$45,$C0,$09,$03,$00          ; ____in battle.___|

DESC_X_HEAL:
.byte $FF,$9B,$2C,$28,$23,$1E,$81,$88,$80,$FF,$91,$99,$C0,$01  ; _Restores 180 HP.|
.byte $FF,$95,$2C,$1E,$A8,$A9,$A9,$A8,$A6,$57,$32,$FF,$FF,$01  ; _Less effective__|
.byte $09,$03,$2D,$29,$A5,$39,$B7,$45,$C0,$09,$03,$00          ; ____in battle.___|

DESC_ETHER:
.byte $FF,$8F,$B8,$4E,$4B,$23,$37,$35,$2C,$FF,$FF,$01          ; _Fully restores__|
.byte $09,$03,$96,$99,$43,$35,$36,$5A,$FF,$FF,$01              ; ___MP for one____|
.byte $FF,$FF,$B6,$B3,$A8,$4E,$BE,$1E,$45,$32,$AF,$C0,$FF,$00  ; __spell's level._|

DESC_ELIXIR:
.byte $FF,$8F,$B8,$4E,$4B,$23,$37,$35,$2C,$FF,$FF,$01          ; _Fully restores__|
.byte $FF,$5F,$58,$91,$99,$20,$3B,$FF,$96,$99,$C0,$FF,$FF,$01  ; _all HP and MP.__|
.byte $02,$8C,$00

DESC_PURE:
.byte $FF,$FF,$8C,$55,$2C,$4F,$B2,$30,$3C,$C0,$FF,$FF,$01      ; __Cures poison.__|
.byte $02,$8C,$01
.byte $02,$8C,$00

DESC_SOFT:
.byte $09,$03,$8C,$55,$2C,$24,$28,$5A,$C0,$FF,$FF,$01          ; ___Cures stone.__|
.byte $02,$8C,$01
.byte $02,$8C,$00

DESC_PHOENIXDOWN:
.byte $09,$03,$8C,$55,$2C,$67,$2B,$1C,$C0,$FF,$FF,$01          ; ___Cures death.__|
.byte $02,$8C,$01
.byte $02,$8C,$00

DESC_TENT:
DESC_CABIN:
.byte $FF,$9E,$3E,$36,$B8,$B7,$B6,$AC,$A7,$1A,$28,$FF,$FF,$01  ; _Use outside to__|
.byte $09,$03,$23,$A6,$B2,$32,$44,$91,$99,$09,$04,$01          ; ___recover HP____|
.byte $09,$03,$43,$35,$20,$4E,$C0,$09,$05,$00                  ; ____for all._____|

DESC_HOUSE:
.byte $FF,$9E,$3E,$36,$B8,$B7,$B6,$AC,$A7,$1A,$28,$FF,$FF,$01  ; _Use outside to__|
.byte $FF,$23,$A6,$B2,$32,$44,$91,$99,$20,$3B,$FF,$FF,$01      ; _recover HP and__|
.byte $09,$03,$96,$99,$43,$35,$20,$4E,$C0,$09,$03,$00          ; ___MP for all.___|

DESC_EYEDROPS:
.byte $FF,$8C,$55,$2C,$31,$68,$3B,$5A,$B6,$B6,$C0,$00          ; _Cures blindness.|
.byte $02,$8C,$01
.byte $02,$8C,$00

DESC_SMOKEBOMB:                                              
.byte $FF,$9E,$3E,$1B,$2E,$3D,$A7,$1A,$1F,$FF,$FF,$01             ; _Use to hide in__|
.byte $FF,$FF,$A5,$39,$B7,$45,$BF,$36,$44,$28,$FF,$FF,$01         ; __battle, or to__|
.byte $FF,$A4,$B9,$B2,$AC,$27,$3A,$A8,$B0,$AC,$2C,$C0,$FF,$FF,$00 ; _avoid enemies.__|

DESC_ALARMCLOCK:
.byte $FF,$FF,$9E,$3E,$1B,$2E,$A4,$5D,$AE,$3A,$FF,$FF,$01      ; __Use to awaken__|
.byte $FF,$1B,$1D,$4F,$2F,$B7,$4B,$A9,$4D,$B0,$FF,$FF,$01      ; _the party from__|
.byte $FF,$B6,$45,$A8,$B3,$2D,$29,$A5,$39,$B7,$45,$C0,$00      ; _sleep in battle.|

DESC_BOTTLE:
.byte $FF,$FF,$95,$B2,$B2,$AE,$C4,$FF,$9D,$1D,$23,$BE,$B6,$FF,$FF,$01  ; __Look! There's__|
.byte $B6,$49,$A8,$1C,$1F,$47,$51,$B8,$AA,$AB,$B7,$FF,$01              ; something caught_|
.byte $FF,$FF,$2D,$B1,$B6,$AC,$A7,$1A,$5B,$69,$C5,$FF,$FF,$00          ; __inside it...?__|

DESC_LEWDS:
.byte $FF,$A2,$26,$38,$22,$BE,$21,$23,$A4,$A7,$FF,$FF,$01      ; _You can't read__|
.byte $FF,$1C,$39,$FF,$B8,$B1,$45,$B6,$1E,$56,$B8,$FF,$01      ; _that unless you_|
.byte $FF,$31,$B8,$4B,$5B,$43,$AC,$63,$B7,$C4,$FF,$FF,$00      ; __buy it first!__|






DESC_MG_NONE:
.byte $00

DESC_MG_CURE:
.byte $02,$70,$01                                              ; _Lightly recover |
.byte $02,$84,$01                                              ; ___HP for one    |
.byte $02,$7C,$00                                              ; __party member.  |

DESC_MG_HARM:
.byte $02,$75,$01                                              ; _Lightly damage  |
.byte $02,$81,$01                                              ; _undead enemies  |
.byte $02,$88,$00                                              ; _with holy magic.|

DESC_MG_FOG:
.byte $09,$03,$8E,$B1,$A6,$41,$B1,$21,$3C,$1A,$FF,$FF,$01      ; ___Enchant one___|
.byte $1B,$2F,$66,$B7,$BE,$1E,$2F,$B0,$35,$BF,$FF,$01          ; _target's armor,_|
.byte $02,$89,$00                                              ; _raising defense.|

DESC_MG_RUSE:
.byte $FF,$8C,$23,$39,$A8,$20,$FF,$AA,$AB,$B2,$37,$FF,$FF,$01  ; _Create a ghost__|
.byte $FF,$36,$54,$1C,$1A,$51,$37,$25,$BF,$FF,$01              ; __of the caster,_|
.byte $02,$8A,$00                                              ; _raising evasion.|

DESC_MG_FIRE:
.byte $02,$75,$01                                              ; _Lightly damage  |
.byte $02,$79,$01                                              ; ____one enemy    |
.byte $02,$85,$00                                              ; ____with fire.   |

DESC_MG_SLEP:
.byte $02,$7D,$01                                              ; __Slight chance  |
.byte $09,$03,$1B,$2E,$B6,$45,$A8,$B3,$09,$05,$01              ; ____to sleep_____|
.byte $02,$80,$C0,$FF,$FF,$00                                  ; ___all enemies.__|

DESC_MG_LOCK:
.byte $FF,$8C,$41,$B1,$48,$1B,$2E,$B7,$B5,$A4,$B3,$FF,$FF,$01  ; _Chance to trap  |
.byte $02,$7F,$BF,$09,$03,$01                                  ; ____one enemy,   |
.byte $02,$8B,$00                                              ; lowering evasion.|

DESC_MG_LIT:
.byte $02,$75,$01                                              ; _Lightly damage  |
.byte $02,$79,$01                                              ; ____one enemy    |
.byte $02,$86,$00                                              ; _with lightning. |

DESC_MG_LAMP:
.byte $02,$74,$01                                              ; __Recover from   |
.byte $09,$03,$31,$68,$3B,$5A,$B6,$B6,$C0,$09,$03,$01          ; ____blindness.___|
.byte $02,$8C,$00

DESC_MG_MUTE:
.byte $02,$7D,$01                                              ; __Slight chance  |
.byte $FF,$FF,$1B,$2E,$B6,$61,$3A,$48,$09,$04,$01              ; ___to silence____|
.byte $02,$80,$C0,$FF,$FF,$00                                  ; ___all enemies.__|

DESC_MG_ALIT:
.byte $02,$7A,$01                                              ; Protect the party|
.byte $43,$4D,$B0,$65,$AC,$AA,$AB,$B7,$B1,$1F,$AA,$C0,$FF,$01  ; _from lightning._|
.byte $02,$8C,$00

DESC_MG_INVS:
.byte $FF,$9D,$55,$29,$1C,$1A,$B7,$2F,$66,$21,$01              ; _Turn the target_|
.byte $09,$03,$2D,$B1,$B9,$30,$AC,$A5,$45,$BF,$09,$03,$01      ; ____invisible,___|
.byte $02,$8A,$00                                              ; _raising evasion.|

DESC_MG_ICE:
.byte $02,$75,$01                                              ; _Lightly damage  |
.byte $02,$79,$01                                              ; ____one enemy    |
.byte $02,$87,$00                                              ; ____with ice.    |

DESC_MG_DARK:
.byte $02,$7D,$01                                              ; __Slight chance  |
.byte $09,$03,$1B,$2E,$A5,$68,$3B,$09,$05,$01                  ; ____to blind     |
.byte $02,$80,$C0,$FF,$FF,$00                                  ; ___all enemies.__|

DESC_MG_TMPR:
.byte $09,$03,$91,$2F,$A7,$3A,$1B,$1D,$09,$04,$01              ; ___Harden the    |
.byte $1B,$2F,$66,$B7,$BE,$1E,$60,$A4,$B3,$3C,$C0,$01          ; _target's weapon.|
.byte $02,$8C,$00

DESC_MG_SLOW:
.byte $FF,$8C,$41,$B1,$48,$1B,$2E,$68,$B0,$5B,$FF,$01          ; _Chance to limit_|
.byte $02,$80,$BE,$FF,$FF,$01                                  ; ___all enemies'__|
.byte $09,$04,$20,$B7,$B7,$5E,$AE,$B6,$C0,$09,$04,$00          ; _____attacks.____|

DESC_MG_CUR2:
.byte $02,$71,$01                                              ; Strongly recover |
.byte $02,$84,$01                                              ; ___HP for one    |
.byte $02,$7C,$00                                              ; __party member.  |

DESC_MG_HRM2:
.byte $02,$76,$01                                              ; Strongly damage  |
.byte $02,$81,$01                                              ; _undead enemies  |
.byte $02,$88,$00                                              ; _with holy magic.|

DESC_MG_AFIR:
.byte $02,$7A,$01                                              ; Protect the party|
.byte $09,$03,$43,$4D,$B0,$43,$AC,$23,$C0,$09,$03,$01          ; ____from fire.___|
.byte $02,$8C,$00

DESC_MG_REGN:
.byte $02,$73,$01                                              ; _Recover party's |
.byte $02,$83,$01                                              ; __HP over time.  |
.byte $FF,$C8,$95,$3F,$B7,$1E,$83,$1B,$55,$B1,$B6,$C9,$FF,$00  ; _[Lasts 3 turns]_|

DESC_MG_FIR2:
.byte $02,$76,$01                                              ; _Strongly damage |
.byte $02,$80,$09,$03,$01                                      ; ___all enemies___|
.byte $02,$85,$00                                              ; ____with fire.   |

DESC_MG_HOLD:
.byte $02,$7D,$01                                              ; __Slight chance  |
.byte $09,$04,$1B,$2E,$37,$B8,$29,$09,$04,$01                  ; _____to stun_____|
.byte $02,$7F,$C0,$09,$03,$00                                  ; ____one enemy.___|

DESC_MG_LIT2:
.byte $02,$76,$01                                              ; _Strongly damage |
.byte $02,$80,$09,$03,$01                                      ; ___all enemies___|
.byte $02,$86,$00                                              ; _with lightning. |

DESC_MG_LOK2:
.byte $FF,$8C,$41,$B1,$48,$1B,$2E,$B7,$B5,$A4,$B3,$FF,$FF,$01  ; _Chance to trap__|
.byte $02,$80,$BF,$FF,$FF,$01                                  ; ___all enemies,__|
.byte $02,$8B,$00                                              ; lowering evasion.|

DESC_MG_PURE:
.byte $02,$74,$01                                              ; __Recover from  |
.byte $09,$04,$4F,$B2,$30,$3C,$C0,$09,$05,$01                  ; _____poison.____|
.byte $02,$8C,$00

DESC_MG_FEAR:
.byte $FF,$8C,$41,$B1,$48,$1B,$2E,$B6,$51,$23,$FF,$01          ; _Chance to scare_|
.byte $02,$80,$09,$03,$01                                      ; ___all enemies___|
.byte $FF,$2D,$B1,$28,$43,$45,$A8,$1F,$AA,$C0,$FF,$FF,$00      ; __into fleeing.__|

DESC_MG_AICE:
.byte $02,$7A,$01                                              ; Protect the party|
.byte $09,$03,$43,$4D,$B0,$2D,$48,$C0,$09,$04,$01              ; ____from ice.____|
.byte $02,$8C,$00

DESC_MG_AMUT:
.byte $02,$74,$01                                              ; __Recover from   |
.byte $B0,$A4,$AA,$AC,$51,$58,$B0,$B8,$53,$5A,$B6,$B6,$C0,$01  ; magical muteness.|
.byte $02,$8C,$00

DESC_MG_SLP2:
.byte $02,$7E,$01                                              ; _Greater chance  |
.byte $09,$04,$1B,$2E,$B6,$45,$A8,$B3,$09,$04,$01              ;_____to sleep_____|
.byte $02,$7F,$C0,$09,$03,$00                                  ; ____one enemy.___|

DESC_MG_FAST:
.byte $FF,$90,$AC,$B9,$A8,$FF,$1C,$1A,$B7,$2F,$66,$21,$01      ; _Give the target_|
.byte $42,$35,$1A,$A6,$41,$B1,$48,$1E,$28,$FF,$01              ; _more chances to_|
.byte $20,$B7,$B7,$5E,$AE,$4F,$25,$1B,$55,$B1,$C0,$00          ; _attack per turn.|

DESC_MG_CONF:
.byte $FF,$FF,$8C,$41,$B1,$48,$1B,$2E,$32,$BB,$FF,$FF,$01      ; __Chance to vex__|
.byte $02,$80,$09,$03,$01                                      ; ___all enemies___|
.byte $FF,$2D,$B1,$28,$2D,$B1,$B6,$22,$5B,$BC,$C0,$FF,$00      ; __into insanity._|

DESC_MG_ICE2:
.byte $02,$76,$01                                              ; _Strongly damage |
.byte $02,$80,$09,$03,$01                                      ; ___all enemies___|
.byte $02,$87,$00                                              ; ____with ice.    |

DESC_MG_CUR3:
.byte $02,$72,$01                                              ; _Greatly recover |
.byte $02,$84,$01                                              ; ___HP for one    |
.byte $02,$7C,$00                                              ; __party member.  |

DESC_MG_LIFE:
.byte $02,$74,$01                                              ; __Recover from   |
.byte $09,$04,$FF,$67,$2B,$1C,$C0,$09,$04,$FF,$01              ; ______death._____|
.byte $02,$8C,$00

DESC_MG_HRM3:
.byte $02,$77,$01                                              ; _Heavily damage  |
.byte $02,$81,$01                                              ; _undead enemies  |
.byte $02,$88,$00                                              ; _with holy magic.|

DESC_MG_RGN2:
.byte $02,$73,$01                                              ; _Recover party's |
.byte $02,$83,$01                                              ; __HP over time.  |
.byte $FF,$C8,$95,$3F,$B7,$1E,$84,$1B,$55,$B1,$B6,$C9,$FF,$00  ; _[Lasts 4 turns]_|

DESC_MG_FIR3:
.byte $02,$77,$01                                              ; _Heavily damage  |
.byte $02,$80,$09,$03,$01                                      ; ___all enemies___|
.byte $02,$85,$00                                              ; ____with fire.   |

DESC_MG_BANE:
.byte $FF,$8C,$41,$B1,$48,$1B,$2E,$AE,$61,$58,$FF,$01          ; _Chance to kill__|
.byte $02,$80,$09,$03,$01                                      ; ___all enemies___|
.byte $FF,$FF,$33,$5B,$AB,$4F,$B2,$30,$3C,$C0,$FF,$FF,$00      ; ___with poison.__|

DESC_MG_WARP:
.byte $02,$7B,$01                                              ; Return the party |
.byte $1B,$2E,$1C,$1A,$B3,$23,$B9,$AC,$26,$1E,$01              ; _to the previous_|
.byte $65,$A8,$32,$AF,$BF,$36,$44,$A8,$BB,$5B,$C0,$FF,$00      ; _level, or exit._|

DESC_MG_SLO2:
.byte $02,$7E,$01                                              ; _Greater chance  |
.byte $FF,$1B,$2E,$68,$B0,$5B,$36,$5A,$09,$03,$01              ; __to limit one___|
.byte $FF,$3A,$A8,$B0,$BC,$BE,$1E,$39,$B7,$5E,$AE,$B6,$C0,$00  ; _enemy's attacks.|

DESC_MG_SOFT:
.byte $02,$74,$01                                              ; __Recover from   |
.byte $09,$05,$24,$28,$5A,$C0,$09,$05,$01                      ; ______stone._____|
.byte $02,$8C,$00

DESC_MG_EXIT:
.byte $02,$7B,$01                                              ; Return the party |
.byte $FF,$FF,$1B,$2E,$1C,$1A,$A8,$BB,$5B,$C0,$FF,$FF,$01      ; ___to the exit.__|
.byte $02,$8C,$00

DESC_MG_FOG2:
.byte $09,$03,$8E,$B1,$A6,$41,$B1,$21,$1C,$1A,$FF,$FF,$01      ; ___Enchant the___|
.byte $FF,$4F,$2F,$B7,$BC,$BE,$1E,$A4,$B5,$B0,$35,$BF,$FF,$01  ; __party's armor,_|
.byte $02,$89,$00                                              ; _raising defense.|

DESC_MG_INV2:
.byte $FF,$9D,$55,$29,$1C,$1A,$B3,$2F,$B7,$4B,$FF,$01          ; _Turn the party__|
.byte $09,$03,$2D,$B1,$B9,$30,$AC,$A5,$45,$BF,$09,$03,$01      ; ____invisible,___|
.byte $02,$8A,$00                                              ; _raising evasion.|

DESC_MG_LIT3:
.byte $02,$77,$01                                              ; _Heavily damage  |
.byte $02,$80,$09,$03,$01                                      ; ___all enemies___|
.byte $02,$86,$00                                              ; _with lightning. |

DESC_MG_RUB:
.byte $FF,$8C,$41,$B1,$48,$1B,$2E,$25,$3F,$1A,$01              ; _Chance to erase_|
.byte $02,$7F,$C0,$09,$03,$01                                  ; ____one enemy.___|
.byte $02,$8C,$00

DESC_MG_QAKE:
.byte $FF,$8C,$41,$B1,$48,$1B,$2E,$3E,$3B,$FF,$FF,$01          ; _Chance to send__|
.byte $02,$80,$09,$03,$01                                      ; ___all enemies___|
.byte $2D,$B1,$28,$1B,$1D,$FF,$2B,$B5,$1C,$C0,$FF,$00          ; _into the earth._|

DESC_MG_STUN:
.byte $FF,$92,$B1,$A9,$68,$A6,$21,$37,$B8,$29,$3C,$FF,$01      ; _Inflict stun on_|
.byte $02,$79,$01                                              ; ____one enemy    |
.byte $02,$82,$00                                              ; _when HP is low. |

DESC_MG_CUR4:
.byte $FF,$9B,$A8,$A6,$B2,$32,$44,$5F,$58,$91,$99,$FF,$FF,$01  ; _Recover all HP  |
.byte $22,$27,$61,$AF,$1E,$A9,$35,$36,$5A,$FF,$01              ; and ills for one |
.byte $02,$7C,$00                                              ; __party member.  |

DESC_MG_HRM4:
.byte $02,$78,$01                                              ; Massively damage |
.byte $02,$81,$01                                              ; _undead enemies  |
.byte $02,$88,$00                                              ; with holy magic. |

DESC_MG_ARUB:
.byte $02,$7A,$01                                              ; Protect the party|
.byte $FF,$FF,$43,$4D,$B0,$67,$2B,$1C,$C0,$09,$03,$01          ; ___from death.___|
.byte $02,$8C,$00

DESC_MG_RGN3:
.byte $02,$73,$01                                              ; _Recover party's |
.byte $02,$83,$01                                              ; __HP over time.  |
.byte $FF,$C8,$95,$3F,$B7,$1E,$85,$1B,$55,$B1,$B6,$C9,$FF,$00  ; _[Lasts 5 turns] |

DESC_MG_ICE3:
.byte $02,$77,$01                                              ; _Heavily damage  |
.byte $02,$80,$09,$03,$01                                      ; ___all enemies   |
.byte $02,$87,$00                                              ; ____with ice.    |

DESC_MG_BRAK:
.byte $FF,$8C,$41,$B1,$48,$1B,$2E,$B7,$55,$29,$FF,$01          ; _Chance to turn__|
.byte $02,$79,$01                                              ; ____one enemy    |
.byte $FF,$FF,$2D,$B1,$28,$24,$28,$5A,$C0,$09,$03,$00          ; ___into stone.___|

DESC_MG_SABR:
.byte $09,$03,$91,$2F,$A7,$3A,$1B,$1D,$09,$04,$01              ; ___Harden the____|
.byte $38,$3F,$53,$B5,$BE,$1E,$60,$A4,$B3,$3C,$C0,$01          ; _caster's weapon.|
.byte $02,$8C,$00

DESC_MG_BLND:
.byte $92,$B1,$A9,$68,$A6,$21,$A5,$68,$3B,$36,$29,$01          ; Inflict blind on_|
.byte $02,$79,$01                                              ; ____one enemy    |
.byte $02,$82,$00                                              ; _when HP is low. |

DESC_MG_LIF2:
.byte $02,$74,$01                                              ; __Recover from   |
.byte $FF,$FF,$67,$2B,$1C,$33,$5B,$AB,$09,$04,$01              ; ___death with____|
.byte $09,$03,$43,$B8,$4E,$FF,$91,$99,$C0,$09,$05,$00          ; ____full HP._____|

DESC_MG_FADE:
.byte $02,$77,$01                                              ; _Heavily damage  |
.byte $02,$80,$C0,$FF,$FF,$01                                  ; ___all enemies   |
.byte $02,$88,$00                                              ; _with holy magic.|

DESC_MG_WALL:
.byte $02,$7A,$01                                              ; Protect the party|
.byte $09,$03,$43,$4D,$B0,$20,$4E,$09,$05,$01                  ; ____from all_____|
.byte $09,$04,$A8,$45,$34,$B1,$B7,$B6,$C0,$09,$04,$00          ; ____elements.____|

DESC_MG_XFER:
.byte $9B,$A8,$B0,$B2,$32,$FF,$23,$B6,$30,$B7,$22,$48,$01      ; Remove resistance|
.byte $28,$FF,$A8,$45,$34,$B1,$B7,$1E,$A9,$4D,$B0,$FF,$01      ; to elements from_|
.byte $02,$7F,$C0,$09,$03,$00                                  ; ____one enemy.___|

DESC_MG_NUKE:
.byte $02,$78,$01                                              ; Massively damage |
.byte $02,$80,$C0,$FF,$FF,$01                                  ; ___all enemies.__|
.byte $02,$8C,$00

DESC_MG_STOP:
.byte $02,$7D,$01                                              ; __Slight chance  |
.byte $09,$04,$1B,$2E,$37,$B8,$29,$09,$04,$01                  ; _____to stun_____|
.byte $02,$80,$C0,$FF,$FF,$00                                  ; ___all enemies.__|

DESC_MG_ZAP:
.byte $02,$7D,$01                                              ; __Slight chance  |
.byte $09,$04,$1B,$2E,$AE,$61,$58,$09,$04,$01                  ; _____to kill_____|
.byte $02,$80,$C0,$FF,$FF,$00                                  ; ___all enemies.__|

DESC_MG_XXXX:
.byte $FF,$92,$B1,$37,$22,$B7,$AF,$4B,$AE,$61,$AF,$1E,$01      ; _Instantly kills_|
.byte $02,$79,$01                                              ; ____one enemy    |
.byte $02,$82,$00                                              ; _when HP is low. |



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Items in treasure chests
;;
;; An explanation of chest item IDs:
;; First byte is Shop Type that you would find the item in.
;; 0 - weapon
;; 1 - armor
;; 2 - white magic
;; 3 - black magic
;; 4 - green magic
;; 5 - time magic
;; 6 - skills
;; 7 - items
;; anything else - gold 

;; JIGS - this is loaded by the low bit of tile properties
;; where 1 = first table, and 0 = second table

lut_TreasureTable_Low:
.byte <lut_Treasure_2
.byte <lut_Treasure

lut_TreasureTable_High:
.byte >lut_Treasure_2
.byte >lut_Treasure


lut_Treasure:
.byte $00, $00      ; 00 ; Unused             - 
.byte $01, ARM4     ; 01 ; Coneria 1          - Iron   Armor
.byte $01, ARM18    ; 02 ; Coneria 2          - Iron   Shield
.byte $07, TNT      ; 03 ; Coneria 3          - TNT    
.byte $00, WEP11    ; 04 ; Coneria 4          - Iron   Staff
.byte $00, WEP12    ; 05 ; Coneria 5          - Sabre  
.byte $00, WEP16    ; 06 ; Coneria 6          - Silver Knife
.byte $07, CABIN    ; 07 ; Temple of Fiends 1 - CABIN  
.byte $07, HEAL     ; 08 ; Temple of Fiends 2 - HEAL Potion
.byte $01, ARM26    ; 09 ; Temple of Fiends 3 - Cap    
.byte $00, WEP27    ; 0A ; Temple of Fiends 4 - Rune   Sword
.byte $00, WEP26    ; 0B ; Temple of Fiends 5 - Were   Sword
.byte $07, SOFT     ; 0C ; Temple of Fiends 6 - Soft  
.byte $00, WEP18    ; 0D ; Elfland 1          - Silver Hammer
.byte $08, GOLD22   ; 0E ; Elfland 2          - 400 G
.byte $08, GOLD19   ; 0F ; Elfland 3          - 330 G
.byte $01, ARM34    ; 10 ; Elfland 4          - Copper Gauntlets
.byte $00, WEP28    ; 11 ; NorthWest Castle 1 - Power  Staff
.byte $01, ARM35    ; 12 ; NorthWest Castle 2 - Iron   Gauntlets
.byte $00, WEP15    ; 13 ; NorthWest Castle 3 - Falchon
.byte $07, PHOENIXDOWN ; JIGS - to combat Astos's RUB
;.byte $07, GOLD16   ; 14 ; Marsh Cave 1       - 295 G 
.byte $01, ARM11    ; 15 ; Marsh Cave 2       - Copper Bracelet
.byte $07, HOUSE    ; 16 ; Marsh Cave 3       - HOUSE  
.byte $08, GOLD21   ; 17 ; Marsh Cave 4       - 385 G
.byte $08, GOLD27   ; 18 ; Marsh Cave 5       - 620 G
.byte $00, WEP6     ; 19 ; Marsh Cave 6       - Short  Sword
.byte $08, GOLD28   ; 1A ; Marsh Cave 7       - 680 G
.byte $00, WEP10    ; 1B ; Marsh Cave 8       - Large  Knife
.byte $07, CROWN    ; 1C ; Marsh Cave 9       - CROWN  
.byte $01, ARM4     ; 1D ; Marsh Cave 10      - Iron   Armor
.byte $01, ARM12    ; 1E ; Marsh Cave 11      - Silver Bracelet
.byte $00, WEP16    ; 1F ; Marsh Cave 12      - Silver Knife
.byte $08, GOLD32   ; 20 ; Marsh Cave 13      - 1020 G
.byte $08, GOLD23   ; 21 ; Dwarf Cave 1       - 450 G
.byte $08, GOLD26   ; 22 ; Dwarf Cave 2       - 575 G
.byte $07, CABIN    ; 23 ; Dwarf Cave 3       - CABIN  
.byte $01, ARM27    ; 24 ; Dwarf Cave 4       - Iron   Helmet
.byte $01, ARM27    ; 25 ; Dwarf Cave 5       - Wooden Helmet
.byte $00, WEP22    ; 26 ; Dwarf Cave 6       - Dragon Sword
.byte $00, WEP16    ; 27 ; Dwarf Cave 7       - Silver Knife
.byte $01, ARM6     ; 28 ; Dwarf Cave 8       - Silver Armor
.byte $08, GOLD26   ; 29 ; Dwarf Cave 9       - 575 G
.byte $07, HOUSE    ; 2A ; Dwarf Cave 10      - HOUSE  
.byte $07, HEAL     ; 2B ; Matoya's Cave 1    - HEAL Potion
.byte $07, PURE     ; 2C ; Matoya's Cave 2    - PURE Potion
.byte $07, HEAL     ; 2D ; Matoya's Cave 3    - HEAL Potion
.byte $08, GOLD31   ; 2E ; Earth Cave 1       - 880 G
.byte $07, HEAL     ; 2F ; Earth Cave 2       - HEAL Potion
.byte $07, PURE     ; 30 ; Earth Cave 3       - PURE Potion
.byte $08, GOLD30   ; 31 ; Earth Cave 4       - 795 G
.byte $08, GOLD37   ; 32 ; Earth Cave 5       - 1975 G
.byte $00, WEP25    ; 33 ; Earth Cave 6       - Coral  Sword
.byte $07, CABIN    ; 34 ; Earth Cave 7       - CABIN  
.byte $08, GOLD19   ; 35 ; Earth Cave 8       - 330 G
.byte $08, GOLD42   ; 36 ; Earth Cave 9       - 5000 G
.byte $01, ARM17    ; 37 ; Earth Cave 10      - Wooden Shield
.byte $08, GOLD26   ; 38 ; Earth Cave 11      - 575 G
.byte $08, GOLD32   ; 39 ; Earth Cave 12      - 1020 G
.byte $08, GOLD40   ; 3A ; Earth Cave 13      - 3400 G
.byte $07, TENT     ; 3B ; Earth Cave 14      - TENT   
.byte $06, HEAL     ; 3C ; Earth Cave 15      - HEAL Potion
.byte $07, RUBY     ; 3D ; Earth Cave 16      - RUBY   
.byte $07, GOLD33   ; 3E ; Earth Cave 17      - 1250 G
.byte $07, ARM19    ; 3F ; Earth Cave 18      - Silver Shield
.byte $07, CABIN    ; 40 ; Earth Cave 19      - CABIN  
.byte $08, GOLD43   ; 41 ; Earth Cave 20      - 5450 G
.byte $08, GOLD35   ; 42 ; Earth Cave 21      - 1520 G
.byte $00, WEP2     ; 43 ; Earth Cave 22      - Wooden Staff
.byte $08, GOLD40   ; 44 ; Earth Cave 23      - 3400 G
.byte $08, GOLD34   ; 45 ; Earth Cave 24      - 1455 G
.byte $01, ARM29    ; 46 ; Titan's Tunnel 1   - Silver Helmet
.byte $08, GOLD23   ; 47 ; Titan's Tunnel 2   - 450 G
.byte $08, GOLD27   ; 48 ; Titan's Tunnel 3   - 620 G
.byte $00, WEP14    ; 49 ; Titan's Tunnel 4   - Great  Axe
.byte $07, HEAL     ; 4A ; Gurgu Volcano 1    - HEAL Potion
.byte $07, CABIN    ; 4B ; Gurgu Volcano 2    - CABIN  
.byte $08, GOLD37   ; 4C ; Gurgu Volcano 3    - 1975 G
.byte $07, PURE     ; 4D ; Gurgu Volcano 4    - PURE Potion
.byte $07, HEAL     ; 4E ; Gurgu Volcano 5    - HEAL Potion
.byte $08, GOLD34   ; 4F ; Gurgu Volcano 6    - 1455 G
.byte $01, ARM19    ; 50 ; Gurgu Volcano 7    - Silver Shield
.byte $08, GOLD35   ; 51 ; Gurgu Volcano 8    - 1520 G
.byte $01, ARM29    ; 52 ; Gurgu Volcano 9    - Silver Helmet
.byte $01, ARM36    ; 53 ; Gurgu Volcano 10   - Silver Gauntlets
.byte $08, GOLD36   ; 54 ; Gurgu Volcano 11   - 1760 G
.byte $00, WEP19    ; 55 ; Gurgu Volcano 12   - Silver Axe
.byte $08, GOLD30   ; 56 ; Gurgu Volcano 13   - 795 G
.byte $08, GOLD29   ; 57 ; Gurgu Volcano 14   - 750 G
.byte $00, WEP23    ; 58 ; Gurgu Volcano 15   - Giant  Sword
.byte $08, GOLD41   ; 59 ; Gurgu Volcano 16   - 4150 G
.byte $08, GOLD35   ; 5A ; Gurgu Volcano 17   - 1520 G
.byte $01, ARM29    ; 5B ; Gurgu Volcano 18   - Silver Helmet
.byte $07, SOFT     ; 5C ; Gurgu Volcano 19   - Soft  
.byte $08, GOLD39   ; 5D ; Gurgu Volcano 20   - 2750 G
.byte $08, GOLD36   ; 5E ; Gurgu Volcano 21   - 1760 G
.byte $00, WEP2     ; 5F ; Gurgu Volcano 22   - Wooden Staff
.byte $08, GOLD33   ; 60 ; Gurgu Volcano 23   - 1250 G
.byte $08, GOLD1    ; 61 ; Gurgu Volcano 24   - 10 G
.byte $08, GOLD10   ; 62 ; Gurgu Volcano 25   - 155 G
.byte $07, HOUSE    ; 63 ; Gurgu Volcano 26   - HOUSE  
.byte $08, GOLD38   ; 64 ; Gurgu Volcano 27   - 2000 G
.byte $00, WEP21    ; 65 ; Gurgu Volcano 28   - Ice    Sword
.byte $08, GOLD31   ; 66 ; Gurgu Volcano 29   - 880 G
.byte $07, PURE     ; 67 ; Gurgu Volcano 30   - PURE Potion
.byte $01, ARM20    ; 68 ; Gurgu Volcano 31   - Flame  Shield
.byte $08, GOLD46   ; 69 ; Gurgu Volcano 32   - 7340 G
.byte $01, ARM7     ; 6A ; Gurgu Volcano 33   - Flame  Armor
.byte $07, HEAL     ; 6B ; Ice Cave 1         - HEAL Potion
.byte $08, GOLD54   ; 6C ; Ice Cave 2         - 10000 G
.byte $08, GOLD52   ; 6D ; Ice Cave 3         - 9500 G
.byte $06, TENT     ; 6E ; Ice Cave 4         - TENT   
.byte $01, ARM21    ; 6F ; Ice Cave 5         - Ice    Shield
.byte $01, ARM1     ; 70 ; Ice Cave 6         - Cloth  
.byte $00, WEP20    ; 71 ; Ice Cave 7         - Flame  Sword
.byte $07, FLOATER  ; 72 ; Ice Cave 8         - FLOATER
.byte $08, GOLD48   ; 73 ; Ice Cave 9         - 7900 G
.byte $08, GOLD43   ; 74 ; Ice Cave 10        - 5450 G
.byte $08, GOLD53   ; 75 ; Ice Cave 11        - 9900 G
.byte $08, GOLD42   ; 76 ; Ice Cave 12        - 5000 G
.byte $08, GOLD12   ; 77 ; Ice Cave 13        - 180 G
.byte $08, GOLD55   ; 78 ; Ice Cave 14        - 12350 G
.byte $01, ARM36    ; 79 ; Ice Cave 15        - Silver Gauntlets
.byte $01, ARM8     ; 7A ; Ice Cave 16        - Ice    Armor
.byte $01, ARM37    ; 7B ; Castle of Ordeal 1 - Zeus   Gauntlets
.byte $07, HOUSE    ; 7C ; Castle of Ordeal 2 - HOUSE  
.byte $08, GOLD34   ; 7D ; Castle of Ordeal 3 - 1455 G
.byte $08, GOLD46   ; 7E ; Castle of Ordeal 4 - 7340 G
.byte $01, ARM13    ; 7F ; Castle of Ordeal 5 - Gold   Bracelet
.byte $00, WEP21    ; 80 ; Castle of Ordeal 6 - Ice    Sword
.byte $01, ARM35    ; 81 ; Castle of Ordeal 7 - Iron   Gauntlets
.byte $00, WEP30    ; 82 ; Castle of Ordeal 8 - Heal   Staff
.byte $07, TAIL     ; 83 ; Castle of Ordeal 9 - TAIL   
.byte $08, GOLD34   ; 84 ; Cardia 1           - 1455 G
.byte $08, GOLD38   ; 85 ; Cardia 2           - 2000 G
.byte $08, GOLD39   ; 86 ; Cardia 3           - 2750 G
.byte $08, GOLD39   ; 87 ; Cardia 4           - 2750 G
.byte $08, GOLD35   ; 88 ; Cardia 5           - 1520 G
.byte $08, GOLD1    ; 89 ; Cardia 6           - 10 G
.byte $08, GOLD24   ; 8A ; Cardia 7           - 500 G
.byte $07, HOUSE    ; 8B ; Cardia 8           - HOUSE  
.byte $08, GOLD26   ; 8C ; Cardia 9           - 575 G
.byte $07, SOFT     ; 8D ; Cardia 10          - Soft  
.byte $07, CABIN    ; 8E ; Cardia 11          - CABIN  
.byte $08, GOLD52   ; 8F ; Cardia 12          - 9500 G
.byte $08, GOLD11   ; 90 ; Cardia 13          - 160 G
.byte $00, $00      ; 91 ; Not Used 1         - 530 G
.byte $00, $00      ; 92 ; Not Used 2         - Small  Knife
.byte $00, $00      ; 93 ; Not Used 3         - Cap    
.byte $00, $00      ; 94 ; Not Used 4         - Zeus   Gauntlets
.byte $01, ARM32    ; 95 ; Sea Shrine 1       - Ribbon  
.byte $08, GOLD53   ; 96 ; Sea Shrine 2       - 9900 G
.byte $08, GOLD46   ; 97 ; Sea Shrine 3       - 7340 G
.byte $08, GOLD39   ; 98 ; Sea Shrine 4       - 2750 G
.byte $08, GOLD47   ; 99 ; Sea Shrine 5       - 7690 G
.byte $08, GOLD49   ; 9A ; Sea Shrine 6       - 8135 G
.byte $08, GOLD43   ; 9B ; Sea Shrine 7       - 5450 G
.byte $08, GOLD21   ; 9C ; Sea Shrine 8       - 385 G
.byte $01, ARM38    ; 9D ; Sea Shrine 9       - Power  Gauntlets
.byte $00, WEP29    ; 9E ; Sea Shrine 10      - Light  Axe
.byte $08, GOLD53   ; 9F ; Sea Shrine 11      - 9900 G
.byte $08, GOLD38   ; A0 ; Sea Shrine 12      - 2000 G
.byte $08, GOLD23   ; A1 ; Sea Shrine 13      - 450 G
.byte $08, GOLD8    ; A2 ; Sea Shrine 14      - 110 G
.byte $00, WEP29    ; A3 ; Sea Shrine 15      - Light  Axe
.byte $01, ARM9     ; A4 ; Sea Shrine 16      - Opal   Armor
.byte $08, GOLD2    ; A5 ; Sea Shrine 17      - 20 G
.byte $00, WEP31    ; A6 ; Sea Shrine 18      - Mage   Staff
.byte $08, GOLD55   ; A7 ; Sea Shrine 19      - 12350 G
.byte $08, GOLD50   ; A8 ; Sea Shrine 20      - 9000 G
.byte $08, GOLD36   ; A9 ; Sea Shrine 21      - 1760 G
.byte $01, ARM14    ; AA ; Sea Shrine 22      - Opal   Bracelet
.byte $08, GOLD39   ; AB ; Sea Shrine 23      - 2750 G
.byte $08, GOLD54   ; AC ; Sea Shrine 24      - 10000 G
.byte $07, GOLD1    ; AD ; Sea Shrine 25      - 10 G
.byte $08, GOLD41   ; AE ; Sea Shrine 26      - 4150 G
.byte $08, GOLD42   ; AF ; Sea Shrine 27      - 5000 G
.byte $07, PURE     ; B0 ; Sea Shrine 28      - PURE Potion
.byte $01, ARM22    ; B1 ; Sea Shrine 29      - Opal   Shield
.byte $01, ARM30    ; B2 ; Sea Shrine 30      - Opal   Helmet
.byte $01, ARM39    ; B3 ; Sea Shrine 31      - Opal   Gauntlets
.byte $06, SLAB     ; B4 ; Sea Shrine 32      - SLAB   
.byte $00, WEP33    ; B5 ; Waterfall 1        - Wizard Staff
.byte $01, ARM32    ; B6 ; Waterfall 2        - Ribbon  
.byte $08, GOLD57   ; B7 ; Waterfall 3        - 13450 G
.byte $08, GOLD44   ; B8 ; Waterfall 4        - 6400 G
.byte $08, GOLD42   ; B9 ; Waterfall 5        - 5000 G
.byte $00, WEP32    ; BA ; Waterfall 6        - Defense
.byte $00, $00      ; BB ; Not Used 5         - HEAL Potion
.byte $00, $00      ; BC ; Not Used 6         - HEAL Potion
.byte $00, $00      ; BD ; Not Used 7         - HEAL Potion
.byte $00, $00      ; BE ; Not Used 8         - HEAL Potion
.byte $00, $00      ; BF ; Not Used 9         - HEAL Potion
.byte $00, $00      ; C0 ; Not Used 10        - HEAL Potion
.byte $00, $00      ; C1 ; Not Used 11        - HEAL Potion
.byte $00, $00      ; C2 ; Not Used 12        - HEAL Potion
.byte $00, $00      ; C3 ; Not Used 13        - HEAL Potion
.byte $01, ARM23    ; C4 ; Mirage Tower 1     - Aegis  Shield
.byte $08, GOLD39   ; C5 ; Mirage Tower 2     - 2750 G
.byte $08, GOLD40   ; C6 ; Mirage Tower 3     - 3400 G
.byte $08, GOLD62   ; C7 ; Mirage Tower 4     - 18010 G
.byte $07, CABIN    ; C8 ; Mirage Tower 5     - CABIN  
.byte $01, ARM31    ; C9 ; Mirage Tower 6     - Heal   Helmet
.byte $08, GOLD31   ; CA ; Mirage Tower 7     - 880 G
.byte $00, WEP34    ; CB ; Mirage Tower 8     - Vorpal 
.byte $07, HOUSE    ; CC ; Mirage Tower 9     - HOUSE  
.byte $08, GOLD47   ; CD ; Mirage Tower 10    - 7690 G
.byte $00, WEP24    ; CE ; Mirage Tower 11    - Sun    Sword
.byte $08, GOLD54   ; CF ; Mirage Tower 12    - 10000 G
.byte $01, ARM10    ; D0 ; Mirage Tower 13    - Dragon Armor
.byte $08, GOLD49   ; D1 ; Mirage Tower 14    - 8135 G
.byte $08, GOLD48   ; D2 ; Mirage Tower 15    - 7900 G
.byte $00, WEP36    ; D3 ; Mirage Tower 16    - Thor   Hammer
.byte $08, GOLD55   ; D4 ; Mirage Tower 17    - 12350 G
.byte $08, GOLD56   ; D5 ; Mirage Tower 18    - 13000 G
.byte $08, GOLD53   ; D6 ; Sky Palace 1       - 9900 G
.byte $07, HEAL     ; D7 ; Sky Palace 2       - HEAL Potion
.byte $08, GOLD42   ; D8 ; Sky Palace 3       - 4150 G
.byte $08, GOLD48   ; D9 ; Sky Palace 4       - 7900 G
.byte $08, GOLD42   ; DA ; Sky Palace 5       - 5000 G
.byte $01, ARM40    ; DB ; Sky Palace 6       - ProRing
.byte $08, GOLD45   ; DC ; Sky Palace 7       - 6720 G
.byte $01, ARM31    ; DD ; Sky Palace 8       - Heal   Helmet
.byte $08, GOLD12   ; DE ; Sky Palace 9       - 180 G
.byte $00, WEP37    ; DF ; Sky Palace 10      - Bane   Sword
.byte $01, ARM15    ; E0 ; Sky Palace 11      - White  Shirt
.byte $01, ARM16    ; E1 ; Sky Palace 12      - Black  Shirt
.byte $01, ARM32    ; E2 ; Sky Palace 13      - Ribbon  
.byte $01, ARM39    ; E3 ; Sky Palace 14      - Opal   Gauntlets
.byte $01, ARM22    ; E4 ; Sky Palace 15      - Opal   Shield
.byte $01, ARM29    ; E5 ; Sky Palace 16      - Silver Helmet
.byte $07, HOUSE    ; E6 ; Sky Palace 17      - HOUSE  
.byte $08, GOLD31   ; E7 ; Sky Palace 18      - 880 G
.byte $08, GOLD56   ; E8 ; Sky Palace 19      - 13000 G
.byte $07, ADAMANT  ; E9 ; Sky Palace 20      - ADAMANT
.byte $08, GOLD41   ; EA ; Sky Palace 21      - 4150 G
.byte $07, SOFT     ; EB ; Sky Palace 22      - Soft  
.byte $08, GOLD40   ; EC ; Sky Palace 23      - 3400 G
.byte $00, WEP38    ; ED ; Sky Palace 24      - Katana 
.byte $01, ARM25    ; EE ; Sky Palace 25      - ProCape
.byte $01, ARM1     ; EF ; Sky Palace 26      - Cloth  
.byte $08, GOLD52   ; F0 ; Sky Palace 27      - 9500 G
.byte $07, SOFT     ; F1 ; Sky Palace 28      - Soft  
.byte $08, GOLD44   ; F2 ; Sky Palace 29      - 6400 G
.byte $08, GOLD49   ; F3 ; Sky Palace 30      - 8135 G
.byte $08, GOLD50   ; F4 ; Sky Palace 31      - 9000 G
.byte $07, HEAL     ; F5 ; Sky Palace 32      - HEAL Potion
.byte $01, ARM40    ; F6 ; Sky Palace 33      - ProRing
.byte $08, GOLD45   ; F7 ; Sky Palace 34      - 5450 G
.byte $00, WEP40    ; F8 ; ToF Revisited 1    - Masmune
.byte $08, GOLD66   ; F9 ; ToF Revisited 2    - 26000 G
.byte $00, WEP38    ; FA ; ToF Revisited 3    - Katana 
.byte $01, ARM40    ; FB ; ToF Revisited 4    - ProRing
.byte $01, ARM25    ; FC ; ToF Revisited 5    - ProCape
.byte $08, GOLD67   ; FD ; ToF Revisited 6    - 45000 G
.byte $08, GOLD68   ; FE ; ToF Revisited 7    - 65000 G
.byte $00, $00      ; FF ;Unused             - 

;; JIGS - this is an entirely new treasure table. None of these are used by the original game.

lut_Treasure_2:
.byte $00, $00        ; 00 ; Unused
.byte $00, WEP41      ; 01 ; Chicken Knife
.byte $00, $00        ; 02 ;
.byte $00, $00        ; 03 ;
.byte $00, $00        ; 04 ;
.byte $00, $00        ; 05 ;
.byte $00, $00        ; 06 ;
.byte $00, $00        ; 07 ;
.byte $00, $00        ; 08 ;
.byte $00, $00        ; 09 ;
.byte $00, $00        ; 0A ;
.byte $00, $00        ; 0B ;
.byte $00, $00        ; 0C ;
.byte $00, $00        ; 0D ;
.byte $00, $00        ; 0E ;
.byte $00, $00        ; 0F ;
.byte $00, $00        ; 10 ;
.byte $00, $00        ; 11 ;
.byte $00, $00        ; 12 ;
.byte $00, $00        ; 13 ;
.byte $00, $00        ; 14 ;
.byte $00, $00        ; 15 ;
.byte $00, $00        ; 16 ;
.byte $00, $00        ; 17 ;
.byte $00, $00        ; 18 ;
.byte $00, $00        ; 19 ;
.byte $00, $00        ; 1A ;
.byte $00, $00        ; 1B ;
.byte $00, $00        ; 1C ;
.byte $00, $00        ; 1D ;
.byte $00, $00        ; 1E ;
.byte $00, $00        ; 1F ;
.byte $00, $00        ; 20 ;
.byte $00, $00        ; 21 ;
.byte $00, $00        ; 22 ;
.byte $00, $00        ; 23 ;
.byte $00, $00        ; 24 ;
.byte $00, $00        ; 25 ;
.byte $00, $00        ; 26 ;
.byte $00, $00        ; 27 ;
.byte $00, $00        ; 28 ;
.byte $00, $00        ; 29 ;
.byte $00, $00        ; 2A ;
.byte $00, $00        ; 2B ;
.byte $00, $00        ; 2C ;
.byte $00, $00        ; 2D ;
.byte $00, $00        ; 2E ;
.byte $00, $00        ; 2F ;
.byte $00, $00        ; 30 ;
.byte $00, $00        ; 31 ;
.byte $00, $00        ; 32 ;
.byte $00, $00        ; 33 ;
.byte $00, $00        ; 34 ;
.byte $00, $00        ; 35 ;
.byte $00, $00        ; 36 ;
.byte $00, $00        ; 37 ;
.byte $00, $00        ; 38 ;
.byte $00, $00        ; 39 ;
.byte $00, $00        ; 3A ;
.byte $00, $00        ; 3B ;
.byte $00, $00        ; 3C ;
.byte $00, $00        ; 3D ;
.byte $00, $00        ; 3E ;
.byte $00, $00        ; 3F ;
.byte $00, $00        ; 40 ;
.byte $00, $00        ; 41 ;
.byte $00, $00        ; 42 ;
.byte $00, $00        ; 43 ;
.byte $00, $00        ; 44 ;
.byte $00, $00        ; 45 ;
.byte $00, $00        ; 46 ;
.byte $00, $00        ; 47 ;
.byte $00, $00        ; 48 ;
.byte $00, $00        ; 49 ;
.byte $00, $00        ; 4A ;
.byte $00, $00        ; 4B ;
.byte $00, $00        ; 4C ;
.byte $00, $00        ; 4D ;
.byte $00, $00        ; 4E ;
.byte $00, $00        ; 4F ;
.byte $00, $00        ; 50 ;
.byte $00, $00        ; 51 ;
.byte $00, $00        ; 52 ;
.byte $00, $00        ; 53 ;
.byte $00, $00        ; 54 ;
.byte $00, $00        ; 55 ;
.byte $00, $00        ; 56 ;
.byte $00, $00        ; 57 ;
.byte $00, $00        ; 58 ;
.byte $00, $00        ; 59 ;
.byte $00, $00        ; 5A ;
.byte $00, $00        ; 5B ;
.byte $00, $00        ; 5C ;
.byte $00, $00        ; 5D ;
.byte $00, $00        ; 5E ;
.byte $00, $00        ; 5F ;
.byte $00, $00        ; 60 ;
.byte $00, $00        ; 61 ;
.byte $00, $00        ; 62 ;
.byte $00, $00        ; 63 ;
.byte $00, $00        ; 64 ;
.byte $00, $00        ; 65 ;
.byte $00, $00        ; 66 ;
.byte $00, $00        ; 67 ;
.byte $00, $00        ; 68 ;
.byte $00, $00        ; 69 ;
.byte $00, $00        ; 6A ;
.byte $00, $00        ; 6B ;
.byte $00, $00        ; 6C ;
.byte $00, $00        ; 6D ;
.byte $00, $00        ; 6E ;
.byte $00, $00        ; 6F ;
.byte $00, $00        ; 70 ;
.byte $00, $00        ; 71 ;
.byte $00, $00        ; 72 ;
.byte $00, $00        ; 73 ;
.byte $00, $00        ; 74 ;
.byte $00, $00        ; 75 ;
.byte $00, $00        ; 76 ;
.byte $00, $00        ; 77 ;
.byte $00, $00        ; 78 ;
.byte $00, $00        ; 79 ;
.byte $00, $00        ; 7A ;
.byte $00, $00        ; 7B ;
.byte $00, $00        ; 7C ;
.byte $00, $00        ; 7D ;
.byte $00, $00        ; 7E ;
.byte $00, $00        ; 7F ;
.byte $00, $00        ; 80 ;
.byte $00, $00        ; 81 ;
.byte $00, $00        ; 82 ;
.byte $00, $00        ; 83 ;
.byte $00, $00        ; 84 ;
.byte $00, $00        ; 85 ;
.byte $00, $00        ; 86 ;
.byte $00, $00        ; 87 ;
.byte $00, $00        ; 88 ;
.byte $00, $00        ; 89 ;
.byte $00, $00        ; 8A ;
.byte $00, $00        ; 8B ;
.byte $00, $00        ; 8C ;
.byte $00, $00        ; 8D ;
.byte $00, $00        ; 8E ;
.byte $00, $00        ; 8F ;
.byte $00, $00        ; 90 ;
.byte $00, $00        ; 91 ;
.byte $00, $00        ; 92 ;
.byte $00, $00        ; 93 ;
.byte $00, $00        ; 94 ;
.byte $00, $00        ; 95 ;
.byte $00, $00        ; 96 ;
.byte $00, $00        ; 97 ;
.byte $00, $00        ; 98 ;
.byte $00, $00        ; 99 ;
.byte $00, $00        ; 9A ;
.byte $00, $00        ; 9B ;
.byte $00, $00        ; 9C ;
.byte $00, $00        ; 9D ;
.byte $00, $00        ; 9E ;
.byte $00, $00        ; 9F ;
.byte $00, $00        ; A0 ;
.byte $00, $00        ; A1 ;
.byte $00, $00        ; A2 ;
.byte $00, $00        ; A3 ;
.byte $00, $00        ; A4 ;
.byte $00, $00        ; A5 ;
.byte $00, $00        ; A6 ;
.byte $00, $00        ; A7 ;
.byte $00, $00        ; A8 ;
.byte $00, $00        ; A9 ;
.byte $00, $00        ; AA ;
.byte $00, $00        ; AB ;
.byte $00, $00        ; AC ;
.byte $00, $00        ; AD ;
.byte $00, $00        ; AE ;
.byte $00, $00        ; AF ;
.byte $00, $00        ; B0 ;
.byte $00, $00        ; B1 ;
.byte $00, $00        ; B2 ;
.byte $00, $00        ; B3 ;
.byte $00, $00        ; B4 ;
.byte $00, $00        ; B5 ;
.byte $00, $00        ; B6 ;
.byte $00, $00        ; B7 ;
.byte $00, $00        ; B8 ;
.byte $00, $00        ; B9 ;
.byte $00, $00        ; BA ;
.byte $00, $00        ; BB ;
.byte $00, $00        ; BC ;
.byte $00, $00        ; BD ;
.byte $00, $00        ; BE ;
.byte $00, $00        ; BF ;
.byte $00, $00        ; C0 ;
.byte $00, $00        ; C1 ;
.byte $00, $00        ; C2 ;
.byte $00, $00        ; C3 ;
.byte $00, $00        ; C4 ;
.byte $00, $00        ; C5 ;
.byte $00, $00        ; C6 ;
.byte $00, $00        ; C7 ;
.byte $00, $00        ; C8 ;
.byte $00, $00        ; C9 ;
.byte $00, $00        ; CA ;
.byte $00, $00        ; CB ;
.byte $00, $00        ; CC ;
.byte $00, $00        ; CD ;
.byte $00, $00        ; CE ;
.byte $00, $00        ; CF ;
.byte $00, $00        ; D0 ;
.byte $00, $00        ; D1 ;
.byte $00, $00        ; D2 ;
.byte $00, $00        ; D3 ;
.byte $00, $00        ; D4 ;
.byte $00, $00        ; D5 ;
.byte $00, $00        ; D6 ;
.byte $00, $00        ; D7 ;
.byte $00, $00        ; D8 ;
.byte $00, $00        ; D9 ;
.byte $00, $00        ; DA ;
.byte $00, $00        ; DB ;
.byte $00, $00        ; DC ;
.byte $00, $00        ; DD ;
.byte $00, $00        ; DE ;
.byte $00, $00        ; DF ;
.byte $00, $00        ; E0 ;
.byte $00, $00        ; E1 ;
.byte $00, $00        ; E2 ;
.byte $00, $00        ; E3 ;
.byte $00, $00        ; E4 ;
.byte $00, $00        ; E5 ;
.byte $00, $00        ; E6 ;
.byte $00, $00        ; E7 ;
.byte $00, $00        ; E8 ;
.byte $00, $00        ; E9 ;
.byte $00, $00        ; EA ;
.byte $00, $00        ; EB ;
.byte $00, $00        ; EC ;
.byte $00, $00        ; ED ;
.byte $00, $00        ; EE ;
.byte $00, $00        ; EF ;
.byte $00, $00        ; F0 ;
.byte $00, $00        ; F1 ;
.byte $00, $00        ; F2 ;
.byte $00, $00        ; F3 ;
.byte $00, $00        ; F4 ;
.byte $00, $00        ; F5 ;
.byte $00, $00        ; F6 ;
.byte $00, $00        ; F7 ;
.byte $00, $00        ; F8 ;
.byte $00, $00        ; F9 ;
.byte $00, $00        ; FA ;
.byte $00, $00        ; FB ;
.byte $00, $00        ; FC ;
.byte $00, $00        ; FD ;
.byte $00, $00        ; FE ;
.byte $00, $00        ; FF ;



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;                                                   ;;;;;;;;;;;;;;;;;;;; 
;;;;;;;;;;;;;;;;;              MENU TEXT FROM BANK 0E               ;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;                                                   ;;;;;;;;;;;;;;;;;;;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  LUT for menu text  [$8500 :: 0x38510]
;;
;;    This is a table of complex strings used in menus.

;; A few things were edited to fit the new menu layouts.

lut_MenuText:                 
.word M_Gold                          ; 0  ; 0 
.word M_Options                       ; 1  ; 1 
.word M_ItemTitle                     ; 2  ; 2 
.word M_QuestItemsTitle               ; 3  ; 3 
.word M_EquipPage1                    ; 4  ; 4 
.word M_EquipPage2                    ; 5  ; 5 
.word M_EquipPage3                    ; 6  ; 6 
.word M_Char1Name                     ; 7  ; 7 
.word M_Char2Name                     ; 8  ; 8 
.word M_Char3Name                     ; 9  ; 9 
.word M_Char4Name                     ; A  ; 10
.word M_EquipNameClass                ; B  ; 11
.word M_EquipmentSlots                ; C  ; 12
.word M_EquipStats                    ; D  ; 13
.word M_MP_List_Level                 ; E  ; 14
.word M_MP_List_MP                    ; F  ; 15
.word M_Elixir_List_MP                ; 10 ; 16
.word M_HP_List                       ; 11 ; 17
.word M_MagicList                     ; 12 ; 18
.word M_CharLevelStats                ; 13 ; 19
.word M_CharMainStats                 ; 14 ; 20
.word M_CharSubStats                  ; 15 ; 21
.word M_ItemNothing                   ; 16 ; 22
.word M_KeyItem1_Desc                 ; 17 ; 23 ; Lute
.word M_KeyItem2_Desc                 ; 18 ; 24 ; Crown
.word M_KeyItem3_Desc                 ; 19 ; 25 ; Crystal
.word M_KeyItem4_Desc                 ; 1A ; 26 ; Herb
.word M_KeyItem5_Desc                 ; 1B ; 27 ; Mystic Key
.word M_KeyItem6_Desc                 ; 1C ; 28 ; TNT
.word M_KeyItem7_Desc                 ; 1D ; 29 ; Adamant
.word M_KeyItem8_Desc                 ; 1E ; 30 ; Slab
.word M_KeyItem9_Desc                 ; 1F ; 31 ; Ruby
.word M_KeyItem10_Desc                ; 20 ; 32 ; Rod
.word M_KeyItem11_Desc                ; 21 ; 33 ; Floater
.word M_KeyItem12_Desc                ; 22 ; 34 ; Chime
.word M_KeyItem13_Desc                ; 23 ; 35 ; Tail
.word M_KeyItem14_Desc                ; 24 ; 36 ; Cube
.word M_KeyItem15_Desc                ; 25 ; 37 ; Bottle
.word M_KeyItem16_Desc                ; 26 ; 38 ; Oxyale
.word M_KeyItem17_Desc                ; 27 ; 39 ; Canoe
.word M_KeyItem1_Use                  ; 28 ; 40 ; Lute use
.word M_KeyItem10_Use                 ; 29 ; 41 ; Rod use
.word M_KeyItem11_Use                 ; 2A ; 42 ; Floater use
.word M_KeyItem15_Use                 ; 2B ; 43 ; Bottle use
.word M_ItemHeal                      ; 2C ; 44 ; CURE magic
.word M_ItemEther                     ; 2D ; 45
.word M_ItemElixir                    ; 2E ; 46 
.word M_ItemPure                      ; 2F ; 47 ; PURE magic
.word M_ItemSoft                      ; 30 ; 48 ; SOFT magic
.word M_ItemPhoenixDown               ; 31 ; 49 ; LIFE magic
.word M_ItemAlarmClock                ; 32 ; 50
.word M_ItemEyedrop                   ; 33 ; 51
.word M_ItemSmokebomb                 ; 34 ; 52
.word M_ItemUseTentCabin              ; 35 ; 53 ; HEAL magic
.word M_ItemUseTentCabin_Save         ; 36 ; 54
.word M_ItemUseHouse_Save             ; 37 ; 55
.word M_ItemUseHouse                  ; 38 ; 56
.word M_ItemCannotSleep               ; 39 ; 57
.word M_NowSaving                     ; 3A ; 58
.word M_ItemCannotUse                 ; 3B ; 59
.word M_HealMagic                     ; 3C ; 60 ; unused
.word M_WarpMagic                     ; 3D ; 61
.word M_ExitMagic                     ; 3E ; 62
.word M_NoMana                        ; 3F ; 63
.word M_CannotUseMagic                ; 40 ; 64
.word M_OrbGoldBoxLink                ; 41 ; 65
.word M_ItemSubmenu                   ; 42 ; 66
.word M_MagicSubmenu                  ; 43 ; 67
.word M_MagicCantLearn                ; 44 ; 68
.word M_MagicAlreadyKnow              ; 45 ; 69
.word M_MagicLevelFull                ; 46 ; 70
.word M_MagicForget                   ; 47 ; 71
.word M_MagicMenuSpellLevel_Right     ; 48 ; 72
.word M_MagicMenuSpellLevel_LeftRight ; 49 ; 73
.word M_MagicMenuSpellLevel_Left      ; 4A ; 74
.word M_ItemNothing                   ; 4B ; 75 ; unused
.word M_MagicMenuOrbs                 ; 4C ; 76 ; unused
.word M_MagicNameLearned              ; 4D ; 77
.word M_EquipPage4                    ; 4E ; 78 ; don't feel like re-formatting all the codes again... New stuff is unorganized here.
.word M_EquipSubMenu                  ; 4F ; 79 ; 
.word M_MagicMenuMPTitle              ; 50 ; 80 ; MP in magic menu title
.word M_EquipStats_Blank              ; 51 ; 81 ; 
.word M_EquipInventoryWeapon          ; 52 ; 82 ; 
.word M_EquipInventoryArmor           ; 53 ; 83 ; 
.word M_EquipInventorySelect          ; 54 ; 84 ; 
.word M_KeyItem18_Desc                ; 55 ; 85 ; 
.word M_LampMagic                     ; 56 ; 86 ; LAMP magic
.word M_EquipInventoryClear           ; 57 ; 87 ; 

M_Gold: 
.byte $04,$FF,$90,$00 ; _G - for gold on menu

M_Options:
.byte $92,$9D,$8E,$96,$9C,$01 ; ITEMS 
.byte $96,$8A,$90,$92,$8C,$01 ; MAGIC
.byte $8E,$9A,$9E,$92,$99,$01 ; EQUIP
.byte $CA,$CB,$CC,$CD,$CE,$01 ; STATUS
.byte $CF,$D0,$D1,$D2,$97,$01 ; OPTION
.byte $9C,$8A,$9F,$8E,$E8,$00 ; SAVE (Heart)

M_ItemTitle: 
.byte $FF,$92,$9D,$8E,$96,$9C,$00 ; ITEMS

M_QuestItemsTitle: 
.byte $FF,$9A,$9E,$8E,$9C,$9D,$00 ; QUEST

M_EquipPage1:  
.byte $FF,$FF,$8E,$B4,$B8,$AC,$B3,$34,$B1,$21,$8B,$A4,$47,$81,$FF,$C7,$00

M_EquipPage2:   
.byte $C1,$FF,$8E,$B4,$B8,$AC,$B3,$34,$B1,$21,$8B,$A4,$47,$82,$FF,$C7,$00

M_EquipPage3:
.byte $C1,$FF,$8E,$B4,$B8,$AC,$B3,$34,$B1,$21,$8B,$A4,$47,$83,$FF,$C7,$00

M_EquipPage4:
.byte $C1,$FF,$8E,$B4,$B8,$AC,$B3,$34,$B1,$21,$8B,$A4,$47,$84,$00

M_Char1Name:   
.byte $10,$00,$00 ; Character 1's name

M_Char2Name:   
.byte $11,$00,$00 ; Character 2's name

M_Char3Name:  
.byte $12,$00,$00 ; Character 3's name

M_Char4Name:   
.byte $13,$00,$00 ; Character 4's name

M_EquipNameClass:  
.byte $10,$00,$09,$08,$10,$01,$00 ; name, 8 spaces, then class

M_EquipmentSlots:
.byte $9B,$AC,$AA,$AB,$21,$91,$22,$A7,$FF,$FF,$C8,$09,$08,$C9,$FF,$D4,$01   ; RIGHT_HAND__[________]_*
.byte $95,$A8,$A9,$21,$FF,$91,$22,$A7,$FF,$FF,$C8,$09,$08,$C9,$FF,$DB,$01   ; LEFT__HAND__[________]_*
.byte $91,$2B,$A7,$09,$08,$C8,$09,$08,$C9,$FF,$DC,$01                       ; HEAD________[________]_*
.byte $8B,$B2,$A7,$BC,$09,$08,$C8,$09,$08,$C9,$FF,$DA,$01                   ; BODY________[________]_*
.byte $91,$22,$A7,$B6,$09,$07,$C8,$09,$08,$C9,$FF,$DD,$01                   ; HANDS_______[________]_*
.byte $8A,$A6,$48,$B6,$B6,$35,$BC,$09,$03,$C8,$09,$08,$C9,$FF,$DE,$01       ; ACCESSORY___[________]_*
.byte $8B,$39,$B7,$45,$FF,$92,$53,$B0,$FF,$C8,$09,$08,$C9,$FF,$D8,$01       ; BATTLE_ITEM_[________]_*
.byte $8B,$39,$B7,$45,$FF,$92,$53,$B0,$FF,$C8,$09,$08,$C9,$FF,$D8,$00       ; BATTLE_ITEM_[________]_*

M_EquipStats:
.byte $8D,$A4,$B0,$A4,$66,$09,$03,  $10,$16,$FF,$FF      ; Damage___##__
.byte $8D,$A8,$A9,$3A,$3E,$FF,$FF,  $10,$18,$01          ; Defense__##
.byte $8A,$A6,$A6,$55,$5E,$4B,      $10,$17,$FF,$FF      ; Accuracy_##__
.byte $8E,$B9,$3F,$AC,$3C,$FF,$FF,  $10,$19,$01          ; Evasion__##
.byte $8C,$5C,$57,$51,$AF,$FF,      $10,$1B,$FF,$FF      ; Critical_##__
.byte $96,$C0,$9B,$2C,$30,$B7,$FF,  $10,$1A,$00          ; M.Resist_## 

M_MP_List_Level:  
.byte $95,$81,$01
.byte $95,$82,$01
.byte $95,$83,$01
.byte $95,$84,$01
.byte $95,$85,$01
.byte $95,$86,$01
.byte $95,$87,$01
.byte $95,$88,$00

M_MP_List_MP:
.byte $10,$20,$7A,$10,$30,$01 ; lists current MP / max MP veritcally
.byte $10,$21,$7A,$10,$31,$01
.byte $10,$22,$7A,$10,$32,$01
.byte $10,$23,$7A,$10,$33,$01
.byte $10,$24,$7A,$10,$34,$01
.byte $10,$25,$7A,$10,$35,$01
.byte $10,$26,$7A,$10,$36,$01
.byte $10,$27,$7A,$10,$37,$00

M_Elixir_List_MP: ; lists current MP / current MP / etc, horizontally
.byte $96,$99,$FF,$FF,$10,$20,$7A,$10,$21,$7A,$10,$22,$7A,$10,$23,$7A,$10,$24,$7A,$10,$25,$7A,$10,$26,$7A,$10,$27,$00

M_HP_List: 
.byte $10,$00,$FF,$10,$02,$FF,$10,$05,$7A,$10,$06,$00 ; lists name, ailment, and current HP horizontally

M_MagicList: 
.byte $95,$81,$FF,$FF,$10,$40,$FF,$FF,$10,$41,$FF,$FF,$10,$42,$01
.byte $95,$82,$FF,$FF,$10,$43,$FF,$FF,$10,$44,$FF,$FF,$10,$45,$01
.byte $95,$83,$FF,$FF,$10,$46,$FF,$FF,$10,$47,$FF,$FF,$10,$48,$01
.byte $95,$84,$FF,$FF,$10,$49,$FF,$FF,$10,$4A,$FF,$FF,$10,$4B,$01
.byte $95,$85,$FF,$FF,$10,$4C,$FF,$FF,$10,$4D,$FF,$FF,$10,$4E,$01
.byte $95,$86,$FF,$FF,$10,$4F,$FF,$FF,$10,$50,$FF,$FF,$10,$51,$01
.byte $95,$87,$FF,$FF,$10,$52,$FF,$FF,$10,$53,$FF,$FF,$10,$54,$01
.byte $95,$88,$FF,$FF,$10,$55,$FF,$FF,$10,$56,$FF,$FF,$10,$57,$00

;     |L  #    __ cc  MP   /  max MP   __  __ spel1 1  __ spell 2  __ spell 3 
;.byte $7E,$81,$FF,$10,$2C,$7A,$10,$34,$FF,$FF,$10,$14,$FF,$10,$15,$FF,$10,$16,$01
;.byte $7E,$82,$FF,$10,$2D,$7A,$10,$35,$FF,$FF,$10,$17,$FF,$10,$18,$FF,$10,$19,$01
;.byte $7E,$83,$FF,$10,$2E,$7A,$10,$36,$FF,$FF,$10,$1A,$FF,$10,$1B,$FF,$10,$1C,$01
;.byte $7E,$84,$FF,$10,$2F,$7A,$10,$37,$FF,$FF,$10,$1D,$FF,$10,$1E,$FF,$10,$1F,$01
;.byte $7E,$85,$FF,$10,$30,$7A,$10,$38,$FF,$FF,$10,$20,$FF,$10,$21,$FF,$10,$22,$01
;.byte $7E,$86,$FF,$10,$31,$7A,$10,$39,$FF,$FF,$10,$23,$FF,$10,$24,$FF,$10,$25,$01
;.byte $7E,$87,$FF,$10,$32,$7A,$10,$3A,$FF,$FF,$10,$26,$FF,$10,$27,$FF,$10,$28,$01
;.byte $7E,$88,$FF,$10,$33,$7A,$10,$3B,$FF,$FF,$10,$29,$FF,$10,$2A,$FF,$10,$2B,$00

M_CharLevelStats: 
.byte $10,$00,$01                                     ; NAME
.byte $10,$01,$01                                     ; Class
.byte $95,$A8,$32,$AF,$09,$05,$10,$03,$01             ; Level ##
.byte $8E,$BB,$B3,$C0,$FF,$FF,$10,$04,$01             ; Exp.  ## 
.byte $97,$A8,$BB,$B7,$09,$03,$10,$1E,$00             ; Next  ##

M_CharMainStats: 
.byte $9C,$B7,$23,$2A,$1C,$FF,$FF,$10,$11,$09,$04,  $8D,$A4,$B0,$A4,$66,$09,$03,  $10,$16,$01 ; Strength__##____Damage___###
.byte $8A,$AA,$61,$5B,$4B,$FF,$FF,$10,$12,$09,$04,  $8A,$A6,$A6,$55,$5E,$4B,      $10,$17,$01 ; Agility___##____Accuracy_###
.byte $92,$B1,$53,$4E,$A8,$A6,$21,$10,$13,$09,$04,  $8C,$5C,$57,$51,$AF,$FF,      $10,$1B,$01 ; Intellect_##____Critical_###
.byte $9F,$5B,$5F,$5B,$4B,$FF,    $10,$14,$09,$04,  $8D,$A8,$A9,$3A,$3E,$FF,$FF,  $10,$18,$01 ; Vitality__##____Defense__###
.byte $9C,$B3,$A8,$40,$09,$05,    $10,$15,$09,$04,  $8E,$B9,$3F,$AC,$3C,$FF,$FF,  $10,$19,$01 ; Speed_____##____Evasion__###
.byte $96,$35,$A4,$45,$09,$03,    $10,$1C,$09,$04,  $96,$C0,$9B,$2C,$30,$B7,$FF,  $10,$1A,$00 ; Morale___###____M.Resist_###

;.byte $9C,$B7,$23,$2A,$1C,$FF,$FF,$10,$07,$01         ; Strength__ 
;.byte $8A,$AA,$61,$5B,$4B,$FF,$FF,$10,$08,$01         ; Agility___  
;.byte $92,$B1,$53,$4E,$A8,$A6,$21,$10,$09,$01         ; Intellect_
;.byte $9F,$5B,$5F,$5B,$4B,$FF,$10,$0A,$01             ; Vitality__
;.byte $9C,$B3,$A8,$40,$09,$05,$10,$0B,$01             ; Speed_____    
;.byte $9C,$B3,$AC,$5C,$21,$FF,$FF,$00                 ; Spirit___
;
M_CharSubStats: 
;.byte $8D,$A4,$B0,$A4,$66,$09,$03,$10,$3C,$01         ; Damage___###
;.byte $8A,$A6,$A6,$55,$5E,$4B,$10,$3D,$01             ; Accuracy_###
;.byte $8C,$5C,$57,$51,$AF,$FF,$10,$44,$01             ; Critical_###
;.byte $8D,$A8,$A9,$3A,$3E,$FF,$FF,$10,$3E,$01         ; Defense__###
;.byte $8E,$B9,$3F,$AC,$3C,$FF,$FF,$10,$3F,$01         ; Evasion__###
;.byte $96,$C0,$8E,$B9,$A4,$A7,$A8,$FF,$FF,$10,$41,$00 ; M.Evade__###

M_ItemNothing:
.byte $A2,$B2,$64,$41,$B9,$1A,$B1,$B2,$1C,$1F,$AA,$C0,$00 ; You have nothing.

M_KeyItem1_Desc: 
.byte $8B,$A8,$A4,$B8,$57,$A9,$B8,$AF,$42,$B8,$B6,$AC,$A6,$43,$AC,$4E,$B6,$01
.byte $B7,$AB,$1A,$A4,$AC,$B5,$C0,$00 ; Beautiful music fills[enter]the air.

M_KeyItem2_Desc: 
.byte $9D,$AB,$1A,$B6,$28,$45,$29,$8C,$9B,$98,$A0,$97,$C0,$00 ; The stolen CROWN.

M_KeyItem3_Desc:
.byte $8A,$FF,$A5,$A4,$4E,$42,$A4,$A7,$1A,$4C,$FF,$8C,$9B,$A2,$9C,$9D,$8A,$95,$C0,$00 ; A ball made of CRYSTAL.

M_KeyItem4_Desc: 
.byte $A2,$B8,$A6,$AE,$C4,$FF,$9D,$3D,$1E,$34,$A7,$AC,$A6,$1F,$A8,$01
.byte $AC,$B6,$1B,$B2,$2E,$A5,$5B,$B7,$25,$C4,$00 ; Yuck! This medicine[enter]is too bitter!

M_KeyItem5_Desc:
.byte $9D,$AB,$1A,$B0,$BC,$37,$AC,$A6,$FF,$94,$8E,$A2,$C0,$00 ; The mystic KEY.

M_KeyItem6_Desc: 
.byte $8B,$A8,$38,$A4,$23,$A9,$B8,$AF,$C4,$00 ; Be careful!

M_KeyItem7_Desc:  
.byte $9D,$AB,$1A,$45,$AA,$3A,$A7,$2F,$4B,$34,$B7,$5F,$C0,$00 ; The legendary metal.

M_KeyItem8_Desc:  
.byte $9E,$B1,$AE,$B1,$46,$B1,$24,$BC,$B0,$A5,$B2,$AF,$1E,$A6,$B2,$B9,$25,$01
.byte $B7,$AB,$1A,$9C,$95,$8A,$8B,$C0,$00 ; Unknown symbols cover[enter]the SLAB.

M_KeyItem9_Desc:  
.byte $8A,$FF,$AF,$2F,$AA,$1A,$23,$A7,$24,$28,$5A,$C0,$00 ; A large red stone.

M_KeyItem10_Desc:  
.byte $9D,$AB,$1A,$9B,$98,$8D,$1B,$2E,$23,$B0,$B2,$B9,$1A,$1C,$A8,$01
.byte $B3,$AF,$39,$1A,$A9,$B5,$49,$1B,$AB,$1A,$2B,$B5,$1C,$C0,$00 ; The ROD to remove the[enter]plate from the earth.

M_KeyItem11_Desc: 
.byte $8A,$FF,$B0,$BC,$37,$25,$AC,$26,$1E,$4D,$A6,$AE,$C0,$00 ; A mysterious rock.

M_KeyItem12_Desc: 
.byte $9C,$B7,$A4,$B0,$B3,$A8,$27,$3C,$1B,$AB,$1A,$A5,$B2,$B7,$28,$B0,$69,$01
.byte $96,$8A,$8D,$8E,$FF,$92,$97,$FF,$95,$8E,$8F,$8E,$92,$97,$00 ; Stamped on the bottom..[enter]MADE IN LEFEIN. 

M_KeyItem13_Desc: 
.byte $98,$98,$91,$91,$C4,$C4,$FF,$92,$21,$37,$1F,$AE,$B6,$C4,$01
.byte $9D,$AB,$B5,$46,$2D,$21,$B2,$B9,$25,$69,$01
.byte $97,$B2,$C4,$FF,$8D,$3C,$BE,$21,$A7,$B2,$1B,$AB,$39,$C4,$C4,$00 ; OOHH!! It stinks![enter]Throw it over..[enter]No! Don't do that!!

M_KeyItem14_Desc:
.byte $8C,$B2,$AF,$35,$1E,$AA,$A4,$1C,$25,$20,$3B,$01
.byte $B6,$BA,$AC,$B5,$58,$1F,$1B,$AB,$1A,$8C,$9E,$8B,$8E,$C0,$00 ; Colors gather and[enter]swirl in the CUBE.

M_KeyItem15_Desc: 
;.byte $92,$B7,$2D,$1E,$A8,$B0,$B3,$B7,$BC,$C0,$00 ; It is empty.

M_KeyItem16_Desc:
.byte $9D,$AB,$1A,$98,$A1,$A2,$8A,$95,$8E,$43,$55,$B1,$30,$1D,$B6,$01
.byte $A9,$B5,$2C,$AB,$20,$AC,$B5,$C0,$00 ; The OXYALE furnishes[enter]fresh air. 

M_KeyItem17_Desc: 
.byte $A2,$B2,$B8,$38,$22,$FF,$A6,$4D,$B6,$B6,$1B,$AB,$1A,$5C,$B9,$25,$C0,$00 ; You can cross the river.

M_KeyItem18_Desc:
.byte $C6,$9D,$1D,$23,$BE,$1E,$B1,$2E,$B3,$AC,$A6,$B7,$55,$2C,$C5,$C4,$BE,$01
.byte $C6,$9E,$3E,$50,$26,$44,$AC,$B0,$A4,$AA,$1F,$39,$AC,$3C,$C4,$BE,$01
.byte $C6,$8A,$BA,$BF,$1B,$41,$B7,$BE,$1E,$A5,$35,$1F,$AA,$C4,$BE,$00

M_KeyItem1_Use:
.byte $9D,$AB,$1A,$B7,$B8,$B1,$1A,$B3,$AF,$A4,$BC,$B6,$BF,$01
.byte $B5,$A8,$B9,$2B,$AF,$1F,$AA,$20,$24,$B7,$A4,$AC,$B5,$5D,$BC,$C0,$00 ; The tune plays,[enter]revealing a stairway.

M_KeyItem10_Use: 
.byte $9D,$AB,$1A,$B3,$AF,$39,$1A,$B6,$AB,$39,$B7,$25,$B6,$BF,$01
.byte $B5,$A8,$B9,$2B,$AF,$1F,$AA,$20,$24,$B7,$A4,$AC,$B5,$5D,$BC,$C4,$00 ; The plate shatters,[enter]revealing a stairway!

M_KeyItem11_Use: 
.byte $9D,$AB,$1A,$8A,$92,$9B,$9C,$91,$92,$99,$31,$A8,$AA,$1F,$B6,$1B,$B2,$01
.byte $B5,$AC,$B6,$1A,$A9,$B5,$49,$1B,$AB,$1A,$A7,$2C,$25,$B7,$C0,$00 ; The AIRSHIP begins to[enter]rise from the desert.

M_KeyItem15_Use: 
.byte $99,$B2,$B3,$C4,$FF,$8A,$43,$A4,$AC,$B5,$BC,$20,$B3,$B3,$2B,$63,$BF,$01
.byte $B7,$AB,$A8,$29,$AC,$1E,$AA,$3C,$A8,$C0,$00 ; Pop! A fairy appears,[enter]then is gone.

M_ItemHeal:  
M_CureMagic:
.byte $9E,$3E,$1B,$2E,$23,$A6,$B2,$32,$44,$91,$99,$C0,$00 ; Use to recover HP.[END]

M_ItemEther:
.byte $9E,$3E,$1B,$2E,$23,$A6,$B2,$32,$44,$96,$99,$01
.byte $A9,$35,$36,$5A,$24,$B3,$A8,$4E,$65,$A8,$32,$AF,$C0,$00 ; Use to recover MP[ENTER]for one spell level.[END]

M_ItemElixir:
.byte $9E,$3E,$1B,$2E,$23,$A6,$B2,$32,$44,$5F,$58,$91,$99,$20,$3B,$FF,$96,$99,$C0,$00 ; Use to recover all HP and MP.[END]

M_ItemPure:  
M_PureMagic:
.byte $9E,$3E,$1B,$2E,$A6,$55,$1A,$B3,$B2,$30,$3C,$C0,$00 ; Use to cure poison.[END]

M_ItemSoft:  
M_SoftMagic:
.byte $9E,$3E,$1B,$2E,$23,$37,$35,$1A,$1C,$A8,$05
.byte $A5,$B2,$A7,$4B,$A9,$4D,$B0,$4F,$A8,$B7,$5C,$A9,$AC,$51,$57,$3C,$C0,$00 ; Use to restore the[ENTER]body from petrification.[END]

M_ItemPhoenixDown:
M_LifeMagic:
.byte $9E,$3E,$1B,$2E,$23,$B9,$AC,$32,$1B,$1D,$24,$B3,$AC,$5C,$B7,$C0,$00 ; Use to revive the spirit.[END]

M_ItemAlarmClock:
.byte $9E,$3E,$1B,$2E,$4D,$B8,$3E,$1B,$1D,$4F,$2F,$B7,$BC,$01
.byte $A9,$4D,$B0,$24,$45,$A8,$B3,$2D,$29,$A5,$39,$B7,$45,$C0,$00 ; Use to rouse the party[ENTER]from sleep in battle.[END]

M_ItemEyedrop:
.byte $9E,$3E,$1B,$2E,$23,$AA,$A4,$1F,$FF,$B6,$AC,$AA,$AB,$B7,$C0,$00 ; Use to regain sight.[END]

M_ItemSmokebomb:
.byte $9E,$3E,$1B,$2E,$3D,$A7,$1A,$A8,$32,$B5,$56,$5A,$2D,$29,$A5,$39,$B7,$45,$01
.byte $B2,$44,$A8,$AF,$B8,$A7,$1A,$3A,$A8,$B0,$AC,$2C,$2D,$29,$A7,$B8,$2A,$A8,$3C,$B6,$C0,$01 ; Use to hide everyone in battle,[ENTER]Or elude enemies in dungeons.[END]
.byte $9E,$3E,$FF,$AC,$B7,$C5,$FF,$99,$B8,$B6,$AB,$FF,$8A,$69,$A2,$8E,$9C,$FF,$99,$B8,$B6,$AB,$FF,$8B,$69,$97,$98,$00 ; Use it? Push A..YES Push B..NO

M_ItemUseTentCabin:
.byte $9B,$A8,$A6,$B2,$32,$44,$91,$99,$43,$35,$20,$4E,$C5,$01
.byte $99,$B8,$B6,$AB,$FF,$8A,$69,$A2,$8E,$9C,$01
.byte $99,$B8,$B6,$AB,$FF,$8B,$69,$97,$98,$00; Recover HP for all?[ENTER]Push A..YES[ENTER]Push B..NO[END]

M_ItemUseTentCabin_Save:
.byte $91,$99,$FF,$23,$A6,$B2,$32,$23,$A7,$C0,$FF,$9C,$A4,$32,$C5,$01
.byte $99,$B8,$B6,$AB,$FF,$8A,$69,$A2,$8E,$9C,$01
.byte $99,$B8,$B6,$AB,$FF,$8B,$69,$97,$98,$00 ; HP recovered. SAVE?[enter]Push A..YES[enter]Push B..NO

M_ItemUseHouse_Save:
.byte $91,$99,$20,$3B,$FF,$96,$99,$FF,$23,$A6,$B2,$32,$23,$A7,$C0,$FF,$9C,$A4,$32,$C5,$01
.byte $99,$B8,$B6,$AB,$FF,$8A,$69,$A2,$8E,$9C,$01
.byte $99,$B8,$B6,$AB,$FF,$8B,$69,$97,$98,$00 ; HP and MP recovered. Save?[ENTER]Push A..YES[ENTER]Push B..NO[END]

M_ItemUseHouse:  
.byte $9B,$A8,$A6,$B2,$32,$44,$91,$99,$20,$3B,$FF,$96,$99,$43,$35,$20,$4E,$C5,$01
.byte $99,$B8,$B6,$AB,$FF,$8A,$69,$A2,$8E,$9C,$01
.byte $99,$B8,$B6,$AB,$FF,$8B,$69,$97,$98,$00 ; Recover HP and MP for all?[ENTER]Push A..YES[ENTER]Push B..NO[END]

M_ItemCannotSleep:  
.byte $FF,$A2,$B2,$B8,$38,$22,$B1,$B2,$21,$B6,$45,$A8,$B3,$FF,$1D,$23,$C4,$00 ; You cannot sleep here!

M_NowSaving:   
.byte $FF,$97,$B2,$BA,$24,$A4,$B9,$1F,$AA,$69,$C4,$00 ; Now saving...! 

M_ItemCannotUse: 
.byte $FF,$A2,$B2,$B8,$38,$22,$B1,$B2,$21,$B8,$B6,$1A,$AC,$21,$1D,$23,$C4,$00 ; You cannot use it here!

M_HealMagic:   ; unused

M_WarpMagic:  
.byte $FF,$8A,$FF,$B0,$A4,$AA,$AC,$A6,$1B,$2E,$23,$B7,$55,$29,$3C,$A8,$01
.byte $FF,$A9,$AF,$B2,$35,$C0,$FF,$97,$46,$33,$2F,$B3,$31,$5E,$AE,$C4,$00 ; A magic to return one[enter]floor. Now warp back!

M_ExitMagic:  
.byte $FF,$95,$B2,$37,$C5,$FF,$97,$2E,$5D,$4B,$26,$B7,$C5,$01
.byte $FF,$92,$B6,$2D,$21,$AB,$B2,$B3,$A8,$AF,$2C,$B6,$C5,$FF,$9E,$B6,$1A,$1C,$30,$01
.byte $FF,$B6,$B3,$A8,$4E,$1B,$2E,$A8,$BB,$5B,$C4,$00 ; Lost? No way out?[return]Is it hopeless? Use this[return]spell to exit!

M_NoMana:  
.byte $FF,$8A,$AF,$AF,$36,$A9,$1B,$41,$21,$45,$32,$AF,$BE,$B6,$01
.byte $FF,$B6,$B3,$A8,$4E,$1E,$2F,$1A,$A8,$BB,$41,$B8,$37,$40,$C0,$00 ; All of that level's[enter]spells are exhausted.

M_CannotUseMagic:  
.byte $FF,$9C,$B2,$B5,$B5,$BC,$BF,$50,$26,$38,$22,$B1,$B2,$21,$B8,$3E,$01
.byte $FF,$B7,$AB,$A4,$21,$B6,$B3,$A8,$4E,$FF,$1D,$23,$C0,$00 ; Sorry, you cannot use[enter]that spell here.

M_OrbGoldBoxLink: ; JIGS - to smooth out the weird orb box shape and timer box...
.byte $6C,$7D,$7D,$7D,$7D,$7D,$7D,$7D,$7D,$6D,$01
.byte $7B,$7E,$7E,$7E,$7E,$7E,$7E,$7E,$7E,$7C,$01,$01,$01,$01,$01,$01,$01
.byte $6C,$7D,$7D,$7D,$7D,$7D,$7D,$7D,$7D,$6D,$00

M_ItemSubmenu:
.byte $FF,$FF,$9E,$3E,$09,$03,$9A,$B8,$2C,$B7,$FF,$92,$B7,$A8,$B0,$B6,$00 ; __ Use ___ Quest Items

M_MagicSubmenu: 
.byte $FF,$FF,$8C,$3F,$21,$FF,$95,$2B,$B5,$29,$FF,$8F,$35,$66,$B7,$00 ; Cast __ Learn __ Forget

M_MagicCantLearn:      
.byte $FF,$A2,$26,$38,$22,$B1,$B2,$21,$45,$2F,$29,$1C,$39,$24,$B3,$A8,$4E,$C0,$00 ; You cannot learn that spell.[END]

M_MagicAlreadyKnow:     
.byte $FF,$A2,$26,$20,$AF,$23,$A4,$A7,$4B,$AE,$B1,$46,$1B,$41,$21,$B6,$B3,$A8,$4E,$C0,$00 ; You already know that spell.[END]

M_MagicLevelFull:       
.byte $FF,$A2,$26,$38,$22,$B1,$B2,$21,$45,$2F,$29,$22,$4B,$B0,$35,$A8,$01
.byte $FF,$B6,$B3,$A8,$4E,$1E,$A9,$35,$1B,$3D,$1E,$B6,$B3,$A8,$4E,$65,$A8,$32,$AF,$C4,$00 ; You cannot learn any more[ENTER]spells for this spell level![END]

M_MagicForget:
.byte $8F,$35,$66,$21,$1C,$30,$24,$B3,$A8,$4E,$C5,$00

M_MagicMenuSpellLevel_Right:
.byte $09,$03,$9C,$B3,$A8,$4E,$FF,$95,$A8,$32,$58,$09,$03,$C7,$00

M_MagicMenuSpellLevel_LeftRight:
.byte $C1,$FF,$FF,$9C,$B3,$A8,$4E,$FF,$95,$A8,$32,$58,$09,$03,$C7,$00

M_MagicMenuSpellLevel_Left:
.byte $C1,$FF,$FF,$9C,$B3,$A8,$4E,$FF,$95,$A8,$32,$58,$09,$04,$00

M_MagicMenuOrbs:
.byte $E5,$01,$E5,$01,$E5,$01,$E5,$01,$E6,$01,$E6,$01,$E6,$01,$E6,$00

M_MagicNameLearned:
.byte $FF,$10,$60,$65,$2B,$B5,$5A,$27,$1C,$1A,$B6,$B3,$A8,$4E,$C4,$00 ; [name] learned the spell! (uses variable width name stat code!)

M_EquipSubMenu:
.byte $FF,$8E,$B4,$B8,$AC,$B3,$FF,$FF,$9B,$A8,$B0,$B2,$B9,$1A,$FF,$8E,$B0,$B3,$B7,$BC,$00


M_MagicMenuMPTitle:
;      0    1   2   3   4   5   6   7   8   9   A   B   C   D   E   F  10  11  12  13
.byte $95,$A8,$B9,$A8,$AF,$FF,$FF,$FF,$96,$99,$FF,$C3,$C3,$FF,$FF,$7A,$FF,$FF,$FF,$00 ; Level___MP_...._*/*__

M_EquipStats_Blank: ; numbers between 2 and 9 are amount of spaces in this string
;; don't draw it with the normal ComplexString setup... it must be loaded into RAM and edited there first!
.byte $8D,$A4,$B0,$A4,$66,$08                 ; Damage___###__ ; later on, stats are added in the # slots
.byte $8D,$A8,$A9,$3A,$3E,$05,$01             ; Defense__###
.byte $8A,$A6,$A6,$55,$5E,$BC,$06             ; Accuracy_###__
.byte $8E,$B9,$3F,$AC,$3C,$05,$01             ; Evasion__###
.byte $8C,$5C,$57,$51,$AF,$06                 ; Critical_###__
.byte $96,$C0,$9B,$2C,$30,$B7,$04,$00         ; M.Resist_###

M_EquipInventoryWeapon:
.byte $C1,$FF,$A0,$2B,$B3,$3C,$B6,$FF,$C7,$00 ; Weapons

M_EquipInventoryArmor: 
.byte $C1,$FF,$FF,$8A,$B5,$B0,$35,$FF,$FF,$C7,$00 ; Armor

M_EquipInventorySelect:
.byte $9E,$3E,$FF,$9C,$B7,$2F,$B7,$7A,$9C,$A8,$45,$A6,$21,$28,$24,$BA,$5B,$A6,$AB,$01
;.byte $09,$03,$9E,$3E,$FF,$9C,$A8,$45,$A6,$21,$28,$24,$BA,$5B,$A6,$AB,$09,$05,$01
.byte $A5,$A8,$B7,$60,$3A,$33,$2B,$B3,$3C,$1E,$22,$27,$2F,$B0,$35,$C0,$00 ; Use Start/Select to switch between weapons and armor.

M_LampMagic:
.byte $8A,$24,$B3,$A8,$4E,$1B,$2E,$23,$37,$35,$1A,$B6,$AC,$AA,$AB,$B7,$C4,$00

M_EquipInventoryClear:
.byte $09,$1A,$00



DrawMenuString_CharCodes_A:
    LDA lut_MenuText, X     ; and load up the pointer into (tmp)
    STA tmp
    LDA lut_MenuText+1, X
    STA tmp+1
    
    LDY LongCall_Y
  @Loop:                    ; now step through each byte of the string....
    LDA (tmp), Y            ; get the byte
    CMP #$10                ; compare it to $10 (charater stat control code)
    BNE :+                  ;   if it equals...
      ORA submenu_targ      ;   OR with desired character ID to draw desired character's stats
  : STA bigstr_buf, Y       ; copy the byte to the big string buffer
    DEY                     ; then decrement Y
    CPY #$FF                ; check to see if it wrapped
    BNE @Loop               ; and keep looping until it has

   ; once the loop is complete and our big string buffer has been filled...

    LDA #<bigstr_buf        ; set the text pointer to our bigstring buffer
    STA text_ptr
    LDA #>bigstr_buf    
    JMP DoText_FromA

DrawMenuString_A:
    LDA lut_MenuText, X
    STA text_ptr
    LDA lut_MenuText+1, X   ; load pointer from table, store to text_ptr  (source pointer for DrawComplexString)
    
DoText_FromA:
    STA text_ptr+1
    LDA #BANK_MENUS
    STA ret_bank
    LDA #BANK_ITEMDESC
    STA cur_bank
    JMP DrawComplexString ;  Draw Complex String, then exit, return to menu








.byte "END OF BANK A"

