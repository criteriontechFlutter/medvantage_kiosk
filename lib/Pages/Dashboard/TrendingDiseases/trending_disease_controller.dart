


import 'package:digi_doctor/Pages/Dashboard/TrendingDiseases/TrendingDiseases/trending_disease_data_modal.dart';
import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class TrendingDiseaseController extends GetxController {

  RxBool showNoData = false.obs;
  TextEditingController searchDiseaseC = TextEditingController();
  bool get getShowNoData => (showNoData.value);
  set updateShowNoData(bool val) {
    showNoData.value = val;
    update();
  }

  List trendingDiseaseList = [];
  List<TrendingDiseaseDataModal> get getTrendingDiseaseList =>
      List<TrendingDiseaseDataModal>.from(
          (
              (searchDiseaseC.text==''?trendingDiseaseList:trendingDiseaseList.where((element) =>
                  (
                      element['problemName'].toString().toLowerCase().trim()
                  ).trim().contains(searchDiseaseC.value.text.toLowerCase().trim())
              )).map((element) => TrendingDiseaseDataModal.fromJson(element))));



  set updateTrendingDiseaseList(List val) {
    trendingDiseaseList = val;
    update();
  }

}


