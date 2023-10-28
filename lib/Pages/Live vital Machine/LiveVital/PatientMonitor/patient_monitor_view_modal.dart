



import 'dart:convert';
import 'package:digi_doctor/Pages/VitalPage/LiveVital/PatientMonitor/patient_monitor_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../../../../AppManager/raw_api.dart';
import '../../../../AppManager/user_data.dart';
import '../../../VitalPage/Add Vitals/add_vitals_modal.dart';

class PatientMonitorViewModal  extends ChangeNotifier {


  clearData(){
    recordData=[];
    updateIsRecordData=false;
    notifyListeners();
  }

  List recordData=[];
  List get getRecordData=>recordData;
  set updateRecordData(String val) {
    recordData.add(val);
    notifyListeners();
  }


  bool isRecordData=false;
  bool get getIsRecordData=>isRecordData;
  set updateIsRecordData(bool val){
    isRecordData=val;
    notifyListeners();
  }

  bool isMeasureBP=false;
  bool get getIsMeasureBp=>isMeasureBP;
  set updateIsMeasureBp(bool val){
    isMeasureBP=val;
    notifyListeners();
  }




  ChartSeriesController? chartSeriesController;

  List<ChartData> spo2GraphList=[];
  List<double> spo2GraphDataList=[0.0];
  List get getSpo2GraphList=>spo2GraphList;

  int countLength=0;
  updateSpo2GraphList(int count,List val){
      for(int i=0;i<val.length; i++){
       try {
         if(val[i].toString()!='' ||val[i].toString()!=' '){
           spo2GraphDataList
               .add(double.parse(val[i].toString()));

           // while(countLength<=150){
           //   if(spo2GraphDataList.length<=150){
           //     spo2GraphDataList.add(double.parse(val[i].toString()));
           //   }
           //   else{
           //     spo2GraphDataList.insert(countLength, double.parse(val[i].toString()));
           //   }
           //   if(countLength==146){
           //     countLength=0;
           //   }
           //   countLength++;
           //
           //   notifyListeners();
           // }

           // spo2GraphList
           //     .add(ChartData(count, double.parse(val[i].toString())));
        }
      }
       catch (e){
       }
      }
    notifyListeners();
  }

  // updateSpo2GraphList(int count,List val){
  //
  //   for(int i=0;i<val.length; i++){
  //       if(demoList23.length<101){
  //         demoList23.add(double.parse(val[i].toString()));
  //       }
  //       else{
  //         if(count<100){
  //             demoList23[count]=double.parse(val[i].toString());
  //             count++;
  //         }
  //         else{
  //           demoList23[count]=double.parse(val[i].toString());
  //           count=0;
  //         }
  //       }
  //       updateSpo2GdraphList(count, demoList23);
  //   }
  //   notifyListeners();
  // }









  // List<ChartData> ecgGraphList=[];

  List<double> ecgGraphDataList=[0.0];
  List get getEcgGraphList=>ecgGraphDataList;

    updateEcgGraphList(int count,List val){
      for(int i=0;i<val.length; i++){
        try {
          ecgGraphDataList.add(double.parse(val[i].toString()));
            // ecgGraphList.add(ChartData(
            //     count, double.parse(val[i].toString() )));

        }
        catch (e){

        }
      }
    notifyListeners();
  }





  String deviceAddress='';
    String get getDevicesAddress=> deviceAddress;
    set updateDeviceAddress(String val){
      deviceAddress=val;
      notifyListeners();
    }


    String spo2Percentage='00';
    String get getSpo2Percentage=>spo2Percentage;
    int get getSpo2Stepper=>getSpo2Percentage==''? 00:(int.parse(getSpo2Percentage.toString())/10).round();
    set updateSpo2Percentage(String val){
      spo2Percentage=val;
      notifyListeners();
    }

    String ECGPercentage='00';
    String get getECGPercentage=>ECGPercentage;
  int get getEcgStepper=>getECGPercentage==''? 0:(int.parse(getECGPercentage.toString())/10).round();
    set updateECGPercentage(String val){
      ECGPercentage=val;
      notifyListeners();
    }




