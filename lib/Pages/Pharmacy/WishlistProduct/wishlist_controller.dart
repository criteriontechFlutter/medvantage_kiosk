import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import 'DataModal/wishlist_data_modal.dart';

class WishlistController extends GetxController{
  TextEditingController searchController = TextEditingController();

  RxBool showNoData=false.obs;
  bool get getShowNoData=>(showNoData.value);
  set updateShowNoData(bool val){
    showNoData.value=val;
    update();
  }

  RxString productInfoCode="".obs;
  String get getProductInfoCode=>productInfoCode.value;
  set updateProductInfoCode(String val) {
    productInfoCode.value = val;
    update();
  }

  
  List wishList=[].obs;

  List<WishListDataModal> get getWishList=>List<WishListDataModal>.from(
      ( searchController.text==''? wishList:
      wishList.where((element) =>
          element['productName'].
          toString().toLowerCase().contains(searchController.text.toString().toLowerCase())).toList()).map((element) =>
      WishListDataModal.fromJson(element)));


  set updateWishList(List val){
    wishList=val;
    update();
  }

}