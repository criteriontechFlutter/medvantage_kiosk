class ApplyCouponsDataModal{
int?id;
String?couponCode;
String?validityFrom;
String?validityTo;
String?description;
double?couponAmount;
double?minShopping;

ApplyCouponsDataModal({
  this.id,
  this.couponCode,
  this.validityFrom,
  this.validityTo,
  this.description,
  this.couponAmount,
  this.minShopping
});
factory ApplyCouponsDataModal.fromJson(Map<String,dynamic>json)=>
ApplyCouponsDataModal(
  id: json['id'],
  couponCode: json['couponCode'],
  validityFrom: json['validityFrom'],
  validityTo: json['validityTo'],
  description: json['description'],
  couponAmount: json['couponAmount'],
  minShopping: json['minShopping']

    );

}
