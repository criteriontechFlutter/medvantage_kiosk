
import 'package:digi_doctor/Pages/MyAppointment/my_appointment_view.dart';
import 'package:digi_doctor/Pages/StartUpScreen/startup_screen.dart';
import 'package:digi_doctor/Pages/VitalPage/LiveVital/device_view.dart';

import '../../../Localization/app_localization.dart';
import 'package:digi_doctor/AppManager/alert_dialogue.dart';
import 'package:digi_doctor/AppManager/progress_dialogue.dart';
import 'package:digi_doctor/AppManager/raw_api.dart';
import 'package:digi_doctor/AppManager/user_data.dart';
import 'package:digi_doctor/AppManager/app_util.dart';
import 'package:digi_doctor/Pages/Login_files/login_controller.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../services/firebase_service/fireBaseService.dart';
import '../Dashboard/dashboard_view.dart';
import '../Drawer/drawer_modal.dart';
import '../Specialities/top_specialities_view.dart';
import 'otp_files/otp_controller.dart';
import 'otp_files/sendotp.dart';

class LoginModal {
  App app = App();

  final UserData userDataC = Get.put(UserData()); //for storing data

  LoginController controller = Get.put(LoginController());

  OtpController otpController = Get.put(OtpController());

  final RawData _rawData = RawData();

  Future<void> onPressedLogin(context, String index) async {
    if (controller.formKey.value.currentState!.validate()) {
      controller.getIsLoginWithOtp ?await sendOtp(context) :await login(context,index);
    }
  }

  Future<void> onPressedResend(context) async {
    await resendOtp(context);
  }

  Future<void> onPressedForgotPassword(context) async {
    ApplicationLocalizations localization=Provider.of<ApplicationLocalizations>(context,listen: false);

    if (controller.forgotPasswordC.value.text.isEmpty) {
      alertToast(context, localization.getLocaleData.enterYourNo.toString());
    }  else {
      await generateOTPForForgotPassword(context);
    }
  }

  Future<void> sendOtp( context, ) async {

    ApplicationLocalizations localization=Provider.of<ApplicationLocalizations>(context,listen: false);
    ProgressDialogue().show(context, loadingText: localization.getLocaleData.sendingOtp.toString());
    var body = {'mobileNo': controller.registrationNumberC.value.text.toString()};
    // print('-----------');

    var data =
    await _rawData.api('Patient/generateOTPForPatient', body, context);

    ProgressDialogue().hide();

    if (data['responseCode'] == 1) {
      app.navigate(
          context,
          SendOtp(
            isExist: data['responseValue'][0]['isExists'].toString(),
            mobileNo:controller.registrationNumberC.value.text.toString(),
          ));
    } else {
      alertToast(context, data['responseMessage'].toString());
    }
  }


  Future<void> login(
      context, String index,
      ) async {
    ApplicationLocalizations localization=Provider.of<ApplicationLocalizations>(context,listen: false);
    ProgressDialogue().show(context, loadingText: localization.getLocaleData.loggingIn.toString());

    var body = {
      "mobileNo": controller.registrationNumberC.value.text.toString(),
      "password": controller.passwordC.value.text.toString(),
      "serviceProviderTypeId": "6",
      "deviceToken": (await FireBaseService().getToken()).toString(),
      "deviceType": "4",
      "appType": "DD",
    };

    var data = await RawData().api('Patient/checkLogin', body, context);
    ProgressDialogue().hide();

    if (data['responseCode'] == 1) {
      userDataC.addUserData(data['responseValue'][0]);

      userDataC.addToken(data['token']);

      var drawerData = await DrawerModal().getMenuForApp(context);
      if (drawerData['responseCode'] == 1) {
        if(index=="0"){
          Get.offAll((){
            return  TopSpecialitiesView();
          });
        }else if(index=="1"){
          Get.offAll((){
            return  DeviceView();
          });
         // alertToast(context, "Under Development");
        } else if(index=="2"){
          Get.offAll((){
            return const MyAppointmentView();
          });
        }else if(index=="4"){
          Get.offAll((){
            return const StartupPage();
          });
        }else{
          Get.offAll((){
            return const StartupPage();
          });
        }

      }
    } else {
      alertToast(context, data['responseMessage'].toString());
    }
  }

  //for resend OTP

  Future<void> resendOtp(
    context,
  ) async {
    var body = {'mobileNo': controller.numberControl.value.text.toString()};
    var data =
        await _rawData.api('Patient/generateOTPForPatient', body, context);

    if (data['responseCode'] == 1) {
      if (data['responseValue'][0]['isExists'] == 1) {
      } else {}
    }
  }


  generateOTPForForgotPassword(context) async {
    ApplicationLocalizations localization=Provider.of<ApplicationLocalizations>(context,listen: false);
    ProgressDialogue().show(context, loadingText:  localization.getLocaleData.verifyingOtp.toString());
    var body = {
      "serviceProviderTypeId": '6',
      "mobileNo": controller.forgotPasswordC.value.text.toString()
    };
    var data = await RawData()
        .api('Doctor/generateOTPForForgotPassword', body, context, token: true);
    ProgressDialogue().hide();

    if (data['responseCode'] == 1) {
      alertToast(context, data['responseMessage']);
       App().navigate(context, SendOtp(isForgotPassword: true,otpText: data['responseValue'].isEmpty? '':data['responseValue'][0]['otp'].toString(),
       mobileNo: controller.registrationNumberC.value.text.toString(),));

    } else {
      alertToast(context, data['responseMessage']);
    }
  }
}
