
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LocalDrawerListStorage extends GetxController {
  final userData = GetStorage('drawerData');




  List get getDrawerList => userData.read('drawerData') ?? [];


  addDrawerData(List val) async {
    await userData.write('drawerData', val);
    update();
  }




  removeDrawerData() async{
    await userData.remove('drawerData');
  }



}
