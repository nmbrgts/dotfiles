function fish_prompt
    printf '\n%%%% '
end

# brew
if test (uname -m) = "x86_64"
    /usr/local/bin/brew shellenv | source
else
    /opt/homebrew/bin/brew shellenv | source
end

# brew installed executables
fish_add_path --append (brew --prefix)/bin

# go toolchain installed executables
fish_add_path --append $HOME/go/bin

# pipx installed executables
pipx ensurepath &> /dev/null

# prefer brew installed llvm
fish_add_path --prepend (brew --prefix llvm)/bin

# prefer brew installed gnutils
fish_add_path --prepend (brew --prefix coreutils)/libexec/gnubin
fish_add_path --prepend (brew --prefix moreutils)/libexec/bin/
fish_add_path --prepend (brew --prefix findutils)/libexec/gnubin/

# direnv
direnv hook fish | source

# vterm
if test "$INSIDE_EMACS" = 'vterm'
    and test -n "$EMACS_VTERM_PATH"
    and test -f "$EMACS_VTERM_PATH/etc/emacs-vterm.fish"
	source "$EMACS_VTERM_PATH/etc/emacs-vterm.fish"
end
