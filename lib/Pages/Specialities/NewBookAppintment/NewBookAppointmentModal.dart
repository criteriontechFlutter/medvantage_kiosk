



import 'package:digi_doctor/AppManager/alert_dialogue.dart';
import 'package:digi_doctor/Pages/VitalPage/LiveVital/stetho_master/AppManager/raw_api.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get_storage/get_storage.dart';


import 'NewBookAppointmentController.dart';

class NewBookAppointmentModal {


  NewBookAppointmentController controller = Get.put(NewBookAppointmentController());


  bookAppointment(context,{ uHID,doctorId,departmentId,timeSlotsId,appointmentDate,})async{
    // var body={
    //   // "uhid": controller.uhidController.value.text.toString(),
    //   "uhid": "UHID00135",
    //   "doctorId": controller.getDoctorId,
    //   "departmentId": '1',
    //   "timeslotsId": '1',
    //   "appointmentDate": controller.getTime.toString(),
    //   "userId": '99'
    // };
    final medvantageUser = GetStorage();
    var name = medvantageUser.read('medvantageUserName');
    var uhid = medvantageUser.read('medvantageUserUHID');
    var body= {
      "uhid": uhid,
      "doctorId": doctorId,
      "departmentId": departmentId,
      "timeslotsId": 2,
      "appointmentDate": "2023-10-30T10:56:11.305Z",
      "userId": 99
    };
    var data = await RawDataApi().api('/api/BookAppointmentMaster/InsertBookAppointmentMaster',body,context);

    print('${data}12345');
    if(data['status']==1){
      alertToast(context, data["message"]);
      Navigator.pop(context);
      print("dkchuyksfgckl");
    }
    else{
      alertToast(context, data["responseValue"]);
      print("dkchuyksfgckl");

    }

  }


  Future <void> getTimeSlots(context,id)async{
    var data = await RawDataApi().getapi('/api/TimeslotMaster/GetAllTimeslotMaster?id=$id',context);
    if (kDebugMode) {
      print(data.toString());
    }
    controller.updateTimeList=data['responseValue'] as List;
    if (kDebugMode) {
      print('abc${controller.getTimeList}');
    }

  }




  Future <void> getDays(context,id)async{
    var data = await RawDataApi().getapi('/api/DayMaster/GetAllDay',context);
    if (kDebugMode) {
      print(data.toString());
    }
    controller.updateDayList=data['responseValue'] as List;
    print('abc${controller.getDayList}');

  }





}