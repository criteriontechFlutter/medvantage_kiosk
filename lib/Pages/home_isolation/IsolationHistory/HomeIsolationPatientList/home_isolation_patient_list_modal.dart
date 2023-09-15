


import 'dart:developer';

import 'package:digi_doctor/AppManager/raw_api.dart';
import 'package:digi_doctor/AppManager/user_data.dart';
import 'package:digi_doctor/Pages/home_isolation/IsolationHistory/HomeIsolationPatientList/home_isolation_patient_list_controller.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';

class HomeIsolationPatientListModal {
  HomeIsolationPatientListController controller = Get.put(HomeIsolationPatientListController());
  RawData rawData = RawData();
  UserData user = UserData();

  Future<void> getHomeIsolationPatientList(context) async {
    controller.updateShowNoData = false;
    var body = {
      "memberId": user.getUserMemberId.toString(),
    };
    var data =
    await rawData.api('Patient/getAllHomeIsolationRequestList', body, context);
    log(data.toString());
    controller.updateShowNoData = true;
    if (data['responseCode'] == 1) {
      controller.updateHomeIsolationPatientList = data['responseValue'];
    }
  }
}