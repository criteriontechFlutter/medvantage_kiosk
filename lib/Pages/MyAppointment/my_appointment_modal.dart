import 'dart:developer';

import 'package:digi_doctor/Pages/MyAppointment/my_appointment_controller.dart';
import 'package:get/get.dart';

import '../../AppManager/raw_api.dart';
import '../../AppManager/user_data.dart';

class MyAppointmentModal {
  MyAppointmentController controller = Get.put(MyAppointmentController());
  RawData rawData = RawData();
  UserData user = UserData();

  Future<void> getPatientAppointmentList(context) async {
    controller.updateShowNoData = false;
    var body = {
      "memberId": user.getUserMemberId.toString(),
    };
    var data =
        await rawData.api('Patient/getPatientAppointmentList', body, context);
    log(data.toString());
    controller.updateShowNoData = true;
    if (data['responseCode'] == 1) {
      controller.updateAppointmentList = data['responseValue'];
    }
  }
}
