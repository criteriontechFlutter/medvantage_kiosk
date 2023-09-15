


import 'package:digi_doctor/AppManager/alert_dialogue.dart';
import 'package:digi_doctor/Pages/InvestigationHistory/AddInvestigation/add_investigation_view.dart';
import 'package:get/get.dart';

import '../../../AppManager/app_color.dart';
import '../../InvestigationHistory/investigation_view.dart';
import 'DataModal/category_details_data_modal.dart';
import 'DataModal/lab_test_dashboard_data_modal.dart';
import 'DataModal/package_details_data_modal.dart';
import 'DataModal/pathalogy_details_data_modal.dart';

class LabTestController extends GetxController{
  List menuList=[
    {
      'title':'Lab',
      'sub_title':'Orders',
      "img":"assets/viewOrder.svg",
  'onPressed':(context) {
    alertToast(context, "Coming Soon");

  }
    },

    {
      'title':'Home',
      'sub_title':'Sample',
      "img":"assets/homeSample.svg",
      'onPressed':(context){
        alertToast(context, "Comming Soon");
      }
    },


    {
      'title':'View',
      'sub_title':'Reports',
      "img":"assets/viewReport.svg",
      'onPressed':const InvestigationView()
    },

    {
      'title':'Add',
      'sub_title':'Reports',
      "img":"assets/safe.svg",
      'onPressed':const AddInvestigationView()
    },


  ];

  List healthCheckupCategories=[
    {
      'title':'Pathology',
      "color":AppColor.purple
    },
    {
      'title':'Microbiology',
      "color":AppColor.orangeButtonColor
    },
    {
      'title':'Radiology',
      "color":AppColor.green
    },
    {
      'title':'Food',
      "color":AppColor.primaryColor
    },
    {
      'title':'Ambulance',
      "color":AppColor.purple
    },
    {
      'title':'Bed Charge',
      "color":AppColor.orangeButtonColor
    },
    {
      'title':'Other',
      "color":AppColor.green
    },
    {
      'title':'Covid 19 Elisa Lab',
      "color":AppColor.primaryColor
    },
    {
      'title':'Corona',
      "color":AppColor.purple
    },

    {
      'title':'ICPMS',
      "color":AppColor.orangeButtonColor
    },


    {
      'title':'LCMS',
      "color":AppColor.green
    },
  ];

  List healthPackage=[
    {
      "img":"assets/homeSample.svg",
      "title":"Full Body Package",
      "sub_title":"Era Pathology",
      "tests":"Includes 63 Tests",
      "fees":"1500--26% Off",
      "discounted_fees":"1110"
    },
    {
    "img":"assets/homeSample.svg",
      "title":"Senior Citizen",
      "sub_title":"Khanna Pathology",
      "tests":"Includes 63 Tests",
      "fees":"1500--26% Off",
      "discounted_fees":"1028"
    },
    {
    "img":"assets/homeSample.svg",
      "title":"Microbiology Test",
      "sub_title":"Shri Pathology",
      "tests":"Includes 23 Tests",
      "fees":"1500--26% Off",
      "discounted_fees":"1110"
    }
    ,
    {
    "img":"assets/homeSample.svg",
      "title":"Blood Sugar Checkup",
      "sub_title":"HDP Pathology",
      "tests":"Includes 103 Tests",
      "fees":"100--26% Off",
      "discounted_fees":"76"
    }
  ];

  List checkupList=[
    {
      'title':'Pathology',
      "img":"assets/viewOrder.svg"
    },

    {
      'title':'Microbiology',
      "img":"assets/homeSample.svg"
    },


    {
      'title':'Radiology',
      "img":"assets/viewReports.svg"
    },

    {
      'title':'Food',
      "img":"assets/hygenic.svg"
    },
    {
      'title':'Ambulance',
      "img":"assets/hygenic.svg"
    },

    {
      'title':'Bed Charge',
      "img":"assets/hygenic.svg"
    },
    {
      'title':'Other',
      "img":"assets/hygenic.svg"
    },
    {
      'title':'Corona',
      "img":"assets/hygenic.svg"
    },
    {
      'title':'ICPMS',
      "img":"assets/hygenic.svg"
    },
    {
      'title':'LCMS',
      "img":"assets/hygenic.svg"
    },


  ];



