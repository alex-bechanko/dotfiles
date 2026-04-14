_completions() {
    local cur
    cur="${COMP_WORDS[$COMP_CWORD]}"
    
    local options="day week month"
    COMPREPLY=( $(compgen -W "${options}" -- "${cur}") )
}

complete -F _completions periodic-note
