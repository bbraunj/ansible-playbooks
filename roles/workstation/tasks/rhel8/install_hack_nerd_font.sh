wget "https://github.com/source-foundry/Hack/releases/download/v3.003/Hack-v3.003-ttf.zip"
unzip Hack-v3.003-ttf.zip
mv ttf/* /usr/share/fonts/
fc-cache -f -v

# Cleanup
cd ..
rm -rf ttf
rm -f Hack-v3.003-ttf.zip
