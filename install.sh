#!/usr/bin/env bash

set -e

LOG_FILE="/tmp/dotfiles-install.log"
TOTAL_STEPS=13
CURRENT_STEP=0

# ==============================================================
#                       Helper functions
# ==============================================================

begin_step() {
    CURRENT_STEP=$((CURRENT_STEP + 1))
    printf "  [ %2d/%-2d ] %s...\n" "$CURRENT_STEP" "$TOTAL_STEPS" "$1"
}

end_step() {
    printf "  [ %2d/%-2d ] %s  ✓\n" "$CURRENT_STEP" "$TOTAL_STEPS" "$1"
}

trap 'printf "\n\033[31m  Error at step %d. Check %s for details.\033[0m\n" "$CURRENT_STEP" "$LOG_FILE"' ERR

check_command() {
    local cmd="$1"
    command -v "$cmd" &>/dev/null
}

# ==============================================================
#                       Step functions
# ==============================================================

# Suppress login message
suppress_login_message() {
    begin_step "Suppress login message"
    touch ~/.hushlogin >> "$LOG_FILE" 2>&1
    end_step "Suppress login message"
}



# Prompt for Git user details
prompt_git_config() {
    begin_step "Git configuration"

    printf "\n"

    read -p "  Enter your full name: " git_name
    read -p "  Enter your email: " git_email

    export GIT_CONFIG_NAME="$git_name"
    export GIT_CONFIG_EMAIL="$git_email"

    printf "\n"
    end_step "Git configuration"
}

# Apply Git configuration
apply_git_config() {
    begin_step "Apply Git configuration"
    if [[ -n "$GIT_CONFIG_NAME" && -n "$GIT_CONFIG_EMAIL" ]]; then
        git config --global user.name "$GIT_CONFIG_NAME" >> "$LOG_FILE" 2>&1
        git config --global user.email "$GIT_CONFIG_EMAIL" >> "$LOG_FILE" 2>&1
    else
        printf "\n\033[33m  Git user details not provided, skipping.\033[0m\n" >> "$LOG_FILE" 2>&1
    fi
    end_step "Apply Git configuration"
}

# Install Homebrew
install_brew() {
    begin_step "Install Homebrew"
    if check_command brew; then
        : # already installed
    else
        NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" >> "$LOG_FILE" 2>&1
    fi

    eval "$(/opt/homebrew/bin/brew shellenv)"
    grep -q "brew shellenv" ~/.zshrc 2>/dev/null || echo 'eval "$(brew shellenv)"' >>~/.zshrc
    end_step "Install Homebrew"
}

# Create symlinks for dotfiles
create_symlinks() {
    begin_step "Create symlinks"

    rm -rf ~/Library/Application\ Support/Code/User/settings.json ~/.zshrc ~/.p10k.zsh ~/.tmux.conf ~/.tmux/scripts/resize-panel.sh ~/.config/nvim >> "$LOG_FILE" 2>&1
    mkdir -p ~/.tmux ~/.tmux/scripts ~/.config >> "$LOG_FILE" 2>&1

    ln -s "$(pwd)/vscode/settings.json" ~/Library/Application\ Support/Code/User/settings.json
    ln -s "$(pwd)/zsh/zshrc" ~/.zshrc
    ln -s "$(pwd)/zsh/p10k.zsh" ~/.p10k.zsh
    ln -s "$(pwd)/tmux/.tmux.conf" ~/.tmux.conf
    ln -s "$(pwd)/tmux/scripts/resize-panel.sh" ~/.tmux/scripts/resize-panel.sh
    ln -s "$(pwd)/nvim" ~/.config/nvim

    chmod +x ~/.tmux/scripts/resize-panel.sh

    end_step "Create symlinks"
}

# Print completion message
print_completion() {
    printf "\n"
    printf "  ____        _    __ _ _           \n"
    printf " |  _ \  ___ | |_ / _(_) | ___  ___ \n"
    printf " | | | |/ _ \| __| |_| | |/ _ \/ __|\n"
    printf " | |_| | (_) | |_|  _| | |  __/\__ \\ \n"
    printf " |____/ \___/ \__|_| |_|_|\___||___/ \n"
    printf "\n"
    printf " Your local environment is ready to use!\n"
    printf " Full log: %s\n\n" "$LOG_FILE"
}

# ==============================================================
#                       MacOS configs
# ==============================================================

# Install common packages via Homebrew
install_brew_packages() {
    begin_step "Install Brew packages"

    brew update >> "$LOG_FILE" 2>&1
    brew install \
        openssl readline sqlite3 xz zlib \
        wget \
        zsh-completions \
        zsh-autosuggestions \
        zsh-syntax-highlighting \
        tree \
        fzf \
        ripgrep \
        webp \
        uv \
        neovim \
        go \
        graphviz \
        terraform \
        fnm \
        neofetch \
        kubernetes-cli \
        minikube \
        awscli \
        tmux \
        gh >> "$LOG_FILE" 2>&1

    end_step "Install Brew packages"
}

# Install MacOS packages via Homebrew cask
install_brew_cask_packages() {
    begin_step "Install Brew Cask packages"

    brew install --cask \
        visual-studio-code \
        iterm2 \
        claude-code \
        docker \
        jetbrains-toolbox \
        "logi-options+" >> "$LOG_FILE" 2>&1

    end_step "Install Brew Cask packages"
}

