


import 'dart:convert';

import 'package:digi_doctor/AppManager/raw_api.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../AppManager/alert_dialogue.dart';
import '../../../../AppManager/user_data.dart';

class GoogleFitModal{

  addVitalData(context,sys ,dia ,hR,BO) async {

    AlertDialogue().show(context,
        msg: 'Are you Sure you want to save Vital'.toString(),
        firstButtonName: 'Save'.toString(),
        showOkButton: false, firstButtonPressEvent: () async{
          Navigator.pop(context);
          List dtDataTable=[];

          if(sys!=''){
            dtDataTable.add({
              'vitalId': 4.toString(),
              'vitalValue': sys.toString(),
            });
          }

          if(sys!=''){
            dtDataTable.add({
              'vitalId': 6.toString(),
              'vitalValue': dia.toString(),
            });
          }
          if(hR!=''){
            dtDataTable.add({
              'vitalId': 3.toString(),
              'vitalValue': hR.toString(),
            });
          }
          if(BO!=''){
            dtDataTable.add({
              'vitalId': 56.toString(),
              'vitalValue': BO.toString(),
            });
          }

          var body = {
            "memberId": UserData().getUserMemberId,
            'dtDataTable': jsonEncode(dtDataTable),
            "date": DateFormat("yyyy-MM-dd").format(DateTime.now()).toString(),
            "time": DateFormat("HH:mm:ss").format(DateTime.now()).toString(),
          };
          var data = await RawData().api(
            "Patient/addVital",
            body,
            context,
          );
          if (data['responseCode'] == 1) {
            alertToast(context, data['responseMessage']);


          } else {

          }



        }, showCancelButton: true);

  }


}