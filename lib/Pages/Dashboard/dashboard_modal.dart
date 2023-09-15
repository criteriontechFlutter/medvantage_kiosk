
import 'dart:io';
import 'package:digi_doctor/Pages/StartUpScreen/startup_screen.dart';
import 'package:digi_doctor/Pages/SymptomTracker/symptom_tracker_view.dart';
import 'package:digi_doctor/Pages/feedback/feedback_view.dart';
import 'package:flutter/cupertino.dart';

import '../../../Localization/app_localization.dart';
import 'package:digi_doctor/AppManager/alert_dialogue.dart';
import 'package:digi_doctor/AppManager/app_util.dart';
import 'package:digi_doctor/AppManager/progress_dialogue.dart';
import 'package:digi_doctor/AppManager/raw_api.dart';
import 'package:digi_doctor/AppManager/user_data.dart';
import 'package:digi_doctor/MapServices/map_modal.dart';
import 'package:digi_doctor/Pages/Dashboard/dashboard_controller.dart';

import 'package:digi_doctor/Pages/Login_files/login_view.dart';
import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:provider/provider.dart';
import 'package:uni_links/uni_links.dart';

import '../../AppManager/api_response.dart';
import '../../AppManager/web_view.dart';

import '../InvestigationHistory/investigation_view.dart';
import '../MyAppointment/my_appointment_view.dart';
import '../VitalPage/vital_view.dart';
import '../feedback/feedback_view.dart';
import '../home_isolation/home_isolation_view.dart';
import '../medicine_reminder/medicine_View.dart';
import '../prescription_history/prescription_history_view.dart';
import '../select_member/AddMember/add_member_view.dart';
import '../share_app/share_app_view.dart';
import '../voiceAssistantProvider.dart';
import 'DataModal/dashboard_data_modal.dart';

class DashboardModal {
  RawData rawData = RawData();
  UserData user = Get.put(UserData());
  DashboardController controller = Get.put(DashboardController());

  // onPressLogout(context) async {
  //   ApplicationLocalizations localization=Provider.of<ApplicationLocalizations>(context,listen: false);
  //
  //   AlertDialogue().actionBottomSheet(subTitle: localization.getLocaleData.doYouReallyLogout.toString(),
  //       cancelButtonName: localization.getLocaleData.alertToast!.cancel.toString(),
  //       okButtonName:localization.getLocaleData.yes.toString() ,
  //       okPressEvent: ()async{
  //         var body = {
  //           'mobileNo': UserData().getUserMobileNo.toString(),
  //           'serviceProviderTypeId': 6.toString()
  //         };
  //         ProgressDialogue().show(context, loadingText: localization.getLocaleData.loggingOut.toString(),);
  //         var data =
  //         await RawData().api('Patient/logout', body, context, token: true);
  //         ProgressDialogue().hide();
  //         print(data);
  //         await UserData().removeUserData();
  //         Get.offAll(() => const StartupPage());
  //         alertToast(context, localization.getLocaleData.loggedOutSuccessfully.toString());
  //       });
  // }

  onPressLogout(context) async {
    VoiceAssistantProvider listenVM=Provider.of<VoiceAssistantProvider>(context,listen: false);
    listenVM.listeningPage="logout";
    listenVM.notifyListeners();
    ApplicationLocalizations localization=Provider.of<ApplicationLocalizations>(context,listen: false);

    var body = {
      'mobileNo': UserData().getUserMobileNo.toString(),
      'serviceProviderTypeId': 6.toString()
    };
   // ProgressDialogue().show(context, loadingText: localization.getLocaleData.loggingOut.toString(),);

    var data = await RawData().api('Patient/logout', body, context, token: true);
    ProgressDialogue().hide();
    print(data);
    await UserData().removeUserData();
    Get.offAll(() => const StartupPage());
    alertToast(context, localization.getLocaleData.loggedOutSuccessfully.toString());
    listenVM.listeningPage="main dashboard";
  }

  onPressedProblems(context, index) {
    App().navigate(context, controller.getProblemList(context)[index]['onPressed']);
  }

  Future<List<DashboardDataModal>> _getDashboardDetails(

      context, Position position) async {
      var body = {
        'lat': position.latitude,
        'long': position.longitude,
        'memberId': user.getUserId.toString()
        //'memberId': "226800"
      };

    var data = await rawData.api(
      'Patient/patientDasboard',
      body,
      context,
      token: true,
      showRetry: false,
    );
    //log("##############"+data.toString());

    if (data['responseCode'] == 1) {

      controller.updateDashboardData = data['responseValue'];
      return List<DashboardDataModal>.from((data['responseValue'])
          .map((element) => DashboardDataModal.fromJson(element)));
    } else {
      ApplicationLocalizations localization=Provider.of<ApplicationLocalizations>(context,listen: false);

      alertToast(context,localization.getLocaleData.anErrorOccurred.toString() );
      Get.back();
      return [];
    }
  }

  getLocation(context) async {
    Position locationData = await MapModal().getCurrentLocation(context);
    List address = await MapModal().getAddress(locationData);
    Placemark location = address[0];

    await UserData().addLocation(
        location.subLocality! + ',' + location.subAdministrativeArea!);
  }


