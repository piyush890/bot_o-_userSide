import 'dart:io';
import 'dart:math';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'Upload_Page.dart';

class Add_Doc extends StatefulWidget {
  const Add_Doc({super.key});

  @override
  State<Add_Doc> createState() => _Add_DocState();
}

class _Add_DocState extends State<Add_Doc> {
  List doc_type = [
    'License',
    'Clearning House',
    'EPN',
    'Medical Card'
    ];
    final ImagePicker picker = ImagePicker();
    File? image;
    File? picture;
  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    //File image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        image = File(pickedFile.path);
      } else {
        print('No image selected');
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: Column(
          children: [
             Container(
                        padding: EdgeInsets.all(10),
                        child:  DropdownButtonFormField(
                         // value: _Endorsement_controller.text.toString(),
                     hint: Text("Select Document Type "),
                    items: doc_type.map((e){
                       
                      return DropdownMenuItem(
                        
                        value: e,
                        child: Container(
                 
                          child: Text(e)));
                    }).toList(), onChanged: (value) { 
                      type.text = value.toString();
                     }, 
                  
                  )
              
                      ),

                      Container(
                        padding: EdgeInsets.all(10),
                        child: Row(
                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            FloatingActionButton(
                              heroTag: "1",
                              onPressed: () async =>{      
                                 await availableCameras().then(
                         (value) => Navigator.push(context, MaterialPageRoute(builder: (context)=>CameraPage(cameras: value, doctype: type,)))),
                                },
                            child: Icon(Icons.camera),
                            ),
                            
                            FloatingActionButton(
                              heroTag: "2",
                              onPressed: () async =>{
                                 
                                 getImage()
                      
                             
                            },
                            child: Icon(Icons.photo),
                            ),

                          ],
                        ),
                      ),

              if (picture != null)
              Image.file(
                File(picture!.path),
                height: 90,
              ),
          ],
        ),
      ),
    );
  }
  TextEditingController type = TextEditingController();
}