#NoEnv
#SingleInstance Force
EnvGet, LocalAppData, LOCALAPPDATA
CoordMode, Mouse, Screen
CoordMode, Pixel, Screen
#Include %A_ScriptDir%\AuraLists.ahk
SetWorkingDir %A_ScriptDir%
iniFilePath := A_ScriptDir "\settings.ini"
iconFilePath := A_ScriptDir "\img\icon.ico"
if (FileExist(iconFilePath)) {
    Menu, Tray, Icon, %iconFilePath%
}

res := "1080p"
maxLoopCount := 30
fishingLoopCount := 10
sellAllToggle := true
advancedFishingToggle := false
pathingMode := "Vip Pathing"
azertyPathing := false
autoUnequip := false
useNothing := false
strangeController := false
biomeRandomizer := false
autoCloseChat := false
privateServerLink := ""
webhookURL := ""
webhookID := ""
clipWebhook := false
doPing2 := false ; ping for clipwebhook
doPing3 := false ; ping if global/transcendent
autocrafting := false
useCelestial := false
useExotic := false
useBounded := false
advancedFishingThreshold := 25
autoClicker := false
IfAdded := ""
blehblehbleh := ""
kurwa := ""
strangeControllerLastRun := 0
strangeControllerInterval := 1260000
strangeControllerTime := 0
biomeRandomizerLastRun := 0
biomeRandomizerInterval := 1260000
biomeRandomizerTime := 300000
hue := 0
manualCraft := false
auraDetection := false
prevState := "None"
prevBiome := "None"
detectGlobal := false
detectTrans := false
triggerDelayGlobal := 10000
triggerDelayTrans := 20000
pendingUnequip := false
autoWarp := false
detectPotion := false
pendingCraft := false
auraFilter := false
auraFilterReady := false
detectEden := false
brainrot67 := ""
checkGhostServer := false
checkGhostServerlastRun := 0
checkGhostServerInterval := 3600000
storagewebhooksent := false
biomeDetect := false
webResponse := false
totalCraftedhp := 0
totalCraftedbp := 0
totalCraftedrp := 0
totalCrafteddp := 0
totalCrafteddip := 0
totalCraftedzp := 0
totalCraftedjp := 0
potionCraftCount := 1
fishingFailsafeRan := false
limboFish := false

if (FileExist(iniFilePath)) {
    IniRead, tempRes, %iniFilePath%, Macro, resolution
    if (tempRes != "ERROR")
    {
        res := tempRes
    }
    IniRead, tempMaxLoop, %iniFilePath%, Macro, maxLoopCount
    if (tempMaxLoop != "ERROR" && tempMaxLoop > 0)
    {
        maxLoopCount := tempMaxLoop
    }
    IniRead, tempFishingLoop, %iniFilePath%, Macro, fishingLoopCount
    if (tempFishingLoop != "ERROR" && tempFishingLoop > 0)
    {
        fishingLoopCount := tempFishingLoop
    }
    IniRead, tempSellAll, %iniFilePath%, Macro, sellAllToggle
    if (tempSellAll != "ERROR")
    {
        sellAllToggle := (tempSellAll = "true" || tempSellAll = "1")
    }
    
    IniRead, tempPathing, %iniFilePath%, Macro, pathingMode
    if (tempPathing != "ERROR")
    {
        pathingMode := tempPathing
    }
    IniRead, tempAzerty, %iniFilePath%, Macro, azertyPathing
    if (tempAzerty != "ERROR")
    {
        azertyPathing := (tempAzerty = "true" || tempAzerty = "1")
    }
    IniRead, tempPrivateServer, %iniFilePath%, Macro, privateServerLink
    if (tempPrivateServer != "ERROR")
    {
        privateServerLink := tempPrivateServer
    }
    IniRead, tempAdvancedFishing, %iniFilePath%, Macro, advancedFishingToggle
    if (tempAdvancedFishing != "ERROR")
    {
        advancedFishingToggle := (tempAdvancedFishing = "true" || tempAdvancedFishing = "1")
    }
    IniRead, tempAutoUnequip, %iniFilePath%, Macro, autoUnequip
    if (tempAutoUnequip != "ERROR")
    {
        autoUnequip := (tempAutoUnequip = "true" || tempAutoUnequip = "1")
    }
    IniRead, tempUseNothing, %iniFilePath%, Macro, useNothing
    if (tempUseNothing != "ERROR")
    {
        useNothing := (tempUseNothing = "true" || tempUseNothing = "1")
    }
    IniRead, tempWebhook, %iniFilePath%, Macro, webhookURL
    if (tempWebhook != "ERROR")
    {
        webhookURL := tempWebhook
    }
    IniRead, tempWebhookID, %iniFilePath%, Macro, webhookID
    if (tempWebhookID != "ERROR")
    {
        webhookID := tempWebhookID
    }
    IniRead, tempClipWebhook, %iniFilePath%, Macro, ClipWebhook
    if (tempClipWebhook != "ERROR") {
    StringLower, tempClipWebhook, tempClipWebhook
    clipWebhook := (tempClipWebhook = "true" || tempClipWebhook = "1")
    }
    IniRead, tempAutoCloseChat, %iniFilePath%, Macro, autoCloseChat, false
    autoCloseChat := (tempAutoCloseChat = "true" || tempAutoCloseChat = "1")

    IniRead, tempBiomeRandomizer, %iniFilePath%, Macro, biomeRandomizer
    if (tempBiomeRandomizer != "ERROR")
    biomeRandomizer := (tempBiomeRandomizer = "true" || tempBiomeRandomizer = "1")

    IniRead, tempStrangeController, %iniFilePath%, Macro, strangeController
    if (tempStrangeController != "ERROR")
    strangeController := (tempStrangeController = "true" || tempStrangeController = "1")

    IniRead, tempAzerty, %iniFilePath%, Macro, azertyPathing
    if (tempAzerty != "ERROR")
    azertyPathing := (tempAzerty = "true" || tempAzerty = "1")

    IniRead, tempDoPing2, %iniFilePath%, Macro, doPing2
    if (tempDoPing2 != "ERROR")
    doPing2 := (tempDoPing2 = "true" || tempDoPing2 = "1")

    IniRead, tempDoPing3, %iniFilePath%, Macro, doPing3
    if (tempDoPing3 != "ERROR")
    doPing3 := (tempDoPing3 = "true" || tempDoPing3 = "1")

    IniRead, tempCelestial, %iniFilePath%, Macro, useCelestial
    if (tempCelestial != "ERROR")
    useCelestial := (tempCelestial = "true" || tempCelestial = "1")

    IniRead, tempExotic, %iniFilePath%, Macro, useExotic
    if (tempExotic != "ERROR")
    useExotic := (tempExotic = "true" || tempExotic = "1")

    IniRead, tempBounded, %iniFilePath%, Macro, useBounded
    if (tempBounded != "ERROR")
    useBounded := (tempBounded = "true" || tempBounded = "1")

    IniRead, tempAutoClicker, %iniFilePath%, Macro, autoClicker
    if (tempAutoClicker != "ERROR")
    autoClicker := (tempAutoClicker = "true" || tempAutoClicker = "1")

    IniRead, tempManualCraft, %iniFilePath%, Macro, manualCraft
    if (tempManualCraft != "ERROR")
    manualCraft := (tempManualCraft = "true" || tempManualCraft = "1")

    IniRead, tempAuraDetection, %iniFilePath%, Macro, auraDetection
    if (tempAuraDetection != "ERROR")
    auraDetection := (tempAuraDetection = "true" || tempAuraDetection = "1")

    IniRead, tempDetectGlobal, %iniFilePath%, Macro, detectGlobal
    if (tempDetectGlobal != "ERROR")
    detectGlobal := (tempDetectGlobal = "true" || tempDetectGlobal = "1")

    IniRead, tempDetectTrans, %iniFilePath%, Macro, detectTrans
    if (tempDetectTrans != "ERROR")
    detectTrans := (tempDetectTrans = "true" || tempDetectTrans = "1")

    IniRead, tempAutoWarp, %iniFilePath%, Macro, autoWarp
    if (tempAutoWarp != "ERROR")
    autoWarp := (tempAutoWarp = "true" || tempAutoWarp = "1")

    IniRead, tempDetectPotion, %iniFilePath%, Macro, detectPotion
    if (tempDetectPotion != "ERROR")
    detectPotion := (tempDetectPotion = "true" || tempDetectPotion = "1")

    IniRead, tempAuraFilter, %iniFilePath%, Macro, auraFilter
    if (tempAuraFilter != "ERROR")
    auraFilter := (tempAuraFilter = "true" || tempAuraFilter = "1")

    IniRead, tempDetectEden, %iniFilePath%, Macro, detectEden
    if (tempDetectEden != "ERROR")
    detectEden := (tempDetectEden = "true" || tempDetectEden = "1")

    IniRead, tempCheckGhostServer, %iniFilePath%, Macro, checkGhostServer
    if (tempCheckGhostServer != "ERROR")
    checkGhostServer := (tempCheckGhostServer = "true" || tempCheckGhostServer = "1")

    IniRead, tempBiomeDetect, %iniFilePath%, Macro, biomeDetect
    if (tempBiomeDetect != "ERROR")
    biomeDetect := (tempBiomeDetect = "true" || tempBiomeDetect = "1")

    IniRead, tempPotionCraftCount, %iniFilePath%, Macro, potionCraftCount
    if (tempPotionCraftCount != "ERROR")
    potionCraftCount := tempPotionCraftCount
    potionCraftCount2 := potionCraftCount

    IniRead, tempLimboFish, %iniFilePath%, Macro, limboFish
    if (tempLimboFish != "ERROR")
    limboFish := (tempLimboFish = "true" || tempLimboFish = "1")

    IniRead, tempAdvancedThreshold, %iniFilePath%, Macro, advancedFishingThreshold
    if (tempAdvancedThreshold != "ERROR" && tempAdvancedThreshold >= 0 && tempAdvancedThreshold <= 40)
    {
        advancedFishingThreshold := tempAdvancedThreshold
    }
    for i, aura in AuraListOrder {
        IniRead, tempEnabled, %iniFilePath%, EnabledAuras, %aura%
        if (tempEnabled = "0")
            EnabledAuras[aura] := 0
    }
}





version := "Aery's v1.6"

devNames    := [["maxstellar","ivelchampion249","cresqnt"],["maxstellar","cresqnt","ivelchampion249"],["cresqnt","ivelchampion249","maxstellar"],["cresqnt","maxstellar","ivelchampion249"],["ivelchampion249","maxstellar","cresqnt"],["ivelchampion249","cresqnt","maxstellar"]]
devRoles    := {"maxstellar":"Lead Developer","ivelchampion249":"Original Creator","cresqnt":"Frontend Developer", "Nadir Rift":"General Programmer"}
devDiscords := {"maxstellar":"Twitch","ivelchampion249":"Youtube","cresqnt":"Scope Development (other macros)","Nadir Rift": "Twitch"}

s := (shuffle >= 1 && shuffle <= 6) ? shuffle : 6
dev1_name := devNames[s][1], dev2_name := devNames[s][2], dev3_name := devNames[s][3]
dev1_role := devRoles[dev1_name], dev2_role := devRoles[dev2_name], dev3_role := devRoles[dev3_name]
dev1_discord := devDiscords[dev1_name], dev2_discord := devDiscords[dev2_name], dev3_discord := devDiscords[dev3_name]

dev1_img :=  A_ScriptDir . "\img\yui1.png"
dev2_img :=  A_ScriptDir . "\img\yui2.png"
dev3_img :=  A_ScriptDir . "\img\yui3.png"
;dev4_img := A_ScriptDir . "\img\yui4.png"

Gui, Color, 041024
Gui, Font, s15 cWhite Bold, Segoe UI
Gui, Add, Text, x0 y8 w600 h45 Center BackgroundTrans c0xFFAA00, Aery's fishSol v1.6
Gui, Font, s10 cWhite Bold, Segoe UI
Gui, Add, Text, x160 y35 w290 h20 Center BackgroundTrans c0xFFAA00, (Only Works In 1080p and Needs VIP)

Gui, Font, s9 cWhite Bold, Segoe UI

tabList := "Main"
tabList .= "|Misc"
tabList .= "|Auras"
tabList .= "|Crafting"
tabList .= "|Private Server"
tabList .= "|Webhook"
tabList .= "|About"
tabList .= "|Extra"

Gui, Add, Tab3, x15 y55 w570 h500 vMainTabs gTabChange c0xFFFFFF, %tabList%

Gui, Tab, Main

Gui, Font, s10 cWhite Bold, Segoe UI
Gui, Add, GroupBox, x30 y85 w260 h120 cWhite, Control Panel
Gui, Font, s11 cWhite Bold
Gui, Add, Text, x45 y110 w60 h25 BackgroundTrans, Status:
Gui, Add, Text, x98 y110 w150 h25 vStatusText BackgroundTrans c0xFF4444, Stopped

Gui, Font, s10 cWhite Bold, Segoe UI
Gui, Add, Button, x45 y140 w70 h35 gStartScript vStartBtn c0x00AA00 +0x8000, Start
Gui, Add, Button, x125 y140 w70 h35 gPauseScript vPauseBtn c0xFFAA00 +0x8000, Pause
Gui, Add, Button, x205 y140 w70 h35 gCloseScript vStopBtn c0xFF4444 +0x8000, Stop
Gui, Add, Text, x45 y180 w80 h25 BackgroundTrans, Resolution:
Gui, Font, s11 cWhite Bold
Gui, Add, Text, x120 y178 w80 h25 BackgroundTrans, 1080p


Gui, Add, GroupBox, x305 y85 w260 h120 cWhite, Limbo Fish

