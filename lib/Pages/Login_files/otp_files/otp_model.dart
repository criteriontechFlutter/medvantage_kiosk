

import 'package:digi_doctor/AppManager/alert_dialogue.dart';
import 'package:digi_doctor/AppManager/app_util.dart';
import 'package:digi_doctor/AppManager/progress_dialogue.dart';
import 'package:digi_doctor/AppManager/raw_api.dart';
import 'package:digi_doctor/AppManager/user_data.dart';
import 'package:digi_doctor/Pages/Dashboard/dashboard_view.dart';
import 'package:digi_doctor/Pages/profile/profile_view.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import '../../../Localization/app_localization.dart';
import '../../../services/firebase_service/fireBaseService.dart';
import '../../Drawer/drawer_modal.dart';
import '../login_controller.dart';
import 'otp_controller.dart';

class OtpModal {
  OtpController otpController = Get.put(OtpController());

  final UserData userDataC = Get.put(UserData());

  LoginController numberController = Get.put(LoginController());

  App app = App();




  Future<void> onPressedVerify(context, isExist) async {

    ApplicationLocalizations localization=Provider.of<ApplicationLocalizations>(context,listen: false);
    ProgressDialogue().show(context, loadingText: localization.getLocaleData.verifyingOtp.toString());

    var body = {
      "mobileNo": otpController.getUserMobile.toString(),
      "serviceProviderTypeId": "6",
      "deviceToken": (await FireBaseService().getToken()).toString(),
      "deviceType": "4",
      "appType": "DD",
      "otp": otpController.otpController.value.text.toString()
    };
    var data = await RawData().api('Patient/checkLogin', body, context);
    ProgressDialogue().hide();

    if (data['responseCode'] == 1 && isExist == '1') {
      userDataC.addUserData(data['responseValue'][0]);
      userDataC.addToken(data['token']);
     var drawerData = await DrawerModal().getMenuForApp(context);
     if(drawerData['responseCode']==1){
       Get.offAll(const DashboardView());
     }
    } else if (data['responseCode'] == 1 && isExist == '0') {
      app.replaceNavigate(context, const ProfileView(isLogin: true,));
    } else {
      alertToast(context, data['responseMessage'].toString());
    }

  }



}
