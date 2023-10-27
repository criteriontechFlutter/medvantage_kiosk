import 'package:digi_doctor/Pages/Pharmacy/allProduct/SortModule/sort_product_module.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:get_storage/get_storage.dart';
import '../../../AppManager/app_color.dart';
import '../../../AppManager/widgets/MyCustomSD.dart';
import '../../../AppManager/widgets/my_button.dart';
import '../../../AppManager/widgets/my_text_field_2.dart';
import '../../VitalPage/LiveVital/stetho_master/AppManager/widgets/date_time_field.dart';
import 'NewBookAppointmentController.dart';
import 'NewBookAppointmentModal.dart';

class NewBookAppointment extends StatefulWidget {
  final doctorName;
  final departmentId;
  final doctorId;
  final timeSlot;
  final timeSlotId;
  final date;
  final day;
  final dayid;
  const NewBookAppointment({super.key, this.doctorName, this.doctorId, this.departmentId ,this.timeSlot,this.date,this.day,this.timeSlotId,this.dayid});

  @override
  State<NewBookAppointment> createState() => _NewBookAppointmentState();
}

class _NewBookAppointmentState extends State<NewBookAppointment> {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //modal.getTimeSlots(context, dayId: '', drId: '',);
    modal.getDays(context,widget.doctorId.toString());
  }
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
    final medvantageUser = GetStorage();
    var name = medvantageUser.read('medvantageUserName');
    var uhid = medvantageUser.read('medvantageUserUHID');
    return Scaffold(
      body:  GetBuilder(
          init: NewBookAppointmentController(),
          builder: (_) {
          return Container(
            decoration: const BoxDecoration(
                image: DecorationImage(image: AssetImage("assets/kiosk_bg_img.png",),fit: BoxFit.fitHeight)
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 25),
              child: Center(
                child: SizedBox(
                  width: Get.width/1.5,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [


                              const Text("Patient Name",
                                  style: TextStyle(
                                    fontSize: 18,
                                    )),
                               const SizedBox(height: 5),
                              SizedBox(
                                child: MyTextField2(
                                  enabled: false,
                                  //controller: modal2.controller.mobileController.value,
                                  hintText: name,
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

                      const SizedBox(height: 15),

                              const Text("UHID",
                                  style: TextStyle(
                                    fontSize: 18,
                                  )),
                              const SizedBox(height: 5),
                              SizedBox(
                                // height: 40,
                                child: MyTextField2(
                                  enabled: false,
                                  //controller: modal2.controller.mobileController.value,
                                  hintText: uhid,
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
                              ),

                      const SizedBox(height: 15),

                              const Text('Doctor Name', style: TextStyle(
                                fontSize: 18,),),
                              const SizedBox(height: 5,),
                      MyTextField2(
                        enabled: false,
                        //controller: modal2.controller.mobileController.value,
                        hintText: widget.doctorName,
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

                      const SizedBox(height: 15),

                              // Text('${localization.getLocaleData.hintText?.id.toString()}',
                              //     style: const TextStyle(
                              //       fontSize: 18, color: Colors.white,)),
                              const Text("Appointment Date",style:TextStyle(
                                fontSize: 18,) ,),
                              const SizedBox(height: 6,),
                  MyTextField2(
                    enabled: false,
                    //controller: modal2.controller.mobileController.value,
                    hintText: widget.date,
                   // controller: modal.controller.uhidController.value,
                    validator: (value) {
                      // if (value!.isEmpty) {
                      //   return localization.getLocaleData
                      //       .validationText!
                      //       .mobileNumber10Digits.toString();
                      // }
                      return null;
                    },
                  ),
                  const SizedBox(height: 15),

                              // Text('${localization.getLocaleData.hintText?.id.toString()}',
                              //     style: const TextStyle(
                              //       fontSize: 18, color: Colors.white,)),
                              const Text("day",style:TextStyle(
                                fontSize: 18,) ,),
                              const SizedBox(height: 6,),
                  MyTextField2(
                    enabled: false,
                    //controller: modal2.controller.mobileController.value,
                    hintText: widget.day,
                   // controller: modal.controller.uhidController.value,
                    validator: (value) {
                      // if (value!.isEmpty) {
                      //   return localization.getLocaleData
                      //       .validationText!
                      //       .mobileNumber10Digits.toString();
                      // }
                      return null;
                    },
                  ),

                      const SizedBox(height: 15,),




                            // Text('${localization.getLocaleData.hintText?.address.toString()}',
                            //     style: const TextStyle(
                            //       fontSize: 18, color: Colors.white,)),
                            const Text("Time Slots",style: TextStyle(fontSize: 18, ),),
                            const SizedBox(height: 5,),
                  MyTextField2(
                    enabled: false,
                    //controller: modal2.controller.mobileController.value,
                    hintText: widget.timeSlot,

                    validator: (value) {
                      // if (value!.isEmpty) {
                      //   return localization.getLocaleData
                      //       .validationText!
                      //       .mobileNumber10Digits.toString();
                      // }
                      return null;
                    },
                  ),


                      const SizedBox(height: 50,),

                      Align(
                        alignment: Alignment.centerRight,
                        child: SizedBox(
                            width: 200,
                            child: MyButton(title:"Book Appointment",height: 50,
                              onPress: (){

                                modal.bookAppointment(context,doctorId: widget.doctorId,departmentId: widget.departmentId,timeSlotsId: widget.timeSlotId,appointmentDate: widget.date,dayId:widget.dayid);
                                // modal.getTimeSlots(context,1);
                                // modal.getDays(context,1);

                                },

                            )),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        }
      ),

    );
  }
}
