# ---------- Stage 1: Build APK ----------
FROM ghcr.io/cirruslabs/flutter:3.22.3 AS builder

WORKDIR /app

# Copy only pubspec first (cache deps)
COPY pubspec.* ./
RUN flutter pub get

# Copy rest of source
COPY . .

# Build APK
RUN flutter build apk --release

# ---------- Stage 2: Minimal output image ----------
FROM alpine:latest

WORKDIR /output

COPY --from=builder /app/build/app/outputs/flutter-apk/app-release.apk .

CMD ["sh"]
