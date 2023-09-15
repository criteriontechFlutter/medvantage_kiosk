import '../../../Localization/app_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import 'DataModal/top_specialities_data_modal.dart';

class TopSpecController extends GetxController{



  RxBool showNoTopData=false.obs;
  bool get getShowNoTopData=>(showNoTopData.value);
  set updateShowNoTopData(bool val){
    showNoTopData.value=val;
    update();
  }

  RxInt isSelected=0.obs;
  int get getSelectedIndex=>(isSelected.value);
  set updateSelectedIndex(int val){
    isSelected.value=val;
    update();
  }


  getShowList(context){
    ApplicationLocalizations localization=Provider.of<ApplicationLocalizations>(context,listen: false);
    return [
      {
        'image':'assets/ophthalmologist.svg',
        'title': localization.getLocaleData.ophthalmologist.toString(),
        'subTitle': 'Lorem Ipsum has been the industry\'s standard.',

      },
      {
        'image':'assets/physician.svg',
        'title': localization.getLocaleData.physician.toString(),
        'subTitle': 'Lorem Ipsum has been the industry\'s standard'
      },
      {
        'image':'assets/surgeon.svg',
        'title': localization.getLocaleData.surgeon.toString(),
        'subTitle': 'Lorem Ipsum has been the industry\'s standard.'
      },
      {
        'image':'assets/paediatric.svg',
        'title': localization.getLocaleData.paediatricSurgeon.toString(),
        'subTitle': 'Lorem Ipsum has been the industry\'s standard'
      },
      {
        'image':'assets/orthopaedic.svg',
        'title': localization.getLocaleData.orthopaedicSurgeon.toString(),
        'subTitle': 'Lorem Ipsum has been the industry'
      },
      {
        'image':'assets/pediatrician.svg',
        'title': localization.getLocaleData.paediatrician.toString(),
        'subTitle': 'Lorem Ipsum has been the industry\'s standard.'
      },
      {
        'image':'assets/gynecologist.svg',
        'title': localization.getLocaleData.gynecologist.toString(),
        'subTitle': 'Lorem Ipsum has been the industry\'s standard.'
      },
      {
        'image':'assets/childsepec.svg',
        'title': localization.getLocaleData.childSpecialist.toString(),
        'subTitle': 'Lorem Ipsum has been the industry\'s standard.'
      },

    ];
  }




  // List get getTopSpec => showList;

  List topSpecialities = [].obs;

  Rx<bool> showNoData = false.obs;

  Rx<TextEditingController> searchC = TextEditingController().obs;




  List<TopSpecialitiesDataModal> get getTopSpecialities=>List<TopSpecialitiesDataModal>.from(

      topSpecialities
          .map((element) => TopSpecialitiesDataModal.fromJson(element))
  );

  set updateTopSpecialities(List val){
    topSpecialities=val;
    update();
  }

  RxString selectedId=''.obs;
  String get getSelectedId=> selectedId.value;
  set updateSelectedId(String val){
    selectedId.value=val;

  }
  
  
}