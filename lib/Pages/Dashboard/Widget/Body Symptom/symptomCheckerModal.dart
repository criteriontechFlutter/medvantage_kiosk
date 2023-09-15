
import 'package:get/get.dart';

import '../../../../AppManager/alert_dialogue.dart';
import '../../../../AppManager/app_util.dart';
import '../../../../AppManager/raw_api.dart';
import '../../../../AppManager/user_data.dart';
import 'animation.dart';
import 'symptomCheckerController.dart';
import 'symptomCheckerDataModal.dart';

class SymptomCheckerModal{

  SymptomCheckerController controller =Get.put(SymptomCheckerController());

  UserData userData=UserData();
  RawData rawData=RawData();
  App app=App();

  // clearTextFields(){
  //   controller.ageC.value.clear();
  //   controller.heightC.value.clear();
  //   controller.kgC.value.clear();
  //   controller.lbsC.value.clear();
  //   controller.inchC.value.clear();
  //   controller.fitC.value.clear();
  //   controller.update();
  // }
  //
  //
  // ageUnit(context)async{
  //
  //   var body={
  //     "userId":"120"       //UserData().getUserData.id.toString()
  //   };
  //
  //   var data=await rawData.api('Knowmed/ageUnitList',body, context,token: true);
  //   if(data['responseCode']==1){
  //    controller.updateAgeUnitList=data['responseValue'];
  //     print('Age Unit: '+data.toString());
  //   }else{
  //     alertToast(context, data['responseMessage']);
  //   }
  //
  // }
  //
  // void calculateBMI(BuildContext context){
  //   if(controller.isMetric){
  //     if(controller.heightC.value.text.isEmpty||controller.kgC.value.text.isEmpty){
  //
  //     }else{
  //       controller.updateBMI=(double.parse(controller.kgC.value.text)/(double.parse(controller.heightC.value.text)/100.0*double.parse(controller.heightC.value.text)/100.0));
  //     }
  //
  //
  //   }else{
  //     if(controller.fitC.value.text.isEmpty||controller.inchC.value.text.isEmpty||controller.lbsC.value.text.isEmpty){
  //
  //     }else{
  //       var heightFeet=int.parse(controller.fitC.value.text);
  //       var heightInch=int.parse(controller.inchC.value.text);
  //       var weightlbs=double.parse(controller.lbsC.value.text);
  //
  //       var inches=((heightFeet*12.toInt())+heightInch.toInt()).toDouble();
  //
  //       controller.updateBMI=((weightlbs/(inches*inches))*703.toInt());
  //     }
  //
  //
  //   }
  //   print(controller.getBMI.toStringAsFixed(2));
  // }

  onClickAnimation(context)async{

    var body={
      "bodyRegionId": controller.getSelectedId.toString()
    };

    var data=await rawData.knowMedApi('Knowmed/getBodyOrganRegion', body, context,token: true);
    if(data['responseCode']==1){
      controller.updateBodyOrganRegionList=data['responseValue'];
      print('00000000000000000000000000'+data.toString());
    }else{
      alertToast(context, 'Something went wrong');
    }

  }

int i=0;
  List alphabets = [];
  getLetters(){
    for(i = 65;i<=90;i++){
      alphabets.add(String.fromCharCode(i));
    }

  }


  onSymptomsClick(context)async{
    controller.updateShowNoData=false;
    var body={
      "regionOrganId": controller.getSelectSymptomId.toString(),
      "alphabet":controller.alpha.toString(),
      "userId":UserData().getUserId.toString()
    };

    var data=await rawData.knowMedApi('Knowmed/getAllSymptoms', body, context,token: true);
    controller.updateShowNoData=true;
    if(data['responseCode']==1){
      controller.updateAllSymptomsList=data['responseValue'];
      print("rrrrrrrrrr"+data.toString());
    }else{
      alertToast(context, 'Something went wrong');
    }

  }

  onBodyPartSymptomsTap(int index){
    print( controller.getAllSymptomsList[index].id.toString(),);
    if(controller.onTapBodyPartSymptomsId.contains(controller.getAllSymptomsList[index].id)){
      controller.onTapBodyPartSymptomsId.remove(controller.getAllSymptomsList[index].id);
      controller.update();
    }
    else{
      controller.onTapBodyPartSymptomsId.add(controller.getAllSymptomsList[index].id);
      controller.update();
      print("list : " + controller.onTapBodyPartSymptomsId.toString());
    }

  }

  
  onTapProblemSearch(context)async {

    var body={
      "alphabet":controller.searchC.value.text.toString(),
      "userId":UserData().getUserId.toString()
    };

    var data=await rawData.knowMedApi('Knowmed/getAllProblemList', body, context,token: true);
    controller.updateSuggestedSearchList=data['responseValue'];
    print("alphabet: " + controller.searchC.value.text.toString(),);
    print("Search & add problem"+data.toString());
  }






  onSuggestedProblem(context,)async{
    var body={
      "problemId":""     // poochna hai ki pairameter empty jayega ya dynamic
    };

    var data=await rawData.knowMedApi('Knowmed/getAllSuggestedProblem', body, context,token: true);
    if(data['responseCode']==1){

      for(int i=0; i<data['responseValue'].length;i++){
        data['responseValue'][i].addAll({'attributeList':[]});
      }
      controller.updateSuggestedProblemList=data['responseValue'];
      print("_____------_____"+data.toString());
    }else{
      alertToast(context, 'Something went wrong');
    }

  }

