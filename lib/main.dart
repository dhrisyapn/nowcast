import 'package:flutter/material.dart';
import 'package:nowcast/home.dart';
import 'package:nowcast/splash.dart';
import 'package:permission_handler/permission_handler.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Ask for location permission
  var status = await Permission.location.request();
  if (status.isGranted) {
    // Permission granted
    runApp(const MyApp());
  } else if (status.isDenied) {
    // Permission denied
    // You can show a dialog or a message to the user
    runApp(const MyApp());
  } else if (status.isPermanentlyDenied) {
    // Permission permanently denied
    // You can open app settings to let the user enable the permission
    openAppSettings();
  }

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
