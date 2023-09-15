
import 'package:digi_doctor/AppManager/alert_dialogue.dart';
import 'package:digi_doctor/AppManager/app_util.dart';
import 'package:digi_doctor/AppManager/raw_api.dart';
import 'package:digi_doctor/AppManager/user_data.dart';
import 'package:digi_doctor/Pages/Pharmacy/orderDetails/order_details_controller.dart';
import 'package:get/get.dart';

import 'orderedlist_controller.dart';
import 'orderedlist_view.dart';

class OrderedListModal{
  OrderedListController controller=Get.put(OrderedListController());
  OrderDetailsController orderDetailsController=Get.put(OrderDetailsController());


  // onPressedMyOrdered(context, index) async {
  //   await App().navigate(
  //       context,
  //       OrderDetail(
  //         orderDetailsId: controller.getOrderedList[index].orderDetailsId,
  //       ));
  // }





   getOrders(context)async{
     controller.updateShowNoData=false;
    var body={
      "memberId": UserData().getUserMemberId.toString(),
    };
    var data=await RawData().api("Pharmacy/getOrders", body, context,token:true);
     controller.updateShowNoData=true;
    if(data['responseCode']==1){
      controller.updateOrderedList=data['responseValue'];

    }
    //print(data.toString());
     print( controller.getOrderedList.toString());
  }

  cancelOrder(context)async{
    var body={
      "orderDetailsId":controller.orderDetailsId.toString(),
      //16.toString()
    };
    var data=await RawData().api("Pharmacy/cancelOrder", body, context,token: true);
    print("order cancelled"+data.toString());
    if(data['responseCode']==1){
      alertToast(context,"Order Cancelled");
      App().navigate(context,OrderedList());
    }
  }
}