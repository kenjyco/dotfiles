## Background

Dotfiles are hidden files in your `HOME` directory that are used to store
preferences, settings, and startup commands for various programs. Not all
programs use dotfiles, but the ones that do expect the files to reside in a
specific location.

> This is why symbolic links are created by the `setup.bash` script.

#### Bash / Zsh
[bash]: http://tldp.org/HOWTO/Bash-Prog-Intro-HOWTO.html
[zsh]: http://zsh.sourceforge.net/Doc/Release/zsh.html

The shell prompt is where you type commands to the system. There are several
different shells available, but we will primarily be using [bash][] and
[zsh][].

> When you type a command at the prompt, you must press the `Enter` key to
> execute it.

Shell commands can also be read from a file (known as a shell script). When you
notice yourself typing the same sequence of commands over and over, **add
the commands to a file, then run the file** to accomplish the task.

> If you make the shell script executable (with `chmod +x`) and include an
> **interpreter directive** in the first line (`#!/usr/bin/env bash`), then you
> can call the shell script like any other command.

When bash or zsh are used as your **interactive login shell**, the personal
initialization file is loaded (from `~/.bashrc` or `~/.zshrc`) as soon as an
interactive session starts (which contains aliases and functions among other
things).

> See: http://unix.stackexchange.com/a/30964 for in-depth answer about when to
> use shell scripts and when to use functions and aliases.

#### Vim
[vim]: http://www.vim.org/about.php

When you learned how to touch type, the first lesson was probably about the
"home row" keys. Your left fingers rest on `a`, `s`, `d`, `f` and your right
fingers rest on `j`, `k`, `l`, `:/;`.

> If you have not learned how to touch type, run the `gtypist` typing tutor
> program and go through the lessons in your free time.

With the text editor [vim][],  there is an "insert mode" (where the keys you type
become characters in your file) and a "command mode" (where the keys you type
are commands).

Vim takes advantage of the fact that your fingers rest on the home row by
letting you use the `h`, `j`, `k`, `l` keys for moving around in a file (when in
command mode).

- `h` move cursor left
- `j` move cursor down
- `k` move cursor up
- `l` move cursor right

This is a very efficient way to move around. Many people that use vim regularly
will set "vim key bindings" in other programs (whenever it is an option),
including the shell prompt of the terminal.

> Often, you will need to modify your previous command. Luckily, the command
> history is saved and can be navigated/edited with our vim bindings. When you
> press the `Esc` key (top-left area of keyboard), you switch to the vim command
> mode.

#### Keyboard shortcuts 

We will be making heavy use of "keyboard shortcuts", for efficiency and
convenience.

Most of the keyboard shortcuts involve pressing two keys at once, but some
involve pressing three keys at once.

Here are some actual keyboard combo sequences:

- `Ctrl` +
    - `Ctrl` + `c`
    - `Ctrl` + `d`
    - `Ctrl` + `b`
    - `Ctrl` + `w`
    - `Ctrl` + `u`
    - `Ctrl` + `Alt` +
        - `Ctrl` + `Alt` + `F2`
        - `Ctrl` + `Alt` + `F7`
        - `Ctrl` + `Alt` + `Del`
- `Alt` + `d`
- `Super` +
    - `Super` + `1`
    - `Super` + `Tab`
    - `Super` + `k`
    - `Super` + `r`
    - `Super` + `Enter`
    - `Super` + `m`
    - `Super` + `n`
    - `Super` + `Shift` + `2`
- `Fn` +
    - `Fn` + `F12`
- `Shift` +
    - `Shift` + `Insert`

> Note: `Super` is the key between`Ctrl` and `Alt`. Its also referred to in some
> contexts as the `Mod4` key.

#### The Window Manager

For this computer system, we will be using a keyboard-friendly tiling window
manager called [awesome](https://awesome.naquadah.org/wiki/My_first_awesome).

The expectation is that you will be typing commands at the shell prompt in your
terminal window to do most things. This includes launching GUI programs like
your web browser (`chromium-browser` or `firefox`), photo editor `gimp`, audio
editor `audacity`, and other things.
