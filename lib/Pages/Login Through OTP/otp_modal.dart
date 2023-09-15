
import 'dart:convert';

import 'package:digi_doctor/AppManager/alert_dialogue.dart';
import 'package:digi_doctor/Pages/Login%20Through%20OTP/select_user.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:provider/provider.dart';
import '../../AppManager/app_util.dart';
import '../../AppManager/progress_dialogue.dart';
import '../../AppManager/user_data.dart';
import '../../Localization/app_localization.dart';
import '../../SignalR/raw_data_83.dart';
import '../StartUpScreen/startup_screen.dart';
import '../VitalPage/LiveVital/stetho_master/AppManager/raw_api.dart';
import 'data modal/user_data_modal.dart';
import 'otp_login_controller.dart';
import 'package:http/http.dart' as http;

import 'registration.dart';

class LoginThroughOTPModal {

  OtpLoginController controller = Get.put(OtpLoginController());
  final GetConnect connect = Get.put(GetConnect());





  loginThroughOTP(context,String phoneNumber)async{
    ApplicationLocalizations localization=Provider.of<ApplicationLocalizations>(context,listen: false);
    ProgressDialogue().show(context, loadingText: localization.getLocaleData.loading.toString());
   var  body={};

    // var data = await RawData().getapi('/api/PatientRegistrationkiosk/VerifyMobileNo?MobileNo=$phoneNumber',body);
    var data = await RawData().getapi('/api/kioskOtpVerification/VerifyMobileNo?MobileNo=$phoneNumber',body);

    ProgressDialogue().hide();
  }


  final UserData userDataC = Get.put(UserData()); //for sto
  matchOtp(context, String phoneNumber)async{

    var  body={};

    // var data = await RawData().getapi('/api/PatientRegistrationkiosk/VerifyOTP?Otp=$phoneNumber',body);
    var data = await RawData().getapi('/api/kioskOtpVerification/VerifyOTP?Otp=$phoneNumber',body);
    print("Animesh${data['message']}");

    if(data['message'].toString()=="success"){


      // var decodedData=jsonEncode(data['responseValue']);
      // print(decodedData.toString());

      // updateCategoryList(List<CategoryData>.from(
      //     (data['responseValue'] as List).map((e) => CategoryData.fromJson(e))
      // ));
      // print( controller.usersList=data['responseValue']);
      // print( controller.usersList[0].gender);

    controller.updateUsersList =
    List<UsersDataModal>.from(( (data['responseValue']) ).map((e) => UsersDataModal.fromJson(e)));


    print('${controller.getUsersList}1234567890');
    if('${controller.getUsersList}'=='[]'){
      App().navigate(context, const Registration());/// Temperory
    }else{
      App().replaceNavigate(context, const SelectUser());
    }
    //
      // userDataC.addUserData(data['responseValue'][0]);
      // userDataC.addToken('');
    }else{

    }
  }

  register(context)async{

  var  body=
    {
      "patientName": controller.nameController.value.text,
      "dob":controller.dobController.value.text,
      "genderId": controller.selectedGenderC.value.text,
      "guardianName": controller.guardianC.value.text,
      "countryCallingCode": 91,
      "mobileNo": controller.mobileController.value.text,
      "stateId": controller.getStateId.toString(),
      "cityId": controller.getCityId.toString(),
      "address":controller.addressController.value.text,
      "userId": "23",///STATIC VALUE
      "idNumber": controller.idC.value.text,
      "idTypeId": controller.getIdentityId.toString(),
      //"age": 0,
      "emailID": controller.emailController.value.text,
      "ageUnitId": "0",
      "bloodGroupId": "0",
      "guardianAddress": "",
      "guardianMobileNo": "",
      "roomId": 0,
      "sexualOrientation": "",
      "id": 0
    };

  print("Body"+body.toString());

    //var data = await RawData().api('/api/PatientRegistration/InsertPatient',context,demo);
    var data = await connect.post("http://172.16.61.31:7082/api/PatientRegistrationkiosk/InsertPatient", body);


   print("Response using get "+data.body.toString());
   print("Response using get "+data.body['message'].toString());
  if(data.body['message'].toString() == "success"){
    alertToast(context, data.body['message'].toString());
    App().navigate(context, const StartupPage());
  }else{
    alertToast(context, data.body['message'].toString());

  }



  }


  // getAllCountry(context)async{
  //   print('wowwww');
  //  var body={};
  //   var data = await RawData83().getapi('/api/CountryMaster/GetAllCountryMaster',{});
  //   //controller.updateCountry=data;
  //   Get.log('${data}country123');
  //
  // }


  allState(context)async{
    var body = {};
    var data = await RawData83().getapi('/api/StateMaster/GetAllStateMaster',{});
    if(data['status']==1){
      controller.updateState= data['responseValue'];
      print('${data}states123');
    }else{
      alertToast(context, data['message']);
    }
  }

  getCityByStates(context)async{
    var body = {};
    var data = await RawData83().getapi('/api/CityMaster/GetCityMasterByStateId?id=${controller.getStateId.toString()}',{});
    print('${data}city123');
    if(data['status']==1){
      controller.updateCity= data['responseValue'];
     // getCityByStates(context);
      print('${data}states123');
    }else{
      alertToast(context, data['message']);
    }
  }

}

// http://172.16.61.31:7083/api/CountryMaster/GetAllCountryMaster
// http://172.16.61.31:7082/api/CountryMaster/GetAllCountryMaster