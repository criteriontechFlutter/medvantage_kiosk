import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LocalData extends GetxController {
  final localStoreData = GetStorage('localData');

  List get getLocalData => localStoreData.read('localStoreData') ?? [];

  addLocalStorageData(
    int id,
    time,
    int MId,
  ) async {
    List temp = getLocalData;
    temp.add({
      "id": id,
      "time": time,
      "MId": MId,
    });
    await localStoreData.write('localStoreData', temp);
    update();
  }

  deleteReminder(int id) async {
    List temp = getLocalData;
    for (int i = 0; i <= temp.length; i++) {
      if (temp[i]['id'] == id) {
        temp.removeAt(i);
      }
    }
    await localStoreData.write('localStoreData', temp);
    update();
  }
}
