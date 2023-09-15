import 'dart:convert';
import 'dart:developer';

import '../../../Localization/app_localization.dart';
import 'package:digi_doctor/AppManager/user_data.dart';
import 'package:digi_doctor/Pages/prescription_history/prescripton_history_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../AppManager/raw_api.dart';
import '../../AppManager/alert_dialogue.dart';
import '../../AppManager/app_util.dart';
import '../../AppManager/progress_dialogue.dart';
import '../MyAppointment/AppointmentDetails/appointment_details_controller.dart';

class PrescriptionHistoryModal {
  PrescriptionHistoryController controller = Get.put(PrescriptionHistoryController());
  MultiPart multiPart = MultiPart();

  Future<void> getPrescriptionHistory(context, int? appointmentId) async {
    controller.updateShowNoData = false;
    var body = {
      "memberId": UserData().getUserMemberId.toString(),
      "appointmentId": appointmentId.toString()
    };
    var data = await RawData()
        .api('Patient/getPatientMedicationDetails', body, context, token: true);
    controller.updateShowNoData = true;
    log('-----------'+data.toString());
    if (data['responseCode'] == 1) {
      controller.updatePrescriptionHistoryList = data['responseValue'];
    }
  }


  getMultipartPath(context) async {
    Map<String, String> body = {};
    var data = await multiPart.api('Doctor/saveMultipleFile', body, context,
        imagePathName: 'files',
        imagePath: controller.getPrescriptionPhotoPath!.toString());

    print('#######' + data.toString());
    if (jsonDecode(data['data'])['responseCode'] == 1) {
      data = jsonDecode(jsonDecode(data['data'])['responseValue']);
    }
    return data[0]['filePath'];

  }


  Future<void>  addPrescription(context) async {
    ApplicationLocalizations localization=Provider.of<ApplicationLocalizations>(context,listen: false);
    ProgressDialogue().show(context, loadingText: localization.getLocaleData.submittingData.toString());
    var imgFile =controller.getPrescriptionPhotoPath.toString()=='' ? '':await getMultipartPath(context);
    log('mmmmmmmmmyfillllllllllllle' + imgFile.toString());
    //
    // List dtTableList = [];
    // for (int i = 0; i < controller.medicineDataList.length; i++) {
    //   dtTableList.add({
    //     'dosageFormId': controller.medicineDataList[i]['dosageFormId'],
    //     'medicineName': controller.medicineDataList[i]['medicineName'],
    //     'medicineId': controller.medicineDataList[i]['medicineId'],
    //     'strength': controller.medicineDataList[i]['strength'],
    //     'frequencyId': controller.medicineDataList[i]['frequencyId'],
    //     'doseUnitId': controller.medicineDataList[i]['doseUnitId'],
    //     'durationInDays': controller.medicineDataList[i]['durationInDays'],
    //   });
    // }

        var body = {
          "memberId": UserData().getUserMemberId.toString(),
          "problemId": ''.toString(),
          "problemName": ''.toString(),
          "serviceProviderDetailsId": "0",
          "serviceProviderName":''.toString(),
          "startDate": DateFormat('yyyy-MM-dd').format(DateFormat('yyyy-MM-dd')
              .parse(controller.dateController.value.text.toString())),
          "filePath":imgFile.toString(),
        };
        print("this is body" + body.toString());
        var data =
        await RawData().api('Patient/patientMedication', body, context,token: true);

        if (data['responseCode'] == 1) {
          alertToast(context, localization.getLocaleData.dataSubmittedSuccessfully.toString());
         // await getPrescriptionHistory(context);
        }
    ProgressDialogue().hide();
  }



  Future<void> onPressedRequest(context) async {
    ApplicationLocalizations localization=Provider.of<ApplicationLocalizations>(context,listen: false);
    if ( controller.getPrescriptionPhotoPath != '') {
    AlertDialogue().show(context,
        msg: localization.getLocaleData.areYouSureWantSubmit.toString(),
        firstButtonName: localization.getLocaleData.confirm.toString(),
        showOkButton: false, firstButtonPressEvent: () async {
          Navigator.pop(context);
          Navigator.pop(context);
          await addPrescription(context);

        }, showCancelButton: true);
     }
    else {
      alertToast(context, localization.getLocaleData.pleaseAttachFile.toString());
    }
  }

}
