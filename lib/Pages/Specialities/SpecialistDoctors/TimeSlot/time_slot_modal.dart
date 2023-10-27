import 'dart:convert';
import 'dart:developer';

import '../../../../Localization/app_localization.dart';
import 'package:digi_doctor/AppManager/app_util.dart';
import 'package:digi_doctor/AppManager/progress_dialogue.dart';
import 'package:digi_doctor/Pages/Dashboard/dashboard_view.dart';
import 'package:digi_doctor/Pages/Specialities/SpecialistDoctors/TimeSlot/time_slot_controller.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import '../../../../AppManager/alert_dialogue.dart';
import '../../../../AppManager/raw_api.dart';
import '../../../../AppManager/user_data.dart';
import 'package:flutter/material.dart';

import '../../../MyAppointment/AppointmentDetails/appointment_details_controller.dart';
import '../../../StartUpScreen/startup_screen.dart';
import 'AppointmentBookedDetails/appointment_successful.dart';

class TimeSlotModal {
  TimeSlotController controller = Get.put(TimeSlotController());
  AppointmentDetailsController appointmentController =
  Get.put(AppointmentDetailsController());

  RawData rawData = RawData();
  UserData userData = UserData();


  String formater(DateTime date){
    return date.toString().split(' ')[0];
  }

  List<OptionDataModals> getOption(context){
    ApplicationLocalizations localization = Provider.of<
        ApplicationLocalizations>(context, listen: false);
    return [
      OptionDataModals(
        optionIcon  :"assets/kiosk_setting.png",
        optionText: "Appointment Detail",
        // route: TopSpecialitiesView(),
      ),
      // OptionDataModals(
      //   optionIcon: "assets/kiosk_symptoms.png",
      //   optionText:  localization.getLocaleData.hintText!.bySymptoms.toString(),
      //   // route:
      // )
    ];

  }

  onEnterPage(context) async {
    await getTimeSlots(context);
  }

  onPressedConfirm(context) async {
    ApplicationLocalizations localization=Provider.of<ApplicationLocalizations>(context,listen: false);
    onPressedConfirm() async {
      Navigator.pop(context);
      await onlineAppointment(context);
    }

    AlertDialogue().actionBottomSheet(subTitle: localization.getLocaleData.areYouSureBookAppointment.toString(),
        okButtonName:localization.getLocaleData.confirm.toString(),
        title: localization.getLocaleData.bookAppointment.toString(),
        cancelButtonName:localization.getLocaleData.alertToast!.cancel.toString() ,
        okPressEvent:(){
          onPressedConfirm();
        });
  }



  Future<void> getTimeSlots(context) async {
    controller.updateShowNoData = false;
    controller.slotTypeList = [];
    controller.selectedSlot = '';
    controller.updateSlotList = [];
    var body = {
      'appointDate': controller.getSelectedDate==null? '':formater(controller.getSelectedDate??DateTime.now()).toString(),
      'isEraUser': controller.iSEraDoctor.value.toString(),
      'serviceProviderDetailsId': controller.doctorId.value.toString(),
    };
    print(body.toString());
    // var data = await rawData
    //     .api('Patient/getOnlineAppointmentSlots', body, context, token: true);
    // controller.updateShowNoData = true;
    // if (data['responseCode'] == 1) {
    //   //   final uniqueJsonList = data['responseValue'][0]['slotBookedDetails']??
    //   //       []
    //   //       .toSet()
    //   //       .toList();
    //   //
    //   //   //print("------------"+uniqueJsonList.toString());
    //   //   var result = uniqueJsonList.map((item) => item['slotType'].toString()).toSet().toList();
    //   //
    //   // controller.updateSlotTypeList = result;
    //
    //   controller.updateSlotList = data['responseValue'].isEmpty? []:data['responseValue'];
    //   print("###########${controller.getSlotList.length}");
    // }
  }

  onPressedCfm(context) async {
    ApplicationLocalizations localization=Provider.of<ApplicationLocalizations>(context,listen: false);
    var payModeData;
    int mrp = (double.parse(controller.getTotalFee.toString())).toInt();
    if (mrp > 0) {
      ProgressDialogue().show(context, loadingText: localization.getLocaleData.loadingData.toString());
      var data = await checkTimeSlotAvailability(context);
      if (data['responseValue'] != null) {
        payModeData = await getPaymentMode(context);
      }
      ProgressDialogue().hide();
    } else {
      await onPressedConfirm(context);
    }
   // return payModeData;
    //await onPressedConfirm(context);
  }

  onPressedPayNow(context, _razorpay) async {
    ApplicationLocalizations localization=Provider.of<ApplicationLocalizations>(context,listen: false);

    Navigator.pop(context);
    var data = await checkTimeSlotAvailability(context);
    if (data['responseValue'] != null && controller.getSelectPayType) {
      await getTransactionNo(context, _razorpay);

      print(controller.getSelectPayType.toString());
    } else {
      alertToast(context, localization.getLocaleData.pleaseSelectPaymentType.toString());
    }
  }

