#!/usr/bin/env bash

# Get the directory where this script lives
DIR="$(cd "$(dirname "$0")" && pwd)"

if [[ "$1" == "clean" || "$2" == "clean" ]]; then
    echo -e "\nDeleting ~/.beu ~/.nvm, ~/.npm, ~/.phantomjs, ~/venv, and ~/.downloaded-completions"
    rm -rf ~/.beu ~/.nvm ~/.npm ~/.phantomjs ~/venv ~/.downloaded-completions 2>/dev/null
    unset NVM_DIR
    if [[ $(uname) != "Darwin" && -d ~/.pyenv ]]; then
        echo -e "\nDeleting ~/.pyenv"
        rm -rf ~/.pyenv
    fi
    echo -e "\nDeleting ~/.git-completion.bash ~/.docker-completion.bash, ~/.docker-compose-completion.bash, and ~/.bash_completion"
    rm -f ~/.git-completion.bash ~/.docker-completion.bash ~/.docker-compose-completion.bash ~/.bash_completion 2>/dev/null
    bash_completion_dir="$(brew --prefix 2>/dev/null)/etc/bash_completion.d"
    echo -e "\nDeleting from $bash_completion_dir: docker, docker-compose, git-completion.bash"
    sudo rm -f $bash_completion_dir/docker $bash_completion_dir/docker-compose $bash_completion_dir/git-completion.bash 2>/dev/null
    echo -e "\nDeleting from ~/.zsh/completion: _docker, _docker-compose, git-completion.zsh"
    rm -f ~/.zsh/completion/_docker ~/.zsh/completion/_docker-compose ~/.zsh/completion/git-completion.zsh 2>/dev/null
fi

# Delete broken symbolic links
find ~ -maxdepth 1 -type l | xargs -I {} file {} | grep "broken symbolic link" | cut -d: -f1 | tr '\n' '\0' | xargs -0 rm -v 2>/dev/null

_lite_install=
if [[ "$1" == "lite" || "$2" == "lite" ]]; then
    _lite_install=yes
    echo -e "\nL I T E :   Only going to set symlinks.."
elif [[ $(uname) == "Darwin" ]] && ! command -v brew >/dev/null 2>&1; then
    _lite_install=yes
    echo "L I T E : macOS without Homebrew; using no-brew configuration."
fi

# Create $BACKUP_DOTFILES directory if it doesn't exist
BACKUP_DOTFILES="$DIR/backup_dotfiles"
[[ ! -d "$BACKUP_DOTFILES" ]] && mkdir -pv "$BACKUP_DOTFILES"

# Backup original dotfiles if they are not symbolic links, otherwise delete
echo -e "\nSaving a copy of real dotfiles and deleting symbolic links"
echo "cd $HOME"
cd $HOME
[[ ! -L .vim && -d .vim ]] && mv -v .vim "$BACKUP_DOTFILES" || rm -v .vim 2>/dev/null
[[ ! -L .tmux && -d .tmux ]] && mv -v .tmux "$BACKUP_DOTFILES" || rm -v .tmux 2>/dev/null
[[ ! -L .gitconfig && -f .gitconfig ]] && mv -v .gitconfig "$BACKUP_DOTFILES" || rm -v .gitconfig 2>/dev/null
[[ ! -L .inputrc && -f .inputrc ]] && mv -v .inputrc "$BACKUP_DOTFILES" || rm -v .inputrc 2>/dev/null
[[ ! -L .editrc && -f .editrc ]] && mv -v .editrc "$BACKUP_DOTFILES" || rm -v .editrc 2>/dev/null
[[ ! -L .tmux.conf && -f .tmux.conf ]] && mv -v .tmux.conf "$BACKUP_DOTFILES" || rm -v .tmux.conf 2>/dev/null
[[ ! -L .vimrc && -f .vimrc ]]  && mv -v .vimrc "$BACKUP_DOTFILES" || rm -v .vimrc 2>/dev/null
[[ ! -L .Xdefaults && -f .Xdefaults ]] && mv -v .Xdefaults "$BACKUP_DOTFILES" || rm -v .Xdefaults 2>/dev/null
[[ ! -L .xinitrc && -f .xinitrc ]] && mv -v .xinitrc "$BACKUP_DOTFILES" || rm -v .xinitrc 2>/dev/null
if [[ -z "$_lite_install" ]]; then
    [[ ! -L wallpapers && -d wallpapers ]] && mv -v wallpapers "$BACKUP_DOTFILES" || rm -v wallpapers 2>/dev/null
    [[ ! -L .ctags && -d .ctags ]] && mv -v .ctags "$BACKUP_DOTFILES" || rm -v .ctags 2>/dev/null
    [[ ! -L .ipython && -d .ipython ]] && mv -v .ipython "$BACKUP_DOTFILES" || rm -v .ipython 2>/dev/null
    [[ ! -L .psqlrc && -f .psqlrc ]] && mv -v .psqlrc "$BACKUP_DOTFILES" || rm -v .psqlrc 2>/dev/null
