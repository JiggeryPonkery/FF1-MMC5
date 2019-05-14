.include "Constants.inc"
.include "variables.inc"

.segment "BANK_10"




.export TalkToObject
.export HideMapObject
.export ShowMapObject
.export lut_DialoguePtrTbl

.import FindEmptyWeaponSlot


BANK_THIS = $10

;.INCBIN "bin/Dialogue_Data.bin"

lut_DialoguePtrTbl:
.WORD EMPTY             ; 0  ; Nothing here.
.WORD KING1             ; 1  ; LIGHT WARRIORS.... Just as in Lukahn's prophecy. Garland has kidnapped the Princess. Please help her!!
.WORD KING2             ; 2  ; Thank you for saving the Princess. To aid your quest I ordered a bridge built to the continent. Go now, and make the ORBS shine again!!
.WORD KING3             ; 3  ; The Princess always worries about you.
.WORD GARLAND           ; 4  ; No one touches my Princess!! LIGHT WARRIORS?? You impertinent fools. I, Garland, will knock you all down!!
.WORD PRINCESS1         ; 5  ; So, you are the LIGHT WARRIORS! Thank you.
.WORD PRINCESS2         ; 6  ; This LUTE has been passed down from Queen to Princess for 2000 years. Garland stole it when he kidnapped me. Please accept it as my gift, it just might come in handy.
.WORD PRINCESS3         ; 7  ; Now, get ready for your trip, and make the ORBS shine again.
.WORD PIRATE1           ; 8  ; Aye, I am Bikke the Pirate, and surprised I am that you scurvy dogs have the nerve to face me. Mates! Get those landlubbers!
.WORD PIRATE2           ; 9  ; Okay, you got me. Take my SHIP.
.WORD PIRATE3           ; A  ; I won't be any more bother. I promise.
.WORD HEALER1           ; B  ; For five years the Prince has slept under Astos' spell. Only HERB can wake him!
.WORD HEALER2           ; C  ; Oh, this HERB will release the Prince from Astos' curse. Look! He is waking....
.WORD HEALER3           ; D  ; Thank you. Peace will return to ElfLand.
.WORD PRINCE1           ; E  ; Is this a dream?.... Are you, the LIGHT WARRIORS?.... Is this for real?.... So, as legend says, I give you the mystic KEY.
.WORD PRINCE2           ; F  ; I feel fine now. Thank you.
.WORD PRINCE3           ; 10 ; z... z... 
.WORD ASTOS1            ; 11 ; Astos double-crossed us. Go south, to the Cave of Marsh, to retrieve the CROWN. Then, bring it directly back to me!
.WORD ASTOS2            ; 12 ; HA, HA, HA! I am Astos, King of the Dark Elves. I have Matoya's CRYSTAL, and you shall give me that CROWN, now!!!
.WORD TNTDWARF1         ; 13 ; A rock blocks construction of my canal. If I only had TNT.
.WORD TNTDWARF2         ; 14 ; Oh, wonderful! Nice work! Yes, yes indeed, this TNT is just what I need to finish my canal. Now excuse me while I get to work!
.WORD BLACKSMITH1       ; 15 ; For the LIGHT WARRIORS I will make a truly legendary sword. However, my supply of ADAMANT is exhausted.
.WORD BLACKSMITH2       ; 16 ; ADAMANT!! Now let me make the sword for you.... Here, the best work I've ever done. It is my gift.
.WORD MATOYA1           ; 17 ; Where is my CRYSTAL? I can't see anything without it.... Who stole my CRYSTAL?
.WORD GENERICPRAISE     ; 18 ; WARRIORS. Revive the Power of the ORBS!
.WORD MATOYA2           ; 19 ; The Prince needs HERB? I'll trade the most powerful HERB to get my CRYSTAL back.... Oh! I can see!!
.WORD MATOYA3           ; 1A ; You have no more business here. Go!!
.WORD UNNE1             ; 1B ; Everybody knows me. What?! You've never heard of Dr. Unne?
.WORD UNNE2             ; 1C ; A SLAB!! This SLAB will lead us to solve the riddle of the Lefeinish!! Now, listen to me....?
.WORD VAMPIRE           ; 1D ; All living things are born to die. No one can defeat me, the Vampire!!
.WORD SARDA             ; 1E ; Use this ROD behind the Vampire's room. Hiding deep inside you will find the cause of the earth's rot.
.WORD BAHAMUT1          ; 1F ; I am BAHAMUT, King of the Dragons. Bring me proof of your courage, to receive the honor due true Warriors.
.WORD BAHAMUT2          ; 20 ; The TAIL of a rat proves your courage. I shall give you the honor due true Warriors.
.WORD BLACKORB1         ; 21 ; The four ORBS now cover the black ORB.... To take a step forward is to go back 2000 years in time.
.WORD BLACKORB2         ; 22 ; The black ORB glitters ominously.... But nothing happens.
.WORD FAIRY1            ; 23 ; That pirate trapped me in the BOTTLE. I will draw OXYALE from the bottom of the spring for you.
.WORD FAIRY2            ; 24 ; Thank you for saving me. Remember! OXYALE will give you air.
.WORD ENGINEER1         ; 25 ; I made a submarine to save the mermaids. But, to go deep enough it will require OXYALE.
.WORD ENGINEER2         ; 26 ; WARRIORS, you have OXYALE. The mermaids wait, please help them!
.WORD ROBOT1            ; 27 ; Take this CUBE. With it, you can transfer to the FLOATING CASTLE.
.WORD ROBOT2            ; 28 ; Please....
.WORD TITAN1            ; 29 ; No one passes this road.
.WORD TITAN2            ; 2A ; If you want pass, give me the RUBY.... Crunch, crunch, crunch, mmm, it tastes so sweet. Rubies are my favorite.
.WORD CANOESAGE1        ; 2B ; Great job vanquishing the Earth FIEND. Now, the Fire FIEND wakes. With this CANOE go to the VOLCANO, and defeat that FIEND also!
.WORD CANOESAGE2        ; 2C ; 400 years ago, we lost control of the Wind. 200 years later we lost the Water, then Earth, and Fire followed. The Powers that bind this world are gone.
.WORD ORDEALSGHOST      ; 2D ; Possession of the CROWN is required to test your courage. Take it to the royal throne, and bring back proof of your courage. GOOD LUCK!
.WORD CHAOS1            ; 2E ; Remember me, Garland? Your puny lot thought it had defeated me. But, the Four FIENDS sent me back 2000 years into the past.
.WORD CHAOS2            ; 2F ; From here I sent the Four FIENDS to the future. The FIENDS will send me back to here, and the Time-Loop will go on.
.WORD CHAOS3            ; 30 ; After 2000 years, I will be forgotten, and the Time-Loop will close. I will live forever, and you shall meet doom!!
.WORD CORNERIACASTLE1   ; 31 ; The King is looking for the LIGHT WARRIORS. You do not happen to be them do you?
.WORD CORNERIACASTLE2   ; 32 ; Yes Sir!! I belong to the Honor Guard of Castle Coneria.
.WORD CORNERIACASTLE3   ; 33 ; Please! Save the Princess!
.WORD CORNERIACASTLE4   ; 34 ; Thank you for rescuing the Princess.
.WORD CORNERIACASTLE5   ; 35 ; Legend says that the LUTE can break the evil gate.
.WORD CORNERIACASTLE6   ; 36 ; Garland used to be a good knight until....
.WORD CORNERIACASTLE7   ; 37 ; In sadness, the Queen locked herself inside.
.WORD CORNERIACASTLE8   ; 38 ; The Princess was looking for you!
.WORD CORNERIACASTLE9   ; 39 ; So, you are the LIGHT WARRIORS?
.WORD BLACKSMITH3       ; 3A ; Don't be greedy. You already have too many weapons to carry.'
.WORD CORNERIACASTLE10  ; 3B ; I am Jane, Queen of Coneria. Please save my daughter, Princess Sara.
.WORD CORNERIACASTLE11  ; 3C ; Thank you for saving Princess Sara.
.WORD CORNERIACASTLE12  ; 3D ; Oh.... My sister....
.WORD CORNERIACASTLE13  ; 3E ; My sister is back safe! Thank you.
.WORD CORNERIACASTLE14  ; 3F ; Reports say that Garland holds the Princess in a Temple to the northwest.
.WORD CORNERIACASTLE15  ; 40 ; Use that KEY. Inside what you find will be quite helpful.
.WORD CORNERIACASTLE16  ; 41 ; 400 years ago the Treasury was locked by the mystic KEY. Our ancestors gave the KEY to the Prince of ElfLand for safekeeping.
.WORD CORNERIACASTLE17  ; 42 ; This treasure room is locked with the mystical KEY.
.WORD CORNERIACASTLE18  ; 43 ; The King is sure that someday the LIGHT WARRIORS will come to save the Princess, just as in Lukahn's prophecy.
.WORD CORNERIATOWN1     ; 44 ; Lukahn left this town, to join his colleagues at Crescent Lake.
.WORD CORNERIATOWN2     ; 45 ; As legend foretold, once again the ORBS shine!! Quickly, to fulfill the legend, take them to the Temple north of here, and stand in the center.
.WORD CORNERIATOWN3     ; 46 ; Go to the King.
.WORD CORNERIATOWN4     ; 47 ; I am Arylon, the Dancer!
.WORD CORNERIATOWN5     ; 48 ; This is Coneria, the dream city.
.WORD CORNERIATOWN6     ; 49 ; North of Coneria lives a witch named Matoya.
.WORD CORNERIATOWN7     ; 4A ; Matoya has poor eyesight. She needs the CRYSTAL to see.
.WORD CORNERIATOWN8     ; 4B ; My home is Pravoka, a beautiful port city far east of here.
.WORD CUTEBAT           ; 4C ; Kee....Kee....
.WORD SKYWARRIOR1       ; 4D ; Help! The FIEND's curse turned us into bats. With the ORBS shining anew, once again we can speak!
.WORD SKYWARRIOR2       ; 4E ; The Four FIENDS power is rooted 2000 years ago. The real enemy is in that time.
.WORD SKYWARRIOR3       ; 4F ; When the 4 ORBS cover the black ORB in the center of the palace, the Time Gate can open.
.WORD SKYWARRIOR4       ; 50 ; You must travel back in time 2000 years. Now, with the ORBS shining, stand in the Time Gate.
.WORD SKYWARRIOR5       ; 51 ; We are the five lost SKY WARRIORS. 400 years ago we battled against the cause of the world's destruction.
.WORD PROVOKA1          ; 52 ; Thank you. We don't need to be afraid of pirates anymore.
.WORD PROVOKA2          ; 53 ; I have escaped from Melmond, in the west. My town is in trouble. Please help them!!
.WORD PROVOKA3          ; 54 ; The Elves live across the sea. Matoya's HERB is the only thing that will wake their Prince.
.WORD PROVOKA4          ; 55 ; This town has been invaded by pirates.
.WORD PROVOKA5          ; 56 ; Ships can stop only at ports. There are no ports in the north.
.WORD PROVOKA6          ; 57 ; Help!
.WORD PROVOKA7          ; 58 ; There are many dangerous monsters in the sea. Be careful!
.WORD ELFLANDCASTLE1    ; 59 ; Astos put the Prince to sleep. Please! Save him!
.WORD ELFLANDCASTLE2    ; 5A ; The Prince is awake! Thank you so much.
.WORD ELFLANDCASTLE3    ; 5B ; The Cave of Dwarf is at the west end of the Aldi Sea.
.WORD ELFLANDCASTLE4    ; 5C ; Without warning, Astos attacked our castle. Our Prince was laid under a curse, and our treasury ransacked.
.WORD ELFLANDCASTLE5    ; 5D ; It is said there is a witch who has HERBS. I believe that her name is.... Matoya!
.WORD ELFLANDCASTLE6    ; 5E ; Is that it? The HERB to save the Prince?
.WORD ELFLANDCASTLE7    ; 5F ; The Prince keeps the mystic KEY until the coming of the LIGHT WARRIORS.
.WORD ELFLANDCASTLE8    ; 60 ; Maybe it's only rumour, but, I think the cause of all problems is to be found in the cave of Marsh.
.WORD ELFLAND1          ; 61 ; Save our Prince!
.WORD ELFLAND2          ; 62 ; Our Prince was to become the King of ElfLand.
.WORD ELFLAND3          ; 63 ; Long ago I wandered to the Northwest. I found an ancient castle that was so spooky, I left immediately.
.WORD ELFLAND4          ; 64 ; Astos has been defeated? Peace will now return to ElfLand.
.WORD ELFLAND5          ; 65 ; Astos wears a disguise, and lurks in seclusion. The Prince must wake soon, or the power of the Dark Elf will dominate!
.WORD ELFLAND6          ; 66 ; The Prince must wake soon, or the power of the Dark Elf will dominate!
.WORD ELFLAND7          ; 67 ; Legend says an AIRSHIP is buried somewhere.
.WORD ELFLAND8          ; 68 ; Swords and armors made of silver are very powerful.
.WORD ELFLAND9          ; 69 ; I can see a cave above the crescent.... To the north of the volcano, there you will find the FLOATER.
.WORD ELFLAND10         ; 6A ; In the desert south of the crescent, something is emerging from below the sand.... Use the FLOATER!
.WORD ELFLAND11         ; 6B ; The Prince must wake soon, or the Dark Elf will dominate!
.WORD DWARFCAVE1        ; 6C ; I'm looking for the FLOATER. I'll bet with it I could float anything.
.WORD DWARFCAVE2        ; 6D ; Old Nerrick is a very respectable Dwarf.
.WORD DWARFCAVE3        ; 6E ; That sound? Nerrick is digging a canal.
.WORD DWARFCAVE4        ; 6F ; Dwarves can see in the dark!
.WORD DWARFCAVE5        ; 70 ; Did you meet Smith, our blacksmith?
.WORD DWARFCAVE6        ; 71 ; With the CRYSTAL, even the blind can see. Astos stole it from Matoya.
.WORD DWARFCAVE7        ; 72 ; The earth is rotting slowly from the west....
.WORD DWARFCAVE8        ; 73 ; The earth is reviving! Thanks to you, LIGHT WARRIORS!
.WORD DWARFCAVE9        ; 74 ; The Q...bracelet can protect you, like armor.
.WORD DWARFCAVE10       ; 75 ; Oh, did you see that canal? Old Nerrick truly is great indeed.
.WORD DWARFCAVE11       ; 76 ; Long ago, Coneria's Treasury safeguarded the use of TNT.
.WORD DWARFCAVE12       ; 77 ; Hurray!!
.WORD BROOM             ; 78 ; ----TCELES B HSUP A magic spell?
.WORD MELMOND           ; 79 ; The Vampire of the Earth Cave is stealing the Power of the earth. We need your help.
.WORD MELMOND1          ; 7A ; Melmond was once a beautiful town.
.WORD MELMOND2          ; 7B ; The Titan who lives in the tunnel eats gems. He loves RUBIES.
.WORD MELMOND3          ; 7C ; The Vampire is gone, but the earth continues to rot. What causes this?
.WORD MELMOND4          ; 7D ; I'm a farmer.
.WORD MELMOND5          ; 7E ; The Earth Cave is on the peninsula southwest of this town.
.WORD MELMOND6          ; 7F ; Look! The Earth ORB is shining again.
.WORD MELMOND7          ; 80 ; This town was invaded by the Vampire. The Clinic was destroyed and the town was cursed.
.WORD MELMOND8          ; 81 ; Are you the LIGHT WARRIORS?
.WORD MELMOND9          ; 82 ; Pass through the Titan's Tunnel, then south to find Sarda, the Sage.
.WORD MELMOND10         ; 83 ; The Vampire is gone, but the earth still rots?....
.WORD MELMOND11         ; 84 ; In the northern world, there once was a prosperous civilization, but now it is ruins.
.WORD MELMOND12         ; 85 ; If the ORB of Earth begins to shine again, the earth shall revive.
.WORD MELMOND13         ; 86 ; LIGHT WARRIORS.... Thanks to you, the earth is beginning to revive....
.WORD MELMOND14         ; 87 ; They say the ancient people used a stone to make their ship float.
.WORD MELMOND15         ; 88 ; OH! An AIRSHIP! The fables are true, it really exists!!
.WORD MELMOND16         ; 89 ; Sarda does not fear the evils of the cave.
.WORD MELMOND17         ; 8A ; Well, well.... You have become fine Warriors.
.WORD MELMOND18         ; 8B ; I am Jim. My home is the Dwarf Village, but I am here investigating.
.WORD LAKESAGE1         ; 8C ; We, the Twelve Sages, were lead here by the stars and prophecy.
.WORD LAKESAGE2         ; 8D ; Once the ORBS shined with the power of Earth, Wind, Fire, and Water. The four FIENDS seized those Powers.
.WORD LAKESAGE3         ; 8E ; Earth, Wind, Fire, and Water.... The world is bound by these four Powers.
.WORD LAKESAGE4         ; 8F ; Each element's power focuses at its Altar. Locate, and crush the Fiend. Then to make it shine, place the ORB on the Altar it guarded!
.WORD LAKESAGE5         ; 90 ; Four FIENDS are bent on the world's destruction. 200 years ago, the FIEND of Wind teamed with that of the Water to destroy civilization.
.WORD LAKESAGE6         ; 91 ; The Earth FIEND causes the rot of our land.
.WORD LAKESAGE7         ; 92 ; The Fire FIEND will burn everything up!
.WORD LAKESAGE8         ; 93 ; As you restore light to the ORBS, we will reveal more secrets, please see us repeatedly.
.WORD LAKESAGE9         ; 94 ; LIGHT WARRIORS, only you can make the ORBS shine again!!
.WORD LAKESAGE10        ; 95 ; Quickly, before all is burnt, hurry to Gurgu Volcano and stop the FIEND of Fire.
.WORD LAKESAGE11        ; 96 ; The Temple of FIENDS is in the center of the Four Altars. The time has come to destroy the source of evil.
.WORD LAKESAGE12        ; 97 ; With the four ORBS shining again the Time Gate can be broken. The true enemy is 2000 years in the past.
.WORD LAKESAGE13        ; 98 ; The world was suddenly thrown into disorder. You must restore it.
.WORD LAKESAGE14        ; 99 ; Time is repeating. In order to break the Time-Loop you must eliminate the enemy who controls from 2000 years in the past.
.WORD LAKESAGE15        ; 9A ; Someone travelled 2000 years to the past. The four FIENDS were sent forward in time. Those FIENDS threaten to destroy the world today.
.WORD LAKESAGE16        ; 9B ; I see now. Someone who travelled back 2000 years is the cause of the world's destruction. After 2000 years he will travel back again.... Then again....Then again....
.WORD LAKESAGE17        ; 9C ; Time will repeat itself every 2000 years. Break the Time-Loop!
.WORD LAKESAGE18        ; 9D ; In the Temple of FIENDS are the remaining SKY WARRIORS. They fought the FIENDS and are now bats!
.WORD LAKESAGE19        ; 9E ; We must use force only for just purposes.
.WORD CRESCENTLAKE1     ; 9F ; For ten years I probed for the FLOATER. CANOE north, to the Ice Cave.
.WORD LAKESAGE20        ; A0 ; I am Lukahn. Now all legends and prophecy will be fulfilled. Our path has been decided.
.WORD CRESCENTLAKE2     ; A1 ; LIGHT WARRIORS, you can do it!
.WORD ONRAC1            ; A2 ; My brother Dr. Unne has studied Lefeinish, the language of the SKY WARRIORS. If he had the SLAB, he could teach it.
.WORD ONRAC2            ; A3 ; Soar to my brother Unne with the SLAB!
.WORD ONRAC3            ; A4 ; Have you found OXYALE?
.WORD ONRAC4            ; A5 ; You have legs!
.WORD ONRAC5            ; A6 ; My legs are beautiful! It's so nice to have legs.
.WORD ONRAC6            ; A7 ; Underhill, the Caravan Master, had something very strange....
.WORD ONRAC7            ; A8 ; Until 200 years ago the Mermaids lived in the Shrine. Then, in fire and smoke, it sank. The Mermaids?....
.WORD ONRAC8            ; A9 ; Until 200 years ago, the Power of Water brought us good fortune.
.WORD ONRAC9            ; AA ; The power of Water!! Now, our country will prosper like before.
.WORD ONRAC10           ; AB ; I saw BAHAMUT, but, to be honored as a true warrior I must return with proof of my courage.
.WORD ONRAC11           ; AC ; Well, well.... I see you have been honored.
.WORD ONRAC12           ; AD ; Avast ye landlubbers! Stay out of me way.
.WORD ONRAC13           ; AE ; My father runs the caravan. He is having a close out sale near the oasis in the western desert.
.WORD ONRAC14           ; AF ; Kope 'says' he saw a shining object fall.
.WORD ONRAC15           ; B0 ; Fables say that when the shrine sank, many treasures were lost. Also, they tell of a cryptic stone plate.
.WORD ONRAC16           ; B1 ; My name is Kope. I saw it north, near the waterfall. Believe me! I think it was a robot.
.WORD ONRAC17           ; B2 ; This town used to be prosperous 200 years ago.
.WORD SAMPLE            ; B3 ; No! That is just an unusable sample.
.WORD MERMAID1          ; B4 ; If we cannot regain the Power of Water, we will become bubbles, then disappear.
.WORD MERMAID2          ; B5 ; Are we going to become bubbles?
.WORD MERMAID3          ; B6 ; As long as the FIEND of Water lives, we.... Oh, boo hoo.
.WORD MERMAID4          ; B7 ; You have responded to me!!
.WORD MERMAID5          ; B8 ; This is the Shrine's top floor. The FIEND of Water, KRAKEN lives on the bottom floor.
.WORD MERMAID6          ; B9 ; I suppose you are the legendary....
.WORD MERMAID7          ; BA ; Please save the sea, and make the ORB shine again!
.WORD MERMAID8          ; BB ; Now, order has returned. The sea will be as it was before, beautiful.
.WORD MERMAID9          ; BC ; My friend Darryl went to the land, then never returned. I've often wondered what happened.... Maybe, she grew legs and walked away?
.WORD MERMAID10         ; BD ; Unbelievable!! You can breathe underwater?! I'm impressed!
.WORD MERMAID11         ; BE ; To unlock the Mirage Tower the Lefeinish used a musical tone.
.WORD LOCKEDDOOR        ; BF ; This door is locked by the mystic KEY.
.WORD GAIA1             ; C0 ; This town is Gaia....
.WORD GAIA2             ; C1 ; Have you been to the city south of here? I just cannot understand a word spoken there. I have wondered what language....
.WORD GAIA3             ; C2 ; Legend says the SKY WARRIORS flew about, here and there, from a castle high in the sky.
.WORD GAIA4             ; C3 ; I saw a shining object flying towards the east.
.WORD GAIA5             ; C4 ; Unbelievable! You are outsiders, right? How did you get this far north?
.WORD GAIA6             ; C5 ; Let me see.... Yes, there was a professor that studied Lefeinish.
.WORD GAIA7             ; C6 ; Only a fairy can draw OXYALE from the spring.
.WORD GAIA8             ; C7 ; Everyone thinks the tower in Yahnikurm Desert is a mirage. I wonder....
.WORD GAIA9             ; C8 ; Hardy har, you are too late! I BOTTLED the fairy and sold her to a caravan.
.WORD GAIA10            ; C9 ; Legends say that the castle in the west is a place to test courage.
.WORD GAIA11            ; CA ; ?rewoP taerg evah uoy oD
.WORD GAIA12            ; CB ; What's that broom up to? It's talking backwards!
.WORD GAIA13            ; CC ; The fairy at the spring was kidnapped.
.WORD LEFEIN1           ; CD ; With this CHIME you can enter the Mirage Tower.
.WORD LEFEIN2           ; CE ; The Mirage Tower was the gateway to our home in the sky.
.WORD LEFEIN3           ; CF ; 400 years ago, we had an advanced civilization. Our interest was the universe!!
.WORD LEFEIN4           ; D0 ; Lu....pa....? Lu....pa....?
.WORD LEFEIN5           ; D1 ; We are the Lefeinish. Only our bravest became SKY WARRIORS. Your AIRSHIP was theirs.
.WORD LEFEIN6           ; D2 ; The FLOATING CASTLE.... Our ancestors lived there. The Mirage Tower is the entrance.
.WORD LEFEIN7           ; D3 ; At the time of destruction a legend was born.... In 400 years, WARRIORS with ORBS will appear to save our people. Are you?....
.WORD LEFEIN8           ; D4 ; We fought with TIAMAT, but were unsuccessful. The FIEND now inhabits our FLOATING CASTLE.
.WORD LEFEIN9           ; D5 ; Our last five Warriors left to find the cause of the world's decay. We know they live, but, as bats.
.WORD LEFEIN10          ; D6 ; We knew that a great power controlled the FIENDS. Our five bravest Warriors left, never to return.
.WORD LEFEIN11          ; D7 ; We have passed on the legends from generation to generation. But 400 years have caused our memories to fade.
.WORD LEFEIN12          ; D8 ; Oh, the LIGHT WARRIORS!! The legend is true! Until 400 years ago we controlled the Power of the Wind. This enabled us to suspend the castle in the air.
.WORD LEFEIN13          ; D9 ; Until 400 years ago we ncontrolled the Power of the Wind. This enabled us to suspend the castle in the air.
.WORD LEFEIN14          ; DA ; The power of Wind was taken by TIAMAT.
.WORD GRAVE2            ; DB ; Here lies Erdrick     837 - 866       R.I.P.
.WORD LEFEIN15          ; DC ; I wonder if the robots made by our ancestors are still moving?
.WORD LEFEIN16          ; DD ; The FLOATING CASTLE floats high in the sky, seemingly among the stars.
.WORD TOWERROBOT1       ; DE ; One of us escaped with a CUBE. He floated far to the west.
.WORD TOWERROBOT2       ; DF ; Transporter operation requires a CUBE.
.WORD TOWERROBOT3       ; E0 ; Are you the master?
.WORD SKYWINDOW1        ; E1 ; You can look out over the world from this window.
.WORD CARDIA1           ; E2 ; If you are brave enough, try meeting the King of the Dragons, BAHAMUT.
.WORD CARDIA2           ; E3 ; Unprofitable business is not a practice of the Dragons of Cardia.
.WORD CARDIA3           ; E4 ; Long ago, Dragons and humans lived and traded together.
.WORD CARDIA4           ; E5 ; You are not afraid of me?? Then, I am impressed!
.WORD CARDIA5           ; E6 ; See your face upon the clean water. How dirty! Come! Wash your face!
.WORD CARDIA6           ; E7 ; We are going to the Castle of Ordeal to the northeast. There we will test, and bring back proof of our courage.
.WORD CARDIA7           ; E8 ; The proof of your courage might be anything.
.WORD CARDIA8           ; E9 ; Have you met BAHAMUT, the Dragon King? He honors those with courage as true warriors.
.WORD CARDIA9           ; EA ; Only the courageous ones bring back the proof of their courage.
.WORD CARDIA10          ; EB ; Once in the north, there were beautiful palaces and big mechanical castles.
.WORD CARDIA11          ; EC ; This is BAHAMUT's room.
.WORD CARDIA12          ; ED ; BAHAMUT verifies the true courage of all.
.WORD GRAVE             ; EE ; This is a tomb.
.WORD WELL              ; EF ; This is a well. You might think that there is something to it.... But in fact it is just an ordinary well.
.WORD TREASURE          ; F0 ; In the treasure box, you found....
.WORD TREASUREFULL      ; F1 ; Can't hold anymore.
.WORD TREASUREEMPTY     ; F2 ; The treasure box is empty!
.WORD ALTAREARTH        ; F3 ; The Altar of the Earth.
.WORD ALTARFIRE         ; F4 ; The Altar of the Fire.
.WORD ALTARWATER        ; F5 ; The Altar of the Water.
.WORD ALTARDWIND        ; F6 ; The Altar of the Wind.
.WORD OXYALESPRINGE     ; F7 ; At the bottom of the spring, something is flowing.
.WORD TIAMATSOMETHING   ; F8 ; TIAMAT is the FIEND of the WIND....
.WORD SKYWINDOW2        ; F9 ; From this window one can see the entire world. The Four Forces are flowing together, into the center of the Four Altars. Into the Temple of FIENDS.
.WORD LICH              ; FA ; The FIEND's ball cracks open.... An ominous cloud rises, and an evil shape congeals.... It is LICH, the FIEND of Earth.
.WORD KARY              ; FB ; Is it you, the tinder that defeated the FIEND of the Earth, and disturbed my sleep? I, KARY will now show you the force of Fire, and you shall burn in its flames!!
.WORD KRAKEN            ; FC ; The FIEND's ball is shattered, evaporating all the water. Ho, Ho, Ho.... How foolhardy to dare challenge me, KRAKEN the FIEND of the Water.
.WORD TIAMAT            ; FD ; Lightning erupts from the FIEND's ball.... So, you have come this far.... I, TIAMAT the FIEND of the Wind will now put an end to your adventure!!
.WORD LEFEIN17          ; FE ; What?? You can speak Lefeinish?
.WORD STONEPLATE        ; FF ; There is a stone plate on the floor.... You sense something.... Evil?....



