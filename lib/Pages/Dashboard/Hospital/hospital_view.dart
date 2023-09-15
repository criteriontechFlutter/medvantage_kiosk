import 'package:cached_network_image/cached_network_image.dart';
import 'package:digi_doctor/AppManager/app_util.dart';
import 'package:digi_doctor/AppManager/my_text_theme.dart';
import 'package:digi_doctor/Pages/Specialities/SpecialistDoctors/DoctorProfile/doctor_profile_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../../AppManager/app_color.dart';
import '../../../AppManager/widgets/common_widgets.dart';
import '../../../AppManager/widgets/my_app_bar.dart';
import '../../../Localization/app_localization.dart';
import '../../Specialities/SpecialistDoctors/DoctorProfile/doctor_profile_modal.dart';
import '../DataModal/dashboard_data_modal.dart';
import 'DataModal/hospital_data_modal.dart';
import 'hospital_controller.dart';
import 'hospital_modal.dart';

class Hospital extends StatefulWidget {
  final TopClinicDataModal hospitalDetails;

  const Hospital({
    Key? key,
    required this.hospitalDetails,
  }) : super(key: key);

  @override
  _HospitalState createState() => _HospitalState();
}

class _HospitalState extends State<Hospital> {

  HospitalModal modal = HospitalModal();
  DoctorProfileModal doctorProfileModal=DoctorProfileModal();

  @override
  void initState() {
    get();
    super.initState();
  }

  get() async {
    modal.controller.updateHospitalId = widget.hospitalDetails.id as int;
    await modal.getHospitalClinicDetail(context);
  }

  //
  HospitalController controller = HospitalController();
  bool isSwitched = false;
  bool isSwitched2 = false;

  @override
  void dispose() {
    super.dispose();
    Get.delete<HospitalController>();
  }

