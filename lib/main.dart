import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_nevis_cli/src/core/routes/AppRouter.dart';
import 'package:flutter_nevis_cli/src/features/features_main/presentation/page/MainPage.dart';
import 'package:xterm/xterm.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Real Terminal',
      debugShowCheckedModeBanner: false,
      initialRoute: AppRouter.home,
      routes: AppRouter.routes,
    );
  }
}
