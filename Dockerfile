FROM ghcr.io/cirruslabs/flutter:3.38.5

WORKDIR /app

COPY pubspec.yaml pubspec.lock ./
RUN flutter pub get

COPY . .
RUN flutter build apk --release

CMD ["bash"]
