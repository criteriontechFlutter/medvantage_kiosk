


import 'package:digi_doctor/Pages/Dashboard/AssociationDoctor/association_doctor_data_modal.dart';
import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class AssociationDoctorController extends GetxController {

  RxBool showNoData = false.obs;
  TextEditingController searchName = TextEditingController();
  bool get getShowNoData => (showNoData.value);
  set updateShowNoData(bool val) {
    showNoData.value = val;
    update();
  }

  List associationDoctorList = [];
  List<AssociationDoctorModal> get getAssociationDoctorList =>
      List<AssociationDoctorModal>.from(
          (
              (searchName.text==''?associationDoctorList:associationDoctorList.where((element) =>
                  (
                      element['name'].toString().toLowerCase().trim()
                  ).trim().contains(searchName.value.text.toLowerCase().trim())
              )).map((element) => AssociationDoctorModal.fromJson(element))));



  set updateAssociationDoctorList(List val) {
    associationDoctorList = val;
    update();
  }

}


