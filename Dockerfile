FROM jenkinsci/blueocean:latest

USER root

ARG SDK_TOOL_URL="https://dl.google.com/android/repository/commandlinetools-linux-7302050_latest.zip"
ENV ANDROID_HOME="/usr/android_sdk"

RUN mkdir -p $ANDROID_HOME && \
    cd $ANDROID_HOME && \
    curl -o sdk.zip $SDK_TOOL_URL && \
    unzip sdk.zip && \
    rm sdk.zip

RUN echo y | $ANDROID_HOME/cmdline-tools/bin/sdkmanager --sdk_root=$ANDROID_HOME "cmdline-tools;latest" && \
    yes | $ANDROID_HOME/cmdline-tools/latest/bin/sdkmanager --licenses && \
    $ANDROID_HOME/cmdline-tools/latest/bin/sdkmanager "platform-tools" && \
    touch ~/.android/repositories.cfg

ENV PATH $ANDROID_HOME/cmdline-tools/latest/bin:$ANDROID_HOME/platform-tools:$PATH