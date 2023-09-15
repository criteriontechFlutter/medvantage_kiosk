import 'package:digi_doctor/AppManager/data_status_enum.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'cartListDataModal.dart';

class CartListController extends GetxController{


 bool add = false;
 set updateProgressAdd(bool val){
   add = val;
   update();
 }

String productInfoCode='';
 set updateProductInfoCode(String val){
   productInfoCode = val;
   update();
 }

 bool addLoading = false;
 set updateProgressAddLoading(bool val){
   addLoading = val;
   update();
 }

 bool subtract = false;
 set updateProgressSub(bool val){
   subtract = val;
   update();
 }



 bool remove = false;
 bool get getRemoveStatus=>remove;
 set updateProgressRemove(bool val){
   remove = val;
   update();
 }

 bool freezeButton = false;
 set updateFreezeButton(bool val){
   freezeButton = val;
   update();
 }




 DataStatus dataStatus=DataStatus.initialStage;
  DataStatus get getDataStatus=>dataStatus;
  set updateDataStatus(DataStatus val){
    dataStatus=val;
  }

 LoaderStatusAdd loaderStatusAdd= LoaderStatusAdd.loadingStopped;
 LoaderStatusAdd get getLoaderStatusAdd=>loaderStatusAdd;
 set updateLoaderStatusAdd(LoaderStatusAdd val){
   loaderStatusAdd=val;
   update();
 }

 LoaderStatusSub loaderStatusSub= LoaderStatusSub.loadingStopped;
 LoaderStatusSub get getLoaderStatusSub=>loaderStatusSub;
 set updateLoaderStatusSub(LoaderStatusSub val){
   loaderStatusSub=val;
   update();
 }







 List productDetails = [].obs;
  List<ProductDetailsDataModal2> get getProductDetails => List<ProductDetailsDataModal2>.from(
      productDetails.map((element) => ProductDetailsDataModal2.fromJson(element)));
  set updateProductDetails (List val){
    productDetails = val;
    update();
  }


 // List loaderStatus = [].obs;
 // List<ProductDetailsDataModal> get getLoaderStatus => List<ProductDetailsDataModal>.from(
 //     loaderStatus.map((element) => ProductDetailsDataModal.fromJson(element)));
 // set updateLoaderStatus (List val){
 //   loaderStatus = val;
 //   // b=false;
 //   update();
 // }

 Rx<TextEditingController> applyCouponController = TextEditingController().obs;


 Map priceDetails = {}.obs;
  PriceDetailsDataModal get getPriceDetails => PriceDetailsDataModal.fromJson(priceDetails);  //CURRENT SUBJECTS
  set updatePriceDetails (Map val){
    priceDetails = val;
    update();
  }




}