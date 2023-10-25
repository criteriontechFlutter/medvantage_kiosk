import 'package:digi_doctor/Pages/Symptoms/Select_Doctor/select_doctor_data_modal.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class SelectDoctorController extends GetxController {


  RxBool showNoData=false.obs;
  bool get getShowNoData=>(showNoData.value);
  set updateShowNoData(bool val){
    showNoData.value=val;
    update();
  }

  List recommended_Doctors = [].obs;
  List popularDoctor = [].obs;

  List suggestionsList = [].obs;
  List problemId = [].obs;
  List get getProblemId=>problemId;
  set updateProblemId(List val){
    problemId=val;
    update();
  }

  set update_recommended_doctors(List val){
     recommended_Doctors = val;
    // recommended_Doctors = val[0]['recomendedDoctor'];
    // popularDoctor = val[0]['popularDoctor'];
     popularDoctor = val;
    update();
  }

  List<RecommendedDoctorDataModal> get get_recommended_Doctors_Data=>List<RecommendedDoctorDataModal>.from(
      (
          (searchC.value.text==''?recommended_Doctors:recommended_Doctors.where((element) =>
              (
                  element['drName'].toString().toLowerCase().trim()
                  +
                  element['speciality'].toString().toLowerCase().trim()
                  +
                  element['hospitalName'].toString().toLowerCase().trim()

              ).trim().contains(searchC.value.text.toLowerCase().trim())
          ))
              .map((element) => RecommendedDoctorDataModal.fromJson(element))
      )
  );
  // List<PopularDoctorDataModal> get get_popular_Doctors_Data=>List<PopularDoctorDataModal>.from(
  //     (
  //         (searchC.value.text==''?popularDoctor:popularDoctor.where((element) =>
  //             (
  //                 element['drName'].toString().toLowerCase().trim()
  //                     +
  //                 element['speciality'].toString().toLowerCase().trim()
  //                     +
  //                 element['hospitalName'].toString().toLowerCase().trim()
  //
  //
  //             ).trim().contains(searchC.value.text.toLowerCase().trim())
  //         ))
  //             .map((element) => PopularDoctorDataModal.fromJson(element))
  //     )
  // );
  List<DoctorsListDataModal> get get_popular_Doctors_Data=>List<DoctorsListDataModal>.from(
      (
          (searchC.value.text==''?popularDoctor:popularDoctor.where((element) =>
              (
                  element['name'].toString().toLowerCase().trim()
                      +
                  element['department'].toString().toLowerCase().trim()
                  //     +
                  // element['hospitalName'].toString().toLowerCase().trim()


              ).trim().contains(searchC.value.text.toLowerCase().trim())
          ))
              .map((element) => DoctorsListDataModal.fromJson(element))
      )
  );
  Rx<TextEditingController> searchC = TextEditingController().obs;

  List weekDays = ["Mon","Tue","Wed","Thu","Fri","Sat","Sun"];
}
