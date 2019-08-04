import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_hair_saloon/Model/Validation.dart';
import 'package:flutter_hair_saloon/theme/Color.dart';
import 'package:flutter_hair_saloon/widgets/BackGroundImage.dart';
import 'package:flutter_hair_saloon/widgets/CustomButton.dart';
import 'package:flutter_hair_saloon/widgets/CustomTextFormField.dart';

class Booking extends StatefulWidget {

  String title;

  Booking({this.title});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return BookingState();
  }
}

class BookingState extends State<Booking> {

  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  FocusNode username;
  FocusNode email;
  FocusNode phoneNumber;

  TextEditingController usernameCtrl;
  TextEditingController emailCtrl;
  TextEditingController phoneCtrl;
  bool isAutoValid = false;


  DateTime selectedDate;
  Validation validation = Validation();


  openDatePciekr(BuildContext context)async{
    DateTime pickeed = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day),
      lastDate: DateTime(DateTime.now().year+1),
    );
    if(pickeed != null){
      setState(() {
        selectedDate = pickeed;
      });
    }
    print(pickeed);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    email = FocusNode();
    username = FocusNode();
    phoneNumber = FocusNode();

    emailCtrl = TextEditingController();
    usernameCtrl = TextEditingController();
    phoneCtrl = TextEditingController();

  }


  onSubmit(){
    setState(()=>isAutoValid = true);
  }

  unFocus(){
    email.unfocus();
    username.unfocus();
    phoneNumber.unfocus();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    unFocus();
    email?.dispose();
    username?.dispose();
    phoneNumber?.dispose();
    emailCtrl?.dispose();
    phoneCtrl?.dispose();
    usernameCtrl?.dispose();

  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.0),
        child: AppBar(
          title: Text("${widget.title} Booking"),
        ),
      ),
      body: Stack(
        children: <Widget>[
          BackGroundImage(image: "assets/images/image1.jpg",),
          SingleChildScrollView(
            child: Form(
                key: _formKey,
                autovalidate: isAutoValid,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: MediaQuery
                          .of(context)
                          .size
                          .height / 10,),
                      Text("Booking Form", style: TextStyle(color: Colors.white,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold),),
                      SizedBox(height: 20.0,),
                      CustomTextFormField(
                        focusNode: username,
                        validator: (val)=>validation.validate("Username", val, TYPE.TEXT),
                        controller: usernameCtrl,
                        hintText: "Username",
                        onSubmitted: (val){
                          username.unfocus();
                          FocusScope.of(context).requestFocus(email);
                        },
                        textInputType: TextInputType.text,
                        textInputAction: TextInputAction.next,
                      ),
                      SizedBox(height: 10.0,),
                      CustomTextFormField(
                        controller: emailCtrl,
                        focusNode: email,
                        validator: (val)=>validation.validate("Email", val, TYPE.EMAIL),
                        onSubmitted: (val){
                          email.unfocus();
                          FocusScope.of(context).requestFocus(phoneNumber);
                        },
                        hintText: "Email",
                        textInputType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                      ),
                      SizedBox(height: 10.0,),
                      CustomTextFormField(
                        onSubmitted: (val){
                          phoneNumber.unfocus();
                        },
                        validator: (val)=>validation.validate("Phone number", val, TYPE.TEXT),
                        focusNode: phoneNumber,
                        controller: phoneCtrl,
                        hintText: "Contact no",
                        textInputType: TextInputType.phone,
                        textInputAction: TextInputAction.done,
                      ),
                      SizedBox(height: 10.0,),
                      GestureDetector(
                        onTap: () {
                          openDatePciekr(context);
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(5.0),
                          child: Container(
                            height: 50,
                            alignment: Alignment.centerLeft,
                            width: double.infinity,
                            color: Colors.white,
                            padding: EdgeInsets.all(10.0),
                            child: Text((selectedDate != null ) ? getDate(selectedDate) : "Select Date"),
                          ),
                        ),
                      ),
                      (isAutoValid & (selectedDate == null)) ?
                      Container(
                        padding: EdgeInsets.only(left: 15.0,top: 10.0),
                        alignment: Alignment.centerLeft,
                        child: Text("Please select date",style: TextStyle(color: Colors.red,fontSize: 12),),
                      ) :
                      Container(),
                      SizedBox(height: 20.0,),
                      CustomButton(
                        width: double.infinity,
                        color: primaryColor,
                        onTap: () {
                          unFocus();
                          onSubmit();
                        },
                        textStyle: TextStyle(color: Colors.white),
                        name: "Submit",
                      )
                    ],
                  ),
                )
            ),
          )
        ],
      ),
    );
  }

  String getDate(DateTime time){
    return "${time.day}/${time.month}/${time.year}";
  }
}