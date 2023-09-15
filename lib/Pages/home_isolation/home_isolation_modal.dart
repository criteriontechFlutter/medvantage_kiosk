import '../../../Localization/app_localization.dart';
import 'package:digi_doctor/AppManager/progress_dialogue.dart';
import 'package:digi_doctor/Pages/home_isolation/IsolationHistory/isolation_history_view.dart';
import 'package:flutter/material.dart';

import 'package:digi_doctor/AppManager/alert_dialogue.dart';
import 'package:digi_doctor/AppManager/user_data.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../AppManager/app_util.dart';
import '../../AppManager/raw_api.dart';
import 'home_isolation_controller.dart';

class HomeModal {
  final RawData rawData = RawData();
  App app = App();
  UserData userData = UserData();
  HomeIsolationController controller = Get.put(HomeIsolationController());

  Future<void> onPressedRequest(context) async {
    ApplicationLocalizations localization=Provider.of<ApplicationLocalizations>(context,listen: false);

    if (controller.formKey.value.currentState!.validate()) {
      if (controller.getSelectedHospitalId != 0) {
        onPressedConfirm() async {
          Navigator.pop(context);
          await postHomeIsolation(context);
        }

        AlertDialogue().show(context,
            msg: localization.getLocaleData.areSureYouWantRequest.toString(),
            firstButtonName: localization.getLocaleData.confirm.toString(),
            showOkButton: false, firstButtonPressEvent: () {
              onPressedConfirm();
            }, showCancelButton: true);
        //if (controller.getSelectedPackageId != 0) {
        //   if (controller.getLifeSupportId != 0) {
        //
        //   }
          // else {
          //   alertToast(context, localization.getLocaleData.alertToast!.pleaseSelectLifeSupport.toString());
          // }
       // }

        // else {
        //   alertToast(context, localization.getLocaleData.alertToast!.pleaseSelectPackage.toString());
        // }
      }
      else {
        alertToast(context, localization.getLocaleData.alertToast!.pleaseSelectHospital.toString());
      }
    }
  }

  Future<void> getHospitalList(context) async {
    var body = {"id": 62.toString(), "name": ""};
    var data = await rawData.api(
        'Patient/getHospitalListForHomeIsolation', body, context,
        token: true);
    if (data['responseCode'] == 1) {
      controller.updateHospitalList = data['responseValue'];
    }
  }

  Future<void> getIsolationPackage(context) async {
    var body = {"": ''};
    var data = await rawData
        .api('Patient/getHospitalAndPackageList', body, context, token: true);
    if (data['responseCode'] == 1) {
      controller.updateHospitalPackageList =
          data['responseValue'][0]['packageList'];
    }
  }

  Future<void> postHomeIsolation(context) async {
    ApplicationLocalizations localization=Provider.of<ApplicationLocalizations>(context,listen: false);

    ProgressDialogue().show(context, loadingText: localization.getLocaleData.submittingData.toString());

    var body = {
      "memberId": controller.memberId!=""?controller.memberId:userData.getUserMemberId.toString(),
      "hospitalId": controller.getSelectedHospitalId.toString(),
      "comorbidities": controller.comorBidController.value.text.toString(),
      "currentProblem": controller.symptomsController.value.text.toString(),
      "packageId": controller.getSelectedPackageId.toString(),
      "testdate": controller.testDateController.value.text.toString(),
      "allergires": controller.allergyController.value.text.toString(),
      "lifeSupport": controller.getLifeSupportId.toString(),
      "o2": controller.spoController.value.text.toString(),
      "onSetDate": controller.onSetDateController.value.text.toString(),
      "testTypes": controller.getCovidTestTypeId.toString(),
      "dtDataTable": ""
    };
    var data = await rawData.api('Patient/homeIsolationRequest', body, context,
        token: true);

    ProgressDialogue().hide();
    if (data['responseCode'] == 1) {
      alertToast(context, localization.getLocaleData.alertToast!.requestSubmittedSuccessfully.toString());
      App().replaceNavigate(context, IsolationHistoryView());
    }
  }
}
