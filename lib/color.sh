color() {
    if [ $# = 1 ]; then
        echo -ne "\x03$1"
    else
        echo -ne "\x03"
    fi
}

color_random() {
    local r=$RANDOM
    let r=$r%9+3
    color $r
}

color_rainbow() {
    local old_IFS=$IFS
    IFS=$'\n'
    echo -n "$*" | while read -n1 c; do
        color_random
        echo -n `echo $c | tr -d '\n'`
    done
    IFS=$old_IFS
    color
}
