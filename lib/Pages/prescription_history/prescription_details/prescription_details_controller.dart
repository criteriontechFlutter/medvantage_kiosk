import 'package:get/get.dart';

class PrescriptionDetailsController extends GetxController{
  RxString appointmentId=''.obs;
  String get getAppointmentId=>appointmentId.value;
  set updateAppointmentId(String val){
    appointmentId.value=val;
    update();
  }

  RxString responseCode=''.obs;
  String get getresponseCode=>responseCode.value;
  set updateresponseCode(String val){
    responseCode.value=val;
    update();
  }

  RxString pdfUrl=''.obs;
  String get getPdfUrl=>pdfUrl.value;
  set updatePdfUrl(String val){
    pdfUrl.value=val;
    update();
  }


  RxBool showNoData=false.obs;
  bool get getShowNoData=>showNoData.value;
  set updateShowNoData(bool val){
    showNoData.value=val;
    update();
  }
}