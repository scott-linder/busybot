file_sanitize_path() {
    echo "$1" | tr -d ' ./'
}
