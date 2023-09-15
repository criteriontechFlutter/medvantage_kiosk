
import '../../../Localization/app_localization.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../AppManager/progress_dialogue.dart';
import '../../AppManager/raw_api.dart';
import 'local_drawer_list_storage.dart';

class DrawerModal{

  LocalDrawerListStorage controller=Get.put(LocalDrawerListStorage());

  getMenuForApp(context) async {
    ApplicationLocalizations localization=Provider.of<ApplicationLocalizations>(context,listen: false);

    ProgressDialogue().show(context, loadingText: localization.getLocaleData.loading.toString());
    var body = {};
    var data = await RawData().api(
      'Patient/getMenuForApp',
      body,
      context,
      showRetry: false,
    );
    ProgressDialogue().hide();

    if (data['responseCode'] == 1) {
      await LocalDrawerListStorage().addDrawerData(data['responseValue']);



    }
    return data;
  }
}