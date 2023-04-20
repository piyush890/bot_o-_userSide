import 'dart:convert';
import 'package:basic_utils/basic_utils.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:our_safety_truck/Add_Accident_Dialog.dart';
import 'package:our_safety_truck/Add_Address_Dialog.dart';
import 'package:our_safety_truck/Add_Employment.dart';
import 'package:our_safety_truck/Add_Experince_Dialog.dart';
import 'package:our_safety_truck/Add_Gap.dart';
import 'package:our_safety_truck/Add_Traffic_Citation.dart';
import 'package:our_safety_truck/Functions/Address.dart';
import 'package:our_safety_truck/Functions/Driver_Detalis.dart';
import 'package:our_safety_truck/Other_Data.dart';
import 'package:our_safety_truck/Toast.dart';
import 'package:radio_group_v2/radio_group_v2.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:signature/signature.dart';

import 'Add_Address.dart';
import 'Functions/Share_Pref.dart';
import 'loading.dart';

class Profile_Form extends StatefulWidget {
  var driver_data_list;
  Profile_Form({super.key, required this.driver_data_list});

  @override
  State<Profile_Form> createState() => _Profile_FormState();
}

class _Profile_FormState extends State<Profile_Form> {
  String Form_1_9 = '';
  String Form_W_4 = '';
  String Required_Ques = '';
  String radio_value = '';
  String radio_value2 = '';
  String q1 = '';
  String q2 = '';
  String q3 = '';
  String q4 = '';
  String q5 = '';
  String q6 = '';
  String q7 = '';
  String q8 = '';
  String q9 = '';
  String q10 = '';
  bool radio_selected1 = true;
  bool radio_selected2 = false;
  bool radio_selected3 = false;
  bool form_w_4_selected1 = false;
  bool form_w_4_selected2 = false;
  bool form_w_4_selected3 = false;

  String from1_9 = '0';
  String code  ='0'; 

  bool ques1 = false;
  bool ques2 = false;
  bool ques3 = false;
  bool ques4 = false;
  bool ques5 = false;
  bool ques6 = false;
  bool ques7 = false;
  bool ques8 = false;
  bool ques9 = false;
  bool ques10 = false;
  bool ques11 = false;
  bool ques12 = false;
  bool ques13 = false;
  bool ques14 = false;
  bool ques15 = false;
  bool ques16 = false;

  PageController pageController = PageController();

  String q_vehicle = '';
  String q_revoked = '';
  String q_cmv = '';
  String q_crime = '';
  String q_alcohol = '';
  String q_drugs = '';
  String q_obtains = '';
  String track_non_track = '';
  List address_li = [];

  List Experience_li = [];
  List Accident_li = [];
  List traffic_citation_li = [];
  List employment_li = [];
  List gap_li = [];
  String n = '';
  String check_vari = '';
  List form1_9 = [];
  List<String> yes_no = ["yes", "no"];
  List endorse = [
    "Tanker",
    "Doubletriple",
    "Hazmate",
    "None",
  ];
  List license_Type = [
    "Class A"
  ];
  String defaultvalue = 'selectCategorie';
  int indexs = -1;
  int indexs1 = -1;
  int indexs2 = -1;
  int indexs3 = -1;
  int indexs4 = -1;
  int indexs5 = -1;
  int indexs6 = -1;
  int indexs7 = -1;
  int pageChanged = 0;
  bool uscis_number= false;
  bool admis= false;
  bool passport= false;
  bool country_issuance = false;
  bool lin_exp = false;
  @override
  void initState() {
   
    _License_type_controller.text = 'Class A';
    WidgetsBinding.instance.addPostFrameCallback((_) {
        driver_address(context);
    driver_Experience(context);
    driver_Accident(context);
    driver_traffic_citation(context);
    driver_employment(context);
 
    form1_9ques();
    driver_Gap(context);
    get_state();
       
        data();
    });
    super.initState();
  }


    List _states =[];
     var res;
     String id = '';
     String company_id = '';
     var respo;
     var decod;


