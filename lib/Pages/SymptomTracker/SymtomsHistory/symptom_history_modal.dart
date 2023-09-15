
import 'package:digi_doctor/Pages/SymptomTracker/SymtomsHistory/symptom_history_controller.dart';
import 'package:get/get.dart';

import '../../../AppManager/raw_api.dart';
import '../../../AppManager/user_data.dart';
class SymptomHistoryModal{

  SymptomHistoryController controller=Get.put(SymptomHistoryController());

    getPatientSymptomDateWiseHistory(context) async {
     controller.updateShowNoData=false;
     var body={
       "memberId":UserData().getUserMemberId.toString(),
       "fromSymptomDate":controller.dateFromC.value.text,
       "toSymptomDate":controller.dateToC.value.text,
     };
     var data=await RawData().api('Patient/getPatientSymptomDateWiseHistory', body, context);
     controller.updateShowNoData=true;

     if(data['responseCode']==1){
       controller.updateSymptomDataList=data['responseValue'];
     }
   }

}