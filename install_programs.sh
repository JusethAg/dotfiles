# Install Homebrew
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"


# Install console applications
brew install wget
brew install git
brew install node
brew install zsh zsh-completions
brew install ansible 

# Install packages
brew tap caskroom/fonts
brew cask install font-fira-code

# Install icon applications
brew cask install visual-studio-code
brew cask install iterm2
brew cask install java
brew cask install docker

# Install apps without homebrew
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"