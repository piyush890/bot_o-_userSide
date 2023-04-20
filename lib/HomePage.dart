import 'dart:convert';


import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:http/http.dart' as http;
import 'package:our_safety_truck/Add_Accident_Dialog.dart';
import 'package:our_safety_truck/Add_Address_Dialog.dart';
import 'package:our_safety_truck/Add_Employment.dart';
import 'package:our_safety_truck/Document.dart';
import 'package:our_safety_truck/Functions/Driver_Detalis.dart';
import 'package:our_safety_truck/Functions/Share_Pref.dart';
import 'package:our_safety_truck/Profile_Form.dart';
import 'package:our_safety_truck/SAP_program.dart';
import 'package:our_safety_truck/Toast.dart';
import 'package:our_safety_truck/lin_page.dart';
import 'package:our_safety_truck/loading.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}


class _HomePageState extends State<HomePage> {
@override
  void initState() {
    driver_detalis(context);
    super.initState();
  }

  String? name = '';
void driver_detalis(BuildContext context) async {
var dr_id = await SharedPreferences.getInstance();
setState(() {
   name = dr_id.getString('name');
});
}

void get_driver_detalis(BuildContext context) async {
var dr_id = await SharedPreferences.getInstance();
String? id = dr_id.getString("driver_id");
var res = await Driver_detalis().driver_detalis(id.toString());
var decoded_data = jsonDecode(res);
Navigator.push(context, MaterialPageRoute(builder: (context)=>Profile_Form(driver_data_list: decoded_data)));
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: (AppBar(
       backgroundColor: Colors.white,
        elevation: 0,
        
        bottom: PreferredSize(
           preferredSize: Size.fromHeight(50),
          child: Container(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(7.0),
                        child: Text("Hello",style: GoogleFonts.poppins(fontSize: 20,color: Color.fromARGB(255, 95, 95, 95)),),
                      ),
                        Container(
                          padding: EdgeInsets.only(left: 10),
                  child: Text(name.toString(),style: GoogleFonts.poppins(fontSize: 25,color: Color.fromARGB(255, 95, 95, 95),fontWeight: FontWeight.w600),),
                )
                    ],
                  ),
                ),
                 Container(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    children: [
                  IconButton(onPressed: ()=>{
                    Share_pref().delete(),
                    Navigator.pushAndRemoveUntil(context, new MaterialPageRoute(builder: (context)=>licence_Page()), (route) => false)
                  }, icon: Icon(Icons.logout_rounded,color: Color.fromARGB(255, 114, 114, 114),)),
                  Text("Logout")

                    ],
                  ),
                 )
              ],
            ),
          ),
        ),
      )
      
      ),
      body: Container(
        width: Size.infinite.width,
        height: Size.infinite.height,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              SizedBox(height: 10,),
               Container(
                child: Column(
                  children: [
                     Container(
                       child: Padding(
                                     padding: const EdgeInsets.all(8.0),
                                     child: MaterialButton(
                                       onPressed: () => {
                                   get_driver_detalis(context)
                                       },
                                       shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                                       padding: EdgeInsets.all(20),
                                       color: Color.fromRGBO(0, 77, 244, 1),
                                       child: Row(
                                         children: [
                        Icon(
                          Icons.edit,
                          color: Colors.white,
                          size: 30,
                        ),
                        SizedBox(
                          width: 40,
                        ),
                        Text(
                          "My Profile",
                          style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.white),
                          textAlign: TextAlign.center,
                        )
                                         ],
                                       ),
                                     ),
                                   ),
                     ),
                     Container(
                       child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: MaterialButton(
                  onPressed: () => {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>Document_Upload()))

                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  padding: EdgeInsets.all(20),
                  color: Color.fromRGBO(247, 111, 57, 1),
                  child: Row(
                    children: [
                      Icon(
                        Icons.upload_file_rounded,
                        color: Colors.white,
                        size: 30,
                      ),
                      SizedBox(
                        width: 30,
                      ),
                      Text(
                        "My Document",
                        style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.white),
                        textAlign: TextAlign.center,
                      )
                    ],
                  ),
                ),
              ),
              
                     ),
                     Container(
                       child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: MaterialButton(
                  onPressed: () => {
                     Add_Address_().Add_Address(context, "", "", "", "", "", "0", "")
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  padding: EdgeInsets.all(20),
                  color: Color.fromRGBO(247, 111, 57, 1),
                  child: Row(
                    children: [
                      Icon(
                        Icons.home,
                        color: Colors.white,
                        size: 30,
                      ),
                      SizedBox(
                        width: 30,
                      ),
                      Text(
                        "Add Address",
                        style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.white),
                        textAlign: TextAlign.center,
                      )
                    ],
                  ),
                ),
              ),
              
                     ),
                     Container(
                       child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: MaterialButton(
                  onPressed: () => {
                     Add_Accident().Add_Acci(context, "", "", "", "0", "", )

                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  padding: EdgeInsets.all(20),
                  color: Color.fromRGBO(38, 2, 138, 1),
                  child: Row(
                    children: [
                      Icon(
                        Icons.car_crash_rounded,
                        color: Colors.white,
                        size: 30,
                      ),
                      SizedBox(
                        width: 30,
                      ),
                      Text(
                        "Add Accident",
                        style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.white),
                        textAlign: TextAlign.center,
                      )
                    ],
                  ),
                ),
              ),
              
                     ),
                     Container(
                       child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: MaterialButton(
                  onPressed: () => {
               Navigator.push(context, new MaterialPageRoute(builder: (context)=>Add_Employment(from_date: "", email: "", to_date: "", Leave_Reason: "", code: "0", id: "")))
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  padding: EdgeInsets.all(20),
                color: Color.fromRGBO(0, 77, 244, 1),
                  child: Row(
                    children: [
                      Icon(
                        Icons.boy_rounded,
                        color: Colors.white,
                        size: 30,
                      ),
                      SizedBox(
                        width: 30,
                      ),
                      Text(
                        "Add Employment",
                        style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.white),
                        textAlign: TextAlign.center,
                      )
                    ],
                  ),
                ),
              ),
              
                     ),
                  ],
                ),
               ),   

               
               Container(
                child: Column(
                  children: [
                     Container(
                       child: 
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: MaterialButton(
                  onPressed: () => {
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  padding: EdgeInsets.all(20),
                  color: Color(0xFF0053C7),
                  child: Row(
                    children: [
                      Icon(
                        Icons.assistant_direction_rounded,
                        color: Colors.white,
                        size: 30,
                      ),
                      SizedBox(
                        width: 30,
                      ),
                      Container(
                        width: 200,
                        child: Text(
                          "Ability to request roadside assistance",
                          style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                      )
                    ],
                  ),
                ),
              ),
                     ),
                     Container(
                       child:  Padding(
                padding: const EdgeInsets.all(8.0),
                child: MaterialButton(
                  onPressed: () => {
                   Navigator.push(context, MaterialPageRoute(builder: (context)=>SAP_Program()))
                  // Custom_Toast().toast_warning(context, "", "Technical Problem Please Try Again Later")
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  padding: EdgeInsets.all(20),
                  color: Color.fromRGBO(247, 111, 57, 1),
                  child: Row(
                    children: [
                      Icon(
                        Icons.card_travel_rounded,
                        color: Colors.white,
                        size: 30,
                      ),
                      SizedBox(
                        width: 40,
                      ),
                      Text(
                        "SAP Program",
                        style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.white),
                        textAlign: TextAlign.center,
                      )
                    ],
                  ),
                ),
              ),
                     ),
                  ],
                ),
               ) ,   
            ],
          ),
        ),
      ),
    );
  }
}
