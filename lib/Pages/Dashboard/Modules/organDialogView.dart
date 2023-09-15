


import 'package:digi_doctor/AppManager/app_color.dart';
import 'package:digi_doctor/AppManager/app_util.dart';
import 'package:digi_doctor/AppManager/widgets/my_button.dart';
import 'package:digi_doctor/Localization/app_localization.dart';
import 'package:digi_doctor/Pages/Dashboard/OrganSymptom/organListView.dart';
import 'package:digi_doctor/Pages/Dashboard/OrganSymptom/organ_modal.dart';
import 'package:digi_doctor/Pages/Symptoms/topSymptoms2.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


organAlertView(context){

  ApplicationLocalizations localization=Provider.of<ApplicationLocalizations>(context,listen: false);
  OrganModal modal =  OrganModal();

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
          title: Text(localization.getLocaleData.doYouHaveProblemSpecificBodyPart.toString(), textAlign: TextAlign.center,),
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
                    Navigator.pop(context);
                    App().navigate(context, const OrganListView());
                    modal.controller.selectedOrganSymptomList = [];
                  },)),

                  const SizedBox(width: 20,),

                  Expanded(child: MyButton(title: localization.getLocaleData.no.toString(),width: 60,onPress: (){
                    Navigator.of(context).pop();
                    App().navigate(context, const TopSymptomsBeta());
                  },))
                ],
              ),
              Positioned(
                top: -100,
                right: -30,
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Align(
                    alignment: Alignment.topRight,
                    child: CircleAvatar(
                      radius: 18.0,
                      backgroundColor: AppColor.white,
                      child: const Icon(Icons.close, color: Colors.red),
                    ),
                  ),
                ),
              ),
            ],
          ));
    },
  );
}