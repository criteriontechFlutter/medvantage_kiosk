import 'package:digi_doctor/AppManager/widgets/customInkWell.dart';
import 'package:get/get.dart';
import '../../../../../AppManager/app_util.dart';
import '../../../../../Localization/app_localization.dart';
import 'package:digi_doctor/AppManager/app_color.dart';
import 'package:digi_doctor/AppManager/my_text_theme.dart';
import 'package:digi_doctor/AppManager/widgets/my_button2.dart';
import 'package:digi_doctor/Pages/Specialities/SpecialistDoctors/TimeSlot/time_slot_controller.dart' as dp;
import 'package:digi_doctor/Pages/Specialities/SpecialistDoctors/TimeSlot/time_slot_modal.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../../AppManager/widgets/my_app_bar.dart';
import '../../../../Dashboard/dashboard_view.dart';
import '../../../../MyAppointment/AppointmentDetails/send_document_view.dart';
import '../../../../StartUpScreen/startup_screen.dart';
import '../../../../VitalPage/Add Vitals/VitalHistory/vital_history_view.dart';
import '../../../../VitalPage/Add Vitals/add_vitals_view.dart';
import '../../../top_specialities_view.dart';
import '../../DataModal/appointment_details_data_modal.dart';
import '../time_slot_modal.dart';
import 'appointment_booked_controller.dart';


class AppointmentBookedView extends StatefulWidget {
  final AppointmentDetailsDataModal details;

  const AppointmentBookedView({Key? key, required this.details})
      : super(key: key);

  @override
  State<AppointmentBookedView> createState() => _AppointmentBookedViewState();
}

class _AppointmentBookedViewState extends State<AppointmentBookedView> {
  List optionList=[
    {
      'icon':"assets/kiosk_setting.png",
      'name':"Find Doctor By Specialty",
      'isChecked':true
    },
    {
      'icon':"assets/kiosk_symptoms.png",
      'name':"Find Doctors By Symptoms",
      'isChecked':false
    },
  ];
  bool isDoctor = true;
  TimeSlotModal modal = TimeSlotModal();
  AppointmentBookedController controller = Get.put(
      AppointmentBookedController());

