import 'package:cached_network_image/cached_network_image.dart';
import 'package:digi_doctor/Pages/Dashboard/Widget/profile_info_widget.dart';
import 'package:digi_doctor/Pages/voiceAssistantProvider.dart';
import '../../../../Localization/app_localization.dart';
import 'package:digi_doctor/AppManager/app_util.dart';
import 'package:digi_doctor/Pages/Specialities/SpecialistDoctors/TimeSlot/time_slot_controller.dart';
import 'package:digi_doctor/Pages/Specialities/SpecialistDoctors/TimeSlot/time_slot_modal.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../../AppManager/alert_dialogue.dart';
import '../../../../AppManager/app_color.dart';
import '../../../../AppManager/my_text_theme.dart';

import '../../../Dashboard/dashboard_modal.dart';
import '../../NewBookAppintment/NewBookAppointemtView.dart';
import '../../NewBookAppintment/NewBookAppointmentController.dart';
import '../../NewBookAppintment/NewBookAppointmentModal.dart';
import '../../NewBookAppintment/data_modal/data_modal.dart';
import '../../top_specialities_controller.dart';
import '../../top_specialities_modal.dart';
import '../../top_specialities_view.dart';
import '../search_specialist_doctor_modal.dart';

class TimeSlotView extends StatefulWidget {
  final String doctorId;
  final String iSEraDoctor;
  final String drName;
  final String speciality;
  final String degree;
  final List timeSlots;
  final double fees;
  final String? selectedDay;
  final String? profilePhoto;
  final int? departmentId;

  const TimeSlotView(
      {Key? key,
        required this.doctorId,
        required this.iSEraDoctor,
        required this.drName,
        required this.speciality,
        required this.degree,
        required this.timeSlots,
        required this.fees,
         this.departmentId,
        this.selectedDay,
        this.profilePhoto,
      })
      : super(key: key);



  @override
  State<TimeSlotView> createState() => _TimeSlotViewState();
}

class _TimeSlotViewState extends State<TimeSlotView> {
  optionList() {

    ApplicationLocalizations localization =
    Provider.of<ApplicationLocalizations>(context, listen: false);
    return  [
      {
        'icon':"assets/kiosk_setting.png",
        'name':localization.getLocaleData.doctorBySpeciality.toString(),
        'isChecked':true
      },
      {
        'icon':"assets/kiosk_symptoms.png",
        'name':localization.getLocaleData.doctorBySymptoms.toString(),
        'isChecked':false
      },
    ];}
  bool isDoctor = true;

  TimeSlotModal modal = TimeSlotModal();

  TopSpecModal topSpecModal = TopSpecModal();
  SpecialistDoctorModal specialistDoctorModal = SpecialistDoctorModal();
  DashboardModal dashboardModal=DashboardModal();

  //String dataColor = '';
  List demo = [];
  List languageList = [
    {
      'name':"Hindi",
    },
    {
      'name':"English",
    },
    {
      'name':"Urdu",
    }
  ];
  NewBookAppointmentModal appointmentModal = NewBookAppointmentModal();
  bool selected = false;
  get() async {

   selected=false;
    appointmentModal.controller.updateAvailableDays=[];
    appointmentModal.controller.updateTimeList=[];
    // appointmentModal.getTimeSlots(context,dayId: '', drId: '');
    appointmentModal.getDays(context,widget.doctorId.toString());
    VoiceAssistantProvider listenVM=Provider.of<VoiceAssistantProvider>(context,listen: false);
    listenVM.listeningPage="slot view";
    List<DateTime> dates = [];

    for (int i = 0; i < 7; i++) {
      DateTime date = DateTime.now().add(Duration(days: i));

      dates.add(date);
    }
    if (widget.selectedDay != null) {
      modal.controller.updateSelectedDate = dates[dates.indexWhere((element) =>
      (DateFormat.E().format(element).toString())
          .toString()
          .toLowerCase() ==
          widget.selectedDay.toString().toLowerCase())];
    } else {

    }

    modal.controller.updateMyAppointmentData =
        modal.appointmentController.appointmentDetailsList;
    modal.controller.updateTotalFee = widget.fees.toDouble();
    modal.controller.doctorId.value = widget.doctorId.toString();
    modal.controller.iSEraDoctor.value = widget.iSEraDoctor.toString();

    await modal.onEnterPage(context);
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
    Get.delete<TimeSlotController>();
  }



