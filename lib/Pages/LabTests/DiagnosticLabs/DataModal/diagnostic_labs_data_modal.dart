class DiagnosticLabsDataModal{
  int?pathalogyId;
  String?pathologyName;
  String?address;
  String?contactNo;
  String?workingHrsFrom;
  String?workingHrsTo;
  String?pincode;
  String?latitude;
  String?longitude;
  String?logo;
  String?stateName;
  String?cityName;




  DiagnosticLabsDataModal({
    this.pathalogyId,
    this.pathologyName,
    this.address,
    this.contactNo,
    this.workingHrsFrom,
    this.workingHrsTo,
    this.pincode,
    this.latitude,
    this.longitude,
    this.logo,
    this.stateName,
    this.cityName
});
  factory DiagnosticLabsDataModal.fromJson(Map<String,dynamic>json)=>
      DiagnosticLabsDataModal(
        pathalogyId: json['pathalogyId'],
        pathologyName: json['pathologyName'],
        address: json['address'],
        contactNo: json['contactNo'],
        workingHrsFrom: json['workingHrsFrom'],
        workingHrsTo: json['workingHrsTo'],
        pincode: json['pincode'],
        latitude: json['latitude'],
        longitude: json['longitude'],
        logo: json['logo'],
        stateName: json['stateName'],
        cityName: json['cityName']
      );


}