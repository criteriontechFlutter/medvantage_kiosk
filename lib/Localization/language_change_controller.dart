

import 'package:get/get.dart';

class LanguageChangeController extends GetxController{
 //  var languageList=  GetStorage('langList');
 // List get getUserData => languageList.read('langList') ?? [];
 //
 //  addUserData(List val) async {
 //    await languageList.write('langList', val);
 //    update();
 //  }


  List langList=[].obs;
  List get getLangList=>langList;
  set updateLangList(List val){
    langList=val;
    update();
  }


}