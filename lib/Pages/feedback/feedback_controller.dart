import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'DataModal/feedback_data_model.dart';

class FeedbackController extends GetxController{

     final formKey = GlobalKey<FormState>().obs;


   updateQuestionRatingData(int index, double val){
     questionList[index]['rating']=val;
     update();

  }

  updateNurseRating(int index,double val, ){
     nursingList[index]['rating']=val;
     update();
    }

  updateWardBoyRating(int index,double val, ){
     wardBoyList[index]['rating']=val;
     update();
    }

  updateTechnicianRating(int index,double val, ){
     technicianList[index]['rating']=val;
     update();
    }


  RxString name="".obs;

  Rx<TextEditingController> nurseRatingC=TextEditingController().obs;
  // Rx<TextEditingController> wardBoyRatingC=TextEditingController().obs;
  // Rx<TextEditingController> technicianRatingC=TextEditingController().obs;
  Rx<TextEditingController> questionRatingC=TextEditingController().obs;

  List questionList=[].obs;

  List <QuestionList> get getQuestionList=>List<QuestionList>.from(
      questionList.map((element) => QuestionList.fromJson(element))
  );

  List wardBoyList=[].obs;

  List <Table4> get getWardBoyList=>List<Table4>.from(
      wardBoyList.map((element) => Table4.fromJson(element))
  );

  List technicianList=[].obs;

  List <Table5> get getTechnicianList=>List<Table5>.from(
      technicianList.map((element) => Table5.fromJson(element))
  );
  List doctorList=[].obs;

  List <DoctorList> get getDoctorList=>List<DoctorList>.from(
      doctorList.map((element) => DoctorList.fromJson(element))
  );
  bool textField=false;
  List nursingList=[].obs;

  List <NursingList> get getNursingList=>List<NursingList>.from(
      nursingList.map((element) => NursingList.fromJson(element))
  );
  set updateNursingList(Map val){
    nursingList=val['nursingList'];
    questionList=val['questionList'];
    doctorList=val['doctorList'];
    wardBoyList=val['table4'];
    technicianList=val['table5'];
    update();
  }

    RxBool showNoData=false.obs;
    bool get getShowNoData=>(showNoData.value);
    set updateShowNoData(bool val){
      showNoData.value=val;
      update();
    }



    bool isAdmitted=true;
    bool get getIsAdmitted=>isAdmitted;
    set updateIsAdmitted(bool val){
      isAdmitted=val;
      update();
    }

}