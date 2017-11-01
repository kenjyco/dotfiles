load-sample-mongodb-data() {
    # https://docs.mongodb.com/getting-started/shell/import-data/
    curl https://raw.githubusercontent.com/mongodb/docs-assets/primer-dataset/primer-dataset.json >/tmp/primer-dataset.json || return 1
    mongoimport --db test --collection restaurants --drop --file /tmp/primer-dataset.json
}
