

import '../../../../AppManager/app_util.dart';
import '../../../../AppManager/user_data.dart';
import 'package:get/get.dart';

import 'new_chart_controller.dart';

class NewChartModal {
  HttpApp httpApp = HttpApp();
  UserData userData = UserData();


  getGraphData(context) async {
    //controller.showNoData;
    var body = {
      "PID": userData.getUserPid.toString(),
      "billNo": "",
      "id": Get.arguments["id"].toString(),
      "searchKey": "Sub"
    };
    var data = await httpApp.api(
        'InvestigationSubCategoryWise/GetGraphByTestIdSubCategoryWise', body,
        context);
    Get.find<NewChartController>().showNoData.value = true;
    Get.find<NewChartController>().updateChartData = data['graphResult'];
  }
}