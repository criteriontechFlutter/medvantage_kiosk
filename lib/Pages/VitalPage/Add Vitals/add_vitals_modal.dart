import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import '../../../AppManager/app_color.dart';
import '../../../AppManager/app_util.dart';
import '../../../AppManager/progress_dialogue.dart';
import '../../../Localization/app_localization.dart';
import 'package:digi_doctor/AppManager/alert_dialogue.dart';
import 'package:digi_doctor/AppManager/raw_api.dart';
import 'package:digi_doctor/AppManager/user_data.dart';
import 'package:digi_doctor/Pages/VitalPage/Add%20Vitals/add_vitals_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../Specialities/SpecialistDoctors/TimeSlot/AppointmentBookedDetails/appointment_booked_controller.dart';
import '../../StartUpScreen/startup_screen.dart';

class AddVitalsModel {
  AddVitalsController controller = Get.put(AddVitalsController());
  AppointmentBookedController appointmentBookedController = Get.put(AppointmentBookedController());

  UserData user = UserData();


    onPressedSubmit(context,) async {
      ApplicationLocalizations localization=Provider.of<ApplicationLocalizations>(context,listen: false);

      bool noData = false;


    if ((controller.systolicC.value.text == '' &&
        controller.diastolicC.value.text == '')||(controller.weightC.value.text!=""&&controller.heightC.value.text!="")) {
      for (int i = 0; i < controller.vitalTextX.length; i++) {
        print('---------'+controller.vitalTextX[i].value.text.toString());
        if ((controller.vitalTextX[i].value.text != '')||(controller.weightC.value.text!=""&&controller.heightC.value.text!="")) {
          noData = true;
        }
      }
    } else {
      noData = true;
    }
    if (noData == true) {
      onPressedConfirm() async {
        Navigator.pop(context);
        await getVitalsList(context);
      }
      AlertDialogue().actionBottomSheet(subTitle: localization.getLocaleData.youWantToAddVital.toString(),
          okButtonName: localization.getLocaleData.yes.toString(),cancelButtonName: localization.getLocaleData.no.toString(),
          okPressEvent:(){
            onPressedConfirm();
          });

    } else {
      alertToast(context, localization.getLocaleData.addAtLeastOneVital.toString(),);
    }
  }
  onPressedClear(context){
    for(int i=0;i<controller.vitalTextX.length;i++){
      controller.vitalTextX.clear();
    }
  }

    getVitalsList(context,{isHelix=false}) async {
      ApplicationLocalizations localization=Provider.of<ApplicationLocalizations>(context,listen: false);

      List dtDataTable = [];
    for (int i = 0; i < controller.getVitalsList(context).length; i++) {
      dtDataTable.add({
        'vitalId': controller.getVitalsList(context)[i]['id'].toString(),
        'vitalValue': controller.vitalTextX[i].value.text,
      });
    }
    dtDataTable.add({
      'vitalId': 4.toString(),
      'vitalValue': controller.systolicC.value.text,
    });

    dtDataTable.add({
      'vitalId': 6.toString(),
      'vitalValue': controller.diastolicC.value.text,
    }
    );
    dtDataTable.add({
      'vitalId ': 1.toString(),
      'height': controller.heightC.value.text,
    }
    );dtDataTable.add({
      'vitalId': 2.toString(),
      'weight ': controller.weightC.value.text,
    }
    );

    var body = {
      "memberId": UserData().getUserMemberId,
      'dtDataTable': jsonEncode(dtDataTable),
      "date": DateFormat("yyyy-MM-dd").format(DateTime.now()).toString(),
      "time": DateFormat("HH:mm:ss").format(DateTime.now()).toString(),
    };

    var data = await RawData().api(
      "Patient/addVital",
      body,
      context,
    );

    if (data['responseCode'] == 1) {

      if(!isHelix){
        alertToast(context,
            localization.getLocaleData.vitalsSaveSuccessfully.toString());
        Navigator.pop(context);
      }
      appointmentBookedController.updateIsVitalSend = true;

    } else {
      if(!isHelix){
      alertToast(context, data['responseMessage'].toString());}
    }

    return data;
  }






