import 'package:digi_doctor/AppManager/alert_dialogue.dart';
import 'package:digi_doctor/AppManager/app_util.dart';
import 'package:digi_doctor/AppManager/progress_dialogue.dart';
import 'package:digi_doctor/AppManager/raw_api.dart';
import 'package:digi_doctor/AppManager/user_data.dart';
import 'package:digi_doctor/Pages/LabTests/LabHome/lab_home_view.dart';

import 'package:digi_doctor/Pages/LabTests/Test/test_controller.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';

class TestsModal{
  TestsController testController=Get.put(TestsController());
  getTestByLab(context)async{
   var body={
      "labId": "1".toString(),
    "memberId": UserData().getUserMemberId.toString(),
    };
    var data=await RawData().api('Lab/getTestByLab', body, context,token: true);
    if(data['responseCode']==1){

      testController.updateTestListData=data['responseValue'];

    }
  }
  addToCart(context)async{
    ProgressDialogue().show(context, loadingText: 'Adding to cart');
    var body={
        "memberId":UserData().getUserMemberId.toString(),
        "testId": testController.getTestId.toString(),
      // "uniqueNo": "string",
      //   "packageId": "string"
    };
    var data=await RawData().api('Lab/addToCart', body, context,token: true);
    ProgressDialogue().hide();
    if(data['responseCode']==1){
      alertToast(context, 'added to cart');
      App().navigate(context, const LabTest());
    }
  }







  // addToCart(context,String productInfoCode )async{
  //   ProgressDialogue().show(context, loadingText: 'Adding to cart');
  //   var body = {
  //     "memberId":UserData().getUserMemberId.toString(),
  //     // "productInfoCode":controller.productInfoCode.toString(),
  //     "productInfoCode":productInfoCode,
  //     "quantity": "1"
  //   };
  //   var data = await rawData.api('Pharmacy/addToCart', body, context);
  //   ProgressDialogue().hide();
  //   if(data['responseCode']==1){
  //     alertToast(context, 'added to cart');
  //     App().navigate(context, const CartList());
  //   }
  // }

}