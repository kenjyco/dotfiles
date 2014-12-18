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
