alias duh="du -sch $_all_files_glob | sort -h | less -FX"

dugigs() {
    eval "du -sh $_all_files_glob" | grep -e '\d+\.?\d+?G' | sort -n | less -FX
}

dumegs() {
    eval "du -sh $_all_files_glob" | grep -e '\d+\.?\d+?M' | sort -n | less -FX
}
