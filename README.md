# HisaabMitra

HisaabMitra is a polished Flutter mobile app that recreates a pharmacy/accounting purchase invoice flow using mock local data.

## Run

```bash
flutter pub get
flutter run
```

## Android Emulator

Start the configured Android emulator:

```bash
flutter emulators --launch Pixel_9a
```

Run the app on the active Android emulator:

```bash
flutter run -d emulator-5554
```

flutter run -d ZA222L5CX2


## VS Code Debug

This repo includes `.vscode/launch.json` and `.vscode/tasks.json` for Android debug runs.

Recommended flow:

1. Run the task `Flutter: Launch Pixel_9a Emulator`
2. In VS Code, select the emulator as the current Flutter device
3. Start the launch config `Flutter Android Debug`

## Local Android Fixes

This machine can build and install the app on the emulator, but `flutter doctor -v` still reports two Android SDK issues outside the repo:

- `cmdline-tools` is missing from `/Users/a1234567890/Library/Android/sdk/cmdline-tools`
- Android SDK licenses are not accepted yet

Fix those with Android Studio SDK Manager, then run:

```bash
flutter doctor --android-licenses
flutter doctor -v
```

## Stack

- Flutter stable
- Dart null safety
- Material 3
- Riverpod
- go_router
