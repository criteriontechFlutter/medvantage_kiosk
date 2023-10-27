import 'package:digi_doctor/Pages/VitalPage/LiveVital/stetho_master/details/patient_details_datamodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class PatientController extends GetxController{
  TextEditingController nameC = TextEditingController();
  TextEditingController ageC = TextEditingController();
  TextEditingController hotSpotNameC = TextEditingController();
  TextEditingController pidField=TextEditingController();
  TextEditingController passwordC = TextEditingController();
  TextEditingController linkC = TextEditingController();
  TextEditingController deviceKey=TextEditingController();


   Map detailsMap =  {};

   String deviceKeyData="";


   String get getDeviceKeyString=>deviceKeyData;

   set updateDeviceKeyData(String val){
     deviceKeyData=val;
     update();
   }

  PatientDetailsDataModel get getpatientDetails=>PatientDetailsDataModel.fromJson(detailsMap);


  set updatPatientDetails( Map val){
    detailsMap =val;
    update();
  }








}