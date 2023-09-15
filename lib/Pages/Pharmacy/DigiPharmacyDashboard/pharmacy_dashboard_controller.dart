import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import 'DataModal/all_category_data_modal.dart';
import 'DataModal/pharmacy_dashboard_data_modal.dart';
import 'DataModal/popular_productList_data_modal.dart';


class PharmacyDashboardController extends GetxController {
  RxBool showNoData = false.obs;

  bool get getShowNoData => (showNoData.value);

  set updateShowNoData(bool val) {
    showNoData.value = val;
    update();
  }

  List offerList = [
    {
      'discount': '25%',
      'off': '  off',
      'msg': 'Only your first medicine order',
      'code': 'DIGI1234'
    }
  ].obs;

  Rx<TextEditingController> searchC = TextEditingController().obs;

  RxInt categoryId = 0.obs;

  int get getCategoryId => categoryId.value;

  set updateCategoryId(int val) {
    categoryId.value = val;
    update();
  }

  List categoryList = [].obs;

  List<AllCategoryDataModal> get getCategoryList =>
      List<AllCategoryDataModal>.from(((searchC.value.text == ""
              ? categoryList
              : categoryList.where((element) =>
                  (element['categoryName'].toString().toLowerCase())
                      .trim()
                      .contains(searchC.value.text.toLowerCase().trim())))
          .map((e) => AllCategoryDataModal.fromJson(e))));

  List popularProductsList = [].obs;

  List<PopularProductListDataModal> get getPopularProductsList =>
      List<PopularProductListDataModal>.from(popularProductsList
          .map((element) => PopularProductListDataModal.fromJson(element)));
  List bannerList = [].obs;

  List<BannerListDataModal> get getBannerList => List<BannerListDataModal>.from(
      bannerList.map((element) => BannerListDataModal.fromJson(element)));
  List searchProductList = [].obs;

  List<PopularProductListDataModal> get getSearchProductList =>
      List<PopularProductListDataModal>.from(searchProductList
          .map((element) => PopularProductListDataModal.fromJson(element)));

  set updateCategoryList(List val) {
    bannerList = val;
    categoryList = val[0]['categoryList'];
    popularProductsList = val[0]['popularProductsList'];
    searchProductList = val[0]['searchProductList'];
    update();
  }

  RxInt cartCount = 0.obs;

  int get getCartCount => cartCount.value;

  set updateCartCount(int val) {
    cartCount.value = val;
    update();
  }
}
