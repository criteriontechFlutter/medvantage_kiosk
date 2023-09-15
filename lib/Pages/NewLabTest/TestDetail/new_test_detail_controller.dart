//
// import 'package:digi_doctor/main.dart';
// import 'package:get/get.dart';
//
// import 'DataModal/new_test_detail_data_modal.dart';
// import 'DataModal/test_info_data_modal.dart';
// import 'new_test_detail_modal.dart';
//
// class NewTestDetailController extends GetxController{
//   NewTestDetailModal modal = NewTestDetailModal();
//
// @override
//   void onInit() async{
//   await modal.getEraInvestigation(NavigationService.navigatorKey.currentContext);
//     super.onInit();
//   }
//
//   List _testDetailList = [];
//
//   RxList<NewTestDetailDataModal> get getTestDetailList=>
//       _testDetailList.map((element) => NewTestDetailDataModal.fromJson(element)).toList().obs
//   ;
//
//   set updateTestDetailList(List val){
//     _testDetailList=val;
//     update();
//   }
//
//   List _testInfo = [].obs;
//   RxList<TestInfoDataModal> get getTestInfo=>
//       _testInfo.map((element) => TestInfoDataModal.fromJson(element)).toList().obs;
//
//   set updateTestInfo(List val){
//     _testInfo=val;
//     update();
//   }
//
//
//   RxBool showNoData = false.obs;
//   RxBool showNoData2 = false.obs;
//
// }



import 'package:digi_doctor/main.dart';
import 'package:get/get.dart';

import 'DataModal/new_test_detail_data_modal.dart';
import 'DataModal/test_info_data_modal.dart';
import 'new_test_detail_modal.dart';

class NewTestDetailController extends GetxController{
  NewTestDetailModal modal = Get.put(NewTestDetailModal());

  @override
  void onInit() async{
    await modal.getEraInvestigation(NavigationService.navigatorKey.currentContext);
    super.onInit();
  }

  List _testDetailList = [];

  RxList<NewTestDetailDataModal> get getTestDetailList=>
      _testDetailList.map((element) => NewTestDetailDataModal.fromJson(element)).toList().obs
  ;

  set updateTestDetailList(List val){
    _testDetailList=val;
    update();
  }

  List _testInfo = [].obs;
  RxList<TestInfoDataModal> get getTestInfo=>
      _testInfo.map((element) => TestInfoDataModal.fromJson(element)).toList().obs;

  set updateTestInfo(List val){
    _testInfo=val;
    update();
  }


  RxBool showNoData = false.obs;
  RxBool showNoData2 = false.obs;

}