#!/bin/bash -eux
source "$(dirname $0)/bin/conf"

# [ "$USER" = "root" ] # USER MUST BE ROOT

### CREATE DIRECTORIES ###
mkdir -p "$logdir" "$datadir" "$datadir/counters"
chown www-data:www-data "$logdir" "$datadir" "$datadir/counters"

### INSTALL THIS SYSTEM ###
rsync -av --delete "$(dirname $0)/bin/" "$appdir/"
chown www-data:www-data "$appdir" -R

### EDIT FETCH CGI ###
cd "$appdir"
rnd=$(cat /dev/urandom | tr -cd 0-9a-zA-Z | head -c 32)
[ -e "/home/onishi/rnd" ] && rnd=$(cat /home/onishi/rnd )
mv "fetch" "fetch_$rnd.cgi"

### PULL DATA ###
# rm -rf "${contentsdir:?}"
cd "$wwwdir"
# git clone "https://github.com/$contents_owner/$contents"
chown www-data:www-data "$contentsdir" -R

### RESTORE DATADIR ###
rm -rf "$datadir/posts"
rm -rf "$datadir/pages"

### INITIALIZE ###
touch "$datadir/INIT"
chown www-data:www-data "$datadir/INIT"
$appdir/fetch_$rnd.cgi

echo "call fetch_$rnd.cgi from GitHub"

# NOTE: Docker 環境で不要なコマンドはコメントアウトしている