fi

# Make sure the ~/.config directory exists
[[ ! -d "$HOME/.config" ]] && mkdir -pv "$HOME/.config"
cd $HOME/.config

# Backup original dotfiles in the ~/.config/ directory
if [[ -z "$_lite_install" ]]; then
    [[ ! -L ranger/rc.conf && -f ranger/rc.conf ]] && mv -v ranger/rc.conf "$BACKUP_DOTFILES/ranger_rc.conf" || rm -v ranger/rc.conf 2>/dev/null
fi
if command -v nvim >/dev/null 2>&1; then
    if [[ ! -L nvim/init.vim && -f nvim/init.vim ]]; then
        if [[ -e "$BACKUP_DOTFILES/nvim_init.vim" ]]; then
            echo "ERROR: Refusing to overwrite backed up nvim_init.vim" >&2
            exit 1
        fi
        mv -v nvim/init.vim "$BACKUP_DOTFILES/nvim_init.vim"
    elif [[ -L nvim/init.vim ]]; then
        rm -v nvim/init.vim
    fi
fi
[[ ! -L awesome/rc.lua && -f awesome/rc.lua ]] && mv -v awesome/rc.lua "$BACKUP_DOTFILES/awesome_rc.lua" || rm -v awesome/rc.lua 2>/dev/null
[[ ! -L awesome/theme.lua && -f awesome/theme.lua ]] && mv -v awesome/theme.lua "$BACKUP_DOTFILES/awesome_theme.lua" || rm -v awesome/theme.lua 2>/dev/null

# Create symbolic links to the individual dotfiles
ln -s "$DIR/git/gitconfig" "$HOME/.gitconfig"
ln -s "$DIR/input/inputrc" "$HOME/.inputrc"
ln -s "$DIR/input/editrc" "$HOME/.editrc"
ln -s "$DIR/vim" "$HOME/.vim"
ln -s "$DIR/tmux" "$HOME/.tmux"
if [[ -z "$_lite_install" ]]; then
    ln -s "$DIR/wallpapers" "$HOME/wallpapers"
    ln -s "$DIR/psql/psqlrc" "$HOME/.psqlrc"
    ln -s "$DIR/ctags/ctags" "$HOME/.ctags"
    ln -s "$DIR/ipython" "$HOME/.ipython"
fi
if type xinit &>/dev/null; then
    ln -s "$DIR/x/Xdefaults" "$HOME/.Xdefaults"
    ln -s "$DIR/x/xinitrc" "$HOME/.xinitrc"
fi

if [[ $(uname) == "Darwin" ]]; then
    if [[ -n "$_lite_install" ]]; then
        ln -s "$DIR/tmux/tmux-mac-no-brew.conf" "$HOME/.tmux.conf"
    elif command -v brew >/dev/null 2>&1; then
        echo -e "\nMaking sure reattach-to-user-namespace is installed (for tmux)"
        brew install reattach-to-user-namespace
        ln -s "$DIR/tmux/tmux-mac.conf" "$HOME/.tmux.conf"
    else
        echo "ERROR: Non-lite macOS setup requires Homebrew" >&2
        exit 1
    fi
    if [[ -z "$_lite_install" ]]; then
        ln -s "$DIR/vim/vimrc-mac" "$HOME/.vimrc"
    else
        ln -s "$DIR/vim/vimrc-mac-no-vundle" "$HOME/.vimrc"
    fi
