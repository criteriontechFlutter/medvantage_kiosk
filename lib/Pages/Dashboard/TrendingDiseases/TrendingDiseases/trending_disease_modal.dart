




import 'dart:developer';

import 'package:digi_doctor/AppManager/progress_dialogue.dart';
import 'package:digi_doctor/AppManager/raw_api.dart';
import 'package:digi_doctor/AppManager/user_data.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';

import '../trending_disease_controller.dart';

class TrendingDiseaseListModal {
  TrendingDiseaseController controller = Get.put(TrendingDiseaseController());
  RawData rawData = RawData();
  UserData user = UserData();

  Future<void> getTrendingDiseaseList(context) async {
    ProgressDialogue().show(context, loadingText: "Loading...");
    controller.updateShowNoData = false;
    var body = {
      //"userId": user.getUserMemberId,
    };
    var data =
    await rawData.api('trendingDiseaseList', body, context,isNewBaseUrl: true,newBaseUrl: "http://182.156.200.179:332/api/v1.0/Knowmed/");
    log(data.toString());
    controller.updateShowNoData = true;
    ProgressDialogue().hide();
    if (data['responseCode'] == 1) {
      controller.updateTrendingDiseaseList = data['responseValue'];
    }
  }

  Future<void> getDiseaseDetails(context, int problemId, int departmentId) async {
    controller.updateShowNoData = false;
    var body = {
      "userId": user.getUserMemberId,
      "problemId": problemId,
      "departmentId": departmentId
    };
    var data =
    await rawData.api('diseaseReport', body, context,isNewBaseUrl: true,newBaseUrl: "http://182.156.200.179:332/api/v1.0/Knowmed/");
    log(data.toString());
    controller.updateShowNoData = true;
    if (data['responseCode'] == 1) {
      controller.updateTrendingDiseaseList = data['responseValue'];
    }
  }
}