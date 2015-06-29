. lib/std.sh

nick=$1; shift
chan=$1; shift

if [ -n "$opts" ]; then
    O=`getopt -s sh $opts $@ 2>&1`
    if [ $? != 0 ]; then
        privmsg $chan "$O"
        exit 1
    fi
    eval set -- "$O"
fi
