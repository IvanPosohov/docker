FROM posohof/java

#inspired by Maik Hummel <m@ikhummel.com>
MAINTAINER Ivan Posokhov <posohof@gmail.com>

ENV ANDROID_SDK_URL="https://dl.google.com/android/repository/sdk-tools-linux-4333796.zip" \
    ANDROID_APIS="android-28" \
    ANDROID_BUILD_TOOLS=28.0.3 \
    ANDROID_HOME="/opt/android"

ENV PATH $PATH:$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools:$ANDROID_HOME/build-tools/$ANDROID_BUILD_TOOLS:/usr/share/gradle/bin

WORKDIR /opt

RUN dpkg --add-architecture i386 && \
    apt-get -qq update && \
    apt-get -qq install -y zip vim wget git curl gradle libncurses5:i386 libstdc++6:i386 zlib1g:i386

# Installs Android SDK
RUN mkdir android && cd android && \
    wget -nv -O tools.zip ${ANDROID_SDK_URL} && \
    unzip tools.zip && rm tools.zip && \
    mkdir ~/.android && \
    echo '### User Sources for Android SDK Manager' > ~/.android/repositories.cfg && \
    yes | tools/bin/sdkmanager --licenses && \
    tools/bin/sdkmanager "platforms;${ANDROID_APIS}" "platform-tools" "build-tools;${ANDROID_BUILD_TOOLS}" "extras;google;m2repository" && \
    tools/bin/sdkmanager --update && \
    chmod a+x -R $ANDROID_HOME && \
    chown -R root:root $ANDROID_HOME

# Clean up
RUN rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
    apt-get autoremove -y && \
    apt-get clean

# Set timezone
ENV TZ=Europe/Moscow
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Set the locale
RUN locale-gen en_US.UTF-8  
ENV LANG en_US.UTF-8  
ENV LANGUAGE en_US:en  
ENV LC_ALL en_US.UTF-8

ENV DOCKER_CI true
