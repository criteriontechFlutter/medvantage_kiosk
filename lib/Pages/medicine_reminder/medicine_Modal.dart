import 'package:get/get.dart';
import '../../AppManager/app_util.dart';
import '../../AppManager/raw_api.dart';
import '../../AppManager/user_data.dart';
import 'medicine_Controller.dart';

class MedicineModal {
  MedicineController controller = Get.put(MedicineController());

  App app = App();
  UserData user = UserData();

  Future<void> medicineReminder(context) async {
    controller.updateShowNoData = false;
    var body = {
      "memberId": UserData().getUserMemberId.toString(),
    };
    var data =
        await RawData().api('Patient/medicineReminderList', body, context);

    controller.updateShowNoData = true;
    if (data['responseCode'] == 1) {
      controller.updateMedicineList = data['responseValue'];
    }
  }
}
