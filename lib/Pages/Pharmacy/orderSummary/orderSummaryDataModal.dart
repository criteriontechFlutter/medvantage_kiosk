
class OrderSummaryDataModal{
  int? addressId;
  int? memberid;
  String? name;
  String? mobileNo;
  String? houseNo;
  String? area;
  String? pincode;
  String? state;
  String? city;
  String? locality;
  bool? isDefault;
  String? addressType;
  bool? isSundayOpen;
  bool? isSaturdayOpen;

  OrderSummaryDataModal({
   required this.addressId,
    required  this.memberid,
    required  this.name,
    required  this.mobileNo,
    required  this.houseNo,
    required  this.area,
    required  this.pincode,
    required  this.state,
    required  this.city,
    required  this.locality,
    required  this.isDefault,
    required  this.addressType,
    required  this.isSundayOpen,
    required  this.isSaturdayOpen,
});


  factory OrderSummaryDataModal.fromJson(Map json) => OrderSummaryDataModal(
      pincode: json['pincode']??''.toString(),
      houseNo:   json['houseNo']??''.toString(),
      isDefault:  json['isDefault']??0,
      name:   json['name']??''.toString(),
      isSundayOpen:  json['isSundayOpen']??0,
      addressType:   json['addressType']??''.toString(),
      memberid:  json['memberid']??0,
      city:   json['city']??''.toString(),
      addressId:  json['addressId']??0,
      area:   json['area']??''.toString(),
      mobileNo:  json['mobileNo']??''.toString(),
      isSaturdayOpen:  json['isSaturdayOpen']??0,
      locality:  json['locality']??''.toString(),
      state:   json['state']??''.toString(),
  );
}