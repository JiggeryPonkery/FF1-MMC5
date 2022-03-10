.include "variables.inc"
.include "macros.inc"
.include "Constants.inc"
.feature force_range

.export ClearNT
.export EnterMainMenu
.export EnterShop
.export PrintBattleTurn
.export PrintCharStat
.export PrintGold
.export PrintNumber_2Digit
.export PrintPrice
.export TurnMenuScreenOn_ClearOAM
.export BattleBGColorDigits
.export TalkToTile_BankE
.export ConvertBattleNumber

.import AddGPToParty
.import CallMusicPlay
.import ClearOAM
.import CoordToNTAddr
.import DimBatSprPalettes
.import DoOverworld
.import DrawBox
.import DrawComplexString
.import DrawCursor
.import DrawEquipMenuStrings
.import DrawImageRect
.import FillItemBox
.import DrawOBSprite
.import DrawPalette
.import Draw2x2Sprite
.import DrawSimple2x3Sprite
.import EraseBox
.import ExitMenu
.import FadeInSprites
.import FadeOutSprites
.import BackUpPalettes
.import ClearSpritePalette
.import LoadMenuCHRPal
.import LoadPrice
.import LoadShopCHRPal
.import LoadTitleScreenGFX
.import LongCall
.import Magic_ConvertBitsToBytes
.import MenuCondStall
.import MultiplyXA
.import OptionsMenu
.import PaletteFrame
.import PlaySFX_Error
.import RandAX
.import SaveScreen_FromMenu
.import UpdateJoy
.import WaitForVBlank_L
.import lutClassBatSprPalette
.import lut_NTRowStartHi
.import lut_NTRowStartLo
.import ReadjustEquipStats
.import UnadjustEquipStats
.import HideMapObject
.import ShowMapObject
.import PlayDoorSFX
.import BattleRNG_L
.import ItemDescriptions
.import WeaponArmorShopStats
.import WeaponArmorSpecialDesc
.import DrawMenuString_FixedBank
.import DrawMenuString_CharCodes_FixedBank
.import KeyItem_LongCall_Add
.import ADD_ITEM
.import REMOVE_ITEM
.import DOES_ITEM_EXIST
.import Set_Inv_Magic
.import Set_Inv_Weapon
.import SetPPUAddr_XA
.import GetEquipPermissions
.import SetCharStats
.import GetExpToNext
.import Set_Inv_KeyItem
.import DOES_ITEM_EXIST_1BIT
.import ADD_ITEM_1BIT
.import REMOVE_ITEM_1BIT
.import SetPartyStats
.import GetNekked

.segment "BANK_0E"


BANK_THIS = $0E

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  LUT containing stock shop text  [$8000 :: 0x38010]

lut_ShopStrings:
.word ShopWeapon           ;00
.word ShopArmor            ;01
.word ShopWhiteMagic       ;02
.word ShopBlackMagic       ;03
.word ShopGreenMagic       ;04
.word ShopTimeMagic        ;05
.word ShopSkills           ;06
.word ShopItem             ;07
.word ShopTemple           ;08
.word ShopInn              ;09
.word ShopOasis            ;0A

.word ShopGold             ;0B
.word ShopXGoldOK          ;0C
.word ShopHowMany          ;0D
.word ShopBuyExit          ;0E
.word ShopBuySellExit      ;0F
.word ShopYesNo            ;10
.word ShopCharNames        ;11

.word ShopWelcome          ;12 item and equipment welcome
.word ShopMagicWelcome     ;13 magic welcome

.word ShopCantAfford       ;14 you don't have enough money
.word ShopNothingToSell    ;15 you have no inventory to sell
.word ShopCannotCarry      ;16 your inventory is too full (items, equip)
.word ShopOutofStock       ;17 your inventory is too full (magic)
.word ShopCantSell         ;18 you have too much money
.word ShopThankYouWhatElse ;19 confirmed transaction
.word ShopTooBadWhatElse   ;1A canceled transaction

.word ShopArmorDescription  ;1B
.word ShopWeaponDescription ;1C

.word ShopNothingElse      ;1D
;; these 4 unused
;.word ShopEquipNow         ;xx do you want to equip it
.word ShopWhoWillTake      ;1E who is it for
.word ShopCannotEquip      ;1F can't equip it
.word ShopItemStowed       ;20 inventory full of character's other item, new item put in inventory

.word ShopInnWelcome       ;21 inn welcome
.word ShopDontForget       ;22 inn exit/before saving
.word ShopInnSaved         ;23 inn after saving

.word ShopClinicWelcome    ;24 clinic welcome/no one's dead
.word ShopWhoToRevive      ;25 clinic welcome/someone's dead
.word ShopReturnToLife     ;26 character revived

.word ShopHowMany_Sell     ;27


;; note these are NOT the original game's strings. I have edited them to better fit within the new shop screen and add some character to the shops.

ShopWeapon:
.byte $09,$03,$A0,$2B,$B3,$3C,$FF,$9C,$AB,$B2,$B3,$00     ; ___Weapon Shop
ShopArmor:
.byte $09,$03,$8A,$B5,$B0,$35,$FF,$9C,$AB,$B2,$B3,$00     ; ___Armor Shop
ShopWhiteMagic:
.byte $09,$03,$A0,$3D,$53,$FF,$96,$A4,$AA,$AC,$A6,$00     ; ___White Magic
ShopBlackMagic:
.byte $09,$03,$8B,$AF,$5E,$AE,$FF,$96,$A4,$AA,$AC,$A6,$00 ; ___Black Magic
ShopGreenMagic:
.byte $09,$03,$90,$B5,$A8,$A8,$29,$96,$A4,$AA,$AC,$A6,$00 ; ___Green Magic
ShopTimeMagic:
.byte $09,$04,$9D,$AC,$34,$FF,$96,$A4,$AA,$AC,$A6,$00     ; ____Time Magic
ShopSkills:
.byte $FF,$FF,$9C,$AE,$61,$AF,$FF,$9D,$B5,$A4,$1F,$25,$00 ; __Skill Trainer
ShopTemple:
.byte $FF,$9D,$A8,$B0,$B3,$45,$36,$54,$95,$AC,$AA,$AB,$B7,$00 ; _Temple of Light
ShopInn:
.byte $FF,$9D,$B5,$A4,$32,$45,$B5,$BE,$1E,$92,$B1,$B1,$00 ; _Traveler's Inn
ShopItem:
.byte $FF,$FF,$90,$3A,$25,$5F,$FF,$9C,$28,$23,$00         ; __General Store
ShopOasis:
.byte $FF,$8C,$AF,$B2,$3E,$FF,$98,$B8,$21,$9C,$5F,$A8,$00 ; Close Out Sale
ShopGold:
.byte $FF,$90,$00 ; _G

ShopXGoldOK:
.byte $FF,$9D,$41,$21,$A6,$49,$2C,$1B,$B2,$69,$01
.byte $09,$08,$90,$BF,$FF,$B2,$AE,$A4,$BC,$C5,$00 ; That comes to... _____ G, okay?
ShopHowMany:
.byte $09,$04,$91,$B2,$BA,$FF,$B0,$A4,$B1,$BC,$C5,$01
.byte $09,$04,$BA,$AC,$AF,$AF,$FF,$A6,$B2,$B6,$B7,$FF,$BC,$A4,$01
.byte $09,$0B,$90,$00 ; How many? __ will cost ya ________ G
ShopBuyExit:
.byte $8B,$B8,$BC,$01,$8E,$BB,$5B,$00 ; Buy / Exit
ShopBuySellExit:
.byte $8B,$B8,$BC,$01,$9C,$A8,$4E,$01,$8E,$BB,$5B,$00 ; Buy / Sell / Exit
ShopYesNo:
.byte $A2,$A8,$B6,$01,$97,$B2,$00 ; Yes / No
ShopCharNames:
.byte $10,$00,$01
.byte $11,$00,$01
.byte $12,$00,$01
.byte $13,$00,$00

ShopWelcome:
.byte $FF,$FF,$A0,$A8,$AF,$A6,$49,$A8,$C4,$FF,$A0,$41,$B7,$01
.byte $FF,$51,$29,$92,$67,$2E,$BC,$A4,$43,$35,$C5,$00 ; Welcome! What can I do ya for?
ShopMagicWelcome:
.byte $FF,$8A,$AB,$C0,$FF,$8C,$B8,$37,$49,$25,$B6,$C0,$01
.byte $FF,$8D,$2E,$56,$64,$3E,$A8,$AE,$1B,$B2,$01
.byte $AE,$B1,$46,$1B,$1D,$20,$B5,$51,$5A,$C5,$00 ; Ah. Customers. Do you seek to know the arcane?

ShopCantAfford:
.byte $FF,$8A,$A6,$AB,$C4,$FF,$A2,$26,$38,$22,$BE,$B7,$01
.byte $FF,$FF,$A4,$A9,$A9,$35,$27,$1C,$39,$69,$00 ; Ach! You can't afford that.
ShopNothingToSell:
.byte $FF,$8A,$A6,$AB,$C4,$FF,$A2,$26,$67,$3C,$BE,$B7,$01
.byte $FF,$41,$32,$20,$B1,$BC,$1C,$1F,$AA,$C4,$00 ; Ach! You don't have anything!
ShopCannotCarry:
.byte $A2,$26,$38,$22,$BE,$21,$A9,$5B,$20,$B1,$BC,$01
.byte $B0,$35,$1A,$4C,$1B,$1D,$3E,$2D,$B1,$01
.byte $50,$26,$44,$1F,$32,$B1,$28,$B5,$BC,$C4,$00 ; You can't fit any more of these in your inventory!
ShopOutofStock:
.byte $FF,$FF,$9D,$41,$21,$B6,$B3,$A8,$4E,$2D,$B6,$01
.byte $FF,$FF,$26,$21,$4C,$24,$28,$A6,$AE,$C4,$00 ; That spell is out of stock.
ShopCantSell:
.byte $FF,$92,$38,$22,$BE,$21,$A4,$A9,$A9,$35,$A7,$01
.byte $1C,$39,$C4,$FF,$A2,$26,$BE,$23,$1B,$B2,$B2,$01
.byte $FF,$FF,$5C,$A6,$AB,$20,$AF,$23,$A4,$A7,$BC,$C4,$00 ; I can't afford that! You're too rich already.

ShopThankYouWhatElse:
.byte $9D,$41,$B1,$AE,$50,$26,$FF,$AE,$1F,$A7,$AF,$BC,$C4,$01
.byte $FF,$8A,$B1,$BC,$1C,$1F,$47,$A8,$AF,$3E,$C5,$00 ; Thank you kindly! Anything else?
ShopTooBadWhatElse:
.byte $8E,$AB,$BF,$20,$AF,$5C,$AA,$AB,$21,$1C,$3A,$C0,$01
.byte $FF,$8A,$B1,$BC,$1C,$1F,$47,$A8,$AF,$3E,$C5,$00 ; Eh, alright then. Anything else?

;ShopWhatWant:
;.byte $FF,$A0,$41,$B7,$BE,$4E,$2D,$21,$62,$C5,$00 ; What'll it be?
;ShopWhatScroll:
;.byte $FF,$A0,$3D,$A6,$AB,$24,$A6,$4D,$4E,$67,$B2,$01
;.byte $09,$03,$56,$64,$23,$B4,$B8,$AC,$23,$C5,$00 ; Which scroll do you require?
;ShopWhatToSell:
;.byte $FF,$A0,$A8,$4E,$BF,$33,$41,$21,$A7,$BE,$BC,$A4,$01
;.byte $09,$03,$AA,$B2,$21,$A9,$35,$42,$A8,$C5,$00 ; Well, what d'ya got for me?
;ShopMagicToSell:
;.byte $FF,$FF,$92,$33,$61,$58,$B6,$55,$A8,$AF,$BC,$01
;.byte $FF,$38,$2F,$1A,$A9,$35,$50,$26,$B5,$01
;.byte $FF,$24,$A6,$4D,$4E,$1E,$60,$4E,$C0,$00 ; I will surely care for your scrolls well.

ShopArmorDescription:
.byte $FF,$FF,$8D,$A8,$A9,$3A,$3E,$E4,$09,$07,$01         ; __Defense:_______|
.byte $FF,$FF,$8E,$B9,$3F,$AC,$3C,$E4,$09,$07,$01         ; __Evasion:_______|
.byte $FF,$FF,$96,$C0,$9B,$2C,$30,$B7,$E4,$09,$06,$00     ; __M.Resist:______|

ShopWeaponDescription:
.byte $09,$03,$8D,$A4,$B0,$A4,$66,$E4,$09,$07,$01         ; ___Damage:_______|
.byte $FF,$FF,$8A,$A6,$A6,$55,$5E,$BC,$E4,$09,$06,$01     ; __Accuracy:______|
.byte $FF,$FF,$8C,$5C,$57,$51,$AF,$E4,$09,$06,$00         ; __Critical:______|

ShopNothingElse:
.byte $FF,$8A,$AB,$BF,$65,$B2,$B2,$AE,$1E,$68,$AE,$A8,$01
.byte $FF,$1B,$41,$21,$5D,$1E,$1C,$A8,$01
.byte $FF,$FF,$65,$3F,$21,$4C,$2D,$B7,$C0,$00 ; Ah, looks like that was the last of it.

ShopEquipNow:
;.byte $FF,$8D,$2E,$56,$64,$5D,$B1,$21,$28,$01
;.byte $FF,$FF,$A8,$B4,$B8,$AC,$B3,$2D,$21,$B1,$46,$C5,$00 ; Do you want to equip it now?
;
ShopWhoWillTake:
;.byte $FF,$A0,$AB,$2E,$30,$2D,$21,$A9,$35,$C5,$00 ; Who is it for?
;
ShopCannotEquip:
;.byte $FF,$FF,$91,$B2,$AF,$27,$3C,$FF,$B1,$46,$69,$05
;.byte $FF,$A2,$26,$BE,$23,$FF,$B1,$B2,$21,$A4,$A5,$45,$05
;.byte $FF,$1B,$2E,$A8,$B4,$B8,$AC,$B3,$1B,$41,$B7,$C4,$00 ; Hold on now... You're not able to equip that!
;
ShopItemStowed:
;.byte $FF,$91,$A4,$B9,$1F,$47,$B7,$4D,$B8,$A5,$45,$C5,$01
;.byte $92,$BE,$4E,$FF,$AD,$B8,$37,$4F,$B8,$21,$5B,$01
;.byte $FF,$2D,$29,$56,$55,$31,$A4,$AA,$B6,$C0,$00 ; Having trouble? I'll just put it in your bags.

ShopInnWelcome:
.byte $FF,$A0,$A8,$AF,$A6,$49,$A8,$BF,$33,$2B,$B5,$BC,$01
.byte $B7,$B5,$A4,$32,$45,$63,$C4,$FF,$95,$A8,$21,$B8,$B6,$01
.byte $B7,$A4,$AE,$1A,$51,$23,$36,$54,$56,$B8,$C0,$00 ; Welcome, weary travelers! Let us take care of you.

ShopDontForget:
.byte $FF,$8D,$3C,$BE,$21,$A9,$35,$66,$21,$28,$01
.byte $FF,$42,$A4,$AE,$1A,$A4,$65,$B2,$47,$4C,$01
.byte $FF,$50,$26,$44,$B7,$B5,$A4,$32,$AF,$B6,$C4,$00 ; Don't forget to make a log of your travels!

ShopInnSaved:
.byte $8D,$3C,$BE,$21,$56,$64,$A9,$A8,$A8,$58,$B6,$B2,$01
.byte $42,$B8,$A6,$AB,$31,$A8,$B7,$53,$44,$B1,$46,$C5,$01
.byte $C8,$91,$99,$F2,$96,$99,$FF,$9B,$2C,$28,$23,$A7,$C4,$C9,$00 ; Don't you feel so much better now? [HP/MP Restored!]

ShopClinicWelcome:
.byte $95,$B2,$B2,$AE,$1B,$2E,$1C,$1A,$68,$AA,$AB,$B7,$01
.byte $22,$27,$B3,$2B,$48,$31,$1A,$BA,$5B,$AB,$01
.byte $FF,$56,$B8,$BF,$FF,$5D,$B5,$5C,$35,$B6,$C0,$00 ; Look to the light and peace be with you, warriors.

ShopWhoToRevive:
.byte $8F,$35,$20,$1B,$5B,$1D,$FF,$92,$38,$22,$01
.byte $AA,$B5,$22,$21,$56,$55,$43,$5C,$3A,$A7,$01
.byte $FF,$42,$4B,$A5,$45,$B6,$B6,$1F,$AA,$B6,$C0,$00 ; For a tithe I can grant your friend my blessings.

ShopReturnToLife:
.byte $8B,$4B,$1C,$1A,$AA,$B5,$5E,$1A,$4C,$01
.byte $68,$AA,$AB,$B7,$69,$FF,$A0,$2F,$5C,$35,$C4,$01
.byte $9B,$A8,$B7,$55,$29,$28,$65,$AC,$A9,$A8,$C4,$00 ; By the grace of light... Warrior! Return to life!

ShopHowMany_Sell:
.byte $09,$04,$91,$B2,$BA,$FF,$B0,$A4,$B1,$BC,$C5,$01
.byte $09,$04,$BA,$AC,$AF,$AF,$FF,$AA,$A8,$B7,$FF,$BC,$A4,$01
.byte $09,$0B,$90,$00 ; How many? __ will get ya ________ G










;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  LUT containing shop data  [$8300 :: 0x38310]

;; JIGS - once all these shops are used, it probably saves bytes to make each shop's inventory X bytes long
;; and skip this pointer table in favor of just converting the shop ID to a pointer.

lut_ShopData:
.word UnusedShop        ; 00
.word ConeriaWeapon     ; 01
.word ProvokaWeapon     ; 02
.word ElflandWeapon     ; 03
.word MelmondWeapon     ; 04
.word LakeWeapon        ; 05
.word GaiaWeapon        ; 06
.word UnusedShop        ; 07
.word UnusedShop        ; 08
.word UnusedShop        ; 09
.word UnusedShop        ; 0A
.word UnusedShop        ; 0B
.word UnusedShop        ; 0C
.word UnusedShop        ; 0D
.word UnusedShop        ; 0E
.word UnusedShop        ; 0F

;; armor
.word ConeriaArmor      ; 10
.word ProvokaArmor      ; 11
.word ElflandArmor      ; 12
.word MelmondArmor      ; 13
.word LakeArmor         ; 14
.word GaiaArmor         ; 15
.word UnusedShop        ; 16
.word UnusedShop        ; 17
.word UnusedShop        ; 18
.word UnusedShop        ; 19
.word UnusedShop        ; 1A
.word UnusedShop        ; 1B
.word UnusedShop        ; 1C
.word UnusedShop        ; 1D
.word UnusedShop        ; 1E
.word UnusedShop        ; 1F

;; white magic
.word ConeriaWMagic     ; 20
.word ProvokaWMagic     ; 21
.word ElflandWMagic     ; 22
.word MelmondWMagic     ; 23
.word LakeWMagic        ; 24
.word ElflandWMagic2    ; 25
.word GaiaWMagic        ; 26
.word GaiaWMagic2       ; 27
.word OnracWMagic       ; 28
.word LeifenWMagic      ; 29
.word UnusedShop        ; 2A
.word UnusedShop        ; 2B
.word UnusedShop        ; 2C
.word UnusedShop        ; 2D
.word UnusedShop        ; 2E
.word UnusedShop        ; 2F

;; black magic
.word ConeriaBMagic     ; 30
.word ProvokaBMagic     ; 31
.word ElflandBMagic     ; 32
.word MelmondBMagic     ; 33
.word LakeBMagic        ; 34
.word ElflandBMagic2    ; 35
.word GaiaBMagic        ; 36
.word GaiaBMagic2       ; 37
.word OnracBMagic       ; 38
.word LeifenBMagic      ; 39
.word UnusedShop        ; 3A
.word UnusedShop        ; 3B
.word UnusedShop        ; 3C
.word UnusedShop        ; 3D
.word UnusedShop        ; 3E
.word UnusedShop        ; 3F

;; green magic
.word UnusedShop        ; 40
.word UnusedShop        ; 41
.word UnusedShop        ; 42
.word UnusedShop        ; 43
.word UnusedShop        ; 44
.word UnusedShop        ; 45
.word UnusedShop        ; 46
.word UnusedShop        ; 47
.word UnusedShop        ; 48
.word UnusedShop        ; 49
.word UnusedShop        ; 4A
.word UnusedShop        ; 4B
.word UnusedShop        ; 4C
.word UnusedShop        ; 4D
.word UnusedShop        ; 4E
.word UnusedShop        ; 4F

;; time magic
.word UnusedShop        ; 50
.word UnusedShop        ; 51
.word UnusedShop        ; 52
.word UnusedShop        ; 53
.word UnusedShop        ; 54
.word UnusedShop        ; 55
.word UnusedShop        ; 56
.word UnusedShop        ; 57
.word UnusedShop        ; 58
.word UnusedShop        ; 59
.word UnusedShop        ; 5A
.word UnusedShop        ; 5B
.word UnusedShop        ; 5C
.word UnusedShop        ; 5D
.word UnusedShop        ; 5E
.word UnusedShop        ; 5F

;; skills
.word UnusedShop        ; 60
.word UnusedShop        ; 61
.word UnusedShop        ; 62
.word UnusedShop        ; 63
.word UnusedShop        ; 64
.word UnusedShop        ; 65
.word UnusedShop        ; 66
.word UnusedShop        ; 67
.word UnusedShop        ; 68
.word UnusedShop        ; 69
.word UnusedShop        ; 6A
.word UnusedShop        ; 6B
.word UnusedShop        ; 6C
.word UnusedShop        ; 6D
.word UnusedShop        ; 6E
.word UnusedShop        ; 6F

;; items
.word ConeriaItem       ; 70
.word ProvokaItem       ; 71
.word ElflandItem       ; 72
.word LakeItem          ; 73
.word GaiaItem          ; 74
.word OnracItem         ; 75
.word UnusedShop        ; 76
.word UnusedShop        ; 77
.word UnusedShop        ; 78
.word UnusedShop        ; 79
.word UnusedShop        ; 7A
.word UnusedShop        ; 7B
.word UnusedShop        ; 7C
.word UnusedShop        ; 7D
.word UnusedShop        ; 7E
.word CaravanShop       ; 7F

;; The following data was organized by 	Dienyddiwr Da - http://www.romhacking.net/documents/81/ !

;; JIGS - for weapons and armor shops, add +1 because the constants are in 0-based format
;
;Second Price Digits or First Item for Sale
;| First Price Digits or Second Item for Sale
;|  | Third Item for Sale
;|  |  | Fourth Item for Sale
;|  |  |  | Fifth Item for Sale
;|  |  |  |  |   Town			               Explanation
;|__|__|__|__|____|__________________________|_______________________
ConeriaWeapon:
.byte WEP3+1, WEP2+1, WEP1+1, WEP4+1, WEP5+1  ;(Coneria) Wooden Staff, Small Knife, Wooden Nunchuku, Rapier, Iron Hammer
ConeriaArmor:
.byte ARM1+1, ARM2+1, ARM3+1, $00             ;(Coneria) Cloth, Wooden Armor, Chain Armor
ConeriaWMagic:
.byte MG_CURE, MG_HARM, MG_FOG, MG_RUSE, $00  ;(Coneria) CURE, HARM, FOG, RUSE
ConeriaBMagic:
.byte MG_FIRE, MG_SLEP, MG_LOCK, MG_LIT, $00  ;(Coneria) FIRE, SLEP, LOCK, LIT
ConeriaItem:
.byte HEAL, PURE, TENT, $00                   ;(Coneria) Heal, Pure, Tent

ProvokaWeapon:
.byte WEP5+1, WEP6+1, WEP7+1, WEP8+1, $00     ;(Provoka) Iron Hammer, Short Sword, Hand Axe, Scimtar
ProvokaArmor:
.byte ARM2+1, ARM3+1, ARM4+1, ARM17+1, ARM33+1;(Provoka) Wooden Armor, Chain Armor, Iron Armor, Wooden Shield, Gloves
ProvokaWMagic:
.byte MG_LAMP, MG_MUTE, MG_ALIT, MG_INVS, $00 ;(Provoka) LAMP, MUTE, ALIT, INVS
ProvokaBMagic:
.byte MG_ICE, MG_DARK, MG_TMPR, MG_SLOW, $00  ;(Provoka) ICE, DARK, TMPR, SLOW
ProvokaItem:
.byte HEAL, PURE, EYEDROPS, TENT, CABIN       ;(Provoka) Heal, Pure, Tent, Cabin

ElflandWeapon:
.byte WEP9+1, WEP10+1, WEP11+1, WEP12+1, WEP17+1;(Elfland) Iron Nunchuku, Large Knife, Iron Staff, Sabre, Silver Sword
ElflandArmor:
.byte ARM4+1, ARM11+1, ARM18+1, ARM26+1, ARM27+1;(Elfland) Iron Armor, Copper Bracelet, Iron Shield, Cap, Wooden Helmet
ElflandWMagic:
.byte MG_CUR2, MG_HRM2, MG_AFIR, MG_REGN, $00 ;(Elfland) CUR2, HRM2, AFIR, HEAL
ElflandBMagic:
.byte MG_FIR2, MG_HOLD, MG_LIT2, MG_LOK2, $00 ;(Elfland) FIR2, HOLD, LIT2, LOK2
ElflandWMagic2:
.byte MG_PURE, MG_FEAR, MG_AICE, MG_AMUT, $00 ;(Elfland) PURE, FEAR, AICE, AMUT
ElflandBMagic2:
.byte MG_SLP2, MG_FAST, MG_CONF, MG_ICE2, $00 ;(Elfland) SLP2, FAST, CONF, ICE2

ElflandItem:
.byte HEAL, PURE, TENT, CABIN, SOFT            ;(Elfland) Heal, Pure, Tent, Cabin, Soft
MelmondWeapon:
.byte WEP11+1, WEP12+1, WEP13+1, WEP15+1, $00 ;(Melmond) Iron Staff, Sabre, Long Sword, Falchion
MelmondArmor:
.byte ARM5+1, ARM12+1, ARM28+1, ARM34+1, ARM35+1;(Melmond) Steel Armor, Silver Bracelet, Iron Helmet, Copper Gauntlet, Iron Gauntlet
MelmondWMagic:
.byte MG_CUR3, MG_LIFE, MG_HRM3, MG_RGN2, $00 ;(Melmond) CUR3, LIFE, HRM3, HEL2
MelmondBMagic:
.byte MG_FIR3, MG_BANE, MG_WARP, MG_SLO2, $00 ;(Melmond) FIR3, BANE, WARP, SLO2

LakeWeapon:
.byte WEP16+1, WEP17+1, WEP18+1, WEP19+1, $00 ;(Cresent Lake) Silver Knife, Silver Sword, Silver Hammer, Silver Axe
LakeArmor:
.byte ARM6+1, ARM19+1, ARM24+1, ARM29+1, ARM36+1 ;(Cresent Lake) Silver Armor, Silver Shield, Buckler, Silver Helmet, Silver Gauntlet
LakeWMagic:
.byte MG_SOFT, MG_EXIT, MG_FOG2, MG_INV2, $00 ;(Cresent Lake) SOFT, EXIT, FOG2, INV2
LakeBMagic:
.byte MG_LIT3, MG_RUB, MG_QAKE, MG_STUN, $00  ;(Cresent Lake) LIT3, RUB, QAKE, STUN

LakeItem:
.byte HEAL, PURE, TENT, CABIN, ALARMCLOCK     ;(Cresent Lake) Heal, Pure, Tent, Cabin
GaiaWeapon:
.byte WEP35+1, $00                            ;(Gaia) CatClaw
GaiaArmor:
.byte ARM13+1, ARM40+1, $00                   ;(Gaia) Gold Bracelet, ProRing
GaiaWMagic:
.byte MG_CUR4, MG_HRM4, $00                   ;(Gaia) CUR4, HRM4
GaiaBMagic:
.byte MG_ICE3, MG_BRAK, $00                   ;(Gaia) ICE3, BRAK
GaiaWMagic2:
.byte MG_FADE, MG_WALL, MG_XFER, $00          ;(Gaia) FADE, WALL, XFER
GaiaBMagic2:
.byte MG_STOP, MG_ZAP, MG_XXXX, $00           ;(Gaia) STOP, ZAP!, XXXX
GaiaItem:
.byte CABIN, HOUSE, HEAL, PURE, PHOENIXDOWN   ;(Gaia) Cabin, House, Heal, Pure

OnracWMagic:
.byte MG_ARUB, MG_RGN3, $00                   ;(Onrac) ARUB, HEL3
OnracBMagic:
.byte MG_SABR, MG_BLND, $00                   ;(Onrac) SABR, BLND
OnracItem:
.byte TENT, CABIN, HOUSE, PURE, SOFT          ;(Onrac) Tent, Cabin, House, Pure, Soft

CaravanShop:
.byte X_HEAL, ETHER, ELIXIR, SMOKEBOMB, BOTTLE;(Caravan) Bottle

LeifenWMagic:
.byte MG_LIF2, $00                            ;(Leifen) LIF2
LeifenBMagic:
.byte MG_NUKE ,$00                            ;(Leifen) NUKE

UnusedShop:
.byte HEAL,$00

