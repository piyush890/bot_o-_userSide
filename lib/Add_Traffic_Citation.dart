import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:our_safety_truck/Functions/Driver_Detalis.dart';
import 'package:our_safety_truck/loading.dart';

import 'Functions/Address.dart';
import 'Functions/Share_Pref.dart';
import 'Toast.dart';

class Add_Traffic_Citation{
  var decod;

  void Add_Traffic(BuildContext context, cit_date,location,cit_no,type_of_cit,code,traffic_id){
   String id;
      String company_id;
      String res;
      String from_date = '';
      String to_date = '';

      Future<void> citation_date() async {
        DateTime? pickedDate = await showDatePicker(
    context: context, //context of current state
    initialDate: DateTime.now(),
    firstDate: DateTime(2000), //DateTime.now() - not to allow to choose before today.
    lastDate: DateTime(2101)
);

if(pickedDate != null ){
    print(pickedDate);  //pickedDate output format => 2021-03-10 00:00:00.000
    String formattedDate = DateFormat('MM-dd-yyyy').format(pickedDate);
    _Citation_date.text = formattedDate.toString();
     String formaDate = DateFormat('yyyy-MM-dd').format(pickedDate);
    from_date  = formaDate;
}else{
    print("Date is not selected");
}
      }
   
    if (cit_date.toString().isEmpty || location.toString().isEmpty || cit_no.toString().isEmpty || type_of_cit.toString().isEmpty) {
      
    }
    else{
      _Citation_date.text = cit_date.toString();
      _Location.text = location.toString();
      _Citation_no.text = cit_no.toString();
      _Type_Citation.text = type_of_cit.toString();
    }
    showDialog(context: context, builder: (BuildContext context){
      return AlertDialog(
        title: Text("Update Experience"),
        actions: [
          Container(
                  child: Column(
                    children: [
                      SizedBox(height: 30,),
                       Container(
                padding: EdgeInsets.all(10),
                  child: TextField(
                    controller: _Citation_date,
                  decoration: InputDecoration(
                      suffixIcon: IconButton(onPressed: ()=>{
                      citation_date()
                    }, icon: Icon(Icons.calendar_month_rounded)),
                     border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                    label: Text("Citation Date"),
                  ),
                ),
                ),
                SizedBox(height: 10,),
              Container(
                padding: EdgeInsets.all(10),
                  child: TextField(
                    controller: _Location,
                  decoration: InputDecoration(
                     border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                    label: Text("Location"),
                  ),
                ),
                ),
                SizedBox(height: 10,),
              Container(
                padding: EdgeInsets.all(10),
                  child: TextField(
                    controller: _Citation_no,
                  decoration: InputDecoration(
                  
                     border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                    label: Text("Citation Number"),
                  ),
                ),
                ),
              
                SizedBox(height: 10,),
              Container(
                padding: EdgeInsets.all(10),
                  child: TextField(
                    controller: _Type_Citation,
                  decoration: InputDecoration(
                     border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                    label: Text("Type of Citation"),
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
                      res =  await Driver_detalis().Add_traffic_cit(from_date,_Location.text.toString(),_Citation_no.text.toString(), _Type_Citation.text.toString(), id,company_id),
                       decod = jsonDecode(res),
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
                      res =  await Driver_detalis().update_traffic_cit(from_date,_Location.text.toString(),_Citation_no.text.toString(), _Type_Citation.text.toString(), id,company_id,traffic_id),
                      decod = jsonDecode(res),
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
                    },
                  child: Text("Update Traffic Citation",style: TextStyle(color: Colors.white),)
                  ),
                
              ),
                    ],
                  ),
                )
                       
                       ],
      );
    });
  }
  final TextEditingController _Citation_date = TextEditingController();
final TextEditingController _Location = TextEditingController();
final TextEditingController _Citation_no = TextEditingController();
final TextEditingController _Type_Citation = TextEditingController();
}