

import 'package:digi_doctor/Pages/Dashboard/DataModal/speech_NLP.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import 'DataModal/body_organ_data_modal.dart';
import 'DataModal/organ_symptom_data_modal.dart';

class OrganController extends GetxController{

  Rx<TextEditingController> searchC=TextEditingController().obs;
  Rx<TextEditingController> searchSpeechToText=TextEditingController().obs;


  List bodyParts=[].obs;
  get getBodyParts=>bodyParts;
  set updateBodyParts(val){
    bodyParts=val;
    update();
  }

  List  listItemsOne = [
    {
      "isSelected":false,
      'img':'assets/abdomen.svg',
      'title':'Abdomen',
      'id':'1',
      'language':'1'
    },
    {
      "isSelected":false,
      'img':'assets/backpain.svg',
      'title':'Back Pain',
      'id':'12',
      'language':'1'
    },
    {
      "isSelected":false,
      'img':'assets/ear.svg',
      'title':'Ear',
      'id':'19',
      'language':'1'
    },
    {
      "isSelected":false,
      'img':'assets/redeye.svg',
      'title':'Eye',
      'id':'22',
      'language':'1'
    },
    {
      "isSelected":false,
      'img':'assets/face.svg',
      'title':'Face',
      'id':'23',
      'language':'1'
    },
    {
      "isSelected":false,
      'img':'assets/arm.svg',
      'title':'Hand',
      'id':'27',
      'language':'1'
    },
    {
      "isSelected":false,
      'img':'assets/leg.svg',
      'title':'Leg',
      'id':'32',
      'language':'1'
    },
    {
      "isSelected":false,
      'img':'assets/mouth.svg',
      'title':'Mouth',
      'id':'34',
      'language':'1'
    },
    {
      "isSelected":false,
      'img':'assets/neck.svg',
      'title':'Neck',
      'id':'36',
      'language':'1'
    },
    {
      "isSelected":false,
      'img':'assets/nose.svg',
      'title':'Nose',
      'id':'37',
      'language':'1'
    },
    {
      "isSelected":false,
      'img':'assets/pelvis.svg',
      'title':'Pelvis',
      'id':'39',
      'language':'1'
    },
    {
      "isSelected":false,
      'img':'assets/skin.svg',
      'title':'Skin',
      'id':'42',
      'language':'1'
    },
    {
      "isSelected":false,
      'img':'assets/spine.svg',
      'title':'Spine',
      'id':'12',
      'language':'1'
    },
    {
      "isSelected":false,
      'img':'assets/mouth.svg',
      'title':'Teeth',
      'id':'43',
      'language':'1'
    },
    {
      "isSelected":false,
      'img':'assets/Clinical Features.svg',
      'title':'Full Body',
      'id':'50',
      'language':'1'
    },
  ].obs;

  List<BodyOrganDataModal> get getListItemsOne=>List<BodyOrganDataModal>.from(
      listItemsOne.map((element) => BodyOrganDataModal.fromJson(element)));





  RxString selectedLangId=''.obs;
  String get getSelectedLangId=>selectedLangId.value;
  set updateSelectedLangId(String val){
    selectedLangId.value=val;
    update();
  }


  List organSymptomList=[].obs;

  // List<OrganSymptom> get getOrganSymptomList=>List<OrganSymptom>.from(
  //     (
  //         (searchC.value.text==''?organSymptomList:organSymptomList.where((element) =>
  //             (
  //                 element['symptoms'].toString().toLowerCase().trim()
  //             ).trim().contains(searchC.value.text.toLowerCase().trim())
  //         ))
  //             .map((element) => OrganSymptom.fromJson(element))
  //     )
  // );
  List<ProblemName> get getOrganSymptomList=>List<ProblemName>.from(
      (
          (searchC.value.text==''?organSymptomList:organSymptomList.where((element) =>
              (
                  element['symptoms'].toString().toLowerCase().trim()
              ).trim().contains(searchC.value.text.toLowerCase().trim())
          ))
              .map((element) => ProblemName.fromJson(element))
      )
  );




  set updateOrganSymptomList(List val){
    organSymptomList=val;
    update();
  }


  List selectedOrganSymptomList=[].obs;
  List selectedOrganSymptomID=[].obs;


  List selectedOrganId=[].obs;


  Map nlpData={};
  NLP_data_modal get getNLPData=>NLP_data_modal.fromJson(nlpData);
  set updateNLPData(val){
    nlpData=val;
    update();
  }
List? ids=[];
  List? get getIds=>ids;
  set updateIds(List? val){
    ids=val;
    update();
  }





}
