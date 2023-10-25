import 'package:cached_network_image/cached_network_image.dart';
import 'package:digi_doctor/AppManager/app_color.dart';
import 'package:digi_doctor/AppManager/my_text_theme.dart';
import 'package:digi_doctor/AppManager/widgets/customInkWell.dart';
import 'package:digi_doctor/Pages/Dashboard/Widget/profile_info_widget.dart';
import 'package:digi_doctor/Pages/MyAppointment/my_appointment_modal.dart';
import 'package:digi_doctor/Pages/VitalPage/LiveVital/stetho_master/AppManager/widgets/my_text_field_2.dart';
import 'package:digi_doctor/Pages/voiceAssistantProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../Localization/app_localization.dart';
import '../../AppManager/app_util.dart';
import '../../AppManager/widgets/common_widgets.dart';
import '../../AppManager/widgets/date_time_field.dart';
import '../../AppManager/widgets/my_button.dart';
import '../Dashboard/Widget/footerView.dart';
import '../Dashboard/Widget/medicalHistoryWidget.dart';
import '../InvestigationHistory/DataModal/investigation_history_data_modal.dart';
import '../InvestigationHistory/Microbiology/microbiology_view.dart';
import '../InvestigationHistory/ViewInvestigation/view_investigation.dart';
import '../InvestigationHistory/investigation_controller.dart';
import '../InvestigationHistory/investigation_view.dart';
import '../InvestigationHistory/investigaton_modal.dart';
import '../InvestigationHistory/radiology/radiology_view.dart';
import '../NewLabTest/lab_test_navigation_view.dart';
import '../VitalPage/Add Vitals/VitalHistory/vital_history_controller.dart';
import '../VitalPage/Add Vitals/VitalHistory/vital_history_modal.dart';
import '../VitalPage/Add Vitals/VitalHistory/vital_history_view.dart';
import '../VitalPage/Add Vitals/add_vitals_controller.dart';
import '../VitalPage/Add Vitals/add_vitals_modal.dart';
import '../VitalPage/Add Vitals/add_vitals_view.dart';
import '../VitalPage/DataModal/vital_history_data_modal.dart';
import '../prescription_history/dataModal/prescription_history_data_modal.dart';
import '../prescription_history/prescription_history_modal.dart';
import 'AppointmentDetails/appointment_details_modal.dart';
import 'MyAppointmentDataModal/my_appointment_data_modal.dart';
import 'appointmentDataModal.dart';
import 'my_appointment_controller.dart';

class MyAppointmentView extends StatefulWidget {
  final int? page;
  final String? mainHeading;
  const MyAppointmentView({
    Key? key, this.page, this.mainHeading,
  }) : super(key: key);

  @override
  State<MyAppointmentView> createState() => _MyAppointmentViewState();
}

class _MyAppointmentViewState extends State<MyAppointmentView> {
  MyAppointmentModal modal = MyAppointmentModal();
  VitalHistoryModal vitalsmodal = VitalHistoryModal();
  AddVitalsModel addVitalsModel = AddVitalsModel();
  InvestigationModal investigationModel = InvestigationModal();
  PrescriptionHistoryModal prescriptionModal = PrescriptionHistoryModal();

