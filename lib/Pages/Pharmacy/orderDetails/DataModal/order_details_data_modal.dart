





import 'package:digi_doctor/Pages/Pharmacy/OrderDetails/DataModal/price_detail_data_modal.dart';
import 'package:digi_doctor/Pages/Pharmacy/OrderDetails/DataModal/product_details_data_modal.dart';
import 'package:digi_doctor/Pages/Pharmacy/OrderDetails/DataModal/related_products_data_modal.dart';

import 'order_status_data_modal.dart';

class OrderDetailsDataModal{
  List<ProductDetailsDataModal>?productDetails;
  List<RelatedProductDataModal>?relatedProducts;
  List<PriceDetailDataModal>?priceDetails;
  List<OrderStatusDataModal>?orderStatus;


  OrderDetailsDataModal({
    this.productDetails,
    this.relatedProducts,
    this.priceDetails,
    this.orderStatus
});

  factory OrderDetailsDataModal.fromJson(Map<String,dynamic>json)=>
      OrderDetailsDataModal(
        productDetails: json['productDetails']??[],
        relatedProducts: json['relatedProducts']??[],
        priceDetails: json['priceDetails']??[],
        orderStatus: json['orderStatus']??[]
      );
}