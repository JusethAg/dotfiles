# Install Homebrew
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# Install taps
brew tap homebrew/services
brew tap hashicorp/tap

# Install console applications
brew install openssl readline sqlite3 xz zlib
brew install wget
brew install git
brew install zsh zsh-completions
brew install ansible
brew install tree
brew install jenv
brew install pyenv
brew install pyenv-virtualenv
brew install postgresql
brew install go
brew install hashicorp/tap/vault

# Install packages
brew tap homebrew/cask-fonts
brew cask install font-fira-code

# Install icon applications
brew cask install visual-studio-code
brew cask install iterm2
brew tap caskroom/versions
brew cask install java8
brew cask install java11
brew cask install docker
brew cask install intellij-idea-ce
brew cask install virtualbox
brew cask install vagrant
brew cask install google-cloud-sdk
# sudo chown -R $(whoami) /usr/local/include
# chmod u+w /usr/local/include
brew install kubernetes-cli
brew install minikube
brew install rke
brew install terraform
brew install nvm


# Install apps without homebrew
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
