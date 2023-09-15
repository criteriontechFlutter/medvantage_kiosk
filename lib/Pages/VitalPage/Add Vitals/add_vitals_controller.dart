import '../../../Localization/app_localization.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';


class AddVitalsController extends GetxController {
  Rx<TextEditingController> systolicC = TextEditingController().obs;
  Rx<TextEditingController> diastolicC = TextEditingController().obs;
  Rx<TextEditingController> heightC = TextEditingController().obs;
  Rx<TextEditingController> weightC = TextEditingController().obs;



  List<TextEditingController> vitalTextX=[
   TextEditingController(),
   TextEditingController(),
   TextEditingController(),
   TextEditingController(),
  ];


  getVitalsList(context){
    ApplicationLocalizations localization=Provider.of<ApplicationLocalizations>(context,listen: false);
    return [
      {
        'title': localization.getLocaleData.pulseRate.toString(),
        'leading': localization.getLocaleData.pulseRate.toString(),

        'image': 'assets/pulseRate.svg',
        'id': 3,
        'required': true,
      },
      {
        'title': localization.getLocaleData.temperature.toString(),
        'leading': localization.getLocaleData.temperature.toString(),

        'image': 'assets/temperature.svg',
        'id': 5,
        'required': true,
      },
      {
        'title': localization.getLocaleData.spO2.toString(),
        'leading': localization.getLocaleData.spO2.toString(),

        'image': 'assets/spO2.svg',
        'id': 56,
        'required': false,
      },
      {
        'title': localization.getLocaleData.respiratoryRate.toString(),
        'leading': localization.getLocaleData.respiratoryRate.toString(),

        'image': 'assets/respiratoryRate.svg',
        'id': 7,
        'required': false,
      }
    ].obs;
  }


}
