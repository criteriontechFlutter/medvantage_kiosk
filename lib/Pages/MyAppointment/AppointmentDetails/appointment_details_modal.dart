import 'dart:convert';
import 'dart:developer';
import 'package:flutter/foundation.dart';

import '../../../Localization/app_localization.dart';
import 'package:digi_doctor/Pages/prescription_history/prescription_details/prescription_details_view.dart';
import 'package:flutter/material.dart';

import 'package:digi_doctor/AppManager/app_util.dart';
import 'package:digi_doctor/AppManager/progress_dialogue.dart';
import 'package:digi_doctor/Pages/MyAppointment/AppointmentDetails/appointment_details_controller.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../../AppManager/alert_dialogue.dart';
import '../../../AppManager/raw_api.dart';
import '../../../AppManager/user_data.dart';
import '../../Dashboard/dashboard_controller.dart';
import '../../prescription_history/prescription_details/prescription_details_controller.dart';
import '../my_appointment_modal.dart';


class AppointmentDetailsModal {
  AppointmentDetailsController controller =
      Get.put(AppointmentDetailsController());
  PrescriptionDetailsController prescriptionController =
      Get.put(PrescriptionDetailsController());
 // DashboardController dashboardController = Get.find();
  RawData rawData = RawData();
  MyAppointmentModal appointHistoryModal = MyAppointmentModal();

  Future<void> onPressedSubmit(context) async {
    ApplicationLocalizations localization=Provider.of<ApplicationLocalizations>(context,listen: false);
    if (controller.ratingData.value != 0) {
      onPressedConfirm() async {
        Navigator.pop(context);
        Navigator.pop(context);
        await writeReview(context);
      }

      AlertDialogue().show(context,
          msg: localization.getLocaleData.sureWantSubmitReview.toString(),
          firstButtonName: localization.getLocaleData.confirm.toString(),
          showOkButton: false, firstButtonPressEvent: () {
        onPressedConfirm();
      }, showCancelButton: true);
    } else {
      alertToast(context, localization.getLocaleData.pleaseSelectRatingStar.toString());
    }
  }

  Future<void> onPressedViewPrescription(context) async {
    await getPrescriptionHistory(context);
  }

  Future<void> onPressedCancel(context) async {
    ApplicationLocalizations localization=Provider.of<ApplicationLocalizations>(context,listen: false);
    AlertDialogue().actionBottomSheet(subTitle: localization.getLocaleData.sureWantCancelAppointment.toString(),
        okButtonName:localization.getLocaleData.confirm.toString(),
        cancelButtonName: localization.getLocaleData.alertToast!.cancel.toString(),
        title: localization.getLocaleData.cancelAppointment.toString(),
        okPressEvent:()async{
          Get.back();
          await cancelAppointment(context);
        });
  }

  Future<void> appointmentDetails(context) async {
    controller.updateShowNoData = false;
    var body = {
      "appointmentId": controller.selectedAppointmentId.value,
    };
    var data = await rawData.api('Patient/appointmentDetails', body, context);
    if (kDebugMode) {
      log('-------nnnnn$data');
    }
    controller.updateShowNoData = true;
    if (data['responseCode'] == 1) {
      controller.updateAppointmentDetailsList = data['responseValue'];
    }
  }

  Future<void> saveAttachmentAfterBooking(context, dtDataTable) async {
    var body = {
      "appointmentId": controller.selectedAppointmentId.value.toString(),
      "dtDataTable": dtDataTable.toString(),
    };
    var data = await rawData
        .api('Patient/saveAttachmentAfterBooking', body, context, token: true);
    if (data['responseCode'] == 1) {
      Navigator.pop(context);
      Navigator.pop(context);
      await appointmentDetails(context);
    }
  }

  Future<void> saveMultipleFile(context) async {
    ApplicationLocalizations localization=Provider.of<ApplicationLocalizations>(context,listen: false);

    ProgressDialogue().show(context, loadingText: localization.getLocaleData.loadingData.toString());
    List docList = [];
    for (int i = 0; i < controller.getAddDocumentList.length; i++) {
      docList.add({
        'filePath': controller.getAddDocumentList[i]['docFile'].toString(),
      });
    }

    Map<String, String> body = {};
    var data = await MultiPart().multiyFileApi(
        'Doctor/saveMultipleFile', body, context,
        docList: docList);

    if (jsonDecode(data['data'])['responseCode'] == 1) {
      await saveAttachmentAfterBooking(
          context, jsonDecode(data['data'])['responseValue'].toString());
    }
    ProgressDialogue().hide();
  }

  Future<void> writeReview(context) async {
    ApplicationLocalizations localization=Provider.of<ApplicationLocalizations>(context,listen: false);
    ProgressDialogue().show(context, loadingText: localization.getLocaleData.submittingReview.toString());
    var body = {
      "serviceProviderDetailsId": controller.selectedDrIdC.value.text,
      "starRating": controller.ratingData.value.toString(),
      "memberId": user.getUserMemberId.toString(),
      "review": controller.reviewC.value.text.toString()
    };
    var data =
        await rawData.api('Patient/writeReview', body, context, token: true);
    ProgressDialogue().hide();
    if (data['responseCode'] == 1) {
      await appointmentDetails(context);
      alertToast(context, data['responseMessage']);
    } else {
      alertToast(context, data['responseMessage']);
    }
  }

  Future<void> getPrescriptionHistory(context) async {
    ApplicationLocalizations localization=Provider.of<ApplicationLocalizations>(context,listen: false);

    ProgressDialogue().show(context, loadingText: localization.getLocaleData.loadingData.toString());
    var body = {
      "memberId": UserData().getUserMemberId.toString(),
      "appointmentId": controller.selectedAppointmentId.value.toString(),
    };
    var data = await RawData()
        .api('Patient/getPatientMedicationDetails', body, context, token: true);
    ProgressDialogue().hide();
    if (data['responseCode'] == 1) {
      controller.updatePrescriptionList = data['responseValue'];

      App().navigate(
          context,
          PrescriptionDetails(
              prescriptionDetail: controller.getPrescriptionList[0]));
    }
  }

  Future<void> cancelAppointment(context) async {
    ProgressDialogue().show(context, loadingText: "Cancelling appointment");
    var body = {
      "appointmentId": controller.selectedAppointmentId.value.toString(),
    };
    var data = await rawData.api('Patient/cancelAppointment', body, context);
    if (data['responseCode'] == 1) {
      DashboardController().removeUpcomingAppointment(controller.selectedAppointmentId.value);
      //Get.off(const MyAppointmentView());
      await appointHistoryModal.getPatientAppointmentList(context);
      ProgressDialogue().hide();
      Navigator.pop(context);
    }
    else{
      ProgressDialogue().hide();
    }
  }

}
