

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:weatherapp/helper/storage_helper.dart';
import 'package:weatherapp/network_manager/rest_client.dart';

import '../screens/home_screen.dart';

class LoginProvider extends ChangeNotifier{

  bool loading=false;
  notifyListeners();

  login(String email,String password,BuildContext context){
    loading=true;
    Map requestBody= {
      "email": email,
      "password": password
    };
    RestClient.loginapi(requestBody).then((value) {
        loading=false;
        notifyListeners();
        print("Token:${value['token']}");
        StorageHelper().setUserBearerToken(value['token']??"");
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen(),));
    },).onError((error, stackTrace) {
      print("Error:${error.toString()}");
    },);
    notifyListeners();
  }
}