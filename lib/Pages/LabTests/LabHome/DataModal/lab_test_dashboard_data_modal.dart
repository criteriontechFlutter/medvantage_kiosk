




import 'package:digi_doctor/Pages/LabTests/LabHome/DataModal/package_details_data_modal.dart';
import 'package:digi_doctor/Pages/LabTests/LabHome/DataModal/pathalogy_details_data_modal.dart';

import 'category_details_data_modal.dart';

class LabTestDashboardDataModal{
  List<SliderImageDataModal>?sliderImage;
  List<PackageDetailsDataModal>?packageDetails;
  List<CategoryDetailsDataModal>?categoryDetails;
  List<BannerTestDataModal>?bannerText;
  List<PathalogyDetailsDataModal>?pathalogyDetails;
  //String?cartCount;


  LabTestDashboardDataModal({
    this.sliderImage,
    this.packageDetails,
    this.categoryDetails,
    this.bannerText,
    this.pathalogyDetails,
    //this.cartCount

});

  factory LabTestDashboardDataModal.fromJson(Map<String,dynamic>json)=>
      LabTestDashboardDataModal(
        sliderImage: json['sliderImage']??[],
        packageDetails: json['packageDetails']??[],
        categoryDetails: json['categoryDetails']??[],
        bannerText: json['bannerText']??[],
        pathalogyDetails: json['pathalogyDetails']??[],
        //cartCount: json['cartCount']
      );
}



class CartCountDataModal{

  int?cart_count;

  CartCountDataModal({
    this.cart_count,

  });
  factory CartCountDataModal.fromJson(Map<String,dynamic> json)=>
      CartCountDataModal(
          cart_count: json['cartCount'],
      );

}





class SliderImageDataModal{

  List?sliderImage;

  SliderImageDataModal({
    this.sliderImage

});
  factory SliderImageDataModal.fromJson(Map<String,dynamic> json)=>
      SliderImageDataModal(
        sliderImage: json['sliderImage']??[]
      );

}

class BannerTestDataModal{

  String?bannerText;
  String?callingNo;

  BannerTestDataModal({
    this.bannerText,
    this.callingNo,

  });
  factory BannerTestDataModal.fromJson(Map<String,dynamic> json)=>
      BannerTestDataModal(
          bannerText: json['bannerText'],
        callingNo: json['callingNo']??''
      );

}
