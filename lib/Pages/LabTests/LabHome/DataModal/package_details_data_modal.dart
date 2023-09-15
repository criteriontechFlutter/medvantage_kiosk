class PackageDetailsDataModal{
  String?packageId;
  String?packageName;
  String?description;
  String?noOfTests;
  String?packagePrice;
  String?mrp;
  String?cartStatus;
  List?groupDetails;
  String?discountPerc;
  String?pathologyName;
  String?labAddress;

  PackageDetailsDataModal({
    this.packageId,
    this.packageName,
    this.description,
    this.noOfTests,
    this.packagePrice,
    this.mrp,
    this.cartStatus,
    this.groupDetails,
    this.discountPerc,
    this.pathologyName,
    this.labAddress
});
  factory PackageDetailsDataModal.fromJson(Map<String,dynamic>json)=>
      PackageDetailsDataModal(
        packageId: json['packageId'],
        packageName: json['packageName'],
        description: json['description'],
        noOfTests: json['noOfTests'],
        packagePrice: json['packagePrice'],
        mrp: json['mrp'],
        cartStatus: json['cartStatus'],
        discountPerc: json['discountPerc'],
        pathologyName: json['pathologyName'],
        labAddress: json['labAddress']

      );

}