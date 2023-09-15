import 'dart:convert';
import 'dart:developer';

import 'package:digi_doctor/AppManager/user_data.dart';
import 'package:digi_doctor/Pages/feedback/feedback_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../AppManager/alert_dialogue.dart';
import '../../AppManager/app_color.dart';
import '../../AppManager/progress_dialogue.dart';
import '../../AppManager/raw_api.dart';
import 'module/verify_feedback_module.dart';

class FeedbackModal {
  FeedbackController controller = Get.put(FeedbackController());
  UserData userData = UserData();

  getFeedbackList(context) async {
    controller.updateShowNoData=false;
    var body = {
       'pid': userData.getUserPid.toString(),
    };

    var data = await RawData().api(
        "PatientFeedback/GetFeedbackList", body, context,isNewBaseUrl: true,
         newBaseUrl: 'http://182.156.200.179:201/api/',
        newToken: 'Bearer 0BE4F774308544ADB68725F0C53F573F-5483',token:true );
    controller.updateShowNoData=true;

    //log('nnnnnnnnnnnnnnn'+data.toString());

    if(data['responseCode']!=200){
      for (int i = 0; i < data['nursingList'].length; i++) {
        var additionalData = {
          'rating': 0.0,
          'controller': TextEditingController()
        };
        data['nursingList'][i].addAll(additionalData);
      }

      for (int i = 0; i < data['questionList'].length; i++) {
        var additionalData = {
          'rating':0.0,
          'controller': TextEditingController()
        };
        data['questionList'][i].addAll(additionalData);
      }
      for (int i = 0; i < data['table4'].length; i++) {
        var additionalData = {
          'rating': 0.0,
          'controller': TextEditingController()
        };
        data['table4'][i].addAll(additionalData);
      }
      for (int i = 0; i < data['table5'].length; i++) {
        var additionalData = {
          'rating': 0.0,
          'controller': TextEditingController()
        };
        data['table5'][i].addAll(additionalData);
      }

      controller.updateNursingList=data;
     controller.updateIsAdmitted = data['table6'].isEmpty? false:data['table6'][0]['isAdmitted']==0? false:true;
    }
    else{
      alertToast(context,data['message'].toString());
    }
  }


  onPressSubmit(context){


    bool nursingListFilled=controller.getNursingList.map((e) => e.rating!=0.0).contains(true);
    bool wardBoyListFilled=controller.getWardBoyList.map((e) => e.rating!=0.0).contains(true);
    bool technicianListFilled=controller.getTechnicianList.map((e) => e.rating!=0.0).contains(true);

    bool questionFilled=controller.getQuestionList.map((e) =>
    e.rating!=0.0
    ).contains(true);


    bool saveFeedBack=nursingListFilled ||questionFilled||wardBoyListFilled||technicianListFilled;
    if(saveFeedBack){
      AlertDialogue().show(context,
          showCancelButton: true,
          msg: 'Confirm To Save Feedback',
          firstButtonName: 'Confirm',
          firstButtonPressEvent: () async {
            Navigator.pop(context);
              await saveRatings(context,"");
          }
      );
    }
    else{
      alertToast(context,"Please rate at least one field");
    }


  }

  saveRatings(context,String otp) async {

    List feedbackData = [];
    for (int i = 0; i < controller.nursingList.length; i++) {
      if (controller.getNursingList[i].rating.toString()=='0.0') {
        feedbackData.add({
          "categoryID": controller.getNursingList[i].categoryId.toString(),
          "feedbackFor":'0',
          "remark":controller.getNursingList[i].controller!.text.toString(),
        });
      }
      else{
        feedbackData.add({
          "categoryID": controller.getNursingList[i].categoryId.toString(),
          "feedbackFor":controller.getNursingList[i].id.toString(),
          "ratingPoint": (controller.getNursingList[i].rating??0.0).toInt().toString(),
          "remark":controller.getNursingList[i].controller!.text.toString(),
        });
      }
    }
    for (int i = 0; i < controller.wardBoyList.length; i++) {
      if (controller.getWardBoyList[i].rating.toString()=='0.0') {
        feedbackData.add({
          "categoryID": controller.getWardBoyList[i].categoryId.toString(),
          "feedbackFor":'0',
          "remark":controller.getWardBoyList[i].controller!.text.toString(),
        });
      }
      else{
        feedbackData.add({
          "categoryID": controller.getWardBoyList[i].categoryId.toString(),
          "feedbackFor":controller.getWardBoyList[i].id.toString(),
          "ratingPoint": (controller.getWardBoyList[i].rating??0.0).toInt().toString(),
          "remark":controller.getWardBoyList[i].controller!.text.toString(),
        });
      }
    }
    for (int i = 0; i < controller.technicianList.length; i++) {
      if (controller.getTechnicianList[i].rating.toString()=='0.0') {
        feedbackData.add({
          "categoryID": controller.getTechnicianList[i].categoryId.toString(),
          "feedbackFor":'0',
          "remark":controller.getTechnicianList[i].controller!.text.toString(),
        });
      }
      else{
        feedbackData.add({
          "categoryID": controller.getTechnicianList[i].categoryId.toString(),
          "feedbackFor":controller.getTechnicianList[i].id.toString(),
          "ratingPoint": (controller.getTechnicianList[i].rating??0.0).toInt().toString(),
          "remark":controller.getTechnicianList[i].controller!.text.toString(),
        });
      }
    }
    for (int i = 0; i < controller.questionList.length; i++) {
      if (controller.getQuestionList[i].rating.toString()=='0.0') {
        feedbackData.add({
          "categoryID": controller.getQuestionList[i].questionCategoryID.toString(),
          "feedbackFor":'0',
          "remark":controller.getQuestionList[i].controller!.text.toString(),
        });
      }
      else
        {
          feedbackData.add({
            "categoryID": controller.getQuestionList[i].questionCategoryID.toString(),
            "feedbackFor":'',
            "ratingPoint": (controller.getQuestionList[i].rating??0.0).toInt().toString(),
            "remark":controller.getQuestionList[i].controller!.text.toString(),
          });
        }
    }
//
    print(feedbackData);

    var body = {
      "counsellorHISId": userData.getUserId.toString(),
      "patientfeedbackByApp": feedbackData,
       "feedbackBy":  userData.getUserPid.toString(),
      "OTP":otp,
      'feedbackFrom':'1'
    };
    //**
    if(feedbackData.isEmpty){
      alertToast(context, "Please rate at least one");
    }
    else {
      ProgressDialogue().show(context, loadingText: 'Submitting Feedback');
      var data = await RawData().api(
        "PatientFeedbackByApp/SavePatientFeedback", body, context,isNewBaseUrl: true,
           newBaseUrl: 'http://182.156.200.179:201/api/',
          newToken: 'Bearer 0BE4F774308544DB68725F0C53F573F-5483',token:true );
      //print('nnnnnnnnnnnnnnnnnnnn'+data.toString());
      ProgressDialogue().hide();


      // if (data['responseCode'] == 200) {


        if(otp==''){
          alertToast(context, 'Enter OTP');
          Color  pageColor=AppColor.bgColor;
          showVerifyFeedbackModule(context,pageColor: pageColor,
          mobileNo: data['table1'][0]['mobileNo'].toString()
          );
        }
        else{
          userData.removeAdmittedData();
          alertToast(context, 'Rating Submitted');
          Navigator.pop(context);
          Navigator.pop(context);
        }

      // } else {
      //   alertToast(context, data['message']);
      // }
    }

  }



}
