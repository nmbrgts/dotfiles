#! /bin/bash

if ! command -v brew > /dev/null 2>&1
then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

brew update

brew upgrade

# tools
brew install fish
brew install git
brew install coreutils
brew install findutils
brew install moreutils
brew install gnu-sed
brew install gnu-tar
brew install gawk
brew install fd
brew install tree
brew install ispell
brew install mediainfo
brew install ripgrep
brew install wget
brew install sqlite
brew install cmake
brew install grep
brew install direnv
brew install shellcheck
brew install openssl
brew install openssh
brew install libsqlite3-dev
brew install zlib

# emacs
brew tap d12frosted/emacs-plus
brew install emacs-plus

# c
brew install llvm
brew install clang

# go
brew install go
go install golang.org/x/tools/gopls@latest
go install golang.org/x/tools/cmd/goimports@latest
go install mvdan.cc/gofumpt@latest

# python
brew install pipx
pipx install ruff
pipx install pyflakes
pipx install black
pipx install isort
pipx install poetry
pipx install uv
pipx install basedpyright
pipx install cookiecutter
pipx install pytest

# disable hot keys that conflict with emacs
# M-.
defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 15 '<dict><key>enabled</key><false/></dict>'
# M-;
defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 16 '<dict><key>enabled</key><false/></dict>'
# M-s-d
defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 52 '<dict><key>enabled</key><false/></dict>'
# S-SPC
defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 60 '<dict><key>enabled</key><false/></dict>'
# S-M-SPC
defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 61 '<dict><key>enabled</key><false/></dict>'
# M-SPC
defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 64 '<dict><key>enabled</key><false/></dict>'
# C-SPC
defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 65 '<dict><key>enabled</key><false/></dict>'
# C-M-d
defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 70 '<dict><key>enabled</key><false/></dict>'
# make effective immediately
/System/Library/PrivateFrameworks/SystemAdministration.framework/Resources/activateSettings -u
