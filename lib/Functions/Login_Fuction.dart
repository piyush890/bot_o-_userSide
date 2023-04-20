import 'dart:convert';

import 'package:http/http.dart' as http;

import '../BaseURL.dart';
class LoginFunction{
  Future<String> driver_login(String driving_lin_no,password) async {
    var response;
    response = await http.post(
         Uri.parse(URLs.LOGIN),
         body: jsonEncode({
           "driving_lin":driving_lin_no,
           "password":password
         })
        );
        var jsonbody = jsonDecode(response.body);
         String body = response.body;
    return body;
  }

  // Future<String> login(String email,String password,String key,String ip) async {
  //   var response;
  //   response = await http.post(
  //        Uri.parse(URLs.LOGIN),
  //        body: jsonEncode({
  //           "email":email,
  //           "password":password,
  //           "ip_address":ip,
  //           "auth_key":key
  //        })
  //       );
  //       String jsonbody = response.body;
 
  //   return jsonbody;
  // }
}