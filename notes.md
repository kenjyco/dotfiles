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
