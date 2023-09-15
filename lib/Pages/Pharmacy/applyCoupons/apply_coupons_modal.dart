import 'package:digi_doctor/AppManager/raw_api.dart';
import 'package:digi_doctor/AppManager/user_data.dart';
import 'package:get/get.dart';

import 'apply_coupons_controller.dart';

class ApplyCouponsModal{
  ApplyCouponsController controller=Get.put(ApplyCouponsController());

  Future getCoupons(context)async{
  var body={
      "memberId":UserData().getUserMemberId.toString()
    };
    var data=await RawData().api('Pharmacy/couponDetails', body, context,token: true);
    // print(data.toString());
    if(data['responseCode']==1){
      controller.updateApplyCoupon=data['responseValue'];
    }
  }
}