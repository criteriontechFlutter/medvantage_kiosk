import 'dart:convert';
import 'package:digi_doctor/AppManager/user_data.dart';
import 'package:digi_doctor/Pages/Symptoms/Select_Doctor/select_doctor_controller.dart';
import 'package:get/get.dart';
import '../../../AppManager/raw_api.dart';
import '../top_symptoms_controller.dart';

class SelectDoctorModal {
  var data;
  List symptomData = [];
  List demoList = [];
  SelectDoctorController controller = Get.put(SelectDoctorController());
  TopSymptomsController topController = Get.put(TopSymptomsController());
  RawData rawData = RawData();

  getDoctorBySymptom(context) async {

    String selectedSymptomId='';
    print(controller.problemId.toString());
    for(int i=0;i<controller.problemId.length;i++){
      selectedSymptomId=selectedSymptomId+controller.problemId[i].toString()+',';
    }
    var body = {
      "memberId": UserData().getUserMemberId.toString(),
      "symptomId": selectedSymptomId.toString(),
    };
    var data =
        await rawData.api('Patient/getDoctorProfileBySymptom', body, context);
    //print(data.toString());
    if (data['responseCode'] == 1) {
      for (int i = 0;
          i < data['responseValue'][0]['popularDoctor'].length;
          i++) {
        final uniqueJsonList = jsonDecode((data['responseValue'][0]
                    ['popularDoctor'][i]['workingHours'] ??
                "[]"))
            .toSet()
            .toList();
//print("------------"+uniqueJsonList.toString());
       var result = uniqueJsonList.map((item) => item['dayName'].toString().substring(0,3)).toList();

        data['responseValue'][0]['popularDoctor'][i].addAll({'sittingDays':result});
      }

      //print('----------------------------------' +  data['responseValue'][0]['popularDoctor'].toString());
      controller.update_recommended_doctors = data['responseValue'];
    }
  }
}
