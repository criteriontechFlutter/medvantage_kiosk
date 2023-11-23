

import 'package:digi_doctor/AppManager/app_util.dart';
import 'package:digi_doctor/Pages/Dashboard/OrganSymptom/organ_controller.dart';
import 'package:digi_doctor/Pages/Dashboard/Widget/profile_info_widget.dart';
import 'package:digi_doctor/Pages/Specialities/top_specialities_view.dart';
import 'package:digi_doctor/Pages/Symptoms/Select_Doctor/select_doctor_controller.dart';
import 'package:digi_doctor/Pages/Symptoms/Select_Doctor/select_doctor_data_modal.dart';
import 'package:digi_doctor/Pages/Symptoms/Select_Doctor/select_doctor_modal.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:provider/provider.dart';

import '../../../AppManager/app_color.dart';
import '../../../AppManager/my_text_theme.dart';
import '../../../AppManager/tab_responsive.dart';
import '../../../AppManager/widgets/MyTextField.dart';
import '../../../AppManager/widgets/common_widgets.dart';
import 'package:get/get.dart';

import '../../../AppManager/widgets/my_button.dart';
import '../../../Localization/app_localization.dart';
import '../../Dashboard/dashboard_modal.dart';
import '../../Specialities/NewBookAppintment/NewBookAppointemtView.dart';
import '../../Specialities/NewBookAppintment/NewBookAppointmentModal.dart';
import '../../Specialities/SpecialistDoctors/TimeSlot/time_slot_view.dart';
import '../../voiceAssistantProvider.dart';

class RecommendedDoctors extends StatefulWidget {
  final List selectedSymptomsId;
  final String? speechText;
   const RecommendedDoctors({Key? key, required this.selectedSymptomsId, this.speechText,}) : super(key: key);

  @override
  State<RecommendedDoctors> createState() => _RecommendedDoctorsState();
}

class _RecommendedDoctorsState extends State<RecommendedDoctors> {
  SelectDoctorModal modal = SelectDoctorModal();
  // TopSymptomsModal modal = TopSymptomsModal();
  DashboardModal dashboardModal=DashboardModal();

  final myList = [];
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

  get() async {
    VoiceAssistantProvider listenVM=Provider.of<VoiceAssistantProvider>(context,listen: false);
    listenVM.listeningPage='Recommended doctors';
    modal.controller.updateProblemId=widget.selectedSymptomsId;
    modal.controller.updateShowNoData = false;
  //  await modal.getDoctorBySymptom(context);
    await modal.getDoctorsList(context);
    modal.controller.updateShowNoData = true;
  }

  @override
  void initState() {
   print("object"+widget.selectedSymptomsId.toString());
   if(widget.selectedSymptomsId.isEmpty){
     optionList()[0]['isChecked']=true;
   }else{
     optionList()[1]['isChecked']=true;
   }
    super.initState();
    get();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    Get.delete<SelectDoctorController>();
  }

