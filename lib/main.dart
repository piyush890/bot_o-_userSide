import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:our_safety_truck/Check.dart';
import 'package:our_safety_truck/Functions/Login_Fuction.dart';
import 'package:our_safety_truck/Functions/Share_Pref.dart';
import 'package:our_safety_truck/HomePage.dart';
import 'package:our_safety_truck/Toast.dart';
import 'package:our_safety_truck/lin_page.dart';
import 'package:our_safety_truck/loading.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Login_Page(),
  ));
}

class Login_Page extends StatefulWidget {
  const Login_Page({super.key});

  @override
  State<Login_Page> createState() => _Login_PageState();
}

class _Login_PageState extends State<Login_Page> {
  
  
  @override
  void initState() {
    show();
    super.initState();
  }
  Future<void> show() async {
    var  n =  await SharedPreferences.getInstance();
    String id = n.getString('driver_id').toString();
    print(id);
    if(id.toString()=="null"){
            Navigator.pushAndRemoveUntil(context, new MaterialPageRoute(builder: (context)=>licence_Page()), (route) => false);
    }
    else{
        Navigator.pushAndRemoveUntil(context, new MaterialPageRoute(builder: (context)=>HomePage()), (route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        child: Center(child: Text("Please Wait Until Check"),) 
      ),
    );
  }
}
