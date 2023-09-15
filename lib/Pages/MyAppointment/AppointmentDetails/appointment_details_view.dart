import 'package:cached_network_image/cached_network_image.dart';
import 'package:digi_doctor/AppManager/ImageView.dart';
import 'package:flutter/foundation.dart';
import '../../../AppManager/user_data.dart';
import '../../../Localization/app_localization.dart';
import 'package:digi_doctor/AppManager/app_color.dart';
import 'package:digi_doctor/AppManager/app_util.dart';
import 'package:digi_doctor/AppManager/my_text_theme.dart';
import 'package:digi_doctor/AppManager/widgets/my_button2.dart';
import 'package:digi_doctor/Pages/MyAppointment/AppointmentDetails/Modules/add_review.dart';
import 'package:digi_doctor/Pages/MyAppointment/AppointmentDetails/appointment_details_modal.dart';
import 'package:digi_doctor/Pages/MyAppointment/AppointmentDetails/send_document_view.dart';
import 'package:digi_doctor/Pages/Specialities/SpecialistDoctors/TimeSlot/time_slot_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../AppManager/VideoPlayer.dart';
import '../../../AppManager/widgets/my_app_bar.dart';
import '../../Dashboard/Widget/profile_info_widget.dart';
import '../../Specialities/top_specialities_view.dart';
import '../MyAppointmentDataModal/my_appointment_data_modal.dart';
import 'appointment_details_controller.dart';

class AppointmentDetailsView extends StatefulWidget {
  final MyAppointmentDataModal appointmentData;

  const AppointmentDetailsView({Key? key, required this.appointmentData})
      : super(key: key);

  @override
  State<AppointmentDetailsView> createState() => _AppointmentDetailsViewState();
}

