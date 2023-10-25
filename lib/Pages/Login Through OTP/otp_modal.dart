
import 'dart:convert';
import 'dart:io';
import 'package:digi_doctor/AppManager/alert_dialogue.dart';
import 'package:digi_doctor/Pages/Login%20Through%20OTP/register%20through%20otp/registration.dart';
import 'package:digi_doctor/Pages/Login%20Through%20OTP/select_user.dart';
import 'package:digi_doctor/Pages/VitalPage/LiveVital/stetho_master/AppManager/raw_api.dart';
import 'package:digi_doctor/Pages/medvantage_login.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';
import '../../AppManager/app_color.dart';
import '../../AppManager/app_util.dart';
import '../../AppManager/progress_dialogue.dart';
import '../../AppManager/user_data.dart';
import '../../Localization/app_localization.dart';
import '../../SignalR/raw_data_83.dart';
import '../StartUpScreen/startup_screen.dart';
import 'data modal/user_data_modal.dart';
import 'otp_login_controller.dart';
import 'otp_view.dart';
import 'package:http/http.dart' as http;

class LoginThroughOTPModal {
  OtpLoginController controller = Get.put(OtpLoginController());
  final GetConnect connect = Get.put(GetConnect());

  loginThroughOTP(context, String phoneNumber) async {
    ApplicationLocalizations localization =
        Provider.of<ApplicationLocalizations>(context, listen: false);
    ProgressDialogue().show(context,
        loadingText: localization.getLocaleData.loading.toString());
    var body = {};
    // var data = await RawData().getapi('/api/PatientRegistrationkiosk/VerifyMobileNo?MobileNo=$phoneNumber',body);
    var data = await RawDataApi().api(
        '/api/kioskOtpVerification/VerifyMobileNoOREmail?UserName=$phoneNumber',
        {},
        context);
    ProgressDialogue().hide();
  }

