function find_file --description "use find-file function to open a file in emacs."
    set -q argv[1]; or set argv[1] "."
    vterm_cmd find-file (realpath "$argv")
end
