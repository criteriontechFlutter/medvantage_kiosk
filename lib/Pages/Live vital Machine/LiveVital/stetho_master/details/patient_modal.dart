import 'package:digi_doctor/AppManager/progress_dialogue.dart';
import 'package:digi_doctor/AppManager/raw_api.dart';
import 'package:digi_doctor/AppManager/user_data.dart';
import 'package:digi_doctor/Pages/VitalPage/LiveVital/stetho_master/details/pateint_controller.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:get/get.dart';
class PatientModal {
  PatientController controller = Get.put(PatientController());
  BluetoothConnection? connection;

  submitDetails(
      context, String selectGender, String deviceName, String deviceKey) async {
    ProgressDialogue().show(context, loadingText: 'loading');

    print("deviceKey$deviceKey");
    var body = {
      "deviceKey": "9C9C1FC2AC26",
      "pid": controller.pidField.text.toString(),
      "name": controller.nameC.text.toString(),
      "age": controller.ageC.text.toString(),
      "gender": selectGender
    };
    var data = await RawData().api('saveApi/',body, context, token: false,isNewBaseUrl: true,newBaseUrl: "http://aws.edumation.in:5001/sthethoapi/");
    ProgressDialogue().hide();
    print('datatatatatata   $data');
    controller.updatPatientDetails = data['data'];
    UserData().addListenUrl(controller.getpatientDetails.listenUrl.toString());
  }
}
