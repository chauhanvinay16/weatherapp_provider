

import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:weatherapp/utiles/toast_message.dart';
import '../model/current_weather_modal.dart';
import '../network_manager/rest_client.dart';


class CurrentWeatherProvider extends ChangeNotifier{
  CurrentWeatherModal  currentWeatherModal= CurrentWeatherModal();

  bool isloading=false;
  String cityname='';

  getCurrentweather(double lat,double lon){
    isloading=true;
    notifyListeners();
    RestClient.getcurrentlocation(lat,lon).then((value) async{
      currentWeatherModal=value;
      isloading=false; //geocode
      List<Placemark> placemarks = await placemarkFromCoordinates(lat, lon);
      Placemark place= placemarks[0];

      cityname=place.locality??"";
      print("Address:${place.name} ${place.locality} ${place.country} ${place.postalCode} ${place.street}");
      notifyListeners();

    },).onError((error, stackTrace) {
      notifyListeners();
      tostmesssage(error.toString());
      print("API Error:${error.toString()}");
    },);
    notifyListeners();
  }
}