;; Coneraia      - 40
;; Pravoka       - 80
;; Elfland       - 200
;; Crescent Lake - 400
;; Onrac / Gaia  - 750 g


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
    CMP #$03       ; is ID == $03?
    BEQ @Level     ; if yes, print Level
    CMP #$04
    BEQ @Exp       ; if $04, print Exp
    CMP #$05
    BEQ @CurHP     ; if $05, print CurHP
    CMP #$06
    BEQ @MaxHP     ; if $06, print MaxHP
    CMP #$16
    BCC @MainStat  ; if under $16, do main stats
    CMP #$1E
    BCC @SubStats  ; if under $1E, do sub stats
    CMP #$20
    BCC @ExpToNext ; if under $20, do Exp to next level
    CMP #$28
    BCC @CurMP     ; if under $28, do current MP
    ; else, its max MP

   @MaxMP:
    ;; A = 30-37
    CLC
    ADC char_index   ; add character index
    TAX
    LDA ch_stats, X  ; get MP
    AND #$0F         ;; JIGS - clear out current MP for max MP only
    STA tmp          ;  and print it as 1 Digit
    JMP PrintNumber_1Digit

   @CurMP:
    ;; A = 20-27
    ; Carry is clear from the branch
    ADC #$10         ; mp is +$10 from $20 in ch_stats
    ADC char_index   ; add character index
    TAX
    LDA ch_stats, X  ; get MP
    AND #$F0         ;; JIGS - cut off max MP to get only current MP
    LSR A            ; and move it to low bits
    LSR A
    LSR A
    LSR A
    STA tmp          ;  and print it as 1 Digit
    JMP PrintNumber_1Digit

   ;;  Stat Code = $03 -- character level
   @Level:
    LDX char_index   ; Get Character index
    LDA ch_level, X  ; Get character's level
    CLC
    ADC #$01         ; Add 1 to it ($00 is "Level 1")
    BNE :+           ; jump ahead to print it as 2 digits

   @MainStat:
    ;; A = stat
    ; Carry is clear from the branch
    ADC char_index
    TAX
    LDA ch_stats, X
  : STA tmp
    JMP PrintNumber_2Digit

   @SubStats:
    ;; A = substat
    ; Carry is clear from the branch
    TAX
    LDA MenuStats-$16, X ; get the substat, -$16 since X will be offset by $16 from the control code
    STA tmp             ; write it as low byte
    LDA #0              ; set mid byte to 0 (need a mid byte for 3 Digit printing)
    STA tmp+1           ;  and print as 3 digits
    JMP PrintNumber_3Digit

    ;;; all other codes default to Exp to Next level
@ExpToNext:
    JSR PrintEXPToNext
    JMP PrintNumber_5Digit

@Exp:
    LDABRA <ch_exp, @Stat6Digit    ; put low byte of address of desired stat in A, then BRA to @Stat6Digit
                                   ;  see macros.inc for this macro
@CurHP:
    LDABRA <ch_curhp, @Stat3Digit

@MaxHP:
    LDABRA <ch_maxhp, @Stat3Digit


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


PrintEXPToNext:
    LDX char_index
    LDA ch_level, X
    CMP #50
    BNE :+
        LDA #0
        STA tmp+6
        STA tmp+7
        STA tmp+8
        RTS

  : JSR LongCall
    .word GetExpToNext
    .byte BANK_Z

    LDX #0
    LDY #3       ; use Y as a counter, because comparing X messes with carry
    SEC          ; a bad thing to do when subtracting in a loop!
   @Subtract:
    LDA tmp+9, X ; EXP to next
    SBC tmp+6, X ; current EXP
    STA tmp, X
    INX
    DEY
    BNE @Subtract

    LDA #0       ; always clear tmp+2 for output; EXP to Next is really only 2 bytes
    STA tmp+2    ; since its the number between level up values
    RTS          ; so from level 3 to 4, its 547 - 196 = 351


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

ConvertBattleNumber:
    LDA MMC5_tmp
    STA tmp
    LDA MMC5_tmp+1
    STA tmp+1
    LDA MMC5_tmp+2
    LSR A
    BCS PrintNumber_2Digit
    LSR A
    BCS PrintNumber_3Digit
    JMP PrintNumber_4Digit

BattleBGColorDigits:
    LDA BattleBGColor
    STA tmp
    INC tmp
    JMP PrintNumber_2Digit

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


TalkToTile_BankE:
   LDA tileprop
   AND #TP_SPEC_MASK
   CMP #TP_SPEC_MP
   BEQ @HealpMP
   CMP #TP_SPEC_HPMP
   BEQ @HealBoth
   CMP #TP_SPEC_CUREDEATH
   BEQ @HealDeath
   CMP #TP_SPEC_CUREAIL
   BEQ @HealAilments
 ; CMP #TP_SPEC_HP
 ; BEQ @HealHP

  @HealHP:
   JSR MenuFillPartyHP
   JMP PlayHealSFX_Map

  @HealpMP:
   JSR MenuRecoverPartyMP
   JMP PlayHealSFX_Map

  @HealBoth:
   JSR FullHealingTile
   JMP PlayHealSFX_Map

  @HealDeath:
   LDA %11111110            ; get every ailment EXCEPT death
   STA tmp                  ; store in tmp
   BNE CurePartyAilment

  @HealAilments:
   LDA #AIL_DEAD            ; get only the death ailment
   STA tmp

CurePartyAilment:
    LDX #0                   ; zero X
  : LDA ch_ailments, X       ; get character ailment
    AND tmp                  ; AND to cut out everything except the ailment to cure
    STA ch_ailments, X       ; save it
    LDA ch_curhp, X          ; then check their HP
    BNE :+                   ; if they have more than 0
        LDA ch_curhp+1          ; check the high byte
        BNE :+               ; if THAT has more than 0, then they're fine, skip ahead
        CLC                  ; otherwise, give them 1 HP
        ADC #1
        STA ch_curhp, X
  : TXA                      ; transfer X to A
    CLC                      ; add #$40
    ADC #$40                 ; to index the next character
    TAX
    BEQ :--                  ; if A = 0, the index wrapped, exit
    JMP PlayHealSFX_Map





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
      LSR A
      ROR A
      ROR A
      ;AND #$C0                  ; and shift it to a useable character index
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

       ;JSR PlaySFX_MenuSel         ; play the selection sound effect
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
    BNE ClearNT_Color

ScreenOff_ClearNT:
    LDA #0
    STA $2001            ; turn the PPU off
    STA menustall        ; and disable menu stalling

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



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Enter Shop [$A330 :: 0x3A340]
;;
;;  IN:  shop_id
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

EnterShop:
    JSR ClearButtons
    STA $2001              ; turn off PPU
    STA $4015              ; silence audio
    STA $5015              ; and silence the MMC5 APU. (JIGS)
    STA item_pageswap      ; is used to display prices (0 = items, magic; 1 = weapons, armor)
    STA shop_descriptionset ; zero shop_spell and shop_descriptionset (shared)

    LDX #$B0
   @ClearLoop:
    STA item_box-1, X
    DEX
    BNE @ClearLoop

   @ClearShopVars:
    STA item_box_offset, X ; clear zero RAM variables, from $5C to $7F
    INX
    CPX #$7F-$5C
    BNE @ClearShopVars

    JSR LoadShopCHRPal     ; load up the CHR and palettes (and the shop type)
    JSR DrawShop           ; draw the shop (and load inventory)

    LDA shop_type          ; use the shop type to get the entry point for this shop
    CMP #SHOP_CLINIC
    BEQ @EnterClinic
    CMP #SHOP_INN
    BEQ @EnterInn

   @EnterShop:
    LDA #$4F
    STA music_track        ; set the music track to $4F (shop music)
    STA dlgmusic_backup
    LDX shop_type
    STX tmp+$13            ; backup shop type
    JMP EnterNormalShop

   @EnterClinic:
    LDA #$48               ; for clinic (castle music, closest thing to a nice temple song!)
    STA music_track
    STA dlgmusic_backup
    JMP EnterClinic

   @EnterInn:
    LDA #$51               ; for inn (the original menu music)
    STA music_track
    STA dlgmusic_backup    ; to replay inn music after saving
    JMP EnterInn


lut_ShopWelcome: ; uses shop_type to pick what lut_ShopStrings text to display
.byte $12 ; 0 weapons
.byte $12 ; 1 armor
.byte $13 ; 2 white magic
.byte $13 ; 3 black magic
.byte $13 ; 4 green magic
.byte $13 ; 5 time magic
.byte $13 ; 6 skills
.byte $12 ; 7 item shop, caravan

lut_ShopMaxAmount: ; maximum amount of this shop's item you can hold in your inventory
.byte 15 ; 0 weapons
.byte 15 ; 1 armor
.byte 4  ; 2 white magic
.byte 4  ; 3 black magic
.byte 4  ; 4 green magic
.byte 4  ; 5 time magic
.byte 4  ; 6 skills
.byte 99 ; 7 item shop, caravan




CheckMagicInventory:
    LDA shop_curitem
    SEC
    SBC #1; ITEM_MAGICSTART   ; convert item ID to spell ID
    STA shop_spell
    PHA                    ; push spell ID to stack
    LSR A
    LSR A
    LSR A
    LSR A                  ; shift to get the spell level
    CLC
    ADC #$81               ; convert it to a printable number
    STA str_buf+$3B, Y     ; put this spell's level in the string buffer

    JSR Set_Inv_Magic

    PLA                    ; pull spell ID
    JSR DOES_ITEM_EXIST    ; checks if you have it in your inventory, and puts the amount in A

    STA shop_amount
    LDA shop_selling       ; if selling, don't list what is equipped
    BNE @End

    INC shop_spell         ; increase to 1-based

    LDA #0                 ; start with char_index 0
   @Loop:
    PHA                    ; push char_index
    TAX

    LDY #24
   @SearchMagicLoop:
    LDA ch_spells, X       ; check the unrolled spell list
    CMP shop_spell         ; see if their spell matches the ID of the spell trying to buy
    BEQ @FoundOne
    INX
    DEY
    BEQ @NextChar
    BNE @SearchMagicLoop

   @FoundOne:
    INC shop_amount        ; increase the # of spells if found

   @NextChar:
    PLA                    ; pull the char_index, add $40
    CLC                    ;
    ADC #$40               ;
    BNE @Loop              ; when it wraps around to 0 again, its done!
   @End:
    RTS

CheckEquipmentInventory:
    JSR Set_Inv_Weapon     ; first set it to weapons
    LDX shop_curitem
    DEX                    ; convert item ID to 0-based
    TXA
    JSR DOES_ITEM_EXIST    ; checks if you have it in your inventory, and puts the amount in A

    STA shop_amount
    LDA shop_selling       ; if selling, don't list what is equipped
    BNE @End

    LDA #0
   @Loop:
    PHA                    ; push 0 to use as character ID
    TAX

    LDY #8
   @SearchEquipmentLoop:
    LDA ch_righthand, X
    CMP shop_curitem
    BNE @NextSlot

   @FoundOne:
    INC shop_amount        ; increase the # of this item found

   @NextSlot:
    INX
    DEY                    ; loop through all 8 equipment slots
    BEQ @NextChar
    BNE @SearchEquipmentLoop

   @NextChar:
    PLA                    ; pull the char_index, add $40
    CLC                    ;
    ADC #$40               ;
    BNE @Loop              ; when it wraps around to 0 again, its done!
   @End:
    RTS




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


EnterNormalShop:
    LDA lut_ShopWelcome, X
    JSR DrawShopDialogueBox     ; draw the "welcome" dialogue
    LDA shop_id
    CMP #SHOP_CARAVAN_ID
    BNE MainShopLoop

EnterCaravan:
    LDA #SHOPBOX_COMMAND
    JSR DrawMainItemBox      ; draw shop box ID=3 (the command box)
    LDA #$0E
    JSR DrawShopString       ; draw shop string ID=$0B ("Buy"/"Exit")
    LDA #2
    STA cursor_max           ; 2 cursor options
    LDA #0
    STA cursor
    JSR CommonShopLoop_Cmd   ; do the common shop loop
    BCS ReturnToMap
    LDA cursor
    BEQ ShopBuy
    RTS                      ; no selling to the Caravan, he's trying to retire

RestartShopLoop:
    JSR ResetShopList_Extras
    LDA #$1A
    JSR DrawShopDialogueBox     ; "eh, alright then, what else?"
    LDA shop_id
    CMP #SHOP_CARAVAN_ID
    BEQ EnterCaravan

MainShopLoop:
   ; LDA tmp+$13                   ; left/right in sell mode will change shop_type, so...
   ; STA shop_type                 ; reset shop_type from backup

    LDA inv_canequipinshop        ; if this is set, characters will dance if they can equip the item the cursor is pointing at
    BEQ :+                        ; so it has to be turned off unless the cursor is pointing at weapons or armor
    JSR Shop_CharacterStopDancing

  : LDA #SHOPBOX_COMMAND
    JSR DrawMainItemBox      ; draw box 3 (command box)
    LDA #$0F
    JSR DrawShopString       ; string 0C ("Buy Sell Exit")
    LDA #$03
    STA cursor_max           ; 3 options
    LDA #0
    STA cursor
    JSR CommonShopLoop_Cmd   ; do command loop
    BCS ReturnToMap

    JSR HideShopCursor
    LDA cursor
    BEQ ShopBuy
    CMP #1
    BNE ReturnToMap
    JMP ShopSell

ReturnToMap:                ; this should fix the weird flicker when leaving a shop...
    JSR WaitForVBlank_L
    LDA #0
    STA $2001               ; turn off APU and PPU
    STA $4015
    STA $5015               ; MMC5 - JIGS
    JMP WaitForVBlank_L

ShopBuy:
    LDA #SHOPBOX_COMMAND
    JSR EraseMainItemBox         ; erase shop box #3 (command box)

ShopBuy_Loop:
    JSR DrawShopInventoryBox
    JSR LoadShopInventory

    LDX shop_type
    LDA lut_ShopMaxAmount, X    ; gets either #99, #15, or #4 depending on shop type
    STA shop_amount_max

    ;; ShopSelectItem also draws the text in the inventory box

    JSR ShopSelectItem          ; let them choose an item from the shop inventory (fills str_buf with item IDs and everything!)
    BCS RestartShopLoop         ; if they pressed B, restart the loop

    JSR ShopCheckInventory      ; reads the list to see how many of the chosen item you have

    LDA shop_amount_max         ; get max
    SEC
    SBC shop_amount             ; subtract total in inventory/on characters
    STA shop_amount_max         ; save as new max
    BNE @ShopSelectAmount_Prep  ; if its not 0, go buy more

    JSR HideShopCursor
    LDA shop_type               ; get shop type again
    CMP #SHOP_ITEM
    BEQ @Normal
    CMP #SHOP_WHITEMAGIC
    BCS @Scrolls

   @Normal:
    LDA #$16                     ; load up "you can't carry any more" string ID
    BNE @DrawDialogue_AndReturn  ; print it and return

   @Scrolls:
    LDA #$17                     ; "That spell is out of stock"

   @DrawDialogue_AndReturn:
    JSR DrawShopDialogueBox
    JSR MenuWaitForBtn
    JMP ShopBuy

   @ShopSelectAmount_Prep:
    STA shop_amount_buy         ; save max amount as amount to try buying
  : JSR ShopLoadPrice_Complex   ; load the price for this many items
    JSR Shop_CanAfford          ; does the player have the money for it?
    BCC @ShopSelectAmount_PrepResume ; if yes, jump ahead

    DEC shop_amount_buy         ; if not, decrement the amount to try buying
    BNE :-                      ; until it reaches 0...
      JSR HideShopCursor        ; if you can't even buy ONE of this item
      LDA #$14
      JSR DrawShopDialogueBox   ; draw "you can't afford it" dialogue
      JSR MenuWaitForBtn
      JMP ShopBuy_Loop          ; and return to loop

   @ShopSelectAmount_PrepResume:
    LDA shop_amount_buy         ; set the amount_max to the amount possible to buy
    STA shop_amount_max
    INC shop_amount_max         ; increase it for SelectAmount_Buy to work right
    LDA #1
    STA shop_amount_buy         ; reset amount_buy to 1

ShopSelectAmount:
    LDA shop_type
    CMP #SHOP_ITEM
    BCC :+                      ; if its not an item shop, skip this check

    LDA shop_curitem            ; if it is an item shop, see if its a key item
    CMP #ITEM_KEYITEMSTART
    BCC :+
       JMP @BuyConfirm          ; if its is, you can only buy one

  : JSR SelectAmount            ; choose how many of an item to buy
    BCS @ShopBuy_Return         ; if B was pressed, go back to choosing an item

   @BuyConfirm:
    JSR ShopXGoldOkay           ; turns off dancing and prints the price to pay
    JSR ShopLoop_YesNo          ; give them the yes/no option
    BCS @ShopBuy_Return ; ShopSelectAmount        ; if they pressed B, return to selecting the amount
    LDA cursor
    BNE @ShopBuy_Return ; ShopSelectAmount        ; if they selected "No", return to selecting the amount
    ;; JIGS - it backs up further until I can get the cursor pointing back at the item they were trying to buy

   @CompletePurchase:
    LDA shop_type
    CMP #SHOP_WHITEMAGIC
    BCC @AddEquipment
    CMP #SHOP_ITEM
    BCC @AddMagic

   @AddItem:
    LDX shop_curitem
    CPX #ITEM_KEYITEMSTART
    BCS BuyKeyItem

    LDA items, X                ; load the current amount
    CLC
    ADC shop_amount_buy         ; add in the amount to buy
    STA items, X                ; and save
    BNE FinishPurchase

   @AddEquipment:
    ;LDA shop_amount_buy
    ;CMP #1
    ;BNE :+                      ; if buying more than one, skip equip offer
    ;
    ;JSR EquipShop_EquipNow
    ;; ^ checks if you want to give it to a character
    ;; If you are able to, it will pull the return address and jump to FinishPurchase
    ;; At this point, its either equip it or store it in inventory, it will not undo the purchase

    ; :
    JSR Set_Inv_Weapon
    JMP :+

   @ShopBuy_Return:
    JMP ShopBuy

   @AddMagic:
    JSR Set_Inv_Magic
  : LDX shop_curitem
    DEX
    TXA                         ; convert ID to 0-based
    JSR ADD_ITEM
    DEC shop_amount_buy
    BNE :-
    ;; JIGS - just loop this until the amount purchased is converted!
    BEQ FinishPurchase

BuyKeyItem:
    JSR Set_Inv_KeyItem
    TXA
    JSR ADD_ITEM_1BIT

FinishPurchase:
    JSR ShopPayPrice            ; subtract the price from your gold amount
    LDA #$19
    JSR DrawShopDialogueBox     ; "Thank you, anything else?" dialogue
    JSR UpdateShopList
    JMP MainShopLoop


DrawShopInventoryBox:
    LDA #0
    STA cursor
    STA shop_selling

    ;; JIGS - while I like not re-drawing the box every single time...
    ;; it does make the game feel laggy when you don't see a change for 1-2 seconds.
    ;; so this "feels" better...

    ;LDA shop_listdrawn          ; don't draw the box if its marked as already drawn
    ;BNE :+
    LDA #SHOPBOX_INV
    JSR DrawMainItemBox             ; draw shop box #2 (inv list box)
    ;INC shop_listdrawn
  ;: RTS
    RTS


ShopSell:
    JSR ConvertInventoryToItemBox
    BNE :+
    JMP NothingToSell

  : LDA #SHOPBOX_COMMAND
    JSR EraseMainItemBox        ; erase shop box #3 (command box)

ShopSell_Loop:
    JSR DrawShopInventoryBox

    INC shop_selling

    ;; ShopSelectItem also draws the text in the inventory box

    JSR ShopSelectItem
    BCC :+
    DEC shop_selling
    JMP RestartShopLoop

  : JSR ShopCheckInventory     ; see how many of this item you have
    STA shop_amount_max
    INC shop_amount_max        ; needs to be 1 over max for the SelectAmount stuff to work
    LDA #1
    STA shop_amount_buy

ShopSelectAmount_Sell:
    JSR SelectAmount
    BCS ShopSell

    JSR Shop_CanShopkeepAfford
    BCC @SellConfirm
      LDA #$18
      JSR DrawShopDialogueBox   ; if they can't, "you're too rich already!"
      JSR MenuWaitForBtn
      JMP ShopSelectAmount_Sell

   @SellConfirm:
    JSR ShopXGoldOkay
    JSR ShopLoop_YesNo          ; give them the yes/no option
    BCS ShopSell        ; ShopSelectAmount        ; if they pressed B, return to selecting the amount
    LDA cursor
    BNE ShopSell        ; ShopSelectAmount        ; if they selected "No", return to selecting the amount
    ;; JIGS - it backs up further until I can get the cursor pointing back at the item they were trying to buy

   @CompleteSale:
    LDA shop_type
    CMP #SHOP_WHITEMAGIC
    BCC @RemoveEquipment
    CMP #SHOP_ITEM
    BCC @RemoveMagic

   @RemoveItem:
    LDX shop_curitem
    LDA items, X                ; load the current amount
    SEC
    SBC shop_amount_buy         ; add in the amount to buy
    STA items, X                ; and save
    JMP FinishSale

   @RemoveEquipment:
    JSR Set_Inv_Weapon
    JMP :+

   @RemoveMagic:
    JSR Set_Inv_Magic
  : LDX shop_curitem
    DEX
    TXA                         ; convert equipment/magic to 0-based
    JSR REMOVE_ITEM
    DEC shop_amount_buy
    BNE :-

FinishSale:
    JSR ShopEarnGold            ; add the price to your gold amount
    JSR ConvertInventoryToItemBox
    BNE ContinueSelling

 ;; nothing left...

    LDA #$1D
    JSR DrawShopDialogueBox     ; "that was the last of it."
    JSR MenuWaitForBtn          ; wait for player to confirm seeing this
    JMP NothingLeftToSell

ContinueSelling:
    JSR UpdateShopList
    LDA #$19
    JSR DrawShopDialogueBox     ; "Thank you, anything else?" dialogue

    JSR ShopLoop_YesNo
    BCS StopSelling             ; if B was pressed...
    LDA cursor
    BNE StopSelling
    JMP ShopSell_Loop           ; else continue loop

StopSelling:
    LDA #$1A
    JSR DrawShopDialogueBox     ; "eh, alright then, what else?"

NothingLeftToSell:
    LDA #SHOPBOX_INV
    JSR EraseMainItemBox        ; erase shop box 2 (inventory)
    JSR ResetShopList_Extras
    JMP :+                      ; and jump to stop selling

NothingToSell:
    LDA #$15                    ; "You haven't got anything!"
    JSR DrawShopDialogueBox
    JSR MenuWaitForBtn          ; wait for player to confirm seeing this

  : LDA #0
    STA shop_selling
    ;STA shop_listdrawn
    JMP MainShopLoop



;;;;;;;;;;;;;;;;;;;;;

ShopCheckInventory:
    LDX cursor
    LDA item_box, X             ; get chosen item ID
    STA shop_curitem            ; save it

    LDY shop_type
    CPY #SHOP_ITEM
    BCC :+                      ; if not an item shop, jump ahead

    CMP #ITEM_KEYITEMSTART
    BCC :+                      ; if not a key item, jump ahead

    LDA #1                      ; otherwise, its a key item--and you don't have it, or it wouldn't be in the list
    STA shop_amount_buy
    JSR ShopLoadPrice_Complex   ;; JIGS - something might break here...
    PLA
    PLA
    JMP ShopSelectAmount

  : LDA #13
    JSR MultiplyXA              ; multiply cursor position by each item's str_buf length
    TAY

    ;LDA str_buf+$42, Y          ; item ID
    ;STA shop_curitem

    LDA str_buf+$46, Y
    CMP #$FF
    BNE @DoubleDigit

   @SingleDigit:
    LDA str_buf+$45, Y
    AND #$0F                    ; convert from tile ID to byte
    JMP :+

   @DoubleDigit:
    LDA str_buf+$45, Y
    AND #$0F
    LDX #10                     ; multiply by $0A to convert to hex tens column
    JSR MultiplyXA
    STA shop_amount_high
    LDA str_buf+$46, Y
    AND #$0F                    ; convert from tile ID to byte
    CLC
    ADC shop_amount_high        ; add in 0 or tens column
  : STA shop_amount
    RTS

ShopXGoldOkay:
    JSR HideShopCursor
    JSR WaitForVBlank_L
    JSR ResetShop_Marks         ; turn off dancing and marks, but leave light blue bar

    LDA #$0C
    JSR DrawShopDialogueBox     ; draws "Gold  OK?" -- IE:  all the non-price text

    LDA #<(str_buf+$B9)         ; get price from here (see PrintShopAmount)
    STA text_ptr
    LDA #>(str_buf+$B9)
    STA text_ptr+1

    LDA #03
    STA dest_x
    INC dest_y
    INC dest_y
    JMP DrawShopComplexString

;;;;;;;;;;;;;;;;;;;;;

;; JIGS - this is broken and breaks the flow of purchasing things
;; since the equip screen is better used to compare new gear vs. old, most people will prefer that anyway

;EquipShop_EquipNow:
;    LDA #$1D                     ; "Do you want to equip it now?"
;    JSR DrawShopDialogueBox
;    JSR ShopLoop_YesNo
;    BCS EquipOnCharacter_Exit
;    LDA cursor
;    BNE EquipOnCharacter_Exit
;
;EquipOnCharacter:
;    LDA #$1E
;    JSR DrawShopDialogueBox      ; "who is it for?"
;    JSR ShopLoop_CharNames       ; have the player select a character
;    BCS @TroubleExit             ; if they press B, do this
;
;    JSR EquipShop_GiveItemToChar ; give the item to the character
;    BCS @TroubleExit             ; carry was set because you have too many of the old item!
;
;    PLA
;    PLA
;    JMP FinishPurchase
;
;   @TroubleExit:
;    LDA #$20
;    JSR DrawShopDialogueBox      ; "I'll put it in your bags"
;    JSR MenuWaitForBtn
;
;EquipOnCharacter_Exit:           ; store in inventory
;    RTS
;
;EquipShop_GiveItemToChar:
;    LDA cursor          ; get the char ID
;    ROR A
;    ROR A
;    ROR A
;    AND #$C0            ; shift and mask to get the char index
;    STA char_index
;
;    LDA shop_curitem
;    STA ItemToEquip
;    JSR IsEquipLegal
;    BEQ CannotEquip
;
;    LDA #0
;    LDX ItemToEquip
;    CPX #ARMORSTART
;    BCC @Unequip
;
;    LDA lut_ArmorTypes, X
;
;   @Unequip:
;    CLC
;    ADC #ch_righthand - ch_stats
;    ADC char_index
;    STA char_index
;    TAX
;    LDA ch_stats, X
;    BEQ @NoSwap
;
;    TAX
;    DEX
;    TXA              ; set it to a 0-based item
;    JSR ADD_ITEM     ; put previously equipped item back into inventory
;    BCC @NoSwap
;
;    ;; THIS PART HERE HAPPENS IF YOU CAN'T STOW YOUR EQUIPPED WEAPON BECAUSE YOU HAVE TOO MANY
;    RTS
;
;   @NoSwap:
;    ;JSR UnEquipStats          ; does not use char_index
;    LDX char_index
;    LDA ItemToEquip
;    STA ch_stats, X
;    RTS
;    ;JMP ReEquipStats
;
;CannotEquip:
;    LDA #$1F
;    JSR DrawShopDialogueBox    ; "You can't equip that"
;    JSR MenuWaitForBtn
;    PLA
;    PLA
;    JMP EquipOnCharacter

;ReEquipStats:
;    JSR LongCall
;    .word ReadjustEquipStats
;    .byte BANK_EQUIPSTATS
;    CLC
;    RTS
;
;UnEquipStats:
;    JSR LongCall
;    .word UnadjustEquipStats
;    .byte BANK_EQUIPSTATS
;    RTS



