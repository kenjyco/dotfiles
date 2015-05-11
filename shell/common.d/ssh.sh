sshlazy() {
    eval $(ssh-agent -s)
    ssh-add
}
