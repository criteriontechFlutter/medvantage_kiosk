class PopularPackageDataModal{
  int?packageId;
  String?packageName;
  int?noOfTests;
  double?packagePrice;
  double?discountPerc;
  double?mrp;
  String?type;
  String?incartStatus;


  PopularPackageDataModal({
    this.packageId,
    this.packageName,
    this.noOfTests,
    this.packagePrice,
    this.discountPerc,
    this.mrp,
    this.type,
    this.incartStatus
});

  factory PopularPackageDataModal.fromJson(Map<String,dynamic>json)=>
      PopularPackageDataModal(
        packageId: json['packageId'],
        packageName: json['packageName'],
        noOfTests: json['noOfTests'],
        packagePrice: double.parse(json['packagePrice'].toString()),
        discountPerc: double.parse(json['discountPerc'].toString()),
        mrp: double.parse(json['mrp'].toString()),
        type: json['type'],
        incartStatus: json['incartStatus'],
      );


}