.include "variables.inc"
.include "macros.inc"
.include "Constants.inc"
.feature force_range

.export ClearNT
.export EnterMainMenu
.export EnterShop
.export IntroTitlePrepare

.export PrintBattleTurn
.export PrintCharStat
.export PrintGold
.export PrintNumber_2Digit
.export PrintPrice
.export TurnMenuScreenOn_ClearOAM
.export DrawManaString_ForBattle
.export BattleBGColorDigits
.export TalkToTile_BankE
.export ConvertBattleNumber

.import AddGPToParty
.import CallMusicPlay
.import ClearMenuOtherNametables
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
.import FadeInBatSprPalettes
.import FadeOutBatSprPalettes
.import GameStart_L
.import HushTriangle
.import LoadBattleSpritePalettes
.import LoadBridgeSceneGFX_Menu
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
.import PlayDoorSFX
.import BattleRNG_L

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
.word ShopTemple           ;04   
.word ShopInn              ;05   
.word ShopItem             ;06   
.word ShopOasis            ;07   
.word ShopGold             ;08   
.word ShopXGoldOK          ;09
.word ShopHowMany          ;0A
.word ShopBuyExit          ;0B   
.word ShopBuySellExit      ;0C   
.word ShopYesNo            ;0D
.word ShopCharNames        ;0E

.word ShopWelcome          ;0F item and equipment welcome    
.word ShopMagicWelcome     ;10 magic welcome

.word ShopCantAfford       ;11 you don't have enough money 
.word ShopNothingToSell    ;12 you have no inventory to sell
.word ShopCannotCarry      ;13 your inventory is too full (items, equip)
.word ShopOutofStock       ;14 your inventory is too full (magic)
.word ShopCantSell         ;15 you have too much money 
.word ShopThankYouWhatElse ;16 confirmed transaction    
.word ShopTooBadWhatElse   ;17 canceled transaction

.word ShopWhatWant         ;18 what do you want? (item, equip)
.word ShopWhatScroll       ;19 what do you want? (magic)
.word ShopWhatToSell       ;1A what do you have to sell? (item, equip)
.word ShopMagicToSell      ;1B what do you have to sell? (magic)

.word ShopEquipNow         ;1C do you want to equip it
.word ShopWhoWillTake      ;1D who is it for
.word ShopCannotEquip      ;1E can't equip it
.word ShopItemStowed       ;1F inventory full of character's other item, new item put in inventory

.word ShopInnWelcome       ;20 inn welcome
.word ShopDontForget       ;21 inn exit/before saving
.word ShopInnSaved         ;22 inn after saving

.word ShopClinicWelcome    ;23 clinic welcome/no one's dead
.word ShopWhoToRevive      ;24 clinic welcome/someone's dead
.word ShopReturnToLife     ;25 character revived

.word ShopHowMany_Sell     ;26 


;; note these are NOT the original game's strings. I have edited them to better fit within the new shop screen and add some character to the shops.

ShopWeapon:
.byte $09,$03,$A0,$2B,$B3,$3C,$FF,$9C,$AB,$B2,$B3,$00 ; ___Weapon Shop
ShopArmor:
.byte $09,$03,$8A,$B5,$B0,$35,$FF,$9C,$AB,$B2,$B3,$00 ; ___Armor Shop
ShopWhiteMagic:
.byte $09,$03,$A0,$3D,$53,$FF,$96,$A4,$AA,$AC,$A6,$00 ; ___White Magic
ShopBlackMagic:
.byte $09,$03,$8B,$AF,$5E,$AE,$FF,$96,$A4,$AA,$AC,$A6,$00 ; ___Black Magic
ShopTemple:
.byte $FF,$9D,$A8,$B0,$B3,$45,$36,$54,$95,$AC,$AA,$AB,$B7,$00 ; _Temple of Light
ShopInn:
.byte $FF,$9D,$B5,$A4,$32,$45,$B5,$BE,$1E,$92,$B1,$B1,$00 ; _Traveler's Inn
ShopItem:
.byte $FF,$FF,$90,$3A,$25,$5F,$FF,$9C,$28,$23,$00 ; __General Store
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
.byte $10,$00,$05
.byte $11,$00,$05
.byte $12,$00,$05
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

ShopWhatWant:
.byte $FF,$A0,$41,$B7,$BE,$4E,$2D,$21,$62,$C5,$00 ; What'll it be?
ShopWhatScroll:
.byte $FF,$A0,$3D,$A6,$AB,$24,$A6,$4D,$4E,$67,$B2,$01
.byte $09,$03,$56,$64,$23,$B4,$B8,$AC,$23,$C5,$00 ; Which scroll do you require?
ShopWhatToSell:
.byte $FF,$A0,$A8,$4E,$BF,$33,$41,$21,$A7,$BE,$BC,$A4,$01
.byte $09,$03,$AA,$B2,$21,$A9,$35,$42,$A8,$C5,$00 ; Well, what d'ya got for me?
ShopMagicToSell:
.byte $FF,$FF,$92,$33,$61,$58,$B6,$55,$A8,$AF,$BC,$01
.byte $FF,$38,$2F,$1A,$A9,$35,$50,$26,$B5,$01
.byte $FF,$24,$A6,$4D,$4E,$1E,$60,$4E,$C0,$00 ; I will surely care for your scrolls well.

ShopEquipNow:
.byte $FF,$8D,$B2,$FF,$BC,$B2,$B8,$FF,$BA,$A4,$B1,$B7,$FF,$B7,$B2,$01
.byte $FF,$FF,$A8,$B4,$B8,$AC,$B3,$FF,$AC,$B7,$FF,$B1,$B2,$BA,$C5,$00 ; Do you want to equip it now?
ShopWhoWillTake:
.byte $FF,$A0,$AB,$2E,$30,$2D,$21,$A9,$35,$C5,$00 ; Who is it for?
ShopCannotEquip:
.byte $FF,$FF,$91,$B2,$AF,$A7,$FF,$B2,$B1,$FF,$B1,$B2,$BA,$C3,$C0,$01
.byte $FF,$A2,$B2,$B8,$BE,$B5,$A8,$FF,$B1,$B2,$B7,$FF,$A4,$A5,$AF,$A8,$01
.byte $FF,$FF,$B7,$B2,$FF,$A8,$B4,$B8,$AC,$B3,$FF,$B7,$AB,$A4,$B7,$C4,$00 ; Hold on now... You're not able to equip that!
ShopItemStowed:
.byte $FF,$91,$A4,$B9,$1F,$47,$B7,$4D,$B8,$A5,$45,$C5,$01
.byte $92,$BE,$4E,$FF,$AD,$B8,$37,$4F,$B8,$21,$5B,$01
.byte $FF,$2D,$29,$56,$55,$31,$A4,$AA,$B6,$C0,$00 ; Having trouble? I'll just put it in your bags.

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
.byte $C8,$91,$99,$7A,$96,$99,$FF,$9B,$2C,$28,$23,$A7,$C4,$C9,$00 ; Don't you feel so much better now? [HP/MP Restored!]

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
.word ConeriaArmor      ; 0B 
.word ProvokaArmor      ; 0C 
.word ElflandArmor      ; 0D 
.word MelmondArmor      ; 0E 
.word LakeArmor         ; 0F 
.word GaiaArmor         ; 10
.word UnusedShop        ; 11
.word UnusedShop        ; 12
.word UnusedShop        ; 13
.word UnusedShop        ; 14
.word ConeriaWMagic     ; 15
.word ProvokaWMagic     ; 16
.word ElflandWMagic     ; 17
.word MelmondWMagic     ; 18
.word LakeWMagic        ; 19
.word ElflandWMagic2    ; 1A
.word GaiaWMagic        ; 1B
.word GaiaWMagic2       ; 1C
.word OnracWMagic       ; 1D
.word LeifenWMagic      ; 1E
.word ConeriaBMagic     ; 1F
.word ProvokaBMagic     ; 20
.word ElflandBMagic     ; 21
.word MelmondBMagic     ; 22
.word LakeBMagic        ; 23
.word ElflandBMagic2    ; 24
.word GaiaBMagic        ; 25
.word GaiaBMagic2       ; 26
.word OnracBMagic       ; 27
.word LeifenBMagic      ; 28
.word ConeriaTemple     ; 29
.word ElflandTemple     ; 2A
.word LakeTemple        ; 2B
.word GaiaTemple        ; 2C
.word OnracTemple       ; 2D
.word ProvokaTemple     ; 2E
.word UnusedShop        ; 2F
.word UnusedShop        ; 30
.word UnusedShop        ; 31
.word UnusedShop        ; 32
.word ConeriaInn        ; 33
.word ProvokaInn        ; 34
.word ElflandInn        ; 35
.word MelmondInn        ; 36
.word LakeInn           ; 37
.word GaiaInn           ; 38
.word OnracInn          ; 39
.word UnusedShop        ; 3A
.word UnusedShop        ; 3B
.word UnusedShop        ; 3C
.word ConeriaItem       ; 3D
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
ConeriaTemple:
;.byte $28,$00,$00                             ;(Coneria) 40g Clinic
ConeriaInn:                               
;.byte $1E,$00,$00                             ;(Coneria) 30g Inn
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
ProvokaTemple:                              
;.byte $50,$00                                 ;(Provoka) 80g Clinic
ProvokaInn:                                   
;.byte $32,$00                                 ;(Provoka) 50g Inn
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
ElflandTemple:                                
;.byte $C8,$00                                 ;(Elfland) 200g Clinic
ElflandInn:                                   
;.byte $64,$00                                 ;(Elfland) 100g Inn
ElflandItem:                                  
.byte HEAL, PURE, TENT, CABIN, FLOWCLOCK       ;(Elfland) Heal, Pure, Tent, Cabin, Soft
MelmondWeapon:                                
.byte WEP11+1, WEP12+1, WEP13+1, WEP15+1, $00 ;(Melmond) Iron Staff, Sabre, Long Sword, Falchion
MelmondArmor:                                
.byte ARM5+1, ARM12+1, ARM28+1, ARM34+1, ARM35+1;(Melmond) Steel Armor, Silver Bracelet, Iron Helmet, Copper Gauntlet, Iron Gauntlet
MelmondWMagic:                                
.byte MG_CUR3, MG_LIFE, MG_HRM3, MG_RGN2, $00 ;(Melmond) CUR3, LIFE, HRM3, HEL2
MelmondBMagic:                                
.byte MG_FIR3, MG_BANE, MG_WARP, MG_SLO2, $00 ;(Melmond) FIR3, BANE, WARP, SLO2
MelmondInn:                                   
;.byte $64,$00                                 ;(Melmond) 100g Inn
LakeWeapon:                                   
.byte WEP16+1, WEP17+1, WEP18+1, WEP19+1, $00 ;(Cresent Lake) Silver Knife, Silver Sword, Silver Hammer, Silver Axe
LakeArmor:                                   
.byte ARM6+1, ARM19+1, ARM24+1, ARM29+1, ARM36+1 ;(Cresent Lake) Silver Armor, Silver Shield, Buckler, Silver Helmet, Silver Gauntlet
LakeWMagic:                                   
.byte MG_FLOW, MG_EXIT, MG_FOG2, MG_INV2, $00 ;(Cresent Lake) SOFT, EXIT, FOG2, INV2
LakeBMagic:                                   
.byte MG_LIT3, MG_RUB, MG_QAKE, MG_STUN, $00  ;(Cresent Lake) LIT3, RUB, QAKE, STUN
LakeTemple:                                   
;.byte $90,$01,$00                             ;(Cresent Lake) 400g Clinic
LakeInn:                                      
;.byte $C8,$00                                 ;(Cresent Lake) 200g Inn
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
GaiaTemple:                                   
;.byte $EE,$02,$00                             ;(Gaia) 750g Clinic
GaiaInn:                                      
;.byte $F4,$01,$00                             ;(Gaia) 500g Inn
GaiaItem:                                     
.byte CABIN, HOUSE, HEAL, PURE, PHOENIXDOWN   ;(Gaia) Cabin, House, Heal, Pure
OnracWMagic:                                  
.byte MG_ARUB, MG_RGN3, $00                   ;(Onrac) ARUB, HEL3
OnracBMagic:                                  
.byte MG_SABR, MG_BLND, $00                   ;(Onrac) SABR, BLND
OnracTemple:                                  
;.byte $EE,$02,$00                             ;(Onrac) 750g Clinic
OnracInn:                                     
;.byte $2C,$01,$00                             ;(Onrac) 300g Inn
OnracItem:                                    
.byte TENT, CABIN, HOUSE, PURE, FLOWCLOCK      ;(Onrac) Tent, Cabin, House, Pure, Soft
CaravanShop:                                  
.byte X_HEAL, ETHER, ELIXIR, SMOKEBOMB, BOTTLE;(Caravan) Bottle
LeifenWMagic:                                 
.byte MG_LIF2, $00                            ;(Leifen) LIF2
LeifenBMagic:                                 
.byte MG_NUKE ,$00                            ;(Leifen) NUKE
UnusedShop:                                   
.byte $FF,$00                                 

;; Coneraia      - 40
;; Pravoka       - 80
;; Elfland       - 200
;; Crescent Lake - 400 
;; Onrac / Gaiat - 750 g

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  LUT for menu text  [$8500 :: 0x38510]
;;
;;    This is a table of complex strings used in menus.

;; A few things were edited to fit the new menu layouts.

lut_MenuText:                 
.word M_Gold                  ; 0  ; 0 
.word M_Options               ; 1  ; 1 
.word M_ItemTitle             ; 2  ; 2 
.word M_QuestItemsTitle       ; 3  ; 3 
.word M_EquipPage1            ; 4  ; 4 
.word M_EquipPage2            ; 5  ; 5 
.word M_EquipPage3            ; 6  ; 6 
.word M_Char1Name             ; 7  ; 7 
.word M_Char2Name             ; 8  ; 8 
.word M_Char3Name             ; 9  ; 9 
.word M_Char4Name             ; A  ; 10
.word M_EquipNameClass        ; B  ; 11
.word M_EquipmentSlots        ; C  ; 12
.word M_EquipStats            ; D  ; 13
.word M_MP_List_Level         ; E  ; 14
.word M_MP_List_MP            ; F  ; 15
.word M_Elixir_List_MP        ; 10 ; 16
.word M_HP_List               ; 11 ; 17
.word M_MagicList             ; 12 ; 18
.word M_CharLevelStats        ; 13 ; 19
.word M_CharMainStats         ; 14 ; 20
.word M_CharSubStats          ; 15 ; 21
.word M_ItemNothing           ; 16 ; 22
.word M_KeyItem1_Desc         ; 17 ; 23 ; Lute
.word M_KeyItem2_Desc         ; 18 ; 24 ; Crown
.word M_KeyItem3_Desc         ; 19 ; 25 ; Crystal
.word M_KeyItem4_Desc         ; 1A ; 26 ; Herb
.word M_KeyItem5_Desc         ; 1B ; 27 ; Mystic Key
.word M_KeyItem6_Desc         ; 1C ; 28 ; TNT
.word M_KeyItem7_Desc         ; 1D ; 29 ; Adamant
.word M_KeyItem8_Desc         ; 1E ; 30 ; Slab
.word M_KeyItem9_Desc         ; 1F ; 31 ; Ruby
.word M_KeyItem10_Desc        ; 20 ; 32 ; Rod
.word M_KeyItem11_Desc        ; 21 ; 33 ; Floater
.word M_KeyItem12_Desc        ; 22 ; 34 ; Chime
.word M_KeyItem13_Desc        ; 23 ; 35 ; Tail
.word M_KeyItem14_Desc        ; 24 ; 36 ; Cube
.word M_KeyItem15_Desc        ; 25 ; 37 ; Bottle
.word M_KeyItem16_Desc        ; 26 ; 38 ; Oxyale
.word M_KeyItem17_Desc        ; 27 ; 39 ; Canoe
.word M_KeyItem1_Use          ; 28 ; 40 ; Lute use
.word M_KeyItem10_Use         ; 29 ; 41 ; Rod use
.word M_KeyItem11_Use         ; 2A ; 42 ; Floater use
.word M_KeyItem15_Use         ; 2B ; 43 ; Bottle use
.word M_ItemHeal              ; 2C ; 44 ; CURE magic
.word M_ItemEther             ; 2D ; 45
.word M_ItemElixir            ; 2E ; 46 
.word M_ItemPure              ; 2F ; 47 ; PURE magic
.word M_ItemFlowClock         ; 30 ; 48 ; SOFT magic
.word M_ItemPhoenixDown       ; 31 ; 49 ; LIFE magic
.word M_ItemAlarmClock        ; 32 ; 50
.word M_ItemEyedrop           ; 33 ; 51
.word M_ItemSmokebomb         ; 34 ; 52
.word M_ItemUseTentCabin      ; 35 ; 53 ; HEAL magic
.word M_ItemUseTentCabin_Save ; 36 ; 54
.word M_ItemUseHouse_Save     ; 37 ; 55
.word M_ItemUseHouse          ; 38 ; 56
.word M_ItemCannotSleep       ; 39 ; 57
.word M_NowSaving             ; 3A ; 58
.word M_ItemCannotUse         ; 3B ; 59
.word M_HealMagic             ; 3C ; 60 ; unused
.word M_WarpMagic             ; 3D ; 61
.word M_ExitMagic             ; 3E ; 62
.word M_NoMana                ; 3F ; 63
.word M_CannotUseMagic        ; 40 ; 64
.word M_OrbGoldBoxLink        ; 41 ; 65
.word M_ItemSubmenu           ; 42 ; 66
.word M_MagicSubmenu          ; 43 ; 67
.word M_MagicCantLearn        ; 44 ; 68
.word M_MagicAlreadyKnow      ; 45 ; 69
.word M_MagicLevelFull        ; 46 ; 70
.word M_MagicForget           ; 47 ; 71
.word M_MagicMenuSpellLevel12 ; 48 ; 72
.word M_MagicMenuSpellLevel34 ; 49 ; 73
.word M_MagicMenuSpellLevel56 ; 4A ; 74
.word M_MagicMenuSpellLevel78 ; 4B ; 75
.word M_MagicMenuOrbs         ; 4C ; 76
.word M_MagicNameLearned      ; 4D ; 77
.word M_EquipPage4            ; 4E ; 78 ; don't feel like re-formatting all the codes again... New stuff is unorganized here.
.word Battle_Ether_MPList     ; 4F ; 79 ; for battle... easier to do it here than copy buncha code over
.word M_MagicMenuMPTitle      ; 50 ; 80 ; MP in magic menu title
.word M_EquipStats_Blank      ; 51 ; 81 ; 
.word M_EquipInventoryWeapon  ; 52 ; 82 ; 
.word M_EquipInventoryArmor   ; 53 ; 83 ; 
.word M_EquipInventorySelect  ; 54 ; 84 ; 
.word M_KeyItem18_Desc        ; 55 ; 85 ; 
.word M_LampMagic             ; 56 ; 86 ; LAMP magic

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
.BYTE $FF,$92,$9D,$8E,$96,$9C,$00 ; ITEMS

M_QuestItemsTitle: 
.BYTE $FF,$9A,$9E,$8E,$9C,$9D,$00 ; QUEST

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
.byte $10,$00,$09,$08,$10,$01,$00 ; name and class

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
.byte $8D,$A4,$B0,$A4,$66,$09,$03,$10,$3C,$FF,$FF      ; Damage
.byte $8D,$A8,$A9,$3A,$3E,$FF,$FF,$10,$3E,$01          ; Defense
.byte $8A,$A6,$A6,$55,$5E,$4B,$10,$3D,$FF,$FF          ; Accuracy
.byte $8E,$B9,$3F,$AC,$3C,$FF,$FF,$10,$3F,$00          ; Evasion

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
.byte $10,$2C,$7A,$10,$34,$01 ; lists current MP / max MP veritcally
.byte $10,$2D,$7A,$10,$35,$01
.byte $10,$2E,$7A,$10,$36,$01
.byte $10,$2F,$7A,$10,$37,$01
.byte $10,$30,$7A,$10,$38,$01
.byte $10,$31,$7A,$10,$39,$01
.byte $10,$32,$7A,$10,$3A,$01
.byte $10,$33,$7A,$10,$3B,$00

M_Elixir_List_MP: ; lists current MP / current MP / etc, horizontally
.byte $96,$99,$FF,$FF,$10,$2C,$7A,$10,$2D,$7A,$10,$2E,$7A,$10,$2F,$7A,$10,$30,$7A,$10,$32,$7A,$10,$33,$00

M_HP_List: 
.byte $10,$00,$FF,$10,$02,$FF,$10,$05,$7A,$10,$06,$00 ; lists name, ailment, and current HP horizontally

M_MagicList: 

