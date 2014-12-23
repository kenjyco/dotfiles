alias duh="du -sch $_all_files_glob | sort -h | less -FX"

dugigs() {
    du -sh $_all_files_glob | grep -P '\d+\.?\d+?G' | sort -n | less -FX
}

dumegs() {
    du -sh $_all_files_glob | grep -P '\d+\.?\d+?M' | sort -n | less -FX
}
