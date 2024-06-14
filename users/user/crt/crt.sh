TMP=$(mktemp -d)
echo "temp:" $TMP
echo "copying $1 to $TMP"
cp -R "$1" "$TMP"/crt
echo nix shell nixpkgs#cool-retro-term -c sh -c "XDG_CONFIG_HOME=$TMP/crt XDG_DATA_HOME=$TMP/crt cool-retro-term --fullscreen -e sh -c \"SHLVL=0; unset XDG_CONFIG_HOME; unset XDG_DATA_HOME; cd; exec zsh\""
nix shell nixpkgs#cool-retro-term -c sh -c "XDG_CONFIG_HOME=$TMP/crt XDG_DATA_HOME=$TMP/crt cool-retro-term --fullscreen -e sh -c \"SHLVL=0; unset XDG_CONFIG_HOME; unset XDG_DATA_HOME; cd; exec zsh\""
rm -Rf $TMP