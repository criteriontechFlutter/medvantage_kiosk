
import '../../../Localization/app_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import 'DataModal/supplement_data_modal.dart';

class SupplementIntakeController extends GetxController{


  RxBool showNoData=false.obs;
  bool get getShowNoData=>(showNoData.value);
  set updateShowNoData(bool val){
    showNoData.value=val;
    update();
  }

  getSupplementList(context){
    ApplicationLocalizations localization=Provider.of<ApplicationLocalizations>(context,listen: false);

    return [
      {'time': "8:00\n${localization.getLocaleData.am.toString()}",},
      {'time': "11:00\n${localization.getLocaleData.am.toString()}",},
      {'time': "2:00\n${localization.getLocaleData.pm.toString()}",},
      {'time': "5:00\n${localization.getLocaleData.pm.toString()}",},
      {'time': "8:00\n${localization.getLocaleData.pm.toString()}",},
      {'time': "10:00\n${localization.getLocaleData.pm.toString()}",},

    ];
  }

  //List supplementList=.obs;

  Rx<TextEditingController> onSetDateController = TextEditingController().obs;
  Rx<TextEditingController> nameC = TextEditingController().obs;


  List supplementDetailList = [].obs;

  List<SupplementDetailsDataModal> get getSupplementDetailList=>List<SupplementDetailsDataModal>.from(
      supplementDetailList.map((element) => SupplementDetailsDataModal.fromJson(element))
  );

  set updateSupplementDetailList(List val){
    supplementDetailList=val[0]['supplementDetails'];
    update();
  }


  RxString intakeTimeForApp=''.obs;
  String get getIntakeTimeForApp=>intakeTimeForApp.value;
  set updateIntakeTimeForApp(String val){
    intakeTimeForApp.value=val;
    update();
  }

  RxString foodId=''.obs;
  String get getFoodId=>foodId.value;
  set updateFoodId(String val){
    foodId.value=val;
    update();
  }


  RxInt unitId=0.obs;
  int get getUnitId=>unitId.value;
  set updateUnitId(int val){
    unitId.value=val;
    update();
  }


  RxInt isDose=0.obs;
  int get getIsDose=>isDose.value;
  set updateIsDose(int val){
    isDose.value=val;
    update();
  }


  RxInt quantity=0.obs;
  int get getQuantity=>quantity.value;
  set updateQuantity(int val){
    quantity.value=val;
    update();
  }



}