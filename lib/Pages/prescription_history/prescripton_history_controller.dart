import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import 'dataModal/prescription_history_data_modal.dart';

class PrescriptionHistoryController extends GetxController{

  List prescriptionHistoryList = [].obs;

  List<PrescriptionHistoryDataModal> get getPrescriptionHistoryList=>List<PrescriptionHistoryDataModal>.from(
      prescriptionHistoryList.map((element) => PrescriptionHistoryDataModal.fromJson(element))
  );

  set updatePrescriptionHistoryList(List val){
    prescriptionHistoryList=val;
    update();
  }


  RxBool showNoData=false.obs;
  bool get getShowNoData=>showNoData.value;
  set updateShowNoData(bool val){
    showNoData.value=val;
    update();
  }




  RxString prescriptionPhotoPath = ''.obs;

  get getPrescriptionPhotoPath => prescriptionPhotoPath.value;

  set updatePrescriptionPhotoPath(String val) {
    prescriptionPhotoPath.value = val;
    update();
  }

  Rx<TextEditingController> dateController = TextEditingController().obs;



}