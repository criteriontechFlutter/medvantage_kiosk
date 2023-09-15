

import '../../MyAppointment/MyAppointmentDataModal/my_appointment_data_modal.dart';

class DashboardDataModal {
 List? topImage ;
 List<BannerDetails>? bannerDetails ;
 List<HealthProductDetails>? healthProductDetails ;
 List<TopClinicDataModal>? topClinics ;
 List<BlogDetailDataModal>? blogDetails ;
 List? doctorDetails  ;
 List<CountDetails>? countDetails ;
 List? menuDetails;
 List<MyAppointmentDataModal>? upcomingAppointments ;
 List<FavouriteDoctorsModal>? favouriteDoctors ;

  DashboardDataModal({
      this.topImage,
      this.bannerDetails,
      this.healthProductDetails,
      this.blogDetails,
      this.topClinics,
      this.countDetails,
      this.upcomingAppointments,
      this.favouriteDoctors,
  });

  factory DashboardDataModal.fromJson(Map<String, dynamic> json) =>
      DashboardDataModal(
        topImage: json['topImage'],
        bannerDetails: List<BannerDetails>.from(
            (json['bannerDetails']??'[]').map((element) => BannerDetails.fromJson(element))
        ),
        healthProductDetails: List<HealthProductDetails>.from(
            (json['healthProductDetails']??'[]').map((element) => HealthProductDetails.fromJson(element))
        ),
        topClinics: List<TopClinicDataModal>.from(
            (json['topClinics']??'[]').map((element) => TopClinicDataModal.fromJson(element))
        ),
        blogDetails: List<BlogDetailDataModal>.from(
            (json['blogDetails']??'[]').map((element) => BlogDetailDataModal.fromJson(element))
        ),
        countDetails: List<CountDetails>.from(
            (json['countDetails']??'[]').map((element) => CountDetails.fromJson(element))
        ),
        upcomingAppointments: List<MyAppointmentDataModal>.from(
            (json['upcomingAppoinments']??'[]').map((element) => MyAppointmentDataModal.fromJson(element))
        ),
        favouriteDoctors: List<FavouriteDoctorsModal>.from(
            (json['favouriteDoctors']??'[]').map((element) => FavouriteDoctorsModal.fromJson(element))
        ),
      );
}

class BannerDetails{
  String? sliderImages;
  BannerDetails({
    this.sliderImages,
});
  factory BannerDetails.fromJson(Map<String, dynamic> json) =>
      BannerDetails(
          sliderImages: json['sliderImages']
      );
}

class CountDetails{
  String? description;
  int? doctorsCount;
  int? hospitalCount;
  int? userCount;
  CountDetails({
    this.description,
    this.doctorsCount,
    this.hospitalCount,
    this.userCount,
});
  factory CountDetails.fromJson(Map<String, dynamic> json) =>
      CountDetails(
  description: json['description']??'',
  doctorsCount: json['doctorsCount']??0,
  hospitalCount: json['hospitalCount']??0,
  userCount: json['userCount']??0,
      );
}


class HealthProductDetails {
 String? id;
 String? categoryName;
 String? imagePath;

 HealthProductDetails(
 {
   this.id,
   this.categoryName,
   this.imagePath,
}
     );
 factory HealthProductDetails.fromJson(Map<String, dynamic> json) =>
     HealthProductDetails(
       id: json['id'].toString(),
       categoryName: json['categoryName'].toString(),
       imagePath: json['imagePath'].toString(),
     );

}

class TopClinicDataModal{
  int ?id;
  String? name;
  String ?address;
  String ?stateName;
  String ?cityName;
  String ?profilePhotoPath;
  String ?serviceProviderType;

  TopClinicDataModal({
    this.id,
    this.name,
    this.address,
    this.stateName,
    this.cityName,
    this.profilePhotoPath,
    this.serviceProviderType
  });
  factory TopClinicDataModal.fromJson(Map<String,dynamic> json)=>
      TopClinicDataModal(
        id: json['id'],
        name: json['name'],
        address: json['address'],
        stateName: json['stateName'],
        cityName: json['cityName'],
        profilePhotoPath: json['profilePhotoPath'],
        serviceProviderType: json['serviceProviderType'],
      );
}




class BlogDetailDataModal{
  int?id;
  String?topic;
  String?title;
  String?description;
  String?totalLikes;
  String?imagePath;
  String?publishDate;

  BlogDetailDataModal({
    this.id,
    this.topic,
    this.title,
    this.description,
    this.totalLikes,
    this.imagePath,
    this.publishDate
  });
  factory BlogDetailDataModal.fromJson(Map<String, dynamic> json) =>
      BlogDetailDataModal(
        id : json['id'],
        topic : json['topic'],
        title : json['title'],
        description : json['description'].toString(),
        totalLikes : json['totalLikes'].toString(),
        imagePath : json['imagePath'],
        publishDate:json['publishDate'],);
}

class FavouriteDoctorsModal {
  String? hospitalName;
  String? name;
  String? id;
  String? subDepartmentName;
  String? yearOfExperience;
  String? profilePhotoPath;

  FavouriteDoctorsModal(
      {this.hospitalName,
        this.name,
        this.id,
        this.subDepartmentName,
        this.yearOfExperience,
        this.profilePhotoPath});

  FavouriteDoctorsModal.fromJson(Map<String, dynamic> json) {
    hospitalName = json['hospitalName']??'--';
    name = json['name'];
    id = (json['id']).toString();
    subDepartmentName = json['subDepartmentName']??"";
    yearOfExperience = json['yearOfExperience']?? '';
    profilePhotoPath = json['profilePhotoPath']?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['hospitalName'] = this.hospitalName;
    data['name'] = this.name;
    data['id'] = this.id;
    data['subDepartmentName'] = this.subDepartmentName;
    data['yearOfExperience'] = this.yearOfExperience;
    data['profilePhotoPath'] = this.profilePhotoPath;
    return data;
  }
}