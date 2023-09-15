import 'dart:async';
import 'dart:convert';
import '../../../Localization/app_localization.dart';
import 'package:digi_doctor/AppManager/progress_dialogue.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../../AppManager/alert_dialogue.dart';
import '../../../AppManager/app_util.dart';
import '../../../AppManager/raw_api.dart';
import '../../../AppManager/user_data.dart';
import '../prescription_history_view.dart';
import 'add_prescription_controller.dart';
import 'package:flutter/material.dart';


class AddPrescriptionModal {
  AddPrescriptionController controller = Get.put(AddPrescriptionController());
  MultiPart multiPart = MultiPart();

  Future<void> clearMedicineFiled() async {
    controller.medicineC.value.clear();
    controller.frequencyC.value.clear();
    controller.durationController.value.clear();
    controller.update();
  }

  Future<void> onPressedRequest(context) async {
    ApplicationLocalizations localization=Provider.of<ApplicationLocalizations>(context,listen: false);

    // if (controller.formKey.value.currentState!.validate()) {
    AlertDialogue().show(context,
        msg: localization.getLocaleData.areYouSureWantSubmit.toString(),
        firstButtonName: localization.getLocaleData.confirm.toString(),
        showOkButton: false, firstButtonPressEvent: () async {
      Navigator.pop(context);
      Navigator.pop(context);
      await addPrescription(context);
    }, showCancelButton: true);
  }

  Future<void> getDiagnosis(context) async {
    var body = {
      "alphabet": "",
    };
    var data = await RawData()
        .api('Patient/getAllProblems', body, context, token: true);

    if (data['responseCode'] == 1) {
      controller.updateDiagnosisList = data['responseValue'];
    }
  }

  Future<void> onPressedAddMedicine(context) async {
    ApplicationLocalizations localization=Provider.of<ApplicationLocalizations>(context,listen: false);
    bool isExist = false;
    if (controller.medicineC.value.text != '') {
      if (controller.frequencyC.value.text != '') {
        if (controller.durationController.value.text.toString() != '') {
          if (controller.medicineDataList.isNotEmpty) {
            for (int i = 0; i < controller.medicineDataList.length; i++) {
              if (controller.medicineDataList[i]['medicineName']
                  .contains(controller.medicineC.value.text)) {
                isExist = true;
              }
            }
            if (isExist == false) {
              controller.medicineDataList.add({
                'dosageFormId': controller.dosageFormId.toString(),
                'medicineName': controller.medicineC.value.text,
                'medicineId': controller.medicineNameId.toString(),
                'strength': controller.strength.toString(),
                'frequency': controller.frequencyC.value.text,
                'frequencyId': controller.frequencyId.toString(),
                'doseUnitId': controller.doseUnitId.toString(),
                "durationInDays": controller.durationController.value.text,
              });
              controller.update();
            } else {
              alertToast(context, localization.getLocaleData.alertToast!.medicineAlreadyAdded.toString());
            }
            clearMedicineFiled();
          } else {
            controller.medicineDataList.add({
              'dosageFormId': controller.dosageFormId.toString(),
              'medicineName': controller.medicineC.value.text,
              'medicineId': controller.medicineNameId.toString(),
              'strength': controller.strength.toString(),
              'frequency': controller.frequencyC.value.text,
              'frequencyId': controller.frequencyId.toString(),
              'doseUnitId': controller.doseUnitId.toString(),
              "durationInDays": controller.durationController.value.text,
            });
            controller.update();

            await clearMedicineFiled();
          }
          print('mmmmmmmmmmmmmylist' + controller.medicineDataList.toString());
        } else {
          alertToast(context, localization.getLocaleData.alertToast!.pleaseAddMedicineDays.toString());
        }
      } else {
        alertToast(context, localization.getLocaleData.alertToast!.pleaseAddMedicineFrequency.toString());
      }
    } else {
      alertToast(context, localization.getLocaleData.alertToast!.pleaseAddMedicineName.toString());
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
    return data;
  }

  Future<void> addPrescription(context) async {
    ApplicationLocalizations localization=Provider.of<ApplicationLocalizations>(context,listen: false);
    ProgressDialogue().show(context, loadingText: localization.getLocaleData.submittingData.toString());
    var imgFile = controller.getPrescriptionPhotoPath.toString() == ''
        ? ''
        : await getMultipartPath(context);

    List dtTableList = [];
    for (int i = 0; i < controller.medicineDataList.length; i++) {
      dtTableList.add({
        'dosageFormId': controller.medicineDataList[i]['dosageFormId'],
        'medicineName': controller.medicineDataList[i]['medicineName'],
        'medicineId': controller.medicineDataList[i]['medicineId'],
        'strength': controller.medicineDataList[i]['strength'],
        'frequencyId': controller.medicineDataList[i]['frequencyId'],
        'doseUnitId': controller.medicineDataList[i]['doseUnitId'],
        'durationInDays': controller.medicineDataList[i]['durationInDays'],
      });
    }

    if (controller.getProblemName.toString() != '') {
      if (dtTableList.isNotEmpty || controller.getPrescriptionPhotoPath != '') {
        print('dfkjdkjf' + controller.dateController.value.text.toString());
        ProgressDialogue().show(context, loadingText: '');
        var body = {
          "memberId": UserData().getUserMemberId.toString(),
          "problemId": controller.getDiagnosisId.toString(),
          "problemName": controller.getProblemName.toString(),
          "serviceProviderDetailsId": "0",
          "serviceProviderName":
              controller.doctorNameController.value.text.toString(),
          "startDate": DateFormat('yyyy-MM-dd').format(DateFormat('yyyy-MM-dd')
              .parse(controller.dateController.value.text.toString())),
          "filePath": jsonEncode(imgFile).toString(),
          "dtDataTable": jsonEncode(dtTableList),
        };
        dtTableList.isNotEmpty
            ? body.remove('filePath')
            : body.remove('dtDataTable');
        print("this is body" + body.toString());
        var data = await RawData()
            .api('Patient/patientMedication', body, context, token: true);
        ProgressDialogue().hide();
        if (data['responseCode'] == 1) {
          Navigator.pop(context);
          App().replaceNavigate(context, const PrescriptionHistory());
          alertToast(context, localization.getLocaleData.alertToast!.formSubmittedSuccessfully.toString());
        }
      } else {
        alertToast(context, localization.getLocaleData.alertToast!.pleaseFillMedicineDetails.toString());
      }
    } else {
      alertToast(context, localization.getLocaleData.alertToast!.pleaseEnterDoctorDiagnosis.toString());
    }
    ProgressDialogue().hide();
  }

  Future<void> getMedicineName(context) async {
    var body = {
      'alphabet': controller.medicineC.value.text.toString(),
      "userMobileNo": UserData().getUserMobileNo.toString(),
    };
    var data = await RawData()
        .api('Doctor/getAllMedicine', body, context, token: true);

    if (data['responseCode'] == 1) {
      controller.updateSearchedMedicine = data['responseValue'];
    }
  }

  Future<void> getFrequency(context) async {
    var body = {
      "alphabet": controller.frequencyC.value.text.toString(),
      "userMobileNo": UserData().getUserMobileNo,
    };
    var data = await RawData()
        .api('Doctor/getAllFrequency', body, context, token: true);

    if (data['responseCode'] == 1) {
      controller.updateFrequencyList = data['responseValue'];
    } else {
      alertToast(context, data['responseMessage']);
    }
  }
}