  onPressedYes(context) async {
    var data = await checkTimeSlotAvailability(context);
    if (data['responseValue'] != null) {
      // Navigator.pop(context);
      await onlineAppointment(context);
    }
  }

  checkTimeSlotAvailability(context) async {
    var body = {
      "memberId": UserData().getUserMemberId.toString(),
      "serviceProviderDetailsId": controller.getMyAppoointmentData.appointmentId != 0
          ? controller.getMyAppoointmentData.doctorId.toString():
      controller.doctorId.toString(),
      "appointDate": controller.getSelectedDate==null? '':formater(controller.getSelectedDate??DateTime.now()).toString(),
      "appointTime": controller.saveTime.toString(),
      "userMobileNo": UserData().getUserMobileNo.toString(),
      "isEraUser": controller.getMyAppoointmentData.appointmentId != 0
          ? controller.getMyAppoointmentData.isEraUser.toString()
          : controller.iSEraDoctor.toString(),
      "appointmentId": controller.getMyAppoointmentData.appointmentId.toString(),
      "isRevisit": 'false'
    };
    var data = await rawData.api('Patient/checkTimeSlotAvailability', body, context);
    if (data['responseCode'] == 1) {
    } else {
      alertToast(context, data['responseMessage']);
    }
    return data;
  }

  getPaymentMode(context) async {
    var body = {'': ''};
    var data = await rawData.api('Pharmacy/getPaymentMode', body, context);
    if (data['responseCode'] == 1) {
      for (int i = 0; i < data['responseValue'].length; i++) {
        data['responseValue'][i].addAll({'isSelected': false});
      }

      print('getPaymentModegetPaymentModegetPaymentMode' + data.toString());

      controller.updatePaymentMode = data['responseValue'];
    }

    print('getPaymentModegetPaymentModegetPaymentMode' + data.toString());
    return data['responseCode'];
  }

  getTransactionNo(context, _razorpay) async {

    ApplicationLocalizations localization=Provider.of<ApplicationLocalizations>(context,listen: false);
    ProgressDialogue().show(context, loadingText: localization.getLocaleData.loadingData.toString());
    int mrp = (double.parse(controller.getTotalFee.toString())).toInt();
    var body = {
      "paymentAmount": mrp.toString(),
      "patientName": UserData().getUserName.toString(),
      "memberId": UserData().getUserMemberId.toString(),
      "userMobileNo": UserData().getUserMobileNo.toString(),
      "appointDate": controller.getSelectedDate==null? '':formater(controller.getSelectedDate??DateTime.now()).toString(),
      "appointTime": controller.saveTime.toString(),
      // "transactionType": "string",
      "serviceProviderDetailsId": controller.doctorId.toString(),
      "isEraUser": controller.iSEraDoctor.toString(),
    };
    var data = await rawData.api('Patient/getTransactionNo', body, context);
    ProgressDialogue().hide();
    if (data['responseCode'] == 1) {
      controller.updateTransactionNo = data['responseValue'][0]['taxId'];

      await openCheckout(context, _razorpay);

      print('getTransactionNogetTransactionNogetTransactionNogetTransactionNo' +
          data.toString());
    } else {
      alertToast(context, data['responseMessage']);
    }
  }

  Future<void> onlineAppointment(context) async {
    ApplicationLocalizations localization=Provider.of<ApplicationLocalizations>(context,listen: false);
    ProgressDialogue().show(context, loadingText: controller .getMyAppoointmentData.appointmentId!=0?
    localization.getLocaleData.reScheduleAppointment.toString(): localization.getLocaleData.bookingAppointment.toString());

    int mrp = (double.parse(controller.getTotalFee.toString())).toInt();
    var body = {
      "memberId": userData.getUserMemberId.toString(),
      "patientName": userData.getUserName.toString(),
      "mobileNo": userData.getUserMobileNo.toString(),
      "guardianTypeId": userData.getGardianRelationId.toString(),
      "guardianName": userData.getGardianName.toString(),
      "stateId": userData.getUserStateId.toString(),
      "address": userData.getUserAddress.toString(),
      "pincode": userData.getUserPinCode.toString(),
      "paymentMode": 'cash',
      "serviceProviderDetailsId": controller.getMyAppoointmentData.appointmentId != 0
          ? controller.getMyAppoointmentData.doctorId.toString():
      controller.doctorId.toString(),
      "appointDate": controller.getSelectedDate==null? '':formater(controller.getSelectedDate??DateTime.now()).toString(),
      "appointTime": controller.saveTime.toString(),
      "isEraUser": controller.getMyAppoointmentData.appointmentId != 0
          ? controller.getMyAppoointmentData.isEraUser.toString():
      controller.iSEraDoctor.toString(),
      "problemName": "",
      "dtPaymentTable": jsonEncode([
        {
          "paymentStatus": "success",
          "bankRefNo": controller.getTransactionNo.toString(),
          "paymentAmount": "$mrp",
          "transactionNo": controller.getTransactionNo.toString(),
          "isErauser": controller.iSEraDoctor.toString()
        }
      ]),
      "appointmentId": controller.getMyAppoointmentData.appointmentId.toString(),
      "dob": DateFormat('yyyy-MM-dd').format(
          DateFormat('dd/MM/yyyy').parse(userData.getUserDob.toString())),
      "gender": userData.getUserGender.toString(),
      "paymentId": controller.getPaymentId.toString(),
      "transactionNo": controller.getTransactionNo.toString(),
      "otherAppointmentsCounts": '',
      'isFromDevice':2,
      'appointmentStartTime':startBookingTime,
    };

    var data = await rawData.api('Patient/onlineAppointment', body, context,
        token: true);
    log('nnnnnnnnnnnnnnnnnnnnnnnn'+data.toString());

    ProgressDialogue().hide();
    if (data['responseCode'] == 1) {
      controller.updateAppointmentDetailList=data['responseValue'];
      // SavePatientVisitRevisit(context);

      alertToast(context, data['responseMessage']);
      controller.getMyAppoointmentData.appointmentId == 0?
      Get.offAll(const AppointmentSuccessful()) :
      //Get.offAll(DashboardView());
      Get.offAll(const StartupPage());

    } else {
      alertToast(context, data['responseMessage']);
      Get.offAll(const StartupPage());
    }
  }

