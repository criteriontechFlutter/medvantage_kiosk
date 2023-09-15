import 'package:digi_doctor/AppManager/raw_api.dart';
import 'package:digi_doctor/AppManager/user_data.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';

import 'lab_test_search_controller.dart';

class LabTestSearchModal{
  LabTestSearchController controller=Get.put(LabTestSearchController());
  searchPackageAndTest(context)async{
    var body={
      "memberId":UserData().getUserMemberId.toString(),
      "labId": 1.toString()
    };
    var data=await RawData().api('Lab/searchPackageAndTest', body, context,token: true);
    if(data['responseCode']==1){
      controller.updateSearchList=data['responseValue'][0]['details'];

    }
  }
}