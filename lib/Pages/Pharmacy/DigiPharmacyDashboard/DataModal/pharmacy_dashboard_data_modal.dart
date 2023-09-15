


import 'package:digi_doctor/Pages/Pharmacy/DigiPharmacyDashboard/DataModal/popular_productList_data_modal.dart';
import 'package:digi_doctor/Pages/Pharmacy/DigiPharmacyDashboard/DataModal/search_productlist_data_modal.dart';


import 'all_category_data_modal.dart';

class PharmacyDashboardDataModal{
  List<PopularProductListDataModal>?popularProductsList;
  List<AllCategoryDataModal>?categoryList;
  List<BannerListDataModal>?bannerText;
  List<SearchProductListDataModal>?searchProductList;
  String?cartCount;


  PharmacyDashboardDataModal({
    this.popularProductsList,
    this.categoryList,
    this.bannerText,
    this.searchProductList,

  });

  factory PharmacyDashboardDataModal.fromJson(Map<String,dynamic>json)=>
      PharmacyDashboardDataModal(
        popularProductsList: json['popularProductsList']??[],
        categoryList: json['categoryList']??[],
        bannerText: json['bannerText']??[],
        searchProductList: json['searchProductList']??[],
      );
}


class BannerListDataModal{

  List?sliderImage;

  BannerListDataModal({
    this.sliderImage

  });
  factory BannerListDataModal.fromJson(Map<String,dynamic> json)=>
      BannerListDataModal(
          sliderImage: json['sliderImage']??[]
      );

}