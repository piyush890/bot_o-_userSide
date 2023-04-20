import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:our_safety_truck/Functions/Driver_Detalis.dart';
import 'package:our_safety_truck/Toast.dart';
import 'package:our_safety_truck/loading.dart';

import 'Functions/Login_Fuction.dart';

class Register_Driver extends StatefulWidget {
  const Register_Driver({super.key});

  @override
  State<Register_Driver> createState() => _Register_DriverState();
}

class _Register_DriverState extends State<Register_Driver> {
  Future<void> Register_drivers() async {
    Load().data(context);
    if (FirstName.text.toString().isEmpty ||  
    LastName.text.toString().isEmpty || Email.text.toString().isEmpty || Password.text.toString().isEmpty || 
    licenseNo.text.toString().isEmpty) {
      Navigator.pop(context);
     Custom_Toast() .toast_warning(context, "!", "Enter Proper All Detalis"); 
    }
    else{
      String response = await Driver_detalis().registerdriver(FirstName.text.toString(),middleName.text.toString(),LastName.text.toString(),Email.text.toString(),Password.text.toString(),Company_ID.text.toString(),licenseNo.text.toString());
      var res = jsonDecode(response);
      if (res['status'].toString().contains("0")) {
        Navigator.pop(context);
        Navigator.pop(context);
        Custom_Toast().toast_success(context, "Done", res['message']);
      }
      else{
         Navigator.pop(context);
        Navigator.pop(context);
        Custom_Toast().toast_success(context, "Error", res['message']);
      }
     }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(title: Text("Back to Login "),
      
      ),

      body: Container(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
                        children: [
                          SizedBox(height: 5,),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextField(
                              controller: FirstName,
                              decoration:
                                  InputDecoration(label: Text("First Name")),
                            ),
                          ),
                          SizedBox(height: 10,),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextField(
                              controller: middleName,
                              decoration:
                                  InputDecoration(label: Text("Middle")),
                            ),
                          ),
                          SizedBox(height: 10,),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextField(
                              controller: LastName,
                              decoration:
                                  InputDecoration(label: Text("Last Name")),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: EdgeInsets.all(8),
                            child: TextField(
                              controller: Email,
                              decoration: InputDecoration(
                                label: Text("Email"),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: EdgeInsets.all(8),
                            child: TextField(
                              controller: Password,
                              decoration: InputDecoration(
                                label: Text("Password"),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: EdgeInsets.all(8),
                            child: TextField(
                              controller: Company_ID,
                              decoration: InputDecoration(
                                label: Text("Company_ID"),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: EdgeInsets.all(8),
                            child: TextField(
                              controller: licenseNo,
                              decoration: InputDecoration(
                                label: Text("Licence No."),
                              ),
                            ),
                          ),
        
                          MaterialButton(onPressed: ()=>{
                            Register_drivers()
                          },
                          
                          child: Text("Submit",style: GoogleFonts.poppins(fontSize: 15,color: Colors.white),),
                          padding: EdgeInsets.all(20),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          color: Color.fromARGB(255, 1, 10, 96),
                          )
                        ],
                      ),
        ),
      ),
    );
  }
   final TextEditingController FirstName = TextEditingController();
   final TextEditingController middleName = TextEditingController();
   final TextEditingController LastName = TextEditingController();
  final TextEditingController Email = TextEditingController();
  final TextEditingController Password = TextEditingController();
  final TextEditingController licenseNo = TextEditingController();
  final TextEditingController Company_ID = TextEditingController();
}