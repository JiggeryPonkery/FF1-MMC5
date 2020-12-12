.include "Constants.inc"
.include "variables.inc"
.include "macros.inc"
.feature force_range

.export AddGPToParty
.export BattleBackgroundColor_LUT
.export BattleCrossPageJump_L
.export BattleRNG_L
.export BattleScreenShake_L
.export Battle_ReadPPUData_L
.export CHRLoad
.export CHRLoadToA
.export CallMusicPlay
.export CallMusicPlay_L
.export ClearBattleMessageBuffer_L
.export ClearOAM
.export ClearUnformattedCombatBoxBuffer
.export CoordToNTAddr
.export DoOverworld
.export Draw2x2Sprite
.export DrawBox
.export DrawBox_L
.export DrawCombatBox_L
.export DrawComplexString
.export DrawComplexString_L
.export DrawCursor
.export DrawEquipBox_String
.export DrawEquipMenuStrings
.export DrawImageRect
.export DrawItemBox_String
.export DrawMagicBox_String
.export DrawOBSprite
.export DrawPalette
.export DrawPalette_L
.export DrawSimple2x3Sprite
.export EraseBox
.export FadeInSprites
.export FadeOutSprites
.export DimAll
.export FadeOutAllPalettes
.export FadeInAllPalettes
.export FadeOutBG
.export FadeInBG
.export ClearPalette
.export BackUpPalettes
.export ClearSpritePalette
.export FillItemBox
.export FormatBattleString
.export GameLoaded
.export GameStart_L
.export JIGS_RefreshAttributes
.export LoadBorderPalette_Blue
.export LoadBridgeSceneGFX_Menu
.export LoadMenuCHRPal
.export LoadPrice
.export LoadPrice_Long
.export LoadShopCHRPal
.export LongCall
;.export Magic_ConvertBitsToBytes
.export MenuCondStall
.export MultiplyXA
.export PaletteFrame
.export PlayDoorSFX
.export PlaySFX_Error
.export RandAX
.export SaveScreenHelper
.export SetPPUAddr_XA
.export ShiftLeft4
.export ShiftLeft6
.export ShiftSpriteHightoLow
.export SwapBtlTmpBytes_L
.export UndrawBattleBlock
.export UndrawNBattleBlocks_L
.export UpdateJoy
.export UpdateJoy_L
.export WaitForVBlank_L
.export WaitForVBlank_L
.export lutClassBatSprPalette
.export lut_NTRowStartHi
.export lut_NTRowStartLo
.export lut_RNG
.export lut_VehicleMusic
.export DrawMenuString_FixedBank
.export DrawMenuString_CharCodes_FixedBank
.export LoadCHR_MusicPlay
.export ReloadBridgeNT
.export ADD_ITEM
.export REMOVE_ITEM
.export DOES_ITEM_EXIST
.export Set_Inv_Magic
.export Set_Inv_Weapon
.export Set_Inv_KeyItem
.export DOES_ITEM_EXIST_1BIT
.export ADD_ITEM_1BIT
.export REMOVE_ITEM_1BIT
.export SwapPRG_L
.export ItemDescriptions
.export lut_2x2MapObj_Down
.export lut_InBattleCharPaletteAssign
.export LoadBorderPalette_Grey
.export JigsBox_Start
.export LoadEnemyGraphicsFromBank

.import AssignMapTileDamage_Z
.import ClearNT
.import EnterBridgeScene_L
.import EnterEndingScene
.import EnterIntroStory
.import EnterMainMenu
.import EnterMiniGame
.import EnterMinimap
.import EnterShop
.import EnterTitleScreen
.import GetDialogueString
.import JigsIntro
.import LoadBattleSpritesForBank_Z
.import LoadOWMapRow_1E
.import LoadSprite_Bank03
.import LoadStatusBoxScrollWork
.import LoadStoneSprites
.import MapPoisonDamage_Z
.import MinimapDecompress
.import MusicPlay_L
.import PrintBattleTurn
.import PrintCharStat
.import PrintGold
.import PrintNumber_2Digit
.import PrintPrice
.import SaveScreen
.import SoundTestZ
.import TalkToObject
.import TalkToTile_BankE
.import TurnMenuScreenOn_ClearOAM
.import UhOhNewGame
.import WeaponArmorPrices
.import WriteAttributesToPPU
.import __Nasir_CRC_High_Byte
.import data_BattleMessages
.import data_BridgeCHR
.import data_BridgeNT
.import data_EnemyNames
.import data_EpilogueCHR
.import data_EpilogueNT
.import lut_BackdropPal
.import lut_BattleFormations
.import lut_BattlePalettes
.import lut_BattleRates
.import lut_BtlBackdrops
.import lut_DialoguePtrTbl
.import lut_DialoguePtrTbl_2
.import lut_Domains
.import lut_EntrTele_Map
.import lut_EntrTele_X
.import lut_EntrTele_Y
.import lut_ExitTele_X
.import lut_ExitTele_Y
.import lut_InitGameFlags
.import lut_InitUnsramFirstPage
.import lut_ItemPrices
.import lut_MapmanPalettes
.import lut_MapMusicTrack
.import lut_MenuTextCHR
.import lut_NormTele_Map
.import lut_NormTele_X
.import lut_NormTele_Y
.import lut_OWPtrTbl
.import lut_OWTileset
.import lut_OrbCHR
.import lut_SMPalettes
.import lut_SMTilesetAttr
.import lut_SMTilesetProp
.import lut_SMTilesetTSA
.import lut_ShopCHR
.import lut_Tilesets
.import lut_MapObjCHR
.import lut_OWMapObjCHR
.import lut_SmallMapObjCHR
.import Overworld_Tileset
.import lut_SMPtrTbl
.import lut_BatSprCHR
.import lut_BatObjCHR
.import DrawMenuString_A
.import DrawMenuString_CharCodes_A
.import KeyItem_Add
.import LoadShopPalette
.import LoadAllBattleSprites_Menu
.import LoadShopCHR_andPalettes
.import Bridge_LoadPalette
.import Ending_LoadPalette
.import LoadMenuOrbs
.import lut_MapBanks
.import LoadSmallMapPalettes
.import lut_MapObjectCount
.import DecompressSMAttributes
.import lut_ItemNames_Low
.import lut_ItemNames_High
.import lut_Treasure
.import lut_Treasure_2
.import lut_EquipmentNames_Low
.import lut_EquipmentNames_High
.import lut_MagicNames_Low
.import lut_MagicNames_High
.import lut_PriceTable_Low
.import lut_PriceTable_High
.import lut_TreasureTable_Low
.import lut_TreasureTable_High
.import lut_BattleMessages_Low
.import lut_BattleMessages_High
.import lut_EnemyNames_Low
.import lut_EnemyNames_High
.import lut_GoldNames_Low
.import lut_GoldNames_High
.import LoadPlayerMapPalette
.import lut_ItemDescStrings_Low
.import lut_ItemDescStrings_High
.import SetPartyStats
.import LoadNPCSprites
.import LoadPlayerMapmanCHR_15
.import LoadMapObjects
.import BeginBattleSetup
.import lut_EnemyCHR_Assignment
.import BackupMapMusic
.import FinishBattlePrepAndFadeIn

.segment "BANK_FIXED"

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Game Start 
;;
;;    The game code starts here.  This is jumped to after the reset vector
;;  preps all the necessary hardware stuff.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

GameStart_L:
GameStart:
    LDA #0                      ; Turn off the PPU
    STA $2000
    STA $2001
    ;STA unk_FE                  ; ?? I don't think this is ever used
 
    LDA #$08                    ; Sprites use pattern table at $1xxx
    STA soft2000
    STA NTsoft2000
    
    LDX #$FF                    ; reset stack pointer
    TXS
    ;; Load some startup info
    
    LDA #BANK_TITLE             ; swap in bank containing some LUTs
    JSR SwapPRG_L
    
    LDX #$00                        ; Loop $100 times to fill each page of unsram
  : LDA #0
    STA unsram, X                 ; stat page filled with zeros (proper stats will be assigned
    STA ch_stats, X               ;   later after party generation)
    STA ch_spells, X              ; 
    ;; JIGS - Rather than take up 256 bytes in Bank 0, the original game only needs to initalize game_flags all to 1, with 7 exceptions.
    LDA #1
    STA game_flags, X
    INX                           ; loop for the full page
    BNE :-

    ;; JIGS - and a little extra: since it loads character startings stats, intro music, and other variables that need to start out 0.
    ;LDX #$00
  : LDA lut_InitUnsramFirstPage, X
    STA unsram, X
    INX 
    CPX #$40
    BNE :-
 
    TXA
    STA game_flags+$12    ;   Princess in Coneria, vanished until rescued
    STA game_flags+$13    ;   Fairy, vanished until rescued from bottle
    STA game_flags+$19    ;   Second Garland at end game
    STA game_flags+$1A    ;   Third Garland at end game
    STA game_flags+$3F    ;   Three Provka citizens hiding from pirates: man
    STA game_flags+$40    ;   Sage
    STA game_flags+$41    ;   Woman
    
    LDA #$41
    STA music_track    
    ;; JIGS - begin prelude
    
    LDA startintrocheck           ; check a random spot in memory.  This value is not inialized as powerup,
    CMP #$4D                      ;    and will be semi-random.
    BEQ TitleScreen               ; if it is any value other than $4D, we can assume we just powered on...

    LDA #$4D                      ; ... so initilize it to $4D.  From this point forward, it will always be initlialized.
    STA startintrocheck           ; This is how the game makes the distinction between cold boot and warm reset
    JSR JigsIntro      
    ;; JIGS - do my fancy new intro! It has letter-by-letter printing, doesn't reset the Prelude music, and a fancy new title screen and everything.

TitleScreen:
    JSR LoadBridgeSceneGFX_Menu     ;; draw the title (bridge) scene and menu CHR
    JSR SaveScreenHelper
    JSR EnterTitleScreen

GameLoaded:
    JSR ClearZeroPage               ; clear Zero Page for good measure
    
    LDA unsram_ow_scroll_x          ; fetch OW scroll from unsram
    STA ow_scroll_x
    LDA unsram_ow_scroll_y
    STA ow_scroll_y
    
    LDA unsram_vehicle              ; fetch vehicle from unsram (wouldn't
    STA vehicle_next                ;   this always be 'on-foot'?)
    STA vehicle
    
  ; JMP DoOverworld                 ; <- Flow into DoOverworld!

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Do Overworld  [$C0CB :: 0x3C0DB]
;;
;;    Called when you enter (or exit to) the overworld.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

DoOverworld:
    JSR PrepOverworld       ; do all overworld preparation
    JSR ScreenWipe_Open     ; then do the screen wipe effect
    JMP EnterOverworldLoop  ; then enter the overworld loop

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Main Overworld Game Logic Loop  [$C0D1 :: 0x3C0E1]
;;
;;   This is where everything spawns from on the overworld.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; this one is for entering the overworld from a menu/story screen
EnterOW_NoWipe:
    JSR PrepOverworld       ; do all necessary overworld preparation
    JSR StopNoise_StopSprites

EnterOverworldLoop:
    LDX #$FF            ; purge stack and wipe the stack pointer so it points to top of stack
    TXS                 ;   overworld loop is the de-facto "top" of all gameflow.

    JSR GetOWTile       ; get the current overworld tile information

   ;;
   ;; THE overworld loop
   ;;
OverworldLoop_2:   

  @Loop:  
    JSR WaitForVBlank_L        ; wait for VBlank
    LDA #>oam                  ; and do sprite DMA
    STA $4014

    JSR OverworldMovement      ; do any pending movement animations and whatnot
                               ;   also does any required map drawing and updates
                               ;   the scroll appropriately
        
    
    LDA music_track        ; if no music track is playing...
    BPL :+
      LDA dlgmusic_backup  ; start the overworld music! 
      STA music_track
    
:   JSR CallMusicPlay_NoSwap   ; Keep the music playing

    LDA mapdraw_job            ; check to see if drawjob number 1 is pending
    CMP #1
    BNE :+
      JSR PrepAttributePos     ; if it is, do necessary prepwork so it can be drawn next frame

:   LDA move_speed             ; check to see if the player is currently moving
    BNE :+                     ; if not....
      LDA vehicle_next         ;   replace current vehicle with 'next' vehicle
      STA vehicle
      JSR DoOWTransitions      ; check for any transitions that need to be done
      JSR ProcessOWInput       ; process overworld input

:   JSR ClearOAM           ; clear OAM
    JSR DrawOWSprites      ; and draw all overworld sprites

    LDA vehicle       ; Get currnt vehicle
    AND #$0C          ; isolate ship and airship bits
    BEQ @Loop         ; if not in ship or airship, just jump back to the loop
                      ;   otherwise... there's a sound effect we need to be playing

    CMP #$08          ; see if we're in the airship
    BNE @ShipSFX      ; if not.. jump ahead to Ship SFX

  @AirshipSFX:
    LDA #$38          ; The airship sound effect performed here is exactly the same
    STA $400C         ;  as the one desribed in AirshipTransitionFrame  (see that routine
    LDA framecounter  ;  for details).  Only difference here is that the framecounter
    ASL A             ;  is doubled -- which means the sound effect cycles twice as fast,
    JMP @PlaySFX      ;  so it sounds like the propellers are spinning faster.

  @ShipSFX:
    LDA framecounter  ; get frame counter
    BPL :+            ; if it's negative...
      EOR #$FF        ;  invert it
:   LSR A             ; then right shift by 4.
    LSR A             ; this produces a triangle pattern between 0-7:
    LSR A             ;     0,1,2,3,4,5,6,7,7,6,5,4,3,2,1,0,0,1,2,3....  etc
    LSR A
    ORA #$30          ; use this pattern as the noise volume
    STA $400C         ;   so the noise is constantly, slowly fading in and out (sounds like ocean waves)
    LDA #$0A          ; use a fixed frequency of $0A

  @PlaySFX:
    STA $400E         ; write specified frequency
    LDA #0
    STA $400F         ; write to last noise reg to reload length counter and get channel started
    JMP @Loop         ; then jump back to loop


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Do Overworld Transitions  [$C140 :: 0x3C150]
;;
;;    Called to do any transitions that need to be done from the overworld.
;;  This includes teleports, battles, entering the caravan, etc.  Anything that
;;  takes the game off of the overworld.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


DoOWTransitions:
    LDA ow_flags
    AND #BRIDGE_SCENE_OVER | BRIDGE_SCENE_NOTYET
    BNE @SkipBridgeScene

    ;LDA bridgescene       ; see if the bridge scene has been triggered
    ;BEQ @SkipBridgeScene  ;   if not triggered... skip it
    ;BMI @SkipBridgeScene  ;   if we've already done it in the past, skip it

      ;JSR StopNoise_StopSprites      ; cycle palettes with code=00 (overworld, cycle out)

      JSR LoadBridgeSceneGFX ; load CHR and NT for the bridge scene
      ;LDA #BANK_BRIDGESCENE
      ;JSR SwapPRG_L          ; swap to bank containing bridge scene
      JSR EnterBridgeScene_L ; do the bridge scene.
      JMP EnterOW_NoWipe     ; then re-enter overworld

  @SkipBridgeScene:
    LDA entering_shop     ; see if we're entering a shop (caravan)
    BEQ @SkipShop         ; if not... skip it

      ;JSR GetOWTile       ; Get overworld tile (why do this here?  doesn't make sense)
      ;JSR StopNoise_StopSprites   ; cycle out the palette

      LDA #BANK_MENUS
      JSR SwapPRG_L       ; swap to bank containing shops
      JSR EnterShop       ; and enter the shop!
      JMP EnterOW_NoWipe  ; then re-enter overworld

  @SkipShop:
    BIT tileprop+1      ; check properties of tile we just moved to
    BMI @Teleport       ; if bit 7 set.. it's a teleport tile
    BVS @Battle         ; otherwise... if bit 6 set, we are to engage in battle

      ;;  If we reach here, there is nothing special that happened due to the player
      ;;   moving.  So check for start/select button presses

    LDA joy_start         ; did they press start?
    BEQ @SkipStart        ; if not... skip it
	
	
	  JSR GetOWTile       ; get overworld tile (needed for some items, like the Floater)
      JSR DoMainMenu
      JMP EnterOW_NoWipe  ; then re-enter the overworld
      
  @SkipStart:
    LDA joy_select        ; check to see if they pressed select
    BEQ @Exit             ; if not... nothing else to check.  Just exit

    LDA joy
      AND #$40            ; see if the B button is being held down
      BEQ @Pause ;Lineup         ;  if not... jump to the lineup menu.  Otherwise do the minimap screen

      @Minimap:
        ;LDA #$00            ; otherwise... if they did press select..
        ;STA $400C           ; silence noise (stop ship/airship sound effects)
        JSR StopNoise_StopSprites   ; cycle out the palette
      
        LDA #BANK_MINIMAP
        JSR SwapPRG_L        ; swap to bank containing the minimap
        JSR EnterMinimap     ; do the minimap
        JMP EnterOW_NoWipe   ; then re-enter overworld
       
       @Pause:
        JSR PauseGame

  @Exit:
   RTS

  @Battle:
    JSR GetOWTile          ; Get overworld tile (needed for battle backdrop)
    JSR EnterBattle_L      ; Load everything up and start the battle!
    JMP EnterOW_NoWipe     ; then re-enter overworld

  @Teleport:
    JSR GetOWTile           ; Get OW tile (so we know the battle backdrop for the map we're entering)
    JSR ScreenWipe_Close    ; wipe the screen closed

    LDA #BANK_TELEPORTINFO  ; swap to bank containing teleport data
    JSR SwapPRG_L

    LDA tileprop+1          ; get the teleport ID
    AND #$3F                ;  remove the teleport/battle bits, leaving just the teleport ID
    TAX                     ;  put the ID in X for indexing

    LDA lut_EntrTele_X, X   ; get the X coord, and subtract 7 from it to get the scroll
    SEC
    SBC #7
    AND #$3F                ; wrap around edge of the map
    STA sm_scroll_x

    LDA lut_EntrTele_Y, X   ; do same with Y coord
    SEC
    SBC #7
    AND #$3F
    STA sm_scroll_y

    LDA lut_EntrTele_Map, X ; get the map
    STA cur_map

    TAX                     ; throw map in X
    LDA lut_Tilesets, X     ; and use it to get the tileset for this map
    STA cur_tileset

    LDA #0                  ; clear the inroom flag (enter maps outside of rooms)
    STA inroom

    JSR DoStandardMap       ; then JSR to the standard map code.  This JSR will only return
                            ;  if/when the player warps out of the map.  At which point...
    JMP DoOverworld         ; we jump to reload and start the overworld all over again.

    
DoMainMenu:
    LDA #0
    STA joy_start       ; clear start button catcher
    JSR StopNoise_StopSprites   ; cycle out the palette

    LDA #BANK_MENUS
    JSR SwapPRG_L       ; swap to bank containing menus
	INC MenuHush
    JMP EnterMainMenu   ; and enter the main menu    
    

PauseSoundTest:
    JSR SoundTestMenu         
    LDA mapflags
    LSR A 
    BCC @Overworld
   
    JMP ReenterStandardMap
    
   @Overworld:    
    JMP EnterOW_NoWipe

PauseGame:
    LDA #%11111110 ; set all colour emphasis, keep PPU on, no greyscale
    STA $2001 
    
    LDA #0
    STA joy_select ; clear select so the game doesn't unpause immediately

    LDA #$30
    STA $4000   ; set Squares and Noise volume to 0
    STA $4004   ;  clear triangle's linear counter (silencing it next clock)
    STA $4008
    STA $400C
    STA $5000   ; set MMC5 Squares volume to 0
    STA $5004   ;
  
   @PauseLoop:
    LDA mapflags           ; check if on overworld or town/dungeon
    LSR A                    
    BCS @StandardMap
        JSR SetOWScroll    ; do overworld scroll if on overworld 
        JMP :+   
   
   @StandardMap:           ; else, do town/dungeon scroll
    JSR WaitForVBlank
    LDA #>oam              ; and do Sprite DMA
    STA $4014               
    JSR SetSMScroll
    JSR ClearOAM           ; clear OAM
    LDY #1
    JSR DrawPlayerMapmanSprite ; why does SetOWScroll not need to do all this to draw the player?
    JSR DrawMapObjectsNoUpdate 
   
  : JSR UpdateJoy  ; keep checking if select is pressed again
    LDA joy_start
    BNE PauseSoundTest
    LDA joy_select
    BEQ @PauseLoop

    LDA #0
    STA joy_select ; clear select so the game doesn't pause immediately again
    STA joy_start  ; clear start so the game doesn't go into menu after unpausing
    STA joy_a      ; clear A so the game doesn't open a dialogue box after unpausing
    LDA #$1E       ; turn on screen/clear emphasis
    STA $2001
    RTS   
    
    
    
    
    
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Fly Airship  [$C215 :: 0x3C225]
;;
;;    Checks to make sure airship is visible and at current coords
;;  and takes flight if it is.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

FlyAirship:
    LDA ow_flags         ; see if airship is visible
    AND #AIRSHIP_VISIBLE
    BEQ @Exit            ; if not... exit

    LDA ow_scroll_x      ; get map X scroll
    CLC
    ADC #7               ; +7 to get player's coord
    CMP airship_x        ; see if it matches the airship's X coord
    BNE @Exit            ; if not.. exit

    LDA ow_scroll_y      ; do same check with Y coord
    CLC
    ADC #7
    CMP airship_y
    BNE @Exit            ; if no match, exit

    LDA #$08
    STA vehicle_next     ; set current and next vehicle to airship
    STA vehicle

    LDA #$46
    STA music_track      ; change music track to $46 (airship music)
    STA dlgmusic_backup

    JMP AnimateAirshipTakeoff    ; do the takeoff animation, then exit

  @Exit:
    RTS

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Process OW input   [$C23C :: 0x3C24C]
;;
;;    Updates joy data and does input processing for the overworld.  Shouldn't
;;  be called when player is in motion.  Does not process start/select buttons.
;;
;;  OUT:     tileprop+1 = bit 7 set if stepping onto a teleport
;;           tileprop+1 = bit 6 set if we should start a random encounter.  btlformation contains
;;                          the formation ID number in that case
;;        entering_shop = nonzero if we're entering a shop (caravan).  shop_id is set appropriatly 
;;                          in that case.
;;          bridgescene = 01 if we triggered the bridge scene
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


ProcessOWInput:
    ;LDA tileprop     ; check properties of tile we just stepped on
    ;AND #OWTP_FOREST ; see if the forest bit is on
    ;STA inforest     ; and store result in 'inforest'
    ;; JIGS - it is an odd place, and will result in sprites coming out of the forest if you can't move!
    
                 ; seems like an odd place to do that... since it has nothing to do with input

    LDA vehchgpause  ; see if we're in the middle of a vehicle change pause
    BEQ @NoVehPause  ; if we are...

      ;SEC
      ;SBC #$01
      ;STA vehchgpause ; decrement the vehchgpause counter (why doesn't it DEC?)
      DEC vehchgpause
      RTS             ; and exit (ignore all input until vehchgpause is zero)

  @NoVehPause:
    JSR UpdateJoy    ; update joypad data

    LDA joy
    AND #$0F         ; check directional buttons
    BNE @Movement    ; if any of them are pressed... do movement.

    LDA joy_a        ; otherwise... check to see if A was pressed
    BEQ @ANotPressed ; jump ahead if it wasn't

      LDA #0         ; if A pressed...
      STA joy_a      ; clear A button catcher

      LDA vehicle      ; check the current vehicle
      CMP #$08
      BEQ @LandAirship ; if in the airship, try to land it
      CMP #$01
      BEQ FlyAirship   ; if on foot, try to take off in the airship
                       ; otherwise, proceed as if A wasn't pressed

  @ANotPressed:
    LDA joy_b
    CMP #55            ; check to see if they pressed B 55 times
    BNE @Exit          ; if not... exit.  Otherwise....

    INC joy_b          ; inc joy_b so that this branch doesn't get taken every frame
    LDA vehicle        ; get the current vehicle
    CMP #$04           ; see if it's the ship
    BNE @Exit          ; if not... exit

    LDA joy            ; get current joy data
    AND #$C0           ; check to make sure both A and B are currently down
    CMP #$C0
    BNE @Exit          ; if not... exit

    ;LDA #0                  ; otherwise... they activated the minigame!
    JSR StopNoise_StopSprites
    JSR LoadBridgeSceneGFX  ; load the NT and most of the CHR for the minigame
    ;; also swaps to the correct bank
    JSR EnterMiniGame    ; and do it!
    BCC :+               ; if they compelted the minigame successfully...
      JSR MinigameReward ;  ... give them their reward

  : JMP EnterOW_NoWipe   ; then re-enter overworld
  @Exit:
    RTS

  ;;  Code reaches here if they pressed a directional button
  ;;    indicating they want to move in a direction!
  ;;  A contains the button(s) pressed (facing)

  @Movement:
    LDX vehicle        ; check the current vehicle

    CPX #$08
    BEQ @StartMove     ; if airship, no collision detection, can move freely anywhere

    CPX #$04
    BEQ @MoveShip      ; if ship or canoe, do appropriate checks
    CPX #$02
    BEQ @MoveCanoe

  @MoveOnFoot:         ; otherwise we're on foot
    JSR OWCanMove      ; see if they can move in given direction
    BCC @Forest        ;  if yes, start the move

    LDA #0
    STA tileprop+1     ; otherwise, zero tileprop+1 so no battle occurs

    JSR IsOnBridge     ; see if they're stepping on the bridge/canal
    BCS @Foot_NoBridge ; if they aren't on the bridge, skip ahead

     LDA ow_flags
     AND #BRIDGE_SCENE_OVER
     BNE @StartMove
     
    @TriggerBridgeScene:
     LDA ow_flags
     AND #~BRIDGE_SCENE_NOTYET
     STA ow_flags
     
     ;LDA bridgescene   ; if they are on a bridge... see if the bridge scene has already happened
     ;BNE @StartMove    ;   if it has, just start moving
     ;INC bridgescene   ; otherwise, INC the bridgescene counter to make it happen
     ;BNE @StartMove    ; then start moving (always branches)

    @Foot_NoBridge:    ; if they weren't on the bridge
      JSR BoardCanoe   ; see if they can board the canoe to get to the next tile
      BCC @StartMove   ;   if they can, start the move
      JSR BoardShip    ; otherwise see if they can board the ship
      BCS @CantMove    ;   if not, they can't move
                       ; otherwise (can board ship), flow into @StartMove
   
   @Forest:            ; JIGS - checks to see if the forest effect is on
    LDA tileprop
    AND #OWTP_FOREST    
    BEQ @StartMove
    
    LDA mapspritehide  ; byte is split into two: high 4 bits are active, low 4 bits are "in waiting"
    ORA #8             ; ORA so as not to wipe out the active bits
    STA mapspritehide  ; then the movement routine rotates the 4 active bits out to get the new bits when changing tiles

  @StartMove:             ; Here if move was legal
    LDA joy               ; get joy
    AND #$0F              ; isolate the direction(s) they're pressing (ie, where they're trying to move)
    STA facing            ; set that as our facing
    JMP StartMapMove      ; then start the map move!  and exit

  @LandAirship:        ; Here when attempting to land the airship
    JMP LandAirship


  @MoveShip:           ; Here if trying to move when in the ship
    JSR OWCanMove      ; see if they can move in desired direction
    BCS @Ship_NoMove   ; if they can't... jump ahead

     JSR IsOnCanal       ; if they can... check to see if the canal is blocking them
     BCS @StartMove      ; if it isn't, start moving
     JMP @CantMove       ; otherwise, prevent them from moving

    @Ship_NoMove:        ; if they couldn't normally move on the ship...
      JSR BoardCanoe     ; see if they can board the canoe to move
      BCC @StartMove     ; if yes... start moving

      LDA tileprop            ; otherwise, get tile properties
      AND #OWTP_DOCKSHIP | 1  ; see if you can walk on foot to this tile... 
      CMP #OWTP_DOCKSHIP      ;   AND that you can dock the ship here
      BNE @CantMove           ; if can't dock ship or can't walk on foot -- then can't move

      JSR UnboardBoat_Abs     ; otherwise, unboard the ship
      JMP @StartMove          ; and start moving


  @CantMove:
    LDA #0
    ;STA tileprop         ; if you can't move... kill tile properties
    STA tileprop+1       ; to prevent undesired teleports/battles
    RTS                  ; and exit


  @MoveCanoe:           ; if in canoe
    JSR OWCanMove       ; see if they can move
    BCC @StartMove      ; if yes... move

    JSR UnboardBoat     ; otherwise, see if they can unboard the canoe and proceed on foot
    BCC @StartMove      ; if yes, move!

    JSR BoardShip       ; otherwise, see if they can board the ship
    BCC @StartMove      ; if yes, do it!
    BCS @CantMove       ; otherwise, can't move (always branches)

;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Load Overworld Tileset Data  [$C30F :: 0x3C31F]
;;
;;    Copies $400 bytes of overworld tileset data to RAM.
;;
;;  This fills the following buffers:
;;    tileset_prop
;;    tsa_ul, tsa_ur, tsa_dl, tsa_dr
;;    tsa_attr
;;    load_map_pal
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;


LoadOWTilesetData:
    LDA #BANK_OWINFO
    JSR SwapPRG_L       ; swap to bank containing OW tileset data

    LDA #0              ; set low bytes of
    STA tmp             ;  source pointer
    STA tmp+2           ;  and dest pointer

    LDA #>lut_OWTileset ; high byte of source pointer
    STA tmp+1

    LDA #>tileset_data  ; high byte of dest pointer
    STA tmp+3

    LDX #4              ; high byte of loop counter ($400 iterations)
   @Loop: 
    JSR Copy256
    INC tmp+1           ; once it wraps, inc high bytes of both pointers
    DEX                 ; and decrement overall loop counter

    BNE @Loop           ; and keep looping until that expires ($400 iterations)

    RTS                 ; then exit

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Overworld movement  [$C335 :: 0x3C345]
;;
;;    This moves the party on the overworld, and deals them poison damage
;;  when appropriate.  It also sets the scroll appropriately.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

OverworldMovement:
    LDA move_speed        ; check movement speed
    BEQ SetOWScroll_PPUOn ; if zero (we're not moving), just set the scroll and exit

    ; JSR OW_MovePlayer    ; otherwise... process party movement
    
    LDA ow_slow           ; if non-zero...
    BEQ :+
    
    LDA framecounter      ; check framecounter
    AND #$01              ; skip moving every other frame
    BEQ @SlowMove
    
  : JSR SM_MovePlayer
    ;; JIGS - SM_MovePlayer handles all the same things by changing mapflags when it needs to do overworld stuff

    LDA vehicle           ; check the current vehicle
    CMP #$01              ; are they on foot?
    BNE :+                ; if not, just exit
      JMP MapPoisonDamage ; if they are... distribute poison damage
:   RTS

   @SlowMove:
    PLA
    PLA
    JSR CallMusicPlay_NoSwap
    JMP OverworldLoop_2
  
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Set OW Scroll  [$C346 :: 0x3C356]
;;
;;    Sets the scroll for the overworld map.  And optionally
;;  turns the screen on (seperate entry point)
;;
;;    Changes to SetOWScroll can impact the timing of some raster effects.
;;  See ScreenWipeFrame for details.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

SetOWScroll_PPUOn:
    LDA #$1E
    STA $2001           ; turn the PPU on!

SetOWScroll:
    LDA NTsoft2000      ; get the NT scroll bits
    STA soft2000        ; and record them in both soft2000
    STA $2000           ; and the actual $2000

    LDA $2002           ; reset PPU toggle

    LDA ow_scroll_x     ; get the overworld scroll position (use this as a scroll_x,
    ;ASL A               ;    since there is no scroll_x)
    ;ASL A
    ;ASL A
    ;ASL A               ; *16 (tiles are 16 pixels wide)
    JSR ShiftLeft4
    ORA move_ctr_x      ; OR with move counter (effectively makes the move counter the fine scroll)
    STA $2005           ; write this as our X scroll

    LDA scroll_y        ; get scroll_y
    ;ASL A
    ;ASL A
    ;ASL A
    ;ASL A               ; *16 (tiles are 16 pixels tall)
    JSR ShiftLeft4
    ORA move_ctr_y      ; OR with move counter
    STA $2005           ; and set as Y scroll

    RTS                 ; then exit




    

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Overworld Move Right  [$C36C :: 0x3C37C]
;;
;;    See OW_MovePlayer for details
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;OWMove_Right:
;    LDA mapdraw_job        ; is there a draw job to do?
;    BEQ @NoJob             ; if not... no job
;      JSR DoMapDrawJob     ; otherwise, do the job

;  @NoJob:
;    JSR SetOWScroll_PPUOn  ; turn on PPU, set scroll

;    LDA move_ctr_x         ; add movement speed
;    CLC                    ;  to our X move counter
;    ADC move_speed
;    AND #$0F               ; mask low bits to keep within a tile
;    BEQ @FullTile          ; if result is zero, we've moved a full tile

;    STA move_ctr_x         ; otherwise, simply write back the counter
;    RTS                    ;  and exit

;  @FullTile:
;    STA move_speed         ; after moving a full tile, zero movement speed
;    STA move_ctr_x         ; and move counter

;    LDA ow_scroll_x        ; +1 to our overworld scroll X
;    CLC
;    ADC #$01
;    STA ow_scroll_x

;    AND #$10               ; get nametable bit of scroll ($10=use nt@$2400, $00=use nt@$2000)
;    LSR NTsoft2000         ; shift out and discard old NTX scroll bit
;    CMP #$10               ; sets C if A=$10 (use nt@$2400).  clears C otherwise
;    ROL NTsoft2000         ; shift C into NTX scroll bit (indicating the proper NT to use)

;    RTS                    ; then exit

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Overworld Move Left  [$C396 :: 0x3C3A6]
;;
;;    See OW_MovePlayer for details
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;OWMove_Left:
;    LDA mapdraw_job        ; is there a draw job to do?
;    BEQ @NoJob             ; if not... no job
;      JSR DoMapDrawJob     ; otherwise... do the job

;  @NoJob:
;    JSR SetOWScroll_PPUOn  ; set scroll and turn PPU on

;    LDA move_ctr_x         ; get the move counter.  If zero, we need to move one tile to left
;    BNE @NoTileChg         ;   otherwise we don't need to change tiles

;    LDA ow_scroll_x        ; subtract 1 from the OW X scroll
;    SEC
;    SBC #$01
 ;   STA ow_scroll_x

 ;   AND #$10               ; get the nametable bit ($10=use nt@$2400... $00=use nt@$2000)
 ;   LSR NTsoft2000         ; shift out and discard old NTX scroll bit
 ;   CMP #$10               ; sets C if A=$10 (use nt@$2400).  clears C otherwise
 ;   ROL NTsoft2000         ; shift C into NTX scroll bit (indicating the proper NT to use)

 ;   LDA move_ctr_x         ; get the move counter

 ; @NoTileChg:
 ;   SEC                    ; A=move counter at this point
 ;   SBC move_speed         ; subtract the move speed from the counter
 ;   AND #$0F               ; mask it to keep it in the tile
 ;   BEQ @FullTile          ; if zero, we've moved a full tile

 ;   STA move_ctr_x         ; otherwise, just write the move counter back
 ;   RTS                    ; and exit

 ; @FullTile:
 ;   STA move_speed         ; if we've moved a full tile, zero our speed
 ;   STA move_ctr_x         ; and our counter
 ;   RTS                    ; and exit

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Overworld Move Player  [$C3C4 :: 0x3C3D4]
;;
;;    This moves the player's sprite in the direction they're facing
;;  at their current movement speed.  It also draw the necessary map
;;  drawing jobs when apppropriate.
;;
;;    For vertical movement... drawing jobs are performed halfway between tiles
;;  (8 pixels in).  For Horizontal movement, they're performed immediately.  The reason
;;  for this is because the game is using Vertical mirroring, which means changes made to the
;;  top of the screen can be seen on the bottom.  So drawing between tiles when moving vertically
;;  minimizes garbage appearing at the top or bottom of the screen.  No such caution is needed
;;  (or desired) for horizontal movement, because the extra nametable on the X axis prevents
;;  such garbage from appearing altogether.
;;
;;    Note that most of the routines this jumps to are jumped to with branches
;;  so this routine must be relatively close to all those routines.
;;
;;    This routine will set the PPU scroll BEFORE doing additional scrolling.  Basically
;;  meaning that the scroll you see on-screen is 1 frame behind what the game is
;;  tracking.  This is intentional, because all sprites also have this 'delay'... because
;;  OAM has to wait until next frame before it can be DMA'd.  So this keeps the BG
;;  and sprites both in sync by keeping them both a frame behind (otherwise, sprites
;;  would appear to shift over 1 pixel during scrolling).
;;
;;    The scroll must be set AFTER all drawing is complete.  This is why each routine
;;  jumped to here calls SetOWScroll_PPUOn instead of this routine just calling it once.
;;  Since each routine needs to do drawing jobs under specific conditions... those drawing
;;  jobs must be done BEFORE the scroll is set (has to do with how NES scrolling works).
;;  Therefore, once this routine is called, the scroll is set, so no further drawing
;;  can be done this frame!
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;OW_MovePlayer:
;    LDA facing          ; check to see which way we're facing
;    LSR A
;    BCS OWMove_Right    ; moving right
;    LSR A
;    BCS OWMove_Left     ; moving left
;    LSR A
;    BCS OWMove_Down     ; moving down
   ; JMP OWMove_Up       ; moving up

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Overworld Move Up  [$C406 :: 0x3C416]
;;
;;    See OW_MovePlayer for details
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;OWMove_Up:
;    LDA mapdraw_job        ; see if a job needs to be done
;    BEQ @NoJob             ; if not, no job

;    CMP #$01
;    BEQ @Job               ; if job=1, do it right away

;    LDA move_ctr_y         ; otherwise, only do it when we're halfway between tiles
;    CMP #$08
;    BNE @NoJob

;  @Job:
;    JSR DoMapDrawJob

;  @NoJob:
;    JSR SetOWScroll_PPUOn  ; turn PPU on and set scroll

;    LDA move_ctr_y         ; get move counter
;    BNE @NoTileChg         ; if it's zero, we need to change tiles.  Otherwise, skip ahead

;    DEC ow_scroll_y        ; dec the OW scroll

;    LDA scroll_y           ; subtract 1 from the map scroll Y
;    SEC
;    SBC #$01
;    BCS :+
;      ADC #$0F             ; and have it wrap from 0->E
;:   STA scroll_y           ; then write it back

;    LDA move_ctr_y         ; get move counter again

;  @NoTileChg:
;    SEC                    ; here, A=move counter
;    SBC move_speed         ; subtract the movement speed from the counter
;    AND #$0F               ; mask it to keep it in a 16x16 tile 
;    BEQ @FullTile          ; if it's now zero... we've moved a full tile

;    STA move_ctr_y         ; otherwise, simply write back the move counter
;    RTS                    ;  and exit

;  @FullTile:
;    STA move_speed         ; if we moved a full tile, zero the move speed (stop player from moving)
;    STA move_ctr_y         ; and zero the move counter
;    RTS                    ; then exit

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Overworld Move Down  [$C3D2 :: 0x3C3E2]
;;
;;    See OW_MovePlayer for details
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    
;OWMove_Down:
;    LDA mapdraw_job     ; see if a drawing job needs to be performed
;    BEQ @NoJob          ; if not... skip ahead

;    CMP #$01            ; if drawing job=1 (attributes)...
;    BEQ @Job            ;   do it right away

;    LDA move_ctr_y      ; otherwise, only do the job if we're halfway between tiles
;    CMP #$08            ;   (8 pixels between the move)
;    BNE @NoJob          ; if not 8 pixels between the move... don't do the job

;  @Job:
;    JSR DoMapDrawJob       ; do the map drawing job, then proceed normally

;  @NoJob:
;    JSR SetOWScroll_PPUOn  ; turn the PPU on, and set the appropriate overworld scroll

;    LDA move_ctr_y         ; get the Y move counter
;    CLC
;    ADC move_speed         ; add our movement speed to it
;    AND #$0F               ; and mask it to keep it within the current tile
;    BEQ @FullTile          ; if it's now zero, we've moved 1 full tile

;    STA move_ctr_y         ; otherwise, simply record the new move counter
;    RTS                    ; and exit

;  @FullTile:               ; if we've moved a full tile
;    STA move_speed         ; zero our move speed (A=0 here) to stop moving
;    STA move_ctr_y         ; also zero our move counter

;    INC ow_scroll_y        ; update the overworld scroll

;    LDA scroll_y           ; and update our map scroll
;    CLC
;    ADC #1                 ;   by adding 1 to it
;    CMP #$0F
;    BCC :+
;      SBC #$0F             ;   and make it wrap from E->0  (nametables are only 15 tiles tall.. not 16)
;:   STA scroll_y           ; write it back
;    RTS                    ; and exit




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Clear OAM   [$C43C :: 0x3C44C]
;;
;;    Fills Shadow OAM with $F8 (which effectively clears it so no sprites are visible)
;;  also resets the sprite index to zero, so that the next sprite drawn will
;;  have top priority.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

ClearOAM:
    LDX #$3F       ; use X as loop counter (looping $40 times)
    LDA #$F8       ; we'll be clearing to $F8

  @Loop:
      STA $0200, X ; clear 4 bytes of OAM
      STA $0240, X
      STA $0280, X
      STA $02C0, X
      DEX          ; and continue looping until X expires
      BPL @Loop

    LDA #0         ; set sprite index to 0
    STA sprindex
    RTS            ; and exit



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Clear Zero Page  [$C454 :: 0x3C464]
;;
;;    Clears Zero Page RAM (or, more specifically, $0001-00EF -- not
;;  quite all of zero page
;;
;;    This is done after game start as a preparation measure.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

ClearZeroPage:
    LDX #$EF          ; start from $EF and count down
    LDA #0
  @Loop:
      STA 0, X
      DEX
      BNE @Loop       ; clear RAM from $01-EF

    LDA #$1B          ; scramble the NPC directional RNG seed
    ORA npcdir_seed   ;  to make it a little more random
    STA npcdir_seed

    RTS


 ;; Unused

;.BYTE $EA, $EA, $EA, $EA, $EA

;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Disable APU  [$C469 :: 0x3C479]
;;
;;    Silences all channels and prevents them from being audible until they are
;;  re-enabled (requires another write to $4015).  Channels will become reenabled
;;  once the music engine starts a new track.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;

DisableAPU:
    LDA #$30
    STA $4000   ; set Squares and Noise volume to 0
    STA $4004   ;  clear triangle's linear counter (silencing it next clock)
    STA $4008
    STA $400C
    STA $5000   ; set MMC5 Squares volume to 0
    STA $5004   ;
    LDA #$00
    STA $4015   ; disable all channels
    STA $5015   ; disable all MMC5 channels (JIGS)
    RTS


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Overworld Can Move  [$C47D :: 0x3C48D]
;;
;;    Checks to see if the player can move in the given direction.  If they can,
;;  it does a little additional work to prep everything for future action.
;;
;;  IN:      A = direction you're facing
;;
;;  OUT:     C = set if cannot move in this direction.  Cleared if can.
;;       tmp+2 = X coord moved to (assuming move was successful)
;;       tmp+3 = Y coord moved to (assuming move was successful)
;;    tileprop = first byte of properties of tile you tried to move to
;;
;;
;;    Additionally... if you can move in a direction (C cleared), the following information
;;  is output:
;;
;;  tileprop+1 = bit 7 set if teleport, with low bits determining teleport ID
;;
;;  tileprop+1 = bit 7 clear and bit 6 set if you are to engage in a random encounter
;;               after moving onto this tile
;;
;;  btlformation = if you are to engage in a random encounter, this is the battle formation
;;                 ID to engage in.
;;
;;  entering_shop = nonzero if moving onto the caravan
;;
;;  shop_id       = set to caravan's shop ID number if entering caravan.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

OWCanMove:
    LSR A         ; determine which direction we're moving
    BCS @Right    ;   and branch accordingly
    LSR A
    BCS @Left
    LSR A
    BCS @Down

  @Up:
    LDX #7        ; for each direction, put x-coord add in X, and y-coord add in Y
    LDY #7-1      ; these will be added to the map scroll to determine player position.
    BNE @Calc     ; Player is always 7 tiles from left, and 7 tiles from top of screen
                  ; -- so base is 7.  For up, you'd add one less to Y (to move up one tile)
  @Down:          ;  and so on for each directon.
    LDX #7
    LDY #7+1
    BNE @Calc

  @Right:
    LDX #7+1
    LDY #7
    BNE @Calc

  @Left:
    LDX #7-1
    LDY #7

  @Calc:
    TXA              ; get X add
    CLC
    ADC ow_scroll_x  ; add to it the OW scroll X
    STA tmp          ; store as low byte of map pointer
    STA tmp+2        ; and also throw in tmp+2 (uncompromised X coord)

    TYA              ; get Y add
    CLC
    ADC ow_scroll_y  ; add to it the OW scroll Y
    STA tmp+3        ; throw it in tmp+3 (uncompromised Y coord)
    AND #$0F         ; then mask with F to keep it within the portion of the map that's loaded
    ORA #>mapdata    ; and OR with high byte of mapdata pointer
    STA tmp+1        ; and write as high byte of pointer

    LDY #0                 ; zero Y for indexing
    LDA (tmp), Y           ; get the tile at desired coords

    ASL A                  ; double it and throw it in X (2 bytes per tile properties)
    TAX
    LDA tileset_prop+1, X
    STA tileprop+1
    LDA tileset_prop, X    ; copy tile properties from tileset
    STA tileprop
    
;    LDA tileprop     ; get first byte of tile properties
    AND vehicle      ; AND with current vehicle to find out whether or not this vehicle can move there
    BEQ :+           ; if zero -- movement is allowed for this vehicle, jump ahead

      SEC            ; otherwise SEC to indicate failure (movement forbidden for this vehicle)
      RTS            ; and exit

:   BIT tileprop+1   ; put bit 6 of tileprop+1 in V
    BVS @Fighting    ; if bit 6 was set (fighting occurs on this tile), jump ahead

    LDA vehicle      ; otherwise, get the vehicle
    CMP #$01         ; check to see if we're on foot
    BEQ @OnFoot      ; if we are, do additional checks

  @Success_1:        ; otherwise (not on foot) Success!
    CLC              ; CLC to indicate success
    RTS              ; and exit

  @OnFoot:
    LDA tileprop         ; get tile properties
    CMP #OWTP_SPEC_CARAVAN  ; is this the caravan?
    ;BNE @Success_1          ; if not, success!
    BEQ @Caravan
    
    AND #OWTP_SPEC_MASK  ; mask out special bits
    BEQ @Success_2       ; if nothing special, success! (JIGS - but check for slowness!)

    CMP #OWTP_SPEC_CHIME ; is the chime necessary?
    ;BEQ @NeedChime       ; if yes... check to make sure we have it

   ; CMP #OWTP_SPEC_CARAVAN  ; is this the caravan?
    BNE @Success_2          ; if not, success!

  @NeedChime:
    LDA keyitems_2
    AND #$10             ; see if they have the chime in their inventory
    BNE @Success_1       ; if they do -- success
    SEC                  ; otherwise, failure
    RTS  
    
  @Caravan:
   ; LDA game_flags+OBJID_FAIRY
   ; AND #$01             ; check the fairy map object to see if she's visible
   ; BNE @Success_2       ; if she is (bottle has been opened already), prevent entering caravan (exit now)

    ;LDA #$01             ; otherwise, we need to indicate the player is entering the caravan
    ;STA entering_shop    ; set entering_shop to nonzero
    INC entering_shop
    LDA #SHOP_CARAVAN_ID+$30 ; = $AF
    STA shop_id          ; shop ID=70 ($46) = caravan's shop ID

    @Success_2:
     JMP OWMoveSlow
      ;CLC
      ;RTS

  @Fighting:
    LDA #10              ; 10 / 256 chance of getting in a random encounter normally
    LDX vehicle          ; check the current vehicle
    CPX #$04             ; see if it's the ship
    BNE :+               ; if it is....
       LDA #3            ;   ... 3 / 256 chance instead  (more infrequent battles at sea)

:   STA tmp              ; store chance of battle in tmp
    JSR EncounterRateOption
    ;; JIGS - EncounterRateIncrease/Decrease!

    JSR BattleStepRNG    ; get a random number for battle steps
    CMP tmp              ; compare it to our chance
    BCC @DoEncounter     ; if the random number < our odds -- do a random encounter

      LDA #0             ; otherwise, no random encounter
      STA tileprop+1     ; clear tileprop+1 to indicate no battle yet
      JMP OWMoveSlow     ; see if moving onto a slow tile

  @DoEncounter:
    LDA tileprop+1       ; find out which type of counter we're to do
    AND #$03             ;   by checking the low 2 bytes of tileprop+1

    BEQ @LandDomain      ; if 0, get battle from land domain

    CMP #2
    BEQ @SeaDomain       ; if 2, get battle from sea domain
                         ;   else, get from river domain

   ;; Note that river and land domains just add 7 to the scroll to get
   ;;  player position... however this gets the player's position BEFORE
   ;;  the move.  So if you get in a battle just as you cross a domain boundary,
   ;;  the battle formation will be chosen from the domain you're leaving, rather
   ;;  than the domain you're entering.  Some might say that's BUGGED -- especially
   ;;  when you consider the ACTUAL player position has already been recorded to tmp+2
   ;;  tmp+3 -- so it could just load those and not do any math.

  @RiverDomain:
    LDA tmp+2            ; player X coord
    AND #$80             ; and clear out all but high bit
    LSR A
    LSR A
    LSR A
    LSR A                ; shift high bits into low bits
    STA tmp
    
    LDA tmp+3
    AND #$80             ; clear out all but high bit
    LSR A
    LSR A
    LSR A                ; shift high bit into $10s slot
    ADC tmp              ; add X coord
    LDX #$08             ; set $08 to high bit
    BNE GetBattleFormation

  @SeaDomain:
    LDA tmp+2            ; Player X Coord  
    AND #$C0
    LSR A
    LSR A 
    LSR A                ; divided by 8
    STA tmp
    
    LDA tmp+3            ; Player Y Coord  
    AND #$C0
    LSR A                ; divided by 2
    CLC
    ADC tmp              ; + X / 8 
    ADC #$20             ; + $20 to put it past the river formations
    LDX #$08             ; set $08 to high bit
    BNE GetBattleFormation 

    ; X = $00        ; Y = $00       ; + X = 00 
    ; X = $40 >>> 8  ; Y = $00       ; + X = 08 
    ; X = $80 >>> 10 ; Y = $00       ; + X = 10 
    ; X = $C0 >>> 18 ; Y = $00       ; + X = 18 
    ;
    ; X = $00        ; Y = $40 > $20 ; + X = 20 
    ; X = $40 >>> 8  ; Y = $40 > $20 ; + X = 28 
    ; X = $80 >>> 10 ; Y = $40 > $20 ; + X = 30 
    ; X = $C0 >>> 18 ; Y = $40 > $20 ; + X = 38 
    ;
    ; X = $00        ; Y = $80 > $40 ; + X = 40 
    ; X = $40 >>> 8  ; Y = $80 > $40 ; + X = 48 
    ; X = $80 >>> 10 ; Y = $80 > $40 ; + X = 50 
    ; X = $C0 >>> 18 ; Y = $80 > $40 ; + X = 58 
    ; 
    ; X = $00        ; Y = $C0 > $60 ; + X = 60 
    ; X = $40 >>> 8  ; Y = $C0 > $60 ; + X = 68 
    ; X = $80 >>> 10 ; Y = $C0 > $60 ; + X = 70 
    ; X = $C0 >>> 18 ; Y = $C0 > $60 ; + X = 78 

  @LandDomain:
    LDA tmp+3              
    LSR A                ; Y coord / 2
    LSR A                ; with the high bits moved into low bits
    LSR A
    LSR A
    LSR A
    TAX                  ; put in X
    
    LDA tmp+2            ; X coord / 2  
    LSR A                ; cut off the low 3 bits
    AND #$F8             ; this gets the low byte offset   
    
    
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Get Battle Formation  [$C54A :: 0x3C55A]
;;
;;    Gets a (weighted) random battle formation from the given domain.
;;
;;  IN:   A = domain ID
;;
;;  OUT:  C = cleared (this is so OWCanMove can JMP to this rather than having to JSR to it)
;;        btlformation = formation ID to engage in
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


GetBattleFormation:
    CLC
    ADC #<lut_Domains
    STA tmp
    TXA
    ADC #>lut_Domains
    STA tmp+1

    LDA #BANK_DOMAINS
    JSR SwapPRG_L        ; swap to bank containing domain information

    ;INC battlecounter    ; increment the battle counter
    LDX framecounter     ; battlecounter    ; and put it in X
    LDA lut_RNG, X       ; use it as seed to get a random number

    AND #$3F                    ; drop the 2 high bits of the random number
    TAX                         ; and put in X
    LDY lut_FormationWeight, X  ; use that to index the formation weight LUT to know which formation to use

    LDA (tmp), Y         ; get the desired formation from the given domain
    STA btlformation     ; record as our battle formation

OWMoveSlow:
    LDA tileprop          ; get tile again
    AND #OWTP_SPEC_SLOW   ; cut off everything but the highest bit
    BEQ :+                ; if 0, finish up
    
    LDX lead_index
    LDA ch_miscperks, X
    AND #LIGHTSTEP
    BNE :+               ; if the lead has the Light Step support ability, don't do any tile damage        
    INC ow_slow          ; otherwise, inc ow_slow (only needs to be non-zero to work)
  : CLC                  ; CLC (to indicate success for OWCanMove -- since it JMPs here)
    RTS                  ; and exit

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Battle Step RNG   [$C571 :: 0x3C581]
;;
;;    This is a pRNG which returns a seemingly random/scrambled number
;;  in A.  This number is then used to determine whether or not to have a random
;;  encounter this step.
;;
;;    Random numbers are generated by stepping through a RNG LUT.  Once it
;;  cycles through the entire LUT, it cycles through it again -- potentially
;;  in a reversed direction.  Which direction it's going depends on battlestep_sign.
;;
;;  OUT:   A = random number
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

BattleStepRNG:
    BIT battlestep_sign    ; see if sign indicates a decrement
    BMI @Negative

  @Positive:
    INC battlestep         ; increment battlestep
    BNE @Done              ; if it hasn't expired, finish up
    BEQ @Expired           ; otherwise, it has  (always branches)

  @Negative:
    DEC battlestep         ; if negative, decrement battlestep
    BNE @Done              ; if it hasn't expired, finish up

  @Expired:                ; if battlestep has expired (= zero)
    LDA battlestep_sign    ; add $A0 to the battlestep_sign
    CLC                    ;   this may potentially change directions
    ADC #$A0
    STA battlestep_sign

  @Done:
    LDA smokebomb_steps    ; if smokebomb_steps is 0, do the normal thing
    BEQ :+
    DEC smokebomb_steps    ; otherwise, decrement smokebomb_steps, and load #$FF as our "random number"
    LDA #$FF               ; ensuring that no random encounter will happen
    RTS  
  
  : LDX battlestep         ; put battlestep in X
    LDA lut_RNG, X         ; use it to get a random number from the LUT
    RTS                    ; and exit


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Formation weight LUT  [$C58C :: 0x3C59C]
;;
;;    64-byte LUT that assigns weight to each of the 8 formations
;;  in battle domains.  The more a number is included in this table,
;;  the more that formation is chosen from the domain.


lut_FormationWeight:
  .BYTE 0,0,0,0,0,0, 0,0,0,0,0,0    ; 12/64 chance of formation 0
  .BYTE 1,1,1,1,1,1, 1,1,1,1,1,1    ; 12/64
  .BYTE 2,2,2,2,2,2, 2,2,2,2,2,2    ; 12/64
  .BYTE 3,3,3,3,3,3, 3,3,3,3,3,3    ; 12/64
  .BYTE 4,4,4,4,4,4                 ;  6/64
  .BYTE 5,5,5,5,5,5                 ;  6/64
  .BYTE 6,6,6                       ;  3/64
  .BYTE 7                           ;  1/64


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Boat boarding / unboarding routines   [$C5CC :: 0x3C5DC]
;;
;;     These are a series of routines that have the player attempt to
;;  change vehicles during a move.  They handle movements between any
;;  combination of foot/canoe/ship.
;;
;;  IN:  tileprop = properties of tile we're moving onto
;;          tmp+2 = X coord we're moving onto
;;          tmp+3 = Y coord
;;
;;  OUT:   C = clear if successful (able to board/unboard/move)
;;             set if unsuccessful.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;
;;  UnboardBoat  [$C5CC :: 0x3C5DC]
;;    Exits the canoe/ship and proceeds on foot
;;

UnboardBoat:
    LDA tileprop         ; get tile properties
    AND #$01             ; see if walking onto this tile is legal
    BNE Board_Fail       ; if not... fail
                 ;  otherwise, proceed to UnboardBoat_Abs

;;
;;  UnboardBoat_Abs  [$C5D2 :: 0x3C5E2]
;;    Same as UnboardBoat, only it does not check to make sure
;;  you can legally walk on target tile (it assumes that check was already
;;  performed).  Therefore it's always successful.
;;

UnboardBoat_Abs:
    LDA vehicle          ; put old vehicle in A (used later)

    LDX #$01
    STX vehicle_next     ; set next vehicle to foot
    STX vehicle          ; and current vehicle (so we don't sail onto the land before going on foot)

    LDX #0
    STX tileprop+1       ; kill tileprop+1 to prevent a battle from occuring

    CMP #$04             ; check old vehicle (previously put in A)
    BEQ DockShip         ; if we were previously in the ship... dock the ship here

    CLC                  ; CLC to indicate success, and exit
    RTS

;;
;;  Board_Fail  [$C5E4 :: 0x3C5F4]
;;    Reached when boarding/unboarding has failed.
;;

Board_Fail:
    SEC        ; SEC to indicate failure
    RTS        ; and exit

;;
;;  BoardCanoe  [$C5E6 :: 0x3C5F6]
;;    Attempts to board the canoe.  Can be done from on foot or from ship
;;

BoardCanoe:
    LDA tileprop        ; get tile properties
    AND #$02            ; check to see if a canoe move is legal here
    BNE Board_Fail      ; if it isn't, fail

    LDA keyitems_3
    AND #$80            ; make sure the player has the canoe
    BEQ Board_Fail      ; if they don't.. fail

    LDA #$04
    STA vehchgpause     ; set a little pause for boarding canoe

    LDA vehicle         ; put old vehicle in A

    LDX #$01            ; set current vehicle to on foot
    STX vehicle         ;   and next vehicle to canoe
    LDX #$02            ; This will make it so you appear to be on foot between tiles
    STX vehicle_next

    LDX #0
    STX tileprop+1      ; prevent battle from occuring

    CMP #$04            ; check old vehicle (in A)
    BEQ DockShip        ; if we were in the ship, dock the ship here

    CLC                 ; CLC for success, and exit
    RTS

;;
;;  BoardShip  [$C609 :: 0x3C619]
;;    Attempts to board the ship.
;;

BoardShip:
    LDA ow_flags        ; is ship visible / available?
    AND #SHIP_VISIBLE
    BEQ Board_Fail      ; if not, fail

    LDA ship_x          ; is ship docked at current X/Y
    CMP tmp+2           ; coords?
    BNE Board_Fail
    LDA ship_y
    CMP tmp+3
    BNE Board_Fail      ; if not... fail

    LDA #$01
    STA vehicle         ; otherwise... set current vehicle to on foot
    LDA #$04
    STA vehicle_next    ; and next vehicle to ship
    LDA #$04
    STA vehchgpause     ; pause a little bit to board the ship

    LDA #0
    STA tileprop+1      ; kill tileprop+1 to prevent unwanted battles

    LDA #$45
    STA music_track     ; switch to music track $45 (the ship music)
    STA dlgmusic_backup
    
    CLC                 ; CLC for succes!
    RTS

;;
;;  DockShip  [$C632 :: 0x3C642]
;;    Docks the ship at current player coords.  CLCs to return success always
;;

DockShip:
    LDA ow_scroll_x     ; get X scroll
    CLC
    ADC #$07            ; add 7 to get player coord
    STA ship_x          ; put ship there

    LDA ow_scroll_y     ; same with Y coord
    CLC
    ADC #$07
    STA ship_y

    CLC                 ; CLC to indicate success

    LDA #$30
    STA $400C           ; silence noise (kills the "waves" sound)

    LDA #$44
    STA music_track     ; switch to music track $44 (overworld theme)
    STA dlgmusic_backup

    RTS                 ; exit

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Is On Bridge   [$C64D :: 0x3C65D]
;;
;;     Checks to see if the player is on a bridge (or the canal, since
;;  that functions exactly the same as a bridge when you're on foot).
;;
;;  IN:  tmp+2 = X coord to check
;;       tmp+3 = Y coord to check
;;
;;  OUT:          C = set if not on a bridge, clear if we are
;;       tileprop+1 = zerod if we are on a bridge
;;
;;     tileprop+1 is zerod if we go on a bridge to prevent a battle from
;;  occuring on a bridge (since you're technically on an ocean tile, it'd be a sea battle
;;  even though you're on foot!).  Since that would be silly, and because we wouldn't want
;;  a battle to happen at the same time as the bridge scene, that var is zerod.
;;
;;     HOWEVER -- tileprop+1 is zerod right before this routine is called!  So zeroing it
;;  here is redundant and pointless.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

IsOnBridge:
    LDA ow_flags
    AND #BRIDGE_VISIBLE
    BEQ IsOnCanal      ; if bridge isn't visible... fail -- skip to canal

    LDA tmp+2
    CMP bridge_x
    BNE IsOnCanal      ; if given X coord does not equal bridge X coord, fail

    LDA tmp+3
    CMP bridge_y
    BNE IsOnCanal      ; same with Y coord

OnABridgeSuccess:    
    LDA #0             ; otherwise... success!  we're on the bridge!
    STA tileprop+1     ;  zero the tileprop+1
    CLC                ; CLC to indicate success
    RTS                ; and exit

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Is On Canal   [$C666 :: 0x3C676]
;;
;;     Exactly the same as IsOnBridge -- only it just checks the canal
;;  and not the bridge (for use with the ship)
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

IsOnCanal:
    LDA ow_flags      ; do all the same checks as with IsOnBridge, but with the canal
    AND #CANAL_VISIBLE
    BEQ @Fail          ;  visibility

    LDA tmp+2
    CMP canal_x
    BNE @Fail          ; X coord

    LDA tmp+3
    CMP canal_y
    BEQ OnABridgeSuccess
    ;BNE @Fail          ; Y coord

    ;LDA #0             ; do all same stuff on success
    ;STA tileprop+1
    ;CLC
    ;RTS

  @Fail:
    SEC                ; SEC to indicate failure
    RTS                ; and exit


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  CallMusicPlay   [$C681 :: 0x3C691]
;;
;;    Calls the music play routine.  Comes in two flavors.  Both are the same, only
;;  CallMusicPlay_NoSwap does not swap the original bank back in.  Therefore CallMusicPlay_NoSwap
;;  should only be called from this bank (bank F) and only if the bank that's swapped in
;;  is unimportant.
;;
;;    The Music Play routine should be called once per frame unless all sound is stopped.  If sound is active,
;;  failure to call the music Play routine will result in unsteady tempo and other ugly audio effects.
;;
;;  IN:  cur_bank = bank to swap back to on exit (CallMusicPlay only)
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


CallMusicPlay_NoSwap:
    LDA #BANK_MUSIC     ; swap to music bank (where MusicPlay is)
    JSR SwapPRG_L
    JMP MusicPlay_L     ; jump to it, and return (do not swap back)

CallMusicPlay_L:    
CallMusicPlay:
    LDA #BANK_MUSIC     ; swap to music bank (for MusicPlay)
    JSR SwapPRG_L
    JSR MusicPlay_L     ; call MusicPlay
    LDA cur_bank        ; then swap back to previously supplied bank
    JMP SwapPRG_L       ;   before returning



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Get Overworld Tile  [$C696 :: 0x3C6A6]
;;
;;     Get's the overworld tile and special properties of the tile the
;;  party is currently standing on
;;
;;  OUT:  ow_tile
;;        tileprop_now
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


GetOWTile:
    LDA ow_scroll_x  ; get X scroll
    CLC
    ADC #$07         ; add 7 to get party's X coord
    STA tmp          ; put in tmp (low byte of pointer -- also the desired column)

    LDA ow_scroll_y  ; get Y scroll
    CLC
    ADC #$07         ; add 7 for party's Y coord
    AND #$0F         ; mask to keep in-bounds of the portion of the map that's loaded
    ORA #>mapdata    ; OR with high byte of mapdata to get the high byte of the pointer
    STA tmp+1        ; write it to high byte

    LDY #0           ; zero Y for indexing
    LDA (tmp), Y     ; get the tile ID that the party is on
    STA ow_tile      ; and record it

    ASL A                ; double it (2 bytes of properties per tile)
    TAX                  ; and put in X
    LDA tileset_prop, X  ; get the first property byte from the tileset
    AND #OWTP_SPEC_MASK  ; mask out the special bits
    STA tileprop_now     ; and record it
    LDA tileset_prop, X  ; get it again
    AND #OWTP_FOREST     ; see if the forest bit is on
    ;STA inforest         ; and store result in 'inforest'
    
    RTS              ; then exit


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Land Airship  [$C6B8 :: 0x3C6C8]
;;
;;    Attempts to land the airship at current player coords
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


LandAirship:
    LDA #0
    STA joy_a           ; erase A button catcher

    JSR AnimateAirshipLanding  ; do the animation of the airship landing

    LDA ow_scroll_x     ; get X scroll
    CLC
    ADC #$07            ; add 7 to get player's position
    STA tmp             ; and write to low byte of pointer

    LDA ow_scroll_y     ; get Y scroll
    CLC
    ADC #$07            ; add 7 for player position
    AND #$0F            ; mask low bits to keep within portion of map we have loaded in RAM
    ORA #>mapdata       ; or with high byte of mapdata pointer
    STA tmp+1           ; and store as high byte of our pointer

    LDY #0
    LDA (tmp), Y        ; get the current tile we're landing on

    ASL A                 ; *2, and throw in X
    TAX
    LDA tileset_prop, X          ; get that tile's properties
    AND #$08                     ; see if landing the airship on this tile is legal
    BEQ :+                       ; if not....
      JSR AnimateAirshipTakeoff  ; .... animate to have the airship take off again
      RTS                        ;      and exit

:   LDA ow_scroll_x     ; otherwise (legal land)
    CLC
    ADC #$07            ; get X coord again
    STA airship_x       ; park the airship there

    LDA ow_scroll_y
    CLC
    ADC #$07
    STA airship_y       ; same with Y coord

    LDA #$01
    STA vehicle_next    ; change vehicle to make the player on foot
    STA vehicle

    LDA #$44
    STA music_track     ; start music track $44 (overworld theme)
    STA dlgmusic_backup

    RTS                 ; and exit


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Prep Overworld  [$C6FD :: 0x3C70D]
;;
;;    Sets up everything for entering (or re-entering) the world map.
;;  INCLUDING map decompression.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

PrepOverworld:
    LDA #0
    STA $2000           ; disable NMIs
    STA $2001           ; turn off PPU
    ;STA $4015           ; silence APU
    ;STA $5015           ; silence MMC5 APU (JIGS)
    ;; ^ disabled to not restart music when exiting the menu
    STA smokebomb_steps ; smokebombs only work in dungeons and such!
    STA scroll_y        ; zero a whole bunch of other things:
    STA tileprop
    STA tileprop+1
    STA inroom
    STA entering_shop
    ;STA facing
    STA joy_a
    STA joy_b
    STA joy_start
    STA joy_select
    STA mapflags        ; zeroing map flags indicates we're on the overworld map
    STA ow_slow

    JSR LoadOWCHR           ; load up necessary CHR
    JSR LoadOWTilesetData   ; the tileset
    JSR LoadMapPalettes     ; palettes
    JSR DrawFullMap         ; then draw the map

    LDA ow_scroll_x      ; get ow scroll X
    AND #$10             ; isolate the '16' bit (nametable bit)
    CMP #$10             ; move it to C (C set if we're to use NT @ $2400)
    ROL A                ; roll that bit into bit 0
    AND #$01             ; isolate it
    ORA #$08             ; OR with 8 (sprites use right-hand pattern table)
    STA NTsoft2000       ; record this as our soft2000
    STA soft2000

    JSR WaitForVBlank_L       ; wait for a VBlank
    JSR DrawMapPalette        ; before drawing the palette
    JSR SetOWScroll            ;; JIGS v 
    ;JSR SetOWScroll_PPUOn     ; the setting the scroll and turning PPU on
    ;LDA #0                    ;  .. but then immediately turn PPU off!
    ;STA $2001                 ;     (stupid -- why doesn't it just call the other SetOWScroll that doesn't turn PPU on)

    ;LDX vehicle
    ;LDA @lut_VehicleMusic, X  ; use the current vehicle as an index
    ;STA music_track           ;   to get the proper music track -- and play it
    ;; JIGS ^ disabled because OverworldMusic is a new routine called below
    ;; and I think actually, standard maps use it too...
    
    LDA MenuHush
    BNE @NoChange
        LDX vehicle
        LDA lut_VehicleMusic, X  
        CMP dlgmusic_backup
        BEQ @NoChange
        STA music_track          
        STA dlgmusic_backup

   @NoChange:
    LDA #0
    STA MenuHush
    ;LDA #BANK_BTLDATA     ; swap to battle rate bank and get the battle rate for the overworld
    ;JSR SwapPRG_L         ;  (first entry in the table).  And record it to 'battlerate'.
    ;LDA lut_BattleRates   ; However, this value goes unused because the battle rate for overworld
    ;STA battlerate        ; is hardcoded... so this is effectively useless for OW (it's used for SM, though).
    
    LDA #DOWN
    STA facing              ; start the player facing downward
    
    RTS                   ; then exit!

  ;;  The lut for knowing which track to play based on the current vehicle
  ;; JIGS - no longer local

  lut_VehicleMusic:
  .BYTE $44               ; unused
  .BYTE $44               ; on foot
  .BYTE $44,$44           ; canoe (2nd byte unused)
  .BYTE $45,$45,$45,$45   ; ship (last 3 bytes unused)
  .BYTE $46               ; airship




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Map Poison Damage [$C7FB :: 0x3C80B]
;;
;;    Deals poison damage (-1 HP) to any poisoned party member, and plays
;;  the harsh "you're poisoned" sound effect.
;;
;;    It is called only when the player is moving.  If it is called when the player
;;  is stationary, then the sound effect would never stop, and party HP would rapidly
;;  drain (1 HP per frame!)
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

MapPoisonDamage:              ; first thing is to check if ANY characters are poisoned.
    LDA ch_ailments           ; so combine their ailments 
    ORA ch_ailments + (1<<6)   
    ORA ch_ailments + (2<<6)
    ORA ch_ailments + (3<<6)
    AND #AIL_POISON           ; AND out anything that's not poison
    BNE @DoIt
   @Exit: 
    RTS                          ; if nobody poisoned, just exit

   @DoIt:
    LDA domappoison
    BMI @SFX
    ;mappoison must be set high bit in order to do SFX and red tint    
    ;but if move_speed is not 0, don't do anything.
    ;once move_speed is 0, decrement domappoison for this step
    
    LDA move_speed
    BNE @Exit
  
    DEC domappoison
    RTS

   @SFX:
    ; play the "you're poisoned" sound effect
    ;LDA #%00111010          ; 12.5% duty (harsh), volume=$A
    ;STA $4004
    ;LDA #%10000001          ; sweep downward in pitch
    ;STA $4005
    ;LDA #$60
    ;STA $4006               ; start at F=$060
    ;STA $4007

    ;LDA #$06                ; indicate sq2 is busy with sound effects for 6 frames
    ;STA sq2_sfx
    
    ;; turn on red emphasis
    LDA #%00111110    
    STA $2001             
    
    ;; and play a scrapey sort of damage noise
    LDA #$1B
    STA $400C
    LDA #$08
    STA $400E 
    LSR A ; #4
    STA $400F             
    ;; check move speed again...!
    LDA move_speed          ; see if party is moving (or really, "has moved")
    BNE @Exit               ; if not... do damage
    ; otherwise... don't do damage... just exit.
    
    LDA #BANK_Z
    JSR SwapPRG_L
    JMP MapPoisonDamage_Z
    
    ;   This might take some explaining.  This seems contradictory to what I say in the routine
    ; description ("It is called only when the player is moving").  Due to the order in which
    ; this routine is called... move_speed will be zero at this point if the player just completed
    ; a move across a tile (ie:  they moved a full 16 pixels).  move_speed will be nonzero if they
    ; moved less than that.
    ;   Without doing this check, poisoned characters would be damaged every FRAME rather than every step
    ; (which would end up being -16 HP per step, since the player moves 1 pixel per frame).  With this check,
    ; damage is only dealt once the move is completed (so only once per step)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Minigame Reward [$C8A4 :: 0x3C8B4]
;;
;;    Called when you complete the mini game successfully
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

MinigameReward:
    LDA #100          ; just give the party 100 GP
    STA tmp
    LDA #0
    STA tmp+1
    LDA #0
    STA tmp+2

    JMP AddGPToParty


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Do Standard Map  [$C8B3 :: 0x3C8C3]
;;
;;    Enters a standard map, loads all appropriate objects, CHR, palettes... everything.
;;  Then does the standard map loop
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

DoStandardMap:
    JSR EnterStandardMap     ; load and prep map stuff
                             ;  then flow seamlessly into StandardMapLoop
     ; no JMP or RTS


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Standard Map Loop  [$C8B6 :: 0x3C8C6]
;;
;;    This is THE loop for game logic when in standard maps.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

StandardMapLoop:
    JSR WaitForVBlank_L        ; wait for VBlank
    LDA #>oam                  ; and do Sprite DMA
    STA $4014
    JSR StandardMapMovement    ; then do movement stuff (involves possible screen drawing)
                               ;   this also sets the scroll
  
    LDA music_track        ; if no music track is playing...
    BPL :+
      LDA dlgmusic_backup  ;; JIGS - start map music again!
      STA music_track
      
:   JSR CallMusicPlay_NoSwap   ; keep music playing

    LDA mapdraw_job            ; check the map draw job
    CMP #1                     ;  if the next job is to draw attributes
    BNE :+                     ;  then we need to prep them here so they're ready for
      JSR PrepAttributePos     ;  drawing next frame

:   LDA move_speed             ; check the player's movement speed to see if they're in motion
    BNE @Continue              ;  if they are, skip over input and some other checks, and just continue to next
                               ;  loop iteration
            ;  This next bit is done only if the player isn't moving, or if they just completed
            ;  a move this frame
      LDA altareffect       ; do the altar effect if its flag is set
      BEQ :+
        JSR DoAltarEffect

:     LDA entering_shop     ; jump ahead to shop code if entering a shop
      BNE @Shop

      LDA tileprop          ; lastly, check to see if a battle or teleport is triggered
      CMP #TP_BATTLEMARKER  ; if tileprop = $FF, its a battle
      BEQ @Battle
      CMP #TP_TELE_WARP
      BEQ @Warp
      CMP #TP_TELE_NORM
      BEQ @NormalTeleport
      CMP #TP_TELE_EXIT
      BEQ @ExitTeleport

      JSR ProcessSMInput    ; if none of those things -- process input, and continue
  @Continue:
    JSR ClearOAM            ; clear OAM
    JSR DrawSMSprites       ; and draw all sprites
    JMP StandardMapLoop     ; then keep looping

  @Shop:
   ; JSR GetSMTilePropNow    ; get the 'now' properties of the tile the player is on
    LDA #0                  ;   this seems totally useless to do here
    STA inroom              ; clear the inroom flags so that we're out of rooms when we enter the shop
    ;LDA #2                 ;   this is to counter the effect of shop enterances also being doors that enter rooms
    ;JSR StopNoise_StopSprites  ; do the palette cycle effect (code 2 -- standard map, cycle out)

    LDA #BANK_MENUS         ; swap to menu bank
    JSR SwapPRG_L
    JSR EnterShop           ; enter the shop
    JSR SMMove_Down         ; JIGS - set player 1 tile below shop door
   
    JSR ReenterStandardMap  ;  then reenter the map
    LDA sm_player_x
    AND #$3F
    STA sm_player_x
    LDA sm_player_y
    AND #$3F
    STA sm_player_y         ; JIGS - update the thing that stops NPCs from walking through you
    
    JMP StandardMapLoop     ;  and continue looping

  ;; here if the player is to teleport, or to start a fight
  @Battle:
   ; JSR GetSMTilePropNow    ; get 'now' tile properties (don't know why -- seems useless?)
    LDA #0
    STA tileprop            ; zero tile property byte to prevent unending battles from being triggered
    JSR EnterBattle_L       ; start the battle!
    BCC :+                  ;  see if this battle was the end game battle

    @VictoryLoop:
      JSR LoadEpilogueSceneGFX
      LDA #BANK_ENDINGSCENE
      JSR SwapPRG_L
      JSR EnterEndingScene
      JMP @VictoryLoop

:   JSR ReenterStandardMap  ; if this was just a normal battle, reenter the map
    JMP StandardMapLoop     ; and resume the loop

  @ExitTeleport:
    JMP @NextExitTeleport ; to deal with range errors...

  @Warp:                   ; code reaches here if we're teleporting or warping
    JMP ScreenWipe_Close   ; ... so just close the screen with a wipe and RTS.  This RTS
    ;RTS                   ;   will either go to the overworld loop, or to one "layer" up in this SM loop

  @NormalTeleport:        ; normal teleport!
    LDA sm_scroll_x       ;  push the scroll (player position), inroom flags,
    PHA                   ;  map, and tileset to the stack
    LDA sm_scroll_y       ; This stuff is all recorded on the stack for
    PHA                   ; WARP purposes
    LDA inroom
    PHA
    LDA cur_map
    PHA
    LDA cur_tileset
    PHA
    
    JSR @TeleportThing  

    LDX tileprop+1          ; get the teleport ID in X for indexing teleport data

    LDA lut_NormTele_X, X   ; get the X coord to teleport to
    SEC                     ;  subtract 7 from desired player coord
    SBC #7                  ;  and wrap to get scroll pos
    AND #$3F
    STA sm_scroll_x

    LDA lut_NormTele_Y, X   ; do same with Y coord
    SEC
    SBC #7
    AND #$3F
    STA sm_scroll_y

    LDA lut_NormTele_Map, X ; get the map and record it
    STA cur_map

    TAX                     ; then throw the map in X, and use it to get
    LDA lut_Tilesets, X     ; the tileset for this map
    STA cur_tileset

    JSR DoStandardMap       ; JSR to DoStandardMap -- which runs a NEW instance of this loop
                            ;  this will only return if/when the player WARPs back to this floor
    PLA                     ; and which point we pull all the above stuff we pushed
    STA cur_tileset         ;  to return to the position we were at before the normal teleport
    PLA
    STA cur_map
    PLA
    STA inroom
    PLA
    STA sm_scroll_y
    PLA
    STA sm_scroll_x

    JMP DoStandardMap       ; then JMP to DoStandardMap to reload everything that needs reloading
                            ;   and do the map loop
  @TeleportThing:
    JSR ScreenWipe_Close    ; wipe the screen closed
    LDA #BANK_TELEPORTINFO  ; swap to the bank containing teleport info
    JMP SwapPRG_L                            

  @NextExitTeleport:       
    JSR @TeleportThing

    LDX tileprop+1          ; get the teleport ID in X
    LDA lut_ExitTele_X, X   ;  get X coord
    SEC                     ;  subtract 7 to get the scroll
    SBC #7
    STA ow_scroll_x

    LDA lut_ExitTele_Y, X   ; do same with Y coord
    SEC
    SBC #7
    STA ow_scroll_y

    JMP DoOverworld         ; then jump to the overworld    


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Process SM input   [$C23C :: 0x3C24C]
;;
;;    Updates joy data and does input processing for standard maps.  Shouldn't
;;  be called when player is in motion.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


ProcessSMInput:  
    LDA joy_a              ; see if user pressed the A button
    BEQ @CheckStart        ; if not, skip ahead to check Start button.  Otherwise...

 ;;
 ;; A button pressed
 ;;

      LDA #0
      STA joy_a              ; clear A button marker
      STA dlgsfx             ;  and a few dialogue flags
      STA dlgflg_reentermap

      JSR WaitForVBlank_L      ; wait for VBlank and keep music playing
      JSR CallMusicPlay_NoSwap ;   seems weird to do this stuff here -- game probably doesn't need to wait a frame

      LDA facing               ; use the direction the player is facing
      JSR GetSMTargetCoords    ;  as the direction to get SM target coords

      LDA mapspritehide        ; player sprite is hidden; either under a bridge or in water
      BNE @TalkToTile          ; so restrict talking to NPCs

      JSR CanTalkToMapObject   ; see if there's a map object at those target coords
      STX talkobj              ; store the index to that object (if any) in talkobj
      PHP                      ; back up the C flag (whether or not there was an object to talk to)

      LDA #4*4                    ; redraw all map objects starting at the 4th sprite
      STA sprindex                ;  this will cause the object we're talking to (if any) to face the player
      JSR DrawMapObjectsNoUpdate  ;  we start at the 4th sprite so the player's sprite doesn't get overwritten

      PLP                ; restore C flag
      LDX talkobj        ; and index of object to talk to
      BCC @TalkToTile    ; examine C flag to see if there was an object to talk to.  If there was....

        JSR DecompressKeyItems ; JIGS - do this before interacting, in case item IDs need to be read!

        LDA #0
        STA tileprop        ; clear tile properties (prevent unwanted teleport/battle)
        STA item_box, X     ; and set the end of item_box 

        LDA #BANK_TALKTOOBJ ; swap to bank containing TalkToObject routine
        JSR SwapPRG_L
        JSR TalkToObject    ; then talk to this object.
        JMP @DialogueBox


      @TalkToTile:          ; if there was no object to talk to....
        JSR TalkToSMTile    ; ... talk to the SM tile instead (open TC or just get misc text)
        BEQ :+              ; if "nothing here" text, skip dialogue box
        LDX #0              ; clear tile properties (prevent unwanted teleport/battle)
        STX tileprop

     ;; whether we talked to an object or the SM tile, here, A contains the dialogue
     ;; text ID we need to draw

    @DialogueBox:
      JSR DrawDialogueBox     ; draw the dialogue box and containing text

      JSR WaitForVBlank_L       ; wait a frame
      LDA #>oam                 ;   (this is all typical frame stuff -- set scroll, play music, etc)
      STA $4014
      JSR SetSMScroll
      LDA #$1E
      STA $2001
      JSR CallMusicPlay_NoSwap

      JSR ShowDialogueBox       ; actually show the dialogue box.  This routine exits once the box closes

      LDA dlgflg_reentermap     ; check the reenter map flag
      BEQ :+
        JMP ReenterStandardMap  ; ... and reenter map if set

:     LDA #0            ; then clear A, Start and Select button catchers
      STA joy_a
      STA joy_start
      STA joy_select
      RTS               ; and exit

  ;; if A button wasn't pressed, it jumps here to check for Start

@CheckStart:
    LDA joy_start      ; check to see if Start pressed
    BEQ @CheckSelect   ; if not... jump ahead to check select.  Otherwise....

 ;;
 ;; Start button pressed
 ;;
      JSR DoMainMenu        ; enter the main menu
      JMP ReenterStandardMap   ; then reenter the map

  ;; if neither A nor Start pressed... jumps here to check select

@CheckSelect:
    LDA joy_select       ; is select pressed?
    BEQ @CheckDirection  ; if not... jump ahead.  Otherwise...

 ;;
 ;; Select button pressed
 ;;
      ;; JIGS - here we have the sound test menu!
  
      LDA joy
      AND #$40          ; see if B is held down
      BEQ @Pause        ; if not, just pause!
    
        LDA #BANK_MINIMAP
        JSR SwapPRG_L
        JSR EnterMinimap
        ;JSR SoundTestMenu  
        JMP ReenterStandardMap
      
    @Pause:
      ;LDA #BANK_MENUS
      ;JSR SwapPRG_L
      ;JSR EnterLineupMenu      ; but since they pressed select -- enter lineup menu, not main menu
      ;JMP ReenterStandardMap
      JMP PauseGame
      
  ;; A, Start, Select -- none of them pressed.  Now check directional buttons

@CheckDirection:
    JSR UpdateJoy       ; update joy data
    LDA joy             ; get updated data, and isolate the directional buttons
    AND #$0F
    BNE @Move           ; if any buttons down, move in that direction
  @Exit:                ;  otherwise, just exit
      RTS
  @Move:
      STA facing           ; record directions pressed as our new facing direction
      JSR CanPlayerMoveSM  ; check to see if the player can move that way
      BCS @Exit            ; if not... exit
      JMP StartMapMove     ; otherwise... start them moving that direction, and exit


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  CanPlayerMoveSM  [$CA76 :: 0x3CA86]
;;
;;    Checks to see if a player can move in the desired direction on
;;  Standard Maps.
;;
;;  OUT:  C = set if player cannot move, clear if they can move
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

CanPlayerMoveSM:
    JSR GetSMTilePropNow    ; see if under or over a bridge
    CMP #TP_SPEC_BRIDGEHORZ ; =
    BNE :+
    
   @HorizontalBridge: 
    LDA mapspritehide ; if under it (1), allow movement north-south only
    BEQ @EastWest    ; if below (0), allow movement east-west only
    
   @NorthSouth:
    LDA facing
    LSR A       ; Put Right bit in carry
    BCS @CantMove
    LSR A       ; Put Left bit in carry
    BCS @CantMove
    BCC :++     ; no need to check up/down bits; movement is allowed

  : CMP #TP_SPEC_BRIDGEVERT ; ||
    BNE :+  
    
   @VerticalBridge:
    LDA mapspritehide ; if under it (1), allow movement east-west only
    BEQ @NorthSouth  ; if below (0), allow movement north-south only
  
   @EastWest:
    LDA facing
    LSR A       ; put Right bit in carry
    BCS :+
    LSR A       ; put Left bit in carry
    BCS :+
    BCC @CantMove ; otherwise, can't move, because trying to walk off the side of the bridge
    
  : LDA facing
    JSR GetSMTargetCoords      ; get target coords (coords which player is attempting to move to)
    JSR IsObjectInPath         ; see if a map object is in their path
    BCS @CantMove              ; if yes... path is blocked -- can't move

    JSR GetSMTileProperties        ; otherwise, get the properties of the tile they're moving to
    LDA tileprop
    ;AND #TP_SPEC_MASK | TP_NOMOVE  ; mask out special and NOMOVE bits
    ;CMP #TP_NOMOVE                 ; if all special bits clear, and NOMOVE bit is set
    AND #TP_NOMOVE
    BNE @CantMove                  ; then this is a nomove tile -- can't move here

    LDA tileprop_now
    CMP #TP_SPEC_DEEPWATER
    BNE @NormalCheck

    LDA tileprop                ; reaches here if player currently standing in water
    CMP #TP_SPEC_BRIDGEHORZ     ; check if the tile falls in the range of bridges, deep water, and water access
    BCC @CantMove               ; if its below, can't get out
    CMP #TP_SPEC_WATERACCESS+1  ; 
    BCS @CantMove               ; if its above, can't get out
    
   @NormalCheck: 
    LDA tileprop
    AND #TP_SPEC_MASK            ; otherwise, toss the NOMOVE bit and keep the special bits
    ASL A                        ; double it
    TAX                          ; throw that in X for indexing
    LDA lut_SMMoveJmpTbl, X      ; use it as an index to get a pointer from the jump table
    STA tmp
    LDA lut_SMMoveJmpTbl+1, X
    STA tmp+1
    TXA                          ; put special bits back in A for the upcoming routines
    JMP (tmp)                    ; jump to the routine in the jumptable

  @CantMove:
    LDA #0                     ; if they couldn't move...
    STA tileprop               ; clear tile properties to prevent a battle or teleport
    STA tileprop+1             ; or somesuch
    SEC                        ;  and SEC to indicate they can't move
    RTS

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  IsObjectInPath  [$CAA2 :: 0x3CAB2]
;;
;;    Checks to see if an objects in in the player's walking path.  If
;;  there is an object in the path, this routine also "shoves" the object
;;  out of the way so that the space the playing is trying to move to vacates
;;  sooner.
;;
;;  IN:  tmp+4 = X coord player is attempting to move to
;;       tmp+5 = Y coord
;;
;;  OUT:     C = set if object is occupying that space (preventing player from moving)
;;                clear if space is clear
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

IsObjectInPath:

     ;; First, loop through all objects to see if any are physically on this space
     ;;  this would prevent the player from moving here

    LDX #0                  ; clear our loop counter (and object index)
  @CutLoop:
     LDA mapobj_id, X       ; check this object's ID to make sure it exists
     BEQ @CutNext           ;  if it's zero, the object doesn't exist.  Skip

     LDA mapobj_physX, X    ; check the object's physical X coord
     CMP tmp+4              ;  compare to given X coord
     BNE @CutNext           ;  if they don't match, not walking into this object.  Skip

     LDA mapobj_physY, X    ; Do same with Y coords
     CMP tmp+5
     BNE @CutNext
                            ; if we're here... we are colliding with this object
     LDA mapobj_movectr, X  ; get the object's move counter
     AND #3                 ;  and "cut" its high bits.  This will help make the object
     STA mapobj_movectr, X  ;  move faster if you walk into it because it shrinks the delay
                            ;  until their next step
     SEC                    ; then SEC to indicate collision with object
     RTS                    ; and exit!

  @CutNext:                 ; CutLoop reaches here if we did not collide with the tested object
    TXA                     ; add $10 to our loop counter/index to look at next object
    CLC
    ADC #$10
    TAX
    CMP #$F0                ; and loop until all 15 objects tested
    BCC @CutLoop

    ;; code reaches here if all 15 objects have been tested, and there were no objects in
    ;;  the path.  Next step is to see if an object is currenting in movement FROM the tile
    ;;  we're trying to move to.  If they are, we set their "shove" flag so that they walk
    ;;  faster.

    ;; to find where the object is moving from, the game uses the graphical (not physical) coords.
    ;;  If in a negative move (left or up), the coord their moving from is +1 from their graphical
    ;;  coord.  For positive moves, you can use the graphical coord as-is.  The game uses the
    ;;  X/Y speed of the object to determine positive/negative movement.

    LDX #0                  ; we'll be looping through objects again -- reset loop counter to zero

  @ShoveLoop:
      LDA mapobj_id, X      ; check object ID to make sure this object exists
      BEQ @ShoveNext        ; if zero, object doesn't exist -- skip

      LDA mapobj_spdX, X    ; next check speeds to see if this is a negative move
      BMI @CheckLeft        ;  if X speed is negative, Check 'Left' movement
      LDA mapobj_spdY, X    ; if Y speed is negative, do 'Up' movement
      BPL @CheckPos         ;  but if Y is positive, jump to 'Pos' movement

  @CheckUp:
    LDA mapobj_gfxX, X      ; if moving up... check X coord (we can use this as-is)
    CMP tmp+4               ; and compare to given X coord
    BNE @ShoveNext          ;  if not a match, skip this object (not moving from the given coords)

    LDA mapobj_gfxY, X      ; next, add 1 to the object's Y coord to counter the
    CLC                     ; negative movement
    ADC #1
    AND #$3F                ; mask to wrap around the edge of the map
    CMP tmp+5               ; and compare to given Y coord
    BNE @ShoveNext          ; if not a match, skip this object

    BEQ @DoShove            ; otherwise it is a match, so do the shove (always branches)


  @CheckLeft:               ; left movement is same idea, only we add 1 to the X
    LDA mapobj_gfxX, X      ;   coord instead because we have negative X movement
    CLC
    ADC #1
    AND #$3F
    CMP tmp+4
    BNE @ShoveNext

    LDA mapobj_gfxY, X
    CMP tmp+5
    BNE @ShoveNext

    BEQ @DoShove


  @CheckPos:                ; positive movement (right/down) doesn't need that adjustment
    LDA mapobj_gfxX, X      ; just check the X/Y coords as-is
    CMP tmp+4
    BNE @ShoveNext
    LDA mapobj_gfxY, X
    CMP tmp+5
    BNE @ShoveNext


  @DoShove:                 ; code reaches here if an object is moving from the given coords
    LDA #1
    STA mapobj_pl, X        ; set their player interaction var to indicate they're being shoved
    CLC                     ; CLC to indicate no objects are obstructing player's path
    RTS                     ; and exit!


  @ShoveNext:             ; reaches here if the object didn't match.  Do next loop iteration
    TXA                   ;  add $10 to object index to test next object
    CLC
    ADC #$10
    TAX
    CMP #$F0              ; and loop until all 15 objects checked
    BCC @ShoveLoop

    CLC                   ; CLC to indicate no objects in path
    RTS                   ; and exit!

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  CanTalkToMapObject  [$CB25 :: 0x3CB35]
;;
;;    Checks to see if there is a map object at the given coords that the player
;;  can talk to.
;;
;;  IN:  tmp+4 = X coord to check
;;       tmp+5 = Y coord to check
;;
;;  OUT:     C = set if there was an object to talk to, clear if no object
;;           X = map object index of the object you can talk to (if any)
;;
;;    This routine does not check the physical X position of the object, rather it does it
;;  based on its graphic position.  Which makes for a much cleaner result -- if it was done by physical
;;  position, you wouldn't be able to talk to people if they just started to take a step because they
;;  physical position updates immediately, whereas the graphical position is a better representation
;;  of where they are.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

CanTalkToMapObject:
    LDX #0                 ; X is loop counter and object index

  @Loop:
    LDA mapobj_id, X       ; get this object's ID
    BEQ @NoMatch           ; if zero, this object doesn't exist, so it's not a match (can't talk to nothing)

    LDA mapobj_ctrX, X     ; get the X counter (fine X scroll of the object -- see how far between tiles it is)
    CMP #8                 ; if >= 8 (greater than halfway between two tiles)
    LDA mapobj_gfxX, X     ;  add an additional 1 to the graphic position.  This is accomplished because the
    ADC #0                 ;  above CMP sets C, which gets added with the following ADC
    AND #$3F               ; That is the X position of the object to use.  Mask to wrap around edge of map.
    CMP tmp+4              ; see if that matches the given X coord
    BNE @NoMatch           ;  if not... no match -- we're not talking to this object

    LDA mapobj_ctrY, X     ; do all the same stuff with the Y coord
    CMP #8
    LDA mapobj_gfxY, X
    ADC #0
    AND #$3F
    CMP tmp+5
    BNE @NoMatch

    LDA mapobj_pl, X       ; if X and Y coords check out, we're talking to this object!
    ORA #$80               ; set the 'talking to player' bit for the object so that they face the player.
    STA mapobj_pl, X

    SEC                    ; SEC to indicate an object was found
    RTS                    ;  and exit

  @NoMatch:           ; if object didn't match...
    TXA               ;  add $10 to loop index to examine next object
    CLC
    ADC #$10
    TAX
    CMP #$F0          ; and loop until all 15 objects checked
    BCC @Loop

    CLC               ; if none of the 15 matched, CLC to indicate failure
    RTS               ; and exit

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  GetSMTargetCoords  [$CB61 :: 0x3CB71]
;;
;;    Get's the X,Y coords that the player is targetting (facing)
;;  For standard maps only.
;;
;;  IN:      A = facing  ('facing' var is not used directly)
;;
;;  OUT: tmp+4 = target X coord
;;       tmp+5 = target Y coord
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

GetSMTargetCoords:
    LSR A          ; check facing and fork appropriately
    BCS @Right
    LSR A
    BCS @Left
    LSR A
    BCS @Down

  @Up:
    LDX #7         ; load x additive into X, and y additive into Y
    LDY #7-1       ; scroll + 7 is where the player is, so scroll + 7-1 would
    JMP @Done      ; be up one tile from the player, etc.
  @Down:
    LDX #7
    LDY #7+1
    JMP @Done
  @Right:
    LDX #7+1
    LDY #7
    JMP @Done
  @Left:
    LDX #7-1
    LDY #7

  @Done:
    TXA               ; get X additive into A
    CLC
    ADC sm_scroll_x   ; add scroll to it
    AND #$3F          ; wrap around edge of map
    STA tmp+4         ; and record it

    TYA               ; do same with Y coord
    CLC
    ADC sm_scroll_y
    AND #$3F
    STA tmp+5

    RTS               ; done

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Get SM Tile PropNow [$CB94 :: 0x3CBA4]
;;
;;     Get's the special properties of the tile the party is currently standing on
;;  for standard maps.
;;
;;  OUT:  tileprop_now
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

GetSMTilePropNow:
    LDA sm_scroll_y       ; get Y scroll
    CLC
    ADC #$07              ; add 7 to get player's Y position
    AND #$3F              ; wrap around edges of map
    TAX                   ; put the y coord in X

    LSR A                 ; right shift y coord by 2 (the high byte of *64)
    LSR A
    ORA #>mapdata         ; OR to get the high byte of the tile entry in the map
    STA tmp+1             ; store to source pointer

    TXA                   ; restore y coord
    ROR A                 ; rotate right by 3 and mask out the high 2 bits.
    ROR A                 ;  same as a left-shift-by-6 (*64)
    ROR A
    AND #$C0
    STA tmp               ; store as low byte of source pointer (points to start of row)

    LDA sm_scroll_x       ; get X scroll
    CLC
    ADC #$07              ; add 7 for player's X position
    AND #$3F              ; wrap around map boundaries
    TAY                   ; put in Y for indexing this row of map data

    LDA (tmp), Y          ; get the tile from the map
    ASL A                 ; *2  (2 bytes of properties per tile)
    TAX                   ; put index in X
    LDA tileset_prop+1, X
    STA tileprop_now+1
    LDA tileset_prop, X   ; get the first property byte
    AND #TP_SPEC_MASK     ; isolate the 'special' bits
    STA tileprop_now      ; and record them!
    RTS                   ; exit

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  GetSMTileProperties  [$CBBE :: 0x3CBCE]
;;
;;    Loads 'tileprop' with the unaltered properties of the tile at
;;  given coords.  For Standard Maps only
;;
;;  IN:  tmp+4 = X coord
;;       tmp+5 = Y coord
;;
;;  OUT: tileprop = 2 bytes of tile properties
;;
;;    X remains unchanged by this routine.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

GetSMTileProperties:
    LDA tmp+5          ; take the Y coord
    LSR A              ; right shift by 2 to get the high byte of *64
    LSR A
    ORA #>mapdata      ; OR with high byte of map data pointer
    STA tmp+1          ; this is high byte of pointer to tile in the map

    LDA tmp+5          ; get Y coord again
    ROR A
    ROR A
    ROR A
    AND #$C0           ; *64 (low byte this time)
    ORA tmp+4          ; OR with X coord
    STA tmp            ; this is low byte of pointer

    LDY #0                ; zero Y for indexing
    LDA (tmp), Y          ; get the tile from the map
    ASL A                 ;  *2 (2 bytes per tile)
    TAY                   ; throw in Y for indexing

    LDA tileset_data, Y   ; copy the two bytes of tile properties
    STA tileprop
    LDA tileset_data+1, Y
    STA tileprop+1
    RTS                   ;then exit!

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  TalkToSMTile [$CBE2 :: 0x3CBF2]
;;
;;    This routine "talks" to a given SM tile.  It is called when the user presses
;;  the A button in a standard map and there are no map objects for them to talk to.
;;  It either opens a chest, returns some special text associated with the tile, or
;;  shows the notorious "Nothing Here" text.
;;
;;  IN:  tmp+4 = X coord of tile to talk to
;;       tmp+5 = Y coord
;;
;;  OUT:     A = ID of dialogue to print to the screen
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

TalkToSMTile:
    JSR GetSMTileProperties   ; get the properties of the tile at the given coords
    STY tmp+10                ; backup Y

    LDA #BANK_DIALOGUE        ; set the bank to print from
    STA DialogueBank        
    
    LDA tileprop              ; get 1st property byte
    AND #TP_SPEC_MASK         ;  see if its special bits indicate it's a treasure chest
    CMP #TP_SPEC_TREASURE
    BEQ @TreasureChest        ; if it is, jump ahead to TC routine
    CMP #TP_SPEC_TREASURE_2
    BEQ @TreasureChest2       ; if it is, jump ahead to TC routine
    CMP #TP_SPEC_CUREAIL      ; then see if its under this...
    BCS :+                    ; if its over, skip ahead
        CMP #TP_SPEC_HP       ; if under, see if its over this.
        BCS @SwapBanks        ; and if over, swap banks to handle things

  : LDA tileprop              ; otherwise, reload property byte
    AND #TP_HASTEXT_MASK      ; see if the HASTEXT bit is set
    BEQ @Nothing              ; if not... force "Nothing Here" text

    LDA tileprop+1            ; otherwise, simply use the 2nd property byte as the dialogue
    RTS                       ;  tied to this tile, and exit

  @Nothing:                   ; if forced "Nothing Here" text...
    LDA #DLGID_NOTHING
    RTS

  @TreasureChest:             ; if the tile is a treasure chest
    LDX tileprop+1            ; put the chest ID in X
    LDA game_flags, X         ; get the game flag associated with that chest
    AND #GMFLG_TCOPEN         ;   to see if the chest has already been opened
    BNE :+                    

  @TreasureChest2:            ; if the tile is a treasure chest
    LDX tileprop+1            ; put the chest ID in X
    LDA game_flags, X         ; get the game flag associated with that chest
    AND #GMFLG_TCOPEN_2       ;   to see if the chest has already been opened
  : BEQ :+                    ; if it has....
      JSR IsThisAChest        ; if its not a chest tile, don't print any dialogue
      BNE @Nothing
      LDA #DLGID_EMPTYTC      ; select "The Chest is empty" text, and exit
      RTS
      
  : JMP OpenTreasureChest     ; otherwise, open the chest
  
   @SwapBanks:
    LDA #BANK_MENUS
    JSR SwapPRG_L
    JSR TalkToTile_BankE  ; do the healing routines here
    LDA #20               ; loop for 20 frames
    STA tmp+10
    
   @FlashyLoop: 
    LDA framecounter      ; get the frame counter
    AND #$01              ; isolate low bit and use as a quick monochrome toggle
    ORA #%10011110        ; set blue colour emphasis, keep PPU on, no greyscale
    STA $2001 
    
    JSR WaitForVBlank
    JSR CallMusicPlay_NoSwap
    DEC tmp+10
    BNE @FlashyLoop
    
    LDA #%00011110        ; turn off blue colour emphasis, keep PPU on, no greyscale
    STA $2001 
    LDA tileprop+1        ; finally, get the message to display
    RTS


;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Load Standard Map Tileset Data  [$CC08 :: 0x3CC18]
;;
;;    Loads the tile property table, TSA tables, and map palette for the current
;;  standard map.  Fills the following buffers:
;;
;;    tileset_prop
;;    tsa_ul, tsa_ur, tsa_dl, tsa_dr
;;    tsa_attr
;;    load_map_pal
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;

LoadSMTilesetData:
    LDA #BANK_SMINFO          ; swap to bank containing desired info
    JSR SwapPRG_L

 ; load tileset properties

    LDA cur_tileset           ; set src pointer to point to lut_SMTilesetProp
    ASL A
    TAX
    LDA lut_SMTilesetProp, X
    STA tmp
    LDA lut_SMTilesetProp+1, X
    STA tmp+1
    
    LDA #<tileset_data
    STA tmp+2
    LDA #>tileset_data        ; set destination to tileset_data
    STA tmp+3

    JSR Copy256               ; load 256 byte of tile properties (incs dest pointer)
    ;; note this does not touch X

 ; load tileset TSA

    LDA lut_SMTilesetTSA, X
    STA tmp
    LDA lut_SMTilesetTSA+1, X
    STA tmp+1

    JSR Copy256               ; copy the first 256 bytes of tsa data
    INC tmp+1                 ; inc src pointer
    JSR Copy256               ; and copy the second 256 bytes of tsa data

 ; load tileset attributes
 
    JMP DecompressSMAttributes ; will also load the palette
    ;JMP LoadSmallMapPalettes

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Copy 256  [$CC74 :: 0x3CC84]
;;
;;    Copies 256 bytes from (tmp) to (tmp+2).  High byte of dest pointer (tmp+3)
;;  is incremented.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

Copy256:
    LDY #0             ; start Y at zero
  @Loop:
      LDA (tmp), Y     ; copy a byte
      STA (tmp+2), Y
      INY
      BNE @Loop        ; loop until Y wraps (256 iterations)

    INC tmp+3          ; inc dest pointer
    RTS                ; and exit

    
    
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Standard Map Movement  [$CC80 :: 0x3CC90]
;;
;;    This moves the party on the standard maps, deals movement damage where appropriate,
;;  and does various other things related to movement.  It also sets the scroll appropriate
;;  for the screen.
;;
;;    Note however it does not do collision detection or the like -- it simply carries out moves
;;  that have already begun -- just like OverworldMovement.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

StandardMapMovement:
    LDA #$1E
    STA $2001             ; turn the PPU on

    JSR RedrawDoor        ; redraw an opening/closing door if necessary

    ;LDA $2002             ; reset PPU toggle (seems unnecessary, here)

    LDA move_speed        ; see if the player is moving
    BEQ SetSMScroll       ; if not, just skip ahead and set the scroll
                          ; the rest of this is only done during movement
      JSR SM_MovePlayer   ; Move the player in the desired direction
      JSR MapPoisonDamage   ; do poison damage

      LDA tileprop          ; get the properties for this tile
      AND #TP_SPEC_MASK     ; mask out the special bits
      CMP #TP_SPEC_DAMAGE   ; see if it's a damage tile (frost/lava)
      BEQ MapTileDamage     ; if it is ... do map tile damage
      RTS
      
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Map Tile Damage  [$C7DE :: 0x3C7EE]
;;
;;    Flashes the screen, plays the "ksssshhh" sound effect, and assigns
;;  map tile damage for when the player is walking over damage tiles like
;;  lava/frost.
;;
;;    Note it does not check to see if the player is on such a damage tile -- it assumes
;;  that check has been done already.  Therefore this routine must only be called when the
;;  player is on such a tile.  Also, this routine must only be called when the player is moving,
;;  otherwise HP would rapidly drain (1 HP per frame) from just the player standing stationary on
;;  the tile.
;;
;;    This routine branches (not JMP!) to AssignMapTileDamage, so it must be somewhere near that routine.
;;  Seems odd that it does that -- it's like it just lets this routine be interrupted by MapPoisonDamage
;;  for whatever reason.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


MapTileDamage:
    LDX lead_index
    LDA ch_miscperks, X
    AND #LIGHTSTEP
    BNE @Nah              ; if the lead has the Light Step support ability, don't do any tile damage    

    LDA framecounter      ; get the frame counter
    AND #$01              ; isolate low bit and use as a quick monochrome toggle
    ORA #%00111110        ; OR with typical PPU flags (JIGS - plus red emphasis! ow!)
    STA $2001             
    ; and write to PPU reg.  This results in a rapid toggle between
    ;  normal/monochrome mode (toggles every frame).  This produces the flashy effect

    LDA #$0F              ; set noise to slowest decay rate (starts full volume, decays slowly)
    STA $400C
    LDA #$0D
    STA $400E             ; set noise freq to $0D (low)
    LDA #$00
    STA $400F             
    ; set length counter to $0A (silence sound after 5 frames)
    ; this gets the noise channel playing the "kssssh" sound effect
    LDA move_speed            ; check move_speed (will be zero when the move is complete)
    BNE @Nah                  ; if the move is complete, assign damage (a branch instead of a jump?  -_-)

    ; damage is only assigned at end of move because we only want to assign damage once per
    ; step, whereas this routine is called once per frame.

    LDA #BANK_Z
    JSR SwapPRG_L
    JMP AssignMapTileDamage_Z
    
   @Nah: 
    RTS                       ; otherwise, just exit


  

  
  
  
  
  

  
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Set SM Scroll  [$CCA1 :: 0x3CCB1]
;;
;;     Sets the scroll for the standard maps.
;;
;;    Changes to SetSMScroll can impact the timing of some raster effects.
;;  See ScreenWipeFrame for details.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

SetSMScroll:
    LDA NTsoft2000      ; get the NT scroll bits
    STA soft2000        ; and record them in both soft2000
    STA $2000           ; and the actual $2000

    LDA sm_scroll_x     ; get the standard map scroll position
    ;ASL A
    ;ASL A
    ;ASL A
    ;ASL A               ; *16 (tiles are 16 pixels wide)
    JSR ShiftLeft4
    ORA move_ctr_x      ; OR with move counter (effectively makes the move counter the fine scroll)
    STA $2005           ; write this as our X scroll

    LDA scroll_y        ; get scroll_y
    ;ASL A
    ;ASL A
    ;ASL A
    ;ASL A               ; *16 (tiles are 16 pixels tall)
    JSR ShiftLeft4
    ORA move_ctr_y      ; OR with move counter
    STA $2005           ; and set as Y scroll

    RTS                 ; then exit


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Standard Map Move Right  [$CCBF :: 0x3CCCF]
;;
;;    See SM_MovePlayer for details
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

SM_LeftRightMoveDrawJobCheck:
    LDA mapdraw_job        ; is there a draw job to do?
    BEQ @NoJob             ; if not... no job
      JSR DoMapDrawJob     ; otherwise... do the job

  @NoJob:
    LDA mapflags
    LSR A
    BCC @Overworld    
     JSR SetSMScroll        ; set scroll, load move_ctr_x
     JMP :+
     
   @Overworld:
    JSR SetOWScroll_PPUOn 
  : LDA move_ctr_x
    CMP #$08               ; if = 8, then halfway done the move
    BNE :+
    
    JSR ToggleHideSprite ; if stepping out from under a bridge, show the sprite again
    
  : LDA move_ctr_x
    RTS

SMMove_Right:
    JSR SM_LeftRightMoveDrawJobCheck

   ;LDA move_ctr_x         ; add movement speed
    CLC                    ;  to our X move counter
    ADC move_speed
    AND #$0F               ; mask low bits to keep within a tile
    BEQ @FullTile          ; if result is zero, we've moved a full tile

      STA move_ctr_x       ; otherwise, simply write back the counter
      RTS                  ;  and exit

  @FullTile:
    ;STA move_speed         ; after moving a full tile, zero movement speed
    ;STA move_ctr_x         ; and move counter
    JSR SM_MoveFullTileDone

    LDA mapflags
    LSR A
    BCC @Overworld
    
    LDA sm_scroll_x        ; add 1 to SM scroll X
    CLC
    ADC #$01
    AND #$3F               ; and wrap at 64 tiles
    STA sm_scroll_x
    JMP :+

  @Overworld:  
    LDA ow_scroll_x        ; +1 to our overworld scroll X
    CLC
    ADC #$01
    STA ow_scroll_x
    
  : AND #$10               ; get nametable bit of scroll ($10=use nt@$2400, $00=use nt@$2000)
    LSR NTsoft2000         ; shift out and discard old NTX scroll bit
    CMP #$10               ; sets C if A=$10 (use nt@$2400).  clears C otherwise
    ROL NTsoft2000         ; shift C into NTX scroll bit (indicating the proper NT to use)

    RTS                    ; then exit

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Standard Map Move Left  [$CCEB :: 0x3CCFB]
;;
;;    See SM_MovePlayer for details
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

SMMove_Left:
    JSR SM_LeftRightMoveDrawJobCheck

   ;LDA move_ctr_x         ; get the move counter.  If zero, we need to move one tile to left
    BNE @NoTileChg         ;   otherwise we don't need to change tiles

    LDA mapflags
    LSR A
    BCC @Overworld

    LDA sm_scroll_x        ; subtract 1 from the SM X scroll
    SEC
    SBC #$01
    AND #$3F               ; and wrap at 64 tiles
    STA sm_scroll_x
    JMP :+
   
  @Overworld:
    LDA ow_scroll_x        ; subtract 1 from the OW X scroll
    SEC
    SBC #$01
    STA ow_scroll_x

  : AND #$10               ; get the nametable bit ($10=use nt@$2400... $00=use nt@$2000)
    LSR NTsoft2000         ; shift out and discard old NTX scroll bit
    CMP #$10               ; sets C if A=$10 (use nt@$2400).  clears C otherwise
    ROL NTsoft2000         ; shift C into NTX scroll bit (indicating the proper NT to use)

    LDA move_ctr_x         ; get the move counter

  @NoTileChg:
    SEC                    ; A=move counter at this point
    SBC move_speed         ; subtract the move speed from the counter
    AND #$0F               ; mask it to keep it in the tile
    BEQ @FullTile          ; if zero, we've moved a full tile

    STA move_ctr_x         ; otherwise, just write the move counter back
    RTS                    ; and exit

  @FullTile:
    JMP SM_MoveFullTileDone
   ; STA move_speed         ; if we've moved a full tile, zero our speed
   ; STA move_ctr_x         ; and our counter
   ; RTS                    ; and exit

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Standard Map Move Player  [$CD1B :: 0x3CD2B]
;;
;;    Performs player movement.  Identical to Overworld Move Player (OW_MovePlayer) except
;;  it adjusts SM scroll instead of OW scroll and wraps at 64 tiles instead of 256.
;;
;;    See OW_MovePlayer for further details.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

SM_MovePlayer:
    LDA facing          ; check to see which way we're facing
    LSR A
    BCS SMMove_Right    ; moving right
    LSR A
    BCS SMMove_Left     ; moving left
    LSR A
    BCS SMMove_Down     ; moving down
;    JMP SMMove_Up       ; moving up

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Standard Map Move Up  [$CD64 :: 0x3CD74]
;;
;;    See SM_MovePlayer for details
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

SMMove_Up:
    JSR SM_UpDownMoveDrawJobCheck

    LDA move_ctr_y         ; get move counter
    BNE @NoTileChg         ; if it's zero, we need to change tiles.  Otherwise, skip ahead

    LDA mapflags
    LSR A
    BCC @Overworld
    
    LDA sm_scroll_y        ; decrement SM Y scroll
    SEC
    SBC #$01
    AND #$3F               ; and wrap at 64 tiles
    STA sm_scroll_y
    JMP :+
   
   @Overworld:
    DEC ow_scroll_y

  : LDA scroll_y           ; subtract 1 from the map scroll Y
    SEC
    SBC #$01
    BCS :+
      ADC #$0F             ; and have it wrap from 0->E
:   STA scroll_y           ; then write it back

    LDA move_ctr_y         ; get move counter again

  @NoTileChg:
    SEC                    ; here, A=move counter
    SBC move_speed         ; subtract the movement speed from the counter
    AND #$0F               ; mask it to keep it in a 16x16 tile 
    ;BEQ @FullTile          ; if it's now zero... we've moved a full tile
    BEQ SM_MoveFullTileDone

    STA move_ctr_y         ; otherwise, simply write back the move counter
    RTS                    ;  and exit

  ;@FullTile:
    ;STA move_speed         ; if we moved a full tile, zero the move speed (stop player from moving)
    ;STA move_ctr_y         ; and zero the move counter
    ;RTS                    ; then exit
    ;JMP SM_MoveFullTileDone    
    
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Standard Map Move Down  [$CD29 :: 0x3CD39]
;;
;;    See SM_MovePlayer for details
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

SMMove_Down:
    JSR SM_UpDownMoveDrawJobCheck
    
    LDA move_ctr_y         ; get the Y move counter
    CLC
    ADC move_speed         ; add our movement speed to it
    AND #$0F               ; and mask it to keep it within the current tile
    BEQ @FullTile          ; if it's now zero, we've moved 1 full tile
    
    STA move_ctr_y         ; otherwise, simply record the new move counter
    RTS                    ; and exit

  @FullTile:               ; if we've moved a full tile
    JSR SM_MoveFullTileDone
    
    LDA mapflags
    LSR A
    BCC @Overworld
    
    LDA sm_scroll_y        ; increment SM Y scroll
    CLC
    ADC #$01
    AND #$3F               ; and wrap at 64 tiles
    STA sm_scroll_y
    JMP :+
    
   @Overworld: 
    INC ow_scroll_y

  : LDA scroll_y           ; and update our map scroll
    CLC
    ADC #1                 ;   by adding 1 to it
    CMP #$0F
    BCC :+
      SBC #$0F             ;   and make it wrap from E->0  (nametables are only 15 tiles tall.. not 16)
:   STA scroll_y           ; write it back
    RTS                    ; and exit





;; JIGS - up and down does this stuff, so no reason to have it copy-pasted twice
SM_UpDownMoveDrawJobCheck:
    LDA mapdraw_job        ; see if a job needs to be done
    BEQ @NoJob             ; if not, no job

    CMP #$01
    BEQ @Job               ; if job=1, do it right away

    LDA move_ctr_y         ; otherwise, only do it when we're halfway between tiles
    CMP #$08
    BNE @NoJob

    JSR ToggleHideSprite ; if stepping out from under a bridge, show the sprite again
    
  @Job:
    JSR DoMapDrawJob

  @NoJob:
    LDA mapflags
    LSR A 
    BCC @Overworld
    JMP SetSMScroll        ; set scroll and return
    
   @Overworld:
    JMP SetOWScroll_PPUOn   

ToggleHideSprite:    
   LDA mapspritehide
   JSR ShiftLeft4
   STA mapspritehide
   RTS

SM_MoveFullTileDone:
   STA move_speed    
   STA move_ctr_y    
   STA move_ctr_x
   STA ow_slow
   LDX tileprop_now
   STX tileprop_last
   LDX tileprop
   CPX #TP_SPEC_BRIDGEHORZ     ; check if the tile falls in the range of bridges, deep water, and water access
   BCC :+
   CPX #TP_SPEC_WATERACCESS+1
   BCC :++
   
 : STA wateraccess
 : RTS

    
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  SMMove Jump Table  [$CDA1 :: 0x3CDB1]
;;
;;    This jump table is referenced when the player walks on a standard map.
;;  The routines called are used to determine whether or not a move to this tile
;;  is legal (note however, that the TP_NOMOVE bit has already been checked prior
;;  to calling these routines).  These routines also do other things where necessary.
;;  For instance the door routine prepares the transition to going in (or out)
;;  of rooms.
;;
;;    (tileprop & TP_SPEC_MASK) is used to index this table, so the entries must
;;  be in the same order as the TP_SPEC_*** series of bits
;;
;;  IN:   A = special bits of the tile properties (tileprop & TP_SPEC_MASK)
;;
;;  OUT:  C = set if player cannot move to this tile.  Clear if they can
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


lut_SMMoveJmpTbl:
;;  .WORD SMMove_Norm       ; 
;;  .WORD SMMove_Door       ; 
;;  .WORD SMMove_Door       ; 
;;  .WORD SMMove_CloseRoom  ; 
;;  .WORD SMMove_Treasure   ; 
;;  .WORD SMMove_Battle     ; 
;;  .WORD SMMove_Dmg        ; 
;;  .WORD SMMove_Crown      ; 
;;  .WORD SMMove_Cube       ; 
;;  .WORD SMMove_4Orbs      ; 
;;  .WORD SMMove_UseRod     ; 
;;  .WORD SMMove_UseLute    ; 
;;  .WORD SMMove_LightOrb   ; 
;;  .WORD SMMove_Norm       ; 
;;  .WORD SMMove_Treasure   ; 
;;  .WORD SMMove_Norm       ; 
;;  
;;  ;.WORD SMMove_EarthOrb 
;;  ;.WORD SMMove_FireOrb 
;;  ;.WORD SMMove_WaterOrb 
;;  ;.WORD SMMove_AirOrb

    .WORD SMMove_Norm
    .WORD SMMove_Norm ; Warp to previous map
    .WORD SMMove_Norm ; Teleport to map
    .WORD SMMove_Norm ; Teleport to overworld
    .WORD SMMove_Door
    .WORD SMMove_Door 
    .WORD SMMove_CloseRoom
    .WORD SMMove_Dmg
    .WORD SMMove_Battle
    .WORD SMMove_Norm ; UseKeyItem    
    .WORD SMMove_Norm ; UseSave    
    .WORD SMMove_LightOrb
    .WORD SMMove_4Orbs 
    .WORD SMMove_Cube
    .WORD SMMove_Crown
    .WORD SMMove_BridgeHorizontal
    .WORD SMMove_BridgeVertical
    .WORD SMMove_DeepWater ; deep water
    .WORD SMMove_WaterAccess 
    
    ;; JIGS - this table is only for tiles without the No Move bit set. 
    ;; since the following tiles have the bit set, they've been removed
    
    ;.WORD SMMove_NoMove ; HP    
    ;.WORD SMMove_NoMove ; MP
    ;.WORD SMMove_NoMove ; HP/MP
    ;.WORD SMMove_NoMove ; CureDeath    
    ;.WORD SMMove_NoMove ; CureAilments
    ;.WORD SMMove_Norm ; Treasure
    ;.WORD SMMove_Norm ; Treasure

SMMove_WaterAccess:
    INC wateraccess
    CLC
    RTS    
  
SMMove_BridgeHorizontal: ; = 
    LDA facing
    LSR A                ; get right facing bit
    BCS SMMove_OK
    LSR A                ; get left facing bit
    BCS SMMove_OK

SMMove_HideUnderBridge:
    INC wateraccess    ; set water access so you can get out from under bridges if in water
    LDA mapspritehide  ; byte is split into two: high 4 bits are active, low 4 bits are "in waiting"
    ORA #2             ; ORA so as not to wipe out the active bits
    BNE SMMove_SaveHideSprite
    
SMMove_DeepWater:    
    LDA wateraccess
    BEQ SMMove_NoMove           
      INC wateraccess
      LDA mapspritehide
      ORA #8

SMMove_SaveHideSprite:
    STA mapspritehide  ; then the movement routine rotates the 4 active bits out to get the new bits when changing tiles
    CLC
    RTS
    
SMMove_BridgeVertical: ; ||
    LDA facing
    LSR A
    BCS SMMove_HideUnderBridge
    LSR A
    BCS SMMove_HideUnderBridge
    BCC SMMove_OK

   
 ;; SMMove_Battle  [$CDC3 :: 0x3CDD3]
 ;;  TP_SPEC_BATTLE
 

SMMove_Battle:
    LDA tileprop+1         ; check the secondary property byte to see which battle to do
    BPL @Spiked            ; if high bit is clear, this is a spiked tile (forced battle)
                           ;   otherwise... it's a random encounter
    JSR BattleStepRNG      ; get a pseudo-random number from the battle step RNG
    CMP battlerate         ; if that number is >= the battle rate for this map...
    BCS @Done              ;  ... then there's no battle

      LDA cur_map             ; otherwise, begin a random encounter
      LDX #$8
      JSR MultiplyXA
      ADC #$A0                ; carry clear from CMP... add $A0 to skip Ocean formations
      PHA
      TXA
      ADC #$08                ; add 8 to the high byte
      TAX
      PLA                     ; restore A
      JSR GetBattleFormation  ; Get the battle formation from this map's domain
      LDA #TP_BATTLEMARKER    ; then set the battle marker bit in the tileprop byte, so that a
      STA tileprop            ;   battle is triggered.

  @Done:
    CLC
    RTS

  @Spiked:
    STA btlformation      ; for spiked tiles, the secondary byte is the battle formation
    LDA #TP_BATTLEMARKER  ;   record it so the appropriate battle is triggered.
    STA tileprop          ; and also replace the tileprop byte with the battle marker bit to start a battle

 
SMMove_UseKeyItem:
SMMove_Dmg:
SMMove_Norm:
SMMove_OK:
    CLC               ; CLC because movement is A-OK, and exit
    RTS

    
;SMMove_Crown:
;    LDA item_crown              ; see if the player has the crown
;    BEQ SMMove_NoSpecialItem    ; if not, can't move
;    BNE SMMove_HaveSpecialItem  ; otherwise, can move (always branches)

;SMMove_Cube:
;    LDA item_cube                ; see if player has the cube
;    BNE SMMove_HaveSpecialItem   ; otherwise, can move (always branches)    
    
;SMMove_NoSpecialItem:
;    LDA #0             ; erase first byte of tile properties to prevent teleport
;    STA tileprop

SMMove_Crown:
    LDA keyitems_1
    AND #$40                    ; see if the player has the crown
    BNE SMMove_HaveSpecialItem  ; otherwise, can move (always branches)
    BEQ SMMove_OK

SMMove_Cube:
    LDA keyitems_2
    AND #$04                     ; see if player has the cube
    BNE SMMove_HaveSpecialItem   ; otherwise, can move (always branches)    
    BEQ SMMove_OK

SMMove_NoMove:
    SEC                ; SEC to disallow movement
    RTS

SMMove_4Orbs:
    LDA orb_fire              ; check to see if the player has all four orbs lit
    AND orb_water
    AND orb_air
    AND orb_earth
    BEQ SMMove_NoMove         ; if not, can't move
                              ; otherwise can (flow directly into SMMove_HaveSpecialItem)

 ;; SMMove_HaveSpecialItem  [$CE08 :: 0x3CE18]
 ;;  called when the player has a special item required to move onto this tile

SMMove_HaveSpecialItem:
    ;LDA #$54
    ;STA music_track   ; play music track $54 (fanfare)
    LDA #TP_TELE_NORM ; now overwrite the properties with a map to map teleport
    STA tileprop    
    CLC               ; CLC to allow movement
    RTS

 ;; SMMove_xOrb  [$CE12 :: 0x3CE22]
 ;;  these routines for the four altars (TP_SPEC_EARTHORB, TP_SPEC_FIREORB, etc)
 ;;  each of these routines are identical, except they all check different orbs

SMMove_LightOrb:          ; JIGS - check map, to see which orb to try lighting
    LDA cur_map
    CMP #AIRORB_MAP
    BEQ SMMove_AirOrb
    CMP #WATERORB_MAP
    BEQ SMMove_WaterOrb
    CMP #FIREORB_MAP
    BEQ SMMove_FireOrb
 
SMMove_EarthOrb:
    LDA orb_earth          ; see if orb already lit
    BNE SMMove_OK          ; if it is, just have player move normally
    INC orb_earth          ; otherwise, light up the orb
    BNE SMMove_AltarEffect ; and do the altar effect (always branches)

SMMove_FireOrb:
    LDA orb_fire
    BNE SMMove_OK
    INC orb_fire
    BNE SMMove_AltarEffect

SMMove_WaterOrb:
    LDA orb_water
    BNE SMMove_OK
    INC orb_water
    BNE SMMove_AltarEffect

SMMove_AirOrb:
    LDA orb_air
    BNE SMMove_OK
    INC orb_air           ; no BNE here because it just flows directly into altar effect

SMMove_AltarEffect:
    INC altareffect       ; set the altar effect flag
    CLC                   ; CLC to allow player to move
    RTS

 ;; SMMove_CloseRoom  [$CE44 :: 0x3CE54]
 ;;  TP_SPEC_CLOSEROOM

SMMove_CloseRoom:
    LDA inroom        ; check the inroom flag to see if we're coming from inside a room
    BPL SMMove_OK     ; if we're not, just move normally
    EOR #$84          ; otherwise, clear the inroom flag, and set the 'exiting' flag
    STA inroom        ; record that so the room will be exited
    JSR PlayDoorSFX   ; play the door sound effect
    CLC                   ; CLC to allow player to move
    RTS

    ; no JMP or RTS -- code continues on to SMMove_OK
    ;  note the game doesn't set doorppuaddr here even though closing the door
    ;  will require redrawing.  This is because it depends on the fact that doorppuaddr
    ;  has not changed from the last time the door has opened (so the game draws to the
    ;  same address as the last door that was opened).  This works most of the time... HOWEVER
    ;  because scroll_y is usually changed if the screen needs to be redrawn, doorppuaddr
    ;  will point to the spot on the NT there door was previously, even if it moved due to the
    ;  redrawing!  As a result, if you go in a menu while standing on a door, then close the door
    ;  a closed door graphic will appear on a seemingly random spot on the map!

    ; This is BUGGED -- but is a minor graphical glitch that only happens under very specific
    ; circumstances and does not affect gameplay at all.  The best way to fix this would probably be
    ; to adjust doorppuaddr in ReenterStandardMap so that doorppuaddr points to the tile the player
    ; is standing on.

    ; Another possible fix is to rebuild doorppuaddr here to point to 1 row above where the player
    ;  is moving to (since close door graphics are generally 1 tile below the door they're closing)

    ;; JIGS - this is fixed! 

 ;; SMMove_Door  [$CE53 :: 0x3CE63]
 ;;  Called for TP_SPEC_DOOR and TP_SPEC_LOCKED

SMMove_Door:
    PHA
    LDA keyitems_1
    AND #$08
    STA tmp
    PLA
    LSR A                                       ; downshift to get the door bits into the low 2 bits
    LSR A  ; downshift again to return to actual tileprop id
    BCC @OpenDoor

    LDX #0                    ; otherwise (door is locked)
    STX tileprop+1            ; erase the secondary attribute byte (prevent it from being a locked shop)
    LDX tmp                   ; check to see if the player has the key
    BNE @OpenDoor             ; if they do, open the door
      SEC                ; otherwise (no key, locked door), SEC to indicate player can't move here
      RTS                ; and exit

   @OpenDoor:
    ;ASL inroom
    LDA #01              ; JIGS - always use 1 to make sprites visible outside of rooms, locked or not
    STA inroom           ; then write the door bits to inroom to mark that we're opening a door (or locked door)
    ;BCS :+ 
    ;  JSR PlayDoorSFX    ;  ... play the door sound effect

SetChestAddr:      
    LDA scroll_y         ; get the Y scroll for drawing
    CLC
    ADC #7               ; add 7 to get the row to which the player is on
    TAX                  ; throw that in X -- it will be the row to draw the door graphic to

    LDA joy              ; check the joy data to see which way the player is moving
    AND #$0F             ; mask out directional bits
    CMP #DOWN            ; see if they pressed left/right
    BCC @SetAddr         ;  BCC will branch if direction is less than DOWN, which is left/right

    INX                  ; otherwise, we're possibly moving down, so inc our row
    CMP #DOWN            ; compare to DOWN again (because INX messed up Z)
    BEQ @SetAddr         ; if they're pressing down jump ahead

    DEX                  ; otherwise they're moving up, so DEX twice.  Once to undo the previous
    DEX                  ;  INX, and again to move up a row from the player.

  @SetAddr:              ; Here, X is the final row on which we will be drawing the door graphic
    TXA                  ; put the row in A
    CMP #15              ; check to see if it's >= 15
    BCC :+               ;  and if it is... subtract 15 (only 15 rows on the nametable)
      SBC #15
  : TAX                  ; put the row back in X for indexing

    LDA tmp+4            ; get the X coord of the tile the player is moving to
    AND #$1F             ; mask out the low bits (column to draw on the nametables)
    CMP #$10             ; see if the high bit is set.  If it is, we're drawing to the NT at $2400
    BCS @NT2400          ;  otherwise we draw to the NT at $2000

  @NT2000:
    ASL A                      ; double the column to get the PPU dest X coord (2 ppu tiles per map tile)
    ORA lut_2xNTRowStartLo, X  ; OR that with the NT address from the LUT, which gives us the 
    STA doorppuaddr            ;  PPU address of the desired tile to redraw
    LDA lut_2xNTRowStartHi, X  ;  record this address to doorppuaddr
    STA doorppuaddr+1
    JMP @CheckShop

  @NT2400:
    AND #$0F                   ; for the NT at $2400, do the same thing, but first clear that
    ASL A                      ; NT bit
    ORA lut_2xNTRowStartLo, X
    STA doorppuaddr
    LDA lut_2xNTRowStartHi, X
    ORA #$04                   ; and OR the high byte of the address with $04 ($2400 -- instead of $2000)
    STA doorppuaddr+1

  @CheckShop:
    LDA tileprop+1       ; check the second byte of properties for the tile.  If nonzero, this is a shop
    BEQ :+               ; enterance
      STA shop_id        ;   so if it's nonzero, write the byte to the shop id to enter
      INC entering_shop  ;   and set the entering_shop flag
      JSR PlayDoorSFX

  : CLC                  ; CLC to indicate the player can move here
    RTS                  ; and exit!


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Redraw Door  [$CEBA :: 0x3CECA]
;;
;;    Redraws the necessary door tile when you enter/exit rooms.
;;  It must be called during VBlank.  Note it only makes NT changes, not attribute changes.
;;  Therefore open and closed door tiles must share the same palette.
;;
;;  IN:  inroom = current state of room transition
;;       doorppuaddr = PPU address at which to redraw door graphic
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

RedrawDoor_Exit:
    RTS

RedrawDoor:
    LDA inroom                 ; check inroom status
    BEQ RedrawDoor_Exit        ; if not inroom, no redrawing required
    BMI RedrawDoor_Exit        ; if already inroom, no redrawing required (redraw only needed for the transition)

    ;AND #$07                   ; mask out the low bits
    ;CMP #$01
    ;BEQ @LockedOpen            ; if $01 -> opening a normal door
    ;CMP #$02
    ;BEQ @NormalOpen            ; $02 -> opening a locked door
    CMP #$05
    BEQ @NormalClose           ; $05 -> closing a normal door
                               ; else ($06) -> closing a locked door
    BCC @NormalOpen            ;; JIGS - if its UNDER $05, then normal open door stuff

  ;@LockedClose:
  ;  LDA #$00                   ; new inroom status ($00 because we're leaving rooms)
  ;  LDX #MAPTILE_LOCKEDDOOR    ; tile we're to draw
  ;  BNE @Redraw                ; redraw it
  ;; JIGS - ... why put a locked door back? The light warriors lock it behind them???
  ;; Well... reloading the map will do that, but at this point its 6 bytes to take out.

  @NormalClose:
    LDA #$00                   ; same...
    LDX #MAPTILE_CLOSEDDOOR    ; but use normal closed door tile instead of the locked door tile
    BNE @Redraw

 ; @LockedOpen:
 ;   LDA #$82                   ; $82 indicates inroom, but shows outroom sprites (locked rooms)
 ;   LDX #MAPTILE_OPENDOOR
 ;   BNE @Redraw
    ;; JIGS - this is kinda weird, why hide inside sprites when inside a locked room? 
    ;; I'm making it so people can be in locked rooms! For whatever reason! 
    
  @NormalOpen:
    LDA #$81                    ; $81 indicates inroom and shows inroom sprites (normal rooms)
    LDX #MAPTILE_OPENDOOR

  @Redraw:
    LDY $2002              ; reset PPU toggle
    LDY inroom             ; put old status in Y
    STA inroom             ; record new inroom status (previously stuffed in A)
    BEQ @SFX               ; if 0, we're outside the room; so always play the opening door sound
    
    ; else, we're inside the room: how to check if its already opened? 
    
   @INROOM: 
    JSR SetDoorAddress     ; get the address
    LDA $2007
    LDA $2007              ; load up the upper left tile
    CMP #$24 
    BEQ :+                 ; 0 if door is open ... so don't play the door SFX!
   
   @SFX:     
    JSR PlayDoorSFX
    
  : JSR SetDoorAddress
    LDA tsa_ul, X          ; and redraw upper two TSA tiles using the current tileset tsa data in RAM
    STA $2007
    LDA tsa_ur, X
    STA $2007

    LDA doorppuaddr+1      ; reload target PPU address
    STA $2006
    LDA doorppuaddr
    ORA #$20               ; but add $20 to it to put it on the second row of the tile (bottom half)
    STA $2006
    LDA tsa_dl, X          ; and redraw lower two TSA tiles
    STA $2007
    LDA tsa_dr, X
    STA $2007

    JMP DrawMapPalette     ; then redraw the map palette (since inroom changed, so did the palette)
                           ;  and exit

SetDoorAddress:           
    LDA doorppuaddr+1      ; load the target PPU address
    STA $2006
    LDA doorppuaddr
    STA $2006              
    RTS    

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Play Door SFX  [$CF1E :: 0x3CF2E]
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

PlayDoorSFX:
    LDA #%00001100  ; enable noise decay, set decay speed to $0C (moderately slow)
    STA $400C
    LDA #$0E
    STA $400E       ; set freq to $0E  (2nd lowest possible for noise)
    LDA #$30
    STA $400F       ; start noise playback -- set length counter to stop after $25 frames
    RTS


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Enter Standard Map  [$CF2E :: 0x3CF3E]
;;
;;    Called when entering a standard map for the first time, or when
;;  changing standard maps.  Map needs to be decompressed and all objects
;;  reloaded.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

EnterStandardMap:
    JSR LoadStandardMapAndObjects   ; decompress the map, load objects
    JSR PrepStandardMap             ; draw it, do other prepwork
    ;JSR AssertNasirCRC              ; do the NASIR CRC
    ;; JIGS ^ might as well take this out while we're ripping the game apart
    JMP ScreenWipe_Open             ; do the screen wipe effect and exit once map is visible




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  LoadStandardMapAndObjects  [$CF42 :: 0x3CF52]
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

LoadStandardMapAndObjects:
    LDA #$01
    STA mapflags          ; set the standard map flag

    LDA #0
    STA $2000             ; disable NMIs
    STA $2001             ; turn off PPU

    JSR LoadStandardMap   ; decompress the map
    LDA #BANK_OBJINFO     ; swap to the bank containing map object information
    JSR SwapPRG_L
    JMP LoadMapObjects    ; load up the objects for this map (townspeople/bats/etc)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Reenter Standard Map  [$CF3A :: 0x3CF4A]
;;
;;    Called to reenter (but not reload) a standard map.  Like when you exit
;;  a shop or menu... the map and objects haven't changed, but the map
;;  needs to be redrawn and such.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

ReenterStandardMap:
 ;   JSR PrepStandardMap   ; do map preparation stuff (redraw, etc)
    JSR StopNoise_StopSprites

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Prep Standard Map  [$CF55 :: 0x3DF65]
;;
;;    Sets up everything for entering (or re-entering) a standard map except for
;;  map decompression and object loading.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

PrepStandardMap:
    LDA #0
    STA $2000               ; disable NMIs
    STA $2001               ; turn off the PPU
    ;STA $400C               ; ??  tries to silence noise?  This doesn't really accomplish that.
    ;; JIGS ^ if it doesn't work don't do it!

    STA joy_select          ; zero a bunch of other map and input related stuff
    STA joy_start
    STA joy_a
    STA joy_b
    STA altareffect
    STA tileprop
    STA tileprop+1
    STA entering_shop

    JSR LoadSMTilesetData   ; load tileset and TSA data
    JSR LoadSMCHR           ; load all the necessary CHR    

    ;; JIGS - here, it checks all the tile properties of the map's tileset to see if there's a chest
    ;; When it finds a chest, it checks to see if its open
    ;; If its open, it swaps the upper tiles to use the opened chest graphic
    
    LDY #0                  ; set Y to 0 to use as loop counter and index
    STY tmp                 ; Set tmp to 0  
    LDA cur_tileset         ; Load current map's tileset
    CLC
    ADC #>lut_SMTilesetProp ; and set high byte to the tileset properties table
    STA tmp+1
   
   @CheckTreasureLoop1:   
    LDA (tmp), Y            ; Load a byte of the tileset properties table
    CMP #TP_SPEC_TREASURE_NOMOVE   ; if it matches a chest
    BEQ @IsChestOpen        ; check if the chest is open!
    CMP #TP_SPEC_TREASURE_2_NOMOVE ; and again for chest type #2
    BEQ @IsChestOpen
   
   @IncY2:   
    INY                     ; if not, increase Y by 2 (each tile is 2 bytes) 
   @IncY1:
    INY
    BNE @CheckTreasureLoop1 ; if Y hasn't wrapped, keep checking for more chests
    JMP @ContinueLoad       ; after all 256 bytes (128 tiles) are checked, resume loading the map like the original game
   
   @IsChestOpen:
    PHA                    ; backup the chest type
    INY                    ; inc Y to check the second byte of the tileset properties table 
    LDA (tmp), Y           
    TAX                    ; put that in X
    PLA                    ; restore the chest byte into A
    LSR A                  ; Chest table 1 is 9 (1001) and Chest table 2 is A (1010)
    BCS @ChestTable1       ; so figure out if its 1 or 2 by checking carry after shifting
    
   @ChestTable2:
    LDA game_flags, X      ; with X as the chest index, check game_flags to see if its set open
    AND #GMFLG_TCOPEN_2     
    BEQ @IncY1             ; if its not, go back up to the main loop, but only inc Y by 1 more
    BNE :+                 ; if it is, skip ahead
   
   @ChestTable1:   
    LDA game_flags, X      ; same, but check a different open bit flag!
    AND #GMFLG_TCOPEN 
    BEQ @IncY1
    
  : DEY                      ; decrement Y back to the previous byte of the table
    TYA                      ; put in A
    LSR A                    ; and halve it
    TAX                      ; then put it into X
    LDA tileset_data+$100, X ; Load up the upper left tile of the chest
    CMP #$2A                 ; see if its actually a treasure box graphic...
    BNE @IncY2               ; if not, skip it; otherwise
    ORA #TP_TREASURE_OPEN    ; ORA with #$70 to change it to the open chest tile
    STA tileset_data+$100, X ; and save it
    LDA tileset_data+$180, X ; Do the same with the upper right tile
    ORA #TP_TREASURE_OPEN
    STA tileset_data+$180, X
    BNE @IncY2               ; Then jump back to inc Y by 2 to check the next tile property 
    
   @ContinueLoad: 
    JSR LoadMapPalettes     ; load palettes
    JSR DrawFullMap         ; draw the map onto the screen

    LDA sm_scroll_x         ; get the map x scroll
    AND #$10                ; isolate the odd NT bit
    CMP #$10                ; move it into C
    ROL A                   ; then rotate it into bit 0
    AND #$01                ; and isolate it again (low bit this time)
    ORA #$08                ; combine with Spr-pattern-page bit
    STA NTsoft2000          ; and record as soft2000
    STA soft2000

    JSR WaitForVBlank_L     ; wait for vblank
    JSR DrawMapPalette      ; so we can draw the palette
    JSR SetSMScroll         ; set the scroll
    
    ;; JIGS - battle rates are with map palettes
    LDX cur_map                 ; use current map to index the rate LUT
    LDA lut_BattleRates+1, X    ; get this map's rate (+1 because first entry is for overworld [unused])
    STA battlerate              ; and record it    

    LDA MenuHush            ; JIGS - if its 1, then the map music is already playing! 
    BNE @NoChange
        LDA #BANK_MAPMUSIC
        JSR SwapPRG_L
        LDX cur_map
        LDA lut_MapMusicTrack, X      ;; JIGS - why tie songs to tilesets when each map can be specific?
        CMP dlgmusic_backup           ; is it already set as the backup song?
        BEQ @NoChange                 ; if so, its already playing, so skip loading it
        
        STA music_track               ; play it
        STA dlgmusic_backup           ; and record it so it can be restarted later by the dialogue box
            
   @NoChange:
    LDA #0                  ; JIGS - so set it to 0 I guess?
    STA MenuHush            ; Honestly don't remember what these toggles are doing, but it worked, so...
    
    LDA #DOWN
    STA facing              ; start the player facing downward

    LDA sm_scroll_x         ; get the scroll coords and add 7 to them to get the player position
    CLC                     ; and record that position
    ADC #7
    STA sm_player_x
    STA doorppuaddr
    LDA sm_scroll_y
    CLC
    ADC #7
    STA sm_player_y
    STA doorppuaddr+1      ;; JIGS - this fixes the phantom door bug

    JMP GetSMTilePropNow        ; then get the properties of the current tile, and exit

 ;; the LUT containing the music tracks for each tileset

 ; @lut_TilesetMusicTrack:
 ;   .BYTE $47, $48, $49, $4A, $4B, $4C, $4D, $4E
 
 ;; JIGS - moving this to the bottom so I can add some code without a critical timing error...

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Assert Nasir CRC  [$CFCB :: 0x3CFDB]
;;
;;    This is the "NASIR CRC".  It's a sort of ?antipiracy? measure to prevent you from removing
;;  NASIR's name in the credits during the bridge scene (though it checks an entire page of text
;;  in the bridge scene, as well as the pointer tables -- so it will likely fail if you make any
;;  changes to the credits).
;;
;;    It is called when you enter any standard map, and if the checksum fails, the game simply
;;  crashes.  However the routine is easily defeated by simply RTSing out of it immediately (or
;;  removing the JSR to it)
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;AssertNasirCRC:
;    LDA #BANK_BRIDGESCENE        ; swap to bank containing the bridge scene (credits text)
;    JSR SwapPRG_L
;
;    LDY #$25                     ; going to sum $25+1 bytes
;    LDX __Nasir_CRC_High_Byte    ; get the high byte of pointer
;    STX tmp+1                    ; and record it (points to lut_CreditsText)
;    STA tmp                      ; zero low byte of pointer (A is zero from SwapPRG)
;
;    CLC
;  @Loop:
;      ADC (tmp), Y          ; sum bytes, including carry between additions
;      DEY
;      BPL @Loop             ; loop until Y wraps ($26 iterations)
;
;    EOR #$AE                ; make sure sum=$AE
;    BEQ @Exit               ; if it does, exit (checksum passed)
;
;    PLA                ; otherwise (checksum failed), pull bytes from stack
;    PLA                ; to corrupt it, then RTS (jumps to crap -- crashing the game)
;    PLA
;
;  @Exit:
;    RTS

;; JIGS - We don't need this.

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Draw Full Map   [$CFE7 :: 0x3CFF7]
;;
;;    Draws 15 rows of tiles for the map, filling the entire screen.
;;  It accomplishes this by adding 15 to the map scroll, then faking
;;  upward movement to draw rows bottom first.
;;
;;    For Standard maps, this does no map decompression.  However for the overworld,
;;  each row is decompressed prior to drawing.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

DrawFullMap:
    LDA #0
    STA scroll_y         ; zero y scroll

    LDA mapflags         ; see if we're on the overworld or not
    LSR A                ; put SM flag in C
    BCS @SM              ;  and jump ahead if in SM
  @OW:
     LDA ow_scroll_y     ; add 15 to OW scroll Y
     CLC
     ADC #15
     STA ow_scroll_y
     JMP @StartLoop

  @SM:
     LDA sm_scroll_y     ; same, but add to sm scroll
     CLC
     ADC #15
     AND #$3F            ; and wrap around map boundary
     STA sm_scroll_y

  @StartLoop:
    LDA #$08
    STA facing           ; have the player face upwards (for purposes of following loop)

   @Loop:
      JSR StartMapMove       ; start a fake move upwards (to prep the next row for drawing)
      JSR DrawMapRowCol      ; then draw the row that just got prepped
      JSR PrepAttributePos   ; prep attributes for that row
      JSR DrawMapAttributes  ; and draw them
      JSR ScrollUpOneRow     ; then force a scroll upward one row

      LDA scroll_y           ; check scroll_y
      BNE @Loop              ; and loop until it reaches 0 again (15 iterations)

    LDA #0
    STA facing           ; clear facing
    STA mapdraw_job      ; clear the draw job (all drawing is done)
    STA move_speed       ; clear move speed (player isn't moving)

       ; those above 3 lines essentially "cancel" the fake moves that were only
       ;   performed to draw the map.

    RTS

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Start Map Move    [$D023 :: 0x3D033]
;;
;;    This routine starts the player moving in the direction they're facing.
;;
;;    The routine does not check to see if a move is legal.  Once this
;;  routine is called, it's assumed it's a legal move and the player starts
;;  moving unconditionally.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


StartMapMove:
    LDA scroll_y         ; copy Y scroll to 
    STA mapdraw_nty      ;   nt draw Y

    LDA #$FF             ; put overworld mask ($FF -- ow is 256x256 tiles )
    STA tmp+8            ; in tmp+8 for later
    LDX ow_scroll_x      ; put scrollx in X
    LDY ow_scroll_y      ; and scrolly in Y

    LDA mapflags         ; get mapflags
    LSR A                ; shift SM bit into C
    BCC :+               ; if we're in a standard map...

      LDX sm_scroll_x    ; ... replace above OW data with SM versions
      LDY sm_scroll_y    ; scrollx in X, scrolly in Y
      LDA #$3F           ; and sm mask ($3F -- 64x64) in tmp+8
      STA tmp+8

:   STX mapdraw_x        ; store desired scrollx in mapdraw_x
    STY mapdraw_y        ; and Y scroll

    TXA                  ; then put X scroll in A
    AND #$1F             ; mask out low bits (32 tiles in a 2-NT wide window)
    STA mapdraw_ntx      ; and that's our nt draw X

    LDA facing           ; check which direction we're facing
    LSR A                ; shift until we find the appropriate direction, and branch to it
    BCS @Right
    LSR A
    BCS @Left
    LSR A
    BCS @Down
    LSR A
    BCS @Up

    RTS                  ; if not facing any direction (doing initial map draw), just exit


  @Right:
    LDA sm_scroll_x      ; update player's SM coord to be the SM scroll
    CLC                  ;  +7 (to center him on screen), +1 (to move him right one)
    ADC #7+1
    AND #$3F             ; and wrap around edge of map
    STA sm_player_x

    LDA mapdraw_x        ; add 16 to the mapdraw_x (draw a column on the right side -- 16 tiles to right of screen)
    CLC
    ADC #16

  @Horizontal:
    AND tmp+8            ; mask column with map mask ($FF for OW, $3F for SM)
    STA mapdraw_x        ; set that as our new mapdraw_x

    AND #$1F             ; from that, calculate the NTX
    STA mapdraw_ntx

    LDA mapflags         ; set the 'draw column' map flag
    ORA #$02
    STA mapflags

    JSR PrepRowCol       ; and prep the column

  @Finalize:
    LDA #$02
    STA mapdraw_job      ; mark that drawjob #2 needs to be done (tiles need drawing)

    LDA #$01
    STA move_speed       ; set movement speed to move in desired direction

    LDA mapflags         ; check map flags
    LSR A                ; put SM flag in C
    BCS @Exit            ; if in a SM, just exit

    LDA vehicle          ; otherwise (OW), get current vehicle
    CMP #$02
    BCC @Exit            ; if vehicle is < 2 (on foot), exit (speed remains 1)

    LSR A                ; otherwise, replace speed with vehicle/2
    STA move_speed       ;  which works out to:  canoe=1   ship=2   airship=4

  @Exit:
    JMP DashButton

  @Left:
    LDA sm_scroll_x      ; exactly the same as @Right... except..
    CLC
    ADC #7-1             ; 7-1 to move him left, instead of right
    AND #$3F
    STA sm_player_x

    LDA mapdraw_x
    SEC
    SBC #1               ; and subtract 1 from the mapdraw column (one tile left of screen)
    JMP @Horizontal


  @Down:
    LDA sm_scroll_y      ; calculate player SM Y position
    CLC                  ; based on SM scroll Y
    ADC #7+1             ; +7 to center him, +1 to move him down 1
    AND #$3F             ; mask to wrap around map boundaries
    STA sm_player_y

    LDA #15              ; want to add 15 rows to mapdraw_y.  For whatever reason
    STA tmp              ;   this addition is done in @Vertical.  So write the desired addivite to tmp

    LDA mapdraw_nty      ; add $F to the NT Y
 ;   CLC                  ;   just so we can subtract it later
 ;   ADC #$0F             ; Waste of time.  The row to draw to is the row that we're scrolled to
 ;   CMP #$0F             ;   so we don't need to change mapdraw_nty at all when moving down
 ;   BCC @Vertical        ; will never branch

 ;   SEC                  ; subtract the $F we just added (dumb)
 ;   SBC #$0F
    JMP @Vertical

  @Up:
    LDA sm_scroll_y      ; same idea as @Down
    CLC
    ADC #7-1             ; only -1 to move up 1 tile
    AND #$3F
    STA sm_player_y

    LDA #-1              ; we want to subtract 1 from mapdraw_y
    STA tmp              ;  which is the same as adding -1  ($FF)

    LDA mapdraw_nty
    SEC
    SBC #$01             ; subtract 1 from mapdraw_nty.  Unlike for @Down -- this is actually important
    BCS @Vertical
    CLC
    ADC #$0F             ; but wrap from 0->E

  @Vertical:
    STA mapdraw_nty      ; record new NT Y

    LDA mapdraw_y        ; get mapdraw_y
    CLC
    ADC tmp              ; add our additive to it (down = 15,up = -1)
    AND tmp+8            ; mask with map size to keep within map bound
    STA mapdraw_y        ; write back

    LDA mapflags         ; turn off the 'draw column' map flag
    AND #~$02            ; to indicate we want to draw a row
    STA mapflags

    JSR LoadOWMapRow     ; need to decompress a new row when moving vertically on the OW map
    JSR PrepRowCol       ; then prep the row
    JMP @Finalize        ; and jump to @Finalize to do final stuff


    ;RTS                  ; useless RTS (impossible to reach)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Do Map Draw Job  [$D0E9 :: 0x3D0F9]
;;
;;     This performs the indicated map drawing job.
;;
;;  job=1  update map attributes to reflect the new row/col being scrolled in
;;  job=2  update map tiles to reflect the new row/col
;;  other  do nothing
;;
;;     The mapdraw_job is then decremented to indicate the previous
;;  job was complete (and move onto the next job)
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

DoMapDrawJob:
    LDA $2002           ; reset PPU toggle  (seems odd to do here...)

    DEC mapdraw_job
    LDA mapdraw_job     ; find which job we're to do
    ;SEC
    ;SBC #1              ; decrement the job (to mark this job as complete 
    ;STA mapdraw_job     ;   and to move to the next job)

    BEQ @Attributes     ; if original job was 1 (0 after decrement)... do attributes

    CMP #1              ; otherwise, if original job was 2 (1 after decrement)
    BEQ @Tiles          ;   ... do a row/column of tiles

    RTS                 ; if job was neither of those, do nothing and just exit

  @Tiles:
    JSR DrawMapRowCol       ; draw a row or column of tiles
    RTS                     ;  and exit

  @Attributes:
    JSR DrawMapAttributes   ; draw attributes
    RTS                     ;  and exit



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  ScrollUpOneRow  [$D102 :: 0x3D112]
;;
;;    This is used by DrawFullMap to "scroll" up one row so that
;;  the next row can be drawn.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

ScrollUpOneRow:
    LDA mapflags        ; see if this is OW or SM by checking map flags
    LSR A
    BCC @OW             ; if OW, jump ahead to OW

  @SM:
    LDA sm_scroll_y     ; otherwise (SM), subtract 1 from the sm_scroll
    SEC
    SBC #$01
    AND #$3F            ; and wrap where needed
    STA sm_scroll_y

    JMP @Finalize

  @OW:
    LDA ow_scroll_y     ; if OW, subtract 1 from ow_scroll
    SEC
    SBC #$01
    STA ow_scroll_y

  @Finalize:
    LDA scroll_y        ; then subtract 1 from scroll_y
    SEC
    SBC #$01
    BCS :+
      ADC #$0F          ; and wrap 0->E
:   STA scroll_y
    RTS                 ; then exit

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Load Standard Map   [$D126 :: 0x3D136]
;;
;;  Called to load the standard 64x64 tile maps (towns, dungeons, etc.. anything that isn't overworld)
;;
;;  TMP:  tmp to tmp+5 used
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

LoadStandardMap:
   ; LDA #BANK_MAPS
   ; JSR SwapPRG_L         ; swap to bank containing start of standard maps
   ; LDA cur_map           ; get current map ID
   ; ASL A                 ; double it, and throw it in X (to get index for pointer table)
   ; TAX
   ; LDA lut_SMPtrTbl, X   ; get low byte of pointer
   ; STA tmp               ; put in tmp (low byte of our source pointer)
   ; LDA lut_SMPtrTbl+1, X ; get high byte of pointer
   ; TAY                   ; copy to Y (temporary hold)
   ; AND #$3F              ; convert pointer to useable CPU address (bank will be loaded into $8000-FFFF)
   ; ORA #$80              ;   AND with #$3F and ORA with #$80 will determine where in the bank the map will start
   ; STA tmp+1             ; put converted high byte to our pointer.  (tmp) is now the pointer to the start of the map
   ; ;                     ;   provided the proper bank is swapped in
   ; TYA                   ; restore original high byte of pointer
   ; ROL A
   ; ROL A                  ; right shift it by 6 (high 2 bytes become low 2 bytes).
   ; ROL A                  ;    These ROLs are a shorter way to do it than LSRs.  Effectively dividing the pointer by $4000
   ; AND #$03               ; mask out low 2 bits (gets bank number for start of this map)
   ; ORA #BANK_MAPS         ; Add standard map bank (use ORA to avoid unwanted carry from above ROLs)
   ; STA tmp+5              ; put bank number in temp ram for future reference
   ; JSR SwapPRG_L          ; swap to desired bank
   ;
   ; LDA #<mapdata
   ; STA tmp+2
   ; LDA #>mapdata     ; set destination pointer to point to mapdata (start of decompressed map data in RAM).
   ; STA tmp+3         ; (tmp+2) is now the dest pointer, (tmp) is now the source pointer
   ; JMP DecompressMap ; start decompressing the map


    LDA #BANK_MAPS
    JSR SwapPRG_L         ; swap to bank containing start of standard maps
    LDA cur_map           ; get current map ID
    TAY
    ASL A                 ; double it, and throw it in X (to get index for pointer table)
    TAX
    LDA lut_SMPtrTbl, X   ; get low byte of pointer
    STA tmp               ; put in tmp (low byte of our source pointer)
    LDA lut_SMPtrTbl+1, X ; get high byte of pointer
    ;TAY                   ; copy to Y (temporary hold)
    AND #$3F              ; convert pointer to useable CPU address (bank will be loaded into $8000-FFFF)
    ORA #$80              ;   AND with #$3F and ORA with #$80 will determine where in the bank the map will start
    STA tmp+1             ; put converted high byte to our pointer. 
    TYA
    TAX
    LDA lut_MapBanks, X
    STA tmp+5              ; put bank number in temp ram for future reference
    JSR SwapPRG_L          ; swap to desired bank
 
    LDA #<mapdata
    STA tmp+2
    LDA #>mapdata     ; set destination pointer to point to mapdata (start of decompressed map data in RAM).
    STA tmp+3         ; (tmp+2) is now the dest pointer, (tmp) is now the source pointer
    JMP DecompressMap ; start decompressing the map



    
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Map routines' Semi-local RTS   [$D156 :: 0x3D166]
;;
;;   It is branched/jumped to by map loading routines
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

Map_RTS:
    RTS

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Load World Map Row  [$D157 :: 0x3D167]
;;
;;  Called to load a single row of an overworld map.  Since only so many can be in RAM at once
;;    a new row needs to be loaded every time the player moves up or down on the overworld map.
;;
;;  IN:   mapflags  = indicates whether or not we're on the overworld map
;;        mapdraw_y = indicates which row needs to be loaded
;;
;;  TMP:  tmp to tmp+7 used
;;
;;  NOTES:  overworld map cannot cross bank boundary.  Entire map and all its pointers must all fit on one bank
;;     (which shouldn't be a problem).
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

LoadOWMapRow:
    LDA mapflags     ; get StandardMap flag (to test to see if we're really in the overworld or not)
    LSR A            ; shift flag into C
    BCS Map_RTS      ; if flag is set (in standard map), we're not in the overworld, so don't do anything -- just exit

    LDA #BANK_OWMAP  ;  swap to bank contianing overworld map
    JSR SwapPRG_L
    
    JSR LoadOWMapRow_1E ;; JIGS - moved this to the Overworld Map bank.

;    LDA #>lut_OWPtrTbl ;  set (tmp+6) to the start of the pointers for the rows of the OW map.
;    STA tmp+7          ;   we will then index this pointer table to get the pointer for the start of the row
;    LDA #<lut_OWPtrTbl ;  Need to use a pointer because there are 256 rows, which means 512 bytes for indexing
;    STA tmp+6          ;    so normal indexing won't work -- have to use indirect mode
;
;    LDA mapdraw_y    ;  Load the row we need to load
;    TAX              ;  stuff it in X (temporary)
;    ASL A            ;  double it (2 bytes per pointer)
;    BCC :+           ;  if there was carry...
;      INC tmp+7      ;     inc the high byte of our temp pointer
;:   TAY              ;  put low byte in Y for indexing
;    LDA (tmp+6), Y   ;  load low byte of row pointer
;    STA tmp          ;  put it in tmp
;    INY              ;  inc our index
;    LDA (tmp+6), Y   ;  load high byte, and put it in tmp+!
;    STA tmp+1        ;  (tmp) is now our source pointer for the row
;
;    TXA              ;  get our row number (previously stuffed in X)
;    AND #$0F         ;  mask out the low 4 bits
;    ORA #>mapdata    ;  and ORA with high byte of mapdata destination
;    STA tmp+3        ;  use this as high byte of dest pointer (to receive decompressed map)
;    LDA #<mapdata    ;   the row will be decompressed to $7x00-$7xFF
;    STA tmp+2        ;   where 'x' is the low 4 bits of the row number
;                     ;  (tmp+2) is now our dest pointer for the row
;
;; no RTS or JMP -- code seamlessly runs into DecompressMap


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  DecompressMap
;;
;;   Decompressed a map from the given source buffer, and puts it in the given dest buffer
;;
;;  IN:  (tmp)   = pointer to source buffer (containing compressed map -- it's assumed it's between $8000-BFFF)
;;       (tmp+2) = pointer to dest buffer (to receive decompressed map.  typically $7xxx)
;;
;;  TMP: tmp to tmp+5 used
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

DecompressMap:
    LDY #0          ;  zero Y, our index
    LDA (tmp), Y    ;  read a byte from source
    BPL @SingleTile ;  if high byte clear (not a run), jump ahead to place a single tile
    CMP #$FF        ;  otherwise check for $FF (termination code)
    BEQ Map_RTS     ;  if == $FF, branch to exit

    ; code reaches here if loaded source byte was $80-FE  (need a run of this tile)
    AND #$7F        ;  take low 7 bits (tile to run)
    STA tmp+4       ;  put tile in temp ram
    INC tmp         ;  inc low byte of src pointer (need to leave Y=0)
    BNE @TileRun    ;  if it didn't wrap, jump ahead to TileRun sublabel

      INC tmp+1     ;    low byte of src pointer wrapped, so inc high byte
      BIT tmp+1     ;    check to see if high byte went over $BF (crossed bank boundary)
      BVC @TileRun  ;    if it didn't, proceed to TileRun
      JSR @NextBank ;    otherwise, we need to swap in the next bank, first

  @TileRun:
    LDA (tmp), Y    ;   get next src byte (length of run)
    TAX             ;   put length of run in X
    LDA tmp+4       ;   get tile ID
  @RunLoop:
      STA (tmp+2), Y ;   write tile ID to dest buffer
      INY            ;   INY to increment our dest index
      BEQ @Full256   ;   if Y wrapped... this run was a full 256 tiles long (maximum).  Jump ahead
      DEX            ;   decrement X (our run length)
      BNE @RunLoop   ;   if it isn't zero yet, we jump back to the loop

      TYA            ;   add Y to the low byte of our dest pointer
      CLC
      ADC tmp+2
      STA tmp+2
      BCC :+              ;   if adding Y caused a carry, we'll need to inc the high byte
    @Full256:
        INC tmp+3         ;   inc high byte of dest pointer
 :    INC tmp             ;   inc low byte of src pointer
      BNE DecompressMap   ;   if it didn't wrap, jump back to main map loading loop
      JMP @IncSrcHigh     ;   otherwise (did wrap), need to increment the high byte of the source pointer

  @SingleTile:
    STA (tmp+2), Y       ;  write tile to dest buffer
    INC tmp+2            ;  increment low byte of dest pointer
    BNE :+               ;  if it wrapped...
      INC tmp+3          ;     inc high byte of dest pointer
 :  INC tmp              ;  inc low byte of src pointer
    BNE DecompressMap    ;  if no wrapping, just continue with map decompression.  Otherwise...

  @IncSrcHigh:
    INC tmp+1            ;  increment high byte of source pointer
    BIT tmp+1            ;  check to see if we've reached end of PRG bank (BIT will set V if the value is >= $C0)
    BVC DecompressMap    ;  if we haven't, just continue with map decompression
    JSR @NextBank        ;  otherwise swap in the next bank
    JMP DecompressMap    ;  and continue decompression

;; NextBank local subroutine
;;  called via JSR when a map crosses a bank boundary (so a new bank needs to be swapped in)
@NextBank:
    LDA #>$8000   ; reset high byte of source pointer to start of the bank:  $8000
    STA tmp+1
    LDA tmp+5     ; get original bank number
    CLC
    ADC #$01      ; increment it by 1
    JMP SwapPRG_L ; swap that new bank in and exit
;    RTS           ; useless RTS (impossible to reach)
;; JIGS ^ useless


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Prep Standard Map Row or Column [$D1E4 :: 0x3D1F4]
;;
;;   Preps the TSA and Attribute bytes of the given row of a Standard map for drawing
;;    Standard maps mainly.  Overworld does not always use this routine.  See PrepRowCol
;;
;;   Data loaded is put in the intermediate drawing buffer to be later drawn
;;    via DrawMapAttributes and DrawMapRowCol
;;
;;   Note while this loads the attribute byte, it does not load other information
;;    necessary to DrawMapAttributes.  For that.. see PrepAttributePos
;;
;;  IN:  X     = Assumed to be set to 0.  This routine does not explicitly set it
;;       (tmp) = pointer to start of map data to prep
;;       tmp+2 = low byte of pointer to the start of the ROW indicated by (tmp).
;;                 basically is (tmp) minus column information
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


PrepSMRowCol:
    LDA mapflags      ; see if we're drawing a row/column
    AND #$02
    BNE @ColumnLoop

  @RowLoop:
    LDY #$00          ; zero Y for following index
    LDA (tmp), Y      ; read a tile from source
    TAY               ; put the tile in Y for a source index

    JSR CopyMapTileQuadrants

    LDA tmp           ; increment source pointer by 1
    CLC
    ADC #1
    AND #$3F          ; but wrap from $3F->00 (standard maps are only 64 tiles wide)
    ORA tmp+2         ; ORA with original address to retain bits 6,7
    STA tmp           ; write incremented+wrapped address back to pointer
    INX               ; increment our dest index
    CPX #$10          ; and loop until it reaches 16 (full row)
    BCC @RowLoop
    RTS

  @ColumnLoop:
    LDY #$00          ; More of the same, as above.  Only we draw a column instead of a row
    LDA (tmp), Y      ; get the tile
    TAY               ; and put it in Y to index

    JSR CopyMapTileQuadrants

    LDA tmp           ; Add 64 ($40) to our source pointer (since maps are 64 tiles wide)
    CLC
    ADC #$40
    STA tmp
    LDA tmp+1
    ADC #$00          ; Add any carry from the low byte addition
    AND #$0F          ; wrap at $0F
    ORA #>mapdata     ; and ORA with high byte of map data to keep the pointer looking at map data at in RAM $7xxx
    STA tmp+1
    INX               ; increment dest pointer
    CPX #$10          ; and loop until it reaches 16 (more than a full column -- probably could only go to 15)
    BCC @ColumnLoop
    RTS

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Prep Map Row or Column [$D258 :: 0x3D268]
;;
;;    Same job as PrepSMRowCol, (see that description for details)
;;   The difference is that PrepSMRowCol is specifically geared for Standard Maps,
;;   whereas this routine is built to cater to both Standard and overworld maps (this routine
;;   will jump to PrepSMRowCol where appropriate)
;;
;;   Again note that this does not load other information
;;    necessary to DrawMapAttributes.  For that.. see PrepAttributePos
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


PrepRowCol:
    LDX #$00          ; zero X (our dest index)
    LDA mapflags      ; see if we're on the overworld, or in a standard map
    LSR A
    BCC @DoOverworld  ; if we're on the overworld, jump ahead to overworld routine

       ; otherwise (we're in a standard map) -- do some pointer prepwork
       ; then call PrepSMRowCol

       LDA mapdraw_y     ; load the row number we're prepping
       LSR A             ; right shift by 2, rotating bits into tmp+2
       ROR tmp+2         ;  this is effectively the same as rotating left by 6 (multiply by 64)
       LSR A             ;  only much shorter in code
       ROR tmp+2         ; tmp+2 is now *almost* the low byte of the src pointer for the start of this row (still has garbage bits)
       ORA #>mapdata     ; after ORing, A is now the high byte of the src pointer
       STA tmp+1         ; write the src pointer to tmp
       LDA tmp+2         ; get low byte
       AND #$C0          ;  kill garbage bits
       STA tmp+2         ;  and write back
       ORA mapdraw_x     ; OR with current column number
       STA tmp           ; write low byte with column to
       JMP PrepSMRowCol  ; tmp, tmp+1, and tmp+2 are all prepped to what PrepSMRowCol needs -- so call it

@DoOverworld:
   LDA mapdraw_y ; get the row number
   AND #$0F      ; mask out the low 4 bits (only 16 rows of the OW map are loaded at a time)
   ORA #>mapdata
   STA tmp+1     ; tmp+1 is now the high byte of the src pointer
   LDA mapdraw_x
   STA tmp       ; and the low byte ($10) is just the column number
   LDA mapflags
   AND #$02      ; see if we are to load a row or a column
   BNE @DoColumn ; jump ahead to column routine if doing a column

  @DoRow:
     LDY #$00      ; zero Y for upcoming index
     LDA (tmp), Y  ; get desired tile from the map
     TAY           ; put that tile in Y to act as src index

     JSR CopyMapTileQuadrants

     INC tmp       ; increment low byte of src pointer.  no need to catch wrapping, as the map wraps at 256 tiles
     INX           ; increment our dest counter
     CPX #$10      ; and loop until we do 16 tiles (a full row)
     BCC @DoRow
     RTS

  @DoColumn:
     LDY #$00      ; zero Y for upcoming index
     LDA (tmp), Y  ; get tile from the map
     TAY           ; and use it as src index

     JSR CopyMapTileQuadrants

     LDA tmp+1     ; load high byte of src pointer
     CLC
     ADC #$01      ;  increment it by 1 (next row in the column)
     AND #$0F      ;  but wrap as to not go outside of map data in RAM
     ORA #>mapdata
     STA tmp+1     ; write incremented and wrapped high byte back
     INX           ; increment dest counter
     CPX #$10      ; and loop until we do 16 tiles (a full column)
     BCC @DoColumn
     RTS
     
CopyMapTileQuadrants:     
    LDA tsa_ul,      Y  ;  copy TSA and attribute bytes to drawing buffer
    STA draw_buf_ul, X
    LDA tsa_ur,      Y
    STA draw_buf_ur, X
    LDA tsa_dl,      Y
    STA draw_buf_dl, X
    LDA tsa_dr,      Y
    STA draw_buf_dr, X
    LDA tsa_attr,    Y
    STA draw_buf_attr, X
    RTS

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Draw Map Row or Column  [$D2E9 :: 0x3D2F9]
;;
;;   This will draw all the tiles in 1 row OR 1 column to the nametable
;;   This is done every time the player takes a step on the map to keep the nametables
;;    updated so that the map appears to be drawn correctly as the player scrolls around
;;
;;   Tiles' TSA have been pre-rendered to an intermediate buffer ($0780-07BF)
;;     draw_buf_ul = UL portion of the tiles
;;     draw_buf_ur = UR portion
;;     draw_buf_dl = DL portion
;;     draw_buf_dr = DR portion
;;
;;   This routine simply copies that pre-rendered data to the NT, so that it becomes
;;    visible on-screen
;;
;;   This routine does not update attributes (see DrawMapAttributes)
;;
;;   16 tiles are drawn if it is to draw a full row.  15 if it is to draw a full column.
;;
;;   Code seems verbose here, like it could've been coded to be smaller, however this is
;;    time critical drawing code (must all be completed in VBlank), so it being more verbose
;;    and lengthy probably keeps it faster than it would be otherwise.. which is very important
;;    for this kind of thing.
;;
;;   mapdraw_nty and mapdraw_ntx the Y,X coords on the NT to start drawing to.  Columns
;;    will draw downward from this point, and rows will draw rightward.
;;
;;  TMP:  tmp through tmp+2 used
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

DrawMapRowCol:
    LDX mapdraw_nty           ; get target row draw to
    LDA lut_2xNTRowStartLo, X ; use it to index LUT to find NT address of that row
    STA tmp
    LDA lut_2xNTRowStartHi, X
    STA tmp+1                 ; (tmp) now dest address
    LDA mapdraw_ntx           ; get target column to draw to
    CMP #$10
    BCS @UseNT2400            ; if column >= $10, we need to switch to NT at $2400, otherwise, use NT at $2000

                  ; if column < $10 (use NT $2000)
      TAX                 ; back up column to X
      ASL A               ; double column number
      ORA tmp             ; OR with low byte of dest pointer.  Dest pointer now points to NT start of desired tile
      STA tmp
      JMP @DetermineRowOrCol

  @UseNT2400:     ; if column >= $10 (use NT $2400)
      AND #$0F            ; mask low bits
      TAX                 ; put column in X
      ASL A               ; double column number
      ORA tmp             ; OR with low byte of dest pointer.
      STA tmp
      LDA tmp+1           ; add 4 to high byte (changing NT from $2000 to $2400)
      CLC
      ADC #$04            ; Dest pointer is now prepped
      STA tmp+1

       ; no matter which NT ($2000/$2400) is being drawn to, both forks reconnect here
  @DetermineRowOrCol:
    LDA mapflags          ; find out if we're moving drawing a row or column
    AND #$02
   ; BEQ @DoRow
   ; JMP @DoColumn
    BNE @DoColumn


   ;;
   ;;  Draw a row of tiles
   ;;

@DoRow:
    TXA              ; put column number in A
    EOR #$0F         ; invert it
    TAX              ; put it back in X, increment it, then create a back-up of it in tmp+2
    INX              ; This creates a down-counter:  it is '16 - column_number', indicating the number of
    STX tmp+2        ;   columns that must be drawn until we reach the NT boundary
    LDY #$00         ; zero Y -- our source index
    LDA $2002        ; reset PPU toggle
    LDA tmp+1
    STA $2006        ; set PPU addr to previously calculated dest addr
    LDA tmp
    STA $2006

  @RowLoop_U:
    LDA draw_buf_ul, Y ; load 2 tiles from drawing buffer and draw them
    STA $2007          ;   first UL
    LDA draw_buf_ur, Y ;   then UR
    STA $2007
    INY              ; inc source index (to look at next tile)
    DEX              ; dec down counter
    BNE :+           ; if it expired, we've reached NT boundary

      LDA tmp+1      ; at NT boundary... so load high byte
      EOR #$04       ;  toggle NT bit
      STA $2006      ;  and write back as the new high byte
      LDA tmp        ; then get low byte
      AND #$E0       ;  snap it to start of the row
      STA $2006      ;  and write back as the new low byte

:   CPY #$10         ; see if we've drawn 16 tiles yet (one full row)
    BCC @RowLoop_U   ; if not, continue looping

    LDA tmp
    CLC              ; add #$20 to low byte of dest pointer so that
    ADC #$20         ;  it points it to the next row of NT tiles
    STA tmp
    LDA tmp+1
    STA $2006        ; then re-copy the dest addr to set the PPU address
    LDA tmp
    STA $2006
    LDY #$00         ; zero our source index again
    LDX tmp+2        ; restore X to our down counter

@RowLoop_D:
    LDA draw_buf_dl, Y ; repeat same tile copying work done above,
    STA $2007          ;   but this time we're drawing the bottom half of the tiles
    LDA draw_buf_dr, Y ;   first DL
    STA $2007          ;   then DR
    INY                ; inc source index (next tile)
    DEX                ; dec down counter (for NT boundary)
    BNE :+
    
      LDA tmp+1      ; at NT boundary again.. same deal.  load high byte of dest
      EOR #$04       ;   toggle NT bit
      STA $2006      ;   and write back
      LDA tmp        ; load low byte
      AND #$E0       ;   snap to start of row
      STA $2006      ;   write back

:   CPY #$10
    BCC @RowLoop_D   ; loop until all 16 tiles drawn
    RTS              ; and RTS out (full rown drawn)


   ;;
   ;;  Draw a row of tiles
   ;;

@DoColumn:
    LDA #$0F         ; prep down counter so that it
    SEC              ;  is 15 - target_row
    SBC mapdraw_nty  ;  This is the number of rows to draw until we reach NT boundary (to be used as down counter)
    TAX              ; put downcounter in X for immediate use
    STX tmp+2        ; and back it up in tmp+2 for future use
    LDY #$00         ; zero Y -- our source index
    LDA $2002        ; clear PPU toggle
    LDA tmp+1
    STA $2006        ; set PPU addr to previously calculated dest address
    LDA tmp
    STA $2006
    LDA #$04
    STA $2000        ; set PPU to "inc-by-32" mode -- for drawing columns of tiles at a time

@ColLoop_L:
    LDA draw_buf_ul, Y ; draw the left two tiles that form this map tile
    STA $2007          ;   first UL
    LDA draw_buf_dl, Y ;   then DL
    STA $2007
    DEX              ; dec our down counter.
    BNE :+           ;   once it expires, we've reach the NT boundary

      LDA tmp+1      ; at NT boundary.. get high byte of dest
      AND #$24       ;   snap to top of NT
      STA $2006      ;   and write back
      LDA tmp        ; get low byte
      AND #$1F       ;   snap to top, while retaining current column
      STA $2006      ;   and write back

:   INY              ; inc our source index
    CPY #$0F
    BCC @ColLoop_L   ; and loop until we've drawn 15 tiles (one full column)


                     ; now that the left-hand tiles are drawn, draw the right-hand tiles
    LDY #$00         ; clear our source index
    LDA tmp+1        ; restore dest address
    STA $2006
    LDA tmp          ; but add 1 to the low byte (to move to right-hand column)
    CLC              ;   note:  the game does not write back to tmp -- why not?!!
    ADC #$01
    STA $2006
    LDX tmp+2        ; restore down counter into X

@ColLoop_R:
    LDA draw_buf_ur, Y ; load right-hand tiles and draw...
    STA $2007          ;   first UR
    LDA draw_buf_dr, Y ;   then DR
    STA $2007
    DEX                ; dec down counter
    BNE :+             ; if it expired, we're at the NT boundary

      LDA tmp+1      ; at NT boundary, get high byte of dest
      AND #$24       ;   snap to top of NT
      STA $2006      ;   and write back
      LDA tmp        ; get low byte of dest
      CLC            ;   and add 1 (this could've been avoided if it wrote back to tmp above)
      ADC #$01       ;   anyway -- adding 1 move to right-hand column (again)
      AND #$1F       ;   snap to top of NT, while retaining current column
      STA $2006      ;   and write to low byte of PPU address

:   INY              ; inc our source index
    CPY #$0F         ; loop until we've drawn 15 tiles
    BCC @ColLoop_R   ;  once we have... 
    RTS              ;  RTS out!  (full column drawn)





;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Prep Row or Column Attribute Positions  [$D401 :: 0x3D411]
;;
;;    Calculates and preps the drawing positions and masks for attribute updates.
;;   This routine just fills the intermediate drawing buffer with information to draw later
;;
;;    Current row/column draw information is used... and OVERWRITTEN!, so either this must be
;;   the last thing you do when preparing things to draw, or row/column info must be restored after
;;   calling this.
;;
;;    This routine might seem more complicated than it is, unless you're familiar with how
;;   the attribute tables are layed out.
;;
;;    Attribute bytes are not prepared here -- they're prepared with map TSA data in other routines
;;
;;   OUT:  mapdraw_nty, mapdraw_ntx are overwritten and become garbage
;;
;;   TMP:  tmp through tmp+2 used
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

PrepAttributePos:
    LDY #$00        ; zero Y -- our dest index

@Loop:
    LDA mapdraw_nty ; get target NT row
    LDX #$0F        ; X=$0F (for odd rows -- bottom half of attribute block)
    LSR A           ; see if row is odd
    BCC :+
       LDX #$F0     ; X=$F0 (for even rows -- top half of attribute block)
:   ASL A
    ASL A           ; A now = (target_NT_row AND $0E) * 8
    ASL A           ;    which is the row of attribute blocks to use
    STA tmp         ; put it in tmp (low byte of dest ppu address)
    STX tmp+1       ; put X (our high/low block mask) in tmp+1
    LDA mapdraw_ntx ; get target NT column
    LDX #$23        ; X=$23 (for left-hand attribute table)
    CMP #$10        ; see if column >= $10... if it is, we need the right-hand attribute table
    BCC :+
       AND #$0F     ;   need right-hand attribute, mask column to low 4 bits
       LDX #$27     ;   X=$27 to indicate right-hand attribute  (NT at $2400 instead of $2000)

:   STX tmp+2       ; put the high byte of the dest ppu address in tmp+2
    LDX #$33        ; X=$33 (for even columns)
    LSR A           ; divide column by 2
    BCC :+          ; see if it was even or odd
       LDX #$CC     ;   X=$CC (for odd columns)
:   ORA tmp         ; OR column/2 with low byte of dest address
    STA tmp         ;    (this is almost the final address for the desired attribute byte)
    TXA             ; Put X (our left/right block mask) in A
    AND tmp+1       ; Combine with our high/low block mask to get the final attribute mask
    STA tmp+1       ;  store final mask in tmp+1

    LDA tmp+2             ; put high byte of dest ppu address in drawing buffer
    STA draw_buf_at_hi, Y
    LDA tmp               ; get low byte of dest ppu address
    ORA #$C0              ;   or with #$C0 so that it's finalized (Attributes start at $23C0.. not $2300)
    STA draw_buf_at_lo, Y ;   and put it in drawing buf
    LDA tmp+1             ; and finally, copy the attribute mask
    STA draw_buf_at_msk, Y

    LDA mapflags
    AND #$02         ; check to see if we're doing a row or column
    BNE @IncByColumn ; if column.. inc by column

         ; otherwise... inc by row
       LDA mapdraw_ntx  ; get current column to draw
       CLC
       ADC #$01         ; increment it by 1 (so that we draw the next column in this row)
       AND #$1F
       STA mapdraw_ntx  ; write it back (overwriting row/column draw information!)
       INY              ; inc our dest counter
       CPY #$10         ; and loop until we've prepped all 16 columns
       BCS @Exit
       JMP @Loop

@IncByColumn:
       LDA mapdraw_nty  ; get current row to draw
       CLC
       ADC #$01         ; increment by 1
       CMP #$0F         ; but wrap $0E->$00 because there's only 15 rows of tiles per NT
       BCC :+
         SBC #$0F
:      STA mapdraw_nty  ; write it back (overwriting row/column draw information!)
       INY              ; inc our dest counter
       CPY #$0F         ; and loop until we've prepped all 15 rows in this column
       BCS @Exit
       JMP @Loop

@Exit: 
    RTS


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Draw Map Attributes   [$D46F :: 0x3D47F]
;;
;;    This uses a little EOR magic to set the appropriate bits in the attribute table.
;;   The general idea is... each map tile has an attribute byte assigned to it.  This byte
;;   is always the same 2 bits repeated 4 times:  $00, $55, $AA, or $FF.  This byte is copied
;;   to the intermediate drawing buffer in full... along with a mask ($03, $0C, $30, or $C0)
;;   to indicate which bits of the attribute byte we are to replace (since each map tile only
;;   represents 2 bits of the attribute byte).
;;
;;    The EOR magic works on the following 2 rules about EOR:
;;      1)  a EOR b = c.  and c EOR b = a.  IE:  EORing with the same value twice gets you the original value
;;      2)  0 EOR b = b.  IE:  EOR works just as OR does if the original source is 0
;;
;;    The code applies this in 3 parts.  To illustrate, I'll use diagrams.  Each letter represents a
;;     bit in the attribute byte.  For this example, let's say the code is to replace bits 2-3 of the attribute byte:
;;
;;      [aaaa aaaa]    <---  'a' = original attribute bits
;;   Step 1 = EOR by the tile's attribute bits
;;      [iiii iiii]    <---  'i' = original attribute bits EOR'd with desired attribute bits
;;   Step 2 = Mask out desired attribute bits
;;      [0000 ii00]    <---  The mask isolates the bits we're interested in
;;   Step 3 = EOR by original attribute byte
;;      [aaaa ddaa]    <---  'a' = original attribute bits, 'd' = desired attribute bits
;;
;;   This works because 0 EOR a = a
;;                  and i EOR a = d  (because a EOR d = i, as per step 1)
;;
;;   This code is timing critical, as it's done every time the player takes a step on the map
;;
;;   The intermediate drawing buffer is used as follows:
;;    draw_buf_attr:    desired attribute byte for tile 'x'
;;    draw_buf_at_hi:   high byte of PPU address in attribute tables for tile 'x'
;;    draw_buf_at_lo:   low byte of PPU address
;;    draw_buf_at_msk:  mask indicating which attribute bits are to be changed in given byte.
;;
;;   TMP:  tmp and tmp+1 are used
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

DrawMapAttributes:
    LDA mapflags
    LDX #$10        ; set X to $10 (if row)
    AND #$02        ; check if we're drawing a row or column
    BEQ :+ 
      LDX #$0F      ; set X to $0F (if column)

:   STX tmp+1       ; dump X to tmp+1.  This is our upper-bound
    LDX #$00        ; clear X (source index)
    LDA $2002       ; reset PPU toggle

@Loop:
    LDA draw_buf_at_hi, X  ; set our PPU addr to desired value
    STA $2006
    LDA draw_buf_at_lo, X
    STA $2006
    LDA $2007              ; dummy PPU read to fill read buffer
    LDA $2007              ; read the attribute byte at the desired address
    STA tmp                ; back it up in temp ram
    EOR draw_buf_attr, X   ; EOR with attribute byte to make attribute bits inversed (so that the next EOR will correct them)
    AND draw_buf_at_msk, X ; mask out desired attribute bits
    EOR tmp                ; EOR again with original byte, correcting desired attribute bits, and restoring other bits
    LDY draw_buf_at_hi, X  ; reload desired PPU address with Y (so not to disrupt A)
    STY $2006
    LDY draw_buf_at_lo, X
    STY $2006
    STA $2007              ; write new attribute byte back to attribute tables
    INX                    ; inc our source index
    CPX tmp+1              ; and loop until it reaches our upper-bound
    BCC @Loop
    RTS             ; exit once we've done them all


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Draw Dialogue Box  [$D4B1 :: 0x3D4C1]
;;
;;    Draws the dialogue box on the "offscreen" NT.  Since the PPU is on during this time, all drawing
;;  must be done in VBlank and thus takes several frames.
;;
;;  IN:  A = ID of dialogue text to draw.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

DrawDialogueBox:
    PHA               ; push the dialogue text ID to the stack for later use (much later)

    LDA #5+1          ; we will be drawing rows from the bottom up...
    STA dlgbox_row    ;  so set dlgbox_row to indicate 1+ the bottom row (row 6) needs drawing

    LDA sm_scroll_y   ; get our map scroll
    CLC
    ADC #5+1          ; add to get 1+ the bottom row on which the dialogue box will be drawn
    AND #$3F          ; wrap to keep it in bounds of the map
    STA mapdraw_y     ; and record that to our draw_y -- this is the first map row we'll be reloading

    LDA scroll_y      ; get screen scroll y
    CLC
    ADC #5+1 ;6+1          ; move to the 1+ bottom row of the dialogue box
    CMP #$0F
    BCC :+
      SBC #$0F        ;   wrap $E->$0
:   STA mapdraw_nty   ; store this as the target NT row on which we'll be drawing
                      ;  in addition to being to row which we're drawing... this is also the loop
                      ;  down counter for the upcoming loop

    LDA #$01          ; set mapflags to indicate we're drawing rows of tiles (don't want to draw columns)
    STA mapflags      ;   and that we're on a standard map

  ;;  Now that our vars are set up, this loop will draw each row

   @RowLoop:
      LDA mapdraw_y      ; predecrement the row of the map we are to draw
      SEC
      SBC #1
      AND #$3F           ;    mask to keep inside the map boundaries
      STA mapdraw_y

      LDA mapdraw_nty    ; and predecrement the destination NT address
      SEC
      SBC #1
      BCS :+
        ADC #$0F         ;    wrap 0->$E
  :   STA mapdraw_nty

      LDA sm_scroll_x    ; get the X scroll
      STA mapdraw_x      ; record that as our map column to start drawing from
      AND #$1F           ; then isolate the low 5 bits (where on which NT we're to draw it)
      EOR #$10           ; toggle the NT bit so it draws "offscreen"
      STA mapdraw_ntx    ; and that is our target NT address

      JSR PrepRowCol             ; prep map row/column graphics
      JSR PrepDialogueBoxRow     ; prep dialogue box graphics on top of that
      JSR WaitForVBlank_L        ; then wait for VBl
      JSR DrawMapRowCol          ; and draw what we just prepped
      JSR SetSMScroll            ; then set the scroll (so the next frame is drawn correctly)
      JSR CallMusicPlay_NoSwap   ; and update the music

      JSR PrepAttributePos       ; then prep attribute position data
     ; LDA mapdraw_nty            ; get dest NT address
     ; CMP scroll_y               ; compare it to the screen scroll
     ; BEQ :+                     ; if they're the same (drawing the top/last row)
        JSR PrepDialogueBoxAttr  ; ... then skip over dialogue box attribute prepping (dialogue box isn't visible top row)

      JSR WaitForVBlank_L        ; then wait for VBl again
      JSR DrawMapAttributes      ; and draw the attributes for this row
      JSR SetSMScroll            ; then set the scroll to keep rendering looking good
      JSR CallMusicPlay_NoSwap   ; and keep the music playing

      LDA mapdraw_nty            ; do the same check as above (see if this is the top/last row)
      CMP scroll_y
      BNE @RowLoop               ; if it isn't, keep looping.  Otherwise the Dialogue box is fully drawn!

    ;; now that the box is drawn, we need to draw the containing text
    ;;   coords at which the text is to be draw are stored in box_x, box_y -- don't let
    ;;   the var name trick you.

    LDA sm_scroll_x     ; get the X scroll of the map
    CLC                 ; then add $10+2 to it.  $10 to put the text on the "offscreen" NT
    ADC #$10+1  ;2        ;   and 2 to put it two map tiles (32 pixels) into that screen.
    AND #$1F            ; mask with $1F to wrap around both NTs properly
    ASL A               ; then double it, to convert from 16x16 tiles to 8x8 tiles
    STA box_x           ; this is our target X coord for the text

    LDA scroll_y        ; get the screen scroll for Y
    ASL A               ; double it to convert from 16x16 map tiles to 8x8 PPU tiles
    CLC
    ADC #3              ; add 4 to move it 32 pixels down from the top of the NT
    CMP #30             ; but wrap 29->0  (NTs are only 30 tiles tall)
    BCC :+
      SBC #30
:   STA box_y           ; this is our target Y coord for the text

   ; LDA #$80            ; enable menu stalling (kind of pointless because the upcoming routine
   ; STA menustall       ;  doesn't check it

    PLA                      ; then pull the dialogue text ID that was pushed at the start of the routine
    JMP DrawDialogueString   ; draw it, then exit!


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Prep Dialogue Box Attributes  [$D53E :: 0x3D54E]
;;
;;    Prepares the draw_buf_attr for the dialogue box.  Note that
;;  the map row must've been prepped before this -- as this is drawn
;;  over it, and it doesn't change all bytes in the buffer (+0 and +$F
;;  remain unchanged)
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

PrepDialogueBoxAttr:
    LDX #$0F ; 0E               ; Loop from $E to 1
    LDA #$FF               ; and set attributes to use palette set 3
  @Loop:
      STA draw_buf_attr, X
      DEX
      BPL @Loop
      ;BNE @Loop            ; loop until X=0 (do not change draw_buf_attr+0!)
    RTS                    ; then exit

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Prep Dialogue Box Row  [$D549 :: 0x3D559]
;;
;;    Prepares a row of 16x16 tiles to be drawn for the desired row of the dialogue
;;  box.  Note that the map row must've been prepped before this -- as the dialogue
;;  box is simply written over it.  Some map graphics are still visible underneath
;;  the dialogue box (dialogue box doesn't write over every graphic in the row)
;;
;;  IN:  dlgbox_row = the row of the dialogue box to draw (1-7)
;;
;;  OUT: dlgbox_row = decremented by 1
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

PrepDialogueBoxRow:
   LDA #$1F
   STA box_wd
   LDY #0             ; prep width and set Y to 0 for JigsBoxDoRow
   
   LDA #<draw_buf     ; set draw_buf as the destination to draw to
   STA tmp+1
   LDA #>draw_buf
   STA tmp+2

   LDX #2             ; do one inner row first--even if its the top row!  
   JSR JigsBoxDoRow   ; since the very top is not shown (fix your TV if it is!)
   ;; this might be considered bad practice? But emulators have overscan, or should... so its fine
  
   DEC dlgbox_row     ; this part is the same as the original at least
   BEQ @TopRow
   
   LDX dlgbox_row
   CPX #5
   BEQ @BottomRow
   
  @InnerRow:
   LDX #2
   JMP JigsBoxDoRow

  @BottomRow:
   LDX #5
   JMP JigsBoxDoRow
  
  @TopRow:
   LDX #$FF
   JMP JigsBoxDoRow

;; JIGS - neat, the row drawing of my battle box drawing routine works just fine here!


;    DEC dlgbox_row     ; decrement the row (drawing bottom up)
;    BEQ @TopRow
;   ; BEQ @Exit          ; if this is the very top row, draw nothing -- since the map is visible
;                       ;  for the top 16 pixels of the screen
;
;    LDA dlgbox_row
;    CMP #5             ; Otherwise, see if this is the bottom row
;    BEQ @BottomRow     ;   if it is, prepare it specially
;
;   ; CMP #1
;   ; BEQ @TopRow        ; same with the top row of the dialogue box (2nd row of 16x16 tiles)
;
;                 ; otherwise, just draw a normal "inner" row
;
;  @InnerRows:
;    LDA #$FA           ; use tile $FA for the leftmost tile in the row (left box graphic)
;    STA tmp+1
;    LDA #$FF           ; tile $FF for all other tiles in the row (inner box graphic / empty space)
;    STA tmp
;    JSR DlgBoxPrep_UL  ;  prep UL tiles
;
;    LDA #$FB           ; $FB as rightmost tile in row (right box graphic)
;    STA tmp+1
;    JSR DlgBoxPrep_UR  ;  prep UR tiles
;
;    LDA #$FA
;    STA tmp+1
;    JSR DlgBoxPrep_DL  ; then prep the fixed DL/DR tiles
;    
;    LDA #$FB
;    STA tmp+1
;    JMP DlgBoxPrep_DR  ;   and exit
;
;  @TopRow:
;    LDA #$F7           ; use tile $F7 for the leftmost tile in the row (UL box graphic)
;    STA tmp+1
;    LDA #$F8           ; use tile $F8 for every other tile in the row (top box graphic)
;    STA tmp
;    JSR DlgBoxPrep_DL  ;  prep the UL tiles
;
;    LDA #$F9           ; use tile $F9 for the rightmost tile in the row (UR box graphic)
;    STA tmp+1
;    JMP DlgBoxPrep_DR  ;  prep the UR tiles
;
;  @BottomRow:
;    LDA #$FF
;    STA tmp
;    LDA #$FA
;    STA tmp+1
;    JSR DlgBoxPrep_UL  
;    
;    LDA #$FB
;    STA tmp+1
;    JSR DlgBoxPrep_UR  
;
;    LDA #$FC           ; use tile $FC for the leftmost tile in the row (DL box graphic)
;    STA tmp+1
;    LDA #$FD           ; use tile $FD for every other tile in the row (bottom box graphic)
;    STA tmp
;    JSR DlgBoxPrep_DL  ;  prep the UL tiles
;   
;    LDA #$FE           ; use tile $FE for the rightmost tile in the row (DR box graphic)
;    STA tmp+1
;    JMP DlgBoxPrep_DR  ;  prep the UR tiles and exit

 ; @Exit:
 ;   RTS

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Dialogue Box Prep Support Routines  [$D59A :: 0x3D5AA]
;;
;;    These routines fill each portion of the TSA draw buffer for the dialogue
;;  box.  UL and UR are configurable and take tmp and tmp+1 as parameters, but
;;  DL and DR are fixed and will draw the same tiles every time.
;;
;;    Each routine fills draw_buf_xx+1 to draw_buf_xx+$E.  +0 and +$F are not
;;  changed because the map is to remain visible in the left and right 16-pixels
;;  of the screen.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

 ;;
 ;;  UL  [$D59A ::0x3D5AA]
 ;;   tmp+1 = tile for leftmost tile
 ;;   tmp   = tile for all other tiles
 ;;

;DlgBoxPrep_UL:
;    LDA tmp+1             ; get the desired leftmost tile
;    STA draw_buf_ul+1     ; record it
;
;    LDX #$01; 02
;    LDA tmp               ; then get the main tile
;   @Loop:
;      STA draw_buf_ul, X  ; and record it for +2 to +$E
;      INX
;      CPX #$10; 0F
;      BCC @Loop           ; stop when X gets to $F (don't want to change $F)
;    RTS                   ; and exit
;
; ;;
; ;;  UR  [$D5AC ::0x3D5BC]
; ;;   tmp   = tile for all other tiles
; ;;   tmp+1 = tile for rightmost tile
; ;;
;
;DlgBoxPrep_UR:
;    LDA tmp               ; get main tile
;    LDX #$00 ; 1
;   @Loop:
;      STA draw_buf_ur, X  ; and write it to +1 to +$D
;      INX
;      CPX #$0F ; E
;      BCC @Loop
;
;    LDA tmp+1             ; then copy the right-most tile to +$E
;    STA draw_buf_ur+$E
;    RTS
;
; ;;
; ;;  DL  [$D5BE :: 0x3D5CE]
; ;;
;
;DlgBoxPrep_DL:
;    LDA tmp+1             ; load hardcoded tile $FA (box left border graphic)
;    STA draw_buf_dl+1     ; to leftmost tile
;
;    LDX #$01; 2
;    LDA tmp               ; then hardcoded tile $FF (blank space / box inner graphic)
;   @Loop:
;      STA draw_buf_dl, X  ;   to the rest of the row
;      INX
;      CPX #$10; 0F
;      BCC @Loop
;    RTS
;
; ;;
; ;;  DR  [$D5D0 :: 0x3D5E0]
; ;;
;
;DlgBoxPrep_DR:
;    LDA tmp               ; load hardcoded tile $FF (blank space / box inner graphic)
;    LDX #$00; 1
;   @Loop:
;      STA draw_buf_dr, X  ;   to all tiles in row except the rightmost
;      INX
;      CPX #$0F; E
;      BCC @Loop
;
;    LDA tmp+1             ; load hardcoded tile $FB (box right border graphic)
;    STA draw_buf_dr+$E    ; to rightmost tile
;    RTS

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  [$D5E2 :: 0x3D5F2]
;;
;;  These LUTs are used by routines to find the NT address of the start of each row of map tiles
;;    Really, they just shortcut a multiplication by $40
;;
;;  "2x" because they're really 2 rows (each row is $20, these increment by $40).  This is because
;;  map tiles are 2 ppu tiles tall

lut_2xNTRowStartLo:    .BYTE  $00,$40,$80,$C0,$00,$40,$80,$C0,$00,$40,$80,$C0,$00,$40,$80,$C0
lut_2xNTRowStartHi:    .BYTE  $20,$20,$20,$20,$21,$21,$21,$21,$22,$22,$22,$22,$23,$23,$23,$23



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Show Dialogue Box [$D602 :: 0x3D612]
;;
;;    This makes the dialogue box and contained text visible (but doesn't draw it to NT,
;;  that must've already been done -- see DrawDialogueBox).  Once the box is fully visible,
;;  it plays any special TC sound effect or fanfare music associated with the box and waits
;;  for player input to close the box -- and returns once the box is no longer visible.
;;
;;  IN:  dlgsfx = 0 if no special sound effect needed.  1 if special fanfare, else do treasure chest ditty.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

ShowDialogueBox:
    LDA #3
    STA tmp+2              ; reset the 3-step counter for WaitScanline

;; JIGS - disables dialogue box SFX
;    LDA #53
;    STA sq2_sfx            ; indicate sq2 is going to be playing a sound effect for the next 53 frames
;    LDA #$8E
;    JSR DialogueBox_Sfx    ; and play the "upward sweep" sound effect that plays when the dialogue box opened.

    LDA soft2000           ; get the onscreen NT
    EOR #$01               ; toggle the NT bit to make it the offscreen NT (where the dialogue box is drawn)
    STA tmp+10             ; store "offscreen" NT in tmp+10

    LDA #$08               ; start the visibility scanline at 8(+8).  This means the first scanline of the box
    STA tmp+11             ;  that's visible will be on scanline 16 -- which is the start of where the box is drawn

     ; open the dialogue box

   @OpenLoop:
      JSR DialogueBox_Frame; do a frame

      LDA tmp+11
      CLC
      ;ADC #2
      ADC #8               ; JIGS - greatly increases dialogue box opening speed!
      STA tmp+11           ; increment the visible scanlines by 2 (box grows 2 pixels/frame)

      CMP #$58; 60             ; see if visiblity lines >= $60 (bottom row of dialogue box)
      BCC @OpenLoop        ; keep looping until the entire box is visible


    LDA dlgsfx             ; see if a sound effect needs to be played
    BEQ @WaitForButton_1   ; if not (dlgsfx = 0), skip ahead
    LDX #$54               ; Use music track $54 for sfx (special fanfare music)
    ;CMP #1
    ;BEQ :+                 ; if dlgsfx > 1...
    ;  LDX #$58             ;  ... then use track $58 instead (treasure chest ditty)
    ;; JIGS - disabling the treasure box music, but not for Key Items
   STX music_track        ; write the desired track to the music_track to get it started

  ; there are two seperate 'WaitForButton' loops because the dialogue box closes when the
  ; user presses A, or when they press any directional button.  The first loop waits
  ; for all directional buttons to be lifted, and the second loop waits for a directional
  ; button to be pressed.  Both loops exit the dialogue box when A is pressed.  Having
  ; the first loop wait for directions to be lifted prevents the box from closing immediately
  ; if you have a direction held.

  @WaitForButton_1:           ;  The loop that waits for the direction to lift 
;    JSR DialogueBox_Frame   ; Do a frame
;    JSR UpdateJoy           ; update joypad data
;    LDA joy_a               ; check A button
;    BNE @ExitDialogue       ; and exit if A pressed
;
;    LDA music_track         ; otherwise, check the music track
;    CMP #$81                ; see if it's set to $81 (special sound effect is done playing)
;    BNE :+                  ; if not, skip ahead (either no sound effect, or sound effect is still playing)
;      LDA dlgmusic_backup      ; if sound effect is done, get the backup track
;      STA music_track          ; and restart it
;      LDA #0
;      STA dlgsfx               ; then clear the dlgsfx flag
;:   LDA joy                 ; check directional buttons
;    AND #$0F

    JSR @DialogueButtonWait
    BNE @WaitForButton_1    ; and continue first loop until they're all lifted

  @WaitForButton_2:           ;  The loop that waits for a direciton to press
;    JSR DialogueBox_Frame   ; exactly the same as above loop
;    JSR UpdateJoy
;    LDA joy_a
;    BNE @ExitDialogue
;
;    LDA music_track
;    CMP #$81
;    BNE :+
;      LDA dlgmusic_backup
;      STA music_track
;      LDA #0
;      STA dlgsfx
;:   LDA joy
;    AND #$0F

    JSR @DialogueButtonWait
    BEQ @WaitForButton_2    ; except here, we loop until a direction is pressed (BEQ instead of BNE)



  @ExitDialogue:
    LDA dlgsfx              ; see if a sfx is still playing
    BEQ @StartClosing       ; if not, start closing the dialogue box immediately


  @WaitForSfx:              ; otherwise (sfx is still playing
    LDA music_track         ;   we need to wait for it to end.  check the music track
    CMP #$81                ; and see if it's $81 (sfx over)
    BEQ @SfxIsDone          ; if it is, break out of this loop
      JSR DialogueBox_Frame   ; otherwise, keep doing frames
      JMP @WaitForSfx         ; and loop until the sfx is done

  @SfxIsDone:
    LDA dlgmusic_backup     ; once the sfx is done restore the music track to the backup value
    STA music_track
    LDA #0
    STA dlgsfx              ; and clear sfx flag



  @StartClosing:
    ;LDA #37
    ;STA sq2_sfx            ; indicate that sq2 is to be playing a sfx for the next 37 frames
    ;LDA #$95
    ;JSR DialogueBox_Sfx    ; and start the downward sweep sound effect you hear when you close the dialogue box
    ;; JIGS - again disabling SFX

  @CloseLoop:
      JSR DialogueBox_Frame; do a frame

      LDA tmp+11        ; subtract 3 from the dialogue visibility scanline (move it 3 lines up
      SEC               ;    retracting box visibility)
      ;SBC #3
      SBC #8            ; JIGS - faster closing of the dialogue box
      STA tmp+11        ; box closes 3 pixels/frame.

      CMP #$12          ; and keep looping until line is below $12
      BCS @CloseLoop


    RTS          ; then the dialogue box is done!
    
  @DialogueButtonWait:
    JSR DialogueBox_Frame   ; Do a frame
    JSR UpdateJoy           ; update joypad data
    LDA joy_a               ; check A button
    BNE @ExitDialogue       ; and exit if A pressed

    LDA music_track         ; otherwise, check the music track
    CMP #$81                ; see if it's set to $81 (special sound effect is done playing)
    BNE :+                  ; if not, skip ahead (either no sound effect, or sound effect is still playing)
      LDA dlgmusic_backup      ; if sound effect is done, get the backup track
      STA music_track          ; and restart it
      LDA #0
      STA dlgsfx               ; then clear the dlgsfx flag
:   LDA joy                 ; check directional buttons
    AND #$0F
    RTS
    


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  DialogueBox_Frame  [$D6A1 :: 0x3D6B1]
;;
;;    Does frame work related to drawing the dialogue box.  This mainly involves timing the screen
;;  splits required to make the dialogue box visible.
;;
;;  IN:  tmp+10 = "offscreen" NT (soft2000 XOR #$01) -- NT containing dialogue box
;;       tmp+11 = number of scanlines (-8) the dialogue box is to be visible.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

DialogueBox_Frame:
    JSR Dialogue_CoverSprites_VBl   ; modify OAM to cover sprites behind the dialogue box, then wait for VBlank
    LDA #>oam          ; do sprite DMA
    STA $4014          ; after waiting for VBlank and Sprite DMA, the game is roughly 556 cycles into VBlank

    LDA tmp+10         ; set NT scroll to draw the "offscreen" NT (the one with the dialogue box)
    STA $2000

        ; now the game loops to burn VBlank time, so that it can start doing raster effects to split the screen

    LDY #$FC           ; count Y down from $FC
  @BurnVBlankLoop:     ; On entry to this loop, game is about 565 cycles into VBlank)
    DEY                    ; 2 cycles
    NOP                    ; +2=4
    NOP                    ; +2=6
    NOP                    ; +2=8
    BNE @BurnVBlankLoop    ; +3=11   (11*$FC)-1 = 2771 cycles burned in loop.
                           ;         2771 + 565 = 3336 cycles since VBl start
                           ; First visible rendered scanline starts 2387 cycles into VBlank
                           ; 3336 - 2387 = 949 cycles into rendering
                           ; 949 / 113.6667 = currently on scanline ~8.3
       PAGECHECK @BurnVBlankLoop

        ; here, thanks to above loop, the game is ~8.3 scanlines into rendering.  Since scroll changes
        ;  are not visible until the end of the scanline, you can round up and say that we're on scanline 9
        ;  since that'll be when scroll changes are first visible.

    LDX tmp+11             ; get the height of the box
    DEX                    ; decrement it BEFORE burning scanlines (since we're on scanline 9, this would
                           ;   mean the last visible dialogue box line is 8+N  -- where N is tmp+11)

  @ScanlineLoop:
    JSR WaitScanline       ; burn the desired number of scanlines
    DEX
    BNE @ScanlineLoop

       PAGECHECK @ScanlineLoop

      ; now... the dialogue box has been visible for 8+N scanlines, and we're to its bottom line
      ; so we don't want it to be visible any more for the rest of this frame

    LDA soft2000                   ; so get the normal "onscreen" NT
    STA $2000                      ; and set it
    JMP CallMusicPlay_NoSwap       ; then call the Music Play routine and exit


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  DialogueBox_Sfx   [$D6C7 :: 0x3D6D7]
;;
;;    Plays the opening/closing sound effect heard when you open/close the dialogue
;;  box.  Note it does not change 'sq2_sfx' -- that is done outside this routine
;;
;;  IN:   A=$8E for the sweep-up sound (opening)
;;        A=$95 for the sweep-down sound (closing)
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;DialogueBox_Sfx:
;    LDX #$38
;    STX $4004      ; 12.5% duty (harsh), volume=8
;    STA $4005      ; for open ($8E):  sweep period=0 (fastest), sweep upwards in pitch, shift=6 (shallow steps)
                   ; for close ($95): sweep period=1 (fast), sweep down in pitch, shift=5 (not as shallow)

;    LSR A          ; rotate sweep value by 2 bits
;    ROR A
;    EOR #$FF       ; and invert
;    STA $4006      ; use that as low byte of F value
                   ; for open:   F = $0DC
                   ; for close:  F = $035

;    LDA #0         ; set high byte of F value to 0, and reload length counter
;    STA $4007
;    RTS            ; and exit

;; JIGS - no longer using this

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Screen Wipe  [$D6DC :: 0x3D6EC]
;;
;;    These routines do the screen wipe effect that is performed as a map
;;  transition (like when you enter a town or go down a staircase).
;;
;;  ScreenWipe_Open opens the screen up
;;  ScreenWipe_Close closes it
;;
;;    They both do pretty much the same thing, but in reverse order.  When
;;  ScreenWipe_Open exits, the PPU is left on, and when ScreenWipe_Close
;;  exits, the PPU is switched off.
;;
;;    Neither routine returns until the wipe effect is complete (takes several frames)
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

 ;;
 ;; ScreenWipe_Open  [$D6DC :: 0x3D6EC]
 ;;

ScreenWipe_Open:
    JSR StartScreenWipe     ; do screen wipe prepwork

    LDA #122+11             ; start the wipe at scanline 122 (just below the center of the screen
    STA tmp+4               ;  -- it probably should've been 120)
    LDA #1                  ; start with just 1 scanline visible
    STA tmp+5

  @Loop:
      JSR ScreenWipeFrame   ; do a frame with these wipe params

      LDA tmp+4             ; move the opened part up by subtracting 2 from the start scanline
      SEC
      ;SBC #2
      SBC #5
      ; JIGS - speeding up the screen wipe too!
      STA tmp+4

      LDA tmp+5             ; move the bottom part down by adding 4 to the visible scanlines
      CLC                   ;  note this only moves the bottom of the wipe down 2 scanlines
      ;ADC #4                ;  because the above -2 offsets this
      ADC #10
      ; JIGS - here too
      STA tmp+5

      CMP #224              ; continue until 224 scanlines are visible (full frame minus 8
      BCC @Loop             ;  lines off the top and bottom)

    LDA #$1E                ; then jump to the finalization with A=1E (PPU On)
    JMP ScreenWipe_Finalize

 ;;
 ;; ScreenWipe_Close  [$D701 :: 0x3D711]
 ;;

ScreenWipe_Close:
    JSR StartScreenWipe     ; do screen wipe prepwork

    LDA #10+11              ; start the wipe at scanline 10 
    STA tmp+4
    LDA #220+1              ; start with 221 scanlines visible
    STA tmp+5               ;  this will make lines 10-230 visible
                            ;  wipe will be centered on the screen

  @Loop:
      JSR ScreenWipeFrame   ; do a frame with these wipe params

      LDA tmp+4             ; move the top portion of the wipe down by
      CLC                   ;  adding 2 to the start line
      ;ADC #2
      ADC #5
      ; JIGS - faster wipe
      STA tmp+4

      LDA tmp+5             ; move the bottom portion up by
      SEC                   ;  subtracting 4 from the stop line.  Note
      ;SBC #4                ;  this only moves the bottom up by 2 scanlines, not 4
      SBC #10
      ; JIGS - faster wipe
      STA tmp+5             ;  (because adding 2 above offsets this as well)

      CMP #1                ; see if we're down to just 1 scanline being visible
      BNE @Loop             ;  if we are, we're done.  If not, keep wiping

    LDA #$00           ; now that the wipe is complete...
                       ;   flow into ScreenWipe_Finalize with A=0 (to turn off PPU)

 ;;
 ;; ScreenWipe_Finalize  [$D723 :: 0x3D733] -- just finishes up some stuff for the screen wipe
 ;;

ScreenWipe_Finalize:
    STA $2001          ; turn on/off the PPU (Close turns it off, Open turns it on)
    LDA #0
    STA $4006          ; then silence the Sq2 sound effect by setting its F-value to zero
    STA $4007
    RTS                ; and exit

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Prep Screen Wipe Frame  [$D72F :: 0x3D73F]
;;
;;    Called every frame of the screen wipe effect (transition between maps).
;;  Does Sprite DMA, draws the palette, and sets the scroll.
;;
;;    In addition to doing these somewhat ordinary tasks... the routine takes
;;  a more or less fixed amount of time.  If JSR'd to immediately after waiting
;;  for VBlank, this routine should exit approximately ~1105 cycles into VBlank
;;  (~9.7 scanlines into VBlank -- about 11 scanlines before onscreen rendering starts)
;;  Timing here isn't super-critical.  However drastic changes in the length
;;  of this routine could impact the screen wipe effect.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

ScreenWipeFrame_Prep:
    LDA #>oam           ; do sprite DMA
    STA $4014           ;  (friendly reminder:  sprite DMA burns 513 cycles)

    JSR DrawMapPalette  ; draw the palette

    LDA mapflags        ; see if we're on the overworld or standard map
    LSR A
    BCS :+
      JMP SetOWScroll   ; and set scroll appropriately
:   JMP SetSMScroll     ;  then exit


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Screen Wipe Frame  [$D742 :: 0x3D752]
;;
;;    Does a single frame of the Screen Wipe effect (map transition).  Updates
;;  the screen wipe sound effect as well.
;;
;;  IN:  tmp+4 = number of scanlines (-11) off the top of the screen that are to be hidden
;;       tmp+5 = number of scanlines in the middle of the screen that are to be visible
;;
;;    'tmp+4' effectively determines where the video gets turned on, and tmp+4 + tmp+5 determines
;;  where the video gets turned off again.  Note that this routine starts counting scanlines 11
;;  lines BEFORE onscreen redering begins... so tmp+4 should be 11 higher than what is actually
;;  desired.
;;
;;    To draw the 'black' portions of the wipe effect, the game simply disables BG rendering
;;  for that portion of the screen.  However, Sprite rendering remains on for the full frame!
;;  So any onscreen sprites will be visible even in portions of the screen where they shouldn't be.
;;  The game gets around this by clearing OAM when it does a screen wipe.  Sprites must be enabled
;;  because if both BG and sprite are disabled, the PPU is switched off and scroll is not updated
;;  as the screen is rendered -- which would completely distort scrolling for the wipe effect.
;;
;;
;;    This routine calls a lot of other routines before it syncs itself up for the timed loops.
;;  If you edit any of the following routines:
;;
;;  - ScreenWipeFrame_Prep
;;  - OnNMI
;;  - DrawMapPalette
;;  - SetOWScroll
;;  - SetSMScroll
;;
;;    then you could potentially mess up the timing for this routine, causing the wipe to occur
;;  offcenter.  If that happens, you can tweak the first '@InitialWait' loop in this routine
;;  to sort of resync it again.  You can also modify what the game writes to tmp+4 in routines
;;  which JSR to here in order to tweak the timing (tmp+4 would make big changes, @InitialWait would
;;  make minor changes)
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



;JIGS : here is another non-critical timing error because the code got squished up! so a fix: its only 3 bytes off
; NOP
; NOP

.ALIGN $100


ScreenWipeFrame:
   ; JSR CallMusicPlay            ; keep music going
    JSR WaitForVBlank_L          ; wait for VBlank
    JSR ScreenWipeFrame_Prep     ; then do prepwork for this frame

    LDX #10                  ; This loop "fine-tunes" the wait.  It works out to 1+5*X cycles
    @InitialWait:            ;  so you can change the value X loads here to increase/decrease
      DEX                    ;  the wait.
      BNE @InitialWait       ; Ultimately, at the end of this loop, you should be about ~1156 cycles
    PAGECHECK @InitialWait   ;  into VBlank (a little under 11 scanlines until onscreen rendering starts)
                             ; If you edit routines SetOWScroll, SetSMScroll, or DrawMapPalette and
                             ;  it messes with the screen wipe effect, you can modify this loop
                             ;  to attempt to realign the timing.

    LDA #$10                 ; turn BG rendering off
    STA $2001
    LDX tmp+4                ; wait for tmp+4 scanlines
    @WaitLines_Off:
      JSR WaitScanline
      DEX
      BNE @WaitLines_Off
    PAGECHECK @WaitLines_Off

    LDA #$1E                 ; turn BG rendering on
    STA $2001
    LDX tmp+5                ; wait for tmp+5 scanlines
    @WaitLines_On:
      JSR WaitScanline
      DEX
      BNE @WaitLines_On
    PAGECHECK @WaitLines_On

    LDA #$10                 ; then turn BG rendering back off.  Leave it off for the rest of the frame
    STA $2001

    LDA tmp+5           ; check the number of visible scanlines
    AND #$0C            ; mask out bits 2,3
    BNE @Exit           ; if either are nonzero, exit
                        ; otherwise... modify the playing wipe sound effect
                        ;  updating the sound effect this way makes it effectively update only
                        ;  once every 4 frames.

     LDA tmp+5
     EOR #$FF           ; invert the number of visible scanlines (so that fewer scanlines visible
     ASL A              ;   = higher period = lower pitch)
     ROL tmp            ; then multiply by 8, rotating carry into tmp (high bits of tmp are unimportant
     ASL A              ;  as they only set the length counter).
     ROL tmp
     ASL A
     STA $4006          ; then write that period to sq2's F value
     ROL tmp
     LDA tmp
     STA $4007          ; output F value is -N * 8 where 'N' is the visible scanlines

  @Exit:
    RTS

    
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Wait a Scanline  [$D788 :: 0x3D798]
;;
;;    JSRing to this routine eats up exactly 109 cycles 2 times out of 3, and 108
;;  cycles 1 time out of 3.  So it effectively eats 108.6667 cycles.  This includes
;;  the JSR.  When placed inside a simple 'DEX/BNE' loop (DEX+BNE = 5 cycles), it
;;  burns 113.6667 cycles, which is EXACTLY one scanline.
;;
;;    This is used as a timing mechanism for some PPU effects like the screen
;;  wipe transition that occurs when you switch maps.
;;
;;    tmp+2 is used as the 3-step counter to switch between waiting 108 and 109
;;  cycles.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

WaitScanline:
    LDY #16          ; +2 cycles
   @Loop:
      DEY            ;   +2
      BNE @Loop      ;   +3  (5 cycle loop * 16 iterations = 80-1 = 79 cycles for loop)

  CRITPAGECHECK @Loop      ; ensure above loop does not cross page boundary

    LDA tmp+2        ; +3
    DEC tmp+2        ; +5
    BNE @NoReload    ; +3 (if no reload -- 2/3)
                     ;   or +2 (if reload -- 1/3)

  CRITPAGECHECK @NoReload  ; ensure jump to NoReload does not require jump across page boundary

  @Reload:
    LDA #3           ; +2   Both Reload and NoReload use the same
    STA tmp+2        ; +3    amount of cycles.. but Reload reloads tmp+2
    RTS              ; +6    with 3 so that it counts down again

  @NoReload:
    LDA #0           ; +2
    LDA tmp+2        ; +3   LDA -- not STA.  It's just burning cycles, not changing tmp+2
    RTS              ; +6


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Start Screen Wipe  [$D79D :: 0x3D7AD]
;;
;;    Does prepwork for the screen wipe effect (for map transitions)
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


StartScreenWipe:
;    LDA #$F8           ; clears OAM to hide sprites during the screen wipe
;    LDX #0             ;   why on earth doesn't this just JSR to ClearOAM?  x_x
;  @Loop:
;      STA oam, X
;      INX
;      BNE @Loop
 
    JSR ClearOAM

    JSR WaitForVBlank_L   ; then wait for VBlank
    LDA #>oam             ; and do sprite DMA
    STA $4014

 ; @OverworldTransition:  
 ;   LDA #$02              ; silence all channels except for square 1
 ;   STA $4015             ;   this stops all music.  Square 1 is used for the wipe sound effect
 ;   LDA #0
 ;   STA $5015             ;   this stops all MMC5 music. (JIGS)
 ;   JMP :+

  @NoTransition:    
    LDA #$30
    STA $4000   ; set Squares and Noise volume to 0
    STA $4004   
    STA $5000   ; set MMC5 Squares volume to 0
    STA $5004   ;
    LDA #%10000000
    STA $4008

    ;LDA CHAN_SQ1 + ch_freq+1
    ;AND #$7F
    ;STA CHAN_SQ1 + ch_freq+1
    ;LDA CHAN_SQ2 + ch_freq+1
    ;AND #$7F
    ;STA CHAN_SQ2 + ch_freq+1
    ;LDA CHAN_SQ3 + ch_freq+1
    ;AND #$7F
    ;STA CHAN_SQ3 + ch_freq+1
    ;LDA CHAN_SQ3 + ch_freq+1
    ;AND #$7F
    ;STA CHAN_SQ3 + ch_freq+1
    ;LDA CHAN_TRI + ch_freq+1
    ;AND #$7F
    ;STA CHAN_TRI + ch_freq+1
    
    ;LDA #22              
    ;STA sq2_sfx           ; mark square 2 as playing SFX for this many frames

    LDA #$38              ; 12.5% duty (harsh), volume=8
    STA $4004             ; uses Square 2 now... you know, the SFX channel?!
    LDA #%10001010        ; sweep downwards in pitch with speed=0 (fast!) and shift=2 (medium)
    STA $4005             ;  don't set F-value here, though -- that isn't done until
                          ;  ScreenWipeFrame
    RTS                   ; exit


;; unused/unreachable

;   JMP CallMusicPlay_NoSwap

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Update Joy  [$D7C2 :: 0x3D7D2]
;;
;;    Reads and processes joypad data, updating:
;;      joy
;;      joy_select
;;      joy_start
;;      joy_b
;;      joy_a
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

UpdateJoy_L: 
UpdateJoy:
    JSR ReadJoypadData
    JMP ProcessJoyButtons


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Read Joypad Data  [$D7C9 :: 0x3D7D9]
;;
;;    This strobes the joypad and reads joy data into our 'joy' variable
;;
;;  OUT:  X is 0 on exit
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

ReadJoypadData:
    LDA #1
    STA $4016    ; strobe joypad (refreshes the latch with up to date joy data)
    LDA #0
    STA $4016

    LDX #$08     ; loop 8 times (have to read each of the 8 buttons 1 at a time)
@Loop:
      LDA $4016  ; get the button state
      AND #$03   ;  button state gets put in bit 0 usually, but it's on bit 1 for the Famicom if
      CMP #$01   ;  the user is using the seperate controllers.  So doing this AND+CMP combo will set
                 ;  the C flag if either of those bits are set (making this routine FC friendly)
      ROL joy    ; rotate the C flag (the button state) into our RAM
      DEX
      BNE @Loop  ; loop until X expires (8 reads, once for each button)

    RTS




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Process Joy Buttons  [$D7E2 :: 0x3D7F2]
;;
;;    This routine examines 'joy' and 'joy_ignore' to determine which buttons are being pressed
;;  joy_start, joy_select, joy_a, and joy_b are all incremented by 1 if their respective buttons
;;  have been pressed... but they are not incremented if a button is being held (ie:  the increment
;;  only happens when you press the button from a released state).
;;
;;    The realtime press/release state of all buttons remains unchanged in 'joy'
;;
;;    'joy_ignore' is altered, but only so it can be examined the next time this routine is called.
;;  Other routines do not use 'joy_ignore'
;;
;;  Note: X is assumed to be 0 on routine entry
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

ProcessJoyButtons:
    LDA joy         ; get joypad data
    AND #$03        ; check Left and Right button states
    BEQ :+          ; if either are pressed...
      LDX #$03      ;   X=$03, otherwise, X=$00
:   STX tmp+1       ; back that value up

    LDA joy         ; get joy data again
    AND #$0C        ; this time, check Up and Down buttons
    BEQ :+
      TXA           ; if either are pressed, OR previous value with $0C
      ORA #$0C      ;  tmp+1 is now a mask indicating which directional buttons we want to keep
      STA tmp+1     ;  directional buttons not included in the mask will be discarded

:   LDA joy         ; get joy data -- do some EOR magic
    EOR joy_ignore  ;  invert it with all the buttons to ignore.
    AND tmp+1       ;  mask out the directional buttons to keep
    EOR joy_ignore  ;  and re-invert, restoring ALL buttons *except* the directional we want to keep
    STA joy_ignore  ;  write back to ignore (so that these buttons will be ignored next time joy data is polled
    EOR joy         ; EOR again with current joy data.

   ; okay this requires a big explanation because it's insane.
   ; directional buttons (up/down/left/right) are treated seperately than other buttons (A/B/Select/Start)
   ;  The game creates a mask with those directional buttons so that the most recently pressed direction
   ;  is ignored, even after it's released.
   ;
   ; To illustrate this... imagine that joy buttons have 4 possible states:
   ;  lifted   (0 -> 0)
   ;  pressed  (0 -> 1)
   ;  held     (1 -> 1)
   ;  released (1 -> 0)
   ;
   ;   For directional buttons (U/D/L/R), the above code will produce the following results:
   ; lifted:   joy_ignore = 0      A = 0
   ; pressed:  joy_ignore = 1      A = 0
   ; held:     joy_ignore = 1      A = 0
   ; released: joy_ignore = 1      A = 0
   ;
   ;   For nondirectional buttons (A/B/Sel/Start), the above produces the following:
   ; lifted:   joy_ignore = 0      A = 0
   ; pressed:  joy_ignore = 0      A = 1
   ; held:     joy_ignore = 1      A = 0
   ; released: joy_ignore = 1      A = 1
   ;
   ;  Yes... it's very confusing.  But not a lot more I can do to explain it though  x_x
   ; Afterwards, A is the non-directioal buttons whose state has transitioned (either pressed or released)

    TAX            ; put transitioned buttons in X (temporary, to back them up)

    AND #$10        ; see if the Start button has transitioned
    BEQ @select     ;  if not... skip ahead to select button check
    LDA joy         ; get current joy
    AND #$10        ; see if start is being pressed (as opposed to released)
    BEQ :+          ;  if it is....
      INC joy_start ;   increment our joy_start var
:   LDA joy_ignore  ; then, toggle the ignore bit so that it will be ignored next time (if being pressed)
    EOR #$10        ;  or will no longer be ignored (if being released)
    STA joy_ignore  ;  the reason for the ignore is because you don't want a button to be pressed
                    ;  a million times as you hold it (like rapid-fire)

@select:
    TXA             ; restore the backed up transition byte
    AND #$20        ; and do all the same things... but with the select button
    BEQ @btn_b
    LDA joy
    AND #$20
    BEQ :+
      INC joy_select
:   LDA joy_ignore
    EOR #$20
    STA joy_ignore

@btn_b:
    TXA
    AND #$40
    BEQ @btn_a
    LDA joy
    AND #$40
    BEQ :+
      INC joy_b
:   LDA joy_ignore
    EOR #$40
    STA joy_ignore


@btn_a:
    TXA
    AND #$80
    BEQ @Exit
    LDA joy
    AND #$80
    BEQ :+
      INC joy_a
:   LDA joy_ignore
    EOR #$80
    STA joy_ignore

@Exit:
    RTS


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;   Draw Palette  [$D850 :: 0x3D860]
;;
;;     Copies the palette from its RAM location (cur_pal) to the PPU
;;   There's also an additional routine here, DrawMapPalette, which will
;;   draw the normal palette, or the "in room" palette depending on whether or
;;   not the player is currently inside rooms.  This is called by maps only
;;
;;     Changes to DrawMapPalette can impact the timing of some raster effects.
;;   See ScreenWipeFrame for details.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

SetPaletteAddress:
    LDA $2002       ; Reset PPU toggle
    LDX #$3F        ; set PPU Address to $3F00 (start of palettes)
    LDA #$00
    JMP SetPPUAddr_XA

DrawPalette_L:
DrawPalette:
    JSR SetPaletteAddress
    TAX
    BEQ _DrawPalette_Norm   ; and copy the normal palette

DrawMapPalette:
    JSR SetPaletteAddress 
    TAX    
    LDA inroom      ; check in-room flag
    BEQ _DrawPalette_Norm   ; if we're not in a room, copy normal palette...otherwise...

  @InRoomLoop:
      LDA inroom_pal, X ; if we're in a room... the BG palette (first $10 colors) come from
      STA $2007         ;   $03E0 instead
      INX
      CPX #$10          ; loop $10 times to copy the whole BG palette
      BCC @InRoomLoop   ;   once the BG palette is drawn, continue drawing the sprite palette per normal

_DrawPalette_Norm:
    LDA cur_pal, X     ; get normal palette
    STA $2007          ;  and draw it
    INX
    CPX #$20           ; loop until $20 colors have been drawn (full palette)
    BCC _DrawPalette_Norm

  ;  LDA $2002          ; once done, do the weird thing NES games do
  ;  LDA #$3F           ;  reset PPU address to start of palettes ($3F00)
  ;  STA $2006          ;  and then to $0000.  Most I can figure is that they do this
  ;  LDA #$00           ;  to avoid a weird color from being displayed when the PPU is off
  ;  STA $2006
  ;  STA $2006
  ;  STA $2006
SetPaletteAddress_ScreenThing:  
    JSR SetPaletteAddress
    STA $2006
    STA $2006  
    RTS



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  WaitVBlank_NoSprites  [$D89F :: 0x3D8AF]
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


WaitVBlank_NoSprites:
    JSR ClearOAM              ; clear OAM
    JSR WaitForVBlank_L       ; wait for VBlank
    LDA #>oam
    STA $4014                 ; then do sprite DMA (hide all sprites)
    RTS                       ; exit



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Load Map Palettes  [$D8AB :: 0x3D8BB]
;;
;;    Note palettes are not loaded from ROM, but rather they're loaded from
;;  the load_map_pal temporary buffer (temporary because it gets overwritten
;;  due to it sharing space with draw_buf).  So this must be called pretty much
;;  immediately after the tileset is loaded.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

LoadMapPalettes:
    LDA #BANK_MAPMANPAL
    JSR SwapPRG_L           ; swap to bank containing mapman palettes
    JSR LoadPlayerMapPalette

    LDX #$2F                ; X is loop counter
  @Loop:
      LDA load_map_pal, X   ; copy colors from temp palette buffer
      STA cur_pal, X        ; to our actual palette
      DEX
      BPL @Loop             ; loop until X wraps ($30 iterations)
    RTS                     ; then exit


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Battle Transition [$D8CD :: 0x3D8DD]
;;
;;    Does the flashy effect for when you begin a battle.  The effect
;;  does not alter the palettes like you might think... instead it uses the
;;  seldom used 'color emphasis' feature of the NES.  It basically cycles
;;  through all the emphasis modes, which makes the screen appear to flash.
;;
;;    This is also coupled with the FF trademarked and ever popular
;;  "shhhheeewww  shhhhheeewww" sound effect on the noise.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


BattleTransition:
    LDA #$08
    STA $4015             ; silence all audio except for noise
    LDA #0
    STA $5015             ; silence all MMC5 audio (JIGS)
    STA tmp+12            ; zero our loop counter (tmp+12)

  ;; loop from $00 - $41

  @Loop:
    JSR WaitForVBlank_L   ; wait for VBlank
    LDA mapflags          ; get map flags to see if this is OW or SM
    LSR A
    BCC @OW               ; fork appropriately

  @SM:
      JSR SetSMScroll         ; set SM scroll if SM
      JMP @Continue
  @OW:
      JSR SetOWScroll_PPUOn   ; or OW scroll if OW

  @Continue:
    LDA tmp+12       ; get loop counter
    ASL A
    ASL A
    ASL A            ; left shift 3 to make bits 2-4 the high bits
    AND #$E0         ; mask them out -- these are our emphasis bits
                     ; this will switch to a new emphasis mode every 4 frames
                     ; and will cycle through all 8 emphasis modes a total of 4 times

    ORA #$0A         ; OR emphasis bits with other info for $2001 (enable BG rendering, disable sprites)
    STA $2001        ; write set emphasis

    LDA #$0F         ; enable volume decay for the noise channel
    STA $400C        ;   and set it to decay at slowest speed -- but since the decay gets restarted every
                     ;   frame in this routine -- this effectively just holds the noise at maximum volume

    LDA tmp+12       ; set noise freq to (loopcounter/2)OR3
    LSR A            ;  this results in the following frequency pattern:
    ORA #$03         ; 3,3,3,3,3,3,3,3, 7,7,7,7,7,7,7,7, B,B,B,B,B,B,B,B, F,F,F,F,F,F,F,F,
    STA $400E        ;    (repeated again)

    LDA #0
    STA $400F        ; reload length counter

    INC tmp+12       ; inc our loop counter
    LDA tmp+12
    CMP #$41

    BCC @Loop        ; and keep looping until it reaches $41

    LDA #$00         ; at which point
    STA $2001        ; turn off the PPU
    STA $4015        ;  and APU

    JMP WaitVBlank_NoSprites   ; then wait for another VBlank before exiting


    ;; JIGS - deleted all the old palette cycling stuff.
    ;; I'll put it back in when I re-order things enough.
    ;; I want to have the original code available everywhere, but it just gets in the way right now.
    
StopNoise_StopSprites:
	LDA #$30					;; JIGS: Turning off noise, because there's a click when
    STA $400C					;; entering menus on the ship
   	JSR WaitVBlank_NoSprites    ; wait for VBlank, and kill all sprites
    JMP CallMusicPlay_NoSwap    ; and update music  (all the typical frame work)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Do Altar Effect [$DA4E :: 0x3DA5E]
;;
;;    This routine performs the "Altar" raster effect.  This effect occurs when you
;;  step on any one of the four altars which revive the orbs.  It creates a 'beam of light'
;;  that starts on the screen where the player is standing and moves towards the upper-left
;;  corner of the screen, while the screen gently shakes and a "voooom" sound effect is played.
;;
;;    Music is silenced during this time, and all input is ignored.  The game is essentially
;;  frozen until this routine exits and the effect is complete (it takes several frames).
;;
;;    The routine uses a few areas in temp RAM for a few things:
;;
;;    tmp    = number of scanlines to delay before starting to illuminate scanlines
;;    tmp+1  = number of scanlines to illuminate
;;    tmp+2  = 0 when the 'beam' is expanding upward from the player sprite to the UL corner
;;             1 when the 'beam' has reached the UL corner and begins retracting to the UL corner
;;              (moving away from the player sprite)
;;    tmp+15 = desired X scroll for the screen (as it needs to be written to $2005)
;;
;;    "Illuminated" scanlines just have the monochrome effect switched on for part of them.  There
;;  are no palette changes involved in this effect.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


DoAltarEffect:
    LDA sm_scroll_x      ; get the X scroll for the map
    ;ASL A                ; multiply it by 16 to get the value need to be written to $2005
    ;ASL A
    ;ASL A
    ;ASL A
    JSR ShiftLeft4
    STA tmp+15           ; record it for future use in the routine

    LDA NTsoft2000       ; copy the NT scroll to the main soft2000 var
    STA soft2000         ; 'soft2000' is written to $2000 automatically every frame (in OnNMI)
                         ; This ensures that the NT scroll will be correct during this routine

    LDA #0
    STA tmp+2            ; clear the phase (start with beam expanding outward from player)
    STA altareffect      ; clear the altar effect flag

    LDA #138
    STA tmp              ; start with a 138 scanline delay before illumination
    LDA #2
    STA tmp+1            ; start with 2 scanlines illuminated

    LDA #$30
    STA $400C            ; silence all audio channels by writing setting their volume to 0
    STA $4004
    STA $4000            ;  note this doesn't silence the triangle because tri has no volume control
    STA $4008            ; instead it marks the linear counter to silence the triangle after $30 clocks (12 frames)
    STA $5000           ; MMC5 Square 1 - JIGS
    STA $5004           ; MMC5 Square 2 - JIGS 

    LDA #$0E
    STA $400E            ; set noise to play freq $E  (2nd lowest pitch possible for noise)
    LDA #$00
    STA $400F            ; start noise playback.  Note noise is still inaudible because its vol=0, but will
                         ; become audible as soon as its volume is changed (see AltarFrame)

    STA $4006            ; set sq2's freq to $500 (low pitch) and start playback
    LDA #$05             ; again it isn't immediately audible, but will be as soon as its vol is changed
    STA $4007

    LDA $2002            ; reset PPU toggle (seems unnecessary here?)

@MainLoop:
    JSR AltarFrame         ; do a frame and sync to desired raster time

    LDX tmp                ; delay 'tmp' scanlines
    @LinesDelay:
      JSR WaitAltarScanline
      DEX
      BNE @LinesDelay
          PAGECHECK @LinesDelay

    LDX tmp+1              ; then illuminate 'tmp+1' scanlines
    @LinesIllum:
      JSR DoAltarScanline
      DEX
      BNE @LinesIllum
          PAGECHECK @LinesIllum

    LDA tmp+2              ; check the phase to see if the beam is expanding/retracting
    BNE @RetractBeam       ; if retracting, jump ahead
                           ; otherwise, beam is expanding

  @ExpandBeam:
    LDA tmp+1           ; inc the number of illuminated scanlines by 2
    CLC
    ADC #$02
    STA tmp+1

    LDA tmp             ; and decrease the delay by 2 (moves top of beam up, but does not move
    SEC                 ; bottom of beam)
    SBC #$02
    STA tmp

    CMP #32             ; see if the delay is < 32 scanlines
    BCS @MainLoop       ; if not, continue as normal

    LDA #1              ; otherwise (< 32 scanline delay), beam has reached top (but not quite top of screen)
    STA tmp+2           ; switch the phase over so that it starts retracting the beam.
    JMP @MainLoop       ; and continue looping

  @RetractBeam:
    LDA tmp+1           ; to retract the beam, simply reduce the number of illuminated lines by 2
    SEC                 ; and do not change the delay
    SBC #$02
    STA tmp+1

    CMP #$08            ; keep looping until < 8 lines are illuminated
    BCS @MainLoop       ;  at which point, we're done


  @Done:                ; altar effect is complete
   ; LDA unk_07D2        ; ???  useless and pretty random.

    LDA tmp+15          ; restore the desired X scroll (to undo the possible shaking)
    STA $2005

    LDA #$00            ; restart sq1, sq2, and tri so they can resume playing the music track
    STA $4007           ;  however note that sq2 is currently playing the wrong note (freq was changed for
    STA $400C           ;  the sound effect)
    STA $4004
    STA $5000           ; MMC5 Square 1 - JIGS
    STA $5004           ; MMC5 Square 2 - JIGS 

    LDA #1              ; to prevent sq2 from playing the wrong note, mark it as playing a sound effect so
    STA sq2_sfx         ; the proper freq will be set by the music playback.

    RTS                 ; then exit!

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Altar Frame  [$DADE :: 0x3DAEE]
;;
;;    This routine is called to wait for a frame for the Altar Effect.
;;  It syncs up the frame so that scanlines can be waited and the timed raster effect
;;  for the Altar Effect can be performed.
;;
;;    IN:  tmp+1  = number of monochrome scanlines
;;         tmp+15 = X scroll as written to PPU (sm_scroll_x * 16)
;;
;;    The routine exits about 593 cycles (roughly 5.2 scanlines) into VBlank.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

AltarFrame:
    LDA tmp+1         ; get number of monochrome'd scanlines
    LSR A             ; divide by 8
    LSR A
    LSR A

    ORA #$30          ; use monochrome scanlines/8 as the volume for sq2 and noise effect
    STA $400C         ;  this will cause the sound effect to fade in and fade out and more/less
    STA $4004         ;  lines of the effect are visible

    AND #$01          ; also use the low bit of lines/8 as a scroll adjustment
    EOR tmp+15        ; OR with desired X scroll
    STA $2005         ; and record this as the scroll for the next frame.  This causes
                      ;  the screen to "shake" by 1 pixel every 8 frames.  This hides
                      ;  the unavoidable inperfection of the monochrome effect (unavoidable because
                      ;  you can't time the writes to the exact pixel no matter how careful you are)

    JSR WaitForVBlank_L    ; wait for VBlank.  This returns ~37 cycles into VBlank
    LDA #>oam         ; Do sprite DMA.  This burns another 513+2+4 cycles -- currently ~556 into VBl
    STA $4014

    LDY #6            ; do a bit more stalling to get the time right where we want it (+2 cycs for LDY)
  @Loop:
      DEY
      BNE @Loop       ; 5*6 - 1 = 29 for loop
    RTS               ; +6 for RTS = routine exits ~593 cycs into VBl

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Wait an Altar Scanline  [$DB00 :: 0x3DB10]
;;
;;    This routine is similar to WaitScanline, however it is specifically applicable
;;  to the Altar effect because it waits *exactly* 109 cycles (and not 108.66667).  This
;;  causes a wait a little longer than a full scanline (1 dot longer), which produces a diagonal
;;  raster effect, rather than a perfect vertical line.
;;
;;    JSRing to this routine eats exactly 109 cycles.  When placed inside a 'DEX/BNE' loop,
;;  this totals 114 cycles (DEX+BNE = 5 cycles) which is 1 dot longer than a scanline.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.ALIGN $100

.byte "JIGSCHECK"

WaitAltarScanline:   ; JSR to routine = 6 cycles
    LDY #18          ; +2 = 8
  @Loop:
     DEY
     BNE @Loop       ; 5 cycle loop * 18 iterations - 1 = 89 cycles for loop
                     ; 8+89 = 97 cycs

       CRITPAGECHECK @Loop

    NOP              ; +2 = 99
    NOP              ; +2 = 101
    NOP              ; +2 = 103
    RTS              ; +6 = 109



;; unused NOPs
;    NOP
;    NOP
;; JIGS 


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Do an Altar Scanline [$DB0B :: 0x3DB1B]
;;
;;    This routine waits 109 cycles just like WaitAltarScanline, however it toggles monochrome
;;  mode at points within the scanline to create the altar effect.  Monochrome is switched on
;;  63 cycles in and switched off 103 cycles in, resulting in a monochrome effect for 40 cycles
;;  (120 pixels).  Since there's an effective 114 cycle delay between calls, each call occurs
;;  one dot/pixel later in the scanline than the previous, which results in the monochrome effect moving
;;  diagonally down-right rather than straight down.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


DoAltarScanline:
    LDY #10         ; 8 cycs (JSR=6 + LDY=2)
   @Loop:
      DEY
      BNE @Loop     ; 5 cyc loop * 10 iterations - 1 = 49 cycs for loop.  49+8 = 57 cycs

      CRITPAGECHECK @Loop

    LDA #$1F        ; +2 = 59
    STA $2001       ; +4 = 63 -- monochrome turned on 63 cycs in

    LDY #$1E        ; +2 = 65
    NOP             ; +2 = 67
    NOP             ; +2 = 69
    JSR @Burn12     ; +12= 81
    JSR @Burn12     ; +12= 93
    NOP             ; +2 = 95
    NOP             ; +2 = 97
    NOP             ; +2 = 99
    STY $2001       ; +4 = 103 -- monochrome turned off 103 cycs in
                    ;   following RTS makes this routine 109 cycles long

  @Burn12:          ; the routine JSRs here to burn 12 cycles (JSR+RTS = 12 cycs)
    RTS

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  PlaySFX_Error   [$DB26 :: 0x3DB36]
;;
;;    Plays the error sound effect.  This sound effect isn't a simple sweep like
;;  most of the other menu sound effects... so it requires a few frames of attention.
;;  it's also hardcoded in this routine.  Because of the combination of these, this routine
;;  doesn't exit until the sound effect is complete... which is why the game will actually
;;  pause for a few frames while this sound effect is playing!
;;
;;    This sound effect is accomplished by rapidly playing the same tone 16 times (one each
;;  frame for 16 frames).  The tone is set to sweep upwards rapidly, so the sweep unit will ultimately
;;  silence the tone before the next is played.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

PlaySFX_Error:
;    LDA #1           ; mark that square 2 will be used as a sound effect for 1 frame
;    STA sq2_sfx      ;  though the MusicPlay routine is not called here, so it's actually longer.
                     ; this will not take effect until after this routine exits... so it's really
                     ; 1 frame after this routine exits

;    LDA #$30
;    STA $4000        ; silence square 1 (set volume to 0)
;    STA $4008        ; attempt (and fail) to silence triangle (this just sets the linear reload.. but without
                     ;   a write to $400B, it will not take effect)
;    STA $400C        ; silence noise (set vol to 0)

;    LDY #$0F         ; loop 16 times
;  @Loop:
;      JSR @Frame     ; do a frame
;      DEY            ; dec Y
;      BPL @Loop      ; and repeat until Y wraps

;    LDA #$30         ; then silence sq2 (vol to zero)
;    STA $4004
;    LDA #$00
;    STA $4006        ; and reset sq2's freq to 0
;    RTS              ; then exit

;  @Frame:
;    JSR WaitForVBlank_L    ; wait a frame

;    LDA #%10001100    ;  50% duty, decay speed=%1100, no fixed volume, length enabled
;    STA $4004
;    LDA #%10001001    ;  sweep upwards in pitch, speed=0 (fast!), shift=1 (large steps!)
;    STA $4005

;    LDA #$80
;    STA $4006         ; set initial freq to $080 (but it will sweep upwards in pitch quickly)
;    LDA #$00          ; and length to $0A  (longer than 1 frame... so length might as well be disabled
;    STA $4007         ;   because this is written every frame)
;    RTS

;; JIGS - original game code ^ up there
;; This new code uses noise channel instead.

    LDA Options
    AND #SFX_MUTED
    BEQ @Muted
    
    LDA #%00000010
    STA $400C
    LDA #%00001100
    STA $400E
;;    LDA #%00011000
;;    STA $400C
;;    LDA #%00001100
;;    STA $400E

    JSR @ErrorSFXLoop
    
    LDA #$30   
    STA $400C
    
    JSR @ErrorSFXLoop
    
    LDA #%00000100
    STA $400C
    LDA #%00001100
    STA $400E
    LDA #%01000000
    STA $400F
;;    LDA #%00011000
;;    STA $400C
;;    LDA #%00001100
;;    STA $400E
;;    LDA #%00010000
;;    STA $400F
    RTS
       
   @ErrorSFXLoop:
    LDY #3
    STY tmp+6
   @Loop:
       JSR @Frame
       DEC tmp+6
       BNE @Loop  ; do 3 frames, then a fourth
       
   @Frame:
    JSR WaitForVBlank_L
    JMP CallMusicPlay

   @Muted:
    JMP BattleScreenShake
    
   ;; JIGS - note for this screen shake thing, I had to include another routine that
   ;; clears the nametables to the side of the screen, otherwise garbled pixels
   ;; would show up on the edge of the screen in the menu
   
   ;; JIGS - also there is an alternate noise I tried, in the commented out part of my code.

;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Draw Dialogue String [$DB64 :: 0x3DB74]
;;
;;    Draws a string to the dialogue.  This is similar to DrawComplexString, however
;;  unlike DrawComplexString, this routine is written to handle the drawing crossing an
;;  NT boundary.  The control codes are also a bit different (and there aren't near as many of them)
;;
;;  IN:             A = dialogue string ID to draw
;;       box_x, box_y = name might be confusing, these are actually the coords at which
;;                        to start string drawing (IE:  they're not really the coords of the
;;                        containing box).
;;         dlg_itemid = item ID for use with the $02 control code (see below)
;;
;;    tmp+7 is used as a "precautionary counter" that decrements every time a DTE code is
;;  used.  Once it expires, the game stalls for a frame.  Since all this drawing is done
;;  while the PPU is on, this helps ensure that writes don't spill out past the end of VBlank.
;;  A stall also occurs on line breaks.
;;
;;  Byte codes are as follows:
;;
;;  $00 = null terminator (marks end of string)
;;  $01 = line break (only seems to be used in the treasure chest "You Found..." dialogue)
;;  $02 = control code to draw an item name (item ID whose name to draw is in dlg_itemid)
;;  $03 = draw the name of the lead character, then stop string drawing (JIGS: fixed!)
;;  $05 = line break
;;  $04,$06-19 = unused, but defaults to a line break
;;  $1A-79 = DTE codes
;;  $7A-FF = single tile output
;;
;;    I don't think code $03 is used anywhere in the game.  It's a little bizarre... maybe it was used
;;  in the J version?
;;
;;    Control code $02 is used for the treasure chest text in order to print the item you found.
;;  the item found is stored in dlg_itemid prior to this routine being called.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;

DrawDialogueString_Done:
    JSR SetSMScroll       ; when done drawing, simply reset the scroll
    RTS                   ; and exit

DrawDialogueString:
    TAX                   ; put string ID in X temporarily

    LDA DialogueBank ; this is set by NPC's lut_MapObjTalkData stuff ; $10 if using first table, $11 if second
    STA cur_bank          ; set cur_bank to bank containing dialogue text (for Music_Play)
    JSR SwapPRG_L         ; and swap to that bank

    JSR GetDialogueString
  
  @PtrLoaded:             ; here, text_ptr points to the desired string
    LDA #10
    STA tmp+7             ;  set precautionary counter to 10

    JSR WaitForVBlank_L   ; wait for VBlank

    LDA box_x             ; copy placement coords (box_*) to dest coords (dest_*)
    STA dest_x
    LDA box_y
    STA dest_y
    JSR SetPPUAddrToDest  ; then set the PPU address appropriately

  @Loop:
    LDY #0                       ; zero Y for indexing
    LDA (text_ptr), Y            ; get the next byte in the string
    BEQ DrawDialogueString_Done  ; if it's zero (null terminator), exit

    INC text_ptr                 ; otherwise increment the pointer
    BNE :+
      INC text_ptr+1             ;   inc high byte if low byte wrapped

:   CMP #$1A
    BCC @ControlCode     ; if the byte is < $1A, it's a control code

    CMP #$7A
    BCC @DTE             ; if $1A-$79, it's a DTE code

   @SingleTile:
      STA $2007            ; otherwise ($7A-$FF), it's a normal single tile.  Draw it

      LDA dest_x           ; increment the dest address by 1
      CLC
      ADC #1
      AND #$3F             ; and mask it with $3F so it wraps around both NTs appropriately
      STA dest_x           ; then write back

      AND #$1F             ; then mask with $1F.  If result is zero, it means we're crossing an NT boundary
      BNE @Loop            ;  if not zero, just continue looping
        JSR SetPPUAddrToDest  ;  otherwise if zero, PPU address needs to be reset (NT boundary crossed)
        JMP @Loop             ;  then jump back to loop


   @DTE:                 ; if byte fetched was a DTE code ($1A-79)
      SEC
      SBC #$1A           ; subtract $1A to make the DTE code zero based
      TAX                ; put in X for indexing
      PHA                ; and push it to back it up (will need it again later)

      LDA lut_DTE1, X    ; get the first byte in the DTE pair
      STA $2007          ; and draw it
      JSR @IncDest       ; update PPU dest address

      PLA                ; restore DTE code
      TAX                ; and put it in X again (X was corrupted by @IncDest call)
      LDA lut_DTE2, X    ; get second byte in DTE pair
      STA $2007          ; draw it
      JSR @IncDest       ; and update PPU address again

      DEC tmp+7            ; decrement cautionary counter
      BNE @Loop            ; if it hasn't expired yet, keep drawing.  Otherwise...

        JSR SetSMScroll      ; we could be running out of VBlank time.  So set the scroll
        JSR CallMusicPlay    ; keep music playing
        JSR WaitForVBlank_L  ; then wait another frame before continuing drawing

        LDA #10
        STA tmp+7            ; reload precautionary counter
        JSR SetPPUAddrToDest ; and set PPU address appropriately
        JMP @Loop            ; then resume drawing

  @ControlCode:          ; if the byte fetched was a control code ($01-19)
    CMP #$03             ; was the code $03?
    BNE @Code_Not03      ; if not jump ahead

    @PrintName:            ; Control Code $03 = prints the name of the lead character
      LDA text_ptr         ; push the text pointer to the stack to back it up
      PHA
      LDA text_ptr+1
      PHA
      
      LDX #0               ; X = lead character only
      JSR DrawPlayerName  
      JSR FixPlayerName

      LDA #<(format_buf-7) ; make text_ptr point to the format buffer
      STA text_ptr
      LDA #>(format_buf-7)
      JMP @ItemPtrLoaded
      ;; JIGS - fixed name printing! Yay

  @Code_Not03:           ; Control codes other than $03
    CMP #$02             ; was code $02
    BNE @Code_Not02_03   ; if not, jump ahead

    @PrintItemName:        ; Control Code $02 = prints the ID of the item stored in dlg_itemid (used for treasure chests)
      LDA text_ptr         ; push the text pointer to the stack to back it up
      PHA
      LDA text_ptr+1
      PHA

      ;; JIGS - swap to item bank, which isn't in dialogue bank anymore
      LDA #BANK_ITEMS
      JSR SwapPRG_L        
      ;; 
      
      LDX dlg_itemid       ; get the item ID whose name we're to print
      LDA treasure_offset
      BEQ @PrintItem
      CMP #2
      BEQ :+

      LDA lut_MagicNames_Low, X
      STA text_ptr
      LDA lut_MagicNames_High, X
      JMP @ItemPtrLoaded
      
      ;; print weapon or armor name instead
    : LDA lut_EquipmentNames_Low, X 
      STA text_ptr
      LDA lut_EquipmentNames_High, X
      JMP @ItemPtrLoaded  
      
     @PrintItem:
      LDA lut_ItemNames_Low, X   ; or from 2nd half if ID >= $80
      STA text_ptr
      LDA lut_ItemNames_High, X
      
     @ItemPtrLoaded: 
      STA text_ptr+1
      JSR @Loop            ; once pointer is loaded, JSR to the @Loop to draw the item name

      PLA                  ; then restore the original string pointer by pulling it from the stack
      STA text_ptr+1
      PLA
      STA text_ptr
      
      ;; JIGS - swap back to dialogue bank
      LDA DialogueBank
      JSR SwapPRG_L         
      ;;

      JMP @Loop            ; and continue drawing the rest of the string

  @Code_Not02_03:          ; all other control codes besides 02 and 03
    JSR @LineBreak         ; just do a line break
    JMP @Loop              ; then continue


@IncDest:                  ; called by DTE bytes to increment the dest address by 1 column
    LDA dest_x             ; add 1 to the X coord
    CLC
    ADC #1
    AND #$3F               ; AND with $3F to wrap around NT boundaries properly
    STA dest_x

    AND #$1F               ; then check the low 5 bits.  If they're zero, we just crossed an NT boundary
    BNE :+
      JMP SetPPUAddrToDest ; if crossed an NT boundary, the PPU address needs to be changed
:   RTS                    ; then return


@LineBreak:                ; wait a frame between each line break to help ensure we stay in VBlank
    JSR SetSMScroll        ; set the scroll
    JSR CallMusicPlay      ; and keep music playing

    LDA #8
    STA tmp+7              ; reload precautionary counter (but with only 8 instead of 10?)

    JSR WaitForVBlank_L    ; then wait for VBlank

    LDA box_x              ; reset dest X coord to given placement coord
    STA dest_x

    LDA dest_y             ; then add 1 to the dest Y coord to move it a line down
    CLC
    ADC #1
    CMP #30                ; but wrap from 29->0  because there are only 30 rows on the nametable
    BCC :+
      SBC #30
:   STA dest_y

    JMP SetPPUAddrToDest   ; then set the PPU address and continue string drawing


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  SetPPUAddrToDest  [$DC80 :: 0x3DC90]
;;
;;    Sets the PPU address to have it start drawing at the coords
;;  given by dest_x, dest_y.  The difference between this and the below
;;  CoordToNTAddr routine is that this one actually sets the PPU address
;;  (whereas the below simply does the conversion without setting PPU
;;  address) -- AND this one works when dest_x is between 00-3F (both nametables)
;;  whereas CoordToNTAddr only works when dest_x is between 00-1F (one nametable)
;;
;;  IN:  dest_x, dest_y
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

SetPPUAddrToDest:
    LDA $2002          ; reset PPU toggle
    LDX dest_x         ; get dest_x in X
    LDY dest_y         ; and dest_y in Y
    CPX #$20           ;  the look at the X coord to see if it's on NTB ($2400).  This is true when X>=$20
    BCS @NTB           ;  if it is, to NTB, otherwise, NTA

 @NTA:
    LDA lut_NTRowStartHi, Y  ; get high byte of row addr
    STA $2006                ; write it
    TXA                      ; put column/X coord in A
    ORA lut_NTRowStartLo, Y  ; OR with low byte of row addr
    STA $2006                ; and write as low byte
    RTS

 @NTB:
    LDA lut_NTRowStartHi, Y  ; get high byte of row addr
    ORA #$04                 ; OR with $04 ($2400 instead of $2000)
    STA $2006                ; write as high byte of PPU address
    TXA                      ; put column in A
    AND #$1F                 ; mask out the low 5 bits (X>=$20 here, so we want to clip those higher bits)
    ORA lut_NTRowStartLo, Y  ; and OR with low byte of row addr
    STA $2006                ;  for our low byte of PPU address
    RTS

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;   Convert Coords to NT Addr   [$DCAB :: 0x3DCBB]
;;
;;   Converts a X,Y coord pair to a Nametable address
;;
;;   Y remains unchanged
;;
;;   IN:    dest_x
;;          dest_y
;;
;;   OUT:   ppu_dest, ppu_dest+1
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

CoordToNTAddr:
    LDX dest_y                ; put the Y coord (row) in X.  We'll use it to index the NT lut
    LDA dest_x                ; put X coord (col) in A
    AND #$1F                  ; wrap X coord
    ORA lut_NTRowStartLo, X   ; OR X coord with low byte of row start
    STA ppu_dest              ;  this is the low byte of the addres -- record it
    LDA lut_NTRowStartHi, X   ; fetch high byte based on row
    STA ppu_dest+1            ;  and record it
    RTS

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  [$DCF4 :: 0x3DD04]
;;
;;  These LUTs are used by routines to find the NT address of the start of each row
;;    Really, they just shortcut a multiplication by $20 ($20 tiles per row)
;;

lut_NTRowStartLo:
  .BYTE $00,$20,$40,$60,$80,$A0,$C0,$E0
  .BYTE $00,$20,$40,$60,$80,$A0,$C0,$E0
  .BYTE $00,$20,$40,$60,$80,$A0,$C0,$E0
  .BYTE $00,$20,$40,$60,$80,$A0,$C0,$E0

lut_NTRowStartHi:
  .BYTE $20,$20,$20,$20,$20,$20,$20,$20
  .BYTE $21,$21,$21,$21,$21,$21,$21,$21
  .BYTE $22,$22,$22,$22,$22,$22,$22,$22
  .BYTE $23,$23,$23,$23,$23,$23,$23,$23



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Draw Image Rectangle  [$DCBC :: 0x3DCCC]
;;
;;    Draws a rectangle of given dimensions with tiles supplies by a buffer.
;;  This allows for simple drawing of a rectangular image.
;;
;;    Note that the image can not cross page boundaries.  Also, no stalling
;;  is performed, so the PPU must be off during a draw.  Also note this routine does not
;;  do any attribute updating.  Image buffer cannot consist of more than 256 tiles.
;;
;;  IN:   dest_x,  dest_y = Coords at which to draw the rectangle
;;       dest_wd, dest_ht = dims of rectangle
;;            (image_ptr) = points to a buffer containing the image to draw
;;                  tmp+2 = tile additive.  This value is added to every non-zero tile in the image
;;
;;    Such a shame this seems to only be used for drawing the shopkeeper.  Really seems like
;;  it would be a more widely used routine.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

DrawImageRect:
    JSR CoordToNTAddr    ; convert the given destination to a usable PPU address
    LDY #0               ; zero our source index, Y

    LDA dest_ht          ; get our height
    STA tmp              ;  and store it in tmp (this will be our row loop down counter)

  @RowLoop:
    LDA $2002            ; reset PPU toggle
    LDA ppu_dest+1       ; load up desired PPU address
    STA $2006
    LDA ppu_dest
    STA $2006

    LDX dest_wd          ; load width into X (column down counter)
   @ColLoop:
      LDA (image_ptr), Y  ; get a tile from the image
      BEQ :+              ; if it's nonzero....
        CLC
        ADC tmp+2         ; ...add our modifier to it
:     STA $2007           ; draw it
      INY                 ; inc source index
      DEX                 ; dec our col loop counter
      BNE @ColLoop        ; continue looping until X expires

    LDA ppu_dest          ; increment the PPU dest by $20 (one row)
    CLC
    ADC #$20
    STA ppu_dest

    LDA ppu_dest+1        ; include carry in the high byte
    ADC #0
    STA ppu_dest+1

    DEC tmp               ; decrement tmp, our row counter
    BNE @RowLoop          ; and loop until it expires

    RTS                   ; then exit




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Open Treasure Chest  [$DD78 :: 0x3DD88]
;;
;;    Opens a treasure chest, gives the item to the party (if possible), marks
;;  the chest as open, and sets 'dlgsfx' appropriately (for TC jingle or key item
;;  fanfare)
;;
;;  IN:  tileprop+1 = ID of the chest (2nd byte of tile properties)
;;           dlgsfx = assumed to be zero
;;
;;  OUT:          A = dialogue text ID to print
;;           dlgsfx = sound effect to play 1=key item fanfare, 2=tc jingle
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

OpenTreasureChest:
    LDA #BANK_TREASURE       ; swap to bank containing treasure chest info
    JSR SwapPRG_L

    LDA tileprop             ; get either 0 or 1 from the tile properties 
    AND #$01                 ; 1 = first table of treasure
    TAX                      ; 0 = second table of treasure
    LDA lut_TreasureTable_Low, X
    STA tmp
    LDA lut_TreasureTable_High, X
    STA tmp+1
    
    LDA tileprop+1
    ASL A
    BCC @LoadTreasure
    
    INC tmp+1
    
   @LoadTreasure:
    TAY 
    LDA (tmp), Y
    STA shop_type 
    INY
    LDA (tmp), Y
    STA dlg_itemid
    LDA #0
    STA treasure_offset
  
   @CheckTreasure:
    LDA shop_type
    CMP #SHOP_ARMOR          ; 0-1 = equipment
    BCC @Equipment
    CMP #SHOP_SKILLS         ; 2-5 = magic
    BCC @Magic
    CMP #SHOP_CLINIC         ; 6-7 = skill or item
    BCC @Items               ; 8+  = gold
  
   ;; if it didn't branch to magic or items, its gotta be gold!
    LDA dlg_itemid
    JSR LoadPrice            ; get the price of the item (the amount of gold in the chest)
    JSR AddGPToParty         ; add that price to the party's GP
    JMP @OpenChest           ; then mark the chest as open, and exit
  
   @Equipment:
    JSR Set_Inv_Weapon
    INC treasure_offset      ; turn on treasure_offset for the Dialogue box drawing
    BNE :+
    
   @Magic:
    JSR Set_Inv_Magic
  : INC treasure_offset      ; 2 = equipment, 1 = magic
    LDA dlg_itemid
    JSR ADD_ITEM
    BCS @TooFull
    BCC @OpenChest    
    
   @Items:
    LDA dlg_itemid
    CMP #ITEM_KEYITEMSTART   ; if its a key item
    BCS @KeyItem
    
    ;; otherwise, its a normal item
    
    TAX                      ; put item ID in X
    LDA items, X             ; see how many of this item the player has
    CMP #99                  ; see if they have >= 99
    BCS @TooFull
      INC items, X           ; give them one of this item -- but only if they have < 99
      BNE @OpenChest
    
   @TooFull:                  ; If too full...
    LDA #DLGID_CANTCARRY     ; select "You can't carry any more" text
    RTS
    
   @KeyItem:
    PHA
    JSR Set_Inv_KeyItem
    PLA
    JSR ADD_ITEM_1BIT
    INC dlgsfx               ; turn on key-item jingle 

   @OpenChest:
    LDA tileprop
    LSR A 
    BCC @FlagChest_2 
   
   @FlagChest_1:
    LDX tileprop+1           ; re-get the chest index
    LDA game_flags, X        ; set the game flag for this chest to mark it as opened
    ORA #GMFLG_TCOPEN        ; 
    BNE :+
    
   @FlagChest_2: 
    LDX tileprop+1           ; re-get the chest index
    LDA game_flags, X        ; set the game flag for this chest to mark it as opened
    ORA #GMFLG_TCOPEN_2
    
  : STA game_flags, X        ; 
   
    JSR IsThisAChest
    BNE @NotChest             ; so skip ahead to alternate message

    LDA #0                    ; since SetChestAddr hijacks the door-drawing code
    STA tileprop+1            ; tileprop+1 needs to be 0
    LDA facing                ; and joy needs to be the direction the character is facing
    STA joy                   ; instead of the direction they're going to be moving
   
    JSR SetChestAddr
    
   @DrawOpenChest:
    LDA #%00000011             ; first clunk
    STA $400C
    LDA #%00001011
    STA $400E
    LDA #$0
    STA $400F         
    
    LDA #10
    STA noise_sfx              ; play noise for 10 frames
  : JSR WaitForVBlank
    JSR CallMusicPlay
    DEC noise_sfx 
    BNE :-
    
    LDA #%00000011             ; second clunk
    STA $400C
    LDA #%00001000
    STA $400E
    LDA #0
    STA $400F         
    
    LDA $2002
    LDA doorppuaddr+1
    STA $2006
    LDA doorppuaddr
    STA $2006
    LDA #$7A
    STA $2007
    LDA #$7B
    STA $2007
    JSR SetSMScroll
   
    LDA #DLGID_TCGET         ; put the treasure chest dialogue ID in A before exiting!
    RTS
 
  @NotChest:
    LDA #DLGID_HIDDENTREASURE
    RTS

IsThisAChest:
    LDA tmp+10                ; get backed-up Y
    LSR A                     ; halve it
    TAY                       ; put it back in Y
    LDA tsa_ul, Y             ; use it to index the upper left chest tile
    CMP #$2A                  ; if its not $2A, its not using the chest graphic
    RTS




;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Add GP To Party  [$DDEA :: 0x3DDFA]
;;
;;  IN:  tmp - tmp+2 = GP to give to party
;;
;;  BUGGED -- theoretically, it is possible for this routine to allow
;;   you to go over the maximum ammount of gold if you add a large enough number.
;;
;;     After CMPing the high byte of your gold against the maximum, it
;;  only does a BCC (which is only a less than check).  It proceeds to check the middle
;;  bytes EVEN IF the high byte of gold is GREATER than the high byte of the max.  This
;;  means that numbers such as 1065535 will not appear to be over the maximum when, in
;;  fact, they are.
;;
;;  Update: Disch fixed this!
;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;

AddGPToParty:
    LDA gold        ; Add the 3 bytes of GP to the
    CLC             ;  party's gold total
    ADC tmp
    STA gold
    LDA gold+1
    ADC tmp+1
    STA gold+1
    LDA gold+2
    ADC tmp+2
    STA gold+2

    CMP #^1000000   ; see if high byte is over maximum
    BCC @Exit       ; if gold_high < max_high, exit
    BEQ @CheckMid   ; high bytes are equal -- need to compare middle bytes   
    BCS @Max        ; gold_high > max_high, we're over the max               

  @CheckMid:                                                                 
    LDA gold+1
    CMP #>1000000   ; check middle bytes
    BCC @Exit       ; if gold < max, exit
    BEQ @CheckLow   ; if gold = max, check low bytes
    BCS @Max        ; if gold > max, over maximum

  @CheckLow:
    LDA gold
    CMP #<1000000   ; check low bytes
    BCC @Exit       ; if gold < max, exit

  @Max:
    LDA #<999999    ; replace gold with maximum
    STA gold
    LDA #>999999
    STA gold+1
    LDA #^999999
    STA gold+2

  @Exit:
    RTS




DrawMenuString_FixedBank:
    LDA #BANK_MENUSTRINGS
    JSR SwapPRG_L
    JMP DrawMenuString_A

DrawMenuString_CharCodes_FixedBank:
    LDA #BANK_MENUSTRINGS
    JSR SwapPRG_L
    JMP DrawMenuString_CharCodes_A

ItemDescriptions: ; called from Bank E, swaps to bank A
    JSR SwapPRG_L    
    LDA lut_ItemDescStrings_Low, X
    STA text_ptr
    LDA lut_ItemDescStrings_High, X    
    STA text_ptr+1
    JMP DrawComplexString

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Draw Complex String   [$DE29 :: 0x3DE39]
;;
;;    Complex Strings are null terminated strings which can contain line breaks
;;  DTE codes, and other control codes indicating a specific number to draw and other
;;  things.
;;
;;    Depending on how complex the string is... this routine can be pretty quick,
;;   or dreadfully slow.  DTE, line breaks, and regular characters go by reasonably
;;   fast... but special control codes can take a considerable timeframe.
;;
;;    One thing to note is that the drawn string cannot cross NT boundaries.  And also,
;;   the source text cannot span multiple banks.
;;
;;   IN:   cur_bank      = PRG bank containing the text data to draw
;;         ret_bank      = PRG bank to swap back to upon completion (ie:  the bank currently swapped in)
;;         dest_x,dest_y = Destination X,Y coords
;;         text_ptr      = Pointer to the source text to draw
;;
;;       cur_bank and ret_bank can be used so that this routine can be called from any bank
;;   without worry of swapping hassles.  The text doesn't even need to be on the same
;;   bank as the routine that wants to draw it!
;;
;;
;;   And yes... this routine is bloody HUGE.  But 95% of it is for the control codes.
;;
;;     And now for a verbose list of control codes:
;;
;;  00       = null terminator (marks end of string) -- not really a control code I suppose
;;  01       = double line break
;;  02 xx    = item name 'xx'
;;  03 xx    = price of item 'xx'
;;  04       = current GP amount
;;  05       = single line break
;;  06 xx    = JIGS - Magic item name
;;  07 xx    = JIGS - Weapon/Armor item name
;;  08       = JIGS - Decrement X
;;  09 xx    = JIGS - print 'xx' spaces 
;;  0A xx    = JIGS - Increment X position by 'xx (invisible tile basically!)
;;  0B xx yy = JIGS - Do 'yy' tile ID by 'xx' amount. ($0B,$09,$FF would do 9 $FFs)
;;  0C-0F    = unused (default to single line break)
;;  10 xx    = draw stat code 'xx' for character 0
;;  11 xx    = draw stat code 'xx' for character 1
;;  12 xx    = draw stat code 'xx' for character 2
;;  13 xx    = draw stat code 'xx' for character 3
;;  14-19    = unused (default to single line break)
;;  16       = JIGS - skip drawing this
;;
;;   stat codes (for use with control codes $10-13) are as follows:
;;
;;  01    = class
;;  02    = out of battle stat icon (ailments)
;;  03    = Level
;;  04    = Exp
;;  05    = Cur HP
;;  06    = Max HP
;;  07-0F ;; nothing
;;  10    ;; 10 cannot be used! See DrawCharMenuString_Len in Bank E
;;  11    = Strength
;;  12    = Agility
;;  13    = Intelligence
;;  14    = Vitality
;;  15    = Speed
;;  16    = Damage
;;  17    = Hit Rate (Accuracy)
;;  18    = Defense
;;  19    = Evasion
;;  1A    = Magic Defense
;;  1B    = Crit Rate
;;  1C    = Morale
;;  1D    = Damage without weapon
;;  1E-1F = Exp to next level
;;  20-27 = Cur MP
;;  30-37 = Max MP
;;  40-57 = Magic Spells
;;  60    = name (fixed width)
;;  everything above 58 and not 60 defaults to: name (variable width)
;;  
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; JIGS - there are a fair few changes in here.


DrawComplexString_Exit:
    LDA #$00       ; reset scroll to 0
    STA $2005
    STA $2005
    LDA ret_bank   ; swap back to original bank
    JMP SwapPRG_L  ;   then return

ComplexString_Backspace:
    DEC ppu_dest              ;; Important to note that it doesn't dec the high byte. 
    JMP ComplexString_SetDest ;; Only use this when you know its not gonna mess up!

DrawComplexString_L:
DrawComplexString:
    LDA cur_bank
    JSR SwapPRG_L
    JSR CoordToNTAddr

ComplexString_CheckMenuStall:
    JSR MenuCondStall ; See if it needs to wait for VBlank or not; will wait if it does (menustall = $01)
    
ComplexString_SetDest:    
    LDX $2002         ; reset PPU toggle
    LDX ppu_dest+1    ;  load and set desired PPU address
    STX $2006         ;  do this with X, as to not disturb A, which is still our character
    LDX ppu_dest
    STX $2006

ComplexString_GetNext:
    LDY #0            ; zero Y -- we don't want to use it as an index.  Rather, the pointer is updated
    LDA (text_ptr), Y ;   after each fetch
    BEQ DrawComplexString_Exit   ; if the character is 0  (null terminator), exit the routine

    INC text_ptr      ; otherwise, inc source pointer
    BNE :+
      INC text_ptr+1  ;   inc high byte if low byte wrapped

:   CMP #$1A          ; values below $1A are control codes.  See if this is a control code
    BCC ComplexStringControlCode  ;   if it is, jump ahead

ComplexString_DrawAndResume:    
    JSR ComplexString_JustDraw
    JMP ComplexString_GetNext ; and repeat the process until terminated

;; JIGS - seperating this allows control codes to draw tiles without having to resume the main string or substring

ComplexString_JustDraw:
    CMP #$6A          ; see if this is a DTE character
    BCS @noDTE        ;  if < #$6A, it is DTE

      SEC             ;  characters 1A-69 are valid DTE characters. 
      SBC #$1A        ; subtract #$1A to get a zero-based index
      TAX             ; put the index in X
      LDA lut_DTE1, X ;  load and draw the first character in DTE
      STA $2007
      LDA lut_DTE2, X ;  load the second DTE character to be drawn in a bit
      INC ppu_dest    ;  increment the destination PPU address

  @noDTE:
    STA $2007         ; draw the character as-is
    INC ppu_dest      ; increment dest PPU address
    RTS
    
    
;; JIGS - mini rant. I have to wonder at the purpose of the original code setting the PPU address EVERY SINGLE TILE.
;; STA $2007 already increments the next save to the right...
;; and the INC ppu_dest lines don't even get the high bit so it can wrap normally! Strings have to rely on line breaks for that!
;; so while I'm keeping those lines in so that any calls to re-setting the PPU destination remain accurate...
;; it does NOT need to waste time setting the address again and again and again.
;; this should massively speed up drawing!    
;; ...update: So it saves like maybe 2-3 scanlines, but I'm calling that a win still.
    

   ; Jumps here for control codes.  Start comparing to see which control code this actually is
   ;; JIGS - cleaning this up so people know what its doing... not to save space.
   ;; though it may just save space anyway...?
ComplexStringControlCode:
    CMP #$01
    BEQ ComplexString_DoubleLineBreak
    CMP #$02
    BNE :+
        JMP ComplexString_ItemName
  : CMP #$03
    BNE :+
        JMP ComplexString_ItemPrice  
  : CMP #$04
    BEQ ComplexString_PlayerGold
    CMP #$05
    BEQ ComplexString_SingleLineBreak
    CMP #$06
    BNE :+
        JMP ComplexString_MagicName
  : CMP #$07
    BNE :+
        JMP ComplexString_WeaponArmorName
  : CMP #$08
    BEQ ComplexString_Backspace
    CMP #$09
    BEQ ComplexString_SpaceString
    CMP #$0A
    BEQ ComplexString_Forward
    CMP #$0B
    BEQ ComplexString_DoTileABunch

  ;; 0A to 0F do nothing     
    CMP #$16 ; see if its exactly $16, and skip drawing if it is
    BNE :+    
        JMP ComplexString_GetNext
  : CMP #$14 ;; check if its equal to or over $14 ... if not, then it is either invalid (0A-0F) or a character stat code ($10-$13)
    BCS ComplexString_SingleLineBreak
    JMP ComplexString_CharacterStatCode
  
;; now the control code routines!  

ComplexString_Forward:            ;; Get the next byte, the number of tiles to skip...
    JSR ComplexString_GetNextByte ;; and skip that many tiles! So you can draw stuff 
    TAX                           ;; between words without drawing the words again.
  : INC ppu_dest
    DEX
    BNE :-
    JMP ComplexString_SetDest
    
ComplexString_DoTileABunch:    
    JSR ComplexString_GetNextByte ;; Amount of tiles to do
    TAX
    JSR ComplexString_GetNextByte ;; Tile to draw
  : JSR ComplexString_JustDraw
    DEX
    BNE :-    
    JMP ComplexString_GetNext
  
ComplexString_SingleLineBreak:
    LDX #$20         ;  X=20 for a single line break (control code $05)
    BNE :+
    
ComplexString_DoubleLineBreak:
    LDX #$40         ; Line break -- X=40 for a double line break (control code $01),

  : STX tmp          
    LDA ppu_dest     ; store X in tmp for future use.
    AND #$E0         ; Load dest PPU Addr, mask off the low bits (move to start of the row)
    ORA dest_x       ;  OR with the destination X coord (moving back to original start column)
    CLC
    ADC tmp          ; add the line break value (number of rows to inc by) to PPU Addr
    STA ppu_dest
    LDA ppu_dest+1
    ADC #0           ; catch any carry for the high byte
    STA ppu_dest+1
    JMP ComplexString_CheckMenuStall   ; continue processing text
    
ComplexString_SpaceString:    ;; prints spaces! Simple
    JSR ComplexString_GetNextByte
ComplexString_SpaceString_ManualEntry: 
    TAX
    LDA #$FF
  : JSR ComplexString_JustDraw
    DEX
    BNE :-
    JMP ComplexString_GetNext

ComplexString_PlayerGold:
    LDA #BANK_MENUS                        ; swap to the menu bank for the PrintGold routine
    JSR ComplexString_SaveTextPointer_Swap ; this is a substring we'll need to draw, so save 
    JSR PrintGold                          ;  PrintGold to temp buffer
    JSR ComplexString_CheckMenuStall       ;  recursively call this routine to draw temp buffer (do another frame if necessary)
    JMP ComplexString_RestoreTextPointer   ; then restore original string state and continue

ComplexString_ItemName:
    JSR ComplexString_GetNextByte        ;; get the item ID
    
ComplexString_ItemName_FromCharCode:    
    JSR DumbBottleThing                  ;; checks if the item = bottle, then flows into...
    ;JSR ComplexString_DrawItemPrep      ;; swaps to the Item name bank, saves the pointer
    LDA lut_ItemNames_Low, X    
    STA text_ptr                     
    LDA lut_ItemNames_High, X   
  : STA text_ptr+1                       ; finally write high byte of pointer
    JSR ComplexString_GetNext            ; recursively draw the substring
    JMP ComplexString_RestoreTextPointer ; then restore original string and continue

ComplexString_MagicName:
    JSR ComplexString_GetNextByte
ComplexString_MagicName_FromCharacterStatCode:    
    JSR ComplexString_DrawItemPrep
      DEX  
      LDA lut_MagicNames_Low, X   
      STA text_ptr                       
      LDA lut_MagicNames_High, X 
      JMP :-

ComplexString_WeaponArmorName:
    JSR ComplexString_GetNextByte
    JSR ComplexString_DrawItemPrep
      DEX                                  ; weapons and armour need to be shifted 1 to a 0 based ID
      LDA lut_EquipmentNames_Low, X   
      STA text_ptr                       
      LDA lut_EquipmentNames_High, X 
      JMP :-

ComplexString_ItemPrice:
    JSR ComplexString_GetNextByte          ;; get the item ID
    PHA
    LDA #BANK_MENUS
    JSR ComplexString_SaveTextPointer_Swap ; Save string info (item price is a substring)
    PLA                                    ; get back the item ID
    JSR PrintPrice                         ; print the price to temp string buffer
    JSR ComplexString_CheckMenuStall       ; recursivly draw it (waits a frame if necessary)
    JMP ComplexString_RestoreTextPointer   ; then restore original string state and continue

ComplexString_GetNextByte:         ;; support routine, just gets the next byte and incs the text pointer
    LDA (text_ptr), Y
    INC text_ptr
    BNE :+
      INC text_ptr+1
  : RTS
    
ComplexString_CharacterStatCode:
    ;;;; Control Codes $10-13
    ;;;;   These control codes indicate to draw a stat of a specific character
    ;;;;   ($10 is character 0, $11 is character 1, etc)
    ;;;; Which stat to draw is determined by the next byte in the string

    JSR ShiftLeft6
    STA char_index ; store index
    TAX            ; and put in X as well
    JSR ComplexString_GetNextByte

    CMP #$01
    BEQ ComplexString_CharCode_Class
    CMP #$02
    BEQ ComplexString_CharCode_AilmentIcon
    ;; if its still below $14, then its a stat or substat
    CMP #$40
    BCC ComplexString_CharCode_NumericalStat
    CMP #$58
    BCC ComplexString_CharCode_MagicName
    ;; if its still below $2B, draw the name of the spell they know!
    ;; otherwise, do the variable width name:
    
    CMP #$60
    BEQ ComplexString_CharCode_Name
    
ComplexString_CharCode_Name_VariableWidth:
    JSR DrawPlayerName
    JSR FixPlayerName
    BEQ :+ ; always branches
 
ComplexString_CharCode_Name:
    JSR DrawPlayerName
  : JSR ComplexString_SaveTextPointer    ; need to draw a substring, so save current string
    LDA #<(format_buf-7)                 ; set string source pointer to temp buffer
    STA text_ptr
    LDA #>(format_buf-7)  
    STA text_ptr+1
    JSR ComplexString_GetNext            ; recursively draw it
    JMP ComplexString_RestoreTextPointer ; then restore original string and continue
    
ComplexString_CharCode_MagicName:   ; $40 - $57 ... 18 spell IDs total
    ; carry is clear from the branch
    ADC char_index                  ; add char_index 
    SEC
    SBC #$40                        ; subtract #$40 to get it zero based
    TAX
    LDA ch_spells, X 
    BEQ :+                          ; if 0, skip ahead and draw nothing (no spell)
      JMP ComplexString_MagicName_FromCharacterStatCode
  : LDA #7
    JMP ComplexString_SpaceString_ManualEntry
 
 ;JMP ComplexString_CheckMenuStall ; jumps here when spell=0.  Simply do nothing and continue with string processing    

ComplexString_CharCode_Class:
    LDA ch_class, X      ; get character's class
    CLC                  ; add #$F0 (start of class names)
    ADC #ITEM_CLASSSTART ; draw it (yes I know, class names are not items, but they're stored with items)
    JMP ComplexString_ItemName_FromCharCode

ComplexString_CharCode_AilmentIcon:
    LDA ch_ailments, X    
    BEQ @Healthy
    LSR A
    BCC :+
    LDA #$E9  ; dead -- note, different tile than the battle version of this code uses
    BNE @DrawIcon
  : LSR A
    BCC :+    
    LDA #$ED  ; stone
    BNE @DrawIcon
  : LSR A
    BCC :+
    LDA #$EB  ; poison
    BNE @DrawIcon
  : LSR A  
    BCC @Healthy
    LDA #$EC  ; blind
    BNE @DrawIcon
   @Healthy: 
    LDA #$E8  ; healthy!
    
   @DrawIcon:
    JMP ComplexString_DrawAndResume

ComplexString_CharCode_NumericalStat:
    PHA                                    ;  temporarily put the code in X
    LDA #BANK_MENUS
    JSR ComplexString_SaveTextPointer_Swap ;  save string data (we'll be drawing a substring)
    PLA                                    ;  put the stat code back in A
    JSR PrintCharStat                      ;  print it to temp string buffer
    JSR ComplexString_CheckMenuStall       ; draw it to the screen
    ;; flow into restoring and resuming!
    
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Complex String save/restore [$E03E :: 0x3E04E]
;;
;;    Some format characters require a complex string to swap banks
;;  and start drawing a seperate string mid-job.  It calls this 'Save' routine
;;  before doing that, and then calls the 'restore' routine after it's done
;;
;;    Note that Restore does not RTS, but rather JMPs back to the text
;;  loop explicitly -- therefore you should JMP to it.. not JSR to it.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

ComplexString_RestoreTextPointer:
    LDA text_ptr_backup        ; restore text pointer and data bank
    STA text_ptr
    LDA text_ptr_backup+1
    STA text_ptr+1
    LDA text_ptr_backup+2
    STA cur_bank
    JSR SwapPRG_L              ; swap the data bank back in
    JMP ComplexString_GetNext  ;  and continue with text processing

DumbBottleThing:
    CMP #BOTTLE
    BEQ @ChangeBottleName
    CMP #LEWDS
    BNE ComplexString_DrawItemPrep

   @ChangeLewdsName:
    LDA #LEWDS_ALT
    BNE ComplexString_DrawItemPrep

   @ChangeBottleName:
    LDA #BOTTLE_ALT

ComplexString_DrawItemPrep: ;; support routine for item names
    TAX                     ;; backup item ID
    LDA #BANK_ITEMS

ComplexString_SaveTextPointer_Swap:
   ; STA cur_bank 
    JSR SwapPRG_L              ; swap to the bank set in A

ComplexString_SaveTextPointer:
    LDY text_ptr               ; back up the text pointer
    STY text_ptr_backup        ;  and the data bank
    LDY text_ptr+1             ;  to temporary RAM space
    STY text_ptr_backup+1
    LDY cur_bank               ; use Y, so as not to dirty A
    STY text_ptr_backup+2
    RTS

DrawPlayerName: ;; used by Dialogue strings as well
    LDX char_index 
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
    RTS

;; NOTE : This is not merged with the above for a reason!
;; Names having a fixed width is necessary for menus and such.

FixPlayerName: 
    LDX #7
   @FixNameLoop:
    LDA format_buf-7, X ;; JIGS - this goes backwards through the name, finding the $FFs at the end
    CMP #$FF
    BNE :+

   @ReplaceFF:          ;; then replaces with a 0, so a 4 letter name doesn't print 4 spaces after it.
    LDA #0              ;; you should still plan your dialogue for 7 letter names though!
    STA format_buf-7, X
  : DEX
    BNE @FixNameLoop      
    RTS


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;   Draw Box  [$E063 :: 0x3E073]
;;
;;    Draws a box of given size, to given coords.  NT changes only, no attribute changes
;;   The box CANNOT cross an NT boundary (ie:  this routine isn't used for the dialog box
;;   which often does cross NT boundaries)
;;
;;   Y remains unchanged
;;
;;   IN:   menustall = Nonzero if the box is to be drawn 1 row per frame (stall between rows)
;;                      or zero if box is to be drawn immediately with no stalling
;;         box_x,y   = Desired Coords of box
;;         box_wd,ht = Desired width/height of box (must be at least 3x3 tiles)
;;         cur_bank  = Bank number to swap to (only used if stalling between rows)
;;
;;   OUT:  dest_x,y  = X,Y coords of inner box body (ie:  where you start drawing text or whatever)
;;
;;   TMP:  tmp+10 and tmp+11 used
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

DrawBox_L: 
DrawBox:
    LDA box_x         ; copy given coords to output coords
    STA dest_x
    LDA box_y
    STA dest_y
    JSR CoordToNTAddr ; convert those coords to an NT address (placed in ppu_dest)
    LDA box_wd        ; Get width of box
    SEC
    SBC #$02          ; subtract 2 to get width of "innards" (minus left and right borders)
    STA tmp+10        ;  put this new width in temp ram
    LDA box_ht        ; Do same with box height
    SEC
    SBC #$02
    STA tmp+11        ;  put new height in temp ram

DrawBox_Preset:
    JSR DrawBoxRow_Top    ; Draw the top row of the box
@Loop:                    ; Loop to draw all inner rows
      JSR DrawBoxRow_Mid  ;   draw inner row
      DEC tmp+11          ;   decrement our adjusted height
      BNE @Loop           ;   loop until expires
    JSR DrawBoxRow_Bot    ; Draw bottom row

    LDA soft2000          ; reset some PPU info
    STA $2000
    LDA #0
    STA $2005             ; and scroll information
    STA $2005

    LDA dest_x        ; get dest X coord
    CLC
    ADC #$01          ; and increment it by 1  (an INC instruction would be more effective...)
    STA dest_x
    LDA dest_y        ; get dest Y coord
    CLC
    ADC #$02          ; and inc by 2
    STA dest_y        ;  dest_x and dest_y are now our output coords (where the game would want to start drawing text
                      ;  to be placed in this box

    RTS

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Draw middle row of a box (used by DrawBox)   [$E0A5 :: 0x3E0B5]
;;
;;   IN:  tmp+10   = width of innards (overall box width - 2)
;;        ppu_dest = the PPU address of the start of this row
;;
;;   OUT: ppu_dest = set to the PPU address of the start of the NEXT row
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


DrawBoxRow_Mid:
    JSR MenuCondStall  ; do the conditional stall
    LDA $2002          ; reset PPU toggle
    LDA ppu_dest+1
    STA $2006          ; Load up desired PPU address
    LDA ppu_dest
    STA $2006
    LDX tmp+10         ; Load adjusted width into X (for loop counter)
    LDA #$FA           ; FA = L border tile
    STA $2007          ;   draw left border

    LDA #$FF           ; FF = inner box body tile
@Loop:
      STA $2007        ;  draw box body tile
      DEX              ;    until X expires
      BNE @Loop

    LDA #$FB           ; FB = R border tile
    STA $2007          ;  draw right border

    LDA ppu_dest       ; Add #$20 to PPU address so that it points to the next row
    CLC
    ADC #$20
    STA ppu_dest
    LDA ppu_dest+1
    ADC #0             ; Add 0 to catch carry
    STA ppu_dest+1

    RTS

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Draw bottom row of a box (used by DrawBox)   [$E0D7 :: 0x3E0E7]
;;
;;   IN:  tmp+10   = width of innards (overall box width - 2)
;;        ppu_dest = the PPU address of the start of this row
;;
;;   ppu_dest is not adjusted for output like it is for other box row drawing routines
;;   since this is the bottom row, no rows will have to be drawn after this one, so it'd
;;   be pointless
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

DrawBoxRow_Bot:
    JSR MenuCondStall   ; Do the conditional stall
    LDA $2002           ; Reset PPU Toggle
    LDA ppu_dest+1      ;  and load up PPU Address
    STA $2006
    LDA ppu_dest
    STA $2006

    LDX tmp+10          ; put adjusted width in X (for loop counter)
    LDA #$FC            ;  FC = DL border tile
    STA $2007

    LDA #$FD            ;  FD = bottom border tile
@Loop:
      STA $2007         ;  Draw it
      DEX               ;   until X expires
      BNE @Loop

    LDA #$FE            ;  FE = DR border tile
    STA $2007

    RTS


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Draw top row of a box (used by DrawBox)   [$E0FC :: 0x3E10C]
;;
;;   IN:  tmp+10   = width of innards (overall box width - 2)
;;        ppu_dest = the PPU address of the start of this row
;;
;;   OUT: ppu_dest = set to the PPU address of the start of the NEXT row
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


DrawBoxRow_Top:
    JSR MenuCondStall   ; Do the conditional stall
    LDA $2002           ; reset PPU toggle
    LDA ppu_dest+1
    STA $2006           ; set PPU Address appropriately
    LDA ppu_dest
    STA $2006

    LDX tmp+10          ; load the adjusted width into X (our loop counter)
    LDA #$F7            ; F7 = UL border tile
    STA $2007           ;   draw UL border

    LDA #$F8            ; F8 = U border tile
@Loop:
      STA $2007         ;   draw U border
      DEX               ;     until X expires
      BNE @Loop

    LDA #$F9            ; F9 = UR border tile
    STA $2007           ;   draw it

    LDA ppu_dest        ; Add #$20 to our input PPU address so that it
    CLC                 ;  points to the next row
    ADC #$20
    STA ppu_dest
    LDA ppu_dest+1
    ADC #0              ; Add 0 to catch the carry
    STA ppu_dest+1

    RTS

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Menu Conditional Stall   [$E12E :: 0x3E13E]
;;
;;    This will conditionally stall (wait) a frame for some menu routines.
;;   For example, if a box is to draw more slowly (one row drawn per frame)
;;   This is important and should be done when you attempt to draw when the PPU is on
;;   because it ensures that drawing will occur in VBlank
;;
;;  IN:  menustall = the flag to indicate whether or not to stall (nonzero = stall)
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

MenuCondStall:
    LDA menustall          ; check stall flag
    BEQ @Exit              ; if zero, we're not to stall, so just exit

      LDA soft2000         ;  we're stalling... so reset the scroll
      STA $2000
      LDA #0
      STA $2005            ;  scroll inside menus is always 0
      STA $2005

      JSR CallMusicPlay    ;  Keep the music playing
      JSR WaitForVBlank_L  ; then wait a frame

@Exit:
    RTS



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Erase Box  [$E146 :: 0x3E156]
;;
;;     Same idea as DrawBox -- only instead of drawing a box, it erases one.
;;   erases bottom row first, and works it's way up.
;;
;;  IN:  box_x, box_y, box_wd, box_ht, menustall
;;  TMP: tmp+11 used
;;
;;   cur_bank must also be set appropriately, as this routine can call CallMusicPlay
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

EraseBox:
    LDA box_x          ; copy box X coord to dest_x
    STA dest_x
    LDA box_y          ; get box Y coord
    CLC
    ADC box_ht         ;  add the box height, and then subtract 1
    SEC
    SBC #$01           ;  and write that to dest_y
    STA dest_y         ;  this puts dest_y to the last row
    JSR CoordToNTAddr  ; fill ppu_dest appropriately
    LDA box_ht         ; get the box height
    STA tmp+11         ; and put it in temp RAM (will be down counter for loop)

  @RowLoop:
     LDA menustall      ; see if we need to stall the menu (draw one row per frame)
     BEQ @NoStall       ; if not, skip over this stalling code

       LDA soft2000         ; reset scroll
       STA $2000
       LDA #0
       STA $2005
       STA $2005
       JSR CallMusicPlay    ; call music play routine
       JSR WaitForVBlank_L  ; and wait for vblank

   @NoStall:
     LDA $2002          ; reset PPU toggle
     LDA ppu_dest+1     ; set the desired PPU address
     STA $2006
     LDA ppu_dest
     STA $2006

     LDX box_wd         ; get box width in X (downcounter for upcoming loop)
     LDA #0             ; zero A
   @ColLoop:
       STA $2007        ; draw tile 0 (blank tile)
       DEX              ; decrement X
       BNE @ColLoop     ; loop until X expires (box_wd iterations)

     LDA ppu_dest        ; subtract $20 from the PPU address (move it one row up)
     SEC
     SBC #$20
     STA ppu_dest

     LDA ppu_dest+1      ; catch borrow
     SBC #0
     STA ppu_dest+1

     DEC tmp+11          ; decrement our row counter
     BNE @RowLoop        ;  if we still have rows to erase, keep looping


    LDA soft2000    ; otherwise, we're done.  Reset the scroll
    STA $2000
    LDA #0
    STA $2005
    STA $2005
    RTS             ; and exit!



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Airship Transition Animations  [$E1A8 :: 0x3E1B8]
;;
;;    AnimateAirshipLanding and AnimateAirshipTakeoff do just as the name
;;  suggests.  They draw the airship as it slowly takes off and lands.
;;
;;    These routines handle all the animation and sound effects that occur during the
;;  animation, but do not switch music tracks.
;;
;;    These routines will not exit until the animation is complete (they won't
;;  return for several frames)
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;
;;  AnimateAirshipTakeoff  [$E1A8 :: 0x3E1B8]
;;

AnimateAirshipTakeoff:
    LDA #$6F
    STA tmp+10           ; start Y coord for airship at $6F

    @Loop:
      JSR AirshipTransitionFrame   ; do a frame

      LDA framecounter
      AND #$01
      BNE @Loop          ; loop if low bit of framecounter is nonzero (move airship every other frame)

      DEC tmp+10         ; dec Y coord

      LDA tmp+10
      CMP #$4F
      BCS @Loop          ; loop until Y coord < $4F

    LDA #RIGHT           ; reset facing to face the player rightward
    STA facing

    RTS                  ; and exit

;;
;;  AnimateAirshipLanding  [$E1C2 :: 0x3E1D2]
;;

AnimateAirshipLanding:
    LDA #$4F
    STA tmp+10           ; start the Y coord for the airship at $4F

    @Loop:
      JSR AirshipTransitionFrame    ; do a frame

      LDA framecounter   ; check low bit of frame counter
      AND #$01
      BNE @Loop          ; and loop if nonzero (move airship once every 2 frames)

      INC tmp+10         ; increment Y coord (move airship closer to ground)

      LDA tmp+10
      CMP #$70
      BCC @Loop          ; loop until Y coord >= $70

    LDA #RIGHT
    STA facing         ; reset facing to face the player rightward

    LDA #0
    STA $400C          ; silence airship noise sound effect by setting volume to zero

    RTS                ; then exit

;;
;;  AirshipTransitionFrame  [$E1E1 :: 0x3E1F1]
;;    Does a frame during airship transitions (landing/taking off)
;;

AirshipTransitionFrame:
    JSR WaitForVBlank_L   ; wait for VBlank
    LDA #>oam             ; then do sprite DMA
    STA $4014

    JSR SetOWScroll_PPUOn     ; Set Scroll
    JSR ClearOAM              ; Clear OAM
    JSR CallMusicPlay_NoSwap  ; And call music play

    LDA #$70
    STA spr_x          ; draw the airship at x coord=$70 (same column that player is drawn)

    LDA tmp+10
    STA spr_y          ; get Y coord from our current animation (in tmp+10)

    LDA framecounter   ; use the frame counter to handle propeller animation
    AND #$08           ;  each image lasts for 8 frames
    STA tmp            ; store this as the table offset

    LDA #$38           ; tile additive = $38  (airship graphics)
    JSR Draw2x2Vehicle ; draw the 2x2 vehicle (airship)

    JSR DrawAirshipShadow       ; then draw the airship shadow
    JSR DrawOWObj_Ship          ;  and ship
    JSR DrawOWObj_BridgeCanal   ;  and bridge/canal

    LDA #%00111000
    STA $400C            ; set noise volume to 8

    LDA framecounter     ; use framecounter as frequency for noise
    STA $400E            ;   this will result in a the pitch starting high, then quickly sweeping
                         ;   downward, then becoming very high again.  Repeating that pattern very
                         ;   quickly (cycles through all pitches once every 16 frames)
                         ; also will switch between "shhhhh" long mode and "bzzzzz" short mode every
                         ;  128 frames

    LDA #0               ; write to last noise reg just to prime the length counter
    STA $400F            ;  ensures noise will be audible

    RTS                  ; frame is complete!  Exit

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Draw OW Sprites   [$E225 :: 0x3E235]
;;
;;    Draws all sprites for the overworld
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


DrawOWSprites:
    LDY vehicle            ; put current vehicle in Y
    CPY #$08
    BEQ @InAirship         ; check to see if the player is in the airship
    CPY #$04
    BEQ @InShip            ; or the ship
    CPY #$02
    BEQ @InCanoe           ; or the canoe
                           ; if none of those, they're on foot.

  @OnFoot:
    JSR DrawPlayerMapmanSprite  ; draw the mapman sprite
    JSR CheckToHideSprite

    ;JSR GetOWTile        ; get the CURRENT tile they're standing on; "inforest" is in A when it exits
    ;LDA inforest        ; check to see if we're in the forest
    ;BEQ @NotInForest     ; if not, skip ahead

   ;   LDA sprindex       ; if we are in a forest... hide the bottom half of the player by
   ;   SEC                ;   getting the sprite index
   ;   SBC #$0C           ; subtract $C and put it in X (this will point it to the 
   ;   TAX                ;   2nd of the 4 8x8 sprites drawn -- DL player mapman sprite)

     ; LDA #$F4           ; new Y coord = $F4 (offscreen -- removes the sprite)
     ; STA oam+$00, X     ;  hide DL sprite
     ; STA oam+$08, X     ;  hide DR sprite
     
     ; LDX #4
     ; LDA oam_a, X
     ; ORA #$20
     ; STA oam_a, X
     ; LDA oam_a+8, X
     ; ORA #$20
     ; STA oam_a+8, X
   ;  JSR HideSpriteBottomHalf

  @NotInForest:
    LDA ow_flags         ; check airship visibility
    AND #AIRSHIP_VISIBLE
    BEQ @HideAirship     ; if not visible, skip ahead and don't draw the airship

    LDA airship_vis
    AND #$1F
    CMP #$1F             ; if visibility = $1F -- airship is fully visible
    BCS @ShowAirship     ; so skip ahead and draw it
                         ;  otherwise the airship is "flashing" because you just
                         ;  raised it with the floater.
    INC airship_vis      ; increment the visibility counter
    LSR A                ; shift bit 1 into C
    LSR A                ;  and only draw it if bit 1 is clear
    BCS @HideAirship     ;  effectively toggles visibility every 2 frames to make it flash

  @ShowAirship:
    JSR DrawOWObj_Airship
  @HideAirship:
    JSR DrawOWObj_Ship
    JMP DrawOWObj_BridgeCanal

  @InAirship:                    ; if in the airship, draw everything normally
    JSR DrawPlayerMapmanSprite   ;  except do NOT draw the airship
    JSR DrawOWObj_Ship
    JMP DrawOWObj_BridgeCanal

  @InShip:                       ; same deal if in ship -- don't draw the ship
    JSR DrawOWObj_BridgeCanal    ; but also... draw the bridge and canal OVER the mapman sprite
    LDY #$04                     ;   this makes it so the ship goes under the bridge rather than over
    JSR DrawPlayerMapmanSprite   ; reload Y with the vehicle (4=ship) before calling this
    JMP DrawOWObj_Airship

  @InCanoe:                      ; canoe is nothing special.. just draw all the sprites
    JSR DrawPlayerMapmanSprite
    JSR DrawOWObj_Ship
    JSR DrawOWObj_Airship
    JMP DrawOWObj_BridgeCanal

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Draw Player Mapman sprite  [$E281 :: 0x3E291]
;;
;;    Draws the mapman sprite for the player.  Handles animations
;;  and vehicle changes as well.
;;
;;  IN:  Y = current vehicle.  ('vehicle' var in RAM is not used by this routine -- this
;;                               is so standard maps can override it)
;;
;;    Note that this routine branches to support routines... so those support routines
;;  must be stored nearby this one.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


DrawPlayerMapmanSprite:
    LDA #$70
    STA spr_x              ; set X coord to $70 (7 tiles from left of screen)

    LDA lut_VehicleSprY, Y ; get proper Y coord from LUT (different vehicles have different Y coords)

    CPY #$08
    BNE @NotAirship      ; see if vehicle is airship.  If it is...

      STA spr_y          ; record Y coord
      LDA framecounter   ; use framecounter as animator (propellers always spinning)
      ASL A              ; double the frame counter to make animation quicker (each pic lasts 4 frames)
      JMP @SetFacing     ; jump ahead to facing code


  @NotAirship:           ; if not airship..
      STA spr_y          ; record Y
      LDA move_ctr_x     ; use X move counter as animator (second half of step is a different pic)
      BNE @SetFacing     ; if X counter is nonzero (moving left/right), use it, otherwise
      LDA move_ctr_y     ;   use Y coord instead

  @SetFacing:
    AND #$08             ; mask out bit 3 of animation source.  This determines which of the two
                         ;  pics to draw

    LDX facing                           ; put facing in X
    ORA lut_VehicleFacingSprTblOffset, X ; use it as index to get sprite table offset
    STA tmp                              ; store sprite table offset in tmp (low byte of spr tbl pointer)

    CPY #$01           ; Check vehicle to see if they're on foot
    BEQ DrawMMV_OnFoot

    CPY #$02           ; or in the canoe
    BEQ DrawMMV_Canoe

    CPY #$04           ; or in the ship
    BEQ DrawMMV_Ship

       ; if none of those, it's the airship!
    LDA #$38
    STA tmp+2               ; tile additive = $38 (airship graphics)
    JSR Draw2x2Vehicle_Set  ; draw the 2x2 vehicle
          
            ; then flow seamlessly into DrawAirshipShadow

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Draw Airship Shadow  [$E2B8 :: 0x3E2C8]
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

DrawAirshipShadow:
    LDA framecounter         ; get frame counter
    LSR A                    ; shift low bit into C
    BCC @Exit                ; if low bit clear, draw nothing (exit)
                             ;  this results in the shadow being drawn every other frame, which
                             ;  how it "flickers"
    LDA #$6F
    STA spr_y                ; Y coord = $6F
    LDA #$70
    STA spr_x                ; X coord = $70

    LDA #$10
    STA tmp+2                ; tile additive = $10 (airship shadow graphics)

    LDA #<lut_OWObjectSprTbl ; and get OW Object sprite table pointer
    STA tmp
    LDA #>lut_OWObjectSprTbl
    STA tmp+1

    JMP Draw2x2Sprite        ; then draw the 2x2 sprite and exit

  @Exit:
    RTS


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  DrawMMV_Ship    [$E2D5 :: 0x3E2E5]
;;
;;    Support routine for DrawPlayerMapmanSprite.  Draws the ship MapMan Vehicle (MMV)
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

DrawMMV_Ship:
    LDA #$20
    STA tmp+2               ; tile additive = $20 (ship graphics)
    JMP Draw2x2Vehicle_Set  ; draw the 2x2 vehicle

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  DrawMMV_Canoe    [$E2DC :: 0x3E2EC]
;;
;;    Support routine for DrawPlayerMapmanSprite.  Draws the canoe MapMan Vehicle (MMV)
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

DrawMMV_Canoe:
    LDA #$50          ; tile additive = $50 (canoe graphics)
             ; flows seamlessly into Draw2x2Vehicle


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Draw 2x2 Vehicle  [$E2DE :: 0x3E2EE]
;;
;;  IN:  tmp         = sprite table pointer offset
;;       spr_x,spr_y = sprite coords
;;       A           = tile additive (Draw2x2Vehicle only)
;;       tmp+2       = tile additive (Draw2x2Vehicle_Set only)
;;
;;    The tile additive should be one of the following to draw the desired vehicle:
;;   canoe   = $50
;;   ship    = $20
;;   airship = $38
;;
;;    The two entry points just look for the tile additive in different places.  Other
;;  than that, they're the same
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

Draw2x2Vehicle:
    STA tmp+2                 ; store tile additive (in A) to tmp+2
                              ;  then proceed to 'Set' version of routine

Draw2x2Vehicle_Set:
    LDA tmp                   ; add low byte of sprite table
    CLC                       ; to our offset
    ADC #<lut_VehicleSprTbl
    STA tmp                   ; and store as low byte of our pointer

    LDA #>lut_VehicleSprTbl   ; then inclue any carry in the high byte of our pointer
    ADC #0
    STA tmp+1

    JMP Draw2x2Sprite         ; draw the 2x2 sprite, then exit


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  DrawMMV_OnFoot  [$E2F0 :: 0x3E300]
;;
;;    Support routine for DrawPlayerMapmanSprite.  Draws the player
;;  'on foot' MapMan Vehicle (MMV) at given coords (ie: no vehicle)
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


DrawMMV_OnFoot:
    LDA #0
    STA tmp+2                      ; zero the tile additive

    LDA #<lut_PlayerMapmanSprTbl   ; add the offset to the
    CLC                            ;  address of the sprite table (facing/animation changes)
    ADC tmp
    STA tmp                        ; and store in low byte of pointer

    LDA #>lut_PlayerMapmanSprTbl   ; include carry in high byte of pointer
    ADC #0
    STA tmp+1                      ; then draw it and exit

       ; no JMP or RTS -- flows seamlessly into Draw2x2Sprite


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Draw 2x2 sprite  [$E301 :: 0x3E311]
;;
;;    Draws a given 2x2 tile sprite at given X,Y coords
;;
;;  IN:  spr_x,spr_y = desired X,Y coords of sprite (upper left corner)
;;       (tmp)       = pointer to sprite data table (see below)
;;       tmp+2       = tile addition
;;
;;    The given sprite data is drawn into oam starting on the next sprite indicated
;;  by 'sprindex'.  Afterwards, 'sprindex' is incremented by 16 (4 sprites) so the
;;  next sprite will be drawn after this one.
;;
;;    (tmp) must point to an 8-byte buffer containing tile and attribute information
;;  for each of the tiles that make up this 2x2 sprite.  This buffer must be in the following
;;  format:
;;
;;    byte 0 = tile number for UL sprite
;;    byte 1 = attribute byte for UL sprite
;;    byte 2 = tile number for DL
;;    byte 3 = attribute for DL
;;    bytes 4,5 = same for UR sprite
;;    bytes 6,7 = same for DR sprite
;;
;;  note that it goes UL,DL,UR,DR instead of UL,UR,DL,DR like you may expect
;;
;;  tmp+2 is added to every tile number so you can offset the tiles by a given amount.
;;    this allows the same buffer to be used for multiple sprites that have different
;;    tiles, but the same attribute info (like standard map objects, for example)
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

Draw2x2Sprite:
    LDY #0           ; zero Y (will be our index to the given buffer
    LDX sprindex     ; get the sprite index in X

    LDA spr_y        ; load up desired Y coord
    STA oam+$0, X    ;  set UL and UR sprite Y coords
    STA oam+$8, X
    CLC
    ADC #$08         ; add 8 to Y coord
    STA oam+$4, X    ;  set DL and DR Y coords
    STA oam+$C, X

    LDA spr_x        ; load up X coord
    STA oam+$3, X    ;  set UL and DL X coords
    STA oam+$7, X
    CLC
    ADC #$08         ; add 8
    STA oam+$B, X    ;  and set UR and DR X coords
    STA oam+$F, X

    LDA (tmp), Y     ; get UL tile from the buffer
    INY              ;  inc our buffer index
    CLC
    ADC tmp+2        ; add the tile offset to the tile ID
    STA oam+$1, X    ; write it to oam
    LDA (tmp), Y     ; get UL attribute byte from buffer
    INY              ;  inc buffer index
    STA oam+$2, X    ; write to oam

    LDA (tmp), Y     ; repeat this process again.. but for the DL sprite
    INY
    CLC
    ADC tmp+2
    STA oam+$5, X
    LDA (tmp), Y
    INY
    STA oam+$6, X

    LDA (tmp), Y     ; and again for the UR sprite
    INY
    CLC
    ADC tmp+2
    STA oam+$9, X
    LDA (tmp), Y
    INY
    STA oam+$A, X

    LDA (tmp), Y     ; and lastly for the DR sprite
    INY
    CLC
    ADC tmp+2
    STA oam+$D, X
    LDA (tmp), Y
    STA oam+$E, X

    LDA sprindex     ; now that all 4 sprites have been fully loaded
    CLC              ;  increment the sprite index by 16 (4 sprites)
    ADC #16
    STA sprindex
    RTS              ; and exit!

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Vehicle sprite Y coord LUT  [$E36A :: 0x3E37A]
;;
;;     Many of these bytes are unused/padding.

lut_VehicleSprY:
  .BYTE     $6C
  .BYTE $6C               ; on foot
  .BYTE $6F,$6F           ; canoe
  .BYTE $6F,$6F,$6F,$6F   ; ship
  .BYTE $4F               ; airship
    ;    ^^  used column


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Draw Overworld Object routines  [$E373 :: 0x3E383]
;;
;;    Each of these routines draws a certain overworld object
;;  at its current coords.  There are three distinct routines, one for the
;;  ship, one for the airship, and one for both the bridge and canal.
;;
;;    Note that the ship/airship are for when those items are not acting
;;  as the current vehicle (ie:  it's the docked ship, and the landed airship --
;;  when the vehicle is not in use).
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

 ;;
 ;;  Ship
 ;;

DrawOWObj_Ship:
    LDA ow_flags            ; get ship visibility flag
    AND #SHIP_VISIBLE
    BEQ DrawOWObj_Exit      ; if zero, ship isn't available yet -- so don't draw it

    LDX ship_x              ; get x coord in X
    LDY ship_y              ; get y coord in Y
    JSR ConvertOWToSprite   ; convert those coords to sprite coords
    BCS DrawOWObj_Exit      ; if sprite out of bounds, don't draw it

    LDA #0
    STA tmp                 ; no additional offset to sprite table
    LDA #$20                ; tile additive of $20 (ship graphics)
    JMP Draw2x2Vehicle      ; draw the vehicle, and exit

 ;;
 ;;  Airship
 ;;

DrawOWObj_Airship:
    LDA ow_flags            ; get airship visibility flag
    AND #AIRSHIP_VISIBLE
    BEQ DrawOWObj_Exit      ; if zero, airship isn't available yet -- so don't draw it

    LDX airship_x           ; get x coord in X
    LDY airship_y           ; and y coord in Y
    JSR ConvertOWToSprite   ; convert those coords to sprite coords
    BCS DrawOWObj_Exit      ; if sprite out of bounds, don't draw it

    LDA #0
    STA tmp                 ; no additional offset to sprite table
    LDA #$38                ; tile additive of $38 (airship graphics)
    JMP Draw2x2Vehicle      ; draw the vehicle, and exit

 ;;
 ;;  a common exit shared by these routines
 ;;

DrawOWObj_Exit:
    RTS

 ;;
 ;;  Bridge and Canal
 ;;

DrawOWObj_BridgeCanal:
    LDA ow_flags            ; check if bridge is visible
    AND #BRIDGE_VISIBLE
    BEQ @Canal              ; if not.. skip it and proceed to canal

    LDX bridge_x            ; get and convert X,Y coords
    LDY bridge_y
    JSR ConvertOWToSprite
    BCS @Canal              ; if out of bounds, skip to canal

    LDA #$14                ; otherwise, draw with table offset $08 (bridge)
    JSR @Draw               ;  then proceed to canal

  @Canal:
    LDA ow_flags
    AND #CANAL_VISIBLE      ; if not visible
    BEQ DrawOWObj_Exit      ;    exit

    LDX canal_x
    LDY canal_y
    JSR ConvertOWToSprite
    BCS DrawOWObj_Exit      ; if coords are out of bounds, exit

    LDA #$18                ; otherwise, draw iwth table offset $10 (canal)

    
  @Draw:
    STA tmp+2
    ;CLC
    ;ADC #<lut_OWObjectSprTbl
    LDA #<lut_OWObjectSprTbl  ; add table offset (in A) to low byte of table
    STA tmp                   ; and store in our pointer
    LDA #>lut_OWObjectSprTbl
    ;ADC #0
    STA tmp+1                 ; include carry in high byte of pointer

   ; LDA #$10                  ; set the tile additive to $10
   ; STA tmp+2

    JMP Draw2x2Sprite         ; draw the sprite, and return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Convert Overworld Coord to Sprite Coord   [$E3DF :: 0x3E3EF]
;;
;;     Converts X/Y overworld map coords to X/Y sprite coords based
;;  on the current scroll.
;;
;;  IN:   X, Y
;;
;;  OUT:  spr_x, spr_y
;;                   C = set if sprite is not visible on current screen
;;                       clear if visible
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

ConvertOWToSprite:
    TYA                 ; put the Y coord in A
    SEC
    SBC ow_scroll_y     ; subtract the current ow scroll
    CMP #$10            ; see if result is >= $10
    BCS @OutOfBounds    ; if it is -- out of bounds

   ; ASL A               ; multiply that tile by 16
   ; ASL A               ;   to get the pixel (16 pixels per tile)
   ; ASL A
   ; ASL A
   JSR ShiftLeft4

    CLC                 ; CLEAR carry (subtract an additional 1 in the folling SBC)
                        ;   this is because NES sprites are drawn 1 scanline below their specified
                        ;   Y coord.

    SBC move_ctr_y      ; then subtract the Y move counter (fine Y scroll)
    CMP #$EC            ; if >= $EF, out of bounds
    BCS @OutOfBounds

    STA spr_y           ; otherwise, Y coord is in bounds.  record it
                        ;   then do the same for X...

    TXA                 ; put X coord in A
    SEC
    SBC ow_scroll_x     ; subtract OW scroll
    CMP #$10            ; out of bounds if >= $10
    BCS @OutOfBounds

   ; ASL A               ; multiply by 16
   ; ASL A
   ; ASL A
   ; ASL A
   JSR ShiftLeft4

    SEC                 ; SEC (no additional 1 this time)
    SBC move_ctr_x      ; subtract fine X scroll
    BCC @OutOfBounds    ; if that moved the sprite off the left of the screen, out of bounds

    CMP #$F8            ; otherwise, if >= $F8
    BCS @OutOfBounds    ;  out of bounds

    STA spr_x           ; otherwise.. in bounds!  record X coord
    CLC                 ; CLC to indicate in bounds
    RTS                 ; and exit

  @OutOfBounds:
    SEC                 ; SEC to indicate out of bounds
    RTS                 ; and exit


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  DrawSMSprites  [$E40F :: 0x3E41F]
;;
;;    Draws all sprites for standard maps, and updates/animates
;;  map objects (townspeople, etc).
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; JIGS - reworked this.
;; mapspritehide holds all the information on how to hide the player's sprite
;; $0x = no hiding... yet
;; $80 = hide bottom half by changing background priority
;; $40 = hide entire sprite by changing background priority
;; $20 = hide entire sprite by moving it off-screen


DrawSMSprites:
    LDY #1
    JSR DrawPlayerMapmanSprite    ; draw the player mapman sprite (on foot -- no ship/airship/etc)
    JSR CheckToHideSprite
     
;  : JSR GetSMTilePropNow          ; get the tile properties for the tile they're on
;    CMP #TP_SPEC_DEEPWATER
;    BNE :+
;      JSR HideSpriteBottomHalf
;      BNE :+           ; always branches
      
;  : LDA tileset_prop, X           ; reload first byte
;    AND #TP_HIDESPRITE            ; check the hide sprite switch
;    BEQ :+
;      LDX #0                      ; set X to sprite index 0 (first sprite, always player)
;    @MaskPlayer:                  
;      JSR HideSpriteThing
;      INX                         ; inc X by 4 to check next sprite
;      INX
;      INX
;      INX 
;      CPX #$10                    ; if X is not yet $10 (4+4+4+4), keep looping
;      BNE @MaskPlayer
   JMP UpdateAndDrawMapObjects   ; then update and draw all map objects, and exit!

CheckToHideSprite:   
    LDA mapspritehide
    ASL A
    BCC :+
      
     @Forest_Water:
      JSR HideSpriteBottomHalf
      BNE @Done
      
  : ASL A 
    BCC :+
    
     @BackgroundPriority:
      LDX #0                      ; set X to sprite index 0 (first sprite, always player)
     @MaskPlayer:                  
      JSR HideSpriteThing
      INX                         ; inc X by 4 to check next sprite
      INX
      INX
      INX 
      CPX #$10                    ; if X is not yet $10 (4+4+4+4), keep looping
      BNE @MaskPlayer
      BEQ @Done
      
  : ASL A
    BCC @Done
     
     @Offscreen:
      LDX #0
      LDA #$F4           ; new Y coord = $F4 (offscreen -- removes the sprite)
      STA oam+$00, X   
      STA oam+$04, X
      STA oam+$08, X   
      STA oam+$0C, X    
 
     @Done:  
      RTS
   
HideSpriteBottomHalf:
    LDX #$04
    JSR HideSpriteThing
    LDX #$0C
  
HideSpriteThing:
    LDA oam_a, X                ; load up the attribyte byte for that sprite
    ORA #$20                    ; add in the "background priority" bit
    STA oam_a, X                ; save it
    RTS
  
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Vehicle facing table offset  [$E417 :: 0x3E427]
;;
;;    The value in this table gets added to the pointer of the sprite table to use
;; when drawing mapman/vehicle sprites (the tables themselves are stored just below).
;;
;;   In short... a different table is used to draw a sprite based on which direction
;; it's facing.  This table indicates which of those tables to use.
;;
;;   right = +$00
;;   left  = +$10
;;   down  = +$30
;;   up    = +$20
;;
;;   'facing' is used as the index for this table.  Normally, this is only either
;;  1, 2, 4, or 8... but could be anywhere between 0-F if the player is pressing
;;  multiple directions at once.  In calculations for determining facing, low bits
;;  are given priority (ie:  if you're pressing up+right, you'll move right because
;;  right is bit 0).  To have the images match this priority, this table has been
;;  built appropriately

lut_VehicleFacingSprTblOffset:
  .BYTE $00,$00,$10,$00,$30,$00,$10,$00,$20,$00,$10,$00,$30,$00,$10,$00
 ;       R   R   L   R   D   R   L   R   U   R   L   R   D   R   L   R   ; direction used
 ;       -   r   l   rl  d   rd  ld rld  u   ru  lu rlu  du rdu ldu rldu ; directions being pressed (lowest bits take priority)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Player mapman sprite tables [$E427 :: 0x3E437]
;;
;;     Sprite tables for use with Draw2x2Sprite.  Used for drawing
;;  the player mapman.  There are eight 8-byte tables, 2 tables for
;;  each direction (1 for each frame of animation).


lut_PlayerMapmanSprTbl:
  .BYTE $09,$40, $0B,$41, $08,$40, $0A,$41   ; facing right, frame 0
  .BYTE $0D,$40, $0F,$41, $0C,$40, $0E,$41   ; facing right, frame 1
  .BYTE $08,$00, $0A,$01, $09,$00, $0B,$01   ; facing left,  frame 0
  .BYTE $0C,$00, $0E,$01, $0D,$00, $0F,$01   ; facing left,  frame 1
  .BYTE $04,$00, $06,$01, $05,$00, $07,$01   ; facing up,    frame 0
  .BYTE $04,$00, $07,$41, $05,$00, $06,$41   ; facing up,    frame 1
  .BYTE $00,$00, $02,$01, $01,$00, $03,$01   ; facing down,  frame 0
  .BYTE $00,$00, $03,$41, $01,$00, $02,$41   ; facing down,  frame 1

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Vehicle mapman sprite tables  [$E467 :: 0x3E477]
;;
;;    Same as above, but for OW vehicles (canoe, ship, airship)
;;
;;    Tile IDs in this table are not usable as-is.  For proper vehicle
;;  tiles to be drawn, the following additives must be used:
;;
;;   canoe   = $50
;;   ship    = $20
;;   airship = $38


lut_VehicleSprTbl:
  .BYTE $11,$42, $13,$42, $10,$42, $12,$42   ; R 0
  .BYTE $15,$42, $17,$42, $14,$42, $16,$42   ; R 1
  .BYTE $10,$02, $12,$02, $11,$02, $13,$02   ; L 0
  .BYTE $14,$02, $16,$02, $15,$02, $17,$02   ; L 1
  .BYTE $00,$02, $02,$02, $01,$02, $03,$02   ; U 0
  .BYTE $04,$02, $06,$02, $05,$02, $07,$02   ; U 1
  .BYTE $08,$02, $0A,$02, $09,$02, $0B,$02   ; D 0
  .BYTE $0C,$02, $0E,$02, $0D,$02, $0F,$02   ; D 1


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  OW object sprite table  [$E4A7 :: 0x3E4B7]
;;
;;    Same, but for the misc overworld objects (airship shadow, bridge, and canal)
;;  Only one 8-byte table per object, since facing isn't applicable, and there's
;;  no animation involved
;;
;;    Really.. the game SHOULD'VE just used 1 8-byte table... since all 3 tables
;;  are identical except for the tile ID used (but that can be adjusted with the
;;  tile additive -- I mean that's exactly what it's for, right?)
;;
;;    Also, somewhat stupidly, the tile IDs in these tables aren't even correct.
;;  to get the right graphics you have to use a tile additive of $10

lut_OWObjectSprTbl:
  .BYTE $00,$03, $02,$03, $01,$03, $03,$03     ; airship shadow
 ; .BYTE $04,$03, $06,$03, $05,$03, $07,$03     ; bridge
 ; .BYTE $08,$03, $0A,$03, $09,$03, $0B,$03     ; canal
 ;
 ; .BYTE $00,$00, $00,$00, $00,$00, $00,$00     ; unused


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  UpdateAndDrawMapObjects  [$E4C7 :: 0x3E4D7]
;;
;;    Updates map objects (so townspeople, etc walk around the map), and draws
;;  all onscreen objects.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

UpdateAndDrawMapObjects:
    LDA framecounter    ; use low bit of frame counter to alternate between drawing
    LSR A               ; forwards and backwards.  This performs a form of OAM cycling which
    BCS @DoBackward     ; causes sprites to flicker rather than completely disappear if too many
                        ; are on a scanline
  @DoForeward:
    LDX #0                ; forward loop draws objects starting with the first, and counting up
   @ForewardLoop:
     LDA mapobj_id, X              ; get the object ID
     BEQ :+                        ; if it'd ID is nonzero, animate and draw it --
       JSR AnimateAndDrawMapObject ;   don't draw an object that doesn't exist
:    TXA                           ; add $10 to the object index 
     CLC
     ADC #$10
     TAX
     CMP #$F0                      ; and loop until all 15 objects drawn
     BCC @ForewardLoop
    JMP MapObjectMove              ; then move a map object and exit

  @DoBackward:            ; backward loop is exactly the same, only it starts at the last object
    LDX #$E0              ;   first, and counts down
   @BackwardLoop:
     LDA mapobj_id, X
     BEQ :+
       JSR AnimateAndDrawMapObject
:    TXA
     SEC
     SBC #$10
     TAX
     BCS @BackwardLoop    ; loop until index wraps
    JMP MapObjectMove     ; then move a map object and exit


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Draw Map Objects No Update  [$E4F6 :: 0x3E506]
;;
;;    A shortened version of above UpdateAndDrawMapObjects routine.  It
;;  draws all map objects, but without OAM cycling, and does not update
;;  or animate any of them.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


DrawMapObjectsNoUpdate:
    LDX #0
  @Loop:                   ; loop through all 15 objects
     LDA mapobj_id, X
     BEQ :+                ; check their ID, and only draw them if they actually exist
       JSR DrawMapObject   ;  (id is nonzero)
:    TXA
     CLC
     ADC #$10              ; add $10 to index to point to next object
     TAX
     CMP #$F0              ; loop until all 15 objects checked
     BCC @Loop
    RTS                    ; then exit

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Map Object Move  [$E50A :: 0x3E51A]
;;
;;    Called every frame to update standard map objects (though objects
;;  are updated serially, with only one object updated per frame).  Objects
;;  simply count down a 'wait' timer, then pick a random direction and try
;;  to walk in that direction, provided the move is legal.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

MapObjectMove:
    LDA cur_mapobj           ; increment the current map object
    CLC                      ;  only one object is updated per frame
    ADC #$10
    AND #$F0
    CMP #$F0                 ; wrap after 15 objects (don't do the 16th object -- there isn't a 16th)
    BCC :+
      LDA #0
:   STA cur_mapobj

    TAX                      ; put the index of the object to update in X
    LDA mapobj_id, X         ; get this object's ID
    BEQ @Exit                ; if the ID is zero (object doesn't exist), do nothing

    LDA mapobj_flgs, X       ; check the object's flags to see if they're stationary
    AND #$40                 ;  -- stationary bit
    ORA mapobj_face, X       ; also check the face var ?to see if they're already moving?  not sure exactly
    BEQ :+                   ; if not stationary, and face=0, then continue on, otherwise exit

       @Exit:
         RTS

:   ;LDA inroom               ; check to see if the player is in a room
    ;AND #1                   ;  specifically, normal rooms (but not locked rooms)
    ;BEQ @NotInRoom           ; if player is in a room....
    ;  LDA mapobj_flgs, X     ; ... check this object's inroom flag
    ;  BPL @Exit              ; if player in room and object out of room, do not update object
                             ; not sure what the point of this is -- however it WILL prevent you from
                             ; being able to shove an object out of the way if they're blocking the
                             ; exit door from the outside (this happened to be before)
                             ; while I wouldn't say this is BUGGED -- I would recommend removing it
                             ; for a general improvement hack

  @NotInRoom:
    LDA mapobj_movectr, X    ; check the object's movement down counter
    BEQ @TakeStep            ; if it's zero (expired), have the object take another step
      ;SEC
      ;SBC #1                 ;  otherwise simply decrement it by 1, and exit
      ;STA mapobj_movectr, X  ;  (what did NASIR have against DEC?)
      DEC mapobj_movectr, X
      RTS


  ;; Reaches here if the object is to attempt to take another step

  @TakeStep:
    LDA mapobj_physX, X      ; to take a new step, copy the object's physical coords
    STA tmp+4                ;  to temp ram
    LDA mapobj_physY, X
    STA tmp+5

    LDA framecounter         ; use the frame counter, and the runtime direcitonal seed
    ADC npcdir_seed          ; to produce a pseudo-random number.  This number will determine
    STA npcdir_seed          ; which direction to move.  Update the seed, as well.
    AND #3                   ; mask with 3 to get one of four values (directions to move)

    CMP #2                   ; now check which direction to go, and fork appropriately
    BCC @Step_LorR           ; if < 2 (0 or 1), move left or right
    BEQ @Step_Up             ; if == 2, move up
                             ; otherwise (3), move down



  @Step_Down:
    LDA tmp+5                ; get Y pos
    CLC
    ADC #1                   ; add 1 to it, and wrap it around the edge of the map
    AND #$3F
    STA tmp+5                ; then write it back

    JSR CanMapObjMove        ; test to see if moving to this new pos is legal
    BCS @CantStep            ; if check failed (step illegal), can't step here, so just exit

    LDA tmp+5                ; otherwise step is legal
    STA mapobj_physY, X      ;  so copy tested Y coord to the actual physical Y coord of this object
    LDA #1
    STA mapobj_spdY, X       ; set their Y movement speed to move +1 (down)
    LDA #8
    STA mapobj_face, X       ; set their face (why?)

    LDA mapobj_id, X         ; finally, check the object ID.  Bats need to be drawn differently
    CMP #OBJID_SKYWAR_FIRST  ; so check to see if the object is one of the sky warriors (bats)
    BCC :+                   ;  or just a normal bat.  If it is, force it to face leftward.
    CMP #OBJID_SKYWAR_LAST+1 ; The reason for this is because when normal objects move up/down
    BCC @ForceFaceLeft       ; the top half doesn't animate, and the bottom half just mirrors itself
    CMP #OBJID_BAT           ; This would look really funky with the bat graphic (would look like garbage)
    BEQ @ForceFaceLeft       ; So we have them face to the left, in order to have fresh graphics for each frame.

:     LDA #<lut_2x2MapObj_Down   ; reaches here if not a bat.  Just load up the pointer
      STA mapobj_tsaptr, X       ;  to the downward 2x2 tsa table
      LDA #>lut_2x2MapObj_Down
      JMP @StepDone              ; then jump ahead to final cleanup stuff

 ;; jumps here if the attempted move was illegal

  @CantStep:
    RTS                      ; simply exit.  No muss, no fuss



  @Step_Up:                  ; stepping upward is the same process as stepping down
    LDA tmp+5                ;  except for a few differences
    SEC
    SBC #1                   ; subtract 1 rather than add 1 (to move up instead of down)
    AND #$3F
    STA tmp+5

    JSR CanMapObjMove
    BCS @CantStep

    LDA tmp+5
    STA mapobj_physY, X
    STA mapobj_gfxY, X       ; update the graphic position immediately because it's a negative move
    LDA #-1
    STA mapobj_spdY, X
    LDA #$0F
    STA mapobj_ctrY, X       ; set the Y counter to max right away -- this has to do with how
    LDA #4                   ;  talking to objects is handled.  Because gfxY is changed immediately,
    STA mapobj_face, X       ;  leaving ctrY zero would cause the talking routine to mess up a bit
                             ; see CanTalkToMapObject for why

    LDA mapobj_id, X           ; do the same thing to check for bat objects and force them to face
    CMP #OBJID_SKYWAR_FIRST    ;  leftward
    BCC :+
    CMP #OBJID_SKYWAR_LAST+1
    BCC @ForceFaceLeft
    CMP #OBJID_BAT
    BEQ @ForceFaceLeft

:     LDA #<lut_2x2MapObj_Up
      STA mapobj_tsaptr, X
      LDA #>lut_2x2MapObj_Up
      JMP @StepDone


  ;; jumps here if trying to move left or right

  @Step_LorR:
    CMP #0
    BEQ @Step_Right          ; fork to left or right if random value was 0 or 1


  @Step_Left:
    LDA tmp+4             ; same process as moving up/down, but we work with X coord/speeds/etc
    SEC
    SBC #1
    AND #$3F
    STA tmp+4

    JSR CanMapObjMove
    BCS @CantStep

    LDA tmp+4
    STA mapobj_gfxX, X    ; update graphic position immediately (again, seems unnecessary)
    STA mapobj_physX, X
    LDA #-1
    STA mapobj_spdX, X
    LDA #$0F
    STA mapobj_ctrX, X    ; set counter to max for same reason we did when moving up (negative move)
    LDA #2                ;  no need to check for bat graphics here, because left/right movement
    STA mapobj_face, X    ;  will draw bat graphics just fine

  @ForceFaceLeft:                  ; @ForceFaceLeft is jumped to for bat graphics (see above)
      LDA #<lut_2x2MapObj_Left
      STA mapobj_tsaptr, X
      LDA #>lut_2x2MapObj_Left
      JMP @StepDone




  @Step_Right:              ; moving right... more of the same
    LDA tmp+4
    CLC
    ADC #1
    AND #$3F
    STA tmp+4

    JSR CanMapObjMove
    BCS @CantStep

    LDA tmp+4
    STA mapobj_physX, X
    LDA #1
    STA mapobj_spdX, X
    LDA #1
    STA mapobj_face, X

    LDA #<lut_2x2MapObj_Right
    STA mapobj_tsaptr, X
    LDA #>lut_2x2MapObj_Right


  @StepDone:                ; moving all directions meet up here for final cleanup
    STA mapobj_tsaptr+1, X  ; record high byte of desired TSA pointer
    LDA framecounter        ; use the framecounter directly as a pRNG
    AND #$07
    STA mapobj_movectr, X   ; to set the delay until the next movement
    RTS                     ; then exit

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  CanMapObjMove  [$E630 :: 0x3E640]
;;
;;    Checks to see if a map object can step on a given tile.  Does not actually
;;  perform the move, it only checks to see if the move is legal.
;;
;;  IN:  tmp+4 = X coord to check (where object is attempting to move to)
;;       tmp+5 = Y coord to check
;;           X = index of the object we're checking for
;;
;;  OUT:     C = clear if move legal, set if move illegal
;;
;;    X remains totally unchanged by this routine.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

CanMapObjMove:             ; first thing to check is the map
    LDA tmp+5              ; get target Y coord
    LSR A
    LSR A                  ; right shift 2 to get high byte of *64
    ORA #>mapdata          ; OR with high byte of map buffer
    STA tmp+1              ; record this as high byte of pointer
    LDA tmp+5              ; reload Y coord
    ROR A
    ROR A
    ROR A
    AND #$C0               ; left shift by 6 and isolate high bits (Y * 64)
    ORA tmp+4              ; OR with desired X coord to get low byte of pointer
    STA tmp                ; record it
    LDY #0                 ; zero Y for indexing
    LDA (tmp), Y           ; get the tile on the map at the given coords

    ASL A                  ; double the tile number (2 bytes of properties per tile)
    TAY                    ; throw in Y for indexing
    LDA tileset_data, Y    ; fetch the first byte of properties for this tile
    AND #TP_TELE_MASK | TP_NOMOVE | TP_HIDESPRITE | TP_SPEC_DOOR | TP_SPEC_CLOSEROOM ; see if this tile is a teleport tile, or a tile you can't move on
    BEQ :+                 ; if either teleport or nomove, NPCs can't walk here, so 
   @AlsoBridge: 
      SEC                  ;  SEC to indicate failure (can't move)
      RTS                  ; and exit

:   LDA tileset_data, Y
    CMP #TP_SPEC_BRIDGEHORZ
    BEQ @AlsoBridge
    CMP #TP_SPEC_BRIDGEVERT
    BEQ @AlsoBridge
    ;; this should stop NPCs from walking on a bridge

    LDA sm_player_x        ; now check to see if they're trying to move on top of the player
    CMP tmp+4
    BNE :+
    LDA sm_player_y
    CMP tmp+5
    BNE :+
      SEC                  ; if they are, SEC for failure and exit
      RTS

:   LDY #0                 ; now we loop through all other objects to see if we're hitting them
  @Loop:                   ; X is index of test object, Y is index of loop object
    STY tmp                ; dump Y to tmp so we can compare to X
    CPX tmp                ; compare the indeces so that the object doesn't collide with itself
    BEQ :+
    LDA mapobj_id, Y       ; then check the loop object to make sure it exists (ID is nonzero)
    BEQ :+
    LDA tmp+4              ; then check X coords of each
    CMP mapobj_physX, Y
    BNE :+
    LDA tmp+5              ; and Y coords
    CMP mapobj_physY, Y
    BNE :+
      SEC                  ; reaches here if loop object is colliding with test object
      RTS                  ; SEC for failure and exit

:   TYA                    ; otherwise, add $10 to our loop index to test next object
    CLC
    ADC #$10
    TAY
    CMP #$F0               ; compare to $F0 to check all 15 objects
    BCC @Loop              ; loop until all 15 objects checked

    CLC                    ; once all objects checked out, if there wasn't a collision, CLC
    RTS                    ;  to indicate success, and exit!

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Animate And Draw Map Object  [$E688 :: 0x3E698]
;;
;;    Animates a map object's gradual motion between two tiles as it takes a step
;;  and draws the object to the screen (provided said object is visible onscreen)
;;
;;  IN:  X = index of desired object to animate/draw
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

AnimateAndDrawMapObject:
    LDA mapobj_pl, X       ; check to see if the object is being shoved by the player
    BNE @Move              ; if they are, keep them moving every frame.  Otherwise...

      LDA framecounter     ; use the low bit of the frame counter to move the object every
      AND #1               ; other frame (1 pixel every 2 frames, vs. 1 pixel per frame when shoved)
      BNE DrawMapObject    ; if an odd frame, skip over movement to the drawing stuff

  @Move:
    LDA mapobj_spdX, X       ; check X speed
    BEQ @Move_Y              ; if nonzero, move X, otherwise jump ahead to check Y speed

     CLC
     ADC mapobj_ctrX, X      ; add speed to move counter
     AND #$0F                ; mask low bits (16 pixels per tile)
     STA mapobj_ctrX, X      ; record new counter

     BNE DrawMapObject       ; if this did not complete the move, jump ahead to draw

      LDA #0                 ; full 16 pixels moved (step to next tile is completed)
      STA mapobj_spdX, X     ; zero the speed, and other things
      STA mapobj_face, X
      STA mapobj_pl, X

      LDA mapobj_physX, X    ; copy the physical X position to the graphic X position
      STA mapobj_gfxX, X

      JMP DrawMapObject      ; and jump ahead to the drawing code


  @Move_Y:                   ; if x speed was zero...
    LDA mapobj_spdY, X       ; check y speed
    BEQ DrawMapObject        ; if it, too, is zero, no movement to be done, so jump ahead to drawing

     CLC                     ; otherwise add Y speed to Y movement counter
     ADC mapobj_ctrY, X
     AND #$0F                ; wrap and record it
     STA mapobj_ctrY, X

     BNE DrawMapObject       ; if the move has been completed....

      LDA #$00               ; ... zero speed and stuff
      STA mapobj_spdY, X
      STA mapobj_face, X
      STA mapobj_pl, X

      LDA mapobj_physY, X    ; and copy physical pos to graphical pos
      STA mapobj_gfxY, X

   ; no JMP or RTS, code flows seamlessly into DrawMapObject


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Draw Map Object  [$E6D8 :: 0x3E6E8]
;;
;;    Draws a map object if it is visible.
;;
;;  IN:  X = index of object to draw
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

DrawMapObject:
    LDA inroom           ; check inroom flag
    AND #1               ;   specifically the low bit (in normal rooms, but not locked rooms)
    BEQ @OutRoom         

  @InRoom:
     LDA mapobj_flgs, X   ; check flags for this object
     BMI @DoDraw          ; if the sprite's inroom flag is set, draw it
    ; BPL @DontDraw        ;  otherwise, don't (hide it) -- always branches

  @OutRoom:
     LDA mapobj_flgs, X   ; same deal if the player is out of rooms -- check the object's flag
     BMI @DontDraw        ;  and don't draw if the object is in a room

  @DoDraw:
    LDA mapobj_ctrY, X    ; get this object's Y counter (fine Y scroll)
    CLC
    SBC move_ctr_y        ; offset it by the player's (screen's) fine Y scroll
    AND #$0F              ; wrap at 16
    STA tmp               ; and back up.  This is the fine Y pos of the sprite

    LDA mapobj_gfxY, X    ; get the graphic Y position (coarse Y scroll)
    SBC sm_scroll_y       ; offset by coarse screen scroll
    AND #$3F              ; wrap around edge of map.  This is now the coarse Y pos of the sprite
    CMP #$10              ; ensure coarse Y scroll puts the object on the actual screen
    BCS @DontDraw         ; if not, don't draw it

    JSR ShiftLeft4
    ;ASL A                 ; multiply coarse scroll by 16
    ;ASL A
    ;ASL A
    ;ASL A
    ORA tmp               ; and add fine scroll to get the actual Y pos
    CMP #$E8              ; if the actual Y pos is off the bottom of the screen
    BCS @DontDraw         ; don't draw (this seems redundant)

    SBC #2                ; subtract !3! (not 2 -- C is clear here) from the Y coord to move it
    STA spr_y             ; off center a bit for aesthetics.  Set this as spr_y for future drawing


    LDA mapobj_ctrX, X    ; do all the same business, but with X coords to get the X position
    SEC
    SBC move_ctr_x
    AND #$0F
    STA tmp

    LDA mapobj_gfxX, X
    SBC sm_scroll_x
    AND #$3F
    CMP #$10
    BCS @DontDraw

    JSR ShiftLeft4
    ;ASL A
    ;ASL A
    ;ASL A
    ;ASL A
    ORA tmp
    CMP #$F8              ; $F8 is off the right side of the screen, not E8 (screen is wider than it is tall)
    BCC @ObjectOnScreen

   @DontDraw:      ; it jumps to here is the object is off-screen or otherwise hidden
      SEC          ; I have no idea what the SEC is for -- success/failure indication comes to mind, but
      RTS          ;  there's no CLC on success, and C is never checked anyway.
                   ; exit if object is not to be drawn


   ; game reaches here if object is onscreen and visible (a sprite will definately be drawn)

  @ObjectOnScreen:
    STA spr_x            ; dump above calculated X coord into spr_x (spr_x,y are now properly calc'd)

    STX tmp+15           ; back up the object index so we can use X for something else
    LDA mapobj_pl, X     ; see if the player is talking to this object
    BMI @FacePlayer      ; if yes, jump ahead to face the player

    LDA mapobj_flgs, X   ; check the stationary flag
    AND #$40             ;  if the object is stationary, have them constantly walk in place
    BNE @WalkInPlace

    LDA mapobj_id, X          ; see if the object is a sky warrior (bat)
    CMP #OBJID_SKYWAR_FIRST
    BCC @NotSkyWar            ; if ID < first sky warrior, not sky warrior
    CMP #OBJID_SKYWAR_LAST+1
    BCS @NotSkyWar            ; if ID > last sky war (>= last+1), not sky war
                         ; otherwise, sky warriors, like bats, always walk in place
                         ;  so that they're always flapping their wings

  @WalkInPlace:
    LDA framecounter       ; for walking in place animations, use the frame counter to get
    LSR A                  ;  the image.  move bit 4 into relevent bit (toggles image every
    JMP @PerformNormalDraw ;  16 frames)

  @NotSkyWar:
    CMP #OBJID_BAT       ; if not a sky warrior, check to see if it's an ordinary bat
    BEQ @WalkInPlace     ;  if yes, have it walk in place as well
                         ;  otherwise, do the normal walking animation

    LDA mapobj_ctrX, X   ; for normal walking animation, use the movement counter
    ORA mapobj_ctrY, X   ;  (x OR y, whichever is active) to get the image.
    ASL A                ; move bit 2 into relevent bit (toggles image every 4 pixels moved)

  @PerformNormalDraw:
    AND #$08                 ; isolate relevent bit for animation (previously calculated)
    CLC
    ADC mapobj_tsaptr, X     ; add that to the sprite's TSA pointer to have them face
    STA tmp                  ;   the right way
    LDA mapobj_tsaptr+1, X
    ADC #0
    STA tmp+1                ; tmp now points to the desired 2x2 sprite contruction table

    TXA                      ; set the tile additive for the sprite to the object index+$10
    CLC                      ; (first $10 tiles are for the player's mapman graphic, all other
    ADC #$10                 ;  map objects have their own $10 tiles)
    STA tmp+2

    JSR Draw2x2Sprite        ; Draw it!
    LDX tmp+15               ; restore the object index to X (was changed by above JSR)
    RTS                      ; and exit!

     ; game branches here if the object is to be drawn facing the player
     ;   (if the player is talking to this object)

  @FacePlayer:
    AND #$7F                 ; (mapobj_pl,X is currently in A) -- clear the 'face player' bit
    STA mapobj_pl, X         ; and write it back.

    TXA                      ; set tile additive to $10+object index
    CLC
    ADC #$10
    STA tmp+2

    LDA facing               ; get direction player is facing
    LSR A
    BCS @FacePlayer_Left     ; if player is facing right, face this object left
    LSR A
    BCS @FacePlayer_Right    ; if player is facing left, face this right
    LSR A
    BCS @FacePlayer_Up       ; if down, up
                             ; otherwise up, so face down
  @FacePlayer_Down:
    LDA #<lut_2x2MapObj_Down     ; low byte of pointer in A
    LDX #>lut_2x2MapObj_Down     ; high byte in X
    BNE @FacePlayer_Draw         ;  always branches
  @FacePlayer_Up:                  ;   and do all the same for up/right/left
    LDA #<lut_2x2MapObj_Up
    LDX #>lut_2x2MapObj_Up
    BNE @FacePlayer_Draw
  @FacePlayer_Right:
    LDA #<lut_2x2MapObj_Right
    LDX #>lut_2x2MapObj_Right
    BNE @FacePlayer_Draw
  @FacePlayer_Left:
    LDA #<lut_2x2MapObj_Left
    LDX #>lut_2x2MapObj_Left

  @FacePlayer_Draw:
    STA tmp               ; low byte previously in A (from above)
    STX tmp+1             ; high byte from X -- tmp is now pointing to the proper 2x2 table

    JSR Draw2x2Sprite     ; draw the sprite
    LDX tmp+15            ; restore X to the previously backed-up object index
    RTS                   ; and exit



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Dialogue_CoverSprites_VBl  [$FF02 :: 0x3FF12]
;;
;;     Edits OAM to hide sprites that are behind the dialogue box
;;  then waits for a VBlank
;;
;;  IN:  tmp+11 = Y coord cutoff point (sprites above this scanline will be hidden)
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

Dialogue_CoverSprites_VBl:
    LDX #4*4           ; start looking at sprites after the first 4 sprites (first 4 are the player, who is never covered)
  @Loop:
    LDA oam_y, X       ; get the sprite's Y coord
    CMP tmp+11         ; compare it to our cutoff scanline (result in C)
    LDA oam_a, X       ; then get the attribute byte for this sprite    
    BCS @FGPrio        ; if spriteY >= cutoffY, sprite has foreground priority, otherwise, BG priority

   @BGPrio:
      ORA #$20         ; for BG prio, set the priority attribute bit in the attribute byte
      BNE @SetPrio     ; and jump ahead (always branches)
   @FGPrio:
      AND #~$20        ; for FG prio, clear priority bit

  @SetPrio:
    STA oam_a, X       ; record priority bit
    INX
    INX
    INX
    INX                ; then increment X by 4 to look at the next sprite

    BNE @Loop          ; keep looping until all sprites examined

    JMP WaitForVBlank_L   ; then wait for VBlank, and exit


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  LUTs for 2x2 sprites that make up map objects (townspeople, etc)  [$E7AB :: 0x3E7BB]
;;
;;    These are used with Draw2x2Sprite.  See that routine for details of
;;  the format of these tables
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

lut_2x2MapObj_Right:
 .BYTE $09,$42,$0B,$43,$08,$42,$0A,$43   ; standing
 .BYTE $0D,$42,$0F,$43,$0C,$42,$0E,$43   ; walking

lut_2x2MapObj_Left:
 .BYTE $08,$02,$0A,$03,$09,$02,$0B,$03
 .BYTE $0C,$02,$0E,$03,$0D,$02,$0F,$03

lut_2x2MapObj_Up:
 .BYTE $04,$02,$06,$03,$05,$02,$07,$03
 .BYTE $04,$02,$07,$43,$05,$02,$06,$43

lut_2x2MapObj_Down:
 .BYTE $00,$02,$02,$03,$01,$02,$03,$03
 .BYTE $00,$02,$03,$43,$01,$02,$02,$43




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Load Epilogue Scene GFX  [$E89C :: 0x3E8AC]
;;
;;    Loads all CHR required for the epilogue scene.  Also
;;  loads the nametables for the bridge/ending scene!
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

LoadEpilogueSceneGFX:
    LDA #$00                ; This routine is 100% identical to 
    STA $2001               ;   LoadBridgeSceneGFX below, except it loads CHR from
    STA $4015               ;   a different address.
    STA $5015               ;    JIGS - MMC5 AUDIO

    JSR LoadMenuCHR

    LDA #BANK_EPILOGUEGFX
    JSR SwapPRG_L
    
    LDA #<data_EpilogueCHR
    STA tmp
    LDA #>data_EpilogueCHR
    JSR SharedBridgeLoadingCode
    
    LDA #>data_EpilogueNT
    STA tmp+1
    LDX #4
    JSR CHRLoad_Cont
    JMP Ending_LoadPalette 
    
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Load Bridge Scene GFX  [$E8CB :: 0x3E8DB]
;;
;;    Loads all CHR required for the bridge scene.  Also
;;  loads the nametables for the bridge scene!
;;
;;    This is also used for the minigame, too.  Since it has the same nametable
;;  layout and much of the same CHR.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

SharedBridgeLoadingCode:
    STA tmp+1

    LDX #$08             ; load 8 rows of tiles ($800 bytes)
    LDA #$00             ; destination address = ppu $0000
    JSR CHRLoadToA       ; load 8 rows of tiles to ppu $0000

    ;                    ; now this is a little tricky.  It uses the CHR loading routine
    ;                    ;    to load NT data instead of CHR
SharedBridgeLoadingCode_2:    
    LDX #4               ; 4 rows of tiles = $400 bytes (1 full NT)
    LDA #$20             ; destination address = ppu $2000! (nametable)
    JMP CHRLoadToA       ; so this fills the whole nametable with NT data
    ;                    ;  stored at lut_BridgeGFX + $800 (+$800 because of the 8 rows of
    ;                    ;  tiles that were copied previously)

ReloadBridgeNT:
    LDA #BANK_BRIDGEGFX      ; swap to bank containing the graphics
    JSR SwapPRG_L
    LDA #<data_BridgeNT
    STA tmp
    LDA #>data_BridgeNT
    STA tmp+1
    JSR SharedBridgeLoadingCode_2
    JMP LoadCHR_MusicPlay_Always


LoadBridgeSceneGFX: ;; JIGS - this is for epilogue/prologue loading
    LDA #0
    STA $4015                ; and APU
    STA $5015                ;    JIGS - MMC5 AUDIO

LoadBridgeSceneGFX_Menu: ;; JIGS -- this is for menu loading; don't want to turn off audio
    LDA #0
    STA $2001                ; turn off PPU

    JSR LoadMenuCHR
    
    LDA #BANK_BRIDGEGFX      ; swap to bank containing the graphics
    JSR SwapPRG_L
    
    LDA #<data_BridgeCHR     ; load a pointer to the bridge scene graphics (CHR first)
    STA tmp
    LDA #>data_BridgeCHR
    
    JSR SharedBridgeLoadingCode

    LDA #>data_BridgeNT      ; reset the source pointer to the start of that NT data
    STA tmp+1

    LDX #4                   ; and set X to 4 again so we draw another $400 bytes (full NT)
    JSR CHRLoad_Cont         ; draw the SAME nametable.  This makes the nametables at
    JMP Bridge_LoadPalette   ;  $2000 and $2400 identical!  This is used for visual effects


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Misc "Master" CHR/Palette loading routines  [$E8FA :: 0x3E90A]
;;
;;   These "Master" routines load all CHR (BG and Sprite) necessary for the given
;;  situation.  Some also load most/all the palettes.  Exceptions will be noted
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; JIGS - moved battle loading stuff, not really necessary to have so many JSRs and JMPs all over the place

LoadMenuCHRPal:                ; does not load 'lit orb' palette, or the two middle palettes ($03C0-03CB)
    JSR LoadCHR_MusicPlay   
    LDA #BANK_MENUCHR          ; This is mainly for menu related CHR and palettes
    JSR SwapPRG_L              ; Swap to Bank D
    JSR LoadMenuOrbs
    JSR LoadBatSprCHRPalettes
	JSR LoadMenuTextBGCHR
    LDA #BANK_MENUS
    JMP SwapPRG_L

LoadShopCHRPal:
    JSR LoadShopBGCHRPalettes
	JSR LoadMenuTextBGCHR	   ; Loads up the blue menu palette as well
    JMP LoadBatSprCHRPalettes

LoadSMCHR:                     ; standard map -- does not any palettes
    JSR LoadPlayerMapmanCHR
    JSR LoadTilesetAndMenuCHR
    LDA #BANK_NPCSPRITES       ; swap to bank containing object info
    JSR SwapPRG_L
    JMP LoadNPCSprites

LoadOWCHR:                     ; overworld map -- does not load any palettes
    JSR LoadCHR_MusicPlay
    JSR LoadOWBGCHR
	JSR LoadCHR_MusicPlay
    JSR LoadPlayerMapmanCHR
	
LoadCHR_MusicPlay:	
    LDA MenuHush              ; only update music if exiting/loading the menu
	BNE LoadCHR_MusicPlay_Always
    RTS
    
LoadCHR_MusicPlay_Always:    
	JSR WaitForVBlank_L
	JMP CallMusicPlay_L

LoadPlayerMapmanCHR:
    LDA #BANK_MAPSPRITES
    JSR SwapPRG_L
    JMP LoadPlayerMapmanCHR_15


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Load Player Mapman CHR  [$E92E :: 0x3E93E]
;;
;;   Loads CHR for the player mapman graphic based on the lead party member's class
;;
;;  TMP:  tmp and tmp+1 used
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

ShiftSpriteHightoLow:
    LSR A
    LSR A
    LSR A
    LSR A
    RTS



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Load OW BG CHR  [$E94B :: 0x3E95B]
;;
;;   Loads all CHR for Overworld BG tiles (full left-hand pattern table)
;;   It is assumed the proper CHR bank is swapped in
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

LoadOWBGCHR:
    LDA #BANK_OWMAPTILESET
	STA cur_bank
    JSR SwapPRG_L
	LDA #>Overworld_Tileset
	STA tmp+1
	LDA #<Overworld_Tileset
	STA tmp
    LDA #0
	LDX #$08
	JSR CHRLoadToA		     ;; JIGS - load half, update music, load the next half
	JSR LoadCHR_MusicPlay
	LDA #>Overworld_Tileset+8
	STA tmp+1
	LDA #<Overworld_Tileset
	STA tmp
	LDX #$08
	TXA	
	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  CHR Row Loading To Given Address 'A'  [$E95A :: 0x3E96A]
;;
;;  Reads a given number of CHR rows from the given buffer, and writes to the specified
;;  address in CHR-RAM.  Destination address is stored in A upon entry
;;  It is assumed the proper PRG bank is swapped in
;;
;;  The difference between CHRLoadToA and CHRLoad is that CHRLoadToA explicitly sets
;;   the PPU address first, whereas CHRLoad does not
;;
;;
;;  IN:   A     = high byte of dest address (low byte is $00)
;;        X     = number of rows to load (1 row = 16 tiles or 256 bytes)
;;        (tmp) = source pointer to graphic data.  It is assumed the proper bank is swapped in
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

CHRLoadToA:
    LDY $2002   ; reset PPU Addr toggle
    STA $2006   ; write high byte of dest address
    LDA #0
    STA $2006   ; write low byte:  0

          ; no JMP or RTS -- seamlessly runs into CHRLoad

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  CHR Row Loading    [$E965 :: 0x3E975]
;;
;;  Reads a given number of CHR rows from the given buffer, and writes them to the PPU
;;  It is assumed that the proper PRG bank is swapped in, and that the dest PPU address
;;  has already been set
;;
;;  CHRLoad       zeros Y (source index) before looping
;;  CHRLoad_Cont  does not (retains Y's original value upon call)
;;
;;
;;  IN:   X     = number of rows to load (1 row = 16 tiles or 256 bytes)
;;        (tmp) = source pointer to graphic data.  It is assumed the proper bank is swapped in
;;        Y     = additional source index   (for CHRLoad_Cont only)
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

CHRLoad:
    LDY #$00

CHRLoad_Cont:
    LDA (tmp), Y      ; read a byte from source pointer
    STA $2007         ; and write it to CHR-RAM
    INY               ; inc our source index
    BNE CHRLoad_Cont  ; if it didn't wrap, continue looping

    INC tmp+1         ; if it did wrap, inc the high byte of our source pointer
    DEX               ; and decrement our row counter (256 bytes = a full row of tiles)
    BNE CHRLoad_Cont  ; if we've loaded all requested rows, exit.  Otherwise continue loading
    RTS



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Standard Map Tileset and Menu CHR Loading   [$E975 :: 0x3E985]
;;
;;   Loads CHR for the tileset of the current map (Standard maps -- not OW)
;;   Also loads menu CHR
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

LoadTilesetAndMenuCHR:
    LDA #BANK_MAPTILESETS
    JSR SwapPRG_L     ; swap to bank containing tileset CHR
    LDA #0
    STA tmp           ; set low byte of src pointer to $00
    LDA cur_tileset   ; get current tileset
    ASL A
    ASL A
    ASL A             ; * 8 (8 rows of tiles per tileset)
    ORA #$80          ; set high byte of src pointer to $80+(tileset * 8)
    STA tmp+1
    LDA #0            ; dest address = $0000
    LDX #8            ; 8 rows to load
    JSR CHRLoadToA

          ;  no JMP or RTS -- seamlessly runs into LoadMenuCHR
	JMP LoadMenuTextBGCHR



    



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Load Shop CHR and Palettes  [$EA02 :: 0x3EA12]
;;
;;    Loads up ALL BG CHR and palettes relating to shops
;;    Does not load any sprite CHR or palettes
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



LoadShopBGCHRPalettes:
    LDA #BANK_MENUCHR
    JSR SwapPRG_L        ; Swap to bank
    JMP LoadShopCHR_andPalettes

LoadMenuTextBGCHR:
	JSR LoadCHR_MusicPlay	

LoadMenuCHR:
    LDA #BANK_MENUCHR 
    JSR SwapPRG_L

    LDA #<lut_MenuTextCHR
	STA tmp
    LDA #>lut_MenuTextCHR
	STA tmp+1
	
    LDA #$08           ; dest PPU address = $0800
    TAX
    JSR CHRLoadToA     ; load them up  (loads all shop related CHR
	JMP LoadBorderPalette_Blue



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Load Battle Sprite CHR and Palettes  [$EAB9 :: 0x3EAC9]
;;
;;    Comes in 2 flavors.  The first loads all 6 class graphics and the cursor graphic
;;     This is used for the 'New Game' screen where you select your party
;;
;;    Next is the in-game flavor that loads 4 classes based on the characters in
;;     The party.  It also loads the cursor, as well as other in-battle sprites, such
;;     as those little magic and weapon animations, and the "fight cloud" that appears
;;     when you attack an enemy.
;;
;;    Both load all palettes used by battle sprites to $03Dx
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

LoadBatSprCHRPalettes:
    LDA #BANK_BATTLESPRITES
    JSR SwapPRG_L       
    
    JSR LoadAllBattleSprites_Menu ; loads the 4 characters entire graphics - every pose
	JSR LoadCHR_MusicPlay

    LDA #BANK_MENUS
    JMP SwapPRG_L      ; and swap to bank E on exit
    
    
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Load Border Palette  [$EB29 :: 0x3EB39]
;;
;;    Loads the greyscale palette used for the border in menus
;;   The routine has 2 entry points... one to load the BLACK bg (used in battle)
;;   and one to load the BLUE bg (used in menus/shops)
;;
;;   X,Y remain unchanged
;;
;;   OUT:  $03CC-03CF = border palette
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

LoadBorderPalette_Blue:
    LDA #$01
    BNE :+         ; always branches

LoadBorderPalette_Grey:
  ;  LDX BattleBGColor
  ;  LDA BattleBackgroundColor_LUT, X
    LDA #$10         
 :  STA cur_pal+$E   ; Black or Blue goes to color 2
    LDA #$0F
    STA cur_pal+$C   ; Black always to color 0
    LDA #$00
    STA cur_pal+$D   ; Grey always to color 1
    LDA #$30
    STA cur_pal+$F   ; White always to color 3
    RTS   



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Draw Out of Battle Sprite [$EBFC :: 0x3EC0C]
;;
;;    This will draw the battle sprite which represents the given party member.
;;  It will draw the class, and will draw him standing if healthy, hunched if poisoned,
;;  hunched and greyed if stoned, and will not draw him at all if dead.
;;
;;    This is specifically for out of battle sprites because in battle, other stances
;;  are possible.
;;
;;  IN:   A           = char index ($00,$40,$80, or $C0) of the character we want to draw
;;        spr_x,spr_y = coords to draw the sprite at
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

DrawOBSprite_Exit:
    RTS

DrawOBSprite:
    TAX                   ; put character index in X
    LSR A                 ;  divide char index by 2
    STA tmp               ;  and put it in tmp  (tmp is now $00,$20,$40, or $60 -- 2 rows of tiles per character)

    LDY ch_sprite, X               ; get the char's class
    ;TAY                           ; use it as an index
    LDA lutClassBatSprPalette, Y  ;  to find which palette that class's battle sprite uses
    STA tmp+1                     ;  put palette in tmp+1

    LDA ch_ailments, X    ; get out of battle ailment byte
    CMP #$80
    BCS @SwapReady        ;; JIGS - if high bit set, character is primed for swapping
    AND #$0F
    BEQ @Standing         ;; no ailments, draw standing
    LSR A
    BCS DrawOBSprite_Exit ;; dead, don't draw anything
    LSR A
    BCS @Stoned           ;; stone, so use the cheer pose, but change palette first
    ;; otherwise, poisoned or blind, so draw crouched, because drawing cool glasses is too hard right now
    ;; ...they're just looking for their contacts...
    
  @Crouched:              ; to draw sprite as crouched... at #$14 to the
    LDA #$14              ;   tile number to draw.
    BNE @Standing
    
  @Stoned: 
    LDA #$03              ; otherwise (ailment byte = 2), character is stoned
    STA tmp+1             ;  change palette byte to 3 (stoned palette)
   
    ;LDA tmp+1
    ;ORA #$40
    ;STA tmp+1            ; JIGS - this would reverse the sprite direction I think?
    ;LDA #$14             ; and draw them kneeling
    ;BNE @Standing
   
  @SwapReady:
    LDA #$0E              ; draw cheering  

  @Standing:              ; to really draw sprite as standing, A must be 0 here
    CLC                   ; add tile offset to tmp
    ADC tmp               ;  tmp is now the start of the tiles which make up this sprite
    STA tmp               ;  and tmp+1 is the palette to use

    ;; no JMP or RTS -- code seamlessly runs into DrawSimple2x3Sprite

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Draw Simple 2x3 Sprite [$EC24 :: 0x3EC34]
;;
;;    Draws a simple 2x3 sprite (an out of battle sprite).  This is called
;;  by above DrawOBSprite routine, but is also called by the party generation screen
;;  since the party creation screen cannot use DrawOBSprite to draw its sprites
;;  (because DrawOBSprite examines characters stats and assumes the CHR for each
;;  character is loaded seperately)
;;
;;  IN:  tmp         = tile ID to start drawing from
;;       tmp+1       = attributes (palette) for all tiles of this sprite
;;       spr_x,spr_y = coords to draw sprite
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

DrawSimple2x3Sprite:
    LDX sprindex       ; put sprite index in X

    LDA tmp+1
    PHA
    AND #$40
    BEQ @Normal
    
   @Reversed:
    LDA #$F8
    STA tmp+1
    LDA spr_x
    CLC
    ADC #08
    BNE :+
    
   @Normal: 
    LDA #$08
    STA tmp+1
    
    LDA spr_x          ; get X coord
  : STA oam+$03, X     ;  write to UL, ML, and DL sprites
    STA oam+$0B, X
    STA oam+$13, X
    CLC
    ADC tmp+1; #$08           ; add 8 to X coord
    STA oam+$07, X     ;  write to UR, MR, and DR sprites
    STA oam+$0F, X
    STA oam+$17, X

    LDA spr_y          ; get Y coord
    STA oam+$00, X     ; write to UL, UR sprites
    STA oam+$04, X
    CLC
    ADC #$08           ; add 8
    STA oam+$08, X     ; write to ML, MR sprites
    STA oam+$0C, X
    CLC
    ADC #$08           ; add another 8
    STA oam+$10, X       ; write to DL, DR sprites
    STA oam+$14, X

    LDA tmp            ; get the tile ID to draw
    STA oam+$01, X     ; draw UL tile
    CLC
    ADC #$01           ; increment, 
    STA oam+$05, X     ;  then draw UR
    CLC
    ADC #$01           ; inc again
    STA oam+$09, X     ;  then ML
    CLC
    ADC #$01
    STA oam+$0D, X     ;  then MR
    CLC
    ADC #$01
    STA oam+$11, X     ;  then DL
    CLC
    ADC #$01
    STA oam+$15, X     ;  then DR

    ;LDA tmp+1          ; get attribute byte
    PLA
    STA oam+$02, X     ; and draw it to all 6 sprites
    STA oam+$06, X
    STA oam+$0A, X
    STA oam+$0E, X
    STA oam+$12, X
    STA oam+$16, X

    TXA                ; put sprite index in A
    CLC
    ADC #6*4           ; increment it by 6 sprites (4 bytes per sprite)
    STA sprindex       ; and write it back (so next sprite drawn is drawn after this one in oam)
    RTS                ;  and exit!

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Draw Cursor  [$EC95 :: 0x3ECA5]
;;
;;    Draws the cursor at given X,Y coords (spr_x,spr_y)
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

DrawCursor:
    LDA #<lutCursor2x2SpriteTable   ; load up the pointer to the cursor sprite
    STA tmp                         ; arrangement
    LDA #>lutCursor2x2SpriteTable   ; and store that pointer in (tmp)
    STA tmp+1
    LDA #$F0                        ; cursor tiles start at $F0
    STA tmp+2
    JMP Draw2x2Sprite               ; draw cursor as a 2x2 sprite, and exit



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  LUT for battle sprite palettes  [$ECA4 :: 0x3ECB4]
;;
;;    each byte indicates which palette (or, more specifically, the entire attribute byte)
;;  is used for each class' battle sprite.  01 is the white/red palette (fighters, red mages, etc)
;;  00 is the blue/brown palette (black mage, thief, etc)
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

lutClassBatSprPalette:
  .BYTE $01,$02,$00,$01,$01,$00,$00,$00    ; 
  .BYTE $01,$02,$00,$01,$01,$00,$00,$00    ; 
  .BYTE $01,$02,$00,$01,$01,$00,$00,$00    ; 
  .BYTE $01,$02,$00,$01,$01,$00,$00,$00    ; 

  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  LUT for cursor sprite arrangement [$ECB0 :: 0x3ECC0]
;;
;;   This lut is used for drawing the standard finger cursor.  See Draw2x2Sprite for details
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

lutCursor2x2SpriteTable:
  .BYTE $00, $03      ; UL sprite = tile 0, palette 3
  .BYTE $02, $03      ; DL sprite = tile 2, palette 3
  .BYTE $01, $03      ; UR sprite = tile 1, palette 3
  .BYTE $03, $03      ; DR sprite = tile 3, palette 3


  ;;  Unused byte
  ;.BYTE $FF

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Load Price   [$ECB9 :: 0x3ECC9]
;;
;;   Loads the price of a desired item and stores it at $10-12
;;
;;  IN:   A            = ID of item to fetch price of
;;
;;  OUT:  tmp to tmp+2 = price of item
;;        *            = BANK_MENUS swapped in
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


LoadPrice_Long:
    JSR LoadPrice
    LDA #BANK_BATTLE
    JMP SwapPRG_L

LoadPrice:
    ASL A             ; double item ID
    TAY               ; backup item ID
    DEY 
    DEY               ; convert to 0-based
  
    LDA #BANK_ITEMPRICES
    JSR SwapPRG_L  ; swap to bank A (for item prices)
  
    LDX shop_type
    LDA lut_PriceTable_Low, X
    STA tmp+1
    LDA lut_PriceTable_High, X
    STA tmp+2
    
    CPX #SHOP_WHITEMAGIC
    BCC @Normal
    CPX #SHOP_ITEM
    BCS @Normal
    
   @MagicPrices:
    LDA shop_curitem ; get the spell ID
    LSR A            ; shift to get spell level
    LSR A
    LSR A
    LSR A            ; bump off that last bit of the low nybble
    ASL A            ; then * 2  
    TAY              ; spells only have 8 prices
    
   @Normal: 
    LDA (tmp+1), Y ; get low byte of price
    STA tmp
    INY
    LDA (tmp+1), Y ; and high byte
    STA tmp+1

    LDA #0
    STA tmp+2       ; 3rd byte is always 0 (no item costs more than 65535)

    LDA #BANK_MENUS ; swap back to bank E
    JMP SwapPRG_L   ; and return



;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Draw Equip Menu Strings  [$ECDA :: 0x3ECEA]
;;
;;    String is placed at str_buf+$10 because first 16 bytes are used for item_box
;;  (the equipment list)
;;
;;    This routine is called when the equip menus change.  If an item is equipped/unequipped
;;  or dropped, or traded.  As such, the entire string of changed items needs to be redrawn.
;;  therefore for drawing empty slots, multiple blank tiles (FF) must be drawn to erase the
;;  item name that was previously drawn.  Blank tiles must also extend past the end of
;;  shorter equipment names.  So that if you have "Wooden" and trade it with "Cap", you're
;;  not left with "Capden".
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;


DrawEquipMenuStrings:
    LDA #0                       ; string will be placed at str_buf+$40, and will be 8 bytes long
    STA str_buf+$48              ; so put the null terminator at the end right-off
    
    LDA char_index
    CLC
    ADC #ch_righthand - ch_stats
    STA MMC5_tmp    
    
    LDA #$00                     ; Set A to zero.  This is our loop counter
    STA MMC5_tmp+1
  @MainLoop:
    PHA                          ; push the loop counter to the stack
    PHA                          ; ... twice
    CLC
    ADC MMC5_tmp                 ; X is now Character Index + start of equipment + loop counter
    TAX                          ; then move it to X
    PLA                          ; restore loop counter
    TAY                          ; and move it*2 to Y
    
    LDA #$12
    STA dest_x                   ;  load up x,y coords for this string
    LDA lut_EquipStringPositions, Y
    STA dest_y

    LDA #>(str_buf+$40)   
    STA text_ptr+1        
    LDA #<(str_buf+$40)   
    STA text_ptr          
    
    LDA #BANK_ITEMS
    JSR SwapPRG_L                ; swap to the bank containing the item strings

    LDA ch_stats, X
    BNE @LoadName                ; if nonzero, load up the other name...

      LDX #8
      LDA #$FF
     @miniloop: 
      STA str_buf+$3F, X
      DEX
      BNE @miniloop
      BEQ @NotEquipped
      
     ; if every STA is 3 bytes of code, this ^ should be less space 

     ; LDA #$FF                   ; otherwise (zero), slot is empty, just fill the string with spaces
     ; STA str_buf+$40
     ; STA str_buf+$41
     ; STA str_buf+$42
     ; STA str_buf+$43
     ; STA str_buf+$44
     ; STA str_buf+$45
     ; STA str_buf+$46
     ; STA str_buf+$47
     ; BNE @NotEquipped           ; then skip ahead (always branches)

  @LoadName:                     ; if the slot is not empty....
    TAX                          ; and stuff it in X to load up the pointer
    DEX                          ; subtract 1 from the item ID
    LDA lut_EquipmentNames_Low, X  ; fetch the pointer and store it to (tmp)
    STA tmp
    LDA lut_EquipmentNames_High, X
    STA tmp+1

    LDY #$07                     ; copy 8 characters from the item name (doesn't look for null termination)
   @LoadNameLoop:
      LDA (tmp), Y               ; load a character in the string
      STA str_buf+$40, Y         ; and write it to our string buffer. 
      DEY                        ; Then decrement Y
      BPL @LoadNameLoop          ; and loop until it wraps (8 iterations)
    
  @NotEquipped:
    JSR DrawComplexString        ; then draw the complex string

    INC MMC5_tmp+1               ; and INC this so we don't draw a weapon again
    PLA                          ; pull the main loop counter
    CLC
    ADC #$01                     ; increment it by one
    CMP #8                       ; and loop until it reaches 8 (8 equipment names to draw)
    BNE @MainLoop ; BCC

    LDA #BANK_MENUS              ; once all names are drawn
    JMP SwapPRG_L                ; then swap back to that bank


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  lut for Equip string positions  [$ED72 :: 0x3ED82]
;;
;;   X,Y positions for equipment text to be printed in equip menus

lut_EquipStringPositions:
.byte $05
.byte $07
.byte $09
.byte $0B
.byte $0D
.byte $0F
.byte $11
.byte $13








    

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  DrawItemBox  [$EF18 :: 0x3EF28]
;;
;;    Fills the item box buffer in RAM with items that the player currently
;;  has in their possesion.
;;
;;    Also draws the item box (and its contents) to the screen
;;
;;  OUT:  C is cleared if the player has at least 1 item, and is set if the player
;;         has no items.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


DecompressKeyItems:
    JSR Set_Inv_KeyItem

    LDX #0
    STA tmp+1
    LDA #keyitems - items      ; set to start of key items
    STA tmp
   
   @Decompress_Loop:
    JSR DOES_ITEM_EXIST_1BIT  ; A = item ID
    BEQ @DoesNotExist
   
    LDX tmp+1                 ; X is item box position
    LDA tmp                   ; get item ID and put in item_box
    STA item_box, X
    INC tmp+1                 
    
   @DoesNotExist: 
    INC tmp                   ; increment item ID 
    LDA tmp
    CMP #ITEM_SKILLSTART      ; see if its gone past key items
    BNE @Decompress_Loop      
    
    LDX tmp+1                 ; put item box position in X in case it wasn't
    JMP ItemBoxFilled    


FillItemBox:
    LDX #0               ; X is our dest index -- start it at zero
    STX tmp+2            ; loop counter
    LDY #1               ; Y is our source index -- start it at 1 (first byte in the 'items' buffer is unused)
    
    LDA submenu_cursor   ; if 1, do key items
    BNE DecompressKeyItems
   
  @ItemFillLoop:
      LDA items, Y       ; check our item qty
      BEQ @IncSrc        ; if it's nonzero...
        TYA              ;  put this item ID in A
        STA item_box, X  ;  and write it to the item box buffer
        INX              ;  inc our dest index

    @IncSrc:
      INY                  ; inc our source index
      INC tmp+2            ; inc loop counter
      LDA tmp+2
      CMP #item_qty_stop - items ; only display this many items at a time
      BCC @ItemFillLoop

ItemBoxFilled:
    CPX #0                 ; if the dest index is still zero, the player has no items
    BNE @StartDrawingItems ;   otherwise (nonzero), start drawing the items they have

    ; no items, so no further work to be done... just exit with C set
      SEC
      RTS

  @StartDrawingItems:
    LDA #0
    STA item_box, X    ; put a null terminator at the end of the item box (needed for following loop)
    STA tmp+3          ; also reset the cursor to 0 (which will be used as a loop counter below)
    STA tmp+2          ; now letter position counter
 
  @DrawItemLoop:
    LDA #BANK_ITEMS    ; swap to BANK_ITEMS (bank containing item names)
    JSR SwapPRG_L

    LDX tmp+3          ; get current loop counter and put it in X
    LDA item_box, X    ; index the item box to see what item name we're to draw
    BEQ @Exit          ; if the item ID is zero, it's a null terminator, which means we're done

    PHA                ; push the item ID
    TAX                ;  and put it in X to index (will be used to index the string pointer table)

    LDA lut_ItemNames_Low, X   ; get the pointer to this item name
    STA tmp                     ;  and put it in (tmp)
    LDA lut_ItemNames_High, X
    STA tmp+1

    ;; JIGS quite a few changes in here, starting with 12 letter quest item names and 8 letter consumable names!
    ;; Quest items draw 12 characters out, while consumables look for a null terminator.
    ;; The exception is the Bottle, which needs to be 8 letters to fit in the store windows...
    
    LDX tmp+2
    LDY #0

   @CopyLoop:
      LDA (tmp), Y         ; copy each character
      BEQ :+               ; stop at null terminator--don't copy it - X should be in the 9th slot for consumables now
      STA bigstr_buf, X    ; and put in bigstr_buf
      INX 
      INY 
      CPY #12
      BNE @CopyLoop        ; loop until Y wraps (copies 12 characters)
      PLA                  ; pull the item ID  
      JMP @SkipQty    
      
  : STX tmp+2               ; backup letter position counter
    PLA                     ; pull the item ID
    CMP #item_qty_stop - items ; double-check its a quest item
    BCS @SkipQty
    TAX                     ; put item ID in X
    LDA items, X            ; use it to index inventory to see how many of this item we have
    STA tmp                 ;  put the qty in tmp
    
    LDA #BANK_MENUS
    JSR SwapPRG_L           ; also swap to BANK_MENUS (for PrintNumber routines)
    JSR PrintNumber_2Digit  ; print the 2 digit number

    LDX tmp+2               ; restore letter position counter
    INX                     ; increase X to 10th slot
    INX                     ; increase X to 11th slot
    LDA format_buf-2        ; copy the printed 2 digit number from the format buffer
    STA bigstr_buf, X         
    INX                     ; increase X to the 12th slot
    LDA format_buf-1
    STA bigstr_buf, X       ; consumables will only appear on page 1
    INX

  @SkipQty:
    INX        ; now make room for the cursor in the middle
    INX
    LDA tmp+3  ; check current item counter
    CMP #15
    BEQ @Exit
    AND #$01   ; see if its even or odd (odd will always have bit 1 set!)
    BNE :+
    INX        ; if its even, the item's in the first column, and we need to add an extra space
  : STX tmp+2
    INC tmp+3
    JMP @DrawItemLoop
   
  @Exit:  
    LDA #BANK_MENUS
    JSR SwapPRG_L           ; resume menu functions
    
    CLC    ; C clear on exit indicates there was at least 1 item in inventory
    RTS
    
    

    
    


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Item Box String Positions [$EFCC :: 0x3EFDC]
;;
;;   LUT containing X,Y coords of where to draw the strings inside of
;;  the item box.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;lutItemBoxStrPos:
;  .BYTE $03,$05,   $12,$05
;  .BYTE $03,$07,   $12,$07
;  .BYTE $03,$09,   $12,$09
;  .BYTE $03,$0B,   $12,$0B
;  .BYTE $03,$0D,   $12,$0D
;  .BYTE $03,$0F,   $12,$0F
;  .BYTE $03,$11,   $12,$11
;  .BYTE $03,$13,   $12,$13
  
  ;; JIGS - wider box has more space, so space things out better!




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  DTE table   [$F050 :: 0x3F060]
;;
;;  first table is the 2nd character in a DTE pair
;;  second table is the 1st character in a DTE pair
;;
;;  don't ask me why it's reversed
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

lut_DTE2:
  .BYTE $FF,$B7,$AB,$A8,  $FF,$B1,$A4,$FF,  $B1,$A8,$B6,$B5,  $B8,$FF,$B2,$FF
  .BYTE $AA,$A4,$B6,$AC,  $FF,$B5,$B6,$A5,  $A8,$BA,$A8,$B5,  $B2,$B7,$A6,$B7
  .BYTE $B1,$A7,$B1,$AC,  $A8,$B6,$A7,$A4,  $B0,$A9,$FF,$A8,  $BA,$FF,$A8,$B0
  .BYTE $92,$FF,$A9,$B2,  $AF,$B3,$BC,$A4,  $8A,$A8,$FF,$B5,  $B2,$AC,$FF,$AB
  .BYTE $A8,$B7,$AC,$A4,  $A6,$AF,$A8,$AF,  $A8,$B6,$FF,$AF,  $A8,$A7,$AC,$C0 ; $C3
;; JIGS this tiny change turns ellipses into 3 periods instead of 4. 4 Looks weird.
  
lut_DTE1:
  .BYTE $A8,$FF,$B7,$AB,  $B6,$AC,$FF,$B7,  $A4,$B5,$FF,$A8,  $B2,$A7,$B7,$B1
  .BYTE $B1,$A8,$A8,$FF,  $B2,$A4,$AC,$FF,  $B9,$FF,$B0,$B2,  $FF,$B6,$FF,$A4
  .BYTE $A8,$B1,$B2,$AB,  $B6,$A4,$A8,$AB,  $FF,$FF,$B5,$AF,  $B2,$AA,$A6,$B2
  .BYTE $90,$BC,$B2,$B5,  $AF,$FF,$FF,$A6,  $96,$B7,$A9,$B8,  $BC,$B7,$AF,$FF
  .BYTE $B1,$AC,$B5,$BA,  $A4,$A4,$BA,$AC,  $A5,$B5,$B8,$FF,  $AA,$FF,$AF,$C3

;;
;;  ???  F0F0
;;   could this be remnants of removed code/data?
;;
;  .BYTE $0A,$FE,$20,$00,$BC,$68,$4C,$03,$FE,$00,$00,$00,$00,$00,$0A,$03
;; JIGS - LETS SEE IF IT BREAKS


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  RNG scrambling lookup table  [$F100 :: 0x3F110]
;;
;;    This table is $100 bytes in size, and simply consists of every number
;;  between $00-FF in a scrambled order.  This is used in some of the random
;;  number generators in the game to make the output seem more scrambled/random
;;

lut_RNG:
    .INCBIN "bin/0F_F100_rngtable.bin"




    
    
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

JIGS_RefreshAttributes:
    LDA #BANK_BTLDATA
    JSR SwapPRG_L
    JSR WriteAttributesToPPU
    LDA battle_bank
    JMP SwapPRG_L

    
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Battle_ReadPPUData  [$F268 :: 0x3F278]
;;
;;    Reads a given number of bytes from PPU memory.
;;
;;  input:
;;     btltmp+4,5 = pointer to write data to
;;     btltmp+6,7 = the PPU address to read from
;;     btltmp+8   = the number of bytes to read
;;
;;  This routine will swap back to the battle_bank prior to exiting
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

Battle_ReadPPUData_L:    
Battle_ReadPPUData:
    JSR WaitForVBlank_L         ; Wait for VBlank
    
    LDA tmp+7
    STA $2006
    LDA tmp+6
    STA $2006
    
    LDA $2007                   ; Throw away buffered byte
    LDY #$00
    LDX tmp+8                   ; btltmp+8 is number of bytes to read
  @Loop:
      LDA $2007
      STA (tmp+4), Y            ; write to (btltmp+4)
      INY
      DEX
      BNE @Loop
      
    LDA battle_bank             ; swap back to desired battle bank, then exit
    JMP SwapPRG_L
    
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  BattleCrossPageJump  [$F284 :: 0x3F294]
;;
;;  Called from a swappable bank to jump to a routine in a different bank.
;;
;;         A = the target bank   (also updates battle_bank)
;;  blttmp+6 = the address of the routine to jump to

BattleCrossPageJump_L:
BattleCrossPageJump:
    STA battle_bank
    JSR SwapPRG_L
    JMP (btltmp+6)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Enter Battle  [$F28D :: 0x3F29D]
;;
;;    Called to initiate a battle.  Does a lot of prepwork, then calls
;;  another routine to do more prepwork and enter the battle loop.
;;
;;    This routine assumes some CHR and palettes have already been loaded.
;;  Specifically... LoadBattleCHRPal should have been called prior to this routine.
;;
;;    Also somewhat oddly, absolute mode is forced for a lot of zero page vars
;;  here (hence all the "a:" crap).  I have yet to understand that.  Must've been
;;  an assembler quirk.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

EnterBattle_L:
EnterBattle:
    JSR BattleTransition      ; Do the flashy transition effect

    LDA #$00
    STA $2001                 ; turn off the PPU

    LDA #BANK_Z               ;; and do pre-emptive battle prep for gear...
    JSR SwapPRG_L
    JSR SetPartyStats

    LDA #BANK_MUSIC
    JSR SwapPRG_L
    JSR BackupMapMusic
    
    LDA #BANK_BATTLESPRITES
    JSR SwapPRG_L              ; this loads the player stone graphics to background tiles
    JSR LoadStoneSprites       ; and loads character palettes   

    LDA #BANK_ATTACKSPRITES
    JSR SwapPRG_L
	LDA #0
    STA MMC5_tmp              ; this loads the player>enemy attack cloud sprites
    JSR LoadSprite_Bank03     ; + backdrop palette and graphics
    
    ;; Load formation data to buffer in RAM and literally everything else

    LDA #BANK_BTLDATA         ; here we load the battle formation data
    JSR SwapPRG_L             ; swap to the bank containing that data
    JSR BeginBattleSetup

    LDA #BANK_DOBATTLE
    STA battle_bank    
    JSR SwapPRG_L
    JMP FinishBattlePrepAndFadeIn ; and jump to battle routine!

LoadEnemyGraphicsFromBank:
    JSR SwapPRG_L             ; Swap in indicated bank
    JSR CHRLoad       
    LDA #BANK_BTLDATA
    JMP SwapPRG_L









;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  SetPPUAddr_XA  [$F3BF :: 0x3F3CF]
;;
;;    Sets the PPU Addr to XXAA
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

SetPPUAddr_XA:
    STX $2006   ; write X as high byte
    STA $2006   ; A as low byte
    RTS




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  BattleScreenShake  [$F440 :: 0x3F450]
;;
;;  Shakes the screen for a few frames (when an enemy attacks)
;;
;;  This routine takes 13 frames, and during that time, the sound effects
;;  are NOT updated.  This results in the sound effect the game makes when
;;  an enemy attacks to hang on the low-pitch 'BOOM' noise longer than
;;  its sound effect data indicates it should.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

BattleScreenShake_L:
BattleScreenShake:
    LDA #$20
    ORA btl_soft2001
    STA btl_soft2001 ;; JIGS - add red emphasis to screen
    JSR Battle_UpdatePPU_UpdateAudio_FixedBank ; 
    
    LDA #$06
    STA ScreenShakeCounter           ; loop down counter.  6*2 = 12 frames  (2 frames per loop)
  @Loop:
      JSR @Stall2Frames ; wait 2 frames
      
      JSR BattleRNG
      AND #$03          ; get a random number betwee 0-3
      STA tmp+11
      STA $2005         ; use as X scroll
      JSR BattleRNG
      AND #$03          ; another random number
      STA tmp+12
      STA $2005         ; for Y scroll
      
      DEC ScreenShakeCounter
      BNE @Loop
    
    ;LDA btl_soft2001
    ;AND #$DF
    LDA #$1E
    STA btl_soft2001     ; JIGS - turn off red emphasis
    JMP Battle_UpdatePPU_UpdateAudio_FixedBank  ; 1 more frame (with reset scroll)
    
  @Stall2Frames:
    JSR @Frame          ; do 1 frame
    LDX #$00            ; wait around -- presumably so we don't try
    : NOP               ;   to wait during VBlank (even though that wouldn't
      NOP               ;   be a problem anyway)
      NOP
      DEX
      BNE :-            ; flow into doing another frame
    
  @Frame:
    JSR WaitForVBlank_L
    JMP BattleUpdateAudio_FixedBank



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Battle_UpdatePPU_UpdateAudio_FixedBank  [$F485 :: 0x3F495]
;;
;;  Resets scroll and $2001, then updates audio.
;;
;;  Used by only a few routines in the fixed bank.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

 :  LDA #$00            ; reset scroll
    STA $2005
    STA $2005
    RTS

Battle_UpdatePPU_UpdateAudio_FixedBank:
    LDA MenuHush     ;; JIGS - if in main menu, don't tint screen!
    BNE :-
    
    LDA btl_soft2001
    STA $2001
    LDA #$00            ; reset scroll
    STA $2005
    STA $2005
  ; JMP BattleUpdateAudio_FixedBank  ; <- flow continues to this routine

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  BattleUpdateAudio_FixedBank  [$F493 :: 0x3F4A3]
;;
;;  Same idea as BattleUpdateAudio from bank $C... just in the fixed bank.
;;
;;  Note that this routine does NOT update battle sound effects.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    
BattleUpdateAudio_FixedBank:
    LDA music_track
    BPL :+
      LDA btl_followupmusic
      STA music_track
:   JMP CallMusicPlay_L


  

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  BattleDrawMessageBuffer  [$F4AA :: 0x3F4BA]
;;
;;  Takes 'btl_msgbuffer' and actually draws it to the PPU.
;;
;;  This process takes 12 frames, as it draws 1 row for each frame.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

BattleDrawMessageBuffer:
    LDA tmp+8                 ; box X and Y position totals
    CLC    
    ADC #<$2280               ; set target PPU address to $2240
    STA btldraw_dst           ; This has the start of the bottom row of the bounding box for 
    LDA #>$2280               ;  enemies
    ADC #0
    STA btldraw_dst+1
  
  @Loop:
      JSR Battle_DrawMessageRow_VBlank  ; draw a row
      
      LDA BattleTmpPointer2   ; add $20 to the source pointer to draw next row
      CLC
      ADC #$20
      STA BattleTmpPointer2
      LDA BattleTmpPointer2+1
      ADC #$00
      STA BattleTmpPointer2+1
      
      LDA btldraw_dst          ; add $20 to the target PPU address
      CLC
      ADC #$20
      STA btldraw_dst
      LDA btldraw_dst+1
      ADC #$00
      STA btldraw_dst+1
      
      JSR Battle_UpdatePPU_UpdateAudio_FixedBank
      
      DEC btl_msgbuffer_loopctr         ; loop for each row
      BNE @Loop
    RTS
    
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Battle_DrawMessageRow_VBlank  [$F4E5 :: 0x3F4F5]
;;  Battle_DrawMessageRow         [$F4E8 :: 0x3F4F8]
;;
;;  Draws a row of tiles in the 'message' area on the battle screen.
;;  The row consists of $19 tiles.
;;
;;  input:  $88,$89 = pointer to data to draw
;;          $8A,$8B = PPU address to draw to.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

Battle_DrawMessageRow_VBlank:
    JSR WaitForVBlank
    
Battle_DrawMessageRow:
    LDA btldraw_dst+1
    STA $2006           ; set provided PPU address
    LDA btldraw_dst
    STA $2006
    LDY #$00
  @Loop:
      LDA (BattleTmpPointer2), Y      ; read $19 bytes from source pointer
      STA $2007        
      INY
      CPY tmp+6 ; box width 
      BNE @Loop
    RTS

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  BattleDrawMessageBuffer_Reverse  [$F4FF :: 0x3F50F]
;;
;;  Takes 'btl_msgbuffer' and actually draws it to the PPU, but draws
;;     the rows in reverse order (bottom up)
;;
;;  Takes 6 frames worth of time, as it draws 2 rows per frame.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

BattleDrawMessageBuffer_Reverse:

 ;  height - 1 + Y position + X position * 32 + $2280
  
    LDA btl_msgbuffer_loopctr ; height
    SEC
    SBC #1     ; -1 from height
    CLC
    ADC tmp+12 ; Y position of box upper left corner
    LDX #32
    JSR MultiplyXA
    CLC
    ADC tmp+4  ; X position
    ADC #$80
    STA btldraw_dst
    TXA
    ADC #$22
    STA btldraw_dst+1
    
    ;; should get bottom left tile of box to start at 
 
   @Loop:
    JSR Battle_DrawMessageRow_VBlank  ; draw a row
    
    LDA BattleTmpPointer2     ; subtract $20 from the source pointer
    SEC
    SBC #$20 
    STA BattleTmpPointer2
    LDA BattleTmpPointer2+1
    SBC #$00
    STA BattleTmpPointer2+1
    
    LDA btldraw_dst     ; and from the dest pointer
    SEC
    SBC #$20 
    STA btldraw_dst
    LDA btldraw_dst+1
    SBC #$00
    STA btldraw_dst+1
    
    JSR Battle_UpdatePPU_UpdateAudio_FixedBank

    DEC btl_msgbuffer_loopctr
    BNE @Loop         ; loop until all rows drawn
    RTS


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  ClearBattleMessageBuffer  [$F620 :: 0x3F630]
;;
;;  Clears the battle message buffer in memory, but does not do any actual drawing.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

ClearBattleMessageBuffer_L:
ClearBattleMessageBuffer:
    ; Clear the message buffer
    LDY #$00
    LDA #$F6 ; 00
    : STA btl_msgbuffer, Y      ; clear the message buffer
      STA btl_msgbuffer+$20, Y  ; which is $130 bytes long
      INY
      BNE :-
  RTS



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  UndrawNBattleBlocks  [$F6B3 :: 0x3F6C3]
;;
;;  This progressively erases 'N' battle blocks.
;;
;;  A = 'N', the number of blocks to undraw
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

UndrawNBattleBlocks_L:
UndrawNBattleBlocks:
    AND #$FF            ; see if A==0
    BEQ @Exit           ; if zero, just exit
    
    STA UndrawNBattleBlocks_loopctr           ; otherwise, store in temp to use as a downcounter
  @Loop:
      JSR UndrawBattleBlock ; undraw one
      DEC UndrawNBattleBlocks_loopctr             ; dec
      BNE @Loop             ; loop until no more to undraw
  @Exit:
    JMP DrawBox_WaitForVBlank
    
    
    
    
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  DrawCombatBox  [$F71C :: 0x3F72C]
;;
;;  input:  A = ID of box to draw (0-4)
;;         YX = pointer to text data to put in that box
;;
;;  Combat boxes are the boxes that pop up during combat that show attackers/damage/etc.
;;  See lut_CombatBoxes for more.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;




CombatBoxStrings_LUT:
    .WORD ConfirmTurn       ; battle_autoswitch = 0 
    .WORD ConfirmCharge     ; battle_autoswitch = 1 
    .WORD ConfirmRunAway    ; battle_autoswitch = 2 
    .WORD PlayerBoxString   ; 03
    .WORD CommandString     ; 04
    .WORD EnemyRosterString ; 05
    .WORD EtherBoxString    ; 06
    .WORD SkillBoxString    ; 07

DrawCombatBox_L:
DrawCombatBox:
    STA btldraw_box_id
    STX btldraw_src            ; store source pointer (even if its garbage)
    STY btldraw_src+1          ; but this should always point to btl_unformattedstringbuf
    CMP #BOX_HPUPDATE
    BEQ @HPUpdate_EntryPoint   ; if just updating HP, skip all this
    BCS :+                     ; If the ID is above that, then X and Y are already pointing to the right spots
        PHA                       ; backup the box ID
        CMP #BOX_CONFIRM          ; is it the Confirm box?
        BNE @NormalBox            ; if not, jump ahead, otherwise...
            LDA battle_autoswitch ; 0 if ready, 1 if charge, 2 if running
        
       @NormalBox: 
        ASL A
        TAX
        LDA CombatBoxStrings_LUT+1, X
        STA btldraw_src+1
        LDA CombatBoxStrings_LUT, X
        STA btldraw_src
        PLA
        
  : PHA
    JSR ClearJigsBoxBuffer     ; make sure the box is empty before drawing text to it
    PLA    
    
    INC BattleBoxBufferCount   ; add this box to the buffer list
    LDX BattleBoxBufferCount    
    STA BattleBoxBufferList-1, X ; add this box ID to the list
   
   @HPUpdate_EntryPoint:    
    ASL A
    ASL A
    TAX
    LDA JigsDrawBox_LUT-8, X     ; get box width
    STA btldraw_width
    TXA 
    LSR A                      ; back to *2 
    TAX    
    LDA btldraw_width
    SEC                        ; set carry to add +1 
    ADC JigsDrawBoxAddress_LUT-3, X ; (+1) add box address (low)
    STA btldraw_dst
    LDA JigsDrawBoxAddress_LUT-4, X ; get box address (high)
    ADC #0                     ; add carry
    STA btldraw_dst+1
    
    JSR SetBtlDrawWidthCounter ; make sure strings don't write over the box borders
    JSR DrawBox_WaitForVBlank
    JSR FormatBattleString     ; decompress the string to the box's innards in RAM    
    JSR DrawBox_WaitForVBlank
   ; JSR WaitForVBlank
    JSR JigsBoxDrawToBuffer    ; copy the box to the screen buffer
    ;; also first copies the screen buffer to backup RAM
    ;; so that undrawing restores the exact tiles "behind" the box
    JSR BattleDrawMessageBuffer

DrawBox_WaitForVBlank:
    JSR Battle_UpdatePPU_UpdateAudio_FixedBank
    JMP WaitForVBlank    ; Wait for V Blank and do audio before trying to decompress the string





    
    
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  ClearUnformattedCombatBoxBuffer  [$F757 :: 0x3F767]
;;
;;  Clears it with *spaces*, not with null.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

ClearUnformattedCombatBoxBuffer:
    LDY #$80                ; pretty self explanitory routine
    LDA #$FF
    : STA btl_unformattedstringbuf-1, Y    ; fill buffer ($80 bytes) with $FF
      DEY
      BNE :-
    RTS
    



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  ShiftLeft routines  [$F897 :: 0x3F8A7]
;;
;;  Convenience routines to shift left a few times.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

ShiftLeft6:
    ASL A
ShiftLeft5:
    ASL A
ShiftLeft4:
    ASL A
    ASL A ; shifting left 3 times wouldn't save any bytes...
    ASL A
    ASL A
    RTS


;; JIGS - this one is easier than the Magic and Item Box, since it doesn't have to scroll.
;; So instead of drawing the whole string to somewhere DrawComplexString can write it out,
;; it just needs to get the shorthand control codes to decompress when drawing the box the first time!

DrawEquipBox_String:
    LDY #0                  ; Y = tiles in each row
    
    LDA #04
    STA tmp+1               ; row counter

    LDA btlcmd_curchar
    LSR A
    ROR A
    ROR A          ; Get the char stat index in X (00,40,80,C0)
    TAX                      ;  This will be the source index
   
  ;  Right, Left     ; FF, FF, 0D, item ID, FF, FF, FF, 0D, item ID, 01
  ;  Head,  Body     ;  0   1   2        3   4   5   6   7        8   9
  ;  Hands, Acc.
  ;  Item1, Item2
    
  @MainLoop:
    LDA #$FF
    STA btl_unformattedstringbuf, Y
    STA btl_unformattedstringbuf+1, Y
    STA btl_unformattedstringbuf+4, Y
    STA btl_unformattedstringbuf+5, Y
    STA btl_unformattedstringbuf+6, Y
    
    LDA #$0D                          ; put in the 0D control codes (for printing weapons and armor)
    STA btl_unformattedstringbuf+2, Y  
    STA btl_unformattedstringbuf+7, Y
    
    LDA ch_righthand, X
    BNE :+ 
    
   @NothingLeft:
    LDA #$19
    STA btl_unformattedstringbuf+2, Y ; replace the 0D control code with 19 control code
    LDA #$08                          ; 8 spaces
    BNE @AddToBufferLeft
 
  : SEC                               ; subtract 1 from the item ID
    SBC #1

   @AddToBufferLeft:
    STA btl_unformattedstringbuf+3, Y
    
    LDA ch_righthand+1, X
    BNE :+ 
    
   @NothingRight:
    LDA #$19
    STA btl_unformattedstringbuf+7, Y ; replace the 0F control code with 19 control code
    LDA #$08                          ; 
    BNE @AddToBufferRight
    
  : SEC
    SBC #1
    
   @AddToBufferRight:
    STA btl_unformattedstringbuf+8, Y

   @EndLine:
    LDA #$01
    STA btl_unformattedstringbuf+9, Y
    
    TYA
    CLC 
    ADC #10                           ; add 10 to the string buffer
    TAY    
    INX
    INX                               ; increment character index by 2 to look at the next 2 equipment pieces
    DEC tmp+1                         ; and decrement the row counter by 1
    BNE @MainLoop
    
    LDA #0
    STA btl_unformattedstringbuf, Y ; end the string
    RTS


DrawMagicBox_String:
    LDA #BANK_ITEMS
    JSR SwapPRG_L

    LDA #0
    STA tmp+5               ; spell level
    STA tmp+4               ; total spell counter
    STA tmp+3               ; magic list counter
    STA tmp+2               ; string position
    
   @MagicRowLoop: 
    LDX tmp+2
    LDA #$95                ; L
    STA btl_unformattedstringbuf, X
    LDA tmp+5               ; Row/spell level
    CLC
    ADC #$81                ; + 1, so that 0 = 1 and 9 = 8
    STA btl_unformattedstringbuf+1, X
    LDA #$FF                ; _
    STA btl_unformattedstringbuf+2, X
    
   @MagicLoop:              ; get the magic ID from the temp list and spell it out 
    LDA char_index
    CLC
    ADC tmp+4
    TAX
    LDA ch_spells, X
    BEQ @Blank
    TAX
    LDA lut_MagicNames_Low, X
    STA tmp
    LDA lut_MagicNames_High, X
    STA tmp+1

    LDX tmp+2
    LDY #0
   @MagicNameLoop:      ; do the name until the null terminator, then do a space after it
    LDA (tmp), Y
    BEQ :+
    STA btl_unformattedstringbuf+3, X
    INX
    INY
    BNE @MagicNameLoop
 
  : LDA #$FF
    STA btl_unformattedstringbuf+3, X
    INX
    BNE @Next
   
   @Blank:              ; inc tmp+5 every time there's an empty spell slot on this row
    LDX tmp+2
    LDA #$FF
    LDY #8
  : STA btl_unformattedstringbuf+3, X
    INX
    DEY
    BNE :-
   
   @Next:
    STX tmp+2
    INC tmp+3           ; do 3 spell names
    INC tmp+4           ; and inc the spell total
    LDA tmp+3
    CMP #3
    BNE @MagicLoop
   
    LDA #0
    STA tmp+3           ; reset the spell name row counter thingy

    LDA char_index
    CLC
    ADC tmp+5             ; spell level
    ADC #ch_mp - ch_stats ; MP offset
    TAY
    LDA ch_stats, Y       ; load the actual stat
    PHA                   ; back it up
    AND #$F0              ; get high bits (current mp)
    LSR A
    LSR A
    LSR A
    LSR A                 ; shift to low bits
    ORA #$80              ; add in #$80 to make it a numerical tile
    STA btl_unformattedstringbuf+3, X
    ; item_box+3 still, because we haven't incremented X for the first 3 tiles drawn
    
    LDA #$7A              ; / tile
    STA btl_unformattedstringbuf+4, X
    PLA 
    AND #$0F              ; restore MP byte, get low bits, add #$80
    ORA #$80
    STA btl_unformattedstringbuf+5, X
    
    LDA #$16              ; tells BattleFormatString to do a VBlank wait
    STA btl_unformattedstringbuf+6, X
    
    LDA #01               ; and end the row with the line break
    STA btl_unformattedstringbuf+7, X


    ;; all this should print:   
    ;; L#_MAGIC-1_MAGIC-2_MAGIC-3#(#/#)

    INC tmp+5
    TXA 
    CLC
    ADC #8
    STA tmp+2
    LDA tmp+4
    CMP #24             ; stop at 24 spells, 8 rows
    BEQ @Finish
    JMP @MagicRowLoop
    
   @Finish:
    LDA #0
    STA btl_unformattedstringbuf+127
    JMP SetCReturnBank



DrawItemBox_String:
    ;; JIGS - just enough changes from the menu version to make 
    ;; it difficult to copy-paste segments and have each routine JSR to them...

    LDX #$A0
    LDA #$FF
   @FillBlanks:
     STA btl_unformattedstringbuf-1, X             
     STA item_box, X ; holds item IDs
     DEX                           
     BNE @FillBlanks               
    
    STX btl_unformattedstringbuf+$8F ; set a 0 null terminator just in case.
    LDY #1           ; Y is our source index -- start it at 1 (first byte in the 'items' buffer is unused)

  @ItemFillLoop:
      LDA items, Y       ; check our item qty
      BEQ @IncSrc        ; if it's nonzero...
        TYA              ;  put this item ID in A
        CMP #TENT
        BEQ @IncSrc
        CMP #CABIN
        BEQ @IncSrc
        CMP #HOUSE
        BEQ @IncSrc      ; skip these 3 items
        
        STA item_box, X  ;  and write it to the item box buffer
        INX              ;  inc our dest index

    @IncSrc:
      INY                  ; inc our source index
      CPY #14              ; only 10 consumables for battle
      BNE @ItemFillLoop

  @StartDrawingItems:
    LDA #0
    ;STA item_box, X    ; put a null terminator at the end of the item box (needed for following loop)
    STA tmp+3          ; also reset the loop counter
    LDA #2             
    STA tmp+2          ; 2 for the letter position counter
   
  @DrawItemLoop:
    LDA #BANK_ITEMS
    JSR SwapPRG_L
  
    LDX tmp+3          ; get current loop counter and put it in X
    LDA item_box, X    ; index the item box to see what item name we're to draw
    ;BEQ @Exit          ; if the item ID is zero, it's a null terminator, which means we're done
    BMI @Exit          ; exit if it hits an $FF

    PHA                ; otherwise, back it up
    ;ASL A              ; then double the item ID
    TAX                ; and put it in X to index (will be used to index the string pointer table)

    LDA lut_ItemNames_Low, X   ; get the pointer to this item name
    STA tmp                     ;  and put it in (tmp)
    LDA lut_ItemNames_High, X
    STA tmp+1
    
    LDX tmp+2
    LDY #0

   @CopyLoop:
      LDA (tmp), Y         ; copy each character
      BEQ :+               ; stop at null terminator--don't copy it - X should be in the 9th slot for consumables now
      STA btl_unformattedstringbuf, X   
      INX 
      INY 
      BNE @CopyLoop
      
  : STX tmp+2               ; backup letter postion counter
    PLA                     ; restore the item ID number
    TAX                     ; put item ID in X
    LDA items, X            ; use it to index inventory to see how many of this item we have
    STA tmp                 ;  put the qty in tmp
    
    LDA #BANK_MENUS
    JSR SwapPRG_L           ; also swap to BANK_MENUS (for PrintNumber routines)
    JSR PrintNumber_2Digit  ; print the 2 digit number

    LDX tmp+2               ; restore letter position counter
    INX                     ; increase X to 10th slot
    LDA format_buf-2        ; copy the printed 2 digit number from the format buffer
    STA btl_unformattedstringbuf, X         
    INX                     ; increase X to the 11th slot
    LDA format_buf-1
    STA btl_unformattedstringbuf, X         
    INX
    LDA #01
    STA btl_unformattedstringbuf, X         ; put the line break in
    INX    
    INX
    INX                     ; INC X twice more, leaving the $FFs to make room for the cursor later
    STX tmp+2               ; save X position
    INC tmp+3               ; increment item counter
    BNE @DrawItemLoop       ; continue the loop!
   
  @Exit:  
    LDA #0
    STA btl_unformattedstringbuf+55

SetCReturnBank:  
    LDA #$0C
    STA ret_bank
    JMP SwapPRG_L
    

CommandString:
.BYTE $FF,$FF,$8F,$AC,$AA,$AB,$B7,$FF,$FF,$90,$B8,$A4,$B5,$A7,$01   ; "Fight__Guard"
.BYTE $FF,$FF,$96,$A4,$AA,$AC,$A6,$FF,$FF,$92,$B7,$A8,$B0,$B6,$01   ; "Magic__Items"
.BYTE $FF,$FF,$9C,$AE,$AC,$AF,$AF,$FF,$FF,$91,$AC,$A7,$A8,$FF,$01   ; "Skill__Hide_" 
.BYTE $FF,$FF,$90,$A8,$A4,$B5,$D4,$FF,$FF,$8F,$AF,$A8,$A8,$00       ; "Gear(sword)__Flee"


SkillBoxString:
.BYTE $FF,$FF,$14,$00,$01,$01
.BYTE $FF,$FF,$14,$01,$01,$01
.BYTE $FF,$FF,$14,$02,$01,$01
.BYTE $FF,$FF,$14,$03,$00

;; $9C, $AE, $AC, $AF, $AF ; "Skill" - for reference
  
PlayerBoxString:
.BYTE $04,$FF,$13,$00,$05,$7A,$13,$00,$06,$01 ; Name_CurrentHP/MaxHP
.BYTE $05,$FF,$13,$40,$05,$7A,$13,$40,$06,$01
.BYTE $06,$FF,$13,$80,$05,$7A,$13,$80,$06,$01
.BYTE $07,$FF,$13,$C0,$05,$7A,$13,$C0,$06,$00

EnemyRosterString:
.BYTE $08,$01  
.BYTE $09,$01  
.BYTE $0A,$01
.BYTE $0B,$00    

EtherBoxString:
.BYTE $95,$81,$FF,$FF,$15,$00,$FF,$95,$85,$FF,$FF,$15,$04,$01
.BYTE $95,$82,$FF,$FF,$15,$01,$FF,$95,$86,$FF,$FF,$15,$05,$01
.BYTE $95,$83,$FF,$FF,$15,$02,$FF,$95,$87,$FF,$FF,$15,$06,$01
.BYTE $95,$84,$FF,$FF,$15,$03,$FF,$95,$88,$FF,$FF,$15,$07,$00

ConfirmTurn:
.byte $01, $0F, BTLMSG_TURN, $17, $01, $01
.byte $0F, BTLMSG_READY, $01
.byte $0F, BTLMSG_YESNO, $00 

ConfirmCharge: 
.byte $01, $0F, BTLMSG_TURN, $17, $01, $01
.byte $0F, BTLMSG_CHARGE, $01
.byte $0F, BTLMSG_YESNO_EMPH, $00

ConfirmRunAway:
.byte $01, $0F, BTLMSG_TURN, $17, $01, $01
.byte $0F, BTLMSG_RUNAWAY_QUERY, $01
.byte $0F, BTLMSG_YESNO_UNSURE, $00

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  FormatBattleString  [$FA59 :: 0x3FA69]
;;
;;  input:   XY points to the buffer containing the null terminated string to draw
;;
;;    The source string can contain the following control codes:
;;
;;  00       = null terminator (marks end of string)
;;  01       = SINGLE line break
;;  02       = print attacker's name
;;  03       = print defender's name
;;  04       = print character 0's name
;;  05       = print character 1's name
;;  06       = print character 2's name
;;  07       = print character 3's name
;;  08       = print enemy roster entry 0
;;  09       = print enemy roster entry 1
;;  0A       = print enemy roster entry 2
;;  0B       = print enemy roster entry 3
;;  0C xx    = Magic name
;;  0D xx    = Equipment name
;;  0E xx    = Item name
;;  0F xx    = Draws a battle message.  xx = the ID to the battle message.  Note that this ID is
;;             1-based, NOT zero based like you'd expect
;;  10 xx    = Gold amount
;;  11 xx yy = yyxx is a number to print
;;  12       = converts btl_defender_index to name
;;  13 xx yy = print character stat, xx = character ID, yy = stat
;;  14 xx    = print skill text based on character, where xx = their skills
;;  15 xx    = print defender's MP stat, where xx = stat to print
;;  16       = force a VBlank wait before continuing
;;  17       = print battle turn
;;  18 xx yy = yyxx is a pointer to a number to print
;;  19 xx    = print a run of spaces.  xx = the run length   
;;
;;  Values >= $48 are printed as normal tiles.
;;
;;    Other values below $48 that are not control codes will either do nothing
;;  or will do a glitched version of one of the above codes.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

    
BattleStringDone:
    JMP SwapBtlTmpBytes     ; swap back the original btltmp bytes, then exit

FormatBattleString:   
    JSR SwapBtlTmpBytes     ; swap out btltmp bytes to back them up
    
    LDY #$00                ; copy the actual string data to a buffer in RAM
    : LDA (btldraw_src), Y  ;   (presumably so we can swap out banks without fear
      STA btl_stringbuf, Y  ;    of swapping out our source data)
      INY                   ;  this allows a buffer of 255 bytes
      BNE :-
      
    LDA #<btl_stringbuf     ; Change source pointer to point to our buffered
    STA btldraw_src         ;   string data
    LDA #>btl_stringbuf
    STA btldraw_src+1
    
    ; Iterate the string and draw each character
  @Loop:
    LDX #$00
    LDA (btldraw_src, X)        ; get the first char
    BEQ BattleStringDone        ; stop at the null terminator
    CMP #$01
    BNE :+
      LDA btldraw_width         ; get total width
      SEC
      SBC #2                    ; subtract the box sides
      SBC btldraw_width_counter ; subtract how many tiles are left to draw
      STA tmp                   ; tmp now = amount of tiles drawn on this row
      LDA btldraw_width         
      SEC
      SBC tmp                   ; A now = the amount of tiles to skip ahead by
      CLC
      ADC btldraw_dst           ; add in the current destination low byte
      ;ADC btldraw_width         ; and another full row
      STA btldraw_dst           ; save it
      LDA #0
      ADC btldraw_dst+1         ; and add the carry
      STA btldraw_dst+1
      JSR SetBtlDrawWidthCounter ; and reset the width counter
      JMP @IncPtr    
  : CMP #$7A
    BCC :+
      JSR DrawBattleString_DrawChar       ; if its definitely not a control code or DTE
      JMP @IncPtr
    
  : CMP #$48
    BCS :+
      JSR DrawBattleString_ControlCode    ; if <  #$48
      JMP @IncPtr
      
  : JSR DrawBattleString_ExpandChar

   @IncPtr:
    JSR DrawBattle_IncSrcPtr    ; Inc the source pointer and continue looping
    JMP @Loop


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  DrawBattleString_ExpandChar  [$FAA6 :: 0x3FAB6]
;;
;;  Takes a single character, expands it to top/bottom pair, and then draws it
;;     btldraw_dst = pointer to the output buffer
;;               A = char to draw
;;
;;  Most of this routine isn't used because the text printed in the US version
;;     does not have a top part.  Most of it is a big else/if chain to determine
;;     which top part to use.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

DrawBattleString_ExpandChar:

;; JIGS - http://www.romhacking.net/hacks/603
;; Credit goes to Lenophis for this fix! 
;; Adds DTE functions to battle text!

;    STA btltmp+$E   ; char code
;    PHA             ; backup A/X/Y
;    TXA
;    PHA
;    TYA
;    PHA
;    LDA btltmp+$E   ; get the char code
;    CMP #$7A        ;(are we beyond the DTE range?)

;; JIGS - no need to backup X I believe...?

    TAX
    TYA
    PHA
    TXA
    CMP #$7A
    BCS :+
    SEC
    SBC #$1A         ;(make DTE zero-based)
    TAX              ;(now the DTE index)
    PHA              ;(save our index, we'll need it again)
    LDA lut_DTE1, X  ;(load from DTE table 1)
    JSR DrawBattleString_DrawChar  ;(draw the letter)
    PLA              ;(our DTE index again)
    TAX
    LDA lut_DTE2, X  ;(load from DTE table 2)
  : JSR DrawBattleString_DrawChar  ;(draw the letter)
    PLA
    TAY
    RTS

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  DrawBattleString_DrawChar  [$FAF1 :: 0x3FB01]
;;
;;  Draws a single character to the output buffer
;; btldraw_dst = pointer to the output buffer
;;           X = top part of char
;;           A = bottom part of char
;;
;;  See DrawBattleSubString for explanation of top/bottom parts
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

DrawBattleString_DrawChar:
    LDY #$00
    STA (btldraw_dst), Y          ; draw the character to the buffer
    
DrawBattleString_IncDstPtr:
    DEC btldraw_width_counter
    BNE DrawBattleString_IncDst_Real

DrawBattleString_IncRow:
    JSR SetBtlDrawWidthCounter ; resets the width counter
    JSR DrawBattleString_IncDst_Real ; 1...
    JSR DrawBattleString_IncDst_Real ; 2...
    ;; flow: inc by 3 to start drawing to the next line (only 2 tiles of box sides to draw over, plus the current tile)

DrawBattleString_IncDst_Real:
    INC btldraw_dst
    BNE :+
      INC btldraw_dst+1
    : RTS  

SetBtlDrawWidthCounter:
    LDA btldraw_width
    SEC     
    SBC #$02                   ; 2 offsets the box borders
    STA btldraw_width_counter  ; when it reaches 0, you've reached the end of the box     
    RTS

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  DrawBattle_Division   [$FAFC :: 0x3FB0C]
;;
;;    Kind of a junky division routine that is used by FormatBattleString
;;  to draw numerical values.
;;
;;  end result:
;;                  A = btltmp6,7 / YX
;;          btltmp6,7 = btltmp6,7 % YX   (remainder)
;;
;;    This division routine is a simple "keep subtracting until we
;;  fall below zero".  Which means that if btltmp+6,7 is zero, the
;;  routine will loop forever and the game will deadlock.  This routine
;;  is kind of junky.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

DrawBattle_Division:
    LDA #$00
    STA btltmp+8    ; initialize result with zero
  @Loop:
    STX btltmp+9
    LDA btltmp+6
    SEC
    SBC btltmp+9
    PHA             ; low byte = $99-X, back it up
    
    STY btltmp+9
    LDA btltmp+7
    SBC btltmp+9    ; high byte = $97-Y
    
    BMI @Done       ; if result is negative, we're done
    
    INC btltmp+8    ; otherwise, increment our result counter
    STA btltmp+7    ; overwrite btltmp+6 with the result of the subtraction
    PLA
    STA btltmp+6
    JMP @Loop       ; and keep going until we fall below zero
    
  @Done:            ; once the result is negative
    PLA             ; throw away the back-up byte
    LDA btltmp+8    ; and put the result in A before exiting
    RTS

    

DrawPlayerHP:
  ;  LDA #8
  ;  STA tmp+9 ; DrawPlayerHPCounter

    JSR DrawBattle_IncSrcPtr
    LDA (btldraw_src), Y     ; get the char index from the string
    STA char_index
    LDA #BANK_MENUS
    JSR SwapPRG_L
    JSR DrawBattle_IncSrcPtr
    LDA (btldraw_src), Y
    JSR PrintCharStat
    LDA format_buf-3
    JSR DrawBattleString_DrawChar
    LDA format_buf-2
    JSR DrawBattleString_DrawChar
    LDA format_buf-1
    JMP DrawBattleString_DrawChar   ; and print it
    ;JSR DrawBattleString_DrawChar
    
    ;; JIGS - ...wait, how did this fix the issue?
    ;; If it was loading 8 into tmp+9 every time this was called?
    ;; Since this routine only does 3 tiles?!
    ;; Meaning its called twice per HP update (current and max)...
    ;; so it would never really decrement 8 times...!? Wah
    
    ;; fix for dropped music frames:
    ;; Player HP is converted 8 times (4 characters, current HP / Max HP)
    ;; This takes up quite a few scanlines for some reason,
    ;; and after doing this, whatever routines that follow don't wait for VBlank and 
    ;; do music soon enough, resulting in a frame (possibly 2?) of music not updating
    ;; So every time an HP number is converted from hex to decimal,
    ;; It decreases the counter from 8, and when it hits 0, it forces a frame/audio update
    
 ;   DEC tmp+9 ; DrawPlayerHPCounter
 ;   BNE :+
 ;   
 ;   JSR WaitForVBlank
 ;   JSR CallMusicPlay
 ;   
 ; : RTS


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  DrawBattleString_ControlCode  [$FB96 :: 0x3FBA6]
;;
;;    Print a control code.  See FormatBattleString for details
;;  A = the control code
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

 


DrawBattleString_ControlCode:
    CMP #$02
    BEQ @PrintAttacker             ; code:  02
    CMP #$03
    BEQ @PrintDefender             ; code:  03
    CMP #$08
    BCC @PrintCharacterName        ; codes: 04-07
    CMP #$0C
    BCC @PrintRoster               ; codes: 08-0B
    CMP #$11                       
    BCC @PrintItemName             ; codes: 0C-10
    JMP @DrawBattleString_ControlCode_2
    
   @PrintAttacker:       ; code: 02
    LDA btl_attacker
    JMP DrawEntityName
    
   @PrintDefender:       ; code: 03
    LDA btl_defender
    JMP DrawEntityName
    
   @PrintDefenderIndex:  ; code: 12 
    LDA btl_defender_index  
    JMP :+
  
   @PrintCharacterName:  ; codes:  04-07
    SEC
    SBC #$04            ; subtract 4 to make it zero based
  : ORA #$80            ; OR with $80 to make it a character entity ID
    JMP DrawEntityName  ; then print it as an entity

    ; Print an entry on the enemy roster
   @PrintRoster:             ; codes: 08-0B
    SEC                     ; subtract 8 to make it zero based
    SBC #$08
    TAX
    LDA btl_enemyroster, X  ; get the roster entry
    CMP #$FF
    BEQ @Exit               ; if 'FF', that signals an empty slot, so don't print anything.
    JSR DrawEnemyName       ; then draw that enemy's name
    JMP DrawEnemyNumber        
   
   @Exit:
    RTS
  
   @PrintItemName:          ; code:  0E
    PHA 
    LDA #BANK_ITEMS
    JSR SwapPRG_L   
    PLA
    JSR BattleDraw_LoadObjectNamePtr
    JMP DrawBattleSubString

 @DrawBattleString_ControlCode_2:
    BEQ @DrawBattleString_Number  ; code:  11
    CMP #$12
    BEQ @PrintDefenderIndex       ; code:  12
    CMP #$13
    BEQ @DrawPlayerHP             ; code:  13
    CMP #$14
    BEQ @PrintSkill               ; code:  14
    CMP #$15
    BEQ @DrawPlayerMP             ; code:  15
    CMP #$17
    BEQ @PrintBattleTurnNumber    ; code:  17
    CMP #$18
    BEQ @DrawBattleNumber_Indirect ; code:  18
    CMP #$19
    BEQ @DrawString_SpaceRun       ; code:  19
    ;; and if its 16-47, do a VBlank.
    JMP DrawBox_WaitForVBlank
    
   @PrintSkill:  
    JSR DrawBattle_IncSrcPtr
    LDA (btldraw_src), Y         ; load it - it should be 0, 1, 2, 3
    CLC
    ADC char_index               ; add their index ($00, $40, $80, $C0)
    TAX
    LDA ch_skills, X             ; put in X, then load that skill byte, which is an ID
    BNE @ContinueSkill
    LDX #10
    BNE @DrawString_SpaceRun_FromSkill
    
   @ContinueSkill: 
    CLC
    ADC #ITEM_SKILLSTART-1       ; then add the skill name offset
    STA (btldraw_src), Y         ; replace the just-loaded byte in the source
    DEC btldraw_src              ; then decrement it so the next increment will re-load this byte
    LDA #$0E                     ; then use the item name code
    JMP @PrintItemName           ; and print it as an item
    
   @DrawPlayerHP:
    JMP DrawPlayerHP

  @PrintBattleTurnNumber:
    LDA #BANK_MENUS
    JSR SwapPRG_L
    JSR PrintBattleTurn
    LDA format_buf-2
    JSR DrawBattleString_DrawChar 
    LDA format_buf-1
    JMP DrawBattleString_DrawChar 
    
  @DrawBattleString_Number:         ; print a number 
    JSR DrawBattle_IncSrcPtr        ;   pointer to the number to print is in the source string
    LDA btldraw_src
    STA btldraw_subsrc              ; since the number is embedded in the source string, just use
    LDA btldraw_src+1               ; the pointer to the source string as the pointer to the number
    STA btldraw_subsrc+1
    JSR DrawBattle_IncSrcPtr
    JMP DrawBattle_Number

   @DrawPlayerMP:
    ;LDA submenu_targ              ; set by the item box or opening the magic menu in battle
    ;JSR ShiftLeft6
    ;STA char_index
    ;; should be set in BattleSubMenu_Magic now
   
    LDA #BANK_MENUS
    JSR SwapPRG_L
    JSR DrawBattle_IncSrcPtr      ; inc the pointer to get the spell level
    LDA (btldraw_src), Y          ; load it
    PHA                           ; back it up
    CLC           
    ADC #$2C                      ; add the current MP stat byte to it
    JSR PrintCharStat
    LDA format_buf-1
    JSR DrawBattleString_DrawChar ; draws current MP 
    LDA #$7A
    JSR DrawBattleString_DrawChar ; draws / 
    PLA                           ; spell level byte
    CLC
    ADC #$34                      ; add maximum MP stat byte to it
    JSR PrintCharStat
    LDA format_buf-1    
    JMP DrawBattleString_DrawChar ; draws max MP 
    
   @DrawBattleNumber_Indirect:  ; print a number (indirect)
    JSR DrawBattle_IncSrcPtr
    LDA (btldraw_src), Y        ; pointer to a pointer to the number to print
    STA btldraw_subsrc
    JSR DrawBattle_IncSrcPtr
    LDA (btldraw_src), Y
    STA btldraw_subsrc+1
    JMP DrawBattle_Number       ; flow into this routine

   @DrawString_SpaceRun:
    JSR DrawBattle_IncSrcPtr    ; inc ptr
    LDA (btldraw_src), Y        ; get the run length
    TAX
   @DrawString_SpaceRun_FromSkill:     
    LDA #$FF                    ; blank space tile
    : STA (btldraw_dst), Y    
      JSR DrawBattleString_IncDstPtr
      DEX
      BNE :-
    RTS    

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  DrawBattle_Number  [$FB3D :: 0x3FB4D]
;;
;;  Converts a number to text and prints it (for FormatBattleString)
;;
;;  input:
;;    btldraw_subsrc = pointer to the 2-byte number to draw.
;;    Y should be 0 upon entry
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


DrawBattle_Number:
    LDA (btldraw_subsrc), Y     ; get the number to print, stuff it in $96,97
    STA btltmp+6
    INY
    LDA (btldraw_subsrc), Y
    STA btltmp+7
    
    LDX #<10000
    LDY #>10000
    JSR DrawBattle_Division
    STA btltmp+$A                     ; start pulling digits out and stuff them in $9A
    LDX #<1000
    LDY #>1000
    JSR DrawBattle_Division
    STA btltmp+$B
    LDX #<100
    LDY #>100
    JSR DrawBattle_Division
    STA btltmp+$C
    LDX #<10
    JSR DrawBattle_Division
    STA btltmp+$D
    
    LDX #$00
  @FindFirstDigit:
    LDA btltmp+$A, X          ; keep getting individual digits  (note that INX is done before 
    INX                 ;    this digit is printed, so we have to read from $9A-1 when printing)
    CPX #$05            ; skip ahead to printing the 1's digit 
    BEQ @OnesDigit      ;  if we've exhausted all 5 digits.
    ORA #$00            ; Otherwise, check this digit (OR to update Z flag)
    BEQ @FindFirstDigit ;  if it's zero, don't print anything, and move to next digit
    
  @PrintDigits:
    LDA btltmp+9, X            ; get the digit
    ORA #$80                ; OR with #$80 to get the tile
    JSR DrawBattleString_DrawChar
    INX
    CPX #$05
    BNE @PrintDigits            ; loop until only the 1s digit is left
    
  @OnesDigit:
    LDA btltmp+6                    ; fetch the 1s digit
    ORA #$80
    JMP DrawBattleString_DrawChar   ; and print it    

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  BattleDrawLoadSubSrcPtr  [$FC00 :: 0x3FC10]
;;
;;  input:       XA = 16-bit pointer to the start of a pointer table
;;
;;  output:  btldraw_subsrc
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

BattleItemName_LUT_Low:
    .word lut_MagicNames_Low      ; $0C
    .word lut_EquipmentNames_Low  ; $0D
    .word lut_ItemNames_Low       ; $0E
    .word lut_BattleMessages_Low  ; $0F
    .word lut_GoldNames_Low       ; $10
    
BattleItemName_LUT_High:
    .word lut_MagicNames_High     ; $0C
    .word lut_EquipmentNames_High ; $0D
    .word lut_ItemNames_High      ; $0E
    .word lut_BattleMessages_High ; $0F    
    .word lut_GoldNames_High      ; $10    

BattleDraw_LoadObjectNamePtr:
    SEC
    SBC #$0C                    ; turn control code into 0-based
    ASL A
    TAX
    LDA BattleItemName_LUT_Low, X
    STA btltmp+6
    LDA BattleItemName_LUT_Low+1, X
    STA btltmp+7
    LDA BattleItemName_LUT_High, X
    STA btltmp+8
    LDA BattleItemName_LUT_High+1, X
    STA btltmp+9
    
    JSR DrawBattle_IncSrcPtr
    LDA (btldraw_src), Y    ; get the desired index    
    TAY
    LDA (btltmp+6), Y
    STA btldraw_subsrc
    LDA (btltmp+8), Y
    STA btldraw_subsrc+1
    RTS



;
; STA btltmp+7 ; $97      ; high byte of pointer table
; 
; JSR DrawBattle_IncSrcPtr
; LDA (btldraw_src), Y    ; get the desired index
;
; ASL A                   ; multiply by 2 (2 bytes per pointer)
; PHP                     ; backup the carry
; STA btltmp+6            ; use as low byte
; 
; TXA                     ; get X (low byte of pointer table)
; CLC
; ADC btltmp+6            ; add with low byte of index
; STA btltmp+6            ; use as final low byte
; 
; LDA #$00                ; add the carry from the X addition
; ADC btltmp+7   
; PLP                     ; also add the carry from the above *2
; ADC #$00
; STA btltmp+7            ; use as final high byte
; 
; LDY #$00                ; get the pointer, store in btldraw_subsrc
; LDA (btltmp+6), Y
; STA btldraw_subsrc
; INY
; LDA (btltmp+6), Y
; STA btldraw_subsrc+1
; 
; RTS    


    
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  DrawEntityName  [$FC4F :: 0x3FC5F]
;;
;;  input:
;;            A = ID of enemy slot or player whose name to draw
;;  btldraw_dst = pointer to draw to
;;
;;  If A has the high bit set, the player name is drawn
;;  Otherwise, A is the enemy slot whose name we're to draw
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

DrawEntityName:
    BPL @Enemy                  ; if high bit is clear, it's an enemy
    
    ; otherwise, it's a player
    AND #$03                    ; mask out the low bits to get the player ID
    LSR A                      ; LSR instead of ROR to clear carry
    ROR A
    ROR A                      ; convert low 2 bits to $00, $40, $80, or $C0
    ADC #ch_name - ch_stats    ; add in name byte
    STA btldraw_subsrc         ; save as low byte
    LDA #>ch_stats             ; high byte is always the same for stats
    STA btldraw_subsrc+1
    
    LDY #$00
    @Nameloop:
      LDA (btldraw_subsrc), Y           ; draw each character in the character's name
      JSR DrawBattleString_ExpandChar
      INY
      CPY #$07                          ; JIGS - 7 letter names!
      BNE @Nameloop
      RTS
    
  @Enemy:
    LDX #28
    JSR MultiplyXA
    TAX
    LDA btl_enemystats + en_enemyid, X ; JIGS - enemy ID is the last one, so no need to + it


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  DrawEnemyName  [$FC7A :: 0x3FC8A]
;;
;;  input:
;;            A = ID of enemy whose name to draw
;;  btldraw_dst = pointer to draw to
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

DrawEnemyName:
    TAX
    LDA #BANK_ENEMYNAMES
    JSR SwapPRG_L           ; swap in bank with enemy names
    
    LDA lut_EnemyNames_Low, X      ; get source pointer from pointer table
    STA btldraw_subsrc
    LDA lut_EnemyNames_High, X
    STA btldraw_subsrc+1
    
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  DrawBattleSubString  [$FC94 :: 0x3FCA4]
;;
;;  btldraw_subsrc = pointer to read from
;;  btldraw_dst = pointer to draw to
;;  btldraw_max = maximum number of characters to draw
;;
;;  Note that this routine seems to be built for the Japanese game where characters
;;    could consist of 2 parts.  For example the Hiragana GU is the same as KU with an
;;    additional quote-like character drawn above it.  As such, each character is drawn
;;    with a "top part" and a "bottom part"
;;
;;  In the US version, the top part is never used, and is just a blank space.  So a good
;;    portion of DrawBattleString_ExpandChar is now worthless and could be trimmed out.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

DrawBattleSubString:
    LDY #$00
  @Loop:
    LDA (btldraw_subsrc), Y         ; get a byte of text
    BEQ @Exit                       ; if null terminator, exit
    JSR DrawBattleString_ExpandChar ; Draw it
    INY                             ; keep looping until null terminator is found
    JMP @Loop
    
  @Exit:
    LDA battle_bank                 ; swap back to battle bank
    JMP SwapPRG_L                   ;   and exit

    
    
    
DrawEnemyNumber:    
    LDY #0
    STY btl_enemyamount
    
    LDA (btldraw_src), Y    ; should still be the enemy roster code?
    SEC
    SBC #08
    TAX
  @Loop:  
    LDA btl_enemyIDs, Y     ; get enemy slot
    CMP btl_enemyroster, X  ; if it matches the name on the roster, increase enemy counter
    BNE @NextEnemy
    
    INC btl_enemyamount     ; otherwise, its a match, so add 1 more enemy
    
   @NextEnemy:
    INY
    CPY #9
    BNE @Loop
    
   @NoMoreEnemies:
    LDA btl_enemyamount
    CMP #2
    BCS :+
        LDA #$7F
        STA btl_enemyamount
        ;; if there's less than 2 enemies, (only one), print a space instead of a number
        ;; ORA #$80 will make this $FF
    
  : LDA btldraw_width_counter     ; see if the destination is at the edge of the roster box
    CMP #1                        ; if it is, print the number
    BEQ :+                        ; if its not, print spaces until it reaches it
    LDA #$FF
    JSR DrawBattleString_DrawChar
    JMP :-
    
  : LDA btl_enemyamount
    ORA #$80                      ; convert the amount to a number
    JMP DrawBattleString_DrawChar ; and print it
    
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Lut to get a character's name by their index  [$FCAA :: 0x3FCBA]

;lut_CharacterNamePtr:
;  .WORD ch_name
;  .WORD ch_name+$40
;  .WORD ch_name+$80
;  .WORD ch_name+$C0
  


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  DrawBattle_IncSrcPtr  [$FCB2 :: 0x3FCC2]
;;
;;  Inrements the source pointer.  Also resets Y to zero so that
;;  the next source byte can be easily read.  Why this routine doesn't also
;;  read the source byte is beyond me.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

DrawBattle_IncSrcPtr:
    LDY #$00
    INC btldraw_src
    BNE :+
      INC btldraw_src+1
  : RTS

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  UNUSED_DrawBattle_IncSrcPtr  [$FCBB :: 0x3FCCB]
;;
;;  Incremenets the sub source pointer by 1 for the Battle Drawing routine(s)
;;
;;  Does not appear to be used by anywhere in the game.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;UNUSED_DrawBattle_IncSrcPtr:
;    INC btldraw_subsrc
;    BNE :+
;      INC btldraw_subsrc+1
;  : RTS

;; JIGS - unused


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  DrawBattleString_IncDstPtr  [$FCC2 :: 0x3FCD2]
;;
;;  Incremenets the destination pointer by 2 for the DrawBattleSubString routine(s)
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;DrawBattleString_IncDstPtr:
;    INC btldraw_dst
;    BNE :+
;      INC btldraw_dst+1
;  : INC btldraw_dst
;    BNE :+
;      INC btldraw_dst+1
;  : RTS


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  SwapBtlTmpBytes  [$FCCF :: 0x3FCDF]
;;
;;  Backs up the btltmp bytes by swapping them into another place in memory
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

SwapBtlTmpBytes_L:
SwapBtlTmpBytes:
;   PHA         ; backup A,X7
;   TXA
;   PHA
    
    LDX #$0F
  @Loop:
      LDA btltmp, X             ; swap data from btltmp with btltmp_backseat
      PHA
      LDA btltmp_backseat, X
      STA btltmp, X
      PLA
      STA btltmp_backseat, X
      DEX
      BPL @Loop
      
;    PLA         ; restory A,X
;    TAX
;    PLA
    RTS
    
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  BattleRNG  [$FCE7 :: 0x3FCF7]
;;
;;    This routine is basically like C's 'rand()' function.  It updates an RNG state (btl_rngstate), and uses
;;  That state to produce a random 8-bit value.
;;
;;    To generate the value, it simply runs the state through a scrambling lut.  What's strange is that it uses
;;  it's own LUT and not the LUT at $F100.  Why it has 2 separate luts to do the same thing is beyond me.
;;
;;    IMPORTANT NOTE!!!!  ChaosDeath in bank B assumes that calling this routine 256 times consecutively will
;;  produce every value between 00,FF.  As a result, this RNG must not have a period longer than 256.  This
;;  means a more complex RNG cannot really be implemented here.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

BattleRNG_L: 
BattleRNG:
    LDX btl_rngstate
    INC btl_rngstate
    LDA lut_RNG, X
    RTS
    
;  @Scramble_lut:
;    .INCBIN "bin/0F_FCF1_rngtable.bin"


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  SetMMC1SwapMode  [$FE06 :: 0x3FE16]
;;
;;   Sets current MMC1 swap/mirroring modes
;;
;;  IN:   A = desired mode
;;
;;  OUT:  A = A>>4
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;SetMMC1SwapMode:
;    STA $9FFF    ; MMC1 registers must be written to 1 bit at a time
;    LSR A        ;  low bit first
;    STA $9FFF    ; To accomplish this, you write, then shift,
;    LSR A        ; then write, then shift.. etc.  5 writes total
;    STA $9FFF
;    LSR A
;    STA $9FFF
;    LSR A
;    STA $9FFF
;    RTS

;; JIGS - uneeded for MMC5! of course.

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  SwapPRG  [$FE1A :: 0x3FE2A]
;;
;;   Swaps so the desired bank of PRG ROM is visible in the $8000-$BFFF range
;;
;;  IN:   A = desired bank to swap to (00-0F)
;;
;;  OUT:  A = 0
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;SwapPRG:
;    STA $FFF9    ; same deal as SetMMC1SwapMode.. write/shift/write...
;    LSR A
;    STA $FFF9
;    LSR A
;    STA $FFF9
;    LSR A
;    STA $FFF9
;    LSR A
;    STA $FFF9
;    RTS

;; JIGS - and the MMC5 swaps banks differently too! Thanks to Disch for this code.
    
SwapPRG_L:  
SwapPRG:  
  STA actual_bank ; JIGS - see LongCall 
  ASL A       ; Double the page number (MMC5 uses 8K pages, but FF1 uses 16K pages)
  ORA #$80    ; Turn on the high bit to indicate we want ROM and not RAM
  STA $5115   ; Swap to the desired page
  LDA #0      ; IIRC Some parts of FF1 expect A to be zero when this routine exits
  RTS    
  
  

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Entry / Reset  [$FE2E :: 0x3FE3E]
;;
;;   Entry point for the program.  Does NES and mapper prepwork, and gets
;;   everything started
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

OnReset:
    SEI            ; Set Interrupt flag (prevent IRQs from occuring)
   
    LDA #0    
    LDX #0
   @ResetRAM:
    STA $0000, X
    STA $0200, X
    STA $0300, X
    STA $0400, X
    STA $0500, X
    STA $0600, X
    STA $0700, X
    INX
    BNE @ResetRAM

    STA $2000      ; Disable NMIs
    ;STA soft2000
    LDA #$06
    STA $2001      ; disable Spr/BG rendering (shut off PPU)
    CLD            ; clear Decimal flag (just a formality, doesn't really do anything)

    LDX #$02       ; wait for 2 vblanks to occurs (2 full frames)
  @Loop: 
      BIT $2002      ;  This is necessary because the PPU requires some time to "warm up"
      BPL @Loop      ;  failure to do this will result in the PPU basically not working
      DEX
      BNE @Loop

    ;; JIGS - this is an MMC5 change!
      
    STX $5010      ; Disable MMC5 PCM and IRQs
    STX $5204      ; Disable MMC5 scanline IRQs
    STX $5130      ; Check doc on MMC5 to see what this does
    STX $5113      ; swap battery-backed PRG RAM into $6000 page.     
    STX $5200      ; disable split-screen mode
    STX $5101      ; 8k CHR swap mode (no swapping)
    STX $5127      ; Swap in first CHR Page
    INX            ; 01
    STX $5100      ; 16k PRG-RAM swap
    STX $5103      ; Allow writing to PRG-RAM B  
    INX            ; 02
    STX $5102      ; Allow writing to PRG-RAM A
    STX $5104      ; ExRAM mode Ex2   
    LDX #$44
    STX $5105      ; Vertical mirroring
    LDX #$FF        
    STX $5117

    LDA #0
    STA $4016      ; clear joypad strobe??  This seems like an odd place to do it since it doesn't read joy data here  =P
    ;STA $4015      ; turn off all sound channels
    ;STA $5015      ; turn off all MMC5 sound channels
    ;; JIGS - Disable APU comes right after this so... not sure why its here still, but oh well!
    
    STA $4010      ; disble DMC IRQs
    LDA #$C0
    STA $4017      ; set alternative pAPU frame counter method, reset the frame counter, and disable APU IRQs

    TXS            ; transfer it to the Stack Pointer (resetting the SP)

    JSR ClearPalette   ; set all palettes to black
    JSR DrawPalette_L
    JSR DisableAPU     ;; JIGS - moved this here

    ;LDA #$06           ; swap to bank 6 again (even though we just did) .. but why?  We never use
    ;JSR SwapPRG        ;   anything in bank 6
    JMP GameStart_L    ; jump to the start of the game!




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;   Wait for VBlank [$FEA8 :: 0x3FEB8]
;;
;;    This does an infinite loop in wait for an NMI to be triggered
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

WaitForVBlank_L:
WaitForVBlank:
    LDA $2002      ; check VBlank flag
    BPL @Wait      ; if off, VBlank hasn't occured yet, so jump to the wait
                   ;  otherwise... whatever code occured since the last frame took longer than
                   ;  1 frame... so...

    LDA #0         ; waste time in this loop for a while...
  @Loop:
      SEC          ; the reason for this is because the game doesn't want NMI to fire during VBlank
      SBC #$01     ;  because then you'd have less than a full VBlank for drawing next frame
      BNE @Loop    ;  Of course... just reading $2002 above will prevent this from happening, so this isn't
                   ;  really necessary, but it doesn't hurt.

  @Wait:
    LDA soft2000   ; Load desired PPU state
    ORA #$80       ; flip on the Enable NMI bit
    STA $2000      ; and write it to PPU status reg
    
    LDA InBattle
    BEQ OnIRQ
        LDA #159
        STA $5203
        LDX BattleBGColor
        LDY BattleBackgroundColor_LUT, X

OnIRQ:             ; IRQs point here, but the game doesn't use IRQs, so it's moot    
@LoopForever:
    LDA $5204      ; JIGS - high bit set when scanline #160 is being drawn
    BPL @LoopForever
    
   @Scanline:   
    LDX #$0D   ; waits for H-blank so as not to draw weird dots on the screen
  : DEX        ; $0D seems the best so far!
    BNE :-    
    LDA $2002  ; reset toggle
    LDA #$3F   ; set PPU addr to point to palette
    STA $2006    
    STX $2001  ; X = 0, turn off screen 
    LDA #$0E
    STA $2006
    STY $2007  ; write Y to palette $3F0E

    ;; scroll setting?
    LDY #$02
    LDA #$80
    STY $2006
    STA $2006  
    LDA btl_soft2001 ;#$1E
    STA $2001  ; turn on screen

    LDA soft2000
    ORA #$90       ; make background tiles use the sprites!
    STA $2000
    
    LDA #$00       
    STA $5203      ; Clear trigger 

   @ContinueLooping: 
    BEQ @LoopForever     ; then loop forever! (or really until the NMI is triggered)
    
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;   NMI Vector [$FE9C :: 0x3FEAC] 
;;
;;     This is called when an NMI occurs.  FF1 has a bizarre way
;;    of doing NMIs.  It calls a Wait for VBlank routine, which enables
;;    NMIs, and does an infinite JMP loop.  When an NMI is triggered,
;;    It does not RTI (since that would put it back in that infinite
;;    loop).  Instead, it tosses the RTI address and does an RTS, which
;;    returns to the area in code that called the Wait for Vblank routine
;;
;;     Changes to this routine can impact the timing of various raster effects,
;;    potentially breaking them.  It is recommended that you don't change this
;;    routine unless you're very careful.  Unedited, this routine exits no earlier
;;    than 37 cycles after NMI (30 cycles used in this routine, plus 7 for the NMI)
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

OnNMI:
    ;; if in Battle, set the one palette to grey at the start of VBlank
    LDA InBattle
    BEQ @NoBattle
        LDX #0
        LDY #$10    
        LDA #$3F   ; set PPU addr to point to palette
        STA $2006
        LDA #$0E
        STA $2006
        STX $2001 ; X = 0, turn off screen 
        LDA #$20
        STY $2007  ; write Y to palette $3F0E
        LDA btl_soft2001
        STA $2001  ; turn on screen, or whatever btl_soft2001 is set to do (it is off before fade in)
        LDY #$0
        LDA ScreenShakeCounter ; is screen still shaking?
        BEQ :+                 ; if yes...
            LDY tmp+11         ; update scroll with these instead
            LDX tmp+12
      : STY $2005
        STX $2005  ; update scroll
        

   @NoBattle:
    LDA soft2000
    STA $2000      ; set the PPU state
    LDA $2002      ; clear VBlank flag and reset 2005/2006 toggle
    PLA
    PLA
    PLA            ; pull the RTI return info off the stack
    RTS            ; return to the game

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;   Clear BG Palette [$FEBE :: 0x3FECE]
;;
;;     This routine resets the BG palette to all black (0F)
;;
;;;;

ClearSpritePalette:
    LDA #$0F
    BNE :+

ClearPalette:
    LDA #$FF
  : STA PaletteFade
    
    LDX #$1F
    LDA #$0F

  @Loop:
    STA cur_pal, X ; write 0F black to the palette
    DEX
    CPX PaletteFade
    BNE @Loop   ; repeat $10 times (entire BG palette)
    BEQ ResetRAMSwap


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Dim Battle Sprite Palettes [$FF20 :: 0x3FF30]
;;
;;    Dims the battle sprite palettes (first two sprite palettes)
;;  by 1 shade.
;;
;;  OUT:  C = set if some colors are still not black
;;            clear if all colors have been dimmed to black
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

DimBG: 
    LDX #$10           ; start with BG palettes
    LDA #0
    BEQ DimPalette

DimAll:
    LDX #$1F           ; X will be our loop down counter and palette index
    LDA #$0
    BEQ DimPalette     ; stop when the palette fade routine hits 0

DimSprites:
    LDX #$1F           ; X will be our loop down counter and palette index
    LDA #$10           ; stop when it hits $10 (only does the sprites)
    
DimPalette:
    STA PaletteFade
    LDY #0             ; Y will count how many colors are not yet black
  @Loop:
    LDA cur_pal, X     ; get color in current palette
    CMP #$0F           ; check if it's black ($0F)
    BEQ @Skip          ; if it is... skip it

    SEC
    SBC #$10           ; otherwise, subtract $10 (dim it)
    BPL :+             ; if that caused it to dro below zero...
      LDA #$0F         ; ...replace it with black ($0F)
:   STA cur_pal, X     ; write the new color back to the palette
    INY                ; and increment Y to mark this color as not fully dimmed yet

  @Skip:
    DEX                ; decrement the loop counter
    CPX PaletteFade    ; see if it reaches the limit set previously
    BNE @Loop          ; and keep looping until it reaches 0 (only 7 iterations because color 0 is transparent)
    CPY #$01           ; set C if Y is nonzero (to indicate some colors are not yet black)
    
ResetRAMSwap:
    LDA #0
    STA RAMSwap
    RTS
    

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Brighten Battle Sprite Palettes  [$FF40 :: 0x3FF50]
;;
;;    Opposite of above routine.  Brightens the battle sprite palettes
;;  by 1 shade.
;;
;;  OUT:  C = set if some colors are still not back to normal ('fully brightened')
;;            clear if all colors are back to normal.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


BrightenBG:
    LDX #$0F           ; start with BG palettes
    LDA #$FF
    BNE BrightenPalettes

BrightenAll:
    LDX #$1F           ; X will be our loop down counter and palette index
    LDA #$FF
    BNE BrightenPalettes     ; stop when the palette fade routine hits 0

BrightenSprites:
    LDX #$1F
    LDA #$0F

BrightenPalettes:
    STA PaletteFade
    LDY #0              ; Y will count how many colors are not fully brightened
  @Loop:
    LDA cur_pal, X      ; get the current color in the palette
    CMP tmp_pal, X      ; compare it to our backed up palette
    BEQ @Skip           ; if it matches.. color is already restored.  Skip it

    CMP #$0F            ; otherwise check to see if the color is black
    BNE @AddBright      ; if not black... just add to the color's brightness

    LDA tmp_pal, X      ; if black... get the desired color
    AND #$0F            ;  and mask out the low bits so we have the darkest shade of that color
    BPL @SetClr         ;  jump ahead (always branches)

  @AddBright:
    CLC
    ADC #$10            ; add one shade to the color's brightness

 @SetClr:
    STA cur_pal, X      ; write this color back to the palette
    INY                 ; and increment Y to count this color as not fully brightened yet

 @Skip:
    DEX                 ; decrement X and loop until it expires
    CPX PaletteFade
    BNE @Loop

    CPY #$01            ; then set C if Y is nonzero (to indicate not all colors are fully bright)
    JMP ResetRAMSwap

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Back Up Battle Sprite Palettes [$FF64 :: 0x3FF74]
;;
;;    Copies the battle sprite palettes to the temp palette
;;  so that they can be restored easily later
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

BackUpPalettes:
    LDX #$1F            ; X is our loop counter.  Going to back up B colors (color 0 is transparent)
  @Loop:
    LDA cur_pal, X      ; copy the color...
    STA tmp_pal, X
    DEX                 ; decrement X
    BPL @Loop           ; loop until X expires
    RTS                 ; then exit

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Palette Frame  [$FF70 :: 0x3FF80]
;;
;;    Updates the palette and does a frame.
;;  Frame is very minimal.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

PaletteFrame:
    JSR WaitForVBlank_L      ; Wait for VBlank
    JSR DrawPalette_L        ; then update the palette
    LDA #0                   ; reset the scroll
    STA $2005
    STA $2005
    JMP CallMusicPlay_L      ; update music engine, then exit

PaletteFrame_Loop:
    LDA PaletteCounter          ; amount of frames to wait
    STA tmp+3                   ; tmp+3 shouldn't be used by MusicPlay
  : JSR PaletteFrame            ; do a frame (updating palettes)
    DEC tmp+3
    BNE :-
    RTS   


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Fade Out Battle Sprite Palettes [$FF90 :: 0x3FFA0]
;;
;;    Fades out the battle sprite palettes until they're all fully black
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

FadeOutAllPalettes:
    JSR PaletteFrame_Loop
    JSR DimAll                  ; every 8 frames... dim the palettes a bit
    BCS FadeOutAllPalettes      ; and jump back to the loop if there are any that aren't blackened yet
    RTS                         ; exit once palette is all black    

FadeOutBG:
    JSR PaletteFrame_Loop
    JSR DimBG
    BCS FadeOutBG
    RTS

FadeOutSprites:
    JSR PaletteFrame_Loop
    JSR DimSprites              ; every 8 frames... dim the palettes a bit
    BCS FadeOutSprites          ; and jump back to the loop if there are any that aren't blackened yet
    RTS                         ; exit once palette is all black

FadeInAllPalettes:              ; Exactly the same as FadeOutBatSprPalettes... except...
    JSR PaletteFrame_Loop
    JSR BrightenAll             ; brighten them instead of dimming them.
    BCS FadeInAllPalettes
    RTS

FadeInBG:
    JSR PaletteFrame_Loop
    JSR BrightenBG
    BCS FadeInBG
    RTS

FadeInSprites:                  ; Exactly the same as FadeOutBatSprPalettes... except...
    JSR PaletteFrame_Loop
    JSR BrightenSprites         ; brighten them instead of dimming them.
    BCS FadeInSprites
    RTS


  
  
RandAX:
    STA Rand_AX_lo       ; 68AF is the 'lo' value
    INX
    STX Rand_AX_high       ; 68B0 is hi+1.  But this STX is totally unnecessary because this value is never used
    
    TXA
    SEC
    SBC Rand_AX_lo       ; subtract to get the range.
    STA Rand_AX_range       ; 68B6 = range
    
    JSR BattleRNG_L
    LDX Rand_AX_range
    JSR MultiplyXA  ; random()*range
    
    TXA             ; drop the low 8 bits, put high 8 bits in A  (effectively:  divide by 256)
    CLC
    ADC Rand_AX_lo       ; + lo
    RTS

MultiplyXA:
    ;; JIGS: this is neat. Yay MMC5 stuff!
    STA $5205
    STX $5206
    LDA $5205            ; 5205 = lower 8 bits 
    LDX $5206            ; 5206 = higher 8 bits
    ;STA MMC5_multiplyA
    ;STX MMC5_multiplyX
    RTS


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;  Re-entrant Long Call
;;  Code provided by DISCH! Edited by JIGGERS a bit.

LongCall:
    @return_addr = tmp      ; (2 bytes) Must be on zero page
    @jump_addr = tmp+2      ; (2 bytes) can be anywhere -- bytes cannot cross page boundry
    
    STA LongCall_A
    STY LongCall_Y
    STX LongCall_X
    ;LDA tmp
    ;STA LongCall_tmp
    ;LDA tmp+1
    ;STA LongCall_tmp+1
    
    PLA                     ; 
    STA @return_addr        ; 
    CLC                     ; 
    ADC #3                  ; 
    TAY                     ; 
    PLA                     ; 
    STA @return_addr+1      ; 
    ADC #0                  ; 
    PHA                     ; 
    TYA                     ; 
    PHA                     ; 
    
    LDY #1                  ; Y starts at 1 because the return address is actually -1
    LDA (@return_addr),Y    ; read low byte of target address
    STA @jump_addr
    INY
    LDA (@return_addr),Y    ; read high byte of target address
    STA @jump_addr+1        ; @jump_addr now has the address we want to jump to
    INY
    
    LDA actual_bank         ; get the 'actual' current bank
    PHA                     ;
    LDA (@return_addr),Y    ; get the target bank
    JSR SwapPRG             ; swap to it
    JSR @doLongCall         ; call our target routine
    
    STA LongCall_A          ; Save A if needed later
    STY LongCall_Y
    STX LongCall_X
    
    ;LDA LongCall_tmp  
    ;STA tmp                 ; restore tmp
    ;LDA LongCall_tmp+1
    ;STA tmp+1
    
    PLA                     ;
    JMP SwapPRG             ;
    
@doLongCall:
    LDY LongCall_Y          ; Restore Y for use in next routine
    LDX LongCall_X
    LDA LongCall_A
                            ; Can't restore tmp, so remember to update things to use LongCall_tmp if possible
    JMP (@jump_addr)        ;

    
    
    





;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; JIGS - and now the stuff I made myself!


    

    
    
;; JIGS - loads the sound test menu and swaps banks and stuff!

SoundTestMenu:         
    LDA #0
    STA $2001             ; turn off the PPU (we need to do some drawing)     
    STA $4015             ; and silence the APU.  Music sill start next time MusicPlay is called.
    STA $5015             ; and silence the MMC5 APU.
    JSR LoadMenuTextBGCHR ; load menu related CHR and palettes
    LDA #BANK_Z
    JSR SwapPRG
    JMP SoundTestZ





;; JIGS - some text to display when hiding

    
;; JIGS - testing B button for move speed

DashButton:
    LDA joy_ignore ; check buttons held down
    AND #$40       ; if B is held down...
    BEQ @RTS
    
    LDA vehicle   ; check vehicle
    CMP #08       ; if airship, then slow speed to 1 for precision landing
    BNE @Walking  ; if not airship, then walking.
    
    LDA #02
    STA move_speed
    RTS
    
   @Walking:   
    LDA mapflags            ; make sure we're NOT on the overworld
    LSR A                   ;  Get SM flag, and shift it into C
    BCC @RTS

    LDA #02    
    STA move_speed
 
   @RTS:
    RTS
 
 
 
 
 





;; JIGS - AND FINALLY the option stuff for the encounter rate.   
    
EncounterRateOption:
    LDA Options
    AND #ENC_RATE_HIGH | ENC_RATE_LOW
    BEQ @RTS
    AND #ENC_RATE_HIGH
    BEQ @LowEncounterRate
    BNE @HighEncounterRate

   @LowEncounterRate:
    LSR tmp              ; 5 if on land, 1 if on ship
   @RTS: 
    RTS
  
   @HighEncounterRate:
    LDA #25
    LDX vehicle          ; check the current vehicle
    CPX #$04             ; see if it's the ship
    BNE :+               ; if it is....
    LDA #10              ; ... 10 / 256 chance instead  (more infrequent battles at sea)
 
  : STA tmp              ; store chance of battle in tmp
    RTS     
  



SaveScreenHelper: 
    LDA #0
    STA $2001
    LDA #BANK_BATTLESPRITES
    JSR SwapPRG
    JSR LoadBattleSpritesForBank_Z
    LDA #BANK_Z
    JMP SwapPRG    
    
    
BattleBackgroundColor_LUT:
.byte $01,$02,$03,$04
.byte $05,$06,$07,$08
.byte $09,$0A,$0B,$0C
.byte $2D,$0F,$14,$11    

;; JIGS - this is a li'l complicated:
;; The highest 4 bits are the original character palettes: 0, 1, 2 ... now 0, 40, 80
;; The low 6 bits are for the unarmed fist sprite. 
;; Because every variable palette uses a base of $20 (00100000), having a base of $10 (00010000)
;; will then trigger the variable palette routine to use specific colors for the sprite
;; These colors are pulled from the original character palettes.
;; The fist sprite is 2 colors. Usually skin + the darker color. 
;; So bits (000000xx) say if the first (skin) color is 1, 2, or 3. 
;; And bits (0000xx00) say if the second (wristband) color is 1, 2, or 3. 
;; And bits (00xx0000) say which of the 3 palettes to pull the color from.

; 0 is the original thief/bb/black mage palette
; 1 is the red/white palette
; 2 is the new palette (used for thief and ninja in my edits)

; so for the BBelt: 00, 00, 01, 11 = 
;1st palette for the class   : palette address 3F10 (whole palette)
;1st palette for the fist    : palette address 3F10 (whole palette)
;1st color for the wristband : palette address 3F11 (single color)
;3rd color for the skin      : palette address 3F13 (single color)

lut_InBattleCharPaletteAssign:
  .BYTE %01010111 ; 01 Fighter
  .BYTE %10100111 ; 02 Thief
  .BYTE %00000111 ; 03 BBelt
  .BYTE %01010111 ; 04 RMage
  .BYTE %01010111 ; 05 WMage
  .BYTE %00000111 ; 06 BMage
  .BYTE %00000000 ; 07 
  .BYTE %00000000 ; 08 
  .BYTE %00000000 ; 09 
  .BYTE %00000000 ; 10 
  .BYTE %00000000 ; 11 
  .BYTE %00000000 ; 12 
  .BYTE %00000000 ; 13  
  .BYTE %00000000 ; 14 
  .BYTE %00000000 ; 15 
  .BYTE %00000000 ; 16 
  .BYTE %01010111 ; 17 Knight
  .BYTE %10100111 ; 18 Ninja
  .BYTE %00000111 ; 19 Master
  .BYTE %01010111 ; 20 RedWiz
  .BYTE %01010111 ; 21 W.Wiz
  .BYTE %00000111 ; 22 B.Wiz
  .BYTE %00000000 ; 23
  .BYTE %00000000 ; 24    
  .BYTE %00000000 ; 25
  .BYTE %00000000 ; 26
  .BYTE %00000000 ; 27
  .BYTE %00000000 ; 28
  .BYTE %00000000 ; 29
  .BYTE %00000000 ; 30
  .BYTE %00000000 ; 31
  .BYTE %00000000 ; 32  
    
    
;Magic_ConvertBitsToBytes:
;; A = character index, either 80, 81, 82, 83, or 00, 01, 02, 03
;    AND #$03                 ; Strip away high bits, in case its in the 80s
;    CLC                      ; Battle spell list will mess up without this!
;    ROR A                    ; Right-shift 3 times (this uses the carry; doing it in Windows calculator, only shift twice)
;    ROR A                    ; 
;    ROR A                    ; 
;    STA CharacterIndexBackup ; back up the character index 
;    TAX
;    LDA #0
;    ;STA TempSpellListIndex  ; Now set this to 0 to start
;    ;STA SpellLevelIndex  ; and this too.
;    ;STA SpellListLoopCounter
;    LDY #26                 ; 24 spells max - 3 per level, 8 levels; + 2 for those 3 variables, since 0 counts as 1!
;
;   @ClearTempSpellList:
;    STA TempSpellList, Y    ; Fill the temp list with 0s
;    DEY                     ; decrement Y
;    BPL @ClearTempSpellList ; When Y = FF, list is cleared!
;
;   @SpellLoop: 
;    TXA
;    CLC
;    ADC SpellListLoopCounter
;    TAX   
;    LDA ch_spells, X   ; level 1 spells
;    JSR UnrollSpell
;    INC SpellListLoopCounter
;    LDA SpellListLoopCounter
;    CMP #$08
;    BNE @SpellLoop
;    RTS
;
;UnrollSpell:
;   @Spell8:
;    ASL A
;    BCC @Spell7
;        LDY #$01
;        JSR UnrollSpell_ConvertToSpellList
;   @Spell7:
;    ASL A
;    BCC @Spell6
;        LDY #$02
;        JSR UnrollSpell_ConvertToSpellList
;   @Spell6:
;    ASL A
;    BCC @Spell5
;        LDY #$03 
;        JSR UnrollSpell_ConvertToSpellList
;   @Spell5:
;    ASL A
;    BCC @Spell4
;        LDY #$04 
;        JSR UnrollSpell_ConvertToSpellList
;   @Spell4:
;    ASL A
;    BCC @Spell3
;        LDY #$05
;        JSR UnrollSpell_ConvertToSpellList  
;   @Spell3:
;    ASL A
;    BCC @Spell2
;        LDY #$06 
;        JSR UnrollSpell_ConvertToSpellList   
;   @Spell2:
;    ASL A
;    BCC @Spell1
;        LDY #$07 
;        JSR UnrollSpell_ConvertToSpellList   
;   @Spell1:
;    ASL A
;    BCC @End
;        LDY #$08 
;        JSR UnrollSpell_ConvertToSpellList
;        
;   @End:                       ; no more spells left to fiddle with...
;    INC SpellLevelIndex        ; increase for each level: 0, 1, 2, 3, 4, 5, 6, 7
;    LDA SpellLevelIndex
;    LDX #03                     ; 3 spells max per level!
;    JSR MultiplyXA              ; Multiply 3 * Spell Level Index
;    STA TempSpellListIndex      ; and save as the temp spell list index. So level 1 * 3 is 3, level 2 * 3 is 6...
;    LDA SpellLevelIndex         ; So even if a character knows more than 3 spells, the list will swap back to write over them
;    LDX CharacterIndexBackup    ; ...I hope
;    RTS
;  
;UnrollSpell_ConvertToSpellList:
;    PHA                     ; backup the whole lot of this level's spells
;    LDX SpellLevelIndex     ; Spell level (0 based)
;    LDA #$08
;    JSR MultiplyXA          ; spell level * 8
;    STA tmp
;    TYA                     ; Spell ID - spell level
;    CLC
;    ADC tmp                 ; Spell ID + Spell Level = Real Spell ID! 
;    LDX TempSpellListIndex 
;    STA TempSpellList, X    
;    INC TempSpellListIndex  
;    PLA                     ; and pull back from the stack to continue
;    RTS
    
;;;;;;;;;;;;;;;;

JigsDrawBox_LUT:

;; max width is $20
;; max height is $09
;; highest Y position possible for a readable box is *6*. 8 breaks things.
;; highest X position possible for a readable 1-tile-wide box is $1D ?

;; width, height, X, Y positions

;; with these 8 missing, just make sure any reading of the LUT is -8?
;.byte $01,$01,$00,$00 ; 01
;.byte $01,$01,$00,$00 ; 02 filler
.byte $0F,$09,$00,$00 ; 02, Confirm Box
.byte $11,$09,$0F,$00 ; 03, Character Box
.byte $10,$09,$00,$00 ; 04, Command Box
.byte $0F,$09,$00,$00 ; 05, Roster Box
.byte $11,$09,$00,$00 ; 06, Ether Box
.byte $0F,$09,$00,$00 ; 07, Skill Box
.byte $09,$09,$17,$00 ; 08, Player HP
.byte $0D,$03,$00,$00 ; 09, Attacker Box
.byte $0D,$03,$0D,$00 ; 0A, Attack Box
.byte $0D,$03,$00,$03 ; 0B, Defender Box
.byte $0D,$03,$0D,$03 ; 0C, Damage Box
.byte $20,$03,$00,$06 ; 0D, Message Box
.byte $20,$09,$00,$00 ; 0E, Magic Box
.byte $0F,$09,$00,$00 ; 0F, Item Box
.byte $17,$09,$00,$00 ; 11, Gear Box
.byte $20,$06,$00,$03 ; 11, Scan Box


;; again note: box IDs 0 and 1 will not work. They are for variations of the "Ready?" box!

JigsDrawBoxAddress_LUT: ; read from -4 
;.byte $75,$00
;.byte $75,$00
.byte $77,$A0 ; 02, Confirm Box - shared with Roster
.byte $76,$60 ; 03, Character Box
.byte $77,$00 ; 04, Command Box
.byte $77,$A0 ; 05, Roster Box
.byte $7A,$40 ; 06, Ether Box  
.byte $77,$A0 ; 07, Skill Box    - shared with Roster
.byte $7F,$A0 ; 08, Player HP   

.byte $75,$00 ; 09, Attacker Box
.byte $75,$40 ; 0A, Attack Box
.byte $75,$80 ; 0B, Defender Box
.byte $75,$C0 ; 0C, Damage Box
.byte $76,$00 ; 0D, Message Box

.byte $78,$40 ; 0E, Magic Box
.byte $77,$A0 ; 0F, Item Box    - shared with Roster
.byte $79,$60 ; 10, Gear Box
.byte $7A,$E0 ; 11, Scan Box    


;; They're ordered by a weird box ID system more than RAM location now.

;; Spaced them out so its easier to read to make sure things are working. 
;; See JigsBox_Start for instructions on making a more snug version


UndrawBattleBlock:
    LDX BattleBoxBufferCount
    LDA BattleBoxBufferList-1, X
    STA btldraw_box_id           
    DEC BattleBoxBufferCount
    LDA #$FF
    STA BattleBoxBufferList-1, X ; and clear the box from the list buffer
  
JigsBoxUndrawFromBuffer:   
    JSR DrawBox_WaitForVBlank
    INC RAMSwap                  ; set the swap switch to copy old data to the screen buffer
    JSR JigsBoxDrawToBuffer
    DEC RAMSwap
    LDA #32
    LDX btl_msgbuffer_loopctr    ; multiply screen width by height - 1
    DEX
    JSR MultiplyXA 
    CLC
    ADC BattleTmpPointer2        ; add to the source pointer for the next routine
    STA BattleTmpPointer2
    TXA
    ADC BattleTmpPointer2+1
    STA BattleTmpPointer2+1
    JMP BattleDrawMessageBuffer_Reverse
    

;; in: A = Box ID
JigsBoxDrawToBuffer:
    LDA btldraw_box_id
    ASL A
    TAX
    LDA JigsDrawBoxAddress_LUT-4, X
    STA tmp+1                 ; Load address high
    LDA JigsDrawBoxAddress_LUT-3, X ; (+1)
    STA tmp                   ; Load address low (now accessed with "(tmp), Y")
    TXA
    ASL A                     ; X = ID * 4
    TAX
    LDA JigsDrawBox_LUT-8, X
    STA tmp+6                 ; Width
    STA tmp+10                ; "tiles left in row" counter
    LDA JigsDrawBox_LUT-7, X  ; (+1)
    STA btl_msgbuffer_loopctr ; Height (amount of rows to draw)
    STA tmp+11
    LDA JigsDrawBox_LUT-6, X  ; (+2)
    STA tmp+4                 ; X pos
    LDA JigsDrawBox_LUT-5, X  ; Y pos (+3)
    STA tmp+12
    LDX #32
    JSR MultiplyXA
    STA tmp+5                 ; new Y position = screen width * original Y position
    CLC
    ADC tmp+4                 ; add in X position
    STA tmp+8                 ; Tmp+8 = X and Y position totals, for use with adding to $2280 to draw to the screen
    ADC #<btl_msgbuffer       ; and screen buffer start
    STA BattleTmpPointer2     ; save address low (screen buffer)
    STA tmp+2
    LDA #0
    ADC #>btl_msgbuffer       
    STA BattleTmpPointer2+1   ; save address high (screen buffer)
    STA tmp+3
    LDY #0
    LDX #1

   @TransferBoxTile:
    LDA RAMSwap               ; check this variable to see if we're undrawing or drawing a box
    BMI @HPUpdate             ; or if the high bit is set, only updating HP text
    BNE @Undraw
    
   @NormalBox:
    LDA (tmp+2), Y            ; copy screen buffer to backup box
    LDX #1
    STX $5113                 ; X = 1 : swap to backup RAM
    STA (tmp), Y              ; save the screen buffer tile to backup RAM box buffer
    DEX
    STX $5113                 ; X = 0 : swap to normal RAM
    
   @HPUpdate:                 ; (for HP updating, only copy new text over)
    LDA (tmp), Y              ; then copy box to draw it to the screen buffer
    STA (tmp+2), Y
    BNE @INC_pointer

   @Undraw:
    LDX #1
    STX $5113               ; X = 1 : swap to backup RAM
    LDA (tmp), Y            ; Get the tile from the backup RAM
    DEX
    STX $5113               ; swap to normal RAM
    STA (tmp+2), Y

  @INC_pointer:
    INY 
    BNE :+                  ; if Y wraps, 
        INC tmp+1           ; inc the high bytes of the pointers
        INC tmp+3
  : DEC tmp+10              ; decrement tiles left in row counter
    BNE @TransferBoxTile
   
   @NextRow:   
    LDA #32+1                 ; screen width +1 to set fake-carry
    ;SEC
    SBC tmp+6               ; minus width of box
    CLC
    ADC tmp+2               ; add it to save address low
    STA tmp+2
    LDA #0
    ADC tmp+3               ; and add in the carry
    STA tmp+3
    
    LDA tmp+6
    STA tmp+10              ; reset "tiles left in row" counter
    DEC tmp+11              ; decrement "rows left in box" counter
    BNE @TransferBoxTile
    RTS

   
   
   
    
JigsBox_Start:
;; First, clear the list of drawn boxes, and set the count to 0.
    LDA #$FF
    LDX #$08
  : STA BattleBoxBufferList-1, X
    DEX
    BNE :-

;    LDA #>BattleBoxBuffers
;    STA tmp+2    
;    LDA #<BattleBoxBuffers ; should be #0
;    STA tmp+1               
;; Enable this and disable the Address_LUT reads to see how the boxes are nudged up beside each other in RAM
    
    STX BattleBoxBufferCount ; set to 0
    LDA #$02
    STA tmp

  : JSR ClearJigsBoxBuffer  ; Loop through all the possible boxes to set them up.
    INC tmp
    LDA tmp
    CMP #$10                ; only $0C boxes so far
    BNE :-
    
    ;; Now to fix the HP update box...
    LDA #$F8
    STA HPUpdateBox
    LDA #$FD
    STA HPUpdateBox+72
    LDA #$FF
    STA HPUpdateBox+9
    STA HPUpdateBox+18
    STA HPUpdateBox+27
    STA HPUpdateBox+36
    STA HPUpdateBox+45
    STA HPUpdateBox+54
    STA HPUpdateBox+63
    RTS
    
;; This draws a blank box to RAM, when A = the box ID
    
ClearJigsBoxBuffer:
    ASL A
    
    ;; vv -- disable this block and enable the one above to make the boxes super snug, then edit the addresses in the lut to match how they're drawn
    
    TAX
    LDA JigsDrawBoxAddress_LUT-4, X ; address high byte
    STA tmp+2
    LDA JigsDrawBoxAddress_LUT-3, X ; (+1) address low byte
    STA tmp+1
    TXA
    
    ;; ^^ 

    ASL A                   ; * 4
    TAX
    LDA JigsDrawBox_LUT-8, X
    STA box_wd
    LDA JigsDrawBox_LUT-7, X ; (+1)
    SEC
    SBC #2                  ; height - 2
    STA box_ht
    DEC box_wd              ; width - 1
    LDY #0
    
    LDX #$FF                ; so the first INX will set it to 0
    JSR JigsBoxDoRow        ; top row
  : LDX #2                  ; X is the index to the box tiles, so use the middle row by default
    JSR JigsBoxDoRow        ; middle rows
    DEC box_ht              ; decrement the height counter (no need to back it up)
    BNE :-                  ; when the height counter = 0 there's one row left, so don't set X back
    
JigsBoxDoRow:
    INX                      
    LDA box_wd
    STA tmp+5               ; set width counter
    JSR @DrawBoxTileToRAM   ; do one tile
    INX                     ; inc X to get next tile graphic
    DEC tmp+5               ; decrement the width counter
  : JSR @DrawBoxTileToRAM   ; loop to do middle tiles
    DEC tmp+5               ; when the width counter = 0, there's one tile left
    BNE :-                  ; until then, keep looping
    INX                     ; get third tile, and flow into doing it

   @DrawBoxTileToRAM:
    LDA BoxTiles, X         ; get the tile graphic
    STA (tmp+1), Y          ; draw it to RAM
    INC tmp+1               ; inc the pointer 
    BNE @End
        INC tmp+2           ; and inc the high bit if it wraps
   @End:
    RTS

 
BoxTiles:
    .byte $F7,$F8,$F9
    .byte $FA,$FF,$FB
    .byte $FC,$FD,$FE


;; this draws a mini box, but the #0F ID skips incrementing drawn-box stuff
;; and it uses no box borders. It should just decompress the HP string
;; in the same place it was first drawn at the start of battle,
;; and then update the screen...?


ADD_ITEM:
    JSR Item_Compression_Shared
    CMP tmp+2           ; compare to max amount
    BCS @Full           ; if the compare sets carry, jump to the RTS
  
    LDA (tmp), Y        ; load the compressed equipment/spell
    ADC tmp+3           ; add the amount to high or low nybble
    STA (tmp), Y        ; then save 
   @Full:               ; carry set when unable to add more
    RTS                 ; carry clear when successful
  
REMOVE_ITEM:
    JSR Item_Compression_Shared
    BEQ @Empty          ; if its 0, there is nothing to subtract
 
    LDA (tmp), Y        ; load the compressed equipment/spell
    SEC
    SBC tmp+3           ; subtract the amount from high or low nybble
    STA (tmp), Y        ; then save 
    CLC                 ; clear carry to indicate success
    RTS
   
   @Empty:              ; manually set carry to indicate failure
    SEC
    RTS
  

Item_Compression_Shared:
    PHA
    LSR A               ; halve the ID
    TAY                 ; put it in Y for indexing
 
    PLA                 ; then restore the ID
    AND #$01            ; see if its even or odd by cutting out all but the lowest bit
    BEQ @High           ; if its set, its an odd numbered ID
 
   @Low: 
    LDA #$01            ; amount to add when low
    LDX #$0F            ; bits to cut/keep, plus max amount when low
    BNE @Check
 
   @High:
    LDA #$10
    LDX #$F0
 
   @Check:
    STX tmp+2           ; tmp+2 are the bits to cut/keep with AND
    STA tmp+3           ; tmp+3 is amount to subtract
   
    LDA (tmp), Y        ; tmp, tmp+1 points to weapon, armor, or spells
    AND tmp+2           ; cut/keep the appropriate bits
    RTS   
  
  
DOES_ITEM_EXIST:       ; input: A = item ID - output: item amount
    PHA
    LSR A               ; halve the ID
    TAY                 ; put it in Y for indexing
  
    PLA
    AND #$01            ; see if its even or odd by cutting out all but the lowest bit
    BEQ @High           ; if its set, its an odd numbered ID
  
   @Low: 
    LDA #$0F            
    BNE @Compare
    
   @High:
    LDA #$F0
  
   @Compare:
    STA tmp+2           ; put the bits to cut or keep into tmp+2
    LDA (tmp), Y        ; tmp, tmp+1 points to weapon, armor, or spells
    AND tmp+2           
    BEQ @Empty          ; if its 0, there is nothing there 
  
    CMP #$10            ; check if it was low or high
    BCC @HaveLow        ; if it was low, do nothing but exit
   
   @HaveHigh:
    LSR A               ; this shifts the high nybble to low to get item count for output
    LSR A               ; as well as clearing out carry
    LSR A   
    LSR A
    
   @HaveLow:
    RTS
   
   @Empty:              ; manually set carry to indicate failure
    SEC
    RTS  
   

Set_Inv_Magic:
    LDA #<inv_magic - unsram
    STA tmp
    LDA #>inv_magic - unsram
    STA tmp+1
    RTS

Set_Inv_Weapon:
    LDA #<inv_weapon - unsram
    STA tmp
    LDA #>inv_weapon - unsram
    STA tmp+1
    RTS
    
Set_Inv_KeyItem:
    LDA #<keyitems - unsram
    STA OneBitPointer
    LDA #>keyitems - unsram
    STA OneBitPointer+1
    RTS
    
DOES_ITEM_EXIST_1BIT:
    JSR Inv_Setup_1BIT
    AND item_bit_ram, Y
    RTS                     ; Zero flag set if it does not exist

ADD_ITEM_1BIT:
    JSR Inv_Setup_1BIT
    ORA item_bit_ram, Y     ; add the bit!
    BNE :+   
    
REMOVE_ITEM_1BIT:
    JSR Inv_Setup_1BIT
    EOR item_bit_ram, Y     ; remove the bit while keeping the rest the same?
  : STA (OneBitPointer), Y  ; save and exit
    RTS

Inv_Setup_1BIT:
    PHA              ; backup item ID
    LDX #$10         ; clear $10 bytes of temp RAM
    LDA #0
   @Loop:
    STA item_bit_ram, X
    DEX
    BNE @Loop
    PLA              ; restore item ID 
    TAX              ; put in X for loop counter
    LSR A            ; then shift right 3 times
    LSR A
    LSR A
    PHA              ; item ID now = which byte of tmp RAM to check against
    
    SEC              ; set C
   @ShiftLoop_X: 
    LDY #0
   @ShiftLoop_Y:
    LDA item_bit_ram, Y
    ROR A
    STA item_bit_ram, Y  ; and shift C into the correct bit
    INY
    CPY #$10             ; when Y = $10, its done one shift of each byte of tmp RAM
    BNE @ShiftLoop_Y
    DEX              
    BNE @ShiftLoop_X
    
    PLA
    TAY
    LDA (OneBitPointer), Y ; get byte of compressed inventory    
    RTS    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    

.segment "VECTORS"

  .WORD OnNMI
  .WORD OnReset
  .WORD OnIRQ     ;IRQ vector points to an infinite loop (IRQs should never occur)

