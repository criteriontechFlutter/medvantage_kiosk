import 'package:digi_doctor/Pages/LabTests/Test/DataModal/test_data_modal.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TestsController extends GetxController{

  TextEditingController searchController = TextEditingController();
RxInt testId=0.obs;
  int get getTestId=>testId.value;
  set updateTestId(int val) {
    testId.value = val;
    update();

  }

  RxBool showNoTopData=false.obs;
  bool get getShowNoTopData=>(showNoTopData.value);
  set updateShowNoTopData(bool val){
    showNoTopData.value=val;
    update();
  }

  List testList=[].obs;
  List <TestDataModal> get getTestList=>List<TestDataModal>.from(
      (searchController.text==''?testList:testList.where((element) => element['testName'].toString().toLowerCase().contains(searchController.text.toString().toLowerCase())).toList())
      .map((e) => TestDataModal.fromJson(e))
  );
  set updateTestListData(List val){
    testList=val;
    update();
  }
}

//List<LabTestSearchDataModal> get getSearchList=>List<LabTestSearchDataModal>.from(
//     (searchController.text==''?searchList:searchList.where((element)=>element['name'].toString().toLowerCase().contains(searchController.text.toString().toLowerCase())).toList())
//     .map((e) =>LabTestSearchDataModal.fromJson(e))
// );