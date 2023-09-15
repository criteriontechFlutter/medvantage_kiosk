import 'package:flutter/cupertino.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:provider/provider.dart';

import '../../../Localization/app_localization.dart';
import '../../MyAppointment/my_appointment_view.dart';
import '../../Specialities/top_specialities_view.dart';

class FooterController extends GetxController {


  RxInt containerIndex =0.obs;
  int get getContainerIndex => containerIndex.value;
  set updateContainerIndex(int val){
    containerIndex.value = val;
    update();
  }

  List<DataModal> getDashboard(context) {
    ApplicationLocalizations localization = Provider.of<
        ApplicationLocalizations>(context, listen: false);
    //*******
    return [
      DataModal(
        containerImage: "assets/consult_doctor_kiosk.png",
        //containerText: "Consult Doctor",
         containerText: localization.getLocaleData.hintText!.consultDoctor.toString(),
        route: TopSpecialitiesView(),
      ),
      DataModal(
        containerImage: "assets/quick_health_kiosk.png",
         containerText: localization.getLocaleData.hintText!.quickHealth.toString(),
        //containerText: "Quick Health checkup",
        // route:alertToast(context, "ksdhkf"),
      ),
      DataModal(
        containerImage: 'assets/medical_history_kiosk.png',
        containerText: localization.getLocaleData.hintText!.medicalHistory.toString(),
        //containerText: "Medical History",
        route: const MyAppointmentView(),
      )
    ];
  }

}
class DataModal{
  String?containerText;
  String?containerImage;
  Widget?route;

  DataModal({
    this.containerImage,
    this.containerText,
    this.route
  });

}