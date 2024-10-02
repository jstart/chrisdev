# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh
    source <(pmk completion --shell=zsh)

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
if [[ "$TERM_PROGRAM" == "iTerm.app" ]]; then
  ZSH_THEME="agnoster"
else
  ZSH_THEME="robbyrussell"
fi

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable bi-weekly auto-update checks
DISABLE_AUTO_UPDATE="true"

# Uncomment to change how many often would you like to wait before auto-updates occur? (in days)
export UPDATE_ZSH_DAYS=13

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(brew composer git npm)

DISABLE_AUTO_UPDATE="true"

source $ZSH/oh-my-zsh.sh

# Customize to your needs...

source $HOME/Developer/dotfiles/shell/.aliases
source $HOME/Developer/dotfiles/shell/.vars
[[ -s ~/.local-aliases ]] && source ~/.local-aliases

## Update $PATH for Homebrew
export PATH="/usr/local/bin:/usr/local/sbin:$PATH"

## NVM (Node Version Manager)
# [[ -s ~/.nvm/nvm.sh ]] && . ~/.nvm/nvm.sh
source $(brew --prefix nvm)/nvm.sh

## Rbenv
#export RBENV_ROOT=/usr/local/var/rbenv
#type rbenv >/dev/null 2>&1 && eval "$(rbenv init -)"

export RBENV_ROOT=/usr/local/var/rbenv
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

## ZSH syntax highlighting
[[ -s /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]] && source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

## Autojump
type brew >/dev/null 2>&1 && [[ -s `brew --prefix`/etc/autojump.sh ]] && . `brew --prefix`/etc/autojump.sh

### Android SDK
export JAVA_HOME=$(/usr/libexec/java_home)

export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting

# The next line updates PATH for the Google Cloud SDK.
# if [ -f '/Users/christophertruman/Downloads/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/christophertruman/Downloads/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
# if [ -f '/Users/christophertruman/Downloads/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/christophertruman/Downloads/google-cloud-sdk/completion.zsh.inc'; fi
