npm-list-docs() {
    ls ~/.nvm/versions/node/*/lib/node_modules/npm/doc/*
}

delete-node-modules() {
    find . -name "node_modules" -print0 | xargs -0 rm -rf
}
