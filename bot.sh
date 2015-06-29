#!/bin/sh

. etc/config.sh
SERVER=${SERVER:-localhost}
PORT=${PORT:-6667}
NICK=${NICK:-sh}
IRC_USER=${IRC_USER:-'sh localhost localhost :sh'}

. lib/std.sh

mkdir -p var
rm -f var/in && mkfifo var/in || err failed to make in fifo
rm -f var/out && mkfifo var/out || err failed to make out fifo

tail -f var/out | nc $SERVER $PORT >var/in &

out "NICK $NICK"
out "USER $IRC_USER"

[ -f var/chans ] &&
    for chan in `cat var/chans`; do
        out "JOIN $chan"
    done

cat var/in | while read -r input; do
    log [in] $input
    input=`echo $input | tr -d '\r\n'`
    if echo "$input" | grep -q PING; then
        out `echo $input | sed 's/PING/PONG/'`
    elif echo "$input" | grep -q PRIVMSG; then
        nick=`echo $input | sed -nE 's/^:([^ ]+)!.*$/\1/p'`
        chan=`echo $input | sed -nE 's/^[^ ]+ [^ ]+ ([^ ]+).*$/\1/p'`
        if [ $chan = $NICK ]; then
            chan=$nick
        fi
        cmd=`echo $input | sed -nE 's/^[^ ]+ [^ ]+ [^ ]+ :?\\$([^ ]+).*$/\1/p'`
        if [ -n "$cmd" ]; then
            rest=`echo $input | sed -nE 's/^[^ ]+ [^ ]+ [^ ]+ :?\\$[^ ]+ (.*)/\1/p'`
            if [ -f bin/$cmd -a -x bin/$cmd ]; then
                old_IFS=$IFS
                # grep breaks each argument onto its own line
                IFS=$'\n'
                # grep applies quoting rules, then sed cleans up quoted
                # arguments, replacing escapes and stripping quotes
                bin/$cmd $nick $chan `echo "$rest" |
                    egrep -o '"([^"]|\\\\")*"|\S+' |
                    sed -E -e 's/^"(.*)"$/\1/' -e 's/\\\\"/"/g'`
                IFS=$old_IFS
            fi
        fi
    fi
done
