import '../../../Localization/app_localization.dart';
import 'package:digi_doctor/AppManager/alert_dialogue.dart';
import 'package:digi_doctor/AppManager/app_util.dart';
import 'package:digi_doctor/Pages/VitalPage/Modules/vital_trends_module.dart';
import 'package:digi_doctor/Pages/VitalPage/vital.controller.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import 'Add Vitals/add_vitals_view.dart';
import 'LiveVital/device_view.dart';

class VitalModal {
  VitalController controller = Get.put(VitalController());

  onPressedVitalOption(context,Val) {
    ApplicationLocalizations localization=Provider.of<ApplicationLocalizations>(context,listen: false);
    switch (Val) {
      case 0:
        App().navigate(context, const AddVitalsView(),);
        break;
      case 1:
        vitalTrendsModule(context);
        // App().navigate(context, VitalTrendsView(),);
        break;
      case 2:
        //App().navigate(context, const DeviceView(),);
        break;
      case 3:
        alertToast(context, 'Coming soon');
        break;
      case 4:
        alertToast(context, 'Coming soon');
        break;
      default:
    }
  }

}