Gui, Add, GroupBox, x30 y215 w535 h120 cWhite, Loop Count Settings
Gui, Font, s10 cWhite Bold
Gui, Add, Text, x45 y240 w180 h25 BackgroundTrans, Fishing Loop Count:
Gui, Add, Edit, x220 y238 w60 h25 vMaxLoopInput gUpdateLoopCount Number Background0xD3D3D3 cBlack, %maxLoopCount%
Gui, Font, s8 c0xCCCCCC
Gui, Add, Text, x285 y242 w270 h15 BackgroundTrans, (How many times to fish before selling. Default: 30)
Gui, Font, s10 cWhite Bold
Gui, Add, Text, x45 y270 w180 h25 BackgroundTrans, Sell Loop Count:
Gui, Add, Edit, x220 y268 w60 h25 vFishingLoopInput gUpdateLoopCount Number Background0xD3D3D3 cBlack, %fishingLoopCount%
Gui, Font, s8 c0xCCCCCC
Gui, Add, Text, x285 y272 w270 h15 BackgroundTrans, (There's is 56 Fish in the game. Default: 10)   

Gui, Font, s10 cWhite Bold
Gui, Add, Text, x45 y301 w120 h25 BackgroundTrans, Pathing Mode:
Gui, Font, s14 cWhite Bold
Gui, Add, Text, x145 y296 w135 h25 BackgroundTrans, VIP Pathing

Gui, Font, s10 cWhite Bold
Gui, Add, Text, x295 y301 w120 h25 BackgroundTrans, AZERTY Pathing:
Gui, Add, Button, x415 y298 w80 h25 gToggleAzertyPathing vAzertyPathingBtn, Toggle
Gui, Font, s10 c0xCCCCCC Bold, Segoe UI
Gui, Add, Text, x510 y303 w60 h25 vAzertyPathingStatus BackgroundTrans, OFF


Gui, Font, s11 cWhite Bold
Gui, Add, GroupBox, x250 y343 w315 h197, Advanced Fishing Detection
Gui, Font, s10 cWhite Bold
Gui, Add, Button, x270 y380 w80 h25 gToggleAdvancedFishingDetection vAdvancedFishingDetectionBtn, Toggle
Gui, Font, s10 c0xCCCCCC Bold, Segoe UI
Gui, Add, Text, x360 y384 w60 h25 vAdvancedFishingDetectionStatus BackgroundTrans, OFF
Gui, Font, s10 cWhite Bold
Gui, Add, Text, x400 y384 w80 h25 BackgroundTrans, Pixels:
Gui, Add, Edit, x455 y380 w75 h25 vAdvancedThresholdInput gUpdateAdvancedThreshold Number Background0xD3D3D3 cBlack, %advancedFishingThreshold%
Gui, Font, s9 cWhite Bold
Gui, Add, Text, x270 y415 w260 cWhite BackgroundTrans, Advanced Detection Threshold -
Gui, Font, s9 cWhite Normal
Gui, Add, Text, x270 y435 w270 h40 BackgroundTrans c0xCCCCCC, Customize how many pixels are left in the fishing range before clicking.
Gui, Font, s9 cWhite Bold
Gui, Add, Text, x453 y416 w120 BackgroundTrans c0xFF4444, Max : 40 Pixels
Gui, Font, s9 c0xCCCCCC Normal
Gui, Add, Text, x270 y470 w285 h30 BackgroundTrans, Advanced Fishing Detection uses a system that clicks slightly before the bar exits the fish range, making the catch rate higher than ever.
Gui, Font, s9 c0x00D4FF Bold
Gui, Add, Text, x297 y503 w515 h30 BackgroundTrans c0x00D4FF, [ Recommended For Lower End Devices ]

Gui, Font, s10 c0xCCCCCC Bold
Gui, Add, Text, x30 y355 w205 h95 BackgroundTrans, Roblox MUST be in fullscreen mode
Gui, Font, s8 c0xCCCCCC
Gui, Add, Text, x30 y400 w5000 h15 BackgroundTrans, Hotkeys:
Gui, Add, Text, x30 y415 w5000 h15 BackgroundTrans, F1=Start Macro - F2=Start AutoCraft  
Gui, Add, Text, x30 y430 w5000 h15 BackgroundTrans, F3=Stop Macro/AutoCraft
Gui, Add, Text, x30 y445 w500 h20 BackgroundTrans, F4=Stop Webhook or Clip
Gui, Add, Text, x30 y460 w500 h20 BackgroundTrans, F6=Join Private Server Link

Gui, Tab, Misc

Gui, Font, s11 cWhite Bold
Gui, Add, GroupBox, x22 y90 w270 h195 cWhite, Auto-Unequip
Gui, Font, s9 cWhite Normal
Gui, Add, Text, x35 y110 h45 w250 BackgroundTrans c0xCCCCCC, Automatically unequip rolled auras when an aura is equipped. Prevents lag and possible macro issues.
Gui, Add, Text, x35 y210 h45 w250 BackgroundTrans c0xCCCCCC, Equips "Nothing" instead of equipping and unequipping your first aura in your storage.
Gui, Font, s10 cWhite Bold, Segoe UI
Gui, Add, Text, x32 y190 h45 w240 BackgroundTrans, Use "Nothing" Aura.
Gui, Font, s10 cWhite Bold
Gui, Add, Button, x35 y160 w80 h25 gToggleAutoUnequip vAutoUnequipBtn, Toggle
Gui, Add, Button, x35 y245 w80 h25 gToggleUseNothing vUseNothingBtn, Toggle
Gui, Font, s10 c0xCCCCCC Bold, Segoe UI
Gui, Add, Text, x130 y163 w60 h25 vAutoUnequipStatus BackgroundTrans, OFF
Gui, Add, Text, x130 y248 w60 h25 vUseNothingStatus BackgroundTrans, OFF

Gui, Font, s11 cWhite Bold
Gui, Add, GroupBox, x307 y90 w270 h100 cWhite, Auto-Close Chat
Gui, Font, s9 cWhite Normal
Gui, Add, Text, x317 y110 h45 w255 BackgroundTrans c0xCCCCCC, Automatically detects if chat is open and if so, closes it to prevent getting stuck in collection.
Gui, Font, s10 cWhite Bold
Gui, Add, Button, x320 y150 w80 h25 gToggleAutoCloseChat vAutoCloseChatBtn, Toggle
Gui, Font, s10 c0xCCCCCC Bold, Segoe UI
Gui, Add, Text, x415 y153 w60 h25 vAutoCloseChatStatus BackgroundTrans, OFF

Gui, Font, s11 cWhite Bold
Gui, Add, GroupBox, x22 y291 w270 h155 cWhite, Biome/Strange Controller:
Gui, Font, s9 c0xCCCCCC Normal
Gui, Add, Text, x37 y313 w255 h50 BackgroundTrans, Uses Biome Randomizer and/or Strange Controller after their cooldowns. Biome Randomizer is used 5 minutes after macro start.

Gui, Font, s10 cWhite Bold, Segoe UI
Gui, Add, Text, x30 y370 w120 h25 BackgroundTrans, Strange Controller:
Gui, Add, Button, x157 y370 w80 h25 gToggleStrangeController vStrangeControllerBtn, Toggle
Gui, Font, s10 c0xCCCCCC Bold, Segoe UI
Gui, Add, Text, x257 y375 w60 h25 vStrangeControllerStatus BackgroundTrans, OFF

Gui, Font, s10 cWhite Bold, Segoe UI
Gui, Add, Text, x30 y410 w125 h25 BackgroundTrans, Biome Randomizer:
Gui, Add, Button, x157 y410 w80 h25 gToggleBiomeRandomizer vBiomeRandomizerBtn, Toggle
Gui, Font, s10 c0xCCCCCC Bold, Segoe UI
Gui, Add, Text, x257 y413 w60 h25 vBiomeRandomizerStatus BackgroundTrans, OFF

Gui, Font, s11 cWhite Bold
Gui, Add, GroupBox, x307 y200 w270 h155 cWhite, Auto Use Skips in Cyberspace
Gui, Font, s9 cWhite Normal
Gui, Add, Text, x317 y222 h45 w255 BackgroundTrans c0xCCCCCC, (During Macro) Automatically detects if you are in Cyberspace and uses a Transcendent Potion or Warp Potion.
Gui, Font, s10 cWhite Bold
Gui, Add, Button, x320 y280 w80 h25 gToggleAutoWarp vAutoWarpBtn, Toggle
Gui, Font, s10 cWhite Bold
Gui, Add, Text, x320 y321 w148 h155 BackGroundTrans, Potion Type:
Gui, Font, s10 c0xCCCCCC Bold, Segoe UI
Gui, Add, Text, x415 y283 w60 h25 vAutoWarpStatus BackgroundTrans, OFF
Gui, Add, DropDownList, x410 y317 w148 vSkipPotionType gskipType, Warp Potion|Transcendent Potion
IniRead, skipType, %iniFilePath%, Macro, skipType
GuiControl, Choose, SkipPotionType, %skipType%
Gui, Tab, Auras

Gui, Font, s13 cWhite Bold, Segoe UI
Gui, Add, Button, x100 y500 w170 h35 gOpenNvidiaNotes, Clipping Tutorial
Gui, Add, Button, x310 y500 w150 h35 gOpenAuraFilter, Aura Filter

Gui, Font, s11 cWhite Bold
Gui, Add, GroupBox, x33 y125 w240 h141 cWhite, Aura Detection (Beta)
Gui, Font, s9 c0xCCCCCC Normal
Gui, Add, Text, x45 y145 w225 h131 BackgroundTrans c0xCCCCCC, Detects the most recent aura equipped. If a global is equipped, you can get pinged by turning on Ping if Global/Transcendent in Webhook. (Also needed for Auto Unequp.)
Gui, Font, s10 cWhite Bold, Segoe UI
Gui, Add, Button, x45 y222 w80 h25 gToggleAuraDetection vAuraDetectionBtn, Toggle
Gui, Font, s10 c0xCCCCCC Bold, Segoe UI
Gui, Add, Text, x143 y227 w60 h25 vAuraDetectionStatus BackgroundTrans, OFF

Gui, Font, s11 cWhite Bold
Gui, Add, GroupBox, x293 y125 w270 h141 cWhite, Toggle Aura Filter
Gui, Font, s9 c0xCCCCCC Normal
Gui, Add, Text, x305 y145 w255 h131 BackgroundTrans c0xCCCCCC, Enables Aura Filter. With Aura Filter enabled, only the globals that are toggled in the Aura Filter will be sent a webhook/clip for. Transcendents are not affected by the Aura Filter.
Gui, Font, s10 cWhite Bold, Segoe UI
Gui, Add, Button, x305 y222 w80 h25 gToggleAuraFilter vAuraFilterBtn, Toggle
Gui, Font, s10 c0xCCCCCC Bold, Segoe UI
Gui, Add, Text, x403 y227 w60 h25 vAuraFilterStatus BackgroundTrans, OFF

Gui, Font, s14 cWhite Bold, Segoe UI
Gui, Add, Text, x33 y93 w400 h75 BackgroundTrans, [ Aura Detection ]
Gui, Font, s11 cWhite Bold, Segoe UI
Gui, Add, Text, x365 y93 w515 h135 BackgroundTrans,Clip Type:
Gui, Font, s10 c0xCCCCCC Bold, Segoe UI
Gui, Add, DropDownList, x440 y93 w128 vClipVersion gclipType, Nvidia: Alt + F10|Medal: F8
IniRead, clipType, %iniFilePath%, Macro, clipType
GuiControl, Choose, ClipVersion, %clipType%

Gui, Font, s11 cWhite Bold, Segoe UI
Gui, Add, GroupBox, x33 y280 w534 h100 cWhite, Clip Globals
Gui, Font, s10 c0xCCCCCC Normal
Gui, Add, Text, x45 y300 w515 h135 BackgroundTrans, Automatically clips with Nvidia's Instant Replay or Medal when detecting a Global has been equipped. (Works for Biome Native Globals and Limbo Globals)
Gui, Font, s10 cWhite Bold, Segoe UI
Gui, Add, Button, x45 y339 w80 h25 gToggleDetectGlobal vDetectGlobalBtn, Toggle
Gui, Font, s10 c0xCCCCCC Bold, Segoe UI
Gui, Add, Text, x143 y341 w70 h25 vDetectGlobalStatus BackgroundTrans, OFF

Gui, Font, s11 cWhite Bold
Gui, Add, GroupBox, x33 y385 w534 h100 cWhite, Clip Transcendents
Gui, Font, s10 c0xCCCCCC Normal
Gui, Add, Text, x45 y405 w515 h145 BackgroundTrans, Automatically clips with Nvidia's Instant Replay or Medal when detecting a Transcendent's has been equipped. Also gives a special webhook!
Gui, Font, s10 cWhite Bold, Segoe UI
Gui, Add, Button, x45 y445 w80 h25 gToggleDetectTrans vDetectTransBtn, Toggle
Gui, Font, s10 c0xCCCCCC Bold, Segoe UI
Gui, Add, Text, x143 y448 w70 h25 vDetectTransStatus BackgroundTrans, OFF



Gui, Tab, Webhook

Gui, Font, s10 cWhite Normal Bold
Gui, Add, Text, x50 y125 w200 h25 BackgroundTrans, Discord Webhook URL:
Gui, Add, Edit, x50 y150 w500 h25 vWebhookInput gUpdateWebhook Background0xD3D3D3 cBlack, %webhookURL%
Gui, Font, s8 c0xCCCCCC Normal
Gui, Add, Text, x50 y180 w500 h15 BackgroundTrans, Paste your Discord webhook URL here to be notified of actions happening in real time.
Gui, Font, s10 cWhite Normal Bold
Gui, Add, Text, x50 y205 w200 h25 BackgroundTrans, Discord USERID:
Gui, Add, Edit, x50 y230 w500 h25 vUserIDInput gUpdateUserID Background0xD3D3D3 cBlack, %webhookID%
Gui, Font, s8 c0xCCCCCC Normal
Gui, Add, Text, x50 y260 w500 h15 BackgroundTrans, Paste your Discord USERID here to be pinged of actions happening in real time.

Gui, Font, s11 cWhite Bold
Gui, Add, GroupBox, x33 y315 w534 h65 cWhite, Macro Clip Message
Gui, Add, Button, x60 y340 w80 h25 gToggleClipWebhook vClipWebhookBtn, Toggle
Gui, Add, Button, x320 y340 w80 h25 gToggleDoPing2 vDoPing2Btn, Toggle
Gui, Font, s10 cWhite Normal
Gui, Add, Text, x250 y344 w100 h25 BackgroundTrans c0xCCCCCC, Ping User: 
Gui, Font, s7 cWhite Normal
Gui, Add, Text, x465 y326 w80 h100 BackgroundTrans c0xCCCCCC, Messages and/or pings if anything has been clipped via Webhook.
Gui, Font, s10 c0xCCCCCC Bold   
Gui, Add, Text, x410 y344 w60 h25 vDoPing2Status BackgroundTrans, OFF
Gui, Add, Text, x150 y344 w60 h25 vClipWebhookStatus BackgroundTrans, OFF

Gui, Font, s11 cWhite Bold
Gui, Add, GroupBox, x33 y385 w534 h65 cWhite, Aura Detection Ping
Gui, Add, Button, x320 y410 w80 h25 gToggleDoPing3 vDoPing3Btn, Toggle
Gui, Font, s10 cWhite Normal
Gui, Add, Text, x50 y414 w300 h25 BackgroundTrans c0xCCCCCC, Ping User if global/transcendent detected: 
Gui, Font, s10 c0xCCCCCC Bold
Gui, Add, Text, x410 y414 w60 h25 vDoPing3Status BackgroundTrans, OFF

Gui, Tab, Crafting

Gui, Font, s10 cWhite Bold
Gui, Add, GroupBox, x22 y85 w554 h130 cWhite, Auto Craft
Gui, Add, GroupBox, x22 y225 w554 h200 cWhite, Manual Craft
Gui, Add, GroupBox, x130 y445 w210 h100 cWhite, Heavenly Potion
Gui, Add, GroupBox, x347 y445 w130 h100 cWhite, Bound Potion 
Gui, Add, Text, x60 y167 w150 h50 BackgroundTrans, F2 = Start | F3 = Stop

Gui, Font, s10 cWhite Bold
Gui, Add, Button, x218 y465 w80 h25 gToggleUseCelestial vUseCelestialBtn, Toggle
Gui, Add, Button, x218 y505 w80 h25 gToggleUseExotic vUseExoticBtn, Toggle
Gui, Add, Text, x308 y469 w60 h25 vUseCelestialStatus BackgroundTrans, OFF
Gui, Add, Text, x308 y509 w60 h25 vUseExoticStatus BackgroundTrans, OFF
Gui, Font, s9 cWhite Normal
Gui, Add, Text, x138 y469 w600 h100 BackgroundTrans c0xCCCCCC, Add 
Gui, Add, Text, x138 y509 w600 h100 BackgroundTrans c0xCCCCCC, Add
Gui, Font, s9 c9B8CFF Bold, Trajan Pro
Gui, Add, Text, x164 y469 w600 h100 BackgroundTrans, Celestial:
Gui, Font, s10 cWhite Normal, Trajan Pro
Gui, Add, Text, vExoticText x164 y507 w600 h100 BackgroundTrans, Exotic:
SetTimer, RainbowText, 50


Gui, Font, s10 cWhite Bold
Gui, Add, Button, x358 y505 w80 h25 gToggleUseBounded vUseBoundedBtn, Toggle
Gui, Add, Text, x446 y509 w60 h25 vUseBoundedStatus BackgroundTrans, OFF
Gui, Font, s9 cWhite Normal
Gui, Add, Text, x358 y469 w600 h100 BackgroundTrans c0xCCCCCC, Add
Gui, Font, s9 c1559C9 Bold, Trajan Pro
Gui, Add, Text, x385 y469 w600 h100 BackgroundTrans, Bounded:


Gui, Font, s9 cWhite Normal
Gui, Add, Text, x35 y105 w534 h100 BackgroundTrans c0xCCCCCC, Adds the nessecary potions and/or auras to craft potions. Please already put the desired item on auto craft. You MUST be inside of Stella's Cauldron's UI. Toggling the auras listed below means adding them to the desired potion from your inventory and turns on Add Everything.
Gui, Font, s10 c0xCCCCCC Bold, Segoe UI
Gui, Add, DropDownList, x245 y165 w120 vAutoCraft gSelectItem, Heavenly Potion|Bound Potion|Jewelry Potion|Zombie Potion|Rage Potion|Diver Potion
IniRead, selectedItem, %iniFilePath%, Macro, selectedItem
GuiControl, Choose, AutoCraft, %selectedItem%

Gui, Font, s9 cWhite Normal
Gui, Add, Text, x35 y245 w534 h100 BackgroundTrans c0xCCCCCC, (During Macro) Goes to Stella's cauldron and crafts the desired item before going to the fish sell shop. Please have the desired on auto craft. Toggling the auras listed below means adding them to the desired potion from your inventory and turns on Add Everything.
Gui, Font, s10 c0xCCCCCC Bold, Segoe UI
Gui, Add, DropDownList, x195 y305 w120 vManualCraft gSelectItem2, Heavenly Potion|Bound Potion|Jewelry Potion|Zombie Potion|Rage Potion|Diver Potion
IniRead, selectedItem2, %iniFilePath%, Macro, selectedItem2
GuiControl, Choose, ManualCraft, %selectedItem2%
Gui, Font, s10 cWhite Bold
Gui, Add, Edit, x450 y305 w70 h25 vPotionCraftInput gUpdatePotionCraft Number Background0xD3D3D3 cBlack, %potionCraftCount%
Gui, Add, Text, x335 y310 w534 h100 BackgroundTrans, Amount to Craft:

Gui, Font, s10 cWhite Bold
Gui, Add, Text, x35 y333 w534 h100 BackgroundTrans, Detect Ready Notification
Gui, Font, s10 c0xCCCCCC Bold, Segoe UI
Gui, Font, s10 cWhite Bold, Segoe UI
Gui, Add, Button, x55 y385 w80 h25 gToggleDetectPotion vDetectPotionBtn, Toggle
Gui, Font, s10 cWhite Bold
Gui, Add, Text, x153 y388 w70 h25 vDetectPotionStatus BackgroundTrans, OFF
Gui, Font, s9 cWhite Normal
Gui, Add, Text, x35 y350 w534 h100 BackgroundTrans c0xCCCCCC, (During Macro) Detects if your potion is ready to be crafted with ready notification, and if so, stops fishing to craft it. Only recommended for Heavenly/Bound Potion.

Gui, Font, s10 cWhite Bold, Segoe UI
Gui, Add, Button, x55 y305 w80 h25 gToggleManualCraft vManualCraftBtn, Toggle
Gui, Font, s10 cWhite Bold
Gui, Add, Text, x153 y308 w70 h25 vManualCraftStatus BackgroundTrans, OFF

Gui, Tab, Private Server
Gui, Add, Text, x35 y90 w150 h25 BackgroundTrans, Private Server Link:
Gui, Add, Edit, x35 y115 w515 h25 vPrivateServerInput gUpdatePrivateServer Background0xD3D3D3 cBlack, %privateServerLink%

Gui, Font, s11 cWhite Bold
Gui, Add, GroupBox, x33 y185 w534 h100 cWhite, Check For Ghost Server
Gui, Font, s10 c0xCCCCCC Normal
Gui, Add, Text, x45 y205 w500 h145 BackgroundTrans, (During Macro) Checks for Ghost Server at the start of script, then hourly by seeing if you have access to Command Panel. If detected joins the server in private server link.
Gui, Font, s10 cWhite Bold, Segoe UI
Gui, Add, Button, x45 y245 w80 h25 gToggleCheckGhostServer vCheckGhostServerBtn, Toggle
Gui, Font, s10 c0xCCCCCC Bold, Segoe UI
Gui, Add, Text, x143 y248 w70 h25 vCheckGhostServerStatus BackgroundTrans, OFF

Gui, Font, s11 cWhite Bold
Gui, Add, GroupBox, x33 y290 w534 h100 cWhite, Biome Detection
Gui, Font, s10 c0xCCCCCC Normal
Gui, Add, Text, x45 y310 w500 h145 BackgroundTrans, (During Macro) Sends a webhook on current biome, mentions everyone when a Glitch, Dreamspace, or Cyberspace is detected. Only detects when you are macroing.
Gui, Font, s10 cWhite Bold, Segoe UI
Gui, Add, Button, x45 y355 w80 h25 gToggleBiomeDetect vBiomeDetectBtn, Toggle
Gui, Font, s10 c0xCCCCCC Bold, Segoe UI
Gui, Add, Text, x143 y358 w70 h25 vBiomeDetectStatus BackgroundTrans, OFF


Gui, Tab, About

Gui, Font, s14 cWhite Bold, Segoe UI
Gui, Add, Text, x30 y90 w535 h30 Center BackgroundTrans c0xFFAA00, Original fishSol Creators

Gui, Add, Picture, x50 y130 w50 h50, %dev1_img%
Gui, Font, s11 cWhite Bold
if (dev1_name = "cresqnt") {
    Gui, Add, Text, x110 y135 w200 h20 BackgroundTrans c0x0088FF gDev1NameClick, %dev1_name%
} else {
    Gui, Add, Text, x110 y135 w200 h20 BackgroundTrans c0x00DD00, %dev1_name%
}
Gui, Font, s9 c0xCCCCCC Normal
Gui, Add, Text, x110 y155 w300 h15 BackgroundTrans, %dev1_role%
Gui, Add, Text, x110 y170 w300 h15 BackgroundTrans c0x0088FF gDev1LinkClick, %dev1_discord%

Gui, Add, Picture, x50 y195 w50 h50, %dev2_img%
Gui, Font, s11 cWhite Bold
if (dev2_name = "cresqnt") {
    Gui, Add, Text, x110 y200 w200 h20 BackgroundTrans c0x0088FF gDev2NameClick, %dev2_name%
} else {
    Gui, Add, Text, x110 y200 w200 h20 BackgroundTrans c0x00DD00, %dev2_name%
}
Gui, Font, s9 c0xCCCCCC Normal
Gui, Add, Text, x110 y220 w300 h15 BackgroundTrans, %dev2_role%
Gui, Add, Text, x110 y235 w300 h15 BackgroundTrans c0x0088FF gDev2LinkClick, %dev2_discord%

Gui, Add, Picture, x50 y260 w50 h50, %dev3_img%
Gui, Font, s11 cWhite Bold
if (dev3_name = "cresqnt") {
    Gui, Add, Text, x110 y265 w200 h20 BackgroundTrans c0x0088FF gDev3NameClick, %dev3_name%
} else {
    Gui, Add, Text, x110 y265 w200 h20 BackgroundTrans c0x00DD00, %dev3_name%
}
Gui, Font, s9 c0xCCCCCC Normal
Gui, Add, Text, x110 y285 w300 h15 BackgroundTrans, %dev3_role%
Gui, Add, Text, x110 y300 w300 h15 BackgroundTrans c0x0088FF gDev3LinkClick, %dev3_discord%

Gui, Font, s9 c0xCCCCCC Normal

Gui, Font, s8 c0x888888
Gui, Add, Text, x50 y325 w480 h1 0x10 BackgroundTrans

url := "https://raw.githubusercontent.com/ivelchampion249/FishSol-Macro/refs/heads/main/DONATORS.txt"

Http := ComObjCreate("WinHttp.WinHttpRequest.5.1")
Http.Open("GET", url, false)
Http.Send()

content := Http.ResponseText

Gui, Font, s10 cWhite Bold
Gui, Add, Text, x50 y345 w2000 h20 BackgroundTrans, Hope you enjoy my fishSol! Donators of Original fishSol:
Gui, Font, s9 c0xCCCCCC Normal
Gui, Add, Edit, x50 y370 w480 h95 vDonatorsList -Wrap +ReadOnly +VScroll -WantReturn -E0x200 Background0x2D2D2D c0xCCCCCC, %content%

Gui, Font, s8 c0x888888
Gui, Add, Text, x50 y490 w480 h1 0x10 BackgroundTrans

Gui, Font, s8 c0xCCCCCC Normal
Gui, Add, Text, x50 y500 w500 h15 BackgroundTrans, Aery's fishSol v1.6 (2026-05-03)
Gui, Add, Text, x300 y500 w500 h15 BackgroundTrans, If you need help, message me on discord. (noaery)
Gui, Add, Text, x50 y525 w500 h15 BackgroundTrans c0x0088FF gReleasesClick +0x200, https://github.com/knowaery/Aery-s-Fishsol

Gui, Tab, Extra

Gui, Font, s11 cWhite Bold
Gui, Add, GroupBox, x33 y270 w534 h120 cWhite, Detect and Contract Eden (Temporary)
Gui, Font, s8 c0xCCCCCC Normal
Gui, Add, Text, x45 y363 w520 h145 BackgroundTrans, Not tested, not much thought into it, sorry if it dont work
Gui, Font, s10 c0xCCCCCC Normal
Gui, Add, Text, x45 y290 w520 h145 BackgroundTrans, Automatically detects if Eden has spawned in and contracts with it. (Uses Check Pixels so it may not be fully accurate, but should work in most cases)
Gui, Font, s10 cWhite Bold
Gui, Add, Text, x230 y330 w400 h135 BackgroundTrans, ! This automatically starts when toggle is ON !
Gui, Font, s10 cWhite Bold, Segoe UI
Gui, Add, Button, x45 y330 w80 h25 gToggleDetectEden vDetectEdenBtn, Toggle
Gui, Font, s10 c0xCCCCCC Bold, Segoe UI
Gui, Add, Text, x143 y333 w60 h25 vDetectEdenStatus BackgroundTrans, OFF

Gui, Font, s11 cWhite Bold
Gui, Add, GroupBox, x33 y90 w270 h135 cWhite, Auto-Clicker
Gui, Add, Button, x46 y185 w80 h25 gStartAutoClicker vAutoClickStart, Start
Gui, Add, Button, x136 y185 w80 h25 gStopAutoClicker  vAutoClickStop Disabled, Stop
Gui, Font, s10 c0xCCCCCC Bold, Segoe UI
Gui, Add, Text, x226 y189 w60 h25 vAutoClickerStatus BackgroundTrans, OFF
Gui, Font, s10 cWhite Bold
Gui, Add, Text, x46 y160 w90 h20 BackgroundTrans, Delay (sec):
Gui, Font, s9 cBlack Bold
Gui, Add, Edit, x131 y160 w60 h22 vAutoClickDelay, 60
Gui, Font, s9 c0xCCCCCC Normal
Gui, Add, Text, x43 y110 w255 h135 BackgroundTrans c0xCCCCCC, Automatically clicks after the desired seconds to prevent disconnection.

Gui, Show, w600 h570,  Aery's fishSol v1.6

GuiControl, Choose, Resolution, 1

if (sellAllToggle) {
    GuiControl,, SellAllStatus, ON
    GuiControl, +c0x00DD00, SellAllStatus
} else {
    GuiControl,, SellAllStatus, OFF
    GuiControl, +c0xFF4444, SellAllStatus
}

if (advancedFishingDetection) {
    GuiControl,, AdvancedFishingDetectionStatus, ON
    GuiControl, +c0x00DD00, AdvancedFishingDetectionStatus
} else {
    GuiControl,, AdvancedFishingDetectionStatus, OFF
    GuiControl, +c0xFF4444, AdvancedFishingDetectionStatus
}

if (pathingMode = "Vip Pathing") {
    GuiControl, Choose, PathingMode, 1
} else if (pathingMode = "Non Vip Pathing") {
    GuiControl, Choose, PathingMode, 2
} else if (pathingMode = "Abyssal Pathing") {
    GuiControl, Choose, PathingMode, 3
} else {
    GuiControl, Choose, PathingMode, 1
    pathingMode := "Vip Pathing"
}

if (azertyPathing) {
    GuiControl,, AzertyPathingStatus, ON
    GuiControl, +c0x00DD00, AzertyPathingStatus
} else {
    GuiControl,, AzertyPathingStatus, OFF
    GuiControl, +c0xFF4444, AzertyPathingStatus
}
if (autoUnequip) {
    GuiControl,, AutoUnequipStatus, ON
    GuiControl, +c0x00DD00, AutoUnequipStatus
    if (!auraDetection) {
        TrayTip, Please turn on Aura Detection!, Auras Tab -> Aura Detection
        GuiControl,, AutoUnequipStatus, OFF
        GuiControl, +c0xFF4444, AutoUnequipStatus
        autoUnequip := false
    }
} else {
    GuiControl,, AutoUnequipStatus, OFF
    GuiControl, +c0xFF4444, AutoUnequipStatus
}
if (useNothing) {
    GuiControl,, UseNothingStatus, ON
    GuiControl, +c0x00DD00, UseNothingStatus
} else {
    GuiControl,, UseNothingStatus, OFF
    GuiControl, +c0xFF4444, UseNothingStatus
}
if (autoCloseChat) {
    GuiControl,, AutoCloseChatStatus, ON
    GuiControl, +c0x00DD00, AutoCloseChatStatus
} else {
    GuiControl,, AutoCloseChatStatus, OFF
    GuiControl, +c0xFF4444, AutoCloseChatStatus
}
if (biomeRandomizer) {
    GuiControl,, BiomeRandomizerStatus, ON
    GuiControl, +c0x00DD00, BiomeRandomizerStatus
} else {
    GuiControl,, BiomeRandomizerStatus, OFF
    GuiControl, +c0xFF4444, BiomeRandomizerStatus
}
if (strangeController) {
    GuiControl,, StrangeControllerStatus, ON
    GuiControl, +c0x00DD00, StrangeControllerStatus
} else {
    GuiControl,, StrangeControllerStatus, OFF
    GuiControl, +c0xFF4444, StrangeControllerStatus
}
if (clipWebhook) {
    GuiControl,, ClipWebhookStatus, ON
    GuiControl, +c0x00DD00, ClipWebhookStatus
} else {
    GuiControl,, ClipWebhookStatus, OFF
    GuiControl, +c0xFF4444, ClipWebhookStatus
}
if (doPing2) {
    GuiControl,, DoPing2Status, ON
    GuiControl, +c0x00DD00, DoPing2Status
} else {
    GuiControl,, DoPing2Status, OFF
    GuiControl, +c0xFF4444, DoPing2Status
}
if (doPing3) {
    GuiControl,, DoPing3Status, ON
    GuiControl, +c0x00DD00, DoPing3Status
} else {
    GuiControl,, DoPing3Status, OFF
    GuiControl, +c0xFF4444, DoPing3Status
}
if (useCelestial) {
    GuiControl,, UseCelestialStatus, ON
    GuiControl, +c0x00DD00, UseCelestialStatus
} else {
    GuiControl,, UseCelestialStatus, OFF
    GuiControl, +c0xFF4444, UseCelestialStatus
}
if (useExotic) {
    GuiControl,, UseExoticStatus, ON
    GuiControl, +c0x00DD00, UseExoticStatus
} else {
    GuiControl,, UseExoticStatus, OFF
    GuiControl, +c0xFF4444, UseExoticStatus
}
if (useBounded) {
    GuiControl,, UseBoundedStatus, ON
    GuiControl, +c0x00DD00, UseBoundedStatus
} else {
    GuiControl,, UseBoundedStatus, OFF
    GuiControl, +c0xFF4444, UseBoundedStatus
}
if (autoClicker) {
    GuiControl, Disable, AutoClickStart
    GuiControl, Enable, AutoClickStop
    GuiControl, +c0x00DD00, AutoClickerStatus, ON
} else {
    GuiControl, Enable, AutoClickStart
    GuiControl, Disable, AutoClickStop
    GuiControl, +c0xFF4444, AutoClickerStatus, OFF
}
if (manualCraft) {
    GuiControl,, ManualCraftStatus, ON
    GuiControl, +c0x00DD00, ManualCraftStatus
} else {
    GuiControl,, ManualCraftStatus, OFF
    GuiControl, +c0xFF4444, ManualCraftStatus
}
if (auraDetection) {
    GuiControl,, AuraDetectionStatus, ON
    GuiControl, +c0x00DD00, AuraDetectionStatus
} else {
    GuiControl,, AuraDetectionStatus, OFF
    GuiControl, +c0xFF4444, AuraDetectionStatus
}
if (detectGlobal) {
    GuiControl,, DetectGlobalStatus, ON
    GuiControl, +c0x00DD00, DetectGlobalStatus
} else {
    GuiControl,, DetectGlobalStatus, OFF
    GuiControl, +c0xFF4444, DetectGlobalStatus
}
if (detectTrans) {
    GuiControl,, DetectTransStatus, ON
    GuiControl, +c0x00DD00, DetectTransStatus
} else {
    GuiControl,, DetectTransStatus, OFF
    GuiControl, +c0xFF4444, DetectTransStatus
}
if (autoWarp) {
    GuiControl,, AutoWarpStatus, ON
    GuiControl, +c0x00DD00, AutoWarpStatus
} else {
    GuiControl,, AutoWarpStatus, OFF
    GuiControl, +c0xFF4444, AutoWarpStatus
}
if (detectPotion) {
    GuiControl,, DetectPotionStatus, ON
    GuiControl, +c0x00DD00, DetectPotionStatus
    SetTimer, DetectPotion, 300
} else {
    GuiControl,, DetectPotionStatus, OFF
    GuiControl, +c0xFF4444, DetectPotionStatus
    SetTimer, DetectPotion, Off
}
if (auraFilter) {
    GuiControl,, AuraFilterStatus, ON
    GuiControl, +c0x00DD00, AuraFilterStatus
} else {
    GuiControl,, AuraFilterStatus, OFF
    GuiControl, +c0xFF4444, AuraFilterStatus
}
if (detectEden) {
    GuiControl,, DetectEdenStatus, ON
    GuiControl, +c0x00DD00, DetectEdenStatus
    edenDelay := 20000
    SetTimer, EdenSnatcher, 50
} else {
    GuiControl,, DetectEdenStatus, OFF
    GuiControl, +c0xFF4444, DetectEdenStatus
    SetTimer, EdenSnatcher, Off
}
if (checkGhostServer) {
    GuiControl,, CheckGhostServerStatus, ON
    GuiControl, +c0x00DD00, CheckGhostServerStatus
    if (privateServerLink = "") {
        TrayTip, Please Enter a Private Server Link!, Private Server Tab -> Private Server Link
        GuiControl,, CheckGhostServerStatus, OFF
        GuiControl, +c0xFF4444, CheckGhostServerStatus
        checkGhostServer := false
    }
} else {
    GuiControl,, CheckGhostServerStatus, OFF
    GuiControl, +c0xFF4444, CheckGhostServerStatus
}
if (biomeDetect) {
    GuiControl,, BiomeDetectStatus, ON
    GuiControl, +c0x00DD00, BiomeDetectStatus
        if (privateServerLink = "") {
        TrayTip, Please Enter a Private Server Link!, Private Server Tab -> Private Server Link
        GuiControl,, BiomeDetectStatus, OFF
        GuiControl, +c0xFF4444, BiomeDetectStatus
        biomeDetect := false
    }
} else {
    GuiControl,, BiomeDetectStatus, OFF
    GuiControl, +c0xFF4444, BiomeDetectStatus
}
if (limboFish) {
    GuiControl,, LimboFishStatus, ON
    GuiControl, +c0x00DD00, LimboFishStatus
} else {
    GuiControl,, LimboFishStatus, OFF
    GuiControl, +c0xFF4444, LimboFishStatus
}

SetTimer, AuraBiomeDetect, 1000



AuraCheckChange:
    if (!auraFilterReady)
        return
    Gui, AuraFilter:Submit, NoHide
    for i, aura in AuraListOrder {
        ctrlName := aura . "_chk"
        StringReplace, ctrlName, ctrlName, -, _, All
        EnabledAuras[aura] := %ctrlName%
        IniWrite, % EnabledAuras[aura], %iniFilePath%, EnabledAuras, %aura%
    }
    for i, aura in AuraListTransOrder {
        ctrlName := aura . "_chk"
        StringReplace, ctrlName, ctrlName, -, _, All
        EnabledAuras[aura] := %ctrlName%
        IniWrite, % EnabledAuras[aura], %iniFilePath%, EnabledAuras, %aura%
    }
return

SaveAuraFilter:
    Gui, AuraFilter:Submit, NoHide
    for i, aura in AuraListOrder {
        ctrlName := aura . "_chk"
        StringReplace, ctrlName, ctrlName, -, _, All
        EnabledAuras[aura] := %ctrlName%
        IniWrite, % EnabledAuras[aura], %iniFilePath%, EnabledAuras, %aura%
    }
    for i, aura in AuraListTransOrder {
        ctrlName := aura . "_chk"
        StringReplace, ctrlName, ctrlName, -, _, All
        EnabledAuras[aura] := %ctrlName%
        IniWrite, % EnabledAuras[aura], %iniFilePath%, EnabledAuras, %aura%
    }
    Gui, AuraFilter:Destroy
return

GuiClose:
ExitApp

toggle := false
firstLoop := true
startTick := 0
cycleCount := 0

TabChange:
return

UpdateLoopCount:
    Gui, Submit, NoHide
    if (MaxLoopInput > 0) {
        maxLoopCount := MaxLoopInput
        IniWrite, %maxLoopCount%, %iniFilePath%, Macro, maxLoopCount
    }
    if (FishingLoopInput > 0) {
        fishingLoopCount := FishingLoopInput
        IniWrite, %fishingLoopCount%, %iniFilePath%, Macro, fishingLoopCount
    }
return

UpdatePotionCraft:
    Gui, Submit, NoHide
    if (PotionCraftInput > 0) {
        potionCraftCount := PotionCraftInput
        IniWrite, %potionCraftCount%, %iniFilePath%, Macro, potionCraftCount
    }
return

ToggleSellAll:
    sellAllToggle := !sellAllToggle
    if (sellAllToggle) {
        GuiControl,, SellAllStatus, ON
        GuiControl, +c0x00DD00, SellAllStatus
    } else {
        GuiControl,, SellAllStatus, OFF
        GuiControl, +c0xFF4444, SellAllStatus
    }
    IniWrite, % (sellAllToggle ? "true" : "false"), %iniFilePath%, Macro, sellAllToggle
return

ToggleAdvancedFishingDetection:
    advancedFishingDetection := !advancedFishingDetection
    if (advancedFishingDetection) {
        GuiControl,, AdvancedFishingDetectionStatus, ON
        GuiControl, +c0x00DD00, AdvancedFishingDetectionStatus
    } else {
        GuiControl,, AdvancedFishingDetectionStatus, OFF
        GuiControl, +c0xFF4444, AdvancedFishingDetectionStatus
    }
    IniWrite, % (advancedFishingDetection ? "true" : "false"), %iniFilePath%, Macro, advancedFishingDetection
return

ToggleAutoUnequip:
    autoUnequip := !autoUnequip
    if (autoUnequip) {
        GuiControl,, AutoUnequipStatus, ON
        GuiControl, +c0x00DD00, AutoUnequipStatus
        if (!auraDetection) {
            TrayTip, Please turn on Aura Detection!, Auras Tab -> Aura Detection
            GuiControl,, AutoUnequipStatus, OFF
            GuiControl, +c0xFF4444, AutoUnequipStatus
            autoUnequip := false
        }
    } else {
        GuiControl,, AutoUnequipStatus, OFF
        GuiControl, +c0xFF4444, AutoUnequipStatus
    }
    IniWrite, % (autoUnequip ? "true" : "false"), %iniFilePath%, Macro, autoUnequip
return

ToggleUseNothing:
    useNothing := !useNothing
    if (useNothing) {
        GuiControl,, UseNothingStatus, ON
        GuiControl, +c0x00DD00, UseNothingStatus
    } else {
        GuiControl,, UseNothingStatus, OFF
        GuiControl, +c0xFF4444, UseNothingStatus
    }
    IniWrite, % (useNothing ? "true" : "false"), %iniFilePath%, Macro, useNothing
return

ToggleAutoCloseChat:
    autoCloseChat := !autoCloseChat
    if (autoCloseChat) {
        GuiControl,, AutoCloseChatStatus, ON
        GuiControl, +c0x00DD00, AutoCloseChatStatus
    } else {
        GuiControl,, AutoCloseChatStatus, OFF
        GuiControl, +c0xFF4444, AutoCloseChatStatus
    }
    IniWrite, % (autoCloseChat ? "true" : "false"), %iniFilePath%, Macro, autoCloseChat
return

ToggleAzertyPathing:
    azertyPathing := !azertyPathing
    if (azertyPathing) {
        GuiControl,, AzertyPathingStatus, ON
        GuiControl, +c0x00DD00, AzertyPathingStatus
    } else {
        GuiControl,, AzertyPathingStatus, OFF
        GuiControl, +c0xFF4444, AzertyPathingStatus
    }
    IniWrite, % (azertyPathing ? "true" : "false"), %iniFilePath%, Macro, azertyPathing
return

ToggleClipWebhook:
    clipWebhook := !clipWebhook
    if (clipWebhook) {
        GuiControl,, ClipWebhookStatus, ON
        GuiControl, +c0x00DD00, ClipWebhookStatus
    } else {
        GuiControl,, ClipWebhookStatus, OFF
        GuiControl, +c0xFF4444, ClipWebhookStatus
    }
    IniWrite, % (clipWebhook ? "true" : "false"), %iniFilePath%, Macro, clipWebhook
return

ToggleDoPing2:
    doPing2 := !doPing2
    if (doPing2) {
        GuiControl,, DoPing2Status, ON
        GuiControl, +c0x00DD00, DoPing2Status
    } else {
        GuiControl,, DoPing2Status, OFF
        GuiControl, +c0xFF4444, DoPing2Status
    }
    IniWrite, % (doPing2 ? "true" : "false"), %iniFilePath%, Macro, doPing2
return

ToggleDoPing3:
    doPing3 := !doPing3
    if (doPing3) {
        GuiControl,, DoPing3Status, ON
        GuiControl, +c0x00DD00, DoPing3Status
    } else {
        GuiControl,, DoPing3Status, OFF
        GuiControl, +c0xFF4444, DoPing3Status
    }
    IniWrite, % (doPing3 ? "true" : "false"), %iniFilePath%, Macro, doPing3
return

ToggleStrangeController:
    strangeController := !strangeController
    if (strangeController) {
        GuiControl,, StrangeControllerStatus, ON
        GuiControl, +c0x00DD00, StrangeControllerStatus
    } else {
        GuiControl,, StrangeControllerStatus, OFF
        GuiControl, +c0xFF4444, StrangeControllerStatus
    }
    IniWrite, % (strangeController ? "true" : "false"), %iniFilePath%, Macro, strangeController
return

ToggleBiomeRandomizer:
    biomeRandomizer := !biomeRandomizer
    if (biomeRandomizer) {
        GuiControl,, BiomeRandomizerStatus, ON
        GuiControl, +c0x00DD00, BiomeRandomizerStatus
    } else {
        GuiControl,, BiomeRandomizerStatus, OFF
        GuiControl, +c0xFF4444, BiomeRandomizerStatus
    }
    IniWrite, % (biomeRandomizer ? "true" : "false"), %iniFilePath%, Macro, biomeRandomizer
return

ToggleUseCelestial:
    useCelestial := !useCelestial
    if (useCelestial) {
        GuiControl,, UseCelestialStatus, ON
        GuiControl, +c0x00DD00, UseCelestialStatus
    } else {
        GuiControl,, UseCelestialStatus, OFF
        GuiControl, +c0xFF4444, UseCelestialStatus
    }
    IniWrite, % (useCelestial ? "true" : "false"), %iniFilePath%, Macro, useCelestial
return

ToggleUseExotic:
    useExotic := !useExotic
    if (useExotic) {
        GuiControl,, UseExoticStatus, ON
        GuiControl, +c0x00DD00, UseExoticStatus
    } else {
        GuiControl,, UseExoticStatus, OFF
        GuiControl, +c0xFF4444, UseExoticStatus
    }
    IniWrite, % (useExotic ? "true" : "false"), %iniFilePath%, Macro, useExotic
return

ToggleUseBounded:
    useBounded := !useBounded
    if (useBounded) {
        GuiControl,, UseBoundedStatus, ON
        GuiControl, +c0x00DD00, UseBoundedStatus
    } else {
        GuiControl,, UseBoundedStatus, OFF
        GuiControl, +c0xFF4444, UseBoundedStatus
    }
    IniWrite, % (useBounded ? "true" : "false"), %iniFilePath%, Macro, useBounded
return

ToggleAutoClicker:
    autoClicker := !autoClicker
        if (autoClicker) {
        GuiControl, Disable, AutoClickStart
        GuiControl, Enable, AutoClickStop
        GuiControl,, AutoClickerStatus, ON
    } else {
        GuiControl, Enable, AutoClickStart
        GuiControl, Disable, AutoClickStop
        GuiControl,, AutoClickerStatus, OFF
    }

    IniWrite, % (autoClicker ? "true" : "false"), %iniFilePath%, Macro, autoClicker
return

ToggleManualCraft:
    manualCraft := !manualCraft
    if (manualCraft) {
        GuiControl,, ManualCraftStatus, ON
        GuiControl, +c0x00DD00, ManualCraftStatus
    } else {
        GuiControl,, ManualCraftStatus, OFF
        GuiControl, +c0xFF4444, ManualCraftStatus
    }
    IniWrite, % (manualCraft ? "true" : "false"), %iniFilePath%, Macro, manualCraft
return

ToggleAuraDetection:
    auraDetection := !auraDetection
    if (auraDetection) {
        GuiControl,, AuraDetectionStatus, ON
        GuiControl, +c0x00DD00, AuraDetectionStatus
    } else {
        GuiControl,, AuraDetectionStatus, OFF
        GuiControl, +c0xFF4444, AuraDetectionStatus
    }
    IniWrite, % (auraDetection ? "true" : "false"), %iniFilePath%, Macro, auraDetection
return

ToggleDetectGlobal:
    detectGlobal := !detectGlobal

    if (detectGlobal) {
        GuiControl,, DetectGlobalStatus, ON
        GuiControl, +c0x00DD00, DetectGlobalStatus
    } else {
        GuiControl,, DetectGlobalStatus, OFF
        GuiControl, +c0xFF4444, DetectGlobalStatus
    }

    IniWrite, % (detectGlobal ? "true" : "false"), %iniFilePath%, Macro, detectGlobal
return

ToggleDetectTrans:
    detectTrans := !detectTrans
    if (detectTrans) {
        GuiControl,, DetectTransStatus, ON
        GuiControl, +c0x00DD00, DetectTransStatus
    } else {
        GuiControl,, DetectTransStatus, OFF
        GuiControl, +c0xFF4444, DetectTransStatus
    }
    IniWrite, % (detectTrans ? "true" : "false"), %iniFilePath%, Macro, detectTrans
return

ToggleAutoWarp:
    autoWarp := !autoWarp
    if (autoWarp) {
        GuiControl,, AutoWarpStatus, ON
        GuiControl, +c0x00DD00, AutoWarpStatus
    } else {
        GuiControl,, AutoWarpStatus, OFF
        GuiControl, +c0xFF4444, AutoWarpStatus
    }
    IniWrite, % (autoWarp ? "true" : "false"), %iniFilePath%, Macro, autoWarp
return

ToggleDetectPotion:
    detectPotion := !detectPotion
    if (detectPotion) {
        GuiControl,, DetectPotionStatus, ON
        GuiControl, +c0x00DD00, DetectPotionStatus
        SetTimer, DetectPotion, 300
    } else {
        GuiControl,, DetectPotionStatus, OFF
        GuiControl, +c0xFF4444, DetectPotionStatus
        SetTimer, DetectPotion, Off
    }
    IniWrite, % (detectPotion ? "true" : "false"), %iniFilePath%, Macro, detectPotion
return

ToggleAuraFilter:
    auraFilter := !auraFilter
    if (auraFilter) {
        GuiControl,, AuraFilterStatus, ON
        GuiControl, +c0x00DD00, AuraFilterStatus
    } else {
        GuiControl,, AuraFilterStatus, OFF
        GuiControl, +c0xFF4444, AuraFilterStatus
    }
    IniWrite, % (auraFilter ? "true" : "false"), %iniFilePath%, Macro, auraFilter
return

ToggleDetectEden:
    detectEden := !detectEden
    if (detectEden) {
        GuiControl,, DetectEdenStatus, ON
        GuiControl, +c0x00DD00, DetectEdenStatus
        edenDelay := 20000
        SetTimer, EdenSnatcher, 100
    } else {
        GuiControl,, DetectEdenStatus, OFF
        GuiControl, +c0xFF4444, DetectEdenStatus
        SetTimer, EdenSnatcher, Off
    }
    IniWrite, % (detectEden ? "true" : "false"), %iniFilePath%, Macro, detectEden
return

ToggleCheckGhostServer:
    checkGhostServer := !checkGhostServer
    if (checkGhostServer) {
        GuiControl,, CheckGhostServerStatus, ON
        GuiControl, +c0x00DD00, CheckGhostServerStatus
        if (privateServerLink = "") {
            TrayTip, Please Enter a Private Server Link!, Private Server Tab -> Private Server Link
            GuiControl,, CheckGhostServerStatus, OFF
            GuiControl, +c0xFF4444, CheckGhostServerStatus
            checkGhostServer := false
        }
    } else {
        GuiControl,, CheckGhostServerStatus, OFF
        GuiControl, +c0xFF4444, CheckGhostServerStatus
    }
    IniWrite, % (checkGhostServer ? "true" : "false"), %iniFilePath%, Macro, checkGhostServer
return

ToggleBiomeDetect:
    biomeDetect := !biomeDetect
    if (biomeDetect) {
        GuiControl,, BiomeDetectStatus, ON
        GuiControl, +c0x00DD00, BiomeDetectStatus
            if (privateServerLink = "") {
            TrayTip, Please Enter a Private Server Link!, Private Server Tab -> Private Server Link
            GuiControl,, BiomeDetectStatus, OFF
            GuiControl, +c0xFF4444, BiomeDetectStatus
            biomeDetect := false
        }
    } else {
        GuiControl,, BiomeDetectStatus, OFF
        GuiControl, +c0xFF4444, BiomeDetectStatus
    }
    IniWrite, % (biomeDetect ? "true" : "false"), %iniFilePath%, Macro, biomeDetect
return

ToggleLimboFish:
    limboFish := !limboFish
    if (limboFish) {
        GuiControl,, LimboFishStatus, ON
        GuiControl, +c0x00DD00, LimboFishStatus
    } else {
        GuiControl,, LimboFishStatus, OFF
        GuiControl, +c0xFF4444, LimboFishStatus
    }
    IniWrite, % (limboFish ? "true" : "false"), %iniFilePath%, Macro, limboFish
return


UpdatePrivateServer:
    Gui, Submit, NoHide
    privateServerLink := PrivateServerInput
    IniWrite, %privateServerLink%, %iniFilePath%, Macro, privateServerLink
return

UpdateAdvancedThreshold:
    Gui, Submit, nohide
    if (AdvancedThresholdInput >= 0 && AdvancedThresholdInput <= 40) {
        advancedFishingThreshold := AdvancedThresholdInput
        IniWrite, %advancedFishingThreshold%, %iniFilePath%, Macro, advancedFishingThreshold
    }
return

RainbowText:
    hue += 3
    if (hue > 360)
        hue := 0

    RGB := HSLtoRGB(hue, 1, 0.5)

    Gui, Font, s10 c%RGB% Normal, Trojan Pro
    GuiControl, Font, ExoticText
return


HSLtoRGB(h, s, l) {
    c := (1 - Abs(2*l - 1)) * s
    x := c * (1 - Abs(Mod(h/60, 2) - 1))
    m := l - c/2

    if (h < 60)
        r:=c, g:=x, b:=0
    else if (h < 120)
        r:=x, g:=c, b:=0
    else if (h < 180)
        r:=0, g:=c, b:=x
    else if (h < 240)
        r:=0, g:=x, b:=c
    else if (h < 300)
        r:=x, g:=0, b:=c
    else
        r:=c, g:=0, b:=x

    r := Round((r+m)*255)
    g := Round((g+m)*255)
    b := Round((b+m)*255)

    return Format("{:02X}{:02X}{:02X}", r, g, b)
}

AuraBiomeDetect:
global webhookURL, webhookID, doPing2, prevState, blehblehbleh, prevBiome, biome, webResponse
global auracolor := 0
    logDir := LocalAppData "\Roblox\logs"

    newestTime := 0
    newestFile := ""
    Loop, Files, %logDir%\*.log, F
    {
        if (A_LoopFileTimeModified > newestTime) {
            newestTime := A_LoopFileTimeModified
            newestFile := A_LoopFileFullPath
        }
    }

    if !newestFile
        return

    file := FileOpen(newestFile, "r")
    if !IsObject(file)
        return

    size := file.Length
    chunkSize := 10240
    if (size > chunkSize)
        file.Seek(-chunkSize, 2)
    content := file.Read()
    file.Close()

    lines := StrSplit(content, "`n")
    regexLine := """state"":""((?:\\.|[^""])*)"".*?""largeImage"":\{""hoverText"":""((?:\\.|[^""])*)"""
    Loop % lines.MaxIndex()
    {
        line := lines[lines.MaxIndex() - A_Index + 1]
        if InStr(line, "[BloxstrapRPC]")
        {
            if RegExMatch(line, regexLine, m) {
                state := m1
                biome := m2
                break
            }
        }
    }

    if (auraDetection) {
        if (state && state != "In Main Menu" && state != "Equipped _None_" && state != prevState) {
            blehblehbleh := ""
            webResponse := false
            if (prevState != "None") {
                needle := Chr(92) Chr(34)
                pos1 := InStr(state, needle)
                auraName := (pos1 ? (pos2 := InStr(state, needle, false, pos1 + StrLen(needle))) && pos2>pos1 ? SubStr(state, pos1 + StrLen(needle), pos2 - (pos1 + StrLen(needle))) : state : state)

                time := A_NowUTC
                timestamp := SubStr(time,1,4) "-" SubStr(time,5,2) "-" SubStr(time,7,2) "T" SubStr(time,9,2) ":" SubStr(time,11,2) ":" SubStr(time,13,2) ".000Z"

                auraName := StrReplace(auraName, "\", "\\")
                auraName := StrReplace(auraName, """", "\""")

                if (AuraList.HasKey(auraName) && doPing3) {
                    contentStr := """content"": ""<@" webhookID ">"","
                    mentionsStr := """allowed_mentions"": {""users"": [""" webhookID """]},"
                } else {
                    contentStr := """content"": """","
                    mentionsStr := ""
                }
                
            if (!AuraListTrans.HasKey(auraName) && auraName != "Nothing" && auraName != "pukeko") {
                    if (!AuraList.HasKey(auraName) && (!auraFilter || !EnabledAuras[auraName])) { ; normal auras
                        json := "{"
                            . mentionsStr
                            . contentStr
                            . """embeds"": [{"
                            . """description"": "" ### Aura Equipped - " auraName ""","
                            . """color"": " auracolor ","
                            . """footer"": {""text"": ""Aery's fishSol v1.6"", ""icon_url"": ""https://raw.githubusercontent.com/knowaery/Aery-s-Fishsol/main/img/yui2.png""},"
                            . """timestamp"": """ timestamp """"
                            . "}]}"

                        http := ComObjCreate("WinHttp.WinHttpRequest.5.1")
                        http.Open("POST", webhookURL, false)
                        http.SetRequestHeader("Content-Type", "application/json")
                        http.Send(json)
                    } else if (auraFilter) { ; check aura filter and see if the aura is enabled
                        if (AuraList.HasKey(auraName) && EnabledAuras[auraName] && !webResponse) {
                            json := "{"
                                . mentionsStr
                                . contentStr
                                . """embeds"": [{"
                                . """description"": "" ### Aura Equipped - " auraName ""","
                                . """color"": " auracolor ","
                                . """footer"": {""text"": ""Aery's fishSol v1.6"", ""icon_url"": ""https://raw.githubusercontent.com/knowaery/Aery-s-Fishsol/main/img/yui2.png""},"
                                . """timestamp"": """ timestamp """"
                                . "}]}"
                            http := ComObjCreate("WinHttp.WinHttpRequest.5.1")
                            http.Open("POST", webhookURL, false)
                            http.SetRequestHeader("Content-Type", "application/json")
                            http.Send(json)
                        } else if (AuraList.HasKey(auraName) && !EnabledAuras[auraName] && !webResponse) { ; if aura is disabled in aura filter, it js sends webhook on the aura without pinging
                                json := "{"
                                . """embeds"": [{"
                                . """description"": "" ### Aura Equipped - " auraName ""","
                                . """color"": " auracolor ","
                                . """footer"": {""text"": ""Aery's fishSol v1.6"", ""icon_url"": ""https://raw.githubusercontent.com/knowaery/Aery-s-Fishsol/main/img/yui2.png""},"
                                . """timestamp"": """ timestamp """"
                                . "}]}"
                            http := ComObjCreate("WinHttp.WinHttpRequest.5.1")
                            http.Open("POST", webhookURL, false)
                            http.SetRequestHeader("Content-Type", "application/json")
                            http.Send(json)
                        }
                    } else if (!auraFilter) { ; no aura filter, checks global list
                        if (AuraList.HasKey(auraName) && !webResponse) {
                            json := "{"
                                . mentionsStr
                                . contentStr
                                . """embeds"": [{"
                                . """description"": "" ### Aura Equipped - " auraName ""","
                                . """color"": " auracolor ","
                                . """footer"": {""text"": ""Aery's fishSol v1.6"", ""icon_url"": ""https://raw.githubusercontent.com/knowaery/Aery-s-Fishsol/main/img/yui2.png""},"
                                . """timestamp"": """ timestamp """"
                                . "}]}"
                            http := ComObjCreate("WinHttp.WinHttpRequest.5.1")
                            http.Open("POST", webhookURL, false)
                            http.SetRequestHeader("Content-Type", "application/json")
                            http.Send(json)
                        }
                    }
                }

                if (auraName = "EQUINOX") {
                    ClipCountdownGlobal()
                    if (!webResponse) {
                        SendWebhook2("**Now your getting yourself closer.. to the.. ZERO** \nAura detected: " auraName, 0, "https://raw.githubusercontent.com/knowaery/Aery-s-Fishsol/main/auraimages/EquinoxNewCollection.webp")
                    }
                } else if (auraName = "LEVIATHAN") {
                    ClipCountdownGlobal()
                    if (!webResponse) {
                        SendWebhook2(":tada: **The Ruler of the Beneath** :tada: \nAura detected: " auraName, 5600, "https://raw.githubusercontent.com/knowaery/Aery-s-Fishsol/main/auraimages/LeviathanLong.png")
                    }
                } else if (auraName = "BREAKTHROUGH") {
                    ClipCountdownGlobal()
                    if (!webResponse) {
                        SendWebhook2("**rune i: starting with a few** \n**rune ii: only less it gets.** \n**rune iii: time by time, now empty** \n**rune iv: and there was nothing left.** \n**get out of my head.** \nAura detected: " auraName, 0, "https://raw.githubusercontent.com/knowaery/Aery-s-Fishsol/main/auraimages/BreakthroughCollection.webp")
                    }
                } else if (auraName = "MONARCH") {
                    ClipCountdownGlobal()
                    if (!webResponse) {
                        SendWebhook2("**The fallen ruler that retained power.** \nAura detected: " auraName, 0, "https://raw.githubusercontent.com/knowaery/Aery-s-Fishsol/main/auraimages/MonarchCollection.webp")
                    }
                } else if (auraName = "Luminosity") {
                    ClipCountdownGlobal()
                    if (!webResponse) {
                        SendWebhook2( ":tada: **The Absolute Radiant** :tada: \nAura detected: " auraName , 11393254, "https://raw.githubusercontent.com/knowaery/Aery-s-Fishsol/main/auraimages/ReworkedLumiCollection.webp")
                    }
                } else if (auraName = "Pixelation") {
                    ClipCountdownGlobal()
                    if (!webResponse) {
                        SendWebhook2(":tada: **Game Start!** :tada: \nAura detected: " auraName, 0, "https://raw.githubusercontent.com/knowaery/Aery-s-Fishsol/main/auraimages/PixelationCollection.webp")
                    }
                } else if (auraName = "illusionary") {
                    ClipCountdownGlobal()
                    if (!webResponse) {
                        SendWebhook2("**<>;'100110101000110101002010-,><';[][[[[][100011001l} \nThe Ultimate ####'# \nP█e█r█f#█3█cT p█##UpP█3█T  ** \n**:)      :)      :)      :)      :)      :)      :)      :)      :)      :)      :)      :)      :) **\n**(:      (:      (:      (:      (:      (:      (:      (:      (:      (:      (:      (:      (: **" auraName , 736657, "https://raw.githubusercontent.com/knowaery/Aery-s-Fishsol/main/auraimages/Illusionary_curation.gif")
                    }
                } else if (auraName = "CHILLSEAR") {
                    ClipCountdownGlobal()
                    if (!webResponse) {
                        SendWebhook2(":tada:**:tada: \nAura detected: " auraName, 0, "https://raw.githubusercontent.com/knowaery/Aery-s-Fishsol/main/auraimages/yuichillsear.gif")
                    }
                } else if (auraName = "ASTRAIOS") {
                    ClipCountdownGlobal()
                    if (!webResponse) {
                        SendWebhook2("**The Ruler of the Quantum Vortex* \nAura detected: " auraName, 0, "https://raw.githubusercontent.com/knowaery/Aery-s-Fishsol/main/auraimages/Astraios.gif")
                    }
                }
                
                
                if (auraFilter) {
                    if (AuraList.HasKey(auraName) && EnabledAuras[auraName] && detectGlobal && !webResponse) {
                        SetTimer, V2Clip, -%triggerDelayGlobal%
                        brainrot67 := "67"
                        ShowClipTextGlobal()
                    }
                } else {
                    if (AuraList.HasKey(auraName) && detectGlobal && !webResponse) {
                        SetTimer, V2Clip, -%triggerDelayGlobal%
                        brainrot67 := "67"
                        ShowClipTextGlobal()
                    }
                }

                if (AuraListTrans.HasKey(auraName) && detectTrans && !webResponse) {
                    SetTimer, V2Clip, -%triggerDelayTrans%
                    brainrot67 := "67"
                    ShowClipTextTrans()
                }

                if (toggle && autoUnequip && auraName != "Nothing") {
                        pendingUnequip := true
                    }
                }
            prevState := state
            brainrot67 := ""
        }
    }
    

    if (strangeController || biomeRandomizer || autoWarp || biomeDetect) {
                if (biome && biome != "" && biome != prevBiome) {
                    if (biomeDetect && toggle) {
                    biomeKey := "Biome" StrReplace(biome, " ", "")
                    IniRead, isBiomeEnabled, %iniFilePath%, "Biomes", %biomeKey%, 1

                        if (isBiomeEnabled = 1 || biome = "GLITCHED" || biome = "DREAMSPACE" || biome = "CYBERSPACE" || biome = "SINGULARITY") {
                            prevBiome := biome
                            
                            if (biomeData = "") {
                                biomeData := {}
                                biomeData["NORMAL"]      := {color: 12582656,  thumbnail: "https://maxstellar.github.io/biome_thumb/GLITCHED.png"}
                                biomeData["EGGLAND"]     := {color: 13958285,  thumbnail: "https://raw.githubusercontent.com/xVapure/Noteab-Macro/refs/heads/main/images/EGGLAND.png"}
                                biomeData["WINDY"]       := {color: 10150399,  thumbnail: "https://maxstellar.github.io/biome_thumb/WINDY.png"}
                                biomeData["RAINY"]       := {color: 163773,    thumbnail: "https://maxstellar.github.io/biome_thumb/RAINY.png"}
                                biomeData["SNOWY"]       := {color: 14479353,  thumbnail: "https://maxstellar.github.io/biome_thumb/SNOWY.png"}
                                biomeData["SAND STORM"]  := {color: 9401431,   thumbnail: "https://maxstellar.github.io/biome_thumb/SAND%20STORM.png"}
                                biomeData["HELL"]        := {color: 16730905,  thumbnail: "https://maxstellar.github.io/biome_thumb/HELL.png"}
                                biomeData["STARFALL"]    := {color: 72375,     thumbnail: "https://maxstellar.github.io/biome_thumb/STARFALL.png"}
                                biomeData["CORRUPTION"]  := {color: 7155368,   thumbnail: "https://maxstellar.github.io/biome_thumb/CORRUPTION.png"}
                                biomeData["NULL"]        := {color: 8618883,   thumbnail: "https://maxstellar.github.io/biome_thumb/NULL.png"}
                                biomeData["GLITCHED"]    := {color: 12582656,  thumbnail: "https://maxstellar.github.io/biome_thumb/GLITCHED.png"}
                                biomeData["DREAMSPACE"]  := {color: 15376858,  thumbnail: "http://github.com/xVapure/Noteab-Macro/blob/main/images/Screenshot_2026-01-03_021107.png?raw=true"}
                                biomeData["AURORA"]      := {color: 18347,     thumbnail: "https://raw.githubusercontent.com/vexthecoder/OysterDetector/main/assets/aurora.png"}
                                biomeData["HEAVEN"]      := {color: 16769184,  thumbnail: "https://maxstellar.github.io/biome_thumb/HEAVEN.png"}
                                biomeData["CYBERSPACE"]  := {color: 663101,    thumbnail: "https://raw.githubusercontent.com/xVapure/Noteab-Macro/refs/heads/main/images/CYBERSPACE.png"}
                                biomeData["SINGULARITY"] := {color: 13582371,  thumbnail: "https://raw.githubusercontent.com/xVapure/Noteab-Macro/refs/heads/main/images/SINGULARITY.png"}
                            }

                            if (biomeData.HasKey(biome)) {
                                color        := biomeData[biome].color
                                thumbnail_url := biomeData[biome].thumbnail
                            }

                            time := A_NowUTC
                            timestamp := SubStr(time,1,4) "-" SubStr(time,5,2) "-" SubStr(time,7,2) "T" SubStr(time,9,2) ":" SubStr(time,11,2) ":" SubStr(time,13,2) ".000Z"

                            if (biome = "GLITCHED" || biome = "DREAMSPACE" || biome = "CYBERSPACE") {
                                RareBiomeWarning()
                                if (!cancelRareBiomeWebhook) {
                                    content := "@everyone"
                                }
                            } else {
                                content := ""
                            }

                            json := "{"
                            . """embeds"": ["
                            . "  {"
                            . "    ""description"": ""> ### Biome Started - " biome "\n> ### [Join Server](" privateServerLink ")"","
                            . "    ""color"": " color ","
                            . "    ""thumbnail"": {""url"": """ thumbnail_url """},"
                            . "    ""footer"": {""text"": ""fishSol v1.9.6"", ""icon_url"": ""https://maxstellar.github.io/fishSol%20icon.png""},"
                            . "    ""timestamp"": """ timestamp """"
                            . "  }"
                            . "],"
                            . """content"": """ content """"
                            . "}"

                            http := ComObjCreate("WinHttp.WinHttpRequest.5.1")
                            http.Open("POST", webhookURL, false)
                            http.SetRequestHeader("Content-Type", "application/json")
                            http.Send(json)
                        }
                    }
                
            if (biome = "CYBERSPACE" && toggle && autoWarp) {
                pendingSkips := true
            }

            if ((toggle) && (detectGlobal || detectTrans) && (prevBiome = "GLITCHED" || prevBiome = "DREAMSPACE" || prevBiome = "CYBERSPACE" || prevBiome = "SINGULARITY") && (biome != prevBiome)) {
                ClipBiome()
            }

            prevBiome := biome
            cancelRareBiomeWebhook := false
        }
    }
return

V2Clip:
    if (clipType = "Nvidia: Alt + F10") {
        Send, !{F10}
    }

    if (clipType = "Medal: F8") {
        Send, {F8}
    }
    if (clipWebhook) {
            Sleep, 1500
            if (clipType = "Nvidia: Alt + F10") {
                PixelGetColor, nvidiacolor, 1622, 155, RGB
                if (nvidiacolor = 0x76B900) {
                    try SendWebhook4(auraName . " has successfully been Clipped!", 0)
                } else {
                    try SendWebhook4(auraName . " has not been Clipped! Nvidia Replay is turned Off!", 0)
                    try SendWebhook4("Turning on Nvidia Replay...", 0)
                    TurnOnNvidiaReplay()
                }
            } else {
                try SendWebhook4(auraName . " has been Clipped!\nClip Type: Medal", 0)
            }
        }
    ToolTip
return

TurnOnNvidiaReplay() {
    Send, !z
    sleep, 300
    MouseMove, 224, 335, 3
    Click, Left
    sleep, 500
    PixelGetColor, nvidiaonbutton, 480, 93, RGB
    if (nvidiaonbutton != 0x76B900) {
        MouseMove, 480, 93, 3
        sleep, 300
        Click, Left
        MouseMove, 960, 540, 3
        sleep, 300
        Click, Left
    }
}

ClipBiome() {
    if (clipType = "Medal: F8") {
        Send, {F8}
    } else {
        Send, !{F10}
    }
}

PopSkips() {
    Sleep, 5000
    Click, 45, 521
    sleep 300
    Click, 1280, 343
    sleep 300
    Click, 820, 370
    sleep 300
    if (skipType = "Transcendent Potion") {
        Send, Transcendent Potion
    } else {
        Send, Warp Potion
    }
    Click, 850, 485
    sleep 300
    Click, 690, 585
    sleep 300
    Click, 1414, 300
    sleep, 600
}

RareBiomeWarning() {
    if (!cancelRareBiomeWebhook) {
        TrayTip, Rare Biome has been detected, F5 to cancel webhook (3)
        sleep, 1000
    }
    if (!cancelRareBiomeWebhook) {
        TrayTip, Rare Biome has been detected, F5 to cancel webhook (2)
        sleep, 1000
    }
    if (!cancelRareBiomeWebhook) {
        TrayTip, Rare Biome has been detected, F5 to cancel webhook (1)
        sleep, 1000
    }
}

DetectPotion:
    if (!toggle) {
        return
    }
    PixelGetColor, potionnotif, 1681, 835, RGB 
    PixelGetColor, potionnotif2, 1622, 720, RGB
    PixelGetColor, potionnotif3, 1622, 615, RGB
    PixelGetColor, potionnotif4, 1622, 490, RGB
    if (potionnotif = 0x6FB5FF || potionnotif2 = 0x6FB5FF || potionnotif3 = 0x6FB5FF || potionnotif4 = 0x6FB5FF) {
        pendingCraft := true
    }
return

EdenSnatcher:
    global edenDelay

    PixelGetColor, colorlimbo, 950, 180, RGB
    PixelGetColor, colorlimbo2, 1200, 100, RGB
    PixelGetColor, colorlimbo3, 676, 676, RGB

    if (colorlimbo = 0xFFFFFF && colorlimbo2 = 0x000000 && colorlimbo3 = 0x000000) {
            SetTimer, DoContract, -%edenDelay%
        }
return

DoContract:
    Send, e
    sleep, 100
    Send, e
    sleep, 100
    Send, e
    sleep, 400
    Click, 800, 800
    sleep, 300
    sleep, 800
    Click, 720, 930
    sleep, 400

    if (clipWebhook) {
        try SendWebhook2(":tada: **Eden has been Contracted!** :tada: \nWhite & Black Pixel Detected!", 0, "https://raw.githubusercontent.com/knowaery/Aery-s-Fishsol/main/auraimages/yuinycto.gif")
    }
    if (detectGlobal || detectTrans) {
        Sleep, 30000
        Send, !{F10}
    }
return

GetPingText() {
    global webhookID
    return webhookID != "" ? "<@" webhookID ">" : ""
}

UpdateWebhook:
    Gui, Submit, nohide
    webhookURL := WebhookInput
    IniWrite, %webhookURL%, %iniFilePath%, Macro, webhookURL
return

UpdateUserID:
    Gui, Submit, NoHide
    webhookID := UserIDInput
    IniWrite, %webhookID%, %iniFilePath%, Macro, webhookID
return


; webhook cystinuzeabukuttuty, please dont hate me max
SendWebhook(text, color := 16777215) {
    global webhookURL, webhookID

    if (!InStr(webhookURL, "discord"))
        return

    time := A_NowUTC
    timestamp := SubStr(time,1,4) "-" SubStr(time,5,2) "-" SubStr(time,7,2)
              . "T" SubStr(time,9,2) ":" SubStr(time,11,2) ":" SubStr(time,13,2) ".000Z"

    allowedMentions := ""
    content := ""



    json := "{"
    . """content"": """ content ""","
    . allowedMentions
    . """embeds"": [{"
    . """title"": """ text ""","
    . """color"": " color ","
    . """footer"": {"
    . """text"": ""Aery's fishSol v1.6"","
    . """icon_url"": ""https://raw.githubusercontent.com/knowaery/Aery-s-Fishsol/main/img/yui2.png"""
    . "},"
    . """timestamp"": """ timestamp """"
    . "}]"
    . "}"

    http := ComObjCreate("WinHttp.WinHttpRequest.5.1")
    http.Open("POST", webhookURL, false)
    http.SetRequestHeader("Content-Type", "application/json")
    http.Send(json)
}

SendWebhook2(text, color := 16777215, imageURL := "") {
    global webhookURL, webhookID, doPing3, auraName

    if (!InStr(webhookURL, "discord"))
        return

    time := A_NowUTC
    timestamp := SubStr(time,1,4) "-" SubStr(time,5,2) "-" SubStr(time,7,2)
              . "T" SubStr(time,9,2) ":" SubStr(time,11,2) ":" SubStr(time,13,2) ".000Z"

    content := ""
    allowedMentions := ""

    if (doPing3 && webhookID != "") {
        content := "<@" webhookID ">"
        allowedMentions := """allowed_mentions"": {""users"": [""" webhookID """]},"
    }

    imageBlock := ""
    if (imageURL != "") {
        imageBlock := """image"": {""url"": """ imageURL """},"
    }

    json := "{"
    . """content"": """ content ""","
    . allowedMentions
    . """embeds"": [{"
    . """title"": """ text ""","
    . """color"": " color ","
    . imageBlock
    . """footer"": {"
    . """text"": ""Aery's fishSol v1.6"","
    . """icon_url"": ""https://raw.githubusercontent.com/knowaery/Aery-s-Fishsol/main/img/yui2.png"""
    . "},"
    . """timestamp"": """ timestamp """"
    . "}]"
    . "}"

    http := ComObjCreate("WinHttp.WinHttpRequest.5.1")
    http.Open("POST", webhookURL, false)
    http.SetRequestHeader("Content-Type", "application/json")
    http.Send(json)
}

SendWebhook3(text, color := 16777215) {
    global webhookURL, webhookID

    if (!InStr(webhookURL, "discord"))
        return

    time := A_NowUTC
    timestamp := SubStr(time,1,4) "-" SubStr(time,5,2) "-" SubStr(time,7,2)
              . "T" SubStr(time,9,2) ":" SubStr(time,11,2) ":" SubStr(time,13,2) ".000Z"

    allowedMentions := ""
    content := "<@" webhookID ">"


    json := "{"
    . """content"": """ content ""","
    . allowedMentions
    . """embeds"": [{"
    . """title"": """ text ""","
    . """color"": " color ","
    . """footer"": {"
    . """text"": ""Aery's fishSol v1.6"","
    . """icon_url"": ""https://raw.githubusercontent.com/knowaery/Aery-s-Fishsol/main/img/yui2.png"""
    . "},"
    . """timestamp"": """ timestamp """"
    . "}]"
    . "}"

    http := ComObjCreate("WinHttp.WinHttpRequest.5.1")
    http.Open("POST", webhookURL, false)
    http.SetRequestHeader("Content-Type", "application/json")
    http.Send(json)
}

SendWebhook4(text, color := 16777215, imageURL := "") {
    global webhookURL, webhookID, doPing3, auraName

    if (!InStr(webhookURL, "discord"))
        return

    time := A_NowUTC
    timestamp := SubStr(time,1,4) "-" SubStr(time,5,2) "-" SubStr(time,7,2)
              . "T" SubStr(time,9,2) ":" SubStr(time,11,2) ":" SubStr(time,13,2) ".000Z"

    content := ""
    allowedMentions := ""

    if (doPing2 && webhookID != "") {
        content := "<@" webhookID ">"
        allowedMentions := """allowed_mentions"": {""users"": [""" webhookID """]},"
    }

    imageBlock := ""
    if (imageURL != "") {
        imageBlock := """image"": {""url"": """ imageURL """},"
    }

    json := "{"
    . """content"": """ content ""","
    . allowedMentions
    . """embeds"": [{"
    . """title"": """ text ""","
    . """color"": " color ","
    . imageBlock
    . """footer"": {"
    . """text"": ""Aery's fishSol v1.6"","
    . """icon_url"": ""https://raw.githubusercontent.com/knowaery/Aery-s-Fishsol/main/img/yui2.png"""
    . "},"
    . """timestamp"": """ timestamp """"
    . "}]"
    . "}"

    http := ComObjCreate("WinHttp.WinHttpRequest.5.1")
    http.Open("POST", webhookURL, false)
    http.SetRequestHeader("Content-Type", "application/json")
    http.Send(json)
}

OpenNvidiaNotes:
    Gui, NvidiaNotes:New, +AlwaysOnTop +Resize, Clipping Tutorial
    Gui, NvidiaNotes:Font, s10, Segoe UI

    Gui, NvidiaNotes:Add, Edit, x10 y10 w530 h180 ReadOnly vNvidiaNotesText -Wrap, 
    (
IMPORTANT, PLEASE READ

Requirements for Nvidia:
- Nvidia Overlay (requires an Nvidia GPU)
- Instant Replay must be enabled, with the keybind set to ALT + F10
- Replay length should be set between 2-5 minutes

Requirements for Medal:

This Replay System can be used even if you're not using the macro
    )

    Gui, NvidiaNotes:Add, Button, x225 y190 w100 h25 gCloseNvidiaNotes, Close
    Gui, NvidiaNotes:Show, w550 h230
return

CloseNvidiaNotes:
    Gui, NvidiaNotes:Destroy
return

OpenAuraFilter:
    Gui, AuraFilter:Destroy
    Gui, AuraFilter:New, +AlwaysOnTop, Aura Filter
    Gui, AuraFilter:Color, 041024
    Gui, AuraFilter:Font, s10 cWhite Bold, Segoe UI
    Gui, AuraFilter:Add, Text, x-15 y10 w600 h20 Center BackgroundTrans c0x00D4FF,Toggle which aura will have a webhook/clip. (Requires Aura Detection and Aura Filter)
    Gui, AuraFilter:Font, s9 cWhite Bold
    Gui, AuraFilter:Add, Text, x10 y35 w100 h20 BackgroundTrans c0xFFAA00, Globals: 
    Gui, AuraFilter:Font, s9 cWhite Normal

    itemsPerCol := Ceil(AuraListOrder.MaxIndex() / 3)
    for i, aura in AuraListOrder {
        col := (i - 1) // itemsPerCol
        row := Mod(i - 1, itemsPerCol)
        x := 10 + col * 185
        y := 55 + row * 22
        ctrlName := aura . "_chk"
        StringReplace, ctrlName, ctrlName, -, _, All
        options := "x" x " y" y " w180 h20 BackgroundTrans c0xCCCCCC v" ctrlName " gAuraCheckChange"
        if (EnabledAuras[aura])
            options .= " Checked"
        Gui, AuraFilter:Add, CheckBox, %options%, %aura%
    }

    nextY := 55 + itemsPerCol * 22 + 10
    Gui, AuraFilter:Font, s10 cWhite Bold, Segoe UI
    saveBtnY := nextY
    Gui, AuraFilter:Add, Button, x190 y%saveBtnY% w180 h30 gSaveAuraFilter, Save Aura Filter

    winH := saveBtnY + 50
    Gui, AuraFilter:Show, w580 h%winH%, Aura Filter
    auraFilterReady := true
return

AuraFilterClose:
    auraFilterReady := false
    Gui, AuraFilter:Destroy
return

ShowClipTextGlobal() {
    global blehblehbleh

    if (blehblehbleh != "hehe") {
        ToolTip, Clipped with Aery's Fishsol. F4 To Cancel (10), 900, 10
        sleep 1000
    }
    if (blehblehbleh != "hehe") {
        ToolTip, Clipped with Aery's Fishsol. F4 To Cancel (9), 900, 10
        sleep 1000
    }
    if (blehblehbleh != "hehe") {
        ToolTip, Clipped with Aery's Fishsol. F4 To Cancel (8), 900, 10
        sleep 1000
    }
    if (blehblehbleh != "hehe") {
        ToolTip, Clipped with Aery's Fishsol. F4 To Cancel (7), 900, 10
        sleep 1000
    }
    if (blehblehbleh != "hehe") {
        ToolTip, Clipped with Aery's Fishsol. F4 To Cancel (6), 900, 10
        sleep 1000
    }
    if (blehblehbleh != "hehe") {
        ToolTip, Clipped with Aery's Fishsol. F4 To Cancel (5), 900, 10
        sleep 1000
    }
    if (blehblehbleh != "hehe") {
        ToolTip, Clipped with Aery's Fishsol. F4 To Cancel (4), 900, 10
        sleep 1000
    }
    if (blehblehbleh != "hehe") {
        ToolTip, Clipped with Aery's Fishsol. F4 To Cancel (3), 900, 10
        sleep 1000
    }
    if (blehblehbleh != "hehe") {
        ToolTip, Clipped with Aery's Fishsol. F4 To Cancel (2), 900, 10
        sleep 1000
    }
    if (blehblehbleh != "hehe") {
        ToolTip, Clipped with Aery's Fishsol, 900, 10
    }

    blehblehbleh := ""
}

ShowClipTextTrans() {
    global blehblehbleh

    if (blehblehbleh != "hehe") {
        ToolTip, Clipped with Aery's Fishsol. F4 To Cancel (20), 900, 10
        sleep 1000
    }
    if (blehblehbleh != "hehe") {
        ToolTip, Clipped with Aery's Fishsol. F4 To Cancel (19), 900, 10
        sleep 1000
    }
    if (blehblehbleh != "hehe") {
        ToolTip, Clipped with Aery's Fishsol. F4 To Cancel (18), 900, 10
        sleep 1000
    }
    if (blehblehbleh != "hehe") {
        ToolTip, Clipped with Aery's Fishsol. F4 To Cancel (17), 900, 10
        sleep 1000
    }
    if (blehblehbleh != "hehe") {
        ToolTip, Clipped with Aery's Fishsol. F4 To Cancel (16), 900, 10
        sleep 1000
    }
    if (blehblehbleh != "hehe") {
        ToolTip, Clipped with Aery's Fishsol. F4 To Cancel (15), 900, 10
        sleep 1000
    }
    if (blehblehbleh != "hehe") {
        ToolTip, Clipped with Aery's Fishsol. F4 To Cancel (14), 900, 10
        sleep 1000
    }
    if (blehblehbleh != "hehe") {
        ToolTip, Clipped with Aery's Fishsol. F4 To Cancel (13), 900, 10
        sleep 1000
    }
    if (blehblehbleh != "hehe") {
        ToolTip, Clipped with Aery's Fishsol. F4 To Cancel (12), 900, 10
        sleep 1000
    }
    if (blehblehbleh != "hehe") {
        ToolTip, Clipped with Aery's Fishsol. F4 To Cancel (11), 900, 10
        sleep 1000
    }
    if (blehblehbleh != "hehe") {
        ToolTip, Clipped with Aery's Fishsol. F4 To Cancel (10), 900, 10
        sleep 1000
    }
    if (blehblehbleh != "hehe") {
        ToolTip, Clipped with Aery's Fishsol. F4 To Cancel (9), 900, 10
        sleep 1000
    }
    if (blehblehbleh != "hehe") {
        ToolTip, Clipped with Aery's Fishsol. F4 To Cancel (8), 900, 10
        sleep 1000
    }
    if (blehblehbleh != "hehe") {
        ToolTip, Clipped with Aery's Fishsol. F4 To Cancel (7), 900, 10
        sleep 1000
    }
    if (blehblehbleh != "hehe") {
        ToolTip, Clipped with Aery's Fishsol. F4 To Cancel (6), 900, 10
        sleep 1000
    }
    if (blehblehbleh != "hehe") {
        ToolTip, Clipped with Aery's Fishsol. F4 To Cancel (5), 900, 10
        sleep 1000
    }
    if (blehblehbleh != "hehe") {
        ToolTip, Clipped with Aery's Fishsol. F4 To Cancel (4), 900, 10
        sleep 1000
    }
    if (blehblehbleh != "hehe") {
        ToolTip, Clipped with Aery's Fishsol. F4 To Cancel (3), 900, 10
        sleep 1000
    }
    if (blehblehbleh != "hehe") {
        ToolTip, Clipped with Aery's Fishsol. F4 To Cancel (2), 900, 10
        sleep 1000
    }
    if (blehblehbleh != "hehe") {
        ToolTip, Clipped with Aery's Fishsol, 900, 10
    }

    blehblehbleh := ""
}

ClipCountdownGlobal() {
    global webResponse

    if (!webResponse) {
        ToolTip, F4 To cancel webhook. Clipping Timer will start after... (10), 850, 10
        Sleep, 1000
    }
    if (!webResponse) {
        ToolTip, F4 To cancel webhook. Clipping Timer will start after... (9), 850, 10
        Sleep, 1000
    }
    if (!webResponse) {
        ToolTip, F4 To cancel webhook. Clipping Timer will start after... (8), 850, 10
        Sleep, 1000
    }
    if (!webResponse) {
        ToolTip, F4 To cancel webhook. Clipping Timer will start after... (7), 850, 10
        Sleep, 1000
    }
    if (!webResponse) {
        ToolTip, F4 To cancel webhook. Clipping Timer will start after... (6), 850, 10
        Sleep, 1000
    }
    if (!webResponse) {
        ToolTip, F4 To cancel webhook. Clipping Timer will start after... (5), 850, 10
        Sleep, 1000
    }
    if (!webResponse) {
        ToolTip, F4 To cancel webhook. Clipping Timer will start after... (4), 850, 10
        Sleep, 1000
    }
    if (!webResponse) {
        ToolTip, F4 To cancel webhook. Clipping Timer will start after... (3), 850, 10
        Sleep, 1000
    }
    if (!webResponse) {
        ToolTip, F4 To cancel webhook. Clipping Timer will start after... (2), 850, 10
        Sleep, 1000
    }
    if (!webResponse) {
        ToolTip, F4 To cancel webhook. Clipping Timer will start after... (1), 850, 10
        Sleep, 1000
    }

    ToolTip
}

ClipCountdown() {
    global webResponse


    if (!webResponse) {
        ToolTip, F4 To cancel webhook (10), 900, 10
        Sleep, 1000
    }
    if (!webResponse) {
        ToolTip, F4 To cancel webhook (9), 900, 10
        Sleep, 1000
    }
    if (!webResponse) {
        ToolTip, F4 To cancel webhook (8), 900, 10
        Sleep, 1000
    }
    if (!webResponse) {
        ToolTip, F4 To cancel webhook (7), 900, 10
        Sleep, 1000
    }
    if (!webResponse) {
        ToolTip, F4 To cancel webhook (6), 900, 10
        Sleep, 1000
    }
    if (!webResponse) {
        ToolTip, F4 To cancel webhook (5), 900, 10
        Sleep, 1000
    }
    if (!webResponse) {
        ToolTip, F4 To cancel webhook (4), 900, 10
        Sleep, 1000
    }
    if (!webResponse) {
        ToolTip, F4 To cancel webhook (3), 900, 10
        Sleep, 1000
    }
    if (!webResponse) {
        ToolTip, F4 To cancel webhook (2), 900, 10
        Sleep, 1000
    }
    if (!webResponse) {
        ToolTip, F4 To cancel webhook (1), 900, 10
        Sleep, 1000
    }
    
    ToolTip
}

ManualCraftAlert() {
    if (offsides != true) {
        ToolTip, Manual Craft is enabled with no item selected! Starting fishSol in: (10), 790, 10
        sleep, 1000
    }
    if (offsides != true) {
        ToolTip, Manual Craft is enabled with no item selected! Starting fishSol in: (9), 790, 10
        sleep, 1000
    }
    if (offsides != true) {
        ToolTip, Manual Craft is enabled with no item selected! Starting fishSol in: (8), 790, 10
        sleep, 1000
    }
    if (offsides != true) {
        ToolTip, Manual Craft is enabled with no item selected! Starting fishSol in: (7), 790, 10
        sleep, 1000
    }
    if (offsides != true) {
        ToolTip, Manual Craft is enabled with no item selected! Starting fishSol in: (6), 790, 10
        sleep, 1000
    }
    if (offsides != true) {
        ToolTip, Manual Craft is enabled with no item selected! Starting fishSol in: (5), 790, 10
        sleep, 1000
    }
    if (offsides != true) {
        ToolTip, Manual Craft is enabled with no item selected! Starting fishSol in: (4), 790, 10
        sleep, 1000
    }
    if (offsides != true) {
        ToolTip, Manual Craft is enabled with no item selected! Starting fishSol in: (3), 790, 10
        sleep, 1000
    }
    if (offsides != true) {
        ToolTip, Manual Craft is enabled with no item selected! Starting fishSol in: (2), 790, 10
        sleep, 1000
    }
    if (offsides != true) {
        ToolTip, Manual Craft is enabled with no item selected! Starting fishSol in: (1), 790, 10
        sleep, 1000
    }
    ToolTip
}

DoStrangeController() {
    global biome

    MouseMove, 45, 521, 3
    sleep 300
    Click, Left
    MouseMove, 1280, 343, 3
    sleep 300
    Click, Left
    MouseMove, 820, 370, 3
    sleep 300
    Click, Left
    Send, Strange Controller
    MouseMove, 850, 485, 3
    sleep 300
    Click, Left            
    MouseMove, 690, 585, 3
    sleep 300
    Click, Left
    sleep 600
    MouseMove, 45, 521, 3
    sleep 300
    Click, Left
    sleep, 600
}

DoBiomeRandomizer() {
    global biome
    MouseMove, 45, 521, 3
    sleep 300
    Click, Left
    MouseMove, 1280, 343, 3
    sleep 300
    Click, Left
    MouseMove, 820, 370, 3
    sleep 300
    Click, Left
    Send, Biome Randomizer
    MouseMove, 850, 485, 3
    sleep 300
    Click, Left            
    MouseMove, 690, 585, 3
    sleep 300
    Click, Left
    sleep 300
    MouseMove, 45, 521, 3
    sleep 300
    Click, Left
    sleep, 600
}

DoAutoUnequip() {
    MouseMove, 45, 412, 3
    sleep 150
    Click, Left
    sleep 150
    MouseMove, 830, 441, 3
    sleep 150
    Click, Left
    sleep 150
    MouseMove, 634, 638, 3
    sleep 159
    Click, Left
    sleep 1200
    Click, Left
    sleep 150
    MouseMove, 1425, 303, 3
    sleep 150
    Click, Left
    sleep 150
}

DoUseNothing() {
    MouseMove, 45, 412, 3
    sleep 150
    Click, Left
    sleep 150
    MouseMove, 820, 340, 3
    sleep, 250
    Click, Left
    sleep, 250
    MouseMove, 820, 370, 3
    sleep 250
    Click, Left
    Send, Nothing
    sleep 150
    MouseMove, 830, 441, 3
    sleep 500
    Send, {WheelUp 100}
    Sleep, 750
    Click, Left
    sleep 300
    MouseMove, 634, 638, 3
    sleep 150
    Click, Left
    sleep 700
    Click, Left
    Sleep, 250
    MouseMove, 1425, 303, 3
    sleep 150
    Click, Left
    sleep 150
}


ManualCraftMovement() {
    Send, {a Down}
    Sleep, 3000
    Send, {a Up}
    Sleep, 50

    Send, {s Down}
    Sleep, 5000
    Send, {s Up}
    Sleep, 50

    Send, {a Down}
    Sleep, 1100
    Send, {a Up}
    Sleep, 200

    Send, {w Down}
    Sleep, 100
    Send, {w Up}
    Sleep, 50

    Send, {Space Down}
    Sleep, 50
    Send, {Space Up}
    Sleep, 50

    Send, {s Down}
    Sleep, 2250
    Send, {s Up}
    Sleep, 50

    Send, {Shift}
    Sleep, 250

    Send, {d Down}
    Sleep, 1800
    Send, {d Up}
    Sleep, 250

    Send, {Shift}
    Sleep, 250

    Send, {a Down}
    Sleep, 380
    Send, {a Up}
    Sleep, 250

    Send, {s Down}
    Sleep, 4400
    Send, {s Up}
    Sleep, 250

    Send, {a Down}
    Sleep, 1465
    Send, {a Up}
    Sleep, 250

    Send, {s Down}
    Sleep, 1800
    Send, {s Up}
    Sleep, 250

    Send, {a Down}
    Sleep, 125
    Send, {a Up}
    Sleep, 250

    Send, {s Down}
    Sleep, 2000
    Send, {s Up}
    Sleep, 250

    Send, {d Down}
    Sleep, 50
    Send, {d Up}
    Sleep, 250

    Send, {Shift}
    Sleep, 250

    Send, {Space Down}
    Sleep, 50
    Send, {Space Up}
    Sleep, 50

    Send, {a Down}
    Sleep, 800
    Send, {a Up}
    Sleep, 250

    Send, {Shift}
    Sleep, 250

    Send, {Space Down}
    Sleep, 50
    Send, {Space Up}
    Sleep, 50

    Send, {a Down}
    Sleep, 2900
    Send, {a Up}
    Sleep, 250

    Send, {s Down}
    Sleep, 2000
    Send, {s Up}
    Sleep, 2000

    Send, {a Down}
    Sleep, 1500
    Send, {a Up}
    Sleep, 250
}

SelectItem:
    Gui, Submit, NoHide
    selectedItem := AutoCraft
return

SelectItem2:
    Gui, Submit, NoHide
    selectedItem2 := ManualCraft
return

ClipType:
    Gui, Submit, NoHide
    clipType := ClipVersion
    IniWrite, %clipType%, %iniFilePath%, Macro, clipType
return

SkipType:
    Gui, Submit, NoHide
    skipType := SkipPotionType
    IniWrite, %skipType%, %iniFilePath%, Macro, skipType
return

CraftHeavenly:
    ToolTip

    if (IfAdded != "Heavenly") {
        IfAdded := "Heavenly"

        MouseMove, 1500, 275, 3
        Sleep, 200
        Click, Left
        Sleep, 200

        Send, ^a
        Sleep, 100
        Send, Heavenly Potion
        Sleep, 200
        Send {Enter}
        Sleep, 200

        MouseMove, 1500, 367, 3
        Sleep, 500
        Click, Left
        Sleep, 200

        MouseMove, 200, 830, 3
        Sleep, 200
        Click, Left
        Sleep, 200
    }

        if (!useCelestial || !useExotic){
            MouseMove, 1023, 437, 3
            Sleep, 200
            Click, Left
            Sleep, 200
            Send, ^a
            Sleep, 200
            Send, 250
            Sleep, 200
            MouseMove, 1130, 437, 3
            Sleep, 1000
            Click, Left
            Sleep, 1000
        }

        if (useCelestial && !useExotic) {
            MouseMove, 1130, 487, 3
            Sleep, 500
            Click, Left
            Sleep, 500
            Click, Left
            Sleep, 500
        }

        if (useExotic && !useCelestial) {
            MouseMove, 1130, 537, 3
            Sleep, 500
            Click, Left
            Sleep, 500
        }

        if (useExotic && useCelestial) {
            MouseMove, 850, 688, 3
            Sleep, 500
            Click, Left
            Sleep, 500
        }

        MouseMove, 1084, 688, 3
        Sleep, 1000
        Click, Left
        sleep, 350
        if (toggle) {
            PixelGetColor, finishcraftcolor, 870, 920, RGB
            if (finishcraftcolor = 0x040F04) {
                totalCraftedhp++
            }
        }
        Sleep, 2500

return

CraftBound:
    ToolTip

    if (IfAdded != "Bounded") {
        IfAdded := "Bounded"

        MouseMove, 1500, 275, 3
        Sleep, 200
        Click, Left
        Sleep, 200

        Send, ^a
        Sleep, 100
        Send, Potion of Bound
        Sleep, 200
        Send {Enter}
        Sleep, 200

        MouseMove, 1500, 367, 3
        Sleep, 500
        Click, Left
        Sleep, 200

        MouseMove, 200, 832, 3
        Sleep, 200
        Click, Left
        Sleep, 200
    }
    If  (!useBounded) {
        MouseMove, 1023, 597, 3
        Sleep, 200
        Click, Left
        Sleep, 200
        Send, ^a
        Sleep, 200
        Send, 100
        Sleep, 200

        MouseMove, 1130, 597, 3
        Sleep, 200
        Click, Left
        sleep, 200
    }

    if (useBounded) {
        MouseMove, 850, 688, 3
        Sleep, 500
        Click, Left
        Sleep, 500
    }

    MouseMove, 1084, 688, 3
    Sleep, 1000
    Click, Left
    sleep, 50
    if (toggle) {
        PixelGetColor, finishcraftcolor, 873, 917, RGB
        if (finishcraftcolor = 0x40FF40) {
            totalCraftedbp++
        }
    }
    Sleep, 2500
return

CraftJewerly:
    ToolTip

    if (IfAdded != "Jewerly") {
        IfAdded := "Jewerly"

        MouseMove, 1500, 275, 3
        Sleep, 200
        Click, Left
        Sleep, 200

        Send, ^a
        Sleep, 100
        Send, Jewelry Potion
        Sleep, 200
        Send {Enter}
        Sleep, 200

        MouseMove, 1500, 367, 3
        Sleep, 500
        Click, Left
        Sleep, 200

        MouseMove, 200, 832, 3
        Sleep, 200
        Click, Left
        Sleep, 200
    }

    MouseMove, 850, 688, 3
    Sleep, 500
    Click, Left
    Sleep, 2000
    MouseMove, 1084, 688, 3
    Sleep, 1000
    Click, Left
    sleep, 50
    if (toggle) {
        PixelGetColor, finishcraftcolor, 873, 917, RGB
        if (finishcraftcolor = 0x40FF40) {
            totalCraftedjp++
        }
    }
    Sleep, 1000

return

CraftZombie:
    ToolTip

    if (IfAdded != "Zombie") {
        IfAdded := "Zombie"

        MouseMove, 1500, 275, 3
        Sleep, 200
        Click, Left
        Sleep, 200

        Send, ^a
        Sleep, 100
        Send, Zombie Potion
        Sleep, 200
        Send {Enter}
        Sleep, 200

        MouseMove, 1500, 367, 3
        Sleep, 500
        Click, Left
        Sleep, 200

        MouseMove, 200, 832, 3
        Sleep, 200
        Click, Left
        Sleep, 200
    }

    MouseMove, 850, 688, 3
    Sleep, 500
    Click, Left
    Sleep, 2000

    MouseMove, 1084, 688, 3
    Sleep, 1000
    Click, Left
    sleep, 350
    if (toggle) {
        PixelGetColor, finishcraftcolor, 846, 919, RGB
        if (finishcraftcolor = 0x092509) {
            totalCraftedzp++
        }
    }
    Sleep, 1000

return

CraftRage:
    ToolTip

    if (IfAdded != "Rage") {
        IfAdded := "Rage"

        MouseMove, 1500, 275, 3
        Sleep, 200
        Click, Left
        Sleep, 200

        Send, ^a
        Sleep, 100
        Send, Rage Potion
        Sleep, 200
        Send {Enter}
        Sleep, 200

        MouseMove, 1500, 367, 3
        Sleep, 500
        Click, Left
        Sleep, 200

        MouseMove, 200, 832, 3
        Sleep, 200
        Click, Left
        Sleep, 200
    }

    MouseMove, 850, 688, 3
    Sleep, 250
    Click, Left
    Sleep, 750

    MouseMove, 1084, 688, 3
    Sleep, 400
    Click, Left
    sleep, 350
    if (toggle) {
        PixelGetColor, finishcraftcolor, 872, 917, RGB
        if (finishcraftcolor = 0x228822) {
           totalCraftedrp++
        }
    }
    Sleep, 400

return

CraftDiver:
    ToolTip
    if (IfAdded != "Diver") {
        IfAdded := "Diver"

        MouseMove, 1500, 275, 3
        Sleep, 200
        Click, Left
        Sleep, 200
        Send, ^a
        Sleep, 100
        Send, Diver Potion
        Sleep, 200
        Send {Enter}
        Sleep, 200
        MouseMove, 1500, 367, 3
        Sleep, 500
        Click, Left
        Sleep, 200
        MouseMove, 200, 832, 3
        Sleep, 200
        Click, Left
        Sleep, 200
    }

    MouseMove, 850, 688, 3
    Sleep, 250
    Click, Left
    Sleep, 750
    MouseMove, 1084, 688, 3
    Sleep, 400
    Click, Left
    sleep, 350
    if (toggle) {
        PixelGetColor, finishcraftcolor, 873, 917, RGB
        if (finishcraftcolor = 0x40FF40) {
            totalCrafteddip++
        }
    }
    Sleep, 2000

return


CraftSelected:

    if (selectedItem = "Heavenly Potion") {
        Gosub, CraftHeavenly
    } else if (selectedItem = "Bound Potion") {
        Gosub, CraftBound
    } else if (selectedItem = "Jewelry Potion") {
        Gosub, CraftJewerly
    } else if (selectedItem = "Zombie Potion") {
        Gosub, CraftZombie
    } else if (selectedItem = "Rage Potion") {
        Gosub, CraftRage
    } else if (selectedItem = "Diver Potion") {
        Gosub, CraftDiver
    }
return

EnsureFullscreen() {
    WinActivate, ahk_exe RobloxPlayerBeta.exe
    sleep, 250
    PixelGetColor, robloxicon, 42, 41, RGB
    if (robloxicon != 0xF7F7F8) {
        Send, {F11}
        Sleep, 1000
    }
}

CheckGhostServer() {

    SendWebhook("Checking for ghost server...", 0)
    ToolTip, Checking for ghost server... , 900, 10
    Send, {Esc}
    Sleep, 650
    Send, R
    Sleep, 650
    Send, {Enter}
    sleep 10000
    EnsureFullscreen()
    sleep, 5000
    MouseMove, 34, 678, 3
    Sleep, 300
    Click, Left
    sleep, 2000
    PixelGetColor, ghostColor, 980, 735, RGB
    PixelGetColor, ghostColor2, 994, 440, RGB
    if (ghostColor != 0xFFFFFF && ghostColor2 != 0xFFF49D) {
        RunRejoin()
    } else {
        MouseMove, 34, 678, 3
        Sleep, 300
        Click, Left
        sleep, 500
        sleep, 1000
        MouseMove, 47, 467, 3
        sleep 220
        Click, Left
        sleep 220
        MouseMove, 382, 126, 3
        sleep 220
        Click, Left
        sleep 220
        Click, WheelUp 80
        sleep 500
        Click, WheelDown 45
        sleep 300
        ToolTip, Going to fishing spot.., 900, 10
        SendWebhook("Going to fishing spot... Not in Ghost Server.", 0)
        FishingSpot()
    }
    ToolTip
}

RunRejoin() {
    SendWebhook("Rejoining Server link...", 0)
    Process, Close, RobloxPlayerBeta.exe
    sleep 2000
    Run, % "powershell -NoProfile -Command ""Start-Process '" . privateServerLink . "'"""
    sleep 15000s
    WinActivate, ahk_exe RobloxPlayerBeta.exe
    sleep 5000
    EnsureFullScreen()
    sleep, 15000
    MouseMove, 251, 997, 3
    Sleep, 300
    Click, Left
    sleep, 5000
    Click, Left
    sleep, 500
    sleep, 1000
    MouseMove, 47, 467, 3
    sleep 220
    Click, Left
    sleep 220
    MouseMove, 382, 126, 3
    sleep 220
    Click, Left
    sleep 220
    Click, WheelUp 80
    sleep 500
    Click, WheelDown 45
    sleep 300
    MouseMove, 600, 600, 3
    Click, Left
    sleep 500
    ToolTip, Going to fishing spot.., 900, 10
    SendWebhook("Going to fishing spot...", 0)
    FishingSpot()
}
RunRejoin2() {
    Process, Close, RobloxPlayerBeta.exe
    SendWebhook("Rejoining Server link...", 0)
    Run, % "powershell -NoProfile -Command ""Start-Process '" . privateServerLink . "'"""
}
FishingSpot() {
    global keyW, keyA
    keyW := azertyPathing ? "z" : "w"
    keyA := azertyPathing ? "q" : "a"
    Send, {%keyW% Down}
    Send, {%keyA% Down}
    sleep 4150
    Send, {%keyW% Up}
    sleep 600
    Send {%keyA% Up}
    sleep 200
    Send {%keyW% Down}
    sleep 400
    Send {%keyW% Up}
    sleep 300
    Send {d Down}
    sleep 180
    Send {d Up}
    sleep 150
    Send {%keyW% Down}
    sleep 1100
    Send {%keyW% Up}
    sleep 300
    Send {s Down}
    sleep 300
    Send {S Up}
    sleep 300
    Send {Space Down}
    sleep 25
    Send {%keyW% Down}
    sleep 1300
    Send {Space Up}
    sleep 200
    Send {%keyW% Up}
    sleep 300
    Send, {Shift Down}
    Sleep, 300
    Send, {Shift Up}
    Sleep, 300
    sleep 200
    Send, {%keyA% Down}
    sleep 1400
    Send, {%keyA% Up}
    sleep 75
    Send, {%keyW% Down}
    sleep 2670
    Send, {%keyW% Up}
}

CraftSelected2:

    if (selectedItem2 = "Heavenly Potion") {
        Gosub, CraftHeavenly
        IfAdded := ""
    } else if (selectedItem2 = "Bound Potion") {
        Gosub, CraftBound
        IfAdded := ""
    } else if (selectedItem2 = "Jewelry Potion") {
        Gosub, CraftJewerly
        IfAdded := ""
    } else if (selectedItem2 = "Zombie Potion") {
        Gosub, CraftZombie
        IfAdded := ""
    } else if (selectedItem2 = "Rage Potion") {
        Gosub, CraftRage
        IfAdded := ""
    } else if (selectedItem2 = "Diver Potion") {
        Gosub, CraftDiver
        IfAdded := ""
    }
return

StartAutoClicker:
    Gui, Submit, NoHide

    if (autoClicker)
        return

    autoClicker := true

    GuiControl, Disable, AutoClickStart
    GuiControl, Enable, AutoClickStop
    GuiControl,, AutoClickerStatus, ON
    GuiControl, +c0x00DD00, AutoClickerStatus

    autoClickDelayMS := AutoClickDelay * 1000
    SetTimer, AutoClickTick, %autoClickDelayMS%
return

StopAutoClicker:
    autoClicker := false

    SetTimer, AutoClickTick, Off

    GuiControl, Enable, AutoClickStart
    GuiControl, Disable, AutoClickStop
    GuiControl,, AutoClickerStatus, OFF
    GuiControl, +c0xFF4444, AutoClickerStatus
return

AutoClickTick:
    Click
return

UpdateGUI:
if (toggle) {
    GuiControl,, StatusText, Running
    GuiControl, +c0x00DD00, StatusText
    GuiControl,, ResStatusText, Active - %res%
} else {
    GuiControl,, StatusText, Stopped
    GuiControl, +c0xFF4444, StatusText
    GuiControl,, ResStatusText, Ready
}
return


ManualGUIUpdate() {
    if (toggle) {
        GuiControl,, StatusText, Running
        GuiControl, +c0x00DD00, StatusText
        GuiControl,, ResStatusText, Active - %res%
    } else {
        GuiControl,, StatusText, Stopped
        GuiControl, +c0xFF4444, StatusText
        GuiControl,, ResStatusText, Ready
    }
}

F1::
    if (manualCraft && selectedItem2 = "") {
        ManualCraftAlert()
    }

    if (!res) {
        res := "1080p"
    }
    if (!toggle && offsides != true) {
        Gui, Submit, nohide
        if (MaxLoopInput > 0) {
            maxLoopCount := MaxLoopInput
        }
        if (FishingLoopInput > 0) {
            fishingLoopCount := FishingLoopInput
        }
        toggle := true
        strangeControllerLastRun := 0
        biomeRandomizerLastRun := 0
        checkGhostServerLastRun := 0

        if (startTick = "") {
            startTick := A_TickCount
        }
        if (cycleCount = "") {
            cycleCount := 0
        }
        strangeControllerLastRun := 0
        biomeRandomizerLastRun := 0
        checkGhostServerLastRun := 0
        IniWrite, %selectedItem2%, %iniFilePath%, Macro, selectedItem2
        IniWrite, %res%, %iniFilePath%, Macro, resolution
        IniWrite, %maxLoopCount%, %iniFilePath%, Macro, maxLoopCount
        IniWrite, %fishingLoopCount%, %iniFilePath%, Macro, fishingLoopCount
        WinActivate, ahk_exe RobloxPlayerBeta.exe
        ManualGUIUpdate()
        EnsureFullscreen()
        SetTimer, UpdateGUI, 1000
        WinClose, %ahkPath% ahk_class AutoHotkey
        if (res = "1080p") {
            SetTimer, DoMouseMove, 100
        }
    }
    try SendWebhook(":green_circle: Macro Started!", "7909721")
return


F2::
    Gui, Submit, NoHide

    if (autocrafting || toggle)
        return

    if (selectedItem = "") {
        ToolTip, Please Select Item To Craft!, 900, 10
        Sleep, 2500
        ToolTip
        return
    }

    IniWrite, %selectedItem%, %iniFilePath%, Macro, selectedItem
    autocrafting := true

    EnsureFullscreen()
    ToolTip, Crafting will start in 5 seconds..., 900, 10
    Sleep, 1000
    ToolTip, Crafting will start in 4 seconds..., 900, 10
    Sleep, 1000
    ToolTip, Crafting will start in 3 seconds..., 900, 10
    Sleep, 1000
    ToolTip, Crafting will start in 2 seconds..., 900, 10
    Sleep, 1000
    ToolTip, Crafting will start in 1 second..., 900, 10
    Sleep, 1000
    ToolTip
    try SendWebhook("Crafting Started on " selectedItem ":tools:", 0)

    SetTimer, CraftSelected, 1000
return

F3::
    Send, {w up}
    Send, {a up}
    Send, {s up}
    Send, {d up}
    Send, {space up}
    Send, {e up}
    Send, {esc up}
    Send, {r up}
    if (toggle) {
        try SendWebhook(":red_circle: Macro Stopped.", "0")
    } else if (autocrafting) {
        try SendWebhook(":red_circle: Auto Crafting Stopped.", "0")
    }
    Reload
return

F4::
global blehblehbleh, webResponse, auraName

    blehblehbleh := "hehe"
    webResponse := true

        if (detectGlobal || detectTrans && auraDetection) {
            SetTimer, V2Clip, Off
            SetTimer, AuraBiomeDetect, Off
        if (clipWebhook && AuraList.HasKey(auraName) && brainrot67 = "67") {
                try SendWebhook(auraName " Clip Canceled.",  14495300)
        }
        ToolTip, Detection Restarting in 2 Seconds..., 870, 10
        sleep, 1000
        ToolTip, Detection Restarting in 1 Seconds..., 870, 10
        sleep, 1000
        ToolTip
        SetTimer, AuraBiomeDetect, 1000
    }
return

F7::
global auraName, biome
    try SendWebhook(auraName,  0)
    try SendWebhook(biome,  0)
return

F5::
    cancelRareBiomeWebhook := true
return

F6::
    RunRejoin2()
return

;1080p
DoMouseMove:
if (toggle) {
    global pathingMode
    global privateServerLink
    global azertyPathing
    global autoUnequip
    global useNothing
    global autoCloseChat
    global strangeController
    global biomeRandomizer
    global strangeControllerTime
    global biomeRandomizerTime
    global strangeControllerInterval
    global biomeRandomizerInterval
    global strangeControllerLastRun
    global biomeRandomizerLastRun
    global manualCraft
    global pendingCraft
    global pendingUnequip
    global biome
    global biomeWebhook
    loopCount := 0
    keyW := azertyPathing ? "z" : "w"
    keyA := azertyPathing ? "q" : "a"
    Loop {
        restartPathing := false
        if (!toggle) {
            break
        }

        if (autoWarp && pendingSkips) {
            if (skipType = "Warp Potion") {
                SendWebhook("Popping Warp Potion", 0)
            } else {
                SendWebhook ("Popping Transcendent Potion")
            }
            PopSkips()
            pendingSkips := false
        }

        if (checkGhostServer && privateServerLink != "") {
                elapsed := A_TickCount - startTick
                if ((checkGhostServerlastRun = 0 && elapsed >= strangeControllerTime) || (checkGhostServerlastRun > 0 && (elapsed - checkGhostServerlastRun) >= checkGhostServerInterval)) {
                    CheckGhostServer()
                    sleep, 1000
                    checkGhostServerlastRun := elapsed
                }
            } else if (checkGhostServer && privateServerLink = "") {
                SendWebhook3("NO PRIVATE SERVER LINK", 14495300)
            }
        

        if (strangeController) {
                    elapsed := A_TickCount - startTick
                    if ((strangeControllerLastRun = 0 && elapsed >= strangeControllerTime && biome != "CORRUPTION") || (strangeControllerLastRun > 0 && (elapsed - strangeControllerLastRun) >= strangeControllerInterval && biome != "CORRUPTION")) {
                        DoStrangeController()
                        sleep, 1000
                        strangeControllerLastRun := elapsed
                    } else if ((strangeControllerLastRun = 0 && elapsed >= strangeControllerTime && biome = "CORRUPTION") || (strangeControllerLastRun > 0 && (elapsed - strangeControllerLastRun) >= strangeControllerInterval && biome = "CORRUPTION")) {
                    strangeControllerLastRun := elapsed
                }
            }

        if (biomeRandomizer) {
                    elapsed := A_TickCount - startTick
                    if ((biomeRandomizerLastRun = 0 && elapsed >= biomeRandomizerTime && biome != "CORRUPTION") || (biomeRandomizerLastRun > 0 && (elapsed - biomeRandomizerLastRun) >= biomeRandomizerInterval && biome != "CORRUPTION")) {
                        DoBiomeRandomizer()
                        biomeRandomizerLastRun := elapsed
                    } else if ((biomeRandomizerLastRun = 0 && elapsed >= biomeRandomizerTime && biome = "CORRUPTION") || (biomeRandomizerLastRun > 0 && (elapsed - biomeRandomizerLastRun) >= biomeRandomizerInterval && biome = "CORRUPTION")) {
                    biomeRandomizerLastRun := elapsed
                }
            }

            if (pendingUnequip = true) {
                sleep, 1000
                if (useNothing && autoUnequip) {
                DoUseNothing()
                } else if (autoUnequip && !useNothing) {
                    DoAutoUnequip()
                }
                pendingUnequip := false
            }

        PixelGetColor, deletebutton, 1106, 919, RGB
        if (deletebutton = 0xFF5A5D) {
                try SendWebhook3("Max Storage Detected \nDisabling Macro", 0)
            Reload
        }
        

        if (pendingCraft && manualCraft && selectedItem2 != "") {

            sleep, 1000
            MouseMove, 47, 467, 3
            sleep 220
            Click, Left
            sleep 220
            MouseMove, 382, 126, 3
            sleep 220
            Click, Left
            sleep 220
            Click, WheelUp 80
            sleep 500
            Click, WheelDown 45
            sleep 300

            Send, {Esc}
            Sleep, 650
            Send, R
            Sleep, 650
            Send, {Enter}
            sleep 3000
            
            ManualCraftMovement()
            Sleep, 500
            Send, f
            Sleep, 1500
            Gosub, CraftSelected2
            Sleep, 1000
            
            MouseMove, 850, 688, 3
            Sleep, 500
            Click, Left
            Sleep, 500

            Send, {Esc}
            Sleep, 650
            Send, R
            Sleep, 650
            Send, {Enter}
            sleep 3000
            pendingCraft := false

            Send, {w Down}
            Sleep, 6950
            Send, {w Up}
        }

        loopCount++
        if (loopCount > maxLoopCount) {
        sleep, 1000
        Send, {Esc}
        Sleep, 650
        Send, R
        Sleep, 650
        Send, {Enter}
        sleep 5000  


        if (autoCloseChat) {
            PixelGetColor, chatcolor, 138, 40, RGB
            if (chatcolor != 0x121215) {
                Send, {Esc}
                Sleep, 300
                MouseMove, 800, 210, 3
                Sleep, 300
                Click, Left
                MouseMove, 800, 460, 3
                Sleep, 300
                Click, WheelUp, 25
                Sleep, 600
                Click, WheelDown, 2
                MouseMove, 1280, 720, 3
                Sleep, 300
                Click, Left
                Sleep, 300
                Send, {Esc}
                Sleep, 1000
            }

            PixelGetColor, chatcolor2, 138, 40, RGB
            if (chatcolor2 = 0xF7F7F8) {
                Sleep, 300
                MouseMove, 145, 40, 3
                Sleep, 300
                MouseClick, Left
                Sleep, 300
            } else if (chatcolor2 = 0x121215) {
                Sleep, 300
            }
        }

        sleep, 1000
        MouseMove, 47, 467, 3
        sleep 220
        Click, Left
        sleep 220
        MouseMove, 382, 126, 3
        sleep 220
        Click, Left
        sleep 220
        Click, WheelUp 80
        sleep 500
        Click, WheelDown 45

        if (manualCraft && selectedItem2 != "") {
            sleep, 1000
            ManualCraftMovement()
            Sleep, 500
            Send, f
            Sleep, 1000
        if (potionCraftCount > 0) {
                Loop {
                    Gosub, CraftSelected2
                    Sleep, 1000
                    potionCraftCount--
                    if (potionCraftCount <= 0) {
                        potionCraftCount := potionCraftCount2
                        break
                    }
                }
            }

                if (selectedItem2 = "Heavenly Potion") {
                    SendWebhook( selectedItem2 " has been crafted " totalCraftedhp " times", 0)
                } else if (selectedItem2 = "Bound Potion") {
                    SendWebhook( selectedItem2 " has been crafted " totalCraftedbp " times", 0)
                } else if (selectedItem2 = "Jewelry Potion") {
                    SendWebhook( selectedItem2 " has been crafted " totalCraftedjp " times", 0)
                } else if (selectedItem2 = "Zombie Potion") {
                    SendWebhook( selectedItem2 " has been crafted " totalCraftedzp " times", 0)
                } else if (selectedItem2 = "Rage Potion") {
                    SendWebhook( selectedItem2 " has been crafted " totalCraftedrp " times", 0)
                } else if (selectedItem2 = "Diver Potion") {
                    SendWebhook( selectedItem2 " has been crafted " totalCrafteddip " times", 0)
                }

                totalCraftedhp := 0
                totalCraftedbp := 0
                totalCraftedrp := 0
                totalCrafteddp := 0
                totalCrafteddip := 0
                totalCraftedzp := 0
                totalCraftedjp := 0

                if (detectPotion) {
                    MouseMove, 850, 688, 3
                    Sleep, 500
                    Click, Left
                    Sleep, 500
                }

                Send, {Esc}
                Sleep, 650
                Send, R
                Sleep, 650
                Send, {Enter}
                sleep 3000
                MouseMove, 47, 467, 3
                sleep 220
                Click, Left
                sleep 220
                MouseMove, 382, 126, 3
                sleep 220
                Click, Left
                sleep 220
                Click, WheelUp 80
                sleep 500
                Click, WheelDown 45
                sleep 300
            }




        if (pathingMode = "Vip Pathing") {
            ; VIP Pathing
            Send, {%keyW% Down}
            Send, {%keyA% Down}
            sleep 4150
            Send, {%keyW% Up}
            sleep 600
            Send {%keyA% Up}
            sleep 200
            Send {%keyW% Down}
            sleep 400
            Send {%keyW% Up}
            sleep 300
            Send {d Down}
            sleep 180
            Send {d Up}
            sleep 150
            Send {%keyW% Down}
            sleep 1100
            Send {%keyW% Up}
            sleep 300
            Send {s Down}
            sleep 300
            Send {S Up}
            sleep 300
            Send {Space Down}
            sleep 25
            Send {%keyW% Down}
            sleep 1300
            Send {Space Up}
            sleep 200
            Send {%keyW% Up}
            sleep 300
            Send, {Shift Down}
            Sleep, 300
            Send, {Shift Up}
            Sleep, 300
            Send {e Down}
            sleep 300
            Send {e Up}
            sleep 300
            MouseMove, 956, 803, 3
            sleep 50
            MouseClick, Left
            sleep 50
            MouseClick, Left
            sleep 200
            MouseMove, 956, 938, 3
            sleep 200
            MouseClick, Left
            sleep 800
            loopCount := 0

            while (loopCount < fishingLoopCount) {
                MouseMove, 828, 404, 3
                sleep 200
                MouseClick, Left
                sleep 200
                if (sellAllToggle) {
                    MouseMove, 680, 804, 3
                } else {
                    MouseMove, 512, 804, 3
                }
                sleep 200
                MouseClick, Left
                sleep 300
                MouseMove, 801, 626, 3
                sleep 200
                MouseClick, Left
                sleep 1000
                loopCount++
            }

            MouseMove, 1458, 266, 3
            sleep 200
            MouseClick, Left
            sleep 200
            Send, {%keyA% Down}
            sleep 1400
            Send, {%keyA% Up}
            sleep 75
            Send, {%keyW% Down}
            sleep 2692
            Send, {%keyW% Up}
            loopCount := 0
        }
     }
 

        MouseMove, 862, 843, 3
        Sleep 300
        MouseClick, Left
        sleep 300
        barColor := 0
        otherBarColor := 0

        ; Check for white pixel
        startWhitePixelSearch := A_TickCount
        fishingFailsafeRan := false
        Loop {
        PixelGetColor, color, 1176, 836, RGB
        if (color = 0xFFFFFF) {
        MouseMove, 950, 880, 3
        ; Get randomized bar color
        Sleep 50
        PixelGetColor, barColor, 955, 767, RGB
        SetTimer, DoMouseMove, Off
        break
        }
        
        if (!toggle) {
        Return
        }
        }

        if (A_TickCount - startWhitePixelSearch > (31000) && !fishingFailsafeRan) {
            MouseMove, 1368, 950, 3
            sleep 300
            MouseClick, Left
            sleep 300
            MouseMove, 1167, 476, 3
            sleep 300
            MouseClick, Left
            sleep 300
            MouseMove, 1113, 342, 3
            sleep 300
            MouseClick, left
            sleep 300
            MouseMove, 851, 832, 3
            sleep 300
            MouseClick, Left
            fishingFailsafeRan := true
            try SendWebhook3(":grey_question: Fishing failsafe was triggered.", "13424349")
        }

        ; PixelSearch loop with 9-second timeout
        startTime := A_TickCount
        Loop {
        if (!toggle)
        break
        if (A_TickCount - startTime > 9000)
        break

        ; Advanced detection
        if (advancedFishingDetection) {
            ErrorLevel := 0
            PixelSearch, leftX, leftY, 757, 767, 1161, 767, barColor, 5, Fast RGB
            if (ErrorLevel = 0) {
                rightX := leftX
                Loop {
                    testX := rightX + 1
                    if (testX > 1161)
                        break
                    PixelGetColor, testColor, %testX%, 767, RGB
                    if (Abs((testColor & 0xFF) - (barColor & 0xFF)) <= 10 && Abs(((testColor >> 8) & 0xFF) - ((barColor >> 8) & 0xFF)) <= 10 && Abs(((testColor >> 16) & 0xFF) - ((barColor >> 16) & 0xFF)) <= 10) {
                        rightX := testX
                    } else {
                        break
                    }
                }
                barWidth := rightX - leftX
                if (barWidth < advancedFishingThreshold) {
                    MouseClick, left
                    sleep 25
                }
            } else {
                MouseClick, left
            }
            sleep 10
        } else {
            ErrorLevel := 0
            PixelSearch, FoundX, FoundY, 757, 762, 1161, 782, barColor, 5, Fast RGB
            if (ErrorLevel = 0) {
            } else {
                MouseClick, left
            }
        }
        }
        sleep 300
        MouseMove, 1113, 342, 3
        Sleep 700
        MouseClick, Left
        sleep 300
        cycleCount++
    }
}
Return




StartScript:
    if (!toggle) {
        Gui, Submit, nohide
        if (MaxLoopInput > 0) {
            maxLoopCount := MaxLoopInput
        }
        if (FishingLoopInput > 0) {
            fishingLoopCount := FishingLoopInput
        }
        toggle := true
        if (startTick = "") {
            startTick := A_TickCount
        }
        if (cycleCount = "") {
            cycleCount := 0
        }
        WinActivate, ahk_exe RobloxPlayerBeta.exe
        ManualGUIUpdate()
        SetTimer, UpdateGUI, 1000
        if (res = "1080p") {
            SetTimer, DoMouseMove, 100
        }
        try SendWebhook(":green_circle: Macro Started!", "7909721")
    }
return

StartScript(res) {
    if (!toggle) {
        Gui, Submit, nohide
        if (MaxLoopInput > 0) {
            maxLoopCount := MaxLoopInput
        }
        if (FishingLoopInput > 0) {
            fishingLoopCount := FishingLoopInput
        }
        toggle := true
        if (startTick = "") {
            startTick := A_TickCount
        }
        if (cycleCount = "") {
            cycleCount := 0
        }
        WinActivate, ahk_exe RobloxPlayerBeta.exe
        ManualGUIUpdate()
        SetTimer, UpdateGUI, 1000
        if (res = "1080p") {
            SetTimer, DoMouseMove, 100
        }
        try SendWebhook(":green_circle: Macro Started!", "7909721")
        }
    }
return


PauseScript:
    toggle := false
    firstLoop := true
    SetTimer, DoMouseMove, Off
    SetTimer, UpdateGUI, Off
    ManualGUIUpdate()
    ToolTip
return

CloseScript:
    try SendWebhook(":red_circle: Macro Stopped.", "14495300")
    Reload
return

SelectRes:
    Gui, Submit, nohide
    res := Resolution
    IniWrite, %res%, %iniFilePath%, Macro, resolution
    ManualGUIUpdate()
return

SelectPathing:
    Gui, Submit, nohide
    IniWrite, %PathingMode%, %iniFilePath%, Macro, pathingMode
    pathingMode := PathingMode
return

Dev1NameClick:
if (dev1_name = "cresqnt") {
    Run, https://cresqnt.com
}
return

Dev1LinkClick:
if (dev1_name = "maxstellar") {
    Run, https://www.twitch.tv/maxstellar
} else if (dev1_name = "cresqnt") {
    Run, https://scopedevelopment.tech
} else if (dev1_name = "ivelchampion249") {
    Run, https://www.youtube.com/@ivelchampion
}
return

Dev2NameClick:
if (dev2_name = "cresqnt") {
    Run, https://cresqnt.com
}
return

Dev2LinkClick:
if (dev2_name = "maxstellar") {
    Run, https://www.twitch.tv/maxstellar
} else if (dev2_name = "cresqnt") {
    Run, https://scopedevelopment.tech
} else if (dev2_name = "ivelchampion249") {
    Run, https://www.youtube.com/@ivelchampion
}
return

Dev3NameClick:
if (dev3_name = "cresqnt") {
    Run, https://cresqnt.com
}
return

Dev3LinkClick:
if (dev3_name = "maxstellar") {
    Run, https://www.twitch.tv/maxstellar
} else if (dev3_name = "cresqnt") {
    Run, https://scopedevelopment.tech
} else if (dev3_name = "ivelchampion249") {
    Run, https://www.youtube.com/@ivelchampion
}
return

PressE:
    Send, e
Return

MerchantClick2:
    Click, 1265, 943, 3
Return

ReleasesClick:
    Run, https://github.com/knowaery/Aery-s-Fishsol
return
