
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class NewBookAppointmentController extends GetxController{
  Rx<TextEditingController> nameController = TextEditingController().obs;
  Rx<TextEditingController> uhidController = TextEditingController().obs;
  Rx<TextEditingController> appointment = TextEditingController().obs;

  String time='';
  get getTime=>time;
  set updateTime(val){
    time=val;
    update();
  }

  String department='';
  get getDepartment=>department;
  set updateDepartment(val){
    department=val;
    update();
  }
  int departmentId=0;
  get getDepartmentId=>departmentId;
  set updateDepartmentId(val){
    departmentId=val;
    update();
  }
  int doctorId=0;
  get getDoctorId=>doctorId;
  set updateDoctorId(val){
    doctorId=val;
    update();
  }

  List dayList=[];
 get getDayList=>dayList;
 set updateDayList(val){
   dayList=val;
   update();
 }

 List timeList=[];
 get getTimeList=>timeList;
 set updateTimeList(val){
   timeList=val;
   update();
 }



}