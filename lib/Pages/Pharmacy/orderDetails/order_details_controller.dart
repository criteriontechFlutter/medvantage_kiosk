
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'DataModal/order_details_data_modal.dart';
import 'DataModal/order_status_data_modal.dart';
import 'DataModal/price_detail_data_modal.dart';
import 'DataModal/product_details_data_modal.dart';
import 'DataModal/related_products_data_modal.dart';

class OrderDetailsController extends GetxController{


  RxBool showNoData=false.obs;
  bool get getShowNoData=>(showNoData.value);
  set updateShowNoData(bool val){
    showNoData.value=val;
    update();
  }
  Rx<TextEditingController> ratingController=TextEditingController().obs;
  RxInt ratingData=0.obs;

  clearData(){
    ratingController.value.clear();
    ratingData.value=0;
  }




  List orderStatuss=[
    {
      'ordered':"Ordered and Approved",
      'packed':'Fri,20th Nov 2020',
      'shipped':'Sun,21st Nov 2020',
      'orderDate':"Thu,19th Nov 20020",
      'oStatus1':'Delivered',
      // 'oStatus2':'Cancelled',
      'cancelledDate':'Fri,20th Nov 2020'
    },

  ].obs;

  RxInt orderDetailsId=0.obs;
  int get getOrderDetailsId=>orderDetailsId.value;
  set updateOrderDetailsId(int val) {
    orderDetailsId.value = val;
    update();
  }
  RxString productInfoCode="".obs;
  String get getProductInfoCode=>productInfoCode.value;
  set updateProductInfoCode(String val){
    productInfoCode.value=val;
    update();
  }


  List orderDetail=[].obs;
  List productDetail=[].obs;
  List orderStatus=[].obs;
  List priceDetail=[].obs;
  List relatedProduct=[].obs;
  List productDetails=[].obs;

  List<OrderDetailsDataModal> get getOrderDetail=>List<OrderDetailsDataModal>.from(
      orderDetail.map((element) => OrderDetailsDataModal.fromJson(element))
  );

List<OrderStatusDataModal> get getOrderStatus=>List<OrderStatusDataModal>.from(
  orderStatus.map((e) => OrderStatusDataModal.fromJson(e))
);


  List<PriceDetailDataModal> get getPriceDetail=>List<PriceDetailDataModal>.from(
      priceDetail.map((e) => PriceDetailDataModal.fromJson(e))
  );

  ProductDetailsDataModal get getProductDetail=>ProductDetailsDataModal.fromJson(
      productDetail.isEmpty?{}:
      productDetail[0]
  );

   List<ProductDetailsDataModal> get getProductDetails=>List<ProductDetailsDataModal>.
   from(productDetails.map((e) => ProductDetailsDataModal.fromJson(e)));

List<RelatedProductDataModal> get getRelatedProduct=>List<RelatedProductDataModal>.from(
    relatedProduct.map((e) =>RelatedProductDataModal.fromJson(e)));

set updateOrderDetail(List val){
    orderDetail=val;
    productDetail=val[0]['productDetails'];
    productDetails=val[0]['productDetails'];
    orderStatus=val[0]['orderStatus'];
    priceDetail=val[0]['priceDetails'];
    relatedProduct=val[0]['relatedProducts'];
    update();
  }
}
