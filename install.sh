#!/bin/bash
echo -e "Installing Zsh..."
apt-get -q -y install zsh
echo -e "Installing Oh My Zsh..."
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

#   ## To install ZSH themes & aliases
#   echo -e "Copying ZSH themes & aliases..."
#   echo -e "Check .aliases file for more details."
# #   cp oh-my-zsh/aliases ~/.aliases                                        ## Copy aliases
# #   cp oh-my-zsh/zshrc ~/.zshrc                                            ## Copy zshrc configs
# #   cp oh-my-zsh/dracula.zsh-theme ~/.oh-my-zsh/themes/dracula.zsh-theme   ## Copy custom dracula theme
# #   cp oh-my-zsh/z.sh ~/z.sh                                               ## Copy z.sh autocompletion file
# #   git clone https://github.com/peterhurford/git-it-on.zsh ~/.oh-my-zsh/custom/plugins/git-it-on ## Copy git it on utilities plugin
# fi
