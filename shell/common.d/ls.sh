alias ls="ls -Fq"
alias l="ls -gothr"
alias la="ls -gothrA"
alias swps2="ls -1 **/.*.swp"

# Add shortcut for listing files or directories in the current directory
if [[ -n $ZSH_VERSION ]]; then
    alias f="ls -gothr *(.)"
    alias fa="ls -gothrA {.*,*}(.)"
    alias d="ls -gothrd *(/)"
    alias da="ls -gothrAd {.*,*}(/)"
elif [[ -n $BASH_VERSION ]]; then
    alias f="ls -gothr | grep -v '^d'"
    alias fa="ls -gothrA | grep -v '^d'"
    alias d="ls -gothr | grep '^d'"
    alias da="ls -gothrA | grep '^d'"
fi
