


import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

import '../../../../Localization/app_localization.dart';
import '../../../MyAppointment/MyAppointmentDataModal/my_appointment_data_modal.dart';
import '../../DataModal/appointment_time_data_modal.dart';
import 'package:get/get.dart';

import '../DataModal/appointment_details_data_modal.dart';
import '../DataModal/payment_data_modal.dart';

class TimeSlotController extends GetxController{


 String? selectedSlot;
 set updateSelectedSlot(String val){
   selectedSlot=val;
   update();
 }
 List<OptionDataModals> getOption(context){
   ApplicationLocalizations localization = Provider.of<
       ApplicationLocalizations>(context, listen: false);
   return [
     OptionDataModals(
       optionIcon  :"assets/kiosk_setting.png",
       optionText: localization.getLocaleData.hintText!.bySpeciality.toString(),
       // route: TopSpecialitiesView(),
     ),
     OptionDataModals(
       optionIcon: "assets/kiosk_symptoms.png",
       optionText:  localization.getLocaleData.hintText!.bySymptoms.toString(),
       // route:
     )
   ];

 }

  RxString doctorId=''.obs;
  RxString iSEraDoctor=''.obs;

  RxString saveTime =''.obs;

  DateTime? _selectedDate ;


  DateTime? get getSelectedDate =>_selectedDate;
  set updateSelectedDate(DateTime val){
    _selectedDate= val;

    update();
  }
  String get getSavedTime=>saveTime.value;

  List slotTypeList = [].obs;
  List get getSlotTypeList=>slotTypeList;
  set updateSlotTypeList(List val){
    slotTypeList=val;
    update();
  }
  List slotList = [].obs;

  List<AppointmentTimeDataModal> get getSlotList=>List<AppointmentTimeDataModal>.from(
      slotList.map((element) => AppointmentTimeDataModal.fromJson(element))
  );


 // List<SlotBookedDetails>   getSlotList(slotType)=>List<SlotBookedDetails>.from(
 //     (
 //         slotList.where(( element) => element['slotType'].toString().trim()==slotType.toString().trim()).toList()
 //     )
 //         .map((element) => SlotBookedDetails.fromJson(element))
 // );


 set updateSlotList(List val){
    slotList=val;
    update();
  }

  RxBool showNoData=false.obs;
  bool get getShowNoData=>(showNoData.value);

  set updateShowNoData(bool val){
    showNoData.value=val;
    update();
  }

  RxDouble totalFee=0.0.obs;
  double get getTotalFee=> totalFee.value;
  set updateTotalFee(double val){
    totalFee.value=val;
    update();
  }


  RxString orderId=''.obs;
  RxString paymentId=''.obs;
  String get getOrderId=>orderId.value;
  String get getPaymentId=>paymentId.value;
  set updatePaymentResponse(PaymentSuccessResponse val){
    print('myyyyyyyyyyyyyyyyresponse'+val.toString());
    orderId.value=val.orderId??'';
    paymentId.value=val.paymentId??'';
        update();
  }


  List paymentMode=[].obs;
  List<PaymentDataModal> get getPaymentMode=>List<PaymentDataModal>.from(
      paymentMode.map((element) => PaymentDataModal.fromJson(element))
  );
  set updatePaymentMode(List val){
    paymentMode=val;
    update();
  }

  RxString TransactionNo=''.obs;
  String get getTransactionNo=>TransactionNo.value;
  set updateTransactionNo(String val){
    TransactionNo.value=val;
    update();
  }

  RxBool selectPayType=false.obs;
  bool get getSelectPayType=>selectPayType.value;
  set updateSelectPayType(bool val){
    selectPayType.value=val;
    update();
  }

  List myAppointmentData= [].obs;
  MyAppointmentDataModal get getMyAppoointmentData=>MyAppointmentDataModal.fromJson(
      myAppointmentData.isEmpty? {}:
      myAppointmentData[0]);
  set updateMyAppointmentData(List val){
    myAppointmentData=val;
    update();
  }


  List appointmentDetailList=[];
  AppointmentDetailsDataModal get getAppointmentDetailList=>AppointmentDetailsDataModal.fromJson(
      appointmentDetailList.isEmpty? {}:
      appointmentDetailList[0]);
  set updateAppointmentDetailList(List val){
    appointmentDetailList=val;
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