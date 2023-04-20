import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:our_safety_truck/Functions/Driver_Detalis.dart';

import 'Functions/Share_Pref.dart';
import 'loading.dart';

class SAP_Program extends StatefulWidget {
  const SAP_Program({super.key});

  @override
  State<SAP_Program> createState() => _SAP_ProgramState();
}

class _SAP_ProgramState extends State<SAP_Program> {

  dynamic respo = '';
  String id = '';
  List SAP_Pro = [];
  void sap_program() async {
    id = await Share_pref().get_id();
    respo = await Driver_detalis().sap(id);
    setState(() {
      SAP_Pro = jsonDecode(respo);
    });
  }
@override
  void initState() {
    sap_program();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold
    (
      appBar: AppBar(
        title: Text("SAP Program"),
      ),
      body: Container(
        child: ListView.builder
        
          (
            itemCount: SAP_Pro.length,
            itemBuilder: (BuildContext context ,index){
          
          return  ExpansionTile(
            title: Text(SAP_Pro[index]['lic'],style: GoogleFonts.poppins(fontSize: 18),),            
            children:[ MaterialButton(onPressed: ()=>{},
            padding: EdgeInsets.all(10),
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: EdgeInsets.all(6),
                      decoration: BoxDecoration(color: Color.fromARGB(255, 64, 2, 187),
                      borderRadius: BorderRadius.circular(20)
                      ),
                      child: Text(SAP_Pro[index]['v_type'],style: TextStyle(color: Colors.white),)),
                     Text(SAP_Pro[index]['r_date'])
                  ],
                ),
              ),),
            ]
          );
        }),
      ),
    );
  }
}
