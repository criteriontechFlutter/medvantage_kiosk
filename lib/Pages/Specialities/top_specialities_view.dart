import 'package:cached_network_image/cached_network_image.dart';
import 'package:digi_doctor/AppManager/app_util.dart';
import 'package:digi_doctor/AppManager/user_data.dart';
import 'package:digi_doctor/Pages/Dashboard/Widget/profile_info_widget.dart';
import 'package:digi_doctor/Pages/voiceAssistantProvider.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import '../../../Localization/app_localization.dart';
import 'package:digi_doctor/AppManager/widgets/common_widgets.dart';
import 'package:digi_doctor/Pages/Specialities/DataModal/top_specialities_data_modal.dart';
import 'package:digi_doctor/Pages/Specialities/top_specialities_controller.dart';
import 'package:digi_doctor/Pages/Specialities/top_specialities_modal.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../../AppManager/app_color.dart';
import '../../../AppManager/my_text_theme.dart';
import '../../AppManager/alert_dialogue.dart';
import '../../AppManager/tab_responsive.dart';
import '../../AppManager/widgets/MyCustomSD.dart';
import '../../AppManager/widgets/customInkWell.dart';
import '../../AppManager/widgets/my_button.dart';
import '../Dashboard/OrganSymptom/organListView.dart';
import '../Dashboard/Widget/footerView.dart';
import '../Dashboard/dashboard_controller.dart';
import '../Dashboard/dashboard_modal.dart';
import '../StartUpScreen/startup_screen.dart';
import '../doctorMedvantage/medvantage_modal.dart';
import 'NewBookAppintment/NewBookAppointemtView.dart';
import 'NewBookAppintment/NewBookAppointmentModal.dart';
import 'SpecialistDoctors/DataModal/search_specialist_doctor_data_modal.dart';
import 'SpecialistDoctors/DoctorProfile/doctor_profile_view.dart';
import 'SpecialistDoctors/TimeSlot/time_slot_view.dart';
import 'SpecialistDoctors/search_specialist_doctor_modal.dart';
import 'SpecialistDoctors/search_specialist_doctor_view.dart';

class TopSpecialitiesView extends StatefulWidget {
  int? isDoctor;
   TopSpecialitiesView({Key? key,  this.isDoctor}) : super(key: key);

  @override
  _TopSpecialitiesViewState createState() => _TopSpecialitiesViewState();
}

class _TopSpecialitiesViewState extends State<TopSpecialitiesView> {


optionList() {

  ApplicationLocalizations localization =
  Provider.of<ApplicationLocalizations>(context, listen: false);
return  [
    {
      'icon':"assets/kiosk_setting.png",
      'name':localization.getLocaleData.doctorBySpeciality.toString(),
      'isChecked':false
    },
    {
      'icon':"assets/kiosk_symptoms.png",
      'name':localization.getLocaleData.doctorBySymptoms.toString(),
      'isChecked':false
    },
  ];}

  bool isDoctor = true;
  int selectedIndex = 0;


  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      get();
    });

    super.initState();
  }

  get() async {
    VoiceAssistantProvider listenVM=Provider.of<VoiceAssistantProvider>(context,listen: false);
    listenVM.listeningPage="Top Specialities";
    MedvantageModal med=MedvantageModal();
    med.getDepartmentList();
    print("object${widget.isDoctor}");
    if(widget.isDoctor==1){
      isDoctor=false;
      widget.isDoctor = 1;
    }
    else{
      widget.isDoctor = 0;
    }
    print("object$isDoctor");
    modal.controller.updateSelectedId = await "2";
    await modal.getSpecialities(context);
   await specialistDoctorModal.getDoctorList(
      context,"1"
    );
  }

  @override
  void dispose() {
    super.dispose();
    Get.delete<TopSpecController>();
  }

  TopSpecModal modal = TopSpecModal();
