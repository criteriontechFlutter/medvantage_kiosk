import 'package:digi_doctor/Pages/Pharmacy/allProduct/SortModule/sort_product_module.dart';
import 'package:flutter/material.dart';

import '../../../AppManager/app_color.dart';
import '../../../AppManager/widgets/MyCustomSD.dart';
import '../../../AppManager/widgets/my_button.dart';
import '../../../AppManager/widgets/my_text_field_2.dart';
import '../../VitalPage/LiveVital/stetho_master/AppManager/widgets/date_time_field.dart';
import 'NewBookAppointmentModal.dart';

class NewBookAppointment extends StatefulWidget {
  final doctorName;
  final doctorId;
  const NewBookAppointment({super.key, this.doctorName, this.doctorId });

  @override
  State<NewBookAppointment> createState() => _NewBookAppointmentState();
}

class _NewBookAppointmentState extends State<NewBookAppointment> {
  NewBookAppointmentModal modal = NewBookAppointmentModal();
  List abc  =[
    {
      "id":1,
      "name":"faheem"
    },
    {
      "id":2,
      "name":"faheem"
    },
    {
      "id":3,
      "name":"faheem"
    },
    {
      "id":4,
      "name":"faheem"
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(image: AssetImage("assets/kiosk_bg_img.png",),fit: BoxFit.fitHeight)
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              const SizedBox(height: 15,),
              Row(
                mainAxisAlignment: MainAxisAlignment
                    .spaceAround,
                crossAxisAlignment: CrossAxisAlignment
                    .start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment
                          .start,
                      children: [
                        const Text("Patient Name",
                            style: TextStyle(
                              fontSize: 18,
                              )),
                         const SizedBox(height: 5,),
                        SizedBox(
                          child: MyTextField2(
                            //controller: modal2.controller.mobileController.value,
                            hintText: 'Patient Name',
                            controller: modal.controller.nameController.value,
                            validator: (value) {
                              // if (value!.isEmpty) {
                              //   return localization.getLocaleData
                              //       .validationText!
                              //       .mobileNumber10Digits.toString();
                              // }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 10,),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment
                          .start,
                      children: [
                        const Text("UHID",
                            style: TextStyle(
                              fontSize: 18,
                            )),
                        const SizedBox(height: 5,),
                        SizedBox(
                          // height: 40,
                          child: MyTextField2(
                            //controller: modal2.controller.mobileController.value,
                            hintText: 'UHID',
                            controller: modal.controller.uhidController.value,
                            validator: (value) {
                              // if (value!.isEmpty) {
                              //   return localization.getLocaleData
                              //       .validationText!
                              //       .mobileNumber10Digits.toString();
                              // }
                              return null;
                            },
                          ),
                        )
                      ],),
                  )
                ],),
              const SizedBox(height: 15),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Department',style: TextStyle(
                          fontSize: 18, ),),
                        const SizedBox(height: 5,),
                        MyCustomSD(
                          borderColor: AppColor
                              .greyLight,
                          listToSearch: abc,
                          hideSearch: true,
                          valFrom: 'gen',
                          height: 70,
                          label: modal.controller.getDepartment,
                          initialValue: [
                            // {
                            //   'parameter': 'gen',
                            //   'value': modal2
                            //       .controller
                            //       .genderController
                            //       .value.text,
                            // },
                          ],
                          onChanged: (val) {
                            if (val != null) {
                              //modal2.controller.selectedGenderC.value.text = val['id'];
                              //print(val['id']);
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 20,),
                  Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Doctor Name', style: TextStyle(
                            fontSize: 18,),),
                          const SizedBox(height: 5,),
                          MyCustomSD(
                            borderColor: AppColor
                                .greyLight,
                            listToSearch: abc,
                            hideSearch: true,
                            valFrom: 'name',
                            height: 70,
                            label: widget.doctorName,
                            initialValue: [
                              // {
                              //   'parameter': 'gen',
                              //   'value': modal2
                              //       .controller
                              //       .genderController
                              //       .value.text,
                              // },
                            ],
                            onChanged: (val) {
                              if (val != null) {
                                //modal2.controller.selectedGenderC.value.text = val['id'];
                                //print(val['id']);
                              }
                            },
                          ),
                        ],
                      )
                  )
                ],
              ),

              const SizedBox(height: 15,),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Text('${localization.getLocaleData.hintText?.id.toString()}',
                        //     style: const TextStyle(
                        //       fontSize: 18, color: Colors.white,)),
                        const Text("Appointment Date",style:TextStyle(
                          fontSize: 18,) ,),
                        const SizedBox(height: 6,),
                        MyDateTimeField(
                          hintText: DateTime.now()
                              .toString(),
                          prefixIcon: const Icon(
                              Icons.cake),
                          borderColor: AppColor
                              .greyLight,
                          // controller: modal2.controller
                          //     .dobController.value,
                          validator: (value) {
                            return null;

                            // if (value!.isEmpty) {
                            //   return localization
                            //       .getLocaleData
                            //       .validationText!
                            //       .pleaseEnterYourDOB
                            //       .toString();
                            // }
                          },
                          onChanged: (val){
                            modal.controller.updateTime = val.toString();
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 20,),

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Text('${localization.getLocaleData.hintText?.address.toString()}',
                        //     style: const TextStyle(
                        //       fontSize: 18, color: Colors.white,)),
                        const Text("Time Slots",style: TextStyle(
                          fontSize: 18, ),),
                        const SizedBox(height: 5,),
                        MyCustomSD(
                          borderColor: AppColor
                              .greyLight,
                          listToSearch: abc,
                          hideSearch: true,
                          valFrom: 'name',
                          height: 70,
                          label: "Time Slots",
                          initialValue: [
                            // {
                            //   'parameter': 'gen',
                            //   'value': modal2
                            //       .controller
                            //       .genderController
                            //       .value.text,
                            // },
                          ],
                          onChanged: (val) {
                            if (val != null) {

                              //modal2.controller.selectedGenderC.value.text = val['id'];
                              //print(val['id']);
                            }
                          },
                        ),
                      ],
                    ),
                  )

                ],
              ),
              const SizedBox(height: 50,),

              Align(
                alignment: Alignment.centerRight,
                child: SizedBox(
                    width: 200,
                    child: MyButton(title:"Book Appointment",height: 50,
                      onPress: (){
                        modal.bookAppointment(context);
                      },

                    )),
              )
            ],
          ),
        ),
      ),

    );
  }
}
