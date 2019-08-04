import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hair_saloon/Model/Validation.dart';
import 'package:flutter_hair_saloon/theme/Color.dart';
import 'package:flutter_hair_saloon/theme/CustomStyle.dart';
import 'package:flutter_hair_saloon/widgets/BackGroundImage.dart';
import 'package:flutter_hair_saloon/widgets/CustomButton.dart';
import 'package:flutter_hair_saloon/widgets/CustomLogo.dart';
import 'package:flutter_hair_saloon/widgets/CustomTextFormField.dart';
import 'package:flutter_hair_saloon/pages/Home.dart';

class Signup extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return SignupState();
  }
}

class SignupState extends State<Signup> {
  Validation validation = Validation();

  bool isAutoSubmit = false;
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  FocusNode email;
  FocusNode password;
  FocusNode username;

  TextEditingController emailCtrl;
  TextEditingController passwordCtrl;
  TextEditingController usernameCtrl;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    email = FocusNode();
    password = FocusNode();
    username = FocusNode();

    emailCtrl = TextEditingController();
    passwordCtrl = TextEditingController();
    usernameCtrl = TextEditingController();
  }

  @override
  void dispose() {
    unFocus();
    email?.dispose();
    password?.dispose();
    username?.dispose();
    emailCtrl?.dispose();
    passwordCtrl?.dispose();
    usernameCtrl?.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  unFocus() {
    email.unfocus();
    password.unfocus();
    username.unfocus();
  }

  signup() {
    setState(() => isAutoSubmit = true);
    if (_formKey.currentState.validate()) {
      Navigator.pushAndRemoveUntil(_scaffoldKey.currentContext, MaterialPageRoute(builder: (context)=>Home()), ModalRoute.withName("/root"));
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      key: _scaffoldKey,
      body: Stack(
        children: <Widget>[
          BackGroundImage(
            image: "assets/images/image1.jpg",
          ),
          SafeArea(
              child: Form(
            autovalidate: isAutoSubmit,
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: (MediaQuery.of(context).orientation ==
                            Orientation.portrait)
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
                      controller: usernameCtrl,
                      focusNode: username,
                      validator: (value) =>
                          validation.validate("Username", value, TYPE.TEXT),
                      hintText: "Username",
                      onSubmitted: (value) {
                        username.unfocus();
                        FocusScope.of(context).requestFocus(email);
                      },
                      textInputType: TextInputType.emailAddress,
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: CustomTextFormField(
                      textInputAction: TextInputAction.next,
                      controller: emailCtrl,
                      focusNode: email,
                      validator: (value) =>
                          validation.validate("Email", value, TYPE.EMAIL),
                      hintText: "Email",
                      onSubmitted: (value) {
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
                      isPassword: true,
                      textInputAction: TextInputAction.done,
                      controller: passwordCtrl,
                      focusNode: password,
                      validator: (value) =>
                          validation.validate("Password", value, TYPE.PASSWORD),
                      hintText: "Password",
                      onSubmitted: (value) {
                        password.unfocus();
                        signup();
                      },
                      textInputType: TextInputType.text,
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: CustomButton(
                      color: primaryColor,
                      width: double.infinity,
                      name: "Register Now",
                      onTap: () {
                        unFocus();
                        signup();
                      },
                      textStyle: loginButton,
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text("Already have an account ? ",style: TextStyle(color: Colors.white),),
                        GestureDetector(
                          onTap: (){
                            Navigator.pop(context);
                          },
                          child: Text("Login here",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ))
        ],
      ),
    );
  }

  Widget loginText() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width / 4.5,
            height: 2.0,
            color: primaryColor,
          ),
          Text(
            "Register now",
            style: TextStyle(
                fontSize: 23.0,
                color: Colors.white,
                fontWeight: FontWeight.bold),
          ),
          Container(
            width: MediaQuery.of(context).size.width / 4.5,
            height: 2.0,
            color: primaryColor,
          )
        ],
      ),
    );
  }
}