  @override
  Widget build(BuildContext context) {
    ApplicationLocalizations localization =
        Provider.of<ApplicationLocalizations>(context, listen: true);
    OrganController controller=Get.put(OrganController());
    NewBookAppointmentModal modal2 = NewBookAppointmentModal();

    return Container(
      color: AppColor.primaryColor,
      child: SafeArea(
        child: Scaffold(
            // appBar: MyWidget().myAppBar(context,
            //     title: localization.getLocaleData.searchDoctorsHere.toString()),
            body: GetBuilder(
                init: SelectDoctorController(),
                builder: (_) {
                  return Scrollbar(
                    child: Container(
                      //width: Get.width,
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

                          // Expanded(
                          //   flex: 2,
                          //   child: Container(
                          //     height: Get.height,
                          //     color: AppColor.primaryColor,
                          //     child: Padding(
                          //       padding: const EdgeInsets.symmetric(
                          //           vertical: 56, horizontal: 12),
                          //       child: Column(
                          //         crossAxisAlignment:
                          //         CrossAxisAlignment.start,
                          //         children: [
                          //
                          //           Expanded(
                          //             child: ListView.builder(itemCount: optionList.length,itemBuilder:(BuildContext context,int index){
                          //               return Padding(
                          //                 padding:
                          //                 const EdgeInsets.symmetric(
                          //                     vertical: 20,
                          //                     horizontal: 12),
                          //                 child: InkWell(
                          //                   onTap: (){
                          //                     setState(() {
                          //                       if(index==0){
                          //                         isDoctor = true;
                          //                         App().replaceNavigate(context, TopSpecialitiesView());
                          //                       }
                          //                       else{
                          //                         isDoctor = false;
                          //                       }
                          //                     });
                          //                     for (var element
                          //                     in optionList) {
                          //                       element["isChecked"] = false;
                          //                     }
                          //                     optionList[index]['isChecked']=true;
                          //                   },
                          //
                          //                   child: Container(
                          //                     color: optionList[index]['isChecked']?AppColor
                          //                         .primaryColorLight:AppColor.primaryColor,
                          //                     child: Padding(
                          //                       padding:
                          //                       const EdgeInsets.all(
                          //                           8.0),
                          //                       child: Row(
                          //                         children: [
                          //                           Image.asset(
                          //                             optionList[index]['icon'],
                          //                             height: 40,
                          //                           ),
                          //                           const SizedBox(
                          //                             width: 10,
                          //                           ),
                          //                           Expanded(
                          //                             child: Text(
                          //                               optionList[index]['name'],
                          //                               style: MyTextTheme()
                          //                                   .largeWCN,
                          //                             ),
                          //                           )
                          //                         ],
                          //                       ),
                          //                     ),
                          //                   ),
                          //                 ),
                          //               );
                          //             }),
                          //           ),
                          //
                          //         ],
                          //       ),
                          //     ),
                          //   ),
                          // ),

                        Expanded(
                          child:
                            Column(
                              // crossAxisAlignment: CrossAxisAlignment.start,
                              // mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                ProfileInfoWidget(),
                                Expanded(
                                  child: Column(children: [

                                    SizedBox(height: 110,
                                      child:
                                      ListView.builder(
                                          scrollDirection:   Axis.horizontal,
                                          physics: const NeverScrollableScrollPhysics(),
                                          itemCount: optionList().length,itemBuilder:(BuildContext context,int index){
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
                                                  App().replaceNavigate(context, TopSpecialitiesView());
                                                }
                                                else{
                                                  isDoctor = false;
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
                                                color: optionList()[index]['isChecked']?AppColor
                                                    .primaryColor:AppColor.white,
                                              ),
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
                                    Padding(
                                      padding:
                                      const EdgeInsets.fromLTRB(10, 0, 10, 15),
                                      child: Text(
                                        localization.getLocaleData.popularDoctors
                                            .toString(),
                                        style: MyTextTheme().largeWCB,
                                      ),
                                    ),

                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(10, 20, 10, 15),
                                      child: TabResponsive().wrapInTab(
                                        context: context,
                                        child: MyTextField(
                                          controller: modal.controller.searchC.value,
                                          hintText: localization
                                              .getLocaleData.searchDoctorsHere
                                              .toString(),
                                          onChanged: (val) {
                                            setState(() {});
                                          },
                                          suffixIcon: SizedBox(
                                            width: 50,
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.end,
                                              children: [
                                                VerticalDivider(
                                                  indent: 5,
                                                  endIndent: 5,
                                                  thickness: 1,
                                                  color: Colors.grey.shade400,
                                                ),
                                                const Icon(
                                                  CupertinoIcons.search,
                                                  size: 20,
                                                  color: Colors.grey,
                                                ),
                                                const Spacer(),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: InkWell(
                                        onTap: (){
                                          Navigator.pop(context);
                                        },
                                        child: Container(
                                          height: 80,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(10),
                                            color: Colors.white,
                                          ),
                                          child: Padding(
                                              padding: const EdgeInsets.symmetric(vertical: 8.0,horizontal: 12),
                                              child: Center(
                                                child: Row(
                                                  children: [
                                                    Icon(Icons.arrow_back,size: 30,color: AppColor.primaryColor,),
                                                    Expanded(child: Center(child: Text(widget.speechText??(modal.controller
                                                        .get_popular_Doctors_Data.isEmpty?localization.getLocaleData.doctorDataNotFound
                                                        .toString():localization.getLocaleData.doctors
                                                        .toString()), style: MyTextTheme().customLargePCB.copyWith(fontSize: 20),))),
                                                  ],
                                                )))),
                                      )),
                                    Visibility(
                                      visible: controller.getNLPData.disease!=null,
                                      child: Container(
                                        height: 50,
                                        decoration: const BoxDecoration(
                                            color: Colors.white30
                                        ),
                                        child: CommonWidgets().showNoData(
                                          title: localization.getLocaleData.doctorDataNotFound
                                              .toString(),
                                          show: (modal.controller.getShowNoData &&
                                              modal
                                                  .controller.get_popular_Doctors_Data.isEmpty),
                                          loaderTitle: localization
                                              .getLocaleData.loadingDoctorData
                                              .toString(),
                                          showLoader: (!modal.controller.getShowNoData &&
                                              modal
                                                  .controller.get_popular_Doctors_Data.isEmpty),

                                          child: ListView.builder(
                                            physics: const NeverScrollableScrollPhysics(),
                                            scrollDirection: Axis.horizontal,
                                            itemCount:controller.getNLPData.disease?.finalDiseaseList?.length??0,
                                            //itemCount:1,
                                            itemBuilder: (BuildContext context, int index) {
                                           return   Padding(
                                             padding: const EdgeInsets.all(8.0),
                                             child: Container(
                                               height: 20,
                                                 decoration: BoxDecoration(
                                                   borderRadius: BorderRadius.circular(10),
                                                   color: Colors.white,
                                                 ),
                                                 child: Padding(
                                                   padding: const EdgeInsets.symmetric(vertical: 4.0,horizontal:8),
                                                   child: Center(
                                                     child:
                                                    Text(controller.getNLPData.disease!.finalDiseaseList![index].problemNames.toString(),
                                                       style: MyTextTheme().customLargePCB.copyWith(fontSize: 14),),),
                                                 ),),
                                           );
                                            }),
                                        ),
                                      ),
                                    ),

                                    Expanded(
                                      //height: 800,
                                      child: Container(
                                        // color: Colors.red,
                                        child: Visibility(
                                          visible: modal.controller
                                              .get_popular_Doctors_Data.isNotEmpty,
                                          replacement: Container(

                                            child: Center(
                                              child: Text(localization.getLocaleData.doctorDataNotFound
                                                  .toString(),style: MyTextTheme().largePCB,),
                                            ),
                                          ),
                                          child: ListView.builder(
                                             // physics: NeverScrollableScrollPhysics(),
                                              itemCount:
                                              modal.controller
                                                  .get_popular_Doctors_Data.length,
                                              itemBuilder: (BuildContext context,int index){
                                                // PopularDoctorDataModal doctor = modal
                                                //     .controller
                                                //     .get_popular_Doctors_Data[index];
                                                DoctorsListDataModal doctor = modal
                                                    .controller
                                                    .get_popular_Doctors_Data[index];
                                                return
                                                  Padding(
                                                    padding: const EdgeInsets.all(8.0),
                                                    child: Container(
                                                      height: 100,
                                                      decoration: BoxDecoration(
                                                          color: AppColor.white,
                                                          borderRadius:const BorderRadius.all( Radius.circular(5))
                                                      )
                                                      ,child:Padding(
                                                      padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 5),
                                                      child: Row(
                                                          crossAxisAlignment: CrossAxisAlignment.center,
                                                          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                          children: [
                                                            // Expanded(flex: 1,
                                                            //   child: CachedNetworkImage(height: 25,imageUrl: doctor.imagePath
                                                            //       .toString(),
                                                            //       // progressIndicatorBuilder: (context,
                                                            //       //         url,
                                                            //       //         downloadProgress) =>
                                                            //       //     CircularProgressIndicator(
                                                            //       //         value:
                                                            //       //             downloadProgress
                                                            //       //                 .progress),
                                                            //       errorWidget: (context,
                                                            //           url, error) =>
                                                            //           Image.asset(
                                                            //               "assets/doctorSign.png")
                                                            //     // Icon(Icons.error),
                                                            //   ),
                                                            // ),
                                                            Expanded(flex: 2,
                                                              child: Text(
                                                                 '    ${doctor.name}',
                                                                style: MyTextTheme()
                                                                    .largeBCB,
                                                              ),
                                                            ),
                                                            // const Text("20 years of experience"),
                                                            Expanded(flex: 2,
                                                              child: Center(
                                                                child: Text(
                                                                  doctor.departmentName
                                                                      .toString(),
                                                                  style: MyTextTheme()
                                                                      .largePCB,
                                                                ),
                                                              ),
                                                            ),
                                                            // Text(
                                                            //   '\u{20B9}  ${doctor.drFee}',
                                                            //   style:
                                                            //   MyTextTheme().mediumPCB,
                                                            // ),
                                                            const Expanded(child: SizedBox()),
                                                            Expanded(flex: 1,
                                                              child:  SizedBox(
                                                                  width: 70,
                                                                  height: 100,
                                                                  child: MyButton(title: localization.getLocaleData.hintText!.book.toString(),
                                                                    onPress: (){
                                                                      modal2.controller.updateDoctorId=doctor.id;
                                                                      modal2.getDays(context,doctor.id.toString());
                                                                      App().navigate(context, TimeSlotView(profilePhoto: '',degree:'' ,doctorId:doctor.id.toString(),
                                                                        drName:doctor.name.toString(),
                                                                        fees: 0,
                                                                        iSEraDoctor:'',
                                                                        speciality:  '',
                                                                        timeSlots:const [],
                                                                        selectedDay:null,
                                                                        departmentId: doctor.departmentId??0,
                                                                        // departmentId: doctor.departmentId??0
                                                                      ));
//**//*********
   ///                                                               App().navigate(context, TimeSlotView(profilePhoto: doctor.imagePath.toString(),degree:doctor.degree.toString() ,doctorId:doctor.id.toString(),
   ///                                                                 drName:doctor.doctorName.toString(),
  ///                                                                  fees: double.parse(doctor.drFee.toString())+.0,
   ///                                                                 iSEraDoctor:doctor.isEraUser.toString(),
   ///                                                                 speciality:  doctor.degree.toString()
  ///                                                                  ,timeSlots:doctor.sittingDays??[],selectedDay:null,));
//
//                                                                 App().navigate(context, TimeSlotView(profilePhoto: doctor.profilePhotoPath.toString(),degree:doctor.degree.toString() ,doctorId:doctor.id.toString(),
//                                                                   drName:doctor.drName.toString(),
//                                                                   fees: double.parse(doctor.drFee.toString())+.0,
//                                                                   iSEraDoctor:doctor.isEraUser.toString(),
//                                                                   speciality:  doctor.degree.toString()
//                                                                   ,timeSlots:doctor.sittingDays??[],selectedDay:null,));
                                                                    },

                                                                  )),
                                                            )


                                                          ]
                                                      ),
                                                    ),


                                                    ),
                                                  );}
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],),
                                ),
                                // Visibility(
                                //   visible: modal
                                //       .controller
                                //       .get_recommended_Doctors_Data.isNotEmpty,
                                //   child: Column(
                                //     crossAxisAlignment: CrossAxisAlignment.start,
                                //     children: [
                                //       //************
                                //       Padding(
                                //         padding:
                                //             const EdgeInsets.fromLTRB(10, 20, 10, 0),
                                //         child: Text(
                                //           localization
                                //               .getLocaleData.recommendedDoctors
                                //               .toString(),
                                //           style: MyTextTheme().largeBCB,
                                //         ),
                                //       ),
                                //       const SizedBox(
                                //         height: 10,
                                //       ),
                                //       Padding(
                                //         padding:
                                //             const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                //         child: SizedBox(
                                //           height: 190,
                                //           child: ListView.separated(
                                //               physics: const BouncingScrollPhysics(
                                //                   parent: AlwaysScrollableScrollPhysics()),
                                //               shrinkWrap: true,
                                //               scrollDirection: Axis.horizontal,
                                //               itemBuilder:
                                //                   (BuildContext context, int index) {
                                //                 RecommendedDoctorDataModal listdata =
                                //                     modal.controller
                                //                             .get_recommended_Doctors_Data[
                                //                         index];
                                //                 return CustomInkwell(
                                //                   borderRadius: 5,
                                //                   elevation:3,shadowColor: AppColor.white,
                                //                   onPress: (){
                                //                     App().navigate(
                                //                         context,
                                //                         DoctorProfile(
                                //
                                //                           doctorId:
                                //                           listdata.id.toString(),
                                //
                                //                         ));
                                //                   },
                                //
                                //                     child: Padding(
                                //                       padding: const EdgeInsets
                                //                               .symmetric(
                                //                           horizontal: 10,
                                //                           vertical: 0),
                                //                       child: Column(
                                //                         crossAxisAlignment:
                                //                             CrossAxisAlignment
                                //                                 .center,
                                //                         children: [
                                //                           Padding(
                                //                             padding:
                                //                                 const EdgeInsets
                                //                                         .fromLTRB(
                                //                                     0, 10, 0, 10),
                                //                             child: CircleAvatar(
                                //                               radius: 30,
                                //                               child: CircleAvatar(
                                //                                 radius: 29,
                                //                                 backgroundColor:
                                //                                     Colors.grey
                                //                                         .shade300,
                                //                                 child: Container(
                                //                                   height: 35,
                                //                                   width: 35,
                                //                                   decoration:
                                //                                       const BoxDecoration(
                                //                                     borderRadius:
                                //                                         BorderRadius.all(
                                //                                             Radius.circular(
                                //                                                 100)),
                                //                                   ),
                                //                                   child:
                                //                                       CachedNetworkImage(
                                //                                     placeholder: (context,
                                //                                             url) =>
                                //                                         Image
                                //                                             .asset(
                                //                                       'assets/doctorSign.png',
                                //                                       height: 50,
                                //                                       width: 50,
                                //                                     ),
                                //                                     imageUrl: listdata
                                //                                         .imagePath
                                //                                         .toString(),
                                //                                     errorWidget: (context,
                                //                                             url,
                                //                                             error) =>
                                //                                         Image
                                //                                             .asset(
                                //                                       'assets/doctorSign.png',
                                //                                       height: 50,
                                //                                       width: 50,
                                //                                     ),
                                //                                   ),
                                //                                 ),
                                //                               ),
                                //                             ),
                                //                           ),
                                //                           Flexible(
                                //                             child: Text(
                                //                               listdata.doctorName
                                //                                   .toString(),
                                //                               style: MyTextTheme()
                                //                                   .mediumBCB,
                                //                               overflow:
                                //                                   TextOverflow
                                //                                       .ellipsis,
                                //                             ),
                                //                           ),
                                //                           const SizedBox(
                                //                             height: 5,
                                //                           ),
                                //                           Flexible(
                                //                             child: Text(
                                //                               listdata
                                //                                   .hospital_name
                                //                                   .toString(),
                                //                               style: MyTextTheme()
                                //                                   .mediumBCN,
                                //                             ),
                                //                           ),
                                //                           const SizedBox(
                                //                             height: 5,
                                //                           ),
                                //                           Flexible(
                                //                             child: Text(
                                //                               listdata.experience
                                //                                   .toString(),
                                //                               style: MyTextTheme()
                                //                                   .smallBCN,
                                //                             ),
                                //                           ),
                                //                           const SizedBox(
                                //                             height: 5,
                                //                           ),
                                //                           Row(
                                //                             mainAxisAlignment:
                                //                                 MainAxisAlignment
                                //                                     .center,
                                //                             children: [
                                //                               Icon(
                                //                                 Icons.star,
                                //                                 color: AppColor
                                //                                     .buttonColor,
                                //                                 size: 15,
                                //                               ),
                                //                               const SizedBox(
                                //                                 width: 5,
                                //                               ),
                                //                               Text(
                                //                                 listdata.review
                                //                                         .toString() +
                                //                                     ' (' +
                                //                                     listdata
                                //                                         .review
                                //                                         .toString() +
                                //                                     " " +
                                //                                     localization
                                //                                         .getLocaleData
                                //                                         .reviews
                                //                                         .toString() +
                                //                                     " )",
                                //                                 style:
                                //                                     MyTextTheme()
                                //                                         .mediumGCN,
                                //                               ),
                                //                             ],
                                //                           )
                                //                         ],
                                //                       ),
                                //                     ));
                                //               },
                                //               separatorBuilder:
                                //                   (BuildContext context, int index) =>
                                //                       const SizedBox(
                                //                         width: 10,
                                //                       ),
                                //               itemCount: modal
                                //                   .controller
                                //                   .get_recommended_Doctors_Data
                                //                   .length),
                                //         ),
                                //       ),
                                //       const SizedBox(
                                //         height: 20,
                                //       ),
                                //     ],
                                //   ),
                                // ),

                                //*************************
                                // Padding(
                                //   padding:
                                //   const EdgeInsets.fromLTRB(10, 0, 10, 15),
                                //   child: GridView.builder(
                                //     shrinkWrap: true,
                                //     physics:
                                //     const NeverScrollableScrollPhysics(),
                                //     itemCount: modal.controller
                                //         .get_popular_Doctors_Data.length,
                                //     gridDelegate:
                                //     SliverGridDelegateWithMaxCrossAxisExtent(
                                //         maxCrossAxisExtent: 600,
                                //         childAspectRatio: 6 / 3.2,
                                //         crossAxisSpacing: 20,
                                //         mainAxisSpacing: 10
                                //     ),
                                //     itemBuilder:
                                //         (BuildContext context, int index) {
                                //       // ListView.builder(
                                //       //   shrinkWrap: true,
                                //       //   physics: const NeverScrollableScrollPhysics(),
                                //       //   itemCount: modal.controller.get_popular_Doctors_Data.length,
                                //       //   itemBuilder: (BuildContext context, int index) {
                                //       PopularDoctorDataModal doctorData = modal
                                //           .controller
                                //           .get_popular_Doctors_Data[index];
                                //       return CustomInkwell(
                                //           elevation: 3,borderRadius: 10,
                                //           onPress: (){
                                //             App().navigate(
                                //                 context,
                                //                 DoctorProfile(
                                //                   // drName: doctorData.doctorName
                                //                   //     .toString(),
                                //                   // speciality: doctorData
                                //                   //     .speciality
                                //                   //     .toString(),
                                //                   // degree: doctorData.degree
                                //                   //     .toString(),
                                //                   // address: doctorData.address
                                //                   //     .toString(),
                                //                   // noofPatients: doctorData
                                //                   //     .noofPatients
                                //                   //     .toString(),
                                //                   // yearOfExperience: doctorData
                                //                   //     .experience
                                //                   //     .toString(),
                                //                   doctorId:
                                //                   doctorData.id.toString(),
                                //                   // iSEraDoctor: doctorData
                                //                   //     .isEraUser
                                //                   //     .toString(),
                                //                   // hospital: doctorData
                                //                   //     .hospital_name
                                //                   //     .toString(),
                                //                   // fees: doctorData.drFee ?? 0.0,
                                //                 ));
                                //           },
                                //           // decoration: BoxDecoration(
                                //           //     boxShadow: [
                                //           //       BoxShadow(
                                //           //         color: Colors.blue,
                                //           //         blurRadius: 1.0,
                                //           //         spreadRadius: 0.0,
                                //           //         offset: Offset(1.0, 2.0), // shadow direction: bottom right
                                //           //       )
                                //           //     ],
                                //           //     color: Colors.white,
                                //           //     borderRadius:
                                //           //         BorderRadius.circular(
                                //           //             10)),
                                //           child: Padding(
                                //             padding:
                                //             const EdgeInsets.fromLTRB(
                                //                 5, 10, 5, 10),
                                //             child: Stack(
                                //               clipBehavior: Clip.none,
                                //               children: [
                                //                 Column(
                                //                   mainAxisAlignment:
                                //                   MainAxisAlignment
                                //                       .start,
                                //                   children: [
                                //                     Row(
                                //                       crossAxisAlignment:
                                //                       CrossAxisAlignment
                                //                           .start,
                                //                       children: [
                                //                         Padding(
                                //                           padding:
                                //                           const EdgeInsets
                                //                               .fromLTRB(
                                //                               5,
                                //                               0,
                                //                               15,
                                //                               0),
                                //                           child: Container(
                                //                             height: 50,
                                //                             width: 45,
                                //                             decoration: BoxDecoration(
                                //                                 color: Colors
                                //                                     .blueGrey
                                //                                     .shade100,
                                //                                 borderRadius:
                                //                                 BorderRadius.circular(
                                //                                     5)),
                                //                             child: Padding(
                                //                               padding:
                                //                               const EdgeInsets
                                //                                   .all(5),
                                //                               child:
                                //                               CachedNetworkImage(
                                //                                 placeholder:
                                //                                     (context,
                                //                                     url) =>
                                //                                     Image.asset(
                                //                                       'assets/doctorSign.png',
                                //                                       height:
                                //                                       45,
                                //                                       width: 20,
                                //                                     ),
                                //                                 imageUrl: modal
                                //                                     .controller
                                //                                     .get_popular_Doctors_Data[
                                //                                 index]
                                //                                     .imagePath
                                //                                     .toString(),
                                //                                 errorWidget: (context,
                                //                                     url,
                                //                                     error) =>
                                //                                     Image
                                //                                         .asset(
                                //                                       'assets/doctorSign.png',
                                //                                       height:
                                //                                       45,
                                //                                       width: 20,
                                //                                     ),
                                //                               ),
                                //                             ),
                                //                           ),
                                //                         ),
                                //                         Expanded(
                                //                           flex: 3,
                                //                           child: Column(
                                //                             mainAxisAlignment:
                                //                             MainAxisAlignment
                                //                                 .start,
                                //                             crossAxisAlignment:
                                //                             CrossAxisAlignment
                                //                                 .start,
                                //                             children: [
                                //                               Row(
                                //                                 mainAxisAlignment: MainAxisAlignment.start,
                                //                                 children: [
                                //                                   Expanded(
                                //                                     child: Text(
                                //                                       modal
                                //                                           .controller
                                //                                           .get_popular_Doctors_Data[
                                //                                       index]
                                //                                           .doctorName
                                //                                           .toString(),
                                //                                       style: MyTextTheme()
                                //                                           .mediumPCB,
                                //                                     ),
                                //                                   ),
                                //                                   SizedBox(width: 50,)
                                //                                 ],
                                //                               ),
                                //                               Text(
                                //                                 modal
                                //                                     .controller
                                //                                     .get_popular_Doctors_Data[
                                //                                 index]
                                //                                     .hospital_name
                                //                                     .toString(),
                                //                                 style: MyTextTheme()
                                //                                     .smallGCN,
                                //                               ),
                                //                               Text(
                                //                                 modal
                                //                                     .controller
                                //                                     .get_popular_Doctors_Data[
                                //                                 index]
                                //                                     .speciality
                                //                                     .toString(),
                                //                                 style: MyTextTheme()
                                //                                     .smallGCN,
                                //                               ),
                                //                               //SizedBox(height: 3,),
                                //
                                //                             ],
                                //                           ),
                                //                         ),
                                //                       ],
                                //                     ),
                                //                     SizedBox(height: 20,),
                                //                     Wrap(
                                //                         spacing: 8,
                                //                         runSpacing:8,
                                //                         direction: Axis.horizontal,
                                //                         children:List.generate(modal.controller.weekDays.length, (index2) {
                                //                           return InkWell(
                                //                             onTap: (){
                                //                               startBookingTime = DateFormat("HH:mm:ss").format(DateTime.now()).toString();
                                //                               if(doctorData.sittingDays.toString().contains(modal.controller.weekDays[index2].toString())){
                                //                                 App().navigate(context, TimeSlotView(degree:doctorData.degree.toString() ,doctorId: doctorData.id.toString(),drName:doctorData.doctorName.toString(),
                                //                                   fees: double.parse(doctorData.fee.toString())+.0,
                                //                                   iSEraDoctor:doctorData.isEraUser.toString(),
                                //                                   speciality:doctorData.speciality.toString()
                                //                                   ,timeSlots:doctorData.sittingDays??[],selectedDay:modal.controller.weekDays[index2].toString() ,));
                                //                               }
                                //                               else{
                                //                                 alertToast(context, localization.getLocaleData.slotNotAvailable.toString());
                                //                               }
                                //
                                //                             },
                                //                             child: Material(
                                //                               elevation: 1,borderRadius: BorderRadius.all(Radius.circular(4)),
                                //                               child: Container(
                                //                                 height: 25,width: 40 ,
                                //                                 decoration: BoxDecoration(
                                //                                     color:doctorData.sittingDays.toString().contains(modal.controller.weekDays[index2].toString()) ? AppColor.orangeButtonColor : AppColor.greyLight.withOpacity(0.2),
                                //                                     borderRadius: const BorderRadius.all(Radius.circular(4)),
                                //                                     border: Border.all(color:  doctorData.sittingDays.toString().contains( modal.controller.weekDays[index2].toString()) ? AppColor.transparent : AppColor.transparent)
                                //                                 ),
                                //                                 child:
                                //                                 Padding(
                                //                                   padding: EdgeInsets.fromLTRB(3, 0, 3, 0),
                                //                                   child: Center(
                                //                                     child: Text(
                                //                                       modal.controller.weekDays[index2].toString().substring(0,3),
                                //                                       //day.toString().substring(0, 3),
                                //                                       style: TextStyle(
                                //                                         color: doctorData.sittingDays.toString().contains( modal.controller.weekDays[index2].toString()) ? Colors.white : AppColor.greyDark,
                                //                                       ),
                                //                                     ),
                                //                                   ),
                                //                                 ),
                                //                               ),
                                //                             ),
                                //                           );
                                //
                                //                         }
                                //                         )
                                //
                                //                     ),
                                //                     Expanded(
                                //                         child:
                                //                         const SizedBox(
                                //                           height: 3,
                                //                         )),
                                //                     Divider(
                                //                       thickness: 1,
                                //                       color: Colors
                                //                           .grey.shade200,
                                //                       indent: 3,
                                //                       endIndent: 3,
                                //                     ),
                                //                     Row(
                                //                       children: [
                                //                         const Icon(
                                //                           Icons
                                //                               .currency_rupee,
                                //                           color: Colors
                                //                               .lightGreen,
                                //                           size: 18,
                                //                         ),
                                //                         const SizedBox(
                                //                           width: 5,
                                //                         ),
                                //                         Text(
                                //                           modal
                                //                               .controller
                                //                               .get_popular_Doctors_Data[
                                //                           index]
                                //                               .fee
                                //                               .toString(),
                                //                           style:
                                //                           MyTextTheme()
                                //                               .mediumBCB,
                                //                         ),
                                //                         const SizedBox(
                                //                           width: 8,
                                //                         ),
                                //                         Text(
                                //                           localization
                                //                               .getLocaleData
                                //                               .consultationFee
                                //                               .toString(),
                                //                           style:
                                //                           MyTextTheme()
                                //                               .mediumGCN,
                                //                         )
                                //                       ],
                                //                     ),
                                //                   ],
                                //                 ),
                                //                 Positioned(
                                //                     top: 0,
                                //                     right: 20,
                                //                     child: InkWell(
                                //                       onTap: () async {
                                //                         final url_link =
                                //                             'https://www.com.digidoctor/doctor/${modal.controller.get_popular_Doctors_Data[index].id.toString()}';
                                //
                                //                         FlutterShare.share(
                                //                             text: localization
                                //                                 .getLocaleData
                                //                                 .hiThereFoundGreatDoctor
                                //                                 .toString() +
                                //                                 """ '${modal.controller.get_popular_Doctors_Data[index].doctorName.toString()}(${modal.controller.get_popular_Doctors_Data[index].hospital_name.toString()})
                                //                                 ${localization.getLocaleData.havingYearsExperience.toString().toString()}
                                //                                 ${modal.controller.get_popular_Doctors_Data[index].speciality.toString()}.
                                //                                 ${localization.getLocaleData.visitDoctorProfile.toString()} ${url_link.toString()}
                                //                   """,
                                //                             title: ' ');
                                //
                                //                         print(
                                //                             'iiiiiiiiiiiiiiiiiii');
                                //                       },
                                //                       child: Padding(
                                //                         padding:
                                //                         const EdgeInsets
                                //                             .all(8.0),
                                //                         child: const Icon(
                                //                           Icons.share,
                                //                           color:
                                //                           Colors.blue,
                                //                           size: 17,
                                //                         ),
                                //                       ),
                                //                     ))
                                //               ],
                                //             ),
                                //           ));
                                //     },
                                //   ),
                                // ),
                              ],
                            ),

                        )
                      ],),
                    ),
                  );
                })),
      ),
    );
  }
}
