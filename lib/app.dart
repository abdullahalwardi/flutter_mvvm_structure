import 'package:app/main.dart';
import 'package:app/router/app_router.dart';
import 'package:app/src/settings/settings_provider.dart';
import 'package:app/theme/platform_default.dart';
import 'package:app/theme/theme.dart';
import 'package:app/utils/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_framework/responsive_framework.dart';

class App extends ConsumerStatefulWidget {
  const App({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AppState();
}

class _AppState extends ConsumerState<App> {

  @override
  Widget build(BuildContext context) {
    final settings = ref.watch(settingsProvider);
    final router = ref.watch(goRouterProvider);

    return MaterialApp.router(
      title: appName,
      debugShowCheckedModeBanner: false,
      routerConfig: router,
      scaffoldMessengerKey: Utils.messengerKey,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      themeMode: settings.themeMode,
      theme: getThemeData(ThemeMode.light),
      darkTheme: getThemeData(ThemeMode.dark),
      locale: PlatformDefault.locale(settings.locale),
      builder: (context, widget) => ResponsiveWrapper.builder(
        BouncingScrollWrapper.builder(context, widget!),
        maxWidth: 1600,
        minWidth: 1550,
        defaultScale: true,
        breakpoints: const [
          ResponsiveBreakpoint.resize(450, name: MOBILE),
          ResponsiveBreakpoint.autoScale(800, name: TABLET),
          ResponsiveBreakpoint.resize(1000, name: DESKTOP),
          ],
          ),
    );
  }
}
