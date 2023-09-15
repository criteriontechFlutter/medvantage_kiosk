import 'package:get/get.dart';

import 'DataModal/lab_test_data_modal.dart';

class LabTestNavigationController extends GetxController{


  List dropDownDateList = [
    {
      "id":'-3',
      "name":"Last 3 Months"
    },
    {
      "id":'-6',
      "name":"Last 6 Months"
    },
    {
      "id":'-12',
      "name":"Last 12 Months"
    },
    {
      "id":'-1',
      "name":"All"
    },
  ];

  List eraInvestigationList = [].obs;

  List<InvestigationListDataModal> get getEraInvestigationList=>
      eraInvestigationList.map((element) => InvestigationListDataModal.fromJson(element)).toList()
  ;

  set updateEraInvestigationList(List val){
    eraInvestigationList=val;
    update();
  }

  RxBool showNoData = false.obs;

   set updateShowNoData(bool val){
     showNoData.value=val;
     update();
   }
  RxString selectTime = '-6'.obs;

}