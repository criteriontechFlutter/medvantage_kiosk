import 'dart:developer';

import 'package:digi_doctor/Pages/SymptomTracker/DataModal/problem_data_modal.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import 'DataModal/attribute_data_modal.dart';

class SymptomTrackerController extends GetxController {
  Rx<TextEditingController> dateC = TextEditingController().obs;

  RxString selectedProblemId = ''.obs;


  List problems = [].obs;

  List<ProblemDataModal> get getProblems => List<ProblemDataModal>.from(
      problems.map((element) => ProblemDataModal.fromJson(element)));

  set updateProblems(List val) {
    problems = val;
    update();
  }

  List temp = [];

  addAttributeList(problemId,attributeId, attributeValueId,moreSymptoms) {
    bool isExist = false;
    int abc = 0;
    if (temp.isEmpty) {
      temp.add({
        'problemId': problemId,
        'attributeId':attributeId,
        'attributeValueId': attributeValueId,
      });
    } else {
      for (int i = 0; i < temp.length; i++) {
        if (temp[i]['attributeValueId'] == attributeValueId) {
          isExist = true;
          abc = i;
        }
      }
      if (isExist) {
        temp.removeAt(abc);
      } else {
        temp.add({
          'problemId': problemId,
          'attributeId':attributeId,
          'attributeValueId': attributeValueId,
        });
      }
    }
    update();
    print('----------' + temp.toString());


    moreSymptoms=='moreSymptoms'? moreSymptomsList[getSelectedIndex]['selectedAttributeList']=temp:problems[getSelectedIndex]['selectedAttributeList']=temp;


    log('777777777777777777777777777777' + moreSymptomsList.toString());
    log('88888888888888888888888888888' + problems.toString());

  }

  List selectedProblem = [].obs;

  List<ProblemDataModal> get getSelectedProblems => List<ProblemDataModal>.from(
      selectedProblem.map((element) => ProblemDataModal.fromJson(element)));

  List get getSelectedProblemIds =>
      selectedProblem.map((e) => e['problemId']).toList();

  set updateSelectedProblems(ProblemDataModal problem) {
    if (getSelectedProblemIds.contains(problem.problemId)) {
      selectedProblem
          .removeWhere((element) => element['problemId'] == problem.problemId);

      problems[getSelectedIndex]['selectedAttributeList']=[];
      log('88888888888888888888888888888' + problems.toString());

    } else {
      selectedProblem.add(problem.toJson());
    }

    print(selectedProblem);
    print(getSelectedProblemIds);
    update();
  }

  List attributeList = [].obs;

  List<AttributeDataModal> get getAttributeList =>
      List<AttributeDataModal>.from(
          attributeList.map((element) => AttributeDataModal.fromJson(element)));

  set updateAttributeList(List val) {
    attributeList = val;
    update();
  }

  RxInt selectedIndex=0.obs;
  int get getSelectedIndex=>selectedIndex.value;
  set updateSelectedIndex(int val){
    selectedIndex.value=val;
    update();
  }


  List moreSymptomsList=[].obs;

  List<ProblemDataModal> get getMoreSymptomsList =>
      List<ProblemDataModal>.from(
          moreSymptomsList.map((element) => ProblemDataModal.fromJson(element)));
  set updateMoreSymptoms(List val){
    moreSymptomsList=val;
    update();
  }

  List selectedMoreProblem = [].obs;
  List get getSelectedMoreProblem =>
      selectedMoreProblem.map((e) => e['problemId']).toList();

  set updateSelectedMoreProblem(ProblemDataModal problemID) {
    if (getSelectedMoreProblem.contains(problemID.problemId)) {
      selectedMoreProblem
          .removeWhere((element) => element['problemId'] == problemID.problemId);

      moreSymptomsList[getSelectedIndex]['selectedAttributeList']=[];
      log('88888888888888888888888888888' + problems.toString());

    } else {
      selectedMoreProblem.add(problemID.toJson());
    }

    print(selectedMoreProblem);
    print(getSelectedProblemIds);
    update();
  }




List allProblemList=[].obs;
  List get getAllProblemList=>allProblemList;
  set updateAllProblemList(List val){
    allProblemList=val;
    update();
  }

  RxString selectedView=''.obs;
  String get getSelected=>selectedView.value;
  set updateSelectedView(String val){
    selectedView.value=val;
    update();
  }


  }
