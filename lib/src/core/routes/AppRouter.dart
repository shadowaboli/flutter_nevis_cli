// lib/core/routes/app_router.dart
import 'package:flutter/material.dart';
import 'package:flutter_nevis_cli/src/features/features_main/presentation/page/MainPage.dart';
import 'package:flutter_nevis_cli/src/features/features_settings/presentation/page/SettingsPage.dart';


class AppRouter {
  // مسیرها
  static const String home = '/';
  static const String settingPage = '/settingPage';

  // Map تمام روت‌ها
  static Map<String, WidgetBuilder> routes = {
    home: (_) => const MainPage(),
    settingPage: (_) => const SettingsPage(),
  };

  // متد کمکی برای pushNamed
  static void pushNamed(BuildContext context, String routeName) {
    Navigator.of(context).pushNamed(routeName);
  }
}