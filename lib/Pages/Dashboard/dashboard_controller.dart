import 'package:digi_doctor/Pages/Dashboard/Modules/organDialogView.dart';
import 'package:digi_doctor/Pages/InvestigationHistory/AddInvestigation/add_investigation_view.dart';
import 'package:digi_doctor/Pages/MyAppointment/MyAppointmentDataModal/my_appointment_data_modal.dart';
import 'package:get/get.dart';
import '../../../Localization/app_localization.dart';
import 'package:digi_doctor/AppManager/app_color.dart';
import 'package:digi_doctor/AppManager/app_util.dart';
import 'package:digi_doctor/Pages/Specialities/top_specialities_view.dart';
import 'package:digi_doctor/Pages/VitalPage/Add%20Vitals/add_vitals_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../AppManager/alert_dialogue.dart';
import '../../AppManager/api_response.dart';

import '../../AppManager/my_text_theme.dart';
import '../NewLabTest/lab_test_navigation_view.dart';
import '../Supplement_Intake/supplement_intake_view.dart';
import '../SymptomTracker/symptom_tracker_view.dart';
import '../VitalPage/vital_view.dart';
import '../home_isolation/home_isolation_dashboard_view.dart';
import '../profile/AllowPrivacyDoctor/allowPrivacyDoctorView.dart';
import 'Cervical/cervical_startup_view.dart';
import 'Common Classes/common_classes.dart';
import 'DataModal/blog_details_data_modal.dart';
import 'DataModal/count_details_data_modal.dart';
import 'DataModal/dashboard_data_modal.dart';
import 'DataModal/doctor_details_data_modal.dart';
import 'DataModal/menu_data_modal.dart';

class DashboardController extends GetxController {


  Rx<TextEditingController> searchC = TextEditingController().obs;

  RxBool showNoData = false.obs;

  bool get getShowNoData => (showNoData.value);

  set updateShowNoData(bool val) {
    showNoData.value = val;
    update();
  }

  RxBool showNoMenuData = false.obs;

  bool get getShowNoMenuData => (showNoMenuData.value);

  set updateShowNoMenuData(bool val) {
    showNoMenuData.value = val;
    update();
  }


  final slideList = [
    Slide(imageUrl: "assets/Rectangle 11.png", imageText: 'abc'),
    Slide(imageUrl: "assets/Rectangle 11.png", imageText: 'abc'),
  ];

  final numbers1 = [

    NumbersList1(text: 'vitamins and Supplements'),
    NumbersList1(text: 'vitamins and Supplements'),
    NumbersList1(text: 'vitamins and Supplements'),
    NumbersList1(text: 'vitamins and Supplements'),
    NumbersList1(text: 'vitamins and Supplements'),
    NumbersList1(text: 'vitamins and Supplements'),
  ];