SelectAmount:
    LDA #0
    STA shop_listactive     ; turn off changing the green bar on the inventory list
    LDA #$0D                ; display buying text; "How many?"
    LDX shop_selling        ; BUT if selling...
    BEQ :+
       LDA #$27             ; display selling text ("will get ya" instead of "Will cost ya")

  : JSR DrawShopDialogueBox
    JSR PrintShopAmount     ; fill the spaces in the "how many?" text with numbers

    LDA #$B0
    STA cursor_y
    LDA #$08
    STA cursor_x          ; move cursor position

    JSR @Start_Loop         ; do the whole loop thing to pick how many new items to buy...
    BCC @End                ; if B is pressed,
    PLA
    PLA
    LDA shop_selling
    BEQ :+
    JMP ShopSell
  : JMP ShopBuy             ; return to picking what to buy

   @End:
    RTS

   @Start_Loop:
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
    BEQ @TenMore

   @TenLess:             ; otherwise, it was down
    LDA shop_amount_buy
    CMP #1               ; if its at the minimum, wrap it to the limit
    BEQ @WrapToLimit
    SEC                  ; otherwise, subtract 10...
    SBC #10
    BEQ @WrapToMinimum   ; if that hit 0, wrap to minimum
    BCS @MoveDone        ; if there's any left over, its ok
    BCC @WrapToMinimum   ; if it went minus, wrap to minimum first

   @TenMore:
    LDX shop_amount_max
    DEX
    LDA shop_amount_buy
    CPX shop_amount_buy  ; if its at max, wrap to minimum
    BEQ @WrapToMinimum
    CMP #1               ; if you start with 1, switch to 10
    BNE :+               ; this is weird, but it bugs me going from 1 to 11...
      LDA #0
  : CLC
    ADC #10
    CMP shop_amount_max
    BCC @MoveDone
    BCS @WrapToLimit

   @Less:
    DEC shop_amount_buy
    LDA shop_amount_buy
    BNE @MoveDone        ; if it hits 0, wrap to limit, otherwise its fine

   @WrapToLimit:
    LDA shop_amount_max  ; otherwise (below 1), wrap to our item limit
    SEC
    SBC #$01             ; minus one
    JMP @MoveDone        ; desired cursor is in A, jump ahead to @MoveDone to write it back

   @More:
    INC shop_amount_buy
    LDA shop_amount_buy  ; if Up or Right pressed, increase amount

   @CompareToMax:
    CMP shop_amount_max  ; check to see if we've gone over the amount we can buy
    BCC @MoveDone        ; if not, jump ahead to @MoveDone

  @WrapToMinimum:
    LDA #1               ; if yes, wrap limit to 1

  @MoveDone:             ; code reaches here when A is to be the new amount to buy
    STA shop_amount_buy  ;
    JSR PrintShopAmount  ; prints all the numbers
    JMP @Loop            ; and continue loop

  @B_Pressed:            ; if B pressed....
    SEC                  ; SEC to indicate player pressed B
                         ;  and proceed to @ButtonDone

  @ButtonDone:           ; reached when the player has pressed B or A (exit this shop loop)
    JMP ClearButtons

  @A_Pressed:            ; if A pressed...
    CLC                  ; CLC to indicate player pressed A
    BCC @ButtonDone      ; and jump to @ButtonDone (always branches)



PrintShopAmount:
    LDA shop_amount_buy
    STA tmp
    JSR PrintNumber_2Digit
    LDA format_buf-2          ; copy the printed 2 digit number from the format buffer
    STA str_buf+$B0
    LDA format_buf-1
    STA str_buf+$B1
    LDA #0
    STA str_buf+$B2
    STA str_buf+$BF

    LDA #22
    STA dest_y
    LDA #03
    STA dest_x

    LDA #<(str_buf+$B0)        ; set our text pointer to point to the generated string
    STA text_ptr
    LDA #>(str_buf+$B0)
    STA text_ptr+1
    JSR DrawComplexString

ShopLoadPrice_Complex_Print:
    JSR ShopLoadPrice_Complex

    ;; then print

    JSR PrintNumber_6Digit

    LDA format_buf-6
    STA str_buf+$B9
    LDA format_buf-5
    STA str_buf+$BA
    LDA format_buf-4
    STA str_buf+$BB
    LDA format_buf-3
    STA str_buf+$BC
    LDA format_buf-2
    STA str_buf+$BD
    LDA format_buf-1
    STA str_buf+$BE

    LDA #24
    STA dest_y
    LDA #06
    STA dest_x

    LDA #<(str_buf+$B9)        ; set our text pointer to point to the generated string
    STA text_ptr
    LDA #>(str_buf+$B9)
    STA text_ptr+1
    JMP DrawComplexString

ShopLoadPrice_Complex:
    LDA shop_curitem
    JSR LoadPrice          ; gets the base price of the item you're trying to buy

    LDA shop_selling
    BEQ :+

    LSR tmp+2              ; if selling, divide the base price by 2
    ROR tmp+1
    ROR tmp

  : CLC
    LDA shop_amount_buy    ; quantity
    LDX tmp                ; low byte of price
    JSR MultiplyXA_Safe
    STA tmp
    STA shop_curprice
    STX shop_x_price

    LDA shop_amount_buy
    LDX tmp+1              ; middle byte of price
    JSR MultiplyXA_Safe
    ADC shop_x_price
    STA tmp+1
    STA shop_curprice+1
    STX shop_x_price

    LDA shop_amount_buy
    LDX tmp+2              ; high byte of price
    JSR MultiplyXA_Safe
    ADC shop_x_price
    STA tmp+2
    STA shop_curprice+2
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
    LDX lead_index
    LDA ch_attackperks, X ; check if party leader is naughty
    AND #STEALTHY
    BEQ @PayUp            ; if not, pay up

   @ShopSteal:
    LDA shop_amount_buy ; how many items are being bought?
    CMP #03             ; only two hands so...
    BCS @PayUp          ; not getting away with it

    TXA
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


ShopEarnGold:
    LDA gold
    CLC
    ADC shop_curprice
    STA gold

    LDA gold+1
    ADC shop_curprice+1       ; mid byte
    STA gold+1

    LDA gold+2
    ADC shop_curprice+2
    STA gold+2
    JMP DrawShopGoldBox



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

Shop_CanShopkeepAfford:
    LDA gold        ; Add the 3 bytes of GP to the
    CLC             ;  party's gold total
    ADC shop_curprice
    STA tmp
    LDA gold+1
    ADC shop_curprice+1
    STA tmp+1
    LDA gold+2
    ADC shop_curprice+2

    CMP #^1000000   ; see if high byte is over maximum
    BCC @Exit       ; if gold_high < max_high, exit with carry clear
    BEQ @CheckMid   ; high bytes are equal -- need to compare middle bytes
    BCS @Exit       ; gold_high > max_high, we're over the max, with carry set

  @CheckMid:
    LDA tmp+1
    CMP #>1000000   ; check middle bytes
    BCC @Exit       ; if gold < max, exit with carry clear
    BEQ @CheckLow   ; if gold = max, check low bytes
    BCS @Exit       ; if gold > max, over maximum, exit with carry set

  @CheckLow:
    LDA tmp
    CMP #<1000000   ; check low bytes

  @Exit:            ; carry set; can't sell
    RTS             ; carry clear, sell is go


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Enter Shop Inn  [$A508 :: 0x3A518]
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

EnterInn:
    LDA #$21
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

    JSR MenuFillPartyHP         ; refill the party's HP
    JSR MenuRecoverPartyMP      ;  and MP

    JSR ClearButtons

    LDA #$22
    JSR DrawShopDialogueBox     ; "Remember to save" dialogue

    LDA #SHOPBOX_COMMAND
    JSR EraseMainItemBox        ; erase shop box 3 (command box)

    JSR ShopFrameNoCursor
    JSR BackUpPalettes
    LDA #8
    STA PaletteCounter          ; vanilla FF1 value more or less - 8 frames per palette change
    JSR FadeOutSprites          ; and fade the party out
    JSR MenuWaitForBtn_SFX

    JSR SaveGame                ; JIGS - now save... and!
    LDA #0
    STA $2001                   ; turn off PPU
    JSR LoadShopCHRPal          ;
    JSR ClearSpritePalette      ; dim the palettes to black so we can fade back in again; save screen reset it
    JSR DrawShop                ; re-draw the shop!

  @LoopOne:
    JSR ShopFrameNoCursor       ; do a shop frame (with no visible cursor)
    JSR FadeInSprites           ; then fade the party back in

  @Exit_HealthRestored:
    LDA #$23
    JSR DrawShopDialogueBox     ; "HP/MP restored" dialogue
    JMP Clinic_Inn_Exit

  @Exit:
    LDA #SHOPBOX_COMMAND
    JSR EraseMainItemBox        ; erase shop box 3 (command box)

    LDA #$22
    JSR DrawShopDialogueBox     ; "Don't forget to save" dialogue

