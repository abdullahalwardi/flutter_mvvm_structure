# Riverpod structure
A flutter project built on MVVM design pattern, structured with riverpod, shared preferences, retrofit, goRouter.

## Project Setup

Things to do when you setup your project with riverpod structure:

1- After replacing the Manifest Make sure of changing android:label, then change host name for deeplinking from ../android/app/src/main/Android.Manifest.xml for android, and search for (<!-- Deep linking -->),
then change the host name in http and https.
and same for ios from ..ios/Runner/info.plist, and search for flutterbooksample.com, then change the name to your host name.

2- run these commands:
flutter pub run change_app_package_name:main <your new package name>,
flutter pub global run rename --bundleId <your new package name>,
flutter pub global run rename --appname <your new App name>,
in search replace (package:app) with (package:<your new App name>)
to change your app package name and name.

3- change app name from pubspec.yaml and from main.dart.

4- dart pub global activate flutter_gen & flutter pub global activate build_runner & flutter pub run build_runner build.

5- add this permission (<uses-permission android:name="android.permission.INTERNET"/>)

6- dart run custom_lint
# Install custom_lint for all projects
dart pub global activate custom_lint
# run custom_lint's command line in a project
custom_lint

7- update the assetslinks.json file

9- follow the official build and release guide (https://docs.flutter.dev/deployment/android) and then update the key.properties.

10- To get the release certificate fingerprint on MacOs: (keytool -list -v \
-alias <your-key-name> -keystore <path-to-production-keystore>)

11- To get the debug certificate fingerprint on MacOs: (keytool -list -v \
-alias androiddebugkey -keystore ~/.android/debug.keystore)

12- follow this video for ios notification config (https://youtu.be/Hg1ZJjWzRxs?feature=shared)

13- if web run these commands (gcloud init) && (gsutil cors set cors.json storage bucket)

14- for hosting assetslink for deeplinking follow this article: (https://medium.com/androiddevelopers/android-app-links-deploy-assetlinks-json-in-minutes-d7082dffcac)