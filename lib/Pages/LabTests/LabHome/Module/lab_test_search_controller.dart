 import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import 'DataModal/lab_test_data_modal.dart';

class LabTestSearchController extends GetxController{

  TextEditingController searchController = TextEditingController();
  RxBool showNoTopData=false.obs;
  bool get getShowNoTopData=>(showNoTopData.value);
  set updateShowNoTopData(bool val){
    showNoTopData.value=val;
    update();
  }

List searchList=[].obs;
// List<ProductDataModal> get getAllProductListData => List<ProductDataModal>.from(
//
//       ( searchController.text==''? allProductListData:
//       allProductListData.where((element) => element['productName'].toString().toLowerCase().contains(searchController.text.toString().toLowerCase())).toList())
//       .map((element)=>ProductDataModal.fromJson(element))
//   );
List<LabTestSearchDataModal> get getSearchList=>List<LabTestSearchDataModal>.from(
    (searchController.text==''?searchList:searchList.where((element)=>element['name'].toString().toLowerCase().contains(searchController.text.toString().toLowerCase())).toList())
    .map((e) =>LabTestSearchDataModal.fromJson(e))
);

set updateSearchList(List val){
  searchList=val;
  update();
}
}