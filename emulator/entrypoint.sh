#!/bin/bash

# Run sshd
/usr/sbin/sshd

# https://developer.android.com/studio/command-line/avdmanager.html
echo "no" | /opt/android/tools/bin/avdmanager create avd -n test -k "system-images;android-29;google_apis;x86_64"
echo "no" | /opt/android/tools/emulator -avd test -noaudio -no-window -gpu off -verbose