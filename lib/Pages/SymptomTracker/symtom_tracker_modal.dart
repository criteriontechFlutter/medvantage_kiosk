import 'dart:convert';
import 'dart:developer';

import '../../../Localization/app_localization.dart';
import 'package:digi_doctor/AppManager/alert_dialogue.dart';
import 'package:digi_doctor/AppManager/raw_api.dart';
import 'package:digi_doctor/Pages/SymptomTracker/DataModal/problem_data_modal.dart';
import 'package:digi_doctor/Pages/SymptomTracker/Modules/show_attribute_list_module.dart';
import 'package:digi_doctor/Pages/SymptomTracker/symptom_tracker_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../AppManager/progress_dialogue.dart';
import '../../AppManager/user_data.dart';
import 'Modules/add_more_symptoms.dart';

class SymptomTrackerModal {
  SymptomTrackerController controller = Get.put(SymptomTrackerController());

  // On Press Events

  Future<void> onPressedProblem(context) async {
    await attributeLists(context);
  }

  void onPressProblem(ProblemDataModal problem) {
    controller.updateSelectedProblems = problem;
  }

  void onPressMoreProblem(ProblemDataModal problemID) {
    controller.updateSelectedMoreProblem = problemID;
  }

  onPressedAddMoreSymptoms(context) async {
    ApplicationLocalizations localization=Provider.of<ApplicationLocalizations>(context,listen: false);
    controller.selectedMoreProblem = [];
    controller.update();
    ProgressDialogue().show(context, loadingText: localization.getLocaleData.loadingData.toString());
    var addSymptomSata = await addSymptom(context);
    var allProblemsData = await getAllProblems(context);
    ProgressDialogue().hide();
    if ((addSymptomSata['responseCode'] == 1) ||
        (allProblemsData['responseCode'] == 1)) {
      await addMoreSymptoms(context);
    }
  }

  Future<void> onPressedSave(context) async {
    ApplicationLocalizations localization=Provider.of<ApplicationLocalizations>(context,listen: false);

    List dtDataTable = [];
    for (int i = 0; i < controller.problems.length; i++) {
      dtDataTable.addAll(controller.problems[i]['selectedAttributeList']);
    }
    for (int i = 0; i < controller.selectedProblem.length; i++) {
      var problemData = {
        "problemId": controller.selectedProblem[i]['problemId'].toString(),
        "attributeId": '0',
        "attributeValueId": '0'
      };
      dtDataTable.addAll({problemData});
    }
    for (int i = 0; i < controller.selectedMoreProblem.length; i++) {
      var problemData = {
        "problemId": controller.selectedMoreProblem[i]['problemId'].toString(),
        "attributeId": '0',
        "attributeValueId": '0'
      };
      dtDataTable.addAll({problemData});
    }

    for (int i = 0; i < controller.moreSymptomsList.length; i++) {
      dtDataTable
          .addAll(controller.moreSymptomsList[i]['selectedAttributeList']);
    }

    if (dtDataTable.isNotEmpty) {
      AlertDialogue().show(context,
          msg: localization.getLocaleData.areYouSureWantSave.toString(),
          showCancelButton: true,
          showOkButton: false,
          firstButtonName: localization.getLocaleData.yes.toString(), firstButtonPressEvent: () async {
        await addMemberProblem(context, dtDataTable);
        Navigator.pop(context);
        Navigator.pop(context);
      });
    } else {
      alertToast(context, localization.getLocaleData.alertToast!.pleaseSelectAtLeastOneSymptom.toString());
    }
  }

  Future<void> addsymptoms(context, val) async {
    ApplicationLocalizations localization=Provider.of<ApplicationLocalizations>(context,listen: false);

    bool isExist = false;
    if (controller.moreSymptomsList.isEmpty) {
      controller.moreSymptomsList.add(val);
    } else {
      for (int i = 0; i < controller.moreSymptomsList.length; i++) {
        if (controller.moreSymptomsList[i]['problemId'] == val['problemId']) {
          isExist = true;
        }
      }
      if (isExist) {
        alertToast(context, localization.getLocaleData.alertToast!.alreadyExist.toString());
      } else {
        controller.moreSymptomsList.add(val);
      }
    }
    controller.selectedProblemId.value = val['problemId'].toString();
    await attributeLists(context);
    controller.getAttributeList.isEmpty
        ? ''
        : controller.updateSelectedView = 'searchedSymptoms';

    controller.update();
  }