Clinic_Inn_Exit:
    JSR ClearButtons

   @Loop:
    JSR ShopFrameNoCursor       ; do a frame
    LDA music_track             ; check to see if the music has silenced (will happen
    CMP #$81                    ;  after the save jingle ends)
    BNE :+
      LDA #$51 ; 4F             ; restart track $4F (shop music) ;; JIGS - menu music now!
      STA music_track
  : LDA joy_a                   ; check to see if A or B have been pressed
    ORA joy_b
    BEQ @Loop                   ; and keep looping until one of them has

Clinic_Inn_QuickExit:
    JMP ReturnToMap             ; then exit


EnterClinic:
    JSR ClearButtons

    JSR ClinicBuildNameString  ; build the name string (also tells us if anyone is dead)
    BCC @NobodysDead           ; if nobody is dead... skip ahead

    LDA #$25
    JSR DrawShopDialogueBox    ; "Who needs to come back to life" dialogue

    JSR Clinic_SelectTarget    ; Get a user selection
    LDA cursor                 ; grab their selection
    STA shop_curitem           ; and put it in cur_item to hold it for later
    BCS Clinic_Inn_QuickExit   ; If they pressed B, exit.

    JSR DrawInnClinicConfirm   ; Draw the cost confirmation dialogue
    JSR ShopLoop_YesNo         ; give them the yes/no option
    BCS EnterClinic            ; If they pressed B, restart loop
    LDA cursor
    BNE EnterClinic            ; if they selected "No", restart loop

    JSR InnClinic_CanAfford    ; otherwise, they selected "Yes".  Make sure they can afford the charge

  ;  LDA shop_curitem           ; code only reaches here if they can afford it.
  ;  CLC
  ;  ADC shop_curitem           ; add their original selection to itself twice (ie:  *3)
  ;  ADC shop_curitem
  ;  TAX                        ; cursor*3 in X
  ;  LDA str_buf+$10, X         ; use that to get the char ID from the previously compiled string
  ;                             ;  (see ClinicBuildNameString for how this string is built and why this works)
  ;
  ;  ROR A                      ; A is currently $10-$13
  ;  ROR A                      ; convert this number into a usable char index ($00,$40,$80, or $C0)
  ;  ROR A                      ;   by shifting it
  ;  AND #$C0                   ; and masking out desired bits
  ;  TAX                        ; put the char index in X.  This is the car we are to revive.

    LDX shop_curitem           ;; JIGS ^ the new price stuff did all this work
    JSR ClearButtons
    STA ch_ailments, X         ; erase this character's ailments (curing his "death" ailment)

    LDA #$01
    STA ch_curhp, X            ; and give him 1 HP

    LDA #$26
    JSR DrawShopDialogueBox    ; "Warrior!  Return to life!"  dialogue

    LDA #SHOPBOX_COMMAND
    JSR EraseMainItemBox       ; erase shop box 3 (command box)

  @ReviveLoop:
    JSR ShopFrameNoCursor      ; do a frame
    LDA joy_a
    ORA joy_b
    BEQ @ReviveLoop            ; and loop (keep doing frames) until A or B pressed
    JMP EnterClinic            ; then restart the clinic loop

  @NobodysDead:
    LDA #$24
    JSR DrawShopDialogueBox    ; if nobody is dead... "You don't need my help" dialogue
    JMP Clinic_Inn_Exit




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
    LDA #$14
    JSR DrawShopDialogueBox    ; draw "you can't afford it" dialogue

    JSR ClearButtons
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
    LDA #SHOPBOX_COMMAND
    JSR DrawMainItemBox            ; draw shop box #3 (command box)

    LDA #<(str_buf+$10)        ; set our text pointer to point to the generated string
    STA text_ptr
    LDA #>(str_buf+$10)
    STA text_ptr+1
    JSR DrawShopComplexString  ; and draw it

    LDA #0
    STA cursor
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









Shop_CharacterStopDancing:
    LDA #0
    STA shop_drawmarks
   @StopPose_Loop:
    STA char_index
    TAX
    LDA ch_ailments, X
    AND #$7F                  ; remove the pose "ailment"
    STA ch_ailments, X
    TXA
    CLC
    ADC #$40
    BNE @StopPose_Loop
    RTS


Shop_CharacterCanEquip:
    LDA cursor
    CLC
    ADC item_box_offset
    TAX
    LDA item_box, X
    STA tmp+8                 ; ID of the item to check

    JSR Shop_CharacterStopDancing

    ;; now do the main loop

   @CharLoop:
    STA char_index
    TAX

    LDA shop_type
    CMP #SHOP_WHITEMAGIC
    BCC @EquipmentShop

    LDY #24
   @MagicLoop:                ; loop through all the character's known spells
    LDA ch_spells, X
    CMP tmp+8
    BEQ @SetMark              ; if the spell is found, mark them as knowing it
    INX
    DEY
    BPL @MagicLoop
    JMP @CanEquip             ; otherwise, they don't know it; see if they can learn it

   @EquipmentShop:
    LDY #8
   @EquipLoop:
    LDA ch_righthand, X
    CMP tmp+8
    BEQ @SetMark
    INX
    DEY
    BPL @EquipLoop
    BMI @CanEquip

   @SetMark:
    LDA char_index
    ASL A                  ;  convert it from $40 base to $1 base (ie:  $03 is character 3 instead of $C0)
    ROL A
    ROL A
    TAX
    LDA lut_BIT, X
    ORA shop_drawmarks
    STA shop_drawmarks
    BNE @EquipPossible     ; they have it equipped; therefore, it must be possible to equip it!

   @CanEquip:
    LDA tmp+8
    JSR IsEquipLegal
    BEQ @NextCharacter     ; they can't equip, so do nothing

   @EquipPossible:
    LDX char_index         ; this sets the high bit, which tells the sprite drawing routine to do the "Cheer" pose
    LDA ch_ailments, X
    ORA #$80
    STA ch_ailments, X

   @NextCharacter:
    LDA char_index
    CLC
    ADC #$40
    BNE @CharLoop

    ;; this takes too long after updating sprites and attributes
    ;; so play music for the frame...

    LDA #BANK_THIS
    STA cur_bank
    JSR CallMusicPlay
    JSR WaitForVBlank_L

    ;; and flow into drawing the marks on screen!

DrawEquipMarks:
    LDY #3
  @RemoveLoop:
    JSR @RemoveMark
    DEY
    BPL @RemoveLoop

    LDY #0
    LDA shop_drawmarks   ; each bit set = draw the ! for that character
    ASL A
    BCC :+
     JSR @DrawMark
  : INY
    ASL A
    BCC :+
     JSR @DrawMark
  : INY
    ASL A
    BCC :+
     JSR @DrawMark
  : INY
    ASL A
    BCC @Exit

   @DrawMark:
    PHA
    LDA #$7F                  ; ! tile
    BNE @DoMark

   @RemoveMark:
    PHA
    LDA #$70                  ; blank tile

   @DoMark:
    PHA                       ; backup the tile to draw
    LDA @Equipped_LUT_High, Y ; use Y to get the tile position
    TAX
    LDA @Equipped_LUT_Low, Y
    JSR SetPPUAddr_XA
    PLA                       ; pull the tile to draw
    STA $2007
    PLA                       ; pull shop_drawmarks, shifted
   @Exit:
    RTS

   @Equipped_LUT_High:
    .byte $20
    .byte $21
    .byte $21
    .byte $21

   @Equipped_LUT_Low:
    .byte $D2
    .byte $32
    .byte $92
    .byte $F2


ChangeInventoryList_Color:
    JSR ResetShopListAttributes
    JSR ShopListActiveBar
    BNE ResetScroll

ResetShopList_Extras:             ; turns off the shop_listactive variable
    JSR WaitForVBlank_L
    JSR ResetShopListAttributes   ; clear active bar

ResetShop_Marks:
    LDA #0
    STA shop_listactive
    JSR Shop_CharacterStopDancing ; turns off posing
    JSR DrawEquipMarks            ; turns off ! marks

ResetScroll:
    LDA soft2000                  ; reset scroll and PPU data
    STA $2000
    LDA #0
    STA $2005
    STA $2005
    RTS

ResetShopListAttributes:          ; clears the highlighted colour
    LDY #4
   @Loop:
    JSR SetAttributeBarLocation
    LDA #$FF
    JSR DrawAttributeBar
    DEY
    BPL @Loop
    RTS

ShopListActiveBar:                ; set the highlighted colour
    LDY cursor
    JSR SetAttributeBarLocation
    LDA #$FA

DrawAttributeBar:                 ; draw all 3 attribute bytes
    STA $2007
    STA $2007
    STA $2007
    RTS

SetAttributeBarLocation:          ; gets the location to draw attribyte bytes
    LDA @ShopListAttribute_LUT, Y
    LDX #$23
    STX $2006
    STA $2006
    RTS

   @ShopListAttribute_LUT:
    .byte $CD
    .byte $D5
    .byte $DD
    .byte $E5
    .byte $ED




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
    JSR DrawShopPartySprites   ; draw the party sprites
    JSR DrawShopCursor         ; and the cursor
    JMP _ShopFrame_WaitForVBlank

ShopFrameNoCursor:
    JSR ClearOAM               ; do all the same things as above, in the same order
    JSR DrawShopPartySprites   ;  only do not draw the cursor -- used by inn and clinic only

_ShopFrame_WaitForVBlank:
    JSR WaitForVBlank_L
    LDA #>oam
    STA $4014

    LDA shop_listactive        ; is the inventory list the box the cursor is on?
    BEQ :+

    LDA shop_cursorchange      ; did the cursor change since the last frame?
    BEQ :+
        JSR ChangeInventoryList_Color ; change the position of the green highlight
        DEC shop_cursorchange

    LDA inv_canequipinshop     ; then do the thing to update character poses and ! equipped things
    BEQ :+
        JSR Shop_CharacterCanEquip ; JIGS - if its weapon or armor shops, check the cursor for the highlighted item
        ; then apply a high bit to ailments that tells the sprite-drawing routine to do them in cheer pose!
        JSR ResetScroll

  : LDA #BANK_THIS
    STA cur_bank
    JSR CallMusicPlay          ; after we call MusicPlay, proceed to check the buttons

_ShopFrame_CheckBtns:
    LDA joy                    ; get old joypad data for last frame
    AND #$0F                   ; isolate the directional buttons
    STA tmp+7                  ; and store it as our prev joy data

    JSR UpdateJoy              ; update joypad data
    LDA joy_a                  ; see if either A or B pressed
    ORA joy_b
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
    JMP ClearButtons



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

ShopAttributes:
.byte $D3,$CB,$DB ; attribute position
.byte $00,$0F,$00 ; attribute value

DrawShop:
    JSR ClearNT                ; clear the nametable
    LDA $2002                  ; reset the PPU toggle

    LDX #$02
    LDY #$23
   @Loop:
    STY $2006
    LDA ShopAttributes, X
    STA $2006
    LDA ShopAttributes+3, X
    STA $2007
    DEX
    BPL @Loop

    ; last byte of that little loop is $00, so that's still in A...
    STA menustall                ; disable menu stalling (PPU is off)
    STA tmp+2                    ; no additive for the DrawImageRect routine

    ; Draw the shopkeeper
    ;LDX shop_type                ; get the shop type in X
    ;LDA lut_ShopkeepAdditive, X  ; use it to fetch the image additive from our LUT
    ;STA tmp+2                    ; tmp+2 is the image additive (see DrawImageRect)

    LDA #7
    STA dest_y
    LDA #12
    STA dest_x
    LDA #9
    STA dest_ht
    LDA #4
    STA dest_wd

    LDA #<lut_ShopkeepImage      ; get the pointer to the shopkeeper image
    STA image_ptr
    LDA #>lut_ShopkeepImage
    STA image_ptr+1

    JSR DrawImageRect            ; draw the image rect

    LDA #SHOPBOX_TITLE
    JSR DrawMainItemBox          ; draw shop box ID=1  (the title box)

    LDA shop_type                ; get the shop type
    CMP #SHOP_CARAVAN
    BNE :+
        LDA #SHOP_CARAVAN_ID     ; -$30 so it becomes $7F, the last item shop
        STA shop_id
        LDA #SHOP_ITEM
        STA shop_type

  : DEC dest_y ; JIGS
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
    LDA #0
    LDY #5
  : STA item_box, Y      ; clear item box and add null terminator
    DEY
    BPL :-
    STA item_box_offset  ; clear this so the list isn't scrolled

    LDA shop_id          ; get the shop ID
    ASL A                ; double it
    TAX                  ; put it in X for indexing

    LDA lut_ShopData, X  ; load up the pointer to shop's inventory
    STA tmp
    LDA lut_ShopData+1, X
    STA tmp+1

    LDY #0               ; copy 5 items from the inventory (max for a shop)
  @Loop:
     LDA (tmp), Y        ; get the item from the shop LUTs
     BEQ @NothingLeft    ; end early if the terminator is found
     STA item_box, Y     ; put it in the item box
     INY
     CPY #5
     BNE @Loop           ; and loop until max amount is loaded

   @NothingLeft:
    ;; check if this is an item shop
    ;; check to see if anything in the box is a key item
    ;; check if the player has it
    ;; if they do, remove it

    LDA shop_type
    CMP #SHOP_ITEM
    BCC @End

    JSR Set_Inv_KeyItem

 ;  @KeyItemCheck:
 ;   LDA item_box, Y
 ;   CMP #ITEM_KEYITEMSTART
 ;   BCC @NextKeyItem
 ;
 ;   TAX
 ;   TYA
 ;   PHA
 ;   TXA
 ;   JSR DOES_ITEM_EXIST_1BIT
 ;   BEQ @DoesNotExist
 ;
 ;   ;; the player has the item...
 ;   PLA
 ;   TAY
 ;   LDA #0
 ;   STA item_box, Y
 ;   BEQ @End          ;; must assume that the shop only has one key item
 ;   ;; because if clear it means this is the end of the shop's inventory, and things will get breaky
 ;
 ;  @DoesNotExist:
 ;   PLA
 ;   TAY
 ;
 ;  @NextKeyItem:
 ;   DEY
 ;   BPL @KeyItemCheck

    ;; JIGS - for a shop that sells one key item at a time, the above code will be fine
    ;; for my Caravan, I have a surprise new item show up... so using thise code for now:

    LDA #BOTTLE
    JSR DOES_ITEM_EXIST_1BIT
    BEQ @End             ; if not, exit

    LDA item_box+4       ; if yes, see if this shop's last item is the Bottle
    CMP #BOTTLE
    BNE @End             ; if not, exit

    LDA #LEWDS           ; change the item the caravan is selling
    STA item_box+4

    LDA #LEWDS           ; does the player have the new item?
    JSR DOES_ITEM_EXIST_1BIT
    BEQ @End             ; if not, exit

    LDA #0               ; if yes, set the caravan's last item to nothing
    STA item_box+4

   @End:
    RTS                  ; and exit


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Draw Shop Gold Box   [$A7EF :: 0x3A7FF]
;;
;;     Draws the box containing remaining GP in the shops and all of its contents
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

DrawShopGoldBox:
    LDA #SHOPBOX_GOLD
    JSR DrawMainItemBox            ; Draw shop box #4  (the gold box)
    JSR PrintGold              ; print current gold to format buffer
    DEC dest_y                 ; JIGS - I think this makes it look nicer
    JSR DrawShopComplexString  ; draw formatted string

    LDA dest_x                 ; add 6 to the X coord
    CLC
    ADC #$06
    STA dest_x

    LDA #$0B                   ; draw shop string ID=$08 (" G")
    JMP DrawShopString         ; then exit





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



Fillblank_item:
    LDX #9
    LDA cursor_max      ; if cursor_max didn't increase yet, this is the first item...
    BNE :+              ; if this is the first item, there are no items!
       LDA item_box_offset
       SEC
       SBC #5
       STA item_box_offset ; subtract 5 from this, and re-do from scratch
       JMP ShopSelectItem

  : LDA ShopListBlankItemCodes_LUT-1, X
    STA str_buf+$40, Y
    INY
    DEX
    BNE :-

    INC blank_item

    INC cursor_max       ; increment cursor_max, our item counter
    LDA cursor_max
    CMP #5               ; ensure we don't exceed 5 items (max the shop space will allow)
    BNE Fillblank_item   ; if we haven't reached 5 items yet, keep looping
    JMP UpdateShopList_Done

ItemTypeLUT:
.byte $07,$07,$06,$06,$06,$06,$02,$02
; ComplexString control codes for equipment, magic, and items, based on shop type

ShopListBlankItemCodes_LUT:
;      9   8   7   6   5  4   3   2   1
.byte $01,$08,$09,$05,$08,$09,$05,$08,$09

ShopListItemCodes_LUT:
;      C   B   A   9   8   7   6   5   4   3   2   1
.byte $01,$44,$03,$FF,$FF,$FF,$05,$FF,$FF,$F1,$05,$44


UpdateShopList:
    LDY #0            ; zero Y... this will be our string building index
    STY cursor_max    ; up counter
    STY blank_item
    INY

UpdateShopList_Loop:
    LDA item_box_offset ; 0 always, except when selling items, then it moves to scroll the list!
    CLC
    ADC cursor_max
    TAX

    LDA item_box, X      ; use it to get the next shop item
    BNE @ItemExists
    BEQ Fillblank_item

   @ItemExists:
    STA shop_curitem     ; save item ID

    LDX shop_type
    LDA ItemTypeLUT, X
    STA str_buf+$40, Y   ; Item Name control code
    INY

    LDX #$0C
   @WriteLoop:
    LDA ShopListItemCodes_LUT-1, X
    CMP #$44             ; convert $44 to item ID
    BNE :+
        LDA shop_curitem
  : STA str_buf+$40, Y
    INY
    DEX
    BNE @WriteLoop

;;  The item string should now look like this:    (05 is single line break)
;;  Name Code, Item ID, 05, x , Inventory QTY, 05 | FF, FF          | FF, 03, Item ID, 01
;;  01         02       03, 04, 05-06        , 07 | 08, 09          | 0A, 0B, 0C     , 0D
;;                                      if magic: | L , Spell Level |

    LDA shop_type
    CMP #SHOP_WHITEMAGIC
    BCC @EquipmentQTY
    CMP #SHOP_ITEM
    BCC @MagicQTY

   @ItemQTY:
    LDX shop_curitem     ; get item ID
    LDA items, X
    JMP @PrintQuantity

   @EquipmentQTY:
    TYA
    PHA
    JSR CheckEquipmentInventory ; like CheckMagicInventory
    PLA
    TAY
    JMP :+

   @MagicQTY:
    TYA
    PHA
    JSR CheckMagicInventory ; does everything to check how many of each spell there is, known and in inventory
    PLA                     ; this also puts spell level in str_buf+$49, Y!
    TAY                     ; it does this before Y is re-used for another loop and restored here
    LDA #$95                ; L
    STA str_buf+$3A, Y      ; overwrite the #$FF in this slot
  : LDA #1
    STA inv_canequipinshop  ; turn on the switch for characters posing
    LDA shop_amount

   @PrintQuantity:
    STA tmp
    JSR PrintNumber_2Digit ; print quantity
    LDA format_buf-1       ; tens
    STA str_buf+$38, Y
    LDA format_buf-2       ; ones
    CMP #$FF
    BNE @TwoDigit

   @Singledigit:
    STA str_buf+$38, Y
    LDA format_buf-1

   @TwoDigit:
    STA str_buf+$37, Y

;;  The item string should now look like this:
;;  02/07 Item ID 05 x  Inventory QTY 05 | _  _           | _  03 Item ID 01
;;  41    42      43 44 45-46         47 | 48 49          | 4A 4B 4C      4D
;;                             if magic: | L  Spell Level |

    INC cursor_max           ; increment cursor_max, our item counter
    LDA cursor_max
    CMP #5                   ; ensure we don't exceed 5 items (max the shop space will allow)
    BNE UpdateShopList_Loop
    ;BEQ UpdateShopList_Done  ; if we haven't reached 5 items yet, keep looping
    ;JMP UpdateShopList_Loop

UpdateShopList_Done:
    SEC
    SBC blank_item
    STA cursor_max

    DEY
    LDA #0
    STA str_buf+$40, Y     ; slap a null terminator at the end of our string
    STA str_buf+$40        ; slap a null terminator at the end of equipment list ???

    LDA #22
    STA dest_x
    LDA #4
    STA dest_y

    LDA #<(str_buf+$41)    ; load up the pointer to our string
    STA text_ptr
    LDA #>(str_buf+$41)
    STA text_ptr+1
    JMP DrawShopComplexString  ; and draw it


ConvertInventoryToItemBox:
    LDA #0
    STA cursor_max
    TAX

    LDY #64
   @ClearBox:
    STA item_box-1, Y
    DEY
    BNE @ClearBox

    LDA shop_type
    BEQ @Weapons
    CMP #SHOP_WHITEMAGIC
    BCC @Armor
    CMP #SHOP_ITEM
    BCC @Magic

    INY                   ; skip the first item that isn't an item
   @Items:
    LDA items, Y          ; get item from inventory
    BEQ @NextItem         ; if no items, skip it
    TYA                   ; otherwise, turn Y into item ID
    STA item_box, X       ; save it in the item box
    INX                   ; increase X to next item box slot
   @NextItem:
    INY                   ; increase item ID/loop counter
    CPY #item_qty_stop - items
    BNE @Items            ; if it matches the end of items, finish
    BEQ @BuildSellString

   @Magic:
    JSR Set_Inv_Magic
    LDX #0
    LDY #128
    BNE @DecompressInventory

   @Weapons:
    JSR Set_Inv_Weapon
    LDX #0
    LDY #64
    BNE @DecompressInventory

   @Armor:
    JSR Set_Inv_Weapon
    LDX #ARMORSTART            ; X and Y basically act as start and stop locations
    LDY #64+ARMORSTART         ; so for armor, its start at 64, end at 128

   @DecompressInventory:
    STY tmp+4                  ; max item amount
    LDA #0
    STA tmp+3                  ; counter for item box

    ; X = offset for where to begin counting items from (+$40 for armor)

   @Loop:
    TXA
    PHA                        ; backup item ID
    JSR DOES_ITEM_EXIST        ; A = item ID going in, output is A = amount, Carry set on no item
    PLA
    TAX                        ; restore item ID and put in X
    INX                        ; convert item to 1-based / check next item
    BCS @Next

   @Exists:
    TXA
    LDY tmp+3                  ; load item box counter (position) into Y
    STA item_box, Y            ; put the item ID in the item box
    INC tmp+3                  ; and increment the counter

   @Next:
    CPX tmp+4                  ; compare to max amount to check for
    BNE @Loop

   @BuildSellString:
    LDA item_box
    RTS



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  ShopLoop_YesNo [$A8C2 :: 0x3A8D2]
;;
;;    Exactly the same as ShopLoop_BuyExit, only it gives
;;  options "Yes" and "No".
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

ShopLoop_YesNo:
    LDA #SHOPBOX_COMMAND
    JSR DrawMainItemBox      ; draw shop box ID=3 (the command box)
    LDA #$10
    JSR DrawShopString       ; draw shop string ID=$0F ("Yes"/"No")

    LDA #2
    STA cursor_max           ; 2 cursor options
    LDA #0
    STA cursor

    JMP CommonShopLoop_Cmd   ; do command shop loop and exit


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
    LDA #SHOPBOX_COMMAND
    JSR DrawMainItemBox            ; draw shop box 3 (command box)

    LDA #$11
    JSR DrawShopString

    LDA #4
    STA cursor_max             ; give the user 4 options
    LDA #0
    STA cursor

    ;JMP CommonShopLoop_Cmd     ; then run the common loop

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


HideShopCursor:
    LDA #$F0
    STA cursor_x
    STA cursor_y
    JMP ShopFrame              ; update cursor position before drawing things

CommonShopLoop_Cmd:
    LDA #<lut_ShopCurs_Cmd     ; get the pointer to the desired cursor position LUT
    STA shop_cursor_ptr        ;
    LDA #>lut_ShopCurs_Cmd     ;
    STA shop_cursor_ptr+1
    JMP _CommonShopLoop_Main   ; then jump ahead to the main entry for these routines

ShopSelectItem:
    JSR UpdateShopList         ; draw the inventory list
    LDA #1
    STA shop_listactive        ; turn the list on
    STA shop_cursorchange      ; and mark the attributes to update

;ShopType_SellLUT:
;    .byte $0, $01, $02, $07

CommonShopLoop_List:
    LDA #$A0                   ; update cursor to point to top of the list
    STA cursor_x
    LDA #$20
    STA cursor_y
    JSR ShopFrame              ; show cursor and update attributes

    LDA #<lut_ShopCurs_List    ; exactly the same as _Cmd version of the routine
    STA shop_cursor_ptr        ; only have (shop_cursor_ptr) point to a different LUT
    LDA #>lut_ShopCurs_List
    STA shop_cursor_ptr+1
    JMP DisplayDescription    ; display the first item's description

      ; both flavors of this routine meet up here, after filling (shop_cursor_ptr)
      ;   with a pointer to a LUT containing the cursor positions.

  ;; JIGS - the @ local labels in this are packed in tight! Be careful of changes with BNE/BEQ/BPL/BMI

 _CommonShopLoop_Main:
    LDA joy              ; get the joy data
    AND #$0C ; 0F        ; isolate up/down bits (JIGS - use 0F for left/right)
    STA joy_prevdir      ; and store in prev_dir and begin loop

  @Loop:
    LDA cursor           ; get the cursor
    ASL A                ; multiply by 2 (2 bytes per position)
    TAY                  ; put in Y for indexing

    LDA (shop_cursor_ptr), Y    ; fetch the cursor X coord from out LUT
    STA cursor_x       ; and record it
    INY                  ; inc Y to get Y coord
    LDA (shop_cursor_ptr), Y    ; read it
    STA cursor_y       ; and record it

    JSR ShopFrame        ; now that cursor position has been recorded... do a frame

    LDA joy_b
    BNE @B_Pressed       ; check to see if A or B have been pressed
    LDA joy_a
    BNE @A_Pressed
  ;  LDA joy_start        ; or if start/select have been pressed
  ;  ORA joy_select
  ;  BNE @Start_Pressed

    LDA joy              ; if neither pressed.. see if the cursor has been moved
    AND #$0C ; F         ; F to isolate up/down/left/right buttons, C for up/down only
    CMP joy_prevdir      ; compare to previous buttons to see if button state has changed
    BEQ @Loop            ; if no change.. do nothing, and continue loop

    STA joy_prevdir      ; otherwise, record changes

    CMP #0               ; then check to see if buttons have been pressed or not
    BEQ @Loop            ; if not.. do thing, and continue loop

   ; CMP #$01             ; if right was pressed
   ; BEQ @Right
   ;
   ; CMP #$02             ; if left was pressed
   ; BEQ @Left

    INC shop_cursorchange
    CMP #$08             ; see if the button pressed was up or down
    BNE @Down

  @Up:
    DEC cursor           ; if up pressed, decrement the cursor by 1
    BPL DisplayDescription ;@Loop            ; if it hasn't gone below zero, that's all -- continue loop

    LDA shop_selling
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

    LDA shop_selling
    BNE @ScrollListDown

   @DownReturn:
    LDA #0               ; if yes, wrap cursor to zero

  @MoveDone:             ; code reaches here when A is to be the new cursor position
    STA cursor           ; just write it back to the cursor
    JMP DisplayDescription ; @Loop            ; and continue loop

  @B_Pressed:            ; if B pressed....
    SEC                  ; SEC to indicate player pressed B

  @ButtonDone:           ; reached when the player has pressed B or A (exit this shop loop)
    JSR ClearButtons
    STA shop_descriptionset
    RTS

  @A_Pressed:            ; if A pressed...
    CLC                  ; CLC to indicate player pressed A
    BCC @ButtonDone      ;  and jump to @ButtonDone (always branches)

;; JIGS - this wasn't working, requires too much extra work

;  @Left:
;    LDA shop_selling
;    BNE :+
;      BEQ @Loop
;
;  : DEC shop_type
;    JMP @ChangeSellType
;
;    ;; left / right swaps shop_type between 0-7 so you can sell different inventories
;
;  @Right:
;    LDA shop_selling
;    BNE :+
;      BEQ @Loop
;
;  : INC shop_type
;
;  @ChangeSellType:
;    LDA shop_type
;    AND #$03
;    TAX
;    LDA ShopType_SellLUT, X
;    STA shop_type
;    JMP ShopSell

@ScrollListDown:
    LDX item_box_offset
    CPX #$3C            ; if item box scrolls beyond this point, no more scrolling
    ;BCC :+
    BCS @DownReturn

    LDY #0
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
    LDA #0
    STA cursor
    JMP ShopSelectItem

@ScrollListUp:
    LDA item_box_offset
    BNE :+
    JMP @UpReturn
  : SEC
    SBC #05
    STA item_box_offset
    LDA #4
    STA cursor
    JMP ShopSelectItem

DisplayDescription:
    LDA shop_listactive
    BEQ @Exit

    LDA cursor
    CLC
    ADC item_box_offset
    TAX
    LDA item_box, X
    STA shop_curitem

    LDA #20
    STA dest_y
    LDA #2
    STA dest_x

    LDA shop_type
    CMP #SHOP_WHITEMAGIC
    BCS @NotEquipment

    LDA shop_descriptionset
    BNE @OnlyUpdateStats

   @Armor:
    LDA #$1B

    LDX shop_type
    BNE:+

   @Weapon:
    LDA #$1C
  : JSR DrawShopString
    LDA #1
    STA shop_descriptionset

   @OnlyUpdateStats:
    JSR LongCall
    .word WeaponArmorShopStats
    .byte BANK_EQUIPSTATS

    LDY #0
   @Loop:
    LDA bigstr_buf+12, Y ; second loop grabs bigstr_buf+16, as Y will = 4 by then--then 3rd loop gets +20
    STA tmp
    LDA #0
    STA tmp+1
    JSR PrintNumber_3Digit
    LDA format_buf-3
    STA bigstr_buf, Y
    INY
    LDA format_buf-2
    STA bigstr_buf, Y
    INY
    LDA format_buf-1
    STA bigstr_buf, Y
    INY                    ; skip over the line breaks
    INY
    CPY #4
    BEQ @Loop
    CPY #8
    BEQ @Loop

 ; bigstr_buf now looks like:
 ; Stat1Digit1, Stat1Digit2, Stat1Digit3, #01
 ; Stat2Digit1, Stat2Digit2, Stat2Digit3, #01
 ; Stat3Digit1, Stat3Digit2, Stat3Digit3, #00

    LDA shop_type
    BEQ :+

    ;; if in armor shop... replace the space before the evade penalty with a minus sign

    LDX #5
   @MiniMinusLoop:
    LDA bigstr_buf, X
    CMP #$FF
    BEQ @MinusSign
    DEX
    CPX #3
    BNE @MiniMinusLoop
    BEQ :+

   @MinusSign:
    LDA #$C2
    STA bigstr_buf, X

  : LDA #<bigstr_buf
    STA text_ptr
    LDA #>bigstr_buf
    STA text_ptr+1

    JSR DrawComplexString
   @Exit:
    JMP _CommonShopLoop_Main

   @NotEquipment:
    LDX shop_curitem
    DEX
    TXA
    LDX shop_type
    CPX #SHOP_ITEM
    BCC @Magic

   @Items:
    CMP #BOTTLE       ; if its bottle, set to $0E
    BNE :+
     LDA #SHOP_BOTTLE
     BNE @DoItems
  : CMP #LEWDS        ; if its lewds, set to $0F
    BNE @DoItems
     LDA #SHOP_LEWDS
     BNE @DoItems

   @Magic:
    ADC #15           ; #14 normal items, then description strings start doing magic

   @DoItems:
    JSR Shop_SpellDescription
    JMP _CommonShopLoop_Main

Shop_SpellDescription: ;; also used by the learning magic menu
    TAX
    LDA #BANK_ITEMDESC
    STA cur_bank
    JSR ItemDescriptions
    LDA #BANK_MENUS
    STA cur_bank
    RTS








;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Draw Shop Cursor   [$A9EF :: 0x3A9FF]
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

DrawShopCursor:
    LDA cursor_x     ; copy over the shop cursor coords
    STA spr_x
    LDA cursor_y
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
;; JIGS - really cram 'em in there! Let Light Warrior #2 see the wares!

    LDA #$82
    STA spr_x
    LDA #$2A ;44
    STA spr_y
    LDA #0<<6
    JSR DrawOBSprite

    LDA #$42 ;5D
    STA spr_y
    LDA #1<<6
    JSR DrawOBSprite

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
    STA text_ptr+1          ;  ... then draw it....
    JMP DrawMenuComplexString





;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Draw Shop Dialogue Box  [$AA5B :: 0x3AA6B]
;;
;;     Draws the shop dialogue and desired text string (shop text string ID in A)
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

DrawShopDialogueBox:
    PHA                  ; back up desired dialogue string by pushing it
    LDA #SHOPBOX_SHOPKEEP
    JSR DrawMainItemBox  ; draw shop box ID 0 (the dialogue box)
    PLA                  ; pull our dialogue string
    JMP DrawShopString   ; draw it, then exit

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Draw Inn Clinic Confirm  [$AA9B :: 0x3AAAB]
;;
;;    Draws the confirmation dialogue for inns/clinics
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

DrawInnClinicConfirm:
    LDA #$0C
    JSR DrawShopDialogueBox   ; draw "Gold  OK?" -- all the non-price text

    LDA #0
    STA tmp
    STA tmp+1

    LDA shop_type
    CMP #SHOP_CLINIC
    BEQ @CalculateClinicPrice

   @CalculateInnPrice:    ;; JIGS - Each character's level x 5 added up
    LDX #05
    LDA ch_level
    CLC
    ADC ch_level+$40
    ADC ch_level+$80
    ADC ch_level+$C0
    ADC #$04             ;; add 4 to make all levels 1-based
    STA tmp

    CMP #64              ;; if the part's level is 4*16, then double the price
    BCC @DrawNumber

    LDX #10
    CMP #100             ;; if the party's level is 4*25 then triple the price
    BCC @DrawNumber

    LDX #15
    CMP #140             ;; if the party's level is 4*35 then price gouge those
    BCC @DrawNumber      ;; foolishly rich light warriors!

    LDX #25
    BNE @DrawNumber

   @CalculateClinicPrice:
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
    STX shop_curitem

    LDA ch_level, X
    CLC
    ADC #01         ;; make level 1 based
    LDX #50         ;; JIGS - price for clinic is level * 50
    STA tmp
    AND #$F0
    BEQ :+

    LDX #75        ;; except past level 16, it is level * 75
    LDA tmp
    CMP #25
    BCC :+

    LDX #125       ;; and past level 25, it is level * 125
    LDA tmp
    CMP #35
    BCC :+

    LDX #200       ;; and past level 35, it is level * 200

  : LDA tmp

   @DrawNumber:
    JSR MultiplyXA
    STA tmp
    STA item_box
    STX tmp+1
    STX item_box+1
   ; LDA item_box              ; copy the inn price (first dtwo bytes in item_box)
   ; STA tmp                   ;  to tmp  (for PrintNumdber)
   ; LDA item_box+1
   ; STA tmp+1
    LDA #0
    STA tmp+2                 ; 5digit print number needs 3 bytes... so just set high byte to zero
    STA item_box+3
    INC dest_y
    INC dest_y
    LDA #04
    STA dest_x
    ;; JIGS - movin' numbers on the screen

    JSR PrintNumber_5Digit    ; print it
    JMP DrawShopComplexString ; and draw it





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
    .word SaveScreen_FromMenu
    .byte BANK_TITLE

    LDA music_track             ; check the music track
    BMI :+                      ; high bit set if music is not playing
    LDA SaveGameMusic
    AND #$01                    ; will be 0 if saving didn't happen
    BEQ :++
  : LDA dlgmusic_backup         ; pre-emptively end the save music
    STA music_track
  : RTS


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

FullHealingTile:           ; the tile in maps that heals all HP/MP
    JSR MenuFillPartyHP

MenuRecoverPartyMP:
    LDX #0                 ; X is our character index.  Start with character 0

  @Loop:
    JSR MenuRecoverSingleMP

    TXA             ; move index into A to do some math
    SEC
    SBC #$38        ; JIGS - undo the +$30 and +8 added to X
    CLC
    ADC #$40        ; add $40 (next character in part
    TAX             ; put back in X
    BNE @Loop       ; and loop until it wraps (full party)
    RTS             ; then exit

MenuRecoverSingleMP:
    JSR CheckDeadStone
    BCS @Skip

    LDY #0
    TXA             ; $0, $40, $80, or $C0
    CLC
    ADC #ch_mp - ch_stats    ; +$30
    TAX

   @InnerLoop:
    LDA ch_stats, X ; X is pointer to level 1 MP
    AND #$0F        ; clear current mp entirely, leaving only max mp
    STA tmp+1       ; back it up
    ASL A           ; shift by 4
    ASL A
    ASL A
    ASL A           ; to put max mp into high bits--current mp
    ORA tmp+1       ; add max mp back in
    STA ch_stats, X ; and save it
    INY
    INX             ; +1 for each spell level
    CPY #08
    BNE @InnerLoop

   @Skip:
    RTS



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

    LDA Options
    AND #SFX_MUTED
    BEQ @Done

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

    LDA Options
    AND #SFX_MUTED
    BEQ @Done

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
    LDA Options
    AND #SFX_MUTED
    BEQ SFX_Done

PlayHealSFX_Map:
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

    SFX_Done:
    RTS              ;  and exit!


PlaySFX_CharSwap:
    LDA Options
    AND #SFX_MUTED
    BEQ @Done

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




ClearMenuOtherNametables:
;; JIGS - just a little thing for the menu, when you shut off SFX, it'll shake the screen for errors instead.
;; This stops it from showing a pixel's worth of garbage on the side.
    LDA #$2002
    LDX #>$2400
    LDA #<$2400
    STX $2006   ; write X as high byte
    STA $2006   ; A as low byte

    LDY #4                    ; loops to clear $0400 bytes of NT data (right nametables)
  @ClearNT_OuterLoop:
      LDX #0
    @ClearNT_InnerLoop:         ; inner loop clears $100 bytes
        STA $2007
        DEX
        BNE @ClearNT_InnerLoop
      DEY                       ; outer loop runs inner loop 8 times
      BNE @ClearNT_OuterLoop    ;  clearing $800 bytes total
    RTS

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Enter Main Menu  [$ADB3 :: 0x3ADC3]
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

MusicPlay_LoadingCHR:      ; this is to smooth out music while loading up screens
    JSR WaitForVBlank_L
    JMP CallMusicPlay

DrawGameTime:
    LDA playtimer+1 ; seconds
    STA tmp
    JSR FormatNumber_2Digits ; formats, but doesn't remove leading 0s
    LDA format_buf-2
    STA bigstr_buf+6
    LDA format_buf-1
    STA bigstr_buf+7

    LDA playtimer+2 ; minutes
    STA tmp
    JSR FormatNumber_2Digits ; formats, but doesn't remove leading 0s
    LDA format_buf-2
    STA bigstr_buf+3
    LDA format_buf-1
    STA bigstr_buf+4

    LDA playtimer+3 ; hours
    STA tmp
    JSR FormatNumber_2Digits ; formats, but doesn't remove leading 0s
    LDA format_buf-1
    STA bigstr_buf+1
    LDA format_buf-2
    STA bigstr_buf

    LDA #$E4        ; : seperators
    STA bigstr_buf+2
    STA bigstr_buf+5
    LDA #0
    STA bigstr_buf+8

    LDA #<(bigstr_buf)
    STA text_ptr
    LDA #>(bigstr_buf)
    STA text_ptr+1
    LDA #02
    STA dest_x
    LDA #27
    STA dest_y
    LDA #1
    STA menustall
    JSR WaitForVBlank_L
    JMP DrawComplexString

EnterMainMenu:
    LDA #0
    STA $2001           ; turn off the PPU (we need to do some drawing)
    LDA #BANK_THIS
    STA cur_bank          ; set cur_bank to this bank
    JSR LoadMenuCHRPal        ; load menu related CHR and palettes

;; ResumeMainMenu is called to redraw and reenter the main menu from other
;;  sub menus (like from the item menu).  This will redraw the main menu, but
;;  won't restart the music or reload CHR like EnterMainMenu does

ResumeMainMenu:
    LDA #0
    STA $2001                       ; turn off the PPU
    STA menustall                   ; and disable menu stalling
    STA joy
    STA joy_prevdir
    STA item_pageswap

    ;; reload first 3 palettes
    LDX #$0B
  @Loop:                      ; load a few other main menu related palettes
      LDA lutMenuPalettes, X  ; fetch the palette from the LUT
      STA cur_pal, X          ; and write it to the palette buffer
      DEX
      BPL @Loop               ; loop until X wraps ($0C colors copied)

    JSR LongCall              ; do this to update max HP for drawing
    .word SetPartyStats
    .byte BANK_Z

    JSR DrawMainMenu                ; draw the main menu
    LDA #$03                        ; draw the little dot that marks the party map character
    JSR SetLeadIndexTile
    JSR ClearMenuOtherNametables
    ;; JIGS ^ clear out the side nametables so screen shaking doesn't produce garbage pixels
    LDA #BANK_THIS
    STA cur_bank
	JSR MusicPlay_LoadingCHR
    JSR TurnMenuScreenOn_ClearOAM   ; then clear OAM and turn the screen on

MainMenuResetCursorMax:
    LDA #0
    STA cursor                      ; flush cursor, joypad, and prev joy directions

    LDA mapflags            ; make sure we're on the overworld
    LSR A                   ;  Get SM flag, and shift it into C
    BCS @CheckTile          ; if not on overworld, then don't let cursor touch save option

   @SetMax6:
    LDA #6
    BNE :+

   @CheckTile:
    LDA tileprop_now        ; check tile they're standing on
    CMP #TP_SPEC_USESAVE    ; if its a safe tile to save on...
    BEQ @SetMax6            ; then allow using the save option!

   @SetMax5:
    LDA #5                        ;; JIGS - set cursor max to 5
  : STA cursor_max                ; flow seamlessly into MainMenuLoop

MainMenuLoop:
    JSR ClearOAM                  ; clear OAM (erasing all existing sprites)
    JSR DrawMainMenuCursor        ; draw the cursor
    JSR DrawMainMenuCharSprites   ; draw the character sprites
    JSR DrawGameTime
    JSR MainMenuFrame             ; Do a frame

    LDA joy_a                     ; check to see if A has been pressed
    BNE @A_Pressed
    LDA joy_b                     ; then see if B has been pressed
    BNE @B_Pressed
    LDA joy_select
    BNE @Select_Pressed
    LDA joy_start
    BNE @Start_Pressed

    JSR MoveCursorUpDown          ; then move the cursor up or down if up/down pressed
    JMP MainMenuLoop              ;  rinse, repeat

   @Select_Pressed:
    JSR LineUp_InMenu
    BCC ResumeMainMenu            ; characters swappwed ; redraw menu
    JMP MainMenuResetCursorMax    ; not swapped - just reset the cursor

   @Start_Pressed:
    JSR WaitForVBlank_L
    LDA #$FF
    JSR SetLeadIndexTile

    LDA lead_index
    CLC
    ADC #$40
    STA lead_index

    LDA #03
    JSR SetLeadIndexTile
    JSR PlaySFX_CharSwap
    JMP MainMenuLoop

   @B_Pressed:
    JSR ClearButtons
    STA $2001
    JMP CallMusicPlay ; and exit the main menu (will RTS out of its loop)

    ; if A pressed, we need to move into the appropriate sub menu based on 'cursor' (selected menu item)

   @A_Pressed:
    JSR PlaySFX_MenuSel         ; play the selection sound effect
    LDA cursor                  ; get the cursor
    ASL A
    TAX

    LDA @MenuJumpList, X
    STA tmp
    LDA @MenuJumpList+1, X
    STA tmp+1
    JMP (tmp)

   @MenuJumpList:
    .word @Item
    .word @Magic
    .word @Equip
    .word @Status
    .word @Option
    .word @Save

   @ReturnToMainMenu:
    JMP MainMenuResetCursorMax

   @Item:
    LDA #0
    STA cursor_x
    STA cursor_y
    STA submenu_cursor
    STA item_pageswap
    JSR EnterItemMenu         ; enter item menu
    JMP ResumeMainMenu        ; then resume (redraw) main menu

   @Magic:
    JSR MainMenuSubTarget      ; select a sub target
    BCS @ReturnToMainMenu      ; if B pressed, they want to escape sub target menu.

    JSR Cursor_to_Index
    ;LDA cursor                ; otherwise (A pressed), get the selected character
    ;ROR A
    ;ROR A
    ;ROR A
    ;AND #$C0                  ; and shift it to a useable character index
    ;TAX                       ; and put in X

    LDA ch_ailments, X        ; get this character's OB ailments
    AND #AIL_DEAD | AIL_STOP  ; see if they're dead or stone
    BEQ @CanUseMagic          ; otherwise.. you can

   @CantUseMagic:             ; if dead or stone...
    JSR PlaySFX_Error         ;  play error sound effect
    JMP @Magic                ;  and continue magic loop until valid option selected

   @CanUseMagic:
    JSR EnterMagicMenu        ; if target is valid.. enter magic menu
    JMP ResumeMainMenu        ; then resume (redraw) main menu and continue

   @Equip:
    JSR MainMenuSubTarget
    BCS @ReturnToMainMenu
     LDA submenu_targ
     STA char_id              ; get target character ID
      LSR A
      ROR A
      ROR A
      ;AND #$C0               ; shift to make ID a usable index
      STA char_index
      LDA #0
      STA equipoffset
      STA DualWieldStats
    JSR EnterEquipMenu        ; and enter equip menu (Weapons menu)
    JMP ResumeMainMenu        ; then resume main menu

   @Status:
    JSR MainMenuSubTarget     ; select a sub target
    BCS @ReturnToMainMenu     ;  if they escaped the sub target selection, then escape it
    JSR EnterStatusMenu       ; otherwise, enter Status menu
    JMP ResumeMainMenu        ; then resume (redraw) main menu

   @Option:
    LDA #0
    STA $2001               ; turn off the PPU
    STA menustall           ; disable menu stalling
    JSR ClearNT             ; clear the NT
    JSR LongCall
    .word OptionsMenu
    .byte BANK_TITLE
    LDA #$01
    STA cur_pal+14
    JMP ResumeMainMenu

   @Save:
    JSR SaveGame
    JMP EnterMainMenu ; uses Enter instead of Resume, to re-load the appropriate character sprites


SetLeadIndexTile:
    PHA
    LDA $2002
    LDA lead_index
    CLC
    ROL A
    ROL A
    ROL A
    ASL A
    TAY
    LDA LeadIndicator_LUT, Y
    LDX LeadIndicator_LUT+1, Y
    JSR SetPPUAddr_XA
    PLA
    STA $2007
    JMP ResetScroll

LeadIndicator_LUT:
    .word $2070
    .word $2130
    .word $21F0
    .word $22B0


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
    JSR DrawMainMenuSubCursor    ; draw the sub target cursor
    JSR DrawMainMenuCharSprites  ; draw the main menu battle sprite
    JSR DrawGameTime
    JSR MainMenuFrame            ; Do a frame

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


DrawTitleTargetName:
    LDA #MBOX_TITLE
    JSR DrawMainItemBox
    DEC dest_y
    LDA #7
    JMP DrawCharMenuString         ; draw the character's name

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
    LDA #MBOX_INV
    JSR DrawMainItemBox          ; Draw the box itself from the list of MainItem boxes
    LDA #18                      ; and draw string 2A (entire spell list, along with level names an MP amounts
    JSR DrawCharMenuString       ;   -- ALL the text in one string!)

    LDX char_index
    LDY #0
  @Loop:
    LDA ch_spells, X
    BNE @FoundSpell
    INX
    INY
    CPY #24
    BNE @Loop          ; loop until we've checked every spell

    INC submenu_cursor ; set to 1 if no spells found
    RTS

  @FoundSpell:
    TYA               ; if we found a spell... move which spell into A
    STA backup_cursor ; put found spell in this variable
    INC cursor_change ; indicate that there is at least 1 spell for the submenu
    RTS               ; and exit



DrawMagicMenu:
    LDA #0
    STA cursor_change              ; stays 0 if no spells found
    STA submenu_cursor             ; will be set to 1 later if there are no spells learned

    STA $2001                      ; turn off PPU
    STA menustall                  ; clear menustall
    STA descboxopen                ; and mark description box as closed

    JSR ClearNT                    ; clear the nametable
    JSR DrawMagicMenuMainBox       ; draw the big box containing all the spells

    ;; submenu_cursor is set to 1 if no spells are found

    JSR DrawTitleTargetName
    LDA #MBOX_SUBMENU
    JMP DrawMainItemBox            ; sub menu box



EnterMagicMenu:
    LDA #0
    STA cursor
    JSR DrawMagicMenu

EnterMagicMenu_ResetSubMenuText:
    LDA #10
    STA dest_x
    LDA #02
    STA dest_y
    LDA #67
    JSR DrawMenuString             ; "Cast / Learn / Forget"
    JSR TurnMenuScreenOn_ClearOAM  ; clear OAM and turn the screen on

    LDA submenu_cursor
    BEQ PeruseMagicMenu
    CMP #2
    BEQ PeruseMagicMenu

MagicSubMenuLoop:
    JSR ClearOAM                ; clear OAM
    JSR DrawMagicSubMenuCursor  ; draw the cursor
    JSR MenuFrame               ; and do a frame

    LDA joy_a
    BNE @A_Pressed              ; check if A pressed
    LDA joy_b
    BNE @B_Pressed              ; and B

    JSR MoveSubMenuCursor       ; otherwise, move the cursor if a direction was pressed
    JMP MagicSubMenuLoop        ; and keep looping

   @B_Pressed:
    RTS                         ; if B pressed, just exit

   @A_Pressed:
    LDA submenu_cursor
    BEQ @CheckForSpells         ; see if there's a spell to cast
    CMP #1
    BNE @CheckForSpells         ; see if there's a spell to forget
    LDA #0
    STA cursor_x
    STA cursor_y                ; clear the x/y cursor positions
    JMP MagicMenu_LearnSpell

   @CheckForSpells:
    LDA cursor_change           ; is 0 if no spells are known
    BNE @PeruseMagicMenu_SFX
    JSR PlaySFX_Error
    INC submenu_cursor          ; no spells, so move the cursor to "Learn"
    JMP MagicSubMenuLoop

   @PeruseMagicMenu_SFX:
    JSR PlaySFX_MenuSel

PeruseMagicMenu:
    LDA #0                      ; otherwise.... (they have magic)
    STA joy                     ; clear joypad
    STA joy_prevdir             ; and previous joy directions

MagicMenu_Loop:
    JSR ClearOAM                ; clear OAM
    JSR DrawMagicMenuCursor     ; draw the cursor
    JSR UpdateMP
    JSR MenuFrame               ; and do a frame

    LDA joy_a
    BNE @A_Pressed              ; check if A pressed
    LDA joy_b
    BNE @B_Pressed              ; and B

    JSR MoveMagicMenuCursor     ; otherwise, move the cursor if a direction was pressed
    JMP MagicMenu_Loop          ; and keep looping

   @B_Pressed:
    JMP EnterMagicMenu_ResetSubMenuText  ; if B pressed, just exit

   @A_Pressed:
    JSR PlaySFX_MenuSel         ; play the selection sound effect
    LDA submenu_cursor
    BEQ MagicMenu_Cast

   @CheckToForget:
    LDA #71
    JSR DrawItemDescBox         ; print "forget this spell?"
    JSR MenuWaitForBtn_SFX
    LDA joy
    AND #$80
    BNE MagicMenu_ForgetSpell   ; if B was pressed, resume loop
    JSR CloseDescBox
    JMP PeruseMagicMenu

