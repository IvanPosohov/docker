FROM posohof/android

MAINTAINER Ivan Posokhov <posohof@gmail.com>

# Expose SSH, ADB and ADB control
EXPOSE 22
EXPOSE 5554
EXPOSE 5555

ENV DEBIAN_FRONTEND noninteractive

# Update packages
RUN apt-get -qqy update && apt-get -qqy install --no-install-recommends \
    ssh \
    openssh-server \
    socat \
    net-tools \
    qemu-kvm \
    libvirt-bin \
    ubuntu-vm-builder \
    bridge-utils \
    libqt5webkit5 \
    libgconf-2-4 \
    xvfb \
 && rm -rf /var/lib/apt/lists/*

# Installs Android SDK
RUN cd android && \
    yes | tools/bin/sdkmanager --licenses && \
    tools/bin/sdkmanager "emulator" "platforms;android-25" "system-images;android-25;google_apis;x86_64" && \
    tools/bin/sdkmanager --update
RUN rm ${ANDROID_HOME}/tools/emulator && \
    ln -s ${ANDROID_HOME}/emulator/emulator64-x86 ${ANDROID_HOME}/tools/emulator
ENV LD_LIBRARY_PATH=$ANDROID_HOME/emulator/lib64:$ANDROID_HOME/emulator/lib64/qt/lib

# Add entrypoint
ADD entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

# Wait for emulator
HEALTHCHECK --interval=2s --timeout=40s --retries=1 \
    CMD adb wait-for-device shell 'while [[ -z $(getprop sys.boot_completed) ]]; do sleep 1; done'
