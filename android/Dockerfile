FROM posohof/java

#inspired by Maik Hummel <m@ikhummel.com>
MAINTAINER Ivan Posokhov <posohof@gmail.com>

ENV ANDROID_SDK_URL="https://dl.google.com/android/repository/sdk-tools-linux-3859397.zip" \
    ANDROID_APIS="android-25" \
    ANDROID_BUILD_TOOLS=25.0.3 \
    ANDROID_HOME="/opt/android"

ENV PATH $PATH:$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools:$ANDROID_HOME/build-tools/$ANDROID_BUILD_TOOLS:/usr/share/gradle/bin

WORKDIR /opt

RUN dpkg --add-architecture i386 && \
    apt-get -qq update && \
    apt-get -qq install -y vim wget git curl gradle libncurses5:i386 libstdc++6:i386 zlib1g:i386 && \

    # Installs Android SDK
    mkdir android && cd android && \
    wget -nv -O tools.zip ${ANDROID_SDK_URL} && \
    unzip tools.zip && rm tools.zip && \
    mkdir "licenses" || true && \
    echo -e "\n8933bad161af4178b1185d1a37fbf41ea5269c55" > "licenses/android-sdk-license" && \
    echo -e "\n84831b9409646a918e30573bab4c9c91346d8abd" > "licenses/android-sdk-preview-license" && \
    echo y | tools/bin/sdkmanager "platforms;${ANDROID_APIS}" "build-tools;${ANDROID_BUILD_TOOLS}" "extras;google;m2repository" "extras;google;play_billing" && \
    chmod a+x -R $ANDROID_HOME && \
    chown -R root:root $ANDROID_HOME && \

    # Clean up
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
    apt-get autoremove -y && \
    apt-get clean