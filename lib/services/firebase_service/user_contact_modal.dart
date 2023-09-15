


class UserContactModal {
  int? userId;
  String? name;
  String? userLoginID;
  String? uName;
  String? mobileNo;
  String? imageUrl;
  String? deviceToken;

  UserContactModal(
      {
        this.userId,
        this.name,
        this.userLoginID,
        this.uName,
        this.mobileNo,
        this.imageUrl,
        this.deviceToken,
      });

  factory UserContactModal.fromJson(Map<String, dynamic> json) => UserContactModal(
    userId: json['userId'] as int,
    name: json['name'].toString(),
    userLoginID: json['userLoginID'].toString(),
    uName: json['uName'].toString(),
    mobileNo: json['mobileNo'].toString(),
    imageUrl: json['imageUrl'].toString(),
    deviceToken: json['deviceToken'].toString(),
  );


}