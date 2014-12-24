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
- This will make things nicer when we edit these (and future files) with `vim`,
  because syntax highlighting and other things will work

    % cd shell/common.d
    % git mv ls ls.sh
    % git mv tree tree.sh
    % git mv vim vim.sh

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
