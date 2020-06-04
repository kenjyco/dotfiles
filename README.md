[background]: https://github.com/kenjyco/dotfiles/blob/master/Background.md

If you are completely new to using the command line, checkout the [background][]
document.

## Install / setup

Clone the repo and run the setup script

    % git clone https://github.com/kenjyco/dotfiles && bash ./dotfiles/setup.bash

- the `setup.bash` script will create a backup copy of your existing dotfiles,
  then create symbolic links to the settings in this repository
- plugins for Vim are also downloaded and installed

## Update Vundle plugin (git submodule)

```
% cd dotfiles

% git submodule init && git submodule update

% cd vim/bundle/Vundle.vim

% git checkout master

% git pull

% cd ../../..

% git add vim/bundle/Vundle.vim

% git commit
```

## Non-standard keyboard shortcuts
[vim-tmux-navigator]: https://github.com/christoomey/vim-tmux-navigator

Provided by [vim-tmux-navigator][] to move between tmux panes and vim splits
with the same key binding

- `Ctrl` + `h` => Left
- `Ctrl` + `j` => Down
- `Ctrl` + `k` => Up
- `Ctrl` + `l` => Right
- `Ctrl` + `\` => Previous split

**Note**: When using `:term` or `:vert term` in vim (version 8+) to open a
terminal split the `Ctrl` + `<direction>` shortcuts will not work... you will
need to `Ctrl` + `w` first, then h/j/k/l

## Vim plugin docs

- <https://github.com/christoomey/vim-tmux-navigator#usage>
- <https://github.com/wesQ3/vim-windowswap#howto>
    - Note: default `<leader>` key in vim is `\`
    - Navigate to window you want to move and press `<leader>ww`
    - Navigate to window you want to swap with and press `<leader>ww` again
- <https://github.com/will133/vim-dirdiff#usage>
    - From CLI: `vim -c "DirDiff dir1 dir2"`
- <https://github.com/tpope/vim-fugitive#fugitivevim>
    - This is a `git` wrapper
        - Also see screencast series: <http://vimcasts.org/blog/2011/05/the-fugitive-series/>
    - `:Gstatus` to see git status
        - if you move cursor to an unstaged file and press `-` it will `git add`
          the file
        - if you move cursor to a staged file and press `-` it will `git reset`
          the file
        - can also use `-` in visual mode
            - `<Shift>v`, then `j` or `k` to select lines above/below; then
              press `-` to either stage or unstage selected files
        - if you move cursor to an unstaged file and press `<Shift>p` it will
          `git add -p` the file (to let you select part of the file to stage)
        - if you press `<Enter>` while on a file, it will open it in a split
          below the `Gstatus` window
            - use `:Gdiff` (mentioned below)
        - use `cc` to open `:Gcommit` from the status window (which opens
          a split with commit buffer)
    - `:Gdiff` to compare diff of current window's file
        - use `:close` on the `fugitive://...` window when done
        - Note: You can select lines of text in visual mode (<Shift>v ..) and
          copy to the `fugitive://` window and `:w!` to stage different parts of
          the file!
            - No need to `git add -p`
            - Verify in another terminal with `git diff --cached` (or another
              split using `:Git diff --cached`)
    - `:Gdiff` on a file with merge conflicts will open 3 vertical splits with vimdiff
    - `:Gblame` to open interactive vertical split with `git blame` output
    - `:Gmove <newname>` to `git mv current <newname>`
    - `:Git [args]` to run arbitrary git command
        - i.e. `:Git checkout -b some-branch` and `:Git push -u origin some-branch`
        - use `:close` on the `fugitive://...` window when done
    - `:Gsplit <branch>:%` to vimdiff current file with version on another
      branch (or at another commit)
            - Note: in vim `%` is a shortcut to current file
    - `:Gedit <branch>:path/to/file` to open a file from any branch in a read-only buffer
    - `:Ggrep 'some text' <branch>` to `git grep` a pattern in a particular branch
- <https://github.com/tpope/vim-obsession#obsessionvim>
    - This is to help manage "sessions" (open splits, window positions, etc)
    - `:Obsess` to start recording session file (to `Session.vim` in current directory)
        - can also pass a filename to save as (to keep separate for 4k.vim, etc)
    - `:qa` to quit vim and close all windows
    - Load session with `vim -RS Session.vim` or `:source` it
    - `:Obsess!` to remove the session file
