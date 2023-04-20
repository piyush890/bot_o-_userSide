import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:our_safety_truck/Functions/Driver_Detalis.dart';
import 'package:our_safety_truck/loading.dart';

import 'Functions/Share_Pref.dart';
import 'Toast.dart';

class Add_Experience{
  var respo;



  void Add_Ex(BuildContext context,equip,aprox_mile,fromdate,todate,code,exper_id){
     List Equipment_li= [
      'Truck',
      'Truck/Trailer',
      'Tanker'
      ];

      if (equip.toString().isEmpty  || aprox_mile.toString().isEmpty || fromdate.toString().isEmpty ||
                  todate.toString().isEmpty) {
        
      }
      else{
     _Approx_Miles.text = aprox_mile;
      _From_Date.text = fromdate;
      _To_Date.text = todate;
      }

      String id;
      String company_id;
      String res;
      String from_date = '';
      String to_date = '';
      
      
       Future<void> From_date() async {
    DateTime? pickedDate = await showDatePicker(
    context: context, //context of current state
    initialDate: DateTime.now(),
    firstDate: DateTime(2000), //DateTime.now() - not to allow to choose before today.
    lastDate: DateTime(2101)
);

if(pickedDate != null ){
    print(pickedDate);  //pickedDate output format => 2021-03-10 00:00:00.000
    String formattedDate = DateFormat('MM-dd-yyyy').format(pickedDate);
    _From_Date.text = formattedDate.toString();
    String formaDate = DateFormat('yyyy-MM-dd').format(pickedDate);
    from_date  = formaDate;
}else{
    print("Date is not selected");
}

  }
       Future<void> To_date() async {
    DateTime? pickedDate = await showDatePicker(
    context: context, //context of current state
    initialDate: DateTime.now(),
    firstDate: DateTime(2000), //DateTime.now() - not to allow to choose before today.
    lastDate: DateTime(2101)
);

if(pickedDate != null ){
    print(pickedDate);  //pickedDate output format => 2021-03-10 00:00:00.000
    String formattedDate = DateFormat('MM-dd-yyyy').format(pickedDate);
    _To_Date.text = formattedDate.toString();
      String formaDate = DateFormat('yyyy-MM-dd').format(pickedDate);
    to_date  = formaDate;
}else{
    print("Date is not selected");
}

  }
    showDialog(context: context, builder: (BuildContext context){
     
      return AlertDialog(
        title: Text("Add Experience"),
        actions: [
          Container(
                  child: Column(
                    children: [
                      SizedBox(height: 30,),
                      Container(
                        padding: EdgeInsets.all(10),
                        child:  DropdownButtonFormField(
                          
                     hint: Text("Select Equipment Type"),
                    items: Equipment_li.map((e){

                      return DropdownMenuItem(
                        
                        value: e,
                        child: Container(
                          width: 150,
                          child: Text(e)));
                    }).toList(), onChanged: (value) { 
                      _Equipment.text = value.toString();
                     }, 
                  
                  )
              
                      ),
                SizedBox(height: 10,),
              Container(
                padding: EdgeInsets.all(10),
                  child: TextField(
                    controller: _Approx_Miles,
                  decoration: InputDecoration(
                     border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                    label: Text("Approx Miles"),
                  ),
                ),
                ),
                SizedBox(height: 10,),
              Container(
                padding: EdgeInsets.all(10),
                  child: TextField(
                    controller: _From_Date,
                  decoration: InputDecoration(
                     border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                    label: Text("From Date"),
                    suffixIcon: IconButton(icon: Icon(Icons.date_range_rounded), onPressed: () { From_date(); },)
                  ),
                ),
                ),
                SizedBox(height: 10,),
              Container(
                padding: EdgeInsets.all(10),
                  child: TextField(
                    controller: _To_Date,
                  decoration: InputDecoration(
                    suffixIcon: IconButton(icon: Icon(Icons.date_range_rounded), onPressed: () { To_date(); },),
                     border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                    label: Text("To Date"),
                  ),
                ),
                ),
                      Container(
                padding: EdgeInsets.all(10),
                alignment: Alignment.center,
                child:  MaterialButton(
                    padding: EdgeInsets.all(15),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                    color: Color.fromARGB(255, 1, 10, 96),
                   
                    onPressed: () async =>{
                    if(code.toString().contains("0")){
                      Load().data(context),
                       id = await Share_pref().get_id(),
                      company_id = await Share_pref().get_company_id(),
                      res =  await Driver_detalis().add_driver_experience_(_Equipment.text.toString(),company_id,id,_Approx_Miles.text.toString(),fromdate,todate),
                      respo = jsonDecode(res),
                      if(respo['status'].toString().contains("0")){
                        Navigator.pop(context),
                        Navigator.pop(context),
                        Custom_Toast().toast_success(context, respo['status'], respo['message'])

                       }
                       else{
                        Navigator.pop(context),
                        Navigator.pop(context),
                        Custom_Toast().toast_success(context, respo['status'], respo['message'])

                       }
                    }
                    else{
                      Load().data(context),
                       id = await Share_pref().get_id(),
                      company_id = await Share_pref().get_company_id(),
                      res =  await Driver_detalis().update_experience(_Equipment.text.toString(),company_id,id,_Approx_Miles.text.toString(),fromdate,todate,exper_id),
                      if(respo['status'].toString().contains("0")){
                        Navigator.pop(context),
                        Navigator.pop(context),
                        Custom_Toast().toast_success(context, respo['status'], respo['message'])

                       }
                       else{
                        Navigator.pop(context),
                        Navigator.pop(context),
                        Custom_Toast().toast_success(context, respo['status'], respo['message'])

                       }
                    }
                    },
                  child: Text("Add Experience",style: TextStyle(color: Colors.white),)
                  ),
                
              ),
                    ],
                  ),
                )
        ],
      );
    });
  }
final TextEditingController _Equipment = TextEditingController();
final TextEditingController _Approx_Miles = TextEditingController();
final TextEditingController _From_Date = TextEditingController();
final TextEditingController _To_Date = TextEditingController();
}