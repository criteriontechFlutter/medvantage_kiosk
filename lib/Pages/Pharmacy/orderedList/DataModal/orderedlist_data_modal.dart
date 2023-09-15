class OrderedListDataModal{

  int?orderDetailsId;
  String?productName;
  String?brandName;
  String?color;
  String?orderNo;
  String?expectedDelievery;
  String?imagePath;
  String?orderStatus;
  String?cancelledDate;
  String?deliveryDate;
  String?shippiingDate;
  String?packingDate;
  double?subTotal;
  int?quantity;
  String?address;
  String?customerName;
  String?customerMobile;
  String?productInfoCode;
  String?productInfo;
  double?finalAmount;
  String?orderDate;



  OrderedListDataModal({
    this.orderDetailsId,
    this.productName,
    this.brandName,
    this.color,
    this.orderNo,
    this.expectedDelievery,
    this.imagePath,
    this.orderStatus,
    this.cancelledDate,
    this.deliveryDate,
    this.shippiingDate,
    this.packingDate,
    this.subTotal,
    this.quantity,
    this.address,
    this.customerName,
    this.customerMobile,
    this.productInfoCode,
    this.productInfo,
    this.finalAmount,
    this.orderDate
});
  factory OrderedListDataModal.fromJson(Map<String,dynamic>json)=>
      OrderedListDataModal(
        orderDetailsId: json['orderDetailsId'],
        productName: json['productName'],
        brandName: json['brandName'],
        color: json['color'],
        orderNo: json['orderNo'],
        expectedDelievery: json['expectedDelievery'],
        imagePath: json['imagePath'],
        orderStatus: json['orderStatus'],
        cancelledDate: json['cancelledDate'],
        deliveryDate: json['deliveryDate'],
        shippiingDate: json['shippiingDate'],
        packingDate: json['packingDate'],
        subTotal: json['subTotal']??0,
        quantity: json['quantity'],
        address: json['address'],
        customerName: json['customerName'],
        customerMobile: json['customerMobile'],
        productInfoCode: json['productInfoCode'],
        productInfo: json['productInfo'],
        finalAmount: json['finalAmount']??0,
        orderDate: json['orderDate']
      );


}
