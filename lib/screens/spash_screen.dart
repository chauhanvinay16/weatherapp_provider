import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:weatherapp/helper/storage_helper.dart';
import 'package:weatherapp/screens/home_screen.dart';
import 'package:weatherapp/screens/login.dart';

class SpashScreen extends StatefulWidget {
  const SpashScreen({super.key});

  @override
  State<SpashScreen> createState() => _SpashScreenState();
}

class _SpashScreenState extends State<SpashScreen> {

  @override
  void initState() {
    Future.delayed(Duration(seconds: 3),(){
        if(StorageHelper().getUserBearerToken()==""){
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginSceen(),));
        }else{
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen(),));
        }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor('#f5f5f5'),
      body: Center(
        child: SizedBox(
            height: 200,
            width: 200,
            child: Image.asset('assets/3942094.png')),
      ),
    );
  }
}
