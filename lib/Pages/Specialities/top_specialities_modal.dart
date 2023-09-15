import 'package:digi_doctor/AppManager/app_util.dart';
import 'package:digi_doctor/AppManager/raw_api.dart';
import 'package:digi_doctor/Pages/Specialities/SpecialistDoctors/search_specialist_doctor_view.dart';
import 'package:digi_doctor/Pages/Specialities/top_specialities_controller.dart';
import 'package:get/get.dart';

import '../../SignalR/raw_data_83.dart';

class TopSpecModal {
  TopSpecController controller = Get.put(TopSpecController());

  onPressedSpecialities(
    context,
  ) async {
    await App().navigate(context, const SearchDoctors());
  }

  Future<void> getSpecialities(context) async {
    controller.updateShowNoTopData = false;
    var body = {'isEmergency': '0'};
    var data = await RawData83().getapi('/api/DepartmentMaster/GetAllDepartmentMaster',{});
    print(data);
  //  var data = await RawData().api('Patient/getAllDepartment', body, context, token: true);
    controller.updateShowNoTopData = true;

    for (int i = 0; i < data['responseValue'].length; i++) {
      data['responseValue'][i].addAll({
        'isSelected': false,
      });
    }
    controller.updateTopSpecialities = data['responseValue'];
  }
}
