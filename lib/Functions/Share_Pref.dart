import 'package:shared_preferences/shared_preferences.dart';

class Share_pref{
  Future<void> Set_ID(String ID,String company_id,name) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('driver_id',ID);
    prefs.setString('name',name);
    prefs.setString('company_id',company_id);
  }
  
  Future<void> delete() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('driver_id',"null");
    prefs.setString('name',"null");
    prefs.setString('company_id',"null");
  }
  Future<String> get_id() async {
    final prefs = await SharedPreferences.getInstance();
   String? id =  prefs.getString('driver_id');
    return id.toString();
  }
  Future<String> get_company_id() async {
    final prefs = await SharedPreferences.getInstance();
   String? com_id =  prefs.getString('company_id');
    return com_id.toString();
  }

  Future<void> Set_profile_Data(fname,
     mname,email,lname,phone,dob,
     appli_date,socialnumber,
     emer_contact_name,relation,em_number,
     lince_num,
     state,issue_date,
     exp_date,
     linc_type,selectendor,
     form1_9,
     align_reg,foren_pass,country_issuance,
     workPermit,martial_status,qualifychild,other_depen,
     moto_vec,sus_rev,cvm,serious_crime,drugs,test_pos,pre_emp,
     trucking,
     
     
     ) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('fname',fname);
    prefs.setString('mname',mname);
    prefs.setString('lname',lname);
    prefs.setString('em_number',em_number);
    prefs.setString('email',email);
    prefs.setString('form1_9',form1_9);
    prefs.setString('phone',phone);
    prefs.setString('dob',dob);
    prefs.setString('appli_date',appli_date);
    prefs.setString('socialnumber',socialnumber);
    prefs.setString('emer_contact_name',emer_contact_name);
    prefs.setString('relation',relation);
    prefs.setString('license_no',lince_num);
    

    prefs.setString('state',state);
    prefs.setString('issue_date',issue_date);
    prefs.setString('exp_date',exp_date);
    prefs.setString('linc_type',linc_type);
    prefs.setString('selectendor',selectendor);
    prefs.setString('align_reg',align_reg);
    prefs.setString('foren_pass',foren_pass);
    prefs.setString('country_issuance',country_issuance);
    prefs.setString('workPermit',workPermit);
    prefs.setString('martial_status',martial_status);
    prefs.setString('qualifychild',qualifychild);
    prefs.setString('other_depen',other_depen);
    prefs.setString('moto_vec',moto_vec);
    prefs.setString('sus_rev',sus_rev);
    prefs.setString('cvm',cvm);
    prefs.setString('serious_crime',serious_crime);
    prefs.setString('drugs',drugs);
    prefs.setString('test_pos',test_pos);
    prefs.setString('pre_emp',pre_emp);
    prefs.setString('trucking',trucking);

  }
  
}