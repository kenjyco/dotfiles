circleci-local-test() {
    JOB="$1"
    [[ -z "$JOB" ]] && JOB=test
    circleci config validate && time circleci local execute --job $JOB
}
