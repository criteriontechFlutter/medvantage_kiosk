
import 'package:get/get.dart';

import 'DataModal/medicineDataModal.dart';

class MedicineController extends GetxController {
  // Rx<TextEditingController> time1C = TextEditingController().obs;
  // Rx<TextEditingController> time2C = TextEditingController().obs;

  List medicineList = [].obs;
  List<MedicineReminderDataModal> get getMedicineList =>
      List<MedicineReminderDataModal>.from(medicineList
          .map((element) => MedicineReminderDataModal.fromJson(element)));
  set updateMedicineList(List val) {
    medicineList = val;
    update();
  }

  RxBool showNoData = false.obs;
  bool get getShowNoData => (showNoData.value);
  set updateShowNoData(bool val) {
    showNoData.value = val;
    update();
  }

  RxInt selectedMId = 0.obs;
  int get getSelectedMID => selectedMId.value;
  set updateSelectedMID(int val) {
    selectedMId.value = val;
    update();
  }

  RxString selectedMNAME = 'Medicine'.obs;
  String get getSelectedMNAME => selectedMNAME.value;
  set updateSelectedMNAME(String val) {
    selectedMNAME.value = val;
    update();
  }
}
