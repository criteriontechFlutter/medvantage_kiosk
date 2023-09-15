

import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../../AppManager/alert_dialogue.dart';

class EcgViewModal extends ChangeNotifier {

    double hrValue=0;
    double get getHrValue=>hrValue;
    set updateHrValue(double val){
      hrValue=val;
      notifyListeners();
    }

    List peakList=[];
    List get getPeakList=>peakList;
    set updatePeakList(List val){
      peakList=val;
      notifyListeners();
    }


    String recordData='';
    String get getRecordData=>recordData;
    set updateRecordData(double val){
      if(recordData.length<=8000){
        if(recordData==''){
        recordData = recordData + val.toString();
      }
        else{
          recordData = recordData + "," + val.toString();
        }
    }
    notifyListeners();
    }

    bool isRecordData=false;
    bool get getIsRecordData=>isRecordData;
    set updateIsRecordData(bool val){
      isRecordData=val;
      notifyListeners();
    }


    clearData(){
      recordData='';
      notifyListeners();
    }


  myData(abc,count){
    double maxValue=0;
    double th=0.0;
    List demo=[];

    double compValue = 0.0;
    double smallest=0.0;
    int compValueIndex=0;
    updatePeakList=[];

      for (int i = 0; i < abc.length; i++) {
        if (maxValue < abc[i]) {
          maxValue = abc[i];
        }
      }

      th = maxValue - (maxValue / 5);
      bool isFound = false;

      for (int i = 0; i < abc.length; i++) {
        if (th < abc[i]) {
          if (compValue < abc[i]){
            compValue = abc[i];
            compValueIndex = i;
            smallest = compValue;
          }
          else if (smallest > abc[i]) {
            smallest = abc[i];
          }
          else {
            peakList.add({'value': compValue, 'compIndex': compValueIndex});
            compValue = smallest;
          }
        }
      }


      double rr = 0.0;

      for (int i = 0; i < peakList.length - 1; i++) {

        if((peakList[i + 1]['compIndex'] - peakList[i]['compIndex']) < 100) {
          peakList.removeAt(i);
        }
        else{
           rr = (peakList[i + 1]['compIndex'] - peakList[i]['compIndex']) * (count/1500);
          updateHrValue= 60000 /rr;
        }
      }
      notifyListeners();
  }


  String apiResponse='nnn';
    String get getApiResponse=>apiResponse;

    set updateApiResponse(String val){
      apiResponse=val;
      notifyListeners();
    }

  saveECG(context) async {
     // try{
       Map  body={
    "time": DateTime.now().toString(),
    "PID": '2076643',
    "location": 'Lucknow' ,
     "patientInfo": {
      "name":'vishal Singh',
       "gender": "M",
       "city":'Lucknow',
       "age":'25',
     } ,
    'payLoad': {
      "leadName": "LEAD II",
      "data": getRecordData
    }
       };

      // print(json.encode(body).toString());
      var response = await http.post(Uri.parse('http://172.16.5.250:1880/ecg'),
           body:   json.encode(body),
          headers: {
        "authKey": "4S5NF5N0F4UUN6G",
           "content-type": "application/json",
          });

      print(body.toString());
      var data = await json.decode(response.body);

      print('nnnnnnnnnnnn'+data.toString());

    if(data['status']==200){
        updateApiResponse =  json.encode(body).toString();
       // alertToast(context, data['message']);
       if(getIsRecordData){
         alertToast(context, 'Data Recorded Successfully');
         updateIsRecordData = false;
       }
      }
    // }
    // catch(e){
    //    print('nnnnnn'+e.toString());
    //   alertToast(context, 'Data Not Saved');
    // }
  }


}