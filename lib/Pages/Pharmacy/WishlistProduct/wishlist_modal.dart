
import 'package:digi_doctor/AppManager/raw_api.dart';
import 'package:digi_doctor/AppManager/user_data.dart';

import 'package:digi_doctor/Pages/Pharmacy/WishlistProduct/wishlist_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


import '../../../AppManager/alert_dialogue.dart';
import '../../../AppManager/progress_dialogue.dart';
import '../cart_controller.dart';

class WishlistModal{
  WishlistController controller=Get.put(WishlistController());
  CartController cartController=Get.put(CartController());



  Future<void> onPressedRemove(context)async {
    AlertDialogue().show(context,
        msg: 'Are you sure you want to Remove?',
        firstButtonName: 'Confirm',
        showOkButton: false, firstButtonPressEvent: () async {
          Navigator.pop(context);
          await assignWishList(context);
        }, showCancelButton: true);
  }



  getWishList(context)async{
    var body={
      "memberId": UserData().getUserMemberId.toString(),
    };
    var data=await RawData().api("Pharmacy/getWhislistProducts", body, context,token: true);

   if(data['responseCode']==1){
     controller.updateWishList=data['responseValue'];
   }

  }

  assignWishList(context) async{
    ProgressDialogue().show(context, loadingText: 'Removing Data...');
    var body={
      "memberId":UserData().getUserMemberId.toString(),
      "productInfoCode":controller.getProductInfoCode.toString(),
      "isWhislist":0.toString()
    };
    var data=await RawData().api('Pharmacy/assignProductAsWhislist', body, context,token: true);
    ProgressDialogue().hide();
    if(data['responseCode']==1){
     await getWishList(context);
    }
  }



}
//01042021131145 product info code