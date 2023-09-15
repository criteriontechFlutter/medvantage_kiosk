import 'package:digi_doctor/AppManager/alert_dialogue.dart';
import 'package:digi_doctor/Pages/prescription_history/prescription_details/prescription_details_controller.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';

import '../../../AppManager/raw_api.dart';
import '../prescription_history_modal.dart';


class PrescriptionDetailModal{
  PrescriptionDetailsController controller=Get.put(PrescriptionDetailsController());
  PrescriptionHistoryModal modal = PrescriptionHistoryModal();

  getMedicationPdf(context, appointmentId) async{
     controller.updateShowNoData=false;
    var body={
         //"appointmentId":"12292"
        "appointmentId":controller.appointmentId.value.toString()

    };
    print("*****"+appointmentId.toString());
    var data = await RawData().api('Patient/getMedicationDetailsForPDF', body, context,token: true);

     controller.updateShowNoData=true;
    if(data['responseCode'] == 1){
      controller.updatePdfUrl = data['responseValue']?? '';
      controller.updateresponseCode = data['responseCode'].toString();
    }
    else if(data['responseCode'] == 0){
     alertToast(context, data['responseMessage']);
    }

  }
  onPressed(context, {appointmentId})async{
    await getMedicationPdf(context, appointmentId);
  }
}