

import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../../../AppManager/alert_dialogue.dart';
import '../../../../Localization/app_localization.dart';
import '../../Add Vitals/add_vitals_modal.dart';
import 'oximeter_controlle.dart';


class OximeterModal {


  // DashboardController dashC=Get.put(DashboardController());
  // IPDController ipdC=Get.put(IPDController());
  OximeterController controller=Get.put(OximeterController());
  AddVitalsModel vitalModal=AddVitalsModel();


  // Press Event


  void saveData(context) async{
    ApplicationLocalizations localization=Provider.of<ApplicationLocalizations>(context,listen: false);
    if(controller.getOximeterData.spo2==null){
      alertToast(context, 'No data to save.');
    }
    else{
      vitalModal.onPressedClear(context);
      // vitalModal.controller.vitalTextX[2].text=controller.getOximeterData.spo2.toString() ;
      // vitalModal.controller.vitalTextX[0].text=controller.getOximeterData.heartRate.toString();
      // vitalModal.controller.vitalsList[6]['controller'].text=controller.getOximeterData.hrv.toString();
      // vitalModal.controller.vitalsList[6]['controller'].text=controller.getOximeterData.perfusionIndex.toString();


          var data= await vitalModal.saveDeviceVital(context,spo2: controller.getOximeterData.spo2.toString(),
         pr: controller.getOximeterData.heartRate.toString() );


      if(data['status']==0){
        alertToast( context,data['message']);
      }
      else{
        if(data['responseCode']==1){
          alertToast( context,localization.getLocaleData.dataSavedSuccessfully.toString());
        }
        else{
          alertToast( context,data['message']);
        }
      }
    }
  }



}