  // int getAge(){
  //   print( '------------------'+UserData().getUserDob.toString());
  //   var days = DateTime.now().difference(DateFormat('dd/MM/yyyy').parse(UserData().getUserDob.toString())).inDays;
  //   return days ~/ 360;
  // }


  // SavePatientVisitRevisit(context) async {
  //
  //   var body={
  //     'PID': UserData().getUserPid.toString(),
  //     'PTPCRNegativeReportDate': '',
  //     'address': UserData().getUserAddress.toString(),
  //     "age": getAge().toString(),
  //     "ageUnit":'0',
  //     'cardImage': "",
  //     'counterID': '75',
  //     'discountedBy': "",
  //     'districtID': UserData().getUserDistrictId.toString(),
  //     'dob':DateFormat('yyyy-MM-dd').format(DateFormat('dd/MM/yyyy').parse(UserData().getUserDob.toString())),
  //     'doctorID': controller.getMyAppoointmentData.appointmentId != 0
  //         ? controller.getMyAppoointmentData.doctorId.toString():
  //     controller.doctorId.toString(),
  //     'educationalID': '0',
  //     'fileCharge': "0.00",
  //     'gender':UserData().getUserGender.toString()=='1'? "M" : "F",
  //     'guardianName': UserData().getGardianName.toString(),
  //     'guardianRelationID': UserData().getGardianRelationId.toString(),
  //     'headID': '0',
  //     'identityNumber': "",
  //     'identityTypeID': '0',
  //     'isChecked': "0",
  //     'isPostCovid': "0",
  //     'labName': "",
  //     'maritalStatusID': '0',
  //     'mobileNo': UserData().getUserMobileNo.toString(),
  //     'occupationID': '0',
  //     'paidAmount': '0.00',
  //     'patientCategoryID': '0',
  //     'patientName': UserData().getUserName.toString(),
  //     'patientProblem': '',
  //     'rdCovidStatus': '0',
  //     'referredFrom': '',
  //     'roomID': "0",
  //     'staffHeadID': '0',
  //     'stateID': UserData().getUserStateId.toString(),
  //     'subDepartmentID': "0",
  //     'userID':UserData().getUserPid.toString(),
  //     'visitCharge': '0.00',
  //     'vmValueBPDias': "",
  //     'vmValueBPSys': "",
  //     'vmValuePulse': "",
  //     'vmValueRBS': "",
  //        'vmValueSPO2': "",
  //     'vmValueTemperature': "",
  //   };
  //    var data=await http.post(Uri.parse('http://182.156.200.179:201/api//PatientRegistration/SavePatientVisitRevisitForDigiDoctor'), body:body,);
  //
  // }





  openCheckout(context, Razorpay _razorpay) async {
    int mrp = (double.parse(controller.getTotalFee.toString()) * 100).toInt();

    var options = {
      'key': 'rzp_live_BwhTaXRxeklaAI',
      // 'key': 'rzp_test_ZuepJZ0pus1Nuf',
      'amount': mrp,
      'name': 'Digi Doctor',
      'currency': 'INR',
      'theme.color': '#1088fc',
      "image": "assets/DDLogo.png",
      'description': 'Book online consultation',
      'prefill': {
        'contact': UserData().getUserMobileNo,
        'email':
        UserData().getUserEmailId == 'null' ? '' : UserData().getUserEmailId
      },
      'external': {
        'wallets': ['paytm']
      },
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint('Error: e');
    }
  }

  checkPaymentMode(index, val) {
    controller.paymentMode[index]['isSelected'] = !val;

    controller.updateSelectPayType =
    controller.paymentMode[index]['isSelected'];
    controller.update();
  }
}
class OptionDataModals{
  String?optionText;
  String?optionIcon;
  Widget?route;

  OptionDataModals({
    this.optionText,
    this.optionIcon,
    this.route
  });

}
