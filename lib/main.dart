import 'package:fitmeeasy/Screens/log_in_screen.dart';
import 'package:fitmeeasy/theme/app_theme.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: buildAppTheme(),
      home: LogInScreen(),
    ); //no cal const?
  }
}
