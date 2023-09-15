//
//
// import 'package:digi_doctor/AppManager/user_data.dart';
// import 'package:get/get.dart';
//
// import '../../../AppManager/app_util.dart';
// import '../../../AppManager/raw_api.dart';
// import 'investigation_controller.dart';
//
// class InvestigationModal {
//   InvestigationController controller = Get.put(InvestigationController());
//   UserData userData = UserData();
//   HttpApp httpApp = HttpApp();
//
//   Future<void> onPressedTab(context) async {
//     switch (controller.getSelectedTab.toString()) {
//       case '0':
//         await getManualInvestigation(context);
//         break;
//       // case '1':
//       //   await getEraInvestigation(context);
//       //   break;
//       case '2':
//         await getRadioLogyReport(context);
//         //getRadiologyReport(context);
//         break;
//     }
//   }
//
//   Future<void> getManualInvestigation(context) async {
//     controller.updateShowNoData = false;
//     var body = {
//       'isRevisit': 'false',
//       'memberId': UserData().getUserMemberId.toString(),
//     };
//     var data = await RawData()
//         .api('Patient/getpatientInvestigationDetails', body, context);
//     controller.updateShowNoData = true;
//
//     if (data['responseCode'] == 1) {
//       controller.updateManuallyList = data['responseValue'];
//     }
//   }
//
//   //   getEraInvestigation(context) async {
//   //   controller.updateShowNoData = false;
//   //   var body = {
//   //     "memberId": UserData().getUserMemberId.toString(),
//   //     'pid': UserData().getUserPid.toString()
//   //   };
//   //
//   //   var data = await httpApp.api(
//   //       'Investigation/ViewBillDetailsDigiDoctor', body, context);
//   //   controller.updateShowNoData = true;
//   //   controller.updateErasInvestigation = data['investigationResult'];
//   // }
//
//   //  getRadiologyReport(context) async {
//   //   controller.updateShowNoData = false;
//   //   var body = {
//   //     "pid": UserData().getUserPid.toString(),
//   //     "userId":"1234567"
//   //   };
//   //   print(body.toString());
//   //   var data = await HttpApp().api('ICUDailyChart/GetPACSURL', body, context);
//   //   controller.updateShowNoData = true;
//   //   print('--------------');
//   //   if (data['responseCode'] == 200) {
//   //     controller.updateRadiologyList = data['pacsData'] ?? [];
//   //   }
//   // }
//
// //on click radiology this api runs
//   Future<void> getRadioLogyReport(context)async{
//     controller.updateShowNoData = false;
//     var body = {
//       //"PID": "2369559"
//       "PID": userData.getUserPid
//     };
//     var data = await httpApp.api('InvestigationSubCategoryWise/GetRadioDateWiseInvestigationDetailsDigiDoctor', body, context,);
//     //print("############# $data");
//     if(data['responseCode']==200){
//       controller.updateRadiologyReportList = await data["radioDateWiseInvestigationDetails"];
//       controller.updateShowNoData = true;
//     }
//     else{
//       controller.updateShowNoData = true;
//     }
//
//
//   }
// }




import 'package:digi_doctor/AppManager/user_data.dart';
import 'package:get/get.dart';

import '../../../AppManager/app_util.dart';
import '../../../AppManager/raw_api.dart';
import 'investigation_controller.dart';

class InvestigationModal {
  InvestigationController controller = Get.put(InvestigationController());
  UserData userData = UserData();
  HttpApp httpApp = HttpApp();

  Future<void> onPressedTab(context) async {
    switch (controller.getSelectedTab.toString()) {
      case '0':
        await getManualInvestigation(context);
        break;
    // case '1':
    //   await getEraInvestigation(context);
    //   break;
      case '2':
        await getRadioLogyReport(context);
        break;
      case '3':
        await getMicrobiologyReport(context);
        break;
    }
  }

  Future<void> getManualInvestigation(context) async {
    controller.updateShowNoData = false;
    var body = {
      'isRevisit': 'false',
      'memberId': UserData().getUserMemberId.toString(),
    };
    var data = await RawData()
        .api('Patient/getpatientInvestigationDetails', body, context);
    controller.updateShowNoData = true;
    if (data['responseCode'] == 1) {
      controller.updateManuallyList = data['responseValue'];
    }
  }

  Future<void> getBMI(context) async {
    controller.updateShowNoData = false;
    var body = {
     // 'memberId': UserData().getUserMemberId.toString(),
      'memberId': 234206,
    };
    var data = await RawData()
        .api('Patient/getBmiDetailsForKiosk', body, context);
    controller.updateShowNoData = true;
    if (data['responseCode'] == 1) {
      controller.updateBmi = data['responseValue'];
    }
  }

  //   getEraInvestigation(context) async {
  //   controller.updateShowNoData = false;
  //   var body = {
  //     "memberId": UserData().getUserMemberId.toString(),
  //     'pid': UserData().getUserPid.toString()
  //   };
  //
  //   var data = await httpApp.api(
  //       'Investigation/ViewBillDetailsDigiDoctor', body, context);
  //   controller.updateShowNoData = true;
  //   controller.updateErasInvestigation = data['investigationResult'];
  // }

  //  getRadiologyReport(context) async {
  //   controller.updateShowNoData = false;
  //   var body = {
  //     "pid": UserData().getUserPid.toString(),
  //     "userId":"1234567"
  //   };
  //   print(body.toString());
  //   var data = await HttpApp().api('ICUDailyChart/GetPACSURL', body, context);
  //   controller.updateShowNoData = true;
  //   print('--------------');
  //   if (data['responseCode'] == 200) {
  //     controller.updateRadiologyList = data['pacsData'] ?? [];
  //   }
  // }

//on click radiology this api runs
  Future<void> getRadioLogyReport(context)async{
    controller.updateShowNoData = false;
    var setPID = '';
    if (controller.getIsNotification == 1){
      setPID = controller.getPID.toString();
    }else{
      setPID = userData.getUserPid.toString();
    }
    var body = {
      "PID": UserData().getUserPid.toString()
    };
    var data = await httpApp.api('InvestigationSubCategoryWise/GetRadioDateWiseInvestigationDetailsDigiDoctor', body, context,);
    if(data['responseCode']==200){
      controller.updateRadiologyReportList = await data["radioDateWiseInvestigationDetails"];

    }else{
      controller.updateShowNoData = true;
    }
  }

  Future<void> getMicrobiologyReport(context)async{
    controller.updateShowNoData = false;
    var setPID = '';
    if (controller.getIsNotification == 1){
      setPID = controller.getPID.toString();
    }else{
      setPID = userData.getUserPid.toString();
    }
    var body = {
      "PID": setPID,
    };
    print("body :"+body.toString());
    var data = await httpApp.api('InvestigationSubCategoryWise/GetMicrobiologyInvestigationsDigiDoctor', body, context,);

    if(data['responseCode']==200){
      controller.updateMicrobiologyList = await data["microbiologyDateWiseInvestigationDetails"];
      controller.updateShowNoData = true;
    }else{
      controller.updateShowNoData = true;
    }
  }
}
