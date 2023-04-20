import 'dart:convert';
import 'dart:io';
import 'dart:math';


import 'package:camera/camera.dart';


import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';


import 'package:http/http.dart' as http;
import 'package:our_safety_truck/BaseURL.dart';
import 'package:our_safety_truck/Functions/Share_Pref.dart';
import 'package:our_safety_truck/HomePage.dart';
import 'package:our_safety_truck/Toast.dart';

import 'loading.dart';


class CameraPage extends StatefulWidget {
  final List<CameraDescription>cameras;
  final doctype;
  CameraPage({required this.cameras,super.key, required this.doctype});

  @override
  _CameraPageState createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
   late CameraController controller;

  String name = "path";
    XFile? pictureFile;
  



  @override
  void initState() {
    super.initState();

    controller = CameraController(
      widget.cameras[0],
      ResolutionPreset.ultraHigh,
    );
    controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!controller.value.isInitialized) {
      return const SizedBox(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(8),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: SizedBox(
                  height: 500,
                  width: 400,
                  child: CameraPreview(controller),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FloatingActionButton(
                    onPressed: () async {
                      try {
                        pictureFile = await controller.takePicture();
                      } catch (CameraException) {
                        print(CameraException);
                      }
                      setState(() {
                        name = pictureFile!.path;
                      });
                    },
                    child: Icon(Icons.camera),
                  ),
                ],
              ),
            ),
            if (pictureFile != null)
              Image.file(
                File(pictureFile!.path),
                height: 90,
              ),
            
            SizedBox(height: 30,),
            Container(
              alignment: Alignment.center,
              child: MaterialButton(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                padding: EdgeInsets.all(12),
                  child: Text("Upload",style: GoogleFonts.poppins(fontSize: 18,color: Colors.white),),
                  color: Colors.blueAccent,
                  onPressed: () async {
                    if(pictureFile==null){
                    }
                    else{
                     String id = await Share_pref().get_id();
                     String comp_id = await Share_pref().get_company_id();
                    print(pictureFile!.path.toString());
                       Load().data(context);
                    var request = http.MultipartRequest(
                        'POST',
                        Uri.parse(URLs.Upload));
                    request.files.add(await http.MultipartFile.fromPath(
                        'file', pictureFile!.path));
                      request.fields['doc_type'] = widget.doctype.toString();
                      request.fields['driver_id'] = id;
                      request.fields['company_id'] = comp_id;
                    

                  
                    var res = await request.send();
                    var responseBytes = await res.stream.toBytes();
                    var responseString = utf8.decode(responseBytes);
                    var data = jsonDecode(responseString);
                    String resp = data['status'];
                    print(resp);

                    if (resp.contains("0")) {
                      controller.dispose(); 
                      Navigator.pop(context);
                     // Navigator.pop(context);
                      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>HomePage()), (route) => false);
                      Custom_Toast().toast_success(context, data['status'], data['message']);    

                      
                    } else {
                      Navigator.pop(context);
                    }
                    }
                  }
                  
                  ),
            )
          ],
        ),
      ),
    );
  }
}
