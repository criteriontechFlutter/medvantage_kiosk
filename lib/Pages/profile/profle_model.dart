import 'dart:convert';
import 'package:digi_doctor/AppManager/alert_dialogue.dart';
import 'package:digi_doctor/AppManager/app_util.dart';
import 'package:digi_doctor/AppManager/progress_dialogue.dart';
import 'package:digi_doctor/AppManager/raw_api.dart';
import 'package:digi_doctor/Pages/Dashboard/dashboard_view.dart';
import 'package:digi_doctor/Pages/Login_files/login_controller.dart';
import 'package:digi_doctor/Pages/Login_files/otp_files/otp_controller.dart';
import 'package:digi_doctor/Pages/StartUpScreen/startup_screen.dart';
import 'package:digi_doctor/Pages/profile/profile_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../Localization/app_localization.dart';
import '../../AppManager/user_data.dart';
import '../../services/firebase_service/fireBaseService.dart';
import '../Drawer/drawer_modal.dart';

class ProfileModel {
  ProfileController controller = Get.put(ProfileController());
  OtpController otpController = Get.put(OtpController());
  LoginController loginController = Get.put(LoginController());

  final UserData _userDataC = Get.put(UserData());

  final RawData rawData = RawData();
  MultiPart multiPart = MultiPart();
  App app = App();


  Future<void> onPressedSubmit(context) async {

    ApplicationLocalizations localization=Provider.of<ApplicationLocalizations>(context,listen: false);
    if (controller.profileFormKey.value.currentState!.validate()) {
      if (controller.selectedGenderC.value.text != '' ||
          UserData().getUserData.isNotEmpty) {
        UserData().getUserData.isEmpty
            ? controller.getCheckBoxValue == true
            ? AlertDialogue().actionBottomSheet(title: localization.getLocaleData.submit.toString(),subTitle: localization.getLocaleData.alertToast!.youWantToSubmit.toString(),
            okButtonName:localization.getLocaleData.confirm.toString(),cancelButtonName: localization.getLocaleData.alertToast!.cancel.toString(),
            okPressEvent:()async{
              Navigator.pop(context);
              await profile(context);
            }) : alertToast(context, localization.getLocaleData.acceptTermCondition.toString(),)
            : AlertDialogue().actionBottomSheet(title:localization.getLocaleData.update,subTitle:localization.getLocaleData.youWantToUpdate.toString(),
            okPressEvent:()async{
              Navigator.pop(context);
              await updateMember(context);
            },okButtonName:localization.getLocaleData.yes.toString(),
            cancelButtonName:localization.getLocaleData.no.toString());
      } else {
        alertToast(context,localization.getLocaleData.selectGenderValidation.toString(),);
      }
    }
  }

  getProfilePath(context) async {
    Map<String, String> body = {};
    //print('------------------'+controller.getProfilePhotoPath.toString());
    var data = await multiPart.api('Doctor/saveMultipleFile', body, context,
        imagePathName: 'files',
        imagePath: controller.getProfilePhotoPath!.toString());

    //print('#######' + data.toString());
    if (jsonDecode(data['data'])['responseCode'] == 1) {
      data = jsonDecode(data['data'])['responseValue'];
    }
    return jsonDecode(data)[0]['filePath'];
  }