EMPTY: 
.byte $97,$B2,$1C,$1F,$47,$1D,$23,$C0,$00

KING1: 
.byte $95,$92,$90,$91,$9D,$FF,$A0,$8A,$9B,$9B,$92,$98,$9B,$9C,$69,$FF,$93,$B8,$37,$20,$B6,$05,$AC,$B1,$FF,$95,$B8,$AE,$A4,$AB,$B1,$BE,$1E,$B3,$4D,$B3,$1D,$A6,$BC,$C0,$05,$90,$A4,$B5,$AF,$22,$27,$41,$1E,$AE,$AC,$A7,$B1,$A4,$B3,$B3,$40,$05,$B7,$AB,$1A,$99,$B5,$1F,$A6,$2C,$B6,$C0,$FF,$99,$AF,$2B,$3E,$05,$AB,$A8,$AF,$B3,$59,$25,$C4,$C4,$00

KING2: 
.byte $9D,$AB,$22,$AE,$50,$26,$43,$35,$24,$A4,$B9,$1F,$AA,$1B,$1D,$05,$99,$B5,$1F,$A6,$2C,$B6,$C0,$FF,$9D,$B2,$20,$AC,$27,$BC,$26,$B5,$05,$B4,$B8,$2C,$21,$92,$FF,$35,$A7,$A8,$23,$A7,$20,$31,$5C,$A7,$66,$05,$A5,$B8,$61,$B7,$1B,$2E,$1C,$1A,$A6,$3C,$B7,$1F,$3A,$B7,$C0,$05,$90,$B2,$FF,$B1,$46,$BF,$20,$B1,$27,$B0,$A4,$AE,$1A,$1C,$A8,$05,$98,$9B,$8B,$9C,$24,$AB,$1F,$1A,$A4,$AA,$A4,$1F,$C4,$C4,$00

KING3: 
.byte $9D,$AB,$1A,$99,$B5,$1F,$A6,$2C,$1E,$5F,$5D,$BC,$B6,$05,$BA,$B2,$B5,$5C,$A8,$1E,$A4,$A5,$26,$21,$BC,$26,$C0,$00

GARLAND: 
.byte $97,$B2,$36,$B1,$1A,$B7,$26,$A6,$1D,$1E,$B0,$BC,$05,$99,$B5,$1F,$A6,$2C,$B6,$C4,$C4,$05,$95,$92,$90,$91,$9D,$FF,$A0,$8A,$9B,$9B,$92,$98,$9B,$9C,$C5,$C5,$05,$A2,$B2,$B8,$2D,$B0,$B3,$25,$B7,$1F,$3A,$21,$A9,$B2,$B2,$AF,$B6,$C0,$05,$92,$BF,$FF,$90,$2F,$AF,$22,$A7,$BF,$33,$AC,$4E,$FF,$AE,$B1,$B2,$A6,$AE,$05,$BC,$B2,$B8,$20,$4E,$67,$46,$B1,$C4,$C4,$00

PRINCESS1: 
.byte $9C,$B2,$BF,$50,$26,$20,$B5,$1A,$1C,$A8,$05,$95,$92,$90,$91,$9D,$FF,$A0,$8A,$9B,$9B,$92,$98,$9B,$9C,$C4,$05,$9D,$AB,$22,$AE,$50,$26,$C0,$00

PRINCESS2: 
.byte $9D,$AB,$AC,$1E,$95,$9E,$9D,$8E,$FF,$41,$1E,$62,$3A,$05,$B3,$A4,$B6,$3E,$27,$A7,$46,$29,$A9,$B5,$49,$FF,$9A,$B8,$A8,$3A,$05,$B7,$B2,$FF,$99,$B5,$1F,$A6,$2C,$1E,$A9,$35,$FF,$82,$80,$80,$80,$05,$BC,$A8,$2F,$B6,$C0,$FF,$90,$2F,$AF,$22,$A7,$24,$28,$AF,$1A,$5B,$05,$BA,$AB,$A8,$29,$AB,$1A,$AE,$AC,$A7,$B1,$A4,$B3,$B3,$A8,$27,$34,$C0,$05,$99,$AF,$2B,$B6,$1A,$5E,$48,$B3,$21,$5B,$20,$1E,$B0,$BC,$05,$AA,$AC,$A9,$B7,$BF,$2D,$21,$AD,$B8,$B6,$21,$B0,$AC,$AA,$AB,$21,$A6,$B2,$34,$05,$AC,$B1,$59,$22,$A7,$BC,$C0,$00

PRINCESS3: 
.byte $97,$B2,$BA,$BF,$FF,$66,$21,$23,$A4,$A7,$BC,$43,$35,$50,$26,$B5,$05,$B7,$B5,$AC,$B3,$BF,$20,$B1,$27,$B0,$A4,$AE,$1A,$1C,$1A,$98,$9B,$8B,$9C,$05,$B6,$AB,$1F,$1A,$A4,$AA,$A4,$1F,$C0,$00

PIRATE1: 
.byte $8A,$BC,$A8,$BF,$FF,$92,$20,$B0,$FF,$8B,$AC,$AE,$AE,$1A,$1C,$A8,$05,$99,$AC,$B5,$39,$A8,$BF,$20,$3B,$24,$55,$B3,$B5,$30,$A8,$27,$92,$05,$A4,$B0,$1B,$41,$21,$BC,$26,$24,$A6,$55,$B9,$4B,$A7,$B2,$AA,$B6,$05,$AB,$A4,$B9,$1A,$1C,$1A,$B1,$25,$B9,$1A,$28,$43,$A4,$48,$05,$B0,$A8,$C0,$05,$96,$A4,$B7,$2C,$C4,$05,$90,$A8,$B7,$1B,$AB,$B2,$B6,$1A,$AF,$22,$A7,$AF,$B8,$A5,$A5,$25,$B6,$C4,$00

PIRATE2: 
.byte $98,$AE,$A4,$BC,$BF,$50,$26,$FF,$AA,$B2,$21,$34,$C0,$05,$9D,$A4,$AE,$1A,$B0,$4B,$9C,$91,$92,$99,$C0,$00

PIRATE3: 
.byte $92,$FF,$BA,$3C,$BE,$21,$A5,$1A,$22,$BC,$42,$B2,$23,$05,$A5,$B2,$1C,$25,$C0,$FF,$92,$4F,$B5,$49,$30,$A8,$C0,$00

HEALER1: 
.byte $8F,$B2,$B5,$43,$AC,$B9,$1A,$BC,$2B,$63,$1B,$1D,$05,$99,$B5,$1F,$A6,$1A,$41,$1E,$B6,$45,$B3,$B7,$05,$B8,$B1,$A7,$25,$FF,$8A,$B6,$28,$B6,$BE,$24,$B3,$A8,$4E,$C0,$05,$98,$B1,$AF,$4B,$91,$8E,$9B,$8B,$38,$22,$33,$A4,$AE,$1A,$3D,$B0,$C4,$00

HEALER2: 
.byte $98,$AB,$BF,$1B,$3D,$1E,$91,$8E,$9B,$8B,$33,$AC,$4E,$05,$B5,$A8,$AF,$2B,$B6,$1A,$1C,$1A,$99,$B5,$1F,$A6,$1A,$A9,$B5,$49,$05,$8A,$B6,$28,$B6,$BE,$38,$55,$3E,$C0,$FF,$95,$B2,$B2,$AE,$C4,$05,$91,$A8,$2D,$1E,$5D,$AE,$1F,$AA,$69,$00

HEALER3: 
.byte $9D,$AB,$22,$AE,$50,$26,$C0,$05,$99,$A8,$5E,$1A,$BA,$AC,$4E,$FF,$23,$B7,$55,$B1,$1B,$B2,$05,$8E,$AF,$A9,$95,$22,$A7,$C0,$00

PRINCE1: 
.byte $92,$B6,$1B,$3D,$1E,$A4,$67,$23,$A4,$B0,$C5,$69,$05,$8A,$B5,$1A,$BC,$26,$BF,$1B,$1D,$05,$95,$92,$90,$91,$9D,$FF,$A0,$8A,$9B,$9B,$92,$98,$9B,$9C,$C5,$69,$05,$92,$B6,$1B,$3D,$1E,$A9,$35,$FF,$23,$5F,$C5,$69,$05,$9C,$B2,$BF,$20,$1E,$45,$AA,$3A,$A7,$24,$A4,$BC,$B6,$BF,$05,$92,$FF,$AA,$AC,$B9,$1A,$BC,$26,$1B,$AB,$1A,$B0,$BC,$37,$AC,$A6,$05,$94,$8E,$A2,$C0,$00

PRINCE2: 
.byte $92,$FF,$A9,$A8,$A8,$58,$A9,$1F,$1A,$B1,$46,$C0,$05,$9D,$AB,$22,$AE,$50,$26,$C0,$00

PRINCE3:
.byte $BD,$C3,$C3,$BD,$C3,$C3,$00

ASTOS1: 
.byte $8A,$B6,$28,$1E,$A7,$26,$A5,$45,$C2,$A6,$4D,$B6,$3E,$27,$B8,$B6,$C0,$05,$90,$B2,$24,$26,$1C,$BF,$1B,$2E,$1C,$1A,$8C,$A4,$B9,$1A,$4C,$05,$96,$A4,$63,$AB,$BF,$1B,$2E,$23,$B7,$5C,$A8,$B9,$1A,$1C,$A8,$05,$8C,$9B,$98,$A0,$97,$C0,$FF,$9D,$1D,$B1,$BF,$31,$B5,$1F,$AA,$2D,$B7,$05,$A7,$AC,$23,$A6,$B7,$AF,$BC,$31,$5E,$AE,$1B,$2E,$34,$C4,$00

ASTOS2: 
.byte $91,$8A,$BF,$FF,$91,$8A,$BF,$FF,$91,$8A,$C4,$FF,$92,$20,$B0,$FF,$8A,$B6,$28,$B6,$BF,$05,$94,$AC,$2A,$36,$A9,$1B,$AB,$1A,$8D,$2F,$AE,$FF,$8E,$AF,$B9,$2C,$C0,$05,$92,$FF,$41,$B9,$1A,$96,$A4,$28,$BC,$A4,$BE,$1E,$8C,$9B,$A2,$9C,$9D,$8A,$95,$BF,$05,$A4,$B1,$27,$BC,$26,$24,$41,$4E,$FF,$AA,$AC,$B9,$1A,$34,$05,$B7,$AB,$A4,$21,$8C,$9B,$98,$A0,$97,$BF,$FF,$B1,$46,$C4,$C4,$C4,$00

TNTDWARF1: 
.byte $8A,$FF,$4D,$A6,$AE,$31,$AF,$B2,$A6,$AE,$B6,$05,$A6,$B2,$B1,$37,$B5,$B8,$A6,$57,$B2,$29,$4C,$42,$BC,$05,$A6,$A4,$B1,$5F,$C0,$05,$92,$A9,$FF,$92,$36,$B1,$AF,$4B,$41,$27,$9D,$97,$9D,$C0,$00

TNTDWARF2: 
.byte $98,$AB,$BF,$33,$B2,$3B,$25,$A9,$B8,$AF,$C4,$05,$97,$AC,$A6,$1A,$BA,$35,$AE,$C4,$FF,$A2,$2C,$BF,$50,$2C,$05,$AC,$B1,$A7,$A8,$40,$BF,$1B,$3D,$1E,$9D,$97,$9D,$2D,$1E,$AD,$B8,$37,$05,$BA,$AB,$A4,$21,$92,$FF,$5A,$40,$1B,$2E,$A9,$1F,$30,$AB,$42,$BC,$05,$A6,$A4,$B1,$5F,$C0,$FF,$97,$46,$FF,$A8,$BB,$A6,$B8,$B6,$1A,$34,$05,$BA,$AB,$61,$1A,$92,$FF,$66,$B7,$1B,$2E,$BA,$35,$AE,$C4,$00

BLACKSMITH1: 
.byte $8F,$B2,$B5,$1B,$AB,$1A,$95,$92,$90,$91,$9D,$05,$A0,$8A,$9B,$9B,$92,$98,$9B,$9C,$FF,$92,$33,$AC,$4E,$42,$A4,$AE,$1A,$A4,$05,$B7,$B5,$B8,$AF,$4B,$45,$AA,$3A,$A7,$2F,$BC,$24,$BA,$35,$A7,$C0,$05,$91,$B2,$60,$B9,$25,$BF,$42,$BC,$24,$B8,$B3,$B3,$AF,$BC,$36,$A9,$05,$8A,$8D,$8A,$52,$97,$9D,$2D,$1E,$A8,$BB,$41,$B8,$37,$40,$C0,$00

BLACKSMITH2: 
.byte $8A,$8D,$8A,$52,$97,$9D,$C4,$C4,$05,$97,$B2,$BA,$FF,$45,$21,$B0,$1A,$B0,$A4,$AE,$A8,$05,$B7,$AB,$1A,$B6,$BA,$35,$27,$A9,$35,$50,$26,$69,$05,$91,$A8,$23,$BF,$1B,$AB,$1A,$A5,$2C,$21,$BA,$35,$AE,$FF,$92,$BE,$32,$05,$A8,$B9,$25,$67,$3C,$A8,$C0,$05,$92,$B7,$2D,$1E,$B0,$4B,$AA,$AC,$A9,$B7,$C0,$00

MATOYA1: 
.byte $A0,$AB,$25,$1A,$AC,$1E,$B0,$4B,$8C,$9B,$A2,$9C,$9D,$8A,$95,$C5,$05,$92,$FF,$A6,$22,$BE,$21,$3E,$1A,$22,$BC,$1C,$1F,$AA,$05,$BA,$AC,$1C,$26,$21,$5B,$69,$FF,$A0,$AB,$B2,$24,$28,$45,$05,$B0,$BC,$FF,$8C,$9B,$A2,$9C,$9D,$8A,$95,$C5,$00

GENERICPRAISE: 
.byte $A0,$8A,$9B,$9B,$92,$98,$9B,$9C,$C0,$05,$9B,$A8,$B9,$AC,$B9,$1A,$1C,$1A,$99,$46,$25,$36,$A9,$05,$B7,$AB,$1A,$98,$9B,$8B,$9C,$C4,$00

MATOYA2: 
.byte $9D,$AB,$1A,$99,$B5,$1F,$A6,$1A,$5A,$40,$1E,$91,$8E,$9B,$8B,$C5,$05,$92,$BE,$4E,$1B,$B5,$A4,$A7,$1A,$1C,$1A,$B0,$B2,$37,$05,$B3,$B2,$BA,$25,$A9,$B8,$58,$91,$8E,$9B,$8B,$1B,$2E,$66,$21,$B0,$BC,$05,$8C,$9B,$A2,$9C,$9D,$8A,$95,$31,$5E,$AE,$69,$05,$98,$AB,$C4,$FF,$92,$38,$22,$24,$A8,$A8,$C4,$C4,$00

MATOYA3: 
.byte $A2,$B2,$64,$41,$B9,$1A,$B1,$2E,$B0,$B2,$23,$05,$A5,$B8,$B6,$1F,$2C,$1E,$1D,$23,$C0,$FF,$90,$B2,$C4,$C4,$00

UNNE1: 
.byte $8E,$B9,$25,$BC,$A5,$B2,$A7,$4B,$AE,$B1,$46,$1E,$34,$C0,$05,$A0,$AB,$39,$C5,$C4,$FF,$A2,$26,$BE,$B9,$1A,$5A,$B9,$25,$05,$AB,$A8,$2F,$27,$4C,$FF,$8D,$B5,$C0,$FF,$9E,$B1,$5A,$C5,$00

UNNE2: 
.byte $8A,$FF,$9C,$95,$8A,$8B,$C4,$C4,$05,$9D,$AB,$AC,$1E,$9C,$95,$8A,$8B,$33,$AC,$4E,$65,$2B,$27,$B8,$B6,$05,$B7,$B2,$24,$B2,$AF,$B9,$1A,$1C,$1A,$5C,$A7,$A7,$AF,$1A,$4C,$05,$B7,$AB,$1A,$95,$A8,$A9,$A8,$1F,$30,$AB,$C4,$C4,$05,$97,$B2,$BA,$BF,$65,$30,$B7,$3A,$1B,$2E,$34,$69,$00

VAMPIRE: 
.byte $8A,$AF,$58,$68,$B9,$1F,$AA,$1B,$AB,$1F,$AA,$1E,$60,$23,$05,$A5,$B2,$B5,$B1,$1B,$2E,$A7,$AC,$A8,$C0,$05,$97,$B2,$36,$B1,$1A,$A6,$22,$67,$A8,$A9,$2B,$21,$34,$BF,$05,$B7,$AB,$1A,$9F,$A4,$B0,$B3,$AC,$23,$C4,$C4,$00

SARDA: 
.byte $9E,$B6,$1A,$1C,$AC,$1E,$9B,$98,$8D,$31,$A8,$AB,$1F,$A7,$1B,$1D,$05,$9F,$A4,$B0,$B3,$AC,$23,$BE,$1E,$4D,$49,$C0,$FF,$91,$AC,$A7,$1F,$AA,$05,$A7,$A8,$A8,$B3,$FF,$1F,$B6,$AC,$A7,$1A,$BC,$26,$33,$AC,$4E,$05,$A9,$AC,$3B,$1B,$AB,$1A,$51,$B8,$B6,$1A,$4C,$1B,$1D,$05,$A8,$A4,$B5,$1C,$BE,$1E,$4D,$B7,$C0,$00

BAHAMUT1: 
.byte $92,$FF,$A4,$B0,$FF,$8B,$8A,$91,$8A,$96,$9E,$9D,$BF,$FF,$94,$1F,$AA,$36,$A9,$05,$B7,$AB,$1A,$8D,$B5,$A4,$AA,$3C,$B6,$C0,$FF,$8B,$B5,$1F,$47,$34,$05,$B3,$B5,$B2,$4C,$36,$A9,$50,$26,$B5,$38,$26,$B5,$A4,$66,$BF,$05,$B7,$B2,$FF,$23,$48,$AC,$B9,$1A,$1C,$1A,$AB,$3C,$35,$05,$A7,$B8,$1A,$B7,$B5,$B8,$1A,$A0,$2F,$5C,$35,$B6,$C0,$00

BAHAMUT2: 
.byte $9D,$AB,$1A,$9D,$8A,$92,$95,$36,$A9,$20,$FF,$B5,$A4,$21,$B3,$4D,$B9,$2C,$05,$BC,$B2,$55,$38,$B2,$55,$A4,$66,$C0,$FF,$92,$24,$41,$4E,$05,$AA,$AC,$B9,$1A,$BC,$26,$1B,$AB,$1A,$AB,$3C,$35,$67,$B8,$A8,$05,$B7,$B5,$B8,$1A,$A0,$2F,$5C,$35,$B6,$C0,$00

BLACKORB1: 
.byte $9D,$AB,$1A,$A9,$26,$44,$98,$9B,$8B,$9C,$FF,$B1,$46,$38,$B2,$B9,$25,$05,$B7,$AB,$1A,$A5,$AF,$5E,$AE,$FF,$98,$9B,$8B,$69,$05,$9D,$B2,$1B,$A4,$AE,$1A,$A4,$24,$53,$B3,$43,$35,$BA,$2F,$A7,$05,$AC,$B6,$1B,$2E,$AA,$B2,$31,$5E,$AE,$FF,$82,$80,$80,$80,$50,$2B,$63,$05,$AC,$B1,$1B,$AC,$34,$C0,$00

BLACKORB2: 
.byte $9D,$AB,$1A,$A5,$AF,$5E,$AE,$FF,$98,$9B,$8B,$05,$AA,$AF,$5B,$B7,$25,$1E,$49,$1F,$26,$B6,$AF,$BC,$69,$05,$8B,$B8,$21,$B1,$B2,$1C,$1F,$47,$41,$B3,$B3,$3A,$B6,$C0,$00

