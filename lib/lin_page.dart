import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:our_safety_truck/Register_Driver.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Functions/Login_Fuction.dart';
import 'Functions/Share_Pref.dart';
import 'HomePage.dart';
import 'Toast.dart';
import 'loading.dart';

class licence_Page extends StatefulWidget {
  const licence_Page({super.key});

  @override
  State<licence_Page> createState() => _licence_PageState();
}

class _licence_PageState extends State<licence_Page> {
  TextEditingController licence_no = TextEditingController();
  TextEditingController password = TextEditingController();
  Future<void> Login_Driver() async {      
    Load().data(context);
    if(licence_no.text.isEmpty ){
      Navigator.pop(context);
      return Custom_Toast().toast_error(context, "Error", "Enter Licence Number");
    }
    if(password.text.isEmpty ){
      Navigator.pop(context);
      return Custom_Toast().toast_error(context, "Error", "Enter Password");
    }
    else{
      String response = await LoginFunction().driver_login(licence_no.text.toString(),password.text.toString());
      var decoded_data = jsonDecode(response);
      String status = decoded_data['status'];
     
     
      
      if(status.contains('1')){
          String status = decoded_data['status'];
      String message = decoded_data['message'];
      String driver_id = decoded_data['driver_id'];
      String company_id = decoded_data['company_id'];
      String name = decoded_data['name'];
         Share_pref().Set_ID(driver_id,company_id,name);
        Navigator.pop(context);
        Navigator.pushAndRemoveUntil(context, new MaterialPageRoute(builder: (context)=>HomePage()), (route) => false);
       Custom_Toast().toast_success(context, status, message);
      }
      else{
          String status = decoded_data['status'];
      String message = decoded_data['message'];
     
        Navigator.pop(context);
              Custom_Toast().toast_error(context, status, message);
      }
    }
  }
  
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        actions:[  Container(
              padding: EdgeInsets.all(10),
          child: OutlinedButton(
                    
                    onPressed: ()=>{
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>Register_Driver()))
                   },
                  
                   child: Text("Register",style: GoogleFonts.poppins(fontSize: 14,color: Colors.black),),
                   style: OutlinedButton.styleFrom(
                    side: BorderSide(color: Colors.black),
                   ),
                   ),
        )]
                 ),
                 
      resizeToAvoidBottomInset: false,
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(child: LottieBuilder.asset('assets/images/truck.json')),
            Expanded(child: Container(
              padding: EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    child: TextField(
                      controller: licence_no,
                     decoration: InputDecoration(
                      enabled: true,
                       enabledBorder: OutlineInputBorder(
                         borderRadius: BorderRadius.circular(5)
                       ),
                        hintText: 'Enter licence Number',
                        labelText: 'Driving licence Number',
                        
                     ),
                    ),
                  ),
                  Container(
                    child: TextField(
                      controller: password,
                     decoration: InputDecoration(
                      enabled: true,
                       enabledBorder: OutlineInputBorder(
                         borderRadius: BorderRadius.circular(5)
                       ),
                        hintText: 'Enter Password ',
                        labelText: 'Password',
                        
                     ),
                    ),
                  ),
             OutlinedButton(
                  
                  onPressed: ()=>{
                  Login_Driver()
                 },
                
                 child: Text(" Login",style: GoogleFonts.poppins(fontSize: 19,color: Colors.black),),
                 style: OutlinedButton.styleFrom(
                  side: BorderSide(color: Colors.black),
                 ),
                 )
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }
}