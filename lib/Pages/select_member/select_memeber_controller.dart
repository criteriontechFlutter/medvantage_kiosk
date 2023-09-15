
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../Localization/app_localization.dart';
import 'DataModal/select_member_data_modal.dart';

class SelectMemberController extends GetxController{
//**
  List<OptionDataModals> getOption(context){
    ApplicationLocalizations localization = Provider.of<
        ApplicationLocalizations>(context, listen: false);
    return [
      OptionDataModals(
        optionIcon  :"assets/kiosk_setting.png",
        optionText: "Select Member",
        // route: TopSpecialitiesView(),
      ),
      // OptionDataModals(
      //   optionIcon: "assets/kiosk_symptoms.png",
      //   optionText:  localization.getLocaleData.hintText!.bySymptoms.toString(),
      //   // route:
      // )
    ];

  }
  RxBool showNoData=false.obs;
  bool get getShowNoData=>(showNoData.value);
  set updateShowNoData(bool val){
    showNoData.value=val;
    update();
  }


  List selectMember = [].obs;
  List<SelectMemberDataModal> get getSelectMember=>List<SelectMemberDataModal>.from(
      selectMember.map((element) => SelectMemberDataModal.fromJson(element))
  );
  set updateSelectMember(List val){
    selectMember=val;
    update();
  }

  RxString selectedMemberId=''.obs;
  String get getSelectedMemberId=>selectedMemberId.value;
  set updateSelectedMemberId(String val){
    selectedMemberId.value=val;
    update();
  }
}

class OptionDataModals{
  String?optionText;
  String?optionIcon;
  Widget?route;

  OptionDataModals({
    this.optionText,
    this.optionIcon,
    this.route
  });

}