NewBookAppointmentModal modal2 = NewBookAppointmentModal();
  SpecialistDoctorModal specialistDoctorModal = SpecialistDoctorModal();
  DashboardModal dashboardModal=DashboardModal();

 // DashboardController dashboardController = Get.find();

  @override
  Widget build(BuildContext context) {
    ApplicationLocalizations localization =
        Provider.of<ApplicationLocalizations>(context, listen: true);
    return Container(
      color: AppColor.primaryColor,
      child: SafeArea(
        child: Scaffold(
          body: GetBuilder(
            init: TopSpecController(),
            builder: (_) {
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
                  children: [
                    const SizedBox(
                        height: 80,
                        child: ProfileInfoWidget()),
                    SizedBox(
                      height: 110,

                      child: AnimationLimiter(
                        child: ListView.builder(
                            scrollDirection:   Axis.horizontal,
                           physics: const NeverScrollableScrollPhysics(),
                           // shrinkWrap: true,

                            itemCount: optionList().length,itemBuilder:(BuildContext context,int index){
                          return AnimationConfiguration.staggeredList(
                            position: index,
                              duration: const Duration(milliseconds: 800),
                            child: SlideAnimation(
                              horizontalOffset: 200.0,
                              //verticalOffset: 0100.0,
                              child: FadeInAnimation(
                                child: Padding(

                                  padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 18),
                                  child: InkWell(
                                    onTap: (){
                                      setState(() {
                                        if(index==0){
                                          isDoctor = true;
                                          widget.isDoctor = index;
                                        }
                                        else{
                                          isDoctor = false;
                                          widget.isDoctor = index;
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
                                     color: widget.isDoctor==index?AppColor.primaryColor:AppColor.white
                                   // color: optionList()[index]['isChecked']?AppColor
                                   //     .primaryColor:AppColor.white,
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
                                              color: widget.isDoctor==index?AppColor
                                                  .white:AppColor.secondaryColorShade2,
                                              height: 40,
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              optionList()[index]['name'],
                                              style: MyTextTheme()
                                                  .largeWCN.copyWith(color:widget.isDoctor==index?AppColor
                                                  .white:AppColor.secondaryColorShade2),
                                            ),
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
                    ),
                    //***
                    isDoctor?
                    Expanded(
                      // flex: 7,
                      //************
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 20),
                        child: Container(
                          color:AppColor.white,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(16,20,5,5),
                            child: Center(child:
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                //**

                                //*****
                                Text(localization.getLocaleData.hintText!.findDoctor.toString(),style: MyTextTheme().mediumGCN.copyWith(fontSize: 20)),
                                Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children:  [
                                          Text("${localization.getLocaleData.hintText!.Selected.toString()} \n${localization.getLocaleData.hintText!.specialist.toString()}",style: MyTextTheme().mediumGCN.copyWith(fontSize: 20),),
                                          const SizedBox(width: 130,),Expanded(child: Text(localization.getLocaleData.hintText!.doctorList.toString(), style: MyTextTheme().mediumGCN.copyWith(fontSize: 20),)),
                                          // Expanded(flex: 3,child: Column(
                                          //   crossAxisAlignment: CrossAxisAlignment.start,
                                          //   children: [
                                          //     Text(localization.getLocaleData.hintText!.findDoctor.toString(),style: MyTextTheme().mediumGCN.copyWith(fontSize: 20)),
                                          //
                                          //   ],
                                          // )),
                                        ],),
                                    ),
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      //mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width:Orientation.portrait==MediaQuery.of(context).orientation?Get.width/3.4 :Get.width/4.5 ,
                                          height: MediaQuery.of(context).size.height-380,
                                          child: ListView(
                                            children: [
                                              AnimationLimiter(
                                                child: StaggeredGrid.count(
                                                  crossAxisCount: 1,
                                                  children: List.generate(
                                                      modal
                                                          .controller
                                                          .getTopSpecialities
                                                          .length, (index) {
                                                    TopSpecialitiesDataModal details =
                                                    (modal
                                                        .controller
                                                        .topSpecialities
                                                        .isEmpty &&
                                                        modal
                                                            .controller
                                                            .getTopSpecialities
                                                            .isEmpty)
                                                        ? TopSpecialitiesDataModal(
                                                      id: 0,
                                                      departmentName:
                                                      'departmentName',
                                                      code: '',
                                                    )
                                                        : modal.controller
                                                        .getTopSpecialities[
                                                    index];

                                                    print(modal.controller
                                                        .topSpecialities.length);

                                                    return AnimationConfiguration.staggeredList(
                                                      position: index,
                                                      duration: const Duration(milliseconds:800),
                                                      child: SlideAnimation(
                                                        horizontalOffset: 200.0,
                                                        child: FadeInAnimation(
                                                          child: SizedBox(
                                                            child:
                                                            Row(
                                                              children: [
                                                                Padding(
                                                                  padding: const EdgeInsets
                                                                      .fromLTRB(
                                                                      10, 10, 10, 10),
                                                                  child: PhysicalModel(
                                                                    shape:
                                                                    BoxShape.rectangle,
                                                                    borderRadius:
                                                                    const BorderRadius
                                                                        .all(
                                                                        Radius.circular(
                                                                            10)),
                                                                    color: AppColor.white,
                                                                    elevation: 5,
                                                                    child: Container(
                                                                      width: 200,
                                                                      height: Get.height*0.15,
                                                                      decoration: BoxDecoration(
                                                                        //

                                                                          color:modal.controller.getSelectedIndex == index?
                                                                          AppColor.primaryColor
                                                                              :
                                                                          AppColor.white,
                                                                          borderRadius:
                                                                          BorderRadius
                                                                              .circular(
                                                                              10),
                                                                          border: Border.all(
                                                                              color: AppColor
                                                                                  .primaryColor)),
                                                                      child: TextButton(
                                                                        style: CommonWidgets()
                                                                            .myButtonStyle
                                                                            .copyWith(),
                                                                        onPressed: () {
                                                                          setState(() {

                                                                          });
                                                                          modal.controller.updateSelectedIndex = index;
                                                                          modal2.controller.updateDepartment = details.departmentName;
                                                                          modal2.controller.updateDepartmentId = details.id.toString();
                                                                          modal.controller.updateSelectedId = details.id.toString();
                                                                          print("id: ${details.id}");
                                                                          specialistDoctorModal.getDoctorList(
                                                                            context,details.id.toString()
                                                                          );
                                                                          //    modal.onPressedSpecialities(context);
                                                                        },
                                                                        child: Padding(
                                                                          padding:
                                                                          const EdgeInsets
                                                                              .only(
                                                                              left: 20,
                                                                              top: 19,
                                                                              right: 10),
                                                                          child: Row(
                                                                            mainAxisAlignment:
                                                                            MainAxisAlignment.spaceEvenly,
                                                                            // mainAxisAlignment:
                                                                            //     MainAxisAlignment.center,
                                                                            children: [
                                                                              Expanded(flex: 2,
                                                                                child: Column(
                                                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                                                  children: [
                                                                                    // CachedNetworkImage(
                                                                                    //   //fit: BoxFit.fitHeight,
                                                                                    //   height:
                                                                                    //   35,
                                                                                    //   width: 35,
                                                                                    //   imageUrl: details
                                                                                    //       .imagePath
                                                                                    //       .toString(),
                                                                                    //   errorWidget: (context, url, error) => modal.controller.getTopSpecialities.isEmpty
                                                                                    //       ? const CircleAvatar()
                                                                                    //       : const Image(
                                                                                    //     image: AssetImage('assets/Clinics.png'),
                                                                                    //   ),
                                                                                    // ),
                                                                                    const SizedBox(
                                                                                      height:
                                                                                      10,
                                                                                    ),
                                                                                    Text(
                                                                                      details
                                                                                          .departmentName
                                                                                          .toString(),
                                                                                      style:modal.controller.getSelectedIndex == index?MyTextTheme()
                                                                                          .mediumWCB:MyTextTheme(). mediumGCN ,
                                                                                      // textAlign:
                                                                                      //     TextAlign.center,
                                                                                      overflow: TextOverflow.clip,

                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                              ),

                                                                              Column(
                                                                                mainAxisAlignment: MainAxisAlignment.center,
                                                                                children: [
                                                                                  // Align(
                                                                                  //   child: Text(
                                                                                  //     //  localization.getLocaleData.noOfDoctors.toString() +
                                                                                  //       details
                                                                                  //           .noOfDoctors
                                                                                  //           .toString(),
                                                                                  //       style:modal.controller.getSelectedIndex == index?MyTextTheme()
                                                                                  //           .veryLargeWCB:MyTextTheme().veryLargeBCN.copyWith(color: AppColor.greyDark,),
                                                                                  //
                                                                                  //       textAlign:
                                                                                  //       TextAlign.left),
                                                                                  // ),
                                                                                  const SizedBox(
                                                                                    height:
                                                                                    9,
                                                                                  ),
                                                                                  // Text(
                                                                                  //   "",
                                                                                  //   style: modal.controller.getSelectedIndex == index?MyTextTheme()
                                                                                  //       .mediumWCN:MyTextTheme()
                                                                                  //       .mediumGCN,
                                                                                  // )
                                                                                ],
                                                                              )
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
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
                                        Expanded(
                                          //**************************************************
                                          child: Container(
                                            height: MediaQuery.of(context).size.height-380,
                                            color: AppColor.bgColor,
                                            child: ListView(
                                              physics: const NeverScrollableScrollPhysics(),
                                              children: [

                                                GetBuilder(
                                                    init: specialistDoctorModal.controller,
                                                    builder: (_) {
                                                      return SizedBox(
                                                        height:MediaQuery.of(context).size.height-370,
                                                        child: Column(
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            //*****sEARCH DOCTOR
                                                            // SizedBox(
                                                            //   height: 40,
                                                            //   width: 450,
                                                            //   child: TabResponsive().wrapInTab(
                                                            //     context: context,
                                                            //     child: TextFormField(
                                                            //       controller: specialistDoctorModal.controller.searchC.value,
                                                            //       onChanged: (val) {
                                                            //         print(specialistDoctorModal.controller.getDataList[0].sittingDays.toString());
                                                            //         setState(() {});
                                                            //       },
                                                            //       style: const TextStyle(fontSize: 18),
                                                            //       decoration: InputDecoration(
                                                            //         contentPadding: const EdgeInsets.symmetric(
                                                            //             horizontal: 24, vertical: 8),
                                                            //         hintText: localization.getLocaleData.searchDoctorsHere.toString(),
                                                            //         suffixIcon: SizedBox(
                                                            //           width: 50,
                                                            //           child: Row(
                                                            //             mainAxisAlignment: MainAxisAlignment.end,
                                                            //             children: [
                                                            //               VerticalDivider(
                                                            //                 indent: 6,
                                                            //                 endIndent: 6,
                                                            //                 thickness: 1,
                                                            //                 color: Colors.grey.shade400,
                                                            //               ),
                                                            //               InkWell(
                                                            //                 child: const Icon(
                                                            //                   CupertinoIcons.search,
                                                            //                   size: 20,
                                                            //                   color: Colors.grey,
                                                            //                 ),
                                                            //                 onTap: () {},
                                                            //               ),
                                                            //               const Spacer(),
                                                            //             ],
                                                            //           ),
                                                            //         ),
                                                            //         hintStyle: TextStyle(
                                                            //             color: AppColor.greyLight, fontSize: 18),
                                                            //         filled: true,
                                                            //         fillColor: Colors.white,
                                                            //         focusedBorder: OutlineInputBorder(
                                                            //             borderRadius: BorderRadius.circular(10),
                                                            //             borderSide: BorderSide(
                                                            //                 color: AppColor.greyLight)),
                                                            //         enabledBorder: OutlineInputBorder(
                                                            //             borderRadius: BorderRadius.circular(10),
                                                            //             borderSide: BorderSide(
                                                            //                 color: AppColor.greyLight,
                                                            //                 width: 1)),
                                                            //       ),
                                                            //     ),
                                                            //   ),
                                                            // ),
                                                            // const SizedBox(height: 20,),
                                                            // Padding(
                                                            //   padding: const EdgeInsets.fromLTRB(15, 10, 5,8),
                                                            //   child: Row(
                                                            //     // mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                            //     children: [
                                                            //       Image.asset("assets/kiosk_doctor.png",height: 35,),
                                                            //       const SizedBox(width: 5,),
                                                            //       Text("List of Doctors", style: MyTextTheme().mediumGCN,),const SizedBox(width: 5,),
                                                            //       VerticalDivider(thickness: 5,width: 5,color: AppColor.greyLight,endIndent: 5,indent: 5),const SizedBox(width: 5,),
                                                            //         ],),
                                                            // ),
                                                            const SizedBox(height: 5),
                                                            Expanded(
                                                                child: Center(
                                                                  child: CommonWidgets().showNoData(
                                                                    title: localization.getLocaleData.dataNotFound.toString(),
                                                                    show: (modal.controller.getShowNoTopData &&
                                                                        specialistDoctorModal.controller.getDataList.isEmpty),
                                                                    loaderTitle: localization.getLocaleData.loadingPrescriptionHistory.toString(),
                                                                    showLoader: (!modal.controller.getShowNoTopData &&
                                                                        specialistDoctorModal.controller.getDataList.isEmpty),
                                                                    child: AnimationLimiter(
                                                                      child: ListView.builder(
                                                                          itemCount: specialistDoctorModal.controller.getDataList.length,
                                                                          itemBuilder: (BuildContext context,int index){
                                                                            SearchDataModel doctor =specialistDoctorModal.controller.getDataList[index];
                                                                            return
                                                                              AnimationConfiguration.staggeredList(
                                                                                position: index,
                                                                                duration: const Duration(milliseconds: 800),
                                                                                child: SlideAnimation(
                                                                                  horizontalOffset: 200.0,
                                                                                  duration: const Duration(milliseconds: 800),
                                                                                  curve: Curves.linear,
                                                                                  child: FadeInAnimation(
                                                                                    child: Padding(
                                                                                      padding: const EdgeInsets.all(8.0),
                                                                                      child: Container(
                                                                                        height: 80,
                                                                                        decoration: BoxDecoration(
                                                                                            color: AppColor.white,
                                                                                            borderRadius:const BorderRadius.all( Radius.circular(5))
                                                                                        )
                                                                                        ,child:Padding(
                                                                                        padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 5),
                                                                                        child: Row(
                                                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                                                            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                                            children: [
                                                                                              // Expanded(flex: 1,
                                                                                              //   child: CachedNetworkImage(height: 50,imageUrl: doctor
                                                                                              //       .profilePhotoPath
                                                                                              //       .toString(),
                                                                                              //       errorWidget: (context,
                                                                                              //           url, error) =>
                                                                                              //           Image.asset(
                                                                                              //               "assets/doctorSign.png")
                                                                                              //     // Icon(Icons.error),
                                                                                              //   ),
                                                                                              // ),
                                                                                              Expanded(flex: 2,
                                                                                                child: Column(
                                                                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                                                                  children: [
                                                                                                    Text(
                                                                                                      doctor.name
                                                                                                          .toString(),
                                                                                                      style: MyTextTheme()
                                                                                                          .smallBCB,
                                                                                                    ),
                                                                                                    Expanded(
                                                                                                      child: Text(
                                                                                                        doctor.titleName.toString(),
                                                                                                        style:
                                                                                                        MyTextTheme().smallBCN,
                                                                                                      ),
                                                                                                    )
                                                                                                  ],
                                                                                                ),
                                                                                              ),
                                                                                              // const Text("20 years of experience"),
                                                                                              // Expanded(flex: 2,
                                                                                              //   child: Text(
                                                                                              //     doctor.hospitalName
                                                                                              //         .toString(),
                                                                                              //     style: MyTextTheme()
                                                                                              //         .smallPCN,
                                                                                              //   ),
                                                                                              // ),
                                                                                              SizedBox(
                                                                                                  width: 80,
                                                                                                  child: MyButton(title:localization.getLocaleData.hintText!.book.toString(),height: 100,
                                                                                                    onPress: (){
                                                                                                    modal2.controller.updateDoctorId=doctor.id;
                                                                                                    App().navigate(context, NewBookAppointment(doctorName: doctor.name.toString(),doctorId:doctor.id));
//**//**********
//                                                                                                       App().navigate(context, TimeSlotView(profilePhoto: doctor.profilePhotoPath.toString(),degree:doctor.degree.toString() ,doctorId:doctor.id.toString(),
//                                                                                                         drName:doctor.drName.toString(),
//                                                                                                         fees: double.parse(doctor.drFee.toString())+.0,
//                                                                                                         iSEraDoctor:doctor.isEraUser.toString(),
//                                                                                                         speciality:  doctor.degree.toString()
//                                                                                                         ,timeSlots:doctor.sittingDays??[],selectedDay:null,));
                                                                                                    },

                                                                                                  ))


                                                                                            ]
                                                                                        ),
                                                                                      ),


                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              );}
                                                                      ),
                                                                    ),
                                                                  ),
                                                                )
                                                            )
                                                          ],
                                                        ),
                                                      );
                                                    }
                                                )


                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                //********
                              ],
                            ),),
                          ),
                        ),
                      ),
                    ):
                    const Expanded(flex: 7,child: OrganListView()),
                    // SizedBox(
                    //     height: Get.height*0.11,
                    //     child: const FooterView())
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

//   Stack(
//                                           children: [
//                                             Padding(
//                                               padding: const EdgeInsets.fromLTRB(
//                                                   10, 50, 10, 10),
//                                               child: PhysicalModel(
//                                                 shape: BoxShape.rectangle,
//                                                 borderRadius: const BorderRadius.all(
//                                                     Radius.circular(10)),
//                                                 color: AppColor.white,
//                                                 elevation: 5,
//                                                 child: Container(
//                                                   decoration: BoxDecoration(
//                                                       color: AppColor.white,
//                                                       borderRadius:
//                                                           BorderRadius.circular(10),
//                                                       border: Border.all(
//                                                           color:
//                                                               AppColor.primaryColor)),
//                                                   child: TextButton(
//                                                     style: CommonWidgets()
//                                                         .myButtonStyle
//                                                         .copyWith(),
//                                                     onPressed: () {
//                                                       modal.controller
//                                                               .updateSelectedId =
//                                                           details.id.toString();
//                                                       modal.onPressedSpecialities(
//                                                           context);
//                                                     },
//                                                     child: Center(
//                                                       child: Column(
//                                                         mainAxisAlignment:
//                                                             MainAxisAlignment.center,
//                                                         children: [
//                                                           const SizedBox(
//                                                             height: 40,
//                                                           ),
//                                                           Text(
//                                                             details.specialityName
//                                                                 .toString(),
//                                                             style: MyTextTheme()
//                                                                 .mediumBCB,
//                                                             textAlign:
//                                                                 TextAlign.center,
//                                                           ),
//                                                           Text(
//                                                               localization.getLocaleData.noOfDoctors.toString() +
//                                                                   details.noOfDoctors
//                                                                       .toString(),
//                                                               style: MyTextTheme()
//                                                                   .mediumBCN,
//                                                               textAlign:
//                                                                   TextAlign.center),
//                                                           const SizedBox(
//                                                             height: 10,
//                                                           )
//                                                         ],
//                                                       ),
//                                                     ),
//                                                   ),
//                                                 ),
//                                               ),
//                                             ),
//                                             Positioned(
//                                               left: 50,
//                                               right: 50,
//                                               top: 20,
//                                               child: Container(
//                                                 height: 70,
//                                                 width: 30,
//                                                 decoration: const BoxDecoration(
//                                                   shape: BoxShape.circle,
//                                                 ),
//                                                 child: CachedNetworkImage(
//                                                   fit: BoxFit.contain,
//                                                   // placeholder: (context, url) => const Center(
//                                                   //   child: SizedBox(
//                                                   //     height: 36,
//                                                   //     child: CircleAvatar(),
//                                                   //   ),
//                                                   // ),
//                                                   imageUrl:
//                                                       details.imagePath.toString(),
//                                                   errorWidget:
//                                                       (context, url, error) => modal
//                                                               .controller
//                                                               .getTopSpecialities
//                                                               .isEmpty
//                                                           ? const CircleAvatar()
//                                                           : const Image(
//                                                               image: AssetImage(
//                                                                   'assets/Clinics.png'),
//                                                             ),
//                                                 ),
//                                               ),
//                                             )
//                                           ],
//                                         ),
