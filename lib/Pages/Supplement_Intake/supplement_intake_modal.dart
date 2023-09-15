import '../../../Localization/app_localization.dart';
import 'package:digi_doctor/AppManager/alert_dialogue.dart';
import 'package:digi_doctor/AppManager/progress_dialogue.dart';
import 'package:digi_doctor/AppManager/raw_api.dart';
import 'package:digi_doctor/AppManager/user_data.dart';
import 'package:digi_doctor/Pages/Supplement_Intake/supplement_intake_controller.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class SupplementIntakeModal{
  SupplementIntakeController controller=Get.put(SupplementIntakeController());

  Future<void> getSupplementDetail(context)async{
   controller.updateShowNoData=false;
    var body=
      {
        "intakeDate":DateFormat('yyyy-MM-dd').format(DateFormat('yyyy-MM-dd').parse(controller.onSetDateController.value.text)),
        "memberId":UserData().getUserMemberId,
        "userMobileNo":UserData().getUserMobileNo,
      };

    var data=await RawData().api('covidSupplementChecklist', body, context,isNewBaseUrl: true);
    print('nnnnnnnnnnnnnnnnnnnn'+data.toString());
   controller.updateShowNoData=true;
    if(data['responseCode']==1){
      controller.updateSupplementDetailList = data['responseValue'];
    }
    print(data);
  }

  Future<void> postSupplementDetail(context)async{
    ApplicationLocalizations localization=Provider.of<ApplicationLocalizations>(context,listen: false);
   ProgressDialogue().show(context, loadingText: localization.getLocaleData.addingData.toString());
    var body={
      "foodId":controller.getFoodId.toString(),
      "intakeDate":controller.onSetDateController.value.text,
      "intakeTime":controller.intakeTimeForApp.toString(),
      "memberId":UserData().getUserMemberId.toString(),
      "quantity":controller.getQuantity.toString(),
      "unitId":controller.getUnitId.toString(),
      "userMobileNo":UserData().getUserMobileNo.toString()};
    print(body.toString());

    var data=await RawData().api('insertCovidSupplement', body, context,isNewBaseUrl: true);
   ProgressDialogue().hide();
    if(data['responseCode']==1){
      await getSupplementDetail(context);
      alertToast(context, localization.getLocaleData.dataAddedSuccessfully.toString());
    }
  }


}