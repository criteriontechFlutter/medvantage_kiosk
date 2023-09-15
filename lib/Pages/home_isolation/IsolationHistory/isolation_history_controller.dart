


import 'package:get/get.dart';

import '../DataModal/isolation_history_data_modal.dart';

class IsolationHistoryController extends GetxController{

  RxBool showNoData=false.obs;
  bool get getShowNoData=>(showNoData.value);
  set updateShowNoData(bool val){
    showNoData.value=val;
    update();
  }


 List requestList=[].obs;
 List<IsolationHistoryDataModal> get getRequestList=>List<IsolationHistoryDataModal>.from(
     requestList.map((element) => IsolationHistoryDataModal.fromJson(element))
 );
 set updateRequestList(List val){
   requestList=val;
   update();
 }


}