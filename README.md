# busybot #

The Swiss Army Knife of IRC Bots

Written in lowest-common-denominator `sh`, and tested against the busybox `ash`
(hence the name `busybot`).

## Configuration ##

The bot can be configured through environment variables or by setting variables
in `etc/config.sh` which is sourced at startup; the default configuration is:

    SERVER=localhost
    PORT=6667
    NICK=sh
    IRC_USER='sh localhost localhost :sh'

## Commands ##

Commands are prefixed with a `$` and the first word (presently any group of
non-space characters) after this prefix is used as the command (`$cmd`).

If the file `bin/$cmd` exists and is executable, it is run with the following
arguments:

1. Nickname
2. Channel
3. Rest

Here "rest" includes all text after the command in the source message.

In the event of a non-channel message (e.g. a private message sent only to the
bot) the nickname and channel may be the same; hence, it is always correct to
reply to the channel, not to the nickname.

In order to send a string to the IRC server, it should be appended to `var/out`.

As a convenience, if your command is written in `sh` as well you can source
`lib/cmd.sh` which will assign the positional parameters to `$nick`, `$chan`,
and `$rest` respectively, as well as make the functions `log`, `err`, `out`,
and `privmsg` available.

## Running ##

The bot must be run from the root directory of the "filesystem" for the bot
(typically the same directory as `bot.sh` itself); the root of this repository
will work without any problem.
