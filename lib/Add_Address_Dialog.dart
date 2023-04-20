import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:our_safety_truck/Functions/Address.dart';
import 'package:our_safety_truck/Functions/Share_Pref.dart';
import 'package:our_safety_truck/Toast.dart';
import 'package:our_safety_truck/loading.dart';

import 'Functions/Driver_Detalis.dart';

class Add_Address_{
  Future<void> Add_Address(BuildContext context,add1,add2,city,coun,zip,code,addres_id) async {
    var driver_states = await Driver_detalis().All_states();
    List _states =[];
     var res;
     String id;
     String company_id;
     var respo;
    var decode_response = jsonDecode(driver_states);
    _states = decode_response;

    if (add1.toString().isEmpty || add2.toString().isEmpty || city.toString().isEmpty
       || coun.toString().isEmpty || zip.toString().isEmpty) {
        coun = 'USA';
      
    }
    else{
      _Address_line1.text = add1;
      _Address_line2.text = add2;
      _City.text = city;
      _Country.text = 'USA';
      _zip_code.text = zip;
      

    }
    
    showDialog(context: context, builder: (BuildContext context){
      return AlertDialog(
        scrollable: true,
        title: Text("Add Address"),
        content:  Column(
                    children: [
                      SizedBox(height: 30,),
                      Container(
                        child:  TextField(
                        controller: _Address_line1,
                        decoration: InputDecoration(
                           border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                          label: Text("Address Line 1"), 
                        ),
                      ),
              
                      ),
                      SizedBox(height: 30,),
                      Container(
                        child:  TextField(
                        controller: _Address_line2,
                        decoration: InputDecoration(
                           border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                          label: Text("Address Line 2"), 
                        ),
                      ),
              
                      ),
                       SizedBox(height: 20,),
                      Container(
                        child:  TextField(
                        controller: _City,
                        decoration: InputDecoration(
                           border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                          label: Text("City"), 
                        ),
                      ),
              
                      ),
                       SizedBox(height: 20,),
                      Container(
                        child:  TextField(
                        controller: _Country,
                        decoration: InputDecoration(
                           border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                          label: Text("Country"), 
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
                          width: 150,
                          child: Text(e['name'])));
                    }).toList(), onChanged: (value) { 
                      _state.text = value.toString();
                     }, 
                  
                  )
              
                      ),
                       SizedBox(height: 20,),
                      Container(
                        child:  TextField(
                          keyboardType: TextInputType.number,
                        controller: _zip_code,
                        decoration: InputDecoration(
                           border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                          label: Text("Zip Code"), 
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
                      res =  await Driver_Address().add_driver_address(id,_Address_line1.text.toString(),_Address_line2.text.toString(), company_id,_City.text.toString(), _state.text.toString(), _Country.text.toString(), _zip_code.text.toString()),
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
                      res =  await Driver_Address().update_driver_address(id,_Address_line1.text.toString(),_Address_line2.text.toString(), company_id,_City.text.toString(), _state.text.toString(), _Country.text.toString(), _zip_code.text.toString(),addres_id),
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
                    },
                  child: Text("Submit  Address",style: TextStyle(color: Colors.white),)
                  ),
                
              ),
                    ],
                  ),
                );
          
        
      
    });
  }
 final TextEditingController _Address_line1 = TextEditingController();
 final TextEditingController _Address_line2 = TextEditingController();
final TextEditingController _City = TextEditingController();
final TextEditingController _state = TextEditingController();
final TextEditingController _zip_code = TextEditingController();
final TextEditingController _Country = TextEditingController();
}