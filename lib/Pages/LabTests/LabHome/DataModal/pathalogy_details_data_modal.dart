class PathalogyDetailsDataModal{
  int?pathalogyId;
  String?pathologyName;
  String?address;
  String?contactNo;
  String?logo;

  PathalogyDetailsDataModal({
    this.pathalogyId,
    this.pathologyName,
    this.address,
    this.contactNo,
    this.logo
});
  factory PathalogyDetailsDataModal.fromJson(Map<String,dynamic>json)=>
      PathalogyDetailsDataModal(
        pathalogyId: json['pathalogyId'],
          pathologyName: json['pathologyName'],
        address: json['address'],
        contactNo: json['contactNo'],
        logo: json['logo']
      );
}