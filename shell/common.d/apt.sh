acs() { apt-cache search $1 | grep "^$1" | less -FX; }
acs2() { apt-cache search $1 | grep -iP "\b$1\b" | less -FX; }
