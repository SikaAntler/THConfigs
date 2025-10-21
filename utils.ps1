# Add the following command to $PROFILE
# Invoke-Expression -Command ". $HOME/THConfigs/utils.ps1"

Set-PSReadLineOption -EditMode Emacs

# aliases
function cd2
{
    Set-Location ..\..
}

function cd3
{
    Set-Location ..\..\..
}

function lg
{
    lazygit
}
function np
{
    nvim $PROFILE
}
function wsi
{
    wezterm cli spawn --domain-name SSH:imager
}

# fzf
if (Get-Module -ListAvailable -Name "PSFzf" -ErrorAction Stop)
{
    Set-PsFzfOption -PSReadlineChordProvider "Ctrl+t" -PSReadlineChordReverseHistory "Ctrl+r"
}

# starship
# if (Get-Command "starship" -ErrorAction Stop)
# {
#     $env:STARSHIP_CONFIG = "$HOME\THConfigs\starship.toml"
#     Invoke-Expression(&starship init powershell)
# }

# yazi
$env:YAZI_CONFIG_HOME = "$HOME\THConfigs\yazi"
$env:YAZI_FILE_ONE = "$HOME\scoop\apps\git\current\usr\bin\file.exe"
function y
{
    $tmp = [System.IO.Path]::GetTempFileName()
    yazi $args --cwd-file="$tmp"
    $cwd = Get-Content -Path $tmp
    if (-not [String]::IsNullOrEmpty($cwd) -and $cwd -ne $PWD.Path)
    {
        Set-Location -LiteralPath $cwd
    }
    Remove-Item -Path $tmp
}

# zoxide
if (Get-Command "zoxide" -ErrorAction Stop)
{
    Invoke-Expression (& { (zoxide init powershell | Out-String) })
}
