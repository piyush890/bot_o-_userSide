import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:our_safety_truck/loading.dart';

import 'Functions/Driver_Detalis.dart';
import 'Functions/Share_Pref.dart';
import 'Toast.dart';

class Add_Gap{
  var decod;

  void Add_Gap_(BuildContext context,act_dur_gap,is_emp_com,from_date,todate,code,gap_id){
   
   String from = '';
   String todate = '';
   Future<void> from_date() async {
   DateTime? pickedDate = await showDatePicker(
    context: context, //context of current state
    initialDate: DateTime.now(),
    firstDate: DateTime(2000), //DateTime.now() - not to allow to choose before today.
    lastDate: DateTime(2101)
);

if(pickedDate != null ){
    print(pickedDate);  //pickedDate output format => 2021-03-10 00:00:00.000
    String formattedDate = DateFormat('MM-dd-yyyy').format(pickedDate);
    _From_Date_Gap.text = formattedDate.toString();
      String formaDate = DateFormat('yyyy-MM-dd').format(pickedDate);
     from  = formaDate;
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
    _To_Date_Gap.text = formattedDate.toString();
    String formaDate = DateFormat('yyyy-MM-dd').format(pickedDate);
    todate  = formaDate;
    }
    else{
    print("Date is not selected");
}

  }
  
    String id = '';
    String company_id = '';
    String res = '';
    if (act_dur_gap.toString().isEmpty || is_emp_com.toString().isEmpty || 
    from_date.toString().isEmpty || todate.toString().isEmpty ) {
      
    }
    else{
      _During_Gap.text = act_dur_gap.toString();
      _is_Emp.text = is_emp_com.toString();
      _From_Date_Gap.text = from_date.toString();
      _To_Date_Gap.text = todate.toString();
    }
    showDialog(context: context, builder: (BuildContext context,){
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
                   controller: _During_Gap,
                  decoration: InputDecoration(
                     border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                    label: Text("Activity During Gap	"),
                  ),
                ),
                ),
                SizedBox(height: 10,),
              Container(
                padding: EdgeInsets.all(10),
                  child: TextField(
                    controller: _is_Emp,
                  decoration: InputDecoration(
                     border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                    label: Text("Is Employed by any Company	"),
                  ),
                ),
                ),
                SizedBox(height: 10,),
              Container(
                padding: EdgeInsets.all(10),
                  child: TextField(
                    controller: _From_Date_Gap,
                  decoration: InputDecoration(
                     border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                    label: Text("From Date	"),
                    suffixIcon: IconButton(onPressed: ()=>{
                      from_date()
                    }, icon: Icon(Icons.date_range_rounded))
                  ),
                ),
                ),
              
                SizedBox(height: 10,),
              Container(
                padding: EdgeInsets.all(10),
                  child: TextField(
                    controller: _To_Date_Gap,
                  decoration: InputDecoration(
                     border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                    label: Text("To Date"),
                    suffixIcon: IconButton(onPressed: ()=>{
                      To_date()
                    }, icon: Icon(Icons.date_range_rounded))
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
                      res =  await Driver_detalis().Add_Gap(_is_Emp.text.toString(), _During_Gap.text.toString(), from, todate, id, company_id),
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
                      res =  await Driver_detalis().update_Gap(_is_Emp.text.toString(), _During_Gap.text.toString(), _From_Date_Gap.text.toString(), _To_Date_Gap.text.toString(), id, company_id,gap_id),
                      decod = jsonDecode(res),
                    if(decod['status'].toString().contains("1")){
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
                  child: Text("Update Gap",style: TextStyle(color: Colors.white),)
                  ),
                
              ),
                    ],
                  ),
                )
        ],
      );
    });
  }
  final TextEditingController _During_Gap = TextEditingController();
final TextEditingController _is_Emp = TextEditingController();
final TextEditingController _From_Date_Gap = TextEditingController();
final TextEditingController _To_Date_Gap = TextEditingController();
}