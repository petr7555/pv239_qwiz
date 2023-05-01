# Qwiz
[![Lint and test](https://github.com/petr7555/pv239_qwiz/actions/workflows/lint_and_test.yml/badge.svg)](https://github.com/petr7555/pv239_qwiz/actions/workflows/lint_and_test.yml)
[![Build iOS and web](https://github.com/petr7555/pv239_qwiz/actions/workflows/build_ios_and_web.yml/badge.svg)](https://github.com/petr7555/pv239_qwiz/actions/workflows/build_ios_and_web.yml)
[![Build Android](https://github.com/petr7555/pv239_qwiz/actions/workflows/build_android.yml/badge.svg)](https://github.com/petr7555/pv239_qwiz/actions/workflows/build_android.yml)

A Flutter app created as a school project.

See [doc/specification.md](doc/specification.md) for the specification.

## Supported platforms

- Android
- iOS
- Web
- others are not supported due to the use
  of [`google_sign_in`](https://pub.dev/packages/google_sign_in) package

## Useful commands

- generate files: `flutter pub run build_runner build --delete-conflicting-outputs`
- format code: `dart format --line-length=120 .`
- analyze code: `flutter analyze --fatal-infos`
- run tests: `flutter test`

## Known bugs

- On web, the cursor of `TextFieldBlocBuilder` is not visible until the user starts typing.