         Future<void> acci_date() async {
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
    _Accident_date.text  = formaDate;

     //formatted date output using intl package =>  2021-03-16
}else{
    print("Date is not selected");
}

  }


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
                           pageController.animateToPage(++pageChanged,
                            duration: Duration(milliseconds: 250),
                            curve: Curves.bounceInOut);
                        Custom_Toast().toast_success(context, respo['status'], respo['message']);

                       }
                       else{
                        
                        Navigator.pop(context);
                        Custom_Toast().toast_success(context, respo['status'], respo['message']);

                       }
    }
   }


   void CheckProfileform(){
    
       if(_First_Name_controller.text.toString().isEmpty){
        Custom_Toast().toast_error(context, "Error", "Enter Name");
        return;
       }
       if(_Last_Name_controller.text.toString().isEmpty){
        Custom_Toast().toast_error(context, "Error", "Enter Last Name");
        return;
       }
       if(_Email_controller.text.toString().isEmpty){
        Custom_Toast().toast_error(context, "Error", "Enter Email");
        return;
       }
       if(_Phone_controller.text.toString().isEmpty){
        Custom_Toast().toast_error(context, "Error", "Enter Phone Number");
        return;
       }
       if(_Phone_controller.text.toString().length != 10){
        Custom_Toast().toast_error(context, "Error", "Enter Valid Number");
        return;
       }
       if(_DOB_controller.text.toString().isEmpty){
        Custom_Toast().toast_error(context, "Error", "Enter Date of Birth");
        return;
       }
      
       if(_Application_date_controller.text.toString().isEmpty){
        Custom_Toast().toast_error(context, "Error", "Enter Application Date");
        return;
       }
       if(_Social_Securtiy_number_controller.text.toString().isEmpty){
        Custom_Toast().toast_error(context, "Error", "Enter Social Security Number");
        return;
       }
       if(_Social_Securtiy_number_controller.text.toString().length!=11){
        Custom_Toast().toast_error(context, "Error", "Enter Valid Social Number");
        return;
       }
       else{
         pageController.animateToPage(++pageChanged,
                            duration: Duration(milliseconds: 250),
                            curve: Curves.bounceInOut);
       }

   }
   void check1_frominfo(){
         if (from1_9.contains("2")) {

          if(_Alien_Registration_no.text.toString().isEmpty){
            Custom_Toast().toast_error(context, "!", "Enter Alien Registration");
            return;
          }
          else{
               pageController.animateToPage(++pageChanged,
                            duration: Duration(milliseconds: 250),
                            curve: Curves.bounceInOut);
          }
          return;
           
         }
     if (from1_9.contains("3")) {

          if(_Alien_Registration_no.text.toString().isEmpty){
            Custom_Toast().toast_error(context, "!", "Enter Alien Registration");
            return;
          }
          if(_lic_exp.text.toString().isEmpty){
            Custom_Toast().toast_error(context, "!", "Enter Expiration Date");
            return;
          }
          else{
               pageController.animateToPage(++pageChanged,
                            duration: Duration(milliseconds: 250),
                            curve: Curves.bounceInOut);
          }

           return;
         }
     if (from1_9.contains("1")) {

          
          
               pageController.animateToPage(++pageChanged,
                            duration: Duration(milliseconds: 250),
                            curve: Curves.bounceInOut);
        

           return;
         }
  else{
    pageController.animateToPage(++pageChanged,
                     duration: Duration(milliseconds: 250),
                     curve: Curves.bounceInOut);
  }
        
       

   }
   void CheckEmergencyForm(){
    
       if(_Emergency_name_controller.text.toString().isEmpty){
        Custom_Toast().toast_error(context, "Error", "Enter Emergency Contact Name");
        return;
       }
       if(_Relation_controller.text.toString().isEmpty){
        Custom_Toast().toast_error(context, "Error", "Enter Relation");
        return;
       }
       if(_EmPhone_controller.text.toString().isEmpty){
        Custom_Toast().toast_error(context, "Error", "Enter Phone");
        return;
       }
       if(_EmPhone_controller.text.toString().length!=10){
        Custom_Toast().toast_error(context, "Error", "Enter Valid Phone");
        return;
       }
      
       else{
         pageController.animateToPage(++pageChanged,
                            duration: Duration(milliseconds: 250),
                            curve: Curves.bounceInOut);
       }

   }
   void CheckLicenseInfo(){
    
       if(_Driver_lincense_controller.text.toString().isEmpty){
        Custom_Toast().toast_error(context, "Error", "Enter Lincense Number");
        return;
       }
       if(_state_controller.text.toString().isEmpty){
        Custom_Toast().toast_error(context, "Error", "Enter State");
        return;
       }
       if(_Expiration_date_controller.text.toString().isEmpty){
        Custom_Toast().toast_error(context, "Error", "Enter Expiration Date");
        return;
       }
       if(_Issue_date_controller.text.toString().isEmpty){
        Custom_Toast().toast_error(context, "Error", "Enter Issue Date");
        return;
       }
       if(_License_type_controller.text.toString().isEmpty){
        Custom_Toast().toast_error(context, "Error", "Enter License Type");
        return;
       }
       if(_Endorsement_controller.text.toString().isEmpty){
        Custom_Toast().toast_error(context, "Error", "Enter Endorsement");
        return;
       }
      
       else{
    
     pageController.animateToPage(++pageChanged,
                            duration: Duration(milliseconds: 250),
                            curve: Curves.bounceInOut);
    
       }

   }
   void checkaddress(){
   
    
     pageController.animateToPage(++pageChanged,
                            duration: Duration(milliseconds: 250),
                            curve: Curves.bounceInOut);
    
   }
   void checkExperience(){
     pageController.animateToPage(++pageChanged,
                            duration: Duration(milliseconds: 250),
                            curve: Curves.bounceInOut);
    
   }
   void checkaccident(){
     pageController.animateToPage(++pageChanged,
                            duration: Duration(milliseconds: 250),
                            curve: Curves.bounceInOut);
    
   } 
   void  checktraffic (){
     pageController.animateToPage(++pageChanged,
                            duration: Duration(milliseconds: 250),
                            curve: Curves.bounceInOut);
    
   } 
   void  checkemployment(){
     pageController.animateToPage(++pageChanged,
                            duration: Duration(milliseconds: 250),
                            curve: Curves.bounceInOut);
    
   } 
   void  checkgap(){
     pageController.animateToPage(++pageChanged,
                            duration: Duration(milliseconds: 250),
                            curve: Curves.bounceInOut);
    
   } 
   


  final SignatureController _controller = SignatureController(
    penStrokeWidth: 5,
    penColor: Colors.red,
    exportBackgroundColor: Colors.blue,
  );
  var _signatureCanvas;



  void driver_address(BuildContext context) async {
    var dr_id = await SharedPreferences.getInstance();

    String? id = dr_id.getString('driver_id');
//print(id);
    dynamic response = await Driver_Address().driver_address(id.toString());
    setState(() {
      address_li = jsonDecode(response);
    });
  }

  void form1_9ques() async {
    dynamic response = await Driver_detalis().form1_9ques();
    setState(() {
      form1_9 = jsonDecode(response);
    });
  }

  void driver_Experience(BuildContext context) async {
    var dr_id = await SharedPreferences.getInstance();

    String? id = dr_id.getString('driver_id');

    dynamic response =
        await Driver_detalis().driver_GetExperience(id.toString());
//print(response);
    setState(() {
      Experience_li = jsonDecode(response);
    });
  }

  void driver_Accident(BuildContext context) async {
    var dr_id = await SharedPreferences.getInstance();

    String? id = dr_id.getString('driver_id');

    dynamic response = await Driver_detalis().driver_GetAccident(id.toString());
//print(response);
    setState(() {
      _Accident_date.text = "";
      _Fatal.text = "";
      _Description.text = "";
      Accident_li = jsonDecode(response);
    });
  }

  void driver_traffic_citation(BuildContext context) async {
    var dr_id = await SharedPreferences.getInstance();

    String? id = dr_id.getString('driver_id');

    dynamic response =
        await Driver_detalis().driver_Get_traffic_Citation(id.toString());
//print(response);
    setState(() {
      traffic_citation_li = jsonDecode(response);
    });
  }

  void driver_employment(BuildContext context) async {
    var dr_id = await SharedPreferences.getInstance();

    String? id = dr_id.getString('driver_id');

    dynamic response = await Driver_detalis().driver_get_employ(id.toString());
    print(response);
    setState(() {
      employment_li = jsonDecode(response);
    });
  }

  void driver_Gap(BuildContext context) async {
    var dr_id = await SharedPreferences.getInstance();

    String? id = dr_id.getString('driver_id');

    dynamic response = await Driver_detalis().driver_get_gap(id.toString());
//print(response);
    setState(() {
      gap_li = jsonDecode(response);
    });
  }

  void States(BuildContext context, String state_id) async {
    dynamic response = await Driver_detalis().states(state_id);
    var res = jsonDecode(response);
    _state.text = res['state'];
//print(res['state']);
  }

  void Data() {
    _First_Name_controller.text =
        widget.driver_data_list[0]['firstname'] ?? "";
    _Last_Name_controller.text =
        widget.driver_data_list[0]['lastname'] ?? "";
    _Middle_Name_controller.text =
        widget.driver_data_list[0]['middle'] ?? "" ?? "";
    _Email_controller.text = widget.driver_data_list[0]['email'] ?? "";
    _Phone_controller.text =
        widget.driver_data_list[0]['phonenumber'] ?? "";
    _DOB_controller.text = widget.driver_data_list[0]['dateofbirth'] ?? "";
    _Terminate_date_controller.text =
        widget.driver_data_list[0]['terminated_date'] ?? "";
    _Application_date_controller.text =
        widget.driver_data_list[0]['application_date'] ?? "";
    _Social_Securtiy_number_controller.text =
        widget.driver_data_list[0]['social_security_number'] ?? "";
    _Emergency_name_controller.text =
        widget.driver_data_list[0]['emergency_contact_name'] ?? "";
    _EmPhone_controller.text =
        widget.driver_data_list[0]['phonenumber'] ?? "";
    _Driver_lincense_controller.text =
        widget.driver_data_list[0]['driverylicence_number'] ?? "";
    _state_controller.text = widget.driver_data_list[0]['state'] ?? "";
    _Expiration_date_controller.text =
        widget.driver_data_list[0]['expiry_date'] ?? "";
    _Issue_date_controller.text =
        widget.driver_data_list[0]['issue_date'] ?? "";
    _License_type_controller.text =
        widget.driver_data_list[0]['licence_type'] ?? "";
    _Endorsement_controller.text =
        widget.driver_data_list[0]['indorsement'] ?? "";
    _Pay_Type_controller.text =
        widget.driver_data_list[0]['pay_type'] ?? "";
    _Rate_controller.text = widget.driver_data_list[0]['rate'] ?? "";
    _Relation_controller.text =
        widget.driver_data_list[0]['relation'] ?? "";
    _Alien_Registration_no.text =
        widget.driver_data_list[0]['uscis_number'] ?? "";
    _Form_I_94_ad_no.text =
        widget.driver_data_list[0]['addmission_number'] ?? "";
    _Foreign_passport_no.text =
        widget.driver_data_list[0]['f_passport_number'] ?? "";
    _COI.text = widget.driver_data_list[0]['country_issuance'] ?? "";
    _Number_of_qualify.text =
        widget.driver_data_list[0]['w_childern_age'] ?? "";
    _Number_of_dependents.text =
        widget.driver_data_list[0]['w_dependent'] ?? "";

    radio_value = widget.driver_data_list[0]['form_opt'] ?? "";
    radio_value2 = widget.driver_data_list[0]['w_for_form'] ?? "";
    q_vehicle = widget.driver_data_list[0]['q_vehicle'] ?? "";
    q_revoked = widget.driver_data_list[0]['q_revoked'] ?? "";
    q_cmv = widget.driver_data_list[0]['q_cmv'] ?? "";
    q_crime = widget.driver_data_list[0]['q_crime'] ?? "";
    q_alcohol = widget.driver_data_list[0]['q_alcohol'] ?? "";
    q_drugs = widget.driver_data_list[0]['q_drugs'] ?? "";
    q_obtains = widget.driver_data_list[0]['q_obtains'] ?? "";
    track_non_track = widget.driver_data_list[0]['track_non_track'] ?? "";
  }

 
  
        Future<void> DateOfBirth() async {
    var datetime = await showDatePicker(
                    context: context, 
                    initialDate: DateTime.now(), 
                    firstDate: DateTime(1100),
                    lastDate: DateTime.now()).then((value){
                 
                       String dateo = value!.month.toString()+"-"+value.day.toString()+"-"+value.year.toString();
                       _DOB_controller.text  = dateo;
                       
                        
                     
                      
                    });

  }
  //       Future<void> TerminationDate() async {
  //   var datetime = await showDatePicker(
  //                   context: context, 
  //                   initialDate: DateTime.now(), 
  //                   firstDate: DateTime(1100),
  //                   lastDate: DateTime.now()).then((value){
                
  //                      String dateo = value!.day.toString()+"-"+value.month.toString()+"-"+value.year.toString();
  //                      _Terminate_date_controller.text  = dateo;
                        
                     
                      
  //                   });

  // }
        Future<void> ApplicationDate() async {
 var datetime = await showDatePicker(
                    context: context, 
                    initialDate: DateTime.now(), 
                    firstDate: DateTime(2023),
                    lastDate: DateTime(2101));
                        
                     
                      String dateo = datetime!.month.toString()+"-"+datetime.day.toString()+"-"+datetime.year.toString();
                       _Application_date_controller.text  = dateo;
                  
                    }

  
        Future<void> ExpirationDate() async {
     DateTime? pickedDate = await showDatePicker(
    context: context, //context of current state
    initialDate: DateTime.now(),
    firstDate: DateTime.now(), //DateTime.now() - not to allow to choose before today.
    lastDate: DateTime(2050)
);

if(pickedDate != null ){
    print(pickedDate);  //pickedDate output format => 2021-03-10 00:00:00.000
    String formattedDate = DateFormat('MM-dd-yyyy').format(pickedDate);
    _Expiration_date_controller.text  = formattedDate;

     
}else{
    print("Date is not selected");
}

  }
       
 Future<void> linc_expire() async {
     DateTime? pickedDate = await showDatePicker(
    context: context, //context of current state
    initialDate: DateTime.now(),
    firstDate: DateTime.now(), //DateTime.now() - not to allow to choose before today.
    lastDate: DateTime(2050)
);

if(pickedDate != null ){
    print(pickedDate);  //pickedDate output format => 2021-03-10 00:00:00.000
    String formattedDate = DateFormat('MM-dd-yyyy').format(pickedDate);
    _lic_exp.text  = formattedDate;

     
}else{
    print("Date is not selected");
}

  }
        Future<void> issueDate() async {
    var datetime = await showDatePicker(
                    context: context, 
                    initialDate: DateTime.now(), 
                    firstDate: DateTime(1100),
                    lastDate: DateTime.now()).then((value){
                 
                       String dateo = value!.month.toString()+"-"+value.day.toString()+"-"+value.year.toString();
                       _Issue_date_controller.text  = dateo;
                        
                     
                      
                    });



  }



    Future<void> get_state() async {
       var driverStates = await Driver_detalis().All_states();
       var decodeResponse = jsonDecode(driverStates);
       print(decodeResponse);
     setState(() {
       _states = decodeResponse;
     });
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: [
        IconButton(
            onPressed: () => {
                  driver_address(context),
                  driver_Experience(context),
                  driver_Accident(context),
                  driver_traffic_citation(context),
                  driver_employment(context),
                 // Data(),
             
                  driver_Gap(context),
                 
            
                  print(check_vari)
                },
            icon: Icon(Icons.refresh)),
           Padding(
             padding: const EdgeInsets.all(8.0),
             child: OutlinedButton(
              
              onPressed: () { 
                 pageController.animateToPage(--pageChanged,
                              duration: Duration(milliseconds: 250),
                              curve: Curves.bounceInOut);
              },
             child: Text("Previous",style: GoogleFonts.poppins(color: Colors.white),),),
           )
      ], title: Text("Profile")),
      body: Container(
        child: PageView(
        physics: NeverScrollableScrollPhysics(),
          controller: pageController,
          onPageChanged: (index) {
            pageChanged = index;
          },
          children: [
            Container(
              child: SingleChildScrollView(
              
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                        child: TextField(
                          controller: _First_Name_controller,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)),
                            label: Text("First Name"),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        child: TextField(
                          controller: _Middle_Name_controller,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)),
                            label: Text("Middle Name"),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        child: TextField(
                          controller: _Last_Name_controller,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)),
                            label: Text("Last Name"),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        child: TextField(
                          controller: _Email_controller,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)),
                            label: Text("Email Address"),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        child: TextField(
                          controller: _Phone_controller,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)),
                            label: Text("Phone"),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                       Container(
                        
                            child: TextField(
                              controller: _DOB_controller,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                label: Text("Date of Birth"),
                                suffixIcon: IconButton(onPressed: ()=>{
                                  DateOfBirth()
                                }, icon: Icon(Icons.calendar_month)
                                )
                              ),
                            ),
                          ),
                        
                      
                      // SizedBox(
                      //   height: 20,
                      // ),
                      
                      // Container(
                      //     child: TextField(
                      //       controller: _Terminate_date_controller,
                      //       decoration: InputDecoration(
                      //         border: OutlineInputBorder(
                      //             borderRadius: BorderRadius.circular(10)),
                      //         label: Text("Terminate Date"),
                      //         suffixIcon: IconButton(onPressed: ()=>{
                      //             TerminationDate()
                      //           }, icon: Icon(Icons.calendar_month)
                      //           )
                      //       ),
                      //     ),
                      //   ),
                      
                      SizedBox(
                        height: 20,
                      ),
                      
                         Container(
                          child: TextField(
                            controller: _Application_date_controller,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              label: Text("Application Date"),
                              suffixIcon: IconButton(onPressed: ()=>{
                                 ApplicationDate()
                                 }, icon: Icon(Icons.calendar_month)
                                )
                            ),
                          ),
                        ),
                      
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        child: TextField(
                          onSubmitted: (value) {
                             var s = StringUtils.addCharAtPosition(_Social_Securtiy_number_controller.text.toString(), "-", 3);
                            var v = StringUtils.addCharAtPosition(s, "-", 6,repeat: true);
                             setState(() {
                              _Social_Securtiy_number_controller.text = v.toString();
                             });
                          },
                          keyboardType: TextInputType.number,
                          controller: _Social_Securtiy_number_controller,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)),
                            label: Text("Social Security Number"),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: MaterialButton(
                          color: Colors.blue,
                          padding: EdgeInsets.all(15),
                          onPressed: () => {
                           CheckProfileform()
                          },
                          child: Text(
                            "Next",
                            style: GoogleFonts.poppins(
                                fontSize: 18, color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Emergency Contact Information",
                        style: GoogleFonts.poppins(
                            fontSize: 20, fontWeight: FontWeight.w600),
                      )),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    child: TextField(
                      controller: _Emergency_name_controller,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        label: Text("Emergency Contact Name"),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    child: TextField(
                      controller: _Relation_controller,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        label: Text("Relation"),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    child: TextField(
                      controller: _EmPhone_controller,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        label: Text("Phone"),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: MaterialButton(
                      color: Colors.blue,
                      padding: EdgeInsets.all(15),
                      onPressed: () => {
                       CheckEmergencyForm()
                      },
                      child: Text(
                        "Next",
                        style: GoogleFonts.poppins(
                            fontSize: 18, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "License Information",
                        style: GoogleFonts.poppins(
                            fontSize: 20, fontWeight: FontWeight.w600),
                      )),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    child: TextField(
                      controller: _Driver_lincense_controller,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        label: Text("Driver License Number"),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(height: 20,),
                      Container(
                        padding: EdgeInsets.all(10),
                        child:  DropdownButtonFormField(
                         // value: 0,
                          
                     hint: Text("Select State"),
                    items: _states.map((e){

                      return DropdownMenuItem(
                        
                        value: e['id'],
                        child: Container(
                          child: Text(e['name'])));
                    }).toList(), onChanged: (value) { 
                              setState(() {
                                defaultvalue = value.toString();
                                _state_controller.text = value.toString();
                              });
                     }, 
                  
                  )
              
                      ),
                  
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                      child: TextField(
                        controller: _Issue_date_controller,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          label: Text("Issue Date"),
                          suffixIcon: IconButton(onPressed: ()=>{
                            issueDate()
                            }, icon: Icon(Icons.calendar_month)
                                )
                        ),
                      ),
                    ),
                    SizedBox(
                    height: 20,
                  ),
                 
                     Container(
                      child: TextField(
                        controller: _Expiration_date_controller,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          label: Text("Expiration Date"),
                          suffixIcon: IconButton(onPressed: ()=>{
                                  ExpirationDate()
                                }, icon: Icon(Icons.calendar_month)
                                )
                        ),
                      ),
                    ),
                  
                  
                  
                  
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    child: TextField(
                      controller: _License_type_controller,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        label: Text("License Type"),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                 Container(
                        padding: EdgeInsets.all(10),
                        child:  DropdownButtonFormField(
                         // value: _Endorsement_controller.text.toString(),
                     hint: Text("Select Endorsements "),
                    items: endorse.map((e){
                       
                      return DropdownMenuItem(
                        
                        value: e,
                        child: Container(
                          width: 150,
                          child: Text(e)));
                    }).toList(), onChanged: (value) { 
                      _Endorsement_controller.text = value.toString();
                     }, 
                  
                  )
              
                      ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: MaterialButton(
                      color: Colors.blue,
                      padding: EdgeInsets.all(15),
                      onPressed: () => {
                       CheckLicenseInfo()
                      },
                      child: Text(
                        "Next",
                        style: GoogleFonts.poppins(
                            fontSize: 18, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
            Container(
              child: Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "1-9 Form information",
                      style: GoogleFonts.poppins(
                          fontSize: 19, fontWeight: FontWeight.w700),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Container(
                      width: Size.infinite.width,
                      padding: EdgeInsets.all(10),
                      decoration: const BoxDecoration(
                          color: Color.fromARGB(255, 186, 229, 247),
                          borderRadius: BorderRadius.all(Radius.circular(8))),
                      child: DropdownButtonFormField(
                    //  value: from1_9,
                        hint: Text("Select Situtation Type"),
                        items: form1_9.map((e) {
                          return DropdownMenuItem(
                              value: e['form_id'],
                              child: Container(
                                  width: 200, child: Text(e["1-9_Form_ques"])));
                        }).toList(),
                        onChanged: (value) {
                          from1_9 =value.toString();
                          setState(() {
                            

                            if (value.toString().contains("1")) {
                              uscis_number = false;
                              passport  = false;
                              country_issuance = false;
                              lin_exp = false;
                              return;
                            }
                            
                            if (value.toString().contains("2")) {
                              setState(() {
                              uscis_number = true;
                              passport  = false;
                              country_issuance = false;
                              lin_exp = false;
                              });
                              return;
                            }
                            
                           
                            if (value.toString().contains("3")) {
                              setState(() {
                              uscis_number = true;
                              passport  = true;
                              country_issuance = true;
                              lin_exp = true;
                              });
                              return;
                            }

                            
                          });
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Divider(
                    thickness: 1,
                    color: Color.fromARGB(201, 0, 0, 0),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    child: Text(
                        "Aliens authorized to work must provide only one of the following document numbers to complete Form I-9: An Alien Registration Number/USCIS Number OR Form I-94 Admission Number OR Foreign Passport Number."),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Visibility(
                    visible: uscis_number,
                    child: Container(
                      padding: EdgeInsets.all(10),
                      child: TextField(
                        controller: _Alien_Registration_no,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          label: Text("Alien Registration Number/USCIS Number:"),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Visibility(
                    visible: admis,
                    child: Container(
                      padding: EdgeInsets.all(10),
                      child: TextField(
                        controller: _Form_I_94_ad_no,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          label: Text("Form I-94 Admission Number:"),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Visibility(
                    visible: passport,
                    child: Container(
                      padding: EdgeInsets.all(10),
                      child: TextField(
                        controller: _Foreign_passport_no,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          label: Text("Foreign Passport Number:"),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Visibility(
                    visible: country_issuance,
                    child: Container(
                      padding: EdgeInsets.all(10),
                      child: TextField(
                        controller: _COI,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          label: Text("Country of Issuance:"),
                        ),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: lin_exp,
                    child: Container(
                      padding: EdgeInsets.all(10),
                      child: TextField(
                        onTap: ()=>{
                  
                        },
                        controller: _lic_exp,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          label: Text("Work Permit Expiry"),
                          suffixIcon: IconButton(onPressed: ()=>{
                            linc_expire()
                          }, icon: Icon(Icons.calendar_month_outlined))
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: MaterialButton(
                      color: Colors.blue,
                      padding: EdgeInsets.all(15),
                      onPressed: () => {
                        check1_frominfo()
                      },
                      child: Text(
                        "Next",
                        style: GoogleFonts.poppins(
                            fontSize: 18, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.all(15),
                      child: Text(
                        "W-4 Form Information",
                        style: GoogleFonts.poppins(
                            fontSize: 20, fontWeight: FontWeight.w600),
                      ),
                    ),
                    Container(
                      child: RadioListTile(
                        selectedTileColor: Colors.amberAccent,
                        selected: form_w_4_selected1,
                        title: Text("Single or Married filing separately."),
                        value: 'separately',
                        activeColor: Colors.black45,
                        groupValue: Form_W_4,
                        onChanged: ((value) {
                          setState(() {
                            Form_W_4 = value.toString();
                          });
                        }),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      child: RadioListTile(
                        selectedTileColor: Colors.amberAccent,
                        selected: form_w_4_selected2,
                        title: Text(
                            "Married filing jointly (or Qualifying widow(er))."),
                        value: 'lawful_permanent',
                        groupValue: Form_W_4,
                        onChanged: ((value) {
                          setState(() {
                            Form_W_4 = value.toString();
                          });
                        }),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      child: RadioListTile(
                        selected: form_w_4_selected3,
                        selectedTileColor: Colors.amberAccent,
                        title: Text("Head of household."),
                        value: 'authorized_to_work',
                        groupValue: Form_W_4,
                        onChanged: ((value) {
                          setState(() {
                            Form_W_4 = value.toString();
                          });
                        }),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      child: TextField(
                        controller: _Number_of_qualify,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          label: Text(
                              "Number of qualifying children under age 17"),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      child: TextField(
                        controller: _Number_of_dependents,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          label: Text("Number of other dependents"),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                        padding: EdgeInsets.all(10),
                        child: Text(
                          "Have you even been denied a license,permit or privilege to operate a motor vehicle?",
                          style: GoogleFonts.poppins(fontSize: 18),
                        )),
                    Padding(
                        padding: const EdgeInsets.all(20),
                        child: Row(
                          children: [
                            Expanded(
                                child: RadioGroup(
                              decoration: RadioGroupDecoration(
                                  spacing: 100,
                                  labelStyle:
                                      GoogleFonts.poppins(fontSize: 18)),
                              indexOfDefault: indexs,
                              orientation: RadioGroupOrientation.horizontal,
                              values: yes_no,
                              onChanged: (value){
                            
                                  q_mv = value.toString();
                             
                               
                              },
                            )),
                          ],
                        )),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                        padding: EdgeInsets.all(10),
                        child: Text(
                          "Has any license, permit or privilege ever been suspended or revoked?",
                          style: GoogleFonts.poppins(fontSize: 18),
                        )),
                    Padding(
                        padding: const EdgeInsets.all(20),
                        child: Row(
                          children: [
                            Expanded(
                                child: RadioGroup(
                              decoration: RadioGroupDecoration(
                                  spacing: 100,
                                  labelStyle:
                                      GoogleFonts.poppins(fontSize: 18)),
                              indexOfDefault: indexs1,
                              orientation: RadioGroupOrientation.horizontal,
                              values: yes_no,
                              onChanged: (value) {
                                
                                q_sus_rev = value.toString();
                              
                              },
                            )),
                          ],
                        )),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                        padding: EdgeInsets.all(10),
                        child: Text(
                          "Have you ever been convicted of any criminal act invoicing the use of a CMV or while driving a CMV?",
                          style: GoogleFonts.poppins(fontSize: 18),
                        )),
                    Container(
                        padding: EdgeInsets.all(10),
                        child: Row(
                          children: [
                            Expanded(
                                child: RadioGroup(
                                    decoration: RadioGroupDecoration(
                                        spacing: 100,
                                        labelStyle:
                                            GoogleFonts.poppins(fontSize: 18)),
                                    indexOfDefault: indexs2,
                                    orientation:
                                        RadioGroupOrientation.horizontal,
                                    values: yes_no,
                                    onChanged: (value) {
                                
                                q_cvm = value.toString();
                              
                              },
                                    
                                    
                                    )
                                    
                                    ),
                                    
                          ],
                        )),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                        padding: EdgeInsets.all(10),
                        child: Text(
                          "Have you ever been convicted of any serious Crime ?",
                          style: GoogleFonts.poppins(fontSize: 18),
                        )),
                    Container(
                        padding: EdgeInsets.all(10),
                        child: Row(
                          children: [
                            Expanded(
                                child: RadioGroup(
                                    decoration: RadioGroupDecoration(
                                        spacing: 100,
                                        labelStyle:
                                            GoogleFonts.poppins(fontSize: 18)),
                                    indexOfDefault: indexs3,
                                    orientation:
                                        RadioGroupOrientation.horizontal,
                                    values: yes_no,
                                    onChanged: (value){
                                      q_sc = value.toString();
                                    },
                                    ))
                          ],
                        )),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                        padding: EdgeInsets.all(10),
                        child: Text(
                          "Have you ever refused to be tested for drugs or alcohol ?",
                          style: GoogleFonts.poppins(fontSize: 18),
                        )),
                    Container(
                        padding: EdgeInsets.all(10),
                        child: Row(
                          children: [
                            Expanded(
                                child: RadioGroup(
                                    decoration: RadioGroupDecoration(
                                        spacing: 100,
                                        labelStyle:
                                            GoogleFonts.poppins(fontSize: 18)),
                                    indexOfDefault: indexs4,
                                    orientation:
                                        RadioGroupOrientation.horizontal,
                                    values: yes_no,
                                    onChanged: (value){
                                      q_drug_alco = value.toString();
                                    },
                                    ))
                          ],
                        )),
                    Container(
                        padding: EdgeInsets.all(10),
                        child: Text(
                          "Have you ever tested positive for drugs or alcohol ?",
                          style: GoogleFonts.poppins(fontSize: 18),
                        )),
                    Container(
                        padding: EdgeInsets.all(10),
                        child: Row(
                          children: [
                            Expanded(
                                child: RadioGroup(
                                    decoration: RadioGroupDecoration(
                                        spacing: 100,
                                        labelStyle:
                                            GoogleFonts.poppins(fontSize: 18)),
                                    indexOfDefault: indexs5,
                                    orientation:
                                        RadioGroupOrientation.horizontal,
                                    values: yes_no,
                                    onChanged: (value){
                                      q_drugs  = value.toString();
                                    },
                                    
                                    ))
                          ],
                        )),
                    Container(
                        padding: EdgeInsets.all(10),
                        child: Text(
                          "Have you ever tested positive for any pre-employment drug or alcohol test for a job which you applied for but did not obtain?",
                          style: GoogleFonts.poppins(fontSize: 18),
                        )),
                    Container(
                        padding: EdgeInsets.all(10),
                        child: Row(
                          children: [
                            Expanded(
                                child: RadioGroup(
                                    decoration: RadioGroupDecoration(
                                        spacing: 100,
                                        labelStyle:
                                            GoogleFonts.poppins(fontSize: 18)),
                                    indexOfDefault: indexs6,
                                    orientation:
                                        RadioGroupOrientation.horizontal,
                                    values: yes_no,
                                    onChanged: (value){
                                      q_empl  = value.toString();
                                    },
                                    ))
                          ],
                        )),
                    Container(
                        padding: EdgeInsets.all(10),
                        child: Text(
                          "If You have any experience of trucking / non trucking ?",
                          style: GoogleFonts.poppins(fontSize: 18),
                        )),
                    Container(
                        padding: EdgeInsets.all(10),
                        child: Row(
                          children: [
                            Expanded(
                                child: RadioGroup(
                                    decoration: RadioGroupDecoration(
                                        spacing: 100,
                                        labelStyle:
                                            GoogleFonts.poppins(fontSize: 18)),
                                    indexOfDefault: indexs7,
                                    orientation:
                                        RadioGroupOrientation.horizontal,
                                    values: yes_no,
                                    onChanged: (value){
                                      q_truck = value.toString();
                                    },
                                    ))
                          ],
                        )),
                    Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: MaterialButton(
                        color: Colors.blue,
                        padding: EdgeInsets.all(15),
                        onPressed: () => {
                          pageController.animateToPage(++pageChanged,
                              duration: Duration(milliseconds: 250),
                              curve: Curves.bounceInOut)
                        },
                        child: Text(
                          "Next",
                          style: GoogleFonts.poppins(
                              fontSize: 18, color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
           
           Container(
            child: Column(
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
                     
                      
                      Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: MaterialButton(
                        color: Colors.blue,
                        padding: EdgeInsets.all(15),
                        onPressed: () => {
                         Addr()
                        },
                        child: Text(
                          "Next",
                          style: GoogleFonts.poppins(
                              fontSize: 18, color: Colors.white),
                        ),
                      ),
                    ),
                    ],
                  ),
           ),
              
            Container(
              padding: EdgeInsets.all(10),
              child: Column(
                children: [
                  Divider(
                    thickness: 2,
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    alignment: Alignment.centerRight,
                    child: SizedBox(
                      width: 190,
                      child: MaterialButton(
                        padding: EdgeInsets.all(15),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4)),
                        color: Color.fromARGB(255, 1, 10, 96),
                        onPressed: () => {
                          Add_Experience()
                              .Add_Ex(context, '', '', '', '', '0', '')
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            
                            Text(
                              "Add Experience",
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Table(
                    border: TableBorder.all(
                        color: Colors.black,
                        style: BorderStyle.solid,
                        width: 1),
                    children: [
                      TableRow(children: [
                        Column(children: [
                          Text('Equipment Type	',
                          textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 19.0, fontWeight: FontWeight.w700))
                        ]),
                        Column(children: [
                          Text('Approx Miles	',
                              style: TextStyle(
                                  fontSize: 19.0, fontWeight: FontWeight.w700))
                        ]),
                        Column(children: [
                          Text('Edit', style: TextStyle(fontSize: 17.0))
                        ]),
                        // Column(children:[Text(address_li[index]['address_line_1'], style: TextStyle(fontSize: 16.0))]),
                      ]),
                    ],
                  ),
                  ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: Experience_li.length,
                    itemBuilder: (context, index) {
                      String equip =
                          Experience_li[index]['equipment_type'] ?? "null";
                      String aprox_mile =
                          Experience_li[index]['approx_miles'] ?? "null";
                      String fromdate =
                          Experience_li[index]['from_date'] ?? "null";
                      String todate = Experience_li[index]['to_date'] ?? "null";
                      String exper_id = Experience_li[index]['id'] ?? "null";
                      return Table(
                        border: TableBorder.all(
                            color: Colors.black,
                            style: BorderStyle.solid,
                            width: 1),
                        children: [
                          TableRow(children: [
                            Column(children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                    Experience_li[index]['equipment_type'] ??
                                        "null",
                                    style: TextStyle(fontSize: 17.0)),
                              )
                            ]),

                            Column(children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                    Experience_li[index]['approx_miles'] ??
                                        "null",
                                    style: TextStyle(fontSize: 17.0)),
                              )
                            ]),
                            Column(children: [
                              IconButton(
                                  onPressed: () => {
                                        Add_Experience().Add_Ex(
                                            context,
                                            equip,
                                            aprox_mile,
                                            fromdate,
                                            todate,
                                            '1',
                                            exper_id)
                                      },
                                  icon: Icon(Icons.edit)),
                            ]),
                            // Column(children:[Text(address_li[index]['address_line_1'], style: TextStyle(fontSize: 16.0))]),
                          ]),
                        ],
                      );
                    },
                  ),
                  SizedBox(height: 20,),
               Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: MaterialButton(
                      color: Colors.blue,
                      padding: EdgeInsets.all(15),
                      onPressed: () => {
                      checkExperience()
                      },
                      child: Text(
                        "Next",
                        style: GoogleFonts.poppins(
                            fontSize: 18, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    Divider(
                      thickness: 2,
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      alignment: Alignment.centerRight,
                      child: SizedBox(
                        width: 190,
                        child: MaterialButton(
                          padding: EdgeInsets.all(15),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4)),
                          color: Color.fromARGB(255, 1, 10, 96),
                          onPressed: () => {
                            Add_Accident().Add_Acci(context, '', '', '', '0', '')
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              
                              Text(
                                "Add Accident",
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: Accident_li.length,
                      itemBuilder: (context, index) {
                        String accident_date =
                            Accident_li[index]['accident_date'] ?? "null";
                        String fatal =
                            Accident_li[index]['fatal_yes_no'] ?? "null";
                        String description =
                           Accident_li[index]['description']  ?? "null";
                        String acc_id = Accident_li[index]['id'] ?? "null";
                  
                           _Accident_date.text = accident_date;
                           _Fatal.text = fatal;
                           _Description.text = description;
                
                        return  Card(
                
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Container(
                    padding: EdgeInsets.all(10),
                    child: ExpansionTile(
                      title: Text(accident_date),
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                        
                         
                             Container(
                           width: 300,
                           padding: EdgeInsets.all(10),
                             child: TextField(
                             
                             controller: _Accident_date,
                             decoration: InputDecoration(
                                 border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                               label: Text("Accident Date"),
                               suffixIcon: IconButton(onPressed: ()=>{
                                acci_date()
                               }, icon: Icon(Icons.calendar_month_outlined))
                             ),
                           ),
                           ),
                           SizedBox(height: 10,),
                             Container(
                           width: 300,
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
                           width: 300,
                           padding: EdgeInsets.all(10),
                             child: TextField(
                             controller: _Description,
                             decoration: InputDecoration(
                                 border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                               label: Text("Description"),
                             ),
                           ),
                           ),
                            
                        MaterialButton(onPressed: () async =>{
                           Load().data(context),
                          id = await Share_pref().get_id(),
                      company_id = await Share_pref().get_company_id(),
                      print(acc_id),
                      print(id),
                      print(company_id),
                      respo = await Driver_detalis().update_Accident(_Accident_date.text.toString(), _Fatal.text.toString(), _Description.text.toString(),id,company_id,acc_id),
                        decod = jsonDecode(respo),

                        if(decod['status'].toString().contains("0")){
                        Navigator.pop(context),
                         driver_Accident(context),
                        Custom_Toast().toast_success(context, decod['status'], decod['message']+"  Please refresh"),
                        

                       }
                       else{
                        Navigator.pop(context),
                        Custom_Toast().toast_success(context, decod['status'], decod['message'])

                       }
                        },child:Text("Update",style:GoogleFonts.poppins(color:Colors.white,fontSize:20)),color:Colors.blue)
                          
                            
                            
                        ],
                      ),
                    ],
                    ),
                  ),
                ),
                          );
                      },
                    ),
                    SizedBox(height: 20,),
                 Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: MaterialButton(
                        color: Colors.blue,
                        padding: EdgeInsets.all(15),
                        onPressed: () => {
                        checkaccident()
                        },
                        child: Text(
                          "Next",
                          style: GoogleFonts.poppins(
                              fontSize: 18, color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: Column(
                children: [
                  Divider(
                    thickness: 2,
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    alignment: Alignment.centerRight,
                    child: SizedBox(
                      width: 190,
                      child: MaterialButton(
                        padding: EdgeInsets.all(15),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4)),
                        color: Color.fromARGB(255, 1, 10, 96),
                        onPressed: () => {
                          Add_Traffic_Citation()
                              .Add_Traffic(context, '', '', '', '', '0', '')
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                           
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "Add Traffic Citation",
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Table(
                    border: TableBorder.all(
                        color: Colors.black,
                        style: BorderStyle.solid,
                        width: 1),
                    children: [
                      TableRow(children: [
                        Column(children: [
                          Text('Citation Date	',
                              style: TextStyle(
                                  fontSize: 19.0, fontWeight: FontWeight.w700))
                        ]),
                        Column(children: [
                          Text('Location	',
                              style: TextStyle(
                                  fontSize: 19.0, fontWeight: FontWeight.w700))
                        ]),
                        Column(children: [
                          Text('Edit', style: TextStyle(fontSize: 17.0))
                        ]),
                        // Column(children:[Text(address_li[index]['address_line_1'], style: TextStyle(fontSize: 16.0))]),
                      ]),
                    ],
                  ),
                  ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: traffic_citation_li.length,
                    itemBuilder: (context, index) {
                      String cit_date =
                          traffic_citation_li[index]['citation_date'] ?? "null";
                      String location =
                          traffic_citation_li[index]['location'] ?? "null";
                      String cit_no =
                          traffic_citation_li[index]['citation_no'] ?? "null";
                      String type_of_citation = traffic_citation_li[index]
                              ['type_of_citation'] ??
                          "null";
                      String id = traffic_citation_li[index]['id'] ?? "null";

                      return Table(
                        border: TableBorder.all(
                            color: Colors.black,
                            style: BorderStyle.solid,
                            width: 1),
                        children: [
                          TableRow(children: [
                            Column(children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                    traffic_citation_li[index]
                                            ['citation_date'] ??
                                        "null",
                                    style: TextStyle(fontSize: 17.0)),
                              )
                            ]),

                            Column(children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                    traffic_citation_li[index]['location'] ??
                                        "null",
                                    style: TextStyle(fontSize: 17.0)),
                              )
                            ]),
                            Column(children: [
                              IconButton(
                                  onPressed: () => {
                                        Add_Traffic_Citation().Add_Traffic(
                                            context,
                                            cit_date,
                                            location,
                                            cit_no,
                                            type_of_citation,
                                            '1',
                                            id)
                                      },
                                  icon: Icon(Icons.edit)),
                            ]),
                            // Column(children:[Text(address_li[index]['address_line_1'], style: TextStyle(fontSize: 16.0))]),
                          ]),
                        ],
                      );
                    },
                  ),
                  SizedBox(height: 20,),
               Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: MaterialButton(
                      color: Colors.blue,
                      padding: EdgeInsets.all(15),
                      onPressed: () => {
                      checktraffic()
                      },
                      child: Text(
                        "Next",
                        style: GoogleFonts.poppins(
                            fontSize: 18, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: Column(
                children: [
                  Divider(
                    thickness: 2,
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    alignment: Alignment.centerRight,
                    child: SizedBox(
                      width: 190,
                      child: MaterialButton(
                        padding: EdgeInsets.all(15),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4)),
                        color: Color.fromARGB(255, 1, 10, 96),
                        onPressed: () => {
                          Navigator.push(
                              context,
                              new MaterialPageRoute(
                                  builder: (context) => Add_Employment(
                                        from_date: '',
                                        email: '',
                                        to_date: '',
                                        Leave_Reason: '',
                                        code: '0',
                                        id: '',
                                      )))
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "Add Employment",
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Table(
                    border: TableBorder.all(
                        color: Colors.black,
                        style: BorderStyle.solid,
                        width: 1),
                    children: [
                      TableRow(children: [
                        Column(children: [
                          Text('Company Name',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                
                                  fontSize: 19.0, fontWeight: FontWeight.w700))
                        ]),
                        Column(children: [
                          Text('Email',
                              style: TextStyle(
                                  fontSize: 19.0, fontWeight: FontWeight.w700))
                        ]),
                        Column(children: [
                          Text('Edit', style: TextStyle(fontSize: 17.0))
                        ]),
                        // Column(children:[Text(address_li[index]['address_line_1'], style: TextStyle(fontSize: 16.0))]),
                      ]),
                    ],
                  ),
                  ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: employment_li.length,
                    itemBuilder: (context, index) {
                      String company_name =
                          employment_li[index]['pcompany_name'] ?? "";
                      String email = employment_li[index]['email'] ?? "";
                      String from_data =
                          employment_li[index]['from_date'] ?? "";
                      String To_date = employment_li[index]['to_date'] ?? "";
                      String Leave_Reason =
                          employment_li[index]['leaving_reason'] ?? "";
                      String id = employment_li[index]['id'] ?? "";
                      return Table(
                        border: TableBorder.all(
                            color: Colors.black,
                            style: BorderStyle.solid,
                            width: 1),
                        children: [
                          TableRow(children: [
                            Column(children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                    employment_li[index]['pcompany_name'] ?? "",
                                    style: TextStyle(fontSize: 17.0)),
                              )
                            ]),

                            Column(children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(employment_li[index]['email'] ?? "",
                                    style: TextStyle(fontSize: 17.0)),
                              )
                            ]),
                            Column(children: [
                              IconButton(
                                  onPressed: () => {
                                        Navigator.push(
                                            context,
                                            new MaterialPageRoute(
                                                builder: (context) =>
                                                    Add_Employment(
                                                      from_date: from_data,
                                                      email: email,
                                                      to_date: To_date,
                                                      Leave_Reason:
                                                          Leave_Reason,
                                                      code: "1",
                                                      id: id,
                                                    )))
                                      },
                                  icon: Icon(Icons.edit)),
                            ]),
                            // Column(children:[Text(address_li[index]['address_line_1'], style: TextStyle(fontSize: 16.0))]),
                          ]),
                        ],
                      );
                    },
                  ),
                  SizedBox(height: 20,),
               Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: MaterialButton(
                      color: Colors.blue,
                      padding: EdgeInsets.all(15),
                      onPressed: () => {
                      checkemployment()
                      },
                      child: Text(
                        "Next",
                        style: GoogleFonts.poppins(
                            fontSize: 18, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: Column(
                children: [
                  Divider(
                    thickness: 2,
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    alignment: Alignment.centerRight,
                    child: SizedBox(
                      width: 190,
                      child: MaterialButton(
                        padding: EdgeInsets.all(10),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4)),
                        color: Color.fromARGB(255, 1, 10, 96),
                        onPressed: () => {
                          Add_Gap().Add_Gap_(context, '', '', '', '', '0', '')
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            
                            Text(
                              "Add Gap",
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Table(
                    border: TableBorder.all(
                        color: Colors.black,
                        style: BorderStyle.solid,
                        width: 1),
                    children: [
                      TableRow(children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                          Container(
                            alignment: Alignment.center,
                            child: const Text(
                              'Activity During Gap	',
                              style: TextStyle(
                                  fontSize: 19.0, fontWeight: FontWeight.w700),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ]),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                           crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                          Text(
                            'Is Employed by any Company',
                            style: TextStyle(
                                fontSize: 19.0, fontWeight: FontWeight.w700),
                            textAlign: TextAlign.center,
                          ),
                        ]),
                        Column(children: [
                          Text('Edit', style: TextStyle(fontSize: 17.0))
                        ]),
                        // Column(children:[Text(address_li[index]['address_line_1'], style: TextStyle(fontSize: 16.0))]),
                      ]),
                    ],
                  ),
                  ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: gap_li.length,
                    itemBuilder: (context, index) {
                      String activi_durn_gap =
                          gap_li[index]['activity_runing_break'] ?? "null";
                      String is_emp_com =
                          gap_li[index]['company_indivdual'] ?? "null";
                      String from_data = gap_li[index]['from_date'] ?? "null";
                      String to_date = gap_li[index]['to_date'] ?? "null";
                      String id = gap_li[index]['id'] ?? "null";
                      return Table(
                        border: TableBorder.all(
                            color: Colors.black,
                            style: BorderStyle.solid,
                            width: 1),
                        children: [
                          TableRow(children: [
                            Column(children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                    gap_li[index]['activity_runing_break'] ??
                                        "null",
                                    style: TextStyle(fontSize: 17.0)),
                              )
                            ]),

                            Column(children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                    gap_li[index]['company_indivdual'] ??
                                        "null",
                                    style: TextStyle(fontSize: 17.0)),
                              )
                            ]),
                            Column(children: [
                              IconButton(
                                  onPressed: () => {
                                        Add_Gap().Add_Gap_(
                                            context,
                                            activi_durn_gap,
                                            is_emp_com,
                                            from_data,
                                            to_date,
                                            "1",
                                            id)
                                      },
                                  icon: Icon(Icons.edit)),
                            ]),
                            // Column(children:[Text(address_li[index]['address_line_1'], style: TextStyle(fontSize: 16.0))]),
                          ]),
                        ],
                      );
                    },
                  ),
                  SizedBox(height: 20,),
               Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: MaterialButton(
                      color: Colors.blue,
                      padding: EdgeInsets.all(15),
                      onPressed: () => {
                        Share_pref().Set_profile_Data(
                          
                          _First_Name_controller.text.toString(), 
                        _Middle_Name_controller.text.toString(),
                        _Email_controller.text.toString(),
                        Form_1_9,
                        _Last_Name_controller.text.toString(), 
                        _Phone_controller.text.toString(),_DOB_controller.text.toString(), _Application_date_controller.text.toString(), 
                        _Social_Securtiy_number_controller.text.toString()
                        , _Emergency_name_controller.text.toString(),
                         _Relation_controller.text.toString(), 
                         _EmPhone_controller.text.toString(),
                        _Driver_lincense_controller.text.toString(),
                         _state_controller.text.toString(), 
                        _Issue_date_controller.text.toString(),
                         _Expiration_date_controller.text.toString(),
                          _License_type_controller.text.toString(), 
                          
                          _Endorsement_controller.text.toString(), 
                         _Alien_Registration_no.text.toString(), _Foreign_passport_no.text.toString(), _COI.text.toString(), 
                         _Expiration_date_controller.text.toString(), Form_W_4,
                         _Number_of_qualify.text.toString(), _Number_of_dependents.text.toString(), q_mv, q_sus_rev, q_cmv, q_sc, q_drug_alco, q_drugs, q_empl, q_truck)
                      },
                      child: Text(
                        "Submit",
                        style: GoogleFonts.poppins(
                            fontSize: 18, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  final TextEditingController _First_Name_controller = TextEditingController();
  final TextEditingController _Middle_Name_controller = TextEditingController();
  final TextEditingController _Last_Name_controller = TextEditingController();
  final TextEditingController _Email_controller = TextEditingController();
  final TextEditingController _Phone_controller = TextEditingController();
  final TextEditingController _DOB_controller = TextEditingController();
  final TextEditingController _Terminate_date_controller = TextEditingController();
  final TextEditingController _Application_date_controller = TextEditingController();
  final TextEditingController _Social_Securtiy_number_controller = TextEditingController();
  final TextEditingController _Emergency_name_controller = TextEditingController();
  final TextEditingController _Relation_controller = TextEditingController();
  final TextEditingController _EmPhone_controller = TextEditingController();
  final TextEditingController _Driver_lincense_controller = TextEditingController();
  final TextEditingController _state_controller = TextEditingController();
  final TextEditingController _Expiration_date_controller = TextEditingController();
  final TextEditingController _Issue_date_controller = TextEditingController();
  final TextEditingController _License_type_controller = TextEditingController();
  final TextEditingController _Endorsement_controller = TextEditingController();
  final TextEditingController _Pay_Type_controller = TextEditingController();
  final TextEditingController _Rate_controller = TextEditingController();
  final TextEditingController _Alien_Registration_no = TextEditingController();
  final TextEditingController _Form_I_94_ad_no = TextEditingController();
  final TextEditingController _Foreign_passport_no = TextEditingController();
  final TextEditingController _COI = TextEditingController();
  final TextEditingController _Number_of_qualify = TextEditingController();
  final TextEditingController _Number_of_dependents = TextEditingController();
  final TextEditingController _Address_line1 = TextEditingController();
  final TextEditingController _Address_line2 = TextEditingController();
  final TextEditingController _City = TextEditingController();
  final TextEditingController _lic_exp = TextEditingController();
  final TextEditingController _state = TextEditingController();
  final TextEditingController _zip_code = TextEditingController();
  final TextEditingController _Equipment = TextEditingController();
  final TextEditingController _Approx_Miles = TextEditingController();
  final TextEditingController _From_Date = TextEditingController();
  final TextEditingController _To_Date = TextEditingController();
  final TextEditingController _Accident_date = TextEditingController();
  final TextEditingController _Fatal = TextEditingController();
  final TextEditingController _Description = TextEditingController();
  final TextEditingController _Citation_date = TextEditingController();
  final TextEditingController _Location = TextEditingController();
  final TextEditingController _Citation_no = TextEditingController();
  final TextEditingController _Type_Citation = TextEditingController();
  final TextEditingController _Company_Name = TextEditingController();
  final TextEditingController _Email = TextEditingController();
  final TextEditingController _Job_peroid = TextEditingController();
  final TextEditingController _Leave_Reason = TextEditingController();
  final TextEditingController _During_Gap = TextEditingController();
  final TextEditingController _is_Emp = TextEditingController();
  final TextEditingController _From_Date_Gap = TextEditingController();
  final TextEditingController _To_Date_Gap = TextEditingController();
  final TextEditingController _Country = TextEditingController();
String q_mv = '';
String q_sus_rev = '';
String q_cvm = '';
String q_sc = '';
String q_drug_alco = '';
String q_empl = '';
String q_truck = '';
String formsit =  '';


Future<void> data() async {
  var sha =  await SharedPreferences.getInstance();
  if (sha.getString('fname').toString().contains("null")) {
     _First_Name_controller.text  = "";
     return;
  }
  if (sha.getString('mname').toString().contains("null")) {
     _Middle_Name_controller.text  = "";
     return;
  }
  if (_Last_Name_controller.text.contains("null")) {
     _Last_Name_controller.text  = "";
     return;
  }
  // if (sha.getString('state').toString().contains("null")) {
  //   _state_controller.text = "null";     
  //   return;
  // }
  // if (sha.getString('selectendor').toString().contains("null")) {
  //   _Endorsement_controller.text = "null";
  //    return;
  // }
  if (_Last_Name_controller.text.contains("null")) {
     _Last_Name_controller.text  = "";
     return;
  }
  else{
   _First_Name_controller.text = sha.getString('fname').toString();
   _EmPhone_controller.text = sha.getString('em_number').toString();
   _Email_controller.text = sha.getString('email').toString();
  _Middle_Name_controller.text = sha.getString('mname').toString();
  _Last_Name_controller.text = sha.getString('lname').toString();
  _Phone_controller.text = sha.getString('phone').toString();
  _DOB_controller.text = sha.getString('dob').toString();
  _Driver_lincense_controller.text = sha.getString('license_no').toString();
  _Application_date_controller.text = sha.getString('appli_date').toString();
  _Social_Securtiy_number_controller.text = sha.getString('socialnumber').toString();
  _Emergency_name_controller.text = sha.getString('emer_contact_name').toString();
  _Relation_controller.text = sha.getString('relation').toString();
  _state_controller.text = sha.getString('state').toString();
  _Issue_date_controller.text = sha.getString('issue_date').toString();
  _Expiration_date_controller.text = sha.getString('exp_date').toString();
  _License_type_controller.text = sha.getString('linc_type').toString();
  _Endorsement_controller.text = sha.getString('selectendor').toString();
  _Alien_Registration_no.text = sha.getString('align_reg').toString();
  _Foreign_passport_no.text = sha.getString('foren_pass').toString();
  _COI.text = sha.getString('country_issuance').toString();
   formsit = sha.getString('form1_9').toString();
  _lic_exp.text = sha.getString('workPermit').toString();
   Form_W_4 = sha.getString('martial_status').toString();
  _Number_of_qualify.text = sha.getString('qualifychild').toString();
  _Number_of_dependents.text = sha.getString('other_depen').toString();
   q_mv = sha.getString('moto_vec').toString();
   q_sus_rev = sha.getString('sus_rev').toString();
   q_cmv = sha.getString('cvm').toString();
   q_sc = sha.getString('serious_crime').toString();
   q_drug_alco = sha.getString('drugs').toString();
   q_drugs = sha.getString('test_pos').toString();
   q_empl = sha.getString('pre_emp').toString();
   q_truck = sha.getString('trucking').toString();
   print(q_sus_rev);
   if (q_mv.contains("no")) {
     setState(() {
       indexs = 1;
     });
     
   }
   else{
    setState(() {
      indexs = 0;
    });
   }
   if (q_sus_rev.contains("no")) {
     setState(() {
       indexs1 = 1;
     });
     
   }
   else{
    setState(() {
      indexs1 = 0;
    });
   }
   if (q_cmv.contains("no")) {
     setState(() {
       indexs2 = 1;
     });
     
   }
   else{
    setState(() {
      indexs2 = 0;
    });
   }
   if (q_sc.contains("no")) {
     setState(() {
       indexs3 = 1;
     });
     
   }
   else{
    setState(() {
      indexs3 = 0;
    });
   }

   if (q_drug_alco.contains("no")) {
     setState(() {
       indexs4 = 1;
     });
     
   }
   else{
    setState(() {
      indexs4 = 0;
    });
   }

   if (q_drugs.contains("no")) {
     setState(() {
       indexs5 = 1;
     });
     
   }
   else{
    setState(() {
      indexs5 = 0;
    });
   }

   if (q_empl.contains("no")) {
     setState(() {
       indexs6 = 1;
     });
     
   }
   else{
    setState(() {
      indexs6 = 0;
    });
   }


   if (q_truck.contains("no")) {
     setState(() {
       indexs7 = 1;
     });
     
   }
   else{
    setState(() {
      indexs7 = 0;
    });
   }




  //  if (q_sus_rev.contains("no")) {
  //    setState(() {
  //      indexs1 = 1;
  //    });
  //    return;
  //  }
  //  if (q_mv.contains("yes")) {
  //    setState(() {
  //      indexs1 = 0;
  //    });
  //    return;
  //  }




  //  if (q_cmv.contains("no")) {
  //    setState(() {
  //      indexs2 = 1;
  //    });
  //    return;
  //  }
  //  if (q_cmv.contains("yes")) {
  //    setState(() {
  //      indexs2 = 0;
  //    });
  //    return;
  //  }


  //  if (q_sc.contains("no")) {
  //    setState(() {
  //      indexs3 = 1;
  //    });
  //    return;
  //  }
  //  if (q_sc.contains("yes")) {
  //    setState(() {
  //      indexs3 = 0;
  //    });
  //    return;
  //  }


  //  if (q_drug_alco.contains("no")) {
  //    setState(() {
  //      indexs4 = 1;
  //    });
  //    return;
  //  }
  //  if (q_drug_alco.contains("yes")) {
  //    setState(() {
  //      indexs4 = 0;
  //    });
  //    return;
  //  }




  //  if (q_drugs.contains("no")) {
  //    setState(() {
  //      indexs5 = 1;
  //    });
  //    return;
  //  }
  //  if (q_drugs.contains("yes")) {
  //    setState(() {
  //      indexs5 = 0;
  //    });
  //    return;
  //  }


  //  if (q_empl.contains("no")) {
  //    setState(() {
  //      indexs6 = 1;
  //    });
  //    return;
  //  }
  //  if (q_empl.contains("yes")) {
  //    setState(() {
  //      indexs6 = 0;
  //    });
  //    return;
  //  }



  //  if (q_truck.contains("no")) {
  //    setState(() {
  //      indexs7 = 1;
  //    });
  //    return;
  //  }
  //  if (q_truck.contains("yes")) {
  //    setState(() {
  //      indexs7 = 0;
  //    });
  //    return;
  //  }

  




   
  }

}
}
