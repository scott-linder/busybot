file_sanitize_path() {
    echo "$1" | tr -d ' ./'
}

file_chan() {
    local chan=`file_sanitize_path "$1"`
    local file=`file_sanitize_path "$2"`
    mkdir -p var/chan/$chan
    echo var/chan/$chan/$file
}
