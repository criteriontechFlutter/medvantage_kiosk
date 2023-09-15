

import 'package:digi_doctor/AppManager/alert_dialogue.dart';
import 'package:digi_doctor/AppManager/raw_api.dart';
import 'package:digi_doctor/Pages/Login_files/ForgotPassword/forgot_password_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import '../../../AppManager/progress_dialogue.dart';
import '../../../Localization/app_localization.dart';
import '../login_controller.dart';
import '../login_view.dart';
import '../otp_files/otp_controller.dart';

class ForgotPasswordModal{
  ForgotPasswordController controller=Get.put(ForgotPasswordController());
  LoginController loginController=Get.put(LoginController());
  OtpController otpController=Get.put(OtpController());

  onPressedResetPassword(context) async {
    if(controller.formKeyResetPassword.value.currentState!.validate()){
      await updateNewPassword(context);
    }

  }

  updateNewPassword(context) async {
    ApplicationLocalizations localization=Provider.of<ApplicationLocalizations>(context,listen: false);
    ProgressDialogue().show(context, loadingText: localization.getLocaleData.changingPassword.toString());
    var body={
      "serviceProviderTypeId": '6',
      "otp": otpController.otpController.value.text.toString(),
      "mobileNo": loginController.forgotPasswordC.value.text.toString(),
      "password": controller.newPasswordC.value.text.toString(),
      "confirmPassword": controller.confirmPasswordC.value.text.toString(),
    };
    var data= await RawData().api('Doctor/updateNewPassword', body, context);
    ProgressDialogue().hide();
    if(data['responseCode']==1){
      alertToast(context, data['responseMessage']);
      Get.offAll( LogIn(index: "4",));
    }else{
      alertToast(context, data['responseMessage']);
      Navigator.pop(context);
    }

  }

}