import 'package:digi_doctor/AppManager/alert_dialogue.dart';
import 'package:digi_doctor/AppManager/data_status_enum.dart';
import 'package:digi_doctor/AppManager/raw_api.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import '../../../AppManager/user_data.dart';
import '../ApplyCoupons/apply_coupons_controller.dart';
import 'cartList_controller.dart';

class CartListModal {
  CartListController controller = Get.put(CartListController());
  ApplyCouponsController applyCouponsController=Get.put(ApplyCouponsController());
  bool? a = false;



  getCartListDetails(context, {bool showLoader = true}) async {
    if (showLoader) {
      controller.updateDataStatus = DataStatus.fetchInProgress;
    }
    var body = {
      "memberId": 221261.toString(),
    };
    var data = await RawData().api('Pharmacy/cartDetails', body, context, token: true);
    if (data['responseCode'] == 1) {
      if ((data['responseValue'][0]['productDetails'] as List).isEmpty) {
        controller.updateDataStatus = DataStatus.isEmpty;
      } else {
        controller.updateProductDetails = data['responseValue'][0]['productDetails'];
        controller.updatePriceDetails = data['responseValue'][0]['priceDetails'][0];
        controller.updateDataStatus = DataStatus.found;
      }
    } else {
      alertToast(context, data['responseMessage']);
      controller.updateDataStatus = DataStatus.isEmpty;
    }
  }




//  REMOVE      REMOVE      REMOVE      REMOVE      REMOVE     REMOVE   REMOVE

  removeCartItem(index, context) async {
    controller.updateProgressRemove = true;
    controller.updateFreezeButton = true;
    var body = {
      "cartId": controller.getProductDetails[index].cartId.toString()
    };
    var data = await RawData().api('Pharmacy/deleteCartItem', body, context, token: true);
    controller.updateProgressRemove = false;
    controller.updateFreezeButton = false;
    if (data['responseMessage'] == 'Success') {
      await getCartListDetails(context, showLoader: false);
      alertToast(context, 'Removed');
    } else {
      alertToast(context, data['responseMessage']);
    }
  }





//     ADD       ADD      ADD      ADD      ADD      ADD      ADD      ADD

  addToCartItemPlus(index, context,int productInfoCode) async {
    // controller.updateProgressAdd = true;
    controller.updateFreezeButton = true;
    controller.updateLoaderStatusAdd=LoaderStatusAdd.loading;
    var body = {
      "memberId": 221261.toString(),
      "uniqueNo": UserData().getUserUniqueNo.toString(),
      "productInfoCode": controller.getProductDetails[index].productInfoCode.toString(),
      "quantity": ((controller.getProductDetails[index].quantity)! + 1).toString()
    };
    var data = await RawData().api('Pharmacy/addToCart', body, context, token: true);
    // controller.updateProgressAdd = false;
    controller.updateFreezeButton = false;

    if (data['responseMessage'] == 'Success') {
      controller.updateLoaderStatusAdd=LoaderStatusAdd.loadingStopped;
      getCartListDetails(context, showLoader: false);
    } else {
      alertToast(context, data['responseMessage']);
    }
  }



//     SUBTRACT        SUBTRACT        SUBTRACT        SUBTRACT        SUBTRACT

  addToCartItemMinus(index, context,) async {
    // controller.updateProgressSub = true;
    controller.updateFreezeButton = true;
    controller.updateLoaderStatusSub=LoaderStatusSub.loading;
    var body = {
      "memberId": 221261.toString(),
      "uniqueNo": UserData().getUserUniqueNo.toString(),
      "productInfoCode": controller.getProductDetails[index].productInfoCode.toString(),
      "quantity": ((controller.getProductDetails[index].quantity)! - 1).toString()
    };
    var data = await RawData().api('Pharmacy/addToCart', body, context, token: true);
    // controller.updateProgressSub = false;
    controller.updateFreezeButton = false;
    controller.updateLoaderStatusSub=LoaderStatusSub.loadingStopped;
    if (data['responseMessage'] == 'Success') {
      getCartListDetails(context,showLoader: false);
    } else {
      alertToast(context, data['responseMessage']);
    }
  }



//  MAX VAL CHECK    MAX VAL CHECK    MAX VAL CHECK    MAX VAL CHECK   MAX VAL

  checkCondition(int index, BuildContext context) {
    if ((controller.getProductDetails[index].quantity ?? 0) <= 1) {
      removeCartItem(index, context);
    } else {
      addToCartItemMinus(index, context);
    }
  }



//      MIN VAL CHECK      MIN VAL CHECK         MIN VAL CHECK    MIN VAL CHECK

  checkConditionForMaxVal(int index, BuildContext context) {
    if ((controller.getProductDetails[index].quantity ?? 0) >= 5) {
      alertToast(context, 'Maximum value reached');
    } else {
      addToCartItemPlus(index, context,17022021112305);
    }
  }

  //apply coupons
validateCoupon(context)async{
    var body={
      "memberId": UserData().getUserMemberId.toString(),
      "couponCode":controller.applyCouponController.value.text,
          //applyCouponsController.getApplyCoupon[0]['couponCode'].toString(),
      "cartAmount": controller.getPriceDetails.totalAmount.toString(),
      "type":''
    };
    var data=await RawData().api('Pharmacy/validateCoupon', body, context,token: true);
    if(data['responseCode']==1){
      alertToast(context,data['responseMessage']);
    }
    else{
      alertToast(context,data['responseMessage']);
    }
}

}
