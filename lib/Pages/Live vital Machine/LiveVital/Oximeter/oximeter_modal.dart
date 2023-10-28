

import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../../../AppManager/alert_dialogue.dart';
import '../../../../AppManager/user_data.dart';
import '../../../../Localization/app_localization.dart';

import '../../../VitalPage/Add Vitals/add_vitals_modal.dart';
import 'oximeter_controlle.dart';


class OximeterModal {


  // DashboardController dashC=Get.put(DashboardController());
  // IPDController ipdC=Get.put(IPDController());
  OximeterController controller=Get.put(OximeterController());
  AddVitalsModel vitalModal=AddVitalsModel();


  // Press Event


  void saveData(context) async{

    AddVitalsModel vitalModal=AddVitalsModel();


    if(controller.getOximeterData.spo2==null){
      alertToast(context, 'No data to save.');
    }
    else{
      await vitalModal.medvantageAddVitals(context,
      SPO2: controller.getOximeterData.spo2.toString(),
      Pulse: controller.getOximeterData.heartRate.toString());

    }
  }



}