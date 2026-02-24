#!/bin/bash
# Sync from this repo to ~/.config/zed/ (merge themes, don't delete extras)

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
echo -e "${WHITE}  This will overwrite ${BLUE}keymap.json${WHITE}, ${BLUE}settings.json${WHITE}, and matching ${BLUE}themes${WHITE} in"
echo -e "  ${BLUE}$ZED_DIR${WHITE} with the versions from the repo."
echo -e "  Existing Zed themes not in the repo will be kept.${WHITE}"
read -r -p "Continue? [y/N] " response
[[ "$response" =~ ^[Yy]$ ]] || exit 0

mkdir -p "$ZED_DIR/themes"
rsync -a "$REPO_DIR/themes/" "$ZED_DIR/themes/"
rsync -a "$REPO_DIR/keymap.json" "$ZED_DIR/keymap.json"
rsync -a "$REPO_DIR/settings.json" "$ZED_DIR/settings.json"

echo "Synced from repo to Zed"
