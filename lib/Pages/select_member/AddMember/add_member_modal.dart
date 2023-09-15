import 'dart:convert';

import 'package:digi_doctor/Pages/StartUpScreen/startup_screen.dart';

import '../../../Localization/app_localization.dart';
import 'package:digi_doctor/AppManager/alert_dialogue.dart';
import 'package:digi_doctor/AppManager/progress_dialogue.dart';
import 'package:digi_doctor/AppManager/user_data.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import '../../../AppManager/app_util.dart';
import '../../../AppManager/raw_api.dart';
import '../../Dashboard/dashboard_view.dart';
import 'add_member_controller.dart';

class AddMemberModal {
  AddMemberController controller = Get.put(AddMemberController());
  App app = App();

  MultiPart multiPart = MultiPart();

  Future<void> onAddMember(context) async {
    ApplicationLocalizations localization=Provider.of<ApplicationLocalizations>(context,listen: false);
    if (controller.formKey.value.currentState!.validate()) {
      if (controller.getGenderId != 0) {
        onPressedConfirm() async {
          await profile(context);
        }

        AlertDialogue().actionBottomSheet(subTitle: localization.getLocaleData.areYouSureWantAddMember.toString(),
            okButtonName:localization.getLocaleData.confirm.toString(),
            cancelButtonName: localization.getLocaleData.alertToast!.cancel.toString(),
            okPressEvent:(){
          Get.back();
          onPressedConfirm();
        } );
      } else {
        alertToast(context, localization.getLocaleData.selectGender.toString());
      }
    }
  }

  getProfilePath(context) async {
    Map<String, String> body = {};
    var data = await multiPart.api('Doctor/saveMultipleFile', body, context,
        imagePathName: 'files',
        imagePath: controller.getProfilePhotoPath!.toString());

    print('#######' + data.toString());
    if (jsonDecode(data['data'])['responseCode'] == 1) {
      data = jsonDecode(data['data'])['responseValue'];
      print('nnnnnnnnnnnnnnnnnnnnname' + data.toString());
    }
    return jsonDecode(data)[0]['filePath'];
  }

  Future<void> profile(context) async {
    ApplicationLocalizations localization=Provider.of<ApplicationLocalizations>(context,listen: false);

    ProgressDialogue().show(context, loadingText: localization.getLocaleData.addingMember.toString());
    var imgFile = controller.getProfilePhotoPath.toString() == ''
        ? ''
        : await getProfilePath(context);
    var body = {
      "userLoginId": UserData().getUserLoginId.toString(),
      "name": controller.nameController.value.text.toString(),
      "mobileNo": controller.mobileController.value.text.toString(),
      "emailId": controller.emailController.value.text.toString(),
      "gender": controller.genderId.toString(),
      "dob": controller.dateController.value.text.toString(),
      "countryId": '0',
      "stateId": '0',
      "districtId": '0',
      "countryCallingCode": 0.toString(),
      "pincode": 0.toString(),
      "address": controller.addressController.value.text.toString(),
      "profilePhotoPath": imgFile.toString(),
      "isFromDevice":'2'
    };
    var data =
        await RawData().api('Patient/addMember', body, context, token: true);
    ProgressDialogue().hide();
    if (data['responseCode'] == 1) {
      // App().navigate(context,DashboardView());
      Get.offAll(()=>const StartupPage());
      //app.replaceNavigate(context, const DashboardView());
      alertToast(context, localization.getLocaleData.memberAddedSuccessfully.toString());
    }else{
      alertToast(context, 'Member Already Added');
    }
  }
}
