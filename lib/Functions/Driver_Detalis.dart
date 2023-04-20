import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:our_safety_truck/Add_Accident_Dialog.dart';
import 'package:our_safety_truck/Add_Employment.dart';


import '../BaseURL.dart';
class Driver_detalis{

      Future<String> driver_detalis(String licenceNo) async {
    dynamic response;
    response = await http.post(
         Uri.parse(URLs.Driver_detalis),
         body: jsonEncode({
           "driver_id":licenceNo
         })
        );

        String res = response.body;
        
    return res;
  }
      Future<String> states(String state_id) async {
    dynamic response;
    response = await http.post(
         Uri.parse(URLs.states),
         body: jsonEncode({
           "state_id":state_id
         })
        );

        String res = response.body;
        
    return res;
  }
      Future<String> All_states() async {
    dynamic response;
    response = await http.get(
         Uri.parse(URLs.all_states),);

        String res = response.body;
        
    return res;
  }
      Future<String> driver_GetExperience(String id) async {
    dynamic response;
    response = await http.post(
         Uri.parse(URLs.experience),
         body: jsonEncode({
           "id":id
         })
        );

        String res = response.body;
        
    return res;
  }
      Future<String> driver_GetAccident(String id) async {
    dynamic response;
    response = await http.post(
         Uri.parse(URLs.accident),
         body: jsonEncode({
           "id":id
         })
        );

        String res = response.body;
        
    return res;
  }
      Future<String> driver_doc(String id) async {
    dynamic response;
    response = await http.post(
         Uri.parse(URLs.doc),
         body: jsonEncode({
           "id":id
         })
        );

        String res = response.body;
        
    return res;
  }
      Future<String> driver_Get_traffic_Citation(String id) async {
    dynamic response;
    response = await http.post(
         Uri.parse(URLs.traffic_citation),
         body: jsonEncode({
           "id":id
         })
        );

        String res = response.body;
        
    return res;
  }
      Future<String> driver_get_employ(String id) async {
    dynamic response;
    response = await http.post(
         Uri.parse(URLs.employment),
         body: jsonEncode({
           "id":id
         })
        );

        String res = response.body;
        
    return res;
  }
      Future<String> driver_get_gap(String id) async {
    dynamic response;
    response = await http.post(
         Uri.parse(URLs.gap),
         body: jsonEncode({
           "id":id
         })
        );

        String res = response.body;
        
    return res;
  }
      Future<String> add_driver_experience_(equipment_type,company_id,driver_id,approx_miles,from_date,to_date) async {
    dynamic response;
    response = await http.post(
         Uri.parse(URLs.add_Exp),
         body: jsonEncode({
              "equipment_type":equipment_type.toString(),
              "company_id":company_id.toString(),
              "driver_id":driver_id.toString(),
              "approx_miles":approx_miles.toString(),
              "from_date":from_date.toString(),
              "to_date":to_date.toString()
         })
        );

        String res = response.body;
        
    return res;
  }
      Future<String> Add_Accident(_Accident_date, _Fatal, _Description,id,company_id) async {
    dynamic response;
    response = await http.post(
         Uri.parse(URLs.add_Acc),
         body: jsonEncode({
                  "accident_date":_Accident_date,
                  "company_id":company_id,
                  "driver_id":id,
                  "fatal_yes_no":_Fatal,
                  "description":_Description,
         })
        );

        String res = response.body;
        
    return res;
  }
      Future<String> Add_traffic_cit(cit_date, Loc, cit_num,  type_of_cit ,id,company_id) async {
    dynamic response;
    response = await http.post(
         Uri.parse(URLs.add_traffic_Cit),
         body: jsonEncode({
                   "company_id":company_id,
                   "driver_id":id,
                    "citation_date":cit_date,
                     "location":Loc,
                      "citation_no":cit_num,
                     "type_of_citation":type_of_cit
         })
        );

        String res = response.body;
        
    return res;
  }
      Future<String> Add_Gap(company_indivdual, activity_runing_break, from_date,  to_date ,id,company_id) async {
    dynamic response;
    response = await http.post(
         Uri.parse(URLs.add_gap),
         body: jsonEncode({
                   "company_id":company_id,
                   "driver_id":id,
                    "company_indivdual":company_indivdual,
                    "activity_runing_break":activity_runing_break,
                    "from_date":from_date,
                    "to_date":to_date

                   
         })
        );

        String res = response.body;
        
    return res;
  }
      Future<String> Add_Employment(pcompany, contact_person,
       company_id,  driver_id ,email,position,fax,from_date,to_date,
       phone,city,state,zip,fmcsrs,any_dot,leaving_reason,address_lin_1,address_lin_2) async {
    dynamic response;
    response = await http.post(
         Uri.parse(URLs.add_Emp),
         body: jsonEncode({
               "pcompany_name":pcompany,
               "contact_person":contact_person,
               "company_id":company_id,
               "driver_id":driver_id,
               "email":email,
               "position":position,
               "fax":fax,
               "from_date":from_date,
               "to_date":to_date,
               "phone":phone,
               "city":city,
               "state":state,
               "zip":zip,
               "fmcsrs":fmcsrs,
               "any_dot":any_dot,
               "leaving_reason":leaving_reason,
               "address_lin_1":address_lin_1,
               "address_lin_2":address_lin_2
         })
        );

        String res = response.body;
        
    return res;
  }
      Future<String> update_experience(equipment_type,company_id,driver_id,approx_miles,from_date,to_date,exper_id) async {
    dynamic response;
    response = await http.post(
         Uri.parse(URLs.experience_update),
         body: jsonEncode({
              "exper_id":exper_id,
              "equipment_type":equipment_type.toString(),
              "company_id":company_id.toString(),
              "driver_id":driver_id.toString(),
              "approx_miles":approx_miles.toString(),
              "from_date":from_date.toString(),
              "to_date":to_date.toString()
         })
        );

        String res = response.body;
        
    return res;
  }
     Future<String> update_Accident(_Accident_date, _Fatal, _Description,id,company_id,accident_id) async {
    dynamic response;
    response = await http.post(
         Uri.parse(URLs.update_accident),
         body: jsonEncode({
                  "accident_date":_Accident_date,
                  "company_id":company_id,
                  "driver_id":id,
                  "fatal_yes_no":_Fatal,
                  "accident_id":accident_id,
                  "description":_Description,
         })
        );

        String res = response.body;
        
    return res;
  }
     Future<String> update_traffic_cit(cit_date, Loc, cit_num,  type_of_cit ,id,company_id,traffic_id) async {
    dynamic response;
    response = await http.post(
         Uri.parse(URLs.update_traffic_citation),
         body: jsonEncode({
                  "company_id":company_id,
                   "driver_id":id,
                    "citation_date":cit_date,
                     "location":Loc,
                      "citation_no":cit_num,
                     "type_of_citation":type_of_cit,
                     "traffic_id": traffic_id
         })
        );

        String res = response.body;
        
    return res;
  }
      Future<String> update_Gap(company_indivdual, activity_runing_break, from_date,  to_date ,id,company_id,gap_id) async {
    dynamic response;
    response = await http.post(
         Uri.parse(URLs.update_gap),
         body: jsonEncode({
                   "gap_id":gap_id,
                   "company_id":company_id,
                   "driver_id":id,
                    "company_indivdual":company_indivdual,
                    "activity_runing_break":activity_runing_break,
                    "from_date":from_date,
                    "to_date":to_date

                   
         })
        );

        String res = response.body;
        
    return res;
  }
      Future<String> registerdriver(FirstName, middlename, lastname,  email,password,company_id,linc) async {
    dynamic response;
    response = await http.post(
         Uri.parse(URLs.regiater),
         body: jsonEncode({
                   "firstname":FirstName,
                   "middle":middlename,
                   "lastname":lastname,
                    "company_id":company_id,
                    "linc":linc,
                    "email":email,
                    "password":password

                   
         })
        );

        String res = response.body;
        
    return res;
  }
      Future<String> form1_9ques()async {
    dynamic response;
    response = await http.get(
         Uri.parse(URLs.get_all_ques),  
        );
        String res = response.body;
    return res;
  }
      Future<String> sap(id)async {
    dynamic response;
    response = await http.post(
         Uri.parse(URLs.SAP), 
         body: jsonEncode({
          "id":id
         }) 
        );
        String res = response.body;
    return res;
  }
  }