FAIRY1: 
.byte $9D,$AB,$A4,$21,$B3,$AC,$B5,$39,$1A,$B7,$B5,$A4,$B3,$B3,$A8,$27,$34,$05,$AC,$B1,$1B,$AB,$1A,$8B,$98,$9D,$9D,$95,$8E,$C0,$05,$92,$FF,$BA,$AC,$4E,$67,$B5,$A4,$BA,$FF,$98,$A1,$A2,$8A,$95,$8E,$43,$B5,$49,$05,$B7,$AB,$1A,$A5,$B2,$B7,$28,$B0,$36,$A9,$1B,$AB,$1A,$B6,$B3,$B5,$1F,$AA,$05,$A9,$B2,$44,$BC,$26,$C0,$00

FAIRY2: 
.byte $9D,$AB,$22,$AE,$50,$26,$43,$35,$24,$A4,$B9,$1F,$47,$34,$C0,$05,$9B,$A8,$34,$B0,$A5,$25,$C4,$FF,$98,$A1,$A2,$8A,$95,$8E,$33,$AC,$4E,$05,$AA,$AC,$B9,$1A,$BC,$26,$20,$AC,$B5,$C0,$00

ENGINEER1: 
.byte $92,$FF,$B0,$A4,$A7,$1A,$A4,$24,$B8,$A5,$B0,$2F,$1F,$1A,$28,$05,$B6,$A4,$B9,$1A,$1C,$1A,$B0,$25,$B0,$A4,$AC,$A7,$B6,$C0,$FF,$8B,$B8,$B7,$BF,$05,$B7,$B2,$FF,$AA,$B2,$67,$A8,$A8,$B3,$FF,$3A,$26,$AA,$AB,$2D,$B7,$05,$BA,$AC,$4E,$FF,$23,$B4,$B8,$AC,$B5,$1A,$98,$A1,$A2,$8A,$95,$8E,$C0,$00

ENGINEER2: 
.byte $A0,$8A,$9B,$9B,$92,$98,$9B,$9C,$BF,$50,$26,$FF,$41,$32,$05,$98,$A1,$A2,$8A,$95,$8E,$C0,$FF,$9D,$AB,$1A,$B0,$25,$B0,$A4,$AC,$A7,$B6,$05,$BA,$A4,$5B,$BF,$4F,$AF,$2B,$B6,$1A,$1D,$AF,$B3,$1B,$1D,$B0,$C4,$00

ROBOT1: 
.byte $9D,$A4,$AE,$1A,$1C,$AC,$1E,$8C,$9E,$8B,$8E,$C0,$FF,$A0,$AC,$1C,$2D,$B7,$BF,$05,$BC,$B2,$B8,$38,$22,$1B,$B5,$22,$B6,$A9,$25,$1B,$2E,$1C,$A8,$05,$8F,$95,$98,$8A,$9D,$92,$97,$90,$FF,$8C,$8A,$9C,$9D,$95,$8E,$C0,$00

ROBOT2: 
.byte $99,$AF,$2B,$3E,$69,$00

TITAN1: 
.byte $97,$B2,$36,$B1,$1A,$B3,$3F,$B6,$2C,$1B,$3D,$1E,$4D,$A4,$A7,$C0,$00

TITAN2: 
.byte $92,$A9,$50,$26,$33,$22,$21,$B3,$3F,$B6,$BF,$FF,$AA,$AC,$32,$05,$B0,$A8,$1B,$1D,$FF,$9B,$9E,$8B,$A2,$69,$05,$8C,$B5,$B8,$B1,$A6,$AB,$BF,$38,$B5,$B8,$B1,$A6,$AB,$BF,$38,$B5,$B8,$B1,$A6,$AB,$BF,$05,$B0,$B0,$B0,$BF,$2D,$B7,$1B,$A4,$37,$A8,$1E,$B6,$B2,$24,$60,$A8,$B7,$C0,$05,$9B,$B8,$A5,$AC,$A8,$1E,$2F,$1A,$B0,$BC,$43,$A4,$B9,$35,$AC,$53,$C0,$00

CANOESAGE1: 
.byte $90,$B5,$2B,$21,$AD,$B2,$A5,$FF,$B9,$22,$B4,$B8,$30,$AB,$1F,$AA,$05,$B7,$AB,$1A,$8E,$2F,$B7,$AB,$FF,$8F,$92,$8E,$97,$8D,$C0,$FF,$97,$46,$BF,$05,$B7,$AB,$1A,$8F,$AC,$B5,$1A,$8F,$92,$8E,$97,$8D,$33,$A4,$AE,$2C,$C0,$05,$A0,$AC,$1C,$1B,$3D,$1E,$8C,$8A,$97,$98,$8E,$FF,$AA,$B2,$1B,$B2,$05,$B7,$AB,$1A,$9F,$98,$95,$8C,$8A,$97,$98,$BF,$20,$B1,$27,$A7,$A8,$A9,$2B,$B7,$05,$B7,$AB,$A4,$21,$8F,$92,$8E,$97,$8D,$20,$AF,$B6,$B2,$C4,$00

CANOESAGE2: 
.byte $84,$80,$80,$50,$2B,$B5,$1E,$A4,$AA,$B2,$BF,$33,$1A,$AF,$B2,$37,$05,$A6,$B2,$B1,$B7,$4D,$AF,$36,$A9,$1B,$AB,$1A,$A0,$1F,$A7,$C0,$05,$82,$80,$80,$50,$2B,$B5,$1E,$AF,$39,$25,$33,$1A,$AF,$B2,$37,$05,$B7,$AB,$1A,$A0,$39,$25,$BF,$1B,$1D,$29,$8E,$2F,$B7,$AB,$BF,$05,$A4,$B1,$27,$8F,$AC,$B5,$1A,$A9,$B2,$4E,$46,$40,$C0,$FF,$9D,$1D,$05,$99,$B2,$BA,$25,$B6,$1B,$41,$21,$A5,$1F,$A7,$1B,$AB,$30,$05,$BA,$B2,$B5,$AF,$A7,$20,$B5,$1A,$AA,$3C,$A8,$C0,$00

ORDEALSGHOST: 
.byte $99,$B2,$B6,$B6,$2C,$B6,$AC,$B2,$29,$4C,$1B,$AB,$1A,$8C,$9B,$98,$A0,$97,$05,$AC,$B6,$FF,$23,$B4,$B8,$AC,$23,$A7,$1B,$2E,$B7,$2C,$21,$BC,$26,$B5,$05,$A6,$B2,$55,$A4,$66,$C0,$FF,$9D,$A4,$AE,$1A,$5B,$1B,$2E,$1C,$A8,$05,$B5,$B2,$BC,$5F,$1B,$AB,$B5,$3C,$A8,$BF,$20,$B1,$27,$A5,$B5,$1F,$AA,$05,$A5,$A4,$A6,$AE,$4F,$4D,$4C,$36,$A9,$50,$26,$B5,$05,$A6,$B2,$55,$A4,$66,$C0,$FF,$90,$98,$98,$8D,$FF,$95,$9E,$8C,$94,$C4,$00

CHAOS1: 
.byte $9B,$A8,$34,$B0,$A5,$25,$FF,$34,$BF,$FF,$90,$2F,$AF,$22,$A7,$C5,$05,$A2,$B2,$B8,$44,$B3,$B8,$B1,$4B,$AF,$B2,$B7,$1B,$AB,$B2,$B8,$AA,$AB,$21,$5B,$05,$AB,$A4,$27,$A7,$A8,$A9,$2B,$53,$27,$34,$C0,$FF,$8B,$B8,$B7,$BF,$05,$B7,$AB,$1A,$8F,$26,$44,$8F,$92,$8E,$97,$8D,$9C,$24,$3A,$21,$34,$05,$A5,$A4,$A6,$AE,$FF,$82,$80,$80,$80,$50,$2B,$B5,$1E,$1F,$28,$05,$B7,$AB,$1A,$B3,$A4,$37,$C0,$00

CHAOS2: 
.byte $8F,$B5,$49,$FF,$1D,$B5,$1A,$92,$24,$3A,$B7,$1B,$1D,$05,$8F,$B2,$B8,$44,$8F,$92,$8E,$97,$8D,$9C,$1B,$2E,$1C,$A8,$05,$A9,$B8,$B7,$B8,$23,$C0,$FF,$9D,$AB,$1A,$8F,$92,$8E,$97,$8D,$9C,$33,$AC,$4E,$05,$B6,$A8,$B1,$27,$B0,$1A,$A5,$5E,$AE,$1B,$2E,$1D,$23,$BF,$05,$A4,$B1,$A7,$1B,$AB,$1A,$9D,$AC,$34,$C2,$95,$B2,$B2,$B3,$33,$AC,$4E,$05,$AA,$B2,$36,$B1,$C0,$00

CHAOS3: 
.byte $8A,$A9,$B7,$25,$FF,$82,$80,$80,$80,$50,$2B,$63,$BF,$FF,$92,$33,$AC,$4E,$05,$A5,$A8,$43,$35,$AA,$B2,$B7,$B7,$3A,$BF,$20,$3B,$1B,$1D,$05,$9D,$AC,$34,$C2,$95,$B2,$B2,$B3,$33,$AC,$4E,$38,$AF,$B2,$3E,$C0,$FF,$92,$05,$BA,$AC,$4E,$65,$AC,$B9,$1A,$A9,$B2,$23,$B9,$25,$BF,$20,$3B,$05,$BC,$B2,$B8,$24,$41,$4E,$FF,$34,$A8,$21,$A7,$B2,$49,$C4,$C4,$00

CORNERIACASTLE1: 
.byte $9D,$AB,$1A,$94,$1F,$AA,$2D,$1E,$AF,$B2,$B2,$AE,$1F,$AA,$43,$35,$05,$B7,$AB,$1A,$95,$92,$90,$91,$9D,$FF,$A0,$8A,$9B,$9B,$92,$98,$9B,$9C,$C0,$FF,$A2,$26,$05,$A7,$B2,$FF,$B1,$B2,$21,$41,$B3,$B3,$3A,$1B,$B2,$31,$1A,$1C,$A8,$B0,$05,$A7,$B2,$50,$26,$C5,$00

CORNERIACASTLE2: 
.byte $A2,$A8,$1E,$9C,$AC,$B5,$C4,$C4,$05,$92,$FF,$62,$AF,$B2,$2A,$1B,$2E,$1C,$1A,$91,$3C,$35,$05,$90,$B8,$2F,$27,$4C,$FF,$8C,$A4,$37,$AF,$1A,$8C,$3C,$25,$AC,$A4,$C0,$00

CORNERIACASTLE3: 
.byte $99,$AF,$2B,$3E,$C4,$05,$9C,$A4,$B9,$1A,$1C,$1A,$99,$B5,$1F,$A6,$2C,$B6,$C4,$00

CORNERIACASTLE4: 
.byte $9D,$AB,$22,$AE,$50,$26,$43,$35,$FF,$23,$B6,$A6,$B8,$1F,$AA,$05,$B7,$AB,$1A,$99,$B5,$1F,$A6,$2C,$B6,$C0,$00

CORNERIACASTLE5: 
.byte $95,$A8,$AA,$3A,$A7,$24,$A4,$BC,$B6,$1B,$AB,$39,$1B,$1D,$05,$95,$9E,$9D,$8E,$38,$22,$31,$23,$A4,$AE,$1B,$AB,$1A,$A8,$B9,$61,$05,$AA,$A4,$53,$C0,$00

CORNERIACASTLE6: 
.byte $90,$A4,$B5,$AF,$22,$27,$B8,$3E,$A7,$1B,$2E,$A5,$1A,$A4,$05,$AA,$B2,$B2,$27,$AE,$B1,$AC,$AA,$AB,$21,$B8,$B1,$57,$AF,$69,$00

CORNERIACASTLE7: 
.byte $92,$B1,$24,$A4,$A7,$B1,$2C,$B6,$BF,$1B,$AB,$1A,$9A,$B8,$A8,$3A,$05,$AF,$B2,$A6,$AE,$A8,$27,$1D,$B5,$3E,$AF,$54,$1F,$B6,$AC,$A7,$A8,$C0,$00

CORNERIACASTLE8: 
.byte $9D,$AB,$1A,$99,$B5,$1F,$A6,$2C,$1E,$BA,$3F,$05,$AF,$B2,$B2,$AE,$1F,$AA,$43,$35,$50,$26,$C4,$00

CORNERIACASTLE9: 
.byte $9C,$B2,$BF,$50,$26,$20,$B5,$1A,$1C,$A8,$05,$95,$92,$90,$91,$9D,$FF,$A0,$8A,$9B,$9B,$92,$98,$9B,$9C,$C5,$00

BLACKSMITH3: 
.byte $8D,$B2,$B1,$BE,$21,$A5,$1A,$AA,$23,$40,$BC,$C0,$FF,$A2,$26,$05,$A4,$AF,$23,$A4,$A7,$4B,$41,$B9,$1A,$28,$2E,$B0,$22,$BC,$05,$BA,$A8,$A4,$B3,$3C,$B6,$1B,$2E,$A6,$2F,$B5,$BC,$C0,$00

CORNERIACASTLE10: 
.byte $92,$FF,$A4,$B0,$FF,$93,$22,$A8,$BF,$FF,$9A,$B8,$A8,$A8,$29,$4C,$05,$8C,$B2,$B1,$25,$AC,$A4,$C0,$FF,$99,$AF,$2B,$B6,$1A,$B6,$A4,$B9,$1A,$B0,$BC,$05,$A7,$A4,$B8,$AA,$AB,$B7,$25,$BF,$FF,$99,$B5,$1F,$A6,$2C,$1E,$9C,$2F,$A4,$C0,$00

CORNERIACASTLE11: 
.byte $9D,$AB,$22,$AE,$50,$26,$43,$35,$24,$A4,$B9,$1F,$AA,$05,$99,$B5,$1F,$A6,$2C,$1E,$9C,$2F,$A4,$C0,$00

CORNERIACASTLE12: 
.byte $98,$AB,$69,$FF,$96,$BC,$24,$30,$B7,$25,$69,$00

CORNERIACASTLE13: 
.byte $96,$BC,$24,$30,$B7,$25,$2D,$1E,$A5,$5E,$AE,$24,$A4,$A9,$A8,$C4,$05,$9D,$AB,$22,$AE,$50,$26,$C0,$00

CORNERIACASTLE14: 
.byte $9B,$A8,$B3,$35,$B7,$1E,$B6,$A4,$BC,$1B,$41,$21,$90,$2F,$AF,$22,$A7,$05,$AB,$B2,$AF,$A7,$B6,$1B,$AB,$1A,$99,$B5,$1F,$A6,$2C,$1E,$1F,$20,$05,$9D,$A8,$B0,$B3,$AF,$1A,$28,$1B,$AB,$1A,$B1,$35,$1C,$BA,$2C,$B7,$C0,$00

CORNERIACASTLE15: 
.byte $9E,$B6,$1A,$1C,$A4,$21,$94,$8E,$A2,$C0,$FF,$92,$B1,$B6,$AC,$A7,$A8,$05,$BA,$AB,$A4,$21,$BC,$26,$43,$1F,$27,$BA,$AC,$4E,$31,$A8,$05,$B4,$B8,$5B,$1A,$1D,$AF,$B3,$A9,$B8,$AF,$C0,$00

CORNERIACASTLE16: 
.byte $84,$80,$80,$50,$2B,$B5,$1E,$A4,$AA,$B2,$1B,$1D,$05,$9D,$B5,$2B,$B6,$55,$BC,$33,$A4,$1E,$AF,$B2,$A6,$AE,$A8,$27,$A5,$BC,$05,$B7,$AB,$1A,$B0,$BC,$37,$AC,$A6,$FF,$94,$8E,$A2,$C0,$FF,$98,$55,$05,$A4,$B1,$A6,$2C,$28,$B5,$1E,$AA,$A4,$B9,$1A,$1C,$1A,$94,$8E,$A2,$05,$B7,$B2,$1B,$AB,$1A,$99,$B5,$1F,$A6,$1A,$4C,$FF,$8E,$AF,$A9,$95,$22,$A7,$05,$A9,$B2,$B5,$24,$A4,$A9,$A8,$AE,$A8,$A8,$B3,$1F,$AA,$C0,$00

CORNERIACASTLE17: 
.byte $9D,$AB,$30,$1B,$23,$3F,$55,$1A,$4D,$49,$2D,$B6,$05,$AF,$B2,$A6,$AE,$A8,$27,$BA,$AC,$1C,$1B,$AB,$1A,$B0,$BC,$37,$AC,$51,$AF,$05,$94,$8E,$A2,$C0,$00

CORNERIACASTLE18: 
.byte $9D,$AB,$1A,$94,$1F,$AA,$2D,$1E,$B6,$55,$1A,$1C,$39,$05,$B6,$B2,$34,$A7,$A4,$BC,$1B,$AB,$1A,$95,$92,$90,$91,$9D,$05,$A0,$8A,$9B,$9B,$92,$98,$9B,$9C,$33,$AC,$4E,$38,$49,$1A,$28,$05,$B6,$A4,$B9,$1A,$1C,$1A,$99,$B5,$1F,$A6,$2C,$B6,$BF,$05,$AD,$B8,$37,$20,$1E,$1F,$FF,$95,$B8,$AE,$A4,$AB,$B1,$BE,$B6,$05,$B3,$B5,$B2,$B3,$1D,$A6,$BC,$C0,$00

CORNERIATOWN1: 
.byte $95,$B8,$AE,$A4,$AB,$29,$45,$A9,$B7,$1B,$AB,$30,$1B,$46,$B1,$BF,$05,$B7,$B2,$FF,$AD,$B2,$1F,$FF,$3D,$1E,$A6,$B2,$4E,$2B,$AA,$B8,$2C,$05,$A4,$B7,$FF,$8C,$23,$B6,$A6,$3A,$B7,$FF,$95,$A4,$AE,$A8,$C0,$00

CORNERIATOWN2: 
.byte $8A,$B6,$FF,$45,$AA,$3A,$27,$A9,$B2,$23,$28,$AF,$A7,$BF,$36,$B1,$48,$05,$A4,$AA,$A4,$1F,$1B,$AB,$1A,$98,$9B,$8B,$9C,$24,$AB,$1F,$A8,$C4,$C4,$05,$9A,$B8,$AC,$A6,$AE,$AF,$BC,$BF,$1B,$2E,$A9,$B8,$AF,$A9,$AC,$4E,$1B,$1D,$05,$AF,$A8,$AA,$3A,$A7,$BF,$1B,$A4,$AE,$1A,$1C,$A8,$B0,$1B,$2E,$1C,$A8,$05,$9D,$A8,$B0,$B3,$AF,$1A,$B1,$35,$1C,$36,$54,$1D,$23,$BF,$05,$A4,$B1,$A7,$24,$B7,$A4,$B1,$27,$1F,$1B,$AB,$1A,$A6,$3A,$B7,$25,$C0,$00

CORNERIATOWN3: 
.byte $90,$B2,$1B,$2E,$1C,$1A,$94,$1F,$AA,$C0,$00

CORNERIATOWN4: 
.byte $92,$FF,$A4,$B0,$FF,$8A,$B5,$BC,$AF,$3C,$BF,$1B,$AB,$1A,$8D,$22,$A6,$25,$C4,$00

CORNERIATOWN5: 
.byte $9D,$AB,$AC,$1E,$30,$FF,$8C,$3C,$25,$AC,$A4,$BF,$1B,$1D,$05,$A7,$B5,$2B,$B0,$38,$5B,$BC,$C0,$00

CORNERIATOWN6: 
.byte $97,$B2,$B5,$1C,$36,$54,$8C,$3C,$25,$AC,$A4,$65,$AC,$B9,$2C,$05,$A4,$FF,$BA,$5B,$A6,$AB,$FF,$B1,$A4,$34,$27,$96,$A4,$28,$BC,$A4,$C0,$00

CORNERIATOWN7: 
.byte $96,$A4,$28,$BC,$A4,$FF,$41,$1E,$B3,$B2,$35,$05,$A8,$BC,$2C,$AC,$AA,$AB,$B7,$C0,$FF,$9C,$AB,$1A,$5A,$40,$B6,$1B,$1D,$05,$8C,$9B,$A2,$9C,$9D,$8A,$95,$1B,$B2,$24,$A8,$A8,$C0,$00

CORNERIATOWN8: 
.byte $96,$BC,$59,$49,$1A,$AC,$1E,$99,$B5,$A4,$B9,$B2,$AE,$A4,$BF,$20,$05,$A5,$A8,$A4,$B8,$57,$A9,$B8,$AF,$4F,$35,$21,$A6,$5B,$BC,$43,$2F,$05,$A8,$A4,$B6,$21,$4C,$FF,$1D,$23,$C0,$00

CUTEBAT: 
.byte $94,$A8,$A8,$69,$94,$A8,$A8,$69,$00

SKYWARRIOR1: 
.byte $91,$A8,$AF,$B3,$C4,$FF,$9D,$AB,$1A,$8F,$92,$8E,$97,$8D,$BE,$1E,$A6,$55,$3E,$05,$B7,$B8,$B5,$5A,$27,$B8,$1E,$1F,$28,$31,$39,$B6,$C0,$05,$A0,$AC,$1C,$1B,$AB,$1A,$98,$9B,$8B,$9C,$24,$AB,$1F,$AC,$2A,$05,$A4,$B1,$A8,$BA,$BF,$36,$B1,$A6,$1A,$A4,$AA,$A4,$1F,$33,$A8,$05,$A6,$A4,$B1,$24,$B3,$2B,$AE,$C4,$00

SKYWARRIOR2: 
.byte $9D,$AB,$1A,$8F,$26,$44,$8F,$92,$8E,$97,$8D,$9C,$4F,$46,$25,$05,$AC,$B6,$FF,$4D,$B2,$53,$27,$82,$80,$80,$80,$50,$2B,$63,$05,$A4,$AA,$B2,$C0,$FF,$9D,$AB,$1A,$23,$A4,$58,$3A,$A8,$B0,$BC,$2D,$B6,$05,$AC,$B1,$1B,$AB,$39,$1B,$AC,$34,$C0,$00

SKYWARRIOR3: 
.byte $A0,$AB,$3A,$1B,$AB,$1A,$84,$FF,$98,$9B,$8B,$9C,$38,$B2,$B9,$25,$05,$B7,$AB,$1A,$A5,$AF,$5E,$AE,$FF,$98,$9B,$8B,$FF,$1F,$1B,$1D,$05,$A6,$A8,$B1,$B7,$25,$36,$A9,$1B,$AB,$1A,$B3,$5F,$5E,$A8,$BF,$05,$B7,$AB,$1A,$9D,$AC,$B0,$1A,$90,$39,$1A,$A6,$22,$36,$B3,$3A,$C0,$00

SKYWARRIOR4: 
.byte $A2,$B2,$B8,$42,$B8,$37,$1B,$B5,$A4,$32,$AF,$31,$5E,$AE,$FF,$1F,$05,$B7,$AC,$B0,$1A,$82,$80,$80,$80,$50,$2B,$63,$C0,$FF,$97,$46,$BF,$05,$BA,$AC,$1C,$1B,$AB,$1A,$98,$9B,$8B,$9C,$24,$AB,$1F,$AC,$2A,$BF,$05,$B6,$B7,$22,$27,$1F,$1B,$AB,$1A,$9D,$AC,$B0,$1A,$90,$39,$A8,$C0,$00

SKYWARRIOR5: 
.byte $A0,$A8,$20,$23,$1B,$1D,$43,$AC,$32,$65,$B2,$37,$05,$9C,$94,$A2,$FF,$A0,$8A,$9B,$9B,$92,$98,$9B,$9C,$C0,$FF,$84,$80,$80,$50,$2B,$63,$05,$A4,$AA,$2E,$BA,$1A,$A5,$39,$B7,$AF,$40,$20,$AA,$A4,$1F,$37,$05,$B7,$AB,$1A,$51,$B8,$B6,$1A,$4C,$1B,$AB,$1A,$BA,$35,$AF,$A7,$BE,$B6,$05,$A7,$A8,$37,$B5,$B8,$A6,$57,$3C,$C0,$00

