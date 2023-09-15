import 'package:digi_doctor/Pages/Symptoms/top_symptom_data_modal.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

import 'Select_Doctor/select_doctor_data_modal.dart';

class TopSymptomsController extends GetxController {
  List symptomsList = [].obs;
  Map demoMap = {}.obs;
  List suggestionsList = [].obs;
  List demoList = [].obs;
  List selectedSymptoms=[].obs;
  List problemId = [].obs;
  List problemSaved = [].obs;
  set updateTopSymptomsList(List val){
    symptomsList = val;
    update();
  }
  set updateSuggestionsList(List val){
    suggestionsList = val;
    update();
  }
  List selectAttributes=[].obs;
  List<TopSymptomsDataModal> get getSelectAttributes=>List<TopSymptomsDataModal>.from(
      selectAttributes.map((e) => TopSymptomsDataModal.fromJson(e)));
  set updateSelectAttributes(List val){
    selectAttributes=val;
    update();
  }
  Rx<TextEditingController> searchC = TextEditingController().obs;
  List<TopSymptomsDataModal> get getSymptomsData=>List<TopSymptomsDataModal>.from(
      (
          symptomsList
              .map((element) => TopSymptomsDataModal.fromJson(element))
      ));
  List<TopSymptomsDataModal> get getSuggestionsData=>List<TopSymptomsDataModal>.from(
      (
          (searchC.value.text==''?suggestionsList:suggestionsList.where((element) =>
              (
                  element['problemName'].toString().toLowerCase()
              ).trim().contains(searchC.value.text.toLowerCase().trim())
          ))
              .map((element) => TopSymptomsDataModal.fromJson(element))
      ));






  RxBool showNoData=false.obs;
  bool get getShowNoData=>showNoData.value;
  set updateShowNoData(bool val){
    showNoData.value=val;
    update();
  }

  List recommended_Doctors = [].obs;
  List popularDoctor = [].obs;

  List<RecommendedDoctorDataModal> get get_recommended_Doctors_Data=>List<RecommendedDoctorDataModal>.from(
      (
          (searchC.value.text==''?recommended_Doctors:recommended_Doctors.where((element) =>
              (
                  element['drName'].toString().toLowerCase()
              ).trim().contains(searchC.value.text.toLowerCase().trim())
          ))
              .map((element) => RecommendedDoctorDataModal.fromJson(element))
      )
  );
  List<PopularDoctorDataModal> get get_popular_Doctors_Data=>List<PopularDoctorDataModal>.from(
      (
          (searchC.value.text==''?popularDoctor:popularDoctor.where((element) =>
              (
                  element['drName'].toString().toLowerCase()
              ).trim().contains(searchC.value.text.toLowerCase().trim())
          ))
              .map((element) => PopularDoctorDataModal.fromJson(element))
      )
  );

  set update_recommended_doctors(List val){
    recommended_Doctors = val[0]['recomendedDoctor'];
    popularDoctor = val[0]['popularDoctor'];
    update();
  }
  RxString selectedId=''.obs;


}
