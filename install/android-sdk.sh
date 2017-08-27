cd ~/Downloads
wget "https://dl.google.com/dl/android/studio/ide-zips/2.3.3.0/android-studio-ide-162.4069837-linux.zip"

mkdir -p ~/.sdks/android
unzip ~/android-studio-ide-162.4069837-linux.zip ~/.sdks/android
mv ~/.sdks/android/tools ~/.sdks/android/cli

echo "" >> "~/.bashrc"
echo "# Android" >> "~/.bashrc"
echo "export ANDROID_HOME=$HOME/.sdks/android" >> "~/.bashrc"

sdkmanager "build-tools;25.0.3"
sdkmanager "emulator"
sdkmanager "ndk-bundle"
sdkmanager "platform-tools"
sdkmanager "platforms;android-25"
sdkmanager "tools"

avdmanager create avd -n "NEXUS_5_API_25" -d "Nexus 5" -k "system-images;android-25;google_apis;x86" -g "google_apis"

emulator -avd "NEXUS_5_API_25" -skin 768x1280 -use-system-libs

reset && ionic cordova run android --livereload

for f in ~/.android/avd/*.avd/config.ini; do echo 'hw.keyboard=yes' >> "$f"; done
