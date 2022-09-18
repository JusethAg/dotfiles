# Install Homebrew
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# Add additional repos
brew tap homebrew/services
brew tap hashicorp/tap
brew tap aws/tap

# Install console applications
brew install openssl readline sqlite3 xz zlib
brew install wget
brew install git
brew install zsh zsh-completions
brew install ansible
brew install tree
brew install fzf
brew install ripgrep
brew install jenv
brew install webp
brew install pyenv
brew install pyenv-virtualenv
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

brew install neovim
brew install postgresql
brew install go
brew install hashicorp/tap/vault
brew install graphviz
brew install terraform
brew install nvm
brew install neofetch
brew install aws-sam-cli

# Install packages
brew tap homebrew/cask-fonts
brew install --cask font-fira-code

# Install icon applications
brew install --cask visual-studio-code
brew install --cask iterm2
brew tap caskroom/versions
brew install --cask java8
brew install --cask java11
brew install --cask docker
brew install --cask intellij-idea-ce
brew install --cask virtualbox
brew install --cask vagrant
brew install --cask google-cloud-sdk
brew install --cask confluent-cli
# sudo chown -R $(whoami) /usr/local/include
# chmod u+w /usr/local/include
brew install kubernetes-cli
brew install minikube
brew install rke



# Install apps without homebrew
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
