
import 'dart:io';
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:digi_doctor/Pages/Dashboard/MyFavoriteDoctorView/my_favorite_doctor_view.dart';
import 'package:digi_doctor/Pages/Dashboard/NearestHospital/nearesthospital_view.dart';
import 'package:digi_doctor/Pages/Dashboard/UpcomingAppointment/upcoming_appointment_view.dart';
import 'package:digi_doctor/Pages/MyAppointment/my_appointment_view.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import '../../../Localization/app_localization.dart';
import 'package:digi_doctor/AppManager/app_color.dart';
import 'package:digi_doctor/AppManager/my_text_theme.dart';
import 'package:digi_doctor/AppManager/user_data.dart';
import 'package:digi_doctor/AppManager/widgets/common_widgets.dart';
import 'package:digi_doctor/MapServices/map_modal.dart';
import 'package:digi_doctor/Pages/Dashboard/Clinics/top_clinics_view.dart';
import 'package:digi_doctor/Pages/Dashboard/dashboard_controller.dart';
import 'package:digi_doctor/Pages/Dashboard/dashboard_modal.dart';
import 'package:digi_doctor/Pages/Specialities/SpecialistDoctors/DoctorProfile/doctor_profile_view.dart';
import 'package:digi_doctor/Services/firebase_service/call_status_controller.dart';
import 'package:digi_doctor/services/firebase_service/firbase_calling_feature.dart';
import 'package:digi_doctor/AppManager/flutter_download_file.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart'; 
import '../../AppManager/alert_dialogue.dart';
import '../../AppManager/app_util.dart';
import '../../AppManager/check_for_update.dart';
import '../../AppManager/manage_response.dart';
import '../../AppManager/tab_responsive.dart';
import '../../Localization/language_change_widget.dart';
import '../Drawer/drawer.dart';
import 'AssociationDoctor/association_doctor_view.dart';
import 'BlogDetailPage/BlogDetails.dart';
import 'Common Classes/common_classes.dart';
import 'DataModal/dashboard_data_modal.dart';
import 'DataModal/doctor_details_data_modal.dart';
import 'Hospital/hospital_view.dart';
import 'SearchDoctorPage/search_doctor_view.dart';
import 'TrendingDiseases/trending_disease_view.dart';


class DashboardView extends StatefulWidget {
  const DashboardView({
    Key? key,
  }) : super(key: key);

  @override
  _DashboardViewState createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  int _currentPage = 0;

  final PageController _pageController = PageController(initialPage: 0);

  DashboardModal modal = DashboardModal();

  get() async {
    Position locationData = await MapModal().getCurrentLocation(context);
    await modal.getDashboardData(context, locationData);
    //await modal.getLocation(context);

  }

