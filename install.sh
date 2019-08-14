#!/bin/bash
export ZSH_CUSTOM=~/.oh-my-zsh/custom
function eInfo {
    echo -e "\e[94m${1}\033[0m"
}
function eWarn {
    echo -e "\e[93m${1}\033[0m"
}

function gitInstall {
    local gitUrl=${1}
    local to=${2}
    if [ ! -d $to ]; then
        eInfo "Installing" "$gitUrl" "to" "$to"
        git clone "$gitUrl" "$to"
        chmod 755 "$to"
    else
        eWarn "Skipping to install $gitUrl to $to"
    fi
}

function ifNotMatch {
  local cmd=${1}
  local toMatch=${2}
  local toExecute=${3}
  if eval "$cmd" | grep -q "$toMatch"; then
    eWarn "IF NOT MATCH"
  fi
}


eInfo "Installing Zsh tmux..."
ifNotMatch "zsh -version" "zsh" "uh oh"
apt-get -q -y install zsh tmux
eInfo "Installing Oh My Zsh..."
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"



gitInstall https://github.com/romkatv/powerlevel10k.git $ZSH_CUSTOM/themes/powerlevel10k
gitInstall https://github.com/zsh-users/zsh-autosuggestions.git $ZSH_CUSTOM/plugins/zsh-autosuggestions


eInfo "Copying dotfiles"
cp .[^.]* ~/

if uname -a | grep -q '^Linux.*Microsoft'; then
	eInfo "In WSL"
fi
