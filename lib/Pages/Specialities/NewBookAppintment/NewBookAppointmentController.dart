
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import 'data_modal/data_modal.dart';

class NewBookAppointmentController extends GetxController{
  Rx<TextEditingController> nameController = TextEditingController().obs;
  Rx<TextEditingController> uhidController = TextEditingController().obs;
  Rx<TextEditingController> appointment = TextEditingController().obs;


  List<Map<String, dynamic>> problemAndOrganId = [];
  get getProblemAndOrganData=> problemAndOrganId;
  set updatePrblmOrgn(val){
    problemAndOrganId=val;
    update();
  }



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

  List<DayDataModal> dayList=[];
  List<DayDataModal> get getDayList=>dayList;
 set updateDayList(List<DayDataModal> val){
   dayList=val;
   update();
 }

 List<TimeSlotDataModal> timeList=[];
  List<TimeSlotDataModal> get  getTimeList=>timeList;
 set updateTimeList(List<TimeSlotDataModal>  val){
   timeList=val;
   update();
 }


  List availableDays =[];
  get getAvailableDays =>availableDays;
  set updateAvailableDays(val){
    availableDays= val;
    update();
  }

  bool loadingDays=false;
  get getLoadingDys=>true;
  set updateDaysLoading(val){
    loadingDays=val;
    update();
  }

  bool loadingTime=false;
  get getLoadingTime=>loadingTime;
  set updateLoadingTime(val){
    loadingTime=val;
    update();
  }

  bool bookAppointmentLoader=false;
  get getBookAppointmentLoader=>bookAppointmentLoader;
  set updateBookAppointment(val){
    bookAppointmentLoader=val;
    update();
  }


}