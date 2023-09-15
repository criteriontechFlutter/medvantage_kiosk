

import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import 'allowPrivacy_DataModal.dart';



class  AllowPrivacyController extends GetxController{

  List allowDoctorList=[].obs;
  List<PrivacyModal> get getAllowDoctorList=>List<PrivacyModal>.from(
      allowDoctorList.map((e) => PrivacyModal.fromJson(e)));
  set updateAllowDoctorList(List val){
    allowDoctorList=val;
    update();

  }

  List allowReportList=[].obs;
  List<PrivacyReportModal> get getAllowReportList=>List<PrivacyReportModal>.from(
      allowReportList.map((e) => PrivacyReportModal.fromJson(e)));
  set updateAllowReportList(List val){
    allowReportList=val;
    update();

  }


  RxBool isFavoriteDoctor = false.obs;
  bool get getIsFavoriteDoctor=>isFavoriteDoctor.value;
  set updateIsFavoriteDoctor(bool val){
    isFavoriteDoctor.value=val;
    update();
  }


}