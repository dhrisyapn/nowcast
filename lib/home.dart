import 'package:flutter/material.dart';
//import geolocator
import 'package:geolocator/geolocator.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:nowcast/providerclass.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Position? _currentPosition;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    setState(() {
      _currentPosition = position;
      print(_currentPosition);
    });
    getWeatherData(_currentPosition!.latitude.toString(),
        _currentPosition!.longitude.toString());
  }

  void getWeatherData(String lat, String lon) async {
    final url =
        'http://api.weatherapi.com/v1/current.json?key=c095793f5e39491eb0d92359242208&q=$lat,$lon';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final tempC = data['current']['temp_c'];
        final tempF = data['current']['temp_f'];
        final conditionText = data['current']['condition']['text'];
        final icon1 = 'https:' + data['current']['condition']['icon'];

        print('Temperature in Celsius: $tempC');
        print('Temperature in Fahrenheit: $tempF');
        print('Condition: $conditionText');
        print('Icon: $icon1');
        //save data to provider
        Provider.of<WeatherProvider>(context, listen: false)
            .setDatas(tempC.toString(), tempF.toString(), conditionText, icon1);
      } else {
        print('Failed to load weather data');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    String formattedDate =
        DateFormat('dd/MM/yyyy EEEE hh:mm a').format(DateTime.now());
    return Scaffold(
      appBar: AppBar(
        title: Image.asset('assets/name.png'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 25,
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      left: 30,
                      right: 10), // Adjusted right padding for better spacing
                  child: Container(
                    width: MediaQuery.of(context).size.width -
                        120, // Adjust width to fit within the screen
                    child: TextField(
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 10.0),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 1, color: Colors.white),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 1, color: Colors.white),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        hintText: 'Search',
                        hintStyle: TextStyle(
                          color: Colors.white.withOpacity(0.5),
                          fontSize: 14,
                        ),
                      ),
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                Container(
                  width: 40,
                  height: 40,
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(width: 1, color: Colors.white),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Icon(
                    Icons.search,
                    color: Colors.white,
                  ),
                )
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.25,
            ),
            Center(
              child: Text(
                formattedDate,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            SizedBox(
              height: 25,
            ),
            Provider.of<WeatherProvider>(context).getIcon?.toString() != null
                ? Image.network(
                    Provider.of<WeatherProvider>(context).getIcon.toString(),
                    width: MediaQuery.of(context).size.width * 0.5,
                    height: 30,
                  )
                : Image.network(
                    'https://firebasestorage.googleapis.com/v0/b/blug-d8bc7.appspot.com/o/loading_circles_blue_gradient.png?alt=media&token=77b8af6b-2d6c-4c3f-8a78-fa122a0d2f35',
                    fit: BoxFit.cover,
                    width: MediaQuery.of(context).size.width * 0.5,
                  ),
            SizedBox(
              height: 20,
            ),
            Text(
              Provider.of<WeatherProvider>(context).getWeather.toString(),
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              Provider.of<WeatherProvider>(context).getTempC.toString() +
                  '°C / ' +
                  Provider.of<WeatherProvider>(context).getTempF.toString() +
                  '°F',
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
