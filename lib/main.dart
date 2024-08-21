import 'package:flutter/material.dart';
import 'package:nowcast/home.dart';
import 'package:nowcast/splash.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        scaffoldBackgroundColor: Color(0xff87CEFA),
        useMaterial3: true,
      ),
      home: HomePage(),
    );
  }
}
