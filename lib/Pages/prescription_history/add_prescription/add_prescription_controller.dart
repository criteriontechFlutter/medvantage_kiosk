import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';


class AddPrescriptionController extends GetxController {
  final formKey = GlobalKey<FormState>().obs;

  var file = ''.obs;

  Rx<TextEditingController> doctorNameController = TextEditingController().obs;
  Rx<TextEditingController> dateController = TextEditingController().obs;
  Rx<TextEditingController> durationController = TextEditingController().obs;

  Rx<TextEditingController> medicineC = TextEditingController().obs;

  Rx<TextEditingController> frequencyC = TextEditingController().obs;
  RxInt medicineNameId = 0.obs;
  RxInt dosageFormId = 0.obs;
  RxInt doseUnitId = 0.obs;
  RxDouble strength = 0.0.obs;
  RxInt frequencyId = 0.obs;

  //

  List diagnosisList = [].obs;

  List get getDiagnosisList => diagnosisList;

  set updateDiagnosisList(List val) {
    diagnosisList = val;
    update();
  }


  RxInt diagnosisId = 0.obs;

  int get getDiagnosisId => diagnosisId.value;

  set updateDiagnosisId(int val) {
    diagnosisId.value = val;
    update();
  }

  RxString problemName = ''.obs;

  String get getProblemName => problemName.value;

  set updateProblemName(String val) {
    problemName.value = val;
    update();
  }

  String prescriptionPhotoPath = '';

  get getPrescriptionPhotoPath => prescriptionPhotoPath;

  set updatePrescriptionPhotoPath(String val) {
    prescriptionPhotoPath = val;
    update();
  }

  List medicineDataList = [].obs;

  List get getMedicineDataList => medicineDataList;


  RxString selectedFrequency = ''.obs;

  List searchedMedicines = [].obs;

  List get getSearchedMedicine => (searchedMedicines
              .where((element) =>
                  element['medicineName'].toString() == medicineC.value.text)
              .toList()
              .length ==
          1)
      ? []
      : searchedMedicines;

  set updateSearchedMedicine(List val) {
    searchedMedicines = val;
    update();
  }

  void onTapMedicine(Map val) {
    medicineC.value.text = val['medicineName'];
    frequencyC.value.text = val['frequencyName'];
    medicineNameId.value = val['id'] ?? 0;
    dosageFormId.value = val['dosageFormId'] ?? 0;
    strength.value = val['strength'];
    frequencyId.value = val['frequencyId'] ?? 0;
    doseUnitId.value = val['doseUnitId'];
    searchedMedicines.clear();
    update();
  }

  List frequencyList = [].obs;

  List get getFrequency => frequencyList
              .where((element) =>
                  element['name'].toString() == frequencyC.value.text)
              .toList()
              .length ==
          1
      ? []
      : frequencyC.value.text == ''
          ? []
          : frequencyList
              .where((element) => element['name']
                  .toString()
                  .toLowerCase()
                  .trim()
                  .contains(frequencyC.value.text.toLowerCase().trim()))
              .toList();

  set updateFrequencyList(List val) {
    frequencyList = val;
    update();
  }

  void onTapFrequency(Map val) {
    frequencyC.value.text = val['name'];
    frequencyId.value = val['id'] ?? 0;

    searchedMedicines.clear();
    update();
  }
}
