
class ProductDetailsDataModal2{
  String? productName;
  int? quantity;
  double? price;
  double? amount;
  String? brandName;
  int? cartId;
  String? productInfoCode;
  String? productImage;
  bool? btnLoader;

  ProductDetailsDataModal2({
    required this.productName,
    required this.quantity,
    required this.price,
    required this.amount,
    required this.brandName,
    required this.cartId,
    required this.productInfoCode,
    required this.productImage,
    required this.btnLoader
  });
  factory ProductDetailsDataModal2.fromJson(Map<String, dynamic> json) =>
      ProductDetailsDataModal2(
        productName:  json['productName']??''.toString(),
        price: json['price']??'',
        brandName:  json['brandName']??''.toString(),
        cartId:  json['cartId']??'',
        productImage:  json['productImage']??''.toString(),
        productInfoCode:  json['productInfoCode']??''.toString(),
        amount:  json['amount']??0.0,
        quantity:  json['quantity']??0,
        btnLoader: false,
      );
}


class PriceDetailsDataModal{
  int? totalProducts;
  double? totalMrp;
  double? totalAmount;
  double? saveAmount;
  int? delievryCharge;
  double? couponAmount;
  String? couponCode;
  double? finalAmount;
  PriceDetailsDataModal({
    required this.totalProducts,
    required this.totalMrp,
    required this.totalAmount,
    required this.saveAmount,
    required this.delievryCharge,
    required this.couponAmount,
    required this.couponCode,
    required this.finalAmount
  });

  factory PriceDetailsDataModal.fromJson(Map json) =>
      PriceDetailsDataModal(
        totalAmount:  json['totalAmount']??0,
        couponAmount:  json['couponAmount']??0.0,
        couponCode:  json['couponCode']??''.toString(),
        totalMrp:  json['totalMrp']??0.0,
        saveAmount:  json['saveAmount']??0.0,
        delievryCharge:  json['delievryCharge']??0,
        totalProducts:  json['totalProducts']??0,
        finalAmount:  json['finalAmount']??0.0,
      );
}

