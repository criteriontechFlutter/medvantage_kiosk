class RelatedProductDataModal{
  int?id;
  String?productName;
  String?brandName;
  String?expectedDelievery;
  String?orderStatus;
  String?imagePath;
  String?productInfo;
  double?finalAmount;
  String?deliveryDate;

  RelatedProductDataModal({
    this.id,
    this.productName,
    this.brandName,
    this.expectedDelievery,
    this.orderStatus,
    this.imagePath,
    this.productInfo,
    this.finalAmount,
    this.deliveryDate
});
  factory RelatedProductDataModal.fromJson(Map<String,dynamic>json)=>
  RelatedProductDataModal(
      id: json['id'],
    productName: json['productName'],
    brandName: json['brandName'],
    expectedDelievery: json['expectedDelievery'],
    orderStatus: json['orderStatus'],
    imagePath: json['orderStatus'],
    productInfo: json['productInfo'],
    deliveryDate: json['deliveryDate'],
    finalAmount: json['finalAmount']
      );
}