import '../../../Localization/app_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class HomeIsolationController extends GetxController{
 final formKey=GlobalKey<FormState>().obs;

  RxInt selectedHospitalId=0.obs;
  int get getSelectedHospitalId=>selectedHospitalId.value;
  set updateSelectedHospitalId(int val){
    selectedHospitalId.value=val;
    update();
  }

  RxInt selectedPackageId=0.obs;
  int get getSelectedPackageId=>selectedPackageId.value;
  set updateSelectedPackageId(int val){
    selectedPackageId.value=val;
    update();
  }


  RxInt lifeSupportId=0.obs ;
  int  get getLifeSupportId=>lifeSupportId.value;
  set updateLifeSupportId(int val){
    lifeSupportId.value=val;
    update();
  }

  RxBool isSwitched=false.obs ;
  bool  get getIsSwitched=>isSwitched.value;
  set updateIsSwitched(bool val){
    isSwitched.value=val;
    update();
  }



 getLifeSupport(context){
   ApplicationLocalizations localization=Provider.of<ApplicationLocalizations>(context,listen: false);
   return [
      {
        'life': localization.getLocaleData.ra.toString(),
        'id':1
      },

      {
        'life': localization.getLocaleData.ot.toString(),
        'id':2
      },

     {
       'life': localization.getLocaleData.ov.toString(),
       'id':3
     }

    ];
 }

  getPackageList(context){
    ApplicationLocalizations localization=Provider.of<ApplicationLocalizations>(context,listen: false);
    return [
      {
        'id':1,
        'packageName': localization.getLocaleData.homeCarePackageForSevenDays.toString(),
        'packagePrice': '5999.0'
      },

      {
        'id':2,
        'packageName': localization.getLocaleData.homeCarePackageForDays.toString(),
        'packagePrice': '9999.0'
      },{
        'id':3,
        'packageName': localization.getLocaleData.homeCarePackageForDaysForPerson.toString(),
        'packagePrice': '13999.0'
      },{
        'id':4,
        'packageName': localization.getLocaleData.notSure.toString(),
        'packagePrice': localization.getLocaleData.dependNumberAdmissionDays.toString()
      },

    ];
  }

  Rx<TextEditingController> nameController = TextEditingController().obs;
  Rx<TextEditingController> mobileController = TextEditingController().obs;
  Rx<TextEditingController> hospitalController = TextEditingController().obs;
  Rx<TextEditingController> comorBidController = TextEditingController().obs;
  Rx<TextEditingController> symptomsController = TextEditingController().obs;
  Rx<TextEditingController> onSetDateController = TextEditingController().obs;
  Rx<TextEditingController> packageController = TextEditingController().obs;
  Rx<TextEditingController> pricePackageController = TextEditingController().obs;
  Rx<TextEditingController> covidTestController = TextEditingController().obs;
  Rx<TextEditingController> testTypeController = TextEditingController().obs;
  Rx<TextEditingController> testDateController = TextEditingController().obs;
  Rx<TextEditingController> allergyController = TextEditingController().obs;
  Rx<TextEditingController> lifeSupportController = TextEditingController().obs;
  Rx<TextEditingController> systolicController = TextEditingController().obs;
  Rx<TextEditingController> diastolicController = TextEditingController().obs;
  Rx<TextEditingController> pulseController = TextEditingController().obs;
  Rx<TextEditingController> temperatureController = TextEditingController().obs;
  Rx<TextEditingController> spoController = TextEditingController().obs;
  Rx<TextEditingController> respiratoryController = TextEditingController().obs;

 // List get homeList=>myList;
  List homeIsolation=[].obs;
  List hospitalList=[].obs;
  List get getHomeIsolation=>homeIsolation;
  List get getHospitalList=>hospitalList;

  set updateHomeIsolation(List val){
    homeIsolation=val;
    update();
  }
  set updateHospitalList(List val){
    hospitalList=val;
    update();
  }
  //


  List hospitalPackageList=[].obs;
  List get getHospitalPackageList=>hospitalPackageList;
  set updateHospitalPackageList(List val){
    hospitalPackageList=val;
    update();
  }

//




RxInt covidTestTypeId=0.obs;
  int get getCovidTestTypeId=>covidTestTypeId.value;
  set updateCovidTestTypeId(int val){
    covidTestTypeId.value=val;
    update();
  }

  getTestType(context){
    ApplicationLocalizations localization=Provider.of<ApplicationLocalizations>(context,listen: false);

    return [
      {
        'test': localization.getLocaleData.rtPCR.toString(),
        'id':1
      },

      {
        'test':localization.getLocaleData.truenat.toString(),
        'id':2
      },

      {
        'test': localization.getLocaleData.antigen.toString(),
        'id':3
      },
    ];
  }

  RxString memberId = "".obs;

}


