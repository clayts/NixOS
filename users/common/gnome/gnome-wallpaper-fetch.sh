mkdir -p ~/.wallpaper
cd ~/.wallpaper
oldFile=$(ls)
filename=$(basename "$oldFile")
filename=${filename%.*}
newFile="$(($filename + 1)).jpg"

echo "Fetching index"
baseURL="https://raw.githubusercontent.com/clayts/Wallpapers/master"
indexPath="index.txt"
index=($(curl -s "$baseURL/$indexPath"))
echo "Index contains ${#index[@]} images"
path="$(printf "%s\n" "${index[@]}" | shuf -n1)"
if [ "$path" = "" ]
then
    echo "Failed"
    exit 1
fi
echo "Fetching $path"
temp=$(mktemp) &&
(
    curl -s "$baseURL/$path" > $temp &&
    mv $temp $newFile && echo "Wrote ~/.wallpaper/$newFile"
) || (
    rm $temp && echo "Failed" && exit 1
)

echo "Executing: gsettings set org.gnome.desktop.background picture-uri '.wallpaper/$newFile'"
gsettings set org.gnome.desktop.background picture-uri ".wallpaper/$newFile"
sleep 2s
echo "Removing ~/.wallpaper/$oldFile"
rm "$oldFile"
