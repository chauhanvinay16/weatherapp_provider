import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weatherapp/helper/storage_helper.dart';
import 'package:weatherapp/provider/auto_complate_provider.dart';
import 'package:weatherapp/provider/current_location_provider.dart';
import 'package:weatherapp/screens/weather_screen.dart';
import 'package:weatherapp/utiles/loadingindugator.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController searchcontroller=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Location',style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.indigo,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ChangeNotifierProvider(
          create: (context) => AutoComplateProvider(),
          child: Consumer<AutoComplateProvider>(
            builder: (context,provider,child) {
              return Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: searchcontroller,
                          decoration: InputDecoration(
                              hintText: 'Enter Place'
                          ),
                          onChanged: (String value) {
                              print(value.toString());
                              Future.delayed(const Duration(seconds: 1),(){
                                provider.autocomplateplace(value, context);
                              });
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ChangeNotifierProvider(
                          create: (context) => CurrentLocationProvider(),
                          child: Consumer<CurrentLocationProvider>(
                            builder: (context,currentlocationprovider,child) {
                              return GestureDetector(
                                onTap: () {
                                  currentlocationprovider.getletlan(context);
                                },
                                child: Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    color: Colors.indigo
                                  ),
                                  child: currentlocationprovider.loading?Center(child: loadingindigator(),):
                                  Icon(Icons.location_on_outlined,color: Colors.white,),
                                ),
                              );
                            }
                          ),
                        ),
                      )
                    ],
                  ),

                  Visibility(
                    visible: provider.autoCompatePlaceModal.results?.isNotEmpty??false,
                    child: ListView.builder(
                        itemCount: provider.autoCompatePlaceModal.results?.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return ListTile(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) =>
                                  WeatherScreen(
                                      lat: provider.autoCompatePlaceModal.results?[index].latitude??0.0,
                                      long: provider.autoCompatePlaceModal.results?[index].longitude??0.0,
                                  ),));
                            },
                            title: Text(provider.autoCompatePlaceModal.results?[index].name??""),
                            subtitle: Text(provider.autoCompatePlaceModal.results?[index].country??""),
                            contentPadding: EdgeInsets.zero,
                            leading: Icon(Icons.location_pin),
                          );
                        },
                    ),
                  )

                ],
              );
            }
          ),
        ),
      ),
    );
  }
}
