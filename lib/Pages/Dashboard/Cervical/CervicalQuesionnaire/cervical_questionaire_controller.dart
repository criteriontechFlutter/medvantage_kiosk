

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CervicalQuestionnaireController extends GetxController{
  //for main page
  int totalPage = 3;
  int _currentPage = 0;
  get getCurrentPage =>_currentPage;
  set updateCurrentPage(int val){
    _currentPage = val;
    update();
  }
  List<String>questions = ["Start and End time of your pain?","How bad is your pain in the average?"
    ,"Does your pain interfere in driving or riding?"];

//for pain intensity widget
  String intensityPicture = "assets/no_pain.svg";
  double intensityPictureHeight = 55;
  String painLabel = 'Slide to select the pain intensity';
  Color activeColor = Colors.grey;
  double lowerValue = 0.0;
  double upperValue = 10.0;
  double painIntensity = 0.0;
  void updatePainIntensity(val){
    painIntensity = val;
    if(painIntensity<=2){
      intensityPicture = "assets/no_pain.svg";
      intensityPictureHeight = 55;
      painLabel = 'No Pain';
      activeColor = Colors.green;
    }
    else if(painIntensity>2&&painIntensity<=4){
      intensityPicture = "assets/mild_pain.svg";
      intensityPictureHeight = 75;
      painLabel = 'Mild Pain';
      activeColor = Colors.lightGreen;
    }
    else if(painIntensity>4&&painIntensity<=6){
      intensityPicture = "assets/moderate_pain.svg";
      intensityPictureHeight = 75;
      painLabel = 'Moderate Pain';
      activeColor = Colors.amber;
    }
    else if(painIntensity>6&&painIntensity<=8){
      intensityPicture = "assets/severe_pain.svg";
      intensityPictureHeight = 60;
      painLabel = 'Severe Pain';
      activeColor = Colors.orange;
    }
    else{
      intensityPicture = "assets/maddening_pain.svg";
      intensityPictureHeight = 60;
      painLabel = 'Extreme Pain';
      activeColor = Colors.red;
    }
    update();
  }

//for driving questions widget

List drivingQuestions = [
  {
    "question":"Not at all",
    "isChecked":false,
    "id":"1"
  },
  {
    "question":"Can't drive or ride ",
    "isChecked":false,
    "id":"2"
  },
];

  void updateIsChecked(int index,bool isChecked){
    for (var element in drivingQuestions) {
      element["isChecked"] = false;
    }
    drivingQuestions[index]["isChecked"]=isChecked;
    update();
  }

}