; AutoHotKey that shows/hides a program window by pressing the <C-;> key.
; If the program is not running, it will start it.
;
; Great to make any program behave like the Quake console (toggle show/hide
; with a hotkey)
;
; Uses AutoHotKey: https://github.com/AutoHotkey/AutoHotkey/releases
;
;
; Terminal Emulator
;
; - WezTerm          https://github.com/wez/wezterm
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
version := "2.0"
website := "https://github.com/orumin/dotfiles"

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
#SingleInstance

; Load a few environment variables
userprofile := EnvGet("USERPROFILE")

; read config file
configFile := userprofile . "\.QuakeLikeConsole.ini"
LoadConfig()

; Tray icon customization
A_IconTip := "Quake Like Console (key: " . key . ")"
Tray:= A_TrayMenu
Tray.Delete() ; V1toV2: not 100% replacement of NoStandard, Only if NoStandard is used at the beginning ; remove standard Menu items
Tray.Add("Quake Like Console v" . version, Dummy)
Tray.Add("") ; separator
Tray.Add("&Suspend", ToggleSuspend)
Tray.Add("&Open config file", OpenConfig)
Tray.Add("") ; separator
tray.add("&About", Link)
Tray.Add("E&xit", ButtonExit)
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Handle Hotkey events
ToggleConsole(ThisHotkey)
{
    DetectHiddenWindows(true)
    ; see http://ahkscript.org/docs/misc/WinTitle.htm and use the AutoHotKey Window Spy
    if WinExist(windowMatcher) {
        DetectHiddenWindows(false)
        if WinActive() {
            WinHide()
        } else {
            WinShow()
            WinActivate()
        }
    } else {
        Try {
            Run(command, workingDir, "Max")  ; see http://ahkscript.org/docs/commands/Run.htm
        } Catch Error as e {
            TrayTip("Could not execute command", command, 3)
            Throw e
        }
    }
    Return
}


LoadConfig() {
    global key, configFile, command, workingDir, windowMatcher, userprofile

    Try {
        Hotkey(key, "Toggle")
    }

    command := IniRead(configFile, "Settings", "command", A_Space)
    if (command = "") {
        command := userprofile . "\wezterm\wezterm-gui.exe"
        IniWrite(command, configFile, "Settings", "command")
    }

    workingDir := IniRead(configFile, "Settings", "workingDir", A_Space)
    if (workingDir = "") {
        workingDir := userprofile
        IniWrite(workingDir, configFile, "Settings", "workingDir")
    }

    windowMatcher := IniRead(configFile, "Settings", "windowMatcher", A_Space)
    if (windowMatcher = "") {
        windowMatcher := "ahk_exe wezterm-gui.exe"
        IniWrite(windowMatcher, configFile, "Settings", "windowMatcher")
    }

    key := IniRead(configFile, "Settings", "key", A_Space)
    if (key = "") {
        key := "F1"
        IniWrite("F1", configFile, "Settings", "key")
    }

    IniWrite("https://goo.gl/uo0CRZ", configFile, "Help", "website")
    IniWrite("see https://www.autohotkey.com/docs/Hotkeys.htm", configFile, "Help", "key")
    IniWrite("see " . website, configFile, "Help", "windowMatcher")

    ; keyboard key (or key-combination) to toggle the console
    Try {
        Hotkey(key, ToggleConsole)
    } Catch Error {
        TrayTip("Invalid key", "using default: <C-;>", 3)
        key := "^;"
        IniWrite("^;", configFile, "Settings", "key")
        Hotkey(key, ToggleConsole)
    }
}


Link(A_ThisMenuItem, A_ThisMenuItemPos, MyMenu)
{
    Run(website)
    Return
}


ButtonExit(A_ThisMenuItem, A_ThisMenuItemPos, MyMenu)
{
    ExitApp()
    Return
}


ToggleSuspend(A_ThisMenuItem, A_ThisMenuItemPos, MyMenu)
{
    Suspend(-1)
    Tray.ToggleCheck("&Suspend")
    Return
}


OpenConfig(A_ThisMenuItem, A_ThisMenuItemPos, MyMenu)
{
    RunWait(configFile)
    LoadConfig()
    Reload()
    Return
}


Dummy(A_ThisMenuItem, A_ThisMenuItemPos, MyMenu)
{
    Return
}
