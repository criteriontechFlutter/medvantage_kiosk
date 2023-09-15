import 'dart:convert';

import '../../../Localization/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:digi_doctor/AppManager/alert_dialogue.dart';
import 'package:digi_doctor/AppManager/raw_api.dart';
import 'package:digi_doctor/AppManager/user_data.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import '../../../AppManager/app_util.dart';
import '../../../AppManager/progress_dialogue.dart';
import '../investigation_view.dart';
import 'add_investigation_controller.dart';

class AddInvestigationModal {
  AddInvestigationController controller = Get.put(AddInvestigationController());
  RawData rawData = RawData();
  UserData userData = UserData();

  void clearTestField() {
    controller.testNameC.value.clear();
    controller.valueC.value.clear();
    controller.unitC.value.clear();
    controller.remarkC.value.clear();
    controller.update();
  }

  onPressedAddTest(context) {
    ApplicationLocalizations localization=Provider.of<ApplicationLocalizations>(context,listen: false);

    bool isExist = false;
    if (controller.testNameC.value.text != '') {
      if (controller.valueC.value.text != '') {
        if (controller.unitC.value.text != '') {
          if (controller.addedTestList.isNotEmpty) {
            for (int i = 0; i < controller.addedTestList.length; i++) {
              if (controller.addedTestList[i]['testName']
                  .contains(controller.testNameC.value.text)) {
                isExist = true;
              }
            }
            if (isExist == false) {
              controller.addedTestList.add({
                'testName': controller.testNameC.value.text.toString(),
                'testId': controller.testID.value.toString(),
                'testValue': controller.valueC.value.text.toString(),
                'unit': controller.unitC.value.text.toString(),
                'unitId': controller.unitID.toString(),
                'remark': controller.remarkC.value.text.toString()
              });
              controller.update();
            } else {
              alertToast(context, localization.getLocaleData.message.toString());
            }
            clearTestField();
          } else {
            controller.addedTestList.add({
              'testName': controller.testNameC.value.text.toString(),
              'testId': controller.testID.value.toString(),
              'testValue': controller.valueC.value.text.toString(),
              'unit': controller.unitC.value.text.toString(),
              'unitId': controller.unitID.toString(),
              'remark': controller.remarkC.value.text.toString()
            });
            controller.update();
            clearTestField();
          }
        } else {
          alertToast(context, localization.getLocaleData.alertToast!.pleaseAddUnit.toString());
        }
      } else {
        alertToast(context, localization.getLocaleData.alertToast!.pleaseAddValue.toString());
      }
    } else {
      alertToast(context, localization.getLocaleData.alertToast!.pleaseAddTestName.toString());
    }
  }

  getTest(context) async {
    var body = {
      'subtestName': controller.testNameC.value.text.toString(),
    };
    var data = await rawData.api('Patient/getAllTest', body, context);
    if (data['responseCode'] == 1) {
      controller.updateSearchedTest = data['responseValue'];
    }
  }

  getUnit(context) async {
    var body = {
      //'alphabet':controller.unitC.value.text.toString(),
      'userMobileNo': userData.getUserMobileNo.toString()
    };
    var data =
        await rawData.api("Doctor/getAllUnit", body, context, token: true);
    if (data['responseCode'] == 1) {
      controller.updateSearchedUnit = data['responseValue'];
    }
  }

  Future<void> addInvestigation(context, fileData) async {
    List testList = [];
    for (int i = 0; i < controller.getAddedTestList.length; i++) {
      testList.add({
        'subTestId': controller.getAddedTestList[i]['testId'].toString(),
        'testValue': controller.getAddedTestList[i]['testValue'].toString(),
        'unitId': controller.getAddedTestList[i]['unitId'].toString(),
        'testRemarks': controller.getAddedTestList[i]['remark'].toString()
      });
    }
    print("******" + controller.getAddedTestList.toString());
    var body = {
      "dtDataTable": fileData == '' ? jsonEncode(testList) : '',
      'dtFileDataTable': testList.isEmpty ? fileData.toString() : '',
      'pathologyName': controller.pathologyC.value.text.toString(),
      'receiptNo': controller.receiptC.value.text.toString(),
      'testDate': controller.testDateC.value.text.toString(),
      'memberId': user.getUserMemberId.toString()
    };
    var data = await rawData.api('Patient/patientInvestigation', body, context,
        token: true);
    if (data['responseCode'] == 1) {
      Navigator.pop(context);
      App().replaceNavigate(context, const InvestigationView());
      // Navigator.pop(context);
      //await appointmentDetails(context);
    } else {
      alertToast(context, data['responseMessage']);
    }
  }

  Future<void> saveMultipleFile(context) async {

    ApplicationLocalizations localization=Provider.of<ApplicationLocalizations>(context,listen: false);

    if (controller.formKey.value.currentState!.validate()) {
      ProgressDialogue().show(context, loadingText: localization.getLocaleData.loadingData.toString());
      Map<String, String> body = {};
      var data = await MultiPart().multiyFileApi(
          'Doctor/saveMultipleFile', body, context,
          docList: controller.getFiles);
      ProgressDialogue().hide();
      print('*********' + data.toString());
      print('*********' + controller.getFiles.toString());
      if (jsonDecode(data['data'])['responseCode'] == 1) {
        await addInvestigation(
            context, jsonDecode(data['data'])['responseValue'].toString());
      }
      ProgressDialogue().hide();
    }
  }
}
