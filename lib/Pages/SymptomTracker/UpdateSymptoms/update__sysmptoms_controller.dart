

import 'package:get/get.dart';

import '../DataModal/problem_data_modal.dart';

class UpdateSymptomsController extends GetxController{


  RxBool showNoData=false.obs;
  bool get getShowNoData=>(showNoData.value);
  set updateShowNoData(bool val){
    showNoData.value=val;
    update();
  }

  RxString selectedMemberId=''.obs;

  RxString selectedYesOrNo=''.obs;
  String get getSelectedMemberId=>selectedYesOrNo.value;
  set updateSelectedYesOrNo(String val){
    selectedYesOrNo.value=val;
    update();
  }


RxInt currentIndex=0.obs;
int get getCurrentIndex=>currentIndex.value;
set updateCurrentIndex(int val){
  currentIndex.value=val;
  update();
}



  List symptomsList=[].obs;
  List<ProblemDataModal> get getSymptomsList => List<ProblemDataModal>.from(
      symptomsList.map((element) => ProblemDataModal.fromJson(element)));
  set updateSymptomsList(List val){
    symptomsList=val;
    update();
  }


updateSelectedData(index, val){
  symptomsList[index]['isSelected']=val;
  print(symptomsList.toString());
}


  List memberList=[].obs;
  List get getMemberList=>memberList;
  set updateMemberList(List val){
    memberList=val;
    update();
  }


}