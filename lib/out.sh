. lib/log.sh

out() {
    log [out] "$*"
    echo "$*" >>var/out
}

privmsg() {
    out "PRIVMSG $1 :$2"
}
