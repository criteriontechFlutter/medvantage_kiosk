


import 'package:digi_doctor/Pages/home_isolation/DataModal/home_isolation_patient_list_data_modal.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class HomeIsolationPatientListController extends GetxController {

  RxBool showNoData = false.obs;

  bool get getShowNoData => (showNoData.value);
  set updateShowNoData(bool val) {
    showNoData.value = val;
    update();
  }

  List homeIsolationPatientList = [].obs;
  List<HomeIsolationPatientListDataModal> get getIsolationPatientList =>
      List<HomeIsolationPatientListDataModal>.from(
          homeIsolationPatientList.map((e) =>
              HomeIsolationPatientListDataModal.fromJson(e)));

  set updateHomeIsolationPatientList(List val) {
    homeIsolationPatientList = val;
    update();
  }

}