

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'symptomCheckerDataModal.dart';

class SymptomCheckerController extends GetxController{

  Rx<TextEditingController> ageC=TextEditingController().obs;
  Rx<TextEditingController> heightC=TextEditingController().obs;
  Rx<TextEditingController> fitC=TextEditingController().obs;
  Rx<TextEditingController> inchC=TextEditingController().obs;
  Rx<TextEditingController> kgC=TextEditingController().obs;
  Rx<TextEditingController> lbsC=TextEditingController().obs;

  final formKey = GlobalKey<FormState>().obs;

  bool isMetric=true;
  bool get getIsMetric=>isMetric;
  set updateIsMetric(bool val){
    isMetric=val;
    update();
  }


  //Age unit list

  List ageUnitList=[].obs;
  List get getAgeUnitList=>ageUnitList;
  set updateAgeUnitList(List val){
    ageUnitList=val;
    update();
  }


  RxInt module=0.obs;
  int get getModule => module.value;
  set updateModule(int value){
    module.value=value;
    update();
  }
  double bmi=0.0;
  double get getBMI=>bmi;
  set updateBMI(double val){
    bmi=val;
    update();
  }




  RxBool isAnimate = false.obs;
  bool get getIsAnimate=>isAnimate.value;
  set updateIsAnimate(bool val){
    isAnimate.value=val;
    update();
  }




  RxString selectedId =''.obs;
  String get getSelectedId=>selectedId.value;
  set updateSelectedId(String val){
    selectedId.value=val;
    update();
  }

  List bodyOrganRegion=[].obs;
  List get getBodyOrganRegionList =>bodyOrganRegion;
  set updateBodyOrganRegionList(List val){
    bodyOrganRegion=val;
    update();
  }


  List allSymptomsList=[].obs;

  // List<AllSymptomsByAlphabet> get getAllSymptomsList=>searchC.value.text==''?List<AllSymptomsByAlphabet>.from(
  //     allSymptomsList.map((element) => AllSymptomsByAlphabet.fromJson(element))
  // ):List<AllSymptomsByAlphabet>.from(
  //     allSymptomsList.map((element) => AllSymptomsByAlphabet.fromJson(element))
  // ).where((element) => (element.problemName!.toLowerCase().contains(searchC.value.text.toLowerCase()))).toList();


  // List<SymptomRelatedBodyPartDataModal> get getAllSymptomsList=>List<SymptomRelatedBodyPartDataModal>.from(
  //     (
  //         (searchC.value.text==''?allSymptomsList:allSymptomsList.where((element) =>
  //             (
  //                 element['problemName'].toString().toLowerCase()
  //             ).trim().contains(searchC.value.text.toLowerCase().trim())
  //         ))
  //             .map((element) => SymptomRelatedBodyPartDataModal.fromJson(element))
  //     ));

  List<SymptomRelatedBodyPartDataModal> get getAllSymptomsList=>List <SymptomRelatedBodyPartDataModal>.from(
      allSymptomsList.map((element) => SymptomRelatedBodyPartDataModal.fromJson(element))
  );

  // List get getAllSymptomsList =>allSymptomsList;
  set updateAllSymptomsList(List val){
    allSymptomsList=val;
    update();
  }


  RxString selectSymptomId =''.obs;
  String get getSelectSymptomId=>selectSymptomId.value;
  set updateSelectSymptomId(String val){
    selectSymptomId.value=val;
    update();
  }


  String alpha ='A';
  set updateAlphabet(String val){
    alpha=val;
    update();
  }

  List onTapBodyPartSymptomsId = [];

  RxBool showNoData=false.obs;
  bool get getShowNoData=>(showNoData.value);
  set updateShowNoData(bool val){
    showNoData.value=val;
    update();
  }


