function Test-ScoopBucketNotAdded {
    param(
        [String]$BucketPath
    )
    $BucketPath = Join-Path $HOME\scoop\buckets $BucketPath

    return -not (Test-Path $BucketPath)

}

function Test-ScoopPackageNotInstalled {
    param([String]$PackageName)
    $PackagePath = Join-Path $HOME\scoop\apps $PackageName

    return -not (Test-Path $PackagePath)
}

# scoop
if (Get-Command scoop) {
    if (Test-ScoopBucketNotAdded extras) {
        scoop bucket add extras
    }
    if (Test-ScoopBucketNotAdded nerd-fonts) {
        scoop bucket add nerd-fonts
    }
} else {
    Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
    Invoke-RestMethod -Uri https://get.scoop.sh | Invoke-Expression
}

if (Test-ScoopPackageNotInstalled git) {
    scoop install main/git
}

if (Test-ScoopPackageNotInstalled alacritty) {
    scoop install extras/alacritty
}
if (-not (Test-Path -Path $HOME\AppData\Roaming\alacritty\ -PathType Container)) {
    New-Item -ItemType Symboliclink -Path $HOME\AppData\Roaming\alacritty\ -Target $HOME\THConfigs\alacritty\
}

if (Test-ScoopPackageNotInstalled cmake) {
    scoop install main/cmake
}

if (Test-ScoopPackageNotInstalled dust) {
    scoop install main/dust
}

if (Test-ScoopPackageNotInstalled eza) {
    scoop install main/eza
}

if (Test-ScoopPackageNotInstalled fd) {
    scoop install main/fd
}

if (Test-ScoopPackageNotInstalled ffmpeg) {
    scoop install main/ffmpeg
}

if (Test-ScoopPackageNotInstalled fzf) {
    scoop install main/fzf
}

if (Test-ScoopPackageNotInstalled gsudo) {
    scoop install main/gsudo
}

if (Test-ScoopPackageNotInstalled jq) {
    scoop install main/jq
}

if (Test-ScoopPackageNotInstalled lazygit) {
    scoop install extras/lazygit
}
if (-not (Test-Path -Path $HOME\.config\lazygit\ -PathType Container)) {
    New-Item -ItemType Symboliclink -Path $HOME\.config\lazygit\ -Target $HOME\THConfigs\lazygit\
}

if (Test-ScoopPackageNotInstalled llvm) {
    scoop install main/llvm
}

if (Test-ScoopPackageNotInstalled LXGWWenKaiScreen) {
    scoop install nerd-fonts/LXGWWenKaiScreen
}

if (Test-ScoopPackageNotInstalled Maple-Mono-NF-CN) {
    scoop install nerd-fonts/Maple-Mono-NF-CN
}

if (Test-ScoopPackageNotInstalled mingw) {
    scoop install main/mingw
}

if (Test-ScoopPackageNotInstalled neovim) {
    scoop install main/neovim
}
if (-not (Test-Path -Path $HOME\.config\nvim\ -PathType Container)) {
    New-Item -ItemType Symboliclink -Path $HOME\.config\nvim\ -Target $HOME\THConfigs\nvim\
}

if (Test-ScoopPackageNotInstalled ninja) {
    scoop install main/ninja
}

if (Test-ScoopPackageNotInstalled nodejs) {
    scoop install main/nodejs
}

if (Test-ScoopPackageNotInstalled psfzf) {
    scoop install extras/psfzf
}

if (Test-ScoopPackageNotInstalled python) {
    scoop install main/python
}

if (Test-ScoopPackageNotInstalled ripgrep) {
    scoop install main/ripgrep
}

if (Test-ScoopPackageNotInstalled uv) {
    scoop install main/uv
}

if (Test-ScoopPackageNotInstalled vcpkg) {
    scoop install main/vcpkg
}

if (Test-ScoopPackageNotInstalled wezterm) {
    scoop install extras/wezterm
}

if (Test-ScoopPackageNotInstalled yazi) {
    scoop install main/yazi
}

if (Test-ScoopPackageNotInstalled yq) {
    scoop install main/yq
}

if (Test-ScoopPackageNotInstalled zoxide) {
    scoop install main/zoxide
}

if (-not (Test-Path -Path $HOME\.ideavimrc)) {
    New-Item -ItemType Symboliclink -Path $HOME\.ideavimrc -Target $HOME\THConfigs\.ideavimrc
}
