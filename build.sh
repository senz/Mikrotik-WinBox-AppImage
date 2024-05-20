#!/bin/sh
chmod +x AppDir/AppRun

echo "Download wine..."
WINE_URL="https://github.com/mmtrt/WINE_AppImage/releases/download/continuous-stable/wine-stable_9.0-x86_64.AppImage"
# LATEST_WINE=$(curl -L "https://api.github.com/repos/mmtrt/WINE_AppImage/releases/latest" | jq -r .assets[0].browser_download_url)
curl -L $WINE_URL -o AppDir/wine.AppImage
chmod +x AppDir/wine.AppImage

if ! command -v appimagetool.AppImage >/dev/null 2>&1
then
    echo "Download AppImage tool..."
    LATEST_TOOL=$(curl -L "https://api.github.com/repos/AppImage/AppImageKit/releases/latest" | jq -r '.assets[] | select(.name | test("appimagetool-x86_64.AppImage$")) | .browser_download_url')
    curl -L $LATEST_TOOL -o appimagetool.AppImage
    chmod +x appimagetool.AppImage
fi

echo "Download winbox..."
curl -L https://mt.lv/winbox64 -o AppDir/winbox64.exe

echo "Build AppImage..."
if command -v appimagetool.AppImage >/dev/null 2>&1
then ARCH=x86_64 appimagetool.AppImage -v AppDir
else
    ARCH=x86_64 ./appimagetool.AppImage --appimage-extract-and-run -v AppDir
    rm ./appimagetool.AppImage
fi
