import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class RegistrationController extends GetxController{

  Rx<TextEditingController> nameController = TextEditingController().obs;
  Rx<TextEditingController> mobileController = TextEditingController().obs;
  Rx<TextEditingController> emailController = TextEditingController().obs;
  Rx<TextEditingController> dobController = TextEditingController().obs;
  Rx<TextEditingController> idController = TextEditingController().obs;/// new
  Rx<TextEditingController> stateController = TextEditingController().obs;/// new
  Rx<TextEditingController> districtController = TextEditingController().obs;/// new
  Rx<TextEditingController> addressController = TextEditingController().obs;/// new
  Rx<TextEditingController> genderController = TextEditingController().obs;
  Rx<TextEditingController> addrsController = TextEditingController().obs;
  Rx<TextEditingController> selectedGenderC = TextEditingController().obs;
  Rx<TextEditingController> passwordC = TextEditingController().obs;
  Rx<TextEditingController> confirmPasswordC = TextEditingController().obs;
  Rx<TextEditingController> heightC = TextEditingController().obs;
  Rx<TextEditingController> weightC = TextEditingController().obs;

   final formKeyRegistration = GlobalKey<FormState>().obs;


  RxBool isReadTerms=false.obs;
  bool get getIsReadTerms=>isReadTerms.value;
  set updateIsReadTerms(bool val){
    isReadTerms.value=val;
    update();
  }


  RxBool checkBoxValue=false.obs;
  bool get getCheckBoxValue=>checkBoxValue.value;
  set updateCheckBoxValue(bool val){
    checkBoxValue.value=!val;
    update();
  }


  String profilePhotoPath = '';
  get getProfilePhotoPath => profilePhotoPath;
  set updateProfilePhotoPath(String val){
    profilePhotoPath=val;
    update();
  }

  bool isValidEmail(val) {
    return RegExp(
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(val);
  }

  bool isPhone(String val) => RegExp(
      r'^[\+]?[(]?[0-9]{3}[)]?[-\s\.]?[0-9]{3}[-\s\.]?[0-9]{4,6}$'
  ).hasMatch(val);

  List gender = [
    {
      'gen' : 'Male' ,
      'id' : '1'
    },
    {
      'gen' : 'Female',
      'id' : '2'
    },
  ];
}