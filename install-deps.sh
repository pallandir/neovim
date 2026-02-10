#!/bin/bash

echo "=== Neovim Updater ==="
echo ""
echo "This script only updates Neovim to the latest version."
echo "For full system dependencies, run the dotfiles install script:"
echo "  Linux: ~/Documents/projects/dotfiles/linux/install.sh"
echo "  macOS: ~/Documents/projects/dotfiles/macos/install.sh"
echo ""

if [[ "$(uname)" == "Darwin" ]]; then
  echo "Updating Neovim via Homebrew..."
  brew upgrade nvim || brew install nvim
else
  echo "Updating Neovim via PPA (unstable)..."
  sudo add-apt-repository -y ppa:neovim-ppa/unstable
  sudo apt-get update
  sudo apt-get install -y neovim
fi

echo ""
echo "Cleaning lazy.nvim cache..."
rm -rf ~/.local/share/nvim/lazy
rm -rf ~/.local/state/nvim/lazy

echo ""
echo "=== Update Complete ==="
nvim --version | head -1
echo ""
echo "Run :Lazy sync in Neovim to reinstall plugins."
