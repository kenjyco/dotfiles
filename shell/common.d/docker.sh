docker-login() {
    if [[ -z "$DOCKER_USER" || -z "$DOCKER_PASSWORD" ]]; then
        echo "Please set DOCKER_USER and DOCKER_PASSWORD"
        return 1
    fi
    docker login -u $DOCKER_USER -p $DOCKER_PASSWORD
}

docker-get-auth-token() {
    echo "$DOCKER_USER:$DOCKER_PASSWORD" | /usr/bin/base64
}

docker-delete-all-images() {
    docker rmi $(docker images -q | sort -u) -f
    echo
    docker images
}

docker-delete-untagged-images() {
    docker rmi $(docker images | grep "<none>" | awk '{print $3}') -f
    echo
    docker images
}

docker-delete-unused-images() {
    docker image prune -af
    echo
    docker images
}

docker-stop-all-containers() {
    docker stop $(docker ps -qa | sort -u)
    echo
    docker ps -a
}

docker-delete-all-containers() {
    docker stop $(docker ps -qa | sort -u)
    docker rm $(docker ps -qa | sort -u)
    echo
    docker ps -a
}

docker-show-untagged-images() {
    docker images | egrep '(<none>|REPOSITORY)'
}

docker-show-all-images() {
    docker images
}

docker-show-all-containers() {
    docker ps -a
}

docker-show-all-images-and-containers() {
    docker images
    echo
    docker ps -a
}

docker-show-all-containers-and-images() {
    docker ps -a
    echo
    docker images
}

docker-top() {
    docker stats --all
}
