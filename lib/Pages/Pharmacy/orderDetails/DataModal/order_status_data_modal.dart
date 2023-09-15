class OrderStatusDataModal{
  String?orderStatus;
  String?orderDate;
  String?shippiingDate;
  String?packingDate;
  String?deliveryDate;
  String?cancelledDate;


  OrderStatusDataModal({
    this.orderStatus,
    this.orderDate,
    this.shippiingDate,
    this.packingDate,
    this.deliveryDate,
    this.cancelledDate,
});
  factory OrderStatusDataModal.fromJson(Map<String,dynamic>json)=>
      OrderStatusDataModal(
        orderStatus: json['orderStatus'],
        orderDate: json['orderDate'],
        shippiingDate: json['shippiingDate'],
        packingDate: json['packingDate'],
        deliveryDate: json['deliveryDate'],
        cancelledDate: json['cancelledDate']
      );
}