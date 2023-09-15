


import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../DataModal/symptom_history_data_modal.dart';

class SymptomHistoryController extends GetxController{


  Rx<TextEditingController> dateFromC=TextEditingController().obs;
  Rx<TextEditingController> dateToC=TextEditingController().obs;

  RxBool showNoData=false.obs;
  bool get getShowNoData=>showNoData.value;
  set updateShowNoData(bool val){
    showNoData.value=val;
    update();
  }

  List symptomDataList=[].obs;
  List<SymptomsHistoryDataModal> get getSymptomDataList => List<SymptomsHistoryDataModal>.from(
      symptomDataList.map((element) => SymptomsHistoryDataModal.fromJson(element)));
  set updateSymptomDataList(List val){
    symptomDataList=val;
    update();
  }
}