MagicMenu_ForgetSpell:
    JSR Set_Inv_Magic
    LDA cursor
    CLC
    ADC char_index
    TAX
    LDA ch_spells, X            ; get spell ID
  ;  BEQ @Oops
    TAY
    LDA #0
    STA ch_spells, X            ; clear that byte in their spell list
    DEY
    TYA                         ; subtract 1 to shift the ID to 0-based
    JSR ADD_ITEM                ; put it back in the inventory

    JSR DrawMagicMenu           ; reload the magic screen to show the spell has vanished
    LDA cursor_change
    BNE PeruseMagicMenu
    INC submenu_cursor          ; set submenu cursor to Forget
    JMP MagicSubMenuLoop        ; and resume forgetting

  ; @Oops:                            ; you tried to forget a spell that doesn't exist!
  ;  JSR PlaySFX_Error                ; this really shouldn't be possible
  ;  JMP PeruseMagicMenu

MagicMenu_Cast:
    JSR UseMagic_GetRequiredMP  ; see if we have MP to cast selected spell
    BCS @HaveMP                 ; if so, skip ahead

    LDA #63                     ; otherwise...
    JSR DrawItemDescBox         ;  print "you don't have enough MP" or whatever message (description text ID=$32)
    JMP PeruseMagicMenu         ;  and return to loop

   @HaveMP:
    LDA cursor
    STA backup_cursor
    CLC
    ADC char_index
    TAX

    LDA #0
    STA cursor
    LDA submenu_targ
    PHA

    LDA ch_spells, X

       ;  This is all a hardcoded mess.  Which I guess is fine because only a handful
       ; of spells can be cast outside of battle.  This code just checks the above calculated
       ; spell ID against every spell you can cast outside of battle, and jumps to that spell's
       ; routine where appropriate.


    CMP #MG_CURE             ; just keep CMPing with every spell you can cast out of battle
    BNE :+                   ;  until we find a match
      JMP UseMagic_CURE      ;  then jump to that spell's routine
  : CMP #MG_CUR2
    BNE :+
      JMP UseMagic_CUR2
  : CMP #MG_CUR3
    BNE :+
      JMP UseMagic_CUR3
  : CMP #MG_CUR4
    BNE :+
      JMP UseMagic_CUR4
  : CMP #MG_REGN ; MG_HEAL
    BNE :+
      JMP UseMagic_HEAL
  : CMP #MG_RGN2 ; MG_HEL2
    BNE :+
      JMP UseMagic_HEL2
  : CMP #MG_RGN3 ; MG_HEL3
    BNE :+
      JMP UseMagic_HEL3
  : CMP #MG_PURE
    BNE :+
      JMP UseMagic_PURE
  : CMP #MG_LIFE
    BNE :+
      JMP UseMagic_LIFE
  : CMP #MG_LIF2
    BNE :+
      JMP UseMagic_LIF2
  : CMP #MG_WARP
    BNE :+
      JMP UseMagic_WARP
  : CMP #MG_SOFT
    BNE :+
      JMP UseMagic_SOFT
  : CMP #MG_EXIT
    BNE :+
      JMP UseMagic_EXIT
  : CMP #MG_LAMP
    BNE :+
      JMP UseMagic_LAMP

  : PLA
    LDA #64                 ; gets here if no match found.
    JSR DrawItemDescBox     ; print description text ("can't cast that here")
    JMP MagicMenu_Loop      ; and return to magic loop

;;;;;;;;;;;;;;;

CureSpellPotency:
    JSR BattleRNG_L         ; use the frame counter as a make-shift pRNG
    AND #$0F                ; mask out the low bits
    ORA #$10                ; and ORA (effective range:  16-31)
    RTS

Cure2SpellPotency:
    JSR BattleRNG_L         ; same deal, but double the recovery
    AND #$1F
    ORA #$20                ; (effective range:  32-63)
    RTS

Cure3SpellPotency:
    JSR BattleRNG_L         ; same deal -- but double it again
    AND #$3F
    ORA #$40                ; (effective range:  64-127)
    RTS

UseMagic_CURE:
    LDA #1
    BNE UseMagic_CureFamily

UseMagic_CUR2:
    LDA #2
    BNE UseMagic_CureFamily

UseMagic_CUR3:
    LDA #4
    BNE UseMagic_CureFamily

UseMagic_CUR4:
    LDA #8

UseMagic_CureFamily:
    STA MMC5_tmp+2
    JSR DrawItemTargetMenu  ; draw the item target menu (gotta choose who to target with this spell)
    LDA #44
    JSR DrawItemDescBox     ; load up the relevent description text

CureFamily_Loop:
    JSR ItemTargetMenuLoop  ; handle the item target menu loop
    BCS CureFamily_Exit     ; if they pressed B, just exit

    JSR UseMagic_CheckMP
    BEQ CureFamily_Exit

    LDA MMC5_tmp+2
    LSR A
    BCC :+
        JSR CureSpellPotency
        BNE @DoCureSpell
  : LSR A
    BCC :+
        JSR Cure2SpellPotency
        BNE @DoCureSpell
  : LSR A
    BCC :+
        JSR Cure3SpellPotency
        BNE @DoCureSpell
  : LDA #$FF

   @DoCureSpell:
    STA hp_recovery         ; store the HP to be recovered for future use
    LDA #0
    STA hp_recovery+1
    JSR Cursor_to_Index
    JSR MenuRecoverHP       ; will check if target is dead and set C if so
    BCS CureFamily_CantUse  ; for Cure 4, will do 256 HP, but cap it--and will copy max to current next anyway

    LDA hp_recovery         ; otherwise, we can target.  Get the HP to recover
    CMP #$FF                ; check if its Cure 4
    BNE :+

    LDA ch_maxhp+1, X
    STA ch_curhp+1, X
    LDA ch_maxhp, X
    STA ch_curhp, X
    LDA ch_ailments, X
    AND #AIL_DEAD | AIL_STOP
    STA ch_ailments, X      ; JIGS - also now does the battle effect of fixing most ailments (poison and blind here)

  : JSR PlayHealSFX
    JSR SetStallAndWait
    JSR DrawItemTargetMenu_OneChar  ; then update the healed character's info
    JSR UseMagic_SpendMP    ; JIGS
    JMP CureFamily_Loop

  CureFamily_Exit:
    JMP EnterMagicMenu      ; to exit, re-enter (redraw) magic menu

  CureFamily_CantUse:
    JSR PlaySFX_Error       ; if can't use, play the error sound effect
    JMP CureFamily_Loop     ; and loop until you get a proper target

;;;;;;;;;;;;;;

HealSpellPotency:
    JSR BattleRNG_L         ; use the framecounter as a makeshift pRNG
    AND #$07                ;  get low bits
    CLC
    ADC #$10                ; and ADD $10 (not ORA)  (effective range:  16-23)
    RTS

Heal2SpellPotency:
    JSR BattleRNG_L         ; same deal as HEAL, only different number
    AND #$0F
    CLC
    ADC #$20                ; (effective range:  32-47)
    RTS

Heal3SpellPotency:
    JSR BattleRNG_L         ; same deal....
    AND #$1F
    CLC
    ADC #$40                ; (effective range:  64-95)
    RTS

    ;; JIGS - these use BattleRNG_L instead of the framecounter, to more randomize the healing between characters
    ;; since it is now called for each character instead of the whole spell... the way it does it in battle, I think.

UseMagic_HEAL:
    LDA #1
    BNE UseMagic_HealFamily

UseMagic_HEL2:
    LDA #2
    BNE UseMagic_HealFamily

UseMagic_HEL3:
    LDA #4

UseMagic_HealFamily:
    STA MMC5_tmp+2
    JSR DrawItemTargetMenu
    LDA #53
    JSR DrawItemDescBox     ; draw the relevent description text

   @HealMenuLoop:
    JSR ClearOAM            ; clear OAM (no sprites)
    JSR MenuWaitForBtn      ; wait for the user to press a button

    LDA joy                 ; see whether the user pressed A or B
    AND #$80                ; check A
    BEQ HealFamily_Exit     ; if not A, they pressed B... so exit

    JSR UseMagic_CheckMP
    BEQ HealFamily_Exit

    LDA #0
    STA cursor
   @HealLoop:
    LDA MMC5_tmp+2
    LSR A
    BCC :+
        JSR HealSpellPotency
        BNE @DoHealSpell
  : LSR A
    BCC :+
        JSR Heal2SpellPotency
        BNE @DoHealSpell
  : JSR Heal3SpellPotency

   @DoHealSpell:
    STA hp_recovery         ; otherwise (pressed A), get HP recovery
    LDA #0
    STA hp_recovery+1
    JSR Cursor_to_Index
    JSR MenuRecoverHP       ; recover one
    JSR SetStallAndWait
    JSR DrawItemTargetMenu_OneChar
    INC cursor
    LDA cursor
    CMP #4
    BNE @HealLoop

    JSR PlayHealSFX
    JSR UseMagic_SpendMP
    JMP @HealMenuLoop

 HealFamily_Exit:
    JMP EnterMagicMenu      ; to exit, just re-enter magic menu

;;;;;;;;;;;;;;;;;;;;;;;

UseMagic_LIFE:
    LDA #49
    PHA
    LDA #1
    BNE UseMagicCureAilment

UseMagic_SOFT:
    LDA #48
    PHA
    LDA #2
    BNE UseMagicCureAilment

UseMagic_PURE:
    LDA #47
    PHA
    LDA #4
    BNE UseMagicCureAilment

UseMagic_LAMP:
    LDA #56
    PHA
    LDA #8
    BNE UseMagicCureAilment

UseMagic_LIF2:
    LDA #49
    PHA
    LDA #$10

UseMagicCureAilment:
    STA hp_recovery
    JSR DrawItemTargetMenu  ; draw the target menu
    PLA
    JSR DrawItemDescBox     ; and relevent description text

   @Loop:
    JSR ItemTargetMenuLoop  ; do the target loop
    BCS @CureAilment_Exit

    JSR UseMagic_CheckMP
    BEQ @CureAilment_Exit

    LDA hp_recovery
    CMP #$10
    BNE :+
     LDA #1
  : STA tmp                 ; put it in tmp for 'CureOBAilment' routine
    JSR CureOBAilment       ; attempt to cure death!
    BCS @CantUse            ; if the char didn't have the death ailment... can't use this spell on him

    LDA hp_recovery
    LSR A
    BCC :+
        LDA #1              ; otherwise it worked.  Give them 1 HP now that they're alive
        STA ch_curhp, X
        BNE @Success
  : LSR A ; Soft in C
    LSR A ; Pure in C
    LSR A ; Lamp in C
    LSR A ; Life 2 in C
    BCC @Success

    LDA ch_maxhp, X         ; for Life 2, refill their HP to max, instead of just giving them 1 HP
    STA ch_curhp, X
    LDA ch_maxhp+1, X
    STA ch_curhp+1, X

   @Success:
    JSR PlayHealSFX
    JSR SetStallAndWait
    JSR DrawItemTargetMenu_OneChar
    JSR UseMagic_SpendMP    ; JIGS
    JMP @Loop

   @CureAilment_Exit:
    JMP EnterMagicMenu      ; and exit by re-entering magic menu

   @CantUse:
    JSR PlaySFX_Error       ; if you can't use it, play the error sound
    JMP @Loop               ;  and loop!


;;;;;;;;;;;;;;;;;;;;;;;

UseMagic_WARP:
    LDA #61
    JSR DrawItemDescBox       ; draw description text
    JSR MenuWaitForBtn_SFX

    LDA joy                 ; see whether the user pressed A or B
    AND #$80                ; check A
    BEQ CancelWarp_Exit     ; if not A, they pressed B... so exit

    ;PLA                     ; pull the submenu_targ backup to toss it away
    JSR UseMagic_SpendMP ; JIGS

    ;JSR MenuWaitForBtn_SFX    ; wait for a button press

    TSX                  ; get the stack pointer
    TXA                  ; and put it in A
    CMP #$FF - 16        ; check the stack pointer to see if at least 16 bytes have been pushed
    BCS UseMagic_DoEXIT  ;  if not, WARP would have the same effect as EXIT, so just jump to EXIT code

    CLC                  ; otherwise, we're to go back one floor
    ADC #9               ;   so add 6 to the stack pointer (kills the last 4 JSRs + the Push to backup submenu_targ)
    TAX                  ;   which would be:  JSR to Magic Menu (+ JSR to Magic Submenu)
    TXS                  ;                    JSR to Main Menu
                         ;                and JSR to Standard Map loop
    LDA #0               ; turn off PPU and APU
    STA $2001
    STA $4015
    STA MenuHush
    RTS                  ; and RTS.  See notes below

UseMagic_EXIT:
    LDA #62
    JSR DrawItemDescBox       ; draw description text
    JSR MenuWaitForBtn_SFX    ; wait for button press
    LDA joy                   ; see whether the user pressed A or B
    AND #$80                  ; check A
    BEQ CancelWarp_Exit       ; if not A, they pressed B... so exit

    JSR UseMagic_SpendMP ; JIGS

UseMagic_DoEXIT:
    DEC MenuHush
    JMP DoOverworld           ; then restart logic on overworld by JMPing to DoOverworld

CancelWarp_Exit:
    JMP EnterMagicMenu

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
    ADC char_index
    ADC #ch_mp - ch_stats
    TAX
    STX mp_required
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
;.byte $08,$08,$08

ConvertSpellByteToBit_LUT:
    .byte %10000000 ; Cure    Lamp   Cure 2  Pure     Cure 3   Soft    Cure 4  Life 2
    .byte %01000000 ; Harm    Mute
    .byte %00100000 ; Sheild  A-Bolt
    .byte %00010000 ; Blink   Invis
    .byte %00001000 ; Fire    Ice    Fire 2  Sleep 2  Fire 3   Lit 3   Ice 3   Nuke
    .byte %00000100 ; Sleep   Dark
    .byte %00000010 ; Lock    Temper
    .byte %00000001 ; Bolt    Slow
    ;; or:
    .byte $80,$40,$20,$10,$08,$04,$02,$01
    ;; this is 16 bytes long, because the high bits of the spell ID are unnecessary.
    ;; otherwise it needs to be 64 bytes long, one for each spell, even if every 8 bytes is the same.

UseMagic_SpendMP:
    LDX mp_required
    LDA ch_stats, X
    SEC
    SBC #$10
    STA ch_stats, X
    RTS

UseMagic_CheckMP:
    LDX mp_required
    LDA ch_stats, X
    AND #$F0
    RTS             ; JIGS - BEQ to CantUse after calling this




