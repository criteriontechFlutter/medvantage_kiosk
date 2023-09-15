



import 'package:digi_doctor/Pages/home_isolation/DataModal/add_relation_isolation_data_modal.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class AddRelationIsolationController extends GetxController{


  Rx<TextEditingController> relationC=TextEditingController().obs;
  Rx<TextEditingController> mobileC=TextEditingController().obs;


  set updateSelectedRelation(String val){
    relationC.value.text=val;
    update();
  }





  RxBool showNoData = false.obs;

  bool get getShowNoData => (showNoData.value);
  set updateShowNoData(bool val) {
    showNoData.value = val;
    update();
  }

  List addRelationList = [].obs;
  List<AddRelationIsolationDataModal> get getIsolationPatientList =>
      List<AddRelationIsolationDataModal>.from(
          addRelationList.map((e) =>
              AddRelationIsolationDataModal.fromJson(e)));

  set updateAddRelationIsolationList(List val) {
    addRelationList = val;
    print(addRelationList.toString());
    update();
  }

}