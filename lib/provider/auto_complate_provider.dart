

import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import '../helper/storage_helper.dart';
import '../model/auto_complate_place.dart';
import '../network_manager/rest_client.dart';
import '../screens/home_screen.dart';

class AutoComplateProvider extends ChangeNotifier{
  AutoCompatePlaceModal autoCompatePlaceModal= AutoCompatePlaceModal();

  autocomplateplace(String placename,BuildContext context){

    RestClient.getlocation(placename).then((value) {
      autoCompatePlaceModal=value;
      notifyListeners();

    },).onError((error, stackTrace) {
      print("Error:${error.toString()}");
    },);
    notifyListeners();
  }
}