.byte $95,$81,$FF,$FF,$10,$14,$FF,$FF,$10,$15,$FF,$FF,$10,$16,$01
.byte $95,$82,$FF,$FF,$10,$17,$FF,$FF,$10,$18,$FF,$FF,$10,$19,$01
.byte $95,$83,$FF,$FF,$10,$1A,$FF,$FF,$10,$1B,$FF,$FF,$10,$1C,$01
.byte $95,$84,$FF,$FF,$10,$1D,$FF,$FF,$10,$1E,$FF,$FF,$10,$1F,$01
.byte $95,$85,$FF,$FF,$10,$20,$FF,$FF,$10,$21,$FF,$FF,$10,$22,$01
.byte $95,$86,$FF,$FF,$10,$23,$FF,$FF,$10,$24,$FF,$FF,$10,$25,$01
.byte $95,$87,$FF,$FF,$10,$26,$FF,$FF,$10,$27,$FF,$FF,$10,$28,$01
.byte $95,$88,$FF,$FF,$10,$29,$FF,$FF,$10,$2A,$FF,$FF,$10,$2B,$00

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
.byte $97,$A8,$BB,$B7,$09,$03,$10,$42,$00             ; Next  ##

M_CharMainStats: 
.byte $9C,$B7,$23,$2A,$1C,$FF,$FF,$10,$07,$01         ; Strength 
.byte $8A,$AA,$61,$5B,$4B,$FF,$FF,$10,$08,$01         ; Agility  
.byte $92,$B1,$53,$4E,$A8,$A6,$21,$10,$09,$01         ; Intellect
.byte $9F,$5B,$5F,$5B,$4B,$FF,$10,$0A,$01             ; Vitality 
.byte $9C,$B3,$A8,$40,$09,$05,$10,$0B,$00             ; Speed    

M_CharSubStats: 
.byte $8D,$A4,$B0,$A4,$66,$09,$03,$10,$3C,$01         ; Damage
.byte $8A,$A6,$A6,$55,$5E,$4B,$10,$3D,$01             ; Accuracy
.byte $8D,$A8,$A9,$3A,$3E,$FF,$FF,$10,$3E,$01         ; Defense
.byte $8E,$B9,$3F,$AC,$3C,$FF,$FF,$10,$3F,$01         ; Evasion
.byte $96,$A4,$AA,$C0,$8D,$A8,$A9,$C0,$FF,$10,$41,$00 ; Mag. Def.

M_ItemNothing:
.byte $A2,$B2,$64,$41,$B9,$1A,$B1,$B2,$1C,$1F,$AA,$C0,$00 ; You have nothing.

M_KeyItem1_Desc: 
.byte $8B,$A8,$A4,$B8,$57,$A9,$B8,$AF,$42,$B8,$B6,$AC,$A6,$43,$AC,$4E,$B6,$05
.byte $B7,$AB,$1A,$A4,$AC,$B5,$C0,$00 ; Beautiful music fills[enter]the air.

M_KeyItem2_Desc: 
.byte $9D,$AB,$1A,$B6,$28,$45,$29,$8C,$9B,$98,$A0,$97,$C0,$00 ; The stolen CROWN.

M_KeyItem3_Desc:
.byte $8A,$FF,$A5,$A4,$4E,$42,$A4,$A7,$1A,$4C,$FF,$8C,$9B,$A2,$9C,$9D,$8A,$95,$C0,$00 ; A ball made of CRYSTAL.

M_KeyItem4_Desc: 
.byte $A2,$B8,$A6,$AE,$C4,$FF,$9D,$3D,$1E,$34,$A7,$AC,$A6,$1F,$A8,$05
.byte $AC,$B6,$1B,$B2,$2E,$A5,$5B,$B7,$25,$C4,$00 ; Yuck! This medicine[enter]is too bitter!

M_KeyItem5_Desc:
.byte $9D,$AB,$1A,$B0,$BC,$37,$AC,$A6,$FF,$94,$8E,$A2,$C0,$00 ; The mystic KEY.

M_KeyItem6_Desc: 
.byte $8B,$A8,$38,$A4,$23,$A9,$B8,$AF,$C4,$00 ; Be careful!

M_KeyItem7_Desc:  
.byte $9D,$AB,$1A,$45,$AA,$3A,$A7,$2F,$4B,$34,$B7,$5F,$C0,$00 ; The legendary metal.

M_KeyItem8_Desc:  
.byte $9E,$B1,$AE,$B1,$46,$B1,$24,$BC,$B0,$A5,$B2,$AF,$1E,$A6,$B2,$B9,$25,$05
.byte $B7,$AB,$1A,$9C,$95,$8A,$8B,$C0,$00 ; Unknown symbols cover[enter]the SLAB.

M_KeyItem9_Desc:  
.byte $8A,$FF,$AF,$2F,$AA,$1A,$23,$A7,$24,$28,$5A,$C0,$00 ; A large red stone.

M_KeyItem10_Desc:  
.byte $9D,$AB,$1A,$9B,$98,$8D,$1B,$2E,$23,$B0,$B2,$B9,$1A,$1C,$A8,$05
.byte $B3,$AF,$39,$1A,$A9,$B5,$49,$1B,$AB,$1A,$2B,$B5,$1C,$C0,$00 ; The ROD to remove the[enter]plate from the earth.

M_KeyItem11_Desc: 
.byte $8A,$FF,$B0,$BC,$37,$25,$AC,$26,$1E,$4D,$A6,$AE,$C0,$00 ; A mysterious rock.

M_KeyItem12_Desc: 
.byte $9C,$B7,$A4,$B0,$B3,$A8,$27,$3C,$1B,$AB,$1A,$A5,$B2,$B7,$28,$B0,$69,$05
.byte $96,$8A,$8D,$8E,$FF,$92,$97,$FF,$95,$8E,$8F,$8E,$92,$97,$00 ; Stamped on the bottom..[enter]MADE IN LEFEIN. 

M_KeyItem13_Desc: 
.byte $98,$98,$91,$91,$C4,$C4,$FF,$92,$21,$37,$1F,$AE,$B6,$C4,$05
.byte $9D,$AB,$B5,$46,$2D,$21,$B2,$B9,$25,$69,$05
.byte $97,$B2,$C4,$FF,$8D,$3C,$BE,$21,$A7,$B2,$1B,$AB,$39,$C4,$C4,$00 ; OOHH!! It stinks![enter]Throw it over..[enter]No! Don't do that!!

M_KeyItem14_Desc:
.byte $8C,$B2,$AF,$35,$1E,$AA,$A4,$1C,$25,$20,$3B,$05
.byte $B6,$BA,$AC,$B5,$58,$1F,$1B,$AB,$1A,$8C,$9E,$8B,$8E,$C0,$00 ; Colors gather and[enter]swirl in the CUBE.

M_KeyItem15_Desc: 
;.byte $92,$B7,$2D,$1E,$A8,$B0,$B3,$B7,$BC,$C0,$00 ; It is empty.

M_KeyItem16_Desc:
.byte $9D,$AB,$1A,$98,$A1,$A2,$8A,$95,$8E,$43,$55,$B1,$30,$1D,$B6,$05
.byte $A9,$B5,$2C,$AB,$20,$AC,$B5,$C0,$00 ; The OXYALE furnishes[enter]fresh air. 

M_KeyItem17_Desc: 
.byte $A2,$B2,$B8,$38,$22,$FF,$A6,$4D,$B6,$B6,$1B,$AB,$1A,$5C,$B9,$25,$C0,$00 ; You can cross the river.

M_KeyItem18_Desc:
.byte $C6,$9D,$1D,$23,$BE,$1E,$B1,$2E,$B3,$AC,$A6,$B7,$55,$2C,$C5,$C4,$BE,$05
.byte $C6,$9E,$3E,$50,$26,$44,$AC,$B0,$A4,$AA,$1F,$39,$AC,$3C,$C4,$BE,$05
.byte $C6,$8A,$BA,$BF,$1B,$41,$B7,$BE,$1E,$A5,$35,$1F,$AA,$C4,$BE,$00

M_KeyItem1_Use:
.byte $9D,$AB,$1A,$B7,$B8,$B1,$1A,$B3,$AF,$A4,$BC,$B6,$BF,$05
.byte $B5,$A8,$B9,$2B,$AF,$1F,$AA,$20,$24,$B7,$A4,$AC,$B5,$5D,$BC,$C0,$00 ; The tune plays,[enter]revealing a stairway.

M_KeyItem10_Use: 
.byte $9D,$AB,$1A,$B3,$AF,$39,$1A,$B6,$AB,$39,$B7,$25,$B6,$BF,$05
.byte $B5,$A8,$B9,$2B,$AF,$1F,$AA,$20,$24,$B7,$A4,$AC,$B5,$5D,$BC,$C4,$00 ; The plate shatters,[enter]revealing a stairway!

M_KeyItem11_Use: 
.byte $9D,$AB,$1A,$8A,$92,$9B,$9C,$91,$92,$99,$31,$A8,$AA,$1F,$B6,$1B,$B2,$05
.byte $B5,$AC,$B6,$1A,$A9,$B5,$49,$1B,$AB,$1A,$A7,$2C,$25,$B7,$C0,$00 ; The AIRSHIP begins to[enter]rise from the desert.

M_KeyItem15_Use: 
.byte $99,$B2,$B3,$C4,$FF,$8A,$43,$A4,$AC,$B5,$BC,$20,$B3,$B3,$2B,$63,$BF,$05
.byte $B7,$AB,$A8,$29,$AC,$1E,$AA,$3C,$A8,$C0,$00 ; Pop! A fairy appears,[enter]then is gone.

M_ItemHeal:  
M_CureMagic:
.byte $9E,$3E,$1B,$2E,$23,$A6,$B2,$32,$44,$91,$99,$C0,$00 ; Use to recover HP.[END]

M_ItemEther:
.byte $9E,$3E,$1B,$2E,$23,$A6,$B2,$32,$44,$96,$99,$05
.byte $A9,$35,$36,$5A,$24,$B3,$A8,$4E,$65,$A8,$32,$AF,$C0,$00 ; Use to recover MP[ENTER]for one spell level.[END]

M_ItemElixir:
.byte $9E,$3E,$1B,$2E,$23,$A6,$B2,$32,$44,$5F,$58,$91,$99,$20,$3B,$FF,$96,$99,$C0,$00 ; Use to recover all HP and MP.[END]

M_ItemPure:  
M_PureMagic:
.byte $9E,$3E,$1B,$2E,$A6,$55,$1A,$B3,$B2,$30,$3C,$C0,$00 ; Use to cure poison.[END]

M_ItemFlowClock:  
M_FlowMagic:
.byte $9E,$3E,$1B,$2E,$23,$37,$35,$1A,$1C,$1A,$A9,$AF,$46,$05,$36,$54,$57,$34,$C0,$00 ; Use to restore the[ENTER]flow of time.[END]

M_ItemPhoenixDown:
M_LifeMagic:
.byte $9E,$3E,$1B,$2E,$23,$B9,$AC,$32,$1B,$1D,$24,$B3,$AC,$5C,$B7,$C0,$00 ; Use to revive the spirit.[END]

M_ItemAlarmClock:
.byte $9E,$3E,$1B,$2E,$4D,$B8,$3E,$1B,$1D,$4F,$2F,$B7,$BC,$05
.byte $A9,$4D,$B0,$24,$45,$A8,$B3,$2D,$29,$A5,$39,$B7,$45,$C0,$00 ; Use to rouse the party[ENTER]from sleep in battle.[END]

M_ItemEyedrop:
.byte $9E,$3E,$1B,$2E,$23,$AA,$A4,$1F,$FF,$B6,$AC,$AA,$AB,$B7,$C0,$00 ; Use to regain sight.[END]

M_ItemSmokebomb:
.byte $9E,$3E,$1B,$2E,$3D,$A7,$1A,$A8,$32,$B5,$56,$5A,$2D,$29,$A5,$39,$B7,$45,$05
.byte $B2,$44,$A8,$AF,$B8,$A7,$1A,$3A,$A8,$B0,$AC,$2C,$2D,$29,$A7,$B8,$2A,$A8,$3C,$B6,$C0,$05 ; Use to hide everyone in battle,[ENTER]Or elude enemies in dungeons.[END]
.byte $9E,$3E,$FF,$AC,$B7,$C5,$FF,$99,$B8,$B6,$AB,$FF,$8A,$69,$A2,$8E,$9C,$FF,$99,$B8,$B6,$AB,$FF,$8B,$69,$97,$98,$00 ; Use it? Push A..YES Push B..NO

M_ItemUseTentCabin:
.byte $9B,$A8,$A6,$B2,$32,$44,$91,$99,$43,$35,$20,$4E,$C5,$05
.byte $99,$B8,$B6,$AB,$FF,$8A,$69,$A2,$8E,$9C,$05
.byte $99,$B8,$B6,$AB,$FF,$8B,$69,$97,$98,$00; Recover HP for all?[ENTER]Push A..YES[ENTER]Push B..NO[END]

M_ItemUseTentCabin_Save:
.byte $91,$99,$FF,$23,$A6,$B2,$32,$23,$A7,$C0,$FF,$9C,$A4,$32,$C5,$05
.byte $99,$B8,$B6,$AB,$FF,$8A,$69,$A2,$8E,$9C,$05
.byte $99,$B8,$B6,$AB,$FF,$8B,$69,$97,$98,$00 ; HP recovered. SAVE?[enter]Push A..YES[enter]Push B..NO

M_ItemUseHouse_Save:
.byte $91,$99,$20,$3B,$FF,$96,$99,$FF,$23,$A6,$B2,$32,$23,$A7,$C0,$FF,$9C,$A4,$32,$C5,$05
.byte $99,$B8,$B6,$AB,$FF,$8A,$69,$A2,$8E,$9C,$05
.byte $99,$B8,$B6,$AB,$FF,$8B,$69,$97,$98,$00 ; HP and MP recovered. Save?[ENTER]Push A..YES[ENTER]Push B..NO[END]

M_ItemUseHouse:  
.byte $9B,$A8,$A6,$B2,$32,$44,$91,$99,$20,$3B,$FF,$96,$99,$43,$35,$20,$4E,$C5,$05
.byte $99,$B8,$B6,$AB,$FF,$8A,$69,$A2,$8E,$9C,$05
.byte $99,$B8,$B6,$AB,$FF,$8B,$69,$97,$98,$00 ; Recover HP and MP for all?[ENTER]Push A..YES[ENTER]Push B..NO[END]

M_ItemCannotSleep:  
.byte $A2,$B2,$B8,$38,$22,$B1,$B2,$21,$B6,$45,$A8,$B3,$FF,$1D,$23,$C4,$00 ; You cannot sleep here!

M_NowSaving:   
.byte $97,$B2,$BA,$24,$A4,$B9,$1F,$AA,$69,$C4,$00 ; Now saving...! 

M_ItemCannotUse: 
.byte $A2,$B2,$B8,$38,$22,$B1,$B2,$21,$B8,$B6,$1A,$AC,$21,$1D,$23,$C4,$00 ; You cannot use it here!

M_HealMagic:   ; unused

M_WarpMagic:  
.byte $8A,$FF,$B0,$A4,$AA,$AC,$A6,$1B,$2E,$23,$B7,$55,$29,$3C,$A8,$05
.byte $A9,$AF,$B2,$35,$C0,$FF,$97,$46,$33,$2F,$B3,$31,$5E,$AE,$C4,$00 ; A magic to return one[enter]floor. Now warp back!

M_ExitMagic:  
.byte $95,$B2,$37,$C5,$FF,$97,$2E,$5D,$4B,$26,$B7,$C5,$05
.byte $92,$B6,$2D,$21,$AB,$B2,$B3,$A8,$AF,$2C,$B6,$C5,$FF,$9E,$B6,$1A,$1C,$30,$05
.byte $B6,$B3,$A8,$4E,$1B,$2E,$A8,$BB,$5B,$C4,$00 ; Lost? No way out?[return]Is it hopeless? Use this[return]spell to exit!

M_NoMana:  
.byte $8A,$AF,$AF,$36,$A9,$1B,$41,$21,$45,$32,$AF,$BE,$B6,$05
.byte $B6,$B3,$A8,$4E,$1E,$2F,$1A,$A8,$BB,$41,$B8,$37,$40,$C0,$00 ; All of that level's[enter]spells are exhausted.

M_CannotUseMagic:  
.byte $9C,$B2,$B5,$B5,$BC,$BF,$50,$26,$38,$22,$B1,$B2,$21,$B8,$3E,$05
.byte $B7,$AB,$A4,$21,$B6,$B3,$A8,$4E,$FF,$1D,$23,$C0,$00 ; Sorry, you cannot use[enter]that spell here.

M_OrbGoldBoxLink: ; JIGS - to smooth out the weird orb box shape and timer box...
.byte $74,$7C,$7C,$7C,$7C,$7C,$7C,$7C,$7C,$75,$01
.byte $7B,$F6,$F6,$F6,$F6,$F6,$F6,$F6,$F6,$7D,$01,$01,$01,$01,$01,$01,$01
.byte $74,$7C,$7C,$7C,$7C,$7C,$7C,$7C,$7C,$75,$00

M_ItemSubmenu:
.byte $FF,$FF,$9E,$3E,$09,$03,$9A,$B8,$2C,$B7,$FF,$92,$B7,$A8,$B0,$B6,$00 ; __ Use ___ Quest Items

M_MagicSubmenu: 
.byte $FF,$FF,$8C,$3F,$21,$FF,$95,$2B,$B5,$29,$FF,$8F,$35,$66,$B7,$00 ; Cast __ Learn __ Forget

M_MagicCantLearn:      
.byte $A2,$26,$38,$22,$B1,$B2,$21,$45,$2F,$29,$1C,$39,$24,$B3,$A8,$4E,$C0,$00 ; You cannot learn that spell.[END]

M_MagicAlreadyKnow:     
.byte $A2,$26,$20,$AF,$23,$A4,$A7,$4B,$AE,$B1,$46,$1B,$41,$21,$B6,$B3,$A8,$4E,$C0,$00 ; You already know that spell.[END]

M_MagicLevelFull:       
.byte $A2,$26,$38,$22,$B1,$B2,$21,$45,$2F,$29,$22,$4B,$B0,$35,$A8,$05
.byte $B6,$B3,$A8,$4E,$1E,$A9,$35,$1B,$3D,$1E,$B6,$B3,$A8,$4E,$65,$A8,$32,$AF,$C4,$00 ; You cannot learn any more[ENTER]spells for this spell level![END]

M_MagicForget:
.byte $8F,$35,$66,$21,$1C,$30,$24,$B3,$A8,$4E,$C5,$00

M_MagicMenuSpellLevel12:
.byte $FF,$FF,$9C,$B3,$A8,$4E,$FF,$95,$A8,$32,$58,$81,$C2,$82,$FF,$C7,$00

M_MagicMenuSpellLevel34:
.byte $C1,$FF,$9C,$B3,$A8,$4E,$FF,$95,$A8,$32,$58,$83,$C2,$84,$FF,$C7,$00

M_MagicMenuSpellLevel56:
.byte $C1,$FF,$9C,$B3,$A8,$4E,$FF,$95,$A8,$32,$58,$85,$C2,$86,$FF,$C7,$00

M_MagicMenuSpellLevel78:
.byte $C1,$FF,$9C,$B3,$A8,$4E,$FF,$95,$A8,$32,$58,$87,$C2,$88,$00

M_MagicMenuOrbs:
.byte $E5,$01,$E5,$01,$E5,$01,$E5,$01,$E6,$01,$E6,$01,$E6,$01,$E6,$00

M_MagicNameLearned:
.byte $FF,$10,$00,$65,$2B,$B5,$5A,$27,$1C,$1A,$B6,$B3,$A8,$4E,$C4,$00 ; [name] learned the spell!

Battle_Ether_MPList:
.byte $95,$81,$FF,$FF,$10,$2C,$7A,$10,$34,$FF,$95,$85,$FF,$FF,$10,$30,$7A,$10,$38,$01
.byte $95,$82,$FF,$FF,$10,$2D,$7A,$10,$35,$FF,$95,$86,$FF,$FF,$10,$31,$7A,$10,$39,$01
.byte $95,$83,$FF,$FF,$10,$2E,$7A,$10,$36,$FF,$95,$87,$FF,$FF,$10,$32,$7A,$10,$3A,$01
.byte $95,$84,$FF,$FF,$10,$2F,$7A,$10,$37,$FF,$95,$88,$FF,$FF,$10,$33,$7A,$10,$3B,$00

