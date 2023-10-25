
import 'package:digi_doctor/AppManager/alert_dialogue.dart';
import 'package:digi_doctor/Pages/Dashboard/find_location.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../AppManager/app_util.dart';
import '../../Localization/app_localization.dart';
import '../MyAppointment/my_appointment_view.dart';
import '../Specialities/top_specialities_view.dart';


class StartupController extends GetxController{

  BuildContext?context;

  RxString containerIndex ="".obs;
  String get getContainerIndex => containerIndex.value;
  set updateContainerIndex(String val){
    containerIndex.value = val;
    update();
  }

  List<StartupDataModal> getDashboard(context) {
    ApplicationLocalizations localization = Provider.of<
        ApplicationLocalizations>(context, listen: false);
    //*******
    return [
      StartupDataModal(
        containerImage: "assets/consult_doctor_kiosk.png",
        containerText: localization.getLocaleData.hintText!.consultDoctor.toString(),
        route: TopSpecialitiesView(),
      ),
      StartupDataModal(
        containerImage: "assets/quick_helth_kiosk.png",
        containerText: localization.getLocaleData.location!.toString(),
        route: FindLocation(),
      ),
      // StartupDataModal(
      //   containerImage: "assets/quick_helth_kiosk.png",
      //   containerText: localization.getLocaleData.hintText!.quickHealth.toString(),
      //   // route:alertToast(context, "ksdhkf"),
      // ),
      StartupDataModal(
        containerImage: 'assets/medical_history_kiosk.png',
        containerText: localization.getLocaleData.hintText!.medicalHistory.toString(),
        route: const MyAppointmentView(),
      )
    ];
  }
  // List containerList=<StartupDataModal>[
  //   StartupDataModal(
  //     containerImage: "assets/consult_doctor_kiosk.png",
  //     containerText: "Consult\nDoctor",
  //     route: TopSpecialitiesView(),
  //   ),
  //   StartupDataModal(
  //     containerImage: "assets/quick_helth_kiosk.png",
  //     containerText: "Quick\nHealth\nCheckup",
  //     // route:alertToast(context, "ksdhkf"),
  //   ),
  //   StartupDataModal(
  //     containerImage: 'assets/medical_history_kiosk.png',
  //     containerText: "Medical\nHistory",
  //     route: const MyAppointmentView(),
  //   )
  // ];

}


class StartupDataModal{
   String?containerText;
   String?containerImage;
   Widget?route;

   StartupDataModal({
     this.containerImage,
     this.containerText,
     this.route
});

}