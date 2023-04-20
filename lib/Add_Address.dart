import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:our_safety_truck/Add_Address_Dialog.dart';

import 'Functions/Address.dart';
import 'Functions/Driver_Detalis.dart';
import 'Functions/Share_Pref.dart';
import 'Toast.dart';
import 'loading.dart';

class Address extends StatefulWidget {
  const Address({super.key});

  @override
  State<Address> createState() => _AddressState();
}

class _AddressState extends State<Address> {

      void initState() {
    
    WidgetsBinding.instance.addPostFrameCallback((_) {
   states();
    });
    super.initState();

  }
  List _states =[];
     var res;
     String id = '';
     String company_id = '';
     var respo;

   Future<void> states() async {
     var driver_states = await Driver_detalis().All_states();
       var decode_response = jsonDecode(driver_states);
      setState(() {
         _states = decode_response;
      });
   }  
   Future<void> Addr() async {
     if(_Address_line1.text.toString().isEmpty){
                        Custom_Toast().toast_error(context, "!", "Enter Address Line1 ");
                        return;
    }
     if(_Address_line2.text.toString().isEmpty){
                        Custom_Toast().toast_error(context, "!", "Enter Address Line2 ");
                        return;
    }
    
     if(_City.text.toString().isEmpty){
                        Custom_Toast().toast_error(context, "!", "Enter City ");
                        return;
    }
     if(_state.text.toString().isEmpty){
                        Custom_Toast().toast_error(context, "!", "Enter State ");
                        return;
    }
     if(_zip_code.text.toString().isEmpty){
                        Custom_Toast().toast_error(context, "!", "Enter ZipCode ");
                        return;
    }
     if(_Country.text.toString().isEmpty){
                        Custom_Toast().toast_error(context, "!", "Enter Country ");
                        return;
    }
    else{

                      Load().data(context);
                        id = await Share_pref().get_id();
                      company_id = await Share_pref().get_company_id();
                      res =  await Driver_Address().add_driver_address(id,_Address_line1.text.toString(),_Address_line2.text.toString(), company_id,_City.text.toString(), _state.text.toString(), _Country.text.toString(), _zip_code.text.toString());
                      respo = jsonDecode(res);
                       if(respo['status'].toString().contains("0")){
                        Navigator.pop(context);
                  
                        Custom_Toast().toast_success(context, respo['status'], respo['message']);

                       }
                       else{
                        Navigator.pop(context);
                        Navigator.pop(context);
                        Custom_Toast().toast_success(context, respo['status'], respo['message']);

                       }
    }
   }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
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
                     
                      
                      Container(
                padding: EdgeInsets.all(10),
                alignment: Alignment.center,
                child:  MaterialButton(
                    padding: EdgeInsets.all(15),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                    color: Color.fromARGB(255, 1, 10, 96),
                   
                    onPressed: () async =>{
                      Addr()
                      
                      
                    },
                  child: Text("Submit  Address",style: TextStyle(color: Colors.white),)
                  ),
                
              ),
                    ],
                  ),
    );
  }
   final TextEditingController _Address_line1 = TextEditingController();
 final TextEditingController _Address_line2 = TextEditingController();
final TextEditingController _City = TextEditingController();
final TextEditingController _state = TextEditingController();
final TextEditingController _zip_code = TextEditingController();
final TextEditingController _Country = TextEditingController();
}