  List partnerList=[
    {
      'title':'Dr Lal Pathlabs',
      "img":"assets/viewOrder.svg"
    },

    {
      'title':'Lifeline Labs \n Excellence..',
      "img":"assets/homeSample.svg"
    },


    {
      'title':'Vimta Labs \n Driven by...',
      "img":"assets/viewReports.svg"
    },

    {
      'title':'Khanna Diagnostic',
      "img":"assets/hygenic.svg"
    },
    {
      'title':'Thakural Labs',
      "img":"assets/hygenic.svg"
    },

    {
      'title':'Charak Pathology',
      "img":"assets/hygenic.svg"
    },
    {
      'title':'Modern Path Labs',
      "img":"assets/hygenic.svg"
    },
    {
      'title':'Hind Pathology',
      "img":"assets/hygenic.svg"
    },
    {
      'title':'India Pathology',
      "img":"assets/hygenic.svg"
    },
    {
      'title':'Free Tests Pathology',
      "img":"assets/hygenic.svg"
    },


  ];

  List dashboardData=[].obs;
  List sliderImage=[].obs;
  List packageDetails=[].obs;
  List categoryDetails=[].obs;
  List bannerText=[].obs;
  List pathalogyDetails=[].obs;
  //List bannerText=[].obs;

  RxBool showNoTopData=false.obs;
  bool get getShowNoTopData=>(showNoTopData.value);
  set updateShowNoTopData(bool val){
    showNoTopData.value=val;
    update();
  }

List<LabTestDashboardDataModal>get getDashboardData=>List<LabTestDashboardDataModal>.from(
    dashboardData.map((e) =>LabTestDashboardDataModal.fromJson(e) )
);



  List<SliderImageDataModal> get getSliderImage=>List<SliderImageDataModal>.
  from(sliderImage.map((e) => SliderImageDataModal.fromJson(e)));

List<PackageDetailsDataModal> get getPackageDetails=>List<PackageDetailsDataModal>.from(
    packageDetails.map((e) => PackageDetailsDataModal.fromJson(e))
);

List<CategoryDetailsDataModal> get getCategoryDetails=>List<CategoryDetailsDataModal>.from(
    categoryDetails.map((e) =>CategoryDetailsDataModal.fromJson(e))
);
List<PathalogyDetailsDataModal> get getPathalogyDetails=>List<PathalogyDetailsDataModal>.from(
      pathalogyDetails.map((e) => PathalogyDetailsDataModal.fromJson(e))
      );

List<BannerTestDataModal>get getBannerText=>List<BannerTestDataModal>.from(
    bannerText.map((e) => BannerTestDataModal.fromJson(e))
);
  set updateDashboardData(List val) {
    sliderImage = val;
    packageDetails=val[0]['packageDetails'];
    categoryDetails=val[0]['categoryDetails'];
    pathalogyDetails=val[0]['pathalogyDetails'];
    bannerText =val[0]['bannerText'];
    dashboardData = val;

  //  cartCount.value = val[0]['cartCount'];
    update();
    // bannerText=val[0].['bannerText'];
  }
  //*************
  List labCartCount=[].obs;
  List<CartCountDataModal> get getLabCartCount=>List<CartCountDataModal>.from(
      labCartCount.map((e) => CartCountDataModal.fromJson(e))
  );


  set updateLabCartCount(List val){
    labCartCount=val;
    update();
  }



  // RxString labCartCount=''.obs;
  // String get getLabCartCount=>labCartCount.value;
  // set updateLabCartCount(String val){
  //   labCartCount.value=val;
  //   update();
  // }
 //  RxString cartCount = ''.obs;
 // // RxString selectedMemberId=''.obs;
 //  String get getCartCount=>cartCount.value;

}