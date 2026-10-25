#!/bin/bash
# Build a static copy of https://github.com/wofsauge/IsaacDocs into ./site
#
# Usage: ./build.sh [git-ref]   (defaults to the pinned commit below; pass "main" for latest)

set -e # Exit on any errors

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
REF="${1:-e05b1fd90e33608a7a7a8dcb70a89cef908cc41a}"
WORK="$DIR/.build"
SRC="$WORK/IsaacDocs"

mkdir -p "$WORK"

# Full history is needed for the "last updated" dates on each page
if [ ! -d "$SRC/.git" ]; then
    git clone https://github.com/wofsauge/IsaacDocs.git "$SRC"
fi
git -C "$SRC" fetch origin
git -C "$SRC" checkout --force "$REF"
git -C "$SRC" clean -fdx docs

if [ ! -d "$WORK/venv" ]; then
    python3 -m venv "$WORK/venv"
fi
"$WORK/venv/bin/pip" install -q -r "$DIR/requirements.txt"

mkdir -p "$SRC/docs/js/vendor"
cp "$DIR"/vendor/*.js "$SRC/docs/js/vendor/"
cp "$DIR/mkdocs.static.yml" "$SRC/mkdocs.static.yml"

# Snippet includes are resolved relative to the working directory
cd "$SRC"
rm -rf "$DIR/site"
"$WORK/venv/bin/mkdocs" build -f mkdocs.static.yml -d "$DIR/site"
touch "$DIR/site/.nojekyll"

echo "Static site written to $DIR/site (built from IsaacDocs @ $(git rev-parse --short HEAD))"
