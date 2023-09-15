class TopClinicsDataModal{
  int ?id;
  String? name;
  String ?address;
  String ?stateName;
  String ?cityName;
  String ?profilePhotoPath;
  String ?serviceProviderType;

  TopClinicsDataModal({
    this.id,
    this.name,
    this.address,
    this.stateName,
    this.cityName,
    this.profilePhotoPath,
    this.serviceProviderType
  });
  factory TopClinicsDataModal.fromJson(Map<String,dynamic> json)=>
      TopClinicsDataModal(
        id: json['id'],
        name: json['name'],
        address: json['address'],
        stateName: json['stateName'],
        cityName: json['cityName'],
        profilePhotoPath: json['profilePhotoPath'],
        serviceProviderType: json['serviceProviderType'],
      );
}