  Future<void> profile(context) async {
    ApplicationLocalizations localization=Provider.of<ApplicationLocalizations>(context,listen: false);
    ProgressDialogue().show(context, loadingText:  localization.getLocaleData.submitting.toString());
    var myFile = controller.getProfilePhotoPath.toString() == ''
        ? ''
        : await getProfilePath(context);
    var body = {
      'name': controller.nameController.value.text.toString(),
      'callingCodeId': '91'.toString(),
      'mobileNo': controller.mobileController.value.text.toString(),
      'dob': DateFormat('yyyy-mm-dd')
          .format(DateFormat("yyyy-mm-dd")
          .parse(controller.dobController.value.text.toString()))
          .toString(),
      'address': controller.addrsController.value.text.toString(),
      'emailId': controller.emailController.value.text.toString(),
      'gender': controller.selectedGenderC.value.text.toString(),
      'deviceType': '3'.toString(),
      'appType': 'DD'.toString(),
      'otp': controller.getOtpText.toString(),
      'profilePhotoPath': myFile.toString(),
      'password': controller.passwordC.value.text.toString(),
      'deviceToken': (await FireBaseService().getToken()).toString(),
      "isFromDevice":2,
      "height":controller.heightC.value.text.toString(),
      "weight":controller.weightC.value.text.toString(),
      "isPrivate":controller.setIsPrivate.toString()
    };
    //print(jsonEncode(body));

    //print('vvvvvvvvvvvidsl' + controller.dobController.value.text.toString());
    var data = await RawData()
        .api('Patient/patientRegistration', body, context, token: true);

    ProgressDialogue().hide();
    if (data['responseCode'] == 1) {
      _userDataC.addUserData(data['responseValue'][0]);

      var drawerData =await DrawerModal().getMenuForApp(context);
      if (drawerData['responseCode'] == 1) {
        Get.offAll(const StartupPage());
        //app.replaceNavigate(context, const DashboardView());
      }
    }
  }

  Future<void> updateMember(context) async {
    ApplicationLocalizations localization=Provider.of<ApplicationLocalizations>(context,listen: false);
    ProgressDialogue().show(context, loadingText: localization.getLocaleData.updating.toString());
    var myFile = controller.getProfilePhotoPath.toString() == ''
        ? ''
        : await getProfilePath(context);
    var body = {
      "memberId": UserData().getUserMemberId.toString(),
      "name": controller.nameController.value.text.toString(),
      "mobileNo": controller.mobileController.value.text.toString(),
      "emailId": controller.emailController.value.text.toString(),
      "gender": controller.selectedGenderC.value.text.toString(),
      "dob": DateFormat('yyyy-mm-dd')
          .format(DateFormat("yyyy-mm-dd")
          .parse(controller.dobController.value.text.toString()))
          .toString(),
      "countryId": UserData().getUserCountryId.toString(),
      "stateId": UserData().getUserStateId.toString(),
      "districtId": UserData().getUserDistrictId.toString(),
      "countryCallingCode": UserData().getUserCountryCallingCode.toString(),
      "pincode": UserData().getUserPinCode.toString(),
      "address": controller.addrsController.value.text.toString(),
      "height":controller.heightC.value.text.toString(),
      "weight":controller.weightC.value.text.toString(),
      "isPrivate":controller.setIsPrivate.toString(),
      "isInvestigation":controller.setIsInvestigation.toString(),
      "isPrescription":controller.setIsPrescription.toString(),
      "serviceProviderDetailsId":controller.notificationServiceProviderDetailsId.toString(),
      "profilePhotoPath": myFile.toString() == ''
          ? UserData().getUserProfilePhotoPath.toString() == ''
          ? ''
          : UserData()
          .getUserProfilePhotoPath
          .trim()
          .split('/')[4]
          .toString()
          : myFile.toString()
    };
    //print('-----------------'+jsonEncode(body));
    var data =
    await RawData().api('Patient/updateMember', body, context, token: true);
    ProgressDialogue().hide();
    if (data['responseCode'] == 1) {
      for (int i = 0; i < data['responseValue'].length; i++) {
        if (data['responseValue'][i]['memberId']
            .toString()
            .contains(UserData().getUserMemberId.toString())) {
          _userDataC.addUserData(data['responseValue'][i]);
          if (controller.notificationServiceProviderDetailsId == 0){
            Get.offAll(const StartupPage());
          }
        }
      }
    }
    else{
      alertToast(context, data["responseMessage"]);
    }
  }
}
