alias duh="du -sch $_all_files_glob | sort -h | less -FX"

dugigs() {
    eval "du -sh $_all_files_glob" | grep '\dG' | sort -n | less -FX
}

dumegs() {
    eval "du -sh $_all_files_glob" | grep '\dM' | sort -n | less -FX
}
