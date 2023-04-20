import 'dart:convert';

import 'package:http/http.dart' as http;


import '../BaseURL.dart';
class Driver_Address{

      Future<String> driver_address(String id) async {
        print(id);
    dynamic response;
    response = await http.post(
        
         Uri.parse(URLs.Driver_address),
         body: jsonEncode({
           "id":id
         }),
        );

        String res = response.body;
        
    return res;
  }
      Future<String> add_driver_address(driver_id, address1, address2, company_id, city, state, country, zipcode)async {
    dynamic response;
    response = await http.post(
        
         Uri.parse(URLs.add_address),
         body: jsonEncode({
           
              "address_line": address1.toString(),
              "address_line1": address2.toString(),
              "company_id": company_id.toString(),
              "driver_id":driver_id.toString(),
              "city": city.toString(),
              "state": state.toString(),
              "country": country.toString(),
              "zip_code":zipcode.toString()

               
         }),
        );

        String res = response.body;
        
    return res;
  }
      Future<String> update_driver_address(driver_id, address1, address2, company_id, city, state, country, zipcode,addres_id)async {
    dynamic response;
    response = await http.post(
        
         Uri.parse(URLs.address_update),
         body: jsonEncode({
           
              "address_line": address1.toString(),
              "address_line1": address2.toString(),
              "address_id":addres_id,
              "company_id": company_id.toString(),
              "driver_id":driver_id.toString(),
              "city": city.toString(),
              "state": state.toString(),
              "country": country.toString(),
              "zip_code":zipcode.toString()

               
         }),
        );

        String res = response.body;
        
    return res;
  }
  }
