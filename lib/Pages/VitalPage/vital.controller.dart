


import '../../../Localization/app_localization.dart';
import 'package:digi_doctor/Pages/VitalPage/Add%20Vitals/add_vitals_view.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../AppManager/app_color.dart';

class VitalController extends GetxController{


  getVitalCardList(context){
    ApplicationLocalizations localization=Provider.of<ApplicationLocalizations>(context,listen: false);
    return [
      {
        'title': localization.getLocaleData.inputVitals.toString(),
        'subTitle':localization.getLocaleData.inputYourVitals.toString(),
        'img':'assets/addManually.svg',
        'onPressed':const AddVitalsView(),
      },
      {
        'title': localization.getLocaleData.vitalTrends.toString(),
        'subTitle': localization.getLocaleData.vitalHistoryGraph.toString(),
        'img':'assets/vitalTrends.svg',
        'onPressed':const AddVitalsView(),
      },
      {
        'title': localization.getLocaleData.getLiveVital.toString(),
        'subTitle': localization.getLocaleData.getVitalViaMachine.toString(),
        'img':'assets/getLiveVital.svg',
        'onPressed':const AddVitalsView(),
      },
      {
        'title': localization.getLocaleData.digi_doctorscope.toString(),
        'subTitle': localization.getLocaleData.getdigi_doctorscopeData.toString(),
        'img':'assets/getLiveVital.svg',
        'onPressed':const AddVitalsView(),
      },
      {
        'title': localization.getLocaleData.laryngoscope.toString(),
        'subTitle':localization.getLocaleData.getLaryngoscopeData.toString(),
        'img':'assets/getLiveVital.svg',
        'onPressed':const AddVitalsView(),
      },
    ];
  }

  // List vitalCardList=.obs;


  Map selectVitals = {}.obs;

  get getSelectVitals => selectVitals;
  set updateSelectVitals(Map val){
    selectVitals=val;
    update();
  }


  getVitalTrends(context){
    ApplicationLocalizations localization=Provider.of<ApplicationLocalizations>(context,listen: false);

    return [
      {
        'tittle' : localization.getLocaleData.bloodPressure.toString(),
        'image' : 'assets/bpChart.svg',
        'icon' : 'assets/arrow_forward.svg',
        'color' : AppColor.lightYellowColor,
        'id' : -1,
        'iconColor' : AppColor.orangeButtonColor
      },
      {
        'tittle' : localization.getLocaleData.pulseRate.toString(),
        'image' : 'assets/pulse_rate2.svg',
        'icon' : 'assets/arrow_forward.svg',
        'color' : AppColor.lightPurple,
        'id' : 3,
        'iconColor' : AppColor.purple
      },
      {
        'tittle' : localization.getLocaleData.spO2.toString(),
        'image' : 'assets/spo_2.svg',
        'icon' : 'assets/arrow_forward.svg',
        'color' : AppColor.lightBlue,
        'id' : 56,
        'iconColor' : AppColor.primaryColor
      },
      {
        'tittle' : localization.getLocaleData.respiratoryRate.toString(),
        'image' : 'assets/lungs.svg',
        'icon' : 'assets/arrow_forward.svg',
        'color' : AppColor.lightPurple,
        'id' : 7,
        'iconColor' : AppColor.purple
      },
      {
        'tittle' : localization.getLocaleData.temperature.toString(),
        'image' : 'assets/temperature.svg',
        'icon' : 'assets/arrow_forward.svg',
        'color' : AppColor.lightRed,
        'id' : 5,
        'iconColor' : AppColor.red
      },
    ];
  }

  // final List vitalTrends = .obs;

}