#!/usr/bin/env bash

# Get the directory where this script lives
DIR="$(cd "$(dirname "$0")" && pwd)"

# Create $BACKUP_DOTFILES directory if it doesn't exist
BACKUP_DOTFILES="$DIR/backup_dotfiles"
[[ ! -d "$BACKUP_DOTFILES" ]] && mkdir -pv "$BACKUP_DOTFILES"

# Destroy/re-create subdirectories of $PLUGIN_INSTALL_DIR
PLUGIN_INSTALL_DIR="$HOME/.plugin_install_dir"
rm -rf "$PLUGIN_INSTALL_DIR/vundle" && mkdir -pv "$PLUGIN_INSTALL_DIR/vundle"

# Backup original dotfiles if they are not symbolic links, otherwise delete
echo "Saving a copy of real dotfiles and deleting symbolic links"
echo "cd $HOME"
cd $HOME
[[ ! -L .shell && -d .shell ]] && mv -v .shell "$BACKUP_DOTFILES" || rm -v .shell 2>/dev/null
[[ ! -L .vim && -d .vim ]] && mv -v .vim "$BACKUP_DOTFILES" || rm -v .vim 2>/dev/null
[[ ! -L .bash_profile && -f .bash_profile ]] && mv -v .bash_profile "$BACKUP_DOTFILES" || rm -v .bash_profile 2>/dev/null
[[ ! -L .bashrc && -f .bashrc ]] && mv -v .bashrc "$BACKUP_DOTFILES" || rm -v .bashrc 2>/dev/null
[[ ! -L .gitconfig && -f .gitconfig ]] && mv -v .gitconfig "$BACKUP_DOTFILES" || rm -v .gitconfig 2>/dev/null
[[ ! -L .inputrc && -f .inputrc ]] && mv -v .inputrc "$BACKUP_DOTFILES" || rm -v .inputrc 2>/dev/null
[[ ! -L .tmux.conf && -f .tmux.conf ]] && mv -v .tmux.conf "$BACKUP_DOTFILES" || rm -v .tmux.conf 2>/dev/null
[[ ! -L .vimrc && -f .vimrc ]]  && mv -v .vimrc "$BACKUP_DOTFILES" || rm -v .vimrc 2>/dev/null
[[ ! -L .Xdefaults && -f .Xdefaults ]] && mv -v .Xdefaults "$BACKUP_DOTFILES" || rm -v .Xdefaults 2>/dev/null
[[ ! -L .zshrc && -f .zshrc ]] && mv -v .zshrc "$BACKUP_DOTFILES" || rm -v .zshrc 2>/dev/null

# Make sure the ~/.config directory exists
[[ ! -d "$HOME/.config" ]] && mkdir -pv "$HOME/.config"
cd $HOME/.config

# Backup original dotfiles in the ~/.config/ directory
[[ ! -L ranger/rc.conf && -f ranger/rc.conf ]] && mv -v ranger/rc.conf "$BACKUP_DOTFILES/ranger_rc.conf" || rm -v ranger/rc.conf 2>/dev/null

# Create symbolic links to the individual dotfiles
ln -s "$DIR/shell" "$HOME/.shell"
ln -s "$DIR/shell/bash/bash_profile" "$HOME/.bash_profile"
ln -s "$DIR/shell/bash/bashrc" "$HOME/.bashrc"
ln -s "$DIR/.gitconfig" "$HOME/.gitconfig"
ln -s "$DIR/.inputrc" "$HOME/.inputrc"
ln -s "$DIR/tmux/tmux.conf" "$HOME/.tmux.conf"
ln -s "$DIR/vim" "$HOME/.vim"
ln -s "$DIR/vim/vimrc" "$HOME/.vimrc"
ln -s "$DIR/.Xdefaults" "$HOME/.Xdefaults"
ln -s "$DIR/shell/zsh/zshrc" "$HOME/.zshrc"

# Create symbolic links to individual dotfiles that live in ~/.config
[[ ! -d "$HOME/.config/ranger" ]] && mkdir -pv "$HOME/.config/ranger"
ln -s "$DIR/ranger/rc.conf" "$HOME/.config/ranger/rc.conf"

# Save the full path to this dotfiles repository to `~/.dotfiles_path`
echo "$DIR" > $HOME/.dotfiles_path

# Fetch the git submodules required
cd $DIR
git submodule init && git submodule update

# Download/install Vim plugins added to vundle
vim +PluginInstall +qall

# List the symbolic links that exist in $HOME
echo -e "\nListing symbolic links that exist in $HOME"
ls -FgohA $HOME | grep '^l'

# List the symbolic links that exist in $HOME/.config
cd $HOME/.config
echo -e "\nListing symbolic links that exist in $HOME/.config"
ls -FgohA {ranger,awesome}/* 2>/dev/null | grep '^l'