  @override
  void initState() {
    ApplicationLocalizations localization =
    Provider.of<ApplicationLocalizations>(context, listen: false);
    FirebaseMessaging.instance.getInitialMessage().then((event) async {
      callStatusC.updateCurrentCall = MyCall.initiated;
      if ((DateTime.parse(event!.data['time']).add(const Duration(seconds: 30)))
          .isAfter(DateTime.now())) {
        FireBaseCalling().pickUpDirectly(context, event);
      } else {
        alertToast(
            context, localization.getLocaleData.missedThisCall.toString());
      }
    });
    //FlutterDownloader.initialize();
    get();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Updater().checkVersion(context);
    });
    FlutterDownloadFiles().callInInitState(setState);

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
    IsolateNameServer.removePortNameMapping('downloader_send_port');
  }

  _onPageChanged(int index) {
    setState(() {
      _currentPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    ApplicationLocalizations localization =
        Provider.of<ApplicationLocalizations>(context, listen: true);
    return Container(
      color: AppColor.primaryColor,
      child: SafeArea(
        child: GetBuilder(
          init: DashboardController(),
          builder: (_) {
            return Scaffold(
              //backgroundColor: AppColor.lightBackground,
              key: scaffoldKey,
              drawer: const MyDrawer(),
              body: GetBuilder(
                  init: DashboardController(),
                  builder: (_) {
                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 2, horizontal: 10),
                          child: SizedBox(
                            height: 70,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                InkWell(
                                  onTap: () {
                                    scaffoldKey.currentState!.openDrawer();
                                  },
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 0, 15, 0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: AppColor.greyLight,
                                        boxShadow: [
                                          BoxShadow(
                                              blurRadius: 10,
                                              color: AppColor.greyDark,
                                              spreadRadius: 0.2)
                                        ],
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Center(
                                            child: CircleAvatar(
                                              radius: 20,
                                              backgroundImage: const AssetImage(
                                                  'assets/noProfileImage.png'),
                                              foregroundImage: NetworkImage(
                                                UserData()
                                                    .getUserProfilePhotoPath
                                                    .toString(),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: InkWell(
                                    onTap: () {
                                      App().navigate(
                                          context,
                                          const SearchDoctorView(
                                              isDoctorDemand: false));
                                    },
                                    child: TabResponsive().wrapInTab(
                                      context: context,
                                      child: Center(
                                        child: Container(
                                          height: 30,
                                          decoration: BoxDecoration(
                                            color: AppColor.white,
                                            borderRadius:
                                                const BorderRadius.all(
                                              Radius.circular(20),
                                            ),
                                            border: Border.all(
                                                color: AppColor.primaryColor,
                                                width: 2),
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 10.0),
                                                child: Text(
                                                  localization.getLocaleData
                                                      .searchDoctor
                                                      .toString(),
                                                  style:
                                                      MyTextTheme().mediumGCN,
                                                ),
                                              ),
                                              Container(
                                                decoration: BoxDecoration(
                                                    color:
                                                        AppColor.primaryColor,
                                                    borderRadius:
                                                        const BorderRadius.only(
                                                      topRight:
                                                          Radius.circular(10),
                                                      bottomRight:
                                                          Radius.circular(10),
                                                    )),
                                                child: Center(
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 5),
                                                    child: Icon(
                                                      Icons.search,
                                                      size: 20,
                                                      color: AppColor.white,
                                                    ),
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                InkWell(
                                  onTap: () {
                                    changeLanguage();
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Image.asset('assets/translate.png',height: 30,width: 35),
                                  ),
                                )
                                // const LocationName()
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Center(
                                        child: CachedNetworkImage(
                                          imageUrl: modal.controller
                                                  .getDashboardData.isEmpty
                                              ? ''
                                              : modal
                                                  .controller
                                                  .getDashboardData[0]
                                                  .topImage![0]['topImage']
                                                  .toString(),
                                          placeholder: (context, url) =>
                                              Image.asset('assets/logo.png'),
                                          errorWidget: (context, url, error) =>
                                              Image.asset('assets/logo.png'),
                                          height: 140,
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                            color: AppColor.white,
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(20))),
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              2, 8, 2, 8),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: List.generate(
                                              modal.controller
                                                  .getProblemList(context)
                                                  .length,
                                              (index) => TextButton(
                                                onPressed: () {
                                                  App().navigate(
                                                      context,
                                                      modal.controller
                                                              .getProblemList(
                                                                  context)[
                                                          index]['onPressed']);
                                                },
                                                style: CommonWidgets()
                                                    .myButtonStyle
                                                    .copyWith(
                                                      overlayColor:
                                                          MaterialStateProperty.all(modal
                                                                  .controller
                                                                  .getProblemList(
                                                                      context)[
                                                              index]['color']),
                                                    ),
                                                child: SizedBox(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      5,
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Container(
                                                        height: 65,
                                                        decoration: BoxDecoration(
                                                            color: modal
                                                                    .controller
                                                                    .getProblemList(
                                                                        context)[
                                                                index]['color'],
                                                            borderRadius:
                                                                const BorderRadius
                                                                        .all(
                                                                    Radius.circular(
                                                                        10))),
                                                        child: Center(
                                                          child:
                                                              SvgPicture.asset(
                                                            modal.controller
                                                                    .getProblemList(
                                                                        context)[
                                                                index]['image'],
                                                            semanticsLabel:
                                                                'Acme Logo',
                                                            height: 30,
                                                            width: 30,
                                                          ),
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        height: 10,
                                                      ),
                                                      Text(
                                                        modal.controller
                                                                .getProblemList(
                                                                    context)[
                                                            index]['title'],
                                                        style: MyTextTheme()
                                                            .smallBCB
                                                            .copyWith(
                                                                fontSize: 11),
                                                        textAlign:
                                                            TextAlign.center,
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      StaggeredGrid.count(
                                        crossAxisSpacing: 10.0,
                                        mainAxisSpacing: 0.0,
                                        crossAxisCount: 2,
                                        children: List.generate(
                                            modal.controller
                                                .getDashboardGrid(context)
                                                .length, (index) {
                                          return TextButton(
                                            style:
                                                CommonWidgets().myButtonStyle,
                                            onPressed: () {
                                              modal.controller
                                                  .getDashboardGrid(
                                                      context)[index]
                                                  .onTap(context);
                                            },
                                            child: SelectFeatures(
                                                features: modal.controller
                                                    .getDashboardGrid(
                                                        context)[index]),
                                          );
                                        }),
                                      ),
                                      Padding(
                                          padding: const EdgeInsets.only(left: 8.0,right: 8.0,top: 15),
                                          child: InkWell(
                                            onTap: (){
                                              App().navigate(context, const TrendingDiseasesView());
                                            },
                                            child: Stack(
                                              clipBehavior: Clip.none,
                                              children: [
                                                Container(
                                                  decoration: BoxDecoration(
                                                      border: Border.all(color: Colors.grey,width: 0.2),
                                                      borderRadius:
                                                      BorderRadius.circular(10),
                                                      color: AppColor.white,
                                                      boxShadow: const [BoxShadow(
                                                        color: Colors.grey,
                                                        blurRadius: 3.0,
                                                      )]
                                                  ),
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 25,
                                                        vertical: 15),
                                                    child: Row(
                                                      children: [
                                                        Text(
                                                          localization.getLocaleData.trendingDiseases.toString(),
                                                          style: MyTextTheme()
                                                              .mediumBCB.copyWith(fontSize: 17),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                Positioned(
                                                  right: 20,
                                                  top: 3,
                                                  child: SizedBox(
                                                    height: 45,
                                                    child: Lottie.asset(
                                                      'assets/trending.json',
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: InkWell(
                                          onTap: () async {
                                            if (Platform.isAndroid) {
                                              if (modal
                                                  .controller
                                                  .getDashboardData
                                                  .isNotEmpty) {
                                                FlutterDownloadFiles().download(
                                                    context,
                                                    'https://digidoctor.in/PostCovidCare.pdf');
                                              } else {
                                                alertToast(
                                                    context,
                                                    localization
                                                        .getLocaleData
                                                        .alertToast
                                                        ?.checkInternetConnection
                                                        .toString());
                                              }
                                            } else if (Platform.isIOS) {
                                              alertToast(
                                                  context,
                                                  localization.getLocaleData
                                                      .alertToast?.comingSoon
                                                      .toString());
                                            }
                                          },
                                          child: Stack(
                                            clipBehavior: Clip.none,
                                            children: [
                                              Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  color: AppColor.lightOrange,
                                                ),
                                                child: Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 25,
                                                      vertical: 8),
                                                  child: Row(
                                                    children: [
                                                      Text(
                                                        localization
                                                            .getLocaleData
                                                            .downloadPostCovidCareBooklet
                                                            .toString(),
                                                        style: MyTextTheme()
                                                            .mediumBCB,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                right: 20,
                                                top: -20,
                                                child: SizedBox(
                                                  height: 70,
                                                  child: Lottie.asset(
                                                    'assets/home_post_covid.json',
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 10,),
                                      Padding(
                                          padding: const EdgeInsets.only(left: 8.0,right: 8.0,bottom: 7),
                                          child: InkWell(
                                            onTap: (){
                                              App().navigate(context, const AssociationDoctorView());
                                            },
                                            child: Stack(
                                              clipBehavior: Clip.none,
                                              children: [
                                                Container(
                                                  decoration: BoxDecoration(
                                                      border: Border.all(color: Colors.grey,width: 0.2),
                                                      borderRadius:
                                                      BorderRadius.circular(10),
                                                      color: AppColor.white,
                                                      boxShadow: const [BoxShadow(
                                                        color: Colors.grey,
                                                        blurRadius: 3.0,
                                                      )]
                                                  ),
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 25,
                                                        vertical: 15),
                                                    child: Row(
                                                      children: [
                                                        Text(
                                                          localization.getLocaleData.associationDoctor.toString(),
                                                          style: MyTextTheme()
                                                              .mediumBCB.copyWith(fontSize: 17),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                Positioned(
                                                  right: 20,
                                                  top: 3,
                                                  child: SizedBox(
                                                    height: 45,
                                                    child: Lottie.asset(
                                                      'assets/associationDoctor.json',
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )
                                      ),
                                    ],
                                  ),
                                ),

                                modal.controller.upcomingAppointmentsData.length != 0?

                                Padding(
                                  padding: const EdgeInsets.fromLTRB(20, 10, 15, 5),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          localization.getLocaleData.upcomingAppointments.toString(),
                                          style: MyTextTheme().mediumBCB.copyWith(fontSize: 16),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          App().navigate(context, const MyAppointmentView());
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 15, vertical: 6),
                                          decoration: BoxDecoration(
                                              color: AppColor.primaryColor,
                                              borderRadius: BorderRadius.circular(20)),
                                          child: Text(
                                            localization.getLocaleData.viewAll.toString(),
                                            style: MyTextTheme().smallWCB,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ):const SizedBox(),

                                modal.controller.upcomingAppointmentsData.length != 0?

                                const UpcomingAppointmentView():const SizedBox(),

                                modal.controller.favouriteDoctorsData.length != 0?
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(20, 15, 15, 0),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          localization.getLocaleData.myFavoriteDoctors.toString(),
                                          style: MyTextTheme().mediumBCB.copyWith(fontSize: 18),
                                        ),
                                      ),
                                      // InkWell(
                                      //   onTap: () {
                                      //     // App().navigate(context, MyAppointmentView());
                                      //   },
                                      //   child: Container(
                                      //     padding: const EdgeInsets.symmetric(
                                      //         horizontal: 15, vertical: 6),
                                      //     decoration: BoxDecoration(
                                      //         color: AppColor.primaryColor,
                                      //         borderRadius: BorderRadius.circular(20)),
                                      //     child: Text(
                                      //       localization.getLocaleData.viewAll.toString(),
                                      //       style: MyTextTheme().smallWCB,
                                      //     ),
                                      //   ),
                                      // ),
                                    ],
                                  ),
                                ):const SizedBox(),
                                modal.controller.favouriteDoctorsData.length != 0?
                                const MyFavoriteDoctorView():const SizedBox(),

                                findTopClinics(),
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
                  }),
            );
          },
        ),
      ),
    );
  }

  findTopClinics() {
    ApplicationLocalizations localization =
        Provider.of<ApplicationLocalizations>(context, listen: false);
    final size = MediaQuery.of(context).size;

    return ManageResponse(
      retry: localization.getLocaleData.alertToast!.retry,
        response: modal.controller.getMyDashboardDataResponse,
        onPressRetry: () async {
          Position locationData = await MapModal().getCurrentLocation(context);
          await modal.getDashboardData(context, locationData);
          // await modal.getDoctorData(context);
        },
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 180,
                    child: Stack(
                      alignment: AlignmentDirectional.bottomCenter,
                      children: [
                        PageView.builder(
                          itemCount: modal.controller.bannerDetailsData.length,
                          scrollDirection: Axis.horizontal,
                          controller: _pageController,
                          onPageChanged: _onPageChanged,
                          itemBuilder: (context, index) => Center(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CachedNetworkImage(
                                imageUrl: modal.controller
                                    .bannerDetailsData[index].sliderImages
                                    .toString(),
                                placeholder: (context, url) => Image.asset(
                                  'assets/logo.png',
                                ),
                                errorWidget: (context, url, error) =>
                                    Image.asset(
                                  'assets/logo.png',
                                ),
                                height: 180,
                                fit: BoxFit.fitWidth,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 25,
                          child: DotsIndicator(
                            decorator: DotsDecorator(
                              activeColor: Colors.grey.shade200,
                            ),
                            dotsCount: modal.controller.slideList.length,
                            position: double.parse(_currentPage.toString()),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 5),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            localization.getLocaleData.findClinic.toString(),
                            style: MyTextTheme().mediumBCB.copyWith(fontSize: 18),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            App().navigate(
                                context,
                                const TopClinicsView());
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 6),
                            decoration: BoxDecoration(
                                color: AppColor.primaryColor,
                                borderRadius: BorderRadius.circular(20)),
                            child: Text(
                              localization.getLocaleData.viewAll.toString(),
                              style: MyTextTheme().smallWCB,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                      height: 170,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: modal.controller.findTopClinics.length,
                          itemBuilder: (BuildContext context, int index) {
                            TopClinicDataModal details =
                                modal.controller.findTopClinics[index];
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: InkWell(
                                onTap: () {
                                  App().navigate(
                                      context,
                                      Hospital(
                                        hospitalDetails: details,
                                      ));
                                },
                                child: Container(
                                  width: 120,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: AppColor.white),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      CachedNetworkImage(
                                        imageUrl:
                                            details.profilePhotoPath.toString(),
                                        placeholder: (context, url) =>
                                            Image.asset(
                                          'assets/logo.png',
                                        ),
                                        errorWidget: (context, url, error) =>
                                            Image.asset(
                                          'assets/logo.png',
                                        ),
                                        height: 60,
                                        fit: BoxFit.fitWidth,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(5),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              details.name.toString(),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: MyTextTheme().smallBCB,
                                            ),
                                            Text(
                                              details.address.toString(),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: MyTextTheme().smallBCN,
                                            ),
                                            Text(
                                              details.cityName.toString(),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: MyTextTheme().smallBCN,
                                            ),
                                            Text(
                                              details.stateName.toString(),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: MyTextTheme().smallBCN,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          })),
                ],
              ),
            ),
            googleHospital(),
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            localization.getLocaleData.doctorsInDemands
                                .toString(),
                            style: MyTextTheme().mediumBCB.copyWith(fontSize: 18),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            App().navigate(
                                context,
                                const SearchDoctorView(
                                  isDoctorDemand: true,
                                ));
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 6),
                            decoration: BoxDecoration(
                                color: AppColor.primaryColor,
                                borderRadius: BorderRadius.circular(20)),
                            child: Text(
                              localization.getLocaleData.viewAll.toString(),
                              style: MyTextTheme().smallWCB,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(
                    height:220,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: modal.controller.getDoctorDetails.length,
                        itemBuilder: (BuildContext context, int index) {
                          DoctorDetailsDataModal detail =
                          modal.controller.getDoctorDetails[index];
                          return Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: InkWell(
                              onTap: () {
                                App().navigate(
                                    context,
                                    DoctorProfile(
                                      doctorId: detail.id.toString(),
                                    ));
                              },
                              child: Container(
                                width: 160,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                        width: 0.7,
                                        color: AppColor.greyLight
                                    ),
                                    color: AppColor.white),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 10),
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        height: 100,
                                        width: 120,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(3),
                                            color: AppColor.lightBlue
                                        ),
                                        child: CachedNetworkImage(
                                          imageUrl: detail.profilePhotoPath
                                              .toString(),
                                          errorWidget: (context, url,
                                              error) =>
                                              SvgPicture.asset('assets/user_image.svg'),
                                          imageBuilder:
                                              (context, imageProvider) =>
                                              Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                  const BorderRadius.only(
                                                      topLeft:
                                                      Radius.circular(
                                                          10),
                                                      topRight:
                                                      Radius.circular(
                                                          10)),
                                                  image: DecorationImage(
                                                    image: imageProvider,
                                                    fit: BoxFit.fitWidth
                                                  ),
                                                ),
                                              ),
                                          placeholder: (context, url) => SvgPicture.asset("assets/user_image.svg")
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(5),
                                        child: Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              detail.drName.toString().capitalize!.toString(),
                                              maxLines: 1,
                                              textAlign: TextAlign.center,
                                              overflow: TextOverflow.ellipsis,
                                              style: MyTextTheme().mediumBCB,
                                            ),
                                            Text(
                                              detail.hospitalName.toString(),
                                              maxLines: 1,
                                              textAlign: TextAlign.center,
                                              overflow: TextOverflow.ellipsis,
                                              style: MyTextTheme().smallBCN,
                                            ),
                                            Text(
                                              detail.yearOfExperience
                                                  .toString(),
                                              maxLines: 1,
                                              textAlign: TextAlign.center,
                                              overflow: TextOverflow.ellipsis,
                                              style: MyTextTheme().smallBCN,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment.center,
                                              children: [
                                                Icon(
                                                  Icons.star,
                                                  color: AppColor
                                                      .orangeButtonColor,
                                                  size: 15,
                                                ),
                                                const SizedBox(
                                                  width: 5,
                                                ),
                                                Text(
                                                    "${detail.rating}  (${detail.review.toString()} reviews)",
                                                    style:
                                                    MyTextTheme().smallBCN),
                                              ],
                                            ),
                                          ],
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
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    localization.getLocaleData.ourBlogs.toString(),
                    style: MyTextTheme().mediumBCB.copyWith(fontSize: 18),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: modal.controller.blogDetail.length,
                    gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 600,
                      childAspectRatio: 6 / 4.5,
                      crossAxisSpacing: 20,
                    ),
                    itemBuilder: (BuildContext context, int index) {
                      BlogDetailDataModal detail =
                          modal.controller.blogDetail[index];
                      return GestureDetector(
                        onTap: () {
                          App().navigate(
                              context,
                              BlogDetails(
                                details: detail,
                              ));
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CachedNetworkImage(
                              imageUrl: detail.imagePath.toString(),
                              placeholder: (context, url) => Image.asset(
                                'assets/logo.png',
                              ),
                              errorWidget: (context, url, error) => Image.asset(
                                'assets/logo.png',
                              ),
                              height: 155,
                              fit: BoxFit.fill,
                              width: MediaQuery.of(context).size.width,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  color: AppColor.white,
                                  borderRadius: const BorderRadius.only(
                                      bottomRight: Radius.circular(15),
                                      bottomLeft: Radius.circular(15))),
                              child: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      detail.topic.toString(),
                                      style: MyTextTheme().mediumBCB,
                                    ),
                                    Text(
                                      detail.title.toString(),
                                      style: MyTextTheme().smallBCN,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.calendar_today_outlined,
                                          color: AppColor.greyLight,
                                          size: 15,
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Expanded(
                                            child: Text(
                                                detail.publishDate.toString(),
                                                style: MyTextTheme().smallGCN)),
                                        const Expanded(child: SizedBox()),
                                        Icon(
                                          Icons.thumb_up,
                                          color: AppColor.greyLight,
                                          size: 15,
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        Text(detail.totalLikes.toString(),
                                            style: MyTextTheme().smallGCN)
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),

                  Column(
                    children: [
                      Container(
                        color: Colors.grey.shade200,
                        child: Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Image.asset(
                                'assets/logo.png',
                                height: 30,
                                width: 100,
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Image.asset(
                                            'assets/DDLogo.png',
                                            height: 20,
                                            width: 20,
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            localization.getLocaleData.ourUsers
                                                .toString(),
                                            style: MyTextTheme().smallBCN,
                                          ),
                                          Text(
                                              modal.controller.countDetailsData
                                                  .userCount
                                                  .toString(),
                                              style: MyTextTheme().mediumBCB),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Column(
                                        children: [
                                          Image.asset(
                                            'assets/DDLogo.png',
                                            height: 20,
                                            width: 20,
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            localization.getLocaleData.ourDoctors
                                                .toString(),
                                            style: MyTextTheme().smallBCN,
                                          ),
                                          Text(
                                              modal.controller.countDetailsData
                                                  .doctorsCount
                                                  .toString(),
                                              style: MyTextTheme().mediumBCB),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Column(
                                        children: [
                                          Image.asset(
                                            'assets/DDLogo.png',
                                            height: 20,
                                            width: 20,
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            localization
                                                .getLocaleData.ourHospitals
                                                .toString(),
                                            style: MyTextTheme().smallBCN,
                                          ),
                                          Text(
                                              modal.controller.countDetailsData
                                                  .hospitalCount
                                                  .toString(),
                                              style: MyTextTheme().mediumBCB),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ));
  }

  changeLanguage() {
    ApplicationLocalizations localization =
    Provider.of<ApplicationLocalizations>(context, listen: false);
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
            title: Text(localization.getLocaleData.changeLanguage.toString()),
            contentPadding: const EdgeInsets.all(8),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            content: Stack(
              clipBehavior: Clip.none,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    LanguageChangeWidget(isPopScreen: true),
                  ],
                ),
                Positioned(
                  top: -70.h,
                  right: -15.w,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Align(
                      alignment: Alignment.topRight,
                      child: CircleAvatar(
                        radius: 18.0,
                        backgroundColor: AppColor.white,
                        child: const Icon(Icons.close, color: Colors.red),
                      ),
                    ),
                  ),
                ),
              ],
            ));
      },
    );
  }

  googleHospital(){
    ApplicationLocalizations localization =
    Provider.of<ApplicationLocalizations>(context, listen: false);
  return  Padding(
      padding: const EdgeInsets.all(5.0),
      child: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(8),color: AppColor.primaryColor),
        child: Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(localization.getLocaleData.findNearestHospitalAndClinic
                        .toString(),style: MyTextTheme().mediumWCB,),
                    const SizedBox(height: 10,),
                    InkWell(
                      onTap: () {
                        App().navigate(
                            context,
                            NearestHospital(title: localization.getLocaleData.nearestHospital
                                .toString(),
                            ));
                      },
                      child: Container(
                        height:30,
                        width: 85,
                        decoration: BoxDecoration(color:AppColor.orangeColorDark,borderRadius: BorderRadius.circular(15)),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 5),
                              child: SvgPicture.asset('assets/google-.svg'),
                            ),
                            Text(localization.getLocaleData.search
                                .toString(),style: MyTextTheme().smallWCB,)
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            SvgPicture.asset('assets/map-locator.svg'),
            const SizedBox(width: 10,)
          ],
        ),
      ),
    );
  }

}