PROVOKA1: 
.byte $9D,$AB,$22,$AE,$50,$26,$C0,$FF,$A0,$1A,$A7,$3C,$BE,$21,$5A,$40,$05,$B7,$B2,$31,$1A,$A4,$A9,$B5,$A4,$AC,$27,$4C,$4F,$AC,$B5,$39,$2C,$05,$A4,$B1,$BC,$B0,$B2,$23,$C0,$00

PROVOKA2: 
.byte $92,$FF,$41,$B9,$1A,$2C,$51,$B3,$A8,$27,$A9,$B5,$49,$05,$96,$A8,$AF,$B0,$B2,$3B,$BF,$FF,$1F,$1B,$AB,$1A,$BA,$2C,$B7,$C0,$05,$96,$BC,$1B,$46,$29,$AC,$1E,$1F,$1B,$B5,$26,$A5,$45,$C0,$05,$99,$AF,$2B,$B6,$1A,$1D,$AF,$B3,$1B,$1D,$B0,$C4,$C4,$00

PROVOKA3: 
.byte $9D,$AB,$1A,$8E,$AF,$32,$1E,$68,$B9,$1A,$5E,$4D,$B6,$B6,$05,$B7,$AB,$1A,$B6,$2B,$C0,$FF,$96,$A4,$28,$BC,$A4,$BE,$1E,$91,$8E,$9B,$8B,$05,$AC,$B6,$1B,$AB,$1A,$3C,$AF,$BC,$1B,$AB,$1F,$AA,$1B,$AB,$39,$05,$BA,$AC,$4E,$33,$A4,$AE,$1A,$1C,$A8,$AC,$44,$99,$B5,$1F,$48,$C0,$00

PROVOKA4: 
.byte $9D,$AB,$30,$1B,$46,$29,$41,$1E,$62,$3A,$05,$AC,$B1,$B9,$A4,$A7,$A8,$27,$A5,$4B,$B3,$AC,$B5,$39,$2C,$C0,$00

PROVOKA5: 
.byte $9C,$AB,$AC,$B3,$1E,$A6,$22,$24,$28,$B3,$36,$B1,$AF,$BC,$20,$B7,$05,$B3,$B2,$B5,$B7,$B6,$C0,$FF,$9D,$1D,$B5,$1A,$2F,$1A,$B1,$B2,$05,$B3,$B2,$B5,$B7,$1E,$1F,$1B,$AB,$1A,$B1,$B2,$B5,$1C,$C0,$00

PROVOKA6: 
.byte $91,$A8,$AF,$B3,$C4,$00

PROVOKA7: 
.byte $9D,$AB,$25,$1A,$2F,$1A,$B0,$22,$4B,$A7,$22,$AA,$25,$26,$B6,$05,$B0,$B2,$B1,$37,$25,$1E,$1F,$1B,$AB,$1A,$B6,$2B,$C0,$05,$8B,$A8,$38,$A4,$23,$A9,$B8,$AF,$C4,$00

ELFLANDCASTLE1: 
.byte $8A,$B6,$28,$1E,$B3,$B8,$B7,$1B,$AB,$1A,$99,$B5,$1F,$A6,$1A,$28,$05,$B6,$AF,$A8,$A8,$B3,$C0,$05,$99,$AF,$2B,$3E,$C4,$FF,$9C,$A4,$B9,$1A,$3D,$B0,$C4,$00

ELFLANDCASTLE2: 
.byte $9D,$AB,$1A,$99,$B5,$1F,$A6,$1A,$AC,$1E,$A4,$5D,$AE,$A8,$C4,$05,$9D,$AB,$22,$AE,$50,$26,$24,$2E,$B0,$B8,$A6,$AB,$C0,$00

ELFLANDCASTLE3: 
.byte $9D,$AB,$1A,$8C,$A4,$B9,$1A,$4C,$FF,$8D,$BA,$2F,$A9,$2D,$1E,$39,$05,$B7,$AB,$1A,$BA,$2C,$21,$3A,$27,$4C,$1B,$AB,$1A,$8A,$AF,$A7,$AC,$05,$9C,$A8,$A4,$C0,$00

ELFLANDCASTLE4: 
.byte $A0,$AC,$1C,$26,$21,$BA,$2F,$B1,$1F,$AA,$BF,$FF,$8A,$B6,$28,$B6,$05,$A4,$B7,$B7,$5E,$AE,$A8,$27,$26,$B5,$38,$A4,$37,$45,$C0,$FF,$98,$55,$05,$99,$B5,$1F,$A6,$1A,$5D,$1E,$AF,$A4,$AC,$27,$B8,$3B,$25,$20,$05,$A6,$B8,$B5,$3E,$BF,$20,$B1,$27,$26,$B5,$1B,$23,$3F,$B8,$B5,$BC,$05,$B5,$A4,$B1,$B6,$5E,$AE,$40,$C0,$00

ELFLANDCASTLE5: 
.byte $92,$B7,$2D,$1E,$B6,$A4,$AC,$A7,$1B,$1D,$B5,$1A,$AC,$1E,$A4,$05,$BA,$AC,$B7,$A6,$AB,$33,$AB,$2E,$41,$1E,$91,$8E,$9B,$8B,$9C,$C0,$05,$92,$FF,$62,$68,$A8,$B9,$1A,$1C,$A4,$21,$1D,$44,$B1,$A4,$34,$05,$AC,$B6,$69,$05,$96,$A4,$28,$BC,$A4,$C4,$00

ELFLANDCASTLE6: 
.byte $92,$B6,$1B,$41,$21,$5B,$C5,$FF,$9D,$AB,$1A,$91,$8E,$9B,$8B,$1B,$B2,$05,$B6,$A4,$B9,$1A,$1C,$1A,$99,$B5,$1F,$48,$C5,$00

ELFLANDCASTLE7: 
.byte $9D,$AB,$1A,$99,$B5,$1F,$A6,$1A,$AE,$A8,$A8,$B3,$B6,$1B,$1D,$05,$B0,$BC,$37,$AC,$A6,$FF,$94,$8E,$A2,$FF,$B8,$B1,$57,$AF,$1B,$1D,$05,$A6,$B2,$B0,$1F,$AA,$36,$A9,$1B,$1D,$05,$95,$92,$90,$91,$9D,$FF,$A0,$8A,$9B,$9B,$92,$98,$9B,$9C,$C0,$00

ELFLANDCASTLE8: 
.byte $96,$A4,$BC,$A5,$1A,$5B,$BE,$1E,$3C,$AF,$4B,$B5,$B8,$B0,$26,$B5,$BF,$05,$A5,$B8,$B7,$BF,$FF,$92,$1B,$AB,$1F,$AE,$1B,$AB,$1A,$51,$B8,$3E,$05,$B2,$A9,$20,$4E,$4F,$4D,$A5,$45,$B0,$1E,$30,$1B,$B2,$05,$A5,$A8,$43,$26,$B1,$27,$1F,$1B,$1D,$38,$A4,$32,$36,$A9,$05,$96,$A4,$63,$AB,$C0,$00

ELFLAND1: 
.byte $9C,$A4,$B9,$1A,$26,$44,$99,$B5,$1F,$48,$C4,$00

ELFLAND2: 
.byte $98,$B8,$44,$99,$B5,$1F,$A6,$1A,$BA,$3F,$1B,$B2,$05,$A5,$A8,$A6,$49,$1A,$1C,$1A,$94,$1F,$AA,$36,$A9,$05,$8E,$AF,$A9,$95,$22,$A7,$C0,$00

ELFLAND3: 
.byte $95,$B2,$2A,$20,$AA,$2E,$92,$33,$22,$A7,$A8,$23,$A7,$1B,$B2,$05,$B7,$AB,$1A,$97,$35,$B7,$AB,$BA,$2C,$B7,$C0,$FF,$92,$43,$26,$3B,$05,$A4,$B1,$20,$B1,$A6,$AC,$3A,$21,$51,$37,$AF,$1A,$1C,$39,$05,$BA,$A4,$1E,$B6,$B2,$24,$B3,$B2,$B2,$AE,$BC,$BF,$FF,$92,$FF,$45,$A9,$B7,$05,$AC,$B0,$34,$A7,$AC,$39,$A8,$AF,$BC,$C0,$00

ELFLAND4: 
.byte $8A,$B6,$28,$1E,$41,$1E,$62,$A8,$29,$A7,$A8,$A9,$2B,$B7,$40,$C5,$05,$99,$A8,$5E,$1A,$BA,$AC,$4E,$FF,$B1,$46,$FF,$23,$B7,$55,$B1,$1B,$B2,$05,$8E,$AF,$A9,$95,$22,$A7,$C0,$00

ELFLAND5: 
.byte $8A,$B6,$28,$1E,$BA,$2B,$B5,$1E,$A4,$67,$30,$AA,$B8,$30,$A8,$BF,$05,$A4,$B1,$27,$AF,$55,$AE,$1E,$1F,$24,$A8,$A6,$AF,$B8,$B6,$AC,$3C,$C0,$00

ELFLAND6: 
.byte $9D,$AB,$1A,$99,$B5,$1F,$A6,$1A,$B0,$B8,$B6,$21,$5D,$AE,$A8,$05,$B6,$B2,$3C,$BF,$FF,$35,$1B,$AB,$1A,$B3,$46,$25,$36,$A9,$05,$B7,$AB,$1A,$8D,$2F,$AE,$FF,$8E,$AF,$A9,$33,$AC,$4E,$05,$A7,$B2,$B0,$1F,$39,$A8,$C4,$00

ELFLAND7: 
.byte $95,$A8,$AA,$3A,$A7,$24,$A4,$BC,$1E,$22,$FF,$8A,$92,$9B,$9C,$91,$92,$99,$05,$AC,$B6,$31,$55,$AC,$40,$24,$B2,$34,$BA,$1D,$23,$C0,$00

ELFLAND8: 
.byte $9C,$BA,$35,$A7,$1E,$22,$A7,$20,$B5,$B0,$35,$1E,$B0,$A4,$A7,$A8,$05,$B2,$A9,$24,$61,$B9,$25,$20,$23,$05,$B9,$A8,$B5,$4B,$B3,$46,$A8,$B5,$A9,$B8,$AF,$C0,$00

ELFLAND9: 
.byte $92,$FF,$A6,$22,$24,$A8,$1A,$A4,$FF,$51,$B9,$1A,$A4,$A5,$B2,$32,$05,$B7,$AB,$1A,$A6,$23,$B6,$A6,$3A,$B7,$69,$05,$9D,$B2,$1B,$AB,$1A,$B1,$35,$1C,$36,$A9,$1B,$1D,$05,$B9,$B2,$AF,$A6,$22,$B2,$BF,$1B,$1D,$B5,$1A,$BC,$26,$33,$AC,$4E,$05,$A9,$AC,$3B,$1B,$AB,$1A,$8F,$95,$98,$8A,$9D,$8E,$9B,$C0,$00

ELFLAND10: 
.byte $92,$B1,$1B,$AB,$1A,$A7,$2C,$25,$21,$B6,$26,$1C,$36,$A9,$05,$B7,$AB,$1A,$A6,$23,$B6,$A6,$3A,$B7,$BF,$24,$B2,$34,$B7,$AB,$1F,$AA,$05,$AC,$B6,$FF,$A8,$B0,$25,$AA,$1F,$AA,$43,$B5,$49,$31,$A8,$AF,$46,$05,$B7,$AB,$1A,$B6,$22,$A7,$69,$05,$9E,$B6,$1A,$1C,$1A,$8F,$95,$98,$8A,$9D,$8E,$9B,$C4,$00

ELFLAND11:
.byte $9D,$AB,$1A,$99,$B5,$1F,$A6,$1A,$B0,$B8,$B6,$21,$5D,$AE,$A8,$05,$B6,$B2,$3C,$BF,$FF,$35,$1B,$AB,$1A,$8D,$2F,$AE,$FF,$8E,$AF,$A9,$05,$BA,$AC,$4E,$67,$49,$1F,$39,$A8,$C4,$00

DWARFCAVE1: 
.byte $92,$BE,$B0,$65,$B2,$B2,$AE,$1F,$AA,$43,$35,$1B,$1D,$05,$8F,$95,$98,$8A,$9D,$8E,$9B,$C0,$FF,$92,$BE,$4E,$31,$A8,$21,$BA,$AC,$1C,$05,$AC,$B7,$FF,$92,$38,$26,$AF,$27,$A9,$AF,$B2,$39,$05,$A4,$B1,$BC,$1C,$1F,$AA,$C0,$00

DWARFCAVE2: 
.byte $98,$AF,$27,$97,$25,$5C,$A6,$AE,$2D,$1E,$A4,$FF,$B9,$25,$BC,$05,$B5,$A8,$B6,$B3,$A8,$A6,$B7,$A4,$A5,$AF,$1A,$8D,$BA,$2F,$A9,$C0,$00

DWARFCAVE3: 
.byte $9D,$AB,$A4,$21,$B6,$26,$3B,$C5,$05,$97,$A8,$B5,$5C,$A6,$AE,$2D,$1E,$A7,$AC,$AA,$AA,$1F,$AA,$20,$05,$A6,$A4,$B1,$5F,$C0,$00

DWARFCAVE4: 
.byte $8D,$BA,$2F,$32,$1E,$A6,$22,$24,$A8,$1A,$1F,$1B,$1D,$05,$A7,$A4,$B5,$AE,$C4,$00

DWARFCAVE5: 
.byte $8D,$AC,$27,$BC,$26,$FF,$34,$A8,$21,$9C,$B0,$AC,$1C,$BF,$05,$B2,$B8,$B5,$31,$AF,$5E,$AE,$B6,$B0,$AC,$1C,$C5,$00

DWARFCAVE6: 
.byte $A0,$AC,$1C,$1B,$AB,$1A,$8C,$9B,$A2,$9C,$9D,$8A,$95,$BF,$FF,$A8,$32,$B1,$05,$B7,$AB,$1A,$A5,$AF,$1F,$27,$A6,$22,$24,$A8,$A8,$C0,$05,$8A,$B6,$28,$1E,$B6,$28,$AF,$1A,$AC,$21,$A9,$B5,$49,$05,$96,$A4,$28,$BC,$A4,$C0,$00

DWARFCAVE7: 
.byte $9D,$AB,$1A,$2B,$B5,$1C,$2D,$1E,$4D,$B7,$B7,$1F,$AA,$05,$B6,$AF,$46,$AF,$BC,$43,$B5,$49,$1B,$AB,$1A,$BA,$2C,$B7,$69,$00

DWARFCAVE8: 
.byte $9D,$AB,$1A,$2B,$B5,$1C,$2D,$1E,$23,$B9,$AC,$B9,$1F,$AA,$C4,$05,$9D,$AB,$22,$AE,$B6,$1B,$2E,$BC,$26,$BF,$05,$95,$92,$90,$91,$9D,$FF,$A0,$8A,$9B,$9B,$92,$98,$9B,$9C,$C4,$00

DWARFCAVE9: 
.byte $9D,$AB,$1A,$DE,$69,$A5,$B5,$A4,$48,$45,$21,$A6,$22,$05,$B3,$B5,$B2,$53,$A6,$21,$BC,$26,$BF,$65,$AC,$AE,$A8,$05,$A4,$B5,$B0,$35,$C0,$00

DWARFCAVE10: 
.byte $98,$AB,$BF,$67,$AC,$27,$BC,$26,$24,$A8,$1A,$1C,$39,$05,$A6,$A4,$B1,$5F,$C5,$FF,$98,$AF,$27,$97,$25,$5C,$A6,$AE,$1B,$B5,$B8,$AF,$BC,$05,$AC,$B6,$FF,$AA,$23,$A4,$21,$1F,$A7,$A8,$40,$C0,$00

DWARFCAVE11: 
.byte $95,$B2,$2A,$20,$AA,$B2,$BF,$FF,$8C,$3C,$25,$AC,$A4,$BE,$B6,$05,$9D,$B5,$2B,$B6,$55,$BC,$24,$A4,$A9,$A8,$AA,$B8,$2F,$A7,$40,$05,$B7,$AB,$1A,$B8,$B6,$1A,$4C,$FF,$9D,$97,$9D,$C0,$00

DWARFCAVE12: 
.byte $91,$B8,$B5,$B5,$A4,$BC,$C4,$C4,$00

BROOM: 
.byte $C3,$C3,$9D,$8C,$8E,$95,$8E,$9C,$FF,$8B,$FF,$91,$9C,$9E,$99,$05,$8A,$FF,$B0,$A4,$AA,$AC,$A6,$24,$B3,$A8,$4E,$C5,$00

MELMOND: 
.byte $9D,$AB,$1A,$9F,$A4,$B0,$B3,$AC,$B5,$1A,$4C,$1B,$AB,$1A,$8E,$2F,$1C,$05,$8C,$A4,$B9,$1A,$AC,$1E,$37,$2B,$AF,$1F,$AA,$1B,$1D,$05,$99,$B2,$BA,$25,$36,$A9,$1B,$AB,$1A,$2B,$B5,$1C,$C0,$05,$A0,$A8,$FF,$5A,$A8,$27,$BC,$26,$44,$1D,$AF,$B3,$C0,$00

MELMOND1: 
.byte $96,$A8,$AF,$B0,$3C,$27,$5D,$1E,$3C,$A6,$1A,$A4,$05,$A5,$A8,$A4,$B8,$57,$A9,$B8,$AF,$1B,$46,$B1,$C0,$00

MELMOND2: 
.byte $9D,$AB,$1A,$9D,$5B,$22,$33,$AB,$2E,$68,$32,$1E,$1F,$05,$B7,$AB,$1A,$B7,$B8,$B1,$5A,$58,$2B,$B7,$1E,$66,$B0,$B6,$C0,$05,$91,$A8,$65,$B2,$32,$1E,$9B,$9E,$8B,$92,$8E,$9C,$C0,$00

MELMOND3: 
.byte $9D,$AB,$1A,$9F,$A4,$B0,$B3,$AC,$B5,$1A,$AC,$1E,$AA,$3C,$A8,$BF,$31,$B8,$B7,$05,$B7,$AB,$1A,$2B,$B5,$B7,$AB,$38,$3C,$B7,$1F,$B8,$2C,$1B,$B2,$05,$B5,$B2,$B7,$C0,$FF,$A0,$41,$21,$51,$B8,$B6,$2C,$1B,$AB,$30,$C5,$00

MELMOND4: 
.byte $92,$BE,$B0,$20,$43,$2F,$B0,$25,$C0,$00

MELMOND5: 
.byte $9D,$AB,$1A,$8E,$2F,$1C,$FF,$8C,$A4,$B9,$1A,$AC,$1E,$3C,$05,$B7,$AB,$1A,$B3,$3A,$1F,$B6,$B8,$AF,$A4,$24,$26,$B7,$AB,$BA,$2C,$B7,$05,$B2,$A9,$1B,$AB,$30,$1B,$46,$B1,$C0,$00

MELMOND6: 
.byte $95,$B2,$B2,$AE,$C4,$FF,$9D,$AB,$1A,$8E,$2F,$1C,$FF,$98,$9B,$8B,$2D,$B6,$05,$B6,$AB,$1F,$AC,$2A,$20,$AA,$A4,$AC,$B1,$C0,$00

MELMOND7: 
.byte $9D,$AB,$30,$1B,$46,$29,$5D,$1E,$1F,$B9,$A4,$A7,$A8,$27,$A5,$BC,$05,$B7,$AB,$1A,$9F,$A4,$B0,$B3,$AC,$23,$C0,$FF,$9D,$AB,$1A,$8C,$AF,$1F,$AC,$A6,$05,$BA,$A4,$1E,$A7,$2C,$B7,$4D,$BC,$40,$20,$3B,$1B,$1D,$05,$B7,$B2,$BA,$29,$5D,$1E,$A6,$55,$3E,$A7,$C0,$00

MELMOND8: 
.byte $8A,$B5,$1A,$BC,$26,$1B,$1D,$05,$95,$92,$90,$91,$9D,$FF,$A0,$8A,$9B,$9B,$92,$98,$9B,$9C,$C5,$00

MELMOND9: 
.byte $99,$A4,$B6,$B6,$1B,$AB,$B5,$26,$AA,$AB,$1B,$AB,$1A,$9D,$5B,$22,$BE,$B6,$05,$9D,$B8,$B1,$5A,$AF,$BF,$1B,$1D,$B1,$24,$26,$1C,$1B,$B2,$05,$A9,$AC,$B1,$27,$9C,$2F,$A7,$A4,$BF,$1B,$AB,$1A,$9C,$A4,$66,$C0,$00

MELMOND10: 
.byte $9D,$AB,$1A,$9F,$A4,$B0,$B3,$AC,$B5,$1A,$AC,$1E,$AA,$3C,$A8,$BF,$31,$B8,$B7,$05,$B7,$AB,$1A,$2B,$B5,$B7,$AB,$24,$57,$4E,$FF,$4D,$B7,$B6,$C5,$69,$00

MELMOND11: 
.byte $92,$B1,$1B,$AB,$1A,$B1,$35,$1C,$25,$29,$BA,$35,$AF,$A7,$BF,$05,$B7,$AB,$25,$1A,$3C,$A6,$1A,$5D,$1E,$A4,$05,$B3,$B5,$B2,$B6,$B3,$25,$26,$1E,$A6,$AC,$B9,$61,$AC,$BD,$39,$AC,$3C,$BF,$05,$A5,$B8,$21,$B1,$46,$2D,$21,$AC,$1E,$B5,$B8,$1F,$B6,$C0,$00

MELMOND12: 
.byte $92,$A9,$1B,$AB,$1A,$98,$9B,$8B,$36,$54,$8E,$2F,$1C,$05,$A5,$A8,$AA,$1F,$B6,$1B,$B2,$24,$AB,$1F,$1A,$A4,$AA,$A4,$1F,$BF,$05,$B7,$AB,$1A,$2B,$B5,$B7,$AB,$24,$41,$4E,$FF,$23,$B9,$AC,$32,$C0,$00

MELMOND13: 
.byte $95,$92,$90,$91,$9D,$FF,$A0,$8A,$9B,$9B,$92,$98,$9B,$9C,$69,$05,$9D,$AB,$22,$AE,$B6,$1B,$2E,$BC,$26,$BF,$1B,$AB,$1A,$2B,$B5,$1C,$05,$AC,$B6,$31,$A8,$AA,$1F,$B1,$AC,$2A,$1B,$2E,$23,$B9,$AC,$32,$69,$00

MELMOND14: 
.byte $9D,$AB,$A8,$BC,$24,$A4,$BC,$1B,$AB,$1A,$22,$A6,$AC,$3A,$B7,$05,$B3,$A8,$B2,$B3,$AF,$1A,$B8,$3E,$A7,$20,$24,$28,$B1,$1A,$28,$05,$B0,$A4,$AE,$1A,$1C,$A8,$AC,$B5,$24,$3D,$B3,$43,$AF,$B2,$39,$C0,$00

MELMOND15: 
.byte $98,$91,$C4,$FF,$8A,$29,$8A,$92,$9B,$9C,$91,$92,$99,$C4,$05,$9D,$AB,$1A,$A9,$A4,$A5,$45,$1E,$2F,$1A,$B7,$B5,$B8,$A8,$BF,$2D,$B7,$05,$B5,$A8,$A4,$4E,$4B,$A8,$BB,$30,$B7,$B6,$C4,$C4,$00

MELMOND16: 
.byte $9C,$A4,$B5,$A7,$A4,$67,$B2,$A8,$1E,$B1,$B2,$21,$A9,$2B,$B5,$1B,$1D,$05,$A8,$B9,$61,$1E,$4C,$1B,$AB,$1A,$51,$32,$C0,$00

MELMOND17: 
.byte $A0,$A8,$4E,$BF,$33,$A8,$4E,$69,$05,$A2,$B2,$64,$41,$B9,$1A,$62,$A6,$49,$1A,$A9,$1F,$A8,$05,$A0,$A4,$B5,$5C,$35,$B6,$C0,$00

MELMOND18: 
.byte $92,$FF,$A4,$B0,$FF,$93,$AC,$B0,$C0,$FF,$96,$4B,$AB,$49,$1A,$30,$1B,$1D,$05,$8D,$BA,$2F,$54,$9F,$AC,$4E,$A4,$66,$BF,$31,$B8,$21,$92,$20,$B0,$05,$AB,$A8,$B5,$1A,$1F,$B9,$2C,$57,$AA,$39,$1F,$AA,$C0,$00