  List suggestedProblemList=[].obs;
  List<SuggestedProblemDataModal> get getSuggestedProblemList=>List <SuggestedProblemDataModal>.from(
      suggestedProblemList.map((element) => SuggestedProblemDataModal.fromJson(element))
  );
   //List get getSuggestedProblemList=>suggestedProblemList;
  set updateSuggestedProblemList(List val){
    suggestedProblemList=val;
    update();
  }

  List unlocalizedProblemId =[].obs;


  //for search & add problems

  Rx<TextEditingController> searchC = TextEditingController().obs;
  List suggestedSearchList=[].obs;
  // List<SuggestedUnlocalizedProblemDataModal> get getSuggestedSearchList=>searchC.value.text==''?List<SuggestedUnlocalizedProblemDataModal>.from(
  //     suggestedSearchList.map((element) => SuggestedUnlocalizedProblemDataModal.fromJson(element))
  // ):List<SuggestedUnlocalizedProblemDataModal>.from(
  //     suggestedSearchList.map((element) => SuggestedUnlocalizedProblemDataModal.fromJson(element))
  // ).where((element) => (element.problemName!.toString().trim().toLowerCase().contains(searchC.value.text.toString().trim().toLowerCase()))).toList();

  List<SuggestedUnlocalizedProblemDataModal> get getSuggestedSearchList=>List<SuggestedUnlocalizedProblemDataModal>.from(
      (
          (searchC.value.text==''?suggestedSearchList:suggestedSearchList.where((element) =>
              (
                      element['problemName'].toString().toLowerCase().trim()
              ).trim().contains(searchC.value.text.toString().toLowerCase().trim())
          ))
              .map((element) => SuggestedUnlocalizedProblemDataModal.fromJson(element))
      ));


  set updateSuggestedSearchList(List val){
    suggestedSearchList=val;
    update();
  }





  List addOtherDiseaseList=[].obs;
  List<AddAnyOtherDiseaseDataModal> get getAddOtherDiseaseList=>List <AddAnyOtherDiseaseDataModal>.from(
      addOtherDiseaseList.map((element) => AddAnyOtherDiseaseDataModal.fromJson(element))
  );
  //List get getAddOtherDiseaseList=>addOtherDiseaseList;
  set updateAddOtherDiseaseList(List val){
    addOtherDiseaseList=val;
    update();
  }

  List diseaseSufferedId=[];


// for search & Disease

List diseaseSearchList=[].obs;
  Rx<TextEditingController> diseaseSearchC = TextEditingController().obs;

List<AddAnyOtherDiseaseDataModal> get getDiseaseSearchList=>diseaseSearchC.value.text==''?List<AddAnyOtherDiseaseDataModal>.from(
    diseaseSearchList.map((element) => AddAnyOtherDiseaseDataModal.fromJson(element))
):List<AddAnyOtherDiseaseDataModal>.from(
    diseaseSearchList.map((element) => AddAnyOtherDiseaseDataModal.fromJson(element))
).where((element) => (element.problemName!.toLowerCase().contains(diseaseSearchC.value.text.toLowerCase()))).toList();

set updateDiseaseSearchList(List val){
  diseaseSearchList=val;
  update();
}

//for on tap symptoms in suggested problem


  List problemsSymptomsTapList=[].obs;
  List<ProblemSymptomsDataModal> get getProblemsSymptomsTapList=>List <ProblemSymptomsDataModal>.from(
      problemsSymptomsTapList.map((element) => ProblemSymptomsDataModal.fromJson(element))
  );
  set updateProblemsSymptomsTapList(List val){
    problemsSymptomsTapList=val;
    update();
  }


  RxString selectedPid=''.obs;
  String get getSelectedPid=>selectedPid.value;
  set updateSelectedPid(String val){
    selectedPid.value=val;
    update();
  }

  List attributesList=[].obs;

RxInt selectedProblemIndex=0.obs;
int get getSelectedProblemIndex=>selectedProblemIndex.value;
set updateSelectedProblemIndex(int val){
  selectedProblemIndex.value=val;
  update();
}


}