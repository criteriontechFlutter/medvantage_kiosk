

import 'dart:convert';

import 'package:digi_doctor/Pages/Dashboard/SearchDoctorPage/search_doctor_controller.dart';
import 'package:get/get.dart';

import '../../../AppManager/raw_api.dart';

class SearchDoctorModal{

  SearchDoctorController controller=Get.put(SearchDoctorController());

  getDoctorProfileBySpeciality(context) async {
    controller.updateShowNoData=false;
    var body = {
      "doctorName": "",
      "specialityId": ""
    };
    var data = await RawData().api(
        'Patient/getDoctorProfileBySpeciality', body, context);
    controller.updateShowNoData=true;
    if (data['responseCode'] == 1) {
      for (int i = 0;
      i < data['responseValue'].length;
      i++) {
        final uniqueJsonList = jsonDecode((data['responseValue'][i]['workingHours'] ??
            "[]"))
            .toSet()
            .toList();
        //print("------------"+uniqueJsonList.toString());
        var result = uniqueJsonList.map((item) => item['dayName'].toString().substring(0,3)).toList();




        data['responseValue'][i].addAll({'sittingDays':result});
      }
      //print('----------------------------------' +  data['responseValue'][20]['sittingDays'].toString());
      //print('----------------------------------' +  data['responseValue'][20]['drName'].toString());
      controller.updateAllDoctor = data['responseValue'];

    }
  }

  onPressedBookAppointment(index) {
    controller.tempSlots = [];
    for (int i = 0; i <
        controller.getAllDoctor[index].workingHours!.length; i++) {
      if(!controller.tempSlots.contains(controller.getAllDoctor[index].workingHours![i].dayName
          .toString()
          .substring(0, 3))){
        controller.tempSlots.add(
            controller.getAllDoctor[index].workingHours![i].dayName
                .toString()
                .substring(0, 3));
      }
      controller.update();
    }
    controller.update();
  }
}