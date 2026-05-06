import 'package:app/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

const String baseurl = 'http://example.com';

/// Routes in-app deep links rooted at [baseurl]; external URLs launch outside.
Future<void> launchUrlOrDeepLink(
  BuildContext context, {
  required String url,
}) async {
  if (url.startsWith(baseurl)) {
    final path = Uri.parse(url).path;
    final normalized = path.isEmpty || path == '.' ? '/' : path;

    if (normalized == const HomeRoute().location) {
      const HomeRoute().go(context);
      return;
    }
    if (normalized == const SignInRoute().location) {
      const SignInRoute().go(context);
      return;
    }
    return;
  }

  await launchUrlString(
    url,
    mode: LaunchMode.externalApplication,
  );
}
