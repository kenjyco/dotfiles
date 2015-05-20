[background]: https://github.com/kenjyco/dotfiles/blob/master/Background.md

If you are completely new to using the command line, checkout the [background][]
document.

## Install / setup
[common.d]: https://github.com/kenjyco/dotfiles/tree/master/shell/common.d

Clone the repo and run the setup script

    % git clone https://github.com/kenjyco/dotfiles && bash ./dotfiles/setup.bash

- the `setup.bash` script will create a backup copy of your existing dotfiles,
  then create symbolic links to the settings in this repository
- plugins for Vim are also downloaded and installed
- the `~/.shell/common` file is sourced when either `~/.bashrc` or `~/.zshrc` is
  sourced
    - this will load aliases and functions from the separate files in
      [~/.shell/common.d/`][common.d].
- The `bin` directory and all sub-directories are automatically added to the
  `PATH` environment variable.

## Non-standard keyboard shortcuts
[vim-tmux-navigator]: https://github.com/christoomey/vim-tmux-navigator

Provided by [vim-tmux-navigator][] to move between tmux panes and vim splits
with the same key binding

- `Ctrl` + `h` => Left
- `Ctrl` + `j` => Down
- `Ctrl` + `k` => Up
- `Ctrl` + `l` => Right
- `Ctrl` + `\` => Previous split