  void onSuggestProblemTap(context,String id){
    if(controller.unlocalizedProblemId.contains(id.toString())){
      controller.unlocalizedProblemId.remove(id.toString());
      controller.update();
    }else{
      controller.unlocalizedProblemId.add(id.toString());
       onTapSuggestedProblemSymptoms(context);
      controller.update();
      print("Problem List :"+controller.unlocalizedProblemId.toString());
    }
    controller.searchC.value.clear();
    controller.update();
  }

  void addedOption(context,SuggestedUnlocalizedProblemDataModal suggestedSearchData) async {

    Map<String,dynamic> selectedProblem ={
      "id":suggestedSearchData.id,
      "problemName":suggestedSearchData.problemName.toString(),
    };
    controller.suggestedProblemList.insert(0,selectedProblem);
    controller.searchC.value.clear();
    //controller.unlocalizedProblemId.add(suggestedSearchData.id);

    controller.update();

    //onTapSuggestedProblemSymptoms(context);
    onSuggestProblemTap(context,suggestedSearchData.id.toString());
    print("Problem add :"+controller.unlocalizedProblemId.toString());
  }


  //On tap Disease you suffered search


  onTapDiseaseSearch(context)async {

    var body={
      "alphabet":controller.diseaseSearchC.value.text.toString(),
      "userId":UserData().getUserId.toString()
    };

    var data=await rawData.knowMedApi('Knowmed/getAllDiseaseByAlphabet', body, context,token: true);
    controller.updateDiseaseSearchList=data['responseValue'];
    //print("alphabet: " + controller.searchC.value.text.toString(),);
    print("Search Disease"+data.toString());
  }





  onAddAnyOtherDisease(context)async{

    var body={
      "":""
    };

    var data=await rawData.knowMedApi('Knowmed/getAllSuggestedDisease', body, context,token: true);
    controller.updateAddOtherDiseaseList=data['responseValue'];
    print('////////'+data.toString());
  }

  void onTapDisease(String id,context){
    if(controller.diseaseSufferedId.contains(id.toString())){
      controller.diseaseSufferedId.remove(id.toString());
      controller.update();
    }else{
      controller.diseaseSufferedId.add(id.toString());
      controller.update();
      print("Disease List: "+controller.diseaseSufferedId.toString());
    }
  }

  void addedDisease(context,AddAnyOtherDiseaseDataModal diseaseData){
    print("add: " + diseaseData.problemName.toString());
    Map<String,dynamic> dList ={
      "id":diseaseData.id,
      "problemName":diseaseData.problemName.toString(),
    };
    controller.addOtherDiseaseList.insert(0,dList);

    controller.update();
    controller.diseaseSearchC.value.clear();

    onTapDisease(diseaseData.id.toString(), context);
    print("Problem add :"+controller.diseaseSufferedId.toString());
  }


  onTapSuggestedProblemSymptoms(context,)async{
    controller.updateProblemsSymptomsTapList=[];
    var body={
      "problemId":controller.getSelectedPid.toString(),
      "userId":UserData().getUserId.toString()
    };

    var data=await rawData.knowMedApi('Knowmed/getAttributeList', body, context,token: true);
    print("Problem Symptoms"+data.toString());
    if(data['responseCode']==1){

       for(int i=0;i<data['responseValue'].length;i++){
         for(int j=0;j<data['responseValue'][i]['attribute'].length;j++){
           data['responseValue'][i]['attribute'][j].addAll({'isSelected':false});
         }
         }

       controller.updateProblemsSymptomsTapList=data['responseValue'];
      if( controller.getProblemsSymptomsTapList.isNotEmpty){
        onTapSuggestedProblemSymptomsWidget(context);
      }
    }else{
      alertToast(context, data['responseMessage']);
    }
  }


  onTapAttribute(context ,Map attributeMap,index,index2,attributeValue){
    attributeMap.addEntries({"attributeName":attributeValue.toString()}.entries);
    print('finalMap'+attributeMap.toString());
    controller.problemsSymptomsTapList[index]['attribute'][index2]['isSelected']=!controller.problemsSymptomsTapList[index]['attribute'][index2]['isSelected'];
    if(controller.suggestedProblemList[controller.getSelectedProblemIndex]['attributeList'].isEmpty){
      controller.suggestedProblemList[controller.getSelectedProblemIndex]['attributeList'].add(attributeMap);
    }
    else{
      bool isFound=false;
      int tapIndex=0;
      for (int i = 0;  i < controller.suggestedProblemList[controller.getSelectedProblemIndex]['attributeList'].length; i++) {
        if(controller.suggestedProblemList[controller.getSelectedProblemIndex]['attributeList'][i]['attributeValueId']==attributeMap['attributeValueId']){
          isFound=true;
          tapIndex=i;
        }
      }

      if(!isFound){
        controller.suggestedProblemList[controller.getSelectedProblemIndex]['attributeList'].add(attributeMap);
      }else{
        controller.suggestedProblemList[controller.getSelectedProblemIndex]['attributeList'].removeAt(tapIndex);
      }
    }
    controller.update();
    print( 'nnnnnnnnnnnnnnnnnnnnnnnnnn'+controller.suggestedProblemList[controller.getSelectedProblemIndex]['attributeList'].toString());
    print( 'nnnnnnnnnnnnnnnnnnnnnnnnnn'+controller.suggestedProblemList[controller.getSelectedProblemIndex]['attributeList'][0]['problemId'].toString());



  }




}