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
fish_add_path --append $HOME/.local/bin

# prefer brew installed llvm
fish_add_path --prepend (brew --prefix llvm)/bin

# prefer brew installed gnutils
fish_add_path --prepend (brew --prefix coreutils)/libexec/gnubin
fish_add_path --prepend (brew --prefix moreutils)/libexec/bin/
fish_add_path --prepend (brew --prefix findutils)/libexec/gnubin/

# prefer brew installed man-db
fish_add_path --prepend (brew --prefix man-db)/libexec/bin/

# direnv
direnv hook fish | source

# pipenv
set -gx PIPENV_VENV_IN_PROJECT 1

# vterm
if test "$INSIDE_EMACS" = 'vterm'
    function clear
        vterm_printf "51;Evterm-clear-scrollback";
        tput clear;
    end
    set -gx GIT_EDITOR "vi"
end

if test "$EMACS_THEME" = "ef-melissa-light"
   fish_config theme choose light
end
