
import 'package:digi_doctor/AppManager/alert_dialogue.dart';
import 'package:digi_doctor/Pages/VitalPage/LiveVital/stetho_master/AppManager/raw_api.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get_storage/get_storage.dart';
import '../../../AppManager/app_color.dart';
import '../../../AppManager/app_util.dart';
import '../../StartUpScreen/startup_screen.dart';
import 'NewBookAppointmentController.dart';
import 'data_modal/data_modal.dart';

class NewBookAppointmentModal {


  NewBookAppointmentController controller = Get.put(NewBookAppointmentController());


  bookAppointment(context,{doctorId,departmentId,timeSlotsId,appointmentDate,dayId })async{
    // var body={
    //   // "uhid": controller.uhidController.value.text.toString(),
    //   "uhid": "UHID00135",
    //   "doctorId": controller.getDoctorId,
    //   "departmentId": '1',
    //   "timeslotsId": '1',
    //   "appointmentDate": controller.getTime.toString(),
    //   "userId": '99'
    // };
    final medvantageUser = GetStorage();
    var name = medvantageUser.read('medvantageUserName');
    var uhid = medvantageUser.read('medvantageUserUHID');
    var body=
    // {
    //   "uhid": uhid,
    //   "doctorId": int.parse(doctorId.toString()),
    //   "departmentId": int.parse(departmentId.toString()),
    //   "timeslotsId": int.parse(timeSlotsId.toString()),
    //   "appointmentDate": appointmentDate,
    //   "userId": 99,
    //   "dayId": int.parse(dayId.toString()),
    // };
    {
      "uhid": uhid.toString(),
      "doctorId": int.parse(doctorId.toString()),
      "dayId": int.parse(dayId.toString()),
      "departmentId": int.parse(departmentId.toString()),
      "timeslotsId": int.parse(timeSlotsId.toString()),
      "appointmentDate": appointmentDate.toString(),
      "userId": 99,
      "clientId": 0
    };
    var data = await RawDataApi().api('/api/BookAppointmentMaster/InsertBookAppointmentMaster',body,context);
    print(body.toString());
    print('${data}12345');
    if(data['status']==1){
      if(data["message"].toString().toLowerCase()=="success"){
        final snackBar = SnackBar(
          backgroundColor: AppColor.green,
          content:  const Text("Appointment booked"),
          action: SnackBarAction(
            textColor: Colors.white,
            label: 'Ok',
            onPressed: () {

            },
          ),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        // alertToast(context, "Appointment booked");
      }else{
        alertToast(context, data["message"]);
      }
      App().replaceNavigate(context, const StartupPage());
      print("dkchuyksfgckl");
    }

    else{

      final snackBar = SnackBar(
        backgroundColor: AppColor.green,
        content:   Text(data["responseValue"]),
        action: SnackBarAction(
          textColor: Colors.white,
          label: 'Ok',
          onPressed: () {

          },
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
     // alertToast(context, data["responseValue"]);
      print("dkchuyksfgckl");
    }

  }


  Future <void> getTimeSlots(context,{required String dayId,required String drId})async{
    var data = await RawDataApi().getapi('/api/DoctorTimeSlotMapping/GetDoctorTimeSlot?dayId=$dayId&doctorId=$drId',context);
    if (kDebugMode) {
      print(data.toString()+'');
    }

    print("ALIIIiii2222"+data.toString());
    controller.updateTimeList=List<TimeSlotDataModal>.from((data['responseValue'] as List).map((e) => TimeSlotDataModal.fromJson(e)));
   // controller.timeList=data['responseValue'] as List<TimeSlotDataModal>;
    if(data['responseValue'].toString()=='[]'){
      controller.updateTimeList=[];
    }
    print("ALIIIiii2222"+controller.timeList.toString());
    controller.getTimeList[0];
    if (kDebugMode) {
      print('abc${controller.getTimeList}abcdefg');
    }
  }




  Future <void> getDays(context,drId)async{
    var data = await RawDataApi().getapi('/api/DoctorTimeSlotMapping/GetAllDaysByDoctorId?doctorId=$drId',context);
    if (kDebugMode) {
      print(data.toString()+'0000000000');
    }

    // List<DayDataModal>
   // controller.updateDayList=data['responseValue'] as List;
    controller.updateDayList=List<DayDataModal>.from((data['responseValue'] as List).map((e) => DayDataModal.fromJson(e)));
    print('abc${controller.getDayList}');
    for(int i =0;i<controller.getDayList.length;i++){
      controller.availableDays.add(controller.getDayList[i].dayName);
      controller.update();
      print(controller.getAvailableDays.toString()+'abcd');
    }
  }

   getTime(BuildContext context,{required String dayName,required String drId}) {
    print("DayLIstLength"+controller.getDayList.length.toString());
    print("DayLIstLength"+dayName.toString());
    for(int i=0;i<controller.getDayList.length;i++){
      if(controller.getDayList[i].dayName.toString().toUpperCase().trim()==dayName.toUpperCase().toString().trim()){
           getTimeSlots(context, dayId: controller.getDayList[i].dayId.toString(), drId: drId);
      }else{
        controller.updateTimeList=List<TimeSlotDataModal>.from(([]).map((e) => TimeSlotDataModal.fromJson(e)));
      }
     // if(dayName.toString().toLowerCase()==controller.getDayList[i-1].dayName.toString().toLowerCase()){
     //   getTimeSlots(context, dayId: controller.getDayList[i-1].dayId.toString(), drId: drId);
     // }
    }



  }
}