  // Api Calls

  Future<void> getSymptomDetail(context) async {
    var body = {
      "problemName": '',
    };
    var data = await RawData()
        .api('Patient/getProblemsWithIcon', body, context, token: true);
    if (data['responseCode'] == 1) {
      for (int i = 0; i < data['responseValue'].length; i++) {
        data['responseValue'][i].addAll({'selectedAttributeList': []});
      }

      print('--------------' + data.toString());
      controller.updateProblems = data['responseValue'];
    } else {
      alertToast(context, "responseMessage");
    }
  }

  //*************************Add symptom modal****************
  addSymptom(context) async {
    var body = {
      "memberId": UserData().getUserMemberId.toString(),
    };
    var data = await RawData()
        .api('Patient/getAllSuggestedProblem', body, context, token: true);

    if (data['responseCode'] == 1) {
      for (int i = 0; i < data['responseValue'].length; i++) {
        var additionalData = {'isSelected': false, 'selectedAttributeList': []};
        data['responseValue'][i].addAll(additionalData);
      }
      controller.updateMoreSymptoms = data['responseValue'];
      log("-------------------add symptoms----------------------------" +
          data.toString());
    }

    return data;
  }

  Future<void> attributeLists(context) async {
    ApplicationLocalizations localization=Provider.of<ApplicationLocalizations>(context,listen: false);

    ProgressDialogue().show(context, loadingText: localization.getLocaleData.loadingData.toString());
    var body = {
      "problemId": controller.selectedProblemId.toString(),
    };
    var data = await RawData()
        .api('Patient/getAttributeByProblem', body, context, token: true);
    ProgressDialogue().hide();

    if (data['responseCode'] == 1) {
      for (int i = 0; i <= data['responseValue'].length - 1; i++) {
        for (int j = 0;
            j <= data['responseValue'][i]['attributeDetails'].length - 1;
            j++) {
          data['responseValue'][i]['attributeDetails'][j]
              .addAll({'isSelected': false});
        }
      }
      controller.updateAttributeList = data['responseValue'];
      data['responseValue'].isEmpty
          ? ''
          : showAttributeDataList(context,
              moreSymptoms: controller.getSelected.toString());
    }
  }

  getAllProblems(context) async {
    var body = {"alphabet": ""};
    var data = await RawData().api('Patient/getAllProblems', body, context);
    if (data['responseCode'] == 1) {
      for (int i = 0; i < data['responseValue'].length; i++) {
        var additionalData = {'isSelected': false, 'selectedAttributeList': []};
        data['responseValue'][i].addAll(additionalData);
      }
      controller.updateAllProblemList = data['responseValue'];
    }

    return data;
  }

  Future<void> addMemberProblem(context, dtDataTable) async {
    ApplicationLocalizations localization=Provider.of<ApplicationLocalizations>(context,listen: false);
    ProgressDialogue().show(context, loadingText: localization.getLocaleData.addingData.toString());
    var body = {
      "memberId": UserData().getUserMemberId.toString(),
      "problemDate": DateFormat('yyyy-MM-dd').format(DateFormat('yyyy-MM-dd')
          .parse(controller.dateC.value.text.toString())),
      "dtDataTable": jsonEncode(dtDataTable),
      "isUpCovid": "0",
      "problemTime": DateFormat('HH:mm').format(DateFormat('yyyy-MM-dd HH:mm')
          .parse(controller.dateC.value.text.toString()))
    };
    var data = await RawData().api('Patient/addMemberProblem', body, context);
    ProgressDialogue().hide();
    print(data.toString());
  }
}
