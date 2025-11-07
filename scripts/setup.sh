#!/usr/bin/env bash

set -eou pipefail

log_info() {
    echo -e "\033[0;32m[INFO]\033[0m $1"
}

log_warn() {
    echo -e "\033[1;33m[WARN]\033[0m $1"
}

log_error() {
    echo -e "\033[0;31m[ERROR]\033[0m $1"
}

prefix() {
    local cmd="$1"
    [[ "$cmd" == "sudo" ]] && cmd="$2"
    local prefix="${cmd##*/}"
    local regex="s/^/[$prefix] /"
    "$@" > >(sed "$regex") 2> >(sed "$regex" >&2)
}

# brew

if ! command -v brew > /dev/null 2>&1; then
    log_info "installing brew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

    if [[ $(uname -m) == "arm64" ]]; then
        eval "$(/opt/homebrew/bin/brew shellenv)"
    else
        eval "$(/usr/local/bin/brew shellenv)"
    fi
else
    log_info "brew already installed"
fi

log_info "updating brew..."

prefix brew update

log_info "upgrading existing packages..."

prefix brew upgrade

# tools
log_info "installing brew packages..."

packages=(
    fish
    git
    coreutils
    findutils
    moreutils
    gnu-sed
    gnu-tar
    man-db
    gawk
    fd
    tree
    ispell
    mediainfo
    ripgrep
    wget
    sqlite
    cmake
    grep
    direnv
    shellcheck
    openssl
    openssh
    zlib
    llvm
    clang-format
    go
    pipx
)

for package in "${packages[@]}"; do
    log_info "installing $package..."
    prefix brew install "$package" || log_warn "Failed to install $package"
done

# emacs
log_info "installing emacs..."
prefix brew tap d12frosted/emacs-plus
prefix brew install emacs-plus || log_warn "failed to install emacs"

log_info "Installing Emacs packages..."
prefix emacs --batch -l ~/.emacs.d/init.el --eval "(vterm)" --kill

# go
log_info "installing go tools..."

go_tools=(
    golang.org/x/tools/gopls
    golang.org/x/tools/cmd/goimports
    mvdan.cc/gofumpt
)

if ! command -v go > /dev/null 2>&1; then
    log_warn "skipping go tools. go not installed."
else
    for tool in "${go_tools[@]}"; do
        log_info "installing $tool..."
        prefix go install "${tool}@latest" || log_warn "failed to install $tool"
    done
fi

# python
log_info "installing python tools..."

python_tools=(
    ruff
    pyflakes
    black
    isort
    reorder-python-imports
    pipenv
    poetry
    uv
    'basedpyright==1.31.7'
    cookiecutter
    pytest
    pre-commit
    tox
)

if ! command -v pipx > /dev/null 2>&1; then
    log_warn "skipping python tools. pipx not installed."
else
    for tool in "${python_tools[@]}"; do
        log_info "installing $tool..."
        prefix pipx install "$tool" || log_warn "failed to install $tool"
    done
fi

# macos
log_info "configuring macos settings..."

# hotkeys that conflict with emacs
hotkeys=(
    15 # M-.
    16 # M-;
    52 # M-s-d
    60 # S-SPC
    61 # S-M-SPC
    64 # M-SPC
    65 # C-SPC
    70 # C-M-d
)

for key in "${hotkeys[@]}"; do
    defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add "$key" '<dict><key>enabled</key><false/></dict>'
done

/System/Library/PrivateFrameworks/SystemAdministration.framework/Resources/activateSettings -u

# general settings
defaults write com.apple.finder AppleShowAllFiles -bool true
defaults write com.apple.finder ShowPathbar -bool true
defaults write com.apple.finder ShowStatusBar -bool true
defaults write com.apple.LaunchServices LSQuarantine -bool false

killall Finder 2>/dev/null || true
killall SystemUIServer 2>/dev/null || true

log_info "building mandb cache..."
prefix sudo mandb /Library/Developer/CommandLineTools/usr/share/man
prefix sudo mandb /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/share/man

log_info "done!"
