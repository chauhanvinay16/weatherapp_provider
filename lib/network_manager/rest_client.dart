
import 'package:weatherapp/network_manager/https_helper.dart';

import '../model/auto_complate_place.dart';
import '../model/current_weather_modal.dart';

class RestClient{
  static final HttpHelper _httpHelper=HttpHelper();

  static Future<dynamic>loginapi(Object requestBody)async{
    Map<String,dynamic>response= await _httpHelper.post(url: 'https://reqres.in/api/login',requestBody: requestBody);
    return response;
  }

  static Future<AutoCompatePlaceModal>getlocation(String palcename)async{
    Map<String,dynamic>response=await _httpHelper.get(url: 'https://geocoding-api.open-meteo.com/v1/search?name=$palcename&count=5');
    return AutoCompatePlaceModal.fromJson(response);
  }

  static Future<CurrentWeatherModal >getcurrentlocation(double lat,double lon)async{
    Map<String,dynamic>response=await _httpHelper.get(url: 'https://api.open-meteo.com/v1/forecast?latitude=$lat&longitude=$lon&current_weather=true');
    return CurrentWeatherModal .fromJson(response);
  }
}