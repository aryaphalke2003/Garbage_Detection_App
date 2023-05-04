# ecotags

A new Flutter application.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.



# Steps to run(Windows):

# Get the Flutter SDK
->Download and install the latest release of  Flutter SDK from [https://docs.flutter.dev/get-started/install/windows]

->Extract the zip file and place the contained flutter in the desired installation location for the Flutter SDK.

# Update your path
-> Go to Edit environment variables for your account.
->Edit environment variables.In the user variables under the entry called Path append the full path to flutter\bin .


->Run the command 'flutter doctor' to see if there are any platform dependencies you need to complete the setup.

# Install Android Studio
->Download and install Android Studio from [https://developer.android.com/studio]

->Run flutter doctor to confirm that Flutter has located your installation of Android Studio. If Flutter cannot locate it, run 'flutter config --android-studio-dir=<directory>' to set the directory that Android Studio is installed to.



# Set up your Android device
->Enable Developer options and USB debugging on your device.
->Using a USB cable, plug your phone into your computer.If prompted on your device, authorize your computer to access your device.
->In the terminal, run the flutter devices command to verify that Flutter recognizes your connected Android device.

# Agree to Android Licenses
->Make sure that you have a version of Java 11 installed and that your JAVA_HOME environment variable is set to the JDK’s folder.
->Agree to the licenses of the Android SDK platform using command 'flutter doctor --android-licenses'.


# Run flutter App
->Open your Flutter project in IntelliJ IDEA: Open IntelliJ IDEA and select "Open" from the "File" menu. Navigate to our project directory and select it.
->Install the Flutter and Dart plugins:Go to "Settings" (or "Preferences" on a Mac), selecting "Plugins", and searching for "Flutter" and "Dart".
->Set up a Flutter run configuration: To run your Flutter app, set up a run configuration. Open the "Run" menu and select "Edit Configurations". Click the "+" button to add a new configuration, select "Flutter" from the list of templates, and give your configuration a name.
->Choose your target device: In the run configuration window, select the target device you want to use to run your app.Choose from a physical device connected to your computer(preferably a mobile).
->Run the app: Once you've set up your run configuration and chosen your target device, click the "Run" button to launch the app. IntelliJ IDEA will build the app and deploy it to your target device.

That's it! You should now be able to run your Flutter app in IntelliJ IDEA. 
