



import 'package:digi_doctor/AppManager/app_util.dart';
import 'package:digi_doctor/AppManager/my_text_theme.dart';
import 'package:digi_doctor/AppManager/widgets/my_button.dart';
import 'package:digi_doctor/Localization/app_localization.dart';
import 'package:digi_doctor/Pages/profile/profle_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../AllowPrivacyDoctor/allowPrivacyDoctorView.dart';


privacyAlertView(context){

  ProfileModel modal = ProfileModel();
  String drName = modal.controller.notificationDrName;
  String reportName = "";

  if (modal.controller.isInvestigation == 1){
    reportName = "Investigation report.";
  }else{
    reportName = "Prescription report.";
  }

  ApplicationLocalizations localization=Provider.of<ApplicationLocalizations>(context,listen: false);
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
          title: Column(
            children: [
              Text( '$drName wants to see your $reportName', textAlign: TextAlign.center,style: MyTextTheme().mediumBCB,),
              const SizedBox(height: 5),
              Text('Do you want to allow it ?', textAlign: TextAlign.center,style: MyTextTheme().mediumBCN,),
            ],
          ),
          contentPadding: const EdgeInsets.all(20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          content: Stack(
            clipBehavior: Clip.none,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(child: MyButton(title: localization.getLocaleData.yes.toString(),width: 60,onPress: () async {
                    if(modal.controller.isInvestigation == 1){
                      modal.controller.setIsInvestigation = 1;
                      modal.controller.setIsPrescription = 0;
                    }else if (modal.controller.isPrescription == 1){
                      modal.controller.setIsInvestigation = 0;
                      modal.controller.setIsPrescription = 1;
                    }
                    Navigator.of(context).pop();
                    App().navigate(context, const AllowPrivacyDoctorView());
                  },)),
                  const SizedBox(width: 25),
                  Expanded(child: MyButton(title: localization.getLocaleData.no.toString(),width: 60,onPress: (){
                    Navigator.of(context).pop();
                  },))
                ],
              ),
            ],
          ));
    },
  );
}