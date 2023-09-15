import 'dart:developer';

import 'package:digi_doctor/AppManager/alert_dialogue.dart';
import 'package:digi_doctor/AppManager/raw_api.dart';
import 'package:digi_doctor/AppManager/user_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import 'lab_cart_controller.dart';

class LabCartModal{
  LabCartController controller=Get.put(LabCartController());

  Future<void> onPressedDelete(context) async {
    onPressedConfirm() async {
      Navigator.pop(context);
      await deleteCartItem(context);
    }

    AlertDialogue().show(context,
        msg: 'Are you sure you want to Delete?',
        firstButtonName: 'Confirm',
        showOkButton: false, firstButtonPressEvent: () {
          onPressedConfirm();
        }, showCancelButton: true);
  }






  Future<void> labCart(context)async{
    var body={
      "memberId": UserData().getUserMemberId.toString(),
    };
    var data=await RawData().api("Lab/cartDetails", body, context,token: true);
    if(data['responseCode']==1){
      controller.updateLabCartList=data['responseValue'];

    }
    //print(data.toString());
    log(data.toString());
  }


  //
  Future details(context)async{
    var body=
    {"packageId": "1".toString(),
      //":UserData().getUserMemberId.toString()}
    }
    ;
    var data=await RawData().api("Lab/getPackageDetails", body, context,token: true);
    // if(data['responseCode']==1){
    //
    //   controller.updateDashboardData=data['responseValue'];
    // }
    print("sahu"+data.toString());
    print("log data");
    log('heeeeeeeeeeeeeeeeelllloooooooooooooooo'+data.toString());
    //print("------------------ok--------------"+controller.getCartCount.toString());
    // log(data);
  }

  deleteCartItem(context) async {

    var body = {
      "cartId": controller.getCartId.toString()
    };
    var data = await RawData().api('Lab/deleteCart', body, context, token: true);

    if (data['responseMessage'] == 'Success') {
      labCart(context);
      alertToast(context, 'Removed');
    } else {
      alertToast(context, data['responseMessage']);
    }
  }




}