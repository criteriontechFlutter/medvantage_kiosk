import 'package:cached_network_image/cached_network_image.dart';
import 'package:digi_doctor/AppManager/alert_dialogue.dart';
import 'package:digi_doctor/AppManager/widgets/customInkWell.dart';
import 'package:digi_doctor/Pages/Dashboard/SearchDoctorPage/search_doctor_controller.dart';
import 'package:digi_doctor/Pages/Dashboard/SearchDoctorPage/search_doctor_modal.dart';
import 'package:digi_doctor/Pages/Dashboard/dashboard_modal.dart';
import 'package:digi_doctor/Pages/Specialities/SpecialistDoctors/DoctorProfile/doctor_profile_view.dart';
import 'package:digi_doctor/Pages/Specialities/SpecialistDoctors/TimeSlot/time_slot_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';


import '../../../AppManager/app_color.dart';
import '../../../AppManager/app_util.dart';
import '../../../AppManager/my_text_theme.dart';
import '../../../AppManager/tab_responsive.dart';
import '../../../AppManager/widgets/common_widgets.dart';
import '../../../AppManager/widgets/my_button.dart';
import '../../../Localization/app_localization.dart';
import '../DataModal/doctor_details_data_modal.dart';

class SearchDoctorView extends StatefulWidget {
  final bool isDoctorDemand;

  const SearchDoctorView({
    Key? key,
    required this.isDoctorDemand,
  }) : super(key: key);

  @override
  State<SearchDoctorView> createState() => _SearchDoctorViewState();
}

class _SearchDoctorViewState extends State<SearchDoctorView> {
  SearchDoctorModal modal = SearchDoctorModal();
  DashboardModal dashboardModal = DashboardModal();

