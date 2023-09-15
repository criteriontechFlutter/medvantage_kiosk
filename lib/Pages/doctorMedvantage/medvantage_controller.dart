




import 'package:digi_doctor/Pages/doctorMedvantage/doctorDataModal.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class MedvantageController extends GetxController {

  List<TopSpecialitiesDataModal> departmentList =[];
  get getTopSpecialities=>departmentList;
  set updateDepartmentList(List<TopSpecialitiesDataModal> val){
    departmentList=val;
    update();
  }


}