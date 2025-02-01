# setting character encoding to UTF-8 (w/o BOM)
$OutputEncoding = [System.Console]::OutputEncoding = [System.Text.UTF8Encoding]::new()

# env
if ($IsWindows) {
    $env:HOME = "$env:USERPROFILE"
    $env:RYE_HOME = "$env:USERPROFILE\scoop\persist\rye"
    $env:PATH = "$env:RYE_HOME\shims;" + "$env:PATH;" + "$env:USERPROFILE\scoop\persist\rye\py\cpython@3.10.13\install\Scripts"
    $env:XDG_CONFIG_HOME = "$env:USERPROFILE\.config"
}
$env:COLORTERM = "truecolor"

Import-Module Catppuccin

# Set a flavor for easy access
$Flavor = $Catppuccin['Mocha']

$Colors = @{
    # Largely based on the Code Editor style guide
    # Emphasis, ListPrediction and ListPredictionSelected are inspired by the Catppuccin fzf theme

    # Powershell colours
    ContinuationPrompt     = $Flavor.Teal.Foreground()
    Emphasis               = $Flavor.Red.Foreground()
    Selection              = $Flavor.Surface0.Background()

    # PSReadLine prediction colours
    InlinePrediction       = $Flavor.Overlay0.Foreground()
    ListPrediction         = $Flavor.Mauve.Foreground()
    ListPredictionSelected = $Flavor.Surface0.Background()

    # Syntax highlighting
    Command                = $Flavor.Blue.Foreground()
    Comment                = $Flavor.Overlay0.Foreground()
    Default                = $Flavor.Text.Foreground()
    Error                  = $Flavor.Red.Foreground()
    Keyword                = $Flavor.Mauve.Foreground()
    Member                 = $Flavor.Rosewater.Foreground()
    Number                 = $Flavor.Peach.Foreground()
    Operator               = $Flavor.Sky.Foreground()
    Parameter              = $Flavor.Pink.Foreground()
    String                 = $Flavor.Green.Foreground()
    Type                   = $Flavor.Yellow.Foreground()
    Variable               = $Flavor.Lavender.Foreground()
}

# Readline Option
Set-PSReadLineOption -Colors $Colors
Set-PSReadLineOption -EditMode vi
# Readline handler
Set-PSReadLineKeyHandler -Chord 'Ctrl+Oem4' -Function ViCommandMode
Set-PSReadlineKeyHandler -Key 'Ctrl+p' -Function HistorySearchBackward
Set-PSReadlineKeyHandler -Key 'Ctrl+n' -Function HistorySearchForward
Set-PSReadLineKeyHandler -Key Tab -Function MenuComplete
Set-PSReadLineKeyHandler -Chord "Ctrl+f" -Function ForwardChar
Set-PSReadLineKeyHandler -Chord "Alt+f" -Function ForwardWord


## scoop completion
$scoop_completion_fpath = '$env:HOME\scoop\apps\scoop\current\supporting\completion\Scoop-Completion.psd1'
if (Test-Path $scoop_completion_fpath) {
    Import-Module $scoop_completion_fpath -ErrorAction SilentlyContinue
}

# import solo2 completion
$solo2_completion_fpath = '$env:HOME\Documents\PowerShell\solo2.ps1'
if (Test-Path $solo2_completion_fpath) {
    . $solo2_completion_fpath
}
# Alias

Set-Alias vi nvim
Set-Alias vim nvim

if (Get-Command "starship") {
    Invoke-Expression (&starship init powershell)
} else {
    # Modified from the built-in prompt function at: https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_prompts
    function prompt {
        $(if (Test-Path variable:/PSDebugContext) { "$($Flavor.Red.Foreground())[DBG]: " }
          else { '' }) + "$($Flavor.Teal.Foreground())PS $($Flavor.Yellow.Foreground())" + $(Get-Location) +
            "$($Flavor.Green.Foreground())" + $(if ($NestedPromptLevel -ge 1) { '>>' }) + '> ' + $($PSStyle.Reset)
    }
    # The above example requires the automatic variable $PSStyle to be available, so can be only used in PS 7.2+
    # Replace $PSStyle.Reset with "`e[0m" for PS 6.0 through PS 7.1 or "$([char]27)[0m" for PS 5.1
}

#f45873b3-b655-43a6-b217-97c00aa0db58 PowerToys CommandNotFound module

Import-Module -Name Microsoft.WinGet.CommandNotFound
#f45873b3-b655-43a6-b217-97c00aa0db58
