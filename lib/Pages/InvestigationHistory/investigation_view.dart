import 'package:cached_network_image/cached_network_image.dart';
import 'package:digi_doctor/AppManager/widgets/my_button.dart';
import 'package:digi_doctor/AppManager/widgets/my_button2.dart';
import 'package:digi_doctor/Pages/Dashboard/Widget/footerView.dart';
import 'package:digi_doctor/Pages/Dashboard/Widget/medicalHistoryWidget.dart';
import 'package:digi_doctor/Pages/Dashboard/Widget/profile_info_widget.dart';
import 'package:digi_doctor/Pages/InvestigationHistory/Microbiology/microbiology_view.dart';
import 'package:digi_doctor/Pages/InvestigationHistory/radiology/radiology_view.dart';
import 'package:digi_doctor/Pages/MyAppointment/my_appointment_view.dart';
import '../../../Localization/app_localization.dart';
import 'package:digi_doctor/AppManager/app_color.dart';
import 'package:digi_doctor/AppManager/in_app_webview.dart';
import 'package:digi_doctor/AppManager/my_text_theme.dart';
import 'package:digi_doctor/AppManager/user_data.dart';
import 'package:digi_doctor/Pages/InvestigationHistory/AddInvestigation/add_investigation_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../../AppManager/app_util.dart';
import '../../../AppManager/widgets/common_widgets.dart';
import '../../../AppManager/widgets/my_app_bar.dart';
import '../NewLabTest/lab_test_navigation_view.dart';
import '../VitalPage/Add Vitals/VitalHistory/vital_history_view.dart';
import 'DataModal/era_investigation_data_modal.dart';
import 'DataModal/investigation_history_data_modal.dart';
import 'DataModal/radiology_data_modal.dart';
import 'ViewInvestigation/view_eras_investigation.dart';
import 'ViewInvestigation/view_investigation.dart';
import 'investigation_controller.dart';
import 'investigaton_modal.dart';

class InvestigationView extends StatefulWidget {
  final int? pageIndex;
  const InvestigationView({Key? key, this.pageIndex}) : super(key: key);

  @override
  State<InvestigationView> createState() => _InvestigationViewState();
}

class _InvestigationViewState extends State<InvestigationView> {
  InvestigationModal modal = InvestigationModal();


  @override
  void initState() {
    //get();
    super.initState();

  }

  @override
  void dispose() {
    super.dispose();
    Get.delete<InvestigationController>();
  }

