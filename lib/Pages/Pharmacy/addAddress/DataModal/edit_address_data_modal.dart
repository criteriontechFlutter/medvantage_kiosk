class EditAddressDataModal{
  String?addressId;
  String?name;
  String?mobileNo;
  String?houseNo;
  String?area;
  String?pincode;
  String?state;
  String?city;
  String?locality;
  bool?isDefault;
  String?addressType;
  bool?isSundayOpen;
  bool?isSaturdayOpen;


  EditAddressDataModal({
    this.addressId,
    this.name,
    this.mobileNo,
    this.houseNo,
    this.area,
    this.pincode,
    this.state,
    this.city,
    this.locality,
    this.isDefault,
    this.addressType,
    this.isSundayOpen,
    this.isSaturdayOpen
});

  factory EditAddressDataModal.fromJson(Map<String,dynamic>json)=>
      EditAddressDataModal(
        addressId: json['addressId'],
        name: json[['name']],
        mobileNo: json['mobileNo'],
        houseNo: json['houseNo'],
        area: json['area'],
        pincode: json['json'],
        state: json['state'],
        city: json['city'],
        locality: json['locality'],
        isDefault: json['isDefault'],
        addressType: json['addressType'],
        isSundayOpen: json['isSundayOpen'],
        isSaturdayOpen: json['isSaturdayOpen']
      );

}