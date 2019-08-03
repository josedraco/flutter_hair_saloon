import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_hair_saloon/Model/Validation.dart';
import 'package:flutter_hair_saloon/pages/Signup.dart';
import 'package:flutter_hair_saloon/theme/Color.dart';
import 'package:flutter_hair_saloon/theme/CustomStyle.dart';
import 'package:flutter_hair_saloon/widgets/BackGroundImage.dart';
import 'package:flutter_hair_saloon/widgets/CustomButton.dart';
import 'package:flutter_hair_saloon/widgets/CustomLogo.dart';
import 'package:flutter_hair_saloon/widgets/CustomTextFormField.dart';
import "package:flutter_hair_saloon/pages/Home.dart";

class Login extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return LoginState();
  }
}

class LoginState extends State<Login> {
  Validation validation = Validation();

  bool isAutoSubmit = false;
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  FocusNode email;
  FocusNode password;

  TextEditingController emailCtrl;
  TextEditingController passwordCtrl;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    email = FocusNode();
    password = FocusNode();

    emailCtrl = TextEditingController();
    passwordCtrl = TextEditingController();
  }

  @override
  void dispose() {
    unFocus();
    email?.dispose();
    password?.dispose();
    emailCtrl?.dispose();
    passwordCtrl?.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  unFocus() {
    email.unfocus();
    password.unfocus();
  }

  login(){
    setState(()=>isAutoSubmit = true);
    if(_formKey.currentState.validate()){
      print("LOGIN DONE");
      Navigator.pushAndRemoveUntil(_scaffoldKey.currentContext, MaterialPageRoute(builder: (context)=>Home()), ModalRoute.withName("/root"));
    }else{
      print("ERROR");
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.black87,
      body: Stack(
        children: <Widget>[
          BackGroundImage(image: "assets/images/image1.jpg",),
          SafeArea(
            child: Form(
              key: _formKey,
              autovalidate: isAutoSubmit,
              child:  SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height:
                      (MediaQuery.of(context).orientation == Orientation.portrait)
                          ? MediaQuery.of(context).size.height / 7.5
                          : 0,
                    ),
                    CustomLogo(),
                    SizedBox(height: 30.0),
                    loginText(),
                    SizedBox(height: 30.0),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      child: CustomTextFormField(
                        textInputAction: TextInputAction.next,
                        controller: emailCtrl,
                        focusNode: email,
                        validator: (value) => validation.validate("Email", value, TYPE.EMAIL),
                        hintText: "Email",
                        onSubmitted: (value){
                          email.unfocus();
                          FocusScope.of(context).requestFocus(password);
                        },
                        textInputType: TextInputType.emailAddress,
                      ),
                    ),
                    SizedBox(height: 10.0),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      child: CustomTextFormField(
                        textInputAction: TextInputAction.done,
                        controller: passwordCtrl,
                        focusNode: password,
                        isPassword: true,
                        validator: (value) => validation.validate("Password", value, TYPE.TEXT),
                        hintText: "Password",
                        onSubmitted: (value){
                          password.unfocus();
                          login();
                        },
                        textInputType: TextInputType.text,
                      ),),
                    SizedBox(height: 20.0),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      child: CustomButton(
                        color: primary,
                        width: double.infinity,
                        name: "Login",
                        onTap: () {
                          unFocus();
                          login();
                        },
                        textStyle: loginButton,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.0,vertical: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text("New User ?",style: TextStyle(color: Colors.white,fontSize: 16.0),),
                          SizedBox(width: 10.0,),
                          GestureDetector(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>Signup()));
                            },
                            child: Text("Register Now",style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.bold,color: Colors.white),),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )
          )
        ],
      ),
    );
  }


  Widget loginText(){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width/3.5,
            height: 2.0,
            color: primary,
          ),
          Text("Login",style: TextStyle(fontSize: 23.0,color: Colors.white,fontWeight: FontWeight.bold),),
          Container(
            width: MediaQuery.of(context).size.width/3.5,
            height: 2.0,
            color: primary,
          )
        ],
      ),
    );
  }
}
