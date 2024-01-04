import 'package:flutter/material.dart';
import 'package:toonflix/screens/home_screen.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        cardColor: const Color(0xFFF4EDDB),
        colorScheme: const ColorScheme(
          background: Color(0xFFE7626C),
          brightness: Brightness.light,
          primary: Color(0xFFFFFFFF),
          onPrimary: Color(0xFFFFFFFF),
          secondary: Color(0xFFFFFFFF),
          onSecondary: Color(0xFFFFFFFF),
          error: Color(0xFFFFFFFF),
          onError: Color(0xFFFFFFFF),
          onBackground: Color(0xFFFFFFFF),
          surface: Color(0xFFFFFFFF),
          onSurface: Color(0xFFFFFFFF),
        ),
        textTheme: const TextTheme(
          displayLarge: TextStyle(
            color: Color(0xFF232B55),
          ),
        ),
      ),
      home: const Scaffold(
        body: HomeScreen(),
      ),
    );
  }
}
