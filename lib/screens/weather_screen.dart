import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:provider/provider.dart';
import 'package:weatherapp/provider/current_weather_provider.dart';
import 'package:weatherapp/utiles/loadingindugator.dart';

class WeatherScreen extends StatefulWidget {
  final double lat,long;
  const WeatherScreen({super.key, required this.lat, required this.long});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  @override
  void initState() {
    print('latitude:${widget.lat} \n longitude:${widget.long}');
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(color: Colors.white,),
        title: Text('Weather',style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.indigo,
        centerTitle: true,
      ),
      body: ChangeNotifierProvider(
        create: (context) => CurrentWeatherProvider()..getCurrentweather(widget.lat, widget.long),
        child: Consumer<CurrentWeatherProvider>(
          builder: (context,provider,child) {
            return provider.isloading?Center(child: loadingindigator(color: Colors.deepPurple),):
              Column(
              children: [
                const SizedBox(height: 50,),
                Text("${provider.cityname}",
                  style: TextStyle(color: Colors.deepPurple,fontSize: 30,fontWeight: FontWeight.bold),),

                Text("${Jiffy.now().yMMMMEEEEdjm}",
                  style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.bold),),

                const SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 130,
                      width: 130,
                      child: Image.asset('assets/3942094.png'),
                    ),
                    SizedBox(width: 20,),
                    Text('${provider.currentWeatherModal.currentWeather?.temperature.toString()??""} ${provider.currentWeatherModal.currentWeatherUnits?.temperature.toString()??""}',
                    style: TextStyle(color: Colors.deepPurple,fontSize: 45,fontWeight: FontWeight.bold),)
                  ],
                ),
                const SizedBox(height: 20,),
                Text("Wind Speed: ${provider.currentWeatherModal.currentWeather?.windspeed.toString()??""} ${provider.currentWeatherModal.currentWeatherUnits?.windspeed??""}",
                  style: TextStyle(color: Colors.deepPurple,fontSize: 20,fontWeight: FontWeight.bold),),
              ],
            );
          }
        ),
      ),
    );
  }
}
