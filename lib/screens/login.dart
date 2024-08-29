import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weatherapp/helper/storage_helper.dart';
import 'package:weatherapp/provider/login_provider.dart';
import 'package:weatherapp/utiles/loadingindugator.dart';

class LoginSceen extends StatefulWidget {
  const LoginSceen({super.key});
  @override
  State<LoginSceen> createState() => _LoginSceenState();
}

class _LoginSceenState extends State<LoginSceen> {

  TextEditingController emailcontroller=TextEditingController();
  TextEditingController passcontroller=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // title: Text('Login API',style: TextStyle(color: Colors.white),),
        title: Text(StorageHelper().getUserBearerToken(),style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.indigo,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("LOGIN",textScaleFactor: 2,),
            TextField(
              controller: emailcontroller,
              decoration: InputDecoration(
                  hintText: 'Email'
              ),
            ),
            SizedBox(height: 20,),
            TextField(
              controller: passcontroller,
              decoration: InputDecoration(
                  hintText: 'password'
              ),
            ),
            SizedBox(height: 30,),
            SizedBox(
              height: 50,
              width: double.infinity,
              child: ChangeNotifierProvider(
                create: (BuildContext context) => LoginProvider(),
                child: Consumer<LoginProvider>(
                  builder: (context,provider,child) {
                    return ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.indigo,
                        ),
                        onPressed: () {
                          if(!provider.loading){
                            provider.login(
                                emailcontroller.text.toString(),
                                passcontroller.text.toString(),
                                context
                            );
                          }
                        }, child: provider.loading?Center(child: loadingindigator(),):
                    Text('Login',style: TextStyle(color: Colors.white),));
                  }
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
