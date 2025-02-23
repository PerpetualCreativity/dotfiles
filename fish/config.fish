
/opt/homebrew/bin/brew shellenv | source

function fish_prompt
    set -g __fish_git_prompt_show_informative_status true
    set -g __fish_git_prompt_use_informative_chars false
    set -g __fish_git_prompt_showuntrackedfiles true
    set -g __fish_git_prompt_showcolorhints true
    set -g __fish_git_prompt_char_stateseparator ' '
    set -g __fish_git_prompt_color brblack
    echo -sn (set_color magenta) $USER (set_color brblack) '@' (set_color green) (prompt_hostname) ' ' (set_color cyan) (prompt_pwd) (fish_git_prompt)
    if fish_is_root_user
        echo -n (set_color red --bold)' $ '
    else
        echo -n (set_color blue)' > '
    end
    set_color normal
end

function fish_right_prompt
    set -l last_status $status
    test $last_status -ne 0
    and echo (set_color red --bold)"[$last_status]"(set_color normal)
end

function fish_greeting
    echo -e (set_color white --bold --dim)'todos:'(set_color normal)
    echo -n (set_color white --dim)
    awk -f ~/notes/todos.awk ~/notes/todo.md
    echo (set_color normal)
end

set EDITOR hx

if status is-interactive
    alias h 'hx .'
    alias sl 'sl -wG'
    alias edit 'hx ~/.config'
    alias reload 'XDG_CONFIG_HOME=~/.config brew bundle install --global --cleanup'

    function mkcd
        mkdir $argv[1]
        and cd $argv[1]
    end
    function cls
        cd $argv[1]
        and ls
    end
    function notes
        hx ~/notes/$argv[1].md
    end

    zoxide init fish --cmd cd | source
    fish_config theme choose 'Rosé Pine Moon'
end

source ~/.orbstack/shell/init2.fish 2>/dev/null || :