MagicMenuMPTitle:
.byte $95,$A8,$B9,$A8,$AF,$FF,$FF,$FF,$96,$99,$FF,$C3,$C3,$FF,$FF,$7A,$FF,$FF,$FF,$00 ; Level___MP_...._*/*__

UpdateMP_Exit:
    RTS

UpdateMP:
    LDA submenu_cursor
    CMP #2
    BEQ UpdateMP_Exit         ; don't display MP if forgetting spells
    LDA cursor_change
    BEQ UpdateMP_Exit

    LDA #<MagicMenuMPTitle
    STA text_ptr
    LDA #>MagicMenuMPTitle
    STA text_ptr+1

    LDY #0
    STY cursor_change
   @Loop:
    LDA (text_ptr), Y
    STA str_buf, Y
    INY
    CPY #$14
    BNE @Loop

    LDX cursor
    LDA BigSpellLevel_LUT, X
    CLC
    ADC #$81
    STA str_buf+$6           ; put spell level in the string

    JSR UseMagic_GetRequiredMP
    LSR A
    LSR A
    LSR A
    LSR A                     ; shift high bits to low
    ORA #$80
    STA str_buf+$0E           ; put current MP in the string
    LDX mp_required
    LDA ch_stats, X
    AND #$0F
    ORA #$80
    STA str_buf+$10           ; put max MP in the string

    LDA #<(str_buf)
    STA text_ptr
    LDA #>(str_buf)           ; load pointer from table, store to text_ptr  (source pointer for DrawComplexString)
    STA text_ptr+1

    LDA #$0C
    STA dest_x
    LDA #$02
    STA dest_y

    LDA #1
    STA menustall

    JMP DrawComplexString










MagicMenu_LearnSpell:
    JSR DrawLearnSpellMenu
    LDA #MBOX_ITEMDESC    ; draw main/item box ID $08  (the description box)
    JSR DrawMainItemBox
    JSR TurnMenuScreenOn_ClearOAM

    LDA #1
    STA cursor_change     ; trigger this to happen on page load
    STA descboxopen

   @LearnSpell_MainLoop:
    LDA cursor_change
    BEQ @MainLoopCont

    DEC cursor_change     ; to stop this part from happening every frame
    STA menustall         ; cursor_change was 1, so set menustall to 1
    LDA #$8
    STA dest_x
    LDA #$17
    STA dest_y

    LDA cursor_x          ; get cursor x position, shift it 3 times, add the y position, that's the spell ID!
    ASL A
    ASL A
    ASL A
    ADC cursor_y
    STA tmp+8             ; backup spell ID
    JSR @DoesSpellExist
    BNE @DoDescription

   @ClearDescriptionBox:
    LDA #MBOX_ITEMDESC    ; redraw the description box to clear it
    JSR DrawMainItemBox
    JMP @LearnSpell_MainLoop

   @DoDescription:
    LDA tmp+8
    ADC #15               ; add 15 to skip the item descriptions and use magic ones
    JSR Shop_SpellDescription

   @MainLoopCont:
    JSR ClearOAM                  ; clear OAM
    JSR DrawMagicLearnMenuCursor  ; draw the cursor
    JSR MenuFrame                 ; and do a frame

    LDA joy_a
    BNE @A_Pressed                ; check if A pressed
    LDA joy_b
    BNE @B_Pressed                ; and B

    JSR MoveMagicLearnMenuCursor  ; otherwise, move the cursor if a direction was pressed
    JMP @LearnSpell_MainLoop      ; and keep looping

   @B_Pressed:
    JMP EnterMagicMenu

   @A_Pressed:
    JSR @DoesSpellExist
    BEQ @NoSpell

    JSR PlaySFX_MenuSel
    JSR TryLearnSpell
    BCS @ClearDescriptionBox      ; carry set if couldn't learn

    JMP MagicMenu_LearnSpell

   @NoSpell:
    JSR PlaySFX_Error
    JMP @LearnSpell_MainLoop      ; and keep looping

   @DoesSpellExist:
    JSR Set_Inv_Magic
    LDA tmp+8
    JMP DOES_ITEM_EXIST


LearnMenuAttributes:
.byte $CC,$D4,$DC,$E4,$D8,$E0 ; attribute positions
.byte $77,$77,$BB,$BB,$33,$33 ; values

LearnMenuSpellLevelStrings:
.byte 72,73,73,73,73,73,73,74

DrawLearnSpellMenu:
    LDA #0
    STA $2001                      ; turn off PPU
    STA menustall                  ; clear menustall
    STA descboxopen                ; and mark description box as closed

    JSR ClearNT

    ;; make the right page have green/purple orbs (or whatever color set by the palettes)
    LDX #5
    LDY #$23
   @AttrLoop:
    STY $2006
    LDA LearnMenuAttributes, X
    STA $2006
    LDA LearnMenuAttributes+6, X
    STA $2007
    DEX
    BPL @AttrLoop

    ;; load first 3 palettes
    LDX #$0B
  @PalLoop:                        ; load a few other main menu related palettes
      LDA lutSpellMenuPalettes, X  ; fetch the palette from the LUT
      STA cur_pal, X               ; and write it to the palette buffer
      DEX
      BPL @PalLoop                 ; loop until X wraps ($0C colors copied)

	LDA #MBOX_MAGIC_L
    JSR DrawMainItemBox          ; draw these first so the name and submenu boxes overlap
    LDA #MBOX_MAGIC_R
    JSR DrawMainItemBox          ; Draw the two learning menu boxes

    LDA #MBOX_TITLE
    JSR DrawMainItemBox
    DEC dest_y
    LDA #7
    JSR DrawCharMenuString         ; draw the character's name

    LDA #MBOX_SUBMENU
    JSR DrawMainItemBox            ; sub menu box
    DEC dest_y
    LDA #11
    STA dest_x

    LDX item_pageswap
    LDA LearnMenuSpellLevelStrings, X
    JSR DrawMenuString             ; Draw Spell Level

    ;; print the spell level inside the above string

    LDA #>$205A
    STA $2006
    LDA #<$205A
    STA $2006
    LDA item_pageswap
    CLC
    ADC #$81
    STA $2007

    ;; now check what spells exist in your inventory, and put them in a buffer to print

    LDA item_pageswap ; 0-7, convert to high nybble
    ASL A
    ASL A
    ASL A
    ASL A

    STA tmp+3      ; spell ID counter
    LDA #0
    STA tmp+4      ; left or right counter
    STA tmp+6      ; and Y backup

   @Loop:
    JSR Set_Inv_Magic   ; reset tmp and tmp+1
    LDA tmp+3           ; get spell ID
    INC tmp+3           ; inc spell ID
    JSR DOES_ITEM_EXIST ; uses tmp+2
    STA tmp             ; save amount for printing
    PHA

    ;; start doing the string...

    LDY tmp+6
    LDA #$E5            ;
    STA bigstr_buf, Y   ; magic orb tile in first slot
    LDA #$FF            ;
    STA bigstr_buf+1, Y ; space in second slot

    PLA
    BNE @Spellname

    LDA #$0B            ; if blank spell slot...
    STA bigstr_buf+2, Y ; repeat code in third slot
    LDA #$07
    STA bigstr_buf+3, Y ; repeat amount in fourth slot
    LDA #$C2
    STA bigstr_buf+4, Y ; repeat tile in fifth slot
    INY
    BNE @Amount

   @Spellname:
    LDA #06
    STA bigstr_buf+2, Y ; magic name code in third slot
    LDA tmp+3           ; get spell (now +1)
    STA bigstr_buf+3, Y ; spell ID in fourth slot

   @Amount:
    LDA #$FF
    STA bigstr_buf+4, Y ; another space in fifth slot
    LDA #$F1
    STA bigstr_buf+5, Y ; tiny x in sixth slot

    JSR PrintNumber_2Digit ; uses tmp to get the numbers
    LDA format_buf-2
    CMP #$FF
    BNE @DoubleDigits      ; is the tens column empty?

   @SingleDigits:
    LDA format_buf-1
    STA bigstr_buf+6, Y    ; single digit in seventh slot
    LDA #$FF
    BNE :+

   @DoubleDigits:
    STA bigstr_buf+6, Y    ; tens column in seventh slot
    LDA format_buf-1
  : STA bigstr_buf+7, Y    ; ones column in eighth slot | or a space

    LDA #01
    STA bigstr_buf+8, Y    ; double line break

    TYA
    CLC
    ADC #9
    TAY

    ;; Spell:
    ;;  0      1     2    3     4    5    6  7    8
    ;; $E5 - $FF - $06 - ID - $FF - $F1 - ## ## - $01

    ;; NoSpell:                   INY  4     5    6  7     8
    ;;  0      1     2    3     4   >  5     6    7  8     9
    ;; $E5 - $FF - $0B - $07 - $C2  - $FF - $F1 - ## ## - $01

    ;; [ @ CONFUSE x15][ @ ------- x0 ]
    ;; [ @ ICE   2 x1 ][ @ ------- x0 ]

   @ResumeLoop:
    STY tmp+6
    INC tmp+4          ; and 0-7 counter
    LDA tmp+4
    CMP #8             ; if counter is 8, end inner loop
    BNE @Loop

    LDA #0             ; put the null terminator in
    STA tmp+4          ; and reset 0-7 counter
    STA tmp+6          ; and Y backup
    STA bigstr_buf, Y

    LDA #<(bigstr_buf) ; fill text_ptr with the pointer to our item names in the big string buffer
    STA text_ptr
    LDA #>(bigstr_buf)
    STA text_ptr+1

    LDA tmp+3          ; get spell ID, see if its wrapped to $x0
    AND #$0F           ; by removing all the high bits
    BEQ @DrawRightSide

   @DrawLeftSide:
    LDA #02
    STA dest_x
    LDA #05
    STA dest_y
    JSR DrawComplexString  ; Draw all the item names
    JMP @Loop

   @DrawRightSide:
    LDA #18
    STA dest_x
    JMP DrawComplexString  ; Draw all the item names




TryLearnSpell:
    LDA #3
    STA shop_type       ; set shop_type for equip permissions...
    INC tmp+8           ; convert to 1-based ID
    LDA tmp+8           ; load magic ID
    JSR IsEquipLegal
    BNE @HasPermission  ;  if result is zero, they have permission to learn

    LDA #68             ; Print "Can't learn that"
    BNE @FailedToLearn

   @HasPermission:
    LDA tmp+8              ; spell ID
    LDX char_index
    LDY #24
   @KnownSpellsLoop:
    CMP ch_spells, X
    BEQ @AlreadyKnow
    INX
    DEY                    ; check all 24 spell slots
    BPL @KnownSpellsLoop

    LDA tmp+8
    LSR A
    LSR A
    LSR A
    LSR A                  ; shift spell level to low nybble
    LDX #3                 ; * 3
    JSR MultiplyXA
    CLC
    ADC char_index
    TAX                    ; X now points to the first slot this spell can be in

    ;; start from 0 and work up to 3, so that spells are saved sequentually instead of filling the 3rd slot first
    LDY #0
   @EmptySlotLoop:
    LDA ch_spells, X
    BEQ @FoundEmptySlot
    INX
    INY
    CPY #3
    BNE @EmptySlotLoop

    LDA #70                ; if no empty slot found... "That level is full" message ID
    BNE @FailedToLearn

   @AlreadyKnow:
    LDA #69                ; if they already know the spell...

   @FailedToLearn:
    JSR DrawItemDescBox    ; "You already know that"

    JSR MenuWaitForBtn
    INC cursor_change      ; trigger re-drawing the original spell's text after
    SEC
    RTS

   @FoundEmptySlot:       ;  All conditions are met
    JSR Set_Inv_Magic     ; reset tmp and tmp+1
    LDA tmp+8
    STA ch_spells, X      ; X is still pointing to the empty slot
    SEC
    SBC #1                ; return the spell ID to 0-based
    JSR REMOVE_ITEM       ; and remove it from inventory

    LDA #1                ; set menustall to nonzero (indicating we need to stall)
    STA menustall
    LDA #MBOX_ITEMDESC    ; draw main/item box ID $08  (the description box)
    JSR DrawMainItemBox
  ;  INC descboxopen       ; set descboxopen to a nonzero value to mark the description box as open
    LDA #77
    JSR DrawCharMenuString  ; draw "Character learned the spell!" text in the box
    JSR MenuWaitForBtn
    JSR CloseDescBox
    CLC
    RTS                  ; and exit!









;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Enter Item Menu  [$B11D :: 0x3B12D]
;;
;;    Pretty self explanitory.  Enters the item menu, returns when player
;;  exits item menu
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


EnterItemMenu:
    JSR WaitForVBlank_L
    LDA #0
    STA $2001           ; turn the PPU off
    STA menustall       ; zero menustall (don't want to stall for drawing the screen for the first time)
    STA descboxopen     ; indicate that the descbox is closed
    JSR ClearNT         ; wipe the NT clean then start drawing the item menu
	
    LDA #MBOX_INV
    JSR DrawMainItemBox    ; draw first, so that the next boxes overlap it

    LDA #MBOX_TITLE        ; draw mainitem box ID 7 (the "ITEM" title box)
    JSR DrawMainItemBox
    DEC dest_y

    LDA submenu_cursor     ; if offset is 0, draw items, if 1, draw quest items
    BNE :+
    LDA #2                 ; draw ITEMS in box
    BNE @DrawTitle
  : LDA #3                 ; draw QUEST in box
  
   @DrawTitle:
    JSR DrawMenuString     ;  and draw it and return

    LDA #MBOX_SUBMENU      ; draw submenu box
    JSR DrawMainItemBox
    DEC dest_y
    LDA #66
    JSR DrawMenuString    ; draw "__Items__Quest Items"

    LDX #0
    LDY #0
   @FillBlanks:
     LDA #0
     STA str_buf, X        ; also clear the item_box
     STA str_buf+8, X
     STA tmp+2             ; tmp+2 is loop counter for each line of spaces
    @FillInnerLoop:
        LDA #$FF
        STA bigstr_buf, Y
        INY
        INC tmp+2
        LDA tmp+2
        CMP #28            ; fill 28 spaces with FF - there's 30 tiles of space, but the first 2 are for the cursor
        BNE @FillInnerLoop

        LDA #01
        STA bigstr_buf, Y  ; every 29th space, put a double line break
        INX
        INY
        CPX #8             ; looping 8 times
        BNE @FillBlanks

    LDA #0
    STA bigstr_buf, Y     ; null terminator

    STA joy               ; clear joy data
    STA joy_prevdir       ; and previous joy directionals

    JSR FillItemBox        ; Transfer items to item_box and fill bigstr_buf with item names
    BCC @DrawItems         ; if the player has no inventory...
      JSR TurnMenuScreenOn_ClearOAM
      LDA #22
      JSR DrawItemDescBox    ; draw the "You have nothing" description text
      JMP ItemMenu_Submenu   ; jump to the submenu

   @DrawItems:
    LDA #<(bigstr_buf)    ; fill text_ptr with the pointer to our item names in the big string buffer
    STA text_ptr
    LDA #>(bigstr_buf)
    STA text_ptr+1

    LDA #03
    STA dest_x
    LDA #05
    STA dest_y

    JSR DrawComplexString  ; Draw all the item names
    JSR TurnMenuScreenOn_ClearOAM  ; clear OAM and turn the screen on

ItemMenu_Loop:
    LDA item_box
    BEQ ItemMenu_Submenu    ; if the first byte of item_box = 0, you have nothing!

    JSR ClearOAM            ; clear OAM
    JSR DrawInventoryCursor ; draw the cursor where it needs to be
    JSR MenuFrame           ; do a frame

    LDA joy_a               ; see if A has been pressed
    BNE @A_Pressed          ; if it has... jump ahead
    CMP joy_b               ; otherwise check for B
    BNE ItemMenu_Submenu    ; and exit if B pressed

    JSR MoveItemMenuCursor  ; neither button pressed... so move cursor if a direction was pressed
    JMP ItemMenu_Loop       ; then continue the loop

   @A_Pressed:
    LDA #0
    STA submenu_targ
    
    JSR PlaySFX_MenuSel        ; play the menu selection sound effect
    
    LDA cursor_x
    CLC
    ADC cursor_y
    TAX
    LDA item_box, X            ; get the selected item, and put it in A
    STA using_item             ; backup item ID
    ASL A                      ; double it (2 bytes per pointer)
    TAX                        ;   and stick it in X

    LDA ItemJumpTable, X      ; load the address to jump to from our jump table
    STA tmp                    ; and put it in (tmp)
    LDA ItemJumpTable+1, X
    STA tmp+1
    JMP (tmp)                  ; then jump to it!
    
ItemMenu_Submenu:
    JSR ClearOAM              ; clear OAM
    JSR DrawItemSubMenuCursor ; draw the cursor
    JSR MenuFrame             ; then do an Equip Menu Frame

    LDA joy_a
    BNE @A_Pressed            ; check to see if A pressed
    LDA joy_b
    BNE @B_Pressed            ; or B

    JSR MoveItemSubMenuCursor
    JMP ItemMenu_Submenu     ; and loop until one of them is pressed

   @B_Pressed:
    RTS

   @A_Pressed:
    LDA item_pageswap        ; change item_pageswap, which starts at 0 
    CMP submenu_cursor       ; compare it to the submenu cursor. If they're equal, do not re-draw
    BEQ ItemMenu_Loop
    EOR #$01
    STA item_pageswap
    JMP EnterItemMenu        ; otherwise, re-draw the screen with the other item type

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

ItemJumpTable:

.word UseItem_Bad         ; Item Start
.word UseItem_Heal        ; Heal
.word UseItem_XHeal       ; X-Heal
.word UseItem_Ether       ; Ether
.word UseItem_Elixir      ; Elixir
.word UseItem_Pure        ; Pure
.word Useitem_Soft        ; Soft
.word UseItem_PhoenixDown ; Phoenix Down
.word UseItem_Tent        ; Tent
.word UseItem_Cabin       ; Cabin
.word UseItem_House       ; House
.word UseItem_Eyedrop     ; Eyedrops
.word UseItem_Smokebomb   ; Smokebomb
.word Useitem_AlarmClock  ; Alarm clock
.word UseItem_Bad         ; unused
.word UseItem_Bad         ; unused

.word UseItem_Lute      ; 10
.word UseItem_Crown     ; 11
.word UseItem_Crystal   ; 12
.word UseItem_Herb      ; 13
.word UseItem_Key       ; 14
.word UseItem_TNT       ; 15
.word UseItem_Adamant   ; 16
.word UseItem_Slab      ; 17
.word UseItem_Ruby      ; 18
.word UseItem_Rod       ; 19
.word UseItem_Floater   ; 1A
.word UseItem_Chime     ; 1B
.word UseItem_Tail      ; 1C
.word UseItem_Cube      ; 1D
.word UseItem_Bottle    ; 1E
.word UseItem_Oxyale    ; 1F
.word UseItem_Canoe     ; 20
.word UseItem_Lewds     ; 21


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  [$B1B3 :: 0x3B1C3]
;;
;;  Following the item jump table is all the routines jumped to!  The first few are simplistic
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

    ; called for invalid item IDs (should never be called -- just sort of a safety catch)
UseItem_Bad:
  JSR PlaySFX_Error
  JMP ItemMenu_Loop   ; just jump back to the item loop


    ; called when the CROWN is selected
UseItem_Crown:
    LDA #24       ; select description text "The stolen CROWN"
                  ; seamlessly flow into UseItem_SetDesc

    ; Jumped to by items that just print a simple description
UseItem_SetDesc:
    JSR DrawItemDescBox    ; draw the description box with given description (in A)
    JMP ItemMenu_Loop      ;  then return to the item loop


;; JIGS - fixed this up some

UseItem_Crystal:  LDABRA $19, UseItem_SetDesc ; 25
UseItem_Herb:     LDABRA $1A, UseItem_SetDesc ; 26
UseItem_Key:      LDABRA $1B, UseItem_SetDesc ; 27
UseItem_TNT:      LDABRA $1C, UseItem_SetDesc ; 28
UseItem_Adamant:  LDABRA $1D, UseItem_SetDesc ; 29
UseItem_Slab:     LDABRA $1E, UseItem_SetDesc ; 30
UseItem_Ruby:     LDABRA $1F, UseItem_SetDesc ; 31

UseItem_Chime:    LDABRA $22, UseItem_SetDesc ; 34
UseItem_Tail:     LDABRA $23, UseItem_SetDesc ; 35
UseItem_Cube:     LDABRA $24, UseItem_SetDesc ; 36

UseItem_Oxyale:   LDABRA $26, UseItem_SetDesc ; 38
UseItem_Canoe:    LDABRA $27, UseItem_SetDesc ; 39
UseItem_Lewds:    LDABRA $55, UseItem_SetDesc ; 85


;;;;;;;;;;;;;;;;;;;;;
;;
;;  UseItem_Bottle  [$B1EE :: 0x3B1FE]
;;
;;;;;;;;;;;;;;;;;;;;;

UseItem_Bottle:
    LDA game_flags + OBJID_FAIRY    ; check the fairy object's state (to see if bottle has been opened already)
    LSR A                           ; move flag into C
    BCC @OpenBottle                 ; if flag is clear... fairy isn't visible, so bottle hasn't been opened yet.  Otherwise...
      LDA #37                       ; Draw "It is empty" description text
      JSR DrawItemDescBox
      JMP ItemMenu_Loop             ;  and return to the item loop

@OpenBottle:                        ; if the bottle hasn't been opened yet
    JSR Set_Inv_KeyItem
    LDA #BOTTLE
    JSR REMOVE_ITEM_1BIT

    LDY #OBJID_FAIRY
    JSR LongCall
    .word ShowMapObject
    .byte BANK_DIALOGUE

    LDA #43                         ; Draw "Pop... a fiary pops out" etc description text
    JSR DrawItemDescBox_Fanfare     ;   with fanfare!
    JSR MenuWaitForBtn
    JMP EnterItemMenu              ; Then RESUME item menu (redraw the item list -- now that the bottle isn't there)

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
    ;AND #TP_SPEC_MASK         ; mask out the 'special' bits
    ;GetSMTilePropNow already did that!
    CMP #TP_SPEC_USEKEYITEM   ; see if the special bits mark this tile as a "use key item" tile
    BNE @CantUse              ; if not... can't use the rod here

    LDA tileprop_now+1        ; get the second byte
    CMP #ROD                  ; see if its the rod
    BNE @CantUse              ; if not, can't use it here

    LDY #OBJID_RODPLATE       ; check the rod plate object, to see if
    LDA game_flags, Y         ;   the rod has been used yet
    LSR A                     ;   shift that flag into C
    BCC @CantUse              ;   if clear, plate is gone, so Rod has already been used.. can't use the Rod again

    JSR LongCall
    .word HideMapObject
    .byte BANK_TALKTOOBJ
    ;JSR HideMapObject           ; otherwise.. first time rod is being used.  Hide the rod plate
    LDA #41                      ;  load up the relevent description text
    JSR DrawItemDescBox_Fanfare ;  and draw it with fanfare!
    JMP ItemMenu_Loop           ; then return to item loop

  @CantUse:
    LDA #32                   ; if you can't use the Rod here, just load up
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
    CMP #TP_SPEC_USEKEYITEM     ;  see if this tile is marked as "use lute"
    BNE @CantUse                ; if not... can't use

    LDA tileprop_now+1        ; get the second byte
    CMP #LUTE                 ; see if its the rod
    BNE @CantUse              ; if not, can't use it here

    LDY #OBJID_LUTEPLATE        ; check the lute plate object, to see if
    LDA game_flags, Y           ;   the lute has been used yet
    LSR A                       ;   shift the flag into C
    BCC @CantUse                ;   if clear, lute plate is gone, so lute was already used.  Can't use it again

    ;ASL A                       ; completely pointless shift (undoes above LSR, but has no real effect)
    JSR LongCall
    .word HideMapObject
    .byte BANK_TALKTOOBJ
    ;JSR HideMapObject           ; hide the lute plate object
    LDA #40                     ; get relevent description text
    JSR DrawItemDescBox_Fanfare ;  and draw it ... WITH FANFARE!
    JMP ItemMenu_Loop           ; then return to item loop

  @CantUse:
    LDA #23                    ; if you can't use the lute here, just
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
    LDA #42                    ; load up the "omg you raised the airship" description text
    JSR DrawItemDescBox_Fanfare ;   and draw it with fanfare
    JMP ItemMenu_Loop           ; then return to item loop

  @CantUse:
    LDA #33
    JSR DrawItemDescBox     ; can't use... so just draw lame description text
    JMP ItemMenu_Loop       ;  and return to loop


;;;;;;;;;;;;;;;;;;;;
;;
;;  UseItem_Tent  [$B284 :: 0x3B294]
;;
;;;;;;;;;;;;;;;;;;;;

UseItem_Tent:
    LDX #TENT_HP
    LDA #53
    BNE UseItem_Rest

UseItem_Cabin:
    LDX #CABIN_HP
    LDA #53                 ; restore HP message
    BNE UseItem_Rest    

UseItem_House:
    LDX #HOUSE_HP
    LDA #56                 ; restore HP and MP message

UseItem_Rest:
    STX hp_recovery
    JSR DrawItemDescBox     ; A = message to draw
    JSR MenuWaitForBtn_SFX
    LDA joy
    AND #$80
    BEQ @Done

    LDA mapflags            ; ensure we're on the overworld
    LSR A                   ;  shift SM flag into C
    BCC @Use                ;  if set (in standard map), can't use tent here

    LDA tileprop_now
    CMP #TP_SPEC_USESAVE    ; if its a safe tile to save on...
    BNE @CantUse

   @Use:
    LDX using_item
    DEC items, X            ; remove the item from inventory
    LDA hp_recovery
    JSR MenuRecoverPartyHP  ; give HP to the whole party
    JSR PlayHealSFX
    
    LDA #54                 ; start with tent/cabin's "save and restore HP?" text
    LDX using_item
    CPX #HOUSE              ; but if its a house...
    BNE :+
    JSR MenuRecoverPartyMP  ; then restore MP as well
    LDA #55                 ; load House's "save and restore HP/MP?" text
    
  : JSR MenuSaveConfirm     ; and bring up confirm save screen (with description text $1A)
   @Done:
    JMP EnterItemMenu       ; then re-enter item menu (need to re-enter, because screen needs full redrawing)

  @CantUse:
    LDA #57                 ; "cannot sleep here!"
    JSR DrawItemDescBox
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

:   ;LDA #58                  ; draw description box with text ID $3F
    ;JSR DrawItemDescBox       ; "your gave is being saved" or whatever
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


Chemist_Check:
    TXA
    PHA

    LDA #$00
   @Loop:
    TAX
    LDA ch_ailments, X
    AND #AIL_DEAD | AIL_STOP
    BNE @Next

    LDA ch_miscperks, X
    AND #CHEMIST
    BNE @Found

   @Next:
    TXA
    CLC
    ADC #$40
    BNE @Loop

    SEC
    BCS @Nope

   @Found:
    CLC

   @Nope:
    PLA
    TAX
    RTS

 ;; can't make these labels local because UseItem_Pure hijacks one of the labels ;_;

UseItem_Heal:
    LDA #HEAL_POTENCY
    STA hp_recovery
    BNE DrawHealMenu

UseItem_XHeal:
    LDA #XHEAL_POTENCY
    STA hp_recovery

DrawHealMenu:
    LDA #0
    STA hp_recovery+1

    JSR Chemist_Check          ; carry clear if a living chemist is in the party
    BCS :+

    ASL hp_recovery
    ROL hp_recovery+1

  : JSR DrawItemTargetMenu     ; Draw the item target menu (need to know who to use this heal potion on)
    LDA #44
    JSR DrawItemDescBox        ; open up the description box with text ID $20

   @UseItem_Heal_Loop:
    JSR ItemTargetMenuLoop     ; run the item target loop.
    BCS @UseItem_Exit          ; if B was pressed (C set), exit this menu

    JSR Cursor_to_Index
	STX submenu_targ
    JSR CheckDeadStone
    BCS @CantUse

    LDA ch_curhp, X            ; make sure not to waste potions!
    CMP ch_maxhp, X            ; if not equal, then either the character has MORE current HP than max... or less.
    BNE :+                     ; going to assume LESS, so go use the potion
       LDA ch_curhp+1, X       ; otherwise, its equal, so check high bytes
       CMP ch_maxhp+1, X
       BEQ @CantUse            ; if those are also equal, there's no point in using a potion

  : LDX using_item
    LDA items, X
    BEQ @UseItem_Exit          ; don't have any!
    DEC items, X

   @DoHeal:
	LDX submenu_targ
    JSR MenuRecoverHP_Abs      ; recover 30 HP for target (index is still in X).
    JSR PlayHealSFX
    JSR SetStallAndWait
    JSR DrawItemTargetMenu_OneChar
    JMP @UseItem_Heal_Loop

  @UseItem_Exit:
    JMP EnterItemMenu          ; re-enter item menu (item menu needs to be redrawn)

  @CantUse:
    JSR PlaySFX_Error          ; play the error sound effect
    JMP @UseItem_Heal_Loop     ; and keep looping until they select a legal target or escape with B


;;;;;;;;;;;;;;;;;;;;
;;
;;  UseItem_Ether
;;
;;;;;;;;;;;;;;;;;;;;

UseItem_Ether:
    LDA #0
    STA cursor_y

UseItem_Ether_2:
    JSR DrawMPTargetMenu       ; draw target menu
    LDA #45
    JSR DrawItemDescBox        ; print relevent description text

  @Loop:
    JSR MPTargetMenuLoop       ; do the target menu loop
    BCS @Exit                  ; if they pressed B (C set), exit

    LDA item_ether
    BEQ @Exit

    JSR Cursor_to_Index        ; cursor is 0, 1, 2, 3
    JSR CheckDeadStone
    BCS @CantUse

    TXA                        ; put index back into A
    CLC
    ADC #ch_mp - ch_stats      ; add ch_mp offset
    ADC cursor_y                ; cursor_y is 0, 1, 2, 3, 4, 5, 6, 7
    TAX                        ; X is now index to character's mp stat
    LDA ch_stats, X
    AND #$0F                   ; check max MP bits
    BEQ @CantUse               ; if 0, can't use ether here - no magic!

    STA tmp                    ; store max MP
    LDA ch_stats, X
    AND #$F0                   ; get current MP
    LSR A
    LSR A
    LSR A
    LSR A
    CMP tmp                    ; if its the same...
    BEQ @CantUse               ; no need to use an ether... so don't

    LDA tmp                    ; reload max MP
    ASL A                      ; shift the bits into current MP
    ASL A
    ASL A
    ASL A
    ORA tmp                    ; combine back with max MP bits
    STA ch_stats, X            ; and save! MP for this level is now filled!

    JSR PlayHealSFX

    DEC item_ether             ; if we could... remove one from the inventory
    JSR SetStallAndWait
    JSR DrawMPTargetMenu_Elixir_OneChar
    JMP @Loop

  @Exit:
    JMP EnterItemMenu          ; before re-entering the item menu (redrawing item menu)

  @CantUse:
    JSR PlaySFX_Error          ; if can't use... give the error sound effect
    JMP @Loop                  ;  and keep looping

;;;;;;;;;;;;;;;;;;;;
;;
;;  UseItem_Elixir
;;
;;;;;;;;;;;;;;;;;;;;

UseItem_Elixir:
    JSR DrawItemTargetMenu_Elixir     ; draw target menu
    LDA #46
    JSR DrawItemDescBox        ; print relevent description text

    LDA #2
    STA item_pageswap          ; tells ItemTargetMenuLoop to use the Elixir cursor positiosn... silly.

  @Loop:
    JSR ItemTargetMenuLoop     ; do the target menu loop
    BCS @Exit                  ; if they pressed B (C set), exit

    LDA item_elixir            ; if no more elixers, exit
    BEQ @Exit

    JSR Cursor_to_Index
    JSR CheckDeadStone
    BCS @CantUse

    LDA ch_maxhp+1, X
    STA ch_curhp+1, X
    LDA ch_maxhp, X
    STA ch_curhp, X

    JSR MenuRecoverSingleMP

    JSR PlayHealSFX

    DEC item_elixir            ; if we could... remove one from the inventory
    JSR SetStallAndWait
    JSR DrawItemTargetMenu_Elixir_OneChar
    JMP @Loop

  @Exit:
    LDA #0
    STA item_pageswap
    JMP EnterItemMenu          ; before re-entering the item menu (redrawing item menu)

  @CantUse:
    JSR PlaySFX_Error          ; if can't use... give the error sound effect
    JMP @Loop                  ;  and keep looping


;;;;;;;;;;;;;;;;;;;;
;;
;;  UseItem_Pure  [$B338 :: 0x3B348]
;;
;;;;;;;;;;;;;;;;;;;;

UseItem_Pure:
    LDX #47                  ; item description
    LDA #AIL_POISON          ; ailment to cure
    BNE UseAilmentCuringItem

Useitem_Soft:
    LDX #48
    LDA #AIL_STOP
    BNE UseAilmentCuringItem

UseItem_PhoenixDown:
    LDX #49
    LDA #AIL_DEAD
    BNE UseAilmentCuringItem

UseItem_Eyedrop:
    LDX #51
    LDA #AIL_DARK

UseAilmentCuringItem:
    STA hp_recovery
    TXA
    PHA

    JSR DrawItemTargetMenu     ; draw target menu
    PLA
    JSR DrawItemDescBox

  @Loop:
    JSR ItemTargetMenuLoop     ; do the target menu loop
    BCS @Exit                  ; if they pressed B (C set), exit

    LDX using_item
    LDA items, X
    BEQ @Exit                  ; exit if you ran out

   @TryUse:
    STX tmp
    JSR CureOBAilment          ; then try to cure it
    BCS @CantUse               ; if we couldn't... can't use this item

    JSR PlayHealSFX

    LDX using_item
    DEC items, X               ; and this time decrease the amount of the item
    CPX #PHOENIXDOWN           ; then check if it was a phoenix down
    BNE @Continue              ; if not, skip this
      JSR Cursor_to_Index
      JSR Chemist_Check        ; carry clear if a living chemist is in the party
      BCS :+

      LDA ch_maxhp, X          ; if anyone in the party is a chemist, give them half their max HP
      STA tmp+8
      LDA ch_maxhp+1, X

      LSR A
      ROR tmp+8

      STA ch_curhp+1, X
      LDA tmp+8
      BNE :++

    : LDA #1                   ; if no chemists...
    : STA ch_curhp, X          ; give the character 1 HP

   @Continue:
    JSR SetStallAndWait
    JSR DrawItemTargetMenu_OneChar
    JMP @Loop

   @Exit:
    JMP EnterItemMenu          ; before re-entering the item menu (redrawing item menu)

  @CantUse:
    JSR PlaySFX_Error          ; if can't use... give the error sound effect
    JMP @Loop                  ;  and keep looping


Useitem_AlarmClock:
    LDA #50
    JSR DrawItemDescBox
    JSR MenuWaitForBtn_SFX
    JMP EnterItemMenu

UseItem_Smokebomb:
    LDA #52
    JSR DrawItemDescBox
    JSR MenuWaitForBtn_SFX

    LDA joy
    AND #$80
    BEQ :+

    LDA mapflags            ; make sure we're on the overworld
    LSR A                   ; Get SM flag, and shift it into C
    BCC @CantUse            ; if set (on overworld), can't use smokebomb here

    LDA #SMOKEBOMB_EFFECT   ; set in Constants for easier editing
    STA smokebomb_steps
    DEC item_smokebomb
    JSR PlayDoorSFX

    JSR Chemist_Check       ; carry clear if a living chemist is in the party
    BCS :+

    LDA smokebomb_steps
    LSR A
    CLC
    ADC smokebomb_steps
    STA smokebomb_steps

  : JMP EnterItemMenu

  @CantUse:
    LDA #59                 ; "cannot use that here"
    JMP :+





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
    ;LDA cursor            ; get cursor (desired character)
    ;ROR A                 ; shift to get usable character index ($00,$40,$80,$C0)
    ;ROR A
    ;ROR A
    ;AND #$C0              ; and mask relevant bits
    ;TAX                   ; then stuff in X
    JSR Cursor_to_Index

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
    LDA submenu_targ
    STA cursor           ; reset the cursor to zero
    LDA #4
    STA cursor_max

  @Loop:
    JSR ClearButtons

    JSR ClearOAM               ; clear OAM
    LDA using_item
    CMP #2
    BNE :+
    JSR DrawElixirTargetCursor
    JMP :++

  : JSR DrawItemTargetCursor   ; draw the cursor for this menu
  : JSR MenuFrame              ; do a frame

    LDA joy_a
    BNE @A_Pressed     ; check to see if they pressed A
    LDA joy_b
    BNE @B_Pressed     ; or B

    JSR MoveCursorUpDown
    LDA cursor
    STA submenu_targ
    JMP @Loop


  @A_Pressed:              ; if A was pressed
    JSR PlaySFX_MenuSel    ;  play the selection sound effect
    CLC                    ;  clear carry to indicate A pressed
    RTS                    ;  and exit

  @B_Pressed:              ; if B pressed
    JSR PlaySFX_MenuSel    ;  play selection sound effect
    SEC                    ;  and set carry before exiting
    RTS




MPTargetMenuLoop:

  @Loop:
    JSR ClearButtons

    JSR ClearOAM               ; clear OAM
    JSR DrawMPTargetCursor   ; draw the cursor for this menu
    JSR DrawMPTargetSprites

    JSR MenuFrame              ; do a frame

    LDA joy_a
    BNE @A_Pressed     ; check to see if they pressed A
    LDA joy_b
    BNE @B_Pressed     ; or B

    JSR MoveMPMenuCursor
    LDA cursor
    STA submenu_targ
    JMP @Loop

  @A_Pressed:              ; if A was pressed
    JSR PlaySFX_MenuSel    ;  play the selection sound effect
    CLC                    ;  clear carry to indicate A pressed
    RTS                    ;  and exit

  @B_Pressed:              ; if B pressed
    JSR PlaySFX_MenuSel    ;  play selection sound effect
    SEC                    ;  and set carry before exiting
    RTS


DrawMPTargetSprites:
    LDA #$4A           ; draw the character sprites
    STA spr_x
    LDA #$0D           ; not exactly on tile edge
    STA spr_y
    LDA #$00
    JSR DrawOBSprite

    LDA #$74
    STA spr_x
    LDA #$40
    JSR DrawOBSprite

    LDA #$9A
    STA spr_x
    LDA #$80
    JSR DrawOBSprite

    LDA #$C4
    STA spr_x
    LDA #$C0
    JMP DrawOBSprite








    ;; since so many things require this...
Cursor_to_Index:
    LDA cursor              ; otherwise... get cursor
    ROR A
    ROR A
    ROR A
    AND #$C0                ; shift it to get a usable index
    TAX                     ; and put in X
    RTS

    ;; JIGS - also used a ton. C set if dead or stone, clear if not, so use BCS to cancel use.
CheckDeadStone:
    LDA ch_ailments, X         ; check their OB ailments
    CMP #$01
    BEQ @No
    CMP #$02
    BEQ @No
    CLC
    RTS
   @No:
    SEC
    RTS

SetStallAndWait:
    LDA #1
    STA menustall
    JSR WaitForVBlank_L
    LDA cursor
    STA submenu_targ
    RTS



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Draw Item Target Menu  [$B400 :: 0x3B410]
;;
;;    Draws the item target menu (the menu that pops up when you select a heal potion
;;  and that kind of thing -- where you select who you want to use it on)
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



CheckForMP:
    LDA submenu_targ
    STA cursor
    JSR Cursor_to_Index

    LDA ch_mp, X   ; check all of this character's Max MP
    ORA ch_mp+1, X ;  if any level of spells is nonzero, we'll need to draw the MP
    ORA ch_mp+2, X ;  for this character.  Otherwise, we won't need to.
    ORA ch_mp+3, X ;  this is checked easily by just ORing all the max MP bytes
    ORA ch_mp+4, X
    ORA ch_mp+5, X
    ORA ch_mp+6, X
    ORA ch_mp+7, X
    RTS

DrawItemTargetMenu:
    JSR ScreenOff_ClearNT
    LDA #MBOX_HP
    JSR DrawMainItemBox
    LDA #3
    STA submenu_targ
   @Loop:
    JSR DrawItemTargetMenu_OneChar
    DEC submenu_targ
    BPL @Loop
    INC submenu_targ    
    JMP TurnMenuScreenOn_ClearOAM   ; then clear OAM and turn the screen back on.  then exit

HealStringPositionLut:
    .byte 8, 11, 14, 17

DrawItemTargetMenu_OneChar:
    LDA submenu_targ
    TAX
    LDA HealStringPositionLut, X
    STA dest_y
    LDA #08
    STA dest_x
    LDA #17
    JMP DrawCharMenuString         ; draw Name, ailment, HP for each character

DrawItemTargetMenu_Elixir:
    JSR ScreenOff_ClearNT
    LDA #MBOX_HPMP
    JSR DrawMainItemBox
    LDA #3
    STA submenu_targ
   @Loop:
    JSR DrawItemTargetMenu_Elixir_OneChar
    DEC submenu_targ
    BPL @Loop
    INC submenu_targ
    JMP TurnMenuScreenOn_ClearOAM   ; then clear OAM and turn the screen back on.  then exit

ElixirStringPositionLut:
    .byte 5, 9, 13, 17

DrawItemTargetMenu_Elixir_OneChar:
    LDA submenu_targ
    TAX
    LDA ElixirStringPositionLut, X
    STA dest_y
    LDA #08
    STA dest_x
    LDA #17
    JSR DrawCharMenuString          ; draw Name, ailment, HP for each character
    INC dest_y
    INC dest_y
    DEC dest_x
    JSR CheckForMP
    BEQ :+
    LDA #16
    JSR DrawCharMenuString          ; draw MP for each character
  : RTS                             ; or just skip it if they have none

DrawMPTargetMenu:
    JSR ScreenOff_ClearNT
    LDA #MBOX_MP
    JSR DrawMainItemBox             ; draw main box for all character's MP
    INC dest_x
    INC dest_y
    INC dest_y                      ; arrange the text over a bit, and down enough to make room for sprites
    LDA #14
    JSR DrawMenuString              ; Draw spell levels on the left
    LDA #3
    STA submenu_targ
   @Loop:
    JSR DrawMPTargetMenu_Elixir_OneChar
    DEC submenu_targ
    BPL @Loop
    JMP TurnMenuScreenOn_ClearOAM

EtherStringPositionLut:
    .byte 9, 14, 19, 24

DrawMPTargetMenu_Elixir_OneChar:
    LDA submenu_targ
    TAX
    LDA EtherStringPositionLut, X
    STA dest_x
    LDA #5
    STA dest_y
    JSR CheckForMP
    BEQ :+
    LDA #15
    JSR DrawCharMenuString          ; draw MP for each character
  : RTS


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  EnterStatusMenu    [$B4AD :: 0x3B4BD]
;;
;;    Just draws the status screen, then waits for the user to press a button
;;  before exiting
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;StatusMenuAttributes:
;.byte $AA,$55
;.byte $AA,$55
;.byte $AA,$55

EnterStatusMenu:
    JSR WaitForVBlank_L
    LDA #0
    STA DualWieldStats
    STA $2001               ; turn off the PPU
    STA menustall           ; disable menu stalling
    STA tmp+2               ; set additive for scrollwork
    JSR ClearNT             ; clear the NT

    LDA #>$23C0
    STA $2006
    LDA #<$23C0
    STA $2006

;    LDX #6
;    LDY #4
;   @AttributeLoop:
;    LDA StatusMenuAttributes-1, X
;    STA $2007
;    DEY
;    BNE @AttributeLoop
;    LDY #4
;    DEX
;    BNE @AttributeLoop

;    LDA #3
;    STA dest_y
;    LDA #20
;    STA dest_x
;    LDA #9
;    STA dest_ht               ; 8 tiles wide and 9 tall
;    LDA #8
;    STA dest_wd
;
;    LDA #<statusbox_scrollwork  ; get the pointer to the orb box scrollwork
;    STA image_ptr
;    LDA #>statusbox_scrollwork
;    STA image_ptr+1
;    JSR DrawImageRect        ; draw the image rect

@ReenterStatusMenu:
    JSR WaitForVBlank_L
    LDA #0                  ; Turn off the PPU
    STA $2001

    LDA submenu_targ        ; get target character ID
    LSR A
    ROR A
    ROR A
    STA char_index

    JSR ResetCharStats

    LDA #MBOX_STATUS_CHAR
    JSR DrawMainItemBox

    ;LDX #02
    ;STX dest_x
    ;DEX ; #01
    ;STX dest_y
    INC dest_x
    LDA #19
    JSR DrawCharMenuString

    LDA #MBOX_STATUS_OPTION
    JSR DrawMainItemBox

    LDA #MBOX_STATUS
    JSR DrawMainItemBox
    LDA #20
    INC dest_x
    JSR DrawCharMenuString

    JSR ClearOAM            ; clear OAM

    LDA #$60 ; B8
    STA spr_x
    LDA #$18 ; 30
    STA spr_y

    JSR TurnMenuScreenOn    ; turn the screen on

   @Loop:
    JSR ClearOAM
  ;  LDX char_index
  ;  LDA ch_ailments, X
  ;  AND #AIL_DEAD | AIL_STOP
  ;  BNE @NormalPose
  ;
  ;  LDA playtimer+1         ; every other second
  ;  AND #01
  ;  BEQ @NormalPose
  ;
  ;  LDA ch_ailments, X      ; set pose to cheer
  ;  ORA #$80
  ;  STA ch_ailments, X
  ;  BNE @DrawSprite
  ;
  ; @NormalPose:             ; reset pose to normal
  ;  LDA ch_ailments, X
  ;  AND #$0F
  ;  STA ch_ailments, X

   @DrawSprite:
    ;TXA
    LDA char_index
    JSR DrawOBSprite        ; then draw this character's OB sprite
    JSR MenuFrame
    JSR @MoveCursorLeftRight

    LDA joy_select
    ORA joy_start
    BEQ :+
        LDX char_index
        LDA ch_lefthand, X  ; see if they have a weapon equipped
        BEQ :+
        CMP #ARMORSTART     ; or if its armor
        BCS :+

        LDA DualWieldStats  ; only do this if they have a weapon
        EOR #1              ; else, the display will mess up probably
        STA DualWieldStats
        JMP @ReenterStatusMenu

  : LDA joy_a
    ORA joy_b
    BEQ @Loop                     ; check if A pressed

@ResetStatusMenuCharPose:
    LDX char_index
    LDA ch_ailments, X
    AND #$0F
    STA ch_ailments, X
    RTS

@MoveCursorLeftRight:
    LDA joy            ; get joy data
    AND #$0F           ; isolate directional buttons
    CMP joy_prevdir    ; see if there were changes
    BEQ @Exit          ; if not, exit

    STA joy_prevdir    ; otherwise, record changes
    CMP #0             ; see if buttons are being pressed
    BEQ @Exit          ; if not, exit

    CMP #$01           ; otherwise, check for left/right
    BNE @Left

  @Right:
    LDA submenu_targ
    CLC
    ADC #$01
    BNE :+

  @Left:
    LDA submenu_targ
    SEC
    SBC #$01
  : AND #$03
    STA submenu_targ
    PLA
    PLA
    JSR @ResetStatusMenuCharPose
    LDA #0
    STA DualWieldStats
    JMP @ReenterStatusMenu

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
    STA hp_recovery
    LDA #0
    STA hp_recovery+1

    LDX #$00
    JSR MenuRecoverHP        ; recover HP for each character
    LDX #$40
    JSR MenuRecoverHP
    LDX #$80
    JSR MenuRecoverHP
    LDX #$C0
    ;JMP MenuRecoverHP

    ;JMP DrawItemTargetMenu   ; then draw item target menu, and exit

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
    BEQ _MenuRecoverHP_BadExit     ; if dead... skip to exit (can't recover HP when dead)
   ; CPY #$02
   ; BEQ _MenuRecoverHP_Exit     ; if stone... skip to exit
  ;; JIGS - healing stone people with magic is allowed, since its allowed in battle

MenuRecoverHP_Abs:
    LDA hp_recovery             ; back up HP to recover by stuffing it in tmp
    CLC
    ADC ch_curhp, X             ; add recover HP to low byte of HP
    STA ch_curhp, X
    LDA ch_curhp+1, X           ; add 0 to high byte of HP (to catch carry from low byte)
    ADC hp_recovery+1
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
    ;JSR PlayHealSFX

    ;LDA hp_recovery               ; restore the HP recovery ammount in A, before exiting
  _MenuRecoverHP_Exit:
    CLC
    RTS

  _MenuRecoverHP_BadExit:
    SEC
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
    JSR MenuWaitForBtn
    JMP PlaySFX_MenuSel     ; play the MenuSel sound effect, and exit

MenuWaitForBtn:
    JSR MenuFrame           ; exactly the same -- only no call to PlaySFX_MenuSel at the end
    LDA joy_a
    ORA joy_b
    BEQ MenuWaitForBtn
    ;JMP ClearButtons

ClearButtons:
    LDA #0
    STA joy_a
    STA joy_b
    STA joy_select
    STA joy_start
    RTS




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
    JSR WaitForVBlank_L    ; wait for VBlank
MainMenuFrame:
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

    JSR ClearButtons
    JMP UpdateJoy          ; update joypad info, then exit


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Move Main Menu Sub Cursor  [$B68C :: 0x3B69C]
;;
;;    Moves the cursor for the main menu sub target.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;MoveMainMenuSubCursor:
;    LDA joy              ; get joy buttons
;    AND #$0F             ; isolate directional arrows
;    CMP joy_prevdir      ; compare to prev directions to see if there was a change
;    BEQ @Exit            ; no change... exit

;    STA joy_prevdir      ; otherwise record change
;    CMP #0               ; see if the change was a press or release
;    BEQ @Exit            ; if release... exit

;    LDX #$01             ; X=1 (for left/right)
;    CMP #$04             ;  see if player pressed up or down
;    BCC :+
;      LDX #$02           ; if they did... X=2 (for up/down)
;:   TXA                  ; then move X to A

                         ; A is now 1 for horizontal movement and 2 for vertical movement
;    EOR cursor           ; EOR with the cursor (wrap around appropriate axis)
;    STA cursor           ; and write back
;    JMP PlaySFX_MenuMove ; then play the move sound effect
;  @Exit:
;    RTS                  ; and exit

;; JIGS - not used, but a good example of how to move cursor around in a 2x2 box.







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
    RTS                      ;    just exit

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
   ; JSR DrawMainMenuGoldBox        ; gold box
   ; JSR DrawMainMenuOptionBox      ; and option box
   ; LDA #$14
   ; JSR DrawMainItemBox            ; timer box

    LDA #02
    STA dest_x
    LDA #11
    STA dest_y
    LDA #0
    JSR DrawMenuString	; draw gold string
    LDA #04
    STA dest_x
    LDA #14
    STA dest_y
    LDA #1
    JSR DrawMenuString   ; draw options string

DrawMainMenu_CharacterBox:
    LDA #BANK_THIS
    STA cur_bank
    STA ret_bank                   ; set for MusicPlay and ComplexString

    LDA #MBOX_CHARACTERS           ; then draw the boxes for each character
    JSR DrawMainItemBox            ;  stats...starting with the first character
	;; at this point, should be at scanline 250 or so...
	JSR CallMusicPlay

    LDA #$00
    JSR DrawMainMenuCharBoxBody

    LDA #12
    STA dest_x
    LDA #9
    STA dest_y
    LDA #$40
    JSR DrawMainMenuCharBoxBody

    LDA #12
    STA dest_x
    LDA #15
    STA dest_y
    LDA #$80
    JSR DrawMainMenuCharBoxBody

    LDA #12
    STA dest_x
    LDA #21
    STA dest_y
    LDA #$C0
    JSR DrawMainMenuCharBoxBody

    ;; JIGS - just a bit more to draw this weird line between the gold and orb boxes...

    LDA #1
    STA dest_x
    LDA #10
    STA dest_y
    LDA #65
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
    LDA #MBOX_OPTION          ; Draw main menu box ID 0  (the orb box)
    JSR DrawMainItemBox

    LDX #$20
   @Scrollwork:
    TXA
    STA orbbox_scrollwork-$20, X
    INX
    CPX #$60
    BNE @Scrollwork           ; the scrollwork is simply tiles $20-$5F in order

    LDA #$02                  ; X and Y positions are the same
    STA dest_y
    STA dest_x
    LDA #8
    STA dest_wd
    STA dest_ht               ; 8 tiles wide and tall
    LDA #0
    STA tmp+2                 ; and no additive!

    LDA #<orbbox_scrollwork  ; get the pointer to the orb box scrollwork
    STA image_ptr
    LDA #>orbbox_scrollwork
    STA image_ptr+1
    JSR DrawImageRect        ; draw the image rect


      ; Fire Orb
    LDX #$84           ; dest ppu address       = $2084
    LDY #$08           ; lit orb tiles start at = $64
    LDA orb_fire       ; fire orb status
    JSR @DrawOrb

      ; Water Orb
    LDX #$86           ; dest ppu address       = $2086
    LDY #$0C           ; lit orb tiles start at = $68
    LDA orb_water      ; water orb status
    JSR @DrawOrb

      ; Air Orb
    LDX #$C4           ; dest ppu address       = $20C4
    LDY #$10           ; lit orb tiles start at = $6C
    LDA orb_air        ; air orb status
    JSR @DrawOrb

      ; Earth Orb
    LDX #$C6           ; dest ppu address       = $20C6
    LDY #$14           ; lit orb tiles start at = $70
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

      LDY #$04    ; if orb not lit... replace tile with $76 (unlit orb graphics)
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

EraseDescBox:
    LDA #1
    STA menustall            ; set menustall -- we will need to stall here, since the PPU is on
    LDA #MBOX_ITEMDESC

EraseMainItemBox:
    JSR LoadMainItemBoxDims
    JMP EraseBox

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

;DrawCharDescBox:
;    PHA
;    LDA #1
;    STA menustall
;    LDA #09
;    JSR DrawMainItemBox
;    PLA
;    INC descboxopen
;    JMP DrawCharMenuString    ; JIGS - because it contains HP/MP or other character-related stats

DrawItemDescBox_Fanfare:
    LDX #$54              ; play music track $54 (special event fanfare)
    STX music_track

DrawItemDescBox:
    PHA                   ; push menu string ID to back it up
    LDA #1                ; set menustall to nonzero (indicating we need to stall)
    STA menustall
    STA descboxopen       ; set descboxopen to a nonzero value to mark the description box as open
    LDA #MBOX_ITEMDESC    ; draw main/item box ID $08  (the description box)
    JSR DrawMainItemBox
    PLA                   ; restore menu string ID

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
    JMP DrawMenuString_FixedBank

   ; LDA lut_MenuText, X
   ; STA text_ptr
   ; LDA lut_MenuText+1, X   ; load pointer from table, store to text_ptr  (source pointer for DrawComplexString)
   ; STA text_ptr+1
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
    ASL A                   ; double menu string ID
    TAX                     ; put in X
    JMP DrawMenuString_CharCodes_FixedBank

;    LDA lut_MenuText, X     ; and load up the pointer into (tmp)
;    STA tmp
;    LDA lut_MenuText+1, X
;    STA tmp+1
;
;    LDA #<bigstr_buf        ; set the text pointer to our bigstring buffer
;    STA text_ptr
;    LDA #>bigstr_buf
;    STA text_ptr+1
;
;  @Loop:                    ; now step through each byte of the string....
;    LDA (tmp), Y            ; get the byte
;    CMP #$10                ; compare it to $10 (charater stat control code)
;    BNE :+                  ;   if it equals...
;      ORA submenu_targ      ;   OR with desired character ID to draw desired character's stats
;:   STA bigstr_buf, Y       ; copy the byte to the big string buffer
;    DEY                     ; then decrement Y
;    CPY #$FF                ; check to see if it wrapped
;    BNE @Loop               ; and keep looping until it has
;
;                                ; once the loop is complete and our big string buffer has been filled
;    JMP DrawMenuComplexString   ; draw the complex string and exit.

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

    ;BNE @DrawMP       ; if max MP is nonzero, jump ahead to DrawMP
    ;  JMP @NoMP       ; otherwise... jump ahead to NoMP
    BEQ @NoMP

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
    STA tmp

    LDX #21
   @MainStringLoop:
    LDA CharBoxString, X
    CMP #$10                ; if its a control code...
    BNE :+
        ORA tmp             ; add in the character's ID
  : STA str_buf, X
    DEX
    BPL @MainStringLoop

    LDA dest_x
    CLC
    ADC #4
    STA dest_x

    LDA #<str_buf  ; set low byte of string pointer (start drawing the string from $0300)
    STA text_ptr

    JMP DrawComplexString    ; Draw it, then exit!

CharBoxString:
.byte $FF,$10,$60,$FF,$FF,$95,$10,$03,$01
.byte $FF,$10,$02,$FF,$91,$99,$FF,$10,$05,$7A,$10,$06,$00

;   0 1  2    3 4 5 6  7     8       9 10 11      12 13 14 15 16 17    18 19 20    21
;   _ 00 Name _ _ L 00 Level -break- _ 00 Ailment _  H  P  _  00 CurHP /  00 MaxHP -end-

; space, char stat; name, space, space, L, char stat; level, line break
; space, char stat: ailment icon, space, H, P, space, char stat: current HP, /, char stat: max HP, end








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

EquipMenu_Attributes_Pos:
.byte $C9,$D1 ; attribute position
EquipMenu_Attributes_Val:
.byte $0F,$F0 ; attribute value



EquipMenu_Submenu:
    JSR ClearOAM               ; clear OAM
    JSR DrawEquipSubMenuCursor ; draw the cursor
    JSR MenuFrame              ; then do an Equip Menu Frame

    LDA joy_a
    BNE @A_Pressed            ; check to see if A pressed
    LDA joy_b
    BNE @B_Pressed            ; or B

    JSR MoveSubMenuCursor
    JMP EquipMenu_Submenu     ; and loop until one of them is pressed

   @B_Pressed:
    RTS

   @A_Pressed:
    LDA submenu_cursor
    BEQ @Equip
    CMP #2
    BEQ @RemoveAll

   @Equip:
    JMP EquipMenu_MainLoop

   @RemoveAll:
    JSR LongCall
    .word GetNekked
    .byte BANK_Z

EnterEquipMenu:
    JSR WaitForVBlank_L
    JSR ClearButtons
    STA $2001                 ; turn off the PPU
    STA menustall             ; and turn off menu stalling (since the PPU is off)
    STA WeaponOrArmorPage     ; default to weapon page
    STA ItemOverflow

    LDX #$03
   @PalLoop:
      LDA lutEquipPalettes, X
      STA cur_pal, X
      DEX
      BPL @PalLoop

    ;; this will color right or left hand green, to indicate which weapon is being shown

    ;JSR ClearNT               ; clear the NT

    LDA #MBOX_EQUIPSTATS
    JSR DrawMainItemBox

    ;; draw description box first, because inventory overlaps it

    LDA #MBOX_INV ; #MBOX_EQUIP
    JSR DrawMainItemBox

    LDA #$05
    STA dest_y
    STA dest_x
    LDA #12
    JSR DrawMenuString        ; Equipment
    JSR DrawEquipMenuStrings  ; Draws item names, what is equipped

    LDA #MBOX_SUBMENU
    JSR DrawMainItemBox

DrawEquipSubMenuString:
    JSR DrawTitleTargetName   ; draw name in title box

    LDA #10
    STA dest_x
    LDA #02
    STA dest_y
    LDA #79
    JSR DrawMenuString        ; "Equip / Remove / Empty"

   @DualWieldStuff:
    LDX char_index         ; see if the character has a weapon
    LDA ch_lefthand, X     ; in their left hand
    BEQ @DrawStats         ; if they don't, do nothing
    CMP #ARMORSTART+1
    BCS @DrawStats         ; if its armor, do nothing

    LDA DualWieldStats
    TAX
    LDA #$23
    STA $2006
    LDA EquipMenu_Attributes_Pos, X
    STA $2006
    LDY #3
    LDA EquipMenu_Attributes_Val, X
   @AttLoop:
    STA $2007
    DEY
    BNE @AttLoop

  @DrawStats:
    JSR ResetCharStats
    LDA #$17
    STA dest_y
    LDA #$03
    STA dest_x
    LDA #13
    JSR DrawCharMenuString   ; Draw Stats

    LDX char_index
    LDA ch_attackperks, X
    AND #DUALWIELD
    BEQ :+

    LDA #>$211B
    STA $2006
    LDA #<$211B
    STA $2006
    LDX #2
   @IconLoop:
    LDA DualWieldIcons, X
    STA $2007
    DEX
    BPL @IconLoop

  : JSR TurnMenuScreenOn_ClearOAM

EquipMenu_MainLoop:
    LDA equipoffset
    STA cursor

  @Loop:
    JSR ClearOAM              ; clear OAM
    JSR DrawEquipMenuCursor   ; draw the cursor
    JSR MenuFrame             ; then do an Equip Menu Frame

    LDA joy_a
    BNE @A_Pressed            ; check to see if A pressed
    LDA joy_b
    BNE @B_Pressed            ; or B
    LDA joy_select
    ORA joy_start
    BNE @SelectPressed

    JSR MoveEquipMenuCurs     ; if neither A nor B pressed, move the mode cursor
    JMP @Loop                 ; and loop until one of them is pressed

  @A_Pressed:
    JSR Set_Inv_Weapon
    LDA cursor                ; cursor = equip slot
    STA equipoffset
    CLC
    ADC char_index            ; add character index
    TAX
    LDA ch_righthand, X       ; check equipped item
    BEQ :+                    ; if it exists...
    PHA                       ; adding an item doesn't restore the item's ID, so back it up
    SEC
    SBC #1                    ; convert item to 0-based
    JSR ADD_ITEM              ; put the unequipped weapon in inventory
    PLA
    BCC :+
    INC ItemOverflow          ; inventory limit reached (over 15 of this item)

  : STA ItemToUnequip
    LDX equipoffset
    BEQ @ViewInventory        ; its a weapon, start with weapon page
    CPX #06
    BCS @ViewInventory        ; its a battle item, start with weapon page
    CPX #01
    BNE @SetArmorBattleSlot   ; its NOT the shield slot, start with armor page
    CMP #0
    BEQ @SetArmorBattleSlot   ; it is the shield slot, but ItemToUnequip is 0: start with armor
    CMP #ARMORSTART+1
    BCS @ViewInventory        ; ItemToUnequip is armor; start with armor

    LDA #01
    STA DualWieldStats        ; else, unequipping a weapon, so start with weapon page
    BNE @ViewInventory        ; and set the trigger to view left hand weapon stats

   @SetArmorBattleSlot:
    INC WeaponOrArmorPage     ; set to 1 to view armor page

   @ViewInventory:
    LDA #0
    STA cursor
    STA cursor_max
    STA item_pageswap
    JSR EnterEquipInventory
    JMP EnterEquipMenu

  @B_Pressed:                 ; if B pressed....
    JMP EquipMenu_Submenu

  @SelectPressed:
    LDX char_index         ; if it is, see if the character has a weapon
    LDA ch_lefthand, X     ; in their left hand
    BEQ @Loop
    CMP #ARMORSTART+1
    BCS @Loop              ; if they don't, do nothing

    LDA DualWieldStats
    EOR #$01               ; if its 0, switch to 1; if its 1, switch to 0!
    STA DualWieldStats
    JMP EnterEquipMenu

DualWieldIcons:
    .byte $D4, $C7, $DB   ; sword, >, shield -- printed in reverse

EnterEquipInventory:
    JSR WaitForVBlank_L
    JSR ClearButtons
    STA $2001             ; turn off the PPU
    STA menustall         ; and turn off menu stalling (since the PPU is off)
    STA tmp+15            ; toggle for special description
    STA tmp+13            ; and make sure this is 0, to keep
    ;; the battle items description box from flickering when passing over empty slots!

    LDA #1
    STA cursor_change

    JSR ClearNT
    JSR DrawEquipInventory ; Draws everything
    JSR TurnMenuScreenOn_ClearOAM

   @Loop:
    JSR ClearOAM
    JSR DrawInventoryCursor
    LDA cursor_change
    BEQ :+
        JSR UpdateEquipInventoryStats
  : JSR MenuFrame ;EquipMenuFrame

    LDA joy_a
    BNE @A_Pressed            ; check to see if A pressed
    LDA joy_b
    BNE @B_Pressed            ; or B
    LDA joy_start
    BNE @Start_Pressed
    LDA joy_select
    BNE @Select_Pressed

    JSR MoveEquipInventoryCursor   ; if neither A nor B pressed, move the mode cursor
    JMP @Loop                      ; and loop until one of them is pressed

  @B_Pressed:                 ; if B pressed....
    JSR PlaySFX_MenuSel
    JSR Set_Inv_Weapon
    LDA equipoffset
    CLC
    ADC char_index           ; add character index
    TAX
    LDA ItemToUnequip
    STA ch_righthand, X      ; restore original item
    BEQ :+
    LDX ItemOverflow         ; if overflow is set, don't subtract the item
    BNE :+
    SEC
    SBC #1
    JSR REMOVE_ITEM          ; and if it was more than 0, take it out of inventory again
  : JMP ResetCharStats

  @Select_Pressed:
    LDA equipoffset
    CMP #1                   ; see if its the shield slot
    BNE :+

    LDX char_index           ; if it is, see if the character can dual-wield
    LDA ch_attackperks, X
    AND #DUALWIELD
    BEQ @Loop                ; if they can't, do nothing

    LDA DualWieldStats
    EOR #$01                 ; if its 0, switch to 1; if its 1, switch to 0!
    STA DualWieldStats
    BNE @SwitchScreen

  : CMP #6
    BCC @Loop

  @SwitchScreen:
    LDA WeaponOrArmorPage
    EOR #$01                ; if its 0, switch to 1; if its 1, switch to 0!
    STA WeaponOrArmorPage
    JSR PlaySFX_MenuSel
    JMP EnterEquipInventory

  @A_Pressed:
    LDA equip_impossible
    BNE @Error

    LDA ItemOverflow
    BNE :+

    ;; JIGS - JSR to something like
    ;; "You have too much of "ItemToUnequip"
    ;; "Do you want to throw it away?"

  : JSR Set_Inv_Weapon
    DEC ItemToEquip          ; if ID is 0 (nothing chosen) and goes to $FF, skip removing the item
    BMI :+
    LDA ItemToEquip          ; get the new weapon
    JSR REMOVE_ITEM          ; remove it from inventory
  : JMP PlaySFX_MenuSel

   @Error:
    JSR PlaySFX_Error        ; kr-kow if not equippable
    JMP @Loop

   @Start_Pressed:
    LDA equipoffset
    CMP #06
    BCS @Select_Pressed

    JSR PlaySFX_MenuSel
    LDA tmp+15
    EOR #$01
    STA tmp+15
    BNE :+
        INC cursor_change
        JMP @Loop

  : JSR EquipStatsDescBoxString_Special
    JMP @Loop


ResetCharStats:
    JSR LongCall
    .word SetCharStats
    .byte BANK_Z
    RTS




UpdateEquipInventoryStats:
;    JSR UnEquipStats

;; every time the cursor moves (plus at the very start) the equipped weapon changes:
;; if it can be equipped, it is, and the stats are adjusted to show that it is--
;; to show what it would be if the player chooses that one with A
;; otherwise, the slot is set with 0 and the stats are adjusted to show they have nothing
;; Pressing B will put the original item back in place
;; Pressing A will equip the item set by UpdateEquipInventoryStats_CheckViable
;; If there is 0 amount of an item, it will equip you with nothing
;; or else give an error if the item set cannot be equipped



    LDA #0
    STA equip_impossible
    STA tmp+8
    LDA equipoffset          ; save equipoffset as the armor type
    STA slotcheck            ; to make sure you don't wear a glove on your head

   @WeaponOrArmorPage:
    LDA WeaponOrArmorPage    ; 1 when looking at armor, 0 when looking at weapons
    STA shop_type            ; for equip permissions, 0: weapon, 1: armor
    BEQ :+                   ; so if its armor, put #ARMORSTART offset into tmp+8
       LDA #ARMORSTART
       STA tmp+8

  : JSR Set_Inv_Weapon
    LDA cursor
    ASL A
    ASL A
    ASL A
    CLC
    ADC cursor_max
    STA tmp+11               ; Used for slot checking for armor
    ADC tmp+8                ; add 0 or armor offset
    STA ItemToEquip          ; Currently 0-based item ID
    STA tmp+10               ; save the 0-based version for much later!
    JSR DOES_ITEM_EXIST      ; output is A = amount of item
    BCS @DoesNotExist        ; Carry set if it does not exist

    INC ItemToEquip          ; Turn the item ID 1-based, both for equipping later
    ; And because IsEquipLegal subtracts 1 from A
    ; Also do it here, so that its primed for @FinishUpdate, if its a battle item slot

    LDA equipoffset
    CMP #06                  ; see if its a battle slot item
    BCS @FinishUpdate        ; If its 6 or 7, no need to check equip permissions

   @CanEquip:
    LDA ItemToEquip          ; 1-based ID
    JSR IsEquipLegal         ; output: zero flag set = can't equip
    BEQ @NoEquip

    LDA equipoffset
    BEQ @FinishUpdate        ; skip checking armor slots if its a weapon

    LDX WeaponOrArmorPage    ; here we know: it is not a battle item slot, it is not the right hand weapon slot
    BEQ @FinishUpdate        ; so it must be the shield/dual wield slot!

   @CheckArmorSlot:
    LDX tmp+11               ; check type LUT (head, body, hands, shield)
    CMP ArmorSlot            ; against equip slot
    BEQ @FinishUpdate        ; if it equals, its in the right slot to continue

   @WrongSlot:
    LDA #$FF                 ; mark the slot as FF
    STA slotcheck            ; so that EquipStatsDescBoxNumbers will show ! tiles to indicate
    BNE @NoEquip             ; that the item IS equippable, but not on that part of the body

   @DoesNotExist:
    LDA #0                   ; only clear the ItemToEquip ID if you don't have one
    STA ItemToEquip          ; we want to keep this to be able to check the item's element stuff!
    BEQ @FinishUpdate

   @NoEquip:
    INC equip_impossible

   @FinishUpdate:
    LDA equipoffset
    CLC
    ADC char_index           ; add character index
    TAX
    LDA ItemToEquip
    STA ch_righthand, X      ; save item in the slot

    JSR ResetCharStats
    DEC cursor_change

    LDA #1
    STA menustall

    LDA equipoffset
    CMP #6
    BCC EquipStatsDescBoxNumbers   ; don't display this stuff if on battle item slot

;; Again, copy this string to str_bug (+$80 this time) and do a fancy thing to fill it with a TON of blank space.
;; this then jumps to get some weapon/armor stats to fill those spaces in with.
;; ran out of room in this bank so the whole thing is moved over here:

EquipStatsDescBoxString_Special:
    JSR LongCall
    .word WeaponArmorSpecialDesc
    .byte BANK_Z

    LDA ItemToEquip     ; still 1-based
    BEQ @Error
    JMP DrawComplexString

   @Error:
    LDA equipoffset
    CMP #06
    BCS @Instructions
    JMP PlaySFX_Error

   @Instructions:
    JMP EquipStatsDescBoxString

EquipStatsDescBoxNumbers:
;    LDA char_index
    JSR @FetchStats

    LDA #3
    STA dest_x
    LDA #23
    STA dest_y

    LDA #<(str_buf)
    STA text_ptr
    LDA #>(str_buf)           ; load pointer from table, store to text_ptr  (source pointer for DrawComplexString)
    STA text_ptr+1
    JMP DrawComplexString

   @FetchStats:
    LDX #$08
    LDY #$16         ; damage
    JSR @TheThing

    LDX #$14
    LDY #$18         ; defense
    JSR @TheThing

    LDX #$1F
    LDY #$17         ; accuracy
    JSR @TheThing

    LDX #$2B
    LDY #$19         ; evasion
    JSR @TheThing

    LDX #$35
    LDY #$1B         ; critical
    JSR @TheThing

    LDX #$41
    LDY #$1A         ; magic defense

   @TheThing:
    LDA slotcheck
    CMP #$FF
    BNE :+

   @WrongSlot:          ; can equip it, but not in this slot!
    LDA #$C4            ; shows ! tile
    BNE @xx_Stats

  : LDA equip_impossible
    BEQ :+

   @XStats:             ; cannot equip it
    LDA #$F0            ; shows fancy X
   @xx_Stats:
    STA str_buf+1, X
    STA str_buf+2, X
    LDA #$FF
    STA str_buf, X
    RTS

  : TXA
    PHA
    TYA
    JSR PrintCharStat
    PLA
    TAX
    LDY #0

   @Loop:
    LDA (text_ptr), Y
    STA str_buf, X
    INY
    INX
    CPY #3
    BNE @Loop
    RTS

EquipStatsDescBoxString:
    LDA #23
    STA dest_y

    LDA equipoffset
    CMP #6
    BCC @Stats

    ;; if in battle item slots...

    LDA tmp+13 ; check to see if the usual "press start/select to switch" text is already drawn or not
    BEQ :+
        RTS

  : LDA #03
    STA dest_x
    LDA #87
    JSR DrawMenuString
    ;; clear out this row with $FFs first.

    ;LDA #23
    ;STA dest_y
    LDA #10
    STA dest_x

    LDA WeaponOrArmorPage
    BEQ @DrawWeapon

   @DrawArmor:
    LDA #83
    BNE @DrawExplanation

   @DrawWeapon:
    LDA #82

   @DrawExplanation:
    JSR DrawMenuString
    INC dest_y
    INC dest_y
    LDA #03
    STA dest_x

    INC tmp+13

    LDA #84
    JMP DrawMenuString


   @Stats:
    LDA #<EquipStats_Blank
    STA text_ptr
    LDA #>EquipStats_Blank
    STA text_ptr+1

    LDY #0                  ; copy it to str_buf, instead of just printing it normally
    LDX #0
   @Loop:
    LDA (text_ptr), Y
    BEQ :+
    CMP #01
    BEQ :+
    CMP #$09
    BCC @FillSpaces

  : STA str_buf, X
    INX
   @Resume:
    INY
    CPY #41
    BNE @Loop

    INC dest_x
    INC dest_x

    LDA #<(str_buf)
    STA text_ptr
    LDA #>(str_buf)           ; load pointer from table, store to text_ptr  (source pointer for DrawComplexString)
    STA text_ptr+1
    JMP DrawComplexString

   @FillSpaces:               ; this little loop saves having to put like 40 blank spaces in M_EquipStats_Blank
    STY tmp                   ; Can't use the $09 code to draw spaces, as putting numbers between would ruin it!
    TAY
    LDA #$FF
  : STA str_buf, X
    INX
    DEY
    BNE :-
    LDY tmp
    JMP @Resume


EquipStats_Blank: ; numbers between 2 and 9 are amount of spaces in this string
;; don't draw it with the normal ComplexString setup... it must be loaded into RAM and edited there first!
.byte $8D,$A4,$B0,$A4,$66,$08                 ; Damage___###__ ; later on, stats are added in the # slots
.byte $8D,$A8,$A9,$3A,$3E,$05,$01             ; Defense__###
.byte $8A,$A6,$A6,$55,$5E,$BC,$06             ; Accuracy_###__
.byte $8E,$B9,$3F,$AC,$3C,$05,$01             ; Evasion__###
.byte $8C,$5C,$57,$51,$AF,$06                 ; Critical_###__
.byte $96,$C0,$9B,$2C,$30,$B7,$04,$00         ; M.Resist_###




lut_EquipInventoryPageTitle:
.byte $04, $05, $06, $4E

DrawEquipInventory:
    LDA #MBOX_EQUIPSTATS        ; Equip Stats Box
    JSR DrawMainItemBox
    LDA equipoffset
    CMP #6
    BCC :+
       DEC cursor_change        ; decrement this to NOT update the description box immediately!

  : JSR EquipStatsDescBoxString ; base string, no stats

    LDA #MBOX_INV               ; Inventory List
    JSR DrawMainItemBox

    LDA #MBOX_TITLE             ; Name
    JSR DrawMainItemBox
    DEC dest_y

    LDA #07
    JSR DrawCharMenuString

    LDA #MBOX_SUBMENU
    JSR DrawMainItemBox        ; sub menu box
    DEC dest_y
    INC dest_x

    LDX item_pageswap
    LDA lut_EquipInventoryPageTitle, X
    JSR DrawMenuString         ; draw page number and arrows

   ; LDA #0
   ; STA dest_x
   ; LDA #3
   ; STA dest_y
   ; LDA #79
   ; JSR DrawMenuString
   ;; this would draw box connectors, if the string's data was also enabled

    ; tmp+4, 5, 6, 7, 8, 9 are safe to use jigs

    LDY #0
    STY tmp+5           ; item counter
    STY tmp+6           ; left or right counter

    LDA item_pageswap   ; get the page number for the inventory screen list
    ASL A               ; there are $10 items per screen
    ASL A               ; which is 8 bytes of data to read
    ASL A               ; which is split into low/high, so back to $10
    ASL A
   ; STA tmp+4           ;

   ; LDA equipoffset     ; get the item slot to check
   ; BEQ @Loop           ; if its 0, its the weapon; jump ahead
   ; CMP #6              ; else, see if its below 6 (armor slots)
   ; BCC @ArmorOffset    ; if equipoffset is 6 or 7, its a battle item

    LDX WeaponOrArmorPage  ; See if its the weapon or armor screen
    BEQ :+                 ; if 0, its weapon, skip ahead

   @ArmorOffset:
    CLC
    ADC #ARMORSTART
  : STA tmp+4           ; tmp+4 is now the offset for where to look

   @Loop:
    JSR Set_Inv_Weapon
    TYA                 ; backup Y
    PHA
    LDA tmp+4
    JSR DOES_ITEM_EXIST ; output is item amount
    STA tmp             ; save for PrintNumber
    PLA
    TAY                 ; restore Y
    BCC @Exists

   @Skip:
    INC tmp+4
    LDA #$0B
    STA bigstr_buf, Y   ; stat code for drawing amount of tiles
    LDA #$08
    STA bigstr_buf+1, Y ; number of tiles to draw
    LDA #$C2
    STA bigstr_buf+2, Y ; tile ID to draw
    INY
    BNE @Numbers

   @Exists:
    INC tmp+4           ; check next item slot, as well as give +1 to item ID
    LDA tmp+4           ;
    STA bigstr_buf+1, Y ; ID in 2nd slot
    LDA #07
    STA bigstr_buf, Y   ; weapon/armor name code in 1st slot

   @Numbers:
    LDA #$FF
    STA bigstr_buf+2, Y ; space
    LDA #$F1
    STA bigstr_buf+3, Y ; cute li'l x

    JSR PrintNumber_2Digit
    LDA format_buf-2
    CMP #$FF
    BNE @DoubleDigits

   @SingleDigits:
    LDA format_buf-1
    STA bigstr_buf+4, Y
    LDA #$FF
    BNE :+

   @DoubleDigits:
    STA bigstr_buf+4, Y  ; tens
    LDA format_buf-1
  : STA bigstr_buf+5, Y  ; ones

    LDA #01
    STA bigstr_buf+6, Y ; double line break

    TYA
    CLC
    ADC #7
    TAY

   @ResumeLoop:
    INC tmp+5
    LDA tmp+5
    CMP #8             ; if item counter is over 8, end inner loop and reset to 0
    BNE @Loop

    LDA #0             ; put the null terminator in
    STA tmp+5          ; reset item counter
    STA bigstr_buf, Y

    LDA #<(bigstr_buf)     ; fill text_ptr with the pointer to our item names in the big string buffer
    STA text_ptr
    LDA #>(bigstr_buf)
    STA text_ptr+1

    LDA tmp+6              ; 0 on the first pass, 1 on the second pass
    BNE @DrawRightSide

   @DrawLeftSide:
    INC tmp+6              ; mark left side as drawn
    LDA #03
    STA dest_x
    LDA #05
    STA dest_y
    JSR DrawComplexString  ; Draw all the item names

    LDY #0
    JMP @Loop

   @DrawRightSide:
    LDA #18
    STA dest_x
    JMP DrawComplexString  ; Draw all the item names













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
    JSR LongCall
    .word GetEquipPermissions
    .byte BANK_EQUIPSTATS

    LDX char_index
    LDA shop_type
    BEQ @Weapon
    CMP #SHOP_WHITEMAGIC
    BCS @NormalPermissions

   @Armor:
    LDA ch_armormastery, X
    AND EquipPermissions
    BNE @CanEquip          ; if their mastery stat has 1 bit that matches the equipment's type, they can equip it

    LDA ch_armormastery+1, X
    JMP :+                 ; if not, check the next byte

   @Weapon:
    LDA ch_weaponmastery, X
    AND EquipPermissions
    BNE @CanEquip

    LDA ch_weaponmastery+1, X
  : AND EquipPermissions+1
    BEQ @NormalPermissions

   @CanEquip:
    RTS

   @NormalPermissions:
    LDA ch_class, X   ; get the character's class
    TAX               ; and put in X to index the equip bit

    ;; JIGS - instead of doubling it for another table...

    LDA #0            ; clear the temp RAM
    STA tmp
    STA tmp+1
    STA tmp+2
    STA tmp+3
    SEC               ; set C
  : ROR tmp           ; shift the carry into the low byte (setting it to $80)
    ROR tmp+1         ; then again with the high byte
    ROR tmp+2
    ROR tmp+3
    DEX               ; decrement X (class ID) -- so a Fighter's ID of 0 will now be FF
    BPL :-            ; when it wraps to FF, its done.

    ;; The White Wizard's class ID is #$14 (21), doing that many shifts...
    ;; would make the temp ram look like so:
    ;; tmp+4      tmp+5         tmp+6      tmp+7
    ;; %00000000, %00000000,   %00001000, %00000000
    ;;  01234567   89ABCDEF  +1 01234567   89ABCDEF
    ;; which is the same value that doing this v would have gotten

    LDA EquipPermissions+2         ; Check first byte of permissions
    AND tmp                        ; mask with low byte of class permissions
    STA EquipPermissions           ;  temporarily store result
    LDA EquipPermissions+3         ; then do the same with the next byte of the permissions
    AND tmp+1                      ;  mask with next byte of class permissions
    ORA EquipPermissions           ; then combine with results of the first
    LDA EquipPermissions+4
    AND tmp+2
    ORA EquipPermissions
    LDA EquipPermissions+5
    AND tmp+3
    ORA EquipPermissions
    ;CMP #$01                       ;  here... any nonzero value will indicate that the item CAN be equipped
    RTS












MoveCursor_Exit:
    PLA
    PLA
    RTS

MoveCursor_Shared:
    LDA joy                      ; get joypad state
    AND #$0F                     ; isolate directional buttons
    CMP joy_prevdir              ; compare to previous buttons to see if any have been pressed/released
    BEQ MoveCursor_Exit          ; if there's no change, just exit
    STA joy_prevdir              ;  otherwise record changes
    CMP #0                       ; see if buttons have been pressed (rather than released)
    BEQ MoveCursor_Exit          ; if no buttons pressed, just exit
    RTS


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
    JSR MoveCursor_Shared

    CMP #$04            ; see if the user pressed down or up
    BNE @Up

  @Down:                ; moving down...
    LDA cursor          ;  get cursor, and increment by 1
    CLC
    ADC #$01
    CMP cursor_max      ;  if it's < cursor_max, it's still in range, so
    BCC @Move           ;   jump ahead to move
    LDA #0              ;  otherwise, it needs to be wrapped to zero
    BEQ @Move           ;   (always branches)

  @Up:                  ; up is the same deal...
    LDA cursor          ;  get cursor, decrement by 1
    SEC
    SBC #$01
    BPL @Move           ; if the result didn't wrap (still positive), jump ahead to move
    LDA cursor_max      ;  otherwise wrap so that it equals cursor_max-1
    SEC
    SBC #$01

  @Move:
    STA cursor            ; set cursor to changed value
    JMP PlaySFX_MenuMove  ; then play that hideous sound effect and exit






MoveSubMenuCursor:
    JSR MoveCursor_Shared

    CMP #$01               ; otherwise, check for left/right
    BEQ @Right

   @Left:
    DEC submenu_cursor
    LDA submenu_cursor
    BPL @Done
    LDA #2
    BNE @Done

   @Right:
    INC submenu_cursor
    LDA submenu_cursor
    CMP #3
    BNE @Done
    LDA #0

   @Done:
    STA submenu_cursor
    JMP PlaySFX_MenuMove

MoveItemSubMenuCursor:   
    JSR MoveCursor_Shared

    INC submenu_cursor
    LDA submenu_cursor 
    AND #$01                ; only 2 options!
    STA submenu_cursor
    JMP PlaySFX_MenuMove



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Move Item Menu Cursor   [$B5AB :: 0x3B5BB]
;;
;;    Moves the cursor around in the item menu.  Checks all 4 directions
;;  and wraps where appropriate.  The description box is closed after every
;;  move (if it's opened).
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


MoveItemMenuCursor:
    JSR MoveCursor_Shared
    INC cursor_change
    
    CMP #$04               ; now see which button was pressed
    BCS @UpDown            ; check for up/down
    CMP #$01               ; otherwise, check for left/right
    BNE @Left
    
   @Right:
    INC cursor_x
    BNE :+
    
   @Left:  
    DEC cursor_x
  : LDA cursor_x
    AND #$01
    STA cursor_x
    JMP PlaySFX_MenuMove
    
   @UpDown:
    JMP MoveCursorYUpDown
    
   
    
;    
;    
;    JSR MoveCursor_Shared
;    INC cursor_change  
;    
;    CMP #$04            ; check the 'Down' bit
;    BCC @LeftOrRight    ;  if it's less than that... it's either Left or Right
;    BNE @Up             ;  if it's not equal to that... it must be Up
;
; @Down:
;    LDA cursor         ; to move down... get the cursor
;    CLC
;    ADC #$02           ; add 2 to it
;    CMP #18            ; there are 17 (counting 0 as 1!) cursor positions
;    BEQ @DownWrapLeft  ; if its 18, its 1 over
;    CMP #19
;    BCS @DownWrapRight
;    BCC @Done
;
;    ; otherwise we need to wrap to top of the column
; @DownWrapLeft:
;    LDA #3             ; by just setting the proper cursor #
;    JMP @Done          ; this wraps to the second item in the list
;
; @DownWrapRight:
;    LDA #0             ; this wraps to the "Use" option
;    JMP @Done
;
; @Up:
;    LDA cursor         ; to move up...
;    SEC
;    SBC #$02           ; subtract 2 from the cursor
;    BPL @Done          ; if we're still above zero, we're done.  Otherwise...
;
;    LDA cursor         ; re-load the cursor into A
;    CMP #01
;    BEQ @UpWrapLeft
;
; @UpWrapRight:         ; to wrap to bottom of column...
;    LDA #17
;    JMP @Done          ; then we're done
;
; @UpWrapLeft:
;    LDA #15
;    JMP @Done
;
; @LeftOrRight:
;    CMP #$01           ; check to see if they pressed Right instead of Left
;    BNE @Left          ; if they didn't... jump to Left
;                       ; otherwise... they must've pressed right
; @Right:
;    LDA cursor         ; to move right... just add 1 to the cursor
;    CLC
;    ADC #$01
;    CMP cursor_max     ; if the cursor is < max...
;    BCC @Done          ;  then we're done
;    LDA #0             ; otherwise wrap the cursor to zero
;    BEQ @Done          ;  (always branches)
;
; @Left:
;    LDA cursor         ; to move left... subtract 1 from the cursor
;    SEC
;    SBC #$01
;    BPL @Done          ; still >= 0, we're done
;    LDA cursor_max     ; otherwise, wrap to max-1
;    SEC
;    SBC #$01
;
; @Done:
;    CMP cursor_max        ; if you have nothing, cursor max is set to 2 instead of 18
;    BCC :+                ; so double-check that the cursor is within bounds (the submenu only)
;     SBC #1               ; no need to set C if it didn't branch on Carry Clear
;     BCC @Done            ; then carry is cleared by the addition...! So it always branches.
;
;  : STA cursor            ; write the new cursor value
;    JMP CloseDescBox_Sfx  ; close the description box, play the menu move sound effect, and exit
    
    
    
;; cursor for magic casting ; 3 wide, 8 tall, but needs to check if a spell exists

MoveMagicMenuCursor:
    JSR MoveCursor_Shared
    INC cursor_change

    CMP #$04               ; now see which button was pressed
    BCS @UpDown            ; check for up/down
    CMP #$01               ; otherwise, check for left/right
    BNE @Left

   @Right:
    INC cursor_x
    LDA cursor_x
    AND #$03
    STA cursor_x
    CMP #$03
    BEQ @Right
    JSR @CheckCursor
    BEQ @Right
    JMP PlaySFX_MenuMove
    
   @Left:
    DEC cursor_x
    LDA cursor_x
    AND #$03
    STA cursor_x
    CMP #$03
    BEQ @Left
    JSR @CheckCursor
    BEQ @Left
    JMP PlaySFX_MenuMove

 @UpDown:         ; if we pressed up or down... see which
    BNE @Up

 @Down:
    INC cursor_y
    LDA cursor_y
    AND #$07
    STA cursor_y
    JSR @CheckCursor
    BEQ @Down
    JMP PlaySFX_MenuMove

  @Up:
    DEC cursor_y
    LDA cursor_y
    AND #$07
    STA cursor_y
    JSR @CheckCursor
    BEQ @Up
    JMP PlaySFX_MenuMove

  ;;;;;;
  ;;  A little mini local subroutine here that checks to see if the cursor
  ;;    is on a spell or an empty slot.
  ;;
  ;;  Result is store in Z on exit.  Z set = cursor on blank slot
  ;;  Z clear = cursor is on actual spell
  ;;;;;;

  @CheckCursor:
    LDA cursor_y
    ASL A
    CLC
    ADC cursor_y
    ADC cursor_x
    ADC char_index
    TAX
    LDA ch_spells, X
    RTS              ; then exit.


;; cursor for Ethers - 4 wide, 8 tall

MoveMPMenuCursor:
    JSR MoveCursor_Shared

    CMP #$04               ; now see which button was pressed
    BCS MoveCursorYUpDown  ; check for up/down
    CMP #$01               ; otherwise, check for left/right
    BNE @Left

   @Right:
    INC cursor_x
    BNE :+

   @Left:
    DEC cursor_x
  : LDA cursor_x
    AND #$03
    STA cursor_x
    JMP PlaySFX_MenuMove

MoveCursorYUpDown:          ; moves cursor_y along 8 positions
    BNE @Up

   @Down:
    INC cursor_y
    BNE :+

   @Up:
    DEC cursor_y
  : LDA cursor_y
    AND #$07
    STA cursor_y
    JMP PlaySFX_MenuMove


;; cursor movement for equip menu ; left/right changes characters, up/down changes equipment slot (8 entries)

MoveEquipMenuCurs:
    JSR MoveCursor_Shared

    CMP #$04           ; see if they're pressing up/down or left/right
    BCS @UpDown
    CMP #$01           ; otherwise, check for left/right
    BNE @Left

  @Right:
    LDA char_index
    CLC
    ADC #$40
    STA char_index
    INC char_id
    BNE :+

  @Left:
    LDA char_index
    SEC
    SBC #$40
    STA char_index
    DEC char_id
  : LDA char_id
    AND #$03
    STA char_id
    STA submenu_targ
    LDA cursor
    STA equipoffset
    JSR PlaySFX_MenuMove
    PLA
    PLA
    JMP EnterEquipMenu

  @Exit:
    RTS

  @UpDown:
    JSR MoveCursorYUpDown
    LDA cursor_y
    STA cursor
    RTS



  ;; JIGS - this cursor movement routine also switches screens when needed
  ;; because the magic learning menu and inventory bags both use the same system
  ;; they just load different jump points and a different LUT (one is 4 pages, one is 8 pages)

MoveEquipInventoryCursor:
    LDA #<EquipInventory_CursorSwap_LUT
    STA tmp+$0E
    LDA #>EquipInventory_CursorSwap_LUT
    STA tmp+$0F

    LDA #<EnterEquipInventory
    STA tmp+$0C
    LDA #>EnterEquipInventory
    STA tmp+$0D
    JMP CursorMove_SwapPages

MoveMagicLearnMenuCursor:
    LDA #<MagicLearnMenu_CursorSwap_LUT
    STA tmp+$0E
    LDA #>MagicLearnMenu_CursorSwap_LUT
    STA tmp+$0F

    LDA #<MagicMenu_LearnSpell
    STA tmp+$0C
    LDA #>MagicMenu_LearnSpell
    STA tmp+$0D

CursorMove_SwapPages:
    JSR MoveCursor_Shared

    INC cursor_change

    CMP #$04               ; now see which button was pressed
    BCS @UpDown            ; check for up/down
    CMP #$01               ; otherwise, check for left/right
    BNE @Left

   @Right:
    INC cursor_x
    LDY cursor_x
    LDA (tmp+$0E), Y       ; get the control code for this cursor position
    BEQ @SwapPageRight     ; if it was 0, change the screen to the next page

    CMP #$FF               ; if it was $FF, its the end of the line
    BNE @Done

    DEC cursor_x           ; so decrement the increment to keep it in place

   @Done:
    JMP PlaySFX_MenuMove

   @Left:
    DEC cursor_x
    LDY cursor_x
    LDA (tmp+$0E), Y
    CMP #1                 ; moving left, if the control code was 1
    BEQ @SwapPageLeft      ; then move back to the previous page

    CPY #$FF               ; or see if the cursor's value itself wrapped to $FF
    BNE @Done              ; if it did not, its finished

    INC cursor_x           ; if it did, increment it back to 0
    JMP @Done

   @SwapPageLeft:
    DEC item_pageswap
    JMP :+

   @SwapPageRight:
    INC item_pageswap

  : JSR PlaySFX_MenuMove
    PLA
    PLA
    JMP (tmp+$0C)

   @UpDown:         ; if we pressed up or down... see which
    JMP MoveCursorYUpDown



EquipInventory_CursorSwap_LUT:
    ; traveling right, swap when it hits 0, stop at $FF
    ; traveling left,  swap when it hits 1
    ;    ; page 1  ; page 2  ; page 3  ; page 4  ;
    .byte $02, $01, $00, $01, $00, $01, $00, $01, $FF

MagicLearnMenu_CursorSwap_LUT:
    ; traveling right, swap when it hits 0, stop at $FF
    ; traveling left,  swap when it hits 1
    ;    ; page 1  ; page 2  ; page 3  ; page 4  ;
    ;    ; page 5  ; page 6  ; page 7  ; page 8  ;
    .byte $02, $01, $00, $01, $00, $01, $00, $01
    .byte $00, $01, $00, $01, $00, $01, $00, $01, $FF















;; Main menu cursor

DrawMainMenuCursor:
    LDY #$10                      ; X coord for main menu cursor is always $10
    LDA cursor                    ; get current cursor selection
    ASL A
    ASL A
    ASL A
    ASL A
    ADC #$70
    BNE DrawMenuCurs

;; JIGS - for reference

;lut_MainMenuCursor_Y:           ; Y coord only... X coord is hardcoded
;   .byte $70
;   .byte $80
;   .byte $90
;   .byte $A0
;   .byte $B0
;   .byte $C0

DrawMainMenuSubCursor:
    LDY #$58
    LDX cursor                    ; get cursor
    LDA lut_MainMenuSubCursor, X  ; load up the coords from our LUT
    BNE DrawMenuCurs

lut_MainMenuSubCursor:
   .byte $18
   .byte $48
   .byte $78
   .byte $A8

;; Equipment Menu and Inventory cursor

DrawEquipMenuCursor:
    LDY #$18                           ; all slots are on same X coordinate
    LDX cursor                         ; get primary cursor
    LDA lut_InventoryCursor_Y, X       ; then fetch
    BNE DrawMenuCurs

DrawEquipSubMenuCursor:
    LDX submenu_cursor                 ; get primary cursor
    LDY lut_EquipSubmenuCursor_X, X    ; then fetch
    LDA #$10                           ; all slots are on same X coordinate    
    BNE DrawMenuCurs

lut_EquipSubmenuCursor_X:
    .byte $48, $80, $C0

DrawMagicLearnMenuCursor:
    LDA cursor_x
    AND #$01
    LSR A
    ROR A
    JMP :+ 
    ;; JMP because it can be 00 o $80

DrawItemSubMenuCursor:
    LDX submenu_cursor
    LDY @lut, X
    LDA #$10
    BNE DrawMenuCurs
    
  @lut:
    .byte $50, $88

DrawInventoryCursor:
    LDA cursor_x
    AND #$01
    TAX
    LDA lut_InventoryCursor_X, X
  : TAY
    LDX cursor_y
    LDA lut_InventoryCursor_Y, X
    
DrawMenuCurs:    
    STA spr_y
    STY spr_x
    JMP DrawCursor               ; draw it, and exit

lut_InventoryCursor_X:
    .byte $08
    .byte $80

lut_InventoryCursor_Y:
    .byte $28
    .byte $38
    .byte $48
    .byte $58
    .byte $68
    .byte $78
    .byte $88
    .byte $98

DrawMagicMenuCursor:
  ;  LDA cursor                   ; get current cursor and double it (loading X,Y pair)
  ;  ASL A
  ;  TAX                          ; put it in X
  ;  LDA lut_MagicMenuCursor, X   ; load X,Y pair into spr_x and spr_y
  ;  STA spr_x
  ;  LDA lut_MagicMenuCursor+1, X
  ;  BNE DrawMenuCurs_Y
  ;; this is 14 bytes? 
  
    LDX cursor_x
    LDY lut_MagicMenuCursor, X
    LDX cursor_y
    LDA lut_InventoryCursor_Y, X
    BNE DrawMenuCurs

lut_MagicMenuCursor: ; x coordinates only
    .byte $18, $60, $A8

;lut_MagicMenuCursor: ; is 48 bytes 
;    .byte $18,$28,  $60,$28,  $A8,$28
;    .byte $18,$38,  $60,$38,  $A8,$38
;    .byte $18,$48,  $60,$48,  $A8,$48
;    .byte $18,$58,  $60,$58,  $A8,$58
;    .byte $18,$68,  $60,$68,  $A8,$68
;    .byte $18,$78,  $60,$78,  $A8,$78
;    .byte $18,$88,  $60,$88,  $A8,$88
;    .byte $18,$98,  $60,$98,  $A8,$98

DrawMagicSubMenuCursor:
    LDX submenu_cursor              
    LDY lut_MagicSubMenuCursor, X   
    LDA #$10
    BNE DrawMenuCurs

lut_MagicSubMenuCursor:
   .byte $50, $80, $B8

;; For the subscreens when using an item on the 4 characters

DrawItemTargetCursor:
    LDY #$30
    LDX cursor          
    LDA @lut, X          
    BNE DrawMenuCurs

  @lut:
    .BYTE $40,$58,$70,$88

DrawElixirTargetCursor:
    LDY #$2C
    LDX cursor          
    LDA @lut, X          
    BNE DrawMenuCurs

  @lut:
    .BYTE $26,$46,$66,$86

DrawMPTargetCursor:
    LDX cursor_x
    LDY @X_lut, X
    LDX cursor_y                
    LDA lut_InventoryCursor_Y, X 
    BNE DrawMenuCurs

  @X_lut:
    .BYTE $38,$60,$88,$B0


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



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Shopkeeper image LUT  [$AC9C :: 0x3ACAC]
;;
;;    this is the 10x10 image that is drawn for the shopkeeper graphics
;;  in all shops.

lut_ShopkeepImage:
 .BYTE $74,$75,$71,$71
 .BYTE $76,$77,$71,$71
 .BYTE $70,$70,$71,$71
 .BYTE $78,$79,$71,$71
 .BYTE $7A,$7B,$71,$71
 .BYTE $7C,$7D,$71,$71
 .BYTE $70,$70,$71,$71
 .BYTE $74,$75,$71,$71
 .BYTE $76,$77,$72,$73



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
.BYTE  $0F,$30,$01,$22,  $0F,$00,$0F,$30,  $0F,$35,$01,$15

lutSpellMenuPalettes:
.BYTE  $0F,$04,$01,$0F,  $0F,$2A,$01,$1A,  $0F,$24,$01,$13

lutEquipPalettes:
.BYTE  $0F,$00,$01,$2A



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Boxes for Main/Item menus  [$BAA2 :: 0x3BAB2]
;;
;;     in groups of 4:  X, Y, width, height
;;
;;  Item menu boxes are also used for the magic menu.

lut_MainItemBoxes:

    ;        X   Y   wid height
    .BYTE   $01,$01,$0A,$1C ; Main menu orb/option box
    .BYTE   $0B,$01,$14,$1C ; Main Menu char stats
    .BYTE   $00,$01,$10,$0D ; Status Menu Character Info
    .BYTE   $10,$02,$10,$0B ; Status Menu Options
    .BYTE   $00,$0E,$20,$0F ; Status Menu Big Box
    .BYTE   $00,$01,$09,$03 ; Item title box (character name for magic/equip screens)
	.BYTE   $09,$01,$17,$03 ; Title submenu
    .BYTE   $00,$03,$20,$13 ; Inventory box
	.BYTE   $00,$16,$20,$07 ; Item description box
    .BYTE   $05,$06,$16,$0E ; Item Target Menu (HP)
    .BYTE   $03,$01,$1A,$15 ; Item Target Menu (MP)
    .BYTE   $04,$03,$18,$13 ; Item Target Menu (HP/MP)
    .BYTE   $00,$15,$20,$08 ; Equip Stats
    .BYTE   $00,$03,$10,$13 ; Magic Learning menu left side
    .BYTE   $10,$03,$10,$13 ; Magic Learning menu right side

    ;; Shop boxes
    .BYTE   $01,$12,$13,$09 ; Shopkeeper dialogue
    .BYTE   $01,$02,$13,$03 ; Title box
    .BYTE   $15,$02,$0A,$16 ; Inventory list
    .BYTE   $02,$06,$09,$0B ; Command box
    .BYTE   $15,$18,$0A,$03 ; Gold box









.byte "END OF BANK E"