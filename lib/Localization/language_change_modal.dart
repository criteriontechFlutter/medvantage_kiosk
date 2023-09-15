


import 'package:digi_doctor/AppManager/raw_api.dart';
import 'package:digi_doctor/Localization/language_change_controller.dart';
import 'package:get/get.dart';

class LanguageChangeModal{
  LanguageChangeController controller=Get.put(LanguageChangeController());

 getLanguageKeyList(context) async {

   var body={
     'langKeyID':'',
     'languageID':'',
  };
   var data=await RawData().api('LanguageKey/GetLanguageKeyList', body, context);
   if(data['responseCode']==1){
     controller.updateLangList=data['responseValue']['table'];
     print('---------------------------'+controller.getLangList.toString());
   }
}

}