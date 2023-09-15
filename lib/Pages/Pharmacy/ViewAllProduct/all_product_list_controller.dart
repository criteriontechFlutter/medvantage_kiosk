import 'package:flutter/material.dart';
import 'package:get/get.dart';


class AllProductListController extends GetxController{
  TextEditingController searchController = TextEditingController();
  List allProductListData = [].obs;

  // RxString productInfoCode="".obs;
  // String get getProductInfoCode=>productInfoCode.value;
  // set updateProductInfoCode(String val) {
  //   productInfoCode.value = val;
 //  //   update();
 //  // }
 //  List<ProductDataModal> get getAllProductListData => List<ProductDataModal>.from(
 //
 //      ( searchController.text==''? allProductListData:
 //      allProductListData.where((element) => element['productName'].toString().toLowerCase().contains(searchController.text.toString().toLowerCase())).toList())
 //      .map((element)=>ProductDataModal.fromJson(element))
 //  );
 //  //allProductListData.sort((a, b) => a.someProperty.compareTo(b.someProperty));
 //  set updateAllProductListData(List val){
 //    allProductListData=val;
 //    update();
 //  }
 //
 //  RxBool getShowNoData= false.obs;
 //  RxString productInfoCode =''.obs;
 //  RxString? isLikedValue =''.obs;
 //  RxBool isLikedProduct = true.obs;
 //  set updateIsLikedProduct(bool val){
 //    isLikedProduct.value =val;
 //    update();
 //  }
 //
 //
 //
 //  RxInt sortValue = 0.obs;
 //  int get getSortedValue => sortValue.value;
 //  set updateSortValue(int val){
 //    sortValue.value = val;
 //    update();
 //  }
 //
 //  List getListAccordingToSort(){
 //    switch(getSortedValue){
 //      case 1:
 //        return allProductListData..sort((a, b) => a['offeredPrice'].compareTo(b['offeredPrice']));
 //      case 2:
 //        return allProductListData..sort((a, b) => b['offeredPrice'].compareTo(a['offeredPrice']));
 //      default:;
 //        return allProductListData;
 //    }
 //  }
 //
 // RxBool isWishList= false.obs;
}