import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hair_saloon/theme/Color.dart';

class CustomLogo extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Container(
              height: 200.0,
              width: 200.0,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: AssetImage("assets/images/logo.png"),
                    fit: BoxFit.contain,
                  )
              )
          ),
          Positioned(
            bottom: 20,
            child: Align(
              alignment: Alignment.center,
              child: Text("QueenSpot",textAlign: TextAlign.center,style: TextStyle(color: primaryColor,fontSize: 30,fontWeight: FontWeight.bold),),
            ),
            )
        ],
      ),
    );
  }
}