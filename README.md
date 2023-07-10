# riverpod_structure
A flutter project structure with riverpod, shared preferences, retrofit, goRouter.

## Project Setup

Things to do when you setup your project with riverpod structure:

1- After replacing the Manifest Make sure of changing android:label, then change host name for deeplinking from ../android/app/src/main/Android.Manifest.xml for android, and search for (<!-- Deep linking -->),
then change the host name in http and https.
and same for ios from ..ios/Runner/info.plist, and search for flutterbooksample.com, then change the name to your host name.

2- run this command (flutter pub run change_app_package_name:main <your new package name>)  to change your app package name.

3- change app name from pubspec.yaml and from main.dart.

4- flutter pub global activate build_runner & flutter pub run build_runner build.

5- add this permission (<uses-permission android:name="android.permission.INTERNET"/>)

6- 
dart run custom_lint
# Install custom_lint for all projects
dart pub global activate custom_lint
# run custom_lint's command line in a project
custom_lint

7- update the assetslinks.json file
