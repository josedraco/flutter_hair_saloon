import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hair_saloon/pages/Home.dart';
import 'package:flutter_hair_saloon/pages/Login.dart';
import 'package:flutter_hair_saloon/pages/Root.dart';
import 'package:flutter_hair_saloon/pages/Signup.dart';
import 'package:flutter_hair_saloon/theme/Color.dart';


Future main() async {
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(new Main());
}


class Main extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      routes: <String, WidgetBuilder>{
        '/home': (BuildContext context) => Home(),
        '/login': (BuildContext context) => Login(),
        '/signup': (BuildContext context) => Signup(),
        '/root': (BuildContext context) => Root(),
      },
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: "Raleway",
        primaryColor: primary,
        accentColor: primary
      ),
      home: Root(),
    );
  }
}