" Use the same Vim configuration for terminal Neovim.
" ~/.vimrc is linked to the OS-appropriate vimrc by setup.bash.
set runtimepath^=~/.vim
set runtimepath+=~/.vim/after
let &packpath = &runtimepath
if filereadable(expand('~/.vimrc'))
    execute 'source ' . fnameescape(expand('~/.vimrc'))
endif
