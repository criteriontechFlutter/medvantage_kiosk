
import 'package:digi_doctor/AppManager/raw_api.dart';
import 'package:digi_doctor/AppManager/user_data.dart';
import 'package:get/get.dart';

import '../../../AppManager/alert_dialogue.dart';
import 'order_details_controller.dart';

class OrderDetailsModal{
  OrderDetailsController controller=Get.put(OrderDetailsController());

   getOrderDetails(context,   getOrderDetailsId)async{   print("ogjoigo"+'data'.toString());
  print( "*****"+controller.getOrderDetailsId.toString());
    var body={
      "memberId":UserData().getUserMemberId.toString(),
      "orderDetailsId": controller.getOrderDetailsId.toString(),
     // "orderDetailsId": getOrderDetailsId.toString(),
     // 7.toString(),
      "orderId": "",
      //controller.getOrderDetailsId.toString(),
     // 7.toString()
    };
    var data=await RawData().api("Pharmacy/getOrderDetails", body, context,token: true);
    print("ogjoigo"+data.toString());
    print(controller.getOrderDetailsId.toString());
    if(data['responseCode']==1){
      controller.updateOrderDetail=data['responseValue'];
      //controller.updateOrderDetailsId=data['responseValue'];

    }
    else {
      alertToast(context, 'An Error Occurred');
      Get.back();
    }

  }

  productRating(context)async{
     var body={
       "memberId":UserData().getUserMemberId.toString(),
       "productInfoCode":controller.getProductDetails[0].productInfoCode.toString(),
       "review": controller.ratingController.value.text.toString(),
       "starrating": controller.ratingData.toString(),
     };

     var data=await RawData().api('Pharmacy/productRating', body, context,token: true);
     print("ogjoigo"+data.toString());
     print(controller.getProductInfoCode.toString());
     if(data['responseCode']==1){
       alertToast(context, "Review Submitted");
       Get.back();
     }
  }

  // cancelOrder(context)async{
  //   var body={
  //     "orderDetailsId":16.toString()
  //   };
  //   var data=await RawData().api("Pharmacy/cancelOrder", body, context,token: true);
  //   print("order cancelled"+data.toString());
  //   if(data['responseCode']==1){
  //     alertToast(context,"Order Cancelled");
  //     App().navigate(context,OrderedList());
  //   }
  // }

}