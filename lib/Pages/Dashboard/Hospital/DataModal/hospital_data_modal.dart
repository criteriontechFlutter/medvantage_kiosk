
class ClinicDetailsDataModal{
  String?profilePhotoPath;
  String?name;
  String?speciality;
  String?address;
  String?imagePath;
  int?reviewCount;
  String?userMobileNo;
  String?hospitalImages;
  String?hospitalName;


  ClinicDetailsDataModal({
    this.profilePhotoPath,
    this.name,
    this.speciality,
    this.address,
    this.imagePath,
    this.reviewCount,
    this.userMobileNo,
    this.hospitalImages,
    this.hospitalName
});
  factory ClinicDetailsDataModal.fromJson(Map<String,dynamic>json)=>
      ClinicDetailsDataModal(
        profilePhotoPath: json['profilePhotoPath'],
        name: json['name'],
        speciality: json['speciality'],
        address: json['address'],
        imagePath: json['imagePath'],
        reviewCount: json['reviewCount'],
        userMobileNo: json['userMobileNo'],
        hospitalImages: json['hospitalImages'],
        hospitalName: json['hospitalName']

      );

}





class DoctorListModal{
  int ?id;
  String ?profilePhotoPath;
  String? name;
  String?speciality;
  String ?yearOfExperience;
  String ?address;
  String ?workDesc;
  String ?degree;
  int?reviewCount;
  String?userMobileNo;
  int?drFee;

  DoctorListModal({
    this.id,
    this.profilePhotoPath,
    this.name,
    this.speciality,
    this.yearOfExperience,
    this.address,
    this.workDesc,
    this.degree,
    this.reviewCount,
    this.userMobileNo,
    this.drFee,
  });
  factory DoctorListModal.fromJson(Map<String,dynamic> json)=>
      DoctorListModal(
        id: json['id'],
        profilePhotoPath: json['profilePhotoPath'],
        name: json['name'],
        speciality: json['speciality'],
        yearOfExperience: json['yearOfExperience'],
        address: json['address'],
        workDesc: json['workDesc'],
        degree: json['degree'],
        reviewCount: json['reviewCount'],
        userMobileNo: json['userMobileNo'],
        drFee: json['drFee'],

      );
}



class SpecialityListDataModal{
  int?id;
  String?specialityName;


  SpecialityListDataModal({
    this.id,
    this.specialityName
  });
  factory SpecialityListDataModal.fromJson(Map<String,dynamic>json)=>
      SpecialityListDataModal(
          id: json['id'],
          specialityName: json['specialityName']
      );

}