  get() async {
    VoiceAssistantProvider listenVM=Provider.of<VoiceAssistantProvider>(context,listen: false);
    listenVM.listeningPage="My appointment";
  //  await modal.getPatientAppointmentList(context);
    await modal.getMedvantageUserAppointment(context);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      updateContainerIndex=widget.mainHeading??'0';
      get();
      getVitals();
      getInvestigation();
    });
  }
  getInvestigation() async {
    await investigationModel.getManualInvestigation(context);
    await investigationModel.getBMI(context);
    if (investigationModel.controller.getIsNotification == 1){
      investigationModel.getRadioLogyReport(context);
      investigationModel.getMicrobiologyReport(context);

    }

  }


  getVitals() async {
    vitalsmodal.controller.dateFromC.value.text = DateFormat('yyyy-MM-dd')
        .format(DateTime.now().subtract(const Duration(days: 9)));
    vitalsmodal.controller.dateToC.value.text =
        DateFormat('yyyy-MM-dd').format(DateTime.now());
    await vitalsmodal.getPatientVitalsDateWiseHistory(context);
    //**
    for(int i=0;i<addVitalsModel.controller.vitalTextX.length;i++){
      addVitalsModel.controller.vitalTextX[i].clear();
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    Get.delete<MyAppointmentController>();
  }

  List abc =[
    {
      'name':'Confirmed'
    },
    {
      'name':'Expired'
    },
    {
      'name':'Prescribed'
    },
  ];


  @override
  Widget build(BuildContext context) {
    ApplicationLocalizations localization=Provider.of<ApplicationLocalizations>(context,listen: true);
    return Container(
      height: Get.height,
      width: Get.width,
      color: AppColor.primaryColor,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          //appBar: MyWidget().myAppBar(context, title: localization.getLocaleData.myAppointments.toString()),
          body: GetBuilder(
              init: MyAppointmentController(),
              builder: (_) {
                print("object$getContainerIndex");
                return Container(
                  decoration: const BoxDecoration(
                    image:DecorationImage(image: AssetImage("assets/kiosk_bg.png",),fit: BoxFit.fill),
                  ),
                  child: Column(
                    children: [
                     const SizedBox(
                       height: 80,
                         child: ProfileInfoWidget()),

                      SizedBox(
                        height: Get.height*0.12,
                         child: ListView.builder(
                            itemCount:getAVIData(context).length,

                            scrollDirection: Axis.horizontal,
                            itemBuilder: (BuildContext context, int index){
                              AVIDataModal data =getAVIData(context)[index];
                              return    InkWell(
                                onTap: (){
                                  setState((){
                                    updateContainerIndex=index.toString();
                                  });
                                },
                                child: Center(
                                  child: Padding(
                                    padding:
                                    const EdgeInsets.symmetric(
                                        vertical: 20,
                                        horizontal: 12),
                                    child: Container(
                                    //  width: Get.width/3.3,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: getContainerIndex.toString()==index.toString()?AppColor
                                            .primaryColor:AppColor.white,
                                      ),

                                      child: Padding(
                                        padding:
                                        const EdgeInsets.all(
                                            8.0),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Image.asset(
                                              data.containerImage.toString(),
                                              height: 40,
                                              color: getContainerIndex.toString()==index.toString()?AppColor.white:AppColor.greyDark,
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              data.containerText.toString(),
                                              style: getContainerIndex.toString()==index.toString()
                                                  ?
                                              MyTextTheme()
                                                  .largeWCN:MyTextTheme()
                                                  .largeBCN,
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }),
                       ),

                      // Row(
                      //   children: [
                      //     InkWell(
                      //                                 onTap: (){
                      //                                  // App().navigate(context, const VitalHistoryView());
                      //                                 },
                      //                                 child: Padding(
                      //                                   padding:
                      //                                   const EdgeInsets.symmetric(
                      //                                       vertical: 20,
                      //                                       horizontal: 12),
                      //                                   child: Container(
                      //                                     height: 40,width: 200,
                      //                                     color: AppColor
                      //                                         .primaryColorLight,
                      //                                     child: Padding(
                      //                                       padding:
                      //                                       const EdgeInsets.all(
                      //                                           8.0),
                      //                                       child: Row(
                      //                                         mainAxisAlignment: MainAxisAlignment.center,
                      //                                         children: [
                      //                                           Image.asset(
                      //                                             'assets/kiosk_setting.png',
                      //                                             height: 40,
                      //                                           ),
                      //                                           const SizedBox(
                      //                                             width: 10,
                      //                                           ),
                      //                                           Expanded(
                      //                                             child: Text(
                      //                                               "Appointment History",
                      //                                               style: MyTextTheme()
                      //                                                   .largeWCN,
                      //                                             ),
                      //                                           )
                      //                                         ],
                      //                                       ),
                      //                                     ),
                      //                                   ),
                      //                                 ),
                      //                               ),
                      //
                      //
                      //     InkWell(
                      //                                 onTap: (){
                      //                                   App().replaceNavigate(context,  const VitalHistoryView());
                      //                                 },
                      //                                 child: Padding(
                      //                                   padding:
                      //                                   const EdgeInsets.symmetric(
                      //                                       vertical: 20,
                      //                                       horizontal: 12),
                      //                                   child: Container(
                      //                                     height: 40,width: 200,
                      //                                     color: AppColor
                      //                                         .primaryColor,
                      //                                     child: Padding(
                      //                                       padding:
                      //                                       const EdgeInsets.all(
                      //                                           8.0),
                      //                                       child: Row(
                      //                                         children: [
                      //                                           Image.asset(
                      //                                             'assets/kiosk_vitals.png',
                      //                                             height: 40,
                      //                                           ),
                      //                                           const SizedBox(
                      //                                             width: 10,
                      //                                           ),
                      //                                           Expanded(
                      //                                             child: Text(
                      //                                               "Vital History",
                      //                                               style: MyTextTheme()
                      //                                                   .largeWCN,
                      //                                             ),
                      //                                           )
                      //                                         ],
                      //                                       ),
                      //                                     ),
                      //                                   ),
                      //                                 ),
                      //                               ),
                      //
                      //
                      //                               InkWell(
                      //                                 onTap: (){
                      //                                   App().replaceNavigate(context, const InvestigationView());
                      //                                 },
                      //                                 child: Padding(
                      //                                   padding:
                      //                                   const EdgeInsets.symmetric(
                      //                                       vertical: 20,
                      //                                       horizontal: 12),
                      //                                   child: Container(
                      //                                     height: 40,width: 200,
                      //                                     color: AppColor
                      //                                         .primaryColor,
                      //                                     child: Padding(
                      //                                       padding:
                      //                                       const EdgeInsets.all(
                      //                                           8.0),
                      //                                       child: Row(
                      //                                         children: [
                      //                                           Image.asset(
                      //                                             'assets/find_symptom_img.png',
                      //                                             height: 40,
                      //                                           ),
                      //                                           const SizedBox(
                      //                                             width: 10,
                      //                                           ),
                      //                                           Expanded(
                      //                                             child: Text(
                      //                                               "Investigation History",
                      //                                               style: MyTextTheme()
                      //                                                   .largeWCN,
                      //                                             ),
                      //                                           )
                      //                                         ],
                      //                                       ),
                      //                                     ),
                      //                                   ),
                      //                                 ),
                      //                               ),
                      //
                      //
                      //
                      //
                      //
                      //
                      //   ],
                      // ),

                      getContainerIndex=="0"?
                      Expanded(
                        child: GetBuilder(
                          init: MyAppointmentController(),
                          builder: (_) {
                            return Padding(
                              padding: const EdgeInsets.fromLTRB(10,0,10,0),
                              child: Container(
                                width: Get.width,
                                decoration: BoxDecoration(
                                    color: Colors.grey.shade200,
                                  borderRadius: BorderRadius.circular(5)
                                ),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:MainAxisAlignment.spaceBetween,
                                        children: [
                                    Padding(
                                                padding: const EdgeInsets.all(20.0),
                                                child: Text(localization.getLocaleData.hintText!.appointment.toString(),style: MyTextTheme().largeBCB,),
                                              ),
                                      const Expanded(child: SizedBox()),


                                          Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: MyTextField2(
                                      controller: modal.controller.search.value,
                                      hintText: localization.getLocaleData.searchBy.toString(),
                                      onChanged: (val){
                                        print(val);
                                        setState(() {
                                        });
                                      },
                                    ),
                                  ),
                              ),
                                        ],
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 20,right: 20,bottom: 10),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [

                                            // Text(localization.getLocaleData.time.toString(),style: MyTextTheme().mediumBCB,),
                                            Text(localization.getLocaleData.hintText!.date.toString(),style: MyTextTheme().mediumBCB,),
                                            Text(localization.getLocaleData.patient.toString(),style: MyTextTheme().mediumBCB,),
                                            Text(localization.getLocaleData.hintText!.doctor.toString(),style: MyTextTheme().mediumBCB,),
                                            Text(localization.getLocaleData.hintText!.department.toString(),style: MyTextTheme().mediumBCB,),
                                            Text(localization.getLocaleData.hintText!.appointment.toString(),style: MyTextTheme().mediumBCB,),

                                          ],
                                        ),
                                      ),
                                CommonWidgets().showNoData(
                                  title: localization.getLocaleData.prescriptionHistoryNotFound.toString(),
                                  show: (modal.controller.getShowNoData &&
                                      modal.controller.getAppointmentList.isEmpty),
                                  loaderTitle: localization.getLocaleData.loadingPrescriptionHistory.toString(),
                                  showLoader: (!modal.controller.getShowNoData &&
                                      modal.controller.getAppointmentList.isEmpty),
                                      child:
                                      modal.controller.getAppointmentList.isNotEmpty?
                                      Expanded(
                                          child: AnimationLimiter(
                                            child: ListView.builder(
                                              itemCount: modal.controller.getAppointmentList.length,
                                                shrinkWrap: true,
                                                itemBuilder: (BuildContext context, int index){
                                                 // MyAppointmentDataModal appointmentData =modal.controller.getAppointmentList[index];
                                                  AppointmentHistoryDataModal appointmentData =modal.controller.getAppointmentList[index];
                                              return AnimationConfiguration.staggeredList(
                                                position: index,
                                                duration: const Duration(milliseconds: 800),

                                                child: InkWell(
                                                  onTap: () async {
                                                    // await prescriptionModal.getPrescriptionHistory(context,appointmentData.appointmentId);
                                                    // showPrescription(context,appointmentData);
                                                  },
                                                  child: Padding(
                                                    padding: const EdgeInsets.fromLTRB(0,5,0,3),
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        color: AppColor.white
                                                      ),
                                                      child: Padding(
                                                        padding: const EdgeInsets.only(left: 20,right: 20,top: 10,bottom: 10),
                                                        child: SlideAnimation(
                                                          verticalOffset: 50.0,
                                                          child: FadeInAnimation(
                                                            child: Row(
                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                              children: [
                                                                 // Text((index+1).toString(),style: MyTextTheme().mediumBCN,),
                                                                Text(appointmentData.appointmentDate.toString(),style: MyTextTheme().mediumBCN,),
                                                                Text(appointmentData.patientName.toString(),style: MyTextTheme().mediumBCN,),
                                                                Text(appointmentData.doctorName.toString(),style: MyTextTheme().mediumBCN,),
                                                                Text(appointmentData.departmentName.toString(),style: MyTextTheme().mediumBCN,),
                                                                Text(appointmentData.mobileNo.toString(),style: MyTextTheme().mediumBCN,),


                                                                // Text(appointmentData.departmentName.toString(),style: MyTextTheme().mediumBCN,),


                                                      //
                                                      // appointmentData.expiredStatus !=
                                                      //         0
                                                      //         ? Container(
                                                      //       width: 100,
                                                      //       padding:
                                                      //       const EdgeInsets
                                                      //           .symmetric(
                                                      //           horizontal: 10,
                                                      //           vertical: 5),
                                                      //       decoration: BoxDecoration(
                                                      //           color: AppColor.red,
                                                      //           borderRadius:
                                                      //           BorderRadius
                                                      //               .circular(
                                                      //               15)),
                                                      //       child: Text(
                                                      //         localization.getLocaleData.expired.toString(),
                                                      //         textAlign:
                                                      //         TextAlign.center,
                                                      //         style: MyTextTheme()
                                                      //             .smallWCB,
                                                      //       ),
                                                      // )
                                                      //         : appointmentData
                                                      //         .isPrescribed ==
                                                      //         true
                                                      //         ? Container(
                                                      //       width: 100,
                                                      //       padding:
                                                      //       const EdgeInsets
                                                      //           .symmetric(
                                                      //           horizontal:
                                                      //           10,
                                                      //           vertical:
                                                      //           5),
                                                      //       decoration: BoxDecoration(
                                                      //           color: AppColor
                                                      //               .green,
                                                      //           borderRadius:
                                                      //           BorderRadius
                                                      //               .circular(
                                                      //               15)),
                                                      //       child: Text(
                                                      //         textAlign: TextAlign.center,
                                                      //         localization.getLocaleData.prescribed.toString(),
                                                      //         style:
                                                      //         MyTextTheme()
                                                      //             .smallWCB,
                                                      //       ),
                                                      // )
                                                      //         : Container(
                                                      //       width: 100,
                                                      //       padding:
                                                      //       const EdgeInsets
                                                      //           .symmetric(
                                                      //           horizontal:
                                                      //           10,
                                                      //           vertical:
                                                      //           5),
                                                      //       decoration: BoxDecoration(
                                                      //           color:!appointmentData.isCancelled? AppColor
                                                      //               .orangeColorDark:AppColor.red,
                                                      //           borderRadius:
                                                      //           BorderRadius
                                                      //               .circular(
                                                      //               15)),
                                                      //       child: Text(
                                                      //         textAlign: TextAlign.center,
                                                      //         !appointmentData.isCancelled? localization.getLocaleData.confirmed.toString():"Cancelled",
                                                      //         style:
                                                      //         MyTextTheme()
                                                      //             .smallWCB,
                                                      //       ),
                                                      // )
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              );
                                            }),
                                          ),
                                      ):Expanded(
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Text("No data found",style: MyTextTheme().mediumBCB,),
                                          ],
                                        ),
                                      )
                                )
                                    ],
                                  ),
                              ),
                            );
                          }
                        ),
                      ):
                           getContainerIndex=="1"?
                           Expanded(
                        child: GetBuilder(
                          init: VitalHistoryController(),
                          builder: (_) {
                            return Padding(
                              padding: const EdgeInsets.fromLTRB(10,0,10,0),
                              child: Container(
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
                                                child: Text(localization.getLocaleData.hintText!.fromDate.toString(), style: MyTextTheme()
                                                    .mediumGCN
                                                    .copyWith(fontSize: 16))),
                                            // const SizedBox(
                                            //   width: 10,
                                            // ),
                                            Expanded(
                                                child: Text(localization.getLocaleData.hintText!.toDate.toString(), style: MyTextTheme()
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
                                                vitalsmodal.controller.dateFromC.value,
                                                onChanged: (val) async {
                                                  await vitalsmodal
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
                                                vitalsmodal.controller.dateToC.value,
                                                onChanged: (val) async {
                                                  await vitalsmodal
                                                      .getPatientVitalsDateWiseHistory(
                                                      context);
                                                },
                                              )),
                                          const SizedBox(width: 50,),
                                          Expanded(child: MyButton(
                                            color: AppColor.primaryColor,
                                            onPress: (){
                                               //App().navigate(context, AddVitalsView());
                                              showAlertDialog(context);
                                            },title:localization.getLocaleData.addManually.toString(),))
                                        ],
                                      ),


                                      Expanded(
                                        child: AnimationLimiter(
                                          child: ListView.builder(
                                              shrinkWrap: true,
                                              itemCount: vitalsmodal.controller
                                                  .getVitalHistoryList.length,
                                              itemBuilder: (BuildContext context, int index) {
                                                VitalHistoryDataModal historyData = vitalsmodal.controller.getVitalHistoryList[index];
                                                return AnimationConfiguration.staggeredList(
                                                  position: index,
                                                  duration: const Duration(milliseconds: 800),
                                                  child: SlideAnimation(
                                                    verticalOffset: 50.0,
                                                    child: FadeInAnimation(
                                                      child: Visibility(  
                                                        visible: historyData.vitalName.toString()!="RBS" && historyData.vitalName.toString()!="TEMPERATURE"&&
                                                            historyData.vitalName.toString()!="RESPRATE",
                                                        child: Padding(
                                                          padding: const EdgeInsets.all(8.0),
                                                          child: Container(
                                                            color: AppColor.white,
                                                            padding: const EdgeInsets.all(8),
                                                            child: Column(
                                                              children: [
                                                                GestureDetector(
                                                                  onTap: () async {
                                                                    await vitalsmodal.controller
                                                                        .updateHistoryData(index, historyData.isSelected as bool);
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
                                                                          child: Text(localization.getLocaleData.hintText!.viewDetails.toString(),style: MyTextTheme().mediumGCN,)
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
                                                                            child: SizedBox(
                                                                              width: 300,
                                                                              child: (vitalsmodal
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
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              }),
                                        ),
                                      ),



                                    ],
                                  ),
                                ),
                              ),
                            );
                          }
                        ),
                      ):
                           Expanded(
                             child: GetBuilder(
                              init: InvestigationController(),
                              builder: (_) {
                                return DefaultTabController(
                                  length: 5,
                                  initialIndex: widget.page??0,
                                  child: Padding(
                                    padding: const EdgeInsets.fromLTRB(10,0,10,0),
                                    child: Container(
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
                                                  investigationModel.controller.updateSelectedTab = val.toString();
                                                  await investigationModel.onPressedTab(context);
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
                                                         Text(localization.getLocaleData.hintText!.microbiology.toString()),
                                                        //Text(localization.getLocaleData.radiologyReport.toString()),
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
                                                         Text(localization.getLocaleData.hintText!.bmi.toString()),
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
                                                  manuallyReport(),
                                                  const LabTestNavigationView(isShowAppBar: false,),
                                                  const RadiologyView(),
                                                  const MicrobiologyView(),
                                                  AnimationLimiter(
                                                      child: ListView.separated( 
                                                      itemCount: investigationModel.controller.getBmI.length,
                                                      separatorBuilder: ((_, index) => const SizedBox(height: 15,)),
                                                      physics: const BouncingScrollPhysics(
                                                          parent: AlwaysScrollableScrollPhysics()),
                                                      itemBuilder: ((_, index) {
                                                        BmiModel bmiData = investigationModel.controller
                                                            .getBmI[index];
                                                        return AnimationConfiguration.staggeredList(
                                                          position: index,
                                                          duration: const Duration(milliseconds: 800),
                                                          child: SlideAnimation(
                                                            verticalOffset: 50.0,
                                                            child: FadeInAnimation(
                                                              child: CustomInkwell(
                                                                onPress: () {
                                                                // Get.to(()=>const MicrobiologyReportView(),arguments: {
                                                                //   "billNo":microbiologyData.labReportNo
                                                                // });
                                                              },
                                                                borderRadius: 10,
                                                                elevation: 3,
                                                                shadowColor: Colors.white,
                                                                child: Padding(
                                                                  padding: const EdgeInsets.fromLTRB(5, 12, 5, 12),
                                                                  child: Column(
                                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                                    children: [
                                                                      Padding(
                                                                        padding: const EdgeInsets.all(8.0),
                                                                        child: Row(
                                                                          mainAxisAlignment: MainAxisAlignment
                                                                              .spaceBetween,
                                                                          children: [
                                                                            Text(localization.getLocaleData.hintText!.bmi.toString(),
                                                                              style: MyTextTheme().mediumGCB,),
                                                                            Text(bmiData.bmiValue.toString(),
                                                                              style: MyTextTheme().mediumGCB,),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                      Padding(
                                                                        padding: const EdgeInsets.all(8.0),
                                                                        child: Row(
                                                                          mainAxisAlignment: MainAxisAlignment
                                                                              .spaceBetween,
                                                                          children: [
                                                                            Text(localization.getLocaleData.hintText!.yourHeight.toString(),
                                                                              style: MyTextTheme().mediumGCB,),
                                                                            Text(bmiData.height.toString(),
                                                                              style: MyTextTheme().mediumGCB,),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                      Padding(
                                                                        padding: const EdgeInsets.all(8.0),
                                                                        child: Row(
                                                                          mainAxisAlignment: MainAxisAlignment
                                                                              .spaceBetween,
                                                                          children: [
                                                                            Text(localization.getLocaleData.hintText!.yourWeight.toString(),
                                                                              style: MyTextTheme().mediumGCB,),
                                                                            Text(bmiData.weight.toString(),
                                                                              style: MyTextTheme().mediumGCB,),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                      // Text(bmiData.createdAt.toString(),
                                                                      //   style: MyTextTheme().mediumGCB,),
                                                                    ],
                                                                  ),
                                                                ),),
                                                            ),
                                                          ),
                                                        );
                                                      }),
                                                  ),
                                                    )
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              }
                          ),
                           ),
                      SizedBox(
                        height: Get.height*0.11,
                          child:  FooterView())
                    ],
                  ),
                );







              }),
        ),
      ),
    );
  }

  List<AVIDataModal> getAVIData(context) {
    ApplicationLocalizations localization = Provider.of<
        ApplicationLocalizations>(context, listen: false);
    //*******
    return [
      AVIDataModal(
        containerImage:  'assets/kiosk_setting.png',
        //containerText: "Appointment",
         containerText: localization.getLocaleData.hintText!.appointment.toString(),
        route:const MyAppointmentView(),
      ),
      AVIDataModal(
          containerImage: 'assets/kiosk_vitals.png',
           containerText: localization.getLocaleData.vitalHistory.toString(),
          //containerText: "Vital History",
          route: const VitalHistoryView()
      ),
      AVIDataModal(
        containerImage: 'assets/find_symptom_img.png',
         containerText: localization.getLocaleData.investigation.toString(),
        //containerText: "Investigation",
        route: const InvestigationView(),
      )
    ];
  }
  RxString containerIndex ="".obs;
  String get getContainerIndex => containerIndex.value;
  set updateContainerIndex(String val){
    containerIndex.value = val;
    //update();
  }


  manuallyReport() {
    ApplicationLocalizations localization=Provider.of<ApplicationLocalizations>(context,listen: false);

    return Center(
      child: CommonWidgets().showNoData(
        title: localization.getLocaleData.manualInvestigationNotFound.toString(),
        show: (modal.controller.getShowNoData &&
            investigationModel.controller.getManuallyList.isEmpty),
        loaderTitle: localization.getLocaleData.loading.toString(),
        showLoader: (!investigationModel.controller.getShowNoData &&
            investigationModel.controller.getManuallyList.isEmpty),
        child: ListView.builder(
          itemCount: investigationModel.controller.getManuallyList.length,
          itemBuilder: (BuildContext context, int index) {
            InvestigationHistoryDataModal manuallyData =
            investigationModel.controller.getManuallyList[index];
            return InkWell(
              onTap: () {
                App().navigate(
                    context,
                    ViewInvestigation(
                      index: index,
                      hospitalName: manuallyData.pathologyName.toString(),
                      receipt: manuallyData.receiptNo.toString(),
                      date: manuallyData.testDate.toString(),
                      investigation: manuallyData.investigation ?? [],
                      filePath: manuallyData.filePathList ?? [],
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
                            placeholder: (context, url) => CircleAvatar(
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
                            width: 20,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                manuallyData.pathologyName
                                    .toString()
                                    .toUpperCase(),
                                style: MyTextTheme().mediumBCB,
                              ),
                              Text(
                                manuallyData.investigation!.isEmpty
                                    ? ''
                                    : manuallyData.investigation![0].testName
                                    .toString(),
                                style: MyTextTheme().smallBCN,
                              )
                            ],
                          )
                        ],
                      ),
                      Divider(
                        color: AppColor.greyDark,
                      ),
                      Text(localization.getLocaleData.hintText!.receiptNo.toString(), style: MyTextTheme().smallBCN),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            manuallyData.receiptNo.toString(),
                            style: MyTextTheme()
                                .smallGCN
                                .copyWith(color: Colors.teal),
                          ),
                          Text(
                            manuallyData.testDate.toString(),
                            style: MyTextTheme()
                                .smallGCN
                                .copyWith(color: Colors.teal),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  showPrescription(context,MyAppointmentDataModal appointmentData,){

    // var prData=appointmentData.;
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
              height: Get.height*0.3,
              //********
              width:Get.width*0.8,
              //width: double.maxFinite,
              child:
              GetBuilder(
                init: MyAppointmentController(),
                builder: (MyAppointmentController controller) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(localization.getLocaleData.prescriptionDetails.toString(),style: MyTextTheme().largeBCN,),
                          Row(
                            children: [
                              Icon(Icons.calendar_today_outlined,color: AppColor.blue,),
                              const SizedBox(width: 10,),
                              Text(appointmentData.appointDate.toString(),style: MyTextTheme().smallBCN,),
                              const SizedBox(width: 40,),
                              InkWell(
                  onTap: (){
                    Navigator.pop(context);
                  }
                  ,child: Icon(Icons.clear,color: AppColor.red,))
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 15,),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Text("${localization.getLocaleData.patient}${localization.getLocaleData.hintText!.name}:",style: MyTextTheme().smallGCN,),
                              Text(appointmentData.patientName.toString(),style: MyTextTheme().mediumPCB,),
                            ],
                          ),
                          const SizedBox(height: 10,),
                          Row(
                            children: [
                              Text(localization.getLocaleData.hintText!.mobileNumber.toString(),style: MyTextTheme().smallGCN,),
                              const SizedBox(height: 15,),
                              Text(appointmentData.drMobileNo.toString(),style: MyTextTheme().mediumPCB,),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                               Text(localization.getLocaleData.diagnosis.toString(),),
                            ],
                          )
                        ],
                      ),
                      Row(

                        children: [
                          Text("${localization.getLocaleData.yourAppointment} :",style: MyTextTheme().smallBCN,),
                          Text(appointmentData.doctorName.toString(),style: MyTextTheme().smallPCB),
                        ],
                      ),

                      const SizedBox(height: 10,),

                      Row(
                        children: [
                          Text(localization.getLocaleData.diagnosis.toString(),style: MyTextTheme().smallBCN,),
                          Text(appointmentData.problemName.toString(),style: MyTextTheme().smallPCB)
                        ],
                      ),
                      const SizedBox(height: 10,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(localization.getLocaleData.Medicine.toString(),style: MyTextTheme().smallGCN,),
                          Text(localization.getLocaleData.dosageForm.toString(),style: MyTextTheme().smallGCN,),
                          Text(localization.getLocaleData.frequency.toString(),style: MyTextTheme().smallGCN,),
                          Text(localization.getLocaleData.strength.toString(),style: MyTextTheme().smallGCN,),
                          Text(localization.getLocaleData.unit.toString(),style: MyTextTheme().smallGCN,),
                          Text(localization.getLocaleData.duration.toString(),style: MyTextTheme().smallGCN,),
                        ],
                      ),
                      prescriptionModal.controller.getPrescriptionHistoryList[0].medicine_details!.isNotEmpty?
                      ListView.builder(
                          shrinkWrap: true,
                          itemCount: prescriptionModal.controller.getPrescriptionHistoryList[0].medicine_details!.length,
                          itemBuilder: (BuildContext context, int index){
                            //print("Animesh"+prData.medicine_details!.length.toString());
                            MedicineDetails medicineData=prescriptionModal.controller.getPrescriptionHistoryList[0].medicine_details![index];
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(medicineData.medicine_name.toString(),style: MyTextTheme().smallBCN),
                                  Text(medicineData.dosage_form_name.toString(),style: MyTextTheme().smallBCN),
                                  Text(medicineData.frequency_name.toString(),style: MyTextTheme().smallBCN),
                                  Text(medicineData.strength.toString(),style: MyTextTheme().smallBCN),
                                  Text(medicineData.unit_name.toString(),style: MyTextTheme().smallBCN),
                                  Text(medicineData.duration.toString(),style: MyTextTheme().smallBCN),
                                ],
                              ),
                            );
                          }):
                          //
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(height: 60,),
                          Text("No data found",style: MyTextTheme().mediumBCN,)
                        ],
                      )


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
                          Text(localization.getLocaleData.addVitals.toString(),style: MyTextTheme().mediumGCN.copyWith(fontSize: 20),),
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
                            Text('${localization.getLocaleData.hintText!.yourHeight} / ${localization.getLocaleData.hintText!.yourWeight}', style: MyTextTheme()
                                .mediumGCN
                                .copyWith(fontSize: 20)),
                            const SizedBox(height: 20,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(child: MyTextField2(hintText: localization.getLocaleData.hintText!.yourHeight.toString(),controller: addVitalsModel.controller.heightC.value,)),
                                const SizedBox(width: 15,),
                                Expanded(child: MyTextField2(hintText: localization.getLocaleData.hintText!.yourWeight.toString(),controller: addVitalsModel.controller.weightC.value)),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(15, 15,15, 15),
                        child: MyButton(
                          title: localization.getLocaleData.save.toString(),
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