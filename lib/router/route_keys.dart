import 'package:flutter/material.dart';

/// Root stack navigator (dialogs, fullscreen flows above tabs/shell).
final GlobalKey<NavigatorState> rootNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'root');
