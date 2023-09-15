import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import 'DataModal/apply_coupons_data_modal.dart';

class ApplyCouponsController extends GetxController{
 RxBool showNoData=false.obs;
 bool get getShowNoData=>(showNoData.value);
 set updateShowNoData(bool val){
   showNoData.value=val;
   update();
 }

 Rx<TextEditingController> applyCouponController = TextEditingController().obs;

   List coupons=[
     {
       'img':"Paytm",
       'code':"FREE50",
       'subtitle':'Get Unlimited free delivery using Paytm',
       'useCode':'Use code FREE50 & get free delivery on all orders Rs 200'
     },
     {
       'title':"Gpay",
       'code':"FREE150",
       'subtitle':'Get Unlimited free delivery using Gpay',
       'useCode':'Use code FREE150 & get free delivery on all orders Rs 500'
     },
     {
       'title':"SBI",
       'code':"FREE250",
       'subtitle':'Get Unlimited free delivery using SBI',
       'useCode':'Use code FREE50 & get free delivery on all orders Rs 800'
     },
     {
       'title':"AXIS BANK",
       'code':"FREE100",
       'subtitle':'Get Unlimited free delivery using AXIS BANK',
       'useCode':'Use code FREE50 & get free delivery on all orders Rs 200'
     }
   ];

 // Rx<TextEditingController> searchC = TextEditingController().obs;
 //   List categoryList=[].obs;
 //
 //   List<AllCategoryDataModal>get getCategoryList=>List<AllCategoryDataModal>.from(
 //   (
 //   (
 //   searchC.value.text==""?categoryList:categoryList.where((element) => (element['categoryName'].toString()
 //       .toLowerCase()).trim().contains(searchC.value.text.toLowerCase().trim()))).map((e) =>AllCategoryDataModal.fromJson(e) ))
 //   );

 Rx<TextEditingController>searchC=TextEditingController().obs;


 List applyCoupon=[].obs;

 // List<ApplyCouponsDataModal>get getApplyCoupon=>List<ApplyCouponsDataModal>.from(
 //     (
 //         (
 //         searchC.value.text==""?applyCoupon:applyCoupon.where((element) => (element['couponCode'].toString().
 //         toLowerCase()).trim().contains(searchC.value.text.toLowerCase().trim()))).map((e) => ApplyCouponsDataModal.fromJson(e)))
 //
 // );

 RxString couponCode=''.obs;
 String get getCouponCode=>couponCode.value;
 set updateCouponCode(String val){
   couponCode.value=val;
   update();
 }

 List get getApplyCoupon=>List<ApplyCouponsDataModal>.from(
   applyCoupon.map((e) => ApplyCouponsDataModal.fromJson(e))

 );
 set updateApplyCoupon(List val){
   applyCoupon=val;
   update();
 }
}