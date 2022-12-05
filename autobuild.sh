if ! command -v zip &> /dev/null
then
    echo "'zip' could not be found"
    echo "Please install zip"
    exit
fi

if [ ! -f setup.sh ]; then
    echo "setup.sh not found, are you sure that you are in the right directory?"
    exit
fi

echo ">> Creating zip file"
echo ""
zip -r PixelLauncherExtended.zip . -x .git/\*

echo ""
echo ">> Done! You can find the zip file in the current directory - $(pwd)/PixelLauncherExtended.zip"