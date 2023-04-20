import 'dart:convert';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:our_safety_truck/Add_Doc.dart';
import 'package:our_safety_truck/Toast.dart';
import 'package:our_safety_truck/Upload_Page.dart';
import 'package:our_safety_truck/loading.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import 'Functions/Driver_Detalis.dart';

class Document_Upload extends StatefulWidget {
  const Document_Upload({super.key});

  @override
  State<Document_Upload> createState() => _Document_UploadState();
}

class _Document_UploadState extends State<Document_Upload> {
  List Doc_ = [
    'Medical Card',
    'EPN',
    'Clearinghouse',
    'license',
  ];




List doc_list = [];
var accident_li;
String imuplo = '';
String name = '';
String url = 'https://philgenx.setupexperts.com/OurTruckApp/Driver_APIs/assets/';   

void driver_Accident(BuildContext context) async {
 Load().data(context);
  var dr_id = await SharedPreferences.getInstance();
  
String? id = dr_id.getString('driver_id');

dynamic response = await Driver_detalis().driver_doc(id.toString());
setState(() {
  accident_li  = jsonDecode(response);
  setState(() {
    doc_list = accident_li;
    Navigator.pop(context);
  });
});
}
  void initState() {
   
 
    WidgetsBinding.instance.addPostFrameCallback((_) {
     driver_Accident(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: ()=>{
            Navigator.push(context,MaterialPageRoute(builder: (context)=>Add_Doc()))
          }, icon: Icon(Icons.add_a_photo))
        ],
      ),
      body: ListView.builder(
        itemCount: doc_list.length,
        itemBuilder: (BuildContext context,index){
        return Container(
        margin: EdgeInsets.only(top: 10),
        child:  Container(
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  alignment: Alignment.centerLeft,
                  child: Text(doc_list[index]['document_type'],style: GoogleFonts.poppins(fontSize: 17,fontWeight: FontWeight.w600,color: Color.fromARGB(170, 0, 0, 0)),)),
                
                Container(
                  padding: EdgeInsets.all(10),
                  alignment: Alignment.centerRight,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                       IconButton(onPressed: () async =>{
                            await launchUrl(Uri.parse(url+doc_list[index]['upload'])),
                     }, icon: Icon(Icons.remove_red_eye_rounded,color: Color.fromARGB(170, 0, 0, 0),)),
                       IconButton(onPressed: ()=>{

                       }, icon: Icon(Icons.download,color: Color.fromARGB(170, 0, 0, 0),)),
                       IconButton(onPressed: () async =>{
                          await availableCameras().then(
                         (value) => Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>CameraPage(cameras: value, doctype: 'License',)), (route) => false))
                         }, icon: Icon(Icons.upload_file_rounded,color: Color.fromARGB(170, 0, 0, 0),))
                  ],),
                ),
                Divider(thickness: 2,),
              ],
            ),
          )
        
      );
      })
    );
  }
}