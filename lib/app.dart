import 'package:app/l10n/app_localizations.dart';
import 'package:app/main.dart';
import 'package:app/router/app_router.dart';
import 'package:app/data/providers/settings_provider.dart';
import 'package:app/theme/app_theme.dart';
import 'package:app/utils/extensions.dart';
import 'package:app/utils/kurdish_localization/kurdish_material_localization_delegate.dart';
import 'package:app/utils/kurdish_localization/kurdish_widget_localization_delegate.dart';
import 'package:app/utils/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_framework/responsive_framework.dart';

class App extends ConsumerStatefulWidget {
  const App({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AppState();
}

class _AppState extends ConsumerState<App> {

  // @override
  // void initState() {
  //   super.initState();
    
  //   initializeFirebaseMessaging();
  //   FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
  //     debugPrint("remote message received: ${message.messageId}");
  //     debugPrint("notification received: ${message.notification?.body}");
  //     if (message.notification != null) {
  //       LocalNotificationsServices.showNotification(message);
  //     }
  //   });
  // }

  // @override
  // void initState() {
  //   super.initState();
  //   WidgetsBinding.instance.scheduleFrameCallback((timeStamp) async {
  //     await ref
  //         .read(getIsarInstanceProvider(const [PostSchemeSchema]).future)
  //         .then((isar) {
  //       debugPrint("this is isar instance: ${isar.path}");
  //       CacheManager().clearCacheAndDatabase(isar);
  //     }); // Open the Isar instance
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme();
    final settings = ref.watch(settingsProvider);

    return MaterialApp.router(
      title: appName,
      debugShowCheckedModeBanner: false,
      routerConfig: router,
      scaffoldMessengerKey: Utils.messengerKey,
      // Locale
      locale: settings.locale,
      onGenerateTitle: (context) => context.l10n.appName,
      localizationsDelegates: const [
              ...AppLocalizations.localizationsDelegates,
              KurdishMaterialLocalizations.delegate,
              KurdishWidgetLocalizations.delegate,
            ],
      supportedLocales: AppLocalizations.supportedLocales,
      // Theme
      themeMode: settings.themeMode,
      darkTheme: theme.buildDarkTheme(),
      theme: theme.buildLightTheme(),
      builder: (context, child) => ResponsiveBreakpoints.builder(
        child: child!,
        breakpoints: [
          const Breakpoint(start: 0, end: 450, name: MOBILE),
          const Breakpoint(start: 451, end: 800, name: TABLET),
          const Breakpoint(start: 801, end: 1920, name: DESKTOP),
          const Breakpoint(start: 1921, end: double.infinity, name: '4K'),
        ],
      ),
    );
  }
}
