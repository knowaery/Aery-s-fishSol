;#Requires AutoHotkey v1.1

#NoEnv
#SingleInstance Force
BatchLine_Default := A_BatchLines
SetBatchLines, -1
EnvGet, LocalAppData, LOCALAPPDATA
SetWorkingDir %A_ScriptDir%
CoordMode, Mouse, Screen
CoordMode, Pixel, Screen
iconFilePath := A_ScriptDir "\img\icon.ico"

/* Put settings & AuraList into LocalAppData
fishSolFilePath := LocalAppData . "\Aery's fishSol"
FileCreateDir, %fishSolFilePath%
fishSolSettingsFilePath := fishSolFilePath . "\settings.ini"
fishSolAuraFilePath := fishSolFilePath . "\AuraList.ini"
*/

fishSolSettingsFilePath := A_ScriptDir "\settings.ini"
fishSolAuraFilePath := A_ScriptDir "\AuraList.ini"

if (FileExist(iconFilePath)) {
    Menu, Tray, Icon, %iconFilePath%
}

AurasURL := "https://raw.githubusercontent.com/knowaery/Aery-s-fishSol/main/AuraList.ini"
try {
    UrlDownloadToFile, %AurasURL%, %fishSolAuraFilePath%
} catch {
    if !FileExist(fishSolAuraFilePath) {
        MsgBox, 16, Error, Failed to download Auras and no local backup exists. Please download the Aura List from https://github.com/knowaery/Aery-s-fishSol/releases and place it into the backup folder.
        BackupAurasURL := "\backup\AuraList.ini"
        if FileExist(BackupAurasURL) {
            FileCopy, %BackupAurasURL%, %fishSolAuraFilePath%
        }
    }
}

IniRead, AuraListOrderRaw, %fishSolAuraFilePath%, AuraListOrder, Order
IniRead, AuraListTransOrderRaw, %fishSolAuraFilePath%, AuraListTransOrder, Order
AuraListOrder := StrSplit(AuraListOrderRaw, ",")
AuraListTransOrder := StrSplit(AuraListTransOrderRaw, ",")
AuraList := {}
for i, aura in AuraListOrder
    AuraList[aura] := 1

AuraListTrans := {}
for i, aura in AuraListTransOrder
    AuraListTrans[aura] := 1

EnabledAuras := {}
for i, aura in AuraListOrder
    EnabledAuras[aura] := 1

auracolor := 0
if (biomeData = "") {
    biomeData := {}
    biomeData["NORMAL"]       := {color: 0,         thumbnail: "https://cdn.mongoosee.com/assets/biomes/NORMAL.png"}
    biomeData["WINDY"]        := {color: 10150399,  thumbnail: "https://cdn.mongoosee.com/assets/biomes/WINDY.png"}
    biomeData["RAINY"]        := {color: 163773,    thumbnail: "https://cdn.mongoosee.com/assets/biomes/RAINY.png"}
    biomeData["SNOWY"]        := {color: 14479353,  thumbnail: "https://cdn.mongoosee.com/assets/biomes/SNOWY.png"}
    biomeData["SAND STORM"]   := {color: 9401431,   thumbnail: "https://cdn.mongoosee.com/assets/biomes/SAND%20STORM.png"}
    biomeData["HELL"]         := {color: 16730905,  thumbnail: "https://cdn.mongoosee.com/assets/biomes/HELL.png"}
    biomeData["STARFALL"]     := {color: 72375,     thumbnail: "https://cdn.mongoosee.com/assets/biomes/STARFALL.png"}
    biomeData["CORRUPTION"]   := {color: 7155368,   thumbnail: "https://cdn.mongoosee.com/assets/biomes/CORRUPTION.png"}
    biomeData["NULL"]         := {color: 8618883,   thumbnail: "https://cdn.mongoosee.com/assets/biomes/NULL.png"}
    biomeData["GLITCHED"]     := {color: 12582656,  thumbnail: "https://cdn.mongoosee.com/assets/biomes/GLITCHED.png"}
    biomeData["DREAMSPACE"]   := {color: 15376858,  thumbnail: "https://cdn.mongoosee.com/assets/biomes/DREAMSPACE.png"}
    biomeData["HEAVEN"]       := {color: 16769184,  thumbnail: "https://cdn.mongoosee.com/assets/biomes/HEAVEN.png"}
    biomeData["CYBERSPACE"]   := {color: 663101,    thumbnail: "https://cdn.mongoosee.com/assets/biomes/CYBERSPACE.png"}
    biomeData["SINGULARITY"]  := {color: 13582371,  thumbnail: "https://cdn.mongoosee.com/assets/biomes/SINGULARITY.png"}
    biomeData["BLAZING SUN"]  := {color: 16106050,  thumbnail: "https://cdn.mongoosee.com/assets/biomes/BLAZING%20SUN.png"}
    biomeData["AURORA"]       := {color: 9065205, thumbnail: "https://cdn.mongoosee.com/assets/biomes/AURORA.png"}
    biomeData["GRAVEYARD"]    := {color: 0, thumbnail: "https://cdn.mongoosee.com/assets/biomes/GRAVEYARD.png"}
    biomeData["PUMPKIN MOON"] := {color: 0, thumbnail: "https://cdn.mongoosee.com/assets/biomes/PUMPKIN%20MOON.png"}
    biomeData["BLOOD RAIN"]   := {color: 0, thumbnail: "https://cdn.mongoosee.com/assets/biomes/BLOOD%20RAIN.png"}
}

ROBLOX_LOGS := LocalAppData "\Roblox\logs\*.log"
res := "1080p"
maxLoopCount := 30
fishingLoopCount := 15
advancedFishingDetection := false
pathingMode := "Vip Pathing"
azertyPathing := false
autoUnequip := false
strangeController := false
biomeRandomizer := false
biomeSelector := false
selectedBiome := "Windy"
strangeControllerTime := 0
biomeRandomizerTime := 300000
biomeSelectorTime := 1000
strangeControllerInterval := 1260000
biomeRandomizerInterval := 2160000
elapsed := 0
strangeControllerLastRun := 0
biomeRandomizerLastRun := 0
biomeSelectorLastRun := 0
privateServerLink := ""
globalFailsafeTimer := 0
fishingFailsafeTime := 31
autoRejoinFailsafeTime := 320
advancedFishingThreshold := 25
webhookURL := ""
prevBiome := "None"
prevState := "None"
currentBiome := "None"
sentstoragefull := false
triggerDelayGlobal := 10000
triggerDelayTrans := 20000
auraDetection := false
detectGlobal := false
detectTrans := false
clipWebhook := false
clipWebhookPing := false
globalTranscendentPing := false
useCelestial := false
useExotic := false
useBounded := false
auraFilter := false
checkGhostServer := false
biomeDetect := false
restartMacroFailsafe := false
useNothing := false
autoWarp := false
webhookID := ""
biomeIndex := 0
potionCraftCount := 1
selectedItem := "Heavenly Potion"
selectedItem2 := "Heavenly Potion"
autoClicker := false
biomeSelectorInterval := 3660000
failsafeTime := 0
fishInLimbo := false
decideAuraClip := false
limboFailsafe := false
pscode := ""
ClipType := "Nvidia: Alt + F10"
SkipType := "Warp Potion"
CloseCollectionType := "Click"
activationMessage := false
biomeItemMessage := false
failsafeMessage := false
failsafeMessagePing := false
restartMacroFailsafePing := false
restartMacroFailsafeTriggers := 0
ping4Aura := true

if (FileExist(fishSolSettingsFilePath)) {
        IniRead, tempRes, %fishSolSettingsFilePath%, Macro, resolution
    if (tempRes != "ERROR")
    {
        res := tempRes
    }
    IniRead, tempMaxLoop, %fishSolSettingsFilePath%, Macro, maxLoopCount
    if (tempMaxLoop != "ERROR" && tempMaxLoop > 0)
    {
        maxLoopCount := tempMaxLoop
    }
    IniRead, tempFishingLoop, %fishSolSettingsFilePath%, Macro, fishingLoopCount
    if (tempFishingLoop != "ERROR" && tempFishingLoop > 0)
    {
        fishingLoopCount := tempFishingLoop
    }
    IniRead, tempPathing, %fishSolSettingsFilePath%, Macro, pathingMode
    if (tempPathing != "ERROR")
    {
        pathingMode := tempPathing
    }
    IniRead, tempAzerty, %fishSolSettingsFilePath%, Macro, azertyPathing
    if (tempAzerty != "ERROR")
    {
        azertyPathing := (tempAzerty = "true" || tempAzerty = "1")
    }
    IniRead, tempPrivateServer, %fishSolSettingsFilePath%, Macro, privateServerLink
    if (tempPrivateServer != "ERROR")
    {
        privateServerLink := tempPrivateServer
    }
    IniRead, tempAdvancedDetection, %fishSolSettingsFilePath%, Macro, advancedFishingDetection, "1"
    if (tempAdvancedDetection != "ERROR")
    {
        advancedFishingDetection := (tempAdvancedDetection = "true" || tempAdvancedDetection = "1")
    }
    IniRead, tempAutoRejoinFailsafe, %fishSolSettingsFilePath%, Macro, autoRejoinFailsafeTime
    if (tempAutoRejoinFailsafe != "ERROR" && tempAutoRejoinFailsafe > 0)
    {
        autoRejoinFailsafeTime := tempAutoRejoinFailsafe
    }
    IniRead, tempAutoUnequip, %fishSolSettingsFilePath%, Macro, autoUnequip
    if (tempAutoUnequip != "ERROR")
    {
        autoUnequip := (tempAutoUnequip = "true" || tempAutoUnequip = "1")
    }
    IniRead, tempAzerty, %fishSolSettingsFilePath%, Macro, azertyPathing
    if (tempAzerty != "ERROR")
    {
        azertyPathing := (tempAzerty = "true" || tempAzerty = "1")
    }
    IniRead, tempAdvancedThreshold, %fishSolSettingsFilePath%, Macro, advancedFishingThreshold
    if (tempAdvancedThreshold != "ERROR" && tempAdvancedThreshold >= 0 && tempAdvancedThreshold <= 40)
    {
        advancedFishingThreshold := tempAdvancedThreshold
    }
    IniRead, tempStrangeController, %fishSolSettingsFilePath%, Macro, strangeController
    if (tempStrangeController != "ERROR")
    {
        strangeController := (tempStrangeController = "true" || tempStrangeController = "1")
    }
    IniRead, tempBiomeRandomizer, %fishSolSettingsFilePath%, Macro, biomeRandomizer
    if (tempBiomeRandomizer != "ERROR")
    {
        biomeRandomizer := (tempBiomeRandomizer = "true" || tempBiomeRandomizer = "1")
    }
    IniRead, tempBiomeSelector, %fishSolSettingsFilePath%, Macro, biomeSelector
    if (tempBiomeSelector != "ERROR")
    {
        biomeSelector := (tempBiomeSelector = "true" || tempBiomeSelector = "1")
    }
    IniRead, tempSelectedBiome, %fishSolSettingsFilePath%, Macro, selectedBiome
    if (tempSelectedBiome != "ERROR")
    {
        selectedBiome := tempSelectedBiome
    }
    IniRead, tempWebhook, %fishSolSettingsFilePath%, Macro, webhookURL
    if (tempWebhook != "ERROR")
    {
        webhookURL := tempWebhook
    }
    IniRead, tempAuraDetection, %fishSolSettingsFilePath%, Macro, auraDetection
    if (tempAuraDetection != "ERROR")
        auraDetection := (tempAuraDetection = "true" || tempAuraDetection = "1")

    IniRead, tempDetectGlobal, %fishSolSettingsFilePath%, Macro, detectGlobal
    if (tempDetectGlobal != "ERROR")
        detectGlobal := (tempDetectGlobal = "true" || tempDetectGlobal = "1")

    IniRead, tempDetectTrans, %fishSolSettingsFilePath%, Macro, detectTrans
    if (tempDetectTrans != "ERROR")
        detectTrans := (tempDetectTrans = "true" || tempDetectTrans = "1")

    IniRead, tempClipWebhook, %fishSolSettingsFilePath%, Macro, clipWebhook
    if (tempClipWebhook != "ERROR")
        clipWebhook := (tempClipWebhook = "true" || tempClipWebhook = "1")

    IniRead, tempClipWebhookPing, %fishSolSettingsFilePath%, Macro, clipWebhookPing
    if (tempClipWebhookPing != "ERROR")
        clipWebhookPing := (tempClipWebhookPing = "true" || tempClipWebhookPing = "1")

    IniRead, tempGlobalTranscendentPing, %fishSolSettingsFilePath%, Macro, globalTranscendentPing
    if (tempGlobalTranscendentPing != "ERROR")
        globalTranscendentPing := (tempGlobalTranscendentPing = "true" || tempGlobalTranscendentPing = "1")

    IniRead, tempUseCelestial, %fishSolSettingsFilePath%, Macro, useCelestial
    if (tempUseCelestial != "ERROR")
        useCelestial := (tempUseCelestial = "true" || tempUseCelestial = "1")

    IniRead, tempUseExotic, %fishSolSettingsFilePath%, Macro, useExotic
    if (tempUseExotic != "ERROR")
        useExotic := (tempUseExotic = "true" || tempUseExotic = "1")

    IniRead, tempUseBounded, %fishSolSettingsFilePath%, Macro, useBounded
    if (tempUseBounded != "ERROR")
        useBounded := (tempUseBounded = "true" || tempUseBounded = "1")

    IniRead, tempAuraFilter, %fishSolSettingsFilePath%, Macro, auraFilter
    if (tempAuraFilter != "ERROR")
        auraFilter := (tempAuraFilter = "true" || tempAuraFilter = "1")

    IniRead, tempCheckGhostServer, %fishSolSettingsFilePath%, Macro, checkGhostServer
    if (tempCheckGhostServer != "ERROR")
        checkGhostServer := (tempCheckGhostServer = "true" || tempCheckGhostServer = "1")

    IniRead, tempBiomeDetect, %fishSolSettingsFilePath%, Macro, biomeDetect
    if (tempBiomeDetect != "ERROR")
        biomeDetect := (tempBiomeDetect = "true" || tempBiomeDetect = "1")

    IniRead, tempRestartMacroFailsafe, %fishSolSettingsFilePath%, Macro, restartMacroFailsafe
    if (tempRestartMacroFailsafe != "ERROR")
        restartMacroFailsafe := (tempRestartMacroFailsafe = "true" || tempRestartMacroFailsafe = "1")

    IniRead, tempUseNothing, %fishSolSettingsFilePath%, Macro, useNothing
    if (tempUseNothing != "ERROR")
        useNothing := (tempUseNothing = "true" || tempUseNothing = "1")

    IniRead, tempAutoWarp, %fishSolSettingsFilePath%, Macro, autoWarp
    if (tempAutoWarp != "ERROR")
        autoWarp := (tempAutoWarp = "true" || tempAutoWarp = "1")

    IniRead, tempWebhookID, %fishSolSettingsFilePath%, Macro, webhookID
    if (tempWebhookID != "ERROR")
        webhookID := tempWebhookID

    IniRead, tempBiomeIndex, %fishSolSettingsFilePath%, Macro, biomeIndex
    if (tempBiomeIndex != "ERROR" && tempBiomeIndex > 0)
        biomeIndex := tempBiomeIndex

    IniRead, tempPotionCraftCount, %fishSolSettingsFilePath%, Macro, potionCraftCount
    if (tempPotionCraftCount != "ERROR" && tempPotionCraftCount > 0)
        potionCraftCount := tempPotionCraftCount

    IniRead, tempSelectedItem, %fishSolSettingsFilePath%, Macro, selectedItem
    if (tempSelectedItem != "ERROR")
        selectedItem := tempSelectedItem

    IniRead, tempSelectedItem2, %fishSolSettingsFilePath%, Macro, selectedItem2
    if (tempSelectedItem2 != "ERROR")
        selectedItem2 := tempSelectedItem2

    IniRead, tempAutoClicker, %fishSolSettingsFilePath%, Macro, autoClicker
    if (tempAutoClicker != "ERROR")
        autoClicker := (tempAutoClicker = "true" || tempAutoClicker = "1")

    IniRead, tempFishInLimbo, %fishSolSettingsFilePath%, Macro, fishInLimbo
    if (tempFishInLimbo != "ERROR")
        fishInLimbo := (tempFishInLimbo = "true" || tempFishInLimbo = "1")

    IniRead, tempLimboFailsafe, %fishSolSettingsFilePath%, Macro, limboFailsafe
    if (tempLimboFailsafe != "ERROR")
        limboFailsafe := (tempLimboFailsafe = "true" || tempLimboFailsafe = "1")

    IniRead, tempActivationMessage, %fishSolSettingsFilePath%, Macro, activationMessage
    if (tempActivationMessage != "ERROR")
        activationMessage := (tempActivationMessage = "true" || tempActivationMessage = "1")

    IniRead, tempBiomeItemMessage, %fishSolSettingsFilePath%, Macro, biomeItemMessage
    if (tempBiomeItemMessage != "ERROR")
        biomeItemMessage := (tempBiomeItemMessage = "true" || tempBiomeItemMessage = "1")

    IniRead, tempSkipType, %fishSolSettingsFilePath%, Macro, SkipType
    if (tempSkipType != "ERROR")
        SkipType := tempSkipType

    IniRead, tempClipType, %fishSolSettingsFilePath%, Macro, ClipType
    if (tempClipType != "ERROR")
        ClipType := tempClipType

    IniRead, tempCloseCollectionType, %fishSolSettingsFilePath%, Macro, CloseCollectionType
    if (tempCloseCollectionType != "ERROR")
        CloseCollectionType := tempCloseCollectionType

    IniRead, tempfailsafeMessage, %fishSolSettingsFilePath%, Macro, failsafeMessage
    if (tempfailsafeMessage != "ERROR")
        failsafeMessage := (tempfailsafeMessage = "true" || tempfailsafeMessage = "1")

    IniRead, tempfailsafeMessagePing, %fishSolSettingsFilePath%, Macro, failsafeMessagePing
    if (tempfailsafeMessagePing != "ERROR")
        failsafeMessagePing := (tempfailsafeMessagePing = "true" || tempfailsafeMessagePing = "1")

    IniRead, temprestartMacroFailsafePing, %fishSolSettingsFilePath%, Macro, restartMacroFailsafePing
    if (temprestartMacroFailsafePing != "ERROR")
        restartMacroFailsafePing := (temprestartMacroFailsafePing = "true" || temprestartMacroFailsafePing = "1")

    for i, aura in AuraListOrder {
        IniRead, savedVal, %fishSolSettingsFilePath%, EnabledAuras, %aura%, 1
        EnabledAuras[aura] := savedVal
    }
    for i, aura in AuraListTransOrder {
        IniRead, savedVal, %fishSolSettingsFilePath%, EnabledAuras, %aura%, 1
        EnabledAuras[aura] := savedVal
    }
}


