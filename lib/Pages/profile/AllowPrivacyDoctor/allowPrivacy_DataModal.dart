

class PrivacyModal {
  int? memberId;
  int? serviceProviderDetailsId;
  String? doctorName;
  String? degree;
  String? profilePhotoPath;
  String? address;
  String? yearOfExperience;
  double? drFee;
  int? isEraUser;
  int? isAllowed;
  bool? status;
  String? privacy;

  PrivacyModal(
      {this.memberId,
        this.serviceProviderDetailsId,
        this.doctorName,
        this.degree,
        this.profilePhotoPath,
        this.address,
        this.yearOfExperience,
        this.drFee,
        this.isEraUser,
        this.isAllowed,
        this.status,
        this.privacy,});

  PrivacyModal.fromJson(Map<String, dynamic> json) {
    memberId = json['memberId'];
    serviceProviderDetailsId = json['serviceProviderDetailsId'];
    doctorName = json['doctorName'];
    degree = json['degree'];
    profilePhotoPath = json['profilePhotoPath'];
    address = json['address'];
    yearOfExperience = json['yearOfExperience'];
    drFee = json['drFee'];
    isEraUser = json['isEraUser'];
    isAllowed = json['isAllowed'];
    status = json['status'];
    privacy = json['privacy'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['memberId'] = this.memberId;
    data['serviceProviderDetailsId'] = this.serviceProviderDetailsId;
    data['doctorName'] = this.doctorName;
    data['degree'] = this.degree;
    data['profilePhotoPath'] = this.profilePhotoPath;
    data['address'] = this.address;
    data['yearOfExperience'] = this.yearOfExperience;
    data['drFee'] = this.drFee;
    data['isEraUser'] = this.isEraUser;
    data['isAllowed'] = this.isAllowed;
    data['status'] = this.status;
    data['privacy'] = this.privacy;
    return data;
  }
}

class PrivacyReportModal {
  int? privacyId;
  String? privacyName;

  PrivacyReportModal({this.privacyId, this.privacyName});

  PrivacyReportModal.fromJson(Map<String, dynamic> json) {
    privacyId = json['privacyId'];
    privacyName = json['privacyName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['privacyId'] = this.privacyId;
    data['privacyName'] = this.privacyName;
    return data;
  }
}

