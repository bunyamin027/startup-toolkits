import 'package:flutter/material.dart';

import 'core/theme/app_theme.dart';

void main() {
  runApp(const StartupToolkitsApp());
}

class StartupToolkitsApp extends StatelessWidget {
  const StartupToolkitsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Startup Toolkits',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      // Dark is the designed theme; light stays a placeholder until drawn.
      themeMode: ThemeMode.dark,
      // UI screens arrive in Sprint 2–3.
      home: const Scaffold(body: Center(child: Text('Startup Toolkits'))),
    );
  }
}