  onPressedDrawerOpt(context, val) async {
    ApplicationLocalizations localization=Provider.of<ApplicationLocalizations>(context,listen: false);
    switch (val) {
      case "Appointment":
        await App().navigate(context, const MyAppointmentView());
        break;
      case 'Prescription History':
        await App().navigate(context, const PrescriptionHistory());
        break;
      case 'Investigation History':
        await App().navigate(context, const InvestigationView());
        break;
      case 'Vital History':
        await App().navigate(context, const VitalView());
        break;
      case 'Add Family Member':
        await App().navigate(context, const AddMember());
        break;
      case 'Medicine Reminder':
        if (Platform.isAndroid) {
          await App().navigate(context, const MedicineView());
        } else if (Platform.isIOS) {
          alertToast(context, localization.getLocaleData.alertToast!.comingSoon.toString());
        }
        break;
      case 'Home Isolation Request':
        await App().navigate(context, const HomeIsolation());
        break;
      case 'Symptom Tracker':
        await App().navigate(context, const SymptomTrackerView());
        break;
      case 'Share App':
        await App().navigate(context, const ShareApp());
        break;
      case 'Feedback':
        await App().navigate(context, const FeedbackView());
        break;
      case 'About Us':
        await App().navigate(
            context,
            WebViewPage(
              title: localization.getLocaleData.aboutUs.toString(),
              url: 'https://digidoctor.in/Home/AboutUs',
            ));
        break;
      case 'Logout':
        await onPressLogout(context);
        break;
      case 'Feedback':
          App().navigate(context, const FeedbackView());
        break;
    }
  }

  initUniLinks(context) async {
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      final initialLink = await getInitialLink();
      if (initialLink != null) {
        List spitPatterns = initialLink.toString().split('/')[3].split('-');

        // App().navigate(context, DoctorProfile(
        //     drName: spitPatterns[0],
        //     speciality: spitPatterns[0],
        //     degree: spitPatterns[0],
        //     address: spitPatterns[0],
        //     noofPatients: spitPatterns[0],
        //     yearOfExperience: spitPatterns[0] ,
        //     doctorId: spitPatterns[0] ,
        //     iSEraDoctor: spitPatterns[0] ,
        //     hospital: spitPatterns[0] ,
        //     fees: spitPatterns[0] ));
      }

      // Parse the link and warn the user, if it is not correct,
      // but keep in mind it could be `null`.
    } on PlatformException {
      // Handle exception by warning the user their action did not succeed
      // return?
    }
  }

  Future<void> getDashboardData(context, locationData) async {
    ApplicationLocalizations localization=Provider.of<ApplicationLocalizations>(context,listen: false);

    controller.updateApiResponse =
        ApiResponse.loading(localization.getLocaleData.fetchingDashboardData.toString());
    // notifyListeners();
    try {
      controller.updateMyDashboardData =
          await _getDashboardDetails(context, locationData);
      if (controller.findTopClinics.isEmpty) {
        controller.updateApiResponse =
            ApiResponse.empty(localization.getLocaleData.noDashboardDataFound.toString());
      } else {
        controller.updateApiResponse =
            ApiResponse.completed(controller.findTopClinics);
      }
    } catch (e) {
      controller.updateApiResponse = ApiResponse.error(localization.getLocaleData.someIssueOccurred.toString());
    }
    controller.update();
  }

  // Future<void> getDoctorData(context) async {
  //   controller.updateDoctorApiResponse =
  //       ApiResponse.loading('Fetching Dashboard Data');
  //   // notifyListeners();
  //   try {
  //     controller.updateDoctorDashboard =
  //         await _getDoctorProfileBySpeciality(context);
  //     if (controller.doctorDashboard.isEmpty) {
  //       controller.updateDoctorApiResponse =
  //           ApiResponse.empty('Doctor Data Not Found'.toString());
  //     } else {
  //       controller.updateDoctorApiResponse =
  //           ApiResponse.completed(controller.doctorDashboard);
  //     }
  //   } catch (e) {
  //     controller.updateApiResponse =
  //         ApiResponse.error('Some Issue Occurred'.toString());
  //   }
  //   controller.update();
  // }

  // Future<void> getDrawerData(context) async {
  //   controller.updateDrawerApiResponse =
  //       ApiResponse.loading('Fetching Dashboard Data');
  //
  //   try {
  //     controller.updateDrawerData = await _getMenuForApp(context);
  //     if (controller.drawerData.isEmpty) {
  //       controller.updateDrawerApiResponse =
  //           ApiResponse.empty('Drawer Data Not Found'.toString());
  //     } else {
  //       controller.updateDrawerApiResponse =
  //           ApiResponse.completed(controller.drawerData);
  //     }
  //   } catch (e) {
  //     controller.updateDrawerApiResponse =
  //         ApiResponse.error('Some Issue Occurred'.toString());
  //   }
  //   controller.update();
  // }


  getLanguageKeyList(context) async {
    var body={
      'langKeyID':'',
      'languageID':'',
    };
    var data=await  RawData().api('LanguageKey/GetLanguageKeyList', body,context,token: true );
    print('nnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnn'+data.toString());
  }



  Future<void> cancelAppointment(context, String appointmentId) async {
    var body = {
      "appointmentId": appointmentId
    };
    var data = await rawData.api('Patient/cancelAppointment', body, context);
    if (data['responseCode'] == 1) {
      Position locationData = await MapModal().getCurrentLocation(context);
      await getLocation(context);
      await getDashboardData(context, locationData);
    }
    Navigator.of(context).pop();
  }
}
