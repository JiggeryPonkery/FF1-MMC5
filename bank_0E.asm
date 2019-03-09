.include "variables.inc"
.include "macros.inc"
.include "Constants.inc"

.export ClearNT
;.export EnterLineupMenu
.export EnterMainMenu
.export EnterShop
.export IntroTitlePrepare
.export NewGamePartyGeneration
.export PrintBattleTurn
.export PrintCharStat
.export PrintGold
.export PrintNumber_2Digit
.export PrintPrice
.export TurnMenuScreenOn_ClearOAM

.import AddGPToParty
.import CallMusicPlay
.import CancelNewGame
.import ClearMenuOtherNametables
.import ClearOAM
.import CoordToNTAddr
.import DimBatSprPalettes
.import DoOverworld
.import DrawBox
.import DrawComplexString
.import DrawCursor
.import DrawEquipMenuStrings
.import DrawEquipInventoryStrings
.import DrawImageRect
.import DrawItemBox
.import DrawOBSprite
.import DrawPalette
.import Draw2x2Sprite
.import DrawSimple2x3Sprite
.import EraseBox
.import ExitMenu
.import FadeInBatSprPalettes
.import FadeOutBatSprPalettes
.import FindEmptyWeaponSlot
.import GameStart_L
.import HushTriangle
.import LoadBattleSpritePalettes
.import LoadBridgeSceneGFX_Menu
.import LoadMenuCHRPal
.import LoadNewGameCHRPal
.import LoadPrice
.import LoadPtyGenBGCHRAndPalettes
.import LoadShopCHRPal
.import LoadTitleScreenGFX
.import LongCall
.import Magic_ConvertBitsToBytes
.import MenuCondStall
.import MultiplyXA
.import OptionsMenu
.import PaletteFrame
.import PlaySFX_Error
.import PrintEXPToNext_B
.import RandAX
.import SaveScreen
.import UpdateJoy
.import WaitForVBlank_L
.import lutClassBatSprPalette
.import lut_NTRowStartHi
.import lut_NTRowStartLo
.import ReadjustEquipStats
.import UnadjustEquipStats
.import HideMapObject
.import ShowMapObject


.segment "BANK_0E"


BANK_THIS = $0E

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  LUT containing stock shop text  [$8000 :: 0x38010]

lut_ShopStrings:
;.INCBIN "bin/0E_8000_shopstrings.bin"

;; JIGS - Labeled! First the pointers...

.word ShopWeapon           ; 00    
.word ShopArmor            ; 01  
.word ShopWhiteMagic       ; 02    
.word ShopBlackMagic       ; 03    
.word ShopTemple           ; 04    
.word ShopInn              ; 05    
.word ShopItem             ; 06    
.word ShopOasis            ; 07    
.word ShopGold             ; 08    
.word ShopWelcome          ; 09    
.word ShopBuySellExit      ; 0A    
.word ShopBuyExit          ; 0B    
.word ShopCannotCarry      ; 0C    
.word ShopWhatWant         ; 0D    
.word ShopXGoldOK          ; 0E    
.word ShopYesNo            ; 0F
.word ShopCantAfford       ; 10
.word ShopWhoWillTake      ; 11    
.word ShopCharNames        ; 12
.word ShopThankYouWhatElse ; 13    
.word ShopWhoseItemToSell  ; 14    
.word ShopWhichOne         ; 15
.word ShopThankYou         ; 16
.word ShopWhoWillLearn     ; 17
.word ShopWhichSpell       ; 18 
.word ShopSorryCantLearn   ; 19    
.word ShopAlreadyKnow      ; 1A
.word ShopInnWelcome       ; 1B
.word ShopDontForget       ; 1C
.word ShopHoldReset        ; 1D
.word ShopNothingToSell    ; 1E
.word ShopKeepOnTrying     ; 1F
.word ShopWhoToRevive      ; 20
.word ShopReturnToLife     ; 21
.word ShopSpellsFull       ; 22
.word ShopDontNeedHelp     ; 23
.word ShopLearnExit        ; 24
.word ShopTooBad           ; 25
.word ShopHowMany          ; 26 
.word ShopEquipNow         ; 27
.word ShopCannotEquip      ; 28

;; JIGS - then the strings:
;; note these are NOT the original game's strings. I have edited them to better fit within the new shop screen and add some character to the shops.


ShopWeapon:
.byte $FF,$FF,$FF,$A0,$2B,$B3,$3C,$C1,$9C,$AB,$B2,$B3,$00 ; ___Weapon Shop
ShopArmor:
.byte $FF,$FF,$FF,$8A,$B5,$B0,$35,$C1,$9C,$AB,$B2,$B3,$00 ; ___Armor Shop
ShopWhiteMagic:
.byte $FF,$FF,$FF,$A0,$3D,$53,$C1,$96,$A4,$AA,$AC,$A6,$00 ; ___White Magic
ShopBlackMagic:
.byte $FF,$FF,$FF,$8B,$AF,$5E,$AE,$C1,$96,$A4,$AA,$AC,$A6,$00 ; ___Black Magic
ShopTemple:
.byte $FF,$9D,$A8,$B0,$B3,$45,$36,$54,$95,$AC,$AA,$AB,$B7,$00 ; _Temple of Light
ShopInn:
.byte $FF,$9D,$B5,$A4,$32,$45,$B5,$BE,$1E,$92,$B1,$B1,$00 ; _Traveler's Inn
ShopItem:
.byte $FF,$FF,$90,$3A,$25,$5F,$C1,$9C,$28,$23,$00 ; __General Store
ShopOasis: 
.byte $8C,$AF,$B2,$3E,$C1,$98,$B8,$21,$9C,$5F,$A8,$00 ; Close Out Sale
ShopGold:
.byte $FF,$90,$00 ; _G
ShopWelcome:
.byte $C1,$C1,$A0,$A8,$AF,$A6,$49,$A8,$C4,$C1,$A0,$41,$B7,$01,$C1,$51,$29,$92,$67,$2E,$BC,$A4,$43,$35,$C5,$00 ; Welcome! 
ShopBuySellExit:
.byte $8B,$B8,$BC,$01,$9C,$A8,$4E,$01,$8E,$BB,$5B,$00
ShopBuyExit:
.byte $8B,$B8,$BC,$01,$8E,$BB,$5B,$00
ShopCannotCarry:
.byte $A2,$26,$38,$22,$B1,$B2,$21,$51,$B5,$B5,$BC,$05,$22,$4B,$B0,$35,$A8,$C4,$00 ; You cannot carry any more.
ShopWhatWant:
.byte $C1,$A0,$41,$B7,$BE,$4E,$2D,$21,$62,$C5,$00
ShopXGoldOK:
.byte $FF,$9D,$41,$21,$A6,$49,$2C,$1B,$B2,$69,$01,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$90,$BF,$C1,$B2,$AE,$A4,$BC,$C5,$00
ShopYesNo:
.byte $A2,$A8,$B6,$01,$97,$B2,$00
ShopCantAfford:
.byte $C1,$8A,$A6,$AB,$C4,$C1,$A2,$26,$38,$22,$BE,$B7,$01,$C1,$C1,$A4,$A9,$A9,$35,$27,$1C,$39,$69,$00
ShopWhoWillTake:
.byte $C1,$A0,$AB,$2E,$30,$2D,$21,$A9,$35,$C5,$00
ShopCharNames:
.byte $10,$00,$05
.byte $11,$00,$05
.byte $12,$00,$05
.byte $13,$00,$00
ShopThankYouWhatElse:
.byte $9D,$41,$B1,$AE,$50,$26,$C1,$AE,$1F,$A7,$AF,$BC,$C4,$01,$C1,$8A,$B1,$BC,$1C,$1F,$47,$A8,$AF,$3E,$C5,$00
ShopWhoseItemToSell:
.byte $A0,$41,$21,$A7,$BE,$56,$64,$41,$32,$05,$A9,$35,$42,$A8,$BF,$1B,$1D,$B1,$C5,$00
ShopWhichOne:
.byte $A0,$AB,$AC,$A6,$AB,$B2,$B1,$A8,$C5,$00
ShopThankYou:
.byte $9D,$AB,$22,$AE,$BC,$B2,$B8,$C4,$00
ShopWhoWillLearn:
.byte $C1,$A0,$41,$21,$A9,$B2,$B2,$58,$B6,$41,$4E,$01,$C1,$45,$2F,$29,$A9,$4D,$B0,$42,$A8,$C5,$00
ShopWhichSpell:
.byte $A0,$AB,$AC,$A6,$AB,$B6,$B3,$A8,$4E,$C5,$00
ShopSorryCantLearn:
.byte $C1,$9D,$3D,$1E,$30,$C1,$B1,$B2,$21,$A9,$35,$01,$C1,$C1,$C1,$56,$64,$28,$C1,$AE,$B1,$46,$C0,$01
.byte $C1,$C1,$C1,$C1,$C1,$69,$43,$B2,$B2,$AF,$C0,$00
ShopAlreadyKnow:
.byte $A2,$26,$20,$AF,$23,$A4,$A7,$4B,$AE,$B1,$46,$01,$1C,$39,$24,$B3,$A8,$4E,$BF,$43,$B2,$B2,$AF,$C4,$00 ; You already know that.
ShopInnWelcome:
.byte $C1,$A0,$A8,$AF,$A6,$49,$A8,$BF,$33,$2B,$B5,$BC,$01,$B7,$B5,$A4,$32,$45,$63,$C4,$C1,$95,$A8,$21,$B8,$B6,$01,$B7,$A4,$AE,$1A,$51,$23,$36,$54,$56,$B8,$C0,$00 ; Inn welcome
ShopDontForget:
.byte $98,$B1,$AF,$4B,$26,$44,$A9,$1F,$2C,$B7,$05,$4D,$49,$43,$35,$50,$26,$05,$A9,$26,$44,$A0,$8A,$9B,$9B,$92,$98,$9B,$9C,$C4,$05,$9C,$45,$A8,$B3,$33,$A8,$4E,$C4,$00
ShopHoldReset: 
.byte $9B,$A8,$34,$B0,$62,$B5,$BF,$1B,$2E,$B6,$A4,$32,$05,$56,$55,$C1,$AA,$A4,$34,$BF,$59,$B2,$AF,$A7,$05,$9B,$8E,$9C,$8E,$9D,$33,$1D,$29,$56,$B8,$05,$B7,$55,$29,$1C,$1A,$B3,$46,$25,$05,$4C,$A9,$C4,$C1,$90,$B2,$B2,$27,$AF,$B8,$A6,$AE,$C4,$00
ShopNothingToSell:
.byte $C1,$8A,$A6,$AB,$C4,$C1,$A2,$26,$67,$3C,$BE,$B7,$01,$C1,$41,$32,$20,$B1,$BC,$1C,$1F,$AA,$C4,$00
ShopKeepOnTrying:
.byte $94,$A8,$A8,$B3,$36,$B1,$B7,$B5,$BC,$1F,$AA,$AA,$B8,$BC,$B6,$69,$00
ShopWhoToRevive:
.byte $91,$46,$C1,$B8,$B1,$A9,$35,$B7,$B8,$B1,$39,$A8,$69,$01,$A0,$3D,$A6,$AB,$43,$5F,$45,$B1,$05,$A0,$8A,$9B,$9B,$92,$98,$9B,$24,$41,$4E,$C1,$92,$05,$A4,$A7,$B0,$1F,$30,$53,$44,$28,$C5,$00
ShopReturnToLife:
.byte $8B,$4B,$1C,$1A,$AA,$B5,$5E,$1A,$4C,$05,$68,$AA,$AB,$B7,$69,$C1,$A0,$8A,$9B,$9B,$92,$98,$9B,$C4,$05,$9B,$A8,$B7,$55,$29,$28,$65,$AC,$A9,$A8,$C4,$00 ; Warrior return to life!
ShopSpellsFull:
.byte $9D,$2B,$A6,$3D,$2A,$50,$26,$1B,$41,$B7,$01,$BA,$26,$AF,$27,$A5,$55,$37,$50,$26,$B5,$01,$C1,$C1,$A5,$B5,$A4,$1F,$BF,$43,$B2,$B2,$AF,$C4,$00 ; Cannot teach that
ShopDontNeedHelp:
.byte $95,$B2,$B2,$AE,$1B,$2E,$1C,$1A,$68,$AA,$AB,$B7,$01,$22,$27,$B3,$2B,$48,$31,$1A,$BA,$5B,$AB,$01,$C1,$56,$B8,$BF,$C1,$A0,$8A,$9B,$9B,$92,$98,$9B,$9C,$C0,$00 ; No dead people here.
ShopLearnExit:
.byte $95,$A8,$2F,$B1,$01,$8E,$BB,$5B,$00
ShopTooBad:
.byte $8E,$AB,$BF,$20,$AF,$5C,$AA,$AB,$21,$1C,$3A,$C0,$01,$C1,$8A,$B1,$BC,$1C,$1F,$47,$A8,$AF,$3E,$C5,$00
ShopHowMany:
.byte $C1,$C1,$C1,$C1,$91,$B2,$BA,$C1,$B0,$A4,$B1,$BC,$C5,$01,$C1,$C1,$C1,$C1,$BA,$AC,$AF,$AF,$C1,$A6,$B2,$B6,$B7,$C1,$BC,$A4,$C1,$01,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$90,$00
ShopEquipNow:
.byte $C1,$8D,$B2,$C1,$BC,$B2,$B8,$C1,$BA,$A4,$B1,$B7,$C1,$B7,$B2,$01,$C1,$C1,$A8,$B4,$B8,$AC,$B3,$C1,$AC,$B7,$C1,$B1,$B2,$BA,$C5,$00 ; Do you want to equip it now?
ShopCannotEquip:
.byte $C1,$C1,$91,$B2,$AF,$A7,$C1,$B2,$B1,$C1,$B1,$B2,$BA,$C3,$C0,$01,$C1,$A2,$B2,$B8,$BE,$B5,$A8,$C1,$B1,$B2,$B7,$C1,$A4,$A5,$AF,$A8,$01,$C1,$C1,$B7,$B2,$C1,$A8,$B4,$B8,$AC,$B3,$C1,$B7,$AB,$A4,$B7,$C4,$00
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  LUT containing shop data  [$8300 :: 0x38310]

lut_ShopData:
;  .INCBIN "bin/0E_8300_shopdata.bin"

;; JIGS - again, labeled and ready for string editing!

.word UnusedShop        ; 00 
.word CorneriaWeapon    ; 01 
.word ProvokaWeapon     ; 02 
.word ElflandWeapon     ; 03 
.word MelmondWeapon     ; 04 
.word LakeWeapon        ; 05 
.word GaiaWeapon        ; 06 
.word UnusedShop        ; 07 
.word UnusedShop        ; 08 
.word UnusedShop        ; 09 
.word UnusedShop        ; 0A 
.word CorneriaArmour    ; 0B 
.word ProvokaArmour     ; 0C 
.word ElflandArmour     ; 0D 
.word MelmondArmour     ; 0E 
.word LakeArmour        ; 0F 
.word GaiaArmour        ; 10
.word UnusedShop        ; 11
.word UnusedShop        ; 12
.word UnusedShop        ; 13
.word UnusedShop        ; 14
.word CorneriaWMagic    ; 15
.word ProvokaWMagic     ; 16
.word ElflandWMagic     ; 17
.word MelmondWMagic     ; 18
.word LakeWMagic        ; 19
.word ElflandWMagic2    ; 1A
.word GaiaWMagic        ; 1B
.word GaiaWMagic2       ; 1C
.word OnracWMagic       ; 1D
.word LeifenWMagic      ; 1E
.word CorneriaBMagic    ; 1F
.word ProvokaBMagic     ; 20
.word ElflandBMagic     ; 21
.word MelmondBMagic     ; 22
.word LakeBMagic        ; 23
.word ElflandBMagic2    ; 24
.word GaiaBMagic        ; 25
.word GaiaBMagic2       ; 26
.word OnracBMagic       ; 27
.word LeifenBMagic      ; 28
.word CorneriaTemple    ; 29
.word ElflandTemple     ; 2A
.word LakeTemple        ; 2B
.word GaiaTemple        ; 2C
.word OnracTemple       ; 2D
.word ProvokaTemple     ; 2E
.word UnusedShop        ; 2F
.word UnusedShop        ; 30
.word UnusedShop        ; 31
.word UnusedShop        ; 32
.word CorneriaInn       ; 33
.word ProvokaInn        ; 34
.word ElflandInn        ; 35
.word MelmondInn        ; 36
.word LakeInn           ; 37
.word GaiaInn           ; 38
.word OnracInn          ; 39
.word UnusedShop        ; 3A
.word UnusedShop        ; 3B
.word UnusedShop        ; 3C
.word CorneriaItem      ; 3D
.word ProvokaItem       ; 3E
.word ElflandItem       ; 3F
.word LakeItem          ; 40
.word GaiaItem          ; 41
.word OnracItem         ; 42
.word UnusedShop        ; 43
.word UnusedShop        ; 44
.word UnusedShop        ; 45
.word CaravanShop       ; 46

;; The following data was organized by 	Dienyddiwr Da - http://www.romhacking.net/documents/81/ ! 

;the bytes of Inns and Clinics are Read as Gold, Two Bytes long. the first byte being the second 2 digits
;and the second byte being the first two (e.g. 28-00 would be 0x0028 = 0x28 = 40 decimal)
;
;
;Second Price Digits or First Item for Sale
;| First Price Digits or Second Item for Sale
;|  | Third Item for Sale
;|  |  | Fourth Item for Sale
;|  |  |  | Fifth Item for Sale
;|  |  |  |  |   Town			Explanation
;|__|__|__|__|____|__________________________|_______________________
CorneriaWeapon:
.byte $1E,$1D,$1C,$1F,$20,$00 ;(Corneria) Wooden Staff, Small Knife, Wooden Nunchuku, Rapier, Iron Hammer
CorneriaArmour:
.byte $44,$45,$46,$00         ;(Corneria) Cloth, Wooden Armour, Chain Armour
CorneriaWMagic:
.byte $B0,$B1,$B2,$B3,$00     ;(Corneria) CURE, HARM, FOG, RUSE
CorneriaBMagic:
.byte $B4,$B5,$B6,$B7,$00     ;(Corneria) FIRE, SLEP, LOCK, LIT
CorneriaTemple:
.byte $28,$00,$00             ;(Corneria) 40g Clinic
CorneriaInn:
.byte $1E,$00,$00             ;(Corneria) 30g Inn
CorneriaItem:
.byte $01,$02,$04,$00         ;(Corneria) Heal, Pure, Tent
ProvokaWeapon:
.byte $20,$21,$22,$23,$00     ;(Provoka) Iron Hammer, Short Sword, Hand Axe, Scimtar
ProvokaArmour:
.byte $45,$46,$47,$54,$64,$00 ;(Provoka) Wooden Armour, Chain Armour, Iron Armour, Wooden Shield, Gloves
ProvokaWMagic:
.byte $B8,$B9,$BA,$BB,$00     ;(Provoka) LAMP, MUTE, ALIT, INVS
ProvokaBMagic:
.byte $BC,$BD,$BE,$BF,$00     ;(Provoka) ICE, DARK, TMPR, SLOW
ProvokaTemple:
.byte $50,$00                 ;(Provoka) 80g Clinic
ProvokaInn:
.byte $32,$00                 ;(Provoka) 50g Inn
ProvokaItem:
.byte $01,$02,$04,$05,$00     ;(Provoka) Heal, Pure, Tent, Cabin
ElflandWeapon:
.byte $24,$25,$26,$27,$2C,$00 ;(Elfland) Iron Nunchuku, Large Knife, Iron Staff, Sabre, Silver Sword 
ElflandArmour:
.byte $47,$4E,$55,$5D,$5E,$00 ;(Elfland) Iron Armour, Copper Bracelet, Iron Shield, Cap, Wooden Helmet
ElflandWMagic:
.byte $C0,$C1,$C2,$C3,$00     ;(Elfland) CUR2, HRM2, AFIR, HEAL
ElflandBMagic:
.byte $C4,$C5,$C6,$C7,$00     ;(Elfland) FIR2, HOLD, LIT2, LOK2
ElflandWMagic2:
.byte $C8,$C9,$CA,$CB,$00     ;(Elfland) PURE, FEAR, AICE, AMUT
ElflandBMagic2:
.byte $CC,$CD,$CE,$CF,$00     ;(Elfland) SLP2, FAST, CONF, ICE2
ElflandTemple:
.byte $C8,$00                 ;(Elfland) 200g Clinic
ElflandInn:
.byte $64,$00                 ;(Elfland) 100g Inn
ElflandItem: 
.byte $01,$02,$04,$05,$03,$00 ;(Elfland) Heal, Pure, Tent, Cabin, Soft
MelmondWeapon:
.byte $26,$27,$28,$2A,$00     ;(Melmond) Iron Staff, Sabre, Long Sword, Falchion
MelmondArmour:
.byte $48,$4F,$5F,$65,$66,$00 ;(Melmond) Steel Armour, Silver Bracelet, Iron Helmet, Copper Gauntlet, Iron Gauntlet
MelmondWMagic:
.byte $D0,$D1,$D2,$D3,$00     ;(Melmond) CUR3, LIFE, HRM3, HEL2
MelmondBMagic:
.byte $D4,$D5,$D6,$D7,$00     ;(Melmond) FIR3, BANE, WARP, SLO2
MelmondInn:
.byte $64,$00                 ;(Melmond) 100g Inn
LakeWeapon:
.byte $2B,$2C,$2D,$2E,$00     ;(Cresent Lake) Silver Knife, Silver Sword, Silver Hammer, Silver Axe
LakeArmour:
.byte $49,$56,$5B,$60,$67,$00 ;(Cresent Lake) Silver Armour, Silver Shield, Buckler, Silver Helmet, Silver Gauntlet
LakeWMagic:
.byte $D8,$D9,$DA,$DB,$00     ;(Cresent Lake) SOFT, EXIT, FOG2, INV2
LakeBMagic:
.byte $DC,$DD,$DE,$DF,$00     ;(Cresent Lake) LIT3, RUB, QAKE, STUN
LakeTemple:
.byte $90,$01,$00             ;(Cresent Lake) 400g Clinic
LakeInn:
.byte $C8,$00                 ;(Cresent Lake) 200g Inn
LakeItem:
.byte $01,$02,$04,$05,$00     ;(Cresent Lake) Heal, Pure, Tent, Cabin
GaiaWeapon:
.byte $3E,$00                 ;(Gaia) CatClaw
GaiaArmour:
.byte $50,$6B,$00             ;(Gaia) Gold Bracelet, ProRing
GaiaWMagic:
.byte $E0,$E1,$00             ;(Gaia) CUR4, HRM4
GaiaBMagic:
.byte $E4,$E5,$00             ;(Gaia) ICE3, BRAK
GaiaWMagic2:
.byte $E9,$EA,$EB,$00         ;(Gaia) FADE, WALL, XFER
GaiaBMagic2:
.byte $ED,$EE,$EF,$00         ;(Gaia) STOP, ZAP!, XXXX
GaiaTemple:
.byte $EE,$02,$00             ;(Gaia) 750g Clinic
GaiaInn:
.byte $F4,$01,$00             ;(Gaia) 500g Inn
GaiaItem:
.byte $05,$06,$01,$02,$00     ;(Gaia) Cabin, House, Heal, Pure
OnracWMagic:
.byte $E2,$E3,$00             ;(Onrac) ARUB, HEL3
OnracBMagic:
.byte $E6,$E7,$00             ;(Onrac) SABR, BLND
OnracTemple:
.byte $EE,$02,$00             ;(Onrac) 750g Clinic
OnracInn:
.byte $2C,$01,$00             ;(Onrac) 300g Inn
OnracItem:
.byte $04,$05,$06,$02,$03,$00 ;(Onrac) Tent, Cabin, House, Pure, Soft
CaravanShop:
.byte $0F,$00                 ;(Caravan) Bottle
LeifenWMagic:
.byte $E8,$00                 ;(Leifen) LIF2
LeifenBMagic:
.byte $EC,$00                 ;(Leifen) NUKE
UnusedShop:
.byte $FF,$00


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  LUT for menu text  [$8500 :: 0x38510]
;;
;;    This is a table of complex strings used in menus.

;lut_MenuText:
;  .INCBIN "bin/0E_8500_menutext.bin"

;; JIGS - once more, labeled!

;; A few things were edited to fit the new menu layouts.

lut_MenuText:
.word M_Gold             ; 0 
.word M_Options          ; 1 
.word M_ItemTitle        ; 2 
.word M_ItemNothing      ; 3 
.word M_ItemLutePlays    ; 4 
.word M_ItemLute         ; 5 
.word M_ItemCrown        ; 6 
.word M_ItemCrystal      ; 7 
.word M_ItemHerb         ; 8 
.word M_ItemKey          ; 9 
.word M_ItemTNT          ; A 
.word M_ItemAdamant      ; B 
.word M_ItemSlab         ; C 
.word M_ItemRuby         ; D 
.word M_ItemRodShatter   ; E 
.word M_ItemRod          ; F 
.word M_ItemFloaterRise  ; 10
.word M_ItemFloater      ; 11
.word M_ItemChime        ; 12
.word M_ItemRatTail      ; 13
.word M_ItemCube         ; 14
.word M_ItemBottlePop    ; 15
.word M_ItemEmptyBottle  ; 16
.word M_ItemOxyale       ; 17
.word M_ItemCanoe        ; 18
.word M_ItemUseTent      ; 19
.word M_ItemCannotUse    ; 1A
.word M_SaveFromMenu     ; 1B
.word M_ItemCannotSleep  ; 1C
.word M_ItemUseHouse     ; 1D
.word M_ItemCannotSave   ; 1E
.word M_ItemHeal         ; 1F
.word M_ItemPure         ; 20
.word M_ItemSoft         ; 21
.word M_Empty            ; 22
.word M_CharStatClass    ; 23
;.word M_CharExp         ; 
.word M_CharLevelStats   ; 24
.word M_CharMainStats    ; 25
.word M_CharSubStats     ; 27 
.word M_MagicList        ; 27
.word M_CureMagic        ; 28
.word M_HealMagic        ; 29
.word M_PureMagic        ; 2A
.word M_LifeMagic        ; 2B
.word M_WarpMagic        ; 2C
.word M_SoftMagic        ; 2D
.word M_ExitMagic        ; 2E
.word M_NoMana           ; 2F
.word M_CannotUseMagic   ; 30
.word M_WeaponTitle      ; 31
.word M_ArmorTitle       ; 32
.word M_EquipString      ; 33
.word M_Char1Name        ; 34
.word M_Char2Name        ; 35
.word M_Char3Name        ; 36
.word M_Char4Name        ; 37
.word M_NowSaving        ; 38
.word M_OrbGoldBoxLink   ; 39
.word M_EquipmentSlots   ; 3A
.word M_EquipTrash       ; 3B
.word M_EquipStats

M_Gold: ;0 
.byte $04,$FF,$90,$00 ; _G - for gold on menu

M_Options: ;1
.byte $92,$9D,$8E,$96,$9C,$01 ; ITEMS 
.BYTE $96,$8A,$90,$92,$8C,$01 ; MAGIC
.byte $8E,$9A,$9E,$92,$99,$01 ; EQUIP
.byte $CA,$CB,$CC,$CD,$CE,$01 ; STATUS
.BYTE $CF,$D0,$D1,$D2,$97,$01 ; OPTION
.byte $9C,$8A,$9F,$8E,$E2,$00 ; SAVE (Heart)

M_ItemTitle: ;2
.BYTE $FF,$92,$9D,$8E,$96,$9C,$00 ; ITEMS

M_ItemNothing: ;3
.byte $A2,$B2,$64,$41,$B9,$1A,$B1,$B2,$1C,$1F,$AA,$C0,$00 ; You have nothing.

M_ItemLutePlays: ;4
.byte $9D,$AB,$1A,$B7,$B8,$B1,$1A,$B3,$AF,$A4,$BC,$B6,$BF,$05,$B5,$A8,$B9,$2B,$AF,$1F,$AA,$20,$24,$B7,$A4,$AC,$B5,$5D,$BC,$C0,$00 ; The tune plays,[enter]revealing a stairway.

M_ItemLute: ;5
.byte $8B,$A8,$A4,$B8,$57,$A9,$B8,$AF,$42,$B8,$B6,$AC,$A6,$43,$AC,$4E,$B6,$05,$B7,$AB,$1A,$A4,$AC,$B5,$C0,$00 ; Beautiful music fills[enter]the air.

M_ItemCrown: ;6
.byte $9D,$AB,$1A,$B6,$28,$45,$29,$8C,$9B,$98,$A0,$97,$C0,$00 ; The stolen CROWN.

M_ItemCrystal: ;7 
.byte $8A,$FF,$A5,$A4,$4E,$42,$A4,$A7,$1A,$4C,$FF,$8C,$9B,$A2,$9C,$9D,$8A,$95,$C0,$00 ; A ball made of CRYSTAL.

M_ItemHerb: ;8 
.byte $A2,$B8,$A6,$AE,$C4,$FF,$9D,$3D,$1E,$34,$A7,$AC,$A6,$1F,$A8,$05,$AC,$B6,$1B,$B2,$2E,$A5,$5B,$B7,$25,$C4,$00 ; Yuck! This medicine[enter]is too bitter!

M_ItemKey: ;9
.byte $9D,$AB,$1A,$B0,$BC,$37,$AC,$A6,$FF,$94,$8E,$A2,$C0,$00 ; The mystic KEY.

M_ItemTNT:  ; 10
.byte $8B,$A8,$38,$A4,$23,$A9,$B8,$AF,$C4,$00 ; Be careful!

M_ItemAdamant:  ;11
.byte $9D,$AB,$1A,$45,$AA,$3A,$A7,$2F,$4B,$34,$B7,$5F,$C0,$00 ; The legendary metal.

M_ItemSlab:  ;12
.byte $9E,$B1,$AE,$B1,$46,$B1,$24,$BC,$B0,$A5,$B2,$AF,$1E,$A6,$B2,$B9,$25,$05,$B7,$AB,$1A,$9C,$95,$8A,$8B,$C0,$00 ; Unknown symbols cover[enter]the SLAB.

M_ItemRuby:  ;13
.byte $8A,$FF,$AF,$2F,$AA,$1A,$23,$A7,$24,$28,$5A,$C0,$00 ; A large red stone.

M_ItemRodShatter:  ;14
.byte $9D,$AB,$1A,$B3,$AF,$39,$1A,$B6,$AB,$39,$B7,$25,$B6,$BF,$05,$B5,$A8,$B9,$2B,$AF,$1F,$AA,$20,$24,$B7,$A4,$AC,$B5,$5D,$BC,$C4,$00 ; The plate shatters,[enter]revealing a stairway!

M_ItemRod:  ;15
.byte $9D,$AB,$1A,$9B,$98,$8D,$1B,$2E,$23,$B0,$B2,$B9,$1A,$1C,$A8,$05,$B3,$AF,$39,$1A,$A9,$B5,$49,$1B,$AB,$1A,$2B,$B5,$1C,$C0,$00 ; The ROD to remove the[enter]plate from the earth.

M_ItemFloaterRise:  ;16
.byte $9D,$AB,$1A,$8A,$92,$9B,$9C,$91,$92,$99,$31,$A8,$AA,$1F,$B6,$1B,$B2,$05,$B5,$AC,$B6,$1A,$A9,$B5,$49,$1B,$AB,$1A,$A7,$2C,$25,$B7,$C0,$00 ; The AIRSHIP begins to[enter]rose from the desert.

M_ItemFloater:  ;17
.byte $8A,$FF,$B0,$BC,$37,$25,$AC,$26,$1E,$4D,$A6,$AE,$C0,$00 ; A mysterious rock.

M_ItemChime: ;18
.byte $9C,$B7,$A4,$B0,$B3,$A8,$27,$3C,$1B,$AB,$1A,$A5,$B2,$B7,$28,$B0,$69,$05,$96,$8A,$8D,$8E,$FF,$92,$97,$FF,$95,$8E,$8F,$8E,$92,$97,$00 ; Stamped on the bottom..[enter]MADE IN LEFEIN. 

M_ItemRatTail: ;19
.byte $98,$98,$91,$91,$C4,$C4,$FF,$92,$21,$37,$1F,$AE,$B6,$C4,$05,$9D,$AB,$B5,$46,$2D,$21,$B2,$B9,$25,$69,$05,$97,$B2,$C4,$FF,$8D,$3C,$BE,$21,$A7,$B2,$1B,$AB,$39,$C4,$C4,$00 ; OOHH!! It stinks![/enter]Throw it over..[enter]No! Don't do that!!

M_ItemCube: ;20
.byte $8C,$B2,$AF,$35,$1E,$AA,$A4,$1C,$25,$20,$3B,$05,$B6,$BA,$AC,$B5,$58,$1F,$1B,$AB,$1A,$8C,$9E,$8B,$8E,$C0,$00 ; Colors gather and[enter]swirl in the CUBE.

M_ItemBottlePop:  ;21
.byte $99,$B2,$B3,$C4,$FF,$8A,$43,$A4,$AC,$B5,$BC,$20,$B3,$B3,$2B,$63,$BF,$05,$B7,$AB,$A8,$29,$AC,$1E,$AA,$3C,$A8,$C0,$00 ; Pop! A fairy appears,[enter]then is gone.

M_ItemEmptyBottle: ;22
.byte $92,$B7,$2D,$1E,$A8,$B0,$B3,$B7,$BC,$C0,$00 ; It is empty.

M_ItemOxyale: ;23
.byte $9D,$AB,$1A,$98,$A1,$A2,$8A,$95,$8E,$43,$55,$B1,$30,$1D,$B6,$05,$A9,$B5,$2C,$AB,$20,$AC,$B5,$C0,$00 ; The OXYALE furnishes[enter]fresh air. 

M_ItemCanoe: ;24
.byte $A2,$B2,$B8,$38,$22,$FF,$A6,$4D,$B6,$B6,$1B,$AB,$1A,$5C,$B9,$25,$C0,$00 ; You can cross the river.

M_ItemUseTent: ;25
;M_ItemUseCabin:  ;originally 27
.byte $91,$99,$FF,$23,$A6,$B2,$32,$23,$A7,$C0,$FF,$9C,$8A,$9F,$8E,$C5,$05,$99,$B8,$B6,$AB,$FF,$8A,$69,$A2,$8E,$9C,$05,$99,$B8,$B6,$AB,$FF,$8B,$69,$97,$98,$00 ; HP recovered. SAVE?[enter]Push A..YES[enter]Push B..NO

M_ItemCannotUse: ;26
.byte $A2,$B2,$B8,$38,$22,$B1,$B2,$21,$B8,$B6,$1A,$AC,$21,$1D,$23,$C4,$00 ; You cannot use it here!

M_SaveFromMenu:  ;27 ;; JIGS - Tent and Cabin uses the same message, so re-purposing this for the in-menu save option!
.byte $9C,$8A,$9F,$8E,$C5,$05,$99,$B8,$B6,$AB,$FF,$8A,$69,$A2,$8E,$9C,$05,$99,$B8,$B6,$AB,$FF,$8B,$69,$97,$98,$00 ; SAVE?[enter]Push A..YES[enter]Push B..NO

M_ItemCannotSleep:  ;28
.byte $A2,$B2,$B8,$38,$22,$B1,$B2,$21,$B6,$45,$A8,$B3,$FF,$1D,$23,$C4,$00 ; You cannot sleep here!

M_ItemUseHouse:  ;29
.byte $91,$99,$FF,$23,$A6,$B2,$32,$23,$A7,$C0,$FF,$9C,$8A,$9F,$8E,$20,$3B,$05,$B5,$A8,$A6,$B2,$B9,$25,$42,$A4,$AA,$AC,$A6,$C5,$05,$99,$9E,$9C,$91,$FF,$8A,$69,$A2,$8E,$9C,$FF,$FF,$99,$9E,$9C,$91,$FF,$8B,$69,$97,$98,$00 ; HP recovered. SAVE and[enter]recover magic?[enter]Push A..YES  Push B..NO

M_ItemCannotSave:  ;30
.byte $97,$B2,$21,$3A,$26,$AA,$AB,$FF,$4D,$49,$FF,$1D,$23,$C0,$05,$9D,$B5,$BC,$20,$B1,$B2,$1C,$25,$24,$B3,$B2,$B7,$C0,$00 ; Not enough room here.[enter]Try another spot.

M_ItemHeal:   ;31
.byte $A0,$AB,$2E,$5A,$40,$B6,$1B,$2E,$23,$A6,$B2,$B9,$25,$FF,$91,$99,$C5,$00 ; Who needs to recover HP?

M_ItemPure:   ;32
.byte $A0,$AB,$2E,$5A,$40,$B6,$1B,$AB,$1A,$8A,$97,$9D,$92,$8D,$98,$9D,$8E,$C5,$00 ; Who needs the ANTIDOTE?

M_ItemSoft:   ;33
.byte $9D,$B8,$B5,$B1,$40,$1B,$2E,$9C,$9D,$98,$97,$8E,$C5,$05,$9C,$98,$8F,$9D,$8E,$97,$33,$3D,$A6,$AB,$36,$5A,$C5,$00 ; Turned to STONE?[enter]SOFTEN which one?

M_Empty:   ;34
.byte $FF,$00 ;; Character Stat 00 

M_CharStatClass:  ;35
;.byte $FF,$FF,$FF,$FF,$10,$01,$00 ;; Character Stat 01 

;M_CharExp:  ;36
;.byte $8E,$BB,$B3,$C0,$FF,$FF,$10,$04,$01 ; Exp.
;.byte $97,$A8,$BB,$B7,$FF,$10,$42,$00     ; Next

M_CharLevelStats:   ;36
.byte $10,$00,$01                                     ; NAME
.byte $10,$01,$01                                     ; Class
.byte $95,$A8,$32,$AF,$FF,$FF,$FF,$FF,$FF,$10,$03,$01 ; Level ##
.byte $8E,$BB,$B3,$C0,$FF,$FF,$10,$04,$01             ; Exp.  ## 
.byte $97,$A8,$BB,$B7,$FF,$FF,$FF,$10,$42,$00         ; Next  ##

M_CharMainStats:   ;37
.byte $9C,$B7,$23,$2A,$1C,$FF,$FF,$10,$07,$01         ; Strength 
.byte $8A,$AA,$61,$5B,$4B,$FF,$FF,$10,$08,$01         ; Agility  
.byte $92,$B1,$53,$4E,$A8,$A6,$21,$10,$09,$01         ; Intellect
.byte $9F,$5B,$5F,$5B,$4B,$FF,$10,$0A,$01             ; Vitality 
.byte $9C,$B3,$A8,$40,$FF,$FF,$FF,$FF,$FF,$10,$0B,$00 ; Speed    

M_CharSubStats:  ;38
.byte $8D,$A4,$B0,$A4,$66,$FF,$FF,$FF,$10,$3C,$01     ; Damage
.byte $8A,$A6,$A6,$55,$5E,$4B,$10,$3D,$01             ; Accuracy
.byte $8D,$A8,$A9,$3A,$3E,$FF,$FF,$10,$3E,$01         ; Defense
.byte $8E,$B9,$3F,$AC,$3C,$FF,$FF,$10,$3F,$01         ; Evasion
.byte $96,$A4,$AA,$C0,$8D,$A8,$A9,$C0,$FF,$10,$41,$00 ; Mag. Def.


M_MagicList:   ;39
;.byte $FF,$95,$81,$FF,$10,$2C,$7A,$10,$34,$FF,$FF,$FF,$10,$14,$FF,$FF,$10,$15,$FF,$FF,$10,$16,$01
;.byte $FF,$95,$82,$FF,$10,$2D,$7A,$10,$35,$FF,$FF,$FF,$10,$17,$FF,$FF,$10,$18,$FF,$FF,$10,$19,$01
;.byte $FF,$95,$83,$FF,$10,$2E,$7A,$10,$36,$FF,$FF,$FF,$10,$1A,$FF,$FF,$10,$1B,$FF,$FF,$10,$1C,$01
;.byte $FF,$95,$84,$FF,$10,$2F,$7A,$10,$37,$FF,$FF,$FF,$10,$1D,$FF,$FF,$10,$1E,$FF,$FF,$10,$1F,$01
;.byte $FF,$95,$85,$FF,$10,$30,$7A,$10,$38,$FF,$FF,$FF,$10,$20,$FF,$FF,$10,$21,$FF,$FF,$10,$22,$01
;.byte $FF,$95,$86,$FF,$10,$31,$7A,$10,$39,$FF,$FF,$FF,$10,$23,$FF,$FF,$10,$24,$FF,$FF,$10,$25,$01
;.byte $FF,$95,$87,$FF,$10,$32,$7A,$10,$3A,$FF,$FF,$FF,$10,$26,$FF,$FF,$10,$27,$FF,$FF,$10,$28,$01
;.byte $FF,$95,$88,$FF,$10,$33,$7A,$10,$3B,$FF,$FF,$FF,$10,$29,$FF,$FF,$10,$2A,$FF,$FF,$10,$2B,$00 
;       __ L   #    __ cc   mana / max mana __  __  __ cc spell1 __ __ cc spell2 __ __ spell 3 null terminator or line break
;                      ^ control code

;; JIGS - removing the space...
.byte $7E,$81,$FF,$10,$2C,$7A,$10,$34,$FF,$FF,$10,$14,$FF,$10,$15,$FF,$10,$16,$01
.byte $7E,$82,$FF,$10,$2D,$7A,$10,$35,$FF,$FF,$10,$17,$FF,$10,$18,$FF,$10,$19,$01
.byte $7E,$83,$FF,$10,$2E,$7A,$10,$36,$FF,$FF,$10,$1A,$FF,$10,$1B,$FF,$10,$1C,$01
.byte $7E,$84,$FF,$10,$2F,$7A,$10,$37,$FF,$FF,$10,$1D,$FF,$10,$1E,$FF,$10,$1F,$01
.byte $7E,$85,$FF,$10,$30,$7A,$10,$38,$FF,$FF,$10,$20,$FF,$10,$21,$FF,$10,$22,$01
.byte $7E,$86,$FF,$10,$31,$7A,$10,$39,$FF,$FF,$10,$23,$FF,$10,$24,$FF,$10,$25,$01
.byte $7E,$87,$FF,$10,$32,$7A,$10,$3A,$FF,$FF,$10,$26,$FF,$10,$27,$FF,$10,$28,$01
.byte $7E,$88,$FF,$10,$33,$7A,$10,$3B,$FF,$FF,$10,$29,$FF,$10,$2A,$FF,$10,$2B,$00


M_CureMagic:   ;40
.byte $A0,$AB,$2E,$5A,$40,$B6,$1B,$2E,$23,$A6,$B2,$B9,$25,$FF,$91,$99,$C5,$00 ; Who needs to recover HP?

M_HealMagic:    ;41
.byte $8A,$FF,$B0,$A4,$AA,$AC,$A6,$1B,$2E,$23,$A6,$B2,$B9,$25,$FF,$91,$99,$05,$A9,$B2,$B5,$20,$4E,$36,$A9,$50,$26,$C0,$05,$99,$B8,$B6,$AB,$FF,$8A,$69,$A2,$8E,$9C,$FF,$FF,$FF,$99,$B8,$B6,$AB,$FF,$8B,$69,$97,$98,$00 ; A magic to recover HP[enter]for all of you.[enter]Push A..YES ___ Push B..NO

M_PureMagic:   ;42
.byte $9D,$AB,$AC,$1E,$B0,$A4,$AA,$AC,$A6,$FF,$23,$B0,$B2,$B9,$2C,$1B,$1D,$05,$B3,$B2,$30,$3C,$C0,$00 ; This magic removes the[enter]poison.

M_LifeMagic:   ;43
.byte $9D,$AB,$AC,$1E,$B6,$B3,$A8,$4E,$33,$AC,$4E,$FF,$23,$B9,$AC,$32,$C4,$00 ; This spell will revive!

M_WarpMagic:   ;44
.byte $8A,$FF,$B0,$A4,$AA,$AC,$A6,$1B,$2E,$23,$B7,$55,$29,$3C,$A8,$05,$A9,$AF,$B2,$35,$C0,$FF,$97,$46,$33,$2F,$B3,$31,$5E,$AE,$C4,$00 ; A magic to return one[enter]floor. Now warp back!

M_SoftMagic:   ;45
.byte $9D,$B8,$B5,$B1,$40,$1B,$2E,$9C,$9D,$98,$97,$8E,$C5,$05,$9D,$AB,$AC,$1E,$BA,$AC,$4E,$FF,$23,$B6,$28,$23,$C4,$00 ; Turned to STONE?[enter]This will restore!

M_ExitMagic:   ;46
.byte $95,$B2,$37,$C5,$FF,$97,$2E,$5D,$4B,$26,$B7,$C5,$05,$92,$B6,$2D,$21,$AB,$B2,$B3,$A8,$AF,$2C,$B6,$C5,$FF,$9E,$B6,$1A,$1C,$30,$05,$B6,$B3,$A8,$4E,$1B,$2E,$A8,$BB,$5B,$C4,$00 ; Lost? No way out?[return]Is it hopeless? Use this[return]spell to exit!

M_NoMana:   ;47
.byte $8A,$AF,$AF,$36,$A9,$1B,$41,$21,$45,$32,$AF,$BE,$B6,$05,$B6,$B3,$A8,$4E,$1E,$2F,$1A,$A8,$BB,$41,$B8,$37,$40,$C0,$00 ; All of that level's[enter]spells are exhausted.

M_CannotUseMagic:   ;48
.byte $9C,$B2,$B5,$B5,$BC,$BF,$50,$26,$38,$22,$B1,$B2,$21,$B8,$3E,$05,$B7,$AB,$A4,$21,$B6,$B3,$A8,$4E,$FF,$1D,$23,$C0,$00 ; Sorry, you cannot use[enter]that spell here.

M_WeaponTitle:   ;49
.byte $A0,$8E,$8A,$99,$98,$97,$9C,$00 ; WEAPONS title

M_ArmorTitle:    ;50
.byte $FF,$8A,$9B,$96,$98,$9B,$00 ; ARMOR title

M_EquipString:   ;51 
;.byte $FF,$FF,$8E,$9A,$9E,$92,$99,$FF,$FF,$9D,$9B,$8A,$8D,$8E,$FF,$FF,$8D,$9B,$98,$99,$00 ; __ EQUIP __ TRADE __ DROP
.byte $10,$00,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$10,$01,$00 ; name and class again

M_Char1Name:    ;52
.byte $10,$00,$00 ; Character 1's name

M_Char2Name:    ;53
.byte $11,$00,$00 ; Character 2's name

M_Char3Name:    ;54
.byte $12,$00,$00 ; Character 3's name

M_Char4Name:    ;55
.byte $13,$00,$00 ; Character 4's name

M_NowSaving:    ;56
.byte $97,$B2,$BA,$24,$A4,$B9,$1F,$AA,$69,$C4,$00 ; Now saving...! 

M_OrbGoldBoxLink: ;57 ; JIGS - to smooth out the weird orb box shape...
.byte $7B,$7C,$7C,$7C,$7C,$7C,$7C,$7D,$00

M_EquipmentSlots:
.byte $9B,$AC,$AA,$AB,$21,$91,$22,$A7,$FF,$FF,$F5,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$F6,$01         ; RIGHT_HAND__ 
.byte $95,$A8,$A9,$21,$FF,$91,$22,$A7,$FF,$FF,$F5,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$F6,$01         ; LEFT__HAND__
.byte $91,$2B,$A7,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$F5,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$F6,$01     ; HEAD________
.byte $8B,$B2,$A7,$BC,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$F5,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$F6,$01 ; BODY________
.byte $91,$22,$A7,$B6,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$F5,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$F6,$01     ; HANDS_______
.byte $8A,$A6,$48,$B6,$B6,$35,$BC,$FF,$FF,$FF,$F5,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$F6,$01         ; ACCESSORY___
.byte $8B,$39,$B7,$45,$C1,$92,$53,$B0,$FF,$F5,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$F6,$01             ; BATTLE_ITEM_
.byte $8B,$39,$B7,$45,$C1,$92,$53,$B0,$FF,$F5,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$F6,$00             ; BATTLE_ITEM_

M_EquipTrash:
.byte $8D,$92,$9C,$8C,$8A,$9B,$8D,$00

M_EquipStats:
.byte $8D,$A4,$B0,$A4,$66,$FF,$FF,$FF,$10,$3C,$FF,$FF  ; Damage
.byte $8D,$A8,$A9,$3A,$3E,$FF,$FF,$10,$3E,$01          ; Defense
.byte $8A,$A6,$A6,$55,$5E,$4B,$10,$3D,$FF,$FF          ; Accuracy
.byte $8E,$B9,$3F,$AC,$3C,$FF,$FF,$10,$3F,$00          ; Evasion

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Print Character Stat  [$8D70 :: 0x38D80]
;;
;;    Called by DrawComplexString to print a specific character stat
;;  String is printed to 'format_buf'
;;
;;  IN:  char_index = character index ($00, $40, $80, or $C0)
;;       A          = ID of stat to draw (between $03-0B and 2C-FF .. other values invalid)
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

PrintCharStat:
    CMP #$03      ; is ID == $03?
    BNE :+
      JMP @Level  ; if yes, print Level
:   CMP #$04
    BEQ @Exp      ; if $04, print Exp
    CMP #$05
    BEQ @CurHP    ; if $05, print CurHP
    CMP #$06
    BEQ @MaxHP    ; etc
    CMP #$07
    BEQ @Str
    CMP #$08
    BEQ @Agil
    CMP #$09
    BEQ @Int
    CMP #$0A
    BEQ @Vit
    CMP #$0B
    BEQ @Luck

    CMP #$3C
    BCS @CodeAbove3B   ; see if ID is >= #$3C
    
    CMP #$34 ; JIGS - check if its equal to or above $34, for Max MP
    BCS @MaxMP 
    
    CMP #$2C ; JIGS - check if its equal to or above $2C, for Max MP
    BCS @CurMP 
       
    ;;  2C-33 = Cur MP
    ;;  34-3B = Max MP
    
    ;CMP #$2C
    BCC @ExpToNext   ; see if ID is < #$2C (should never happen)
    
      @CurMP: ;; JIGS - adding this
      SEC
      SBC #$0C         ; subtract #$C  ($20-2F -- index + $20)
      CLC
      ADC char_index   ; add character index
      TAX
      LDA ch_mp-$20, X ; get MP  (need to subtract $20 because index is +$20)
      AND #$F0         ;; JIGS - gets current MP
      LSR A            ; and move it to low bits
      LSR A 
      LSR A 
      LSR A 
      ;ORA #$80        ;  Or with $80 to get this digit's tile
      STA tmp          ;  and print it as 1 Digit
      JMP PrintNumber_1Digit
    
    ;;; code reaches here if the ID is between $2C-3B  (prints MP... cur or max)
      @MaxMP:
      SEC
      SBC #$14         ; JIGS - originally subtract #$C  ($20-2F -- index + $20)
      CLC
      ADC char_index   ; add character index
      TAX
      LDA ch_mp-$20, X ; get MP  (need to subtract $20 because index is +$20)
      AND #$0F         ;; JIGS - gets max MP
      STA tmp          ;  and print it as 1 Digit
      JMP PrintNumber_1Digit
    
@CodeAbove3B:
    CMP #$42
    BCS @ExpToNext     ; see if ID is >= $42

    ;;; code reaches here if ID is between $3C-41  (prints substats, like Damage, Hit%, etc)
      SEC
      SBC #$3C            ; subtract #$3C  ($00-05)
      CLC
      ADC char_index      ; add character index
      TAX
      LDA ch_substats, X  ; get the substat
      STA tmp             ; write it as low byte
      LDA #0              ; set mid byte to 0 (need a mid byte for 3 Digit printing)
      STA tmp+1           ;  and print as 3 digits
      JMP PrintNumber_3Digit

    ;;; all other codes default to Exp to Next level
@ExpToNext:
      ;LDX char_index         ; get the index
      ;LDA ch_exptonext, X    ; low byte of Exp To Next
      ;STA tmp
      ;LDA ch_exptonext+1, X  ; mid byte
      ;STA tmp+1
      ;LDA #0                 ; high byte is 0 (5 digit numbers need a high byte)
      ;STA tmp+2              ; print it as 5 digits
      
      JSR LongCall
      .word PrintEXPToNext_B
      .byte $0B      
      JMP PrintNumber_5Digit
      

@Exp:
    LDABRA <ch_exp, @Stat6Digit    ; put low byte of address of desired stat in A, then BRA to @Stat6Digit
                                   ;  see macros.inc for this macro

@CurHP:
    LDABRA <ch_curhp, @Stat3Digit

@MaxHP:
    LDABRA <ch_maxhp, @Stat3Digit

@Str:
    LDABRA <ch_strength, @Stat2Digit

@Agil:
    LDABRA <ch_agility, @Stat2Digit

@Int:
    LDABRA <ch_intelligence, @Stat2Digit

@Vit:
    LDABRA <ch_vitality, @Stat2Digit

@Luck:
    LDABRA <ch_speed, @Stat2Digit

@Stat1Digit:       ; same as below routines -- but 1 byte, 1 digit
    CLC            ;  I do not believe this 1Digit code is ever called
    ADC char_index
    TAX
    LDA ch_stats, X
    STA tmp
    JMP PrintNumber_1Digit

@Stat2Digit:       ; same as below routines -- but 1 byte, 2 digits
    CLC
    ADC char_index
    TAX
    LDA ch_stats, X
    STA tmp
    JMP PrintNumber_2Digit

@Stat3Digit:
    CLC
    ADC char_index     ; add character index to stat ID (currently in A)
    TAX                ; use this to index stat from start of player stats ($6100)
    LDA ch_stats, X
    STA tmp
    LDA ch_stats+1, X  ; read a 2-byte number
    STA tmp+1          ; and print it as 3-digits
    JMP PrintNumber_3Digit

@Stat6Digit:
    CLC
    ADC char_index      ; add character index to stat ID (currently in A)
    TAX                 ; use this to index stat from start of player stats ($6100)
    LDA ch_stats, X
    STA tmp
    LDA ch_stats+1, X   ; read a 3-byte number
    STA tmp+1
    LDA ch_stats+2, X
    STA tmp+2           ; and print it as 6-digits
    JMP PrintNumber_6Digit

;;  Stat Code = $03 -- character level
@Level:
    LDX char_index   ; Get Character index
    LDA ch_level, X  ; Get character's level
    CLC
    ADC #$01         ; Add 1 to it ($00 is "Level 1")
    STA tmp          ; and print it as 2-digit
    JMP PrintNumber_2Digit



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Print Price  [$8E44 :: 0x38E54]
;;
;;    Fetches desired item price, then prints it to a temp drawing buffer
;;  (see Print Number below for details)
;;
;;  IN:  A = item ID whose price we're printing
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

PrintPrice:
    JSR LoadPrice             ; just load the price
    JMP PrintNumber_5Digit    ; and print it as 5-digits!

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Print Gold   [$8E4A :: 0x38E5A]
;;
;;    Loads and prints current gold amount into a temporary drawing buffer
;;    (see Print Number below for details)
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

PrintGold:
    LDA gold     ; just copy the gold to the routine input vars
    STA tmp      ;   and then call "print"
    LDA gold+1
    STA tmp+1
    LDA gold+2
    STA tmp+2
    JMP PrintNumber_6Digit

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Print Number   [$8E5C :: 0x38E6C]
;;
;;    These routines print a number of a desired number of digits to format_buf.
;;  The number is right-aligned with zeros trimmed off the front
;;  (ie:  "  67" instead of "0067").  A pointer to the start of the buffer
;;  is then stored at text_ptr.
;;
;;   The printed number is not null terminated... therefore the end of format_buf
;;  must always contain 0 so that this string is null terminated when it is attempted
;;  to be drawn
;;
;;  IN:  tmp = 3-byte number to print
;;            only the low byte is used for 1,2 digit printing
;;            and the highest byte is only used for 5,6 digit printing
;;
;;  OUT: format_buf = buffer receiving the printed string
;;       text_ptr   = pointer to start of buffer
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

PrintBattleTurn:
    LDA BattleTurn
    STA tmp
    JMP PrintNumber_2Digit
    ;; JIGS ^ prints battle turn in battles

PrintNumber_1Digit:
    LDA tmp              ; no real formatting involved in 1-digit numbers
    ORA #$80             ; just OR the number with $80 to convert it to the tile ID
    STA format_buf-1     ; write it to output buffer
    LDABRA <format_buf-1, PrintNumber_Exit
                         ; A = start of string, then BNE (or BEQ) to exit

PrintNumber_2Digit:
    JSR FormatNumber_2Digits   ; format the number
    JSR TrimZeros_2Digits      ; trim leading zeros
    LDABRA <format_buf-2, PrintNumber_Exit      ; string start

PrintNumber_3Digit:            ; more of same...
    JSR FormatNumber_3Digits
    JSR TrimZeros_3Digits
    LDABRA <format_buf-3, PrintNumber_Exit

PrintNumber_4Digit:            ; more of same.
    JSR FormatNumber_4Digits   ; though... I don't think this 4-digit routine is used anywhere in the game
    JSR TrimZeros_4Digits
    LDABRA <format_buf-4, PrintNumber_Exit

PrintNumber_5Digit:
    JSR FormatNumber_5Digits
    JSR TrimZeros_5Digits
    LDABRA <format_buf-5, PrintNumber_Exit

PrintNumber_6Digit:
    JSR FormatNumber_6Digits
    JSR TrimZeros_6Digits
    LDABRA <format_buf-6, PrintNumber_Exit

PrintNumber_Exit:         ; on exit, each of the above routines put the low byte
    STA text_ptr          ; of the pointer in A -- store that to text_ptr, our output pointer
    LDA #>format_buf      ;  high byte
    STA text_ptr+1
    RTS                   ; and exit!

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Trim Zeros  [$8E9F :: 0x38EAF]
;;
;;    These routines examine the formatted string in format_buf and
;;  replace leading '0' characters ($80) with a blank space character ($FF)
;;  which converts a string like "0100" to the desired " 100"
;;
;;    The ones digits (at format_buf-1) is never trimmed.  So you still get "  0"
;;  if the number is zero.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

TrimZeros_6Digits:
    LDA format_buf-6   ; get first digit
    CMP #$80           ; check if it's "0" (tile $80)
    BNE TrimZeros_RTS  ; if it's not, exit
    LDA #$FF           ; if it is, replace with blank space ($FF)
    STA format_buf-6   ;  and continue on to lower digits

TrimZeros_5Digits:     ; etc
    LDA format_buf-5
    CMP #$80
    BNE TrimZeros_RTS
    LDA #$FF
    STA format_buf-5

TrimZeros_4Digits:
    LDA format_buf-4
    CMP #$80
    BNE TrimZeros_RTS
    LDA #$FF
    STA format_buf-4

TrimZeros_3Digits:
    LDA format_buf-3
    CMP #$80
    BNE TrimZeros_RTS
    LDA #$FF
    STA format_buf-3

TrimZeros_2Digits:
    LDA format_buf-2
    CMP #$80
    BNE TrimZeros_RTS
    LDA #$FF
    STA format_buf-2

TrimZeros_RTS:
    RTS


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Format Number  [$8ED2 :: 0x38EE2]
;;
;;   These routines format a given number into a string that can be displayed
;;  on screen.  This involves converting to decimal base, which is a lengthy process
;;
;;  IN:  tmp = 3-byte value containing the number to format
;;
;;  OUT: format_buf = buffer filled with the formatted string to print (not explicitly null terminated
;;                    it is assumed format_buf is always null terminated)
;;
;;    There are several entry points to format the number into different lengths (6 digits, down to 2 digits)
;;  In the case of fewer digits, the first few bytes of the output buffer go unused.  IE:  for a 5-digit
;;  format, the first byte in format_buf remains unchanged.
;;
;;    Also, the high byte of the number is only used for 5 or 6 digit formats
;;    And the mid byte is only used for 3, 4, 5, 6 digits formats
;;
;;    Buffer will be filled with the '0' character (tile $80) for all digits that are 0,
;;  even if they're at the start of the string.  IE:  $0064 formatted as 4 digits will
;;  produce "0100" instead of " 100".  These leading zeros are later trimmed via the
;;  above TrimZeros series of routines
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


FormatNumber_6Digits:
    LDX #8            ; start with '900000' and work your way downward
@Loop:
    LDA tmp+2             ; get high byte of number
    CMP lut_DecD6_hi, X   ; see if it's greater than high byte of our check
    BEQ @Equal            ;  if it's equal.. to the check... need to do further comparisons
    BCS @Good             ;  if it's greater than the check... then this is the digit to print

@Less:                    ; if the number is less than the check...
    DEX                   ; decrement the check to look at next lowest
    BPL @Loop             ; and loop to continue checking until we've checked all 9 digits

      LDX #$80                   ;  code reaches here if we went through all 9 digits and there was no match
      STX format_buf-6           ; This means the number has no 6th digit -- so use the '0' character instead ($80)
      JMP FormatNumber_5Digits   ; And continue formatting by formatting for 5 digits

@Equal:                   ; if the high byte was equal to the check, we need to compare the middle byte
    LDA tmp+1             ;  load up the middle byte
    CMP lut_DecD6_md, X   ;  compare to check
    BEQ @Equal2           ; if equal, we still need to check the low byte.. so jump ahead to that
    BCC @Less             ; if less, digit is no good
    BCS @Good             ; if greater, digit is good

@Equal2:                  ; the final check for this digit
    LDA tmp               ; get low byte
    CMP lut_DecD6_lo, X   ; see if it's less than the check.  If it is, it's no good
    BCC @Less             ;  otherwise... if it's greater than or equal, it's good

@Good:                    ; code reaches here if the number is >= our check
    LDA tmp               ;  now.. we subtract the check from the number, so can can
    SEC                   ;  continue formatting for further digits
    SBC lut_DecD6_lo, X   ; subtract low byte of check
    STA tmp
    LDA tmp+1
    SBC lut_DecD6_md, X   ; mid byte
    STA tmp+1
    LDA tmp+2
    SBC lut_DecD6_hi, X   ; high byte
    STA tmp+2

    TXA                   ; lastly, X is our desired digit to print - 1 (ie:  X=0 means we want to print "1")
    CLC                   ;  so move X to A, and add #$81 (digits start at tile $80)
    ADC #$81              ;  and store it to our output buffer
    STA format_buf-6      ; afterwards, program flow moves seamlessly into the 5-digit format routine


FormatNumber_5Digits:         ; Flow in this routine is identical to the flow in
    LDX #8                    ;  FormatNumber_6Digits.  Rather than recomment it all, see that routine for details
@Loop:
    LDA tmp+2
    CMP lut_DecD5_hi, X
    BEQ @Equal
    BCS @Good

@Less:
    DEX
    BPL @Loop
 
      LDX #$80
      STX format_buf-5
      JMP FormatNumber_4Digits

@Equal:
    LDA tmp+1
    CMP lut_DecD5_md, X
    BEQ @Equal2
    BCC @Less
    BCS @Good

@Equal2:
    LDA tmp
    CMP lut_DecD5_lo, X
    BCC @Less


@Good:
    LDA tmp
    SEC
    SBC lut_DecD5_lo, X
    STA tmp
    LDA tmp+1
    SBC lut_DecD5_md, X
    STA tmp+1
    LDA tmp+2
    SBC lut_DecD5_hi, X
    STA tmp+2
    TXA
    CLC
    ADC #$81
    STA format_buf-5


FormatNumber_4Digits:     ; again... this routine is exactly the same as the above... so see that
    LDX #8                ;  for details.  Only difference here is there is no high byte check (4 digit numbers don't go beyond 2 bytes)
@Loop:
    LDA tmp+1
    CMP lut_DecD4_md, X
    BEQ @Equal
    BCS @Good

@Less:
    DEX
    BPL @Loop

      LDX #$80
      STX format_buf-4
      JMP FormatNumber_3Digits

@Equal:
    LDA tmp
    CMP lut_DecD4_lo, X
    BCC @Less

@Good:
    LDA tmp
    SEC
    SBC lut_DecD4_lo, X
    STA tmp
    LDA tmp+1
    SBC lut_DecD4_md, X
    STA tmp+1
    TXA
    CLC
    ADC #$81
    STA format_buf-4


FormatNumber_3Digits:  ; again... more of the same
    LDX #8
@Loop:
    LDA tmp+1
    CMP lut_DecD3_md, X
    BEQ @Equal
    BCS @Good

@Less:
    DEX
    BPL @Loop

      LDX #$80
      STX format_buf-3
      JMP FormatNumber_2Digits

@Equal:
    LDA tmp
    CMP lut_DecD3_lo, X
    BCC @Less

@Good:
    LDA tmp
    SEC
    SBC lut_DecD3_lo, X
    STA tmp
    LDA tmp+1
    SBC lut_DecD3_md, X
    STA tmp+1
    TXA
    CLC
    ADC #$81
    STA format_buf-3


FormatNumber_2Digits:   ; 2 digit numbers are done a bit differently... since they are only 1 byte in size
                        ;  no LUT is used... just keep subtracting 10 until you can't any more
    LDX #0              ; X is the counter to keep track of how many times we subtracted (thus, is the desired digit)
                        ;   start it at 0

    LDA tmp             ; get low digit into A
@Loop:
    CMP #10             ; if < 10, can't subtract anymore.. so we're done
    BCC @Done

      SBC #10           ; otherwise, subtract 10
      INX               ; increment our tens counter
      BNE @Loop         ; and loop (this will always branch, as X cannot be zero after above INX)

@Done:                  ; here, we're done.  A is now the ones and X is the tens
    ORA #$80            ;  so OR with $80 and output the ones digit
    STA format_buf-1
    TXA                 ; then grab X
    ORA #$80            ; OR it with $80
    STA format_buf-2    ; and output the tens digit
    RTS                 ; and we're done!

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Decimal conversion LUTs  [$8FD1 :: 0x38FE1]
;;
;;   code uses these LUTs to do binary to decimal conversion to print
;;  numbers onto the screen.  Each group of tables has 9 entries, one for
;;  each digit.
;;
;;  2-digit numbers don't use LUTs, and you don't need a LUT for single digits.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

lut_DecD6_hi:  .BYTE ^100000,^200000,^300000,^400000,^500000,^600000,^700000,^800000,^900000
lut_DecD6_md:  .BYTE >100000,>200000,>300000,>400000,>500000,>600000,>700000,>800000,>900000
lut_DecD6_lo:  .BYTE <100000,<200000,<300000,<400000,<500000,<600000,<700000,<800000,<900000

lut_DecD5_hi:  .BYTE ^10000,^20000,^30000,^40000,^50000,^60000,^70000,^80000,^90000
lut_DecD5_md:  .BYTE >10000,>20000,>30000,>40000,>50000,>60000,>70000,>80000,>90000
lut_DecD5_lo:  .BYTE <10000,<20000,<30000,<40000,<50000,<60000,<70000,<80000,<90000

lut_DecD4_md:  .BYTE >1000,>2000,>3000,>4000,>5000,>6000,>7000,>8000,>9000
lut_DecD4_lo:  .BYTE <1000,<2000,<3000,<4000,<5000,<6000,<7000,<8000,<9000

lut_DecD3_md:  .BYTE >100,>200,>300,>400,>500,>600,>700,>800,>900
lut_DecD3_lo:  .BYTE <100,<200,<300,<400,<500,<600,<700,<800,<900




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Enter Lineup Menu  [$9915 :: 0x39925]
;;

UndoSwap_Error:
      JSR PlaySFX_Error

UndoSwap:             ; if they escaped the sub target menu...
      LDX MMC5_tmp
      LDA ch_ailments, X
      AND #$0F
      STA ch_ailments, X     ; clear high bits in ailments to reset pose

SwappingDone:      
      LDA #0
      STA joy_select
      SEC     ; set C to indicate swap was unsuccesful
      RTS 

LineUp_InMenu:
    JSR MainMenuSubTarget       ; select a sub target
    BCS SwappingDone        ;  if they escaped the sub target selection, then escape it
    ;; cursor is now first character... 
    
      JSR PlaySFX_MenuSel         ; play the selection sound effect  
      LDA cursor                ; otherwise (A pressed), get the selected character
      ROR A
      ROR A
      ROR A
      AND #$C0                  ; and shift it to a useable character index
      STA MMC5_tmp              ; swap target
      TAX                       ; and put in X

      LDA ch_ailments, X        ; get this character's OB ailments
      CMP #$01
      BEQ UndoSwap_Error      ; if dead.. they're not swappable
      CMP #$02
      BEQ UndoSwap_Error      ; if stone, they're not swappable
      
      ORA #$80
      STA ch_ailments, X      ; set high bit in ailments
      
        JSR MainMenuSubTarget_NoClear ; get second target, don't clear cursor
        BCS UndoSwap
        
       JSR PlaySFX_MenuSel         ; play the selection sound effect   
       LDA cursor                ; otherwise (A pressed), get the selected character
       ROR A
       ROR A
       ROR A
       AND #$C0                  ; and shift it to a useable character index
       STA MMC5_tmp+1            ; swap target 2
       TAX                       ; and put in X
       
       CMP MMC5_tmp
       BEQ UndoSwap_Error       ; can't swap the same character!

      LDA ch_ailments, X        ; get this character's OB ailments
      CMP #$01
      BEQ UndoSwap_Error             ; if dead.. they're not swappable
      CMP #$02
      BEQ UndoSwap_Error             ; if stone, they're not swappable
      
      LDX MMC5_tmp+1       ; second swap character
      
      LDY #0
    : LDA ch_stats, X         ; backup character 2
      STA CharStats_TmpSwap2, Y
      INX 
      INY
      CPY #$40
      BNE :-

      LDX MMC5_tmp           ; first swap character

      LDY #0
    : LDA ch_stats, X         ; backup character 1
      STA CharStats_TmpSwap1, Y
      INX
      INY
      CPY #$40
      BNE :-
    
      LDX MMC5_tmp+1          ; second swap character   
      
      LDY #0
    : LDA CharStats_TmpSwap1, Y         ; restore character 2 in 1's slot
      STA ch_stats, X
      INX
      INY
      CPY #$40
      BNE :-    
      
      LDX MMC5_tmp        ; first swap character
      
      LDY #0
    : LDA CharStats_TmpSwap2, Y         ; restore character 1 in 2's slot
      STA ch_stats, X
      INX
      INY
      CPY #$40
      BNE :-
            
      @SwapComplete:
      LDX MMC5_tmp+1      
      LDA ch_ailments, X
      AND #$0F
      STA ch_ailments, X     ; clear high bits in ailments to reset pose
      
      LDA #0
      STA joy_select
      CLC                    ; clear C to indicate swap successful
      JMP PlaySFX_CharSwap
      
      





;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Clear Nametable  [$9C02 :: 0x39C12]
;;
;;    This clears the full nametable (ppu$2000) to 00, as well as filling
;;   the attribute table with FF.  This provides a "clean slate" on which
;;   menu boxes and stuff can be drawn to.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; JIGS - added this first thing here, to fill the background with a colour instead of inside boxes

ClearNT_FillBackground:
    LDA #$EF
    STA MMC5_tmp
    JMP ClearNT_Color
    
ClearNT:
    LDA #$00
    STA MMC5_tmp
    
    ;LDA $2002     ; reset PPU toggle
    ;LDA #$20
    ;STA $2006
    ;LDA #$00
    ;STA $2006     ; set PPU addr to $2000 (start of NT)
    ;LDY #$00      ; zero out A and Y
    ;TYA           ;   Y will be the low byte of our counter
    ;LDX #$03      ; X=3 -- this is the high byte of our counter (loop $0300 times)
    
    ;; JIGS - I think I accidentally deleted an original line somewhere... maybe. 

ClearNT_Color:   ;; JIGS - now this loads either 0 or FF depending what you want to fill the background with
    LDA $2002     ; reset PPU toggle
    LDA #$20
    STA $2006
    LDA #$00
    STA $2006     ; set PPU addr to $2000 (start of NT)
    TAY
    LDA MMC5_tmp
    LDX #$03      

@Loop:            ; first loop clears the first $0300 bytes of the NT
      STA $2007
      INY
      BNE @Loop      ; once Y wraps
        DEX          ;  decrement X
        BNE @Loop    ;  and stop looping once X expires (total $0300 iterations)

@Loop2:           ; next loop clears the next $00C0 (up to the attribute table)
      STA $2007
      INY
      CPY #$C0       ; loop until Y reaches #$C0
      BCC @Loop2


    LDA #$FF      ; A=FF (this is what we will fill attribute table with
@Loop3:           ;  3rd and final loop fills the last $40 bytes (attribute table) with FF
      STA $2007
      INY
      BNE @Loop3

    RTS


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Draw Character Name  [$9C2E :: 0x39C3E]
;;
;;     Draws a given character name at given coords
;;
;;  IN:             A = char index (00,40,80,C0)
;;      dest_x,dest_y = coords to draw at
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


DrawCharacterName:
    TAX                    ; put char index in X

    ;LDA ch_name, X         ; copy the character name to the format_buf
    ;STA format_buf-4
    ;LDA ch_name+1, X
    ;STA format_buf-3
    ;LDA ch_name+2, X
    ;STA format_buf-2
    ;LDA ch_name+3, X
    ;STA format_buf-1

    ;LDA #<(format_buf-4)   ; set text_ptr to point to it
    ;STA text_ptr
    ;LDA #>(format_buf-4)
    ;STA text_ptr+1
    
    ;; JIGS - 7 letter name edit!
    
    LDA ch_name, X       
    STA format_buf-7
    LDA ch_name+1, X
    STA format_buf-6
    LDA ch_name+2, X
    STA format_buf-5
    LDA ch_name+3, X
    STA format_buf-4
    LDA ch_name+4, X
    STA format_buf-3
    LDA ch_name+5, X
    STA format_buf-2
    LDA ch_name+6, X
    STA format_buf-1
    
    LDA #<(format_buf-7) 
    STA text_ptr
    LDA #>(format_buf-7)
    STA text_ptr+1

    LDA #BANK_THIS         ; set banks required for DrawComplexString
    STA cur_bank
    STA ret_bank

    JMP DrawComplexString  ; Draw it!  Then return




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  NewGamePartyGeneration  [$9C54 :: 0x39C64]
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

    ReturnToTitle:
    PLA
    PLA ; remove the "JSR NewGamePartyGeneration" bit from the stack?
    JMP CancelNewGame
    ;; JIGS - hope this works!

NewGamePartyGeneration:
    LDA #$00                ; turn off the PPU
    STA $2001

    JSR LoadMenuCHRPal
    JSR LoadPtyGenBGCHRAndPalettes
    
    LDX #$4B        ; Initialize the ptygen buffer!
    ;;  JIGS - bigger buffer! Buff buff.
    : LDA lut_PtyGenBuf, X  ;  all $40 bytes!  ($10 bytes per character)
      STA ptygen, X
      DEX
      BPL :-
      
    LDA #$00        ; This null-terminates the draw buffer for when the character's
    STA $60         ;   name is drawn on the name input screen.  Why this is done here
                    ;   and not with the actual drawing makes no sense to me.
    
    
  @Char_0:                      ; To Character generation for each of the 4 characters
    LDA #$00                    ;   branching back to the previous char if the user
    STA char_index              ;   cancelled by pressing B
    JSR DoPartyGen_OnCharacter
    BCS ReturnToTitle
    ;; JIGS ^ if you accidentally clicked new game...
  @Char_1:
    LDA #$13  ;; JIGS - every character has 3 more bytes in ptygen now
    STA char_index
    JSR DoPartyGen_OnCharacter
    BCS @Char_0
  @Char_2:
    LDA #$26  
    STA char_index
    JSR DoPartyGen_OnCharacter
    BCS @Char_1
  @Char_3:
    LDA #$39  
    STA char_index
    JSR DoPartyGen_OnCharacter
    BCS @Char_2
    
    
    ; Once all 4 characters have been generated and named...
    JSR PtyGen_DrawScreen       ; Draw the screen one more time
    JSR ClearOAM                ; Clear OAM
    JSR PtyGen_DrawChars        ; Redraw char sprites
    JSR WaitForVBlank_L         ; Do a frame
    LDA #>oam                   ;   with a proper OAM update
    STA $4014
    
    JSR MenuWaitForBtn_SFX      ; Wait for the user to press A (or B) again, to
    LDA joy                     ;  confirm their party decisions.
    AND #$40
    BNE @Char_3                 ; If they pressed B, jump back to Char 3 generation
    
    ;;  Otherwise, they've pressed A!  Party confirmed!
    LDA #$00
    STA $2001                   ; shut the PPU off
    
    LDX #$00                    ; Move class and name selection
    JSR @RecordClassAndName     ;  out of the ptygen buffer and into the actual character stats
    LDX #$13
    JSR @RecordClassAndName
    LDX #$26
    JSR @RecordClassAndName
    LDX #$39
    
  @RecordClassAndName:
    TXA                     ; X is the ptygen source index  ($10 bytes per character)

  ;; JIGS - X needs to be 0, 13, 26, and 39
  ;;        Y needs to be 0, 10, 20, and 30, ASL A'd twice    
    AND #$F0                ; - so cut off low byte!
    
    ASL A
    ASL A
    TAY                     ; Y is the ch_stats dest index  ($40 bytes per character)
    
    LDA ptygen_sprite, X ; get sprite
    ASL A                ; shift the low bits into the high bits
    ASL A
    ASL A
    ASL A    
    ORA ptygen_class, X  ; combine with class bits
    STA ch_class, Y      ; and save!
    
    LDA ptygen_name+0, X ; then save name!
    STA ch_name    +0, Y
    LDA ptygen_name+1, X
    STA ch_name    +1, Y
    LDA ptygen_name+2, X
    STA ch_name    +2, Y
    LDA ptygen_name+3, X
    STA ch_name    +3, Y
    LDA ptygen_name+4, X
    STA ch_name    +4, Y
    LDA ptygen_name+5, X
    STA ch_name    +5, Y
    LDA ptygen_name+6, X
    STA ch_name    +6, Y
    
    ;; JIGS - LONGER NAMES
    
    RTS
    


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  PtyGen_DrawScreen  [$9CF8 :: 0x39D08]
;;
;;    Prepares and draws the Party Generation screen
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

PtyGen_DrawScreen:
    LDA #$08
    STA soft2000          ; set BG/Spr pattern table assignments
    LDA #0
    STA $2001             ; turn off PPU
    STA joy_a             ;  clear various joypad catchers
    STA joy_b
    STA joy
    STA joy_prevdir

    JSR TitleScreenBGColour         ; Change the colour of the Title Screen
    JSR ClearNT_FillBackground      ; Fill the background with colour instead of boxes
    JSR PtyGen_DrawBoxes    
    JSR PtyGen_DrawText     
    JMP TurnMenuScreenOn_ClearOAM
    
    TitleScreenBGColour:
    LDA #$01
    STA cur_pal+1
    STA cur_pal+13
    RTS


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  DoPartyGen_OnCharacter  [$9D15 :: 0x39D25]
;;
;;    Does character selection and name input for one character.
;;
;;  input:      ptygen = should be filled appropriately
;;          char_index = $00, 10, 20, 30 to indicate which character's name we're setting
;;
;;  output:    C is cleared if the user confirmed/named their character
;;             C is set if the user pressed B to cancel/go back
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

DoPartyGen_OnCharacter:
    JSR PtyGen_DrawScreen           ; Draw the Party generation screen
    
    ; Then enter the main logic loop
  @MainLoop:
      JSR PtyGen_Frame              ; Do a frame and update joypad input
      LDA joy_a
      BNE DoNameInput               ; if A was pressed, do name input
      LDA joy_b
      BEQ :+
        ; if B pressed -- just SEC and exit
        SEC
        RTS
      
      ; Code reaches here if A/B were not pressed
    : LDA joy
      AND #$0F
      CMP joy_prevdir
      BEQ @MainLoop             ; if there was no change in directional input, loop to another frame
      
      STA joy_prevdir           ; otherwise, record new directional input as prevdir
      CMP #$00                  ; if directional input released (rather than pressed)
      BEQ @MainLoop             ;   loop to another frame.
      
      ;; JIGS-- Left/Right now change the class, Up/Down change the sprite.
      CMP #$02  ; if left is pressed
        BEQ @ReverseCharThing
      CMP #$04  ; or if down is pressed
        BEQ @ReverseCharSpriteThing
      CMP #$08  ; or if up is pressed
        BEQ @CharSpriteThing
    
     ; Otherwise, if any direction was pressed:
      LDX char_index
      CLC
      LDA ptygen_class, X       ; Add 1 to the class ID of the current character.
      ADC #1
      CMP #6                    ; JIGS - change this to 12 for all classes
      BCC :+
        LDA #0                  ; wrap 5->0
    : STA ptygen_class, X
  
      LDA #$01                  ; set menustall (drawing while PPU is on)
      STA menustall
      LDX char_index            ; then update the on-screen class name
      JSR PtyGen_DrawOneText
      JMP @MainLoop
      
      @ReverseCharThing:
      LDX char_index
      LDA ptygen_class, X       ; Subtract 1 from the class ID of the current character.
      SEC 
      SBC #1
      CMP #6                    ; JIGS - change this to 12 for all classes 
      BCC :-
        LDA #5                  ; JIGS - and then change this to 11
      JMP :-
  
      @CharSpriteThing:
      LDX char_index
      LDA ptygen_sprite, X 
      CLC
      ADC #1
      CMP #6                    ; JIGS - change this to 12 for all classes 
      BCC :+
         LDA #0
    : STA ptygen_sprite, X    
      JMP @MainLoop
      
      @ReverseCharSpriteThing:
      LDX char_index
      LDA ptygen_sprite, X    ; Subtract 1 from the sprite ID of the current character.
      SEC 
      SBC #1
      CMP #6                  ; JIGS - change this to 12 for all classes   
      BCC :-
        LDA #5                ; JIGS - and then change this to 11  
      STA ptygen_sprite, X  
      JMP :-  
  
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  DoNameInput  [$9D50 :: 0x39D60]
;;
;;    Does the name input screen.  Draw the screen, gets the name, etc, etc.
;;
;;  input:      ptygen = should be filled appropriately
;;          char_index = $00, 10, 20, 30 to indicate which character's name we're setting
;;
;;  output:    C is cleared to indicate name successfully input
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

DoNameInput:
    LDA #$00                ; Turn off the PPU (for drawing)
    STA $2001
    
    STA menustall           ; zero a bunch of misc vars being used here
    STA joy_a
    STA joy_b
    STA joy_start
    STA joy
    STA joy_prevdir
    
    STA cursor              ; letter of the name we're inputting (0-3)
    STA namecurs_x          ; X position of letter selection cursor (0-9)
    STA namecurs_y          ; Y position (0-6)
    
    ; Some local temp vars
                @cursoradd      = $63
                @selectedtile   = $10
    
    JSR ClearNT_FillBackground
    ;; JIGS - its nicer this way with the box inside background being black
    JSR DrawNameInputScreen
    
    LDX char_index          ; wipe this character's name
    LDA #$FF
    STA ptygen_name, X
    STA ptygen_name+1, X
    STA ptygen_name+2, X
    STA ptygen_name+3, X
    STA ptygen_name+4, X
    STA ptygen_name+5, X
    STA ptygen_name+6, X
    
    JSR TurnMenuScreenOn_ClearOAM   ; now that everything is drawn, turn the screen on
    
    LDA #$01                ; Set menustall, as future drawing will
    STA menustall           ;  be with the PPU on
    JMP @MainLoop
    
      ;;;;;;;;;;;;;;;;;;
   @StartDone:
    CLC
    RTS      
      
  @Start_Pressed:
    LDA char_index
    CLC
    ADC #7
    TAX
  : DEX
    LDA ptygen_name, X     
    CMP #$FF
    BNE @StartDone
    CPX #$0
    BNE :-
    STX joy_start
    
  @MainLoop:
    JSR CharName_Frame      ; Do a frame & get input

    LDA joy_start
    BNE @Start_Pressed    
    LDA joy_a
    BNE @A_Pressed          ; Check if A or B pressed
    LDA joy_b
    BNE @B_Pressed
    
    LDA joy                 ; Otherwise see if D-pad state has changed
    AND #$0F
    CMP joy_prevdir
    BEQ @MainLoop           ; no change?  Jump back
    STA joy_prevdir
    
       ; D-pad state has changed, see what it changed to
    CMP #$00
    BEQ @MainLoop           ; if released, do nothing and loop
    
    CMP #$04
    BCC @Left_Or_Right      ; if < 4, L or R pressed
    
    CMP #$08                ; otherwise, if == 8, Up pressed
    BNE @Down               ; otherwise, if != 8, Down pressed
    
  @Up:
    DEC namecurs_y          ; DEC cursor Y position
    BPL @MainLoop
    LDA #$06                ; wrap 0->6
    STA namecurs_y
    JMP @MainLoop
    
  @Down:
    INC namecurs_y          ; INC cursor Y position
    LDA namecurs_y
    CMP #$07                ; wrap 6->0
    BCC @MainLoop
    LDA #$00
    STA namecurs_y
    JMP @MainLoop
    
  @Left_Or_Right:
    CMP #$02                ; if D-pad state == 2, Left pressed
    BNE @Right              ; else, Right pressed
    
  @Left:
    DEC namecurs_x          ; DEC cursor X position
    BPL @MainLoop
    LDA #$09                ; wrap 0->9
    STA namecurs_x
    JMP @MainLoop
    
  @Right:
    INC namecurs_x          ; INC cursor X position
    LDA namecurs_x
    CMP #$0A                ; wrap 9->0
    BCC @MainLoop
    LDA #$00
    STA namecurs_x
    JMP @MainLoop
    

    
 @B_Pressed:
    LDA #$FF                ; if B was pressed, erase the previous tile
    STA @selectedtile       ;   by setting selectedtile to be a space
    
    LDA cursor              ; then by pre-emptively moving the cursor back
    SEC                     ;   so @SetTile will overwrite the prev char
    SBC #$01                ;   instead of the next one
    ;BMI :+                  ; (clip at 0)
      STA cursor
      CMP #$FF
      BEQ @B_RTS
        
    LDA #$00                ; set cursoradd to 0 so @SetTile doesn't change
    STA @cursoradd          ; the cursor
    STA joy_b               ; clear joy_b as well
    BEQ @SetTile            ; (always branches)
    
    @B_RTS:
    JMP DoPartyGen_OnCharacter      
    
    ;;;;;;;;;;;;;;;;;;
  @A_Pressed:
    LDX namecurs_y                  ; when A is pressed, clear joy_a
    LDA #$00
    STA joy_a                       ; Then get the tile they selected by first
    LDA lut_NameInputRowStart, X    ;  running the Y cursor through a row lut
    CLC
    ADC namecurs_x                  ; add X cursor
    ASL A                           ; and multiply by 2 -- since there are spaces between tiles
    TAX                             ; use that value as an index to the lut_NameInput
  ;  BCC :+                          ; This will always branch, as C will always be clear
  ;      LDA lut_NameInput+$100, X       ; I can only guess this was used in the Japanese version, where the NameInput table might have been bigger than 
  ;      JMP :++                         ; 256 bytes -- even though that seems very unlikely.
        
  : LDA lut_NameInput, X
  : STA @selectedtile               ; record selected tile
    LDA #$01
    STA @cursoradd                  ; set cursoradd to 1 to indicate we want @SetTile to move the cursor forward
    
    LDA cursor                      ; check current cursor position
    CMP #$07                       ;  If we've already input 7 letters for this name....
    BCS @Done                       ;  .. then we're done.  Branch ahead
                                    ; Otherwise, fall through to SetTile

  @SetTile:
    LDA cursor                  ; use cursor and char_index to access the appropriate
    CLC                         ;   letter in this character's name
    ADC char_index
    TAX
    LDA @selectedtile
    STA ptygen_name, X          ; and write the selected tile
    
    JSR NameInput_DrawName      ; Redraw the name as it appears on-screen
    
    LDA cursor                  ; Then add to our cursor
    CLC
    ADC @cursoradd
 ;   BPL :+                      ; clipping at 0 (if subtracting -- although this never happens)
 ;     LDA #$00
  : STA cursor
  
    JMP @MainLoop               ; And keep going!
  
    
  @Done:
    CLC                 ; CLC to indicate name was successfully input
    RTS

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  PtyGen_Frame  [$9E33 :: 0x39E43]
;;
;;    Does the typical frame stuff for the Party Gen screen
;;  Note the scroll is not reset here, since there is a little bit of drawing
;;  done AFTER this (which is dangerous -- what if the music routine runs long!)
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

PtyGen_Frame:
    JSR ClearOAM           ; wipe OAM then draw all sprites
    JSR PtyGen_DrawChars
    JSR PtyGen_DrawCursor

    JSR WaitForVBlank_L    ; VBlank and DMA
    LDA #>oam
    STA $4014

    LDA #BANK_THIS         ; then keep playing music
    STA cur_bank
    JSR CallMusicPlay

    JMP PtyGen_Joy         ; and update joy data!


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  CharName_Frame  [$9E4E :: 0x39E5E]
;;
;;    Does typical frame stuff for the Character naming screen
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

CharName_Frame:
    JSR ClearOAM           ; wipe OAM then draw the cursor
    JSR CharName_DrawCursor

    JSR WaitForVBlank_L    ; VBlank and DMA
    LDA #>oam
    STA $4014

    LDA soft2000           ; reset the scroll to zero.
    STA $2000
    LDA #0
    STA $2005
    STA $2005

    LDA #BANK_THIS         ; keep playing music
    STA cur_bank
    JSR CallMusicPlay

      ; then update joy by running seamlessly into PtyGen_Joy

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  PtyGen_Joy  [$9E70 :: 0x39E80]
;;
;;    Updates Joypad data and plays button related sound effects for the Party
;;  Generation AND Character Naming screens.  Seems like a huge waste, since sfx could
;;  be easily inserted where the game handles the button presses.  But whatever.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

PtyGen_Joy:
    LDA joy
    AND #$0F
    STA tmp+7            ; put old directional buttons in tmp+7 for now

    JSR UpdateJoy        ; then update joypad data

    LDA joy_a            ; if either A or B pressed...
    ORA joy_b
    BEQ :+
      JMP PlaySFX_MenuSel ; play the Selection SFX, and exit

:   LDA joy              ; otherwise, check new directional buttons
    AND #$0F
    BEQ @Exit            ; if none pressed, exit
    CMP tmp+7            ; if they match the old buttons (no new buttons pressed)
    BEQ @Exit            ;   exit
    JMP PlaySFX_MenuMove ; .. otherwise, play the Move sound effect
  @Exit:
    RTS

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  PtyGen_DrawBoxes  [$9E90 :: 0x39EA0]
;;
;;    Draws the 4 boxes for the Party Generation screen
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

PtyGen_DrawBoxes:
    LDA #0
    STA tmp+15       ; reset loop counter to zero

  @Loop:
      JSR @Box       ; then loop 4 times, each time, drawing the next
      LDA tmp+15     ; character's box
      CLC
      ADC #$13       ; incrementing by $13 each time (indexes ptygen buffer)
      STA tmp+15
      CMP #$40      ;; JIGS - this might should be $4C but I guess it doesn't matter
      BCC @Loop
    RTS

 @Box:
    LDX tmp+15           ; get ptygen index in X

    LDA ptygen_box_x, X  ; get X,Y coords from ptygen buffer
    STA box_x
    LDA ptygen_box_y, X
    STA box_y

    LDA #11              ; fixed width/height of 10
    STA box_wd
    STA box_ht

    LDA #0
    STA menustall        ; disable menustalling (PPU is off)
    JMP DrawBox          ;  draw the box, and exit


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  PtyGen_DrawText  [$9EBC :: 0x39ECC]
;;
;;    Draws the text for all 4 character boxes in the Party Generation screen.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

PtyGen_DrawText:
    LDA #0             ; start loop counter at zero
  @MainLoop:
     PHA                ; push loop counter to back it up
     JSR @DrawOne       ; draw one character's strings
     PLA                ;  pull loop counter
     CLC                ; and increase it to point to next character's data
     ADC #$13
     CMP #$4C
     
     BCC @MainLoop      ;  loop until all 4 chars drawn
    RTS

  @DrawOne:
    TAX                 ; put the ptygen index in X for upcoming routine

      ; no JMP or RTS -- code flows seamlessly into PtyGen_DrawOneText

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  PtyGen_DrawOneText  [$9ECC :: 0x39EDC]
;;
;;    This draws text for *one* of the character boxes in the Party Generation
;;  screen.  This is called by the above routine to draw all 4 of them at once,
;;  but is also called to redraw an individual class name when the player changes
;;  the class of the selected character.
;;
;;    The text drawn here is just two short strings.  First is the name of the
;;  selected class (Fighter/Thief/etc).  Second is the character's name.
;;
;;    Text is drawn by simply copying short strings to the format buffer, then
;;  calling DrawComplexString to draw them.  The character's name is simply
;;  the 4 letters copied over.. whereas the class name makes use of one
;;  of DrawComplexString's control codes.  See that routine for further details.
;;
;;  IN:  X = ptygen index of the char whose text we want to draw
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

PtyGen_DrawOneText:
    LDA ptygen_class_x, X   ; get X,Y coords where we're going to place
    STA dest_x              ;  the class name
    LDA ptygen_class_y, X
    STA dest_y

    LDA ptygen_class, X     ; get the selected class
    CMP #01                 ; this silly thing just centers the THIEF text...
    BEQ :+
    CMP #07                 ; and the NINJA if its ever set to print here
    BNE :++
    
  : INC dest_x
        
  : CLC
    ADC #$F0                ; add $F0 to select the class' "item name"
    STA format_buf-1        ;  store that as 2nd byte in format string
    LDA #$FF
    STA format_buf-3
    LDA #$02                ; first byte in string is $02 -- the control code to
    STA format_buf-2        ;  print an item name

    LDA #<(format_buf-3)    ; set the text pointer to point to the start of the 2-byte
    STA text_ptr            ;  string we just constructed
    LDA #>(format_buf-3)
    STA text_ptr+1

    LDA #BANK_THIS          ; set cur and ret banks (see DrawComplexString for why)
    STA cur_bank
    STA ret_bank

    TXA                     ; back up our index (DrawComplexString will corrupt it)
    PHA
    JSR DrawComplexString   ; draw the string
    PLA
    TAX                     ; and restore our index
 
    LDA ptygen_name, X      
    STA format_buf-7        
    LDA ptygen_name+1, X
    STA format_buf-6
    LDA ptygen_name+2, X
    STA format_buf-5
    LDA ptygen_name+3, X
    STA format_buf-4
    LDA ptygen_name+4, X
    STA format_buf-3
    LDA ptygen_name+5, X
    STA format_buf-2
    LDA ptygen_name+6, X
    STA format_buf-1
 
    LDA ptygen_name_x, X    ; set destination coords appropriately
    STA dest_x
    LDA ptygen_name_y, X
    STA dest_y
    
    ;; JIGS - for longer names
    
    LDA #<(format_buf-7)    ; set pointer to start of 4-byte string
    STA text_ptr
    LDA #>(format_buf-7)
    STA text_ptr+1

    LDA #BANK_THIS          ; set banks again (not necessary as they haven't changed from above
    STA cur_bank            ;   but oh well)
    STA ret_bank

    JMP DrawComplexString   ; then draw another complex string -- and exit!


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  PtyGen_DrawCursor  [$9F26 :: 0x39F36]
;;
;;    Draws the cursor for the Party Generation screen
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

PtyGen_DrawCursor:
    LDX char_index          ; use the current index to get the cursor
    LDA ptygen_curs_x, X    ;  coords from the ptygen buffer.
    STA spr_x
    LDA ptygen_curs_y, X
    STA spr_y
    JMP DrawCursor          ; and draw the cursor there



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  CharName_DrawCursor  [$9F35 :: 0x39F45]
;;
;;    Draws the cursor for the Character Naming screen
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

CharName_DrawCursor:
    LDA namecurs_x      ; X position = (cursx * 16) + $20
    ASL A
    ASL A
    ASL A
    ASL A
    CLC
    ADC #$20
    STA spr_x
    
    LDA namecurs_y      ; Y position = (cursy * 16) + $50
    ASL A
    ASL A
    ASL A
    ASL A
    CLC
    ADC #$50
    STA spr_y
    
    JMP DrawCursor


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  PtyGen_DrawChars  [$9F4E :: 0x39F5E]
;;
;;    Draws the sprites for all 4 characters on the party gen screen.
;;  This routine uses DrawSimple2x3Sprite to draw the sprites.
;;  See that routine for details.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

PtyGen_DrawChars:
    LDX #$00         ; Simply call @DrawOne four times, each time
    JSR @DrawOne     ;  having the index of the char to draw in X
    LDX #$13
    ;; JIGS ^ again, increase by 3 for every character
    JSR @DrawOne
    LDX #$26
    JSR @DrawOne
    LDX #$39
    

  @DrawOne:
    LDA ptygen_spr_x, X   ; load desired X,Y coords for the sprite
    STA spr_x
    LDA ptygen_spr_y, X
    STA spr_y

    ;LDA ptygen_class, X   ; get the class
    LDA ptygen_sprite, X   ; JIGS - get the SPRITE
    TAX
    LDA lutClassBatSprPalette, X   ; get the palette that class uses
    STA tmp+1             ; write the palette to tmp+1  (used by DrawSimple2x3Sprite)

    TXA               ; multiply the class index by $20
    ASL A             ;  this gets the tiles in the pattern tables which have this
    ASL A             ;  sprite's CHR ($20 tiles is 2 rows, there are 2 rows of tiles
    ASL A             ;  per class)
    ASL A
    ;ASL A
    ;; JIGS ^ one too many? Not sure, this might be a 12 classes fix thing.
    STA tmp           ; store it in tmp for DrawSimple2x3Sprite
    JMP DrawSimple2x3Sprite



;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  NameInput_DrawName  [$9F7D :: 0x39F8D]
;;
;;    Used during party generation.. specifically the name input screen
;;  to draw the character's name at the top of the screen.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;

NameInput_DrawName:
            @buf  = $59 ; $5C     ; local - buffer to hold the name for printing
            ;; JIGS ^ move the buffer further in, but its okay! Not overwriting anything. I think.
            
    LDX char_index          ; copy the character's name to our temp @buf
    LDA ptygen_name, X
    STA @buf
    LDA ptygen_name+1, X
    STA @buf+1
    LDA ptygen_name+2, X
    STA @buf+2
    LDA ptygen_name+3, X
    STA @buf+3              ; The code assumes @buf+4 is 0
    ;; JIGS - adding more letters ^ this is still correct, but 7 instead of 4
    LDA ptygen_name+4, X
    STA @buf+4          
    LDA ptygen_name+5, X
    STA @buf+5           
    LDA ptygen_name+6, X
    STA @buf+6              
    
    LDA #>@buf              ; Set the text pointer
    STA text_ptr+1
    LDA #<@buf
    STA text_ptr
    
    LDA #BANK_THIS          ; set cur/ret banks
    STA cur_bank
    STA ret_bank

    LDA #$0C                ; set X/Y positions for the name to be printed
    STA dest_x
    LDA #$04
    STA dest_y
    
    LDA #$01                ; drawing while PPU is on, so set menustall
    STA menustall
    
    JMP DrawComplexString   ; Then draw the name and exit!
    
;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  DrawNameInputScreen  [$9FB0 :: 0x39FC0]
;;
;;  Draws everything except for the player's name.
;;
;;  Assumes PPU is off upon entry
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;

DrawNameInputScreen:
    LDA $2002               ; clear PPU toggle
    
;    LDA #>$23C0             ; set PPU addr to the attribute table
;    STA $2006
;    LDA #<$23C0
;    STA $2006
    
;    LDA #$00                ; set $10 bytes of the attribute table to use palette 0
;    LDX #$10                ;  $10 bytes = 8 rows of tiles (32 pixels)
;    : STA $2007             ; This makes the top box the orangish color instead of the normal blue
;      DEX
;      BNE :-

;; JIGS - not doing that anymore!

    LDA #0
    STA menustall           ; no menustall (PPU is off at this point)
    
    LDA #$04                ; Draw the big box containing input
    STA box_x
    LDA #$08
    STA box_y
    LDA #$17
    STA box_wd
    LDA #$14
    STA box_ht
    JSR DrawBox

    LDA #$0A               ; Draw the small top box containing the player's name
    STA box_x
    LDA #$02
    STA box_y
    LDA #$0B ; 06
    STA box_wd
    LDA #$05 ; 04
    STA box_ht
    JSR DrawBox
    
    LDA #<lut_NameInput     ; Print the NameInput lut as a string.  This will fill
    STA text_ptr            ;  the bottom box with the characters the user can select.
    LDA #>lut_NameInput
    STA text_ptr+1
    LDA #$06
    STA dest_x
    LDA #$0A
    STA dest_y
    LDA #BANK_THIS
    STA cur_bank
    STA ret_bank
    JMP DrawComplexString
    
    
;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Name Input Row Start lut  [$A00A :: 0x3A01A]
;;
;;    offset (in usable characters) to start of each row in the below lut_NameInput

lut_NameInputRowStart:
  .BYTE  0, 10, 20, 30, 40, 50, 60  ; 10 characters of data per row
                                    ;  (which is actually 20 bytes, because they have spaces between them)
  
;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Name Input lut  [$A011 :: 0x3A021]
;;
;;    This lut is not only used to get the character the user selection on the name input screen,
;;  but it also is stored in null-terminated string form so that the entire thing can be drawn with
;;  with a single call to DrawComplexString.  It's intersperced with $FF (spaces) and $01 (double line breaks)

lut_NameInput:
  .BYTE $8A, $FF, $8B, $FF, $8C, $FF, $8D, $FF, $8E, $FF, $8F, $FF, $90, $FF, $91, $FF, $92, $FF, $93, $01  ; A - J
  .BYTE $94, $FF, $95, $FF, $96, $FF, $97, $FF, $98, $FF, $99, $FF, $9A, $FF, $9B, $FF, $9C, $FF, $9D, $01  ; K - T
  .BYTE $9E, $FF, $9F, $FF, $A0, $FF, $A1, $FF, $A2, $FF, $A3, $FF, $BE, $FF, $BF, $FF, $C0, $FF, $FF, $01  ; U - Z ; , . <space>
  .BYTE $80, $FF, $81, $FF, $82, $FF, $83, $FF, $84, $FF, $85, $FF, $86, $FF, $87, $FF, $88, $FF, $89, $01  ; 0 - 9
  .BYTE $A4, $FF, $A5, $FF, $A6, $FF, $A7, $FF, $A8, $FF, $A9, $FF, $AA, $FF, $AB, $FF, $AC, $FF, $AD, $01  ; a - j
  .BYTE $AE, $FF, $AF, $FF, $B0, $FF, $B1, $FF, $B2, $FF, $B3, $FF, $B4, $FF, $B5, $FF, $B6, $FF, $B7, $01  ; k - t
  .BYTE $B8, $FF, $B9, $FF, $BA, $FF, $BB, $FF, $BC, $FF, $BD, $FF, $C2, $FF, $C3, $FF, $C4, $FF, $C5, $01  ; u - z - .. ! ?
  ;.BYTE $01
  ;.BYTE $FF, $FF, $FF, $9C, $8E, $95, $8E, $8C, $9D, $FF, $FF, $97, $8A, $96, $8E, $00                      ;   SELECT  NAME
  
  ;; JIGS - I think this looks nicer:
  
  .BYTE $05
  .BYTE $97,$8A,$96,$8E,$C1,$A2,$98,$9E,$9B,$C1,$8C,$91,$8A,$9B,$8A,$8C,$9D,$8E,$9B,$00 

;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  LUT for party generation  [$A0AE :: 0x3A0BE]
;;
;;    This LUT is copied to the RAM buffer 'ptygen' which is used to
;;  track which class is selected for each character, what their name is,
;;  where they're to be drawn, etc.  This can be changed to assign a default
;;  party or default names, and to rearrange some of the graphics for the
;;  Party Generation Screen
;;
;;    See details of 'ptygen' buffer in RAM for a full understanding of
;;  the format of this table.

lut_PtyGenBuf:
;  .BYTE $00,$00,$FF,$FF,$FF,$FF,$07,$0C,$05,$06,$40,$40,$04,$04,$30,$40
;  .BYTE $01,$00,$FF,$FF,$FF,$FF,$15,$0C,$13,$06,$B0,$40,$12,$04,$A0,$40
;  .BYTE $02,$00,$FF,$FF,$FF,$FF,$07,$18,$05,$12,$40,$A0,$04,$10,$30,$A0
;  .BYTE $03,$00,$FF,$FF,$FF,$FF,$15,$18,$13,$12,$B0,$A0,$12,$10,$A0,$A0
  ;      1   2   3   4   5   6   7   8   9   10  11  12  13  14  15  16  17  18  19
  .BYTE $00,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$06,$0C,$05,$06,$48,$40,$04,$04,$33,$44,$00
  .BYTE $01,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$13,$0C,$12,$06,$B0,$40,$11,$04,$9C,$44,$01
  .BYTE $02,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$06,$18,$05,$12,$48,$A0,$04,$10,$33,$A4,$02
  .BYTE $03,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$13,$18,$12,$12,$B0,$A0,$11,$10,$9C,$A4,$03

  ;; JIGS ^ adding more bytes for names, and one for sprite instead of class.... ^
; ptygen_class   = 1
; ptygen_name    = 2, 3, 4, 5, 6, 7, 8
; ptygen_name_x  = 9
; ptygen_name_y  = 10
; ptygen_class_x = 11
; ptygen_class_y = 12
; ptygen_spr_x   = 13
; ptygen_spr_y   = 14
; ptygen_box_x   = 15
; ptygen_box_y   = 16 
; ptygen_curs_x  = 17
; ptygen_curs_y  = 18
; ptygen_sprite  = 19


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  IntroTitlePrepare  [$A219 :: 0x3A229]
;;
;;    Does various preparation things for the intro story and title screen.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

IntroTitlePrepare:
    LDA #$08               ; set soft2000 so that sprites use right pattern
    STA soft2000           ;   table while BG uses left
    LDA #0
    STA $2001              ; turn off the PPU;

    JSR LoadMenuCHRPal     ; Load necessary CHR and palettes
    
    JMP LoadBridgeSceneGFX_Menu ;; JIGS - ignore below. 
    ;JMP LoadMenuCHRPal ; -- JIGS: LoadMenuCHRPal eventually comes around to swapping back to Bank E and RTSing out... so it has to start in Bank E.
        ;          The rest can safely be moved to Bank 10!

  ;;  LDA #$41
  ;;  STA music_track        ; Start up the crystal theme music
  ;;; JIGS - stop resetting the damn song!

;    LDA #0
;    STA joy_a              ; clear A, B, Start button catchers
;    STA joy_b
;    STA joy_start
;    STA cursor
;    STA joy_prevdir        ; as well as resetting the cursor and previous joy direction

;    JMP ClearNT            ; then wipe the nametable clean and exit



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Shop entry jump table [$A320 :: 0x3A330]
;;
;;    The jump table indicating entry points for various shop
;;  types.

lut_ShopEntryJump:
  .WORD EnterShop_Equip      ; weapon
  .WORD EnterShop_Equip      ; armor
  .WORD EnterShop_Magic      ; white magic
  .WORD EnterShop_Magic      ; black magic
  .WORD EnterShop_Clinic     ; clinic
  .WORD EnterShop_Inn        ; inn
  .WORD EnterShop_Item       ; item
  .WORD EnterShop_Caravan    ; caravan

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Enter Shop [$A330 :: 0x3A340]
;;
;;  IN:  shop_id
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

EnterShop:
    LDA #0
    STA $2001              ; turn off PPU
    STA $4015              ; silence audio
    STA $5015              ; and silence the MMC5 APU. (JIGS)
    STA joy_b              ; erase joypad A and B buttons
    STA joy_a
    STA item_box_offset
    STA inv_canequipinshop

EnterShopFromMenu:    
    JSR LoadShopCHRPal     ; load up the CHR and palettes (and the shop type)
    JSR DrawShop           ; draw the shop

    LDA shop_type              ; use the shop type to get the entry point for this shop
    ASL A                      ; double it (2 bytes per pointer)
    TAX                        ; put in X
    LDA lut_ShopEntryJump, X   ; load up the entry point from our jump table
    STA tmp
    LDA lut_ShopEntryJump+1, X
    STA tmp+1

;    LDA #$4F
;    STA music_track        ; set the music track to $4F (shop music)

;    JMP (tmp)              ; jump to shop's entry point

  ;; JIGS - different music depending on shop type! 
  ; 0 weapon
  ; 1 armor
  ; 2 wmagic
  ; 3 bmagic
  ; 4 clinic
  ; 5 inn
  ; 6 item
  ; 7 caravan
  ;; just disable this code, and re-enable the last 3 lines above to return to normal!
    
    LDA dlgmusic_backup    ; JIGS - if the shop music is already playing, skip starting the song
    CMP #$48
    BEQ @DoShopJump
    CMP #$51
    BEQ @DoShopJump
    CMP #$4F
    BEQ @DoShopJump
    
    LDA shop_type
    CMP #4
    BNE :+
    LDA #$48               ; for clinic (castle music, closest thing to a nice temple song!)
    STA music_track
    STA dlgmusic_backup
  @DoShopJump:
    JMP (tmp)
  : CMP #5    
    BNE :+
    LDA #$51               ; for inn (the original menu music)
    STA music_track
    STA dlgmusic_backup    ; to replay inn music after saving
    JMP (tmp)
  : LDA #$4F
    STA music_track        ; set the music track to $4F (shop music)
    STA dlgmusic_backup
    JMP (tmp)              ; jump to shop's entry point
   

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Enter Magic Shop  [$A357 :: 0x3A367]
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

  MagicShop_Exit:
    RTS

  MagicShop_CancelPurchase:
    LDA #$25
    JSR DrawShopDialogueBox      ; "too bad... something else?" dialogue
    JMP MagicShop_Loop           ; jump ahead to loop


EnterShop_Magic:
    LDA #$17
    JSR DrawShopDialogueBox      ; "Who will learn the spell" dialogue

  MagicShop_Loop:
    JSR ShopLoop_CharNames       ; Have the player select a party member
    BCS MagicShop_Exit           ; if they pressed B, exit the shop

    LDA cursor                   ; otherwise, get their selection
   ; ROR A
   ; ROR A
   ; ROR A
   ; AND #$C0                     ; shift and mask to get the char index
   ; STA shop_charindex           ; record it
    
    ;; JIGS - don't need that, do need this
    JSR Magic_ConvertBitsToBytes
    LDA #0
    STA shop_curprice+2  ;; JIGS - make sure this is 0  
    ;;

    JSR ShopSelectBuyMagic       ; now have them select the spell to buy from the
                                 ;   shop inventory
    BCS MagicShop_Loop           ; if they press B, restart the loop

    LDX cursor                   ; otherwise get the cursor in X
    LDA item_box, X              ; use it to get the item ID they selected
    STA shop_curitem             ; record that as the current item

    JSR MagicShop_AssertLearn    ; assert that the selected character can learn
                                 ;  this spell.

                                 ; code only reaches here if the character
                                 ; can learn the spell.  If they can't
                                 ; AssertLearn jumps back to the magic loop.
    JSR DrawShopBuyItemConfirm   ; Draw item price and confirmation dialogue
    JSR ShopLoop_YesNo           ; Give the player the yes/no option

    BCS MagicShop_CancelPurchase ; cancel purchase if they pressed B
    LDA cursor
    BNE MagicShop_CancelPurchase ; or if they selected "No"

    JSR Shop_CanAfford           ; check to make sure they can afford the purchase
    BCC @FinalizePurchase        ; if yes... finalize the purchase

      LDA #$10                   ; ... otherwise
      JSR DrawShopDialogueBox    ; "you can't afford it" dialogue
      JMP MagicShop_Loop         ; keep looping

  @FinalizePurchase:
    JSR ShopPayPrice             ; subtract the item price from party GP
    ;LDX shop_charindex           ; get the empty slot in X
    ;LDA shop_spell               ; get the adjusted spell ID
    ;STA ch_spells, X             ; add this spell to char's magic list
    
    
    ;; JIGS - now cram that byte into a single bit!
    
    LDA shop_spell ; the spell ID
    AND #$0F       ; chop off the high bits, so that the LUT only needs to be 16 bytes long
    TAX
    LDA ConvertSpellByteToBit_LUT, X ; $2A is the same as $0A
    STA tmp

    ;; Spell Level + Character Index + Start of spell list
    
    LDA GetSpellLevelIndex
    CLC
    ADC CharacterIndexBackup
    ;ADC #ch_spells - ch_stats
    TAX
    LDA ch_spells, X
    ORA tmp
    STA ch_spells, X
    JMP EnterShop_Magic
   
   
    ConvertSpellByteToBit_LUT:
    .byte %10000000 ; Cure, Lamp, Cure 2, Pure, Cure 3, Soft, Cure 4, Life 2
    .byte %01000000
    .byte %00100000
    .byte %00010000 
    .byte %00001000 ; Fire, Ice, Fire 2, Sleep 2, Fire 3, Lit 3, Ice 3, Nuke
    .byte %00000100
    .byte %00000010
    .byte %00000001 
    ;; or:   
    .byte $80,$40,$20,$10,$08,$04,$02,$01
    ;; this is 16 bytes long, because the high bits of the spell ID are unnecessary.
    ;; otherwise it needs to be 64 bytes long, one for each spell, even if every 8 bytes is the same.

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Enter Equip Shop  [$A3AC :: 0x3A3BC]
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

  EquipShop_Cancel:
    LDA #$25
    JSR DrawShopDialogueBox     ; "Too bad... something else?" dialogue
    JMP EquipShop_Loop          ; jump ahead to loop


EnterShop_Equip:
    LDA #$09
    JSR DrawShopDialogueBox     ; "Welcome" dialogue

  EquipShop_Loop:
    LDA inv_canequipinshop        ; if this is set, characters will dance if they can equip the item the cursor is pointing at
    BEQ :+                        ; so it has to be turned off unless the cursor is pointing at weapons or armor
    JSR Shop_CharacterStopDancing ;
    
  : LDA #0
    STA shop_curprice+2         ; JIGS - make sure these are set to 0
    STA BlankItem       
    STA SellingEquipment 
    
    JSR ShopLoop_BuySellExit    ; give player Buy/Sell/Exit option
    BCS @Exit                   ; if they pressed B, exit
    LDA cursor
    BEQ @Buy                    ; cursor=0  means they selected "Buy"
    CMP #$01
    BEQ @Sell                   ; cursor=1  is "Sell"
    
  @Exit:                        ; otherwise, "Exit"
    RTS

  ;; Buying

  @Buy:
    JSR LoadShopInventory       ; load shop inventory.  Needs to be done here
                                ;  because item box can be filled with a character's
                                ;  equipment instead of shop inventory.

    LDA #$0D
    JSR DrawShopDialogueBox     ; "what would you like" dialogue

    LDA #01
    STA inv_canequipinshop ; turn on the ability to dance to equipable items!
    JSR ShopSelectBuyItem       ; have the player select something
    BCS EquipShop_Loop          ; if they pressed B, return to loop
    
    JSR Shop_CharacterStopDancing ; JIGS - turn off the cheer pose
    JSR DrawShopBuyItemConfirm  ; otherwise.. draw price confirmation text
    JSR ShopLoop_YesNo          ; and have them confirm it
    BCS EquipShop_Cancel        ; if they press B, cancel purchase
    LDA cursor
    BNE EquipShop_Cancel        ; if they select "No", cancel purchase

    JSR Shop_CanAfford          ; check to see if they can afford it
    BCC @CanAfford              ; if they can, jump ahead... otherwise...

      LDA #$10
      JSR DrawShopDialogueBox   ; "You can't afford it" dialogue
      JSR ClearShopkeeperTextBox
      JMP EquipShop_Loop        ; keep looping

  @CanAfford:
    LDA #$27                    ; "Do you want to equip it now?"
    JSR DrawShopDialogueBox       
    JSR ShopLoop_YesNo
    BCS @PutInInventory
    LDA cursor
    BEQ @EquipOnCharacter
        
       @PutInInventory: 
       JSR EquipShop_StoreInInventory
       BCC @FinalizePurchase        ; if they had room, finalize the purchase

        LDA #$0C                   ; otherwise (no room)
        JSR DrawShopDialogueBox    ; "You don't have room" dialogue
        JSR ClearShopkeeperTextBox
        JMP EquipShop_Loop         ; jump back to loop
  
  @EquipOnCharacter:
    LDA #$11             
    JSR DrawShopDialogueBox      ; "who will you give it to" dialogue"
    JSR ShopLoop_CharNames       ; have the player select a character
    BCS EquipShop_Loop           ; if they press B, jump back to loop

    JSR EquipShop_GiveItemToChar ; give the item to the character
    BCC @FinalizePurchase        ; if they had room, finalize the purchase

      LDA #$0C                   ; otherwise (no room)
      JSR DrawShopDialogueBox    ; "You don't have room" dialogue
      JSR ClearShopkeeperTextBox
      JMP EquipShop_Loop         ; jump back to loop

  @FinalizePurchase:
    JSR ShopPayPrice             ; subtract the GP
    LDA #$13
    JSR DrawShopDialogueBox      ; "Thank you, what else?" dialogue
    JMP EquipShop_Loop           ; jump back to loop

  ;; Selling

  @_Loop:   JMP EquipShop_Loop   ; these two are here so that these labels
  @_Cancel: JMP EquipShop_Cancel ;  can be branched to.  The main labels
                                 ;  might be too far for a branch (can only branch
                                 ;  back 128 bytes).  I'm not sure that's
                                 ;  necessary though.... don't think the routine
                                 ;  is that big

  @Sell:
    LDA #01
    STA SellingEquipment         ; toggle so moving the cursor around past the max will shift the list
    ;LDA #$14
    ;JSR DrawShopDialogueBox      ; "Whose item do you want to sell" dialogue
    ;JSR ShopLoop_CharNames       ; have the player select a character
    ;BCS @_Loop                   ; if they pressed B, jump back to loop

    JSR EquipMenu_BuildSellBox   ; fill the item box with this character's equipment
    BCS @ItemsForSale            ; if there are items for sale... proceed.  otherwise....

      LDA #$1E
      JSR DrawShopDialogueBox    ; "you have nothing to sell" dialogue
      JMP EquipShop_Loop         ; jump back to loop

  @ItemsForSale:
    LDA #01
    STA inv_canequipinshop ; turn on the ability to dance to equipable items!
    JSR ShopSelectBuyItem        ; have the user select an item to sell
    BCS @_Loop                   ; if they pressed B, jump back to the loop
    
    LDA cursor
    STA ItemToEquip
    
    DEC SellingEquipment
    JSR DrawShopSellItemConfirm  ; draw the sell confirmation dialogue
    JSR ShopLoop_YesNo           ; give them the yes/no option
    BCS @_Cancel                 ; if they pressed B, canecl
    LDA cursor
    BNE @_Cancel                 ; if they selected "No", cancel

    LDA ItemToEquip
    CLC
    ADC item_box_offset
    TAX
    LDA #0
    STA item_box, X

    JSR EquipMenu_RebuildInventory ; and re-sort inventory based on what's in the item box now
    
    LDA shop_curprice      ; copy 3 bytes of sale price to tmp
    STA tmp
    LDA shop_curprice+1
    STA tmp+1
    LDA #0
    STA tmp+2
    LDA shop_curprice+2

    JSR AddGPToParty       ; give that money to the party
    JSR DrawShopGoldBox    ; redraw the gold box to reflect changes
    JMP EquipShop_Loop     ; and jump back to loop

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Enter Item Shop   [$A471 :: 0x3A481]
;;
;;    Enter Caravan shop is also here.  Caravan operates exactly
;;  like an item shop -- only with different graphics.  But since the
;;  shop has been drawn already by the time code reaches this routine,
;;  the game can treat them as if they're the same.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

  ItemShop_Exit:
    LDA #0
    STA InItemShop                   ;; JIGS - note that we're leaving the item shop
    RTS

  ItemShop_CancelBuy:           ; jumped to for cancelled purchases
    LDA #$25
    JSR DrawShopDialogueBox     ; "too bad, something else?" dialogue
    JMP ItemShop_Loop           ; return to loop

EnterShop_Caravan:

EnterShop_Item:
    LDA #$09
    JSR DrawShopDialogueBox     ; draw the "welcome" dialogue

  ItemShop_Loop:
    JSR ShopLoop_BuyExit        ; give them the option to buy or exit
    BCS ItemShop_Exit           ; if they pressed B, exit
    LDA cursor
    BNE ItemShop_Exit           ; otherwise if they selected 'exit', then exit

    LDA #$0D
    JSR DrawShopDialogueBox     ; "what would you like" dialogue
    JSR ShopSelectBuyItem       ; let them choose an item from the shop inventory
    BCS ItemShop_Loop           ; if they pressed B, restart the loop

    ;; JIGS - adding option to buy more than one...
    JSR BuyLots
    BCS ItemShop_CancelBuy
  
    @Shop_HaveMoney:
    JSR Shop_CanAfford          ; check to ensure they can afford this item
    BCC @Confirm                ; if they can, jump ahead to complete the purchase.
      LDA #$10
      JSR DrawShopDialogueBox   ; if they can't, "you can't afford it" dialogue
      JMP ItemShop_Loop         ; and return to loop
  
    @Confirm: 
    JSR DrawShopBuyItemConfirm  ; confirm price dialogue
    JSR ShopLoop_YesNo          ; give them the yes/no option
    BCS ItemShop_CancelBuy      ; if they pressed B, cancel the purchase
    LDA cursor
    BNE ItemShop_CancelBuy      ; if they selected "No", cancel the purchase
  
  
  @CompletePurchase:    
    LDA MMC5_tmp
    LDX shop_curitem
    STA items, X
    JSR ShopPayPrice            ; subtract the price from your gold amount
    LDA #$13
    JSR DrawShopDialogueBox     ; "Thank you, anything else?" dialogue
    JMP ItemShop_Loop           ; and continue loop
    
    
    BuyLots:
    LDA cursor            ; get current item selected
    LDX #09               ; multiply by 9
    JSR MultiplyXA
    TAX                   ; put in X for indexing
    LDA str_buf+$48, X    ; point to string buffer+17, which is where the first item's ID is; next ID is in 9 bytes
    STA MMC5_tmp+3
    TAX
    STA shop_curitem
        
      LDA items, X
      STA MMC5_tmp+2      ; ammount we have
      CMP #99
      BCC :+
         LDA #$0C
         JSR DrawShopDialogueBox   ; "you have too many" dialogue
         JMP ItemShop_Loop         ; return to loop
    
    : LDA #100         ; then kinda reverse it
      SEC
      SBC MMC5_tmp+2  ; subtract the amount we already have from 1 over the limit
      STA MMC5_tmp+1  ; how many items we can buy
      LDA #1
      STA MMC5_tmp     ; start with 1
      STA InItemShop        ; and note that we're in an item shop goin' real fast
                 
    LDA #$26      ; "How many?" ; this makes the caravan guy really evil... how many bottled faeries does he HAVE?!
    JSR DrawShopDialogueBox
    JSR BuyLotsQuantity ; and load the price up for viewing
    JSR BuyLotsAmountLoop ; do the whole loop thing to pick how many new items to buy...    
    BCC @End              ; if B is pressed, 
    PLA
    PLA
    JMP ItemShop_CancelBuy     ; return to loop
    @End:
    RTS
    
   BuyLotsAmountLoop:
    LDA joy              ; get the joy data
    AND #$0C             ; isolate up/down bits
    STA joy_prevdir      ; and store in prev_dir
                         ; then begin the loop...

  @Loop:
    JSR ShopFrame        ; now that cursor position has been recorded... do a frame

    LDA joy_b
    BNE @B_Pressed       ; check to see if A or B have been pressed
    LDA joy_a
    BNE @A_Pressed

                         ; if neither pressed.. see if the cursor has been moved
    LDA joy              ; get joy
    AND #$0F             ; isolate up/down and left/right buttons
    CMP joy_prevdir      ; compare to previous buttons to see if button state has changed
    BEQ @Loop            ; if no change.. do nothing, and continue loop

    STA joy_prevdir      ; otherwise, record changes

    CMP #0               ; then check to see if buttons have been pressed or not
    BEQ @Loop            ; if not.. do thing, and continue loop

    CMP #$01             ; if right was pressed
    BEQ @More
    
    CMP #$02             ; if left was pressed
    BEQ @Less
    
    CMP #$08             ; if up was pressed
    BEQ @More

   @Less:                ; otherwise, it was down
    DEC MMC5_tmp         ; 
    LDA MMC5_tmp
    CMP #0
    BNE @MoveDone        ; if it hasn't gone below 1, that's all -- continue loop
    
    LDA MMC5_tmp+1       ; otherwise (below 1), wrap to our item limit
    SEC
    SBC #$01             ; minus one
    JMP @MoveDone        ; desired cursor is in A, jump ahead to @MoveDone to write it back

   @More:
    LDA MMC5_tmp         ; if Up or Right pressed, increase amount 
    CLC
    ADC #$01             ; increment it by 1
    CMP MMC5_tmp+1       ; check to see if we've gone over the amount we can buy
    BCC @MoveDone        ; if not, jump ahead to @MoveDone
    LDA #1               ; if yes, wrap limit to 1

  @MoveDone:             ; code reaches here when A is to be the new amount to buy
    STA MMC5_tmp         ; 
    JSR BuyLotsQuantity  ; prints all the numbers
    JMP @Loop            ; and continue loop

  @B_Pressed:            ; if B pressed....
    SEC                  ; SEC to indicate player pressed B
                         ;  and proceed to @ButtonDone

  @ButtonDone:           ; reached when the player has pressed B or A (exit this shop loop)
    LDA #0
    STA joy_a            ; zero joy_a and joy_b so further buttons will be detected
    STA joy_b
    STA joy_select       ; and select... but why?  select isn't used in shops?
    RTS

  @A_Pressed:            ; if A pressed...
    CLC                  ; CLC to indicate player pressed A
    BCC @ButtonDone      ; and jump to @ButtonDone (always branches)
    
    
    
    BuyLotsQuantity:
    LDA MMC5_tmp
    STA tmp
    JSR PrintNumber_2Digit
    LDA format_buf-2        ; copy the printed 2 digit number from the format buffer
    STA str_buf+$06
    LDA format_buf-1
    STA str_buf+$07
    LDA #0
    STA str_buf+$08
    STA str_buf+$0F
    
    LDA #22
    STA dest_y
    LDA #03
    STA dest_x
    
    LDA #<(str_buf+$06)        ; set our text pointer to point to the generated string
    STA text_ptr
    LDA #>(str_buf+$07)
    STA text_ptr+1
    JSR DrawComplexString
    
    LDA shop_curitem
    JSR LoadPrice                ; gets the price of the item you're trying to buy
    JSR BuyLotsQuantityGetPrice     ; multiplies stuff
    
    LDA tmp
    STA shop_curprice
    LDA tmp+1
    STA shop_curprice+1
    LDA tmp+2
    STA shop_curprice+2
    LDA tmp+3
    STA shop_curprice+3
        
    JSR PrintNumber_6Digit
    
    LDA format_buf-6
    STA str_buf+$09
    LDA format_buf-5
    STA str_buf+$0A
    LDA format_buf-4
    STA str_buf+$0B
    LDA format_buf-3
    STA str_buf+$0C
    LDA format_buf-2
    STA str_buf+$0D
    LDA format_buf-1
    STA str_buf+$0E
    
    LDA #24
    STA dest_y
    LDA #06
    STA dest_x
    
    LDA #<(str_buf+$09)        ; set our text pointer to point to the generated string
    STA text_ptr
    LDA #>(str_buf+$09)
    STA text_ptr+1
    JMP DrawComplexString
    

 BuyLotsQuantityGetPrice:
    CLC
    LDA MMC5_tmp        ; quantity
    LDX tmp             ; low byte of price
    JSR MultiplyXA_Safe
    ;STA shop_curprice   ; low byte of combined price
    STA tmp
    STX MMC5_tmp+$10
    
    LDA MMC5_tmp        ; quantity
    LDX tmp+1           ; middle byte of price
    JSR MultiplyXA_Safe
    ADC MMC5_tmp+$10
    ;STA shop_curprice+1
    STA tmp+1
    STX MMC5_tmp+$10
    
    LDA MMC5_tmp        ; quantity
    LDX tmp+2           ; high byte of price
    JSR MultiplyXA_Safe
    ADC MMC5_tmp+$10
    ;STA shop_curprice+2
    STA tmp+2
        
    BCC :+
       INX
  : ;STX shop_curprice+3  
    STA tmp+3
    RTS

    
; SUPPORT ROUTINE -- code by Disch! 
; This routine may or may not be necessary depending on how MultiplyXA works.
;   The important bit here is that C needs to be
;   unchanged by the call.  The PHP/PLP here assure that.  If MultiplyXA preseves
;   C then this routine is not needed and MultiplyXA can be called directly

MultiplyXA_Safe:
    PHP
    JSR MultiplyXA
    PLP
    RTS
    
; The actual multiplication routine
;
;   Goal:  $AABBCC * $EE   (24 bit value * 8 bit value)
;   Visualization:
;
;       AA BB CC
; x           EE
; --------------
;          BD A8   (EE * CC = BDA8)
;       AD DA ..   (EE * BB = ADDA)     (dots are effectively zeros)
; +  9E 0C .. ..   (EE * AA = 9E0C)     (note that all addition must include carry)
; --------------
;    9E BA 97 A8   <-  End result, $AABBCC * $EE = $9EBA97A8

;Multiply_24x8:
;    @in_24  =   ; low byte of 24-bit value (assume +1 and +2 are med/high bytes)
;    @in_8   =   ; low byte of 8-bit value
;    @out_32 =   ; output (32-bit value)
;    @temp   =   ; some area of temp ram (only 1 byte needed for this code)
    
;    CLC                     ; start with C clear
    
    ; low byte (EE * CC)
;    LDA @in_8
;    LDX @in_24
;    JSR MultiplyXA_Safe
;    STA @out_32             ; no addition needed for low byte
;    STX @temp               ; addition needed for high byte, stuff it for later
    
    ; middle byte (EE * BB)
;    LDA @in_8
;    LDX @in_24+1
;    JSR MultiplyXA_Safe
;    ADC $temp               ; add with previous high byte
;    STA $out_32+1
;    STX $temp               ; for future addition
    
    ; high byte (EE * AA)
;    LDA @in_8
;    LDX @in_24+2
;    JSR MultiplyXA_Safe
;    ADC @temp
;    STA @out_32+2
    
    ; high byte currently in X.  It does not need full addition, but we do need to add to it
    ;  any carry from the previous addition
;    BCC :+
;       INX
;    :
;    STX @out_32+3
    
    ; Done!
;    RTS
    


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  ShopPayPrice  [$A4CD :: 0x3A4DD]
;;
;;    Subtracts the current shop price from the player's gold total
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

ShopPayPrice:
    ShopThief:         ; JIGS - HEEHEE
    LDX #0
    LDA ch_class, X    ; check if thief is party leader.
    AND #$0F           ; cut off high bits (sprite)
    CMP #$01           ; IF thief, goto ShopSteal
    BEQ @ShopSteal
    CMP #$07
    BNE @PayUp         ; otherwise, pay up
    
    @ShopSteal:
    LDA InItemShop           ; check if we're buying lots of things from an item shop
    BNE :+              ; if so, need to make an item quantity check
    
    LDA MMC5_tmp        ; how many items are being bought?
    CMP #03             ; only two hands so...
    BCS @PayUp          ; not getting away with it
    
  : TXA
    LDX #100           
    JSR RandAX
    CMP #91             ; Player needs to roll 91 or over to do their special thing?
    BCC @PayUp
        JSR PlayHealSFX ; and a little victory vwoop
        RTS
    
    @PayUp:
    LDA gold
    SEC
    SBC shop_curprice         ; subtract low byte
    STA gold

    LDA gold+1
    SBC shop_curprice+1       ; mid byte
    STA gold+1

    LDA gold+2
    SBC shop_curprice+2       ;; JIGS - hope this will work...
    ;SBC #0                    ; and get borrow from high byte
    STA gold+2

    JMP DrawShopGoldBox       ; then redraw the gold box to reflect changes, and return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Shop Can Afford [$A4EB :: 0x3A4FB]
;;
;;   Checks the current item price and sees if the player can afford it.
;;
;;  IN:  shop_curprice = price to check
;;
;;  OUT:             C = clear if they can afford, set if they can't
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


Shop_CanAfford:
   ; LDA gold+2           ; if high byte of gold is nonzero (> 65535 GP), they can afford it
   ; BNE @Yes
   
    LDA gold+2
    CMP shop_curprice+2 ; JIGS - new variable for the ridiculous amount of money we can spend in one go
    BEQ @CheckMiddle     ; if equal, need to check the middle byte
    BCC @No              ; if gold < price, can't afford
    BCS @Yes             ; otherwise... can afford
    
  @CheckMiddle:
    LDA gold+1           ; check mid byte of gold
    CMP shop_curprice+1  ;  against high byte of price
    BEQ @CheckLow        ; if equal, need to check the low byte
    BCC @No              ; if gold < price, can't afford
    BCS @Yes             ; otherwise... can afford

  @CheckLow:
    LDA gold             ; compare low byte of gold
    CMP shop_curprice    ;  with low byte of price
    BCS @Yes             ;  if >=, can afford
                         ;  otherwise... can't
  @No:
    SEC                  ; SEC to indicate can't afford
    RTS

  @Yes:
    CLC                  ; CLC to indicate can afford
    RTS


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Enter Shop Inn  [$A508 :: 0x3A518]
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

EnterShop_Inn:
    LDA #$1B
    JSR DrawShopDialogueBox     ; "Welcome.. would you like to stay?" dialogue

    JSR ShopLoop_YesNo          ; give them the yes/no option
    BCS @Exit                   ; if they pressed B, exit
    LDA cursor
    BNE @Exit                   ; also exit if they selected 'No'

    JSR DrawInnClinicConfirm    ; draw the price confirmation dialogue
    JSR ShopLoop_YesNo          ; give them another yes/no option
    BCS @Exit                   ; again... pressed B = exit
    LDA cursor
    BNE @Exit                   ; select No = exit

    JSR InnClinic_CanAfford     ; assert that they can afford the price, and charge them

   ; LDA #$30                    ; code only reaches here if the price could be afforded
   ; STA $4004                   ;   silence square 2
   ; LDA #$7F                    ;   and reset it's F-value to zero.
   ; STA $4005                   ;  Game seems to do this in a few places... still not sure why
   ; LDA #$00                    ;  probably prevents unwanted ugly sounds when switching tracks?
   ; STA $4006                   ;   but it only does it for some tracks?
   ; STA $4007
   ;; JIGS - I don't think this is needed since Square 2 is not being used for SFX anymore?
   

    JSR MenuFillPartyHP         ; refill the party's HP
    JSR MenuRecoverPartyMP      ;  and MP
    ;JSR SaveGame                ;  then save the game (this starts the "you saved your game" jingle)
    ;; JIGS - moving
    
    LDA #0
    STA joy_a                   ; clear A and B catchers
    STA joy_b

    LDA #$1C
    JSR DrawShopDialogueBox     ; "Don't forget when you leave your game" dialogue

    LDA #$03
    JSR LoadShopBoxDims         ; erase shop box 3 (command box)
    JSR EraseBox

   ; JSR ClearOAM                ; clear OAM (to remove the cursor)
   ; JSR DrawShopPartySprites    ; draw the party
   ; JSR WaitForVBlank_L         ; then wait for VBlank before
   ; LDA #>oam                   ;   performing sprite DMA
   ; STA $4014                   ; all of this is to remove the cursor graphic without doing a real frame
   ;; JIGS ^ why do that when you have this?
    JSR ShopFrameNoCursor 
    JSR FadeOutBatSprPalettes   ; and fade the party out
    
    JSR SaveGame                ; JIGS - now save... and!
    LDA #0
    STA $2001                   ; turn off PPU
    JSR LoadShopCHRPal          ; 
    @PaletteLoop:    
    JSR DimBatSprPalettes       ; dim the palettes to black so we can fade back in again; save screen reset it
    BCS @PaletteLoop            ; 
    JSR DrawShop                ; re-draw the shop!
    
  @LoopOne:
    JSR ShopFrameNoCursor       ; do a shop frame (with no visible cursor)

;; JIGS - all this is handled by the new save screen and routines
;    LDA music_track             ; check the music track
;    CMP #$81                    ; if $81 (no music currently playing)...
;    BNE :+
;      LDA #$51 ; 4F                  ; restart track $4F (shop music)
               ;; JIGS - menu music now!
;      STA music_track           ; this happens because music stops after the save jingle

;:   LDA joy_a                   ; check to see if either A or B have been pressed
;    ORA joy_b
;    BEQ @LoopOne                ; and keep looping until one of them has
    JSR FadeInBatSprPalettes    ; then fade the party back in



  @Exit:
    LDA #$03
    JSR LoadShopBoxDims         ; erase shop box 3 (the command box)
    JSR EraseBox                ; this is redundant if they stayed at the inn, but
                                ; if the code jumped here because the user wanted to
                                ; exit the inn, then this has meaning

    LDA #$1D
    JSR DrawShopDialogueBox     ; "Hold Reset when turning power off" dialogue

    LDA #0
    STA joy_a
    STA joy_b                   ; clear A and B catchers

  @LoopTwo:
    JSR ShopFrameNoCursor       ; do a frame

    LDA music_track             ; check to see if the music has silenced (will happen
    CMP #$81                    ;  after the save jingle ends)
    BNE :+
      LDA #$51 ; 4F                  ; restart track $4F (shop music)
               ;; JIGS - menu music now!
      STA music_track
:   LDA joy_a                   ; check to see if A or B have been pressed
    ORA joy_b
    BEQ @LoopTwo                ; and keep looping until one of them has

    RTS                         ; then exit


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Enter Shop Clinic  [$A5A1 :: 0x3A5B1]
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

ClinicShop_Exit:
    RTS


EnterShop_Clinic:
    LDA #0
    STA joy_a                  ; clear A and B button catchers
    STA joy_b

    JSR ClinicBuildNameString  ; build the name string (also tells us if anyone is dead)
    BCC @NobodysDead           ; if nobody is dead... skip ahead

    LDA #$20
    JSR DrawShopDialogueBox    ; "Who needs to come back to life" dialogue

    JSR Clinic_SelectTarget    ; Get a user selection
    LDA cursor                 ;   grab their selection
    STA shop_curitem           ;   and put it in cur_item to hold it for later
    BCS ClinicShop_Exit        ; If they pressed B, exit.

    JSR DrawInnClinicConfirm   ; Draw the cost confirmation dialogue
    JSR ShopLoop_YesNo         ; give them the yes/no option
    BCS EnterShop_Clinic       ; If they pressed B, restart loop
    LDA cursor
    BNE EnterShop_Clinic       ; if they selected "No", restart loop

    JSR InnClinic_CanAfford    ; otherwise, they selected "Yes".  Make sure they can afford the charge

    LDA shop_curitem           ; code only reaches here if they can afford it.
    CLC
    ADC shop_curitem           ; add their original selection to itself twice (ie:  *3)
    ADC shop_curitem
    TAX                        ; cursor*3 in X
    LDA str_buf+$10, X         ; use that to get the char ID from the previously compiled string
                               ;  (see ClinicBuildNameString for how this string is built and why this works)

    ROR A                      ; A is currently $10-$13
    ROR A                      ; convert this number into a usable char index ($00,$40,$80, or $C0)
    ROR A                      ;   by shifting it
    AND #$C0                   ; and masking out desired bits
    TAX                        ; put the char index in X.  This is the car we are to revive.

    LDA #$00
    STA ch_ailments, X         ; erase this character's ailments (curing his "death" ailment)
    STA joy_a
    STA joy_b                  ; clear A and B catchers
    LDA #$01
    STA ch_curhp, X            ; and give him 1 HP

    LDA #$21
    JSR DrawShopDialogueBox    ; "Warrior!  Return to life!"  dialogue

    LDA #$03
    JSR LoadShopBoxDims        ; erase shop box 3 (command box)
    JSR EraseBox

  @ReviveLoop:
    JSR ShopFrameNoCursor      ; do a frame
    LDA joy_a
    ORA joy_b
    BEQ @ReviveLoop            ; and loop (keep doing frames) until A or B pressed
    JMP EnterShop_Clinic       ; then restart the clinic loop

  @NobodysDead:
    LDA #$23
    JSR DrawShopDialogueBox    ; if nobody is dead... "You don't need my help" dialogue

    LDA #0
    STA joy_a
    STA joy_b                  ; clear A and B catchers

  @ExitLoop:
    JSR ShopFrameNoCursor      ; do a frame
    LDA joy_a
    ORA joy_b
    BEQ @ExitLoop              ; and loop (keep doing frames) until either A or B pressed

    RTS                        ; then exit


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  EquipShop_GiveItemToChar  [$A61D :: 0x3A62D]
;;
;;    Finds whether or not a character has room in his inventory
;;  for the given weapon/armor.  If he does, the item is placed in
;;  his inventory.
;;
;;  IN:     cursor = char ID (0-3) of target character
;;       shop_type = 0 for weapon shop, 1 for armor shop
;;    shop_curitem = item ID of the weapon/armor
;;
;;  OUT:         C = clear if character had room
;;                     set if he didn't
;;               * = item is placed in char's inventory if he has room
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

EquipShop_StoreInInventory:
    LDX shop_type
    BNE @Armor

    LDX #0
   @WeaponLoop:
    LDA inv_weapon, X
    BEQ @StoreWeapon
        INX
        CPX #$40
        BNE @WeaponLoop
    SEC                     ; if no empty slot, SEC to indicate so
    RTS                     ; and exit

   @StoreWeapon: 
    LDA shop_curitem 
    SEC
    SBC #$1C-1            ; subtract to convert to weapon IDs
    STA inv_weapon, X
    CLC
    RTS
    
 @Armor:
    LDX #0
   @ArmorLoop:
    LDA inv_armor, X
    BEQ @StoreArmor
        INX
        CPX #$40
        BNE @ArmorLoop
    SEC                     ; if no empty slot, SEC to indicate so
    RTS                     ; and exit

   @StoreArmor: 
    LDA shop_curitem 
    SEC
    SBC #$44-1            ; subtract to convert to weapon IDs
    STA inv_armor, X
    CLC
    RTS



EquipShop_GiveItemToChar:
    LDA cursor          ; get the char ID
    ROR A
    ROR A
    ROR A
    AND #$C0            ; shift and mask to get the char index
    STA CharacterIndexBackup

    LDX shop_type       ; see if this is weapon or armor, and
    BEQ @CheckWeapons   ;  fork appropriately
    
    JMP CheckArmor

  @CheckWeapons:
    LDA shop_curitem
    SEC
    SBC #$1C-1          ; 
    STA ItemToEquip
    JSR IsEquipLegal
    BCS CannotEquip
    
    JSR LongCall
    .word UnadjustEquipStats
    .byte $0F
  
    LDX CharacterIndexBackup
    LDA ch_righthand, X
    BEQ @EquipWeapon_NoSwap
    STA ItemToUnequip
    
    LDX #0
   @WeaponLoop:
    LDA inv_weapon, X
    BEQ @StoreWeapon
        INX
        CPX #$40
        BNE @WeaponLoop
    JSR ReEquipStats
    SEC                     ; if no empty slot, SEC to indicate so
    RTS                     ; and exit
    
   @StoreWeapon:
    LDA ItemToUnequip
    STA inv_weapon, X
   @EquipWeapon_NoSwap: 
    LDX CharacterIndexBackup
    LDA ItemToEquip
    STA ch_righthand, X
    JSR ReEquipStats
    CLC
    RTS
    
   CannotEquip:
    LDA #$28                   ;
    JSR DrawShopDialogueBox    ; "You can't equip that"
    JSR ClearShopkeeperTextBox
    JMP EquipShop_Loop         ; jump back to loop
    
   CheckArmor: 
    LDA shop_curitem
    SEC
    SBC #$44-1           
    STA ItemToEquip
    JSR IsEquipLegal
    BCS CannotEquip
    
    JSR LongCall
    .word UnadjustEquipStats
    .byte $0F
    
    LDA shop_curitem
    SEC
    SBC #$44             ; subtract to convert to armor ID - 1 (important! is #$44, not #44-1)
    TAX
    LDA lut_ArmorTypes, X ; check type LUT
    STA equipoffset   
    CLC
    ADC #ch_righthand - ch_stats
    ADC CharacterIndexBackup
    STA CharacterIndexBackup
    TAX                   
    LDA ch_stats, X 
    BEQ @EquipArmor_NoSwap
    STA ItemToUnequip
    
    LDX #0
   @ArmorLoop:
    LDA inv_armor, X
    BEQ @StoreArmor
        INX
        CPX #$40
        BNE @ArmorLoop
    JSR ReEquipStats
    SEC                     ; if no empty slot, SEC to indicate so
    RTS                     ; and exit
    
   @StoreArmor:
    LDA ItemToUnequip
    STA inv_armor, X
   @EquipArmor_NoSwap:
    LDX CharacterIndexBackup
    LDA ItemToEquip
    STA ch_stats, X
    JSR ReEquipStats
    CLC
    RTS
    


ReEquipStats:
JSR LongCall
.word ReadjustEquipStats
.byte $0F
RTS



Shop_CharacterStopDancing:
    DEC inv_canequipinshop
    LDA cursor
    PHA
    LDA shop_type
    BNE @Armor
    
    LDA #$6F
    JMP :+
    
    @Armor:
    LDA #$70
  : STA cursor
    JSR Shop_CharacterCanEquip
    PLA
    STA cursor
    RTS    

    ;; ^ this routine temporarily sets cursor to bytes in the string buffer
    ;;   which make it think its pointing to a 41st weapon or armor
    ;;   which has its permission bits all set so no one can equip it... 
    ;;   which causes everyone to return to normal pose!

Shop_CharacterCanEquip:
    LDA shop_type
    STA equipoffset
    BNE @Armor

   @Weapon:
    LDX cursor
    LDA item_box, X
    SEC
    SBC #$1C-1
    JMP :+

   @Armor:
    LDX cursor
    LDA item_box, X
    SEC
    SBC #$44-1
  : STA MMC5_tmp+3

    LDA #0
   @Loop:
    AND #$C0
    STA CharacterIndexBackup
    LDA MMC5_tmp+3
    JSR IsEquipLegal
    BCS @CannotEquip
    
    LDX CharacterIndexBackup
    LDA ch_ailments, X
    ORA #$80
    STA ch_ailments, X
    JMP @NextCharacter
    
    @CannotEquip:
    LDX CharacterIndexBackup
    LDA ch_ailments, X
    AND #$0F
    STA ch_ailments, X

   @NextCharacter:
    LDA CharacterIndexBackup
    CLC
    ADC #$40
    STA CharacterIndexBackup
    BNE @Loop
    RTS

    
    

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Inn / Clinic Can Afford [$A689 :: 0x3A699]
;;
;;    Checks the cost of the inn/clinic and sees if the player can afford it.
;;  if they can't afford it, this displays text telling them so, then EXITS
;;  the inn/clinic.
;;
;;    This routine will only return to the code that called it if the player
;;  can afford the price
;;
;;  IN:  item_box = price to check (inn/clinic prices are stored in the itembox)
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

InnClinic_CanAfford:
    LDA gold+2         ; if high byte of gold is nonzero (> 65535 GP), they can afford it
    BNE @CanAfford

    LDA gold+1
    CMP item_box+1     ; otherwise, compare mid byte of gold to high byte of cost
    BEQ @CheckLow      ; if equal... need to compare low bytes
    BCS @CanAfford     ; if greater... can afford
    BCC @CantAfford    ; if less... can't afford

  @CheckLow:
    LDA gold           ; compare low bytes
    CMP item_box
    BCS @CanAfford     ; if gold >= cost, can afford.  otherwise....

  @CantAfford:
    LDA #$10
    JSR DrawShopDialogueBox    ; draw "you can't afford it" dialogue

    LDA #0                     ; clear joy_a and joy_b markers
    STA joy_a
    STA joy_b
   @Loop:
      JSR ShopFrameNoCursor    ; then just keep looping frames
      LDA joy_a                ;  until either A or B pressed
      ORA joy_b
      BEQ @Loop

    PLA                ; then pull the previous return address, and exit
    PLA                ;  this is effectively a double-RTS.  Returning not
    RTS                ;  only from this routine, but the routine that called this routine
                       ;  IE:  this exits the shop.  Code does not return to the Inn/Clinic routine.

  @CanAfford:
    LDA gold           ; subtract the cost of the inn/clinic from the player's gold
    SEC
    SBC item_box
    STA gold
    LDA gold+1
    SBC item_box+1
    STA gold+1
    LDA gold+2
    SBC #0
    STA gold+2

    JMP DrawShopGoldBox  ; redraw the gold box to reflect changes, and exit



;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Clinic_SelectTarget  [$A6D7 :: 0x3A6E7]
;;
;;     Draws the command box, fills it with the names of all the dead
;;  characters, then waits for the user to select one of them.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;


Clinic_SelectTarget:
    LDA #$03
    JSR DrawShopBox            ; draw shop box #3 (command box)

   LDA #<(str_buf+$10)        ; set our text pointer to point to the generated string
   STA text_ptr
   LDA #>(str_buf+$10)
   STA text_ptr+1
   JSR DrawShopComplexString  ; and draw it
 
    JMP CommonShopLoop_Cmd     ; then do the shop loop to get the user's selection


;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Clinic Build Name String   [$A6ED :: 0x3A6FD]
;;
;;     Builds the string to fill the command box.  The string consists of names
;;  of characters in the party that are dead.  This tring is placed in str_buf+$10,
;;  because str_buf shares space with item_box, and item_box still contains the price
;;  of this clinic.
;;
;;     The string is only built here... it is not actually drawn.
;;
;;     In addition, cursor_max is filled to the proper number of options
;;  available (ie:  the number of dead guys in the party).
;;
;;  OUT:   cursor_max = number of dead guys
;;                  C = set if at least 1 dead guy, clear if no dead guys
;;
;;     The compiled string is 3 bytes per included character in format:
;;  "1X 00 01" where 'X' is 0-3 indicating the char ID, and 01 is a double line
;;  break.  "1X 00" is a control code to draw that character's name.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;

ClinicBuildNameString:
    LDY #0                ; Y will be our string index
    LDX #0                ; X will be our character index
    STX cursor_max        ; will count how many characters are dead

  @Loop:
    LDA ch_ailments, X    ; get this char's OB ailments
    CMP #$01              ; check to see if he's dead
    BNE @NotDead          ; if not... skip him.  Otherwise...

      TXA                 ; put char index in A
      ROL A
      ROL A
      ROL A
      AND #$03            ; shift and mask to make it char ID (0-3)

      ADC #$10            ; add 10 to get the "draw stat" string control code ($10-$13).  Carry is impossible here
      STA str_buf+$10, Y  ; put it in the string buffer
      LDA #$00
      STA str_buf+$11, Y  ; draw stat 0 (name)
      LDA #$01
      STA str_buf+$12, Y  ; followed by a double line break

      TYA
      CLC
      ADC #$03            ; add 3 to the string index (we just put 3 bytes in the buffer)
      TAY

      INC cursor_max      ; and increment our dead guy counter

  @NotDead:
    TXA
    CLC
    ADC #$40              ; add $40 to our char index (look at next char)
    TAX

    BNE @Loop             ; and keep looping until it wraps (4 iterations)

    LDA #$00
    STA str_buf+$10, Y    ; then put a null terminator at the end of the string

    LDA cursor_max        ; set C if we have at least 1 dead guy
    CMP #$01              ; clear C otherwise

    RTS                   ; and exit!

;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Shop Frame  [$A727 :: 0x3A737]
;;
;;    Does a frame for shops.  Plays movement and selection sound effects
;;  where appropriate.  Like EquipMenuFrame... tmp+7 is used for previous
;;  directions pressed for the purposes of playing sound effects only!
;;  other parts of the shop code still use joy_prevdir for detecting
;;  cursor movement.
;;
;;    Routine comes in two flavors.  ShopFrame and ShopFrameNoCursor.
;;  both are identical, only the latter does not draw the cursor.
;;
;;    Note the inefficiency here.  Both routines meet up after they call
;;  music play, but they COULD meet up just before the call to WaitForVBlank_L
;;  since the code in both is identical at that point.
;;
;;    Strangely, NEITHER routine clears joy_a or joy_b, which means the shop
;;  code has to do this!
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;

ShopFrame:
    JSR ClearOAM               ; clear OAM
    
    LDA inv_canequipinshop
    BEQ :+
    JSR Shop_CharacterCanEquip ; JIGS - if its weapon or armor shops, check the cursor for the highlighted item
                               ; then apply a high bit to ailments that tells the sprite-drawing routine to do them in cheer pose! oof
    
  : JSR DrawShopPartySprites   ; draw the party sprites
    JSR DrawShopCursor         ; and the cursor
    JMP _ShopFrame_WaitForVBlank

ShopFrameNoCursor:
    JSR ClearOAM               ; do all the same things as above, in the same order
    JSR DrawShopPartySprites   ;  only do not draw the cursor
  _ShopFrame_WaitForVBlank:
    JSR WaitForVBlank_L
    LDA #>oam
    STA $4014
    LDA #BANK_THIS
    STA cur_bank
    JSR CallMusicPlay          ; after we call MusicPlay, proceed to check the buttons

  _ShopFrame_CheckBtns:
    LDA joy                    ; get old joypad data for last frame
    AND #$0F                   ; isolate the directional buttons
    STA tmp+7                  ; and store it as our prev joy data

    JSR UpdateJoy              ; update joypad data
    LDA joy_a                  ; see if either A or B pressed
    ORA joy_b
    ;ORA joy_start
    BEQ @CheckMovement         ; if not... check directionals

    JMP PlaySFX_MenuSel        ; if either A or B pressed, play the selection sound effect, and exit

  @CheckMovement:
    LDA joy                    ; joy current joypad data
    AND #$0F                   ; isolate directional buttons
    BEQ @Exit                  ; if no directional buttons down, exit
    CMP tmp+7                  ; compare to previous directional buttons
    BEQ @Exit                  ; if no change, exit
    JMP PlaySFX_MenuMove       ; otherwise, play the movement sound effec, and exit

  @Exit:
    LDA #0
    STA joy_a
    STA joy_b
    STA joy_start
    RTS

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Draw Shop   [$A778 :: 0x3A788]
;;
;;     Draws most of the shop.  This includes the title box, gold box, and
;;  shopkeeper graphics... as well as the attribute tables for the whole screen.
;;  It does not draw the inventory, command, or dialogue boxes, nor does it draw
;;  any sprites.
;;
;;    shop_id and shop_type must both be set appropriately prior to calling
;;  this routine.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


DrawShop:
    JSR LoadShopInventory      ; load up this shop's inventory into the item box
    JSR ClearNT                ; clear the nametable

              ; Fill attribute tables
    LDA $2002                  ; reset the PPU toggle
    LDA #>$2300                ; set the ppu addr to $23C0  (attribute tables)
    STA $2006
    LDA #<$23C0
    STA $2006

    LDX #$00                     ; loop $40 time to copy our attribute LUT to the on-screen attribute tables
  @AttribLoop:
      LDA lut_ShopAttributes, X  ; fetch a byte from the lut
      STA $2007                  ; draw it
      INX
      CPX #$40                   ; repeat until X=$40
      BCC @AttribLoop

              ; Draw the shopkeeper
    LDX shop_type                ; get the shop type in X
    LDA lut_ShopkeepAdditive, X  ; use it to fetch the image additive from our LUT
    STA tmp+2                    ; tmp+2 is the image additive (see DrawImageRect)

    ;LDA #$06                     ; the shopkeeper image rectangle
    ;STA dest_y                   ;  coords:  $0B,$06
    ;LDA #$0B                     ;    dims:  10x10
    ;STA dest_x
    ;LDA #10
    ;STA dest_wd
    ;STA dest_ht
    
    ;; JIGS - making this smaller
    
    LDA #$08                     
    STA dest_y                   
    LDA #$0C                     
    STA dest_x
    LDA #4
    STA dest_wd
    LDA #8
    STA dest_ht
    
    LDA #<lut_ShopkeepImage      ; get the pointer to the shopkeeper image
    STA image_ptr
    LDA #>lut_ShopkeepImage
    STA image_ptr+1

    JSR DrawImageRect            ; draw the image rect

    LDA #0
    STA menustall                ; disable menu stalling (PPU is off)

    LDA #$01
    JSR DrawShopBox              ; draw shop box ID=1  (the title box)

    LDA shop_type                ; get the shop type
    DEC dest_y ; JIGS 
    JSR DrawShopString           ; and draw that string (the shop title string)

    JSR DrawShopGoldBox          ; draw the gold box

    JSR TurnMenuScreenOn_ClearOAM   ; then clear OAM and turn the screen on

    LDA #1
    STA menustall                ; now that the screen is on, turn on menu stalling as well

    RTS                          ; and exit

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Load Shop Inventory  [$A7D1 :: 0x3A7E1]
;;
;;   Loads a shop's inventory into the item box
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

LoadShopInventory:
    LDA shop_id          ; get the shop ID
    ASL A                ; double it
    TAX                  ; put it in X for indexing

    LDA lut_ShopData, X      ; load up the pointer to shop's inventory
    STA tmp
    LDA lut_ShopData+1, X
    STA tmp+1

    LDY #$04             ; copy 5 items from the inventory (max for a shop)
  @Loop:
     LDA (tmp), Y        ; get the item from the shop LUTs
     STA item_box, Y     ; put it in the item box
     DEY                 ; decrement loop counter and index
     BPL @Loop           ; and loop until counter wraps

    LDA #0
    STA item_box+5       ; put a null terminator at the end of the item_box

    RTS                  ; and exit

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Draw Shop Gold Box   [$A7EF :: 0x3A7FF]
;;
;;     Draws the box containing remaining GP in the shops and all of its contents
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

DrawShopGoldBox:
    LDA #$04
    JSR DrawShopBox            ; Draw shop box #4  (the gold box)
    JSR PrintGold              ; print current gold to format buffer
    DEC dest_y                 ; JIGS - I think this makes it look nicer
    JSR DrawShopComplexString  ; draw formatted string

    LDA dest_x                 ; add 6 to the X coord
    CLC
    ADC #$06
    STA dest_x

    LDA #$08                   ; draw shop string ID=$08 (" G")
    JMP DrawShopString         ; then exit


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  EquipMenu_BuildSellBox  [$A806 :: 0x3A816]
;;
;;     This routine fills the item box with a character's weapon or armor
;;  list.
;;
;;     This routine is totally stupid.  It only works if the character's equipment
;;  list is sorted (it stops as soon as it sees an empty slot).  Hence all the annoying
;;  automatic sorting in the equip menus and shops.
;;
;;     So yeah -- this routine is dumb.  But I suppose it works...
;;
;;  IN:      cursor = char ID (0-3) whose items we want to sell
;;        shop_type = 0 for weapon, 1 for armor
;;
;;  OUT:   item_box = filled with items for sale.  Null terminated
;;                C = set if no items available to sell
;;                      clear if at least 1 item
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; JIGS - edited this a bit to print blank fire orbs for empty equipment slots. 

EquipMenu_BuildSellBox:
    LDX #0               
    LDA shop_type        ; check shop type, and fork appropriately
    
    BNE @ArmorLoop

  @WeaponLoop:
    LDA inv_weapon, X      ; get the weapon ID in this slot
    BEQ @Done
    
    CLC
    ADC #$1C-1           ; add to convert to an Item ID
    STA item_box, X      ; put it in the item_box
    INX                  ; inc both source and dest indeces
    CPX #$40
    BNE @WeaponLoop
    JMP @Done
    
  @ArmorLoop:
    LDA inv_armor, X
    BEQ @Done
    
    CLC
    ADC #$44-1           ; convert from armor ID to item ID
    STA item_box, X
    INX 
    CPX #$40
    BNE @ArmorLoop
    
    @Done:
    LDA #0
    STA item_box, X
    INX 
    CPX #$40
    BCC @Done
    
    LDA item_box
    CMP #01
    RTS


    
    
    
EquipMenu_RebuildInventory:
    LDX #0              
    LDY #0    
    STX MMC5_tmp 

    LDA shop_type      ; check shop type, and fork appropriately
    BNE @ArmorLoop

  @WeaponLoop:
    LDA item_box, Y    ; get the item ID in this slot
    BEQ @SkipWeapon

    SEC
    SBC #$1C-1         ; subtract to turn back into weapon ID
    STA inv_weapon, X  ; put it in the weapon inventory
    INX
    
   @ResumeWeapon:
    INY
    CPY #$40
    BNE @WeaponLoop
    
    LDA MMC5_tmp
    BEQ @Done
        
    @FillWeaponBlanks:    ; otherwise, fill the blanks
    LDA #0
    STA inv_weapon, X  
    INX
    DEC MMC5_tmp ; decrease the amount of blanks left to fill 
    LDA MMC5_tmp 
    BNE @FillWeaponBlanks  ; when its 0, stop! 
  @Done:
    RTS     
    
   @SkipWeapon:
    INC MMC5_tmp
    JMP @ResumeWeapon    
    
  @ArmorLoop:
    LDA item_box, Y    ; get the item ID in this slot
    BEQ @SkipArmor

    SEC
    SBC #$44-1         ; subtract to turn back into weapon ID
    STA inv_armor, X  ; put it in the weapon inventory
    INX
    
   @ResumeArmor:
    INY
    CPY #$40
    BNE @ArmorLoop
    
    LDA MMC5_tmp
    BEQ @DoneArmor
        
    @FillArmorBlanks:    ; otherwise, fill the blanks
    LDA #0
    STA inv_armor, X  
    INX
    DEC MMC5_tmp ; decrease the amount of blanks left to fill 
    LDA MMC5_tmp 
    BNE @FillArmorBlanks  ; when its 0, stop! 
  @DoneArmor:
    RTS     
    
   @SkipArmor:
    INC MMC5_tmp
    JMP @ResumeArmor
    
    
    
    
    
    
    
    
;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Shop Select Buy Item   [$A857 :: 0x3A867]
;;
;;     Builds the string to fill the inventory box from the shop's
;;  inventory (ie:  items you can buy).  These items are taken from the item_box
;;  Once the string is drawn, cursor_max is set appropriatly (the number of items
;;  available for sale), and this routine calls the common shop loop.
;;
;;  OUT:   cursor = selected item
;;              C = set if B pressed, clear if A pressed
;;
;;     str_buf+$10 is used to hold the string because item_box and str_buf share
;;  space.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;


ShopSelectBuyItem:
    LDY #0            ; zero Y... this will be our string building index
    STY cursor_max    ; up counter
  @Loop:
    LDA item_box_offset ; 0 always, except when selling items, then it moves to scroll the list!
    CLC
    ADC cursor_max
    TAX
    
    LDA item_box, X      ; use it to get the next shop item
    BEQ @Done            ; if null terminator, no more shop items.  We're done
                         ; otherwise... start building the string
    STA str_buf+$42, Y   ; put item ID at +$11
    STA str_buf+$48, Y   ; and at +$17
    LDA #$02
    STA str_buf+$41, Y   ; put #2 (Item Name control code) at +$10 
    LDA #$03
    STA str_buf+$47, Y   ; put #3 (Item Price control code) at +$16
    LDA #$01
    STA str_buf+$43, Y   ; put #1 (double line break) at +$12 and +$18
    STA str_buf+$49, Y
    LDA #$FF
    STA str_buf+$44, Y   ; put a space at +$13, +$14, and +$15
    STA str_buf+$45, Y   ; compiled string is:
    STA str_buf+$46, Y

    TYA
    CLC                  ; add 8 to our string index so the next item is drawn after this item
    ADC #9               ; JIGS - the box is longer than original game
    TAY

    INC cursor_max       ; increment cursor_max, our item counter
    LDA cursor_max
    CMP #5               ; ensure we don't exceed 5 items (max the shop space will allow)
    BNE @Loop            ; if we haven't reached 5 items yet, keep looping

  @Done:
    LDA #0
    STA str_buf+$41, Y     ; slap a null terminator at the end of our string
    STA str_buf+$40        ; slap a null terminator at the end of equipment list
    
    LDA #$44
    STA str_buf+$6F        ; JIGS - weapon dance reset byte!
    LDA #$6C
    STA str_buf+$70         ; Armor dance reset byte!
    
    ;; SO since the string buffer ends at $3D when a shop has 5 items, these two bytes are unused, but need to be filled...
    ;; By setting cursor to $3E and $3F, depending on weapon or armor shops, the routine that makes them pose to show they can equip weapons
    ;; Will try to make them equip a 41st item, which in the permissions LUT, is filled with "cannot equip" bits...
    
    LDA #$02
    JSR DrawShopBox        ; draw shop box #2 (inv list box)

    LDA #<(str_buf+$41)    ; load up the pointer to our string
    STA text_ptr
    LDA #>(str_buf+$41)
    STA text_ptr+1
    JSR DrawShopComplexString  ; and draw it

    LDA #$03
    JSR LoadShopBoxDims
    JSR EraseBox           ; erase shop box #3 (command box)

    JMP CommonShopLoop_List  ; everything's ready!  Just run the common loop from here, then return
    


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  ShopLoop_BuyExit [$A8B1 :: 0x3A8C1]
;;
;;    Opens up the shop command box, gives options "Buy" and "Exit"
;;  and loops until the user selects one.
;;
;;  OUT:  cursor = 0 for "Buy", 1 for "Exit"
;;             C = set if B pressed (exit), clear if A pressed
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

ShopLoop_BuyExit:
    LDA #$03
    JSR DrawShopBox          ; draw shop box ID=3 (the command box)
    LDA #$0B
    JSR DrawShopString       ; draw shop string ID=$0B ("Buy"/"Exit")

    LDA #2
    STA cursor_max           ; 2 cursor options

    JMP CommonShopLoop_Cmd   ; do the common shop loop, and exit


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  ShopLoop_YesNo [$A8C2 :: 0x3A8D2]
;;
;;    Exactly the same as ShopLoop_BuyExit, only it gives
;;  options "Yes" and "No".
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

ShopLoop_YesNo:
    LDA #$03
    JSR DrawShopBox          ; draw shop box ID=3 (the command box)
    LDA #$0F
    JSR DrawShopString       ; draw shop string ID=$0F ("Yes"/"No")

    LDA #2
    STA cursor_max           ; 2 cursor options

    JMP CommonShopLoop_Cmd   ; do command shop loop and exit



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  ShopLoop_BuySellExit  [$A8D3 :: 0x3A8E3]
;;
;;    Same thing as above... but with options "Buy", "Sell"
;;  and "Exit"
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

ShopLoop_BuySellExit:
    LDA #$03
    JSR DrawShopBox          ; draw box 3 (command box)
    LDA #$0A
    JSR DrawShopString       ; string 0A ("Buy Sell Exit")

    LDA #$03
    STA cursor_max           ; 3 options

    JMP CommonShopLoop_Cmd   ; do command loop


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  ShopLoop_CharNames [$A8E4 :: 0x3A8F4]
;;
;;    opens up the shop command box, fills it with the names of the
;;  party members, and has the user select one of them.  The selection
;;  is put in 'cursor', and C is set if B was pressed, and is cleared if
;;  A was pressed.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

ShopLoop_CharNames:
    LDA #$03
    JSR DrawShopBox            ; draw shop box 3 (command box)

    LDA #<@NamesString         ; set our pointer to the string containing char names
    STA text_ptr
    LDA #>@NamesString
    STA text_ptr+1
    JSR DrawShopComplexString  ; and draw it

    LDA #4
    STA cursor_max             ; give the user 4 options

    JMP CommonShopLoop_Cmd     ; then run the common loop

  @NamesString:
  .BYTE $10,$00,$01   ; char 0's name, double line break
  .BYTE $11,$00,$01   ; char 1's, double line break
  .BYTE $12,$00,$01   ; char 2's, double line break
  .BYTE $13,$00,$00   ; char 3's, null terminator


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Common Shop Loop  [$A907 :: 0x3A917]
;;
;;    Shops consist of waiting for the user to navigate a menu.  And the cursor is always
;;  restricted to a fixed up/down motion.  Because of this, the loop that drives shops
;;  can all share the same routine.
;;
;;    Why the game didn't do something like this for ALL the menus... I'll never know.
;;
;;    This common shop loop will keep doing frames, checking for cursor movement each frame
;;  and exits only once the player presses A or B.
;;
;;    The routine comes in two flavors.  CommonShopLoop_Cmd and CommonShopLoop_List.  The
;;  difference between the two is where the cursor is drawn.  For _Cmd, it's drawn in the
;;  command box ("buy", "sell", etc box).  For _List it's drawn in the inventory list box.
;;
;;  IN:   cursor_max
;;
;;  OUT:       C = set if B pressed
;;                 clear if A pressed
;;        cursor = the selected menu item (assuming A was pressed)
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


CommonShopLoop_Cmd:
    LDA #<lut_ShopCurs_Cmd     ; get the pointer to the desired cursor position LUT
    STA text_ptr               ;  put the pointer in (text_ptr).  Yes, I know... 
    LDA #>lut_ShopCurs_Cmd     ;  it's not really text.
    STA text_ptr+1
    JMP _CommonShopLoop_Main   ; then jump ahead to the main entry for these routines

CommonShopLoop_List:
    LDA #<lut_ShopCurs_List    ; exactly the same as _Cmd version of the routine
    STA text_ptr               ; only have (text_ptr) point to a different LUT
    LDA #>lut_ShopCurs_List
    STA text_ptr+1

      ; both flavors of this routine meet up here, after filling (text_ptr)
      ;   with a pointer to a LUT containing the cursor positions.

 _CommonShopLoop_Main:
    LDA #0
    STA cursor           ; reset the cursor to zero

    LDA joy              ; get the joy data
    AND #$0C             ; isolate up/down bits
    STA joy_prevdir      ; and store in prev_dir
                         ; then begin the loop...

  @Loop:
    LDA cursor           ; get the cursor
    ASL A                ; multiply by 2 (2 bytes per position)
    TAY                  ; put in Y for indexing

    LDA (text_ptr), Y    ; fetch the cursor X coord from out LUT
    STA shopcurs_x       ; and record it
    INY                  ; inc Y to get Y coord
    LDA (text_ptr), Y    ; read it
    STA shopcurs_y       ; and record it

    JSR ShopFrame        ; now that cursor position has been recorded... do a frame

    LDA joy_b
    BNE @B_Pressed       ; check to see if A or B have been pressed
    LDA joy_a
    BNE @A_Pressed
    ;LDA joy_start
    ;BNE @Start_Pressed
                         ; if neither pressed.. see if the cursor has been moved
    LDA joy              ; get joy
    AND #$0C             ; isolate up/down buttons
    CMP joy_prevdir      ; compare to previous buttons to see if button state has changed
    BEQ @Loop            ; if no change.. do nothing, and continue loop

    STA joy_prevdir      ; otherwise, record changes

    CMP #0               ; then check to see if buttons have been pressed or not
    BEQ @Loop            ; if not.. do thing, and continue loop

    CMP #$08             ; see if the button pressed was up or down
    BNE @Down

  @Up:
    DEC cursor           ; if up pressed, decrement the cursor by 1
    BPL @Loop            ; if it hasn't gone below zero, that's all -- continue loop

    LDA SellingEquipment
    BNE @ScrollListUp
    
    @UpReturn:
    LDA cursor_max       ; otherwise (below zero), wrap to cursor_max-1
    SEC
    SBC #$01
    JMP @MoveDone        ; desired cursor is in A, jump ahead to @MoveDone to write it back

  @Down:
    LDA cursor           ; if down pressed, get the cursor
    CLC
    ADC #$01             ; increment it by 1
    CMP cursor_max       ; check to see if we've gone over the cursor max
    BCC @MoveDone        ; if not, jump ahead to @MoveDone

    LDA SellingEquipment
    BNE @ScrollListDown
    @DownReturn:
    
    LDA #0               ; if yes, wrap cursor to zero

  @MoveDone:             ; code reaches here when A is to be the new cursor position
    STA cursor           ; just write it back to the cursor
    JMP @Loop            ; and continue loop
 


  @B_Pressed:            ; if B pressed....
    SEC                  ; SEC to indicate player pressed B
                         ;  and proceed to @ButtonDone

  @ButtonDone:           ; reached when the player has pressed B or A (exit this shop loop)
    LDA #0
    STA joy_a            ; zero joy_a and joy_b so further buttons will be detected
    STA joy_b
    ;STA joy_start       ; and select... but why?  select isn't used in shops?
    RTS

  @A_Pressed:            ; if A pressed...
    CLC                  ; CLC to indicate player pressed A
    BCC @ButtonDone      ;  and jump to @ButtonDone (always branches)
    
;  @Start_Pressed:
;   JSR EnterMainMenu
;   JSR LoadShopCHRPal     ; load up the CHR and palettes (and the shop type)
;   JSR DrawShop           ; draw the shop  
;   LDA ShopCursorBackup
;   STA cursor
;   LDA ShopDialogueBackup
;   JSR DrawShopDialogueBox
;   JMP @Loop


@ScrollListDown:
    LDX item_box_offset
    CPX #$3C            ; if item box scrolls beyond this point, no more scrolling
    BCC :+
    JMP @DownReturn
    
  : LDY #0
 @ScrollDownLoop:  
    LDA item_box, X
    BEQ @DownReturn
    INX
    INY
    CPY #6              ; check the next 5 slots for 0. If a 0 is reached before 5, 
    BNE @ScrollDownLoop ; there's no more items to display
    
    LDA item_box_offset
    CLC
    ADC #05
    STA item_box_offset
    JMP ShopSelectBuyItem


@ScrollListUp:
    LDA item_box_offset
    BNE :+
    JMP @UpReturn
  : SEC
    SBC #05
    STA item_box_offset
    JMP ShopSelectBuyItem

ClearShopkeeperTextBox:
    JSR ShopFrame        ; now that cursor position has been recorded... do a frame

    LDA joy_b
    ORA joy_a
    BEQ ClearShopkeeperTextBox ; just wait for A or B to be pressed
    
    LDA #0
    STA joy_b
    STA joy_a

    LDA #$00
    JSR LoadShopBoxDims
    JMP EraseBox           ; erase shop box #3 (command box)






   

;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Shop cursor position luts  [$A977 :: 0x3A987]
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;lut_ShopCurs_Cmd:    ; cursor positions for the command box
;  .BYTE $28,$A0
;  .BYTE $28,$B0
;  .BYTE $28,$C0
;  .BYTE $28,$D0

;lut_ShopCurs_List:   ; cursor positions for the inventory list box
;  .BYTE $A8,$20
;  .BYTE $A8,$40
;  .BYTE $A8,$60
;  .BYTE $A8,$80
;  .BYTE $A8,$A0

;; JIGS - reorganized:

lut_ShopCurs_Cmd:    ; cursor positions for the command box
  .BYTE $08,$40
  .BYTE $08,$50
  .BYTE $08,$60
  .BYTE $08,$70

lut_ShopCurs_List:   ; cursor positions for the inventory list box
  .BYTE $A0,$20
  .BYTE $A0,$40
  .BYTE $A0,$60
  .BYTE $A0,$80
  .BYTE $A0,$A0


;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Shop Select Buy Magic   [$A989 :: 0x3A999]
;;
;;     Builds the string to fill the inventory box from the shop's
;;  inventory (ie:  spells you can buy).  These items are taken from the item_box
;;  Once the string is drawn, cursor_max is set appropriatly (the number of items
;;  available for sale), and this routine calls the common shop loop.
;;
;;  OUT:   cursor = selected item
;;              C = set if B pressed, clear if A pressed
;;
;;     str_buf+$10 is used to hold the string because item_box and str_buf share
;;  space.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;

ShopSelectBuyMagic:
    LDA #0
    STA cursor_max     ; zero cursor max... this will count the number of spells for sale.
    LDY #0             ; Y will be our string index

  @Loop:
    LDX cursor_max
    LDA item_box, X    ; get next item in shop inventory
    BEQ @Done          ; if it's zero (the null terminator), break out of the loop

    ;STA str_buf+$11, Y ; store item ID at $11
    ;STA str_buf+$16, Y ; and $16
    ;LDA #$02
    ;STA str_buf+$10, Y ; store $02 ("draw item name" control byte) at $10
    ;LDA #$03
    ;STA str_buf+$15, Y ; store $03 ("draw item price" control byte) at $15
    ;LDA #$01
    ;STA str_buf+$12, Y ; store $01 (double line break) at $12 and $17
    ;STA str_buf+$17, Y
    ;LDA #$C6
    ;STA str_buf+$13, Y ; store tile $C6 (the special 'L' character) at $13
    
    ;; JIGS - some changes...
    
    STA str_buf+$42, Y ; store item ID at $11
    STA str_buf+$48, Y ; and $17
    LDA #$02
    STA str_buf+$41, Y ; store $02 ("draw item name" control byte) at $10
    LDA #$03
    STA str_buf+$47, Y ; store $03 ("draw item price" control byte) at $16
    LDA #$01
    STA str_buf+$43, Y ; store $01 (double line break) at $12 and $18
    STA str_buf+$49, Y
    LDA #$95
    STA str_buf+$44, Y ; JIGS - normal L now
    LDA #$FF           ; and a space
    STA str_buf+$46, Y

    LDA str_buf+$42, Y ; get the item ID
    SEC
    SBC #$B0           ; subtract $B0 (spell IDs start at $B0
    LSR A
    LSR A
    LSR A              ; then divide by 8.  This gives us the spell's level
    SEC
    ADC #$80           ; SEC then add $80 (so really... add $81).  This converts the 0-based
                       ;  level, into the 1-based tile to draw.  IE:  level=0 prints the "1" tile.
    STA str_buf+$45, Y ; put that tile at $14

                 ; string is now:  "02 XX 01 C6 VV 03 XX 01" where XX is the item ID, and VV is the spell level
                 ;  which... after processing all control codes... will draw to:
                 ;
                 ; Name
                 ; LV_Price

    TYA
    CLC                ; that bit of string is 8 bytes... so add 8 to our
    ;ADC #$08           ;  string index:  Y
    ;; JIGS - it is 9!
    ADC #$09
    TAY

    INC cursor_max     ; increment cursor max to count this entry
    LDA cursor_max
    CMP #5             ; check to see if we have 5 spells yet (can't sell more than 5)
    BCC @Loop          ; keep looping if we have less than 5

  @Done:
    LDA #$00
    STA str_buf+$41, Y ; put a null terminator at the end of the string

    LDA #$02
    JSR DrawShopBox    ; draw shop box 2 (inventory list box)

    LDA #<(str_buf+$41)         ; set the text pointer to our string
    STA text_ptr
    LDA #>(str_buf+$41)
    STA text_ptr+1
    JSR DrawShopComplexString   ; and draw it

    LDA #$03
    JSR LoadShopBoxDims         ; then erase shop box 3 (command box)
    JSR EraseBox

    JMP CommonShopLoop_List     ; and have the user select an option from the shop inventory list

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Draw Shop Cursor   [$A9EF :: 0x3A9FF]
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

DrawShopCursor:
    LDA shopcurs_x     ; copy over the shop cursor coords
    STA spr_x
    LDA shopcurs_y
    STA spr_y
    JMP DrawCursor     ; then draw it, and exit

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Draw Shop Party Sprites [$A9FA :: 0x3AA0A]
;;
;;    Draws the sprites for the party when in a shop
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

DrawShopPartySprites:
;    LDA #$98
;    STA spr_x
;    LDA #$38
;    STA spr_y
;    LDA #1<<6
;    JSR DrawOBSprite    ; draw char 1 at $98,$38

;    LDA #$50
;    STA spr_y
;    LDA #2<<6
;    JSR DrawOBSprite    ; draw char 2 at $98,$50

;    LDA #$68
;    STA spr_y
;    LDA #3<<6
;    JSR DrawOBSprite    ; draw char 3 at $98,$68

;    LDA #$50
;    STA spr_y
;    LDA #$88
;    STA spr_x
;    LDA #0<<6
;    JMP DrawOBSprite    ; draw char 0 at $88,$50, then exit

;; JIGS - really cram 'em in there! Let Light Warrior #2 see the wares! 

    LDA #$80
    STA spr_x    
    LDA #$2A ;44
    STA spr_y
    LDA #0<<6
    JSR DrawOBSprite    
    
    LDA #$42 ;5D
    STA spr_y
    LDA #1<<6
    JSR DrawOBSprite    
    
    ;LDA #$90
    ;STA spr_x
    LDA #$5A ; 3C
    STA spr_y
    LDA #2<<6
    JSR DrawOBSprite    

    LDA #$72 ; 55
    STA spr_y
    LDA #3<<6
    JMP DrawOBSprite    

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Draw Shop String  [$AA26 :: 0x3AA36]
;;
;;     Draws a stock shop string as a Complex String given its ID number.  These strings
;;  include shop dialogue, stop titles, and other things.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

DrawShopString:
    ASL A              ; double the ID (2 bytes per pointer)
    TAX                ; put it in X

    LDA lut_ShopStrings, X  ; load the pointer from the shop string LUT
    STA text_ptr
    LDA lut_ShopStrings+1, X
    STA text_ptr+1     ;  ... then draw it....
                       ; no JMP or RTS -- code seamlessly flows into DrawShopComplexString

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Draw Shop Complex String  [$AA32 :: 0x3AA42]
;;
;;    This just calls DrawComplexString, but sets the required bank information
;;  first.
;;
;;    Somewhat wastefully, there's a routine virtually identical to this one
;;  that is used for menus!  See DrawMenuComplexString.  The only difference is that this
;;  routine uses X instead of A -- but since DrawComplexString overwrites both A and X...
;;  that is utterly meaningless.
;;
;;    Anyway, yeah.  Big waste.  No reason this routine needs to exist.  All references to it
;;  could just call DrawMenuComplexString.  C'est la vie... one of this game's many quirks.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;DrawShopComplexString:
;    LDX #BANK_THIS
;    STX cur_bank
;    STX ret_bank
;    JMP DrawComplexString

;; JIGS - moving this label to save space

JMP DrawMenuComplexString

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Draw Shop Box  [$AA3B :: 0x3AA4B]
;;
;;    Draws a shop box
;;
;;  IN:   A = shop box ID number
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

DrawShopBox:
    JSR LoadShopBoxDims      ; load the dims
    JMP DrawBox              ; draw it, then exit

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Load Shop Box Dims  [$AA41 :: 0x3AA51]
;;
;;    Loads the positions and dimensions for the given shop box ID number (in A)
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

LoadShopBoxDims:
    TAX                    ; put box ID in X

    LDA lut_ShopBox_X, X        ; use it to copy data from LUTs
    STA box_x
    LDA lut_ShopBox_Y, X
    STA box_y
    LDA lut_ShopBox_Wd, X
    STA box_wd
    LDA lut_ShopBox_Ht, X
    STA box_ht

    LDA #BANK_THIS         ; set the cur bank.  cur bank is needed to be set
    STA cur_bank           ; for when boxes are drawn/erased when stalled

    RTS




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Draw Shop Dialogue Box  [$AA5B :: 0x3AA6B]
;;
;;     Draws the shop dialogue and desired text string (shop text string ID in A)
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

DrawShopDialogueBox:
    ;STA ShopDialogueBackup
    PHA                  ; back up desired dialogue string by pushing it
    LDA #$00
    JSR DrawShopBox      ; draw shop box ID 0 (the dialogue box)
    PLA                  ; pull our dialogue string
    JMP DrawShopString   ; draw it, then exit



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Draw Shop Buy Item Confirm  [$AA65 :: 0x3AA75]
;;
;;    This routine draws the 'are you sure you want to buy this' confirmation
;;  dialogue text for the shopkeeper after you select an item to buy.  This
;;  text involves printing the price of the item... and the game does a very weird
;;  way of getting the text for the item.  Rather than just building a string in
;;  a temp buffer and calling DrawComplexString... it modifies the existing
;;  string in str_buf (the string that was used to draw the shop inventory)
;;
;;    Each item in str_buf consists of 8 bytes:  "02 XX 01 FF FF 03 XX 01" where
;;  'XX' is the ID of this item.  (02 is the control code to indicate the item
;;  name is to be drawn, and 03 is the control code to indicate the price is
;;  to be drawn, and 01 is a double line break).
;;
;;    Rather than repeat '03 XX' in RAM somewhere, the game will calculate the
;;  position of the 03 XX bytes in that string and point to it!  It will then
;;  stick a null terminator after the price.
;;
;;    The shop inventory string starts at str_buf+$10 rather than str_buf, because
;;  str_buf is shared with item_box, which is still needed to hold the shop inventory.
;;  Also, the 03 XX bytes are 5 bytes into the string for the item.... and as said before
;;  each item has 8 bytes in the string.  So the formula for finding the price in that
;;  string is:  (cursor * 8) + str_buf+$15
;;
;;    This routine also fills shop_curitem and shop_curprice with the selected item
;;  and its price.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

DrawShopBuyItemConfirm:
    LDA #$0E
    JSR DrawShopDialogueBox  ; draws "Gold  OK?" -- IE:  all the non-price text

    ;LDA cursor            ; get the cursor
    ;ASL A
    ;ASL A
    ;ASL A                 ; multiply by 8
    ;CLC
    ;ADC #<(str_buf+$15)   ; add str_buf+$15
    ;STA text_ptr          ; use as low byte of pointer.  See routine description
                          ; for details of why its doing this

    ;; JIGS - I forget why, but we need to multiply by 9 now, and str_buf is larger, so...

    LDA InItemShop             ;; JIGS - and skip loading the price if we're in an item shop
    BEQ :+ 
    
    LDA #<(str_buf+$09)        ; set our text pointer to point to the generated string
    STA text_ptr
    LDA #>(str_buf+$09)
    STA text_ptr+1
    LDA #03
    JMP :++
    
    ;; JIGS - that will set it in the right spot, plus the edits at the ++ jump point
        
  : LDA cursor            
    LDX #09
    JSR MultiplyXA
    CLC
    ADC #<(str_buf+$47)   
    STA text_ptr          
    
    CLC                   ; add 2 and put in X.  X will now be
    ADC #$02              ;  where we need to put the null terminator (2 bytes after
    TAX                   ;  the start of the string -- all we're drawing is "03 XX")

    LDA #0
    STA str_buf, X        ; put the null terminator there

    DEX                   ; decrement X...
    LDA str_buf, X        ;   this gets the item ID from the string
    STA shop_curitem      ;  store in the current item

    LDA #>(str_buf+$47)
    STA text_ptr+1
    
    LDA shop_curitem      ; get the current item
    JSR LoadPrice         ; load its price (gets put in tmp, tmp+1)

    LDA tmp               ; copy the price to shop_curprice
    STA shop_curprice
    LDA tmp+1
    STA shop_curprice+1

    LDA #04
  : STA dest_x
    INC dest_y
    INC dest_y
    
    ;; JIGS - movin' some numbers on the screen
    
    JMP DrawShopComplexString  ; draw our complex string (item price), and exit



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Draw Inn Clinic Confirm  [$AA9B :: 0x3AAAB]
;;
;;    Draws the confirmation dialogue for inns/clinics
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

DrawInnClinicConfirm:
    LDA #$0E
    JSR DrawShopDialogueBox   ; draw "Gold  OK?" -- all the non-price text

    LDA item_box              ; copy the inn price (first two bytes in item_box)
    STA tmp                   ;  to tmp  (for PrintNumber)
    LDA item_box+1
    STA tmp+1
    LDA #0
    STA tmp+2                 ; 5digit print number needs 3 bytes... so just set high byte to zero

    INC dest_y
    INC dest_y
    LDA #04
    STA dest_x
    ;; JIGS - movin' numbers on the screen
    
    JSR PrintNumber_5Digit    ; print it
    JMP DrawShopComplexString ; and draw it


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Draw Shop Sell Item Confirm  [$AAB4 :: 0x3AAC4]
;;
;;    This routine draws the 'are you sure you want to sell this' confirmation
;;  dialogue text for the shopkeeper after you select an item to sell.  It also
;;  calculates the sale price before printing it, and stores the price in shop_curprice
;;
;;  IN:           cursor = selected menu item
;;        shop_charindex = index to start of character's equipment list
;;
;;  OUT:  shop_charindex = index to precise slot of item being sold (cursor is added to it)
;;         shop_curprice = sale price of item
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


DrawShopSellItemConfirm:
    LDA #$0E
    JSR DrawShopDialogueBox  ; draw " Gold OK?" dialogue -- all the text except the actual price
    
   ; LDA cursor               ; put the cursor (selected item) in X
   ; TAX
   ; CLC
   ; ADC shop_charindex       ; and add it to our char index
   ; STA shop_charindex       ;  so char index points directly to the item being sold
    
    LDA cursor
    CLC
    ADC item_box_offset
    TAX
    ;LDX cursor
    LDA item_box, X          ; get the item ID from the item box
    STA MMC5_tmp+1
   
    JSR LoadPrice            ; load the price of this item
    LSR tmp+1                ; then divide that price by 2 to get the sale price
    ROR tmp

    LDA tmp
    STA shop_curprice
    LDA tmp+1
    STA shop_curprice+1      ; copy the price to shop_curprice
    LDA #0
    STA shop_curprice+2

    INC dest_y
    INC dest_y
    LDA #04
    STA dest_x
    
    ;; JIGS - movin' numbers on the screen
    
    JSR PrintNumber_5Digit    ; print the sale price as 5 digits
    JMP DrawShopComplexString ; then draw it, and exit

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  MagicShop_AssertLearn  [$AADF :: 0x3AAEF]
;;
;;    This routine checks to see whether or not the selected character
;;  is capable of learning the selected spell.  It checks for magic
;;  permissions... it checks to see whether or not the spell has already
;;  been learned... and it checks to see if the character has a free slot
;;
;;    If any of those checks fail... this routine does NOT return to the
;;  code that called it.  Instead it drops the return address by manually
;;  pulling it off the stack, then JMPs back to the magic shop loop.
;;
;;    The routine only performs an RTS if the character is capable of
;;  learning the spell.
;;
;;  OUT:  shop_charindex = index to empty slot to receive spell
;;            shop_spell = adjusted ID of this spell (1-8)
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

MagicShop_AssertLearn:
    LDX CharacterIndexBackup ;; JIGS might as well use this
    ;LDX shop_charindex            ; get the target char's index
    LDA ch_class, X               ; use it to get his class
    AND #$0F             ;; JIGS - cut off high bits (sprite)
    ASL A                         ; double it (2 bytes per pointer)
    TAX                           ; and put in X for indexing

    LDA lut_MagicPermisPtr, X     ; get the pointer to this class's
    STA tmp                       ;    magic permissions table
    LDA lut_MagicPermisPtr+1, X   ; put that pointer in (tmp)
    STA tmp+1

    LDA shop_curitem    ; get the item ID of the spell we're to learn
    SEC
    SBC #$B0            ; subtract $B0 to convert it to magic ID (magic starts at item $B0)
    STA tmp+2           ; store magic ID in tmp+2 for future use

    AND #$07            ; get low 3 bits.  This will indicate the bit to use for permissions
    STA tmp+3           ; store it in tmp+3 for future use

    LDA tmp+2           ; get the magic ID
    LSR A               ; divide by 8 (gets the level of the spell)
    LSR A
    LSR A
    
    STA GetSpellLevelIndex ;; JIGS - save this for learning the spell later!
    
    TAY                 ; put spell level in Y
    LDA (tmp), Y        ; use it as index to get the desired permissions byte
    STA tmp+4           ; store permissions byte in tmp+4 for future use

    LDX tmp+3           ; get required bit position
    LDA lut_BIT, X      ; use as index in the BIT lut to get the desired bit
    AND tmp+4           ; AND with permissions byte
    BEQ @HasPermission  ;  if result is zero, they have permission to learn

      LDA #$19                  ; otherwise...
      JSR DrawShopDialogueBox   ; "You can't learn that" dialogue
      PLA                       ; drop the return address
      PLA
      JMP MagicShop_Loop        ; and jump back to the magic shop loop

  @HasPermission:
   ; LDA tmp+2            ; get magic ID
   ; LSR A                ; divide by 2
   ; AND #$1C             ; and mask out high bits.
                         ;   this is effetively (spell_level*4)
   ; CLC                  ; add to that the char index, and you have
   ; ADC shop_charindex   ;  the index to the start of this level's spells
                         ;  for the target character

   ; TAX                  ; put that index in X
   ; LDA tmp+3            ; then get the low bits of the spell ID (0-7)
   ; CLC                  ;  add 1 to that, and you have the level-based
   ; ADC #$01             ;  spell ID (1-8).  These are how spell IDs are stored
                         ;  in the character's spell list

   ; CMP ch_spells, X     ; check each of this character's spells
   ; BEQ @AlreadyKnow     ;  on this level.  If any of them match the
   ; CMP ch_spells+1, X   ;  current spell... then the character
   ; BEQ @AlreadyKnow     ;  already knows this spell
   ; CMP ch_spells+2, X
   ; BEQ @AlreadyKnow

   ; LDA ch_spells, X     ; If they don't already know the spell.. check
   ; BEQ @FoundEmptySlot  ;  each slot until we find an empty one
   ; INX                  ; We need an empty slot to put this spell in
   ; LDA ch_spells, X
   ; BEQ @FoundEmptySlot
   ; INX
   ; LDA ch_spells, X
   ; BEQ @FoundEmptySlot
   ;; JIGS - new way:
   
   INC tmp+2 ; since spells are stored +1 - this also allows Cure to be learned, since otherwise it would CMP/BEQ at 0...
   
   LDA tmp+2            ; spell ID
   LDX #0
    @KnownSpellsLoop:
    CMP TempSpellList, X
    BEQ @AlreadyKnow
    INX 
    CPX #24
    BNE @KnownSpellsLoop
   
    LDX GetSpellLevelIndex ; use it
    LDA SpellLevel_LUT, X  ; to get THIS index...
    TAX  
    
    LDY #0
    @EmptySlotLoop:    
    LDA TempSpellList, X
    BEQ @FoundEmptySlot
    INX
    INY
    CPY #3             ; JIGS - change this (and the LUT below) 
    BNE @EmptySlotLoop ; if you want characters to learn more than 3 spells per level
   
    LDA #$22                 ; if no empty slot found...
    JSR DrawShopDialogueBox  ; "That level is full" dialogue
    PLA                      ; drop return address
    PLA
    JMP MagicShop_Loop       ; and jump back to magic loop

  @AlreadyKnow:
    LDA #$1A                 ; if they already know the spell...
    JSR DrawShopDialogueBox  ; "You already know that" dialogue
    PLA                      ; drop return addy
    PLA
    JMP MagicShop_Loop       ; jump back to magic loop

                         ; if found empty slot -- we have success!
  @FoundEmptySlot:       ;  All conditions are met
    ;LDA tmp+3            ; get low bits
    ;CLC
    ;ADC #$01             ; and add 1 again to get the adjusted spell ID
    
    DEC tmp+2
    LDA tmp+2            ; JIGS - just the plain spell ID now!
    STA shop_spell       ; record that adjusted spell ID

    ;STX shop_charindex   ; record the index to the empty slot in our char index
    ;; JIGS - this will be useless...?
    RTS                  ; and exit!
    
    
SpellLevel_LUT:
.byte $00,$03,$06,$09,$0C,$0F,$12,$15
;; JIGS - offset for where to look for empty spell slots    



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Save Game  [$AB69 :: 0x3AB79]
;;
;;     Saves the game to SRAM and plays that little jingle
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; JIGS - whew... totally re-did this...
SaveGame:
 LDA #1
 STA weasels ; weasels will help save the game
 JSR LongCall
 .word SaveScreen
 .byte $0F 
 
  LDA music_track             ; check the music track
  CMP #$81                    ; if $81 (no music currently playing)...
  BEQ :+
  LDA Asleep                  ; will be 0 if saving didn't happen
  CMP #$56                    ; if save music still playing
  BNE :++
: LDA dlgmusic_backup         ; pre-emptively end the save music
  STA music_track
: RTS
 

;    LDX #0            ; zero X for upcoming loop

;    LDA ow_scroll_x           ; copy over OW information
;    STA unsram_ow_scroll_x
;    LDA ow_scroll_y
;    STA unsram_ow_scroll_y
;    LDA vehicle
;    STA unsram_vehicle

;  @CopyLoop:
;      LDA unsram       , X    ; copy $400 bytes from "unsram" to sram
;      STA   sram       , X
;      LDA unsram + $100, X
;      STA   sram + $100, X
;      LDA unsram + $200, X
;      STA   sram + $200, X
;      LDA unsram + $300, X
;      STA   sram + $300, X
;      INX
;      BNE @CopyLoop           ; loop until X expires ($100 iterations)

;    LDA #$55                  ; set assertion bytes
;    STA sram_assert_55        ;  if assertion bytes are ever different values
;    LDA #$AA                  ;  the game knows SRAM has been corrupted
;    STA sram_assert_AA        ;   like due to battery failure or something

        ; now we need to compute the checksum!
        ;  checksum further verifies that SRAM has not been comprimised

;    LDA #$00
;    STA sram_checksum         ; clear the checksum byte so that it will not interfere with checksum calculations
;    LDX #$00                  ; clear X (loop counter)
;    CLC                       ; and clear carry so it isn't included in checksum

;  @ChecksumLoop:
;      ADC sram       , X    ; sum every byte in SRAM
;      ADC sram + $100, X    ;  note that carry is not cleared between additions
;      ADC sram + $200, X
;      ADC sram + $300, X
;      INX
;      BNE @ChecksumLoop     ; loop until X expires ($100 iterations)

                      ; after loop, A is now what the checksum computes to
;    EOR #$FF          ;  to force it to compute to FF, invert the value
;    STA sram_checksum ;  and write it to the checksum byte.  Checksum calculations will now result in FF

 ;   LDA #$56
 ;   STA music_track   ; play music track $56 (the "you saved your game" jingle)

   ; LDA #%00110000
   ; STA $4004         ; silence sq2 (volume=0)
   ; LDA #$7F
   ; STA $4005         ; disable sweep, and clear freq
   ; LDA #$00          ;  this probably just prevents an unwanted squeak or something when
   ; STA $4006         ;  the jingle starts.  Not entirely sure why the game does this,
   ; STA $4007         ;  but it does it for a few of these jingles.
   ;; JIGS - if no more square 2 SFX... unneeded
;    RTS



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Menu Fill Party HP  [$ABD2 :: 0x3ABE2]
;;
;;    Refills all party members' HP to maximum unless they're dead/stone
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

MenuFillPartyHP:
    LDX #0                  ; X is our char index/loop counter.  start at zero
  @Loop:
    LDA ch_ailments, X      ; get this character's ailment

    CMP #$01
    BEQ @Skip               ; if dead... skip him
    CMP #$02
    BEQ @Skip               ; if stone... skip him

      LDA ch_maxhp, X       ; otherwise copy Max HP over to Cur HP
      STA ch_curhp, X
      LDA ch_maxhp+1, X
      STA ch_curhp+1, X

  @Skip:
    TXA                ; add $40 to X (next char)
    CLC
    ADC #$40
    TAX
    BNE @Loop          ; loop until X wraps (4 iterations)

    RTS                ; then exit

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Menu Recover Party MP  [$ABF3 :: 0x3AC03]
;;
;;    Refills all MP for every party member except those that
;;  are dead or turned to stone.  For use out of battle only (in menus)
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

MenuRecoverPartyMP:
    LDX #0                 ; X is our character index.  Start with character 0
  @Loop:
    LDA ch_ailments, X     ; check OB ailments
    CMP #$01
    BEQ @Skip              ; if dead... skip
    CMP #$02
    BEQ @Skip              ; if stone... skip

    ;  LDA ch_maxmp, X      ; otherwise... refill MP on all level to maximum
    ;  STA ch_curmp, X
    ;  LDA ch_maxmp+1, X
    ;  STA ch_curmp+1, X
    ;  LDA ch_maxmp+2, X
    ;  STA ch_curmp+2, X
    ;  LDA ch_maxmp+3, X
    ;  STA ch_curmp+3, X
    ;  LDA ch_maxmp+4, X
    ;  STA ch_curmp+4, X
    ;  LDA ch_maxmp+5, X
    ;  STA ch_curmp+5, X
    ;  LDA ch_maxmp+6, X
    ;  STA ch_curmp+6, X
    ;  LDA ch_maxmp+7, X
    ;  STA ch_curmp+7, X
    
    ;; JIGS - this gets complicated
    
   LDY #0 
   TXA          ; $0, $40, $80, or $C0
   CLC
   ADC #ch_mp - ch_stats    ; +$30
   TAX
       
    @InnerLoop:
    LDA ch_stats, X ; X is pointer to level 1 MP 
    AND #$0F     ; clear current mp entirely, leaving only max mp
    STA tmp+1    ; back it up
    ASL A        ; shift by 4
    ASL A
    ASL A
    ASL A        ; to put max mp into high bits--current mp
    ORA tmp+1    ; add max mp back in
    STA ch_stats, X ; and save it
    INY
    TXA          
    CLC
    ADC #1       ; +1 for each spell level
    TAX
    CPY #08
    BNE @InnerLoop
    
  @Skip:
    TXA             ; move index into A to do some math
      SEC
      SBC #$38         ; JIGS - undo the +$30 and +8 added to X
    CLC
    ADC #$40        ; add $40 (next character in part
    TAX             ; put back in X
    BNE @Loop       ; and loop until it wraps (full party)

    RTS             ; then exit


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Bit position LUT  [$AC38 :: 0x3AC48]
;;
;;    This LUT simply contains bytes with 1 bit in each
;;  position set.  The game uses this table for magic permissions
;;  checking.
;;
;;    The basic formula for entries in this table is ($80 >> X)
;;  High bit is the first entry

lut_BIT:
  .BYTE %10000000
  .BYTE %01000000
  .BYTE %00100000
  .BYTE %00010000
  .BYTE %00001000
  .BYTE %00000100
  .BYTE %00000010
  .BYTE %00000001
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Shop Box LUTs  [$AC40 :: 0x3AC50]
;;
;;    These are the LUTs for the 5 boxes that appear in the shops.
;;  Since it's not easy to multiply an index by 5 and use that to index a single
;;  LUT, each element (X coord, Y coord, Width, Height) are each in their own
;;  seperate LUT (personally I think this is the better way to do it for all
;;  LUTs... no multiplication needed... but meh)
;;
;;  As for the box IDs:
;;
;;    0 = the shopkeeper's dialogue box
;;    1 = the title box (WEAPON / INN / whathaveyou)
;;    2 = the shop inventory box
;;    3 = the command box (buy/sell/exit/etc)
;;    4 = the gold box (how much money you have left)
;;


;lut_ShopBox_X:    .BYTE $01,$0C,$16,$06,$12
;lut_ShopBox_Y:    .BYTE $04,$02,$02,$12,$18
;lut_ShopBox_Wd:   .BYTE $09,$08,$09,$09,$0A
;lut_ShopBox_Ht:   .BYTE $0C,$04,$16,$0A,$04

;JIGS - MUCH NICER

lut_ShopBox_X:    .BYTE $01,$01,$15,$02,$15
lut_ShopBox_Y:    .BYTE $12,$02,$02,$06,$18
lut_ShopBox_Wd:   .BYTE $13,$13,$0A,$09,$0A
lut_ShopBox_Ht:   .BYTE $09,$03,$16,$0B,$03



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Shopkeep additive LUT  [$AC54 :: 0x3AC64]
;;
;;    Shopkeeper graphics all use the same image when drawn.  The thing that makes them
;;  different is that the tiles used in the drawing are offset by a specific amount, so that
;;  different tiles are drawn for different shops.  This LUT is the offset/additive to use
;;  for each shop type.  Each shopkeep's graphics consist of 14 tiles, so this LUT is basically
;;  just a multiplication by 14

lut_ShopkeepAdditive:
  .BYTE (0*14),(1*14),(2*14),(3*14),(4*14),(5*14),(6*14),(7*14)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Shop Attribute Table LUT  [$AC5C :: 0x3AC6C]
;;
;;    This is a copy of the attribute table to be used for the shop screen.
;;  This is a full $40 bytes that is copied IN FULL to the attribute table
;;  for the shop.

lut_ShopAttributes:
;  .BYTE $FF,$FF,$FF,$55,$55,$FF,$FF,$FF
;  .BYTE $FF,$FF,$3F,$05,$05,$CF,$FF,$FF
;  .BYTE $FF,$FF,$33,$00,$00,$CC,$FF,$FF
;  .BYTE $FF,$FF,$33,$00,$00,$CC,$FF,$FF
;  .BYTE $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
;  .BYTE $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
;  .BYTE $FF,$FF,$FF,$FF,$AA,$AA,$AA,$AA
;  .BYTE $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF

;; JIGS - need this too

  .BYTE $55,$55,$55,$55,$55,$FF,$FF,$FF
  .BYTE $F5,$F5,$F5,$05,$05,$FF,$FF,$FF
  .BYTE $FF,$FF,$FF,$00,$00,$FF,$FF,$FF
  .BYTE $FF,$FF,$FF,$00,$00,$FF,$FF,$FF
  .BYTE $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  .BYTE $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  .BYTE $FF,$FF,$FF,$FF,$FF,$AA,$AA,$AA
  .BYTE $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Shopkeeper image LUT  [$AC9C :: 0x3ACAC]
;;
;;    this is the 10x10 image that is drawn for the shopkeeper graphics
;;  in all shops.

lut_ShopkeepImage:

; .BYTE $00,$00,$00,$00,$00,$00,$00,$00,$00,$00
; .BYTE $00,$00,$00,$00,$00,$00,$00,$00,$00,$00
; .BYTE $00,$00,$00,$00,$01,$01,$00,$00,$00,$00
; .BYTE $04,$05,$00,$00,$01,$01,$00,$00,$00,$00
; .BYTE $06,$07,$08,$09,$01,$01,$00,$00,$00,$00
; .BYTE $04,$05,$0A,$0B,$01,$01,$00,$00,$00,$00
; .BYTE $06,$07,$0C,$0D,$01,$01,$00,$00,$00,$00
; .BYTE $04,$05,$00,$00,$01,$01,$00,$00,$00,$00
; .BYTE $06,$07,$00,$00,$01,$01,$00,$00,$00,$00
; .BYTE $00,$00,$00,$00,$02,$03,$00,$00,$00,$00

;; JIGS - with bigger boxes we need smaller graphics... lookit all those 0s! 

 .BYTE $04,$05,$01,$01
 .BYTE $06,$07,$01,$01
 .BYTE $08,$09,$01,$01
 .BYTE $0A,$0B,$01,$01
 .BYTE $0C,$0D,$01,$01
 .BYTE $00,$00,$01,$01
 .BYTE $04,$05,$01,$01
 .BYTE $06,$07,$02,$03

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Magic permissions LUT [$AD00 :: 0x3AD10]
;;
;;    Each class has an 8-byte LUT to indicate which spells
;;  he can learn.  There is also a pointer table that points
;;  to each of these LUTs, so the game can use the character's class
;;  as an index to find the start of the desired permissions table
;;
;;    Personally... that seems like a waste, since you can just multiply
;;  the class ID by 8 to get the offset of the permissions table.  If they
;;  were going to use a pointer table, they should've at least shared
;;  common permissions tables (ie:  have fighter, thief, BB, master all share
;;  the same table, since none of them can learn any spells).  But the games
;;  doesn't do that.  Oh well... whatever.
;;
;;    Anyway, in the permissions tables... each byte represents 8 spells.
;;  The first byte represents level 1 spells, next byte is level 2 spells,
;;  etc.  The high bit reprents the first spell on that level (ie:  white
;;  magic is the high 4 bits).  If the cooresponding bit is set... that means
;;  that class CANNOT cast that spell


   ; pointer table -- one entry for each class
lut_MagicPermisPtr:
  .WORD @FT, @TH, @BB, @RM, @WM, @BM
  .WORD @KN, @NJ, @MA, @RW, @WW, @BW

   ; each class's permission table.  8 bytes (64 spells) per table

 @FT: ;.BYTE $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
 @TH: ;.BYTE $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF ;; JIGS - now they share
 @BB: .BYTE $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
 @RM: .BYTE $50,$00,$50,$50,$76,$FF,$FF,$FF
 @WM: .BYTE $0F,$0F,$0F,$0F,$0F,$4F,$CF,$FF
 @BM: .BYTE $F0,$F0,$F0,$F0,$F2,$F0,$F6,$FF

 @KN: .BYTE $4F,$0F,$5F,$FF,$FF,$FF,$FF,$FF
 @NJ: .BYTE $F0,$F0,$F0,$F0,$FF,$FF,$FF,$FF
 @MA: .BYTE $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
 @RW: .BYTE $40,$00,$50,$40,$30,$87,$D7,$FF
 @WW: .BYTE $0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F
 @BW: .BYTE $F0,$F0,$F0,$F0,$F0,$F0,$F0,$F0

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  LUT for Menu palettes  [$AD78 :: 0x3AD88]
;;
;;    This is only for the 3 BG palettes that aren't loaded by LoadMenuCHRPal
;;  IE:  the 'lit orb' palette, and the two middles ones that are mirrors of the 4th
;;  palette.  The middle palettes are coded to be used by the Equip Menu in order to
;;  highlight some text, but due to some problems (not highlighting all the letters in the
;;  string) that functionality is removed by having those palettes unchanged.

lutMenuPalettes:
  .BYTE  $0F,$30,$01,$22,  $0F,$00,$01,$30,  $0F,$00,$01,$30



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Play SFX Menu Sel  [$AD84 :: 0x3AD94]
;;
;;    Plays the ugly sound effect you hear when a selection is made (or a deselection)
;;  ie:  most of the time when A or B is pressed in menus, this sound effect is played.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

PlaySFX_MenuSel:
;    LDA #%10111010   ; 50% duty, length disabed, decay disabed, volume=$A
;    STA $4004

;    LDA #%10111010   ; sweep pitch upwards at speed %011 with shift %010
;    STA $4005

;    LDA #$40         ; set starting pitch to F=$040
;    STA $4006
;    LDA #$00
;    STA $4007

;    LDA #$1F
;    STA sq2_sfx      ; indicate square 2 is busy with sfx for $1F frames
;    RTS              ;  and exit!

;; JIGS - uses the noise channel instead now. Pff! 

    LDA MuteSFXOption
    BNE @Done

    LDA #%00010100
    STA $400C
    
    LDA #%10001000
    STA $400F
    
    LDA #%00001010
    STA $400E

    @Done:
    RTS              ;  and exit!


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Play SFX  Menu Move  [$AD9D :: 0x3ADAD]
;;
;;    Plays the ugly sound effect you hear when you move the cursor inside of menus
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

PlaySFX_MenuMove:
;    LDA #%01111010   ; 25% duty, length counter disabled, decay disabled, volume=$A
;    STA $4004

;    LDA #%10011011   ; sweep pitch upwards at speed %001 with shift %011
;    STA $4005

;    LDA #$20
;    STA $4006        ; set starting pitch to F=$020
;    LSR A
;    STA $4007

;    STA sq2_sfx      ; indicate square 2 is playing a sound effect for $10 frames
;    RTS              ;  and exit!

    LDA MuteSFXOption
    BNE @Done

    LDA #%00000010
    STA $400C
    
    LDA #%01000000
    STA $400F
    
    LDA #$0
    STA $400E
    
    @Done:
    RTS              ;  and exit!
    
    
;; JIGS - optional heal SFX instead of the jingle
    
 PlayHealSFX:
 LDA MuteSFXOption
 BNE @Done
 
 LDA #%01000111 ; 
 STA $4004

 LDA #%11101010 ; 
 STA $4005

 LDA #%11110000 ; 
 STA $4006        
 LSR A
 LDA #%11000000
 STA $4007

 LDA #$20
 STA sq2_sfx      ; indicate square 2 is playing a sound effect for $20 frames
 
 @Done:
 RTS              ;  and exit!  
 
 
 PlaySFX_CharSwap:
    LDA MuteSFXOption
    BNE @Done
    
    LDA #%10111010   ; 50% duty, length disabed, decay disabed, volume=$A
    STA $4004

    LDA #%10111010   ; sweep pitch upwards at speed %011 with shift %010
    STA $4005

    LDA #$40         ; set starting pitch to F=$040
    STA $4006
    LDA #$00
    STA $4007

    LDA #$1F
    STA sq2_sfx      ; indicate square 2 is busy with sfx for $1F frames
    
    @Done:
    RTS              ;  and exit!

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Enter Main Menu  [$ADB3 :: 0x3ADC3]
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

EnterMainMenu:
    ;LDA #$51
    ;STA music_track     ; set music track $51 (menu music)
    ;JIGS - no resetting music here!
    
    LDA #0
    STA $2001           ; turn off the PPU (we need to do some drawing)     
    ;STA $4015           ; and silence the APU.  Music sill start next time MusicPlay is called.
    ;STA $5015           ; and silence the MMC5 APU. (JIGS)
    
    LDA #1
    STA MenuHush        ;; JIGS - mute music instead

    JSR LoadMenuCHRPal        ; load menu related CHR and palettes
    LDX #$0B
  @Loop:                      ; load a few other main menu related palettes
      LDA lutMenuPalettes, X  ; fetch the palette from the LUT
      STA cur_pal, X          ; and write it to the palette buffer
      DEX
      BPL @Loop               ; loop until X wraps ($0C colors copied)

;; ResumeMainMenu is called to redraw and reenter the main menu from other
;;  sub menus (like from the item menu).  This will redraw the main menu, but
;;  won't restart the music or reload CHR/Palettes like EnterMainMenu does

    LDA #BANK_THIS
    STA cur_bank          ; set cur_bank to this bank
    JSR CallMusicPlay     ;   so we can call music play routine
    ;;JIGS -- I feel like this smooths out the music a bit more when opening the menu? maybe not

ResumeMainMenu:
    LDA #0
    STA $2001                       ; turn off the PPU
    LDA #0
    STA menustall                   ; and disable menu stalling

    JSR DrawMainMenu                ; draw the main menu
    JSR TurnMenuScreenOn_ClearOAM   ; then clear OAM and turn the screen on

    LDA #0
    STA cursor                      ; flush cursor, joypad, and prev joy directions
    STA joy
    STA joy_prevdir

MainMenuResetCursorMax:    
    LDA mapflags            ; make sure we're on the overworld
    LSR A                   ;  Get SM flag, and shift it into C
    BCS @SetCursorMax5      ; if not on overworld, then don't let cursor touch save option
        LDA #6
        JMP :+
        
    @SetCursorMax5:    
    LDA #5                        ;; JIGS - set cursor max to 5
  : STA cursor_max                ; flow seamlessly into MainMenuLoop
                                    

MainMenuLoop:
    JSR ClearOAM                  ; clear OAM (erasing all existing sprites)
    JSR DrawMainMenuCursor        ; draw the cursor
    JSR DrawMainMenuCharSprites   ; draw the character sprites
    JSR MenuFrame                 ; Do a frame

    LDA joy_a                     ; check to see if A has been pressed
    BNE @A_Pressed
    LDA joy_b                     ; then see if B has been pressed
    BNE @B_Pressed
    LDA joy_select
    BNE @Select_Pressed
    
    JSR MoveCursorUpDown          ; then move the cursor up or down if up/down pressed
    JMP MainMenuLoop              ;  rinse, repeat
  
  @Select_Pressed:
    JSR LineUp_InMenu
    BCC EnterMainMenu
    JMP @EscapeSubTarget
    
  @B_Pressed:
    LDA #0            ; turn PPU off
    STA $2001
    STA joy_a         ; flush A, B, and Start joypad recordings
    STA joy_b
    STA joy_start
    STA joy_select
    JSR CallMusicPlay
    RTS               ; and exit the main menu (by RTSing out of its loop)
    ;JMP ExitMenu
    ;; JIGS - moved to bank F to simplify and make space

    ; if A pressed, we need to move into the appropriate sub menu based on 'cursor' (selected menu item)

  @A_Pressed:
    JSR PlaySFX_MenuSel         ; play the selection sound effect
    LDA cursor                  ; get the cursor
    BNE @NotItem                ; if zero.... (ITEM)

    @Item:
      JSR EnterItemMenu         ; enter item menu
      JMP ResumeMainMenu        ; then resume (redraw) main menu

  @NotItem:
    CMP #$01
    BNE @NotMagic               ; if cursor = 1... they selected 'magic'


    @MagicLoop:
      JSR MainMenuSubTarget     ; select a sub target
      BCS @EscapeSubTarget      ; if B pressed, they want to escape sub target menu.

      LDA cursor                ; otherwise (A pressed), get the selected character
      ROR A
      ROR A
      ROR A
      AND #$C0                  ; and shift it to a useable character index
      TAX                       ; and put in X

      LDA ch_ailments, X        ; get this character's OB ailments
      CMP #$01
      BEQ @CantUseMagic         ; if dead.. can't use their magic
      CMP #$02
      BNE @CanUseMagic          ; otherwise.. if they're not stone, you can

    @CantUseMagic:              ;if dead or stone...
      JSR PlaySFX_Error         ;  play error sound effect
      JMP @MagicLoop            ;  and continue magic loop until valid option selected

    @CanUseMagic:
      JSR EnterMagicMenu        ; if target is valid.. enter magic menu
      JMP ResumeMainMenu        ; then resume (redraw) main menu and continue

  @NotMagic:
    CMP #$02
    BNE @NotEquip              ; if cursor = 2... they selected 'Weapon'

    @Equip:
      JSR MainMenuSubTarget
      BCS @EscapeSubTarget
       LDA submenu_targ
       STA CharacterEquipBackup ; get target character ID
        ROR A
        ROR A
        ROR A
        AND #$C0                 ; shift to make ID a usable index
        STA CharacterIndexBackup 
        LDA #0
        STA equipoffset
      JSR EnterEquipMenu        ; and enter equip menu (Weapons menu)
      JMP ResumeMainMenu        ; then resume main menu

      ;; JIGS -- adding some options! 
    
  @NotEquip:                      ; otherwise (cursor=4)... they selected 'Status' (Now Options!)
    CMP #$03
    BNE @NotStatus
  
    @Status:
    JSR MainMenuSubTarget       ; select a sub target
    BCS @EscapeSubTarget        ;  if they escaped the sub target selection, then escape it
    JSR EnterStatusMenu         ; otherwise, enter Status menu
    JMP ResumeMainMenu          ; then resume (redraw) main menu

  @NotStatus:
    CMP #$04
    BNE @Save    
    
    @Options:
    LDA #0
    STA $2001               ; turn off the PPU
    STA menustall           ; disable menu stalling
    JSR ClearNT             ; clear the NT
    JSR LongCall
    .word OptionsMenu
    .byte $0F
    JMP ResumeMainMenu
        
   @Save:
    ;LDA mapflags            ; make sure we're on the overworld
    ;LSR A                   ;  Get SM flag, and shift it into C
    ;BCS @Rawr
        JSR SaveGame
        JMP EnterMainMenu
    ;@Rawr:
    ;JSR PlaySFX_Error        ; if can't use, play the error sound effect

@EscapeSubTarget:             ; if they escaped the sub target menu...
    LDA #0
    STA cursor                ; reset the cursor to zero
    ;LDA #6                     ; JIGS - originally #5
    ;STA cursor_max            ; and reset cursor_max to 5 (only 5 main menu options)
    ;JMP MainMenuLoop          ; then return to main menu loop
    JMP MainMenuResetCursorMax

    
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Main Menu Sub Target  [$AE71 :: 0x3AE81]
;;
;;    Gets the main menu sub target (ie:  gets the target for
;;  'Magic' and 'Status' main menu options
;;
;;  OUT:  C = set if B pressed (exited)
;;            clear if A pressed (selection made)
;;
;;        submenu_targ = desired target (only valid if A pressed)
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

MainMenuSubTarget:
    LDA #0              ; clear the cursor
    STA cursor
MainMenuSubTarget_NoClear:    
    LDA #4
    STA cursor_max

  @Loop:
    JSR ClearOAM                 ; clear OAM
    JSR DrawMainMenuCharSprites  ; draw the main menu battle sprite
    JSR DrawMainMenuSubCursor    ; draw the sub target cursor
    JSR MenuFrame                ; do a frame

    LDA joy_a
    BNE @A_Pressed               ; check if A pressed
    LDA joy_b
    BNE @B_Pressed               ; or B

    JSR MoveCursorUpDown ;MoveMainMenuSubCursor    ; if neither, move the cursor
    JMP @Loop                    ; and keep looping

  @B_Pressed:
    SEC            ; if B pressed, just SEC before exiting
    RTS            ;  to indicate failure / user escaped

  @A_Pressed:
    LDA cursor         ; if A pressed, record the submenu target
    STA submenu_targ
    CLC                ; then clear C to indicate a target has been selected
    RTS                ; and exit!



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Enter Magic Menu  [$AE97 :: 0x3AEA7]
;;
;;    The good old magic menu!
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

EnterMagicMenu:
    LDA #0
    STA $2001                      ; turn off PPU
    STA menustall                  ; clear menustall
    STA descboxopen                ; and mark description box as closed

    JSR ClearNT                    ; clear the nametable
    JSR DrawMagicMenuMainBox       ; draw the big box containing all the spells
    PHP                            ; C is set if char has no spells -- we'll use that later, so PHP for now

    LDA #$07
    JSR DrawMainItemBox            ; draw the character's name
    LDA #52 ; < JIGS < ; #$29
    JSR DrawCharMenuString         ; and draw the "MAGIC" title text
    JSR TurnMenuScreenOn_ClearOAM  ; clear OAM and turn the screen on

    PLP                            ; pull status to see if character has any spells
    BCC :+                         ; if not....
      JMP MenuWaitForBtn_SFX       ;    simply wait for a button press and exit

:   LDA #0                    ; otherwise.... (they have magic)
    STA joy                   ; clear joypad
    STA joy_prevdir           ; and previous joy directions

MagicMenu_Loop:
    JSR ClearOAM              ; clear OAM
    JSR DrawMagicMenuCursor   ; draw the cursor
    JSR MenuFrame             ; and do a frame

    LDA joy_a
    BNE @A_Pressed            ; check if A pressed
    LDA joy_b
    BNE @B_Pressed            ; and B

    JSR MoveMagicMenuCursor   ; otherwise, move the cursor if a direction was pressed
    JMP MagicMenu_Loop        ; and keep looping

  @B_Pressed:
    RTS                       ; if B pressed, just exit

  @A_Pressed:
    JSR PlaySFX_MenuSel         ; play the selection sound effect
    JSR UseMagic_GetRequiredMP  ; see if we have MP to cast selected spell
    BCS @HaveMP                 ; if so, skip ahead

      LDA #47 ; < JIGS < ; #$32                  ; otherwise...
      JSR DrawItemDescBox       ;  print "you don't have enough MP" or whatever message (description text ID=$32)
      JMP MagicMenu_Loop        ;  and return to loop

  @HaveMP:
    LDX cursor
    LDA TempSpellList, X
    CLC 
    ADC #MG_START-1
    

       ;  This is all a hardcoded mess.  Which I guess is fine because only a handful
       ; of spells can be cast outside of battle.  This code just checks the above calculated
       ; spell ID against every spell you can cast outside of battle, and jumps to that spell's
       ; routine where appropriate.


    CMP #MG_CURE             ; just keep CMPing with every spell you can cast out of battle
    BNE :+                   ;  until we find a match
      JMP UseMagic_CURE      ;  then jump to that spell's routine
:   CMP #MG_CUR2
    BNE :+
      JMP UseMagic_CUR2
:   CMP #MG_CUR3
    BNE :+
      JMP UseMagic_CUR3
:   CMP #MG_CUR4
    BNE :+
      JMP UseMagic_CUR4
:   CMP #MG_HEAL
    BNE :+
      JMP UseMagic_HEAL
:   CMP #MG_HEL3
    BNE :+
      JMP UseMagic_HEL3
:   CMP #MG_HEL2
    BNE :+
      JMP UseMagic_HEL2
:   CMP #MG_PURE
    BNE :+
      JMP UseMagic_PURE
:   CMP #MG_LIFE
    BNE :+
      JMP UseMagic_LIFE
:   CMP #MG_LIF2
    BNE :+
      JMP UseMagic_LIF2
:   CMP #MG_WARP
    BNE :+
      JMP UseMagic_WARP
:   CMP #MG_SOFT
    BNE :+
      JMP UseMagic_SOFT
:   CMP #MG_EXIT
    BNE :+
      JMP UseMagic_EXIT

:   LDA #48; < JIGS < ;#$33                ; gets here if no match found.
    JSR DrawItemDescBox     ; print description text ("can't cast that here")
    JMP MagicMenu_Loop      ; and return to magic loop

;;;;;;;;;;;;;;;

UseMagic_CURE:
    LDA framecounter        ; use the frame counter as a make-shift pRNG
    AND #$0F                ; mask out the low bits
    ORA #$10                ; and ORA (effective range:  16-31)
    BNE UseMagic_CureFamily ; and do the cure family of spells (always branches)

UseMagic_CUR2:
    LDA framecounter        ; same deal, but double the recovery
    AND #$1F
    ORA #$20                ; (effective range:  32-63)
    BNE UseMagic_CureFamily ; always branches

UseMagic_CUR3:
    LDA framecounter        ; same deal -- but double it again
    AND #$3F
    ORA #$40                ; (effective range:  64-127)
                            ; flow right into UseMagic_CureFamily

UseMagic_CureFamily:
    STA hp_recovery         ; store the HP to be recovered for future use
    JSR DrawItemTargetMenu  ; draw the item target menu (gotta choose who to target with this spell)
    LDA #40 ; < JIGS < ;#$2B
    JSR DrawItemDescBox     ; load up the relevent description text

 CureFamily_Loop:
    JSR ItemTargetMenuLoop  ; handle the item target menu loop
    BCS CureFamily_Exit     ; if they pressed B, just exit

    LDA cursor              ; otherwise... get cursor
    ROR A
    ROR A
    ROR A
    AND #$C0                ; shift it to get a usable index
    TAX                     ; and put in X

    LDA ch_ailments, X      ; get target's OB ailments
    CMP #$01
    BEQ CureFamily_CantUse  ; if dead... can't target
    CMP #$02
    BEQ CureFamily_CantUse  ; can't target if stone, either

    LDA hp_recovery         ; otherwise, we can target.  Get the HP to recover
    JSR MenuRecoverHP_Abs   ; and recover it
    JSR DrawItemTargetMenu  ; then redraw the target menu screen to reflect changes
    JSR UseMagic_SpendMP ; JIGS

    JSR MenuWaitForBtn_SFX  ; Then just wait for the player to press a button.  Then exit by re-entering magic menu

  CureFamily_Exit:
    JMP EnterMagicMenu      ; to exit, re-enter (redraw) magic menu

  CureFamily_CantUse:
    JSR PlaySFX_Error       ; if can't use, play the error sound effect
    JMP CureFamily_Loop     ; and loop until you get a proper target

;;;;;;;;;;;;;;

UseMagic_CUR4:
    JSR DrawItemTargetMenu  ; draw item target menu
    LDA #40 ; < JIGS < ;#$2B
    JSR DrawItemDescBox     ; and appropriate description text
    JSR ItemTargetMenuLoop  ; do the item target menu loop
    BCS CureFamily_Exit     ; if they pressed B to escape.. just exit

    LDA cursor              ; otherwise, get cursor (target character ID)
    ROR A
    ROR A
    ROR A
    AND #$C0                ; shift to get a usable charater index
    TAX                     ; and put in X

    LDA ch_maxhp+1, X       ; and copy max HP to cur HP
    STA ch_curhp+1, X       ; BUGGED:  game does not check ailments.  So you can cast
    LDA ch_maxhp, X         ;  this on a stoned or even a dead character!
    STA ch_curhp, X         ;  but while it will refill a dead character's HP, he will stay dead
                            ;  because he'll still have the "dead" ailment.

    JSR DrawItemTargetMenu  ; redraw target menu to reflect changes
    JSR UseMagic_SpendMP ; JIGS 

    JSR MenuWaitForBtn_SFX  ; then just wait for the player to press a button
    JMP EnterMagicMenu      ; and re-enter (redraw) the magic menu

;;;;;;;;;;;;;;

UseMagic_HEAL:
    LDA framecounter        ; use the framecounter as a makeshift pRNG
    AND #$07                ;  get low bits
    CLC
    ADC #$10                ; and ADD $10 (not ORA)  (effective range:  16-23)
    BNE UseMagic_HealFamily ; and do the heal family of spells (always branches)

UseMagic_HEL2:
    LDA framecounter        ; same deal as HEAL, only different number
    AND #$0F
    CLC
    ADC #$20                ; (effective range:  32-47)
    BNE UseMagic_HealFamily ; always branches

UseMagic_HEL3:
    LDA framecounter        ; same deal....
    AND #$1F
    CLC
    ADC #$40                ; (effective range:  64-95)
                            ; flow into UseMagic_HealFamily

UseMagic_HealFamily: 
    STA hp_recovery         ; store HP recovery for future use
    LDA #41 ; < JIGS < ;#$2C
    JSR DrawItemDescBox     ; draw the relevent description text
    JSR ClearOAM            ; clear OAM (no sprites)
    JSR MenuWaitForBtn      ; wait for the user to press a button

    LDA joy                 ; see whether the user pressed A or B
    AND #$80                ; check A
    BEQ HealFamily_Exit     ; if not A, they pressed B... so exit

    LDA hp_recovery         ; otherwise (pressed A), get HP recovery
    JSR MenuRecoverPartyHP  ; and give it to the entire party (also redraws the target menu for us)
    JSR UseMagic_SpendMP ; JIGS 
        
    JSR MenuWaitForBtn_SFX  ; then just wait for the player to press a button before exiting

 HealFamily_Exit:
    JMP EnterMagicMenu      ; to exit, just re-enter magic menu

;;;;;;;;;;;;;;;;;;;;;;;

UseMagic_LIFE:
    JSR DrawItemTargetMenu  ; draw the target menu
    LDA #43 ; < JIGS < ;#$2E
    JSR DrawItemDescBox     ; and relevent description text
  @Loop:
    JSR ItemTargetMenuLoop  ; do the target loop
    BCS HealFamily_Exit     ; if they pressed B to exit, exit (hijack the HealFamily exit, whynot)

    LDA #$01                ; mark the ailment-to-cure as "death" ($01)
    STA tmp                 ; put it in tmp for 'CureOBAilment' routine
    JSR CureOBAilment       ; attempt to cure death!
    BCS @CantUse            ; if the char didn't have the death ailment... can't use this spell on him

    LDA #1                  ; otherwise it worked.  Give them 1 HP now that they're alive
    STA ch_curhp, X

    JSR UseMagic_SpendMP ; JIGS 

    JSR DrawItemTargetMenu  ; redraw target menu to reflect changes
    JSR MenuWaitForBtn_SFX  ; then wait for the user to press a button
    JMP EnterMagicMenu      ; and exit by re-entering magic menu

  @CantUse:
    JSR PlaySFX_Error       ; if you can't use it, play the error sound
    JMP @Loop               ;  and loop!


UseMagic_LIF2:
    JSR DrawItemTargetMenu  ; Exactly the same as LIFE, except...
    LDA #43 ; < JIGS < ; #$2E
    JSR DrawItemDescBox
  @Loop:
    JSR ItemTargetMenuLoop
    BCS HealFamily_Exit

    LDA #$01
    STA tmp
    JSR CureOBAilment
    BCS @CantUse

    LDA ch_maxhp, X         ; refill their HP to max, instead of just giving them 1 HP
    STA ch_curhp, X
    LDA ch_maxhp+1, X
    STA ch_curhp+1, X

    JSR UseMagic_SpendMP ; JIGS 

    JSR DrawItemTargetMenu
    JSR MenuWaitForBtn_SFX
    JMP EnterMagicMenu

  @CantUse:
    JSR PlaySFX_Error
    JMP @Loop

UseMagic_PURE:
    JSR DrawItemTargetMenu  ; Exactly the same as LIFE, except...
    LDA #42 ; < JIGS < ;#$2D
    JSR DrawItemDescBox     ; different description text
  UseMagic_PURE_Loop:
    JSR ItemTargetMenuLoop
    BCS UseMagic_PURE_Exit

    LDA #04                     ; JIGS - cure "poison" ailment instead of "death"
    STA tmp
    JSR CureOBAilment
    BCS UseMagic_PURE_CantUse

    JSR UseMagic_SpendMP ; JIGS 
    
    JSR DrawItemTargetMenu
    JSR MenuWaitForBtn_SFX

 UseMagic_PURE_Exit:
    JMP EnterMagicMenu

 UseMagic_PURE_CantUse:
    JSR PlaySFX_Error
    JMP UseMagic_PURE_Loop

UseMagic_SOFT:
    JSR DrawItemTargetMenu     ; again... more of the same
    LDA #45 ; < JIGS < ; #$30
    JSR DrawItemDescBox        ; but different description text
  @Loop:
    JSR ItemTargetMenuLoop
    BCS UseMagic_PURE_Exit
    LDA #$02                   ; and cure stone instead of death or poison
    STA tmp
    JSR CureOBAilment
    BCS @CantUse
    JSR UseMagic_SpendMP ; JIGS 
    
    JSR DrawItemTargetMenu
    JSR MenuWaitForBtn_SFX
    JMP EnterMagicMenu
  @CantUse:
    JSR PlaySFX_Error
    JMP @Loop


;;;;;;;;;;;;;;;;;;;;;;;

UseMagic_WARP:
    LDA #44 ; < JIGS < ; #$2F
    JSR DrawItemDescBox       ; draw description text
    JSR UseMagic_SpendMP ; JIGS 
    
    JSR MenuWaitForBtn_SFX    ; wait for a button press

    TSX                  ; get the stack pointer
    TXA                  ; and put it in A
    CMP #$FF - 16        ; check the stack pointer to see if at least 16 bytes have been pushed
    BCS UseMagic_DoEXIT  ;  if not, WARP would have the same effect as EXIT, so just jump to EXIT code

    CLC                  ; otherwise, we're to go back one floor
    ADC #6               ;   so add 6 to the stack pointer (kills the last 3 JSRs)
    TAX                  ;   which would be:  JSR to Magic Menu
    TXS                  ;                    JSR to Main Menu
                         ;                and JSR to Standard Map loop
    LDA #0               ; turn off PPU and APU
    STA $2001
    STA $4015

    RTS                  ; and RTS.  See notes below

UseMagic_EXIT:
    LDA #46 ; < JIGS < ;#$31
    JSR DrawItemDescBox       ; draw description text
    JSR UseMagic_SpendMP ; JIGS 
    
    JSR MenuWaitForBtn_SFX    ; wait for button press

  UseMagic_DoEXIT:
    JMP DoOverworld           ; then restart logic on overworld by JMPing to DoOverworld

;  Notes regarding WARP/EXIT:
;
;    The Overword loop wipes the stack clean, so it is effectively the "top" of all game
;  logic execution.  When you JMP to DoOverworld (as EXIT does), the end result is that
;  all warp chain data (which exists on the stack) is cleared, and you find yourself
;  back on the overworld map, at the same coords you were when you left.
;
;    WARP is a bit trickier.  When you teleport between maps, each non-warp and non-exit
;  teleport pushes 5 bytes of data to the stack (coords, map, etc).  This data is used
;  by the game to restore you to the map and coords you were previously at if you cast WARP
;  or step on a warp-style teleport tile.  In addition to this 5 bytes of data, the game recursively
;  JSRs to the Standard Map loop, resulting in a 7 byte stack increase.  (see @NormalTeleport
;  local label inside of StandardMapLoop)
;
;    To perform a WARP, all the game has to do is escape the most recent JSR to the standard map code.
;  once this is accomplished, the returning code in StandardMapLoop will pull the old position
;  off the stack and all that good stuff, just as if the player had stepped on a warp-style
;  teleport.
;
;    To escape mentioned JSR, the WARP code above simply adds 6 to the stack pointer, which
;  has the same effect as 6 PLAs (drops the last 6 bytes on the stack).  This escapes the last 3
;  JSRs, which escapes all the menus and exits the most recent call to DoStandardMap, resulting in
;  the WARP.

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  UseMagic_GetRequiredMP  [$B102 :: 0x3B112]
;;
;;     Calculate which level of MP the selected spell uses, and
;;  determines whether or not the character has MP on that level
;;
;;  OUT:  mp_required = index to level's MP (from ch_magicdata -- not ch_curmp like you might expect)
;;                  C = set if character has MP.  Cleared if they don't
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

UseMagic_GetRequiredMP:
;; JIGS - new version:

    LDX cursor             ; spell in TempSpellList
    LDA BigSpellLevel_LUT, X  
    CLC
    ADC CharacterIndexBackup
    ADC #ch_mp - ch_stats
    TAX
    STA mp_required
    LDA ch_stats, X
    AND #$F0   ; clear low bits to get current mp
    CMP #1
    RTS
    
BigSpellLevel_LUT: 
.byte $00,$00,$00
.byte $01,$01,$01
.byte $02,$02,$02
.byte $03,$03,$03
.byte $04,$04,$04
.byte $05,$05,$05
.byte $06,$06,$06
.byte $07,$07,$07
.byte $08,$08,$08

UseMagic_SpendMP:
    LDX mp_required
    LDA ch_stats, X
    SEC
    SBC #$10
    STA ch_stats, X
    RTS 




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Enter Item Menu  [$B11D :: 0x3B12D]
;;
;;    Pretty self explanitory.  Enters the item menu, returns when player
;;  exits item menu
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


EnterItemMenu:
    LDA #0
    STA $2001           ; turn the PPU off
    STA menustall       ; zero menustall (don't want to stall for drawing the screen for the first time)
    STA descboxopen     ; indicate that the descbox is closed
    JSR ClearNT         ; wipe the NT clean
                        ;  then start drawing the item menu

;; ResumeItemMenu is jumped to to refresh the item box (like after you use a key item and it disappears)
ResumeItemMenu:
    JSR DrawItemBox        ; Draw the item box
    PHP                    ; C will be set if there was no inventory -- push it to stack for use later

    ;LDA #$03
    ;; JIGS - moved to inside DRawItemTitleBox
    
    JSR DrawItemTitleBox           ; draw the "ITEM" title box
    JSR TurnMenuScreenOn_ClearOAM  ; clear OAM and turn the screen on

    PLP                    ; pull the previously pushed C (C set if no inventory)
    BCC :+                 ; if the player has no inventory...
      LDA #03 ; < JIGS < ;#$04
      JSR DrawItemDescBox     ; draw the "You have nothing" description text
      JMP MenuWaitForBtn_SFX  ; then just wait for A or B to be pressed -- then exit

    ; otherwise (player has at least 1 item in inventory)
:   LDA #0
    STA cursor         ; clear the current cursor position       
    STA joy            ; clear joy data
    STA joy_prevdir    ; and previous joy directionals

ItemMenu_Loop:
    JSR ClearOAM            ; clear OAM
    JSR DrawItemMenuCursor  ; draw the cursor where it needs to be
    JSR MenuFrame           ; do a frame

    LDA joy_a               ; see if A has been pressed
    BNE @APressed           ; if it has... jump ahead
    CMP joy_b               ; otherwise check for B
    BNE @Exit               ; and exit if B pressed
    JSR MoveItemMenuCurs    ; neither button pressed... so move cursor if a direction was pressed
    JMP ItemMenu_Loop       ; then continue the loop

  @Exit:
    RTS

  @APressed:
    JSR PlaySFX_MenuSel        ; play the menu selection sound effect
    LDX cursor                 ; put the cursor in X
    LDA item_box, X            ; get the selected item, and put it in A
    ASL A                      ; double it (2 bytes per pointer)
    TAX                        ;   and stick it in X
    LDA @ItemJumpTable, X      ; load the address to jump to from our jump table
    STA tmp                    ; and put it in (tmp)
    LDA @ItemJumpTable+1, X
    STA tmp+1
    JMP (tmp)                  ; then jump to it!

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  [$B177 :: 0x3B187]
;;
;;  Each item has its own entry in this jump table.  When that item is selected,
;;    its routine gets jumped to.
;;
;;  Note this is still sort of part of ItemMenu_Loop... kinda
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

 @ItemJumpTable:

 ;; JIGS - this also re-organizes items

.word UseItem_Bad       ; Item Start
.word UseItem_Heal      ; 
.word UseItem_Pure      ; 
.word UseItem_Soft      ; 
.word UseItem_Tent      ; 
.word UseItem_Cabin     ; 
.word UseItem_House     ; 
.word UseItem_Lute      ; 
.word UseItem_Crown     ; 
.word UseItem_Crystal   ; 
.word UseItem_Herb      ; 
.word UseItem_Key       ; 
.word UseItem_TNT       ; 
.word UseItem_Adamant   ; 
.word UseItem_Slab      ; 
.word UseItem_Ruby      ; 
.word UseItem_Rod       ; 
.word UseItem_Floater   ; 
.word UseItem_Chime     ; 
.word UseItem_Tail      ; 
.word UseItem_Cube      ; 
.word UseItem_Bottle    ;   
.word UseItem_Oxyale    ; 
.word UseItem_Canoe     ; 
.word UseItem_Bad       ; Fire Orb
.word UseItem_Bad       ; Water Orb
.word UseItem_Bad       ; Air Orb
.word UseItem_Bad       ; Earth Orb
.word UseItem_Bad       ; Item Stop
.word UseItem_Bad       ; ??



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  [$B1B3 :: 0x3B1C3]
;;
;;  Following the item jump table is all the routines jumped to!  The first few are simplistic
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

    ; called for invalid item IDs (should never be called -- just sort of a safety catch)
UseItem_Bad:
  JMP ItemMenu_Loop   ; just jump back to the item loop


    ; called when the CROWN is selected
UseItem_Crown:
    LDA #$07      ; select description text "The stolen CROWN"
                  ; seamlessly flow into UseItem_SetDesc

    ; Jumped to by items that just print a simple description
UseItem_SetDesc:
    JSR DrawItemDescBox    ; draw the description box with given description (in A)
    JMP ItemMenu_Loop      ;  then return to the item loop


;; JIGS - fixed this up some

UseItem_Crystal:  LDABRA $07, UseItem_SetDesc ; 07
UseItem_Herb:     LDABRA $08, UseItem_SetDesc ; 08
UseItem_Key:      LDABRA $09, UseItem_SetDesc ; 09
UseItem_TNT:      LDABRA $0A, UseItem_SetDesc ; 10
UseItem_Adamant:  LDABRA $0B, UseItem_SetDesc ; 11
UseItem_Slab:     LDABRA $0C, UseItem_SetDesc ; 12
UseItem_Ruby:     LDABRA $0D, UseItem_SetDesc ; 13

UseItem_Chime:    LDABRA $12, UseItem_SetDesc ; 18
UseItem_Tail:     LDABRA $13, UseItem_SetDesc ; 19
UseItem_Cube:     LDABRA $14, UseItem_SetDesc ; 20

UseItem_Oxyale:   LDABRA $17, UseItem_SetDesc ; 23
UseItem_Canoe:    LDABRA $18, UseItem_SetDesc ; 24


;;;;;;;;;;;;;;;;;;;;;
;;
;;  UseItem_Bottle  [$B1EE :: 0x3B1FE]
;;
;;;;;;;;;;;;;;;;;;;;;

UseItem_Bottle:
    LDA game_flags + OBJID_FAIRY    ; check the fairy object's state (to see if bottle has been opened already)
    LSR A                           ; move flag into C
    BCC @OpenBottle                 ; if flag is clear... fairy isn't visible, so bottle hasn't been opened yet.  Otherwise...
      LDA #22 ; < JIGS < ;#$17                      ; Draw "It is empty" description text
      JSR DrawItemDescBox
      JMP ItemMenu_Loop             ;  and return to the item loop

@OpenBottle:                        ; if the bottle hasn't been opened yet
    LDA #0
    STA item_bottle                 ; remove the bottle from inventory
    LDY #OBJID_FAIRY
    JSR LongCall
    .word ShowMapObject
    .byte $10        
    ;JSR ShowMapObject               ; mark the fairy object as visible
    LDA #21 ; < JIGS < ;#$16                        ; Draw "Pop... a fiary pops out" etc description text
    JSR DrawItemDescBox_Fanfare     ;   with fanfare!
    JMP ResumeItemMenu              ; Then RESUME item menu (redraw the item list -- now that the bottle isn't there)

;;;;;;;;;;;;;;;;;;;;;
;;
;;  UseItem_Rod  [$B20E :: 0x3B21E]
;;
;;;;;;;;;;;;;;;;;;;;;

UseItem_Rod:
    LDA mapflags        ; see if we're on the overworld
    LSR A               ;  put SM flag in C (C will be clear if on overworld)
    BCC @CantUse        ;  if on overworld, can't use the Rod here

    LDA tileprop_now          ; get the properties of the tile we're stepping on
    AND #TP_SPEC_MASK         ; mask out the 'special' bits
    CMP #TP_SPEC_USEROD       ; see if the special bits mark this tile as a "use rod" tile
    BNE @CantUse              ; if not... can't use the rod here

    LDY #OBJID_RODPLATE       ; check the rod plate object, to see if
    LDA game_flags, Y         ;   the rod has been used yet
    LSR A                     ;   shift that flag into C
    BCC @CantUse              ;   if clear, plate is gone, so Rod has already been used.. can't use the Rod again

    JSR LongCall
    .word HideMapObject
    .byte $10    
    ;HideMapObject           ; otherwise.. first time rod is being used.  Hide the rod plate
    LDA #14 ; < JIGS < ;#$0F                    ;  load up the relevent description text
    JSR DrawItemDescBox_Fanfare ;  and draw it with fanfare!
    JMP ItemMenu_Loop           ; then return to item loop

  @CantUse:
    LDA #15 ; < JIGS < ;#$10                  ; if you can't use the Rod here, just load up
    JSR DrawItemDescBox       ;   the generic description text
    JMP ItemMenu_Loop         ; and return to the item loop


;;;;;;;;;;;;;;;;;;;;
;;
;;  UseItem_Lute  [$B236 :: 0x3B246]
;;
;;;;;;;;;;;;;;;;;;;;

UseItem_Lute:
    LDA mapflags        ; see if we're on the overworld
    LSR A               ;  move SM flag into C
    BCC @CantUse        ;  if SM flag clear (on overworld), can't use the Lute here

    LDA tileprop_now            ; get the special properties  of the tile we're stepping on
    AND #TP_SPEC_MASK           ;  mask out 'special' bits
    CMP #TP_SPEC_USELUTE        ;  see if this tile is marked as "use lute"
    BNE @CantUse                ; if not... can't use

    LDY #OBJID_LUTEPLATE        ; check the lute plate object, to see if
    LDA game_flags, Y           ;   the lute has been used yet
    LSR A                       ;   shift the flag into C
    BCC @CantUse                ;   if clear, lute plate is gone, so lute was already used.  Can't use it again

    ASL A                       ; completely pointless shift (undoes above LSR, but has no real effect)
    JSR LongCall
    .word HideMapObject
    .byte $10    
    ;JSR HideMapObject           ; hide the lute plate object
    LDA #04 ; < JIGS < ; #$05                    ; get relevent description text
    JSR DrawItemDescBox_Fanfare ;  and draw it ... WITH FANFARE!
    JMP ItemMenu_Loop           ; then return to item loop

  @CantUse:
    LDA #05 ; < JIGS < ; #$06                    ; if you can't use the lute here, just
    JSR DrawItemDescBox         ;  load up generic description text
    JMP ItemMenu_Loop           ; and return to item loop


;;;;;;;;;;;;;;;;;;;;
;;
;;  UseItem_Floater  [$B25F :: 0x3B26F]
;;
;;;;;;;;;;;;;;;;;;;;

UseItem_Floater:
    LDA mapflags         ; see if we're on the overworld
    LSR A                ;  move SM flag into C
    BCS @CantUse         ;  if SM flag set (in standard map -- not overworld), can't use floater here

    LDA tileprop_now        ; get the special properties of the tile you're standing on
    AND #OWTP_SPEC_MASK     ;  mask out the 'special' bits
    CMP #OWTP_SPEC_FLOATER  ;  is tile marked to allow floater?
    BNE @CantUse            ; if not, can't use it here

    LDA airship_vis         ; check current airship visibility state
    BNE @CantUse            ;  if it's nonzero, airship is already raised.  Can't raise it again

    INC airship_vis             ; otherwise... increment airship visibility (= $01)
    LDA #16 ; < JIGS < ; #$11                    ; load up the "omg you raised the airship" description text
    JSR DrawItemDescBox_Fanfare ;   and draw it with fanfare
    JMP ItemMenu_Loop           ; then return to item loop

  @CantUse:
    LDA #17 ; < JIGS < ; #$12
    JSR DrawItemDescBox     ; can't use... so just draw lame description text
    JMP ItemMenu_Loop       ;  and return to loop


;;;;;;;;;;;;;;;;;;;;
;;
;;  UseItem_Tent  [$B284 :: 0x3B294]
;;
;;;;;;;;;;;;;;;;;;;;

UseItem_Tent:
    LDA mapflags            ; ensure we're on the overworld
    LSR A                   ;  shift SM flag into C
    BCS @CantUse            ;  if set (in standard map), can't use tent here

    DEC item_tent           ; otherwise... remove 1 tent from the inventory
    LDA #30
    JSR MenuRecoverPartyHP  ; give 30 HP to the whole party
    LDA #25 ; < JIGS < ; #$1A
    JSR MenuSaveConfirm     ; and bring up confirm save screen (with description text $1A)
    JMP EnterItemMenu       ; then re-enter item menu (need to re-enter, because screen needs full redrawing)

  @CantUse:
    LDA #26 ; < JIGS < ; #$1B                ; if we can't use, just print description text
    JSR DrawItemDescBox
    JMP ItemMenu_Loop       ; and return to loop

;;;;;;;;;;;;;;;;;;;;
;;
;;  UseItem_Cabin  [$B2A1 :: 0x3B2B1]
;;
;;;;;;;;;;;;;;;;;;;;

UseItem_Cabin:
    LDA mapflags            ; exactly the same as tents... except....
    LSR A
    BCS @CantUse
    DEC item_cabin          ; remove cabins from inventory instead of tents
    LDA #60                 ;  recover 60 HP instead of 30
    JSR MenuRecoverPartyHP
    LDA #25 ; < JIGS uses same as tent, originally #27 < ; #$1C                ; and use different description strings
    JSR MenuSaveConfirm
    JMP EnterItemMenu
  @CantUse:
    LDA #28 ; < JIGS < ; #$1D                ; another different description string
    JSR DrawItemDescBox
    JMP ItemMenu_Loop

;;;;;;;;;;;;;;;;;;;;
;;
;;  UseItem_House  [$B2BE :: 0x3B2CE]
;;
;;;;;;;;;;;;;;;;;;;;

UseItem_House:
    LDA mapflags            ; make sure we're on the overworld
    LSR A                   ;  Get SM flag, and shift it into C
    BCS @CantUse            ;  if set (not on overworld), can't use house here

    DEC item_house          ; otherwise... remove a house from our inventory
    LDA #120
    JSR MenuRecoverPartyHP  ; give the whole party 120 HP
    JSR MenuRecoverPartyMP  ; JIGS - recover MP before saving
    
    LDA #29 ; < JIGS < ; #$1E
    JSR MenuSaveConfirm     ; bring up the save confirmation screen.  (description text $1E)
:   JMP EnterItemMenu         ; then, whether they saved or not, re-enter item menu

  @CantUse:
    LDA #30 ; < JIGS < ; #$1F
    JSR DrawItemDescBox     ; if you can't use the house... just print description text ($1F)
    JMP ItemMenu_Loop       ; and return to loop


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Menu Save Confirmation  [$B2E0 :: 0x3B2F0]
;;
;;    Draws the item description box with given string ID (in A)
;;  then waits for the user to press A or B.  If A is pressed, the game is
;;  saved.
;;
;;  IN:   A = ID of description string to draw
;;
;;  OUT:  C = set if game was saved
;;            clear if game was not saved
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

MenuSaveConfirm:
    JSR DrawItemDescBox       ; draw the description box
    JSR ClearOAM              ; clear OAM
    JSR MenuWaitForBtn        ; then wait for player to press A or B

    LDA joy                   ; see if they pressed A or B
    AND #$80                  ;  check the 'A' bit
    BNE :+                    ; if they didn't press A...
      JSR CloseDescBox         ;  close the description box
      CLC                      ;  CLC to indicate they did not save
      RTS                      ;  and exit

:   LDA #56 ; < JIGS < ; #$3F                  ; draw description box with text ID $3F
    JSR DrawItemDescBox       ; "your gave is being saved" or whatever
    JSR SaveGame              ; save the game
    LDA #0
    STA $2001
    JMP LoadMenuCHRPal
    ;RTS                       ;  and exiting


;;;;;;;;;;;;;;;;;;;;
;;
;;  UseItem_Heal  [$B301 :: 0x3B311]
;;
;;    Back to UseItem routines
;;
;;;;;;;;;;;;;;;;;;;;

  ;; can't make these labels local because UseItem_Pure hijacks one of the labels ;_;

UseItem_Heal:
    JSR DrawItemTargetMenu     ; Draw the item target menu (need to know who to use this heal potion on)
    LDA #31 ; < JIGS < ; #$20
    JSR DrawItemDescBox        ; open up the description box with text ID $20

  _UseItem_Heal_Loop:
    JSR ItemTargetMenuLoop     ; run the item target loop.
    BCS UseItem_Exit           ; if B was pressed (C set), exit this menu

    LDA cursor                 ; otherwise... A was pressed.
    ROR A                      ;  get the cursor (target character)
    ROR A                      ;  left shift by 6 (make char index:  $40, $80, $C0)
    ROR A
    AND #$C0                   ; mask out relevent bits
    TAX                        ; and put in X

    LDA ch_ailments, X         ; check their OB ailments
    CMP #$01
    BEQ _UseItem_Heal_CantUse  ; if dead... can't use
    CMP #$02
    BEQ _UseItem_Heal_CantUse  ; if stone... can't use

    LDA #30                    ; otherwise.. can use!
    JSR MenuRecoverHP_Abs      ;   recover 30 HP for target (index is still in X).  Can use _Abs version
    JSR DrawItemTargetMenu     ;   because we already checked the ailments
    JSR MenuWaitForBtn_SFX     ; then redraw the menu to reflect the HP change, and wait for the user to press a button

    DEC item_heal              ; then remove a heal potion from the inventory

UseItem_Exit:
    JMP EnterItemMenu          ; re-enter item menu (item menu needs to be redrawn)

  _UseItem_Heal_CantUse:       ; can't make this local because of stupid UseItem_Pure hijacking the above label
    JSR PlaySFX_Error          ; play the error sound effect
    JMP _UseItem_Heal_Loop     ; and keep looping until they select a legal target or escape with B

;;;;;;;;;;;;;;;;;;;;
;;
;;  UseItem_Pure  [$B338 :: 0x3B348]
;;
;;;;;;;;;;;;;;;;;;;;

UseItem_Pure:
    JSR DrawItemTargetMenu     ; draw target menu
    LDA #32 ; < JIGS < ; #$21
    JSR DrawItemDescBox        ; print relevent description text (ID=$21)
  @Loop:
    JSR ItemTargetMenuLoop     ; do the target menu loop
    BCS UseItem_Exit           ; if they pressed B (C set), exit

    LDA #04                    ; otherwise, put "poison" OB ailment
    STA tmp                    ;   in tmp as our ailment to cure
    JSR CureOBAilment          ; then try to cure it
    BCS @CantUse               ; if we couldn't... can't use this item

    DEC item_pure              ; if we could... remove one from the inventory
    JSR DrawItemTargetMenu     ; redraw the target menu to reflect the changes
    JSR MenuWaitForBtn_SFX     ; then wait for the player to press a button
    JMP EnterItemMenu          ; before re-entering the item menu (redrawing item menu)

  @CantUse:
    JSR PlaySFX_Error          ; if can't use... give the error sound effect
    JMP @Loop                  ;  and keep looping

;;;;;;;;;;;;;;;;;;;;
;;
;;  UseItem_Soft  [$B360 :: 0x3B370]
;;
;;;;;;;;;;;;;;;;;;;;

UseItem_Soft:
    JSR DrawItemTargetMenu     ; this is all EXACTLY the same as UseItem_Pure.  Except...
    LDA #33 ; < JIGS < ; #$22
    JSR DrawItemDescBox        ; different description text ID
  @Loop:
    JSR ItemTargetMenuLoop
    BCS UseItem_Exit

    LDA #$02                   ; cure "stone" ailment
    STA tmp
    JSR CureOBAilment
    BCS @CantUse

    DEC item_soft              ; remove soft from inventory
    JSR DrawItemTargetMenu
    JSR MenuWaitForBtn_SFX
    JMP EnterItemMenu

  @CantUse:
    JSR PlaySFX_Error
    JMP @Loop


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Conditially cure OB Ailment  [$B388 :: 0x3B398]
;;
;;    Checks a character's OB ailment.  See if it matches the given
;;  ailment.  If it does, it cures the ailment, otherwise it doesn't
;;
;;  IN:  cursor = ID (0,1,2,3) of the character to check
;;          tmp = ailment to cure
;;
;;  OUT:      X = char index to target
;;            C = set on failure (ailment not cured)
;;                clear on success (ailment cured)
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

CureOBAilment:
    LDA cursor            ; get cursor (desired character)
    ROR A                 ; shift to get usable character index ($00,$40,$80,$C0)
    ROR A
    ROR A
    AND #$C0              ; and mask relevant bits
    TAX                   ; then stuff in X
    LDA ch_ailments, X    ; get OB ailments
    CMP tmp               ; compare to given ailment
    BEQ @Success          ; if they match.. success!
    SEC                   ;  otherwise... failure.  SEC to indicate failure
    RTS                   ;   and exit

@Success:
    LDA #$00              ; clear the character's OB Ailment (curing them)
    STA ch_ailments, X
    CLC                   ; CLC to indicate success
    RTS                   ; and exit

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  ItemTargetMenuLoop    [$B3A0 :: 0x3B3B0]
;;
;;     Runs the Item Target Menu loop.  Let's the player move the cursor between
;;  the 4 characters to select a target, and looks for A and B button presses.
;;
;;  OUT:  C = cleared if A pressed
;;            set if B pressed
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

ItemTargetMenuLoop:
    LDA #0
    STA cursor      ; reset the cursor to zero
  @Loop:
    LDA #0
    STA joy_a       ; clear joy_a and joy_b so that a button press
    STA joy_b       ;  will be recognized

    JSR ClearOAM               ; clear OAM
    JSR DrawItemTargetCursor   ; draw the cursor for this menu
    JSR MenuFrame              ; do a frame

    LDA joy_a
    BNE @A_Pressed     ; check to see if they pressed A
    LDA joy_b
    BNE @B_Pressed     ; or B

    LDA joy            ; get joy data
    ;JIGS - changing the left/right to up/down
    AND #$0C
    
    CMP joy_prevdir    ; compare it to the prev pressed buttons (to see if buttons are pressed or held)
    BEQ @Loop          ; if they match... no new button presses.  Keep looping.

    STA joy_prevdir    ; otherwise... record the change
    CMP #0             ; see if this was a release
    BEQ @Loop          ; if it was, no button press... keep looping

    CMP #$04            ; otherwise.. they just pressed left or right...
    ;; JIGS - up/down change
    BNE @Left          ;  see which they pressed

  @Right:
    LDA cursor         ; get cursor
    CLC                ;  and add 1 (move it to the right)
    ADC #$01
    JMP @MoveCurs      ; skip over the @Left block

  @Left:
    LDA cursor         ; get cursor
    SEC                ;  and subtract 1 (move it to the left)
    SBC #$01

  @MoveCurs:
    AND #$03               ; whether we moved left or right, AND with 3 to effectively wrap the cursor
    STA cursor             ;  and keep it in bounds.  Then write it back to the 'cursor' var
    JSR PlaySFX_MenuMove   ; Play the "move" sound effect
    JMP @Loop              ; and continue looping

  @A_Pressed:              ; if A was pressed
    JSR PlaySFX_MenuSel    ;  play the selection sound effect
    CLC                    ;  clear carry to indicate A pressed
    RTS                    ;  and exit

  @B_Pressed:              ; if B pressed
    JSR PlaySFX_MenuSel    ;  play selection sound effect
    SEC                    ;  and set carry before exiting
    RTS

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Draw Item Target Cursor  [$B3EE :: 0x3B3FE]
;;
;;     Draws the cursor for the item target menu
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


DrawItemTargetCursor:
    ;; JIGS - gotta flip it on the side

    LDX cursor           ; put the cursor in X
    LDA @lut, X          ; use it to index our LUT
    STA spr_y            ; that lut is the X coord for cursor
    LDA #$30
    STA spr_x            ; Y coord is always $68
    JMP DrawCursor       ; draw it, and exit

  @lut:
    .BYTE $40,$58,$70,$88


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Draw Item Target Menu  [$B400 :: 0x3B410]
;;
;;    Draws the item target menu (the menu that pops up when you select a heal potion
;;  and that kind of thing -- where you select who you want to use it on)
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

DrawItemTargetMenu:
    LDA #0
    STA $2001            ; turn the PPU off
    STA menustall        ; and disable menu stalling
    JSR ClearNT          ; wipe the NT clean

    ;; JIGS - new box size
    
    LDA #$06 
    STA box_y
    LDA #$05 
    STA box_x
    LDA #$16 
    STA box_wd
    LDA #$0E 
    STA box_ht
    JSR DrawBox    

    JSR @DrawBoxBody                ; draw the box body
    JMP TurnMenuScreenOn_ClearOAM   ; then clear OAM and turn the screen back on.  then exit

    RTS     ; useless RTS -- impossible to reach


   ;; JIGS - Really simplified this, I feel!  
   
    @DrawBoxBody:
    LDA #$08
    STA dest_x
    STA dest_y

    @DrawString:
    LDA #<lut_str_pointertable
    STA text_ptr              
    LDA #>lut_str_pointertable
    STA text_ptr+1
    JMP DrawMenuComplexString   
    
  lut_str_pointertable: 
  .byte $10,$00,$FF,$10,$02,$FF,$10,$05,$7A,$10,$06,$01,$05
  .byte $11,$00,$FF,$11,$02,$FF,$11,$05,$7A,$11,$06,$01,$05
  .byte $12,$00,$FF,$12,$02,$FF,$12,$05,$7A,$12,$06,$01,$05
  .byte $13,$00,$FF,$13,$02,$FF,$13,$05,$7A,$13,$06,$00    
    



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  EnterStatusMenu    [$B4AD :: 0x3B4BD]
;;
;;    Just draws the status screen, then waits for the user to press a button
;;  before exiting
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


EnterStatusMenu:
    LDA #0
    STA $2001               ; turn off the PPU
    LDA #0
    STA menustall           ; disable menu stalling
    JSR ClearNT             ; clear the NT

    LDX #4*4                ; draw status box 0
    JSR DrawMenuBox
    LDA #36
    INC dest_x
    JSR DrawCharMenuString

    LDX #5*4                ; and so on
    JSR DrawMenuBox
    LDA #37
    INC dest_x
    JSR DrawCharMenuString
    
    LDX #6*4                ; and so on
    JSR DrawMenuBox
    LDA #38
    INC dest_x
    JSR DrawCharMenuString
    
    
    JSR ClearOAM            ; clear OAM

    LDA #$A0
    STA spr_x
    LDA #$20
    STA spr_y

    LDA submenu_targ        ; get target character ID
    ROR A
    ROR A
    ROR A
    AND #$C0                ; shift to make ID a usable index
    
    STA CharacterIndexBackup ;; JIGS - adding this
    
    JSR DrawOBSprite        ; then draw this character's OB sprite

    JSR TurnMenuScreenOn    ; turn the screen on
   @Loop:  
    JSR MenuFrame
    JSR MoveCursorLeftRight
    
    LDA joy_a
    ORA joy_b
    BEQ @Loop                     ; check if A pressed    
    RTS     



  
MoveCursorLeftRight:
    LDA joy            ; get joy data
    AND #$0F           ; isolate directional buttons
    CMP joy_prevdir    ; see if there were changes
    BEQ @Exit          ; if not, exit

    STA joy_prevdir    ; otherwise, record changes
    CMP #0             ; see if buttons are being pressed
    BEQ @Exit          ; if not, exit

    CMP #$01               ; otherwise, check for left/right
    BNE @Left
    
  @Right:
    LDA submenu_targ
    CLC
    ADC #$01
    JMP :+

  @Left:
    LDA submenu_targ
    SEC
    SBC #$01
  : AND #$03
    STA submenu_targ
    PLA
    PLA
    JMP EnterStatusMenu
  
  @Exit:
   RTS
  
  

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  MenuRecoverPartyHP    [$B53F :: 0x3B54F]
;;
;;    Recovers HP for the whole party, AND draws the item target menu
;;
;;  IN:  A = HP to recover
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

MenuRecoverPartyHP:
    LDX #$00
    JSR MenuRecoverHP        ; recover HP for each character
    LDX #$40
    JSR MenuRecoverHP
    LDX #$80
    JSR MenuRecoverHP
    LDX #$C0
    JSR MenuRecoverHP
    JMP DrawItemTargetMenu   ; then draw item target menu, and exit

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Menu Recover HP   [$B556 :: 0x3B566]
;;
;;   Recovers HP for a party member.  For use in menus (out of battle) only.
;;
;;  IN:   X = char index to receive HP ($00, $40, $80, or $C0)
;;        A = ammount of HP to recover (1 byte only -- means max is 255)
;;
;;  OUT:  neither A nor X are changed by these routines
;;
;;   Two flavors.  MenuRecoverHP does nothing if the player is dead/stone
;;  MenuRecoverHP_Abs recovers HP even if dead/stone (does not check)
;;  Also.. when HP is recovered, the "recover hp" jingle is played.
;;
;;   Too hard to use local labels here because of the two entry points branching around
;;  each other... so had to use global labels.  Hence the long label names.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

MenuRecoverHP:
    LDY ch_ailments, X          ; get out of battle ailments for this character
    CPY #$01
    BEQ _MenuRecoverHP_Exit     ; if dead... skip to exit (can't recover HP when dead)
    CPY #$02
    BEQ _MenuRecoverHP_Exit     ; if stone... skip to exit

MenuRecoverHP_Abs:
    STA tmp                     ; back up HP to recover by stuffing it in tmp
    CLC
    ADC ch_curhp, X             ; add recover HP to low byte of HP
    STA ch_curhp, X
    LDA ch_curhp+1, X           ; add 0 to high byte of HP (to catch carry from low byte)
    ADC #0
    STA ch_curhp+1, X
    CMP ch_maxhp+1, X           ; then compare against max HP to make sure we didn't go over
    BEQ _MenuRecoverHP_CheckLow ; if high byte of cur = high byte of max, we need to check the low byte
    BCS _MenuRecoverHP_OverMax  ; if high byte of cur > high byte of max... we went over
                                ; otherwise.. we're done...

  _MenuRecoverHP_Done:
    ;LDA #$57
    ;STA music_track             ; play music track $57 (the little gain HP jingle)

    ;LDA #%00110000              ; set vol for sq2 to zero
    ;STA $4004
    ;LDA #%01111111              ; disable sweep
    ;STA $4005
    ;LDA #0                      ; and clear freq
    ;STA $4006                   ;  best I can figure... shutting off sq2 here prevents some ugly sounds
    ;STA $4007                   ;  from happening when the gain HP jingle starts.  Though I don't see why
                                ;  that should happen...
                                
    ;; JIGS - just use a neat little SFX with square2 instead:
    JSR PlayHealSFX

    LDA tmp                     ; restore the HP recovery ammount in A, before exiting
  _MenuRecoverHP_Exit:
    RTS


  _MenuRecoverHP_CheckLow:
    LDA ch_curhp, X             ; check low byte of HP against low byte of max
    CMP ch_maxhp, X
    BCS _MenuRecoverHP_OverMax  ; if cur >= max, we're over the max
    BCC _MenuRecoverHP_Done     ;  otherwise we're not, so we're done (always branches)

  _MenuRecoverHP_OverMax:
    LDA ch_maxhp, X             ; if over max, just replace cur HP with maximum HP.
    STA ch_curhp, X
    LDA ch_maxhp+1, X
    STA ch_curhp+1, X
    JMP _MenuRecoverHP_Done     ; and then jump to done

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Move Item Menu Cursor   [$B5AB :: 0x3B5BB]
;;
;;    Moves the cursor around in the item menu.  Checks all 4 directions
;;  and wraps where appropriate.  The description box is closed after every
;;  move (if it's opened).
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


MoveItemMenuCurs_Exit:
    RTS

MoveItemMenuCurs:
    LDA joy                   ; get current joy data
    AND #$0F                  ; mask out the directional bits
    CMP joy_prevdir           ; see if any bits have changed (button has been pressed/released)
    BEQ MoveItemMenuCurs_Exit ; if there was no change, there's nothing to do here, just exit
    STA joy_prevdir           ; write the new value back so that the joy changes are recorded
    CMP #0                    ; see if a button is being pressed or released (since either would cause a transition)
    BEQ MoveItemMenuCurs_Exit ; if 'joy' was zero... then buttons are released.. no buttons being pressed.. so just exit

    CMP #$04            ; check the 'Down' bit
    BCC @LeftOrRight    ;  if it's less than that... it's either Left or Right
    BNE @Up             ;  if it's not equal to that... it must be Up
                        ;  otherwise... it's Down
 @Down:
    LDA cursor         ; to move down... get the cursor
    CLC
    ADC #$03           ; add 3 to it
    CMP cursor_max     ; then if it's less than the max
    BCC @Done          ; we're done
    CMP #$03           ;   otherwise... if it's less than 3
    BCC @Done          ;   we're also done  (I don't see how this could ever happen, though)
                       ; otherwise we need to wrap to top of the column
 @DownWrap:
    SEC                ; wrap to top of the column
    SBC #$03           ;  by repeatedly subtracting 3
    CMP #$03           ;  until the cursor is < 3
    BCS @DownWrap      ; if >= 3, keep subtracting, otherwise...
    BCC @Done          ; we're done (always branches)


 @Up:
    LDA cursor         ; to move up...
    SEC
    SBC #$03           ; subtract 3 from the cursor
    BPL @Done          ; if we're still above zero, we're done.  Otherwise...

    LDA cursor         ; re-load the cursor into A
    LDX cursor_max     ; and put the maximum in X
    CPX #$03           ; if the max is less than 3
    BCC @Done          ;  we're done (do nothing -- cursor can't move)

 @UpWrap:              ; to wrap to bottom of column...
    CLC                ;  just repeatedly add 3
    ADC #$03
    CMP cursor_max
    BCC @UpWrap        ;  until the cursor is greater than the maximum
    SBC #$03           ; at which point, you subtract 3 to get it *just under* the maximum (but keeping it in its column)
    JMP @Done          ; then we're done


 @LeftOrRight:
    CMP #$01           ; check to see if they pressed Right instead of Left
    BNE @Left          ; if they didn't... jump to Left
                       ; otherwise... they must've pressed right
 @Right:
    LDA cursor         ; to move right... just add 1 to the cursor
    CLC
    ADC #$01
    CMP cursor_max     ; if the cursor is < max...
    BCC @Done          ;  then we're done
    LDA #0             ; otherwise wrap the cursor to zero
    BEQ @Done          ;  (always branches)

 @Left:
    LDA cursor         ; to move left... subtract 1 from the cursor
    SEC
    SBC #$01
    BPL @Done          ; still >= 0, we're done
    LDA cursor_max     ; otherwise, wrap to max-1
    SEC
    SBC #$01

 @Done:
    STA cursor            ; write the new cursor value
    JMP CloseDescBox_Sfx  ; close the description box, play the menu move sound effect, and exit

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Menu Wait for Btn [$B613 :: 0x3B623]
;;
;;    These routines will simply wait until the user pressed either the A or B buttons, then
;;  will exit.  MenuFrame is called during the wait loop, so the music driver and things stay
;;  up to date.
;;
;;    MenuWaitForBtn_SFX   will play the MenuSel sound effect once A or B is pressed
;;    MenuWaitForBtn       will not play any sound effect
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

MenuWaitForBtn_SFX:
    ;JSR DoWeDrawChars
    ;; JIGS ^ 
    JSR MenuFrame           ; do a frame
    LDA joy_a               ;  check A and B buttons
    ORA joy_b
    BEQ MenuWaitForBtn_SFX  ;  if both are zero, keep looping.  Otherwise...
    LDA #0
    STA joy_a               ; clear both joy_a and joy_b
    STA joy_b
    JMP PlaySFX_MenuSel     ; play the MenuSel sound effect, and exit


MenuWaitForBtn:
    ;JSR DoWeDrawChars
    ;; JIGS ^ 
    JSR MenuFrame           ; exactly the same -- only no call to PlaySFX_MenuSel at the end
    LDA joy_a
    ORA joy_b
    BEQ MenuWaitForBtn
    LDA #0
    STA joy_a
    STA joy_b
    RTS
    
    ;; this isn't used anymore, since there's a new save screen that doesn't treat you like a baby
   ; DoWeDrawChars:  ;; JIGS - if saving on the main menu, the description box 
                    ;; frames will stop drawing sprites; this tells it to draw them!
 ;LDA InMainMenu
 ;CMP #1
 ;BNE :+
 ;JSR DrawMainMenuCharSprites
 ;: RTS

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Draw Main Menu Character Sprites [$B635 :: 0x3B645]
;;
;;    Pretty self explanitory.  Draws the 4 characters sprites as seen
;;  on the main menu
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

DrawMainMenuCharSprites:
;    LDA #$88           ; Draw char 0's OB Sprite at $88,$18
;    STA spr_x
;    LDA #$18
;    STA spr_y
;    LDA #$00
;    JSR DrawOBSprite

;    LDA #$D8           ; Draw char 1's OB sprite at $D8,$18
;    STA spr_x
;    LDA #$40
;    JSR DrawOBSprite

;    LDA #$88           ; Draw char 3's OB sprite at $D8,$88
;    STA spr_y
;    LDA #$C0
;    JSR DrawOBSprite

;    LDA #$88           ; and lastly, char 2's OB sprite at $88,$88
;    STA spr_x
;    LDA #$80
;    JMP DrawOBSprite   ; then exit

    ;; JIGS - moved them around slightly
    
    LDA #$6C          
    STA spr_x
    LDA #$18
    STA spr_y
    LDA #$00
    JSR DrawOBSprite
    
    ;LDA #$D8          
    ;STA spr_x
    LDA #$48
    STA spr_y    
    LDA #$40
    JSR DrawOBSprite

    LDA #$78          
    STA spr_y
    LDA #$80
    JSR DrawOBSprite

    LDA #$A8          
    STA spr_y
    LDA #$C0
    JMP DrawOBSprite  

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Menu Frame  [$B65D :: 0x3B66D]
;;
;;    This does various things that must be done every frame when in the menus.
;;  This involves:
;;    1)  waiting for VBlank
;;    2)  Sprite DMA
;;    3)  scroll resetting
;;    4)  calling MusicPlay
;;    5)  incrementing frame counter
;;    6)  updating joypad
;;
;;    Menu loops will call this routine every iteration before processing the user
;;  input to navigate menus.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

MenuFrame:
    JSR HushTriangle
    ;; JIGS ^ every frame, gosh
    JSR WaitForVBlank_L    ; wait for VBlank
    LDA #>oam              ; Do sprite DMA (update the 'real' OAM)
    STA $4014

    LDA soft2000           ; reset scroll and PPU data
    STA $2000
    LDA #0
    STA $2005
    STA $2005

    LDA music_track        ; if no music track is playing...
    BPL :+
      ;LDA #$51             ;  start music track $51  (menu music)
      LDA dlgmusic_backup  ;; JIGS - change to map music
      STA music_track

:   LDA #BANK_THIS         ; record this bank as the return bank
    STA cur_bank           ; then call the music play routine (keep music playing)
    JSR CallMusicPlay

    INC framecounter       ; increment the frame counter to count this frame

    LDA #0                 ; zero joy_a and joy_b so that an increment will bring to a
    STA joy_a              ;   nonzero state
    STA joy_b
    STA joy_select
    JMP UpdateJoy          ; update joypad info, then exit


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Move Main Menu Sub Cursor  [$B68C :: 0x3B69C]
;;
;;    Moves the cursor for the main menu sub target.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

MoveMainMenuSubCursor:
    LDA joy              ; get joy buttons
    AND #$0F             ; isolate directional arrows
    CMP joy_prevdir      ; compare to prev directions to see if there was a change
    BEQ @Exit            ; no change... exit

    STA joy_prevdir      ; otherwise record change
    CMP #0               ; see if the change was a press or release
    BEQ @Exit            ; if release... exit

    LDX #$01             ; X=1 (for left/right)
    CMP #$04             ;  see if player pressed up or down
    BCC :+
      LDX #$02           ; if they did... X=2 (for up/down)
:   TXA                  ; then move X to A

                         ; A is now 1 for horizontal movement and 2 for vertical movement
    EOR cursor           ; EOR with the cursor (wrap around appropriate axis)
    STA cursor           ; and write back
    JMP PlaySFX_MenuMove ; then play the move sound effect
  @Exit:
    RTS                  ; and exit

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Move Cursor Up / Down  [$B6AB :: 0x3B6CB]
;;
;;    Checks joypad data for up/down button presses, and increments/decrements
;;  the cursor appropriately.  The cursor is wrapped at cursor_max.  This also
;;  plays that ugly sound effect if the cursor has been moved
;;
;;    Left/Right button presses are not checked here -- this is for up/down only
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

MoveCursorUpDown:
    LDA joy           ; get joypad data
    AND #$0C          ;  isolate up/down buttons
    CMP joy_prevdir   ;  compare it to previously checked button states
    BEQ @Exit         ; if they equal, do nothing (button has already been pressed and is currently just held)

    STA joy_prevdir   ; otherwise, button state has changed, so record new button state in prevdir
    CMP #$00          ;  and check to see if a button is being pressed or released (nonzero=pressed)
    BEQ @Exit         ;  if zero, button is being released, so do nothing and just exit

    CMP #$04          ; see if the user pressed down or up
    BNE @Up

  @Down:              ; moving down...
    LDA cursor        ;  get cursor, and increment by 1
    CLC
    ADC #$01
    CMP cursor_max    ;  if it's < cursor_max, it's still in range, so
    BCC @Move         ;   jump ahead to move
    LDA #0            ;  otherwise, it needs to be wrapped to zero
    BEQ @Move         ;   (always branches)

  @Up:                ; up is the same deal...
    LDA cursor        ;  get cursor, decrement by 1
    SEC
    SBC #$01
    BPL @Move         ; if the result didn't wrap (still positive), jump ahead to move
    LDA cursor_max    ;  otherwise wrap so that it equals cursor_max-1
    SEC
    SBC #$01

  @Move:
    STA cursor            ; set cursor to changed value
    JMP PlaySFX_MenuMove  ; then play that hideous sound effect and exit

  @Exit:
    RTS


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Move Magic Menu Cursor  [$B6DC :: 0x3B6EC]
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

MoveMagicMenuCursor_Exit:
    RTS

MoveMagicMenuCursor:
    ;LDA submenu_targ            ; get target character ID
    ;ROR A
    ;ROR A
    ;ROR A
    ;AND #$C0                    ; shift to get a usable character index
    ;STA tmp                     ; put it in tmp
    ;; JIGS - none of that anymore

    LDA joy                      ; get joypad state
    AND #$0F                     ; isolate directional buttons
    CMP joy_prevdir              ; compare to previous buttons to see if any have been pressed/released
    BEQ MoveMagicMenuCursor_Exit ; if there's no change, just exit
    STA joy_prevdir              ;  otherwise record changes
    CMP #0                       ; see if buttons have been pressed (rather than released)
    BEQ MoveMagicMenuCursor_Exit ; if no buttons pressed, just exit

    CMP #$04               ; now see which button was pressed
    BCS @UpDown            ; check for up/down
    CMP #$01               ; otherwise, check for left/right
    BNE @Left


  @Right:
     INC cursor
     LDA cursor
     CMP #24
     BEQ @OopsRight
     JSR @CheckCursor
     BEQ @Right
     JMP CloseDescBox_Sfx
          
   @OopsRight:
   LDA #0     ; well this doesn't need checking...
   STA cursor
   JMP CloseDescBox_Sfx
   
   ; LDA cursor            ; get cursor
   ; CLC
   ; ADC #$01              ; add 1 to it (move it right)
   ; AND #$03              ; mask out the low bits (column)
   ; CMP #$03              ; see if in column 3 (column 3 doesn't exist -- is padding)
   ; BNE @Right_ColOK      ; if not column 3, this column is okay!  skip ahead
    
   ;   LDA cursor             ; otherwise (column is bad), get the cursor
   ;   AND #$1C               ; wrap it to start of row
   ;   STA cursor             ; write it back
   ;   JSR @CheckCursor       ; check to make sure slot isn't empty
   ;   BEQ @Right             ; if it is, keep looping until we get to a slot that isn't empty
   ;   JMP CloseDescBox_Sfx   ; otherwise, close the description box and exit

  ;@Right_ColOK:
  ;  INC cursor             ; if we're not in the last column... just INC the cursor
  ;  JSR @CheckCursor       ; then check to make sure it's not an empty slot
  ;  BEQ @Right             ; if it is, keep looping
  ;  JMP CloseDescBox_Sfx   ; otherwise, close desc box and exit


  @Left:                  ; moving left is just like moving right, just in opposite direction
     DEC cursor
     LDA cursor
     CMP #23
     BCS @OopsLeft
     JSR @CheckCursor
     BEQ @Left
     JMP CloseDescBox_Sfx
          
   @OopsLeft:
   LDA #23
   STA cursor
  : JSR @CheckCursor
    BEQ @MoreLeft
    JMP CloseDescBox_Sfx 
   
   @MoreLeft:
   DEC cursor
   JMP :-
   
  
  ;  LDA cursor            ; get cursor
  ;  SEC
  ;  SBC #$01              ; subtract 1 and mask
  ;  AND #$03
  ;  CMP #$03              ; then see if we're in the padding column
  ;  BNE @Left_ColOK       ; if not, col is OK
    
  ;    LDA cursor            ; if we are in padding column, get cursor
  ;    AND #$1C              ; mask out the row
  ;    ORA #$02              ; snap to last column in row
  ;    STA cursor            ; write back
  ;    JSR @CheckCursor      ; verify slot isn't empty
  ;    BEQ @Left             ; if it is, keep looping
  ;    JMP CloseDescBox_Sfx  ; otherwise, exit

  ;@Left_ColOK:
  ;  DEC cursor            ; not in the first column... so we can just dec the cursor
  ;  JSR @CheckCursor      ; verify it
  ;  BEQ @Left             ; loop if empty
  ;  JMP CloseDescBox_Sfx  ; otherwise exit


@UpDown:         ; if we pressed up or down... see which
    BNE @Up

 @Down:                  
    LDA cursor            
    CLC
    ADC #03               
    STA cursor
    CMP #26
    BCS @OopsDown_2
    CMP #25
    BCS @OopsDown_1
    CMP #24
    BCS @OopsDown
    JSR @CheckCursor       
    BEQ @Down         
    JMP CloseDescBox_Sfx   
   
   @OopsDown_2:    
    LDA #0
    JMP :+
   @OopsDown_1:    
    LDA #25
   @OopsDown: 
    SEC
    SBC #23
  : STA cursor
    JSR @CheckCursor       
    BEQ @Down         
    JMP CloseDescBox_Sfx   

  @Up:                    
    LDA cursor
    SEC
    SBC #03       
    CMP #$FD
    BEQ @OopsUp_1
    CMP #25
    BCS @OopsUp
    STA cursor
    JSR @CheckCursor
    BEQ @Up
    JMP CloseDescBox_Sfx   

   @OopsUp_1:   
    LDA #0
   @OopsUp: 
    CLC
    ADC #23
  : STA cursor
    JSR @CheckCursor       
    BEQ @Up         
    JMP CloseDescBox_Sfx   
    
    ;; JIGS - well this only took two hours to perfect... and it could probably be done easier somehow.
    
    
 ; @Down:                   ; moving up/down is a bit easier than left/right
 ;   LDA cursor             ; get cursor
 ;   CLC
 ;   ADC #$04               ; just add 4 to it (one row)
 ;   AND #$1F               ; mask to keep within 8 rows
 ;   STA cursor             ; and write back
 ;   JSR @CheckCursor       ; verify
 ;   BEQ @Down              ; loop if slot is empty
 ;   JMP CloseDescBox_Sfx   ; then exit once we find a nonempty slot

 ; @Up:                     ; moving up is exactly the same
 ;   LDA cursor
 ;   SEC
 ;   SBC #$04               ; only we subtract 4 instead of adding
 ;   AND #$1F
 ;   STA cursor
 ;   JSR @CheckCursor
 ;   BEQ @Up
 ;   JMP CloseDescBox_Sfx

  ;;;;;;
  ;;  A little mini local subroutine here that checks to see if the cursor
  ;;    is on a spell or an empty slot.
  ;;
  ;;  Result is store in Z on exit.  Z set = cursor on blank slot
  ;;  Z clear = cursor is on actual spell
  ;;;;;;

  @CheckCursor:
    ;LDA cursor       ; get the cursor
    ;ORA tmp          ; add the char index to it
    ;TAX              ; put in X to index
    ;LDA ch_magicdata, X     ; and fetch the spell at current cursor
    
    LDX cursor
    LDA TempSpellList, X
    RTS              ; then exit.

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Close Description Box  [$B771 :: 0x3B781]
;;
;;    Closes the item description box if it is open, and clears 'descboxopen'
;;  to indicate that the box is closed.
;;
;;    Routine comes in two flavors:
;;
;;  CloseDescBox_Sfx = plays the menu move sound effect, and closes
;;                     the box only if it's open
;;
;;  CloseDescBox     = doesn't play any sound effect, and closes the box
;;                     even if it's already closed (no checking to see if it's open)
;;
;;    Note the difference between these and EraseDescBox.  EraseDescBox simply
;;  does the PPU drawing.  These routines also clear 'descboxopen', which EraseDescBox
;;  does not do.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


CloseDescBox_Sfx:
    JSR PlaySFX_MenuMove     ; play the menu move sound effect
    LDA descboxopen          ; see if the box is currently open
    BNE CloseDescBox         ;  if it is, close it... otherwise
      RTS                    ;    just exit

CloseDescBox:
    LDA #0
    STA descboxopen          ; clear descboxopen to indicate that the box is now closed
    JMP EraseDescBox         ; and erase the box, then exit


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Turn Menu Screen On  [$B780 :: 0x3B790]
;;
;;    This is called to switch on the PPU once all the drawing for the menus is complete
;;
;;   Comes in 2 flavors... normal, and 'ClearOAM' -- both of which are the same, only
;;   the ClearOAM version, as the name implies, clears OAM (clearing all sprites).
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


TurnMenuScreenOn_ClearOAM:
    JSR ClearOAM             ; clear OAM
                             ;  then just do the normal stuff

TurnMenuScreenOn:
    JSR ClearMenuOtherNametables
    ;; JIGS ^ clear out the side nametables so screen shaking doesn't produce garbage pixels
    JSR WaitForVBlank_L      ; wait for VBlank (don't want to turn the screen on midway through the frame)
    LDA #>oam                ; do Sprite DMA
    STA $4014
    JSR DrawPalette          ; draw/apply the current palette

    LDA #$08
    STA soft2000             ; set $2000 and soft2000 appropriately
    STA $2000                ;  (no NT scroll, BG uses left pattern table, sprites use right, etc)

    LDA #$1E
    STA $2001                ; enable BG and sprite rendering
    LDA #0
    STA $2005
    STA $2005                ; reset scroll

    LDA #BANK_THIS           ; record current bank and CallMusicPlay
    STA cur_bank
    JMP CallMusicPlay


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Draw Main Menu Sub Cursor  [$B7A9 :: 0x3B7B9]
;;
;;    Draws the cursor for the main menu sub target (ie:  when you select
;;  a character for a sub menu -- like for magic or status)
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

DrawMainMenuSubCursor:
    LDA cursor                      ; get cursor
    ASL A                           ; double it (2 bytes per coord)
    TAX                             ; and stuff it in X
    LDA lut_MainMenuSubCursor, X    ; load up the coords from our LUT
    STA spr_x
    LDA lut_MainMenuSubCursor+1, X
    STA spr_y
    JMP DrawCursor                  ; then draw the cursor and exit


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  DrawMainMenuCursor  [$B7BA :: 0x3B7CA]
;;
;;    Loads the coords for the main menu cursor, and draw the cursor sprite
;;  at those coords.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

DrawMainMenuCursor:
    LDY cursor                    ; get current cursor selection
    LDA lut_MainMenuCursor_Y, Y   ;  use cursor as an index to get the desired Y coord
    STA spr_y                     ;  write the Y coord
    LDA #$10                      ; X coord for main menu cursor is always $10
    STA spr_x
    JMP DrawCursor                ; draw it!  and exit

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  DrawItemMenuCursor  [$B7C8 :: 0x3B7D8]
;;
;;   Loads the coords for the item menu cursor, and draws the cursor sprite there
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

DrawItemMenuCursor:
    LDA cursor                   ; get current cursor and double it (loading X,Y pair)
    ASL A
    TAX                          ;  put it in X

    LDA lut_ItemMenuCursor, X    ; load X,Y pair into spr_x and spr_y
    STA spr_x
    LDA lut_ItemMenuCursor+1, X
    STA spr_y

    JMP DrawCursor               ; then draw the cursor


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Main and item menu cursor position LUTs  [$B7D9 :: 0x3B7E9]
;;
;;    X/Y Coords for cursor placement for main and item menus
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; JIGS -- all these got changed around

lut_MainMenuSubCursor:
 ; .BYTE $50,$18,      $A0,$18
 ; .BYTE $50,$88,      $A0,$88
 
  .BYTE $58,$18,      $58,$48
  .BYTE $58,$78,      $58,$A8

lut_MainMenuCursor_Y:           ; Y coord only... X coord is hardcoded
 ; .BYTE   $90,$A0,$B0,$C0,$D0
 
   .BYTE   $70,$80,$90,$A0,$B0,$C0,$D0

lut_ItemMenuCursor:
 ; .BYTE   $10,$30,   $58,$30,   $A0,$30
 ; .BYTE   $10,$40,   $58,$40,   $A0,$40
 ; .BYTE   $10,$50,   $58,$50,   $A0,$50
 ; .BYTE   $10,$60,   $58,$60,   $A0,$60
 ; .BYTE   $10,$70,   $58,$70,   $A0,$70
 ; .BYTE   $10,$80,   $58,$80,   $A0,$80
 ; .BYTE   $10,$90,   $58,$90,   $A0,$90
 ; .BYTE   $10,$A0,   $58,$A0,   $A0,$A0

  .BYTE   $08,$30,   $58,$30,   $A8,$30
  .BYTE   $08,$40,   $58,$40,   $A8,$40
  .BYTE   $08,$50,   $58,$50,   $A8,$50
  .BYTE   $08,$60,   $58,$60,   $A8,$60
  .BYTE   $08,$70,   $58,$70,   $A8,$70
  .BYTE   $08,$80,   $58,$80,   $A8,$80
  .BYTE   $08,$90,   $58,$90,   $A8,$90
  .BYTE   $08,$A0,   $58,$A0,   $A8,$A0


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Draw Magic Menu Cursor [$B816 :: 0x3B826]
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

DrawMagicMenuCursor:
;    LDA cursor            ; get the cursor
;    STA tmp               ; back it up (dumb -- since we can just look at 'cursor' any time >_>)

;    AND #$03              ; mask out the low bits (column)
;    ASL A                 ;   *2
;    STA tmp+1             ;  store in tmp+1
;    CLC
;    ADC tmp+1             ; add it again (*4)
;    ADC tmp+1             ; and again (*6)
;    ADC tmp+1             ; JIGS - AGAIN! (*8 ... jump 8 spaces per spell? (7 letters, 1 space)...wow that worked.
;    ASL A
;    ASL A
;    ASL A                 ; then multiply by 8 (*48)
;    CLC
    ;;ADC #$50              ; and add $50  (col*48 + $50)
;        ADC #$30              ; JIGS - longer spell names! ...means a lesser number here.
;    STA spr_x             ; this is our X coord for the cursor
        
;    LDA tmp               ; get the cursor (row*4)
;    LDA cursor
;    ASL A                 ; multiply by 4  (*16)
;    ASL A
;    AND #$F0              ; mask to remove the column bits (now a clean *16)
;    CLC
;    ADC #$28              ; add $28  (row*16 + $28)
;    STA spr_y             ; this is our Y coord
;    JMP DrawCursor        ; Draw it!  and exit


;; JIGS - screw all that... using a LUT.

    LDA cursor                   ; get current cursor and double it (loading X,Y pair)
    ASL A
    TAX                          ;  put it in X

    LDA lut_MagicMenuCursor, X    ; load X,Y pair into spr_x and spr_y
    STA spr_x
    LDA lut_MagicMenuCursor+1, X
    STA spr_y
    JMP DrawCursor               ; then draw the cursor


lut_MagicMenuCursor:
  .BYTE   $30,$28,   $70,$28,   $B0,$28
  .BYTE   $30,$38,   $70,$38,   $B0,$38
  .BYTE   $30,$48,   $70,$48,   $B0,$48
  .BYTE   $30,$58,   $70,$58,   $B0,$58
  .BYTE   $30,$68,   $70,$68,   $B0,$68
  .BYTE   $30,$78,   $70,$78,   $B0,$78
  .BYTE   $30,$88,   $70,$88,   $B0,$88
  .BYTE   $30,$98,   $70,$98,   $B0,$98








    ;; JIGS - couldn't use a simple lut, could you...

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Draw Main Menu   [$B83A :: 0x3B84A]
;;
;;    Does all BG drawing for the main menu
;;   Does not draw sprites
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

DrawMainMenu:
    JSR ClearNT                    ; start by clearing the NT
    JSR DrawOrbBox                 ; draw the orb box
    JSR DrawMainMenuGoldBox        ; gold box
    JSR DrawMainMenuOptionBox      ; and option box

    LDA #1                         ; then draw the boxes for each character
    JSR DrawMainItemBox            ;  stats...starting with the first character
    LDA #$00
    JSR DrawMainMenuCharBoxBody

;    LDA #2                         ; second
;    JSR DrawMainItemBox
    

    LDA #12
    STA dest_x
    LDA #9
    STA dest_y
    LDA #$40
    JSR DrawMainMenuCharBoxBody

;    LDA #3                         ; third
;    JSR DrawMainItemBox
    
    LDA #12
    STA dest_x
    LDA #15
    STA dest_y
    LDA #$80
    JSR DrawMainMenuCharBoxBody

;    LDA #4                         ; fourth
;    JSR DrawMainItemBox
    LDA #12
    STA dest_x
    LDA #21
    STA dest_y
    LDA #$C0
    JSR DrawMainMenuCharBoxBody   
    
    ;; JIGS - just a bit more to draw this weird line between the gold and orb boxes...
    
    LDA #2
    STA dest_x
    LDA #9
    STA dest_y
    LDA #57
    JMP DrawMenuString


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Draw Main Menu Gold Box   [$B86E :: 0x3B87E]
;;
;;    Self explanitory.  Draws the box on the main menu that shows your current GP
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

DrawMainMenuGoldBox:
    LDA #5               ; draw main/item box number 5 (the GP box)
    JSR DrawMainItemBox
    LDA #0  ; < JIGS < ; #$01             ; draw menu string ID=$01  (current GP, followed by " G")
    DEC dest_y
    ;; JIGS ^ the gold box is thinner now
    JMP DrawMenuString


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Draw Orb Box   [$B878 :: 0x3B888]
;;
;;   Draws the Orb box (and its contents) as seen on the main menu.
;;
;;   tmp+7 is used to build the attribute byte
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

DrawOrbBox:
    LDA #0             ; Draw main menu box ID 0  (the orb box)
    JSR DrawMainItemBox

      ; Fire Orb
    LDX #$84           ; dest ppu address       = $2084
    LDY #$64           ; lit orb tiles start at = $64
    LDA orb_fire       ; fire orb status
    JSR @DrawOrb

      ; Water Orb
    LDX #$86           ; dest ppu address       = $2086
    LDY #$68           ; lit orb tiles start at = $68
    LDA orb_water      ; water orb status
    JSR @DrawOrb

      ; Air Orb
    LDX #$C4           ; dest ppu address       = $20C4
    LDY #$6C           ; lit orb tiles start at = $6C
    LDA orb_air        ; air orb status
    JSR @DrawOrb

      ; Earth Orb
    LDX #$C6           ; dest ppu address       = $20C6
    LDY #$70           ; lit orb tiles start at = $70
    LDA orb_earth      ; earth orb status
    JSR @DrawOrb

      ; Attributes for all orbs
    LDA $2002    ; reset PPU toggle
    LDA #>$23C9
    STA $2006
    LDA #<$23C9
    STA $2006    ; attribute byte at $23C9
    LDA tmp+7    ; load computed attribute byte
    STA $2007    ;   and draw it
    RTS


   ; DrawOrb local subroutine
   ;  X = low byte of dest PPU address
   ;  Y = orb tile ID to draw (each lit orb has different graphics)
   ;  A = orb status.  0 = not lit... nonzero=lit

  @DrawOrb:
    LSR tmp+7
    LSR tmp+7     ; shift 2 bits out of computed attribute byte
    CMP #0        ; check orb status
    BNE :+        ; if lit, skip ahead

      LDY #$76    ; if orb not lit... replace tile with $76 (unlit orb graphics)
      LDA #$C0    ; and OR #$C0 to our attribute byte
      ORA tmp+7   ;  unlit orbs use palette 3
      STA tmp+7   ;  lit orbs use palette 0 -- so this changes attributes accordingly

:   LDA $2002     ; reset PPU toggle
    LDA #$20
    STA $2006     ; set high byte of ppu addr to $20
    STX $2006     ; and low byte to our desired address

    STY $2007     ;  draw the first tile
    INY
    STY $2007     ;  then the second
    INY

    LDA #$20      ; Set PPU address to look 1 row below what we just drew
    STA $2006     ;  high byte is still $20
    TXA           ;  but take the low byte
    CLC
    ADC #$20      ;  and add #$20 so that it is the next row
    STA $2006

    STY $2007     ;  draw the 3rd tile
    INY
    STY $2007     ;  and lastly the 4th
    RTS

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Draw Main/Item Box   [$B8EF :: 0x3B8FF]
;;
;;    A contains the ID of box we're to draw.
;;      simply loads dims then draws box
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

DrawMainItemBox:
    JSR LoadMainItemBoxDims
    JMP DrawBox

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;   Load Main/Item Menu Box Dimensions  [$B8F5 :: 0x3B905]
;;
;;     A contains the ID of the box we're to load dims for:
;;
;;     0-6 are main menu boxes
;;     7-9 are item menu boxes
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

LoadMainItemBoxDims:
    ASL A        ; multiply ID by 4 (4 bytes per box)
    ASL A
    TAX          ; put it in X to index

    LDA lut_MainItemBoxes, X     ; X coord of box
    STA box_x
    LDA lut_MainItemBoxes+1, X   ; Y coord of box
    STA box_y
    LDA lut_MainItemBoxes+2, X   ; Width of box
    STA box_wd
    LDA lut_MainItemBoxes+3, X   ; Height of box
    STA box_ht

    LDA #BANK_THIS   ; set swap back bank to this bank
    STA cur_bank     ;  so that stalled boxes will swap back appropriately
    RTS


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  DrawMainMenuOptionBox  [$B911 :: 0x3B921]
;;
;;    Draws the option box for the main menu (the one that contains further menu options,
;;  like "Status", "Item", "Weapon", etc
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

DrawMainMenuOptionBox:
    LDA #6
    JSR DrawMainItemBox    ; Draw Main/Item Box ID=$06  (the option box)
    ;INC dest_y             ;  draw the containing text one line lower than usual (so the cursor will fit in the box)
    LDA #4
    STA dest_x             ; JIGS - due to widening the option box, text needs to be pushed right 2 extra 
    LDA #01 ; < JIGS < ; #$02               ; Draw Menu String ID=$02 (the option text)
    JMP DrawMenuString


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Draw Item Title Box  [$B91D :: 0x3B92D]
;;
;;    Draws the 'ITEM' title box as appears in the item menu
;;  Somewhat oddly, the box to draw is hardcoded into this routine.. but the string isn't!
;;
;;  IN:  A = Menu String ID to draw inside this box ($03 = "ITEM")
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

DrawItemTitleBox:
   ; PHA                   ; push menu string ID to back it up
    LDA #$07              ; draw mainitem box ID 7 (the "ITEM" title box)
    JSR DrawMainItemBox
   ; PLA                   ; pull menu string ID
   
   ;; JIGS - don't mess with the stack! Moved that thing here v
   
    LDA #02 ; < JIGS < ; #$03  
    JMP DrawMenuString    ;  and draw it and return



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Draw Item Description Box  [$B927 :: 0x3B937]
;;
;;    This comes in two flavors.  One plays the special event fanfare music
;;  (heard when you use a special item at the right time -- like when you use the Lute in ToFR)
;;  the other doesn't.  Apart from that they're both the same.  They draw the
;;  description box, then the desired description text
;;
;;  IN:   A = ID of menu to string to draw (for description text)
;;
;;    Note that the description box is drawn while the PPU is on and rendering!
;;  Therefore all the box and text drawing must be done in VBlank.  To accomplish
;;  this... the game uses 'menustall'
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


DrawItemDescBox_Fanfare:
    LDX #$54              ; play music track $54 (special event fanfare)
    STX music_track

DrawItemDescBox:
    PHA                   ; push menu string ID to back it up
    LDA #1                ; set menustall to nonzero (indicating we need to stall)
    STA menustall
    LDA #$08              ; draw main/item box ID $08  (the description box)
    JSR DrawMainItemBox
    PLA                   ; restore menu string ID
    INC descboxopen       ; set descboxopen to a nonzero value to mark the description box as open

    ;;;  no JMP or RTS -- code flows seamlessly into DrawMenuString

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Draw Menu String  [$B938 :: 0x3B948]
;;
;;    Draws a string from a series of menu strings.  These include titles,
;;  labels, as well as item descriptions, and pretty much anything else that
;;  appears in menus
;;
;;  IN:  A              = ID of menu string to draw ($00-7F)
;;       dest_x, dest_y = Coords to draw string to (this is usually filled by DrawBox)
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

DrawMenuString:
    ASL A                   ; double A (pointers are 2 bytes)
    TAX                     ; put in X to index menu string pointer table
    LDA lut_MenuText, X
    STA text_ptr
    LDA lut_MenuText+1, X   ; load pointer from table, store to text_ptr  (source pointer for DrawComplexString)
    STA text_ptr+1
         ;;  code seamlessly flows into DrawMenuComplexString


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Draw Menu Complex String  [$B944 :: 0x3B954]
;;
;;    Simply calls DrawComplexString -- however it sets the desired return and data bank
;;  to this bank.  This can be called when the string to be drawn is either on this bank
;;  or is in RAM.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

DrawShopComplexString: ;; JIGS < moved here
DrawMenuComplexString:
    LDA #BANK_THIS
    STA cur_bank          ; set data bank (string to draw is on this bank -- or is in RAM)
    STA ret_bank          ; set return bank (we want it to RTS to this bank when complete)
    JMP DrawComplexString ;  Draw Complex String, then exit!



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Erase Description Box [$B94D :: 0x3B95D]
;;
;;    Erases the item description box from the item menu.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

EraseDescBox:
    LDA #1
    STA menustall            ; set menustall -- we will need to stall here, since the PPU is on
    LDA #$08
    JSR LoadMainItemBoxDims  ; load box dimensions for box ID 8 (the item description box)
    JMP EraseBox             ;  erase the box, then exit



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Draw Character Menu String  [$B959 :: 0x3B969]
;;
;;     Draws a desired menu string (see DrawMenuString), but replaces character stat
;;  codes in the string to reflect the stats of the given character.
;;
;;  IN:              A = menu string ID to draw
;;        submenu_targ = character ID whose stats to draw
;;                   Y = length of string (DrawCharMenuString_Len only!)
;;
;;     Why the length of the string is required is beyond me -- the game really should've just
;;  looked for the null terminator instead.  But it doesn't... so blah.  Chalk it up to one of the
;;  many stupid things this game does.
;;
;;    DrawCharMenuString_Len  is the same as DrawCharMenuString, only it does not set the
;;  string length, and thus the string length must be put in Y before calling.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

DrawCharMenuString:
    LDY #$7F                ; set length to default 7F

DrawCharMenuString_Len:
    ASL A                   ; double menu string ID
    TAX                     ; put in X
    LDA lut_MenuText, X     ; and load up the pointer into (tmp)
    STA tmp
    LDA lut_MenuText+1, X
    STA tmp+1

    LDA #<bigstr_buf        ; set the text pointer to our bigstring buffer
    STA text_ptr
    LDA #>bigstr_buf
    STA text_ptr+1

  @Loop:                    ; now step through each byte of the string....
    LDA (tmp), Y            ; get the byte
    CMP #$10                ; compare it to $10 (charater stat control code)
    BNE :+                  ;   if it equals...
      ORA submenu_targ      ;   OR with desired character ID to draw desired character's stats
:   STA bigstr_buf, Y       ; copy the byte to the big string buffer
    DEY                     ; then decrement Y
    CPY #$FF                ; check to see if it wrapped
    BNE @Loop               ; and keep looping until it has

                                ; once the loop is complete and our big string buffer has been filled
    JMP DrawMenuComplexString   ; draw the complex string and exit.

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Draw Main Menu Character Box Body      [$B982 :: 0x3B992]
;;
;;    Fills a previously drawn character box with the given character's data
;;
;;  IN:  A              = $00, $40, $80, or $C0 indicating which character's stats to draw
;;       dest_x, dest_y = Destination coordinates (filled by DrawBox, which is called just before this routine)
;;
;;    Note this routine does BG changes only -- it does NOT draw the character sprites
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

DrawMainMenuCharBoxBody:
    PHA               ; push char index to stack (temporary)
    TAX               ; also put index in X

    LDA #>str_buf     ; the strings we will be drawing here will be from a RAM buffer
    STA text_ptr+1    ;  so set the high byte of the string pointer

    LDA ch_mp, X   ; check all of this character's Max MP
    ORA ch_mp+1, X ;  if any level of spells is nonzero, we'll need to draw the MP
    ORA ch_mp+2, X ;  for this character.  Otherwise, we won't need to.
    ORA ch_mp+3, X ;  this is checked easily by just ORing all the max MP bytes
    ORA ch_mp+4, X
    ORA ch_mp+5, X
    ORA ch_mp+6, X
    ORA ch_mp+7, X
   
    BNE @DrawMP       ; if max MP is nonzero, jump ahead to DrawMP
      JMP @NoMP       ; otherwise... jump ahead to NoMP


  @DrawMP:
    LDY #$00          ; Y is dest index for our drawing loop, start it at zero
                      ;  the loop also modifies X to use it as a source index (this is why the char index was pushed)
                      
    LDA #$96          ; M
    STA str_buf
    LDA #$99          ; P
    STA str_buf+1                      
    LDA #$FF          ; _
    STA str_buf+2                      
   @MPLoop:
      ;LDA ch_curmp, X ; Get current MP for this level
      LDA ch_mp, X
      AND #$F0        ; JIGS - high bits are current mp
      LSR A           ; shift them into low bits
      LSR A
      LSR A
      LSR A           
      
      ORA #$80        ;  Or with $80 to get this digit's tile
      STA str_buf+3, Y  ; write this tile to the temp string

      INY             ; inc our dest pointer
      LDA #$7A        ; write the '/' tile to seperate the spell levels
      STA str_buf+3, Y

      INX             ; inc src pointer (to look at next level MP)
      INY             ; inc dest pointer
      CPY #8*2        ; continue until all 8 levels drawn (2 characters drawn per level)
      BCC @MPLoop

    LDA dest_y        ; we draw the 2nd row of this MP first
    CLC
    ADC #4          ; Add $A to the given row so we draw this string 10 rows 
    STA dest_y        ;  into the box
    
    LDA #$00          ; replace the last '/' in the string with a null terminator
    STA str_buf+$12 ;F

    LDA #<str_buf ;+ $08  ; start drawing from 8 characters into the string
    STA text_ptr         ;  this will draw MP for levels 4-7 only (the second row)
    JSR DrawMenuComplexString    ; draw it

    LDA dest_y        ; subtract 8 from the Y coord to put it back to where it started
    SEC               ;  (we added 10 at first, and then DEC'd twice)
    SBC #4
    STA dest_y

  @NoMP:        ; code reaches here when the character has no MP, or after MP drawing is complete

   ; LDA dest_y
   ; SEC
   ; SBC #6      ; then subtract the 5 we just added to restore the Y coord
   ; STA dest_y

     ;;; Draw everything else (name, level, "HP" text or ailment blurb)
    PLA         ; pull previously pushed character index
    ASL A       ;  convert it from $40 base to $1 base (ie:  $03 is character 3 instead of $C0)
    ROL A
    ROL A
    AND #$03    ; mask out low 2 bits (precautionary -- isn't really necessary)
    ORA #$10    ; or with $10 (creates the 'draw stat' control code)
    
    STA str_buf+1
    STA str_buf+6
    STA str_buf+10
    STA str_buf+16
    STA str_buf+19
            
    LDA #0
    STA str_buf+2  ; Name Code
    STA str_buf+21 ; Terminator
    
    LDA #$FF
    STA str_buf    ; stupid
    STA str_buf+3
    STA str_buf+4    
    STA str_buf+9  ; stupid
    STA str_buf+12
    STA str_buf+15 ; spaces
    
    ;; why stupid? Because the ailment icon won't display after a line break
    ;; unless another tile is drawn first... I don't know why.
    
    LDA #$95       ; L 
    STA str_buf+5
    
    LDA #$03       ; draw stat 3 (Level)
    STA str_buf+7
    
    LDA #$01       ; double line break
    STA str_buf+8
    
    LDA #$02       ; draw stat 2 (Ailment icon)
    STA str_buf+11  ; 9  

    LDA #$91       ; H
    STA str_buf+13
    LDA #$99       ; P
    STA str_buf+14    
    LDA #$FF
    
    LDA #$05       ; draw stat 5 (Cur HP)
    STA str_buf+17
    LDA #$7A       ; '/' character
    STA str_buf+18
    LDA #$06       ; stat 6 (Max HP)
    STA str_buf+20
    
    LDA dest_x
    CLC
    ADC #4
    STA dest_x    
    
    ;   0 1  2    3 4 5 6  7     8       9 10 11      12 13 14 15 16 17    18 19 20    21
    ;   _ 00 Name _ _ L 00 Level -break- _ 00 Ailment _  H  P  _  00 CurHP /  00 MaxHP -end-
    
    LDA #<str_buf  ; set low byte of string pointer (start drawing the string from $0300)
    STA text_ptr
 
    JMP DrawComplexString    ; Draw it, then exit!



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Draw Magic Menu Main Box  [$BA6D :: 0x3BA7D]
;;
;;    Draws the magic menu main box (containing all the spells)
;;  Also sets the cursor to the first spell in the list.
;;
;;  OUT:       C = set if player has no spells
;;                 clear if player has at least 1 spell
;;        cursor = first spell on the character's list (if they have any spells)
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

DrawMagicMenuMainBox:
    LDA #$09
    JSR DrawMainItemBox          ; Draw the box itself from the list of MainItem boxes

    LDA submenu_targ             ; get the character we're looking at
    JSR Magic_ConvertBitsToBytes
    ; JIGS ^ Gotta get the spells into place before printing them!
    
    LDY #$C0                     ; set char menu string length to $C0
    DEC dest_x
    LDA #39 ; < JIGS < ; #$2A                     ; and draw string 2A (entire spell list, along with level names an MP amounts
    JSR DrawCharMenuString_Len   ;   -- ALL the text in one string!)
   
   LDX #0
    LDY #$08                     ; going to loop 8 times (one for each level of spells

  @Loop:
      LDA TempSpellList, X
      BNE @FoundSpell         ; if nonzero (has a spell)  escape
      INX
      LDA TempSpellList, X
      BNE @FoundSpell
      INX
      LDA TempSpellList, X
      BNE @FoundSpell
      INX                     
      DEY
      BNE @Loop               ; loop until we've checked every spell

    SEC             ; if no spell found, SEC and exit
    RTS

  @FoundSpell:
    TXA             ; if we found a spell... move which spell into A
    AND #$1F        ;  and mask out which spell it is (remove the char index)
    STA cursor      ;  and store it in the current cursor
    CLC             ; then CLC to indicate the character has a spell
    RTS             ; and exit


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Boxes for Main/Item menus  [$BAA2 :: 0x3BAB2]
;;
;;     in groups of 4:  X, Y, width, height
;;
;;  Item menu boxes are also used for the magic menu.

lut_MainItemBoxes:
 ;; JIGS -- some new boxes
 
    .BYTE   $02,$02,$08,$08 ; < new orb box
    .BYTE   $0B,$01,$14,$1C ; $0B,$01,$0A,$0E char 1
    .BYTE   $15,$01,$0A,$0E ; char 2
    .BYTE   $0B,$0F,$0A,$0E ; char 3
    .BYTE   $15,$0F,$0A,$0E ; char 4
    .BYTE   $01,$09,$0A,$03 ; < new gold box
    .BYTE   $01,$0C,$0A,$11 ; < new option box
    .BYTE   $01,$01,$09,$04 ; < new item title box (also character names for magic screen I think)
    .BYTE   $01,$16,$1E,$07 
    .BYTE   $00,$03,$20,$13 ; < new magic menu box
    
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Enter Equip Menu  [$BACA :: 0x3BADA]
;;
;;    Good old equip menus!  (Weapon and Armor menus).  On entry, the game calls UnadjustEquipStats
;;  to modify the party's stats to be what they would be if all their equipment was removed.  Then on exit
;;  it calls ReadjustEquipStats to modify the party's stats to reflect the equipment they're wearing.
;;  This makes it so it doesn't have to constantly modify stats as you unequip/reequip items in the menu...
;;  and can just do it all at once.
;;
;;  IN:   A = ch_weapons-ch_stats  for weapon menu
;;            ch_armor-ch_stats    for armor menu
;;            this value to be stored in 'equipoffset' by this routine
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


EnterEquipMenu:
    LDA #0
    STA $2001             ; turn off the PPU
    STA joy_a             ; clear joy_a and joy_b counters
    STA joy_b
    STA menustall         ; and turn off menu stalling (since the PPU is off)
    LDA equipoffset
    STA cursor
    
    JSR DrawEquipMenu        ; Draws boxes, name, class, stats, and slots
    JSR DrawEquipMenuStrings ; Draws item names, what is equipped
    JSR TurnMenuScreenOn_ClearOAM
    
  @Loop:
    JSR ClearOAM              ; clear OAM
    JSR DrawEquipMenuCurs     ; draw the cursor
    JSR EquipMenuSprite
    JSR EquipMenuFrame        ; then do an Equip Menu Frame
    
    LDA joy_a
    BNE @A_Pressed            ; check to see if A pressed
    LDA joy_b
    BNE @B_Pressed            ; or B

    JSR MoveEquipMenuCurs     ; if neither A nor B pressed, move the mode cursor
    JMP @Loop                 ; and loop until one of them is pressed

  @A_Pressed:
    JSR LongCall
    .word UnadjustEquipStats
    .byte $0F
    
    LDA cursor
    STA equipoffset
    JSR EnterEquipInventory
    
    JSR LongCall
    .word ReadjustEquipStats
    .byte $0F
    JMP EnterEquipMenu        ; then restart this loop once they exit that sub menu

  @B_Pressed:                 ; if B pressed....
    RTS

EquipMenuSprite:
   LDA #$78
   STA spr_x
   LDA #$17
   STA spr_y
   LDA CharacterIndexBackup 
   JMP DrawOBSprite        ; then draw this character's OB sprite    

EnterEquipInventory:
    LDA #0
    STA $2001             ; turn off the PPU
    STA joy_a             ; clear joy_a and joy_b counters
    STA joy_b             
    STA cursor  
    STA menustall         ; and turn off menu stalling (since the PPU is off)
    JSR ClearNT
    JSR DrawEquipInventory ; Draws boxes, title, "DISCARD" text
    JSR FillItemBoxWithEquipInventory ; Fills item box with inventory
    JSR DrawEquipInventoryStrings  ; Draws names of items in inventory (from item box though!)
    JSR TurnMenuScreenOn_ClearOAM
    LDA #36 ; last 3 are current equipped item
    STA cursor_max
 
    @Loop:
    JSR ClearOAM
    JSR DrawEquipInventoryCursor
    JSR EquipMenuFrame
    
    LDA joy_a
    BNE @A_Pressed            ; check to see if A pressed
    LDA joy_b
    BNE @B_Pressed            ; or B
    LDA joy_select
    BNE @Select_Pressed

    JSR MoveEquipInventoryCursor   ; if neither A nor B pressed, move the mode cursor
    JMP @Loop                      ; and loop until one of them is pressed

  @A_Pressed:
    LDA cursor
    CMP #32
    BEQ @TrashItem
    
    LDX inv_trashswitch
    BNE @TrashIt
    
    TAX                  ; put cursor in X
    LDA item_box, X      ; get item ID
    STA ItemToEquip      ; back it up
    BEQ @DoEquip         ; if its 0, basically swap current equipped item into the empty slot 
    
    LDA equipoffset
    CMP #06
    BCS @DoEquip         ; if offset is over 5--it is either of the battle items
    
    LDA ItemToEquip
    JSR IsEquipLegal     ; if not 0, see if its equippable
    BCC @DoEquip         ; equip it if it is! (swaps item with blank or previous item)
    
    JSR PlaySFX_Error    ; kr-kow if not equippable
    JMP @Loop
    
  @Select_Pressed:
    JSR EquipInventorySwap
    JMP EnterEquipInventory

  @B_Pressed:                 ; if B pressed....
    LDA inv_trashswitch
    BEQ :+
       DEC inv_trashswitch
       JSR GreyCursor
       JMP @Loop
  : RTS
    

    
   @TrashIt:
    DEC inv_trashswitch
    JSR GreyCursor
    
   @DoTrash:
    LDX cursor    
    LDA item_box, X
    BEQ @CannotTrash
    
    CPX #33
    BCC :+
    
    LDA CharacterIndexBackup
    CLC
    ADC equipoffset
    ADC #ch_righthand - ch_stats
    TAX
    LDA #0
    STA ch_stats, X
    JMP :++    

  : LDA #0
    STA item_box, X
    
    JSR FillEquipInventoryWithItemBox ; re-sort inventory list 
  : JMP EnterEquipInventory        ; re-draw the screen
        
   @TrashItem: 
    LDA inv_trashswitch
    BEQ :+
   
   @CannotTrash:   
    JSR PlaySFX_Error ; if switch is on, and cursor is #33, you're trying to trash the discard option! silly.
    JMP @Loop
   
  : INC inv_trashswitch ; turn on switch
    LDA #$07
    STA cur_pal+$1F
    LDA #$16
    STA cur_pal+$1E
    LDA #$26
    STA cur_pal+$1D
    JSR PaletteFrame    ; turn cursor red
    JMP @Loop
 
 
  @DoEquip: ;; JIGS - FINALLY equipping a thing! Sometimes!!
    LDX equipoffset
    LDA lut_EquipOffset, X
    ;TAX
    ;LDA equipoffset
    ;CMP #06
    ;BCS :+
    ;CMP #0
    BNE @DoEquip_ArmourCheck
    
  : LDA equipoffset
    CLC 
    ADC CharacterIndexBackup
    PHA                 ; A is now 0, 40, 80, or C0 + 0, 1, 2, 3, 4, 5, or 6 -- back it up in stack
    TAX
    LDA ch_righthand, X ; ch_righthand is start of equipped items
  
    LDX cursor          ; cursor is still pointing to the item_box spot
    STA item_box, X
    
    PLA
    TAX ; restore the thing
    LDA ItemToEquip
    STA ch_righthand, X
    JMP FillEquipInventoryWithItemBox ; re-sort inventory from item box and return to equip screen
  
  @DoEquip_ArmourCheck:
    DEC ItemToEquip      ; subtract 1
    LDX ItemToEquip      ; put in X 
    INC ItemToEquip      ; and restore
    BEQ :-               ; if its 0, skip this check, because the player is trying to UN-equip!
    LDA lut_ArmorTypes, X ; check type LUT
    CMP equipoffset      ; against equip slot
    BEQ :-              ; if it equals, its in the right slot to continue equipping
      JSR PlaySFX_Error
      JMP @Loop
      
      
      
GreyCursor:
    JSR LoadBattleSpritePalettes ; turn cursor grey
    JMP PaletteFrame      
      
     
EquipInventorySwap:
    LDA #32
    STA cursor_max

    LDA #$14
    STA cur_pal+$1B
    LDA #$24
    STA cur_pal+$1A
    LDA #$34
    STA cur_pal+$19 ; turn Swap cursor Pink
    
    LDA #$1C
    STA cur_pal+$1F
    LDA #$2C
    STA cur_pal+$1E
    LDA #$3C
    STA cur_pal+$1D ; turn main cursor Teal
    JSR PaletteFrame    
    
    @Loop:
    JSR ClearOAM
    LDA cursor
    STA ItemToEquip
    JSR DrawEquipInventoryCursor_Swap
    JSR EquipMenuFrame
    
    LDA joy_a
    BNE @A_Pressed            ; check to see if A pressed
    LDA joy_b
    BNE @B_Pressed            ; or B
    JSR MoveEquipInventoryCursor   ; if neither A nor B pressed, move the mode cursor
    JMP @Loop                      ; and loop until one of them is pressed

  @A_Pressed:
    LDA cursor
    CMP #32
    BEQ @SwapError
    JSR EquipInventorySwap2
    
  @B_Pressed:                 ; if B pressed....
    JSR LoadBattleSpritePalettes ; turn cursor grey
    JSR PaletteFrame
    RTS
    
  @SwapError:
   JSR PlaySFX_Error
   JMP @Loop


EquipInventorySwap2:
    @Loop:
    JSR ClearOAM
    JSR DrawEquipInventoryCursor
    JSR DrawEquipInventoryCursor_Swap
    JSR EquipMenuFrame
    
    LDA joy_a
    BNE @A_Pressed            ; check to see if A pressed
    LDA joy_b
    BNE @B_Pressed            ; or B
    JSR MoveEquipInventoryCursor   ; if neither A nor B pressed, move the mode cursor
    JMP @Loop                      ; and loop until one of them is pressed

  @A_Pressed:
    LDA ItemToEquip
    CMP cursor          ; if first and second selections are equal, error
    BEQ @SwapError
    CMP #32             ; if first selection is Discard option, error
    BEQ @SwapError
    CMP #33             ; if first selection is Equipped item... error
    BEQ @SwapError
    LDX cursor
    CPX #32             ; if second selection is Discard option, error
    BEQ @SwapError
    CPX #33             ; if second selection is Equipped item... error
    BEQ @SwapError
    
    LDA item_box, X     ; get second selection's item
    PHA                 ; push to stack
    LDX ItemToEquip
    LDA item_box, X     ; get first selection
    LDX cursor
    STA item_box, X     ; save in second selection's slot
    LDX ItemToEquip
    PLA                 ; pull second selection's item from stack
    STA item_box, X     ; save in first selection's slot
    JSR FillEquipInventoryWithItemBox

  @B_Pressed:                 ; if B pressed....
    RTS

  @SwapError:
   JSR PlaySFX_Error
   JMP @Loop
   
   

DrawEquipInventoryCursor_Swap:
    LDA ItemToEquip              ; get current cursor and double it (loading X,Y pair)
    JSR JustEquipCursorStuff
    JMP DrawSwapCursor               ; then draw the cursor

DrawEquipInventoryCursor:
    LDA cursor                   ; get current cursor and double it (loading X,Y pair)
    JSR JustEquipCursorStuff
    JMP DrawCursor               ; then draw the cursor

JustEquipCursorStuff:    
    ASL A
    TAX                          ;  put it in X

    LDA lut_EquipInventoryCursor, X    ; load X,Y pair into spr_x and spr_y
    STA spr_x
    LDA lut_EquipInventoryCursor+1, X
    STA spr_y
    RTS

lut_EquipInventoryCursor:
  .BYTE   $08,$28,   $58,$28,   $A8,$28
  .BYTE   $08,$38,   $58,$38,   $A8,$38
  .BYTE   $08,$48,   $58,$48,   $A8,$48
  .BYTE   $08,$58,   $58,$58,   $A8,$58
  .BYTE   $08,$68,   $58,$68,   $A8,$68
  .BYTE   $08,$78,   $58,$78,   $A8,$78
  .BYTE   $08,$88,   $58,$88,   $A8,$88
  .BYTE   $08,$98,   $58,$98,   $A8,$98
  .BYTE   $08,$A8,   $58,$A8,   $A8,$A8
  .BYTE   $08,$B8,   $58,$B8,   $A8,$B8
  .BYTE   $08,$C8,   $58,$C8,   $A8,$C8
  .BYTE   $78,$10 ; Currently equipped item

DrawSwapCursor:
    LDA #<lutSwapCursor             ; load up the pointer to the cursor sprite
    STA tmp                         ; arrangement
    LDA #>lutSwapCursor            ; and store that pointer in (tmp)
    STA tmp+1
    LDA #$F0                        ; cursor tiles start at $F0
    STA tmp+2
    JMP Draw2x2Sprite               ; draw cursor as a 2x2 sprite, and exit
  
lutSwapCursor:
  .BYTE $00, $02      ; UL sprite = tile 0, palette 3
  .BYTE $02, $02      ; DL sprite = tile 2, palette 3
  .BYTE $01, $02      ; UR sprite = tile 1, palette 3
  .BYTE $03, $02      ; DR sprite = tile 3, palette 3
  


FillEquipInventoryWithItemBox: ;; fill inventory from item box - after equipping, swapping, deleting an item!
   ; LDX equipoffset
   ; BEQ :+      ; if 0, its a weapon, so skip ahead
   ; CPX #06
   ; BCS :+
    LDX equipoffset
    LDA lut_EquipOffset, X
    TAX
    BEQ :+
   
    LDX #$40    ; 64 bytes past weapon list
   ; JMP :++     ; X is now the start of weapons or the start of armors  
    
  ;: LDX #0
  : LDY #0 
    STY MMC5_tmp ; Zero these
   @Loop:
    LDA item_box, Y    
    BEQ @Skip        ; if item is blank... INC MMC5_tmp to count how many blank spots there are, then @Resume
        
    @AddtoList:
    STA inv_equip, X   ; save non-blank item next in the inventory
    INX             ; increase X only if non-blank item
  @Resume:  
    INY             
    CPY #$40      
    BNE @Loop    ; Item Box has been checked up to #$20 bytes, but X is not yet at #$20 if there are blanks so...
  
    LDA MMC5_tmp ; check if there are blanks
    BEQ @Done      ; if there are none, exit
  
  @FillBlanks:    ; otherwise, fill the blanks
  : LDA #0
    STA inv_equip, X  
    INX
    DEC MMC5_tmp ; decrease the amount of blanks left to fill 
    LDA MMC5_tmp 
    BNE :-          ; when its 0, stop! 
  @Done:
    RTS    
    
  @Skip:
    INC MMC5_tmp
    JMP @Resume
    
    
FillItemBoxWithEquipInventory: ;; Fill item box with inventory
    ;LDX equipoffset
    ;BEQ :+     ; if 0, its a weapon, so skip ahead
    ;CPX #06
    ;BCS :+
    
    LDX equipoffset
    LDA lut_EquipOffset, X
    TAX
    BEQ :+
    
    LDX #$40 ; 64 bytes past weapon list
    ;JMP :++
    
  ;: LDX #0
  : LDY #0 
    STY MMC5_tmp
    @Loop:
    LDA inv_equip, X
    BEQ @Skip
        
    @AddtoList:
    STA item_box, Y
    INY
    
    @Skip:
    INX
    INC MMC5_tmp
    LDA MMC5_tmp
    CMP #$40 ; 32 bytes 
    BNE @Loop
    
    CPY #$40 ; check if Y hit #$40
    BEQ @Done ; if it did, exit
    
    @FillZeroes: ; if it didn't, there are 0s to fill
    LDA #0
    STA item_box, Y
    INY
    CPY #$40 
    BNE @FillZeroes
    
    @Done:
    RTS


    
    
DrawEquipInventory:
    LDX #1*4                ; Box List
    JSR DrawMenuBox
    LDX #2*4                ; Weapons / Armour
    JSR DrawMenuBox
    DEC dest_y
  
    LDX equipoffset
    LDA lut_EquipOffset, X
    BNE @Armour
    
  @Weapon:
  LDA #$31
  JSR DrawMenuString
  JMP :+
  
  @Armour:
  LDA #$32
  JSR DrawMenuString

: LDX #3*4                ; Item in chosen slot
  JSR DrawMenuBox
  
  DEC dest_y
    
  LDA CharacterIndexBackup
  CLC
  ADC #ch_righthand - ch_stats
  ADC equipoffset
  TAX
  LDA ch_stats, X
  BEQ :++          ; if no item, don't draw
  
  LDY equipoffset
  CPY #06
  BCS @AddWeaponOffset
  CPY #0
  BEQ @AddWeaponOffset
  
  @AddWeaponOffset:
    CLC
    ADC #$1C-1
    JMP :+
  
  @AddArmourOffset:
   CLC
   ADC #$44-1
  
 : STA str_buf+$41
   LDA #0                     
   STA str_buf+$42            
   LDA #$02
   STA str_buf+$40
   
   LDA #>(str_buf+$40)           
   STA text_ptr+1            
   LDA #<(str_buf+$40)           
   STA text_ptr              
 
   JSR DrawMenuComplexString        ; then draw the complex string
  
  : LDA #$17
    STA dest_x
    LDA #$19
    STA dest_y
    LDA #$3B
    JMP DrawMenuString
  











;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Is Equip Legal [$BC0A :: 0x3BC1A]
;;
;;     Checks to see if a specific class can equip a specific item.
;;  ALSO!  This routine modifies the item_box to de-equip all items of the same
;;  type that this character is equipping.  So if you test to see if a weapon is
;;  equippable, and it is, then all other weapons will be unequipped by this routine.
;;  Or if you try to equip a helmet.. all other helmets will be unequipped.
;;
;;  IN:            A = 1-based ID of item to check (0=blank item)
;;       equipoffset = indicates to check weapon or armor
;;            cursor = 4* the character ID whose class we're to check against
;;
;;  OUT:           C = set if equipping is illegal for this class (can't equip it)
;;                     clear if legal (can)
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


IsEquipLegal:
    SEC
    SBC #$01          ; subtract 1 from the item ID to make it zero based
    ASL A             ; double it
    STA tmp           ; tmp = (2*item_id)
   
    LDX CharacterIndexBackup
    LDA ch_class, X   ; get the character's class
    AND #$0F             ;; JIGS - cut off high bits (sprite)
    ASL A             ; double it (2 bytes for equip permissions)
    TAX               ; and put in X to index the equip bit

    LDA lut_ClassEquipBit, X        ; get the class permissions bit position word
    STA tmp+4                       ;  and put in tmp+4,5
    LDA lut_ClassEquipBit+1, X
    STA tmp+5

    ;LDA equipoffset              ; now, see if we're dealing with weapons or armor
    ;CMP #06
    ;BCS @BattleItem
    ;CMP #0
    LDX equipoffset
    LDA lut_EquipOffset, X
    TAX    
    BNE @Armor

  @Weapon:
    LDX tmp                        ; get the weapon id (*2)
    LDA lut_WeaponPermissions, X   ; use it to get the weapon permissions word (low byte)
    AND tmp+4                      ; mask with low byte of class permissions
    STA tmp                        ;  temporarily store result
    LDA lut_WeaponPermissions+1, X ; then do the same with the high byte of the permissions word
    AND tmp+5                      ;  mask with high byte of class permissions
    ORA tmp                        ; then combine with results of low mask
                          ;  here... any nonzero value will indicate that the item cannot be equipped
    CMP #$01                      
    RTS
    

  @Armor:
    LDX tmp                       ; get the armor id (*2)
    LDA lut_ArmorPermissions, X   ; use it to get the armor permissions word
    AND tmp+4                     ;  and mask it with the class permissions word
    STA tmp
    LDA lut_ArmorPermissions+1, X
    AND tmp+5
    ORA tmp               ; and OR both high and low bytes of result together.  A nonzero result here indicates
                          ;  armor cannot be equipped
    CMP #$01
    RTS                   

   @BattleItem:
   CLC
   RTS  


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;   Class Equip Bit LUT   [$BCB9 :: 0x3BCC9]
;;
;;    For weapon/armor equip permissions, each bit coresponds to a class.  If the class's
;;  bit is set for the permissions word... then that piece of equipment CANNOT be equipped
;;  by that class.  Permissions are stored in words (2 bytes) instead of just 1 byte because
;;  there are more than 8 classes
;;
;;    This lookup table is used to get the bit which represents a given class.  The basic
;;  formula is "equip_bit = ($800 >> class_id)".  So Fighter=$800, Thief=$400, etc
;;


lut_ClassEquipBit: ;  FT   TH   BB   RM   WM   BM      KN   NJ   MA   RW   WW   BW
   .WORD            $800,$400,$200,$100,$080,$040,   $020,$010,$008,$004,$002,$001


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;   Armor Type LUT  [$BCD1 :: 0x3BCE1]
;;
;;   This LUT determines which type of armor each armor piece is.  The 4 basic types are:
;;
;;  0 = body armor
;;  1 = shield
;;  2 = helmet
;;  3 = gloves / gauntlets
;;
;;   Note the numbers themselves really don't signify anything.  They're only there to
;;  prevent a player from equipping multiple pieces of armor of the same type.  So you could
;;  have 256 different types of armor if you wanted (even though there are only 40 pieces of
;;  armor  ;P).
;;

lut_ArmorTypes:
;  .BYTE    0,0,0,0,0, 0,0,0,0,0, 0,0,0,0,0, 0        ; 16 pieces of body armor
;  .BYTE    1,1,1,1,1, 1,1,1,1                        ; 9 shields
;  .BYTE    2,2,2,2,2, 2,2                            ; 7 helmets
;  .BYTE    3,3,3,3,3, 3,3,3                          ; 8 gauntlets

  ;; JIGS - "equipoffset" is the slot of armour: shield (left hand), head, body, arms, accessory. In that order.
  ;; So the type of armour in each slot is set here.
  ;; 0 is a weapon!
  
  .byte 3 ; Cloth T
  .byte 3 ; Wooden
  .byte 3 ; Chain
  .byte 3 ; Iron
  .byte 3 ; Steel
  .byte 3 ; Silver  
  .byte 3 ; Flame
  .byte 3 ; Ice
  .byte 3 ; Opal
  .byte 3 ; Dragon
  .byte 5 ; Copper Q
  .byte 5 ; Silver Q
  .byte 5 ; Gold Q
  .byte 5 ; Opal Q
  .byte 3 ; White T
  .byte 3 ; Black T
  
  .byte 1 ; Wooden
  .byte 1 ; Iron
  .byte 1 ; Silver
  .byte 1 ; Flame
  .byte 1 ; Ice
  .byte 1 ; Opal
  .byte 1 ; Aegis
  .byte 1 ; Buckler
  .byte 1 ; ProCape
  
  .byte 2 ; Cap
  .byte 2 ; Wooden
  .byte 2 ; Iron
  .byte 2 ; Silver
  .byte 2 ; Opal
  .byte 2 ; Heal
  .byte 2 ; Ribbon
  
  .byte 4 ; Gloves
  .byte 4 ; Copper
  .byte 4 ; Iron
  .byte 4 ; Silver
  .byte 4 ; Zeus
  .byte 4 ; Power
  .byte 4 ; Opal
  .byte 4 ; ProRing
  
  
    

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  EquipMenuFrame  [$BCF9 :: 0x3BD09]
;;
;;    Same as MenuFrame in that it does all the relevent work that needs to 
;;  be done every frame.  This routine, however, is specifically geared to be
;;  used for the equip menus.  Specifically, it updates the mode attribute
;;  bytes (though that's useless in this ROM).  It also does a few extra
;;  things for the equip menu.
;;
;;  USED:  tmp+7 = used for previous direction info *in addition to* joy_prevdir
;;                 this is apparently so this routine can play the menu move sound effect
;;                 so the rest of the menu code doesn't have to.  joy_prevdir is still used
;;                 in other menu code to detect directional presses for cursor movement, though.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

EquipMenuFrame:
    JSR WaitForVBlank_L     ; wait for VBlank
    LDA #>oam
    STA $4014               ; do sprite DMA

    LDA soft2000          ; reset scroll
    STA $2000
    LDA #$00
    STA $2005
    STA $2005
    
    LDA #BANK_THIS
    STA cur_bank          ; set cur_bank to this bank
    JSR CallMusicPlay     ;   so we can call music play routine

    INC framecounter      ; inc the frame counter to count this frame

    LDA #0                ; clear joy_a and joy_b markers so button presses
    STA joy_a             ;  will be recognized
    STA joy_b
    STA joy_select

    LDA joy               ; get the joy data
    AND #$0F              ; isolate directional buttons
    STA tmp+7             ; and store it as the previous joy data
    JSR UpdateJoy         ; then update joy data

    LDA joy_a
    ORA joy_b             ; see if either A or B pressed
    ORa joy_select
    BEQ @NotPressed       ; if not... jump ahead
    JMP PlaySFX_MenuSel   ; otherwise, play the selection sound effect and exit


  @NotPressed:            ; if neither A nor B have been pressed
    LDA joy               ; get the joy data
    AND #$0F              ; isolate directional buttons
    BEQ @Exit             ; if no directions are pressed, exit

    CMP tmp+7             ; compare current buttons to previous buttons
    BEQ @Exit             ; if no change, then exit

    JMP PlaySFX_MenuMove  ; otherwise, a new button has been pressed, so play the menu move sound, then exit

  @Exit:
    RTS




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Move Equip Menu Cursor [$BD6E :: 0x3BD7E]
;;
;;    Moves the primary/main cursor in the equip menu (the one that actually
;;  moves amongst the charater equipment).
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

MoveEquipMenuCurs:
    LDA joy            ; get joy data
    AND #$0F           ; isolate directional buttons
    CMP joy_prevdir    ; see if there were changes
    BEQ @Exit          ; if not, exit

    STA joy_prevdir    ; otherwise, record changes
    CMP #0             ; see if buttons are being pressed
    BEQ @Exit          ; if not, exit

    CMP #$04           ; see if they're pressing up/down or left/right
    BCS @UpDown
    CMP #$01               ; otherwise, check for left/right
    BNE @Left
    
  @Right:
    LDA CharacterIndexBackup
    CLC
    ADC #$40
    AND #$C0
    STA CharacterIndexBackup
    LDA CharacterEquipBackup
    CLC
    ADC #$01
    JMP :+

  @Left:
    LDA CharacterIndexBackup
    SEC
    SBC #$40
    AND #$C0
    STA CharacterIndexBackup
    LDA CharacterEquipBackup
    SEC
    SBC #$01
  : AND #$03
    STA CharacterEquipBackup
    LDA cursor
    STA equipoffset
    PLA
    PLA
    JMP EnterEquipMenu
 
  @Exit:
    RTS

  @UpDown:
    BNE @Up            ; If not left/right, see if they pressed up or down.

  @Down:
    INC cursor
    LDA cursor         ; If down, add 1 to the cursor (next row)
    CMP #$08
    BNE @Exit
    
    LDA #$00
    STA cursor
    RTS

  @Up:
    DEC cursor
    LDA cursor         
    CMP #$FF
    BNE @Exit
    
    LDA #$07
    STA cursor
    RTS

DrawEquipMenuCurs:
    LDA #$18                   ; all slots are on same X coordinate
    STA spr_x                  ; 
    LDX cursor                 ; get primary cursor
    LDA lut_EquipMenuCurs, X   ; then fetch
    STA spr_y                    ;    and record Y coord
    JMP DrawCursor               ; draw the cursor, and exit

  lut_EquipMenuCurs:
  .BYTE $38
  .BYTE $48    
  .BYTE $58
  .BYTE $68
  .BYTE $78
  .BYTE $88
  .BYTE $98
  .BYTE $A8
  
  

  
  
  
MoveEquipInventoryCursor_Exit:
    RTS

MoveEquipInventoryCursor:
    LDA joy                      ; get joypad state
    AND #$0F                     ; isolate directional buttons
    CMP joy_prevdir              ; compare to previous buttons to see if any have been pressed/released
    BEQ MoveEquipInventoryCursor_Exit ; if there's no change, just exit
    STA joy_prevdir              ;  otherwise record changes
    CMP #0                       ; see if buttons have been pressed (rather than released)
    BEQ MoveEquipInventoryCursor_Exit ; if no buttons pressed, just exit

    CMP #$04               ; now see which button was pressed
    BCS @UpDown            ; check for up/down
    CMP #$01               ; otherwise, check for left/right
    BNE @Left
    
   
  @Right:
     INC cursor
     LDA cursor
     CMP #34  ; if 34, set to 0
     BEQ @OopsRight
     RTS
          
   @OopsRight:
   LDA #0     ; well this doesn't need checking...
   STA cursor
   RTS
   
  @Left:                
     DEC cursor
     LDA cursor
     CMP #33 ; if over 33, then set to... 33 
     BCS @OopsLeft
     RTS
          
   @OopsLeft:
   LDA #33
   STA cursor
   RTS 
   
@UpDown:         ; if we pressed up or down... see which
    BNE @Up

 @Down:                  
    LDA cursor            
    CLC
    ADC #03               
    STA cursor
    CMP #36      ; 33+3 - down to 0
    BCS @OopsDown_3
    CMP #35      ; 32+3 - up to 33
    BCS @OopsDown_2
    CMP #34      ; 31+3 - up to 2
    BCS @OopsDown_1
    CMP #33      ; 30+3 - up to 1
    BCS @OopsDown
    RTS
   
   @OopsDown_3:    
    LDA #0
    JMP :+
   @OopsDown_2:    
    LDA #33
    JMP :+
   @OopsDown_1:    
    LDA #34
   @OopsDown: 
    SEC
    SBC #32
  : STA cursor
    RTS  

  @Up:                    
    LDA cursor
    SEC
    SBC #03       
    CMP #30
    BEQ @OopsUp_2    
    CMP #$FD     ; 0 - 3 ; 
    BEQ @OopsUp_1
    CMP #$FE     ; 1 - 3 ; 
    BCS @OopsUp
    STA cursor
    RTS

   @OopsUp_2:   
    LDA #32
    JMP :+
   @OopsUp_1:   
    LDA #1
   @OopsUp: 
    CLC
    ADC #32
  : STA cursor
    RTS

;  FD FE FF    
;       33  
;   0  1  2
;   3  4  5 
;   6  7  8
;   0 10 11    
;  12 13 14
;  15 16 17
;  18 19 20
;  21 22 23
;  24 25 26
;  27 28 29  
;  30 31 32
    


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Draw Equip Menu  [$BDF3 :: 0x3BE03]
;;
;;    Does not draw the names of the equipment -- only the boxes and other text
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


DrawEquipMenu:
   JSR ClearNT             ; clear the NT
   
   LDX #0*4                
   JSR DrawMenuBox

   LDA CharacterEquipBackup
   STA submenu_targ
 
   LDA #$05
   STA dest_x
   
   LDA #$33
   JSR DrawCharMenuString   ; Name and Class
   
   LDA #$07
   STA dest_y
   LDA #$3A
   JSR DrawMenuString       ; Equipment
   
   LDA #$18
   STA dest_y
   LDA #$03 
   STA dest_x
   LDA #$3C
   JSR DrawCharMenuString  ; Stats
   RTS
   
 DrawMenuBox:
    LDA @lut_MenuBoxes, X    ; use it to index our lut
    STA box_x                 ; and load box coords/dims
    LDA @lut_MenuBoxes+1, X
    STA box_y
    LDA @lut_MenuBoxes+2, X
    STA box_wd
    LDA @lut_MenuBoxes+3, X
    STA box_ht
    JMP DrawBox               ; then draw the box, and return

 @lut_MenuBoxes:
 ;; equip menu boxes
  .BYTE $01,$02,$1E,$1B  ; Name / Sprite / Class

 ;; weapon inventory boxes
  .byte $00,$03,$20,$19  ; big box
  .byte $02,$01,$09,$03  ; weapon / armour
  .byte $11,$01,$0C,$03  ; current item
 
 ;; Status menu boxes 
  .BYTE $08,$02,$10,$0D  ; Name, Class, Level, Exp., Exp to Next
  .BYTE $00,$0F,$10,$0D  ; All main stats
  .BYTE $10,$0F,$10,$0D  ; All sub stats



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Weapon Permissions LUT   [$BF50 :: 0x3BF60]
;;
;;    Weapon permissions.  Each word corresponds to the equip permissions for
;;  a weapon.  See lut_ClassEquipBit for which bit corresponds to which class.
;;  Note again that bit set = weapon CANNOT be equipped by that class.

lut_WeaponPermissions:
  .WORD   $0DE7,$028A,$0400,$02CB,$074D,   $06CB,$07CF,$02CB,$0DE7,$028A
  .WORD   $05C7,$02CB,$06CB,$07CF,$02CB,   $028A,$06CB,$074D,$07CF,$06CB
  .WORD   $06CB,$02CB,$06CB,$06CB,$02CB,   $06CB,$02CB,$0504,$07CF,$0F6D
  .WORD   $0FAE,$0FCB,$0FFE,$0FCB,$0FCA,   $0FCD,$0FCB,$0FEF,$0FDF,$0000
  .WORD   $FFFF ; JIGS - for clearing cheer pose in shops ; item #$28 / #40
  
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Armor Permissions LUT  [$BFA0 :: 0x3BFB0]
;;
;;    Same deal as above, only for the armor instead of the weapons.

lut_ArmorPermissions:
  .WORD   $0000,$00C3,$06CB,$07CF,$07DF,   $06CB,$07CF,$07CF,$0FDF,$0FDF
  .WORD   $0000,$0000,$0000,$0000,$0FFD,   $0FFE,$07CF,$07CF,$07CF,$07CF
  .WORD   $07CF,$0FDF,$0FDF,$02CB,$0208,   $0000,$07CF,$07CF,$07CF,$0FDF
  .WORD   $0FCF,$0000,$0000,$07CF,$07CF,   $07CB,$0FCB,$07CB,$0FDF,$0000
  .WORD   $FFFF ; JIGS - for clearing cheer pose in shops


lut_EquipOffset:
.byte $00,$01,$01,$01,$01,$01,$00,$00








.byte "END OF BANK E"