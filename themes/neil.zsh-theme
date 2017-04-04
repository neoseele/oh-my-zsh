#Host prompt
if [[ -z "$SSH_CLIENT" ]]; then
     prompt_host=""
  else
     prompt_host=%{$fg_bold[white]%}@%{$reset_color$fg[yellow]%}$(hostname -s)
fi

_rbenv_prompt()
{
  type rbenv >/dev/null 2>&1 || return 0
  rbenv_version=$(rbenv version-name)
  if [[ $rbenv_version == 'system' ]]; then
    return 0
  else
    echo "$rbenv_version "
  fi
}

PROMPT=$'$(_rbenv_prompt)%{$fg_bold[cyan]%}%~ %{$reset_color%}$(git_prompt_info)%D{[%H:%M:%S]}$(battery_pct_prompt)\
%{$fg_bold[green]%}%n${prompt_host}%{$fg_bold[white]%} \x\xCE\xbb%{$reset_color%} '

RPROMPT='%(0?..(%?%))'
#RPROMPT='[%F{yellow}%?%f]'

ZSH_THEME_GIT_PROMPT_PREFIX="[%{$fg_bold[green]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}]"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg_bold[red]%}*%{$fg_bold[green]%}"
ZSH_THEME_GIT_PROMPT_CLEAN=""

# See http://geoff.greer.fm/lscolors/
export LSCOLORS="exfxcxdxbxbxbxbxbxbxbx"
export LS_COLORS="di=34;40:ln=35;40:so=32;40:pi=33;40:ex=31;40:bd=31;40:cd=31;40:su=31;40:sg=31;40:tw=31;40:ow=31;40:"