# Install VSCode extensions
install_vscode_extensions() {
    begin_step "Install VSCode extensions"
    code --install-extension aeschli.vscode-css-formatter >> "$LOG_FILE" 2>&1
    code --install-extension christian-kohler.npm-intellisense >> "$LOG_FILE" 2>&1
    code --install-extension dbaeumer.vscode-eslint >> "$LOG_FILE" 2>&1
    code --install-extension donjayamanne.githistory >> "$LOG_FILE" 2>&1
    code --install-extension dracula-theme.theme-dracula >> "$LOG_FILE" 2>&1
    code --install-extension eamodio.gitlens >> "$LOG_FILE" 2>&1
    code --install-extension golang.go >> "$LOG_FILE" 2>&1
    code --install-extension hashicorp.terraform >> "$LOG_FILE" 2>&1
    code --install-extension ivory-lab.jenkinsfile-support >> "$LOG_FILE" 2>&1
    code --install-extension kisstkondoros.vscode-codemetrics >> "$LOG_FILE" 2>&1
    code --install-extension ms-azuretools.vscode-azurefunctions >> "$LOG_FILE" 2>&1
    code --install-extension ms-azuretools.vscode-azureresourcegroups >> "$LOG_FILE" 2>&1
    code --install-extension ms-azuretools.vscode-docker >> "$LOG_FILE" 2>&1
    code --install-extension ms-vscode.azure-account >> "$LOG_FILE" 2>&1
    code --install-extension ms-vsliveshare.vsliveshare >> "$LOG_FILE" 2>&1
    code --install-extension ms-vsliveshare.vsliveshare-audio >> "$LOG_FILE" 2>&1
    code --install-extension msjsdiag.debugger-for-chrome >> "$LOG_FILE" 2>&1
    code --install-extension NicolasVuillamy.vscode-groovy-lint >> "$LOG_FILE" 2>&1
    code --install-extension nodesource.vscode-for-node-js-development-pack >> "$LOG_FILE" 2>&1
    code --install-extension nopjmp.fairyfloss >> "$LOG_FILE" 2>&1
    code --install-extension pnp.polacode >> "$LOG_FILE" 2>&1
    code --install-extension RobbOwen.synthwave-vscode >> "$LOG_FILE" 2>&1
    code --install-extension samuelcolvin.jinjahtml >> "$LOG_FILE" 2>&1
    code --install-extension streetsidesoftware.code-spell-checker >> "$LOG_FILE" 2>&1
    code --install-extension techer.open-in-browser >> "$LOG_FILE" 2>&1
    code --install-extension vscode-icons-team.vscode-icons >> "$LOG_FILE" 2>&1
    code --install-extension wix.vscode-import-cost >> "$LOG_FILE" 2>&1
    code --install-extension Zignd.html-css-class-completion >> "$LOG_FILE" 2>&1
    end_step "Install VSCode extensions"
}

# Install packages not supported by Homebrew
install_non_brew_packages() {
    begin_step "Install non-Brew packages"
    
    rm -rf ~/.oh-my-zsh ~/.zshrc >> "$LOG_FILE" 2>&1

    RUNZSH=no CHSH=no sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" >> "$LOG_FILE" 2>&1

    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k" >> "$LOG_FILE" 2>&1

    end_step "Install non-Brew packages"
}

# Install fonts via Homebrew
install_macos_fonts() {
    begin_step "Install macOS fonts"
    brew install --cask font-fira-code >> "$LOG_FILE" 2>&1
    end_step "Install macOS fonts"
}

# Set computer name & hostname
set_hostname() {
    begin_step "Set hostname"

    printf "\n"

    echo "  Current computer name: $(scutil --get ComputerName 2>/dev/null || echo 'Not set yet.')"
    echo "  Current hostname: $(scutil --get HostName 2>/dev/null || echo 'Not set yet.')"
    echo "  Current local hostname: $(scutil --get LocalHostName 2>/dev/null || echo 'Not set yet.')"

    read -p "  Enter new computer name (or press Enter to keep current): " new_name

    if [[ -n "$new_name" ]]; then
        sudo scutil --set ComputerName "$new_name"
        sudo scutil --set HostName "$new_name"
        sudo scutil --set LocalHostName "$new_name"
        sudo defaults write /Library/Preferences/SystemConfiguration/com.apple.smb.server NetBIOSName -string "$new_name"
    fi

    printf "\n"
    end_step "Set hostname"
}

# ==============================================================
#                       Runtime installations
# ==============================================================

# Install latest Node.js via fnm
install_node() {
    begin_step "Install Node.js (fnm)"

    eval "$(fnm env)" >> "$LOG_FILE" 2>&1

    fnm install --latest >> "$LOG_FILE" 2>&1
    fnm default "$(fnm current)" >> "$LOG_FILE" 2>&1
    
    end_step "Install Node.js (fnm)"
}

# ==============================================================
#                       MacOS configs
# ==============================================================

update_macos_defaults() {
    begin_step "Update macOS defaults"
    defaults write com.apple.finder ShowPathbar -bool true >> "$LOG_FILE" 2>&1
    end_step "Update macOS defaults"
}

setup_local_env() {
    > "$LOG_FILE"
    printf "Setting up dotfiles...\n\n"

    suppress_login_message
    set_hostname
    update_macos_defaults
    install_brew
    install_brew_packages
    install_brew_cask_packages
    install_node
    install_vscode_extensions
    install_non_brew_packages
    install_macos_fonts
    prompt_git_config
    apply_git_config
    create_symlinks

    print_completion
}

# Ask for admin pass and keep the session alive
sudo -v
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

setup_local_env
