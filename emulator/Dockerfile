FROM posohof/android

MAINTAINER Ivan Posokhov <posohof@gmail.com>

EXPOSE 22

ENV DEBIAN_FRONTEND noninteractive

# Install packages
RUN apt-get -qqy update && apt-get -qqy install --no-install-recommends \
    qemu-kvm \
    xvfb \
    ssh \
    openssh-server \
 && rm -rf /var/lib/apt/lists/*

# Installs Android SDK
RUN cd android && \
    yes | tools/bin/sdkmanager --licenses && \
    tools/bin/sdkmanager "emulator" "system-images;android-28;google_apis;x86_64" && \
    tools/bin/sdkmanager --update

# Add entrypoint
ADD entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

# Wait for emulator
HEALTHCHECK --interval=2s --timeout=40s --retries=1 \
    CMD adb wait-for-device shell 'while [[ -z $(getprop sys.boot_completed) ]]; do sleep 1; done'
