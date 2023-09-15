import 'package:digi_doctor/AppManager/alert_dialogue.dart';
import 'package:digi_doctor/AppManager/app_util.dart';
import 'package:digi_doctor/AppManager/progress_dialogue.dart';
import 'package:digi_doctor/AppManager/raw_api.dart';
import 'package:digi_doctor/AppManager/user_data.dart';
import 'package:digi_doctor/Pages/Pharmacy/DigiPharmacyDashboard/pharmacy_dashboard_controller.dart';
import 'package:digi_doctor/Pages/Pharmacy/cartList/CartList.dart';
import 'package:digi_doctor/Pages/Pharmacy/cart_controller.dart';
import 'package:get/get.dart';

import 'all_product_list_controller.dart';

class AllProductListModal {
  AllProductListController controller = Get.put(AllProductListController());
  CartController cartController = Get.put(CartController());
  PharmacyDashboardController pharmacyDashboardController =
      Get.put(PharmacyDashboardController());
  RawData rawData = RawData();
  App app = App();

  // getAllProductList(context, String? categoryId) async {
  //   controller.updateAllProductListData = [];
  //   controller.getShowNoData.value = false;
  //   var body;
  //
  //   if (categoryId == null) {
  //     body = {
  //       "memberId": UserData().getUserMemberId.toString(),
  //     };
  //   } else {
  //     body = {
  //       "memberId": UserData().getUserMemberId.toString(),
  //       //"categoryId":pharmacyDashboardController.getCategoryId.toString()
  //       "categoryId": categoryId.toString()
  //     };
  //   }
  //
  //   var data = await rawData.api('Pharmacy/getAllProducts', body, context);
  //   controller.getShowNoData.value = true;
  //   if (data['responseCode'] == 1) {
  //     controller.updateAllProductListData = data['responseValue'];
  //   }
  //   else {
  //     alertToast(context, data['responseMessage']);
  //   }
  // }

  // addToCart2(context)async{
  //   ProgressDialogue().show(context, loadingText: 'Adding to cart');
  //   var body = {
  //     "memberId":UserData().getUserMemberId.toString(),
  //    "productInfoCode": controller.productInfoCode.toString(),
  //     "quantity": "1"
  //   };
  //   var data = await rawData.api('Pharmacy/addToCart', body, context);
  //   ProgressDialogue().hide();
  //   if(data['responseCode']==1){
  //    alertToast(context, 'added to cart');
  //    App().navigate(context, const CartList());
  //   }
  // }

  addToCart(context, String productInfoCode) async {
    ProgressDialogue().show(context, loadingText: 'Adding to cart');
    var body = {
      "memberId": UserData().getUserMemberId.toString(),
      // "productInfoCode":controller.productInfoCode.toString(),
      "productInfoCode": productInfoCode,
      "quantity": "1"
    };
    var data = await rawData.api('Pharmacy/addToCart', body, context);
    ProgressDialogue().hide();
    if (data['responseCode'] == 1) {
      alertToast(context, 'added to cart');
      App().navigate(context, const CartList());
    }
  }

// addToWishList(context,String productInfoCode)async{
//   ProgressDialogue().show(context, loadingText: 'Adding to Wishlist');
//   var body = {
//     "memberId":UserData().getUserMemberId.toString(),
//     "productInfoCode":productInfoCode,
//     "isWhislist": 0.toString()
//     //controller.isWishList.value?"1":"0"
//   };
//   print('**********'+body.toString());
//   var data = await rawData.api('Pharmacy/assignProductAsWhislist', body, context);
//   ProgressDialogue().hide();
//   if(data['responseCode']==1){
//     alertToast(context,"Added to Wishlist");
//    // app.replaceNavigate(context, WishListProduct());
//     //addToCart(context);
//   }
// }

// Future<bool> onLikeButtonTapped(bool isLiked,String productInfoCode, {context}) async{
//   /// send your request here
//   // final bool success= await sendRequest();
//   print("######"+isLiked.toString());
//   if(isLiked){
//     print('ye true');
//     controller.isWishList.value = false;
//     controller.productInfoCode.value = productInfoCode;
//     addToWishList(context);
//     print('dfdhfhfh');
//   }
//   else{
//     print('ye false');
//     controller.isWishList.value = true;
//     controller.productInfoCode.value = productInfoCode;
//     addToWishList(context);
//   }
//   //print(isLiked.toString());
//   /// if failed, you can do nothing
//   // return success? !isLiked:isLiked;
//
//   return isLiked;
// }

// addToCartProductDetails(context,String productInfoCode)async{
//   ProgressDialogue().show(context, loadingText: 'Adding to cart');
//   var body = {
//     "memberId":UserData().getUserMemberId.toString(),
//     "productInfoCode": productInfoCode,
//     //"productInfoCode": controller.productInfoCode.toString(),
//     //"productInfoCode": controller.getAllProductListData[0].productInfoCode.toString(),
//     //"productInfoCode": 28102021135330.toString(),
//     //controller.productInfoCode.toString(),
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
