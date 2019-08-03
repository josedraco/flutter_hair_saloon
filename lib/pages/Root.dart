import 'package:flutter/material.dart';
import 'package:flutter_hair_saloon/pages/Login.dart';

class Root extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return RootState();
  }
}

class RootState extends State<Root>{
  Widget customWidget = Container(child: Text("Loading..."),);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    customWidget = Login();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: customWidget,
    );
  }
}