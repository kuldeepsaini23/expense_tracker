import 'package:expense_tracker/widgets/expenses.dart';
import 'package:flutter/material.dart';

var kColorScheme = ColorScheme.fromSeed(
  seedColor: const Color.fromARGB(255, 96, 59, 181),
);

var kDarkColorScheme = ColorScheme.fromSeed(
  brightness: Brightness.dark,
  seedColor: const Color.fromARGB(255, 5, 99, 125),
);

void main() {
  runApp(MaterialApp(
    title: "Expense Tracker",

    //* Darkmode
    darkTheme: ThemeData.dark().copyWith(
      useMaterial3: true,
      colorScheme: kDarkColorScheme,

      //*Expense List Item Card Theme
      cardTheme: CardTheme(
        color: kDarkColorScheme.secondaryContainer,
        margin: const EdgeInsets.symmetric(
          vertical: 8,
          horizontal: 16,
        ),
      ),

      //* Eleveated Button Thems
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: kDarkColorScheme.primaryContainer,
          foregroundColor: kDarkColorScheme.onPrimaryContainer,
        ),
      ),

      //*Appbar Theme
      textTheme: ThemeData().textTheme.copyWith(
            titleLarge: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: kDarkColorScheme.onSecondaryContainer,
            ),
             titleSmall: TextStyle(
              fontWeight: FontWeight.normal,
              fontSize: 14,
              color: kDarkColorScheme.onSecondaryContainer,
            ),
          ),
    ),

    //* lightmode
    theme: ThemeData().copyWith(
      useMaterial3: true,
      colorScheme: kColorScheme,
      //*Appbar Theme
      appBarTheme: AppBarTheme(
        backgroundColor: kColorScheme.onPrimaryContainer,
        foregroundColor: kColorScheme.primaryContainer,
      ),

      //*Expense List Item Card Theme
      cardTheme: CardTheme(
        color: kColorScheme.secondaryContainer,
        margin: const EdgeInsets.symmetric(
          vertical: 8,
          horizontal: 16,
        ),
      ),

      //* Eleveated Button Thems
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: kColorScheme.primaryContainer,
        ),
      ),

      //*Appbar Theme
      textTheme: ThemeData().textTheme.copyWith(
            titleLarge: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: kColorScheme.onSecondaryContainer,
            ),
            titleSmall: TextStyle(
              fontWeight: FontWeight.normal,
              fontSize: 14,
              color: kColorScheme.onSecondaryContainer,
            ),
          ),
    ),
    //* CheckMode --> but default flutter already do that
    // themeMode: ThemeMode.system,
    home: const Expenses(),
  ));
}
