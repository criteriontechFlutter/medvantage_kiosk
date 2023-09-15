
import 'dart:convert';
import 'dart:developer';
import 'package:digi_doctor/AppManager/alert_dialogue.dart';
import 'package:digi_doctor/AppManager/progress_dialogue.dart';
import 'package:digi_doctor/AppManager/user_data.dart';
import 'package:digi_doctor/Pages/Specialities/SpecialistDoctors/DoctorProfile/doctor_profile_controller.dart';
import 'package:provider/provider.dart';

import '../../../../AppManager/app_util.dart';
import '../../../../AppManager/raw_api.dart';
import 'package:get/get.dart';

import '../../../../Localization/app_localization.dart';
import '../../../Dashboard/dashboard_controller.dart';
import '../../../Dashboard/dashboard_modal.dart';

class DoctorProfileModal {
  DoctorProfileController controller = Get.put(DoctorProfileController());
  DashboardController dashboardController = Get.find();
  RawData rawData = RawData();
  UserData userData = Get.put(UserData());

  Future<void> getDoctorProfile(context) async {
    controller.updateShowNoData = false;
    var body = {
      "id": controller.getDoctorId.toString(),
      "userLoginId": userData.getUserId.toString(),
      "userMobileNo": userData.getUserMobileNo.toString(),
    };
    var data = await rawData.api('Doctor/getDoctorProfile', body, context,
        token: true);
    controller.updateShowNoData = true;
// My code

    if (data['responseCode'] == 1) {
      controller.updateDoctorProfileData = data['responseValue'];
      //log("*******************"+data.toString());
      controller.updateSelectedNo=data['responseValue'][0]['mobileNo'].toString();
        controller.updateProfileList =
            jsonDecode(data['responseValue'][0]['timeSlots'] ?? '[]');
      for (int i = 0;
      i < jsonDecode(data['responseValue'][0]['timeSlots']).length;
      i++) {
        print('----------------------------------');
        final uniqueJsonList = jsonDecode((data['responseValue'][0]
        ['timeSlots'] ??
            "[]"))
            .toSet()
            .toList();

        var result = uniqueJsonList.map((item) => item['dayName']).toList();
        // data['responseValue'][0]['mobileNo'][i].addAll(
        //     {'dayName': result});

        controller.updateSittingDaysList = result.toSet().toList();
        print('----------------------------------' + result.toString());
      }
    }
    else{
      alertToast(context, data['responseMessage']);
    }

// end

    // if (data['responseCode'] == 1) {
    //   controller.updateSelectedNo=data['responseValue'][0]['mobileNo'].toString();
    //   controller.updateProfileList =
    //       jsonDecode(data['responseValue'][0]['dayName'] ?? '[]');
    //
    //   print('----------------------------------' +  data['responseValue'][0]['mobileNo'].toString());
    // }


  }

  Future<void> sendSMSPatientToDoctor(context,mobileNo) async {
    ApplicationLocalizations localization=Provider.of<ApplicationLocalizations>(context,listen: false);

    var body = {
      "patientName": userData.getUserName.toString(),
      "mobileNo":mobileNo.toString()
    };
    var data =
        await rawData.api('Patient/sendSMSPatientToDoctor', body, context);
    if (data['responseCode'] == 1) {
      alertToast(context, data['responseMessage']);
    } else {
      alertToast(context, localization.getLocaleData.messageNotSend.toString());
    }
  }

  Future<void> addFavouriteDoctor(context,String doctorId,int status) async {
    ApplicationLocalizations localization=Provider.of<ApplicationLocalizations>(context,listen: false);

    ProgressDialogue().show(context, loadingText: 'Loading...');
    var body = {
      "patientId": userData.getUserMemberId.toString(),
      "doctorId": doctorId,
      "status": status,
    };
    var data =
        await rawData.api('Patient/PatientFavouriteDoctor', body, context);

    if (data['responseCode'] == 1) {
      alertToast(context, data['responseMessage']);
      if(status==1){
        dashboardController.updateFavoriteDoctorProfile(controller.getDoctorProfileData);
      }
      else{
        dashboardController.removeFavoriteDoctor(doctorId);
      }
      //onBackApiCall = true;
      // Position locationData = await MapModal().getCurrentLocation(context);
      // await dashboardModal.getLocation(context);
      // await dashboardModal.getDashboardData(context, locationData);
    } else {
      alertToast(context, data['responseMessage']);
    }
    ProgressDialogue().hide();
  }


}
