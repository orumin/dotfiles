# setting character encoding to UTF-8 (w/o BOM)
$OutputEncoding = [System.Text.Encoding]::GetEncoding("utf-8")
# Import the module
Import-Module PSReadLine
Import-Module Catppuccin

# Set a flavor for easy access
$Flavor = $Catppuccin['Mocha']

# Modified from the built-in prompt function at: https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_prompts
function prompt {
    $(if (Test-Path variable:/PSDebugContext) { "$($Flavor.Red.Foreground())[DBG]: " }
      else { '' }) + "$($Flavor.Teal.Foreground())PS $($Flavor.Yellow.Foreground())" + $(Get-Location) +
        "$($Flavor.Green.Foreground())" + $(if ($NestedPromptLevel -ge 1) { '>>' }) + '> ' + $($PSStyle.Reset)
}
# The above example requires the automatic variable $PSStyle to be available, so can be only used in PS 7.2+
# Replace $PSStyle.Reset with "`e[0m" for PS 6.0 through PS 7.1 or "$([char]27)[0m" for PS 5.1

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

# Set the colours
Set-PSReadLineOption -Colors $Colors

# Readline handler
Set-PSReadlineKeyHandler -Key 'Ctrl+p' -Function HistorySearchBackward
Set-PSReadlineKeyHandler -Key 'Ctrl+n' -Function HistorySearchForward
Set-PSReadLineKeyHandler -Key Tab -Function MenuComplete

# scoop completion
Import-Module 'C:\Users\$env:USERNAME\scoop\apps\scoop\current\supporting\completion\Scoop-Completion.psd1' -ErrorAction SilentlyContinue

# import solo2 completion
$solo2_completion_fpath = 'C:\Users\$env:USERNAME\Documents\PowerShell\solo2.ps1'
if (Test-Path $solo2_completion_fpath) {
    . $solo2_completion_fpath
}
# Alias

Set-Alias vi nvim
Set-Alias vim nvim

# some functions

function CustomListChildItems { Get-ChildItem -force | Sort-Object -Property @{ Expression = 'LastWriteTime'; Descending = $true }, @{ Expression = 'Name'; Ascending = $true } | Format-Table -AutoSize -Property Mode, Length, LastWriteTime, Name }
Set-Alias ll CustomListChildItems

function FindPackageChocolatey { Find-Package -ProviderName ChocolateyGet -Name $args[0] }
Set-Alias choco-find FindPackageChocolatey

function InstallPackageChocolatey { Install-Package -ProviderName ChocolateyGet -Name $args[0] }
Set-Alias choco-install InstallPackageChocolatey

# env
$env:RYE_HOME = "$env:USERPROFILE\scoop\persist\rye"
$env:PATH = "$env:RYE_HOME\shims;" + $env:PATH
$env:HOME = "$env:USERPROFILE"
$env:XDG_CONFIG_HOME = "$env:USERPROFILE\.config"
if ( -not [String]::IsNullOrEmpty($env:WT_SESSION) ) {
    $env:COLORTERM = "truecolor"
}

$env:WSLENV = "WT_SESSION/u:COLORTERM/u:WT_PROFILE_ID/u"
