class UsersDataModal {
  int? id;
  String? uhID;
  String? patientName;
  int? genderId;
  String? gender;
  String? mobileNo;
  int? age;
  String? registrationDate;
  String? guardianName;
  String? agetype;

  UsersDataModal(
      {this.id,
        this.uhID,
        this.patientName,
        this.genderId,
        this.gender,
        this.mobileNo,
        this.age,
        this.registrationDate,
        this.guardianName,
        this.agetype});

  UsersDataModal.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    uhID = json['uhID'];
    patientName = json['patientName'];
    genderId = json['genderId'];
    gender = json['gender'];
    mobileNo = json['mobileNo'];
    age = json['age'];
    registrationDate = json['registrationDate'];
    guardianName = json['guardianName'];
    agetype = json['agetype'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['uhID'] = this.uhID;
    data['patientName'] = this.patientName;
    data['genderId'] = this.genderId;
    data['gender'] = this.gender;
    data['mobileNo'] = this.mobileNo;
    data['age'] = this.age;
    data['registrationDate'] = this.registrationDate;
    data['guardianName'] = this.guardianName;
    data['agetype'] = this.agetype;
    return data;
  }
}
