
import 'dart:convert';
import 'dart:developer';
import 'dart:ffi';
import 'package:digi_doctor/AppManager/alert_dialogue.dart';
import 'package:digi_doctor/AppManager/raw_api.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../AppManager/user_data.dart';
import 'allowPrivacy_Controller.dart';


class AllowPrivacyModel {

  AllowPrivacyController controller = Get.put(AllowPrivacyController());
  RawData rawData = RawData();
  UserData user = UserData();

  List privacyReport = [];

  Future<void> getAllowDoctorList(context) async {
    var body = {
      "memberId": user.getUserMemberId.toString(),
    };
    var data =
    await rawData.api('Doctor/getAllowedHistory', body, context);
    log(data.toString());
    if (data['responseCode'] == 1 && data['responseValue'].isNotEmpty) {
      controller.updateAllowDoctorList = data['responseValue'];
      controller.updateAllowReportList = jsonDecode(data['responseValue'][0]['privacy']);
    }else{
      alertToast(context, "No Privacy report data found");
      Navigator.pop(context);
    }
  }

  Future<void> changePrivacyReport(context, String id) async {
    var body = {
      "id": id,
    };
    var data =
    await rawData.api('Doctor/updatePrivacyToNotAllowed', body, context);
    log(data.toString());
    if (data['responseCode'] == 1) {
      getAllowDoctorList(context);
      alertToast(context, data['responseMessage']);
    }else{
      alertToast(context, data['responseMessage']);
    }
  }

}
