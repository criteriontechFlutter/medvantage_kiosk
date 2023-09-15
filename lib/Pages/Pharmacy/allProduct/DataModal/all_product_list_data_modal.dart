class ProductDataModal{
  String? productId,productName,shortDescription,mrp,offeredPrice,productInfoCode,inCartStatus,wishlistStatus,imageURL,off;

  ProductDataModal({
    this.productId,
    this.productName,
    this.shortDescription,
    this.mrp,
    this.offeredPrice,
    this.productInfoCode,
    this.inCartStatus,
    this.wishlistStatus,
    this.imageURL,
    this.off,
});


  factory ProductDataModal.fromJson(Map<String,dynamic>json) => ProductDataModal(
    productId: (json['productId']??'').toString(),
    productName: (json['productName']??'').toString(),
    shortDescription: (json['shortDescription']??'').toString(),
    mrp: (json['mrp']??'0.0').toString(),
    offeredPrice: (json['offeredPrice']??'0.0').toString(),
    productInfoCode: (json['productInfoCode']??'').toString(),
    inCartStatus: (json['inCartStatus']??'').toString(),
    wishlistStatus: (json['wishlistStatus']??'').toString(),
    imageURL: (json['imageURL']??'').toString(),
    off:(double.parse((json['mrp']??'0.0').toString())-double.parse((json['offeredPrice']??'0.0').toString())).toString(),
  );


}