  getDashboardGrid(context) {
    ApplicationLocalizations localization = Provider.of<
        ApplicationLocalizations>(context, listen: false);

    return [
      Features(
          text: localization.getLocaleData.findDoctorsBy.toString(),
          text2: localization.getLocaleData.specialities.toString(),
          colorOfCard: AppColor.darkOrange,
          imgUrl: 'assets/doctor_home.png',
          onTap: (context) {
            Get.to(() =>  TopSpecialitiesView());
            //App().navigate(context, const TopSpecialitiesView(),);
          }),
      Features(
          text: localization.getLocaleData.findDoctorsBy.toString(),
          text2: localization.getLocaleData.symptoms.toString(),
          colorOfCard: AppColor.green,
          imgUrl: 'assets/cough_home.png',
          onTap: (context) {
            organAlertView(context);
          }),

      Features(
          text: localization.getLocaleData.lab.toString(),
          text2: localization.getLocaleData.tests.toString(),
          colorOfCard: AppColor.primaryColorLight,
          imgUrl: 'assets/flask_home.png',
          onTap: (context) {
            AlertDialogue().show(context,
                secondButtonName: localization.getLocaleData.alertToast!.cancel,
                showCancelButton: true,
                newWidget: [
                  Column(
                    children: [
                      const SizedBox(height: 20,),
                      InkWell(
                        onTap: () {
                          alertToast(context,
                              localization.getLocaleData.alertToast!
                                  .comingSoon);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                const Icon(
                                    Icons.assignment_turned_in, color: Colors
                                    .black54, size: 16),
                                const SizedBox(width: 8,),
                                Text(localization.getLocaleData.bookATest
                                    .toString(), style: MyTextTheme()
                                    .mediumBCB),
                              ],
                            ),
                            Icon(Icons.arrow_forward_ios_rounded, size: 13,
                                color: AppColor.greyDark)
                          ],
                        ),
                      ),
                      const SizedBox(height: 20,),
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                          App().navigate(context,
                              const LabTestNavigationView(isShowAppBar: true));
                        },

                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                const Icon(Icons.file_copy, color: Colors
                                    .black54, size: 16),
                                const SizedBox(width: 8,),
                                Text(localization.getLocaleData.viewReports
                                    .toString(), style: MyTextTheme()
                                    .mediumBCB),
                              ],
                            ),
                            Icon(Icons.arrow_forward_ios_rounded, size: 13,
                                color: AppColor.greyDark)
                          ],
                        ),
                      ),
                      const SizedBox(height: 20,),
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                          Get.to(() => const AddInvestigationView());
                        },

                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                const Icon(Icons.add_box, color: Colors.black54,
                                    size: 16),
                                const SizedBox(width: 8,),
                                Text(localization.getLocaleData.addInvestigation
                                    .toString(), style: MyTextTheme()
                                    .mediumBCB),
                              ],
                            ),
                            Icon(Icons.arrow_forward_ios_rounded, size: 13,
                                color: AppColor.greyDark)
                          ],
                        ),
                      ),
                      const SizedBox(height: 20,),
                    ],
                  )
                ]);
            //App().navigate(context, LabTest());
            //alertToast(context, localization.getLocaleData.alertToast!.comingSoon);
          }),

      Features(
          text: localization.getLocaleData.digi.toString(),
          text2: localization.getLocaleData.pharmacy.toString(),
          colorOfCard: AppColor.orangeButtonColor,
          imgUrl: 'assets/medicine_home.png',
          onTap: (context) {
            App().navigate(context, const AllowPrivacyDoctorView());
             //App().navigate(context, const CervicalStartUpView());
            // alertToast(
            //     context, localization.getLocaleData.alertToast!.comingSoon);
          }),
    ];
  }


  getProblemList(context) {
    ApplicationLocalizations localization = Provider.of<
        ApplicationLocalizations>(context, listen: false);

    return [
      {
        'title': localization.getLocaleData.homeIsolation.toString(),
        'image': 'assets/isolation.svg',
        'color': AppColor.lightPurple,
        'onPressed': const HomeIsolationDashboardView()
      },
      {
        'title': localization.getLocaleData.supplementIntake.toString(),
        'image': 'assets/pills-_1_.svg',
        'color': AppColor.lightPink,
        'onPressed': const SupplementIntake()
      },
      {
        'title': localization.getLocaleData.symptomTracker.toString(),
        'image': 'assets/cough.svg',
        'color': AppColor.lightGreen2,
        'onPressed': const SymptomTrackerView()
      },
      {
        'title': localization.getLocaleData.vitalHistory.toString(),
        'image': 'assets/vital-signs.svg',
        'color': AppColor.veryLightYellow,
        'onPressed': const VitalView()
      },
    ];
  }


  List dashboardData = [].obs;
  List topClinic = [].obs;
  List blogDetails = [].obs;
  List countDetails = [].obs;
  List doctorDetails = [].obs;


  List tempSlots = [].obs;


  List<BlogDetailsDataModal> get getBlogDetails =>
      List<BlogDetailsDataModal>.from(
          blogDetails.map((element) => BlogDetailsDataModal.fromJson(element))
      );

  List<DoctorDetailsDataModal> get getDoctorDetails =>
      List<DoctorDetailsDataModal>.from(
          doctorDetails.map((element) =>
              DoctorDetailsDataModal.fromJson(element)));


  List<CountDetailsDataModal> get getCountDetails =>
      List<CountDetailsDataModal>.from(
          countDetails.map((element) =>
              CountDetailsDataModal.fromJson(element)));

  List<DashboardDataModal> get getDashboardData =>
      List<DashboardDataModal>.from(
          dashboardData.map((element) => DashboardDataModal.fromJson(element))
      );

  set updateDashboardData(List val) {
    dashboardData = val;
    topClinic = val[0]['topClinics'];
    blogDetails = val[0]['blogDetails'];
    countDetails = val[0]['countDetails'];
    doctorDetails = val[0]['doctorDetails'];
    update();
  }

  RxString location = ''.obs;

  get getLocation => location.isEmpty ? 'Unknown,Location' : location;

  set updateLocation(String val) {
    location.value = val;
    update();
  }

  List allDoctor = [].obs;

  List<DoctorDetailsDataModal> get getAllDashboardDoctor =>
      List<DoctorDetailsDataModal>.from(
          allDoctor.map((element) => DoctorDetailsDataModal.fromJson(element)));


  set updateAllDoctor(List val) {
    allDoctor = val;
    update();
  }


  List menuList = [].obs;

  List<MenuDataModal> get getMenuList =>
      List<MenuDataModal>.from(
          menuList.map((element) => MenuDataModal.fromJson(element)));


  set updateMenuList(List val) {
    menuList = val;
    print('nnnnnaaaaaaaaaaa${val.length}');
    print('nnnnnaaaaaaaaaaa${getMenuList.length}');
    update();
  }


  List<TopClinicDataModal> findTopClinics = [];
  List<BlogDetailDataModal> blogDetail = [];
  List<BannerDetails> bannerDetailsData = [];
  List<MyAppointmentDataModal> upcomingAppointmentsData = [];
  List<FavouriteDoctorsModal> favouriteDoctorsData = [];
  CountDetails countDetailsData = CountDetails();


  ApiResponse apiResponse = ApiResponse.initial('Empty data',);


  ApiResponse get getMyDashboardDataResponse {
    return apiResponse;
  }

  set updateApiResponse(ApiResponse val) {
    apiResponse = val;
    update();
  }


  set updateMyDashboardData(List<DashboardDataModal> val) {
    findTopClinics = val[0].topClinics ?? [];
    blogDetail = val[0].blogDetails ?? [];
    bannerDetailsData = val[0].bannerDetails ?? [];
    countDetailsData = val[0].countDetails![0];
    upcomingAppointmentsData = val[0].upcomingAppointments ?? [];
    favouriteDoctorsData = val[0].favouriteDoctors ?? [];
    update();
  }
