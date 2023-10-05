#!/usr/bin/env bash
#title         :blastoff.sh
#description   :This script will install and configure the environment
#author        :Aleksey
#date          :2023-09-05
#version       :0.2
#usage         :bash <(curl --silent --location "https://github.com/Alekseykua/Environment/blob/main/its.sh?raw=true")
#bash_version  :3.2.57(1)-release     < Not sure
#special thanks: Basing this on ghaiklor & codeinthehole scripts TY!
#===================================================================================

#set -ueo pipefail

INFO_LEVEL="\033[0;33m"
SUCCESS_LEVEL="\033[0;32m"

function print() {
  echo -e "$1$2\033[0m"
}

function print_banner() {
  print "$INFO_LEVEL" "                                               "
  print "$INFO_LEVEL" "   ____ _ ____ _  _ ____ _  _ ____ _    _      "
  print "$INFO_LEVEL" "   |___ | [__  |__| [__  |__| |___ |    |      "
  print "$INFO_LEVEL" "   |    | ___] |  | ___] |  | |___ |___ |___   "
  print "$INFO_LEVEL" "                                               "
  print "$INFO_LEVEL" "        Command Line Tools + Homebrew + Tools  "
  print "$INFO_LEVEL" "                 by @aleksey                   "
  print "$INFO_LEVEL" "                                               "
}

function install_command_line_tools() {
  if xcode-select --print-path &>/dev/null; then
    print "$SUCCESS_LEVEL" "Command Line Tools already installed, skipping..."
  else
    print "$INFO_LEVEL" "Installing Command Line Tools..."

    xcode-select --install &>/dev/null
    until xcode-select --print-path &>/dev/null; do
      sleep 5
    done
  fi
}

function install_homebrew() {
if ! command -v brew &>/dev/null; then
  print "Installing Homebrew, an OSX package manager, follow the instructions..." 
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  if ! grep -qs "recommended by brew doctor" ~/.zshrc; then
    print "Put Homebrew location earlier in PATH ..."
      printf '\n# recommended by brew doctor\n' >> ~/.zshrc
      printf 'export PATH="/usr/local/bin:$PATH"\n' >> ~/.zshrc
      export PATH="/usr/local/bin:$PATH"
  fi
else
  print "$SUCCESS_LEVEL" "You already have Homebrew installed...good job!"
fi
}

function update_homebrew() {
 print "$INFO_LEVEL" "Updating Homebrew..."
 brew update
}

function print_post_installation() {
  print "$SUCCESS_LEVEL" "                 "
  print "$SUCCESS_LEVEL" "!!! IMPORTANT !!!"
  print "$SUCCESS_LEVEL" "                 "
  print "$SUCCESS_LEVEL" "The script accomplished all the commands it was told to do"
}

function install_necessary_brew_packages() {
 print "$INFO_LEVEL" "Installing core Homebrew packages"
 brew install --cask 1password
 brew install nmap
 brew install --cask parallels
 brew install --cask spotify
 brew install --cask teamviewer
 brew install --cask vlc
 brew install --cask sublime-text
 brew install --cask docker
 brew install --cask visual-studio-code
 brew install --cask google-chrome
 # Style Baby
 brew install lsd
}

print_banner
install_command_line_tools
install_homebrew
update_homebrew
install_necessary_brew_packages
print_post_installation


