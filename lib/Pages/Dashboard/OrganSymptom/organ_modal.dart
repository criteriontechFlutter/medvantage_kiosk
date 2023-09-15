
import 'dart:convert';

import 'package:digi_doctor/AppManager/app_color.dart';
import 'package:digi_doctor/AppManager/progress_dialogue.dart';
import 'package:digi_doctor/AppManager/raw_api.dart';
import 'package:digi_doctor/Pages/Dashboard/OrganSymptom/speech.dart';
import 'package:digi_doctor/Pages/Symptoms/Select_Doctor/select_doctor_view.dart';
import 'package:digi_doctor/Pages/VitalPage/LiveVital/stetho_master/AppManager/my_text_theme.dart';
import 'package:digi_doctor/Pages/bhojpuri.dart';
import 'package:digi_doctor/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import '../../../AppManager/app_util.dart';
import '../../Symptoms/Select_Doctor/select_doctor_controller.dart';
import '../../Symptoms/topSymptoms2.dart';
import '../../voiceAssistantProvider.dart';
import 'OrganAlertView/selected_organ_problem_view.dart';
import 'organ_controller.dart';
import 'package:digi_doctor/Localization/app_localization.dart';

class OrganModal{

  RawData rawData = RawData();
  OrganController controller=Get.put(OrganController());
  SelectDoctorController selectDoctorController = Get.put(SelectDoctorController());


  selectOrganSymptomList(Map object,Map Organ){
    print(object);
Map newObject={
  'organ': Organ
};
    newObject.addAll(object);


    if(controller.selectedOrganSymptomList.map((e) => e['id']).toList().contains(object["id"])){
      controller.selectedOrganSymptomList.removeAt(
          controller.selectedOrganSymptomList.map((e) => e['id']).toList().indexOf(object["id"])
      );
    }
    else{
      controller.selectedOrganSymptomList.add(newObject);
    }

    controller.update();


  }

  clearSelectedList(){
    for(int i=0;i< controller.listItemsOne.length;i++){
      controller.listItemsOne[i]['isSelected']=false;
    }
    controller.update();
  }

  Future<void> getOrganSymptomList(context,setState,Map Organ) async {

    print(Organ);
    ProgressDialogue().show(context, loadingText: 'Loading...');
    var body = {
      "id": Organ['id'].toString(),
      "language": controller.getSelectedLangId.toString(),
      "symptomName":""
    };
    var data = await rawData.api(
        'GetKioskSymptomsByProblemId', body, context,
        isNewBaseUrl: true, newBaseUrl: 'http://182.156.200.178:192/Services/patientProblem.asmx/',
        token: true);
    ProgressDialogue().hide();
    if (data['responseCode'] == 1) {

      for(int i=0;i<data['responseValue'].length;i++){
        data['responseValue'][i].addAll({'isSelected':false});
      }

        controller.updateOrganSymptomList = data['responseValue'];

       showSymptomDataList(context,setState,Organ);
    }
  }


  getDoctorListData(context) async{
    for(int i=0;i<controller.selectedOrganSymptomList.length;i++){
      controller.selectedOrganId.add(controller.selectedOrganSymptomList[i]['id'].toString());
      controller.update();
    }
    print('nnnnnnnnn'+controller.selectedOrganId.toString());

    Navigator.of(context).pop();
    App().navigate(context,   const TopSymptomsBeta());
    }


  symptomsNLP(context,String speech,bool? bhojpuri)async{

    ApplicationLocalizations localization = Provider.of<ApplicationLocalizations>(context, listen: false);
    VoiceAssistantProvider listenVM = Provider.of<VoiceAssistantProvider>(context, listen: false);

    listenVM.updateLoading=true;
    var code = 'en';
    if(localization.getLanguage.toString()=='Language.english'){
      print('english');
      code = 'en';
    }else if(localization.getLanguage.toString()=='Language.hindi'){
      print('hindi');
      code = 'hi';
    }else if(localization.getLanguage.toString()=='Language.urdu'){
      print('urdu');
      code = 'ur-IN';
    }else if(localization.getLanguage.toString()=='Language.bengali'){
      print('bengali');
      code = 'bn-IN';
    }else if(localization.getLanguage.toString()=='Language.marathi'){
      print('marathi');
      code = 'mr-IN';
    }else if(localization.getLanguage.toString()=='Language.arabic'){
      print('arabic');
      code = 'ar-SA';
    }else{
      code = 'en-IN';
    }
    if(bhojpuri==true){
      code='bho';
    }
    controller.updateIds=[];
    var data=await rawData.apiNLP('?localVoiceData=$speech&languageCode=$code', "", context,token: false);
    print('${jsonEncode(data)}1234567890');
    if(data.toString().isNotEmpty){
      controller.updateNLPData=data;
      print(controller.getNLPData.disease!.finalDiseaseList!.length.toString());
      if(controller.getNLPData.disease!.finalDiseaseList!.isNotEmpty){
        for(int i=0;i<controller.getNLPData.disease!.finalDiseaseList!.length;i++){
          controller.getIds?.add(controller.getNLPData.disease!.finalDiseaseList![i].id.toString());
          print(controller.getIds.toString());
        }
      }
      if(controller.getIds!.isEmpty){
        VoiceAssistantProvider listenVM=Provider.of<VoiceAssistantProvider>(context,listen: false);
        listenVM.listeningPage='main dashboard';
      //  const AlertDialog(title: Text('No symptoms found, please try again'),);
        Navigator.pop(context);
        showDialog<String>(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: Text(localization.getLocaleData.alertToast!.symptomsNotFound.toString(),style: MyTextTheme().veryLargePCB,textAlign: TextAlign.center),
            content: SizedBox(
              height: 70,
              child: Column(
                children: [
                  InkWell(
                    onTap: (){
                      Navigator.pop(context);
                      VoiceAssistantProvider listenVM=Provider.of<VoiceAssistantProvider>(context,listen: false);
                      listenVM.stopListening();
                      if(bhojpuri==true){
                        bhojpuriSheet(context);
                      }else{
                        App().navigate(context, Speech());

                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: AppColor.green,
                      ),
                      child:  Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.mic,color: Colors.white,),
                            Text(localization.getLocaleData.alertToast!.tryAgain.toString(),style: MyTextTheme().largeWCB),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }else{
        listenVM.updateLoading=true;
        App().replaceNavigate(context, RecommendedDoctors(selectedSymptomsId:controller.getIds??[],speechText: speech,));
      }
    }else{
      VoiceAssistantProvider listenVM=Provider.of<VoiceAssistantProvider>(context,listen: false);
      listenVM.listeningPage='main dashboard';
      Navigator.pop(context);
      print('oooooooooooo');
      // App().replaceNavigate(context, RecommendedDoctors(selectedSymptomsId: controller.getIds??[],speechText: speech,));
    }
  }
}