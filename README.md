
<!--

TODO: describe what the project actually is.
Sprinkle some links to Ilya's stuff necessary for use and development?

-->


# Dependencies

We use [Flutter](https://flutter.dev/) (and, as a consequence, Dart) as a
cross-platform framework for the app.

To develop for Android, you will also need the Android SDK and JDK11.

## Nix

If you prefer to use the [Nix package manager](https://nixos.org/), we provide
a flake with all the dependencies listed. Just run

```
nix develop
```

to enter a shell with all the dependencies available.

# Building and running

This Flutter project is currently configured to be able to run on Linux and Android.

## Linux

On Linux, execute the following command to launch the app in debug mode:

```
flutter run
```

## Android

To develop for Android, you will need to have an emulator or a physical device
connected. Then, execute the following command to launch the app in debug mode:

```
flutter run -d <device>
```

where `<device>` is the name of the device you want to run the app on. You can
get a list of available devices by running

```
flutter devices
```
