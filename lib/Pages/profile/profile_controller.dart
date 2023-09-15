
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../Localization/app_localization.dart';

class ProfileController extends GetxController{

  var datafile = ''.obs;

  final profileFormKey = GlobalKey<FormState>().obs;

  RxString otpText=''.obs;
  String get getOtpText=>otpText.value;
  set updateOtpText(String val){
    otpText.value=val;
    update();
  }
  List<OptionDataModal> getOption(context){
    ApplicationLocalizations localization = Provider.of<
        ApplicationLocalizations>(context, listen: false);
    return [
      OptionDataModal(
        optionIcon  :"assets/kiosk_setting.png",
        optionText: localization.getLocaleData.profile.toString(),
        // route: TopSpecialitiesView(),
      ),

    ];

  }
  Rx<TextEditingController> nameController = TextEditingController().obs;
  Rx<TextEditingController> mobileController = TextEditingController().obs;
  Rx<TextEditingController> emailController = TextEditingController().obs;
  Rx<TextEditingController> dobController = TextEditingController().obs;
  Rx<TextEditingController> genderController = TextEditingController().obs;
  Rx<TextEditingController> addrsController = TextEditingController().obs;
  Rx<TextEditingController> selectedGenderC = TextEditingController().obs;
  Rx<TextEditingController> passwordC = TextEditingController().obs;
  Rx<TextEditingController> confirmPasswordC = TextEditingController().obs;
  Rx<TextEditingController> heightC = TextEditingController().obs;
  Rx<TextEditingController> weightC = TextEditingController().obs;


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

  String profilePhotoPath = '';

  String notificationDrName = '';
  int notificationServiceProviderDetailsId = 0;

  int setIsPrivate = 0;
  int setIsInvestigation = 0;
  int setIsPrescription = 0;

  int isInvestigation = 0;
  int isPrescription = 0;

  get getProfilePhotoPath => profilePhotoPath;

  set updateProfilePhotoPath(String val){
    profilePhotoPath=val;
    update();
  }

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


}
class OptionDataModal{
  String?optionText;
  String?optionIcon;
  Widget?route;

  OptionDataModal({
    this.optionText,
    this.optionIcon,
    this.route
  });

}