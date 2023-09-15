


import 'package:digi_doctor/Pages/doctorMedvantage/doctorDataModal.dart';
import 'package:digi_doctor/Pages/doctorMedvantage/medvantage_controller.dart';
import 'package:digi_doctor/SignalR/raw_data_83.dart';
import 'package:get/get.dart';

class MedvantageModal {

  MedvantageController controller = Get.put(MedvantageController());

  getDepartmentList()async{
    print('these are department');

    var data = await RawData83().getapi('/api/DepartmentMaster/GetAllDepartmentMaster',{});
   controller.updateDepartmentList= List<TopSpecialitiesDataModal>.from(( (data['responseValue']) ).map((e) => TopSpecialitiesDataModal.fromJson(e)));
print('${controller.getTopSpecialities[0].departmentName}12345678990');



  }

}