  final UserData userDataC = Get.put(UserData()); //for storing
  matchOtp(context, String oTP, usernameOrNumber) async {
    try {
      MedvantageLogin userdata = Provider.of<MedvantageLogin>(context, listen: false);
      var body = {};
      // var data = await RawData().getapi('/api/PatientRegistrationkiosk/VerifyOTP?Otp=$phoneNumber',body);
      var data = await RawDataApi().getapi('/api/kioskOtpVerification/VerifyOTP?userName=$usernameOrNumber&Otp=$oTP', body);
      if (kDebugMode) {
        print("Animesh$data");
      }
      if (data['status'].toString() == "1") {
        userdata.saveLoginUserData(data.toString());
        print("Animesh2${data['message']}");
        // var decodedData=jsonEncode(data['responseValue']);
        // print(decodedData.toString());

        // updateCategoryList(List<CategoryData>.from(
        //     (data['responseValue'] as List).map((e) => CategoryData.fromJson(e))
        // ));
        // print( controller.usersList=data['responseValue']);
        // print( controller.usersList[0].gender);

        final medvantageUser = GetStorage();
        controller.updateUsersList = List<UsersDataModal>.from(((data['responseValue'])).map((e) => UsersDataModal.fromJson(e)));
        await medvantageUser.write('allUsersList',controller.usersList);

        print('1234567890${controller.getUsersList}');
        if ('${controller.getUsersList}' == '[]') {
       //   App().navigate(context, const Registration());
          /// Temperory
        } else {
          var users =  await medvantageUser.read('allUsersList');
          print('1234567890${users}1234567890');
          App().replaceNavigate(context, const SelectUser());

        }
        //
        // userDataC.addUserData(data['responseValue'][0]);
        // userDataC.addToken('');
      } else {
        final snackBar = SnackBar(
          backgroundColor: AppColor.secondaryColor,
          content:  Text(data['message']),
          action: SnackBarAction(
            textColor: Colors.white,
            label: 'Ok',
            onPressed: () {

            },
          ),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
      data['message'];
    } catch (e) {
      print('nhgdfjyrtyf');

      final snackBar = SnackBar(
        backgroundColor: AppColor.secondaryColor,
        content: const Text('RETRY'),
        action: SnackBarAction(
          textColor: Colors.white,
          label: 'Ok',
          onPressed: () {
            // Some code to undo the change.
          },
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

// http://172.16.61.31:7082/api/PatientRegistration/InsertPatient
// http://172.16.61.31:7082/api/PatientRegistrationkiosk/InsertPatient

  sendOTPForRegistration(context, String phoneNumber) async {
    try {
      var data =
      await RawDataApi().api('/api/kioskOtpVerification/VerifyMobileNoForRegistration?UserName=$phoneNumber', {}, context);
      if(data["status"].toString()=='1'){
        if(data["message"]=="Otp Send Successfully."){
          App().replaceNavigate(context,  OtpView(phonenumber:phoneNumber, registerOrLogin: 'registration',));
        }
      }else{
        final snackBar = SnackBar(
          backgroundColor: AppColor.secondaryColor,
          content: const Text('RETRY'),
          action: SnackBarAction(
            textColor: Colors.white,
            label: 'Ok',
            onPressed: () {
              // Some code to undo the change.
            },
          ),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
       // alertToast(context, data["message"].toString());
      }
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }

  matchRegistrationOtp(context,String phoneNumber,String otp)async{
    try {
      var data =
          await RawDataApi().getapi('/api/kioskOtpVerification/VerifyOTPForRegistration?userName=$phoneNumber&Otp=$otp',  context);
      print(data.toString()+'uy');
      if(data["status"].toString()=='1'){
        if(data["message"]=="Verified Successfully"){
          App().replaceNavigate(context,  Registration(phonenumber:phoneNumber));
        }
      }else{
       // alertToast(context, data["message"].toString());
      }
    } catch (e) {
      final snackBar = SnackBar(
        backgroundColor: AppColor.secondaryColor,
        content: const Text('RETRY'),
        action: SnackBarAction(
          textColor: Colors.white,
          label: 'Ok',
          onPressed: () {
            // Some code to undo the change.
          },
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      print(e.toString());
    }
  }

  register(context,String phoneNumber) async {
    print("Ali Zaidi"+'data.body.toString()');
    var body = {
      "uhID": "",
      "patientName": controller.nameController.value.text,
      "emailID": controller.emailController.value.text.toString(),
      "genderId": controller.selectedGenderC.value.text,
      "age": controller.dobController.value.text,
      // "mobileNo": controller.mobileController.value.text,
      "mobileNo": phoneNumber,
      "userId": "99",
      "isFromKiosk": 1
    };


    print(body.toString());

    dynamic data = await http.post(
        headers: {
          HttpHeaders.contentTypeHeader: "application/json",
        },
      Uri.parse('http://172.16.61.31:7082/api/PatientRegistrationkiosk/InsertPatient'),
      body: jsonEncode(body)
        );
    Map<String, dynamic> map = json.decode(data.body);
    print(map['responseValue'].toString());

    print("Ali Zaidi${data.statusCode}"=='200');

    if (kDebugMode) {
      print("Response using get ${data.body}");
    }
     if (data.statusCode.toString()=='200') {

      // Data mappedData=Data.fromJson(data.body);
     //  print('${mappedData.toJson().toString()}234567890456789456789');
      // alertToast(context, data.body['message'].toString());
       App().navigate(context, const StartupPage());

    } else {
       print('${data.body}234567890456789456789');
      alertToast(context, map['responseValue'].toString());

     }
  }

  allState(context) async {
    var body = {};
    var data =
        await RawData83().getapi('/api/StateMaster/GetAllStateMaster', {});
    if (data['status'] == 1) {
      controller.updateState = data['responseValue'];
      print('${data}states123');
    } else {
      alertToast(context, data['message']);
    }
  }

  getCityByStates(context) async {
    var body = {};
    var data = await RawData83().getapi(
        '/api/CityMaster/GetCityMasterByStateId?id=${controller.getStateId.toString()}',
        {});
    print('${data}city123');
    if (data['status'] == 1) {
      controller.updateCity = data['responseValue'];
      // getCityByStates(context);
      print('${data}states123');
    } else {
      alertToast(context, data['message']);
    }
  }

}


class Data {
  int? status;
  String? message;
  String? responseValue;

  Data({this.status, this.message, this.responseValue});

  Data.fromJson(Map json) {
    status = json['status'];
    message = json['message'];
    responseValue = json['responseValue'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['responseValue'] = this.responseValue;
    return data;
  }
}