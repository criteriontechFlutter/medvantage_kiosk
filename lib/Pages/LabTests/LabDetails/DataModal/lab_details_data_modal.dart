

class LabDetailsDataModal{
  String?pathologyName;
  String?address;
  String?contactNo;
  String?workingHrsFrom;
  String?workingHrsTo;
  String?pincode;
  String?logo;
  String?description;
   double?totalReview;
  double?averageRating;


  LabDetailsDataModal({
    this.pathologyName,
    this.address,
    this.contactNo,
    this.workingHrsFrom,
    this.workingHrsTo,
    this.pincode,
    this.logo,
    this.description,
   this.totalReview,
    this.averageRating
  }
      );


  factory LabDetailsDataModal.fromJson(Map<String,dynamic>json)=>
  LabDetailsDataModal(
      pathologyName:json['pathologyName'],
    address: json['address'],
    contactNo: json['contactNo'],
    workingHrsFrom: json['workingHrsFrom'],
    workingHrsTo: json['workingHrsTo'],
    pincode: json['pincode'],
    logo: json['logo'],
    description: json['description'],
     totalReview: double.parse(json['totalReview'].toString()),
     averageRating: double.parse(json['averageRating'].toString())

      );



}