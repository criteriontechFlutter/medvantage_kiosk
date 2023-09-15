

import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:digi_doctor/AppManager/widgets/customInkWell.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:share_plus/share_plus.dart';
import '../../../Localization/app_localization.dart';
import 'package:digi_doctor/AppManager/app_color.dart';
import 'package:digi_doctor/AppManager/my_text_theme.dart';
import 'package:digi_doctor/AppManager/widgets/common_widgets.dart';
import 'package:digi_doctor/AppManager/widgets/my_button.dart';
import 'package:digi_doctor/Pages/Specialities/SpecialistDoctors/search_specialist_doctor_controller.dart';
import 'package:digi_doctor/Pages/Specialities/SpecialistDoctors/DataModal/search_specialist_doctor_data_modal.dart';
import 'package:digi_doctor/Pages/Specialities/SpecialistDoctors/search_specialist_doctor_modal.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../../AppManager/alert_dialogue.dart';
import '../../../AppManager/app_util.dart';
import '../../../AppManager/tab_responsive.dart';
import 'DoctorProfile/doctor_profile_view.dart';
import 'TimeSlot/time_slot_view.dart';

class SearchDoctors extends StatefulWidget {
  const SearchDoctors({
    Key? key,
  }) : super(key: key);

  @override
  _SearchDoctorsState createState() => _SearchDoctorsState();
}

class _SearchDoctorsState extends State<SearchDoctors> {
  SpecialistDoctorModal modal = SpecialistDoctorModal();

  get() async {
    await modal.getDoctorList(
      context,'1'
    );
    //log("mmmmmmmmmmmmmmmmmmmmmmmmmmmm"+modal.controller.doctorList[32]['sittingDays'].toString());
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      get();
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    Get.delete<SpecialistDoctorController>();
  }

