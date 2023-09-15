import 'dart:developer';

import 'package:digi_doctor/AppManager/raw_api.dart';
import 'package:digi_doctor/AppManager/user_data.dart';
import 'package:digi_doctor/Pages/LabTests/AllPackages/all_packages_controller.dart';
import 'package:get/get.dart';


class AllPackagesModal{
  AllPackagesController controller=Get.put(AllPackagesController());
  Future allPackages(context)async{
    var body=
    {
      "memberId":UserData().getUserMemberId.toString(),
   // "packageId":controller.getPackageId.toString()

    }
    ;
    var data=await RawData().api("Lab/getAllPackages", body, context,token: true);
    log(data.toString());
    if(data['responseCode']==1){

      controller.updateAllPackages=data['responseValue'];
    }
print("length"+controller.getAllPackages.length.toString());

    // log(data);
  }
}
