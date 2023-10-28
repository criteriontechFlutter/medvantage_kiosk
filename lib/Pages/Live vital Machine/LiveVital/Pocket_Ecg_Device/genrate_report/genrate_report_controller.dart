import 'dart:convert';
import 'dart:developer';
import 'package:digi_doctor/AppManager/user_data.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../../../AppManager/raw_api.dart';
import '../../../../VitalPage/Add Vitals/add_vitals_modal.dart';
import '../ecg_controller.dart';

class GenerateReportController extends GetxController{

  EcgController ecgController =Get.put(EcgController());


  Map perLead={};
  Map get getPerLead=>perLead;
  set updatePerLead(Map val){
    perLead=val;
    update();
  }

  // String leadGain = '2';

  saveECGBMData(context) async {
    // try{    sir ab check kariye
    Map  body={
      "time": DateTime.now().toString(),
      "PID":UserData().getUserPid.toString(),
      "Location":UserData().getUserLocation.toString(),
      "notes":ecgController.notesController.text.toString(),
      "leadGain":"1".toString(),
      "patientInfo": {
        "name":UserData().getUserName.toString(),
        "gender":UserData().getUserGender.toString()=='1'? "Male":'Female',
        "city":UserData().getUserCityName.toString(),
        "age": '${DateTime.now().year - int.parse(UserData().getUserDob.split('/')[2])} year' ,
      },
      'payLoad': {
        "leadName": "LEAD II".toString(),
        "data": (ecgController.ecgData.toList().length < 1500
            ? ecgController.ecgData.toList()
            : ecgController.ecgData
            .toList()
            .getRange(
            (ecgController.ecgData.toList().length -
                1500),
            ecgController
                .ecgData.toList().length)).toList().join(',').toString()


      }
    };
    log('nnnnnnnnnnnnvnvnvnvnvnvnvnnvnvnvnvnv'+jsonEncode(body).toString());
    (json.encode(body).toString());
    print(json.encode(body).toString());
    try{
      var response = await http.post(Uri.parse('http://182.156.200.179:1880/ecg'),
          body: json.encode(body),
          headers: {
            "authKey": "4S5NF5N0F4UUN6G",
            "content-type": "application/json",
          }
      );

      print(response.toString());
      var data = await json.decode(response.body);

      print('nnnnnnnnnnnnvnvnvnvnvnvnvnnvnvnvnvnv1112222' + data.toString());
      updatePerLead=data['perlead'][0];
    }
    catch(e){
      print('nnnnnnnnnnnnvnvnvnvnvnvnvnnvnvnvnvnv111222vvv2' + e.toString());
      alertToast(context, 'Error');
    }
    // }
    // catch(e){
    //    print('nnnnnn'+e.toString());
    //   alertToast(context, 'Data Not Saved');
    // }
  }


  genrateReportTableData({required String interval, required String intervalValue,required String emptyReturn}){
   var data= getPerLead.isEmpty
        ? emptyReturn.toString()
        :getPerLead['Lead_II']==null? '0':getPerLead['Lead_II'][interval]==null? '0':getPerLead['Lead_II'][interval][intervalValue]??'0';
  return data;
  }



  saveDeviceVital(context,getHrValue) async {

    List dtDataTable = [];

    AddVitalsModel vitalModal=AddVitalsModel();

    await vitalModal.medvantageAddVitals(context,
      HeartRate: getHrValue.toString(),);


  }


}