LAKESAGE1: 
.byte $A0,$A8,$BF,$1B,$AB,$1A,$9D,$60,$AF,$B9,$1A,$9C,$A4,$AA,$2C,$BF,$05,$BA,$A8,$B5,$1A,$AF,$2B,$27,$1D,$B5,$1A,$A5,$BC,$1B,$1D,$05,$B6,$B7,$2F,$1E,$22,$27,$B3,$4D,$B3,$1D,$A6,$BC,$C0,$00

LAKESAGE2: 
.byte $98,$B1,$A6,$1A,$1C,$1A,$98,$9B,$8B,$9C,$24,$AB,$1F,$40,$05,$BA,$AC,$1C,$1B,$AB,$1A,$B3,$46,$25,$36,$54,$8E,$2F,$1C,$BF,$05,$A0,$AC,$3B,$BF,$FF,$8F,$AC,$23,$BF,$20,$B1,$27,$A0,$39,$25,$C0,$05,$9D,$AB,$1A,$A9,$26,$44,$8F,$92,$8E,$97,$8D,$9C,$24,$A8,$AC,$BD,$40,$05,$B7,$AB,$B2,$B6,$1A,$99,$46,$25,$B6,$C0,$00

LAKESAGE3: 
.byte $8E,$A4,$B5,$1C,$BF,$FF,$A0,$1F,$A7,$BF,$FF,$8F,$AC,$23,$BF,$20,$3B,$05,$A0,$A4,$B7,$25,$69,$05,$9D,$AB,$1A,$BA,$35,$AF,$27,$AC,$1E,$A5,$26,$B1,$27,$A5,$BC,$05,$B7,$AB,$2C,$1A,$A9,$26,$44,$99,$46,$25,$B6,$C0,$00

LAKESAGE4: 
.byte $8E,$A4,$A6,$AB,$FF,$A8,$45,$34,$B1,$B7,$BE,$1E,$B3,$46,$25,$05,$A9,$B2,$A6,$B8,$3E,$1E,$A4,$21,$5B,$1E,$8A,$AF,$B7,$2F,$C0,$05,$95,$B2,$A6,$39,$A8,$BF,$20,$B1,$27,$A6,$B5,$B8,$B6,$AB,$1B,$1D,$05,$8F,$AC,$3A,$A7,$C0,$FF,$9D,$1D,$B1,$1B,$2E,$B0,$A4,$AE,$A8,$05,$AC,$B7,$24,$AB,$1F,$A8,$BF,$4F,$AF,$5E,$1A,$1C,$1A,$98,$9B,$8B,$05,$B2,$B1,$1B,$AB,$1A,$8A,$AF,$B7,$2F,$2D,$21,$AA,$B8,$2F,$A7,$40,$C4,$00

LAKESAGE5: 
.byte $8F,$B2,$B8,$44,$8F,$92,$8E,$97,$8D,$9C,$20,$B5,$1A,$A5,$3A,$21,$3C,$05,$B7,$AB,$1A,$BA,$35,$AF,$A7,$BE,$1E,$A7,$2C,$B7,$B5,$B8,$A6,$57,$3C,$C0,$05,$82,$80,$80,$50,$2B,$B5,$1E,$A4,$AA,$B2,$BF,$1B,$AB,$1A,$8F,$92,$8E,$97,$8D,$05,$B2,$A9,$FF,$A0,$1F,$A7,$1B,$2B,$34,$27,$BA,$AC,$1C,$1B,$AB,$39,$05,$B2,$A9,$1B,$AB,$1A,$A0,$39,$25,$1B,$2E,$A7,$2C,$B7,$4D,$BC,$05,$A6,$AC,$B9,$61,$AC,$BD,$39,$AC,$3C,$C0,$00

LAKESAGE6: 
.byte $9D,$AB,$1A,$8E,$2F,$1C,$FF,$8F,$92,$8E,$97,$8D,$38,$A4,$B8,$B6,$2C,$05,$B7,$AB,$1A,$4D,$21,$4C,$FF,$26,$44,$AF,$22,$A7,$C0,$00

LAKESAGE7: 
.byte $9D,$AB,$1A,$8F,$AC,$B5,$1A,$8F,$92,$8E,$97,$8D,$33,$AC,$4E,$05,$A5,$B8,$B5,$29,$A8,$B9,$25,$BC,$1C,$1F,$47,$B8,$B3,$C4,$00

LAKESAGE8: 
.byte $8A,$B6,$50,$26,$FF,$23,$B6,$28,$B5,$1A,$68,$AA,$AB,$B7,$1B,$B2,$05,$B7,$AB,$1A,$98,$9B,$8B,$9C,$BF,$33,$1A,$BA,$AC,$4E,$FF,$23,$B9,$2B,$AF,$05,$B0,$B2,$B5,$1A,$3E,$A6,$23,$B7,$B6,$BF,$4F,$AF,$2B,$B6,$1A,$3E,$A8,$05,$B8,$B6,$FF,$23,$B3,$2B,$B7,$40,$AF,$BC,$C0,$00

LAKESAGE9: 
.byte $95,$92,$90,$91,$9D,$FF,$A0,$8A,$9B,$9B,$92,$98,$9B,$9C,$BF,$05,$B2,$B1,$AF,$4B,$BC,$26,$38,$22,$42,$A4,$AE,$1A,$1C,$A8,$05,$98,$9B,$8B,$9C,$24,$AB,$1F,$1A,$A4,$AA,$A4,$1F,$C4,$C4,$00

LAKESAGE10: 
.byte $9A,$B8,$AC,$A6,$AE,$AF,$BC,$BF,$31,$A8,$A9,$35,$1A,$A4,$4E,$2D,$B6,$05,$A5,$B8,$B5,$B1,$B7,$BF,$59,$B8,$B5,$B5,$BC,$1B,$2E,$90,$B8,$B5,$AA,$B8,$05,$9F,$B2,$AF,$A6,$22,$B2,$20,$3B,$24,$28,$B3,$1B,$1D,$05,$8F,$92,$8E,$97,$8D,$36,$54,$8F,$AC,$23,$C0,$00

LAKESAGE11: 
.byte $9D,$AB,$1A,$9D,$A8,$B0,$B3,$AF,$1A,$4C,$FF,$8F,$92,$8E,$97,$8D,$9C,$2D,$B6,$05,$AC,$B1,$1B,$AB,$1A,$A6,$3A,$B7,$25,$36,$A9,$1B,$1D,$05,$8F,$B2,$B8,$44,$8A,$AF,$B7,$2F,$B6,$C0,$FF,$9D,$AB,$1A,$57,$34,$05,$AB,$A4,$1E,$A6,$49,$1A,$28,$67,$2C,$B7,$4D,$BC,$1B,$1D,$05,$B6,$B2,$55,$A6,$1A,$4C,$FF,$A8,$B9,$61,$C0,$00

LAKESAGE12: 
.byte $A0,$AC,$1C,$1B,$AB,$1A,$A9,$26,$44,$98,$9B,$8B,$9C,$05,$B6,$AB,$1F,$AC,$2A,$20,$AA,$A4,$AC,$B1,$1B,$AB,$1A,$9D,$AC,$34,$05,$90,$A4,$B7,$1A,$A6,$22,$31,$1A,$A5,$4D,$AE,$3A,$C0,$FF,$9D,$1D,$05,$B7,$B5,$B8,$1A,$3A,$A8,$B0,$BC,$2D,$1E,$82,$80,$80,$80,$50,$2B,$63,$05,$AC,$B1,$1B,$AB,$1A,$B3,$A4,$37,$C0,$00

LAKESAGE13: 
.byte $9D,$AB,$1A,$BA,$35,$AF,$27,$5D,$1E,$B6,$B8,$A7,$A7,$3A,$AF,$BC,$05,$B7,$AB,$B5,$46,$29,$1F,$28,$67,$30,$35,$A7,$25,$C0,$05,$A2,$B2,$B8,$42,$B8,$B6,$21,$23,$B6,$28,$B5,$1A,$5B,$C0,$00

LAKESAGE14: 
.byte $9D,$AC,$B0,$1A,$AC,$1E,$23,$B3,$2B,$B7,$1F,$AA,$C0,$05,$92,$B1,$FF,$35,$A7,$25,$1B,$2E,$A5,$23,$A4,$AE,$1B,$1D,$05,$9D,$AC,$34,$C2,$95,$B2,$B2,$B3,$50,$26,$42,$B8,$37,$05,$A8,$AF,$AC,$B0,$1F,$39,$1A,$1C,$1A,$3A,$A8,$B0,$BC,$33,$AB,$B2,$05,$A6,$B2,$B1,$B7,$4D,$AF,$1E,$A9,$B5,$49,$FF,$82,$80,$80,$80,$50,$2B,$63,$05,$AC,$B1,$1B,$AB,$1A,$B3,$A4,$37,$C0,$00

LAKESAGE15: 
.byte $9C,$B2,$34,$3C,$1A,$B7,$B5,$A4,$32,$AF,$45,$27,$82,$80,$80,$80,$05,$BC,$A8,$2F,$B6,$1B,$2E,$1C,$1A,$B3,$A4,$37,$C0,$FF,$9D,$1D,$05,$A9,$B2,$B8,$44,$8F,$92,$8E,$97,$8D,$9C,$33,$25,$1A,$B6,$3A,$B7,$05,$A9,$B2,$B5,$BA,$2F,$27,$1F,$1B,$AC,$34,$C0,$FF,$9D,$AB,$B2,$3E,$05,$8F,$92,$8E,$97,$8D,$9C,$1B,$AB,$23,$39,$3A,$1B,$B2,$05,$A7,$A8,$37,$4D,$BC,$1B,$AB,$1A,$BA,$35,$AF,$A7,$1B,$B2,$A7,$A4,$BC,$C0,$00

LAKESAGE16: 
.byte $92,$FF,$3E,$1A,$B1,$46,$C0,$05,$9C,$B2,$34,$3C,$1A,$BA,$AB,$B2,$1B,$B5,$A4,$32,$4E,$40,$05,$A5,$A4,$A6,$AE,$FF,$82,$80,$80,$80,$50,$2B,$B5,$1E,$30,$1B,$1D,$05,$A6,$A4,$B8,$B6,$1A,$4C,$1B,$AB,$1A,$BA,$35,$AF,$A7,$BE,$B6,$05,$A7,$A8,$37,$B5,$B8,$A6,$57,$3C,$C0,$FF,$8A,$A9,$B7,$25,$FF,$82,$80,$80,$80,$05,$BC,$A8,$2F,$1E,$AB,$1A,$BA,$AC,$4E,$1B,$B5,$A4,$32,$AF,$05,$A5,$A4,$A6,$AE,$20,$AA,$A4,$1F,$69,$05,$9D,$AB,$3A,$20,$AA,$A4,$1F,$69,$9D,$AB,$3A,$20,$AA,$A4,$1F,$69,$00

LAKESAGE17: 
.byte $9D,$AC,$B0,$1A,$BA,$AC,$4E,$FF,$23,$B3,$2B,$21,$5B,$3E,$AF,$A9,$05,$A8,$B9,$25,$4B,$82,$80,$80,$80,$50,$2B,$63,$C0,$05,$8B,$B5,$2B,$AE,$1B,$AB,$1A,$9D,$AC,$34,$C2,$95,$B2,$B2,$B3,$C4,$00

LAKESAGE18: 
.byte $92,$B1,$1B,$AB,$1A,$9D,$A8,$B0,$B3,$AF,$1A,$4C,$FF,$8F,$92,$8E,$97,$8D,$9C,$05,$A4,$B5,$1A,$1C,$1A,$23,$B0,$A4,$1F,$AC,$2A,$FF,$9C,$94,$A2,$05,$A0,$8A,$9B,$9B,$92,$98,$9B,$9C,$C0,$FF,$9D,$1D,$BC,$43,$26,$AA,$AB,$B7,$05,$B7,$AB,$1A,$8F,$92,$8E,$97,$8D,$9C,$20,$3B,$20,$B5,$1A,$B1,$46,$05,$A5,$A4,$B7,$B6,$C4,$00

LAKESAGE19: 
.byte $A0,$A8,$42,$B8,$B6,$21,$B8,$3E,$43,$35,$48,$36,$B1,$AF,$BC,$05,$A9,$B2,$44,$AD,$B8,$B6,$21,$B3,$55,$B3,$B2,$B6,$2C,$C0,$00

CRESCENTLAKE1: 
.byte $8F,$B2,$B5,$1B,$A8,$29,$BC,$2B,$B5,$1E,$92,$4F,$4D,$A5,$40,$05,$A9,$B2,$B5,$1B,$AB,$1A,$8F,$95,$98,$8A,$9D,$8E,$9B,$C0,$FF,$8C,$8A,$97,$98,$8E,$05,$B1,$B2,$B5,$1C,$BF,$1B,$2E,$1C,$1A,$92,$A6,$1A,$8C,$A4,$32,$C0,$00

LAKESAGE20: 
.byte $92,$FF,$A4,$B0,$FF,$95,$B8,$AE,$A4,$AB,$B1,$C0,$05,$97,$B2,$BA,$20,$4E,$FF,$45,$AA,$3A,$A7,$1E,$22,$A7,$05,$B3,$B5,$B2,$B3,$1D,$A6,$BC,$33,$AC,$4E,$31,$A8,$05,$A9,$B8,$AF,$A9,$AC,$4E,$40,$C0,$FF,$98,$B8,$44,$B3,$A4,$1C,$59,$3F,$05,$A5,$A8,$A8,$29,$A7,$A8,$A6,$AC,$A7,$40,$C0,$00

CRESCENTLAKE2: 
.byte $95,$92,$90,$91,$9D,$FF,$A0,$8A,$9B,$9B,$92,$98,$9B,$9C,$BF,$50,$26,$38,$22,$05,$A7,$B2,$2D,$B7,$C4,$00

ONRAC1: 
.byte $96,$BC,$31,$4D,$1C,$25,$FF,$8D,$B5,$C0,$FF,$9E,$B1,$B1,$1A,$AB,$3F,$05,$B6,$B7,$B8,$A7,$AC,$A8,$27,$95,$A8,$A9,$A8,$1F,$30,$AB,$BF,$1B,$1D,$05,$AF,$A4,$2A,$B8,$A4,$AA,$1A,$4C,$1B,$AB,$1A,$9C,$94,$A2,$05,$A0,$8A,$9B,$9B,$92,$98,$9B,$9C,$C0,$FF,$92,$54,$AB,$1A,$41,$A7,$1B,$1D,$05,$9C,$95,$8A,$8B,$BF,$59,$1A,$A6,$26,$AF,$A7,$1B,$2B,$A6,$AB,$2D,$B7,$C0,$00

ONRAC2: 
.byte $9C,$B2,$2F,$1B,$2E,$B0,$BC,$31,$4D,$1C,$25,$FF,$9E,$B1,$5A,$05,$BA,$AC,$1C,$1B,$AB,$1A,$9C,$95,$8A,$8B,$C4,$00

ONRAC3: 
.byte $91,$A4,$B9,$1A,$BC,$26,$43,$26,$B1,$27,$98,$A1,$A2,$8A,$95,$8E,$C5,$00

ONRAC4: 
.byte $A2,$B2,$64,$41,$B9,$1A,$45,$AA,$B6,$C4,$00

ONRAC5: 
.byte $96,$BC,$FF,$45,$AA,$1E,$2F,$1A,$A5,$2B,$B8,$57,$A9,$B8,$AF,$C4,$05,$92,$B7,$BE,$1E,$B6,$2E,$B1,$AC,$A6,$1A,$28,$FF,$41,$32,$05,$AF,$A8,$AA,$B6,$C0,$00

ONRAC6: 
.byte $9E,$B1,$A7,$25,$3D,$4E,$BF,$1B,$AB,$1A,$8C,$2F,$A4,$B9,$22,$05,$96,$A4,$37,$25,$BF,$FF,$41,$A7,$24,$B2,$34,$1C,$1F,$AA,$05,$B9,$A8,$B5,$BC,$24,$B7,$B5,$22,$66,$69,$00

ONRAC7: 
.byte $9E,$B1,$57,$58,$82,$80,$80,$50,$2B,$B5,$1E,$A4,$AA,$B2,$1B,$1D,$05,$96,$A8,$B5,$B0,$A4,$AC,$A7,$1E,$68,$32,$27,$1F,$1B,$1D,$05,$9C,$AB,$B5,$1F,$A8,$C0,$FF,$9D,$1D,$B1,$BF,$FF,$1F,$43,$AC,$23,$05,$A4,$B1,$A7,$24,$B0,$B2,$AE,$A8,$BF,$2D,$21,$B6,$A4,$B1,$AE,$C0,$FF,$9D,$1D,$05,$96,$A8,$B5,$B0,$A4,$AC,$A7,$B6,$C5,$69,$00

ONRAC8: 
.byte $9E,$B1,$57,$58,$82,$80,$80,$50,$2B,$B5,$1E,$A4,$AA,$B2,$BF,$1B,$1D,$05,$99,$B2,$BA,$25,$36,$54,$A0,$39,$25,$31,$B5,$26,$AA,$AB,$B7,$05,$B8,$B6,$FF,$AA,$B2,$B2,$27,$A9,$35,$B7,$B8,$5A,$C0,$00

ONRAC9: 
.byte $9D,$AB,$1A,$B3,$46,$25,$36,$54,$A0,$39,$25,$C4,$C4,$05,$97,$B2,$BA,$BF,$FF,$26,$B5,$38,$26,$B1,$B7,$B5,$BC,$33,$AC,$4E,$05,$B3,$B5,$B2,$B6,$B3,$25,$65,$AC,$AE,$1A,$62,$A9,$B2,$23,$C0,$00

ONRAC10: 
.byte $92,$FF,$B6,$A4,$BA,$FF,$8B,$8A,$91,$8A,$96,$9E,$9D,$BF,$31,$B8,$B7,$BF,$1B,$B2,$05,$A5,$A8,$59,$3C,$B2,$23,$A7,$20,$1E,$A4,$1B,$B5,$B8,$A8,$05,$BA,$A4,$B5,$5C,$35,$FF,$92,$42,$B8,$B6,$21,$23,$B7,$55,$B1,$05,$BA,$AC,$1C,$4F,$4D,$4C,$36,$A9,$42,$BC,$05,$A6,$B2,$55,$A4,$66,$C0,$00

ONRAC11: 
.byte $A0,$A8,$4E,$BF,$33,$A8,$4E,$69,$05,$92,$FF,$3E,$1A,$BC,$26,$FF,$41,$B9,$1A,$62,$3A,$05,$AB,$B2,$B1,$B2,$23,$A7,$C0,$00

ONRAC12: 
.byte $8A,$B9,$3F,$21,$BC,$1A,$AF,$22,$A7,$AF,$B8,$A5,$A5,$25,$B6,$C4,$05,$9C,$B7,$A4,$4B,$26,$21,$4C,$42,$1A,$5D,$BC,$C0,$00

ONRAC13: 
.byte $96,$BC,$43,$A4,$1C,$25,$FF,$B5,$B8,$B1,$B6,$1B,$1D,$05,$A6,$A4,$B5,$A4,$B9,$22,$C0,$FF,$91,$1A,$AC,$1E,$41,$B9,$1F,$AA,$20,$05,$A6,$AF,$B2,$B6,$1A,$26,$21,$B6,$5F,$1A,$B1,$2B,$B5,$1B,$1D,$05,$B2,$A4,$B6,$AC,$1E,$1F,$1B,$AB,$1A,$BA,$2C,$B7,$25,$B1,$05,$A7,$A8,$B6,$25,$B7,$C0,$00

ONRAC14: 
.byte $94,$B2,$B3,$1A,$BE,$B6,$A4,$BC,$B6,$BE,$59,$1A,$B6,$A4,$BA,$20,$05,$B6,$AB,$1F,$AC,$2A,$36,$A5,$AD,$A8,$A6,$21,$A9,$A4,$4E,$C0,$00

ONRAC15: 
.byte $8F,$A4,$A5,$45,$1E,$B6,$A4,$BC,$1B,$41,$21,$BA,$1D,$B1,$05,$B7,$AB,$1A,$B6,$AB,$B5,$1F,$1A,$B6,$22,$AE,$BF,$42,$22,$BC,$05,$B7,$B5,$2B,$B6,$55,$A8,$1E,$BA,$25,$1A,$AF,$B2,$37,$C0,$05,$8A,$AF,$B6,$B2,$BF,$1B,$1D,$BC,$1B,$A8,$4E,$36,$A9,$20,$05,$A6,$B5,$BC,$B3,$57,$A6,$24,$28,$B1,$1A,$B3,$AF,$39,$A8,$C0,$00

ONRAC16: 
.byte $96,$BC,$FF,$B1,$A4,$B0,$1A,$AC,$1E,$94,$B2,$B3,$A8,$C0,$05,$92,$FF,$B6,$A4,$BA,$2D,$21,$B1,$35,$1C,$BF,$FF,$B1,$2B,$B5,$1B,$1D,$05,$BA,$A4,$B7,$25,$A9,$A4,$4E,$C0,$FF,$8B,$A8,$68,$A8,$B9,$1A,$34,$C4,$FF,$92,$05,$B7,$AB,$1F,$AE,$2D,$21,$5D,$1E,$A4,$FF,$4D,$A5,$B2,$B7,$C0,$00

ONRAC17: 
.byte $9D,$AB,$30,$1B,$46,$29,$B8,$3E,$A7,$1B,$2E,$62,$05,$B3,$B5,$B2,$B6,$B3,$25,$26,$1E,$82,$80,$80,$50,$2B,$63,$05,$A4,$AA,$B2,$C0,$00

SAMPLE: 
.byte $97,$B2,$C4,$05,$9D,$AB,$A4,$21,$AC,$1E,$AD,$B8,$37,$20,$B1,$05,$B8,$B1,$B8,$B6,$A4,$A5,$AF,$1A,$B6,$A4,$B0,$B3,$45,$C0,$00

MERMAID1: 
.byte $92,$A9,$33,$1A,$A6,$22,$B1,$B2,$21,$23,$AA,$A4,$1F,$1B,$1D,$05,$99,$B2,$BA,$25,$36,$54,$A0,$39,$25,$BF,$33,$1A,$BA,$AC,$4E,$05,$A5,$A8,$A6,$49,$1A,$A5,$B8,$A5,$A5,$AF,$2C,$BF,$1B,$1D,$B1,$05,$A7,$AC,$B6,$A4,$B3,$B3,$2B,$B5,$C0,$00

MERMAID2: 
.byte $8A,$B5,$1A,$60,$FF,$AA,$B2,$1F,$AA,$1B,$2E,$62,$A6,$B2,$34,$05,$A5,$B8,$A5,$A5,$AF,$2C,$C5,$00

MERMAID3: 
.byte $8A,$B6,$65,$B2,$2A,$20,$B6,$1B,$AB,$1A,$8F,$92,$8E,$97,$8D,$36,$A9,$05,$A0,$A4,$B7,$25,$65,$AC,$B9,$2C,$BF,$33,$A8,$69,$05,$98,$AB,$BF,$31,$B2,$2E,$AB,$B2,$B2,$C0,$00

MERMAID4: 
.byte $A2,$B2,$64,$41,$B9,$1A,$23,$B6,$B3,$B2,$3B,$40,$05,$B7,$B2,$FF,$34,$C4,$C4,$00

MERMAID5: 
.byte $9D,$AB,$AC,$1E,$30,$1B,$AB,$1A,$9C,$AB,$B5,$1F,$A8,$BE,$B6,$1B,$B2,$B3,$05,$A9,$AF,$B2,$35,$C0,$FF,$9D,$AB,$1A,$8F,$92,$8E,$97,$8D,$36,$A9,$05,$A0,$A4,$B7,$25,$BF,$FF,$94,$9B,$8A,$94,$8E,$97,$65,$AC,$32,$1E,$3C,$05,$B7,$AB,$1A,$A5,$B2,$B7,$28,$B0,$43,$AF,$B2,$35,$C0,$00

MERMAID6: 
.byte $92,$FF,$B6,$B8,$B3,$B3,$B2,$B6,$1A,$BC,$26,$20,$B5,$1A,$1C,$A8,$05,$AF,$A8,$AA,$3A,$A7,$2F,$BC,$69,$00

MERMAID7: 
.byte $99,$AF,$2B,$B6,$1A,$B6,$A4,$B9,$1A,$1C,$1A,$B6,$2B,$BF,$05,$A4,$B1,$27,$B0,$A4,$AE,$1A,$1C,$1A,$98,$9B,$8B,$24,$AB,$1F,$A8,$05,$A4,$AA,$A4,$1F,$C4,$00

