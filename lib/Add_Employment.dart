import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';
import 'package:our_safety_truck/loading.dart';

import 'Functions/Driver_Detalis.dart';
import 'Functions/Share_Pref.dart';
import 'Toast.dart';

class Add_Employment extends StatefulWidget {
  dynamic pcompany_name,email,from_date,to_date,Leave_Reason,code,id;
   Add_Employment({super.key,required this.from_date,required this.email,required this.to_date,required this.Leave_Reason,required this.code,required this.id});

  @override
  State<Add_Employment> createState() => _Add_EmploymentState();
}

class _Add_EmploymentState extends State<Add_Employment> {
  var decod;

 

 @override
  void initState() {
    get_state();
    super.initState();

  }
  bool? _is_done = false;
  bool? _is_don2 = false;
  String id = '';
      String company_id ='';
      String res = '';
  String fmcsrs = '';
  String anydot = '';
  String states = ''; 
  String from = '';
  String todate = '';
   
    List _states =[];
    Future<void> get_state() async {
       var driverStates = await Driver_detalis().All_states();
       var decodeResponse = jsonDecode(driverStates);
       print(decodeResponse);
     setState(() {
       _states = decodeResponse;
     });
    }
 
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
    _To_Date.text = formattedDate.toString();
      String formaDate = DateFormat('yyyy-MM-dd').format(pickedDate);
      todate  = formaDate;
}else{
    print("Date is not selected");
}

  }
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar( title: Text("Add Employment"),),
        body: Container(
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: TextField(
                controller: _Company_Name,
                decoration: InputDecoration(
                  border:
                      OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                  label: Text("Company Name"),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: TextField(
                controller: _Email,
                decoration: InputDecoration(
                  border:
                      OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                  label: Text("Email"),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: TextField(
                controller: _From_Date,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    label: Text("From date"),
                    suffixIcon: IconButton(
                        onPressed: () => {
                          From_date()
                        },
                        icon: Icon(Icons.date_range_rounded))),
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: TextField(
                controller: _To_Date,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    label: Text("To Date"),
                    suffixIcon: IconButton(
                        onPressed: () => {
                          To_date() 
                        },
                        icon: Icon(Icons.date_range_rounded))),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: TextField(
                controller: _Position,
                decoration: InputDecoration(
                  border:
                      OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                  label: Text("Position"),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: TextField(
                controller: _Phone,
                decoration: InputDecoration(
                  border:
                      OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                  label: Text("Phone"),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: TextField(
                controller: _Contact_person,
                decoration: InputDecoration(
                  border:
                      OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                  label: Text("Contact Person"),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: TextField(
                controller: _Leave_Reason,
                decoration: InputDecoration(
                  border:
                      OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                  label: Text("Leaving Reason"),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: TextField(
                controller: address1,
                decoration: InputDecoration(
                  border:
                      OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                  label: Text("Address Line1"),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: TextField(
                controller: address2,
                decoration: InputDecoration(
                  border:
                      OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                  label: Text("Address Line2"),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: TextField(
                controller: city,
                decoration: InputDecoration(
                  border:
                      OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                  label: Text("City"),
                ),
              ),
            ),
             SizedBox(height: 20,),
                      Container(
                        padding: EdgeInsets.all(10),
                        child:  DropdownButtonFormField(
                          
                     hint: Text("Select State"),
                    items: _states.map((e){

                      return DropdownMenuItem(
                        
                        value: e['id'],
                        child: Container(
                          child: Text(e['name'])));
                    }).toList(), onChanged: (value) { 
                              setState(() {
                                states = value.toString();
                              });
                     }, 
                  
                  )
              
                      ),
            SizedBox(
              height: 10,
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: TextField(
                controller: zipcode,
                decoration: InputDecoration(
                  border:
                      OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                  label: Text("Zip Code"),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: TextField(
                controller: fax,
                decoration: InputDecoration(
                  border:
                      OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                  label: Text("Fax"),
                ),
              ),
            ),
                          Container(
                 padding: EdgeInsets.all(10.0),
                  child: Row(
                    children: <Widget>[
                      Checkbox(value: _is_done,
                          activeColor: Colors.green, 
                          onChanged: (value) { 
                               setState(() {
                                 _is_done = value;
                                 if (_is_done == true) {
                                  fmcsrs  = "yes";
                                 }
                                 else{
                                  fmcsrs = "no";
                                 }
                               });
                           },
                     ),
                     Text("You were subject to FMCSR while employed?")
                    ],
                  ),
                ),
                          Container(
                 padding: EdgeInsets.all(10.0),
                  child: Row(
                    children: <Widget>[
                      Checkbox(value: _is_don2,
                          activeColor: Colors.green, 
                          onChanged: (bool? value) { 
                               setState(() {
                                 _is_don2 = value;
                                 if (_is_done == true) {
                                  anydot  = "yes";
                                 }
                                 else{
                                  anydot = "no";
                                 }
                               });
                           },
                     ),
                     Container(
                      width: 200,
                      child: Text("Your job designated as safety senstive fuction in any DOT?"))
                    ],
                  ),
                ),
            Container(
              padding: EdgeInsets.all(10),
              alignment: Alignment.center,
              child: MaterialButton(
                  padding: EdgeInsets.all(15),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4)),
                  color: Color.fromARGB(255, 1, 10, 96),
                  onPressed: () async => {
                    if(widget.code.toString().contains("0")){
                        Load().data(context),
                        id = await Share_pref().get_id(),
                      company_id = await Share_pref().get_company_id(),
                      res =  await Driver_detalis().Add_Employment(_Company_Name.text.toString(),
                      _Contact_person.text.toString(),company_id,id,_Email.text.toString(),
                      _Position.text.toString(),fax.text.toString(),
                      from,todate,
                      _Phone.text.toString(),city.text.toString(),states,
                      zipcode.text.toString(),
                      fmcsrs,
                      anydot,_Leave_Reason.text.toString(),
                      address1.text.toString(),
                      address2.text.toString()),
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
                    //  res =  await Driver_detalis().update_traffic_cit(_Citation_date.text.toString(),_Location.text.toString(),_Citation_no.text.toString(), _Type_Citation.text.toString(), id,company_id,traffic_id),
                      Navigator.pop(context)
                      }
                  },
                  child: Text(
                    "Update Employment",
                    style: TextStyle(color: Colors.white),
                  )),
            ),
          ],
        ),
      ),
    )
    );
  }
    final TextEditingController _Company_Name = TextEditingController();
final TextEditingController _Email = TextEditingController();
final TextEditingController _From_Date = TextEditingController();
final TextEditingController _To_Date= TextEditingController();
final TextEditingController _Leave_Reason = TextEditingController();
final TextEditingController _Position = TextEditingController();
final TextEditingController _Phone = TextEditingController();
final TextEditingController _Contact_person = TextEditingController();
final TextEditingController address1 = TextEditingController();
final TextEditingController address2 = TextEditingController();
final TextEditingController state= TextEditingController();
final TextEditingController city = TextEditingController();
final TextEditingController zipcode = TextEditingController();
final TextEditingController fax = TextEditingController();
}
