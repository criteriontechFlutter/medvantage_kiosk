

import 'package:digi_doctor/Pages/VitalPage/DataModal/vital_history_data_modal.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';


class VitalHistoryController extends GetxController{


  Rx<TextEditingController> dateFromC=TextEditingController().obs;
  Rx<TextEditingController> dateToC=TextEditingController().obs;

  List vitalHistoryList=[].obs;
  List vitalDetailsList =[].obs;

  List<VitalHistoryDataModal> get getVitalHistoryList=>List<VitalHistoryDataModal>.from(
      vitalHistoryList.map((element) => VitalHistoryDataModal.fromJson(element))
  );

  set updateVitalHistoryList(List val){
    vitalHistoryList=val;
    update();
  }


  updateHistoryData(int index, bool val){
    vitalHistoryList[index]['isSelected']=!val;
    update();
  }

  RxBool showNoData=false.obs;
  bool get getShowNoData=>(showNoData.value);
  set updateShowNoData(bool val){
    showNoData.value=val;
    update();
  }

}