MERMAID8: 
.byte $97,$B2,$BA,$BF,$FF,$35,$A7,$25,$FF,$41,$1E,$23,$B7,$55,$B1,$40,$C0,$05,$9D,$AB,$1A,$B6,$2B,$33,$AC,$4E,$31,$1A,$A4,$1E,$5B,$05,$BA,$A4,$1E,$62,$A9,$B2,$23,$BF,$31,$2B,$B8,$57,$A9,$B8,$AF,$C0,$00

MERMAID9: 
.byte $96,$BC,$43,$5C,$3A,$27,$8D,$2F,$B5,$BC,$AF,$33,$3A,$B7,$1B,$B2,$05,$B7,$AB,$1A,$AF,$22,$A7,$BF,$1B,$1D,$29,$5A,$B9,$25,$05,$B5,$A8,$B7,$55,$B1,$40,$C0,$FF,$92,$BE,$B9,$1A,$4C,$B7,$3A,$05,$BA,$B2,$3B,$A8,$23,$27,$BA,$41,$21,$AB,$A4,$B3,$B3,$3A,$40,$69,$05,$96,$A4,$BC,$62,$BF,$24,$AB,$1A,$AA,$23,$BA,$FF,$45,$AA,$1E,$22,$A7,$05,$BA,$A4,$AF,$AE,$40,$20,$BA,$A4,$BC,$C5,$00

MERMAID10: 
.byte $9E,$B1,$62,$68,$A8,$B9,$A4,$A5,$45,$C4,$C4,$05,$A2,$B2,$B8,$38,$22,$31,$23,$A4,$1C,$A8,$05,$B8,$B1,$A7,$25,$BA,$39,$25,$C5,$C4,$05,$92,$BE,$B0,$2D,$B0,$B3,$23,$B6,$3E,$A7,$C4,$00

MERMAID11: 
.byte $9D,$B2,$FF,$B8,$B1,$AF,$B2,$A6,$AE,$1B,$AB,$1A,$96,$AC,$B5,$A4,$66,$05,$9D,$B2,$BA,$25,$1B,$AB,$1A,$95,$A8,$A9,$A8,$1F,$30,$AB,$05,$B8,$B6,$40,$20,$42,$B8,$B6,$AC,$51,$AF,$1B,$3C,$A8,$C0,$00

LOCKEDDOOR: 
.byte $9D,$AB,$AC,$1E,$A7,$B2,$35,$2D,$1E,$AF,$B2,$A6,$AE,$A8,$27,$A5,$BC,$05,$B7,$AB,$1A,$B0,$BC,$37,$AC,$A6,$FF,$94,$8E,$A2,$C0,$00

GAIA1: 
.byte $9D,$AB,$30,$1B,$46,$29,$AC,$1E,$90,$A4,$AC,$A4,$69,$00

GAIA2: 
.byte $91,$A4,$B9,$1A,$BC,$26,$31,$A8,$3A,$1B,$2E,$1C,$A8,$05,$A6,$AC,$B7,$BC,$24,$26,$1C,$36,$54,$1D,$23,$C5,$FF,$92,$05,$AD,$B8,$B6,$21,$A6,$22,$B1,$B2,$21,$B8,$3B,$25,$37,$22,$A7,$05,$A4,$FF,$BA,$35,$A7,$24,$B3,$B2,$AE,$3A,$1B,$1D,$23,$C0,$05,$92,$FF,$41,$B9,$1A,$BA,$B2,$3B,$A8,$23,$27,$BA,$AB,$39,$05,$AF,$A4,$2A,$B8,$A4,$66,$69,$00

GAIA3: 
.byte $95,$A8,$AA,$3A,$A7,$24,$A4,$BC,$B6,$1B,$AB,$1A,$9C,$94,$A2,$05,$A0,$8A,$9B,$9B,$92,$98,$9B,$9C,$43,$45,$BA,$20,$A5,$26,$B7,$BF,$05,$AB,$A8,$B5,$1A,$22,$A7,$1B,$AB,$A8,$23,$BF,$43,$B5,$49,$20,$05,$A6,$A4,$37,$AF,$1A,$3D,$AA,$AB,$FF,$1F,$1B,$AB,$1A,$B6,$AE,$BC,$C0,$00

GAIA4: 
.byte $92,$FF,$B6,$A4,$BA,$20,$FF,$B6,$AB,$1F,$AC,$2A,$36,$A5,$AD,$A8,$A6,$B7,$05,$A9,$AF,$BC,$1F,$AA,$1B,$46,$2F,$A7,$B6,$1B,$AB,$1A,$2B,$37,$C0,$00

GAIA5: 
.byte $9E,$B1,$62,$68,$A8,$B9,$A4,$A5,$45,$C4,$05,$A2,$B2,$B8,$20,$B5,$1A,$B2,$B8,$B7,$B6,$AC,$A7,$25,$B6,$BF,$05,$B5,$AC,$AA,$AB,$B7,$C5,$05,$91,$B2,$BA,$67,$AC,$27,$BC,$26,$FF,$66,$B7,$1B,$3D,$1E,$A9,$2F,$05,$B1,$B2,$B5,$1C,$C5,$00

GAIA6: 
.byte $95,$A8,$21,$B0,$1A,$3E,$A8,$69,$FF,$A2,$2C,$BF,$1B,$1D,$23,$05,$BA,$A4,$1E,$A4,$4F,$B5,$4C,$2C,$B6,$35,$1B,$AB,$39,$05,$B6,$B7,$B8,$A7,$AC,$A8,$27,$95,$A8,$A9,$A8,$1F,$30,$AB,$C0,$00

GAIA7: 
.byte $98,$B1,$AF,$BC,$20,$43,$A4,$AC,$B5,$BC,$38,$22,$67,$B5,$A4,$BA,$05,$98,$A1,$A2,$8A,$95,$8E,$43,$B5,$49,$1B,$AB,$1A,$B6,$B3,$B5,$1F,$AA,$C0,$00

GAIA8: 
.byte $8E,$B9,$25,$BC,$3C,$1A,$1C,$1F,$AE,$B6,$1B,$1D,$05,$B7,$B2,$BA,$25,$FF,$1F,$FF,$A2,$A4,$AB,$B1,$AC,$AE,$55,$B0,$05,$8D,$A8,$B6,$25,$21,$AC,$1E,$A4,$42,$AC,$B5,$A4,$66,$C0,$05,$92,$FF,$BA,$B2,$3B,$25,$69,$00

GAIA9: 
.byte $91,$A4,$B5,$A7,$4B,$41,$B5,$BF,$50,$26,$20,$B5,$1A,$28,$B2,$05,$AF,$A4,$53,$C4,$FF,$92,$FF,$8B,$98,$9D,$9D,$95,$8E,$8D,$1B,$1D,$05,$A9,$A4,$AC,$B5,$BC,$20,$3B,$24,$B2,$AF,$27,$1D,$B5,$1B,$B2,$20,$05,$A6,$A4,$B5,$A4,$B9,$22,$C0,$00

GAIA10: 
.byte $95,$A8,$AA,$3A,$A7,$1E,$B6,$A4,$BC,$1B,$AB,$39,$1B,$1D,$05,$A6,$A4,$37,$AF,$1A,$1F,$1B,$AB,$1A,$BA,$2C,$21,$AC,$1E,$A4,$05,$B3,$AF,$5E,$1A,$28,$1B,$2C,$21,$A6,$26,$B5,$A4,$66,$C0,$00

GAIA11: 
.byte $C5,$B5,$A8,$BA,$B2,$99,$1B,$A4,$25,$47,$A8,$B9,$A4,$AB,$FF,$B8,$B2,$BC,$36,$8D,$00

GAIA12: 
.byte $A0,$AB,$39,$BE,$B6,$1B,$41,$21,$A5,$4D,$49,$FF,$B8,$B3,$1B,$B2,$C5,$05,$92,$B7,$BE,$B6,$1B,$5F,$AE,$1F,$AA,$31,$5E,$AE,$BA,$2F,$A7,$B6,$C4,$00

GAIA13: 
.byte $9D,$AB,$1A,$A9,$A4,$AC,$B5,$BC,$20,$B7,$1B,$AB,$1A,$B6,$B3,$B5,$1F,$AA,$05,$BA,$A4,$1E,$AE,$AC,$A7,$B1,$A4,$B3,$B3,$40,$C0,$00

LEFEIN1: 
.byte $A0,$AC,$1C,$1B,$3D,$1E,$8C,$91,$92,$96,$8E,$50,$26,$38,$22,$05,$A8,$B1,$B7,$25,$1B,$AB,$1A,$96,$AC,$B5,$A4,$AA,$1A,$9D,$46,$25,$C0,$00

LEFEIN2: 
.byte $9D,$AB,$1A,$96,$AC,$B5,$A4,$AA,$1A,$9D,$46,$25,$33,$3F,$1B,$1D,$05,$AA,$A4,$53,$5D,$BC,$1B,$2E,$26,$44,$AB,$49,$1A,$1F,$05,$B7,$AB,$1A,$B6,$AE,$BC,$C0,$00

LEFEIN3: 
.byte $84,$80,$80,$50,$2B,$B5,$1E,$A4,$AA,$B2,$BF,$33,$1A,$41,$A7,$20,$B1,$05,$A4,$A7,$B9,$22,$48,$27,$A6,$AC,$B9,$61,$AC,$BD,$39,$AC,$3C,$C0,$05,$98,$B8,$44,$1F,$53,$23,$B6,$21,$BA,$3F,$1B,$1D,$05,$B8,$B1,$AC,$B9,$25,$3E,$C4,$C4,$00

LEFEIN4: 
.byte $95,$B8,$69,$B3,$A4,$69,$C5,$05,$95,$B8,$69,$B3,$A4,$69,$C5,$00

LEFEIN5: 
.byte $A0,$A8,$20,$23,$1B,$1D,$FF,$95,$A8,$A9,$A8,$1F,$30,$AB,$C0,$05,$98,$B1,$AF,$4B,$26,$B5,$31,$B5,$A4,$B9,$2C,$21,$62,$51,$34,$05,$9C,$94,$A2,$FF,$A0,$8A,$9B,$9B,$92,$98,$9B,$9C,$C0,$FF,$A2,$26,$B5,$05,$8A,$92,$9B,$9C,$91,$92,$99,$33,$3F,$1B,$1D,$AC,$63,$C0,$00

LEFEIN6: 
.byte $9D,$AB,$1A,$8F,$95,$98,$8A,$9D,$92,$97,$90,$FF,$8C,$8A,$9C,$9D,$95,$8E,$69,$05,$98,$B8,$B5,$20,$B1,$A6,$2C,$28,$B5,$1E,$68,$32,$A7,$05,$B7,$AB,$A8,$23,$C0,$FF,$9D,$AB,$1A,$96,$AC,$B5,$A4,$AA,$1A,$9D,$46,$25,$05,$AC,$B6,$1B,$AB,$1A,$3A,$B7,$B5,$22,$48,$C0,$00

LEFEIN7: 
.byte $8A,$B7,$1B,$AB,$1A,$57,$B0,$1A,$4C,$05,$A7,$A8,$37,$B5,$B8,$A6,$57,$3C,$20,$FF,$45,$AA,$3A,$27,$BA,$3F,$05,$A5,$B2,$B5,$B1,$69,$FF,$FF,$92,$29,$84,$80,$80,$50,$2B,$63,$BF,$05,$A0,$8A,$9B,$9B,$92,$98,$9B,$9C,$33,$AC,$1C,$FF,$98,$9B,$8B,$9C,$33,$AC,$4E,$05,$A4,$B3,$B3,$2B,$B5,$1B,$B2,$24,$A4,$B9,$1A,$26,$B5,$05,$B3,$A8,$B2,$B3,$45,$FF,$C0,$05,$8A,$B5,$1A,$BC,$26,$C5,$69,$00

LEFEIN8: 
.byte $A0,$A8,$43,$26,$AA,$AB,$21,$BA,$AC,$1C,$FF,$9D,$92,$8A,$52,$9D,$BF,$05,$A5,$B8,$21,$BA,$25,$1A,$B8,$B1,$B6,$B8,$A6,$A6,$2C,$B6,$A9,$B8,$AF,$C0,$05,$9D,$AB,$1A,$8F,$92,$8E,$97,$8D,$FF,$B1,$46,$FF,$1F,$41,$A5,$5B,$B6,$05,$B2,$B8,$44,$8F,$95,$98,$8A,$9D,$92,$97,$90,$FF,$8C,$8A,$9C,$9D,$95,$8E,$C0,$00

LEFEIN9: 
.byte $98,$B8,$44,$AF,$3F,$21,$A9,$AC,$B9,$1A,$A0,$2F,$5C,$35,$B6,$05,$AF,$A8,$A9,$B7,$1B,$2E,$A9,$1F,$A7,$1B,$AB,$1A,$51,$B8,$3E,$05,$B2,$A9,$1B,$AB,$1A,$BA,$35,$AF,$A7,$BE,$1E,$A7,$A8,$51,$BC,$C0,$05,$A0,$A8,$FF,$94,$B1,$46,$1B,$1D,$4B,$68,$32,$BF,$31,$B8,$B7,$BF,$05,$A4,$B6,$31,$39,$B6,$C0,$00

LEFEIN10: 
.byte $A0,$A8,$FF,$AE,$5A,$BA,$1B,$AB,$39,$20,$FF,$AA,$23,$39,$05,$B3,$B2,$BA,$25,$38,$3C,$B7,$4D,$4E,$40,$1B,$1D,$05,$8F,$92,$8E,$97,$8D,$9C,$C0,$FF,$98,$55,$43,$AC,$B9,$1A,$A5,$B5,$A4,$B9,$2C,$B7,$05,$A0,$A4,$B5,$5C,$35,$1E,$45,$A9,$B7,$BF,$FF,$5A,$B9,$25,$1B,$B2,$05,$B5,$A8,$B7,$55,$B1,$C0,$00

LEFEIN11: 
.byte $A0,$A8,$FF,$41,$32,$4F,$3F,$3E,$27,$3C,$1B,$1D,$05,$AF,$A8,$AA,$3A,$A7,$1E,$A9,$B5,$49,$FF,$AA,$3A,$25,$39,$AC,$3C,$05,$B7,$B2,$FF,$AA,$3A,$25,$39,$AC,$3C,$C0,$FF,$8B,$B8,$21,$84,$80,$80,$05,$BC,$A8,$2F,$1E,$41,$B9,$1A,$51,$B8,$3E,$27,$26,$B5,$05,$B0,$A8,$B0,$35,$AC,$2C,$1B,$2E,$A9,$A4,$A7,$A8,$C0,$00

LEFEIN12: 
.byte $98,$AB,$BF,$1B,$AB,$1A,$95,$92,$90,$91,$9D,$FF,$A0,$8A,$9B,$9B,$92,$98,$9B,$9C,$C4,$C4,$05,$9D,$AB,$1A,$45,$AA,$3A,$27,$30,$1B,$B5,$B8,$A8,$C4,$00

LEFEIN13: 
.byte $9E,$B1,$57,$58,$84,$80,$80,$50,$2B,$B5,$1E,$A4,$AA,$2E,$60,$05,$A6,$B2,$B1,$B7,$4D,$4E,$40,$1B,$AB,$1A,$99,$46,$25,$36,$A9,$05,$B7,$AB,$1A,$A0,$1F,$A7,$C0,$FF,$9D,$3D,$1E,$3A,$A4,$A5,$AF,$40,$05,$B8,$B6,$1B,$B2,$24,$B8,$B6,$B3,$3A,$A7,$1B,$AB,$1A,$51,$37,$45,$05,$AC,$B1,$1B,$AB,$1A,$A4,$AC,$B5,$C0,$00

LEFEIN14: 
.byte $9D,$AB,$1A,$B3,$46,$25,$36,$54,$A0,$1F,$27,$BA,$3F,$05,$B7,$A4,$AE,$A8,$29,$A5,$4B,$9D,$92,$8A,$52,$9D,$C0,$00

GRAVE2: 
.byte $91,$A8,$B5,$1A,$68,$A8,$1E,$8E,$B5,$A7,$5C,$A6,$AE,$05,$FF,$FF,$FF,$FF,$88,$83,$87,$FF,$C2,$FF,$88,$86,$86,$05,$FF,$FF,$FF,$FF,$FF,$FF,$9B,$C0,$92,$C0,$99,$C0,$00

LEFEIN15: 
.byte $92,$FF,$BA,$B2,$3B,$25,$2D,$A9,$1B,$AB,$1A,$4D,$A5,$B2,$B7,$B6,$05,$B0,$A4,$A7,$1A,$A5,$4B,$26,$B5,$20,$B1,$A6,$2C,$28,$63,$05,$A4,$B5,$1A,$37,$AC,$4E,$42,$B2,$B9,$1F,$AA,$C5,$00

LEFEIN16: 
.byte $9D,$AB,$1A,$8F,$95,$98,$8A,$9D,$92,$97,$90,$FF,$8C,$8A,$9C,$9D,$95,$8E,$05,$A9,$AF,$B2,$39,$1E,$3D,$AA,$AB,$FF,$1F,$1B,$1D,$05,$B6,$AE,$BC,$BF,$24,$A8,$A8,$B0,$1F,$AA,$AF,$BC,$20,$B0,$B2,$2A,$05,$B7,$AB,$1A,$37,$2F,$B6,$C0,$00

TOWERROBOT1: 
.byte $98,$B1,$1A,$4C,$FF,$B8,$1E,$2C,$51,$B3,$A8,$27,$BA,$AC,$1C,$05,$A4,$FF,$8C,$9E,$8B,$8E,$C0,$FF,$91,$1A,$A9,$AF,$B2,$39,$A8,$27,$A9,$2F,$05,$B7,$B2,$1B,$AB,$1A,$BA,$2C,$B7,$C0,$00

TOWERROBOT2: 
.byte $9D,$B5,$22,$B6,$B3,$35,$B7,$25,$36,$B3,$25,$39,$AC,$3C,$05,$B5,$A8,$B4,$B8,$AC,$B5,$A8,$1E,$A4,$FF,$8C,$9E,$8B,$8E,$C0,$00

TOWERROBOT3: 
.byte $8A,$B5,$1A,$BC,$26,$1B,$AB,$1A,$B0,$A4,$37,$25,$C5,$00

SKYWINDOW1: 
.byte $A2,$B2,$B8,$38,$22,$65,$B2,$B2,$AE,$36,$B8,$21,$B2,$B9,$25,$05,$B7,$AB,$1A,$BA,$35,$AF,$27,$A9,$B5,$49,$1B,$AB,$30,$05,$BA,$AC,$3B,$46,$C0,$00

CARDIA1: 
.byte $92,$A9,$50,$26,$20,$B5,$1A,$A5,$B5,$A4,$B9,$1A,$3A,$26,$AA,$AB,$BF,$05,$B7,$B5,$4B,$34,$A8,$B7,$1F,$AA,$1B,$AB,$1A,$94,$1F,$AA,$36,$A9,$05,$B7,$AB,$1A,$8D,$B5,$A4,$AA,$3C,$B6,$BF,$FF,$8B,$8A,$91,$8A,$96,$9E,$9D,$C0,$00

CARDIA2: 
.byte $9E,$B1,$B3,$B5,$4C,$5B,$A4,$A5,$AF,$1A,$A5,$B8,$B6,$1F,$2C,$B6,$05,$AC,$B6,$FF,$B1,$B2,$B7,$20,$4F,$B5,$5E,$57,$A6,$1A,$4C,$1B,$1D,$05,$8D,$B5,$A4,$AA,$3C,$1E,$4C,$FF,$8C,$2F,$A7,$AC,$A4,$C0,$00

CARDIA3: 
.byte $95,$B2,$2A,$20,$AA,$B2,$BF,$FF,$8D,$B5,$A4,$AA,$3C,$1E,$22,$A7,$05,$AB,$B8,$B0,$22,$1E,$68,$32,$A7,$20,$3B,$1B,$B5,$A4,$A7,$40,$05,$B7,$B2,$66,$1C,$25,$C0,$00

CARDIA4: 
.byte $A2,$B2,$B8,$20,$B5,$1A,$B1,$B2,$B7,$20,$A9,$B5,$A4,$AC,$27,$4C,$05,$B0,$A8,$C5,$C5,$05,$9D,$AB,$3A,$BF,$FF,$92,$20,$B0,$2D,$B0,$B3,$23,$B6,$3E,$A7,$C4,$00

CARDIA5: 
.byte $9C,$A8,$1A,$BC,$26,$B5,$43,$5E,$1A,$B8,$B3,$3C,$1B,$1D,$05,$A6,$AF,$A8,$22,$33,$39,$25,$C0,$FF,$91,$46,$67,$AC,$B5,$B7,$BC,$C4,$05,$8C,$B2,$34,$C4,$FF,$A0,$3F,$AB,$50,$26,$B5,$43,$A4,$48,$C4,$00

CARDIA6: 
.byte $A0,$A8,$20,$23,$FF,$AA,$B2,$1F,$AA,$1B,$2E,$1C,$A8,$05,$8C,$A4,$37,$AF,$1A,$4C,$FF,$98,$B5,$A7,$2B,$AF,$1B,$2E,$1C,$A8,$05,$B1,$B2,$B5,$1C,$2B,$37,$C0,$FF,$9D,$1D,$B5,$1A,$60,$33,$AC,$4E,$05,$B7,$A8,$37,$BF,$20,$B1,$27,$A5,$B5,$1F,$AA,$31,$5E,$AE,$05,$B3,$B5,$B2,$4C,$36,$54,$26,$B5,$38,$26,$B5,$A4,$66,$C0,$00

CARDIA7: 
.byte $9D,$AB,$1A,$B3,$4D,$4C,$36,$A9,$50,$26,$B5,$05,$A6,$B2,$55,$A4,$AA,$1A,$B0,$AC,$AA,$AB,$21,$62,$05,$A4,$B1,$BC,$1C,$1F,$AA,$C0,$00

CARDIA8: 
.byte $91,$A4,$B9,$1A,$BC,$26,$FF,$34,$21,$8B,$8A,$91,$8A,$96,$9E,$9D,$BF,$05,$B7,$AB,$1A,$8D,$B5,$A4,$AA,$B2,$29,$94,$1F,$AA,$C5,$FF,$91,$A8,$05,$AB,$B2,$B1,$35,$B6,$1B,$AB,$B2,$B6,$1A,$BA,$AC,$1C,$05,$A6,$B2,$55,$A4,$AA,$1A,$3F,$1B,$B5,$B8,$A8,$05,$BA,$A4,$B5,$5C,$35,$B6,$C0,$00

CARDIA9: 
.byte $98,$B1,$AF,$BC,$1B,$AB,$1A,$A6,$26,$B5,$A4,$66,$26,$1E,$3C,$2C,$05,$A5,$B5,$1F,$AA,$31,$5E,$AE,$1B,$AB,$1A,$B3,$4D,$4C,$36,$A9,$05,$B7,$AB,$A8,$AC,$B5,$38,$26,$B5,$A4,$66,$C0,$00

CARDIA10: 
.byte $98,$B1,$A6,$1A,$1F,$1B,$AB,$1A,$B1,$35,$1C,$BF,$1B,$1D,$23,$05,$BA,$A8,$B5,$1A,$A5,$2B,$B8,$57,$A9,$B8,$AF,$4F,$5F,$5E,$2C,$05,$A4,$B1,$27,$A5,$AC,$47,$34,$A6,$41,$B1,$AC,$51,$AF,$05,$A6,$A4,$37,$AF,$2C,$C0,$00

CARDIA11: 
.byte $9D,$AB,$AC,$1E,$30,$FF,$8B,$8A,$91,$8A,$96,$9E,$9D,$BE,$B6,$FF,$4D,$49,$C0,$00

CARDIA12: 
.byte $8B,$8A,$91,$8A,$96,$9E,$9D,$FF,$B9,$25,$AC,$A9,$AC,$2C,$1B,$1D,$05,$B7,$B5,$B8,$1A,$A6,$26,$B5,$A4,$AA,$1A,$4C,$20,$4E,$C0,$00

GRAVE: 
.byte $9D,$AB,$AC,$1E,$30,$20,$1B,$49,$A5,$C0,$00

