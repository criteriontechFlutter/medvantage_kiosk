


import 'package:digi_doctor/AppManager/app_util.dart';
import 'package:digi_doctor/AppManager/user_data.dart';
import 'package:digi_doctor/Pages/VitalPage/Add%20Vitals/VitalHistory/vital_history_controller.dart';
import 'package:get/get.dart';

import '../../../../AppManager/raw_api.dart';


class VitalHistoryModal{

  VitalHistoryController controller=Get.put(VitalHistoryController());
  App app=App();
  UserData user=UserData();


 Future<void> getPatientVitalsDateWiseHistory(context) async {
    var body={
      "memberId": UserData().getUserMemberId.toString(),
      "toDate": controller.dateToC.value.text.toString(),
      "fromDate": controller.dateFromC.value.text.toString(),
    };
    var data= await RawData().api('Patient/getPatientVitalsDateWiseHistory', body, context);
    if(data['responseCode']==1){


      for(int i=0; i<data['responseValue'].length;i++){
        data['responseValue'][i].addAll({'isSelected':false});
      }
      print('dkfdkjhfkjdhkh'+data.toString());
      controller.updateVitalHistoryList=data['responseValue'];
    }
  }
  
  
}