import 'package:flutter/material.dart';

import 'package:nodepad/homepage.dart';


void main() {
  runApp(app());
}

class app extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.dark,
      darkTheme: ThemeData(
        appBarTheme: const AppBarTheme(
          centerTitle: true,
          backgroundColor: Colors.orange,
          titleTextStyle: TextStyle(
            fontSize: 30,
            fontStyle: FontStyle.italic,
            color: Colors.black,
          ),
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Colors.orange,
        ),
        textTheme: const TextTheme(
          bodyText1: TextStyle(
            fontSize: 30,
            fontStyle: FontStyle.italic,
          ),
        ),
      ),
      home: Home(),
    );
  }
}
