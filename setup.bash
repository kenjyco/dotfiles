#!/usr/bin/env bash

# Get the directory where this script lives
DIR="$(cd "$(dirname "$0")" && pwd)"

# Create $BACKUP_DOTFILES directory if it doesn't exist
BACKUP_DOTFILES="$DIR/backup_dotfiles"
[[ ! -d "$BACKUP_DOTFILES" ]] && mkdir -pv "$BACKUP_DOTFILES"

# Backup original dotfiles if they are not symbolic links, otherwise delete
echo "Saving a copy of real dotfiles and deleting symbolic links"
echo "cd $HOME"
cd $HOME
[[ ! -L .bash_profile && -f .bash_profile ]] && mv -v .bash_profile "$BACKUP_DOTFILES" || rm -v .bash_profile 2>/dev/null
[[ ! -L .bashrc && -f .bashrc ]] && mv -v .bashrc "$BACKUP_DOTFILES" || rm -v .bashrc 2>/dev/null
[[ ! -L .gitconfig && -f .gitconfig ]] && mv -v .gitconfig "$BACKUP_DOTFILES" || rm -v .gitconfig 2>/dev/null
[[ ! -L .inputrc && -f .inputrc ]] && mv -v .inputrc "$BACKUP_DOTFILES" || rm -v .inputrc 2>/dev/null
[[ ! -L .tmux.conf && -f .tmux.conf ]] && mv -v .tmux.conf "$BACKUP_DOTFILES" || rm -v .tmux.conf 2>/dev/null
[[ ! -L .vimrc && -f .vimrc ]]  && mv -v .vimrc "$BACKUP_DOTFILES" || rm -v .vimrc 2>/dev/null
[[ ! -L .Xdefaults && -f .Xdefaults ]] && mv -v .Xdefaults "$BACKUP_DOTFILES" || rm -v .Xdefaults 2>/dev/null
[[ ! -L .zshrc && -f .zshrc ]] && mv -v .zshrc "$BACKUP_DOTFILES" || rm -v .zshrc 2>/dev/null

# Create symbolic links to the individual dotfiles
ln -s "$DIR/.bash_profile" "$HOME/.bash_profile"
ln -s "$DIR/.bashrc" "$HOME/.bashrc"
ln -s "$DIR/.gitconfig" "$HOME/.gitconfig"
ln -s "$DIR/.inputrc" "$HOME/.inputrc"
ln -s "$DIR/.tmux.conf" "$HOME/.tmux.conf"
ln -s "$DIR/.vimrc" "$HOME/.vimrc"
ln -s "$DIR/.Xdefaults" "$HOME/.Xdefaults"
ln -s "$DIR/.zshrc" "$HOME/.zshrc"

# List the symbolic links that exist in $HOME
echo -e "\nListing symbolic links that exist in $HOME"
ls -FgohA $HOME | grep '^l'
