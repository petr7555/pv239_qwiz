# Qwiz

A Flutter app created as a school project.

See [doc/specification.md](doc/specification.md) for the specification.

## Supported platforms

- Android
- iOS
- Web
- others are not supported due to the use
  of [`google_sign_in`](https://pub.dev/packages/google_sign_in) package

## Useful commands

- generate JSON serialization
  files: `flutter pub run build_runner build --delete-conflicting-outputs`
- format code: `dart format --line-length=120 .`
- analyze code: `dart analyze --fatal-infos`
- run tests: `flutter test`

## Known bugs

- On web, the cursor of `TextFieldBlocBuilder` is not visible until the user starts typing.
