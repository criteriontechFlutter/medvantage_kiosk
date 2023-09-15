

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController{
  final formKey = GlobalKey<FormState>().obs;
  Map saveCredentials = {}.obs;

  Rx<TextEditingController> numberControl = TextEditingController().obs;
  Rx<TextEditingController> registrationNumberC= TextEditingController().obs;
  Rx<TextEditingController> passwordC = TextEditingController().obs;


  Rx<TextEditingController> forgotPasswordC= TextEditingController().obs;


  RxBool isLoginWithOTP=false.obs;
  bool get getIsLoginWithOtp=>isLoginWithOTP.value;
  set updateISLoginWithOtp(bool val){
    isLoginWithOTP.value=!val;
    passwordC.value.clear();

    update();
  }



}