  import 'dart:convert';
import 'dart:developer';

import 'package:digi_doctor/AppManager/raw_api.dart';
import 'package:digi_doctor/AppManager/user_data.dart';
import 'package:digi_doctor/Pages/Specialities/SpecialistDoctors/search_specialist_doctor_controller.dart';
import 'package:get/get.dart';

import '../../../AppManager/alert_dialogue.dart';
import '../../../AppManager/app_util.dart';
import '../../../AppManager/progress_dialogue.dart';
import '../../../SignalR/raw_data_84.dart';
import '../../Dashboard/dashboard_controller.dart';
import '../../Dashboard/dashboard_modal.dart';
import '../top_specialities_controller.dart';
import 'DataModal/search_specialist_doctor_data_modal.dart';

class SpecialistDoctorModal {
  SpecialistDoctorController controller = Get.put(SpecialistDoctorController());
  TopSpecController topController = Get.put(TopSpecController());
  //DashboardController dashboardController = Get.find();
  DashboardModal dashboardModal = DashboardModal();
  RawData rawData = RawData();
  UserData user = UserData();



  Future<void> getDoctorList(
    context, String departmentId,
  ) async {
    controller.updateShowNoData = false;
    var body = {
      //"specialityId": topController.getSelectedId.toString(),
      //"id": user.getUserMemberId.toString()
    };
   // var data = await RawData().api("Patient/getDoctorProfileBySpeciality", body, context);
   var data = await RawData84().getapi("/api/Users/GetDoctorByDepartmentId?departmentId=$departmentId",{});

    controller.updateShowNoData = true;
    //log('--------------------'+data.toString());

    if(data['status']==1){
      log("DoctorListApi"+data.toString());
      controller.updateDoctorList = data['responseValue'];
    }else{
      alertToast(context, data['responseMessage']);
    }
    // if (data['responseCode'] == 1) {
    //   for (int i = 0;
    //   i < data['responseValue'].length;
    //   i++) {
    //     final uniqueJsonList = jsonDecode((data['responseValue'][i]['workingHours'] ??
    //         "[]"))
    //         .toSet()
    //         .toList();
    //     //print("------------"+uniqueJsonList.toString());
    //     var result = uniqueJsonList.map((item) => item['dayName'].toString().substring(0,3)).toList();
    //     data['responseValue'][i].addAll({'sittingDays':result});
    //   }
    //   controller.updateDoctorList = data['responseValue'];
    // } else {
    //   alertToast(context, data['responseMessage']);
    // }
  }

  Future<void> timeSlot(SearchDataModel doctor) async {
    controller.updateTimeSlot = [];
    // for (int i = 0; i < doctor.workingHours!.length; i++) {
    //   if(!controller.timeSlot.contains(doctor.workingHours![i].dayName.toString().substring(0, 3))){
    //     controller.timeSlot
    //         .add(doctor.workingHours![i].dayName.toString().substring(0, 3));
    //   }
    // }
    controller.update();
  }

  addFavouriteDoctor(context,String doctorId,int status) async {
    //ApplicationLocalizations localization=Provider.of<ApplicationLocalizations>(context,listen: false);

    ProgressDialogue().show(context, loadingText: 'Loading...');
    var body = {
      "patientId": user.getUserMemberId.toString(),
      "doctorId": doctorId,
      "status": status,
    };
    var data =
    await rawData.api('Patient/PatientFavouriteDoctor', body, context);

    if (data['responseCode'] == 1) {
      for(int i=0;i<controller.doctorList.length;i++){
        if(controller.doctorList[i]['id'].toString()==doctorId.toString()){
          controller.doctorList[i]['isFavourite']=int.parse(status.toString());
          controller.update();
          onBackApiCall=true;
        }
      }
      alertToast(context, data['responseMessage']);
      //Position locationData = await MapModal().getCurrentLocation(context);
      //await dashboardModal.getLocation(context);
      //await dashboardModal.getDashboardData(context, locationData);
    } else {
      alertToast(context, data['responseMessage']);
    }
    ProgressDialogue().hide();
    return data;
  }

}
