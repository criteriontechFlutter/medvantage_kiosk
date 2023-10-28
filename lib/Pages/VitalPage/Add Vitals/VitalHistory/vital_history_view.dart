import 'package:cached_network_image/cached_network_image.dart';
import 'package:digi_doctor/AppManager/app_color.dart';
import 'package:digi_doctor/AppManager/my_text_theme.dart';
import 'package:digi_doctor/AppManager/widgets/date_time_field.dart';
import 'package:digi_doctor/AppManager/widgets/my_app_bar.dart';
import 'package:digi_doctor/AppManager/widgets/my_button.dart';
import 'package:digi_doctor/AppManager/widgets/my_button2.dart';
import 'package:digi_doctor/Pages/Dashboard/Widget/footerView.dart';
import 'package:digi_doctor/Pages/VitalPage/Add%20Vitals/VitalHistory/vital_history_controller.dart';
import 'package:digi_doctor/Pages/VitalPage/DataModal/vital_history_data_modal.dart';
import 'package:digi_doctor/Pages/VitalPage/Add%20Vitals/VitalHistory/vital_history_modal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../../AppManager/app_util.dart';
import '../../../../AppManager/tab_responsive.dart';
import '../../../../AppManager/user_data.dart';
import '../../../../AppManager/widgets/common_widgets.dart';
import '../../../../AppManager/widgets/my_text_field_2.dart';
import '../../../../Localization/app_localization.dart';
import '../../../Dashboard/Widget/medicalHistoryWidget.dart';
import '../../../Dashboard/Widget/profile_info_widget.dart';
import '../../../InvestigationHistory/investigation_view.dart';
import '../../../MyAppointment/my_appointment_view.dart';
import '../../../Specialities/SpecialistDoctors/TimeSlot/AppointmentBookedDetails/appointment_booked_controller.dart';
import '../add_vitals_controller.dart';
import '../add_vitals_modal.dart';
import '../add_vitals_view.dart';

class VitalHistoryView extends StatefulWidget {
  const VitalHistoryView({Key? key}) : super(key: key);

  @override
  _VitalHistoryViewState createState() => _VitalHistoryViewState();
}

