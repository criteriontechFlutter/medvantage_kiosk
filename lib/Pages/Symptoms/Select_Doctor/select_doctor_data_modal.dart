


class RecommendedDoctorDataModal{
  int? id;
  String? experience;
  String? doctorName;
  String? imagePath;
  String? hospital_name;
  int? review;
  int? rating;
  String? speciality;
  int? isEraUser;
  String? address;
  String? degree;
  int? noofPatients;
  double? drFee;

  RecommendedDoctorDataModal({
      this.id,
      this.imagePath,
      this.doctorName,
      this.hospital_name,
      this.experience,
      this.rating,
      this.review,
    this.speciality,
    this.isEraUser,
    this.address,
    this.degree,
    this.noofPatients,
    this.drFee,
  });

  factory RecommendedDoctorDataModal.fromJson(Map<String, dynamic> json) =>
      RecommendedDoctorDataModal(
        id: json['id'],
        doctorName: json['drName'],
        imagePath: json['profilePhotoPath'],
        experience: json['yearOfExperience'],
        hospital_name: json['hospitalName'],
        review: json['review'],
        rating: json['rating'],
        speciality: json['speciality'],
        isEraUser: json['isEraUser'],
        address: json['address'],
        degree: json['degree'],
        noofPatients: json['noofPatients'],
          drFee: double.parse(json['drFee'].toString())
      );

}


class PopularDoctorDataModal{


  int? id;
  String? experience;
  String? doctorName;
  String? imagePath;
  String? hospital_name;
  int? review;
  int? rating;
  String? working_hours;
  String? speciality;
  int? isEraUser;
  double? fee;
  String? degree;
  String? address;
  int? noofPatients;
  double? drFee;
  List? sittingDays;
  PopularDoctorDataModal({
      this.id,
      this.imagePath,
      this.doctorName,
      this.hospital_name,
      this.experience,
      this.rating,
      this.review,
      this.working_hours,
      this.fee,
      this.speciality,
      this.degree,
      this.address,
      this.noofPatients,
    this.isEraUser,
    this.drFee,
    this.sittingDays
  });

  factory PopularDoctorDataModal.fromJson(Map<String, dynamic> json) =>
      PopularDoctorDataModal(
        id: json['id'],
        doctorName: json['drName'],
        imagePath: json['profilePhotoPath'],
        experience: json['yearOfExperience'],
        hospital_name: json['hospitalName'],
        review: json['review'],

        rating: json['rating'],
        working_hours: json['workingHours'],
        fee: double.parse((json['drFee']??0.0).toString()),
        speciality: json['speciality'],
          degree: json['degree'],
        address: json['address'],
        noofPatients: json['noofPatients'],
        isEraUser: json['isEraUser'],
          sittingDays: json['sittingDays'],
        drFee:  double.parse((json['drFee']??'0.0').toString())

      );


}

class DoctorsListDataModal {
  int? id;
  String? name;
  int? departmentId;
  String? departmentName;
  int? designationId;
  int? clientID;
  int? roleId;

  DoctorsListDataModal(
      {this.id,
        this.name,
        this.departmentId,
        this.departmentName,
        this.designationId,
        this.clientID,
        this.roleId});

  DoctorsListDataModal.fromJson(Map<String, dynamic> json) {
    id = json['id']??0;
    name = json['name']??'';
    departmentId = json['departmentId']??0;
    departmentName = json['departmentName']??'';
    designationId = json['designationId']??0;
    clientID = json['clientID']??0;
    roleId = json['roleId']??0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['departmentId'] = this.departmentId;
    data['departmentName'] = this.departmentName;
    data['designationId'] = this.designationId;
    data['clientID'] = this.clientID;
    data['roleId'] = this.roleId;
    return data;
  }
}
