Notes
=====
Create a `dotfiles` directory and copy settings files there

    % cd
    % mkdir dotfiles
    % cp -av .bash_profile .bashrc .gitconfig .inputrc .tmux.conf .vimrc .Xdefaults .zshrc dotfiles/
    ‘.bash_profile’ -> ‘dotfiles/.bash_profile’
    ‘.bashrc’ -> ‘dotfiles/.bashrc’
    ‘.gitconfig’ -> ‘dotfiles/.gitconfig’
    ‘.inputrc’ -> ‘dotfiles/.inputrc’
    ‘.tmux.conf’ -> ‘dotfiles/.tmux.conf’
    ‘.vimrc’ -> ‘dotfiles/.vimrc’
    ‘.Xdefaults’ -> ‘dotfiles/.Xdefaults’
    ‘.zshrc’ -> ‘dotfiles/.zshrc’

Move to the `dotfiles` directory and turn it into a local git repository

    % cd dotfiles
    % git init

Stage the files in the `dotfiles` repository and commit them

    % git add .
    % git commit

Create a dotfiles repository on [github](https://github.com/new) through the web
browser, then push the local dotfiles repository to it

    % git remote add origin git@github.com:kenjyco/dotfiles.git
    % git push -u origin master

> This assumes a user account has already been created on github, and that the
> [SSH keys](https://github.com/settings/ssh) have been setup.

Add the `setup.bash` script to this repository
- It will create a backup of any existing dotfiles in $HOME (that are not links)
- It will create symbolic links to the individual dotfiles in the repo

Add the name of the created backup directory to the `.gitignore` file

Create a `shell` directory to hold bash and zsh settings

    % mkdir -pv shell/bash shell/zsh
    mkdir: created directory ‘shell’
    mkdir: created directory ‘shell/bash’
    mkdir: created directory ‘shell/zsh’

Move the `.bash_profile`, `.bashrc`, and `.zshrc` files to their appropriate
sub-directories in `shell`

    % git mv .bashrc shell/bash/bashrc
    % git mv .bash_profile shell/bash/bash_profile
    % git mv .zshrc shell/zsh/zshrc

Update the `setup.bash` script to use the new locations for the shell settings
when creating symolic links

Create a `shell/common.d` directory to contain functions and aliases (grouped by
filename) that should be sourced by `bashrc` or `zshrc`

    % mkdir -pv shell/common.d
    mkdir: created directory ‘shell/common.d’

Add the `shell/common` script to this repository
- It will source any files in `shell/common.d`

Add the `ls`, `tree`, and `vim` files to `shell/common.d/`
- Each file sets some basic aliases

Update the `setup.bash` script to create a symbolic link to the `shell`
directory in $HOME (as `$HOME/.shell`)

Update the `bashrc` and `zshrc` files to source `$HOME/.shell/common`

Rename the existing files in `shell/common.d` to end in a `.sh` extension

    % cd shell/common.d
    % git mv ls ls.sh
    % git mv tree tree.sh
    % git mv vim vim.sh

- This will make things nicer when we edit these (and future files) with `vim`,
  because syntax highlighting and other things will work

Add a `Tmux` function that makes it easy to attach to named sessions
in `shell/common.d/tmux.sh`

Add a `fontsize` function that allows resetting the terminal font size on the
fly in `shell/common.d/fontsize.sh`

Add `feh*` aliases for viewing images in `shell/common.d/feh.sh`

Set a variable called `_all_files_glob` in `shell/common` to be the filename
glob that represents all hidden and non-hidden files/directories in the current
directory
- This glob pattern is different between bash and zsh, so it is set in
  `shell/common`, allowing the pattern to be used in functions and aliases

In `shell/zsh/zshrc`, set the `null_glob` option, which will simply remove a
pattern with no matches from the command-line argument list instead of reporting
an error

Add several new functions and aliases to several files in the `shell/common.d`
directory

Update the `setup.bash` script to save the full path of the dotfiles repo to
`~/.dotfiles_path`.
- Add a `dotfiles` function and a `common` function that will cd to either the
  `dotfiles/` directory or `dotfiles/shell/common.d` directory and show some
  information

For aliases that reference themselves (`ls` and `feh`), make the other aliases
that also call the program name not repeat options/flags set in the base alias.

Add dotfiles for `ranger`

    % mkdir ranger

Update the `setup.bash` script to handle the `ranger` dotfile, which needs to be
in `~/.config/ranger/rc.conf`

Add the `autoenv` and `youtube-dl` repos as submodules in `shell/bash/extra`

    % git submodule add https://github.com/kennethreitz/autoenv shell/bash/extra/autoenv
    % git submodule add https://github.com/rg3/youtube-dl shell/bash/extra/youtube-dl

Update the `shell/bash/bashrc` file to enable [autoenv][] to automatically
execute a directory's `.env` file and to make the [youtube-dl][] command callable

[autoenv]: https://github.com/kennethreitz/autoenv
[youtube-dl]: https://github.com/rg3/youtube-dl

In `shell/common.d/tree.sh`, change `t` from an alias to a function
- The function accpets an optional directory name, which gets passed to `tree`
  before piping the output to `less -FX`
- An `_ignore_tree_string` variable was added so that certain tree aliases can
  ignore directory patterns (like the `thome` alias)

Update the `dotfiles` and `common`  functions to only change to the directory
- Each function also has a variant that will output extra information, like
  the new current directory and the directory tree or listing

Add aliases for `..` `...` and `....` to `shell/common`

Add new files `lsblk.sh` and `watch.sh` to `shell/common.d`

Add `vundle` repo as submodule in `vim/bundle/Vundle.vim`

    % git submodule add https://github.com/gmarik/Vundle.vim vim/bundle/Vundle.vim

Move `.vimrc` to `vim/vimrc`

    % git mv .vimrc vim/vimrc

Update `vim/vimrc` with stuff to enable Vundle, but don't install any plugins

Update the `setup.bash` script to use the new path to `vim/vimrc` as a symbolic
link for `~/.vimrc` and create a symbolic link for `~/.vim`

Also, have `setup.bash` create the `~/.plugin_install_dir/vundle` directory
(which will contain the downloads for plugins added to Vundle) and automatically
install Vundle plugins

Create a `tmux` directory

    % mkdir tmux

Move `.tmux.conf` to `tmux/tmux.conf`

    % git mv .tmux.conf tmux/tmux.conf

Update the `setup.bash` script to use the new path to `tmux/tmux.conf` as
a symbolic link for `~/.tmux.conf`

Add [vim-tmux-navigator][] style navigation that uses `ctrl-h`, `ctrl-j`,
`ctrl-k`, `ctrl-l` to move between tmux panes and vim splits (without using the
`^b` prefix for tmux or the `^w` prefix for vim)
- Update the `vim/vimrc` file to add the `vim-tmux-navigator` plugin to vundle
- Update the keybindings in the `tmux/tmux.conf` file

[vim-tmux-navigator]: https://github.com/christoomey/vim-tmux-navigator

Move `.Xdefaults`, `.inputrc`, and `.gitconfig` to their own sub-directories and
remove the leading `.` from the filenames

    % mkdir x input git
    % git mv .Xdefaults x/Xdefaults
    % git mv .inputrc input/inputrc
    % git mv .gitconfig git/gitconfig

Update the `setup.bash` script to use the new paths for symbolic links

Update this `notes.md` file with minor cosmetic changes (to parts of the file
that were committed in the past)

Add the `conqueterm` and `fugitive` plugins to Vundle

Add the `acs` function to `shell/common.d/apt.sh` as a light wrapper around
`apt-cache search` and add the `partitions2` alias to `shell/common.d/sudo.sh`

Add `x/awesome` directory and copy default awesome settings

    % mkdir -p x/awesome
    % cp -a /etc/xdg/awesome/rc.lua x/awesome

Update the `setup.bash` script to add symbolic links for
`~/.config/awesome/rc.lua`

Add a wrapper function to the find command called `_find` in `shell/common`
- Placing it here allows it to be used in `shell/common.d` scripts

Add `shell/common.d/grip.sh` which provides the `grip-many` function
- This function makes use of `_find` and creates a markdown file containing
  links to other markdown files based on depth and time filters