  @override
  void initState() {
    controller.addDocumentList.clear();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    ApplicationLocalizations localization = Provider.of<
        ApplicationLocalizations>(context, listen: false);
    return Container(
      color: AppColor.primaryColor,
      child: SafeArea(
          child: Scaffold(
              backgroundColor: Colors.blue.shade50,
              appBar: MyWidget().myAppBar(context,
                  title: localization.getLocaleData.appointmentBooked
                      .toString()),
              body: Stack(
                alignment: AlignmentDirectional.bottomCenter,
                children: [
                  Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: ListView(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      flex: 2,
                                      child: Container(
                                        height:Get.height,
                                        //820,
                                        // MediaQuery.of(context).size.height * .89,
                                        color: AppColor.primaryColor,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 56, horizontal: 12),
                                          child: Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding:
                                                const EdgeInsets.only(left: 20),
                                                child: Image.asset(
                                                  'assets/kiosk_logo.png',
                                                  color: Colors.white,
                                                  height: 40,
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              //*********
                                              Expanded(
                                                child: ListView.builder(itemCount: modal.controller.getOption(context).length,
                                                    itemBuilder:(BuildContext context,int index){
                                                      // OptionDataModal opt=modal.controller.getOption(context)[index];
                                                      dp.OptionDataModals opts=modal.controller.getOption(context)[index];
                                                      return Padding(
                                                        padding:
                                                        const EdgeInsets.symmetric(
                                                            vertical: 20,
                                                            horizontal: 12),
                                                        child: InkWell(
                                                          onTap: (){
                                                            setState(() {
                                                              if(index==0){
                                                                isDoctor = true;
                                                                App().navigate(context, TopSpecialitiesView());
                                                              }
                                                              else{
                                                                isDoctor = false;
                                                                App().navigate(context, TopSpecialitiesView(isDoctor:1));

                                                              }
                                                            });
                                                            for (var element
                                                            in optionList) {
                                                              element["isChecked"] = false;
                                                            }
                                                            optionList[index]['isChecked']=true;





                                                          },

                                                          child: Container(
                                                            color: optionList[index]['isChecked']?AppColor
                                                                .primaryColorLight:AppColor.primaryColor,
                                                            child: Padding(
                                                              padding:
                                                              const EdgeInsets.all(
                                                                  8.0),
                                                              child: Row(
                                                                children: [
                                                                  Image.asset(
                                                                    optionList[index]['icon'],
                                                                    height: 40,
                                                                  ),
                                                                  const SizedBox(
                                                                    width: 10,
                                                                  ),
                                                                  Expanded(
                                                                    child: Text(
                                                                      opts.optionText.toString(),
                                                                      style: MyTextTheme()
                                                                          .largeWCN,
                                                                    ),
                                                                  )
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      );
                                                    }),
                                              ),

                                              Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Image.asset("assets/kiosk_tech.png",height: 25,color: AppColor.white,),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      Expanded(flex: 7,
                        child: ListView(
                            children: [
                              Container(
                                padding: EdgeInsets.all(15),
                                color: AppColor.white,
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        ClipRRect(
                                          borderRadius: BorderRadius.circular(10),
                                          child: Container(
                                            padding: EdgeInsets.all(8),
                                            color: Colors.blue.shade50,
                                            child: Image.asset(
                                              "assets/doctorSign.png",
                                              width: 30,
                                              height: 30,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment
                                              .start,
                                          children: [
                                            Text(
                                              widget.details
                                                  .doctorName
                                                  .toString(),
                                              style: MyTextTheme().mediumBCB,
                                            ),
                                            Text(widget.details
                                                .specialityName
                                                .toString() +
                                                widget.details
                                                    .degree
                                                    .toString(),
                                                style: MyTextTheme().smallBCB),
                                          ],
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Icon(Icons.add_location, color: Colors.blue,),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment
                                                .start,
                                            children: [
                                              Text(widget.details
                                                  .clinicName
                                                  .toString(),
                                                  style: MyTextTheme().smallBCB),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Text(widget.details.address
                                                  .toString(),
                                                style: MyTextTheme().smallBCN,
                                              ),
                                            ],
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            InkWell(
                                              onTap: () async {
                                                String url =
                                                    'https://maps.apple.com/?sll=${widget
                                                    .details.latitude
                                                    .toString()},${widget.details
                                                    .longititude.toString()}';

                                                // if (await canLaunch(url)) {
                                                await launchUrl(Uri.parse(url));
                                                // } else {
                                                //   throw 'Could not launch $url';
                                                // }
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    borderRadius: BorderRadius
                                                        .circular(10),
                                                    border: Border.all(
                                                        color: AppColor
                                                            .primaryColorDark)),
                                                child: Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: Row(
                                                    children: [
                                                      Icon(Icons.directions,
                                                          color: Colors.green),
                                                      Text(
                                                        localization.getLocaleData
                                                            .getDirections.toString(),
                                                        style: MyTextTheme().smallBCB,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),

                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                padding: EdgeInsets.all(15),
                                color: AppColor.white,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      localization.getLocaleData.appointmentBooked
                                          .toString(),
                                      style: MyTextTheme().mediumBCB,
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment
                                          .spaceBetween,
                                      children: [
                                        Text(
                                          localization.getLocaleData.fullName
                                              .toString(),
                                          style: MyTextTheme().smallBCB,
                                        ),
                                        Text(widget.details.memberName
                                            .toString(),
                                          style: MyTextTheme().smallBCB,
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 10,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment
                                          .spaceBetween,
                                      children: [
                                        Text(localization.getLocaleData.dateAndTime
                                            .toString(),
                                            style: MyTextTheme().mediumBCB),
                                        Text(widget.details.visitDate
                                            .toString() +
                                            '  ' +
                                            widget.details.visitTime
                                                .toString(),
                                          style: MyTextTheme().smallBCB,
                                        ),

                                      ],
                                    ),
                                    SizedBox(height: 10,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment
                                          .spaceBetween,
                                      children: [
                                        Text(localization.getLocaleData.appointmentID
                                            .toString(),
                                            style: MyTextTheme().mediumBCB),
                                        Text(widget.details.appointmentId
                                            .toString(),
                                            style: MyTextTheme().smallBCB),


                                        // MyButton2(
                                        //   width: 100,
                                        //   title: localization.getLocaleData.confirmed.toString(),
                                        //   color: Colors.green,
                                        // )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment
                                          .spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text("Status",
                                            style: MyTextTheme().smallBCB),
                                        Text(localization.getLocaleData.confirmed
                                            .toString(),
                                          style: MyTextTheme().smallBCB.copyWith(
                                              color: Colors.green, letterSpacing: 0.5
                                          ),),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 10,),
                              GetBuilder<AppointmentBookedController>(
                                  builder: (_) {
                                    return Column(
                                      children: [
                                        Container(
                                          padding: EdgeInsets.all(15),
                                          color: AppColor.white,
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text("Share your data",
                                                style: MyTextTheme().mediumBCB,),
                                              SizedBox(height: 20,),
                                              Center(
                                                child: CustomInkwell(borderRadius: 8,
                                                    child: Padding(
                                                      padding: const EdgeInsets.symmetric(
                                                          horizontal: 10.0),
                                                      child: Text("Upload",
                                                        style: MyTextTheme().mediumWCB,),
                                                    ),
                                                    onPress: () {
                                                      App().navigate(
                                                          context,
                                                          SendDocumentView(appointmentId: widget.details.appointmentId.toString(),));
                                                    },
                                                    color: AppColor.orangeButtonColor,
                                                    shadowColor: Colors.white),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(height: 10,),
                                        // Padding(
                                        //   padding: const EdgeInsets.symmetric(horizontal: 12.0,vertical: 30),
                                        //   child: GridView.count(
                                        //     shrinkWrap: true,
                                        //       crossAxisCount: 3,
                                        //       crossAxisSpacing: 35,
                                        //       mainAxisSpacing: 10,
                                        //       children: List.generate(
                                        //           controller.getAddDocumentList.length,
                                        //               (index) {
                                        //             return Stack(
                                        //               children: [
                                        //                 InkWell(
                                        //                   onTap: () {
                                        //                     Platform.isAndroid?
                                        //                    controller
                                        //                         .getAddDocumentList[index]
                                        //                     ['docFile'].endsWith('jpg')
                                        //                         ?
                                        //                     App().navigate(context, ImageView(isFilePath: true,filePathImg:controller.getAddDocumentList[index]['docFile'],url:  ''))
                                        //                         : App().navigate(
                                        //                         context,
                                        //                         VideoPlayer(
                                        //                             url: controller
                                        //                                 .getAddDocumentList[index]
                                        //                             ['docFile']))
                                        //                         :controller
                                        //                         .getAddDocumentList[index]
                                        //                     ['docFile']
                                        //                         .toString()
                                        //                         .trim()
                                        //                         .split('/').last.split('.')[1] ==
                                        //                         'jpg'
                                        //                         ?
                                        //
                                        //                     App().navigate(context, ImageView(isFilePath: true,filePathImg:controller.getAddDocumentList[index]['docFile'],url:  ''))
                                        //                         : App().navigate(
                                        //                         context,
                                        //                         VideoPage(
                                        //                             filePath: controller
                                        //                                 .getAddDocumentList[index]
                                        //                             ['docFile']));
                                        //                     print("######"+controller.getAddDocumentList[index]['docFile'].toString());
                                        //                   },
                                        //                   child: Center(
                                        //                     child: Column(
                                        //                       children: [
                                        //                        controller
                                        //                             .getAddDocumentList[index]
                                        //                         ['docFile']
                                        //                             .toString()
                                        //                         [Platform.isAndroid?1:0] ==
                                        //                             'jpg'
                                        //                             ? Image.file(
                                        //                           File(controller
                                        //                               .getAddDocumentList[index]
                                        //                           ['docFile']
                                        //                               .toString()),
                                        //                           height: 60,
                                        //                           width: 60,
                                        //                         )
                                        //                             : SvgPicture.asset(
                                        //                           controller
                                        //                               .getAddDocumentList[index]
                                        //                           ['img']
                                        //                               .toString(),
                                        //                           height: 60,
                                        //                           width: 60,
                                        //                         ),
                                        //                       ],
                                        //                     ),
                                        //                   ),
                                        //                 ),
                                        //                 Positioned(
                                        //                     top: 2,
                                        //                     right: 0,
                                        //                     child: InkWell(
                                        //                       onTap: () {
                                        //                         // controller
                                        //                         //     .deleteDocumentInList(index);
                                        //                       },
                                        //                       child: Padding(
                                        //                         padding: const EdgeInsets.fromLTRB(
                                        //                             5, 0, 2, 5),
                                        //                         child: Icon(
                                        //                           Icons.delete,
                                        //                           color: AppColor.red,
                                        //                           size: 15,
                                        //                         ),
                                        //                       ),
                                        //                     ))
                                        //               ],
                                        //             );
                                        //           })),
                                        // ),
                                        SizedBox(height: 10,),
                                        Container(
                                          padding: EdgeInsets.all(15),
                                          color: AppColor.white,
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text("Add vitals",
                                                style: MyTextTheme().mediumBCB,),
                                              SizedBox(height: 20,),
                                              !controller.getIsVitalSend?Center(
                                                child: CustomInkwell(borderRadius: 8,
                                                    child: Padding(
                                                      padding: const EdgeInsets.symmetric(
                                                          horizontal: 10.0),
                                                      child: Text("Add Vitals",
                                                        style: MyTextTheme().mediumWCB,),
                                                    ),
                                                    onPress: () {
                                                      Get.to(() => AddVitalsView(),
                                                          arguments: {
                                                            "isNavigateFromAppointment": true
                                                          });
                                                    },
                                                    color: AppColor.orangeButtonColor,
                                                    shadowColor: Colors.white),
                                              ):Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                children: [
                                                  CustomInkwell(borderRadius: 8,
                                                      child: Padding(
                                                        padding: const EdgeInsets.symmetric(
                                                            horizontal: 10.0),
                                                        child: Text("Add Vitals",
                                                          style: MyTextTheme().mediumWCB,),
                                                      ),
                                                      onPress: () {
                                                        Get.to(() => AddVitalsView(),
                                                            arguments: {
                                                              "isNavigateFromAppointment": true
                                                            });
                                                      },
                                                      color: AppColor.orangeButtonColor,
                                                      shadowColor: Colors.white),
                                                  SizedBox(width: 10,),
                                                  CustomInkwell(borderRadius: 8,
                                                      child: Padding(
                                                        padding: const EdgeInsets.symmetric(
                                                            horizontal: 10.0),
                                                        child: Text("Show Vitals",
                                                          style: MyTextTheme().mediumWCB,),
                                                      ),
                                                      onPress: () {
                                                        Get.to(() => VitalHistoryView(),
                                                        );
                                                      },
                                                      color: AppColor.green,
                                                      shadowColor: Colors.white),

                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(height: 10,),
                                      ],
                                    );
                                  }),

                              // Container(
                              //   padding: EdgeInsets.all(15),
                              //   color: AppColor.white,
                              //   child: Column(
                              //     crossAxisAlignment: CrossAxisAlignment.start,
                              //     children: [
                              //       Text("Height & Weight",style: MyTextTheme().mediumBCB,),
                              //       SizedBox(height: 20,),
                              //       Row(
                              //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              //         children: [
                              //           Expanded(child: MyTextField2(enabled: false,labelText: "Height",hintText: "5.9",)),
                              //           SizedBox(width: 15,),
                              //           Expanded(child: MyTextField2(enabled: false,hintText: "60 kg",labelText:"Weight")),
                              //         ],
                              //       ),
                              //     ],
                              //   ),
                              // ),
                              // SizedBox(height: 10,),
                              //         Container(
                              //           padding: EdgeInsets.all(15),
                              //           color: AppColor.white,
                              //           child: Column(
                              //             crossAxisAlignment: CrossAxisAlignment.start,
                              //             children: [
                              //               Text("Vitals",style: MyTextTheme().mediumBCB,),
                              //               SizedBox(height: 20,),
                              //               Row(
                              //                 children: [
                              //                   CircleAvatar(
                              //                       radius: 15,
                              //                       backgroundColor: Colors.white,
                              //                       child: SvgPicture.asset(
                              //                           'assets/bloodPressureImage.svg')),
                              //                   const SizedBox(
                              //                     width: 10,
                              //                   ),
                              //                   Text(
                              //                     localization.getLocaleData.bloodPressure.toString(),
                              //                     style: MyTextTheme().smallBCB,
                              //                   )
                              //                 ],
                              //               ),
                              //               const SizedBox(
                              //                 height: 10,
                              //               ),
                              //               Row(
                              //                 children: [
                              //                   Expanded(
                              //                       child: MyTextField2(
                              //                         enabled: false,
                              //                         controller: modal.controller.systolicC.value,
                              //                         hintText: localization.getLocaleData.hintText!.systolic.toString(),
                              //                         maxLength: 3,
                              //                         keyboardType: TextInputType.number,
                              //                       )),
                              //                   const SizedBox(
                              //                     width: 10,
                              //                   ),
                              //                   Expanded(
                              //                       child: MyTextField2(
                              //                         enabled: false,
                              //                         controller: modal.controller.diastolicC.value,
                              //                         hintText:  localization.getLocaleData.hintText!.diastolic.toString(),
                              //                         maxLength: 3,
                              //                         keyboardType: TextInputType.number,
                              //                       ))
                              //                 ],
                              //               ),
                              //
                              //               ListView.builder(
                              //                 physics: const NeverScrollableScrollPhysics(),
                              //                 shrinkWrap: true,
                              //                 itemCount: modal.controller.getVitalsList(context).length,
                              //                 itemBuilder: (BuildContext context, int index) {
                              //                   // print('-------------'+modal.controller.getVitalsList(context)[index]['controller'].value.text.toString());
                              //                   return Container(
                              //                     decoration:
                              //                     const BoxDecoration(color: Colors.white),
                              //                     child: Column(
                              //                       children: [
                              //                         const SizedBox(
                              //                           height: 20,
                              //                         ),
                              //                         Row(
                              //                           children: [
                              //                             CircleAvatar(
                              //                                 radius: 15,
                              //                                 backgroundColor: Colors.white,
                              //                                 child: SvgPicture.asset(modal
                              //                                     .controller
                              //                                     .getVitalsList(context)[index]['image']
                              //                                     .toString())),
                              //                             const SizedBox(
                              //                               width: 10,
                              //                             ),
                              //                             Expanded(
                              //                               child: Text(
                              //                                 modal.controller
                              //                                     .getVitalsList(context)[index]['title']
                              //                                     .toString(),
                              //                                 style: MyTextTheme().smallBCB,
                              //                               ),
                              //                             ),
                              //                           ],
                              //                         ),
                              //                         const SizedBox(
                              //                           height: 10,
                              //                         ),
                              //
                              //                         MyTextField2(
                              //                           enabled: false,
                              //                           controller:modal.controller.vitalTextX[index],
                              //                           hintText: modal.controller
                              //                               .getVitalsList(context)[index]['leading']
                              //                               .toString(),
                              //                           maxLength:index==1? 6:3,
                              //                           onChanged: (val){
                              //                             setState(() {
                              //
                              //                             });
                              //                           },
                              //                           keyboardType: TextInputType.number,
                              //                         ),
                              //
                              //                       ],
                              //                     ),
                              //                   );
                              //                 },
                              //               ),
                              //               SizedBox(height: 40,),
                              //       ],
                              // ),
                              //       )
                            ]
                        ),
                      ),
                    ],
                  ),
                  MyButton2(
                    title: localization.getLocaleData.goToDashboard.toString(),
                    color: AppColor.primaryColor,
                    width: 300,
                    onPress: () {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                              StartupPage()),
                              (Route<dynamic> route) => false);
                      // Get.offAll(DashboardView());
                    },
                  ),
                ],
              )
          )
      ),
    );
  }
}
