import 'package:flutter/material.dart';

class WeatherProvider with ChangeNotifier {
  String? tempC;
  String? tempF;
  String? weather;
  String? get getTempC => tempC;
  String? get getTempF => tempF;
  String? get getWeather => weather;
  void setDatas(String tempC, String tempF, String weather) {
    this.tempC = tempC;
    this.tempF = tempF;
    this.weather = weather;
    notifyListeners();
  }
}
