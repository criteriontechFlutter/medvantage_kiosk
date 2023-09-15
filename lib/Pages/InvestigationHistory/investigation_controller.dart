// import 'package:digi_doctor/Pages/InvestigationHistory/radiology/radiology_data_model.dart';
// import 'package:get/get.dart';
//
// import 'DataModal/era_investigation_data_modal.dart';
// import 'DataModal/investigation_history_data_modal.dart';
// import 'DataModal/radiology_data_modal.dart';
//
// class InvestigationController extends GetxController {
//   RxString selectedTab = ''.obs;
//
//   String get getSelectedTab => selectedTab.value;
//
//   set updateSelectedTab(String val) {
//     selectedTab.value = val;
//     update();
//   }
//
//   RxBool showNoData = false.obs;
//
//   bool get getShowNoData => showNoData.value;
//
//   set updateShowNoData(bool val) {
//     showNoData.value = val;
//     update();
//   }
//
//   List manuallyList = [].obs;
//
//   List<InvestigationHistoryDataModal> get getManuallyList =>
//       List<InvestigationHistoryDataModal>.from(manuallyList
//           .map((element) => InvestigationHistoryDataModal.fromJson(element)));
//
//   set updateManuallyList(List val) {
//     manuallyList = val;
//     update();
//   }
//
//   List erasInvestigation = [].obs;
//
//   List<InvestigationResult> get getErasInvestigation =>
//       List<InvestigationResult>.from(erasInvestigation
//           .map((element) => InvestigationResult.fromJson(element)));
//
//   set updateErasInvestigation(List val) {
//     erasInvestigation = val;
//     update();
//   }
//
//   List radiologyList = [].obs;
//
//   List<RadiologyDataModal> get getRadiologyList =>
//       List<RadiologyDataModal>.from(
//           radiologyList.map((element) => RadiologyDataModal.fromJson(element)));
//
//   set updateRadiologyList(List val) {
//     radiologyList = val;
//     update();
//   }
//
//   List _radiologyReportList = [].obs;
//
//   List<RadiologyDataModel> get getRadiologyReportList =>
//       List<RadiologyDataModel>.from(
//           _radiologyReportList.map((element) => RadiologyDataModel.fromJson(element)));
//
//   set updateRadiologyReportList(List val) {
//     _radiologyReportList = val;
//     update();
//   }
// }


import 'package:digi_doctor/Pages/InvestigationHistory/Microbiology/microbiology_data_model.dart';
import 'package:digi_doctor/Pages/InvestigationHistory/radiology/radiology_data_model.dart';
import 'package:get/get.dart';

import 'DataModal/era_investigation_data_modal.dart';
import 'DataModal/investigation_history_data_modal.dart';
import 'DataModal/radiology_data_modal.dart';
import 'Microbiology/microbiology_data_model.dart';

class InvestigationController extends GetxController {
  RxString selectedTab = ''.obs;

  String get getSelectedTab => selectedTab.value;

  int isNotification = 0;
  int get getIsNotification=>isNotification;
  set updateIsNotification(val){
    isNotification=val;
    update();
  }

  int pid = 0;
  int get getPID=>pid;
  set updatePID(val){
    pid=val;
    update();
  }

  set updateSelectedTab(String val) {
    selectedTab.value = val;
    update();
  }

  RxBool showNoData = false.obs;

  bool get getShowNoData => showNoData.value;

  set updateShowNoData(bool val) {
    showNoData.value = val;
    update();
  }

  List manuallyList = [].obs;
  List bmiList=[].obs;

  List<InvestigationHistoryDataModal> get getManuallyList =>
      List<InvestigationHistoryDataModal>.from(manuallyList
          .map((element) => InvestigationHistoryDataModal.fromJson(element)));

  set updateManuallyList(List val) {
    manuallyList = val;
    update();
  }

  List<BmiModel> get getBmI =>
      List<BmiModel>.from(bmiList
          .map((element) => BmiModel.fromJson(element)));

  set updateBmi(List val) {
    bmiList = val;
    update();
  }

  List erasInvestigation = [].obs;

  List<InvestigationResult> get getErasInvestigation =>
      List<InvestigationResult>.from(erasInvestigation
          .map((element) => InvestigationResult.fromJson(element)));

  set updateErasInvestigation(List val) {
    erasInvestigation = val;
    update();
  }


  List microbiologyList = [].obs;

  List<MicrobiologyDataModel> get getMicrobiologyList =>
      List<MicrobiologyDataModel>.from(
          microbiologyList.map((element) => MicrobiologyDataModel.fromJson(element)));

  set updateMicrobiologyList(List val) {
    microbiologyList = val;
    update();
  }

  List radiologyList = [].obs;

  List<RadiologyDataModal> get getRadiologyList =>
      List<RadiologyDataModal>.from(
          radiologyList.map((element) => RadiologyDataModal.fromJson(element)));

  set updateRadiologyList(List val) {
    radiologyList = val;
    update();
  }



  List _radiologyReportList = [].obs;

  List<RadiologyDataModel> get getRadiologyReportList =>
      List<RadiologyDataModel>.from(
          _radiologyReportList.map((element) => RadiologyDataModel.fromJson(element)));

  set updateRadiologyReportList(List val) {
    _radiologyReportList = val;
    update();
  }
}

class BmiModel {
  int? id;
  int? memberId;
  double? height;
  double? weight;
  double? bmiValue;
  double? hyderation;
  double? visceralFat;
  double? muscleMass;
  double? metabolicRating;
  double? metabolicAge;
  double? boneMass;
  String? createdAt;
  int? status;

  BmiModel(
      {this.id,
        this.memberId,
        this.height,
        this.weight,
        this.bmiValue,
        this.hyderation,
        this.visceralFat,
        this.muscleMass,
        this.metabolicRating,
        this.metabolicAge,
        this.boneMass,
        this.createdAt,
        this.status});

  BmiModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    memberId = json['memberId'];
    height = json['height'];
    weight = json['weight'];
    bmiValue = json['bmiValue'];
    hyderation = json['hyderation'];
    visceralFat = json['visceralFat'];
    muscleMass = json['muscleMass'];
    metabolicRating = json['metabolicRating'];
    metabolicAge = json['metabolicAge'];
    boneMass = json['boneMass'];
    createdAt = json['createdAt'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['memberId'] = this.memberId;
    data['height'] = this.height;
    data['weight'] = this.weight;
    data['bmiValue'] = this.bmiValue;
    data['hyderation'] = this.hyderation;
    data['visceralFat'] = this.visceralFat;
    data['muscleMass'] = this.muscleMass;
    data['metabolicRating'] = this.metabolicRating;
    data['metabolicAge'] = this.metabolicAge;
    data['boneMass'] = this.boneMass;
    data['createdAt'] = this.createdAt;
    data['status'] = this.status;
    return data;
  }
}