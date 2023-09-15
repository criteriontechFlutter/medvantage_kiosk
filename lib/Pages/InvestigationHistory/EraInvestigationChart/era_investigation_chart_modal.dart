import 'dart:developer';
import '../../../../AppManager/app_util.dart';
import '../../../../AppManager/user_data.dart';
import 'era_investigation_chart_controller.dart';
import 'package:get/get.dart';

class EraddInvestigationChartModal {
  EraInvestigationChartControllerss controller =
      Get.put(EraInvestigationChartControllerss());

  getChartData(context) async {
    controller.updateShowNoData=false;
    var body = {
        'PID': UserData().getUserPid.toString(),
      // 'PID':'1000533',
        'id': controller.getSelectedId.toString(),
      // 'billNo': 'null',
      'searchKey': "All"
    };
    var data = await App().api(
        'InvestigationSubCategoryWise/GetGraphByTestIdSubCategoryWise',
        body,
        context,
        isNewUrl: true,
        newBaseUrl: 'http://182.156.200.179:201/api/',
        );

    controller.updateShowNoData=true;
    log('*******' + data.toString());
    controller.updateEraInvestigationChart = data['graphResult'];
  }
}
