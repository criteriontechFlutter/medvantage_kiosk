import 'dart:developer';

import 'package:digi_doctor/AppManager/raw_api.dart';
import 'package:digi_doctor/AppManager/user_data.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';

import 'lab_details_controller.dart';

class LabDetailsModal{
  LabDetailsController controller=Get.put(LabDetailsController());

    getLabDetails(context)async{
    var body={
    "memberId": UserData().getUserMemberId.toString(),
    "pathalogyId":controller.getPathalogyId.toString()
    };
    var data=await RawData().api('Lab/getPackageAndTestLabWise', body, context,token: true);
    log(data.toString());
    controller.updatePackageAndTestLabWise=data['responseValue'];

     if(data['responseCode']==1){

          controller.updatePackageAndTestLabWise=data['responseValue'];
        }
  }
}