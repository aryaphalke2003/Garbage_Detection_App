# ecotags

A new Flutter application that helps users track and reduce their carbon footprint!


## Getting Started

This project is a starting point for a Flutter application. Follow these steps to get started:


### Get the Flutter SDK

1. Download and install the latest release of the Flutter SDK from the official [Flutter website](https://flutter.dev/docs/get-started/install).

2. Extract the zip file and place the contained `flutter` folder in the desired installation location.


### Update your path

1. Go to Edit environment variables for your account.

2. Edit environment variables. In the user variables under the entry called Path, append the full path to `flutter\bin`.

3. Run the command `flutter doctor` to see if there are any platform dependencies you need to complete the setup.


### Install Android Studio

1. Download and install Android Studio from the official [Android Studio website](https://developer.android.com/studio).

2. Run `flutter doctor` to confirm that Flutter has located your installation of Android Studio. If Flutter cannot locate it, run `flutter config --android-studio-dir=<directory>` to set the directory that Android Studio is installed to.


### Set up your Android device

1. Enable Developer options and USB debugging on your device.

2. Plug your Android device into your computer using a USB cable. If prompted on your device, authorize your computer to access your device.

3. In your terminal, run the `flutter devices` command to verify that Flutter recognizes your connected Android device.


### Agree to Android Licenses

1. Make sure that you have a version of Java 11 installed and that your `JAVA_HOME` environment variable is set to the JDK's folder.

2. Agree to the licenses of the Android SDK platform using the command `flutter doctor --android-licenses`.


### Run the Flutter app

1. Open your Flutter project in IntelliJ IDEA: Open IntelliJ IDEA and select "Open" from the "File" menu. Navigate to the project directory and select it.

2. Install the Flutter and Dart plugins. Go to "Settings" (or "Preferences" on a Mac), select "Plugins", and search for "Flutter" and "Dart".

3. Set up a Flutter run configuration. To run your Flutter app, set up a run configuration. Open the "Run" menu and select "Edit Configurations". Click the "+" button to add a new configuration, select "Flutter" from the list of templates, and give your configuration a name.

4. Choose your target device. In the run configuration window, select the target device you want to use to run your app. Choose from a physical device connected to your computer(preferably a mobile).

5. Run the app. Once you've set up your run configuration and chosen your target device, click the "Run" button to launch the app. IntelliJ IDEA will build the app and deploy it to your target device.



That's it! You should now be able to run your Flutter app! 


