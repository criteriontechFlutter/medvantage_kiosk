
import 'package:get/get.dart';

import 'LabCartDataModal/lab_cart_data_modal.dart';

class LabCartController extends GetxController{

  RxInt cartId=0.obs;
  int get getCartId=>cartId.value;
  set updateCartId(int val){
    cartId.value=val;
    update();
  }



  List labCartList=[].obs;

  List<LabCartDataModal>get getLabCartList=>List<LabCartDataModal>.from(
      labCartList.map((e) => LabCartDataModal.fromJson(e))
  );

  List  pkgDetail=[].obs;
  List<PackageTestList> get getPkgDetail=>List<PackageTestList>.from(
      pkgDetail.map((e) => PackageTestList.fromJson(e))
  );

  set updateLabCartList(List val){
    labCartList=val;
    pkgDetail=val;
   //  pkgDetail=val[1]['packageTestList'];
    update();
  }
}
