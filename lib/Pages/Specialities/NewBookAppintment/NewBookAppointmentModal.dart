



import 'package:digi_doctor/AppManager/alert_dialogue.dart';
import 'package:digi_doctor/Pages/VitalPage/LiveVital/stetho_master/AppManager/raw_api.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';


import 'NewBookAppointmentController.dart';

class NewBookAppointmentModal {


  NewBookAppointmentController controller = Get.put(NewBookAppointmentController());


  bookAppointment(context)async{
    var body={
      // "uhid": controller.uhidController.value.text.toString(),
      "uhid": "UHID00135",
      "doctorId": controller.getDoctorId,
      "departmentId": '1',
      "timeslotsId": '1',
      "appointmentDate": controller.getTime.toString(),
      "userId": '99'
    };
    var data = await RawData().api('/api/BookAppointmentMaster/InsertBookAppointmentMaster',body,context);

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
}