  get() async {
    if (widget.isDoctorDemand) {
      modal.controller.allDoctor = dashboardModal.controller.doctorDetails;
    } else {
      await modal.getDoctorProfileBySpeciality(context);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    get();
    modal.controller.searchC.value.clear();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    Get.delete<SearchDoctorController>();
  }

  @override
  Widget build(BuildContext context) {
    ApplicationLocalizations localization=Provider.of<ApplicationLocalizations>(context,listen: true);

    return Container(
      color: AppColor.primaryColor,
      child: SafeArea(
        child: Scaffold(
          body: GetBuilder(
              init: SearchDoctorController(),
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
                                    Text(localization.getLocaleData.searchDoctor.toString(),
                                        style: MyTextTheme().largeBCB),
                                  ],
                                ),
                              ),
                              const LocationName()
                            ],
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          TabResponsive().wrapInTab(
                            context: context,
                            child: SizedBox(
                              height: 40,
                              child: TextFormField(
                                controller: modal.controller.searchC.value,
                                onChanged: (val) {
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.end,
                                      children: [
                                        VerticalDivider(
                                          indent: 6,
                                          endIndent: 6,
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
                                  hintStyle: TextStyle(
                                      color: AppColor.greyLight,
                                      fontSize: 18),
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
                          const SizedBox(
                            height: 5,
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                        child: Center(
                      child: CommonWidgets().showNoData(
                        title: localization.getLocaleData.doctorListNotFound.toString(),
                        show: (modal.controller.getShowNoData &&
                            modal.controller.getAllDoctor.isEmpty),
                        loaderTitle: localization.getLocaleData.loading.toString(),
                        showLoader: (!modal.controller.getShowNoData &&
                            modal.controller.getAllDoctor.isEmpty),
                        child: ListView(
                          physics: const BouncingScrollPhysics(
                              parent: AlwaysScrollableScrollPhysics()),
                          children: [
                            StaggeredGrid.count(
                              crossAxisSpacing: 10.0,
                              mainAxisSpacing: 0.0,
                              crossAxisCount:
                                  MediaQuery.of(context).size.width > 600
                                      ? 2
                                      : 1,
                              children: List.generate(
                                  modal.controller.getAllDoctor.length,
                                  (index) {
                                DoctorDetailsDataModal doctor =
                                    modal.controller.getAllDoctor[index];
                                return Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: CustomInkwell(
                                    elevation: 3,borderRadius: 10,
                                    onPress: (){
                                      App().navigate(
                                          context,
                                          DoctorProfile(
                                            doctorId: doctor.id.toString(),

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
                                                child: CachedNetworkImage(
                                                    imageUrl: doctor
                                                        .profilePhotoPath
                                                        .toString(),
                                                    errorWidget: (context,
                                                            url, error) =>
                                                        Image.asset(
                                                            "assets/doctorSign.png")
                                                    // Icon(Icons.error),
                                                    ),
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
                                                      doctor.drName
                                                          .toString(),
                                                      style: MyTextTheme()
                                                          .mediumBCB,
                                                    ),
                                                    Text(
                                                      doctor.specialityName
                                                              .toString() +
                                                          " ," +
                                                          doctor
                                                              .yearOfExperience
                                                              .toString(),
                                                      style: MyTextTheme()
                                                          .smallBCN,
                                                    ),
                                                    Text(
                                                      doctor.hospitalName
                                                          .toString(),
                                                      style: MyTextTheme()
                                                          .smallPCN,
                                                    )
                                                  ],
                                                ),
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  alertToast(context,
                                                    localization.getLocaleData.featureWillAvailableSoon.toString(),);
                                                },
                                                child: InkWell(
                                                  onTap: () {
                                                    print(doctor.yearOfExperience);
                                                    Share.share(

                                                          " Hi there!! \n I found a great Doctor " +
                                                            doctor.drName
                                                                .toString() +
                                                            " having " +
                                                            doctor
                                                                .yearOfExperience
                                                                .toString() +
                                                            " in " +
                                                            doctor
                                                                .specialityName
                                                                .toString() +
                                                            " visit Doctor's profile " +
                                                                "http://digiDoctor.com/${doctor.id}",
                                                      //'http://theorganicdelight.com/$heroTag-$productCode-$productId-$productVarient-$PageName',
                                                      subject:  'Doctor Profile',
                                                    );
                                                  },
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets
                                                            .all(8.0),
                                                    child: Icon(
                                                      Icons.share,
                                                      color: AppColor
                                                          .primaryColor,
                                                    ),
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.fromLTRB(
                                                  10, 10, 0, 5),
                                          child: Row(
                                            children: [
                                              Icon(
                                                Icons.people_outline,
                                                color:
                                                    AppColor.primaryColor,
                                                size: 15,
                                              ),
                                              const SizedBox(
                                                width: 8,
                                              ),
                                              Text(
                                                doctor.noOfpatients
                                                        .toString() +
                                                  localization.getLocaleData.patients.toString(),
                                                style:
                                                    MyTextTheme().smallBCN,
                                              )
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.fromLTRB(
                                                  10, 5, 0, 5),
                                          child: Row(
                                            children: [
                                              SvgPicture.asset(
                                                'assets/degree_icon.svg',
                                                height: 14,
                                                color:
                                                    AppColor.primaryColor,
                                              ),
                                              const SizedBox(
                                                width: 8,
                                              ),
                                              Expanded(
                                                child: Text(
                                                  doctor.degree.toString(),
                                                  style:
                                                      MyTextTheme().smallBCN,
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.fromLTRB(
                                                  10, 5, 0, 0),
                                          child: Row(
                                            children: [
                                              Icon(
                                                Icons.location_on_rounded,
                                                color:
                                                    AppColor.primaryColor,
                                                size: 15,
                                              ),
                                              const SizedBox(
                                                width: 8,
                                              ),
                                              Text(
                                                doctor.address.toString(),
                                                style:
                                                    MyTextTheme().smallBCN,
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(height: 10,),
                                        Wrap(
                                            spacing: 10,
                                            runSpacing:8,
                                            direction: Axis.horizontal,
                                            children:List.generate(modal.controller.weekDays.length, (index2) {
                                              return InkWell(
                                                onTap: (){
                                                  startBookingTime = DateFormat("HH:mm:ss").format(DateTime.now()).toString();
                                                  print("-------------"+startBookingTime);
                                                  if(doctor.sittingDays.toString().contains(modal.controller.weekDays[index2].toString())){
                                                    //print(modal.controller.popularDoctor[index]['drFee']);
                                                   // print(modal.controller.weekDays[index2].toString());
                                                    App().navigate(context, TimeSlotView(degree:doctor.degree.toString() ,doctorId:doctor.id.toString(),
                                                      drName:doctor.drName.toString(),
                                                      fees: double.parse(doctor.drFee.toString())+.0,
                                                      iSEraDoctor:doctor.isEraUser.toString(),
                                                      speciality:doctor.specialityName.toString()
                                                      ,timeSlots:doctor.sittingDays??[],selectedDay:modal.controller.weekDays[index2].toString() ,));
                                                  }
                                                  else{
                                                    alertToast(context, "Slot not available");
                                                  }

                                                },
                                                child: Material(
                                                  elevation: 1,borderRadius:const BorderRadius.all(Radius.circular(4)),
                                                  child: Container(
                                                    height: 25,width: 40 ,
                                                    decoration: BoxDecoration(
                                                        color: doctor.sittingDays.toString().contains(modal.controller.weekDays[index2].toString()) ? AppColor.orangeButtonColor : AppColor.greyLight.withOpacity(0.2),
                                                        borderRadius: const BorderRadius.all(Radius.circular(4)),
                                                        border: Border.all(color: doctor.sittingDays.toString().contains( modal.controller.weekDays[index2].toString()) ? AppColor.transparent : AppColor.transparent)
                                                    ),
                                                    child:
                                                    Padding(
                                                      padding: const EdgeInsets.fromLTRB(3, 0, 3, 0),
                                                      child: Center(
                                                        child: Text(
                                                          modal.controller.weekDays[index2].toString().substring(0,3),
                                                          //day.toString().substring(0, 3),
                                                          style: TextStyle(
                                                            color: doctor.sittingDays.toString().contains( modal.controller.weekDays[index2].toString()) ? Colors.white : AppColor.greyDark,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              );

                                            }
                                            )

                                        ),
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
                                                localization.getLocaleData.consultationFee.toString(),
                                                style:
                                                    MyTextTheme().mediumBCB,
                                              ),
                                              const Spacer(),
                                              Text(
                                                '\u{20B9}  ',
                                                style: MyTextTheme()
                                                    .largeSCB
                                                    .copyWith(
                                                        color:
                                                            AppColor.green),
                                              ),
                                              Text(
                                                doctor.drFee.toString(),
                                                style:
                                                    MyTextTheme().mediumBCB,
                                              ),
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
                                        const SizedBox(),
                                        Padding(
                                          padding:
                                              const EdgeInsets.all(10.0),
                                          child: doctor.slotDetails!.isEmpty
                                              ? MyButton(
                                                  title:localization.getLocaleData.slotNotAvailable.toString(),
                                                  buttonRadius: 25,
                                                  color: Colors.grey,
                                                  onPress: () {
                                                    alertToast(context,
                                                      localization.getLocaleData.slotNotAvailable.toString(),);
                                                  },
                                                )
                                              : MyButton(
                                                  title: localization.getLocaleData.bookAppointment.toString(),
                                                  buttonRadius: 25,
                                                  onPress: () async {
                                                    await modal
                                                        .onPressedBookAppointment(
                                                            index);
                                                    App().navigate(
                                                        context,
                                                        TimeSlotView(
                                                          doctorId: doctor
                                                              .id
                                                              .toString(),
                                                          iSEraDoctor: doctor
                                                              .isEraUser
                                                              .toString(),
                                                          drName: doctor
                                                              .drName
                                                              .toString(),
                                                          speciality: doctor
                                                              .specialityName
                                                              .toString(),
                                                          degree: doctor
                                                              .degree
                                                              .toString(),
                                                          timeSlots: modal
                                                              .controller
                                                              .tempSlots,
                                                          fees: doctor
                                                                  .drFee ??
                                                              0.0,
                                                          selectedDay: doctor.sittingDays![0].toString(),
                                                        ));
                                                    // print( '------------------------'+doctor.slotDetails.toString());
                                                  }),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }),
                            ),
                          ],
                        ),
                      ),
                    ))
                  ],
                );
              }),
        ),
      ),
    );
  }
}
