import 'package:digi_doctor/AppManager/raw_api.dart';
import 'package:digi_doctor/AppManager/user_data.dart';
import 'package:get/get.dart';

import 'diagnostic_labs_controller.dart';

class DiagnosticLabsModal{
  DiagnosticLabController diagnosticLabController=Get.put(DiagnosticLabController());
   getAllLabs(context)async{
    var body={
      "memberId":UserData().getUserMemberId.toString()
    };
    var data=await RawData().api('Lab/getAllLabs', body, context,token: true);
      if(data['responseCode']==1){
        diagnosticLabController.updateDiagnosticLabs=data['responseValue'];
      }
      print("next");
    }
  }

