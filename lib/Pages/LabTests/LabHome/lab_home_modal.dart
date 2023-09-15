

import 'package:digi_doctor/AppManager/raw_api.dart';
import 'package:digi_doctor/AppManager/user_data.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import 'lab_home_controller.dart';

class LabTestModal{
  LabTestController controller=Get.put(LabTestController());

  Future labDashboard(context)async{
    var body={
        "memberId":UserData().getUserMemberId.toString()
    };
    var data=await RawData().api("Lab/labDasboard", body, context,token: true);
    if(data['responseCode']==1){

      controller.updateDashboardData=data['responseValue'];
    }


    //print("------------------ok--------------"+controller.getCartCount.toString());
    // log(data);
  }



  Future labCartCount(context)async{
    var body={
      "memberId":UserData().getUserMemberId.toString(),
    };
    var data=await RawData().api("Lab/cartCount", body, context,token: true);
    if(data["responseCode"]==1){
      controller.updateLabCartCount=data['responseValue'];

     // cartController.updateCartCount=data['responseValue'][0]['cartCount'];

    }
    if (kDebugMode) {
      print("cartValue$data");
    }
  }



}