function title
    if not functions -q fish_title_backup
       functions --copy fish_title fish_title_backup
    end
    if test "$argv[1]" = ""
        functions --erase fish_title
        functions --copy fish_title_backup fish_title
    else
        set -l title_text $argv[1]
        function fish_title --inherit-variable title_text
            echo $title_text
        end
    end
end
