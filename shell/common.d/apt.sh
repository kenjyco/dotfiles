[[ $(uname) == 'Darwin' ]] && return

acs() { apt-cache search $1 | grep -i "^$1" | less -FX; }
acs2() { apt-cache search $1 | grep -i "\b$1\b" | less -FX; }
alias upgradable="apt list --upgradable"
