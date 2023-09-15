

import 'package:digi_doctor/Pages/Pharmacy/DigiPharmacyDashboard/pharmacy_dashboard_controller.dart';
import 'package:get/get.dart';

import '../../../../AppManager/raw_api.dart';
import '../../../../AppManager/user_data.dart';
import '../cart_controller.dart';

class PharmacyDashboardModal {
  PharmacyDashboardController controller =
      Get.put(PharmacyDashboardController());
  CartController cartController = Get.put(CartController());

  Future<void> getPharmacyDashboard(context) async {
    controller.updateShowNoData = false;
    var body = {
      "memberId": UserData().getUserMemberId.toString(),
    };
    var data = await RawData()
        .api("Pharmacy/patientDasboard", body, context, token: true);
    controller.updateShowNoData = true;
    if (data["responseCode"] == 1) {
      controller.updateCategoryList = data['responseValue'];
    }
    //log('--------------------------'+data.toString());
  }

  Future<void> cartCount(context) async {
    var body = {
      "memberId": UserData().getUserMemberId.toString(),
    };
    var data =
        await RawData().api("Pharmacy/cartCount", body, context, token: true);
    if (data["responseCode"] == 1) {
     // controller.updateCartCount=data['responseValue'][0]['cartCount'];
      cartController.updateCartCount =data['responseValue'][0]['cartCount'];
    }
  }
}
