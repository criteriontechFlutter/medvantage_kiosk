

class AppointmentHistoryDataModal {
  int? id;
  String? uhID;
  int? departmentId;
  String? departmentName;
  int? doctorId;
  String? doctorName;
  int? timeslotsId;
  String? patientName;
  String? mobileNo;
  String? emailID;
  int? age;
  String? address;
  String? registrationDate;
  String? appointmentDate;
  String? fromTime;
  String? toTime;
  String? appointmentStatus;

  AppointmentHistoryDataModal(
      {this.id,
        this.uhID,
        this.departmentId,
        this.departmentName,
        this.doctorId,
        this.doctorName,
        this.timeslotsId,
        this.patientName,
        this.mobileNo,
        this.emailID,
        this.age,
        this.address,
        this.registrationDate,
        this.appointmentDate,
        this.fromTime,
        this.toTime,
        this.appointmentStatus});

  AppointmentHistoryDataModal.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    uhID = json['uhID'];
    departmentId = json['departmentId'];
    departmentName = json['departmentName'];
    doctorId = json['doctorId'];
    doctorName = json['doctorName'];
    timeslotsId = json['timeslotsId'];
    patientName = json['patientName'];
    mobileNo = json['mobileNo'];
    emailID = json['emailID'];
    age = json['age'];
    address = json['address'];
    registrationDate = json['registrationDate'];
    appointmentDate = json['appointmentDate'];
    fromTime = json['fromTime'];
    toTime = json['toTime'];
    appointmentStatus = json['appointmentStatus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['uhID'] = this.uhID;
    data['departmentId'] = this.departmentId;
    data['departmentName'] = this.departmentName;
    data['doctorId'] = this.doctorId;
    data['doctorName'] = this.doctorName;
    data['timeslotsId'] = this.timeslotsId;
    data['patientName'] = this.patientName;
    data['mobileNo'] = this.mobileNo;
    data['emailID'] = this.emailID;
    data['age'] = this.age;
    data['address'] = this.address;
    data['registrationDate'] = this.registrationDate;
    data['appointmentDate'] = this.appointmentDate;
    data['fromTime'] = this.fromTime;
    data['toTime'] = this.toTime;
    data['appointmentStatus'] = this.appointmentStatus;
    return data;
  }
}
