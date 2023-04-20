import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class Load{
  
  void data(BuildContext context) {
  
  showDialog(
       //isDismissible: false,
        //shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10))),
    context: context, builder: (BuildContext context){
    return Scaffold(
      body: Center(
        child: Container(
          
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container
              (width: 200,
              
                child: LottieBuilder.asset('assets/images/loading.json')),
              SizedBox(width: 20,),
              Container( child: Text('Please Wait ',style: GoogleFonts.poppins(fontSize: 15,fontWeight: FontWeight.w700,color: Colors.blue),),)
            ],
          ),
        ),
      ),
    );
  });
}
}
