

import 'package:digi_doctor/AppManager/alert_dialogue.dart';
import 'package:digi_doctor/AppManager/app_util.dart';
import 'package:digi_doctor/AppManager/raw_api.dart';
import 'package:digi_doctor/AppManager/user_data.dart';
import 'package:digi_doctor/Pages/VitalPage/VitalsChart/vital_chart_controller.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';

import '../vital.controller.dart';



class VitalChartModal{


  // WritePrescriptionController prescriptionController=Get.put(WritePrescriptionController());
  App app=App();
  UserData user=UserData();
  RawData rawData=RawData();
  //PrescribedPatientsDetailsController pDC = Get.put(PrescribedPatientsDetailsController());
  VitalChartController controller = Get.put(VitalChartController());

  VitalController vitalController = Get.put(VitalController());
  // PrescribedPatientsDetailsController prescribedPatientsDetailsController=Get.put(PrescribedPatientsDetailsController());

  getVitalsData(context,) async {
    var body = {
      // 'memberId' :prescribedPatientsDetailsController.isPrescribedPatientDetails.value?prescribedPatientsDetailsController.getSelectedPatientMemberId.toString():prescriptionController.getMemberId.toString(),
      'vitalId' : vitalController.getSelectVitals['id'].toString(),
      'memberId': UserData().getUserMemberId.toString()

    };

    var data = await  rawData.api('Patient/getPatientVitalList', body, context,token: true);

    print(data);

    if (data['responseCode']==1) {
      controller.updateVitalData = data['responseValue'];
      if(controller.getVitalData.isEmpty){
        controller.updateShowNoData=true;
      }
      // if(controller.get)

    }
    else {
      alertToast(context, data['responseMessage']);
    }

    return data;
  }




}