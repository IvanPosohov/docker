#!/bin/bash

# https://developer.android.com/studio/command-line/avdmanager.html
if [[ $SDK_ID == "" ]]; then
    SDK_ID="system-images;android-25;google_apis;x86_64"
    echo "Using default emulator $SDK_ID"
fi

# Run sshd
/usr/sbin/sshd

# Detect ip and forward ADB ports outside to outside interface
ip=$(ifconfig  | grep 'inet addr:'| grep -v '127.0.0.1' | cut -d: -f2 | awk '{ print $1}')
socat tcp-listen:5554,bind=$ip,fork tcp:127.0.0.1:5554 &
socat tcp-listen:5555,bind=$ip,fork tcp:127.0.0.1:5555 &

echo "no" | /opt/android/tools/bin/avdmanager create avd -n test -k "$SDK_ID"
echo "no" | /opt/android/tools/emulator -avd test -noaudio -no-window -gpu off -verbose
