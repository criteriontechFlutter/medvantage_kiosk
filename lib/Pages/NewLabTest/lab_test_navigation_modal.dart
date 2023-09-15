import '../../AppManager/app_util.dart';
import '../../AppManager/user_data.dart';
import 'lab_test_navigation_controller.dart';
import 'package:get/get.dart';

class LabTestNavigationModal{
  LabTestNavigationController controller = Get.put(LabTestNavigationController());
  HttpApp httpApp = HttpApp();
  UserData userData = UserData();
  onEnterPage(context)async{
    await getEraInvestigation(context);
  }

  getEraInvestigation(context) async {
    controller.eraInvestigationList=[];
    controller.updateShowNoData = false;
    var body = {
      'month' :controller.selectTime.toString(),
      'pid': userData.getUserPid.toString()
    };
    var data = await httpApp.api('Investigation/GetInvestigationBillForDigiDoctor', body, context);
    controller.updateShowNoData= true;
        if(data is Map){
      controller.updateEraInvestigationList =  data['investigationList'];
    }
  }

}