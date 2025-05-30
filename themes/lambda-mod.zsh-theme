#!/usr/bin/env zsh

local LAMBDA="%(?,%{$fg_bold[green]%}λ,%{$fg_bold[red]%}λ)"
if [[ "$USER" == "root" ]]; then USERCOLOR="red"; else USERCOLOR="yellow"; fi

# Git sometimes goes into a detached head state. git_prompt_info doesn't
# return anything in this case. So wrap it in another function and check
# for an empty string.
function check_git_prompt_info() {
    if git rev-parse --git-dir > /dev/null 2>&1; then
        if [[ -z $(git_prompt_info) ]]; then
            echo "%{$fg[blue]%}detached-head%{$reset_color%}) $(git_prompt_status)
%{$fg[yellow]%}→ "
        else
            echo "$(git_prompt_info) $(git_prompt_status)
%{$fg_bold[cyan]%}→ "
        fi
    else
        echo "
%{$fg_bold[blue]%}→ "
    fi
}

function get_right_prompt() {
    if git rev-parse --git-dir > /dev/null 2>&1; then
        echo -n "$(git_prompt_short_sha)%{$reset_color%}"
    else
        echo -n "%{$reset_color%}"
    fi
}

function current_config {
#  gcloud config configurations list | awk '{ if ($2 == "True") print $1 }'
}
function current_context {
#  kubectl config current-context 2>/dev/null
}

# PROMPT='[%{$fg[cyan]%}$(current_config)%{$reset_color%} > %{$fg[green]%}$(current_context)%{$reset_color%}]
# ${LAMBDA}\
#  %{$fg_bold[$USERCOLOR]%}%n\
#  %{$fg_bold[cyan]%}%~\
#  $(check_git_prompt_info)\
# %{$reset_color%}'

PROMPT='[%{$fg[cyan]%}$(current_context)%{$reset_color%}]
${LAMBDA}\
 %{$fg_bold[$USERCOLOR]%}%n%{$reset_color%}@%{$fg_bold[green]%}%m:\
 %{$fg_bold[cyan]%}%~\
 $(check_git_prompt_info)\
%{$reset_color%}'

#RPROMPT='$(get_right_prompt)'
#RPROMPT='[%{$fg_bold[blue]%}%T%{$reset_color%}]'

# Format for git_prompt_info()
ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[blue]%} "
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
#ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg_bold[red]%}✗"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg_bold[red]%}⚡"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg_bold[green]%} ✔"

# Format for git_prompt_status()
ZSH_THEME_GIT_PROMPT_ADDED="%{$fg_bold[green]%}+"
ZSH_THEME_GIT_PROMPT_MODIFIED="%{$fg_bold[blue]%}!"
ZSH_THEME_GIT_PROMPT_DELETED="%{$fg_bold[red]%}-"
ZSH_THEME_GIT_PROMPT_RENAMED="%{$fg_bold[magenta]%}>"
ZSH_THEME_GIT_PROMPT_UNMERGED="%{$fg_bold[yellow]%}#"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg_bold[cyan]%}?"

# Format for git_prompt_ahead()
ZSH_THEME_GIT_PROMPT_AHEAD=" %{$fg_bold[white]%}^"


# Format for git_prompt_long_sha() and git_prompt_short_sha()
ZSH_THEME_GIT_PROMPT_SHA_BEFORE=" %{$fg_bold[white]%}[%{$fg_bold[blue]%}"
ZSH_THEME_GIT_PROMPT_SHA_AFTER="%{$fg_bold[white]%}]"