Devs := [{dev_name:"mongoosee"
         , dev_role:"Biome Image Credits"
         , dev_discord:"Website"
         , dev_img: A_ScriptDir . "\img\mongoosee.png"
         , dev_link:"https://mongoosee.com/"
         , dev_website:"https://mongoosee.com/"}
        ,{dev_name:"ivelchampion249"
         , dev_role:"YouTube"
         , dev_discord:"Original Creator"
         , dev_img: A_ScriptDir . "\img\Ivel.png"
         , dev_link:"https://www.youtube.com/@ivelchampion"}
       ,{dev_name:"cresqnt"
         , dev_role:"Scope Development (other macros)"
         , dev_discord:"Frontend Developer"
         , dev_img: A_ScriptDir . "\img\cresqnt.png"
         , dev_link:"https://scopedevelopment.tech"
         , dev_website:"https://cresqnt.com"}
       ,{dev_name:"Nadir Rift"
         , dev_role:"Twitch"
         , dev_discord:"General Programmer"
         , dev_img: A_ScriptDir . "\img\nadir.png"
         , dev_link:"https://www.twitch.tv/nadirrift"
         , dev_egg:"Bonk"}]

Randomised_DevOrder := "1|2|3|4"
Sort, Randomised_DevOrder, Random D|

Randomised_DevOrder := StrSplit(Randomised_DevOrder, "|")
loop % Devs.Length()
{
    dev%A_Index%_name         := Devs[Randomised_DevOrder[A_INDEX]].dev_name
    dev%A_Index%_role         := Devs[Randomised_DevOrder[A_INDEX]].dev_role
    dev%A_Index%_discord      := Devs[Randomised_DevOrder[A_INDEX]].dev_discord
    dev%A_Index%_img          := Devs[Randomised_DevOrder[A_INDEX]].dev_img
    dev%A_Index%_link         := Devs[Randomised_DevOrder[A_INDEX]].dev_link
    dev%A_Index%_egg_label    := ""
    dev%A_Index%_egg_variable := ""
    dev%A_Index%_website      := ""
    if Devs[Randomised_DevOrder[A_INDEX]].dev_website != ""
        dev%A_Index%_website    := Devs[Randomised_DevOrder[A_INDEX]].dev_website
    if Devs[Randomised_DevOrder[A_Index]].dev_egg != ""
    {
        dev%A_Index%_egg_label    := "g"Devs[Randomised_DevOrder[A_INDEX]].dev_egg
        dev%A_Index%_egg_variable := "vIMG_"Devs[Randomised_DevOrder[A_INDEX]].dev_egg
    }
}

Gui, Color, 041024

Gui, Font, s30 cWhite Bold, Segoe UI
Gui, Font, s17 cWhite Bold, Segoe UI
Gui, Add, Text, x0 y8 w600 h45 Center BackgroundTrans c0xFFAA00, Aery's fishSol v1.8

Gui, Font, s9 cWhite Normal, Segoe UI

Gui, Color, 041024

Gui, Font, s10 cWhite Normal Bold

tabList := "Main"
tabList .= "|Misc"
tabList .= "|Auras"
tabList .= "|Links"
tabList .= "|Credits"
tabList .= "|Extra"

Gui, Add, Tab3, x15 y55 w570 h500 vMainTabs gTabChange c0xFFFFFF, %tabList%
Gui, Tab, Main

Gui, Font, s10 cWhite Bold, Segoe UI
Gui, Add, GroupBox, x30 y85 w185 h120 cWhite, Control Panel
Gui, Font, s11 cWhite Bold
Gui, Add, Text, x45 y110 w60 h25 BackgroundTrans, Status:
Gui, Add, Text, x98 y110 w150 h25 vStatusText BackgroundTrans c0xFF4444, Stopped

Gui, Font, s10 cWhite Bold, Segoe UI
Gui, Add, Button, x45 y140 w70 h35 gStartScript vStartBtn c0x00AA00 +0x8000, Start
Gui, Add, Button, x125 y140 w70 h35 gCloseScript vStopBtn c0xFF4444 +0x8000, Stop
Gui, Add, Text, x45 y180 w80 h25 BackgroundTrans, Resolution:
Gui, Font, s11 cWhite Bold
Gui, Add, Text, x120 y178 w80 h25 BackgroundTrans, 1080p

Gui, Font, s11 cWhite Bold
Gui, Add, GroupBox, x235 y85 w330 h120 cWhite, Limbo Fish
Gui, Font, s9 cWhite Normal
Gui, Add, Text, x247 y105 h45 w295 BackgroundTrans c0xCCCCCC, (During Macro) Automatically uses Zeus to glitch into limbo then fish in overworld. Requires Zeus and a consistent frame rate (~60fps). (In development)
Gui, Font, s10 cWhite Bold
;Gui, Add, Button, x250 y160 w80 h25 gTogglefishInLimbo vfishInLimboBtn, Toggle
Gui, Font, s10 c0xCCCCCC Bold, Segoe UI
;Gui, Add, Text, x340 y163 w60 h25 vfishInLimboStatus BackgroundTrans, OFF

