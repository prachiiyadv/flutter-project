FROM ghcr.io/cirruslabs/flutter:3.38.5 AS builder

WORKDIR /app

# Cache dependencies
COPY pubspec.* ./
RUN flutter pub get

# Copy rest of source
COPY . .

# Build APK
RUN flutter build apk --release