  @override
  Widget build(BuildContext context) {
    ApplicationLocalizations localization=Provider.of<ApplicationLocalizations>(context,listen: true);
    return Container(
      color: AppColor.primaryColor,
      child: SafeArea(
        child: Scaffold(
          //backgroundColor: AppColor.lightBackground,
          body: GetBuilder(
              init: SpecialistDoctorController(),
              builder: (_) {
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(15, 5, 15, 8),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  IconButton(
                                    icon: const Icon(
                                        Icons.arrow_back_ios_outlined,
                                        color: Colors.black),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                  ),
                                ],
                              ),
                              Expanded(
                                child: Row(
                                  children: [
                                    Text( localization.getLocaleData.searchDoctor.toString(),
                                        style: MyTextTheme().largeBCB),
                                  ],
                                ),
                              ),
                              const LocationName()
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            height: 40,
                            child: TabResponsive().wrapInTab(
                              context: context,
                              child: TextFormField(
                                controller: modal.controller.searchC.value,
                                onChanged: (val) {
                                  //print(modal.controller.getDataList[0].sittingDays.toString());
                                  setState(() {});
                                },
                                style: const TextStyle(fontSize: 18),
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 24, vertical: 8),
                                  hintText: localization.getLocaleData.searchDoctorsHere.toString(),
                                  suffixIcon: SizedBox(
                                    width: 50,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        VerticalDivider(
                                          indent: 6,
                                          endIndent: 6,
                                          thickness: 1,
                                          color: Colors.grey.shade400,
                                        ),
                                        InkWell(
                                          child: const Icon(
                                            CupertinoIcons.search,
                                            size: 20,
                                            color: Colors.grey,
                                          ),
                                          onTap: () {},
                                        ),
                                        const Spacer(),
                                      ],
                                    ),
                                  ),
                                  hintStyle: TextStyle(
                                      color: AppColor.greyLight, fontSize: 18),
                                  filled: true,
                                  fillColor: Colors.white,
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(50),
                                      borderSide: BorderSide(
                                          color: AppColor.primaryColor)),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(50),
                                      borderSide: BorderSide(
                                          color: AppColor.primaryColor,
                                          width: 1)),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                        child: Center(
                          child: CommonWidgets().showNoData(
                            title: localization.getLocaleData.doctorListDataNotFound.toString(),
                            show: (modal.controller.getShowNoData &&
                                modal.controller.getDataList.isEmpty),
                            loaderTitle: localization.getLocaleData.loadingDoctorList.toString(),
                            showLoader: (!modal.controller.getShowNoData &&
                                modal.controller.getDataList.isEmpty),
                            child:  ListView(physics:const BouncingScrollPhysics(
                                parent: AlwaysScrollableScrollPhysics()),
                              children: [
                                StaggeredGrid.count(
                                  crossAxisSpacing: 10.0,
                                  mainAxisSpacing: 0.0,
                                  crossAxisCount: MediaQuery.of(context).size.width>600? 2:1,
                                  children: List.generate(
                                      modal.controller.getDataList.length,
                                          (index) {
                                        SearchDataModel doctor =
                                        modal.controller.getDataList[index];
                                        //modal.controller.updateIsFavoriteDoctor = doctor.isFavourite==1?true:false;
                                        return Padding(
                                          padding: const EdgeInsets.all(8),
                                          child: CustomInkwell(
                                            borderRadius: 15,elevation: 2,
                                            // width:
                                            // MediaQuery.of(context).size.width,
                                            // decoration: BoxDecoration(
                                            //   boxShadow: [
                                            //     BoxShadow(
                                            //       color: Colors.blue.shade100,
                                            //       blurRadius: 1.0,
                                            //       spreadRadius: 0.0,
                                            //       offset: Offset(1.0, 2.0), // shadow direction: bottom right
                                            //     )
                                            //   ],
                                            //   color: Colors.white,
                                            //   borderRadius:
                                            //   BorderRadius.circular(10),
                                            // ),
                                            onPress: (){


                                              App().navigate(
                                                  context,
                                                  DoctorProfile(
                                                    // address:
                                                    // doctor.address.toString(),
                                                    // degree: doctor.degree.toString(),
                                                    // drName: doctor.drName.toString(),
                                                    // noofPatients: doctor.noofPatients
                                                    //     .toString(),
                                                    // speciality:
                                                    // doctor.speciality.toString(),
                                                    // yearOfExperience: doctor
                                                    //     .yearOfExperience
                                                    //     .toString(),
                                                    doctorId: doctor.id.toString(),
                                                    // iSEraDoctor:
                                                    // doctor.isEraUser.toString(),
                                                    // hospital: doctor.hospitalName
                                                    //     .toString(),
                                                    // fees: doctor.drFee ?? 0.0,
                                                  ));
                                            },
                                            child: Column(
                                              children: [
                                                Padding(
                                                  padding:
                                                  const EdgeInsets.all(8.0),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                    children: [
                                                      Container(
                                                        height: 40,
                                                        width: 40,
                                                        decoration: BoxDecoration(
                                                          borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                          color:
                                                          Colors.grey.shade50,

                                                        ),
                                                        // child: CachedNetworkImage(
                                                        //     imageUrl: doctor
                                                        //         .profilePhotoPath
                                                        //         .toString(),
                                                        //     errorWidget: (context,
                                                        //         url, error) =>
                                                        //         Image.asset(
                                                        //             "assets/doctorSign.png")
                                                        //   // Icon(Icons.error),
                                                        // ),
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
                                                              doctor.name
                                                                  .toString(),
                                                              style: MyTextTheme()
                                                                  .smallBCB,
                                                            ),
                                                            // Text(
                                                            //   doctor.speciality
                                                            //       .toString(),
                                                            //   style: MyTextTheme()
                                                            //       .smallBCN,
                                                            // ),
                                                            // Text(
                                                            //   doctor.hospitalName
                                                            //       .toString(),
                                                            //   style: MyTextTheme()
                                                            //       .smallPCN,
                                                            // )
                                                          ],
                                                        ),
                                                      ),
                                                      InkWell(
                                                        onTap: () {
                                                          alertToast(context,
                                                              localization.getLocaleData.featureWillAvailableSoon.toString());
                                                        },
                                                        child: InkWell(
                                                          onTap: () async {
                                                            Share.share(

                                                              " Hi there!! \n I found a great Doctor " +
                                                                  doctor.name
                                                                      .toString() +
                                                                  // " having " +
                                                                  // doctor
                                                                  //     .yearOfExperience
                                                                  //     .toString() +
                                                                  // " in " +
                                                                  // doctor.speciality
                                                                  //     .toString() +
                                                                  // " visit Doctor's profile " +
                                                                  "http://digiDoctor.com/${doctor.id}",
                                                              //'http://theorganicdelight.com/$heroTag-$productCode-$productId-$productVarient-$PageName',
                                                              subject:  'Doctor Profile',
                                                            );
                                                            // Share.share(  subject: 'Look what I made!');
                                                          },
                                                          child: const Padding(
                                                            padding:
                                                            EdgeInsets.all(8.0),
                                                            child: Icon(
                                                              Icons.share,
                                                              color: Colors.blue,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      // IconButton(
                                                      //   onPressed: () async {
                                                      //     modal.controller.updateIsFavoriteDoctor = !modal.controller.getIsFavoriteDoctor;
                                                      //     //log("nnnnnnnnnnnnnnnnn"+modal.controller.doctorList[index].toString());
                                                      //     //print("---------"+doctor.id.toString());
                                                      //     //await modal.addFavouriteDoctor(context,doctor.id.toString(),doctor.isFavourite !=1? 1:0);
                                                      //     // if(doctor.isFavourite !=1){
                                                      //     //   //print("ccccccccccccc${doctor.isFavourite}");
                                                      //     //   modal.dashboardModal.controller.updateFavoriteDoctor(modal.controller.doctorList[index]);
                                                      //     // }
                                                      //     // else{
                                                      //     //   //print("ccccccccccccc${doctor.isFavourite}");
                                                      //     //  // modal.dashboardController.removeFavoriteDoctor(modal.controller.doctorList[index]);
                                                      //     //   modal.dashboardModal.controller.removeFavoriteDoctor(modal.controller.doctorList[index]);
                                                      //     // }
                                                      //   },
                                                      //   // icon: SvgPicture.asset(
                                                      //   //   doctor.isFavourite ==1?  'assets/heart.svg':'assets/unFavourite.svg',
                                                      //   //   height: 20,
                                                      //   // ),
                                                      // )
                                                    ],
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                  const EdgeInsets.fromLTRB(
                                                      10, 15, 0, 0),
                                                  child: Row(
                                                    children: [
                                                      const Icon(
                                                        Icons.people_outline,
                                                        color: Colors.blue,
                                                        size: 15,
                                                      ),
                                                      const SizedBox(
                                                        width: 8,
                                                      ),
                                                      // Text(
                                                      //   doctor.noofPatients
                                                      //       .toString(),
                                                      //   style:
                                                      //   MyTextTheme().smallBCN,
                                                      // )
                                                    ],
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                  const EdgeInsets.fromLTRB(
                                                      10, 5, 0, 0),
                                                  child: Row(
                                                    children: [
                                                      const Icon(
                                                        Icons.rotate_90_degrees_ccw,
                                                        color: Colors.blue,
                                                        size: 15,
                                                      ),
                                                      const SizedBox(
                                                        width: 8,
                                                      ),
                                                      // Text(
                                                      //   doctor.degree.toString(),
                                                      //   style:
                                                      //   MyTextTheme().smallBCN,
                                                      // )
                                                    ],
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                  const EdgeInsets.fromLTRB(
                                                      10, 5, 0, 0),
                                                  child: Row(
                                                    children: [
                                                      const Icon(
                                                        Icons.location_on_rounded,
                                                        color: Colors.blue,
                                                        size: 15,
                                                      ),
                                                      const SizedBox(
                                                        width: 8,
                                                      ),
                                                      // Text(
                                                      //   doctor.address.toString(),
                                                      //   style:
                                                      //   MyTextTheme().smallBCN,
                                                      // ),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(height: 10,),
                                                Wrap(
                                                    spacing: 10,
                                                    runSpacing:8,
                                                    direction: Axis.horizontal,
                                                    children:List.generate(modal.controller.weekDays.length, (index2) {
                                                      return InkWell(
                                                        onTap: () {
                                                          //   startBookingTime = DateFormat("HH:mm:ss").format(DateTime.now()).toString();
                                                          //   //print("####################"+modal.controller.doctorList[index]['sittingDays'].toString());
                                                          //   if(doctor.sittingDays.toString().contains(modal.controller.weekDays[index2].toString())){
                                                          //
                                                          //     App().navigate(context, TimeSlotView(degree:doctor.degree.toString() ,doctorId: doctor.id.toString(),drName:doctor.drName.toString(),
                                                          //       fees: double.parse(doctor.drFee.toString())+.0,
                                                          //       iSEraDoctor:doctor.isEraUser.toString(),
                                                          //       speciality:doctor.speciality.toString(),
                                                          //       timeSlots: doctor.sittingDays??[],
                                                          //       selectedDay:modal.controller.weekDays[index2].toString() ,));
                                                          //   }
                                                          //   else{
                                                          //     alertToast(context, "Slot not available");
                                                          //   }
                                                          // },
                                                        },
                                                        child: Material(
                                                          elevation: 1,borderRadius: BorderRadius.all(Radius.circular(4)),
                                                          child: Container(
                                                            height: 25,width: 40 ,
                                                            // decoration: BoxDecoration(
                                                            //     color:doctor.sittingDays!.contains(modal.controller.weekDays[index2].toString()) ? AppColor.orangeButtonColor : AppColor.greyLight.withOpacity(0.2),
                                                            //     borderRadius: const BorderRadius.all(Radius.circular(4)),
                                                            //     border: Border.all(color:  doctor.sittingDays.toString().contains( modal.controller.weekDays[index2].toString()) ? AppColor.transparent : AppColor.transparent)
                                                            // ),
                                                            child:
                                                            Padding(
                                                              padding: EdgeInsets.fromLTRB(3, 0, 3, 0),
                                                              child: Center(
                                                                child: Text(
                                                                  modal.controller.weekDays[index2].toString().substring(0,3),
                                                                  //day.toString().substring(0, 3),
                                                                  // style: TextStyle(
                                                                  //   color:doctor.sittingDays.toString().contains( modal.controller.weekDays[index2].toString()) ? Colors.white : AppColor.greyDark,
                                                                  // ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      );

                                                    }
                                                    )
                                                  // ListView.builder(
                                                  //     shrinkWrap: true,
                                                  //     physics: NeverScrollableScrollPhysics(),
                                                  //     scrollDirection: Axis.horizontal,
                                                  //     itemCount:modal.controller.weekDays.length,
                                                  //     itemBuilder: (BuildContext context, int index2) {
                                                  //       String
                                                  //           day =
                                                  //           (DateFormat.EEEE().format(DateTime.now().add(Duration(days: index2))).toString());
                                                  //       String
                                                  //           date =
                                                  //           (DateFormat('dd').format(DateTime.now().add(Duration(days: index2))).toString());
                                                  //       print("${modal.controller.popularDoctor[index]['sittingDays']}");
                                                  //       //String saveDate = '';
                                                  //       return Padding(
                                                  //         padding: const EdgeInsets.only(left: 5.0),
                                                  //         child: Container(
                                                  //           decoration: BoxDecoration(
                                                  //               color: modal.controller.popularDoctor[index]['sittingDays'].contains(modal.controller.weekDays[index2].toString()) ? Colors.blue : AppColor.white.withOpacity(0.2),
                                                  //               //borderRadius: const BorderRadius.all(Radius.circular(4)),
                                                  //               border: Border.all(color: AppColor.primaryColor)
                                                  //           ),
                                                  //           child:
                                                  //               Padding(
                                                  //             padding: EdgeInsets.fromLTRB(3, 0, 3, 0),
                                                  //             child: Center(
                                                  //               child: Text(
                                                  //                   modal.controller.weekDays[index2].toString().substring(0,3),
                                                  //                 //day.toString().substring(0, 3),
                                                  //                 style: TextStyle(
                                                  //                   color: modal.controller.popularDoctor[index]['sittingDays'].contains( modal.controller.weekDays[index2].toString()) ? Colors.white : AppColor.primaryColor,
                                                  //                 ),
                                                  //               ),
                                                  //             ),
                                                  //           ),
                                                  //         ),
                                                  //       );
                                                  //     }),
                                                ),
                                                //Text(doctor.sittingDays.toString().toString()),
                                                SizedBox(
                                                  height: 30,
                                                  child: Divider(
                                                    color: Colors.grey.shade400,
                                                    thickness: 1,
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                  const EdgeInsets.fromLTRB(
                                                      10, 0, 10, 0),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                    children: [
                                                      Text(
                                                        localization.getLocaleData.consultancyFee.toString(),
                                                        style:
                                                        MyTextTheme().mediumBCB,
                                                      ),
                                                      // Text(
                                                      //   '\u{20B9}  ' +
                                                      //       doctor.drFee.toString(),
                                                      //   style:
                                                      //   MyTextTheme().mediumPCB,
                                                      // ),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 20,
                                                  child: Divider(
                                                    color: Colors.grey.shade400,
                                                    thickness: 1,
                                                  ),
                                                ),
                                                // Padding(
                                                //   padding:
                                                //   const EdgeInsets.all(10.0),
                                                //   child: doctor.timeSlots!.isEmpty
                                                //       ? MyButton(
                                                //     title:
                                                //     localization.getLocaleData.slotNotAvailable.toString()
                                                //         .toUpperCase(),
                                                //     buttonRadius: 25,
                                                //     color: Colors.grey,
                                                //     onPress: () {
                                                //       alertToast(context,
                                                //           localization.getLocaleData.slotNotAvailable.toString());
                                                //     },
                                                //   )
                                                //       : MyButton(
                                                //     title: localization.getLocaleData.bookingAppointment.toString()
                                                //         .toUpperCase(),
                                                //     buttonRadius: 25,
                                                //     onPress: () async {
                                                //       await modal
                                                //           .timeSlot(doctor);
                                                //
                                                //       App().navigate(
                                                //           context,
                                                //           TimeSlotView(
                                                //             speciality: doctor
                                                //                 .speciality
                                                //                 .toString(),
                                                //             drName: doctor
                                                //                 .drName
                                                //                 .toString(),
                                                //             iSEraDoctor: doctor
                                                //                 .isEraUser
                                                //                 .toString(),
                                                //             doctorId: doctor
                                                //                 .id
                                                //                 .toString(),
                                                //             degree: doctor
                                                //                 .degree
                                                //                 .toString(),
                                                //             timeSlots: modal
                                                //                 .controller
                                                //                 .getTimeSlot,
                                                //             fees: doctor
                                                //                 .drFee ??
                                                //                 0.0,selectedDay:doctor.sittingDays![0].toString(),
                                                //           ));
                                                //     },
                                                //   ),
                                                // ),
                                              ],
                                            ),
                                          ),
                                        );
                                      }),
                                ),
                              ],
                            ),
                          ),
                        )
                    )],
                );
              }),
        ),
      ),
    );
  }
}
