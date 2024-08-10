//Internal Packages
import 'package:flutter/material.dart';

//External Packages
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//Project Packages
import 'package:timesheet/screens/user_landing.dart';

final theme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
    brightness: Brightness.light,
    seedColor: const Color.fromARGB(255, 174, 15, 35)
  ),
  textTheme: GoogleFonts.latoTextTheme(),
);

void main() {
  runApp(
    const ProviderScope(
      child: MyApp()
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: theme,
      home: const UserLandingScreen(),
    );
  }
}
