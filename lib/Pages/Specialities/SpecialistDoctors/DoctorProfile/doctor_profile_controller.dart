

import 'package:get/get.dart';
import '../DataModal/time_details_data_modal.dart';
import 'doctor_profile_data_modal.dart';

class DoctorProfileController extends GetxController{


RxBool isFavoriteDoctor = false.obs;
bool get getIsFavoriteDoctor=>isFavoriteDoctor.value;
set updateIsFavoriteDoctor(bool val){
  isFavoriteDoctor.value=val;
  update();
}

  RxBool showNoData=false.obs;
  bool get getShowNoData=>(showNoData.value);

  set updateShowNoData(bool val){
    showNoData.value=val;
    update();
  }

  RxString selectedNo=''.obs;
  String get getSelectedNo=>selectedNo.value;
  set updateSelectedNo(String val){
    selectedNo.value=val;
    update();
  }

  RxString doctorId=''.obs;
  String get getDoctorId=> doctorId.value;
  set updateDoctorId(String val){
    doctorId.value=val;
    update();
  }
  //
  List profileList=[].obs;
  List sortDaysList=[].obs;
  // MyAppointmentDataModal get getMyAppoointmentData=>MyAppointmentDataModal.fromJson(
  //     myAppointmentData.isEmpty? {}:
  //     myAppointmentData[0]);
  List _doctorProfileData=[].obs;
  DoctorProfileDataModal get getDoctorProfileData=>DoctorProfileDataModal.fromJson(_doctorProfileData.isEmpty?{}:_doctorProfileData[0]);
  set updateDoctorProfileData(List val){
    _doctorProfileData=val;
    update();
  }

  List<TimeDetailsDataModal>  getProfileList(dayName)=>List<TimeDetailsDataModal>.from(
      (
          profileList.where(( element) => element['dayName'].toString().trim()==dayName.toString().trim()).toList()
      )
          .map((element) => TimeDetailsDataModal.fromJson(element))
  );

  List get getSortDaysList=>sortDaysList;
  set updateProfileList(List val){
    profileList=val;
    for (int i = 0; i < val.length; i++) {
      if(!sortDaysList.contains(val[i]['dayName'].toString().substring(0, 3))){
        sortDaysList.add(val[i]['dayName'].toString().substring(0, 3));
      }
    }
    update();
  }


  List SittingDayList=[].obs;
  List get getSittingDayList=>SittingDayList;
  set updateSittingDaysList(List val){
    SittingDayList=val;
    update();
  }
}