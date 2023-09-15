import 'package:digi_doctor/AppManager/app_color.dart';
import 'package:digi_doctor/AppManager/widgets/my_app_bar.dart';
import 'package:digi_doctor/AppManager/widgets/my_button.dart';
import 'package:digi_doctor/Pages/Pharmacy/AddAddress/add_address_modal.dart';
import 'package:digi_doctor/Pages/Pharmacy/orderSummary/OrderSummaryModal.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../../AppManager/widgets/my_text_field_2.dart';
import '../AddAddress/DataModal/addAddress_data_modal.dart';
import 'add_address_controller.dart';

class AddAddress extends StatefulWidget {
  final int addressId;
  const AddAddress( {Key? key,required this.addressId, }) : super(key: key);

   // final int productId;
  //   const ProductDetails({Key? key, required this.productId}) : super(key: key);

  @override
  _AddAddressState createState() => _AddAddressState();
}

class _AddAddressState extends State<AddAddress> {
  AddAddressModal modal=AddAddressModal();
  OrderSummaryModal summaryModal=OrderSummaryModal();


  get() {


    if(widget.addressId!=0) {
      AddressFields.allFields[0].controller!.text = summaryModal.controller.getAddress[0].name.toString(); //name
      AddressFields.allFields[1].controller!.text =
          summaryModal.controller.getAddress[0].mobileNo
              .toString(); //locality//mobile
      AddressFields.allFields[2].controller!.text =
          summaryModal.controller.getAddress[0].houseNo.toString();
      AddressFields.allFields[3].controller!.text =
          summaryModal.controller.getAddress[0].area.toString();
      AddressFields.allFields[4].controller!.text =
          summaryModal.controller.getAddress[0].pincode.toString(); //pincode
      AddressFields.allFields[5].controller!.text =
          summaryModal.controller.getAddress[0].state.toString(); //state
      AddressFields.allFields[6].controller!.text =
          summaryModal.controller.getAddress[0].city.toString(); //city
      AddressFields.allFields[7].controller!.text =
          summaryModal.controller.getAddress[0].locality.toString(); //locality
      AddressFields.allFields[8].controller!.text =
          summaryModal.controller.getAddress[0].addressType
              .toString(); //addressType
      // AddressFields.allFields[9].controller!.text=summaryModal.controller.getAddress[0].isSundayOpen.toString();//isSundayOpen
      // AddressFields.allFields[10].controller!.text=summaryModal.controller.getAddress[0].isSaturdayOpen.toString();//isSaturdayOpen
      // AddressFields.allFields[11].controller!.text=summaryModal.controller.getAddress[0].isDefault.toString();//isDefault
    }
    else{
      for(int i=0;i<AddressFields.allFields.length;i++){
        AddressFields.allFields[i].controller!.clear();
      }
    }




  }

@override
void initState(){
    get();
    super.initState();
}

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    Get.delete<AddAddressController>();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: MyWidget().pharmacyAppBar(context,title:widget.addressId==0? "Add Address":'Update Address'),
        body:GetBuilder(
          init: AddAddressController(),
          builder: (_){
            return Form(
              key: modal.address.formKey.value,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child:  Column(
                children: [
                 // Text(widget.addressId.toString()),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(8, 20, 8, 0),
                      child: SingleChildScrollView(
                        child: Column(
                        children: [
                          ListView.separated(
                            shrinkWrap: true,
                            physics:NeverScrollableScrollPhysics(),
                            itemCount: AddressFields.allFields.length,itemBuilder:(BuildContext context,int index){
                            AddressFields field=AddressFields.allFields[index];

                            return Padding(
                              padding: const EdgeInsets.all(8.0),


                              child: MyTextField2(
                                controller:field.controller,
                                validator:(value){
                                  if(value!.isEmpty){
                                    return "Enter your ${field.lableName}";
                                  }
                                  else{
                                    return null;
                                  }
                                },
                                //***********
                               keyboardType: field.lableName!="Mobile No."?TextInputType.text:TextInputType.number,
                               maxLength: field.lableName.toString()=="Mobile No."?10:100,
                                inputFormatters: field.lableName=="Mobile No."? [
                                FilteringTextInputFormatter.allow(
                                  RegExp(r'[0-9]')),
                                ]:[],

                                 label: Row(
                                  children: [
                                   // fields.icon,
                                    //Text(field.icon.icon),
                                    const SizedBox(width: 5,),
                                    Expanded(child: Text(field.lableName.toString()))
                                  ],
                                ),
                                hintText: field.hintText.toString(),
                              ),
                            );
                          },
                          separatorBuilder: (BuildContext context,int index){
                            return const SizedBox(height:5);
                          },),
                          Row(
                            children: [

                              Checkbox(
                                 checkColor:AppColor.lightGreen2,
                                activeColor: AppColor.primaryColor,
                                value: modal.controller.isSundayOpen.value,
                                onChanged: (bool? value) {

                                  setState(() {
                                    if(value!){
                                      modal.controller.isSundayOpen.value=value;

                                    }
                                    else{
                                      modal.controller.isSundayOpen.value=value;

                                    }
                                  });

                                },
                              ),
                              const Text("Is Sunday Open"),
                            ],
                          ),
                          Row(
                            children: [

                              Checkbox(
                                 checkColor:AppColor.lightGreen2,
                                activeColor: AppColor.primaryColor,
                                value:modal.controller.isSaturdayOpen.value,
                                onChanged: (bool? value) {
                                   setState(() {
                                     if(value!){
                                       modal.controller.isSaturdayOpen.value=value;
                                     }
                                     else {
                                       modal.controller.isSaturdayOpen.value=value;
                                     }
                                   });

                                },
                              ),
                              const Text("Is Saturday Open"),

                            ],
                          ),
                          Row(
                            children: [
                              Checkbox(
                                 checkColor: AppColor.lightGreen2,
                                activeColor: AppColor.primaryColor,
                                value: modal.controller.isDefault.value,
                                onChanged: (bool? val) {

                                   setState(() {
                                     if(val!){
                                       modal.controller.isDefault.value=val;
                                     }
                                     else{
                                       modal.controller.isDefault.value=val;
                                     }
                                   });
                                },
                              ),
                               Text("IsDefault"),
                              // TextButton(onPressed: null, child:Text("hkh"),style:TextButton.styleFrom(backgroundColor: Colors.red,elevation: 2,s),)
                            ],
                          ),

                        ],
            ),
                      ),
                    ),
                  ),
                  //summaryModal.controller.getAddress==''?,
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child:widget.addressId==0?
                        MyButton(
                        title: 'Submit',
                        onPress: () async{
                         //await modal.addAddress(context);
                          await modal.onPressedSave(context);
                        })
                        : MyButton(
                        title: 'Update',
                        onPress: ()async {
                          await modal.onPressedUpdate(context);
                          //addAddress(context);
                        })

                  )
                ],
              ),);
          },
        )
      ),
    );
  }
}
