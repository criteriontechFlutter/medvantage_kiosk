
class AppointmentDetailsDataModal{
  int? appointmentId;
  String? memberName;
  String? visitDate;
  String? visitTime;
  String? msg;
  String? doctorName;
  String? clinicName;
  String? msgTitle;
  String? msgBody;
  String? patientMsgBody;
  String? patientDeviceToken;
  String? deviceToken;
  int? deviceType;
  String? profilePhotoPath;
  int? notificationType;
  int? isMonitoring;
  String? latitude;
  String? longititude;
  String? clinicMobileNo;
  String? address;
  String? degree;
  String? specialityName;
  String? appointmentStatus;
  int? doctorId;
  int? isEraUser;
  int? drFees;
  int? pid;
  AppointmentDetailsDataModal({
    this.appointmentId,
    this.memberName,
    this.visitDate,
    this.visitTime,
    this.msg,
    this.doctorName,
    this.clinicName,
    this.msgTitle,
    this.msgBody,
    this.patientMsgBody,
    this.patientDeviceToken,
    this.deviceToken,
    this.deviceType,
    this.profilePhotoPath,
    this.notificationType,
    this.isMonitoring,
    this.latitude,
    this.longititude,
    this.clinicMobileNo,
    this.address,
    this.degree,
    this.specialityName,
    this.appointmentStatus,
    this.doctorId,
    this.isEraUser,
    this.drFees,
    this.pid,
});

  factory AppointmentDetailsDataModal.fromJson(Map<String, dynamic> json) =>
      AppointmentDetailsDataModal(
  appointmentId: json['appointmentId'],
        memberName: json['memberName'],
  visitDate: json['visitDate'],
  visitTime: json['visitTime'],
  msg: json['msg'],
  doctorName: json['doctorName'],
  clinicName: json['clinicName'],
  msgTitle: json['msgTitle'],
  msgBody: json['msgBody'],
  patientMsgBody: json['patientMsgBody'],
  patientDeviceToken: json['patientDeviceToken'],
  deviceToken: json['deviceToken'],
  deviceType: json['deviceType'],
  profilePhotoPath: json['profilePhotoPath'],
  notificationType: json['notificationType'],
  isMonitoring: json['isMonitoring'],
  latitude: json['latitude'],
  longititude: json['longititude'],
  clinicMobileNo: json['clinicMobileNo'],
  address: json['address'],
  degree: json['degree'],
  specialityName: json['specialityName'],
  appointmentStatus: json['appointmentStatus'],
  doctorId: json['doctorId'],
  isEraUser: json['isEraUser'],
  drFees: json['drFees'],
  pid: json['pid'],
  );
}