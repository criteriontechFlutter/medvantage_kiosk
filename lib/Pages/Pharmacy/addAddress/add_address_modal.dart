import 'package:digi_doctor/AppManager/alert_dialogue.dart';
import 'package:digi_doctor/AppManager/raw_api.dart';
import 'package:digi_doctor/AppManager/user_data.dart';
import 'package:digi_doctor/Pages/Pharmacy/DigiPharmacyDashboard/pharmacy_dashboard_view.dart';
import 'package:digi_doctor/Pages/Pharmacy/orderSummary/OrderSummaryModal.dart';
import 'package:digi_doctor/Pages/Pharmacy/orderSummary/OrderSummaryView.dart';

import 'package:get/get.dart';

import '../../../../AppManager/app_util.dart';
import '../../../../AppManager/progress_dialogue.dart';

import 'DataModal/addAddress_data_modal.dart';
import 'add_address_controller.dart';
//******************
class AddAddressModal{

  AddAddressController controller=Get.put(AddAddressController());
  AddressFields address=Get.put(AddressFields());
  OrderSummaryModal summaryModal=OrderSummaryModal();
  App app = App();


  void clearTestField() {
    for(int i=0;i< AddressFields.allFields.length;i++){
      AddressFields.allFields[i].controller?.clear();
    }
    controller.update();
  }
  addAddress(context)async{
    ProgressDialogue().show(context, loadingText: 'Submitting Data...');


    var body={
      "memberId": UserData().getUserMemberId.toString(),
      "name": AddressFields.allFields[0].controller!.text.toString(),
      "mobileno":AddressFields.allFields[1].controller!.text.toString(),
      "houseNo": AddressFields.allFields[2].controller!.text.toString(),
      "area": AddressFields.allFields[3].controller!.text.toString(),
      "pincode": AddressFields.allFields[4].controller!.text.toString(),
      "state":AddressFields.allFields[5].controller!.text.toString(),
      "city": AddressFields.allFields[6].controller!.text.toString(),
      "locality":AddressFields.allFields[7].controller!.text.toString(),
      "isDefault":controller.isDefault.value?'1':'0',
      "isSundayOpen":controller.isSundayOpen.value?'1':'0',
      "isSaturdayOpen": controller.isSaturdayOpen.value?'1':'0',
      "addressType":AddressFields.allFields[8].controller!.text.toString(),

    };
    var data=await RawData().api("Pharmacy/addAddress", body, context,token: true);
    print(data.toString());
    ProgressDialogue().hide();
    if(data['responseCode']==1){
      alertToast(context,"Form Saved !!!");
      app.replaceNavigate(context,const PharmacyDashboard());
      clearTestField();
    }
  }

  onPressedSave(context) async {
    if (address.formKey.value.currentState!.validate()) {
        AlertDialogue().show(context,
          msg: 'Are you sure you want to Submit?',
          firstButtonName: 'Confirm',
          showOkButton: false,
          showCancelButton: true,
          firstButtonPressEvent: () async {
            await addAddress(context);
          },);

      }
    else{
      alertToast(context,"Please fill form properly");
    }

  }



  updateAddress(context)async{
    ProgressDialogue().show(context, loadingText: 'Updating Data...');
    var body={
      "addressId":summaryModal.controller.addressId.toString(),
      "memberId":UserData().getUserMemberId.toString(),
      "name": AddressFields.allFields[0].controller!.text.toString(),
      "mobileno":AddressFields.allFields[1].controller!.text.toString(),
      "houseNo": AddressFields.allFields[2].controller!.text.toString(),
      "area": AddressFields.allFields[3].controller!.text.toString(),
      "pincode": AddressFields.allFields[4].controller!.text.toString(),
      "state":AddressFields.allFields[5].controller!.text.toString(),
      "city": AddressFields.allFields[6].controller!.text.toString(),
      "locality":AddressFields.allFields[7].controller!.text.toString(),
      "isDefault":controller.isDefault.value?'1':'0',
      "isSundayOpen":controller.isSundayOpen.value?'1':'0',
      "isSaturdayOpen": controller.isSaturdayOpen.value?'1':'0',
      "addressType":AddressFields.allFields[8].controller!.text.toString(),

    };
    var data=await RawData().api('Pharmacy/updateAddress', body, context,token: true);
    ProgressDialogue().hide();
    if(data['responseCode']==1){
      alertToast(context,"Form updated !!!");
      app.replaceNavigate(context,const OrderSummary());
      clearTestField();
    }


  }


  onPressedUpdate(context) async {
    if (address.formKey.value.currentState!.validate()) {
      AlertDialogue().show(context,
        msg: 'Are you sure you want to Submit?',
        firstButtonName: 'Confirm',
        showOkButton: false,
        showCancelButton: true,
        firstButtonPressEvent: () async {
          await updateAddress(context);
        },);

    }
    else{
      alertToast(context,"Please fill form properly");
    }

  }




}