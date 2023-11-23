
import 'dart:convert';

import 'package:digi_doctor/Pages/Symptoms/top_symptom_data_modal.dart';
import 'package:digi_doctor/Pages/Symptoms/top_symptoms_controller.dart';
import 'package:digi_doctor/Pages/VitalPage/LiveVital/stetho_master/AppManager/raw_api.dart';
import 'package:get/get.dart';

import '../../AppManager/alert_dialogue.dart';
import '../../AppManager/raw_api.dart';
import '../../AppManager/user_data.dart';

class TopSymptomsModal {
  var data;
  List symptomData = [];
  List demoList = [];
  TopSymptomsController controller = Get.put(TopSymptomsController());
  RawData rawData = RawData();



 Future<void> onPressed(context) async{
  //  await getDoctorBySymptom(context);
   // await getDoctorsList(context);

  }


  Future<void> onPressedSelectSearchList(int index,TopSymptomsDataModal listData ) async{

    String c = controller
        .getSuggestionsData[index].problemName
        .toString();
    for (int h = 0; h <
        controller.suggestionsList
            .length -  1;  h++) {
      if (controller
          .suggestionsList[h]
      ['problemName']
          .toString() ==
          c) {

        controller.suggestionsList[h]
        ['isSelected'] =
        !controller.suggestionsList[h]
        ['isSelected'];
      }
    }
    if (controller.demoList
        .contains(listData.problemName)) {
      controller.demoList
          .remove(listData.problemName);
      controller.problemId
          .remove(listData.id);
      controller.problemSaved
          .remove(listData.problemName);
    }
    else {
      controller.demoList
          .add(listData.problemName);
      controller.problemId
          .add(listData.id);
      controller.problemSaved
          .add(listData.problemName);
    }
    controller.update();
  }

  Future<void> onPressedRemoveSearchedData(int index)async{
    for (int r = 0;
    r < controller.suggestionsList.length;
    r++) {
      // print(controller.suggestionsList[r]['problemName'].toString() +" "+ controller.suggestionsList[r]['isSelected'].toString());
      if (controller.demoList[index]
          .toString() ==
          controller.suggestionsList[r]
          ['problemName']
              .toString()) {
        controller.suggestionsList[r]
        ['isSelected'] = !controller.suggestionsList[r]
        ['isSelected'];
      }
    }
    controller.demoList.removeAt(index);
    controller.problemSaved.removeAt(index);
    controller.problemId.removeAt(index);
    controller.update();
  }


  Future<void> onPressedRemoveListData(int index ,TopSymptomsDataModal listData) async{
    controller.symptomsList[index]['isSelected'] = !listData.isSelected;
    if (controller.problemSaved.contains(listData.problemName)) {
      controller.problemSaved
          .remove(listData.problemName);
      controller.problemId.remove(listData.id);
    }
    else {
      controller.problemSaved
          .add(listData.problemName);
      controller.problemId.add(listData.id);

    }
    controller.update();
  }

  Future<void> addSelectedSymptoms(index,value)async {
   if( !controller.selectedSymptoms.contains(value)){
   controller.selectedSymptoms.add(value);
  }
   else if(controller.selectedSymptoms.contains(value)){
     controller.selectedSymptoms.remove(value);
   }
   controller.update();
  }



  Future<void> getSymptoms(context) async {
    controller.updateShowNoData=false;
    var body = {
      "problemName": ""
    };
   var data = await rawData.api('Patient/getProblemsWithIcon', body, context);
    controller.updateShowNoData=true;
    for(int i=0;i<data['responseValue'].length;i++) {
      var additionalData = {
        'isSelected': false,
      };
      data['responseValue'][i].addAll(additionalData);
    }
    if(data['status']==0){
      alertToast( context,data['message']);
    }
    else{
      if(data['responseCode']==1){
        controller.updateTopSymptomsList=data['responseValue'];

      }
      else{
        alertToast( context,data['message']);
      }
    }
  }


 Future<void> getProblemSuggestions(context) async {
    var body = {
      "alphabet": controller.searchC.value.text.toString()
    };
    var data = await rawData.api('Patient/getAllProblems', body, context);
    for(int j=0;j<data['responseValue'].length;j++) {
      var additionalData = {
        'isSelected': false,
      };
      var problems = {
        'problem_id': controller.problemId,
        'problem_name': controller.problemSaved,
      };
      controller.demoMap.addAll(problems);
      data['responseValue'][j].addAll(additionalData);
    }

    if(data['status']==0){
      alertToast( context,data['message']);
    }
    else{
      if(data['responseCode']==1){
        controller.updateSuggestionsList = data['responseValue']?? [];
      }
      else{
        alertToast( context,data['message']);
      }
    }
  }


 Future<void> getDoctorBySymptom(context) async{
    String demoString = "";
    String cached = "";
    demoString = demoString + controller.problemId.toString();
    for(int d =0;d<demoString.length;d++){
      if(demoString[d] == '[' || demoString[d] == "]" || demoString[d] == " "){
        print("");
      }
      else{
        cached = cached + demoString[d];
      }
    }
    controller.selectedId.value=cached;

    var body = {
      "memberId":UserData().getUserId.toString(),
      "symptomId":cached.toString(),
    };
    var data = await rawData.api('Patient/getDoctorProfileBySymptom', body, context);
    if(data['status']==0){
      controller.update_recommended_doctors = data['responseValue'];
      alertToast( context,data['message']);

    }
    else{
      if(data['responseCode']==1){
      }
      else{
        alertToast( context,data['message']);
      }
    }
  }
  
  
  
//   Future<void>getDoctorsList(context)async{
//    var body=[{"organId":50},{"organId":19}];
//    var b = jsonEncode(body);
//    var data = await RawDataApi().getapi('/api/OrganDepartmentMapping/GetDoctorBySymptoms?JsonOrgan=$b', context);
//    print(data['responseValue'].toString());
//    if(data["status"].toString()=='1'){
//      print('${data}abcd');
//      List<dynamic> responseValue=data['responseValue'];
// print(responseValue.toString()+'12345678901234567890');
//      controller.update_recommended_doctors = responseValue;
//      alertToast( context,data['message']);
//    }
//   }

}