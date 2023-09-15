import '../../../Localization/app_localization.dart';
import 'package:digi_doctor/AppManager/progress_dialogue.dart';
import 'package:digi_doctor/AppManager/raw_api.dart';
import 'package:digi_doctor/AppManager/user_data.dart';
import 'package:digi_doctor/Pages/select_member/select_memeber_controller.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../AppManager/alert_dialogue.dart';

class SelectMemberModal {
  SelectMemberController controller = Get.put(SelectMemberController());
  final UserData _userDataC = Get.put(UserData()); //f
//*****
  Future<void> onPressedDelete(context) async {
    ApplicationLocalizations localization=Provider.of<ApplicationLocalizations>(context,listen: false);
    onPressedConfirm() async {
      Get.back();
      await deleteMember(context);
    }

    AlertDialogue().actionBottomSheet(subTitle: localization.getLocaleData.areYouSureWantDelete.toString(),
        okButtonName:localization.getLocaleData.confirm.toString(),
        cancelButtonName: localization.getLocaleData.alertToast!.cancel.toString(),
        okPressEvent: (){
          onPressedConfirm();
        });
  }

  Future<void> getMember(context, {noId}) async {
    controller.updateShowNoData = false;
    var body = {
      "memberId": controller.getSelectedMemberId.toString(),
      "userLoginId": UserData().getUserLoginId
    };
    var data =
        await RawData().api('Patient/getMembers', body, context, token: true);
    controller.updateShowNoData = true;
    if (data['responseCode'] == 1) {
      controller.updateSelectMember = data['responseValue'];
      _userDataC.addUserData(data['responseValue'][0]);
    }
  }

  Future<void> deleteMember(context) async {
    ApplicationLocalizations localization=Provider.of<ApplicationLocalizations>(context,listen: false);
    ProgressDialogue().show(context, loadingText: localization.getLocaleData.deletingData.toString());
    var body = {
      "memberId": controller.getSelectedMemberId.toString(),
    };
    var data =
        await RawData().api('Patient/deleteMember', body, context, token: true);
    ProgressDialogue().hide();
    if (data['responseCode'] == 1) {
      alertToast(context, data['responseMessage']);
      controller.updateSelectedMemberId = '';
      await getMember(
        context,
      );
    } else {
      alertToast(context, data['responseMessage']);
    }
  }
}
