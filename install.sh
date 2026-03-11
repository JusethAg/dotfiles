#!/usr/bin/env bash

set -e
# ==============================================================
#                       Helper functions
# ==============================================================

# Suppress login message
suppress_login_message() {
    echo "Suppressing login message..."

    touch ~/.hushlogin

    echo "Login message suppressed."
}

check_command() {
    local cmd="$1"
    command -v "$cmd" &>/dev/null
}

# Prompt for Git user details
prompt_git_config() {
    echo "Enter your information for Git configuration."

    read -p "Enter your full name: " git_name
    read -p "Enter your email: " git_email

    export GIT_CONFIG_NAME="$git_name"
    export GIT_CONFIG_EMAIL="$git_email"
}

# Apply Git configuration
apply_git_config() {
    if [[ -n "GIT_CONFIG_NAME" && -n "GIT_CONFIG_EMAIL" ]]; then
        echo "Applying Git configuration..."
        
        git config --global user.name "$GIT_CONFIG_NAME"
        git config --global user.email "$GIT_CONFIG_EMAIL"

        echo "Git user name and email have been set."
    else
        echo "Git user details not provided, skipping Git configuration."
    fi
}

# Install Homebrew
install_brew() {
    if check_command brew; then
        echo "Homebrew is already installed."
    else
        echo "Installing Homebrew..."
        NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

    fi

    echo "Setting up Homebrew environment..."

    # Source brew for current session
    eval "$(/opt/homebrew/bin/brew shellenv)"

    # Add to shell configuration
    grep -q "brew shellenv" ~/.zshrc 2>/dev/null || echo 'eval "$(brew shellenv)"' >>~/.zshrc
}

# Create symlinks for dotfiles
create_symlinks() {
    echo "Removing existing dotfiles..."

    rm -rf ~/Library/Application\ Support/Code/User/settings.json ~/.zshrc ~/.tmux.conf ~/.tmux/scripts/resize-panel.sh ~/.config/nvim 2>/dev/null

    echo "Creating folders..."

    mkdir -p ~/.tmux ~/.tmux/scripts ~/.config

    echo "Creating symlinks..."
    ln -s "$(pwd)/vscode/settings.json" ~/Library/Application\ Support/Code/User/settings.json
    ln -s "$(pwd)/zsh/zshrc" ~/.zshrc
    ln -s "$(pwd)/tmux/.tmux.conf" ~/.tmux.conf
    ln -s "$(pwd)/tmux/scripts/resize-panel.sh" ~/.tmux/scripts/resize-panel.sh
    ln -s "$(pwd)/nvim" ~/.config/nvim


    chmod +x ~/.tmux/scripts/resize-panel.sh
}

# Print completion message
print_completion() {
    # TODO: Add a nice image
    echo "Your local environment is ready to use!"
}
# ==============================================================
#                       MacOS configs
# ==============================================================

# Install common packages via Homebrew
install_brew_packages() {
    echo "Installing Brew packages..."

    brew update

    brew install openssl readline sqlite3 xz zlib
    brew install wget
    brew install zsh-completions
    brew install zsh-autosuggestions
    brew install zsh-syntax-highlighting
    brew install tree
    brew install fzf
    brew install ripgrep
    brew install webp
    brew install uv
    brew install neovim
    brew install go
    brew install graphviz
    brew install terraform
    brew install nvm
    brew install neofetch
    brew install kubernetes-cli
    brew install minikube
    brew install awscli
    brew install tmux
    brew install gh

    echo "Brew packages have been installed!"

}

# Install MacOS packages via Homebrew cask
install_brew_cask_packages() {
    echo "Installing Brew Cask packages..."

    brew install --cask visual-studio-code
    brew install --cask iterm2
    brew install --cask claude-code
    brew install --cask docker
    brew install --cask jetbrains-toolbox
    brew install --cask logi-options+

    echo "Cask applications have been installed!"
}

# Install packages not supported by Homebrew
install_non_brew_packages() {
    echo "Installing packages not supported by Homebrew..."

    # Install Oh My Zsh!
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

    # Install Powerlevel10k zsh theme
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k" 

    echo "Packages not supported by Homebrew have been installed!"
}

# Install fonts via Homebrew
install_macos_fonts() {
    echo "Installing fonts..."

    brew install --cask font-fira-code

    echo "MacOS fonts have been installed!"
}

# Set computer name & hostname
set_hostname() {
    echo "Current computer name: $(scutil --get ComputerName 2>/dev/null || echo 'Not set yet.')"
    echo "Current hostname: $(scutil --get HostName 2>/dev/null || echo 'Not set yet.')"
    echo "Current local hostname: $(scutil --get LocalHostName 2>/dev/null || echo 'Not set yet.')"

    read -p "Enter new computer name (or press Enter to keep current): " new_name

    if [[ -n "$new_name" ]]; then
        sudo scutil --set ComputerName "$new_name"
        sudo scutil --set HostName "$new_name"
        sudo scutil --set LocalHostName "$new_name"
        sudo defaults write /Library/Preferences/SystemConfiguration/com.apple.smb.server NetBIOSName -string "$new_name"
        
        echo "Computer name set to: $new_name :)"
    else
        echo "No changes applied. Keeping current computer name."
    fi
}

update_macos_defaults() {
    echo "Updating macOS system defaults..."

    # Show Path Bar in Finder
    defaults write com.apple.finder ShowPathbar -bool true;

    echo "macOS defaults updated. You may need to restart your computer for some changes to take effect!"
}

setup_local_env() {
    echo -e "Setting up dotfiles...\\n"

    suppress_login_message

    set_hostname

    update_macos_defaults

    install_brew

    install_brew_packages

    install_brew_cask_packages

    install_non_brew_packages

    install_macos_fonts

    prompt_git_config

    apply_git_config

    create_symlinks

    print_completion
}

# Ask for admin pass
sudo -v

setup_local_env