WELL: 
.byte $9D,$AB,$AC,$1E,$30,$20,$33,$A8,$4E,$C0,$FF,$A2,$26,$05,$B0,$AC,$AA,$AB,$B7,$1B,$AB,$1F,$AE,$1B,$AB,$39,$1B,$1D,$23,$05,$AC,$B6,$24,$B2,$34,$1C,$1F,$AA,$1B,$B2,$2D,$B7,$69,$05,$8B,$B8,$21,$1F,$43,$5E,$21,$5B,$2D,$1E,$AD,$B8,$37,$05,$A4,$B1,$FF,$35,$A7,$1F,$2F,$BC,$33,$A8,$4E,$C0,$00

TREASURE: 
.byte $92,$B1,$1B,$AB,$1A,$B7,$23,$3F,$55,$1A,$A5,$B2,$BB,$BF,$05,$BC,$B2,$B8,$43,$B2,$B8,$3B,$69,$01,$02,$00

TREASUREFULL: 
.byte $8C,$A4,$B1,$BE,$21,$AB,$B2,$AF,$A7,$20,$B1,$BC,$B0,$B2,$23,$C0,$00

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

OXYALESPRINGE: 
.byte $8A,$B7,$1B,$AB,$1A,$A5,$B2,$B7,$28,$B0,$36,$A9,$1B,$1D,$05,$B6,$B3,$B5,$1F,$AA,$BF,$24,$B2,$34,$1C,$1F,$AA,$2D,$B6,$05,$A9,$AF,$46,$1F,$AA,$C0,$00

TIAMATSOMETHING: 
.byte $9D,$92,$8A,$52,$9D,$2D,$B6,$1B,$AB,$1A,$8F,$92,$8E,$97,$8D,$36,$A9,$05,$B7,$AB,$1A,$A0,$92,$97,$8D,$69,$00

SKYWINDOW2: 
.byte $8F,$B5,$49,$1B,$3D,$1E,$BA,$1F,$A7,$46,$36,$B1,$1A,$A6,$22,$05,$B6,$A8,$1A,$1C,$1A,$3A,$57,$B5,$1A,$BA,$35,$AF,$A7,$C0,$05,$9D,$AB,$1A,$8F,$26,$44,$8F,$35,$48,$1E,$A4,$23,$05,$A9,$AF,$46,$1F,$AA,$1B,$B2,$66,$1C,$25,$BF,$FF,$1F,$28,$05,$B7,$AB,$1A,$A6,$3A,$B7,$25,$36,$A9,$1B,$AB,$1A,$8F,$26,$B5,$05,$8A,$AF,$B7,$2F,$B6,$C0,$FF,$92,$B1,$28,$1B,$AB,$1A,$9D,$A8,$B0,$B3,$45,$05,$B2,$A9,$FF,$8F,$92,$8E,$97,$8D,$9C,$C0,$00

LICH: 
.byte $9D,$AB,$1A,$8F,$92,$8E,$97,$8D,$BE,$1E,$A5,$A4,$4E,$38,$B5,$5E,$AE,$B6,$05,$B2,$B3,$3A,$69,$FF,$8A,$29,$49,$1F,$26,$1E,$A6,$AF,$26,$A7,$05,$B5,$AC,$B6,$2C,$BF,$20,$3B,$20,$29,$A8,$B9,$61,$24,$41,$B3,$A8,$05,$A6,$B2,$2A,$2B,$AF,$B6,$69,$05,$92,$B7,$2D,$1E,$95,$92,$8C,$91,$BF,$1B,$AB,$1A,$8F,$92,$8E,$97,$8D,$36,$A9,$05,$8E,$A4,$B5,$1C,$C0,$00

KARY: 
.byte $92,$B6,$2D,$21,$BC,$26,$BF,$1B,$AB,$1A,$B7,$1F,$A7,$25,$05,$B7,$AB,$A4,$21,$A7,$A8,$A9,$2B,$B7,$40,$1B,$AB,$1A,$8F,$92,$8E,$97,$8D,$05,$B2,$A9,$1B,$AB,$1A,$8E,$2F,$1C,$BF,$20,$3B,$05,$A7,$AC,$37,$55,$62,$27,$B0,$BC,$24,$45,$A8,$B3,$C5,$05,$92,$BF,$FF,$94,$8A,$9B,$A2,$33,$AC,$4E,$FF,$B1,$46,$24,$AB,$46,$05,$BC,$B2,$B8,$1B,$AB,$1A,$A9,$35,$A6,$1A,$4C,$FF,$8F,$AC,$23,$BF,$05,$A4,$B1,$27,$BC,$26,$24,$41,$4E,$31,$55,$29,$1F,$05,$AC,$B7,$1E,$A9,$AF,$A4,$B0,$2C,$C4,$C4,$00

KRAKEN: 
.byte $9D,$AB,$1A,$8F,$92,$8E,$97,$8D,$BE,$1E,$A5,$A4,$4E,$2D,$B6,$05,$B6,$AB,$39,$53,$23,$A7,$BF,$FF,$A8,$B9,$A4,$B3,$35,$39,$1F,$AA,$05,$A4,$AF,$AF,$1B,$AB,$1A,$BA,$39,$25,$C0,$05,$91,$B2,$BF,$FF,$91,$B2,$BF,$FF,$91,$B2,$69,$05,$91,$B2,$BA,$43,$B2,$B2,$AF,$AB,$2F,$A7,$BC,$1B,$2E,$A7,$A4,$23,$05,$A6,$AB,$5F,$45,$2A,$1A,$34,$BF,$FF,$94,$9B,$8A,$94,$8E,$97,$1B,$1D,$05,$8F,$92,$8E,$97,$8D,$36,$A9,$1B,$AB,$1A,$A0,$39,$25,$C0,$00

TIAMAT: 
.byte $A0,$AB,$39,$C5,$C5,$05,$A2,$B2,$B8,$38,$22,$24,$B3,$2B,$AE,$FF,$95,$A8,$A9,$A8,$1F,$30,$AB,$C5,$00

LEFEIN17: 
.byte $9D,$AB,$25,$1A,$AC,$1E,$A4,$24,$28,$B1,$1A,$B3,$AF,$39,$A8,$05,$B2,$B1,$1B,$AB,$1A,$A9,$AF,$B2,$35,$69,$05,$A2,$B2,$B8,$24,$3A,$B6,$1A,$B6,$B2,$34,$1C,$1F,$AA,$69,$05,$8E,$B9,$61,$C5,$69,$00

STONEPLATE: 
.byte $95,$AC,$AA,$AB,$B7,$B1,$1F,$47,$25,$B8,$B3,$B7,$1E,$A9,$B5,$49,$05,$B7,$AB,$1A,$8F,$92,$8E,$97,$8D,$BE,$1E,$A5,$A4,$4E,$69,$05,$9C,$B2,$BF,$50,$26,$FF,$41,$B9,$1A,$A6,$49,$1A,$1C,$30,$05,$A9,$A4,$B5,$69,$05,$92,$BF,$FF,$9D,$92,$8A,$52,$9D,$1B,$AB,$1A,$8F,$92,$8E,$97,$8D,$36,$A9,$05,$B7,$AB,$1A,$A0,$1F,$27,$BA,$AC,$4E,$FF,$B1,$46,$4F,$B8,$B7,$20,$B1,$05,$A8,$B1,$A7,$1B,$2E,$BC,$26,$B5,$20,$A7,$32,$B1,$B7,$B8,$23,$C4,$C4,$00










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
    STA tmp+6           ; back the ID up for later

    LDY #0              ; mulitply the ID by 4 (4 bytes of talk data per object)
    STY tmp+5
    ASL A
    ROL tmp+5
    ASL A
    ROL tmp+5

    ADC #<lut_MapObjTalkData   ; and add the pointer to the start of the talk data table to that
    STA tmp+4
    LDA #>lut_MapObjTalkData
    ADC tmp+5
    STA tmp+5                  ; (tmp+4) now points to the talk data for this object

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

    LDA tmp+6           ; get the object ID (previously backed up)
    ASL A               ; *2 (two bytes per pointer) (high bit shifted into C)
    TAY                 ; throw in Y for indexing
    BCC :+              ; if C clear, we read from bottom half of table, otherwise, top half

     LDA lut_MapObjTalkJumpTbl+$100, Y  ; copy the desired pointer from the talk jump table
     STA tmp+6
     LDA lut_MapObjTalkJumpTbl+$101, Y
     STA tmp+7
     JMP (tmp+6)                        ; and jump to it, then exit

:    LDA lut_MapObjTalkJumpTbl, Y       ; same, but with low half of table
     STA tmp+6
     LDA lut_MapObjTalkJumpTbl+1, Y
     STA tmp+7
     JMP (tmp+6)


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

 ;; No object (ID=00)
.WORD Talk_None                ; 00

 ;; Several special objects(ID=01-1F)
.WORD Talk_KingConeria         ; 01
.WORD Talk_Garland             ; 02
.WORD Talk_Princess1           ; 03
.WORD Talk_Bikke               ; 04
.WORD Talk_ElfDoc              ; 05
.WORD Talk_ElfPrince           ; 06
.WORD Talk_Astos               ; 07
.WORD Talk_Nerrick             ; 08
.WORD Talk_Smith               ; 09
.WORD Talk_Matoya              ; 0A
.WORD Talk_Unne                ; 0B
.WORD Talk_Vampire             ; 0C
.WORD Talk_Sarda               ; 0D
.WORD Talk_Bahamut             ; 0E
.WORD Talk_ifvis               ; 0F
.WORD Talk_SubEng              ; 10
.WORD Talk_CubeBot             ; 11
.WORD Talk_Princess2           ; 12
.WORD Talk_Fairy               ; 13
.WORD Talk_Titan               ; 14
.WORD Talk_CanoeSage           ; 15
.WORD Talk_norm                ; 16
.WORD Talk_norm                ; 17
.WORD Talk_Replace             ; 18
.WORD Talk_Replace             ; 19
.WORD Talk_fight               ; 1A
.WORD Talk_fight               ; 1B
.WORD Talk_fight               ; 1C
.WORD Talk_fight               ; 1D
.WORD Talk_fight               ; 1E
.WORD Talk_Unused              ; 1f

 ;; Coneria people (ID=20-39)
.WORD Talk_ifvis               ; 20
.WORD Talk_ifvis               ; 21
.WORD Talk_ifvis               ; 22
.WORD Talk_ifitem              ; 23
.WORD Talk_ifvis               ; 24
.WORD Talk_ifvis               ; 25
.WORD Talk_Invis               ; 26
.WORD Talk_ifbridge            ; 27
.WORD Talk_ifvis               ; 28
.WORD Talk_ifvis               ; 29
.WORD Talk_ifvis               ; 2A
.WORD Talk_ifvis               ; 2B
.WORD Talk_ifitem              ; 2C
.WORD Talk_ifvis               ; 2D
.WORD Talk_ifitem              ; 2E
.WORD Talk_ifevent             ; 2F
.WORD Talk_ifvis               ; 30
.WORD Talk_ifvis               ; 31
.WORD Talk_GoBridge            ; 32
.WORD Talk_ifvis               ; 33
.WORD Talk_4Orb                ; 34
.WORD Talk_norm                ; 35
.WORD Talk_norm                ; 36
.WORD Talk_ifvis               ; 37
.WORD Talk_ifvis               ; 38
.WORD Talk_norm                ; 39

 ;; Sky Warriors(ID=3A-3E)
.WORD Talk_4Orb                ; 3A
.WORD Talk_4Orb                ; 3B
.WORD Talk_4Orb                ; 3C
.WORD Talk_4Orb                ; 3D
.WORD Talk_4Orb                ; 3E

 ;; The rest(ID=3F-CF)
.WORD Talk_norm                ; 3F
.WORD Talk_norm                ; 40
.WORD Talk_norm                ; 41
.WORD Talk_ifevent             ; 42
.WORD Talk_ifevent             ; 43
.WORD Talk_ifevent             ; 44
.WORD Talk_norm                ; 45
.WORD Talk_ifevent             ; 46
.WORD Talk_ifitem              ; 47
.WORD Talk_norm                ; 48
.WORD Talk_ifevent             ; 49
.WORD Talk_ifevent             ; 4A
.WORD Talk_ifitem              ; 4B
.WORD Talk_ifevent             ; 4C
.WORD Talk_ifevent             ; 4D
.WORD Talk_ifevent             ; 4E
.WORD Talk_ifevent             ; 4F
.WORD Talk_ifevent             ; 50
.WORD Talk_ifevent             ; 51
.WORD Talk_norm                ; 52
.WORD Talk_ifcanoe             ; 53
.WORD Talk_ifitem              ; 54
.WORD Talk_ifevent             ; 55
.WORD Talk_ifevent             ; 56
.WORD Talk_norm                ; 57
.WORD Talk_norm                ; 58
.WORD Talk_ifcanal             ; 59
.WORD Talk_norm                ; 5A
.WORD Talk_norm                ; 5B
.WORD Talk_ifitem              ; 5C
.WORD Talk_ifitem              ; 5D
.WORD Talk_norm                ; 5E
.WORD Talk_ifcanal             ; 5F
.WORD Talk_ifkeytnt            ; 60
.WORD Talk_norm                ; 61
.WORD Talk_ifcanal             ; 62
.WORD Talk_norm                ; 63
.WORD Talk_norm                ; 64
.WORD Talk_norm                ; 65
.WORD Talk_norm                ; 66
.WORD Talk_norm                ; 67
.WORD Talk_ifvis               ; 68
.WORD Talk_norm                ; 69
.WORD Talk_ifearthvamp         ; 6A
.WORD Talk_ifitem              ; 6B
.WORD Talk_ifvis               ; 6C
.WORD Talk_ifearthvamp         ; 6D
.WORD Talk_norm                ; 6E
.WORD Talk_norm                ; 6F
.WORD Talk_ifitem              ; 70
.WORD Talk_ifairship           ; 71
.WORD Talk_norm                ; 72
.WORD Talk_ifevent             ; 73
.WORD Talk_ifitem              ; 74
.WORD Talk_norm                ; 75
.WORD Talk_norm                ; 76
.WORD Talk_norm                ; 77
.WORD Talk_4Orb                ; 78
.WORD Talk_4Orb                ; 79
.WORD Talk_4Orb                ; 7A
.WORD Talk_4Orb                ; 7B
.WORD Talk_4Orb                ; 7C
.WORD Talk_4Orb                ; 7D
.WORD Talk_4Orb                ; 7E
.WORD Talk_ifitem              ; 7F
.WORD Talk_ifearthfire         ; 80
.WORD Talk_ifitem              ; 81
.WORD Talk_norm                ; 82
.WORD Talk_norm                ; 83
.WORD Talk_CoOGuy              ; 84
.WORD Talk_norm                ; 85
.WORD Talk_norm                ; 86
.WORD Talk_norm                ; 87
.WORD Talk_norm                ; 88
.WORD Talk_norm                ; 89
.WORD Talk_norm                ; 8A
.WORD Talk_norm                ; 8B
.WORD Talk_norm                ; 8C
.WORD Talk_norm                ; 8D
.WORD Talk_norm                ; 8E
.WORD Talk_norm                ; 8F
.WORD Talk_norm                ; 90
.WORD Talk_norm                ; 91
.WORD Talk_norm                ; 92
.WORD Talk_norm                ; 93
.WORD Talk_ifitem              ; 94
.WORD Talk_norm                ; 95
.WORD Talk_norm                ; 96
.WORD Talk_norm                ; 97
.WORD Talk_norm                ; 98
.WORD Talk_norm                ; 99
.WORD Talk_ifitem              ; 9A
.WORD Talk_ifevent             ; 9B
.WORD Talk_norm                ; 9C
.WORD Talk_norm                ; 9D
.WORD Talk_norm                ; 9E
.WORD Talk_norm                ; 9F
.WORD Talk_norm                ; A0
.WORD Talk_norm                ; A1
.WORD Talk_CubeBotBad          ; A2
.WORD Talk_norm                ; A3
.WORD Talk_norm                ; A4
.WORD Talk_norm                ; A5
.WORD Talk_norm                ; A6
.WORD Talk_norm                ; A7
.WORD Talk_norm                ; A8
.WORD Talk_ifitem              ; A9
.WORD Talk_norm                ; AA
.WORD Talk_norm                ; AB
.WORD Talk_norm                ; AC
.WORD Talk_norm                ; AD
.WORD Talk_norm                ; AE
.WORD Talk_ifevent             ; AF
.WORD Talk_norm                ; B0
.WORD Talk_norm                ; B1
.WORD Talk_norm                ; B2
.WORD Talk_norm                ; B3
.WORD Talk_norm                ; B4
.WORD Talk_norm                ; B5
.WORD Talk_norm                ; B6
.WORD Talk_norm                ; B7
.WORD Talk_norm                ; B8
.WORD Talk_norm                ; B9
.WORD Talk_norm                ; BA
.WORD Talk_Chime               ; BB
.WORD Talk_ifevent             ; BC
.WORD Talk_ifevent             ; BD
.WORD Talk_ifevent             ; BE
.WORD Talk_ifevent             ; BF
.WORD Talk_ifevent             ; C0
.WORD Talk_ifevent             ; C1
.WORD Talk_ifevent             ; C2
.WORD Talk_ifevent             ; C3
.WORD Talk_ifevent             ; C4
.WORD Talk_ifevent             ; C5
.WORD Talk_ifevent             ; C6
.WORD Talk_ifevent             ; C7
.WORD Talk_ifevent             ; C8
.WORD Talk_ifevent             ; C9
.WORD Talk_BlackOrb            ; CA
.WORD Talk_norm                ; CB
.WORD Talk_norm                ; CC
.WORD Talk_norm                ; CD
.WORD Talk_norm                ; CE
.WORD Talk_norm                ; CF


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


 ;; none (Blank sprite -- object ID=0)  [$9296 :: 0x392A6]

Talk_None:
    RTS

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

:   LDA bridge_vis          ; otherwise (princess rescued), see if bridge is visible
    BEQ :+                  ; if it is...
      LDA tmp+3             ;  ... print [3]
      RTS
                            ; otherwise (princess rescued, bridge not visible)
:   LDA tmp+2               ; print [2]
    INC bridge_vis          ; make bridge visible
    INC dlgsfx              ; play fanfare
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
    LDA ship_vis         ; see if the party has the ship
    BNE @HaveShip        ; if they do, skip ahead

      INC ship_vis            ; otherwise, give the player the ship
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
    LDA item_herb         ; check to see if the player has any herb
    BNE @HaveHerb         ; if not...
      LDA tmp+1           ; .. then simply print [1]
      RTS

  @HaveHerb:              ; prince is asleep and you have herb!
    DEC item_herb         ; take away the herb from the party
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
    LDA item_mystickey  ; check to see if the player has the key
    BEQ @GiveTheKey     ; if they already do...
      LDA tmp+2         ; .. then just print [2]
      RTS

  @GiveTheKey:          ; otherwise, we need to give them the key
    INC item_mystickey  ; give it to them
    INC dlgsfx          ; play fanfare
    LDA tmp+1           ; and print [1]
    RTS

  ;; Astos  [$9338 :: 0x39348]
  ;;  [1] if you don't have the Crown
  ;;  [2] if you do

Talk_Astos:
    LDA item_crown         ; see if the player has the crown
    BNE @HaveCrown         ; if they don't...
      LDA tmp+1            ; ... simply print [1]
      RTS

  @HaveCrown:              ; otherwise (they have the crown)
    INC item_crystal       ; give them the Crystal
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
    LDA item_tnt           ; check to see if the player has TNT
    BNE @HaveTNT           ; if not...
      LDA tmp+1            ; ... simply print [1]
      RTS

  @HaveTNT:
    DEC item_tnt           ; otherwise, remove the TNT from the party
    LDA #0                 ; kill the Canal
    STA canal_vis
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
    LDA item_adamant       ; otherwise check to see if party has the Adamant
    BNE @HaveAdamant       ; if not...
      LDA tmp+1            ; ... simply print [1]
      RTS

  @HaveAdamant:             ; otherwise, make the sword!
     LDX #WPNID_XCALBUR     ; put the XCalbur in the previously found slot
     INC inv_weapon, X      ; JIGS - tiny bit of changes here
     LDY #OBJID_SMITH       ; set Smith's event flag to mark that we made the sword
     JSR SetGameEventFlag
     DEC item_adamant       ; take the Adamant away from the party
     INC dlgsfx             ; play fanfare
     LDA tmp+2              ; and print [2]
     RTS

;  @WontFit:                 ; if XCalbur won't fit in the inventory...
;    LDA #DLGID_DONTBEGREEDY ; print "Don't be Greedy" text (note:  hardcoded)
;    RTS

  ;; Matoya (witch with the herb) [$9398 :: 0x393A8]
  ;;  [1] if prince is asleep and you don't have the crystal
  ;;  [2] if you have the crystal
  ;;  [3] if you have the herb, or if prince is awake

Talk_Matoya:
    LDA item_herb           ; see if they already have the herb
    BEQ @NoHerb             ; if not... jump ahead.  If so, do the default

  @Default:
    LDA tmp+3               ; default just prints [3]
    RTS

  @NoHerb:
    LDA item_crystal          ; see if the player has the crystal
    BNE @DoExchange           ; if they do, exchange!

     LDY #OBJID_ELFPRINCE     ; otherwise, see if the elf prince is still asleep
     JSR CheckGameEventFlag   ;  by checking his game flag
     BCS @Default             ; if he's awake, revert to default action

      LDA tmp+1               ; otherwise, elf is still asleep.  print [1]
      RTS

  @DoExchange:          ; exchanging Crystal for Herb
    INC item_herb       ; give player herb
    DEC item_crystal    ; take away crystal
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
    LDA item_slab           ; otherwise, check to see if the party has the Slab
    BNE @Teach              ; if they don't...
      LDA tmp+1             ; .. print [1]
      RTS

  @Teach:                   ; if they have the slab... teach them!
    DEC item_slab           ; take away the slab
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
    LDA item_rod            ; see if the party already has the Rod
    BNE @Default            ; if they do, skip to default

    LDY #OBJID_VAMPIRE      ; see if they killed the vampire yet (seems pointless -- can't reach Sarda
    JSR IsObjectVisible     ;   until you kill the vampire)
    BCS @Default            ; if Vampire is still alive, skip to default

    INC item_rod            ; otherwise, reward them with the Rod
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
    LDA item_tail           ; he hasn't promoted you yet... so check to see if you have the tail
    BNE @ClassChange        ; if you don't...
      LDA tmp+1             ; ... print [1]
      RTS

  @ClassChange:             ; otherwise (have tail), do the class change!
    DEC item_tail           ; remove the tail from inventory
    JSR SetGameEventFlag    ; set Bahamut's event flag
    JSR DoClassChange       ; do class change
    INC dlgsfx              ; play fanfare
    LDA tmp+2               ; and print [2]
    RTS

  ;; Generic condition check based on object visibility  [$941B :: 0x3942B]
  ;;  [1] if object ID [0] is hidden
  ;;  [2] if it's visible

Talk_ifvis:
    LDY tmp                 ; check to see if object [0] is visible
    JSR IsObjectVisible
    BCS :+                  ; if it is, print [2]
      LDA tmp+1             ; otherwise, print [1]
      RTS
:   LDA tmp+2
    RTS

  ;; Submarine Engineer (in Onrac, blocking enterance to Sea Shrine)  [$9428 :: 0x39438]
  ;;  [1] if you don't have the Oxyale
  ;;  [2] if you do

Talk_SubEng:
    LDA item_oxyale         ; see if the player has the Oxyale
    BNE :+                  ; if they don't...
      LDA tmp+1             ; ...print [1]
      RTS
:   LDY #OBJID_SUBENGINEER  ; otherwise (they do)
    JSR HideThisMapObject   ; hide the sub engineer object (this object)
    LDA tmp+2               ; and print [2]
    RTS

  ;; Waterfall Robot (gives you the cube)  [$9438 :: 0x39448]
  ;;  [1] if you don't have the Cube
  ;;  [2] if you do

Talk_CubeBot:
    LDA item_cube        ; see if the player has the cube
    BEQ :+               ; if they do...
      LDA tmp+2          ; ... print [2]
      RTS
:   INC item_cube        ; if they don't, give them the cube
    LDA tmp+1            ; print [1]
    INC dlgsfx           ; and play fanfare
    RTS

  ;; Rescued Princess (in Coneria Castle)  [$9448 :: 0x39458]
  ;;  [1] if you don't have the Lute
  ;;  [2] if you do

