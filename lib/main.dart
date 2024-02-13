import 'package:flutter/material.dart';
import 'package:weather_app/widgets/home_page.dart';

var kColorScheme =
    ColorScheme.fromSeed(seedColor: const Color.fromARGB(31, 27, 9, 225));

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App',
      theme: ThemeData().copyWith(
        colorScheme: kColorScheme,
        appBarTheme: const AppBarTheme().copyWith(
          backgroundColor: kColorScheme.onPrimaryContainer,
          foregroundColor: kColorScheme.primaryContainer,
        ),
        cardTheme: const CardTheme().copyWith(
          color: kColorScheme.secondaryContainer
        ),
      ),
      home: const HomePage(),
    );
  }
}
