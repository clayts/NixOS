TMP=$(mktemp -d)
echo "copying $1 to $TMP"
cp -R "$1"/* "$TMP"
# TMP=./settings
nix shell nixpkgs#cool-retro-term -c sh -c "XDG_CONFIG_HOME=$TMP XDG_DATA_HOME=$TMP cool-retro-term --fullscreen -e sh -c \"SHLVL=0; unset XDG_CONFIG_HOME; unset XDG_DATA_HOME; cd; exec zsh\""
rm -Rf $TMP