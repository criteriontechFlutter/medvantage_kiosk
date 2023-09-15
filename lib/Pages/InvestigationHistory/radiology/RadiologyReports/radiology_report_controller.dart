import 'package:digi_doctor/Pages/InvestigationHistory/radiology/RadiologyReports/radiology_report_data_model.dart';
import 'package:get/get.dart';

import '../../../../AppManager/app_util.dart';
import '../../../../AppManager/user_data.dart';
import '../../../../main.dart';
import '../../DataModal/radiology_data_modal.dart';

class RadiologyReportController extends GetxController{
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


//radiology report list if type is 3 from previous api
  List _radiologyReportList = [].obs;
  List<RadiologyReportsData> get getRadiologyReportList =>
      List<RadiologyReportsData>.from(
          _radiologyReportList.map((element) => RadiologyReportsData.fromJson(element)));
  set updateRadiologyReportList(List val) {
    _radiologyReportList = val;
    update();
  }
//pacs data list if type is 4
  List radiologyList = [].obs;
  List<RadiologyDataModal> get getRadiologyList =>
      List<RadiologyDataModal>.from(
          radiologyList.map((element) => RadiologyDataModal.fromJson(element)));
  set updateRadiologyList(List val) {
    radiologyList = val;
    update();
  }

  //*****Api part******
  //radiology api if type is 3
  Future<void> getRadioLogyReport(context)async{
    _expandedList.clear();
    updateShowNoData = false;
    var body = {"collectionDate":Get.arguments["collectionDate"],
      "subCategoryID":Get.arguments["subCategoryID"].toString(),
      "categoryID":Get.arguments["categoryID"].toString(),
      "PID":userData.getUserPid.toString()
    };
    var data = await httpApp.api('InvestigationSubCategoryWise/GetRadioSubcategoryWiseInvestigationDetailsDigiDoctor', body, context,);
    //print("############# $data");
    if(data['responseCode']==200){
      updateRadiologyReportList =await data["radioSubcategoryWiseInvestigationDetails"];
      updateShowNoData = true;
      _expandedList = List<bool>.filled(getRadiologyReportList.length, true);
      //print("##############${getExpandedList}");
    }

  }

//pacs api
  Future<void> getRadiologyPacsReport(context) async {
    updateShowNoData = false;
    var body = {
       "pid": userData.getUserPid.toString(),
      "userId":"1234567"
    };
    print(body.toString());
    var data = await HttpApp().api('ICUDailyChart/GetPACSURL', body, context);

    print('--------------'+data.toString());
    if (data['responseCode'] == 200) {
      updateRadiologyList = data['pacsData'] ?? [];
      updateShowNoData = true;
    }
  }

  @override
  void onInit() {
    Get.arguments["type"]==3?getRadioLogyReport(NavigationService.navigatorKey.currentContext)
        :getRadiologyPacsReport(NavigationService.navigatorKey.currentContext);
    super.onInit();
  }
}