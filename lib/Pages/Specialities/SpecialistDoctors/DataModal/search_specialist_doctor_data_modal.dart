import 'dart:convert';


// class SearchDataModel{
//   int? id;
//   String? drName;
//   String? speciality;
//   String? hospitalName;
//   String? degree;
//   int? isEraUser;
//   String? address;
//   double? drFee;
//   String? profilePhotoPath;
//   int? noofPatients;
//   int? isFavourite;
//   // String? timeSlots;
//   List<DoctorProfileModel>? timeSlots;
//   List<WorkingHoursDataModal>? workingHours;
//   String? yearOfExperience;
//   List? sittingDays;
//
//   SearchDataModel(
//       {this.id,
//         this.drName,
//       this.speciality,
//       this.hospitalName,
//       this.degree,
//       this.isEraUser,
//       this.address,
//       this.drFee,
//       this.profilePhotoPath,
//       this.noofPatients,
//       this.isFavourite,
//       // this.timeSlots,
//       this.timeSlots,
//       this.yearOfExperience,
//         this.workingHours,
//         this.sittingDays,
//       });
//
//   factory SearchDataModel.fromJson(Map<String, dynamic> json) =>
//       SearchDataModel(
//         id: json['id'],
//         drName: json['drName'].toString(),
//         speciality: json['speciality'],
//         hospitalName: json['hospitalName'],
//         degree: json['degree'],
//         isEraUser: json['isEraUser'],
//         address: json['address'],
//         drFee: double.parse(json['drFee'].toString()),
//         profilePhotoPath: json['profilePhotoPath'],
//         noofPatients: json['noofPatients'],
//         isFavourite: json['isFavourite'],
//         yearOfExperience: json['yearOfExperience'],
//         sittingDays: json['sittingDays']??[],
//         // timeSlots: json['timeSlots'],
//
//         timeSlots: List<DoctorProfileModel>.from(
//             jsonDecode(json['timeSlots']?? '[]')
//                 .map((element) => DoctorProfileModel.fromJson(element))),
//         workingHours: List<WorkingHoursDataModal>.from(
//             jsonDecode(json['workingHours']?? '[]')
//                 .map((element) => WorkingHoursDataModal.fromJson(element))),
//       );
// }
//
// class DoctorProfileModel {
//   String? dayName;
//   List<TimeDetailsModel>? timeDetails;
//   DoctorProfileModel({
//     this.dayName,
//     this.timeDetails,
//   });
//
//   factory DoctorProfileModel.fromJson(Map<String, dynamic> json) =>
//       DoctorProfileModel(
//         dayName: json['dayName'],
//         timeDetails: List<TimeDetailsModel>.from((json['timeDetails'] ?? '[]')
//             .map((element) => TimeDetailsModel.fromJson(element))),
//       );
// }
//
// class WorkingHoursDataModal {
//   String? dayName;
//   WorkingHoursDataModal({
//     this.dayName,
//   });
//
//   factory WorkingHoursDataModal.fromJson(Map<String, dynamic> json) =>
//       WorkingHoursDataModal(
//         dayName: json['dayName'],
//
//       );
// }




class SearchDataModel {
  int? id;
  int? clientID;
  String? name;
  String? titleName;
  String? email;
  String? mobileNo;
  String? userName;
  String? password;
  int? roleId;
  int? userTypeId;
  int? empNo;
  int? titleID;
  int? userId;
  bool? isOtpAuthentication;
  String? client;
  String? createdDate;
  int? designationId;
  int? departmentId;
  bool? status;
  String? assignUserWiseMenuList;
  String? assignDepartmentHeadMaster;
  String? userMFASettings;
  String? userStatusSettings;

  SearchDataModel(
      {this.id,
        this.clientID,
        this.name,
        this.titleName,
        this.email,
        this.mobileNo,
        this.userName,
        this.password,
        this.roleId,
        this.userTypeId,
        this.empNo,
        this.titleID,
        this.userId,
        this.isOtpAuthentication,
        this.client,
        this.createdDate,
        this.designationId,
        this.departmentId,
        this.status,
        this.assignUserWiseMenuList,
        this.assignDepartmentHeadMaster,
        this.userMFASettings,
        this.userStatusSettings});

  SearchDataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    clientID = json['clientID'];
    name = json['name'];
    titleName = json['titleName'];
    email = json['email'];
    mobileNo = json['mobileNo'];
    userName = json['userName'];
    password = json['password'];
    roleId = json['roleId'];
    userTypeId = json['userTypeId'];
    empNo = json['empNo'];
    titleID = json['titleID'];
    userId = json['userId'];
    isOtpAuthentication = json['isOtpAuthentication'];
    client = json['client'];
    createdDate = json['createdDate'];
    designationId = json['designationId'];
    departmentId = json['departmentId'];
    status = json['status'];
    assignUserWiseMenuList = json['assignUserWiseMenuList'].toString();
    assignDepartmentHeadMaster = json['assignDepartmentHeadMaster'].toString();
    userMFASettings = json['userMFASettings'].toString();
    userStatusSettings = json['userStatusSettings'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['clientID'] = this.clientID;
    data['name'] = this.name;
    data['titleName'] = this.titleName;
    data['email'] = this.email;
    data['mobileNo'] = this.mobileNo;
    data['userName'] = this.userName;
    data['password'] = this.password;
    data['roleId'] = this.roleId;
    data['userTypeId'] = this.userTypeId;
    data['empNo'] = this.empNo;
    data['titleID'] = this.titleID;
    data['userId'] = this.userId;
    data['isOtpAuthentication'] = this.isOtpAuthentication;
    data['client'] = this.client;
    data['createdDate'] = this.createdDate;
    data['designationId'] = this.designationId;
    data['departmentId'] = this.departmentId;
    data['status'] = this.status;
    data['assignUserWiseMenuList'] = this.assignUserWiseMenuList;
    data['assignDepartmentHeadMaster'] = this.assignDepartmentHeadMaster;
    data['userMFASettings'] = this.userMFASettings;
    data['userStatusSettings'] = this.userStatusSettings;
    return data;
  }
}

class TimeDetailsModel {
  String? timeFrom;
  String? timeTo;

  TimeDetailsModel({
    this.timeFrom,
    this.timeTo,
  });

  factory TimeDetailsModel.fromJson(Map<String, dynamic> json) =>
      TimeDetailsModel(
        timeFrom: json['timeFrom'],
        timeTo: json['timeTo'],
      );
}
