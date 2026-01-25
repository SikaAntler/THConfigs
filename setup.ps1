function Test-ScoopBucketNotAdded {
    param([String]$BucketPath)
    $BucketPath = Join-Path $HOME\scoop\buckets $BucketPath

    return -not (Test-Path $BucketPath)
}

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

function Test-ScoopPackageNotInstalled {
    param([String]$PackageName)
    $PackagePath = Join-Path $HOME\scoop\apps $PackageName

    return -not (Test-Path $PackagePath)
}

if (Test-ScoopPackageNotInstalled git) {
    scoop install main/git
}

$packages = @(
    # 'extras/alacritty'
    'main/cmake'
    'main/dust'
    'main/eza'
    'main/fd'
    'main/ffmpeg'
    'main/fzf'
    'main/ghostscript'
    'main/gsudo'
    'main/imagemagick'
    'main/jq'
    'extras/lazygit'
    'main/llvm'
    'main/lua-language-server'
    'nerd-fonts/LXGWWenKaiScreen'
    'nerd-fonts/Maple-Mono-NF-CN'
    'main/mingw'
    'main/neovim'
    'extras/netron'
    'main/ninja'
    'main/nodejs'
    'extras/psfzf'
    'main/python'
    'main/ripgrep'
    'main/ruff'
    'main/scc'
    'main/stylua'
    'main/taplo'
    'main/uv'
    'main/vcpkg'
    'extras/wezterm'
    'main/yamlfmt'
    'main/yazi'
    'main/yq'
    'main/zoxide'
)

function Install-ScoopPackage {
    param([String[]]$Package)
    $parts = $Package -split '/'
    $PackageName = $parts[-1]
    if (Test-ScoopPackageNotInstalled $PackageName) {
        scoop install $PackageName
    }
}

foreach ($Package in $packages) {
    Install-ScoopPackage($Package)
}

# if (-not (Test-Path -Path $HOME\AppData\Roaming\alacritty\ -PathType Container)) {
#     New-Item -ItemType Symboliclink -Path $HOME\AppData\Roaming\alacritty\ -Target $HOME\THConfigs\alacritty\
# }

if (-not (Test-Path -Path $HOME\.config\lazygit\ -PathType Container)) {
    New-Item -ItemType Symboliclink -Path $HOME\.config\lazygit\ -Target $HOME\THConfigs\lazygit\
}

if (-not (Test-Path -Path $HOME\.config\nvim\ -PathType Container)) {
    New-Item -ItemType Symboliclink -Path $HOME\.config\nvim\ -Target $HOME\THConfigs\nvim\
}

if (-not (Test-Path -Path $HOME\.ideavimrc)) {
    New-Item -ItemType Symboliclink -Path $HOME\.ideavimrc -Target $HOME\THConfigs\.ideavimrc
}
