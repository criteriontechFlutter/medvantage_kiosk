

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ForgotPasswordController extends GetxController{

  final formKeyResetPassword = GlobalKey<FormState>().obs;



  Rx<TextEditingController> newPasswordC = TextEditingController().obs;
  Rx<TextEditingController> confirmPasswordC = TextEditingController().obs;

}