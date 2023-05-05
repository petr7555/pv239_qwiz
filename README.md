# Qwiz
[![Lint and test](https://github.com/petr7555/pv239_qwiz/actions/workflows/lint_and_test.yml/badge.svg)](https://github.com/petr7555/pv239_qwiz/actions/workflows/lint_and_test.yml)
[![Build iOS](https://github.com/petr7555/pv239_qwiz/actions/workflows/build_ios.yml/badge.svg)](https://github.com/petr7555/pv239_qwiz/actions/workflows/build_ios.yml)
[![Build Android](https://github.com/petr7555/pv239_qwiz/actions/workflows/build_android.yml/badge.svg)](https://github.com/petr7555/pv239_qwiz/actions/workflows/build_android.yml)
[![Deploy to Firebase Hosting on merge](https://github.com/petr7555/pv239_qwiz/actions/workflows/firebase-hosting-merge.yml/badge.svg)](https://github.com/petr7555/pv239_qwiz/actions/workflows/firebase-hosting-merge.yml)

A quiz game for 2 players created as a school project.
You can try it at [https://pv239-qwiz.web.app/](https://pv239-qwiz.web.app/). 

See [doc/specification.md](doc/specification/specification.md) for the specification.

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
- On web, the profile image sometimes does not load: `Failed to load network image.`.

## Notes

- Icons have been generated using https://icon.kitchen/ from [assets/images/icon-512x512.png](assets/images/icon-512x512.png).
