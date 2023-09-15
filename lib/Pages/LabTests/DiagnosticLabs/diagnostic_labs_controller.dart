 import 'package:get/get.dart';

import 'DataModal/diagnostic_labs_data_modal.dart';

class DiagnosticLabController extends GetxController{


  List diagnosticLabs=[];
  List <DiagnosticLabsDataModal> get getDiagnosticLabs=>List<DiagnosticLabsDataModal>.from(

      diagnosticLabs.map((e) =>DiagnosticLabsDataModal.fromJson(e) )
  );

  set updateDiagnosticLabs(List val){
    diagnosticLabs=val;
    update();
  }
}