Gui, Font, s9 c0xCCCCCC Bold, Segoe UI
;Gui, Add, Button, x385 y159 w124 h25 gTogglelimboFailsafe vlimboFailsafeBtn, Toggle Limbo Failsafe
Gui, Font, s10 c0xCCCCCC Bold, Segoe UI
;Gui, Add, Text, x521 y162 w60 h25 vlimboFailsafeStatus BackgroundTrans, OFF

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
Gui, Add, Text, x285 y272 w270 h15 BackgroundTrans, (There's is 56 Fish in the game. Default: 15)   

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

Gui, Font, s10 cWhite Bold
Gui, Add, GroupBox, x30 y485 w205 h55 cWhite, How to Close Collection
Gui, Add, DropDownList, x45 y507 w150 h125 vCloseCollectionVersion gCloseCollectionType, \ Key/UI Navigation|Click
GuiControl, Choose, CloseCollectionVersion, %closeCollectionType%

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
Gui, Add, GroupBox, x22 y291 w270 h230 cWhite, Biome Devices:
Gui, Font, s9 c0xCCCCCC Normal
Gui, Add, Text, x37 y313 w250 h50 BackgroundTrans, Togge which biome devices you want to be automatically used during fishing. (Strange Controller, Biome Randomizer, Biome Selector)

Gui, Font, s10 cWhite Bold, Segoe UI
Gui, Add, Text, x30 y370 w120 h25 BackgroundTrans, Strange Controller:
Gui, Add, Button, x157 y370 w80 h25 gToggleStrangeController vStrangeControllerBtn, Toggle
Gui, Font, s10 c0xCCCCCC Bold, Segoe UI
Gui, Add, Text, x257 y375 w60 h25 vStrangeControllerStatus BackgroundTrans, OFF
Gui, Font, s9 cWhite Normal
Gui, Add, Text, x30 y388 w500 h40 BackgroundTrans c0xCCCCCC,Uses every 21 minutes

Gui, Font, s10 cWhite Bold, Segoe UI
Gui, Add, Text, x30 y410 w125 h25 BackgroundTrans, Biome Randomizer:
Gui, Add, Button, x157 y410 w80 h25 gToggleBiomeRandomizer vBiomeRandomizerBtn, Toggle
Gui, Font, s10 c0xCCCCCC Bold, Segoe UI
Gui, Add, Text, x257 y413 w60 h25 vBiomeRandomizerStatus BackgroundTrans, OFF
Gui, Font, s9 cWhite Normal
Gui, Add, Text, x30 y428 w500 h40 BackgroundTrans c0xCCCCCC,Uses every 36 minutes

Gui, Font, s10 cWhite Bold, Segoe UI
Gui, Add, Text, x30 y450 w150 h25 BackgroundTrans, Biome Selector:
Gui, Font, s10 cWhite Bold
Gui, Add, Button, x157 y450 w80 h25 gToggleBiomeSelector vBiomeSelectorBtn, Toggle
Gui, Font, s10 c0xCCCCCC Bold, Segoe UI
Gui, Add, Text, x257 y455 w60 h25 vBiomeSelectorStatus BackgroundTrans, OFF
Gui, Font, s9 cWhite Normal
Gui, Add, Text, x30 y468 w500 h40 BackgroundTrans c0xCCCCCC,Uses every 61 minutes.
Gui, Font, s9 cWhite Bold
Gui, Add, DropDownList, x30 y487 w100 h200 vSelectedBiome gUpdateSelectedBiome, Windy|Snowy|Rainy|Heaven|Hell|Starfall|Corruption|SandStorm|Null

Gui, Font, s11 cWhite Bold
Gui, Add, GroupBox, x307 y90 w270 h155 cWhite, Auto Use Skips in Cyberspace
Gui, Font, s9 cWhite Normal
Gui, Add, Text, x317 y112 h45 w255 BackgroundTrans c0xCCCCCC, (During Macro) Automatically detects if you are in Cyberspace and uses a Transcendent Potion or Warp Potion.
Gui, Font, s10 cWhite Bold
Gui, Add, Button, x320 y170 w80 h25 gToggleAutoWarp vAutoWarpBtn, Toggle
Gui, Font, s10 cWhite Bold
Gui, Add, Text, x320 y211 w148 h155 BackGroundTrans, Potion Type:
Gui, Font, s10 c0xCCCCCC Bold, Segoe UI
Gui, Add, Text, x415 y173 w60 h25 vAutoWarpStatus BackgroundTrans, OFF
Gui, Add, DropDownList, x410 y207 w148 vSkipPotionType gskipType, Warp Potion|Transcendent Potion
GuiControl, Choose, SkipPotionType, %skipType%

Gui, Add, GroupBox, x307 y290 w260 h120 cWhite, Restart Macro Failsafe
Gui, Font, s9 cWhite Normal
Gui, Add, Text, x318 y310 h45 w240 BackgroundTrans c0xCCCCCC, (During Macro) Toggle if you want the macro to automatically restart if it detects that nothing has happened in 5 minutes.
Gui, Font, s10 cWhite Bold
Gui, Add, Button, x318 y370 w80 h25 gToggleRestartMacroFailsafe vRestartMacroFailsafeBtn, Toggle
Gui, Font, s10 c0xCCCCCC Bold, Segoe UI
Gui, Add, Text, x405 y373 w60 h25 vRestartMacroFailsafeStatus BackgroundTrans, OFF

Gui, Tab, Auras

Gui, Font, s13 cWhite Bold, Segoe UI
Gui, Add, Button, x100 y500 w170 h35 gOpenNvidiaNotes, Clipping Tutorial
Gui, Add, Button, x310 y500 w150 h35 gOpenAuraFilter, Aura Filter

Gui, Font, s11 cWhite Bold
Gui, Add, GroupBox, x33 y125 w240 h141 cWhite, Aura Detection
Gui, Font, s9 c0xCCCCCC Normal
Gui, Add, Text, x45 y145 w225 h131 BackgroundTrans c0xCCCCCC, Detects the most recent aura equipped. This will NOT work if the aura is automatically deleted. If you want to be pinged for a global/transcendent, enable Aura Detection Ping in Webhook Options.
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
Gui, Add, DropDownList, x440 y93 w128 vClipVersion gclipType, Nvidia: Alt + F10
GuiControl, Choose, ClipVersion, %clipType%

Gui, Font, s11 cWhite Bold, Segoe UI
Gui, Add, GroupBox, x33 y280 w534 h100 cWhite, Clip Globals
Gui, Font, s10 c0xCCCCCC Normal
Gui, Add, Text, x45 y300 w515 h135 BackgroundTrans, Automatically clips with Nvidia's Instant Replay when detecting a Global has been equipped. (Works for Biome Native Globals and Limbo Globals)
Gui, Font, s10 cWhite Bold, Segoe UI
Gui, Add, Button, x45 y339 w80 h25 gToggleDetectGlobal vDetectGlobalBtn, Toggle
Gui, Font, s10 c0xCCCCCC Bold, Segoe UI
Gui, Add, Text, x143 y341 w70 h25 vDetectGlobalStatus BackgroundTrans, OFF

Gui, Font, s11 cWhite Bold
Gui, Add, GroupBox, x33 y385 w534 h100 cWhite, Clip Transcendents
Gui, Font, s10 c0xCCCCCC Normal
Gui, Add, Text, x45 y405 w515 h145 BackgroundTrans, Automatically clips with Nvidia's Instant Replay when detecting a Transcendent has been equipped. Also gives a special webhook!
Gui, Font, s10 cWhite Bold, Segoe UI
Gui, Add, Button, x45 y445 w80 h25 gToggleDetectTrans vDetectTransBtn, Toggle
Gui, Font, s10 c0xCCCCCC Bold, Segoe UI
Gui, Add, Text, x143 y448 w70 h25 vDetectTransStatus BackgroundTrans, OFF


Gui, Tab, Links
Gui, Add, Text, x35 y95 w150 h25 BackgroundTrans, Private Server Link:
Gui, Add, Edit, x35 y120 w515 h25 vPrivateServerInput gUpdatePrivateServer Background0xD3D3D3 cBlack, %privateServerLink%

Gui, Font, s10 cWhite Normal Bold
Gui, Add, Text, x35 y155 w200 h25 BackgroundTrans, Discord Webhook URL:
Gui, Add, Edit, x35 y180 w515 h25 vWebhookInput gUpdateWebhook Background0xD3D3D3 cBlack, %webhookURL%
Gui, Font, s8 c0xCCCCCC Normal
Gui, Add, Text, x35 y210 w500 h15 BackgroundTrans, Paste your Discord Webhook URL here to be notified of actions happening in real time.

Gui, Font, s10 cWhite Normal Bold
Gui, Add, Text, x35 y230 w200 h25 BackgroundTrans, Discord USERID:
Gui, Add, Edit, x35 y255 w515 h25 vUserIDInput gUpdateUserID Background0xD3D3D3 cBlack, %webhookID%
Gui, Font, s8 c0xCCCCCC Normal
Gui, Add, Text, x35 y285 w500 h15 BackgroundTrans, Paste your Discord USERID here to be pinged of actions happening in real time.

Gui, Font, s11 cWhite Bold
Gui, Add, GroupBox, x33 y310 w534 h110 cWhite, Biome Detection
Gui, Font, s10 c0xCCCCCC Normal
Gui, Add, Text, x45 y330 w500 h145 BackgroundTrans, (During Macro) Detects your current biome and sends a webhook. Mentions everyone when a Glitch, Dreamspace, or Cyberspace is detected. Only detects when you are macroing.
Gui, Font, s10 cWhite Bold, Segoe UI
Gui, Add, Button, x45 y385 w80 h25 gToggleBiomeDetect vBiomeDetectBtn, Toggle
Gui, Font, s10 c0xCCCCCC Bold, Segoe UI
Gui, Add, Text, x143 y388 w70 h25 vBiomeDetectStatus BackgroundTrans, OFF
Gui, Font, s11 cWhite Bold, Segoe UI4
Gui, Add, Button, x405 y385 w100 h25 gClearLogs, Clear Logs

Gui, Font, s14 cWhite Bold, Segoe UI4
Gui, Add, Button, x205 y490 w190 h40 gOpenWebhookList, Webhook Options

/*
Gui, Font, s11 cWhite Bold
Gui, Add, GroupBox, x33 y185 w534 h100 cWhite, Check For Ghost Server
Gui, Font, s10 c0xCCCCCC Normal
Gui, Add, Text, x45 y205 w500 h145 BackgroundTrans, (During Macro) Checks for Ghost Server at the start of script, then hourly by seeing if you have access to Command Panel. If detected joins the server in private server link.
Gui, Font, s10 cWhite Bold, Segoe UI
Gui, Add, Button, x45 y245 w80 h25 gToggleCheckGhostServer vCheckGhostServerBtn, Toggle
Gui, Font, s10 c0xCCCCCC Bold, Segoe UI
Gui, Add, Text, x143 y248 w70 h25 vCheckGhostServerStatus BackgroundTrans, OFF
*/

Gui, Tab, Credits
Gui, Add, Picture, x14 y80 w574 h590 vIMAGE_HANDLE_PNG_CRED_TAB
Gui, Font, s10 cWhite Normal
Gui, Add, Picture, x50 y130 w50 h50 %dev1_egg_label% %dev1_egg_variable%, %dev1_img%
Gui, Font, s11 cWhite Normal Bold
if (dev1_website != "") {
    Gui, Add, Text, x110 y135 w200 h20 BackgroundTrans c0x0088FF gDev1NameClick, %dev1_name%
} else {
    Gui, Add, Text, x110 y135 w200 h20 BackgroundTrans c0x00DD00, %dev1_name%
}
Gui, Font, s9 c0xCCCCCC Normal
Gui, Add, Text, x110 y155 w200 h15 BackgroundTrans, %dev1_role%
Gui, Font, s9 c0xCCCCCC Normal Underline
Gui, Add, Text, x110 y170 w200 h15 BackgroundTrans c0x0088FF gDev1LinkClick, %dev1_discord%
Gui, Font, s11 cWhite Normal Bold
Gui, Add, Picture, x50 y195 w50 h50 %dev2_egg_label% %dev2_egg_variable%, %dev2_img%
if (dev2_website != "") {
    Gui, Add, Text, x110 y200 w200 h20 BackgroundTrans c0x0088FF gDev2NameClick, %dev2_name%
} else {
    Gui, Add, Text, x110 y200 w200 h20 BackgroundTrans c0x00DD00, %dev2_name%
}
Gui, Font, s9 c0xCCCCCC Normal
Gui, Add, Text, x110 y220 w200 h15 BackgroundTrans, %dev2_role%
Gui, Font, s9 c0xCCCCCC Normal Underline
Gui, Add, Text, x110 y235 w200 h15 BackgroundTrans c0x0088FF gDev2LinkClick, %dev2_discord%
Gui, Add, Picture, x50 y260 w50 h50 %dev3_egg_label% %dev3_egg_variable%, %dev3_img%
Gui, Font, s11 cWhite Normal Bold
if (dev3_website != "") {
    Gui, Add, Text, x110 y265 w200 h20 BackgroundTrans c0x0088FF gDev3NameClick, %dev3_name%
} else {
    Gui, Add, Text, x110 y265 w200 h20 BackgroundTrans c0x00DD00, %dev3_name%
}
Gui, Font, s9 c0xCCCCCC Normal
Gui, Add, Text, x110 y285 w200 h15 BackgroundTrans, %dev3_role%
Gui, Font, s9 c0xCCCCCC Normal Underline
Gui, Add, Text, x110 y300 w200 h15 BackgroundTrans c0x0088FF gDev3LinkClick, %dev3_discord%
Gui, Add, Picture, x490 y260 w50 h50 %dev4_egg_label% %dev4_egg_variable%, %dev4_img%
Gui, Font, s11 cWhite Normal Bold
if (dev4_website != "") {
    Gui, Add, Text, x280 y265 w200 h20 BackgroundTrans c0x0088FF 0x202 gDev4NameClick, %dev4_name%
} else {
    Gui, Add, Text, x280 y265 w200 h20 BackgroundTrans c0x00DD00 0x202, %dev4_name%
}
Gui, Font, s9 c0xCCCCCC Normal
Gui, Add, Text, x280 y285 w200 h15 BackgroundTrans 0x202, %dev4_role%
Gui, Font, s9 c0xCCCCCC Normal Underline
Gui, Add, Text, x280 y300 w200 h15 BackgroundTrans c0x0088FF gDev4NameClick 0x202, %dev4_discord%
Gui, Font, s8 c0x888888
Gui, Add, Text, x50 y325 w480 h1 0x10 BackgroundTrans

url := "https://raw.githubusercontent.com/ivelchampion249/FishSol-Macro/refs/heads/main/DONATORS.txt"

Http := ComObjCreate("WinHttp.WinHttpRequest.5.1")
try Http.Open("GET", url, false)
try Http.Send()

content := Http.ResponseText

; change
Gui, Font, s10 cWhite Bold
Gui, Add, Text, x50 y345 w2000 h20 BackgroundTrans, Hope you enjoy my fishSol! Donators of Original fishSol:
Gui, Font, s9 c0xCCCCCC Normal
Gui, Add, Edit, x50 y370 w480 h95 vDonatorsList -Wrap +ReadOnly +VScroll -WantReturn -E0x200 Background0x2D2D2D c0xCCCCCC, %content%

Gui, Font, s8 c0x888888
Gui, Add, Text, x50 y490 w480 h1 0x10 BackgroundTrans

Gui, Font, s8 c0xCCCCCC Normal
Gui, Add, Text, x50 y500 w500 h15 BackgroundTrans, Aery's fishSol v1.8 (2026-08-12)
Gui, Add, Text, x300 y500 w500 h15 BackgroundTrans, If you need help, message me on discord. (noaery)
Gui, Add, Text, x50 y525 w500 h15 BackgroundTrans c0x0088FF gReleasesClick +0x200, https://github.com/knowaery/Aery-s-Fishsol

Gui, Tab, Extra
Gui, Font, s11 cWhite Bold
Gui, Add, GroupBox, x22 y265 w225 h120 cWhite, Auto-Clicker
Gui, Add, Button, x35 y345 w80 h25 gStartAutoClicker vAutoClickStart, Start
Gui, Add, Button, x125 y345 w80 h25 gStopAutoClicker  vAutoClickStop Disabled, Stop
Gui, Font, s10 c0xCCCCCC Bold, Segoe UI
Gui, Add, Text, x214 y349 w60 h25 vAutoClickerStatus BackgroundTrans, OFF
Gui, Font, s10 cWhite Bold
Gui, Add, Text, x35 y320 w90 h20 BackgroundTrans, Delay (sec):
Gui, Font, s9 cBlack Bold
Gui, Add, Edit, x120 y320 w60 h22 vAutoClickDelay, 60
Gui, Font, s9 c0xCCCCCC Normal
Gui, Add, Text, x32 y285 w205 h135 BackgroundTrans c0xCCCCCC, Automatically clicks after the desired seconds.

Gui, Font, s10 cWhite Bold
Gui, Add, GroupBox, x22 y85 w554 h170 cWhite, Auto Craft
Gui, Add, Text, x60 y167 w150 h50 BackgroundTrans, F2 = Start | F3 = Stop

Gui, Font, s10 cWhite Bold
Gui, Add, GroupBox, x220 y145 w210 h100 cWhite, Heavenly Potion
Gui, Add, Button, x308 y165 w80 h25 gToggleUseCelestial vUseCelestialBtn, Toggle
Gui, Add, Button, x308 y205 w80 h25 gToggleUseExotic vUseExoticBtn, Toggle
Gui, Add, Text, x398 y169 w60 h25 vUseCelestialStatus BackgroundTrans, OFF
Gui, Add, Text, x398 y209 w60 h25 vUseExoticStatus BackgroundTrans, OFF
Gui, Font, s9 cWhite Normal
Gui, Add, Text, x228 y170 w600 h100 BackgroundTrans c0xCCCCCC, Add
Gui, Add, Text, x228 y210 w600 h100 BackgroundTrans c0xCCCCCC, Add
Gui, Font, s9 c9B8CFF Bold, Trajan Pro
Gui, Add, Text, x254 y169 w600 h100 BackgroundTrans, Celestial:
Gui, Font, s10 cWhite Normal, Trajan Pro
Gui, Add, Text, vExoticText x254 y209 w600 h100 BackgroundTrans, Exotic:
SetTimer, RainbowText, 50

Gui, Font, s10 cWhite Bold
Gui, Add, GroupBox, x437 y145 w130 h100 cWhite, Bound Potion 
Gui, Add, Button, x448 y205 w80 h25 gToggleUseBounded vUseBoundedBtn, Toggle
Gui, Add, Text, x536 y209 w60 h25 vUseBoundedStatus BackgroundTrans, OFF
Gui, Font, s9 cWhite Normal
Gui, Add, Text, x448 y169 w600 h100 BackgroundTrans c0xCCCCCC, Add
Gui, Font, s9 c1559C9 Bold, Trajan Pro
Gui, Add, Text, x475 y169 w600 h100 BackgroundTrans, Bounded:


Gui, Font, s9 cWhite Normal
Gui, Add, Text, x35 y105 w534 h100 BackgroundTrans c0xCCCCCC, Adds the nessecary potions and/or auras to craft potions. Please already put the desired item on auto craft. You MUST be inside of Stella's Cauldron's UI. Toggling the auras listed below means adding them to the desired potion from your inventory and turns on Add Everything.
Gui, Font, s10 c0xCCCCCC Bold, Segoe UI
Gui, Add, DropDownList, x60 y205 w120 vAutoCraft gSelectItem, Heavenly Potion|Bound Potion|Jewelry Potion|Zombie Potion|Rage Potion|Diver Potion
GuiControl, Choose, AutoCraft, %selectedItem%

GuiControl, Choose, Resolution, 1

Gui, Show, w600 h570,  Aery's fishSol v1.8

GuiControl, Choose, Resolution, 1
GuiControl, Choose, PathingMode, 1

UpdateStatus(initialToggle, convert) {
    GuiControl,, %initialToggle%, % convert ? "ON" : "OFF"
    GuiControl, % (convert ? "+c0x00DD00" : "+c0xFF4444"), %initialToggle%
}

; fishing/macro related
UpdateStatus("AdvancedFishingDetectionStatus", advancedFishingDetection)
UpdateStatus("AzertyPathingStatus", azertyPathing)
UpdateStatus("RestartMacroFailsafeStatus", restartMacroFailsafe)
UpdateStatus("FishInLimboStatus", fishInLimbo)
UpdateStatus("LimboFailsafeStatus", limboFailsafe)

; unequip related
if (autoUnequip && !auraDetection) {
    TrayTip, Please turn on Aura Detection!, Auras Tab -> Aura Detection
    autoUnequip := false
}
UpdateStatus("AutoUnequipStatus", autoUnequip)
if (autoUnequip && !auraDetection) {
    TrayTip, Please turn on Aura Detection!, Auras Tab -> Aura Detection
    autoUnequip := false
} else if (!autoUnequip) {
    TrayTip, Please turn Auto Unequip!
    useNothing := false
}
UpdateStatus("UseNothingStatus", useNothing)

; biome devices related
UpdateStatus("BiomeRandomizerStatus", biomeRandomizer)
UpdateStatus("StrangeControllerStatus", strangeController)
UpdateStatus("BiomeSelectorStatus", biomeSelector)

; crafting related
UpdateStatus("AutoCraftStatus", autoCraft)
UpdateStatus("UseCelestialStatus", useCelestial)
UpdateStatus("UseExoticStatus", useExotic)
UpdateStatus("UseBoundedStatus", useBounded)


; aura detection related
UpdateStatus("AuraDetectionStatus", auraDetection)
UpdateStatus("AuraFilterStatus", auraFilter)
UpdateStatus("DetectGlobalStatus", detectGlobal)
UpdateStatus("DetectTransStatus", detectTrans)
UpdateStatus("ClipWebhookStatus", clipWebhook)
UpdateStatus("ClipWebhookPingStatus", clipWebhookPing)
UpdateStatus("GlobalTranscendentPingStatus", globalTranscendentPing)

; biome detection related
if (biomeDetect && privateServerLink = "") {
    TrayTip, Please Enter a Private Server Link!, Private Server Tab -> Private Server Link
    biomeDetect := false
}
UpdateStatus("BiomeDetectStatus", biomeDetect)
UpdateStatus("AutoWarpStatus", autoWarp)

; misc related
if (autoClicker) {
    GuiControl, Disable, AutoClickStart
    GuiControl, Enable, AutoClickStop
} else {
    GuiControl, Enable, AutoClickStart
    GuiControl, Disable, AutoClickStop
}
UpdateStatus("AutoClickerStatus", autoClicker)

/*
if (checkGhostServer && privateServerLink = "") {
    TrayTip, Please Enter a Private Server Link!, Private Server Tab -> Private Server Link
    checkGhostServer := false
}
UpdateStatus("CheckGhostServerStatus", checkGhostServer)
*/

GuiControl, ChooseString, SelectedBiome, %selectedBiome%
SetTimer, AuraBiomeDetect, 1000
SetTimer, ServerLinkConverter, 1000




AuraCheckChange:
    if (!auraFilterReady)
        return
    Gui, AuraFilter:Submit, NoHide
    for i, aura in AuraListOrder {
        auraName := aura . "_chk"
        StringReplace, auraName, auraName, -, _, All
        StringReplace, auraName, auraName, %A_Space%, _, All
        EnabledAuras[aura] := %auraName%
        IniWrite, % EnabledAuras[aura], %fishSolSettingsFilePath%, EnabledAuras, %aura%
    }
    for i, aura in AuraListTransOrder {
        auraName := aura . "_chk"
        StringReplace, auraName, auraName, -, _, All
        StringReplace, auraName, auraName, %A_Space%, _, All
        EnabledAuras[aura] := %auraName%
        IniWrite, % EnabledAuras[aura], %fishSolSettingsFilePath%, EnabledAuras, %aura%
    }
return

SaveAuraFilter:
    Gui, AuraFilter:Submit, NoHide
    for i, aura in AuraListOrder {
        auraName := aura . "_chk"
        StringReplace, auraName, auraName, -, _, All
        StringReplace, auraName, auraName, %A_Space%, _, All
        EnabledAuras[aura] := %auraName%
        IniWrite, % EnabledAuras[aura], %fishSolSettingsFilePath%, EnabledAuras, %aura%
    }
    for i, aura in AuraListTransOrder {
        auraName := aura . "_chk"
        StringReplace, auraName, auraName, -, _, All
        StringReplace, auraName, auraName, %A_Space%, _, All
        EnabledAuras[aura] := %auraName%
        IniWrite, % EnabledAuras[aura], %fishSolSettingsFilePath%, EnabledAuras, %aura%
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

GuiControl, ChooseString, SelectedBiome, %selectedBiome%
SetBatchLines, %BatchLine_Default%
return

UpdateLoopCount:
    Gui, Submit, NoHide
    if (MaxLoopInput > 0) {
        maxLoopCount := MaxLoopInput
        IniWrite, %maxLoopCount%, %fishSolSettingsFilePath%, Macro, maxLoopCount
    }
    if (FishingLoopInput > 0) {
        fishingLoopCount := FishingLoopInput
        IniWrite, %fishingLoopCount%, %fishSolSettingsFilePath%, Macro, fishingLoopCount
    }
return

UpdatePotionCraft:
    Gui, Submit, NoHide
    if (PotionCraftInput > 0) {
        potionCraftCount := PotionCraftInput
        IniWrite, %potionCraftCount%, %fishSolSettingsFilePath%, Macro, potionCraftCount
    }
return

UpdateSelectedBiome:
    Gui, Submit, nohide
    selectedBiome := SelectedBiome
    IniWrite, %selectedBiome%, %fishSolSettingsFilePath%, Macro, selectedBiome
return

ToggleSetting(ByRef Setting, toggleName, iniKey) {
    global fishSolSettingsFilePath
    Setting := !Setting
    UpdateStatus(toggleName, Setting)
    IniWrite, % (Setting ? "true" : "false"), %fishSolSettingsFilePath%, Macro, %iniKey%
    return Setting
}

ToggleAutoUnequip:
    if (ToggleSetting(autoUnequip, "AutoUnequipStatus", "autoUnequip") && !auraDetection) {
        TrayTip, Please turn on Aura Detection!, Auras Tab -> Aura Detection
        ToggleSetting(autoUnequip, "AutoUnequipStatus", "autoUnequip")
    }
return

ToggleUseNothing:
    if (ToggleSetting(useNothing, "UseNothingStatus", "useNothing") && !autoUnequip) {
        TrayTip, Please turn on Auto Unequip!, Misc Tab -> Auto Unequip
        ToggleSetting(useNothing, "UseNothingStatus", "useNothing")
    }
return

ToggleAutoClicker:
    autoClicker := ToggleSetting(autoClicker, "AutoClickerStatus", "autoClicker")
    GuiControl, % (autoClicker ? "Disable" : "Enable"), AutoClickStart
    GuiControl, % (autoClicker ? "Enable" : "Disable"), AutoClickStop
return

ToggleCheckGhostServer:
    if (ToggleSetting(checkGhostServer, "CheckGhostServerStatus", "checkGhostServer") && privateServerLink = "") {
        TrayTip, Please Enter a Private Server Link!, Private Server Tab -> Private Server Link
        ToggleSetting(checkGhostServer, "CheckGhostServerStatus", "checkGhostServer")
    }
return

ToggleBiomeDetect:
    if (ToggleSetting(biomeDetect, "BiomeDetectStatus", "biomeDetect") && privateServerLink = "") {
        TrayTip, Please Enter a Private Server Link!, Private Server Tab -> Private Server Link
        ToggleSetting(biomeDetect, "BiomeDetectStatus", "biomeDetect")
    }
return

ToggleAdvancedFishingDetection:
    ToggleSetting(advancedFishingDetection, "AdvancedFishingDetectionStatus", "advancedFishingDetection")
return

ToggleAzertyPathing:
    ToggleSetting(azertyPathing, "AzertyPathingStatus", "azertyPathing")
return

ToggleClipWebhook:
    ToggleSetting(clipWebhook, "ClipWebhookStatus", "clipWebhook")
return

ToggleClipWebhookPing:
    ToggleSetting(clipWebhookPing, "ClipWebhookPingStatus", "clipWebhookPing")
return

ToggleGlobalTranscendentPing:
    ToggleSetting(globalTranscendentPing, "GlobalTranscendentPingStatus", "globalTranscendentPing")
return

ToggleStrangeController:
    ToggleSetting(strangeController, "StrangeControllerStatus", "strangeController")
return

ToggleBiomeRandomizer:
    ToggleSetting(biomeRandomizer, "BiomeRandomizerStatus", "biomeRandomizer")
return

ToggleUseCelestial:
    ToggleSetting(useCelestial, "UseCelestialStatus", "useCelestial")
return

ToggleUseExotic:
    ToggleSetting(useExotic, "UseExoticStatus", "useExotic")
return

ToggleUseBounded:
    ToggleSetting(useBounded, "UseBoundedStatus", "useBounded")
return

ToggleAuraDetection:
    ToggleSetting(auraDetection, "AuraDetectionStatus", "auraDetection")
return

ToggleDetectGlobal:
    ToggleSetting(detectGlobal, "DetectGlobalStatus", "detectGlobal")
return

ToggleDetectTrans:
    ToggleSetting(detectTrans, "DetectTransStatus", "detectTrans")
return

ToggleAutoWarp:
    ToggleSetting(autoWarp, "AutoWarpStatus", "autoWarp")
return

ToggleAuraFilter:
    ToggleSetting(auraFilter, "AuraFilterStatus", "auraFilter")
return

ToggleRestartMacroFailsafe:
    ToggleSetting(restartMacroFailsafe, "RestartMacroFailsafeStatus", "restartMacroFailsafe")
return

ToggleBiomeSelector:
    ToggleSetting(biomeSelector, "BiomeSelectorStatus", "biomeSelector")
return

ToggleFishInLimbo:
    ToggleSetting(fishInLimbo, "FishInLimboStatus", "fishInLimbo")
return

ToggleLimboFailsafe:
    ToggleSetting(limboFailsafe, "LimboFailsafeStatus", "limboFailsafe")
return

ToggleActivationMessage:
    ToggleSetting(activationMessage, "ActivationMessageStatus", "activationMessage")
return

ToggleBiomeItemMessage:
    ToggleSetting(biomeItemMessage, "BiomeItemMessageStatus", "biomeItemMessage")
return

ToggleFailsafeMessage:
    ToggleSetting(failsafeMessage, "FailsafeMessageStatus", "failsafeMessage")
return

ToggleFailsafeMessagePing:
    ToggleSetting(failsafeMessagePing, "FailsafeMessagePingStatus", "failsafeMessagePing")
return

ToggleRestartMacroFailsafePing:
    ToggleSetting(restartMacroFailsafePing, "RestartMacroFailsafePingStatus", "restartMacroFailsafePing")
return

UpdatePrivateServer:
    Gui, Submit, NoHide
    privateServerLink := PrivateServerInput
    IniWrite, %privateServerLink%, %fishSolSettingsFilePath%, Macro, privateServerLink
return

UpdateAutoRejoinFailsafe:
Gui, Submit, nohide
if (AutoRejoinFailsafeInput > 0) {
    autoRejoinFailsafeTime := AutoRejoinFailsafeInput
    IniWrite, %autoRejoinFailsafeTime%, %fishSolSettingsFilePath%, Macro, autoRejoinFailsafeTime
}
return

UpdateAdvancedThreshold:
Gui, Submit, nohide
if (AdvancedThresholdInput >= 0 && AdvancedThresholdInput <= 40) {
    advancedFishingThreshold := AdvancedThresholdInput
    IniWrite, %advancedFishingThreshold%, %fishSolSettingsFilePath%, Macro, advancedFishingThreshold
}
return

UpdateWebhook:
    Gui, Submit, nohide
    webhookURL := WebhookInput
    IniWrite, %webhookURL%, %fishSolSettingsFilePath%, Macro, webhookURL
return

ProcessExist(Name) {
    IfWinActive, ahk_exe %name%
        return true
    for process in ComObjGet("winmgmts:").ExecQuery("Select * from Win32_Process")
        if (process.Name = Name)
            return true
    return false
}


; webhooks!
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
    . """text"": ""Aery's fishSol v1.8"","
    . """icon_url"": ""https://raw.githubusercontent.com/knowaery/Aery-s-Fishsol/main/img/yui2.png"""
    . "},"
    . """timestamp"": """ timestamp """"
    . "}]"
    . "}"

    http := ComObjCreate("WinHttp.WinHttpRequest.5.1")
    http.Open("POST", webhookURL, false)
    http.SetRequestHeader("Content-Type", "application/json")
    try http.Send(json)
}

SendWebhook2(text, color := 16777215, imageURL := "") {
    global webhookURL, webhookID, globalTranscendentPing, auraName

    if (!InStr(webhookURL, "discord"))
        return

    time := A_NowUTC
    timestamp := SubStr(time,1,4) "-" SubStr(time,5,2) "-" SubStr(time,7,2)
              . "T" SubStr(time,9,2) ":" SubStr(time,11,2) ":" SubStr(time,13,2) ".000Z"

    content := ""
    allowedMentions := ""

    if (globalTranscendentPing && webhookID != "") {
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
    . """text"": ""Aery's fishSol v1.8"","
    . """icon_url"": ""https://raw.githubusercontent.com/knowaery/Aery-s-Fishsol/main/img/yui2.png"""
    . "},"
    . """timestamp"": """ timestamp """"
    . "}]"
    . "}"

    http := ComObjCreate("WinHttp.WinHttpRequest.5.1")
    http.Open("POST", webhookURL, false)
    http.SetRequestHeader("Content-Type", "application/json")
    try http.Send(json)
}

SendWebhookForcePing(text, color := 16777215) {
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
    . """text"": ""Aery's fishSol v1.8"","
    . """icon_url"": ""https://raw.githubusercontent.com/knowaery/Aery-s-Fishsol/main/img/yui2.png"""
    . "},"
    . """timestamp"": """ timestamp """"
    . "}]"
    . "}"

    http := ComObjCreate("WinHttp.WinHttpRequest.5.1")
    http.Open("POST", webhookURL, false)
    http.SetRequestHeader("Content-Type", "application/json")
    try http.Send(json)
}

SendWebhook4(text, color := 16777215, imageURL := "") {
    global webhookURL, webhookID, globalTranscendentPing, auraName

    if (!InStr(webhookURL, "discord"))
        return

    time := A_NowUTC
    timestamp := SubStr(time,1,4) "-" SubStr(time,5,2) "-" SubStr(time,7,2)
              . "T" SubStr(time,9,2) ":" SubStr(time,11,2) ":" SubStr(time,13,2) ".000Z"

    content := ""
    allowedMentions := ""

    if (clipWebhookPing && webhookID != "") {
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
    . """text"": ""Aery's fishSol v1.8"","
    . """icon_url"": ""https://raw.githubusercontent.com/knowaery/Aery-s-Fishsol/main/img/yui2.png"""
    . "},"
    . """timestamp"": """ timestamp """"
    . "}]"
    . "}"

    http := ComObjCreate("WinHttp.WinHttpRequest.5.1")
    http.Open("POST", webhookURL, false)
    http.SetRequestHeader("Content-Type", "application/json")
    try http.Send(json)
}

SendWebhookMonarch(text, color := 16777215, imageURL := "") {
    global webhookURL, webhookID, globalTranscendentPing, auraName

    if (!InStr(webhookURL, "discord"))
        return

    time := A_NowUTC
    timestamp := SubStr(time,1,4) "-" SubStr(time,5,2) "-" SubStr(time,7,2)
              . "T" SubStr(time,9,2) ":" SubStr(time,11,2) ":" SubStr(time,13,2) ".000Z"

    content := ""

    content := "# All Hail... <@" webhookID ">"

    imageBlock := ""
    if (imageURL != "") {
        imageBlock := """image"": {""url"": """ imageURL """},"
    }

    json := "{"
    . """content"": """ content ""","
    . """embeds"": [{"
    . """title"": """ text ""","
    . """color"": " color ","
    . imageBlock
    . """footer"": {"
    . """text"": ""Aery's fishSol v1.8"","
    . """icon_url"": ""https://raw.githubusercontent.com/knowaery/Aery-s-Fishsol/main/img/yui2.png"""
    . "},"
    . """timestamp"": """ timestamp """"
    . "}]"
    . "}"

    http := ComObjCreate("WinHttp.WinHttpRequest.5.1")
    http.Open("POST", webhookURL, false)
    http.SetRequestHeader("Content-Type", "application/json")
    try http.Send(json)
}

SendWebhookAuras(text, color := 16777215) {
    global auraName, webhookID, globalTranscendentPing, ping4Aura

    if (ping4Aura) {
        contentStr := """content"": ""<@" webhookID ">"","
        mentionsStr := """allowed_mentions"": {""users"": [""" webhookID """]},"
    } else {
        contentStr := """content"": """","
        mentionsStr := ""
    }
    json := "{"
    . mentionsStr
    . contentStr
    . """embeds"": [{"
    . """description"": "" ### Aura Equipped - " auraName ""","
    . """color"": " auracolor ","
    . """footer"": {""text"": ""Aery's fishSol v1.8"", ""icon_url"": ""https://raw.githubusercontent.com/knowaery/Aery-s-Fishsol/main/img/yui2.png""},"
    . """timestamp"": """ timestamp """"
    . "}]}"

    http := ComObjCreate("WinHttp.WinHttpRequest.5.1")
    http.Open("POST", webhookURL, false)
    http.SetRequestHeader("Content-Type", "application/json")
    try http.Send(json)
    ping4Aura := false
}

; Strange Controller toggle
RunStrangeController() {
    global biomeItemMessage
    MouseMove, 45, 521, 3
    sleep 300
    Click, Left
    MouseMove, 1280, 343, 3
    sleep 300
    Click, Left
    MouseMove, 820, 370, 3
    sleep 300
    Click, Left
    Clipboard := "Strange Controller"
    sleep 150
    Send, ^v
    sleep 300
    MouseMove, 850, 485, 3
    sleep 300
    Click, Left            
    MouseMove, 690, 585, 3
    sleep 300
    if (biomeItemMessage) {
        SendWebhook(":joystick: Strange Controller Activated!", 0)
    }
    Click, Left
    sleep 600
    MouseMove, 45, 521, 3
    sleep 300
    Click, Left
    sleep, 600
}

; Biome Selector Toggle
RunBiomeSelector() {
    global selectedBiome
    global currentBiome
    global res
    global biomeItemMessage
    SetBatchLines, -1
    if (selectedBiome = "") {
        return
    }

    StringUpper, normalizedSelected, % StrReplace(selectedBiome, " ", "")
    StringUpper, normalizedCurrent, % StrReplace(currentBiome, " ", "")


    if (normalizedSelected = normalizedCurrent && currentBiome != "None") {
        return
    }

    tryCount := 0

    Starfall := "0x1C73FF"
    Hell := "0xFF3737"
    Null := "0xFFFFFF"
    Corruption := "0x972EFF"
    SandStorm := "0xFFBC86"
    Snowy := "0x9EECFF"
    Rainy := "0x589BFF"
    Windy := "0x8AFFBD"
    Heaven := "0xFFCE80"

    switch selectedBiome {
        case "Starfall":
            COLOR := Starfall
        case "Hell":
            COLOR := Hell
        case "Null":
            COLOR := Null
        case "Corruption":
            COLOR := Corruption
        case "SandStorm":
            COLOR := SandStorm
        case "Snowy":
            COLOR := Snowy
        case "Rainy":
            COLOR := Rainy
        case "Windy":
            COLOR := Windy
        case "Heaven":
            COLOR := Heaven
    }

    if (res = "1080p") {
        MouseMove, 36, 513, 3
        sleep 200
        MouseClick, Left
        sleep 200
        MouseMove, 1272, 338, 3
        sleep 300
        MouseClick, Left
        sleep 300
        MouseMove, 1104, 368, 3
        sleep 300
        MouseClick, Left
        sleep 150
        Clipboard := "Biome Selector"
        sleep 150
        Send, ^v
        sleep 300
        MouseMove, 848, 479, 3
        sleep 300
        MouseClick, Left
        sleep 500
        Loop 3  {   
            if (CheckItemDescription1080p(10, 0x47c8ff, 0xff5f1f, 0xf8ac73, 0x9580ff)) {
                MouseMove, 685, 580, 3
                sleep 200
                MouseClick, Left
                inController := true
                X_Start  := 612
                X_End    := 614
                Y_Start  := 370
                Y_End    := 710
                DRIVE_HEIGHT   := 31
                X_Button_Center := 880
                ConfirmX := 775
                ConfirmY := 605
                X_Close := 1305
                Y_Close := 350
                break
            } else {
                ; BS failsafe
                MouseMove, 1270, 338, 3
                sleep 300
                MouseClick, Left
                sleep 300
                MouseMove, 1104, 368, 3
                sleep 300
                MouseClick, Left
                sleep 150
                Clipboard := "Biome Selector"
                sleep 150
                Send, ^v
                sleep 300
                MouseMove, 848, 479, 3
                sleep 300
                MouseClick, Left
                sleep 500
            }
        }
        if (!inController) {
            MouseMove, 1305, 350, 3
            sleep 300
            MouseClick, Left
            if (biomeItemMessage) {
                SendWebhook(":joystick: Biome Selector couldn't be Found after retries!", "3225405")
            }
        }
    }

    if (inController){
        MouseMove, %X_Button_Center%, 100, 0
        sleep 3000
        if (selectedBiome = "Heaven")
        {
            MouseMove, % A_ScreenWidth / 2, % A_ScreenHeight / 2, 3
            sleep 300
            Click, WheelDown
            sleep 30
            MouseMove, %X_Button_Center%, 100, 3
            sleep 3000
        }
        loop, 3
        {
            ErrorLevel := 0
            PixelSearch, px, py, %X_Start%, %Y_Start%, %X_End%, %Y_End%, %COLOR%, 0, Fast RGB
            if (ErrorLevel = 0)
            {
                PixelGetColor, out_color, %px%, %py%, RGB
                if (COLOR = out_color)
                {
                    MouseMove, %X_Button_Center%, % py + (DRIVE_HEIGHT / 2), 2
                    sleep 300
                    MouseClick, Left
                    biomeDetected := true
                    break
                }
            } else {
                MouseMove, % A_ScreenWidth / 2, % A_ScreenHeight / 2, 3
                sleep 300
                Click, % A_Index = 1 ? "WheelDown" : "WheelUp"
                sleep 30
                MouseMove, %X_Button_Center%, 100, 3
                sleep 3000
            }
        }

        if (!biomeDetected) {
            MouseMove, %X_Close%, %Y_Close%, 3
            sleep 300
            MouseClick, Left
            SendWebhookForcePing(":joystick: Biome Selector is Missing a Drive!", "3225405")
        } else {
            sleep 1000
            pixelsearch, x, y, % X_Close + 50, % Y_Close + 50, % X_Close - 50, % Y_Close - 50, %Color%, 0, Fast RGB
            if (ErrorLevel != 0)
            {
                MouseMove, %X_Close%, %Y_Close%, 3
                sleep 300
                MouseClick, Left
                if (biomeItemMessage) {
                    try SendWebhook(":joystick: Biome Selector is Recharging!", "3225405")
                }
            } else {
                MouseMove, %ConfirmX%, %ConfirmY%, 3
                sleep 300
                MouseClick, Left
                if (biomeItemMessage) {
                    try SendWebhook(":joystick: Biome Selector was used to select " . selectedBiome . ".", "3225405")
                }
            }
        }
        sleep 3000
    } else {
        if (biomeItemMessage) {
            try SendWebhook(":joystick: Biome Selector couldn't be Found!.", "3225405")
        }
    }
}

; Biome Randomizer Toggle
RunBiomeRandomizer() {
    global biomeItemMessage
    MouseMove, 45, 521, 3
    sleep 300
    Click, Left
    MouseMove, 1280, 343, 3
    sleep 300
    Click, Left
    MouseMove, 820, 370, 3
    sleep 300
    Click, Left
    Clipboard := "Biome Randomizer"
    sleep 150
    Send, ^v
    MouseMove, 850, 485, 3
    sleep 300
    Click, Left            
    MouseMove, 690, 585, 3
    sleep 300
    if (biomeItemMessage) {
        SendWebhook(":joystick: Biome Randomizer Activated!", 0)
    }
    Click, Left
    sleep 300
    MouseMove, 45, 521, 3
    sleep 300
    Click, Left
    sleep, 600
}


UpdateGUI:
if (toggle) {
    GuiControl,, StatusText, Running
    GuiControl, +c0x00DD00, StatusText
    GuiControl,, ResStatusText, Active - %res%

    elapsed := A_TickCount - startTick
    hours := elapsed // 3600000
    minutes := (elapsed - hours * 3600000) // 60000
    seconds := (elapsed - hours * 3600000 - minutes * 60000) // 1000
    timeStr := Format("{:02d}:{:02d}:{:02d}", hours, minutes, seconds)
    GuiControl,, RuntimeText, %timeStr%
    GuiControl, +c0x00DD00, RuntimeText
    GuiControl,, CyclesText, %cycleCount%
    GuiControl, +c0x00DD00, CyclesText

} else {
    GuiControl,, StatusText, Stopped
    GuiControl, +c0xFF4444, StatusText
    GuiControl,, ResStatusText, Ready
}
return

; misc functions
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

ServerLinkConverter() {
    global privateServerLink, privateServerLinkDeepLink
    RegExMatch(privateServerLink, "code=([^&]+)", codeMatch)
    code := codeMatch1
    privateServerLinkDeepLink := "roblox://navigation/share_links?code=" . code . "&type=Server"
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
        if (closeCollectionType = "\ Key/UI Navigation") {
            sleep, 1000
            MouseMove, 47, 467, 3
            sleep 220
            Click, Left
            sleep 320
            Send, {\}
            sleep, 400
            Send, {Enter}
            sleep 320
            Send, {\}
            sleep, 350
            Click, WheelUp 80
            sleep 500
            Click, WheelDown 45
            sleep 300
        } else if (closeCollectionType = "Click") {
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
        }
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
    sleep 15000
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
    global privateServerLinkDeepLink
    SendWebhook("Rejoining Server link...", 0)
    Run, % "powershell -NoProfile -Command ""Start-Process '" . privateServerLinkDeepLink . "'"""
}

ZeusAbility() {
    Send, {f up}
    Send, {f down}
}

LimboFish() {
    sleep, 1000
    if (limboFailsafe) {
        Send, {Esc}
        Sleep, 650
        Send, R
        Sleep, 650
        Send, {Enter}
        sleep 3000
    }
    /*
    ; stop rolling
    sleep, 1000
    MouseMove, 760, 1020, 3
    sleep, 150
    Click, Left
    sleep, 300
    */
        /*
    if (autoUnequip && !useNothing) {
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
        sleep 500
    }

    if (autoUnequip && useNothing) {
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
        sleep 500
    }
        */

    ; equips zeus
    MouseMove, 45, 412, 3
    sleep 150
    Click, Left
    MouseMove, 820, 370, 3
    sleep 400
    Click, Left
    Send, Zeus
    sleep 350
    MouseMove, 830, 441, 3
    sleep 500
    Send, {WheelUp 100}
    Sleep, 750
    Click, Left
    sleep 500
    MouseMove, 634, 638, 3
    sleep 350
    Click, Left
    sleep 700
    MouseMove, 1425, 303, 3
    sleep 350
    Click, Left
    sleep 600

    ; open inventory for protable crack
    MouseMove, 45, 521, 3
    sleep 500
    Click, Left
    MouseMove, 1280, 343, 3
    sleep 500
    Click, Left
    MouseMove, 820, 370, 3
    sleep 500
    Click, Left
    Send, Portable Crack
    sleep 350
    MouseMove, 850, 485, 3
    sleep 500
    Click, Left

    ; uses portable crack
    MouseMove, 690, 585, 3
    Send, {f up}
    ZeusAbility()
    Click, Left
    sleep 2000
    MouseMove, 45, 521, 3
    sleep 300
    Click, Left
    sleep, 600
    if (limboFailsafe) {
        PixelGetColor, ifinlimbo, 1873 , 1050, RGB
        if (ifinlimbo = 0xFCFCFD || ifinlimbo = 0xFDFDFE) {
            try SendWebhookForcePing("Successfully entered Limbo!", 0)
            FishingSpot()
        } else {
            try SendWebhookForcePing("Failed to enter Limbo.\n Attempting Again...", 0)
            LimboFish()
        }
    }
    enteredLimbo := true
}

; countdown functions

CountdownTooltip(baseText, seconds, x, y, ByRef cancelFlag) {
    Loop % seconds {
        if (cancelFlag)
            return
        remaining := seconds - A_Index + 1
        label := (remaining = 1) ? baseText : baseText " (" remaining ")"
        ToolTip, %label%, %x%, %y%
        Sleep, 1000
    }
    ToolTip
}

ShowClipTextGlobal() {
    global blehblehbleh
    CountdownTooltip("Clipped with Aery's Fishsol. F4 To Cancel", 10, 900, 10, blehblehbleh)
    blehblehbleh := ""
}

ShowClipTextTrans() {
    global blehblehbleh
    CountdownTooltip("Clipped with Aery's Fishsol. F4 To Cancel", 20, 900, 10, blehblehbleh)
    blehblehbleh := ""
}

ClipCountdownGlobal() {
    global webResponse
    CountdownTooltip("F4 To cancel webhook. Clipping Timer will start after...", 10, 850, 10, webResponse)
}

ClipCountdown() {
    global webResponse
    CountdownTooltip("F4 To cancel webhook", 10, 900, 10, webResponse)
}

; tool functions

EnsureFullscreen() {
    WinActivate, ahk_exe RobloxPlayerBeta.exe
    sleep, 250
    PixelGetColor, robloxicon, 42, 41, RGB
    if (robloxicon != 0xF7F7F8) {
        Send, {F11}
        Sleep, 1000
    }
}

ClipMethod:
    Send, !{F10}
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
    WinActivate, ahk_exe RobloxPlayerBeta.exe
}

ClipBiome() {
    Send, !{F10}
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

FishingSpot() {
    global keyW, keyA, azertyPathing, res, toggle, maxLoopCount, fishingLoopCount
    global strangeControllerLastRun, biomeRandomizerLastRun, checkGhostServerLastRun
    global startTick, cycleCount, restartingMacro, MaxLoopInput, FishingLoopInput
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
    sleep 1300
    Send, {%keyA% Up}
    sleep 75
    Send, {%keyW% Down}
    sleep 2670
    Send, {%keyW% Up}
}

FishingSpotSelling() {
    global keyW, keyA, azertyPathing, res, toggle, maxLoopCount, fishingLoopCount
    global strangeControllerLastRun, biomeRandomizerLastRun, checkGhostServerLastRun
    global startTick, cycleCount, restartingMacro, MaxLoopInput, FishingLoopInput
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
        MouseMove, 680, 804, 3
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
    sleep 1300
    Send, {%keyA% Up}
    sleep 75
    Send, {%keyW% Down}
    sleep 2682
    Send, {%keyW% Up}
    if (MaxLoopInput > 0) {
        maxLoopCount := MaxLoopInput
    }
    if (FishingLoopInput > 0) {
        fishingLoopCount := FishingLoopInput
    }
    toggle := true
    checkGhostServerLastRun := 0

    if (startTick = "") {
        startTick := A_TickCount
    }
    if (cycleCount = "") {
        cycleCount := 0
    }
    checkGhostServerLastRun := 0
    WinActivate, ahk_exe RobloxPlayerBeta.exe
    SetTimer, UpdateGUI, 1000
    SetTimer, DoMouseMove, 100
    try SendWebhook(":green_circle: Macro Started!", "7909721")
}

ClearLogs:
    FileDelete, %logDir%\*.log
    FileDelete, %ROBLOX_LOGS%
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

; extra updaters

SelectItem:
    Gui, Submit, NoHide
    selectedItem := AutoCraft
return

ClipType:
    Gui, Submit, NoHide
    clipType := ClipVersion
    IniWrite, %clipType%, %fishSolSettingsFilePath%, Macro, clipType
return

SkipType:
    Gui, Submit, NoHide
    skipType := SkipPotionType
    IniWrite, %skipType%, %fishSolSettingsFilePath%, Macro, skipType
return

CloseCollectionType:
    Gui, Submit, NoHide
    CloseCollectionType := CloseCollectionVersion
    IniWrite, %CloseCollectionType%, %fishSolSettingsFilePath%, Macro, closeCollectionType
return

UpdateUserID:
    Gui, Submit, NoHide
    webhookID := UserIDInput
    IniWrite, %webhookID%, %fishSolSettingsFilePath%, Macro, webhookID
return

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

    This Replay System can be used even if you're not using the macro
        )

    Gui, NvidiaNotes:Add, Button, x225 y190 w100 h25 gCloseNvidiaNotes, Close
    Gui, NvidiaNotes:Show, w550 h230
return

CloseNvidiaNotes:
    Gui, NvidiaNotes:Destroy
return

OpenAuraFilter:
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
        auraName := aura . "_chk"
        StringReplace, auraName, auraName, -, _, All
        StringReplace, auraName, auraName, %A_Space%, _, All
        options := "x" x " y" y " w180 h20 BackgroundTrans c0xCCCCCC v" auraName " gAuraCheckChange"
        if (EnabledAuras[aura])
            options .= " Checked"
        Gui, AuraFilter:Add, CheckBox, %options%, %aura%
    }

    yColumns := 55 + itemsPerCol * 22 + 10
    SaveButtonY := yColumns
    Gui, AuraFilter:Font, s10 cWhite Bold, Segoe UI
    Gui, AuraFilter:Add, Button, x190 y%SaveButtonY% w180 h30 gSaveAuraFilter, Save Aura Filter

    WindowHeight := SaveButtonY + 50
    Gui, AuraFilter:Show, w580 h%WindowHeight%, Aura Filter
return

AuraFilterClose:
    Gui, AuraFilter:Destroy
return

OpenWebhookList:
    global ClipWebhook, GlobalTranscendentPing, WebhookURL, UserID
    Gui, WebhookList:New, +AlwaysOnTop, Webhook List
    Gui, WebhookList:Color, 041024
    Gui, WebhookList:Font, s10 cWhite Bold, Segoe UI
    Gui, WebhookList:Add, Text, x-15 y10 w600 h20 Center BackgroundTrans c0xFFAA00,Toggle Webhooks Options (Requires a Webhook URL and/or User ID)

    Gui, Font, s10 cWhite Bold
    Gui, Add, GroupBox, x23 y45 w534 h65 cWhite, Aura Detection Ping

    Gui, Add, Button, x310 y70 w80 h25 gToggleGlobalTranscendentPing vGlobalTranscendentPingBtn, Toggle
    Gui, Font, s10 cWhite Normal
    Gui, Add, Text, x40 y74 w300 h25 BackgroundTrans c0xCCCCCC, Ping User if global/transcendent detected: 
    Gui, Font, s9 c0xCCCCCC Bold
    Gui, Add, Text, x400 y74 w60 h25 vGlobalTranscendentPingStatus BackgroundTrans, OFF



    Gui, Font, s10 cWhite Bold
    Gui, Add, GroupBox, x23 y115 w534 h65 cWhite, Clip Message

    Gui, Add, Button, x50 y140 w80 h25 gToggleClipWebhook vClipWebhookBtn, Toggle
    Gui, Add, Button, x310 y140 w80 h25 gToggleClipWebhookPing vClipWebhookPingBtn, Toggle
    Gui, Font, s9 cWhite Normal
    Gui, Add, Text, x240 y144 w100 h25 BackgroundTrans c0xCCCCCC, Ping User: 
    Gui, Font, s7 cWhite Normal
    Gui, Add, Text, x455 y126 w80 h100 BackgroundTrans c0xCCCCCC, Messages and/or pings if anything has been clipped via Webhook.
    Gui, Font, s9 c0xCCCCCC Bold   
    Gui, Add, Text, x400 y144 w60 h25 vClipWebhookPingStatus BackgroundTrans, OFF
    Gui, Add, Text, x140 y144 w60 h25 vClipWebhookStatus BackgroundTrans, OFF



    Gui, Font, s10 cWhite Bold
    Gui, Add, GroupBox, x23 y185 w534 h65 cWhite, Macro Start/Stop Message

    Gui, Add, Button, x310 y210 w80 h25 gToggleActivationMessage vActivationMessageBtn, Toggle
    Gui, Font, s10 cWhite Normal
    Gui, Add, Text, x40 y214 w300 h25 BackgroundTrans c0xCCCCCC, Message if macro has been started/stopped: 
    Gui, Font, s9 c0xCCCCCC Bold   
    Gui, Add, Text, x400 y214 w60 h25 vActivationMessageStatus BackgroundTrans, OFF



    Gui, Font, s10 cWhite Bold
    Gui, Add, GroupBox, x23 y255 w534 h65 cWhite, Biome Item Message

    Gui, Add, Button, x310 y280 w80 h25 gToggleBiomeItemMessage vBiomeItemMessageBtn, Toggle
    Gui, Font, s10 cWhite Normal
    Gui, Add, Text, x40 y284 w300 h25 BackgroundTrans c0xCCCCCC, Message if macro uses a biome item: 
    Gui, Font, s9 c0xCCCCCC Bold   
    Gui, Add, Text, x400 y284 w60 h25 vBiomeItemStatus BackgroundTrans, OFF



    Gui, Font, s10 cWhite Bold
    Gui, Add, GroupBox, x23 y325 w534 h145 cWhite, Failsafe Messages

    Gui, Add, Button, x310 y350 w80 h25 gToggleFailsafeMessage vFailsafeMessageBtn, Toggle
    Gui, Font, s10 cWhite Normal
    Gui, Add, Text, x40 y354 w300 h25 BackgroundTrans c0xCCCCCC, Message if macro triggers fishing failsafe: 
    Gui, Font, s9 c0xCCCCCC Bold   
    Gui, Add, Text, x400 y354 w60 h25 vFailsafeMessageStatus BackgroundTrans, OFF

    Gui, Font, s10 cWhite Bold
    Gui, Add, Button, x310 y390 w80 h25 gToggleFailsafeMessagePing vFailsafeMessagePingBtn, Toggle
    Gui, Font, s10 cWhite Normal
    Gui, Add, Text, x40 y394 w300 h25 BackgroundTrans c0xCCCCCC, Ping if macro triggers fishing failsafe: 
    Gui, Font, s9 c0xCCCCCC Bold   
    Gui, Add, Text, x400 y394 w60 h25 vFailsafeMessagePingStatus BackgroundTrans, OFF

    Gui, Font, s10 cWhite Bold
    Gui, Add, Button, x310 y430 w80 h25 gToggleRestartMacroFailsafePing vRestartMacroFailsafePingBtn, Toggle
    Gui, Font, s10 cWhite Normal
    Gui, Add, Text, x40 y434 w300 h25 BackgroundTrans c0xCCCCCC, Ping if macro triggers restart failsafe: 
    Gui, Font, s9 c0xCCCCCC Bold   
    Gui, Add, Text, x400 y434 w60 h25 vRestartMacroFailsafePingStatus BackgroundTrans, OFF

    UpdateStatus("ClipWebhookStatus", clipWebhook)
    UpdateStatus("ClipWebhookPingStatus", clipWebhookPing)
    UpdateStatus("GlobalTranscendentPingStatus", globalTranscendentPing)
    UpdateStatus("ActivationMessageStatus", activationMessage)
    UpdateStatus("BiomeItemStatus", biomeItemMessage)
    UpdateStatus("FailsafeMessageStatus", failsafeMessage)
    UpdateStatus("FailsafeMessagePingStatus", failsafeMessagePing)
    UpdateStatus("RestartMacroFailsafePingStatus", restartMacroFailsafePing)

    Gui, WebhookList:Show, w580 h500, Webhook Options List
return

WebhookListClose:
    Gui, WebhookList:Destroy
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

AuraBiomeDetect:
global webhookURL, webhookID, clipWebhookPing, prevState, blehblehbleh, prevBiome, biome, webResponse, biomeIndex, auraColor
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
                
            if (!AuraListTrans.HasKey(auraName) && auraName != "Nothing" && auraName != "Heatstroke") {
                    if (!AuraList.HasKey(auraName) && (!auraFilter || !EnabledAuras[auraName])) { ; normal auras
                        ping4Aura := false
                        SendWebhookAuras("## Aura Equipped - " auraName, auracolor)
                    } else if (auraFilter) { ; check aura filter and see if the aura is enabled
                        if (AuraList.HasKey(auraName) && EnabledAuras[auraName] && !webResponse) {
                            ping4Aura := true
                            SendWebhookAuras("## Aura Equipped - " auraName, auracolor)
                            ping4Aura := false
                        } else if (AuraList.HasKey(auraName) && !EnabledAuras[auraName] && !webResponse) { ; if aura is disabled in aura filter, it js sends webhook on the aura without pinging
                            ping4Aura := false
                            SendWebhookAuras("## Aura Equipped - " auraName, auracolor)
                        }
                    } else if (!auraFilter) { ; no aura filter, checks global list
                        if (AuraList.HasKey(auraName) && !webResponse) {
                            ping4Aura := true
                            SendWebhookAuras("## Aura Equipped - " auraName, auracolor)
                            ping4Aura := false
                        }
                    }
                }

                

                if (auraName = "Pixelation") {
                    ClipCountdownGlobal()
                    if (!webResponse) {
                        SendWebhook2(":tada: **Mania!** :tada: \n**[1 in 1,073,741,824!]** \nAura detected: " auraName, 3348986, "https://raw.githubusercontent.com/knowaery/Aery-s-Fishsol/main/auraimages/PixelationCollection.webp")
                    }
                } else if (auraName = "Luminosity") {
                    ClipCountdownGlobal()
                    if (!webResponse) {
                        SendWebhook2( ":tada: **The Absolute Radiance** :tada: \n**[1 in 1,200,000,000!]** \nAura detected: " auraName , 11393254, "https://raw.githubusercontent.com/knowaery/Aery-s-Fishsol/main/auraimages/ReworkedLumiCollection.webp")
                    }
                } else if (auraName = "LEVIATHAN") {
                    ClipCountdownGlobal()
                    if (!webResponse) {
                        SendWebhook2("**The Ruler of the Beneath** \n**[1 in 1,730,000,000 from Rainy!]** \nAura detected: " auraName, 5600, "https://raw.githubusercontent.com/knowaery/Aery-s-Fishsol/main/auraimages/LeviathanLong.png")
                    }
                } else if (auraName = "ASTRAIOS") {
                    ClipCountdownGlobal()
                    if (!webResponse) {
                        SendWebhook2("**Dragon** \n**[1 in 1,750,000,000 from Singularity!]** \nAura detected: " auraName, 3920232, "https://raw.githubusercontent.com/knowaery/Aery-s-Fishsol/main/auraimages/Astraios.gif")
                    }
                } else if (auraName = "BREAKTHROUGH") {
                    ClipCountdownGlobal()
                    if (!webResponse) {
                        SendWebhook2("**How much do you believe in this world?**\n**[1 in 1,999,999,999!]** \nAura detected: " auraName, 3289154, "https://raw.githubusercontent.com/knowaery/Aery-s-Fishsol/main/auraimages/BreakthroughCollection.webp")
                    }
                } else if (auraName = "Dream Catcher") {
                    ClipCountdownGlobal()
                    if (!webResponse) {
                        SendWebhook2("**I close my eyes...\nIs this a dream? ** \n**[1 in 2,222,222,222 from Nighttime!]**  \nAura detected: " auraName, 12476663, "https://raw.githubusercontent.com/knowaery/Aery-s-Fishsol/main/auraimages/DreamcatcherCollection.webp")
                    }
                } else if (auraName = "EQUINOX") {
                    ClipCountdownGlobal()
                    if (!webResponse) {
                        SendWebhook2("**Equilibrium Incarnate**\n**[1 in 2,500,000,000!]** \nAura detected: " auraName, 16777215, "https://raw.githubusercontent.com/knowaery/Aery-s-Fishsol/main/auraimages/EquinoxNewCollection.webp")
                    }
                } else if (auraName = "MONARCH") {
                    ClipCountdownGlobal()
                    if (!webResponse) {
                        SendWebhookMonarch("**[1 in 3,000,000,0000 from Corruption!]**\nAura detected: " auraName, 4330383, "https://raw.githubusercontent.com/knowaery/Aery-s-Fishsol/main/auraimages/MonarchCollection.webp")
                    }
                } else if (auraName = "meta") {
                    ClipCountdownGlobal()
                    if (!webResponse) {
                        SendWebhook2("**[1 in 10,000 from Cyberspace!]**\nAura detected: " auraName , 736657, "https://raw.githubusercontent.com/knowaery/Aery-s-Fishsol/main/auraimages/MetaCollection.webp")
                    }
                } else if (auraName = "illusionary") {
                    ClipCountdownGlobal()
                    if (!webResponse) {
                       SendWebhook2("**THE PERFECT PUPPET**\n**[1 in 10,000,000 from Cyberspace!]** \nAura detected: " auraName, 736657, "https://raw.githubusercontent.com/knowaery/Aery-s-Fishsol/main/auraimages/Illusionary_curation.gif")
                    }
                }

                if (auraName = "TAVERNA") {
                    ClipCountdownGlobal()
                    if (!webResponse) {
                        SendWebhook2("**Opened the Tavern!**\n**[1 in 1,444,444,444 from Blazing Sun!]**\nAura detected: " auraName, 16361845, "https://raw.githubusercontent.com/knowaery/Aery-s-Fishsol/main/auraimages/TavernaCollection.webp" )
                    }
                } else if (auraName = "CENTAURUS") {
                    ClipCountdownGlobal()
                    if (!webReponse) {
                        SendWebhook2("**Conqueror of the Sun!**\n**[1 in 3,000,000,000 from Blazing Sun!]**\nAura detected: " auraName, 16580586, "https://raw.githubusercontent.com/knowaery/Aery-s-Fishsol/main/auraimages/CentaurusCollection.png")
                    }
                }
                
                
                if (auraFilter) {
                    if (AuraList.HasKey(auraName) && EnabledAuras[auraName] && detectGlobal && !webResponse) {
                        SetTimer, ClipMethod, -%triggerDelayGlobal%
                        decideAuraClip := true
                        ShowClipTextGlobal()
                    }
                } else {
                    if (AuraList.HasKey(auraName) && detectGlobal && !webResponse) {
                        SetTimer, ClipMethod, -%triggerDelayGlobal%
                        decideAuraClip := true
                        ShowClipTextGlobal()
                    }
                }

                if (AuraListTrans.HasKey(auraName) && detectTrans && !webResponse) {
                    SetTimer, ClipMethod, -%triggerDelayTrans%
                    decideAuraClip := true
                    ShowClipTextTrans()
                }

                if (toggle && autoUnequip && auraName != "Nothing") {
                        pendingUnequip := true
                    }
                }

                prevState := state
                decideAuraClip := false
                }
            }
    
        
            if (autoWarp || biomeDetect) {
                if (biome && biome != "" && biome != prevBiome) {
                    if (biomeDetect && toggle) {
                    biomeKey := "Biome" StrReplace(biome, " ", "")
                    IniRead, isBiomeEnabled, %fishSolSettingsFilePath%, "Biomes", %biomeKey%, 1

                    ; end
                    if ((prevBiome != "" && prevBiome != "Normal") || (prevBiome = "GLITCHED" || prevBiome = "DREAMSPACE" || prevBiome = "CYBERSPACE" || prevBiome = "SINGULARITY") && (biome != prevBiome)) {
                        if (biomeData.HasKey(prevBiome)) {
                            endColor := biomeData[prevBiome].color
                        }

                        endwebhookTime := A_NowUTC
                        endTimestamp := SubStr(endwebhookTime,1,4) "-" SubStr(endwebhookTime,5,2) "-" SubStr(endwebhookTime,7,2) "T" SubStr(endwebhookTime,9,2) ":" SubStr(endwebhookTime,11,2) ":" SubStr(endwebhookTime,13,2) ".000Z"
                        endwebhookUnix := A_NowUTC
                        EnvSub, endwebhookUnix, 19700101000000, Seconds

                        enddescription := "> ### Biome Ended - " prevBiome " "

                        endJson := "{"
                        . """embeds"": ["
                        . "  {"
                        . "    ""title"": ""<t:" endwebhookUnix ":F> (<t:" endwebhookUnix ":R>)"","
                        . "    ""description"": """ enddescription ""","
                        . "    ""color"": " biomeColor ","
                        . "    ""footer"": {""text"": ""fishSol v1.9.8"", ""icon_url"": ""https://purestellenium.github.io/fishSol%20icon.png""},"
                        . "    ""timestamp"": """ endTimestamp """"
                        . "  }"
                        . "],"
                        . """content"": """""
                        . "}"

                        endHttp := ComObjCreate("WinHttp.WinHttpRequest.5.1")
                        endHttp.Open("POST", webhookURL, false)
                        endHttp.SetRequestHeader("Content-Type", "application/json")
                        try endHttp.Send(endJson)
                    }

                    
                    ; start
                    if ((isBiomeEnabled = 1 || biome = "GLITCHED" || biome = "DREAMSPACE" || biome = "CYBERSPACE" || biome = "SINGULARITY") && biome != "Normal") {

                        if (biomeData.HasKey(biome)) {
                            biomeColor    := biomeData[biome].color
                            thumbnail_url := biomeData[biome].thumbnail
                        }

                        startwebhookTime := A_NowUTC
                        startTimestamp := SubStr(startwebhookTime,1,4) "-" SubStr(startwebhookTime,5,2) "-" SubStr(startwebhookTime,7,2) "T" SubStr(startwebhookTime,9,2) ":" SubStr(startwebhookTime,11,2) ":" SubStr(startwebhookTime,13,2) ".000Z"
                        startwebhookUnix := A_NowUTC
                        EnvSub, startwebhookUnix, 19700101000000, Seconds


                        if (biome = "GLITCHED" || biome = "DREAMSPACE" || biome = "CYBERSPACE") {
                            content := "@everyone"
                        } else {
                            content := ""
                        }

                        description := "> ## Biome Started - " biome "\n> ### [Join Server](" privateServerLink ")  "

                        json := "{"
                        . """embeds"": ["
                        . "  {"
                        . "    ""title"": ""<t:" startwebhookUnix ":F> (<t:" startwebhookUnix ":R>)"","
                        . "    ""description"": """ description ""","
                        . "    ""color"": " biomeColor ","
                        . "    ""thumbnail"": {""url"": """ thumbnail_url """},"
                        . "    ""footer"": {""text"": ""fishSol v1.9.8"", ""icon_url"": ""https://purestellenium.github.io/fishSol%20icon.png""},"
                        . "    ""timestamp"": """ startTimestamp """"
                        . "  }"
                        . "],"
                        . """content"": """ content """"
                        . "}"

                        http := ComObjCreate("WinHttp.WinHttpRequest.5.1")
                        http.Open("POST", webhookURL, false)
                        http.SetRequestHeader("Content-Type", "application/json")
                        try http.Send(json)
                    }
                }

                if (biome = "CYBERSPACE" && toggle && autoWarp && (prevBiome != "CYBERSPACE" || prevBiome = "")) {
                    pendingSkips := true
                }

                if ((toggle) && (detectGlobal || detectTrans) && (prevBiome = "GLITCHED" || prevBiome = "DREAMSPACE" || prevBiome = "CYBERSPACE") && (biome != prevBiome)) {
                    ClipBiome()
                }

                prevBiome := biome
                cancelRareBiomeWebhook := false
            }
        }
return


F1::
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
        enteredLimbo := false
        IniWrite, %selectedItem2%, %fishSolSettingsFilePath%, Macro, selectedItem2
        IniWrite, %res%, %fishSolSettingsFilePath%, Macro, resolution
        IniWrite, %maxLoopCount%, %fishSolSettingsFilePath%, Macro, maxLoopCount
        IniWrite, %fishingLoopCount%, %fishSolSettingsFilePath%, Macro, fishingLoopCount
        WinActivate, ahk_exe RobloxPlayerBeta.exe
        SetTimer, UpdateGUI, 1000
        SetTimer, DoMouseMove, 100
        if (activationMessage) {
            try SendWebhook(":green_circle: Macro Started!", "7909721")
        }
    }
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

    IniWrite, %selectedItem%, %fishSolSettingsFilePath%, Macro, selectedItem
    autocrafting := true

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
    if (activationMessage) {
        try SendWebhook("Crafting Started on " selectedItem ":tools:", 0)
    }

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
    Send, {f up}
    send, {shift up}
    enteredlimbo := false
    if (toggle) {
        if (activationMessage) {
            try SendWebhook(":red_circle: Macro Stopped.", "0")
        }
    } else if (autocrafting) {
        if (activationMessage) {
            try SendWebhook(":red_circle: Macro Stopped.", "0")
        }
    }
    toggle := false
    Reload
