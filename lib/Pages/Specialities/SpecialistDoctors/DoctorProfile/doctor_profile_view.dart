

import 'package:cached_network_image/cached_network_image.dart';
import 'package:digi_doctor/AppManager/alert_dialogue.dart';
import 'package:digi_doctor/AppManager/app_color.dart';
import 'package:digi_doctor/AppManager/app_util.dart';
import 'package:digi_doctor/AppManager/my_text_theme.dart';
import 'package:digi_doctor/AppManager/widgets/my_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../../AppManager/widgets/common_widgets.dart';
import '../../../../Localization/app_localization.dart';
import '../TimeSlot/time_slot_view.dart';
import 'doctor_profile_controller.dart';
import 'doctor_profile_modal.dart';

class DoctorProfile extends StatefulWidget {
  final String doctorId;

  const DoctorProfile({
    Key? key,
    required this.doctorId,
  }) : super(key: key);

  @override
  State<DoctorProfile> createState() => _DoctorProfileState();
}

class _DoctorProfileState extends State<DoctorProfile> {
  DoctorProfileModal modal = DoctorProfileModal();

  get() async {
    modal.controller.updateDoctorId = widget.doctorId.toString();
   await modal.getDoctorProfile(context);
    modal.controller.updateIsFavoriteDoctor = modal.controller.getDoctorProfileData.isFavourite==1?true:false;
    print("##############"+modal.controller.getSittingDayList.toString());
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    get();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    Get.delete<DoctorProfileController>();
  }

