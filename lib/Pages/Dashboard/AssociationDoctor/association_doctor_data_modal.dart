class AssociationDoctorModal {
  int? id;
  int? serviceProviderLoginId;
  int? serviceProviderTypeId;
  String? name;
  String? address;
  String? userMobileNo;
  String? long;
  String? lat;
  int? sourceId;

  AssociationDoctorModal(
      {this.id,
        this.serviceProviderLoginId,
        this.serviceProviderTypeId,
        this.name,
        this.address,
        this.userMobileNo,
        this.long,
        this.lat,
        this.sourceId});

  AssociationDoctorModal.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    serviceProviderLoginId = json['serviceProviderLoginId'];
    serviceProviderTypeId = json['serviceProviderTypeId'];
    name = json['name'];
    address = json['address'];
    userMobileNo = json['userMobileNo'];
    long = json['long'];
    lat = json['lat'];
    sourceId = json['sourceId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['serviceProviderLoginId'] = this.serviceProviderLoginId;
    data['serviceProviderTypeId'] = this.serviceProviderTypeId;
    data['name'] = this.name;
    data['address'] = this.address;
    data['userMobileNo'] = this.userMobileNo;
    data['long'] = this.long;
    data['lat'] = this.lat;
    data['sourceId'] = this.sourceId;
    return data;
  }
}
