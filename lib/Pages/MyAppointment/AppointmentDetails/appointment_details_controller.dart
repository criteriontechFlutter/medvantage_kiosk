



import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import '../../../Localization/app_localization.dart';
import '../../Dashboard/dashboard_controller.dart';
import '../../prescription_history/dataModal/prescription_history_data_modal.dart';
import '../MyAppointmentDataModal/my_appointment_data_modal.dart';

class AppointmentDetailsController extends GetxController{
  RxBool showNoData=false.obs;
  bool get getShowNoData=>(showNoData.value);
  set updateShowNoData(bool val){
    showNoData.value=val;
    update();
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

  Rx<TextEditingController> reviewC=TextEditingController().obs;
  RxInt ratingData=0.obs;
  Rx<TextEditingController> selectedDrIdC=TextEditingController().obs;


  clearData(){
    reviewC.value.clear();
    ratingData.value=0;
    addDocumentList=[];
  }

  RxString selectedAppointmentId=''.obs;



  List appointmentDetailsList=[].obs;
  List otherAppointmentList=[].obs;

  List<MyAppointmentDataModal> get getAppointmentDetailsList=>List<MyAppointmentDataModal>.from(
      appointmentDetailsList.map((element) => MyAppointmentDataModal.fromJson(element))
  );


  MyAppointmentDataModal get getLatestAppointment=>MyAppointmentDataModal.fromJson(
      appointmentDetailsList.isEmpty?{}:
      appointmentDetailsList[0]);

  List<MyAppointmentDataModal> get getOtherAppointmentList=>List<MyAppointmentDataModal>.from(
      otherAppointmentList.map((element) => MyAppointmentDataModal.fromJson(element))
  );


  List sortDaysList=[].obs;
  List get getSortDaysList=>sortDaysList;
  set updateAppointmentDetailsList(List val){

    appointmentDetailsList=val[0]['appointmentDetails'];

    otherAppointmentList=val[0]['otherAppointments'];

    for (int i = 0; i < jsonDecode(appointmentDetailsList[0]['workingHours']).length; i++) {
      if(!sortDaysList.contains(jsonDecode(appointmentDetailsList[0]['workingHours'])[i]['dayName']
          .toString()
          .substring(0, 3))){
        sortDaysList.add(
            jsonDecode(appointmentDetailsList[0]['workingHours'])[i]['dayName']
                .toString()
                .substring(0, 3));
      }
    }
    update();
  }


  List addDocumentList=[];
  get getAddDocumentList=>addDocumentList;
     addDocumentInList( val,docType){
    addDocumentList.add({'docFile':val, 'img':docType});
    if (kDebugMode) {
      print('MyyyyyyyyyyyyyyyyyyyyyyyyList$addDocumentList');
    }
    update();
  }
  deleteDocumentInList( index){
    addDocumentList.removeAt(index);
    update();
  }

  List prescriptionList=[].obs;

  List<PrescriptionHistoryDataModal> get getPrescriptionList=>List<PrescriptionHistoryDataModal>.from(
      prescriptionList.map((element) => PrescriptionHistoryDataModal.fromJson(element))
  );
     set  updatePrescriptionList(List val){
       prescriptionList=val;
       update();
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