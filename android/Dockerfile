FROM adoptopenjdk/openjdk17:alpine
MAINTAINER Ivan Posokhov <posohof@gmail.com>

ENV ANDROID_APIS="android-33"
ENV ANDROID_BUILD_TOOLS=33.0.2
ENV ANDROID_HOME "/opt/sdk"
ENV CMDLINE_VERSION "4.0"
ENV SDK_TOOLS "7302050"
ENV PATH $PATH:${ANDROID_HOME}/cmdline-tools/${CMDLINE_VERSION}/bin:${ANDROID_HOME}/platform-tools:${ANDROID_HOME}/extras/google/instantapps

RUN apk add --no-cache bash git unzip wget && \
    apk add --virtual .rundeps $runDeps && \
    rm -rf /tmp/* && \
    rm -rf /var/cache/apk/* && \
    wget -q https://dl.google.com/android/repository/commandlinetools-linux-${SDK_TOOLS}_latest.zip -O /tmp/tools.zip && \
    mkdir -p ${ANDROID_HOME}/cmdline-tools && \
    unzip -qq /tmp/tools.zip -d ${ANDROID_HOME}/cmdline-tools && \
    mv ${ANDROID_HOME}/cmdline-tools/* ${ANDROID_HOME}/cmdline-tools/${CMDLINE_VERSION} && \
    rm -v /tmp/tools.zip && \
    mkdir -p ~/.android/ && touch ~/.android/repositories.cfg && \
    yes | sdkmanager --licenses && \
    sdkmanager "platforms;${ANDROID_APIS}" "platform-tools" "build-tools;${ANDROID_BUILD_TOOLS}" "extras;google;m2repository" && \
    sdkmanager --update

# Set timezone
ENV TZ=Europe/Moscow
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

WORKDIR /home/android
