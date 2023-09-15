
import 'package:digi_doctor/AppManager/alert_dialogue.dart';
import 'package:digi_doctor/AppManager/raw_api.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../../Localization/app_localization.dart';
import 'hospital_controller.dart';

class HospitalModal {
  HospitalController controller = Get.put(HospitalController());


  getHospitalClinicDetail(context) async {
    controller.updateShowNoData = false;
    var body = {
      "id": controller.getHospitalId.toString(),
    };
    print("**5" + body.toString());
    var data = await RawData()
        .api('Patient/getHospitalClinicDetails', body, context, token: true);
    controller.updateShowNoData = true;
    if (data['responseCode'] == 1) {
      controller.updateDoctorList = data['responseValue'];
    }
    print("**********" + data.toString());
  }

  onPressedOtpn(context) {
    ApplicationLocalizations localization=Provider.of<ApplicationLocalizations>(context,listen: false);
    switch (controller.getDocList.toString()) {
      case "Doctors":
        break;
      case 'Services':
        break;
      case 'Speciality':
        alertToast(context, localization.getLocaleData.alertToast!.comingSoon);
        break;
      case 'Reviews':
        alertToast(context, localization.getLocaleData.alertToast!.comingSoon);
        break;
    }
  }
}
