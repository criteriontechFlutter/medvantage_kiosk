class WishListDataModal{
  int?productId;
  String?productName;
  String?shortDescription;
  double?mrp;
  double?offeredPrice;
  String?productInfoCode;
  String?imageURL;

  WishListDataModal({
    this.productId,
    this.productName,
    this.shortDescription,
   this.mrp,
    this.offeredPrice,
    this.productInfoCode,
    this.imageURL
});
  factory WishListDataModal.fromJson(Map<String,dynamic>json)=>
      WishListDataModal(
        productId: json['productId'],
        productName: json['productName'],
      shortDescription: json['shortDescription'],
      mrp: json["mrp"]??0.0,
      offeredPrice: json['offeredPrice']??0.0,
      productInfoCode: json['productInfoCode']
      ,imageURL: json['imageURL']
      );


}