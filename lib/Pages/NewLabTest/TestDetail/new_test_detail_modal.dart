//
// import 'package:digi_doctor/AppManager/raw_api.dart';
//
// import '../../../AppManager/app_util.dart';
// import '../../../AppManager/user_data.dart';
// import 'package:get/get.dart';
//
// import 'new_test_detail_controller.dart';
// class NewTestDetailModal{
//   HttpApp httpApp = HttpApp();
//   UserData userData = UserData();
//   RawData rawData = RawData();
//
//   getEraInvestigation(context) async {
//     var body = {
//     "PID":  userData.getUserPid.toString(),
//     "categoryID": Get.arguments[0].toString(),
//     "collectionDate":Get.arguments[1].toString(),// "06/09/2022",
//     "subCategoryID": Get.arguments[2].toString()
//     };
//     var data = await httpApp.api(
//         'InvestigationSubCategoryWise/GetInvestigationDetailsDigiDoctor', body, context);
//     //print("---------"+data.toString());
//     Get.find<NewTestDetailController>().showNoData.value = true;
//     Get.find<NewTestDetailController>().updateTestDetailList = data['subTestListDetails'];
//   }
//
//   // Future<void>getTestDetails(context) async {
//   //   //controller.showNoData;
//   //   var body = {
//   //       "subTestId": "1837"
//   //   };
//   //   var data = await httpApp.api(
//   //       'InvestigationSubCategoryWise/GetInvestigationDetailsDigiDoctor', body, context);
//   //   //print("---------"+data.toString());
//   //   Get.find<NewTestDetailController>().showNoData.value = true;
//   //   //print(data['investigationList'].toString());
//   //   Get.find<NewTestDetailController>().updateTestDetailList = data['subTestListDetails'];
//   // }
//
//   Future<void> getTestInfo(context,String id)async{
//     Get.find<NewTestDetailController>().showNoData2.value = false;
//     var body = {
//       //"subTestId": "1826",
//       "subTestId": id
//     };
//     var data = await rawData.api('getInvestigationSubtestReason', body, context,newBaseUrl:"http://182.156.200.179:332/api/v1.0/Knowmed/" ,isNewBaseUrl: true);
//
//    if(data['responseCode']==1){
//       Get.find<NewTestDetailController>().showNoData2.value = true;
//      Get.find<NewTestDetailController>().updateTestInfo = data["responseValue"];
//    }
//
//
//   }
// }


import 'package:digi_doctor/AppManager/raw_api.dart';

import '../../../AppManager/app_util.dart';
import '../../../AppManager/user_data.dart';
import 'package:get/get.dart';

import 'new_test_detail_controller.dart';
class NewTestDetailModal extends GetxController{
  HttpApp httpApp = HttpApp();
  UserData userData = UserData();
  RawData rawData = RawData();

  int isNotification = 0;
  int get getIsNotification=>isNotification;
  set updateIsNotification(val){
    isNotification=val;
    update();
  }

  int pid = 0;
  int get getPID=>pid;
  set updatePID(val){
    pid=val;
    update();
  }

  getEraInvestigation(context) async {
    var setPID = '';
    if (getIsNotification == 1){
      setPID = getPID.toString();

    }else{
      setPID = userData.getUserPid.toString();
    }
    var body = {
      "PID": setPID,
      "categoryID": Get.arguments[0].toString(),
      "collectionDate":Get.arguments[1].toString(),// "06/09/2022",
      "subCategoryID": Get.arguments[2].toString()
    };
    var data = await httpApp.api(
        'InvestigationSubCategoryWise/GetInvestigationDetailsDigiDoctor', body, context);
    Get.find<NewTestDetailController>().showNoData.value = true;
    Get.find<NewTestDetailController>().updateTestDetailList = data['subTestListDetails'];
  }


  Future<void> getTestInfo(context,String id)async{
    Get.find<NewTestDetailController>().showNoData2.value = false;
    var body = {
      //"subTestId": "1826",
      "subTestId": id
    };
    var data = await rawData.api('getInvestigationSubtestReason', body, context,newBaseUrl:"http://182.156.200.179:332/api/v1.0/Knowmed/" ,isNewBaseUrl: true);

    if(data['responseCode']==1){
      Get.find<NewTestDetailController>().showNoData2.value = true;
      Get.find<NewTestDetailController>().updateTestInfo = data["responseValue"];
    }


  }
}