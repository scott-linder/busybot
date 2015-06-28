log() {
    echo `date -Iseconds` "$*" >&2
}

err() {
    log [err] "$*"
    exit 1
}
