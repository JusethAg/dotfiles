#!/usr/bin/env bash

echo "Installing VSCode extensions..."

code -v > /dev/null
if [[ $? -eq 0 ]];then
  code --install-extension kisstkondoros.vscode-codemetrics
  code --install-extension aeschli.vscode-css-formatter
  code --install-extension msjsdiag.debugger-for-chrome
  code --install-extension PeterJausovec.vscode-docker
  code --install-extension dracula-theme.theme-dracula
  code --install-extension dbaeumer.vscode-eslint
  code --install-extension nopjmp.fairyfloss
  code --install-extension donjayamanne.githistory
  code --install-extension eamodio.gitlens
  code --install-extension wix.vscode-import-cost
  code --install-extension Zignd.html-css-class-completion
  code --install-extension christian-kohler.npm-intellisense
  code --install-extension techer.open-in-browser
  code --install-extension pnp.polacode
  code --install-extension nodesource.vscode-for-node-js-development-pack
  code --install-extension robertohuertasm.vscode-icons
else
  echo "Error, command 'code' doesn't exist"
fi