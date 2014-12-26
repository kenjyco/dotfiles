acs() { apt-cache search $1 | grep "^$1" | less -FX; }
