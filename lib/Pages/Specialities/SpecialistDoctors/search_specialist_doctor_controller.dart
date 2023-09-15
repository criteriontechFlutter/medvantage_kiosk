import 'package:digi_doctor/Pages/Specialities/SpecialistDoctors/DataModal/search_specialist_doctor_data_modal.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class SpecialistDoctorController extends GetxController {
  Rx<TextEditingController> searchC = TextEditingController().obs;



  RxBool showNoData=false.obs;
  bool get getShowNoData=>(showNoData.value);
  set updateShowNoData(bool val){
    showNoData.value=val;
    update();
  }


  List doctorList = [].obs;

  List<SearchDataModel> get getDataList=>List<SearchDataModel>.from(
      (

          (searchC.value.text==''?doctorList:doctorList.where((element) =>
              (
                  element['drName'].toString().toLowerCase().trim()
                      +
                  element['hospitalName'].toString().toLowerCase().trim()
                      +
                      element['speciality'].toString().toLowerCase().trim()
              ).trim().contains(searchC.value.text.toLowerCase().trim())
          ))
              .map((element) => SearchDataModel.fromJson(element))
      ));


  set updateDoctorList(List val) {
    doctorList = val;
    update();
  }

  List timeSlot=[];
  List get getTimeSlot=>timeSlot;
  set updateTimeSlot(List val){
    timeSlot=val;
    update();
  }

  List weekDays = ["Mon","Tue","Wed","Thu","Fri","Sat","Sun"];

  RxBool isFavoriteDoctor = false.obs;
  bool get getIsFavoriteDoctor=>isFavoriteDoctor.value;
  set updateIsFavoriteDoctor(bool val){
    isFavoriteDoctor.value=val;
    update();
  }

}
