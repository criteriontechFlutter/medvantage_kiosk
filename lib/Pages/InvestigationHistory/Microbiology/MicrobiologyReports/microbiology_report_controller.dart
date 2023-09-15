
import 'package:digi_doctor/Pages/InvestigationHistory/Microbiology/MicrobiologyReports/microbiology_report_data_model.dart';
import 'package:get/get.dart';

import '../../../../AppManager/app_util.dart';
import '../../../../AppManager/user_data.dart';
import '../../../../main.dart';

class MicrobiologyReportController extends GetxController{
  HttpApp httpApp = HttpApp();
  UserData userData = UserData();

  bool _showNoData = false;
  bool get getShowNoData => _showNoData;
  set updateShowNoData(bool val) {
    _showNoData = val;
    update();
  }

  //for expansion of container
  List<bool> _expandedList = [];
  get getExpandedList =>_expandedList;
  void  updateExpandedList(int index,bool val){
    _expandedList[index] = val;
    update();
  }


  List microbiologyReportList = [].obs;
  List<MicrobiologyReportsData> get getMicrobiologyReportList =>
      List<MicrobiologyReportsData>.from(
          microbiologyReportList.map((element) => MicrobiologyReportsData.fromJson(element)));
  set updateRadiologyReportList(List val) {
    microbiologyReportList = val;
    update();
  }

  Future<void> getMicrobiologyReport(context)async{
    _expandedList.clear();
    updateShowNoData = false;
    var body = {
      "billNo":Get.arguments["billNo"]
    };
    var data = await httpApp.api('InvestigationSubCategoryWise/GetMicrobiologySubCategoryWiseInvestigationsDigiDoctor', body, context,);
    if(data['responseCode']==200){
      updateRadiologyReportList =await data["microbiologySubCategoryWiseInvestigationDetails"];
      updateShowNoData = true;
      _expandedList = List<bool>.filled(getMicrobiologyReportList.length, true);
    }

  }



  @override
  void onInit() {
    getMicrobiologyReport(NavigationService.navigatorKey.currentContext);
    super.onInit();
  }

}