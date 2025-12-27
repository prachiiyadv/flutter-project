FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

# Install dependencies
RUN apt update && apt install -y \
    curl git unzip xz-utils zip \
    openjdk-17-jdk wget \
    && apt clean

# Flutter
RUN git clone https://github.com/flutter/flutter.git /opt/flutter
ENV PATH="/opt/flutter/bin:/opt/flutter/bin/cache/dart-sdk/bin:${PATH}"

# Android SDK
ENV ANDROID_HOME=/opt/android-sdk
RUN mkdir -p $ANDROID_HOME/cmdline-tools

RUN wget https://dl.google.com/android/repository/commandlinetools-linux-11076708_latest.zip \
    && unzip commandlinetools-linux-11076708_latest.zip \
    && mv cmdline-tools $ANDROID_HOME/cmdline-tools/latest

ENV PATH="$ANDROID_HOME/cmdline-tools/latest/bin:$ANDROID_HOME/platform-tools:$PATH"

RUN yes | sdkmanager --licenses
RUN sdkmanager "platform-tools" "platforms;android-36" "build-tools;28.0.3"

WORKDIR /app
COPY . .

RUN flutter pub get
RUN flutter build apk --release
