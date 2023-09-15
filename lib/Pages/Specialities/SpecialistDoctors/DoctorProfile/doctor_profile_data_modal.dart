class DoctorProfileDataModal {
  int? id;
  int? serviceProviderDetailsId;
  int? serviceProviderLoginId;
  int? serviceProviderTypeId;
  String? mobileNo;
  String? serviceProviderType;
  String? specialityName;
  String? name;
  String? gender;
  String? emailId;
  String? address;
  String? pinCode;
  int? cityId;
  String? city;
  int? stateId;
  String? state;
  int? countryId;
  String? country;
  String? profilePhotoPath;
  String? userMobileNo;
  String? workDescription;
  String? registrationNo;
  String? registrationCouncil;
  String? registrationYear;
  String? degree;
  String? college;
  String? yearOfCompletion;
  String? genderId;
  String? yearOfExperience;
  bool? ownOrVisitEstabilshment;
  String? establishmentName;
  int? establishmentCityId;
  String? establishmentCity;
  String? establishmentLocality;
  int? drFee;
  String? currency;
  int? currencyId;
  String? symbol;
  int? primaryStatus;
  String? dob;
  String? signature;
  String? ageText;
  String? age;
  int? specialityId;
  String? timeDetails;
  int? departmentId;
  String? speciality;
  String? clinicName;
  String? timeSlots;
  int? followUpDuration;
  int? reVisitCount;
  int? isEraUser;
  int? noofPatients;
  int? isFavourite;
  DoctorProfileDataModal(
      {this.id,
        this.serviceProviderDetailsId,
        this.serviceProviderLoginId,
        this.serviceProviderTypeId,
        this.mobileNo,
        this.serviceProviderType,
        this.specialityName,
        this.name,
        this.gender,
        this.emailId,
        this.address,
        this.pinCode,
        this.cityId,
        this.city,
        this.stateId,
        this.state,
        this.countryId,
        this.country,
        this.profilePhotoPath,
        this.userMobileNo,
        this.workDescription,
        this.registrationNo,
        this.registrationCouncil,
        this.registrationYear,
        this.degree,
        this.college,
        this.yearOfCompletion,
        this.genderId,
        this.yearOfExperience,
        this.ownOrVisitEstabilshment,
        this.establishmentName,
        this.establishmentCityId,
        this.establishmentCity,
        this.establishmentLocality,
        this.drFee,
        this.currency,
        this.currencyId,
        this.symbol,
        this.primaryStatus,
        this.dob,
        this.signature,
        this.ageText,
        this.age,
        this.specialityId,
        this.timeDetails,
        this.departmentId,
        this.speciality,
        this.clinicName,
        this.timeSlots,
        this.followUpDuration,
        this.reVisitCount,
      this.isEraUser,
      this.noofPatients,
      this.isFavourite
      });

  DoctorProfileDataModal.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    serviceProviderDetailsId = json['serviceProviderDetailsId'];
    serviceProviderLoginId = json['serviceProviderLoginId'];
    serviceProviderTypeId = json['serviceProviderTypeId'];
    mobileNo = json['mobileNo']??'';
    serviceProviderType = json['serviceProviderType'];
    specialityName = json['specialityName']??"";
    name = json['name']??"";
    gender = json['gender']??'';
    emailId = json['emailId']??"";
    address = json['address']??'';
    pinCode = json['pinCode'];
    cityId = json['cityId'];
    city = json['city'];
    stateId = json['stateId'];
    state = json['state'];
    countryId = json['countryId'];
    country = json['country'];
    profilePhotoPath = json['profilePhotoPath']??'';
    userMobileNo = json['userMobileNo']??"";
    workDescription = json['workDescription'];
    registrationNo = json['registrationNo'];
    registrationCouncil = json['registrationCouncil'];
    registrationYear = json['registrationYear'];
    degree = json['degree']??'';
    college = json['college']??'';
    yearOfCompletion = json['yearOfCompletion']??'';
    genderId = json['genderId'];
    yearOfExperience = json['yearOfExperience']??'';
    ownOrVisitEstabilshment = json['ownOrVisitEstabilshment'];
    establishmentName = json['establishmentName'];
    establishmentCityId = json['establishmentCityId'];
    establishmentCity = json['establishmentCity'];
    establishmentLocality = json['establishmentLocality'];
    drFee = json['drFee']??0;
    currency = json['currency'];
    currencyId = json['currencyId'];
    symbol = json['symbol'];
    primaryStatus = json['primaryStatus'];
    dob = json['dob'];
    signature = json['signature'];
    ageText = json['ageText']??'';
    age = json['age'];
    specialityId = json['specialityId'];
    timeDetails = json['timeDetails'];
    departmentId = json['departmentId'];
    speciality = json['speciality']??'';
    clinicName = json['clinicName']??'';
    timeSlots = json['timeSlots'];
    followUpDuration = json['followUpDuration'];
    reVisitCount = json['reVisitCount'];
    isEraUser = json['isEraUser'];
    noofPatients = json['noofPatients'];
    isFavourite = json['isFavourite'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['serviceProviderDetailsId'] = this.serviceProviderDetailsId;
    data['serviceProviderLoginId'] = this.serviceProviderLoginId;
    data['serviceProviderTypeId'] = this.serviceProviderTypeId;
    data['mobileNo'] = this.mobileNo;
    data['serviceProviderType'] = this.serviceProviderType;
    data['specialityName'] = this.specialityName;
    data['name'] = this.name;
    data['gender'] = this.gender;
    data['emailId'] = this.emailId;
    data['address'] = this.address;
    data['pinCode'] = this.pinCode;
    data['cityId'] = this.cityId;
    data['city'] = this.city;
    data['stateId'] = this.stateId;
    data['state'] = this.state;
    data['countryId'] = this.countryId;
    data['country'] = this.country;
    data['profilePhotoPath'] = this.profilePhotoPath;
    data['userMobileNo'] = this.userMobileNo;
    data['workDescription'] = this.workDescription;
    data['registrationNo'] = this.registrationNo;
    data['registrationCouncil'] = this.registrationCouncil;
    data['registrationYear'] = this.registrationYear;
    data['degree'] = this.degree;
    data['college'] = this.college;
    data['yearOfCompletion'] = this.yearOfCompletion;
    data['genderId'] = this.genderId;
    data['yearOfExperience'] = this.yearOfExperience;
    data['ownOrVisitEstabilshment'] = this.ownOrVisitEstabilshment;
    data['establishmentName'] = this.establishmentName;
    data['establishmentCityId'] = this.establishmentCityId;
    data['establishmentCity'] = this.establishmentCity;
    data['establishmentLocality'] = this.establishmentLocality;
    data['drFee'] = this.drFee;
    data['currency'] = this.currency;
    data['currencyId'] = this.currencyId;
    data['symbol'] = this.symbol;
    data['primaryStatus'] = this.primaryStatus;
    data['dob'] = this.dob;
    data['signature'] = this.signature;
    data['ageText'] = this.ageText;
    data['age'] = this.age;
    data['specialityId'] = this.specialityId;
    data['timeDetails'] = this.timeDetails;
    data['departmentId'] = this.departmentId;
    data['speciality'] = this.speciality;
    data['clinicName'] = this.clinicName;
    data['timeSlots'] = this.timeSlots;
    data['followUpDuration'] = this.followUpDuration;
    data['reVisitCount'] = this.reVisitCount;
    data['isEraUser'] = this.isEraUser;
    data['noofPatients'] = this.noofPatients;
    data['isFavourite'] = this.isFavourite;
    return data;
  }
}
