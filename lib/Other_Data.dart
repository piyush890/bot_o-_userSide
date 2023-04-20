import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Add_Address_Dialog.dart';
import 'Functions/Address.dart';
import 'Functions/Driver_Detalis.dart';

class OtherData extends StatefulWidget {
  const OtherData({super.key});

  @override
  State<OtherData> createState() => _OtherDataState();
}

class _OtherDataState extends State<OtherData> {
  List address_li = [];

  @override
  void initState() {
    driver_address(context);
    super.initState();
  }

  void driver_address(BuildContext context) async {
    var dr_id = await SharedPreferences.getInstance();

    String? id = dr_id.getString('driver_id');
    print(id);
    dynamic response = await Driver_Address().driver_address(id.toString());
    setState(() {
      address_li = jsonDecode(response);
    });
  }

  void States(BuildContext context, String state_id) async {
    dynamic response = await Driver_detalis().states(state_id);
    var res = jsonDecode(response);
    setState(() {
      _state.text = res['state'];
    });
    print(res['state']);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Profile"),
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: address_li.length,
                  itemBuilder: (BuildContext context, index) {
                    _Address_line.text = address_li[index]['address_line_1']??"0";
                    _Address_line2.text = address_li[index]['address_line_2']??"0";
                    _City.text = address_li[index]['city']??"0";
                    String State_id = address_li[index]['state_id']??"0";
                    
                    _zip_code.text = address_li[index]['zip']??"0";
                   // States(context, State_id);
                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            controller: _Address_line,
                            decoration:
                                InputDecoration(label: Text("Address Line1")),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: EdgeInsets.all(8),
                          child: TextField(
                            controller: _Address_line2,
                            decoration: InputDecoration(
                              label: Text("Address Line2"),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: EdgeInsets.all(8),
                          child: TextField(
                            controller: _City,
                            decoration: InputDecoration(
                              label: Text("City"),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8),
                          child: TextField(
                            controller: _state,
                            decoration: InputDecoration(
                              label: Text("State"),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8),
                          child: TextField(
                            controller: _zip_code,
                            decoration: InputDecoration(
                              label: Text("Zip Code"),
                            ),
                          ),
                        ),

                        MaterialButton(onPressed: ()=>{

                        },
                        child: Text("Add Address",style: GoogleFonts.poppins(fontSize: 15,color: Colors.white),),
                        padding: EdgeInsets.all(10),
                        color: Color.fromARGB(255, 1, 10, 96),
                        )
                      ],
                    );
                  }),
            ],
          ),
        ));
  }

  final TextEditingController _Address_line = TextEditingController();
  final TextEditingController _Address_line2 = TextEditingController();
  final TextEditingController _City = TextEditingController();
  final TextEditingController _state = TextEditingController();
  final TextEditingController _zip_code = TextEditingController();
}