    List yAxisList=[
      {'val':'50'},
      {'val':'100'},
      {'val':'150'},
      {'val':'200'},
      {'val':'250'},
      {'val':'300'},
      {'val':'350'},
      {'val':'400'},
      {'val':'450'},
      {'val':'500'},
      {'val':'600'},
      {'val':'700'},
      {'val':'800'},
      {'val':'900'},
      {'val':'1000'},
      {'val':'2000'},
      {'val':'3000'},
      {'val':'4000'},
      {'val':'5000'},
    ];


 List XAxisList=[
   {'val':'50'},
   {'val':'100'},
   {'val':'150'},
   {'val':'200'},
   {'val':'250'},
   {'val':'300'},
   {'val':'350'},
   {'val':'400'},
   {'val':'450'},
   {'val':'500'},
   {'val':'600'},
   {'val':'700'},
   {'val':'800'},
   {'val':'900'},
   {'val':'1000'},
   {'val':'2000'},
   {'val':'3000'},
   {'val':'4000'},
   {'val':'5000'},
    ];

    double selectedEcgYaxisValue=500;
  double get getSelectedEcgYaxisValue=>selectedEcgYaxisValue;
    set updateEcgYaxisValue(double val){
      selectedEcgYaxisValue=val;
      notifyListeners();
    }



    int selectedEcgXAxisValue=300;
  int get getSelectedEcgXAxisValue=>selectedEcgXAxisValue;
    set updateEcgXAxisValue(int val){
      selectedEcgXAxisValue=val;
      notifyListeners();
    }

    double selectedSpo2YaxisValue=250;
  double get getSelectedSpo2YaxisValue=>selectedSpo2YaxisValue;
    set updateSpo2YaxisValue(double val){
      selectedSpo2YaxisValue=val;
      notifyListeners();
    }


    int selectedSpo2XAxisValue=300;
  int get getSelectedSpo2XAxisValue=>selectedSpo2XAxisValue;
    set updateSpo2XAxisValue(int val){
      selectedSpo2XAxisValue=val;
      notifyListeners();
    }



  double prData=0.0;
    double get getPRData=>prData;
    set updatePRData(List val){
      for(int i=0;i<val.length;i++){
        try{
        if (val[i].toString() != '' || val[i].toString() != ' ') {
          prData = double.parse(val[i].toString());
        }
      }
      catch(e){

      }
    }
      notifyListeners();
    }


  double sysData=0.0;
  double dysData=0.0;
    double tempData=0.0;
  double get getSysData=>sysData;
  double get getDysData=>dysData;
  double get getTempData=>tempData;

  set updateSysList(List val){
    for(int i=0;i<val.length;i++){
      try{
        if (val[i].toString() != '' || val[i].toString() != ' ') {
      sysData= double.parse(val[i].toString());
    }}
      catch(e){

      }
    notifyListeners();
  }}


  set updateDysList(List val){
    for(int i=0;i<val.length;i++){
      try{
        if (val[i].toString() != '' || val[i].toString() != ' ') {
          dysData = double.parse(val[i].toString());
        }}
      catch(e){

      }
    }
    notifyListeners();
  }


  set updateTempList(List val){
    for(int i=0;i<val.length;i++){
      try{
        if (val[i].toString() != '' || val[i].toString() != ' ') {
          tempData = double.parse(val[i].toString());
        }
      }
      catch(e){

      }
    }
    notifyListeners();
  }



  saveDeviceVital(context,{spo2,pr,sys,dys,temp,hr}) async {
    print('----------'+sys.toString());



    AddVitalsModel vitalModal=AddVitalsModel();


    await vitalModal.medvantageAddVitals(context,SPO2: spo2.toString(),
      Pulse: pr.toString(),
      BPDias: dys.toString() ,
      BPSys: sys.toString(),
      Temperature: temp.toString(),
      HeartRate: hr.toString(),);



  }



  String newSpo2Value='';
  String get getNewSpo2Value=>newSpo2Value;
  set updateNewSpo2Value(String val){
    newSpo2Value=val;
    notifyListeners();
  }

  String newEcgValue='';
  String get getNewEcgValue=>newEcgValue;
  set updateNewEcgValue(String val){
    newEcgValue=val;
    notifyListeners();
  }
  String newPRValue='';
  String get getNewPRValue=>newPRValue;
  set updateNewPRValue(String val){
    newPRValue=val;
    notifyListeners();
  }

  String newTempValue='';
  String get getNewTempValue=>newTempValue;
  set updateNewTempValue(String val){
    newTempValue=val;
    notifyListeners();
  }

}
