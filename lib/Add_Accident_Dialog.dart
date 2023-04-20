import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:our_safety_truck/Functions/Driver_Detalis.dart';
import 'package:our_safety_truck/Toast.dart';
import 'package:our_safety_truck/loading.dart';

import 'Functions/Share_Pref.dart';

class Add_Accident{
  void Add_Acci(BuildContext context,aci_date,fatal,description,code,accident_id){
    String respo;
    String id;
    String company_id;
    String from_date = '';
    var decod;
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
    _Accident_date.text = formattedDate.toString();
    String formaDate = DateFormat('yyyy-MM-dd').format(pickedDate);
    from_date  = formaDate;
    print(from_date);
     //formatted date output using intl package =>  2021-03-16
}else{
    print("Date is not selected");
}

  }
    if(aci_date.toString().isEmpty || fatal.toString().isEmpty || description.toString().isEmpty){

    
    }
    else{
      _Accident_date.text = aci_date.toString();
      _Fatal.text = fatal.toString();
      _Description.text = description.toString();
    }
    showDialog(context: context, builder: (BuildContext context,){
      return AlertDialog(
        title: Text("Accident"),
        actions: [
          Container(
                  child: Column(
                    children: [
                      SizedBox(height: 30,),
                       Container(
                padding: EdgeInsets.all(10),
                  child: TextField(
                    controller: _Accident_date,
                  decoration: InputDecoration(
                     border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                    label: Text("Accident Date"),
                    suffixIcon: IconButton(onPressed: ()=>{
                      From_date()
                    }, icon: Icon(Icons.date_range_rounded))
                  ),
                ),
                ),
                SizedBox(height: 10,),
              Container(
              padding: EdgeInsets.all(10),
                child: TextField(
                controller: _Fatal,
                decoration: InputDecoration(
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                  label: Text("Fatal"),
                ),
              ),
              ),
              SizedBox(height: 10,),
            Container(
              padding: EdgeInsets.all(10),
                child: TextField(
                controller: _Description,
                decoration: InputDecoration(
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                  label: Text("Description"),
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
                      respo = await Driver_detalis().Add_Accident(from_date, _Fatal.text.toString(), _Description.text.toString(),id,company_id),
                       decod = jsonDecode(respo),
                      
                      // Custom_Toast().toast_success(context, decod['status'], decod['message']),
                      if(decod['status'].toString().contains("0")){
                        Navigator.pop(context),
                        Navigator.pop(context),
                        Custom_Toast().toast_success(context, decod['status'], decod['message'])

                       }
                       else{
                        Navigator.pop(context),
                        Navigator.pop(context),
                        Custom_Toast().toast_success(context, decod['status'], decod['message'])

                       }
                    }
                    else{
                      Load().data(context),
                          id = await Share_pref().get_id(),
                      company_id = await Share_pref().get_company_id(),
                      respo = await Driver_detalis().update_Accident(_Accident_date.text.toString(), _Fatal.text.toString(), _Description.text.toString(),id,company_id,accident_id),
                       decod = jsonDecode(respo),
                        if(decod['status'].toString().contains("0")){
                        Navigator.pop(context),
                        Navigator.pop(context),
                        Custom_Toast().toast_success(context, decod['status'], decod['message']+"Please refresh"),


                       }
                       else{
                        Navigator.pop(context),
                        Navigator.pop(context),
                        Custom_Toast().toast_success(context, decod['status'], decod['message'])

                       }

                    }
                    },
                  child: Text("Update Accident",style: TextStyle(color: Colors.white),)
                  ),
                
              ),
                    ],
                  ),
                )
        ],
      );
    });
  }
  final TextEditingController _Accident_date = TextEditingController();
final TextEditingController _Fatal = TextEditingController();
final TextEditingController _Description= TextEditingController();

            
}