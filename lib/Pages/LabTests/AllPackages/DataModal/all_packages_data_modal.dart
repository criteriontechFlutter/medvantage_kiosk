class AllPackageDataModal{
  String?packageId;
  String?packageName;
  String?noOfTests;
  double?packagePrice;
  double?discountPerc;
  double?mrp;
  String?type;
  String?cartStatus;


  AllPackageDataModal({
    this.packageId,
    this.packageName,
    this.noOfTests,
    this.packagePrice,
    this.discountPerc,
    this.mrp,
    this.type,
    this.cartStatus
  });

  factory AllPackageDataModal.fromJson(Map<String,dynamic>json)=>
      AllPackageDataModal(
        packageId: json['packageId'],
        packageName: json['packageName'],
        noOfTests: json['noOfTests'],
        packagePrice: double.parse(json['packagePrice'].toString()),
        discountPerc: double.parse(json['discountPerc'].toString()),
        mrp: double.parse(json['mrp'].toString()),
        type: json['type'],
        cartStatus: json['cartStatus'],
      );


}