#!/usr/bin/env bash

# Get the directory where this script lives
DIR="$(cd "$(dirname "$0")" && pwd)"

_call_make_home_venv=
if [[ "$1" == "clean" ]]; then
    [[ -d ~/venv ]] && _call_make_home_venv=yes
    echo -e "\nDeleting ~/.beu ~/.nvm, ~/.phantomjs, and ~/venv"
    rm -rf ~/.beu ~/.nvm ~/.phantomjs ~/venv 2>/dev/null
fi

# Create $BACKUP_DOTFILES directory if it doesn't exist
BACKUP_DOTFILES="$DIR/backup_dotfiles"
[[ ! -d "$BACKUP_DOTFILES" ]] && mkdir -pv "$BACKUP_DOTFILES"

# Destroy/re-create subdirectories of $PLUGIN_INSTALL_DIR
PLUGIN_INSTALL_DIR="$HOME/.plugin_install_dir"
rm -rf "$PLUGIN_INSTALL_DIR/vundle" && mkdir -pv "$PLUGIN_INSTALL_DIR/vundle"

# Backup original dotfiles if they are not symbolic links, otherwise delete
echo -e "\nSaving a copy of real dotfiles and deleting symbolic links"
echo "cd $HOME"
cd $HOME
[[ ! -L bin && -d bin ]] && mv -v bin "$BACKUP_DOTFILES" || rm -v bin 2>/dev/null
[[ ! -L wallpapers && -d wallpapers ]] && mv -v wallpapers "$BACKUP_DOTFILES" || rm -v wallpapers 2>/dev/null
[[ ! -L .shell && -d .shell ]] && mv -v .shell "$BACKUP_DOTFILES" || rm -v .shell 2>/dev/null
[[ ! -L .vim && -d .vim ]] && mv -v .vim "$BACKUP_DOTFILES" || rm -v .vim 2>/dev/null
[[ ! -L .ipython && -d .ipython ]] && mv -v .ipython "$BACKUP_DOTFILES" || rm -v .ipython 2>/dev/null
[[ ! -L .tmux && -d .tmux ]] && mv -v .tmux "$BACKUP_DOTFILES" || rm -v .tmux 2>/dev/null
[[ ! -L .bash_profile && -f .bash_profile ]] && mv -v .bash_profile "$BACKUP_DOTFILES" || rm -v .bash_profile 2>/dev/null
[[ ! -L .bashrc && -f .bashrc ]] && mv -v .bashrc "$BACKUP_DOTFILES" || rm -v .bashrc 2>/dev/null
[[ ! -L .gitconfig && -f .gitconfig ]] && mv -v .gitconfig "$BACKUP_DOTFILES" || rm -v .gitconfig 2>/dev/null
[[ ! -L .inputrc && -f .inputrc ]] && mv -v .inputrc "$BACKUP_DOTFILES" || rm -v .inputrc 2>/dev/null
[[ ! -L .editrc && -f .editrc ]] && mv -v .editrc "$BACKUP_DOTFILES" || rm -v .editrc 2>/dev/null
[[ ! -L .tmux.conf && -f .tmux.conf ]] && mv -v .tmux.conf "$BACKUP_DOTFILES" || rm -v .tmux.conf 2>/dev/null
[[ ! -L .psqlrc && -f .psqlrc ]] && mv -v .psqlrc "$BACKUP_DOTFILES" || rm -v .psqlrc 2>/dev/null
[[ ! -L .vimrc && -f .vimrc ]]  && mv -v .vimrc "$BACKUP_DOTFILES" || rm -v .vimrc 2>/dev/null
[[ ! -L .Xdefaults && -f .Xdefaults ]] && mv -v .Xdefaults "$BACKUP_DOTFILES" || rm -v .Xdefaults 2>/dev/null
[[ ! -L .xinitrc && -f .xinitrc ]] && mv -v .xinitrc "$BACKUP_DOTFILES" || rm -v .xinitrc 2>/dev/null
[[ ! -L .zshrc && -f .zshrc ]] && mv -v .zshrc "$BACKUP_DOTFILES" || rm -v .zshrc 2>/dev/null

# Make sure the ~/.config directory exists
[[ ! -d "$HOME/.config" ]] && mkdir -pv "$HOME/.config"
cd $HOME/.config

# Backup original dotfiles in the ~/.config/ directory
[[ ! -L ranger/rc.conf && -f ranger/rc.conf ]] && mv -v ranger/rc.conf "$BACKUP_DOTFILES/ranger_rc.conf" || rm -v ranger/rc.conf 2>/dev/null
[[ ! -L awesome/rc.lua && -f awesome/rc.lua ]] && mv -v awesome/rc.lua "$BACKUP_DOTFILES/awesome_rc.lua" || rm -v awesome/rc.lua 2>/dev/null
[[ ! -L awesome/theme.lua && -f awesome/theme.lua ]] && mv -v awesome/theme.lua "$BACKUP_DOTFILES/awesome_theme.lua" || rm -v awesome/theme.lua 2>/dev/null

