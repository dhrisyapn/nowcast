import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Center(child: Image.asset('assets/logo.png')),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.35,
          ),
          Text(
            'NOWCAST',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w900,
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.08,
          )
        ],
      ),
    );
  }
}
