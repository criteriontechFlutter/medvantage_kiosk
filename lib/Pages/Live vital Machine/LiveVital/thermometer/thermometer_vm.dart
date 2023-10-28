

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

import '../../../../AppManager/alert_dialogue.dart';
import '../../../../AppManager/progress_dialogue.dart';
import '../../../../AppManager/raw_api.dart';
import '../../../../AppManager/user_data.dart';
import '../../../VitalPage/Add Vitals/add_vitals_modal.dart';

class ThermometerVM extends ChangeNotifier{



  String tempalue='';
  String get getTempValue=>tempalue;

  set updateGetTempValue(List val){

    var c;

    print('vvvvvvvvvvvvvvvvnnnnnnnnnnnv'+val.toString());
    if(val.isNotEmpty){
      c = val[2].toRadixString(16) + val[1].toRadixString(16);

      final number = int.parse(c, radix: 16);

      for (int i = 0; i < number.toString().length - 1; i++) {
        print(number.toString()[i].toString());
        tempalue = tempalue + number.toString()[i];
      }
      tempalue =
          tempalue + '.' + number.toString()[number.toString().length - 1];
    }
    print('vvvvvvvvvvvvvvvvv'+tempalue.toString());

    notifyListeners();
  }



  String myv='';
  String get getmyv=>myv;

  set updateGetmyv(String val){

    myv=val;
    notifyListeners();
  }
  String tmpType='';
  String get gettmpType=>tmpType;

  set updateGettmpType(String val){
    tmpType=val;
    notifyListeners();
  }






  saveDeviceVital(context) async {


    AddVitalsModel vitalModal=AddVitalsModel();

    await vitalModal.medvantageAddVitals(context,
      Temperature: getmyv.toString(),);



  }


}