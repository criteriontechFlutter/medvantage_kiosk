import 'package:get/get.dart';

class CartController extends GetxController{
  RxInt cartCount=0.obs;
  int get getCartCount=>cartCount.value;
  set updateCartCount(int val){
    cartCount.value=val;
    update();
  }
}