  @override
  Widget build(BuildContext context) {
    ApplicationLocalizations localization=Provider.of<ApplicationLocalizations>(context,listen: true);
    return Container(
      color: AppColor.primaryColor,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
              leading: InkWell(
                child: const Icon(Icons.arrow_back,color: Colors.black),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              title: Text(localization.getLocaleData.doctorProfile.toString(),style:const TextStyle(color: Colors.black),),
              elevation: 0),
          body: GetBuilder(
              init: DoctorProfileController(),
              builder: (_) {
                return Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: CommonWidgets().shimmerEffect(shimmer: !modal.controller.getShowNoData,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.fromLTRB(10, 15, 8, 0),
                                child: Row(
                                  children: [
                                    Container(
                                      height: 35,
                                      width: 30,
                                      decoration: BoxDecoration(
                                          color: Colors.grey.shade400,
                                          borderRadius: BorderRadius.circular(10)),
                                      child: CachedNetworkImage(
                                          imageUrl:
                                              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTDqltw7wVNb8VwhdVSpWJoPEEVcTpflDB4nw&usqp=CAU',

                                          // progressIndicatorBuilder:
                                          //     (context, url, downloadProgress) =>
                                          //         CircularProgressIndicator(
                                          //             value: downloadProgress.progress),
                                          errorWidget: (context, url, error) =>
                                              Image.network(
                                                  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTDqltw7wVNb8VwhdVSpWJoPEEVcTpflDB4nw&usqp=CAU')
                                          // Icon(Icons.error),

                                          ),
                                    ),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(modal.controller.getDoctorProfileData.name.toString(),
                                                        style: MyTextTheme()
                                                            .mediumBCB),
                                                    const SizedBox(
                                                      height: 5,
                                                    ),
                                                    Text(
                                                        modal.controller.getDoctorProfileData.speciality.toString() +
                                                            ', ' +
                                                            modal.controller.getDoctorProfileData.degree
                                                                .toString(),
                                                        style: MyTextTheme()
                                                            .smallBCB
                                                            .copyWith(
                                                                color: Colors.grey
                                                                    .shade400)),
                                                  ],
                                                ),
                                              ),

                                              Padding(
                                                padding: const EdgeInsets.fromLTRB(0,0,10,0),
                                                child: IconButton(
                                                  onPressed: () async {
                                                    await modal.sendSMSPatientToDoctor(context,modal.controller.getSelectedNo.toString());
                                                  },
                                                  icon: Image.asset(
                                                    'assets/sms.png',
                                                    height: 25,
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding:  EdgeInsets.fromLTRB(0,0,10,0),
                                                child: IconButton(
                                                  onPressed: () async {
                                                    modal.controller.updateIsFavoriteDoctor = !modal.controller.getIsFavoriteDoctor;
                                                    await modal.addFavouriteDoctor(context,modal.controller.getDoctorProfileData.id.toString(),modal.controller.getIsFavoriteDoctor?1:0);
                                                  },
                                                  icon: SvgPicture.asset(
                                                    modal.controller.getIsFavoriteDoctor?  'assets/heart.svg':'assets/unFavourite.svg',
                                                    height: 25,
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Visibility(
                                visible:modal.controller.getDoctorProfileData.clinicName.toString()!="",
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 18.0,top: 10),
                                  child: Text(
                                    modal.controller.getDoctorProfileData.clinicName.toString(),
                                    style: MyTextTheme().smallBCB,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 15.0,top: 5),
                                child: Row(
                                  children: [
                                    const Icon(
                                      Icons.location_on_outlined,
                                      size: 15,
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      modal.controller.getDoctorProfileData.address.toString(),
                                      style: MyTextTheme().smallBCN,
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    color: AppColor.buttonColor,
                                    borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(20),
                                        topRight: Radius.circular(20))),
                                child: Padding(
                                  padding: const EdgeInsets.fromLTRB(5, 12, 5, 12),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Expanded(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            const SizedBox(
                                              width: 20,
                                            ),
                                            CircleAvatar(
                                              radius: 20,
                                              backgroundColor:
                                                  Colors.amber.shade400,
                                              child: const Icon(
                                                Icons.people,
                                                color: Colors.white,
                                                size: 20,
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Expanded(
                                              child: Text(
                                                modal.controller.getDoctorProfileData.noofPatients.toString() +
                                                    localization.getLocaleData.patient.toString(),
                                                style: MyTextTheme()
                                                    .mediumBCB
                                                    .copyWith(
                                                        color: AppColor.white),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            CircleAvatar(
                                              radius: 20,
                                              backgroundColor:
                                                  Colors.amber.shade400,
                                              child: const Icon(
                                                Icons.cases_rounded,
                                                color: Colors.white,
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Expanded(
                                              child: Text(
                                                modal.controller.getDoctorProfileData.yearOfExperience.toString(),
                                                style: MyTextTheme()
                                                    .mediumBCB
                                                    .copyWith(
                                                        color: AppColor.white),
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 5,
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      localization.getLocaleData.timing.toString(),
                                      style: MyTextTheme().mediumBCB,
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 10),
                                // child: CommonWidgets().showNoData(
                                //   show: (modal.controller.getShowNoData &&
                                //       modal.controller.getSittingDayList.isEmpty),
                                //   title: localization.getLocaleData.slotDataNotAvailable.toString(),
                                //   loaderTitle: localization.getLocaleData.loadingSlotData.toString(),
                                //   showLoader: (!modal.controller.getShowNoData &&
                                //       modal.controller.getSittingDayList.isEmpty),
                                  child:ListView.builder(
                                    shrinkWrap: true,
                                    physics: const NeverScrollableScrollPhysics(),
                                    itemCount: modal.controller.getSittingDayList.length,
                                    itemBuilder: (BuildContext context, int index) {
                                      var daysName=modal.controller.getSittingDayList[index];
                                      var timeDetails=   modal.controller.getProfileList(daysName);
                                      return Column(
                                       crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          const SizedBox(height: 5,),
                                          Text(daysName.toString(),style: MyTextTheme().mediumBCN),

                                          ListView.builder(
                                            shrinkWrap: true,
                                            physics: const NeverScrollableScrollPhysics(),
                                            itemCount: timeDetails.length,
                                            itemBuilder: (BuildContext context, int index2) {
                                              var timeData=timeDetails[index2];
                                              return Row(
                                                children: [
                                                  Text(timeData.timeFrom.toString()+" - ",style: MyTextTheme().mediumGCN),
                                                  Text(timeData.timeTo.toString(),style: MyTextTheme().mediumGCN),

                                                ],
                                              );
                                            }, )
                                        ],
                                      );
                                    }, )
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Visibility(
                      visible: modal.controller.getShowNoData &&
                          modal.controller.getSittingDayList.isNotEmpty,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: MyButton(
                          title: localization.getLocaleData.bookAppointment.toString(),
                          buttonRadius: 25,
                          onPress: () {
                            startBookingTime = DateFormat("HH:mm:ss").format(DateTime.now()).toString();
                            print(startBookingTime);
                            App().navigate(
                                context,
                                TimeSlotView(
                                   degree: modal.controller.getDoctorProfileData.degree.toString(),
                                   speciality: modal.controller.getDoctorProfileData.speciality.toString(),
                                   drName: modal.controller.getDoctorProfileData.name.toString(),
                                  doctorId: widget.doctorId.toString(),
                                   iSEraDoctor: modal.controller.getDoctorProfileData.isEraUser.toString(),
                                  timeSlots: modal.controller.getSortDaysList,
                                  fees: double.parse(modal.controller.getDoctorProfileData.drFee.toString()),
                                  selectedDay: modal.controller.SittingDayList.isEmpty?'':modal.controller.getSittingDayList[0].toString().substring(0,3),
                                ));
                          },
                        ),
                      ),
                    ),
                    Visibility(
                      visible: modal.controller.getShowNoData &&
                          modal.controller.getSittingDayList.isEmpty,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: MyButton(
                          title: localization.getLocaleData.slotNotAvailable.toString().toUpperCase(),
                          buttonRadius: 25,
                          color: Colors.grey,
                          onPress: () {
                            alertToast(context, localization.getLocaleData.slotNotAvailable.toString());
                          },
                        ),
                      ),
                    )
                  ],
                );
              }),
        ),
      ),
    );
  }
}
