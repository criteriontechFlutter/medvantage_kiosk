


import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../DataModal/doctor_details_data_modal.dart';

class SearchDoctorController extends GetxController{

  RxBool showNoData=false.obs;
  bool get getShowNoData=>showNoData.value;
  set updateShowNoData(bool val){
    showNoData.value=val;
    update();
  }
  List tempSlots=[].obs;

  Rx<TextEditingController> searchC = TextEditingController().obs;


  List allDoctor=[].obs;
  List<DoctorDetailsDataModal> get getAllDoctor=>List<DoctorDetailsDataModal>.from(
      (
          (searchC.value.text==''?allDoctor:allDoctor.where((element) =>
              (
                  element['drName'].toString().toLowerCase().trim()+
                  element['hospitalName'].toString().toLowerCase().trim()+
                  element['speciality'].toString().toLowerCase().trim()
              ).trim().contains(searchC.value.text.toLowerCase().trim())
          ))
              .map((element) => DoctorDetailsDataModal.fromJson(element))
      ));

  List<DoctorDetailsDataModal> get getAllDashboardDoctor=>List<DoctorDetailsDataModal>.from(
      allDoctor.map((element) => DoctorDetailsDataModal.fromJson(element)));


  set updateAllDoctor(List val){
    allDoctor=val;
    update();
  }
  List weekDays = ["Mon","Tue","Wed","Thu","Fri","Sat","Sun"];
}