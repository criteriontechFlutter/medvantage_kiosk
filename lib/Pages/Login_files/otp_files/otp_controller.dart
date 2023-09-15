
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OtpController extends GetxController{
  final formKey = GlobalKey<FormState>().obs;
  Rx<TextEditingController> otpController = TextEditingController().obs;


  Rx<String> userMobile=''.obs;
  String get getUserMobile=>userMobile.value;
  set updateUserMobile(String val){
    userMobile.value=val;
    update();
  }


}