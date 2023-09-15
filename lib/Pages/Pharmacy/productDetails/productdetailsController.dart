
import 'package:digi_doctor/Pages/Pharmacy/productDetails/productDetailsDataModal.dart';


import 'package:get/get.dart';

import '../../../AppManager/data_status_enum.dart';


class ProductDetailsController extends GetxController {
  DataStatus dataStatus = DataStatus.initialStage;

  DataStatus get getDataStatus => dataStatus;

  set updateDataStatus(DataStatus val) {
    dataStatus = val;
    update();
  }

  Map cartListProductDetails = {}.obs;
  CartListProductDetailsDataModal get getCartListProductDetails =>
      CartListProductDetailsDataModal.fromJson(cartListProductDetails);
  set updateCartListProductDetails(Map val) {
    cartListProductDetails = val;
    update();
  }

  // List images = [].obs;
  // List get getImages =>images;    //  IMAGES
  // set updateImages (List val){
  //   images = val;
  //   update();
  // }

 RxInt productId=0.obs;
  int get getProductId=>productId.value;
  set updateProductId(int val) {
    productId.value = val;
    update();
  }



  List images = [].obs;
  // List<ImageDataModal> get getImages => List<ImageDataModal>.from(
  //     images.map((element) => ImageDataModal.fromJson(element)));
  List get getImageList=>images;
  set updateImages (List val){
    images = val;
    update();
  }
  List similarProducts = [].obs;
  List<SimilarProduct> get getSimilarProducts => List<SimilarProduct>.from(
      similarProducts.map((element) => SimilarProduct.fromJson(element)));
  set updateSimilarProducts (List val){
    similarProducts = val;
    update();
  }


  List size = [].obs;
  List<SizeDetails> get getSize => List<SizeDetails>.from(
      size.map((element) => SizeDetails.fromJson(element)));
  set updateSize(List val){
    size = val;
    update();
  }

  // List flavourDetails = [].obs;
  // List<FlavourDetails> get getFlavourDetails => List<FlavourDetails>.from(
  //     flavourDetails.map((element) => FlavourDetails.fromJson(element)));
  // set updateFlavourDetails(List val){
  //   flavourDetails = val;
  //   update();
  // }

  List color = [].obs;
  List<ColorDetails> get getColor => List<ColorDetails>.from(
      color.map((element) => ColorDetails.fromJson(element)));
  set updateColor(List val){
    color = val;
    update();
  }

  List review = [].obs;
  List<ReviewDetailsDataModal> get getReview => List<ReviewDetailsDataModal>.from(
      review.map((element) => ReviewDetailsDataModal.fromJson(element)));
  set updateReview(List val){
    review = val;
    update();
  }

  List flavour = [].obs;
  List<FlavourDataModal> get getFlavour => List<FlavourDataModal>.from(
      flavour.map((element) => FlavourDataModal.fromJson(element)));
  set updateFlavour(List val){
    flavour = val;
    update();
  }

  List material = [].obs;
  List<MaterialDataModal> get getMaterial => List<MaterialDataModal>.from(
      material.map((element) => MaterialDataModal.fromJson(element)));
  set updateMaterial(List val){
    material = val;
    update();
  }
}
