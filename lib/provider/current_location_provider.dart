import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:weatherapp/helper/geo_locator_handeler.dart';
import 'package:weatherapp/utiles/toast_message.dart';

import '../screens/weather_screen.dart';

class CurrentLocationProvider extends ChangeNotifier{

  bool loading=false;

  getletlan(BuildContext context){
    loading=true;
    notifyListeners();
    determinePosition().then((value) {
      loading=false;
      notifyListeners();
      Navigator.push(context, MaterialPageRoute(builder: (context) =>
          WeatherScreen(
            lat: value.latitude,
            long: value.longitude,
          ),));
    },).onError((error, stackTrace) {
      tostmesssage('Opps somthing want to wrong');
      print("current location error:${error.toString()}");
      loading=false;
      notifyListeners();
    },);
  }
}