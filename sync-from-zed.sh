#!/bin/bash
# Sync from ~/.config/zed/ to this repo (exact 1:1 copy)

RED='\033[38;2;255;0;127m'
BLUE='\033[38;5;81m'
WHITE='\033[0m'

REPO_DIR="$(cd "$(dirname "$0")" && pwd)"
ZED_DIR="$HOME/.config/zed"

if [ ! -d "$ZED_DIR" ]; then
    echo "Error: $ZED_DIR does not exist"
    exit 1
fi

echo -e "${RED}Warning:${WHITE}"
echo -e "${WHITE}  This will overwrite ${BLUE}keymap.json${WHITE}, ${BLUE}settings.json${WHITE}, and ${BLUE}themes/${WHITE} in the repo"
echo -e "  with the versions from ${BLUE}$ZED_DIR${WHITE}."
echo -e "  Any repo themes not present in Zed will be deleted.${WHITE}"
read -r -p "Continue? [y/N] " response
[[ "$response" =~ ^[Yy]$ ]] || exit 0

rsync -a --delete "$ZED_DIR/themes/" "$REPO_DIR/themes/"
rsync -a "$ZED_DIR/keymap.json" "$REPO_DIR/keymap.json"
rsync -a "$ZED_DIR/settings.json" "$REPO_DIR/settings.json"

echo "Synced from Zed to repo"