  saveDeviceVital(context,{spo2,pr,sys,dia}) async {
print('----------'+sys.toString());

    ApplicationLocalizations localization=Provider.of<ApplicationLocalizations>(context,listen: false);

    AlertDialogue().show(context,
        msg: localization.getLocaleData.youWantToAddVital.toString(),
        firstButtonName: localization.getLocaleData.confirm.toString(),
        showOkButton: false, firstButtonPressEvent: () async {


          List dtDataTable = [];
      if(spo2!=null){
          dtDataTable.add({
            'vitalId': 56.toString(),
            'vitalValue': spo2.toString(),
          });}
    if(pr!=null){
          dtDataTable.add({
            'vitalId': 3.toString(),
            'vitalValue':pr.toString(),
          });}

    if(sys!=null){
          dtDataTable.add({
            'vitalId': 4.toString(),
            'vitalValue':sys.toString(),
          });}

    if(dia!=null){
          dtDataTable.add({
            'vitalId': 6.toString(),
            'vitalValue':dia.toString(),
          });}



          ProgressDialogue().show(context, loadingText: localization.getLocaleData.savingVitals.toString());
          var body = {
            "memberId": UserData().getUserMemberId,
            'dtDataTable': jsonEncode(dtDataTable),
            "date": DateFormat("yyyy-MM-dd").format(DateTime.now()).toString(),
            "time": DateFormat("HH:mm:ss").format(DateTime.now()).toString(),
          };

          var data = await RawData().api(
            "Patient/addVital",
            body,
            context,
          );


          ProgressDialogue().hide();
          if (data['responseCode'] == 1) {

              alertToast(context,
                  localization.getLocaleData.vitalsSaveSuccessfully.toString());
              Navigator.pop(context);
            }  else {

              alertToast(context, data['responseMessage'].toString());}


        }, showCancelButton: true);

  }


  medvantageAddVitals(context,{
    String BPSys='0',
    String BPDias='0',
    String RespiratoryRate='0',
    String SPO2='0',
    String Pulse='0',
    String Temperature='0',
    String HeartRate='0',
    String BMI='0',
    String BMR='0',
    String weight='0',
    String height='0',
    String Rbs='0',
  })  async {
    final medvantageUser = GetStorage();
    // var name = medvantageUser.read('medvantageUserName');
    var uhid = medvantageUser.read('medvantageUserUHID');

    // /api/PatientVital/InsertPatientVital

    var headers = {
      'Content-Type': 'application/json; charset=utf-8'
    };
    var request = http.Request('POST', Uri.parse('https://demo.medvantage.tech:7082/api/PatientVital/InsertPatientVital'));
    DateTime now = DateTime.now();
    DateTime parsedDate = DateTime.parse(now.toString());
    String formattedDate = DateFormat('MMM dd, yyyy HH:mm:ss').format(parsedDate);

    request.body =   json.encode({
        "pmId": 0,
        "userId": 99,
        "vmValueBPSys": BPSys.toString(),
        "vmValueBPDias": BPDias.toString(),
        "vmValueRespiratoryRate": RespiratoryRate.toString(),
        "vmValueSPO2": SPO2.toString(),
        "vmValuePulse": Pulse.toString(),
        "vmValueTemperature": Temperature.toString(),
        "vmValueHeartRate": HeartRate.toString(),
        "vmValueBMI": BMI.toString(),
        "vmValueBMR": BMR.toString(),
        "weight": weight.toString(),
        "height": height.toString(),
        "vmValueRbs": Rbs.toString(),
        "vitalDate": formattedDate,
        "uhid": uhid.toString(),
        "clientId": 176
      });

    print(request.body.toString());
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    var data = await response.stream.bytesToString();
    print(data);
    Map<String, dynamic> responseData = jsonDecode(data);
    print(responseData["responseValue"].toString()+'added');
    print(responseData["message"].toString()=="success");
    if(responseData["message"].toString()=="success"){
      App().replaceNavigate(context, const StartupPage());
    }
    final snackBar = SnackBar(
      duration: const Duration(seconds: 10),
      backgroundColor:response.statusCode == 200?
      AppColor.green: AppColor.secondaryColor,
      content:  Text(response.statusCode == 200?
      "Added"
          :responseData["responseValue"].toString()),
      action: SnackBarAction(
        textColor: Colors.white,
        label: 'Ok',
        onPressed: () {

        },
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);



  }
}


