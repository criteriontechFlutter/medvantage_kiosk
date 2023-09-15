class PriceDetailDataModal{
  int?totalProducts;
  double?mrp;
  double?finalAmount;
  double?youSave;
  double?subTotal;
  String?paymentMode;
  int?totalQuantity;



  PriceDetailDataModal({
    this.totalProducts,
    this.mrp,
    this.finalAmount,
    this.youSave,
    this.subTotal,
    this.paymentMode,
    this.totalQuantity
});
  factory PriceDetailDataModal.fromJson(Map<String,dynamic>json)=>
      PriceDetailDataModal(
        totalProducts: json['totalProducts'],
        mrp: json['mrp'],
        finalAmount: json['finalAmount'],
        youSave: json['youSave'],
        subTotal: json['subTotal'],
        paymentMode: json['paymentMode'],
        totalQuantity: json['totalQuantity']

      );


}