class _AppointmentDetailsViewState extends State<AppointmentDetailsView> {
  AppointmentDetailsModal modal = AppointmentDetailsModal();
  bool isDoctor = true;
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
  get() async {
    modal.prescriptionController.appointmentId.value =
        widget.appointmentData.appointmentId.toString();
    modal.controller.selectedAppointmentId.value =
        widget.appointmentData.appointmentId.toString();
    modal.controller.selectedDrIdC.value.text =
        widget.appointmentData.doctorId.toString();

    await modal.appointmentDetails(context);
    if (kDebugMode) {
      print('-------------------${modal.controller.selectedAppointmentId.value}');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      get();
    });
  }


  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    Get.delete<AppointmentDetailsController>();
  }

  @override
  Widget build(BuildContext context) {
    ApplicationLocalizations localization=Provider.of<ApplicationLocalizations>(context,listen: true);
    return Container(
      color: AppColor.primaryColor,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
         // appBar: MyWidget().myAppBar(context, title: localization.getLocaleData.appointmentDetails.toString(),),
          body: Row(
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
                                              OptionDataModals opts=modal.controller.getOption(context)[index];
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
                                                       // App().navigate(context, TopSpecialitiesView());
                                                      }
                                                      else{
                                                        isDoctor = false;
                                                       // App().navigate(context, TopSpecialitiesView(isDoctor:1));

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
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16,20,5,5),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 25),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(UserData().getUserName.toString(),style: MyTextTheme().largePCB.copyWith(color: AppColor.primaryColorLight,fontSize: 25)),
                                Row(
                                  children: [

                                    Text(UserData().getUserGender.toString()=='1'? 'Male':'Female',style: MyTextTheme().mediumGCN.copyWith(fontSize: 18)),
                                    Text(" ${DateTime.now().year-int.parse(UserData().getUserDob.split('/')[2])} years ",style: MyTextTheme().mediumGCN.copyWith(fontSize: 18)),
                                  ],
                                ),
                                Text(UserData().getUserMobileNo,style: MyTextTheme().mediumGCN.copyWith(fontSize: 18)),
                                Text(UserData().getUserEmailId,style: MyTextTheme().mediumGCN.copyWith(fontSize: 18)),
                              ],
                            ),
                          ),
                          const Expanded(child: SizedBox()),
                          Expanded(flex: 8,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: const [
                                  ProfileInfoWidget()
                                ],
                              )
                          ),


                        ],),
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: GetBuilder(
                            init: AppointmentDetailsController(),
                            builder: (_) {
                              return Padding(
                                padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [

                                    Row(
                                      children: [
                                        Image.asset(
                                          'assets/prescription.png',
                                          width: 30,
                                          height: 30,
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                widget.appointmentData.doctorName
                                                    .toString(),
                                                style: MyTextTheme().mediumBCB,
                                              ),
                                              Text(
                                                widget.appointmentData.degree
                                                    .toString(),
                                                style: MyTextTheme().mediumBCN,
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.add_location,
                                          color: AppColor.primaryColor,
                                          size: 25,
                                        ),
                                        const SizedBox(
                                          width: 15,
                                        ),
                                        Text(
                                          widget.appointmentData.address.toString(),
                                          style: MyTextTheme().mediumBCB,
                                        )
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          height: 18,
                                          width: 18,
                                          child: SvgPicture.asset(
                                            'assets/calender.svg',
                                            fit: BoxFit.cover,
                                            color: AppColor.primaryColor,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 22,
                                        ),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: Text(
                                                      localization.getLocaleData.dateAndTime.toString(),
                                                      style: MyTextTheme().mediumBCB,
                                                    ),
                                                  ),
                                                  Visibility(
                                                    visible: widget.appointmentData
                                                        .isPrescribed ==
                                                        true,
                                                    child: InkWell(
                                                      onTap: () async {
                                                        if(modal.controller.getLatestAppointment.isReview==0){
                                                          await addReview(context);
                                                        }

                                                      },
                                                      child: Container(
                                                        padding:
                                                        const EdgeInsets.symmetric(
                                                            horizontal: 10,
                                                            vertical: 4),
                                                        decoration: BoxDecoration(
                                                          borderRadius:
                                                          BorderRadius.circular(10),
                                                          color:modal.controller.getLatestAppointment.isReview==0?
                                                          AppColor.orangeColorDark:AppColor.greyLight,
                                                        ),
                                                        child: Text(
                                                          localization.getLocaleData.review.toString(),
                                                          style: MyTextTheme().smallWCB.copyWith(
                                                              color:modal.controller.getLatestAppointment.isReview==0?
                                                              AppColor.white:AppColor.greyDark
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              Text(
                                                '${DateFormat('dd MMMM yyyy').format(
                                                    DateFormat('yyyy-MM-dd').parse(
                                                      widget.appointmentData
                                                          .appointmentDate
                                                          .toString(),
                                                    ))}  ${DateFormat('hh:mm a').format(
                                                        DateFormat('hh:mm:ss').parse(
                                                            widget.appointmentData
                                                                .appointmentTime
                                                                .toString()))}',
                                                textAlign: TextAlign.left,
                                                style: MyTextTheme().mediumGCN,
                                              ),
                                              const Divider(
                                                thickness: 1,
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Icon(
                                          Icons.person,
                                          color: AppColor.primaryColor,
                                          size: 25,
                                        ),
                                        const SizedBox(
                                          width: 15,
                                        ),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                localization.getLocaleData.medicalProblem.toString(),
                                                style: MyTextTheme().mediumBCB,
                                              ),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              Text(
                                                widget.appointmentData.problemName
                                                    .toString(),
                                                textAlign: TextAlign.left,
                                                style: MyTextTheme().mediumBCN,
                                              ),
                                              const SizedBox(
                                                height: 20,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                                children: [
                                                  Column(
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        localization.getLocaleData.bookedFor.toString(),
                                                        style: MyTextTheme().mediumBCB,
                                                      ),
                                                      const SizedBox(
                                                        height: 5,
                                                      ),
                                                      Text(
                                                          widget.appointmentData
                                                              .patientName
                                                              .toString(),
                                                          style:
                                                          MyTextTheme().mediumBCN),
                                                    ],
                                                  ),
                                                  Column(
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        localization.getLocaleData.appointmentID.toString(),
                                                        style: MyTextTheme().mediumBCB,
                                                      ),
                                                      const SizedBox(
                                                        height: 5,
                                                      ),
                                                      Text(
                                                          widget.appointmentData
                                                              .appointmentIdView
                                                              .toString(),
                                                          style:
                                                          MyTextTheme().mediumBCN),
                                                      const SizedBox(
                                                        height: 10,
                                                      ),
                                                      widget.appointmentData
                                                          .expiredStatus !=
                                                          0
                                                          ? Container(
                                                        width: 100,
                                                        padding: const EdgeInsets
                                                            .symmetric(
                                                            horizontal: 10,
                                                            vertical: 5),
                                                        decoration: BoxDecoration(
                                                            color: AppColor.red,
                                                            borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                15)),
                                                        child: Text(
                                                          localization.getLocaleData.expired.toString(),
                                                          textAlign:
                                                          TextAlign.center,
                                                          style: MyTextTheme()
                                                              .smallWCB,
                                                        ),
                                                      )
                                                          : widget.appointmentData
                                                          .isPrescribed ==
                                                          true
                                                          ? Container(
                                                        width: 100,
                                                        padding:
                                                        const EdgeInsets
                                                            .symmetric(
                                                            horizontal:
                                                            10,
                                                            vertical: 5),
                                                        decoration: BoxDecoration(
                                                            color: AppColor
                                                                .green,
                                                            borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                15)),
                                                        child: Text(
                                                          localization.getLocaleData.prescribed.toString(),
                                                          style: MyTextTheme()
                                                              .smallWCB,
                                                        ),
                                                      )
                                                          : Container(
                                                        width: 100,
                                                        padding:
                                                        const EdgeInsets
                                                            .symmetric(
                                                            horizontal:
                                                            10,
                                                            vertical: 5),
                                                        decoration: BoxDecoration(
                                                            color:!widget.appointmentData.isCancelled? AppColor
                                                                .orangeColorDark:AppColor.red,
                                                            borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                15)),
                                                        child: Text(
                                                          !widget.appointmentData.isCancelled? localization.getLocaleData.confirmed.toString():"Cancelled",
                                                          style: MyTextTheme()
                                                              .smallWCB,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Visibility(
                                      visible: widget.appointmentData.expiredStatus !=
                                          1 &&
                                          widget.appointmentData.isPrescribed != true,
                                      child:!widget.appointmentData.isCancelled? Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 5),
                                        width: MediaQuery
                                            .of(context)
                                            .size
                                            .width,
                                        color: Colors.orangeAccent.withOpacity(0.15),
                                        child: Column(
                                          children: [
                                            Text(
                                              localization.getLocaleData.sendYourDataToDoctor.toString(),
                                              style: MyTextTheme().mediumBCN,
                                              textAlign: TextAlign.center,
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            InkWell(
                                              onTap: () {
                                                App().navigate(
                                                    context, SendDocumentView(appointmentId: widget.appointmentData.appointmentId.toString(),));
                                              },
                                              child: Container(
                                                padding: const EdgeInsets.symmetric(
                                                    horizontal: 20, vertical: 8),
                                                decoration: BoxDecoration(
                                                    color: AppColor.primaryColor,
                                                    borderRadius:
                                                    BorderRadius.circular(15)),
                                                child: Text(
                                                  widget.appointmentData.attachFile!
                                                      .isEmpty
                                                      ? localization.getLocaleData.upload.toString()
                                                      : localization.getLocaleData.addMore.toString(),
                                                  style: MyTextTheme().mediumWCB,
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                          ],
                                        ),
                                      ):const SizedBox(),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    modal.controller.getLatestAppointment
                                        .attachFile!.isEmpty ? const SizedBox()
                                        :
                                    GridView.count(
                                        shrinkWrap: true,
                                        physics:
                                        const NeverScrollableScrollPhysics(),
                                        crossAxisCount: 4,
                                        crossAxisSpacing: 50,
                                        mainAxisSpacing: 10,
                                        children: List.generate(
                                            modal.controller.getLatestAppointment
                                                .attachFile!.length, (index) {
                                          AttachFileDataModal fileData = modal
                                              .controller
                                              .getLatestAppointment
                                              .attachFile![index];
                                          return InkWell(
                                            onTap: () {
                                              if (kDebugMode) {
                                                print( modal
                                                  .controller
                                                  .getLatestAppointment
                                                  .attachFile![index]
                                                  .filePath
                                                  .toString());
                                                print( modal
                                                    .controller
                                                    .getLatestAppointment
                                                    .attachFile![index]
                                                    .fileType
                                                    .toString());
                                              }


                                              if (fileData.fileType.toString() ==
                                                  'jpg') {
                                                App().navigate(
                                                    context,
                                                    ImageView(
                                                        url: fileData.filePath.toString()));
                                              } else {
                                                App().navigate(
                                                    context,
                                                    VideoPlayer(
                                                        url: modal
                                                            .controller
                                                            .getLatestAppointment
                                                            .attachFile![index]
                                                            .filePath
                                                            .toString()));
                                              }
                                            },
                                            child: CachedNetworkImage(
                                              imageUrl:
                                              modal
                                                  .controller
                                                  .getLatestAppointment
                                                  .attachFile![index]
                                                  .filePath
                                                  .toString(),
                                              placeholder: (context, url) =>
                                              modal
                                                  .controller
                                                  .getLatestAppointment
                                                  .attachFile![index]
                                                  .fileType == 'jpg' ?
                                              SvgPicture.asset(
                                                'assets/image.svg',
                                                height: 55,
                                                width: 55,
                                              ) : modal
                                                  .controller
                                                  .getLatestAppointment
                                                  .attachFile![index]
                                                  .fileType == 'mp4' ? SvgPicture.asset(
                                                'assets/video.svg',
                                                height: 55,
                                                width: 55,
                                              ) : SvgPicture.asset(
                                                'assets/audio.svg',
                                                height: 55,
                                                width: 55,
                                              ),
                                              errorWidget: (context, url, error) =>
                                              modal
                                                  .controller
                                                  .getLatestAppointment
                                                  .attachFile![index]
                                                  .fileType == 'jpg' ?
                                              SvgPicture.asset(
                                                'assets/image.svg',
                                                height: 55,
                                                width: 55,
                                              ) : modal
                                                  .controller
                                                  .getLatestAppointment
                                                  .attachFile![index]
                                                  .fileType == 'mp4' ? SvgPicture.asset(
                                                'assets/video.svg',
                                                height: 55,
                                                width: 55,
                                              ) : SvgPicture.asset(
                                                'assets/audio.svg',
                                                height: 55,
                                                width: 55,
                                              ),
                                            ),
                                          );
                                        })),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Visibility(
                                      visible: modal.controller.getOtherAppointmentList
                                          .isNotEmpty,
                                      child: Column(
                                        children: [
                                          Text(
                                            localization.getLocaleData.oldAppointments.toString(),
                                            style: MyTextTheme().mediumBCB,
                                          ),
                                          ListView.builder(
                                              shrinkWrap: true,
                                              physics:
                                              const NeverScrollableScrollPhysics(),
                                              itemCount: modal.controller
                                                  .getOtherAppointmentList.length,
                                              itemBuilder:
                                                  (BuildContext context, int index) {
                                                MyAppointmentDataModal
                                                otherAppointment = modal.controller
                                                    .getOtherAppointmentList[index];
                                                return Padding(
                                                  padding: const EdgeInsets.symmetric(
                                                      vertical: 5),
                                                  child: Card(
                                                    child: InkWell(
                                                      onTap: () {
                                                        App().navigate(
                                                            context,
                                                            AppointmentDetailsView(
                                                              appointmentData:
                                                              otherAppointment,
                                                            ));
                                                      },
                                                      child: Container(
                                                        padding:
                                                        const EdgeInsets.all(8.0),
                                                        decoration: BoxDecoration(
                                                          color: AppColor.white,
                                                          borderRadius:
                                                          BorderRadius.circular(10),
                                                        ),
                                                        child: IntrinsicHeight(
                                                          child: Row(
                                                            children: [
                                                              Column(
                                                                children: [
                                                                  Text(
                                                                    DateFormat.E()
                                                                        .format(
                                                                        DateFormat(
                                                                            'yyyy-MM-dd')
                                                                            .parse(
                                                                            otherAppointment
                                                                                .appointmentDate
                                                                                .toString())),
                                                                    style: MyTextTheme()
                                                                        .mediumBCN,
                                                                  ),
                                                                  const SizedBox(
                                                                    height: 5,
                                                                  ),
                                                                  Text(
                                                                    DateFormat('dd')
                                                                        .format(
                                                                        DateFormat(
                                                                            'yyyy-MM-dd')
                                                                            .parse(
                                                                            otherAppointment
                                                                                .appointmentDate
                                                                                .toString())),
                                                                    style: MyTextTheme()
                                                                        .largeBCB
                                                                        .copyWith(
                                                                        color: AppColor
                                                                            .orangeColorDark),
                                                                  ),
                                                                  const SizedBox(
                                                                    height: 5,
                                                                  ),
                                                                  Text(
                                                                    DateFormat.MMM()
                                                                        .format(
                                                                        DateFormat(
                                                                            'yyyy-MM-dd')
                                                                            .parse(
                                                                            otherAppointment
                                                                                .appointmentDate
                                                                                .toString())),
                                                                    style: MyTextTheme()
                                                                        .mediumBCN,
                                                                  ),
                                                                ],
                                                              ),
                                                              const SizedBox(
                                                                width: 10,
                                                              ),
                                                              Container(
                                                                width: 1,
                                                                color:
                                                                AppColor.greyDark,
                                                              ),
                                                              const SizedBox(
                                                                width: 10,
                                                              ),
                                                              Expanded(
                                                                child: Column(
                                                                  crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                                  children: [
                                                                    Text(
                                                                      otherAppointment
                                                                          .doctorName
                                                                          .toString(),
                                                                      style:
                                                                      MyTextTheme()
                                                                          .mediumBCB,
                                                                    ),
                                                                    const SizedBox(
                                                                      height: 5,
                                                                    ),
                                                                    Text(
                                                                      otherAppointment
                                                                          .specialty
                                                                          .toString(),
                                                                      style:
                                                                      MyTextTheme()
                                                                          .smallBCN,
                                                                    ),
                                                                    const SizedBox(
                                                                      height: 5,
                                                                    ),
                                                                    Row(
                                                                      mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                      children: [
                                                                        Text(
                                                                          DateFormat(
                                                                              'hh:mm a')
                                                                              .format(
                                                                              DateFormat(
                                                                                  'hh:mm:ss')
                                                                                  .parse(
                                                                                  otherAppointment
                                                                                      .appointmentTime
                                                                                      .toString())),
                                                                          style: MyTextTheme()
                                                                              .smallBCN,
                                                                        ),
                                                                        otherAppointment
                                                                            .expiredStatus !=
                                                                            0
                                                                            ? Container(
                                                                          width:
                                                                          80,
                                                                          padding: const EdgeInsets
                                                                              .symmetric(
                                                                              horizontal:
                                                                              10,
                                                                              vertical:
                                                                              5),
                                                                          decoration: BoxDecoration(
                                                                              color:
                                                                              AppColor
                                                                                  .red,
                                                                              borderRadius: BorderRadius
                                                                                  .circular(
                                                                                  15)),
                                                                          child:
                                                                          Text(
                                                                            localization.getLocaleData.expired.toString(),
                                                                            textAlign:
                                                                            TextAlign
                                                                                .center,
                                                                            style:
                                                                            MyTextTheme()
                                                                                .smallWCB,
                                                                          ),
                                                                        )
                                                                            : Container(
                                                                          width:
                                                                          80,
                                                                          padding: const EdgeInsets
                                                                              .symmetric(
                                                                              horizontal:
                                                                              10,
                                                                              vertical:
                                                                              5),
                                                                          decoration: BoxDecoration(
                                                                              color:
                                                                              AppColor
                                                                                  .orangeColorDark,
                                                                              borderRadius: BorderRadius
                                                                                  .circular(
                                                                                  15)),
                                                                          child:
                                                                          Text(
                                                                            localization.getLocaleData.confirmed.toString(),
                                                                            style:
                                                                            MyTextTheme()
                                                                                .smallWCB,
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    )
                                                                  ],
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              }),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              );
                            }),
                      ),
                    ),
                    widget.appointmentData.expiredStatus != 0
                        ? MyButton2(
                      title: localization.getLocaleData.expired.toString(),
                      color: AppColor.red,
                      width: 300,
                      onPress: () {},
                    )
                        : widget.appointmentData.isPrescribed == true
                        ? MyButton2(
                        title: localization.getLocaleData.viewPrescription.toString(),
                        color: AppColor.green,
                        width: 300,
                        onPress: () async {
                          await modal.onPressedViewPrescription(context);
                        })
                        :!widget.appointmentData.isCancelled? Padding(
                      padding:  const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: MyButton2(
                                title: localization.getLocaleData.cancelAppointment.toString(),
                                color: AppColor.red,
                                onPress: () async {
                                  await modal.onPressedCancel(context);
                                }),
                          ),
                          const SizedBox(width: 10,),
                          Expanded(
                            child: MyButton2(
                                title: localization.getLocaleData.reSchedule.toString(), width: 300, onPress: () {

                              App().navigate(context, TimeSlotView(
                                  selectedDay: DateFormat.E().format(DateTime.parse(widget.appointmentData.appointmentDate.toString())),
                                  doctorId: widget.appointmentData.doctorId.toString(),
                                  iSEraDoctor: widget.appointmentData.isEraUser.toString(),
                                  drName: widget.appointmentData.doctorName.toString(),
                                  speciality: widget.appointmentData.specialty.toString(),
                                  degree: widget.appointmentData.degree.toString(),
                                  timeSlots:modal.controller.getSortDaysList,
                                  fees:modal.controller.getLatestAppointment.doctorFees??0.0));
                            }),
                          ),
                        ],
                      ),
                    ):const SizedBox(),
                    const SizedBox(
                      height: 10,
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