class _VitalHistoryViewState extends State<VitalHistoryView> {
  VitalHistoryModal modal = VitalHistoryModal();
  AddVitalsModel addVitalsModel = AddVitalsModel();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    get();
  }

  get() async {
    modal.controller.dateFromC.value.text = DateFormat('yyyy-MM-dd')
        .format(DateTime.now().subtract(const Duration(days: 9)));
    modal.controller.dateToC.value.text =
        DateFormat('yyyy-MM-dd').format(DateTime.now());
    await modal.getPatientVitalsDateWiseHistory(context);
    //**
    for(int i=0;i<addVitalsModel.controller.vitalTextX.length;i++){
      addVitalsModel.controller.vitalTextX[i].clear();
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    Get.delete<VitalHistoryController>();
    Get.delete<AddVitalsController>();
    Get.delete<AppointmentBookedController>();
  }

  @override
  Widget build(BuildContext context) {
    ApplicationLocalizations localization =
        Provider.of<ApplicationLocalizations>(context, listen: true);

    return Container(
      color: AppColor.primaryColor,
      child: SafeArea(
        child: Scaffold(
          // appBar: MyWidget().myAppBar(context, title: localization.getLocaleData.vitalHistory.toString()),
          body: GetBuilder(
            init: VitalHistoryController(),
            builder: (_) {

              return Container(
                decoration: const BoxDecoration(
                  image:DecorationImage(image: AssetImage("assets/kiosk_bg.png",),fit: BoxFit.fill),
                ),
                child: Column(
                  children: [
                    const ProfileInfoWidget(),

                    //const Expanded(child: AVIWidget()),

                    // Row(
                    //   children: [
                    //     InkWell(
                    //       onTap: (){
                    //          App().navigate(context, const MyAppointmentView());
                    //       },
                    //       child: Padding(
                    //         padding:
                    //         const EdgeInsets.symmetric(
                    //             vertical: 20,
                    //             horizontal: 12),
                    //         child: Container(
                    //           height: 40,width: 200,
                    //           color: AppColor
                    //               .primaryColorLight,
                    //           child: Padding(
                    //             padding:
                    //             const EdgeInsets.all(
                    //                 8.0),
                    //             child: Row(
                    //               mainAxisAlignment: MainAxisAlignment.center,
                    //               children: [
                    //                 Image.asset(
                    //                   'assets/kiosk_setting.png',
                    //                   height: 40,
                    //                 ),
                    //                 const SizedBox(
                    //                   width: 10,
                    //                 ),
                    //                 Expanded(
                    //                   child: Text(
                    //                     "Appointment History",
                    //                     style: MyTextTheme()
                    //                         .largeWCN,
                    //                   ),
                    //                 )
                    //               ],
                    //             ),
                    //           ),
                    //         ),
                    //       ),
                    //     ),
                    //
                    //
                    //     InkWell(
                    //       onTap: (){
                    //         //App().replaceNavigate(context,  const VitalHistoryView());
                    //       },
                    //       child: Padding(
                    //         padding:
                    //         const EdgeInsets.symmetric(
                    //             vertical: 20,
                    //             horizontal: 12),
                    //         child: Container(
                    //           height: 40,width: 200,
                    //           color: AppColor
                    //               .primaryColor,
                    //           child: Padding(
                    //             padding:
                    //             const EdgeInsets.all(
                    //                 8.0),
                    //             child: Row(
                    //               children: [
                    //                 Image.asset(
                    //                   'assets/kiosk_vitals.png',
                    //                   height: 40,
                    //                 ),
                    //                 const SizedBox(
                    //                   width: 10,
                    //                 ),
                    //                 Expanded(
                    //                   child: Text(
                    //                     "Vital History",
                    //                     style: MyTextTheme()
                    //                         .largeWCN,
                    //                   ),
                    //                 )
                    //               ],
                    //             ),
                    //           ),
                    //         ),
                    //       ),
                    //     ),
                    //
                    //
                    //     InkWell(
                    //       onTap: (){
                    //         App().replaceNavigate(context, const InvestigationView());
                    //       },
                    //       child: Padding(
                    //         padding:
                    //         const EdgeInsets.symmetric(
                    //             vertical: 20,
                    //             horizontal: 12),
                    //         child: Container(
                    //           height: 40,width: 200,
                    //           color: AppColor
                    //               .primaryColor,
                    //           child: Padding(
                    //             padding:
                    //             const EdgeInsets.all(
                    //                 8.0),
                    //             child: Row(
                    //               children: [
                    //                 Image.asset(
                    //                   'assets/find_symptom_img.png',
                    //                   height: 40,
                    //                 ),
                    //                 const SizedBox(
                    //                   width: 10,
                    //                 ),
                    //                 Expanded(
                    //                   child: Text(
                    //                     "Investigation History",
                    //                     style: MyTextTheme()
                    //                         .largeWCN,
                    //                   ),
                    //                 )
                    //               ],
                    //             ),
                    //           ),
                    //         ),
                    //       ),
                    //     ),
                    //
                    //
                    //
                    //
                    //
                    //
                    //   ],
                    // ),

                    Padding(
                      padding: const EdgeInsets.fromLTRB(10,0,10,0),
                      child: Container(
                        height:640,
                        width: Get.width,
                        decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(5)
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(localization.getLocaleData.vitalHistory.toString(),style: MyTextTheme().largeBCB,),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(4, 8, 170,5),
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.center,
                                  children:  [
                                    Expanded(
                                        child: Text( localization.getLocaleData.hintText!.fromDate.toString(), style: MyTextTheme()
                                            .mediumGCN
                                            .copyWith(fontSize: 16))),
                                    // const SizedBox(
                                    //   width: 10,
                                    // ),
                                    Expanded(
                                        child: Text( localization.getLocaleData.hintText!.toDate.toString(), style: MyTextTheme()
                                            .mediumGCN
                                            .copyWith(fontSize: 16))),

                                  ],
                                ),
                              ),

                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceAround,
                                children: [
                                  Expanded(flex: 2,
                                      child: MyDateTimeField(
                                        controller:
                                        modal.controller.dateFromC.value,
                                        onChanged: (val) async {
                                          await modal
                                              .getPatientVitalsDateWiseHistory(
                                              context);
                                        },
                                      )),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(flex: 2,
                                      child: MyDateTimeField(
                                        controller:
                                        modal.controller.dateToC.value,
                                        onChanged: (val) async {
                                          await modal
                                              .getPatientVitalsDateWiseHistory(
                                              context);
                                        },
                                      )),
                                  const SizedBox(width: 50,),
                                  Expanded(child: MyButton(
                                    color: AppColor.primaryColor,
                                    onPress: (){
                                      // App().navigate(context, AddVitalsView());
                                      showAlertDialog(context);
                                    },title:  localization.getLocaleData.addManually.toString(),))
                                ],
                              ),


                              Expanded(
                                child: ListView.builder(
                                  shrinkWrap: true,
                                    itemCount: modal.controller
                                        .getVitalHistoryList.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      VitalHistoryDataModal historyData =
                                      modal.controller
                                          .getVitalHistoryList[index];
                                      return Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          color: AppColor.white,
                                          padding: EdgeInsets.all(8),
                                          child: Column(
                                            children: [
                                              GestureDetector(
                                                onTap: () async {
                                                  await modal.controller
                                                      .updateHistoryData(
                                                      index,
                                                      historyData
                                                          .isSelected
                                                      as bool);
                                                },
                                                child: Row(
                                                  children: [
                                                    Expanded(
                                                      flex: 1,
                                                      child:
                                                      CachedNetworkImage(
                                                        placeholder: (context,
                                                            url) =>
                                                            Image.asset(
                                                                'assets/image_unavailable.jpg'),
                                                        imageUrl: historyData
                                                            .iconPath
                                                            .toString(),
                                                        errorWidget: (context,
                                                            url, error) =>
                                                            Image.asset(
                                                                'assets/image_unavailable.jpg'),
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      width: 10,
                                                    ),
                                                    Expanded(
                                                      flex: 7,
                                                      child: Text(
                                                        historyData.vitalName
                                                            .toString()
                                                            .toUpperCase(),
                                                        style: MyTextTheme()
                                                            .smallBCB,
                                                      ),
                                                    ),
                                                    Expanded(
                                                        flex: 2,
                                                        child: Container(child: Text(localization.getLocaleData.hintText!.viewDetails.toString(),style: MyTextTheme().mediumGCN,),)
                                                      // Icon(
                                                      //   Icons.info_outline,
                                                      //   color: AppColor
                                                      //       .primaryColor,
                                                      //   size: 20,
                                                      // ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Visibility(
                                                  visible: historyData
                                                      .isSelected ==
                                                      true,
                                                  child: Padding(
                                                    padding:
                                                    const EdgeInsets.all(
                                                        8.0),
                                                    child: Row(
                                                      children: [
                                                        Expanded(
                                                          child: Container(
                                                            width: 300,
                                                            child: (modal
                                                                .controller
                                                                .getVitalHistoryList[
                                                            index]
                                                                .vitalDetails!
                                                                .isEmpty ==
                                                                true)
                                                                ? Padding(
                                                              padding:
                                                              const EdgeInsets.all(
                                                                  8.0),
                                                              child:
                                                              Text(
                                                                "NO Data Found",
                                                                textAlign:
                                                                TextAlign.center,
                                                                style: MyTextTheme()
                                                                    .smallGCN,
                                                              ),
                                                            )
                                                                : Column(
                                                              children: List.generate(
                                                                  historyData
                                                                      .vitalDetails!
                                                                      .length,
                                                                      (index) {
                                                                    return Row(
                                                                      children: [
                                                                        Expanded(
                                                                          child: Padding(
                                                                            padding: const EdgeInsets.all(8.0),
                                                                            child: Text(
                                                                              historyData.vitalDetails![index].vitalDate.toString(),
                                                                              style: MyTextTheme().smallBCN,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        Text(
                                                                          historyData.vitalDetails![index].vitalValue.toString(),
                                                                          style: MyTextTheme().smallBCN,
                                                                        ),
                                                                      ],
                                                                    );
                                                                  }),
                                                            ),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ))
                                            ],
                                          ),
                                        ),
                                      );
                                    }),
                              ),



                            ],
                          ),
                        ),
                      ),
                    ),

                     // Expanded(child: FooterView())
                  ],
                ),
              );




              // return Row(
              //   children: [
              //     Expanded(
              //       flex: 3,
              //       child: ListView(
              //         physics: const NeverScrollableScrollPhysics(),
              //         // crossAxisAlignment: CrossAxisAlignment.start,
              //         children: [
              //           Row(
              //             children: [
              //               Expanded(
              //                 flex: 2,
              //                 child: Container(
              //                   height: Get.height,
              //                   color: AppColor.primaryColor,
              //                   child: Padding(
              //                     padding: const EdgeInsets.symmetric(
              //                         vertical: 56, horizontal: 12),
              //                     child: Column(
              //                       crossAxisAlignment:
              //                           CrossAxisAlignment.start,
              //                       children: [
              //                         Padding(
              //                           padding:
              //                               const EdgeInsets.only(left: 20),
              //                           child: Image.asset(
              //                             'assets/kiosk_logo.png',
              //                             color: Colors.white,
              //                             height: 40,
              //                           ),
              //                         ),
              //                         const SizedBox(
              //                           height: 10,
              //                         ),
              //                         InkWell(
              //                           onTap: () {
              //                             App().replaceNavigate(
              //                                 context, const MyAppointmentView());
              //                           },
              //                           child: Padding(
              //                             padding: const EdgeInsets.symmetric(
              //                                 vertical: 20, horizontal: 12),
              //                             child: Container(
              //                               color: AppColor.primaryColor,
              //                               child: Padding(
              //                                 padding:
              //                                     const EdgeInsets.all(8.0),
              //                                 child: Row(
              //                                   children: [
              //                                     Image.asset(
              //                                       'assets/kiosk_setting.png',
              //                                       height: 40,
              //                                     ),
              //                                     const SizedBox(
              //                                       width: 10,
              //                                     ),
              //                                     Expanded(
              //                                       child: Text(
              //                                         "Appointment History",
              //                                         style: MyTextTheme()
              //                                             .largeWCN,
              //                                       ),
              //                                     )
              //                                   ],
              //                                 ),
              //                               ),
              //                             ),
              //                           ),
              //                         ),
              //                         InkWell(
              //                           onTap: () {
              //                             App().replaceNavigate(
              //                                 context, const VitalHistoryView());
              //                           },
              //                           child: Padding(
              //                             padding: const EdgeInsets.symmetric(
              //                                 vertical: 20, horizontal: 12),
              //                             child: Container(
              //                               color: AppColor.primaryColorLight,
              //                               child: Padding(
              //                                 padding:
              //                                     const EdgeInsets.all(8.0),
              //                                 child: Row(
              //                                   children: [
              //                                     Image.asset(
              //                                       'assets/kiosk_vitals.png',
              //                                       height: 40,
              //                                     ),
              //                                     const SizedBox(
              //                                       width: 10,
              //                                     ),
              //                                     Expanded(
              //                                       child: Text(
              //                                         "Vital History",
              //                                         style: MyTextTheme()
              //                                             .largeWCN,
              //                                       ),
              //                                     )
              //                                   ],
              //                                 ),
              //                               ),
              //                             ),
              //                           ),
              //                         ),
              //                         InkWell(
              //                           onTap: () {
              //                             App().replaceNavigate(
              //                                 context, const InvestigationView());
              //                           },
              //                           child: Padding(
              //                             padding: const EdgeInsets.symmetric(
              //                                 vertical: 20, horizontal: 12),
              //                             child: Container(
              //                               color: AppColor.primaryColor,
              //                               child: Padding(
              //                                 padding:
              //                                     const EdgeInsets.all(8.0),
              //                                 child: Row(
              //                                   children: [
              //                                     Image.asset(
              //                                       'assets/find_symptom_img.png',
              //                                       height: 40,
              //                                     ),
              //                                     const SizedBox(
              //                                       width: 10,
              //                                     ),
              //                                     Expanded(
              //                                       child: Text(
              //                                         "Investigation History",
              //                                         style: MyTextTheme()
              //                                             .largeWCN,
              //                                       ),
              //                                     )
              //                                   ],
              //                                 ),
              //                               ),
              //                             ),
              //                           ),
              //                         )
              //                       ],
              //                     ),
              //                   ),
              //                 ),
              //               ),
              //             ],
              //           )
              //         ],
              //       ),
              //     ),
              //     Expanded(
              //       flex: 6,
              //       child: CommonWidgets().showNoData(
              //         title: localization
              //             .getLocaleData.topSpecialitiesDataNotFound
              //             .toString(),
              //         show: (modal.controller.getShowNoData &&
              //             modal.controller.getVitalHistoryList.isEmpty),
              //         loaderTitle: localization
              //             .getLocaleData.loadingTopSpecialitiesData
              //             .toString(),
              //         showLoader: (!modal.controller.getShowNoData &&
              //             modal.controller.getVitalHistoryList.isEmpty),
              //         child: Column(
              //           crossAxisAlignment: CrossAxisAlignment.start,
              //           mainAxisAlignment: MainAxisAlignment.start,
              //           children: [
              //             Padding(
              //               padding: const EdgeInsets.fromLTRB(16, 0, 5, 5),
              //               child: Row(
              //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //                 children: [
              //                   Padding(
              //                     padding: const EdgeInsets.only(top: 25),
              //                     child: Column(
              //                       crossAxisAlignment: CrossAxisAlignment.start,
              //                       children: [
              //                         Text(UserData().getUserName.toString(),style: MyTextTheme().largePCB.copyWith(color: AppColor.primaryColorLight,fontSize: 25)),
              //                         Row(
              //                           children: [
              //
              //                             Text(UserData().getUserGender.toString()=='1'? 'Male':'Female',style: MyTextTheme().mediumGCN.copyWith(fontSize: 18)),
              //                             Text(" ${DateTime.now().year-int.parse(UserData().getUserDob.split('/')[2])} years ",style: MyTextTheme().mediumGCN.copyWith(fontSize: 18)),
              //                           ],
              //                         ),
              //                         Text(UserData().getUserMobileNo,style: MyTextTheme().mediumGCN.copyWith(fontSize: 18)),
              //                         Text(UserData().getUserEmailId,style: MyTextTheme().mediumGCN.copyWith(fontSize: 18)),
              //                       ],
              //                     ),
              //                   ),
              //                   Row(
              //                     mainAxisAlignment: MainAxisAlignment.end,
              //                     children: [
              //                       //const Expanded(child: SizedBox()),
              //                       ProfileInfoWidget()
              //                     ],
              //                   )
              //                 ],
              //               ),
              //             ),
              //             Container(
              //                 color: AppColor.greyLight.withOpacity(0.1),
              //                 child: Padding(
              //                   padding: const EdgeInsets.fromLTRB(16, 0, 5, 5),
              //                   child: Row(
              //                     children: [
              //                       Text("Vital History",
              //                           style: MyTextTheme()
              //                               .mediumGCN
              //                               .copyWith(fontSize: 20)),
              //                       Expanded(child: SizedBox())
              //                     ],
              //                   ),
              //                 )),
              //             Expanded(
              //               child: Container(
              //                   // decoration: BoxDecoration(color: AppColor.lightBackground),
              //                   child: Padding(
              //                 padding: const EdgeInsets.all(10),
              //                 child: SingleChildScrollView(
              //                   child: Column(
              //                     children: [
              //                       Padding(
              //                         padding: const EdgeInsets.fromLTRB(4, 8, 170,5),
              //                         child: Row(
              //                           mainAxisAlignment:
              //                           MainAxisAlignment.center,
              //                           children:  [
              //                             Expanded(
              //                                 child: Text("From", style: MyTextTheme()
              //                                     .mediumGCN
              //                                     .copyWith(fontSize: 16))),
              //                             // const SizedBox(
              //                             //   width: 10,
              //                             // ),
              //                             Expanded(
              //                                 child: Text("To", style: MyTextTheme()
              //                                     .mediumGCN
              //                                     .copyWith(fontSize: 16))),
              //
              //                           ],
              //                         ),
              //                       ),
              //                       Row(
              //                         mainAxisAlignment:
              //                         MainAxisAlignment.spaceAround,
              //                         children: [
              //                           Expanded(flex: 2,
              //                               child: MyDateTimeField(
              //                                 controller:
              //                                 modal.controller.dateFromC.value,
              //                                 onChanged: (val) async {
              //                                   await modal
              //                                       .getPatientVitalsDateWiseHistory(
              //                                       context);
              //                                 },
              //                               )),
              //                           const SizedBox(
              //                             width: 10,
              //                           ),
              //                           Expanded(flex: 2,
              //                               child: MyDateTimeField(
              //                                 controller:
              //                                 modal.controller.dateToC.value,
              //                                 onChanged: (val) async {
              //                                   await modal
              //                                       .getPatientVitalsDateWiseHistory(
              //                                       context);
              //                                 },
              //                               )),
              //                           const SizedBox(width: 50,),
              //                         Expanded(child: MyButton(
              //                           color: AppColor.primaryColor,
              //                           onPress: (){
              //                          // App().navigate(context, AddVitalsView());
              //                           showAlertDialog(context);
              //                         },title: "Add Manually",))
              //                         ],
              //                       ),
              //                       SizedBox(height: 420,
              //                         child: ListView.builder(
              //                             itemCount: modal.controller
              //                                 .getVitalHistoryList.length,
              //                             itemBuilder:
              //                                 (BuildContext context, int index) {
              //                               VitalHistoryDataModal historyData =
              //                                   modal.controller
              //                                       .getVitalHistoryList[index];
              //                               return Padding(
              //                                 padding: const EdgeInsets.all(8.0),
              //                                 child: Container(
              //                                   color: AppColor.white,
              //                                   padding: EdgeInsets.all(8),
              //                                   child: Column(
              //                                     children: [
              //                                       GestureDetector(
              //                                         onTap: () async {
              //                                           await modal.controller
              //                                               .updateHistoryData(
              //                                                   index,
              //                                                   historyData
              //                                                           .isSelected
              //                                                       as bool);
              //                                         },
              //                                         child: Row(
              //                                           children: [
              //                                             Expanded(
              //                                               flex: 1,
              //                                               child:
              //                                                   CachedNetworkImage(
              //                                                 placeholder: (context,
              //                                                         url) =>
              //                                                     Image.asset(
              //                                                         'assets/image_unavailable.jpg'),
              //                                                 imageUrl: historyData
              //                                                     .iconPath
              //                                                     .toString(),
              //                                                 errorWidget: (context,
              //                                                         url, error) =>
              //                                                     Image.asset(
              //                                                         'assets/image_unavailable.jpg'),
              //                                               ),
              //                                             ),
              //                                             const SizedBox(
              //                                               width: 10,
              //                                             ),
              //                                             Expanded(
              //                                               flex: 7,
              //                                               child: Text(
              //                                                 historyData.vitalName
              //                                                     .toString()
              //                                                     .toUpperCase(),
              //                                                 style: MyTextTheme()
              //                                                     .smallBCB,
              //                                               ),
              //                                             ),
              //                                             Expanded(
              //                                               flex: 2,
              //                                               child: Container(child: Text("View Details",style: MyTextTheme().mediumGCN,),)
              //                                               // Icon(
              //                                               //   Icons.info_outline,
              //                                               //   color: AppColor
              //                                               //       .primaryColor,
              //                                               //   size: 20,
              //                                               // ),
              //                                             ),
              //                                           ],
              //                                         ),
              //                                       ),
              //                                       Visibility(
              //                                           visible: historyData
              //                                                   .isSelected ==
              //                                               true,
              //                                           child: Padding(
              //                                             padding:
              //                                                 const EdgeInsets.all(
              //                                                     8.0),
              //                                             child: Row(
              //                                               children: [
              //                                                 Expanded(
              //                                                   child: Container(
              //                                                     width: 300,
              //                                                     child: (modal
              //                                                                 .controller
              //                                                                 .getVitalHistoryList[
              //                                                                     index]
              //                                                                 .vitalDetails!
              //                                                                 .isEmpty ==
              //                                                             true)
              //                                                         ? Padding(
              //                                                             padding:
              //                                                                 const EdgeInsets.all(
              //                                                                     8.0),
              //                                                             child:
              //                                                                 Text(
              //                                                               "NO Data Found",
              //                                                               textAlign:
              //                                                                   TextAlign.center,
              //                                                               style: MyTextTheme()
              //                                                                   .smallGCN,
              //                                                             ),
              //                                                           )
              //                                                         : Column(
              //                                                             children: List.generate(
              //                                                                 historyData
              //                                                                     .vitalDetails!
              //                                                                     .length,
              //                                                                 (index) {
              //                                                               return Row(
              //                                                                 children: [
              //                                                                   Expanded(
              //                                                                     child: Padding(
              //                                                                       padding: const EdgeInsets.all(8.0),
              //                                                                       child: Text(
              //                                                                         historyData.vitalDetails![index].vitalDate.toString(),
              //                                                                         style: MyTextTheme().smallBCN,
              //                                                                       ),
              //                                                                     ),
              //                                                                   ),
              //                                                                   Text(
              //                                                                     historyData.vitalDetails![index].vitalValue.toString(),
              //                                                                     style: MyTextTheme().smallBCN,
              //                                                                   ),
              //                                                                 ],
              //                                                               );
              //                                                             }),
              //                                                           ),
              //                                                   ),
              //                                                 )
              //                                               ],
              //                                             ),
              //                                           ))
              //                                     ],
              //                                   ),
              //                                 ),
              //                               );
              //                             }),
              //                       ),
              //
              //                     ],
              //                   ),
              //                 ),
              //               )),
              //             ),
              //           ],
              //         ),
              //       ),
              //     ),
              //   ],
              // );
            },
          ),
        ),
      ),
    );
  }
  showAlertDialog(BuildContext context) {

    ApplicationLocalizations localization=Provider.of<ApplicationLocalizations>(context,listen: false);
    // show the dialog
    showDialog(
      barrierDismissible: true,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(

          insetPadding: const EdgeInsets.symmetric(horizontal: 10),
          contentPadding: EdgeInsets.zero,
          content:
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12,horizontal: 20),
            child: SizedBox(
              height: Get.height*0.85,
              //********
              width:Get.width*0.6,
              //width: double.maxFinite,
              child:
              GetBuilder(
                init: AddVitalsController(),
                builder: (AddVitalsController controller) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Add Vitals",style: MyTextTheme().mediumGCN.copyWith(fontSize: 20),),
                          InkWell(
                              onTap: (){
                                Navigator.pop(context);
                              },
                              child: const Icon(Icons.close,size: 30,)),

                        ],
                      ),
                     Expanded(
                       child: ListView(
                         children: [
                           const SizedBox(height: 15,),

                           Row(
                             children: [
                               CircleAvatar(
                                   radius: 15,
                                   backgroundColor: Colors.white,
                                   child: SvgPicture.asset(
                                       'assets/bloodPressureImage.svg')),
                               const SizedBox(
                                 width: 10,
                               ),
                               Text(
                                 localization.getLocaleData.bloodPressure.toString(),
                                 style: MyTextTheme()
                                     .mediumGCN
                                     .copyWith(fontSize: 20),
                               )
                             ],
                           ),

                           const SizedBox(height: 15,),

                           Row(
                             children: [
                               Expanded(
                                 child: MyTextField2(
                                   controller: addVitalsModel.controller.systolicC.value,
                                   hintText: localization.getLocaleData.hintText!.systolic.toString(),
                                   maxLength: 3,
                                   keyboardType: TextInputType.number,
                                 ),
                               ),
                               const SizedBox(
                                 width: 10,
                               ),
                               Expanded(
                                 child: MyTextField2(
                                   controller: addVitalsModel.controller.diastolicC.value,
                                   hintText:  localization.getLocaleData.hintText!.diastolic.toString(),
                                   maxLength: 3,
                                   keyboardType: TextInputType.number,
                                 ),
                               )
                             ],
                           ),

                           ListView.builder(
                             physics: const NeverScrollableScrollPhysics(),
                             shrinkWrap: true,
                             itemCount: addVitalsModel.controller.getVitalsList(context).length,
                             itemBuilder: (BuildContext context, int index) {
                               // print('-------------'+modal.controller.getVitalsList(context)[index]['controller'].value.text.toString());
                               return Column(
                                 children: [
                                   const SizedBox(
                                     height: 20,
                                   ),
                                   Row(
                                     children: [
                                       CircleAvatar(
                                           radius: 15,
                                           backgroundColor: Colors.white,
                                           child: SvgPicture.asset(addVitalsModel
                                               .controller
                                               .getVitalsList(context)[index]['image']
                                               .toString())),
                                       const SizedBox(
                                         width: 10,
                                       ),
                                       Expanded(
                                         child: Text(
                                           addVitalsModel.controller
                                               .getVitalsList(context)[index]['title']
                                               .toString(),
                                           style: MyTextTheme()
                                               .mediumGCN
                                               .copyWith(fontSize: 20),
                                         ),
                                       ),
                                     ],
                                   ),
                                   const SizedBox(
                                     height: 10,
                                   ),

                                   MyTextField2(
                                     controller:addVitalsModel.controller.vitalTextX[index],
                                     hintText: addVitalsModel.controller
                                         .getVitalsList(context)[index]['leading']
                                         .toString(),
                                     maxLength:index==1? 6:3,
                                     onChanged: (val){
                                       setState(() {

                                       });
                                     },
                                     keyboardType: TextInputType.number,
                                   ),

                                 ],
                               );
                             },
                           ),

                           const SizedBox(height: 30,),
                           Text("Height & Weight", style: MyTextTheme()
                               .mediumGCN
                               .copyWith(fontSize: 20)),
                           const SizedBox(height: 20,),
                           Row(
                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                             children: [
                               Expanded(child: MyTextField2(hintText: "Height",controller: addVitalsModel.controller.heightC.value,)),
                               const SizedBox(width: 15,),
                               Expanded(child: MyTextField2(hintText: "Weight",controller: addVitalsModel.controller.weightC.value)),
                             ],
                           ),
                         ],
                       ),
                     ),

                      Padding(
                        padding: const EdgeInsets.fromLTRB(15, 15,15, 15),
                        child: MyButton(
                          title: "Save",
                          //localization.getLocaleData.submit.toString(),
                          //   buttonRadius: 25,
                          color: AppColor.primaryColor,
                          onPress: () {
                            addVitalsModel.onPressedSubmit(context);
                          },
                        ),
                      ),
                    ],
                  );
                },

              ),
            ),
          ),
        );
      },
    );
  }
}
