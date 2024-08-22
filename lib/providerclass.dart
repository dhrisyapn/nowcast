import 'package:flutter/material.dart';

class WeatherProvider with ChangeNotifier {
  String? tempC;
  String? tempF;
  String? weather;
  String? icon;
  String? get getTempC => tempC;
  String? get getTempF => tempF;
  String? get getWeather => weather;
  String? get getIcon => icon;
  void setDatas(String tempC, String tempF, String weather, String icon) {
    this.tempC = tempC;
    this.tempF = tempF;
    this.weather = weather;
    this.icon = icon;
    notifyListeners();
  }
}