# Create symbolic links to the individual dotfiles
ln -s "$DIR/bin" "$HOME/bin"
ln -s "$DIR/wallpapers" "$HOME/wallpapers"
ln -s "$DIR/shell" "$HOME/.shell"
ln -s "$DIR/shell/bash/bash_profile" "$HOME/.bash_profile"
ln -s "$DIR/shell/bash/bashrc" "$HOME/.bashrc"
ln -s "$DIR/git/gitconfig" "$HOME/.gitconfig"
ln -s "$DIR/input/inputrc" "$HOME/.inputrc"
ln -s "$DIR/input/editrc" "$HOME/.editrc"
ln -s "$DIR/psql/psqlrc" "$HOME/.psqlrc"
ln -s "$DIR/vim" "$HOME/.vim"
ln -s "$DIR/ipython" "$HOME/.ipython"
ln -s "$DIR/tmux" "$HOME/.tmux"
ln -s "$DIR/x/Xdefaults" "$HOME/.Xdefaults"
ln -s "$DIR/x/xinitrc" "$HOME/.xinitrc"
ln -s "$DIR/shell/zsh/zshrc" "$HOME/.zshrc"

if [[ $(uname) == 'Darwin' ]]; then
    echo -e "\nMaking sure reattach-to-user-namespace is installed (for tmux)"
    brew install reattach-to-user-namespace
    ln -s "$DIR/tmux/tmux-mac.conf" "$HOME/.tmux.conf"
    ln -s "$DIR/vim/vimrc-mac" "$HOME/.vimrc"
else
    ln -s "$DIR/tmux/tmux.conf" "$HOME/.tmux.conf"
    ln -s "$DIR/vim/vimrc" "$HOME/.vimrc"
fi

# Create symbolic links to individual dotfiles that live in ~/.config
[[ ! -d "$HOME/.config/ranger" ]] && mkdir -pv "$HOME/.config/ranger"
ln -s "$DIR/ranger/rc.conf" "$HOME/.config/ranger/rc.conf"
[[ ! -d "$HOME/.config/awesome" ]] && mkdir -pv "$HOME/.config/awesome"
ln -s "$DIR/x/awesome/rc.lua" "$HOME/.config/awesome/rc.lua"
ln -s "$DIR/x/awesome/theme.lua" "$HOME/.config/awesome/theme.lua"

# Save the full path to this dotfiles repository to `~/.dotfiles_path`
echo "$DIR" > $HOME/.dotfiles_path

# Download wallpapers
cd $DIR/wallpapers
bash ./download.sh

# Fetch the git submodules required
cd $DIR
echo -e "\nUpdating git submodules, if necessary"
git submodule init && git submodule update

# Download/install Vim plugins added to vundle
vim +PluginInstall +qall

# Source the ~/.tmux.conf file
tmux source-file ~/.tmux.conf

# Install beu
if [[ ! -d ~/.beu ]]; then
    echo -e "\nInstalling beu"
    curl -o- https://raw.githubusercontent.com/kenjyco/beu/master/install.sh | bash
fi

# Copy a xscreensaver config file if none in use
[[ ! -s $HOME/.xscreensaver ]] && cp -av $DIR/x/xscreensaver/none $HOME/.xscreensaver

# Install nvm, a couple versions of node, and some "global" packages
if [[ ! -d ~/.nvm ]]; then
    echo -e "\nInstalling nvm, node 4.8.4, node 6.10.3, node 8.10, node 4.3.2, and some global packages"
    curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.8/install.sh | bash
    export NVM_DIR="$HOME/.nvm"
    source "$NVM_DIR/nvm.sh"
    nvm install 4.8.4
    npm install -g nodemon mocha karma-cli karma watchr speed-test
    nvm install 6.10.3
    nvm install 8.10
    nvm install 4.3.2
fi

# Install phantomjs
if [[ ! -d ~/.phantomjs ]]; then
    echo -e "\nInstalling PhantomJS"
    if [[ $(uname) == 'Darwin' ]]; then
        curl -OL https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-2.1.1-macosx.zip
        unzip phantomjs-2.1.1-macosx.zip && rm phantomjs-2.1.1-macosx.zip
        mv phantomjs-2.1.1-macosx ~/.phantomjs
    else
        curl -OL https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-2.1.1-linux-x86_64.tar.bz2
        tar xvf phantomjs-2.1.1-linux-x86_64.tar.bz2 && rm phantomjs-2.1.1-linux-x86_64.tar.bz2
        mv phantomjs-2.1.1-linux-x86_64 ~/.phantomjs
    fi
fi

# Call make-home-venv if ~/venv was deleted (via "clean" arg passed to script)
if [[ -n "$_call_make_home_venv" ]]; then
    echo -e "\nCalling make-home-venv"
    source $DIR/shell/common.d/python.sh
    make-home-venv
fi

# Download git completion for bash
if [[ ! -s ~/.git-completion.bash ]]; then
    echo -e "\nDownloading git-completion.bash"
    curl https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash > ~/.git-completion.bash
fi

# Set python2.7 config for npm (otherwise node-gyp may raise many errors when doing `npm install`)
[[ "$(npm config get python)" = "undefined" ]] && npm config set python /usr/bin/python

# Remove any empty directories
rmdir * 2>/dev/null

# List the symbolic links that exist in $HOME
echo -e "\nListing symbolic links that exist in $HOME"
ls -FgohA $HOME | grep '^l'

# List the symbolic links that exist in $HOME/.config
cd $HOME/.config
echo -e "\nListing symbolic links that exist in $HOME/.config"
ls -FgohA {ranger,awesome}/* 2>/dev/null | grep '^l'
