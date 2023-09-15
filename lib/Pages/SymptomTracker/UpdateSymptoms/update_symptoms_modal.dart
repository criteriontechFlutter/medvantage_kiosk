import '../../../Localization/app_localization.dart';
import 'package:digi_doctor/AppManager/app_util.dart';
import 'package:digi_doctor/AppManager/progress_dialogue.dart';
import 'package:digi_doctor/AppManager/user_data.dart';
import 'package:digi_doctor/Pages/Dashboard/dashboard_view.dart';
import 'package:digi_doctor/Pages/SymptomTracker/UpdateSymptoms/update__sysmptoms_controller.dart';
import 'package:provider/provider.dart';

import '../../../AppManager/raw_api.dart';
import 'package:get/get.dart';

class UpdateSymptomsModal {
  UpdateSymptomsController controller = Get.put(UpdateSymptomsController());

  Future<void> onPressedSubmit(context) async {
    await updatePatientSymptomNotification(context);
  }

  Future<void> onPressedNext() async {
    controller.updateSelectedYesOrNo = '';
    if (controller.getSymptomsList.length > (controller.getCurrentIndex + 1)) {
      controller.updateCurrentIndex = controller.getCurrentIndex + 1;
    }
  }

  Future<void> onPressedPrevious() async {
    controller.updateSelectedYesOrNo = '';
    if (0 < (controller.getCurrentIndex)) {
      controller.updateCurrentIndex = controller.getCurrentIndex - 1;
    }
  }

  Future<void> getPatientSymptomNotification(context) async {
    controller.updateShowNoData = false;
    var body = {
      "memberId": controller.selectedMemberId.value == ''
          ? UserData().getUserMemberId.toString()
          : controller.selectedMemberId.value.toString()
    };
    var data = await RawData()
        .api('Patient/getPatientSymptomNotification', body, context);
    controller.updateShowNoData = true;
    if (data['responseCode'] == 1) {
      for (int i = 0; i < data['responseValue'].length; i++) {
        data['responseValue'][i].addAll({'isSelected': false});
      }
      controller.updateSymptomsList = data['responseValue'];
    }
  }

  Future<void> getMember(context) async {
    var body = {"userLoginId": UserData().getUserLoginId};
    var data =
        await RawData().api('Patient/getMembers', body, context, token: true);
    if (data['responseCode'] == 1) {
      controller.updateMemberList = data['responseValue'];
    }
  }

  Future<void> updatePatientSymptomNotification(context) async {
    ApplicationLocalizations localization=Provider.of<ApplicationLocalizations>(context,listen: false);

    ProgressDialogue().show(context, loadingText: localization.getLocaleData.submittingData.toString());
    List problemList = [];
    for (int i = 0; i < controller.symptomsList.length; i++) {
      if (controller.symptomsList[i]['isSelected'] == true) {
        problemList.add(controller.symptomsList[i]['problemId']);
      }
    }
    print(problemList.toString());

    var body = {
      "memberId": UserData().getUserMemberId.toString(),
      "problemName": problemList.join(",").toString(),
    };
    var data = await RawData()
        .api('Patient/updatePatientSymptomNotification', body, context);
    ProgressDialogue().hide();
    if (data['responseCode'] == 1) {
      App().replaceNavigate(context, const DashboardView());
    }
  }
}
