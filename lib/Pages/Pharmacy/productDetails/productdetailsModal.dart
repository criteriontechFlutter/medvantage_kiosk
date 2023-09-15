
import 'package:digi_doctor/AppManager/progress_dialogue.dart';
import 'package:digi_doctor/AppManager/raw_api.dart';
import 'package:digi_doctor/Pages/Pharmacy/cart_controller.dart';
import 'package:digi_doctor/Pages/Pharmacy/productDetails/productdetailsController.dart';
import 'package:get/get.dart';


import '../../../AppManager/alert_dialogue.dart';
import '../../../AppManager/data_status_enum.dart';
import '../../../AppManager/user_data.dart';




class ProductDetailsModal{


  ProductDetailsController controller = Get.put(ProductDetailsController());
  CartController cartController=Get.put(CartController());

  // productDetails(context) async {
  //   ProgressDialogue().show(context, loadingText: "Loading");
  //   controller.updateDataStatus=DataStatus.fetchInProgress;
  //   var body = {
  //     "memberId":UserData().getUserMemberId.toString(),
  //     // "sizeId": 1.toString(),
  //     // "colorId": 1.toString(),
  //     // "flavorId": 1.toString(),
  //     // "materialId": 1.toString(),
  //     //"productId": 8.toString(),
  //     "productId": controller.getProductId.toString(),
  //   };
  //   var data = await RawData().api('Pharmacy/getProductDetails', body, context, token: true);
  //
  //   if(data['responseCode']==1){
  //     print('00000'+(data['responseValue'][0]['productDetails'] as List).toString());
  //     if((data['responseValue'][0]['productDetails'] as List).isEmpty){
  //       controller.updateDataStatus=DataStatus.isEmpty;
  //     }
  //     else{
  //       controller.updateSimilarProducts=data['responseValue'][0]['similarProduct'];
  //       controller.updateImages=data['responseValue'][0]['imagePath'];
  //       controller.updateSize=data['responseValue'][0]['sizeDetails'];
  //       controller.updateColor=data['responseValue'][0]['colorDetails'];
  //       controller.updateReview=data['responseValue'][0]['reviewDetails'];
  //       controller.updateFlavour=data['responseValue'][0]['flavourDetails'];
  //       controller.updateMaterial=data['responseValue'][0]['materialDetails'];
  //       controller.updateCartListProductDetails=data['responseValue'][0]['productDetails'][0];
  //       controller.updateDataStatus=DataStatus.found;
  //       ProgressDialogue().hide();
  //     }
  //   }
  //   else{
  //     alertToast(context, data['responseMessage']);
  //     controller.updateDataStatus=DataStatus.isEmpty;
  //   }
  // }



  //**********addToCart
  // addToCart(context)async{
  //   ProgressDialogue().show(context, loadingText: 'Adding to cart');
  //   var body = {
  //     "memberId":UserData().getUserMemberId.toString(),
  //     "productInfoCode": controller.getProductInfoCode.toString(),
  //     //"productInfoCode": 28102021135330.toString(),
  //     //controller.productInfoCode.toString(),
  //     "quantity": "1"
  //   };
  //   var data = await RawData().api('Pharmacy/addToCart', body, context);
  //   ProgressDialogue().hide();
  //   if(data['responseCode']==1){
  //     alertToast(context, 'added to cart');
  //     App().navigate(context, const CartList());
  //   }
  // }

  assignWishlist(context, String productInfoCode, int status) async {
    ProgressDialogue().show(context, loadingText: "Loading");
   var body ={
       "memberId": UserData().getUserMemberId.toString(),
       "uniqueNo":  UserData().getUserUniqueNo.toString(),
       "productInfoCode":productInfoCode.toString() ,
       //"isWhislist": 0.toString(),
       "isWhislist": status.toString(),
   };
   var data = await RawData().api('Pharmacy/assignProductAsWhislist', body, context, token: true);
    ProgressDialogue().hide();
   if(data["responseMessage"]=='Success'){
     await selectProductDetails(context,'','','','');

   }
  }


  selectProductDetails(context, String sizeId,String flavourId, String materialId,String colorId) async {

    controller.updateDataStatus=DataStatus.fetchInProgress;
    var body = {
      "memberId": UserData().getUserMemberId.toString(),
      "sizeId": sizeId,
      "colorId": colorId,
      "flavorId": flavourId,
      "materialId": materialId,
      "productId": controller.getProductId.toString(),
    };
    var data = await RawData().api('Pharmacy/getProductDetails', body, context, token: true);
    print('--------------'+data.toString());

      if(data['responseValue'].isNotEmpty){
        if ((data['responseValue'][0]['productDetails'] as List).isEmpty) {
          controller.updateDataStatus = DataStatus.isEmpty;
        } else {
          controller.updateSimilarProducts =
              data['responseValue'][0]['similarProduct'];
          controller.updateImages = data['responseValue'][0]['imagePath'];
          controller.updateSize = data['responseValue'][0]['sizeDetails'];
          controller.updateColor = data['responseValue'][0]['colorDetails'];
          controller.updateReview = data['responseValue'][0]['reviewDetails'];
          controller.updateFlavour = data['responseValue'][0]['flavourDetails'];
          controller.updateMaterial =
              data['responseValue'][0]['materialDetails'];
          controller.updateCartListProductDetails =
              data['responseValue'][0]['productDetails'][0];
          controller.updateDataStatus = DataStatus.found;
        }

    }
    else{
      alertToast(context, data['responseMessage']);
      controller.updateDataStatus=DataStatus.isEmpty;
    }
  }
}


