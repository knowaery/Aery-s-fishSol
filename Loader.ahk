;#Requires AutoHotkey v1.1

#NoEnv
#SingleInstance Force
SetWorkingDir %A_ScriptDir%
fishSolScriptPath := A_ScriptDir "\Aery's fishSol.ahk"
fishSolURL := "https://raw.githubusercontent.com/knowaery/Aery-s-fishSol/main/files/Aery's%20fishSol.ahk"

try {
    ToolTip, Downloading..
    UrlDownloadToFile, %fishSolURL%, %fishSolScriptPath%
    ToolTip
    ToolTip, Initializing..
    Run, %fishSolScriptPath%
    ToolTip
} catch {
    if !FileExist(fishSolScriptPath) {
       MsgBox, 16, Error, Failed to download. Please download "Aery's fishSol.ahk" from https://github.com/knowaery/Aery-s-fishSol and run it within this folder.
    }
}
