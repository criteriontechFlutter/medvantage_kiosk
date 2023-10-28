

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'MyAppointmentDataModal/my_appointment_data_modal.dart';
import 'appointmentDataModal.dart';
import 'my_appointment_modal.dart';

class MyAppointmentController extends GetxController{

Rx<TextEditingController> search=TextEditingController().obs;


  RxBool showNoData=false.obs;
  bool get getShowNoData=>(showNoData.value);
  set updateShowNoData(bool val){
    showNoData.value=val;
    update();
  }



  List appointmentList=[].obs;

  //
  // List<MyAppointmentDataModal> get getAppointmentList=>List<MyAppointmentDataModal>.from(
  //     appointmentList.map((e) => MyAppointmentDataModal.fromJson(e)));


List<AppointmentHistoryDataModal> get getAppointmentList=>List<AppointmentHistoryDataModal>.from(
    (
        (search.value.text==''?appointmentList:appointmentList.where((element) =>
            (
                element['doctorName'].toString().toLowerCase().trim()
            ).trim().contains(search.value.text.toLowerCase().trim())
        ))
            .map((element) => AppointmentHistoryDataModal.fromJson(element))
    )
);

// List<MyAppointmentDataModal> get getAppointmentList=>List<MyAppointmentDataModal>.from(
//     (
//         (search.value.text==''?appointmentList:appointmentList.where((element) =>
//             (
//                 element['doctorName'].toString().toLowerCase().trim()
//             ).trim().contains(search.value.text.toLowerCase().trim())
//         ))
//             .map((element) => MyAppointmentDataModal.fromJson(element))
//     )
// );




  set updateAppointmentList(List val){
    appointmentList=val;
    update();

  }


List medVitalsList = [];
 get getMedVitalsList=>medVitalsList;
  set updateSetMedVitalList(val){
    medVitalsList=val;
    update();
  }




}