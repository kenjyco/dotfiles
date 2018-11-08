circleci-local-test() {
    JOB="$1"
    [[ -z "$JOB" ]] && JOB=test

    AWS_ACCESS_KEY_ID=$(grep aws_access_key_id ~/.aws/credentials 2>/dev/null | egrep -o '\S+$')
    AWS_DEFAULT_REGION=$(grep region ~/.aws/config 2>/dev/null | egrep -o '\S+$')
    AWS_SECRET_ACCESS_KEY=$(grep aws_secret_access_key ~/.aws/credentials 2>/dev/null | egrep -o '\S+$')

    circleci config validate || return 1
    time circleci local execute --job $JOB \
        -e AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID \
        -e AWS_DEFAULT_REGION=$AWS_DEFAULT_REGION \
        -e AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY \
        -e DOCKER_USER=$DOCKER_USER \
        -e DOCKER_PASSWORD=$DOCKER_PASSWORD
}
