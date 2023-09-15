




import 'dart:developer';

import 'package:digi_doctor/AppManager/progress_dialogue.dart';
import 'package:digi_doctor/AppManager/raw_api.dart';
import 'package:digi_doctor/AppManager/user_data.dart';
import 'package:digi_doctor/Pages/Dashboard/AssociationDoctor/association_doctor_controller.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';


class AssociationDoctorListModal {
  AssociationDoctorController controller = Get.put(AssociationDoctorController());
  RawData rawData = RawData();
  UserData user = UserData();

  Future<void> getAssociationDoctorList(context) async {
    ProgressDialogue().show(context, loadingText: "Loading...");
    controller.updateShowNoData = false;
    var body = {
      "drName": ""
    };
    var data = await RawData()
        .api('Doctor/getDrListOfIMA', body, context, token: true);
    log(data.toString());
    controller.updateShowNoData = true;
    ProgressDialogue().hide();
    if (data['responseCode'] == 1) {
      controller.updateAssociationDoctorList = data['responseValue'];
    }
  }


}