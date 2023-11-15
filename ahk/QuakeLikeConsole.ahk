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
#SingleInstance Force
#Warn

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
    dim := GetActiveMonitorDimention()
    ;MsgBox( "monIndex: " . dim.index . " x: " . dim.x . " y: " . dim.y . " width: " . dim.width . " height: " . dim.height)
    DetectHiddenWindows(true)
    ; see http://ahkscript.org/docs/misc/WinTitle.htm and use the AutoHotKey Window Spy
    local hwnd_id := WinExist(windowMatcher)
    if (hwnd_id != 0) {
        DetectHiddenWindows(false)
        if WinActive() {
            WinHide()
            ;AnimateWindow(hwnd_id, Integer(duration), 0x00050004)
        } else {
            DetectHiddenWindows(true)
            WinMove(dim.x, dim.y, dim.width, dim.height * Float(heightRatio), hwnd_id)
            ;AnimateWindow(hwnd_id, Integer(duration), 0x00060004)
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

GetActiveMonitorDimention()
{
    dim := {index: 0, x: 0, y: 0, width: 0, height: 0}
    CoordMode("Mouse", "Screen")
    MouseGetPos(&x, &y)
    local count := MonitorGetCount()
    Loop count {
        MonitorGet(A_Index, &Left, &Top, &Right, &Bottom)
        if (x >= Left) && (x <= Right) && (y <= Bottom) && (y >= Top) {
            dim.index := A_Index
            dim.x := Left
            dim.y := Top
            dim.width := Abs(Right - Left)
            dim.height := Abs(Top - Bottom)
        }
    } Until (dim.width > 0)
    return dim
}

;; Flag
; 0x00000001 = AW_HOR_POSITIVE (Left to Right)
; 0x00000002 = AW_HOR_NEGATIVE (Right to Left)
; 0x00000004 = AW_VER_POSITIVE (Top to Bottom)
; 0x00000008 = AW_VER_NEGATIVE (Bottom to Top)
; 0x00000010 = AW_CENTER
; 0x00010000 = AW_HIDE
; 0x00020000 = AW_ACTIVE
; 0x00040000 = AW_SLIDE
; 0x00080000 = AW_BLEND (Fade-In/Out)
AnimateWindow(hWnd, Duration, Flag)
{
    return DllCall("User32.dll\AnimateWindow", "Uint", hWnd, "Int", Duration, "Uint", Flag)
}

LoadConfig() {
    global key, configFile, command, heightRatio, duration, workingDir, windowMatcher, userprofile

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
        key := "^;"
        IniWrite(key, configFile, "Settings", "key")
    }

    heightRatio := IniRead(configFile, "Settings", "heightRatio", A_Space)
    if (heightRatio = "") {
        heightRatio := "0.6"
        IniWrite(heightRatio, configFile, "Settings", "heightRatio")
    }

    duration := IniRead(configFile, "Settings", "duration", A_Space)
    if (duration = "") {
        duration := "500"
        IniWrite(duration, configFile, "Settings", "duration")
    }

    IniWrite("https://github.com/orumin/dotfiles", configFile, "Help", "website")
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