  @override
  Widget build(BuildContext context) {
    ApplicationLocalizations localization=Provider.of<ApplicationLocalizations>(context,listen: false);
    return DefaultTabController(
      length: 4,
      initialIndex:widget.pageIndex?? 0,
      child: Container(
        color: AppColor.primaryColor,
        child: SafeArea(
          child: Scaffold(
            // backgroundColor: AppColor.bgColor,
            // appBar:
            // MyWidget().myAppBar(context, title: localization.getLocaleData.investigation.toString(), action: [
            //   Padding(
            //     padding:
            //     const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
            //     child: InkWell(
            //       onTap: () {
            //         App().navigate(context, const AddInvestigationView());
            //       },
            //       child: Container(
            //         padding: const EdgeInsets.symmetric(horizontal: 10),
            //         decoration: BoxDecoration(
            //             color: AppColor.orangeColorDark,
            //             borderRadius: BorderRadius.circular(20)),
            //         child: Row(
            //           children: [const Icon(Icons.add), Text(localization.getLocaleData.addManually.toString())],
            //         ),
            //       ),
            //     ),
            //   )
            // ]),
            body: GetBuilder(
                init: InvestigationController(),
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
                        //         App().navigate(context, const MyAppointmentView());
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
                        //         App().replaceNavigate(context,  const VitalHistoryView());
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
                        //         //App().replaceNavigate(context, const InvestigationView());
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
                                children: [
                                  SizedBox(
                                    height: 50,
                                    child: TabBar(
                                      onTap: (val) async {
                                        print("object"+val.toString());
                                        modal.controller.updateSelectedTab = val.toString();
                                        await modal.onPressedTab(context);
                                      },
                                      mouseCursor: MouseCursor.defer,
                                      isScrollable: true,
                                      labelColor: AppColor.primaryColor,
                                      unselectedLabelColor: AppColor.greyDark,
                                      tabs: [
                                        Tab(
                                          icon: Row(
                                            children: [
                                              SvgPicture.asset('assets/manuallyReport.svg'),
                                              const SizedBox(
                                                width: 5,
                                              ),
                                              Text(localization.getLocaleData.manuallyReport.toString()),
                                            ],
                                          ),
                                        ),
                                        Tab(
                                          icon: Row(
                                            children: [
                                              SvgPicture.asset('assets/investigation.svg'),
                                              const SizedBox(
                                                width: 5,
                                              ),
                                              Text(localization.getLocaleData.erasInvestigation.toString()),
                                            ],
                                          ),
                                        ),
                                        Tab(
                                          icon: Row(
                                            children: [
                                              SvgPicture.asset('assets/radiology.svg'),
                                              const SizedBox(
                                                width: 5,
                                              ),
                                              Text(localization.getLocaleData.radiologyReport.toString()  ),
                                            ],
                                          ),
                                        ),
                                        Tab(
                                          icon: Row(
                                            children: [
                                              SvgPicture.asset('assets/microbiology.svg',width: 15,height: 15,),
                                              const SizedBox(
                                                width: 5,
                                              ),
                                              const Text("Microbiology"),
                                              //Text(localization.getLocaleData.radiologyReport.toString()),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: TabBarView(
                                      physics: const NeverScrollableScrollPhysics(),
                                      children: [
                                        //manuallyReport(),
                                        const LabTestNavigationView(isShowAppBar: false,),
                                        const RadiologyView(),
                                        const MicrobiologyView(),
                                      ],
                                    ),
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
                  //                       CrossAxisAlignment.start,
                  //                       children: [
                  //                         Padding(
                  //                           padding:
                  //                           const EdgeInsets.only(left: 20),
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
                  //                           onTap: (){
                  //                             App().replaceNavigate(context, const MyAppointmentView());
                  //                           },
                  //                           child: Padding(
                  //                             padding:
                  //                             const EdgeInsets.symmetric(
                  //                                 vertical: 20,
                  //                                 horizontal: 12),
                  //                             child: Container(
                  //                               color: AppColor
                  //                                   .primaryColor,
                  //                               child: Padding(
                  //                                 padding:
                  //                                 const EdgeInsets.all(
                  //                                     8.0),
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
                  //
                  //
                  //                         InkWell(
                  //                           onTap: (){
                  //                             App().replaceNavigate(context,  const VitalHistoryView());
                  //                           },
                  //                           child: Padding(
                  //                             padding:
                  //                             const EdgeInsets.symmetric(
                  //                                 vertical: 20,
                  //                                 horizontal: 12),
                  //                             child: Container(
                  //                               color: AppColor
                  //                                   .primaryColor,
                  //                               child: Padding(
                  //                                 padding:
                  //                                 const EdgeInsets.all(
                  //                                     8.0),
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
                  //
                  //
                  //                         InkWell(
                  //                           onTap: (){
                  //                             //App().navigate(context, const InvestigationView());
                  //                           },
                  //                           child: Padding(
                  //                             padding:
                  //                             const EdgeInsets.symmetric(
                  //                                 vertical: 20,
                  //                                 horizontal: 12),
                  //                             child: Container(
                  //                               color: AppColor
                  //                                   .primaryColorLight,
                  //                               child: Padding(
                  //                                 padding:
                  //                                 const EdgeInsets.all(
                  //                                     8.0),
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
                  //             modal.controller.getManuallyList.isEmpty),
                  //         loaderTitle: localization
                  //             .getLocaleData.loadingTopSpecialitiesData
                  //             .toString(),
                  //         showLoader: (!modal.controller.getShowNoData &&
                  //             modal.controller.getManuallyList.isEmpty),
                  //         child: Column(
                  //           crossAxisAlignment: CrossAxisAlignment.start,
                  //           mainAxisAlignment: MainAxisAlignment.start,
                  //           children: [
                  //             Padding(
                  //               padding: const EdgeInsets.fromLTRB(16,0,5,5),
                  //               child: Row(
                  //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //                 children: [
                  //                   Padding(
                  //                     padding: const EdgeInsets.only(top: 25),
                  //                     child:
                  //                     Column(
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
                  //                     children: const [
                  //                       ProfileInfoWidget()
                  //                     ],
                  //                   )
                  //
                  //                 ],
                  //               ),
                  //             ),
                  //             SizedBox(height: 20,),
                  //
                  //             SizedBox(
                  //               height: 50,
                  //               child: TabBar(
                  //                 onTap: (val) async {
                  //                   print("object"+val.toString());
                  //                   modal.controller.updateSelectedTab = val.toString();
                  //                   await modal.onPressedTab(context);
                  //                 },
                  //                 mouseCursor: MouseCursor.defer,
                  //                 isScrollable: true,
                  //                 labelColor: AppColor.primaryColor,
                  //                 unselectedLabelColor: AppColor.greyDark,
                  //                 tabs: [
                  //                   Tab(
                  //                     icon: Row(
                  //                       children: [
                  //                         SvgPicture.asset('assets/manuallyReport.svg'),
                  //                         const SizedBox(
                  //                           width: 5,
                  //                         ),
                  //                         Text(localization.getLocaleData.manuallyReport.toString()),
                  //                       ],
                  //                     ),
                  //                   ),
                  //                   Tab(
                  //                     icon: Row(
                  //                       children: [
                  //                         SvgPicture.asset('assets/investigation.svg'),
                  //                         const SizedBox(
                  //                           width: 5,
                  //                         ),
                  //                         Text(localization.getLocaleData.erasInvestigation.toString()),
                  //                       ],
                  //                     ),
                  //                   ),
                  //                   Tab(
                  //                     icon: Row(
                  //                       children: [
                  //                         SvgPicture.asset('assets/radiology.svg'),
                  //                         const SizedBox(
                  //                           width: 5,
                  //                         ),
                  //                         Text(localization.getLocaleData.radiologyReport.toString()  ),
                  //                       ],
                  //                     ),
                  //                   ),
                  //                   Tab(
                  //                     icon: Row(
                  //                       children: [
                  //                         SvgPicture.asset('assets/microbiology.svg',width: 15,height: 15,),
                  //                         const SizedBox(
                  //                           width: 5,
                  //                         ),
                  //                         const Text("Microbiology"),
                  //                         //Text(localization.getLocaleData.radiologyReport.toString()),
                  //                       ],
                  //                     ),
                  //                   ),
                  //                 ],
                  //               ),
                  //             ),
                  //             Expanded(
                  //               child: TabBarView(
                  //                 physics: const NeverScrollableScrollPhysics(),
                  //                 children: [
                  //                   manuallyReport(),
                  //                   const LabTestNavigationView(isShowAppBar: false,),
                  //                   const RadiologyView(),
                  //                   const MicrobiologyView(),
                  //                 ],
                  //               ),
                  //             ),
                  //           ],
                  //         ),
                  //       ),
                  //     ),
                  //   ],
                  // );
                }),
          ),
        ),
      ),
    );
  }


  erasInvestigation() {
    ApplicationLocalizations localization=Provider.of<ApplicationLocalizations>(context,listen: false);
    return GetBuilder(
        init: InvestigationController(),
        builder: (_) {
          return Container(
            color: Colors.blue.shade50,
            child: Center(
              child: CommonWidgets().showNoData(
                title: localization.getLocaleData.erasInvestigationNotFound.toString(),
                show: (modal.controller.getShowNoData &&
                    modal.controller.getErasInvestigation.isEmpty),
                loaderTitle: localization.getLocaleData.loading.toString(),
                showLoader: (!modal.controller.getShowNoData &&
                    modal.controller.getErasInvestigation.isEmpty),
                child: ListView.builder(
                  itemCount: modal.controller.getErasInvestigation.length,
                  itemBuilder: (BuildContext context, int index) {
                    InvestigationResult erasInvestigation =
                    modal.controller.getErasInvestigation[index];
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: erasInvestigation.result!.length,
                      itemBuilder: (BuildContext context, int index2) {
                        Result resultData = erasInvestigation.result![index2];
                        return InkWell(
                          onTap: () {
                            App().navigate(
                                context,
                                ViewErasInvestigation(
                                  resultDetail: resultData,
                                  date: erasInvestigation.billDate.toString(),
                                ));
                          },
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(8, 10, 8, 0),
                            child: Container(
                              padding: const EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                  color: AppColor.white,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      CachedNetworkImage(
                                        imageUrl: "http://fm/350x150",
                                        placeholder: (context, url) =>
                                            CircleAvatar(
                                              radius: 18,
                                              backgroundColor: AppColor.bgColor,
                                              child: Center(
                                                child: SizedBox(
                                                  height: 35,
                                                  child: SvgPicture.asset(
                                                      'assets/investigation.svg'),
                                                ),
                                              ),
                                            ),
                                        errorWidget: (context, url, error) =>
                                            CircleAvatar(
                                              radius: 18,
                                              backgroundColor: AppColor.bgColor,
                                              child: Center(
                                                child: SizedBox(
                                                  height: 35,
                                                  child: SvgPicture.asset(
                                                      'assets/investigation.svg'),
                                                ),
                                              ),
                                            ),
                                        height: 50,
                                        fit: BoxFit.fitHeight,
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            resultData.itemName.toString(),
                                            style: MyTextTheme().mediumBCB,
                                          ),
                                          Text(
                                            resultData.testDetails!.isEmpty
                                                ? ''
                                                : resultData
                                                .testDetails![0].subTestName
                                                .toString(),
                                            style: MyTextTheme().smallBCN,
                                          ),
                                        ],
                                      )
                                      // Column(
                                      //   crossAxisAlignment: CrossAxisAlignment.start,
                                      //   children: [
                                      //     Text(
                                      //       erasInvestigation.pathologyName.toString().toUpperCase(),
                                      //       style: MyTextTheme().mediumBCB,
                                      //     ),
                                      //     Text(
                                      //       erasInvestigation.investigation!.isEmpty
                                      //           ? ''
                                      //           : erasInvestigation.investigation![0].testName
                                      //           .toString(),
                                      //       style: MyTextTheme().smallBCN,
                                      //     )
                                      //   ],
                                      // )
                                    ],
                                  ),
                                  Divider(
                                    color: AppColor.greyDark,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      // Text(
                                      //   manuallyData.receiptNo.toString(),
                                      //   style: MyTextTheme()
                                      //       .smallGCN
                                      //       .copyWith(color: Colors.teal),
                                      // ),

                                      Column(
                                        children: [
                                          Text(localization.getLocaleData.hintText!.receiptNo.toString(),
                                              style: MyTextTheme().smallBCN),
                                          Text(
                                            ''.toString(),
                                            style: MyTextTheme()
                                                .smallGCN
                                                .copyWith(color: Colors.teal),
                                          ),
                                        ],
                                      ),
                                      Text(
                                        erasInvestigation.billDate.toString(),
                                        style: MyTextTheme()
                                            .smallGCN
                                            .copyWith(color: Colors.teal),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ),
          );
        });
  }

  radiologyReport() {
    ApplicationLocalizations localization=Provider.of<ApplicationLocalizations>(context,listen: false);
    return GetBuilder(
        init: InvestigationController(),
        builder: (_) {
          return Center(
            child: CommonWidgets().showNoData(
              title: localization.getLocaleData.radiologyReportsNotFound.toString(),
              show: (modal.controller.getShowNoData &&
                  modal.controller.getRadiologyList.isEmpty),
              loaderTitle: localization.getLocaleData.loading.toString(),
              showLoader: (!modal.controller.getShowNoData &&
                  modal.controller.getRadiologyList.isEmpty),
              child: ListView.builder(
                itemCount: modal.controller.getRadiologyList.length,
                itemBuilder: (BuildContext context, int index) {
                  RadiologyDataModal radiologyData =
                  modal.controller.getRadiologyList[index];
                  return Container(
                    decoration: BoxDecoration(
                        color: AppColor.white,
                        borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(15, 8, 8, 8),
                      child: Row(
                        children: [
                          Text(
                            (index + 1).toString() + ' .',
                            style: MyTextTheme().mediumBCB,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            '${UserData().getUserName} ( ${UserData().getUserPid} )',
                            style: MyTextTheme().mediumBCB,
                          ),
                          const Expanded(
                              child: SizedBox(
                                width: 5,
                              )),
                          InkWell(
                            onTap: () {
                              App().navigate(
                                  context,
                                  InAppWebViewScreen(
                                      myUrl: radiologyData.pacsURL.toString()));
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(15),
                              child: Icon(
                                Icons.remove_red_eye,
                                color: AppColor.primaryColor,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          );
        });
  }
}