return

F4::
global blehblehbleh, webResponse, auraName

    blehblehbleh := "hehe"
    webResponse := true

        if ((detectGlobal || detectTrans) && auraDetection) {
            SetTimer, ClipMethod, Off
            SetTimer, AuraBiomeDetect, Off
        if (clipWebhook && AuraList.HasKey(auraName) && decideAuraClip) {
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

F6::
    RunRejoin2()
return


DoMouseMove:
if (toggle) {
    global pathingMode
    global privateServerLink
    global globalFailsafeTimer
    global azertyPathing
    global autoUnequip
    global strangeController
    global biomeRandomizer
    global strangeControllerTime
    global biomeRandomizerTime
    global strangeControllerInterval
    global biomeRandomizerInterval
    global strangeControllerLastRun
    global biomeRandomizerLastRun
    global startTick
    global failsafeWebhook
    global pathingWebhook
    loopCount := 0
    keyW := azertyPathing ? "z" : "w"
    keyA := azertyPathing ? "q" : "a"
    restartPathing := false
    Loop {
        if (!toggle) {
            break
        }

        if (autoWarp && pendingSkips) {
            if (skipType = "Transcendent Potion") {
                SendWebhookForcePing("Popping Transcendent Potion", 0)
            } else {
                try SendWebhookForcePing("Popping Warp Potion", 0)
            }
            if (pendingEnterLimbo || enteredLimbo) {
                Send, {Esc}
                Sleep, 650
                Send, R
                Sleep, 650
                Send, {Enter}
                sleep 3000
                pendingEnterLimbo := false
                enteredLimbo := false
            }
            PopSkips()
            pendingSkips := false
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
        ; limbo stuff
        if (fishInLimbo && !enteredLimbo) {
            LimboFish()
            enteredLimbo := true
            SendWebhook("Mini Version")
        }
        ; SC Toggle
        if (strangeController) {
            elapsed := A_TickCount - startTick
            if (strangeControllerLastRun = 0 && elapsed >= strangeControllerTime) {
                RunStrangeController()
                strangeControllerLastRun := elapsed
            } else if (strangeControllerLastRun > 0 && (elapsed - strangeControllerLastRun) >= strangeControllerInterval) {
                RunStrangeController()
                strangeControllerLastRun := elapsed
            }
        }

        ; BR Toggle
        if (biomeRandomizer) {
            elapsed := A_TickCount - startTick
            if (biomeRandomizerLastRun = 0 && elapsed >= biomeRandomizerTime) {
                RunBiomeRandomizer()
                biomeRandomizerLastRun := elapsed
            } else if (biomeRandomizerLastRun > 0 && (elapsed - biomeRandomizerLastRun) >= biomeRandomizerInterval) {
                RunBiomeRandomizer()
                biomeRandomizerLastRun := elapsed
            }
        }

        ; Biome Selector Toggle
        if (biomeSelector) {
            elapsed := A_TickCount - startTick
            if (biomeSelectorLastRun = 0 && elapsed >= biomeSelectorTime) {
                RunBiomeSelector()
                biomeSelectorLastRun := elapsed
            } else if (biomeSelectorLastRun > 0 && (elapsed - biomeSelectorLastRun) >= biomeSelectorInterval) {
                RunBiomeSelector()
                biomeSelectorLastRun := elapsed
            }
        }
        PixelGetColor, deletebutton, 1106, 919, RGB
        if (deletebutton = 0xFF5A5D && !sentstoragefull) {
            try SendWebhookForcePing("Max Storage Detected", 0)
            sentstoragefull := true
        }
    

    loopCount++
    if (loopCount > maxLoopCount) {
            Send, {Esc}
            Sleep, 650
            Send, R
            Sleep, 650
            Send, {Enter}
            sleep 3000
        if (closeCollectionType = "\ Key/UI Navigation") {
            sleep, 1000
            MouseMove, 47, 467, 3
            sleep 220
            Click, Left
            sleep 320
            Send, {\}
            sleep, 400
            Send, {Enter}
            sleep 320
            Send, {\}
            sleep, 350
            Click, WheelUp 80
            sleep 500
            Click, WheelDown 45
            sleep 300
        } else if (closeCollectionType = "Click") {
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
            Send {s Up}
            sleep 300
            Send {Space Down}
            sleep 25
            Send {%keyW% Down}
            sleep 1200
            Send {Space Up}
            sleep 200
            Send {%keyW% Up}
            sleep 300
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
                sleep 400
                PixelSearch, , , 560, 640, 680, 645, 0xFFFFFF, 1, Fast RGB
                if ErrorLevel != 0
                break
                MouseMove, 680, 804, 3
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
            sleep 2670
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
        if (globalFailsafeTimer = 0) {
        globalFailsafeTimer := A_TickCount
        }
        fishingFailsafeRan := false
        failsafeTime := 0
        Loop {
        PixelGetColor, color, 1176, 836, RGB
        if (color = 0xFFFFFF) {
        MouseMove, 950, 880, 3
        ; Get randomized bar color
        Sleep 50
        PixelGetColor, barColor, 955, 767, RGB
        SetTimer, DoMouseMove, Off
        globalFailsafeTimer := 0
        break
        }

        ; Fishing Failsafe
        if (A_TickCount - startWhitePixelSearch > (fishingFailsafeTime * 1000) && !fishingFailsafeRan) {
        MouseMove, 1350, 941, 3
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
        failsafeTime := A_TickCount
        if (failsafeMessage && failsafeMessagePing) {
            try SendWebhookForcePing("Fishing Failsafe Activated", 14495300)
        } else if (failsafeMessage && !failsafeMessagePing) {
            try SendWebhook("Fishing Failsafe Activated", 14495300)
        }
        }
        
        if (restartMacroFailsafe && failsafeTime > 0 && A_TickCount - failsafeTime > 120 * 1000) {
            restartMacroFailsafeTriggers++
        if (restartMacroFailsafePing) {
            try SendWebhookForcePing("Restart Macro Failsafe Activated - Restarting Macro...", 14495300)
        } else {
            try SendWebhook("Fishing Failsafe Activated - Restarting Macro...", 0)
        }
        toggle := false
        SetTimer, DoMouseMove, Off
        SetTimer, UpdateGUI, Off
        Send, {w up}
        Send, {a up}
        Send, {s up}
        Send, {d up}
        Send, {space up}
        Send, {e up}
        Send, {esc up}
        Send, {r up}
        sleep, 300
        Send, {Esc}
        Sleep, 650
        Send, R
        Sleep, 650
        Send, {Enter}
        sleep 5000
        if (closeCollectionType = "\ Key/UI Navigation") {
            sleep, 1000
            MouseMove, 47, 467, 3
            sleep 220
            Click, Left
            sleep 320
            Send, {\}
            sleep, 400
            Send, {Enter}
            sleep 320
            Send, {\}
            sleep, 350
            Click, WheelUp 80
            sleep 500
            Click, WheelDown 45
            sleep 300
        } else if (closeCollectionType = "Click") {
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
        }
        FishingSpotSelling()
        return
        }

        if (restartMacroFailsafeTriggers > 3)
        

        if (!toggle) {
        Return
        }
        }


        ; PixelSearch loop
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
            ; Normal detection
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
        firstfishclick := false
        infiniteclickfailsafe := 0
        cycleCount++

        fixinfiniteclick:
        sleep 300
        MouseMove, 1113, 342, 3
        Sleep 700
        MouseClick, Left
        sleep 300
        firstfishclick := false
        infiniteclickfailsafe := 0
        cycleCount++
    }
}
return

StartScript:
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
        enteredLimbo := false
        IniWrite, %selectedItem2%, %fishSolSettingsFilePath%, Macro, selectedItem2
        IniWrite, %res%, %fishSolSettingsFilePath%, Macro, resolution
        IniWrite, %maxLoopCount%, %fishSolSettingsFilePath%, Macro, maxLoopCount
        IniWrite, %fishingLoopCount%, %fishSolSettingsFilePath%, Macro, fishingLoopCount
        WinActivate, ahk_exe RobloxPlayerBeta.exe
        SetTimer, UpdateGUI, 1000
        SetTimer, DoMouseMove, 100
        if (activationMessage) {
            try SendWebhook(":green_circle: Macro Started!", "7909721")
        }
    }
return

CloseScript:
    Send, {w up}
    Send, {a up}
    Send, {s up}
    Send, {d up}
    Send, {space up}
    Send, {e up}
    Send, {esc up}
    Send, {r up}
    Send, {f up}
    send, {shift up}
    enteredlimbo := false
    if (toggle) {
        if (activationMessage) {
            try SendWebhook(":red_circle: Macro Stopped.", "0")
        }
    } else if (autocrafting) {
        if (activationMessage) {
            try SendWebhook(":red_circle: Macro Stopped.", "0")
        }
    }
    toggle := false
    Reload
return

Dev1NameClick:
if (dev1_website) {
    Run, %dev1_website%
}
return

Dev1LinkClick:
    Run, %dev1_link%
return

Dev2NameClick:
if (dev2_website) {
    Run, %dev2_website%
}
return

Dev2LinkClick:
    Run, %dev2_link%
return

Dev3NameClick:
if (dev3_website) {
    Run, %dev3_website%
}
return

Dev3LinkClick:
    Run, %dev3_link%
return

Dev4NameClick:
if (dev4_website) {
    Run, %dev4_website%
}
Return

Dev4LinkClick:
    Run, %dev4_link%
return

Bonk:
    SetTimer, ResetBonkFunc, Off
    GuiControl,, IMG_Bonk , ./img/nadir_bonk.png
    SoundPlay, ./img/bonk.mp3
    while GetKeyState("LButton", "P")
        sleep 1
    GuiControl,, IMG_Bonk , ./img/nadir_unbonk.png
    SetTimer, ResetBonkFunc, -3000
return

RemoveToolTip:
    ToolTip
return

ResetBonkFunc:
    GuiControl,, IMG_Bonk , ./img/nadir.png
Return

/*
Send_WM_COPYDATA(ByRef StringToSend, ByRef TargetScriptTitle)
{
    VarSetCapacity(CopyDataStruct, 3 * A_PtrSize, 0)
    SizeInBytes := (StrLen(StringToSend) + 1) * (A_IsUnicode ? 2 : 1)
    NumPut(SizeInBytes, CopyDataStruct, A_PtrSize)
    NumPut(&StringToSend, CopyDataStruct, 2 * A_PtrSize)
    Prev_DetectHiddenWindows := A_DetectHiddenWindows
    Prev_TitleMatchMode := A_TitleMatchMode
    DetectHiddenWindows On
    SetTitleMatchMode 2
    SendMessage, 0x4a, 0, &CopyDataStruct,, %TargetScriptTitle%
    DetectHiddenWindows %Prev_DetectHiddenWindows%
    SetTitleMatchMode %Prev_TitleMatchMode%
    return ErrorLevel
}
*/
/*
    Receive_WM_COPYDATA(wParam, lParam)
    {
        SetBatchLines, -1
        StringAddress := NumGet(lParam + 2*A_PtrSize)
        CopyOfData := StrGet(StringAddress)
        List := StrSplit(CopyOfData, "`n")
        if CanProcessMessage(Data[1])
        {
            LastMessageData = SubStr(CopyOfData, 1, strlen(Data[1]))
            CanProcessMessage(LastMessageData)
            return true
        }
        return false
    }

    CanProcessMessage(Header)
    {
        ListOfFunctions := [ "biome", "aura"]
        SetBatchLines, -1
        for function in ListOfFunctions
            if function == Header
                return true
    }

    CanProcessMessage(Data)
    {
    }

*/

DoChatWait:
    sleep 3000
    PixelGetColor, ChatCheck, 132, 35, RGB
    while (ChatCheck ~= "0xF[4-9A-F]F[4-9A-F]F8")
    {
        PixelGetColor, ChatCheck, 132, 35, RGB
    }
return



LazyCheckItemDescription(senstivity, list*) {
    global res
    SetBatchLines, -1
    switch res
    {
        case "1080p":
            CheckItemDescription1080p(senstivity, list)
    }
}

CheckItemDescription1080p(senstivity, list*) {
    global _
    SetBatchLines, -1
    for c, list_color in list
    {
        ErrorLevel := 0
        PixelSearch, x, y, 490, 610, 625, 700, %list_color%, %senstivity%, Fast RGB
        if ErrorLevel = 0
            Continue

        ErrorLevel := 0
        PixelSearch, x, y, 625, 610, 760, 700, %list_color%, %senstivity%, Fast RGB
        if ErrorLevel = 0
            Continue

        ErrorLevel := 0
        PixelSearch, x, y, 490, 700, 625, 790, %list_color%, %senstivity%, Fast RGB
        if ErrorLevel = 0
            Continue

        ErrorLevel := 0
        PixelSearch, x, y, 625, 700, 760, 790, %list_color%, %senstivity%, Fast RGB
        if ErrorLevel != 0
            return false
    }
    return true
}

ReleasesClick:
    Run, https://github.com/knowaery/Aery-s-fishSol
return