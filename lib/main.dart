import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_tasky_app/core/services/preferences_manager.dart';
import 'package:flutter_tasky_app/core/theme/dark_theme.dart';
import 'package:flutter_tasky_app/core/theme/theme_controller.dart';
import 'package:flutter_tasky_app/main_screen.dart';
import 'package:flutter_tasky_app/welcome_screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await PreferencesManager().init();
  ThemeController().init();
  String? username = PreferencesManager().getString("userName");
  runApp( MyApp(username: username));
}

class MyApp extends StatelessWidget {
  MyApp({super.key , this.username});
  final String? username;
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: ThemeController.themeNotifier,
      builder: (context, mode, _) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: darkTheme,
          darkTheme: darkTheme,
          themeMode: mode,
          home: username == null ? WelcomeScreen() :  MainScreen(),
        );
      },
    );
  }
}
