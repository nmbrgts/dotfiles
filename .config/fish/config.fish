function fish_prompt
    printf '\n%%%% '
end

# brew installed executables
fish_add_path --append /opt/local/bin

# qlot installed executables?
fish_add_path --append /Users/nmbrgts/.qlot/bin

# go toolchain installed executables
fish_add_path --append $HOME/go/bin

# pipx installed executables
fish_add_path --append /Users/nmbrgts/.local/bin

# prefer brew installed llvm
fish_add_path --prepend /usr/local/opt/llvm/bin

# prefer brew installed gnutils
fish_add_path --prepend /usr/local/opt/coreutils/libexec/gnubin
fish_add_path --prepend /usr/local/opt/moreutils/libexec/bin/
fish_add_path --prepend /usr/local/opt/findutils/libexec/gnubin/

# brew
eval "$(/usr/local/bin/brew shellenv)"