Talk_Princess2:
    LDA item_lute          ; see if the player has the Lute
    BEQ :+
      LDA tmp+2            ; if they do, print [2]
      RTS
:   INC item_lute          ; otherwise, give them the lute
    INC dlgsfx             ; play fanfare
    LDA tmp+1              ; and print [1]
    RTS

  ;; Fairy (trapped in the Bottle)  [$9458 :: 0x39468]
  ;;  [1] if you don't have the Oxyale
  ;;  [2] if you do

Talk_Fairy:
    LDA item_oxyale        ; see if the player has the oxyale
    BEQ :+
      LDA tmp+2            ; if they do, print [2]
      RTS
:   INC item_oxyale        ; otherwise, give them the oxyale
    INC dlgsfx             ; play fanfare
    LDA tmp+1              ; print [1]
    RTS

  ;; Titan  [$9468 :: 0x39478]
  ;;  [1] if you don't have the Ruby
  ;;  [2] if you do

Talk_Titan:
    LDA item_ruby          ; does the player have the ruby?
    BNE :+                 ; if not...
      LDA tmp+1            ; ... simply print [1]
      RTS
:   DEC item_ruby          ; if they do have it, take it away
    LDY #OBJID_TITAN       ; hide/remove Titan (this object)
    JSR HideThisMapObject
    LDA tmp+2              ; print [2]
    INC dlgsfx             ; and play fanfare
    RTS

  ;; Nameless sage who gives you the canoe  [$947D :: 0x3948D]
  ;;  [1] if you don't have the canoe and Earth Orb has been lit
  ;;  [2] if you have the canoe or if Earth Orb hasn't been lit yet

Talk_CanoeSage:
    LDA item_canoe         ; see if party has canoe
    BNE @Default          ; if they do, show default text
      LDA orb_earth       ; if they have the canoe, check to see if they've recovered the Earth Orb
      BEQ @Default        ; if not, show default
        INC item_canoe     ; otherwise, give them the canoe
        INC dlgsfx        ; play fanfare
        LDA tmp+1         ; and print [1]
        RTS
  @Default:
    LDA tmp+2             ; for default, just print [2]
    RTS

  ;; Generic eventless object  [$9492 :: 0x394A2]
  ;;  [1] always

Talk_norm:
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

Talk_CoOGuy:
    LDY tmp
    JSR HideThisMapObject ; hide object ID [0] (this object)
    LDA tmp+1             ; and print [1]
    RTS

  ;; Generic fight (Final ToFR Garland, Fiends)  [$94AA :: 0x394BA] 
  ;;  [1] always --- hide THIS object whose ID is [0], and initiate battle ID [3]

Talk_fight:
    LDY tmp
    JSR HideThisMapObject ; hide object [0] (this object)
    LDA tmp+3
    JSR TalkBattle        ; trigger battle ID [3]
    LDA tmp+1             ; and print [1]
    RTS

  ;; Unused object / waste of space  [$94B7 :: 0x394C7]
  ;;  note, though, that the label is in fact used (it is in the jump table)

Talk_Unused:
    RTS

  ;; Generic condition based on item index  [$94B8 :: 0x394C8]
  ;;  [1] if party contains at least one of item index [0]
  ;;  [2] otherwise (none of that item)

Talk_ifitem:
    LDY tmp              ; use [0] as an item index
    LDA items, Y         ; see if the player has said item
    BEQ @DontHave        ; if they do have it
      LDA tmp+1          ; print [1]
      RTS
  @DontHave:
    LDA tmp+2            ; otherwise, print [2]
    RTS

  ;; Invisible Lady  (infamous invisible lady in Coneria Castle)  [$94C5 :: 0x394D5]
  ;;  [1] if princess not rescued and you don't have the Lute
  ;;  [2] if princess rescued or you do have the Lute

Talk_Invis:
    LDY #OBJID_PRINCESS_2
    JSR IsObjectVisible  ; see if the princess has been rescued (rescued princess object visible)
    BCS :+               ; if she's not rescued...
      LDA item_lute
      BNE :+             ; ... and if you don't have the lute (redundant)
        LDA tmp+1        ; print [1]
        RTS
:   LDA tmp+2            ; otherwise print [2]
    RTS


  ;; Condition based on whether or not the bridge has been built [$94D7 :: 0x394E7]
  ;;   this condition is not used by any objects in the game, however it's still in the jump table
  ;;  [1] if bridge is built
  ;;  [2] otherwise

Talk_ifbridge:
    LDA bridge_vis       ; see if bridge is visible (has been built)
    BEQ :+               ; if it has...
      LDA tmp+1          ; print [1]
      RTS
:   LDA tmp+2            ; otherwise, print [2]
    RTS


  ;; Generic condition based on game event flag [$94E2 :: 0x394F2]
  ;;  [1] if game event flag ID [0] is clear
  ;;  [2] if it's set

Talk_ifevent:
    LDY tmp                 ; use [0] as an event flag index
    JSR CheckGameEventFlag  ;  see if that event flag has been set
    BCS :+                  ; if not...
      LDA tmp+1             ; ... print [1]
      RTS
:   LDA tmp+2               ; otherwise print [2]
    RTS

 ; Unused (truely unused -- no entry in the jump table)
    RTS

  ;; Some guard in Coneria town  [$94F0 :: 0x39500]
  ;;  [1] if princess has been saved, but bridge isn't built yet
  ;;  [2] if princess still kidnapped or bridge is built

Talk_GoBridge:
    LDY #OBJID_PRINCESS_2   ; check to see if princess has been rescued
    JSR IsObjectVisible
    BCC :+                  ; if she has...
      LDA bridge_vis        ; see if bridge has been built
      BNE :+                ; if not... (princess saved, but bridge not built yet...)
        LDA tmp+1           ;  ... print [1]
        RTS
:   LDA tmp+2               ; otherwise print [2]
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
:   LDA tmp+2           ; otherwise (not all of them lit)
    RTS                 ;  print [2]

 ;; Conditional check for canoe (some lady in Elfland)  [$9533 :: 0x39543]
 ;;  [1] if you have the canoe
 ;;  [2] if you don't

Talk_ifcanoe:
    LDA item_canoe       ; see if the player has the canoe
    BEQ @NoCanoe        ; if they do...
      LDA tmp+1         ; print [1]
      RTS
  @NoCanoe:             ; otherwise (no canoe), print [2]
    LDA tmp+2
    RTS

 ;; Conditional check for Canal (some dwarves)  [$953E :: 0x3954E]
 ;;  [1] if Canal has been opened up
 ;;  [2] if Canal is still blocked

Talk_ifcanal:
    LDA canal_vis       ; see if the canal has been blown yet
    BNE @CanalBlocked   ; if it has been opened up already
      LDA tmp+1         ;   print [1]
      RTS
  @CanalBlocked:        ; otherwise (still blocked)
    LDA tmp+2           ;   print [2]
    RTS

 ;; Conditional check for key+TNT  (some dwarf?)  [$9549 :: 0x39559]
 ;;  [1] if have key, but not TNT
 ;;  [2] if no key, or have TNT

Talk_ifkeytnt:
    LDA item_mystickey  ; check to see if the party has the key
    BEQ :+              ; if they do...
      LDA item_tnt      ; check to see if they have the TNT
      BNE :+            ; if they don't  (key but no TNT)
        LDA tmp+1       ;   print [1]
        RTS
:   LDA tmp+2           ; otherwise, print [2]
    RTS

 ;; Conditional check for Earth Orb and Vampire (people in Melmond) [$9559 :: 0x39569]
 ;;  [1] if Vampire is dead and Earth Orb not lit
 ;;  [2] if Vampire lives, or Earth Orb has been lit

Talk_ifearthvamp:
    LDY #OBJID_VAMPIRE    ; see if the vampire has been killed yet
    JSR IsObjectVisible
    BCS :+                ; if not...
      LDA orb_earth       ; check to see if player revived earth orb
      BNE :+              ; if not... (Vampire killed, Earth Orb not lit yet)
        LDA tmp+1         ; print [1]
        RTS
:   LDA tmp+2             ; otherwise print [2]
    RTS

 ;; Conditional check for airship  [$956B :: 0x3957B]
 ;;  [1] if you don't have the airship
 ;;  [2] if you do

Talk_ifairship:
    LDA airship_vis      ; see if the party has the airship
    BNE @HaveAirship     ; if they don't....
      LDA tmp+1          ; print [1]
      RTS
  @HaveAirship:
    LDA tmp+2            ; if they do, print [2]
    RTS

 ;; Conditional check for earth/fire orbs [$9576 :: 0x39586]
 ;;  [1] if Earth Orb not lit, or Fire Orb Lit
 ;;  [2] if Earth Orb lit, and Fire Obj not lit

Talk_ifearthfire:
    LDA orb_earth        ; see if the Earth Orb has been recovered
    BEQ :+               ; if it has...
      LDA orb_fire       ; check Fire Orb
      BNE :+             ; if it's still dark (Earth lit, but not Fire)
        LDA tmp+1        ; print [1]
        RTS
:   LDA tmp+2            ; otherwise, print [2]
    RTS

 ;; Unused duplicate of Cube bot (doesn't play fanfare)  [$9586 :: 0x39596]
 ;;  [1] if you don't have the Cube
 ;;  [2] if you do.

Talk_CubeBotBad:
    LDA item_cube        ; see if they have the Cube
    BEQ :+               ; if they do...
      LDA tmp+2          ;  print [2]
      RTS
:   INC item_cube        ; otherwise, give them the cube
    LDA tmp+1            ; and print [1]
    RTS                  ; but no fanfare!

 ;; Guy with the Chime (in Lefein)  [$9594 :: 0x395A4]
 ;;  [1] if you speak Lefeinish, and don't have the Chime
 ;;  [2] if you speak Lefeinish, and do have the Chime
 ;;  [3] if you don't speak Lefeinish

Talk_Chime:
    LDY #OBJID_UNNE         ; see if Unne event has happened yet (they speak Lefeinish)
    JSR CheckGameEventFlag
    BCS :+                  ; if not (they don't speak it)
      LDA tmp+3             ; ... print [3]
      RTS
:   LDA item_chime          ; otherwise, check to see if they have the Chime
    BEQ :+                  ; if they do...
      LDA tmp+2             ; ... print [2]
      RTS
:   INC item_chime          ; otherwise, give them the Chime
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


lut_MapObjTalkData:
  ;.INCBIN "bin/0E_95D5_objectdata.bin"
  
.byte $00,$00,$00,$00 ; 00 ; 
.byte $00,$01,$02,$03 ; 01 ; 
.byte $00,$04,$00,$00 ; 02 ; Garland (Temple of Fiends)
.byte $00,$05,$00,$00 ; 03 ; Kidnapped Princess
.byte $00,$08,$09,$0A ; 04 ; Bikke
.byte $00,$0B,$0C,$0D ; 05 ; 
.byte $00,$0E,$0F,$10 ; 06 ; Elf Prince
.byte $00,$11,$12,$00 ; 07 ; Astos
.byte $00,$13,$14,$00 ; 08 ; TNT Dwarf
.byte $00,$15,$16,$18 ; 09 ; Blacksmith Dwarf
.byte $00,$17,$19,$1A ; 0A ; Matoya
.byte $00,$1B,$1C,$18 ; 0B ; Unne
.byte $00,$1D,$00,$00 ; 0C ; Vampire
.byte $00,$1E,$18,$00 ; 0D ; Sarda
.byte $00,$1F,$20,$18 ; 0E ; Bahamut
.byte $13,$21,$22,$00 ; 0F ; 
.byte $00,$25,$26,$00 ; 10 ; Submarine Engineer
.byte $00,$27,$28,$00 ; 11 ; 
.byte $00,$06,$07,$00 ; 12 ; Rescued Princess
.byte $00,$23,$24,$00 ; 13 ; Fairy
.byte $00,$29,$2A,$00 ; 14 ; Titan
.byte $00,$2B,$2C,$00 ; 15 ; 
.byte $00,$FF,$00,$00 ; 16 ; Earth Plate
.byte $00,$FF,$00,$00 ; 17 ; Temple of Fiends Plate
.byte $18,$2E,$00,$19 ; 18 ; 
.byte $19,$2F,$00,$1A ; 19 ; 
.byte $1A,$30,$00,$7B ; 1A ; Chaos fight
.byte $1B,$FA,$00,$F3 ; 1B ; Earth Orb (Lich Fight)
.byte $1C,$FB,$00,$F4 ; 1C ; Fire Orb (Kary Fight) 
.byte $1D,$FC,$00,$F5 ; 1D ; Water Orb (Kraken Fight)
.byte $1E,$FD,$00,$F6 ; 1E ; Wind Orb (Tiamat Fight)
.byte $00,$00,$00,$00 ; 1F ; 
.byte $12,$31,$32,$00 ; 20 ; 
.byte $12,$31,$34,$00 ; 21 ; 
.byte $12,$33,$34,$00 ; 22 ; 
.byte $01,$35,$36,$00 ; 23 ; 
.byte $12,$33,$34,$00 ; 24 ; 
.byte $12,$37,$34,$00 ; 25 ; 
.byte $00,$38,$39,$00 ; 26 ; 
.byte $00,$3A,$34,$00 ; 27 ; 
.byte $12,$33,$34,$00 ; 28 ; 
.byte $12,$3B,$3C,$00 ; 29 ; 
.byte $12,$3D,$3E,$00 ; 2A ; 
.byte $12,$3F,$34,$00 ; 2B ; 
.byte $05,$40,$41,$00 ; 2C ; 
.byte $12,$33,$32,$00 ; 2D ; 
.byte $05,$42,$41,$00 ; 2E ; 
.byte $06,$33,$34,$00 ; 2F ; 
.byte $12,$31,$34,$00 ; 30 ; 
.byte $12,$43,$18,$00 ; 31 ; 
.byte $00,$46,$18,$00 ; 32 ; 
.byte $12,$33,$34,$00 ; 33 ; 
.byte $00,$45,$44,$00 ; 34 ; 
.byte $00,$47,$00,$00 ; 35 ; 
.byte $00,$48,$00,$00 ; 36 ; 
.byte $12,$33,$49,$00 ; 37 ; 
.byte $12,$33,$4A,$00 ; 38 ; 
.byte $00,$4B,$00,$00 ; 39 ; 
.byte $00,$4D,$4C,$00 ; 3A ; Sky Warrior 1
.byte $00,$4E,$4C,$00 ; 3B ; Sky Warrior 2
.byte $00,$4F,$4C,$00 ; 3C ; Sky Warrior 3
.byte $00,$50,$4C,$00 ; 3D ; Sky Warrior 4
.byte $00,$51,$4C,$00 ; 3E ; Sky Warrior 5
.byte $00,$52,$00,$00 ; 3F ; Scared Pravoka Townsfolk
.byte $00,$53,$00,$00 ; 40 ; Scared Pravoka Townsfolk
.byte $00,$54,$00,$00 ; 41 ; Scared Pravoka Townsfolk
.byte $04,$55,$56,$00 ; 42 ; 
.byte $04,$57,$58,$00 ; 43 ; 
.byte $06,$59,$5A,$00 ; 44 ; 
.byte $00,$5B,$00,$00 ; 45 ; 
.byte $06,$5C,$5A,$00 ; 46 ; 
.byte $04,$5E,$5D,$00 ; 47 ; 
.byte $00,$42,$00,$00 ; 48 ; 
.byte $06,$59,$5F,$00 ; 49 ; 
.byte $06,$59,$60,$00 ; 4A ; 
.byte $05,$59,$5A,$00 ; 4B ; 
.byte $06,$59,$5A,$00 ; 4C ; 
.byte $06,$61,$5A,$00 ; 4D ; 
.byte $06,$62,$5A,$00 ; 4E ; 
.byte $06,$63,$64,$00 ; 4F ; 
.byte $06,$65,$5A,$00 ; 50 ; 
.byte $06,$66,$67,$00 ; 51 ; 
.byte $00,$68,$00,$00 ; 52 ; 
.byte $11,$69,$6B,$00 ; 53 ; 
.byte $0B,$6A,$6B,$00 ; 54 ; 
.byte $06,$61,$5A,$00 ; 55 ; 
.byte $06,$61,$5A,$00 ; 56 ; 
.byte $00,$4C,$00,$00 ; 57 ; Kee Kee
.byte $00,$6C,$00,$00 ; 58 ; 
.byte $00,$6D,$6E,$00 ; 59 ; 
.byte $00,$6F,$00,$00 ; 5A ; 
.byte $00,$70,$00,$00 ; 5B ; 
.byte $03,$6F,$71,$00 ; 5C ; 
.byte $15,$73,$72,$00 ; 5D ; 
.byte $00,$74,$00,$00 ; 5E ; 
.byte $00,$75,$6E,$00 ; 5F ; 
.byte $00,$76,$77,$00 ; 60 ; 
.byte $00,$71,$00,$00 ; 61 ; 
.byte $00,$75,$6E,$00 ; 62 ; 
.byte $00,$77,$00,$00 ; 63 ; 
.byte $00,$78,$00,$00 ; 64 ; 
.byte $00,$78,$00,$00 ; 65 ; 
.byte $00,$78,$00,$00 ; 66 ; 
.byte $00,$78,$00,$00 ; 67 ; 
.byte $0C,$7A,$79,$00 ; 68 ; 
.byte $00,$7B,$00,$00 ; 69 ; 
.byte $00,$7C,$7D,$00 ; 6A ; 
.byte $15,$7F,$7E,$00 ; 6B ; 
.byte $0C,$81,$80,$00 ; 6C ; 
.byte $00,$83,$18,$00 ; 6D ; 
.byte $00,$82,$00,$00 ; 6E ; 
.byte $00,$84,$00,$00 ; 6F ; 
.byte $15,$86,$85,$00 ; 70 ; 
.byte $00,$87,$88,$00 ; 71 ; 
.byte $00,$89,$00,$00 ; 72 ; 
.byte $0E,$18,$8A,$00 ; 73 ; 
.byte $15,$86,$8B,$00 ; 74 ; 
.byte $00,$18,$00,$00 ; 75 ; 
.byte $00,$18,$00,$00 ; 76 ; 
.byte $00,$8C,$00,$00 ; 77 ; 
.byte $00,$96,$8D,$00 ; 78 ; 
.byte $00,$97,$8E,$00 ; 79 ; 
.byte $00,$98,$8F,$00 ; 7A ; 
.byte $00,$99,$90,$00 ; 7B ; 
.byte $00,$9A,$91,$00 ; 7C ; 
.byte $00,$9B,$92,$00 ; 7D ; 
.byte $00,$9C,$93,$00 ; 7E ; 
.byte $00,$9D,$94,$00 ; 7F ; 
.byte $00,$95,$9E,$00 ; 80 ; 
.byte $12,$9F,$10,$00 ; 81 ; 
.byte $00,$A0,$00,$00 ; 82 ; 
.byte $00,$A1,$00,$00 ; 83 ; 
.byte $84,$2D,$00,$00 ; 84 ; 
.byte $00,$E2,$00,$00 ; 85 ; 
.byte $00,$E3,$00,$00 ; 86 ; 
.byte $00,$E4,$00,$00 ; 87 ; 
.byte $00,$E5,$00,$00 ; 88 ; 
.byte $00,$E6,$00,$00 ; 89 ; 
.byte $00,$E7,$00,$00 ; 8A ; 
.byte $00,$E8,$00,$00 ; 8B ; 
.byte $00,$E9,$00,$00 ; 8C ; 
.byte $00,$EA,$00,$00 ; 8D ; 
.byte $00,$EB,$00,$00 ; 8E ; 
.byte $00,$EC,$00,$00 ; 8F ; 
.byte $00,$ED,$00,$00 ; 90 ; 
.byte $00,$EE,$00,$00 ; 91 ; 
.byte $00,$EF,$00,$00 ; 92 ; 
.byte $00,$AE,$00,$00 ; 93 ; 
.byte $08,$A3,$A2,$00 ; 94 ; 
.byte $00,$A4,$00,$00 ; 95 ; 
.byte $00,$A5,$00,$00 ; 96 ; 
.byte $00,$A6,$00,$00 ; 97 ; 
.byte $00,$A7,$00,$00 ; 98 ; 
.byte $00,$A8,$00,$00 ; 99 ; 
.byte $14,$AA,$A9,$00 ; 9A ; 
.byte $0E,$AB,$AC,$00 ; 9B ; 
.byte $00,$AD,$00,$00 ; 9C ; 
.byte $00,$AF,$00,$00 ; 9D ; 
.byte $00,$B0,$00,$00 ; 9E ; 
.byte $00,$B1,$00,$00 ; 9F ; 
.byte $00,$B2,$00,$00 ; A0 ; 
.byte $00,$B3,$00,$00 ; A1 ; 
.byte $00,$27,$28,$00 ; A2 ; 
.byte $00,$B4,$00,$00 ; A3 ; 
.byte $00,$B5,$00,$00 ; A4 ; 
.byte $00,$B6,$00,$00 ; A5 ; 
.byte $00,$B7,$00,$00 ; A6 ; 
.byte $00,$B8,$00,$00 ; A7 ; 
.byte $00,$B9,$00,$00 ; A8 ; 
.byte $13,$BB,$BA,$00 ; A9 ; 
.byte $00,$BC,$00,$00 ; AA ; 
.byte $00,$BD,$00,$00 ; AB ; 
.byte $00,$BE,$00,$00 ; AC ; 
.byte $00,$BF,$00,$00 ; AD ; 
.byte $00,$C0,$00,$00 ; AE ; 
.byte $0B,$C1,$FE,$00 ; AF ; 
.byte $00,$C2,$00,$00 ; B0 ; 
.byte $00,$C3,$00,$00 ; B1 ; 
.byte $00,$C4,$00,$00 ; B2 ; 
.byte $00,$C5,$00,$00 ; B3 ; 
.byte $00,$C6,$00,$00 ; B4 ; 
.byte $00,$C7,$00,$00 ; B5 ; 
.byte $00,$C8,$00,$00 ; B6 ; 
.byte $00,$C9,$00,$00 ; B7 ; 
.byte $00,$CA,$00,$00 ; B8 ; 
.byte $00,$CB,$00,$00 ; B9 ; 
.byte $00,$CC,$00,$00 ; BA ; 
.byte $00,$CD,$CE,$D0 ; BB ; 
.byte $0B,$D0,$CF,$00 ; BC ; 
.byte $0B,$D0,$D1,$00 ; BD ; 
.byte $0B,$D0,$D2,$00 ; BE ; 
.byte $0B,$D0,$D3,$00 ; BF ; 
.byte $0B,$D0,$D4,$00 ; C0 ; 
.byte $0B,$D0,$D5,$00 ; C1 ; 
.byte $0B,$D0,$D6,$00 ; C2 ; 
.byte $0B,$D0,$D7,$00 ; C3 ; 
.byte $0B,$D0,$D8,$00 ; C4 ; 
.byte $0B,$D0,$D9,$00 ; C5 ; 
.byte $0B,$D0,$DA,$00 ; C6 ; 
.byte $0B,$D0,$DB,$00 ; C7 ; 
.byte $0B,$D0,$DC,$00 ; C8 ; 
.byte $0B,$D0,$DD,$00 ; C9 ; 
.byte $00,$21,$22,$00 ; CA ; Black Orb
.byte $00,$D0,$00,$00 ; CB ; 
.byte $00,$DE,$00,$00 ; CC ; 
.byte $00,$DF,$00,$00 ; CD ; 
.byte $00,$E0,$00,$00 ; CE ; 
.byte $00,$E1,$00,$00 ; CF ; 



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  DoClassChange [$95AE :: 0x395BE]
;;
;;    Performs class change (promotion) on all party members.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


DoClassChange:
    LDA ch_class        ; simply bump up every party member's class ID number
    CLC                 ; to up them to the promoted version of their class
    ADC #6
    ADC #$60            ; JIGS - and sprite
    STA ch_class

    LDA ch_class+(1<<6)
    CLC
    ADC #6
    ADC #$60
    STA ch_class+(1<<6)

    LDA ch_class+(2<<6)
    CLC
    ADC #6
    ADC #$60
    STA ch_class+(2<<6)

    LDA ch_class+(3<<6)
    CLC
    ADC #6
    ADC #$60
    STA ch_class+(3<<6)
 
    INC dlgflg_reentermap  ; set flag to indicate map needs reentering 
    RTS                    ;   in order to reload party's mapman graphic


























.byte "END OF BANK DIALOGUE"