else
    tmux_version=$(tmux -V | perl -pe 's/^tmux\s+(\d+\.*\d*).*/$1/')
    IFS='.' read major minor <<< "$tmux_version"
    # if (( $(echo "$tmux_version < 2.6" | bc -l) )); then
    if [[ $major -le 2 && $minor -lt 6 ]]; then
        ln -s "$DIR/tmux/tmux-pre2.6.conf" "$HOME/.tmux.conf"
    else
        ln -s "$DIR/tmux/tmux.conf" "$HOME/.tmux.conf"
    fi
    if [[ -z "$_lite_install" ]]; then
        ln -s "$DIR/vim/vimrc" "$HOME/.vimrc"
    else
        ln -s "$DIR/vim/vimrc-no-vundle" "$HOME/.vimrc"
    fi
fi

# Create symbolic links to individual dotfiles that live in ~/.config
if [[ -z "$_lite_install" ]]; then
    [[ ! -d "$HOME/.config/ranger" ]] && mkdir -pv "$HOME/.config/ranger"
    ln -s "$DIR/ranger/rc.conf" "$HOME/.config/ranger/rc.conf"
fi
if command -v nvim >/dev/null 2>&1; then
    [[ ! -d "$HOME/.config/nvim" ]] && mkdir -pv "$HOME/.config/nvim"
    if [[ -e "$HOME/.config/nvim/init.vim" || -L "$HOME/.config/nvim/init.vim" ]]; then
        echo "ERROR: Existing nvim init.vim was not backed up; refusing to overwrite" >&2
        exit 1
    fi
    ln -s "$DIR/nvim/init.vim" "$HOME/.config/nvim/init.vim"
fi
if type awesome &>/dev/null; then
    [[ ! -d "$HOME/.config/awesome" ]] && mkdir -pv "$HOME/.config/awesome"
    ln -s "$DIR/x/awesome/rc.lua" "$HOME/.config/awesome/rc.lua"
    ln -s "$DIR/x/awesome/theme.lua" "$HOME/.config/awesome/theme.lua"
fi

# Save the full path to this dotfiles repository to `~/.dotfiles_path`
echo "$DIR" > $HOME/.dotfiles_path

# Reload tmux config only if a tmux server is already running.
if command -v tmux >/dev/null 2>&1 && tmux list-sessions >/dev/null 2>&1; then
    tmux source-file "$HOME/.tmux.conf"
fi

if [[ -z "$_lite_install" ]]; then
    # Destroy/re-create subdirectories of $PLUGIN_INSTALL_DIR
    PLUGIN_INSTALL_DIR="$HOME/.plugin_install_dir"
    rm -rf "$PLUGIN_INSTALL_DIR/vundle" && mkdir -pv "$PLUGIN_INSTALL_DIR/vundle"

    # Fetch the git submodules required
    cd $DIR
    echo -e "\nUpdating git submodules, if necessary"
    git submodule init && git submodule update

    # Download/install Vim plugins added to vundle
    vim +PluginInstall +qall

    # Copy a xscreensaver config file if none in use
    [[ ! -s $HOME/.xscreensaver ]] && cp -av $DIR/x/xscreensaver/none $HOME/.xscreensaver
fi

# Remove any empty directories
rmdir * 2>/dev/null

# List the symbolic links that exist in $HOME
echo -e "\nListing symbolic links that exist in $HOME"
ls -FgohA $HOME | grep '^l'

# List the symbolic links that exist in $HOME/.config
cd $HOME/.config
echo -e "\nListing symbolic links that exist in $HOME/.config"
ls -FgohA {ranger,awesome}/* 2>/dev/null | grep '^l'
