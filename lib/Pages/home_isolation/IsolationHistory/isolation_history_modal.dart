

 import 'package:digi_doctor/Pages/home_isolation/IsolationHistory/isolation_history_controller.dart';

import '../../../AppManager/app_util.dart';
import 'package:get/get.dart';

import '../../../AppManager/raw_api.dart';
import '../../../AppManager/user_data.dart';

class IsolationHistoryModal{

  IsolationHistoryController controller=Get.put(IsolationHistoryController());
    App app=App();
  UserData user=UserData();



  Future<void> homeIsolationRequestList(context)async{
   controller.updateShowNoData=false;
    var body={
      "memberId":UserData().getUserMemberId.toString(),
    };
    var data= await RawData().api('Patient/homeIsolationRequestList', body, context);
   controller.updateShowNoData=true;
    if(data['responseCode']==1){
      controller.updateRequestList=data['responseValue'];
    }
  }



 }