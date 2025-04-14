# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
#ZSH_THEME="lambda-mod"

# Set auto-updates to 2 week interval
export UPDATE_ZSH_DAYS=14

# Disable command autocorrection
DISABLE_CORRECTION="true"

# Display red dots while waiting for completion
COMPLETION_WAITING_DOTS="true"

# Disable marking untracked files under VCS as dirty.
# This makes repository status check for large repositories much, much faster.
DISABLE_UNTRACKED_FILES_DIRTY="true"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

#Finally, Source oh-my-zsh
source $ZSH/oh-my-zsh.sh

# Set up the prompt
autoload -Uz promptinit
promptinit
prompt adam1

setopt histignorealldups sharehistory

# Use emacs keybindings even if our EDITOR is set to vi
#bindkey -e

# Use option+<-> to move between words
bindkey "^[[1;3C" forward-word
bindkey "^[[1;3D" backward-word

# Keep 1000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.zsh_history

# Use modern completion system
autoload -Uz compinit
compinit

zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select=2
eval "$(dircolors -b)"
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true

zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/usr/local/google/home/nmiu/Downloads/google-cloud-sdk/path.zsh.inc' ]; then . '/usr/local/google/home/nmiu/Downloads/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/usr/local/google/home/nmiu/Downloads/google-cloud-sdk/completion.zsh.inc' ]; then . '/usr/local/google/home/nmiu/Downloads/google-cloud-sdk/completion.zsh.inc'; fi

# kubectl
#source <(kubectl completion zsh)
# hgd
source /etc/bash_completion.d/hgd
# g4d
source /etc/bash_completion.d/g4d
# Enables fzf
source /usr/share/doc/fzf/examples/key-bindings.zsh
source /usr/share/doc/fzf/examples/completion.zsh
# custom functions
source ~/.funcs
#source ~/code/kubelab/tools/shell/k8s.sh
# rvm
source /usr/local/google/home/nmiu/.rvm/scripts/rvm

# ~/bin
export PATH="$HOME/bin:$PATH"

# alias
alias versionstore='/google/bin/releases/rollouts/versionstore/cli'
alias prodspec='/google/bin/releases/rollouts/prodspec/prodspec'
alias rpcdig='/google/data/ro/teams/zoneman/tools/rpcdig'
alias tp_am="tool-proxy-cli -tool_proxy /abns/alertmanager-tool-proxy/prod-alertmanager-tool-proxy-tool-proxy.annealed-tool-proxy"
alias boq_glaze='/google/bin/releases/goa-dev/boq_glaze/boq_glaze'
alias plxutil='/google/data/ro/teams/plx/plxutil'
alias loas_creds.sh='/google/src/head/depot/google3/identity/tools/creds/loas_creds.sh'
alias bluze='/google/bin/releases/blueprint-bluze/public/bluze'
alias ganpaticfg='/google/bin/releases/ganpaticfg/public/ganpaticfg'
alias aclcheck='/google/bin/releases/ganpati-acls/tools/aclcheck'

# metamappera
alias mmc_workflows='blaze query //cloud/cre/plx/metamapper_collector:all | grep :workflow | cut -d":" -f2 | sed -e "s|workflow_|/google/data/ro/teams/plx/plxutil rm --hard_delete workflow |" | grep -v diffemall'
alias mmc_scripts='blaze query //cloud/cre/plx/metamapper_collector:all | grep :script | cut -d":" -f2 | sed -e "s|script_|/google/data/ro/teams/plx/plxutil rm --hard_delete script |" | grep -v diffemall'
alias mmc_drop_staging_tables='blaze query //cloud/cre/plx/metamapper_collector:all | grep :script | cut -d":" -f2 | grep whereiyc | sed -E "s/script_cre_metamapper_(.*_whereiyc)_.*/DROP TABLE IF EXISTS cloud_cre_metamapper.product_\1_staging_qual;/g" | uniq'
alias mmc_drop_dev_tables='blaze query //cloud/cre/plx/metamapper_collector:all | grep :script | cut -d":" -f2 | grep whereiyc | sed -E "s/script_cre_metamapper_(.*_whereiyc)_.*/DROP TABLE IF EXISTS cloud_cre_metamapper.product_\1_nmiu;/g" | uniq'

# gcs md
alias bstp='/google/bin/releases/blobstore2/bstp/bstp'
alias bstp-qa='/google/bin/releases/blobstore2/bstp-qa/bstp'

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

#== GCS SRE ==

GOOGLE3="/google/src/head/depot/google3"
source "${GOOGLE3}/cloud/bigstore/tools/alias.bashrc"

# Runs gcert, but first checks if you have current credentials.
# If your cert expires in the next five hours, run gcert, otherwise carry on
gcertstatus --check_remaining 5h
EXIT_STATUS=$?
if [ $EXIT_STATUS -gt 0 ]; then
  # Exit status greater than 0 probably indicates expired/expiring credentials.
  # https://goto.corp.google.comogle3/security/tools/gnubby/ssh/gerror.go?l=15&rcl=350130320
  echo "Running 'gcert -s'"
  gcert -s
  GCERT_EXIT_STATUS=$?
  if [ $GCERT_EXIT_STATUS -gt 0 ]; then
    echo "gcert error occurred, exit status: $GCERT_EXIT_STATUS"
  fi
fi

bigstore_bashrc='/google/src/head/depot/google3/cloud/bigstore/tools/bigstore.bashrc'
if [ -f "${bigstore_bashrc}" ]; then
  source "${bigstore_bashrc}"
else
  echo "Failed to source ${bigstore_bashrc}"
fi

