import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 25,
            ),
            Center(child: Image.asset('assets/name.png')),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.30,
            ),
            Text(
              '13/08/2024 Tuesday 10.23 AM',
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(
              height: 25,
            ),
            Image.asset('assets/cloudy.png'),
            SizedBox(
              height: 20,
            ),
            Text(
              'Rain',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              '29/39',
              style: TextStyle(
                color: Color(0xFF98FF98),
                fontSize: 10,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w500,
              ),
            )
          ],
        ),
      ),
    );
  }
}
