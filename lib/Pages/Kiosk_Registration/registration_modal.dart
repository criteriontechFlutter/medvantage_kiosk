import 'dart:convert';

import 'package:digi_doctor/Pages/Kiosk_Registration/registration_controller.dart';
import 'package:digi_doctor/Pages/StartUpScreen/startup_screen.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../AppManager/alert_dialogue.dart';
import '../../AppManager/app_util.dart';
import '../../AppManager/progress_dialogue.dart';
import '../../AppManager/raw_api.dart';
import '../../AppManager/user_data.dart';
import '../../Localization/app_localization.dart';
import '../../services/firebase_service/fireBaseService.dart';

class RegistrationModal{

  RegistrationController controller = Get.put(RegistrationController());

  final UserData _userDataC = Get.put(UserData());

  final RawData rawData = RawData();
  MultiPart multiPart = MultiPart();
  App app = App();


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
      'deviceType':0,
      'appType': 'DD'.toString(),
      'otp': 0,
      'profilePhotoPath': myFile.toString(),
      'password': controller.passwordC.value.text.toString(),
      'deviceToken': (await FireBaseService().getToken()).toString(),
      //"isFromDevice":2,
      // "height":controller.heightC.value.text.toString(),
      // "weight":controller.weightC.value.text.toString(),
      // "isPrivate":controller.setIsPrivate.toString()
    };
    print('bodyData'+jsonEncode(body).toString());

    //print('vvvvvvvvvvvidsl' + controller.dobController.value.text.toString());
    var data = await RawData()
        .api('Patient/patientRegistration', body, context, token: true);


    ProgressDialogue().hide();
    if (data['responseCode'] == 1) {
      _userDataC.addUserData(data['responseValue'][0]);
      App().replaceNavigate(context, const StartupPage());
      // var drawerData =await DrawerModal().getMenuForApp(context);
      //       // if (drawerData['responseCode'] == 1) {
      //       //   Get.offAll(const DashboardView());
      //       //   //app.replaceNavigate(context, const DashboardView());
      //       // }
    }else{
      alertToast(context,
          data['responseMessage'].toString());
    }
  }
}