M_MagicMenuMPTitle:
;      0    1   2   3   4   5   6   7   8   9   A   B   C   D   E   F  10  11  12  13
.byte $95,$A8,$B9,$A8,$AF,$FF,$FF,$FF,$96,$99,$FF,$C3,$C3,$FF,$FF,$7A,$FF,$FF,$FF,$00 ; Level___MP_...._*/*__

M_EquipStats_Blank:
.byte $8D,$A4,$B0,$A4,$66,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF  ;13; Damage
.byte $8D,$A8,$A9,$3A,$3E,$FF,$FF,$FF,$FF,$FF,$01          ;11; Defense
.byte $8A,$A6,$A6,$55,$5E,$4B,$FF,$FF,$FF,$FF,$FF          ;11; Accuracy
.byte $8E,$B9,$3F,$AC,$3C,$FF,$FF,$FF,$FF,$FF,$00          ;11; Evasion

;.byte $FF,$95,$81,$C2,$10,$2C,$7A,$10,$34
;.byte $FF,$95,$82,$C2,$10,$2D,$7A,$10,$35
;.byte $FF,$95,$83,$C2,$10,$2E,$7A,$10,$36
;.byte $FF,$95,$84,$C2,$10,$2F,$7A,$10,$37,$01
;.byte $FF,$95,$85,$C2,$10,$30,$7A,$10,$38
;.byte $FF,$95,$86,$C2,$10,$31,$7A,$10,$39
;.byte $FF,$95,$87,$C2,$10,$32,$7A,$10,$3A
;.byte $FF,$95,$88,$C2,$10,$33,$7A,$10,$3B,$00

M_EquipInventoryWeapon:
.byte $C1,$FF,$A0,$2B,$B3,$3C,$B6,$FF,$C7,$00 ; Weapons

M_EquipInventoryArmor: 
.byte $C1,$FF,$FF,$8A,$B5,$B0,$35,$FF,$FF,$C7,$00 ; Armor

M_EquipInventorySelect:
.byte $9E,$3E,$FF,$9C,$A8,$45,$A6,$21,$35,$FF,$9C,$B7,$2F,$21,$28,$24,$BA,$5B,$A6,$AB,$01
.byte $FF,$31,$A8,$B7,$60,$3A,$33,$2B,$B3,$3C,$1E,$22,$27,$2F,$B0,$35,$C0,$00 ; Use Select or Start to switch between weapons and armor.

M_LampMagic:
.byte $8A,$24,$B3,$A8,$4E,$1B,$2E,$23,$37,$35,$1A,$B6,$AC,$AA,$AB,$B7,$C4,$00

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
    
    CMP #$2C ; JIGS - check if its equal to or above $2C, for current MP
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
      JSR LongCall
      .word PrintEXPToNext_B
      .byte BANK_BTLDATA
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
   JMP CurePartyAilment

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
   
    LDA ch_name, X          ; copy the character name to the format_buf
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
    
    LDA #<(format_buf-7)   ; set text_ptr to point to it
    STA text_ptr
    LDA #>(format_buf-7)
    STA text_ptr+1

    LDA #BANK_THIS         ; set banks required for DrawComplexString
    STA cur_bank
    STA ret_bank

    JMP DrawComplexString  ; Draw it!  Then return






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
    
    JMP LoadBridgeSceneGFX_Menu ;




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Shop entry jump table [$A320 :: 0x3A330]
;;
;;    The jump table indicating entry points for various shop
;;  types.

;lut_ShopEntryJump:
;  .WORD EnterShop_Equip      ; 0 weapon
;  .WORD EnterShop_Equip      ; 1 armor
;  .WORD EnterShop_Magic      ; 2 white magic
;  .WORD EnterShop_Magic      ; 3 black magic
;  .WORD EnterShop_Clinic     ; 4 clinic
;  .WORD EnterShop_Inn        ; 5 inn
;  .WORD EnterShop_Item       ; 6 item
;  .WORD EnterShop_Caravan    ; 7 caravan

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
    STA item_pageswap      ; is used to display prices (0 = items, magic; 1 = weapons, armor)
    
    LDX #$B0
   @ClearLoop:
    STA item_box-1, X
    DEX
    BNE @ClearLoop    
    
   @ClearShopVars:
    STA item_box_offset, X    
    INX
    CPX #$23
    BNE @ClearShopVars

    JSR LoadShopCHRPal     ; load up the CHR and palettes (and the shop type)
    JSR DrawShop           ; draw the shop

    LDA shop_type              ; use the shop type to get the entry point for this shop
    CMP #4
    BEQ @EnterClinic
    CMP #5
    BEQ @EnterInn
    
   @EnterShop:
    LDA #$4F
    STA music_track        ; set the music track to $4F (shop music)
    STA dlgmusic_backup
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
.byte $0F ; weapons
.byte $0F ; armor
.byte $10 ; white magic
.byte $10 ; black magic
.byte $23 ; clinic (not used; clinics do their own logic)
.byte $20 ; inn    (not used; inns do their own logic)
.byte $0F ; item shop
.byte $0F ; caravan

lut_ShopWhatWant: 
.byte $18 ; weapons
.byte $18 ; armor
.byte $19 ; white magic
.byte $19 ; black magic
.byte $00 ; clinic (not used; clinics do their own logic)
.byte $00 ; inn    (not used; inns do their own logic)
.byte $18 ; item shop
.byte $18 ; caravan

lut_ShopWhatSell: 
.byte $1A ; weapons
.byte $1A ; armor
.byte $1B ; white magic
.byte $1B ; black magic
.byte $00 ; clinic (not used; clinics do their own logic)
.byte $00 ; inn    (not used; inns do their own logic)
.byte $1A ; item shop
.byte $00 ; caravan (not used; caravan won't buy your things)

lut_ShopMaxAmount:
.byte $10 ; weapons
.byte $10 ; armor
.byte $04 ; white magic
.byte $04 ; black magic
.byte $00 ; clinic (not used; clinics do their own logic)
.byte $00 ; inn    (not used; inns do their own logic)
.byte $63 ; item shop
.byte $63 ; caravan    
    

    
    
CheckMagicInventory:
  LDA item_box, X
  SEC
  SBC #ITEM_MAGICSTART   ; convert item ID to spell ID
  STA shop_spell 
  TAX
  LSR A
  LSR A
  LSR A
  CLC
  ADC #$81
  STA str_buf+$49, Y     ; put this spell's level in the string buffer
  
  LDA inv_magic, X       ; get amount in inventory
  STA shop_amount
  LDA shop_selling       ; if selling, don't list what is equipped
  BNE @End
  
  INC shop_spell         ; increase to 1-based
  
  LDA #0
  PHA                    ; push 0 to use as character ID
 @Loop:
  JSR Magic_ConvertBitsToBytes 
  
  LDY #0
 @SearchMagicLoop:
  LDA TempSpellList, Y   ; check the unrolled spell list
  CMP shop_spell         ; see if their spell matches the ID of the spell trying to buy
  BEQ @FoundOne
  
  INY
  CPY #24                ; check 24 magic spell slots
  BEQ @NextChar
  BNE @SearchMagicLoop
    
 @FoundOne:
  INC shop_amount        ; increase the # of spells if found
  
 @NextChar:
  PLA                    ; pull the 0 from the start, add 1
  CLC                    ; next loop: pull the 1, add 1 to make 2
  ADC #1                 ; next loop: pull the 2, add 1 to make 3... 
  CMP #4                 ; if all characters are checked, end
  BEQ @End
  
  PHA                    ; push the character ID
  JMP @Loop
  
 @End:
  RTS
  

CheckEquipmentInventory:
  LDX str_buf+$42, Y
  STX shop_curitem       ; backup item ID
  DEX                    ; convert item ID to 0-based
  LDA inv_weapon, X      ; get the amount in inventory
  STA shop_amount       
  LDA shop_selling       ; if selling, don't list what is equipped
  BNE @End
  
  LDA #0
  PHA                    ; push 0 to use as character ID
 
 @Loop:
  TAX
 @SearchEquipmentLoop:
  LDA ch_righthand, X    
  CMP shop_curitem
  BEQ @FoundOne
  
  INX
  TXA
  AND #$0F               ; chop off high bits to get loop counter (only the INX)
  CMP #8                 ; loop through all 8 equipment slots
  BEQ @NextChar
  BNE @SearchEquipmentLoop
    
 @FoundOne:
  INC shop_amount        ; increase the # of spells if found
  
 @NextChar:
  PLA                    ; pull the 0 from the start, add $40
  CLC                    ; next loop: pull the $40, add $40 to make $80
  ADC #$40               ; next loop: pull the $80, add $40 to make $C0... 
  BEQ @End               ; next loop; pull the $C0, add $40 to make $0 again
  
  PHA                    ; push the character ID
  JMP @Loop
  
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
    LDX shop_type
    LDA lut_ShopWelcome, X
    JSR DrawShopDialogueBox     ; draw the "welcome" dialogue
    LDA shop_type
    CMP #7
    BNE MainShopLoop

EnterCaravan:    
    LDA #$03
    JSR DrawShopBox          ; draw shop box ID=3 (the command box)
    LDA #$0B
    JSR DrawShopString       ; draw shop string ID=$0B ("Buy"/"Exit")
    LDA #2
    STA cursor_max           ; 2 cursor options
    LDA #0
    STA cursor
    JSR CommonShopLoop_Cmd   ; do the common shop loop
    BCS ExitShop
    LDA cursor
    BEQ ShopBuy
    RTS                      ; no selling to the Caravan, he's trying to retire

RestartShopLoop:
    JSR ResetShopList_Color
    LDA #$17  
    JSR DrawShopDialogueBox     ; "eh, alright then, what else?"
    LDA shop_type
    CMP #7
    BEQ EnterCaravan
    
MainShopLoop:
    LDA inv_canequipinshop        ; if this is set, characters will dance if they can equip the item the cursor is pointing at
    BEQ :+                        ; so it has to be turned off unless the cursor is pointing at weapons or armor
    JSR Shop_CharacterStopDancing 
    
  : LDA #$03
    JSR DrawShopBox          ; draw box 3 (command box)
    LDA #$0C
    JSR DrawShopString       ; string 0C ("Buy Sell Exit")
    LDA #$03
    STA cursor_max           ; 3 options
    LDA #0
    STA cursor
    JSR CommonShopLoop_Cmd   ; do command loop

    BCS ExitShop
    LDA cursor
    BEQ ShopBuy
    CMP #1
    BNE ExitShop
    JMP ShopSell
    
ExitShop:
    RTS

ShopBuy:
    LDX shop_type
    LDA lut_ShopWhatWant, X
    JSR DrawShopDialogueBox     ; "what would you like" dialogue (different depending on shop type)
    JSR ResetShopListAttributes
    JSR ResetScroll
    
ShopBuy_Loop:    
    LDA shop_listdrawn          ; don't draw the box if its marked as already drawn
    BNE :+
    LDA #$02
    JSR DrawShopBox             ; draw shop box #2 (inv list box)    
    INC shop_listdrawn

  : JSR ShopCursor_Slot1
    JSR LoadShopInventory
    
    LDX shop_type
    LDA lut_ShopMaxAmount, X    ; gets either #99, #16, or #4 depending on shop type
    STA shop_amount_max

    LDA #0
    STA cursor
    STA shop_selling
    
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
    CMP #2
    BEQ @Scrolls                ; if its 2 or 3, its a magic shop
    CMP #3
    BEQ @Scrolls 
    
    LDA #$13                     ; load up "you can't carry any more" string ID
    JMP @DrawDialogue_AndReturn  ; print it and return    

   @Scrolls:
    LDA #$14                     ; "That spell is out of stock"

   @DrawDialogue_AndReturn:    
    JSR DrawShopDialogueBox   
    JSR MenuWaitForBtn
    JMP ShopBuy
    
   @ShopSelectAmount_Prep:
    INC shop_amount_max         ; increase it for SelectAmount_Buy to work right
    
ShopSelectAmount:    
    LDA shop_curitem            
    CMP #BOTTLE
    BNE :+
        JMP @BuyConfirm

 :  JSR SelectAmount            ; choose how many of an item to buy
    BCS @ShopBuy_Return         ; if B was pressed, go back to choosing an item
  
    JSR Shop_CanAfford          ; check to ensure they can afford this item
    BCC @BuyConfirm             ; if they can, jump ahead to complete the purchase.
      JSR HideShopCursor
      LDA #$11
      JSR DrawShopDialogueBox   ; if they can't, "you can't afford it" dialogue
      JSR MenuWaitForBtn
      JMP ShopSelectAmount      ; and return to loop
      
   @ShopBuy_Return:
    JMP ShopBuy
  
   @BuyConfirm: 
    JSR HideShopCursor
    JSR ShopXGoldOkay           ; turns off dancing and prints the price to pay
    JSR ShopLoop_YesNo          ; give them the yes/no option
    BCS @ShopBuy_Return ; ShopSelectAmount        ; if they pressed B, return to selecting the amount
    LDA cursor
    BNE @ShopBuy_Return ; ShopSelectAmount        ; if they selected "No", return to selecting the amount
    ;; JIGS - it backs up further until I can get the cursor pointing back at the item they were trying to buy

   @CompletePurchase:    
    LDA shop_type
    CMP #2
    BCC @AddEquipment
    CMP #4
    BCC @AddMagic
    
   @AddItem:    
    LDX shop_curitem
    LDA items, X                ; load the current amount
    CLC
    ADC shop_amount_buy         ; add in the amount to buy
    STA items, X                ; and save
    JMP FinishPurchase 
    
   @AddEquipment:
    LDA shop_amount_buy
    CMP #1
    BNE :+                      ; if buying more than one, skip equip offer
   
    JSR EquipShop_EquipNow
    ;; ^ checks if you want to give it to a character
    ;; If you are able to, it will pull the return address and jump to FinishPurchase
    ;; At this point, its either equip it or store it in inventory, it will not undo the purchase
  : LDX shop_curitem
    DEX                         ; convert equipment to 0-based
    LDA inv_weapon, X
    CLC
    ADC shop_amount_buy
    STA inv_weapon, X
    JMP FinishPurchase 
    
   @AddMagic: 
    LDA shop_curitem
    SEC
    SBC #ITEM_MAGICSTART        ; convert magic to 0-based
    TAX
    LDA inv_magic, X
    CLC
    ADC shop_amount_buy
    STA inv_magic, X   
    
FinishPurchase: 
    JSR ShopPayPrice            ; subtract the price from your gold amount
    LDA #$16
    JSR DrawShopDialogueBox     ; "Thank you, anything else?" dialogue
    JMP ShopBuy_Loop            ; and continue loop
    
    
;;;;;;;;;;;;;;;;;;;;;

HideShopCursor:
    LDA #$F0
    STA shopcurs_x
    STA shopcurs_y
    JMP ShopFrame               ; update cursor position before drawing things
    
ShopCursor_Slot1:
    LDA #$A0
    STA shopcurs_x
    LDA #$20
    STA shopcurs_y
    JMP ShopFrame               ; update cursor position before drawing things

ShopSell:
    JSR ConvertInventoryToItemBox
    BNE :+
    JMP NothingToSell 
    
  : LDX shop_type
    LDA lut_ShopWhatSell, X
    JSR DrawShopDialogueBox     ; "what do you have to sell?"
    JSR ResetShopListAttributes
    JSR ResetScroll

ShopSell_Loop:    
    LDA shop_listdrawn          ; don't draw the box if its marked as already drawn
    BNE :+
    LDA #$02
    JSR DrawShopBox             ; draw shop box #2 (inv list box)    
    INC shop_listdrawn

  : JSR ShopCursor_Slot1
    LDA #0
    STA cursor
    LDA #1
    STA shop_selling

    JSR ShopSelectItem
    BCC :+
    LDA #0
    STA shop_selling
    JMP RestartShopLoop
    
  : JSR ShopCheckInventory
    STA shop_amount_max
    INC shop_amount_max        ; needs to be 1 over max for the SelectAmount stuff to work

ShopSelectAmount_Sell:    
    JSR SelectAmount
    BCS ShopSell
    
    JSR Shop_CanShopkeepAfford
    BCC @SellConfirm
      LDA #$12
      JSR DrawShopDialogueBox   ; if they can't, "you're too rich already!"
      JSR MenuWaitForBtn
      JMP ShopSelectAmount_Sell
      
   @SellConfirm:   
    JSR HideShopCursor
    JSR ShopXGoldOkay
    JSR ShopLoop_YesNo          ; give them the yes/no option
    BCS ShopSell        ; ShopSelectAmount        ; if they pressed B, return to selecting the amount
    LDA cursor
    BNE ShopSell        ; ShopSelectAmount        ; if they selected "No", return to selecting the amount
    ;; JIGS - it backs up further until I can get the cursor pointing back at the item they were trying to buy
    
   @CompleteSale:    
    LDA shop_type
    CMP #2
    BCC @RemoveEquipment
    CMP #4
    BCC @RemoveMagic
    
   @RemoveItem:    
    LDX shop_curitem
    LDA items, X                ; load the current amount
    SEC
    SBC shop_amount_buy         ; add in the amount to buy
    STA items, X                ; and save
    JMP FinishSale
    
   @RemoveEquipment:
    LDX shop_curitem
    DEX                         ; convert equipment to 0-based
    LDA inv_weapon, X
    SEC
    SBC shop_amount_buy
    STA inv_weapon, X
    JMP FinishSale
    
   @RemoveMagic: 
    LDA shop_curitem
    SEC
    SBC #ITEM_MAGICSTART        ; convert magic to 0-based
    TAX
    LDA inv_magic, X
    SEC
    SBC shop_amount_buy
    STA inv_magic, X   

FinishSale: 
    JSR ShopEarnGold            ; add the price to your gold amount
    LDA #$16
    JSR DrawShopDialogueBox     ; "Thank you, anything else?" dialogue
    JSR ConvertInventoryToItemBox
    BEQ :+
    JMP ShopSell_Loop           ; and continue loop    
    
NothingToSell:    
    LDA #$12
    JSR DrawShopDialogueBox
    JSR MenuWaitForBtn
  : LDA #$02
    JSR LoadShopBoxDims         ; erase shop box 2 (inventory)
    JSR EraseBox
    DEC shop_selling
    DEC shop_listdrawn
    JMP MainShopLoop    
    
;;;;;;;;;;;;;;;;;;;;;

ShopCheckInventory:
    LDX cursor
    LDA item_box, X             ; get chosen item ID
    STA shop_curitem            ; save it
    CMP #BOTTLE
    BNE :+
    
    LDA #1
    STA shop_amount_buy
    JSR ShopLoadPrice_Complex
    PLA
    PLA
    JMP ShopSelectAmount
    
  : LDA #13
    JSR MultiplyXA              ; multiply cursor position by each item's str_buf length
    TAY
    
    LDA str_buf+$42, Y          ; item ID
    STA shop_curitem
    
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
    JSR ResetShopList_Color
    
    LDA inv_canequipinshop        ; if this is set, characters will dance if they can equip the item the cursor is pointing at
    BEQ :+                        ; so it has to be turned off unless the cursor is pointing at weapons or armor
    JSR Shop_CharacterStopDancing 
    
  : LDA #$09
    JSR DrawShopDialogueBox    ; draws "Gold  OK?" -- IE:  all the non-price text
    
    LDA #<(str_buf+$B9)        ; get price from here (see PrintShopAmount)
    STA text_ptr
    LDA #>(str_buf+$B9)
    STA text_ptr+1
    
    LDA #03
    STA dest_x
    INC dest_y
    INC dest_y
    JMP DrawShopComplexString     

;;;;;;;;;;;;;;;;;;;;;
    
EquipShop_EquipNow:
    LDA #$1C                     ; "Do you want to equip it now?"
    JSR DrawShopDialogueBox       
    JSR ShopLoop_YesNo
    BCS EquipOnCharacter_Exit
    LDA cursor
    BNE EquipOnCharacter_Exit
  
EquipOnCharacter:
    LDA #$1D             
    JSR DrawShopDialogueBox      ; "who is it for?"
    JSR ShopLoop_CharNames       ; have the player select a character
    BCS @TroubleExit             ; if they press B, do this
    
    JSR EquipShop_GiveItemToChar ; give the item to the character
    PLA
    PLA
    JMP FinishPurchase

   @TroubleExit:
    LDA #$1F             
    JSR DrawShopDialogueBox      ; "I'll put it in your bags"
    JSR MenuWaitForBtn
  
EquipOnCharacter_Exit:                        ; store in inventory
    RTS  
  
EquipShop_GiveItemToChar:
    LDA cursor          ; get the char ID
    ROR A
    ROR A
    ROR A
    AND #$C0            ; shift and mask to get the char index
    STA CharacterIndexBackup

    LDX shop_type       ; see if this is weapon or armor, and
    BNE CheckArmor

  @CheckWeapons:
    LDA shop_curitem
    STA ItemToEquip
    JSR IsEquipLegal
    BCS CannotEquip
    
    JSR UnEquipStats
  
    LDX CharacterIndexBackup
    LDA ch_righthand, X
    BEQ @EquipWeapon_NoSwap
    
    TAX
    DEX                         ; convert to 0-based
    INC inv_weapon, X
    
   @EquipWeapon_NoSwap: 
    LDX CharacterIndexBackup
    LDA ItemToEquip
    STA ch_righthand, X
    JMP ReEquipStats
    
CannotEquip:
    LDA #$28                   
    JSR DrawShopDialogueBox    ; "You can't equip that"
    JSR MenuWaitForBtn
    PLA
    PLA
    JMP EquipOnCharacter
    
CheckArmor: 
    LDA shop_curitem
    SEC
    SBC #ARMORSTART     
    STA ItemToEquip
    JSR IsEquipLegal
    BCS CannotEquip
    
    JSR UnEquipStats
    
    LDX ItemToEquip
    LDA lut_ArmorTypes, X ; check type LUT
    STA equipoffset   
    CLC
    ADC #ch_righthand - ch_stats
    ADC CharacterIndexBackup
    STA CharacterIndexBackup
    TAX                   
    LDA ch_stats, X 
    BEQ @EquipArmor_NoSwap
    
    TAX
    DEX
    INC inv_weapon, X       ; put their old gear into inventory
    
   @EquipArmor_NoSwap:
    LDX CharacterIndexBackup
    LDA ItemToEquip
    CLC
    ADC #ARMORSTART
    STA ch_stats, X

ReEquipStats:
    JSR LongCall
    .word ReadjustEquipStats
    .byte BANK_EQUIPSTATS
    RTS      

UnEquipStats:
    JSR LongCall
    .word UnadjustEquipStats
    .byte BANK_EQUIPSTATS
    RTS    
    
SelectAmount:
    LDA #0
    STA shop_listactive     ; turn off changing the green bar on the inventory list
    LDA shop_selling        ; if selling...
    BEQ :+
       LDA #$26             ; display selling text
       JMP :++
      
  : LDA #$0A                ; display buying text; "How many?" 
  : JSR DrawShopDialogueBox
    LDA #1
    STA shop_amount_buy    
    JSR PrintShopAmount     ; fill the spaces in the "how many?" text with numbers
    
    LDA #$B0
    STA shopcurs_y
    LDA #$08
    STA shopcurs_x          ; move cursor position    
   
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
    BEQ @More

   @Less:                ; otherwise, it was down
    DEC shop_amount_buy  
    LDA shop_amount_buy
    CMP #0
    BNE @MoveDone        ; if it hasn't gone below 1, that's all -- continue loop
    
    LDA shop_amount_max  ; otherwise (below 1), wrap to our item limit
    SEC
    SBC #$01             ; minus one
    JMP @MoveDone        ; desired cursor is in A, jump ahead to @MoveDone to write it back

   @More:
    LDA shop_amount_buy  ; if Up or Right pressed, increase amount 
    CLC
    ADC #$01             ; increment it by 1
    CMP shop_amount_max  ; check to see if we've gone over the amount we can buy
    BCC @MoveDone        ; if not, jump ahead to @MoveDone
    LDA #1               ; if yes, wrap limit to 1

  @MoveDone:             ; code reaches here when A is to be the new amount to buy
    STA shop_amount_buy  ; 
    JSR PrintShopAmount  ; prints all the numbers
    JMP @Loop            ; and continue loop

  @B_Pressed:            ; if B pressed....
    SEC                  ; SEC to indicate player pressed B
                         ;  and proceed to @ButtonDone

  @ButtonDone:           ; reached when the player has pressed B or A (exit this shop loop)
    LDA #0
    STA joy_a            ; zero joy_a and joy_b so further buttons will be detected
    STA joy_b
    RTS

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
    
;;    BCC :+                 ; I'm confused about this.
;;       INX                 ; why increase X? Never used...?
;;  : STA tmp+3              ; tmp+3 is same as tmp+2?? Did I mess up... is this not needed at all?
;;    STA shop_curprice+3    ; shop_curprice+3 isn't even called anywhere!

;    LDA tmp
;    STA shop_curprice
;    LDA tmp+1
;    STA shop_curprice+1
;    LDA tmp+2
;    STA shop_curprice+2
;    LDA tmp+3
;    STA shop_curprice+3
;; JIGS - before, I had a bug where trying to save both at the same time didn't work.
;;        if that's still the case, re-enable this

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
    
    LDA shop_curitem       ; if bottle, don't print
    CMP #BOTTLE
    BNE :+
        RTS 
    
  : LDA #24
    STA dest_y
    LDA #06
    STA dest_x
    
    LDA #<(str_buf+$B9)        ; set our text pointer to point to the generated string
    STA text_ptr
    LDA #>(str_buf+$B9)
    STA text_ptr+1
    JMP DrawComplexString
    

    
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
    LDA #$20
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
    
    LDA #0
    STA joy_a                   ; clear A and B catchers
    STA joy_b

    LDA #$21
    JSR DrawShopDialogueBox     ; "Remember to save" dialogue

    LDA #$03
    JSR LoadShopBoxDims         ; erase shop box 3 (command box)
    JSR EraseBox

    JSR ShopFrameNoCursor 
    JSR FadeOutBatSprPalettes   ; and fade the party out
    JSR MenuWaitForBtn_SFX  
    
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
    JSR FadeInBatSprPalettes    ; then fade the party back in

  @Exit_HealthRestored:
    LDA music_track             ; check to see if the music has silenced (will happen
    CMP #$81                    ;  after the save jingle ends)
    BNE :+
      LDA #$51 ; 4F             ; restart track $4F (shop music) ;; JIGS - menu music now!
      STA music_track
    
  : LDA #$22
    JSR DrawShopDialogueBox     ; "HP/MP restored" dialogue
    JMP @True_Exit
    
  @Exit:
    LDA #$03
    JSR LoadShopBoxDims         ; erase shop box 3 (command box)
    JSR EraseBox    

    LDA #$21
    JSR DrawShopDialogueBox     ; "HP/MP restored" dialogue 
    
  @True_Exit:  
    LDA #0
    STA joy_a
    STA joy_b                   ; clear A and B catchers

  @LoopTwo:
    JSR ShopFrameNoCursor       ; do a frame
    LDA joy_a                   ; check to see if A or B have been pressed
    ORA joy_b
    BEQ @LoopTwo                ; and keep looping until one of them has

ClinicInn_Exit:
    RTS                         ; then exit


EnterClinic:
    LDA #0
    STA joy_a                  ; clear A and B button catchers
    STA joy_b

    JSR ClinicBuildNameString  ; build the name string (also tells us if anyone is dead)
    BCC @NobodysDead           ; if nobody is dead... skip ahead

    LDA #$24
    JSR DrawShopDialogueBox    ; "Who needs to come back to life" dialogue

    JSR Clinic_SelectTarget    ; Get a user selection
    LDA cursor                 ; grab their selection
    STA shop_curitem           ; and put it in cur_item to hold it for later
    BCS ClinicInn_Exit         ; If they pressed B, exit.

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
    LDA #$00
    STA ch_ailments, X         ; erase this character's ailments (curing his "death" ailment)
    STA joy_a
    STA joy_b                  ; clear A and B catchers
    LDA #$01
    STA ch_curhp, X            ; and give him 1 HP

    LDA #$25
    JSR DrawShopDialogueBox    ; "Warrior!  Return to life!"  dialogue

    LDA #$03
    JSR LoadShopBoxDims        ; erase shop box 3 (command box)
    JSR EraseBox

  @ReviveLoop:
    JSR ShopFrameNoCursor      ; do a frame
    LDA joy_a
    ORA joy_b
    BEQ @ReviveLoop            ; and loop (keep doing frames) until A or B pressed
    JMP EnterClinic            ; then restart the clinic loop
 
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
    LDA #$11
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
    STA inv_canequipinshop
    STA item_box_offset
    LDA cursor
    PHA
    LDA shop_type
    BNE @Armor
    
    LDA #$91
    JMP :+
    
   @Armor:
    LDA #$92
  : STA cursor
    JSR Shop_CharacterCanEquip
    PLA
    STA cursor
    RTS    

    ;; ^ this routine temporarily sets cursor to bytes in the string buffer
    ;;   which make it think its pointing to a 65th weapon or armor
    ;;   which has its permission bits all set so no one can equip it... 
    ;;   which causes everyone to return to normal pose!

Shop_CharacterCanEquip:
    LDA cursor
    CLC
    ADC item_box_offset
    TAX
    
    LDA shop_type
    STA equipoffset
    BNE @Armor
    
    LDA item_box, X
    STA tmp+8
    BNE :+

   @Armor:
    LDA item_box, X
    STA tmp+8
    SEC
    SBC #ARMORSTART
  : STA tmp+9
    
    LDA #0
   @Loop:
    AND #$C0
    STA CharacterIndexBackup
    TAX
    JSR @DrawEquipped
    
    LDA tmp+9
    JSR IsEquipLegal
    BCS @CannotEquip
    
    LDX CharacterIndexBackup ; this sets the high bit, which tells the sprite drawing routine to do the "Cheer" pose
    LDA ch_ailments, X
    ORA #$80
    STA ch_ailments, X
    JMP @NextCharacter
    
   @CannotEquip:
    LDX CharacterIndexBackup ; this will set them to stop dancing if they were before
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
    
   @DrawEquipped:
    LDA ch_righthand, X
    CMP tmp+8
    BEQ @Do_DrawMark
    
    INX
    TXA
    AND #$0F
    CMP #8
    BNE @DrawEquipped    
   
   @Undo_DrawMark:
    JSR @DrawMark
    EOR #$0F
    AND shop_drawmarks
    JMP :+
    
   @Do_DrawMark:
    JSR @DrawMark
    ORA shop_drawmarks
  : STA shop_drawmarks
    LDX CharacterIndexBackup
    RTS
   
   @DrawMark:  
    LDA CharacterIndexBackup
    ASL A                     ;  convert it from $40 base to $1 base (ie:  $03 is character 3 instead of $C0)
    ROL A
    ROL A
    AND #$03                  ; mask out low 2 bits 
    TAX
    LDA @Equipped_LUT, X
    RTS 
   
   @Equipped_LUT:
    .byte $01  
    .byte $02 
    .byte $04 
    .byte $08 

    
ChangeInventoryList_Color:
    JSR ResetShopListAttributes
    JSR ShopListActiveBar
    BNE ResetScroll

ResetShopList_Color:              ; turns off the shop_listactive variable
    LDA #0
    STA shop_listactive
    JSR ResetShopListAttributes    

ResetScroll:        
    LDA soft2000                  ; reset scroll and PPU data
    STA $2000
    LDA #0
    STA $2005
    STA $2005
    RTS
    
ResetShopListAttributes:          ; clears the highlighted colour 
    JSR WaitForVBlank_L
    
    LDY #0
   @Loop: 
    JSR SetAttributeBarLocation    
    LDA #$FF             
    JSR DrawAttributeBar    
    INY
    CPY #5
    BNE @Loop
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
    LDA ShopListAttribute_LUT, Y
    LDX #$23
    STX $2006
    STA $2006
    RTS

ShopListAttribute_LUT:         
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

DrawEquipMarks:
    LDA shop_drawmarks   ; each bit set = draw the ! for that character
    LSR A 
    BCC :+
     LDX #0              ; put character index in X
     JSR @DoMark
  : LSR A
    BCC :+
     LDX #1
     JSR @DoMark
  : LSR A
    BCC :+
     LDX #2
     JSR @DoMark    
  : LSR A
    BCC :+
     LDX #3 
     JSR @DoMark    
  : RTS   
    
   @DoMark: 
    PHA
    LDA @Equipped_LUT, X    
    LDX sprindex
    STA oam+$0, X          ; upper left vertical coordinate
    LDA #$95
    STA oam+$3, X          ; upper left horizontal coordinate
    LDA #$FF
    STA oam+$1, X          ; graphic: !
    LDA #$03
    STA oam+$2, X          ; attribute
    LDA sprindex     
    CLC                    ;  increment the sprite index by 4 (1 sprite)
    ADC #4
    STA sprindex
    PLA
    RTS
   
   @Equipped_LUT:
    .byte $2E  
    .byte $46 
    .byte $5E 
    .byte $76 


ShopFrame:
    JSR ClearOAM               ; clear OAM
    LDA shop_listactive        ; is the inventory list the box the cursor is on?
    BEQ :+    
    LDA shop_cursorchange      ; did the cursor change since the last frame?
    BEQ :+
    JSR ChangeInventoryList_Color ; change the position of the green highlight
    DEC shop_cursorchange
    LDA inv_canequipinshop     ; then do the thing to update character poses and ! equipped things
    BEQ :+
    JSR Shop_CharacterCanEquip ; JIGS - if its weapon or armor shops, check the cursor for the highlighted item
                               ; then apply a high bit to ailments that tells the sprite-drawing routine to do them in cheer pose! oof
  : JSR DrawShopPartySprites   ; draw the party sprites
    JSR DrawShopCursor         ; and the cursor
    JSR DrawEquipMarks
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

EquippedMark_LUT:  
.byte $60,$00,$60,$60,$60,$60,$60,$00  ; reversed

LoadEquippedMark:
    LDA #>$1FF0
    STA $2006
    LDA #<$1FF0
    STA $2006
    
    LDX #8
   @Loop:   
    LDA EquippedMark_LUT-1, X
    STA $2007
    DEX
    BNE @Loop

    TXA
    LDX #8
   @0_Loop:
    STA $2007
    DEX
    BNE @0_Loop
    RTS
    ;; this all draws a ! to the sprite CHR at tile $FF

DrawShop:
    LDA shop_type              ;; JIGS - skip loading "inventory" if its an inn or clinic
    CMP #4
    BEQ :+
    CMP #5
    BEQ :+              
    
    JSR LoadShopInventory      ; load up this shop's inventory into the item box
  : JSR ClearNT                ; clear the nametable
    LDA $2002                  ; reset the PPU toggle

    LDA #>$23D3
    STA $2006
    LDA #<$23D3
    STA $2006
    LDA #0
    STA $2007
    LDX #>$23DB
    STX $2006
    LDX #<$23DB
    STX $2006
    STA $2007                  ; JIGS - only fill these two attribute bytes!
    JSR LoadEquippedMark
 
    ; Draw the shopkeeper
    LDX shop_type                ; get the shop type in X
    LDA lut_ShopkeepAdditive, X  ; use it to fetch the image additive from our LUT
    STA tmp+2                    ; tmp+2 is the image additive (see DrawImageRect)
    
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
    STA item_box_offset  ; clear this so the list isn't scrolled
    
    LDX #BOTTLE
    LDA items, X         ; does player have the Bottle?
    BEQ @End             ; if not, exit
    
    LDX #4
    LDA item_box, X      ; if yes, see if this shop's last item is the Bottle
    CMP #BOTTLE
    BNE @End             ; if not, exit
    
    LDA #LEWDS           ; change the item the caravan is selling
    STA item_box, X

    LDX #LEWDS           ; does the player have the new item?
    LDA items, X          
    BEQ @End             ; if not, exit
    
    LDX #4               ; if yes, set the caravan's last item to nothing
    LDA #0
    STA item_box, X
    
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

EquipMenu_BuildSellBox:
    LDY #63
    LDA #0
   @ClearBox:
    STA item_box, Y
    DEY
    BPL @ClearBox

    LDX #$FF
    INY    
    LDA shop_type        ; check shop type, and fork appropriately
    BEQ @SkipWeapon
    CMP #1    
    BEQ @SkipArmor
    BNE @SkipMagic
    
  @SkipWeapon:
    INX  
    CPX #64
    BEQ @Done

  @WeaponLoop:
    LDA inv_weapon, X    ; get the weapon ID in this slot
    BEQ @SkipWeapon
    
    INX                  ; convert weapon to +1 ID 
    TXA                  ; put ID in A
    STA item_box, Y      ; store in item_box
    
    INY
   @ResumeWeaponLoop: 
    CPX #64
    BNE @WeaponLoop
    JMP @Done
   
   @SkipArmor:
    INX  
    CPX #64
    BEQ @Done

  @ArmorLoop:
    LDA inv_armor, X    ; get the armor ID in this slot
    BEQ @SkipArmor
    
    TXA                  ; put ID in A
    CLC
    ADC #ARMORSTART+1    ; add Armor ID offest +1
    STA item_box, Y      ; store in item_box
    
    INY
    INX                  
   @ResumeArmorLoop: 
    CPX #64
    BNE @ArmorLoop
    JMP @Done

    @Done:
    LDA #0
    STA item_box, X
    INX 
    CPX #64
    BCC @Done
    
    LDA item_box
    CMP #01
    RTS
    
  @SkipMagic:
    INX  
    CPX #64
    BEQ @Done

  @MagicLoop:
    LDA inv_magic, X    ; get the magic ID in this slot
    BEQ @SkipMagic
    
    TXA
    CLC
    ADC #MG_START+1     ; add magic ID offset+1
    STA item_box, Y     ; store in item_box
    
    INX                  ; convert magic to +1 ID 
    INY
   @ResumeMagicLoop: 
    CPX #64
    BNE @WeaponLoop
    JMP @Done    
    
    
    
    
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


ShopSelectItem:
    JSR UpdateShopList 
    LDA #$03
    JSR LoadShopBoxDims
    JSR EraseBox             ; erase shop box #3 (command box)
    LDA #1
    STA shop_listactive
    STA shop_cursorchange  
    JMP CommonShopLoop_List  ; everything's ready!  Just run the common loop from here, then return

Fillblank_item:         
    LDA cursor_max      ; if cursor_max didn't increase yet, this is the first item...
    BNE :+              ; if this is the first item, there are no items! 
       LDA item_box_offset
       SEC
       SBC #5
      ; BPL @NothingLeft
       STA item_box_offset ; subtract 5 from this, and re-do from scratch
       JMP ShopSelectItem    
       
     ; @NothingLeft:        ; player has cleared out their inventory, so break out of the sell loop
     ;  PLA
     ;  PLA
     ;  LDA #$16
     ;  JSR DrawShopDialogueBox ; "Thank you, anything else?"
     ;  JSR ResetShopList_Color
     ;  JMP MainShopLoop
       
    
 :  LDA #$09            ; fill 3 rows with 8 blank spaces (09 is control code for print spaces, followed by 08)
    STA str_buf+$41, Y  
    STA str_buf+$44, Y  
    STA str_buf+$47, Y  
    LDA #8              
    STA str_buf+$42, Y  
    STA str_buf+$45, Y  
    STA str_buf+$48, Y  
    LDA #$05
    STA str_buf+$43, Y  
    STA str_buf+$46, Y  
    LDA #$01            
    STA str_buf+$49, Y     
    INC blank_item
    
    TYA
    CLC
    ADC #9
    TAY
    
    INC cursor_max       ; increment cursor_max, our item counter
    LDA cursor_max
    CMP #5               ; ensure we don't exceed 5 items (max the shop space will allow)
    BNE :-               ; if we haven't reached 5 items yet, keep looping
    JMP UpdateShopList_Done

UpdateShopList:
    LDY #0            ; zero Y... this will be our string building index
    STY cursor_max    ; up counter
    STY blank_item
    
UpdateShopList_Loop:
    LDA item_box_offset ; 0 always, except when selling items, then it moves to scroll the list!
    CLC
    ADC cursor_max
    TAX
    
    LDA item_box, X      ; use it to get the next shop item
    BNE @ItemExists
    
    JMP Fillblank_item
    
   @ItemExists:
    STA str_buf+$42, Y   ; put item ID
    STA str_buf+$4C, Y   ; 
    
    LDA shop_type
    CMP #2
    BCS :+
       LDA #$07
       JMP :++
    
  : LDA #$02
  : STA str_buf+$41, Y   ; Item Name control code
    LDA #$03
    STA str_buf+$4B, Y   ; Item Price control code
    LDA #$05
    STA str_buf+$43, Y   ; single line break
    STA str_buf+$47, Y   ; single line break
    LDA #$01
    STA str_buf+$4D, Y   ; double line break
    LDA #$FF
    STA str_buf+$48, Y
    STA str_buf+$49, Y
    STA str_buf+$4A, Y
    LDA #$F1              ; x
    STA str_buf+$44, Y

    LDA shop_type
    CMP #2
    BCC @EquipmentQTY
    CMP #4
    BCC @MagicQTY
    
   @ItemQTY:
    LDX str_buf+$42, Y   ; get item ID
    LDA items, X           
    JMP :++              ; double ++ so it doesn't load shop_amount
   
   @EquipmentQTY:
    JSR CheckEquipmentInventory ; like CheckMagicInventory, but doesn't use Y
    LDA #1
    STA inv_canequipinshop ; turn on the switch for characters posing  
    JMP :+
    
   @MagicQTY: 
    TYA                     
    PHA
    JSR CheckMagicInventory ; does everything to check how many of each spell there is, known and in inventory
    PLA                     ; this also puts spell level in str_buf+$49, Y! 
    TAY                     ; it does this before Y is re-used for another loop and restored here
    LDA #$95                ; L
    STA str_buf+$48, Y      ; overwrite the #$FF in this slot
  : LDA shop_amount
    
  : STA tmp
    JSR PrintNumber_2Digit ; print quantity
    LDA format_buf-1       ; tens   
    STA str_buf+$46, Y    
    LDA format_buf-2       ; ones 
    CMP #$FF
    BNE @TwoDigit
    
   @Singledigit:
    STA str_buf+$46, Y
    LDA format_buf-1
        
   @TwoDigit:
    STA str_buf+$45, Y   
    
;;  The item string should now look like this:    
;;  02/07 Item ID 05 x  Inventory QTY 05 | _  _           | _  03 Item ID 01
;;  41    42      43 44 45-46         47 | 48 49          | 4A 4B 4C      4D 
;;                             if magic: | L  Spell Level |

    TYA
    CLC                  ; add 13 to our string index so the next item is drawn after this item
    ADC #13              ; JIGS - the box is longer than original game
    TAY
  
    INC cursor_max           ; increment cursor_max, our item counter
    LDA cursor_max
    CMP #5                   ; ensure we don't exceed 5 items (max the shop space will allow)
    BEQ UpdateShopList_Done  ; if we haven't reached 5 items yet, keep looping
    JMP UpdateShopList_Loop

UpdateShopList_Done:
    SEC
    SBC blank_item
    STA cursor_max
   
    DEY
    LDA #0
    STA str_buf+$41, Y     ; slap a null terminator at the end of our string
    STA str_buf+$40        ; slap a null terminator at the end of equipment list
    STA str_buf+$94
    STA str_buf+$96        ; and two on the end of the "Character has this item Equipped" short little things
        
    LDA #WEP64+1
    STA str_buf+$91         ; JIGS - weapon dance reset byte!
    LDA #ARM64+1
    STA str_buf+$92         ; Armor dance reset byte!
    
    ;; SO since the string buffer ends at $3D when a shop has 5 items, these two bytes are unused, but need to be filled...
    ;; By setting cursor to $3E and $3F, depending on weapon or armor shops, the routine that makes them pose to show they can equip weapons
    ;; Will try to make them equip a 41st item, which in the permissions LUT, is filled with "cannot equip" bits...
        
    LDA #$7F
    STA str_buf+$93         ; ! icon on black background
    LDA #$7E
    STA str_buf+$95         ; just an empty, black background 
    
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
    
    LDY #63
   @ClearBox:
    STA item_box, Y
    DEY
    BPL @ClearBox
    TAY
    
    LDA shop_type
    BEQ @Weapons
    CMP #2
    BCC @Armor
    CMP #4
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
    JMP @BuildSellString
    
   @Magic:
    LDA inv_magic, Y
    BEQ @NextMagic
    TYA
    CLC
    ADC #ITEM_MAGICSTART       ; convert Y to magic ID
    STA item_box, X
    INX 
   @NextMagic:
    INY
    CPY #64               ; check all 64 spells 
    BNE @Magic
    JMP @BuildSellString
    
   @Weapons: 
    LDA inv_weapon, Y
    BEQ @NextWeapon
    TYA            
    STA item_box, X
    INC item_box, X      ; convert Y to weapon ID
    INX 
   @NextWeapon:
    INY
    CPY #64               ; check all 64 weapon slots
    BNE @Weapons
    JMP @BuildSellString
    
   @Armor: 
    LDA inv_armor, Y
    BEQ @NextArmor
    TYA           
    CLC
    ADC #ARMORSTART+1
    STA item_box, X
    INX 
   @NextArmor:
    INY
    CPY #64               ; check all 64 armor slots
    BNE @Armor

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
    LDA #$03
    JSR DrawShopBox          ; draw shop box ID=3 (the command box)
    LDA #$0D
    JSR DrawShopString       ; draw shop string ID=$0F ("Yes"/"No")

    LDA #2
    STA cursor_max           ; 2 cursor options
    LDA #0
    STA cursor

    JMP CommonShopLoop_Cmd   ; do command shop loop and exit



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  ShopLoop_BuySellExit  [$A8D3 :: 0x3A8E3]
;;
;;    Same thing as above... but with options "Buy", "Sell"
;;  and "Exit"
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;ShopLoop_BuySellExit:
;    LDA #$03
;    JSR DrawShopBox          ; draw box 3 (command box)
;    LDA #$0A
;    JSR DrawShopString       ; string 0A ("Buy Sell Exit")

;    LDA #$03
;    STA cursor_max           ; 3 options
;    LDA #0
;    STA cursor

;    JMP CommonShopLoop_Cmd   ; do command loop


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
    LDA #0
    STA cursor

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
    STA shop_cursor_ptr        ;  
    LDA #>lut_ShopCurs_Cmd     ;  
    STA shop_cursor_ptr+1
    JMP _CommonShopLoop_Main   ; then jump ahead to the main entry for these routines

CommonShopLoop_List:
    LDA #<lut_ShopCurs_List    ; exactly the same as _Cmd version of the routine
    STA shop_cursor_ptr        ; only have (shop_cursor_ptr) point to a different LUT
    LDA #>lut_ShopCurs_List
    STA shop_cursor_ptr+1

      ; both flavors of this routine meet up here, after filling (shop_cursor_ptr)
      ;   with a pointer to a LUT containing the cursor positions.

 _CommonShopLoop_Main:
    LDA joy              ; get the joy data
    AND #$0C             ; isolate up/down bits
    STA joy_prevdir      ; and store in prev_dir
                         ; then begin the loop...

  @Loop:
    LDA cursor           ; get the cursor
    ASL A                ; multiply by 2 (2 bytes per position)
    TAY                  ; put in Y for indexing

    LDA (shop_cursor_ptr), Y    ; fetch the cursor X coord from out LUT
    STA shopcurs_x       ; and record it
    INY                  ; inc Y to get Y coord
    LDA (shop_cursor_ptr), Y    ; read it
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

    INC shop_cursorchange
    CMP #$08             ; see if the button pressed was up or down
    BNE @Down

  @Up:
    DEC cursor           ; if up pressed, decrement the cursor by 1
    BPL @Loop            ; if it hasn't gone below zero, that's all -- continue loop

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

;ClearShopkeeperTextBox:
;    JSR ShopFrame        ; now that cursor position has been recorded... do a frame

;    LDA joy_b
;    ORA joy_a
;    BEQ ClearShopkeeperTextBox ; just wait for A or B to be pressed
    
;    LDA #0
;    STA joy_b
;    STA joy_a

;    LDA #$00
;    JSR LoadShopBoxDims
;    JMP EraseBox           ; erase shop box #3 (command box)






   

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

;ShopSelectBuyMagic:
;    LDA #0
;    STA cursor
;    STA cursor_max     ; zero cursor max... this will count the number of spells for sale.
;    LDY #0             ; Y will be our string index

;  @Loop:
;    LDX cursor_max
;    LDA item_box, X    ; get next item in shop inventory
;    BEQ @Done          ; if it's zero (the null terminator), break out of the loop
   
;    STA str_buf+$42, Y ; store item ID at $11
;    STA str_buf+$48, Y ; and $17
;    LDA #$02
;    STA str_buf+$41, Y ; store $02 ("draw item name" control byte) at $10
;    LDA #$03
;    STA str_buf+$47, Y ; store $03 ("draw item price" control byte) at $16
;    LDA #$01
;    STA str_buf+$43, Y ; store $01 (double line break) at $12 and $18
;    STA str_buf+$49, Y
;    LDA #$95
;    STA str_buf+$44, Y ; JIGS - normal L now
;    LDA #$FF           ; and a space
;    STA str_buf+$46, Y

;    LDA str_buf+$42, Y ; get the item ID
;    SEC
;    SBC #ITEM_MAGICSTART  ; subtract 
;    LSR A
;    LSR A
;    LSR A              ; then divide by 8.  This gives us the spell's level
;    SEC
;    ADC #$80           ; SEC then add $80 (so really... add $81).  This converts the 0-based
                       ;  level, into the 1-based tile to draw.  IE:  level=0 prints the "1" tile.
;    STA str_buf+$45, Y ; put that tile at $14

                 ; string is now:  "02 XX 01 C6 VV 03 XX 01" where XX is the item ID, and VV is the spell level
                 ;  which... after processing all control codes... will draw to:
                 ;
                 ; Name
                 ; LV_Price

;    TYA
;    CLC                ; that bit of string is 8 bytes... so add 8 to our
    ;ADC #$08           ;  string index:  Y
    ;; JIGS - it is 9!
;    ADC #$09
;    TAY

;    INC cursor_max     ; increment cursor max to count this entry
;    LDA cursor_max
;    CMP #5             ; check to see if we have 5 spells yet (can't sell more than 5)
;    BCC @Loop          ; keep looping if we have less than 5

;  @Done:
;    LDA #$00
;    STA str_buf+$41, Y ; put a null terminator at the end of the string

;    LDA #$02
;    JSR DrawShopBox    ; draw shop box 2 (inventory list box)

;    LDA #<(str_buf+$41)         ; set the text pointer to our string
;    STA text_ptr
;    LDA #>(str_buf+$41)
;    STA text_ptr+1
;    JSR DrawShopComplexString   ; and draw it

;    LDA #$03
;    JSR LoadShopBoxDims         ; then erase shop box 3 (command box)
;    JSR EraseBox

;    JMP CommonShopLoop_List     ; and have the user select an option from the shop inventory list

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
    PHA                  ; back up desired dialogue string by pushing it
    LDA #$00
    JSR DrawShopBox      ; draw shop box ID 0 (the dialogue box)
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
    LDA #$09
    JSR DrawShopDialogueBox   ; draw "Gold  OK?" -- all the non-price text

    LDA #0
    STA tmp
    STA tmp+1

    LDA shop_type
    CMP #4
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
    BCC @DrawNumber     ;; foolishly rich light warriors!
    
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

    LDA shop_curitem
   
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
 .byte BANK_TITLE
 
  LDA music_track             ; check the music track
  CMP #$81                    ; if $81 (no music currently playing)...
  BEQ :+
  LDA SaveGameMusic           ; will be 0 if saving didn't happen
  CMP #$56                    ; if save music still playing
  BNE :++
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
;; JIGS - not the original version, but an older version
;; purple text for title, green text for gold box

;  .BYTE $55,$55,$55,$55,$55,$FF,$FF,$FF
;  .BYTE $F5,$F5,$F5,$F5,$F5,$FF,$FF,$FF
;  .BYTE $FF,$FF,$FF,$00,$FF,$FF,$FF,$FF
;  .BYTE $FF,$FF,$FF,$00,$FF,$FF,$FF,$FF
;  .BYTE $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
;  .BYTE $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
;  .BYTE $FF,$FF,$FF,$FF,$FF,$AA,$AA,$AA
;  .BYTE $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF

  


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
 BNE SFX_Done
 
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
    
    LDA #$7E         ; : seperators
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
    LDA #1
    STA MenuHush        ;; JIGS - mute music instead
    LDA #BANK_THIS
    STA cur_bank          ; set cur_bank to this bank

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
    
    JSR WaitForVBlank_L
    JSR CallMusicPlay     ;   so we can call music play routine
    ;;JIGS -- I feel like this smooths out the music a bit more when opening the menu? maybe not

ResumeMainMenu:
    LDA #0
    STA $2001                       ; turn off the PPU
    STA menustall                   ; and disable menu stalling

    JSR DrawMainMenu                ; draw the main menu
    JSR TurnMenuScreenOn_ClearOAM   ; then clear OAM and turn the screen on

    LDA #0
    STA cursor                      ; flush cursor, joypad, and prev joy directions
    STA joy
    STA joy_prevdir
    STA item_pageswap

MainMenuResetCursorMax:    
    LDA mapflags            ; make sure we're on the overworld
    LSR A                   ;  Get SM flag, and shift it into C
    BCS @CheckTile          ; if not on overworld, then don't let cursor touch save option
    
   @SetMax6:
    LDA #6
    JMP :+

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
    
    JSR MoveCursorUpDown          ; then move the cursor up or down if up/down pressed
    JMP MainMenuLoop              ;  rinse, repeat
  
  @Select_Pressed:
    JSR LineUp_InMenu
    BCC ResumeMainMenu            ; characters swappwed ; redraw menu
    JMP @EscapeSubTarget          ; not swapped ; just reset the cursor
    
  @B_Pressed:
    LDA #0            ; turn PPU off
    STA $2001
    STA joy_a         ; flush A, B, and Start joypad recordings
    STA joy_b
    STA joy_start
    STA joy_select
    JSR CallMusicPlay
    RTS               ; and exit the main menu (by RTSing out of its loop)

    ; if A pressed, we need to move into the appropriate sub menu based on 'cursor' (selected menu item)

  @A_Pressed:
    JSR PlaySFX_MenuSel         ; play the selection sound effect
    LDA cursor                  ; get the cursor
    BNE @NotItem                ; if zero.... (ITEM)

    @Item:
      LDA #0
      STA backup_cursor
      JSR EnterItemMenu         ; enter item menu
      JMP ResumeMainMenu        ; then resume (redraw) main menu

  @NotItem:
    CMP #$01
    BNE @NotMagic               ; if cursor = 1... they selected 'magic'


    @MagicLoop:
      JSR MainMenuSubTarget     ; select a sub target
      BCS @EscapeSubTarget      ; if B pressed, they want to escape sub target menu.

      JSR Cursor_to_Index
      ;LDA cursor                ; otherwise (A pressed), get the selected character
      ;ROR A
      ;ROR A
      ;ROR A
      ;AND #$C0                  ; and shift it to a useable character index
      ;TAX                       ; and put in X

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
    .byte BANK_TITLE
    LDA #$01
    STA cur_pal+14
    JMP ResumeMainMenu
        
   @Save:
    JSR SaveGame
    JMP EnterMainMenu ; uses Enter instead of Resume, to re-load the appropriate character sprites

@EscapeSubTarget:             ; if they escaped the sub target menu...
    LDA #0
    STA cursor                ; reset the cursor to zero
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

DrawMagicMenu:
    LDA #0
    STA $2001                      ; turn off PPU
    STA menustall                  ; clear menustall
    STA descboxopen                ; and mark description box as closed
    
    LDA submenu_targ               ; get the character we're looking at
    JSR Magic_ConvertBitsToBytes
    ; JIGS ^ Gotta get the spells into place before printing them!
    
    JSR ClearNT                    ; clear the nametable
    JSR DrawMagicMenuMainBox       ; draw the big box containing all the spells
    ;; item_pageswap is set to 0 if no spells are found
    
    LDA #$07
    JSR DrawMainItemBox             
    DEC dest_y
    LDA #7
    JSR DrawCharMenuString         ; draw the character's name
   
    LDA #$11
    JSR DrawMainItemBox            ; sub menu box

DrawMagicSubMenuString:
    LDA #10
    STA dest_x
    LDA #02
    STA dest_y
    LDA #67 
    JMP DrawMenuString             ; "Cast / Learn / Forget"

JumpToMagicLearnMenu:
    LDA #0
    STA cursor
    STA cursor_max
    STA item_pageswap
    JSR MagicMenu_LearnSpell

EnterMagicMenu:
    LDA #0
    STA cursor
    STA item_pageswap              
    INC item_pageswap              ; will be set to 0 later if there are no spells learned
    
    JSR DrawMagicMenu
    
    JSR TurnMenuScreenOn_ClearOAM  ; clear OAM and turn the screen on

EnterMagicSubMenu:
    LDA #0
    STA cursor
    
    LDA #1
    STA menustall
    JSR DrawMagicSubMenuString
 
    NoLocal_MagicSubMenuLoop:
  @MagicSubMenuLoop:
    JSR ClearOAM                ; clear OAM
    JSR DrawMagicSubMenuCursor  ; draw the cursor
    JSR MenuFrame               ; and do a frame

    LDA joy_a
    BNE @A_Pressed            ; check if A pressed
    LDA joy_b
    BNE @B_Pressed            ; and B

    JSR MoveMagicSubMenuCursor   ; otherwise, move the cursor if a direction was pressed
    JMP @MagicSubMenuLoop        ; and keep looping

  @B_Pressed:
    RTS                       ; if B pressed, just exit

  @A_Pressed:
    JSR PlaySFX_MenuSel
    LDA cursor
    BEQ EnterMagicMenu_PrepareCursor
    CMP #1
    BEQ JumpToMagicLearnMenu
    
  @MagicForgetOption:
    LDA item_pageswap
    BEQ CannotEnterMagic
    LDA #2
    STA item_pageswap          ; set to 2 to indicate that selecting a spell will forget it
    JMP :+
    
  EnterMagicMenu_PrepareCursor:
    LDA item_pageswap          ; is set to 0 if no spells are known
    BEQ CannotEnterMagic
    CMP #2
    BCC :+
      DEC item_pageswap
  : LDA backup_cursor
    STA cursor                 ; set cursor to first known spell
    JSR EnterMagicMenu_Cast
    JMP EnterMagicSubMenu
    
  CannotEnterMagic:
    JSR PlaySFX_Error
    LDA #1
    STA cursor               ; put cursor on Learn to suggest learning a spell first...
    JMP NoLocal_MagicSubMenuLoop
    
EnterMagicMenu_Redraw:
    PLA 
    STA submenu_targ
    PLA ; so many jumps now... need this to not be stuck pressing B in the submenu to exit
    PLA
    JSR DrawMagicMenu
    JSR TurnMenuScreenOn_ClearOAM  ; clear OAM and turn the screen on    
    JMP EnterMagicMenu_PrepareCursor
    
EnterMagicMenu_Cast:    
    LDA #0                    ; otherwise.... (they have magic)
    STA joy                   ; clear joypad
    STA joy_prevdir           ; and previous joy directions
    LDA #1
    STA cursor_change
    
MagicMenu_Loop:
    JSR ClearOAM              ; clear OAM
    JSR DrawMagicMenuCursor   ; draw the cursor
    JSR UpdateMP    
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
    LDA item_pageswap
    CMP #1
    BEQ :+                      ; if 1, resume as normal
   
    LDA #71
    JSR DrawItemDescBox         ; print "forget this spell?"
    JSR MenuWaitForBtn_SFX
      LDA joy
      AND #$80
      BNE @ForgetSpell        ; if B was pressed, resume loop
      JSR CloseDescBox
      JMP EnterMagicMenu_Cast
      
    @ForgetSpell:  
    JSR MagicMenu_ForgetSpell   ; if A was pressed, forget the spell  
    LDA item_pageswap
    BEQ @B_Pressed              ; if item_pageswap hits 0, there's no spells left to forget, so return to the submenu
    INC item_pageswap           ; otherwise, item_pageswap was set back to 1 by the reloading of the screen, so set it back to 2
    PLA
    PLA
    JMP EnterMagicMenu_PrepareCursor
    
  : JSR UseMagic_GetRequiredMP  ; see if we have MP to cast selected spell
    BCS @HaveMP                 ; if so, skip ahead

      LDA #63                   ; otherwise...
      JSR DrawItemDescBox       ;  print "you don't have enough MP" or whatever message (description text ID=$32)
      JMP EnterMagicMenu_Cast   ;  and return to loop

  @HaveMP:
    LDA submenu_targ
    PHA
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
:   CMP #MG_FLOW
    BNE :+
      JMP UseMagic_FLOW
:   CMP #MG_EXIT
    BNE :+
      JMP UseMagic_EXIT
:   CMP #MG_LAMP
    BNE :+
      JMP UseMagic_LAMP

:   PLA
    LDA #64                 ; gets here if no match found.
    JSR DrawItemDescBox     ; print description text ("can't cast that here")
    JMP MagicMenu_Loop      ; and return to magic loop

;;;;;;;;;;;;;;;

CureSpellPotency:    
    LDA framecounter        ; use the frame counter as a make-shift pRNG
    AND #$0F                ; mask out the low bits
    ORA #$10                ; and ORA (effective range:  16-31)
    RTS

Cure2SpellPotency:
    LDA framecounter        ; same deal, but double the recovery
    AND #$1F
    ORA #$20                ; (effective range:  32-63)
    RTS

Cure3SpellPotency:
    LDA framecounter        ; same deal -- but double it again
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
    JSR Cursor_to_Index
    LDA hp_recovery
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
    JMP EnterMagicMenu_Redraw      ; to exit, re-enter (redraw) magic menu

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
  : JSR Cure3SpellPotency

   @DoHealSpell:
    STA hp_recovery         ; otherwise (pressed A), get HP recovery
    JSR Cursor_to_Index
    LDA hp_recovery
    JSR MenuRecoverHP       ; recover one 
    JSR SetStallAndWait
    JSR DrawItemTargetMenu_OneChar
    INC cursor
    LDA cursor
    CMP #4
    BNE @HealLoop
    
    JSR PlayHealSFX
    JSR UseMagic_SpendMP    ; JIGS 
    JMP @HealMenuLoop

 HealFamily_Exit:
    JMP EnterMagicMenu_Redraw      ; to exit, just re-enter magic menu

;;;;;;;;;;;;;;;;;;;;;;;

UseMagic_LIFE:
    LDA #49
    PHA
    LDA #1
    BNE UseMagicCureAilment

UseMagic_FLOW:
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
    JMP EnterMagicMenu_Redraw ; and exit by re-entering magic menu

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
  JMP EnterMagicMenu_Redraw

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
.byte $08,$08,$08

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
    
MagicMenu_ForgetSpell:
    LDX cursor
    LDA BigSpellLevel_LUT, X         ; get spell level
    STA SpellLevelIndex           ; store in this snazzy variable
    
    LDX cursor
    LDA TempSpellList, X             ; get spell ID
    BEQ @Oops
    SEC
    SBC #1                           ; subtract 1 to shift the ID to 0-based
    TAX
    INC inv_magic, X                 ; increase the amount of this spell in inventory
    AND #$0F                         ; then cut off the high bits
    TAX                              ; put in X again
    LDA ConvertSpellByteToBit_LUT, X ; convert the ID to a single bit
    STA tmp                          ; store in tmp
    
    LDA SpellLevelIndex           ; get the spell level
    CLC                        
    ADC CharacterIndexBackup         ; add the character's index
    ADC #ch_spells - ch_stats        ; and ch_spells
    TAX                              ; X is now pointing at the stat byte for this spell's level
    LDA ch_stats, X                  ; load the stat
    SEC
    SBC tmp                          ; subtract that bit
    STA ch_stats, X                  ; save it without that spell's bit  

    JSR DrawMagicMenu                ; reload the magic screen to show the spell has vanished
    JMP TurnMenuScreenOn_ClearOAM    ; clear OAM and turn the screen on
    
    @Oops:
    JMP PlaySFX_Error                ; you tried to forget a spell that doesn't exist!
    ;                                ; this really shouldn't be possible
    
    
MagicMenu_LearnSpell:
    JSR DrawLearnSpellMenu
    JSR TurnMenuScreenOn_ClearOAM
    
@LearnSpell_MainLoop:
    JSR ClearOAM                  ; clear OAM
    JSR DrawMagicLearnMenuCursor  ; draw the cursor
    JSR MenuFrame                 ; and do a frame

    LDA joy_a
    BNE @A_Pressed            ; check if A pressed
    LDA joy_b
    BNE @B_Pressed            ; and B

    JSR MoveMagicLearnMenuCursor   ; otherwise, move the cursor if a direction was pressed
    JMP @LearnSpell_MainLoop       ; and keep looping

    @B_Pressed:
    RTS                       ; if B pressed, just exit
    
    @A_Pressed:
    LDA cursor
    ASL A
    ASL A
    ASL A
    CLC
    ADC cursor_max
    STA tmp+2
    STA tmp+5
    TAX
    LDA inv_magic, X          ; check if the spell exists
    BEQ @NoSpell

    JSR PlaySFX_MenuSel 
    JSR TryLearnSpell
    BCS @LearnSpell_MainLoop   ; carry set if couldn't learn

    JMP MagicMenu_LearnSpell
    
    ;LDX tmp+5
    ;LDA inv_magic, X         ; check if more copies of the spell exist
    ;BEQ MagicMenu_LearnSpell ; if not, re-draw screen to remove it
    ;JMP @LearnSpell_MainLoop       ; and keep looping

    @NoSpell:
    JSR PlaySFX_Error
    JMP @LearnSpell_MainLoop       ; and keep looping

   
DrawLearnSpellMenu:    
    LDA #0
    STA $2001                      ; turn off PPU
    STA menustall                  ; clear menustall
    STA descboxopen                ; and mark description box as closed
    
    JSR ClearNT
    
    LDA #$12
    JSR DrawMainItemBox          ; 
    LDA #$13
    JSR DrawMainItemBox          ; Draw the two learning menu boxes
    
    LDA #$07
    JSR DrawMainItemBox             
    DEC dest_y
    LDA #7
    JSR DrawCharMenuString         ; draw the character's name
    
    LDA #$11
    JSR DrawMainItemBox            ; sub menu box
    DEC dest_y
    LDA #11
    STA dest_x
    
;    LDA item_pageswap
;    BEQ @Page1Title
;    CMP #1
;    BEQ @Page2Title
;    CMP #2
;    BEQ @Page3Title
    
;    @Page4Title:
;    LDA #75
;    JMP :+
    
;    @Page3Title:
;    LDA #74
;    JMP :+
    
;    @Page2Title:
;    LDA #73
;    JMP :+
    
;    @Page1Title:
;    LDA #72

    ;; JIGS -- this is why organizing your text string tables is good!
    LDA #72
    CLC
    ADC item_pageswap

    JSR DrawMenuString         ; draw White / Black magic submenu
  
    LDA item_pageswap
    BEQ @Page1
    CMP #1
    BEQ @Page2
    CMP #2
    BEQ @Page3
    
   @Page4:
    LDX #$30
    JMP :+
    
   @Page3:
    LDX #$20
    JMP :+
    
   @Page2:
    LDX #$10
    JMP :+
    
   @Page1:
    LDX #0
  : STX MMC5_tmp+2
    LDY #0
    STY MMC5_tmp        ; spell level counter
    STY MMC5_tmp+1      ; left or right counter
  
   @Loop: 
    LDX MMC5_tmp+2
    LDA inv_magic, X
    BEQ @SkipOne
    
    STA tmp             ; save for PrintNumber
    
    TXA                 ; turn X into spell ID
    STA MMC5_tmp+2
    CLC
    ADC #ITEM_MAGICSTART
    
    STA bigstr_buf+1, Y ; spell ID in 2nd slot
    LDA #02
    STA bigstr_buf, Y   ; item name code in 1st slot
    LDA #$FF
    STA bigstr_buf+2, Y ; space
    LDA #01
    STA bigstr_buf+5, Y ; double line break
    
    JSR PrintNumber_2Digit
    LDA format_buf-1     ; numbers!
    STA bigstr_buf+4, Y  ; tens 
    LDA format_buf-2
    STA bigstr_buf+3, Y  ; ones
    
    TYA
    CLC
    ADC #6
    TAY
    
   @ResumeLoop:
    INC MMC5_tmp+2     ; inc the backed up X counter
    INC MMC5_tmp
    LDA MMC5_tmp
    CMP #8             ; if spell level counter is over 8, end inner loop and reset to 0
    BNE @Loop
    
    LDA #0             ; put the null terminator in
    STA MMC5_tmp       ; reset spell counter
    STA bigstr_buf, Y

    LDA #<(bigstr_buf)    ; fill text_ptr with the pointer to our item names in the big string buffer
    STA text_ptr
    LDA #>(bigstr_buf)
    STA text_ptr+1
    
    INC MMC5_tmp+1
    LDA MMC5_tmp+1
    CMP #2
    BEQ @DrawRightSide
    
   @DrawLeftSide:
    LDA #04 
    STA dest_x 
    LDA #05
    STA dest_y
    JSR DrawComplexString  ; Draw all the item names
    
    LDY #0
    JMP @Loop
    
    @DrawRightSide:
    LDA #20
    STA dest_x 
    JSR DrawComplexString  ; Draw all the item names
    
    LDA #03
    STA dest_x
    LDA #76
    JSR DrawMenuString     ; draw left side orbs
    
    LDA #19
    STA dest_x
    LDA #76
    JMP DrawMenuString     ; draw right side orbs
    
   @SkipOne:
    LDA #$C2  
    STA bigstr_buf, Y
    STA bigstr_buf+1, Y
    STA bigstr_buf+2, Y
    STA bigstr_buf+3, Y
    STA bigstr_buf+4, Y
    STA bigstr_buf+5, Y
    STA bigstr_buf+6, Y
    LDA #01
    STA bigstr_buf+7, Y
    TYA
    CLC
    ADC #8
    TAY
    JMP @ResumeLoop

    
    
    
TryLearnSpell:
    LDX CharacterIndexBackup      ; load index 
    LDA ch_class, X               ; use it to get his class
    AND #$0F                      ; cut off high bits (sprite)
    ASL A                         ; double it (2 bytes per pointer)
    TAX                           ; and put in X for indexing

    LDA lut_MagicPermisPtr, X     ; get the pointer to this class's
    STA tmp                       ;    magic permissions table
    LDA lut_MagicPermisPtr+1, X   ; put that pointer in (tmp)
    STA tmp+1

    LDA tmp+2           ; load stored magic ID

    AND #$07            ; get low 3 bits.  This will indicate the bit to use for permissions
    STA tmp+3           ; store it in tmp+3 for future use

    LDA tmp+2           ; get the magic ID
    LSR A               ; divide by 8 (gets the level of the spell)
    LSR A
    LSR A
    
    STA SpellLevelIndex ;; JIGS - save this for learning the spell later!
    
    TAY                 ; put spell level in Y
    LDA (tmp), Y        ; use it as index to get the desired permissions byte
    STA tmp+4           ; store permissions byte in tmp+4 for future use

    LDX tmp+3           ; get required bit position
    LDA lut_BIT, X      ; use as index in the BIT lut to get the desired bit
    AND tmp+4           ; AND with permissions byte
    BEQ @HasPermission  ;  if result is zero, they have permission to learn

        LDA #68            ; 
        JSR DrawItemDescBox    ; "Can't learn that"
        ;JSR MenuWaitForBtn
        SEC
        RTS

  @HasPermission:
   INC tmp+2 ; since spells are stored +1 - this also allows Cure to be learned, since otherwise it would CMP/BEQ at 0...
   
   LDA tmp+2            ; spell ID
   LDX #0
  @KnownSpellsLoop:
    CMP TempSpellList, X
    BEQ @AlreadyKnow
    INX 
    CPX #24
    BNE @KnownSpellsLoop
   
    LDX SpellLevelIndex ; use it
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
   
    LDA #70            ; if no empty slot found...
    JSR DrawItemDescBox    ; "That level is full"
    ;JSR MenuWaitForBtn
    SEC
    RTS
    

  @AlreadyKnow:
    LDA #69            ; if they already know the spell...
    JSR DrawItemDescBox    ; "You already know that"
    ;JSR MenuWaitForBtn
    SEC
    RTS

  @FoundEmptySlot:       ;  All conditions are met
    DEC tmp+2
    LDA tmp+2
    AND #$0F       ; chop off the high bits, so that the LUT only needs to be 16 bytes long
    TAX
    LDA ConvertSpellByteToBit_LUT, X ; $2A is the same as $0A
    STA tmp+2

    ;; Spell Level + Character Index + Start of spell list
    
    LDA SpellLevelIndex
    CLC
    ADC CharacterIndexBackup
    TAX
    LDA ch_spells, X
    ORA tmp+2
    STA ch_spells, X
    
    LDX tmp+5
    DEC inv_magic, X     ; and remove it from inventory
    
    LDA submenu_targ             ; re-load the magic list!
    JSR Magic_ConvertBitsToBytes
    
    LDA #1                ; set menustall to nonzero (indicating we need to stall)
    STA menustall
    LDA #$08              ; draw main/item box ID $08  (the description box)
    JSR DrawMainItemBox
    INC descboxopen       ; set descboxopen to a nonzero value to mark the description box as open
    LDA #77
    JSR DrawCharMenuString  ; draw "Learned the spell!" text in the box
    JSR MenuWaitForBtn
    JSR CloseDescBox
    CLC
    RTS                  ; and exit!
    
    
SpellLevel_LUT:
.byte $00,$03,$06,$09,$0C,$0F,$12,$15
;; JIGS - offset for where to look for empty spell slots    





    



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Enter Item Menu  [$B11D :: 0x3B12D]
;;
;;    Pretty self explanitory.  Enters the item menu, returns when player
;;  exits item menu
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


EnterItemMenu:
    LDA backup_cursor
    STA cursor
    LDA #18
    STA cursor_max
        
    LDA #0
    STA $2001           ; turn the PPU off
    STA menustall       ; zero menustall (don't want to stall for drawing the screen for the first time)
    STA descboxopen     ; indicate that the descbox is closed
    JSR ClearNT         ; wipe the NT clean
                        ;  then start drawing the item menu
    LDA #$09         
    JSR DrawMainItemBox                        
    
    LDA #$07               ; draw mainitem box ID 7 (the "ITEM" title box)
    JSR DrawMainItemBox
    DEC dest_y
    
    LDA item_pageswap      ; if offset is 0, draw items, if 1, draw quest items
    BNE :+
    LDA #2              
    JSR DrawMenuString     ;  and draw it and return    
    JMP :++
    
  : LDA #3                 ; draw QUEST in box
    JSR DrawMenuString     ;  and draw it and return   
  
  : LDA #$11               ; draw submenu box
    JSR DrawMainItemBox
    DEC dest_y
    LDA #66
    JSR DrawMenuString
  
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
  
    STA joy            ; clear joy data
    STA joy_prevdir    ; and previous joy directionals
  
    JSR FillItemBox        ; Transfer items to item_box and fill bigstr_buf with item names
    BCC @DrawItems         ; if the player has no inventory...
      JSR TurnMenuScreenOn_ClearOAM
      LDA #22
      JSR DrawItemDescBox     ; draw the "You have nothing" description text
      LDA item_pageswap
      BEQ :+
        LDA #0
        STA cursor
        LDA #2
        STA cursor_max
        JMP ItemMenu_Loop
      
    : LDA #1
      STA cursor
      JMP ItemMenu_Loop
      
      ;JMP MenuWaitForBtn_SFX  ; then just wait for A or B to be pressed -- then exit
    
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
    JSR ClearOAM            ; clear OAM
    JSR DrawItemMenuCursor  ; draw the cursor where it needs to be
    JSR MenuFrame           ; do a frame

    LDA joy_a               ; see if A has been pressed
    BNE @APressed           ; if it has... jump ahead
    CMP joy_b               ; otherwise check for B
    BNE @Exit               ; and exit if B pressed
    LDA joy_select
    BNE @SelectPressed
    
    JSR MoveItemMenuCurs    ; neither button pressed... so move cursor if a direction was pressed
    JMP ItemMenu_Loop       ; then continue the loop
  
  @SelectPressed:
    LDA cursor
    BEQ @SwapToItems        ; check if cursor is on "Use" or "Quest Items" option
    CMP #01
    BEQ @SwapToQuest        
    
    LDA item_pageswap       ; if its not, then select was pressed, so check the page number
    BEQ @SwapToQuest         
      
      @SwapToItems:
       LDA #02
       STA backup_cursor   ; set cursor to first item
       STA cursor        
       LDA item_pageswap   ; check the page number in case select was NOT pressed
       BEQ ItemMenu_Loop   ; if its 0, just re-enter loop with new cursor coordinates
       LDA #0
       STA item_pageswap   ; otherwise, swap the page and reload the item_box
       JMP EnterItemMenu
   
   @SwapToQuest:
    LDA #02
    STA backup_cursor   ; set cursor to first item
    STA cursor           
    LDA item_pageswap
    BNE ItemMenu_Loop
    LDA #1
    STA item_pageswap
    JMP EnterItemMenu    
  
  @Exit:
    RTS
    
  @APressed:
    LDA #0
    STA backup_cursor_targ
    LDA cursor                 ; if A is pressed while the cursor is on an option
    BEQ @SelectPressed         ; do that option (almost the same as pressing select)
    CMP #01
    BEQ @SelectPressed
    
    JSR PlaySFX_MenuSel        ; play the menu selection sound effect
    LDX cursor                 ; put the cursor in X
    STX backup_cursor
    DEX
    DEX                        ; decrement X to save 4 bytes in the jump table
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

.word UseItem_Bad         ; Item Start
.word UseItem_Heal        ; Heal
.word UseItem_XHeal       ; X-Heal
.word UseItem_Ether       ; Ether
.word UseItem_Elixir      ; Elixir
.word UseItem_Pure        ; Pure
.word Useitem_FlowClock   ; Flowing Clock
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
    ;LDA #0
    ;STA item_bottle                 ; remove the bottle from inventory
    DEC item_bottle
    LDY #OBJID_FAIRY
    JSR LongCall
    .word ShowMapObject
    .byte BANK_DIALOGUE
    ;JSR ShowMapObject               ; mark the fairy object as visible
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
    LDA #53                 
    JSR DrawItemDescBox
    JSR MenuWaitForBtn_SFX
    LDA joy
    AND #$80
    BEQ :+    

    LDA mapflags            ; ensure we're on the overworld
    LSR A                   ;  shift SM flag into C
    BCC @Use                ;  if set (in standard map), can't use tent here

    LDA tileprop_now
    CMP #TP_SPEC_USESAVE    ; if its a safe tile to save on...
    BNE @CantUse
    
   @Use: 
    DEC item_tent           ; otherwise... remove 1 tent from the inventory
    LDA #30
    JSR MenuRecoverPartyHP  ; give 30 HP to the whole party
    JSR PlayHealSFX
    LDA #54 
    JSR MenuSaveConfirm     ; and bring up confirm save screen (with description text $1A)
  : JMP EnterItemMenu       ; then re-enter item menu (need to re-enter, because screen needs full redrawing)

  @CantUse:
    LDA #57                 ; "cannot sleep here!"
    JSR DrawItemDescBox
    JMP ItemMenu_Loop       ; and return to loop

;;;;;;;;;;;;;;;;;;;;
;;
;;  UseItem_Cabin  [$B2A1 :: 0x3B2B1]
;;
;;;;;;;;;;;;;;;;;;;;

UseItem_Cabin:
    LDA #53               
    JSR DrawItemDescBox
    JSR MenuWaitForBtn_SFX
    
    LDA joy
    AND #$80
    BEQ :+    
    
    LDA mapflags            ; exactly the same as tents... except....
    LSR A
    BCC @Use                ;  if set (in standard map), can't use here

    LDA tileprop_now
    CMP #TP_SPEC_USESAVE    ; if its a safe tile to save on...
    BNE @CantUse
    
   @Use: 
    DEC item_cabin          ; remove cabins from inventory instead of tents
    LDA #60                 ;  recover 60 HP instead of 30
    JSR MenuRecoverPartyHP
    JSR PlayHealSFX
    LDA #54    
    JSR MenuSaveConfirm
  : JMP EnterItemMenu
  @CantUse:
    LDA #57                 ; "cannot sleep here!"
    JSR DrawItemDescBox
    JMP ItemMenu_Loop

;;;;;;;;;;;;;;;;;;;;
;;
;;  UseItem_House  [$B2BE :: 0x3B2CE]
;;
;;;;;;;;;;;;;;;;;;;;

UseItem_House:
    LDA #56               
    JSR DrawItemDescBox
    JSR MenuWaitForBtn_SFX
    
    LDA joy
    AND #$80
    BEQ :+    

    LDA mapflags            ; make sure we're on the overworld
    LSR A                   ;  Get SM flag, and shift it into C
    BCC @Use                ;  if set (in standard map), can't use here

    LDA tileprop_now
    CMP #TP_SPEC_USESAVE    ; if its a safe tile to save on...
    BNE @CantUse

   @Use:
    DEC item_house          ; otherwise... remove a house from our inventory
    LDA #120
    JSR MenuRecoverPartyHP  ; give the whole party 120 HP
    JSR MenuRecoverPartyMP  ; JIGS - recover MP before saving
    JSR PlayHealSFX
    
    LDA #55
    JSR MenuSaveConfirm     ; bring up the save confirmation screen.  (description text $1E)
:   JMP EnterItemMenu         ; then, whether they saved or not, re-enter item menu

  @CantUse:
    LDA #57 
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

  ;; can't make these labels local because UseItem_Pure hijacks one of the labels ;_;

UseItem_Heal:
    LDA #HEAL_POTENCY
    STA hp_recovery
    BNE DrawHealMenu

UseItem_XHeal:    
    LDA #XHEAL_POTENCY
    STA hp_recovery
    
DrawHealMenu:
    JSR DrawItemTargetMenu     ; Draw the item target menu (need to know who to use this heal potion on)
    LDA #44 
    JSR DrawItemDescBox        ; open up the description box with text ID $20

   @UseItem_Heal_Loop:
    JSR ItemTargetMenuLoop     ; run the item target loop.
    BCS @UseItem_Exit          ; if B was pressed (C set), exit this menu

    JSR Cursor_to_Index
    JSR CheckDeadStone
    BCS @CantUse
    
    LDA ch_curhp, X            ; make sure not to waste potions!
    CMP ch_maxhp, X            ; if not equal, then either the character has MORE current HP than max... or less. 
    BNE :+                     ; going to assume LESS, so go use the potion
       LDA ch_curhp+1, X       ; otherwise, its equal, so check high bytes
       CMP ch_maxhp+1, X
       BEQ @CantUse            ; if those are also equal, there's no point in using a potion
       
  : LDA hp_recovery
    CMP #HEAL_POTENCY
    BNE :+ 
        LDA item_heal
        BEQ @UseItem_Exit
        DEC item_heal          ; then remove a heal potion from the inventory
        JMP @DoHeal
  : LDA item_x_heal
    BEQ @UseItem_Exit          ; stop if there's no more to use!
    DEC item_x_heal
    
   @DoHeal: 
    LDA hp_recovery            ; otherwise.. can use!
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
    STA cursor2
    
UseItem_Ether_2:
    JSR DrawMPTargetMenu       ; draw target menu
    LDA #45
    JSR DrawItemDescBox        ; print relevent description text 
    
    LDA backup_cursor_targ
    STA cursor
    
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
    ADC cursor2                ; cursor2 is 0, 1, 2, 3, 4, 5, 6, 7
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
    LDA #AIL_POISON
    STA hp_recovery
    LDA #47 
    PHA
    BNE :+

Useitem_FlowClock:
    LDA #AIL_STOP
    STA hp_recovery
    LDA #48 
    PHA
    BNE :+

UseItem_PhoenixDown:
    LDA #AIL_DEAD
    STA hp_recovery
    LDA #49
    PHA
    BNE :+    

UseItem_Eyedrop:    
    LDA #AIL_DARK
    STA hp_recovery            ; uses this as safe tmp storage
    LDA #51
    PHA

UseAilmentCuringItem:    
  : JSR DrawItemTargetMenu     ; draw target menu
    PLA
    JSR DrawItemDescBox        

  @Loop:
    JSR ItemTargetMenuLoop     ; do the target menu loop
    BCS @Exit                  ; if they pressed B (C set), exit
    
    LDX hp_recovery            ; use the ailment to cure to get the item ID from a lut
    LDY UseAilmentCuringItemLUT, X
    LDA items, Y               
    BEQ @Exit                  ; exit if you ran out
   
   @TryUse:  
    STX tmp
    JSR CureOBAilment          ; then try to cure it
    BCS @CantUse               ; if we couldn't... can't use this item

    JSR PlayHealSFX

    LDX hp_recovery            ; do this little thing again
    LDY UseAilmentCuringItemLUT, X
    LDA items, Y
    SEC
    SBC #1
    STA items, Y               ; and this time decrease the amount of the item
    CPY #PHOENIXDOWN           ; then check if it was a phoenix down
    BNE :+                     ; if not, skip this
      JSR Cursor_to_Index        
      LDA #1      
      STA ch_curhp, X          ; give the character 1 HP
        
  : JSR SetStallAndWait
    JSR DrawItemTargetMenu_OneChar
    JMP @Loop
    
   @Exit: 
    JMP EnterItemMenu          ; before re-entering the item menu (redrawing item menu)

  @CantUse:
    JSR PlaySFX_Error          ; if can't use... give the error sound effect
    JMP @Loop                  ;  and keep looping

UseAilmentCuringItemLUT:
    .byte 0, PHOENIXDOWN, FLOWCLOCK, 0, PURE, 0, 0, 0, EYEDROPS
    ;     0, 1,         , 2   , 3, 4,  , 5, 6, 7, 8


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
    ;LDA #0
    LDA backup_cursor_targ
    STA cursor      ; reset the cursor to zero
    LDA #4
    STA cursor_max 
    
  @Loop:
    LDA #0
    STA joy_a       ; clear joy_a and joy_b so that a button press
    STA joy_b       ;  will be recognized

    JSR ClearOAM               ; clear OAM
    LDA item_pageswap
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
    STA backup_cursor_targ
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
    LDA #0
    STA joy_a       ; clear joy_a and joy_b so that a button press
    STA joy_b       ;  will be recognized

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
    STA backup_cursor_targ
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
    
    
    
MoveMPMenuCursor:    
    LDA joy                      ; get joypad state
    AND #$0F                     ; isolate directional buttons
    CMP joy_prevdir              ; compare to previous buttons to see if any have been pressed/released
    BEQ @Exit                    ; if there's no change, just exit
    STA joy_prevdir              ;  otherwise record changes
    CMP #0                       ; see if buttons have been pressed (rather than released)
    BEQ @Exit                    ; if no buttons pressed, just exit

    CMP #$04               ; now see which button was pressed
    BCS @UpDown            ; check for up/down
    CMP #$01               ; otherwise, check for left/right
    BNE @Left

  @Right:
     INC cursor
     LDA cursor
     CMP #4
     BNE @Done_X
     LDA #0
     BEQ @Done_X

  @Left:                 
     DEC cursor
     LDA cursor
     CMP #$FF
     BNE @Done_X
     LDA #03
     JMP @Done_X
   
@UpDown:         ; if we pressed up or down... see which
    BNE @Up

 @Down:                  
    INC cursor2
    LDA cursor2
    CMP #8
    BNE @Done_Y
    LDA #0
    BEQ @Done_Y
    
  @Up:                    
    DEC cursor2
    LDA cursor2
    CMP #$FF
    BNE @Done_Y
    LDA #08
    
  @Done_Y:
    STA cursor2
    RTS
    
  @Done_X:
    STA cursor  
  @Exit:
    RTS
    
    
    
    
    
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
    
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Draw Item Target Cursor  [$B3EE :: 0x3B3FE]
;;
;;     Draws the cursor for the item target menu
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


DrawItemTargetCursor:
    LDX cursor           ; put the cursor in X
    LDA @lut, X          ; use it to index our LUT
    STA spr_y            ; that lut is the X coord for cursor
    LDA #$30
    STA spr_x            ; Y coord is always $68
    JMP DrawCursor       ; draw it, and exit

  @lut:
    .BYTE $40,$58,$70,$88
    
    
    
DrawElixirTargetCursor:
    LDX cursor           ; put the cursor in X
    LDA @lut, X          ; use it to index our LUT
    STA spr_y            ; that lut is the X coord for cursor
    LDA #$30
    STA spr_x            ; Y coord is always $68
    JMP DrawCursor       ; draw it, and exit

  @lut:
    .BYTE $28,$48,$68,$88    
    
    
DrawMPTargetCursor:

    LDX cursor2           ; put the cursor in X
    LDA @Y_lut, X          ; use it to index our LUT
    STA spr_y            ; that lut is the X coord for cursor
    LDX cursor
    LDA @X_lut, X
    STA spr_x            ; Y coord is always $68
    JMP DrawCursor       ; draw it, and exit

  @Y_lut:
    .BYTE $28,$38,$48,$58,$68,$78,$88,$98
  
  @X_lut:
    .BYTE $38,$60,$88,$B0  

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Draw Item Target Menu  [$B400 :: 0x3B410]
;;
;;    Draws the item target menu (the menu that pops up when you select a heal potion
;;  and that kind of thing -- where you select who you want to use it on)
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

ScreenOff_ClearNT:
    LDA #0
    STA $2001            ; turn the PPU off
    STA menustall        ; and disable menu stalling
    JMP ClearNT          ; wipe the NT clean


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
    LDA #$0A 
    JSR DrawMainItemBox
    LDA #3
    STA submenu_targ
   @Loop: 
    JSR DrawItemTargetMenu_OneChar
    DEC submenu_targ
    BPL @Loop
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
    LDA #$10 
    JSR DrawMainItemBox
    LDA #3
    STA submenu_targ
   @Loop:
    JSR DrawItemTargetMenu_Elixir_OneChar
    DEC submenu_targ
    BPL @Loop
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
    JSR CheckForMP
    BEQ :+
    LDA #16
    JSR DrawCharMenuString          ; draw MP for each character
  : RTS                             ; or just skip it if they have none
    
DrawMPTargetMenu:
    JSR ScreenOff_ClearNT
    LDA #$0B
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


StatusMenuAttributes:
.byte $FA,$F5
.byte $AA,$55
.byte $AA,$55
.byte $AA,$55

EnterStatusMenu:
    LDA #0
    STA $2001               ; turn off the PPU
    LDA #0
    STA menustall           ; disable menu stalling
    JSR ClearNT             ; clear the NT

    ;LDA #$02                ; draw status box 0
    ;JSR DrawMainItemBox
    ;LDA #19
    ;INC dest_x
    
    LDA #>$23C0
    STA $2006
    LDA #<$23C0
    STA $2006
    
    LDX #8
    LDY #4
   @AttributeLoop:
    LDA StatusMenuAttributes-1, X
    STA $2007
    DEY
    BNE @AttributeLoop
    LDY #4
    DEX
    BNE @AttributeLoop
    
    LDA #$0F
    STA cur_pal+6
    LDA #$35
    STA cur_pal+9
    ;LDA #$38
    ;STA cur_pal+10
    LDA #$15
    STA cur_pal+11
  
    
    LDA #4
    STA dest_y
    LDA #20
    STA dest_x
    LDA #8
    STA dest_wd
    LDA #10
    STA dest_ht               ; 8 tiles wide and 10 tall
    LDA #0 
    STA tmp+2                 ; and no additive!
    
    LDA #<statusbox_scrollwork  ; get the pointer to the orb box scrollwork
    STA image_ptr            
    LDA #>statusbox_scrollwork  
    STA image_ptr+1          
    JSR DrawImageRect        ; draw the image rect

@ReenterStatusMenu:
    LDA #02
    STA dest_x
    LDA #04
    STA dest_y
    LDA #19
    JSR DrawCharMenuString

    LDA #$03                ; and so on
    JSR DrawMainItemBox
    LDA #20
    INC dest_x
    JSR DrawCharMenuString
    
    LDA #$04                ; and so on
    JSR DrawMainItemBox
    LDA #21
    INC dest_x
    JSR DrawCharMenuString
    
    JSR ClearOAM            ; clear OAM

    LDA #$B8
    STA spr_x
    LDA #$3C
    STA spr_y

    LDA submenu_targ        ; get target character ID
    ROR A
    ROR A
    ROR A
    AND #$C0                ; shift to make ID a usable index
    STA CharacterIndexBackup ;; JIGS - adding this
    JSR TurnMenuScreenOn    ; turn the screen on
    
   @Loop: 
    JSR ClearOAM
    LDX CharacterIndexBackup 
    LDA ch_ailments, X
    AND #AIL_DEAD | AIL_STOP
    BNE @NormalPose
    
    LDA playtimer+1         ; every other second
    AND #01
    BEQ @NormalPose
    
    LDA ch_ailments, X      ; set pose to cheer
    ORA #$80
    STA ch_ailments, X
    BNE @DrawSprite

   @NormalPose:             ; reset pose to normal
    LDA ch_ailments, X
    AND #$0F
    STA ch_ailments, X
   
   @DrawSprite:   
    TXA
    JSR DrawOBSprite        ; then draw this character's OB sprite
    JSR MenuFrame
    JSR @MoveCursorLeftRight
    
    LDA joy_a
    ORA joy_b
    BEQ @Loop                     ; check if A pressed  

@ResetStatusMenuCharPose:    
    LDX CharacterIndexBackup 
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
    LDA #0                      ; Turn off the PPU
    STA $2001
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
    ;JSR PlayHealSFX

    LDA tmp                     ; restore the HP recovery ammount in A, before exiting
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
    ADC #$02           ; add 2 to it
    CMP #18            ; there are 17 (counting 0 as 1!) cursor positions
    BEQ @DownWrapLeft  ; if its 18, its 1 over
    CMP #19          
    BCS @DownWrapRight
    BCC @Done    
    
    ; otherwise we need to wrap to top of the column
 @DownWrapLeft:
    LDA #3             ; by just setting the proper cursor #
    JMP @Done          ; this wraps to the second item in the list
    
 @DownWrapRight:
    LDA #0             ; this wraps to the "Use" option
    JMP @Done

 @Up:
    LDA cursor         ; to move up...
    SEC
    SBC #$02           ; subtract 2 from the cursor
    BPL @Done          ; if we're still above zero, we're done.  Otherwise...

    LDA cursor         ; re-load the cursor into A
    CMP #01
    BEQ @UpWrapLeft
    
 @UpWrapRight:         ; to wrap to bottom of column...
    LDA #17
    JMP @Done          ; then we're done
    
 @UpWrapLeft:         
    LDA #15
    JMP @Done          

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
    CMP cursor_max        ; if you have nothing, cursor max is set to 2 instead of 18
    BCC :+                ; so double-check that the cursor is within bounds (the submenu only)
     SBC #1               ; no need to set C if it didn't branch on Carry Clear
     BCC @Done            ; then carry is cleared by the addition...! So it always branches.
    
  : STA cursor            ; write the new cursor value
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
    JSR MenuFrame           ; do a frame
    LDA joy_a               ;  check A and B buttons
    ORA joy_b
    BEQ MenuWaitForBtn_SFX  ;  if both are zero, keep looping.  Otherwise...
    LDA #0
    STA joy_a               ; clear both joy_a and joy_b
    STA joy_b
    JMP PlaySFX_MenuSel     ; play the MenuSel sound effect, and exit


MenuWaitForBtn:
    JSR MenuFrame           ; exactly the same -- only no call to PlaySFX_MenuSel at the end
    LDA joy_a
    ORA joy_b
    BEQ MenuWaitForBtn
    LDA #0
    STA joy_a
    STA joy_b
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

    JSR HushTriangle
    ;; JIGS ^ every frame, gosh    
    
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
    STA joy_start
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

MoveMagicLearnMenuCursor:
    LDA joy                      ; get joypad state
    AND #$0F                     ; isolate directional buttons
    CMP joy_prevdir              ; compare to previous buttons to see if any have been pressed/released
    BEQ @Exit                    ; if there's no change, just exit
    STA joy_prevdir              ;  otherwise record changes
    CMP #0                       ; see if buttons have been pressed (rather than released)
    BEQ @Exit                    ; if no buttons pressed, just exit

    CMP #$04               ; now see which button was pressed
    BCS @UpDown            ; check for up/down
    CMP #$01               ; otherwise, check for left/right
    BNE @Left
    
    @Right:
    INC cursor
    LDX cursor
    LDA @CursorSwapPage_LUT, X
    BEQ @SwapPageRight
    
    CMP #$FF
    BNE @Done
    
    DEC cursor
    
    @Done:
    JMP CloseDescBox_Sfx 
    
    @Exit:
    RTS ; do this if no buttons were pressed, so as not to close the message box
    
    @Left:
    DEC cursor
    LDX cursor
    LDA @CursorSwapPage_LUT, X
    CMP #1
    BEQ @SwapPageLeft
    
    LDA cursor
    CMP #$FF
    BNE @Done
    
    INC cursor
    JMP CloseDescBox_Sfx 
    
    @SwapPageLeft:
    DEC item_pageswap
    JMP :+
    
    @SwapPageRight:
    INC item_pageswap
    
  : PLA
    PLA
    JSR PlaySFX_MenuMove
    JMP MagicMenu_LearnSpell

    @CursorSwapPage_LUT:
    ; traveling right, swap when it hits 0, stop at $FF
    ; traveling left,  swap when it hits 1
    ;    ; page 1  ; page 2  ; page 3  ; page 4  ; 
    .byte $02, $01, $00, $01, $00, $01, $00, $01, $FF
    
    @UpDown:         ; if we pressed up or down... see which
    BNE @Up

    @Down:      
    INC cursor_max
    LDA cursor_max
    CMP #8
    BCC @UpDownDone
    
    LDA #0
    STA cursor_max
    JMP CloseDescBox_Sfx 
    
    @Up:
    DEC cursor_max
    LDA cursor_max
    CMP #$FF
    BNE @UpDownDone
    
    LDA #7
    STA cursor_max
    @UpDownDone:
    JMP CloseDescBox_Sfx 
 
 
 
 
 
 
 
    

MoveMagicSubMenuCursor:
    LDA joy                      ; get joypad state
    AND #$03                     ; isolate left/right directional buttons
    CMP joy_prevdir              ; compare to previous buttons to see if any have been pressed/released
    BEQ MoveMagicMenuCursor_Exit ; if there's no change, just exit
    STA joy_prevdir              ;  otherwise record changes
    CMP #0                       ; see if buttons have been pressed (rather than released)
    BEQ MoveMagicMenuCursor_Exit ; if no buttons pressed, just exit

    CMP #$01               ; otherwise, check for left/right
    BNE @Left

    @Right:
    INC cursor
    LDA cursor
    CMP #3
    BNE @Done
    LDA #0
    
    @Done:
    STA cursor
    JMP PlaySFX_MenuMove
    
    @Left:
    DEC cursor
    LDA cursor
    CMP #$FF
    BNE @Done
    LDA #2
    JMP @Done
    
MoveMagicMenuCursor_Exit:
    RTS

MoveMagicMenuCursor:
    LDA joy                      ; get joypad state
    AND #$0F                     ; isolate directional buttons
    CMP joy_prevdir              ; compare to previous buttons to see if any have been pressed/released
    BEQ MoveMagicMenuCursor_Exit ; if there's no change, just exit
    STA joy_prevdir              ;  otherwise record changes
    CMP #0                       ; see if buttons have been pressed (rather than released)
    BEQ MoveMagicMenuCursor_Exit ; if no buttons pressed, just exit
    
    INC cursor_change

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
   LDA #0     
   STA cursor
   JSR @CheckCursor
   BEQ @Right
   JMP CloseDescBox_Sfx
   
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
    STA cursor
    JSR @CheckCursor       
    BEQ @Up         
    JMP CloseDescBox_Sfx   
    
   ;;;;;;
  ;;  A little mini local subroutine here that checks to see if the cursor
  ;;    is on a spell or an empty slot.
  ;;
  ;;  Result is store in Z on exit.  Z set = cursor on blank slot
  ;;  Z clear = cursor is on actual spell
  ;;;;;;

  @CheckCursor:
    LDX cursor
    LDA TempSpellList, X
UpdateMP_Exit:    
    RTS              ; then exit.
    
UpdateMP:    
    LDA item_pageswap
    CMP #2
    BEQ UpdateMP_Exit         ; don't display MP if forgetting spells  
    
    LDA #80
    ASL A                   ; double A (pointers are 2 bytes)
    TAX                     ; put in X to index menu string pointer table
    LDA lut_MenuText, X
    STA text_ptr
    LDA lut_MenuText+1, X   ; load pointer from table, store to text_ptr  (source pointer for DrawComplexString)
    STA text_ptr+1
    
    LDY #0
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
  .BYTE $58,$18,      $58,$48
  .BYTE $58,$78,      $58,$A8

lut_MainMenuCursor_Y:           ; Y coord only... X coord is hardcoded
   .BYTE   $70,$80,$90,$A0,$B0,$C0,$D0

lut_ItemMenuCursor:
  .BYTE   $50,$10,   $80,$10
  .BYTE   $08,$28,   $80,$28
  .BYTE   $08,$38,   $80,$38
  .BYTE   $08,$48,   $80,$48
  .BYTE   $08,$58,   $80,$58
  .BYTE   $08,$68,   $80,$68
  .BYTE   $08,$78,   $80,$78
  .BYTE   $08,$88,   $80,$88
  .BYTE   $08,$98,   $80,$98



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
  .BYTE   $18,$28,   $60,$28,   $A8,$28
  .BYTE   $18,$38,   $60,$38,   $A8,$38
  .BYTE   $18,$48,   $60,$48,   $A8,$48
  .BYTE   $18,$58,   $60,$58,   $A8,$58
  .BYTE   $18,$68,   $60,$68,   $A8,$68
  .BYTE   $18,$78,   $60,$78,   $A8,$78
  .BYTE   $18,$88,   $60,$88,   $A8,$88
  .BYTE   $18,$98,   $60,$98,   $A8,$98

  

DrawMagicSubMenuCursor:
    LDX cursor                   ; get current cursor and double it (loading X,Y pair)
    LDA lut_MagicSubMenuCursor, X    ; load X,Y pair into spr_x and spr_y
    STA spr_x
    LDA #$10
    STA spr_y
    JMP DrawCursor               ; then draw the cursor

lut_MagicSubMenuCursor:
  .BYTE   $50, $80, $B8
  
  
DrawMagicLearnMenuCursor:
    LDA cursor                 
    AND #$01
    TAX
    LDA lut_MagicLearnCursor_X, X  
    STA spr_x

    LDX cursor_max
    LDA lut_MagicLearnCursor_Y, X
    STA spr_y
    JMP DrawCursor               ; then draw the cursor

lut_MagicLearnCursor_X:
  .BYTE   $08
  .BYTE   $88
    
lut_MagicLearnCursor_Y:
  .BYTE   $28
  .BYTE   $38
  .BYTE   $48
  .BYTE   $58
  .BYTE   $68
  .BYTE   $78
  .BYTE   $88
  .BYTE   $98
  
  
  

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
    LDA #$14
    JSR DrawMainItemBox            ; timer box

DrawMainMenu_CharacterBox:
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
    
    LDA #1
    STA dest_x
    LDA #10
    STA dest_y
    LDA #65
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
    LDA #0              ; draw menu string ID=$01  (current GP, followed by " G")
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

    
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Boxes for Main/Item menus  [$BAA2 :: 0x3BAB2]
;;
;;     in groups of 4:  X, Y, width, height
;;
;;  Item menu boxes are also used for the magic menu.

lut_MainItemBoxes:
 
    ;       X   Y   wid height
    .BYTE   $01,$01,$0A,$0A ; 00 ; Main menu orb box
    .BYTE   $0B,$01,$14,$1C ; 01 ; Main Menu char stats
    .BYTE   $08,$02,$10,$0D ; 02 ; Status Menu - Name, Class, Level, Exp., Exp to Next
    .BYTE   $00,$0F,$10,$0D ; 03 ; Status Menu - main stats
    .BYTE   $10,$0F,$10,$0D ; 04 ; Status Menu - sub stats
    .BYTE   $01,$0A,$0A,$03 ; 05 ; Main menu gold box
    .BYTE   $01,$0C,$0A,$10 ; 06 ; Main menu option box
    .BYTE   $00,$01,$09,$03 ; 07 ; item title box (character name for magic screen)
    .BYTE   $00,$16,$20,$07 ; 08 ; Item description box
    .BYTE   $00,$03,$20,$13 ; 09 ; new magic menu and item box
    .BYTE   $05,$06,$16,$0E ; 0A ; Item Target Menu (HP)
    .BYTE   $03,$01,$1A,$15 ; 0B ; Item Target Menu (MP)
    .BYTE   $01,$01,$1E,$1C ; 0C ; Equip Menu ()
    .BYTE   $00,$03,$20,$14 ; 0D ; unused
    .BYTE   $02,$01,$09,$03 ; 0E ; unused
    .BYTE   $01,$16,$0C,$03 ; 0F ; unused
    .BYTE   $05,$03,$16,$13 ; 10 ; Item Target Menu (HP/MP)
    .BYTE   $09,$01,$17,$03 ; 11 ; Magic/Item title submenu
    .BYTE   $00,$03,$10,$13 ; 12 ; Magic Learning menu left side
    .BYTE   $10,$03,$10,$13 ; 13 ; Magic Learning menu right side
    .BYTE   $01,$1A,$0A,$03 ; 14 ; Main menu timer box

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
    LDA #4
    STA dest_x             ; JIGS - due to widening the option box, text needs to be pushed right 2 extra 
    LDA #01                ; Draw Menu String ID=$02 (the option text)
    JMP DrawMenuString






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

DrawCharDescBox:
    PHA                  
    LDA #1               
    STA menustall
    LDA #$08             
    JSR DrawMainItemBox
    PLA                  
    INC descboxopen      
    JMP DrawCharMenuString    ; JIGS - because it contains HP/MP or other character-related stats

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
    ;; Update: Actually, fixed that problem, but I am not going to fiddle with this unless I have to.
    
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
    
    LDY #$C0                     ; set char menu string length to $C0
   ; DEC dest_x
    LDA #18                      ; and draw string 2A (entire spell list, along with level names an MP amounts
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

    ;SEC             ; if no spell found, SEC and exit
    LDA #0
    STA item_pageswap ; set back to 0 if no spells found
    RTS

  @FoundSpell:
    TXA             ; if we found a spell... move which spell into A
    AND #$1F        ;  and mask out which spell it is (remove the char index)
    ;STA cursor      ;  and store it in the current cursor
    STA backup_cursor ; put found spell in this variable
    ;CLC             ; then CLC to indicate the character has a spell
    RTS             ; and exit



 
 
    
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
    JSR MenuFrame        ; then do an Equip Menu Frame
    
    LDA joy_a
    BNE @A_Pressed            ; check to see if A pressed
    LDA joy_b
    BNE @B_Pressed            ; or B

    JSR MoveEquipMenuCurs     ; if neither A nor B pressed, move the mode cursor
    JMP @Loop                 ; and loop until one of them is pressed

  @A_Pressed:
    LDA cursor                ; cursor = equip slot
    CLC
    ADC CharacterIndexBackup  ; add character index
    TAX
    LDA ch_righthand, X       ; check equipped item
    BEQ :+                   ; if it exists...
    TAX
    DEX
    INC inv_weapon, X        ; put the unequipped weapon in inventory
    
:   STA ItemToUnequip
    LDA cursor
    STA equipoffset
    LDA #0
    STA cursor
    STA cursor_max
    STA item_pageswap
    STA battleitemslot        ; set to weapons for battle item slots
    JSR EnterEquipInventory
    JMP EnterEquipMenu
    
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
    STA joy_select
    STA joy_start
    STA menustall         ; and turn off menu stalling (since the PPU is off)
    LDA #1
    STA cursor_change
   
    JSR ClearNT
    JSR DrawEquipInventory ; Draws everything
    JSR TurnMenuScreenOn_ClearOAM
    
    @Loop:
    JSR ClearOAM
    JSR DrawEquipInventoryCursor
    LDA cursor_change
    BEQ :+
    JSR UpdateEquipInventoryStats
  : JSR MenuFrame ;EquipMenuFrame
    
    LDA joy_a
    BNE @A_Pressed            ; check to see if A pressed
    LDA joy_b
    BNE @B_Pressed            ; or B
    LDA joy_start
    ORA joy_select
    BNE @Select_Pressed

    JSR MoveEquipInventoryCursor   ; if neither A nor B pressed, move the mode cursor
    JMP @Loop                      ; and loop until one of them is pressed
    
  @B_Pressed:                 ; if B pressed....
    JSR UnEquipStats
    LDA equipoffset
    CLC 
    ADC CharacterIndexBackup ; add character index
    TAX
    LDA ItemToUnequip 
    STA ch_righthand, X      ; restore original item
    BEQ :+
    TAX
    DEX
    DEC inv_weapon, X        ; and if it was more than 0, take it out of inventory again
  : JMP ReEquipStats
  
  @Select_Pressed:
    LDA battleitemslot
    BEQ @SwitchToArmor
    
       @SwitchToWeapon:
        DEC battleitemslot
        JMP @DoneSwitch
        
       @SwitchToArmor:
        INC battleitemslot
       @DoneSwitch:  
        JMP EnterEquipInventory
    
  @A_Pressed:
    LDA equip_impossible
    BNE @Error
    
    LDX ItemToEquip          ; get the new weapon
    DEX
    DEC inv_weapon, X        ; remove it from inventory
    RTS
    
   @Error: 
    JSR PlaySFX_Error        ; kr-kow if not equippable
    JMP @Loop

    
UpdateEquipInventoryStats:    
    JSR UnEquipStats        
    JSR UpdateEquipInventoryStats_CheckViable
    JSR ReEquipStats
    DEC cursor_change
    
;; every time the cursor moves (plus at the very start) the equipped weapon changes:
;; if it can be equipped, it is, and the stats are adjusted to show that it is--
;; to show what it would be if the player chooses that one with A
;; otherwise, the slot is set with 0 and the stats are adjusted to show they have nothing
;; Pressing B will put the original item back in place
;; Pressing A will equip the item set by UpdateEquipInventoryStats_CheckViable
;; If there is 0 amount of an item, it will equip you with nothing
;; or else give an error if the item set cannot be equipped
    
    LDA equipoffset
    CMP #6
    BCC EquipStatsDescBoxNumbers   ; don't display this stuff if on battle item slot
        RTS 
    
EquipStatsDescBoxNumbers:
    LDA CharacterIndexBackup
    STA char_index
    JSR @FetchStats
    
    LDA #03
    STA dest_x
    LDA #24
    STA dest_y
    
    LDA #1
    STA menustall
    
    LDA #<(str_buf)
    STA text_ptr
    LDA #>(str_buf)           ; load pointer from table, store to text_ptr  (source pointer for DrawComplexString)
    STA text_ptr+1
    JMP DrawComplexString
    
   @FetchStats:    
    LDA #$08        
    STA tmp+7
    LDY #$3C         ; damage
    JSR @TheThing
  
    LDA #$14
    STA tmp+7
    LDY #$3E         ; defense
    JSR @TheThing
    
    LDA #$1E
    STA tmp+7
    LDY #$3D         ; accuracy
    JSR @TheThing
   
    LDA #$2A
    STA tmp+7        
    LDY #$3F         ; evasion
   
   @TheThing:
;    LDA equipoffset
;    CMP #06
;    BCS @DashStats

    LDA equip_impossible
    BEQ :+
   
   @XStats: 
    LDX tmp+7
    LDA #$FF
    STA str_buf, X
    LDA #$F0
    STA str_buf+1, X
    STA str_buf+2, X
    RTS   
    
;   @DashStats: 
;    LDX tmp+7
;    LDA #$FF
;    STA str_buf, X
;    LDA #$C2
;    STA str_buf+1, X
;    STA str_buf+2, X
;    RTS  
  
   @WrongSlot: 
    LDX tmp+7
    LDA #$FF
    STA str_buf, X
    LDA #$C4
    STA str_buf+1, X
    STA str_buf+2, X
    RTS  
  
  : LDA equipoffset
    CMP slotcheck
    BNE @WrongSlot 
  
    TYA
    JSR PrintCharStat
    LDX tmp+7
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
    LDA equipoffset
    CMP #6
    BCC :+
    
    ;; if in battle item slots...
    LDA #23
    STA dest_y
    LDA #10
    STA dest_x
    
    LDA battleitemslot
    BEQ @DrawWeapon
    
   @DrawArmor:    
    LDA #83
    JSR DrawMenuString
    JMP @DrawExplanation
    
   @DrawWeapon:
    LDA #82
    JSR DrawMenuString
   
   @DrawExplanation:   
    INC dest_y
    INC dest_y
    LDA #01
    STA dest_x
    
    LDA #84
    JMP DrawMenuString

  : LDA #81
    ASL A                   ; double A (pointers are 2 bytes)
    TAX                     ; put in X to index menu string pointer table
    LDA lut_MenuText, X
    STA text_ptr
    LDA lut_MenuText+1, X   ; load pointer from table, store to text_ptr  (source pointer for DrawComplexString)
    STA text_ptr+1

    LDY #0
   @Loop:
    LDA (text_ptr), Y
    STA str_buf, Y
    INY 
    CPY #$2E
    BNE @Loop
    
    INC dest_x
    INC dest_x
    
    LDA #<(str_buf)
    STA text_ptr
    LDA #>(str_buf)           ; load pointer from table, store to text_ptr  (source pointer for DrawComplexString)
    STA text_ptr+1
    JMP DrawComplexString


UpdateEquipInventoryStats_CheckViable:
    LDA #0
    STA equip_impossible
    STA slotcheck

    LDA cursor
    ASL A
    ASL A
    ASL A
    ADC cursor_max
    STA ItemToEquip
    TAX
    
    LDA equipoffset
    BEQ @DoesWeaponExist
    CMP #6
    BCC @DoesArmorExist
    
    LDA battleitemslot
    BEQ @DoesWeaponExist
    
   @DoesArmorExist: 
    LDA inv_armor, X
    BEQ @ClearStats
    BNE :+
    
   @DoesWeaponExist:
    LDA inv_weapon, X
    BEQ @ClearStats
    
  : LDA equipoffset
    CMP #06               
    BCC @IsEquipLegal
    
    LDA battleitemslot
    BEQ @FinishUpdate
    JMP @FinishUpdate_Armor
  
   @IsEquipLegal:
    INC ItemToEquip    
    LDA ItemToEquip
    JSR IsEquipLegal         ; This routine subtracts 1 from A
    BCC @UpdateStats
    
   @NoEquip: 
    LDA #1
    STA equip_impossible
    
   @ClearStats:            
    LDA equipoffset
    STA slotcheck
   @ClearStats_2: 
    CLC 
    ADC CharacterIndexBackup ; add character index
    TAX
    LDA #0
    STA ItemToEquip
    STA ch_righthand, X      ; clear slot
    RTS
   
  @UpdateStats:
    DEC ItemToEquip
    LDX equipoffset
    LDA lut_EquipOffset, X
    BEQ @FinishUpdate         
  
  @UpdateStats_Armor:
    LDX ItemToEquip      
    LDA lut_ArmorTypes, X    ; check type LUT
    CMP equipoffset          ; against equip slot
    BNE @WrongSlot           ; if it equals, its in the right slot to continue
   
    STA slotcheck
    
   @FinishUpdate_Armor:
    LDA ItemToEquip
    CLC
    ADC #ARMORSTART
    STA ItemToEquip          ; and add $40 to the item
    
   @FinishUpdate:  
    LDA equipoffset
    CLC 
    ADC CharacterIndexBackup ; add character index
    TAX
    INC ItemToEquip          ; convert to 1-based item
    LDA ItemToEquip
    STA ch_righthand, X      ; save item in that slot 
    RTS                      ; return
    
  @WrongSlot:
   LDA #9
   STA slotcheck   
   LDA equipoffset
   JMP @ClearStats_2

  

DrawEquipInventoryCursor:
    LDA cursor                 
    AND #$01
    TAX
    LDA lut_EquipInventoryCursor_X, X  
    STA spr_x

    LDX cursor_max
    LDA lut_EquipInventoryCursor_Y, X
    STA spr_y
    JMP DrawCursor               ; then draw the cursor

lut_EquipInventoryCursor_X:
  .BYTE   $10
  .BYTE   $88
    
lut_EquipInventoryCursor_Y:
  .BYTE   $28
  .BYTE   $38
  .BYTE   $48
  .BYTE   $58
  .BYTE   $68
  .BYTE   $78
  .BYTE   $88
  .BYTE   $98

lut_EquipInventoryPageTitle:
.byte $04, $05, $06, $4E 
    
DrawEquipInventory:
    LDA #$09                ; Box List
    JSR DrawMainItemBox
    
    LDA #$08                ; Description box
    JSR DrawMainItemBox
    JSR EquipStatsDescBoxString ; base string, no stats
   
    LDA #$07                ; Name
    JSR DrawMainItemBox
    DEC dest_y
    LDA #7
    JSR DrawCharMenuString
  
    LDA #$11
    JSR DrawMainItemBox     ; sub menu box
    DEC dest_y
    INC dest_x
    
    LDX item_pageswap
    LDA lut_EquipInventoryPageTitle, X
    JSR DrawMenuString         ; draw page number and arrows
  
    LDA item_pageswap
    ASL A
    ASL A
    ASL A
    ASL A
    STA MMC5_tmp+2      ; X backup
    LDY #0
    STY MMC5_tmp        ; item counter
    STY MMC5_tmp+1      ; left or right counter
    
    LDA equipoffset
    BEQ @Loop
    CMP #6
    BCC @ArmorOffset
    
    LDA battleitemslot  ; if equipoffset is 6 or 7 (battle item)
    BEQ @Loop           ; check this variable to see if weapon or armor
    
   @ArmorOffset:
    LDA MMC5_tmp+2
    CLC
    ADC #ARMORSTART
    STA MMC5_tmp+2
    
   @Loop: 
    LDX MMC5_tmp+2
    LDA inv_weapon, X
    BEQ @SkipOne
    
    STA tmp             ; save for PrintNumber
    
    INX                 ; increase X to convert to readable item name
    TXA
    STA bigstr_buf+1, Y ; ID in 2nd slot
    STA MMC5_tmp+2      ; save X 
    LDA #07
    STA bigstr_buf, Y   ; weapon/armor name code in 1st slot
    LDA #01
    STA bigstr_buf+5, Y ; double line break
    LDA #$FF
    STA bigstr_buf+2, Y ; space
    
    JSR PrintNumber_2Digit
    LDA format_buf-1     ; numbers!
    STA bigstr_buf+4, Y  ; tens 
    LDA format_buf-2
    STA bigstr_buf+3, Y  ; ones
    
    TYA
    CLC
    ADC #6
    TAY
   
   @ResumeLoop:
    INC MMC5_tmp
    LDA MMC5_tmp
    CMP #8             ; if item counter is over 8, end inner loop and reset to 0
    BNE @Loop
    
    LDA #0             ; put the null terminator in
    STA MMC5_tmp       ; reset item counter
    STA bigstr_buf, Y

    LDA #<(bigstr_buf)    ; fill text_ptr with the pointer to our item names in the big string buffer
    STA text_ptr
    LDA #>(bigstr_buf)
    STA text_ptr+1
    
    INC MMC5_tmp+1
    LDA MMC5_tmp+1
    CMP #2
    BEQ @DrawRightSide
    
   @DrawLeftSide:
    LDA #04 
    STA dest_x 
    LDA #05
    STA dest_y
    JSR DrawComplexString  ; Draw all the item names
    
    LDY #0
    JMP @Loop
    
    @DrawRightSide:
    
    LDA #19
    STA dest_x 
    JMP DrawComplexString  ; Draw all the item names
        
   @SkipOne:
    INX  ; skip this item
    STX MMC5_tmp+2
    LDA #$C2  
    STA bigstr_buf, Y
    STA bigstr_buf+1, Y
    STA bigstr_buf+2, Y
    STA bigstr_buf+3, Y
    STA bigstr_buf+4, Y
    STA bigstr_buf+5, Y
    STA bigstr_buf+6, Y
    STA bigstr_buf+7, Y
    LDA #01
    STA bigstr_buf+8, Y
    TYA
    CLC
    ADC #9
    TAY
    JMP @ResumeLoop    
  











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

  ;; JIGS - "equipoffset" is the slot of Armor: shield (left hand), head, body, arms, accessory. In that order.
  ;; So the type of Armor in each slot is set here.
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
    JSR PlaySFX_MenuMove
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
    BNE @Done
    
    LDA #$00
    JMP :+

  @Up:
    DEC cursor
    LDA cursor         
    CMP #$FF
    BNE @Done
    
    LDA #$07
  : STA cursor
   @Done:
    JMP PlaySFX_MenuMove

DrawEquipMenuCurs:
    LDA #$18                   ; all slots are on same X coordinate
    STA spr_x                  ; 
    LDX cursor                 ; get primary cursor
    LDA @lut_EquipMenuCurs, X   ; then fetch
    STA spr_y                    ;    and record Y coord
    JMP DrawCursor               ; draw the cursor, and exit

  @lut_EquipMenuCurs:
  .BYTE $38
  .BYTE $48    
  .BYTE $58
  .BYTE $68
  .BYTE $78
  .BYTE $88
  .BYTE $98
  .BYTE $A8
  
  

MoveEquipInventoryCursor:
    LDA joy                      ; get joypad state
    AND #$0F                     ; isolate directional buttons
    CMP joy_prevdir              ; compare to previous buttons to see if any have been pressed/released
    BEQ @Exit                    ; if there's no change, just exit
    STA joy_prevdir              ;  otherwise record changes
    CMP #0                       ; see if buttons have been pressed (rather than released)
    BEQ @Exit                    ; if no buttons pressed, just exit
    
    CMP #$04               ; now see which button was pressed
    BCS @UpDown            ; check for up/down
    CMP #$01               ; otherwise, check for left/right
    BNE @Left
    
    @Right:
    INC cursor
    LDX cursor
    LDA @CursorSwapPage_LUT, X
    BEQ @SwapPageRight
    
    CMP #$FF
    BNE @Done
    
    DEC cursor
    
    @Done:
    INC cursor_change
    JMP PlaySFX_MenuMove
    
    @Exit:
    RTS ; do this if no buttons were pressed, so as not to close the message box
    
    @Left:
    DEC cursor
    LDX cursor
    LDA @CursorSwapPage_LUT, X
    CMP #1
    BEQ @SwapPageLeft
    
    LDA cursor
    CMP #$FF
    BNE @Done
    
    INC cursor
    JMP @Done
    
    @SwapPageLeft:
    DEC item_pageswap
    JMP :+
    
    @SwapPageRight:
    INC item_pageswap
    
  : JSR PlaySFX_MenuMove
    PLA
    PLA
    JMP EnterEquipInventory

    @CursorSwapPage_LUT:
    ; traveling right, swap when it hits 0, stop at $FF
    ; traveling left,  swap when it hits 1
    ;    ; page 1  ; page 2  ; page 3  ; page 4  ; 
    .byte $02, $01, $00, $01, $00, $01, $00, $01, $FF
    
    @UpDown:         ; if we pressed up or down... see which
    BNE @Up

    @Down:      
    INC cursor_max
    LDA cursor_max
    CMP #8
    BCC @UpDownDone
    
    LDA #0
    STA cursor_max
    JMP @UpDownDone
    
    @Up:
    DEC cursor_max
    LDA cursor_max
    CMP #$FF
    BNE @UpDownDone
    
    LDA #7
    STA cursor_max
    
    @UpDownDone:
    INC cursor_change
    JMP PlaySFX_MenuMove

    


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Draw Equip Menu  [$BDF3 :: 0x3BE03]
;;
;;    Does not draw the names of the equipment -- only the boxes and other text
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


DrawEquipMenu:
   JSR ClearNT             ; clear the NT
   
   LDA #$0C                
   JSR DrawMainItemBox

   LDA CharacterEquipBackup
   STA submenu_targ
 
   LDA #$05
   STA dest_x
   
   LDA #11
   JSR DrawCharMenuString   ; Name and Class
   
   LDA #$07
   STA dest_y
   LDA #12
   JSR DrawMenuString       ; Equipment
   
   LDA #$18
   STA dest_y
   LDA #$03
   STA dest_x
   LDA #13
   JMP DrawCharMenuString  ; Stats


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
  .WORD   $0208,$06CB,$FFFF,$FFFF,$FFFF,   $FFFF,$FFFF,$FFFF,$FFFF,$FFFF
  .WORD   $FFFF,$FFFF,$FFFF,$FFFF,$FFFF,   $FFFF,$FFFF,$FFFF,$FFFF,$FFFF
  .WORD   $FFFF,$FFFF,$FFFF,$FFFF,$FFFF,   $FFFF

  ; JIGS - last one is for clearing cheer pose in shops 
  
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
  .WORD   $FFFF,$FFFF,$FFFF,$FFFF,$FFFF,   $FFFF,$FFFF,$FFFF,$FFFF,$FFFF
  .WORD   $FFFF,$FFFF,$FFFF,$FFFF,$FFFF,   $FFFF,$FFFF,$FFFF,$FFFF,$FFFF
  .WORD   $FFFF,$FFFF,$FFFF,$FFFF,$FFFF,   $FFFF


lut_EquipOffset:
.byte $00,$01,$01,$01,$01,$01,$00,$00


DrawManaString_ForBattle:
LDA #01
STA dest_x
LDA #21
STA dest_y
LDA #1
STA menustall
LDA #$4F
JMP DrawCharMenuString




.byte "END OF BANK E"