  @override
  Widget build(BuildContext context) {
    var selectedDay = '';

    ApplicationLocalizations localization =
    Provider.of<ApplicationLocalizations>(context, listen: true);
    return Container(
      color: AppColor.primaryColor,
      child: SafeArea(
        child: Scaffold(
          // appBar: MyWidget().myAppBar(context,
          //     title: localization.getLocaleData.selectTime.toString()),
          body: GetBuilder(
            init: TopSpecController(),
            builder: (_) {
              //**
              //**
              return Container(
                //  height: MediaQuery.of(context).size.height,
                // width: Get.width,
                decoration:   BoxDecoration(
                  //***
                    color: AppColor.primaryColorLight,
                    image: const DecorationImage(
                        image:  AssetImage("assets/kiosk_bg.png"),
                        // Orientation.portrait==MediaQuery.of(context).orientation?
                        //  AssetImage("assets/kiosk_bg.png",):
                        // AssetImage("assets/kiosk_bg_img.png",),
                        fit: BoxFit.fill)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                        height: 80,
                        child: ProfileInfoWidget()),
                    // Container(
                    //   height:300,
                    //   //820,
                    //   // MediaQuery.of(context).size.height * .89,
                    //   color: AppColor.primaryColor,
                    //   child: Padding(
                    //     padding: const EdgeInsets.symmetric(
                    //         vertical: 56, horizontal: 12),
                    //     child:
                    //     Column(
                    //       crossAxisAlignment:
                    //       CrossAxisAlignment.start,
                    //       children: [
                    //         Expanded(
                    //           child: ListView.builder(itemCount: optionList.length,itemBuilder:(BuildContext context,int index){
                    //             return Padding(
                    //               padding:
                    //               const EdgeInsets.symmetric(
                    //                   vertical: 20,
                    //                   horizontal: 12),
                    //               child: InkWell(
                    //                 onTap: (){
                    //                   setState(() {
                    //                     if(index==0){
                    //                       isDoctor = true;
                    //                       App().navigate(context, TopSpecialitiesView());
                    //                     }
                    //                     else{
                    //                       isDoctor = false;
                    //                       App().navigate(context, TopSpecialitiesView(isDoctor:1));
                    //                     }
                    //                   });
                    //                   for (var element
                    //                   in optionList) {
                    //                     element["isChecked"] = false;
                    //                   }
                    //                   optionList[index]['isChecked']=true;
                    //                 },
                    //
                    //                 child: Container(
                    //                   color: optionList[index]['isChecked']?AppColor
                    //                       .primaryColorLight:AppColor.primaryColor,
                    //                   child: Padding(
                    //                     padding:
                    //                     const EdgeInsets.all(
                    //                         8.0),
                    //                     child: Row(
                    //                       children: [
                    //                         Image.asset(
                    //                           optionList[index]['icon'],
                    //                           height: 40,
                    //                         ),
                    //                         const SizedBox(
                    //                           width: 10,
                    //                         ),
                    //                         Expanded(
                    //                           child: Text(
                    //                             optionList[index]['name'],
                    //                             style: MyTextTheme()
                    //                                 .largeWCN,
                    //                           ),
                    //                         )
                    //                       ],
                    //                     ),
                    //                   ),
                    //                 ),
                    //               ),
                    //             );
                    //           }),
                    //         ),
                    //         // Expanded(child: SizedBox(width: 20,)),
                    //         // Expanded(
                    //         //   child: Row(
                    //         //    crossAxisAlignment: CrossAxisAlignment.start,
                    //         //     mainAxisAlignment: MainAxisAlignment.end,
                    //         //     children: [
                    //         //       SizedBox(width: 70,
                    //         //         child: MyButton(width: 20,color: AppColor.primaryColorLight,title: "Back",
                    //         //         onPress: (){
                    //         //           App().navigate(context, TopSpecialitiesView());
                    //         //         },
                    //         //         ),
                    //         //       ),
                    //         //     ],
                    //         //   ),
                    //         // ),
                    //       ],
                    //     ),
                    //   ),
                    // ),
                    //**************************
                    SizedBox(
                      height: 110,
                      child: ListView.builder(
                          scrollDirection:   Axis.horizontal,
                          physics: const NeverScrollableScrollPhysics(),
                          // shrinkWrap: true,
                          itemCount: optionList().length,
                          itemBuilder:(BuildContext context,int index){
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 18),
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
                                  in optionList()) {
                                    element["isChecked"] = false;
                                  }
                                  optionList()[index]['isChecked']=true;
                                },

                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    //color: isDoctor==index.toString()?AppColor.primaryColor:AppColor.white
                                    color: optionList()[index]['isChecked']?AppColor
                                        .primaryColor:AppColor.white,
                                  ),
                                  //  width: Get.width*.46,
                                  child: Padding(
                                    padding:
                                    const EdgeInsets.all(
                                        8.0),
                                    child: Row(
                                      children: [
                                        Image.asset(
                                          optionList()[index]['icon'],
                                          color: optionList()[index]['isChecked']?AppColor
                                              .white:AppColor.secondaryColorShade2,
                                          height: 40,
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          optionList()[index]['name'],
                                          style: MyTextTheme()
                                              .largeWCN.copyWith(color:optionList()[index]['isChecked']?AppColor
                                              .white:AppColor.secondaryColorShade2),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }),
                    ),
                    //**************************
                    Expanded(
                      child:
                      ListView(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  //mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      //**************************************************
                                      child: Container(
                                        height: Get.height-230,
                                        color: AppColor.bgColor,
                                        child: ListView(
                                          physics: const NeverScrollableScrollPhysics(),
                                          children: [
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.fromLTRB(20, 15, 15, 0),
                                                  child: Text(localization.getLocaleData.hintText!.findDoctor.toString(),style: MyTextTheme().mediumGCN.copyWith(fontSize: 20)),
                                                ),
                                                //Text("convenience",style: MyTextTheme().mediumGCN.copyWith(fontSize: 20)),
                                              ],
                                            ),
                                            GetBuilder(
                                                init: specialistDoctorModal.controller,
                                                builder: (_) {
                                                  return SizedBox(
                                                    height: Get.height-270,
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        //****
                                                        Expanded(
                                                          child: GetBuilder(
                                                              init: TimeSlotController(),
                                                              builder: (_) {
                                                                return GetBuilder(
                                                                 init: NewBookAppointmentController(),
                                                                     builder: (_) {
                                                                    return Column(
                                                                      children: [
                                                                        Container(
                                                                          width: MediaQuery.of(context).size.width,
                                                                          decoration: const BoxDecoration(

                                                                              borderRadius: BorderRadius.only(
                                                                                  bottomLeft: Radius.circular(20),
                                                                                  bottomRight: Radius.circular(20))),
                                                                          child: Padding(
                                                                            padding: const EdgeInsets.fromLTRB(20, 15, 15, 15),
                                                                            child: Column(
                                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                                              children: [
                                                                                Row(
                                                                                  children: [
                                                                                    CachedNetworkImage(height: 80,imageUrl: widget.profilePhoto
                                                                                        .toString(),
                                                                                        // progressIndicatorBuilder: (context,
                                                                                        //         url,
                                                                                        //         downloadProgress) =>
                                                                                        //     CircularProgressIndicator(
                                                                                        //         value:
                                                                                        //             downloadProgress
                                                                                        //                 .progress),
                                                                                        errorWidget: (context,
                                                                                            url, error) =>
                                                                                            Image.asset(
                                                                                                "assets/doctorSign.png")
                                                                                      // Icon(Icons.error),
                                                                                    ),
                                                                                    Padding(
                                                                                      padding: const EdgeInsets.all(8.0),
                                                                                      child: Column(
                                                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                                                        children: [
                                                                                          Text(
                                                                                            widget.drName.toString(),
                                                                                            style: MyTextTheme().largeBCB,
                                                                                          ),
                                                                                          const SizedBox(height: 5),
                                                                                          Text(widget.speciality.toString(),
                                                                                              style: MyTextTheme().mediumBCB),
                                                                                        ],
                                                                                      ),
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        Padding(
                                                                          padding: const EdgeInsets.fromLTRB(20, 10, 15, 10),
                                                                          child: Row(
                                                                            children: [
                                                                              //*********
                                                                              SizedBox(
                                                                                // height: 16,
                                                                                // width: 16,
                                                                                  child:Text(localization.getLocaleData.hintText!.bookSlot.toString(),style: const TextStyle(fontSize: 18),)
                                                                                // SvgPicture.asset(
                                                                                //   'assets/calender.svg',
                                                                                //   fit: BoxFit.cover,
                                                                                //   color: AppColor.primaryColor,
                                                                                // ),
                                                                              ),
                                                                              const SizedBox(
                                                                                width: 10,
                                                                              ),
                                                                              Text(
                                                                                modal.controller.getSelectedDate == null
                                                                                    ? ""
                                                                                    : DateFormat.yMMMEd().format(
                                                                                    modal.controller.getSelectedDate ??
                                                                                        DateTime.now()),

                                                                                style: MyTextTheme().mediumBCB,
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                        Padding(
                                                                          padding: const EdgeInsets.fromLTRB(8, 0, 20, 0),
                                                                          child: Container(
                                                                            color: Colors.white,
                                                                            height: 95,
                                                                            child: ListView.builder(
                                                                                physics: const BouncingScrollPhysics(
                                                                                    parent: AlwaysScrollableScrollPhysics()),
                                                                                scrollDirection: Axis.horizontal,
                                                                                itemCount: 7,
                                                                                itemBuilder: (BuildContext context, int index) {
                                                                                  DateTime date = DateTime.now().add(Duration(days: index));
                                                                                  String day = (DateFormat.E().format(date).toString());
                                                                                  String fullDay = DateFormat.EEEE().format(date);
                                                                                  print("ALIIiiiii"+index.toString());
                                                                                   selected = (modal.controller.getSelectedDate == null ? "" : (modal.controller.getSelectedDate ?? DateTime.now()).day) == date.day;
                                                                                  //String saveDate = '';
                                                                                  return InkWell(
                                                                                    onTap: () async {
                                                                                      if(appointmentModal.controller.getAvailableDays.contains(fullDay)){
                                                                                        print(date.toString()+'jkhjk');
                                                                                        print(modal.controller.getSelectedDate.toString());
                                                                                        modal.controller.updateSelectedDate = date;
                                                                                        selectedDay=fullDay.toString();
                                                                                        //await modal.onEnterPage(context);
                                                                                        print("${fullDay}jkhjk");
                                                                                        // DayDataModal dataModelDay=    appointmentModal.controller.getDayList.where((data) => data.dayName==fullDay) as DayDataModal;
                                                                                        appointmentModal.getTime(context, dayName: fullDay, drId: widget.doctorId);

                                                                                      }else{



                                                                                      }


                                                                                      // appointmentModal.getTime(context, dayName: fullDay, drId: widget.doctorId,);
                                                                                    },
                                                                                    child: Container(
                                                                                      width: 155,
                                                                                      margin:
                                                                                      const EdgeInsets.fromLTRB(0, 10, 10, 10),
                                                                                      decoration: BoxDecoration(
                                                                                          color:
                                                                                          // widget.timeSlots.contains(widget.selectedDay)?
                                                                                          // AppColor.buttonColor:AppColor.greyLight,
                                                                                          //kk
                                                                                          !selected
                                                                                              ? (appointmentModal.controller.getAvailableDays.contains(fullDay)?AppColor.white:AppColor.greyLight)
                                                                                              : AppColor.primaryColor,
                                                                                          borderRadius: const BorderRadius.all(
                                                                                              Radius.circular(5)),
                                                                                          border: Border.all(
                                                                                              color: !selected
                                                                                                  ? AppColor.primaryColor
                                                                                                  : AppColor.white,
                                                                                              width: 1)),
                                                                                      child: Padding(
                                                                                        padding:
                                                                                        const EdgeInsets.fromLTRB(5, 4, 5, 0),
                                                                                        child: Column(
                                                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                                                          children: [
                                                                                            Row(
                                                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                                                              children: [
                                                                                                Text(day,
                                                                                                    style: widget.timeSlots.contains(day)
                                                                                                        ? MyTextTheme().smallBCN
                                                                                                        : !selected
                                                                                                        ? MyTextTheme().smallBCN
                                                                                                        : MyTextTheme().smallWCN),
                                                                                                const SizedBox(
                                                                                                  height: 5,
                                                                                                  width: 5,
                                                                                                ),
                                                                                                Text(
                                                                                                  date.day.toString(),
                                                                                                  style: widget.timeSlots.contains(day)
                                                                                                      ? MyTextTheme().mediumBCB:!selected
                                                                                                      ? MyTextTheme().mediumWCB.copyWith(color: AppColor.greyDark):
                                                                                                  MyTextTheme().mediumWCB,
                                                                                                ),
                                                                                              ],
                                                                                            ),
                                                                                            const SizedBox(
                                                                                              height: 5,
                                                                                            ),
                                                                                            Flexible(
                                                                                                child: Text(
                                                                                                  appointmentModal.controller.getAvailableDays.contains(fullDay)
                                                                                                      ?
                                                                                                  // localization.getLocaleData.selectSlot
                                                                                                  //     .toString():
                                                                                                  "Slots available ":'No slots available',
                                                                                                  style: appointmentModal.controller.getAvailableDays.contains(fullDay)
                                                                                                      ? TextStyle(fontSize: 12, color:!selected?AppColor.primaryColor: AppColor.white):!selected
                                                                                                      ?  TextStyle(
                                                                                                      fontSize: 9,
                                                                                                      color: AppColor.greyDark)
                                                                                                      : TextStyle(
                                                                                                      fontSize: 9,
                                                                                                      color: AppColor.white),
                                                                                                ))
                                                                                          ],
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                  );
                                                                                }),
                                                                          ),
                                                                        ),
                                                                        Padding(
                                                                          padding: const EdgeInsets.all(8.0),
                                                                          child: Align(
                                                                            alignment: Alignment.topLeft,
                                                                            child: Visibility(
                                                                              visible: appointmentModal.controller.getTimeList.isNotEmpty,
                                                                              replacement: Center(child: Padding(
                                                                                padding: const EdgeInsets.all(20.0),
                                                                                child:  Text("No Slots Available",style: MyTextTheme().largePCB,),
                                                                              )),
                                                                              child: SizedBox(
                                                                                height: Get.height/2-100,
                                                                                width: Get.width/2,
                                                                                child: ListView.builder(
                                                                                  itemCount: appointmentModal.controller.getTimeList.length,
                                                                                  itemBuilder: (BuildContext context, int index2) {
                                                                                TimeSlotDataModal  time=      appointmentModal.controller.getTimeList[index2];
                                                                                  return InkWell(
                                                                                    onTap: (){

                                                                                      App().navigate(context, NewBookAppointment(doctorName: widget.drName.toString(),doctorId:widget.doctorId,departmentId: widget.departmentId,timeSlot: (time.fromTime.toString()+time.toTime.toString()),date: modal.controller.getSelectedDate.toString(),day: selectedDay,timeSlotId: time.id,dayid: time.dayId,));
// //**//*******
                                                                                    },
                                                                                    child: Container(
                                                                                      height: 70,
                                                                                      decoration: BoxDecoration(
                                                                                        borderRadius: BorderRadius.circular(10),
                                                                                        border: Border.all(color: Colors.grey),
                                                                                          color:  AppColor.primaryColor),
                                                                                      child: Center(child: Row(
                                                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                                                        children: [
                                                                                          Text('${time.fromTime} - ${time.toTime}',style: MyTextTheme().largeWCB,),
                                                                                          SizedBox(width: 20,),
                                                                                          Icon(Icons.send,color: AppColor.white,)
                                                                                        ],
                                                                                      )),
                                                                                    ),
                                                                                  );
                                                                                },),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),

                                                                        // Expanded(
                                                                        //   child: Center(
                                                                        //       child: CommonWidgets().showNoData(
                                                                        //           show: (modal.controller.getShowNoData &&
                                                                        //               modal.controller.getSlotList.isEmpty),
                                                                        //           title: localization.getLocaleData.slotNotAvailable
                                                                        //               .toString(),
                                                                        //           loaderTitle: localization
                                                                        //               .getLocaleData.loadingSlotData
                                                                        //               .toString(),
                                                                        //           showLoader: (!modal.controller.getShowNoData &&
                                                                        //               modal.controller.getSlotList.isEmpty),
                                                                        //           child: Padding(
                                                                        //             padding: const EdgeInsets.all(5.0),
                                                                        //             child: Container(
                                                                        //                 padding: const EdgeInsets.all(5),
                                                                        //                 width: MediaQuery.of(context).size.width,
                                                                        //                 color: AppColor.white,
                                                                        //                 child: ListView.builder(
                                                                        //                     physics: const BouncingScrollPhysics(
                                                                        //                         parent: AlwaysScrollableScrollPhysics()),
                                                                        //                     itemCount:
                                                                        //                     modal.controller.getSlotList.length,
                                                                        //                     itemBuilder: (context, index) {
                                                                        //                       var slotType = modal.controller.getSlotList[index];
                                                                        //                       //print("hhhhhhhhhhhhhhhhhh${slotType.slotType}");
                                                                        //
                                                                        //                       return Column(
                                                                        //                           crossAxisAlignment:
                                                                        //                           CrossAxisAlignment.start,
                                                                        //                           children: [
                                                                        //                             Text(
                                                                        //                               slotType.slotType.toString(),
                                                                        //                               style: MyTextTheme().mediumBCB,
                                                                        //                             ),
                                                                        //                             const SizedBox(
                                                                        //                               height: 10,
                                                                        //                             ),
                                                                        //                             AnimationLimiter(
                                                                        //                               child: GridView.builder(
                                                                        //                                   shrinkWrap: true,
                                                                        //                                   physics:
                                                                        //                                   const NeverScrollableScrollPhysics(),
                                                                        //                                   gridDelegate:
                                                                        //                                   const SliverGridDelegateWithFixedCrossAxisCount(
                                                                        //                                     crossAxisCount: 4,
                                                                        //                                     crossAxisSpacing: 15,
                                                                        //                                     mainAxisSpacing: 5,
                                                                        //                                     childAspectRatio: 4 / 1.4,
                                                                        //                                   ),
                                                                        //                                   itemCount: slotType.slotDetails!.length,
                                                                        //                                   itemBuilder:
                                                                        //                                       (BuildContext context,
                                                                        //                                       int index2) {
                                                                        //                                     SlotBookedDetails
                                                                        //                                     slotDetails = slotType.slotDetails!.isEmpty
                                                                        //                                         ? SlotBookedDetails()
                                                                        //                                         : slotType.slotDetails![index2];
                                                                        //                                     //print("ccccccccccccccc${slotDetails.slotTime}");
                                                                        //
                                                                        //                                     // Map slot=modal.controller.getPatientList[index]['slotDetails'][index2];
                                                                        //
                                                                        //                                     return AnimationConfiguration.staggeredGrid(
                                                                        //                                       position: index2,
                                                                        //                                       columnCount: 4,
                                                                        //                                       duration: const Duration(milliseconds: 800),
                                                                        //                                       child: ScaleAnimation(
                                                                        //                                         child: FadeInAnimation(
                                                                        //                                           child: InkWell(
                                                                        //                                             onTap: ()
                                                                        //                                             {
                                                                        //                                               if (UserData().getUserData.isNotEmpty) {
                                                                        //
                                                                        //
                                                                        //                                                 print(DateFormat("yyyy-MM-dd").format(modal.controller.getSelectedDate??DateTime.now()));
                                                                        //                                                 print(modal.controller.getSelectedDate);
                                                                        //                                                 if(DateFormat("yyyy-MM-dd").format(modal.controller.getSelectedDate??DateTime.now())==DateFormat("yyyy-MM-dd").format(DateTime.now())){
                                                                        //                                                   print("time is ${DateFormat('hh:mm a').format(DateFormat('hh:mma').parse(slotDetails.slotTime??""))}");
                                                                        //                                                   var selectedTime = DateFormat('HH:mm a').format(DateFormat('hh:mma').parse(slotDetails.slotTime??""));
                                                                        //                                                   //var newD =DateFormat("HH:mm").format(DateFormat.jm().parse(slotDetails.slotTime??""));
                                                                        //                                                   if (kDebugMode) {
                                                                        //                                                     print(selectedTime);
                                                                        //                                                   }
                                                                        //                                                 }
                                                                        //
                                                                        //                                                 modal.controller.saveTime
                                                                        //                                                     .value =
                                                                        //                                                     slotDetails.slotTime
                                                                        //                                                         .toString();
                                                                        //
                                                                        //                                                 if (slotDetails.isBooked
                                                                        //                                                     .toString() !=
                                                                        //                                                     '1') {
                                                                        //                                                   modal.controller
                                                                        //                                                       .updateSelectedSlot =
                                                                        //                                                       slotDetails.slotType
                                                                        //                                                           .toString() +
                                                                        //                                                           index2
                                                                        //                                                               .toString();
                                                                        //
                                                                        //                                                   modal
                                                                        //                                                       .controller
                                                                        //                                                       .getMyAppoointmentData
                                                                        //                                                       .appointmentId !=
                                                                        //                                                       0
                                                                        //                                                       ? reScheduleAppointment(
                                                                        //                                                       context)
                                                                        //                                                       : App().navigate(
                                                                        //                                                       context,
                                                                        //                                                       BookAppointmentView(
                                                                        //                                                         drName: widget
                                                                        //                                                             .drName
                                                                        //                                                             .toString(),
                                                                        //                                                         speciality: widget
                                                                        //                                                             .speciality
                                                                        //                                                             .toString(),
                                                                        //                                                         degree: widget
                                                                        //                                                             .degree
                                                                        //                                                             .toString(),
                                                                        //                                                         isEraUser: int
                                                                        //                                                             .parse(widget
                                                                        //                                                             .iSEraDoctor
                                                                        //                                                             .toString()),
                                                                        //                                                       ));
                                                                        //                                                 }
                                                                        //                                                 else {
                                                                        //                                                   alertToast(context,
                                                                        //                                                       'Slot Booked Already');
                                                                        //                                                 }
                                                                        //
                                                                        //                                               } else {
                                                                        //                                                 App().navigate(context,  LoginThroughOtp(index:'appointment',registerOrLogin: 'Login'));
                                                                        //                                               }
                                                                        //                                             },
                                                                        //                                             child: Container(
                                                                        //                                                 decoration:
                                                                        //                                                 BoxDecoration(
                                                                        //                                                   border: Border.all(
                                                                        //                                                     color: Colors.grey.shade400,
                                                                        //                                                   ),
                                                                        //                                                   color: modal.controller
                                                                        //                                                       .selectedSlot ==
                                                                        //                                                       slotDetails
                                                                        //                                                           .slotType
                                                                        //                                                           .toString() +
                                                                        //                                                           index2
                                                                        //                                                               .toString()
                                                                        //                                                       ? AppColor
                                                                        //                                                       .primaryColor
                                                                        //                                                       : slotDetails
                                                                        //                                                       .isBooked
                                                                        //                                                       .toString() !=
                                                                        //                                                       '1'
                                                                        //                                                       ? AppColor
                                                                        //                                                       .white
                                                                        //                                                       : AppColor
                                                                        //                                                       .white,
                                                                        //                                                   borderRadius:
                                                                        //                                                   const BorderRadius
                                                                        //                                                       .all(
                                                                        //                                                       Radius
                                                                        //                                                           .circular(
                                                                        //                                                           5)),
                                                                        //                                                 ),
                                                                        //                                                 child: Center(
                                                                        //                                                     child: Text(
                                                                        //                                                         slotDetails
                                                                        //                                                             .slotTime
                                                                        //                                                             .toString(),
                                                                        //                                                         style: MyTextTheme().smallPCB.copyWith(
                                                                        //                                                             color: modal.controller.selectedSlot == slotDetails.slotType.toString() + index2.toString()
                                                                        //                                                                 ? AppColor.white
                                                                        //                                                                 : slotDetails.isBooked.toString() != '1'
                                                                        //                                                                 ? Colors.grey.shade600
                                                                        //                                                                 : Colors.black54)))),
                                                                        //                                           ),
                                                                        //                                         ),
                                                                        //                                       ),
                                                                        //                                     );
                                                                        //                                   }),
                                                                        //                             ),
                                                                        //                             const SizedBox(
                                                                        //                               height: 10,
                                                                        //                             ),
                                                                        //                           ]);
                                                                        //                     })),
                                                                        //           ))),
                                                                        // )
                                                                      ],
                                                                    );
                                                                  }
                                                                );
                                                              }),
                                                        ),
                                                        //*********

                                                      ],
                                                    ),
                                                  );
                                                }
                                            )
                                            //********************************
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),


                            ],
                          ),
                          //               CommonWidgets().showNoData(
                          //                 title: localization
                          //                     .getLocaleData.topSpecialitiesDataNotFound
                          //                     .toString(),
                          //                 show: (topSpecModal.controller.getShowNoTopData &&
                          //                     topSpecModal.controller.getTopSpecialities.isEmpty),
                          //                 loaderTitle: localization
                          //                     .getLocaleData.loadingTopSpecialitiesData
                          //                     .toString(),
                          //                 showLoader: (!topSpecModal.controller.getShowNoTopData &&
                          //                     topSpecModal.controller.getTopSpecialities.isEmpty),
                          //                 child:
                          //                 Column(
                          //                   crossAxisAlignment: CrossAxisAlignment.start,
                          //                   mainAxisAlignment: MainAxisAlignment.start,
                          //                   children: [
                          //                     Padding(
                          //                       padding: const EdgeInsets.fromLTRB(16,26,5,5),
                          //                       child: Row(
                          //                         crossAxisAlignment: CrossAxisAlignment.start,
                          //                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          //                         children: [
                          //                           Column(
                          //                             crossAxisAlignment: CrossAxisAlignment.start,
                          //                             children: [
                          //                               Text(UserData().getUserName.toString(),style: MyTextTheme().largePCB.copyWith(fontSize: 25)),
                          //                               Row(
                          //                                 children: [
                          //                                   Text(UserData().getUserGender.toString()=='1'? 'Male':'Female',style: MyTextTheme().mediumGCN.copyWith(fontSize: 25)),
                          //
                          // Text("  ${DateTime.now().year-int.parse(UserData().getUserDob.split('/')[2])} years ",style: MyTextTheme().mediumGCN.copyWith(fontSize: 25)),
                          //                                 ],
                          //                               ),
                          //                               Text(UserData().getUserMobileNo,style: MyTextTheme().mediumGCN.copyWith(fontSize: 20)),
                          //                               Text(UserData().getUserEmailId,style: MyTextTheme().mediumGCN.copyWith(fontSize: 20)),
                          //                             ],
                          //                           ),
                          //                           const Expanded(flex: 2,child: SizedBox()),
                          //                           Expanded(
                          //                             child: Row(
                          //                               children: [
                          //                                 Container(
                          //                                   decoration: BoxDecoration(
                          //                                     shape: BoxShape.circle,
                          //                                     color: AppColor.greyLight,
                          //                                     boxShadow: [
                          //                                       BoxShadow(
                          //                                           blurRadius: 10,
                          //                                           color: AppColor.greyDark,
                          //                                           spreadRadius: 0.2)
                          //                                     ],
                          //                                   ),
                          //                                   child: Row(
                          //                                     mainAxisAlignment:
                          //                                     MainAxisAlignment.center,
                          //                                     children: [
                          //                                       Center(
                          //                                         child: CircleAvatar(
                          //                                           radius: 20,
                          //                                           backgroundImage: const AssetImage(
                          //                                               'assets/noProfileImage.png'),
                          //                                           foregroundImage: NetworkImage(
                          //                                             UserData()
                          //                                                 .getUserProfilePhotoPath
                          //                                                 .toString(),
                          //                                           ),
                          //                                         ),
                          //                                       ),
                          //                                     ],
                          //                                   ),
                          //                                 ),
                          //                                 SizedBox(width: 8),
                          //                                 Text(UserData().getUserName.toString(),style: MyTextTheme().mediumGCN.copyWith(fontSize: 20))
                          //                                 ,SizedBox(width: 8,),
                          //
                          //                                 InkWell(
                          //
                          //                                     onTap: (){
                          //                                       dashboardModal.onPressLogout(context);
                          //                                     }
                          //                                     ,child: Image.asset("assets/logout_kiosk.png",scale: 2,)),
                          //                               ],
                          //                             ),
                          //                           ),
                          //
                          //
                          //                         ],)
                          //                     ),
                          //                     Padding(
                          //                       padding: const EdgeInsets.fromLTRB(16,52,5,5),
                          //                       child: Row(
                          //                         // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          //                         crossAxisAlignment: CrossAxisAlignment.start,
                          //                         children:  [
                          //                           // Expanded(child: Column(
                          //                           //   crossAxisAlignment: CrossAxisAlignment.start,
                          //                           //   children: [
                          //                           //     Text("Selected",style: MyTextTheme().mediumGCN.copyWith(fontSize: 25),),
                          //                           //     Text("Specialist",style: MyTextTheme().mediumGCN.copyWith(fontSize: 25),),
                          //                           //   ],
                          //                           // )),
                          //                           Expanded(child: Column(
                          //                             crossAxisAlignment: CrossAxisAlignment.start,
                          //                             children: [
                          //                               Text("To find a doctor as your",style: MyTextTheme().mediumGCN.copyWith(fontSize: 30)),
                          //                               Text("convenience",style: MyTextTheme().mediumGCN.copyWith(fontSize: 30)),
                          //                             ],
                          //                           )),
                          //                         ],),
                          //                     ),
                          //                     Padding(
                          //                       padding: const EdgeInsets.all(8.0),
                          //                       child: Row(
                          //                         crossAxisAlignment: CrossAxisAlignment.start,
                          //                         //mainAxisAlignment: MainAxisAlignment.start,
                          //                         children: [
                          //                           // SizedBox(
                          //                           //   width: Get.width/4.5,
                          //                           //   height: Get.height,
                          //                           //   child: ListView(
                          //                           //     children: [
                          //                           //       StaggeredGrid.count(
                          //                           //         crossAxisCount: 1,
                          //                           //         children: List.generate(
                          //                           //             topSpecModal
                          //                           //                 .controller
                          //                           //                 .getTopSpecialities
                          //                           //                 .length, (index) {
                          //                           //           TopSpecialitiesDataModal details =
                          //                           //           (topSpecModal
                          //                           //               .controller
                          //                           //               .topSpecialities
                          //                           //               .isEmpty &&
                          //                           //               topSpecModal
                          //                           //                   .controller
                          //                           //                   .getTopSpecialities
                          //                           //                   .isEmpty)
                          //                           //               ? TopSpecialitiesDataModal(
                          //                           //             id: 0,
                          //                           //             specialityName:
                          //                           //             'specialityName',
                          //                           //             imagePath: '',
                          //                           //             description: '',
                          //                           //             noOfDoctors: 0,
                          //                           //           )
                          //                           //               : topSpecModal.controller
                          //                           //               .getTopSpecialities[
                          //                           //           index];
                          //                           //
                          //                           //           print(topSpecModal.controller
                          //                           //               .topSpecialities.length);
                          //                           //
                          //                           //           return SizedBox(
                          //                           //             child:
                          //                           //             CommonWidgets().shimmerEffect(
                          //                           //               shimmer: topSpecModal.controller
                          //                           //                   .getTopSpecialities.isEmpty,
                          //                           //               child: Row(
                          //                           //                 children: [
                          //                           //                   Padding(
                          //                           //                     padding: const EdgeInsets
                          //                           //                         .fromLTRB(
                          //                           //                         10, 10, 10, 10),
                          //                           //                     child: PhysicalModel(
                          //                           //                       shape:
                          //                           //                       BoxShape.rectangle,
                          //                           //                       borderRadius:
                          //                           //                       const BorderRadius
                          //                           //                           .all(
                          //                           //                           Radius.circular(
                          //                           //                               10)),
                          //                           //                       color: AppColor.white,
                          //                           //                       elevation: 5,
                          //                           //                       child: Container(
                          //                           //                         width: 200,
                          //                           //                         height: 110,
                          //                           //                         decoration: BoxDecoration(
                          //                           //                             color: AppColor
                          //                           //                                 .white,
                          //                           //                             borderRadius:
                          //                           //                             BorderRadius
                          //                           //                                 .circular(
                          //                           //                                 10),
                          //                           //                             border: Border.all(
                          //                           //                                 color: AppColor
                          //                           //                                     .primaryColor)),
                          //                           //                         child: TextButton(
                          //                           //                           style: CommonWidgets()
                          //                           //                               .myButtonStyle
                          //                           //                               .copyWith(),
                          //                           //                           onPressed: () {
                          //                           //                             topSpecModal.controller.updateSelectedId = details.id.toString();
                          //                           //                             specialistDoctorModal.getDoctorList(
                          //                           //                               context,
                          //                           //                             );
                          //                           //                             //    modal.onPressedSpecialities(context);
                          //                           //                           },
                          //                           //                           child: Padding(
                          //                           //                             padding:
                          //                           //                             const EdgeInsets
                          //                           //                                 .only(
                          //                           //                                 left: 20,
                          //                           //                                 top: 19,
                          //                           //                                 right: 10),
                          //                           //                             child: Row(
                          //                           //                               mainAxisAlignment:
                          //                           //                               MainAxisAlignment.spaceEvenly,
                          //                           //                               // mainAxisAlignment:
                          //                           //                               //     MainAxisAlignment.center,
                          //                           //                               children: [
                          //                           //                                 Expanded(flex: 2,
                          //                           //                                   child: Column(
                          //                           //                                     crossAxisAlignment: CrossAxisAlignment.start,
                          //                           //                                     children: [
                          //                           //                                       CachedNetworkImage(
                          //                           //                                         //fit: BoxFit.fitHeight,
                          //                           //                                         height:
                          //                           //                                         30,
                          //                           //                                         width: 30,
                          //                           //                                         // placeholder: (context, url) => const Center(
                          //                           //                                         //   child: SizedBox(
                          //                           //                                         //     height: 36,
                          //                           //                                         //     child: CircleAvatar(),
                          //                           //                                         //   ),
                          //                           //                                         // ),
                          //                           //                                         imageUrl: details
                          //                           //                                             .imagePath
                          //                           //                                             .toString(),
                          //                           //                                         errorWidget: (context, url, error) => topSpecModal.controller.getTopSpecialities.isEmpty
                          //                           //                                             ? const CircleAvatar()
                          //                           //                                             : const Image(
                          //                           //                                           image: AssetImage('assets/Clinics.png'),
                          //                           //                                         ),
                          //                           //                                       ),
                          //                           //                                       const SizedBox(
                          //                           //                                         height:
                          //                           //                                         10,
                          //                           //                                       ),
                          //                           //                                       Text(
                          //                           //                                         details
                          //                           //                                             .specialityName
                          //                           //                                             .toString(),
                          //                           //                                         style: MyTextTheme()
                          //                           //                                             .mediumGCB,
                          //                           //                                         // textAlign:
                          //                           //                                         //     TextAlign.center,
                          //                           //                                         overflow: TextOverflow.clip,
                          //                           //
                          //                           //                                       ),
                          //                           //                                     ],
                          //                           //                                   ),
                          //                           //                                 ),
                          //                           //
                          //                           //                                 Column(
                          //                           //                                   children: [
                          //                           //                                     Text(
                          //                           //                                       //  localization.getLocaleData.noOfDoctors.toString() +
                          //                           //                                         details
                          //                           //                                             .noOfDoctors
                          //                           //                                             .toString(),
                          //                           //                                         style: MyTextTheme()
                          //                           //                                             .veryLargePCB,
                          //                           //                                         textAlign:
                          //                           //                                         TextAlign.left),
                          //                           //                                     const SizedBox(
                          //                           //                                       height:
                          //                           //                                       9,
                          //                           //                                     ),
                          //                           //                                     Text(
                          //                           //                                       "Available",
                          //                           //                                       style: MyTextTheme()
                          //                           //                                           .mediumGCN,
                          //                           //                                     )
                          //                           //                                   ],
                          //                           //                                 )
                          //                           //                               ],
                          //                           //                             ),
                          //                           //                           ),
                          //                           //                         ),
                          //                           //                       ),
                          //                           //                     ),
                          //                           //                   ),
                          //                           //                 ],
                          //                           //               ),
                          //                           //             ),
                          //                           //           );
                          //                           //         }),
                          //                           //       ),
                          //                           //     ],
                          //                           //   ),
                          //                           // ),
                          //
                          //                           Expanded(
                          //                             //**************************************************
                          //                             child: Container(
                          //                               height: 800,
                          //                               color: AppColor.bgColor,
                          //                               child: ListView(
                          //                                 physics: NeverScrollableScrollPhysics(),
                          //                                 children: [
                          //
                          //                                   GetBuilder(
                          //                                       init: specialistDoctorModal.controller,
                          //                                       builder: (_) {
                          //                                         return SizedBox(
                          //                                           height: 800,
                          //                                           child: Column(
                          //                                             crossAxisAlignment: CrossAxisAlignment.start,
                          //                                             children: [
                          //                                               SizedBox(
                          //                                                 height: 40,
                          //                                                 width: 450,
                          //                                                 child: TabResponsive().wrapInTab(
                          //                                                   context: context,
                          //                                                   child: TextFormField(
                          //                                                     controller: topSpecModal.controller.searchC.value,
                          //                                                     onChanged: (val) {
                          //                                                       print(specialistDoctorModal.controller.getDataList[0].sittingDays.toString());
                          //                                                       // if (modal.controller.getTopSpecialities.isEmpty) {
                          //                                                       //   modal.controller.showNoData.value = true;
                          //                                                       // } else {
                          //                                                       //   modal.controller.showNoData.value = false;
                          //                                                       // }
                          //                                                       setState(() {});
                          //                                                     },
                          //                                                     style: const TextStyle(fontSize: 18),
                          //                                                     decoration: InputDecoration(
                          //                                                       contentPadding: const EdgeInsets.symmetric(
                          //                                                           horizontal: 24, vertical: 8),
                          //                                                       hintText: localization.getLocaleData.searchDoctorsHere.toString(),
                          //                                                       suffixIcon: SizedBox(
                          //                                                         width: 50,
                          //                                                         child: Row(
                          //                                                           mainAxisAlignment: MainAxisAlignment.end,
                          //                                                           children: [
                          //                                                             VerticalDivider(
                          //                                                               indent: 6,
                          //                                                               endIndent: 6,
                          //                                                               thickness: 1,
                          //                                                               color: Colors.grey.shade400,
                          //                                                             ),
                          //                                                             InkWell(
                          //                                                               child: const Icon(
                          //                                                                 CupertinoIcons.search,
                          //                                                                 size: 20,
                          //                                                                 color: Colors.grey,
                          //                                                               ),
                          //                                                               onTap: () {},
                          //                                                             ),
                          //                                                             const Spacer(),
                          //                                                           ],
                          //                                                         ),
                          //                                                       ),
                          //                                                       hintStyle: TextStyle(
                          //                                                           color: AppColor.greyLight, fontSize: 18),
                          //                                                       filled: true,
                          //                                                       fillColor: Colors.white,
                          //                                                       focusedBorder: OutlineInputBorder(
                          //                                                           borderRadius: BorderRadius.circular(10),
                          //                                                           borderSide: BorderSide(
                          //                                                               color: AppColor.greyLight)),
                          //                                                       enabledBorder: OutlineInputBorder(
                          //                                                           borderRadius: BorderRadius.circular(10),
                          //                                                           borderSide: BorderSide(
                          //                                                               color: AppColor.greyLight,
                          //                                                               width: 1)),
                          //                                                     ),
                          //                                                   ),
                          //                                                 ),
                          //                                               ),
                          //                                               SizedBox(height: 20,),
                          //                                               SizedBox(height: 5,),
                          //                                               //****
                          //                                               Expanded(
                          //                                                 child: GetBuilder(
                          //                                                     init: TimeSlotController(),
                          //                                                     builder: (_) {
                          //                                                       return Column(
                          //                                                         children: [
                          //                                                           Container(
                          //                                                             width: MediaQuery.of(context).size.width,
                          //                                                             decoration: const BoxDecoration(
                          //
                          //                                                                 borderRadius: BorderRadius.only(
                          //                                                                     bottomLeft: Radius.circular(20),
                          //                                                                     bottomRight: Radius.circular(20))),
                          //                                                             child: Padding(
                          //                                                               padding: const EdgeInsets.fromLTRB(20, 15, 15, 15),
                          //                                                               child: Column(
                          //                                                                 crossAxisAlignment: CrossAxisAlignment.start,
                          //                                                                 children: [
                          //
                          //                                                                   Row(
                          //                                                                     children: [
                          //                                                                       CachedNetworkImage(height: 25,imageUrl: widget.profilePhoto
                          //                                                                           .toString(),
                          //                                                                           // progressIndicatorBuilder: (context,
                          //                                                                           //         url,
                          //                                                                           //         downloadProgress) =>
                          //                                                                           //     CircularProgressIndicator(
                          //                                                                           //         value:
                          //                                                                           //             downloadProgress
                          //                                                                           //                 .progress),
                          //                                                                           errorWidget: (context,
                          //                                                                               url, error) =>
                          //                                                                               Image.asset(
                          //                                                                                   "assets/doctorSign.png")
                          //                                                                         // Icon(Icons.error),
                          //                                                                       ),
                          //                                                                       Text(
                          //                                                                         widget.drName.toString(),
                          //                                                                         style: MyTextTheme().largeBCB,
                          //                                                                       ),
                          //                                                                     ],
                          //                                                                   ),
                          //                                                                   const SizedBox(height: 5),
                          //                                                                   Text(widget.speciality.toString(),
                          //                                                                       style: MyTextTheme().mediumBCB),
                          //
                          //                                                                 ],
                          //                                                               ),
                          //                                                             ),
                          //                                                           ),
                          //                                                           Padding(
                          //                                                             padding: const EdgeInsets.fromLTRB(20, 20, 15, 10),
                          //                                                             child: Row(
                          //                                                               children: [
                          //                                                                 //*********
                          //                                                                 const SizedBox(
                          //                                                                   // height: 16,
                          //                                                                   // width: 16,
                          //                                                                     child:Text("Book Slot")
                          //                                                                   // SvgPicture.asset(
                          //                                                                   //   'assets/calender.svg',
                          //                                                                   //   fit: BoxFit.cover,
                          //                                                                   //   color: AppColor.primaryColor,
                          //                                                                   // ),
                          //                                                                 ),
                          //                                                                 const SizedBox(
                          //                                                                   width: 10,
                          //                                                                 ),
                          //                                                                 Text(
                          //                                                                   modal.controller.getSelectedDate == null
                          //                                                                       ? ""
                          //                                                                       : DateFormat.yMMMEd().format(
                          //                                                                       modal.controller.getSelectedDate ??
                          //                                                                           DateTime.now()),
                          //
                          //                                                                   style: MyTextTheme().mediumBCB,
                          //                                                                 ),
                          //                                                               ],
                          //                                                             ),
                          //                                                           ),
                          //                                                           Padding(
                          //                                                             padding: const EdgeInsets.fromLTRB(8, 0, 20, 0),
                          //                                                             child: Container(
                          //                                                               color: Colors.white,
                          //                                                               height: 95,
                          //                                                               child: ListView.builder(
                          //                                                                   physics: const BouncingScrollPhysics(
                          //                                                                       parent: AlwaysScrollableScrollPhysics()),
                          //                                                                   scrollDirection: Axis.horizontal,
                          //                                                                   itemCount: 7,
                          //                                                                   itemBuilder: (BuildContext context, int index) {
                          //                                                                     DateTime date =
                          //                                                                     DateTime.now().add(Duration(days: index));
                          //                                                                     String day =
                          //                                                                     (DateFormat.E().format(date).toString());
                          //                                                                     bool selected =
                          //                                                                         (modal.controller.getSelectedDate == null
                          //                                                                             ? ""
                          //                                                                             : (modal.controller.getSelectedDate ??
                          //                                                                             DateTime.now())
                          //                                                                             .day) ==
                          //                                                                             date.day;
                          //                                                                     //String saveDate = '';
                          //                                                                     return InkWell(
                          //                                                                       onTap: () async {
                          //                                                                         print(date.toString());
                          //                                                                         print(modal.controller.getSelectedDate
                          //                                                                             .toString());
                          //
                          //                                                                         modal.controller.updateSelectedDate = date;
                          //
                          //                                                                         await modal.onEnterPage(context);
                          //                                                                       },
                          //                                                                       child: Container(
                          //                                                                         width: 155,
                          //                                                                         margin:
                          //                                                                         const EdgeInsets.fromLTRB(0, 10, 10, 10),
                          //                                                                         decoration: BoxDecoration(
                          //                                                                             color:
                          //                                                                             // widget.timeSlots.contains(widget.selectedDay)?
                          //                                                                             // AppColor.buttonColor:AppColor.greyLight,
                          //                                                                             //kk
                          //                                                                             !selected
                          //                                                                                 ? widget.timeSlots.contains(day)
                          //                                                                                 ? AppColor.orangeButtonColor
                          //                                                                                 : Colors.white
                          //                                                                                 : AppColor.primaryColor,
                          //                                                                             borderRadius: const BorderRadius.all(
                          //                                                                                 Radius.circular(5)),
                          //                                                                             border: Border.all(
                          //                                                                                 color: !selected
                          //                                                                                     ? AppColor.greyLight
                          //                                                                                     : AppColor.primaryColor,
                          //                                                                                 width: 1)),
                          //                                                                         child: Padding(
                          //                                                                           padding:
                          //                                                                           const EdgeInsets.fromLTRB(5, 4, 5, 0),
                          //                                                                           child: Column(
                          //                                                                             children: [
                          //
                          //                                                                               Text(day,
                          //                                                                                   style: widget.timeSlots.contains(day)
                          //                                                                                       ? MyTextTheme().smallWCN
                          //                                                                                       : !selected
                          //                                                                                       ? MyTextTheme().smallBCN.copyWith(color: AppColor.greyDark)
                          //                                                                                       : MyTextTheme().smallWCN),
                          //                                                                               const SizedBox(
                          //                                                                                 height: 5,
                          //                                                                               ),
                          //                                                                               Text(
                          //                                                                                 date.day.toString(),
                          //                                                                                 style: widget.timeSlots.contains(day)
                          //                                                                                     ? MyTextTheme().mediumWCB:!selected
                          //                                                                                     ? MyTextTheme().mediumWCB.copyWith(color: AppColor.greyDark):
                          //                                                                                 MyTextTheme().mediumWCB,
                          //                                                                               ),
                          //                                                                               const SizedBox(
                          //                                                                                 height: 3,
                          //                                                                               ),
                          //                                                                               Flexible(
                          //                                                                                   child: Text(
                          //                                                                                     widget.timeSlots.contains(day)
                          //                                                                                         ?
                          //                                                                                     // localization.getLocaleData.selectSlot
                          //                                                                                     //     .toString():
                          //                                                                                     "Slots available ":'No slots available',
                          //                                                                                     style: widget.timeSlots.contains(day)
                          //                                                                                         ? TextStyle(fontSize: 9, color: AppColor.white):!selected
                          //                                                                                         ?  TextStyle(
                          //                                                                                         fontSize: 9,
                          //                                                                                         color: AppColor.greyDark)
                          //                                                                                         : TextStyle(
                          //                                                                                         fontSize: 9,
                          //                                                                                         color: AppColor.white),
                          //                                                                                   ))
                          //                                                                             ],
                          //                                                                           ),
                          //                                                                         ),
                          //                                                                       ),
                          //                                                                     );
                          //                                                                   }),
                          //                                                             ),
                          //                                                           ),
                          //                                                           Expanded(
                          //                                                             child: Center(
                          //                                                                 child: CommonWidgets().showNoData(
                          //                                                                     show: (modal.controller.getShowNoData &&
                          //                                                                         modal.controller.getSlotList.isEmpty),
                          //                                                                     title: localization.getLocaleData.slotNotAvailable
                          //                                                                         .toString(),
                          //                                                                     loaderTitle: localization
                          //                                                                         .getLocaleData.loadingSlotData
                          //                                                                         .toString(),
                          //                                                                     showLoader: (!modal.controller.getShowNoData &&
                          //                                                                         modal.controller.getSlotList.isEmpty),
                          //                                                                     child: Padding(
                          //                                                                       padding: const EdgeInsets.all(8.0),
                          //                                                                       child: Container(
                          //                                                                           padding: const EdgeInsets.all(5),
                          //                                                                           width: MediaQuery.of(context).size.width,
                          //                                                                           color: AppColor.white,
                          //                                                                           child: ListView.builder(
                          //                                                                               physics: const BouncingScrollPhysics(
                          //                                                                                   parent: AlwaysScrollableScrollPhysics()),
                          //                                                                               itemCount:
                          //                                                                               modal.controller.getSlotList.length,
                          //                                                                               itemBuilder: (context, index) {
                          //                                                                                 var slotType = modal
                          //                                                                                     .controller.getSlotList[index];
                          //                                                                                 //print("hhhhhhhhhhhhhhhhhh${slotType.slotType}");
                          //
                          //                                                                                 return Column(
                          //                                                                                     crossAxisAlignment:
                          //                                                                                     CrossAxisAlignment.start,
                          //                                                                                     children: [
                          //                                                                                       Text(
                          //                                                                                         slotType.slotType.toString(),
                          //                                                                                         style: MyTextTheme().mediumBCB,
                          //                                                                                       ),
                          //                                                                                       const SizedBox(
                          //                                                                                         height: 10,
                          //                                                                                       ),
                          //                                                                                       GridView.builder(
                          //                                                                                           shrinkWrap: true,
                          //                                                                                           physics:
                          //                                                                                           const NeverScrollableScrollPhysics(),
                          //                                                                                           gridDelegate:
                          //                                                                                           const SliverGridDelegateWithFixedCrossAxisCount(
                          //                                                                                             crossAxisCount: 4,
                          //                                                                                             crossAxisSpacing: 15,
                          //                                                                                             mainAxisSpacing: 5,
                          //                                                                                             childAspectRatio: 4 / 1.4,
                          //                                                                                           ),
                          //                                                                                           itemCount: slotType.slotDetails!.length,
                          //                                                                                           itemBuilder:
                          //                                                                                               (BuildContext context,
                          //                                                                                               int index2) {
                          //                                                                                             SlotBookedDetails
                          //                                                                                             slotDetails = slotType.slotDetails!.isEmpty
                          //                                                                                                 ? SlotBookedDetails()
                          //                                                                                                 : slotType.slotDetails![index2];
                          //                                                                                             //print("ccccccccccccccc${slotDetails.slotTime}");
                          //
                          //                                                                                             // Map slot=modal.controller.getPatientList[index]['slotDetails'][index2];
                          //
                          //                                                                                             return InkWell(
                          //                                                                                               onTap: () {
                          //                                                                                                 print(DateFormat("yyyy-MM-dd").format(modal.controller.getSelectedDate??DateTime.now()));
                          //                                                                                                 print(modal.controller.getSelectedDate);
                          //                                                                                                 if(DateFormat("yyyy-MM-dd").format(modal.controller.getSelectedDate??DateTime.now())==DateFormat("yyyy-MM-dd").format(DateTime.now())){
                          //                                                                                                   print("time is ${DateFormat('hh:mm a').format(DateFormat('hh:mma').parse(slotDetails.slotTime??""))}");
                          //                                                                                                   var selectedTime = DateFormat('HH:mm a').format(DateFormat('hh:mma').parse(slotDetails.slotTime??""));
                          //                                                                                                   //var newD =DateFormat("HH:mm").format(DateFormat.jm().parse(slotDetails.slotTime??""));
                          //                                                                                                   print(selectedTime);
                          //                                                                                                 }
                          //
                          //                                                                                                 modal.controller.saveTime
                          //                                                                                                     .value =
                          //                                                                                                     slotDetails.slotTime
                          //                                                                                                         .toString();
                          //
                          //                                                                                                 if (slotDetails.isBooked
                          //                                                                                                     .toString() !=
                          //                                                                                                     '1') {
                          //                                                                                                   modal.controller
                          //                                                                                                       .updateSelectedSlot =
                          //                                                                                                       slotDetails.slotType
                          //                                                                                                           .toString() +
                          //                                                                                                           index2
                          //                                                                                                               .toString();
                          //
                          //                                                                                                   modal
                          //                                                                                                       .controller
                          //                                                                                                       .getMyAppoointmentData
                          //                                                                                                       .appointmentId !=
                          //                                                                                                       0
                          //                                                                                                       ? reScheduleAppointment(
                          //                                                                                                       context)
                          //                                                                                                       : App().navigate(
                          //                                                                                                       context,
                          //                                                                                                       BookAppointmentView(
                          //                                                                                                         drName: widget
                          //                                                                                                             .drName
                          //                                                                                                             .toString(),
                          //                                                                                                         speciality: widget
                          //                                                                                                             .speciality
                          //                                                                                                             .toString(),
                          //                                                                                                         degree: widget
                          //                                                                                                             .degree
                          //                                                                                                             .toString(),
                          //                                                                                                         isEraUser: int
                          //                                                                                                             .parse(widget
                          //                                                                                                             .iSEraDoctor
                          //                                                                                                             .toString()),
                          //                                                                                                       ));
                          //                                                                                                 } else {
                          //                                                                                                   alertToast(context,
                          //                                                                                                       'Slot Booked Already');
                          //                                                                                                 }
                          //                                                                                               },
                          //                                                                                               child: Container(
                          //                                                                                                   decoration:
                          //                                                                                                   BoxDecoration(
                          //                                                                                                     border: Border.all(
                          //                                                                                                       color: Colors.grey.shade400,
                          //                                                                                                     ),
                          //                                                                                                     color: modal.controller
                          //                                                                                                         .selectedSlot ==
                          //                                                                                                         slotDetails
                          //                                                                                                             .slotType
                          //                                                                                                             .toString() +
                          //                                                                                                             index2
                          //                                                                                                                 .toString()
                          //                                                                                                         ? AppColor
                          //                                                                                                         .primaryColor
                          //                                                                                                         : slotDetails
                          //                                                                                                         .isBooked
                          //                                                                                                         .toString() !=
                          //                                                                                                         '1'
                          //                                                                                                         ? AppColor
                          //                                                                                                         .white
                          //                                                                                                         : AppColor
                          //                                                                                                         .white,
                          //                                                                                                     borderRadius:
                          //                                                                                                     const BorderRadius
                          //                                                                                                         .all(
                          //                                                                                                         Radius
                          //                                                                                                             .circular(
                          //                                                                                                             5)),
                          //                                                                                                   ),
                          //                                                                                                   child: Center(
                          //                                                                                                       child: Text(
                          //                                                                                                           slotDetails
                          //                                                                                                               .slotTime
                          //                                                                                                               .toString(),
                          //                                                                                                           style: MyTextTheme().smallPCB.copyWith(
                          //                                                                                                               color: modal.controller.selectedSlot == slotDetails.slotType.toString() + index2.toString()
                          //                                                                                                                   ? AppColor.white
                          //                                                                                                                   : slotDetails.isBooked.toString() != '1'
                          //                                                                                                                   ? Colors.grey.shade600
                          //                                                                                                                   : Colors.black54)))),
                          //                                                                                             );
                          //                                                                                           }),
                          //                                                                                       const SizedBox(
                          //                                                                                         height: 10,
                          //                                                                                       ),
                          //                                                                                     ]);
                          //                                                                               })),
                          //                                                                     ))),
                          //                                                           )
                          //                                                         ],
                          //                                                       );
                          //                                                     }),
                          //                                               ),
                          //                                               //*********
                          //
                          //                                             ],
                          //                                           ),
                          //                                         );
                          //                                       }
                          //                                   )
                          //                                   //********************************
                          //
                          //                                 ],
                          //                               ),
                          //                             ),
                          //                           ),
                          //                         ],
                          //                       ),
                          //                     ),
                          //
                          //
                          //                   ],
                          //                 ),
                          //               )
                        ],
                      ),
                    ),
                    SizedBox(height: 5,)
                  ],
                ),
              );
            },
          ),
          //******

          //*******




        ),
      ),
    );
  }

  reScheduleAppointment(
      context,
      ) {
    ApplicationLocalizations localization =
    Provider.of<ApplicationLocalizations>(context, listen: false);
    AlertDialogue().actionBottomSheet(
        subTitle: '${localization.getLocaleData.reScheduleAppointmentOn}${modal
            .formater(modal.controller.getSelectedDate ?? DateTime.now())}  ${modal.controller.saveTime.value}',
        title: localization.getLocaleData.reScheduleAppointment.toString(),
        cancelButtonName: localization.getLocaleData.no.toString(),
        okButtonName: localization.getLocaleData.yes.toString(),
        okPressEvent: () async {
          await modal.onPressedYes(context);
        });
  }
}


//   Container(
//                       height:300,
//                       //820,
//                       // MediaQuery.of(context).size.height * .89,
//                       color: AppColor.primaryColor,
//                       child: Padding(
//                         padding: const EdgeInsets.symmetric(
//                             vertical: 56, horizontal: 12),
//                         child:
//                         Column(
//                           crossAxisAlignment:
//                           CrossAxisAlignment.start,
//                           children: [
//                             Expanded(
//                               child: ListView.builder(itemCount: optionList.length,itemBuilder:(BuildContext context,int index){
//                                 return Padding(
//                                   padding:
//                                   const EdgeInsets.symmetric(
//                                       vertical: 20,
//                                       horizontal: 12),
//                                   child: InkWell(
//                                     onTap: (){
//                                       setState(() {
//                                         if(index==0){
//                                           isDoctor = true;
//                                           App().navigate(context, TopSpecialitiesView());
//                                         }
//                                         else{
//                                           isDoctor = false;
//                                           App().navigate(context, TopSpecialitiesView(isDoctor:1));
//                                         }
//                                       });
//                                       for (var element
//                                       in optionList) {
//                                         element["isChecked"] = false;
//                                       }
//                                       optionList[index]['isChecked']=true;
//                                     },
//
//                                     child: Container(
//                                       color: optionList[index]['isChecked']?AppColor
//                                           .primaryColorLight:AppColor.primaryColor,
//                                       child: Padding(
//                                         padding:
//                                         const EdgeInsets.all(
//                                             8.0),
//                                         child: Row(
//                                           children: [
//                                             Image.asset(
//                                               optionList[index]['icon'],
//                                               height: 40,
//                                             ),
//                                             const SizedBox(
//                                               width: 10,
//                                             ),
//                                             Expanded(
//                                               child: Text(
//                                                 optionList[index]['name'],
//                                                 style: MyTextTheme()
//                                                     .largeWCN,
//                                               ),
//                                             )
//                                           ],
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                 );
//                               }),
//                             ),
//                             // Expanded(child: SizedBox(width: 20,)),
//                             // Expanded(
//                             //   child: Row(
//                             //    crossAxisAlignment: CrossAxisAlignment.start,
//                             //     mainAxisAlignment: MainAxisAlignment.end,
//                             //     children: [
//                             //       SizedBox(width: 70,
//                             //         child: MyButton(width: 20,color: AppColor.primaryColorLight,title: "Back",
//                             //         onPress: (){
//                             //           App().navigate(context, TopSpecialitiesView());
//                             //         },
//                             //         ),
//                             //       ),
//                             //     ],
//                             //   ),
//                             // ),
//                           ],
//                         ),
//                       ),
//                     ),