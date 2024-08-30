import 'package:flutter/material.dart';
import 'package:interact/widget/expenses.dart';
// import 'package:flutter/services.dart';

var KdarkColorscheme = ColorScheme.fromSeed(
  brightness: Brightness.dark,
  seedColor: const Color.fromARGB(255, 11, 12, 12),
);

var KColorSchem =
    ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 96, 59, 181));
void main() {
  // WidgetsFlutterBinding
  //     .ensureInitialized(); //to does not respond the orentation
  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitUp,
  // ]).then((fn) {
  runApp(
    MaterialApp(
        debugShowCheckedModeBanner: false,
       themeMode: ThemeMode.dark, // Ensure the dark theme is used

        darkTheme: ThemeData.dark().copyWith(
          colorScheme: KdarkColorscheme,
          cardTheme: const CardTheme().copyWith(
              color: KdarkColorscheme.secondaryContainer,
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8)),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
                backgroundColor: KdarkColorscheme.primaryContainer,
                foregroundColor: KdarkColorscheme.onPrimaryContainer),
          ),
        ),
        theme: ThemeData().copyWith(
            colorScheme: KColorSchem,
            appBarTheme: const AppBarTheme().copyWith(
                backgroundColor: KColorSchem.onPrimaryContainer,
                foregroundColor: KColorSchem.primaryContainer),
            cardTheme: const CardTheme().copyWith(
                color: KColorSchem.secondaryContainer,
                margin:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8)),
            elevatedButtonTheme: ElevatedButtonThemeData(
                style: ElevatedButton.styleFrom(
                    backgroundColor: KColorSchem.primaryContainer)),
            textTheme: ThemeData().textTheme.copyWith(
                titleLarge: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: KColorSchem.onSecondaryContainer))),
        home: const Expenses()),
  );
  // });
}
