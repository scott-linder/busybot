file_sanitize_path() {
    echo "$1" | tr -d ' ./'
}

file_chan_dir() {
    local chan=`file_sanitize_path "$1"`
    echo var/chan/$chan
}

file_chan_file() {
    local chan="$1"
    local file=`file_sanitize_path "$2"`
    local dir=`file_chan_dir "$chan"`
    mkdir -p $dir
    echo $dir/$file
}
