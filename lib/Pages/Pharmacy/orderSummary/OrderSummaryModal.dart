import 'package:get/get.dart';
import '../../../AppManager/alert_dialogue.dart';
import '../../../AppManager/raw_api.dart';

import 'orderSummaryController.dart';

class OrderSummaryModal{
  OrderSummaryController controller = Get.put(OrderSummaryController());
  getAddress(context) async {
    var body ={
      "memberId": 221261.toString(),
    };
    var data = await RawData().api('Pharmacy/getAddress', body, context, token: true);
     if(data["responseMessage"]=='Success'){
      controller.updateAddress=data['responseValue'];
    }
     else{
       alertToast(context, data['responseMessage']);
     }
  }

  deleteAddress(context, String addressId) async {
    var body ={
      "addressId": addressId.toString()
    };
    var data = await RawData().api('Pharmacy/deleteAddress', body, context, token: true);
  }
}