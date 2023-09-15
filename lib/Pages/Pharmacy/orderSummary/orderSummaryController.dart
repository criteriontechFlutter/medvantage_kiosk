



import 'package:get/get.dart';
import 'orderSummaryDataModal.dart';

class OrderSummaryController extends GetxController{

  RxInt addressId=0.obs;
  int get getAddressId=>addressId.value;
  set updateAddressId(int val) {
    addressId.value = val;
    update();
  }

  List address = [].obs;
  List<OrderSummaryDataModal> get getAddress => List<OrderSummaryDataModal>.from(
      address.map((element) => OrderSummaryDataModal.fromJson(element)));
  set updateAddress (List val){
    address = val;
    update();
  }



}