//this is used to add fav doctor
  void updateFavoriteDoctor(val) {
    favouriteDoctorsData.add(FavouriteDoctorsModal(
      hospitalName: val['hospitalName'],
      id: val['id'].toString(),
      name: val['drName'],
      profilePhotoPath: val['profilePhotoPath'],
      subDepartmentName:"",
      yearOfExperience:val['yearOfExperience'],));
    update();
    //print("**************$favouriteDoctorsData");
  }

  //this function used in doctor profile page
  void updateFavoriteDoctorProfile(val) {
    favouriteDoctorsData.add(FavouriteDoctorsModal(
      hospitalName: val.clinicName,
      id: val.id.toString(),
      name: val.name,
      profilePhotoPath: val.profilePhotoPath,
      subDepartmentName:"",
      yearOfExperience:val.yearOfExperience,));
    update();
    //print("**************$favouriteDoctorsData");
  }
  void removeFavoriteDoctor(val){
    if(val is String){
      favouriteDoctorsData.removeWhere((e) =>e.id == val.toString());
    }
    else{
      favouriteDoctorsData.removeWhere((e) =>e.id == val['id'].toString());
    }
    update();
  }
  void removeUpcomingAppointment(val){
    upcomingAppointmentsData.removeWhere((e) =>e.appointmentId.toString() == val.toString());
    update();
  }

  List<TopClinicDataModal> get getTopClinic =>
      List<TopClinicDataModal>.from(
          (
              (searchC.value.text == '' ? topClinic : topClinic.where((
                  element) =>
                  (
                      element['name'].toString().toLowerCase().trim()
                          +
                          element['address'].toString().toLowerCase().trim()
                          +
                          element['cityName'].toString().toLowerCase().trim()


                  ).trim().contains(searchC.value.text.toLowerCase().trim())
              ))
                  .map((element) => TopClinicDataModal.fromJson(element))
          )
      );


  Rx<TextEditingController> searchTopClinics = TextEditingController().obs;

  List<TopClinicDataModal> get getTopClinics =>
      List<TopClinicDataModal>.from(
          (
              (searchTopClinics.value.text == '' ? topClinic : topClinic.where((
                  element) =>
                  (
                      element['name'].toString().toLowerCase().trim()
                  ).trim().contains(
                      searchTopClinics.value.text.toLowerCase().trim())
              )).map((element) => TopClinicDataModal.fromJson(element))));


}