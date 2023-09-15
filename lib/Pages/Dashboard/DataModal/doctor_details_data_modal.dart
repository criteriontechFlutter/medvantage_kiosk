
import 'dart:convert';

class DoctorDetailsDataModal{

  int? id;
  String? name;
  String?drName;
  String? hospitalName;
  String?yearOfExperience;
  String? address;
  String? stateName;
  String? cityName;
  String? profilePhotoPath;
  String? specialityName;
  double? drFee;
  int?reviewCount;
  int?review;
  int?rating;
  List<SlotInformation>? slotDetails;
  List<WorkingHoursDataModal>? workingHours;
  String? degree;
  int? noOfpatients;
  int? isEraUser;
  List? sittingDays;
  DoctorDetailsDataModal({
    this.id,
    this.name,
    this.drName,
    this.hospitalName,
    this.yearOfExperience,
    this.address,
    this.stateName,
    this.cityName,
    this.profilePhotoPath,
    this.specialityName,
    this.drFee,
    this.slotDetails,
    this.workingHours,
    this.reviewCount,
    this.review,
    this.rating,
    this.degree,
    this.noOfpatients,
    this.isEraUser,
    this.sittingDays
  });

  factory DoctorDetailsDataModal.fromJson(Map<String, dynamic> json) =>
      DoctorDetailsDataModal(
        id : int.parse(json['id'].toString()),
        name : json['name'],
        drName: json['drName'],
        address : json['address'],
        hospitalName: json['hospitalName']??'',
        yearOfExperience: json['yearOfExperience'],
        stateName : json['stateName'],
        cityName : json['cityName'],
        profilePhotoPath : json['profilePhotoPath'],
        specialityName : json['speciality'],
        drFee : double.parse(json['drFee'].toString()),
        reviewCount: json['reviewCount'],
        review: json['review'],
        rating: json['rating'],
        sittingDays: json['sittingDays']??[],
        slotDetails: List<SlotInformation>.from(
            (jsonDecode(json['timeSlots']??'[]')).map((element) => SlotInformation.fromJson(element))
        ),
        workingHours: List<WorkingHoursDataModal>.from(
            (jsonDecode(json['workingHours']??'[]')).map((element) => WorkingHoursDataModal.fromJson(element))
        ),
        degree: json['degree'],
        noOfpatients: json['noofPatients']??0,
        isEraUser: json['isEraUser'],

      );

}
class SlotInformation{
  String? slotId;
  String? slotType;
  String? slotTime;

  SlotInformation({
    this.slotId,
    this.slotType,
    this.slotTime
  });

  factory SlotInformation.fromJson(Map<String, dynamic> json) => SlotInformation(
    slotId: json['slotId'].toString(),
    slotType: json['slotType'].toString(),
    slotTime: json['slotTime'].toString(),
  );

}

class WorkingHoursDataModal{
  String? dayName;
  String? timeFrom;
  String? timeTo;

  WorkingHoursDataModal({
    this.dayName,
    this.timeFrom,
    this.timeTo
  });

  factory WorkingHoursDataModal.fromJson(Map<String, dynamic> json) => WorkingHoursDataModal(
    dayName: json['dayName'].toString(),
    timeFrom: json['timeFrom'].toString(),
    timeTo: json['timeTo'].toString(),
  );

}