

import 'dart:developer';

import 'package:digi_doctor/AppManager/progress_dialogue.dart';
import 'package:digi_doctor/AppManager/raw_api.dart';
import 'package:digi_doctor/AppManager/user_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import 'add_relation_isolation_controller.dart';

class AddRelationIsolationModal{
  AddRelationIsolationController controller=Get.put(AddRelationIsolationController());

  RawData rawData = RawData();
  UserData user = UserData();


  Future<void> getRelationIsolationData(context) async {
    controller.updateShowNoData = false;
    var body = {
      "memberId": user.getUserMemberId.toString(),
    };
    var data = await rawData.api('Patient/getHomeIsolationAlert', body, context);
    log(data.toString());
    controller.updateShowNoData = true;
    if (data['responseCode'] == 1) {
      controller.mobileC.close();
      controller.updateAddRelationIsolationList = data['responseValue'];
    }
  }


  Future<void> addRelationIsolationData(context) async {
    ProgressDialogue().show(context, loadingText: "Loading...");
    var body = {
      "memberId": user.getUserMemberId.toString(),
      "mobileNo": controller.mobileC.value.text,
      "relation": controller.relationC.value.text
    };
    var data = await rawData.api('Patient/homeIsolationAlert', body, context);
    log(data.toString());
    ProgressDialogue().hide();
    if (data['responseCode'] == 1) {
      FocusScope.of(context).requestFocus(FocusNode());
     await getRelationIsolationData(context);

    }
  }


  Future<void> deleteRelationIsolationData(context, int id) async {
    ProgressDialogue().show(context, loadingText: "Loading...");
    var body = {
      "id": id,
      "memberId": user.getUserMemberId.toString(),
    };
    var data = await rawData.api('Patient/homeIsolationAlertRemove', body, context);
    log(data.toString());
    ProgressDialogue().hide();
    if (data['responseCode'] == 1) {
      FocusScope.of(context).requestFocus(FocusNode());
      await getRelationIsolationData(context);

    }
  }
}