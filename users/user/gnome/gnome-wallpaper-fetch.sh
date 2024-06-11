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
mkdir -p ~/.wallpaper
cd ~/.wallpaper
oldFile=$(ls)
if [ "$oldFile" = "" ]
then
    oldFile="0.jpg"
fi
filename=$(basename "$oldFile")
filename=${filename%.*}
newFile="$(($filename + 1)).jpg"
if [ "$newFile" = "" ]
then
    echo "Error"
    exit 1
fi
temp=$(mktemp) &&
(
    curl -s "$baseURL/$path" > $temp &&
    mv $temp $newFile && echo "Wrote ~/.wallpaper/$newFile"
) || (
    rm $temp && echo "Failed" && exit 1
)

echo "Executing: gsettings set org.gnome.desktop.background picture-uri '.wallpaper/$newFile'"
gsettings set org.gnome.desktop.background picture-uri ".wallpaper/$newFile"
if [ ! "$oldFile" = "0.jpg" ]
then
    sleep 2s
    echo "Removing ~/.wallpaper/$oldFile"
    rm "$oldFile"
fi