  @override
  Widget build(BuildContext context) {
    ApplicationLocalizations localization=Provider.of<ApplicationLocalizations>(context,listen: true);
    return Container(
      color: AppColor.primaryColor,
      child: SafeArea(
        child: Scaffold(
          appBar:MyWidget().myAppBar(context, title: localization.getLocaleData.hospital.toString()),
          body: GetBuilder(
              init: HospitalController(),
              builder: (_) {
                return Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Center(
                    child: CommonWidgets().showNoData(
                      title: localization.getLocaleData.hospitalNotFound.toString(),
                      show: (modal.controller.getShowNoData &&
                          modal.controller.getClinicDetails.isEmpty),
                      loaderTitle: localization.getLocaleData.loadingHospitalList.toString(),
                      showLoader: (!modal.controller.getShowNoData &&
                          modal.controller.getClinicDetails.isEmpty),
                      child: ListView.builder(
                          itemCount: modal.controller.getClinicDetails.length,
                          itemBuilder: (BuildContext context, int index) {
                            ClinicDetailsDataModal hospitalData =
                                modal.controller.getClinicDetails.isEmpty
                                    ? ClinicDetailsDataModal(
                                        name: localization.getLocaleData.na.toString(),
                                        speciality: localization.getLocaleData.na.toString(),
                                        userMobileNo: localization.getLocaleData.na.toString(),
                                      )
                                    : modal.controller.getClinicDetails[0];
                            return CommonWidgets().shimmerEffect(
                              shimmer: modal.controller.getClinicDetails.isEmpty,
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(0, 15, 8, 5),
                                      child: Row(
                                        children: [
                                          SvgPicture.asset(
                                            'assets/hospital_buildings.svg',
                                            height: 20,
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          Expanded(
                                            child: Text(
                                              hospitalData.hospitalName.toString(),
                                              style: MyTextTheme().mediumBCB,
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(0,0,10,0),
                                            child: IconButton(
                                              onPressed: () async {
                                                await doctorProfileModal.sendSMSPatientToDoctor(context,hospitalData.userMobileNo.toString());
                                              },
                                              icon: Image.asset(
                                                'assets/sms.png',
                                                height: 25,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),


                                    Text(hospitalData.address.toString()),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.speaker_notes_rounded,
                                          size: 15,
                                          color: AppColor.orangeButtonColor,
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        Text(hospitalData.reviewCount.toString() +
                                            localization.getLocaleData.feedback.toString()),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    SizedBox(
                                      height: 220,
                                      child: ListView.separated(
                                        scrollDirection: Axis.horizontal,
                                        // itemCount:5,
                                        itemCount:
                                            modal.controller.getClinicDetails.length,
                                        itemBuilder: (BuildContext context, int index) {
                                          ClinicDetailsDataModal clinic =
                                              modal.controller.getClinicDetails.isEmpty
                                                  ? ClinicDetailsDataModal()
                                                  : hospitalData;
                                          return Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                height: 200,
                                                width:
                                                    MediaQuery.of(context).size.width /
                                                        1.06,
                                                decoration: BoxDecoration(
                                                  border: Border.all(color: AppColor.greyLight),
                                                    borderRadius:
                                                        BorderRadius.circular(10)),
                                                child: CachedNetworkImage(
                                                  imageUrl: widget
                                                      .hospitalDetails.profilePhotoPath
                                                      .toString()
                                                      .toString(),
                                                  errorWidget: (context, url, error) =>
                                                      Image.asset(
                                                        'assets/logo.png',
                                                      ),
                                                  fit: BoxFit.contain,
                                                ),
                                              ),
                                            ],
                                          );
                                        },
                                        separatorBuilder: (context, index) {
                                          return const SizedBox(
                                            width: 10,
                                          );
                                        },
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Icon(
                                          Icons.location_on,
                                          size: 15,
                                          color: AppColor.orangeButtonColor,
                                        ),
                                        const SizedBox(
                                          width: 8,
                                        ),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(modal.controller.getClinicDetails[0]
                                                  .address
                                                  .toString()),
                                              // Text(   widget.hospitalDetails.stateName.toString(),),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.phone,
                                          size: 15,
                                          color: AppColor.orangeButtonColor,
                                        ),
                                        const SizedBox(
                                          width: 8,
                                        ),
                                        Text(hospitalData.userMobileNo.toString())
                                      ],
                                    ),
                                    const SizedBox(height: 20),
                                    Text(
                                     localization.getLocaleData.overall.toString() ,
                                      style: MyTextTheme().mediumBCB,
                                    ),
                                    SizedBox(
                                      height: 60,
                                      child: ListView.separated(
                                        shrinkWrap: true,
                                        // physics: NeverScrollableScrollPhysics(),
                                        scrollDirection: Axis.horizontal,
                                        itemCount: modal.controller.getHomeGrid(context).length,
                                        itemBuilder: (BuildContext context, int index) {
                                          return Row(
                                            children: [
                                              Container(
                                                alignment: Alignment.center,
                                                height: 30,
                                                width: 120,
                                                decoration: BoxDecoration(
                                                    color: controller.getHomeGrid(context)[index]
                                                        ['color'],
                                                    borderRadius:
                                                        BorderRadius.circular(18)),
                                                child: InkWell(
                                                    onTap: () {

                                                      modal.onPressedOtpn(context);
                                                      modal.controller.updateDocList =
                                                          controller.getHomeGrid(context)[index]
                                                              ['sub_tittle'];
                                                    },
                                                    child: Center(
                                                      child: Text(
                                                        controller.getHomeGrid(context)[index]
                                                            ['sub_tittle'],
                                                        style: MyTextTheme().mediumWCB,
                                                      ),
                                                    )),
                                              )
                                            ],
                                          );
                                        },
                                        separatorBuilder: (context, index) {
                                          return const SizedBox(
                                            width: 10,
                                          );
                                        },
                                      ),
                                    ),
                                    Visibility(
                                      visible: modal.controller.getDocList == 'Doctors',
                                      child: ListView.builder(
                                          shrinkWrap: true,
                                          physics: const NeverScrollableScrollPhysics(),
                                          itemCount:
                                              modal.controller.getDoctorList.length,
                                          itemBuilder:
                                              (BuildContext context, int index) {
                                            DoctorListModal details =
                                                modal.controller.getDoctorList.isEmpty
                                                    ? DoctorListModal()
                                                    : modal.controller.getDoctorList[0];
                                            return InkWell(
                                              onTap: (){
                                                App().navigate(context, DoctorProfile(
                                                    // drName: details.name.toString(),
                                                    // speciality: details.speciality.toString(),
                                                    // degree: details.degree.toString(),
                                                    // address: details.address.toString(),
                                                    // noofPatients: '',
                                                    // yearOfExperience: details.yearOfExperience.toString(),
                                                    doctorId: details.id.toString(),
                                                    // iSEraDoctor: '',
                                                    // hospital: '',
                                                    // fees: double.parse(details.drFee.toString())
                                                )
                                                );
                                              },
                                              child: Card(
                                                child: Padding(
                                                  padding: const EdgeInsets.all(10.0),
                                                  child: Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.start,
                                                    children: [
                                                      Container(
                                                        height: 60,
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius.circular(
                                                                    20)),
                                                        child: CachedNetworkImage(
                                                          width: 45,
                                                          imageUrl: details
                                                              .profilePhotoPath
                                                              .toString(),
                                                          placeholder: (context, url) =>
                                                              Image.asset(
                                                                  'assets/noProfileImage.png'),
                                                          errorWidget:
                                                              (context, url, error) =>
                                                                  CircleAvatar(
                                                            radius: 22,
                                                            child: ClipOval(
                                                              child: Image.asset(
                                                                'assets/noProfileImage.png',
                                                                fit: BoxFit.cover,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        width: 20,
                                                      ),
                                                      Expanded(
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment.start,
                                                          children: [
                                                            Text(details.name.toString()),
                                                            const SizedBox(height: 5),
                                                            Text(details.speciality
                                                                .toString()),
                                                            const SizedBox(height: 5),
                                                            Container(
                                                              padding: const EdgeInsets
                                                                      .symmetric(
                                                                  horizontal: 10,
                                                                  vertical: 4),
                                                              decoration: BoxDecoration(
                                                                  color: AppColor
                                                                      .orangeButtonColor,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(15)),
                                                              child: Text(
                                                                localization.getLocaleData.viewProfile.toString(),
                                                                style: MyTextTheme()
                                                                    .mediumWCB,
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                      // Icon(
                                                      //   Icons.share,
                                                      //   color: AppColor.primaryColor,
                                                      // )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            );
                                          }),
                                    ),

                                    Visibility(
                                        visible:
                                            modal.controller.getDocList == 'Services',
                                        child: Padding(
                                          padding: const EdgeInsets.only(top: 100),
                                          child: Center(
                                            child: Text(localization.getLocaleData.alertToast!.comingSoon.toString()),
                                          ),
                                        )),

                                    Visibility(
                                        visible:
                                            modal.controller.getDocList == 'Speciality',
                                        child: Padding(
                                          padding: const EdgeInsets.only(top: 100),
                                          child: Center(
                                            child: Text(localization.getLocaleData.alertToast!.comingSoon.toString()),
                                          ),
                                        )),
                                    Visibility(
                                        visible:
                                            modal.controller.getDocList == 'Reviews',
                                        child: Padding(
                                          padding: const EdgeInsets.only(top: 100),
                                          child: Center(
                                            child: Text(localization.getLocaleData.alertToast!.comingSoon.toString()),
                                          ),
                                        )),
                                  ]),
                            );
                          }),
                    ),
                  ),
                );
              }),
        ),
      ),
    );
  }
}
